Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3463B2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiK1UTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiK1UTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:19:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEC41CFDC;
        Mon, 28 Nov 2022 12:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSx59Ct6SxHXB/+x5snCYQCwWAMcFUioJYLTwAi0ewjf0KSnzmyI5MYuv/XxIOwsQqULgaAY3u32L78RqWcmJtommggElb+HQfrSDnylMCikCvOlTeBw/ofcOuafNTMSUkhgffuYjvQ26OfsVK9Y+oHETkj4HkVu+AkuiJFfkq4hgZqS7MxQk0hgJSJiQGWQjPLm4MAnBGiwfSE7dCb/diQ2QabGsLsrtRIgNHyZ0r8l9iY6xooFPdxGT+CVtIvgov8ENs2iXRYsUQ3YoHZJJ4j/2W44DsjMDT15FFdS4PxDoMXlPD6dXkO72Y2RGwX1XpFkJSqlXm4pxPPSjc/vXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bjYacb2l+/bfej100wjY2vSvC/9mKoZgjUAIAfJG0I=;
 b=UdP2cyAmkw6DPvtxSoIB7HyM4dW73g+EASwcT1tm0rCYZDV1WhycbQccYhW2hrOxT7DPGaUVrZg9ymk1woS6h5OC/2AOxRD7WaC76YTEaDxvPCr936sLOBFqhsteuhUvDjn/wWc0Ih4+n4qayYsbAK0LkHnvJ8H66lJ4CVeUQ9NKwxrfH059gwWYR8E/b4GI4NKKe6FJyc63tlrGZhlT2KiysROZGo/1SS+D50pIJ3Kh5m3JoS8TqpIXvKRTLne4tyE5YA8Lc4P3zR9albM5y+P319XiIp77du94Ve6ckfm5UFOISKyEHlb7843IY4dkciFHBut8u/VKPxKtkFZibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bjYacb2l+/bfej100wjY2vSvC/9mKoZgjUAIAfJG0I=;
 b=u55+i8GR737XgaLSXbToWtDeJ53ybopAX2Aar1G/hZ+mmEPO6umt8VW7cNUnwBwvGxkvD49zhokKZhuDhdIEUlNv7+/DITah8iBVZmMjcu+E4AMX6ScZqQDKuTP7u95SyW5hKXrjqE3IRn3/aaMWcdScRGyPem/kBc4wpHHnWY8=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 20:19:34 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::27) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 20:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 28 Nov 2022 20:19:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 28 Nov
 2022 14:19:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 28 Nov
 2022 12:19:33 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 28 Nov 2022 14:19:32 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <ojeda@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs: Integrate rustdoc-generated output to Rust docs
Date:   Mon, 28 Nov 2022 14:19:32 -0600
Message-ID: <20221128201932.168313-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7511df-c633-4510-70bd-08dad17ddd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX03JOwtjHu7sxlJi8dQ6mIyn4Whjnp/UqQWHHDvnkh/OLSwFr9eIPpBWd6IFfmwhmKhjZh/gDCYiVbZPfAa83B5RFGsnqDAdYEHST7DSdq3LKZPJNtTNkGaEdtp5S9q3GBE5HD6RQGBNcYBYlMb+MIzmd/E9J6c+FxO0oRCVAmuumrsaD8sUeDOY0fZ8H/SPdEEdsakiqU2xQnsSRWUmYWAmds31bN2TY+nMVSSuToTybUkWz3ekoqIciLdymw/IFUOpJvQXasdklhY2C1M9YPZxzhWCBBgXVpMfM0qCCfE4Fq+90bsnc9cMTUx64pXs2RsQSM14Wy6ShDbbit66ZCSIvfYD6CAGrsumWygz3eo7ThNwj1JzwKGr9p6Kv8HplYox/NVs/3OWH9pbF6C1LsFlW/Fpmj9NoH5pLedjeaEayiONlFVlRGsYCZPazZjAXo1IxqrC2nOa4FKytlgyNZvvofjkmelwkzUH57Nt3bKYTl/SqQN9DACJu4BN9af/DkBNUVYMFZniYP9SHXJU8guycCsdmv9LBRio6ULIlrVW9bvdKY6jGy5TFzT8qGRARrPoc78XTYbhtlIzX+WWLDa1h5MML8ub99rXD+/3PzcUZXrtc9fPn58VEKCXBm+9jXTi+Ylq1TlgZlh/7Lw3hJBpDKvxYiOyImRj7dRZkPnOeW9OFLPrc6OciCcJ02Gvr8gPYlIORDiGPXrjs7ZkYTp4mGdzccFQmcCxBZB26s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(356005)(81166007)(40480700001)(40460700003)(86362001)(110136005)(7696005)(36756003)(54906003)(8936002)(478600001)(44832011)(2906002)(5660300002)(2616005)(41300700001)(316002)(4326008)(70586007)(70206006)(8676002)(36860700001)(82310400005)(186003)(26005)(1076003)(83380400001)(336012)(426003)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 20:19:33.6966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7511df-c633-4510-70bd-08dad17ddd26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include HTML output generated from rustdoc into the Linux kernel
documentation on Rust. Add Makefile target `make htmlrust` to combine
make htmldocs and the generation of Rust documentation.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/Makefile         | 11 +++++++++++
 Documentation/rust/index.rst   |  1 +
 Documentation/rust/rustdoc.rst | 10 ++++++++++
 Makefile                       |  2 +-
 4 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/rust/rustdoc.rst

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 64d44c1ecad3..02ed01fa3499 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -95,6 +95,17 @@ htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
+ifdef CONFIG_RUST
+htmlrust:
+	@make rustavailable
+	@make LLVM=1 rustdoc
+	@cp -r rust/doc/* Documentation/output/
+	@make htmldocs
+else
+htmlrust:
+	@echo "Error: CONFIG_RUST must be defined (see .config)"
+endif
+
 linkcheckdocs:
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
 
diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index 4ae8c66b94fa..5e7a9d39af90 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -13,6 +13,7 @@ in the kernel, please read the quick-start.rst guide.
     general-information
     coding-guidelines
     arch-support
+    rustdoc
 
 .. only::  subproject and html
 
diff --git a/Documentation/rust/rustdoc.rst b/Documentation/rust/rustdoc.rst
new file mode 100644
index 000000000000..74581367417b
--- /dev/null
+++ b/Documentation/rust/rustdoc.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Rustdoc output
+==============
+
+If this documentation includes rustdoc-generated HTML, this is the
+entry point.
+
+.. raw:: html
+    :file: doc/kernel/index.html
diff --git a/Makefile b/Makefile
index f41ec8c8426b..c7e00bf928ed 100644
--- a/Makefile
+++ b/Makefile
@@ -1785,7 +1785,7 @@ $(help-board-dirs): help-%:
 # Documentation targets
 # ---------------------------------------------------------------------------
 DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
-	       linkcheckdocs dochelp refcheckdocs
+	       linkcheckdocs dochelp refcheckdocs htmlrust
 PHONY += $(DOC_TARGETS)
 $(DOC_TARGETS):
 	$(Q)$(MAKE) $(build)=Documentation $@
-- 
2.34.1

