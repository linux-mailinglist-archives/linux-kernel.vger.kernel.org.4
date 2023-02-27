Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9174C6A3FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjB0K6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjB0K6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E969CCA37;
        Mon, 27 Feb 2023 02:58:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t15so5728593wrz.7;
        Mon, 27 Feb 2023 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfZlvyD8rTZQbpQrkIlLlvAbU21XIuea0Ob/RtnHs1U=;
        b=kif3rjC5DZzlITC9ZiIlLLV1GPEFuq0QTF4KSI0Pap7DXwFdqaW0rTfovI/5Y99mzT
         Yt+TbxPB+blULAQNX3feY4zpOdFl2aK5lbsxmXcXOP8Z+0J5u+il/lP4iRXWXd4GxK3N
         GuUr8ZCoztrHQdovCqWGLWgRfdATvAKh8BkJAKiZoZTq/lwewdbcvRjNB3w5hPQaablF
         mAfT6Lq7jH3wCaJS4nN/2bdZny9GEpCUegYb7aS1ucnrg+8m/S7pGEq9ag0/KGHChXvw
         KLS9oy1N6xQZaqiM6Rm5sfWELjVnWl56Nxa+g8xZOTsuaeKsaLqGqjHEeenlkwWjileC
         1oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfZlvyD8rTZQbpQrkIlLlvAbU21XIuea0Ob/RtnHs1U=;
        b=Vs/kuNGd046+aQ/fcCvQ2ssztVz6SCJRmB6IvP3w+nBtB2MVtL0sGmyPPWuUKN6DrD
         U7trAyTaZ+EXu0vHDPITI+Wt7jVvpeHgIDsGlrdtZejq7enzutyIPQttmQQA4oVy4rT7
         IebLT761Ryqk1+iXSqWrGX1HL5gl/uWALgiZ72s8PKPqmER61EP/+tZAe4VN4IhVY64k
         JM1iAvqqTDgw1OfexJaN2Rs8EzA6arn1Nm0J0iOybFjuHLMGj8UbkA7Lct40V5pyu9jU
         PAHlDe5KRkoS08BEAV59T+BHUqN1GJRik19khqX0PaIYipJoL9IMuaxMVQijDhmydU+9
         NirQ==
X-Gm-Message-State: AO0yUKVCt8t/uvD/VEsKwFICOms1uzvyVCiWmDrOdjuo2PWWxFfj8Mlu
        l1x9eBOgHjoYVfQ1Ez/xLGYSmMmqajM=
X-Google-Smtp-Source: AK7set/yOo+O4Atmx3ogx4palFZ4WkH53bAEddE4+yuzkAbiT1njKJ9z0G5mtmVx8ef5JkPjeaBJUg==
X-Received: by 2002:adf:e58f:0:b0:2c5:a07e:4bb6 with SMTP id l15-20020adfe58f000000b002c5a07e4bb6mr20110631wrm.33.1677495491221;
        Mon, 27 Feb 2023 02:58:11 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:10 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 03/12] mips: ralink: rt305x: introduce 'soc_device' initialization
Date:   Mon, 27 Feb 2023 11:57:57 +0100
Message-Id: <20230227105806.2394101-4-sergio.paracuellos@gmail.com>
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

RT305x SoCs have their own 'ralink_soc_info' structure with some
information about the soc itself. In order to be able to retrieve this
information from driver code and avoid architecture dependencies for
retrieving these details introduce this 'soc_device'. Set 'data' pointer
points to the struct 'ralink_soc_info' to be able to export also current
soc information using this mechanism. We need to select 'SOC_BUS' in
Kconfig configuration for these SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/Kconfig  |  1 +
 arch/mips/ralink/rt305x.c | 46 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 06031796c87b..658e12b34ccc 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -32,6 +32,7 @@ choice
 
 	config SOC_RT305X
 		bool "RT305x"
+		select SOC_BUS
 
 	config SOC_RT3883
 		bool "RT3883"
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index a24143c739ee..d8dcc5cc66cc 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/bug.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #include <asm/io.h>
 #include <asm/mipsregs.h>
@@ -19,6 +21,8 @@
 
 #include "common.h"
 
+static struct ralink_soc_info *soc_info_ptr;
+
 static unsigned long rt5350_get_mem_size(void)
 {
 	unsigned long ret;
@@ -233,6 +237,46 @@ static unsigned int __init rt305x_get_soc_rev(void)
 	return (rt305x_get_soc_id() & CHIP_ID_REV_MASK);
 }
 
+static const char __init *rt305x_get_soc_id_name(void)
+{
+	if (soc_is_rt3050())
+		return "rt3050";
+	else if (soc_is_rt3052())
+		return "rt3052";
+	else if (soc_is_rt3350())
+		return "rt3350";
+	else if (soc_is_rt3352())
+		return "rt3352";
+	else if (soc_is_rt5350())
+		return "rt5350";
+	else
+		return "invalid";
+}
+
+static int __init rt305x_soc_dev_init(void)
+{
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Ralink";
+	soc_dev_attr->soc_id = rt305x_get_soc_id_name();
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
+device_initcall(rt305x_soc_dev_init);
+
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
 	const char *name = rt305x_get_soc_name(soc_info);
@@ -253,4 +297,6 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 		soc_info->mem_size_min = RT3352_MEM_SIZE_MIN;
 		soc_info->mem_size_max = RT3352_MEM_SIZE_MAX;
 	}
+
+	soc_info_ptr = soc_info;
 }
-- 
2.25.1

