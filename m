Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B5D7282CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjFHOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjFHOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:35:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E570A2D65;
        Thu,  8 Jun 2023 07:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY7LFOOfl9CpnkTr2m+cbWvR1GmAj0blQ9sW/rZTv1lBKAlufM+UQ3TpJorU2BMcZqZeV06NBwVsxSGampFSc3POIgTGzoTuBCnOQJfFtacpqVFJVFQCtZuFRv3kc5BDB61CCWpeLp8MO+upAfNeIO2K9JOrKGWRlNC3xMjieSB2jWamYkeBtcdFNXKUhABq2VPqSO7d8eYvMdtB1R1cqQoKyW4VWVinp0lFkUXwDVW+KmyhMhioBpIdMs/RPU/NkpouRo0IQDv41zhxwrsHaVQsG+ksJEYsP2sBhRLs37roDZnDwH2nGAs/EedPgqOuBL7HtoO6u74xk4ITVnyYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzoi33Xh8T+Oo6n/VXZ3m9A8Rzw44urh6rN2z177qNE=;
 b=jgoUqH+I4eYbQHxaoL4AIWInInbrC2vm5d/RHO4TY2a6oBsVXMkPWILSrNmv8K3XEwh0vmCiAXLVpl0f9RFLjRwFzLOV5ry2HM1/F2EzjJ6TfH9QrlF3wAUB8gXqIHiFKwp7XAhO87Ij0haiuPeMNMJ8/1LeeibWFhAssGPkWEQyG0vzKFDmw0x7RXyxyqhTlwi5w7s8KAnuo8qM7BeU4FD12dN39/tx+9s0bayE540R4mGb2M1BpqY4ZQhaj4Wop1MRog/VYkF35bJUtlc69WPdfclkDbeK+V9w3KB7OfQDLp8ic8NOpQHy2lA5gErmbVIXK+i16ix/WRfL7sAgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzoi33Xh8T+Oo6n/VXZ3m9A8Rzw44urh6rN2z177qNE=;
 b=JuFLmRAv9DSTkcMpLFk9AWAAsc9WdqFcwi9PnkdGgTVsRRsrRQcnMztBnfnYHgN1RtmppJcyFlJ2eiXM+3o6snfBysHL/QcCCGmf1Fnk140ngHfXP8MsQ4AJNwHhLH74aBoDXlAl0qXVr5VgpoKiG/nW0dHcj2SrGJxIOcNvafR66RzQE3g2Y6rQM24KvvgAJj7hkkMzmuoa53JrGWHPZu66qYsGMaBgsYdXPGsgpr+4ReUZHqN9R1Xw21mbCelSg3VNPgC85VPyV6sWMagjZW51Y1k+XdNAELEXKWxTFecucnGjdQS/FNgaKYUClOoDOi2sDTsq97e22w+BOTgYpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 14:35:06 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 14:35:06 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RESEND v4 1/1] HID: nvidia-shield: Initial driver implementation with Thunderstrike support
Date:   Thu,  8 Jun 2023 07:34:50 -0700
Message-Id: <20230608143450.12283-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.5
In-Reply-To: <20230608143450.12283-1-rrameshbabu@nvidia.com>
References: <20230608143450.12283-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de7fae8-176c-46e5-06e9-08db682d8d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbFIDTSoVftXHFjurM16bndVSWI1wDUpk98pjBijE2ERqsuhq3IXAySBCjWIwqXbmTpZwzgYvhRLVGft7NR/a9lyu5vIHV73HZWlsbkBzn9BD78L6CZWcurrH8KdreJ8ZXny0fnn+YTyDjk7sYDbMQ+mmPmw9W6ICpq5Kv4nXKoUIOCGoZyT//bFZ0RFq3K05jsTNLVKOKMhaJfzix7Vz4M8No8RLTCfiHD08mElw2Yyky2wdd6OlcjiH2pyGg3nYrS5QxR/BegP03+j/t3wlx5FEMERWDgdaXQF0wMWHsfJh5730OW9XeJcBk6zcLGPvA2mMVrxcj/L8XMXiT+l5BHT3/ri7jWvTzaxufOA4cSANg9vGd8rgPBEWEZRm5bxFTwpMpsgefWEpBaLE4mxdveDNCHwUtkurZknNhu0fckaIAHfbFb7zVxeiW6z+2xgkIhKpQmEkQA/2PLtETBsxNVkT4a/72qrLBHtXTzlgFOru9Vw0onTMrNo+vioYLq7fBedkZ+khbzR0OmRtrgU7Twvq0TFb6Qp6u448HbpUhwpj5HzMSaSdeoT3gV1mjvP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(8676002)(2906002)(316002)(5660300002)(30864003)(66946007)(66476007)(4326008)(66556008)(8936002)(41300700001)(110136005)(54906003)(6486002)(6666004)(6506007)(6512007)(26005)(1076003)(36756003)(186003)(107886003)(2616005)(83380400001)(478600001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wL2NqpqxZj4fC0FHywEXKczBPgU77WObKvEGbHzGuLqRTETfcSgQhAR8bVzL?=
 =?us-ascii?Q?hrr7jbNZQLtZi+aG3drU3XZ5/J9vpfMcWVkOXKRty1aZZ95AImLefAjrDvXF?=
 =?us-ascii?Q?I3OItn8maQzdZU74QKz+5W4a0l0IAFdLASM/w6mlpr8K/7WggN/O832kmRiP?=
 =?us-ascii?Q?8qS4czGkbdQUz47y1VlLfPL7NMAd/PkHfVuFkrc8ewblJHnk21GXmHa29Z3E?=
 =?us-ascii?Q?4np7ABo7u5ap0PIfynO91lnOYS5iSjHPcSo63PwoAfxSiKqeCW57kBp26Xyt?=
 =?us-ascii?Q?cqFhbK0fuAkqbMNSFdIff2n31W1580zws92zSD4z1oGKLQV3KRDMI1lc3jpq?=
 =?us-ascii?Q?irErg+KdIbf/hZKjdjXnwQLDIf0HZdmOU05njDTpOUK2Y3VVD83dqb7F+gnb?=
 =?us-ascii?Q?Gvgu0xAbMQGw/918ytM63C+4j6q2rN03Nt5PKSAsTL3cNII2QrH2EGu8hHgG?=
 =?us-ascii?Q?vsw8I1mMyQQdweJX/ijceqyeFXNk8H7PXYYyRbD6z0SKd45K8obWr2sMcZle?=
 =?us-ascii?Q?OSq/qkRvvr1+aDLBdoZOgapTbsHF4690DeYr52qrqRTECu5gMnTCJV6KaO0c?=
 =?us-ascii?Q?SIuCdGUlrUJ0tCAoNCRE4dQi0w0xy4xYzhaoJFs+egbOefYFn8zs8P62xf62?=
 =?us-ascii?Q?5fDES8CwlqVDQbCx20LjjKXaQGNdtLvVpXHM0VL8HQcezy+sQSESnFIEC1V3?=
 =?us-ascii?Q?fF6nHgGxrDee9AcvO4RkAHpl2u2VAnrFLtdt4shyq6+cu1u14+Ue4oOnGobH?=
 =?us-ascii?Q?Wo+DkPt6QEk92uAvAmkOPAAiMl7EDH5h+XA0hF9X5L7mkAS2gn4dZ2KUcies?=
 =?us-ascii?Q?pI5XOO4YA3RKF40CHtkT9y5tqS6wUzPnnuhkItx+P+C5dHEM8XNBns3u4nPb?=
 =?us-ascii?Q?TU/IzJDgq3Bu7ISPomG1i3lrlEFsXPatlUbmsdgJJJ/X9eGGYTZWA2KHO0wK?=
 =?us-ascii?Q?SG2LCrf8J6E0B+QnBKlqpiamCkTCPff1PNloQiQSfO2zz1nmY76P2+fJEnV+?=
 =?us-ascii?Q?IXpnnoGCoQS5IPOCxWVPnYJuAunO2F1hrdd8bgvMOEMcbVTKDUj1j7e8TbF1?=
 =?us-ascii?Q?IYb66YxfzGsWsMJFxtWJ+nNfxQO4S6goM6VjWf4YZCbHka7Xniuiokl69E15?=
 =?us-ascii?Q?A8V8P84W1BUZdqkEmv05onj3RKOr7y8ZgQJ5vUT9G+Re2tgjo3COYIxesP2g?=
 =?us-ascii?Q?vg7wpYJpPiA/m0dWNjZlZ3hhvqvm69qMX9a/fmbH3+chyVmHNli/91zuyT5N?=
 =?us-ascii?Q?4no80H7erhawrEzkXiauQHu5NP7sO7sRrJMq6KCE+N8QhFWsQyFapLdX8LPD?=
 =?us-ascii?Q?eMimHvg8+w0t9uIeEYHY3B+SdHJXHNBxxFCxP6J7rlbes6493uz3whYLD7X+?=
 =?us-ascii?Q?P7yEnVhiHBIJTiXXoe5lLd7WTUSAEkwPTLDNLNngBOUrBMnCiyZrpFmYItmt?=
 =?us-ascii?Q?NYNjgzT8QMzSNpuwYVmwRdfcQH7TcdJHBa0MVRQbWgU7ymT413+2++zyvcm2?=
 =?us-ascii?Q?CQA6iwynWVra7850MwadAuDf7ng/50HyLONnKskeiITAntJ0I9hvd/X06O7v?=
 =?us-ascii?Q?AzEZijAbkjX5FeJfMRLjZ95vWrU9fyDC+xWeKsoS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de7fae8-176c-46e5-06e9-08db682d8d31
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 14:35:06.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7Fb3sI/NBW4HhLnXY74R6kqcCD7O9pgoT660T1ShptcYzAleK/6pfmdUlQLLg8mAxSRUw+IISPPKjpBiRe3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
index 2b073facf399..2e8badb87da8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9098,6 +9098,12 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-logitech-hidpp.c
 
+HID NVIDIA SHIELD DRIVER
+M:	Rahul Rameshbabu <rrameshbabu@nvidia.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-nvidia-shield.c
+
 HID PLAYSTATION DRIVER
 M:	Roderick Colenbrander <roderick.colenbrander@sony.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 82f64fb31fda..b1790dc20d2d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -788,6 +788,24 @@ config HID_NTRIG
 	help
 	Support for N-Trig touch screen.
 
+config HID_NVIDIA_SHIELD
+	tristate "NVIDIA SHIELD devices"
+	depends on USB_HID
+	depends on BT_HIDP
+	help
+	  Support for NVIDIA SHIELD accessories.
+
+	  Supported devices:
+	  - Thunderstrike (NVIDIA SHIELD Controller 2017)
+
+config NVIDIA_SHIELD_FF
+	bool "NVIDIA SHIELD force feedback support"
+	depends on HID_NVIDIA_SHIELD
+	select INPUT_FF_MEMLESS
+	help
+	  Say Y here if you would like to enable force feedback support for
+	  NVIDIA SHIELD accessories with haptics capabilities.
+
 config HID_ORTEK
 	tristate "Ortek PKB-1700/WKB-2000/Skycable wireless keyboard and mouse trackpad"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 5d37cacbde33..7a9e160158f7 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
 obj-$(CONFIG_HID_NINTENDO)	+= hid-nintendo.o
 obj-$(CONFIG_HID_NTI)			+= hid-nti.o
 obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
+obj-$(CONFIG_HID_NVIDIA_SHIELD)	+= hid-nvidia-shield.o
 obj-$(CONFIG_HID_ORTEK)		+= hid-ortek.o
 obj-$(CONFIG_HID_PRODIKEYS)	+= hid-prodikeys.o
 obj-$(CONFIG_HID_PANTHERLORD)	+= hid-pl.o
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
index 000000000000..4182ad3a7b93
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
+	if (!IS_ENABLED(CONFIG_NVIDIA_SHIELD_FF))
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
+err:
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
2.38.5

