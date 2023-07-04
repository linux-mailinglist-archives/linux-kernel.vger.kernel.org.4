Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE774720E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGDND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGDND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:03:26 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051C10CE;
        Tue,  4 Jul 2023 06:03:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6EbQR1Nt6C2E5SM0AUvk2HtvPFMsSip3SYUPjxc2z1bCA/qJG4sXlehFope27MpLmfCEVjCTIxf89QHfQyCTO2N8kYFrSevAN7aonwRD0lFCFXSB4hHnlIraKUDozn0r3KWfP6ewwfZmX9ClzaKMinWLL6ZvPLPgAPK0tDloGykIEovKX05NKILk5MgYRggxsQUPBKe/GEZU8R/E4YG3R1EbScLl3RKnnJgTVcqTphq06IqLZqQw0OXq6EpWKrUj8xb+G/N9WezCc8o9/s+RSCZGE1o0xz6YKeynHZPtboIonsbb+wTOgQt8Z0SuP/MIliC/rxj8jZCIZZUI08Zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZoaJ2ss0Ouf7T3wqe4Rjxy/uV5EQbGwn8UrA19tXs8=;
 b=LmdtPF50F31MXR97xUh/ZixNdW1G4Q+0iYwZ8gPTIeTNv5vZssyATlOod0JL2hdbjj6W3mxPm4qMRpsSOUOTofcqRFwQwgx1JsSA2GK6kdDOSNUXBnU4SdBA/IzJRgVygJIYIe02M8dQKTpTMyXLjY0lT5G+GpayAgdlta/byYBSGuvs5ZPtg0vd0RqXWAjXf4NzfWO7+NPwaKIUUqLsf8L8TLFTOYdPU9RxYdyC2UVulNTN0yOA0EVOZ5I6tnUlAsjv/bCVnFDSlETGtvXAC4Xd7b7cWOhvUebRCCv4MvaROXygrdLXHHHUz696CrQwwSxI0DyXrOBXPpnnth0+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZoaJ2ss0Ouf7T3wqe4Rjxy/uV5EQbGwn8UrA19tXs8=;
 b=Ji/vCb7dRoqbjOqZ2JFV4rQXrF6p8CiVosPJ6TLZxqIco9ULRpwiBbdyRPwBtKFoKj/0iJCT5HheE5LiF7VVUR+ySNpO+tGbhUsknh1rk22dfxppUvli8d44mnM3F0Colf5pdEW7ViXdDwkpZGgD7eGXfI6KgcBGtG52Qscl/1wcPekkYqV7QtX5j3rAn+OpY5hPlyCJuzOd1LtRugH6uFo3Vul+p8io2i1+kgdqm9Es2GFKvfii8l/MASLnOFI6RBvTAtAYLlkhqpvvQ9xuq3lWk5ICEXSxBg6IiD1tO6dgiypZtuy4sPYAamnQcYD+wmxku3RlgWevbcwgbRfa8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6198.apcprd06.prod.outlook.com (2603:1096:101:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:03:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:03:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] power: reset: at91-sama5d2_shdwc: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:03:04 +0800
Message-Id: <20230704130309.16444-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704130309.16444-1-frank.li@vivo.com>
References: <20230704130309.16444-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 12262d86-2072-4c24-8d7c-08db7c8f0ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utuwIoNLW17DGW2AwOK57mwTP02sTCgS1ZK9l4+vpQo3IAZTy89Cno2YHFw0aSJH2PzNyU73G9qV2UMBzTEXpc6dC36Fa/fMidn18BFJW9cYSv2SmJWu6KAZ4/YdLAuJUI48BSD8oYbuz/rEpIwR7/C8fekIw1wHy7pmOEewW2jrvBzV5bIrLx1rmN7HOyRlP6ZzvPqpQVYNQ/qIB557GPL8rWKxlzV1659aFHvSWzThDEBZwVJ85+/5dk0bItJT1Q5GBPYlWmbA59eQMNl8Mlw/RmYW/KUiE9rYjYWjqgdcw4rjHlZYorXfwM2KFfkI/A2PHVFdNwqe+UclH6+0EZXvrGfeEBTRAabbapalJSw7a6lPi65pjtvSCyGp+S7NhbAhNLftFVS7lMK6LvoBC34eWAO45KGUPbGsZvsF8o+uAaYcZOiPm7s+1KIAh9qo9aPoL6Xi/dAKw8yxupl2Olv4ZX19+xQrWwWhRFMz1TRiNjbpDLmwBxKrAeK3NoZeG5MBqTEfiOMZYVmBYm04geogQ6Qy0wBaJVo/Gc3CXPNx4p4N/H8eB4AdbCTwWdfTIE5cQ22O3NLhJy4qHkODYs6V84RM1xW/GHkqOXItmKjI9b6aFJst6t41bqKf/ktL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199021)(66556008)(66946007)(4326008)(36756003)(66476007)(478600001)(316002)(2906002)(8676002)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(38100700002)(6666004)(1076003)(6506007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwXYccp8+7i90zDblaGW3Bh+Vnxo3W3fU3tsgLztDXhlTuDkzpf+YXU10ahQ?=
 =?us-ascii?Q?lSqDw/6Ooe4Bkiv4LeFbbCduPKV+mY5egVDWO7PUBowin6C58s29/Gxag3qT?=
 =?us-ascii?Q?sfe4i9w/tYujDruhsz9nRuTL3W+r0G/AWF/CfMPRhfucuwtImLmWvGGbmqgb?=
 =?us-ascii?Q?tw00ljffzeWsFrgjDezrJAYxXGaZbrTf5u7U1A7eK2QoPuK6Cb+mJYnOu9b0?=
 =?us-ascii?Q?eos5MuwDTjiLVBiXJ48O+BKy+wwuth+0qZgC9Z0asPEwV8gM+eiOx9rLZ2zL?=
 =?us-ascii?Q?wf3QUS3cQ6uKbGvxBtERVzCyqMNNEL/qP63Lw+OFjr+dmjpsCWgk/doaM7jW?=
 =?us-ascii?Q?1oyhL9ju4r1CLJT6CYmgiaaZBgll8CrTe+5aFEWZHON8a04hq+Mc7VTYEgAF?=
 =?us-ascii?Q?1WZckz0k97uQAZwD3LhgQWlCRE/8oENuZu8H9j5I4/LQ8QOOVmxjO7TJZB0e?=
 =?us-ascii?Q?gkTrxFSswbKsBj/Dmz14+2mFRPaoU6R8bCQlURkkK0jqkJncTMdeZCFCnD2b?=
 =?us-ascii?Q?kMXxUCNmd78jPMG79fKI9caDJA1NXwiyiQC9BV5AqmF6qN7impcvVxv8JKYB?=
 =?us-ascii?Q?SzpryohDJq7kG3Uiuhy+eNJrc1l7MgAB05ccnjTNs2TRs6dI29DECSedtTSV?=
 =?us-ascii?Q?gu3itdouHsmRogeTQP1czbKnsvbO+uO4rGCK7jcy+3QSBuLQWYbBxPOmI7iC?=
 =?us-ascii?Q?ShiKuTNXTRJLUNad13vu0TmB7xnufwhGaEyRxnGGNX1DpGXQWUyzVFiPRbo8?=
 =?us-ascii?Q?bG8Ps0oeRT/BkdENCfjYiZbX8hmVTNqajz4Cbajc7y7Xwx97O4aXzinMSAod?=
 =?us-ascii?Q?WtoXPhN8y5ju37Ak70RqJtLHZcEYpvl6NVS3Yq/zvOHdGrKrBTDv7pKcqDsu?=
 =?us-ascii?Q?RJHU0bQvukXI+YZj0GaeYugTrq9HEWnVofK1Pq4G4bwZEylfkE7w3We1bt5c?=
 =?us-ascii?Q?F4yiCLvoL0YT28lUIgfwBY+DGeVsXW6z53v0HdTGZgakGqwT7AQTdqOEXGxm?=
 =?us-ascii?Q?5mmsj3TrMQOixvgDpjEBd4CpNwZnoEPlCDXFNBpiyzq/rBFhqbKU5vunZ8l9?=
 =?us-ascii?Q?BXx7mJMijczBasxTIewjeASrRzVqx8um7HnM1itnzo1OOTSoP91T5yGlasJy?=
 =?us-ascii?Q?aau+FM2oy3wyX2P7/81w+XjGZfj6vT489NSOgsRIHPOTY8zFi8nL5lVZsXea?=
 =?us-ascii?Q?XrlhRpn2llo57H5zv0cXzOn2IyvgRCyiNxzlOCgiwSdZS8w7upVBPFLJh2Q/?=
 =?us-ascii?Q?P0LW8XIIg9x+L8NCJhP40S91P4AdBDbNpz4Z6tWjyudaHf7nqfXMLGiwnj1O?=
 =?us-ascii?Q?jeNoPhQrlbCdO9OO88s3hgbkULVh87mD+rTfdgCiZL1pJeAZAkxeEahI2HbN?=
 =?us-ascii?Q?uwiUjcR8uVIVRKqXql5yUUFa+pSbsCwMTUfvbAoF7rnV6NZrFSZpUM4x0fpV?=
 =?us-ascii?Q?sWTo3eeHGrhKnJRd2REXOPqHOfThHhfm1SiMcxwUCFyk0QC5A2hk27szS4px?=
 =?us-ascii?Q?tHo0P5+6A59MAfqku9pj6IHvsuLieq7wHepqBDvRGsypeK4XO1MymFz2eNuL?=
 =?us-ascii?Q?BrqewFrqsIkx2iw+HmbvIG1f7B+CkmnQfVVOxkV7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12262d86-2072-4c24-8d7c-08db7c8f0ac6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:03:20.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7oqBqYkiUvD0T283Wlvh3098govvXz5NLvuUsjAyjPVIAbV0cP9NsJyjUyytkTMYWLjFgpGYZ/lNTX7ZGPCTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index d8ecffe72f16..e76b102b57b1 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -331,7 +331,6 @@ static const struct of_device_id at91_pmc_ids[] = {
 
 static int __init at91_shdwc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	const struct of_device_id *match;
 	struct device_node *np;
 	u32 ddr_type;
@@ -349,8 +348,7 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, at91_shdwc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc->shdwc_base = devm_ioremap_resource(&pdev->dev, res);
+	at91_shdwc->shdwc_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(at91_shdwc->shdwc_base))
 		return PTR_ERR(at91_shdwc->shdwc_base);
 
-- 
2.39.0

