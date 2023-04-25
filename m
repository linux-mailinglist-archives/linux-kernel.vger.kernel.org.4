Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35246EDD08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjDYHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjDYHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:46:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1737093;
        Tue, 25 Apr 2023 00:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDaPWtdv/9bN576laWhJzYlfkFDGpImzG3Xzs+jLl9FR6kc91g5IJu5Pjltfge2gxokC7YFBAwlGpI11/G/jRS2JfH73bl2PNfYHzA6sVGPcKaiqGnkO0Tlw8EHSHjMyJBm0uoSLNxnYZ7MCEZGzz+yFEfhXrz2On5SgWD9LgjZEqrA53jqHrA3MqNAeOf+/jK+DYrolK9H2xq5WutnurUrWhBHNV/qnjevfFc4hVEqImSrFUYECzNRQxb1LTR8bUomC9glI5l5zpJ89x0iT+Xi6zmktWvy2xjENtszt65i1GEU+i44CSEJBP0twA97phhiNTJgcsZ7K0RRdh/T6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGeqvL5cQmRE/clzvih5eW72uuSL2zHMAAxlqd2/z3Q=;
 b=VFlPCm4fQkLKrAIbGd7wf1z0fQnONDVoH4Vt0QJXD+FIVralpikZoEVTaJU65ij60DGYiaaCqD2vRPCnsvYSUMqUDEZu4OBoLdKkel9a6ZOVoLFga+80IveU9ZhvCWYmrXkb4R11f5ctNu2930dVxnWYDccuU9leZSLTVC6utekqKUCqVJne3qbkct2KXHDl+V0ZUBerMQmbW7zUud1lPhbr0O7TnPBIgIMGnTD1SNZowu4mlo0ypZbuGDR40IT1JVPslrLCZxDOrz96wJ3gblV8ddHZw7WP2uMMxFiw0CTfMMguQeXYkLly68dGFlvFDujvd/rnjvkwMtDwGfKRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGeqvL5cQmRE/clzvih5eW72uuSL2zHMAAxlqd2/z3Q=;
 b=veMvBik/141HdsoRdckcgzfh82DwijyUH5u5BHu3LSvm043Iw/NaJdUoIwAoGKUxMemFD8GrEirfhl5r27s5xRqdBd60n6A85aB0a9wshNE7tmmsw+8rm5N+O+jVJ0SW8lN+ZxMoA50FRTmuvy5oAOrPp74hKmA5lNjl+r9oPh3YAJT42VtYzhlj0yEJjfWoP5v7lnxcRmLGPMz118HZ8nod8zf7GuOaQ/Y1YeTeQPfnDdQwjKiIeQzG7k5oq8YbTb1Fycisrif5GYnKWs2gZcKQvX0e5OGeYcuHxqCXPiuKsC0YdGGLeK8HfXZresJVj0dzSiryAd9jZMpLmIP7HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PA4PR04MB9224.eurprd04.prod.outlook.com (2603:10a6:102:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 07:46:26 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::1f05:8f31:47e7:d6b0]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::1f05:8f31:47e7:d6b0%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:46:26 +0000
Date:   Tue, 25 Apr 2023 15:46:14 +0800
From:   Chester Lin <clin@suse.com>
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        NXP S32 Linux Team <s32@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: s32: add missing cache properties
Message-ID: <ZEeFRpfL9TTYF1Ow@linux-8mug>
References: <20230421223202.115472-1-krzysztof.kozlowski@linaro.org>
 <aa3c1fda-553b-fa71-21dc-41d1244007a4@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa3c1fda-553b-fa71-21dc-41d1244007a4@suse.com>
X-ClientProxiedBy: KU1PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:802:18::21) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PA4PR04MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5247e237-1c3a-4b0d-247e-08db45612c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVTK8X56/h8aV3fJnlxAWbbjBDRfY9Xd2ALcS/Mk5jn3Pf5xBUkIeYf7QzcmXPIfepyn78atRzUP4amL0DX4gtCQVvWknpwMCDvUa+d9V24lf4Ahu21qETHcHaus1j7kxJfKz26DLxPKv4MnQjTwEYpgOp5vkxD2tO53IR6plY9UGxQYPx/17pYh3CRbzRyR1f4nOZrW2iM6xJlfz6uYvs+IB77KeuPZYLb0YOERDM3DDmjLB5AWxBXq6sBc0zIbnBAUkzrSKS58w12qvSIa3tl6Nj1APDJPx+mVbz1MEEDwPpC/JnFEW48PVc0JmlKlxo3U5zxEcq9LrDs8v+CUF19cJCou+2b8V3o087uPyEOLF4HOJfkekOyi7M/fnUcnc/bWWMzJi7FMs2Yj3Ofu1fLAjWqyZHXF+x/yfzd4a/OdIVgZvmcpoF/GmUGMGDMKnLC3onzA22QMxQTTsdzWmMMjtOgAlGK6i2uXdklh78z0o69+4cOIlWaJ3ELOdcBGtc3A8IvKuDyewPM0X4L2CZh3i10WUc288d44nsZ9qPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(41300700001)(5660300002)(7416002)(8936002)(8676002)(6862004)(83380400001)(53546011)(186003)(26005)(6512007)(9686003)(6506007)(38100700002)(86362001)(66476007)(4326008)(316002)(6486002)(966005)(66946007)(66556008)(478600001)(6636002)(54906003)(6666004)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zdWKAcfuGz+/elvTp0QbX+4rsVPBrIfMwTeZjtr4h0vf/+XMjpyg+4XfDr0D?=
 =?us-ascii?Q?QmTj8jttORBjHrGGv7mMfQgHQJELmgVw36eE05FAnmLyA3936ovbrGAtv/dF?=
 =?us-ascii?Q?LIf3D/uCAkrHswHmW96qCwOla0X/otV3rxeW3U2voV8NWgX4slYZVoGlJ9s1?=
 =?us-ascii?Q?GJNBm6wv56r5jRiq7hlQQj7cGQTJ4QtUu0UbB3u3iKAru3k8WxA+VrlD7Zhm?=
 =?us-ascii?Q?Ow/sxWXc/0Iimf9yGYvIvawbJceF8ocl3HAg2+YmKsSk3PA361NlbZN2OpIc?=
 =?us-ascii?Q?q6IiAwOIoQa9IcxPipqMslxqPBia10Wpj10+QWPUWBSEKyLO3xW6fREPKFps?=
 =?us-ascii?Q?kPCAGXSDHrwEDJ49osgmG+rU3m7ttwjyYBivbPQsGGUj9OLnG2z3IVeDqhLs?=
 =?us-ascii?Q?gJ14XQpDikV+o5ACtaXOlkAMIMrmjn9lk6evFFvuaSGGdZ+TBrKG7FKCUWQg?=
 =?us-ascii?Q?VJrBvWJwB7lBJ5/wcyR1x0Te8k+z4KR743U5yygvGFhRRKz17lDoCaA8tof/?=
 =?us-ascii?Q?KPw1f3DuoT1WiM7RSltNj69uQp32R1FZzvTR0rO4P9vxFSl80zHR1XwNl5LA?=
 =?us-ascii?Q?DBF9Np6x3pRoo+bgOgvd/OPJxvgKwpTVvtyeVPC5xjwQRDoWVd8T0dM2YSki?=
 =?us-ascii?Q?z56k4AglbdI5TSE0sT6FaiNKz9c1ovzCgzogVdKO1CN5HTLpvysRjFJ/TfrZ?=
 =?us-ascii?Q?Dytzyakc9rvliPMI9FhqUUEWhXDYFhcZ5N9Upha1UGPdjVmJSnLOe3374HlW?=
 =?us-ascii?Q?7nH7BNY5jgetRTFwA7R418hcQP6NDazUqXbLZnMX8571MMF/zr0fxrBV5kAD?=
 =?us-ascii?Q?2LUijiUoPi/2cV894eSVA/97uXN6tG4OGS2JBjZIY2jNMjl0wlKpeO2CQ4j8?=
 =?us-ascii?Q?kanbx+0i9K5UrAXEmu2Alv7AFp7nEHPUQ0r01jj0NBF+IL0EzvguBpUHDhSk?=
 =?us-ascii?Q?sDV+5WXrI3fjfsk+x+8i0J3AOJdGGReJnhieEN+c3WaizAG6g/d/wPYdG/i2?=
 =?us-ascii?Q?Zc+vagE7E41REq63JRjtaYOMt0DFo0Q2ph2+glxRLpDbImcCxyzocZk8UzWf?=
 =?us-ascii?Q?9wI9giPAiciC1wOk1LXD1w7NoLcBe0zxA6DSKuVSJymh1bSvBXHLxUdA82mt?=
 =?us-ascii?Q?E+xadR97a2lmLxJTghGpQVVWl4Xl4zDvT9e6953wQd4F0nOpmTzNRBc8OwA6?=
 =?us-ascii?Q?H4pNllxgVxvYMUH1AqKFxCsuEidlD2oy4wzYCcfT+doE4kUJRKMzKxlG/CcH?=
 =?us-ascii?Q?pFGISd2v6LgPqbMlOYRaMBvClW2m/G8qj/4OdDPyzLXIcP8lb7IR+AsHi0Ha?=
 =?us-ascii?Q?S+aKa/IhVUsI7fjP2zj//b235YRTmlEnm/5NWrjlj8PZpj4LkmVn/JspCd5I?=
 =?us-ascii?Q?+l/JjuKP3ID9eyqhbsAMAna41vPAy4TJ1gKFj0lYnRq4NYM68m8uSzf78wVM?=
 =?us-ascii?Q?Yf0PObZroVB/6cBmqln9fBaxMOKgKSVH92kcRbHEvQiCN3uh+IHe99tjGK+P?=
 =?us-ascii?Q?bi++qlGizy9jDIS94AFx1ZveQhjWqJ3blOX8TH6ARVUmGKMFuMQQg8XVFecw?=
 =?us-ascii?Q?uHPANn8xJb/Vad4hyfo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5247e237-1c3a-4b0d-247e-08db45612c4d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 07:46:26.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7z5mYlWJq5/+DvUhGtlaAmtPzT0VyieVYmOJq4RU4Kem4P6HUvJWiPS3AOuZdtM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9224
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 12:37:34PM +0200, Matthias Brugger wrote:
> 
> 
> On 22/04/2023 00:32, Krzysztof Kozlowski wrote:
> > As all level 2 and level 3 caches are unified, add required
> > cache-unified properties to fix warnings like:
> > 
> >    s32g274a-evb.dtb: l2-cache1: 'cache-unified' is a required property
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> 
> > 
> > ---
> > 
> > Please take the patch via sub-arch SoC tree.
> > ---
> >   arch/arm64/boot/dts/freescale/s32g2.dtsi   | 2 ++
> >   arch/arm64/boot/dts/freescale/s32v234.dtsi | 2 ++
> >   2 files changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > index d8c82da88ca0..5ac1cc9ff50e 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > @@ -53,11 +53,13 @@ cpu3: cpu@101 {
> >   		cluster0_l2: l2-cache0 {
> >   			compatible = "cache";
> >   			cache-level = <2>;
> > +			cache-unified;
> >   		};
> >   		cluster1_l2: l2-cache1 {
> >   			compatible = "cache";
> >   			cache-level = <2>;
> > +			cache-unified;
> >   		};
> >   	};
> > diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> > index 3e306218d533..42409ec56792 100644
> > --- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> > @@ -62,11 +62,13 @@ cpu3: cpu@101 {
> >   		cluster0_l2_cache: l2-cache0 {
> >   			compatible = "cache";
> >   			cache-level = <2>;
> > +			cache-unified;
> >   		};
> >   		cluster1_l2_cache: l2-cache1 {
> >   			compatible = "cache";
> >   			cache-level = <2>;
> > +			cache-unified;
> >   		};
> >   	};

Applied to https://github.com/chesterlintw/linux-s32g/tree/s32g2/next

Thanks,
Chester
