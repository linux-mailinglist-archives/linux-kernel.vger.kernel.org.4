Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686F717A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjEaIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjEaIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:32:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165FF12E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:32:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f623adec61so57275865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685521917; x=1688113917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhA/sfDRnLuDCN7yHv6nCUiMzZVvvoBjYdsSnPZ2b68=;
        b=Qf9zKFrn4Y6OFuEjXy7xAuVGz/ckgeam+xe7JLoo1sZ2JIwV3Zle4eGVrClGw0Suuu
         EuPu5XqzoGtSat0xDB8XzH//945LkSMdRioWZ07l3M+g3sQPSG6k5rbbiURKiTm3B7io
         beFK2eG3qQGuU7oqTYBxDur924FFE9Kd6DwSCXq6CmSdUPSY7ZYVbroOjtE0rOpBialT
         2pRHtuwWKBsxHuAUF0xHP+WoE6Cpl5WLqdOnWc2v6+hVQ1Y3woLNfCrW5f8kxg0qVI9C
         WdnZVK5XxDrJP5HkDypnDQoH7zGtbRZct9zHWKgpsrYdownAuH6HRocfvXIjm7fhRODu
         PeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521917; x=1688113917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhA/sfDRnLuDCN7yHv6nCUiMzZVvvoBjYdsSnPZ2b68=;
        b=lMAPL2rZJR1gxK2OtdVAJ89dNAoNjT+KxTsoXv55r6FTKSJxpds8bul9drQ3Mk99kR
         TkwUTm6mQG+1oEpPHxdhz/eM6E6KIzSxyPUjYkiZBHS6ygwqeydlCsqavFWhh5FMBXhB
         w/nverBSDQ79de54dQh6Am25xk4tqV4HqDRmRGA2s9VYAjtCGxAnbJogNnvIW7D1auMo
         myH6oVGxJHIXb9EOu3GRX2FMuhasuhO5V9bg31dymZA7ERzMxCh4gfzfJHpYbVlG2Wx9
         u5QpwFhTSdNnqtjHEn1Ux1J26T1O8oIRB/TryFccxsb745A08EG6NbMAQrD/6K51+FVV
         Qytw==
X-Gm-Message-State: AC+VfDySSyai8vKqBjmk+PfS6MHAGIJYSE4anTBQM9Z8hVBD18oIFSa/
        XAbuMnKZhwZ6uuLgzh8GMYcw8w==
X-Google-Smtp-Source: ACHHUZ4S5/0dJg8BIO5Y3X1Ar+fFJRW029hscEdyzxU/RK6FIShaB3l5woWFqtMhhmxltyEBwA5dOw==
X-Received: by 2002:a1c:f216:0:b0:3f1:7581:eaaf with SMTP id s22-20020a1cf216000000b003f17581eaafmr3223629wmc.4.1685521916624;
        Wed, 31 May 2023 01:31:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q13-20020a7bce8d000000b003f43f82001asm23557270wmj.31.2023.05.31.01.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 01:31:54 -0700 (PDT)
Date:   Wed, 31 May 2023 11:31:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, airlied@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/nvif: use struct_size()
Message-ID: <00e84595-e2c9-48ea-8737-18da34eaafbf@kili.mountain>
References: <20230531043826.991183-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531043826.991183-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:38:26PM +0800, Su Hui wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more informative.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpu/drm/nouveau/nvif/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
> index 4d1aaee8fe15..4bd693aa4ee0 100644
> --- a/drivers/gpu/drm/nouveau/nvif/object.c
> +++ b/drivers/gpu/drm/nouveau/nvif/object.c
> @@ -65,7 +65,7 @@ nvif_object_sclass_get(struct nvif_object *object, struct nvif_sclass **psclass)
>  	u32 size;
>  
>  	while (1) {
> -		size = sizeof(*args) + cnt * sizeof(args->sclass.oclass[0]);
> +		size = struct_size(args, sclass.oclass, cnt);

This is from the original code, but now that you are using the
struct_size() macro static checkers will complain about it.  (Maybe they
don't yet?).  size is a u32.  Never save struct_size() returns to
anything except unsigned long or size_t.  (ssize_t is also fine, I
suppose).  Otherwise, you do not benefit from the integer overflow
checking.

>  		if (!(args = kmalloc(size, GFP_KERNEL)))
>  			return -ENOMEM;
>  		args->ioctl.version = 0;

regards,
dan carpenter
