Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4E65FA66
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjAFDmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAFDmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:42:08 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB66AD92;
        Thu,  5 Jan 2023 19:41:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXnC0m9dUUWGgSBapwnjhomtS1b+NFPrleGXTKdr3zspZzoAy5CzBBlDZKBWbMaUA9LVVYeAEwxyXakf3LW4OKXp6aTvdVYUXBIkB9PBdpAJSdAoJuveNulMxpSlA77sr7x+57Tl85SzjLEsqN4V7gU1vx30GwZidiNzFFD6Xc4h8I9Wx0l4Yq6Ka2xr8EpPN8/puOgOK8cT+43ZkYtJITjLu2NU8o7MERNKCXbb8EgHRXg3T9Pjai5rnK/a6QBy4WLajxONBMi1H580apjuXADznMG3rmdfSEPu7tz8pQSuvcOE1uQiQMZU2NT53GYXTwHi+ivxCLOsz+B1A34ROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSPoFCp1WU1ODs5miVRwkzxQHfokDiDO6FyQQnFZ4VI=;
 b=Godh0CP7oNaNgyjv7/RFf1b3h/IdyRU3I4cRjNRihZG1AsmRDSMiNLTSy1nRiS8h0hfmQai6ArFCD+h/wkCFDo8HBf/tjcmxJhE+fXvXrgVi9OSpQvpvp1xtS3dedOksUGLaqApH62qw8tnoI3JjCkie+RvGMK5R4MT9GW4gKSmAlKYkqJb+WnjGmires4Z+aLt+QGgFvxrrWTnLEqSQDR8qy1+SeIcONzs478j1vImmCVFq9Mcfj8rSE2pigMEFwMYXATLGJaOgoss4UNST9mQkY7s2R+/YC5/NrlU45JaL0w8pwvgRny5IMp1t+9oFAJnBDtXTONcqSYTfWOpqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSPoFCp1WU1ODs5miVRwkzxQHfokDiDO6FyQQnFZ4VI=;
 b=MOKxhtjMvQ+ubQlyJz/mNxdwROPkRJmevdyWlSeevWFu09zWxeQ2m4J0cng0Zte5iWnbHNB5nt4ZKwS1D6aL8iuL9p7u7aC+lkVMmomiLmRyXAuhQ/A23mb+8FiKH9SoZj47+Ytan36e1id9LZT/tvE5QzQvFA2SI3nrs3X842c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:41:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:41:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/5] remoteproc: imx_rproc: correct i.MX8MQ DDR Code alias mapping
Date:   Fri,  6 Jan 2023 11:43:03 +0800
Message-Id: <20230106034305.2868740-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4b0d759b-242b-4c82-b0a8-08daef97f550
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vNcCEdy1ALPxlXeLGMlPMZcc+RLFmW6301g2lij2tOuYVFYvyTqqhn6Mp2OgXuSH9bx2TbsJeEKI9S6dTmC/DRrdDLvUanG5kUOhKi8YzUO/xmvFkVag01Rovv5tQjf9f6SKDor+osEO9HIPIL93H/GvtkND4aCPQUtU7o+EZiAUt11CfS8XL6G09bZ7uSCMguIMqWZorK35dWCwtoXRGeZVxxCSi3wI4LDs+nB2UfQDhVf0nEjeORlAs8W3XUVyNR8vpJg/HA+EQOQBAvi0NmF+52hTRpYoGdv2E7xuttVekZxuLTsrTDiLw60iSGGkRmw3aKH6et3eCLeDhesCL0GPBdc7Qbc05DlzCnAQUcMZ55e36X/EmOsX0b0ioLc9JhO3dHLyiGPS6TDBVmPAMAGKrVoDpRgS2kAxQlaFAav0Wgv2yKX8JInIW3ZcGYQLSZf+DbRTS6eP2Mgy+vID5ZlLxiu4mICERb69OB6WuxWxynlaB46Pw4QQABfIHn6GXo/D2kx7L5mGBKG3Xd2q/OQVsT7ShijAzHAmWa2xLIu7j2rFAveai1wE1qUPFmlUVwzQ+ipD4UoEVgRkobnfBFhjJv/IzYrkoI9uf+vrtYcS4PdWrbCFHIkx13lU/Cry5iMzwXCIqYVtUhXsHcelcr91zTuyogpAlCiTGmQPDp1pHiCUW5YRnwzIeBYWmp9LfUOoOolwt4riolLLRAW8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(38350700002)(38100700002)(6512007)(86362001)(186003)(6486002)(316002)(26005)(4326008)(8676002)(66946007)(66556008)(478600001)(2616005)(1076003)(66476007)(52116002)(2906002)(6506007)(6666004)(4744005)(41300700001)(7416002)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?suJGMPSU5aHxb5t1+3Cf26whiPHK6BO8UoJEXNX21pxOzwkTpUeydZCTcIpy?=
 =?us-ascii?Q?gn92cCjbn3q+bqsPAZhgnb9iiuhvc67O0nNDbt++7x9+2IJ7PPelVuiIOvLq?=
 =?us-ascii?Q?n8o3iT0+qQDwjG08tdweTj8mKegyMX6HVMHh8KSb/U0BHiryrlRDwY/hqzIl?=
 =?us-ascii?Q?cgTNagEzmyuydjf0wXnRH8fREdW3DbtTqSpHzij8xlwnyiyJTeaL5GY6d81e?=
 =?us-ascii?Q?tUJyugpETQkyya+v7uFockaF09L4giEYYgQOWjkJ48hIUM+JY3RtnHrYulkD?=
 =?us-ascii?Q?PD24ubucxFpfAlULuM86aPH/Ti2DTb79iAfjZoR1hYGMGIFKmbaaqKRpmXkx?=
 =?us-ascii?Q?qk9ztRAOgech76arR3yXDNQWZLaQB1a3D1iYLgTDjvTrKHQQL+3FjxYqSyrT?=
 =?us-ascii?Q?Yii4bE9LZjYcKVhvaF5Yfpim8KGNI4nJ2+8yEKRjl9KsLb9mU1JNBpUbsfZq?=
 =?us-ascii?Q?4ec2S+Zr4HVyPG2gvIzvkV5FgaUL5Oc9kfxApXCGc5zauLuxmbvQIs0lJ5iX?=
 =?us-ascii?Q?owDtI4H1SFTBXX6mzQZhC0XmvyLE2Gu2vCq5S19j5CY5zmkBDV48ZnPN35dl?=
 =?us-ascii?Q?b0um4GSzO2iieg8PH1jGq8mNtLvUVSGOOu9j1adGauM+zx4LsykPE4hDOBmI?=
 =?us-ascii?Q?DUJBEJFvptMZs36ExTowbhlserdWUwhNkGa8BJFkchUmW/wCjZrKyrROFLiR?=
 =?us-ascii?Q?g9GALkD4fSiJUUdd2X0Lt9msVFL1R0vhcBSO+5evaW32t2qXcChocJZELf/0?=
 =?us-ascii?Q?/Fr37s7jG5VdnX0Bxj61dIEJgVX/Xk52/hRlJC6Zca/2FGuSpWOccu7ftP2+?=
 =?us-ascii?Q?GWdSJigmd8isyXYJ4oEcfOnc5UPxlgspWlUxwonTFeG2Vga6doY96+NfyBX5?=
 =?us-ascii?Q?AVLfY6lMe8Ww09QHtD9FZoacJ+Q9BUOLgJUlFqsbXPdlpS1TNCKnPnll4gia?=
 =?us-ascii?Q?BHtSI7JTwvzp7lZF+y1C3KOcq5VRKdR7CoDH2hUtueKdRj+yJQopHDtxLFO3?=
 =?us-ascii?Q?/9zYFfNVnHDzD8363Vmaq2+OUbS3K5Rts/jC4EVDVegtyNBODm8/3HlaKQD7?=
 =?us-ascii?Q?9PPL/qSbmxYoLV7aqNl73Ch7sO6hKtpQQPcQDsgna/ZTt80sdxx079WCmhM5?=
 =?us-ascii?Q?Vf37dKfQ6jFV4d6SWtpuYIvnu/vDEkPF0AOztZglSTIKsFsmCwr7vqknsgRx?=
 =?us-ascii?Q?a6qnYTEGKSwh+hu/M0TnR7EBhwm+TEyutcyWbKsh/As2PvaqMaxXsMN1n9KG?=
 =?us-ascii?Q?mu5HrKK++yvAIpL20DxSsu+nI6i190wwqTXtaTO14Mp3qRG2SX0kmqBEkM9k?=
 =?us-ascii?Q?RwQLweTGUnkT6gU6m5Pr/HYAzZQOMTAw/qQbiXibwedxVJ0QyPYVg+qwW45b?=
 =?us-ascii?Q?GxFos21yCnbX4Vj+6rGZNtr8mPu7dT1V1CO4+/A1BYwMzMXsZwhdfVc3kNj/?=
 =?us-ascii?Q?lRn5d4pvgpxBKO2IFIPLKFKeduQrvpRM0VnkR0FmaBWoDqhOAzb0CPWlEWUB?=
 =?us-ascii?Q?AMYy2oCBSPGDr1OpmZg2vA+RtQC5x8qpHISNLZCzJES9DHA6ibYpelQdtYd8?=
 =?us-ascii?Q?10+0vpd9K0bgEenUA+415HWWkRRyP/WMpUWzczup?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0d759b-242b-4c82-b0a8-08daef97f550
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:41:56.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryXRMnyn1VSx7pNMPAljOZjQnoph/3DUS1BLgPdD5AduwzTIKFb2KfqOjwZkjXQSdesuXGFRnmCJJACxvndKVQ==
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

The i.MX8MQ DDR starts at address 0x40000000, so correct it for
the DDR code alias.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8a282fb67a4d..13199e593b47 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -206,7 +206,7 @@ static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
 	/* QSPI Code - alias */
 	{ 0x08000000, 0x08000000, 0x08000000, 0 },
 	/* DDR (Code) - alias */
-	{ 0x10000000, 0x80000000, 0x0FFE0000, 0 },
+	{ 0x10000000, 0x40000000, 0x0FFE0000, 0 },
 	/* TCML */
 	{ 0x1FFE0000, 0x007E0000, 0x00020000, ATT_OWN  | ATT_IOMEM},
 	/* TCMU */
-- 
2.37.1

