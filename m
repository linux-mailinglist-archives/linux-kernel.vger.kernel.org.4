Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241535BDEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiITHr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiITHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:46:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20627.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B683AC;
        Tue, 20 Sep 2022 00:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhfRQ7O4wrnvXqzKi1IH4IbGyl2uduyjo6yeOL1dJubTwh8BOSq1ovm7djXnHDOjp408OdA8XlSYJKHlBpJy7Y8mmBtrl3XFuZXQ8yGY1hE4N9XkXD0IwHzFMr1ZgSEGqm65eyIueNbTN1Z3y+oMcH1D2EK+cri0i3Cney33g6uq4OH2CllrUQsK49j7EFNtWghf1sV/ddaoWs5rnFeB5eH39vHkCwGBi7Q70Er2EfYMRIaPatu9lKevI9b7hGzpr4are0Zee14UucBmBPAuaLarvlBUBrHLgU+Pb5FW+NMSPjZjKEJpDFT2iGpwMgu3lMS6jA3ERzKvIaTf0gFNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ90A0la84uECePEQ2C7nsNUEi7uZtTqmjEGCUdU1Qw=;
 b=nOuC5uaI8IrG7xDfZVPROfuL70tz4eTWtM8DKJ8S0mw2A7z66K9jtJYKmR0AcEaXGqD7XFP3f1SOPv5Ag3bS3s/OXI0213Y0WkMoP9sEGeRFJR+s73CmAQUbk3MKc8G8xqaJKM2e9hhPzIwHDoQgIVp8XnGXVLZaTLDLiYA/orv4/miowqPEAXmFT4nwVHksPsGYDkzlYfqdFk0G19lH8MZcAXTGqBCwyubcBDl2lXDio+CDWmhAr+ckoVyg9VhpOyUYR1JPmI8iLY5VR/vQ3m/je5F43SVzMN1dEb4jICwP5xc+tQlhZNzBbSZ+dIZ1dhU/ash0+jqZJSnc9Wconw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ90A0la84uECePEQ2C7nsNUEi7uZtTqmjEGCUdU1Qw=;
 b=p7nDYjr2+MyNCDEYl1TKQ2qoaU2suKd9lNS0D50FS7smbfX6Ld7PLDNgMWxcyXkfpAUVBB0XHvpgWN/yaVQQQy/mt48zAmFHoIBXg/9w/aZAY/6h4v0GhIq7s/f9KXCaaJFspW7MOje5/tfbYodeFD0qt7nC/IZU5xQfpo2F84mvsDaxF2nWVZZSa4jBjwLOgmAAs2FE67STTqFr7b9+tw/G8uWoub39NIY/IhlufU2+AePTd7tR7shihD1url+LH8V21ePVzhD1LMnFkD0euTfwfC1KK/1rps6Izndf/7k+lVtYtFzH5k9uZq+BkWM3juAcpNdTAQ7FjEU6EMSB7Q==
Received: from HK0PR04MB3105.apcprd04.prod.outlook.com (2603:1096:203:8e::20)
 by SI2PR04MB4267.apcprd04.prod.outlook.com (2603:1096:4:e9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.15; Tue, 20 Sep 2022 07:45:53 +0000
Received: from HK0PR04MB3105.apcprd04.prod.outlook.com
 ([fe80::6b9a:1628:86cd:af11]) by HK0PR04MB3105.apcprd04.prod.outlook.com
 ([fe80::6b9a:1628:86cd:af11%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 07:45:53 +0000
From:   Bonnie Lo/WYHQ/Wiwynn <Bonnie_Lo@wiwynn.com>
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
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Thread-Topic: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Thread-Index: AQHYyNQMAFo+dL1NvU+j1+FW6/gp2q3j24EAgAQacrA=
Date:   Tue, 20 Sep 2022 07:45:52 +0000
Message-ID: <HK0PR04MB3105F759F43FEDE24C24FB3AF84C9@HK0PR04MB3105.apcprd04.prod.outlook.com>
References: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
 <10176630-3ff7-54f7-8836-779e5a2bf6d4@linaro.org>
In-Reply-To: <10176630-3ff7-54f7-8836-779e5a2bf6d4@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR04MB3105:EE_|SI2PR04MB4267:EE_
x-ms-office365-filtering-correlation-id: febc8690-2734-4294-147d-08da9adc24f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLdcvrA4x8Ryw1/4qEt2WTEythV0V0A8YDAd7B4ino7qD63tIHprHBZ2PRHFLuhWxAPH2mhUJDhtaHsW0USjwyfB29R6TtkHZkMKZHMZ/hImd9TSTI3KdadQAXazyY8ypnnp8DCo8b2wUGrXe/eV5qlQWHZdt7HMabah4BUIT5BsKApH7NHZncPud8vU9TBuMbNXF2Hjd2aOr6anA29fJ9i8LB7tVqMsgJxmz/D08vwXmbLwcy1k0wZ87RuUSv0galT4EW/hCdgtMyR+gNz1ARpufAUXSbafcxJ6wLuZImD97tHHBalPHKwQNTldCK1kcQgLcRmxgo+kWlNNHih+75HI+sDsaMFbAJEwUANn3rNiJtMrYIX7040rapiAD6iijKCOjpIq4Qs0qPpw3rEyrOs8ZI8UcmF2qtph8wVcrbeLxAjMDifNEEzMMNzCKrc5wcZWlEDQOn/NcrZm5ck0cOrfhYlHbS+gLA8ls76KB9zSaijBi4tww4kdBYNKLyUfX99nXKlxV0TAvwyulYZakh1KTjrfVbLk1bKnrv4c9k3G22zlsgD22aL4ixg/ga/zCb+AtTWbTUzP2h0nFrRvnZPiLQ12rifZmJdlu4w1o/U26Q/tnIbJH+UAH8SgOT5M9yKY82i6GuXlevZVCR64T9Wa5YPPJuPBJrjCX0LbnHkVDWy1s09XNgWpMK1OYAa5vurVGq/EJ0O3sF145ZM/oT7+cCyh1KtvZMWKGDzSF/OhmZsl1/5/KCgPDez7+10F7LPKA5wzlL6mHBqTJu9ZWAROgYYnq6HkyLspF4naQZk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3105.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(47680400002)(451199015)(83380400001)(186003)(45080400002)(2906002)(122000001)(38100700002)(54906003)(316002)(55016003)(86362001)(4326008)(110136005)(38070700005)(71200400001)(52536014)(8936002)(6506007)(966005)(7696005)(41300700001)(478600001)(66946007)(64756008)(66556008)(7416002)(5660300002)(33656002)(76116006)(66446008)(8676002)(26005)(9686003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RGgi3YT9zeSRjKSFb/mpppO+dMl2KK+Y6u+rwRcn8PcUiuYobwkjcETOwsdR?=
 =?us-ascii?Q?kYyymLfwwVj9L/sk6mQfieCf9J9pUdw9MmY/jf5YiQr7bBmQv/Phg5Q3uMHf?=
 =?us-ascii?Q?78it1XTCYL7j+bnfuZTc0G3b4kTt0c5kmBMAZF4dDf0Fq08zBgKN4g3TcK3t?=
 =?us-ascii?Q?zl2E6JNcbR9Rhmwu2Qz1h5zzAu8JVV7wTIQXOKErBSW56ujq3QSwUP/D8OF6?=
 =?us-ascii?Q?nz6T9pU0y94oGUgaPwLbMpWFO2IiSbjo3OAe9jU8IVorknloQPJcnmXTLI/g?=
 =?us-ascii?Q?idxWx6ZuANNCfoEq+7jdGHdjv6kg5yWkQDU4FO2qaB5FVVTcOLnnL6Vp4e2Q?=
 =?us-ascii?Q?k9s2lqp6/HxRg8Thf2K4zUh+GxyRa8ZuORzcl8OO0pZc/Jacsep5tQ1xiTIu?=
 =?us-ascii?Q?tE5ahGS59UAMHxqTfvyww5q+N8oZkwyYJM91nHfCpiOqmpwnMZzP2WYIq+O8?=
 =?us-ascii?Q?miO7Navj/F4thxgzj/pkOtpN7KT/nFr+MVZI2vBXpOsDm0Bq4/fq0w1ZFFhL?=
 =?us-ascii?Q?R5ML/LkppP6AZWMo1JHN0fdeg9MGxkGSU1Te7o7KcMko+DPcrZMAn7eqgZoi?=
 =?us-ascii?Q?msLfaqGozQCYjNeAthWZPTASjyXR7KucbNI83mcwmTu3Eagwtl5Tf615njoB?=
 =?us-ascii?Q?iOKZwCtD6mW/PNApkVk9yL8mrZqwIotHqTKf76YmRz26qtT2mUR2Z4lbzdk7?=
 =?us-ascii?Q?5PVQJGitAvG1A2WB+De8k31gkHdqb4A0Qr1d8SnWFY1GO7GCG02y0naL306J?=
 =?us-ascii?Q?wvUNbrqA+99oCtN/Dm2dIdVkTo+Ninye0MfMj6VaD4F5nxsJYveKcZh+v6VL?=
 =?us-ascii?Q?/tcANrrKOW/jEaADEn7dqr9J0CXoYvAtN4Y7gDrkAU+bjmU0WVjzwWS7c1Kb?=
 =?us-ascii?Q?jypqNcqA5LPCWmqTPvp8XC8ZqOIfrtpJsUAQtN4KSElQp4eGnrpXeccqhalI?=
 =?us-ascii?Q?SnufZpKrm5XQYuHwPGdUupd9vLvPMjbEFZLMKWkqNWC/75yZGSwlP7fEIga5?=
 =?us-ascii?Q?PLE6OkBLGZy8QGvmq9deHa18jHh+1H+IcpSQ/RNguEQawzj1R5l8uWsy4oTv?=
 =?us-ascii?Q?LCPSQ0HRZBWIeqIAeokyaG8cR5UsTtDIuN2hpgV0FipDzxpZNX2wJk47/l/j?=
 =?us-ascii?Q?Crv2oPkbWtq15L2AtdHER4euDNKNHTHe5ZkqdszziMfiR+LGoM+w63bzaJcn?=
 =?us-ascii?Q?x/q5ORjIgGDrh8qr2z5EcG71jK7hWAFyquCAhvK93u37ExMvuI8cXJyksdqr?=
 =?us-ascii?Q?l/LyHbqTT11p3PNRVDg4chhIL0uWd9cq/HdVwceQ01nJ3cmiHXw0tPy/JtkR?=
 =?us-ascii?Q?U4JG29rq/WJcs9C/uQP6/c9bS8Bb5vlf/4Gm6lWnzsynqS1894eDgwdAxHD/?=
 =?us-ascii?Q?CliqkZefWy3EDufwEMuaNadLf9FGBdpIGmKiMpWlf48IK8NlbJ2iLrNR5YBB?=
 =?us-ascii?Q?SJzsIpvTqNyToZY5V62i0SBMqoqliI7lEt9w8Pt80GF94ioTVEo7MZVKGwVv?=
 =?us-ascii?Q?AqYtSxKGSc0OaH7BImdg87jaQlwGery54AR3V+n/hwyviGnoXBWSjOgsZFJm?=
 =?us-ascii?Q?KM717w8YUUGlCktdpH862MZtKYHefv7C3q9gnBB/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3105.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febc8690-2734-4294-147d-08da9adc24f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 07:45:52.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZtceeFpZSbeApWQcGw7ZTu1QeTKyjwHgtXEPWumEzjFm0By916D+l6UAgxRtHNMZEof7kLrKth9VpKPd15naA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

I revise the device tree as following and resend the mail.
It create a new mail thread " [PATCH] ARM: dts: aspeed: greatlakes: Add Fac=
ebook greatlakes (AST2600) BMC".
Kindly to correct me, if there is any problem.

> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>
> >
> > Add linux device tree entry related to greatlakes specific devices
> > connected to BMC SoC.
>
> Please wrap commit message according to Linux coding style / submission
> process:
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Felixi=
r.b
> ootlin.com%2Flinux%2Fv5.18-rc4%2Fsource%2FDocumentation%2Fprocess%2
> Fsubmitting-patches.rst%23L586&amp;data=3D05%7C01%7CBonnie_Lo%40wiw
> ynn.com%7C1dee8dcb540a49522fb608da98cdba6f%7Cda6e0628fc834caf9dd
> 273061cbab167%7C0%7C0%7C637990306620286314%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DmC2E3dJbuYgXklS%2Fw8s2w%2
> BKH%2BZ3CsZSndFTgPBjyvpw%3D&amp;reserved=3D0
>

I have add " ARM: dts: aspeed: greatlakes:".

> >
> > Signed-off-by: Bonnie Lo <Bonnie_Lo@wiwynn.com>
> > ---
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 248
> ++++++++++++++++++
>
> Missing documentation of board compatible (bindings) as first patch.
>
> >  2 files changed, 249 insertions(+)
> >  create mode 100644
> > arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 05d8aef6e5d2..40fa906ab17f 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1580,6 +1580,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> >         aspeed-bmc-asrock-e3c246d4i.dtb \
> >         aspeed-bmc-asrock-romed8hm3.dtb \
> >         aspeed-bmc-bytedance-g220a.dtb \
> > +       aspeed-bmc-facebook-greatlakes.dtb \
>
> Wrong order.

I have reordered it.

>
> >         aspeed-bmc-facebook-bletchley.dtb \
> >         aspeed-bmc-facebook-cloudripper.dtb \
> >         aspeed-bmc-facebook-cmm.dtb \
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> > b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> > new file mode 100644
> > index 000000000000..f011cc4d370f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later // Copyright 2022
> > +Facebook Inc.
> > +
> > +/dts-v1/;
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h> #include
> > +<dt-bindings/i2c/i2c.h> #include <dt-bindings/leds/leds-pca955x.h>
> > +
> > +/ {
> > +       model =3D "AST2600 EVB";
>
> Wrong name.

I have revies the model name " Facebook Greatlakes BMC ".

>
> > +       compatible =3D "aspeed,ast2600";
>
> Missing board compatible.
>

I add board compatible " facebook,greatlakes-bmc"

> > +
> > +       aliases {
> > +               serial4 =3D &uart5;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path =3D &uart5;
> > +               bootargs =3D "console=3DttyS4,57600n8 root=3D/dev/ram r=
w
> > + vmalloc=3D384M";
>
> Bootargs usually do not belong to mainline DTS.

Removed.

>
> > +       };
> > +
> > +       memory@80000000 {
> > +               device_type =3D "memory";
> > +               reg =3D <0x80000000 0x80000000>;
> > +       };
> > +
> > +       iio-hwmon {
> > +               compatible =3D "iio-hwmon";
> > +               io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>,
> <&adc0 3>,
> > +                               <&adc0 4>, <&adc0 5>, <&adc0 6>,
> <&adc0 7>,
> > +                               <&adc1 0>, <&adc1 2>, <&adc1 3>,
> <&adc1 4>,
> > +                               <&adc1 5>, <&adc1 6>;
> > +       };
> > +};
> > +
> > +&uart1 {
> > +       status =3D "okay";
> > +};
> > +
> > +&uart2 {
> > +       status =3D "okay";
> > +};
> > +
> > +&uart3 {
> > +       status =3D "okay";
> > +};
> > +
> > +&uart4 {
> > +       status =3D "okay";
> > +};
> > +
> > +&uart5 {
> > +       status =3D "okay";
> > +};
> > +
> > +&wdt1 {
> > +       status =3D "okay";
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_wdtrst1_default>;
> > +       aspeed,reset-type =3D "soc";
> > +       aspeed,external-signal;
> > +       aspeed,ext-push-pull;
> > +       aspeed,ext-active-high;
> > +       aspeed,ext-pulse-duration =3D <256>; };
> > +
> > +&mac3 {
> > +       status =3D "okay";
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_rmii4_default>;
> > +       no-hw-checksum;
> > +       use-ncsi;
> > +       mlx,multi-host;
> > +       ncsi-ctrl,start-redo-probe;
> > +       ncsi-ctrl,no-channel-monitor;
> > +       ncsi-package =3D <1>;
> > +       ncsi-channel =3D <1>;
> > +       ncsi-rexmit =3D <1>;
> > +       ncsi-timeout =3D <2>;
> > +};
> > +
> > +&rtc {
> > +       status =3D "okay";
> > +};
> > +
> > +&fmc {
> > +       status =3D "okay";
> > +       flash@0 {
> > +               status =3D "okay";
> > +               m25p,fast-read;
> > +               label =3D "bmc";
> > +               spi-rx-bus-width =3D <4>;
> > +               spi-max-frequency =3D <50000000>; #include
> > +"openbmc-flash-layout-64.dtsi"
> > +       };
> > +       flash@1 {
> > +               status =3D "okay";
> > +               m25p,fast-read;
> > +               label =3D "bmc2";
> > +               spi-rx-bus-width =3D <4>;
> > +               spi-max-frequency =3D <50000000>;
> > +       };
> > +};
> > +
> > +&i2c0 {
> > +       status =3D "okay";
> > +       multi-master;
> > +       ipmb0@10 {
> > +               compatible =3D "ipmb-dev";
> > +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> > +               i2c-protocol;
> > +       };
> > +};
> > +
> > +&i2c1 {
> > +       status =3D "okay";
> > +       multi-master;
> > +       ipmb1@10 {
> > +               compatible =3D "ipmb-dev";
> > +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> > +               i2c-protocol;
> > +       };
> > +};
> > +
> > +&i2c2 {
> > +       status =3D "okay";
> > +       multi-master;
> > +       ipmb2@10 {
> > +               compatible =3D "ipmb-dev";
> > +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> > +               i2c-protocol;
> > +       };
> > +};
> > +
> > +&i2c3 {
> > +       status =3D "okay";
> > +       multi-master;
> > +       ipmb3@10 {
> > +               compatible =3D "ipmb-dev";
> > +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> > +               i2c-protocol;
> > +       };
> > +};
> > +
> > +&i2c4 {
> > +       status =3D "okay";
> > +};
> > +
> > +&i2c5 {
> > +       status =3D "okay";
> > +};
> > +
> > +&i2c6 {
> > +       status =3D "okay";
> > +};
> > +
> > +&i2c7 {
> > +       status =3D "okay";
> > +};
> > +
> > +&i2c8 {
> > +       status =3D "okay";
> > +       tmp421@1f {
>
> Node names should be generic.
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdevic=
et
> ree-specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-basi
> cs.html%23generic-names-recommendation&amp;data=3D05%7C01%7CBonnie
> _Lo%40wiwynn.com%7C1dee8dcb540a49522fb608da98cdba6f%7Cda6e0628f
> c834caf9dd273061cbab167%7C0%7C0%7C637990306620286314%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DAjWYGYl6zCyNq5Yd
> 6VOui9P40Kdz3boxK1LSNSy%2Bcmw%3D&amp;reserved=3D0
>

Revise as "temperature-sensor".

> > +               compatible =3D "ti,tmp421";
> > +               reg =3D <0x1f>;
> > +       };
> > +       // NIC EEPROM
> > +       eeprom@50 {
> > +               compatible =3D "st,24c32";
> > +               reg =3D <0x50>;
> > +       };
> > +};
> > +
> > +&i2c9 {
> > +       status =3D "okay";
> > +       multi-master;
> > +       ipmb9@10 {
> > +               compatible =3D "ipmb-dev";
> > +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> > +               i2c-protocol;
> > +       };
> > +};
> > +
> > +&i2c10 {
> > +       status =3D "okay";
> > +};
> > +
> > +&i2c11 {
> > +       status =3D "okay";
> > +       eeprom@51 {
> > +               compatible =3D "atmel,24c128";
> > +               reg =3D <0x51>;
> > +       };
> > +       eeprom@54 {
> > +               compatible =3D "atmel,24c128";
> > +               reg =3D <0x54>;
> > +       };
> > +};
> > +
> > +&i2c12 {
> > +       status =3D "okay";
> > +       lm75@4f {
>
> Node names should be generic.
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdevic=
et
> ree-specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-basi
> cs.html%23generic-names-recommendation&amp;data=3D05%7C01%7CBonnie
> _Lo%40wiwynn.com%7C1dee8dcb540a49522fb608da98cdba6f%7Cda6e0628f
> c834caf9dd273061cbab167%7C0%7C0%7C637990306620286314%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DAjWYGYl6zCyNq5Yd
> 6VOui9P40Kdz3boxK1LSNSy%2Bcmw%3D&amp;reserved=3D0
>

Revise as "temperature-sensor".

> > +               compatible =3D "lm75";
> > +               reg =3D <0x4f>;
> > +       };
> > +};
> > +
>
> (...)
>
> > +
> > +&gpio0 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
> > +};
> > +
> > +
> > --
> > 2.17.1
> >
> > WIWYNN PROPRIETARY This email (and any attachments) contains
> proprietary or confidential information and is for the sole use of its in=
tended
> recipient. Any unauthorized review, use, copying or distribution of this =
email
> or the content of this email is strictly prohibited. If you are not the i=
ntended
> recipient, please notify the sender and delete this email immediately.
>
> This means we cannot take this patch. Proprietary and/or confidential
> patches cannot be merged.
>
> Please license the patch as you wrote in SPDX header.
>
> Best regards,
> Krzysztof
WIWYNN PROPRIETARY
This email (and any attachments) contains proprietary or confidential infor=
mation and is for the sole use of its intended recipient. Any unauthorized =
review, use, copying or distribution of this email or the content of this e=
mail is strictly prohibited. If you are not the intended recipient, please =
notify the sender and delete this email immediately.
