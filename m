Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2F67DFFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjA0JXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjA0JXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:23:18 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823F77DED;
        Fri, 27 Jan 2023 01:22:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzM94cECm7JC+9F5LuPrkveDkf9aO/HQNvEtWZayTMNK/1iBUyV0Qf/bS5EAfoDV1AZCafHmvPnsqyQ6XYEhDNBz2iKx9AJET9eOTWw1q7g5ZmgRmHVjPdIQGAnLWFKNF3O+fptgYGENAYvGoeLO4z9hT8jGYRrhNELoGq5gkf3k221sN56sat4vq8KyunwhEC/94c25+NTchYLJvRHOJ5mTqOVYyfgNlBEXnUpwb0lLa5n0xtsTx3r34QbpWR/+hOBxd7+6YY/NxQhRYuohtuYtZJJwfERG0XDpBpX9m/iCXkz569v0aY8BZqvPye58NilwCZQWcehHVOZGPqLmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oqHj3aTUHkzEteDjyXDD4LqRrd5/36TOWD1fab0LS0=;
 b=j5NQfoJFL67/0bs3jAs61zCGUfaeTmoV3mYfB9T5INaGRYcfoR9R7IMn/9VhjGOzxPwPDBTmoqqFaUgB160kxXRsN0UTvANoMLUbMbwrkBBaA5rQLW+gQ7t0gpc7KeVrR+rzIoPEV64q5xt9x5tYfZTCAOcAOto49dhrOIO1AOHya0lXxCwh0hqixUFQgewO3YxlNLSwf4iJ1mtO4IH8SdVHI+oNfSiQyiaHxGqafEEQO9ay21i9LPbT/9o9QoHBCPVf7z4Bt2HaHci+6DTRAGSQj59ZzSn8TKv8+GYzqaNoaXCi4IvjQb1uYEf8ODNMaixvijRdVPHuLVLHiAQO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oqHj3aTUHkzEteDjyXDD4LqRrd5/36TOWD1fab0LS0=;
 b=DFICwUaoNhEcW6vuxEMuWbpI9x6k169Yr5SB1q664peu9AlU2SHOmGQB6PZXi+37v8dMVwO2Dv1c27Mb7bwGLlPqb3rNivnxRAsqhPyukWfCxJcYu+Lp4yOXvRqL9rr5W3tisIzNYNk+pe1RLfpMHlCEofTxqjLFaTM/Eefn61Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 09:21:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6002.033; Fri, 27 Jan 2023
 09:21:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/6] remoteproc: imx_rproc: set address of .interrupts section as bootaddr
Date:   Fri, 27 Jan 2023 17:22:46 +0800
Message-Id: <20230127092246.1470865-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: de8f055a-4781-4589-3a75-08db0047eda5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScCWPZNlS+wk8DaIyqO7oKFLmU4OYjSryTasyB8HpZVH3ug6HhewlVXLzzo+gKfhWoWjIgq08/2Zp5k1eJlXm4fyJ69v36wVQZ5bRBvxc4T+J+XzlmnCfp06Hb1hYXQ5V1ZmnCqv4ScXzZgViCZXYdJg+15MD2meBqyTXHnY8qA0uvcNTi80UaiA3MIBfUqk8hIkZBnYIhSTAXgH7mrlnS3W2PO6TuFjNISrfAcKV+m6OVz6CKT2vHRWcbaG0jWcfmV55Tz0DwB4vesx29uiQYuhi4Wc2HkW/fklkBdriWrM7jvpm6zffLSxVsQjkM2xfJBdlQ7NdVPlt1CHf3CyBdIk64IsS+9Mp3mpYuLLtkuqe359zb4L35gBFQBhRa1a1/JboBsuTZ03BFX8RLCn+0uev3BQOtE0LUoUmoYtE7JNQWXfw1TDZBEUtGWcsWX4BUbB32wDU0t0tgMtWqd/M8ugaXgTcJIN8bZmsI/10FV6OvtnVuKBH5XxkRqAPa6ymx7ia8CLLQ9Rc1prcIPEB1rX5l05iRlEY6tOrPInvfQ9yROfAhRs3BO9/sI5ZEEwJfC33v4r2/SIvJCvGvJVyDBIqClR5F07iN87UDl2yNDFVapG4iF/hSgvAIHXhRwS5oRB5cB5qAG4OIni71rvl67ykPvjaKMZkfVIAy8wdpxfuiIDIwu9UT9+DLARyE6X4zV5g5sqe5pA+EO4MifKRKt6KplNHHHA0mW50sP2XkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(38100700002)(1076003)(2616005)(8936002)(38350700002)(2906002)(316002)(52116002)(41300700001)(6486002)(478600001)(86362001)(83380400001)(6512007)(186003)(26005)(6666004)(6506007)(7416002)(8676002)(66946007)(5660300002)(66476007)(4326008)(66556008)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPpR1tAbZwEgHljSPlzN8TZwiPJ9DnzQHoqXIByxBJ8ZGL2YZMF0wZB83Y7f?=
 =?us-ascii?Q?JKuOaxbUD1CgUntdG7VrEBm9O+YmciFWNKluo0NZf6RwLB42vN7ahOyvPc99?=
 =?us-ascii?Q?dh6ox/4Vpc/VVClYIC0Y+pmGH27jngJu8Upz4y7L3psrwdXMCr9DVPvYOwU3?=
 =?us-ascii?Q?rdQpY6MynF7ZJgY9M6QMUcRA7iPONW0ydwu95bBHNKx7F6IWBN5A3ejinzXq?=
 =?us-ascii?Q?bHOTONYZyX/yi8k5kuo2DZLIk3RnBmQzN/Xs7bcDgOFIjvUHzV58TV0WXEzR?=
 =?us-ascii?Q?HAIaZj0sCTCEnpVd5Y2nJ2TIygGAbMlKy1cGCHZEuASmD6nDASoJMl8u6bXs?=
 =?us-ascii?Q?3Z8yRhV+sgoNyeNotfXUB3jMhFbkYYuzj/fq6A3NV4uYhBu316CH9Ik0w4QD?=
 =?us-ascii?Q?c4qIVodIKE0dpcN9l2ToH4zqGhtQpzXCSGQZxAkQiN2Dz0p2864eaxEj6WEo?=
 =?us-ascii?Q?FC1P8MXckSgtvJwbpw9Fg744jCNyaW0E5sy7SE2eAysS7/wd/zrSA03z6vyP?=
 =?us-ascii?Q?8gvSDvndf3RB2V8+W/rArdtMfDPJwWqPR0QWiCdruA83R/x4Ie69NeMoCQiw?=
 =?us-ascii?Q?xSoscjW+n5UByw/GnwLyMe17MzHtUj/TsddrlgEht/iEGsQUoGa7fpQF9I6K?=
 =?us-ascii?Q?emh0hIoV8PpbGGUfJsUSrN5R5wBsehzp+noQTZ6nyjD882h5JWAYMeMhxFJ9?=
 =?us-ascii?Q?fen+Rqrn5QJGV0pwkaoUKJzIUIUrsovfzY7j42MOPmszY2i9tEZd05/ikz/2?=
 =?us-ascii?Q?8O2rN5Fx6AUahUr+/cbnkRRey0Lk92Nm4sKj7q5oukajuvJggLdSe4vmQSzD?=
 =?us-ascii?Q?PucaWE8WC6APfhqaZEzETdsN4M6TcAc6nxUlibkSUq/VvnR8UtvA/ufGn9Zq?=
 =?us-ascii?Q?MAjgrbbOwl7hIIjnwOBo2dL3nDaPliSmRWzt/m+4RAHRcvjdgbtIoRsLwtuC?=
 =?us-ascii?Q?BaGdGZtoF851rdt63NosbMqS6GUNuNyd+srx4DBUZiT+ge0kicALifwzMyhr?=
 =?us-ascii?Q?9SwbJXwUeu1xNuAuw5g9ySzjMs3rEj8JtdaGaUwh9jkbEC7neBpdGwhaNRyF?=
 =?us-ascii?Q?7thiIbj4Bl9hxJh0uNrue0MCtYyATcyg5LHmL09rOkSEHSNz7bzTXqdxWtBb?=
 =?us-ascii?Q?79UEuHf4O45ffEZrCKgIbfUFwdzDDU4AbgssD2BMn4VB0RiituB2ZQenR45x?=
 =?us-ascii?Q?jDznzlp7XAf0pnYCM5MncpjPM5JVUWg8effGrnVRcRlJkT20gnPSTMePPWUW?=
 =?us-ascii?Q?bl+mF7q7H2nKI3XW6ot5g2rzgQOpDM9LUnlymRyi6fynavZWNUNTZQ8JcivG?=
 =?us-ascii?Q?gzPyr94pCGlj0wn/TRMp+l/UZaWi0b4lmCnxxA05d65Ons41tw4MyLB0JVri?=
 =?us-ascii?Q?sSOABDkUugqSQpSgar0afES77nbqPMUaf2aoQFvTPfH6PgKY/lWSHCi3kKya?=
 =?us-ascii?Q?rT4hvQv4oz1x62PHyNuLZp/81LuJX/BWSsZ2hAwFS/Qq8Qo9sHueVTRvs+ZR?=
 =?us-ascii?Q?QaZ9aJplUiJHIzI0vwRyvRyrBgjvUEpgk5lSMKlC8LzrYKSoR2v4LEQGKFmy?=
 =?us-ascii?Q?5z50zw9szkNO4VjnCxmlWHk5M9gpwSfLlZHHJPPK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8f055a-4781-4589-3a75-08db0047eda5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 09:21:53.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNA4XnjBXjNn+yLbsgwqzl0QhZKBDjw4v+zEuFhHzuSc0vi2ka8egTzSP/gBPcswd3Suz9bD6Vsvsive89j/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
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
index f5ee0c9bb09d..59cca5ac3045 100644
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

