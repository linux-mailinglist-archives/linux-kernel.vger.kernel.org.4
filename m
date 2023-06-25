Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA5D73CFE1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjFYJzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjFYJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:55:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E710C8;
        Sun, 25 Jun 2023 02:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvlavjtQzggXEUrxJM9CSYZRI1sCHBmb4jixUZnY/96nVWv+dgQTtjSrRn6eLxeJUu7fHonYs0qOYeeXt1+i1EQ9vQFcqCutsIz14KnfKxUKUhwZ3JcNpsiIo5OTkoUlq0ZQKbcPlOhujgUA8Fts113f688nYmEzmWoPlCueEYoosZ3M68y5TtDZe3nMVDc9uGxKc8q91FOY4iWISDW5oA7vmv+zPeiI16SilExSVJc1sOYvIeOb7FR4ctD8VTKeMo4Ne398m2MiOqzd0kkpyL+Hq0UCsocVORPYvLv14JGgeghE/GAz+09MJCSb5xvaGuanC4B/LuBeBn/DNzvE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6RjJEMGbO31IIcRVItQpnF1/zDX5vSfrAJfbPWL+Xw=;
 b=FGXz3D9Eindnc8GoBa4cxR5ecrQuvejkxxcAKRrch4Z+eLnRVi8j26NGupEiRVwBBFS4oUuinQXwtc2vduhL+9UmFP42fxZwUecN+rw+m9KboRukAw7MKAYStU71oaWnlULk+p5UK5unlH9H9CekVU9c4QsZw/gqTWbZvbJ83Vk+NAEB9f/ce//kb0NE4n1ynB96pu6Ql5dArYFaC/d3LqQlDKucSxesDcmyOSfQGhdBf02cTOlBZHVjF/1F7gLr9LmlbBSh0pd2WORYMJEo0bO7LZuyTJ2nC0c38Ja/SzAl02I1+qyC9GmT1fcO4TMTglZItDeLD8oTDxdbEthFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6RjJEMGbO31IIcRVItQpnF1/zDX5vSfrAJfbPWL+Xw=;
 b=pBV65s6wapRER3JYT1ZsuQWH3W4nRv43YHkUb05QrCia5sEUaMrPAtlX3AFQW9DzJqhoz67ZBya//ldnrWy7385TmmNorJsewVz+Hx5k5zh+BAiLX3sM0/Svj39QiRSk5OpZwhRO1QBMstRZC44Ks5A/cTJ2J61TrirLQv7Xm60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 09:55:01 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 09:55:01 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp compatible string
Date:   Sun, 25 Jun 2023 17:48:57 +0800
Message-Id: <20230625094857.29644-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230625094857.29644-1-sherry.sun@nxp.com>
References: <20230625094857.29644-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8ebd61-6d64-4cbf-a791-08db75623dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRvkmBxDvASXuA0eWDih3vspR50rA+UcuQFrGzfu8F0fvY5oIVKjziPUeTRwkrxewi/LIY6wE4sZMi1LDacztKPm9r8jxGkiemUTW3SMy4PlAUbZOE3xVi86Q0k2fAS8YfCO/iQ79ClHvzdopHVcxKHdd5PpgiKCyEoGKCqP5qzpPXSZyCu/op5cZbbqbiCoey1bxSmYUIQDo7/NTu1wU7iYZ2xnDUClCamOOHGebA7Spl8uC1IIOY+s3OMJ1DYcr6cSyLGaZnGQv6Cz4y9HXJF/gX3VwF8X8cFULZzswtAdfXL27S2jrNtRobUjrL8KjVTh4JXLDu+IgeFwXZny9IRTBybbaJVuuJBS7Hjlo6ETLBjZU3QPpdq8UJT3/6w773o75pNwnrnXIwrMUTDvo6/dGEWOSNgOTEs77Z62Pr//Znvhkf8kja3lGvtv+oEG6xz3XKqGCktoiaa06xXjhqfF7194HenmGODk8Q6WiDZeK0eEphc2ThBgvf1xFSbYV7liBfhIGMd91mxOzU67sMVwOg2ACJyGB79e9rUTcliA+GQe3SotQQGCV/jA9uxW6S6e7lPYU9p1gXrjq48Q0MsDT+t5/8D3uSldpdqn/vx+a6WaNIEYhRmZ0OTw+uNuzuut4RELl1Nnt+tl0PWyLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(26005)(36756003)(5660300002)(7416002)(44832011)(66476007)(8936002)(8676002)(41300700001)(86362001)(316002)(66556008)(4326008)(38350700002)(38100700002)(66946007)(6506007)(1076003)(4744005)(6512007)(2906002)(6486002)(186003)(52116002)(6666004)(83380400001)(478600001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8Dpvua05TDrteIyUarBt0hi5OZjN9Q0J+FoBG9ADCLNRWe14Q3EnCy+D47/?=
 =?us-ascii?Q?uH1Jg6bh3jitooxcJpZrvyFmUO0wROgvtdb5AaAEbzL3snGbhxcJRmbptZ+l?=
 =?us-ascii?Q?MHvojkCW/XlL9XVmOv9imtPDDs/2N4MxvgomwN8ZemZnKQSdkcKIlDUN5FgC?=
 =?us-ascii?Q?pnY0dreKYVScZ17Dmh1FUsR3PLKSuxxOfWyX2HMPS7lL2WHTGeTgv5bIZJn5?=
 =?us-ascii?Q?EjMh6x/+lKp3BjH8n7EeY7PTUexrYsMujzPyXWlrK1X6HADSXJokpl5FWuXF?=
 =?us-ascii?Q?8aBb5EiSDa6wAQhD3N0d9oNHMjTD2aoZ4bRp0dmpZL92UrkwNs7BRs8arNgv?=
 =?us-ascii?Q?ooB06GGhSLbX0qPZkEa5PGPUQSNk7QDuKsNJQF7nniwRjnvJ/YmIIe3o4PSq?=
 =?us-ascii?Q?efcdVWzSCxc/XGyF/v9vVgN14PGN328byuSJxMw8GFAWerAGWkYKRGXj5qCm?=
 =?us-ascii?Q?61aoJznKh4vOA7wQvCb8s3IQm8AWtAOtm1k2QQ4l6MKdGzMigDlecdn5e8nL?=
 =?us-ascii?Q?hwDBlQqx+e6YF0F5T6ogy/q1xRFblIFsz0SI4DGp2BnqUPeLvIPJwVJ5a7+r?=
 =?us-ascii?Q?b4a9Ad++dx960vH3wHC0lhnsbddbrLTnPi8OV3GWmd5a6yhCKF1S+EtUQgqC?=
 =?us-ascii?Q?C8bjP5Jm3f6bIXfz/fe1A9CBNmnn1ybpLialVilAmB9myzPdmd5TJyf6Mryt?=
 =?us-ascii?Q?DynbSD5m5FMjKOYCRznzISp8UI81ANiV2I4W4xhZ8x++hO+SWnZBMR9w/Ac7?=
 =?us-ascii?Q?+YcLO+NL9yVRJoAE27rMuI16DVSj4gSCI22o7X0dW8Qijpbm/VoOT3nBr4DZ?=
 =?us-ascii?Q?68qSo3shEERXpgvxKknJlTB45CgKa0kyPun6YAYF6vGSSNMs38vMZdhS+XPO?=
 =?us-ascii?Q?+jdkn204fEPS+RoUuV4pHmpJrU0H0EyAPiRUK8oyUXPVjAS2oN2VOa3jSPey?=
 =?us-ascii?Q?5BCz35Q5pusjk4N/pqxX9Ubx0pNKQHUat2tj0RQA1MatdyebnOpeUaSSBQQx?=
 =?us-ascii?Q?K2zWUXwt/zvByLqAKeveu9Vz40VNEeqnqnKY9QYmfFbzTCF4408NAuSx7JHJ?=
 =?us-ascii?Q?3A76gVWAY4JG+yMflktsElCH7Y1PrAsATZeu7Ng//W6EVqTDecAQ1TOLWfwz?=
 =?us-ascii?Q?ZUwIswXs6E1J2j8Al73zd7cEXoXAvDWgJFDXpU5OMjzt4fObvGxMuXqUeOSv?=
 =?us-ascii?Q?v8pBxBrzJcTJ/uFPP3tcNY4gyLWUE+eOqh7MI9fiv0oWh+fxZODtWQXbGOxw?=
 =?us-ascii?Q?gkuQud2oJ5p6IJio0+wAapZPl03kr0GA3CwybwiPJtHX+QFQkSDVQ1LB4ISc?=
 =?us-ascii?Q?T+7sJXaLVV4hyPNma3cf1wPF31q8KTVZuT8gpMPKGqWCyJaS+YMPs8Ee8MHm?=
 =?us-ascii?Q?V28RFgHMjfd7UA73hwJDRMHIQn8FQ7/m8gRCjOsWV6l+OY+hsH0Wtg8SUbz7?=
 =?us-ascii?Q?EQZPaoZsuCWihK4XS+alwp+ymxovEGOFxvhKCN716WZUAXz/UiBzQxSeOtY/?=
 =?us-ascii?Q?LnJLLcIzys/ulrdiVEasCOnGC31rvwfiWyz/oRBvxik/P9gpMPTyXlJhoO2b?=
 =?us-ascii?Q?NtfcYx31vKxyb4ByMqCJKJMySiwVgwQ2ou5TtQTI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8ebd61-6d64-4cbf-a791-08db75623dea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 09:55:01.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSspO0mV34hy0KZht3FDfy+kMs5Zk6BDZ5JEl5ukDQDRusK1/HxwbJPvZxRKj49ZHL6cUgQ5E8FZRorQ91v6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPUART driver adds a new compatible string for imx8ulp, and imx93 is
much more compatible with imx8ulp than imx7ulp, so correct the
dt-binding here.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 93062403276b..5599be95400b 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -21,13 +21,12 @@ properties:
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
-          - const: fsl,imx7ulp-lpuart
+          - const: fsl,imx93-lpuart
+          - const: fsl,imx8ulp-lpuart
       - items:
           - enum:
               - fsl,imx8qm-lpuart
-- 
2.17.1

