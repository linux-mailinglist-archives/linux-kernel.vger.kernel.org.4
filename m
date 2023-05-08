Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0206F9E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjEHEFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjEHEEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:04:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823605FDA;
        Sun,  7 May 2023 21:04:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso7443273a12.0;
        Sun, 07 May 2023 21:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683518681; x=1686110681;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EHAT0FpwV3AmMbV3FwWi0IRotmMH++8ZC/lSzkodBA=;
        b=geMSnh2vDesRtQzP5cZ6uRXFnNtww8hlBA5Kugl8KRxENtX4dpqiYLyiabSZXjdEy/
         ePuWKENTV+KkKm2iRoxfYfUSxoIxVmjrH8Gm5BDDonPp3mWBCOmMS9AJF1zpecHhqSCD
         oXg5GMaEtLifWEbN8Mg9SzthetubwvBBOkLF8nM8Zb4xgqu5gTGFDJjTkxveeXbUWN35
         elKFwv2kbqzDLfAjr4fBBUD+3coxi1uQlmriHN5eC7ntDZAw6u2CzCgZsAhp3RgX9vA6
         fnpJTaHPV4VaK9RTG/TPmjAhZi9fJX+zfjhTMc2soBA7TMzM9b5QyRPYami7MCmuG1Ij
         6CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683518681; x=1686110681;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EHAT0FpwV3AmMbV3FwWi0IRotmMH++8ZC/lSzkodBA=;
        b=OrHWHsmvjTMett/EZreNU6ibWeSG2mgM3JGpAPbCiQFYwkL9y0TPb3hXLNl2yA5NsA
         nfMuj8nwRtFK8MWMhz6FzbG6XpjTvZpDFM7VpGzaQE1A3yqtKLYSoW9xijTy5ROBV5Zo
         +m33Je7L2iUKqc3g+wy3APrsC79yhlhqEOI/Zncn6GliGsDI1jNmAWYGCymVfVqBJKGC
         I/Ull9STCckSYa1v9hFxFn2p6HHaj34DC7WFlThM4DYpU1+Cl2V9WaJrmPFW3WYe9Sen
         HTZR+8NlFC8MDz/BWiM/QngoU3WskK6QsKt6h9/QvZdoJ7KAvygqxXKCptoMlmBCuHmP
         zN2g==
X-Gm-Message-State: AC+VfDz5hy468p1KFhYf7cPxyST7j2Wi7uqJ3KgL61kXeGHWFW5tYHI0
        4SFo9U8Eh3Wdz1sFm7bKeZ8=
X-Google-Smtp-Source: ACHHUZ7S7/kq9jz38RlRxFDhe5+6ko5+I6KvU/mC4gq9bmtvxlog+Hpmw1DjqBpVwlOOqJKu63i2Kw==
X-Received: by 2002:aa7:d5d5:0:b0:508:4f66:e70d with SMTP id d21-20020aa7d5d5000000b005084f66e70dmr6512173eds.36.1683518680757;
        Sun, 07 May 2023 21:04:40 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:8906:f99a:ce33:2033])
        by smtp.gmail.com with ESMTPSA id f12-20020a05640214cc00b005068fe6f3d8sm5645242edx.87.2023.05.07.21.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 21:04:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        soc@kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ARM: s3c: remove obsolete config S3C64XX_SETUP_IDE
Date:   Mon,  8 May 2023 06:04:33 +0200
Message-Id: <20230508040433.13648-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0d297df03890 ("ARM: s3c: simplify platform code") removes the line
in Makefile.s3c64xx to configure the inclusion of setup-ide-s3c64xx.c,
with CONFIG_S3C64XX_SETUP_IDE. So, since then, config S3C64XX_SETUP_IDE has
no effect and any further purpose.

Remove the obsolete config S3C64XX_SETUP_IDE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-s3c/Kconfig.s3c64xx | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index 01a7a8eec6e8..8f40af063ad6 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -69,11 +69,6 @@ config S3C64XX_SETUP_I2C1
 	help
 	  Common setup code for i2c bus 1.
 
-config S3C64XX_SETUP_IDE
-	bool
-	help
-	  Common setup code for S3C64XX IDE.
-
 config S3C64XX_SETUP_FB_24BPP
 	bool
 	help
@@ -110,7 +105,6 @@ config MACH_WLF_CRAGG_6410
 	select S3C64XX_DEV_SPI0
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_I2C1
-	select S3C64XX_SETUP_IDE
 	select S3C64XX_SETUP_KEYPAD
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_SPI
-- 
2.17.1

