Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58A974AF8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjGGLNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGGLNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:13:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AC5172B;
        Fri,  7 Jul 2023 04:13:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b2886364so12064595ad.0;
        Fri, 07 Jul 2023 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688728386; x=1691320386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OTQ5yVTxRtYhECJ+X/PAMcN/OJn5QRTMtMnEyGTaoQ=;
        b=cxlLr2uqLFB+CMrQVjH7ufhUN7nH1eyHHotc9UGsBrhoe4i9RvkhADjSMvv9s1VPe1
         /r9jAhniYZarvErD462L/QnwTMlCEq+F1CbvH3Cy0cQwDI2eng0dVDyEJf7J7Eu5maXZ
         ACIPo8di+OfIf0b+qNHg+n1j7a6GTiZNYTtXbHgpOthS4BrRso5l0lQ6zIikflMRdjYE
         DoHupI/eDN3OtOe07elF20CuP0+1m1ncqRpRr5Owa6opPSJ4lOAAhbugAbY49FRTdzb9
         ONICtVLwA1CH9wUWU3NzDRM/huOgnk2g8PQAVZEtvuV/tBz8jGk116m+W0uF8YP7rCMc
         3ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688728386; x=1691320386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OTQ5yVTxRtYhECJ+X/PAMcN/OJn5QRTMtMnEyGTaoQ=;
        b=gt63mupuSq+yjI9rmHwl+HCqcTSlNPHC/md1LnDEwxZ4nFw5q2bNLDnXChl85xAQ+v
         uf6TZ9zTvYoRnZWqpvw7WXQavF4x5DfQ3FGHYCubjmvQYoaeyS8K0wg0BLyqUaFs8HOp
         b2GK283JL9G1lTbZicLEA/rMn3Bbww1ax3B1+pBvHEc5F0HD/a0OUy53/ER1qizzlEao
         c/cMogLmEZlfVXW+Z87t2cKufsWH5oQ9/D95hJDlmlfxEBaQg2ChAlY8GpE6qVPBJLq/
         1PQVgzFxCh8dulTQB8q5U7VD3XAVaZk9rSk+hmEMia8nWXnw9Au1lK/ogtVVhcJpZ4/x
         mHgA==
X-Gm-Message-State: ABy/qLYTMpsuIwwve2ibg4NM014gTooLZQOyTuc7urjboxcsOvRywNnc
        a1FuM9MFmoorl6Vq3AxJCmxGNsk4rhp1/A==
X-Google-Smtp-Source: APBJJlED83Y2vl/tQgc3I+AWlTf2aabPEGfWMiPfbbx7owHQUrm2sY6GGwAc4UBUAXD3lOiPTUw5Pg==
X-Received: by 2002:a17:902:a411:b0:1b8:5fb4:1c85 with SMTP id p17-20020a170902a41100b001b85fb41c85mr3803435plq.16.1688728386509;
        Fri, 07 Jul 2023 04:13:06 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902744c00b001b8c8d06285sm1985639plt.122.2023.07.07.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:13:06 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 1/2] MIPS: loongson32: Remove regs-clk.h
Date:   Fri,  7 Jul 2023 19:11:50 +0800
Message-Id: <20230707111151.461373-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707111151.461373-1-keguang.zhang@gmail.com>
References: <20230707111151.461373-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c46496119ed0 ("clk: loongson1: Remove
the outdated driver"), no one is using regs-clk.h.
Therefore, remove this obsolete header file.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../include/asm/mach-loongson32/loongson1.h   |  1 -
 .../include/asm/mach-loongson32/regs-clk.h    | 81 -------------------
 2 files changed, 82 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-clk.h

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 7971272345d3..bc27fcee3176 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -45,7 +45,6 @@
 #define LS1X_NAND_BASE			0x1fe78000
 #define LS1X_CLK_BASE			0x1fe78030
 
-#include <regs-clk.h>
 #include <regs-mux.h>
 #include <regs-rtc.h>
 
diff --git a/arch/mips/include/asm/mach-loongson32/regs-clk.h b/arch/mips/include/asm/mach-loongson32/regs-clk.h
deleted file mode 100644
index 98136fa8bee1..000000000000
--- a/arch/mips/include/asm/mach-loongson32/regs-clk.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 Clock Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_CLK_H
-#define __ASM_MACH_LOONGSON32_REGS_CLK_H
-
-#define LS1X_CLK_REG(x) \
-		((void __iomem *)KSEG1ADDR(LS1X_CLK_BASE + (x)))
-
-#define LS1X_CLK_PLL_FREQ		LS1X_CLK_REG(0x0)
-#define LS1X_CLK_PLL_DIV		LS1X_CLK_REG(0x4)
-
-#if defined(CONFIG_LOONGSON1_LS1B)
-/* Clock PLL Divisor Register Bits */
-#define DIV_DC_EN			BIT(31)
-#define DIV_DC_RST			BIT(30)
-#define DIV_CPU_EN			BIT(25)
-#define DIV_CPU_RST			BIT(24)
-#define DIV_DDR_EN			BIT(19)
-#define DIV_DDR_RST			BIT(18)
-#define RST_DC_EN			BIT(5)
-#define RST_DC				BIT(4)
-#define RST_DDR_EN			BIT(3)
-#define RST_DDR				BIT(2)
-#define RST_CPU_EN			BIT(1)
-#define RST_CPU				BIT(0)
-
-#define DIV_DC_SHIFT			26
-#define DIV_CPU_SHIFT			20
-#define DIV_DDR_SHIFT			14
-
-#define DIV_DC_WIDTH			4
-#define DIV_CPU_WIDTH			4
-#define DIV_DDR_WIDTH			4
-
-#define BYPASS_DC_SHIFT			12
-#define BYPASS_DDR_SHIFT		10
-#define BYPASS_CPU_SHIFT		8
-
-#define BYPASS_DC_WIDTH			1
-#define BYPASS_DDR_WIDTH		1
-#define BYPASS_CPU_WIDTH		1
-
-#elif defined(CONFIG_LOONGSON1_LS1C)
-/* PLL/SDRAM Frequency configuration register Bits */
-#define PLL_VALID			BIT(31)
-#define FRAC_N				GENMASK(23, 16)
-#define RST_TIME			GENMASK(3, 2)
-#define SDRAM_DIV			GENMASK(1, 0)
-
-/* CPU/CAMERA/DC Frequency configuration register Bits */
-#define DIV_DC_EN			BIT(31)
-#define DIV_DC				GENMASK(30, 24)
-#define DIV_CAM_EN			BIT(23)
-#define DIV_CAM				GENMASK(22, 16)
-#define DIV_CPU_EN			BIT(15)
-#define DIV_CPU				GENMASK(14, 8)
-#define DIV_DC_SEL_EN			BIT(5)
-#define DIV_DC_SEL			BIT(4)
-#define DIV_CAM_SEL_EN			BIT(3)
-#define DIV_CAM_SEL			BIT(2)
-#define DIV_CPU_SEL_EN			BIT(1)
-#define DIV_CPU_SEL			BIT(0)
-
-#define DIV_DC_SHIFT			24
-#define DIV_CAM_SHIFT			16
-#define DIV_CPU_SHIFT			8
-#define DIV_DDR_SHIFT			0
-
-#define DIV_DC_WIDTH			7
-#define DIV_CAM_WIDTH			7
-#define DIV_CPU_WIDTH			7
-#define DIV_DDR_WIDTH			2
-
-#endif
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_CLK_H */
-- 
2.39.2

