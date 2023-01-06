Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4787065FA70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjAFDmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAFDmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:42:12 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08D6B589;
        Thu,  5 Jan 2023 19:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y620mummi6E1HZlIvTwdYFrD+LkWUAKQINrnqHKFwzGNyfbUNau7ue3/Xg7PwZLXFoV3V6hM15oAyfFwR4gg9Gkfvaaaa3DvHq478Yg57JjYVm2qv9Wrz98P3BtpZER3grfZEzd4plTIKNgj/2lP9uaNMP9QWDR+b1uNYQOxhTXg91ebEO+wGFkrDBkfa3tXDCX6+b2qEF5aKGUShN854YyPu92e9Wbf4l6ffdsmi3v5grE5gvxy2/mY32JZPXtZMDX6X/Ltkkj5dkwzR+k67ee4cZqc1wX2ZUcU6FCqLhUPoKhNLKCU22d+eRfVT1dF6gTL1+pW24HCEfgHnbm2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4G5wZXUhS/UCosIeUj4Y9NRHxRLQxGvBi6w+2JckDA=;
 b=XC+UBeQ2cWpNFlut0AOqhTnF51xIbFkgbN3VH/AtoX5PJ5uJEDz2Qmkk6CSmnbs0j8eVm5m+ZM1nXrbIZm1YnattzMSrUsZ5xnlRGCjfO6ZWR8e5wOGb6g4cBOZeAy4TTymVOesyaevBYHsenbH20jhWuBzk3zh2Y4Y86TAp7hWTwYsT9dGotEg175rkmzShV3uTiKoowhas3P1z8cqOzbjzi6Rbuht+YMH27chKO2U9Ncg1UwOkJRcZBt6EYpFg3yTLm2SXFWd0vyA2TOvAEiyHe8/f0Kc68T75tC4P/qD+2h3IG1uZRlLr0oKImnxJ9AGgFOlXcJoiQDhL2C7MvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4G5wZXUhS/UCosIeUj4Y9NRHxRLQxGvBi6w+2JckDA=;
 b=banDoSh2TTp8lnb3n+pmi6eBGviO8m+C2I839C6/Cuu0w7KsXcQTF0pOWiDayJy20z+9Z5ZhzvYxFcQs8uxqtYGUNNO6SMr5U43cxCNg/R1B5VzgADLmwniMY8gaqdWPpSz1KD4gUiI1FOV9F39qqSWoDr8GsYcpyhiO4GaIVHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:42:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:42:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/5] remoteproc: imx_rproc: set address of .interrupts section as bootaddr
Date:   Fri,  6 Jan 2023 11:43:05 +0800
Message-Id: <20230106034305.2868740-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
References: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2b2bb6-fd75-4aef-7848-08daef97f9d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdsBD2on/an/hcKwkbuwjPJ+awFyNhU1Dz8dIvJYFYSVWM+Duh07b/PdOynDbcwRJ/gkbvfjBS/SEgbQ70o6hoTo7JHb7Pu1uXme2mlIFsskTACouSxynGZI6s3T5eXQ2sy5BMk497YUZWEvho0wa09j42v6kGDek8C9pvY/S0irkdGCmNwUJH3LPjoPT3xTBRz0fzCdDsOjGJheIPIVqBZE0phcPBADZbLG6W2KfXyqXQnbHaeClE1iBVc0d3GhA/JT0rDKW/mu0EAFvp6gN4H1D0XJz77f2qcg1JS+f554NsB5t2MVm9Dejnzm7BLmNIXi9VixB3+Mqw5qP3W724xSrQJwoqeSLzwRVTzCoRF56vAxRIt/oIosCLcLdRtlAzgEqIj32lIaVHTuTtsVT22KIz+m3tOVNj05KU3TJUEzxrd63mJoa7fDOyuTvdeKsItqW8LhbiFWwGwbjTrTvrb3ZHRs3uXDYJXBgf+T+DBJO88g4u99vzvLDJfX495S1ctxMExCblB6R5TLkL6FbEAYW3MZo6E9hfXTb106Y0i3EWiMdEqBcbkQkOBH8GDcUuNSwt3FjQ1WkMIrGLTmDRgFDefSPsgJ9JuovdZx/Awh/9MWa9/vvWkSj5cxc/7A40d72LAuZ++j2pDqWBS+9uJ38wLQIvVqTTbBWhVtwdHOV+P6Qehpi2misNJ+OyVi6ofI8SCaysQbXBQZ4Bj2xVwPpRWNyYRhG+bUAPdUox8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(38350700002)(38100700002)(6512007)(86362001)(186003)(6486002)(316002)(26005)(4326008)(8676002)(66946007)(66556008)(478600001)(2616005)(1076003)(66476007)(52116002)(2906002)(6506007)(41300700001)(7416002)(83380400001)(5660300002)(8936002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yOwyW6kCwV3EtfQ4Z9RRjSsr1zJDxAHmXLqin9lOxufFGkvyDymCqy2Fwivo?=
 =?us-ascii?Q?ZxpzVph+xaWGKSFKQAGhDM4XLfxNjLqkX8s9qYcsypiNDsUq/PgZEEZSIUZs?=
 =?us-ascii?Q?gH7dyyGisgwazeTAs2mpR0fWwpRlSYeL3s1LvUnGyYoEW/3szA74whlpn4ho?=
 =?us-ascii?Q?RRIvkWv9cmullyhjAB/WvcBnCziK0VOwZTfKW4NK3GFlbEcuRpD890h8Br3r?=
 =?us-ascii?Q?G2AHrN/p9GP5VwJezYHpxUYxXYHgSTG7SszBtXuL3F34fpT0IrhOKD4OETBp?=
 =?us-ascii?Q?IiUeOhYwKgRmbZXlJWrVTx6PBPA4tRL020gwrhg7YRS/KDbHiP/dhvtGopCY?=
 =?us-ascii?Q?5V6/4j8Pa8X2sCZT+wpTvO4pxnV5vYIFvhwKjXETNTOOw4vgupsFzF2pwgJw?=
 =?us-ascii?Q?j1xzxYeRfFC1P2AmD8mA4g9Z3f0En7n+5Ok500N3hSVJd9q3JBadUG13CS+d?=
 =?us-ascii?Q?rz6FtmshbE71ILdnaPXCrqMbiD6jKJ11HmD+E5NV8/3YyLhCtLK0RCGDLTXA?=
 =?us-ascii?Q?DY4Aez6OZypy8aWlsunIndYeO3VoXsYxYWqqwiOX9dOgxMSyAfu601rkqqec?=
 =?us-ascii?Q?i4nswU593MZ7us7DEvYflgjL7XfeSLzNrMWwx2cDJzdTzGvrY/BZ7d9bYA+n?=
 =?us-ascii?Q?drO1Idj+FadWmTDZ3IJGNya0tUsUPbtyTibwur3GJPx9i6WX2JLTyjnnVzLv?=
 =?us-ascii?Q?0utE95lNaHOHIcOMmel5Bt4SSYS+qyCO+XhbLCrWp4eD674OTiyP5NoLHmZ/?=
 =?us-ascii?Q?eWpHCL3f5ttT0Qdw5viGJOaZSsZrRdGmOww7WoxIwWl1rGWwneq4oYuoZemj?=
 =?us-ascii?Q?9FtVqobgAyZvY33IcloCcaupSGGdFR6v0jPRY1yEdaqgttv4FDbRtk0DD3Bj?=
 =?us-ascii?Q?BxyDJpD0ICAvGKSOflUWVsz3q8ijdxF1cNY1Na4FwXRb0L3UOE16685/l969?=
 =?us-ascii?Q?Wk4mC70LfG0Mn+r/INqTOqeLOTIHgJKu8Ng9fn37X3RJdUZvnWrnlS1yodee?=
 =?us-ascii?Q?+qsTx0EelHy4ohpL5AszxlrSG8BzQ75ND2S8h6lXe8SYS3qQwZPdWHj+/elk?=
 =?us-ascii?Q?oHFJ9zkah33HeJLVTwpyhpruWSEIYSMuzF/X3ecnoGO4hoBCxt3Z9+i4rbHe?=
 =?us-ascii?Q?BdmxCOCVR1s7qBhmEwJtW6EweukOx/lSZIq9q2Mdeoa4vknr/5s9NyAkgYAt?=
 =?us-ascii?Q?tc5e+NJQd/G6sn6fLA/+rHXfaw/4sEZcCO/mg0Vd2XvVCif4GNh2FvH5hijA?=
 =?us-ascii?Q?FXY7bRmuKiRg8uctE04Rp0M3A3V8Qxx3DltL9Sax3+YtmhRL+sD7iSaR7nph?=
 =?us-ascii?Q?r+qEzE7KlwTNStxnFdE1f5EzGxKn2OWrKZTVyDa9wEU+9ohVQhRMOIMyjWdy?=
 =?us-ascii?Q?aKMhs/Gts7kwrqdEZH0Iq2BdsLbnHwh6+aqYvyJdo8T3GbZUD3l6UPPW2E0L?=
 =?us-ascii?Q?BGlbWCG4OFGHOdcp8NeluNCzYJ0wUShrRqO3xWYmumyi8MkS3lV/0RDsHb05?=
 =?us-ascii?Q?DZqecuDpI9j9a3yaNEVtehg2sjMYcT3TiFLVTUNFBtbJA0viezjxfE5+5h88?=
 =?us-ascii?Q?DOv2AVRtxd8ugIC/S6Z5ydtqKTVytXkx/XwdCMO2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2b2bb6-fd75-4aef-7848-08daef97f9d5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:42:03.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2D+nKWlLmLS96ROjvJCgYgTzkp5LKLzjY6yrqNgupnpoSnqY7oqbe5ek75vhDAXTyX56h1UJSPT2An6WRkDCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 M33 has ROM, it needs the ".interrupts" section address to start
M33 firmware. In current design, the Arm Trusted Firmware(ATF) use TCML
start address when the 2nd arg is 0 when SMC call. So When the M33 firmware
is built with TCML address, it works well.

However when M33 firmware is built to run in DDR, we need pass the
".interrupts" address as 2nd arg to ATF to start M33 firmwrae.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 2ddf89e15dc6..2e90fd470198 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -374,7 +374,8 @@ static int imx_rproc_start(struct rproc *rproc)
 					 dcfg->src_start);
 		break;
 	case IMX_RPROC_SMC:
-		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
+		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, rproc->bootaddr,
+			      0, 0, 0, 0, 0, &res);
 		ret = res.a0;
 		break;
 	case IMX_RPROC_SCU_API:
@@ -664,6 +665,13 @@ static u64 imx_rproc_get_boot_addr(struct rproc *rproc, const struct firmware *f
 		 */
 		writel(*(u32 *)(elf_data + offset), va);
 		writel(*(u32 *)(elf_data + offset + 4), va + 4);
+	} else if (priv->dcfg->devtype == IMX_RPROC_IMX93) {
+		/* i.MX93 Cortex-M33 has ROM, it only needs the section address */
+		shdr = rproc_elf_find_shdr(rproc, fw, ".interrupts");
+		if (!shdr)
+			return bootaddr;
+
+		return elf_shdr_get_sh_addr(class, shdr);
 	}
 
 	return bootaddr;
-- 
2.37.1

