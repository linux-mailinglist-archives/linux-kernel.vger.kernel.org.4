Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41026A3FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjB0K7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjB0K6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155D10AAE;
        Mon, 27 Feb 2023 02:58:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so3559817wmq.2;
        Mon, 27 Feb 2023 02:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUIj51PNz0xKbBS1KQE1NGFBEuNj+zGXmUx8EwDrEEo=;
        b=TJYUtDgqq9fjYccEW/VNEByBE9lmodlqJVkF6UoDUTECzXGQdVxmSRkGnC4sgATJ3C
         OpV7BIvpnGMbb7e69N6ba26mdPG9o4UWaAMeMFP2M3c7urK3w3RT4ftZBgAHY1V+DMIL
         90aS0fgh3JohfkogcQBFi2Kt1DY36wNdY9iOzRZ31CUkyzQUPnOEeNrFkdr7ka54XUaM
         /lZ/W9DlOkXM50U25a06s5tX4JAh5Ns5MfDkuDmNC2zWOc7ZgXQJHYBppp5RdzzqQzqe
         EL2rlrcA8QcuAJ6JpAQOpbNh5q4gGhhrZ1/sGnin3kTYE7H/Ixh1OpS0h6FtvSQLqwNs
         NSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUIj51PNz0xKbBS1KQE1NGFBEuNj+zGXmUx8EwDrEEo=;
        b=18PhZNM2JKTkS/imc+fwP4Icb9490dJYlWjPDcXIMJTSq8hvuPk0cTGOzdgUdvMeCR
         7Ma0pJTxVzgMYd49b3V6AWeBzRY9CoZ1bfpFMcYVZ5bGl7qeEe9SSXCcsye4FvRdXdyj
         ZIViPWG2/Q9+mAywtdzBKxS6BufswwBFsddlL674h268vaIpVtiDEZXPJw8kQXjUONdV
         t/eWrpt2ZaTnpvZvq76mXe/BQeDKpWx6uQQcQPSJHDzRKpoC9t1B6RTOpu7lYTkzrlSM
         SuAhTov+6dBUX9nLKRpprZwcGaxFfw4L6GPzXTFEzBVCvIjklC8eJGXiX7AIzY+otZ4g
         yGNw==
X-Gm-Message-State: AO0yUKV5zaTt/40pIH9i7PCG7AXJI7Fol1kyeWlpQBs1oQjjEiADwC10
        UWVGm25s3s9Hszu31V1XThmJbllWpiI=
X-Google-Smtp-Source: AK7set8P3IPV4EDc0sawNE5O19VB7XhcUX9DCeoL6NHPAEmlnNulXRB7DJzxpQ1Nlmp34Q5Xp35isg==
X-Received: by 2002:a05:600c:19cb:b0:3eb:4cb5:e13 with SMTP id u11-20020a05600c19cb00b003eb4cb50e13mr386314wmq.31.1677495499660;
        Mon, 27 Feb 2023 02:58:19 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:19 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 12/12] mips: ralink: mt7620: introduce 'soc_device' initialization
Date:   Mon, 27 Feb 2023 11:58:06 +0100
Message-Id: <20230227105806.2394101-13-sergio.paracuellos@gmail.com>
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

MT7620 SoCs have their own 'ralink_soc_info' structure with some
information about the soc itself. In order to be able to retrieve this
information from driver code and avoid architecture dependencies for
retrieving these details introduce this 'soc_device'. Set 'data' pointer
points to the struct 'ralink_soc_info' to be able to export also current
soc information using this mechanism. We need to select 'SOC_BUS' in
Kconfig configuration for these SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/Kconfig  |  1 +
 arch/mips/ralink/mt7620.c | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 3e01e2df96b0..088d46f16800 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -44,6 +44,7 @@ choice
 		bool "MT7620/8"
 		select CPU_MIPSR2_IRQ_VI
 		select HAVE_PCI
+		select SOC_BUS
 
 	config SOC_MT7621
 		bool "MT7621"
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 8604d91f3375..4435f50b8d24 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/bug.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #include <asm/mipsregs.h>
 #include <asm/mach-ralink/ralink_regs.h>
@@ -49,6 +51,8 @@
 /* does the board have sdram or ddram */
 static int dram_type;
 
+static struct ralink_soc_info *soc_info_ptr;
+
 static __init u32
 mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
 {
@@ -410,6 +414,44 @@ static const char __init *mt7620_get_soc_name(struct ralink_soc_info *soc_info)
 	}
 }
 
+static const char __init *mt7620_get_soc_id_name(void)
+{
+	if (ralink_soc == MT762X_SOC_MT7620A)
+		return "mt7620a";
+	else if (ralink_soc == MT762X_SOC_MT7620N)
+		return "mt7620n";
+	else if (ralink_soc == MT762X_SOC_MT7688)
+		return "mt7688";
+	else if (ralink_soc == MT762X_SOC_MT7628AN)
+		return "mt7628n";
+	else
+		return "invalid";
+}
+
+static int __init mt7620_soc_dev_init(void)
+{
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Ralink";
+	soc_dev_attr->soc_id = mt7620_get_soc_id_name();
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
+device_initcall(mt7620_soc_dev_init);
+
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
 	const char *name = mt7620_get_soc_name(soc_info);
@@ -444,4 +486,6 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 		(pmu0 & PMU_SW_SET) ? ("sw") : ("hw"));
 	pr_info("Digital PMU set to %s control\n",
 		(pmu1 & DIG_SW_SEL) ? ("sw") : ("hw"));
+
+	soc_info_ptr = soc_info;
 }
-- 
2.25.1

