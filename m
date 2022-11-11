Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663976252D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiKKEtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKKEtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:49:31 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B31275E;
        Thu, 10 Nov 2022 20:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjB5BHNHD3NqgJpPHlqba3oPqNtCQARBQ9kLI3rVHIEWCm6zO+TOoPnyOd2YcqV3gYHM3iKHjV7ZgQi6N0l603AXnRt8wUnI3tTfnW7ppR4Rb/FyxMJY7l0oy8SLjGFTpEVhIJnpMa4tRMd+wRInICWByGdbBT30MjI+atyObrNMqTJpL8HBylY6ouggawkGUEqaCLIIIKVd4N4LeBh/xn9+VGAIbtBWNhRKASV/fYuSJ4EU27yeJEKw/K8SYuiU1VeDz5VzXIxBjd/IUjP0C9RraImai6uq2Ojhb0pA9L5QcabYWi++ce7z/AJGEWD+Nv8RMsqmCg56bnx/0WQ4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCQtni6Qan66lP1P2KJ2ZSMhQOEso8DAGxDBVzIc/oU=;
 b=dGQnqORTvyWCffnr0Ylq4NOIjiBi+H5eL6+mHeyA9OwuH+uVPLYZh8uSy6vqIEgTjdjS5dukTCAXNsUVg+EIPKzb84dGjgr7u2Rd8+UbrP1K1JhrkysY43ZnoFsvRNeaMurZcgJ3Hd2mAiv+Hj5S41clSoe5JB7L+k5SrC22/vQ0ZkiJ+7N26CG/7BG0B1BE+xWNRcFDS3rQ+fnoV96Hih0cEEj1X3YMRRM8GQteedT0uqawrR6VkclBJ0hAWvCGmbkaPvAPhhCdG0VrH8XdsTWOym0XViap0ak0sRSo0umKHfvejkv23OMnr6jir+mBKGvoDS4Wq8b0QU1HULErWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCQtni6Qan66lP1P2KJ2ZSMhQOEso8DAGxDBVzIc/oU=;
 b=a2vttbBEv//YEMi1ggFaXEkIAIT8VDOv6ji024BA1EmB6J+ZBGs7DUaqCZ/i08gh3bUQsMChxTF1+3YIAbWX/5tHdICJq7zy0hkmoV3YnplQSKiRy3GG3SU6S6GNAB7oLCEFV7VWhMLkoi9d1EbKn4VeLjll4baVyy8o3c0fSyVlkiAXsBFNT0aHDBl+AzKIAhVEJyhy73bzE0Pn2AtIidNGfkpA0j63Ff4Fsf26pK0WxPbsxuOIFUMA6zs8KWXHqt0ZP4zCfFijoeuJTyBZCj7pOdSFeX7zopjAhjVUtTwAi1UDd+w6KrTw3irIcQ3WyQQXdVKyjwdtkEx07HU1uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM9PR04MB9004.eurprd04.prod.outlook.com (2603:10a6:20b:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 04:49:27 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b7c1:3e11:9b46:28c9]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b7c1:3e11:9b46:28c9%4]) with mapi id 15.20.5791.025; Fri, 11 Nov 2022
 04:49:27 +0000
Date:   Fri, 11 Nov 2022 12:49:08 +0800
From:   Chester Lin <clin@suse.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/20] arm64: dts: Update cache properties for freescale
Message-ID: <Y23URNBaDS4wmykw@linux-8mug>
References: <20221031091956.531935-1-pierre.gondois@arm.com>
 <20221111025553.GJ125525@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111025553.GJ125525@dragon>
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM9PR04MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: db4c05d2-e65c-4b01-d5a4-08dac3a01c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDaCoj6QcV8ORF0BWiu9ZuYGFnxYHlwZ8u9+OnwLheK/+ID9FLQuvhCRPwOd4Qtd4/C5p0AbfBxIxWth34Pv/61YrrgxMRSHnu01z0geKvVgQMOMS8V2mOTLHGMXGXwamHjeg9dA8AKo49yXqgs3s4c7Hk+jWKj1+sPJIGdNwdHg7KpreABsqDS9rx33w85jDeVBWec9w0c9eBEg6iBkbyLigjYgS7kN7n8B3mLeaq+DyK9ApdH6yM5sL55nItm8nzH97qfoGtRh83YA8kzoPh3+7cOXFWkfYBk5iZF+TBVF68EbkgIs4aN0XEuPQjBIDt8yqkJD9GctGidkVJVkUdR7lvKat5dzs4UMhJc54C4BOaD2L/p+ICmSle+Y4Z7uqdOpYTEuXQ9YaqXnpl9kbEJYcwJPhD7pisXtHmv4xTeFBGm0+g4Nkr4/HJaUOBIVODVkSgA4UMRf6E7XL1DvhVhGZS50JU2EH2/HNcAHDnQz+uFms4iQK3s7gvEcj3FSAeFVkYPEYtoT5WVicmoseqfH0maAj3IxzhUvRZE0GnoegqJmDj3uVr/niTsaHRNKOLBTcOeRYinAxwt3WaDQl5Mqqv2nYhnrbR4u6b5S7NjIOAZ0PgXHfKYa39StTRxVsW6XRAW9NB2AH+yEIqbuN2dHELvfHxl0w35YKLNtg+RcvaQ+F4jxGl/uRaX2xHFNHNCUxuF0UCfknMIIR2HVAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(26005)(8936002)(6486002)(4326008)(86362001)(33716001)(38100700002)(6666004)(478600001)(83380400001)(6506007)(41300700001)(186003)(9686003)(6512007)(2906002)(66946007)(8676002)(66556008)(6916009)(66476007)(7416002)(5660300002)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6T73ZpYAg6D6z3GLU1gU84NGxlR1ypFwTcgkYsduJUhvUTGUfZnaPwcgrou8?=
 =?us-ascii?Q?Oo63D6y9mTj7KfmFbJsfz/4iFycHsqx6MChbR78fsBwbjiU9BOkqhFwu9Y2u?=
 =?us-ascii?Q?esm0uLELLvPYOOgO7tXJZ6DjEDAYd7+l2t2aTrPkmu9T0rFea/NQBCpZDC/P?=
 =?us-ascii?Q?rM5UZ2Oni5vnO/VDu1c4Yi3p6fTMPZFDXamTIFuzClp+8pV9EYkU0lCgDn2S?=
 =?us-ascii?Q?FgmnVn7q26jrVr33IbHzCXHkWJ5K5B3WOBKuA6Onr2yxG/ZxAzgCMeVwDJMz?=
 =?us-ascii?Q?QdvIHq1vQ25l2lNnfrQQGHf3tSi1mVUXcQvWbSy5vzSllCN5sF3zaXKy4mWo?=
 =?us-ascii?Q?UaR25i/JkqX9pDsRn0Kuxmwqz7I7WT6/uZnONSOitz4bG6Grl9MTpLGL8psx?=
 =?us-ascii?Q?xoj7T4agEHtj8xe7ctaeHPT+yTzIvzURCw08ZC3U8phxDXcCOmh1cHtJe9yx?=
 =?us-ascii?Q?RSX/Ld0W368bQo8bR5Jnyr8+1XzpKqqzcTX3uyvG3oQx2uii2ipnITWz4Zfe?=
 =?us-ascii?Q?TYTHShDNlzPa4tYItu0agL0WZlGlXnvfbZxGcJ/is2026I3c5q9+4LDAYqgT?=
 =?us-ascii?Q?faYruBUE9C0xZAXPXjIU2mvAhPJrY/AtY96dRlSAZxX180KsyIDp6pH8h8UA?=
 =?us-ascii?Q?J/IHzsJi8rY/VNcfzF85fFsWM2vrP7T4QlhCscvaerXQ3r/28mxYrPpOLCtV?=
 =?us-ascii?Q?BVJgYLY61hifHhsYZWI3gh06dX10Y2rQ7exBgE/S/J7KOTKpSsIdNIhKkmkg?=
 =?us-ascii?Q?OUJTmu9adyE5T0rb2oTnlWxuVEQ0BV8G7PDOquVCJPgy+4xNuszSmdymuFDv?=
 =?us-ascii?Q?ZuvmTZL6dnYzbs3337SaOPpVf8GlGqRStZb5RVq8WSVQDDM3T4nBofaQuamW?=
 =?us-ascii?Q?ed2SrK8O4eEY4rRMojOtMP6vpmqYM/FfuuCOocDGtQbI0Dkt5Z0SivTAKg3Y?=
 =?us-ascii?Q?gtZ1naK5hmnRVC4tyQSLN4B1p4RRjYVdNQaHHwvnAJMsS+mpAprTtDATgWwN?=
 =?us-ascii?Q?IjuMM90oMhFv9KApiOSGTr1JC756DeETTVaoOMQhvMRym6+NFnk43sy28sVB?=
 =?us-ascii?Q?lmLNQqfacT0aPunIYqIr2UgW1SWSTFSz3hV+UhCcY4ZQy8DqXqUz6jTzTFo3?=
 =?us-ascii?Q?NGzyBaJFqivDMl7T9Kpipb3HU8m5lQTgZiFTZeJe/xNsHZnrcoHb3LFxesnO?=
 =?us-ascii?Q?wdnWxTdGaRW2xepsVPJu3Scf4PbO/tKbhRqDmgc+V3AXn7K1gXPjDnWeWk8Z?=
 =?us-ascii?Q?8OGc5ltdnOVchX5yFn2fhnuW8TQHI9fJrN2AJ6U2UJfy8yK+y6ZyX1TAK6cU?=
 =?us-ascii?Q?ODGo/BmHwJucWVVGgXEISLm5gx4szfMnxX+npgO97mPEm/AZZC/e01Pvzh67?=
 =?us-ascii?Q?+AfsVry6PyfYzfWXshORmEax4iXyoiXbBq8Vp/T6CyOVS565gfjPsDoBZKxZ?=
 =?us-ascii?Q?QETH6za+eanSUQAOCEzze1H2ivyWQp8V2nY6EIWUDN8pol3VHLXAKzvUve//?=
 =?us-ascii?Q?XIf88PsDe5cH6IgV+xEPaMziZAxTc77n+YR04XKp61UadeUgpGmnY356Jfk/?=
 =?us-ascii?Q?IQYrd7DajgRGWnoW20Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4c05d2-e65c-4b01-d5a4-08dac3a01c8b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 04:49:27.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEOiiF4T69J3nX6MH4xZCIceXQjMQefF7emB4NcsOhwuSMlaGivkZPOALrc78e/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Fri, Nov 11, 2022 at 10:55:53AM +0800, Shawn Guo wrote:
> On Mon, Oct 31, 2022 at 10:19:51AM +0100, Pierre Gondois wrote:
> > The DeviceTree Specification v0.3 specifies that the cache node
> > 'compatible' and 'cache-level' properties are 'required'. Cf.
> > s3.8 Multi-level and Shared Cache Nodes
> > 
> > The recently added init_of_cache_level() function checks
> > these properties. Add them if missing.
> > 
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> Looks good to me.  Should I pick it up on IMX tree, or it needs to go as
> part of the series (via other tree)?
> 
> Shawn
> 

The change for s32g2 looks good to me. I would be grateful if you could pick
this patch to the IMX tree. Thanks!

Reviewed-by: Chester Lin <clin@suse.com>

> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
> >  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 4 ++++
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi     | 1 +
> >  arch/arm64/boot/dts/freescale/s32g2.dtsi       | 2 ++
> >  arch/arm64/boot/dts/freescale/s32v234.dtsi     | 2 ++
> >  8 files changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 5627dd7734f3..ed0cc1a5d17e 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -46,6 +46,7 @@ cpu1: cpu@1 {
> >  
> >  		l2: l2-cache {
> >  			compatible = "cache";
> > +			cache-level = <2>;
> >  		};
> >  	};
> >  
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > index ca3d5a90d6d4..c8b1202d2584 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > @@ -83,6 +83,7 @@ cpu3: cpu@3 {
> >  
> >  		l2: l2-cache {
> >  			compatible = "cache";
> > +			cache-level = <2>;
> >  		};
> >  	};
> >  
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > index feab604322cf..4590bdc076b7 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > @@ -78,6 +78,7 @@ cpu3: cpu@3 {
> >  
> >  		l2: l2-cache {
> >  			compatible = "cache";
> > +			cache-level = <2>;
> >  		};
> >  	};
> >  
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > index 6f6667b70028..2a7e13b6ef8a 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > @@ -95,18 +95,22 @@ cpu7: cpu@301 {
> >  
> >  	cluster0_l2: l2-cache0 {
> >  		compatible = "cache";
> > +		cache-level = <2>;
> >  	};
> >  
> >  	cluster1_l2: l2-cache1 {
> >  		compatible = "cache";
> > +		cache-level = <2>;
> >  	};
> >  
> >  	cluster2_l2: l2-cache2 {
> >  		compatible = "cache";
> > +		cache-level = <2>;
> >  	};
> >  
> >  	cluster3_l2: l2-cache3 {
> >  		compatible = "cache";
> > +		cache-level = <2>;
> >  	};
> >  
> >  	CPU_PW20: cpu-pw20 {
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > index c3dc38188c17..c12c86915ec8 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > @@ -95,18 +95,22 @@ cpu7: cpu@301 {
> >  
> >  	cluster0_l2: l2-cache0 {
> >  		compatible = "cache";
> > +		cache-level = <2>;
> >  	};
> >  
> >  	cluster1_l2: l2-cache1 {
> >  		compatible = "cache";
> > +		cache-level = <2>;
> >  	};
> >  
> >  	cluster2_l2: l2-cache2 {
> >  		compatible = "cache";
> > +		cache-level = <2>;
> >  	};
> >  
> >  	cluster3_l2: l2-cache3 {
> >  		compatible = "cache";
> > +		cache-level = <2>;
> >  	};
> >  
> >  	CPU_PW20: cpu-pw20 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > index 60c1b018bf03..187353458673 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > @@ -50,6 +50,7 @@ A35_1: cpu@1 {
> >  
> >  		A35_L2: l2-cache0 {
> >  			compatible = "cache";
> > +			cache-level = <2>;
> >  		};
> >  	};
> >  
> > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > index 824d401e7a2c..d8c82da88ca0 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > @@ -52,10 +52,12 @@ cpu3: cpu@101 {
> >  
> >  		cluster0_l2: l2-cache0 {
> >  			compatible = "cache";
> > +			cache-level = <2>;
> >  		};
> >  
> >  		cluster1_l2: l2-cache1 {
> >  			compatible = "cache";
> > +			cache-level = <2>;
> >  		};
> >  	};
> >  
> > diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> > index ba0b5305d481..3e306218d533 100644
> > --- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> > @@ -61,10 +61,12 @@ cpu3: cpu@101 {
> >  
> >  		cluster0_l2_cache: l2-cache0 {
> >  			compatible = "cache";
> > +			cache-level = <2>;
> >  		};
> >  
> >  		cluster1_l2_cache: l2-cache1 {
> >  			compatible = "cache";
> > +			cache-level = <2>;
> >  		};
> >  	};
> >  
> > -- 
> > 2.25.1
> > 
