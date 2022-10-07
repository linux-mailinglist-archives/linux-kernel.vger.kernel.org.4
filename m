Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A935F7FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJGVSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJGVSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:18:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D36748D5;
        Fri,  7 Oct 2022 14:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejuzAXQkc0BlbN45fAgXkMC6WlFO5sG6kN4vU2ADZs0pYSn6wIF3gha+5AlMBP7FLziT541Qu84UFnlFt6F6ldzFF79bziDdE/N3qGx1fGcKMNSFuLYPx5JSHTuDiF+wV+s4kuUuRR5Q+yggUdTH1ZmhM+ik69V/QThtHcu0cIlmkcY9uB8f3+3w29LvyL9uk2RjgRNreSf5kf4xCfCxOUSPdZUQmV2xTkL5Vm+aiYMlrZSbiLVVuWbcDFI3PcqFsmFKShoS0W1myHzZ5I5xfn0X1nuhWix75gfWTiWzMe8WHeXzAc2i1pWiJZ8lrVb7WtCGSimIbICw/vIePXeupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqgIgG7eFAKdQN7WKusA92r6fEvTgZv9MIcqCXqScpA=;
 b=HGtufid1Vg+QWcql8N+6dEtUuMKFvnmN0TOpwG+HVerQoMUPR+jQF3eGVC1QXKC7Epo65/hwFmjrPnk2e6EQ41NGZGCiFLoaG14aJ5vt4rmzVK8AZv6KTe15wOHupUEdG+lXejUsx6j7ZgUz6VYjV2rhC2t8oPMEYt/5vfTx74mREu1jORnyD6E5OatV6kykFo5NDLMjCEgIxGkezHLZp+eVGgPZBKpM3BYrhAuNUwOPfsvFVVwtJiXzqIulKlmxJnf7wY+OhLeRrNFs0v9Q9HykhsNcfKAy2OV65DWH792f5fvQaibD0dUog9pZD7FUuajroLNeO5kKcvfz+pVrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqgIgG7eFAKdQN7WKusA92r6fEvTgZv9MIcqCXqScpA=;
 b=VCU+C/uO5nbg5CLRw96058OjZvH4aOvVWvGuvrU/2Ed/JD7HNkSxzqMlhyeVobgBe6aNCDTL9sV+eyNXs2LMIBIe59SnysnVifMg2EKq4BRN/3m+VbpBNnUUm8FkXU1z4poWE6+Q80Xo7hTHx2y/gIhIZVKhe7S4Q6ID5PpXeho=
Received: from BN8PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:70::41)
 by BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 21:17:29 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::fd) by BN8PR04CA0028.outlook.office365.com
 (2603:10b6:408:70::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Fri, 7 Oct 2022 21:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 21:17:29 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 7 Oct
 2022 16:17:28 -0500
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
Subject: [PATCH 1/2] efi/cper, cxl: Decode CXL Protocol Error Section
Date:   Fri, 7 Oct 2022 21:17:13 +0000
Message-ID: <20221007211714.71129-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|BL1PR12MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e09a3de-cc06-4e6e-dc57-08daa8a9576c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ayJSA04obPQqRVr40JW2XTN6dZagPLPP955XVyOuQH3e3Phj9fNsjHJpusZ1qkx98kxf5/k5ib1Ujbd9NbzqN22JGVE6UZKXOLFDoGLiHz0IVJbb3zs8GeIKPY6uBfNDNcUyWpNMN5h7ifg27JeY7zP8ND1cNTFe/wy5Z+gcOv7F09NhXlGqzYehdqetk9BrSvsFNvMYCmwkasRjC3AOrZR2FcFa0hISVAYKE8m1BCGrCq6sRPoTvWZ4haIQP00i3aseeabxqsseQctvtThbNvUzU+1JHmHA3d1fuDNa6vITDnAmymw2k2bTLCHPrFwWj3CYAywrZ8biz2Ezfw4ROqJsM2ZbI4f3+Uej9EJGpEMh0ZI/1J8hjqqGS6XJ0dz9qXTv8YB/BZfC3dk/LMt4YJA4XjVgvTI/c5iOn9mxxPbistGljPomTOgdLzZLwujVJbKkXWvIsKcagglvOREUtWax9QaX3+Jp7z418UUg5P7rJk8VgPSah+dvxDHrtZrcHhvS+5yJpOM7a18ZiaNtidWrrDGoQlgJzUuuu7aG3PelqTp5MHwaMy41lQJHTwl20UR/OADn9OfDTUUA4aOEGaI+hUbYq6KzUPCrO6QfYvtNdKzO94agEAsQBDkI4PqYBhfu3+710Gl0G2fL/+S4Cr0XOYGZl0mEyRVkcGDY7wsIhA5t0LysA9R2CfmbLKWkEyNG4DEw1b2/dMOaPhfWblHBHO2PZIFVTh/h+GsIcSI16GptE5Fbub4wOT3gSBw470MydJWSNBTYz8xwZ+NKYRuR679SFv1qL4dN641J4g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(6666004)(54906003)(110136005)(86362001)(82310400005)(8936002)(36756003)(5660300002)(8676002)(478600001)(41300700001)(316002)(70586007)(70206006)(4326008)(36860700001)(2616005)(82740400003)(40460700003)(40480700001)(356005)(81166007)(26005)(7696005)(83380400001)(47076005)(336012)(186003)(426003)(1076003)(16526019)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 21:17:29.5569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e09a3de-cc06-4e6e-dc57-08daa8a9576c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5303
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for decoding CXL Protocol Error Section as defined in UEFI 2.9
Section N.2.13.

Do the section decoding in a new cper_cxl.c file. This new file will be
used in the future for more CXL CPERs decode support. Add this to the
existing UEFI_CPER config.

Decode only the fields that are useful to parse the error.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/Makefile   |  2 +-
 drivers/firmware/efi/cper.c     |  9 ++++
 drivers/firmware/efi/cper_cxl.c | 87 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 58 ++++++++++++++++++++++
 4 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/cper_cxl.c
 create mode 100644 drivers/firmware/efi/cper_cxl.h

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 8d151e332584..4f332de54173 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -19,7 +19,7 @@ endif
 obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
 obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
-obj-$(CONFIG_UEFI_CPER)			+= cper.o
+obj-$(CONFIG_UEFI_CPER)			+= cper.o cper_cxl.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 subdir-$(CONFIG_EFI_STUB)		+= libstub
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e4e5ea7ce910..181deb9af527 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -24,6 +24,7 @@
 #include <linux/bcd.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
+#include "cper_cxl.h"
 
 /*
  * CPER record ID need to be unique even after reboot, because record
@@ -595,6 +596,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_fw_err(newpfx, gdata, fw_err);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: CXL Protocol Error\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*prot_err))
+			cper_print_prot_err(newpfx, prot_err);
+		else
+			goto err_section_too_small;
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
new file mode 100644
index 000000000000..e5f48f0de1a4
--- /dev/null
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UEFI Common Platform Error Record (CPER) support for CXL Section.
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
+ */
+
+#include <linux/cper.h>
+#include "cper_cxl.h"
+
+#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
+#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
+#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
+#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
+#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
+#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
+
+static const char * const prot_err_agent_type_strs[] = {
+	"Restricted CXL Device",
+	"Restricted CXL Host DP",
+};
+
+enum {
+	RCD,
+	RCH_DP,
+};
+
+void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
+{
+	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
+		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
+			prot_err->agent_type < ARRAY_SIZE(prot_err_agent_type_strs)
+			? prot_err_agent_type_strs[prot_err->agent_type]
+			: "unknown");
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS) {
+		switch (prot_err->agent_type) {
+		case RCD:
+			pr_info("%s agent_address: %04x:%02x:%02x.%x\n",
+				pfx, prot_err->segment, prot_err->bus,
+				prot_err->device, prot_err->function);
+			break;
+		case RCH_DP:
+			pr_info("%s rcrb_base_address: 0x%016llx\n", pfx,
+				prot_err->agent_addr);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID) {
+		const __u8 *class_code;
+
+		switch (prot_err->agent_type) {
+		case RCD:
+			pr_info("%s slot: %d\n", pfx,
+				prot_err->device_id.slot >> CPER_PCIE_SLOT_SHIFT);
+			pr_info("%s vendor_id: 0x%04x, device_id: 0x%04x\n",
+				pfx, prot_err->device_id.vendor_id,
+				prot_err->device_id.device_id);
+			pr_info("%s sub_vendor_id: 0x%04x, sub_device_id: 0x%04x\n",
+				pfx, prot_err->device_id.sub_vendor_id,
+				prot_err->device_id.sub_device_id);
+			class_code = prot_err->device_id.class_code;
+			pr_info("%s class_code: %02x%02x\n", pfx,
+				class_code[1], class_code[0]);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) {
+		switch (prot_err->agent_type) {
+		case RCD:
+			pr_info("%s lower_dw: 0x%08x, upper_dw: 0x%08x\n", pfx,
+				prot_err->dev_serial_num.lower_dw,
+				prot_err->dev_serial_num.upper_dw);
+			break;
+		default:
+			break;
+		}
+	}
+}
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
new file mode 100644
index 000000000000..f924d96e4bb2
--- /dev/null
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UEFI Common Platform Error Record (CPER) support for CXL Section.
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
+ */
+
+#ifndef LINUX_CPER_CXL_H
+#define LINUX_CPER_CXL_H
+
+/* CXL Protocol Error Section */
+#define CPER_SEC_CXL_PROT_ERR						\
+	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
+		  0x4B, 0x77, 0x10, 0x48)
+
+#pragma pack(1)
+
+/* Compute Express Link Protocol Error Section, UEFI v2.9 sec N.2.13 */
+struct cper_sec_prot_err {
+	u64			valid_bits;
+	u8			agent_type;
+	u8			reserved[7];
+	union {
+		u64		agent_addr;
+		struct {
+			u8	function;
+			u8	device;
+			u8	bus;
+			u16	segment;
+			u8	reserved_1[3];
+		};
+	};
+	struct {
+		u16		vendor_id;
+		u16		device_id;
+		u16		sub_vendor_id;
+		u16		sub_device_id;
+		u8		class_code[2];
+		u16		slot;
+		u8		reserved_1[4];
+	}			device_id;
+	struct {
+		u32		lower_dw;
+		u32		upper_dw;
+	}			dev_serial_num;
+	u8			capability[60];
+	u16			dvsec_len;
+	u16			err_len;
+	u8			reserved_2[4];
+};
+
+#pragma pack()
+
+void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+
+#endif //__CPER_CXL_
-- 
2.17.1

