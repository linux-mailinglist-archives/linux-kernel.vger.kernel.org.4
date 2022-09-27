Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2625ECDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiI0UIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiI0UHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F331EB18D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664309174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAY2Zic/UhuXA0wiNZF7u3ZPpnlczOTVslT3ViiwH1w=;
        b=Qx3gxsJcqtYAmX1jEcR7mi7BAgEtcynBXRpda73X3LbFxzYe5gMRLOcXP0dTth9rHZnAHn
        szhaCqTr13hLI0bty9i5AOMUVsy43d9QkkHuZsDNqtksOOUaXNW9yM57WKCJBp2pgniujD
        fPEz5tI+pa5mksb6T8i+9IvBT54HRFE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-2KqwgImIMMGMm6o5jilwBg-1; Tue, 27 Sep 2022 16:06:13 -0400
X-MC-Unique: 2KqwgImIMMGMm6o5jilwBg-1
Received: by mail-il1-f198.google.com with SMTP id r12-20020a92cd8c000000b002f32d0d9fceso8361277ilb.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OAY2Zic/UhuXA0wiNZF7u3ZPpnlczOTVslT3ViiwH1w=;
        b=NTD6WO3c1DzwAwwGIRHUqeOI/tUwPRIpYMnsxW7XKaCynGLagIhL4TBh2AfnRD2h0H
         qScm/yShjV+FCxHkGN7EZazPStviHfrkOMcr6TTqOM3xdZ82w88BziNVCm2nncibpvQ9
         UveSv6o1ECuGojq6hDqqrUmrL2GrKSkOrQmJGaKAo4+9dGUJOdW2A9covKPwznUh4pE+
         kr0LpqcnSAfr7oLX4Qzeg8YFLaAD2A41t+9hq5BbU99CMXauFo9kEprP3K4JPwndv6KA
         tR4YqkdqNgua8BUa6CAwVsJqsEaxYeAinJHCtwrF1BlsIet0Rao3MVQWGWIEod1ptBNp
         fCfg==
X-Gm-Message-State: ACrzQf1ECHka0OU2/yyy4OQXKHMs65Rr2cf6bkSekJ41NsC5uE+dkdWT
        az+luvk9PVuQy+rwOFwbojKttCpQ57i+TNoSj5KHwFZsFEJ2aM95h9v7FVpeLj60iPk2R/FNHgP
        f1aUUlyu6w5tZZcU95VNpN9E1
X-Received: by 2002:a05:6638:3054:b0:35b:6eb3:8537 with SMTP id u20-20020a056638305400b0035b6eb38537mr5443503jak.17.1664309170893;
        Tue, 27 Sep 2022 13:06:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6OyV3H4MMkZFWplgbmP9BJGkd5c3LnPni/NOmQSqSmvQ425SbKltrtDKKgVtKpowATOAmfZQ==
X-Received: by 2002:a05:6638:3054:b0:35b:6eb3:8537 with SMTP id u20-20020a056638305400b0035b6eb38537mr5443494jak.17.1664309170671;
        Tue, 27 Sep 2022 13:06:10 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b15-20020a92dccf000000b002f1d7850037sm619885ilr.44.2022.09.27.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:06:10 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:06:07 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: Re: [PATCH v3 0/5] Fix some bugs and clean code issues
Message-ID: <20220927140607.06dc9018.alex.williamson@redhat.com>
In-Reply-To: <20220926093332.28824-1-liulongfang@huawei.com>
References: <20220926093332.28824-1-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 17:33:27 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> Modify two code bugs inside the driver, update the format of the
> driver's log and comments, and delete an unused macro definition.
> 
> Changes in v3:
> - Remake patchset based on vfio/next branch.
> - Add new reviewer.
> 
> Changes in v2:
> - Remove a wrong patch.
> - Remove some unnecessary changes.
> 
> Longfang Liu (5):
>   hisi_acc_vfio_pci: Fixes error return code issue
>   hisi_acc_vfio_pci: Fix device data address combination problem
>   hisi_acc_vfio_pci: Remove useless function parameter
>   hisi_acc_vfio_pci: Remove useless macro definitions
>   hisi_acc_vfio_pci: Update some log and comment formats
> 
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 36 ++++++++++---------
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  7 ++--
>  2 files changed, 22 insertions(+), 21 deletions(-)
> 

Applied to vfio next branch for v6.1.  Thanks,

Alex

