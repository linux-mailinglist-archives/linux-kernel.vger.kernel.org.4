Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5435F73E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJGFV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGFVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:21:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325CB115C1B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 22:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnbUFFdKqIVfXkamwe3IZNxt41Iqz1wopzHLAfJFNe2FgbpVMv+xVVt8Z4F2vOIry6qTZzqNLzf3ieemUK7U9tMCFaiWF22WuUhtPr3jrXbdZphFXi2PdMUkFxjBLVA1OdZPnaiJkn95wSJK7V+yAbwu3he+CHyA+Og82IqU13Wd5w6bo7rQDYS8pAcc0njOd1WpWXcpWOKUql4+mVuTR0nOAiQC0CP+nXK1yV3JdxGnkMcglaFoYBNzMzCxoG3+mXhZ1sc/bXN+06GqAvAevk56VQZscO7bXBaCjVkgU3U7e3FdYOjH5o5+rdvdSjK248keX/vjoq0r8vF2Sn/cLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDSABVANcvQU8Z1+8dkqGsyl6Sw+lcenc1+fwuUqXsQ=;
 b=mm39cGfeD+y8NVQniT4FZWlm+R0puDnb5Hw7snaMOWbWWXmFNL80MVSwIG8Jhgzfhver4TuQ3SWFWsdkAM8FRNx4RdBcEkhNlqesp/OfSfs9BCJkJ2AbZGxN6JYOk7Kdu15KN2QpQFjGQiFWqyRGB3CWhWhNaNn8gSYH8t2+Wcd93PIQEozx6iWtiwPZ4RzzJ5vVW5/wWpw33XrKNz8D6vP3n+gYz7e9qztf5vO7vVmLMEsBI7dY8UJCpL2SlqhQqAKxDFwgoCa4egS5tk1SL3/bKTuZsLG3AKn4+SWUTSz1zeQxx+JbSUwARw7Mxq7qzCIUQ4TTkjBuZc/FUIjcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=walle.cc smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDSABVANcvQU8Z1+8dkqGsyl6Sw+lcenc1+fwuUqXsQ=;
 b=oJHWW+fAaaec8LiSqnLPD5v0lJRTUrhGqYxsqduSvMCzNWsnIHyR9n9aDGWrY+lhrSY9KNWGrNKmtPGtZSf72DMPUClb+jwB2TJSIvgaFKZ5jk0y3Rwm4Lb4DFiqQCW2Xk4raPGIkOTBCBjXE7oBQWcJifAVDjYcQuxnXIKRF2LnG1/6/7i9chWKP3Kf+zlIYJOeHOQLZYqlo8Fr3e39zou7Y4ZLQeDXLSGoVsNvb2fiVCYpgP/lko+TJpcQgIyixGJQJM7vFe1CjFEwpWRHzkcreEkFfotlMKv4cq2SbdxUVOEDV469Q/xrWE1y0VOyhBrscYSX0In1WImSRFGFNA==
Received: from PS2PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::20) by SEYPR04MB6773.apcprd04.prod.outlook.com
 (2603:1096:101:da::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 05:21:48 +0000
Received: from PSAAPC01FT024.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:57:cafe::79) by PS2PR01CA0056.outlook.office365.com
 (2603:1096:300:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38 via Frontend
 Transport; Fri, 7 Oct 2022 05:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 PSAAPC01FT024.mail.protection.outlook.com (10.13.38.118) with Microsoft SMTP
 Server id 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 05:21:47
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     michael@walle.cc
Cc:     patrick@stwcx.xyz, garnermic@fb.com,
        Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: winbond: add support for w25q01jv-im
Date:   Fri,  7 Oct 2022 13:21:08 +0800
Message-Id: <20221007052108.3339266-1-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT024:EE_|SEYPR04MB6773:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fbf5c7b5-9d12-4e87-d913-08daa823d50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHtE3Z4L0x8lsgPBvexC7IhpPVWvV6VUNn9ErcUTPOmwTEsOPItMYWkj2IwFHpMcx2Ga//2w+no/jDJc7nt0/YMUkoRr8ot7c2bz/ta2KhtFz5RZkq9M3yp9fkLs+GQ/WRLjjfC1HN8ln88AHSgUDtBH053i/MHln2pp5vzsZLc4Ws/dbTWg4TzZH61cxwOTrj9rBLWx+fyMokVsUUSXDQjPVaHZwCXeRzrzHteqJxwX0SDCKwwTzhCrJDx1Hdb0USV9AFWB3ORmzN6lxybf0FJJAozwt/xlhl7N9O59uStZtrDDcIKc30QvVfz5Mks+U60P/Z2IGJhUaYfftx/alWhRZ3Oigy5GaTtuVK0ZQY1p+9JduQ7EcrBkeHJvVrFAl7apKQmtTZJ+ifqKhMWvb9z3pckxA6e5JCLeNC0gqMTsv3WrpzNL72R7k+i07SYg9cOMvzKMhJf/0yEMTeJ/1yNMfJGBR54VV2Cu0GfU0gFlJ6ErFZVev+Oq7cwHcLkZP4ZgKw/ry9pIziK2eq9m4QygkyrplA7+8hO2nZKWu5GbcEGyQEPLkH0wqYoZFde7YymHDUkwgdpI3e97Afe5Ys8u3wluLr70BU4avKXBdXgPgn4eYYD7uGdx3B/x1BRr713vt554pke85I7nFIeZbKEfOy/tUnWe92WCpUQnLcba8sqOX2upeH1cqdLJQWonW5MRSfiGTJGjceooSy+ZB8w9NIzHobZNbLU3J7rM1vM=
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(36840700001)(1076003)(336012)(956004)(2616005)(186003)(6506007)(6512007)(6666004)(26005)(4326008)(6486002)(36906005)(36736006)(478600001)(47076005)(6916009)(8676002)(316002)(70206006)(54906003)(70586007)(41300700001)(8936002)(7416002)(36756003)(356005)(2906002)(82740400003)(5660300002)(4744005)(36860700001)(81166007)(86362001)(9316004)(82310400005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 05:21:47.1535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf5c7b5-9d12-4e87-d913-08daa823d50f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT024.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond w25q01jv-im chip.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index ffaa24055259..850f2fd867aa 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -139,6 +139,8 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "w25q01jvm", INFO(0xef7021, 0, 64 * 1024, 2048)
+		PARSE_SFDP },
 };
 
 /**
-- 
2.25.1

