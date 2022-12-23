Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9227654B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiLWDCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWDCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:02:30 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3286BDFB3;
        Thu, 22 Dec 2022 19:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6kkJ20R7/l3TDiyrpShLTSCXosDDkQUq6VcYChaWbESCA2sGNDwFUHLzWCwcQ13fKFd7JwjGtNTLPIKyDzaIXt/97j84oX+0RFDgjC5E+MrgbACeDJi8C4QaXTp+AP5YfjaBTmpuyf98PojMu8agW6tZv3lvp77Tw1GJs2ZCxjsboTN9m7GVP2qqXh6nzT0GAG8QB2prEKoPYzt4/aUAxAN/6esH97zMyMFuadJTPFLAVRvXikZdARDry0YChy/QiLCMlVXyjUpwp3ssq8o9fNUIps0q/fstFc87r9hkjH4tdBf3xS+n8GHnExPDC/K5Wb1109aTWx/cqy/HB4eAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRoBwxHQjO6lXlyVXshRWrEal40SwuQOXcJms6FVzDE=;
 b=MphpMmEWjSHalSfkMO3JlUSEvN6leM8RV3+P0C9FkXRZW5eMrojuVLZv9RbeKJvDJUTIX3dEEFD1imv1UTl/rChaPkQyy9JjTrK7puQgnnd4K31ILzPTooeofatD8tz8PI6SS9iK5MRiw0SxykazKowuulEWHev4armG7Gz1L09rqH0bbO+jTx5hrrVcHQ9ACwrYvzMyBucX/8fQ1JP4eSmmC8L1ewsgmd7wmKHWJ+EmwEu+u6y17jOr3NaeJfcvWBbZY26gYc4v2T1wzP705aVRQwSQtrtMy7S2bi2RVfVJRKum0i4cbEMFixhlgeqTq71aOnKQmv7NlDfNCtOUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRoBwxHQjO6lXlyVXshRWrEal40SwuQOXcJms6FVzDE=;
 b=h67NIn2J9OhHvxUWAkuMNIzDz5SF81sBlN4uHeP80TdNWYH+EhUowoGxxZHP29qrp6XgVxmzNvaQWDtWJ4jDzO+bpYGsE/uAjrjl3cIDY8vm3gvtuivm5m2DXpnUWOPepFiIHBRj5LhfXPv8gMviszLo7rB2MYYii+LhLPWlmM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 03:02:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 03:02:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: update binding for i.MX50 and i.MX7D
Date:   Fri, 23 Dec 2022 11:03:47 +0800
Message-Id: <20221223030347.17093-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c876195-1429-4fb7-60e2-08dae4921e34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3YUbPLuNnAWnoE4Cy/Vfv4/uEdQmYfl7JF2jAWj6d+/FHYNxjccZp/3eg73HUtwZCCreMuaQs7o2a9H48gOZ7qj+KzMfuykPtAwVpKD5/V9vqSIEK4/fKV5pvnB6uyJ9UubH+RXP80VfHoUg8fDPXu+3Hjtl21i1lWVJoT9NY6UVoQn+qgVzkjTn3onH6i2PcSVb0aKRWGO5L0IealAb7umKPNGq6637jbSa6yAfYUB9r+4E3/cYd1pGu0n5pp8HVczqu/D5O8LDKCVmx7ITnsneBjmvW8LVc+P1mFdCZL9tZDzPMcuvULJRsd6OSiejCmc36iX9Vbcpz6bwidjLVIw77xQdyZYqAJlErGuC2XSs+LG2PljEXMKweIHBj2zBT0HHWyTmoanAUZSH+pUv/uU5/CNYAZua0M6uYFvX5zTK+Byp39ThkCkXO8po+a74GryF5rztJZe2T/CYInce8VPI2TfKP9fc5SZ48Q86EfJBkC3hUm9Kg1CPUwyGGJ1flTaPLPF3Hm79aMwUur6rm6FQM2rX6qWyF9ukj6tdLcYmJ+OzP4mIsJBUV7g+vu4nUOKg3JgLYN0NED5D+zq8QgjaOVwUyy3tihJBiEMw+/eBDpSPaZMmILx0wXl3bdTj1/JIXBCSyC9j9s+Z5z22nJVyOpfw+924MbGF329YByoqCmyoRfWLFZ7O7RR2lGH5Qpv1IINHe4AlrLT/l+qRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(186003)(8676002)(7416002)(6512007)(66556008)(66476007)(5660300002)(38350700002)(4326008)(66946007)(6506007)(6666004)(52116002)(8936002)(38100700002)(83380400001)(86362001)(15650500001)(316002)(1076003)(2906002)(4744005)(2616005)(41300700001)(26005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1ZLdZSo7Ht/tVzPXgQELCqjf3rf6DnqgaI580xnQZvjrPQC9vH2c9Z1nfP9?=
 =?us-ascii?Q?TdIUTweRF5IbhgvttNrc+USv56o2lgMn/LJIHLmd9L8Vq68/41uHzD+5t0UW?=
 =?us-ascii?Q?x0OJZW5P53T4MdxjV1SpROEhW787nxdoxV60jX+qIB+2nBc+tFI1yfTjaDWV?=
 =?us-ascii?Q?J40kFt72KWPDtNCruCDvea6juuQ2kvW+lONhtK5fEujxxre7JgV/dgk1HAkW?=
 =?us-ascii?Q?hwMQ9AsaH0xIcTEKHE5pzy10WfomnhDFw6TY2bXgoeoVBqcGi23lRxaHILKU?=
 =?us-ascii?Q?IKw2TOGqyluRHWf3BslWx/lu2wm3Kj/5UE2wyEx1yAsxDBemV0YQRAWYbMPX?=
 =?us-ascii?Q?O2Z+pGvYNdnqVoqe0GiyCDinTBjVhjTjGGcWOoVaXDSvHbi3JX6u1JgVbfoA?=
 =?us-ascii?Q?8fvmH3AFZtO5ZJkgdsRiaXxhIvRp/7eftpGI/3KuBkHn4ZkXqtOM+gjWP7JQ?=
 =?us-ascii?Q?2HwB5RxjPmMAuXc3AoZAfwH804qdr3e3vEraQbZvsyqrFIOV5/WaoAYuQX+D?=
 =?us-ascii?Q?dp/qOXDiZKn1HzHq9dvp584DPob/dez1axaCKQqns2O4RXysNc3U12GORTOJ?=
 =?us-ascii?Q?yszagg6F5gJ5T2DWQFA05CKG85mT3kGxgFubbxpuCzx92BZLjsv04tf6D2gP?=
 =?us-ascii?Q?csJQFF7msZPze+eMD3gytGWEuB6ewNtKFO+2cQr4yMgtdZQeM0yW8mezfsRG?=
 =?us-ascii?Q?NPg5agSi9oB3eFDj9kWXBFgCTaEygWXrggIKRCSDx/F52V6kjP1+znwqkRJS?=
 =?us-ascii?Q?Jfj86W1Td6JG70c+Sgt8oaEarLB9/WzDV+zuSJQBHh4WzqpNcIJUBRgdom6c?=
 =?us-ascii?Q?uPG65kjIYaUA0nC0HtmHUTlXmJAZ2IlNachfib9rRY61tAfBDYC/BypPMO0m?=
 =?us-ascii?Q?YKh1XiClWt4sIRIuWV2b1IQnCIkgpU6ILX/RNhC+KiVfXbuSCwr+7o4jYQtn?=
 =?us-ascii?Q?IEbOnZF8xIh2Yc6pv+Md5TOlkU7JluDWP6ezypZiGaAyegV1Z1s6j90bs/hb?=
 =?us-ascii?Q?ErHl/dOcXbgBSKy6bXsnjUSWY9h2I9In5eLi++CIAXniyQFQWl4N4mcoIgY3?=
 =?us-ascii?Q?3v54QlZVi0YLD75c8SG9LKPE3rfOIUIewZzX/8FiTJhixZ1t1uhp+ihg7W/k?=
 =?us-ascii?Q?pnKrv67UrBFBAJItTcpdm40O2bAU5w18zlWmuC/zl86/dbJx7db1I3HNtyzr?=
 =?us-ascii?Q?ig7FNvCffTZcaF0wdndY7JKMC/jyYXI9TpwKSnaKmd/iS6D1T8j5/0JwEIzB?=
 =?us-ascii?Q?7tcHiPff+hcUiTLeplacKTSnKp+3t8k5YTDTOZLV3NJsQygFM22o91i6SoX+?=
 =?us-ascii?Q?NGGMHMBLS4QrqaSz5hF5qLn3JU4BRi34ArTb5Ty65Z2nZogZUvapatzQeFI4?=
 =?us-ascii?Q?ukss4QHHIlktTUTukrbqfodsk4V125xqUkeiLKLE3y+itKoD7/Y7aDnGoIJw?=
 =?us-ascii?Q?t+MzWWdusVutSI8iwUHtdDvrGY/KZ78z94FeTbRrfheaLLkmMc8tk2HoTzX+?=
 =?us-ascii?Q?qauY2IUzUMA8SyFToPUxzacPJdGteaoks1JRaWr1LYoDS8tWYSSIWT0zPoUM?=
 =?us-ascii?Q?5BhhLS2siIK8yP3VQ3F+7WW5k27UVWzzCkBVQq1U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c876195-1429-4fb7-60e2-08dae4921e34
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 03:02:25.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZbvkbjlpmNkGvIK18aiVqcnceM3aYnpjriZZi/NNO2GzOXEnEvrDUEMYDgdMfDtrl8R7/n51WMry/cTV2zn+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX50 eSDHC is compatible with i.MX53. i.MX7D uSDHC is compatible with
i.MX6SL. So update for them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index dc6256f04b42..546ebcecaf95 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -37,6 +37,12 @@ properties:
           - fsl,imx8mm-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
+      - items:
+          - const: fsl,imx50-esdhc
+          - const: fsl,imx53-esdhc
+      - items:
+          - const: fsl,imx7d-usdhc
+          - const: fsl,imx6sl-usdhc
       - items:
           - enum:
               - fsl,imx8mq-usdhc
-- 
2.37.1

