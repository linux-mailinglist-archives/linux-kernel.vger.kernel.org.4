Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F786B55CB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjCJXlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjCJXlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0014ACEE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678491631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbyezWLgJaDXuWA7503EtzDYr33RVbeOKfFddnGwXlI=;
        b=QThYvzdEBcJihWbY7Frd6vKzSNpfIvLuYhmQA2ER2R9gjp7YF29orcLYd+12BbXd++5oUr
        JogRnFkzdYDeEUfK/xkpaYyHxa1PDcJZJrHYFrq6ZtDJreKgZ3ws3raSyjzDRQhdVfinoL
        hZdslcU2JMcm42OAAZ03a5P2X4RV6fk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-j-8q5xoLMKST6GAqx02toQ-1; Fri, 10 Mar 2023 18:40:29 -0500
X-MC-Unique: j-8q5xoLMKST6GAqx02toQ-1
Received: by mail-il1-f198.google.com with SMTP id d6-20020a92d786000000b00316f1737173so3514400iln.16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678491629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbyezWLgJaDXuWA7503EtzDYr33RVbeOKfFddnGwXlI=;
        b=KsqZBpx1U9fcvGb/OmfjZjnjPnbXewFyTq6kVV+Ng8A+jiQbqlHAEMm6HYHatj9egD
         QJ1nkaJKZ9oB8/0f+wSv6/jaJkHFJf1gDElWf5+xOuDfxLdTlnCkIdvXk/u81zxxxzGz
         WSJS0ziuuXGq6FI5Dhwhd1VKp5PHTlLCS4XIJwR1I94WHGPxhl1+O99QOMQmQH0KhelZ
         lEZVeQLj8QT5aL2SDtA9vtJeQLFXlCik3UK7urFbSZeFEFE19KcDkOuHY0Ekq8JmHKJ6
         bozWMi9TElm9zkJy2iH3TwzAAQwRpfzjEHvilRc6dp8T7LkLYmqD8M2BHPLjpyd8Cgwi
         Q3yQ==
X-Gm-Message-State: AO0yUKVADaLEul2bVsFWL0hPiBt4ko4N9xn4A3OuOBQk3yEDB0zC7UaD
        /i4STdxgxiWBbKvyePuX02bWg8vKM51DNL/BSrHD/xlrb8ZcUnotHXI+AjUtUTl7m81ZnTw9THO
        8k3dZp+kf/IUvhNlHn2MqDDNu
X-Received: by 2002:a05:6e02:174b:b0:317:9945:605a with SMTP id y11-20020a056e02174b00b003179945605amr25170350ill.12.1678491628971;
        Fri, 10 Mar 2023 15:40:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/g8l8yaAK5Wy4YJ3nX/K3TMTsExjr4jhUudGVUnJ4WWzoZxwhCJoDnEZA0trMQv/t9UyFMEg==
X-Received: by 2002:a05:6e02:174b:b0:317:9945:605a with SMTP id y11-20020a056e02174b00b003179945605amr25170337ill.12.1678491628694;
        Fri, 10 Mar 2023 15:40:28 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x16-20020a029710000000b003bf39936d1esm371961jai.131.2023.03.10.15.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 15:40:27 -0800 (PST)
Date:   Fri, 10 Mar 2023 16:39:57 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v8 4/5] Documentation: add debugfs description for vfio
Message-ID: <20230310163957.60e9bc36.alex.williamson@redhat.com>
In-Reply-To: <20230217084831.35783-5-liulongfang@huawei.com>
References: <20230217084831.35783-1-liulongfang@huawei.com>
        <20230217084831.35783-5-liulongfang@huawei.com>
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

On Fri, 17 Feb 2023 16:48:30 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> Add two debugfs document description file to help users understand
> how to use the accelerator live migration driver's debugfs.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../ABI/testing/debugfs-hisi-migration        | 28 +++++++++++++++++++
>  Documentation/ABI/testing/debugfs-vfio        | 17 +++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
> 
> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
> new file mode 100644
> index 000000000000..0f45f30ff6d4
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
> @@ -0,0 +1,28 @@
> +What:		/sys/kernel/debug/vfio/<bdf>/migration_data

s/bdf/name/ throughout.

> +Date:		Feb 2023
> +KernelVersion:  6.2
> +Contact:	linux-kernel@vger.kernel.org

Is there not someone at Huawei willing to be the contact point for the
hisi_acc specific attributes?

> +Description:	Read the live migration data of the vfio device.
> +		The output format of the data is defined by the live
> +		migration driver.
> +
> +What:		/sys/kernel/debug/vfio/<bdf>/migration_attr
> +Date:		Feb 2023
> +KernelVersion:  6.2
> +Contact:	linux-kernel@vger.kernel.org
> +Description:	Read the live migration attributes of the vfio device.
> +		The output format of the attributes is defined by the live
> +		migration driver.
> +
> +What:		/sys/kernel/debug/vfio/<bdf>/migration_debug
> +Date:		Feb 2023
> +KernelVersion:  6.2
> +Contact:	linux-kernel@vger.kernel.org
> +Description:	This debug file supports "echo" command	write operations.
> +		The command is actually represented by an integer number, and the
> +		specific meaning is defined by the corresponding device driver.
> +		For example, three commands are defined in the HiSilicon accelerator
> +		live migration driver:
> +		0: State save
> +		1: State resume
> +		2: IO test
> diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
> new file mode 100644
> index 000000000000..e22531d16674
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-vfio
> @@ -0,0 +1,17 @@
> +What:		/sys/kernel/debug/vfio
> +Date:		Feb 2023
> +KernelVersion:  6.2
> +Contact:	linux-kernel@vger.kernel.org

These should likely at least be the kvm list as the official list of
vfio if you're not interested in being the contact point.

Thanks,
Alex

> +Description:	This debugfs file directory is used for debugging
> +		of vfio devices that support live migration.
> +		Each device that supports live migration can create a device
> +		subdirectory under this directory by referencing the public
> +		registration interface.
> +
> +What:		/sys/kernel/debug/vfio/<bdf>/migration_state
> +Date:		Feb 2023
> +KernelVersion:  6.2
> +Contact:	linux-kernel@vger.kernel.org
> +Description:	Read the live migration status of the vfio device.
> +		The status of these live migrations includes:
> +		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.

