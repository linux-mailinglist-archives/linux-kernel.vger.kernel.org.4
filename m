Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4446A65D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCACzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCACy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:54:56 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03124C85
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbaUAQ8/KVKeFCtfiZjj648qArTICLlAF6Y8N8GaNqnEcyiuVp/LC5vEkgctWZoXLQqjDtFBUP+iv+kSvU2QNeWq2KEkrYD/2wuPjJN5Zc0QigkOWi+SDDDHyxsftXFukmyHGmubQ0yomW6+W/LUdoLzClQvj4R8WTsBteYs5iLGeDmfgNhRdwk8bAn5ghSLVkmPfQ6tZNlcpp4uUJTUgyn0cPdROUe9VWrHC9IkqAau0CGTBNpXVsNKzqDWN0NP/saKh5etM8bLAyXFV5f0wmwmomF/khmqElyrd6oDysmRDmuSsOiwnrVDZPOGDOL9u9KMZEnjLSl73vIQmMxpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8aOS0n1QdvTyTzGa5bwZDYtpFbYVqtMJyMva3oZC5M=;
 b=R+Iq/xn2VrLB7Ja+1kaDScpW22weDNYVLIXChFYIkFYuPmsCnLo2gK9svKpCiU23MzIslmHmK9nYK9n9MbN34AlAI6BVXBAmouM3rNBw0+kVcCJrbiGtOXozYNlO+0KOXmsiFI4dUK4osb/DmKlwj31H73Xe0R7Eo4g9CxmMrdFF538lVxTzceO51pbHQ3p2Ko3TWIHPpKvV5ET5+IqR45IQJkjV1q34+aNn06ATjGK2RqTA3eAOn9ZwcgyhHydh5cX44R/2qgVCwUk3kNMumif/lzZlRGvN8YAIia8sVn+E75OoOIA1h/W2niMrNB5lQ3BwN/02lCnqQ5V5XQ515Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8aOS0n1QdvTyTzGa5bwZDYtpFbYVqtMJyMva3oZC5M=;
 b=SdtSMfjpAtOCKTTLcJfAxSCkpWYITMAxjM5ZOPfbE3eBCKUswGveRZ7kFRjKC1HEv0Zbdsb9134j+r6xA0YtLLwwgTP1B2eAJF8k3qjtDcT/iRMsiyqT2eJ/goDVfAQOAoiiaL5sh8O+zHgmhWzYsfVFBtvaazwKPeHhrxLGzIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:54:30 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:54:29 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH v2 5/7] soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
Date:   Wed,  1 Mar 2023 11:00:40 +0800
Message-Id: <20230301030042.2357706-6-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301030042.2357706-1-jindong.yue@nxp.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a4d5e2-22f6-4101-30c3-08db1a0046a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHr0/wH8dBYuCwde870GxSmPWUlrE3WBxj8VrfOcYo8LQ8qG0kGcXO7Ygxzo/8bXxtSUcCHOtNvs+SFJrUDQ806BBKjM42T9MEyOWsdtry1pXgglnKm8Pw+sE+E8qy4oVeB0/ox3Ht1+js5i9UP+eACuTrbCylbyYr5blD+bY3B129NzT+lFbvdssXyiM4jPO6vt8cJ21ikxTBiX9htQ+rYqtbyjvCXQLa92UsnrL9JZIVTgrbThgOQjskhxguhPPBp7aV0zgG0LQ7H3XLoJB3a/LoWvIObBdSNJ6D1pdPMElb8rSdkyRwEo8UOvJ2wK9Lr2JE+F6Yr3J3xos3ewgTfhN1CiaDAARUWa+XyICHbmma+pVUMvswkT/Bv4g/IKvYDgzqiJdMDIxVQSIKFmFpSNVQ0pu1zOxOT0mCaZNCcnVG8Zo/MHGHWXrGghOJrpMpeH47Yb6feRB/Pp79nku+cC6iil4UZOby30xLu7E9mVezlaX0Dum77aQpWPktpgbNhHRVVrKEZWcnSehvZNY0rWY/25KxK+WmE3kRFgUgdnf99J/bJybkM1oLNTcdh1c0dAbI3/6vHcD7Xb033qMuxE3tpVfz+LrrOalbQ8tCBmZezI/1uyvi3JU5FlUSr4MNha/YZAJxEkq4eUwZd2+dY93aZn6xFj+TpG8rGzOAGkQdjV5EspFqlWHBftWp7aAS5k68Bz8vg+PwTF3a0yFKzeqv/bSXe23Bd+NmW3SaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(36756003)(478600001)(316002)(4326008)(38350700002)(8676002)(38100700002)(66476007)(6506007)(1076003)(6512007)(2616005)(186003)(26005)(52116002)(6666004)(6486002)(5660300002)(66946007)(66556008)(44832011)(4744005)(8936002)(86362001)(2906002)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rCLaDdWA9uVGe0py77wU5x94koOqox/0Z7GwNl1Imf3RFQ0xJcdDGJikPbZn?=
 =?us-ascii?Q?AEh8vImvJzW5uOJoiQNTrjva6xWxC+1WDfdzg2p/6t8F3p+SGLXojD4eWs2J?=
 =?us-ascii?Q?NYZJiHlMF+ju69fVEj4NhfD2gVUQneGkAjawVcA5fKuGnD0/nt5A2/F2dW8V?=
 =?us-ascii?Q?e6UeL6TzR1vUoVkCxZVymtgbpUUuokJRpOuyscJpGm4NpejrwCfLD2vq+vAt?=
 =?us-ascii?Q?0p5WCo6bEVenpztNm2gxrhz0EwuMPY7JYE/WHlhfmSRlKNuJusXbre6fsUGA?=
 =?us-ascii?Q?PjQaxNgip9ffQEZqC1+SnZKZNN28GqPYrwHprore0AjkzK6fk2lvzG93151s?=
 =?us-ascii?Q?c8kEgKlYs3BgPGwE0XdV2Bx0hUyJPCQybKvOSj9oqVm6qRnQWtgqO3S6pq5M?=
 =?us-ascii?Q?fYz+9Fs/7FGBYN72LPI52wlZIHijOKn2D4b2IyC17PFYH+Xj0C+L0EeZgbmF?=
 =?us-ascii?Q?HNNeWGUQdx5RyQX85mH1BpPBnjmhLBVpTfWZqX03Crne5KyxarAu/smy8xH4?=
 =?us-ascii?Q?ah3fpOuqhrGC8WHKL0IDZORJPzvK1OPbYYOwvi/Z6TfZgmdbnnCu0NTMiXXY?=
 =?us-ascii?Q?/Q1ioCgg6qNAxJMtVIWCaJ9ag5GLVPx6ch6+qqD+AZ2cKkrnCGv6RV5KV92Z?=
 =?us-ascii?Q?Y0i8ueZBtjMRvJhL2MwlkyOn12UUEas7iLTWoUj78S6bd3LmXS46ZZitJKHl?=
 =?us-ascii?Q?ufH/OUbDGma/Oo7COZh3Iqbt0RXwjJTatXiuWhXeklcJXrgCbrlTWyubPFQB?=
 =?us-ascii?Q?4dem8c1d+KOHEZnqEn47RVzGJN0KsgESAZlVrCNA8jm39Bs9wSSWPtD9fgSi?=
 =?us-ascii?Q?DEINZgVUT+hSfFS2Gw4NnYv/HArevGggscmMahDTIHp4cxL4bRYWDKwKA50Q?=
 =?us-ascii?Q?JBEUC2F/LwyshkDburr3siXvKRzkMojD8oRJylzI1QHEELoKkp8JYtQjgN/s?=
 =?us-ascii?Q?aqvVkAS9gnbz4f8/aZfOrxFdWEnJRQ5V2SnMZTRQIZ8Umpk5Qd/R4oyyZdKx?=
 =?us-ascii?Q?FHbxTpRdDob0iDDQ7wpzMQd/inqZJ2nRVLY+7clvaHKSyzUh4quzXm/S4Wo9?=
 =?us-ascii?Q?N5O53yPT5zIwAUWNbKj+5R6D5T8DOZuzplITJc2H9qaF/fThZg5QN+WDICE1?=
 =?us-ascii?Q?PAwtlQLFn2bKwD1x4YSqZ35D3d7a+wKZxC5WGj2eQz5Vq1XcYl/OC2kyhWjB?=
 =?us-ascii?Q?NP2h7x07DcarHO8u6RZF+uNRn4J5LrJOzrtqDE8tGzhPHQaY4FOo+oJ7x2UH?=
 =?us-ascii?Q?ggyYUJj8HtaIsygPbT9ULMx2/swfTb/DHPhAihZyiXKsmsWwSA2ru8OMOAof?=
 =?us-ascii?Q?dww045hB2LO0ADRK49mfdxWuXBx0RiYWGENdsQdFFL4QQFMXwLis49wPcReE?=
 =?us-ascii?Q?yG0MaIKkyhbCmDu6z5u6yt4Ra1n1l7hNkPx22MyqbI9cbJKc2ehZ3riguCIv?=
 =?us-ascii?Q?g3OzvpRJZZIiJjU/vFzOrtW7l+kP9xrui6+WkgMMQED5r/yM6ZEKxYLMdIUJ?=
 =?us-ascii?Q?xIU1jNHGZ6wTNw8Dm4sngD+oGhiPdOVl5U5mcMy/2EwQkNLpFIiZAlQfMrTF?=
 =?us-ascii?Q?LkCEq87g1eqHwFYWF9/xIZb73YsFINA8AcFNKSJU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a4d5e2-22f6-4101-30c3-08db1a0046a9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:54:29.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJMRW5uLdPB4pz66DymAZuJVfddWtsSAKXWPEgVrfoOUHvbPcpTr0w5ws2121x4Cov0loMuo4Z2zoqobMo7LDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as a module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index af67f2c3f7a1..a955513d6d68 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -891,3 +891,4 @@ static struct platform_driver imx8m_blk_ctrl_driver = {
 	},
 };
 module_platform_driver(imx8m_blk_ctrl_driver);
+MODULE_LICENSE("GPL");
-- 
2.36.0

