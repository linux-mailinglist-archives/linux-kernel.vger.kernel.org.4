Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C52606EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJUEOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJUEOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:14:21 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4801E204AD5;
        Thu, 20 Oct 2022 21:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjnHxDCXmKVG2H0j9l6PKdEYAzQ63z77AtXU+oLHNV56P7L3p9319UTV4eiWHf5JgE2x6DxQZgdy+9GrGNlxTamqPynzyv3zA/fKcvwpqi75K9zM/n834W5oCpemsQHadesXF03EiLi9m/okf6144nF+TokpRXtqFVG27Qyq+M+TEm3bKWqVCnvdULuw3hYf+E+w3dfMGnFtn1pSHcFk0zAoFtmbL5lMOzwUpXFHbKoWWvE1UcWpy0LScBxb4zJJYFoQzDjkQ94vrsh1huIEYXcV3ltURFReggpflBgQ443KkMpv8Inif0K8gfiWNINFu2lN0jNv3NiubRWCR6NXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34agaj5t8z/WCYbnoytBz9wnHdSdG6GQDoFKZbVDIfU=;
 b=Ft3Ry4bZREW4L0D3gxm+f5EnD/M5ZiVI/YBuoUeCU/eO6nPF2pjh6iMD77Vf0xvhoa0P620vOF4TSg6ZCEWr+g39iAnM/85goD/IyQvCEf/DIHtXQkc83RIpkxfKUMIwSHOH7ZWZolntp15EWCI4Lah3S5sju7RM57Dp4fbR/mG21G58XDa1V1R/8ExI9Nw3bc6oPhDZEGXDlkCZVo/yFvtYj6q8E3JDL8lCZAXlj2OLyvCts8hohebi+sciPqrI0gUOJFCJIpXa7gyO8VK2vsEbLX7gdc4kgA4cUEcWWkW+s329PO+VbQpnKnCRAgSBiO5taMbuuG2cwVjjNLCWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34agaj5t8z/WCYbnoytBz9wnHdSdG6GQDoFKZbVDIfU=;
 b=hKkSlnbdZALDujXw+P76J0h2EpHuar8aCwxXbWNpqp+8Pp9tpcHK6R0T2B82Ls1BOgSPiviLhKVIh1Ue0TazEBsulyFivwkAXymxTd2En0SYMHfkgikpyEczrlsCgWxemmFHzDPr0nKkfs5rFvxk1eavyeUeKQl4QBjXRUXhkgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 04:14:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 04:14:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V8 2/7] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Date:   Fri, 21 Oct 2022 12:15:21 +0800
Message-Id: <20221021041526.3696483-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
References: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 7146e2f9-eb3d-407a-40da-08dab31ab4d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCYp8d+OXzaweB9fQcL+S5k/mH+d/+gvjUsAuEcs0PNTNrBSF1oJjlzUdSpKrLNenJdH4Nm9oxNQevFShtOShS0bayDB6Jtum8wghB1yQWrz0GuFNN1tmp4IntxPoG6c2flvRewkycQONLJGNI3oUrtR4SV5i5NtiYRQ4tRUzLZ937XO3rpE9l9t9YbWBAauSM5XL0tTjMKVVy/4q+ax+F6xbvYLUYQ2Eg2KWlFZ2fg3tPdPZo4G2+pENSx+7OhnP+xwfYTm2LKYUyFLknJvbx3Irgy+MPkzvJeSwRqiDdml5k1hLujDsUuns9QEOl7o88Yk+PqBXJD3YBhuvUj/j75xAHmjPFAr82riptG551i6JuvHZa/bZgUt/otKEazegNLeidAd96SumH7jRtkHoDXv9Kp4vBdhe7Q8MUDncrIAgKkMiX0V4DFyCPpuJ3NAok4elznIJjbWlHO8bIFQS7hhpTzLt4OpG6c6JASlYfnlqVXE5i2fDp3Jb9MEwOALESVEobO6PvWf9GDL+MhNhR/bMCiwazW6NrQVK41judPdS9XsnskASFsWA/gWUofrRpg5AFc5Iy1mZqS5DQ66E4/JUpUOVz75yftO6Ujl4SCIfdFglFZh1VVQDFb/8WravFuJ21HySwqLSFVLny9XZHVsbl4vgllugEUtNTuhyobbnNanvQqZ0Y2bcGMcPKv65Cwr72RUXl4cAcEBx6RFTPwKnUwUU9kgvblU1G/fxSrjP9LuFlkkGhQ4xr+D4ddpDd/SUcxc0jarOWxVwzvExQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38350700002)(186003)(2616005)(38100700002)(6486002)(2906002)(1076003)(478600001)(54906003)(4744005)(66476007)(66556008)(8676002)(66946007)(86362001)(6666004)(8936002)(316002)(4326008)(6512007)(6506007)(26005)(41300700001)(52116002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ML6iJqV9pJ40gUiG0fdbcjSWYYu1jb2EDmX4vKrx0ugUD4t+id/Wa5aHCRqo?=
 =?us-ascii?Q?uXAPEWUcjALck65UoMVltML+Ap6if9OFOiTRlSd5lqYPCJVQfzE6s8SE1jae?=
 =?us-ascii?Q?GJOSqHeNzgXqv0ItrPbbLsVFOTkK7b/pzLocqkvwsuyrSAhh1hF3rQQXizYh?=
 =?us-ascii?Q?+L+1Pd7GU5VnJMnOL/47KY3q5hnkInG9iLLuaLRwWgcAO5vbombjXw+Lxalg?=
 =?us-ascii?Q?vTyrohUgckifCVsyr0+7980a6hlAdeuFWzbVAzKqFrhtAcOLVfuqEPfjoiGz?=
 =?us-ascii?Q?BhibbXPFCQvHt61Ll0BddQQ2C+3YM9oclljeVR3a2ZJ05rRVO5Y5difj2G4p?=
 =?us-ascii?Q?vGcnpNrXtGqEBSAJ65ToGRn1XM5y6mRYr5IpaxM/+ZNkEOnWdIcB6lCdQ37I?=
 =?us-ascii?Q?/rwynn9AAkyEgbkqXWcFSLIANfMEg06cJMFz5AUcyOJUdr3nyRgQVPS2SOVb?=
 =?us-ascii?Q?jxDC/ejOPlGmuApOA3jO7fSVph5FktJx2cuN7il3SGuDCQbk+/mk1xNvEGDO?=
 =?us-ascii?Q?N9vU++6ihih2ZD2s8bZkOiKVYkZnqQ9EGdhhiKudCXvDE02dQnC2w3bXd+ef?=
 =?us-ascii?Q?Fiou8GnrqH3uZpSFu9Qk1lKjGdSzXmWP0fyLc8XCg5pYd94SLAC7GYkizbrb?=
 =?us-ascii?Q?2ESPiBaMUgiUWshEmDVlaTMAvVgRU8FxnkjNWjBaGi4KZOfKOg3+6c8YH7xm?=
 =?us-ascii?Q?Y4yNcHIlVbS4C9fMB8+JCDScN8eEpXoLMg2phCAgbXKu9+Jls/IyCKXiR9ze?=
 =?us-ascii?Q?CES1nbNOB+X6ku47Xc9dUho+61RrTm8mxmidRaFSsbKus8C0g7kO5+Eou4mm?=
 =?us-ascii?Q?en0+YQKih616qLXNy3Y9XigIOR0+1fJ9qfhTlexKr+2h2OSctFNSEpzaqQl+?=
 =?us-ascii?Q?0alwumFSMjyF2yYjlg2LJCavnQ4dgCB6uCgZs1arY/q/C95bRRFe1vuYE1WI?=
 =?us-ascii?Q?ZaoqkSMueUUsx0vEg8gS4tuWC5pPjB9lStaN9dwp2bS5LglFPqUpYQyXzy7a?=
 =?us-ascii?Q?t03giXtUOlCtK5mgrR+TLN24itpI1musyP5txX6CtNRIeC/5CP9MoDqiZaS3?=
 =?us-ascii?Q?XNGtQto4t1eDBKpP1ZW8d9OPRFpE6ofxHUBkbY/ljvkL46aAeFi/ZHW3ppct?=
 =?us-ascii?Q?EBMUeExnseCtNmcQhCjZn5/taZa4Nf1yWteSDf4r0uXEAJGq4u+opx31gAMs?=
 =?us-ascii?Q?fFnmuupIhGe38l0U8/Vchxq3mwHGW7kx8L37+YLqgmffXlKfchwHrUCwq5eW?=
 =?us-ascii?Q?04BxMksuVh8vPzbbt0szvmgz9Sudv7pOILwd2oo0OK2QIPTdLhwVAHJ65T7i?=
 =?us-ascii?Q?d3ih/K6GLKmf3sDkqZHVZuE/0Jyu6t1D+3toLhfmTntNB+Uw2rdsMPjoUnwI?=
 =?us-ascii?Q?t16GmlLtKJqJpmlu85ZvuAcmtnEAV8I7YVeCBvCLMMSrvD1/gRuCAgnt7HQB?=
 =?us-ascii?Q?rK7mlhHeAOirf1sf/Y5kkb1VFUd/uweYPmtio/p0QG4rhhPafR5E/p1Be/d4?=
 =?us-ascii?Q?X1Gz8IpdoGYjPbupJiDxIkA2gQTcrJeHEthB8Ev/LhWzb825TqMWKp8EDKyy?=
 =?us-ascii?Q?KodcJ79RHsCrar4nSREaW0EKE8eIhmyILY8gdWAn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7146e2f9-eb3d-407a-40da-08dab31ab4d5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:11.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrwZIiLn5RnhlZYvWTLRtD1TNN8z01JZ491o9plSlnoMGPcWPj8t6TNWTMoc3yTVacINQrHdo6kM1/lKNW/z6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
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
index 70322e57b6ff..ad3b8d4ccd91 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
       - fsl,imx8mq-cm4
+      - fsl,imx8qm-cm4
       - fsl,imx8qxp-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx93-cm33
-- 
2.37.1

