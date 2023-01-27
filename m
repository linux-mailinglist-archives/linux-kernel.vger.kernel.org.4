Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7567EBBD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjA0Q5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjA0Q5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:57:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3D11F;
        Fri, 27 Jan 2023 08:57:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCVvWHJ4hPfG5ny/I+5cdXImcxMxXih8kz5nN1VBgS/CUAK1z4HAFOCiE6ooRfGZhR9Zye0giV/Uf1m5brSbZOQTivAHwYvAiWjJUymxvsApJt+4GPB+D1U8clV2z/T0WMrYKB579r0TKuEiyrrCRLPrycycCGX1s7V+Xjr/RUE4VTj5j4TLRhp0dLnmzRElkgPrReeWf4aqsriScnLWIJ5BW/nErRoUb1nmauqVHRb0/k90MPtvjATNvNWrNtdoTK0lgWRo/oEqW/cj2GgcE8RFeeyMh6wEaAKMlpU/bx4rk2pYbS6y5FdVhIfzRUAuxmMasqMGoTnEt9TjVWD9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEvYD05+DILWPF29H57c5xi+s7dBsP1BYajS+dY1OuA=;
 b=P7qZzOCoBzJaLypnuWYdXbmIxEiMdCqvVFVaddkuId0w3SaYlzND7oVJ13vYsPzoSfdBNoGS1Qyt8NOjx69aZPX3VYAoye3ZSQ1lqnhwgOTEWfoAubvkZuCc8B/5/vC1WHbFly5MCXdv2hUoYVvdmkjNrQ5vx9XP96QUtx76hBlkpBgHxIp8lGEWm1iigppU+OuPsehUoa0adoh7UNcgzhln4njllpR9/V7LJyPziX09jQ0o87zPuMlq2CoznD9X49AKOwxYvh+lJkDaAB1/C47nIeDNoI0/CqstHZwqCtQSeTCT4qWdtVgcTR9YwYqkeMOqVc5BQLwHs76DopgUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEvYD05+DILWPF29H57c5xi+s7dBsP1BYajS+dY1OuA=;
 b=OvmmTzkrK2y5Pg9nmH1ApQgdscJZ2Zj8SPY5P8kaWStwpZCWuntAiJ/PYrJGmIK0qytqJxPCXWgDlBn9NSCeWSKI/yVdNe/xAkvLs+/wPy5KNqXfF05A3HaD8whK4kd98Vr+OGqLDeUHPAicegHusgw4RZnLlDXZG0x7lQfrB64=
Received: from DM6PR08CA0053.namprd08.prod.outlook.com (2603:10b6:5:1e0::27)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 16:57:30 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c3) by DM6PR08CA0053.outlook.office365.com
 (2603:10b6:5:1e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
 Transport; Fri, 27 Jan 2023 16:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Fri, 27 Jan 2023 16:57:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:57:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 08:57:29 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 27 Jan 2023 10:57:29 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ojeda@kernel.org>, <corbet@lwn.net>,
        <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v6 1/2] docs: Move rustdoc output, cross-reference it
Date:   Fri, 27 Jan 2023 10:57:27 -0600
Message-ID: <20230127165728.119507-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165728.119507-1-carlos.bilbao@amd.com>
References: <20230127165728.119507-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bbe65f-0b59-44c4-e6fb-08db008793dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORQKbIp9Pcrp9TnPyJ6JW4TqSaaBBAuoLhUr1oaboKOqgR4TVhiH+aC5rN0KvGFHyke5LtbwJfhiEhx0+dI3V8/ShcEXt9sw1FaFa+plTsn64URf1y/a97gXYnYx0Xekyysy3dvUczdMGJdMYDn+16iImSQTqBp3S+i2c15/rj7T85NugBQcHByGR3/dF42JOldA9kh19QUUTqpxdv1/rcyU8WB+Ir9sT2yBFjT1xV4Km+q8911KBDpY+YVSdftE9QsNle9EWKnLg5T3KHSwrVSKyh+1LwoOaDaZJXPcO7p5h68W0rehGb5mTCLP2D4+f6BIkEamfCVQC77qp/FE6fIOy3r76M7p0jtZQ0D83kd9l4OMINf+gqMbQNViTAVprGrdEcdLEV63XaAWzkrtAc0FZxPo6CiNcLCBmLMVCI/gys+k3yFq6DaLZzdd8q+1qAIA3juLopC/98ygO+ffuSdS4pXLs0k+nEli8eA7nf5TzlEU6cu8ovX6BG5JMaVuH1uPU/ofAQyoTVgPIQUbOmF1fzOvvCw1tws7kn9jAX04tB/Ega8PM2iazOkVphsnBEmesf47hzqlAU2+t/4rDnfPLGToL2nVGKDkBFxoatI/aqCKh5d6SKJ7vXo3ETu9goxVDJba9XiMevEzK1+2Rtkud9xdkOulIwLZH2/LZabLNBGnL0UaaLiaTPeUe/+aCjgr5OL7U2bxQSmZ/6Xn+wSijzHJiCS9GBI6tslEKhc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(356005)(44832011)(2906002)(5660300002)(81166007)(8936002)(41300700001)(86362001)(478600001)(40460700003)(83380400001)(36756003)(110136005)(36860700001)(54906003)(82740400003)(316002)(47076005)(426003)(336012)(2616005)(7696005)(40480700001)(8676002)(4326008)(70586007)(70206006)(82310400005)(1076003)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:57:30.3432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bbe65f-0b59-44c4-e6fb-08db008793dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 4ae8c66b94fa..e599be2cec9b 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -6,6 +6,14 @@ Rust
 Documentation related to Rust within the kernel. To start using Rust
 in the kernel, please read the quick-start.rst guide.
 
+.. only:: rustdoc and html
+
+	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
+
+.. only:: not rustdoc and html
+
+	This documentation does not include rustdoc generated information.
+
 .. toctree::
     :maxdepth: 1
 
diff --git a/rust/Makefile b/rust/Makefile
index ff70c4c916f8..04f4ee3a193e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Where to place rustdoc generated documentation
+RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
+
 always-$(CONFIG_RUST) += target.json
 no-clean-files += target.json
 
@@ -64,7 +67,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
-		--output $(objtree)/$(obj)/doc \
+		--output $(RUSTDOC_OUTPUT) \
 		--crate-name $(subst rustdoc-,,$@) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
@@ -81,15 +84,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
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
@@ -150,7 +153,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
-		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
+		-L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
 		--crate-name $(subst rusttest-,,$@) $<
 
 # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
-- 
2.34.1

