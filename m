Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB56E5F7FB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJGVRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJGVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:17:36 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A5073C1B;
        Fri,  7 Oct 2022 14:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqpv+EeHnxh5MXCtBHfIFSTZSIV5SgrFE5GC4EheF7IxmHvJTlZtrI9mLHKh76tDUfjzi6mNh4S8Sk37PAVgSVv18sCf4iIngHUg0hHJtt45mxY+o1FYsNnDC1BuE3a7FgpWimnd5ElG539qH6slvM0NjCQkGKBDyiZmRAqVis9OiXWJXxemdpIGe95oYDcW9vDvnqiGC54L215OXFNX0APb7PSwNsEAm0ZNFSbqt2waCrywlJ2aTvbJ0GlhSqitU+0H48RFcvx/svcQFZRdoRzr7h1+I5ka8ZsfXJdNsmtLdYHIEnVnKE0W8yViJaulqzIM3n9w4DbVHzz5ScRsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j51i0QUL/GQU+TUlox0vZI0lQDIXngfwMeYzEIXiQ0Q=;
 b=GKCMQgfPTyA+SgzCXGNgrWqHuH+/s+XP/1S/FzccbVP6o3MqcjGWiRcCsNdp0GiG2M3W7Qs5BGpbZZhTbZQkXzqILx5vFXU1HTz2Bh13iEXVViHWyaqTLYO8xkdf/q0UCxB2tPzTkzT/U0pcx41UGiIxTiRcLY7mZGnBt0nYAUOhD1X5fBk6S7mMjbqYdAsFDdYnQACtHaNXawFQdlH+O3knMyJdu1LEge/PTO/CLgJza3yuUW6tgFgVSzrQD6R71Q5tORhBfgR501JsRYh7DBazVfLt7+zp72NO6l0r7a9UjUpHpEP30IUZodSIDoDZauXe3OxbQznNnCPGKx97xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j51i0QUL/GQU+TUlox0vZI0lQDIXngfwMeYzEIXiQ0Q=;
 b=uwNVC6l+jd2umBzYV11g4Be4UsGxmgfei5UU1oAE/R7aFGjzvDmF2qL+sPVt4vNROHyZF55X7yL9rKt09dCtiJpmHFuErSFfmhrNNlJdzU4rf7LKwPhvtzLnDBgD6sqMf3RDCSTPEO+Abvz/BXCX0/DaEcM+hGODXZsywPgtk4k=
Received: from BN8PR15CA0072.namprd15.prod.outlook.com (2603:10b6:408:80::49)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 21:17:31 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::3f) by BN8PR15CA0072.outlook.office365.com
 (2603:10b6:408:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34 via Frontend
 Transport; Fri, 7 Oct 2022 21:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 21:17:31 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 7 Oct
 2022 16:17:30 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 2/2] efi/cper, cxl: Decode CXL Error Log
Date:   Fri, 7 Oct 2022 21:17:14 +0000
Message-ID: <20221007211714.71129-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 43431578-cb34-4259-5246-08daa8a9584c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79bOGSZHtmWxxOrHvuFxoAfr7tBkYFYNFQgUqE4CeIQx9lCKETo/tKoInuYdYG5x2v/Kfs1FPaJwJACAtM2G3uoUUR0oDLoK236lP2Fqfn9IPI3oQKUkP72+dINutu5nl7684OVe441nXAUIkRw65HTy1u0aJ2TLlXR6lWU2EdSdjDVPEs8/9e+vEEuJddSxGr0NFST6F3j9VN4Pl4Kq0MWc2w0T8cZxJHcuTJikCXHSfmlYIKGLJBhko/25ht5itprMIWVfieCIyucUCNChK9KyVIqAcpyjzW25Az00ECudOKn2SPXQiz9rJ6hiVdnnfHwQ16jT7rXpTVVwU+XrfQq9Zw2kkjTZAwZg2lMQHyrVBGd+f4wFSMO3bP0h4B0MhK+eD3wxSIfZ4PYiYAD7ANtA70skMmlPCSP7leViT8qfOM7Dn/hewIAdrqJbNXyymfEIiGrpyG6IuKY8rEwCdU2Nw5l91MqXNe9B5onJaqtiAPziJYkrcwXSNsRD3bcbJybvqqiBu4Ci/amI9jirZRIDJeOvtAEqfLTAIJoYN5LVTT5BJ7b9h08NJUPK5StHuX2Ht08UnXq4IkdDFgFgCL1Q1sfeZYEYwHUQvx9nZdC8RvsgHKH6lSSRfcpazWLjfKIjKqFCXBncvCPu7nMFDnQCmObQF+tKTTH/nOni9kvNCfkxRpSSlrwMnW4je/uNsIqiHb69UVifLhOpp0jhk+djILBlFhJhA02maY9uKRdi5LAZNfnJidxSeRtz55FqBOYV78czvZha5JeJt3dil1sU3uK2X206FpOFq0KGQvmNR5k9VHm02zksJA+AI5in
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(316002)(5660300002)(70586007)(41300700001)(70206006)(8936002)(36860700001)(426003)(8676002)(4326008)(47076005)(2906002)(86362001)(336012)(40480700001)(82740400003)(7696005)(40460700003)(6666004)(478600001)(1076003)(356005)(16526019)(186003)(110136005)(26005)(81166007)(2616005)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 21:17:31.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43431578-cb34-4259-5246-08daa8a9584c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the CXL Error Log field as found in CXL Protocol Error Section.

The CXL RAS Capability structure will be reused by OS First Handling
and the duplication/appropriate placement will be addressed eventually.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/cper_cxl.c | 21 +++++++++++++++++++++
 include/linux/cxl_err.h         | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 include/linux/cxl_err.h

diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index e5f48f0de1a4..c3d1d0770aef 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/cper.h>
+#include <linux/cxl_err.h>
 #include "cper_cxl.h"
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
@@ -16,6 +17,7 @@
 #define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
 #define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
 #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
+#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
 
 static const char * const prot_err_agent_type_strs[] = {
 	"Restricted CXL Device",
@@ -84,4 +86,23 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 			break;
 		}
 	}
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG) {
+		size_t size = sizeof(*prot_err) + prot_err->dvsec_len;
+		struct ras_capability_regs *cxl_ras;
+
+		pr_info("%s Error log length: 0x%04x\n", pfx, prot_err->err_len);
+
+		pr_info("%s CXL Error Log:\n", pfx);
+		cxl_ras = (struct ras_capability_regs *)((long)prot_err + size);
+		pr_info("%s cxl_ras_uncor_status: 0x%08x, cxl_ras_uncor_mask: 0x%08x\n",
+			pfx, cxl_ras->uncor_status, cxl_ras->uncor_mask);
+		pr_info("%s cxl_ras_uncor_severity: 0x%08x\n", pfx,
+			cxl_ras->uncor_severity);
+		pr_info("%s cxl_ras_cor_status: 0x%08x, cxl_ras_cor_mask: 0x%08x\n",
+			pfx, cxl_ras->cor_status, cxl_ras->cor_mask);
+		pr_info("%s Header Log Registers:\n", pfx);
+		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, cxl_ras->header_log,
+			       sizeof(cxl_ras->header_log), 0);
+	}
 }
diff --git a/include/linux/cxl_err.h b/include/linux/cxl_err.h
new file mode 100644
index 000000000000..c89dbb6c286f
--- /dev/null
+++ b/include/linux/cxl_err.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
+ */
+
+#ifndef LINUX_CXL_ERR_H
+#define LINUX_CXL_ERR_H
+
+struct ras_capability_regs {
+	u32 uncor_status;
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_status;
+	u32 cor_mask;
+	u32 cap_control;
+	u32 header_log[16];
+};
+
+#endif //__CXL_ERR_
-- 
2.17.1

