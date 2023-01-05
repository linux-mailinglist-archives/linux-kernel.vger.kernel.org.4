Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352C165F0F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjAEQSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAEQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:18:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624664C724;
        Thu,  5 Jan 2023 08:18:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m3so19502255wmq.0;
        Thu, 05 Jan 2023 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg9Z/ezQ2VP1OzBT9xNik8ur6PBM8ZeCnIkxjvkNCdA=;
        b=ZVjIz5m0hX8PlIXMGahJ6x/Csgadc5GJ9Zd+rVumUwtBq99GX7dkkYFL7AZQF1oj9T
         y5ICbFMI9cC6zeXuhiqA9Sacw3BcWcoDBtJ5ON/+Eo5Jq9Vsl4zsRz3qwg3CmjEW2e4w
         W0+bhDkAhXoq22eOKduRjSnsct8jj+IZuszeti+y2cFQnnrmg1tG82ezdd2P0oKcxWXJ
         vFQ6FOezDrkrdLRGk/ZHZLkFZad+7zFnZjbvNVriYgMzTBayde0OMF0UDmoCzDMHrLsc
         O5SkLRr5FLGl+wYpoCxFP5t2txoq+xnRzk4UCXCmxvGjpr4IF7kSWqsFGv4VRXabVJqt
         poBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qg9Z/ezQ2VP1OzBT9xNik8ur6PBM8ZeCnIkxjvkNCdA=;
        b=ZeKXQPyRkRWpS2FEEMvFZP0+vSaY0IQTGEz/NaCw657Y0QiC66CkauZO/P4eKQpPhu
         uskOdhh2f1W6IknLegYYYk98mTO740/En8+daYH22r5W56dQOdqWIBmiJK2T1GDhtOGe
         L9wdCpzru50nCkhPoeQcnokY8z8z+ADMFsOPKqloOKoykIIIMC52jBgGJh5z4haENTFj
         dTli++uXvs7gB19jZ0TsR42b+uDPlhqxIxElTR7OdKsaHjgYPLEYFqZETQikRd4NiMiT
         pcwLfUuuG7NIb2zHDjJJ4AS0o0bOQ1wdFbWZc+Yc8jzwwkIZY7mU8pH9OFm6OR/js4s5
         P2GA==
X-Gm-Message-State: AFqh2krhyM7bGAQbsCYO65Qlxc7IfkOvBtEZl1FQ4wfoQjzNshdWYNEu
        YrFPFeaiXPIYBEDngIRIM2A9XH+q12DvHhZF
X-Google-Smtp-Source: AMrXdXvGqO38SjpeDx+nQ5mO3gltv5DwVHr3T+e4+/rn3MECG1cCKPkwM5HXIKyWHVlh4HQG9zupiA==
X-Received: by 2002:a05:600c:4e13:b0:3c6:e63d:fcfc with SMTP id b19-20020a05600c4e1300b003c6e63dfcfcmr36682966wmq.35.1672935484869;
        Thu, 05 Jan 2023 08:18:04 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003d359aa353csm2779923wmb.45.2023.01.05.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:18:04 -0800 (PST)
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
Subject: Re: [PATCH 1/4] media: dt-bindings: cedrus: Allow power domain references
Date:   Thu, 05 Jan 2023 17:18:02 +0100
Message-ID: <5891785.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20221231164628.19688-2-samuel@sholland.org>
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-2-samuel@sholland.org>
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

Dne sobota, 31. december 2022 ob 17:46:24 CET je Samuel Holland napisal(a):
> The Allwinner D1 SoC contains a separate power domain for its video
> engine, controlled via the "PPU" power controller. Allow the
> power-domains property so this can be represented in the devicetree.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.
> yaml
> b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.
> yaml index 541325f900a1..d5be7f604e8c 100644
> ---
> a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.
> yaml +++
> b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.
> yaml @@ -63,6 +63,9 @@ properties:
>        CMA pool to use for buffers allocation instead of the default
>        CMA pool.
> 
> +  power-domains:
> +    maxItems: 1

Please add check if it's needed based on compatible. This yaml is one of the 
few for sunxi platform which doesn't have strict checks. Same goes for sram 
property.

Best regards,
Jernej

> +
>  required:
>    - compatible
>    - reg




