Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3162A41C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKOV3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiKOV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161822C5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668547698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmoXYFI0/eVOuz/NEvHefHeJjHkU7FXRO8BQqWcg6VU=;
        b=S+qFTzd7R0OMu3Q0VjmfZeJp1YLFaAkUGKXdeb/y6iCzuosxogc6KrsZ8uOnAV/zGstQdF
        xAsn9fPtmCuMzIRMXtLDh5n5axoQlWooOV/iYOmPfDpx4bHp9HUNG0TOxss3Vr98NNm+qC
        noX4Ft7fLkauXICMvuYB7PBnEcOwfLM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-rUoDlml0O6-mV3OYFN-ARA-1; Tue, 15 Nov 2022 16:28:16 -0500
X-MC-Unique: rUoDlml0O6-mV3OYFN-ARA-1
Received: by mail-qt1-f197.google.com with SMTP id i13-20020ac8764d000000b003a4ec8693dcso11353612qtr.14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmoXYFI0/eVOuz/NEvHefHeJjHkU7FXRO8BQqWcg6VU=;
        b=cwiiOPlUUdIA+f1DF/f65zHVOK5jZxrdQv9P927p98XlWBnNRfwFfXSdRns4fK0dDm
         4Lw6LSLrebNtN2h5+NlTgIY5ojXOS1hJt6Q3Fi++z6hxd4CwZu6a+XK9LpnSLZUKBRA8
         +fjfCHW1kvUwvc+sekS8MYcJD42D50dDTZ4EmqOGULDYIErMs/e6H0ruAdeXeNBZQmeN
         7BIWanDHxp2+u2mNNyV5gXWOWCEmqIt680h45lVlPRwySwK1aiGIoRo+uwv2O0KVvcyo
         HZ1jJTHiGUzp584nnkUtZfsnlINKt6lELLmCVbEChupiQWowiT3/ZJVTr3q+0P26N3T+
         hycw==
X-Gm-Message-State: ANoB5pln1+fnlK0Vc0sVHASp+b9gnkdnRm+c0PzI24eQ0ZL4kAr2Qiel
        Tw3WWhZt4F/qGJo8GizeNrW4PsMcYeF077pSdHdhPo6AxlOyD72mt7H4K8BVmxmyZq1vYyEdRI9
        /lEAP41y4SY4BCcYM3fRvD0pK
X-Received: by 2002:a37:3d6:0:b0:6ea:5efd:7c07 with SMTP id 205-20020a3703d6000000b006ea5efd7c07mr17083355qkd.68.1668547696218;
        Tue, 15 Nov 2022 13:28:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7CK3bbYzt2A3qEQjSmPdgB+DjUzTsXhGVKt0JKIf2+CrZ0ap0pHsHrLeu7LKroMWDYnkzA+Q==
X-Received: by 2002:a37:3d6:0:b0:6ea:5efd:7c07 with SMTP id 205-20020a3703d6000000b006ea5efd7c07mr17083336qkd.68.1668547695975;
        Tue, 15 Nov 2022 13:28:15 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:9200::feb? ([2600:4040:5c6c:9200::feb])
        by smtp.gmail.com with ESMTPSA id x28-20020a05620a0b5c00b006fa0d98a037sm8637014qkg.87.2022.11.15.13.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:28:14 -0800 (PST)
Message-ID: <78b220f34105e8f9ed5c1e9f1d3974c5ee9562e8.camel@redhat.com>
Subject: Re: [PATCH -next] drm/nouveau/gr/gf100-: Remove unneeded semicolon
From:   Lyude Paul <lyude@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, bskeggs@redhat.com
Cc:     kherbst@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Tue, 15 Nov 2022 16:28:13 -0500
In-Reply-To: <20221111011919.1992-1-yang.lee@linux.alibaba.com>
References: <20221111011919.1992-1-yang.lee@linux.alibaba.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2022-11-11 at 09:19 +0800, Yang Li wrote:
> ./drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:423:31-32: Unneeded semicolon
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3013
> Fixes: 78a43c7e3b2f ("drm/nouveau/gr/gf100-: make global attrib_cb actually global")
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> index 5f20079c3660..204516891ece 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> @@ -420,7 +420,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_fifo_chan *fifoch,
>  			return ret;
>  	} else {
>  		ret = nvkm_memory_map(gr->attrib_cb, 0, chan->vmm, chan->attrib_cb,
> -				      &args, sizeof(args));;
> +				      &args, sizeof(args));
>  		if (ret)
>  			return ret;
>  	}

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

