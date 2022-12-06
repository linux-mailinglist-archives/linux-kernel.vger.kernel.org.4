Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9523F64480C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLFPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiLFPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:32:00 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768CF2980D;
        Tue,  6 Dec 2022 07:31:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gcqg4aYMzlqKxrXOqk7PcIx/FZaRSf2b2bPGh/mYzKekIgSfwq6LDVS0YXvUlKfPcdAArrsTm59w5xcbh+QUvyIKE02SSWma2W66u0kRnjVyyoSoKP2Cn11PZOlJ8Lfe2NVQoLRMGH8ckxgLNfmqRA8TMr0KOyPH5nOpDVPe4IbX8xeVGXrQbzu+mIFxLWN1s3iKQMImeVjnQd8Ef/YlGmItaL9Qro3k60c2ric6S0F6/sUSBgq7Iy4qK60MEE2N+9dseR6h0k9mmzx++1GCeJAu37RkIbCIIaW/sXN5XkfoY/QFffCyX18pM/lu7MtN3rpLnNs93OvjJO98jUif5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0ozFJe66DXmXYLYyIKEpSwRsVAAJajiNk3FfCc337s=;
 b=YLwWCCarhfZDlXrJZyDuMkRempymgGSS3j7cywFmTqnWqmolI8EG6NkOgjwLkTRteTP6UVV7dJmYNkLyp2CSN9gUoJ/FrGWeQS0UaewKyIalx9mw7gOJQ8D8wZrQv3Cu5Fxy5MIxw32WqIaqcfsxIyChvpFiYSX0MBIChv5o8SoII0TPHqPE7czEnr7sdB8VeyHL4XiRfJ0Jr1vCDzN6/HL3FdQ21MR1LjfKzcCmiefuRdHhQ5TmBZiNi/G4kVClMUMhpuEm/koXIWPJBScEPsrOJfnO1K5hzZ/nRql3pwEDodMGAwWgS9BqQuac/dmooCuFDlVwFtQ1i54XPJXfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0ozFJe66DXmXYLYyIKEpSwRsVAAJajiNk3FfCc337s=;
 b=YkFWG1Th1Xf2Q+GRbSxkpMne27N8MBRYuFh0k+0oblJXM54oBpUwTNEOIexATP1cyTUh5J+v9YDpfVIZ9VyVgzqmD9kzdblBdrDcJYgeMcsKEDyyykYn/g9fCAsi1f7bPg7EVolwt6pHVR1Z5cEPTnla29zapLN8UN+Q/FM3yek=
Received: from DM5PR07CA0076.namprd07.prod.outlook.com (2603:10b6:4:ad::41) by
 SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Tue, 6 Dec
 2022 15:31:54 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::ca) by DM5PR07CA0076.outlook.office365.com
 (2603:10b6:4:ad::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 15:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 15:31:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 09:31:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 09:31:53 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 6 Dec 2022 09:31:52 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <akiyks@gmail.com>, <ojeda@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v3 1/2] docs: Move rustdoc output, cross-reference it
Date:   Tue, 6 Dec 2022 09:31:50 -0600
Message-ID: <20221206153151.771038-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206153151.771038-1-carlos.bilbao@amd.com>
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d78836-500f-45a6-b45c-08dad79f00f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq1zBZZdNH5mWLt7UgCAI9BVIpKL7cwQInyFLAa4ocprq9PG2PhBrCmJC5PdDe3FNeg8r/c7Z48CfmsIsFwEo5MnAKObZwset10WFDLR3ffFg16yfIEF5nn73JJuIMesCd5XAOZc8XsBGCQF8A8d6sX6Z0Ix5n3Tx0vli6FHnJ8ETzWOQGMKylWEMAg+/Fwr4MbvNPSgZqmxaCdMClQB1+G3RMdXFcZ8acyrCivoc44evSCzJaoN1IBSlrEYGxpglOkkb3j5mbFoAoaPYUjYwgZU/x/BLGW7YzXuiOF59axIkOnXWEY2cXo9pAq9S9ODSgz1Jxx6AR16lKXx/cvOYzKI1/y0m6II4lNhAYnJywqZv9rIM2ZLwxvEAB54/Ld/ejWDyc7OFaq55NofvgigGCQg8ZzeD9Kl0aY9QiPU1zo1G0SPFFvJ42I4JM5JaThONle000IDr0LfVCo/KfCRWT2F0E/ewTAUfd8Rzx0mk5FMMqnrnql4nPges4DyWJmk+42YZDAOpqlG+T6+J2SrOtsVRjbOIgND/Zp5dPbw6z7W8ZjC+bQFwcOawy6eotr5Vg6FeVtV2PseVnmIksiZPYyuWr1i/XKofsx+jm94GGltV+wUvSlbnma5U8psUJ6cfjF3XsxZ6TIdiyHsnV39LVoeiW1DrCTLzEfA35wtswSTZjy7WyzYdCdjAtl6vfFSANtQs2Amz25OAe/HMcf9lytnlBkdBM+vIGFODTzrsVc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(70586007)(8936002)(110136005)(36860700001)(81166007)(356005)(82310400005)(316002)(54906003)(82740400003)(41300700001)(86362001)(4326008)(40460700003)(70206006)(8676002)(44832011)(2906002)(36756003)(5660300002)(478600001)(40480700001)(26005)(186003)(7696005)(426003)(47076005)(83380400001)(336012)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 15:31:54.1727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d78836-500f-45a6-b45c-08dad79f00f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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
Documentation/rust/index.rst.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/rust/index.rst |  5 +++++
 rust/Makefile                | 15 +++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index 4ae8c66b94fa..416d6b3de1e4 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -6,6 +6,11 @@ Rust
 Documentation related to Rust within the kernel. To start using Rust
 in the kernel, please read the quick-start.rst guide.
 
+.. only:: html
+
+	If this documentation includes rustdoc-generated HTML, the entry
+	point can be found `here <rustdoc/kernel/index.html>`_.
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

