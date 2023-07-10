Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902EF74C9FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGJCqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjGJCqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:46:14 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667CE6;
        Sun,  9 Jul 2023 19:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxKIX+dTw67zDHywkNPj6YbcqPVd53eukX5O7AOgclSqwAwrdXmQmmdPtsxdWJIyF/ecllKbXspl/sqsqLheBhP/yJ6hd0RcCZKPO6u0ynewtYcYIP8LeF7O3j1LPDDStAGaJ0eh+zuIGRDIoknVa2EgFuPZA5qClNSQoCtOf+81GdlD7TfE70MHJesZSITbQ6xYUNSbQE5V9qe/LrCIhLIDmDe6v9Pj8LFPYyqxa0QAQIUGcD8R/R29T8hYFYTY76Y54ilItphiydppcdJCtcIipJg5QjD1wg216/FeJf9qSFG233CPtTE6Cb0XejGyAormzetwqFDC9i6WlAGi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD8GThYyR4e7OPYeAyEKnBqEfkeohWv4pHC59+3Uy50=;
 b=MobLbt9UQ0ztCPCKD8Gg5HmCZU5hQBAY9L9UQKiwZ7VJppvlZ7axE6OM131WHAGNU7xXFWD4tE0ww2Aos5iIOk7bNNK9nPq96D8tVnK3+OtC+5kW8uIuk1mFbZaRXPK6XJuTp+97j0+9LxQlaWnwb4ZYtd9Xeug8wQGYdl4/8c1UmbaN+62oAPXuvI/BwU8ClyMalmdEhT2ZQn3yfTxoZbWCmTCfemXKnlp02mvVVaIJKR4Gqb4XvWaex27prZrWyfaBjBPWCaxaWkfNc4O8UeD5sTgjIGHZdEPSHj9C7nO1ybZui0pw1Wi1l0uWS2u0uY9Hof4iLl4BY4GtCUha3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD8GThYyR4e7OPYeAyEKnBqEfkeohWv4pHC59+3Uy50=;
 b=BHlLaRepmRegRj+4OFoCstZ6gim1X/0u+vEKoYfsxojeIND2Q8NLSj2Sh2kANQ/zA/PKP3YmfPnxsDa3dU8zUcDPyMs1L1H/5J99w7n49BSsBO9Iz/NuA91vcAQYqm/o71sQ3mA6x5oQaGjWAJRq7HQ3qGyhi8sPY58yu541X+Tz5/N+QP2k0rT8scErGi721os4Vzf9rDJig+Iy7eI2cEN8nbMLn1fhSLWcyh/ejbRxk2C+lwNlgwzwNHUN9MWl7rEkejEliT5Iq9KeVNgla2jran7nWpze1sIza7PXXAh0s+qsik09vNgbNWJJTbuaI0Y3gKcJ0pHpPuTWNl3HNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6357.apcprd06.prod.outlook.com (2603:1096:101:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/11] ata: ahci_xgene: Convert to devm_platform_ioremap_resource()
Date:   Mon, 10 Jul 2023 10:45:42 +0800
Message-Id: <20230710024550.59544-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710024550.59544-1-frank.li@vivo.com>
References: <20230710024550.59544-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d2cef8-5611-4aa5-6f6b-08db80efcf97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbSd2diZr4CD9XKh1vNTxAUCXKCRXmIDhns+nS5Npfs2QkoujAAYRbCwVyZE0moan0klb1D1f/XhI1mFqaAFy7cf8CG6CPuENNuijgCDdLp6mSHCIt9WpBT79+YLR6YKT8ZrbbYofTM0G5HFHJRDfrV7ielcLcie6VUOyhBJgr+YiZMrAaDlC/XljaGTQ219eDxoinHqIZDnp/Hrkv0oR8wpTrhW1R+9Yk+u8TUR5hBkqv13+oK8QUZmGFPFBSn8bg1t1bUuVrzov034UG/skIyOK1DPTP7XPZlW0Pwwef0pk/rm9RmdnpbRQBgDkOog8gM1dy23cOmPu5Gu6IS7QzAkPJ7gibjkhQVM8ZVfsGhRskpWIaT1hb+YvGkQjCFsRaf4R6q0SmIrPhYkifmThFy8rRT7xVCLrIuDK43yi1l9NmvKf+Ap199WGGGrr1IULfwSln9JjJognzxyMRe0sFiMmiphQLNu11SpGZq0i9gESL9FMGyrFtfJs9QSQsjnzYcy0fOilB8DXUjBPpgE7dLxHWRPqpVguuwvQvRS8l1Lv4khds5tpNi6X0m+mYZFMhY1mofrMBtfjapP8ZMkQ3PGs5lCb/KHfD3aIFMYQuKFgWTiQGOgGkwIPInQu43p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(41300700001)(4326008)(6916009)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dz9KpgwU8xeZrgQYMzvFrSDS6JeLKchq+m0CVQGeIFPV88fQmwdcWq9SjjCc?=
 =?us-ascii?Q?v3/VxBmiJUdm/ag6Z0dMRvUwvWrXjFbURxjKF9REtkHi6H9xQH+wYFzprik7?=
 =?us-ascii?Q?W86q880SCknSGJ/whLzZhZeaJdTsR+2GBrK6Ip36jBacBlbXH8lZ8rDI6xb6?=
 =?us-ascii?Q?ujKrx3o46uXNCq8+XeOPUSZmKjvzrVVoI7Fj7AlMcQkonWZhSmio88l8uR89?=
 =?us-ascii?Q?/hGXqA4SaYE/vNyx4wiP+sKtMpYSa44Nwyrirwm+SWWRcnYvZzUvXsXmPAja?=
 =?us-ascii?Q?VHdRfRu3sYWv6ph3FHBax2NO6twpUDM7A5TTxsZkSyw/FXGckglZacFYjtMe?=
 =?us-ascii?Q?jqOKcIlbsThosl9W3gifr6BVJVhJBCE2RuGrWCrQThX4ChAtiuUNCsjI87/A?=
 =?us-ascii?Q?vN1E0SsVYYm3CfLAYVRLa9CleKXXYIqrur8l0pnUNuvVZGlWIWIdU88+4hKL?=
 =?us-ascii?Q?ALiA5JGVwDIRFi8KiOOCr2k1oNl5Qz7FctcXRg5fjJxW0ZZTiILek1OTAjqP?=
 =?us-ascii?Q?ozrG2tFbMXPYJ96s/rs3UFtc1+k2ou1YaET4H9RG6SJfUCGuQeJj7+SzI14U?=
 =?us-ascii?Q?IbGDiSn0xTaP4e0YyF5uapUfByMCpL01FVhoy/iT9yEGqP6esD+aIW7h4oxx?=
 =?us-ascii?Q?cENP9DhYI4yhc9+4LjQKss4WGORGimCjK7plrib93cBttocGURB8p5qUWn2G?=
 =?us-ascii?Q?JH+plmHw1aoHMyQnB5uyv6oSj1w5isJOCtOTVo7k6c30mfRKib4OlvtEgg39?=
 =?us-ascii?Q?/at40UQ4XwqVAGs37XiDegrB+zkwQRfU4JB3Q4rj/uBqIy1CHY/1J2Kqzhhu?=
 =?us-ascii?Q?jMUhCjJbyraVS3JJgIgc36lumyvJ4PkXRyniXi9lh+7kxfmvUSomvjOgtiAL?=
 =?us-ascii?Q?2NZWiLTQ3RrOABtn0S02gCRYek1XdO7b+nd6phVjxTIbzhIo1Yw3q7wcI9gi?=
 =?us-ascii?Q?bgRKPWyjRcvp7+ym+NWoXeGwImkM+tTytR9aPixNJBXCTC5Lt6aCX07mN9v9?=
 =?us-ascii?Q?eEU03Q8eHq6ZIHaLNFIU5vcgRo5GYf/MJOezxPUj8q7y9g3GjchSWx1uvtg/?=
 =?us-ascii?Q?1B1Kpb6EbAaUuZeeZxlbXp6npOU362wmfdpLnOyCXmZO/o6uYgheupFV+EAT?=
 =?us-ascii?Q?xmmSVZh2kFMtaOeE/8VBW+XSXailxw5ggtIcV3Zxu89F+WY73dc+v+LBRkXB?=
 =?us-ascii?Q?bDUlsymdmpRR1P5ckCdPqopQGo4fEAatjyHBnjCNkoZC9Tk8I1Y+2JexmDb4?=
 =?us-ascii?Q?ZOmIlrKfIDkvxIGw/ReHilDlbtm9BpSu1nZCy49qKUEqY4WCd5asi8E5CK3f?=
 =?us-ascii?Q?80Clxks3NodBqT0uL8h/cgewSzZ6D/luVo9IJISIvpoXAtWOZaYVJDR5cIPd?=
 =?us-ascii?Q?7mIbxc6o/k7PIjrxxfowTSY9crqM+kcc9ZDxEgaz0iHQJpDCwfNoOwukEmRo?=
 =?us-ascii?Q?4CfLpGanQMfwGPyfWo0i/HFSrZoZxX6yA66y/KPQHbYUmpTZakOG2G/AMRrV?=
 =?us-ascii?Q?14p+yjibCm4gRrSA6hmFMtp4l2iF1b48pi4f9WJtoTgznuoYVGF0EK/Tjw2t?=
 =?us-ascii?Q?GgaFMDoN64Lu44mcz1nMe7tLVCcEM+1cQ3QWeU52?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d2cef8-5611-4aa5-6f6b-08db80efcf97
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:07.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGbkiuYsPFLd+y8ek89qJ9EQsZlWJcUD9kDFfPNAaWUHSsMlHKvYZSqA2ymiVixGKOH1gxNH3LC4dCIxcuTs/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/ahci_xgene.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index eb773f2e28fc..f5deaf648663 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -755,20 +755,17 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 
 	/* Retrieve the IP core resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ctx->csr_core = devm_ioremap_resource(dev, res);
+	ctx->csr_core = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ctx->csr_core))
 		return PTR_ERR(ctx->csr_core);
 
 	/* Retrieve the IP diagnostic resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	ctx->csr_diag = devm_ioremap_resource(dev, res);
+	ctx->csr_diag = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(ctx->csr_diag))
 		return PTR_ERR(ctx->csr_diag);
 
 	/* Retrieve the IP AXI resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	ctx->csr_axi = devm_ioremap_resource(dev, res);
+	ctx->csr_axi = devm_platform_ioremap_resource(pdev, 3);
 	if (IS_ERR(ctx->csr_axi))
 		return PTR_ERR(ctx->csr_axi);
 
-- 
2.39.0

