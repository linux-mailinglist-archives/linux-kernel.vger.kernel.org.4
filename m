Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6F646043
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLGRbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLGRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:30:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666425C5;
        Wed,  7 Dec 2022 09:30:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LssEoZOEwpy1H6Mx+fbN2UL1lktjoPL4xB0Bz8Q7IoQDghzpbnSN32G7hlT6XaueppFCbJwT4uRYHSzCi7rvdHooQTsOoSip8uPIVxC9uKnfAjjd4SdAbD3UaK7Alsb85Jo66C2V/3lzhX/ytULQRbIdky4S2cj6JTrQ7NxdHhN3DcmIFo/tduX3OJS8ukzPwDU/RikYA6qCSBQxN8g4amVCllH6ir1KBRq7sv1BNl/Aee7ktHDN1Dh/qb7meU0oltLyTMA+GWAnU4y+xrD8Fi/M+FhxuZ48vhUY8MgudzXFgsgzgEZU+sZQkdSoiq10DQDvN/1k4iqHS84AHLYPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nt9UZb1a7DDvTNjM44NL7DYobcejXgPoy/2LXXB9t5Y=;
 b=HL2KtKD+wMA2yVrO+Fo375PWYZe8TcK8zEhJZGyJUxGMx1JhbV2X91qL3870Jfuil5alpuCuJtiFI+TGGKD/YK2puT+quhRbYlVsL/KbKF7Vhxh2ilPsPcxRV23m/BKlxJD9ZyLFT2cKoNyK2nsgCvjRj2dmnEAg/pFNx9aSkRSYwFeyeu4YSwZvxOK/GR7RbQC20W5eZEru2e8tdjSKpzY6y1p9u+IvF73lulzSfGvHD6nND6DpiA2c8sjcBR4EPHOsNPbF5j5K5U3e1ManAtaUmZHU1UV8vMV7MiBxg5Pk+kvbxffCKeVQjz+FOdJdozK67+usHG6r3zSiWwrFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt9UZb1a7DDvTNjM44NL7DYobcejXgPoy/2LXXB9t5Y=;
 b=fBdBgIZb72StbiEKW7QDxOLuS17bNvPjfInZMC/1Jc9Or0NKNdiNHYaNVQXtJFAHW19NpB0xAxe9A0+hLtseyFEQen4ozxmcWbchCBrU8Fx826oQaKZNFxdxGpg6zBh/c2M5JrKg8SRiHn8Bv6MVcSyoeUbYb8nzLdpYOGlOgRw=
Received: from DM6PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:100::29)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:30:55 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::19) by DM6PR03CA0052.outlook.office365.com
 (2603:10b6:5:100::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 17:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 17:30:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 11:30:54 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Dec 2022 11:30:54 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ojeda@kernel.org>, <corbet@lwn.net>, <akiyks@gmail.com>,
        <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v4 1/2] docs: Move rustdoc output, cross-reference it
Date:   Wed, 7 Dec 2022 11:30:52 -0600
Message-ID: <20221207173053.1463800-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207173053.1463800-1-carlos.bilbao@amd.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0dc3ef-66c3-45e2-f220-08dad878cbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvx93BpocbJjMIMxWGUg2KCYnEogZo/WhzkRHqubdwyDNuiYH72MIbb3QPXJvfxzOeI0AW5muNiDTgToQjHMslAGYg66mEAUWF3o0PeIy+f6EYTAnoinPor6ma5zbns5ZHD2xbv93aVECkZTY4R6NI17iV9PaCQ+B7QNAj59IXukyuxaqlXyZbcudrmUxRX4P3FHGxXtO5Q3qRONj8v7G+AKoKAZ4kezCUqIT0LJrA4WYRps8M8iYlz1aauf3dfKqNZCOO2mjkUYGYB1MMPvNo8cFBV8lPEGJyXRTzDGf0pm4zMXyr86fGe06tLv1gt1tWPjIyPfQGxe2H9Qv6DKdekXjK+n7roZfGH4bSVVQY0WfQUSmKpYimz3f/hlP5523PxVGVcib64RCE6VG8TbKDFtaRkCwA+v5iLsBKT9NOwAjOHX6adSC6nf0WTcRSXE82fOsLRpsXsd5zaAelsxnPqGBDaHO+CFP7/jWJXmQ3+Cz2nlThliHCf6noJkycH75bFLRWrmXcQ10S6491XGSh8abQ0Y5AVdYpiNj8pkpaxf4IIIE+Q/H8l56Lnh/ja4AQgK8x8XiJA2q4yyRlnWp/XVEDZMc2fUvDki711TKsWuVuhd6W4s1z41Yz+RwdUU4C9O7zg3Pg8ByAUvt86/AaJgH3/+ZnFBess3BexmesUZI7W5A7po6tNBOpQUvc8qi6kIBlVeYE3h/rtTzZBrkbhIlyk5pnLj5wu136v2qsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(478600001)(7696005)(4326008)(70586007)(36860700001)(41300700001)(8676002)(40480700001)(70206006)(356005)(36756003)(82740400003)(81166007)(40460700003)(1076003)(2616005)(47076005)(426003)(82310400005)(316002)(86362001)(186003)(26005)(54906003)(110136005)(83380400001)(8936002)(336012)(44832011)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:30:55.2577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0dc3ef-66c3-45e2-f220-08dad878cbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generate rustdoc documentation with the rest of subsystem's documentation
in Documentation/output. Add a cross reference to the generated rustdoc in
Documentation/rust/index.rst if Sphinx target rustdoc is set.

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/rust/index.rst |  8 ++++++++
 rust/Makefile                | 15 +++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index 4ae8c66b94fa..4fc97c1eb1d1 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -6,6 +6,14 @@ Rust
 Documentation related to Rust within the kernel. To start using Rust
 in the kernel, please read the quick-start.rst guide.
 
+.. only:: rustdoc
+
+	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
+
+.. only:: not rustdoc
+
+	This documentation does not include rustdoc generated information.
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
-- 
2.34.1

