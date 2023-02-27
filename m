Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A746A3FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjB0K6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjB0K6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97449CA37;
        Mon, 27 Feb 2023 02:58:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h14so5736883wru.4;
        Mon, 27 Feb 2023 02:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=job8OjNMmgGAToT54F6bhg5jAGzIyUdmtqvbHKYK1dE=;
        b=Dq5nTkrv4NsOu2ZhEiH1eT4O+XdbX5EPH3rS+KF0eEt3F/81ZXxFmNFQOVZSALlAbq
         KU95NDES7wkBgmUbjb9L2pypbQEQvxcdzXecOKm9UWRgfX0VIhkyu80qHvsyCIvVLV4K
         vJ/FGhO9baaKJlebaeWrSy1VxmyGE3QifeWyG1gsA+jDFjKmUQiPg59SHa+UQWqoSIfa
         HzvEUCH9W3bzthq9VohIkQlC2KnVbw8hkrGPxW+JCaWpnsC3coovH82rka3IW/OiQHws
         ERWZwoDxByiQzvBAIn83vg2mSZJWNucimNzaAU28m12qTF11a3vVsZlYBf+MMmk14PM+
         hX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=job8OjNMmgGAToT54F6bhg5jAGzIyUdmtqvbHKYK1dE=;
        b=XegnYYCYggxx4JefFIEekLRz4DyNSQcE26LenCniAgNuYqbYbsYBYYAzmV1fKAw5Lb
         RoRncQZAVTxvr46VL5rwN1lPPKeJJ3a3GHRMC5PhtNXjRfTqXczfJKS9UCjFqYXIvUzS
         o790suGamS/OLx5FwaY+fb4dkTBEsa4zBUhkmubGBAH0kgcbxHdD1+XUa6TFpJ5QZcSb
         LzDP55MRlLRdV9dLr+zS6QjNZiwF7HDWKdsnFsg0vheAL1upqHz4Gt5JMRgtjRPvU9OG
         fwwz6w6LxzXrPSxMGz52cdSGI3n31uK7AMO9dN4+b/ieA5RILMoog01hmKaDvlhE0UV4
         Iypg==
X-Gm-Message-State: AO0yUKVmKiMKbOUFUofWoT8JIY+Ju2f0s65mUDEmoshZ+A0pBWzqZ07r
        S8cM36mI6Mogpz4U8FR7GOiibtVVG7g=
X-Google-Smtp-Source: AK7set/Svomg/t/SIOSOkAXql0lxaZjxzyOXD3Ly6NJKJ/Y6mqXBwLAxQg50AYQ4UYRc/GAOLNwgiw==
X-Received: by 2002:adf:eacd:0:b0:2c7:107c:e172 with SMTP id o13-20020adfeacd000000b002c7107ce172mr11744605wrn.41.1677495494879;
        Mon, 27 Feb 2023 02:58:14 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:14 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 07/12]  mips: ralink: rt288x: define RT2880_SYSC_BASE with __iomem
Date:   Mon, 27 Feb 2023 11:58:01 +0100
Message-Id: <20230227105806.2394101-8-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
References: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 So that RT2880_SYSC_BASE can be used later in multiple functions without
 needing to repeat this __iomem declaration each time

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/rt288x.h | 3 ++-
 arch/mips/ralink/rt288x.c                  | 7 +++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt288x.h b/arch/mips/include/asm/mach-ralink/rt288x.h
index 5f213534f0f5..66a999cd1d80 100644
--- a/arch/mips/include/asm/mach-ralink/rt288x.h
+++ b/arch/mips/include/asm/mach-ralink/rt288x.h
@@ -11,7 +11,8 @@
 #ifndef _RT288X_REGS_H_
 #define _RT288X_REGS_H_
 
-#define RT2880_SYSC_BASE		0x00300000
+#define IOMEM(x)			((void __iomem *)(KSEG1ADDR(x)))
+#define RT2880_SYSC_BASE		IOMEM(0x00300000)
 
 #define SYSC_REG_CHIP_NAME0		0x00
 #define SYSC_REG_CHIP_NAME1		0x04
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 493335db2fe1..12f339138c4c 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -59,15 +59,14 @@ void __init ralink_of_remap(void)
 
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
-	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT2880_SYSC_BASE);
 	const char *name;
 	u32 n0;
 	u32 n1;
 	u32 id;
 
-	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
-	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
-	id = __raw_readl(sysc + SYSC_REG_CHIP_ID);
+	n0 = __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+	n1 = __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_NAME1);
+	id = __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_ID);
 
 	if (n0 == RT2880_CHIP_NAME0 && n1 == RT2880_CHIP_NAME1) {
 		soc_info->compatible = "ralink,r2880-soc";
-- 
2.25.1

