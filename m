Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7F45EA589
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbiIZMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiIZMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:02:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E9358B79
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:53:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i26so10155707lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zT9HYnywBLKAnKj+znnUDQxqf7HMsI+nwdK6gxUUKog=;
        b=nnwMFktu6Mzy49U0FD2s+8Z4fRTD91ziKmoRUTM3H8NByk5c+iYEF0H4nly5PKKAJb
         0XtvTB7/iX2VrdGEwfRbKXNtxvUNNjB6xgsiE9VDMW1oBRgxhUHWCq8hM45Foj+QhCBQ
         kSsS991r9ijmdvr9hIQC+sF9wYUtp8jF8Un3uyxpZHaQNGzN46RKUIkM8cElkzXObzsB
         w2kEtScKAqxKrvXJoZcEsSdTgDIgyYlBpS2gZVdM4VXrV1LDTF56yoV0csuBPC5u0z6o
         9kjVOu7hzVAnlG9iXluVY8vuelDtrdIk/3wxbptt5McOENOmIAftdbKRioqC162s1cfE
         SsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zT9HYnywBLKAnKj+znnUDQxqf7HMsI+nwdK6gxUUKog=;
        b=DcVQKjAw1lCLsuc99rTiR2Le/fMzE1VhCz7zAGLRolmw0mUkS1RAjr36kvjJa9vjDA
         Wlfz+Tw9Dv9g7V3ItD1bR+BGexe9t2O24c4rXL7HQMiARv/vQUFIwuPjOTqJyBhtYGe3
         tIUJiJc+DfUq0zvmiFb+0f7EV3bCCq87VC8PWQywehoLJDnwefKykhfctsGLppOkRo2V
         LmD5/Cs0PwLQYPPPpZB3p4DCZDBG6LMhA+j37DiKDMMUbWePJoUR5D2iGNCGSDK4rSgv
         mBNbxbN1lzAKxD9aTVrh0N0ei5GPF5i6K0+m7Z8Kzl5mfpMJSOXkD1MMPU4jXeoeIM95
         mjSA==
X-Gm-Message-State: ACrzQf2Ijwn6AxP9GXSDmJlMbqY6qfBg4FVafJA0PzwfYQaX2nvaIbBg
        A+sYWBzA1tODZfatnimXRxqKrQsEz3iyjQ==
X-Google-Smtp-Source: AMsMyM4CI56MoPkBYHfKNTWWd82vbJ9ouSxHTzz89N+BnGbFsWbsGBpY753rS4H1VwrtNhHaGqKUAA==
X-Received: by 2002:a2e:a801:0:b0:261:91a3:bc44 with SMTP id l1-20020a2ea801000000b0026191a3bc44mr7213846ljq.497.1664189049185;
        Mon, 26 Sep 2022 03:44:09 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y1-20020a05651c020100b0026c423959desm2313408ljn.25.2022.09.26.03.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:44:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Tomasz Figa <t.figa@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH PULL 2/2] ARM: s3c: remove orphan declarations from arch/arm/mach-s3c/devs.h
Date:   Mon, 26 Sep 2022 12:43:54 +0200
Message-Id: <20220926104354.118578-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926104354.118578-1-krzysztof.kozlowski@linaro.org>
References: <20220926104354.118578-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaosheng Cui <cuigaosheng1@huawei.com>

s3c64xx_device_spi1 and s3c64xx_device_spi2 were removed by
commit f1ba938e4f98 ("spi: s3c64xx: Delete unused boardfile
helpers"), so remove the declaration, too.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220914034615.1240860-3-cuigaosheng1@huawei.com
---
 arch/arm/mach-s3c/devs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-s3c/devs.h b/arch/arm/mach-s3c/devs.h
index 02b0c5750572..991b9b2006a1 100644
--- a/arch/arm/mach-s3c/devs.h
+++ b/arch/arm/mach-s3c/devs.h
@@ -33,8 +33,6 @@ extern struct platform_device s3c64xx_device_onenand1;
 extern struct platform_device s3c64xx_device_pcm0;
 extern struct platform_device s3c64xx_device_pcm1;
 extern struct platform_device s3c64xx_device_spi0;
-extern struct platform_device s3c64xx_device_spi1;
-extern struct platform_device s3c64xx_device_spi2;
 
 extern struct platform_device s3c_device_adc;
 extern struct platform_device s3c_device_cfcon;
-- 
2.34.1

