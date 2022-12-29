Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D56589B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiL2Ga7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiL2Gat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:30:49 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD47D90;
        Wed, 28 Dec 2022 22:30:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEd1dHCl1yNp3EzVJoGdioTs74YSlOPdfldLbcggjFwxAyVqPzS1/9Mr64yVdtG/4gjm2LfPID2BeN+aFh30D7nrN7AeTaAogujeFTmRhf0E61+PnfHr++jSJVB+7Vx5WVjquHYKC3DGY1QgGWKZT+29OjnyR1rJEPu2KJhgmDjCVhYi7DF75e/yFwjWTyEvmvIvsPDFfx4e+KXM5776K92uiPHZtbfsKgF/aPStus2l/cSIO1V6zx7lod0b8irmGFnkIvXKR8DGxqVwIWJ45QYCr+OuC/AiVG2yE4YXA4iD7lL3yHEmd7yL05MdLWsDR4V2l1MZ09XFQjv7GMDeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfqqfKq+p5L47STbaiUShceGluBUv/TPjceQ6WfftIM=;
 b=kydmW3ZBJaWd+xvRWgXuKL6q0/b3M3zsvZGfEl4/+9emuNuuCAv8p/1L2Fcv0Mi/pNZZ/+pQE5hw5l5/Fpso0ozilvfgw9iDh9QOOnKjFuFVOnn5MtroAZ6sZ2gu86mHEc9fbnoeeZpzmJ6TPqKdipfv+WqI7BwGlwuJBY2qXAIumf5KjE3ap/b9ywRkJwDQHe0Wqv6DMSbrqYXxKdbLy7dZBbOQPErJTWhqpggoO83VNPzPybiL4DstBV9SjuLD3qwDTgsF8J2oOdekfxBdH7ydXzmWj04jGo/PcqyfS+poTn4nXaePB6s0pD/tFQGR1xOgtNlDrd6lAdGTJuYD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfqqfKq+p5L47STbaiUShceGluBUv/TPjceQ6WfftIM=;
 b=QxsFXlnozdgYE1p4XmVKn8783+vx3jNXL7f3ZyE1lrW9anYOYoBt2CTmud1bX+5OVYEjjrVEU3yzIDod/WkIoFRkUiZwAtfB7dJxN6xJRyn+hnPPJ1u2XDNFJMIoreRwycL1wHx6GVaXG0gDZISynkH122aXCd4S4SGCXapiPcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 06:30:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 06:30:42 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 3/3] ASoC: fsl_xcvr: Add constraints of period size while using eDMA
Date:   Thu, 29 Dec 2022 14:30:09 +0800
Message-Id: <20221229063009.2396716-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229063009.2396716-1-chancel.liu@nxp.com>
References: <20221229063009.2396716-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf28895-f001-4487-2b87-08dae9663551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItHFV4CRocwZ2OYoA3PtprqWOYuVZuFkjUOr+NU7PS82gb4abM5+nZNBdwdExL3hrnunIJOyl03uxjlPlS/Fla2yy2KYFCmgbjFZfsZH7l+gAQ3LpvVogneGmBvB8A6E080dmjiuZdBmuPrepnfNV/29VKKnwM3T0N27phpGeRctPvVNxE/QVJTUZEmIoWak5Ce343AORTP/UeCgS8DIrrMwg1VMNJVu/9kxYdhhMnCATpjwnrCkrpMd8+z25moGWhM7y0JN1gpLF+gAJ+kUi35FPRaed2Xt1WXl3QNhEr/cglEw4JpiLXNB1wG80zrKGlnlB8Mj+LVY35FOBnSQGXMsSuSw3iviVd2fS6/uCYeuMtpBAInWRF/rllvCFLg+5PNOmjm8a764hv+bP5gTBWwZI6nVCVwM9REbQG/VuidS9vKGg7KzbLULqlHYtjS3shlI3r85gOqivMi6Ly0jqJdFisnvQ/If/f6OKf+WpJMEGICIQHt9KddZBFYNzvQKvjC3owiHucrLvAQ6/4U/tiU+KK0WEMzx4uSqaOh/GRrCW2bcH4k/2QPZTxtrH1kwVFWiH+yzsoEKxJP8IKdg7IOoOF2IkMeTno/SFxJ8K3RR/lw2jjBU0Il1g40o7oP/VJpw+AJmFPKBHoKeNlxJOM/tg4WUuWA8qOS9W3VjoL7g2QygqhzuPQLNcEjnpE2+2wx6+xr4jgipTgm+1tMdZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(8936002)(8676002)(66556008)(66476007)(66946007)(4326008)(44832011)(316002)(2906002)(7416002)(38350700002)(86362001)(6486002)(52116002)(478600001)(36756003)(6666004)(5660300002)(2616005)(38100700002)(6512007)(186003)(26005)(6506007)(921005)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XwUyp0vqZUecVTL1foS7FPM/iTV60IVyOl7UepDfdMHU7A4b50tg2JAI648Q?=
 =?us-ascii?Q?28M0nWa5s4e8RBGBq6jmd7WtOvqh5iKc1+PiGBWpixvDDdZNlHa8+9jonT1E?=
 =?us-ascii?Q?/RPyDE5kOW8W+kU6LYJXj3mW6lBVtAMsFCa0JhNMa0sAw/sz2u0J7Zenx3FZ?=
 =?us-ascii?Q?SgOD1vvobSG6+RQ0d1XmHfZA+8M6ELjyfKb1Bs7SjuyLaIzfqNDEJph1lPqV?=
 =?us-ascii?Q?sL/KcxrMgAHqyJBx55o8Aa7+wo32L/NujSdobdZIvBnwCjtErrhPv1lvC3Qc?=
 =?us-ascii?Q?VJmTM2MUjdBi3yqrCPqwhSIP9BcS/vg3YHmnQKBMsj8KoozKi/Jm9bQJMERR?=
 =?us-ascii?Q?8nWZVIfuwAnBGmv9aINMqSWYmmDOjxk79Vt5N59aIt/kxKHVsDq9M4voCL25?=
 =?us-ascii?Q?P084/yzZpnO2y5EMBI+onUgNE3pIFUnj6SXC2aVFPWQiaf9EL/atkph5Qa19?=
 =?us-ascii?Q?dBXsJQJPy2rvrIRN/l502La6qDGlxg5WAFguyLT8ltMQ0GWuwe+QWKmy8csw?=
 =?us-ascii?Q?Y8G+g/NWqlP5JHq8WKdUoV3+0B2/dItiPEyMmjkNymjknw/Kc2Z7Bhe581ld?=
 =?us-ascii?Q?lNJ6Thxy1C0m214EHZ5+gDkrHjYiwpV9ThlurbT9fGBEMbt08buSA7KqiBS/?=
 =?us-ascii?Q?NFs5vLiLNw5tQz/XJaVF+756YTL6tA6IfjufX0jwZJUYclPF7t1Wq3qQeLNa?=
 =?us-ascii?Q?vV7DXiBLQbBTKVgbU1xVAmzwoRyv3+S5lHhkbQaOJi2UIJhz7oz/s+wlvEl+?=
 =?us-ascii?Q?iSKs+qrYy84Z68ts1BB/08UIlXaA7Ua8CDyBuNVT/qjQabGXb79fpy53+BS/?=
 =?us-ascii?Q?YGPaXTp7A/XSDwXecBMBC/GgdHuaLEbFrCtAfs7AAqjcONlyxpqbltik6A+X?=
 =?us-ascii?Q?HqWASGjXF+nWxN9LxwuFgZuF5+ZHszkGllloOZ5sqZIPq4sRQWA3U+MqWYD+?=
 =?us-ascii?Q?2fsuJk8PAw3zyBRzJ8DBb/nE6Dac8Nhx4LeWv+qZ5LxHxYRCFL1H56Zi7nDV?=
 =?us-ascii?Q?dMPcwKqfjo6hGw0Pb/fBPqvVnqNlqBz5nEXJAch7XQCgDHdk9L2OGcVMRK9w?=
 =?us-ascii?Q?fvWHMCw15wIZWos4yOD/x/a95zPdWR6suXIn3FtD1wtTWFpf6xNmRIKnmuJO?=
 =?us-ascii?Q?G+T3dkLu+StC9XVOXqQF0RxPuw5S1cUz6o6876gPAYq+eNXwC/OPihS4yng8?=
 =?us-ascii?Q?V9OQnrjEn5q5A477fc1G+V6bsIJXwHviT+xILPI3XEszvxryjseLHeKCSD5K?=
 =?us-ascii?Q?LxFBiMvAiWtyobijnKXkiZGvcGjcjdBUAtOWx2ge7iP2byL/I6veIFQGS4ZM?=
 =?us-ascii?Q?rojO6jZb/GltEPUgyXn9wzCnpzOEZz/0mKL8IZ7FdcuW0UcN+Fa8XO2sZMJI?=
 =?us-ascii?Q?qTOiac+9j6mt4Bftrv7ThLVm50kMaQ1E3ruQy+5CHX78KIOIBYHN0G10YzL2?=
 =?us-ascii?Q?hn7RKa9Vbnco42dUptVuE4jqsZoGxncf0E2qH83xRVRJdoYcuQc3mPz2/ONF?=
 =?us-ascii?Q?0JgzCdbgckntsc1oMw6dnrqZ+Bgg4pfSbWzi2gyWgtZpdWDLAvrozgZb6Gvn?=
 =?us-ascii?Q?6QJN/b7HwmkTA/RMSLmmrECRWc6xC2fjPGVO9wN2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf28895-f001-4487-2b87-08dae9663551
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 06:30:42.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8x5LKoU0BhMZPe7iiNk8id7cGhETF1PWL2sJ6pTl93qnSccilwX14vSfL8qiwUOl+Ja+INSsKHuSiB3s79slg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDMA on i.MX93 platform requires the period size to be multiple of
maxburst.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index b794158a7876..2a78243df752 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -22,6 +22,7 @@
 struct fsl_xcvr_soc_data {
 	const char *fw_name;
 	bool spdif_only;
+	bool use_edma;
 };
 
 struct fsl_xcvr {
@@ -538,6 +539,16 @@ static int fsl_xcvr_startup(struct snd_pcm_substream *substream,
 		return -EBUSY;
 	}
 
+	/*
+	 * EDMA controller needs period size to be a multiple of
+	 * tx/rx maxburst
+	 */
+	if (xcvr->soc_data->use_edma)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   tx ? xcvr->dma_prms_tx.maxburst :
+					   xcvr->dma_prms_rx.maxburst);
+
 	switch (xcvr->mode) {
 	case FSL_XCVR_MODE_SPDIF:
 	case FSL_XCVR_MODE_ARC:
@@ -1207,6 +1218,7 @@ static const struct fsl_xcvr_soc_data fsl_xcvr_imx8mp_data = {
 
 static const struct fsl_xcvr_soc_data fsl_xcvr_imx93_data = {
 	.spdif_only = true,
+	.use_edma = true,
 };
 
 static const struct of_device_id fsl_xcvr_dt_ids[] = {
-- 
2.25.1

