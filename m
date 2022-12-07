Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53139646046
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiLGRbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLGRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:31:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126C35F83;
        Wed,  7 Dec 2022 09:31:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsC/WRcbjV2WJzQxuctTD8fCn819hVyHbaNI351m8j08DmuhvwdZXpWkt5pKfJYrcuV5AkXmjn8iVCJUM0ploejbk79vxE9gSkPxn85/iRS8LRcYiSxE2R88v/jtdI+CpeozNysbeOJpk8fAUUqBliW22HUZvSv0fiT1QHx4L1RCF+EXl+g2ec4VXzxJMKFqH0d5Xk9jnMaw1EalD/3WLpnfJzgNmrQAKCCkL+TlNPmfqOWWTYXrS1c/DCW1UWNLUbZZEZN2TgHCipFtGNV57regEx87aIH37DeiTPSIrO+RJzKZig8NwubAYDcLgq+xngY1qb6/1t7NKeWDo1hfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3N527NZ1kQy3eKrJFn2M95pS/7egEFzSPa6utMlUTw=;
 b=BgDnSb7pR+OZZzqQ3VSbasvGjydHqiPTWFl05cDKaY3W2XwLJ0lHjkFsQ9pgk0uy0XtX0A1OYY1dqLHKdxAZw4vfQq69aYLVo5roRvbMxQvhKg1By3VDZVUQ54wB90Ac6Ek16mK1AOUMLnfM2iHoFumHd48BXJbhds73kBJ9UzpfbLQP2WVbZgw42+X6l7tsKbcGU53wcYv/E88uJackEFOikUoQi7fvG4UQTT4V4UczfSuiIUNhB6qEVehC/JY9/EHlrlNZWS8/kIMxJeJXpspPsLq2ukoSjHblD1hCvi2NAeQc0Aae7w7TFVjriU3eyzMt2Jm5usxhg2KCj6nNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3N527NZ1kQy3eKrJFn2M95pS/7egEFzSPa6utMlUTw=;
 b=VGA5I8/iYXYOeRvtwvmwjWMa+gzDIgxdSNr81R0HDKcnk9HQkE7s083T2jKVoT+5NAblQ1VSQ+h14oZHYxdHQXom8T4bXDuA7txFmW2qXl+nMbUdYAuhAOwMJHKpNYULnJwm9r3q8evJJf91+zOKfg0r6pofsKxwmsMqrNpi6zI=
Received: from BN8PR16CA0010.namprd16.prod.outlook.com (2603:10b6:408:4c::23)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:30:56 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::d3) by BN8PR16CA0010.outlook.office365.com
 (2603:10b6:408:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Wed, 7 Dec 2022 17:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 17:30:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 11:30:55 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 09:30:55 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Dec 2022 11:30:54 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ojeda@kernel.org>, <corbet@lwn.net>, <akiyks@gmail.com>,
        <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v4 2/2] docs: Integrate rustdoc generation into htmldocs
Date:   Wed, 7 Dec 2022 11:30:53 -0600
Message-ID: <20221207173053.1463800-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207173053.1463800-1-carlos.bilbao@amd.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: cae996c6-2b5b-472b-7c01-08dad878cc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpvEdOmOH0eyww9Is0/Hpvveg7RqsgP3sR83isfxuqIGUXJVRz2WzyXsCqTLad0LM13T10m60f45atu7xXPqqxl9e+ZxEy0ByL5sEXJRxD+ipt2hhuwN7bdUDbL/yggVD1QZr6HHkKGPgXhegmLeP6959yGqIKMTYw7pPfTq5zkZ1Hk8BSlDXWxMcGGAN6ofmWcnoBOQkvHiFKx278w7Tf2aSHSdWCdVhHz7MQzs3OgtUQq4735+1/cmq57xn3BqWNXkpFraVe+xu05SRGQ30WC7UNN6R0W73NsI7XNVOcs62Cxm2ddT5psR2Ey9xjf0VJK3keR3KZdZWsE3vyy3laAhVxoh+MaELVziWqqBkuMU1i0JzYf1KwLowLE+gEqLIv3GinGfOBGbxIAfvflhRgQCjKs/4Yf2TkevwqlQ7Uspbnb2HFejhaEC4c2QGa3HU7/YtGUfYGOtF0TLGZvPGLlOAq4fpxs3sbQs5OgOiaWyvCS5m3sK2Tuotwy1GXKOYJp7DQSdlgWec92I/q6YiHV5WRf37FmQI+l5g6GaAp++f0s1XKH+s/tnXWZUDmWtrYvx8gBFmi2qq4S3DnI7E+iWpuiZYsRsmyqLuptz/oZtVb6bcjxlYOQhB7jB7x5F63uIoWPKJWSAI5xXkRAcTCIwsQcMiARdKhX77DrlecNnnb+ZUZSJelkToM15WUfbQGZvFgEXnZROFa21Vd6h3oNbHoj9dgCn3FGaUT0JtW4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(47076005)(316002)(5660300002)(40460700003)(8936002)(336012)(426003)(86362001)(1076003)(36860700001)(2906002)(2616005)(110136005)(36756003)(7696005)(82310400005)(54906003)(44832011)(81166007)(356005)(8676002)(26005)(70586007)(186003)(70206006)(82740400003)(41300700001)(4326008)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:30:56.2034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae996c6-2b5b-472b-7c01-08dad878cc5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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
index 64d44c1ecad3..701ccb07e873 100644
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
 
 linkcheckdocs:
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
-- 
2.34.1

