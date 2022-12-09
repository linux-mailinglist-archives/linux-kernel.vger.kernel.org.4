Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D758E648261
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLIMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiLIMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:32:06 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2072.outbound.protection.outlook.com [40.107.103.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E3862EBF;
        Fri,  9 Dec 2022 04:32:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUEJAQZRult6eslWWuoZk6NwLoL1yE/CCkq8s2OfIPO8I8Dd+Tkg2wpiemPysEHZDR7dzgaFpnhgvz2hyUpPIBYwQ0T+aLAYmHiRINzNuWJ9ODn8wli6luG70Z1XF43GA+/jX+ri9AVZ9FEiEkzU5t2gLhA1JOljg5mNMlYrAkeJ0RbADOkXZ0VUC4w5uN1XTSh0XS9t1aqdpOrZ5CRZEIxqTmA4wKQtnP/W/1i2uG2dYh6NZdbpp3XCToaq/f1ZlMEEFK57OTR/HaMR40VKnJpqwXfxbtAKnyJVDtw9LNAJvfZq6ODnJSRC7VP91bagSqimv/LBRr3qBV60yDwy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7jaFHi0m/L+U7D7vTpKFCe0BHGggnUYstSiKm6UX8E=;
 b=NWoVnVSsJQeW73vXMZu9vuAKZCL/0jr1QJs2QtHt7JpFQqRxo6lcD9jqKpb58+r+D3d0KbyY6E8T7Lvqq9NqrkTIOp/zCO17DQ/fHj/ha6HJWWBwbflMCT9w3IKOxCJGlNvZxSMLgF4nhHl7nszO4mO5tH8wK4ACD1L4guVCaEctoRIr+eLLjg/Mf2UUCKEtGsPPusUN5FvS0dMhT6DQLH2jBMwOMv8lO5sGwiEWcs/t8vy8l0vLvT6cQW7QEgvxBmQs7Yfn4T3FcEAl/TjNVHG5xkNckCKgHUWMRJRh/Q1mMiMWj7V6eCX0UqXEQ48I+O5TbGnV79v0rWSAqEwsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7jaFHi0m/L+U7D7vTpKFCe0BHGggnUYstSiKm6UX8E=;
 b=l2ymjfCfSOpkJF/88S6JqAzHfmzS+bECM28bYd/XSnp+k9xx6OFZRC6Tt0YAifAgCzl044Rxf2sYLrIwC6YoY2yAKOCDk7+p8sbN8+3iFAAVV8cJo4b1wx08IsxUoBz4I219D47eQlKG0IeSgxSmo/OLzM4Ib2eUo4uEb6/sUy+yGT7ZxU1CjPxklH4+vbvc6QxbZXnKLHNV3sES62BTS72tRV4B1JZJMFsNiauOvWhSTBL+kTCR7tpjhd6FOIf7eLCWaxlJldwQ81qvXS3qORtya4E++5KMfbieb3Ie01JZSLiF8N6WFJxbnhom3mdnESD+jcx5BDYhnDoynWiZ3Q==
Received: from AM8P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::35)
 by PAVPR10MB7402.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 12:32:03 +0000
Received: from VE1EUR01FT101.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:218:cafe::e6) by AM8P189CA0030.outlook.office365.com
 (2603:10a6:20b:218::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 12:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT101.mail.protection.outlook.com (10.152.3.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Fri, 9 Dec 2022 12:32:02 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 13:32:02 +0100
Received: from bennie-lenovo.fritz.box (144.145.220.67) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 13:32:01 +0100
From:   "B. Niedermayr" <benedikt.niedermayr@siemens.com>
To:     <linux-next@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        "open list:OMAP GENERAL PURPOSE MEMORY CONTROLLER SUPPORT" 
        <linux-omap@vger.kernel.org>,
        "open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>
Subject: [PATCH] memory: omap-gpmc: fix wait pin validation
Date:   Fri, 9 Dec 2022 13:31:47 +0100
Message-ID: <20221209123147.591982-1-benedikt.niedermayr@siemens.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [144.145.220.67]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT101:EE_|PAVPR10MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: fc180bc7-9037-4280-4bab-08dad9e16011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dcvK6uV7ZFnPcKuHfEiZPS+LUi1NPTqV1+sp2sLcLj+DxD/6Iehws5+2T7oD2NpEhtIpBXpEgo+LSiM7AAMbGoQrRs/MpBdNiFQW0aVB6eBDPlWUzOV0nFfoK0zpKV8lMW1lVKgb7x6AmSEymM/ZHL7XoK2LNVk6sUtWUBBz1wH6OVwcRCaPGz1GESWdSj/OajeGkSUSEPDj2bdPutc1uzZH3e0R9lrYhHwLU1lnIYdQoT8XaS0XZGwOIHwKEp0AaGcDCSSn7biQZRpBzmaRr/u7zzU+Gfd+f9lB1R+8G6ae/zjgA/qNxMEJyqNt9bum7PjXvvlYrFCNK+CbEq0dAAmfPNoQPtK+pxp5IjTSJ1RCI8A7ODVmkPRy1LS4MoJHU8RiZPyW0FBpKtVi7qstlwLB+KBEMEXaVV+xjDb9gqEmhB7yULzbx/sJuUBcX921XzuMF/jzBLwXqr0d52QfcQdFYUJQVBG3BrFEA/TVKrg8o66C8eWgE2hqrmbr4V3XYMXMARdLq7nzxZOcNMG7RTJyep0aKi6tU9G1KjTaaP69svycAYWlC41c0T+YH1D9tNYBWE53KpRQMDzRBNSvOHn92kYVD04hF3d6lpSW7mvooe6QGRR8cAtF+NE/4h2v/zk8z50hx6IvmGXe3OIxQAThjdTYEmwmeUezZltfmbkrDhSUiFRenh6jGKDjwjh2V+SkHltqkV6mFQN70EQbBYPLmXU1oKXZeQxOUFAPNM=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(186003)(86362001)(16526019)(956004)(1076003)(336012)(83380400001)(356005)(81166007)(47076005)(82740400003)(82960400001)(36860700001)(2906002)(5660300002)(40480700001)(82310400005)(8936002)(40460700003)(478600001)(70586007)(4326008)(26005)(70206006)(6666004)(8676002)(41300700001)(110136005)(54906003)(316002)(36756003)(7049001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 12:32:02.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc180bc7-9037-4280-4bab-08dad9e16011
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7402
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>

This bug has been introduced after switching from -1 to UINT_MAX
for GPMC_WAITPIN_INVALID.

The bug leads to an error when the optional gpmc,wait-pin
dt-property is not used:

...
gpmc_cs_program_settings: invalid wait-pin (-1)
...

Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Fixes: 8dd7e4af5853 ("memory: omap-gpmc: fix coverity issue "Control flow issues"")
Cc: Rob Herring <robh+dt@kernel.org>
---
 drivers/memory/omap-gpmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 57d9f91fe89b..d78f73db37c8 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1918,7 +1918,8 @@ int gpmc_cs_program_settings(int cs, struct gpmc_settings *p)
 		}
 	}
 
-	if (p->wait_pin > gpmc_nr_waitpins) {
+	if (p->wait_pin != GPMC_WAITPIN_INVALID &&
+	    p->wait_pin > gpmc_nr_waitpins) {
 		pr_err("%s: invalid wait-pin (%d)\n", __func__, p->wait_pin);
 		return -EINVAL;
 	}
-- 
2.25.1

