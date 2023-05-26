Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0B7123E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjEZJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjEZJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:42:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2108.outbound.protection.outlook.com [40.92.107.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0AEA4;
        Fri, 26 May 2023 02:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7xqHl6rQR5Bd/2ssHvLUtvW5FK/KDv5rjw1m5n/3TWX7XczJFgKImU6v6bCG/krXeXQIaYbj8JkFeEzi6VlDW+89VBCN03RTzINJPibM5G+V3BCV4TNFeYSNM2xxRwXejJ9RyZuLOKNQOn3FYx9jG01xg2EigZsLUk1f5evpYpjin+SMA3x/8v0V8LOHAyi+N1oPf70tgNspBEb714uH7THa+Zkhdj+L4TuIJ6qxRsn1Zd4l296z+ated540tcM2Oqfur8I6XqbdScLcPq7c0ZIndLLhMHwW7t/UVugZglB3xKj4RqiuJpIk8KyFsqt+ZlBmyCVXN+/vFx8mP/S5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJyjzd04qEPgBXSuzDcAzjm3DUEU5W15E9jvAJimiu0=;
 b=kU/QVqY8px3g+5qdxM2imCjf6k1Hiyl7ThCWD5rCHeYl3xl4mZvgZ1gE4vvOk4mdZZDM9M/dkBl34SaazXYVuDzvtM1h7jfzM6GlYgQy54tR7+b4MUTSYMAtBoIKOae8F0zfIVVfyolgrzDO+T2DzZDx3fAt+UYlLzYPmA6DgjpjEMAqfAfJ6TLGHQD1VwHr3YOHAJHRCr3em4282vrcBoomMABzVrVlUNhn/X9yWfAVH1LLPAF9vfyxfclvQDew7M61aedBTQtJhy7E0Mnfz74PEMlBD9Fmc9D4XjZpjCnStni+os2f3wcr1cdRE7Ss2RGW28347DnRuCJ1ih1rZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJyjzd04qEPgBXSuzDcAzjm3DUEU5W15E9jvAJimiu0=;
 b=eHgXxF1rvyjodumOJaiJumxV4NCjTwcJQk1Z22gzvOcu5IOU0GVdYEo0ESae8QJlD9F3l16am1tNYR6Yiwz4RyjIK8WCnIYPVtJ4ZUfMzhtPNQfVl8YFk241xHZ8Ct+67HNFx+/JT0bnKXNabJKnZW3IrWufrDn3rBEMkacYoWFTcMoeSIRLDmFGfDM8NJDGv9XyATVvd56pjiDmZxwxX+5hYDw6qJ4pLkKlS8r6ZVZTNyQWs6c3Gxx+z0eiE6rSSYtA6m49WHsS3aNj5ZDaj381EKJ4vMKXTjkvioF43BsucgXL7wxoLd6Vu4ZBxYn+wvT/KPMIDxQeu2qk/Myr7A==
Received: from TYZPR03MB7130.apcprd03.prod.outlook.com (2603:1096:400:339::5)
 by TYSPR03MB7859.apcprd03.prod.outlook.com (2603:1096:400:480::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Fri, 26 May
 2023 09:42:21 +0000
Received: from TYZPR03MB7130.apcprd03.prod.outlook.com
 ([fe80::fba4:58a9:bd22:641e]) by TYZPR03MB7130.apcprd03.prod.outlook.com
 ([fe80::fba4:58a9:bd22:641e%7]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 09:42:21 +0000
From:   Noah Wang <noahwang.wang@outlook.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Noah Wang <noahwang.wang@outlook.com>
Subject: [PATCH] hwmon: mp2891: add MP2891 driver
Date:   Fri, 26 May 2023 17:42:07 +0800
Message-ID: <TYZPR03MB7130A7F41D61BFB611DDF0C7FA479@TYZPR03MB7130.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [AySHkpwMqkXKcBrZhpO4coL3UQFJO2+q]
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To TYZPR03MB7130.apcprd03.prod.outlook.com
 (2603:1096:400:339::5)
X-Microsoft-Original-Message-ID: <20230526094207.18924-1-noahwang.wang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7130:EE_|TYSPR03MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3b9da6-4efd-45b7-a505-08db5dcd806b
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrOEviK8+uzePVrrlXkXAwgL0K8DolhdhdIdALggfclbyfOpLos1lQnMsh7ENkyEXYgXdszuQcUtnIH1MplSSzxakzufY0ujjhttMU+08pAjVxrN6+H9zrCy7Y086mKiNiE7CoEmGm59Y/94RWCqaSEiDowWFWXa2A8cF+4FptJBSkaq5d/fSIb2ojk+eYcEisn0xKVcdpQtrohjHqyw0pHJUXNob0qEJouswEs2gd8Bsws2xH0TUmrm0Mu8ftSFuUJudchIKcMLQ9qDPkbaQ2dzMXoFZA/dVgAXvPWjzSFKR4lOTgREnGNUJIsiNTWlED6eUhytTwrwZCy12Ace7W38m4wHJaAsLH7VyShth5R/+eqE4p5MY+qpusUzbsnsgcRGZvqA5Yl7vrDdb439E33hZ4yE/Hl98JoH04GaDe8sWPSXZtHZQOjkIxRMI3UxouoJoShj3bTnJiT7aKwDCvVAqStB5sIqSlZ1I7p4JroCY1xO0Jf6kPQrpPywspcsYQid3I5HHoJa0mLbqHwPD4HKveZOjBQu27nJ1HsD1R7Qef7sjw7QPLbfAE0bKjcTvB7B29JiQPJbDt0CpBzxR54YlwHxWqJm2eHhpv0xclhc9yYWPfbmZNAgGwQ8lIvtZDXHzRzBLCOozJHITdSzsGDEF+1MDVTMGPHLyE6czG8fvfuA1qyKQ4fMabGjuTsbGezI5b7zW1sCfp9Q9jI8Hf2dMgj/QBa8sr8TxVhjy5y1eWSCs32ePJ800ZEuAlJJ1wI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLyGlhYBTw654982v3gaeRKxv4barkgX0sHQl/RG12+rp9VTyj8He+UpsfdqtM+Gc1RlkCH1DbdEk3gsFd8M+kpCtdqK5ZQvZPKKjc0xa9tr8jEXNfvdeM7ULxep+0Q1kie0asPL2Y0WZB6F11qJ4zqE/tGIOOKbzEV6p7BfBCJCVD0YB0dZSL0X9Qapjuuo4oIBvUq8RuEuqO7XDSvyqn/VagiBIR9oGM8ZSTAEymf8bkTWN4K4alFyK841QtRnzduW/T0ObTY+GnYqqDtVo3+hiW2VaclyVEL4sVGpBoMA5MLo2WkYpPQxKPzNZxCeBZENv5maTe2iIRAy2uUgT5lz0JfhCT2kMi57vjUCjIyifMMgRW/sePDBnWj+ynMMf1g03TQVmlupufpgqV9iRE1OVRBQtFAWz0Vm4MOkhinCRsbx7fqZjMGxfV2uUVzG2+5pmUUfkDcGr0kyBR/WEpnBpKixcZ6aB2OhjLyjxQsa1dMBRC27l/5ZLUX1BwQZMD8TRb28ti7VHMzpB9WxMLH2m6W1kryt5TviNdUH/xypgv7AB9HUyFrqy8g5AJBuo3IaKUlbvkLxhfu5e65KufoTSMWnTmbg4+4c+GefO4r2Do60SqG+U67rxUHrC66m
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hsoRjzD5YWQNIqXqPID1jUrZ4cwMVPbV068VXbu4FfLRD0+ckWZY8mx/P7F5?=
 =?us-ascii?Q?XsTa78/xBpA4i8mM0zwTG21zx9QQ79ud2h1Ff688pPTfr2zFvJSiB32QTI3R?=
 =?us-ascii?Q?g7GphVDiR9ndgnq6BfOOkz/QVSQAWJlJM0f0JoxkU2J55UfMOPlfArOza/uM?=
 =?us-ascii?Q?jQLoTH2ZIaksgxGLELYl2/jT+lBgcNjKiiyYH/+8q5o4BLllYIxGgePysp6+?=
 =?us-ascii?Q?NfKvjXOyb1x92v21jf/KiUjDj4xrzqY5wwptvrMWpYeAr3QN+yb21uw9Qymj?=
 =?us-ascii?Q?qpDaGrnLzcRRu7AJVvJ4oCTH4MEr+z17X+dIO7HDEkSQEM+0r9r6Km8tB2Yw?=
 =?us-ascii?Q?vmSuIowJzT8lcaCWLINQBzqphC/S1RuP2nACh3ZM04LIZr7O1I9UZpg4KkTs?=
 =?us-ascii?Q?A9wKvDrtjnjnCsAlI6b9HPTTZYYRLgsIR3tOPvLYFjng4x9uEqsuSiA3uajn?=
 =?us-ascii?Q?h8YJ/5MU1LlMLjzYeQ/qeXze7Jwu+yx8aO1Irn3qVyaBIxYxTebAN+ZKUZdN?=
 =?us-ascii?Q?v9AQGBYnjxD4m87PwP2A3DDxgoPkHEY2+hl0jOp6PYEMQvavc5i1SpODTjUB?=
 =?us-ascii?Q?E0tUCk+SRDCTTbLK8H6tnIa7JsvxRDhLnm9Cze+8jJyuc96ClbONloy5kVs2?=
 =?us-ascii?Q?vg3ihAwdOPfFtbCKwQUG5dCgDAbY7tUEEiKSLYIiJJiaor00CYZZBUzUIgIU?=
 =?us-ascii?Q?2xvfskREjNORx+dpTA0NMlZX+na1SD1ARlI39uUN9iAKQVpj5peZmptK+90J?=
 =?us-ascii?Q?4U/hz4uq5MM+MkvCjbqoINNQwhvn4lm3grSELX/APWXZ7pomRtqmB+5bZzqJ?=
 =?us-ascii?Q?lutTPEWMospeLSBzfjbdVXZh2E5y9oC6ifqbSz8WlbU6UeeQp4dSgksHQ4Ng?=
 =?us-ascii?Q?OZ1nu9F7PbxbOnFt/U8maMnuuCQMzJkYS3zRXsoijd7U0p4LeMXtspsI+JrV?=
 =?us-ascii?Q?RVdhr5jLFhKlyWJgYznjQ33yX5cTrhd7LQOSYbW+3qIib/+ulk1W1zGajHAT?=
 =?us-ascii?Q?IkyiR132vcoY+r/mhaofu7LXNPQ9x0ITclxC2Go6aXwR0wdkGKDd7YMtktL7?=
 =?us-ascii?Q?a3zAoS3+Fs2rbQvt9SW8yhtjnLGEGOcHf+sc9Os6dCOBp3BPYxnbi9ZZXrhS?=
 =?us-ascii?Q?rO/RTXz7WeT5pUIdVAyevfxv3GAJfkQMvVxALvcRhFKHg1OPb2BCNTb5thq9?=
 =?us-ascii?Q?hCu7+0H4JMdcgLYeFG2QhGPgRlKmdxWPeT7fhPOxuC+bLqlhI4m2XkK9+Rc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3b9da6-4efd-45b7-a505-08db5dcd806b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7130.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 09:42:21.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is designed for MPS VR controller mp2891. The sum
of input voltage, output voltage, output current, input power,
output power and temperature of per rail can be obtained from
hwmon interfaces that the driver provided.

Firstly, the driver get the vid_step of output voltage and
current scale(iout_scale) from the mps specific register
MFR_VOUT_LOOP_CTRL(0xBD) and MFR_SVI3_IOUT_PRT(0x65). These
two parameters are used to calculate the output voltage and
output current. Then, if the hwmon interfaces that the driver
provided are read by the userspace, the driver will obtain
corresponding data from mp2891 and the data will be submitted
to the pmbus-core. Finally, userspace can obtain the result.

Signed-off-by: Noah Wang <noahwang.wang@outlook.com>
---
 drivers/hwmon/pmbus/Kconfig  |  10 +
 drivers/hwmon/pmbus/Makefile |   1 +
 drivers/hwmon/pmbus/mp2891.c | 371 +++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/mp2891.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 270b6336b76d..8e930c15aa89 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -326,6 +326,16 @@ config SENSORS_MP5023
 	  This driver can also be built as a module. If so, the module will
 	  be called mp5023.
 
+config SENSORS_MP2891
+	tristate "MPS MP2891"
+	help
+	  If you say yes here you get hardware monitoring support for MPS
+	  MP2891 Dual Loop Digital Multi-Phase Controller.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mp2891.
+
+
 config SENSORS_MPQ7932_REGULATOR
 	bool "Regulator support for MPQ7932"
 	depends on SENSORS_MPQ7932 && REGULATOR
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 84ee960a6c2d..1a3884fd4b1a 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
+obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
 obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
 obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
 obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
diff --git a/drivers/hwmon/pmbus/mp2891.c b/drivers/hwmon/pmbus/mp2891.c
new file mode 100644
index 000000000000..07adf5f9871f
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp2891.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2891)
+ *
+ * Copyright (C) 2023 MPS
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+
+/* Vendor specific registers. */
+#define MFR_VOUT_LOOP_CTRL      0xBD
+#define MFR_SVI3_IOUT_PRT       0x65
+#define READ_PIN_EST            0x94
+
+#define VID_STEP_POS            14
+#define VID_STEP_MSK            (0x3 << VID_STEP_POS)
+#define DAC_2P5MV_POS           13
+#define DAC_2P5MV_MSK           (0x1 << DAC_2P5MV_POS)
+#define IOUT_SCALE_POS          0
+#define IOUT_SCALE_MSK          (0x7 << IOUT_SCALE_POS)
+
+#define MP2891_PAGE_NUM			2
+
+#define MP2891_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
+							PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | \
+							PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | \
+							PMBUS_PHASE_VIRTUAL)
+
+#define MP2891_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
+							PMBUS_HAVE_TEMP | PMBUS_HAVE_POUT | \
+							PMBUS_PHASE_VIRTUAL)
+
+struct mp2891_data {
+	struct pmbus_driver_info info;
+	int vid_step[MP2891_PAGE_NUM];
+	int iout_scale[MP2891_PAGE_NUM];
+};
+
+#define to_mp2891_data(x) container_of(x, struct mp2891_data, info)
+
+static int
+mp2891_read_pout(struct i2c_client *client, int page, int phase, int reg)
+{
+	int ret;
+
+	ret = pmbus_read_word_data(client, page, phase, reg);
+
+	return ret;
+}
+
+static int
+mp2891_read_pin(struct i2c_client *client, int page, int phase, int reg)
+{
+	int ret;
+
+	ret = pmbus_read_word_data(client, page, phase, reg);
+
+	return ret;
+}
+
+static int
+mp2891_read_vin(struct i2c_client *client, int page, int phase, int reg)
+{
+	int ret;
+
+	ret = pmbus_read_word_data(client, page, phase, reg);
+	ret = ((ret & 0x7FF) * 1000) >> 5;
+
+	return ret;
+}
+
+static int
+mp2891_read_vout(struct i2c_client *client, int page, int phase, int reg)
+{
+	int ret;
+
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2891_data *data = to_mp2891_data(info);
+
+	ret = pmbus_read_word_data(client, page, phase, reg);
+	ret = (ret & 0x7FF) * data->vid_step[page] / 100;
+
+	return ret;
+}
+
+static int
+mp2891_read_iout(struct i2c_client *client, int page, int phase, int reg)
+{
+	int ret;
+
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2891_data *data = to_mp2891_data(info);
+
+	ret = pmbus_read_word_data(client, page, phase, reg);
+
+	if (((ret & 0x8000) >> 15) == 0)
+		ret = (ret & 0x7FF) * (((ret & 0x7800) >> 11) + 1);
+	else
+		ret = (ret & 0x7FF) >> (32 - ((ret & 0xF800) >> 11));
+
+	ret = ret * data->iout_scale[page];
+
+	return ret;
+}
+
+static int
+mp2891_read_temperature(struct i2c_client *client, int page, int phase, int reg)
+{
+	int ret;
+
+	ret = pmbus_read_word_data(client, page, phase, reg);
+
+	if (((ret & 0x400) >> 10) == 0)
+		ret = ret & 0x7FF;
+	else
+		ret = ~(ret & 0x7FF) + 1;
+
+	return ret;
+}
+
+static int mp2891_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/*
+		 * Enforce VOUT direct format, since device allows to set the
+		 * different formats for the different rails. Conversion from
+		 * VID to direct provided by driver internally, in case it is
+		 * necessary.
+		 */
+		ret = PB_VOUT_MODE_DIRECT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp2891_read_word_data(struct i2c_client *client, int page, int phase,
+			      int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_READ_VIN:
+		ret = mp2891_read_vin(client, page, phase, reg);
+		break;
+	case PMBUS_READ_VOUT:
+		ret = mp2891_read_vout(client, page, phase, reg);
+		break;
+	case PMBUS_READ_IOUT:
+		ret = mp2891_read_iout(client, page, phase, reg);
+		break;
+	case PMBUS_READ_TEMPERATURE_1:
+		ret = mp2891_read_temperature(client, page, phase, reg);
+		break;
+	case PMBUS_READ_PIN:
+		ret = mp2891_read_pin(client, page, phase, READ_PIN_EST);
+		break;
+	case PMBUS_READ_POUT:
+		ret = mp2891_read_pout(client, page, phase, reg);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int
+mp2891_identify_vid(struct i2c_client *client, struct mp2891_data *data,
+						u32 reg, int page)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Obtain vid_step from the register MFR_VOUT_LOOP_CTRL, bits 15-14,bit 13.
+	 * If MFR_VOUT_LOOP_CTRL[13] = 1, the vid_step is below:
+	 * 2.5mV/LSB
+	 * If MFR_VOUT_LOOP_CTRL[13] = 0, the vid_step is decided by
+	 * MFR_VOUT_LOOP_CTRL[15:14]:
+	 * 00b - 6.25mV/LSB, 01b - 5mV/LSB, 10b - 2mV/LSB, 11b - 1mV
+	 */
+	if (((ret & DAC_2P5MV_MSK) >> VID_STEP_POS))
+		data->vid_step[page] = 250;
+	else {
+		ret = ((ret & VID_STEP_MSK) >> VID_STEP_POS);
+		if (ret == 0)
+			data->vid_step[page] = 625;
+		else if (ret == 1)
+			data->vid_step[page] = 500;
+		else if (ret == 2)
+			data->vid_step[page] = 200;
+		else
+			data->vid_step[page] = 100;
+	}
+
+	return 0;
+}
+
+static int
+mp2891_identify_rails_vid(struct i2c_client *client, struct mp2891_data *data)
+{
+	int ret;
+
+	/* Identify vid_step from register  MFR_VOUT_LOOP_CTRL. */
+	/* Identify vid_step for rail 1. */
+	ret = mp2891_identify_vid(client, data, MFR_VOUT_LOOP_CTRL, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Identify vid_step for rail 2. */
+	ret = mp2891_identify_vid(client, data, MFR_VOUT_LOOP_CTRL, 1);
+
+	return ret;
+}
+
+static int
+mp2891_iout_scale_get(struct i2c_client *client, struct mp2891_data *data,
+						u32 reg, int page)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+
+	/*
+	 * Obtain iout_scale from the register MFR_SVI3_IOUT_PRT, bits 2-0.
+	 * The value is selected as below:
+	 * 000b - 1A/LSB, 001b - (1/32)A/LSB, 010b - (1/16)A/LSB,
+	 * 011b - (1/8)A/LSB, 100b - (1/4)A/LSB, 101b - (1/2)A/LSB
+	 * 110b - 1A/LSB, 111b - 2A/LSB
+	 */
+	ret = (ret & IOUT_SCALE_MSK) >> IOUT_SCALE_POS;
+	if ((ret == 0) | (ret == 6))
+		data->iout_scale[page] = 32;
+	else if (ret == 1)
+		data->iout_scale[page] = 1;
+	else if (ret == 2)
+		data->iout_scale[page] = 2;
+	else if (ret == 3)
+		data->iout_scale[page] = 4;
+	else if (ret == 4)
+		data->iout_scale[page] = 8;
+	else if (ret == 5)
+		data->iout_scale[page] = 16;
+	else
+		data->iout_scale[page] = 64;
+
+	return 0;
+}
+
+static int
+mp2891_rails_iout_scale_get(struct i2c_client *client, struct mp2891_data *data)
+{
+	int ret;
+
+	/* Get iout_scale from register MFR_SVI3_IOUT_PRT. */
+	/* Get iout_scale for rail 1. */
+	ret = mp2891_iout_scale_get(client, data, MFR_SVI3_IOUT_PRT, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Get iout_scale for rail 2. */
+	ret = mp2891_iout_scale_get(client, data, MFR_SVI3_IOUT_PRT, 1);
+
+	return ret;
+}
+
+static struct pmbus_driver_info mp2891_info = {
+	.pages = MP2891_PAGE_NUM,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.format[PSC_POWER] = linear,
+
+	.m[PSC_VOLTAGE_IN] = 1,
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.m[PSC_CURRENT_OUT] = 32,
+	.m[PSC_TEMPERATURE] = 1,
+	.R[PSC_VOLTAGE_IN] = 3,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.R[PSC_CURRENT_OUT] = 0,
+	.R[PSC_TEMPERATURE] = 0,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.b[PSC_CURRENT_OUT] = 0,
+	.b[PSC_TEMPERATURE] = 0,
+
+	.func[0] = MP2891_RAIL1_FUNC,
+	.func[1] = MP2891_RAIL2_FUNC,
+	.read_word_data = mp2891_read_word_data,
+	.read_byte_data = mp2891_read_byte_data,
+};
+
+static int mp2891_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct pmbus_driver_info *info;
+	struct mp2891_data *data;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mp2891_data), GFP_KERNEL);
+
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp2891_info, sizeof(*info));
+	info = &data->info;
+
+	/* Identify VID setting per rail. */
+	ret = mp2891_identify_rails_vid(client, data);
+	if (ret < 0)
+		return ret;
+
+	/* Get iout scale per rail. */
+	ret = mp2891_rails_iout_scale_get(client, data);
+	if (ret < 0)
+		return ret;
+
+	return pmbus_do_probe(client, info);
+}
+
+static const struct i2c_device_id mp2891_id[] = {
+	{"mp2891", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp2891_id);
+
+static const struct of_device_id __maybe_unused mp2891_of_match[] = {
+	{.compatible = "mps,mp2891"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp2891_of_match);
+
+static struct i2c_driver mp2891_driver = {
+	.driver = {
+		.name = "mp2891",
+		.of_match_table = mp2891_of_match,
+	},
+	.probe = mp2891_probe,
+	.id_table = mp2891_id,
+};
+
+module_i2c_driver(mp2891_driver);
+
+MODULE_AUTHOR("Noah Wang <noahwang.wang@outlook.com>");
+MODULE_DESCRIPTION("PMBus driver for MPS MP2891 device");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.25.1

