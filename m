Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F90647CFA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLIEjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 23:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLIEjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 23:39:16 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A4D389D7;
        Thu,  8 Dec 2022 20:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGygBM4VYujejhSp/DVadfCqmHrb7HQ9M3Ib4TRLDDkyF8GMfRag2CfWUrEYWdONJ/7w2QEuVR6gCsR8R9EXUMMYz2cF5aX/jtwuWoCwA6OKbw3sPX2BpTV3LiOrw6CwC9sPAo9FRCw9IbhIfq+56abVo9U4MzgL9RdVrdvuwo1RIHussWw0OEjBKapbZOEnxANG5wY84ndtQD0Qf4jIF5ylvqplstEbPMP54XWYYamAiAXVBJbBKPVKK/R+ox+NYr/OTaf5cF0D2MpByFjLPCJ4LBbGzGE2teCHYR7Z5zFrnGtGVY/mUPRquZvo3wb+TeZj3M8y3laJ7wDra5ehNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krYM4wEtvuuArgN0tfvokRxHJdMqM2aZ+R7FZv7J7rg=;
 b=O2ooEx083I/YFarEKM0DEypQwXFGbhSTFyKds4GEEqmaxC5yTBK766Bcm7kjOMUeqbuzuJ1z48q8ZX1uE/7WOLkJqFIDvktIZQNjwkyC+PPiqgpo3kS9i4ZDJwxaXgutIWxp08f7bTnN6qPUjubtgCcariJ8+ik9d0XJJ6U1CYDr399bz9JF/61kMz8eK7w5pkvKQ3BMgeIiUG1KwdH+zKn3nOjNDHdgfAssBB59nJ0asavCAJ+b1fhK61/SJp155UawscwxZBBx60HWbloCVHTZRt9Qnfs0adbW2D263pmKRdKjiBmRsu/k/un5k5a4SkNuSzRUMr7p8Egni4IJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krYM4wEtvuuArgN0tfvokRxHJdMqM2aZ+R7FZv7J7rg=;
 b=qcKwtr3Lc8gudq7UqHOSypMmudkt2Z+oS1loSg7iQ1omxE1HYwfhARtQavTwlwE2vRlCFD2r/2jn9OdE+IOd0G+Xk7Qq2CPhCeFI4FeTo5vYRZC490T5iX/SG5FFsaUlFNSUFuXrKsqae5S14uSlBhmwwNwRjPKLLjav+DwECjyTyW3wqFqZ5BiH5eSqDCS4TKiGBjxattblXLv+h1INTjjk2hrP7rx+iwnHJG8QJeR2NgHbZu9bPeCS4Gbkhe911aKvPahZj54UDVMe66D2Ql7Vucj0iRpohmStBHIxCmIqhhPs2GKuVJFPez8Sfqt6c1FxMsPMOUHslOctyDEmrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM8PR04MB7377.eurprd04.prod.outlook.com (2603:10a6:20b:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Fri, 9 Dec
 2022 04:39:11 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5%7]) with mapi id 15.20.5880.011; Fri, 9 Dec 2022
 04:39:10 +0000
Date:   Fri, 9 Dec 2022 12:38:51 +0800
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v2 2/2] pinctrl: add NXP S32 SoC family support
Message-ID: <Y5K726npjKAO4sIq@linux-8mug>
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-3-clin@suse.com>
 <CAOMZO5D0wJcfbFsvUN3K17S5F4zT2Yf8yQB+wMKQPzuMBitrpA@mail.gmail.com>
 <CACRpkdaKYFbXRcV1WgDEiYPEwzNAZq-AqAHpWd1rJyW-h369dw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaKYFbXRcV1WgDEiYPEwzNAZq-AqAHpWd1rJyW-h369dw@mail.gmail.com>
X-ClientProxiedBy: TYCP301CA0034.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::14) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM8PR04MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0497b3-462a-45f9-2ace-08dad99f50d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P892p19npaRtH/1LKjs1HzWb9WeBKXJ/OJhU3icv4F8pEU9CpHPBtnGnSQDM4REVDitPnT8KPRVvnD4pa+iiGXS7k8+alZHfRDJKQCTIr4tA/2iATFfqioBJ7zGeNfJGk8ercwZHaURo/qXcFAjGpJRUVS9rA0Z6sjtpdYWlenxgoLHtMKeW04yg+tafddnZHnXssptInOca/2fRQ1CcnmTqAy70E6/qEKnO95teBUvnKHByysJYpoT1kP8KbW/2b+dvuLH9nAcBWoevuHXqELreF7H2RDqBva88KQY3JeHCCHOu7jmapA1HKuwiUFHIdrNGI3Aw4wFApmgRmCrYVAb3bkuDkvhx5dmNGeYsKoyBvy/2yjxpyKgZ2FBSrB0OyofYMGC8exg7Ymd7AVZioajnPLwnTF20CS1V0O3Fl8s6070OBZftuGH0wjNJkKr3nioXCejq0GHpMZQr64Fn5u1KhgSjdo6Rsc8MuBkj2qYW3oNyg2/nAj5/TOYWJSyC2s6FY48+yHCmvGlsxnq94K/VPD+cmchcLoHUxN/+zseFoOp2OaX4NkYiSZJqGyG1IqxQoxsXP4Yc9A29GQllK8jUL58nw5m1DezfZRJuffxpsXew6Sa0FAIJKnJ6+BNDyYg8/ULt/NMDWw20CSyw5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(86362001)(41300700001)(38100700002)(8936002)(7416002)(5660300002)(4744005)(8676002)(66946007)(66476007)(66556008)(4326008)(33716001)(2906002)(9686003)(26005)(6512007)(83380400001)(316002)(6486002)(54906003)(6916009)(53546011)(6506007)(6666004)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNKyglSeoUfzmJQ6xnMkV6KccDpAgL0ChcwEQDLgLVkBkmwElJ6JSwvHn4Ar?=
 =?us-ascii?Q?oMFVn+46Wc87BWm3mP3fSozK4h5ODdi7WcHfVrBR5TjTdKSCWsl+7fnlgOKg?=
 =?us-ascii?Q?K3Cp8J79lUbdV31dXliMxhmJNQRm42Mvr4oX4tnhz04oCMc7aBg+1MgnqhhR?=
 =?us-ascii?Q?/rickF7/DKtcocdaOxEzUuydIWACd6B88aqTcAn/mGw5FKHtQYcm/I7b+KrV?=
 =?us-ascii?Q?RWcx5JjXMkEAK7qp2n/JaSWWLPjKsG4TXMJi3kIdoPfwFZjPl1RP1vuAi1gy?=
 =?us-ascii?Q?5Ycw886VIACGWpLpPnv62dvBs8GmMD8RIPvKxcrTqjNlvnP07CeRJO5zRRPS?=
 =?us-ascii?Q?hiAu6JjGvLH3ljXkLTqTp0kDyDywk+n6zV/4C933jtBnGDacRYKsf+r6zllt?=
 =?us-ascii?Q?1u1kzFW1s2WWNehMp7GuxBC2iRf0O9aoCGk4hN9A+OhGjX3aPa2vlVyz3pqV?=
 =?us-ascii?Q?8xaJAHXSWafk3UamMVOFF6pywncv3dqqcUr/XWBFx+h1BYOVV3Cj6oeu1w8D?=
 =?us-ascii?Q?Jr+pYxpY17LeZc6bXYFp/sFdLIuN9ow44A/q5K5iLxOjNevLPXtDLYsxSzU8?=
 =?us-ascii?Q?NyXgOthW+8DZIaMNoKEUaeyXbHTH5xlSnvh/Ffrj9YY9qAdOWSBGJso0SD9w?=
 =?us-ascii?Q?I3pcJqIJKtMJf5gtSOSbINgW5cNbnO9G8e+dtXo917LHfZpnUy0jq6e2IHOV?=
 =?us-ascii?Q?3e7n6ZirYUILIjVQJ9SARNTg9Mu3NS9wE2qXXinP6FOwyuB4HSob3h8pzx/j?=
 =?us-ascii?Q?U4MCW5IrS61Kl4h8Ff8sKiT/mGzZ9dP6wJWu4tNEBML2jEvRgF14rdOStyc8?=
 =?us-ascii?Q?l4OsXYY8ub0XUphP5bSGYxVJkvjPxIuvN/GeK5ALGH7qPXt9Y971YY10f1mP?=
 =?us-ascii?Q?2vbgRwfa/daR29+3X6TlXWIflW0Ds9asy3ZK61/NlLelyi8GEpTyXxpNkRSX?=
 =?us-ascii?Q?0BeJ6kyJoTIMhAqm7NWTEDLUeQ/0HBva3gY57vmkkbMdm4tG8A5gAr2mtcGF?=
 =?us-ascii?Q?uvljVN+k6FeWKNhF9vO8GQyaqE/A4GnRY0jVJY0ORsalvfaz4XQrWzxDhW0W?=
 =?us-ascii?Q?kXtzMQilU6lGiiONSfRtk3iBTmBJcNfilIteTfW5Dcx0bi5BOTYpwK+1v/fl?=
 =?us-ascii?Q?0V5tjW/NDi74Kp4xo4zj6tpDdTp45c25ytl/IcRqyM/gmQR+JcQfDi8cElOD?=
 =?us-ascii?Q?Fch95r/2KChLLKvPyiIoio7pAeN74XY57Sc8+HmzgF8co/c3MsTpyhU+h+mS?=
 =?us-ascii?Q?NV6DPvfnU2zeknkHxPD60TFMuf5zKgWrvAPxjBqIQjkomYUGF5+OoGwut7ZW?=
 =?us-ascii?Q?NW6jJZk8wC8Jhuj1WbHtZ93nb+DvDpvw8CPZwoijlClpUHs82wgIbZrgO0mG?=
 =?us-ascii?Q?kOoWcqKw0X/yiXm42lqK4TM6nQqMPjhTfWd+dY3odX9/43I5zlmcHMU7SAqq?=
 =?us-ascii?Q?NbKcY3/Gh1YfNNjrGG1LXUeL0qOIp/g26J+o5SqPdMLt7BtC/d0Fm7s3te8j?=
 =?us-ascii?Q?xXbKqkQNqmI8w3a0oOUaDZrlufpCMxFhBJlEM7y2Nns64BRbHokfeHlm7AN1?=
 =?us-ascii?Q?2zfiwdqu1Z3b0JYN8lM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0497b3-462a-45f9-2ace-08dad99f50d9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 04:39:10.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqZHY31qdB7xzfRzsNRqJSjalYbI5kKGGsy0YsJaTXZBUQr4Z2SXHbwKmOO0pRgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Fabio,

Thanks for your time to review this patch!

On Thu, Dec 08, 2022 at 10:37:36PM +0100, Linus Walleij wrote:
> On Thu, Dec 8, 2022 at 12:04 AM Fabio Estevam <festevam@gmail.com> wrote:
> 
> > In other imx8m pinctrl drivers we pass:
> (...)
> > > +module_platform_driver(s32g_pinctrl_driver);
> >
> > And we also register it in arch_initcall() level.
> 
> Do you really need that though? This driver certainly does not.
> 
> I was under the impression that recent changes to the probe-order
> logic has made most explicit arch_ etc initcall orderings surplus.
> 

Could bool/tristate options in the Kconfig be the key point?

Based on current design I prefer to build the s32g2 pinctrl driver as built-in
rather than a loadable module. IIUC, when the driver is not built as module
then the initcall ordering should still matter.

Feel free to correct me if anything wrong.

Regards,
Chester


> Yours,
> Linus Walleij
