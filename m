Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9546A3FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjB0K6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjB0K6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470CBBA4;
        Mon, 27 Feb 2023 02:58:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h14so5736855wru.4;
        Mon, 27 Feb 2023 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdLIQJlJWnELjON9nBGeYOy/CiIIUc1Jm+enmEwgejU=;
        b=Si7wHOgxp7FKgb9sqtCU1ATOpyTMrA1JejnS6/GufE3c0dXf/ZfUdByyAeIn6RjlHQ
         D+XpFSaQSRB25ckaKlcYMvYcRHJH3gG8MvNzrsazoOQppT4QCjcpIScWMBV/r6brqBY6
         D+N5tgu9Xqg25Vr1S4kLm0yP1ARusLMwD3AR4FF18mPypZO6BgrMgNh9LyVZSRFDaQqM
         P8g8fx1LJTW3luvJcwWIjWVRzCWpyvNhrBMGNK+kW3gZLkz7mxWNtSf18BBC6lIgojTU
         Hq+vGV4Fw2e6qAzyhXofOa/azwN98tEPjMWwmkIMPoBTCzBUlfVoKZE+GtXdU/mGXJg+
         kTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdLIQJlJWnELjON9nBGeYOy/CiIIUc1Jm+enmEwgejU=;
        b=xK/ORg/PhaTN3/OpvvTtq2ZwrXGLWUQFhI0K31Pjal9V7q/xDvA4a/F631hUp+xiZc
         Cq/2T2iT7gZfNVmbERnhYaSyCsT6zFGMWfhhbKtKM9y0yRaCwqxCzj9Ak1YhbWCd2j9V
         9wsD55WiODAOjhgkbQhS8S3CPKUPceVcASWZ2gJCUrALMmWITgKaGBCrL79hIS+Tv+0y
         xx4SvSH8iPefSU7ge+6QooGm1aDNuXNvzOKZJ/AVcuJEhCh97mSsevp0JgD9E5vrSY0v
         CFMPsa4l9fF+uCNTZZo2R71hgOEKqzHKJEpgEQlxL9AxNGIo/6T6SrPboM3vIpVvGNT+
         4UIA==
X-Gm-Message-State: AO0yUKVFxUnYv7iV90W4pFJqbVTXjdEXMRmHRKdaToZtA5PjAd/Bz0xW
        O6fSBRN6G6dZiuwlrMZjUYowgC667aQ=
X-Google-Smtp-Source: AK7set8Wy5J+ZaIXb1rYxVW9GugSr/pTe4HJ7WJLll4S3vSID4GqvvUPBFWuO+dCDpSgEtUJWY5lPQ==
X-Received: by 2002:a05:6000:1287:b0:2c7:a39:6e2e with SMTP id f7-20020a056000128700b002c70a396e2emr15365864wrx.15.1677495493991;
        Mon, 27 Feb 2023 02:58:13 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:13 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 06/12] mips: ralink: rt3883: introduce 'soc_device' initialization
Date:   Mon, 27 Feb 2023 11:58:00 +0100
Message-Id: <20230227105806.2394101-7-sergio.paracuellos@gmail.com>
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

RT3883 SoC have its own 'ralink_soc_info' structure with some
information about the soc itself. In order to be able to retrieve this
information from driver code and avoid architecture dependencies for
retrieving these details introduce this 'soc_device'. Set 'data' pointer
points to the struct 'ralink_soc_info' to be able to export also current
soc information using this mechanism. We need to select 'SOC_BUS' in
Kconfig configuration for these SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/Kconfig  |  1 +
 arch/mips/ralink/rt3883.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 658e12b34ccc..f657e55b10b7 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -37,6 +37,7 @@ choice
 	config SOC_RT3883
 		bool "RT3883"
 		select HAVE_PCI
+		select SOC_BUS
 
 	config SOC_MT7620
 		bool "MT7620/8"
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index 6f8541a4bc8e..cca887af378f 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
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
 	unsigned long cpu_rate, sys_rate;
@@ -112,6 +116,30 @@ static unsigned int __init rt3883_get_soc_rev(void)
 	return (rt3883_get_soc_id() & RT3883_REVID_ECO_ID_MASK);
 }
 
+static int __init rt3883_soc_dev_init(void)
+{
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Ralink";
+	soc_dev_attr->soc_id = rt3883_get_soc_name();
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
+device_initcall(rt3883_soc_dev_init);
+
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
 	if (rt3883_soc_valid())
@@ -131,4 +159,5 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 	soc_info->mem_size_max = RT3883_MEM_SIZE_MAX;
 
 	ralink_soc = RT3883_SOC;
+	soc_info_ptr = soc_info;
 }
-- 
2.25.1

