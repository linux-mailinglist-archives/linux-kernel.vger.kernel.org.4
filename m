Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FD644809
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiLFPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiLFPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:32:00 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0BE29345;
        Tue,  6 Dec 2022 07:31:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNYmJ9JSxXIxjy/E+tIKNrJ9QDOSxaLdhCXCU/plKTvyNsSDmOCXV+wgu3AXm7B/uVsvZ4n2faYA1i49mk6Ab2oxi7U9n2LYu9mbrOWyBXMa7/q+APytY1kEifa58IqpJBzYJ0mWtLSj72LjJzdjdSnnDXhw/k2atVqtqJc+oe3Zb+BIRDrldHEqyrFZ5ytjLWd9gHWwJoLI0tua5szUvcvHhZ8ADNnNXswNYe3zJh6mh5+ErvMK5AyPepiqLh6HYLdqTGBHhhmsCLErql21YTShk5Rnqrp/sbz80tFnxAxjGM6La1fG2UyW21IgeiIuiHn285XQBJgEmAeqYzphGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fct9EdusZ66zA8PQNfT8qAZxVnr3woAuHV4V4m27fI4=;
 b=KrRHN6M0HqFqqTveBBLTAAok/X9i79Mj2Ey1lXmWsJsW5vCmtrLPudVFTX/mefE4NlUu1vutk0em1JlKk7yOPLzryc14Wt8KdVcZ/zBw3+thfjbcFAdSWxlARG5dMpofza8DqEocB6tFYouHThRMqkzBDyTrOeY9npq+fjscuyrAL2TMsh0/f+bKlWwCaQmpIZWc8dzra4VDM3Vr/kuv1p8390GygUinDGEvGKLwhOhAaDPt6vS7sJNqDSrAqazs1i/ohxQlx142qoY+SjsIcy4ZdFjyvv39MCacKR2XusWJ5gIp06tEhLl5fn63ZGLn2vZ0KnRe4zGRx84dg88zaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fct9EdusZ66zA8PQNfT8qAZxVnr3woAuHV4V4m27fI4=;
 b=V8GV0nnVjNk9LcVhM52ANAQgVX+0XCa73XfprID4Oe9qztbXZlkZljXp39efDyTEaDdoePo7pDDn2Yi4DV3IQqXudo2OR/XFzRlGqqak7C3B4rR40yM3WNcFBT/9ItzGyMxrwu7n5w1d8GQCdy24Z9k7adn5L3E2wMRdF6p4cpw=
Received: from DM5PR07CA0069.namprd07.prod.outlook.com (2603:10b6:4:ad::34) by
 DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.13; Tue, 6 Dec 2022 15:31:55 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::5d) by DM5PR07CA0069.outlook.office365.com
 (2603:10b6:4:ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13 via Frontend
 Transport; Tue, 6 Dec 2022 15:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 15:31:55 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 09:31:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 07:31:53 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 6 Dec 2022 09:31:53 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <akiyks@gmail.com>, <ojeda@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v3 2/2] docs: Integrate rustdoc generation into htmldocs
Date:   Tue, 6 Dec 2022 09:31:51 -0600
Message-ID: <20221206153151.771038-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206153151.771038-1-carlos.bilbao@amd.com>
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: b364f1c8-009d-4b6e-2157-08dad79f0189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2dE0o95E6opZFR1j0tZ53DIW81jMHoTkzbJMVBryK+qhFtqIN3b35gOLkyGjevgYIAoCRPtBYAZaXUPZ4L+3osKBRcE96fNW6dPYXHWvyGABXy7wg9TbTmBxwQZzCWvgxhTmgQjvLHly1l/I3yqDuuh5F0i6r6JQYcII45g7r/pYYxwlayXtwlBAlOiXXzTknHwJfyVsokyzZtY54oWBJwCSv3n6uT2lkzqbyFxYewyUTPT+Hg5VVIKgsSpKpyccnXWhY4jhpoFlA36rACxoYBCIbYZ4QkHjv0W8mp4ADDT9lmpMxYknhQNXBX5WMDlLcTmx8upFacYidk4DmsfkAZpiYCAJPeaX20Owe22vFbTJJ/qhiyjzYUSkZa/qoGYQ+bXgkOLsJy0y8imdDdwKPYmv5Hd9rY/Cir8xg8mSdEU4haYBgO/nSrGXCmAopjlbFTw/mZxPOaJnUGfzS7pJON0/aAzPObeRryWjl2gnnFfUII6LAaOGYE8Gc7rKijveSTwaHRMpnZRDiCmpqgfOm2+38JE0Rr8C2VlyOsZ4ca3HZgyfscqFSclH5765JpHnGZN1QMyINvUAosstgwbcdF3icJpN+RpomiUOju9+IkQUN9M0z+h7K1D2/CJnvV4yX5O3TQMx7ot32Lfl1Ke+zs689DB/8yAZwgpP+uFVjzFLmdG2cUCyvoOsIBN95PNdbV0El5vurz7ABz8EFrQj94UEAJQZADRXpRG6IWi+Fw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(356005)(36860700001)(81166007)(54906003)(82310400005)(110136005)(82740400003)(41300700001)(8676002)(86362001)(70206006)(70586007)(4326008)(40460700003)(316002)(44832011)(4744005)(36756003)(2906002)(478600001)(5660300002)(40480700001)(186003)(26005)(7696005)(47076005)(426003)(336012)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 15:31:55.1257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b364f1c8-009d-4b6e-2157-08dad79f0189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change target `make htmldocs` to combine RST Sphinx and the
generation of Rust documentation, when support is available.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

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
 
-- 
2.34.1

