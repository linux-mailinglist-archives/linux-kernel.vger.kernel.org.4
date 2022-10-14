Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B055F5FEC19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJNJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJNJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:50:50 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F25E306;
        Fri, 14 Oct 2022 02:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnPW5CrjHkumn7kcY4r9bqoUWDgi0dHSckf7t7CNJ08wBdIoQ86erKP/B4KJN0HXyuo0BBcG70ieZNhIlO3TXslh87RZGweFFtdVCeWJAARlki7ew43amUrGKR48X+HbltKa1hvYFmQ02ICl9gSXuzYaczIf6J4Cso/MQTTAOvRe0dCDClMRVVeT78fufMwbamfA7Z/P524uFgMU85Z4+sMwZCJa9q7fuVZdSuziRRY+9/LWO1APFEZdiohNY+5YuMGWlIF8rBpmUpI0n+4FoH7we4KlC6hc0Z9JRRlDMT1pcfZLCcngiTSBtb0hpgctV2vmFzI4GhisTDJ+UPeSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH07K6nf2DHx5bwSvlJxgeePDcG9VNXo0jlVlD26iWs=;
 b=UM+gY4ADGseEt04HFyX+mvf0sFj9Q1ypFaG4WJ4llCCnfxxSeEkwWRuM6hja0LS5kh/ML85t0IN+h21a8NN4ToNdoIoEEQkq3077LQGcmTSeu++KHYe13WtnFb/msVWtSvLKD6CrpGTq38drG7+9Vj5h7onX17NaA/c4/LN3bgiL7CCEp+DyILix8R5ha3S/XHCxIM4ke/QwMV6rdS0CL/Lt8B1QUSeIzcMoxWhM47k81KRjBsud2NuAzQwsG80rYTcm7wyNczzUMxGxq6hrzuZ13hbGBy0Q+zgU9VZIzK8wY2xdFfGt9mpWofQwU+kk0DFltQp01MyYIzWPoBavqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH07K6nf2DHx5bwSvlJxgeePDcG9VNXo0jlVlD26iWs=;
 b=hS46r9iWnHAV06aG1/VT9gjygbxzcDj0eCQ7ONThAGDyAaDknhQGaJmJSS0r/mPlAQeC5v001zUmARdiDpkqjzXEVsn6j88TFqNQgy6zegacPsqhq1bOvQqbOmFxlWB5lzeSaNE+SdsFGWOTpYpIef7pIlD+vqOEB8uHSxMy1UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 09:50:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 09:50:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/6] dt-bindings: usb: usbmisc-imx: add more i.MX compatible
Date:   Fri, 14 Oct 2022 17:51:45 +0800
Message-Id: <20221014095148.2063669-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b27a560-ede1-4b65-4a37-08daadc988ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EpttGrkuIEE49PdEP7RhHA+ZJkWjPelqkMw9hV33iDdUdqeVpIBleEwq4BHCKDB2n5HM4+is+eekvL70akITxhkB9OafjKYPVmcPuMd+a8/QE8ZfTRn9f84YEtssbfNHfaOLE/7mfnZycVR02FDRoOTS+qzBtDIjUQ1y4jFSBgF8TR89jPmY2rcH+J+E4/3yf2vy0RSu0iQDNEYnWZhYosIu+Wp4An/SC2of/nV8bmhIuOIek1YXC8q421piCH4YRx0mMYZjCbfNZVIHHc3ISrDD27rMi1ZqaKxhC7AzWnIhDCKjniEf1IvGXUzXXfQk8VgEJHemArB4yCIb8o1Qk0gP55U+QVcFgN0WoDRQAiHvZSf4V29vTN+kFfTJDoz3QkohmoWAEn/NRqc7TGznn3+7s6IJotmym4mkKlGoc8ckcvdz54BOgwumVUrn4FYXAqU71pt/l+swMWdCYLnQrE85V8bqPo4lyB3a+/rjQoZhqNazK63dYcB5oD2+lFUFH37C7t2QPoOEMvvAqlFNYp2+ykt/Zc8PVCK3hrWcC6w0HOS4hVysu24TFlOCd1iT0NuQ2l9YodI7Gj/1h9uEmSehEYyuX/zmsp91UrxF9z1EX4f5lIpxcy96oyIis2BbnM2GOxtBMcxr3mZWXOh8E7TfpCDV0ekr9DTRh6hlEO8cYSB1jGAXDydI+6705H63bTWbtHjXZj8RY6dNmGqTUOHz4qRnZC9SDLEaotkHsQK6dm2LRGMDxXh9Xohyy0TfnyHchx4L5MmQlkKwlb8kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(478600001)(6486002)(38100700002)(38350700002)(316002)(4326008)(7416002)(83380400001)(6512007)(6666004)(8676002)(66556008)(66946007)(41300700001)(86362001)(26005)(8936002)(1076003)(66476007)(6506007)(5660300002)(186003)(2906002)(52116002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ev33+FFPyt80T9aq+5oJWcT2oxeoO84ANw8NDtUPEI+9IUsv5DrlXIS8T8gV?=
 =?us-ascii?Q?h0IlRlI6Lm3tZr88foAeDIBpXsVmZZdks8g+7zIR7gIbibcA6toyoYUta65a?=
 =?us-ascii?Q?qvLotQg2P+RVTnvkTE15r8pQQO5aT5u8/dQKEADGEeABP2amL3NPp1A8nV21?=
 =?us-ascii?Q?VxfeyxLxrjyWOyABneMzLGmL9blvefddSy9h7FWKjNzo0GMGbLz6KWPXoPU0?=
 =?us-ascii?Q?3zhbWqtKsATfV7KKCSxaPb0LMPc3VVfg4rW/DsT3AX2mO/QHNMmVKrhBVWK7?=
 =?us-ascii?Q?phlWg7dLFuIosC7IybLMaTH9dLHQPr4c5/bJD0OFfIwV6PPoKjFjvF5PEbTz?=
 =?us-ascii?Q?kAp9cKQ7+gGGOXnw7qIn/mj+47rntpZ2DulrttGGsoMUqIbXP/SoTBxYv6/E?=
 =?us-ascii?Q?zj4vGeFPra7/Lof+Nb0nEUaIH0EfVpqNymx2K3XB0qiqJrJqEL3VjMHqeGVZ?=
 =?us-ascii?Q?EzSaeJD/tml/jrhCcKN9phgbpUxglKOdw12zAQ1LqsBCe67Fq2P/d9l4ON0u?=
 =?us-ascii?Q?k6y8rl25dcI/gMDlSacjB/rlUvseL23eDOtJNCNUBy5oDCWJDLwj76m1i29f?=
 =?us-ascii?Q?x5iZwPo8z+ecUqH03GvTF8S/PQXVfzf0K6VizOdbQs4iBjlrfzSa5JmuXi3l?=
 =?us-ascii?Q?1PrqipJq/m6Pw3ew6PwfK1Qo9qeWXuG6cVxrI6TPvyDk5HcsK0787TsYEglR?=
 =?us-ascii?Q?qCz2m7IYh3ZLjpdy+espVvnOiM3rNjPtrj/4x+Sd1G6+gFCJ//+6ZW2AVIYj?=
 =?us-ascii?Q?K9dT4E6b1Ou/IwuKt/HEsnSWCANCPDOdnR/EORYtV3V+m4cwzaumKL4Bjz4l?=
 =?us-ascii?Q?BpMa+0Vd02yzfDSg4P8Bc6VVobKb2IQDWWaSLZ8J1KXM6M6b6xx6oeL4Hmvg?=
 =?us-ascii?Q?8PMxa0Ff+0XSJzplVnQcKpY15URrMM47UVwGJBOCw0v++dcDtFv+ZmuUlcT8?=
 =?us-ascii?Q?07AA3zKUF6Q2zYa+SVOwEB1iuBi20QIxliRfBFGPkRiaBPBfTK1jqkYj/V5B?=
 =?us-ascii?Q?AY9n2Dw6ULaHTGIFrSVP8LpUITZsN5+p92GOcrI2zZ+tI5TtHuruViFah5Hi?=
 =?us-ascii?Q?4jMWRJAShLc4Mh80DFGfFN6dfmRI7jYDjGvTz3ADcvcydTBNaTosHwM//xrT?=
 =?us-ascii?Q?LKFrRU8rkDZ/BDoV5IxbyVPG4jsXt3l3XQzKZUplo/5gZKB4ZBqY80o+qL/y?=
 =?us-ascii?Q?MaEZN0KghzUES1mWSDK51j16yRkMY+pPGtZtobmAlPyQWodXT2ztwEFT59qb?=
 =?us-ascii?Q?RWWGT57eQrtlPeSNU3Wb3Gzw/TDndHA7lHtAcneqLvkwQ+z3O0NAB5byCykf?=
 =?us-ascii?Q?Aeb3m4XD0oP870rev2diXSJv+RJzjzrDAIdzRparniGtRS+jc8If9pPprk+7?=
 =?us-ascii?Q?lgMfh6qO7vG58f7g1xCfaGC82RZKMvoHfS2ZhOp1bej28j0UlHlnxlP9QHWh?=
 =?us-ascii?Q?XWtYigDRRNoX/oyxWWQYYlGfILyMAlA4RgNFS7c/nNGQ8RKu4F65DYmn8/vd?=
 =?us-ascii?Q?V1dtcJh18T9SCs8CLGFXZtyn2ZMlUbKPcnrPn7ap7RFV9Pw8mtSEZlCMzVdk?=
 =?us-ascii?Q?oACcOD21AagCMRWmNidg36C7x1vGetr8JWQDrDp9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b27a560-ede1-4b65-4a37-08daadc988ad
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:50:32.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCs2K/ETlDO+ltOlom5rUdufjGUcc92KYxPba/ioVKtmD7FWntEEeoWbu3sJ+/5wLo+ZYO+H/WeBHH3C39r0Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add more i.MX chips support

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/fsl,usbmisc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
index 89e2035436f8..b465bdd12cc0 100644
--- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -13,19 +13,31 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - fsl,imx25-usbmisc
+          - fsl,imx27-usbmisc
+          - fsl,imx35-usbmisc
+          - fsl,imx51-usbmisc
+          - fsl,imx53-usbmisc
           - fsl,imx6q-usbmisc
           - fsl,imx7ulp-usbmisc
           - fsl,vf610-usbmisc
       - items:
           - enum:
               - fsl,imx6ul-usbmisc
+              - fsl,imx6sl-usbmisc
               - fsl,imx6sx-usbmisc
               - fsl,imx7d-usbmisc
           - const: fsl,imx6q-usbmisc
       - items:
           - enum:
               - fsl,imx7ulp-usbmisc
+              - fsl,imx8mm-usbmisc
+              - fsl,imx8mn-usbmisc
           - const: fsl,imx7d-usbmisc
+      - items:
+          - const: fsl,imx6sll-usbmisc
+          - const: fsl,imx6ul-usbmisc
+          - const: fsl,imx6q-usbmisc
 
   clocks:
     maxItems: 1
-- 
2.37.1

