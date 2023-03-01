Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305396A6CB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCANAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCANAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:07 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644AC36099
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:59:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa1hMuqLUj22TlJ+ovCZ0gPB6nWFvT/KHee0RKujEi64qVsHc0c8fKsVzVESxjiAogL7KKPQjmdGeHIWEmCrdTSkCn9iClIEU775+bVTErb1hMZ+dPfAWV6wMnq7xO8/gjnYbXAl7RkXxCz1xbw32027HNbCJBZ+s2mhvVNqiq/uqY5/mbIhAxv9isjYGLwtpW4+fJagcsRQgPePyXgJKFHMmq8Uu0Ig6mhxAPnlxoxp3C1gV9wsJBec4KPCTwHa0ldU1hutiAFZ0s/YDyAdKh5tmgIbz1V5PYR51ikIbp831P8T3RizNTnCS5DNq2LBYKUWBO5CQX7rxhUBgJZJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAfZ9fOF+dQKrKADq4sru6T9NzyLUFiW1M2qo68+gn4=;
 b=Vyjz+3abYZJ0gRxx1uwwqXi0Bdey3/aaC0H6V4NDvhBR6FmAFCwl8VJixTMDHJJLnpviUzKEYuDzH35+emdkO7laqtiEJr0J+Q4+4sLxkMhZBiAsJVoKHfZx/K3AUTjq7T5KHrzWi7SlEPsqNAVs3JwxqcUeA9Fb136NSm65AWOq84T9sxSY+9Td2uDEpbqCs1zpyw/qm7sROpb2xKCOFug218fqCRapjBvBBN3C3vZ2+gNrYx8roxmr70poPJeSkwbWH1nh2Odb9J1TyVpUST3nfTbXY1SV1z9ToXgWunN8MM+38Bj0s0HT5AFciAR7FIVxh979IfwrQdP5CD+X3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAfZ9fOF+dQKrKADq4sru6T9NzyLUFiW1M2qo68+gn4=;
 b=rFrHoIMpdfiPe3/ZAsMxs7NhR1gBvAmCWR/Ej/yb73mkEdCWjaUox3tdkwu4V37MP71MipLFy72g7+B1//2iP10Nuq3uYmixmzjXvu2jQMZsW/O24rNazfXgqYl6yOa0VNwV8vjXfH0Rn+1ppwmbKpMJh+yGP40vWB5TRT6axeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:59:28 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:59:28 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, m.felsch@pengutronix.de,
        jindong.yue@nxp.com
Subject: [PATCH v3 2/7] soc: imx: imx8mp-blk-ctrl: Fix typo of imx8m_blk_ctrl_of_match
Date:   Wed,  1 Mar 2023 21:05:52 +0800
Message-Id: <20230301130557.3949285-3-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301130557.3949285-1-jindong.yue@nxp.com>
References: <20230301130557.3949285-1-jindong.yue@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1bdeed-9360-4967-164d-08db1a54ca60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gi4xb9F3fUD5mo4NTQsxznQj4TvUe1Vcd7AQZl2u6/1FN+WQvKSVN3jwNuZ1Yd+wnN0D99XIcm+tbC8IO3lBC7pGJaXbkm6r0RlpSD8yrvt7fnLvyN7UhDxPnH5gt0J71VWTq9O2+yUtcDi6uJcpaixhv6f9fDaTlKe7sXq82ANuCxNFiKiWIlLNMl0z8HOhY/DQaE0AgreexRnf6dCrJoy3w7ZPn3bW4FrJ1ckLuEyzU9uQEyR0yv1Eo/cyqjUsvHsjKbMqiPtMlvtR4D2ieSJovLYo8YbXL9eUFPpK+wCHrvLVTPn88x28PDUUfujjlBxYx2047Xj+UYOpRTyOQvUgd68VlTxBJ5CbWZ2D4GNmYatDqvQLLvzyR6pdi9UMVA+pRS8r1mG2B1QtVyGPHKMIPzEie8CIstWOw3Ec2EbK0xA1wZSEUfBpS/6H8gjaz2pKfltoaC6xso85ZUyOKbnK6PXAp8MVbXkci/UAuBH2tT6mgnlCLALEW1Vrv6cHpibH7N5ZsJb6+UFW0xzivnKpyITptagm1lcFpdPm+Y3fPypAsSYbh2VYRCykimpV8ez/WREeHo6Zn4lVfiuiAlGQ2qSGWHNFzCzhLdeS0B5aGt3lvV03BoMlqbOSyfLxtn80yF8lVvEn/OmL34IFaHxqulycPkqiYSwq1DR11FzOgWROCZGDt96CtDcqRpeYlfRBr6Aln6OkwOTbG9htY6sOb6DJvEjlGOVbaYMxXCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(36756003)(44832011)(2906002)(5660300002)(83380400001)(6666004)(186003)(2616005)(26005)(4326008)(1076003)(38100700002)(38350700002)(66946007)(8676002)(66476007)(316002)(41300700001)(6486002)(6506007)(86362001)(478600001)(6512007)(66556008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGYzZ1V0R1lpNzVXNlZQRnFRTGRFaE1aOWttUDNOVWVQZDhuQVB6QXdCZjJQ?=
 =?utf-8?B?cnBSRTN0Vm41cFZxUUpZdkdtbDZQa01FTldVSmNYekoyblNHR2VyaUg0Rzlp?=
 =?utf-8?B?bzZtd2wyNzA2alZySXVnaGNzUWdvQTdVMmE1RUdxWFc4VWRlVFJFSktsdjBT?=
 =?utf-8?B?amtNQkZadk43VUxmUWV2di8rSndOd0RqMnpaWHJkcVJBMDZNUDhxSnBQTlMy?=
 =?utf-8?B?QUNlbmIvSXRjd2F5UE5IZm5QUXVKMkJSRWxvdndja3pwVW9WeTF6dVFscEJ5?=
 =?utf-8?B?Vng1My8wUjc0a2Vhb1hqTU1zWk5YeUxDSUkwRFdEaDhvVjVyWGNCeitaWUt5?=
 =?utf-8?B?Qmk1UmpFSmprU29YRFRXMGdYMXFHaWs1eTN6UithbjZwLzdEa2ZkVlpNL3kv?=
 =?utf-8?B?cnEySkVJYURxaS84SkFSYzM5OE94d1NXLytvUmxrQnlvTi9zTnd1NFRZdXJK?=
 =?utf-8?B?TjNNOHkwT01hY3VLQzdodHNDbDlFamVyNXduaGRVSDd0aW8reTVWTTlNa052?=
 =?utf-8?B?RE1kV1NjOG41aXZ5Y2o5T2xIR1NqRmVRbmJDS1Bab1gwME03T2tnOUlCanN1?=
 =?utf-8?B?Zm8zOHFURE9KSTd4OURCRCtnNWVaVndwVG5nb2p0emppWWFFUzBYalVZVjBC?=
 =?utf-8?B?L0JqOTBUR3Z5Y1ZDeWo2aEZWYVdGS2VPVWFScFB0Yy84YmlXZWlDdUVnS3JH?=
 =?utf-8?B?cktKbHBNVjY5dVNKU3BoMzAxbXJIVUtKWW9SYXBQVkY3anhJVG52M3l2OUhj?=
 =?utf-8?B?ZnlZUW05RDFEUWRJWDgvR3pGc0ZrNklZZ0VRYzlUU3JyQ083RHNCbm9yUHVl?=
 =?utf-8?B?Q3VNbWhTSlBxaGhkSHJzWkdEaHFSemc1OUZqTGhJVUorZVk4LzUyYlJvdjRy?=
 =?utf-8?B?ZllFak15MDR4dGltTVJodmlxNzYyQnJ2N0d4azB1LzBuWWVYWEVkaUdXM3Vt?=
 =?utf-8?B?MFVJeWNid2x2dmhTYlZSUWxHWFZIUi8zK0xQT28vRzU4bHBkNTBxbkplM09r?=
 =?utf-8?B?b3kvUi9mekVxSC9BdkYvNEkwRCtkOHJWbWg2NURIYndvaUZ2WlpIYnBDUEdT?=
 =?utf-8?B?MWQ4cVlzVTVsTExBMTNsNWV3WlkyWXlCV1IxUFIzU2xteG0xNVhNRG1YSWRq?=
 =?utf-8?B?Vi9NRGJmMHFRTTFCcHpvdW5qS09nbUYyQzVLWTBGRFJqeFN4Y0thbXJQQ0Yv?=
 =?utf-8?B?L1VDQlV2enp2SFY1K2ptMi9XeWlLalNCbDYwZExiR202THNOSkFSZG1rS0ZR?=
 =?utf-8?B?QkJuLzVTNTI4STZKbllQUmxIaWJMNEFnVm0yQUx4ZmVLZlBQQnd5N1p5R3lF?=
 =?utf-8?B?RUZWNSt2QjhoNXVlYWJRcE0rbVBrVmhHZk0xUUNBTWJCRkh5UlEvb1pUNGcv?=
 =?utf-8?B?dGpLUnY1ejFYSnpEdUZPdjdpeXFtUlBhcXJvVjg3c3BVdytXa2hvUmZNeGtT?=
 =?utf-8?B?UnBTeXBpWVZWNE9nWHBZbWEwdGRycDl5KzJISEt3VDd3UndwUUdUNnFNc09s?=
 =?utf-8?B?ejBqbXZDdnhZRXZkbUJzR3g3em55ZDdhUk5JVFoveURLRUdTK1N1S3ZKcGox?=
 =?utf-8?B?SmowL0pIUFBvYjUwcU0zUjI1UGYvM0t6cFZzNzZ6Z3NlZERJREJuUENwQ3Nr?=
 =?utf-8?B?VTZ5bEdERmEzQ1YzZ3VoaEd0R2ErSXRITG5HQXM3TXF3enJVMWR4R1c5N3ll?=
 =?utf-8?B?WXJhOHhVMWJhSWs3c2NmUDQ5ak9lbjdSOU5VZTV6SUtuQys3WHlDKzNERFU0?=
 =?utf-8?B?OWdtWHFuOHVNQytRdU51MmpGSzMrMXI5bXdCZWVTNjd6TCtHZVNFYm1sU3Zo?=
 =?utf-8?B?NG5UeGNuNmFUTEs4YXpuOHdTd2kvQVhNMWhwS0xtTDh4bjhLeVdNUGhtVlFC?=
 =?utf-8?B?b3MrWVJPVy9MTHloeml3ZEJHRjlWc3MvZXliZ0JwUEFkc1J3UUlzbVhKbEVq?=
 =?utf-8?B?YVk2Z0EvWVR3eGNZWDRXS3I0bzI5bVBHUzZWaXVRYlI2VndVeGlDdS9TUVZE?=
 =?utf-8?B?WEI4SEFBdDZRb0VZRnprZ0JOU0NEUnNzQm13anh4WmkzVzJEOHBYSEszRmFY?=
 =?utf-8?B?WGNqWWRmbUhJVm5wMzE0bDBDMER5ZGdCbDI4S09NN2J6UEtPZlNnT3lvdnNS?=
 =?utf-8?Q?uBzdStUTweay0NMvtnAF3oTvr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1bdeed-9360-4967-164d-08db1a54ca60
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:59:28.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UH3Hqd+KconYZ4qCqdHj0xwXyPYtNwo3hPC2o48qeE0Ngpn35os6WQ4pwN7grC/DKrwSjrMoiV/TM9HfNRDSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once set CONFIG_SOC_IMX8M as m, following error occurs:

drivers/soc/imx/imx8mp-blk-ctrl.c:747:25: error: ‘imx8m_blk_ctrl_of_match’
undeclared here (not in a function); did you mean ‘imx8mp_blk_ctrl_of_match’?
  747 | MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~

Fix the typo.

Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 1892c2c78831..f109c7bd6658 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -852,7 +852,7 @@ static const struct of_device_id imx8mp_blk_ctrl_of_match[] = {
 		/* Sentinel */
 	}
 };
-MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
+MODULE_DEVICE_TABLE(of, imx8mp_blk_ctrl_of_match);
 
 static struct platform_driver imx8mp_blk_ctrl_driver = {
 	.probe = imx8mp_blk_ctrl_probe,
-- 
2.36.0

