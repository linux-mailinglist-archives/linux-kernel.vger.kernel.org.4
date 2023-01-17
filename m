Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254A866DF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjAQNnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjAQNmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:42:37 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB7B33475;
        Tue, 17 Jan 2023 05:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+GWiATne6zij6PS+y+Fh27HVp6OI/Z0Z2QPsBJVTLFNQ7Kb/reiExffKalNlk1a5EhN1yBBIyNA3g2QCtNQFC9eotzqihCupvqerOL/TpDWRGt9bI6XWhkxvK6Zfz6kxaQg1EygnBk4xLF3amQ/5Yv6Nwx0pqnKXKVw9WepApefNiUZp155hmBnjl16lhxxXMKumqqNt2I08ODXEOHJP4kux/EPIKKB70ZOrRKk31i08zj4EhUNMccz/QpOxzGUbaHZ9grq5+SFOMId/LbrPkSe+KmWHtI9wztTI2lZMBNTJWeeNoMZcD8dgohxiLodaGQGI2+TGIt3j1+lU+nziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utOPQxpcNURxULdNm6+kRAYuSW/510ZHgRGYiG1uPd0=;
 b=LiOgWvueW/sG9qy2zIJecllpdPBaH9XEssKSUDiSnj0pf9o3AaEYPBk+k8ULzJyNGp8H0JYyNn0bHDCP59qCXzG9B8prDAuJ2onA/G8Wn9p6BKt6giiYNGW1nCRecFpZIkEgPKOnwMo2b1YWW8fvxtkgMdCyy0mfmULk9PlWrZBKh5zRNXnMjqF8ibMjBU8cgkGX7ySzKCJv8ec9udEczZvsctAWCVv88/NX369jaJ1+kxH10jFmCL0HHK0PEl/A/WzVjUrkNRWEu7KiOckq2662vtC5kysGPZdTDAQWCR9e7nz7n8cXuqqKg4OkqaLhOCz0DorWSxHpQjQE7JyWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utOPQxpcNURxULdNm6+kRAYuSW/510ZHgRGYiG1uPd0=;
 b=j6DjI4+muM1yHLh1h7Kw7o0q2L2l/v0i43gf2Y2b/8yL/YSLRtzHDFKSzI/D6tAgmfA5niV6A7XJYNkl1huqRPxe5vWNaCak7Se8cRd76YqOPw88/meTaxy86IY9iH919DvxbovsxEqLchyMCyC05YhOSZ69/eU+OJ94/2WCSbs=
Received: from DS7PR03CA0323.namprd03.prod.outlook.com (2603:10b6:8:2b::12) by
 SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 13:42:26 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::df) by DS7PR03CA0323.outlook.office365.com
 (2603:10b6:8:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 13:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 13:42:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 05:42:24 -0800
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 07:42:17 -0600
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <eric.auger@redhat.com>, <alex.williamson@redhat.com>,
        <cohuck@redhat.com>, <song.bao.hua@hisilicon.com>,
        <mchehab+huawei@kernel.org>, <maz@kernel.org>,
        <f.fainelli@gmail.com>, <jeffrey.l.hugo@gmail.com>,
        <saravanak@google.com>, <Michael.Srba@seznam.cz>,
        <mani@kernel.org>, <yishaih@nvidia.com>, <jgg@ziepe.ca>,
        <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <joro@8bytes.org>, <masahiroy@kernel.org>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH 04/19] bus/cdx: add MCDI protocol interface for firmware interaction
Date:   Tue, 17 Jan 2023 19:11:36 +0530
Message-ID: <20230117134139.1298-5-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117134139.1298-1-nipun.gupta@amd.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ce8eb5-f03a-4310-0be4-08daf890abc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWPBXME14irXT9XfcyJZFeRyVniOpdAlFYJXwJdpt5g1yfV+qcw339XS1fuCSgbz6OuDCgXBilpfG32e9ucVrt+ly+kbmIarY6iIpkVaphBhQaNLZdbSxxsGQNqjLsRcfuOUAB3tWC7vHecP+GecMnL6cvbqctBJpq7gXwqec/BYp0klI6MigIoRhc/i84Bttrvg/7GdQRVNQ2N7TnwwYIEMVWnCjQsYsrI9lahmbFAxwmG2mYXNIA0i1iP3B4Pi54BHq6lDAVKduMXodiKUdChM5SeCtX3QLGUgKYQcmHZ4OWTsDxVpSbusRZjwAy7qEHrXENIDMkUtKhoWUMeFLuteb/14Wkc9RficQPeYRHhtHXaY8orWMpk88t3T5U8NM3pxlxRxSek/CdY1DZX29GUOi4oBQ7M5uKmDp1FO++sY0k/zxDNhqUPJcj3N5+mr37I6VmeWCxXcO0JEHKFPcewZYr8RlVy4kVTAG0ajSXY3fEoATxaGtFUGWSUlKRLK4+XdbONyg4pts328NuH8iQB7rcaAy7GyDSADezuyOb0Gkza14YxAEfNiqWn4odr6i6y2dUqG1FqdGGKffm5n8KoUtm7TYduDmS0Ax72d7nqBU4jn0mNqSLUtwq7EHwCRLkdJfAkf7KpqcxQMlnQjjmuZLRCwSbHmjbBtNYtdB6g6moYfuO511Y9tRfJeN4LlHP11C/FeMUDii6w8UWEgCaZXADgcNT7TosUh5lEWwu16uaSMZGwZDVnSplU51ErL4vKorHYhU3M2KlfKxb2kImfxPDdsMPeVaDxyYtC9oqw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(921005)(86362001)(356005)(44832011)(8676002)(8936002)(70586007)(70206006)(4326008)(2906002)(30864003)(5660300002)(7416002)(82740400003)(81166007)(83380400001)(36860700001)(316002)(110136005)(40460700003)(426003)(45080400002)(54906003)(40480700001)(6666004)(41300700001)(478600001)(336012)(26005)(1076003)(82310400005)(2616005)(47076005)(186003)(36900700001)(2101003)(83996005)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:42:26.6099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ce8eb5-f03a-4310-0be4-08daf890abc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCDI (Management CPU Driver Interface) is used as a
protocol to communicate with the RPU firmware. It has
pre-defined set of messages for different message exchanges
between APU and RPU.

Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---
 drivers/bus/cdx/Kconfig                  |   2 +
 drivers/bus/cdx/Makefile                 |   2 +-
 drivers/bus/cdx/controller/Kconfig       |  20 +
 drivers/bus/cdx/controller/Makefile      |   9 +
 drivers/bus/cdx/controller/bitfield.h    |  88 +++
 drivers/bus/cdx/controller/mc_cdx_pcol.h | 590 +++++++++++++++
 drivers/bus/cdx/controller/mcdi.c        | 918 +++++++++++++++++++++++
 drivers/bus/cdx/controller/mcdi.h        | 250 ++++++
 8 files changed, 1878 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bus/cdx/controller/Kconfig
 create mode 100644 drivers/bus/cdx/controller/Makefile
 create mode 100644 drivers/bus/cdx/controller/bitfield.h
 create mode 100644 drivers/bus/cdx/controller/mc_cdx_pcol.h
 create mode 100644 drivers/bus/cdx/controller/mcdi.c
 create mode 100644 drivers/bus/cdx/controller/mcdi.h

diff --git a/drivers/bus/cdx/Kconfig b/drivers/bus/cdx/Kconfig
index 54e0623ebcff..a7e474d621e0 100644
--- a/drivers/bus/cdx/Kconfig
+++ b/drivers/bus/cdx/Kconfig
@@ -12,3 +12,5 @@ config CDX_BUS
 	  scanning and probing of CDX devices. CDX devices are memory
 	  mapped on system bus for embedded CPUs. CDX bus uses CDX
 	  controller and firmware to scan the CDX devices.
+
+source "drivers/bus/cdx/controller/Kconfig"
diff --git a/drivers/bus/cdx/Makefile b/drivers/bus/cdx/Makefile
index c5feb11fc718..0324e4914f6e 100644
--- a/drivers/bus/cdx/Makefile
+++ b/drivers/bus/cdx/Makefile
@@ -5,4 +5,4 @@
 # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
 #
 
-obj-$(CONFIG_CDX_BUS) += cdx.o
+obj-$(CONFIG_CDX_BUS) += cdx.o controller/
diff --git a/drivers/bus/cdx/controller/Kconfig b/drivers/bus/cdx/controller/Kconfig
new file mode 100644
index 000000000000..785c71063b2a
--- /dev/null
+++ b/drivers/bus/cdx/controller/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# CDX controller configuration
+#
+# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+#
+
+if CDX_BUS
+
+config MCDI_LOGGING
+	bool "MCDI Logging for the CDX controller"
+	depends on CDX_CONTROLLER
+	help
+	  Enable MCDI Logging for
+	  the CDX Controller for debug
+	  purpose.
+
+	  If unsure, say N.
+
+endif
diff --git a/drivers/bus/cdx/controller/Makefile b/drivers/bus/cdx/controller/Makefile
new file mode 100644
index 000000000000..0ce200678eda
--- /dev/null
+++ b/drivers/bus/cdx/controller/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for CDX controller drivers
+#
+# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+#
+
+obj-$(CONFIG_CDX_CONTROLLER) += cdx-controller.o
+cdx-controller-objs := mcdi.o
diff --git a/drivers/bus/cdx/controller/bitfield.h b/drivers/bus/cdx/controller/bitfield.h
new file mode 100644
index 000000000000..d390e48239d5
--- /dev/null
+++ b/drivers/bus/cdx/controller/bitfield.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2005-2006 Fen Systems Ltd.
+ * Copyright 2006-2013 Solarflare Communications Inc.
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef CDX_BITFIELD_H
+#define CDX_BITFIELD_H
+
+/* Lowest bit numbers and widths */
+#define CDX_DWORD_LBN 0
+#define CDX_DWORD_WIDTH 32
+
+/* Specified attribute (e.g. LBN) of the specified field */
+#define CDX_VAL(field, attribute) field ## _ ## attribute
+/* Low bit number of the specified field */
+#define CDX_LOW_BIT(field) CDX_VAL(field, LBN)
+/* Bit width of the specified field */
+#define CDX_WIDTH(field) CDX_VAL(field, WIDTH)
+/* High bit number of the specified field */
+#define CDX_HIGH_BIT(field) (CDX_LOW_BIT(field) + CDX_WIDTH(field) - 1)
+
+/* A doubleword (i.e. 4 byte) datatype - little-endian in HW */
+struct cdx_dword {
+	__le32 cdx_u32;
+};
+
+/* Value expanders for printk */
+#define CDX_DWORD_VAL(dword)				\
+	((unsigned int)le32_to_cpu((dword).cdx_u32))
+
+/*
+ * Extract bit field portion [low,high) from the 32-bit little-endian
+ * element which contains bits [min,max)
+ */
+#define CDX_DWORD_FIELD(dword, field)					\
+	(FIELD_GET(GENMASK(CDX_HIGH_BIT(field), CDX_LOW_BIT(field)),	\
+		  (dword).cdx_u32))
+
+/*
+ * Creates the portion of the named bit field that lies within the
+ * range [min,max).
+ */
+#define CDX_INSERT_FIELD(field, value)				\
+	(FIELD_PREP(GENMASK(CDX_HIGH_BIT(field),		\
+			    CDX_LOW_BIT(field)), value))
+
+/*
+ * Creates the portion of the named bit fields that lie within the
+ * range [min,max).
+ */
+#define CDX_INSERT_FIELDS(field1, value1,		\
+			  field2, value2,		\
+			  field3, value3,		\
+			  field4, value4,		\
+			  field5, value5,		\
+			  field6, value6,		\
+			  field7, value7)		\
+	(CDX_INSERT_FIELD(field1, (value1)) |		\
+	 CDX_INSERT_FIELD(field2, (value2)) |		\
+	 CDX_INSERT_FIELD(field3, (value3)) |		\
+	 CDX_INSERT_FIELD(field4, (value4)) |		\
+	 CDX_INSERT_FIELD(field5, (value5)) |		\
+	 CDX_INSERT_FIELD(field6, (value6)) |		\
+	 CDX_INSERT_FIELD(field7, (value7)))
+
+#define CDX_POPULATE_DWORD(dword, ...)					\
+	(dword).cdx_u32 = cpu_to_le32(CDX_INSERT_FIELDS(__VA_ARGS__))
+
+/* Populate a dword field with various numbers of arguments */
+#define CDX_POPULATE_DWORD_7 CDX_POPULATE_DWORD
+#define CDX_POPULATE_DWORD_6(dword, ...) \
+	CDX_POPULATE_DWORD_7(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_5(dword, ...) \
+	CDX_POPULATE_DWORD_6(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_4(dword, ...) \
+	CDX_POPULATE_DWORD_5(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_3(dword, ...) \
+	CDX_POPULATE_DWORD_4(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_2(dword, ...) \
+	CDX_POPULATE_DWORD_3(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_1(dword, ...) \
+	CDX_POPULATE_DWORD_2(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_SET_DWORD(dword) \
+	CDX_POPULATE_DWORD_1(dword, CDX_DWORD, 0xffffffff)
+
+#endif /* CDX_BITFIELD_H */
diff --git a/drivers/bus/cdx/controller/mc_cdx_pcol.h b/drivers/bus/cdx/controller/mc_cdx_pcol.h
new file mode 100644
index 000000000000..902c856b1c5c
--- /dev/null
+++ b/drivers/bus/cdx/controller/mc_cdx_pcol.h
@@ -0,0 +1,590 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Driver for AMD network controllers and boards
+ *
+ * Copyright (C) 2021, Xilinx, Inc.
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef MC_CDX_PCOL_H
+#define MC_CDX_PCOL_H
+
+/* The current version of the MCDI protocol. */
+#define MCDI_PCOL_VERSION 2
+
+/*
+ * Each MCDI request starts with an MCDI_HEADER, which is a 32bit
+ * structure, filled in by the client.
+ *
+ *       0       7  8     16    20     22  23  24    31
+ *      | CODE | R | LEN | SEQ | Rsvd | E | R | XFLAGS |
+ *               |                      |   |
+ *               |                      |   \--- Response
+ *               |                      \------- Error
+ *               \------------------------------ Resync (always set)
+ *
+ * The client writes its request into MC shared memory, and rings the
+ * doorbell. Each request is completed either by the MC writing
+ * back into shared memory, or by writing out an event.
+ *
+ * All MCDI commands support completion by shared memory response. Each
+ * request may also contain additional data (accounted for by HEADER.LEN),
+ * and some responses may also contain additional data (again, accounted
+ * for by HEADER.LEN).
+ *
+ * Some MCDI commands support completion by event, in which any associated
+ * response data is included in the event.
+ *
+ * The protocol requires one response to be delivered for every request; a
+ * request should not be sent unless the response for the previous request
+ * has been received (either by polling shared memory, or by receiving
+ * an event).
+ */
+
+/** Request/Response structure */
+#define MCDI_HEADER_OFST 0
+#define MCDI_HEADER_CODE_LBN 0
+#define MCDI_HEADER_CODE_WIDTH 7
+#define MCDI_HEADER_RESYNC_LBN 7
+#define MCDI_HEADER_RESYNC_WIDTH 1
+#define MCDI_HEADER_DATALEN_LBN 8
+#define MCDI_HEADER_DATALEN_WIDTH 8
+#define MCDI_HEADER_SEQ_LBN 16
+#define MCDI_HEADER_SEQ_WIDTH 4
+#define MCDI_HEADER_RSVD_LBN 20
+#define MCDI_HEADER_RSVD_WIDTH 1
+#define MCDI_HEADER_NOT_EPOCH_LBN 21
+#define MCDI_HEADER_NOT_EPOCH_WIDTH 1
+#define MCDI_HEADER_ERROR_LBN 22
+#define MCDI_HEADER_ERROR_WIDTH 1
+#define MCDI_HEADER_RESPONSE_LBN 23
+#define MCDI_HEADER_RESPONSE_WIDTH 1
+#define MCDI_HEADER_XFLAGS_LBN 24
+#define MCDI_HEADER_XFLAGS_WIDTH 8
+/* Request response using event */
+#define MCDI_HEADER_XFLAGS_EVREQ 0x01
+/* Request (and signal) early doorbell return */
+#define MCDI_HEADER_XFLAGS_DBRET 0x02
+
+/* Maximum number of payload bytes */
+#define MCDI_CTL_SDU_LEN_MAX_V2 0x400
+
+#define MCDI_CTL_SDU_LEN_MAX MCDI_CTL_SDU_LEN_MAX_V2
+
+/*
+ * The MC can generate events for two reasons:
+ *   - To advance a shared memory request if XFLAGS_EVREQ was set
+ *   - As a notification (link state, i2c event), controlled
+ *     via MC_CMD_LOG_CTRL
+ *
+ * Both events share a common structure:
+ *
+ *  0      32     33      36    44     52     60
+ * | Data | Cont | Level | Src | Code | Rsvd |
+ *           |
+ *           \ There is another event pending in this notification
+ *
+ * If Code==CMDDONE, then the fields are further interpreted as:
+ *
+ *   - LEVEL==INFO    Command succeeded
+ *   - LEVEL==ERR     Command failed
+ *
+ *    0     8         16      24     32
+ *   | Seq | Datalen | Errno | Rsvd |
+ *
+ *   These fields are taken directly out of the standard MCDI header, i.e.,
+ *   LEVEL==ERR, Datalen == 0 => Reboot
+ *
+ * Events can be squirted out of the UART (using LOG_CTRL) without a
+ * MCDI header.  An event can be distinguished from a MCDI response by
+ * examining the first byte which is 0xc0.  This corresponds to the
+ * non-existent MCDI command MC_CMD_DEBUG_LOG.
+ *
+ *      0         7        8
+ *     | command | Resync |     = 0xc0
+ *
+ * Since the event is written in big-endian byte order, this works
+ * providing bits 56-63 of the event are 0xc0.
+ *
+ *      56     60  63
+ *     | Rsvd | Code |    = 0xc0
+ *
+ * Which means for convenience the event code is 0xc for all MC
+ * generated events.
+ */
+
+/*
+ * the errno value may be followed by the (0-based) number of the
+ * first argument that could not be processed.
+ */
+#define MC_CMD_ERR_ARG_OFST 4
+
+/* MC_CMD_ERR enum: MCDI error codes. */
+/* enum: Operation not permitted. */
+#define MC_CMD_ERR_EPERM 0x1
+/* enum: Non-existent command target */
+#define MC_CMD_ERR_ENOENT 0x2
+/* enum: assert() has killed the MC */
+#define MC_CMD_ERR_EINTR 0x4
+/* enum: I/O failure */
+#define MC_CMD_ERR_EIO 0x5
+/* enum: Already exists */
+#define MC_CMD_ERR_EEXIST 0x6
+/* enum: Try again */
+#define MC_CMD_ERR_EAGAIN 0xb
+/* enum: Out of memory */
+#define MC_CMD_ERR_ENOMEM 0xc
+/* enum: Caller does not hold required locks */
+#define MC_CMD_ERR_EACCES 0xd
+/* enum: Resource is currently unavailable (e.g. lock contention) */
+#define MC_CMD_ERR_EBUSY 0x10
+/* enum: No such device */
+#define MC_CMD_ERR_ENODEV 0x13
+/* enum: Invalid argument to target */
+#define MC_CMD_ERR_EINVAL 0x16
+/* enum: No space */
+#define MC_CMD_ERR_ENOSPC 0x1c
+/* enum: Read-only */
+#define MC_CMD_ERR_EROFS 0x1e
+/* enum: Broken pipe */
+#define MC_CMD_ERR_EPIPE 0x20
+/* enum: Out of range */
+#define MC_CMD_ERR_ERANGE 0x22
+/* enum: Non-recursive resource is already acquired */
+#define MC_CMD_ERR_EDEADLK 0x23
+/* enum: Operation not implemented */
+#define MC_CMD_ERR_ENOSYS 0x26
+/* enum: Operation timed out */
+#define MC_CMD_ERR_ETIME 0x3e
+/* enum: Link has been severed */
+#define MC_CMD_ERR_ENOLINK 0x43
+/* enum: Protocol error */
+#define MC_CMD_ERR_EPROTO 0x47
+/* enum: Bad message */
+#define MC_CMD_ERR_EBADMSG 0x4a
+/* enum: Operation not supported */
+#define MC_CMD_ERR_ENOTSUP 0x5f
+/* enum: Address not available */
+#define MC_CMD_ERR_EADDRNOTAVAIL 0x63
+/* enum: Not connected */
+#define MC_CMD_ERR_ENOTCONN 0x6b
+/* enum: Operation already in progress */
+#define MC_CMD_ERR_EALREADY 0x72
+/* enum: Stale handle. The handle references resource that no longer exists */
+#define MC_CMD_ERR_ESTALE 0x74
+/* enum: Resource allocation failed. */
+#define MC_CMD_ERR_ALLOC_FAIL 0x1000
+/* enum: V-adaptor not found. */
+#define MC_CMD_ERR_NO_VADAPTOR 0x1001
+/* enum: EVB port not found. */
+#define MC_CMD_ERR_NO_EVB_PORT 0x1002
+/* enum: V-switch not found. */
+#define MC_CMD_ERR_NO_VSWITCH 0x1003
+/* enum: Too many VLAN tags. */
+#define MC_CMD_ERR_VLAN_LIMIT 0x1004
+/* enum: Bad PCI function number. */
+#define MC_CMD_ERR_BAD_PCI_FUNC 0x1005
+/* enum: Invalid VLAN mode. */
+#define MC_CMD_ERR_BAD_VLAN_MODE 0x1006
+/* enum: Invalid v-switch type. */
+#define MC_CMD_ERR_BAD_VSWITCH_TYPE 0x1007
+/* enum: Invalid v-port type. */
+#define MC_CMD_ERR_BAD_VPORT_TYPE 0x1008
+/* enum: MAC address exists. */
+#define MC_CMD_ERR_MAC_EXIST 0x1009
+/* enum: Slave core not present */
+#define MC_CMD_ERR_SLAVE_NOT_PRESENT 0x100a
+/* enum: The datapath is disabled. */
+#define MC_CMD_ERR_DATAPATH_DISABLED 0x100b
+/* enum: The requesting client is not a function */
+#define MC_CMD_ERR_CLIENT_NOT_FN 0x100c
+/*
+ * enum: The requested operation might require the command to be passed between
+ * MCs, and thetransport doesn't support that. Should only ever been seen over
+ * the UART.
+ */
+#define MC_CMD_ERR_NO_PRIVILEGE 0x1013
+/*
+ * enum: Workaround 26807 could not be turned on/off because some functions
+ * have already installed filters. See the comment at
+ * MC_CMD_WORKAROUND_BUG26807. May also returned for other operations such as
+ * sub-variant switching.
+ */
+#define MC_CMD_ERR_FILTERS_PRESENT 0x1014
+/* enum: The clock whose frequency you've attempted to set doesn't exist */
+#define MC_CMD_ERR_NO_CLOCK 0x1015
+/*
+ * enum: Returned by MC_CMD_TESTASSERT if the action that should have caused an
+ * assertion failed to do so.
+ */
+#define MC_CMD_ERR_UNREACHABLE 0x1016
+/*
+ * enum: This command needs to be processed in the background but there were no
+ * resources to do so. Send it again after a command has completed.
+ */
+#define MC_CMD_ERR_QUEUE_FULL 0x1017
+/*
+ * enum: The operation could not be completed because the PCIe link has gone
+ * away. This error code is never expected to be returned over the TLP
+ * transport.
+ */
+#define MC_CMD_ERR_NO_PCIE 0x1018
+/*
+ * enum: The operation could not be completed because the datapath has gone
+ * away. This is distinct from MC_CMD_ERR_DATAPATH_DISABLED in that the
+ * datapath absence may be temporary
+ */
+#define MC_CMD_ERR_NO_DATAPATH 0x1019
+/* enum: The operation could not complete because some VIs are allocated */
+#define MC_CMD_ERR_VIS_PRESENT 0x101a
+/*
+ * enum: The operation could not complete because some PIO buffers are
+ * allocated
+ */
+#define MC_CMD_ERR_PIOBUFS_PRESENT 0x101b
+
+/***********************************/
+/*
+ * MC_CMD_CDX_BUS_ENUM_BUSES
+ * CDX bus hosts devices (functions) that are implemented using the Composable
+ * DMA subsystem and directly mapped into the memory space of the FGPA PSX
+ * Application Processors (APUs). As such, they only apply to the PSX APU side,
+ * not the host (PCIe). Unlike PCIe, these devices have no native configuration
+ * space or enumeration mechanism, so this message set provides a minimal
+ * interface for discovery and management (bus reset, FLR, BME) of such
+ * devices. This command returns the number of CDX buses present in the system.
+ */
+#define MC_CMD_CDX_BUS_ENUM_BUSES 0x1
+#define MC_CMD_CDX_BUS_ENUM_BUSES_MSGSET 0x1
+#undef MC_CMD_0x1_PRIVILEGE_CTG
+
+#define MC_CMD_0x1_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_BUS_ENUM_BUSES_IN msgrequest */
+#define MC_CMD_CDX_BUS_ENUM_BUSES_IN_LEN 0
+
+/* MC_CMD_CDX_BUS_ENUM_BUSES_OUT msgresponse */
+#define MC_CMD_CDX_BUS_ENUM_BUSES_OUT_LEN 4
+/*
+ * Number of CDX buses present in the system. Buses are numbered 0 to
+ * BUS_COUNT-1
+ */
+#define MC_CMD_CDX_BUS_ENUM_BUSES_OUT_BUS_COUNT_OFST 0
+#define MC_CMD_CDX_BUS_ENUM_BUSES_OUT_BUS_COUNT_LEN 4
+
+/***********************************/
+/*
+ * MC_CMD_CDX_BUS_ENUM_DEVICES
+ * Enumerate CDX bus devices on a given bus
+ */
+#define MC_CMD_CDX_BUS_ENUM_DEVICES 0x2
+#define MC_CMD_CDX_BUS_ENUM_DEVICES_MSGSET 0x2
+#undef MC_CMD_0x2_PRIVILEGE_CTG
+
+#define MC_CMD_0x2_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_BUS_ENUM_DEVICES_IN msgrequest */
+#define MC_CMD_CDX_BUS_ENUM_DEVICES_IN_LEN 4
+/*
+ * Bus number to enumerate, in range 0 to BUS_COUNT-1, as returned by
+ * MC_CMD_CDX_BUS_ENUM_BUSES_OUT
+ */
+#define MC_CMD_CDX_BUS_ENUM_DEVICES_IN_BUS_OFST 0
+#define MC_CMD_CDX_BUS_ENUM_DEVICES_IN_BUS_LEN 4
+
+/* MC_CMD_CDX_BUS_ENUM_DEVICES_OUT msgresponse */
+#define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_LEN 4
+/*
+ * Number of devices present on the bus. Devices on the bus are numbered 0 to
+ * DEVICE_COUNT-1. Returns EAGAIN if number of devices unknown or if the target
+ * devices are not ready (e.g. undergoing a bus reset)
+ */
+#define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT_OFST 0
+#define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT_LEN 4
+
+/***********************************/
+/*
+ * MC_CMD_CDX_BUS_GET_DEVICE_CONFIG
+ * Returns device identification and MMIO/MSI resource data for a CDX device.
+ * The expected usage is for the caller to first retrieve the number of devices
+ * on the bus using MC_CMD_BUS_ENUM_DEVICES, then loop through the range (0,
+ * DEVICE_COUNT - 1), retrieving device resource data. May return EAGAIN if the
+ * number of exposed devices or device resources change during enumeration (due
+ * to e.g. a PL reload / bus reset), in which case the caller is expected to
+ * restart the enumeration loop. MMIO addresses are specified in terms of bus
+ * addresses (prior to any potential IOMMU translation). For versal-net, these
+ * are equivalent to APU physical addresses. Implementation note - for this to
+ * work, the implementation needs to keep state (generation count) per client.
+ */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG 0x3
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_MSGSET 0x3
+#undef MC_CMD_0x3_PRIVILEGE_CTG
+
+#define MC_CMD_0x3_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN msgrequest */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN_LEN 8
+/* Device bus number, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN_BUS_OFST 0
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN_BUS_LEN 4
+/* Device number relative to the bus, in range 0 to DEVICE_COUNT-1 for that bus */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN_DEVICE_OFST 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN_DEVICE_LEN 4
+
+/* MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT msgresponse */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_LEN 88
+/* 16-bit Vendor identifier, compliant with PCI-SIG VendorID assignment. */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_VENDOR_ID_OFST 0
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_VENDOR_ID_LEN 2
+/* 16-bit Device ID assigned by the vendor */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_ID_OFST 2
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_ID_LEN 2
+/*
+ * 16-bit Subsystem Vendor ID, , compliant with PCI-SIG VendorID assignment.
+ * For further device differentiation, as required. 0 if unused.
+ */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_VENDOR_ID_OFST 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_VENDOR_ID_LEN 2
+/*
+ * 16-bit Subsystem Device ID assigned by the vendor. For further device
+ * differentiation, as required. 0 if unused.
+ */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_DEVICE_ID_OFST 6
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_DEVICE_ID_LEN 2
+/* 24-bit Device Class code, compliant with PCI-SIG Device Class codes */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_CLASS_OFST 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_CLASS_LEN 3
+/* 8-bit vendor-assigned revision */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_REVISION_OFST 11
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_REVISION_LEN 1
+/* Reserved (alignment) */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_RESERVED_OFST 12
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_RESERVED_LEN 4
+/* MMIO region 0 base address (bus address), 0 if unused */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_OFST 16
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_LEN 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_LO_OFST 16
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_LO_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_LO_LBN 128
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_LO_WIDTH 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_HI_OFST 20
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_HI_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_HI_LBN 160
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE_HI_WIDTH 32
+/* MMIO region 0 size, 0 if unused */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_OFST 24
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_LEN 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_LO_OFST 24
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_LO_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_LO_LBN 192
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_LO_WIDTH 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_HI_OFST 28
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_HI_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_HI_LBN 224
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE_HI_WIDTH 32
+/* MMIO region 1 base address (bus address), 0 if unused */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_OFST 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_LEN 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_LO_OFST 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_LO_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_LO_LBN 256
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_LO_WIDTH 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_HI_OFST 36
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_HI_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_HI_LBN 288
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE_HI_WIDTH 32
+/* MMIO region 1 size, 0 if unused */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_OFST 40
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_LEN 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_LO_OFST 40
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_LO_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_LO_LBN 320
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_LO_WIDTH 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_HI_OFST 44
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_HI_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_HI_LBN 352
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE_HI_WIDTH 32
+/* MMIO region 2 base address (bus address), 0 if unused */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_OFST 48
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_LEN 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_LO_OFST 48
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_LO_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_LO_LBN 384
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_LO_WIDTH 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_HI_OFST 52
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_HI_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_HI_LBN 416
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE_HI_WIDTH 32
+/* MMIO region 2 size, 0 if unused */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_OFST 56
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_LEN 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_LO_OFST 56
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_LO_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_LO_LBN 448
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_LO_WIDTH 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_HI_OFST 60
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_HI_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_HI_LBN 480
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE_HI_WIDTH 32
+/* MMIO region 3 base address (bus address), 0 if unused */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_OFST 64
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_LEN 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_LO_OFST 64
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_LO_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_LO_LBN 512
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_LO_WIDTH 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_HI_OFST 68
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_HI_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_HI_LBN 544
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE_HI_WIDTH 32
+/* MMIO region 3 size, 0 if unused */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_OFST 72
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_LEN 8
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_LO_OFST 72
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_LO_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_LO_LBN 576
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_LO_WIDTH 32
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_HI_OFST 76
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_HI_LEN 4
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_HI_LBN 608
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE_HI_WIDTH 32
+/* MSI vector count */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MSI_COUNT_OFST 80
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_MSI_COUNT_LEN 4
+/* Requester ID used by device (SMMU StreamID, GIC ITS DeviceID) */
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_OFST 84
+#define MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID_LEN 4
+
+/***********************************/
+/*
+ * MC_CMD_CDX_DEVICE_RESET
+ * After this call completes, device DMA and interrupts are quiesced, devices
+ * logic is reset in a hardware-specific way and DMA bus mastering is disabled.
+ */
+#define MC_CMD_CDX_DEVICE_RESET 0x6
+#define MC_CMD_CDX_DEVICE_RESET_MSGSET 0x6
+#undef MC_CMD_0x6_PRIVILEGE_CTG
+
+#define MC_CMD_0x6_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_DEVICE_RESET_IN msgrequest */
+#define MC_CMD_CDX_DEVICE_RESET_IN_LEN 8
+/* Device bus number, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_DEVICE_RESET_IN_BUS_OFST 0
+#define MC_CMD_CDX_DEVICE_RESET_IN_BUS_LEN 4
+/* Device number relative to the bus, in range 0 to DEVICE_COUNT-1 for that bus */
+#define MC_CMD_CDX_DEVICE_RESET_IN_DEVICE_OFST 4
+#define MC_CMD_CDX_DEVICE_RESET_IN_DEVICE_LEN 4
+
+/*
+ * MC_CMD_CDX_DEVICE_RESET_OUT msgresponse: The device is quiesced and all
+ * pending device initiated DMA has completed.
+ */
+#define MC_CMD_CDX_DEVICE_RESET_OUT_LEN 0
+
+/***********************************/
+/*
+ * MC_CMD_CDX_DEVICE_CONTROL_SET
+ * If BUS_MASTER is set to disabled, device DMA and interrupts are quiesced.
+ * Pending DMA requests and MSI interrupts are flushed and no further DMA or
+ * interrupts are issued after this command returns. If BUS_MASTER is set to
+ * enabled, device is allowed to initiate DMA. Whether interrupts are enabled
+ * also depends on the value of MSI_ENABLE bit. Note that, in this case, the
+ * device may start DMA before the host receives and processes the MCDI
+ * response. MSI_ENABLE masks or unmasks device interrupts only. Note that for
+ * interrupts to be delivered to the host, both BUS_MASTER and MSI_ENABLE needs
+ * to be set. MMIO_REGIONS_ENABLE enables or disables host accesses to device
+ * MMIO regions. Note that an implementation is allowed to permanently set this
+ * bit to 1, in which case MC_CMD_CDX_DEVICE_CONTROL_GET will always return 1
+ * for this bit, regardless of the value set here.
+ */
+#define MC_CMD_CDX_DEVICE_CONTROL_SET 0x7
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_MSGSET 0x7
+#undef MC_CMD_0x7_PRIVILEGE_CTG
+
+#define MC_CMD_0x7_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_DEVICE_CONTROL_SET_IN msgrequest */
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_LEN 12
+/* Device bus number, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_OFST 0
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_LEN 4
+/* Device number relative to the bus, in range 0 to DEVICE_COUNT-1 for that bus */
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_DEVICE_OFST 4
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_DEVICE_LEN 4
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_FLAGS_OFST 8
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_FLAGS_LEN 4
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_MASTER_ENABLE_OFST 8
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_MASTER_ENABLE_LBN 0
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_MASTER_ENABLE_WIDTH 1
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_MSI_ENABLE_OFST 8
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_MSI_ENABLE_LBN 1
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_MSI_ENABLE_WIDTH 1
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_MMIO_REGIONS_ENABLE_OFST 8
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_MMIO_REGIONS_ENABLE_LBN 2
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_IN_MMIO_REGIONS_ENABLE_WIDTH 1
+
+/* MC_CMD_CDX_DEVICE_CONTROL_SET_OUT msgresponse */
+#define MC_CMD_CDX_DEVICE_CONTROL_SET_OUT_LEN 0
+
+/***********************************/
+/*
+ * MC_CMD_CDX_DEVICE_CONTROL_GET
+ * Returns device DMA, interrupt and MMIO region access control bits. See
+ * MC_CMD_CDX_DEVICE_CONTROL_SET for definition of the available control bits.
+ */
+#define MC_CMD_CDX_DEVICE_CONTROL_GET 0x8
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_MSGSET 0x8
+#undef MC_CMD_0x8_PRIVILEGE_CTG
+
+#define MC_CMD_0x8_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_DEVICE_CONTROL_GET_IN msgrequest */
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_IN_LEN 8
+/* Device bus number, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_IN_BUS_OFST 0
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_IN_BUS_LEN 4
+/* Device number relative to the bus, in range 0 to DEVICE_COUNT-1 for that bus */
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_IN_DEVICE_OFST 4
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_IN_DEVICE_LEN 4
+
+/* MC_CMD_CDX_DEVICE_CONTROL_GET_OUT msgresponse */
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN 4
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_FLAGS_OFST 0
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_FLAGS_LEN 4
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_BUS_MASTER_ENABLE_OFST 0
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_BUS_MASTER_ENABLE_LBN 0
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_BUS_MASTER_ENABLE_WIDTH 1
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MSI_ENABLE_OFST 0
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MSI_ENABLE_LBN 1
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MSI_ENABLE_WIDTH 1
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_OFST 0
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_LBN 2
+#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_WIDTH 1
+
+/***********************************/
+/* MC_CMD_V2_EXTN - Encapsulation for a v2 extended command */
+#define MC_CMD_V2_EXTN 0x7f
+
+/* MC_CMD_V2_EXTN_IN msgrequest */
+#define MC_CMD_V2_EXTN_IN_LEN 4
+/* the extended command number */
+#define MC_CMD_V2_EXTN_IN_EXTENDED_CMD_LBN 0
+#define MC_CMD_V2_EXTN_IN_EXTENDED_CMD_WIDTH 15
+#define MC_CMD_V2_EXTN_IN_UNUSED_LBN 15
+#define MC_CMD_V2_EXTN_IN_UNUSED_WIDTH 1
+/* the actual length of the encapsulated command */
+#define MC_CMD_V2_EXTN_IN_ACTUAL_LEN_LBN 16
+#define MC_CMD_V2_EXTN_IN_ACTUAL_LEN_WIDTH 10
+#define MC_CMD_V2_EXTN_IN_UNUSED2_LBN 26
+#define MC_CMD_V2_EXTN_IN_UNUSED2_WIDTH 2
+/* Type of command/response */
+#define MC_CMD_V2_EXTN_IN_MESSAGE_TYPE_LBN 28
+#define MC_CMD_V2_EXTN_IN_MESSAGE_TYPE_WIDTH 4
+/*
+ * enum: MCDI command directed to versal-net. MCDI responses of this type
+ * are not defined.
+ */
+#define MC_CMD_V2_EXTN_IN_MCDI_MESSAGE_TYPE_PLATFORM 0x2
+
+#endif /* MC_CDX_PCOL_H */
diff --git a/drivers/bus/cdx/controller/mcdi.c b/drivers/bus/cdx/controller/mcdi.c
new file mode 100644
index 000000000000..49020e79dd1c
--- /dev/null
+++ b/drivers/bus/cdx/controller/mcdi.c
@@ -0,0 +1,918 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Management-Controller-to-Driver Interface
+ *
+ * Copyright 2008-2013 Solarflare Communications Inc.
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/if_vlan.h>
+#include <linux/timer.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/version.h>
+#include <linux/rwsem.h>
+#include <linux/vmalloc.h>
+#include <net/netevent.h>
+#include <linux/log2.h>
+#include <linux/net_tstamp.h>
+#include <linux/wait.h>
+
+#include "bitfield.h"
+#include "mcdi.h"
+
+struct cdx_mcdi_copy_buffer {
+	struct cdx_dword buffer[DIV_ROUND_UP(MCDI_CTL_SDU_LEN_MAX, 4)];
+};
+
+#ifdef CONFIG_MCDI_LOGGING
+#define LOG_LINE_MAX		(1024 - 32)
+#endif
+
+static void cdx_mcdi_cancel_cmd(struct cdx_mcdi *cdx, struct cdx_mcdi_cmd *cmd);
+static void cdx_mcdi_wait_for_cleanup(struct cdx_mcdi *cdx);
+static int cdx_mcdi_rpc_async_internal(struct cdx_mcdi *cdx,
+				       struct cdx_mcdi_cmd *cmd,
+				       unsigned int *handle);
+static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
+				    bool allow_retry);
+static void cdx_mcdi_cmd_start_or_queue(struct cdx_mcdi_iface *mcdi,
+					struct cdx_mcdi_cmd *cmd);
+static void cdx_mcdi_cmd_start_or_queue_ext(struct cdx_mcdi_iface *mcdi,
+					    struct cdx_mcdi_cmd *cmd);
+static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
+				  struct cdx_mcdi_cmd *cmd,
+				  struct cdx_mcdi_copy_buffer *copybuf,
+				  struct list_head *cleanup_list);
+static void cdx_mcdi_timeout_cmd(struct cdx_mcdi_iface *mcdi,
+				 struct cdx_mcdi_cmd *cmd,
+				 struct list_head *cleanup_list);
+static void cdx_mcdi_cmd_work(struct work_struct *context);
+static void cdx_mcdi_mode_fail(struct cdx_mcdi *cdx, struct list_head *cleanup_list);
+static void _cdx_mcdi_display_error(struct cdx_mcdi *cdx, unsigned int cmd,
+				    size_t inlen, int raw, int arg, int rc);
+
+static bool cdx_cmd_cancelled(struct cdx_mcdi_cmd *cmd)
+{
+	return cmd->state == MCDI_STATE_RUNNING_CANCELLED;
+}
+
+static void cdx_mcdi_cmd_release(struct kref *ref)
+{
+	kfree(container_of(ref, struct cdx_mcdi_cmd, ref));
+}
+
+static unsigned int cdx_mcdi_cmd_handle(struct cdx_mcdi_cmd *cmd)
+{
+	return cmd->handle;
+}
+
+static void _cdx_mcdi_remove_cmd(struct cdx_mcdi_iface *mcdi,
+				 struct cdx_mcdi_cmd *cmd,
+				 struct list_head *cleanup_list)
+{
+	/* if cancelled, the completers have already been called */
+	if (cdx_cmd_cancelled(cmd))
+		return;
+
+	if (cmd->completer) {
+		list_add_tail(&cmd->cleanup_list, cleanup_list);
+		++mcdi->outstanding_cleanups;
+		kref_get(&cmd->ref);
+	}
+}
+
+static void cdx_mcdi_remove_cmd(struct cdx_mcdi_iface *mcdi,
+				struct cdx_mcdi_cmd *cmd,
+				struct list_head *cleanup_list)
+{
+	list_del(&cmd->list);
+	_cdx_mcdi_remove_cmd(mcdi, cmd, cleanup_list);
+	cmd->state = MCDI_STATE_FINISHED;
+	kref_put(&cmd->ref, cdx_mcdi_cmd_release);
+	if (list_empty(&mcdi->cmd_list))
+		wake_up(&mcdi->cmd_complete_wq);
+}
+
+static unsigned long cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd)
+{
+	if (!cdx->mcdi_ops->mcdi_rpc_timeout)
+		return MCDI_RPC_TIMEOUT;
+	else
+		return cdx->mcdi_ops->mcdi_rpc_timeout(cdx, cmd);
+}
+
+int cdx_mcdi_init(struct cdx_mcdi *cdx)
+{
+	struct cdx_mcdi_iface *mcdi;
+	int rc = -ENOMEM;
+
+	cdx->mcdi = kzalloc(sizeof(*cdx->mcdi), GFP_KERNEL);
+	if (!cdx->mcdi)
+		goto fail;
+
+	mcdi = cdx_mcdi_if(cdx);
+	mcdi->cdx = cdx;
+
+#ifdef CONFIG_MCDI_LOGGING
+	mcdi->logging_buffer = kmalloc(LOG_LINE_MAX, GFP_KERNEL);
+	if (!mcdi->logging_buffer)
+		goto fail2;
+#endif
+	mcdi->workqueue = alloc_ordered_workqueue("mcdi_wq", 0);
+	if (!mcdi->workqueue)
+		goto fail3;
+	mutex_init(&mcdi->iface_lock);
+	mcdi->mode = MCDI_MODE_EVENTS;
+	INIT_LIST_HEAD(&mcdi->cmd_list);
+	init_waitqueue_head(&mcdi->cmd_complete_wq);
+
+	mcdi->new_epoch = true;
+
+	return 0;
+fail3:
+#ifdef CONFIG_MCDI_LOGGING
+	kfree(mcdi->logging_buffer);
+fail2:
+#endif
+	kfree(cdx->mcdi);
+	cdx->mcdi = NULL;
+fail:
+	return rc;
+}
+
+void cdx_mcdi_finish(struct cdx_mcdi *cdx)
+{
+	struct cdx_mcdi_iface *iface;
+
+	if (!cdx->mcdi)
+		return;
+
+	cdx_mcdi_wait_for_cleanup(cdx);
+
+	iface = cdx_mcdi_if(cdx);
+#ifdef CONFIG_MCDI_LOGGING
+	kfree(iface->logging_buffer);
+#endif
+
+	destroy_workqueue(iface->workqueue);
+	kfree(cdx->mcdi);
+	cdx->mcdi = NULL;
+}
+
+static bool cdx_mcdi_flushed(struct cdx_mcdi_iface *mcdi, bool ignore_cleanups)
+{
+	bool flushed;
+
+	mutex_lock(&mcdi->iface_lock);
+	flushed = list_empty(&mcdi->cmd_list) &&
+		  (ignore_cleanups || !mcdi->outstanding_cleanups);
+	mutex_unlock(&mcdi->iface_lock);
+	return flushed;
+}
+
+/* Wait for outstanding MCDI commands to complete. */
+static void cdx_mcdi_wait_for_cleanup(struct cdx_mcdi *cdx)
+{
+	struct cdx_mcdi_iface *mcdi = cdx_mcdi_if(cdx);
+
+	if (!mcdi)
+		return;
+
+	wait_event(mcdi->cmd_complete_wq,
+		   cdx_mcdi_flushed(mcdi, false));
+}
+
+int cdx_mcdi_wait_for_quiescence(struct cdx_mcdi *cdx,
+				 unsigned int timeout_jiffies)
+{
+	struct cdx_mcdi_iface *mcdi = cdx_mcdi_if(cdx);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	int rc;
+
+	if (!mcdi)
+		return -EINVAL;
+
+	flush_workqueue(mcdi->workqueue);
+
+	add_wait_queue(&mcdi->cmd_complete_wq, &wait);
+
+	while (!cdx_mcdi_flushed(mcdi, true)) {
+		rc = wait_woken(&wait, TASK_IDLE, timeout_jiffies);
+		if (rc != 0)
+			continue;
+		break;
+	}
+
+	remove_wait_queue(&mcdi->cmd_complete_wq, &wait);
+
+	if (rc > 0)
+		rc = 0;
+	else if (rc == 0)
+		rc = -ETIMEDOUT;
+
+	return rc;
+}
+
+static u8 cdx_mcdi_payload_csum(const struct cdx_dword *hdr, size_t hdr_len,
+				const struct cdx_dword *sdu, size_t sdu_len)
+{
+	u8 *p = (u8 *)hdr;
+	u8 csum = 0;
+	int i;
+
+	for (i = 0; i < hdr_len; i++)
+		csum += p[i];
+
+	p = (u8 *)sdu;
+	for (i = 0; i < sdu_len; i++)
+		csum += p[i];
+
+	return ~csum & 0xff;
+}
+
+static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
+				  struct cdx_mcdi_cmd *cmd)
+{
+	struct cdx_mcdi_iface *mcdi = cdx_mcdi_if(cdx);
+	const struct cdx_dword *inbuf = cmd->inbuf;
+	size_t inlen = cmd->inlen;
+	struct cdx_dword hdr[2];
+	size_t hdr_len;
+	u32 xflags;
+#ifdef CONFIG_MCDI_LOGGING
+	char *buf;
+#endif
+
+	if (!mcdi) {
+		pr_err("Caught null pointer for mcdi\n");
+		return;
+	}
+#ifdef CONFIG_MCDI_LOGGING
+	buf = mcdi->logging_buffer; /* page-sized */
+#endif
+
+	mcdi->prev_seq = cmd->seq;
+	mcdi->seq_held_by[cmd->seq] = cmd;
+	mcdi->db_held_by = cmd;
+	cmd->started = jiffies;
+
+	xflags = 0;
+
+	/* MCDI v2 */
+	WARN_ON(inlen > MCDI_CTL_SDU_LEN_MAX_V2);
+	CDX_POPULATE_DWORD_7(hdr[0],
+			     MCDI_HEADER_RESPONSE, 0,
+			     MCDI_HEADER_RESYNC, 1,
+			     MCDI_HEADER_CODE, MC_CMD_V2_EXTN,
+			     MCDI_HEADER_DATALEN, 0,
+			     MCDI_HEADER_SEQ, cmd->seq,
+			     MCDI_HEADER_XFLAGS, xflags,
+			     MCDI_HEADER_NOT_EPOCH, !mcdi->new_epoch);
+	CDX_POPULATE_DWORD_3(hdr[1],
+			     MC_CMD_V2_EXTN_IN_EXTENDED_CMD, cmd->cmd,
+			     MC_CMD_V2_EXTN_IN_ACTUAL_LEN, inlen,
+			     MC_CMD_V2_EXTN_IN_MESSAGE_TYPE,
+			     MC_CMD_V2_EXTN_IN_MCDI_MESSAGE_TYPE_PLATFORM);
+	hdr_len = 8;
+
+#ifdef CONFIG_MCDI_LOGGING
+	if (!WARN_ON_ONCE(!buf)) {
+		const struct cdx_dword *frags[] = { hdr, inbuf };
+		const size_t frag_len[] = { hdr_len, round_up(inlen, 4) };
+		int bytes = 0;
+		int i, j;
+
+		for (j = 0; j < ARRAY_SIZE(frags); j++) {
+			const struct cdx_dword *frag;
+
+			frag = frags[j];
+			for (i = 0;
+			     i < frag_len[j] / 4;
+			     i++) {
+				/*
+				 * Do not exceed the internal printk limit.
+				 * The string before that is just over 70 bytes.
+				 */
+				if ((bytes + 75) > LOG_LINE_MAX) {
+					pr_info("MCDI RPC REQ:%s \\\n", buf);
+					bytes = 0;
+				}
+				bytes += snprintf(buf + bytes,
+						  LOG_LINE_MAX - bytes, " %08x",
+						  le32_to_cpu(frag[i].cdx_u32));
+			}
+		}
+
+		pr_info("MCDI RPC REQ:%s\n", buf);
+	}
+#endif
+	hdr[0].cdx_u32 |= (__force __le32)(cdx_mcdi_payload_csum(hdr, hdr_len, inbuf, inlen) <<
+			 MCDI_HEADER_XFLAGS_LBN);
+	cdx->mcdi_ops->mcdi_request(cdx, cmd->bufid, hdr, hdr_len, inbuf, inlen);
+
+	mcdi->new_epoch = false;
+}
+
+static int cdx_mcdi_errno(struct cdx_mcdi *cdx, unsigned int mcdi_err)
+{
+	switch (mcdi_err) {
+	case 0:
+	case MC_CMD_ERR_QUEUE_FULL:
+		return mcdi_err;
+	case MC_CMD_ERR_EPERM:
+		return -EPERM;
+	case MC_CMD_ERR_ENOENT:
+		return -ENOENT;
+	case MC_CMD_ERR_EINTR:
+		return -EINTR;
+	case MC_CMD_ERR_EAGAIN:
+		return -EAGAIN;
+	case MC_CMD_ERR_EACCES:
+		return -EACCES;
+	case MC_CMD_ERR_EBUSY:
+		return -EBUSY;
+	case MC_CMD_ERR_EINVAL:
+		return -EINVAL;
+	case MC_CMD_ERR_ERANGE:
+		return -ERANGE;
+	case MC_CMD_ERR_EDEADLK:
+		return -EDEADLK;
+	case MC_CMD_ERR_ENOSYS:
+		return -EOPNOTSUPP;
+	case MC_CMD_ERR_ETIME:
+		return -ETIME;
+	case MC_CMD_ERR_EALREADY:
+		return -EALREADY;
+	case MC_CMD_ERR_ENOSPC:
+		return -ENOSPC;
+	case MC_CMD_ERR_ENOMEM:
+		return -ENOMEM;
+	case MC_CMD_ERR_ENOTSUP:
+		return -EOPNOTSUPP;
+	case MC_CMD_ERR_ALLOC_FAIL:
+		return -ENOBUFS;
+	case MC_CMD_ERR_MAC_EXIST:
+		return -EADDRINUSE;
+	case MC_CMD_ERR_NO_EVB_PORT:
+		return -EAGAIN;
+	default:
+		return -EPROTO;
+	}
+}
+
+static void cdx_mcdi_process_cleanup_list(struct cdx_mcdi *cdx,
+					  struct list_head *cleanup_list)
+{
+	struct cdx_mcdi_iface *mcdi = cdx_mcdi_if(cdx);
+	unsigned int cleanups = 0;
+
+	while (!list_empty(cleanup_list)) {
+		struct cdx_mcdi_cmd *cmd =
+			list_first_entry(cleanup_list,
+					 struct cdx_mcdi_cmd, cleanup_list);
+		cmd->completer(cdx, cmd->cookie, cmd->rc,
+			       cmd->outbuf, cmd->outlen);
+		list_del(&cmd->cleanup_list);
+		kref_put(&cmd->ref, cdx_mcdi_cmd_release);
+		++cleanups;
+	}
+
+	if (cleanups) {
+		bool all_done;
+
+		mutex_lock(&mcdi->iface_lock);
+		CDX_WARN_ON_PARANOID(cleanups > mcdi->outstanding_cleanups);
+		all_done = (mcdi->outstanding_cleanups -= cleanups) == 0;
+		mutex_unlock(&mcdi->iface_lock);
+		if (all_done)
+			wake_up(&mcdi->cmd_complete_wq);
+	}
+}
+
+static void _cdx_mcdi_cancel_cmd(struct cdx_mcdi_iface *mcdi,
+				 unsigned int handle,
+				 struct list_head *cleanup_list)
+{
+	struct cdx_mcdi_cmd *cmd;
+
+	list_for_each_entry(cmd, &mcdi->cmd_list, list)
+		if (cdx_mcdi_cmd_handle(cmd) == handle) {
+			switch (cmd->state) {
+			case MCDI_STATE_QUEUED:
+			case MCDI_STATE_RETRY:
+				pr_debug("command %#x inlen %zu cancelled in queue\n",
+					 cmd->cmd, cmd->inlen);
+				/* if not yet running, properly cancel it */
+				cmd->rc = -EPIPE;
+				cdx_mcdi_remove_cmd(mcdi, cmd, cleanup_list);
+				break;
+			case MCDI_STATE_RUNNING:
+			case MCDI_STATE_RUNNING_CANCELLED:
+			case MCDI_STATE_FINISHED:
+			default:
+				/* invalid state? */
+				WARN_ON(1);
+			}
+			break;
+		}
+}
+
+static void cdx_mcdi_cancel_cmd(struct cdx_mcdi *cdx, struct cdx_mcdi_cmd *cmd)
+{
+	struct cdx_mcdi_iface *mcdi = cdx_mcdi_if(cdx);
+	LIST_HEAD(cleanup_list);
+
+	if (!mcdi)
+		return;
+
+	mutex_lock(&mcdi->iface_lock);
+	cdx_mcdi_timeout_cmd(mcdi, cmd, &cleanup_list);
+	mutex_unlock(&mcdi->iface_lock);
+	cdx_mcdi_process_cleanup_list(cdx, &cleanup_list);
+}
+
+struct cdx_mcdi_blocking_data {
+	struct kref ref;
+	bool done;
+	wait_queue_head_t wq;
+	int rc;
+	struct cdx_dword *outbuf;
+	size_t outlen;
+	size_t outlen_actual;
+};
+
+static void cdx_mcdi_blocking_data_release(struct kref *ref)
+{
+	kfree(container_of(ref, struct cdx_mcdi_blocking_data, ref));
+}
+
+static void cdx_mcdi_rpc_completer(struct cdx_mcdi *cdx, unsigned long cookie,
+				   int rc, struct cdx_dword *outbuf,
+				   size_t outlen_actual)
+{
+	struct cdx_mcdi_blocking_data *wait_data =
+		(struct cdx_mcdi_blocking_data *)cookie;
+
+	wait_data->rc = rc;
+	memcpy(wait_data->outbuf, outbuf,
+	       min(outlen_actual, wait_data->outlen));
+	wait_data->outlen_actual = outlen_actual;
+	/* memory barrier */
+	smp_wmb();
+	wait_data->done = true;
+	wake_up(&wait_data->wq);
+	kref_put(&wait_data->ref, cdx_mcdi_blocking_data_release);
+}
+
+static int cdx_mcdi_rpc_sync(struct cdx_mcdi *cdx, unsigned int cmd,
+			     const struct cdx_dword *inbuf, size_t inlen,
+			     struct cdx_dword *outbuf, size_t outlen,
+			     size_t *outlen_actual, bool quiet)
+{
+	struct cdx_mcdi_blocking_data *wait_data;
+	struct cdx_mcdi_cmd *cmd_item;
+	unsigned int handle;
+	int rc;
+
+	if (outlen_actual)
+		*outlen_actual = 0;
+
+	wait_data = kmalloc(sizeof(*wait_data), GFP_KERNEL);
+	if (!wait_data)
+		return -ENOMEM;
+
+	cmd_item = kmalloc(sizeof(*cmd_item), GFP_KERNEL);
+	if (!cmd_item) {
+		kfree(wait_data);
+		return -ENOMEM;
+	}
+
+	kref_init(&wait_data->ref);
+	wait_data->done = false;
+	init_waitqueue_head(&wait_data->wq);
+	wait_data->outbuf = outbuf;
+	wait_data->outlen = outlen;
+
+	kref_init(&cmd_item->ref);
+	cmd_item->quiet = quiet;
+	cmd_item->cookie = (unsigned long)wait_data;
+	cmd_item->completer = &cdx_mcdi_rpc_completer;
+	cmd_item->cmd = cmd;
+	cmd_item->inlen = inlen;
+	cmd_item->inbuf = inbuf;
+
+	/* Claim an extra reference for the completer to put. */
+	kref_get(&wait_data->ref);
+	rc = cdx_mcdi_rpc_async_internal(cdx, cmd_item, &handle);
+	if (rc) {
+		kref_put(&wait_data->ref, cdx_mcdi_blocking_data_release);
+		goto out;
+	}
+
+	if (!wait_event_timeout(wait_data->wq, wait_data->done,
+				cdx_mcdi_rpc_timeout(cdx, cmd)) &&
+	    !wait_data->done) {
+		pr_err("MC command 0x%x inlen %zu timed out (sync)\n",
+		       cmd, inlen);
+
+		cdx_mcdi_cancel_cmd(cdx, cmd_item);
+
+		wait_data->rc = -ETIMEDOUT;
+		wait_data->outlen_actual = 0;
+	}
+
+	if (outlen_actual)
+		*outlen_actual = wait_data->outlen_actual;
+	rc = wait_data->rc;
+
+out:
+	kref_put(&wait_data->ref, cdx_mcdi_blocking_data_release);
+
+	return rc;
+}
+
+static bool cdx_mcdi_get_seq(struct cdx_mcdi_iface *mcdi, unsigned char *seq)
+{
+	*seq = mcdi->prev_seq;
+	do {
+		*seq = (*seq + 1) % ARRAY_SIZE(mcdi->seq_held_by);
+	} while (mcdi->seq_held_by[*seq] && *seq != mcdi->prev_seq);
+	return !mcdi->seq_held_by[*seq];
+}
+
+static int cdx_mcdi_rpc_async_internal(struct cdx_mcdi *cdx,
+				       struct cdx_mcdi_cmd *cmd,
+				       unsigned int *handle)
+{
+	struct cdx_mcdi_iface *mcdi = cdx_mcdi_if(cdx);
+	LIST_HEAD(cleanup_list);
+
+	if (!mcdi) {
+		kref_put(&cmd->ref, cdx_mcdi_cmd_release);
+		return -ENETDOWN;
+	}
+
+	if (mcdi->mode == MCDI_MODE_FAIL) {
+		kref_put(&cmd->ref, cdx_mcdi_cmd_release);
+		return -ENETDOWN;
+	}
+
+	cmd->mcdi = mcdi;
+	INIT_WORK(&cmd->work, cdx_mcdi_cmd_work);
+	INIT_LIST_HEAD(&cmd->list);
+	INIT_LIST_HEAD(&cmd->cleanup_list);
+	cmd->rc = 0;
+	cmd->outbuf = NULL;
+	cmd->outlen = 0;
+
+	queue_work(mcdi->workqueue, &cmd->work);
+	return 0;
+}
+
+static void cdx_mcdi_cmd_start_or_queue_ext(struct cdx_mcdi_iface *mcdi,
+					    struct cdx_mcdi_cmd *cmd)
+{
+	struct cdx_mcdi *cdx = mcdi->cdx;
+	u8 seq, bufid;
+
+	if (!mcdi->db_held_by &&
+	    cdx_mcdi_get_seq(mcdi, &seq) &&
+	    cdx->mcdi_ops->mcdi_get_buf(cdx, &bufid)) {
+		cmd->seq = seq;
+		cmd->bufid = bufid;
+		cmd->reboot_seen = false;
+		cdx_mcdi_send_request(cdx, cmd);
+		cmd->state = MCDI_STATE_RUNNING;
+	} else {
+		cmd->state = MCDI_STATE_QUEUED;
+	}
+}
+
+static void cdx_mcdi_cmd_start_or_queue(struct cdx_mcdi_iface *mcdi,
+					struct cdx_mcdi_cmd *cmd)
+{
+	cdx_mcdi_cmd_start_or_queue_ext(mcdi, cmd);
+}
+
+/* try to advance other commands */
+static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
+				    bool allow_retry)
+{
+	struct cdx_mcdi_cmd *cmd, *tmp;
+
+	list_for_each_entry_safe(cmd, tmp, &mcdi->cmd_list, list)
+		if (cmd->state == MCDI_STATE_QUEUED ||
+		    (cmd->state == MCDI_STATE_RETRY && allow_retry))
+			cdx_mcdi_cmd_start_or_queue(mcdi, cmd);
+}
+
+void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword hdr)
+{
+	struct cdx_mcdi_copy_buffer *copybuf;
+	struct cdx_mcdi_iface *mcdi;
+	struct cdx_mcdi_cmd *cmd;
+	LIST_HEAD(cleanup_list);
+	unsigned int respseq;
+
+	mcdi = cdx_mcdi_if(cdx);
+	copybuf = kmalloc(sizeof(*copybuf), GFP_KERNEL);
+	respseq = CDX_DWORD_FIELD(hdr, MCDI_HEADER_SEQ);
+
+	mutex_lock(&mcdi->iface_lock);
+	cmd = mcdi->seq_held_by[respseq];
+
+	if (cmd) {
+		if (cmd->state == MCDI_STATE_FINISHED) {
+			mutex_unlock(&mcdi->iface_lock);
+			kref_put(&cmd->ref, cdx_mcdi_cmd_release);
+			kfree(copybuf);
+			return;
+		}
+
+		cdx_mcdi_complete_cmd(mcdi, cmd, copybuf, &cleanup_list);
+	} else {
+		pr_err("MC response unexpected for seq : %0X\n", respseq);
+	}
+
+	mutex_unlock(&mcdi->iface_lock);
+
+	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
+	kfree(copybuf);
+}
+
+static void cdx_mcdi_cmd_work(struct work_struct *context)
+{
+	struct cdx_mcdi_cmd *cmd =
+		container_of(context, struct cdx_mcdi_cmd, work);
+	struct cdx_mcdi_iface *mcdi = cmd->mcdi;
+
+	mutex_lock(&mcdi->iface_lock);
+
+	cmd->handle = mcdi->prev_handle++;
+	list_add_tail(&cmd->list, &mcdi->cmd_list);
+	cdx_mcdi_cmd_start_or_queue_ext(mcdi, cmd);
+
+	mutex_unlock(&mcdi->iface_lock);
+}
+
+/*
+ * Returns true if the MCDI module is finished with the command.
+ * (examples of false would be if the command was proxied, or it was
+ * rejected by the MC due to lack of resources and requeued).
+ */
+static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
+				  struct cdx_mcdi_cmd *cmd,
+				  struct cdx_mcdi_copy_buffer *copybuf,
+				  struct list_head *cleanup_list)
+{
+	struct cdx_dword *outbuf = copybuf ? copybuf->buffer : NULL;
+	size_t resp_hdr_len, resp_data_len;
+	struct cdx_mcdi *cdx = mcdi->cdx;
+	unsigned int respcmd, error;
+	bool completed = false;
+	u8 bufid = cmd->bufid;
+	struct cdx_dword hdr;
+	int rc;
+
+	/* ensure the command can't go away before this function returns */
+	kref_get(&cmd->ref);
+
+	cdx->mcdi_ops->mcdi_read_response(cdx, bufid, &hdr, 0, 4);
+	respcmd = CDX_DWORD_FIELD(hdr, MCDI_HEADER_CODE);
+	error = CDX_DWORD_FIELD(hdr, MCDI_HEADER_ERROR);
+
+	if (respcmd != MC_CMD_V2_EXTN) {
+		resp_hdr_len = 4;
+		resp_data_len = CDX_DWORD_FIELD(hdr, MCDI_HEADER_DATALEN);
+	} else {
+		cdx->mcdi_ops->mcdi_read_response(cdx, bufid, &hdr, 4, 4);
+		resp_hdr_len = 8;
+		resp_data_len =
+			CDX_DWORD_FIELD(hdr, MC_CMD_V2_EXTN_IN_ACTUAL_LEN);
+	}
+
+#ifdef CONFIG_MCDI_LOGGING
+	if (!WARN_ON_ONCE(!mcdi->logging_buffer)) {
+		size_t len;
+		int bytes = 0;
+		int i;
+		char *log = mcdi->logging_buffer;
+
+		WARN_ON_ONCE(resp_hdr_len % 4);
+		/*
+		 * MCDI_DECLARE_BUF ensures that underlying buffer is padded
+		 * to dword size, and the MCDI buffer is always dword size
+		 */
+		len = resp_hdr_len / 4 + DIV_ROUND_UP(resp_data_len, 4);
+
+		for (i = 0; i < len; i++) {
+			if ((bytes + 75) > LOG_LINE_MAX) {
+				pr_info("MCDI RPC RESP:%s \\\n", log);
+				bytes = 0;
+			}
+			cdx->mcdi_ops->mcdi_read_response(cdx, bufid,
+							  &hdr, (i * 4), 4);
+			bytes += snprintf(log + bytes, LOG_LINE_MAX - bytes,
+					  " %08x", le32_to_cpu(hdr.cdx_u32));
+		}
+
+		pr_info("MCDI RPC RESP:%s\n", log);
+	}
+#endif
+
+	if (error && resp_data_len == 0) {
+		/* MC rebooted during command */
+		rc = -EIO;
+	} else if (!outbuf) {
+		rc = -ENOMEM;
+	} else {
+		if (WARN_ON_ONCE(error && resp_data_len < 4))
+			resp_data_len = 4;
+
+		cdx->mcdi_ops->mcdi_read_response(cdx, bufid, outbuf,
+						  resp_hdr_len, resp_data_len);
+
+		if (error) {
+			rc = CDX_DWORD_FIELD(outbuf[0], CDX_DWORD);
+			if (!cmd->quiet) {
+				int err_arg = 0;
+
+				if (resp_data_len >= MC_CMD_ERR_ARG_OFST + 4) {
+					cdx->mcdi_ops->mcdi_read_response(cdx, bufid, &hdr,
+									  resp_hdr_len +
+									  MC_CMD_ERR_ARG_OFST, 4);
+					err_arg = CDX_DWORD_VAL(hdr);
+				}
+				_cdx_mcdi_display_error(cdx, cmd->cmd,
+							cmd->inlen, rc, err_arg,
+							cdx_mcdi_errno(cdx, rc));
+			}
+			rc = cdx_mcdi_errno(cdx, rc);
+		} else {
+			rc = 0;
+		}
+	}
+
+	/* free doorbell */
+	if (mcdi->db_held_by == cmd)
+		mcdi->db_held_by = NULL;
+
+	if (cdx_cmd_cancelled(cmd)) {
+		list_del(&cmd->list);
+		kref_put(&cmd->ref, cdx_mcdi_cmd_release);
+		completed = true;
+	} else if (rc == MC_CMD_ERR_QUEUE_FULL) {
+		cmd->state = MCDI_STATE_RETRY;
+	} else {
+		cmd->rc = rc;
+		cmd->outbuf = outbuf;
+		cmd->outlen = outbuf ? resp_data_len : 0;
+		cdx_mcdi_remove_cmd(mcdi, cmd, cleanup_list);
+		completed = true;
+	}
+
+	/* free sequence number and buffer */
+	mcdi->seq_held_by[cmd->seq] = NULL;
+	cdx->mcdi_ops->mcdi_put_buf(cdx, bufid);
+
+	cdx_mcdi_start_or_queue(mcdi, rc != MC_CMD_ERR_QUEUE_FULL);
+
+	/* wake up anyone waiting for flush */
+	wake_up(&mcdi->cmd_complete_wq);
+
+	kref_put(&cmd->ref, cdx_mcdi_cmd_release);
+
+	return completed;
+}
+
+static void cdx_mcdi_timeout_cmd(struct cdx_mcdi_iface *mcdi,
+				 struct cdx_mcdi_cmd *cmd,
+				 struct list_head *cleanup_list)
+{
+	struct cdx_mcdi *cdx = mcdi->cdx;
+
+	pr_err("MC command 0x%x inlen %zu state %d timed out after %u ms\n",
+	       cmd->cmd, cmd->inlen, cmd->state,
+	       jiffies_to_msecs(jiffies - cmd->started));
+
+	cdx->mcdi_ops->mcdi_put_buf(cdx, cmd->bufid);
+
+	cmd->rc = -ETIMEDOUT;
+	cdx_mcdi_remove_cmd(mcdi, cmd, cleanup_list);
+
+	cdx_mcdi_mode_fail(cdx, cleanup_list);
+}
+
+/**
+ * cdx_mcdi_rpc - Issue an MCDI command and wait for completion
+ * @cdx: NIC through which to issue the command
+ * @cmd: Command type number
+ * @inbuf: Command parameters
+ * @inlen: Length of command parameters, in bytes. Must be a multiple
+ *	of 4 and no greater than %MCDI_CTL_SDU_LEN_MAX_V1.
+ * @outbuf: Response buffer. May be %NULL if @outlen is 0.
+ * @outlen: Length of response buffer, in bytes. If the actual
+ *	response is longer than @outlen & ~3, it will be truncated
+ *	to that length.
+ * @outlen_actual: Pointer through which to return the actual response
+ *	length. May be %NULL if this is not needed.
+ *
+ * This function may sleep and therefore must be called in process
+ * context.
+ *
+ * @return: A negative error code, or zero if successful. The error
+ *	code may come from the MCDI response or may indicate a failure
+ *	to communicate with the MC. In the former case, the response
+ *	will still be copied to @outbuf and *@outlen_actual will be
+ *	set accordingly. In the latter case, *@outlen_actual will be
+ *	set to zero.
+ */
+int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
+		 const struct cdx_dword *inbuf, size_t inlen,
+		 struct cdx_dword *outbuf, size_t outlen,
+		 size_t *outlen_actual)
+{
+	return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
+				 outlen_actual, false);
+}
+
+/**
+ * cdx_mcdi_rpc_async - Schedule an MCDI command to run asynchronously
+ * @cdx: NIC through which to issue the command
+ * @cmd: Command type number
+ * @inbuf: Command parameters
+ * @inlen: Length of command parameters, in bytes
+ * @outlen: Length to allocate for response buffer, in bytes
+ * @complete: Function to be called on completion or cancellation.
+ * @cookie: Arbitrary value to be passed to @complete.
+ *
+ * This function does not sleep and therefore may be called in atomic
+ * context.  It will fail if event queues are disabled or if MCDI
+ * event completions have been disabled due to an error.
+ *
+ * If it succeeds, the @complete function will be called exactly once
+ * in process context, when one of the following occurs:
+ * (a) the completion event is received (in process context)
+ * (b) event queues are disabled (in the process that disables them)
+ */
+int
+cdx_mcdi_rpc_async(struct cdx_mcdi *cdx, unsigned int cmd,
+		   const struct cdx_dword *inbuf, size_t inlen,
+		   cdx_mcdi_async_completer *complete, unsigned long cookie)
+{
+	struct cdx_mcdi_cmd *cmd_item =
+		kmalloc(sizeof(struct cdx_mcdi_cmd) + inlen, GFP_ATOMIC);
+
+	if (!cmd_item)
+		return -ENOMEM;
+
+	kref_init(&cmd_item->ref);
+	cmd_item->quiet = true;
+	cmd_item->cookie = cookie;
+	cmd_item->completer = complete;
+	cmd_item->cmd = cmd;
+	cmd_item->inlen = inlen;
+	/* inbuf is probably not valid after return, so take a copy */
+	cmd_item->inbuf = (struct cdx_dword *)(cmd_item + 1);
+	memcpy(cmd_item + 1, inbuf, inlen);
+
+	return cdx_mcdi_rpc_async_internal(cdx, cmd_item, NULL);
+}
+
+static void _cdx_mcdi_display_error(struct cdx_mcdi *cdx, unsigned int cmd,
+				    size_t inlen, int raw, int arg, int rc)
+{
+	pr_err("MC command 0x%x inlen %d failed rc=%d (raw=%d) arg=%d\n",
+	       cmd, (int)inlen, rc, raw, arg);
+}
+
+/*
+ * Set MCDI mode to fail to prevent any new commands, then cancel any
+ * outstanding commands.
+ * Caller must hold the mcdi iface_lock.
+ */
+static void cdx_mcdi_mode_fail(struct cdx_mcdi *cdx, struct list_head *cleanup_list)
+{
+	struct cdx_mcdi_iface *mcdi = cdx_mcdi_if(cdx);
+
+	if (!mcdi)
+		return;
+
+	mcdi->mode = MCDI_MODE_FAIL;
+
+	while (!list_empty(&mcdi->cmd_list)) {
+		struct cdx_mcdi_cmd *cmd;
+
+		cmd = list_first_entry(&mcdi->cmd_list, struct cdx_mcdi_cmd,
+				       list);
+		_cdx_mcdi_cancel_cmd(mcdi, cdx_mcdi_cmd_handle(cmd), cleanup_list);
+	}
+}
diff --git a/drivers/bus/cdx/controller/mcdi.h b/drivers/bus/cdx/controller/mcdi.h
new file mode 100644
index 000000000000..a2ee8821b6fe
--- /dev/null
+++ b/drivers/bus/cdx/controller/mcdi.h
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2008-2013 Solarflare Communications Inc.
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef CDX_MCDI_H
+#define CDX_MCDI_H
+
+#include <linux/mutex.h>
+#include <linux/kref.h>
+
+#include "bitfield.h"
+#include "mc_cdx_pcol.h"
+
+#ifdef DEBUG
+#define CDX_WARN_ON_ONCE_PARANOID(x) WARN_ON_ONCE(x)
+#define CDX_WARN_ON_PARANOID(x) WARN_ON(x)
+#else
+#define CDX_WARN_ON_ONCE_PARANOID(x) do {} while (0)
+#define CDX_WARN_ON_PARANOID(x) do {} while (0)
+#endif
+
+/**
+ * enum cdx_mcdi_mode - MCDI transaction mode
+ * @MCDI_MODE_EVENTS: wait for an mcdi response callback.
+ * @MCDI_MODE_FAIL: we think MCDI is dead, so fail-fast all calls
+ */
+enum cdx_mcdi_mode {
+	MCDI_MODE_EVENTS,
+	MCDI_MODE_FAIL,
+};
+
+#define MCDI_RPC_TIMEOUT	(10 * HZ)
+#define MCDI_RPC_LONG_TIMEOU	(60 * HZ)
+#define MCDI_RPC_POST_RST_TIME	(10 * HZ)
+
+#define MCDI_BUF_LEN (8 + MCDI_CTL_SDU_LEN_MAX)
+
+/**
+ * enum cdx_mcdi_cmd_state - State for an individual MCDI command
+ * @MCDI_STATE_QUEUED: Command not started and is waiting to run.
+ * @MCDI_STATE_RETRY: Command was submitted and MC rejected with no resources,
+ *	as MC have too many outstanding commands. Command will be retried once
+ *	another command returns.
+ * @MCDI_STATE_RUNNING: Command was accepted and is running.
+ * @MCDI_STATE_RUNNING_CANCELLED: Command is running but the issuer cancelled
+ *	the command.
+ * @MCDI_STATE_FINISHED: Processing of this command has completed.
+ */
+
+enum cdx_mcdi_cmd_state {
+	MCDI_STATE_QUEUED,
+	MCDI_STATE_RETRY,
+	MCDI_STATE_RUNNING,
+	MCDI_STATE_RUNNING_CANCELLED,
+	MCDI_STATE_FINISHED,
+};
+
+/**
+ * struct cdx_mcdi - CDX MCDI Firmware interface, to interact
+ *	with CDX controller.
+ * @mcdi: MCDI interface
+ * @mcdi_buf_use: Stores MCDI buffer usage
+ * @mcdi_ops: MCDI operations
+ * @mcdi_buf: MCDI receive buffer
+ */
+struct cdx_mcdi {
+	/* MCDI interface */
+	struct cdx_mcdi_data *mcdi;
+	unsigned long mcdi_buf_use;
+	const struct cdx_mcdi_ops *mcdi_ops;
+	void *mcdi_buf;
+};
+
+struct cdx_mcdi_ops {
+	void (*mcdi_request)(struct cdx_mcdi *cdx, u8 bufid,
+			     const struct cdx_dword *hdr, size_t hdr_len,
+			     const struct cdx_dword *sdu, size_t sdu_len);
+	bool (*mcdi_poll_response)(struct cdx_mcdi *cdx, u8 bufid);
+	void (*mcdi_read_response)(struct cdx_mcdi *cdx,
+				   u8 bufid, struct cdx_dword *pdu,
+				   size_t pdu_offset, size_t pdu_len);
+	bool (*mcdi_get_buf)(struct cdx_mcdi *cdx, u8 *bufid);
+	void (*mcdi_put_buf)(struct cdx_mcdi *cdx, u8 bufid);
+	unsigned int (*mcdi_rpc_timeout)(struct cdx_mcdi *cdx, unsigned int cmd);
+};
+
+typedef void cdx_mcdi_async_completer(struct cdx_mcdi *cdx,
+				      unsigned long cookie, int rc,
+				      struct cdx_dword *outbuf,
+				      size_t outlen_actual);
+
+/**
+ * struct cdx_mcdi_cmd - An outstanding MCDI command
+ * @ref: Reference count. There will be one reference if the command is
+ *	in the mcdi_iface cmd_list, another if it's on a cleanup list,
+ *	and a third if it's queued in the work queue.
+ * @list: The data for this entry in mcdi->cmd_list
+ * @cleanup_list: The data for this entry in a cleanup list
+ * @work: The work item for this command, queued in mcdi->workqueue
+ * @mcdi: The mcdi_iface for this command
+ * @state: The state of this command
+ * @inlen: inbuf length
+ * @inbuf: Input buffer
+ * @quiet: Whether to silence errors
+ * @reboot_seen: Whether a reboot has been seen during this command,
+ *	to prevent duplicates
+ * @seq: Sequence number
+ * @bufid: Buffer ID from the NIC implementation
+ * @started: Jiffies this command was started at
+ * @cookie: Context for completion function
+ * @completer: Completion function
+ * @handle: Command handle
+ * @cmd: Command number
+ * @rc: Return code
+ * @outlen: Length of output buffer
+ * @outbuf: Output buffer
+ */
+struct cdx_mcdi_cmd {
+	struct kref ref;
+	struct list_head list;
+	struct list_head cleanup_list;
+	struct work_struct work;
+	struct cdx_mcdi_iface *mcdi;
+	enum cdx_mcdi_cmd_state state;
+	size_t inlen;
+	const struct cdx_dword *inbuf;
+	bool quiet;
+	bool reboot_seen;
+	u8 seq;
+	u8 bufid;
+	unsigned long started;
+	unsigned long cookie;
+	cdx_mcdi_async_completer *completer;
+	unsigned int handle;
+	unsigned int cmd;
+	int rc;
+	size_t outlen;
+	struct cdx_dword *outbuf;
+	/* followed by inbuf data if necessary */
+};
+
+/**
+ * struct cdx_mcdi_iface - MCDI protocol context
+ * @cdx: The associated NIC
+ * @iface_lock: Serialise access to this structure
+ * @outstanding_cleanups: Count of cleanups
+ * @cmd_list: List of outstanding and running commands
+ * @workqueue: Workqueue used for delayed processing
+ * @cmd_complete_wq: Waitqueue for command completion
+ * @db_held_by: Command the MC doorbell is in use by
+ * @seq_held_by: Command each sequence number is in use by
+ * @prev_handle: The last used command handle
+ * @mode: Poll for mcdi completion, or wait for an mcdi_event
+ * @prev_seq: The last used sequence number
+ * @new_epoch: Indicates start of day or start of MC reboot recovery
+ * @logging_buffer: Buffer that may be used to build MCDI tracing messages
+ * @logging_enabled: Whether to trace MCDI
+ */
+struct cdx_mcdi_iface {
+	struct cdx_mcdi *cdx;
+	/* Serialise access */
+	struct mutex iface_lock;
+	unsigned int outstanding_cleanups;
+	struct list_head cmd_list;
+	struct workqueue_struct *workqueue;
+	wait_queue_head_t cmd_complete_wq;
+	struct cdx_mcdi_cmd *db_held_by;
+	struct cdx_mcdi_cmd *seq_held_by[16];
+	unsigned int prev_handle;
+	enum cdx_mcdi_mode mode;
+	u8 prev_seq;
+	bool new_epoch;
+#ifdef CONFIG_MCDI_LOGGING
+	bool logging_enabled;
+	char *logging_buffer;
+#endif
+};
+
+/**
+ * struct cdx_mcdi_data - extra state for NICs that implement MCDI
+ * @iface: Interface/protocol state
+ * @fn_flags: Flags for this function, as returned by %MC_CMD_DRV_ATTACH.
+ */
+struct cdx_mcdi_data {
+	struct cdx_mcdi_iface iface;
+	u32 fn_flags;
+};
+
+static inline struct cdx_mcdi_iface *cdx_mcdi_if(struct cdx_mcdi *cdx)
+{
+	return cdx->mcdi ? &cdx->mcdi->iface : NULL;
+}
+
+int cdx_mcdi_init(struct cdx_mcdi *cdx);
+void cdx_mcdi_finish(struct cdx_mcdi *cdx);
+
+void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword hdr);
+int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
+		 const struct cdx_dword *inbuf, size_t inlen,
+		 struct cdx_dword *outbuf, size_t outlen, size_t *outlen_actual);
+int cdx_mcdi_rpc_async(struct cdx_mcdi *cdx, unsigned int cmd,
+		       const struct cdx_dword *inbuf, size_t inlen,
+		       cdx_mcdi_async_completer *complete,
+		       unsigned long cookie);
+int cdx_mcdi_wait_for_quiescence(struct cdx_mcdi *cdx,
+				 unsigned int timeout_jiffies);
+
+/*
+ * We expect that 16- and 32-bit fields in MCDI requests and responses
+ * are appropriately aligned, but 64-bit fields are only
+ * 32-bit-aligned.
+ */
+#define MCDI_DECLARE_BUF(_name, _len) struct cdx_dword _name[DIV_ROUND_UP(_len, 4)] = {{0}}
+#define _MCDI_PTR(_buf, _offset)					\
+	((u8 *)(_buf) + (_offset))
+#define MCDI_PTR(_buf, _field)						\
+	_MCDI_PTR(_buf, MC_CMD_ ## _field ## _OFST)
+#define _MCDI_CHECK_ALIGN(_ofst, _align)				\
+	((void)BUILD_BUG_ON_ZERO((_ofst) & ((_align) - 1)),		\
+	 (_ofst))
+#define _MCDI_DWORD(_buf, _field)					\
+	((_buf) + (_MCDI_CHECK_ALIGN(MC_CMD_ ## _field ## _OFST, 4) >> 2))
+
+#define MCDI_BYTE(_buf, _field)						\
+	((void)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 1),	\
+	 *MCDI_PTR(_buf, _field))
+#define MCDI_WORD(_buf, _field)						\
+	((void)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 2),	\
+	 le16_to_cpu(*(__force const __le16 *)MCDI_PTR(_buf, _field)))
+#define MCDI_SET_DWORD(_buf, _field, _value)				\
+	CDX_POPULATE_DWORD_1(*_MCDI_DWORD(_buf, _field), CDX_DWORD, _value)
+#define MCDI_DWORD(_buf, _field)					\
+	CDX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), CDX_DWORD)
+#define MCDI_POPULATE_DWORD_1(_buf, _field, _name1, _value1)		\
+	CDX_POPULATE_DWORD_1(*_MCDI_DWORD(_buf, _field),		\
+			     MC_CMD_ ## _name1, _value1)
+#define MCDI_SET_QWORD(_buf, _field, _value)				\
+	do {								\
+		CDX_POPULATE_DWORD_1(_MCDI_DWORD(_buf, _field)[0],	\
+				     CDX_DWORD, (u32)(_value));	\
+		CDX_POPULATE_DWORD_1(_MCDI_DWORD(_buf, _field)[1],	\
+				     CDX_DWORD, (u64)(_value) >> 32);	\
+	} while (0)
+#define MCDI_QWORD(_buf, _field)					\
+	(CDX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[0], CDX_DWORD) |	\
+	(u64)CDX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[1], CDX_DWORD) << 32)
+
+#endif /* CDX_MCDI_H */
-- 
2.17.1

