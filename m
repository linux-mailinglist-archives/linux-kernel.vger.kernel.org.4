Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4CB5FCE94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJLWtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F5D77DF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665614930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5nfuKdPwrQVXi/vnKW1FCyCONTVZtF3Xa0tpdwXNtg=;
        b=ULnhQPMbjGKdhY5cpzHTtTKonC9hIAcph92D1mAMTgB2PlepfWFbeJPxDqkioRYu4eJM5e
        bgh9dHdRozEGJgEdvbCWEk/osyXZVf7XKZJU1Job4fNP7yhfIQXkSFcuKavmDSsxnlf9s7
        7m8XxYUCfKVrvu7FLFxhY5o65mJRh8Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-IYq6pzPkNNGjFbeFn3_jOA-1; Wed, 12 Oct 2022 18:48:48 -0400
X-MC-Unique: IYq6pzPkNNGjFbeFn3_jOA-1
Received: by mail-qk1-f199.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso110694qkp.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5nfuKdPwrQVXi/vnKW1FCyCONTVZtF3Xa0tpdwXNtg=;
        b=HjLN0JPwTEP1DjMzBcW9DW61UphaKvtB/l3+3BVD/v4c8H4Q/+FkLyatQMHLK3GPDj
         OzupQkST0M6mtQDRUEpv74e0lFkzm2BQBWwihnc1+KzlM6E2/TLogSfg7czBWVnUAECl
         J5Bs7xAFgs/IWCsa6L3+xIj5esAIqT3cZznSQLaiWOfCEf0V8HYLfgvRz/lSn/AOCI+f
         /GdxvYTvAzrx2WP4RSk9HpJ6ixdO4Qj1OlTsikgyPkzPpesknLeNQv0y52uXSuoYrVFb
         nlg2Bn+Z5xPjfLnLOmZjINq/GbFQsfiPFt06RzcgbWyDwmdhcKcYHp6T7yFhGT0R1T+p
         IBSA==
X-Gm-Message-State: ACrzQf1942Csan29u5MBpTBfnbGcVlDXyKoIuGMqcK86s3PQ9uczYC2f
        Gqb3JwcFYjx0Sw/7DY/+dxAqSheyghFYfWkJC0Eu/9Esj0O0Ge4XAwncWfAGIjXL9LrONxrUKOD
        sFRYlzVeaKOk08uxowI8Iu5JF
X-Received: by 2002:a05:620a:27d2:b0:6cf:b644:f644 with SMTP id i18-20020a05620a27d200b006cfb644f644mr22536271qkp.35.1665614928439;
        Wed, 12 Oct 2022 15:48:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM72AflosodYNtr/quj11dfW8xw1ovGZzl7sA9B7tx1ZGymI0DOPi1vu4e2bPcM1ZP1Q5MC8dg==
X-Received: by 2002:a05:620a:27d2:b0:6cf:b644:f644 with SMTP id i18-20020a05620a27d200b006cfb644f644mr22536261qkp.35.1665614928240;
        Wed, 12 Oct 2022 15:48:48 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c68:4300:fdba:af4a:bbcd:7e28? ([2600:4040:5c68:4300:fdba:af4a:bbcd:7e28])
        by smtp.gmail.com with ESMTPSA id l10-20020ac8148a000000b0039cc47752casm1669626qtj.77.2022.10.12.15.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:48:47 -0700 (PDT)
Message-ID: <9c36a93654c5aa9c850cd5d42681aa951df9e769.camel@redhat.com>
Subject: Re: [PATCH -next] drm/nouveau/disp: fix cast removes address space
 of expression warnings
From:   Lyude Paul <lyude@redhat.com>
To:     ruanjinjie <ruanjinjie@huawei.com>, bskeggs@redhat.com,
        kherbst@redhat.com, airlied@linux.ie, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch, jani.nikula@intel.com, airlied@redhat.com,
        tzimmermann@suse.de, hverkuil-cisco@xs4all.nl, greenfoo@u92.eu,
        seanpaul@chromium.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Date:   Wed, 12 Oct 2022 18:48:46 -0400
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

...oops, totally forgot to actually give you the magic tag so patchwork knows
I reviewed it:

Reviewed-by: Lyude Paul <lyude@redhat.com>

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

