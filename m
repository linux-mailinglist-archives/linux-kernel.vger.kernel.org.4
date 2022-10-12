Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E395FCE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJLWs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC31DD77DF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665614901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cQbK112G3CBY1iPorRDqAdSJlO6cOwytKNZM4RSxzY=;
        b=eL422QMjrB6LYxyXRNWVn2VQl57EmpF70t1alwPFIup7PxEMnCjbUgBBrsdIMlw1OOMDvY
        20ErjViN1ctYoELr7jvtivxRIUQWYpIc2XrCaxEIElKUF12dI5nRLPmysSeH6o4ukZopHR
        PflDJ0/ttRTzyziIqXFbnhGBgGppZUU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-RTeibYE-MR6vAsq-A-bKTQ-1; Wed, 12 Oct 2022 18:48:18 -0400
X-MC-Unique: RTeibYE-MR6vAsq-A-bKTQ-1
Received: by mail-qt1-f197.google.com with SMTP id s14-20020a05622a1a8e00b00397eacd9c1aso8617401qtc.21
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cQbK112G3CBY1iPorRDqAdSJlO6cOwytKNZM4RSxzY=;
        b=1umadboy44U9YDgUVyu0Pkprg9U1wbRCs9n1CsYtKeXQ42op6bRdY0vguSPtmZ+7g6
         HQ4fyLE+rm++X+F6hsbsZH6zfkEw0aSRCZA31hh7SR4xA7b9b2v8cFrFsI8S+DQRYkov
         S5jV5s91T7jaaQ4qVlRoBP9Ge7A4Hho08deBkeUUlxPyWmknACeKV8tHYh/hBGDx7Zl+
         xA3J+UV7t6EhGWnSfHGmy3S3BsznDtxLP0QlVmrGdLhxN5GXrZCr9o97Pr+URfB133H1
         5/Cx3VJ8y5HndaXP4KD0qzhYvi8q7SJicuSA97xUxaDdOd3n2hfe1O6SOtYDOqtpqd0q
         IIYw==
X-Gm-Message-State: ACrzQf2fiYc6D9k80bWoXKo2rzvio3lJbkE2FJZx6mGdmr1WZ1mlivVR
        E6XD+EHC77knkLTqBSgTHtkSCJUQeidIRf0Ity7ntcKEULcEy/VIFmacwwP4NV1KTqCp2qG9TWN
        N3nyBXOwC6eYR97BbbCT3Yl5k
X-Received: by 2002:a05:622a:1183:b0:39c:606d:1f7f with SMTP id m3-20020a05622a118300b0039c606d1f7fmr8858874qtk.313.1665614897689;
        Wed, 12 Oct 2022 15:48:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5tzPmYPKNIbVp3GJbjJyU2orb8Zq7NMYarr1l6JZruGvyaqWohInpYh6qO0ffWOFde1Yrniw==
X-Received: by 2002:a05:622a:1183:b0:39c:606d:1f7f with SMTP id m3-20020a05622a118300b0039c606d1f7fmr8858864qtk.313.1665614897486;
        Wed, 12 Oct 2022 15:48:17 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c68:4300:fdba:af4a:bbcd:7e28? ([2600:4040:5c68:4300:fdba:af4a:bbcd:7e28])
        by smtp.gmail.com with ESMTPSA id x20-20020ac87014000000b0039cb9ef50b5sm3192209qtm.26.2022.10.12.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:48:16 -0700 (PDT)
Message-ID: <b52dbad5e3c2c5f19c605440de3e4e017e70a2ec.camel@redhat.com>
Subject: Re: [PATCH -next] drm/nouveau/disp: fix cast removes address space
 of expression warnings
From:   Lyude Paul <lyude@redhat.com>
To:     ruanjinjie <ruanjinjie@huawei.com>, bskeggs@redhat.com,
        kherbst@redhat.com, airlied@linux.ie, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch, jani.nikula@intel.com, airlied@redhat.com,
        tzimmermann@suse.de, hverkuil-cisco@xs4all.nl, greenfoo@u92.eu,
        seanpaul@chromium.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Date:   Wed, 12 Oct 2022 18:48:15 -0400
In-Reply-To: <20220924092516.10007-1-ruanjinjie@huawei.com>
References: <20220924092516.10007-1-ruanjinjie@huawei.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me (sorry for the slow response! I think this one just got lost
in the noise). Will push to drm-misc-next in a moment

On Sat, 2022-09-24 at 17:25 +0800, ruanjinjie wrote:
> When build Linux kernel with 'make C=2', encounter the following warnings:
> 
> ./drivers/gpu/drm/nouveau/dispnv50/disp.c:134:34: warning: cast removes address space '__iomem' of expression
> ./drivers/gpu/drm/nouveau/dispnv50/disp.c:197:34: warning: cast removes address space '__iomem' of expression
> 
> The data type of dmac->_push.mem.object.map.ptr is 'void __iomem *', but
> converted to 'u32 *' directly and cause above warnings, now
> recover their data types to fix these warnings.
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 33c97d510999..aa94f8e284dd 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -131,7 +131,7 @@ nv50_dmac_kick(struct nvif_push *push)
>  {
>  	struct nv50_dmac *dmac = container_of(push, typeof(*dmac), _push);
>  
> -	dmac->cur = push->cur - (u32 *)dmac->_push.mem.object.map.ptr;
> +	dmac->cur = push->cur - (u32 __iomem *)dmac->_push.mem.object.map.ptr;
>  	if (dmac->put != dmac->cur) {
>  		/* Push buffer fetches are not coherent with BAR1, we need to ensure
>  		 * writes have been flushed right through to VRAM before writing PUT.
> @@ -194,7 +194,7 @@ nv50_dmac_wait(struct nvif_push *push, u32 size)
>  	if (WARN_ON(size > dmac->max))
>  		return -EINVAL;
>  
> -	dmac->cur = push->cur - (u32 *)dmac->_push.mem.object.map.ptr;
> +	dmac->cur = push->cur - (u32 __iomem *)dmac->_push.mem.object.map.ptr;
>  	if (dmac->cur + size >= dmac->max) {
>  		int ret = nv50_dmac_wind(dmac);
>  		if (ret)

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

