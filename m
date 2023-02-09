Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E369007B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBIGi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBIGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:38:27 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC340BEF;
        Wed,  8 Feb 2023 22:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXWlbV1BNyo1qpP8eZvzpkfWTGWdO/+AX0vgM++3qaqZRT/AVxjXcIrFsppOcb+jtrzERfg2h3v47rHgp5sCI+SObohBHshCsY72dR1QCv8h9qk+wRsgmwXkW2qvCQvRpxYi2adeqbMyKup8SQ1Xg7nbHjTiSO1QYhIqTrw7qyN5/STWOeJGEZ7zR88ah2hqCjPKoyJc5cPeNs29HoAIXRPRS8UNDqq2x5LzDmGnyVy6ARDj8g/T3+lV7ECh0LCGX1d5f3BqnRyseBAZr9r7/gxtLUftWN1FCTCnVBIag1ibhxu21Y3oiXxkIqGVOPYTYqfpECUqKNlTgHYBqgx/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuwlH9ek5tMgVYl1OfWKuv6ppu+tqv22m/mAcECL2Xk=;
 b=XZy7VFlTQ1elb2o/nPk1EAYhyHVqTR+fufQEKZ9um7xz8kE3/QGyjviNQLUWGeT3Z7d7f3O9H804rF5aThco/xLNbemZ7fbboFuJr7fqkSNTbWkm13qDnZD5g7n/GKT+NMM4lnckiy/C3iaHeQW9mFysHiQb9kHEFGhqCa5A1MsmuK0NUSHUpDjFYrM06yvNOZAzYx5QfggeY1Y5F1LphXHGjBzOBkFyjZ0pzSfTuIiwOrasHl5OmGCnyVw9+GdZbmPDuTFNWuCcuRA/l6cIod0sQAxLuIqdHCiOZ1arYwI3NFe6MFIK0VfMvVb/a5HWtXSEdNGMnLgBrrOdra/qyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuwlH9ek5tMgVYl1OfWKuv6ppu+tqv22m/mAcECL2Xk=;
 b=L+PCeqp+5/ghiVn1jQiw1tEX+i2iF41CpyozupqNWmMN3YHN8CshP156Xe2qFwI/tOzGw5MWzM222hDRW2K5BMGO/m6S17r/0PPfoMFZVPijrtbO5HbpVqkH75ivPNPDlPS9bEj1IOblVJOMvTwjzhF7eXoEjaU8BpYQs1TgVuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:37:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Thu, 9 Feb 2023
 06:37:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 6/6] remoteproc: imx_rproc: set address of .interrupts section as bootaddr
Date:   Thu,  9 Feb 2023 14:38:16 +0800
Message-Id: <20230209063816.2782206-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9280fa-824b-4dad-be74-08db0a681d1f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdWBIEWcqRzddwX1ww5dma46KBH8EsKLWns98dFkQPXTobKj+hIzcUVPbuh19MVJMqC3y09gBssouOpSccrfd7Rtu1Os31orHMvfB2nqZMGobhurVnFu79J8zzVa8eGKmM9t0vveKf23B2bWPMiqLkmClxwdpcTrR5IVbHLuVkH2Jq8QaJaf7bxLvCLYoUKlo4Vd5aCXabEWDTifi4ZCvWNS+zOeeWGWMebzO1u8y2htGi+jw8CmdabL+tdURp44MMHR44d6cHAO1BGLwyc86bSQwtMHYlCkC8CovDUzTmjzuFEWKYZZGMbGv8Hw0G/7uILLhj2E97RhPEvB7iCscCGu6wkvT470WAcjMTfzPSJb+aKqr51oUInfE0Lbr3u6C4+OQi8yC2SM1mIdWhUE8n0KQjTg+PSn83S3O9p9P75cpCRFoVeeSC0C6tGcSZwIF1Kdr7nFSNk6FVOvtbeVHLVlBmNPknK9AtGUaUFx8PzkZ1r6T2xFfQTpzt/zWREZaaZ2L2V4IMxENuIzCQEH60XW7ls3bdD98MsGjFz3uMQxcOkc6aOzBmuFaDZcaz0MR9GQKhXX3MCFUimzZSwKtINnVg/t2zuakUfkAPhWQQWaLW+GIXVP8T14KjM+koAOW4qhrbGMvoVYlsaDpLgMLiVQH8Irzt+yyFGv5BmsKsiK3cNiHzlEK3FGbbx3u45N7ThjMnFHlvb0mhM9BdpL4TSIXavQ6qw9LwVKEXzofBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(6506007)(6512007)(6666004)(1076003)(86362001)(478600001)(6486002)(5660300002)(52116002)(83380400001)(7416002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdByv/2T1MDFHZMMVsIob4v1h2u9ZNLovDiSFF5CpffEr53RrVxHuqXcekop?=
 =?us-ascii?Q?MY9r5L2e3NDIX3kh2ZEX5r2CeGLJJ+8YlPUSH+3/8rqSEiijxNjGbHJlvtt4?=
 =?us-ascii?Q?k33gsjMhB4cLJGjamZmfOrJ2+viGMAMrBpuZvzvsitY/kHBsANAD/TXeg7A4?=
 =?us-ascii?Q?nuW6QpeaN7atZT/mBd0XTNp0ZD0FVAWPwFDuonNojmsBmykTHjOr1VcWshiT?=
 =?us-ascii?Q?h7NCbPneeLlQGxyj7BBCyWa4omCwwc8iI8EONr4qLmnjsnNqSX+5PIiOD18K?=
 =?us-ascii?Q?KhZQcXYMknsIQ2dKlXMKSqIf/opFQkAotxvlPL6d3TBi7W6mzCi6u/vtJ21i?=
 =?us-ascii?Q?Okx1diiTcQxfSkse0n7TRWn+p58J6Gsdg0vNKjUSivMg85n05aklsXtejK5e?=
 =?us-ascii?Q?0AtISY/oFzS81VCIsKKxCOFiCsZ2mIWrOofjVBr+ZfGEHU9fPDTlyuGfDvnG?=
 =?us-ascii?Q?fXqWMT7LXzBUmcRtL2cxBgiLyg23eO6v69LzlGNt2GydpuFHRp6hjQ20EuSz?=
 =?us-ascii?Q?KWMCv6GmP535amcc/R4unEOMnYcPRT2Vi/riJxix+BPDs9agkdGIG/4WPoz9?=
 =?us-ascii?Q?0TYG3GtieMwfpmDjCzOGDKWv/vj7aJBB4Q6BeYnoK03R1NOS336urMD4xMim?=
 =?us-ascii?Q?ApjDKVzNafqEEks8XSP4nd9FjRICVJYgXF+3eyipJZsDILYQd2eatCf8d9JZ?=
 =?us-ascii?Q?/VEODf3vgDLIlNsQcjSboguCArtQ1UqY7xe+9dHsJ4yy8gmd6NKbgWRZOuxc?=
 =?us-ascii?Q?0B7Q7SPTcF5zbrlxpoc/HIYd4tqFjyPXu1Qw/l2/IYuIZ8Hf4E/10GbXNN+F?=
 =?us-ascii?Q?x2mQGoWE6fh7sB6tXT+QamZnvH92/IOzYTzQ0Y3A469IU9APLH9CgKTnfLmL?=
 =?us-ascii?Q?8gagwrlF1KLWYpBGv/bwDgkVMJR5ph2nqmVB18IQlsCqja0SRPxwXY6Qb9SE?=
 =?us-ascii?Q?LklvkC02BTs+/QXEopKlJ5MuWHePEfNmeuL5BWU4Nex0BKd8mDh2ev+Xo3vB?=
 =?us-ascii?Q?egCWs9FJHJtv6SyAlCfwKkSfZuhu6lgpFPOKCURLFxP/6/Eww22VwZDsdZIs?=
 =?us-ascii?Q?YfkRxbL9leyh9RdZCcEcLyjlP00t0qwLTrNs+W/c0LFbeHwT96VQGaNqvUSY?=
 =?us-ascii?Q?jj3vcrNI4JZm7/MXMx6PyF9lgUaU8Es/p2/TYTs4TrCzOFnYxLFP/8OQa5g7?=
 =?us-ascii?Q?bSo1e2FYVo76hWfiyUY2z4JvsEf3x7CHYqMKXhLkdVIjF3+8rQmddLhr/ODf?=
 =?us-ascii?Q?HIJPBygPY5DIwLj2Kip/P3kDGB/cpuVMZs11Yc+SwmcKF8Weyz8An3sMK7Ai?=
 =?us-ascii?Q?qoFu14SnvQZHQ6Z373lMQNAhz/TmKYAaBqLZRXg4942/PKYRroRAfQizH7TJ?=
 =?us-ascii?Q?nobraqnGyk8/Rciv4a50FihfKtQidA/07VLcCRy+zoWasC4gmsU//S3spIN7?=
 =?us-ascii?Q?i8RWhQwbcHXwpz4qgbgT0QvL7dsZjXP0OJd1ddeoASRA3cB1C0iMpRg1/Bdf?=
 =?us-ascii?Q?hBFBx1hA6t+SUmJwSfVXkV1XfvKnwcQYceOR4yBxfUKg4OWdSWls7dgvdB3B?=
 =?us-ascii?Q?rH7xZLQFb02gTPdkfIigFLjXXN+0QUsSXtk5gx97?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9280fa-824b-4dad-be74-08db0a681d1f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:37:28.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uefO2NGccf4XZXzcwwof2xpVpWCyj9YCiIsrpm+5dJmaTLsEXgDMpky1e9zPZPzFYKA+zpEb8Vc8PbSYyJ8vuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
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
M33 firmware, because the PC and Stack is stored in the first 8 bytes of
section ".interrupts". In current design, the Arm Trusted Firmware(ATF)
use TCML start address when the 2nd arg is 0 when SMC call. So When the
M33 firmware is built with TCML address, it works well.

However when M33 firmware is built to run in DDR, we need pass the
".interrupts" address as 2nd arg to ATF to start M33 firmwrae.

If there is no ".interrupts", it just return bootaddr

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 2265eddef4e9..ec5b1d8ed8a0 100644
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
@@ -663,6 +664,13 @@ static u64 imx_rproc_get_boot_addr(struct rproc *rproc, const struct firmware *f
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

