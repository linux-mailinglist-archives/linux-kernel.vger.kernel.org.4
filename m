Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916DD6A3FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjB0K6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjB0K6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2259199DC;
        Mon, 27 Feb 2023 02:58:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v16so2929834wrn.0;
        Mon, 27 Feb 2023 02:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+BgnLruvamK2++KZsoFKmP2nKS18Ke5ejpmduGAEa8=;
        b=bsA9jGbaN8/IzJibEXpIpiU+I4jQ5MyTYNC5aKwo5JfsIU+U+UpYJkku4o75VITbfT
         ztIb5Gt7dd3veZMIBVrtHFRL5U68PzSuNGSGf2lo1InFqhgU19onwegovG3b95B9eV0y
         QYhE/dUY2xQvT6LYHaQzIJWhAgnZNMKKAuRbGpISLFJLdhbMGgY0YUjCemXH9KkOgGbH
         2G7qMOHCT6Aj+ZJZwml/a3UjFgmE99SF/k4/qaZmXajqVJBIe82pYjQbtsHluxO7vq6l
         9qUeC5enc6s54FrGL6i9I3h2G//xTCIcsNdMbKwKYuFyhQRMDBOb1gbidWZGzBO4f/Sf
         ov5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+BgnLruvamK2++KZsoFKmP2nKS18Ke5ejpmduGAEa8=;
        b=Ao3EKhMqdjtOb/lK93CTfSO7F9CR73BDrOpHqAQ+fuiLk69ueWgXinMXc2jRXjF5Wf
         hT/IcSaEM6TjK5fHkPviT8OVWjQv7biu8qzQRYiLO9Yrj3tkf3j0VvHfY41ekArMt3fz
         0A5inTBffaLoESpAJKCX97pZnjp6gNiEmHkGK00FX6sHK5yZ5WU747QXSyyATaV6/Hdj
         dSB78543jPJvW/iDjK/E41Xw44OZFl681XTyAqPrOOz/nMVp5vnevepBCHe/S3DnDNje
         aQZ8jrI3/YMgPvI3odr6Bg1W61wCsHnEWKbHG8hkEpr1dlEZgp7Uui6YPOdx0FN7ztzD
         sJ2g==
X-Gm-Message-State: AO0yUKU5K+iv7BVcWUjlrqF0O2QmE5rl8y1/JcLXf79GXixhcBUNmRDU
        J7Hmj4R/+Tw+DmMJo9APR9aaF4DVDbI=
X-Google-Smtp-Source: AK7set+0++ntSAzlqXozngN8qg3LJc/I6BmsBNjR85BiuQQzSfrPyYT4TaQ1bK1QsbwF9A9+M88qAw==
X-Received: by 2002:adf:f0cd:0:b0:2c7:d75:373a with SMTP id x13-20020adff0cd000000b002c70d75373amr14358125wro.1.1677495496839;
        Mon, 27 Feb 2023 02:58:16 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:16 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 09/12] mips: ralink: rt288x: introduce 'soc_device' initialization
Date:   Mon, 27 Feb 2023 11:58:03 +0100
Message-Id: <20230227105806.2394101-10-sergio.paracuellos@gmail.com>
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

RT288X SoCs have their own 'ralink_soc_info' structure with some
information about the soc itself. In order to be able to retrieve this
information from driver code and avoid architecture dependencies for
retrieving these details introduce this 'soc_device'. Set 'data' pointer
points to the struct 'ralink_soc_info' to be able to export also current
soc information using this mechanism. We need to select 'SOC_BUS' in
Kconfig configuration for these SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/Kconfig  |  1 +
 arch/mips/ralink/rt288x.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index f657e55b10b7..3e01e2df96b0 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -29,6 +29,7 @@ choice
 		select MIPS_AUTO_PFN_OFFSET
 		select MIPS_L1_CACHE_SHIFT_4
 		select HAVE_PCI
+		select SOC_BUS
 
 	config SOC_RT305X
 		bool "RT305x"
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index a417b8b89b94..456ba0b2599e 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -10,6 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #include <asm/mipsregs.h>
 #include <asm/mach-ralink/ralink_regs.h>
@@ -17,6 +19,8 @@
 
 #include "common.h"
 
+static struct ralink_soc_info *soc_info_ptr;
+
 void __init ralink_clk_init(void)
 {
 	unsigned long cpu_rate, wmac_rate = 40000000;
@@ -98,6 +102,31 @@ static unsigned int __init rt2880_get_soc_rev(void)
 {
 	return (rt2880_get_soc_id() & CHIP_ID_REV_MASK);
 }
+
+static int __init rt2880_soc_dev_init(void)
+{
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Ralink";
+	soc_dev_attr->soc_id = rt2880_get_soc_name();
+
+	soc_dev_attr->data = soc_info_ptr;
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	return 0;
+}
+device_initcall(rt2880_soc_dev_init);
+
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
 	if (rt2880_soc_valid())
@@ -117,4 +146,5 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 	soc_info->mem_size_max = RT2880_MEM_SIZE_MAX;
 
 	ralink_soc = RT2880_SOC;
+	soc_info_ptr = soc_info;
 }
-- 
2.25.1

