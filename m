Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794F6A2FB7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBZNHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBZNHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:07:43 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C63B760;
        Sun, 26 Feb 2023 05:07:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNs8eB1FaLm810vP5ibFWuCJAHFUwzj25N3j3OZKqCoL/TLlfIpTBX8rQNpLQBS8oH8SKbJ1UgcdJ3HIcQGxU7UioRCaOAc8tr3zq9gbjve2U0hRswFKL+wU5/x9+QA9uHgJ53X4i+a2Smtj8d4bwCiFuY/3qFsF1A09b5cf2SC22h+lc3SH+3A1Tb2NMUzSG+xmMzyjuCd/0Jk37mmc37KZghazsPyzIhcVSsb2XzqO2X7K8vFoGgoNvL5vqMsqb03z8hiTMmoiAHpHPRINqt8RyhJP9jha+SXnt/q0iD4/VO9Hh/L1AIiEmtMpD98ERPF5bSWvtV9bQbc9/6rv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rag+zOPnj6/zARi7+95BuQXfim6XrsczTr4CapuVvI=;
 b=RESb7B28VXK+mtfNyej8V/hXmgZO5YoaJ0hNCfTsErI7s6GzOJQv3RiBRYs/l9qEqsBoydUNKGHLleEFbLAITX+BaRZrZYPFbs2WWbkWdfMWp4va5NZMb76FXyJ35qpIQHzJ2KXGO5aLF5rL0WjbWd6b70V4TXlqXX35XWSi2A30feRh0HXcSNJS+3vGd8oVCd7oMBMMbiRwveEqA+qH21G0I226kkJueMNcGV0c08kBXEeECcpNsFPsgdl/bfCOT9oWjYJ6m8ApzeaYhZ6KTRkzTtX/rIQG9fF3T+k1l6NtHY3mzB6s1twmSt7vXiLAX5j3ZmmzCICR4CMFAOZ6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rag+zOPnj6/zARi7+95BuQXfim6XrsczTr4CapuVvI=;
 b=lwEnTzNZ52iBeSELpqBJw/bQOUS/WoijIglrYpsm12JXA5Zz6FTn1BYpIbn904G+Wf2lBRRllQGlJOQhZkaKqytr2k5tMiU1VPqA4Rxb09oCiCvpTIL+0V1f3QVx4HaTqrQLBO1okW8QyOj6qPj4Q+4ipjg1Euly+XOAeaOeaPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7962.eurprd04.prod.outlook.com (2603:10a6:10:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:07:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:07:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] ARM: dts: imx6sl: tolino-shine2hd: fix usbotg1 pinctrl
Date:   Sun, 26 Feb 2023 21:12:14 +0800
Message-Id: <20230226131214.278911-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230226131214.278911-1-peng.fan@oss.nxp.com>
References: <20230226131214.278911-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d0aff5-c64d-4df7-f69c-08db17fa6f75
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fNYic0FAIBnbGeSOeB11DbsUMOeXuHc/mq5Qpch3Lq3v13aqu8xR98QxuRJp0fLxT8XIHYfSyeDWjLioCEWfDUqb0Cm1LxmhEL6rv4kxMPcRIz/YcMbDPMLQVzRIcerozJknfNDT9s3wRIZdIS1xpQJAV1CmU4wMbldWnEgPeljUpQFCXdSVfZUOajB1EnuHWk6RW6j4af4X3ygxsxrT+FE4QWB7Ffo91RfutkfVw3dsVGOv//KBw1ND8c9u1E+dG8f/MbgM5IfvMo/OmDWNWEgC1dKsWgPs6o3OdFZrwwJsKPPzD3BZzstkOBx9sl95+j7u0hSgAGVX2qU/TW5pqe7LNqrKdt2LwjqrPkoqCXkxN7iTmT7dqe6FUf4nsdN3wDM7ri3ukC1JdmKFTiOco5iI6JBTROFHpw9Emw+IXHMtY+slYbqs7n30x67pW3/cxPJN8BucwFf6ZVKXLNZmQHUcFOxwK0/Fl1Y01CtR7ELy/ckt53Un4ts8NVqSJRrw62D3apGFTYiq3IorG/EpVQEhEbkpDEuY0Q64GHfkJG7pORTnT5QuaCvgdixpKrYcQQN+kcNs8nybC4LPGoJshCoX7+flIo5+Ucmt44Snkxf9b2F3AR2O8a1CzkHbyVBW3Zo4ARi+5t0ory3XykcyT85X1N3ohYLCuuf83CLad7uOqik7ZaPRIooGPZM4XRXM51VWJgeShXabnuR4ShZjDvFZpnfUuPbPHV/1gtT7hE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199018)(1076003)(26005)(186003)(41300700001)(6506007)(6512007)(6666004)(478600001)(8676002)(4326008)(66476007)(66556008)(66946007)(316002)(6486002)(52116002)(86362001)(4744005)(2616005)(8936002)(5660300002)(38100700002)(38350700002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MzIDx7Z3aLwirwPEeFnPwvNw3HHQGCnO1GRkY6CR5dfmShZrOjG2PkDlK6OA?=
 =?us-ascii?Q?+HRn5m6b+si5VFVQLYaMH4LOxcKPvJRwM9lXBxQDU6JqgVhspZoO4LFNZZat?=
 =?us-ascii?Q?5CXoTlUwdeYoRKO/Nz3cQ757eUBi4jhUaSqx4dFvn4yZbG8SnAacMwYFFczo?=
 =?us-ascii?Q?zXzum9Irk2DRg5aJjsACCWvcnkYpQN7bWaQs3syrXC/ePVNDDMAEkMJ29DZe?=
 =?us-ascii?Q?gciqJD+wjsj9F+30+ZGdHq0et1U6I9qEM/7dqUnI2VHvbuLtOfn0mPeYN90g?=
 =?us-ascii?Q?5osDA45G8lWWE9yhmwc3pjMF2OKBKvviQGQi7Rcs47ka2FpYsveMYtph8Ytp?=
 =?us-ascii?Q?ZNjHFvPr+tBaz2s2TZxZKooaFKHnZnyGBT0axD5ZuiCkOe6opHvGIFUNOfoJ?=
 =?us-ascii?Q?QUkEgl+QQCSjezMZrE6jzoZ0yYY2pE8EzslJERqJTIOP5iiiolew/05SX6In?=
 =?us-ascii?Q?BtT3l79DM0DzvV2pso9qciQOBQUh8BigNsgijL30oCq6z4v9F0O9wp8S5q/M?=
 =?us-ascii?Q?DK369moNGueADq6SFefptdLCuiPJ8JeVJ5qST4oFqOh8zcOlPVZV4+mtHjTZ?=
 =?us-ascii?Q?DHLd1VJ/vyy3GDBRF1TsZ4EAcCLnPJK4gOIJiVfta2PkVkOZYnI3xbXLxBII?=
 =?us-ascii?Q?k6/1MSVgz4ri8FLuof1LdiBH3QkCc4Vxt2txF64dOWyvWrzfF5Likyn+NEfP?=
 =?us-ascii?Q?G0EWvJOmpvbOTlIKq6ZkMVdDKVow37qutYh9SrD3VL5/f0Tfmgdoz1dg2Azv?=
 =?us-ascii?Q?pxjIaUOAS0V77ePtGYwr0dCDjGBmt12+qVDBw93L49jcSCNGQg0dEPnq1a1p?=
 =?us-ascii?Q?Dux9uclBTX10H7jNZkLUCNwLF2hIpEZWJ4Jf7bT78z3wqeEo4nX59VTuy/Py?=
 =?us-ascii?Q?efPDbJYQgeLZ6o4ckqeZwDTIi4V48GmgXub3q2qgYPuOiUDlGdTOvVo6r93a?=
 =?us-ascii?Q?MSfCdx/kjbxjQ8ZJtB3Pd20P5cR93asLqqeFhTJmV6sP0Y6Zg1fuSCwuryzm?=
 =?us-ascii?Q?nenDSPbzJI/ZYwx73cOSmodJIeNSvm8LncEqnDQ1eRjl5xcFT9eJjUNES00p?=
 =?us-ascii?Q?V5Hgx1QxQXMlsrXSiikDGs/VdreD2rKJdism/MEgK0L4Cy2OtxwAMVblW+kc?=
 =?us-ascii?Q?0NUUBbc78yukZSxShH5Ci5XcZ8Iy6KgQwXpi8v6wjcr0HfhdBpPlb4af16Lu?=
 =?us-ascii?Q?8cJfa+r62hnmKzfa0UzAK2Hj87VvO2kGIBN6LJ1OywiaeGK/M7h59oe7SpYA?=
 =?us-ascii?Q?RAHR7bSUj04bHbRMK3x8Ae7a1KLA4DrfyO2uOfJ78JDgL3qLFa+nXC+nWYQQ?=
 =?us-ascii?Q?wjRXtsq39X3liwvvNCj0QFspjjIB6lhP7C7V8ui0hYaXPSRxQ5sITTEIcW2O?=
 =?us-ascii?Q?J5uafakFgVwGX+zAbxdtoHK+lKJLlFPkpPg73IqZFUPsAvtAO+rLo75PB+GP?=
 =?us-ascii?Q?UZOaDHTAt4tms7olheFt1K5+I5Jx5jymQnj3Fb7zi6hwoHYJntELi2lm1KOo?=
 =?us-ascii?Q?TR4RUFy5o+S0tNp2tkNr/P1cELlPHhOAAZmU2xcJvb1NYmB6YFjDuIYZHiWj?=
 =?us-ascii?Q?rok+ia4Rzfe5XHdCAmf6qJqSFEUVaPvmcQs0nJlL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d0aff5-c64d-4df7-f69c-08db17fa6f75
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:07:38.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTxteiznxTlvl0Chd1x67k+sDxzmshch/Fc+2zIUcHJGFWtTPWkRkTqVVrzaPoPL4Qweie+zNV22AfdVkLOwsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

usb@2184000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
index da1399057634..815119c12bd4 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
@@ -625,6 +625,7 @@ &usdhc3 {
 
 &usbotg1 {
 	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
 	disable-over-current;
 	srp-disable;
 	hnp-disable;
-- 
2.37.1

