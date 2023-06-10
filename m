Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB92672AE43
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFJTEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFJTEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:04:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9761993;
        Sat, 10 Jun 2023 12:04:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30aebe2602fso1943026f8f.3;
        Sat, 10 Jun 2023 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686423878; x=1689015878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+YjzUo1B2S2csqhYjgytz5WXmvhzS96d+qxUFRdrfc=;
        b=FiZkOzgUV4WCSgew0MvSsd/J2ST7V62H/PbPxj6U9tz3f2mwkjLLt3zw1HbDLtjF1W
         O/shoVGScGEQ0UwqJTyWX/8EFv0CmSl15OH4qwVDN5umIYmpMyRs6A29TBgQTr6ITLk5
         Z0h3jDWIJuCVp3hjL4rufQHX9lpEz45mPdFILSqbPM1q2cc/asJKuImPV2Nq16Fywuzl
         DajsNuquw8QvP7Rh1m2qCXNj641jxEvMrTMxnNMNdGg+yZua95BioqffM5VNGhP4miZw
         uzSKUmDWIkjSdDqkWT+Qb5tyiP1dCIlkTdt0+PMr8IMb/dTiudd0u1YfmH9E1C+us7X/
         fj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686423878; x=1689015878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+YjzUo1B2S2csqhYjgytz5WXmvhzS96d+qxUFRdrfc=;
        b=FCMvDzA33dJ07Na9BMemc4ibjVMvZ81xLARlTGYxV3LVvDUfffddTZd7WTfwT0/rSc
         /+UYOWhDAL2IF+y0sIGGQXxYRs2ivokda3OUwU/7ZQQtDGcZ28sLtuvLtxz6qBJ0/+Kk
         77rz+ytqfDNPD61jtnYomriP7UTIXGwYNfCva2S5l+tsGaBRuwoSG5UOu22qV4Vk6YL/
         Nlp1Df0HdRJjl54EcH0js/paht3FRj/01DZNkhE8igB5I+NYQEw2Ul2p38N/PBWzOF+h
         3EG3cZmLEVaJf3v6xhH/YdiUj4oWD2zlmRHrOBY5T+qLTGMSHBYSWrniKUCI9ul6AjfW
         pr8A==
X-Gm-Message-State: AC+VfDw1la0pGh+vvEdDnp1GFEYgg1NwSBNt3OuuYgZowORlAryAM6YK
        wSsDmaW7ye6sjwtE95MZ6+Z7X8QshmncbECC
X-Google-Smtp-Source: ACHHUZ7+FwyXPExmCGfTdhBoc8oJvU/zTiio5BdCHihsSEDTYpwdfYxIiMhA0liy4/BsVzbnEHqTuw==
X-Received: by 2002:a5d:448a:0:b0:30d:8490:58 with SMTP id j10-20020a5d448a000000b0030d84900058mr1191214wrq.9.1686423877776;
        Sat, 10 Jun 2023 12:04:37 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id i1-20020adff301000000b002f28de9f73bsm7764607wro.55.2023.06.10.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:04:37 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/3] Add D1/T113s thermal sensor controller support
Date:   Sat, 10 Jun 2023 21:04:34 +0200
Message-ID: <4275249.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <20230610141739.999268-1-bigunclemax@gmail.com>
References: <20230610141739.999268-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 10. junij 2023 ob 16:17:31 CEST je Maksim Kiselev napisal(a):
> This series adds support for Allwinner D1/T113s thermal sensor controller.
> THIS controller is similar to the one on H6, but with only one sensor and
> uses a different scale and offset values.
> 
> Maxim Kiselev (3):
>   thermal: sun8i: Add D1/T113s THS controller support
>   riscv: dts: allwinner: d1: Add thermal sensor and thermal zone
>   dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller

As mentioned elsewhere, please fix SoB tags. Also binding patch should
come before driver changes.

Best regards,
Jernej

> 
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 20 +++++++++++++-
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 26 +++++++++++++++++++
>  drivers/thermal/sun8i_thermal.c               | 13 ++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> 




