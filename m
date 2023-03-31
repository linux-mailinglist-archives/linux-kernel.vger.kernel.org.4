Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1203D6D1777
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCaGdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjCaGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:33:30 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB543EB76;
        Thu, 30 Mar 2023 23:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h54spxVVyZxIyd9SDYJtg5+coIiFm65Un0EIV1mjnm0LK3quOx4jbSaVsg1rutLYvAi2GjjcYP7Q9IDcgrB9dKeaGumGLpkDndnIz3jxULLBr6kriiDM9Vk8UR3bHdMZjsKKi4DHvsL+AUCPZesPfuLP5UOACaXRYzEksUsiveexk852ChBI4UgHvzasxUpTTShTBd5CqJrVECDmLxdSZzdfRNvUYv/lrMz7ZCu6CoEo33CJSSKmkFJD4n+N2RAKpczp5h2PxNw9LYYez6L9Ky1R8tKYg57AOW30ipVLYBPiJfI3QMQgcRaeRqblU0s9X4BFREcJregUb1xZ9yYmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjnMQACy2BSOf6Igq6IXExV58Xr6JV+uzip0tl+2MMA=;
 b=hfTxoOUGcWZ2V80Il0OXTkvgsRvy2Di7EafVcppwhcrxhCea4iPwump6k5J8kPLg3skPELU6JyXBcDkEa5laZsybXunyYL81uaUiMKjqvRl9PP2c30sH7nxW+asDRgcmDuOvYdV4I396/06/eujZvrvK7VL/uJVnq+Rhkv1wixFX2bmcNobimI4PjFgpFM++tEBNcqpQOx5lzdu2FbUqrAl2QOc+BHEPy6u4FU0d8R7LUAFC/2PNGkVRZ3sCbF8l/eskwEz71OPxzZrugNLeyeU3ZMsUdpwY5vXCDt8h1kfcmNkmyI1Cxs+HmevI5L/cR/JUBAU1REgXjiJiKcfpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjnMQACy2BSOf6Igq6IXExV58Xr6JV+uzip0tl+2MMA=;
 b=B4+jpbgf6x4I/FFoJUqmwZmyls2c5Fpg8hg46amKAFbOzIH5H8uW2EfSt+ukfMMbYujbN4aEq25H5Aeux08b+ln1410WYswZ4W7Az/r5mNvMtdkktDbaU00W6CQTVKR+xj2Xi9+mJLXRLc9GveRG81VOVTwH/teNA2brFX/UIgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9875.eurprd04.prod.outlook.com (2603:10a6:20b:652::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 06:33:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:33:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] clk: imx: imx8ulp: clk fix and update
Date:   Fri, 31 Mar 2023 14:38:09 +0800
Message-Id: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: 438445ff-04d5-4165-8794-08db31b1d48a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXlw9trSNjTL2SpwEc2kZ+MWRnKg4oXBUZgOKlbfVgb+RKiveqEDGqT5drjy6GFOvqdHzeSzlqFl4c/asNfVweuyudouOhqwNfD60mL/116itB7wo4ci44HY54AoArdtNlbFZ+6yqtBvd83TXgNQ7ZY0XZ9TulH9/DASWHR2V1EqxGHRDOFN1r76WTcY7EsT/hSNGBPIQCxkssG9U6/3h2iNceFm+tw3Jl/YTGjRufQ8CE8IXxwjfjaBYggK9Bo1WV30zawoBc0XHtrVAFBJFQA9SsHgc7SBFLbTdzRRPZMzIHo42XAH5htdK8GhbCXNgDuS3LIB6Fa2jzqZ67UOu1THeoxyqvvTSBZscWoCq30hFJR1D+PfvSAuucLaRjuBKEr1G4iJT9ltPYb3h6oqVGKwwZXhbqTSPtco2JEYvkztnBD0WzP4ggeQsrxvGruVuZ5AIKFCwgpoaMq4Ng/GIkvIAOSyRxpYCl6xcN6THlGsaGjMSfsprPTY9u44xx1dm25p5tM9x7/LGEOMBzvBiFlgfVQEa5ou/hQ4ZmFhm3ruMmGH9Jz4oJtNFSzV3c3wvNUEMTWXW9BH6/Mx+9uLclSYpIGcIzqiLlqFT8enqz2ayGXzdxFnlY3w8CugKLvH+M25SExyJqeaIKgu8DnZUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(1076003)(186003)(6666004)(6512007)(6506007)(83380400001)(26005)(41300700001)(2616005)(66476007)(66556008)(478600001)(66946007)(316002)(38100700002)(4326008)(8676002)(52116002)(38350700002)(2906002)(6486002)(86362001)(7416002)(5660300002)(4744005)(8936002)(15650500001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2tLdEL89z45dvjPEKtJpBZToCWrj/WI5qwroI5QJsZSOMwgvnzPBBMi1GmW?=
 =?us-ascii?Q?rebtYmeot/MboM6vjtEXaoGqLVULDm74eaTT5phPboysFGYbkcUajad3kIy9?=
 =?us-ascii?Q?DxwuY1I2ga86qbZ8OxGHN79UZ5C3hmNtwk8IOtXYz/IlVP8tgwskky3Ue5fI?=
 =?us-ascii?Q?PSy6qWq6a3X2cjQpWixfbCLvJ0UFffYrq9B7N+6uXhnj3+D8TLif//S7QQ3l?=
 =?us-ascii?Q?TNikl98YZWjvZC0zY+Zeir2Zr3/yVEi1hRggwUn6L8ecbaLWkgMInUcXENvm?=
 =?us-ascii?Q?5lANLxcYR88eZ5gkRm7tuY6oXHJ9TgWCJoZM6hTeKs1V0OCYLYxtvQIK8kpF?=
 =?us-ascii?Q?uPP8UaHJ9W4S24lO4zjgYCch5bdfjvf1kRpMeZF9gSwrcuukZp7rBvOlVseD?=
 =?us-ascii?Q?IrjQhXe15g/JPCoYUEHmmzcqeqQ6n78MLof9UIpHAWLguj9XmeD0caZoDNbZ?=
 =?us-ascii?Q?zHttAdn7sd+jkW7Dl5H2r5NtPPT7nEVlXRNs5np3C+T5ATCnIAmnbLLgspeW?=
 =?us-ascii?Q?V6gyFK6YhbJEWjc8n44ULzsSoaOlLSHPmE+CtHkx3Rqex+TidfoYaPiPkBrY?=
 =?us-ascii?Q?T54D+GMH/k2PRHD020BzztCY+fai+ER0MW5mjDtNlRcMiMN3+htt7NkcT+XO?=
 =?us-ascii?Q?YD9dirdMlXHOKesSZK36y2YutAh1sb7fOL9OnFBnvIfk8nrfKRCo5URuQHGJ?=
 =?us-ascii?Q?FYDny/wnG+wFSLlPqeifa4bdLVOphBDPVclYCufpuzhbHdcK9J7GcuwNd753?=
 =?us-ascii?Q?eVLOdq/XRbhtRcqL7pXjQfiwlsBb464Fcdf84isWIRZcyI387Xj4im+IDXff?=
 =?us-ascii?Q?oKAJUVCerpVbrXNKh7V3OHnLhn81+0P7qQeb/PrQzAfD00gfNnVtd/EFBNDO?=
 =?us-ascii?Q?rA0TeOeDzFBSI8f8GEHkQeoa/QM/Y6YeYbOA0Tm6eG7/blJ+DhgUutmO8IPe?=
 =?us-ascii?Q?vltAvkOmBFWgRt+78IdOByY8moiD1fd+aXJ4hjNbPUsfZv81v9U24qt8uu/W?=
 =?us-ascii?Q?2za5xlo1LMyg++Z46SYs9e7KcBtc60vLCHGlW8qbnkYi2dgRIIRs3i82MXdF?=
 =?us-ascii?Q?cZFRpNPHkXowEJjMA6vbpLXxwDjoIq3p2B820Kwt49sZ+W1zGEyrGBFnDtp3?=
 =?us-ascii?Q?apXgH7bC7O0dwtZ27MdFthGIPCcBJl8bikVmqdvH+PRsJVxHtG+KAY7VJm7Q?=
 =?us-ascii?Q?Eiq1mnQbkuRhJZo6NOmu9k3jDYYF3h/dHz0bRTDDSsNXOMALTGTXAhmg+L0/?=
 =?us-ascii?Q?sdj+NVosx+39MBFjr9v0p/LTVWDH/HQjTPK4Dd1HcOQncQNNLD7n+KyVLFHm?=
 =?us-ascii?Q?8i6hNQUXhP3w7sl00AUpNUkmEEqwMsj9dBxzIIu0oElfmJNnTQNUsiD1Aqfw?=
 =?us-ascii?Q?9zuKMVjqrBnRrb6vxLCwp/zex+PT+oLFDHsd6YADJKArEwHaGIu4VxjA0CD0?=
 =?us-ascii?Q?iwsEWv4bgfuq5E5IQBbP/x984bC2l+MhlRO8DBAhCbvBzwd/jlfyKG1MOJLl?=
 =?us-ascii?Q?XPjIT02lR6YZSHVD0AhV/rDLMdg5WzBKue6hgkGwMso27n4WYScyGwXWmGXd?=
 =?us-ascii?Q?jeNvIoONPFo/p0lBrQJoEiFmNEKH1/NAJT0B9/X1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438445ff-04d5-4165-8794-08db31b1d48a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:33:25.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yke2rKvDlNNOSlOZ893F4KW3j35RgX3mod2dXvyPNLsCqSYGxiVlLa1Nr3Kgd+/SvdW/Xcv/WYsP0bGfa6f38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9875
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Patch 1 is a fix to get correct clk rate
Patch 2-5 is to support accurate clk rate, enable MU and TPM clk for
          low power, update flag for system clk freq change

Jacky Bai (4):
  clk: imx: imx8ulp: Add divider closest support to get more accurate
    clock rate
  clk: imx: imx8ulp: keep MU0_B clock enabled always
  clk: imx: imx8ulp: Add tpm5 clock as critical gate clock
  clk: imx: imx8ulp: update clk flag for system critical clock

Peng Fan (1):
  clk: imx: imx8ulp: Fix XBAR_DIVBUS and AD_SLOW clock parents

 drivers/clk/imx/clk-imx8ulp.c | 34 +++++++++++++++++-----------------
 drivers/clk/imx/clk.h         |  9 +++++++++
 2 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.37.1

