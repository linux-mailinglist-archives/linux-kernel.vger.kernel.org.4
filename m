Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEF6C7237
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCWVRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCWVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:17:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B282825BBA;
        Thu, 23 Mar 2023 14:17:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg48so329378edb.13;
        Thu, 23 Mar 2023 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679606235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+99Id4vlxpRMOhGjaSB6bloNnr3EAmVVri5OUB3HI0=;
        b=Z0OU4zaxuMlq76Gk4nh+Y3sS3l4JuzykQcrJRFgVcU4j3G99BBLVe5F8T31Hs1pnfF
         hYPLX9iuFec7w3kEKsmgrOGm7M0dfAXgq0u6Tw2FglaTMif9h7HGqo306Nz6FSKUfdxs
         /E8CtpxeTvNfOIVx8LcKy/9AU6GDQj6pOXr30TAad6lh0Qw7dNL+V3CC17p0hpWI1PyJ
         JP+dWjVOA3cB6bETXZ+L4xHytwjWrUfnrcmTWlxCLf9N6fpPp2lsvVpEmoGzz4RtQw9c
         OcTeKFFPxCbmCtyYq2tUArCpX7wefJwkmGb4fS18m3V5qswE+8F7KsDwk4+R3De956Ie
         uSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+99Id4vlxpRMOhGjaSB6bloNnr3EAmVVri5OUB3HI0=;
        b=2UVf5vQsl8bJtbEJziUeNvTVNlzDAFYQUROSLKeFIbNnqOEeCFmRV7LphZ7w4m44vw
         imkPlTZb4GTygD3JQ5RJ1UDZFrPSudq5I8kL7VONbQiaFu9XYthyk1tjaMXZ6Uc1MRGl
         11PVYA5uCuTRJkEH810nBCWIr85RaWs2FW+FbFfllqYupOKz/Jj2CjmX6139HbLmcxe9
         a1cZ2qNn8xUGgYDs9WA+lGpVkn0wGZ75n03KvG9QNcsasWCF90pEt8xji6YvIH6pPXR+
         sTthZ6ZqPYDgdww682Su9zGHLjowVrU9LZmhvBAZ11p/Sv49gx5wd177Rt41E12bXOp+
         NUEA==
X-Gm-Message-State: AAQBX9epPhlsf0nE3dsePiW7+u/w+ge7T22eOiLoaowPcPxLESczy1Lj
        fhNDmonbNOj+4P6IAodGL/o=
X-Google-Smtp-Source: AKy350YXV7OnGGHypgylfPA7W/z5nJ+1x5GYw3D1Ob/zxZAWqv391Qz43ld0dBcs8lA0IxMw54UvSQ==
X-Received: by 2002:a17:906:fa0b:b0:8b8:c06e:52d8 with SMTP id lo11-20020a170906fa0b00b008b8c06e52d8mr404362ejb.36.1679606234729;
        Thu, 23 Mar 2023 14:17:14 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709064d0500b00923f05b2931sm9111409eju.118.2023.03.23.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:17:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?ISO-8859-1?Q?Andr=E1s_Szemz=F6?= <szemzo.andras@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: sunxi: add Allwinner T113-s SoC .dtsi
Date:   Thu, 23 Mar 2023 22:17:13 +0100
Message-ID: <13227090.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20230320005249.13403-3-andre.przywara@arm.com>
References: <20230320005249.13403-1-andre.przywara@arm.com>
 <20230320005249.13403-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 20. marec 2023 ob 01:52:47 CET je Andre Przywara napisal(a):
> The Allwinner T113-s SoC is apparently using the same (or at least a very
> similar) die as the D1/D1s, but replaces the single RISC-V core with
> two Arm Cortex-A7 cores.
> Since the D1 core .dtsi already describes all common peripherals, we
> just need a DT describing the ARM specific peripherals: the CPU cores,
> the Generic Timer, the GIC and the PMU.
> We include the core .dtsi directly from the riscv DT directory.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


