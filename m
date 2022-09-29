Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36E5EEDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiI2GQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiI2GPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:15:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3512579F;
        Wed, 28 Sep 2022 23:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEfHmwuqoJ1s0poR2d85881cZBPqWl+vRCgrPO15qRUxvJI1wbIzD/rgCEndLo3d8l3WroMkn4mab5tr4DZ5Pcyir1T1MIjNOcaFEFUVeqGEAvvB4pU9rXk9Tc8sb6A8sZqhtZeJLXavTppciqYct4TqGrWF0pp16F82teHB2IOvpDBNpn1/MubsshDnGEfqwr+u/x3rSzj+1mHPVr74z2mzztrfxFE5Fep5m5HKJCcqFD6bSA1V4z8ePsw4GoXFrWjabAKKWuihc+xiIGLH9aRen/pgJCzqeff3YWqKNdWt2OiIa50Qjcw0sbaiczsZVGgfg6CxL0V18ETNs3JxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYRBLRGVmW0aYEp0yM/gTOlzfxHZDMvloKUpivAqNLM=;
 b=e14EUs4Mu49POyIKWShoBNAToFsw9ZBs0vnmtdvJjmEMRMtvK2YtnJKtkE1tvQu37yhpHpQiIz9P/2XD+xqLfOrf7kZVhe5gVXVrAtekKBDL2H0L3kgXNAskHEa1a7BgRM86LTK5EnRBvLfG9+/HaYF1CKdhog/l/54uxads7QYHDn+JlfwxkmeuPkWdAFc36kiQyGO/eo8Oug1UOzezXm5qD7z8lOYQbGD/sd3tOtR9xKkIdcO7ROkQnaFIB68oc0ur9KwswfzSEF+jec0JjjSPSTf3+zkhKHBvy34UPjy3qTx7lNbtRJazzVFILnwA1xYn3P22gaSyYK1BIM1bmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYRBLRGVmW0aYEp0yM/gTOlzfxHZDMvloKUpivAqNLM=;
 b=H8lRtMBQkl1pdFrks6WJoXd4ZGLg/wBzutlQ8bSVo/nrVBYE+PWG7QS8tRXqA0BFUt3T+9a0ulQU7lDXWs3CMlY55e5FduCjyOk91zXfCo8d9UygypMRLoaXEy9kLwN9Dq/BAGw30XPB4oGsiGuWb17F0BJHEV1mVyjKsTUTNmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 06:15:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 06:15:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V6 2/7] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Date:   Thu, 29 Sep 2022 14:16:59 +0800
Message-Id: <20220929061704.1571746-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e8a3eb-3158-4907-8aeb-08daa1e20b70
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZJRrTGuxu/MN9cTpJF7S4yEA/5YJSIckG3CSfP5NM6u8pN2cIXDasF4UD8DJWPn6CQPg/C5oANTOEohRuYdCfSSO/0q1k96kQCvVCp00T4G3aAbBhjdr+9GXyNHgPkd/r6HkZ8DhM8NPKSck70SWw/MFLaCRklrLtZ6YTJY4d9u6jXeh5glehS86lkFIByPnX0kp7PJRD3sZLNRfq62T3One50+Jib4BSJ+d4tzqwv3lQQg0YkjhCSrC1/lGfaPsmSTwph9/zHbaUAAUSG0b/epzp7fA/yMyJbxFMmXnTPho23BPeupwSTi1gLCtNqlcumOzu3PLVHL7zov3G8DVOXhknpDkAfcGzQPidANRk5YyF3kegWfq/Kv7w8iNba3egyHKN6xHlfpG8HslS8NwFA0ABNG/I/317GdbY5rFXR/tGVrWtWs3hYxTI9H1s7zx3X571NAHb7WcyXD0gXy2VrNYmuYzNZnHKG27TkxrKvvImz/4e0Fq9oo1NWAeUkLh1B95WTSNZccbyHmRNoh+BcT8vVD4c+kV9xph0RBmh9U/Oo+BAfCa8DLvCxlRvsYPvQpsbBuQNY2h7FJClzP06SBD8c2XwdDhLpLm+fVt4aChFkB0zT7D3VoVJ2meIQD7ziQRl72lZ2iFnVUBD8B8JcuhTjZWu6b+6GVv+6s5JmR0yXF2RzvoXXOwOqg/DkGq69CbHg4MLc10dF5ASqZmp6wnO5QAiRo4LoGau80pYcT0QxUOT+V2yEky/KFMocxByUT7+Ag8t1gTWJyrP1AhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(4326008)(316002)(86362001)(38350700002)(38100700002)(8676002)(66556008)(66476007)(66946007)(54906003)(1076003)(478600001)(4744005)(6486002)(41300700001)(2906002)(5660300002)(7416002)(6666004)(8936002)(186003)(2616005)(52116002)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XXqYWfg7nX8q9cr4pL9vU4NFbuhFgZC2wacRaJoFfx68i0DUun2TXczMc6Fd?=
 =?us-ascii?Q?CIEs1+BuZhkQd5DiNi17bA+m41WhNLB7IhpLgSdM6sSiw6Bee0XmN8vjXVMI?=
 =?us-ascii?Q?pZUGVdgaI0I76YkAQAFbyd8SChUrzsfl9Nixf/q9LXCMLLU6B04Zg/5fufhC?=
 =?us-ascii?Q?Ouuk2y5a2X+0b8U7veAybxvpouAQNOq5Zii6FzfCn9c7fAyD3UELnuW6Zs/4?=
 =?us-ascii?Q?LXUrvocfg4bZCw2pvmJDnbhB3F2ovmAzTjLIdYV0vJR/q6kQsAfGHW0mSUZb?=
 =?us-ascii?Q?x62WHs5xKQMZtcg+M3uz9GJouGbea05XQyp1BBZhz+AwKkur5cvcWpBLZyyi?=
 =?us-ascii?Q?+Bna2FebCLWDJVL/4cExlItgJHLD0u4x0Menk1/l2WGa3AVtcfIxNBI+rMZi?=
 =?us-ascii?Q?muTT68QWMuksG7yjxRN22QlvmBm1vEDqrm+tWl0p74fnnYCyrl8OKgZ7Sisi?=
 =?us-ascii?Q?T/Jt7nvD9FxTqcfeD0/ewS/BYhDTc4i7xu0EvIPjXYWPW422u7vD1Hg5obpu?=
 =?us-ascii?Q?3Q37xQ9DnPJi2Zlqn76yMPxqpD+o7OF3bPbumX3a1oY+bpuxK1tQ1rkk0gEX?=
 =?us-ascii?Q?daY3qnsDQCKuzv6oeAk8AsPRW/MkkaCercR9W+0ged7uh1XA7o7bI5+xAT5e?=
 =?us-ascii?Q?zUR/tX2TVca3d0gyqyMTJm/GyA1iDK6lidZ0lsCUSvXu7FRNWGuZSOAaS0Zw?=
 =?us-ascii?Q?oMaHkm9Xe1G0mg/8Avf9Cob7SDYB+xEXclhX0EZVtdt+LlacHc/hqqwaaOlx?=
 =?us-ascii?Q?t496FKkP5XOHLIPn/hzkToGOs/ZZzXqO8xdl02dpiM9/CG1ciJXNlQ9t+2bM?=
 =?us-ascii?Q?Xap7BSHjQTsMv7oGwpEI8MgZ4bCbn+dO1bYa2Ayp8yzUqZFyj+wJ/yhCsGE9?=
 =?us-ascii?Q?P2T7domqQx9Iv+u6s8T692WOnFnAr150NS7pnwJfyrqi68QL7YyNnBeaysu1?=
 =?us-ascii?Q?+yr5TgjSgIJ+T5NeCcVvYvqu5ZcJfVMUq92x6i6UD0dsJIyHrRixOu4MuLGW?=
 =?us-ascii?Q?xdrgSaF+GY3JdDJLgq9OeIt5/pds5Qf+NQLHePqD9W1tAVI/b2m6LjEGW6tY?=
 =?us-ascii?Q?tulaoR2IwuNj+aQ3Bf7dVDFWWPHnlcvOeF9uRe/qGDc8FiGpQQ3CNy2NOFB4?=
 =?us-ascii?Q?8WEftF4eJwdqF0djLA0D5qVbMVTq5i4cMr+ylMlJzCagw7tFf+5qLzo5Yi/P?=
 =?us-ascii?Q?8KiZc1+TE7fVlRv2Emwu9xOH1F5pkUwwh4siN4g1jQI1hzByVbUlqz7K+Ech?=
 =?us-ascii?Q?ArZRQx42pqS7HYLl7K+dls3T+k/A4FMZi+fK2a6Ib16beVqaye4xcYL5uwmW?=
 =?us-ascii?Q?6tmSup8WNPyp1fxlZYiHKgfO+AOJ3LU38tbKhYZOpDOp+J8l9Xn0K37TZRHV?=
 =?us-ascii?Q?SXr6/b8aosUM/7aLa/+mrGOoEU2Rhryt/a77S2Gk9LAieFUpPAJIHzuD8fLd?=
 =?us-ascii?Q?Pa3cJEYMoNsRkhlPoECHKJPqe6fkdRNpZTezJ7dpyUCOZTaFU5tAr83xXcuu?=
 =?us-ascii?Q?DDMSPbTk6ak8qaktNf2d8RHrnHe8E40ps9McVW+2MNBOvgZuoVNnrgpDYoxP?=
 =?us-ascii?Q?km+9hcl1I5UfJjF97TN1Ti5nbyIp1kdeJKUK43I1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8a3eb-3158-4907-8aeb-08daa1e20b70
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:15:45.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W/VSSjKWqkoYaBoyBB/ieCDpWDPdIQkAkahhtNwGyHNNWYFFaD2GvQaIvHoY9TayL5MBOMrgMPBvktFoZeo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QM compatible

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index 70322e57b6ff..64e783234e38 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -23,6 +23,7 @@ properties:
       - fsl,imx8mp-cm7
       - fsl,imx8mq-cm4
       - fsl,imx8qxp-cm4
+      - fsl,imx8qm-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx93-cm33
 
-- 
2.37.1

