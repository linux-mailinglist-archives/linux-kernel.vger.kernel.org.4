Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4A6E5035
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDQS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDQS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:29:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240AF5BA9;
        Mon, 17 Apr 2023 11:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlebcpV0pk/WSed6eTQ+a0zGQ0bpDFOPPhcK7aUR7kdiuYClvutYdU3lorWLSoRad+I8DqBxLLje6Db4ZgvPq+RrRbsW7RTGayKFdd/1sbFf3V4UMq4+7scSW/FGxXLhmrpY8j7pXSHOiElm38kxQT6couajF82TJEJPh9n4TLqavLv8Lld6Bnr4qIIVa/JL70GlY6V58+W/kAXnT5SdVdM7KOsAQRcmy+PguiL/osB/0BhinDr5My6OSvutipocjqpjqjfutmAJkTxh9gvBKNqaaOMbzpa1dJtJL7lOumHpJs32qdese71dYPvOQ5uY51xHGGegGYiS40C62JGJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+bHiOoBg2j3UovN1u8tVsJSiXWff6vv8wMADVlOhMc=;
 b=ZUoDbUUfbmOD3NyCFPfXzai2vlJmGR0Q7AYjc9+Yl2yR/cHK8QKp8KSxIUR/I5bDobJmWX1IJj+R2k1k9yQZ+S2Fp4r5JuOb0FR/gjPML7Mdb5yfMkWGH6+K+khCC5wnjUghJBRkGkA2wvu8Z6tgp7H/t0dU5MTTLFmGLPKNfpt24cc8qS7KtxWvcOY0f2bbdCucIiwWZOTao/kBXzsHT2B2+KaFC7u9umjJ+HQBp9UHgbT9T3/pM+LWUvgpdeeiR6Qj/6iXFPj9McjInd3BFi4BTlb1FXnXhqXC8cZVxroBqCYGDfPsoDsZMNl1V3PnYp/KXyag1FCbkHEvn43EPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+bHiOoBg2j3UovN1u8tVsJSiXWff6vv8wMADVlOhMc=;
 b=RG4/h664WzcaEKQ/C6y+u/vBB4rCBwAA5Vvo9uSWqjiDyRWiIZ0fZjCeRjRi1u3fWHsjfgcAoh/frcwXn8ApxdTpSYyCctdgTSMp+PupReLfrpWnOBDEel+4L+T/nyHUKAnj/Hv8n5m8dBIcY4bIiQIygcIKRm6vabwo7yd7wjJ3EFHipnhZcac2xojPQQGh8xCXoxvzZWOV+Pq8VfIyhxO0zhdMk2aroi93Oh/n6qj161yy4SnzXBOeTnKN1BwS5Gqw46ci8MI8b8RHEyGK7rfktkHhoFulFEXz1PipD4RmOvR9SC3jd0qujtyQkoJGZZ+cbjuFsDXHtcbFVwIUSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 18:29:23 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9%7]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 18:29:23 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v3 1/1] HID: shield: Initial driver implementation with Thunderstrike support
Date:   Mon, 17 Apr 2023 11:29:09 -0700
Message-Id: <20230417182909.33833-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
In-Reply-To: <20230417182909.33833-1-rrameshbabu@nvidia.com>
References: <20230417182909.33833-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a68ee4-2c3d-4397-430e-08db3f71aad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IODa7oZ+LDXnEamW0XvbRe+mOGtI8wqLRLIB5mlZB5eByU7LdjyTdPoVgi/8PiO7I/IFBSZ1Q2ESxnFH5oR/dZhE8Yx9n7sFrjZV1Ew1diIBrCSvp/inCAgskzARHTh0allF020LLt7or580uQMK/FR6spJStzZIR9PCeYtEhGUfAtiAsinW3KRkLYyyRb9lw65tiJwhZqpSz/PQL5kZBkoVRLtM7+q0FMDNjYKW1iJgHe6ET8A3jTekfrRRO0T06pxSfHyfI7rR1zkuV40+YWz5ik2ybhzKxgYBiKqb/5wn9J8kTAg46r2kCivDaWOe8Wf4STzM92TD2GMsTukIj3OP/vJWjsTOos2blHdTqz8g0o3ssZ4juazTzcpBfTfst843MkKvw40G7rOTGk01Dq14O4IVwT7SwfywkuPYuOHvu8VHZcMMHE/BxcXUBZrWGrZPXFDbVynarcSY68WaGFlvfPzutmBKDrZtWtO5NbW3TGjHIh5Q6X2fmCv6PzA/VBA9boXDzvvUnxmgt9BShBQjsWOC09mv3ZEd2tqk7JzgXDZH9l2weSWtzmku+vx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(86362001)(6486002)(8676002)(8936002)(107886003)(5660300002)(83380400001)(38100700002)(186003)(6512007)(1076003)(6506007)(26005)(66476007)(478600001)(4326008)(66946007)(66556008)(110136005)(2616005)(36756003)(6666004)(2906002)(30864003)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvKkn+7OBJAlkXxcFbWOj1q48jxROFI8S6N1FAAmChZdfR8/uuT7yf1WWefL?=
 =?us-ascii?Q?YljuEPFeMMhFozgqjH0ws1Sq3+cGLJa8Jla8DH8aZs17BVRgG1QSnjHfW2LA?=
 =?us-ascii?Q?DX6ViFA2J6xGy7Z2DF4eLGgKVle7IfcoVAAZDSW/JvtjPKNDQxWJdwndR0eI?=
 =?us-ascii?Q?OKMTN6huegkUTiGdn3XEsMERwWMZN2WJrVgvZtBUXsrzQq5lZ80BAxlest9B?=
 =?us-ascii?Q?2gQT/eSspfRlvFLzMtTH7f1TInwqgIwKa95NVPToZOPx6+RsFzCUm8R4j9cQ?=
 =?us-ascii?Q?K+IxgmMJQSk7d2WxDB0cUhGNr/3WpBku+vMW58tLnXJNNLEBjBby8xdIwI8O?=
 =?us-ascii?Q?0vsnRYaE4JYkIGSipmI6QgaA8ZWU1KplTR45qxvZEVa/gb9MR1a9IQGgiXcN?=
 =?us-ascii?Q?8xVcBW62eCjUTIWKsbpbIvjcUkbZ0SClwNMGwYx2AUe96xquC50664puVWAR?=
 =?us-ascii?Q?EuBnwf0ZlB7k+DC7oro7Z4wj2EsYdalxKoXk7Y9iTuzKtGI/E8+48vA0r4/0?=
 =?us-ascii?Q?v8nPRAxZDLLcWnw2Y69AT8SnT4C4vmXOfKfh4E1NaJLiVwdQcuSgbVz/hBb/?=
 =?us-ascii?Q?v12PRxo2VYR269HgyqKQqJHSVHoEzfGS6hIQBViy1zIPQcKmFxYKzQaAs14p?=
 =?us-ascii?Q?TjWFDyh6zVIzdt749ovH1H8EkZIITQqGECag04h+fc/3QK0rx0Ecw4kDnG97?=
 =?us-ascii?Q?Hw+YnUeHTgPsr2dxlyqF6NCZN6pNeC8U8qzx4nToLUPbazRt9e3patXLq/mJ?=
 =?us-ascii?Q?T9Jy8r4ExHAyY6dhUXdE4B56dw8DcP+EUBnq5rraTxTrbvznk9gXWpPS5nEO?=
 =?us-ascii?Q?aqaJEGcVF0cCUS6Gja2HrnrVQ4B1MVD+ZW6VRWhvpI5+Gma94v+cMGGnO4he?=
 =?us-ascii?Q?6222fdSz1NUDhitl2T/+ORYJzZKd4MI4kQs6DA/iegz/MZO15oFrvNJVfLZA?=
 =?us-ascii?Q?9YPBh3pF3jLZdbPu/Nt7JKpoHYhFXBrSCGp8/ue6bECbXuDhGvNiQqQcAS1J?=
 =?us-ascii?Q?jnJPDDMQaW9KQM/qQKYSadL26ZPguW05U2qLSUvKwwoxi8ZgW2RRD6koM3Dd?=
 =?us-ascii?Q?KNGD83bAc0lV5hoAOfXnanXzwSZXWgz6/oZZN+Bjtt/c4nSYwA0x8h2j5oPe?=
 =?us-ascii?Q?PXD4NyjwtZDBaLGffb+XavRAJoZAD22hkmhhFe1dzS2LkPZkbK4ZuSdWXkdi?=
 =?us-ascii?Q?7rPJXgwMJaUFuvESCDKWiNzhWiT+XPutTBu5e/sHwEVuKIegGuEEk9fwVQeU?=
 =?us-ascii?Q?3qflu3NQH1QSimsoxkbbkFcEHspDx7mcbYQFFbYfq6bhlEWWd7thETgiXFtG?=
 =?us-ascii?Q?MST9gMRd4xAg+gIxCwU0wuljjj0/hf3O2FxFs7sg+4jHhvxQ5d7xI948vLLC?=
 =?us-ascii?Q?P4NJ3FRhjpr0mZHT46L5ZQzqjFYVTZXqhJLbtxmLMltclg+CGsYqW+QiI7/H?=
 =?us-ascii?Q?8gfKwRaIUQ85w2Ndi5teyidNS8Pv4Cij/FAuQD2LeJIdCtX++dPiGh1bSUEz?=
 =?us-ascii?Q?+g913kDtJVnkMzCHoVjcIP6JFNVBPnIQS4AjRp+GA62nM/us2IgBHp43a2+1?=
 =?us-ascii?Q?XutIg9u2A3xb4sTKPRsGRaQxvrJka5CJIqOEabHjd5fZkHGLNxl7kVdiWMuY?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a68ee4-2c3d-4397-430e-08db3f71aad8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 18:29:23.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIiipvSzcgAVSYmqynBMNYKkDgcFouPGTwaf0YWxQBiBeOzpXZi2mVbnz98cEnw996ecIByLc2oO5R7S7J7WUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supports the Thunderstrike (SHIELD 2017) controller. Implements support for
the Thunderstrike HOSTCMD firmware interface. Adds sysfs attributes about a
SHIELD device and introduces haptics support for controllers.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 MAINTAINERS                     |   6 +
 drivers/hid/Kconfig             |  18 +
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-ids.h           |   3 +
 drivers/hid/hid-nvidia-shield.c | 587 ++++++++++++++++++++++++++++++++
 5 files changed, 615 insertions(+)
 create mode 100644 drivers/hid/hid-nvidia-shield.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b073facf399..2390b6427e07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9122,6 +9122,12 @@ F:	drivers/hid/hid-sensor-*
 F:	drivers/iio/*/hid-*
 F:	include/linux/hid-sensor-*
 
+HID SHIELD DRIVER
+M:	Rahul Rameshbabu <rrameshbabu@nvidia.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-nvidia-shield.c
+
 HID VRC-2 CAR CONTROLLER DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 82f64fb31fda..eb19debaa1f5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -990,6 +990,24 @@ config HID_SEMITEK
 	- Woo-dy
 	- X-Bows Nature/Knight
 
+config HID_SHIELD
+	tristate "SHIELD HID Driver"
+	depends on USB_HID
+	depends on BT_HIDP
+	help
+	Support for NVIDIA SHIELD accessories.
+
+	Supported devices:
+	- Thunderstrike (NVIDIA SHIELD Controller 2017)
+
+config SHIELD_FF
+	bool "SHIELD force feedback support"
+	depends on HID_SHIELD
+	select INPUT_FF_MEMLESS
+	help
+	Say Y here if you would like to enable force feedback support for
+	NVIDIA SHIELD accessories with haptics capabilities.
+
 config HID_SIGMAMICRO
 	tristate "SiGma Micro-based keyboards"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 5d37cacbde33..a37487b470c8 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_HID_RMI)		+= hid-rmi.o
 obj-$(CONFIG_HID_SAITEK)	+= hid-saitek.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
 obj-$(CONFIG_HID_SEMITEK)	+= hid-semitek.o
+obj-$(CONFIG_HID_SHIELD)	+= hid-nvidia-shield.o
 obj-$(CONFIG_HID_SIGMAMICRO)	+= hid-sigmamicro.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 63545cd307e5..4000d53b1bac 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -993,6 +993,9 @@
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_18   0x0014
 #define USB_DEVICE_ID_NTRIG_DUOSENSE 0x1500
 
+#define USB_VENDOR_ID_NVIDIA				0x0955
+#define USB_DEVICE_ID_NVIDIA_THUNDERSTRIKE_CONTROLLER	0x7214
+
 #define USB_VENDOR_ID_ONTRAK		0x0a07
 #define USB_DEVICE_ID_ONTRAK_ADU100	0x0064
 
diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
new file mode 100644
index 000000000000..32173cf7f8c9
--- /dev/null
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ *
+ *  HID driver for NVIDIA SHIELD peripherals.
+ */
+
+#include <linux/hid.h>
+#include <linux/input-event-codes.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "hid-ids.h"
+
+#define NOT_INIT_STR "NOT INITIALIZED"
+
+enum {
+	SHIELD_FW_VERSION_INITIALIZED = 0,
+	SHIELD_BOARD_INFO_INITIALIZED,
+};
+
+enum {
+	THUNDERSTRIKE_FW_VERSION_UPDATE = 0,
+	THUNDERSTRIKE_BOARD_INFO_UPDATE,
+	THUNDERSTRIKE_HAPTICS_UPDATE,
+};
+
+enum {
+	THUNDERSTRIKE_HOSTCMD_REPORT_SIZE = 33,
+	THUNDERSTRIKE_HOSTCMD_REQ_REPORT_ID = 0x4,
+	THUNDERSTRIKE_HOSTCMD_RESP_REPORT_ID = 0x3,
+};
+
+enum {
+	THUNDERSTRIKE_HOSTCMD_ID_FW_VERSION = 1,
+	THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO = 16,
+	THUNDERSTRIKE_HOSTCMD_ID_USB_INIT = 53,
+	THUNDERSTRIKE_HOSTCMD_ID_HAPTICS = 57,
+	THUNDERSTRIKE_HOSTCMD_ID_BLUETOOTH_INIT = 58,
+};
+
+struct thunderstrike_hostcmd_board_info {
+	__le16 revision;
+	__le16 serial[7];
+};
+
+struct thunderstrike_hostcmd_haptics {
+	u8 motor_left;
+	u8 motor_right;
+};
+
+struct thunderstrike_hostcmd_resp_report {
+	u8 report_id; /* THUNDERSTRIKE_HOSTCMD_RESP_REPORT_ID */
+	u8 cmd_id;
+	u8 reserved_at_10;
+
+	union {
+		struct thunderstrike_hostcmd_board_info board_info;
+		struct thunderstrike_hostcmd_haptics motors;
+		__le16 fw_version;
+		u8 payload[30];
+	};
+} __packed;
+static_assert(sizeof(struct thunderstrike_hostcmd_resp_report) ==
+	      THUNDERSTRIKE_HOSTCMD_REPORT_SIZE);
+
+struct thunderstrike_hostcmd_req_report {
+	u8 report_id; /* THUNDERSTRIKE_HOSTCMD_REQ_REPORT_ID */
+	u8 cmd_id;
+	u8 reserved_at_10;
+
+	struct {
+		u8 update;
+		struct thunderstrike_hostcmd_haptics motors;
+	} haptics;
+	u8 reserved_at_30[27];
+} __packed;
+static_assert(sizeof(struct thunderstrike_hostcmd_req_report) ==
+	      THUNDERSTRIKE_HOSTCMD_REPORT_SIZE);
+
+/* Common struct for shield accessories. */
+struct shield_device {
+	struct hid_device *hdev;
+
+	unsigned long initialized_flags;
+	const char *codename;
+	u16 fw_version;
+	struct {
+		u16 revision;
+		char serial_number[15];
+	} board_info;
+};
+
+struct thunderstrike {
+	struct shield_device base;
+
+	/* Sub-devices */
+	struct input_dev *haptics_dev;
+
+	/* Resources */
+	void *req_report_dmabuf;
+	unsigned long update_flags;
+	struct thunderstrike_hostcmd_haptics haptics_val;
+	spinlock_t haptics_update_lock;
+	struct work_struct hostcmd_req_work;
+};
+
+static inline void thunderstrike_hostcmd_req_report_init(
+	struct thunderstrike_hostcmd_req_report *report, u8 cmd_id)
+{
+	memset(report, 0, sizeof(*report));
+	report->report_id = THUNDERSTRIKE_HOSTCMD_REQ_REPORT_ID;
+	report->cmd_id = cmd_id;
+}
+
+static inline void shield_strrev(char *dest, size_t len, u16 rev)
+{
+	dest[0] = ('A' - 1) + (rev >> 8);
+	snprintf(&dest[1], len - 1, "%02X", 0xff & rev);
+}
+
+static struct input_dev *shield_allocate_input_dev(struct hid_device *hdev,
+						   const char *name_suffix)
+{
+	struct input_dev *idev;
+
+	idev = input_allocate_device();
+	if (!idev)
+		goto err_device;
+
+	idev->id.bustype = hdev->bus;
+	idev->id.vendor = hdev->vendor;
+	idev->id.product = hdev->product;
+	idev->id.version = hdev->version;
+	idev->uniq = hdev->uniq;
+	idev->name = devm_kasprintf(&idev->dev, GFP_KERNEL, "%s %s", hdev->name,
+				    name_suffix);
+	if (!idev->name)
+		goto err_name;
+
+	input_set_drvdata(idev, hdev);
+
+	return idev;
+
+err_name:
+	input_free_device(idev);
+err_device:
+	return ERR_PTR(-ENOMEM);
+}
+
+static struct input_dev *shield_haptics_create(
+	struct shield_device *dev,
+	int (*play_effect)(struct input_dev *, void *, struct ff_effect *))
+{
+	struct input_dev *haptics;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SHIELD_FF))
+		return NULL;
+
+	haptics = shield_allocate_input_dev(dev->hdev, "Haptics");
+	if (IS_ERR(haptics))
+		return haptics;
+
+	input_set_capability(haptics, EV_FF, FF_RUMBLE);
+	input_ff_create_memless(haptics, NULL, play_effect);
+
+	ret = input_register_device(haptics);
+	if (ret)
+		goto err;
+
+	return haptics;
+
+ err:
+	input_free_device(haptics);
+	return ERR_PTR(ret);
+}
+
+static inline void thunderstrike_send_hostcmd_request(struct thunderstrike *ts)
+{
+	struct thunderstrike_hostcmd_req_report *report = ts->req_report_dmabuf;
+	struct shield_device *shield_dev = &ts->base;
+	int ret;
+
+	ret = hid_hw_raw_request(shield_dev->hdev, report->report_id,
+				 ts->req_report_dmabuf,
+				 THUNDERSTRIKE_HOSTCMD_REPORT_SIZE,
+				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+
+	if (ret < 0) {
+		hid_err(shield_dev->hdev,
+			"Failed to output Thunderstrike HOSTCMD request HID report due to %pe\n",
+			ERR_PTR(ret));
+	}
+}
+
+static void thunderstrike_hostcmd_req_work_handler(struct work_struct *work)
+{
+	struct thunderstrike *ts =
+		container_of(work, struct thunderstrike, hostcmd_req_work);
+	struct thunderstrike_hostcmd_req_report *report;
+	unsigned long flags;
+
+	report = ts->req_report_dmabuf;
+
+	if (test_and_clear_bit(THUNDERSTRIKE_FW_VERSION_UPDATE, &ts->update_flags)) {
+		thunderstrike_hostcmd_req_report_init(
+			report, THUNDERSTRIKE_HOSTCMD_ID_FW_VERSION);
+		thunderstrike_send_hostcmd_request(ts);
+	}
+
+	if (test_and_clear_bit(THUNDERSTRIKE_BOARD_INFO_UPDATE, &ts->update_flags)) {
+		thunderstrike_hostcmd_req_report_init(
+			report, THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO);
+		thunderstrike_send_hostcmd_request(ts);
+	}
+
+	if (test_and_clear_bit(THUNDERSTRIKE_HAPTICS_UPDATE, &ts->update_flags)) {
+		thunderstrike_hostcmd_req_report_init(
+			report, THUNDERSTRIKE_HOSTCMD_ID_HAPTICS);
+
+		report->haptics.update = 1;
+		spin_lock_irqsave(&ts->haptics_update_lock, flags);
+		report->haptics.motors = ts->haptics_val;
+		spin_unlock_irqrestore(&ts->haptics_update_lock, flags);
+
+		thunderstrike_send_hostcmd_request(ts);
+	}
+}
+
+static inline void thunderstrike_request_firmware_version(struct thunderstrike *ts)
+{
+	set_bit(THUNDERSTRIKE_FW_VERSION_UPDATE, &ts->update_flags);
+	schedule_work(&ts->hostcmd_req_work);
+}
+
+static inline void thunderstrike_request_board_info(struct thunderstrike *ts)
+{
+	set_bit(THUNDERSTRIKE_BOARD_INFO_UPDATE, &ts->update_flags);
+	schedule_work(&ts->hostcmd_req_work);
+}
+
+static inline int
+thunderstrike_update_haptics(struct thunderstrike *ts,
+			     struct thunderstrike_hostcmd_haptics *motors)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->haptics_update_lock, flags);
+	ts->haptics_val = *motors;
+	spin_unlock_irqrestore(&ts->haptics_update_lock, flags);
+
+	set_bit(THUNDERSTRIKE_HAPTICS_UPDATE, &ts->update_flags);
+	schedule_work(&ts->hostcmd_req_work);
+
+	return 0;
+}
+
+static int thunderstrike_play_effect(struct input_dev *idev, void *data,
+				     struct ff_effect *effect)
+{
+	struct hid_device *hdev = input_get_drvdata(idev);
+	struct thunderstrike_hostcmd_haptics motors;
+	struct shield_device *shield_dev;
+	struct thunderstrike *ts;
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	shield_dev = hid_get_drvdata(hdev);
+	ts = container_of(shield_dev, struct thunderstrike, base);
+
+	/* Thunderstrike motor values range from 0 to 32 inclusively */
+	motors.motor_left = effect->u.rumble.strong_magnitude / 2047;
+	motors.motor_right = effect->u.rumble.weak_magnitude / 2047;
+
+	hid_dbg(hdev, "Thunderstrike FF_RUMBLE request, left: %u right: %u\n",
+		motors.motor_left, motors.motor_right);
+
+	return thunderstrike_update_haptics(ts, &motors);
+}
+
+static void
+thunderstrike_parse_fw_version_payload(struct shield_device *shield_dev,
+				       __le16 fw_version)
+{
+	shield_dev->fw_version = le16_to_cpu(fw_version);
+
+	set_bit(SHIELD_FW_VERSION_INITIALIZED, &shield_dev->initialized_flags);
+
+	hid_dbg(shield_dev->hdev, "Thunderstrike firmware version 0x%04X\n",
+		shield_dev->fw_version);
+}
+
+static void
+thunderstrike_parse_board_info_payload(struct shield_device *shield_dev,
+				       struct thunderstrike_hostcmd_board_info *board_info)
+{
+	char board_revision_str[4];
+	int i;
+
+	shield_dev->board_info.revision = le16_to_cpu(board_info->revision);
+	for (i = 0; i < 7; ++i) {
+		u16 val = le16_to_cpu(board_info->serial[i]);
+
+		shield_dev->board_info.serial_number[2 * i] = val & 0xFF;
+		shield_dev->board_info.serial_number[2 * i + 1] = val >> 8;
+	}
+	shield_dev->board_info.serial_number[14] = '\0';
+
+	set_bit(SHIELD_BOARD_INFO_INITIALIZED, &shield_dev->initialized_flags);
+
+	shield_strrev(board_revision_str, 4, shield_dev->board_info.revision);
+	hid_dbg(shield_dev->hdev,
+		"Thunderstrike BOARD_REVISION_%s (0x%04X) S/N: %s\n",
+		board_revision_str, shield_dev->board_info.revision,
+		shield_dev->board_info.serial_number);
+}
+
+static inline void
+thunderstrike_parse_haptics_payload(struct shield_device *shield_dev,
+				    struct thunderstrike_hostcmd_haptics *haptics)
+{
+	hid_dbg(shield_dev->hdev,
+		"Thunderstrike haptics HOSTCMD response, left: %u right: %u\n",
+		haptics->motor_left, haptics->motor_right);
+}
+
+static int thunderstrike_parse_report(struct shield_device *shield_dev,
+				      struct hid_report *report, u8 *data,
+				      int size)
+{
+	struct thunderstrike_hostcmd_resp_report *hostcmd_resp_report;
+	struct thunderstrike *ts =
+		container_of(shield_dev, struct thunderstrike, base);
+	struct hid_device *hdev = shield_dev->hdev;
+
+	switch (report->id) {
+	case THUNDERSTRIKE_HOSTCMD_RESP_REPORT_ID:
+		if (size != THUNDERSTRIKE_HOSTCMD_REPORT_SIZE) {
+			hid_err(hdev,
+				"Encountered Thunderstrike HOSTCMD HID report with unexpected size %d\n",
+				size);
+			return -EINVAL;
+		}
+
+		hostcmd_resp_report =
+			(struct thunderstrike_hostcmd_resp_report *)data;
+
+		switch (hostcmd_resp_report->cmd_id) {
+		case THUNDERSTRIKE_HOSTCMD_ID_FW_VERSION:
+			thunderstrike_parse_fw_version_payload(
+				shield_dev, hostcmd_resp_report->fw_version);
+			break;
+		case THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO:
+			thunderstrike_parse_board_info_payload(
+				shield_dev, &hostcmd_resp_report->board_info);
+			break;
+		case THUNDERSTRIKE_HOSTCMD_ID_HAPTICS:
+			thunderstrike_parse_haptics_payload(
+				shield_dev, &hostcmd_resp_report->motors);
+			break;
+
+		case THUNDERSTRIKE_HOSTCMD_ID_USB_INIT:
+		case THUNDERSTRIKE_HOSTCMD_ID_BLUETOOTH_INIT:
+			/* May block HOSTCMD requests till received initially */
+			thunderstrike_request_firmware_version(ts);
+			thunderstrike_request_board_info(ts);
+			/* Only HOSTCMD that can be triggered without a request */
+			return 0;
+		default:
+			hid_warn(hdev,
+				 "Unhandled Thunderstrike HOSTCMD id %d\n",
+				 hostcmd_resp_report->cmd_id);
+			return -ENOENT;
+		}
+
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static struct shield_device *thunderstrike_create(struct hid_device *hdev)
+{
+	struct shield_device *shield_dev;
+	struct thunderstrike *ts;
+
+	ts = devm_kzalloc(&hdev->dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return ERR_PTR(-ENOMEM);
+
+	ts->req_report_dmabuf = devm_kzalloc(
+		&hdev->dev, THUNDERSTRIKE_HOSTCMD_REPORT_SIZE, GFP_KERNEL);
+	if (!ts->req_report_dmabuf)
+		return ERR_PTR(-ENOMEM);
+
+	shield_dev = &ts->base;
+	shield_dev->hdev = hdev;
+	shield_dev->codename = "Thunderstrike";
+
+	spin_lock_init(&ts->haptics_update_lock);
+	INIT_WORK(&ts->hostcmd_req_work, thunderstrike_hostcmd_req_work_handler);
+
+	hid_set_drvdata(hdev, shield_dev);
+
+	ts->haptics_dev = shield_haptics_create(shield_dev, thunderstrike_play_effect);
+	if (IS_ERR(ts->haptics_dev))
+		return ERR_CAST(ts->haptics_dev);
+
+	hid_info(hdev, "Registered Thunderstrike controller\n");
+	return shield_dev;
+}
+
+static ssize_t firmware_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct shield_device *shield_dev;
+	int ret;
+
+	shield_dev = hid_get_drvdata(hdev);
+
+	if (test_bit(SHIELD_FW_VERSION_INITIALIZED, &shield_dev->initialized_flags))
+		ret = sysfs_emit(buf, "0x%04X\n", shield_dev->fw_version);
+	else
+		ret = sysfs_emit(buf, NOT_INIT_STR "\n");
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(firmware_version);
+
+static ssize_t hardware_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct shield_device *shield_dev;
+	char board_revision_str[4];
+	int ret;
+
+	shield_dev = hid_get_drvdata(hdev);
+
+	if (test_bit(SHIELD_BOARD_INFO_INITIALIZED, &shield_dev->initialized_flags)) {
+		shield_strrev(board_revision_str, 4, shield_dev->board_info.revision);
+		ret = sysfs_emit(buf, "%s BOARD_REVISION_%s (0x%04X)\n",
+				 shield_dev->codename, board_revision_str,
+				 shield_dev->board_info.revision);
+	} else
+		ret = sysfs_emit(buf, NOT_INIT_STR "\n");
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(hardware_version);
+
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct shield_device *shield_dev;
+	int ret;
+
+	shield_dev = hid_get_drvdata(hdev);
+
+	if (test_bit(SHIELD_BOARD_INFO_INITIALIZED, &shield_dev->initialized_flags))
+		ret = sysfs_emit(buf, "%s\n", shield_dev->board_info.serial_number);
+	else
+		ret = sysfs_emit(buf, NOT_INIT_STR "\n");
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(serial_number);
+
+static struct attribute *shield_device_attrs[] = {
+	&dev_attr_firmware_version.attr,
+	&dev_attr_hardware_version.attr,
+	&dev_attr_serial_number.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(shield_device);
+
+static int shield_raw_event(struct hid_device *hdev, struct hid_report *report,
+			    u8 *data, int size)
+{
+	struct shield_device *dev = hid_get_drvdata(hdev);
+
+	return thunderstrike_parse_report(dev, report, data, size);
+}
+
+static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct shield_device *shield_dev = NULL;
+	struct thunderstrike *ts;
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "Parse failed\n");
+		return ret;
+	}
+
+	switch (id->product) {
+	case USB_DEVICE_ID_NVIDIA_THUNDERSTRIKE_CONTROLLER:
+		shield_dev = thunderstrike_create(hdev);
+		break;
+	}
+
+	if (unlikely(!shield_dev)) {
+		hid_err(hdev, "Failed to identify SHIELD device\n");
+		return -ENODEV;
+	}
+	if (IS_ERR(shield_dev)) {
+		hid_err(hdev, "Failed to create SHIELD device\n");
+		return PTR_ERR(shield_dev);
+	}
+
+	ts = container_of(shield_dev, struct thunderstrike, base);
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDINPUT);
+	if (ret) {
+		hid_err(hdev, "Failed to start HID device\n");
+		goto err_haptics;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "Failed to open HID device\n");
+		goto err_stop;
+	}
+
+	thunderstrike_request_firmware_version(ts);
+	thunderstrike_request_board_info(ts);
+
+	return ret;
+
+err_stop:
+	hid_hw_stop(hdev);
+err_haptics:
+	if (ts->haptics_dev)
+		input_unregister_device(ts->haptics_dev);
+	return ret;
+}
+
+static void shield_remove(struct hid_device *hdev)
+{
+	struct shield_device *dev = hid_get_drvdata(hdev);
+	struct thunderstrike *ts;
+
+	ts = container_of(dev, struct thunderstrike, base);
+
+	hid_hw_close(hdev);
+	if (ts->haptics_dev)
+		input_unregister_device(ts->haptics_dev);
+	cancel_work_sync(&ts->hostcmd_req_work);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id shield_devices[] = {
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NVIDIA,
+			       USB_DEVICE_ID_NVIDIA_THUNDERSTRIKE_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NVIDIA,
+			 USB_DEVICE_ID_NVIDIA_THUNDERSTRIKE_CONTROLLER) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, shield_devices);
+
+static struct hid_driver shield_driver = {
+	.name         = "shield",
+	.id_table     = shield_devices,
+	.probe        = shield_probe,
+	.remove       = shield_remove,
+	.raw_event    = shield_raw_event,
+	.driver = {
+		.dev_groups = shield_device_groups,
+	},
+};
+module_hid_driver(shield_driver);
+
+MODULE_AUTHOR("Rahul Rameshbabu <rrameshbabu@nvidia.com>");
+MODULE_DESCRIPTION("HID Driver for NVIDIA SHIELD peripherals.");
+MODULE_LICENSE("GPL");
-- 
2.38.4

