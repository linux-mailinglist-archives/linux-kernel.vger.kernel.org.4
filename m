Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80D6B0ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCHOSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCHOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C4C86A9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678285065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttecRVaLcokGkQnpMMD3LNLXwWSTcMNNpaM+wYM2sIQ=;
        b=dRTC7jlg5DOkEnz949HNl0CPFLiMWrjMn54DEohZBjUvVikaAEx465EIHyTpE8TF2fNH8r
        KBfJIIfLN4RDMNUJSgp4RfDxIiWwxgQaCSTKF53od3rU3shTKqrGau1vvxvlpDSnwUXUxQ
        qW6BOVlJgl8ExZmeXaJWPmPiUKd+aP8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-GbnWo0TiP5S3kGmuyS5B0g-1; Wed, 08 Mar 2023 09:17:43 -0500
X-MC-Unique: GbnWo0TiP5S3kGmuyS5B0g-1
Received: by mail-qt1-f197.google.com with SMTP id z22-20020ac86b96000000b003bfc3f97097so9155867qts.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttecRVaLcokGkQnpMMD3LNLXwWSTcMNNpaM+wYM2sIQ=;
        b=bIXgEVGVzYtwAsWLLr7nqlfWRKwae4EZ3zCtxPGt9b6suJvqQxdJkKlg2SqclEaqt8
         QFy+/Fc4gqEGbpnWViQ2mYUQDLehWPgvToY4yigqlRTQ0SGU0ZeAa6oQgWjLZQfL/P/P
         fL3XhZI6m6ZdjTqMWLy3j/Iw+g5w4I7lNmZTFJ2THwof6zTeBfe9q8yYojxk7e/SOjpF
         5Dx1AWnjxrf4QKZ6IkbjrySNFEOhZf8NF/GOlD3f2Gurf1rtmefufIJ0/tw3xDP7hz37
         c6+WXWkS0QgzqLOT3ncw0sOL3t0xZ1SdFNT2FZcrA1J4d/94BoZ4sPVCWglsanshFL7p
         Fi5g==
X-Gm-Message-State: AO0yUKVZGbe9B48KOXEqh/vDTGJg2/gHixpTal5509feXMsz3WZqdLgK
        poY/Gza3xacZytuVrypiwvr0BoyB+pOsU/VQBC14XY8Qf0AYTXun3iS8kYYkgq/0OrdfIIUoKdR
        nQHis01qIGNStfsfNSNPUWKgN
X-Received: by 2002:ac8:5f4f:0:b0:3bb:8a14:badd with SMTP id y15-20020ac85f4f000000b003bb8a14baddmr32533621qta.29.1678285062639;
        Wed, 08 Mar 2023 06:17:42 -0800 (PST)
X-Google-Smtp-Source: AK7set9vFABDqE96MkgXNbZHat3oPZ5tvsXBqvU9/f0sBWiq54XK/Fphhn5yZSGJuDf8rbsfS4nA+g==
X-Received: by 2002:ac8:5f4f:0:b0:3bb:8a14:badd with SMTP id y15-20020ac85f4f000000b003bb8a14baddmr32533583qta.29.1678285062353;
        Wed, 08 Mar 2023 06:17:42 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id a18-20020ac84352000000b003bfaff2a6b9sm11697660qtn.10.2023.03.08.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:17:41 -0800 (PST)
Date:   Wed, 8 Mar 2023 15:17:37 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     mst@redhat.com, Rong Tao <rongtao@cestc.cn>,
        Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: virtio_test -h,--help should return
 directly
Message-ID: <20230308141737.ioxvifnarhluafmh@sgarzare-redhat>
References: <tencent_A95EA946D511450DBE8486B2122FA1549609@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_A95EA946D511450DBE8486B2122FA1549609@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:30:30PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>When we get help information, we should return directly, and we should not
>execute test cases. At the same time, the code indentation issue was fixed
>and virtio-trace/trace-agent was added to .gitignore.

Thanks for this cleanup, but you mentioned 3 independent things that
this patch does, so it would be better to split it into 3 separate
patches.

>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
> tools/virtio/.gitignore    | 1 +
> tools/virtio/virtio_test.c | 6 +++---
> 2 files changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
>index 075588c4da08..9934d48d9a55 100644
>--- a/tools/virtio/.gitignore
>+++ b/tools/virtio/.gitignore
>@@ -2,3 +2,4 @@
> *.d
> virtio_test
> vringh_test
>+virtio-trace/trace-agent
>diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>index 120062f94590..6370cdada396 100644
>--- a/tools/virtio/virtio_test.c
>+++ b/tools/virtio/virtio_test.c
>@@ -134,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> 	dev->buf_size = 1024;
> 	dev->buf = malloc(dev->buf_size);
> 	assert(dev->buf);
>-        dev->control = open("/dev/vhost-test", O_RDWR);
>+	dev->control = open("/dev/vhost-test", O_RDWR);
> 	assert(dev->control >= 0);
> 	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
> 	assert(r >= 0);
>@@ -142,7 +142,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> 			  sizeof dev->mem->regions[0]);
> 	assert(dev->mem);
> 	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
>-                          sizeof dev->mem->regions[0]);
>+			sizeof dev->mem->regions[0]);

This did not seem to me to be an indentation issue, there are 2 tabs and
1 space to line it up with the opening of the parenthesis of the line
above.

> 	dev->mem->nregions = 1;
> 	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
> 	dev->mem->regions[0].userspace_addr = (long)dev->buf;
>@@ -361,7 +361,7 @@ int main(int argc, char **argv)
> 			break;
> 		case 'h':
> 			help();
>-			goto done;
>+			exit(0);

Maybe we can move the exit() directly into the help() function and 
remove it from case '?'.

I would return a value different from 0 (like in the case '?').

Thanks,
Stefano

> 		case 'i':
> 			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
> 			break;
>-- 
>2.39.2
>

