Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C15E5F9C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiJJKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiJJKRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:17:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB596A48A;
        Mon, 10 Oct 2022 03:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbKktC8wXAMXpkTJ8W0Zdgrd/Sj226koYk/PWN3FDIpSfkYbFRBZia/rjxg0bIEDYIxg/w6v8Kq//I6/d6PBsnIer/LxESOMY0HLKQkvkyeJQYCFFslwwCWQq+vuiDsmFi9/08AQ7cHd5/FAg0S7I44N7FSV3kqgFyGwXZuJ+EY5UeBConY2N+ONn2aPJDEIDWac++WDsfIgHeHKn/pYyKkQiwZ3PTmFt78D5XZUNuonRbcDzUc7XfxM/YQk7+kBFBK5ctUl0S40uYajya2dnoyy66P/TI5pdhQ84Fbh6I3e4Kpi98yXfGuMyqJ80Nb51YUEah29fyTuzpB3QPvMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBLKAsnBh+Vsu9/olrR7bsu8237ki8V2/vQKFz5mdog=;
 b=AVPK/CxvOykUmdkYeyN8o8SmZem3Vm9UHDR5+HUEecD4UiaYWK+iD8h8qtM2YvCCxqsXCRg0Ruc6jNvMA/5RTuD6797+JrD6aplKQc721uBFRXvW7aDfzhGmcLMX0C72CdLX4wO31r1uPwiQ/oZt4r3YNIr1gb3qkx7yG6hAmQ4hAF5o6CfsXsogynBqd1QqE6CLgtfJeVpCIa89ROG5EdDHWTWp1q5Jiy/VfCQRPSpMwnJQVjORbJGHHn7dve0kUw+iKA3DdroJWP4gFw4otBZazAXqqFutGIgzuFL0sADyfrnpv3lq5TxfkynwonIIiqHvPOf63vjibC+Sug0zNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBLKAsnBh+Vsu9/olrR7bsu8237ki8V2/vQKFz5mdog=;
 b=aPOayBg5rFoWJLBAafGFHtuBrvCKxZyZ53pg5z3ChGte7hmLm1XO/Wm9HgsjNjQg7XHACOp2Q0wkfiBGIk05qaNuqRw3yYGdXVqEM+52HAQvi1buMhyHCFr0oCyuvcM3ac8prXXgOO7dIbtuXAj1v0xuzmRvJhVGjU5ZWfjT4LU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:16:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:16:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/6] dt-bindings: usb: ci-hdrc-usb2: add i.MX8DXL/M[M,N] support
Date:   Mon, 10 Oct 2022 18:18:13 +0800
Message-Id: <20221010101816.298334-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221010101816.298334-1-peng.fan@oss.nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9f6604-af12-477b-df4b-08daaaa890d6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yf6k+z3l4IxTz4EJG/Jbn0iFF8zA7Zo5oUfQwYMwxhZRry633quiuhSk9pUaug7mcJU5yLadhLyRCALDZNpEBcZpLgBA7xh6Gek1AD0fq6HtmADMmyxv0u1zdDY4tBDqJEwNNO26OFMh1CJQC7MIP/0DTYq4cZaYqm8/mHpL3XRV10Zoe8265LC4BJwRIBRjIhZV+LaUCJzGyhcPaZQQ9ii4SGeNjowXo4lfXWuCQ6wQPCViqBzTqKA5ttMLDzCERGyI55g8XH+0UX02xj55g+PqOG/oHLICj+V3YX8VQLAYY13Fzbcm9UAFUcWv4Nzu5q3c/XftDDwyM4CZ4ERt56xWVsv5BGeJnNKz0wwU22Z6HIS3ALMQM27qYlUcUsX3Pvg/QG/VF9MHYdFgDq+x8dMw4TMIucrEzieI+BstUdPQROtEaeYF1mihakhnDMrptafhFoxv6DAtQIty2cgnaxIkL8trAcdWLQMl+Vq7AqNarBslEsT569qBDLUj9HrsZkQ5qDhMHNQOaVrCgT76nqEh5YN3ssivGsgVLW7FIe9mx9NfHQTPLXQctM/W/Z5yYigDHFJKbtiqvnnwqN738niaUqwZMZGbItYcYfXFbxzWvz8xHDbG3FC1dPHlrgWYIwsEbI1ZzToynr/FtLMHt2f0oQc7VRkUe1KaYRy0vCo2BKCCNmOZEQlV6R6KcS8PaTRcRoZ0+QaBlqZJFX5nbos/bIRHP/8vu4SCKCo+XcL15vAE0q6lAHwjklyw9SX2r0BXsSAQ1K8PkIp7s72UFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(316002)(7416002)(2906002)(6486002)(4744005)(186003)(1076003)(2616005)(66476007)(41300700001)(6666004)(66946007)(66556008)(478600001)(8936002)(8676002)(4326008)(5660300002)(26005)(6506007)(52116002)(86362001)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CIqoKTKMgyeLzq0m8Iz9nXRpf+1GKQRSkXHzFWfW7WOkatds+Aj9Ij+p9UQ4?=
 =?us-ascii?Q?cO6qFwiHKF32X9shMV4Zbq4mX3fvpmB1n6KhBYqeeDPLP2/IyzfuOFTV8u1P?=
 =?us-ascii?Q?JkOl6Io+v0I3CmuLBKik3VpfEk81D/0P1NOwQYONzkhSVqK86KQE+WhrDLej?=
 =?us-ascii?Q?E1F7OSws9laqOqClf0MI4vwcJz514jViAdxUYeLD6vRIaQ9KN7vb/g6diZMD?=
 =?us-ascii?Q?OIOwJKy9B3lJZBViCVx3gKLAzLbeK/NkBzdbwTTObr132QDpiu3q4K4J/gDj?=
 =?us-ascii?Q?bjGRiWnxztYnh8buRNkPQKFtHc+exrFTGNIqaIY2uEbtr60TYOP7Ss4Hg/30?=
 =?us-ascii?Q?SjMnII6i8+fWd7f7IGvPeX66t6j0+o5dLfNmdcb2FnrVHS0pTrkkEmMQxvCC?=
 =?us-ascii?Q?3vP2T+25zKcQ8I1qw5YB7T5KVY4nE+DoQBLXoPNymINVoYhB1fv/xl8yPcPr?=
 =?us-ascii?Q?SoddZ/vp5j2jwZssIusXEhrc9TUYC196Uq9YyWjz254PinweCqAQKEf3z9aJ?=
 =?us-ascii?Q?PKjIYjD5ZsaYTDc9Ht6PotE8NQikMEu8ku1WC860t/p90/xM4fLU0duiP65z?=
 =?us-ascii?Q?fqeFQQ+swCbfeMTQow4jtSBOZaXll59s8kSiKBVZ1PqxsTo/I5F1GculSAIG?=
 =?us-ascii?Q?lxXfQxiCQ6fH6anMBoR7lHnXG0UXzifxpqXgfoTPcyMRdcvaRCUWAEvZPuzo?=
 =?us-ascii?Q?OAOq/Affp/ZzPQ5GJ5qOE8nJvyrE1cbzs08JJGwAjBOsKd+z7ziYlbfvnDz5?=
 =?us-ascii?Q?tam1kNOCiQYOCSMaiJ1sYKT2W+QMbpCpcxbap4n8cvRZNsOtXbqKPo32IkIJ?=
 =?us-ascii?Q?eiC148+PY6rRS3NT5XjSQ7qw6H1ZYoOBBkeL7tEaWOkpW06Pb09F9BgmqbZU?=
 =?us-ascii?Q?ReR+FABZkK79swPL7UOmUjkBvZCiJWHG6pu4xE7jSN3UG1LNU0PVTvYBjbaK?=
 =?us-ascii?Q?Vpn3L7M3rrwYyvvzAd5u2ojcA1xibMcZqU73Pt+LBpJzqEu+ROibaKglC4G1?=
 =?us-ascii?Q?QXGeuIdIDv1YB2bc+yhsN1YuPXGSCcRgQNSH0GxggtdhlorFjqvQXaMuEKrT?=
 =?us-ascii?Q?IWbUU0nBU7bLJM92X4IQC7IWQoFk2X5kb+9U1N2QJSva1X8RVUN7g5zQ4sCS?=
 =?us-ascii?Q?P9BBhC43acfErCw5ZOJDSyhRIc9WqX/LyC17mqiR9x94TGq4t8Bgh77twVGx?=
 =?us-ascii?Q?eQQ9neMubUFD38B2lLGXfy0x4EfOOHGAT9sLCpN/iAXAAaARbeju8zLJjs1N?=
 =?us-ascii?Q?A74JgRDf4z34jxDAiBKg8Atw/WoAJnor2DT8WxBPu8SK1r+G0b9JPyIJAPGl?=
 =?us-ascii?Q?gJ770NvOn7iALbB/98ReKNECI27FNAeLABPb7HbMPO4ZP3How5HTx1kIg3SS?=
 =?us-ascii?Q?mTBxTct1K4v246dzuH6n72oZSRYqRbvhzyberoUXF6ToMW5Pp4rpUniVyZM9?=
 =?us-ascii?Q?MlI5zJgajLkh7s3PjsSpc5AmoSTyABL5uyIH0jMNaOWRoGLZLVLBykoo7FBC?=
 =?us-ascii?Q?BdtyyJBX+G5eLUM3XAa/6ny1DFaGTeSXtY1iGww1SRn9wjbKIKRJuyfxTozh?=
 =?us-ascii?Q?2PufsQnwFn3iWMngGlBjvbLRpN/Vy4rptr5mVBVM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9f6604-af12-477b-df4b-08daaaa890d6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:16:59.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3ynsvMGXcpRm0qTXkcGGDYCfE482px5VRvotSGYK7kRwXm5L4GzfNZe0I3BVFLk0kTB364veJ3KZiOBcLWNQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MM/N compatible strings, which are compatible with i.MX7D.
Add i.MX8DXL compatible string, which is compatible with i.MX7ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 575084ccd6b8..11d08ffeb1e9 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -35,6 +35,14 @@ properties:
               - fsl,imx7d-usb
               - fsl,vf610-usb
           - const: fsl,imx27-usb
+      - items:
+          - const: fsl,imx8dxl-usb
+          - const: fsl,imx7ulp-usb
+      - items:
+          - enum:
+              - fsl,imx8mm-usb
+              - fsl,imx8mn-usb
+          - const: fsl,imx7d-usb
       - items:
           - const: fsl,imx7ulp-usb
           - const: fsl,imx6ul-usb
-- 
2.37.1

