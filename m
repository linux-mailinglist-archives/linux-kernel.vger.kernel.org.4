Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58263E326
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiK3WJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiK3WIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:08:50 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68681950CB;
        Wed, 30 Nov 2022 14:08:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqhf7VDU4B8Z8HN9CW4BQo/CWo4+1hQxaKm3EBfYgLM0WqJu6wh/O4NbRppJP6STlxAvGdJD+hPytZBscCxLdFZ2qC4EknJqjGpGUyb72DEtBYUB8BvPk0xHWDgZRMxTXZztqXXK0JYg/kset3tCvuvoh8qooOdtswb9AjWDC3pVPNEA2TWu9SKpPV21CyqgiUBFQhxg9E56qDvCKRdPK0vr4NAubw6WJxkp2CBvxxPKdm702go4sh5g7DjPXDjVaGXwYEPFDuyjMGGVKp0sJvIxBTbV+f6e5OFkdqaLVvf5jAQOKgWV5IbsHSzAR+J43gaXNirv86AhiQFtFANlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBCTYfLZlTLoplafRcpyElJWchq+ALO7akMWYF0z8wY=;
 b=b+8Ir8xC8Ai9TmC4o0TELwriqQHZFsEnirnQnB0xFeUior8wLi9Xbxuar0rC08t0OLpV/4gK7r/vHoOE2bQ6+KktiP1NCwop4+XXvnl9WXpvwOR1NYnWFKgCO5Ba+UjTAlOF2iwAXlhK0mrN4qsCZY2DhN244sXzWB4BQ4Gk9akUJS1Y1CeTWk8Ho56NSHndrq9gcTmCfSuZ59EoF4ADc6MrKF1CzqCcTJq4SSCkv7jWenVmMMO6vAniXn8ucoq+N4Hfvp3FRVF07QQFiUYGbzPhOwhfTEVsV48zOcUc9CHx+Wmu+BT4Bqsw0NpmIBYEsl5dTW/5b1fezRAV8p8q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBCTYfLZlTLoplafRcpyElJWchq+ALO7akMWYF0z8wY=;
 b=SHsFHv+zjyhGNNo83dnHXX4h0oY9oknH7sYviIjLbIqoc7BPvyIQQoOjEv9oywYv/DxfxemaAoMga4P4ulZbluYxzUpHZVJ7bdgj19nV4kR6jY2H2o/JokvVApd4fcJX/q1uOhqeNMUMaGeu0i5NykwABPxjX5zEvicXGUqLTTo=
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 22:08:26 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::3) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 22:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 30 Nov 2022 22:08:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 16:08:25 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 30 Nov 2022 16:08:25 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <ojeda@kernel.org>
CC:     <bilbao@vt.edu>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konstantin@linuxfoundation.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>
Subject: [PATCH] docs: Integrate rustdoc into Rust documentation
Date:   Wed, 30 Nov 2022 16:08:25 -0600
Message-ID: <20221130220825.1545758-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|BN9PR12MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: d21a665a-1938-45a4-2121-08dad31f67a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdWEeCkG7jrc80haDPjlug829akfhyVpSqfR+EAaZLJeE8BUTMoMeJmH5Wt5e75JfYSu3FuvQCvYwd0oqbGFpG/qz30taISiIh2pxmeiUVaCS5FrmmiUtHu4NCEB1GxvsfbclQwWYpfyZHAbWBSHtubbzQeYwD7fAUodm8yzwppAGEEtqm+2/wc4jZcLLrIynN4Wlfe/g0O6icTHgy2hSIg3yX6TxQAcOhK4Y0uf/F6bq8TtxKRudfHna6tyzKDpL65v6WR1BHpNwjnbNnKeeoTRsKSEYwn3rMtjjalNZIhaf5KLUaiSh1VvSeVKPMj0GLtyA5e/HZtXC4B2DUsgCCOflWVEJRojclQiusb70VkUEcOS8EXF4dEVwH3b7MPt6zXxpXOJ/8vuZxdqMSBy7d4/QIUCAPWPYuS25BAachNnsYD6hcigBF03gFS8Ulg96YBzM8Z3A/V1esKMSJ+D7ugX//AZJYBuqdLGK0LVHvy2CfLNyL0Kgy4fqmCbvxofvg4XL6YqqaqBdzLYwijv9QK7M8iSs/Wjd1W9zhB07WViRYdXidYvVzlDmgdaVcaQQ54ms3JOOxpBS+SmvLdqFk6E4lnYy6k7HCppgd13tyJ7UE5oz8dpZHAn34ahs/tPHtMWuJr7nJomc3c3P6SbyxbBlDtpoqo/9/mJEv1onpJriVzsdycwEpPRGI9c/WWtwyt7RQkMYrnA4kZfwchfqadR30+HTi2RdEzidcHQfyI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(478600001)(36756003)(82310400005)(40480700001)(26005)(7696005)(81166007)(40460700003)(41300700001)(70206006)(70586007)(356005)(8676002)(86362001)(426003)(4326008)(316002)(44832011)(54906003)(110136005)(8936002)(5660300002)(336012)(47076005)(2616005)(186003)(1076003)(83380400001)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 22:08:26.2068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21a665a-1938-45a4-2121-08dad31f67a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
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
 Documentation/Makefile         |  4 ++++
 Documentation/rust/index.rst   |  1 +
 Documentation/rust/rustdoc.rst |  7 +++++++
 rust/Makefile                  | 15 +++++++++------
 4 files changed, 21 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/rust/rustdoc.rst

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 64d44c1ecad3..5e9435198cfb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -92,6 +92,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	fi
 
 htmldocs:
+# If Rust support is available, add rustdoc generated contents
+ifdef CONFIG_RUST
+	@make LLVM=1 rustdoc
+endif
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
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
index 000000000000..aa63a550b34c
--- /dev/null
+++ b/Documentation/rust/rustdoc.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Rustdoc output
+==============
+
+If this documentation includes rustdoc-generated HTML, the entry point
+can be found `here. <rustdoc/kernel/index.html>`_
diff --git a/rust/Makefile b/rust/Makefile
index f32df0e49815..eb2ff9260a6c 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Where to place rustdoc generated documentation
+RUSTDOC_OUTPUT=$(objtree)/Documentation/output/rust/rustdoc
+
 always-$(CONFIG_RUST) += target.json
 no-clean-files += target.json
 
@@ -67,7 +70,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
-		--output $(objtree)/$(obj)/doc \
+		--output $(RUSTDOC_OUTPUT) \
 		--crate-name $(subst rustdoc-,,$@) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
@@ -84,15 +87,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
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
@@ -153,7 +156,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
-		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
+		-L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
 		--crate-name $(subst rusttest-,,$@) $<
 
 quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
-- 
2.34.1

