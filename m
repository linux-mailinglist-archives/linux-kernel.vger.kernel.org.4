Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58A73D702
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjFZEyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjFZEyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:54:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315C13D;
        Sun, 25 Jun 2023 21:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPsfEcEe/LSx3p/VmJavWltnaAz4WH3uhKKfk57z5xmHGgpZtKidQV7ACE/HdF8R/sRMZHIM128DtzmWqczkPkau+JiOekYL2Eyl8dEkiJluBh/sZRN4tIUnt7Pcjkt6CukfiSag5I4wm+hNTnsnUFt55KbC9jgeFW8roQN54SudRi6zamO0mBUfZoyMEudjEjDRf4XKQyfUX3mVvswy5lIHuZfB4/4usFGsbjLy+7KA4n4FgouVGbolwEx47pq1XTvepfIdgaoRthqgDgMXTeQYueDUn9sIYcy/itxMVGfMDKUxDOdOOngS6wY8qOnRl8TYQEmncQxVQ82kAlSYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH5ahxKxLXSeTUpO+3Iz/J4JQSxicsJOo3Fcn1PdDO8=;
 b=fOQu0gekPzKazfnacPPSnPjdaatjte26LPd0snwcNsjlMnNdyw2k8z0dr9vO+mOnw/tf9lKiN4CgXPUnBL7HSOEmQ3bYhlTs84CYNPX5Elk38YIRv4WEg2g+wiPTpjEd9O30PeAuaFG6k+IO55BgiTQHsc2Zq5hirjHOHpCztfZaOcoA2ikWlOE+oTB5TmkzN/l3JovniKfRTUS55K0bbUfrmD/qXHaY3NRGN9SZzBn8g+TxxhGBNm2NPs/DdqO+K8z0yK32E0zG8qL1Mnjh75k621yCMbNW/wej7SmCywm1Zg8QPOj6X93yKKQVrZZNbdi7f7I3AWmUBPShHHZBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH5ahxKxLXSeTUpO+3Iz/J4JQSxicsJOo3Fcn1PdDO8=;
 b=EiriXbYhET/MF1eapJ12pgZZEZ6pLrYCEiaNrC6fXkNrYSA4J75oBDk5jmNE1+K+f0mwZ4aWI/goHoGeXsup0HAxGnvii3h6yopvZDaV+S/CdgV6rVXHzRBZMjg2IxmnI2eJlW/qqadeHfArDs/9Dqd3YadfyZ5J4Lf+3cBqnYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 04:54:28 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 04:54:28 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 3/3] dt-bindings: serial: fsl-lpuart: add imx8ulp compatible string
Date:   Mon, 26 Jun 2023 12:48:48 +0800
Message-Id: <20230626044848.4417-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626044848.4417-1-sherry.sun@nxp.com>
References: <20230626044848.4417-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0c5b78-3fa9-4463-b239-08db76016c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvKjfAzRhdV+X/ydfMuJXCkH3J9zjMLhusPABrf9Cw0TuPqi1sOl0xPc3AfjKET3IiqwbzVvDjRwxTBNsk+tVXUzSmn69/dsc4OfNLf7cGAxjiYuvdlIhzufPJOSFYbd39gjs80cS1OB45hv+ElEnc/426JgbvYYav5T7O1mWwk+PreDF8DdmWH4ozCsFZESUVm4iFFdU46v8m37kUtd76Cz3lvPTgJLGgmz3TBC4PJq3NXg+/08qJBiwE7SuK3F0MJ5zQlREDfKHjpyHxxYiTjurWm8IqVO2acDeE1nO4gKOxYL9dlAyijhWckZF6b1GFVNomXRYRwAzW2h/VxAcuhi58TnD+HMDjrg2rAAmUk+PHDaXuikjmnjKEr0E0lGnVn2N2QFxpY/PXWUVtkacy9+jakeTCJtfcVDERJDRJ5Ik/Ci/Skk2hMsN+fpjJjP9QTE/X+kBJoiU2tgbf1Sljp8dNWeweuTnuYB54jGmGd3gPCFGDANzybWfAfSL/lYgWaMt9XuPRFic3jArHteQ5VjR/xKFNIKZZrmJTZsS5RKO+DIywSk1MgH6iKLs+eL9G+2WV3z9Wo1Sa4mKwXsT31quyunx8y0m0AMWnDiw/Szp1RSyIlzZn1quCZD0l9h2GrSZHPo/BhHdxp261j8mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(186003)(26005)(2906002)(52116002)(6666004)(7416002)(8676002)(36756003)(316002)(478600001)(6486002)(86362001)(4326008)(2616005)(38350700002)(1076003)(38100700002)(41300700001)(44832011)(5660300002)(8936002)(66556008)(83380400001)(66946007)(66476007)(6512007)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5GpeBAGkQ1yZc460uYfYAXf9J8aDbnUmKPoa+grXAHgr6ONNtzdBVpZ7+fqn?=
 =?us-ascii?Q?kvvNhEQDoBK9vQk0h9wCcze7d39GgV+N9jm/QXKSor5NkDCzcnQcFc2UA6Be?=
 =?us-ascii?Q?Fqi3r05AbOgTdbNB6yDfJe5uxjJ4NHu8bJJQAPaT8Z/W+MAQSYYDSijlZW3o?=
 =?us-ascii?Q?O9ATsIrVrQ5KdtboUUDs1/2SZJhbJxmc29rfSSYXYhuKcevz0AGWxZM0d2y0?=
 =?us-ascii?Q?5ZYe5slSO86bxOs+8rUqDmiwD6jdd1iks8TfKN8/MLQZTtI6KaHP3mXUbvM8?=
 =?us-ascii?Q?r5vkGv51lZVIgdq0MdBKsvGYjFkBKOt3YK6FY1dfId2Z6//izBqi1mbUmiVy?=
 =?us-ascii?Q?S6V5NUcUaZsVmXIdCFKmg1QfO/MBL4RGcqOMdBQrbiY+UGQNEbLO7M8moonm?=
 =?us-ascii?Q?BmxavOykgb9WIdIpeQoFv9qepWxThJHzjrC4DjjmsDP4nJ5HibT+0kJQi505?=
 =?us-ascii?Q?Z0ZoEBTmWykrPKxW4ZdyNVYS2zSoAu73RCjg8WDlEVJaEWgXJdYWPFSofdSF?=
 =?us-ascii?Q?9MTCT+OFCmDdtJ/nOQBAgRFsL5GMNol//x3NkllU6CqxD0HjFwX3VdYep+CM?=
 =?us-ascii?Q?3J1MPwqCNPHETsJmrstC/tx6S9CyLN3MA9YkDU61dEMP34hjYjzohn0dJcbS?=
 =?us-ascii?Q?ZBuvEY69MJ3x4cq2uoL27nEv+yBYdV+RCEs7gxibNbwxIitm8G7ZkaBIqzY1?=
 =?us-ascii?Q?dhjy7iGGMTiqYmfZ1nlmv5Umjy5FOM4mFOpYl62tU0BaepQpMPW4t1c0swyZ?=
 =?us-ascii?Q?yvkr2vl5PSMNMOFq7uHHK7l6OppCeL8aefuwBQG8AY+/odfk2A8Xl68c6SVN?=
 =?us-ascii?Q?i40BUczdaSf6OtGHsxV9ZnyBy4l8GRfEadgw0a+rpSL3LZgyLMmFIsMPky+F?=
 =?us-ascii?Q?b6r6SCC5GJkRaCB0DhkbUHC8wSu+UArn1RtbhdaV2O30hKkz5C8AVp44Ppmc?=
 =?us-ascii?Q?PmZxLUS+F/z3XTyiNXb2VFTHsp9FjRCYTK+Iq442zfk2gONUuzM7mnC/cL18?=
 =?us-ascii?Q?I9zTCKx1jDSg1mnJAK9Cw/MhKnGGONIKLcIIuHtK67sDESywBDToWVz8LbVV?=
 =?us-ascii?Q?Fr/pfZSIGjooirshZeFnJAmboSd0Kmur1vyW6ZhOwz30jYLJsykqRgTqJCXI?=
 =?us-ascii?Q?R8X+RIUXsbypIY3bRLQZWUvF5joOrJQ6rBD6dlUOZ4aBbnHKRMvBP1WaT/22?=
 =?us-ascii?Q?nS1Iqkayuwf3+bp2dJRrqP9pQuNVHUegdBLhB18Q6sx2fbblrJEcsYEan+Ka?=
 =?us-ascii?Q?sie+OwC9vGxiIr6RxdVgkH5aA/2aari5lW6h1nfc8QoZM9Ypqf3y9TufVhcO?=
 =?us-ascii?Q?uIaQ910ohPXV93yIJJdJ5vr+tFVIjPGieVt+FJPN0/O5f6bCi07jogwfM/jv?=
 =?us-ascii?Q?Nktp0+/vHQ1h4PBSHwGYxi2CN+BQKPPRnXgry/juO61QgzcHYR/CBdwP7Ufy?=
 =?us-ascii?Q?IjOyzQEH/NM+u9NAgnRvnt3P62+PvIzbFotMGS35I0hK1abtLjJ+zpsU+gmX?=
 =?us-ascii?Q?A35hd5kfXYuJkHWaRRbOe0+fq781fJsktT1MtV3OVlUq4uBQ+r4obblwEoIF?=
 =?us-ascii?Q?UvbbyTOg6vbPR+PhQM9x6o9m6GCFbFFmpt5usq8S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0c5b78-3fa9-4463-b239-08db76016c24
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 04:54:28.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cY0eAQRGoCUnFyTtFC77aF/kVwHPJDqQ1zCqBkY1e6qcdQF2P//VJRyQ7uLaOIgUVPFsyYyPfUsahR8aqaeTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx8ulp compatible string in lpuart dt-binding, also correct the
imx93 compatible here, imx93/imx8ulp add some new features based on
imx7ulp lpuart, so need to add "fsl,imx8ulp-lpuart" for imx93 to enable
those new features.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 93062403276b..272bfbb1cdfc 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -21,12 +21,15 @@ properties:
           - fsl,ls1021a-lpuart
           - fsl,ls1028a-lpuart
           - fsl,imx7ulp-lpuart
+          - fsl,imx8ulp-lpuart
           - fsl,imx8qxp-lpuart
           - fsl,imxrt1050-lpuart
       - items:
-          - enum:
-              - fsl,imx93-lpuart
-              - fsl,imx8ulp-lpuart
+          - const: fsl,imx8ulp-lpuart
+          - const: fsl,imx7ulp-lpuart
+      - items:
+          - const: fsl,imx93-lpuart
+          - const: fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
       - items:
           - enum:
-- 
2.17.1

