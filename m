Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0072B569
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjFLC1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjFLC1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:27:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4DCA4;
        Sun, 11 Jun 2023 19:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu5fi6YHpRnRyRbvMrecRgVUq5tVc8+DSq1Pwg+lzphCaxWtGohySkcuuraAjC9AVSPz2TCCDNDLkkSyCAQZXHhtoRf53D8s5glYY+whOsnlkhN2HNVNHsCvccbOcVapOKrGeZFbmuRjYcul5ZzdIQ0DSTQ4cOGRWJB2KzQy1KQbkiajHk0eIM7Zr73X43kK7JNF7r5ni9k7i2Dr6MptDhPnjQuB23JSsq+T2QiM3Gtj/j7pKpr+7mpuJU2LLCo0aW/IvtIo3+OiP0HoHe1+uGaE05yhAK2+JEQgzZ59Gs+QGVOt/9YIyFBabPDzgwu0o0aNN9NxrSzOOb2VykknYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/acxFV5WYJetHLiChIfApaoz3J1/EP44+SK1PX6q+AY=;
 b=JlsJ14+SfKRCPkBCPYQk4XeVK9T3emJdsMkNQqbLhuqlHpPi/oIWrQtutQ99jJGddz/hKi6GEV4+igKKeRL4qlA+PgIHXThF8gpiHEScjzAVQTk4wZGGyi+IDtkHiQUBf/3fppO7DEFYmvPdYd25ZvB0APaqMtkCaaNPqbZMPUqdT8VTVpsyuTFWaaRuUbobLEAkh1QwJUF6yK5wrNHCMWAtUSYj0qZVdqzn7lYuoS4k44LutkFpkJhDBVjZaUtbyAGRNcxAk4YLWEGInnRkB2hJVpoXB8ALbX2xrhlQdiin1xGjyE/24k9ZXisT8SNfABOiLGKepvXo6qp63rh+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.147.44.15) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=tw.synaptics.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=tw.synaptics.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/acxFV5WYJetHLiChIfApaoz3J1/EP44+SK1PX6q+AY=;
 b=TwAay8n/fhuWhxb9z4Rd4cNJvtrDoq3G+m4u5YCm3yWWDBPgnjPetHt54BnK9D/dw0GlKNghacxL1eZmK+bbGucduwi60n92YAbVXMSN8D6uDXXMJ14GFvqO3pWy9Zuq8TJqVK46WLD2RRJmmyYNGOHvk1xF1C+n3TPC1raZcM0=
Received: from BN9PR03CA0400.namprd03.prod.outlook.com (2603:10b6:408:111::15)
 by PH7PR03MB7488.namprd03.prod.outlook.com (2603:10b6:510:2eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 02:26:55 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::33) by BN9PR03CA0400.outlook.office365.com
 (2603:10b6:408:111::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 02:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.147.44.15)
 smtp.mailfrom=tw.synaptics.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=tw.synaptics.com;
Received-SPF: Pass (protection.outlook.com: domain of tw.synaptics.com
 designates 192.147.44.15 as permitted sender)
 receiver=protection.outlook.com; client-ip=192.147.44.15;
 helo=sjc1wvp-mail01.synaptics-inc.local; pr=C
Received: from sjc1wvp-mail01.synaptics-inc.local (192.147.44.15) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 02:26:54 +0000
Received: from sjc1wvp-mail04.synaptics-inc.local (10.20.24.185) by
 sjc1wvp-mail01.synaptics-inc.local (10.20.24.252) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sun, 11 Jun 2023 19:26:12 -0700
Received: from sjc1wvp-mail01.synaptics-inc.local (10.20.24.252) by
 sjc1wvp-mail04.synaptics-inc.local (10.20.24.185) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sun, 11 Jun 2023 19:26:11 -0700
Received: from sjc1uvd-bld04.synaptics.com (10.20.70.64) by
 sjc1wvp-mail01.synaptics-inc.local (10.20.24.252) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Sun, 11 Jun 2023 19:26:11 -0700
From:   Marge Yang <marge.yang@tw.synaptics.com>
To:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marge.yang@tw.synaptics.com>
CC:     <david.chiu@tw.synaptics.com>, <derek.cheng@tw.synaptics.com>,
        <sam.tsai@synaptics.com>, <vincent.huang@tw.synaptics.com>
Subject: [PATCH V2] Input: synaptics-rmi4- Add a new feature for Forepad.
Date:   Mon, 12 Jun 2023 02:26:07 +0000
Message-ID: <20230612022607.315149-1-marge.yang@tw.synaptics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|PH7PR03MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 663ba9f7-5996-4e2d-453f-08db6aec7d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4Z55aMczf/+0rJ17y1uFqnw5LuTz8XDmGRsSB3RF3h/TaK3RLkce7Z5v4eML2DcoCrs/w1QPfKJwIHDaO6cm12wVhQG0E1lavY9weKueEVVkQjKGsWR1eB7G0vHzZew5A8Jcc6/cexG+kHNSp3iZ4yXkvjl9wJ7Etmexp2S1Xxl5e76QGKoNdEatfEceJ0odMdtgKvpvU1exVblfnMmrF9Hxi71sbpfXHPdTvREWaALU9HpdIwCXNpHwD1T6U+/m/a0yH8bHil96N1eoR6ds2SjCOMvhRbyXQHtGErV2dpkgEN1rKcNLf4upjPmHW0eVhMUSOgih2SJVkCRz//ZWL8M3Z4d91o5ljYQoyACvd4+GL0mU5o/kw4w7fbmfSs/0l2c2nIhTstVh6VVLnmGwNswh3voZDZTM5FQllvxWP4o/Nr939Vyp7+l6aZSSMsplXDaWtByWoq8eSGKC5G1GbnnV20rAfna8E5O/ids/soih8gwlyX3JCQH3UMMkEvhAzSzWSIEiHWN9kjnoCpmK7he4TYZM35HYAcLssHkCjn/qP6LcnSTrVLBGUTdFop0nY5Tk+eHibFIXIMxxNz5KoB1T36zTg+76b/usoqlSRsgL0MqpOwDmNjrNXNDBpuK5e8dwv2klYN28gDPRS0q07VVB7+obFiKShrypfYmbdG62SLxsM4HPFZfbdCgJH5FQzs2nOhvn1ReuGbwKZlL4X2h6L7d0xmI6tFC/9N+prP1mmpIztRFmdTUp9YZuAif
X-Forefront-Antispam-Report: CIP:192.147.44.15;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjc1wvp-mail01.synaptics-inc.local;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(346002)(39850400004)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(8936002)(44832011)(8676002)(5660300002)(4326008)(70586007)(70206006)(316002)(54906003)(110136005)(2906002)(41300700001)(7049001)(36860700001)(6666004)(478600001)(81166007)(40480700001)(356005)(26005)(107886003)(1076003)(336012)(83380400001)(186003)(47076005)(82740400003)(82310400005)(2616005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 02:26:54.8108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663ba9f7-5996-4e2d-453f-08db6aec7d50
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335d1fbc-2124-4173-9863-17e7051a2a0e;Ip=[192.147.44.15];Helo=[sjc1wvp-mail01.synaptics-inc.local]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7488
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forcepad devices will use F21, for click simulation
due to lack of a metal button, so we add F21 support
to make forcepad support click function.

Signed-off-by: Marge Yang <marge.yang@tw.synaptics.com>
---
 drivers/input/rmi4/Kconfig      |   8 +++
 drivers/input/rmi4/Makefile     |   1 +
 drivers/input/rmi4/rmi_bus.c    |   3 +
 drivers/input/rmi4/rmi_driver.h |   5 +-
 drivers/input/rmi4/rmi_f21.c    | 110 ++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/rmi4/rmi_f21.c

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index c0163b983ce6..37e2ba4918fd 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -108,6 +108,14 @@ config RMI4_F3A
 	  Function 3A provides GPIO support for RMI4 devices. This includes
 	  support for buttons on TouchPads and ClickPads.
 
+config RMI4_F21
+	bool "RMI4 Function 21 (PRESSURE)"
+	help
+	  Say Y here if you want to add support for RMI4 function 21.
+
+	  Function 21 provides buttons/pressure for RMI4 devices. This includes
+	  support for buttons/pressure on PressurePad.
+
 config RMI4_F54
 	bool "RMI4 Function 54 (Analog diagnostics)"
 	depends on VIDEO_DEV=y || (RMI4_CORE=m && VIDEO_DEV=m)
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 02f14c846861..ec4f08513d8b 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -11,6 +11,7 @@ rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
 rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
 rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o rmi_f34v7.o
 rmi_core-$(CONFIG_RMI4_F3A) += rmi_f3a.o
+rmi_core-$(CONFIG_RMI4_F21) += rmi_f21.o
 rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
 rmi_core-$(CONFIG_RMI4_F55) += rmi_f55.o
 
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index f2e093b0b998..e12033aa7517 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -369,6 +369,9 @@ static struct rmi_function_handler *fn_handlers[] = {
 #ifdef CONFIG_RMI4_F3A
 	&rmi_f3a_handler,
 #endif
+#ifdef CONFIG_RMI4_F21
+	&rmi_f21_handler,
+#endif
 #ifdef CONFIG_RMI4_F54
 	&rmi_f54_handler,
 #endif
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 1c6c6086c0e5..57f258371bab 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -114,7 +114,9 @@ static inline int rmi_f03_overwrite_button(struct rmi_function *fn,
 }
 static inline void rmi_f03_commit_buttons(struct rmi_function *fn) {}
 #endif
-
+#ifdef CONFIG_RMI4_F21
+int rmi_f21_report_pressure(struct rmi_function *fn, int i);
+#endif
 #ifdef CONFIG_RMI4_F34
 int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
 void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev);
@@ -136,6 +138,7 @@ extern struct rmi_function_handler rmi_f12_handler;
 extern struct rmi_function_handler rmi_f30_handler;
 extern struct rmi_function_handler rmi_f34_handler;
 extern struct rmi_function_handler rmi_f3a_handler;
+extern struct rmi_function_handler rmi_f21_handler;
 extern struct rmi_function_handler rmi_f54_handler;
 extern struct rmi_function_handler rmi_f55_handler;
 #endif
diff --git a/drivers/input/rmi4/rmi_f21.c b/drivers/input/rmi4/rmi_f21.c
new file mode 100644
index 000000000000..5657bf4a2026
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f21.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2012-2020 Synaptics Incorporated
+ */
+
+#include <linux/kernel.h>
+#include <linux/rmi.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include "rmi_driver.h"
+
+#define RMI_F21_FORCE_CLICK_OFFSET	8
+#define RMI_f21_FORCE_CLICK			0x01
+#define RMI_f21_DATA_REGS_MAX_SIZE	1
+#define RMI_f21_FORCEPAD_BUTTON_COUNT	1
+
+struct f21_data {
+	/* Query Data */
+	u8 data_regs[RMI_f21_DATA_REGS_MAX_SIZE];
+	struct input_dev *input;
+	u16 key_code;
+};
+
+static irqreturn_t rmi_f21_attention(int irq, void *ctx)
+{
+	struct rmi_function *fn = ctx;
+	struct f21_data *f21 = dev_get_drvdata(&fn->dev);
+	int error;
+
+	error = rmi_read_block(fn->rmi_dev,
+				fn->fd.data_base_addr+RMI_F21_FORCE_CLICK_OFFSET,
+				f21->data_regs, 1);
+	if (error) {
+		dev_err(&fn->dev,
+			"%s: Failed to read f21 data registers: %d\n",
+			__func__, error);
+		return IRQ_RETVAL(error);
+	}
+
+	if (!!(f21->data_regs[0] & RMI_f21_FORCE_CLICK))
+		input_report_key(f21->input, f21->key_code, true);
+	else
+		input_report_key(f21->input, f21->key_code, false);
+	return IRQ_HANDLED;
+}
+
+static int rmi_f21_config(struct rmi_function *fn)
+{
+	struct f21_data *f21 = dev_get_drvdata(&fn->dev);
+	struct rmi_driver *drv = fn->rmi_dev->driver;
+
+	if (!f21)
+		return 0;
+
+	drv->set_irq_bits(fn->rmi_dev, fn->irq_mask);
+
+	return 0;
+}
+
+static int rmi_f21_initialize(struct rmi_function *fn, struct f21_data *f21)
+{
+	struct input_dev *input = f21->input;
+	unsigned int button = BTN_LEFT;
+
+	f21->key_code = button;
+	input_set_capability(input, EV_KEY, f21->key_code);
+	input->keycode = &(f21->key_code);
+	input->keycodesize = sizeof(f21->key_code);
+	input->keycodemax = RMI_f21_FORCEPAD_BUTTON_COUNT;
+
+	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+
+	return 0;
+}
+
+static int rmi_f21_probe(struct rmi_function *fn)
+{
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct f21_data *f21;
+	int error;
+
+	if (!drv_data->input) {
+		dev_info(&fn->dev, "f21: no input device found, ignoring\n");
+		return -ENXIO;
+	}
+
+	f21 = devm_kzalloc(&fn->dev, sizeof(*f21), GFP_KERNEL);
+	if (!f21)
+		return -ENOMEM;
+
+	f21->input = drv_data->input;
+
+	error = rmi_f21_initialize(fn, f21);
+	if (error)
+		return error;
+
+	dev_set_drvdata(&fn->dev, f21);
+	return 0;
+}
+
+struct rmi_function_handler rmi_f21_handler = {
+	.driver = {
+		.name = "rmi4_f21",
+	},
+	.func = 0x21,
+	.probe = rmi_f21_probe,
+	.config = rmi_f21_config,
+	.attention = rmi_f21_attention,
+};
-- 
2.25.1

