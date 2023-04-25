Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E06EE02A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjDYKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjDYKY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:24:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD27FF;
        Tue, 25 Apr 2023 03:24:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so4677337b3a.2;
        Tue, 25 Apr 2023 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682418268; x=1685010268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=nw1Cc3SvvnkxZ493q//Rs/ADiMgtbxDiXoh0f7wZNN275/44c51Pfw6iEQi8G7OFEm
         7DU2pwgQdPqJMQZvMBstGwJ8OrI5q133reUXv2hBLUKvz2MS13c1G5s0+UA8REs1EOxP
         cg653T/L0cLD3GddIpW4VowmusXgHNzh1iPNwmz8w+2kD0j2Z+TPGzD7hMHxLoH0nbk4
         i5RJARD1MqumJ5a2tyAABb6OdaDzqcO5VrhDmzxcLRA6IcXeJRraEMYONwOjZZX8muhD
         pkZyvRftJdJn7CmOtW7tCz5EDpRKouiYyFLxyZwlLpkgJKFGDDiBP6TOoRbXRWqaakxY
         xSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418268; x=1685010268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=T0wRPnpoY37PxFZ2ulLwU8PzihRE1I+WNFM6UViYMTboQOw+PRIOBAjV8EhBi10brM
         v6EwZrYsZ+bzSCjc33brvWG1UlwiOP5Jk+2XnygEid3QcVX8NPDQ9zzGvdpKFnf1Y2Ol
         4TC2uUVYTftirEy9eHLNF9YuHzX4hy71SRO/h1BbEEZ0fiZDuQ3vYHmv1EcVF4F/Nu4U
         dABtmvJ/OfMXC/1bNNB6Eh7SFAfMpWjpkBqemPlbiTj5kQDu4sxwNlk78aI+vyXBKQxq
         vUJaWwgyfGcu99mg95Qe3d6pkU+i9JBNlE3IBHGFkmNYjTchouf0tCN4NzOv9AAye9ND
         6/JA==
X-Gm-Message-State: AAQBX9cjird4tY9sH8xVw+Zg0fcl/pDALBrKoPtfWnVJ/te+aTDCoMMV
        0HSZ2+qPGx+7GnHNNwGx7Q4=
X-Google-Smtp-Source: AKy350Ya6koe34pMKu0Lw5ZDOgszwAiwAuoR9ChAelgyJ7/bOkB6sqim2SObSAXD2D3xr6Sk7aW2nQ==
X-Received: by 2002:a05:6a21:3988:b0:ef:f558:b7d with SMTP id ad8-20020a056a21398800b000eff5580b7dmr15226701pzc.59.1682418268018;
        Tue, 25 Apr 2023 03:24:28 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 30-20020a63125e000000b0051b70c8d446sm7644715pgs.73.2023.04.25.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 03:24:27 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v8 01/11] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Tue, 25 Apr 2023 10:24:08 +0000
Message-Id: <20230425102418.185783-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425102418.185783-1-ychuang570808@gmail.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

