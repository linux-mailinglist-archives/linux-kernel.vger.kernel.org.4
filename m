Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B163F95E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLAUsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLAUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:48:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48F82EF44;
        Thu,  1 Dec 2022 12:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNUQ8OH9eKcP0P4dDXtf+J9738cJubQshWv6dRkVg+MSAuuFVv44TIWoQEw+Lrr+FpVJon0fUMZ56lfrxP7DIXKTi6cZactMwm2IudGpYYrdwlIN5zaEUnlSmbwhmHc8VEGgbdWuBV61mJ9rr2ap52+C3L3z9QnK2KC/S1nEcZsy6xHtbF2RyAojdYkL/63a7PpvXiGYJY2JOK/YoZ1BBX2Yym+xp9UWB1bwv2AdGo7sdLVPns3Fw/vdPcbakVorcTuf9jn71YErm0nBQxpxo2paznZANi3Uy4TRwxAxia72yzBR005txFyNXQ2GNCnKzCf3SsdIHJiMCdxaYbmcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2hEUEMFbIiMGHQv+7ZQwqcv4T6euaf6BcLAB2YbWuA=;
 b=oMIXg2mBCWKRjs+sB9JZBSwc/ShwVCOfcOMoTI8IWVhSEc+59mBIM7XbywbEnrCD6dURv9v3YO79ovR4pFDJCwLTaghFo7M55/NBOv3X5E9DZfwHnKNuBiKV0nsO68yZpr7zGn8Lvg9IBNgg4XmZFFHSXuUGLDmvwHxnHVX/4SOHBscoe+yxytloyD2rw2gEmuiZsj4YAL7NsVXxLvfbeIVDhW4MisCFZxJTzFtuAa1WWaEyzkmukflsK4pjES8hNTZd92v8slkBDlMQfwNmPQUW6LdCAeVOlAVILcWyus5/M7WerW0EvTgrAvwb0kEejIQ8xLnyRqqUUD9dJvjowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2hEUEMFbIiMGHQv+7ZQwqcv4T6euaf6BcLAB2YbWuA=;
 b=4bcdN3s+Quaft1l6ahymopiT6DKX6EDbpDNixrQ41mfjZPmxefg7xzzxv50Y7nTDfxH59kRD1d7QD84ZYdhcJX3OfGRPIMI5q3Z2PKjDjOEkT0ISDEiibvW2mc8EwcCDRyK+oYHazvRTEEguZ+S6uwKEX8bWakV9PAx51+3P6y0=
Received: from MW4PR03CA0129.namprd03.prod.outlook.com (2603:10b6:303:8c::14)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 20:48:16 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::16) by MW4PR03CA0129.outlook.office365.com
 (2603:10b6:303:8c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 20:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 20:48:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 14:48:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 12:48:15 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 1 Dec 2022 14:48:14 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <ojeda@kernel.org>, <akiyks@gmail.com>,
        <konstantin@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2] docs: Integrate rustdoc into Rust documentation
Date:   Thu, 1 Dec 2022 14:48:14 -0600
Message-ID: <20221201204814.2141401-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130220825.1545758-1-carlos.bilbao@amd.com>
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 84227b8a-e9cf-4026-c797-08dad3dd5edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs9O7K3jxI/6AVDGWcJd+muUHfTEK5PjR6bhEXGIx7I2vE9qIP5TloF7J9OmyTu+IA8sMrMIUn5YbuvlxRZxaRlbS0RCWZPSH3PA+QW2ogvGEFv/rtBMNtNwlGOQYpAaV3lbgUAi33ESqfmf5oBcgJDR58VDDMx5E515qYNMhIklS+CfdEiGhOLHdqqJI4x3SoyizNExbYI2vA8D2dZcItfIRU0YYtOvZKWkioxuE4oUCmnpY0S6CadVRJlNxh2YJFVSSSFsbcdCG4xLsfbwH/y+Oi7Ju9EHQW9rGJ+qMGZYmgZ5HS4kGD9/7JVfAssMjj0XUAKSrd9Hko24d9Soq95/nfNrLmH8Cd4X59XzqkwIwUlL38qjJvVxLCfeKrdaRz2uBz9//KXY94N/db2JDYa2pWbK0ZFipFIofcog9d+Y4SPurFCSSKcwcldCsFK0PqpypzlS4xNWs7yMhjzu1e+bdpnAthxEq609UqwY9Mz5dvn6iXw3t5mXU5zjqHJ963b90gb+DaksonC55Z98MKW5wlprv50drQEJyLyPqs+/koKIFQ1yGv0wGCRSck0OVhsUvTxWbOlMdv3Etz69TU5qFagEg1Rb3iFpC2sTlr2jTRmdNNdgUI4JBhAbNfWRJruRiOEBMus3bBXB+igOuAO++LFFIgs6uFiwWPFrSjjMBuRcuqbtJHlXF9D5DTUvYxXB8GFTfNfmPwsPLXB8fSr899y2xdzTgwtu8QvbO+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(70206006)(5660300002)(8676002)(8936002)(41300700001)(70586007)(44832011)(36756003)(4326008)(82310400005)(40460700003)(40480700001)(1076003)(36860700001)(26005)(186003)(47076005)(336012)(426003)(2616005)(83380400001)(356005)(82740400003)(81166007)(86362001)(316002)(110136005)(478600001)(7696005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 20:48:15.7584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84227b8a-e9cf-4026-c797-08dad3dd5edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include HTML output generated with rustdoc into the Linux kernel
documentation on Rust. Change target `make htmldocs` to combine RST Sphinx
and the generation of Rust documentation, when support is available.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---

Changes since V1:
 - Work on top of v6.1-rc1.
 - Don't use rustdoc.rst, instead add link to Documentation/rust/index.rst.
 - In Documentation/Makefile, replace @make rustdoc for $(Q)$(MAKE) rustdoc.
 - Don't do LLVM=1 for all rustdoc generation within `make htmldocs`.
 - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.

---
 Documentation/Makefile       |  4 ++++
 Documentation/rust/index.rst |  3 +++
 rust/Makefile                | 15 +++++++++------
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 64d44c1ecad3..f537cf558af6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -92,6 +92,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	fi
 
 htmldocs:
+# If Rust support is available, add rustdoc generated contents
+ifdef CONFIG_RUST
+	$(Q)$(MAKE) rustdoc
+endif
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index 4ae8c66b94fa..4005326c3ba9 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -6,6 +6,9 @@ Rust
 Documentation related to Rust within the kernel. To start using Rust
 in the kernel, please read the quick-start.rst guide.
 
+If this documentation includes rustdoc-generated HTML, the entry point can
+be found `here. <rustdoc/kernel/index.html>`_
+
 .. toctree::
     :maxdepth: 1
 
diff --git a/rust/Makefile b/rust/Makefile
index 7700d3853404..080c07048065 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Where to place rustdoc generated documentation
+RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
+
 always-$(CONFIG_RUST) += target.json
 no-clean-files += target.json
 
@@ -58,7 +61,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
-		--output $(objtree)/$(obj)/doc \
+		--output $(RUSTDOC_OUTPUT) \
 		--crate-name $(subst rustdoc-,,$@) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
@@ -75,15 +78,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
     rustdoc-alloc rustdoc-kernel
-	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
-	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
-	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
+	$(Q)cp $(srctree)/Documentation/images/logo.svg $(RUSTDOC_OUTPUT)
+	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(RUSTDOC_OUTPUT)
+	$(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
 		-e 's:rust-logo\.svg:logo.svg:g' \
 		-e 's:rust-logo\.png:logo.svg:g' \
 		-e 's:favicon\.svg:logo.svg:g' \
 		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
 	$(Q)echo '.logo-container > img { object-fit: contain; }' \
-		>> $(objtree)/$(obj)/doc/rustdoc.css
+		>> $(RUSTDOC_OUTPUT)/rustdoc.css
 
 rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
@@ -141,7 +144,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
-		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
+		-L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
 		--crate-name $(subst rusttest-,,$@) $<
 
 # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.34.1

