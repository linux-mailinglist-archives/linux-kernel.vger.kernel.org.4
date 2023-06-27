Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50DF73F10D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjF0C7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjF0C7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:59:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689D19B6;
        Mon, 26 Jun 2023 19:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXXYGPYGG6l8NRlmTJ8uY8siveb/hozXH272cda22sOgqzStBSg98kzyEF6YPWYeBvoyDUXCIZPG3NF6Imk/l0+FszdqxkjImm24TnNfgEV5cp8rFhxRV10zIeXapuVDqnTr2pewpAYZ03xSP1k0bUX1/ylT3DJ83Xd4dfMy3tTEJfAyTgNtq+7eLKW4eWQLdMDC83nGVsasxdIXJgoZu6Fz/QGJen0bi9Oy7GxB4poEZLizk2oBsYmOu+/8MWoP0qKfgUCUx/OSDFATP5h57IPSsnue266cWFLynBRyL5nA4IF+4C/6G0hTpHGtA7qeoRixxlMmL4XATDQkwReFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqbZPFXAEI1suDeObje5ixCzsoZniqvxce850kO3GaM=;
 b=jSpniJKBKZzM23C7//ZsWCq90fZqSWgv4QiZQ4ueLIN9jTlDTVJ4KQcNQ4qY7g8QNGTPNfOsmmYTmwA8MImrPXMJTx8gq76OYNhxJWq3X4J3eRFkQaFulaft2IPuhWCwQEK7KPP7e/qo9y4ycqWxqXzLuSqinC1CdPhcVB6f7ya4kK12QpEVtbB0n3E+EmwHXZNZ/idTfBhB/sA8vO5oZZmrZC3gHpv3z/AUpUT/wCt/izl1f0QxeClE/E2siP91OXijT4lUtwqRSDvny2+jH6RcnHSpJFtMoRxyohA4ywLBhMmKHkK0CVCA7CBPXgGCrpSBnqo9xA1yp0VAqD7ZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqbZPFXAEI1suDeObje5ixCzsoZniqvxce850kO3GaM=;
 b=pErnfUdYcwsXk/7ZaLJvALu2pq49T8qk+zsRet9F0QLSX4sUCFPS3CCgcQ0o572vgJGBSpOZ5TNZRYDerD3NilBOAegzz1TjqOFQ0hgmh60hPJagpgQ8vhxQm65irvuD6Sx31TITWKka6BvFnbt67hU3sBgI692QZhdElmPEKco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 02:58:56 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 02:58:56 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V3 0/3] correct the lpuart compatible for imx8dxl and imx93
Date:   Tue, 27 Jun 2023 10:53:29 +0800
Message-Id: <20230627025332.11133-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2510f8-d1b0-49a9-c770-08db76ba727e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0xc2kvRrms5lgAukFLDYndMWKTnHG6wM0iCKktylE+XeFuRTTwZfL4LdM9EVI0U4TzwFvLLUDLIWHVa+9BsxIhbp/uYURXjVpxqlvKQmF8KVKIozTIahKRNIIqYM4Xo8QMbY2xFtDSHbB+VQAYA0hBl2GgMR9iuozRAe8S2lsqgMQ3R2HQJYstBqDjS38KaC+3GW1NIeG6wGKYlrCR7KhP14nPvSVVolBrKQazEru+2yOe+1UII1dP0/WpRFA2zNW6elF0MxuKZmy2NcT8238sCUnGGDqjF4ta5trp6/TO3PHs8EyhqIgZGgrX+nk+j5dx+EkiSJPBHXOJvYXjUVTrECcZBOHgK4IeWDzuDg9hP3cDBnA6bmPUOJQDIE544i1KUSZowQ63oSkbAKghT8MZ/faNAweevF7/Hrd6x5QI5N32Jng2VbGcDts5u6F6Q15m/wLvaRJu4/ZsZ57/8DpO9NitS4KLf7x1dLw3LLVxIADKK0HBj/hQcXOWi9kCyxRPTdYV4G0aJ5vpIpBn2wC4sFTirx0s2HPdQcChEZXnseNSIa2SIobslb6OrSKInJTG8bpRzEBLD+WllCxu7i1lKMzGsehxarWqGblSAFat0v5MaBkSnQ8djEBBVdukX+ktgBcpOCAMpD1eh/gitWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(316002)(66556008)(66946007)(66476007)(478600001)(4326008)(36756003)(8936002)(8676002)(5660300002)(7416002)(44832011)(1076003)(86362001)(41300700001)(6486002)(2906002)(52116002)(4744005)(26005)(186003)(6506007)(6512007)(38100700002)(83380400001)(38350700002)(6666004)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMkjYnT7MGDqNA8Yqvku+U9vxRvHOEs7LAg1zDDqcRDu+xnFHJ3pdtNMlmx3?=
 =?us-ascii?Q?f2eKMK7M4GfLnsuBnw4BYIFTolyZl09nltfUkrSXMjGujOUWqwKL9whWBqCM?=
 =?us-ascii?Q?09MBSBGlB+owPET7rQzRUU7Qufn/14G5hsAM2EMCkokDgXf0tQD0fppNSmzE?=
 =?us-ascii?Q?7h1p+WZrwueXq2lpZpdAXD9I9BzCK89nulJ1WCFASZ7iXRIDq8it+DoGZZjP?=
 =?us-ascii?Q?jYCx2FpoU2ERumlXa1xHpYtwmpiCom2r9GKTqthJrgl9WXnPwLsdRgNtgk8h?=
 =?us-ascii?Q?sqzY4jDpKb7GFvlsk5zDTO0eCNFzxEEiZWXW8PIPyVAxvLQKwYR1WOR83X4V?=
 =?us-ascii?Q?Wcma9OlRf+d0ci/qx/ijztwj2B+3w1DLkVs0u/7YNpxOH/x7Tr1atBGgL2iQ?=
 =?us-ascii?Q?wUxHw2eSee3V5dFNp08fgpRABWD+8A/pYKLQZ1Om5071/tZp2DotAWRm6Gum?=
 =?us-ascii?Q?CSR7qWQP+ttmiUJbkx6AdHQJIbfH109GmxbsqExmkjB2/ML+8aLHF+f1/Euh?=
 =?us-ascii?Q?P0kitcJZquGOIGwffyiGe/sgi4NcQkz2WGh2f707mq8GNxWSReJ4RMzb1tp3?=
 =?us-ascii?Q?8UiA8Oq/5jUr//E302nrtysG4nVInZSL9VjxxG83hrbGaiwk+z9T4B2HAjff?=
 =?us-ascii?Q?q+fvpbvAFjz1QBm4gubbnQ5IIdSvzGqZHzfCj1fdmJZK6OUng4RWm3zKAfwM?=
 =?us-ascii?Q?0CXOBr+aI+zya182nu+P4xGHvNIYgoGGVlF5ypuBdV9AphExVHtt8yANxHGX?=
 =?us-ascii?Q?CDrYan0I2g1cI1rTgm6w+sj4nOCfXbO4c2Z6m2wkRq3Ja/22f+4qgW0gOMHK?=
 =?us-ascii?Q?v5siG6yK6ZIp+Jv1ck9uZUJm2MXR1/TkZJxxU2QY/SqNLmLEGpEO4nX7EgNM?=
 =?us-ascii?Q?Mzhz9YhaMLsXkJcrJiGsnYiu3RfAuKJhQTqGRZAP7eqepf+/Vvp9i+8VHUC4?=
 =?us-ascii?Q?VPX5wFqwOgDA7lhigOfL4x/jod3sJinBKUb3yF83nMfqRdn0Q67S/kinKhCh?=
 =?us-ascii?Q?IsZP95rPXl+LvMzyaYvhDY+N5USeLrZRnLS8TM9Y7a+RbFQT71wsRUM16kzE?=
 =?us-ascii?Q?3cSfshbHNXDcwFiSBr8pIul22YSjjy9ZdpJsymysldRs/j9a2ZQuAM+pwN1l?=
 =?us-ascii?Q?sDsXh3UD34qy4TiqCtEcZw9y3ZsHAitC/rjJmgohd4ZE42q9mbhexQ4ruTbI?=
 =?us-ascii?Q?ch+PvJzkZ4jk1taV0U4m/8JlLdLBbpCDCNZAyFWsm/n6G+h2OcN9yasSXk55?=
 =?us-ascii?Q?/sw19eN23TInFKTHrdjVM4UxabOXACYm4el5yESuQaYwJcgGlO3ryCvXNXvL?=
 =?us-ascii?Q?FhdY4N2sPdBs7lu4EYsqqksXQ1QakPlhxYoLokwRgh/+qGHUkybB5Hvdp9AW?=
 =?us-ascii?Q?Ai80aoD1dO9QQebGSuxdyVYDOCozh6xpYOKQG1huJaFbO60FB/E+EnguIZcT?=
 =?us-ascii?Q?ZzwRODISrS3GiO8JlVUoPK8P3thfVftHE8az+UyLuznk3RtoJi39kkUt1289?=
 =?us-ascii?Q?nM94TNX8K75CoocFLF3SGfXIq0xyM+ny4YRQB3BEukn6/SP9Y4NveMwZUR0U?=
 =?us-ascii?Q?lIIVe7l2xqSYxOboapEFFDc+xxwBUtdEkx59wjkA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2510f8-d1b0-49a9-c770-08db76ba727e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:58:56.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lMVHW355JmOPqPozcXqat59vch7hE88sCMkJYwCYuvT4mtFflx0tCeKXcqSMRaMX/4fmdV1rM0A6g63hSzOqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch set corrects the lpuart compatible for imx8dxl and imx93 platforms,
also correct the corresponding fsl-lpuart dt-binding doc. 

---
Changes in V3
1. remove the redundant fsl,imx8ulp-lpuart entry in patch#3
2. change const to enum for better readability in patch#3

Changes in V2
1. drop the imx8ulp dts changes in last version patch set
2. add both "fsl,imx8ulp-lpuart" and "fsl,imx7ulp-lpuart" for imx93
3. correct the dt-bindings for imx93 lpuart compatible
---

Sherry Sun (3):
  arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for
    imx8dxl
  arm64: dts: imx93: add "fsl,imx8ulp-lpuart" compatible for imx93
  dt-bindings: serial: fsl-lpuart: correct imx93-lpuart dt-binding item

 .../devicetree/bindings/serial/fsl-lpuart.yaml   |  6 +++++-
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi      |  8 ++++----
 arch/arm64/boot/dts/freescale/imx93.dtsi         | 16 ++++++++--------
 3 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.17.1

