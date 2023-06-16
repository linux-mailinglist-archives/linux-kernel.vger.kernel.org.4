Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3A7329BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbjFPI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjFPI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:28:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295C2D69
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBQRk/Ea4S0fLwFQo7V5alDd4RYQKuMAGFUmkMNT0youHyWu3cr9MuFoK6VZom4n5+XLDIKYks3C3Y4iN2OD8tVO4j50Ukyf2MqmINiMGwqjFBF+BQ9/AM3+VU5o2p+PM8Ubk7X3GKlNNBLEymSSwKJionFFYtNAUU+vA0F4QvrpQ9iZaagpGvuYbss/SNECR75wdQWf3DJ3Vmw3AdXs1zGJ2KfKSurZjhc8ntt2QLRz/tCCNoL6EkONgZEG04Wu9/puz7JE3eFr/AYFdt3SfMhyx6u6M+P8Txjmv4PqeADRqFMC1SrOmFnlCHLK7MGup6nMfypqkPVYKNr93EwR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TDQSyu5QOQk2J654aSu8ybSzCtQyVYRYh2vUdE0khs=;
 b=DzA6/3FMZqdvaVBU+sOJUQSwrpRwfGqVRuqN0tAEEn4F6bbGl4Y7dsR0NKHkuiJZ/duRxeZUFz1DKQc1NZy/zBwBXUhZD2byDOcPNMladdjJKiPqU2pUloabPfsRINoNSkJdqjZCgBFZdGtI2nCp53ggPIHrIPcI3Ao6+s6yCho1inm/UDUjcVXQgEaeYeqTVy46GtpVV8ovnExlEAfYA+C/jbcAk+qifLsV+VBd5SMB69+6m3C1ZBNrH49TmyyTrTQWqbBDkh6wEqhGLMITJqL8aS3FRENIuub6fMWyG4RQOcqE/PY4w2RGPimVVVixXzA93DNyH4Rm1ulrjQ9qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TDQSyu5QOQk2J654aSu8ybSzCtQyVYRYh2vUdE0khs=;
 b=beN1p1CvAM/810o6LFpV1jA6GBTMIolwqVoS13aWgZAXFD0+xLy7v3fS5H8ylxdnWKL0QMszJe0uzC4yokWSepnQZ5ha2+6NlBTYMzNoEH2N4v8F5ZlpcuKwGhnaYh2inqSe3PQvU//EAwixlx/eCRQYHaojIwSq696E4bgE+s8=
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 08:28:06 +0000
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::95c3:f23e:1b24:e99e]) by AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::95c3:f23e:1b24:e99e%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 08:28:06 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
        "X.F. Ren" <xiaofeng.ren@nxp.com>, Feng Guo <feng.guo@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Thread-Topic: [EXT] Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Thread-Index: AQHZoBVsg6habxYIbEmfvjjh7HkyA6+M9moAgAARzFA=
Date:   Fri, 16 Jun 2023 08:28:05 +0000
Message-ID: <AM9PR04MB8907E5BF0A7F6448B2F7DF6DF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <20230616055913.2360-2-alison.wang@nxp.com>
 <2023061616-sacrifice-mollusk-737f@gregkh>
In-Reply-To: <2023061616-sacrifice-mollusk-737f@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8907:EE_|VI1PR04MB6813:EE_
x-ms-office365-filtering-correlation-id: 87e7c1c9-0e6b-4e6e-be02-08db6e439bdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: miHMY3lh/p3EUiHUTQQ02RXnOafzPtvSGVrce8DEd7z9wm4oKa0adY+bHdW0UMZUmvd/mBQx2Pc4WrSwyPxjitgCn3OSggEiX5PxgVYmS3LsMbXBUEkONcYuNDuK3cCcpdIKIt4uSfWQfx8tHX6kAys/BX+R9fuIo/98bK2QEzYmcss8KvQHpBlBpeWPKlbTrDGYWdkApvNie3QXohoxL4FYylyc/FlQ4QzScW6JCUDRYXqEtserv+SO6L6grG4HSoW3EygzGA/5efbjCXGZYsmd6MBiGk5muYLRB9ZWd1P+rT4k2qCpf1ZrG6WzqziYzgnN+BwQMElJh06MVOsuJOe+jd2yvI/CVvJz258z/PQrMsoMwaLbsx7wI9t4qaZVV+sabX+smfFpQycyG68mOyZKMluJSteC7hIVK6U+McbMrMbfL9SN1fBXMBaOLtTfXYDjrr2VCjsjh8dgAkJJB2tYIeWO9vtovTTXTozvGgtS/7N+6wvG7s4/ZQwPNndzGofvPSBW/fz+/YgzZDMWci25FbFWUx/KdLdsz2S2AlNKWR+SSsbhLHfF4EBnH5WBnyQC0/nIV/gz+ma6syPnuBocBKNUVUML9FtDJGsTmXZbMAR0G1lzN1Bh4P4Pl26m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8907.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(71200400001)(9686003)(6916009)(4326008)(66946007)(66476007)(316002)(66556008)(64756008)(66446008)(66574015)(76116006)(6506007)(83380400001)(186003)(26005)(45080400002)(122000001)(7696005)(966005)(54906003)(478600001)(55016003)(38100700002)(44832011)(52536014)(8936002)(5660300002)(38070700005)(86362001)(8676002)(41300700001)(33656002)(2906002)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zctHAZv+Y+KE5DbVkmQmKdbG/TSvtrcKmMQG+v/9xoRbEjZhKatVIx1KMl?=
 =?iso-8859-1?Q?m2Yhu+7DroJKoD+WnH8qH2WxgPkTkak62RJyPQQCaWN0UoAXdHgqLEaJdF?=
 =?iso-8859-1?Q?mttqVJRMVl3I0YXJmQfjhw8012zBOqZPUKEM6iLX/I9TGNaF72hAZIvoSS?=
 =?iso-8859-1?Q?oWDMKyXY98KOe2r44191gG7Q7WST/zSzEfoWS4KDy9/A6CMVZwq20XeQPt?=
 =?iso-8859-1?Q?nfItVTcqnUTGnKtgzuBMFGmHzRJOgpJk9PZRWSqdiqxJasIzygzMse6w7M?=
 =?iso-8859-1?Q?l4wywN99jH6/pfYCO6yjjsB7IrHi8ViJj8U1QWqqiytpUq4gMWm6I14DwF?=
 =?iso-8859-1?Q?BG1CrJvjbYFJjAU/vt+ghBEr7V677JJMjMSvirzeJRLf4kIVtVu2BoCgAk?=
 =?iso-8859-1?Q?w8P1tSf82uSIP9NH3V5yPoK/UVgGbSwpR3ZL35Z7YHijTAq3TE7cRELWDQ?=
 =?iso-8859-1?Q?n3noQ+CfrE5Z+YLVGquPVJtunyUSP7YbMEKnUWRXIKyeJzz0Tp+1fVhmU9?=
 =?iso-8859-1?Q?whGx75C1QKKAsOU/lFpKbEMZST/wbW9VuIus9iOa/8o2mejWcpYfA9/Y0x?=
 =?iso-8859-1?Q?yU4YyPNMP2PIZrPmINnOiTsDPEW45tf5zAtl+qmqB9ejj1x+HAr/Q4WUU6?=
 =?iso-8859-1?Q?+LNJIIQ8i4g7R0ZuV+qq0pTs0NraJH4b7i2M2yTc69yHgoqheDUIZ1gY7G?=
 =?iso-8859-1?Q?9Qdsaa8Fg/OjMV9TGz86yXIFjosN5X8T1ktswEhWsAVX49B2Fv7ZYDiDDM?=
 =?iso-8859-1?Q?EHAktu80McoyBGydgQD3qGBY0yzmidAlZ0J8eqeBDNMp6syqV9swxseXgk?=
 =?iso-8859-1?Q?daWAVYk6u0KNkdc2O71dt0ZyIxk7ujHt6xA+dMFeeCURkjUmERMIW+dvtE?=
 =?iso-8859-1?Q?rEwEv4wBVAk4l+zqmTWSLuEv/AWTiaJ4tHcAK6XHibM9jv/KHmkNaR01Bd?=
 =?iso-8859-1?Q?i9Yn1ZZwdnC+kDq6O/o2rGHl5l/vQfJau6qXZOY2oVu1eSlhKDhKOdE1ZU?=
 =?iso-8859-1?Q?ngYhcjhOZglrrfqEXpL48lvsPJ+JBtCjHey93xFO5XEIKTnA7ud4hJfhM/?=
 =?iso-8859-1?Q?ytSfE/7DARYFwUSi+gjvTOVjjFSSVAYxqiyaEDtRp5DW9vvQ4lZM3eMQku?=
 =?iso-8859-1?Q?0vhFrIVnGGkQNkzS3SGg5TsEc+v4zxaIGl8FSIgZAOh0gShQoWiN51lADM?=
 =?iso-8859-1?Q?CuJ2VH9Zg6ktRTrG3c41vc4Gs2FR8RX1vwCet9uBVALROYP2j3VOlWHKQ3?=
 =?iso-8859-1?Q?u3H8TnV2Bu8Jltew6VXB51fMDkbq91BCO4jR+cQ6E1VJIiad8MXGu0QlGL?=
 =?iso-8859-1?Q?VZ4/GRPlcbyXU8UsJ3y59u7ZpJ1AeutkngocCqxCgVzzIqFdhnsqcdoTA/?=
 =?iso-8859-1?Q?BV93aRtoc3clqbUbnRL5ahI37G3e7EfAQ5HXB4p9oouEabjlmgcB+PR48/?=
 =?iso-8859-1?Q?Pf/iexW65+I7C5KLyLL5B8TXtpvJEBLPawAz07DJZ+08Kjvtp3J3ejVV3s?=
 =?iso-8859-1?Q?HIu6EK4p1dG9TtcFFnK1tDR7dmi+GSZkiAF4/IRhCPnnx86kAvKbCraSrG?=
 =?iso-8859-1?Q?sV5PL4PpvpKtAHPShtFybx1coSJB3xvoxJBdMUyq9+Ys5+YSHxFv1U5ZFF?=
 =?iso-8859-1?Q?VFWLfvHNyPnukOen/atqO+4qkXh9mWpc0x?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8907.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e7c1c9-0e6b-4e6e-be02-08db6e439bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 08:28:05.9804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6ikwbcCwlAzu+0j/GFrRA4a0ZH6OD+Ys1qbyp1WoSwGWVp2lGc4LKp+a0bwPyUco+NFYbCZeKnjYWdbNR6bmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:59:06PM +0800, Alison Wang wrote:
> Ethos-U Linux driver is to provide an example of how a rich operating
> system like Linux can dispatch inferences to an Arm Cortex-M
> subsystem, consisting of an Arm Cortex-M and an Arm Ethos-U NPU.
>
> Link:
> https://git/.
> mlplatform.org%2Fml%2Fethos-u%2Fethos-u-linux-driver-stack.git&data=3D05
> %7C01%7Calison.wang%40nxp.com%7C4b1681cd19b9450e832208db6e32709b%7C686
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638224935139578328%7CUnknown%7
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Djwhvw5i1Q2M%2FOLID8TsOOnaI9LqD6y%2BMnn
> jzdvdCXcw%3D&reserved=3D0
> Tag: 22.02

What does "Tag:" mean?

>
> Signed-off-by: Kristofer Jonsson <kristofer.jonsson@arm.com>
> Signed-off-by: Per Astrand <per.astrand@arm.com>
> Signed-off-by: Jonny Sv=E4rd <jonny.svaerd@arm.com>
> Signed-off-by: Lior Dekel <Lior.dekel@arm.com>
> Signed-off-by: Henrik Hoglind <henrik.hoglind@arm.com>
> Signed-off-by: Davide Grohmann <davide.grohmann@arm.com>
> Signed-off-by: Alison Wang <alison.wang@nxp.com>

If this many people signed off on this, it better be correct :)
[Alison Wang] The source codes of this patch come from the kernel folder of=
 https://git.mlplatform.org/ml/ethos-u/ethos-u-linux-driver-stack.git, the =
detailed tag is 22.02.
So the source codes of this patch are written by Arm guys. The above people=
 are all the authors. I list them all to avoid any missing.

> --- /dev/null
> +++ b/drivers/firmware/ethosu/Kconfig
> @@ -0,0 +1,24 @@
> +#
> +# (C) COPYRIGHT 2020 ARM Limited. All rights reserved.

It's not 2020 anymore.

> +#
> +# This program is free software and is provided to you under the
> +terms of the # GNU General Public License version 2 as published by
> +the Free Software # Foundation, and any use by you of this program is
> +subject to the terms # of such GNU licence.
> +#
> +# This program is distributed in the hope that it will be useful, #
> +but WITHOUT ANY WARRANTY; without even the implied warranty of #
> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the # GNU
> +General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License #
> +along with this program; if not, you can access it online at #
> +http://www.gnu.org/licenses/gpl-2.0.html.
> +#
> +# SPDX-License-Identifier: GPL-2.0-only #
> +
> +config ETHOSU
> +    tristate "Arm Ethos-U NPU support"
> +    help
> +      Arm Ethos-U NPU driver.

{sigh}

With all of those people, NO ONE ran checkpatch.pl on the thing?

I'm stopping here, please go do that, fix up the obvious issues it tells yo=
u about (hint, no SPDX line and drop the huge license "boiler plate"
texts)

And also provide a REAL configuration help text, 4 words for this is just n=
ot acceptable, what would you do if you were asked to review this?
[Alison Wang] So sorry, I didn't do any change for the issues you mentioned=
 above for this patch.
My previous idea is the first patch comes from Arm guys and the other patch=
es are written by NXP guys. It seems this is not a good idea.
I will change this way in the next version.

Thanks a lot for your review.

thanks,

greg k-h
