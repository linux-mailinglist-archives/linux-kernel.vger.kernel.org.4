Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FCC5BC193
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiISDA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISDAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:00:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0D175B1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3s7na8MwiF/RyHjX/En9ZrVn4hsoLptr23DqBc1zBuo+CL67Qj17n7OBuhfltRNhaCmJRK51syxNKZmiTxUxIp2ysz8CVX6/y6Uhr1fbnGxkO9JTadN5INv2ADIDYOcKonvY0UOB4PSE+b9nAj0duiGpyKAOTl6aH4N3X4NkNIG6xtBuLxj+pfOhTloMfFpOec8Of9PuzU8oHiQcb89ujv2HyTsYoFzsuXN0NmhnMEvwOXQJqYHlt8w/vQNMC9c4HSo7egvN4TSdgGDFj0xohLJIxLu1AY3VWtSHIU1GRwSQDTBC+TMJFPJ0EQSXpx7Sl3junB1fRCCUNu+DUx0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4XFS/UYxZPpxD4rKE1i2sWUNjiPNlf2oXFTKMoPX3o=;
 b=lETq1pqF1KkU/SneBYdzD9YiWAN6kp1DFV+iP52Ttbk9cNaJ/BRu0QI5bRCl4zL49MJ9Tf/qVA8/kKBZA2c672z2MqZsk5yfIbx9MPT0ZfWx0ObYgBji+VgXBAdTOvRBsWssvlUwbXjXN0npNDRJD7mzKcK3xBzP1Gy2udqUfFfLyaL+s5O0e2Ss1YhGKMRc3SAKt5TzfmGI9k9x4qLhg+iu0HNvBzrA2XQsT4zSb/VuyIgsntBLN1si0gPiHuwS7u29AFvMOEQxtQ+lma2zwr5HkQHTUUU9ZASqS+G9Ayil69mz0scyHYZoQSExe3MK76kmp7nJ9HFLlXT164zgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4XFS/UYxZPpxD4rKE1i2sWUNjiPNlf2oXFTKMoPX3o=;
 b=aM2mN0P4KdBikXqYPgzYZyAVyo/aDQESrHtBDplfsywzDxakiOp3aghYBIwzD1O8G3d3Q1FU2HjdkcbOFWJHY5kWm6m6nMZyTtqfReHfgPP3wZVlTOMkYg6zpRJw9wu4f5ThMwJZ9FxVhJxA0bgzH0Va+BP8unRqVcmJwhz8F94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6917.eurprd04.prod.outlook.com (2603:10a6:20b:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 03:00:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Mon, 19 Sep 2022
 03:00:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>
Subject: [PATCH V2] mailbox: imx: fix RST channel support
Date:   Mon, 19 Sep 2022 11:01:36 +0800
Message-Id: <20220919030136.1055409-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 512f246b-4bf9-4e59-c709-08da99eb1489
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRGaYm5s8QeikUfcwdSwT9yPq6Zz0OU0csf1hLk3+cfSnQT6on8/SZGnpkan7PD4cnE1XPXDIqmZXE8c7OfLzkSXuJ+A7ODZTUUbwVw7GxQelsrbetuiWR1Q5V1deVpouhL7ge3+jfspb23+xrsyNMkMDuj2HzRou1Btm/ju2zv3jDBaXFx2DZNkEIEtZU3+jNRom+ei77purpzGWoyseQslh7gdhRflrDYU+b1UrCoufI/KUGl7zzMhi9QBfTl9jsP/gJoCC6ZudvXylTXCy+KBVwF1ACtwtfhe3m2UfjGLi5D/6rj3JTygmg9eCsC9yritvGUFtvh7fqNqUR4j8qxDkevlCJFKrHgedJHOxCESKqpoEuDDzNfIDgGvDVb1AgEhrNTmGmN+fCXGtu+NmBrxBl+LL3JHz/Q4V3LZ2w04raJUp25yl1n1W4yXHHi6mIhXhU0ZstdjxWrOWmB81hoOYTrO3yowa0Oco9tK8GLANE/+iOkuCSQFH9MKWiEYT1wY/bV1MrN0AQozhVvJMPQM+V0CvMY4znSo2MTFsXq//1oTxij02AM0CZ69MiRmMOmc7w2oB+FqJGk0h2IcOpC6T60bi7arGmyWSK73tIhikOsooighh0E5nvwC6fMHpjslydf/+fbSAN0as/44u0jzAutBQCd5g2Bt5Ydf8/qmWapj8wKFTSRiXFKzxhHuFjqPwtA3SJc35Atp6F6SCdFxPWMvEq+r4sbMKaDp8Dip7Ag/2xb/+cEt3UsNYuQFlDUk86McB4yOvr3Pl5gVfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39850400004)(136003)(376002)(451199015)(2906002)(15650500001)(316002)(38350700002)(38100700002)(66556008)(4326008)(8676002)(5660300002)(66476007)(66946007)(86362001)(8936002)(54906003)(1076003)(186003)(478600001)(2616005)(6512007)(26005)(83380400001)(6486002)(6506007)(41300700001)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?atE4dUZSoNzsGdoUfiO719ngkhdzgyJ3LZzJL8w/IjALnjCcpDAIegbBPQJC?=
 =?us-ascii?Q?7Tne3PN18CFPzovypfo1sxZ3pJVob+in29hMCj38ocgh/7+zRnipEsq5lRAq?=
 =?us-ascii?Q?rpgoJ0P9CYyzsIRtYYZrINUYKhiFN3qzdq0jt2ZRHe5cGgCkNdQ10wBeZX8c?=
 =?us-ascii?Q?zmJjEKzkdxz283WRUxW9D9+Q6k4f6Thq5fziCiGU4dXMocjPgedTij54rLI2?=
 =?us-ascii?Q?vVtlwQU46xcSDIzke8fK66Y6OUzQgyVr6Pww9tAWBGuz6EjrthuFiY1rRyJn?=
 =?us-ascii?Q?Ghi+dmWzaSiQuTEXccY/D3k6G2KdGO9JiiSEEc1Isj8MNe9VAxzCZNXmxQTT?=
 =?us-ascii?Q?xu83VEXrqFnnbUXQRdEbv3Gjlu4sT7JSmK4/B3Pt+V7dG4DVL67VNtiH6I2/?=
 =?us-ascii?Q?xdVfw8R69q1LJZlfi8/janpyseENObo6KvGb4TINqioDvht6oAercxH/KWUD?=
 =?us-ascii?Q?ycZpSusbeLFK01H30pzgLrQZ044M1NkRcn1DJyGPt7mONfmub6gMEgGO4cc5?=
 =?us-ascii?Q?i3jIwE8e48iG6chZrygiLVT/ePB8YS4LJr68KNAcG8Gfs4BjOzHkL52AUJE+?=
 =?us-ascii?Q?NlLtDmXm2zgUM9KjtQEFb+GRbmmiN15arazv3/hlfXJPkWyk3PaWc5/1/89s?=
 =?us-ascii?Q?wCmFmEZWYP9fVdWR5z9KuS+mmPLfa+RE+1tcluPTe4u7Hoz5CS0z+6KNeLEW?=
 =?us-ascii?Q?bp2MWjCB6TtAkixiEMtm6JpWeS7KQyuol3jcRqmYlY06BXnlsXPxFt3SdEb7?=
 =?us-ascii?Q?SJtgMkzq+0L2y6Emk7KYQDu9cHOfdl1KCfWilIPSrQ4msALVyNVzAO2XfSh6?=
 =?us-ascii?Q?q/4AuDTZ8Z85Ub0OQ04gVwtMVbM0oN0D+ia4ciRa6HwqwYfUfny3BZndCDVi?=
 =?us-ascii?Q?q54jSb35Ltz+aBsuMUH6lKIotrVL9neXUe3oJkmjUVJjs0Z8ZGBBW7kltwsm?=
 =?us-ascii?Q?ogw7SbvUOm1Ffj72aBk49SQQO3gqUgkECKaOnIgOOzri0eqynoMdxGixpxmC?=
 =?us-ascii?Q?XgWzXoYPUNy6Muw+pXYJpMr95dimJaKsfMtWUVt64Fbikw7JBiouIx8bkHdp?=
 =?us-ascii?Q?A7gz1hAPIcOy0VBpUkkp9b3kKDZ9vni2l/3pInxVFCWgTxtFM3/YihxM92u+?=
 =?us-ascii?Q?3A7gu3l6pMgyiDMTxWQ09VOvbPb22j7qHWMfjoBopWi4HSKi28WdJnNOMtUV?=
 =?us-ascii?Q?4ERYdRuPd8W9h9HJvmRu8VI5/sHd7G3pfDjeyFRn1uR0YTH0XLgvYkTEvPE6?=
 =?us-ascii?Q?hhKGL+Gx3L1hUOnmdjCmqk9aC7GvObC6GIU/u2L+pMCgrcv2Yh/yVJ6fUsKi?=
 =?us-ascii?Q?ScYRp8lJ92Cj8m0KZFiSNcJMqwxdAbSvMkfdzZxo45Z/UNXM9IsNX1Q6BX2t?=
 =?us-ascii?Q?DkA1L5E/PsS6SXuwwcl+uRkuxctjOjqOsxUD7REEdPiPFtFMBkCp2XjL+8gs?=
 =?us-ascii?Q?EF73Ef7wz8H10+Q7Xg42U7PAUJ0lWojNG4RKkty3xaxHJGCnnk1Jj20nHRvk?=
 =?us-ascii?Q?B2RHjK5lW1KS0ybaUTc81V7BrXVNPoez3Ka9JCzqsHv3dWWFAb+WIx9vNQ8L?=
 =?us-ascii?Q?peu8bbIbc0PKVAaS4SOGE4D1/RNr5WketLJBn7Va?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512f246b-4bf9-4e59-c709-08da99eb1489
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 03:00:17.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiG1tcY6lyZfLm975ANXZqesrUxpomw1g5r8yTVPkjoSfnPhC1nyKjgVTIVzG8gVO/mhf4pZj14XlAoFUatm9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6917
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Because IMX_MU_xCR_MAX was increased to 5, some mu cfgs were not updated
to include the CR register. Add the missed CR register to xcr array.

Fixes: 82ab513baed5 ("mailbox: imx: support RST channel")
Reported-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8qm/qxp MEK boards boot
---

V2:
 Correct Fixes commit hash

 drivers/mailbox/imx-mailbox.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 02922073c9ef..20f2ec880ad6 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -904,7 +904,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.xTR	= 0x20,
 	.xRR	= 0x40,
 	.xSR	= {0x60, 0x60, 0x60, 0x60},
-	.xCR	= {0x64, 0x64, 0x64, 0x64},
+	.xCR	= {0x64, 0x64, 0x64, 0x64, 0x64},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
@@ -927,7 +927,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
 	.xTR	= 0x200,
 	.xRR	= 0x280,
 	.xSR	= {0xC, 0x118, 0x124, 0x12C},
-	.xCR	= {0x110, 0x114, 0x120, 0x128},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
@@ -938,7 +938,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
 	.xTR	= 0x200,
 	.xRR	= 0x280,
 	.xSR	= {0xC, 0x118, 0x124, 0x12C},
-	.xCR	= {0x110, 0x114, 0x120, 0x128},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
@@ -949,7 +949,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
-	.xCR	= {0x24, 0x24, 0x24, 0x24},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco = {
@@ -960,7 +960,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco = {
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
-	.xCR	= {0x24, 0x24, 0x24, 0x24},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
 };
 
 static const struct of_device_id imx_mu_dt_ids[] = {
-- 
2.37.1

