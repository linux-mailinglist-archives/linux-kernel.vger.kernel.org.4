Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEB65F0FE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjAEQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjAEQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:19:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CD64E42F;
        Thu,  5 Jan 2023 08:19:53 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz12so91212571ejc.9;
        Thu, 05 Jan 2023 08:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyOyM/HgwJlEQ/SHr0fVdceVxYFOEYTbqWcahqqz92M=;
        b=VQVKe2hUanS6/QijnRF6HkC0a+ngye5JsJDB/WLc6I2avTZBU/dgJ5Pc5p7zQ0uyrc
         OmZMAIjPj70zYo6IwuWUb/JWAoZlOU8h02pIXCHOZZBGDaKzHb7KNiEFpkc8Cjf3ac8R
         pUEzIrtIGUtKDiteNml8SNjgIG8qT/HsK93oEGjafTcBOgrUQV+mre7/c/iModBDsEi9
         JGN6DdTrLG/BBdLt5V+rDhcjmT11A+FmdL8zpW/uPWMw1b348xCf8RXsylclOt+uAY3f
         uZHddDuwE+5a4EY3pqNXIjraf3/MtJ3O/Vb93N0sZHlGPPnHHrrET35p3PAKNJYaT0jW
         L+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyOyM/HgwJlEQ/SHr0fVdceVxYFOEYTbqWcahqqz92M=;
        b=qmdPWIM8uUFk3yGL981szLcIO84Yx9D+QK3hZEaVWNBWnEwBVIRsqS67acrPEt003k
         gII1nbZtMAjU+mDhgWHHcZGOm/ZoStoKhkn8cmUzhZkzw+LrIHAOQwkXum97BmyA2A5y
         w6Dl7N5qAtVyCdpxAAegi2ngJlnyKzy2ffV6wsGA2FGZv3eEPb+3eOTLDfzUjvyVg5Nq
         b3szPrUlrb1AdHAr4Ec6v0kjh9GDtN/k+hE7YFuclMJBr0iM75ajfpkoO0u647ZuK95y
         wp+Rgn02B5WBvLLj+2BvV1dNUx366jmBQpEyauX6zVbZCJVnGFc53CLUmTdBj0Uoe5xc
         /X+g==
X-Gm-Message-State: AFqh2kp29jU6mhYzchdwZSgWPSFiiyHqdCDPEJJxtJccVd4L/qOImM20
        Xdk4RPCh9aZkDcnoCf/UQEA=
X-Google-Smtp-Source: AMrXdXsQwQkFr98YlIHQBlZLZhzkiyI1XZKspKsDyskIeLIk0vVJSB5Ia1sEEmCFUSd/R/u3G5WP/w==
X-Received: by 2002:a17:906:f854:b0:849:7688:3e3e with SMTP id ks20-20020a170906f85400b0084976883e3emr35059487ejb.44.1672935592250;
        Thu, 05 Jan 2023 08:19:52 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b0083ffb81f01esm16797532ejp.136.2023.01.05.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:19:51 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/4] media: cedrus: Make SRAM section claiming optional
Date:   Thu, 05 Jan 2023 17:19:49 +0100
Message-ID: <4450464.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20221231164628.19688-4-samuel@sholland.org>
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 31. december 2022 ob 17:46:26 CET je Samuel Holland napisal(a):
> The video engine in the D1 family of SoCs does not have a switchable
> SRAM section. Allow the driver to probe even when the SRAM section
> reference is missing.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c index
> fa86a658fdc6..11e859617932 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -257,7 +257,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  	}
> 
>  	ret = sunxi_sram_claim(dev->dev);
> -	if (ret) {
> +	if (ret && ret != -ENOENT) {

What about more strict check based on quirks flag?

Best regards,
Jernej

>  		dev_err(dev->dev, "Failed to claim SRAM\n");
> 
>  		goto err_mem;




