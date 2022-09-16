Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4DF5BABBE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIPKyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiIPKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:53:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E9AFACE;
        Fri, 16 Sep 2022 03:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqV3+eP8RaifsgYCZ7nntS7o1VH/UKQ4o+CZsBsgao0fDBbu/4d3DUvxk5QqYvWw5WeZvZSZjTfy8vx+Rt1F+KUXyw4kTR52IZmnPtnmP/dN/UAzZ7g+rlwtmpvI1N+4XMUzNwtzyczxIfDLXaZ2X4EcIUfim/NGTmUnBEwnl5wwO7rhanZgHsBdtiI4WNFQOv5Stb7wi8nLOTIwfGNu2YyRB4yiAJr4BqVFQW+VL+LFfwK9q9bI+UC2nXItgK5dC0/Lv3cdV9gCvgieBI7fUcggENTfbSmLSFNK9qpQLIGLm6XA7A5CSoeREwdRvbHqkm7pnqJ/nxLRipWcNjoRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgKKCpdvsopV2mp4k82WrXwrvAxixxmvFxf9lyp6k2I=;
 b=kkNoEuqsD0TNJb6ngecRrUiS4SyAw9Yf9R5w3KOkLhhWQog40/OHweiTy+9+9UZKb5KsUwtMWjVGP8EuERb4tEH7mmIe7I5DT39SZaDWKZeS2gIW1o7u1pi/dKrNDyJiBd/3Mq7mJK2Q9MR2YwQkXZYzTHkgCKWtA2OmTdt/xRiNAymSVXhlVDqO7+86on3K3vcXc3T8qQtouWSs6qyr3QnDZEPU3O2Bkv4RyETCohVCDGVioMdCY1Mtpup5k78rKWbXEitIa+STPN9tM107+p8DGuU9IVUVd8M4LOkcZRMpuUAharnP/wmXsC4kF+UbCUKa0Rn9FihsZYwilAM73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgKKCpdvsopV2mp4k82WrXwrvAxixxmvFxf9lyp6k2I=;
 b=bAciiNHGAp2y+B6ID7ll/BD/76Mpgn8CZUinR8NigTC8frRY1cHl+tubkxRtqmpDiSkczKMJe3F1QpSY4YpR2sOhcw7dOq1L9+60vddclNLk6jYIo6uus/OIZFM1xdQN1HvSNd9pQsye7YwZImK6PxSOvHs4YdqwS3OnmZdxUpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 10:36:52 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 10:36:52 +0000
Date:   Fri, 16 Sep 2022 13:36:41 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
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
Message-ID: <20220916103641.2xvwkqovnuh2ajm2@fsr-ub1664-116>
References: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
 <20220915181805.424670-2-viorel.suman@oss.nxp.com>
 <58e7eada-ce18-0135-210a-3bc27e849fd7@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e7eada-ce18-0135-210a-3bc27e849fd7@pengutronix.de>
X-ClientProxiedBy: AS4P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::9) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DU0PR04MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fe207b-720d-4b55-30a0-08da97cf5e20
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kK2D18L+wi8tGSLb3lHkdilcCd6dhdG3V3fQ82ofX/0/3o6gyBNIt0kRoenu+cSVeJ9m/HexAjliGhPXfpaPSzfxyy6dNayrJmFP1QiDgBDNCOJN0FCJmq3jKevvl5F/PZdn3UnzTVor0eqO+wLKf2okCiGFRN7spkuESVMjG/OW78Sf7OFPuLlTEmAGaXDq0atpga4vEVpe95NSE0NiZbTvDJb+YEJKZjYgaTxr5rVw77mhfe2rNucKVkYpla6QZUOxIXeMMv7lEeDbKktKzDZoem1MILR8WdENHu11W1Bx+dT6+fQxtNaGmLVMkbn/SN5pYg6hwPI0uGFawU4zM+Id7eqkufO6OkWn57ccpCFXm6f52BwXZdzwEtIaUi5baIi6XJk5iBk6c0Xge/ELQKJKTIELeEeJ4IcBxr4TDJXbXgopoauCAWeqEeNRfNfLJy6B0lVWutDYtq9qfydUUGsNRIltV+TNaZnmJHq0x16R+/gOzIboa7Qf4wqYqhrgSRDGQCW9vObdadQRAms8Ukj9Mei30vc1/COaJ8piDgTRlDSDAIRR4wy2TDgZytchX9M1NaGUIEjV2BPt3CYzPZ5ALMUSGFKL8R7Qcee1KhdoYPy40xnqKcJqE7X29uUpZYPbIp1cyHmOUZ3XqcyeobqJC8NCZWEnDyFzOYWL+XJsKEgrU36ImkZLNKoKOicoCpLpAemL3eLt8RR4tLnOVST8fd/IEKrYGF/ZFLlX+Cr1rwPiBZp/NjW+I5EJ9FQMwntELC7dcajs0vtZsokM6V2ct9Fov1K3Qz+VYjiOoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(44832011)(1076003)(186003)(478600001)(8676002)(83380400001)(6506007)(53546011)(86362001)(38100700002)(66556008)(2906002)(7416002)(9686003)(316002)(6916009)(966005)(6486002)(52116002)(66946007)(54906003)(8936002)(26005)(33716001)(6666004)(66476007)(38350700002)(41300700001)(6512007)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8nxsq0gqLRUTxSk6vsdHvshABllE5CZqLfl3AnT+fDitWTNmijKDkFSs3/a?=
 =?us-ascii?Q?R35WA3UjgNVfrc4g5Cxfr6StYX6nYslcv0nk8mAnQPT7hybXt9Hp8OwXHrlm?=
 =?us-ascii?Q?pm59vzQIdW9xam7RSlhVz51hzVueTsU8rDQ4WY7WUl5CvZcYYv+FjaDQgfXl?=
 =?us-ascii?Q?OZKlIN9/Sgn2T+f44Vb1SLcAwFjeszXEAAWsAFyDHWHwJ1EOZ3Ei+LTJMTUl?=
 =?us-ascii?Q?VpCg+HCAlON81A3dfJ+yMEikSvN8fz0eAmcqc8XKCl0UhjAYBZc2Y5pGcyp0?=
 =?us-ascii?Q?4q2x/oBlSrp8pMqTAB068EwRLiuiTRCDvmZB4e+9DFPqRAHo/IXK3g1ViRSt?=
 =?us-ascii?Q?peXsg4v6ud8h1u2a1Hxdkiz5RVKzkAUgSRlUSosBy6GIdyXwUW5dpD90E8Pa?=
 =?us-ascii?Q?6iy6VtjFZn3f7OvVdYexnDgAusF2VdJmCp0woBOYXmNTeCu5yROISdOQXgPi?=
 =?us-ascii?Q?mIV9+9mDfLltSAHm9acwwjCVP/82JPV5Unl4ShpOD0p8DwXItfncU00Hj9/u?=
 =?us-ascii?Q?wGY/wYsLtiNtW6MIvAnaTIblig++OjvkOoUTI0Uat4VPKGdfNZa4ANlKO0BF?=
 =?us-ascii?Q?Z1loh6HMRZL5M6piNa2nsYIOiz7fNZ160EUqd9yp9iqbWqpAUD1dJ84HnTqg?=
 =?us-ascii?Q?zhFyWanIdHZPLUdbHy1a+2crubZvy06SGlYrNBY8MW1KxmEoS/3VM786I14H?=
 =?us-ascii?Q?BJeFZWIig1H/BS5tzXauze/S5OwPehhOlt3b/EBTTVrYWHuKFeAedRNhdPDf?=
 =?us-ascii?Q?lZhAOlzs02IW17uDH63EVVDw5Uf6QS/HoF9bWhVbRvnX7Y50g3G+pgiEMXOV?=
 =?us-ascii?Q?k8HU3hpbL+zv54jjEjZdsVC0/+dJhIwDTFy0Ff8DRY8mVQOyBEyFJPqjd1Ud?=
 =?us-ascii?Q?UfBn8mxJ6+vKHoCLOJS0YhfstIOM8ow2jZ1OBVoBpYoPo/B4HkkrDlQSTGBK?=
 =?us-ascii?Q?u4bC3qIy6A3MUOtmAPlp+Bp0nM+rkSrmxTJSCfZ23Iyq9eQUMMvw378I59ls?=
 =?us-ascii?Q?6H3vc9EwnFi7Hk7OqIjq7h19QjvVU3HeEElEFOc1UADohE3pCSN8bW1hsn1R?=
 =?us-ascii?Q?0TAgAEgW9ULUNZsNqjkxfabpppTTpp0PEGF+tb1VfQa3KhDsYwUSYfI0cKyp?=
 =?us-ascii?Q?ZqogtFRaN0MLQsYXGYEJmZEmKrA8rdUO/3UZ3ZxuLtXR67cumcMQFZ9wnMg1?=
 =?us-ascii?Q?yM+8/Vd79J9914DkvDjhYx63zafOhEGqmJX1LWATx/qLOO6w5V2QZc1by1fs?=
 =?us-ascii?Q?GY8p2XxieNC2ltvFE2wdIgQ6Sn1P3MwUXHKlrF9BRqa1KgJMA7xwWXB1swwm?=
 =?us-ascii?Q?KAdIsMwIN6nJbEwqgOKvZKO5pOJH6EGBez7xeWKs/KwhkdvaPc0MuMgoopJC?=
 =?us-ascii?Q?7808hky9rMB5GNjMMSmXmQmRTijxIlomUFPuBabO3libQxDPWBbaRTWujeov?=
 =?us-ascii?Q?PD3FoEta5OaUbTcqGRq0gHPV2WJQfHL7E/OZ6W1EDDAF6C8c8kZ0aOyepoR/?=
 =?us-ascii?Q?s3hK7YI4A6FH0oe8uV2dtCnT8uSj8mkxN8AV1XmC9CotiBaLvvZgcLt7loMx?=
 =?us-ascii?Q?N4lZa4xUkbNu3goZ2NdGw+f1ZoZlIVPAJ2Yq0ldJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fe207b-720d-4b55-30a0-08da97cf5e20
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 10:36:52.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rBYOH9X99n+SvBD76EMZaz9/qUYRfNr+1QH3P1bJBVLNj8npAi5dIyl6dQESKGDgP4KuZFQxvFAJjIFkyXyyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9417
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-16 09:43:51, Ahmad Fatoum wrote:
> Hello,
> 
> On 15.09.22 20:18, Viorel Suman (OSS) wrote:
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
> 
> Above comment literally says that you should never remove defines below.
> Please provide a better justification why you deem breaking DT backward
> compatibility acceptable.
> 
> Thanks,
> Ahmad
> 
> >   */
> >  
> > -#define IMX_SC_R_A53			0
> > -#define IMX_SC_R_A53_0			1
> > -#define IMX_SC_R_A53_1			2
> > -#define IMX_SC_R_A53_2			3
> > -#define IMX_SC_R_A53_3			4
...

Hi Ahmad,

The defines you mentioned are not removed, just redefined in the
backward compatibility section added in the end of the patch.
The patch follows the same approach as in SCFW kit v1.13.0, so
it's much easier to synchronize them.

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
...

The only renamed defines are below, the reason is that
VPU_UART and VPUCORE* defines were replaced with ENET defines
in SCFW kit long time ago, to quote the author:
   "The VPU UARTs haven't existed since QM A0 was supported."

> > -#define IMX_SC_R_VPU_UART		366
> > -#define IMX_SC_R_VPUCORE		367
> > -#define IMX_SC_R_VPUCORE_0		368
> > -#define IMX_SC_R_VPUCORE_1		369
> > -#define IMX_SC_R_VPUCORE_2		370
> > -#define IMX_SC_R_VPUCORE_3		371
> > +#define IMX_SC_R_ENET_0_A2		366
> > +#define IMX_SC_R_ENET_1_A0		367
> > +#define IMX_SC_R_ENET_1_A1		368
> > +#define IMX_SC_R_ENET_1_A2		369
> > +#define IMX_SC_R_ENET_1_A3		370
> > +#define IMX_SC_R_ENET_1_A4		371

Regards,
Viorel
