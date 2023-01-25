Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3292267ABC4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjAYIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjAYIbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:31:55 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF71632B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:31:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qgk/CzBwWEefrgyuiA2OBKWWFYBulgTmzCOVcJVy/oATfKr+OWX9SiG1lmQI037L/R/7P90e5DpTRucNmGMyP5yM5ztuoi7LbaSk0xLvijCRQt4Q6QtCtQGUbkYn6r/vD82DizhLo11PTnPK43A1z5R5097T7RrtrjdIqTgbQsGUUJrC0EIuxMAxh+GRhPD1RfvXqK7VPKxD22uHV9gIhETkt5B7p+mrO/3a5CpnxZOOnMK2ToaaxE9Xhhig+SBBos3ryj+S5+n9eiPY6AZkvjh7powkpb0bOX/qWRidBJwBSA9KXIaKxxpXa+2gCR6FSJLvvi8vZqQ6+vUhEj/nEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoxCTsVdZFHDRxqGyEYXLG9qHPT2PJVSDWgO1l1hkYE=;
 b=DqO0AsMREWvpQA7np873Mtipaq4IrRrK9K/0D5dxrZChhuP8L96iXPEgx14vMuUdFGlMsmOdtw00KdhmEUG03XyZfpqgzy9YDXqyU/Qy69+d0WgeIvwjK61BAufi94gntyC6HFLDz7dZNs0ai6AZAOqJIzAqTPdbdzvS3WxZbHmjhXzhof+nJLgUMLBet9pFtEwnmNwzGPjBZTG5ZeHQydwDMg8kdk8NTmF/DRHt00IqZ60C25RCPXO00WQkH6JN3nwKiSycoFDJpJhEC6S0CBJzTEuIfSLwIKKnVRnql0bxup/PQQjiuSbn2/7uvMvzfDjOaobEb2GShyUE6X8Nag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoxCTsVdZFHDRxqGyEYXLG9qHPT2PJVSDWgO1l1hkYE=;
 b=MPmLZjUNG2kuHG+nXr4j629KhEmXKpgFVyh2L/DN5TWvcdxGvYl4sCI2BtVfH7orzTFYxWKI0iMFf8Nf0svbiqvh/Kr2sTtmvGM46Hx9Sc8fz1sffCeuMLzZpyp2kjvjDHGGTwN64A2kKMcccuX1ad2QnVCBFTrWYyxOVGMgusI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB9301.eurprd04.prod.outlook.com (2603:10a6:102:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 08:31:33 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%7]) with mapi id 15.20.6002.028; Wed, 25 Jan 2023
 08:31:33 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, geert+renesas@glider.be,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp CSR compatible strings
Date:   Wed, 25 Jan 2023 16:32:48 +0800
Message-Id: <20230125083248.1305270-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: ec166100-4173-48ca-6ff9-08dafeae90d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erbkF/zyPRQh2fxVphJakKOXSNIb2u0VZtHZiIPC9XbTdoa4O6+WzoZxOHiLvQqkh+pM1xV0NTIE82zoThqMxC1C7x2o8JgIBrc5Fq0L420d/uKrKKC4Ka4vHV2AAK+9x6TMHtGHMdhoZp/FnXpN/PW95Y+zhCAfoQHKZwm0wauCrJ92l6s+xw75u0Vr6b5HUan9Cp647jrdMTUF31Zbn92I97ijQWiqkaYnYtSBHdXxyZ0qZ0tGYNIwPT0uksryZ0KcxTZSArG5xffdU3XrSus0iwJ2CN4qtbrYaRabnNFfXJMhCHe14te/tAiPX6cWFGnAx8OS5d9m3lzpdbSgL1DMVLwJ8rOHUozDhVuSXUbhUDUBc91FrVhPCjuXIPq6L5LptG5WnxrO3aBqCs1qxNL9Lb+J1mlzF/M9iFYHb9luDk4E22pqKLE4oRVG1+NKFNiFcOHuxMU20bXLUe2p98pyk33vF+3iiaLsv3KVsEUQ216QUkHg3TKtdTA+qVibcu1+YO2Lb5FzvnjLSlWOq1LVAMDplyjVo6Ypq2b0H6K0jOxdT6sZOnOg4kwVaWFAKXZ+baawVDLoFAw+M/9DHFNSd/eMk8In7bUD2Ab51L1f2Q8h3qPWKqSZso4XQMG8xgl5KNCmvzu2rQqDILtbP8RQltnIogt3HjR6NGJe8noBv3oWWig+1MkjMQUEnLU9ZogR6fxi35YKKi1v65K3stT1rlQie7hsW4IYicpyJy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199018)(38350700002)(38100700002)(83380400001)(54906003)(6916009)(66556008)(2616005)(478600001)(8676002)(186003)(66476007)(6486002)(36756003)(1076003)(66946007)(52116002)(966005)(2906002)(86362001)(41300700001)(26005)(5660300002)(316002)(6506007)(6666004)(6512007)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zn7ByK5GzjH6qYQVbxqmZg1TumVQ/nIqhGQpbSCuosaBiccYKA+7uSUkfBs?=
 =?us-ascii?Q?mraup0fgtclaGgOL4iLQHNVmgMv1SUbIC32LsDu81ecmhrlrsUKXsfjy08sM?=
 =?us-ascii?Q?HxmGVq7mU3OfhzCy1RYP1lICZHXAsM8MfZfQ0/vF4ekTZeu2GAQKujJ+/oMm?=
 =?us-ascii?Q?ETRU7UHTJfTua5e8a/ndww1h1PSfnG0fxXlXld3wX3RrqTvJvgtC6WI5v+u/?=
 =?us-ascii?Q?EBb2L45OdV5O7HxSDmB4WNSLTivM5YMB+GLYatVpeLnQjAizjvWDYt3XWERB?=
 =?us-ascii?Q?5t9rDhciAQrKSPp7DBZmsxJ+09brPT3qKfNPzKBBxumyQ8s2LGgI3jgGVxYd?=
 =?us-ascii?Q?G6Kwc0POqcEWyQeXUhrNNrEDQOKRIXLGITprXoJ3qIHC+JXobRRVgerumtdv?=
 =?us-ascii?Q?cJqJpeEP+gacj8Mx9lFQ6qsnFblXPenw8MhqP5jmwcshEcg0oFLyzRzgZKJA?=
 =?us-ascii?Q?4A8p3SHSprfJOg6CPedh8C2oKIdB1Y+ehASHzc3Pgny9Y2MWg16MxuJCqI48?=
 =?us-ascii?Q?90eMoKVsert/6TYUuHf6GwEFaOFZLBz/hpukrVy+fdfNMcEAnEJqQgeNeuIX?=
 =?us-ascii?Q?l/tT99/aq/fRuB3b7Ae6TDuTakvBu9sU3SErldt0MBP9ZGhNT+mTp+y3ZDkW?=
 =?us-ascii?Q?jcgG0V0IX79lq838TFA9EnP0MBebDizd3J1/QBF6DXTz0tL0Wh43+HteUBRS?=
 =?us-ascii?Q?XH19EE7FXjyExGjnNjFn7azPGhzfz8xDUk5XDRTWbtEoBnhz6Jdj2O1pRE9I?=
 =?us-ascii?Q?1v3PwlE+hyFS6E7Q128v/gWw1SOTTnoAgmzBNb4t6TmTy+KWmNtCNP09N9QM?=
 =?us-ascii?Q?eYxNjsmB2/5W1fzdNkz8mNimDTxIDqYbz5f/X+1IS8i3qRVblN1AdcHUjPzD?=
 =?us-ascii?Q?3H1dIw9F6uRtU0rEMKGAAezdQ0LZCni7l3uMHFVxDRHXc7gu+2bWr4StXwbU?=
 =?us-ascii?Q?291iv05NkEwM0jjdCVgaayyHoGd2B4Qwf/XVHdnkd9uviIBFXQ3cRIK80aHZ?=
 =?us-ascii?Q?Gy/Y+OTSmH8AmQMcNXMJUBjfzsyduhzcOv+S/nsOzMc98QditQ6QqbwnCwN3?=
 =?us-ascii?Q?DCYPH6+E0IoE4dv0c3L4WE5MEQLBdiQWMwWopbWxJBQ1AXh8pVNSLmaApxiH?=
 =?us-ascii?Q?1ShfsKv0Ti8JbJ8FVeiNldENdGmQWwbkUKwfPqCc4YXeNKysPtVWo370hDwq?=
 =?us-ascii?Q?tU2JGj3pNIS7omoJZtJz26rCqhUSH5Q3A3sNTZUpAxXo4x42cQFXokW3vOmW?=
 =?us-ascii?Q?4owAwbOcmRQP1OOYZEataYMCfhb7JpQRri5u88RzoS0OHiBJy9L0aurtsZS5?=
 =?us-ascii?Q?vXSsNh0SXTt5IUeko87iTQZPtMos0YtuIqCegxnQV7Z8Z+k8kS67B1QYhkC8?=
 =?us-ascii?Q?4anQJtPV4MhVviaFL8m7WOl5m41WWp11BK65kMuFd0CBhmQ1P35EwYwp62Uh?=
 =?us-ascii?Q?DlcLSgqgsArUwHjhNWRj26jxRut858IJAyLAFiQSrGLd9WEUEc4JWAmkFtVZ?=
 =?us-ascii?Q?kP/+bapiHjEJSfm6Qs31eLjA3L7cLEXTygc8N0zjH6fDIDprC6IGxvTQeMzD?=
 =?us-ascii?Q?FB+OAJzBtUuiqZqYR9WlguLextMB+FBTtpV+rcmO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec166100-4173-48ca-6ff9-08dafeae90d3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 08:31:33.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCscIDLc4skoe+epslrrfdy9lNewb4o95cuIOjP1bnCINeTQeF1rWSVJ8jQYdIFbdguTUfBKBAX881IWRZUuKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9301
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale i.MX8qm/qxp CSR module matches with what the simple power
managed bus driver does, considering it needs an IPG clock to be
enabled before accessing it's child devices, the child devices need
to be populated by the CSR module and the child devices' power
management operations need to be propagated to their parent devices.
Add the CSR module's compatible strings to simple_pm_bus_of_match[]
table to support the CSR module.

Suggested-by: Rob Herring <robh@kernel.org>
Suggested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
The CSR module's dt-binding documentation can be found at
Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.

Suggested by Rob and Lee in this thread:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221017075702.4182846-1-victor.liu@nxp.com/

 drivers/bus/simple-pm-bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 7afe1947e1c0..4a7575afe6c6 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -120,6 +120,8 @@ static const struct of_device_id simple_pm_bus_of_match[] = {
 	{ .compatible = "simple-mfd",	.data = ONLY_BUS },
 	{ .compatible = "isa",		.data = ONLY_BUS },
 	{ .compatible = "arm,amba-bus",	.data = ONLY_BUS },
+	{ .compatible = "fsl,imx8qm-lvds-csr", },
+	{ .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
-- 
2.37.1

