Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F056A3FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjB0K6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjB0K6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D529EE4;
        Mon, 27 Feb 2023 02:58:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bv17so5737300wrb.5;
        Mon, 27 Feb 2023 02:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnZe77O04Wi6t00vWipQfVmBBAx1Is2ZWNAespWbpaw=;
        b=gMaVrmBNFyZA3PKVfkLWgfaalbAd8Iy1p5KsCpUsbm85PHastzbtDAl8dn+P55Y2/N
         groYWNXgCK8nz7t8AfZmBuqs9doqafgO3UCw/xy8SmtKIxcaWg0OmvVB2fyCDqqqDwNQ
         fFjfLswzGYYBKIZ4XFWn1ddhu6rhz6vGgmiG1738foG6NDlEbyfmRySI8TuRwknXTz4x
         BDUbR6S7ggOtMroz9hPVKPkiiVVrcWFyAEhCYML+HCZaR/GNaL14oFe9g3LrkPBlh3/U
         j2Pl9Ez6zH7ipZVs41BIyN81tEPAGN56gRzHsdQiVZjvp0/RoZZ4yMLs353NEJdIkPCY
         9CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnZe77O04Wi6t00vWipQfVmBBAx1Is2ZWNAespWbpaw=;
        b=y0BELKDvHiJ1LeHHnXDDDdPcgSu6QJITBjw+wDjb0rvlnpPNHx6IbZdkwh54W3fsEi
         ZjFjAHt4AJjAPFuUhAbW2znaKdm8ankPKKNX69zoGyryGLNJC1QoZSQKn4QIwAUX6ym0
         vZRacu6CV2KTl4m+LbmawWJV3e2sSQbUjuZFUw//Rcs5ixal4bqYSCTPaB1BHgNNpkbC
         325Wcg+ovUo+9UsahC+gM9wKS03cRRSmSlJd9bk5dX7aii3Kh4I6d4uRO66yj/+YYEDa
         kMG3qcp4J1xGcQqcISuRv/KtkUI7AC2ybZ3kzjohtLoBuNx274GeQXvhM+kggIOh8ChJ
         BVzg==
X-Gm-Message-State: AO0yUKVtuqIvAipHLQKS+sCv3XcJv+ZbhT41et+ZnP5TplmqSLDMAXQ5
        Hhwjdo/K131S6ImuvMAMlMXmR2xLhW4=
X-Google-Smtp-Source: AK7set82GupIzkEIFy4bqPqu5a4V4MV3GEeXP9Z94MdMh3GAhpGZa6uMALcC1OuWntCgvHNphosmtA==
X-Received: by 2002:adf:f247:0:b0:2c7:1e00:d514 with SMTP id b7-20020adff247000000b002c71e00d514mr11484247wrp.38.1677495489091;
        Mon, 27 Feb 2023 02:58:09 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:08 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 01/12] mips: ralink: rt305x: define RT305X_SYSC_BASE with __iomem
Date:   Mon, 27 Feb 2023 11:57:55 +0100
Message-Id: <20230227105806.2394101-2-sergio.paracuellos@gmail.com>
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

So that RT305X_SYSC_BASE can be used later in multiple functions without
needing to repeat this __iomem declaration each time

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/rt305x.h | 3 ++-
 arch/mips/ralink/rt305x.c                  | 8 +++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
index 4d8e8c8d83ce..ef58f7bff957 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x.h
@@ -43,7 +43,8 @@ static inline int soc_is_rt5350(void)
 	return ralink_soc == RT305X_SOC_RT5350;
 }
 
-#define RT305X_SYSC_BASE		0x10000000
+#define IOMEM(x)			((void __iomem *)(KSEG1ADDR(x)))
+#define RT305X_SYSC_BASE		IOMEM(0x10000000)
 
 #define SYSC_REG_CHIP_NAME0		0x00
 #define SYSC_REG_CHIP_NAME1		0x04
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 8b095a9dcb15..135a46517763 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -21,11 +21,10 @@
 
 static unsigned long rt5350_get_mem_size(void)
 {
-	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT305X_SYSC_BASE);
 	unsigned long ret;
 	u32 t;
 
-	t = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG);
+	t = __raw_readl(RT305X_SYSC_BASE + SYSC_REG_SYSTEM_CONFIG);
 	t = (t >> RT5350_SYSCFG0_DRAM_SIZE_SHIFT) &
 		RT5350_SYSCFG0_DRAM_SIZE_MASK;
 
@@ -142,14 +141,13 @@ void __init ralink_of_remap(void)
 
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
-	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT305X_SYSC_BASE);
 	unsigned char *name;
 	u32 n0;
 	u32 n1;
 	u32 id;
 
-	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
-	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
+	n0 = __raw_readl(RT305X_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+	n1 = __raw_readl(RT305X_SYSC_BASE + SYSC_REG_CHIP_NAME1);
 
 	if (n0 == RT3052_CHIP_NAME0 && n1 == RT3052_CHIP_NAME1) {
 		unsigned long icache_sets;
-- 
2.25.1

