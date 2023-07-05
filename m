Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C074848A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGENAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGENAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:00:40 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2109.outbound.protection.outlook.com [40.107.15.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6BDA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1rTq+GfL9tIPQPxZaOVzDSOjFaMksxhlv0m1GvWne+4MAZDcDASSdd9WZJQJZYed+sJEg5yLc0gPdKLgv5G/KxyXMSr05AgxdEata06jkKZ5TxIamLaWy0DlW6bz14cuwIWivGTbon8gUZyEBy7llQWbVN9EHweAbMJ7ZfVUJAecPZ5asNxyHa3lraCZpuxXhjIYx5RReDjSWdCYqE25JOmJVHbJ3H+8pWWP8BBLLPjqJOtmBiuUXcEe/rpzcsk3AkIRxtws0+6a0mNCTaLzKcXLjXQTdJ4obIifm645JWBt6fY5hddayVSCqaLd+XhfBONi1/ELUX6caYGxEeo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjWHcXNonHylLQR+y/OMH8/07S8zwCoOsUy7Xv+6sTg=;
 b=RG4KjJxwkOQOHTHxoE8Z1/jG/ty5+XdbHFsSDOsxGC7tn4sZQBe8xj4UYxYSATi/DJhEWNJWC86018GFURX75IOXYPYyHK0FOJ3SseT+vvnPKVjVHDXZfp/qCeXH0iqH7+udQ+66r+svgGDezWn1B3MvCArXJwrZfmpkE8nPa5JJaa5KIwuPt00AaQ3f2qxc+A2KCQEakfsiQWfv+l2cHFYxcAcD60n+L2PZROm+AJrGnCaEImZ1ziQahRkLQaOQ68j0L1B7+HK/lMUSd9gg9rx3q7QBz8uIVDAWLnDZzD0wxr1fdjAo/zfacrmo1f8Oc8vk/Xm9nrSnOAOsWNFz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjWHcXNonHylLQR+y/OMH8/07S8zwCoOsUy7Xv+6sTg=;
 b=IoLN0taUFYltKI/B/7kMWzz0lfvfYoGIaCHnXqvXY54HvZdxZ/8qXtfeHlFr/CFBS79eB2aRQDKxBKaIRXFUtvCMCi8gGlIv+FezIegbMzz9i0zb3/5w4kUzDQTVx684d02MVEsu5JtZvxqGXSUqJWlm4hHr27x0ozVp6/i6tvg=
Received: from AS9PR04CA0179.eurprd04.prod.outlook.com (2603:10a6:20b:530::21)
 by DB9PR06MB8536.eurprd06.prod.outlook.com (2603:10a6:10:36b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:00:37 +0000
Received: from AM0EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:530:cafe::94) by AS9PR04CA0179.outlook.office365.com
 (2603:10a6:20b:530::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Wed, 5 Jul 2023 13:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM0EUR02FT056.mail.protection.outlook.com (10.13.55.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.18 via Frontend Transport; Wed, 5 Jul 2023 13:00:36 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Wed, 5 Jul 2023 15:00:36 +0200
From:   Mamta Shukla <mamta.shukla@leica-geosystems.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: [PATCH] mtd: micron-st: enable lock/unlock for mt25qu512a
Date:   Wed,  5 Jul 2023 15:00:10 +0200
Message-Id: <20230705130010.2999839-1-mamta.shukla@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2023 13:00:36.0750 (UTC) FILETIME=[B10FA2E0:01D9AF40]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0EUR02FT056:EE_|DB9PR06MB8536:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 086e56be-01e6-448f-eaf7-08db7d57d3a4
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nN+ztF99P5P/mlgZQS62MGsaueCLNU++876cSjLgNUziQFs74mniH1YJz1aobKcmk8bdIw+09wcytAbZaA+yYAECEZwzhie9/Q0r1knhxIO4mL1LBpqDFFMmO44Qq9M5xKmzbJ89+dZe2J6Wr5u4Wch0s8ZN8t1lnH7RYn9US+isJIOoULfETKLpriXtPRqSSzfIJR9rWAauZrDJb+FNryK5eJl7cQl6DGY4NmPcJsqyUOBjw8ZPzGmgynUl2GxIWNqIF/MmZZ2yVOKTBffgX8+KmXbzgJA0z1bKiORJZJFqafu3vwIqBnfTYNt4+LJrzxPpRP3K44KW/cr41kHYnMhdlb8ZlokJ3Hj+vruiqgyH5er/bL4kK7LhHTA3U4LyjzzqJV0WxBZT6X82vQiCV1J4Hl/+k5Ib29IlDOp3dXC6LV5x2fawDrFvnHU/xSG4ug1XRoh0rnEOK9eVRD7/cZU3WyQNtY6bO6YaCrF0NbCZILHSemZHM/xhDo4OwoFvoOOWRPpImNPSHap7p9ZU6/Y3L0ut1IdAlZ9N6Y8t2z0V5QXRmiE5lqxH9cLhCdzxOA+AiOPH7as0Zk/zwSYZfOHurHCJS2oHbtXGctQ4ct0DKgyyOqxADdcsEKdx31wnJ7xs7xxqsCzAkDPNReRtnvL1/68KoOc/7CeuwCM8rG9Zp/HntvNnpe5dfZw+KbVcB3feu8ULJdfoXksRRFjoTw/zB7Rq/obQ6Xl8ZYRVYojL+8YFnrGvllLghPpHrmQu
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(2906002)(5660300002)(40460700003)(44832011)(8676002)(8936002)(82310400005)(36756003)(40480700001)(86362001)(2616005)(6666004)(82740400003)(336012)(478600001)(186003)(1076003)(107886003)(26005)(966005)(70586007)(4326008)(70206006)(36860700001)(316002)(83380400001)(356005)(47076005)(81166007)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:00:36.9172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086e56be-01e6-448f-eaf7-08db7d57d3a4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM0EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8536
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt25qu512a[1] supports locking/unlocking through BP bits in SR.

Tested using mtd-utils- flash_lock/flash_unlock for MT25QU512ABB8E12.

[1] https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211

Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
---
 drivers/mtd/spi-nor/micron-st.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4b919756a205..5d1dc8e0bbba 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -218,6 +218,8 @@ static const struct flash_info st_nor_parts[] = {
 		MFR_FLAGS(USE_FSR)
 	},
 	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+		      SPI_NOR_BP3_SR_BIT6)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		MFR_FLAGS(USE_FSR)
-- 
2.25.1

