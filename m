Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8F6264B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiKKWhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiKKWgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578445F87A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668206156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhguikNfjP3jJj2Xsd2EMwn1nCtYD4FWU8eudH5AFMc=;
        b=MA25sQIWc0ddhfcddwraC+TGkTSaolZURMyA95vQifXHSXfSnErndfi5RZvFnMsea6JBOt
        KnJQrNSSVS1D5A/I36dag2YGU/DU5ZZeJ0lv9P65K+QpkR861crckkqzW85+bmxe3Hfzsr
        LxmcnKxy8mv7vPkDpb0gteQR3CpU1+w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-567-DlUr5vCEMHGTy4JuKEkUDA-1; Fri, 11 Nov 2022 17:35:55 -0500
X-MC-Unique: DlUr5vCEMHGTy4JuKEkUDA-1
Received: by mail-qt1-f197.google.com with SMTP id b20-20020ac844d4000000b003a542f9de3dso4488431qto.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhguikNfjP3jJj2Xsd2EMwn1nCtYD4FWU8eudH5AFMc=;
        b=VGSel38x+6cXMlylnn4At+bPkqWbGxQgmC/K/2MkEnx12oIR+46S9aZokzN+EzOaup
         c8lfp6HbYME2iwf4JXSTMm9D+EwYiQQEg6UWXhn3CQqf5VGxakNBKtmZZ6fmhtFeJM0S
         LZenevBSnm4TIundOdXcXRKCkyrNIol4s2HgIraqfcuRS0qpacxQ//srNlC/zFqSSZW+
         xtPf6VbVAWUpSKgyiYqNy18LEXVn4XxWplUsoRpvM7wszhi/vyt8fXWXrDemVE1iB4Jk
         T/UAF0s8eCjn4/7b0QqjSdVSzZ3CMr5oAcyCiitLgaPAbJcAP9BsVxkvepmS6w+ufK7N
         m1vA==
X-Gm-Message-State: ANoB5pknKM4OdcdnfzXasdIy0mZ2gFTeF6bkxsk+Aj1GvtKTyh1SAIFz
        KiwP4vPZWItORS+6MAoddGutfwHtoqvqw7KfUnKijkAtOT2IRdVX7pDcf7nGI+Aq/c/uTe6cGQ1
        hYLq9slgk1Q2c9lWMOzycV30O
X-Received: by 2002:a05:620a:6c6:b0:6fa:3aa2:3269 with SMTP id 6-20020a05620a06c600b006fa3aa23269mr3031013qky.580.1668206154909;
        Fri, 11 Nov 2022 14:35:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6W/KXwux5rPH6dWDWepLU+USDtFNI5v0KJ6gDMc3Hi176iuyM26xOcvo8FvrRu0zkBEIu9xg==
X-Received: by 2002:a05:620a:6c6:b0:6fa:3aa2:3269 with SMTP id 6-20020a05620a06c600b006fa3aa23269mr3031002qky.580.1668206154708;
        Fri, 11 Nov 2022 14:35:54 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:9200::feb? ([2600:4040:5c6c:9200::feb])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006fafaac72a6sm2203033qkl.84.2022.11.11.14.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:35:53 -0800 (PST)
Message-ID: <b4f731226c27150cc776d87a1175859d22acd666.camel@redhat.com>
Subject: Re: [PATCH 1/5] drm/nouveau/nvfw/acr: make
 wpr_generic_header_dump() static
From:   Lyude Paul <lyude@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, bskeggs@redhat.com
Cc:     kherbst@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Fri, 11 Nov 2022 17:35:52 -0500
In-Reply-To: <20221111091130.57178-1-jiapeng.chong@linux.alibaba.com>
References: <20221111091130.57178-1-jiapeng.chong@linux.alibaba.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the whole series:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next in a bit

On Fri, 2022-11-11 at 17:11 +0800, Jiapeng Chong wrote:
> This symbol is not used outside of acr.c, so marks it static.
> 
> drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:49:1: warning: no previous prototype for ‘wpr_generic_header_dump’.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3023
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
> index 83a9c48bc58c..7ac90c495737 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
> @@ -45,7 +45,7 @@ wpr_header_v1_dump(struct nvkm_subdev *subdev, const struct wpr_header_v1 *hdr)
>  	nvkm_debug(subdev, "\tstatus        : %d\n", hdr->status);
>  }
>  
> -void
> +static void
>  wpr_generic_header_dump(struct nvkm_subdev *subdev, const struct wpr_generic_header *hdr)
>  {
>  	nvkm_debug(subdev, "wprGenericHeader\n");

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

