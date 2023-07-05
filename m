Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD874885F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjGEPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjGEPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:49:56 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2119.outbound.protection.outlook.com [40.107.241.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724C1985
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG5RjNlrJq66wnookrty/9HNZJjVN8j0jAZP7QKA5cAsM8yHpRkteP0nGiE5N9URhi9BWrd4AscGSjVAT5q1xQmWhoH6NhGOS0dERyf97uagHO9a8cenmY5JdQi448GmNnPLoeAplMXpSIwTufe6NpTZ83+YcNyJ/3EHCDr11v0a0UNXOL/nIZGK+GfQaeUSqInMPmi50+xcjqBe/octojr8hHzu+sC6KBU7OUGPRJb7KuuCDZFgwjlEPvTvqYEW79/1xevZV/Fphku9ma3ULCJr72P9B/aKP+RZmwW06uSQ6789vqr2XZmo9LxguGiW/z8fC8c/2Cr5oeqU6YKr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLSJlQQK40VNdYzvDUs5zvYM3zH81yG/vs/WLU+oWFA=;
 b=FXujvFtjetyy3UuMYSOXHqCkD8+TnlmoQbNXcC00oqynJN26Mb1r8vGnFZQIeYeg9RRTN2/oYAR9o/grgPmi3FCAyhJuiCL2otfHLsFhY+xeTivtGtZjkTUDzYzsge5B2q2+DdXHPDGNtJSfgjUDoP0m5K2Fy9RTfFFvvV5SwbWNsXU+3CSMWxKt98UJsqpeYq8R+C46Atr+QmT16I1mm6zHdOFl71Q1VxfJkLsiJPO6ctFuqZ7KzzvXZEEQI/U++aLunRiwW5ujbKNvXZGa9Hgdu5Jo/0YSW5umPAFS/FBAWXSQ6ncinqkWlOM34em4aGW8cSeWlS7f9IoufaLbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLSJlQQK40VNdYzvDUs5zvYM3zH81yG/vs/WLU+oWFA=;
 b=XszQhHltOO0ieFIWH0MO7rvzhxm7uKkkk0YKosVvHUjAFldQ3S17spSJfYzxPLNu10KaGMY9Q1hsbO0T6dnLVoT11SXIE6dFWY4cRMzLgSozCBvc7jxAwj+chFUlrm7H2KOYE3F4hK10bFiHVKkPpyxVYHH+iabzzP1+jGRkxZ4=
Received: from AS9PR06CA0497.eurprd06.prod.outlook.com (2603:10a6:20b:49b::22)
 by DB9PR06MB7948.eurprd06.prod.outlook.com (2603:10a6:10:291::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 15:49:51 +0000
Received: from AM0EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:49b:cafe::3c) by AS9PR06CA0497.outlook.office365.com
 (2603:10a6:20b:49b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 15:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM0EUR02FT033.mail.protection.outlook.com (10.13.54.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.23 via Frontend Transport; Wed, 5 Jul 2023 15:49:51 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Wed, 5 Jul 2023 17:49:50 +0200
From:   Mamta Shukla <mamta.shukla@leica-geosystems.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Date:   Wed,  5 Jul 2023 17:49:42 +0200
Message-Id: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2023 15:49:50.0817 (UTC) FILETIME=[555B4D10:01D9AF58]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0EUR02FT033:EE_|DB9PR06MB7948:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4c8758e-f612-4f2e-0660-08db7d6f77f4
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxvanrRXxWYi5x4xNy4E/wT0TPOc9QOukzrYxb3ZP5MAXkhaAQJ/ujlHnia4w64rI0YoCLBKGU0tXdswZXkRqXBu6mMN+pbSrfbnDo9eOUQXZ2A4kyGk4T2Sgo40F0cHeiX1Dfyg5CyHlALVIYSb6msnOgmg/3HqfP2AGjSW/DwpACVjDBMg5IlPmgHcnnXYOFtSqA8GAcgk2yDAz1OTvm+KdQmr9bv1HUJuTDTK35I1CokOOkr9BGbhYCezbJI4+5dXqtiwCWO63QXjbXk0u4zlW5PSW0cpxvw/CGU1N+XBjOQJePF0W+Btfwz0ArWnpbEwf/io6vbkx1MT29dvBYFkvTMfrYJyZUhFHq8QY45Zi2qxKyOX0IBJ2mIEQzIVc+E/RzHV8x5AMVP0m7RarYQSPipEhsJ1B3Wa34yPrGPlowm/TBzXtk0jWhA8omp1qAubexMPpPGXAA5K2x9busc64VxcJqD3ugI44QnokqJryBDLUB/R1/YxOIYXFTdSeIE8HBKCnZLRZcgQ9lAq3NcFWYGzt2r4yVerh4juK+nc3W5iewj364SWGexqrlmPyHPBc/gm0zxe7L7ixw1mSDCl7E08Z3EdbAdk2VEwD75teSZNiYMkE2hcs8W8tmZLimkFz3kba032BiEtSF0rVf4uHP7i434uHPUN2YOMNUEawCSUsxbyojB2Vt5ZfppI9+ptYFnm34F8mnQ/BSSDk05om2bXGmCZiTkaHCpg0mpD3fcVCLSvke/YUjID+63D
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(107886003)(70206006)(478600001)(36860700001)(86362001)(82310400005)(966005)(6666004)(81166007)(356005)(82740400003)(336012)(83380400001)(4326008)(36756003)(47076005)(316002)(2906002)(2616005)(40480700001)(26005)(5660300002)(186003)(70586007)(8936002)(8676002)(1076003)(44832011)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 15:49:51.0067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c8758e-f612-4f2e-0660-08db7d6f77f4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM0EUR02FT033.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7948
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

Link: https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211
Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
---
 Changes in v2:
 - add Link tag
 - fix chip part number mt25ql512a->mt25qu512a

 drivers/mtd/spi-nor/micron-st.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4b919756a205..08e94340ebaa 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -229,6 +229,8 @@ static const struct flash_info st_nor_parts[] = {
 		MFR_FLAGS(USE_FSR)
 	},
 	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+		      SPI_NOR_BP3_SR_BIT6)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		MFR_FLAGS(USE_FSR)
-- 
2.25.1

