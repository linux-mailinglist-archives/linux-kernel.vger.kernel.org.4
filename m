Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABD36A7CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCBIeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCBIeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:34:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA1A1115D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677746012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2wWYhw4IbCn2jiud1m9fHjCN/hg14p3hY5/TY/f9/s=;
        b=Tf6ohF9CG3a+C4sNFmNM2VEt0R0jiZDvaD0P05eA4ZLEP4OVgxRjy/KxplWWyOZS2Os+W2
        6zW3mPmQsT+VZur2N613FodydYSxQHUH0uhbZQPq//Q/oCLopj/FHaevZWyOUuVVPRskXh
        yA+5UgLVD6kDeOvd5FD0ZuXk0/Aq9t8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-MGPiK5isNQSgUAYiHJE0bA-1; Thu, 02 Mar 2023 03:33:28 -0500
X-MC-Unique: MGPiK5isNQSgUAYiHJE0bA-1
Received: by mail-qk1-f197.google.com with SMTP id 8-20020a370508000000b00724fd33cb3eso9632970qkf.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677746008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2wWYhw4IbCn2jiud1m9fHjCN/hg14p3hY5/TY/f9/s=;
        b=zxVGXix0IubZIZ+py2e9vp2OnA7YdwURhVGs1A6S2cfpbj9C9hVvJhaZhGaH56fJBN
         v8ee8/aM9mDmDe6TJHjdPUo5ZWd8Us7ObobsGFMYWpe117FFGAKgKE6/P8ntlnTaYbjM
         6F320/AqNhy1UY8NDOJbLS8AOnjcbrJ/WmGofHyi+lODSNNkci6NL3MC/FPHFMfwHWih
         AMFUyLGKpqCTmdPNXUX3Nw8jPZLWfKkDjftj1P/4WxdPSVxluBfjlkhJqcIchoV3kod/
         4ifYiVkfRxNr+h9bwQ62GEGXJbaIWSmLT6UCXRLsTTyC3t662SaoebnV/uJd1RMZ5JgQ
         X49g==
X-Gm-Message-State: AO0yUKUesGEpOr5D+hzpD0kKabDlJit8quJxthSIGjQcZMlt8YN2Jh5S
        aG9ExP7ORoyK1ilNMxFuquiT/g0Su6qvj+kMkMFgKd7dvJKwz1e7yH54PaG/U+q3Y7SYAWRUjC+
        yWJbtCiXpNuTayKHwG57UKsdR
X-Received: by 2002:a05:6214:19c6:b0:56e:b5a0:29eb with SMTP id j6-20020a05621419c600b0056eb5a029ebmr17272849qvc.40.1677746007951;
        Thu, 02 Mar 2023 00:33:27 -0800 (PST)
X-Google-Smtp-Source: AK7set99YYiQIT3q7u8Fs8YEPbCbxaT865af9SQwhTIhLrsPHZ5cKOxrj+xqsWWZYUHwSbbTr5OKZw==
X-Received: by 2002:a05:6214:19c6:b0:56e:b5a0:29eb with SMTP id j6-20020a05621419c600b0056eb5a029ebmr17272835qvc.40.1677746007699;
        Thu, 02 Mar 2023 00:33:27 -0800 (PST)
Received: from sgarzare-redhat ([212.43.115.213])
        by smtp.gmail.com with ESMTPSA id d187-20020ae9efc4000000b007428e743508sm9907618qkg.70.2023.03.02.00.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 00:33:27 -0800 (PST)
Date:   Thu, 2 Mar 2023 09:33:14 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Gautam Dawar <gautam.dawar@amd.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
        harpreet.anand@amd.com, tanuj.kamde@amd.com
Subject: Re: [PATCH] vhost-vdpa: free iommu domain after last use during
 cleanup
Message-ID: <20230302083314.xj2wlzkarvsmofd6@sgarzare-redhat>
References: <20230301163203.29883-1-gautam.dawar@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230301163203.29883-1-gautam.dawar@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 10:02:01PM +0530, Gautam Dawar wrote:
>Currently vhost_vdpa_cleanup() unmaps the DMA mappings by calling
>`iommu_unmap(v->domain, map->start, map->size);`
>from vhost_vdpa_general_unmap() when the parent vDPA driver doesn't
>provide DMA config operations.
>
>However, the IOMMU domain referred to by `v->domain` is freed in
>vhost_vdpa_free_domain() before vhost_vdpa_cleanup() in
>vhost_vdpa_release() which results in NULL pointer de-reference.
>Accordingly, moving the call to vhost_vdpa_free_domain() in
>vhost_vdpa_cleanup() would makes sense. This will also help
>detaching the dma device in error handling of vhost_vdpa_alloc_domain().

Yep, good cleanup!

>
>This issue was observed on terminating QEMU with SIGQUIT.
>
>Fixes: 037d4305569a ("vhost-vdpa: call vhost_vdpa_cleanup during the release")
>Signed-off-by: Gautam Dawar <gautam.dawar@amd.com>
>---
> drivers/vhost/vdpa.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

