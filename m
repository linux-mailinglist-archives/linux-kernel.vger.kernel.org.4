Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EEF658560
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiL1Rqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiL1Rq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:46:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773582E2;
        Wed, 28 Dec 2022 09:46:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mk/zOFpb3PXIgGX6itWrjGb0NhmyMywIqw2HPO60wWjTzlcCgdnjxl+ENGit+bg5Fj3Bas2o0ixI8Pq7lgqtfXgBGHRuXwjV6qL8KeX9eRu7vcY+8PL2r/EoHgV0JFraJHnQlPNhvfGjQoPJpKzvXPJetye/yAhN0FTtw7CgkWXfxRNhH4f2f9DTkhgzwCR06S/LzFqHNWdjTClIlFtmN6hvoFlN0d6CU5k27UGfpWa8SaYaWaoM7FbsoVIhpqlqbBviLZTeX6Sp7T+/AaUE5Q8wjrAeQsOy3coHoHm7s3lbp649Vq2K2YWxTFLksl+XR8k3WvttUBYqxQtBTy+XFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPwOy6ooehZme7InP69/UxrtEx1T/sJGGgNzW+ToYfE=;
 b=kLIPHudO4XB2/TbfbEgYbWrFASGBGGj/jX8EnqBxFi2YQymfRw0zzNrurSkOgCbCEBOL0+1ulfAimbNusupI3SDbI30/qUsu2CL+OhXC5mUHTZSc42byVnzqvz+Fh+VSvulQO3d59K7CED4nM0yfOv5teEkjaNEMmhoKA0ppPU5novyQ5aDCJhxtM8ubU37Ebgwb3hLhViKuNtxEmE0QJFU2+iFHe3d1Z7payJug3c+Pw8wzQLUACk7LA07IXMceb2c6Lk9nDumYB8Rgl0iLbimvn7kO8TrIT9mYD6Gk547POVe6DJJpmvVPTU49n3CEPDa4IQLbW3gvBZdVfeYxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPwOy6ooehZme7InP69/UxrtEx1T/sJGGgNzW+ToYfE=;
 b=pYgeh+jOkjXLn32M0zfyv4+FIXa2+qhc+hMTNzTrl15AHDWqeMbbaR0bkgzHWCGSwEDVpKjWW1RTEviRZmu+LIjgd4CHK+a1oAPeOWyaZP0Ls/mWa1MJy3LyqCMSNaCLKoBAkgfcJSWd4pXOcXLI1IgoztsK12dJuw3iijQ4y5A=
Received: from CY5PR19CA0132.namprd19.prod.outlook.com (2603:10b6:930:64::29)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 17:46:26 +0000
Received: from CY4PEPF0000C96D.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::92) by CY5PR19CA0132.outlook.office365.com
 (2603:10b6:930:64::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.17 via Frontend
 Transport; Wed, 28 Dec 2022 17:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96D.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Wed, 28 Dec 2022 17:46:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 28 Dec
 2022 11:46:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 28 Dec
 2022 11:46:25 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 28 Dec 2022 11:46:25 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ojeda@kernel.org>, <corbet@lwn.net>, <akiyks@gmail.com>,
        <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v5 2/2] docs: Integrate rustdoc generation into htmldocs
Date:   Wed, 28 Dec 2022 11:46:23 -0600
Message-ID: <20221228174623.144199-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228174623.144199-1-carlos.bilbao@amd.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96D:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7bddb4-e0ea-4554-8407-08dae8fb718d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbcbJLdJFb9BkDPDXZzT279VMpqo3YYzCCOl9sHDt7AMXbG7qKJJKLK8nvSnw4NZxeH1tsdFA4u2mxV1G5ACe61mt2xRac5nFqsakzj/Uaq4QSV/zs9eEFsNbrtY946frHHj31f6KJbOlusFdg6brPvAXzERYDDxbqs9a5TX1o2+UNaGxbsA84uYzKv+v3l6YQQTxrQehLH5IIqR0BKPdu8WitUt0ebV6KjSgYdG3+dEdUoqaUX6IDO9ZtzmcYRoIO9vwFgwsoMENg0gikwsxg3epRxreAuHLc8lx9KraHVGmJRzum7Uyo41ZpU5f2VQvHWYr9+OZavXdXEgMFoUqm7CslyDyF30eWM595kVY5Wa653igXWuzHTEDJ3uJZqfwup+F/Ae7AqHIG16n+DR2uCx4T4oi/A2WPdypQEG4quNAJR3Ox/soG8Ue+p0W0VqSFvwTGd1kB/npID8NFlG7N5l6QN9z/sV9qWe0saWqjcyGctCL17hAEG4lHNA5NZhl5LL5r1epeL3mVMm2Vzhh5H4+o6o/nML+n2w6fhXIjPlr4sENiqdcTSUz1sRKvPilG4mQWlc9CZj4QBtti+d482LSxs2jusFsIGMlEPZ9ObPuw024WRnjuVVRFIvw0b4FQGi2ZOvX3EYUxNoJ5w9m0e4lqe8HFnM3Vhc4DQpYgbgoyB5S3SL7vjyGQfGEopLCaeyD0kqtERYkGdqWWJ3bzhPfdcdXnZrGmaWIeg/Nmk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(426003)(47076005)(86362001)(82740400003)(81166007)(336012)(356005)(2906002)(5660300002)(44832011)(41300700001)(8936002)(40460700003)(40480700001)(82310400005)(478600001)(26005)(2616005)(1076003)(186003)(316002)(4326008)(8676002)(70206006)(7696005)(54906003)(110136005)(70586007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 17:46:26.4787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7bddb4-e0ea-4554-8407-08dae8fb718d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change target `make htmldocs` to combine RST Sphinx and the generation of
Rust documentation, when support is available.

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index bb73dcb5ed05..edc5540ab12a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -59,6 +59,10 @@ PAPEROPT_letter = -D latex_paper_size=letter
 KERNELDOC       = $(srctree)/scripts/kernel-doc
 KERNELDOC_CONF  = -D kerneldoc_srctree=$(srctree) -D kerneldoc_bin=$(KERNELDOC)
 ALLSPHINXOPTS   =  $(KERNELDOC_CONF) $(PAPEROPT_$(PAPER)) $(SPHINXOPTS)
+ifeq ($(CONFIG_RUST),y)
+# Let Sphinx know we will include rustdoc
+ALLSPHINXOPTS   +=  -t rustdoc
+endif
 # the i18n builder cannot share the environment and doctrees with the others
 I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
 
@@ -94,6 +98,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
+# If Rust support is available, add rustdoc generated contents
+ifeq ($(CONFIG_RUST),y)
+	$(Q)$(MAKE) rustdoc
+endif
 
 texinfodocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
-- 
2.34.1

