Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83D667D55B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjAZT3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjAZT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0435A355
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674761300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhJB0OteAHLqy+cPXd9aMet1vNNRAA89ktvZLkF0kak=;
        b=EBHzzoW8qpMCyDap6BXP2oJCV5+bvFlOx5c5RWbrP77A1A+Omu+TVfndEQ+V12kv9GETZ6
        AP3xESHIIDwzHr57h0Uf0htt2rw3JapicgzY/zm+fvNvUALx6zzxLJXm0IJTB8oDdk3Zk5
        X7mMv08bbwSy7oCn704ZwWvZFXZcdhU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-221-cDMVfwOGN1SHow9HxLVJmg-1; Thu, 26 Jan 2023 14:28:19 -0500
X-MC-Unique: cDMVfwOGN1SHow9HxLVJmg-1
Received: by mail-io1-f70.google.com with SMTP id k5-20020a6bf705000000b0070483a64c60so1504335iog.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhJB0OteAHLqy+cPXd9aMet1vNNRAA89ktvZLkF0kak=;
        b=qTeueGK76G83VrxuLSNbIib52J7HbeUIHd1Jq9MQ72rRztmRkjzioKi3KPfZjQIh3Z
         arAWaDfJVbemRuerkFtgauoVhbVfjfF2kSp21yGf3HRQ2YG759YMkoXxQAXVaBHBB2rw
         gmPzh+DSsFMka8+uG5Ueedr++PgfU3wo8Z5MPQIl4/RD579eiXiQwM3HCfzOHwsVShJ8
         FTDwXjuutbIJUym4IjFxJhj/jbTVEbyklgTDFzy2dgjAwyntaJTEEdT2u2Fuu2gNrl4l
         7n0HSTPOBpJOqaabVGZyESERvaRqNzKu42TOzgL5eN+UA3KmLUuO3ppw8h4a4gpCM8fh
         H7XQ==
X-Gm-Message-State: AFqh2kroH4B2hHm/WTTyOc7GtHXon9lSHxnGFI9CsGWp6qbEb80VaR7d
        LZaknUAx0F2DVY+NL4AVih98HPtJg7KtVdyrSRZgJNzIeINWaZcpHGfrkGx7v65dDYq14XjVOhD
        vzzhBDMGUr0jtSekpaMG+BK/1
X-Received: by 2002:a5d:9158:0:b0:707:e4ef:deb0 with SMTP id y24-20020a5d9158000000b00707e4efdeb0mr7904717ioq.16.1674761298596;
        Thu, 26 Jan 2023 11:28:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvyiQeyUdq5bJopVD2VzTLhBHZ++igkJPuP+oItdQr0exQz1QbNJJEZq81QVbfEey97hSlbhg==
X-Received: by 2002:a5d:9158:0:b0:707:e4ef:deb0 with SMTP id y24-20020a5d9158000000b00707e4efdeb0mr7904708ioq.16.1674761298395;
        Thu, 26 Jan 2023 11:28:18 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k9-20020a02ccc9000000b003a961e5d33fsm596210jaq.49.2023.01.26.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:28:17 -0800 (PST)
Date:   Thu, 26 Jan 2023 12:28:05 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v7 4/5] Documentation: add debugfs description for
 hisi_acc_vfio_pci
Message-ID: <20230126122805.1e17d08b.alex.williamson@redhat.com>
In-Reply-To: <20230120032930.43608-5-liulongfang@huawei.com>
References: <20230120032930.43608-1-liulongfang@huawei.com>
        <20230120032930.43608-5-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 11:29:29 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> Add a debugfs document description file to help users understand
> how to use the accelerator live migration driver's debugfs.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../ABI/testing/debugfs-hisi-migration        | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
> 
> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
> new file mode 100644
> index 000000000000..d644a497c464
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
> @@ -0,0 +1,32 @@
> +What:		/sys/kernel/debug/vfio_mig/<bdf>/state
> +Date:		Jan 2023
> +Contact:	linux-kernel@vger.kernel.org
> +Description:	Read the live migration status of the VF device.
> +		The status of these live migrations includes:
> +		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.

state is added by vfio-pci-core in this series, so the documentation
can't be limited to hisi_acc.

> +
> +What:		/sys/kernel/debug/vfio_mig/<bdf>/mig_data
> +Date:		Jan 2023
> +Contact:	linux-kernel@vger.kernel.org
> +Description:	Read the live migration data of the VF device.
> +		The output format of the data is defined by the live
> +		migration driver.
> +
> +What:		/sys/kernel/debug/vfio_mig/<bdf>/mig_attr
> +Date:		Jan 2023
> +Contact:	linux-kernel@vger.kernel.org
> +Description:	Read the live migration attributes of the VF device.
> +		The output format of the attributes is defined by the live
> +		migration driver.
> +
> +What:		/sys/kernel/debug/vfio_mig/<bdf>/debug
> +Date:		Jan 2023
> +Contact:	linux-kernel@vger.kernel.org
> +Description:	This debug file supports "echo" command	write operations.
> +		The command is actually represented by an integer number, and the
> +		specific meaning is defined by the corresponding device driver.
> +		For example, three commands are defined in the HiSilicon accelerator
> +		live migration driver:
> +		0: State save
> +		1: State resume
> +		2: IO test

I think the goal here is to create some sort of standard interface for
migration, so these should also be documented for all devices, and any
device specific behavior noted.  Otherwise these should all be prefixed
hisi_acc_ to denote them as device specific implementations.  Thanks,

Alex

