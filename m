Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18920701670
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbjEMLdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjEMLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:33:12 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2047.outbound.protection.outlook.com [40.107.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C04469C;
        Sat, 13 May 2023 04:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgSpAGrmHLPkl48aceF/LIvbJo/kQCE2LIHg86OLHw+WYcjJ+ItiqYiBfgqHw2wpo0cyHu3/BvAIZgssdNWeCTXvrmQR+QyBFKI1OsEyFov4QzCNPtieGji3mzn0w/4P1SzvWiWMK5sGIAHOCU20vXq0M5K8EhC8I6JND+z5aKluKJtbQyz/Ne4oU9U41KiMmdEsS51THCL0oJ+zHWZcLU2j/4I0cTzEQSZ6mKsxGuKa1gcixtFsCG/srW8kglSpxq9FOTjvlzKlStPdi15N3YkRXapLRlNP2QA/J2Ny6GnUVPzc8SYgMK/guLIDOwwz83fYjg72kEGnZVV5L+my0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCLzeFq/a9uAtrtdgsfmAFJrt+Tw/Gq4+T4smcbeF9g=;
 b=YTGb7REbJoxngoVlBTXsENcNi2U7FPhfS5rtwdWTkVTybkNb+Mq91yryw0+X03xg0fHp1PkUjUmS/bhwlrGBljyl02691zVk4mxrBYrKK0pxXHU2qJpn6aH6fR6PMBvlNi4rsqVmErlFngWTY1fi0NOzuaJRht6mx31uuwoim+Qh9hybmaRdYc6SGiRs5P/AqmuyyQ8SC+BA6qOqcrQuhr3sWIfXjdkLEf173m1xnYOp0fmkyAmyeW7k3D1gSKijfpsmqNsfuDC0lC4TxbWg5eXU7ZenvheE+eeFs8e+uiqDooAMaHhpTTazDQ6Dhdlt0xMdLlJVqi+AKLOytfPnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNZPR01MB8378.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Sat, 13 May
 2023 11:33:01 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Sat, 13 May 2023
 11:33:01 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/3] dt-bindings: vendor-prefixes: Add Emtop
Date:   Sat, 13 May 2023 17:01:26 +0530
Message-Id: <20230513113133.1913736-4-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
References: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PNZPR01MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d531e38-14ef-4fac-32ea-08db53a5cedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rm5zlj0SAMj0NiZ8t2iAl1AplQKSfM3yJdzQIBGevy89VIrSBfCeAVY0ob2YfP/jBGIeWNvTWIsVcbXXXd3SL4Mw281PEaIkRsOF6faG74o3rbCUZXLA06Qeo9JiCpxDFSSFRYGk6RKR6xZzcl9sShQVl4FPI1hnfhr7ngVfjUntla2zgEO3wrlEl8gJcJCQGRglfjy7za3C9gUKyvq1AghiqPOxfjYyTpjMkqe3fQZJwfDQe7wdIPRzhJQjVgOl3bpBp18Q1pKs5TD8ChKclODvTrlObQlW13B4//vbI06R6Q38FOVpOOacLNQYj4lT2tlzCcS8P0lk4ZVkNRZMt3qnO3nPmK5KPuH3LkgIlAZW0BZQjYgeU2YLGXSC74Azaj5NMaXRW9wKM72YQnxZwWjBbMlNjuTJtTtO71BHiMUEhmt/iLJA4FAq5jTjgPAWUeIhDjnJecKx8A/gVZS3GuDGgKgji0++2BvWU5dmLerAYtXrrUdUnG6qlvHJHRMmZ0RacVVJybaS80W9bZbPgj2lmsZX151nytlJmWHC4ApzuBiw9DVWagOgvSZ0WzjdJgjO8zwAQ4E3fXXdltlSAlWkBl9bvwP+wRnLMJC5cR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39830400003)(376002)(396003)(346002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(26005)(186003)(36756003)(41300700001)(4326008)(66476007)(6916009)(66946007)(8936002)(66556008)(5660300002)(7416002)(44832011)(8676002)(316002)(86362001)(38350700002)(38100700002)(478600001)(54906003)(6666004)(4744005)(2906002)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSC+crNUma5GnrgYPckhgtB1Sl07+xnF1VVQBbMUahto0F5hCTHfgKwCTSny?=
 =?us-ascii?Q?12czPy2V2DWDfxD7F9ZPjpi6GdaaP/LK7vhw7K4Gr4J87iYJ9vBOi7Bg7vDO?=
 =?us-ascii?Q?Ve4qXqepyPAf32ZY140nMyzK2G6tyT9zyEpC77YUgT1AlB49Y2Pm81Ik5DDH?=
 =?us-ascii?Q?leeF50eML9IGAQPuQ/7N9c7SgZMZ2JvSf+XHwa3aokPuH2rW8FF5H/9rLyc0?=
 =?us-ascii?Q?x9zu5dw4Vkjyw0DZSooL9jKvJ8sQ253CA7v1N2epWAhGG1AFDvzHP1mdy7bs?=
 =?us-ascii?Q?GZJl3qmFt2DWXeD/GRsTDuHt/0MeczuHjtYEXO8q3CqI9qwAP1DCMXooKajY?=
 =?us-ascii?Q?TuMBvFPbwLYffpyaAwFutNvte0M3/KoKE4+9AL3OHkw1J9Qtn69RrFhLgcrs?=
 =?us-ascii?Q?VIqylxNiMMucwcFglzFmzfh98lGHPOAehTOVBhx9a7kDC8A9xXNzK8DzbaGb?=
 =?us-ascii?Q?aNw1Zuuxe9UEJyaJurJguRWMXiwbPXcB1/tJzcyXHTCMOpWcpTLP88mNxEcF?=
 =?us-ascii?Q?0N85VltgBr0QC2zJmYeRJJ7xkFgoikrmM0vcdEq2GYgqfvlICFECVTctdh2s?=
 =?us-ascii?Q?ZTWBEUPAQapge6deQ9XQsX2BCS28KziEtDju/FHenMvudDJ36j4Awo1fVQd2?=
 =?us-ascii?Q?yshqzvmIIEHW6HSF/cZjBR7UtLYC44LeRiXVO6V3Z+ZN0HDDkzkq7SaSO1Nd?=
 =?us-ascii?Q?X8yA4q31EVySXfK1EmoJ6i6eHZXKV9FCzA+V46XbbZVtud9ntoR5cfnkJGyf?=
 =?us-ascii?Q?S0V05E0z7Bnri9hR1bvbJHlKMt6hI5yxSri0PSGm3A29IuCBPlfTTKJ7VamI?=
 =?us-ascii?Q?raGqUWXc6o+OaLAFJtzOowO0FGoqcC7B7qTfS0GPZoOlOOnhGI71fuK5+/XG?=
 =?us-ascii?Q?RuGCVpWsa+87E6ioo9IdS8UaDnIgPN9wNsPDi/HSobYGrY0bVtnOqe2d9JN/?=
 =?us-ascii?Q?bP+QgdzLWaNwwWupoZXezYwUF7Zc4J13Ui6F8oLyjAQil4IOFe39WHEmm6aK?=
 =?us-ascii?Q?f9AjiLde5qUs1QUmuVD3BmfoFtA3WrIBO7vHy8MlBRMGWjcjA0mRIst7AXg0?=
 =?us-ascii?Q?HHTLo3/MgIL9xfWdejDv7lYUAzHb3jZCMGQGXzxuENpJd6fclaGF9J0BU5hV?=
 =?us-ascii?Q?ztoGIk5/JTSV+Wer2uwBXT8lRVBzIPtwDca48EjB69+OdO7l61JWAueKMoJR?=
 =?us-ascii?Q?YxTcY4TxbHENzuLFu4OPwjt96jgqf/pu0YxJgGcwdiYeBrnSiQBKUCdPi8Xd?=
 =?us-ascii?Q?72mcPamVSxIKgtbSbRI5MsM12psGpMXjo4PVU+Mf4hGEjRVCdpZs/YF7dCyN?=
 =?us-ascii?Q?B6b7PEUhfG8NTSaiv9JHSUtUjraADaVEvNKYrY98K9/YkWp5FbnHQj+QKVis?=
 =?us-ascii?Q?FEix7Ri1ACajUSGI1bRFDRX9RgJZp6y/45Z7mtpSt2lsawud765NCC5t7+71?=
 =?us-ascii?Q?6dNyjbvXD1tpvGcAX5ANGvXy7yiZDxxyczB3vDq8GGaJ4Vm56gbVCJT5Orsb?=
 =?us-ascii?Q?heGYWf7huNEy1aPfiC9Sc2VLP3kWu3XxNDvtJ7TAM2VmhBfd0UW/NkEpc6Hd?=
 =?us-ascii?Q?E6B4+CyAP9SdIpG5M4tt6Rj0w7h08T8uU/XywkKgklDCb5fPu+0VIu1DHUpe?=
 =?us-ascii?Q?xPIjr8CjlyhhWd5s8Z/GzZk=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d531e38-14ef-4fac-32ea-08db53a5cedc
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 11:33:01.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYFReZ0RjGa/8kRD7OMJJRm8yqB7n8l256Q8eU3coaUPge3Q3Bo6fKgYcv3cQVpGoKHLbuORutXkLjVNTHDz38cgGkiUtvrT/8Puy/J4gFRMwVv//IzroxlFkYtmT40K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB8378
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Emtop Embedded Solutions
(https://www.emtop-tech.com/)

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..88f823e19194 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -384,6 +384,8 @@ patternProperties:
     description: EDIMAX Technology Co., Ltd
   "^edt,.*":
     description: Emerging Display Technologies
+  "^ees,.*":
+    description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
   "^einfochips,.*":
-- 
2.25.1

