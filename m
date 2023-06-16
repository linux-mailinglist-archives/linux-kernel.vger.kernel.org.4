Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482F773317F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbjFPMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjFPMoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:44:08 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2041.outbound.protection.outlook.com [40.107.247.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E60D35BE;
        Fri, 16 Jun 2023 05:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jtgf6T1/aiNArO2F3kCMZM+BSBt1wRp311FjFr3+nJ6gchOOs+TJ0Ee475+xSZ2lVknKRrEESDlmb7r6YSMVwfhXxLY5tyiqUbD6060D6A2c+AAbitXku9vmtn14cF0REYRLZHzYYO5mXGjXugbAK8mTxw/FWdGvHvNFIXFrGNT20fUiQhX/yNu5hOidiOIDGc9mvNT2I/OxR6+vg1wX2T/bTp4Fb+zuO5BQh17KDl9tm5XKbr3lz1PVzllbKt/btt5dNfJ2nierLrr92SXDzpzj2woelu0x5pjyCuiDL6s2804SxbT0Vzn7OSP+Nx2dvRimh9uKVbeRI9Ls3I+rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTkaHzimDYs5V/v3H50MrtfCLaTZp9hn5ECU0FygbLA=;
 b=HZXjODKSQgziWN/IGkJNP5zQG+0BGYGvW43IH4DFZKL7GevZCEN2jenI4Lo2WZcRwIrDNaU44skYHCgMCnQ4Ju1/UxcN7hJbJ565778Xhu+NQhiFIxSYrMWn94jg5vweo6mlQLJpUSCxRdMXQEnEwmLTMhPg9K2qsOagNrrJVt+rNGvYBKQr4tZ8aGIKJ9fyTJTiA7ONg18qhxx7iREaEIzwaIOqR9AcorhVQBkrF98oiMimytkiWS99zRDmc/3tvEnNvF33tDENaOctfenmlorrgKVvcnLnrHMPkySF7ZHvj0w3XuCRIU6OplceJrcCJgleMukXMCdgDpRHnOKxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTkaHzimDYs5V/v3H50MrtfCLaTZp9hn5ECU0FygbLA=;
 b=Fd5hh+efVcCq3xjJ2EESsoIdzKeZrEMuLM+d8Zi/ZEXRrJ2neVmm4YefwmjF2y18jl0CFriUx+D3fDYRMDnQkhMm64KMRnY07WR2xZx4Drf/lth9xz+sl+ccuag2ITzb2pIpQvvN/Q6VPPAFtztv3IWTkr9TyDTlXG9z2ZxSRBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:43:20 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:43:20 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v3 7/7] MAINTAINERS: Added maintainer details
Date:   Fri, 16 Jun 2023 23:41:44 +0530
Message-Id: <20230616181144.646500-8-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616181144.646500-1-pankaj.gupta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b04227-439e-41c1-8758-08db6e67440b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsafLA5/Y31l8mbpcxTs8K0r02PqBknJw356Yzc8KzUFT+T97KU/V8rqc9JuW4viRVgfxphWNm028p5XeAYQT0eoxVoYxLrFUl0koLhCKVbBSOTJ/7Q3k2IJu1LMNexVFbStUaFWg1yFuV78iLsyww64SLMODN9G2BK8weK5M3TPn84FO1F9HpYCq4v9QGTjLMofTo49PXT/SlCXP7S2XD0t0R7kWX9YIe4l2LxmJxKnNr8LqVTO6TYLKboeVCmJtUMKy9eCc9tIvJOa/BBOGV3G+qmYxv/GWkQ8wXkoN3ANW+iCxgVgRLNombCzWyJc1Q6FEobjACvN/4GkuAW3TpflAccHocwmipXRXX50ELVlIrCA1bq+PSVnruao85O42CDdsvn3ZTw8F3W8+Vof3sr6zIcF0egUwXWqtX58KmMTmysZQhEcYmk/GsXlzGR8hnS9bTKX8Sejs0BSwZaRjQ40lniADN+KA3bbQ7wZc5oebcRnR4OAdaOgK67jQS6MyfvPoORd+G+p0NTiBt1EKQiQwbOwFDXdbU7buG+IoNXTnZD/4SFizcwGvg/K8e6Lo20060iuCdfoYokbWF9NqAGaf7CQ8wEriXSlZWTrd6VawQ2mdtjvmI640Ui1AMZ3GN1gBa/7Zyr3LOeLnmDRdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(5660300002)(478600001)(8936002)(41300700001)(8676002)(316002)(6486002)(52116002)(1076003)(6506007)(7416002)(44832011)(186003)(6666004)(4326008)(66476007)(66556008)(66946007)(26005)(6512007)(2616005)(2906002)(4744005)(83380400001)(921005)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WE/iXoDg4A+YEavL7GoyUynxFwAjRFsvewZOydQpuPTgqDLs2A/gEnyg8eRS?=
 =?us-ascii?Q?nLNLC9bewuC4zrhOk6gi0VVZ6YlhL7IJ9jO6jcE3kKuKMTP8RQpR43pBKmYX?=
 =?us-ascii?Q?zSL8EItsxsJfIUzAUGrN5Mld8TDYqtC1U9UPI+QSnp0+tcmGHkpxVdoIbU9a?=
 =?us-ascii?Q?exHaYz4GEEZLUyvkLoduqV3S9Ym+1FWxi3740sW8rJXujsROkoWiiFipFbxC?=
 =?us-ascii?Q?0JWPdS2STlwgImpcCVFlwdhngJe0VowUdbNCv/PosjFAaxs/wOfHVB6wgTDU?=
 =?us-ascii?Q?yN/Rzpdt0dX6UPiQ6skvvS+SLnryrmKlaxT0xzlTG2zTRwdSbkOetFtYtzxT?=
 =?us-ascii?Q?HrHRMroJItu694pn+kPAgCDspd0GlbkdqnbsCOfinZ1K5YkZOjs09cp1Cb8i?=
 =?us-ascii?Q?Nv7uQ1q69FOAb1K2ZcqiLZVqR0hN+vn/r+qZtVZcyhVnEuhEF2Bp6ubDNazz?=
 =?us-ascii?Q?DmYNFHRtqNUtasBarVY9F002u6UCLh3hlgHNv4B09UmtuGZgpk4xKLuWW2MR?=
 =?us-ascii?Q?ZlqDPG/6EUvbo7Gl1hJwPTBaJCyPrK5qCgonXFbDezUcffW1had28pgb+6Nz?=
 =?us-ascii?Q?W9F+TvWEV+ICh8YJZb9dL0mIzFCmV6K2tPVa9Tdqju82+3VjnKnb9h8GmAuc?=
 =?us-ascii?Q?W2GdjbSMqtSDWTj/NB113AN1UZH6yM9xQeIXTpnmtD9ZsOrPCf5CBproSles?=
 =?us-ascii?Q?LhjWmse0dxNPJAI/1ghxHN5zxmcI9/9OKaxYupJut4BwJjZJco8FmL4Udl5c?=
 =?us-ascii?Q?Q0cr/9+B+QjHS8KNdgKkWcrteRJbhylQ2MxwwoWx230mwGc6AtqKkXSTtN3G?=
 =?us-ascii?Q?cAnZIealIwSXrxnY2a2avRIUjppLMJSyQdzEj6Fd2mnsrDHxyOgOxPXc5sWj?=
 =?us-ascii?Q?tc2cyYmM9VUMdM/N17uYX7cJRvW5xftGkNaCzEb+Pun7n76yCRMjR6F4CrAo?=
 =?us-ascii?Q?41B5tINR2FBOzZUZpAhIHof0fuGr4DXiWltdE8gqXcpEWf/90+G+mGmcuhfb?=
 =?us-ascii?Q?a8ZrBPYHuMs4d9NvtSGKccVzkFrIXx//BSJMNo/+O2J+IER1oU1/qCwJb5ZF?=
 =?us-ascii?Q?aAcdHswA9Y8XyjPPIWT2z8reVOd4wiNyxGol7yaxB/lg+lBloTJrpxI18MOh?=
 =?us-ascii?Q?DSDVtAkA4GeNaOP7OISxrlGgiX0fnKGcuCoZO5Z9BYxy20fn9oj21a8hfknF?=
 =?us-ascii?Q?9/IYHwYiPha7LQGJH4TuLtao4FdwY30Ogy37D78VrDiqw/8lkN2So3wWJkkZ?=
 =?us-ascii?Q?SnL4AvfzZI+wYPcD8OngqL1orOgfejg1qxT5n1oKxy0WGxqco+dlCVerqYbV?=
 =?us-ascii?Q?4N++H6VE2IXkxqsDCqPGAWqDgGSYRMleDk/gkSxTYl/ilVaUX9ORiLHAK1pA?=
 =?us-ascii?Q?uVRFtAvMyzShSFyoXmdCprOg28ok1Nz1dIKWsYZ4c++JRmOGPN1tz3olpEgg?=
 =?us-ascii?Q?KC5NQIRhpB22oSqE2fz9Zn+6zIFhoQJb1lE1MD2a8LLm04y/eSrxietDdiWB?=
 =?us-ascii?Q?UnRYuNS9GLJzmjHka9Sse+lYpe86o1SSy0B7Y1Dd2fF44hRj9jRg3j1Igqb7?=
 =?us-ascii?Q?XlVNx2FWYTm3TcmbO3Zj4XKphWgSSMavwU2zG7Yv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b04227-439e-41c1-8758-08db6e67440b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:43:20.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHMXas5f0Su3Wa//pdlP4Yk578tFm+5S2T4rzmlSfGvUAXzjJG1JbpzbZmvZFzxZf2hJOZebcwmY7kV8zXPv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS: Added maintainer details for ele-mu driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6992b7cc7095..21a7a5604436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13536,6 +13536,15 @@ F:	mm/
 F:	tools/mm/
 F:	tools/testing/selftests/mm/
 
+NXP Edgelock Enclave MU DRIVER
+M:	Pankaj Gupta <pankaj.gupta@nxp.com>
+R:	NXP Linux Team <linux-imx@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
+F:	drivers/firmware/imx/ele*.*
+F:	include/linux/firmware/imx/ele*.*
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
-- 
2.34.1

