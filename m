Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0867E3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjA0LrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjA0Lqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:46:35 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC27BBF4;
        Fri, 27 Jan 2023 03:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksCkehmux0Tdf7FGzen3at/8bCCe/emq9XBTLdttDzQ=;
 b=NVQlYF2vkdYU+rc47z1ciTjGIkcTnkzfz4n5Ml6QWrpA7+V20nlkjbUheJZlRVjy5mICZkhBYkbpqCJmtR1f+PwVNyV9zd6waY8QzpIyJKxJRhSt1mvKMLwIC0lR5PWxt+I5MqLsOsS7DMkzmog8u7WOWRt7rCYugyKBBc2cLc8=
Received: from DU2PR04CA0338.eurprd04.prod.outlook.com (2603:10a6:10:2b4::8)
 by AS8PR08MB9647.eurprd08.prod.outlook.com (2603:10a6:20b:618::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 11:43:50 +0000
Received: from DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::74) by DU2PR04CA0338.outlook.office365.com
 (2603:10a6:10:2b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
 Transport; Fri, 27 Jan 2023 11:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT051.mail.protection.outlook.com (100.127.142.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.23 via Frontend Transport; Fri, 27 Jan 2023 11:43:50 +0000
Received: ("Tessian outbound 6e565e48ed4a:v132"); Fri, 27 Jan 2023 11:43:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5d05838f867c82d3
X-CR-MTA-TID: 64aa7808
Received: from 6f39253fd576.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5290425F-A59F-4806-BA9B-C941E5F3FDE9.1;
        Fri, 27 Jan 2023 11:43:43 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6f39253fd576.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Jan 2023 11:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsY2GnkrkaiYntOL5S5IGxW6kpNScr/v2EAalopY3uT0y5HKOCdm4pnyxXDzUqM3VkdixOOwyJVI+pnOh2mhcWi5v9AO7PD2VeTweo3lSk8wWSm4WBAn9+IuG8+hE4UFJKKK6xlItcg4OLbJqxjinfuZOrS48GdeC9UOFgzN6YmnEfl1eqPFduK6woS8r+MOYP+I2f+A/K3fqbYrp97NpURGxlg7i/Cx0Ry5C/l0CMoNa5GiWeZNUD7kATteBxIsYSs4+XGl5pR1rmu3/OHf24IWoNNvTos+DxGxD7MeL03bAMI6EQO27OZe3fyzQxmogQ2cvPeAl98Xe9kWjCS7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksCkehmux0Tdf7FGzen3at/8bCCe/emq9XBTLdttDzQ=;
 b=ASbSoNGAt+4CfG3cXMZpKail+28+p8i2QhPCTeagSEXuf1rhRhYN5CxljkTUcMHssOskrTTEMA1KMRv819p+AULEeH0oA5VekAodzt3K12bnxor9MuNUL4mY0EQKLVDdjUyQYfz7D3n8tf8Yb6MaOoI1DSr3dQeJED/ophXqw7tyvRU6Hgrhmki0nGmU5bF96RVtiH/RPGcX0ecS2mScqG9paZtMDfO6ae+0CoFAZHtKLXiu1LxCkScGwREesmG1DOMhuNXI5lZHt2AHMWGOhq6B0pOG3nU5cREdb8dm907uGxm3vMX4Bb8JiMTr2jYjaWliou/4YFM5Du3wE5FC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksCkehmux0Tdf7FGzen3at/8bCCe/emq9XBTLdttDzQ=;
 b=NVQlYF2vkdYU+rc47z1ciTjGIkcTnkzfz4n5Ml6QWrpA7+V20nlkjbUheJZlRVjy5mICZkhBYkbpqCJmtR1f+PwVNyV9zd6waY8QzpIyJKxJRhSt1mvKMLwIC0lR5PWxt+I5MqLsOsS7DMkzmog8u7WOWRt7rCYugyKBBc2cLc8=
Received: from DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) by VI1PR08MB10124.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 27 Jan
 2023 11:43:38 +0000
Received: from DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:469:cafe::d4) by DUZPR01CA0047.outlook.office365.com
 (2603:10a6:10:469::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.37 via Frontend
 Transport; Fri, 27 Jan 2023 11:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT037.mail.protection.outlook.com (100.127.142.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Fri, 27 Jan 2023 11:43:38 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 27 Jan
 2023 11:43:37 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 27 Jan
 2023 11:43:37 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 27 Jan 2023 11:43:31 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Andrew Jones <andrew.jones@linux.dev>, <kvmarm@lists.linux.dev>,
        <kvm@vger.kernel.org>
CC:     <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Thomas Huth" <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        <linux-coco@lists.linux.dev>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mate Toth-Pal <mate.toth-pal@arm.com>
Subject: [RFC kvm-unit-tests 25/27] arm: realm: Add Realm attestation tests
Date:   Fri, 27 Jan 2023 11:41:06 +0000
Message-ID: <20230127114108.10025-26-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230127114108.10025-1-joey.gouly@arm.com>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127114108.10025-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT037:EE_|VI1PR08MB10124:EE_|DBAEUR03FT051:EE_|AS8PR08MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1e461b-c180-4086-5861-08db005bc22a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lgsspNkfJ1FnkQc5doCWVVijMA7Vko9KhNOVkYguOIs07HyTIfme9VtMKvoex904pudIl0l92v2iPCuOJJ/Jp2uonaJOepNJECGIlIW3Ku7yIeHn8G//UJYSkiPxcLChqH9lc9FmJUPC/6NLa3BEpkinQYPqx9qsMEjEpJd/aSV7NnXo2gUivqoRrtJJ8cUnA0i/Z/wSazV+h+ixna/16nK60gJmDiipekEK/fizvFsZmQecFHt1BigVbAD4wDvAy2mk20VFVcvs0koChhYD6+gAvOb2Iyw4Edv46xyvJVSdn+ShaBQ9atOPxsXbkdLg6rf6DPtYnUtKXC/nfPE7jkE+1I1Cdn6PDhOsHGMt4JFU7vIOwerVCM4DsFhnNPMw7/dJSaY2TvZYxIT+h0nSYaGodD/shKyvOtkgEExfPkVtgDGELXPJ0OVtGtFnF1/c3+AuthVtTbLvN7j1S1H/xsbYxSNTjDiOL4wCeI2jnoSCOAUORoVRfU2DrYemUGjVKbNOfFOwU0/qUnBYGL/SRYg9V+Yj4yEj6+65Dpfx3b/mxHobAW1tPHTUKtt6kgu94Fa95/YKauuPCOwN0ZHwywI0wVahBJzEBj++CmwluavHNigya1U+6UKQAwRbQjXDpMXhDs+5MgfX8roRUuXjyQH9mijKOBCU4mXQjuXYEx5nD5DzXdp/AptkE50rbdijA4vs86D97euHXXgIKhorK2rOsloLhV3Gc0ZIyi8gwmhvYlulp8/VKHONR75Fm8etExQRXauNAenKcoY7SCg66maWQvQ43LlY1MQcpgGpFPc=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(41300700001)(426003)(86362001)(40460700003)(7696005)(47076005)(82310400005)(36756003)(1076003)(70586007)(6666004)(54906003)(81166007)(8936002)(83380400001)(36860700001)(2906002)(7416002)(5660300002)(30864003)(82740400003)(356005)(40480700001)(44832011)(336012)(316002)(186003)(966005)(70206006)(8676002)(4326008)(26005)(2616005)(110136005)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10124
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c6125aa0-8690-4fb4-5d70-08db005bbb12
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9LKg6FCgYz0cx+3QNwWvzK1M7ZA2JC4KfRyG3MLM5pMkUHiEq1qmd8Xurtn5n+LLIGPe9XZ5XcQyQoA2Tq9q2sQy8FXwZASjpFFFmYPO+Itxq02nBC68iVTduQGRCWpiy46NlVcyX6Zl7KSAdcGnBZu1HDUfyYsmltWKfdwmFxBhgfijdc89uLi9iCYvmtXg+CuEgV8mlWd6oU1ePARX0CKVMpiUFS3lP2wxZIx9j/0RVRZM6cxKgZQCge+hCLFsUDPD2YwA1FFJNUn+7fETt+gWE2W/2VtK7zcwxr/IMkStLR1FhWnIdcsBjYORZDsoZrHQGJl/ASipomx9yeBXrOKJ8Vau8DT7YELk6T7YX3mA1hBKup8O32IL04a+TQXHewjSroV5PerNgXmBfTpIfoZhvdtEKqFWHjsc6UZhxBzPBsj83N/Ipv8jvF5Bm3LKDZ2zP8+UPshxWM2AJt42BuoPeMP7HRBLwYdxIKXwlnDuoiaWsrV/r+rkfE7u4fRSdeEozgyEM5rgsRaanZe1iXE2AshOg64Bm8thbMi7pu4c+F9iW1vWzvllL/Bl8Ql28EhnkrMXdOcxgoP3QiSWJmX4rh7jZcIn5g7PUac0TF8g0gAhrysNXgd+8ounc3aHpebGoqAXFmefZt2fWHKZI7Ll2you6MOrsu39xtA67XYnxicmvr+MNE6OvsFEpuKHaBRgA8Go1Uf8c8Cf1lQJXhi+WW+3GkfXB5XUBpFQqwhQ4rKwhyRFO8RXYo0KL2c
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(41300700001)(83380400001)(8676002)(70206006)(450100002)(70586007)(426003)(336012)(47076005)(36860700001)(4326008)(1076003)(82740400003)(8936002)(82310400005)(40460700003)(2616005)(54906003)(110136005)(316002)(5660300002)(6666004)(7696005)(966005)(44832011)(40480700001)(36756003)(81166007)(26005)(30864003)(186003)(86362001)(478600001)(2906002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 11:43:50.2479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1e461b-c180-4086-5861-08db005bc22a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9647
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mate Toth-Pal <mate.toth-pal@arm.com>

Add tests for Attestation and measurement related RSI calls.

Signed-off-by: Mate Toth-Pal <mate.toth-pal@arm.com>
Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[ Rewrote the test cases, keeping the core testing data/logic ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
---
 arm/Makefile.arm64 |    1 +
 arm/realm-attest.c | 1125 ++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg  |   50 ++
 lib/libcflat.h     |    1 +
 4 files changed, 1177 insertions(+)
 create mode 100644 arm/realm-attest.c

diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index f57d0a95..0a0c4f2c 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -41,6 +41,7 @@ tests += $(TEST_DIR)/micro-bench.flat
 tests += $(TEST_DIR)/cache.flat
 tests += $(TEST_DIR)/debug.flat
 tests += $(TEST_DIR)/realm-rsi.flat
+tests += $(TEST_DIR)/realm-attest.flat
 tests += $(TEST_DIR)/realm-fpu.flat
 tests += $(TEST_DIR)/realm-sea.flat
 
diff --git a/arm/realm-attest.c b/arm/realm-attest.c
new file mode 100644
index 00000000..6c357fb5
--- /dev/null
+++ b/arm/realm-attest.c
@@ -0,0 +1,1125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Arm Limited.
+ * All rights reserved.
+ */
+#include <libcflat.h>
+
+#include <attest_defines.h>
+#include <alloc.h>
+#include <stdlib.h>
+#include <token_dumper.h>
+#include <token_verifier.h>
+
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/rsi.h>
+#include <asm/setup.h>
+#include <asm/smp.h>
+
+
+#define SHA256_SIZE	32
+
+struct challenge {
+	unsigned long words[8];
+};
+
+struct measurement {
+	unsigned long words[8];
+};
+
+static char __attribute__((aligned(SZ_2M))) __attribute__((section(".data")))
+			block_buf_data[SZ_2M * 2];
+
+static char __attribute__((aligned(SZ_2M))) __attribute__((section(".bss")))
+			block_buf_bss[SZ_2M];
+
+static char __attribute__((aligned(SZ_4K))) __attribute__((section(".data")))
+			page_buf_data[SZ_4K];
+
+static char __attribute__((aligned(SZ_4K))) __attribute__((section(".bss")))
+			page_buf_bss[SZ_4K];
+
+/* Page aligned offset within the block mapped buffer */
+#define BLOCK_BUF_OFFSET	(SZ_8K)
+
+static inline void debug_print_raw_token(void *buf, size_t size)
+{
+#ifdef PRINT_RAW_TOKEN
+	print_raw_token(buf, size);
+#endif
+}
+
+static inline void debug_print_token(struct attestation_claims *claim)
+{
+#ifdef PRINT_TOKEN
+	print_token(claim);
+#endif
+}
+
+static bool claims_verify_token(char *token, size_t token_size,
+				struct attestation_claims *claims,
+				bool report_success)
+{
+	int verify_rc = verify_token(token, token_size, claims);
+	int cpu = smp_processor_id();
+
+	if (verify_rc == TOKEN_VERIFICATION_ERR_SUCCESS) {
+		if (report_success)
+			report(true, "CPU%d: Verfication of token passed", cpu);
+		return true;
+	}
+
+	report(false,
+	       "CPU%d: Verification of token failed with error code %d",
+	       cpu, verify_rc);
+
+	return false;
+}
+
+static inline void attest_token_init(phys_addr_t addr,
+				     struct challenge *ch,
+				     struct smccc_result *res)
+{
+	rsi_attest_token_init(addr, &ch->words[0], res);
+}
+
+
+static inline void attest_token_continue(phys_addr_t addr,
+					 struct smccc_result *res)
+{
+	rsi_attest_token_continue(addr, res);
+}
+
+static inline void attest_token_complete(phys_addr_t addr,
+					 struct smccc_result *res)
+{
+	do {
+		attest_token_continue(addr, res);
+	} while (res->r0 == RSI_INCOMPLETE);
+}
+
+static void get_attest_token(phys_addr_t ipa,
+			     struct challenge *ch,
+			     struct smccc_result *res)
+{
+	attest_token_init(ipa, ch, res);
+
+	if (res->r0)
+		return;
+	attest_token_complete(ipa, res);
+}
+
+/*
+ * __get_attest_token_claims: Get attestation token and verify the claims.
+ * If @claims is not NULL, token is parsed and the @claims is populated.
+ * All failures reported. Success is only reported if the @report_success is
+ * true.
+ * Returns whether the calls and verification succeeds
+ */
+static bool __get_attest_token_claims(void *buf, struct challenge *ch,
+				      struct attestation_claims *claims,
+				      size_t *token_size, bool report_success)
+{
+	struct smccc_result result;
+	struct attestation_claims local_claims;
+	struct attestation_claims *claimsp;
+	bool rc = false;
+
+	/* Use the local_claims if claims is not supplied */
+	claimsp = claims ? : &local_claims;
+
+	get_attest_token(virt_to_phys(buf), ch, &result);
+	if (result.r0) {
+		report(false, "Get attestation token with : %ld", result.r0);
+		return rc;
+	}
+
+	if (report_success)
+		report(true, "Get attestation token");
+
+	/* Update token_size if necessary */
+	if (token_size)
+		*token_size = result.r1;
+
+	return claims_verify_token(buf, result.r1, claimsp, report_success);
+}
+
+static bool get_attest_token_claims(void *buf, struct challenge *ch,
+				    struct attestation_claims *claims,
+				    size_t *token_size)
+{
+	return __get_attest_token_claims(buf, ch, claims, token_size, false);
+}
+
+static void get_verify_attest_token(void *buf, struct challenge *ch,
+				    const char *desc)
+{
+	report_prefix_push(desc);
+	__get_attest_token_claims(buf, ch, NULL, NULL, true);
+	report_prefix_pop();
+}
+
+static void get_verify_attest_token_verbose(void *buf,
+					    struct challenge *ch,
+					    const char *desc)
+{
+	size_t token_size;
+	struct attestation_claims claims;
+
+	report_prefix_push(desc);
+	if (__get_attest_token_claims(buf, ch, &claims, &token_size, true)) {
+		debug_print_raw_token(buf, token_size);
+		debug_print_token(&claims);
+	}
+	report_prefix_pop();
+}
+
+static void test_get_attest_token(void)
+{
+	char stack_buf[SZ_4K]__attribute__((aligned(SZ_4K)));
+	char *heap_buf;
+	struct challenge ch;
+
+	memset(&ch, 0xAB, sizeof(ch));
+
+	/* Heap buffer */
+	heap_buf = memalign(SZ_4K, SZ_4K);
+	if (heap_buf) {
+		get_verify_attest_token(heap_buf, &ch, "heap buffer");
+		free(heap_buf);
+	} else {
+		report_skip("heap buffer: Failed to allocate");
+	}
+
+	/* Stack buffer */
+	get_verify_attest_token(stack_buf, &ch, "stack buffer");
+	/* Page aligned buffer .data segment */
+	get_verify_attest_token(page_buf_data, &ch, ".data segment buffer");
+	/* Page aligned buffer .bss segment */
+	get_verify_attest_token(page_buf_bss, &ch, ".bss segment buffer");
+	/* Block mapped buffer in .data segment */
+	get_verify_attest_token(&block_buf_data[BLOCK_BUF_OFFSET], &ch,
+				"block mapped .data segment buffer");
+	/* Block mapped buffer in .bss segment */
+	get_verify_attest_token_verbose(&block_buf_bss[BLOCK_BUF_OFFSET],
+					 &ch, "block mapped .bss segment buffer");
+}
+
+static void get_attest_token_check_fail(phys_addr_t ipa,
+					struct challenge *ch,
+					return_code_t exp,
+					const char *buf_desc)
+{
+	struct smccc_result result;
+	return_code_t rc;
+
+	report_prefix_push(buf_desc);
+	get_attest_token(ipa, ch, &result);
+	rc = unpack_return_code(result.r0);
+	if (rc.status != exp.status) {
+		report(false, "Get attestation token "
+			      "got (%d) expected (%d)",
+			      rc.status, exp.status);
+	} else {
+		report(true, "Get attestation token fails as expected");
+	}
+	report_prefix_pop();
+}
+
+static void test_get_attest_token_bad_input(void)
+{
+	struct challenge ch;
+	return_code_t exp;
+
+	memset(page_buf_data, 0, sizeof(page_buf_data));
+	memset(&ch, 0xAB, sizeof(ch));
+	exp = make_return_code(RSI_ERROR_INPUT, 0);
+	get_attest_token_check_fail(virt_to_phys(page_buf_data + 0x100),
+				    &ch, exp, "unaligned buffer");
+	get_attest_token_check_fail(__phys_end + SZ_512M, &ch, exp,
+				    "buffer outside PAR");
+}
+
+static void test_get_attest_token_abi_misuse(void)
+{
+	struct smccc_result result;
+	struct challenge ch;
+	phys_addr_t ipa = virt_to_phys(page_buf_data);
+	return_code_t rc;
+
+	memset(&ch, 0xAB, sizeof(ch));
+
+	/*
+	 * Testcase 1 - Miss call to RSI_ATTEST_TOKEN_INIT
+	 *
+	 * step1. Execute a successful test to reset the state machine.
+	 */
+	report_prefix_push("miss token init");
+	get_attest_token(ipa, &ch, &result);
+	if (result.r0) {
+		report(false, "Get attestation failed %ld", result.r0);
+		report_prefix_pop(); /* miss token init */
+		return;
+	}
+	/*
+	 * step2. Execute RSI_ATTEST_TOKEN_CONTINUE without an RSI_ATTEST_TOKEN_INIT.
+	 * 	  Expect an error == RSI_ERROR_STATE
+	 */
+	attest_token_continue(ipa, &result);
+	rc = unpack_return_code(result.r0);
+	if (rc.status != RSI_ERROR_STATE) {
+		report(false, "Unexpected result (%d, %d) vs (%d) expected",
+		       rc.status, rc.index, RSI_ERROR_STATE);
+		report_prefix_pop(); /* miss token init */
+		return;
+	}
+
+	report(true, "Fails as expected");
+	report_prefix_pop(); /* miss token init */
+
+	/*
+	 * Test case 2 - Calling with inconsistend input.
+	 * step1. Issue RSI_ATTEST_TOKEN_INIT
+	 * step2. Modify the challenge and issue RSI_ATTEST_TOKEN_CONTINUE.
+	 * Test : Expect error == (RSI_ERROR_INPUT, 0)
+	 */
+	report_prefix_push("inconsistent input");
+	attest_token_init(ipa, &ch, &result);
+	rc = unpack_return_code(result.r0);
+	if (result.r0) {
+		report(false, "RSI_ATTEST_TOKEN_INIT failed unexpectedly (%d, %d)",
+		       rc.status, rc.index);
+		report_prefix_pop(); /* inconsistent input */
+		return;
+	}
+
+	/*
+	 * Corrupt the IPA address input to ATTEST_TOKEN_CONTINUE,
+	 */
+	attest_token_continue(ipa ^ 0x1UL, &result);
+	rc = unpack_return_code(result.r0);
+	if (rc.status != RSI_ERROR_INPUT) {
+		report(false, "Attest token continue unexpected results"
+			       " (%d) vs expected (%d)",
+			      rc.status, RSI_ERROR_INPUT);
+	}
+
+	report_prefix_pop(); /* inconsistent input */
+
+	/*
+	 * Test case 3
+	 * step1. Complete the token attestation from with proper values.
+	 *        Failures in the Test case 2 should not affect the completion.
+	 */
+	report_prefix_push("valid input after inconsistent input");
+	attest_token_complete(ipa, &result);
+	rc = unpack_return_code(result.r0);
+	if (result.r0) {
+		report(false, "Attest token continue failed with (%d, %d)",
+			rc.status, rc.index);
+		return;
+	} else {
+		report(true, "Attest token continue complete");
+	}
+	report_prefix_pop(); /* Valid input after inconsistent input */
+}
+
+static void test_get_attest_token_abi_abort_req(void)
+{
+	int i;
+	char *p;
+	size_t size;
+	struct attestation_claims claims;
+	struct smccc_result result;
+	struct challenge ch;
+	char stack_buf[SZ_4K] __attribute__((aligned(SZ_4K))) = { 0 };
+	phys_addr_t addr = virt_to_phys(stack_buf);
+
+	/* Set the initial challenge, which will be aborted */
+	memset(&ch, 0xAB, sizeof(ch));
+	attest_token_init(addr, &ch, &result);
+	if (result.r0) {
+		report(false, "Attest token init failed %ld", result.r0);
+		return;
+	}
+
+	/* Execute a few cycles, but not let it complete */
+	for (i = 0; i < 3; i++) {
+		attest_token_continue(addr, &result);
+		if (result.r0 != RSI_INCOMPLETE) {
+			if (result.r0)
+				report(false, "Attest token continue : unexpected "
+				       "failure %ld", result.r0);
+			else
+				report_skip("Attest token finished at iteration %d",
+					    i + 1);
+			return;
+		}
+	}
+
+	/* Issue a fresh Attest Token request with updated challenge */
+	memset(&ch, 0xEE, sizeof(ch));
+	get_attest_token(addr, &ch, &result);
+	if (result.r0) {
+		report(false, "Attest Token failed %ld", result.r0);
+		return;
+	}
+	claims_verify_token(stack_buf, result.r1, &claims, false);
+
+	/*
+	 * TODO: Index of claim in the array depends on the init sequence
+	 * in token_verifier.c: init_claim()
+	 */
+	p = (char*)claims.realm_token_claims[0].buffer_data.ptr;
+	size = claims.realm_token_claims[0].buffer_data.len;
+
+	/* Verify that token contains the updated challenge. */
+	if (size != sizeof(ch)) {
+		report(false, "Attestation token: abort request: "
+				"claim size mismatch : %ld", result.r0);
+		return;
+	}
+	if (memcmp(p, &ch, size)) {
+		report(false, "Attestation token: abort request: "
+			      "claim value mismatch: %ld", result.r0);
+		return;
+	}
+	report(true, "Aborting ongoing request");
+}
+
+static void run_rsi_attest_tests(void)
+{
+	report_prefix_push("attest");
+
+	test_get_attest_token();
+
+	report_prefix_push("bad input");
+	test_get_attest_token_bad_input();
+	report_prefix_pop();
+
+	report_prefix_push("ABI misuse");
+	test_get_attest_token_abi_misuse();
+	report_prefix_pop();
+
+	report_prefix_push("ABI Abort");
+	test_get_attest_token_abi_abort_req();
+	report_prefix_pop();
+
+	report_prefix_pop(); /* attest */
+}
+
+static void run_get_token_times(void *data)
+{
+	char buf[SZ_4K] __attribute__((aligned(SZ_4K)));
+	struct challenge ch;
+	struct attestation_claims claims;
+	unsigned long runs = ((size_t)data);
+	int i, j;
+	int cpu = smp_processor_id();
+
+	report_info("CPU%d: Running get token test %ld times", cpu, runs);
+	for (i = 0; i < runs; i++) {
+		uint8_t pattern = (cpu << 4) | (i & 0xf);
+		size_t token_size;
+		struct claim_t *claim;
+
+		memset(buf, 0, sizeof(buf));
+		memset(&ch, pattern, sizeof(ch));
+
+		if (!get_attest_token_claims(buf, &ch, &claims, &token_size))
+			return;
+		claim = claims.realm_token_claims;
+		if (claim->key != CCA_REALM_CHALLENGE ||
+		    claim->buffer_data.len != sizeof(ch)) {
+			report(false, "Invalid challenge size in parsed token:"
+				      " %zu (expected %zu)",
+				      claim->buffer_data.len, sizeof(ch));
+			return;
+		}
+
+		for (j = 0; j < sizeof(ch); j++) {
+			uint8_t byte = ((uint8_t *)claim->buffer_data.ptr)[j];
+			if (byte != pattern) {
+				report(false, "Invalid byte in challenge[%d]: "
+					       " %02x (expected %02x)",
+					       j, byte, pattern);
+				return;
+			}
+		}
+	}
+	report(true, "CPU%d: Completed runs", cpu);
+}
+
+static void run_rsi_attest_smp_test(void)
+{
+	unsigned long runs = 100;
+
+	report_prefix_push("attest_smp");
+	on_cpus(run_get_token_times, (void *)runs);
+	report_prefix_pop();
+}
+
+/*
+ * There are 7 slots for measurements. The first is reserved for initial
+ * content measurement. The rest are meant to store runtime measurements.
+ * Runtime measurements are extended (concatenated and hashed). Reading
+ * them back separately is unsupported. They can be queried in an
+ * attestation token.
+ *
+ * Measurement size is 64bytes maximum to accommodate a SHA512 hash.
+ */
+
+static void measurement_extend(int idx, struct measurement *m, size_t size,
+			       struct smccc_result *res)
+{
+	rsi_extend_measurement(idx, size, &m->words[0], res);
+}
+
+static void test_extend_measurement(void)
+{
+	struct smccc_result result;
+	struct measurement m;
+	return_code_t rc;
+	int idx;
+
+	memset(&m, 0xEE, sizeof(m));
+	/*
+	 * Store Runtime measurements for all possible slots.
+	 */
+	for (idx = 1; idx <= REM_COUNT; idx ++) {
+		measurement_extend(idx, &m, sizeof(m.words), &result);
+		rc = unpack_return_code(result.r0);
+		report(!rc.status, "Extend measurement idx: %d (%d, %d)",
+			idx, rc.status, rc.index);
+	}
+}
+
+static void test_extend_measurement_bad_index(struct measurement *m)
+{
+	struct smccc_result result;
+	return_code_t rc;
+	int indices[] = { 0, REM_COUNT + 1 };
+	const char *idx_descs[] = { "reserved", "out-of-bounds" };
+	int i;
+
+	report_prefix_push("index");
+	for (i = 0; i < ARRAY_SIZE(indices); i++) {
+		report_prefix_push(idx_descs[i]);
+		measurement_extend(indices[i], m, sizeof(m->words), &result);
+		rc = unpack_return_code(result.r0);
+
+		if (rc.status != RSI_ERROR_INPUT)
+			report(false, "Extend measurement index: "
+				      "actual (%d) vs expected (%d)",
+				      rc.status, RSI_ERROR_INPUT);
+		else
+			report(true, "Extend measurement index fails as expected");
+		report_prefix_pop(); /* idx_descs[i] */
+	}
+	report_prefix_pop(); /* index */
+}
+
+static void test_extend_measurement_bad_size(struct measurement *m)
+{
+	struct smccc_result result;
+	return_code_t rc;
+
+	report_prefix_push("size");
+	rsi_extend_measurement(1, 65, &m->words[0], &result);
+	rc = unpack_return_code(result.r0);
+	if (rc.status != RSI_ERROR_INPUT)
+		report(false, "Measurement extend "
+			      "actual (%d) vs expected (%d)",
+			      rc.status, RSI_ERROR_INPUT);
+	else
+		report(true, "Extend measurement fails as expected");
+	report_prefix_pop(); /* size */
+}
+
+static void test_extend_measurement_bad_input(void)
+{
+	struct measurement m;
+
+	report_prefix_push("bad input");
+	memset(&m, 0xEE, sizeof(m));
+	test_extend_measurement_bad_index(&m);
+	test_extend_measurement_bad_size(&m);
+	report_prefix_pop(); /* bad input */
+}
+
+static void run_rsi_extend_tests(void)
+{
+	report_prefix_push("extend");
+	test_extend_measurement();
+	test_extend_measurement_bad_input();
+	report_prefix_pop(); /* extend */
+}
+
+/*
+ * cpu_extend_run - Parameters for the extend measurement SMP run.
+ * @idx		- Pointer to the index
+ * @size	- Size of the measurement data
+ * @m		- Measurement data.
+ */
+struct cpu_extend_run {
+	int *idx;
+	struct measurement *m;
+	size_t size;
+	unsigned long rc;
+};
+
+/*
+ * We get an array of the parameters for the extend measurement.
+ * The cpu number is the index to the array. At the moment we
+ * only support 2 cpus.
+ */
+static void cpu_run_extend_measurement(void *data)
+{
+	struct smccc_result result;
+	struct cpu_extend_run *run;
+	int me = smp_processor_id();
+
+	assert(me >= 0);
+
+	/* Tests for only 2 CPUs */
+	if (me > 1)
+		return;
+	run = (struct cpu_extend_run *)data + me;
+	rsi_extend_measurement(*run->idx, run->size, &run->m->words[0], &result);
+	run->rc = result.r0;
+	if (result.r0 != 0)
+		report(false, "CPU%d: Extend measurement failed for slot %d",
+		       me, *run->idx);
+}
+
+static bool claims_uses_sha256_algo(struct attestation_claims *claims)
+{
+	struct claim_t *claim = claims->realm_token_claims + 2; /* CCA_REALM_HASH_ALGO_ID */
+
+	/* claim->buffer_data.ptr: Not NULL terminated, so using memcmp */
+	return !memcmp(claim->buffer_data.ptr, "sha-256", strlen("sha-256"));
+}
+
+static void test_rsi_extend_smp(void)
+{
+	int slot, m_idx;
+	struct measurement m[2];
+	struct challenge ch;
+	struct attestation_claims claims;
+	size_t token_size;
+
+	/*
+	 * Measurements to extend with
+	 *
+	 * Run		CPU0 data	CPU1 data
+	 *   1:		[31 - 0]	[55 - 24]
+	 *   2:		[39 - 8]	[63 - 32]
+	 *   3:		[47 - 16]	[71 - 40]
+	 */
+	char measure_bytes[] = {
+		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
+		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
+		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
+		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
+		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+		0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+		0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
+		0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27
+	};
+
+	/*
+	 * The expected measurement values. Each element in the array contains
+	 * a possible extended measurement value. (Multiple values are possible
+	 * as the extend function might be called in any order by the cores.)
+	 * The array contains results for all the possible orders. The number of
+	 * possibilities can be calculated as here:
+	 * https://math.stackexchange.com/q/1065374
+	 */
+	struct extend_smp_expected {
+		const char *sequence;
+		char measurement[SHA256_SIZE];
+	} expected[] = {
+		{
+			"[ cpu0#0 cpu0#1 cpu0#2 cpu1#0 cpu1#1 cpu1#2 ]",
+			{
+				0xB1, 0xBE, 0x04, 0x25, 0xBB, 0xBC, 0x04, 0x9F,
+				0x98, 0x4F, 0xFB, 0xDE, 0xAA, 0x00, 0xC9, 0xBC,
+				0x41, 0x43, 0xDB, 0x16, 0xBB, 0x2A, 0x5F, 0x4B,
+				0x8B, 0x36, 0xAE, 0x3F, 0xFE, 0x24, 0x23, 0xA4
+			},
+		},
+		{
+			"[ cpu0#0 cpu0#1 cpu1#0 cpu0#2 cpu1#1 cpu1#2 ]",
+			{
+				0x99, 0x00, 0x5E, 0xB7, 0xF8, 0x84, 0xA3, 0x99,
+				0x7E, 0x12, 0xDE, 0xD1, 0x5B, 0xA7, 0x07, 0xF4,
+				0x24, 0x3E, 0x77, 0xED, 0x60, 0xC0, 0xBD, 0x43,
+				0x3B, 0x60, 0x7E, 0x38, 0xDD, 0x58, 0xC7, 0x46
+			},
+		},
+		{
+			"[ cpu0#0 cpu0#1 cpu1#0 cpu1#1 cpu0#2 cpu1#2 ]",
+			{
+				0x0B, 0x5E, 0x31, 0x69, 0xAC, 0xAF, 0xA0, 0x8B,
+				0x4F, 0x90, 0xD1, 0x86, 0xCC, 0x8E, 0x11, 0x42,
+				0x0B, 0x74, 0x49, 0x6C, 0xA1, 0x27, 0x1B, 0x7C,
+				0x52, 0x77, 0x7F, 0x2F, 0x53, 0x2F, 0x9A, 0xC1
+			},
+		},
+		{
+			"[ cpu0#0 cpu0#1 cpu1#0 cpu1#1 cpu1#2 cpu0#2 ]",
+			{
+				0x99, 0xDE, 0xF8, 0x02, 0x27, 0xE9, 0x6F, 0x6F,
+				0xA6, 0x55, 0xFC, 0x56, 0xCC, 0x7A, 0xFC, 0xEF,
+				0x2F, 0x0C, 0x45, 0x3E, 0x01, 0xE0, 0x4B, 0xA1,
+				0x60, 0x96, 0xEE, 0xB1, 0x4A, 0x25, 0x86, 0x89},
+		},
+		{
+			"[ cpu0#0 cpu1#0 cpu0#1 cpu0#2 cpu1#1 cpu1#2 ]",
+			{	0x88, 0x40, 0x05, 0xF5, 0xA6, 0x95, 0xC1, 0xC7,
+				0xD3, 0x69, 0x16, 0x82, 0x0D, 0x79, 0xC1, 0x5B,
+				0x4A, 0x48, 0xCA, 0x7F, 0xA5, 0xF3, 0x77, 0x37,
+				0xBE, 0x0D, 0xAC, 0x2E, 0x42, 0x3E, 0x03, 0x37
+			},
+		},
+		{
+			"[ cpu0#0 cpu1#0 cpu0#1 cpu1#1 cpu0#2 cpu1#2 ]",
+			{
+				0x68, 0x32, 0xC6, 0xAF, 0x8C, 0x86, 0x77, 0x09,
+				0x4A, 0xB9, 0xA1, 0x9E, 0xBB, 0x2B, 0x42, 0x35,
+				0xF8, 0xDE, 0x9A, 0x98, 0x37, 0x7B, 0x3E, 0x82,
+				0x59, 0x0B, 0xC4, 0xAD, 0x1D, 0x01, 0x28, 0xCA
+			},
+		},
+		{
+			"[ cpu0#0 cpu1#0 cpu0#1 cpu1#1 cpu1#2 cpu0#2 ]",
+			{
+				0xF5, 0x96, 0x77, 0x68, 0xD9, 0x6A, 0xA2, 0xFC,
+				0x08, 0x8C, 0xF5, 0xA9, 0x6B, 0xE7, 0x1E, 0x20,
+				0x35, 0xC1, 0x92, 0xCE, 0xBC, 0x3A, 0x75, 0xEA,
+				0xB4, 0xEB, 0x17, 0xE5, 0x77, 0x50, 0x85, 0x40
+			},
+
+		},
+		{
+			"[ cpu0#0 cpu1#0 cpu1#1 cpu0#1 cpu0#2 cpu1#2 ]",
+			{
+				0x4E, 0xA2, 0xD2, 0x79, 0x55, 0x75, 0xCB, 0x86,
+				0x87, 0x34, 0x35, 0xE7, 0x75, 0xDF, 0xD5, 0x59,
+				0x58, 0xDE, 0x74, 0x35, 0x68, 0x2B, 0xDC, 0xC8,
+				0x85, 0x72, 0x97, 0xBE, 0x58, 0xB1, 0x1E, 0xA7
+			},
+
+		},
+		{
+			"[ cpu0#0 cpu1#0 cpu1#1 cpu0#1 cpu1#2 cpu0#2 ]",
+			{
+				0xD1, 0xC2, 0xC8, 0x08, 0x00, 0x64, 0xB8, 0x1F,
+				0xA0, 0xA5, 0x32, 0x20, 0xAA, 0x08, 0xC0, 0x48,
+				0xDB, 0xB1, 0xED, 0xE7, 0xAF, 0x18, 0x2F, 0x7F,
+				0x3C, 0xB8, 0x58, 0x83, 0xEC, 0xF9, 0x38, 0xFD
+			},
+
+		},
+		{
+			"[ cpu0#0 cpu1#0 cpu1#1 cpu1#2 cpu0#1 cpu0#2 ]",
+			{
+				0xD1, 0xB8, 0x31, 0x98, 0x8E, 0xF2, 0xE7, 0xF5,
+				0xBB, 0xD1, 0xE1, 0xC7, 0x3E, 0xB7, 0xA9, 0x18,
+				0x3B, 0xCC, 0x58, 0x98, 0xED, 0x22, 0x1E, 0xE2,
+				0x04, 0x76, 0xA1, 0xB9, 0x92, 0x54, 0xB5, 0x5B
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu0#0 cpu0#1 cpu0#2 cpu1#1 cpu1#2 ]",
+			{
+				0xAB, 0x50, 0x2A, 0x68, 0x28, 0x35, 0x16, 0xA9,
+				0xDE, 0x26, 0x77, 0xAA, 0x99, 0x29, 0x0E, 0x9C,
+				0x67, 0x41, 0x64, 0x28, 0x6E, 0xFF, 0x54, 0x33,
+				0xE5, 0x29, 0xC4, 0xA5, 0x98, 0x40, 0x7E, 0xC9
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu0#0 cpu0#1 cpu1#1 cpu0#2 cpu1#2 ]",
+			{
+				0xA3, 0x4D, 0xB0, 0x28, 0xAB, 0x01, 0x56, 0xBB,
+				0x7D, 0xE5, 0x0E, 0x86, 0x26, 0xBB, 0xBB, 0xDE,
+				0x58, 0x91, 0x88, 0xBB, 0x9F, 0x6A, 0x58, 0x78,
+				0x30, 0x2C, 0x22, 0x2E, 0x85, 0x7F, 0x87, 0xF6
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu0#0 cpu0#1 cpu1#1 cpu1#2 cpu0#2 ]",
+			{
+				0x1A, 0x2E, 0xD2, 0xC2, 0x0C, 0xBD, 0x30, 0xDA,
+				0x4F, 0x37, 0x6B, 0x90, 0xE3, 0x67, 0xFE, 0x61,
+				0x4F, 0x30, 0xBB, 0x29, 0xBC, 0xAA, 0x6E, 0xC5,
+				0x60, 0x6E, 0x13, 0x6B, 0x33, 0x3D, 0xC0, 0x11
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu0#0 cpu1#1 cpu0#1 cpu0#2 cpu1#2 ]",
+			{
+				0x8F, 0xEA, 0xD1, 0x80, 0xE0, 0xBE, 0x27, 0xF7,
+				0x8D, 0x19, 0xBF, 0x65, 0xBE, 0x92, 0x83, 0x7C,
+				0x61, 0x8F, 0xC5, 0x8D, 0x0F, 0xAD, 0x89, 0x1E,
+				0xAE, 0x0A, 0x75, 0xAC, 0x3E, 0x5F, 0xD5, 0x31
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu0#0 cpu1#1 cpu0#1 cpu1#2 cpu0#2 ]",
+			{
+				0x0F, 0x7B, 0xEE, 0xA5, 0x9A, 0xCD, 0xED, 0x8D,
+				0x5A, 0x52, 0xFF, 0xD6, 0x30, 0xF4, 0xD9, 0xE9,
+				0xF4, 0xC1, 0x1A, 0x0C, 0x86, 0x2B, 0x96, 0x2C,
+				0x0E, 0x2D, 0x1A, 0x2A, 0xFE, 0xE6, 0x7C, 0xAD
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu0#0 cpu1#1 cpu1#2 cpu0#1 cpu0#2 ]",
+			{
+				0x4A, 0xBA, 0xFF, 0x0B, 0x0B, 0x06, 0xD1, 0xCE,
+				0x95, 0x91, 0x70, 0x68, 0x20, 0xD6, 0xF2, 0x23,
+				0xC5, 0x6A, 0x63, 0x2B, 0xCA, 0xDF, 0x37, 0xB5,
+				0x0B, 0xDC, 0x64, 0x6A, 0xA3, 0xC9, 0x8F, 0x1E
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu1#1 cpu0#0 cpu0#1 cpu0#2 cpu1#2 ]",
+			{
+				0x3D, 0xB1, 0xE1, 0xBD, 0x85, 0x2C, 0xA0, 0x04,
+				0xE6, 0x43, 0xE8, 0x82, 0xC3, 0x77, 0xF3, 0xCE,
+				0x4D, 0x62, 0x2C, 0xF4, 0x65, 0xF6, 0x29, 0x5F,
+				0x17, 0xDA, 0xD5, 0x79, 0x55, 0xE2, 0x3D, 0x0C
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu1#1 cpu0#0 cpu0#1 cpu1#2 cpu0#2 ]",
+			{
+				0x5B, 0xFE, 0x29, 0xA4, 0xDA, 0x9F, 0xE7, 0x13,
+				0x5F, 0xA2, 0xCE, 0x53, 0x40, 0xC0, 0x38, 0xBC,
+				0x10, 0x7A, 0xF0, 0x29, 0x3C, 0xD6, 0xAF, 0x8A,
+				0x03, 0x40, 0xED, 0xE1, 0xFD, 0x46, 0xB7, 0x06
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu1#1 cpu0#0 cpu1#2 cpu0#1 cpu0#2 ]",
+			{
+				0x66, 0x20, 0xA7, 0xBE, 0xED, 0x90, 0x0A, 0x14,
+				0x95, 0x7A, 0x93, 0x47, 0x1E, 0xA8, 0xDD, 0x6E,
+				0x25, 0xCB, 0x73, 0x18, 0x77, 0x77, 0x91, 0xE9,
+				0xCA, 0x17, 0x26, 0x16, 0xAA, 0xC9, 0x34, 0x7A
+			},
+
+		},
+		{
+			"[ cpu1#0 cpu1#1 cpu1#2 cpu0#0 cpu0#1 cpu0#2 ]",
+			{
+				0x4D, 0xF6, 0xC7, 0x74, 0x37, 0x66, 0x4C, 0x6A,
+				0x40, 0x32, 0x94, 0x01, 0x17, 0xA2, 0xE6, 0x3D,
+				0xA8, 0x00, 0x3E, 0xB7, 0x89, 0x24, 0xF4, 0x04,
+				0x14, 0xA8, 0xA1, 0xD1, 0xCD, 0x5B, 0xC3, 0x60
+			},
+
+		},
+	};
+
+	struct cpu_extend_run cpus[2] = {
+		/* CPU0 */
+		{ .idx = &slot, .m = &m[0], .size = SHA256_SIZE },
+		/* CPU1 */
+		{ .idx = &slot, .m = &m[1], .size = SHA256_SIZE },
+	};
+
+	for (slot = 1; slot <= REM_COUNT; slot++) {
+		for (m_idx = 0; m_idx < 3; m_idx++) {
+			memcpy(m[0].words, &measure_bytes[m_idx * 8], SHA256_SIZE);
+			memcpy(m[1].words, &measure_bytes[24 + m_idx * 8], SHA256_SIZE);
+			on_cpus(cpu_run_extend_measurement, (void *)&cpus[0]);
+			if (cpus[0].rc || cpus[1].rc)
+				return;
+		}
+	}
+
+	/* Get the token and parse the claims */
+	memset(page_buf_data, 0, sizeof(page_buf_data));
+	memset(&ch, 0xAB, sizeof(ch));
+	if (!get_attest_token_claims(page_buf_data, &ch, &claims, &token_size))
+		return;
+
+	/*
+	 * Hard-coded test data expects sha-256 algorithm, skip the measurement
+	 * value comparison if realm hash algo is different.
+	 */
+	if (!claims_uses_sha256_algo(&claims)) {
+		report_skip("Hash algo is different than sha-256,"
+			    " skip measurement value comparison");
+		return;
+	}
+
+	for (slot = 0; slot < REM_COUNT; slot++) {
+		struct claim_t *claim = &claims.realm_measurement_claims[slot];
+		const char *data = claim->buffer_data.ptr;
+		const size_t len = claim->buffer_data.len;
+
+		if (len != SHA256_SIZE) {
+			report(false, "Realm measurement size mismatch "
+				      "%zu vs %d (expected)", len, SHA256_SIZE);
+			continue;
+		}
+
+		for (m_idx = 0; m_idx < ARRAY_SIZE(expected); m_idx++) {
+			struct extend_smp_expected *em = &expected[m_idx];
+
+			if (memcmp(data, em->measurement, SHA256_SIZE) == 0) {
+				report(true, "Hash found for slot %d: %s",
+					      slot, em->sequence);
+				break;
+			}
+		}
+
+		if (m_idx == ARRAY_SIZE(expected))
+			report(false, "Measurement doesn't match any expected "
+				      "sequence for slot %d", slot);
+	}
+}
+
+static void run_rsi_extend_smp_tests(void)
+{
+	report_prefix_push("extend_smp");
+	test_rsi_extend_smp();
+	report_prefix_pop();
+}
+
+static void test_rsi_extend_and_attest(void)
+{
+	struct challenge ch;
+	struct measurement m;
+	struct attestation_claims claims;
+	size_t token_size;
+	int i, j;
+
+	char measure_bytes[] = {
+		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*slot 1*/
+		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*slot 2*/
+		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*slot 3*/
+		0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*slot 4*/
+		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /*slot 5*/
+		0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, /*slot 6*/
+		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+		0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
+		0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27
+	};
+
+	/* The following expectations assume extending with SHA256 */
+	char expected_measurements[][SHA256_SIZE] = {
+		{
+			0x88, 0x78, 0xb1, 0x5a, 0x7d, 0x6a, 0x3a, 0x4f,
+			0x46, 0x4e, 0x8f, 0x9f, 0x42, 0x59, 0x1d, 0xbc,
+			0x0c, 0xf4, 0xbe, 0xde, 0xa0, 0xec, 0x30, 0x90,
+			0x03, 0xd2, 0xb2, 0xee, 0x53, 0x65, 0x5e, 0xf8
+		},
+		{
+			0x58, 0x32, 0x3b, 0xdf, 0x7a, 0x91, 0xf6, 0x8e,
+			0x80, 0xc7, 0xc8, 0x7f, 0xda, 0x1e, 0x22, 0x6c,
+			0x8b, 0xe7, 0xee, 0xa9, 0xef, 0x64, 0xa5, 0x21,
+			0xdb, 0x2c, 0x09, 0xa7, 0xd7, 0x01, 0x92, 0x05
+		},
+		{
+			0x66, 0xe3, 0x3b, 0x99, 0x49, 0x4d, 0xf4, 0xdd,
+			0xbc, 0x7a, 0x61, 0x7a, 0xa1, 0x56, 0x7b, 0xf8,
+			0x96, 0x3f, 0x0a, 0xf3, 0x1e, 0xab, 0xdd, 0x16,
+			0x37, 0xb0, 0xfb, 0xe0, 0x71, 0x82, 0x66, 0xce
+		},
+		{
+			0x97, 0x5e, 0x9f, 0x64, 0x79, 0x90, 0xa1, 0x51,
+			0xd2, 0x5b, 0x73, 0x75, 0x50, 0x94, 0xeb, 0x54,
+			0x90, 0xbb, 0x1e, 0xf8, 0x3b, 0x2c, 0xb8, 0x3b,
+			0x6f, 0x24, 0xf3, 0x86, 0x07, 0xe0, 0x58, 0x13
+		},
+		{
+			0x68, 0x99, 0x86, 0x64, 0x9b, 0xeb, 0xa2, 0xe4,
+			0x4d, 0x07, 0xbb, 0xb3, 0xa1, 0xd9, 0x2d, 0x07,
+			0x76, 0x7f, 0x86, 0x19, 0xb8, 0x5f, 0x14, 0x48,
+			0x1f, 0x38, 0x4b, 0x87, 0x51, 0xdc, 0x10, 0x31
+		},
+		{
+			0xee, 0x8f, 0xb3, 0xe9, 0xc8, 0xa5, 0xbe, 0x4f,
+			0x12, 0x90, 0x4a, 0x52, 0xb9, 0xc8, 0x62, 0xd1,
+			0x8a, 0x44, 0x31, 0xf7, 0x56, 0x7d, 0x96, 0xda,
+			0x97, 0x7a, 0x9e, 0x96, 0xae, 0x6a, 0x78, 0x43
+		},
+	};
+	int times_to_extend[] = {1, 2, 3, 4, 5, 6};
+
+	memset(page_buf_data, 0, sizeof(page_buf_data));
+	memset(&ch, 0xAB, sizeof(ch));
+	if (!__get_attest_token_claims(page_buf_data, &ch,
+				       &claims, &token_size, true))
+		return;
+
+	for (i = 0; i < REM_COUNT; i++) {
+		struct claim_t c = claims.realm_measurement_claims[i];
+		for (j = 0; j < c.buffer_data.len; j++) {
+			if (((char *)c.buffer_data.ptr)[j])
+				break;
+		}
+	}
+
+	report((i == REM_COUNT), "Initial measurements must be 0");
+
+	/* Extend the possible measurements (i.e., 1 to REM_COUNT) */
+	for (i = 1; i <= REM_COUNT; i++) {
+		memcpy(&m.words[0], &measure_bytes[(i - 1) * 8], SHA256_SIZE);
+		for (j = 0; j < times_to_extend[i - 1]; j++) {
+			struct smccc_result r;
+
+			measurement_extend(i, &m, SHA256_SIZE, &r);
+			if (r.r0) {
+				report(false, "Extend measurment slot %d, iteration %d "
+					      "failed with %ld", i, j, r.r0);
+				return;
+			}
+		}
+	}
+	report(true, "Extend measurement for all slots completed");
+
+	/* Get the attestation token again */
+	if (!__get_attest_token_claims(page_buf_data, &ch,
+				       &claims, &token_size, true))
+		return;
+
+	/*
+	 * Hard-coded test data expects sha-256 algorithm, skip the measurement
+	 * value comparison if realm hash algo is different.
+	 */
+	if (!claims_uses_sha256_algo(&claims))
+		return;
+
+	/* Verify the extended measurements */
+	for (i = 0; i < REM_COUNT; i++) {
+		const char *exp = expected_measurements[i];
+		const char *actual = claims.realm_measurement_claims[i].buffer_data.ptr;
+		const size_t len = claims.realm_measurement_claims[i].buffer_data.len;
+
+		if (len != SHA256_SIZE) {
+			report(false, "Realm measurement: slot: %d, unexpected size "
+				      "actual %ld vs %d expected", i, len,
+				      SHA256_SIZE);
+			return;
+		}
+		if (memcmp(exp, actual, len)) {
+			report(false, "Measurement doesn't match for slot %d", i);
+			printf("Expected:\n");
+			for (j = 0; j < len; j++)
+				printf("0x%2x ", exp[j]);
+			printf("\nActual:\n");
+			for (j = 0; j < len; j++)
+				printf("0x%2x ", actual[j]);
+			printf("\n");
+		} else {
+			report(true, "Extended measurement match expected for "
+				     "slot %d", i);
+
+		}
+	}
+}
+
+static void run_rsi_extend_and_attest_tests(void)
+{
+	report_prefix_push("extend_and_attest");
+	test_rsi_extend_and_attest();
+	report_prefix_pop();
+}
+
+#define MEASUREMENT_MAX_SIZE_LONGS	8
+
+static void test_read_measurement(void)
+{
+	struct smccc_result result;
+	return_code_t rc;
+	unsigned long *m;
+	int i, j;
+
+	/*
+	 * We must be able to read all measurements
+	 * 0 (Initial read-only measurement and the
+	 * realm extendable ones, 1 to REM_COUNT.
+	 */
+	for (i = 0; i <= REM_COUNT; i++) {
+		rsi_read_measurement(i, &result);
+		rc = unpack_return_code(result.r0);
+		if (rc.status) {
+			report(false, "Read measurement failed for slot %d with "
+				      "(%d, %d)", i, rc.status, rc.index);
+			return;
+		}
+		m = &result.r1;
+		printf("Read measurement slot:%d, Hash = ", i);
+		for (j = 0; j < MEASUREMENT_MAX_SIZE_LONGS; j++)
+			printf("%lx", __builtin_bswap64(*m++));
+		printf("\n");
+		report(true, "Read Measurement Slot: %d", i);
+	}
+}
+
+static void test_read_measurement_bad_input(void)
+{
+	struct smccc_result result;
+	return_code_t rc;
+
+	report_prefix_push("out-of-range index");
+	rsi_read_measurement(REM_COUNT + 1, &result);
+	rc = unpack_return_code(result.r0);
+	if (rc.status != RSI_ERROR_INPUT) {
+		report(false, "Read measurement fails, "
+			      "expected (%d), got (%d)",
+			      RSI_ERROR_INPUT, rc.status);
+	} else {
+		report(true, "Read measurement fails as expected");
+	}
+	report_prefix_pop(); /* out-of-range index */
+}
+
+static void run_rsi_read_measurement_tests(void)
+{
+	report_prefix_push("measurement");
+	test_read_measurement();
+	test_read_measurement_bad_input();
+	report_prefix_pop();
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+	report_prefix_push("attestation");
+
+	for (i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "attest") == 0)
+			run_rsi_attest_tests();
+		else if (strcmp(argv[i], "attest_smp") == 0)
+			run_rsi_attest_smp_test();
+		else if (strcmp(argv[i], "extend") == 0)
+			run_rsi_extend_tests();
+		else if (strcmp(argv[i], "extend_smp") == 0)
+			run_rsi_extend_smp_tests();
+		else if (strcmp(argv[i], "extend_and_attest") == 0)
+			run_rsi_extend_and_attest_tests();
+		else if (strcmp(argv[i], "measurement") == 0)
+			run_rsi_read_measurement_tests();
+		else
+			report_info("Unknown subtest '%s'", argv[i]);
+	}
+	return report_summary();
+}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index bc2354c7..5e9e1cbd 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -311,3 +311,53 @@ file = realm-sea.flat
 groups = nodefault realms
 accel = kvm
 arch = arm64
+
+# Realm Attestation realted tests
+[realm-attest]
+file = realm-attest.flat
+groups = nodefault realms
+smp = 1
+extra_params = -m 32 -append 'attest'
+accel = kvm
+arch = arm64
+
+[realm-attest-smp]
+file = realm-attest.flat
+groups = nodefault realms
+smp = 2
+extra_params = -m 32 -append 'attest_smp'
+accel = kvm
+arch = arm64
+
+[realm-extend]
+file = realm-attest.flat
+groups = nodefault realms
+smp = 1
+extra_params = -m 32 -append 'extend'
+accel = kvm
+arch = arm64
+
+[realm-extend-smp]
+file = realm-attest.flat
+groups = nodefault realms
+smp = 2
+extra_params = -m 32 -append 'extend_smp'
+accel = kvm
+arch = arm64
+
+[realm-extend-and-attest]
+file = realm-attest.flat
+groups = nodefault realms
+smp = 1
+extra_params = -m 32 -append 'extend_and_attest'
+accel = kvm
+arch = arm64
+
+
+[realm-measurement]
+file = realm-attest.flat
+groups = nodefault realms
+smp = 1
+extra_params = -m 32 -append 'measurement'
+accel = kvm
+arch = arm64
diff --git a/lib/libcflat.h b/lib/libcflat.h
index c1fd31ff..893fee6f 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -163,6 +163,7 @@ extern void setup_vm(void);
 #define SZ_64K			(1 << 16)
 #define SZ_1M			(1 << 20)
 #define SZ_2M			(1 << 21)
+#define SZ_512M			(1 << 29)
 #define SZ_1G			(1 << 30)
 #define SZ_2G			(1ul << 31)
 
-- 
2.17.1

