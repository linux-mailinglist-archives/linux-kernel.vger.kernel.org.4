Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859BB6F6377
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEDDhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjEDDhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:37:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F2198A;
        Wed,  3 May 2023 20:37:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24de9c66559so49545a91.0;
        Wed, 03 May 2023 20:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683171456; x=1685763456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=BouU2EJgGelDQw8riSruyKADA1q4XAF76S+xK6/V3U23CPNZ1tp0mJp6coGpB4dUvQ
         P7SnFgFoYWDLh+14xjFm0WUxfA0ZB00kvHJh8WH4y68cBcXWkxitKorJfrrkDXWYGeFG
         fGoRP1HpNsYtjcBxpndQYAq9YMK8Wq1r67oPsClLFCdP1j4hVNqIj6ZRrplDy7ju/za2
         Ec8KIcnpvaV1nJ+mWUDKuaHuMhpmN89IOLLXlwsbs0AdrE/Rq8herNU2TexrXURMUt8n
         V9dMuNBdBPNictE4fr+vw/Ko/L9Dqj7sjQ1dmKNDFL/9BjXIrFgGramvW4/9oVstzo0v
         oBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683171456; x=1685763456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=XP3KXS5NF0Oqhh8/Qtx6WRA/7g2tfrQwc6jCZpoisFKLv7/ZrbLR/E0X4iIf+qbDrs
         aQCSroov9bZEkgwlbV873eDhcCxZyGlj5DVDV6wsgNN3nJaFFToOFmOp1xy1IBI89wjw
         SvT4iRQzjfeWwyyTLeEr//Ba7CgUJM6fUd21KM//MeLoozI6Y+eYOxLowQjJHKTxJmhQ
         ICgYbPjL/iiOXnYb9qZ5TaNKMr/0RFahII5O2gA2dfkovf3Hvnh+27VwesaF3302qTrh
         uVrWPd2sUI57YCCxheRwvnPbA8XovqCR56kuvO7h//KWqUBFxGIYa4OArIu+ycbclFDK
         rHXQ==
X-Gm-Message-State: AC+VfDw9GHk2Xzul5rn1g7yTz728UvTVT0ulpOrvBEYnZ6I6d7k5v/zS
        7evdj23/pCXCojQVWlU2hp4=
X-Google-Smtp-Source: ACHHUZ6TNisKLsFOFGSX2LVcYmEdkYNgygVGFYagwlzvTEgn2hxs5nhbyqbYozghQxD5bG2tVU31Ng==
X-Received: by 2002:a17:903:230e:b0:19d:778:ff5 with SMTP id d14-20020a170903230e00b0019d07780ff5mr2662950plh.15.1683171456228;
        Wed, 03 May 2023 20:37:36 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001ab849b46d3sm468761plb.178.2023.05.03.20.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:37:35 -0700 (PDT)
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
Subject: [PATCH v9 01/10] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Thu,  4 May 2023 03:37:17 +0000
Message-Id: <20230504033726.93-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504033726.93-1-ychuang570808@gmail.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
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

