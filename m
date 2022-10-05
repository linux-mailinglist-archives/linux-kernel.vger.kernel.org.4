Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04B5F5110
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJEInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJEInk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:43:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB531222;
        Wed,  5 Oct 2022 01:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP2s9jy2ATVvsNSAyk6Kk56oVFTdlVdFYiGHfoperIt3geOa81ItpU+Vr7Wm1wHysoojhcm90qyYfKcvP6p5QaI1usCauaLHvJ9oxtj1qbfgxkCI54E8RmKQUZgInBWzO7+dVTe3qyP6PCmdaU5ZEI92MwBZLqHrez4WE6rWlISVy3pfIlw4Udyw6rFabK6IYTSp4Xh7uvD9LclbDnGhNQcBf3buq6ojtKH4KXUdQ53KqNyFpTp+lt4MBsWfvRbNZqnoXJlS79spoVVK3zABBcg2a/ehDsz7f5S3w/4crrZrDzcqYi0LaOSC4wMCocbgliUgb0fqbvcUPP0xfnh0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO7HuSC+qG699Jg1NZkrtCG9Xq/rBo6JUpAUSXfC38I=;
 b=WkefzcGAIeqHrlVPcrmdXEP2tDqN5XIywfzTWau+xCwOMwGZTkcsbiPdkx5z/KxuYmprPzT4SjVpTijnZIu582WxRwzjDuPfLr82zWXa7d5qXyzeGDkNFztDQYghMhEbmGNTGvinN0UiCjQlTvYCAwX2ivuMxFc08n3yf2G0bIXalFXCka0WVMudinHe4VKQqBBz6j4OtK7xn/I93aQyK4pVlPVdhLTLCRQ94pP9rA00NJ1JQ5FobAeafoYcIjmotvmZYAtf8Q5wJ6wjHyPRSdLHKg8iVfSk6T7hLldtudV3SI4xc2gs973K3OLR1pAawQIMDvZLmRaq61m4hgsIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO7HuSC+qG699Jg1NZkrtCG9Xq/rBo6JUpAUSXfC38I=;
 b=jdTH7mbBPqGooeNYtKIv9J5aKv0YMQTouFihZkmrA+4YRydVJSdaNuZEFt55uIGYulorOn7vmMpj3jE5PAcvTaRI6V0Pfb7ABWezbjpm1bsrw9wItL92XD0tKLjJ00KB+a8SPGgmRPf06rsEkwxSFZqxc+EUlnyHYeb58a34/nFQNgADFCcCHklxBsIxoIm5af4s+dWZSrpnIriLSZJIEOKN070eGX78Ckcp67EtjnCmXFSlYh1teumUyD5SouzW13l19Doy6ZZcajcZ2uYSJi7IIbrWG8UJ8VX/tPzRKAlnE1nvnPYqrijNbT+mzOCn2NHrYyTpAp3pvEA2/v8ouw==
Received: from HK0PR04MB3105.apcprd04.prod.outlook.com (2603:1096:203:8e::20)
 by TYZPR04MB6636.apcprd04.prod.outlook.com (2603:1096:400:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Wed, 5 Oct
 2022 08:43:35 +0000
Received: from HK0PR04MB3105.apcprd04.prod.outlook.com
 ([fe80::6b9a:1628:86cd:af11]) by HK0PR04MB3105.apcprd04.prod.outlook.com
 ([fe80::6b9a:1628:86cd:af11%6]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 08:43:35 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>
CC:     "patrickw3@fb.com" <patrickw3@fb.com>,
        "garnermic@fb.com" <garnermic@fb.com>,
        Delphine Chiu/WYHQ/Wiwynn <DELPHINE_CHIU@wiwynn.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Bonnie Lo/WYHQ/Wiwynn <Bonnie_Lo@wiwynn.com>
Subject: RE: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Thread-Topic: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Thread-Index: AQHYyNQMAFo+dL1NvU+j1+FW6/gp2q3j24EAgAQacrCAAA07AIAXlyMA
Date:   Wed, 5 Oct 2022 08:43:35 +0000
Message-ID: <HK0PR04MB3105AE7BA97942C160A6939AF85D9@HK0PR04MB3105.apcprd04.prod.outlook.com>
References: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
 <10176630-3ff7-54f7-8836-779e5a2bf6d4@linaro.org>
 <HK0PR04MB3105F759F43FEDE24C24FB3AF84C9@HK0PR04MB3105.apcprd04.prod.outlook.com>
 <61de4c6c-84e9-345a-495d-4d44d9351d84@linaro.org>
In-Reply-To: <61de4c6c-84e9-345a-495d-4d44d9351d84@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR04MB3105:EE_|TYZPR04MB6636:EE_
x-ms-office365-filtering-correlation-id: 69c18ddf-874a-4a37-a955-08daa6adb0b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kzE3yqRRLEEsknQBTNXhZnLu+wk60rpaHBJByI+eRfZ/nR4qB+MZWOs2dvxOZW93dj7yOqBAlo5cVSQI9XwLqp1NeDvC2hIEwlJSxwK63kdAYw7TKf0TKIrWD1O5mF1tQkVbbxoex2tB1WQSWH8/sXh29+ur6x10vGq7CP5C1USgSwr6czds09pnVG6KbvF+82MlfLttIzgF9hnUKbGNHUdFDiLQNvgjL8Y7GJzjFkkvs7XpFuHu61UepBnrXbGxJLju9EMa24Jf9Aze0xIOWEQvnSzBC6gZt0+oQqDZ6G9Y8CpsFV/Uqm+bh2l8RhU6Xqg2MgedKsUK5PpjM0ECxJIalxU5G+6tedxg/chmcIC7kREqJ3DirPIME/G2BSlPC14QtSHtY6pjAFeGIdzkRhLxaQzJ/0aGemBzcAG6woy8+A950Ri/lWSv+gJKh4cMaLze2IKCMo1RmeMD3FV/DYpdgwtfaVoj9pQHIG22Q5ZEhtHTGTuDD5mfcKve4R0Z73tmhqCx/i0dDyCKSYCOVcpEylKh0DjFy87h4iP72ndji1DMZTF8in+pCjuC0GMbmS5k6A0ZXeYzv3PNdmSvwMoflWt/P7SgqQI+uJRPSponyiY6+8NRyEIVR685FdoVNNpztgAWieFX+6UmIh2U/loAJBjWJxqFhr20fK3YqjnMQ25E7/04NE0fEqYeoSgmfnnSGO0K16tAsCUDLxxabPG795IQPvSFk0rfXkOmWWD04oU3Ie8KSOnQIuwHYI7haV63p9CIMKwu/JJO4pNlAZgXaQDMGrhE1ZlYf4ZWtHc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3105.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(376002)(346002)(396003)(366004)(47680400002)(451199015)(71200400001)(7696005)(45080400002)(52536014)(107886003)(6506007)(2906002)(53546011)(478600001)(966005)(26005)(8936002)(4326008)(9686003)(64756008)(66556008)(66446008)(66476007)(66946007)(76116006)(83380400001)(41300700001)(186003)(7416002)(5660300002)(8676002)(110136005)(122000001)(33656002)(38100700002)(55016003)(86362001)(38070700005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8s7fGkypg2g2kZHNFhtb+yddbpNJ4PgUz76y9oTc0lWwbFGuEMGtIvc19lxL?=
 =?us-ascii?Q?rYQ6lgve+p+5+iOBPD9SixP7OM6B07vO9dD4WEdP70KWzIvMIImBEzHArR79?=
 =?us-ascii?Q?k10m13XNjVWKMIHOZ4v+E7vvzBTfbeNS/z4APDlq4UcjypuJHUMe/qIHnR4D?=
 =?us-ascii?Q?abV+YKn8J9aKao4fykDKyjUM4vBxvznmix/Ix4a6cgs1WEv+SAZlvgFghNpo?=
 =?us-ascii?Q?aBPP4nbN45I0TVwN4CpVSBmjmPt/Zrcgca1O3tCKmDr+lzn9pyn+fj/dMzAl?=
 =?us-ascii?Q?u1NDLzNQhl38m5C5p7SRpgmSzgGTkeA2NYSiH+pWoPgeQBV5jttQU4o1dkYY?=
 =?us-ascii?Q?nhKhhvaFxUKXrSeQBmZq085WTlSABSFKo/tBAt8t9PbeoZ0jbRtrjulZTZtt?=
 =?us-ascii?Q?9d/9qSpklJaqlxGVv+IKe3dlO1xAEA989oLNAq09GaXo4Z6fW3tj0uwFD087?=
 =?us-ascii?Q?LMfO23s1bSccqIFZno4oYSDlNukAlhO6YynHt4sRZaC2Hj5RzK6RCo5GPcRg?=
 =?us-ascii?Q?/skDpXOg0Us3JOjBVx75TycakHmA7b8dxxBWkJ2qQntIZyHZvX7svwX11BEK?=
 =?us-ascii?Q?X+tnLaEIwZ62qLGRiEsVddyezpM5+ZDfmIjctiazDS4mnIjGfjlXDGPIqoQ2?=
 =?us-ascii?Q?2gh96FEnfw0abGcggz2RgTS4wLmKB1p4axPZGgb8KIUW3236/XV3JQR0Jnxc?=
 =?us-ascii?Q?9aE8o52bkIqOaFXfXFy2Hy6A6k6Vo/g0+rOvJ/KfXRIG3fGtna7AL5itJdVy?=
 =?us-ascii?Q?XU9ETvlyHKhm5B4RL/bGh3OchQ2tVRVpiRtoQjAxlmEUsccGkkVWuiYcVWPF?=
 =?us-ascii?Q?r9WTL9qc7SOvqnA1SN8WfDB0uqEks1Fxa1HIHwEesLxz9XDIYkk0yT8tc1hq?=
 =?us-ascii?Q?jJ/i1cnrecDHtPQQBxbAbOaAhxo9xJehKQNrbwGZAbEdGjFq9EDmuA6KGfZ6?=
 =?us-ascii?Q?Rm89oiQuBp6XxWn5BL5x9Jry1KSAK1FhirIrTyY+bgTU2/JibVL4LyTTTYhr?=
 =?us-ascii?Q?0ygF/nTBCs8ERpNOuI2KOIbdVv0htKoiVeu4puSXvQMUY5XbUq5JEiz0QK2R?=
 =?us-ascii?Q?Ev01v1WlJHflJUDnP2TRnLdh+9SsEnjLw+IB4+PXL1KR5N97klMe7dywIk+c?=
 =?us-ascii?Q?kTsQpbKa+tHTUyWzihXMgENidduLLQ9aPkuyw4Ffc5rKZIuIL/EfZ8fWD7rk?=
 =?us-ascii?Q?cGk9Q6hJ9lAazWdnsDRVO1P/o2SAtu4VQNklBiUB5CsIWePgNL+3QYQRhOPZ?=
 =?us-ascii?Q?r+aLpZNWVll9mVIHkkFNYzsfbomWnyTzNnZhxgQLCrUzkTLKklk43/W21YR5?=
 =?us-ascii?Q?kp8auMUkQgfxHnNGJqUt+iUQO+/omsoO686+HzoCOO8YpcM5Ww4y72nLgELn?=
 =?us-ascii?Q?QHooXpTFbGJd/9bwMhvk2fvvJQYqpM193UeOznhAagzfjTf34tBe9qiSm0Xw?=
 =?us-ascii?Q?Pv94BzWnuaerfHLhBkOWX2TzUt3A0OD8zvgj5Nwy/ZlJ5Dn6vEJtsibMhjn1?=
 =?us-ascii?Q?WI/6SDjrwwdvbmEx6EnpHgmuNFTZKEbQ0K54Txsm/l2MnujU6Ir4cPdnXlpX?=
 =?us-ascii?Q?CXGj9lOcNDZos7FuNlaR8HAcPWTHjv4zJVbjbHXo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3105.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c18ddf-874a-4a37-a955-08daa6adb0b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 08:43:35.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RExotmK4Qp3N/aLv3FwE4cj6l5p+mdZoyFp3LLwBO+cMUDI8wJ9RmoHdRL5io00w6eBGdsK2bQoMVpOV7GGNtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 20/09/2022 09:45, Bonnie Lo/WYHQ/Wiwynn wrote:
> > Hi Krzysztof,
> >
> > I revise the device tree as following and resend the mail.
> > It create a new mail thread " [PATCH] ARM: dts: aspeed: greatlakes: Add
> Facebook greatlakes (AST2600) BMC".
> > Kindly to correct me, if there is any problem.
> >
> >> Use subject prefixes matching the subsystem (git log --oneline -- ...)=
.
> >>
> >>>
> >>> Add linux device tree entry related to greatlakes specific devices
> >>> connected to BMC SoC.
> >>
> >> Please wrap commit message according to Linux coding style /
> >> submission
> >> process:
> >> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fel=
i
> >>
> xir.b%2F&amp;data=3D05%7C01%7CBonnie_Lo%40wiwynn.com%7Ca2eecb3c2d
> ff4eff
> >>
> 361b08da9ae190fd%7Cda6e0628fc834caf9dd273061cbab167%7C0%7C0%7C6
> 379925
> >>
> 90848633103%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
> joiV2luM
> >>
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DMJn
> u2iv19
> >> dvbcMH7SJSExKOFV18dUtGRFSKO6Au2tFg%3D&amp;reserved=3D0
> >>
> ootlin.com%2Flinux%2Fv5.18-rc4%2Fsource%2FDocumentation%2Fprocess%2
> >>
> Fsubmitting-patches.rst%23L586&amp;data=3D05%7C01%7CBonnie_Lo%40wiw
> >>
> ynn.com%7C1dee8dcb540a49522fb608da98cdba6f%7Cda6e0628fc834caf9dd
> >>
> 273061cbab167%7C0%7C0%7C637990306620286314%7CUnknown%7CTWFp
> >>
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> >>
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DmC2E3dJbuYgXklS%2Fw8s2w%2
> >> BKH%2BZ3CsZSndFTgPBjyvpw%3D&amp;reserved=3D0
> >>
> >
> > I have add " ARM: dts: aspeed: greatlakes:".
> >
> >>>
> >>> Signed-off-by: Bonnie Lo <Bonnie_Lo@wiwynn.com>
> >>> ---
> >>>  arch/arm/boot/dts/Makefile                    |   1 +
> >>>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 248
> >> ++++++++++++++++++
> >>
> >> Missing documentation of board compatible (bindings) as first patch.
>
> Why did you ignore it?

We need to look at this more. There might be something under the Documentat=
ion tree.
Could you guide us an example for adding the document?

>
> >>
> >>>  2 files changed, 249 insertions(+)
> >>>  create mode 100644
> >>> arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> >>>
> >>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >>> index 05d8aef6e5d2..40fa906ab17f 100644
> >>> --- a/arch/arm/boot/dts/Makefile
> >>> +++ b/arch/arm/boot/dts/Makefile
> >>> @@ -1580,6 +1580,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> >>>         aspeed-bmc-asrock-e3c246d4i.dtb \
> >>>         aspeed-bmc-asrock-romed8hm3.dtb \
> >>>         aspeed-bmc-bytedance-g220a.dtb \
> >>> +       aspeed-bmc-facebook-greatlakes.dtb \
> >>
> >> Wrong order.
> >
> > I have reordered it.
> >
> >>
> >>>         aspeed-bmc-facebook-bletchley.dtb \
> >>>         aspeed-bmc-facebook-cloudripper.dtb \
> >>>         aspeed-bmc-facebook-cmm.dtb \ diff --git
> >>> a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> >>> b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> >>> new file mode 100644
> >>> index 000000000000..f011cc4d370f
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> >>> @@ -0,0 +1,248 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-or-later // Copyright 2022
> >>> +Facebook Inc.
> >>> +
> >>> +/dts-v1/;
> >>> +#include "aspeed-g6.dtsi"
> >>> +#include <dt-bindings/gpio/aspeed-gpio.h> #include
> >>> +<dt-bindings/i2c/i2c.h> #include <dt-bindings/leds/leds-pca955x.h>
> >>> +
> >>> +/ {
> >>> +       model =3D "AST2600 EVB";
> >>
> >> Wrong name.
> >
> > I have revies the model name " Facebook Greatlakes BMC ".
> >
> >>
> >>> +       compatible =3D "aspeed,ast2600";
> >>
> >> Missing board compatible.
> >>
> >
> > I add board compatible " facebook,greatlakes-bmc"
>
> And what is the output of the checkpatch?
>
> >
> >>> +
> >>> +       aliases {
> >>> +               serial4 =3D &uart5;
> >>> +       };
> >>> +
> >>> +       chosen {
> >>> +               stdout-path =3D &uart5;
> >>> +               bootargs =3D "console=3DttyS4,57600n8 root=3D/dev/ram
> rw
> >>> + vmalloc=3D384M";
> >>
> >> Bootargs usually do not belong to mainline DTS.
> >
> > Removed.
>
> I still saw bootargs.
>
> (...)
>
> >>>
> >>> WIWYNN PROPRIETARY This email (and any attachments) contains
> >> proprietary or confidential information and is for the sole use of
> >> its intended recipient. Any unauthorized review, use, copying or
> >> distribution of this email or the content of this email is strictly
> >> prohibited. If you are not the intended recipient, please notify the s=
ender
> and delete this email immediately.
> >>
> >> This means we cannot take this patch. Proprietary and/or confidential
> >> patches cannot be merged.
> >>
> >> Please license the patch as you wrote in SPDX header.
> >>
> >> Best regards,
> >> Krzysztof
> > WIWYNN PROPRIETARY
> > This email (and any attachments) contains proprietary or confidential
> information and is for the sole use of its intended recipient. Any
> unauthorized review, use, copying or distribution of this email or the
> content of this email is strictly prohibited. If you are not the intended
> recipient, please notify the sender and delete this email immediately.
>
> Your company is still adding proprietary license. Since I am not intended
> recipient, I will remove your messages.
>
> Best regards,
> Krzysztof
WIWYNN PROPRIETARY
This email (and any attachments) contains proprietary or confidential infor=
mation and is for the sole use of its intended recipient. Any unauthorized =
review, use, copying or distribution of this email or the content of this e=
mail is strictly prohibited. If you are not the intended recipient, please =
notify the sender and delete this email immediately.
