Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31DA5BAB54
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiIPKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiIPKcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:32:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C22EAFAD6;
        Fri, 16 Sep 2022 03:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OagK+bqEA6wu/tcKjayI2HjF6kfUsQm33OxaA5XJJ5fkSY5GbbyoctIbGxY3JnPDa9uRYf766Fzb3ZqcHvnb/F4Ax1783LqRooRXRpBSRBz5AMtLv/tjQ4tSTF4xoTvr5V1nOx0T9o24LV6tUo9cLr/BvMt6RdbEoIHk8BMBaqCu8LifrH8rJsNPt+mom0XZCZ/tQjwrZv2L9mUxwG6P/koghr6bpaJxtnDp4X5eFyyMn3tDAmxwKEELe2unDxvrlftEGFsUf4Q5FuY+0ov76Sul+UPcNqKs0alMBerZ7TDBeqRAQ0U88AXuDeiCLRK+fEPu7SpSovWqfZW2SBpPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+VqnzUl5Z7hfweJG11an1Y83cEXeGWUbndlGwEHYlI=;
 b=Pt23YU+xrZ86TLicU4I6EfktE0mu+rvDfFPQZu0rCkQA+K1GJFfm2cPPDWzsBqEouMgYA85XHl6CdNbjKL29wEAR0G78ozdBhr9R1AVSCctqUHelVvsAvSvSE+Rvl/E7f8OeDn7xxVpRGL+nJJGAzW4UUrHdBJ8dQTSPTssDY3+ohCxzh/rQQA2Avw1mO9hLk8s+IvvidCtJxi9RQqklJQV1lQ2Oebhu6jPdX8DpjgtkpcpWCx8T1kZOcC/h7fzByyMazErm+lqU3U3htHpjqCwAQKU/ya/vPfjRDjVwNb4nB1zHFqOc4Hu+tIUCkMf3d4JyZvaxSBfQnsTpdd1Qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+VqnzUl5Z7hfweJG11an1Y83cEXeGWUbndlGwEHYlI=;
 b=cbYDTcaW5Zlpu/f/MX3ZdMAbELBgMEykGkeGq38D+cf1qq8Sy7OnW9e4x2hO3JoFk3598+/fWvy3A9S7fUQJrg/0JGGH0H6YnoRnjj0AzD5K1f9AS+L4m0/ts1W2l9COitY5QLBA9yzakfR1ooMfgbABAc3y+UAM3Vt7eGaQTYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 10:17:54 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 10:17:54 +0000
Date:   Fri, 16 Sep 2022 13:17:38 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: firmware: imx: sync with SCFW kit
 v1.13.0
Message-ID: <20220916101738.xn7xx7ipf7p5dbok@fsr-ub1664-116>
References: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
 <20220915181805.424670-2-viorel.suman@oss.nxp.com>
 <42e78db0-74f9-3098-0cf2-908092a0b594@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e78db0-74f9-3098-0cf2-908092a0b594@linaro.org>
X-ClientProxiedBy: AM0PR10CA0048.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::28) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AS8PR04MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: c67bd8a9-f200-4756-9719-08da97ccb80a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoXEJK/OiqfM5XwO5pkPKZUEmICqwvGXSYhzrjhF/pS3G05uB+o0TtyDXN9jm9asm8SGzP7kkSADO/CTgXJa4Ik1/iIl0/CHVATQNkdE4Qas91kIitzVI8sNEpsNE81lC1laMTRs/nBikaL1BhmU/wF0lmenAWTKf6gpe1RPy6yPWVhQ6DZpqkW71X8BJCLc1kEASDMCujOG4yH56XvgslJ9Vohpa6cU62CjM9hRGqW7PbsxFpAWgddfHbtZPIFxZgW0POQUhyWch/L9Oa6xxeC7HxnQa/q3o33ndxbEU0WQwfH3LN4dKNt9IdsmfBzsUtCLbY7muOteaW3L0q+knrEljZr/6ME30Dq+ps5NTKcavnc7cOPWeqby3qX/zvDYvfwk16GnLnGK73TqBJ/kqqU+uHOotUcvM/2yMN9NQBsD82/TjuW3k1SRUj/Q966C9l/1ZjQwn/+tG6D/RzkOBQfkPGNTXAczhCd8RMtrZbQ8xSv4P+S4S9xpv4qv9MbHX+sSBZ15VMWc9SvezUwcTDXtHxpLL6jkCF1GP1t6zAnEkvaak8AFPmO7y2tBxG7C3nK/Yqra9Okmmmp8zjYpG3vFoXRWPcUXTZWf9hPhPTCGrXyGfHIn86KobJbSDtvXDONEq1QB73pS3COhDOQHM5B019aGaKYK3ZmqkPhFlG2NB5Q0IKclWbST+hfh+D9pQyMzAsPbwyQX0TY8gOQhCJyAoEOR67xJhR3Gco6Ywe0IAluco3oqkg57+4RNqJBr920Ti5XhkYSRhrJry36woS8K39/6xgBMOM8oz1dAgI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(8676002)(6506007)(53546011)(6512007)(966005)(26005)(9686003)(7416002)(86362001)(6486002)(44832011)(38350700002)(478600001)(38100700002)(1076003)(186003)(83380400001)(41300700001)(33716001)(6666004)(52116002)(4326008)(2906002)(66946007)(5660300002)(8936002)(316002)(6916009)(66556008)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MjF5T+Sc3B7OqQm5tnLW8QrO0fjFkq4dSqhrXHasmteZz5uitvY4E/y4cqo2?=
 =?us-ascii?Q?CL/7dQ3aaWyAyonfPRoL7Qik570J2rAdqYsoxlhJQ5r05N06Q3o6HUMdI+TR?=
 =?us-ascii?Q?5HG7PBQhHOE/x0+ry53BSlT98LlDFjI9x5DN8rbYkjUe8F3S25wTdvq9Pg+a?=
 =?us-ascii?Q?HnxQtBdZHD/DOyR6RvEhg1GxunnYkAAzcO+9x4QVnIylGjZ0kC0ONgSrERby?=
 =?us-ascii?Q?117Kmq4djE/djjeGUcqqefkcL0tFLmy7XbEgahttQBDmVwQAA3iAjc9PiSUe?=
 =?us-ascii?Q?IlCnF/guhdJcVqfyHaojHV7JrGBpfD4/qQgZKj2ZtEXx0H5jrTyfy8MSo/DY?=
 =?us-ascii?Q?RkIXTMboJO2wYrPIVrULfv0iEP5vA8OKL2xM+tjC+VNQgulNnN+1fVeC73dk?=
 =?us-ascii?Q?WdTv03o/x+bOj0sSfhMpzeSlc46brUBPWncgWNRT7dmQNrmmqfpjz3T4GcEi?=
 =?us-ascii?Q?Ri6B+Yy3MN8+tFMLErAo0FzLWnFnMFPUemvOS7q9yiTE4MvhwMMumg2Mm86/?=
 =?us-ascii?Q?dtBHtvvIMwsd39/a2nJH8bAmkkzTyGaw9Hnwqf6YJtivqscfC26TMZmVUOEz?=
 =?us-ascii?Q?Vu8VdI/el/BKgCEFbVgW9MEA6KnytKtqHUbBnoiVDwCFqWG/suwPyAP2Q9Uw?=
 =?us-ascii?Q?UCliutRkOuuljzAfftS6A3lpegZgeTOlagTU8VY5z4EiF90/wzVXRC88ezA7?=
 =?us-ascii?Q?65gnTnK/CVGZekm8yHBqUN2CUeOhWnnFXNKUHhGfBeCmu9445J5KNeCrfd0k?=
 =?us-ascii?Q?1VDY70a/WNI1iTxt++tccnbauH7vz7/n6tYmTa/bw7v+S746J73GZeFmSeYi?=
 =?us-ascii?Q?CnR86AwVsZaVeGyRYt+topwRfvXQ6i+7kC2Qi2v/oqxTnNoY0UJLSA1a1Qu4?=
 =?us-ascii?Q?wYXap02tpZzIuqfbk4/D2Z3rDQRLNSzSA+/HcTSVK6CyzS/f42BCTmq/7mev?=
 =?us-ascii?Q?MGnUM1ShiVw38qhN3SZvo3JrLkhZxEvy0i4wPBfYYxwVuVH6uuMfothoJTiP?=
 =?us-ascii?Q?2/rbh4cobatiD5qepQ8EJx7GL+ogUwisUZRQYN1BDtADw1tLntHAIdH62oxV?=
 =?us-ascii?Q?LAsngw5clfj4vbHAN6BQHBXYGiOgJB2nc9DWFz2t4rrM6ea6mydnEVYDb5aW?=
 =?us-ascii?Q?gPaLCecV9sJFfVKdBIgc9R+GarIsjwmzUNryZ7A9NIGQ9bMam/5/jTwpfrwL?=
 =?us-ascii?Q?9iS4pPHDLto9EEN2StqyP0meNEkw9pqP9ON2T57DEV5B7S1+uaOo6QBdvsx6?=
 =?us-ascii?Q?S+xCxnnQvOkum6SDFicF8yifm979QTKKwvOZ+XVwt8OoWncs3+kLhNJVZY7x?=
 =?us-ascii?Q?po30IO4gCwJpKF7BNPx/JDvCgPi7QCqT9ml0F7oF1BRvl1ui1Qd+evECoAaZ?=
 =?us-ascii?Q?9LZG5Zc4NURKXlo4xAgLf2MrXTA1d+d38GU0xbvxMFrAeETF2KnBud8KmUeR?=
 =?us-ascii?Q?6piwZjbt0gUIdETtX0Tr7Qa2PjsV/VuSPXmGOYHOOtTDNSz2JDuALU629aJf?=
 =?us-ascii?Q?gkauvB/wTpqGmiCufi89aZO14YTg17YKPjn+jtcs3YLcpdExVRdzahbD5RUM?=
 =?us-ascii?Q?Zr2rOdSSnXXJ8GQNfhX3EJYTuVbvVGBjG86qhUU0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67bd8a9-f200-4756-9719-08da97ccb80a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 10:17:54.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYpyffW3oCetockp9TtBCThKt1GXTR/IWeOe+KYYW574AUTqLIllDnNcmcFmIUaeEbWYmj2A2IWC8JwEPfaU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8833
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-16 10:38:30, Krzysztof Kozlowski wrote:
> On 15/09/2022 19:18, Viorel Suman (OSS) wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> > 
> > Sync defines with the latest available SCFW kit version 1.13.0,
> > may be found at the address below:
> > 
> > https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
> > 
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  include/dt-bindings/firmware/imx/rsrc.h | 299 ++++++++++++++++--------
> >  1 file changed, 203 insertions(+), 96 deletions(-)
> > 
> > diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
> > index 43885056557c..a4c68f394986 100644
> > --- a/include/dt-bindings/firmware/imx/rsrc.h
> > +++ b/include/dt-bindings/firmware/imx/rsrc.h
> > @@ -13,34 +13,38 @@
> >   * never be changed or removed (only added to at the end of the list).
> >   */
> >  
> > -#define IMX_SC_R_A53			0
> > -#define IMX_SC_R_A53_0			1
> 
> You cannot change binding constants... Aren't you breaking all possible
> boards and users?

Hi Krzysztof,

There is a backward compatibility section added in the end of the patch,
it follows the same approach as in SCFW kit v1.13.0:

+/*
+ * Compatibility defines for sc_rsrc_t
+ */
+#define IMX_SC_R_A35                   IMX_SC_R_AP_2
+#define IMX_SC_R_A35_0                 IMX_SC_R_AP_2_0
+#define IMX_SC_R_A35_1                 IMX_SC_R_AP_2_1
+#define IMX_SC_R_A35_2                 IMX_SC_R_AP_2_2
+#define IMX_SC_R_A35_3                 IMX_SC_R_AP_2_3
+#define IMX_SC_R_A53                   IMX_SC_R_AP_0
+#define IMX_SC_R_A53_0                 IMX_SC_R_AP_0_0
+#define IMX_SC_R_A53_1                 IMX_SC_R_AP_0_1
+#define IMX_SC_R_A53_2                 IMX_SC_R_AP_0_2
+#define IMX_SC_R_A53_3                 IMX_SC_R_AP_0_3

Regards,
Viorel

