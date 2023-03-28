Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF46CB3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjC1CT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1CT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:19:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94821984;
        Mon, 27 Mar 2023 19:19:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w4so10257926plg.9;
        Mon, 27 Mar 2023 19:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=JrZiDQCM8obn47HG6nG2G2UpXVKihakdoFKZkex0s0+WFdxEg+P637vEFMh4T+9KI2
         bkumzgsfPG7wTsqf1wWQW+0swBS0Bk+m52AA4IYzHFKLdXqbOAXG6fjE7ZowXHBJmlkP
         mw4WLEsWRPZ279PUzqzehOErdhz8k7ziKHIAQNptdDUajohBhWr0isJo0JVox3X3yiyo
         nrixUIqhi5X7H0jyl3teDep+iWaYJlpmUBPoCLR9TAnoRLb07Phg6aTu1C6zpqYt/0aZ
         EmprwQX3/6eRtDLzoFVh3ZUoe+3hhhwvIraB+K+Gmd6yxQwLruB8qdggUTe2HUuORfsk
         SpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=xI8GYffYZcO0lh+Fl8iyf/is8Zh0YkRUNNbpSqVVnLgIslFkCWiy9tcMV2Callgz/f
         OVlfAszT0zme7r9l3YTOJsrFdVsuEqxvCaHIlrn8UgWQzS8M+piz8vfbiW+q1360SSvi
         gUe8Zo2aEa2LXN8P8ji3XflujqAhtypynwVJztYV7flfLEx/WSoIJRFfQRxW6UGfven/
         6GJ+61APQxrqhduuqlHmWPmpbjgrNWsEAIGxL9EdL5iFudO3KBLFoUH4tVUtfVqjL5ju
         hqgjDJLBO7Fgex9l31Ds13iKpor6NSy1QyFN3LCGI/NP7V3Ip4L9vBO5gt/MCM2pfsnq
         v7iw==
X-Gm-Message-State: AAQBX9cBD5Gu9+I1psNmAphZWgp/jSwsdbxdwNKMK6w3xBLaUv3NWyrE
        oYjMeMP1RaDxE7YKFPSeTQM=
X-Google-Smtp-Source: AKy350YfyhdyweZtFN/BNXq0hVSxafPGhhlEDcagMGpm3IymCcmIgTPyVrsg4P3GnM9R0GxshUeBTQ==
X-Received: by 2002:a17:90b:4c12:b0:23f:7dfb:7dc1 with SMTP id na18-20020a17090b4c1200b0023f7dfb7dc1mr15163422pjb.33.1679969963077;
        Mon, 27 Mar 2023 19:19:23 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:22 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 01/12] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Tue, 28 Mar 2023 02:19:01 +0000
Message-Id: <20230328021912.177301-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/Kconfig.platforms | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 89a0b13b058d..c1f277c05569 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -236,6 +236,15 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_NUVOTON
+	bool "Nuvoton MA35 Platforms"
+	select GPIOLIB
+	select PINCTRL
+	select RESET_CONTROLLER
+	help
+	  This enables support for the ARMv8 based Nuvoton SoCs such
+	  as MA35D1.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.34.1

