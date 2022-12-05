Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA278643548
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiLEUJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiLEUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:09:35 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5322B35;
        Mon,  5 Dec 2022 12:09:34 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m19so17354285edj.8;
        Mon, 05 Dec 2022 12:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpMKLnQvRwdkwAICgisKHiIAgDK4bb7kpFoIvZc8X0Y=;
        b=eO0nr9xr/5Axiu65l0YsbhdbJtKiMGVBtsKTtMG1A2Et+o7gvvNdM3qg20UeO1vj55
         G2XMKYhZXLza4c2E+amkl3PjlRwV/BQTkTucQDJCTz0eDTMDP1k/Ph2M2B2ht/qC3K2Q
         8z9crRRVSmHGXqm4HScyfqCUoqpLVODPbZXXfrO1GIXOL6KayXG20aTZphDljX6gV5Vq
         6+pzQL38pEcHNCQnDves3hkJMSeN3kjVp09XhskyaJHjTNKLTzicZG6cKJCxweW8Et/8
         XovWi0eNiBeRb0J2gpXNMBB09dbY3U54YJwi/noqwUScKPlLDjDn0y6llCiZp4Lp1H6i
         F4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpMKLnQvRwdkwAICgisKHiIAgDK4bb7kpFoIvZc8X0Y=;
        b=v8PiQ5PP2HvVrHWQXF364HS1DI9OLGTUlWDkD6p5sguN9/jrcDZjBCE3fKjcz3nfHn
         rDlZfJZ0yGIXgBLLLXblUo7dT7VvY6RgpvC4/AI62ny4Yhvs+EocOAffl0DFy953OuSR
         CTAdz1qrG3+pSvGGrQU2bI048VYzYAH3HYH68xCSGQehQHOmyq3gZeaJIpkcmAwZEcBM
         QyR2OSDIJwaFIRFqiMtrpkCtte1ah26iOMBCvWD9k/YNolgYJekftO+tn0O9/rCIYDoF
         /RM/DploTm0pVTSqUJn4mCua8oQ1u++/Xt6szIxn3oSLOpdZOZ5bxCMf4jT3ct1uyCFm
         kcYw==
X-Gm-Message-State: ANoB5pkurM70PlfwiFqfHCeTzFfQI8Qg5kIx9vqWWYWw4zqSY+y96QsN
        MKgMeNV47iPTPepDSjrNOSLFa/qmyTo=
X-Google-Smtp-Source: AA0mqf7BlEOEgsitTiXLkvk1nxBEdhQvF8zq2FdleVoqh4mVW4UshOpPANKgeusok80IzaRsR4w03w==
X-Received: by 2002:a05:6402:e9c:b0:458:d064:a8c2 with SMTP id h28-20020a0564020e9c00b00458d064a8c2mr2891532eda.346.1670270973026;
        Mon, 05 Dec 2022 12:09:33 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id v16-20020a1709061dd000b007b47749838asm6531100ejh.45.2022.12.05.12.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:09:32 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: sun8i: h3-beelink-x2: align HDMI CEC node names with dtschema
Date:   Mon, 05 Dec 2022 21:09:31 +0100
Message-ID: <2656750.mvXUDI8C0e@kista>
In-Reply-To: <20221204183341.139946-1-krzysztof.kozlowski@linaro.org>
References: <20221204183341.139946-1-krzysztof.kozlowski@linaro.org>
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

Dne nedelja, 04. december 2022 ob 19:33:41 CET je Krzysztof Kozlowski 
napisal(a):
> The bindings expect "cec" for HDMI CEC node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


