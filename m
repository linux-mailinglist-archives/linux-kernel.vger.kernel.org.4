Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802566DC9C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjDJRJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDJRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:09:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0688B2116;
        Mon, 10 Apr 2023 10:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuhAIo5d+Cn/uwsa2BUr7Oaf/yo/yVYnyKqC9rSkmKvjC6jucy+WKLWU0Dek29wx+6fFx7JcQVkAwojtnnXZ7Cek4IOx5by8u2FzPEgMcKIwaLS+fn0zTpV1C4KZgd7BZLyH2PVwDM6IqgxbQmsYV7w0to32h58CzMstcNmn2+UkA1C98Dpv89HN94tyjXQChv7oQ/0CVqMpvi7vodoNfNAqd0R/r0AUWRZJQiJaZNPYWgNFB1VMtyaB3w2f5UnTIi12JlKPDy2pCtASpb2NtAYNwNRkRVC4lrbGahFP/EwbUK07jYuiHtSGiBUGgxwnURrc0xPdb5LVROj1HLo/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMwbUfiAEwfxuQzeKk6QzpmHcEANfSyLBJEDlYV1r94=;
 b=GCtiCJVFzwhFAwag7DRvPBBs9EBfcwLdDXHrGLu1l9QxNAuKNAAVepKG4cKCxPeqjtwR808b+wODROfv/GMW8XnYA35IX+r+9cb7Q9cYEW9UB7tOcCxc4t+8ciozeGZ95bEicmusFhEYtKiLReQrw1lGW03KNtcVluP6zMqRN3SoC+HCosRSJnMvvno3TL4RUJxsVEOw7nLDPTEcjanwLH4failzlnILVAbpf3gP3tED1y2TCQGw4WadrIfP1+z9HCj5MMepCH9zncjn+GF855oOP+39JHZX0rN3HjfDpAnlAMeXFKg3zjns6zwDH3UB6HS69wwOt/cZp80zKySZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMwbUfiAEwfxuQzeKk6QzpmHcEANfSyLBJEDlYV1r94=;
 b=ruc8zbc4yVYpgYHSZRX8cJ/AThGnSTbqoGcKTbQYyrVetRpE01v9ET5SYGoaSzjGUcOdWLjPnh866FjzB6wJwkDOJAZQcs+VmfEpeG50h4M913g+oSwqqIMBcg5bOJwQe4XVR6LeeMuUgdnP/s9wGBijtxkJKfdof6ocTBpolgb4ZMk4Og0ObSHMh62X4cNpBmaUYlAd3pJBzfjL04MYU1vSehKLrapzDOJm9fNyJJ5ZTjQFPn1u38DWZEzW4lQwyOtcp6A8V/t1If82BYCvcTBTKpUqZXhUbXzuYwSNIkvxiX9e4eiyJ/zCPqD2IBADaijzTDOIAYgNYfy7Mq6puQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Mon, 10 Apr
 2023 17:09:29 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9%6]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 17:09:29 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v2 1/1] HID: shield: Initial driver implementation with Thunderstrike support
Date:   Mon, 10 Apr 2023 10:08:40 -0700
Message-Id: <20230410170840.16119-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
In-Reply-To: <20230410170840.16119-1-rrameshbabu@nvidia.com>
References: <20230410170840.16119-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: e848f1c1-a697-4abc-bfc7-08db39e65886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95svE8HQ9+oEqe7nsHMCjyQ0Pjp/K+G7+88AP3v/SQb3OsbJqwMJg1BKLTK+1haD3WsD89lHfOAbPJOPFFV10OGsZ5i3SQpUpAtgQdaYV/18OCqxXWpAN1WSmi9cTZB27h0D98BCO2kV3FdI+5kaGbOpBXG3HL7sgmQkho8UlA3K+XPDikDHSCpKtpQVE8pqxnulJYSa8kSfBSkkUitI04UAppm+LHawkhjhhOgPS4mbvUdt2D+teIAuDy6+E5vODtLBnX6kO4XF6Skrv0+YwUqnigmMZuKlXCw8LJwmj8LobvwW7sMnZYfPtLHdGVT3J9VlDmradtoMzmRasnJP8eeIw4s4oHMSNnfC9a6DQAnv+fYVD2hNQ88T0Mc00JwgEE2q7Jkh0RpbHzEW8Ytr6b6KmLnOTDwBi7lRBtbRtRg7B5paEOJ8YLDf6z7C5TGY6oiurBmP+3D0opwVg6GA1mr/2LhGFlrSmNRoPwO55VX5hL6Dx7rwoXw5RkRtVG+SjW/THivuJNprzLSl+SZe5G6T3gjh05J8E3O+6qExnzrgrI5OOYNXCjJal/oUDFgJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(110136005)(2616005)(83380400001)(6486002)(186003)(6666004)(478600001)(316002)(26005)(6512007)(1076003)(6506007)(107886003)(66946007)(30864003)(5660300002)(2906002)(38100700002)(36756003)(4326008)(86362001)(41300700001)(66556008)(8676002)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j68YNA5tiEzpMK0j7RdXt58izrh3UhuJcZKK2Ll5XcN45ZBIIIb9fVeLDB/V?=
 =?us-ascii?Q?WHqTe3n9+nbrCNaojNsylPWKqiJ+to8UHTQJqV7GiMwx1fy01J8Ia3DEubX0?=
 =?us-ascii?Q?s+YK0PlPsYfGjwuZ33FlKsyAggxrl8GUhKnit2YQvQ0GjvmXnhB7oixxfUFd?=
 =?us-ascii?Q?1KE+FNvJaNMXDfcFQyj9UT7TISS7kVxUjY5x5RNrPTxT8H4vDkpBG8TkZXGu?=
 =?us-ascii?Q?RzBORfLPNKolCVSXVxiL3Hlv30kL8efRGhQ5DUopYWcNIRBG5Vl39YQZbzys?=
 =?us-ascii?Q?qiTNwUBF7GX7nIJZ2eqivaAtwxtE1r69QWF6HPRYP0bxQjcX62Ur7RJKMoob?=
 =?us-ascii?Q?h0g6uddVorHHeR+Br1KLXznmm3FlFTq2Wir9RgWZsOI0/PJO2tZcf4BarY3v?=
 =?us-ascii?Q?8r68FLFDKCNQk/ziuqpAT2nuoMrrrbFGk8QIJSs4gR+fw1Ga4MLrsB3RLTF8?=
 =?us-ascii?Q?2Zv/lDd0kYf9RY7Sq1um7uQuNNlcrlObtqXKFECo1fliM5jVaAhCGzzx40oT?=
 =?us-ascii?Q?Vq4h8TfBvgrqEq3Ixb81/6qYkZmEb/r5irD11+Fj4p/Dzw/0ktRUmoHR7Xkv?=
 =?us-ascii?Q?o2m9Sx9MXryXDrqpcd5RaNnEKDdA3Pg0+ymAPR2X2i75jC5U1Y9b7sbn5HBj?=
 =?us-ascii?Q?RiODncAjwy8QIGKwENMa4qJX5MiEk05e4ATk1MaMrTXTsZjVLm7mDLPIeXS7?=
 =?us-ascii?Q?ghkO+i8WN3kY0ePC2R0JBOtL5VYsO3t9tuzdA9fLTYNyFVbt8SZjRmTWaAOV?=
 =?us-ascii?Q?tRbmtu22IBnByClCIvyQEJqi1LhjHaZxdBE9d9sIIyLf/1bgmGXVQEIG00b8?=
 =?us-ascii?Q?PJ+9v1JgPg4CddJuJMIyaC9HnCZjeG+cupoZJ5KEY+pScPfQp3oD/7GKIvsg?=
 =?us-ascii?Q?46pahxCFN7wDroF2N999FoAbuUCWB5znOMEnvvOg9sW03n1X7ETS7MavpibM?=
 =?us-ascii?Q?ZFdYwBZbqdoNipWYMpPP21FsKXGg8M3Q5mMB6/clZSL8olhHt9NahxVCAfbJ?=
 =?us-ascii?Q?2Z/aXmgU3LMlJfB1ya05Fpx9NGV1RydkdvJTLWSjsB6YQwXvliTJsxy5FB9i?=
 =?us-ascii?Q?uuvbcTjKRB2ZcauvPHfIDTU1csy1+lnafXpIFIUlBXoRiFM5ZiD76Qbbrrpf?=
 =?us-ascii?Q?ZlphbXsWU2Te00bgSO8bIhPw433CPcnulxDgVhPtTUBMsfQ0+Gd3343tdVI7?=
 =?us-ascii?Q?aw5cOssrFZzMRDveu5ReJrhMgDPWksBoYxd4gTI0pQqujIJKd836BIknUVFO?=
 =?us-ascii?Q?/ZLfMcloYLElegPtirvJoseFhjBpeiQjWfyCbR15C5fQ8+Q2td374aYp9Lmq?=
 =?us-ascii?Q?wh+RtwAnO3fFUy95CeS6jEsNf9TUApWcPPwhJd1VCeCSWzVuqecw7D65zRq1?=
 =?us-ascii?Q?qSsmZ9+/GYfveekFRArM34LRJyb0R3ba3ycpqHfSXCoa5v/Sak5tCkNeaKI4?=
 =?us-ascii?Q?TsPH7qUeuS36dntCPUZ5wmLFbQ8MGAKN48qxk6GDj+mDM8D3IYaNxVeZvEuy?=
 =?us-ascii?Q?M8SXZBcfUVkcvm5CkHy7DzLkF4A0hscStdaEcOCKpe1P6D6k+/BZFalrEhc+?=
 =?us-ascii?Q?RZ5lV9g5hLX5i5QBMiIUFmIA17xrCQGwl08TKqeIlKp4mip03jw8uTEkwOlE?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e848f1c1-a697-4abc-bfc7-08db39e65886
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 17:09:29.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnySokSd/m8nRZTzoLmkVVdNBZAUAStrgMUw4SRwij5acUerNjAvfyY4lD1mJ83BQ5H+br1jccaMY1dljiLu6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 MAINTAINERS              |   6 +
 drivers/hid/Kconfig      |  18 ++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-ids.h    |   3 +
 drivers/hid/hid-shield.c | 587 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 615 insertions(+)
 create mode 100644 drivers/hid/hid-shield.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b073facf399..4fa673401bc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9122,6 +9122,12 @@ F:	drivers/hid/hid-sensor-*
 F:	drivers/iio/*/hid-*
 F:	include/linux/hid-sensor-*
 
+HID SHIELD DRIVER
+M:	Rahul Rameshbabu <rrameshbabu@nvidia.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-shield.c
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
index 5d37cacbde33..a2ed1db9ed9d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_HID_RMI)		+= hid-rmi.o
 obj-$(CONFIG_HID_SAITEK)	+= hid-saitek.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
 obj-$(CONFIG_HID_SEMITEK)	+= hid-semitek.o
+obj-$(CONFIG_HID_SHIELD)	+= hid-shield.o
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
 
diff --git a/drivers/hid/hid-shield.c b/drivers/hid/hid-shield.c
new file mode 100644
index 000000000000..3befa8f133c7
--- /dev/null
+++ b/drivers/hid/hid-shield.c
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
+	{}
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

