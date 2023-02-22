Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6305169FAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjBVSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F5838B6D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677088787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWyApdiQGDHbUGKS9+Y31lH4Jek/qAyUXTgCGlvrld4=;
        b=f3Q5wN+jxE8cea+AHSPDgb07n1LeccReqDghmsN+lqv3aR1Z1fxWA+XorLm+rtle5Rbx0K
        gWfAwkBVJ3qcmVXG4MNDj1mFjz/o40lStk8haopUkY/T0DljmvKKZxt9J0aaBwmFH1AoRR
        WqutI3rMPLD8EJDN/voQooNc5+28hV4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-0aMYqjTTNHGbEdOxignJdA-1; Wed, 22 Feb 2023 12:59:45 -0500
X-MC-Unique: 0aMYqjTTNHGbEdOxignJdA-1
Received: by mail-io1-f72.google.com with SMTP id z6-20020a056602080600b007407df88db0so4804499iow.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWyApdiQGDHbUGKS9+Y31lH4Jek/qAyUXTgCGlvrld4=;
        b=gVsaSDYuVxWSbEyFmOLO/AMM5Al5KQONRszHf2jo5kiRlTmKrQurl1Py6NP+v2hZwH
         iVH/UOk6pqfW7/kFd31XQbTy2+r1o88M2Lix3ezkUqdFsqVrtaR4F8MOARg1L5OXkKqo
         n52DAyXL6ipKLcYWXm/l2RbNOD/Yak1xuoGXSeKj09HKzvTCjnLYxa6KfCrCfzLUnfIJ
         srHRyKlbqc3oa+EXM+1uixMEjFh5dynQIGzvESvLOfdSBUB+9K7TTadpfHzEU1ZgwA0S
         7mmhMohfXy7DoYXHq3hJYGyPJWgv9BFoKLVJeJ3WA1fX4uJ9R3T5MFB/uGYFQFUS26o/
         FKHg==
X-Gm-Message-State: AO0yUKW0T55JncNL8/KnkF7ZZFKzfu34Ql0mFaNFbik2a9mxDdvnRhXt
        MygD7SqX3PlMzoqBXLZmRxN/pNhZHZvVS272dGGBqfJVmjVQqp7Za2Cs8R2w8IwrSqTlI89soL0
        0zEx1pkxnGJFk1+9NOg28xbGq
X-Received: by 2002:a05:6e02:1d99:b0:315:7004:3e69 with SMTP id h25-20020a056e021d9900b0031570043e69mr7546078ila.13.1677088785209;
        Wed, 22 Feb 2023 09:59:45 -0800 (PST)
X-Google-Smtp-Source: AK7set9r6tRu/CNtnXOiqXnQw+dpxBgVCCJ4i5wUmXP6rZKqJ2tGI7YJQa71XArwlBX37VPRQgaYlQ==
X-Received: by 2002:a05:6e02:1d99:b0:315:7004:3e69 with SMTP id h25-20020a056e021d9900b0031570043e69mr7546058ila.13.1677088784970;
        Wed, 22 Feb 2023 09:59:44 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m5-20020a924b05000000b00316ecc80a61sm622829ilg.11.2023.02.22.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:59:44 -0800 (PST)
Date:   Wed, 22 Feb 2023 10:59:42 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     jgg@nvidia.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: Fix NULL pointer dereference caused by
 uninitialized group->iommufd
Message-ID: <20230222105942.27ead3de.alex.williamson@redhat.com>
In-Reply-To: <20230222074938.13681-1-yan.y.zhao@intel.com>
References: <20230222074938.13681-1-yan.y.zhao@intel.com>
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

On Wed, 22 Feb 2023 15:49:38 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> group->iommufd is not initialized for the iommufd_ctx_put()
> 
> [20018.331541] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [20018.377508] RIP: 0010:iommufd_ctx_put+0x5/0x10 [iommufd]
> ...
> [20018.476483] Call Trace:
> [20018.479214]  <TASK>
> [20018.481555]  vfio_group_fops_unl_ioctl+0x506/0x690 [vfio]
> [20018.487586]  __x64_sys_ioctl+0x6a/0xb0
> [20018.491773]  ? trace_hardirqs_on+0xc5/0xe0
> [20018.496347]  do_syscall_64+0x67/0x90
> [20018.500340]  entry_SYSCALL_64_after_hwframe+0x4b/0xb5
> 
> Fixes: 9eefba8002c2 ("vfio: Move vfio group specific code into group.c")
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  drivers/vfio/group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 57ebe5e1a7e6..8649f85f3be4 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -137,7 +137,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
>  
>  		ret = iommufd_vfio_compat_ioas_id(iommufd, &ioas_id);
>  		if (ret) {
> -			iommufd_ctx_put(group->iommufd);
> +			iommufd_ctx_put(iommufd);
>  			goto out_unlock;
>  		}
>  

Applied to vfio next branch for v6.3 and added a stable cc.  Thanks,

Alex

