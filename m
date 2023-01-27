Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B0367EBBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjA0Q5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjA0Q5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:57:33 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC782D5D;
        Fri, 27 Jan 2023 08:57:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3VzMBHwXqUEM3fdzUIdRwWYn67SgVnauQTlL1G/kA+L5Yo226HzvsfSXLiCcxg99siY/C0EM0tdLu+n7TtCmvg6gnkAptl3Ur64jjIUY7mvOYxeMOHt2R19CaLgCrL2nCzLAcnPSyupt4RvB1nvwNLa4o43eq8pC9Buyq/RlzI5o8oPgqjW3bZ/GCZ4gP8nAJmc89aZpTJOKrrlf39Pc7+BEsm68t8SNKOzWmounCkjfQ4bYN61Rh50jKErsHzYMr33PaMIm8q9GvYHDoQW+b9CYUlIBVmSQnIsRe5/1nc8t1kwISK1yLsCCanwnMVTA8HUWBAHmJhvOPBRP6Grfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQcDmVzPKVLhte1QLeCCDRNnHJBDJ9UkicLQqJ997Do=;
 b=ctqB9sALHEKetf9j7Yo9qotogMpP/Bri/962p7eUgo6ks6G5l+TAFpX21W66wIP8ZDyjOpxu75eI/w93Y845RgT4eoSmFF4MMsCbBoGLmP89VMLgcod8uUJKBmysA6Aw5g34yoJy9nrjpSxhrd9g/bJlpNRN4AUIZB58sbfnoajQlWCUCC2RhtpL1qI2k/SGXGcAuXiixFvchKJsVQlRkbHNDHYHyZRFjmLZr95uBCN7jJRA7VCRnQZ3/9qlza4o/WCCkA1ilTwncHUbnRM6ObIQ4LXhycrcUowIX0NNsBdvPJI/n6i+FJooFCW3hy6e71UZorLcVSXZOjWLeHkiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQcDmVzPKVLhte1QLeCCDRNnHJBDJ9UkicLQqJ997Do=;
 b=hfaBR3QhzqfFTxcW6l5p8hkdtzEc+CkhwRkfo8OyiFX+2HAxzRhSyHkf84Ikghl3ZZMI8mPhdVrMbmx+eNTf/chPuzQDaL+qislVyDKYKb0s/c5PpIcwN5oX1cxPldzXIw4Z4Ii5wnP5CJp5SNEsZ8eJ2koHcklZHxx7W+3tLms=
Received: from CY5PR15CA0077.namprd15.prod.outlook.com (2603:10b6:930:18::33)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 16:57:31 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::3d) by CY5PR15CA0077.outlook.office365.com
 (2603:10b6:930:18::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 16:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.3 via Frontend Transport; Fri, 27 Jan 2023 16:57:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:57:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 08:57:30 -0800
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
Subject: [PATCH v6 2/2] docs: Integrate rustdoc generation into htmldocs
Date:   Fri, 27 Jan 2023 10:57:28 -0600
Message-ID: <20230127165728.119507-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165728.119507-1-carlos.bilbao@amd.com>
References: <20230127165728.119507-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2d3bf9-d67e-47c9-8457-08db0087944a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HD7uExyS9xNMDZTAbW9yUq3GdJ2kxhKOZfIkYLp0K9muSosoMAgej0tzrMBjchmSpg3EqP3Zv646uBSDm5RARWLGVOYgaC2trD/HMpya4sLdUIbYmkenDvBLrsTVWSOanr0paPGJeXmQDcrdqxf/UUYAnTFHq8y2gDQVH/bUnrDjI7VR4s5immXZT4zyVNVZOKXINK7Uv6LBS/19dKUk8+J5B+V3NMo6R/0k6dWKGFEXyWCUmYXE0opV7EeaiblqOsgVT2+QdT4tVDi6ZX1jXu2jddO6dYTb4JvepocnjCfLh2mDHHWsHB3KZLBJCiXMd+SPlcaO21XwmlcOQhFGHVcuOP52OCruEB1fnkt/qSM0Kn11PusCgahykhWDYKN+DJa083k4bfsTD4q+sevs2Jg262EGiG56ddeiO72A5UqS29O6ImuUkgdPtgXm/JSJId8HWo4V8654jV0BVznX4fFo5vkoMNpqb2lZiiwKNsEHEd4d8/CU5Lj3a3T8qwEdppjTYIe9V8P0lgVLJsnV0jyvZrmbcFRVegq/DJ9HaIhSWuTBieRe7Nz+YomHFP7HW2MM3Qu8PLu/Zf8j2viHmnQUaMqwNMBQcaDFUp2Dcx9dvuSO0QbrOe/O7wu0r4XrwL8Ryw5YpxM1xeKsxuSL+W+xL5PZaPMcmuKJL6STleyaa38juGXqUwwZ9IvQCo9REZEii07tMjOEy+NZugYow3Hp1gl7eskieDV1Y3twUJo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(82740400003)(5660300002)(44832011)(2906002)(36756003)(356005)(41300700001)(81166007)(70586007)(4326008)(70206006)(40480700001)(8676002)(8936002)(316002)(110136005)(54906003)(2616005)(40460700003)(36860700001)(426003)(336012)(478600001)(47076005)(26005)(1076003)(186003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:57:31.0459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2d3bf9-d67e-47c9-8457-08db0087944a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 Documentation/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index bb73dcb5ed05..4111d0dd54d0 100644
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
 
@@ -94,6 +98,12 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
+# If Rust support is available, add rustdoc generated contents.
+# If there are any, the errors from this make rustdoc will be displayed but
+# won't stop the execution of htmldocs
+ifeq ($(CONFIG_RUST),y)
+	$(Q)$(MAKE) rustdoc || true
+endif
 
 texinfodocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
-- 
2.34.1

