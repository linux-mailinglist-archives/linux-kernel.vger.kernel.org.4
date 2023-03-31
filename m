Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB126D1834
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCaHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCaHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:11:44 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32918C676;
        Fri, 31 Mar 2023 00:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPjQy9OghCa10EQEJlDbPGJLQKd897ppepUy/ekUZrIuoxm0pDVBecZLuaUCmi/gtXk9X4MgibykmmEKnLmd+wwEwKAIZuAIB2pbHtgKbMjg7QOn1fGaQJe3vGk9/9OYdZTzS/tosFAZbflfp/itOesyip0ALAT7TVJrBosg3d/4WkRot66YkAL0VZ9VhlSPh9fn3HI+z3eO5IZPLYjShecjQem+bYAtRKTkv60QIUlq/E9Yb3S/Tf5vAu08bGIZ64BKzGo+1mrZBYNXXNAPUap1rg6ngkfgZ8Sz3ove7FKYZ1jkHRstCuqTPoVWT4yAVaDNZox6BGzvP72HzZJf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnaUKe2DK51guMZ/UlUnpms01DM9P7ZJ2qMrOqYiPgA=;
 b=HcZjxUiWZ4cLpTCrb3FvJpLe55/WKRZH2wLa+bfT/qNUvLaV28VZMtp8i7L0GlIBWqAl+boOfLqfELD0WT0bg3SdsoFQVicFrzTzxF9Kw89R4cN69epLkC9CP6oyYNCYgPp28dBMnOt+Hbf1tTn0DUaizwpowLygN53lb7sWeCO7AfoJ1OvPxOjpl5M8SuBh8sqhIdmpq9sr+u/J22qBJt7igB2+/OF5IzPTe2v55sSqToZCrhfmEjYHTOVjLUJpuUCBCu+3NW2ZS4YLASEZyLeRiCPsNPjGE5L3C/P0H0rSz7uX7qrvz4bRnz/lcTZlxh+vv8dV2LBl6r5WF+2KZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnaUKe2DK51guMZ/UlUnpms01DM9P7ZJ2qMrOqYiPgA=;
 b=g5jLivDvlejG1eJxGDDpurKL8fRJ6CqBb+1YJDhXWbZq+Jm49HQbnoMu2yo9d7J7rlzmajw4DNAt0uGZhLee2C+SBfL3F3/eCWn3wsETS0MbEEQtTAVnqTqyyFpdtSkpSAvx9pY81iU27zUEL0sDA3z5lZSTLh7ROt6d2he74NA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8632.eurprd04.prod.outlook.com (2603:10a6:10:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 07:11:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 07:11:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: composite-7ulp: Add some delay before deassert the reset
Date:   Fri, 31 Mar 2023 15:16:42 +0800
Message-Id: <20230331071642.2483199-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8632:EE_
X-MS-Office365-Filtering-Correlation-Id: 8875b8c9-c8a2-4547-8e2e-08db31b72bd4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebarMx4l+Vdz+R82kYWQFiz/AGV1+416hsbSuiHEqQ1Npdskqwsu+9PntCV28wbGrMAcyZavMkvUZvlpElSSfQYBtzTx9GsbOJaEEySFf5mYsE98pbCmlKPdZRw9ymILr0pRXT7uDO7KNSTUv2VWSeADq5JGZGXqBBd4uBaraWNBlwYqcq+BD0uZBdq89jMSzEaqY3KnF3iGBdqk+moC1PDBv1gyLvB0/aNcF0+6RMpW0NyGrDEEU0DoFIirrqXSnTkV7F2+z7VhYv34BTv8f342ACzfyQ/dUKd6R3F07P+wFPXK+OYiBThf1QfArQLPwPl3RtBo88OpB3BBAATPc3qU9y2//EljRZHFsgVpqKjT9sUqdVN0jFI7uYOoCZwlqyy41V6LlCONENOTrQN0diFQaYZp7kMuaYz2JZqZAvMz8Y3KbwEXBMLBMXgjcFrsuyq35PGMHrWRmYqQWs/Pn9qi8A4f3oNgtlszCMlCP3VMCEP0ZTaivpCtGFeAWkeSN8yDX6odLabQW1GvXG223cZJPXe6bFkG2j75hxD3IfFM40dwJ8B9/U+LvjbIP9nlHCjBb5kg4vWhK9RpkShyZpEuooVx/J90paQ0mag5cQj8xZVrxeIgotk2omZx31d1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(4326008)(54906003)(316002)(8676002)(66946007)(66556008)(66476007)(6486002)(52116002)(478600001)(8936002)(41300700001)(5660300002)(7416002)(2906002)(86362001)(38100700002)(38350700002)(186003)(2616005)(6512007)(6506007)(1076003)(26005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZVJJl+TajjiEYTX+nop9wmwCqvr0ULSIc0Whgm7flzBn6AkUMhFp8LU+8lzv?=
 =?us-ascii?Q?CIDby+xfXv9HcySVnVONTCUNQx9bVarl6Sg8QXz9yaey7B66tfYfhiaXnYgE?=
 =?us-ascii?Q?6qJ3OdlFATkHgxOuD2L8849+FKsuhlcIB4jHoiil8NLFry0A1uqkcSLp3LSz?=
 =?us-ascii?Q?bljkdFQW59/CCce7H3XNDmdQi8QZLkh7HCs9aE/M6gKJpr9NqL2sFZR1eqbS?=
 =?us-ascii?Q?nUt/57j0HdVubEcxoJfNgez4ukaTLl5n1yboU9EXQmBENIL60XMAxSRXCQRx?=
 =?us-ascii?Q?gFbBIdAfbweR9hUtqZdyB2trEM8J8sAhZvDGG2wQ/E+C6Ro9nJDsjFKplXYn?=
 =?us-ascii?Q?+Id+h0qqZFcVraTXKpu21pRc2kcdmnoZswXntPBjJqo68ZAeiG5Ery6hfHY8?=
 =?us-ascii?Q?w583rjlveDf5OrpwFBrvPoL1Goyx7y0RLC7gDD91qZNXg8epOjyfwkNqnRaS?=
 =?us-ascii?Q?QF/MvpCCwL3hIc1KqNNv+v+wzZHsKu5qgyDW39GHlEnoXgoXavlACeg0eO3l?=
 =?us-ascii?Q?ST0SrmQ8Xte18EdtdO5tJ96UODFo2ebvoFwOAmMS9HIZmnOjVq6fq/06oVnp?=
 =?us-ascii?Q?pzDesuQcQAAXtlbYnH065B0qdV3/jsm0wRoEYirHp0JoELL1HfTqjJixF7Uf?=
 =?us-ascii?Q?RrH3Lc7JYeMb2ZBdHz6GtriIv65gumQvJfPD4KtFjC2G0GMxmTbrAPMnnIW3?=
 =?us-ascii?Q?BLngZliQU6ykizSbkMBbSYtwxLvj3JkawbHAVX5ZdANkjXbAWO8sUbhOODam?=
 =?us-ascii?Q?8kydnkgygN5sojkS8XWwXc3nOjl10g17bMN7Tlq6JcmiLUpDMYtNqfw+YedE?=
 =?us-ascii?Q?/JI6cla2wk2yrz98IIshr/89u25E0thVT7xWfyDLq9g4ntALXpJmlTbsFPGo?=
 =?us-ascii?Q?dl4FbuWcmxgHf8o7QobMm8JHCZxoFEraRGi0wG45+kV/z/IDxzfCLK+LC5fM?=
 =?us-ascii?Q?vgKANquWbxgFOAavEPfrN/hQeCEZMC3MXsLnoZBig4ILojD4a0l95zHJ24tO?=
 =?us-ascii?Q?Up3Xng+zeylAUfAlBUJCJoM+o4F0HKNj9Z0okL4CgGBWMB7dgyMm5ERu/wgK?=
 =?us-ascii?Q?We9A/+xOH3k6HGyGDWIaK4BC8gnX3o2Ex5sOrgYMbafh9slJYaLyF1ldzLiR?=
 =?us-ascii?Q?W5cgpGKTKaWlrFIOtPLpDztWxJpW1fPT+a/dE/Wql1g9rux/fOkZKj6onWQ5?=
 =?us-ascii?Q?EOsFqfcyg954RQuawb9z7pFec7q70c6c3cz6XR2pv/hsol6h6QLWbUsvVlDg?=
 =?us-ascii?Q?E4/d4DcYCso806L2kxkr+YpXjV58deVgfe6gIuzwURHciKlql59GLiq6euUV?=
 =?us-ascii?Q?4nRJ8GC45/9NE0gWUl1e5CAFiuGIYbdEkqJTfhxVHXkjcfqCpEhohTTMfo4k?=
 =?us-ascii?Q?Yhzc+X0w1cbEV4SgjVqMFeMr0P+wbykG+aG/R+OlezO4CCC6KzfeJSxNOVhB?=
 =?us-ascii?Q?E+VEOkDHNxg+b7XOc76qJvMqjWmnRmNzfKaWrV6FRnUeM0G6g74VhOfdcjoR?=
 =?us-ascii?Q?EVu5XhH7IdOhbwtPF73LwlTcZo5EhC1WExxkXXC+GKn7zdpXBiiHKQI2gYcH?=
 =?us-ascii?Q?sUu+hk0U6npk1XwF0X7v0fyevs1p/DdfxTqqRj7Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8875b8c9-c8a2-4547-8e2e-08db31b72bd4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:11:38.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYqliE8sUzMWnFTxt4zTNbUMteyx7LT/6lmDVGM5mny51VBxlon2Kh4LIn289WbuRXLols/xpGpRZwVAjixoZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8632
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Some of the PCCs on i.MX8ULP have a sw_rst bit to control
the peripheral reset through SW method. For peripherals like GPU
that need sync reset, some delay is necessary befere & after release
the reset to make sure the HW is reset into known status. So add
some delay before & after release reset.

This change will not impact i.MX7ULP function

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-7ulp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index 4eedd45dbaa8..f9fe968bd900 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -37,6 +38,9 @@ static int pcc_gate_enable(struct clk_hw *hw)
 	if (ret)
 		return ret;
 
+	/* wait before release reset */
+	udelay(1);
+
 	spin_lock_irqsave(gate->lock, flags);
 	/*
 	 * release the sw reset for peripherals associated with
@@ -48,6 +52,9 @@ static int pcc_gate_enable(struct clk_hw *hw)
 
 	spin_unlock_irqrestore(gate->lock, flags);
 
+	/* wait sync reset done */
+	udelay(1);
+
 	return 0;
 }
 
-- 
2.37.1

