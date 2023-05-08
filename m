Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84926FAE41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjEHLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjEHLmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:42:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D667E3FCE4;
        Mon,  8 May 2023 04:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI6pFfMoxKTy25cKEos9SVXDmAXyGUgiNhq9wZyxPPlncrHKKVLT0r3Kvs530k1tCCJ4Rto2HWsI8uSQROJJtqanejNnlEj+Ry1y7K1mMvLQIbnaIF4BhJ/Fkw3nBu41Mog8sZLTIzn6+tu13wNcIb0JTRV0OhYx6qkaXrB+ngy4rpZ8m9WUS7uMQkzNfflpb1v5j7C5woU+BGn5I0O29hHwPu4eVSyAHdVfK2eJdT385sYBXbE7/vwqUJzthwOFqoXLSV/Y6wjZuOKC1KPxW8cHkGNTXwNq36npKnEu/AIxNX6HBTANz4dbWALCzYi/vtExd8w2HyCXklYb7ewuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dd2HjagfFkX8ISXkv0GwqoTEvu8Vvqfg2F+XjOK+MI=;
 b=B7JCZ/+CJ01g6NOdFwpEk82/9wVmjtDhtCnIXcA50btKDMp2UOiQHFeRTAsme0nHvlhS6L94lmfvC7CVk7VZ3/mr9lWB1ozTm7PPt4G2tpQ0cjMG4PidUDbU6nXduDn7uxrKoC8W5JUQWIRb1aszikx6EcyPV0Xc/2YZxd232hTUkNJtpgZQmwjXU5UQLFdSefO0jGyD52PPFWjuh4z2iEIsRluQ2tEgaYdjv9TMWki9gEIiGjCA0s3ixUXGtqOsbjcXNe4EC1CBpyKoDuH+5K1V9OKtBg7hmBUDQAVT/cUhkjGckoQjWFhKfbBq3b+uWYRMSLEyihD2tv3clXyeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dd2HjagfFkX8ISXkv0GwqoTEvu8Vvqfg2F+XjOK+MI=;
 b=cS77M9V0EZGfDhzgOMLKu/kXQe5zXd6lLmKdg75t8xlEISJyLNa2LYxgFo9EUNO25iJpW98Avg4a+eWpEz6pgfrr9tnO/9wWbalI8/WhwgAsXqjEPbpTi6CnQW9/MtFWiDYdl/moyYtcWsjYQWDcf7U+8OcH3tNJjyebOBdHGZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9632.eurprd04.prod.outlook.com (2603:10a6:20b:477::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.30; Mon, 8 May
 2023 11:41:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:41:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX93
Date:   Mon,  8 May 2023 19:46:38 +0800
Message-Id: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb1adcc-44d0-49a5-cc5c-08db4fb930c8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVMtx+Tx8rWXXsYz92puXMqStikjwjImfB86sSKiKjxGeF66vTULF1qOQqN7u3hprQLZ1TR2TG2/Egvw1LJgf1MUwnP+VdQt5noHtg1uDZ69tWQXz+CcFYBYdbhp3YYg3vFN1Dbn6rCVpUajRfzUeUbNR8gZqe7OwfdIPqd4ZOo7m15Tp0P7owZXlIKIZOTChFFIkD1tFw/g94ySDVVmQrC0VlQOFvp3Ud6NHeea0tZNUC+W6XgacBwTLjFrsjdrMNYXhrg1VW4GTT0IJWYQWXZLLbDq3+nk8/ko8sZj6qSzyBlsapq4Kz1a5AqV6HXMmw0MxUled8X1OJvwNzdU0mC7aGa5OEZHy65D/EHn4OM0poq0VoCDrQYDjZvk2OjjxxAYxve4UQ/6xXG+TgbQahkKNk26Do2X5kI4GQPVCygAC/aLewR6ipHt7gEia5Xzl0WB9SeIDEaqjbmFKujtgbaeoFSY9uaq8UqlGdwo7bAktxD/7nuehhRMTO98PcJcATovhWjHlpkQPEtAPX9RaPXMPhOgk6bJvdj4GwZY9bcH1Eln+5MNIeWRdXh07LqF2x/zq6qxPpAFla+OywhsTYPaNyx8Fuv7K96S7Kmr1QIEzNCVgxQ11zXicpLtt+XT0YmYLPDcLKmMTMSoAYzjEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(83380400001)(66556008)(2616005)(66946007)(52116002)(6486002)(1076003)(66476007)(6506007)(6512007)(966005)(478600001)(26005)(186003)(6666004)(2906002)(86362001)(5660300002)(7416002)(38100700002)(41300700001)(38350700002)(4326008)(8936002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYMj4/kJeZUBP6EmqhN80EiE7gF7hB/VqJTRBKJ4KXB5b4w6HLLxC3aTAJ/i?=
 =?us-ascii?Q?n00QJFZcu3TN94+1CWQlELZmwStQalgBKHxHQ+oLgUTZ09CbKb68Lm35PC8e?=
 =?us-ascii?Q?+W1SqcW5zI2jfMWLS73lFcnZIagqdpxEufyYLnV0F4gNgtrhjUAv+Q4q8Uro?=
 =?us-ascii?Q?qSSOnnCljSx4Ck2qt/VjAPhszp3X5TTHMqNgjDRu4ehIqSh7YGRrs3Vt0g4r?=
 =?us-ascii?Q?GNEH/6mJmrxQWLqj3bO7SQ0T5W0FYi2iS1/ozkCrtLE+4IJxMw30dMOto/xe?=
 =?us-ascii?Q?SzqN/96BJzhhWZDXSNL7FcQKqQqvpg5EvWxYF1VDr9hWpF1lS7vloVR57MR/?=
 =?us-ascii?Q?hx/yHtPc5ECgrT0EtNutffnXgMfNwOTzjk5W/Z9kn217yd5D2ZhmxL9/+ur6?=
 =?us-ascii?Q?lV2MEGbMq6bTdjXHAOTxtWELH1oTVSxQEXaws9i9Omm2tAOq3vyTvxBCB35C?=
 =?us-ascii?Q?efcDPPPsffvcieBdbCAtiUplsBj24fobzlqX75R5YcBIsq6XaIPeBgiPXDko?=
 =?us-ascii?Q?6sKY+QxQEixiltmTFaZwFinmTbujb3hxnl5qebvUljG91wH3lBYsJGOLZ2jj?=
 =?us-ascii?Q?EGx/wGg03bIBFO6uYih6gCmcQpRPNIDdiCVk9ZUahtbtD1Ej0nppjen4FSD4?=
 =?us-ascii?Q?L8AwhhZmoJuunt56XLpgx+NfR2PSQNdNkn6OiNPwuj9nFoXn8nl9sJ2+8HyL?=
 =?us-ascii?Q?lT+aVNkb4S9IfV3saGEPVZohM+bp7RXdA4vPtf6vsdJMlU5FozGmHqh0c4Ye?=
 =?us-ascii?Q?cQGxHaw/CU6vk0usANquRXwUUAFtrt9dLrmMNiLAlN9xDv5aiuGU2i+3QdEp?=
 =?us-ascii?Q?icAvFDcDaIwAubDqlhDWlj+Ct4pjAd+kqm7Rl/LY8/j2UlbcuP5zKEFeEyLR?=
 =?us-ascii?Q?JPX4rN13Pod3AypSe0yEN42UrBZU6Jus14OxjXYUwsuAAoj4pNXakdDqCRXu?=
 =?us-ascii?Q?iNUR2mEo1xl4GsBtIIK8vv4Ir3SBJtdf6y5AZi/mHfo8aa/CN+nA8bl76+LS?=
 =?us-ascii?Q?QJKxyE/yFs3pRAAbCWmPUxhSwyYXVa/pqKrIoKsVWypNGlAkSKJ1Zzsb6i/H?=
 =?us-ascii?Q?Aj/7WFxUt+vdlS/sSgqjqWirwx8YBTXL5sI4U6KcuVdOTzKNJ9nj3Bfmz7Gw?=
 =?us-ascii?Q?ew1tujrtEjqKt7WmiQohuF3K016RSb4DbyJzlf9d+ClRTnb6kA88HS1jlfj/?=
 =?us-ascii?Q?Sv9jT3oBiGdheu5KY1XQAYBqAMVlgh/KlnAmu7bVh6ksIqQvows5KSD1IvzZ?=
 =?us-ascii?Q?ZH5V9a1zjDeePM/eDpMeLvyImrsrvubZeaOLJ00etO2IkLNhIVChtMvJmBHC?=
 =?us-ascii?Q?tkZuINk9jQzo1g12hYEgosAQXnipbUbUBGsN5EP2jYl8nvN+M4MLhOr3xyfo?=
 =?us-ascii?Q?miE8vnDmVLAvm+Fh1ZmS6QlO8FlSRviTaC7ckaIGnWl6HDn+1i4h/EfcxCLW?=
 =?us-ascii?Q?/28IEpMtjaSm6/+HroelCCSP23SVYjWnsSBti3bqJHuYS6mA7510NqAQ3Ma/?=
 =?us-ascii?Q?N5qPUjCodJ79WnmA8DFYKMac2KlOTQyMpocf9dSlwoABRn8Do8aosQH8LFpU?=
 =?us-ascii?Q?xWBaOIlX10xrNKS5ah+DT2pypeYyyv+J+fUnfD9n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb1adcc-44d0-49a5-cc5c-08db4fb930c8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 11:41:41.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+ACEZ1xVxDIWLtyf7fMAavaejONRM8R/g2CXXWNHSEtkV0T/pzkPhCZEXaurOvAuwcImPrgy+31AV8WoozC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9632
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 OCOTP support

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Reuse imx-ocotp.yaml
 Based on https://lore.kernel.org/all/20230506064128.34005-1-krzysztof.kozlowski@linaro.org/

 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 0784d71ae8f9..99e60d713dac 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/nvmem/imx-ocotp.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Freescale i.MX6 On-Chip OTP Controller (OCOTP)
+title: Freescale i.MX On-Chip OTP Controller (OCOTP)
 
 maintainers:
   - Anson Huang <Anson.Huang@nxp.com>
@@ -12,7 +12,7 @@ maintainers:
 description: |
   This binding represents the on-chip eFuse OTP controller found on
   i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
+  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93 SoCs.
 
 allOf:
   - $ref: nvmem.yaml#
@@ -32,6 +32,7 @@ properties:
               - fsl,imx7ulp-ocotp
               - fsl,imx8mq-ocotp
               - fsl,imx8mm-ocotp
+              - fsl,imx93-ocotp
           - const: syscon
       - items:
           - enum:
-- 
2.37.1

