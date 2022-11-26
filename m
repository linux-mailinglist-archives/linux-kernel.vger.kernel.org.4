Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FDC6398E9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKZXXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZXXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B91837E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669504936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bcuOqDLUG//aDYIiQVtJ0uGG3AUcLGhed3fAsyj+39Y=;
        b=LbyS53vCkThTTBBSuaMEPWzoiADcNwOAnJBViF98GaTnBhjh6YiKWh1HQdO84F8UTKFXA/
        psRAz41gT35tfj7vuIpoWogbr5HJnJri2IayGDoNjao0g2EOKIw25UZiY+PsGNZ2bTE25i
        nUT1VHb1Bw34JeOvojOUmT/5V30jqWA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-djaXyEqKNOawHA_rtgL4VQ-1; Sat, 26 Nov 2022 18:22:15 -0500
X-MC-Unique: djaXyEqKNOawHA_rtgL4VQ-1
Received: by mail-wm1-f70.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso6325476wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcuOqDLUG//aDYIiQVtJ0uGG3AUcLGhed3fAsyj+39Y=;
        b=zLeKFZOaln5F5cmGZKtjZ6Qu2e51MOPYTj2d5mGvKJseArj5ejjk0LtHqCBLqpPyz8
         WBnS3xrL2iInu2p/rULFX7o0v7ZCRx//eBYY4Idff/+8kfOD7rPtqHaxirERe4VbAup7
         RkSWT8n00lSHJGxhH0TbMtNU3mVKjw60khVqXOtoWANqdyEico14AZQjg7baSNfk7Mij
         qFfAWjx76rOYkRmVzc1KgPkxGt/NNPn5NWXSPX5+3cRRGWGd0WuxEZy8dpWCf2SB8Bql
         XCvqjZFTE8p8hRmvUCbqoVu+/aq7hb8P3sXp+A8GFUCc21zln2Zg7aJ6NSey5+up0h6m
         fWFA==
X-Gm-Message-State: ANoB5pnytVHuPPmS8qdnVXdCA6V6qFI9vU/UlZgwQcZdBIiBClpqt0D8
        ljp85a4gJijeZXOtF9kL/T+lIG2CoXtvbxnvfLGuKjYH7wLC+1tUfoN0B6NMGUswRJb/vIpFQPA
        yP3Ym2NFY5JwOiYE517C9Lgqg
X-Received: by 2002:adf:e7c7:0:b0:241:ca33:a188 with SMTP id e7-20020adfe7c7000000b00241ca33a188mr17403395wrn.559.1669504934271;
        Sat, 26 Nov 2022 15:22:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6AGVUQP9IX9nrjgocQ9WJdTNyBicSL0dD2H1r/aRWNPERU9L8fNUx9OHN+C8Tdl1ndMAYlCg==
X-Received: by 2002:adf:e7c7:0:b0:241:ca33:a188 with SMTP id e7-20020adfe7c7000000b00241ca33a188mr17403389wrn.559.1669504934050;
        Sat, 26 Nov 2022 15:22:14 -0800 (PST)
Received: from redhat.com ([2.52.135.58])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c46ca00b003c6bd91caa5sm11044655wmo.17.2022.11.26.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 15:22:13 -0800 (PST)
Date:   Sat, 26 Nov 2022 18:22:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Guanjun <guanjun@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
Message-ID: <20221126181822-mutt-send-email-mst@kernel.org>
References: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 07:59:58PM -0800, Harshit Mogalapalli wrote:
> As 'dev->vq_num' is user-controlled data, if user tries to allocate
> memory larger than(>=) MAX_ORDER, then kcalloc() will fail, it
> creates a stack trace and messes up dmesg with a warning.
> 
> Call trace:
> -> vduse_ioctl
> --> vduse_create_dev
> 'config->vq_num' is user data as it comes from ioctl, which is
> assigned to 'dev->vq_num'.
> 
> Add __GFP_NOWARN in order to avoid too large allocation warning.
> This is detected by static analysis using smatch.
> 
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 35dceee3ed56..5e9546b16165 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1512,7 +1512,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	dev->config_size = config->config_size;
>  	dev->vq_align = config->vq_align;
>  	dev->vq_num = config->vq_num;
> -	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
> +	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs),
> +			   GFP_KERNEL | __GFP_NOWARN);
>  	if (!dev->vqs)
>  		goto err_vqs;

This is insufficient - the real source of the problem is that
vq_num is not validated.
The thing to do is to validate config and limit vq_num to 0xffff;


> -- 
> 2.38.1

