Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EEF60745E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJUJoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJUJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33C2582D8;
        Fri, 21 Oct 2022 02:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEOYiKWZKn8LfGvHrdnVdFUe5uQenJCV75mDlws+PlQuAIcvtHQoELqth0WVxwkK63JRBhAxm76yEzxZyvRcQP9UhWZrYkE8PiruHki7BhdPAtXXSXQKl+sirFhXV6bkN8wa7NHOgEUcrIoOsytJVw2gO+apJ4wMM/7mqzEN0KC9KOJbE3BP1Q57lgCXdQuM1233KXJhkgdGsVuZlMacy7gFM8d8vEik8CLg6kkujxa67q2SG+EWyyDPfS0q9qjoDbspLBcxYYd8y24RBJP3KxWkAHQTj0P5QCo+MHJTpanWDQLIT4T+Ak6gZdRHsPrWN7q/J/q7QkyBJ3Bput9s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpj3syGTmojVM4omwyrecDY4XLASZkkJd30oHgH54rg=;
 b=n9g7QgVfHDJJih/sEyj2xTVR3g5Qf9TBQF5f1xa4WO3SFG5fg2Gcdc8t6sZI6J05avua/3AqCZti6ZRf372BN9uIoaG8I8Y6Pot8YJmQR0Z5Dwwm78nJVZL5NGlcV8LhxnhYaNBZqo8qUTjk9AGHFzHX5A4CE7JuLoceja3W0oF//wU9ZKrjgnLlbjnAuC8g1mMUrqR8QotohijDRFaGRVDij8IKC7OF3heOae4C57BrVSgD3Qi7QwfnokkYGC52dhOyn1GXACysurXC5uY/XSKivfQM4hg/OYN7jFOIJ62mYjtdS7aZVU5vir1dvYk8x4ni/8rRaO7SjDgh1R/ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpj3syGTmojVM4omwyrecDY4XLASZkkJd30oHgH54rg=;
 b=ImPAuIAZOoA5nTSbOCLaJwqpxSwVq1W43iAVxYoW5MmL4+X0H2seIfpQU0HhFN1ge4Pk0t+dNrmnzuNyLzeDDejOn6cR8tDY8Vk8L1pYiMPC5gdlXjx521knZNlcMwl7xvgAVYUlrx+48qhap0i+n1JfbAkIZNVMQfRi8tGRhFQ=
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 21 Oct
 2022 09:44:14 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::4454:3de:fe7:adcb]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::4454:3de:fe7:adcb%3]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 09:44:14 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 03/15] arm64: dts: imx8mp-evk: fix BUCK/LDO voltage
Thread-Topic: [PATCH 03/15] arm64: dts: imx8mp-evk: fix BUCK/LDO voltage
Thread-Index: AQHY5GqAN+iWpir27USo/J5ZgJkMS64XHjCAgAFz1ICAAASLQA==
Date:   Fri, 21 Oct 2022 09:44:14 +0000
Message-ID: <DB9PR04MB8412780C8C6CDF64006B807A872D9@DB9PR04MB8412.eurprd04.prod.outlook.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-4-peng.fan@oss.nxp.com>
 <20221020110257.5ojjq2j2c53hevnt@pengutronix.de>
 <ac906692-b4b1-136d-e93f-e1388a803684@oss.nxp.com>
In-Reply-To: <ac906692-b4b1-136d-e93f-e1388a803684@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8412:EE_|DB9PR04MB8480:EE_
x-ms-office365-filtering-correlation-id: 80a5c3ac-2c4b-44a5-f67b-08dab348d07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eS0hrb9Gz0kVbuvp6w9C2PYi5BRg0nJJxz58eIPZ5cUh3mctqBOWmoF5a4CZdpcTOHdnqviOdNwV2gCpQpOd9QkAFJbO8Vph/ODa2RWnnPqTA6/X+aa30hKu+fTFQnOHNxx6pU1EkvW83dunY9Y0rT7sxPRxeRb/sEcNZQkX+56b/1bdVxUtExPQ9GdDL0db1dIFlev/Jz/eoFAuZjJp6sV0qFvPDClC31IzrIsvHbUFJERy8WK1wuAQPetcyhIIPWnhJ5xfZeca9aW68kQEv6uL+XXWi3s6S6iQ/a40aw3Xj2+crjK6/yh8yKL1lJFLwZK3d5eqB9jw97R0sob++DU58Wm07FZSwOoIpftAo9ogVzFDNHPgwYj15C9H083rYfpR6uLA17CZzQ86zB/DC+JU4hdhnCiuE9KJbpVFjf/euwFhcIIluQ5cT+K87/Ow08uON3agtb3zXZ+IF40PsnSlBD2rIjSV6+0Z0GBL7yfNWenBDkAuSTBvWu1TTERUg2evIlqAa79GAvYylHn6yHPRn2pcjDyIOgY6z87ImcZOIpv1Jq27t+PamqpV9UCv1ctKceJZwPBwQANR1e9bNb0dUMaecflSKeN8Lr11FNz3Vfsn1O/9v8j6Ka3daMtsUpY/t6x88oIMK02udGrFK++ypMzBMZoYmxJi66rJ8b99N6yXwC1AsDe7uzz6ius6EImMuW9EmTcNjpvG0zaGLT1ONBoOnzhpyJTtqHCNPmCv49gU7nZvn4D29g5yofwughnPuL1g/D4GrVXPqiBL/O7FWBxVYQPNenb6EDFlm3Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(54906003)(71200400001)(7416002)(5660300002)(33656002)(52536014)(4326008)(8936002)(99936003)(478600001)(26005)(64756008)(66446008)(9686003)(2906002)(83380400001)(8676002)(6506007)(66476007)(66556008)(110136005)(66946007)(316002)(41300700001)(38070700005)(122000001)(38100700002)(186003)(76116006)(55016003)(53546011)(7696005)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekJiRGxYa3FVQ0JRdDFNa0QzTFA5S1p3QzVxbEhxeWdpS3hFVkRIa2JNNFhh?=
 =?utf-8?B?TlA1d0trdklKeDVFM3EyY3VIT01laTBrWWFUNVQxaDIzTlRieW00czQ1Z0N5?=
 =?utf-8?B?YmhqdEMvUE9xdEZGNG9ZME5rMmNLT3RmSzRJYXpoTFFnQUl0TlNCbFVWc2pC?=
 =?utf-8?B?Z0FNVmkrM1hjNldPcTBoVTFGVGNZZmp0ME5uR0xaU0orT2F6Z3NXWEdEeDJE?=
 =?utf-8?B?QjZYNTB3M2VlODFTUVpBUUk1QW81ZStaQVZmbXpndHJ2bm12RHNPYkdPTk9r?=
 =?utf-8?B?SHl0RExCd085ZlV1K053QXcrQm15dUR1YjVoSWcxUUttLzZmMFZZSHVuUmoy?=
 =?utf-8?B?YXp2RE9ZdkJOK3ZSQzFvRzRaTHZvYVFJVWFJWmRZMlhwS3JJY3NidkxkRWJ0?=
 =?utf-8?B?ang1V2Yza0lUeGlvM2ZuaWJ5TGtCa3FUZStvTTRET1Fpd3JLRkIyQnFla2xp?=
 =?utf-8?B?QWpLUGhpR0pIcitSd0s4V2phMHJOaU9nT09YcVRZZVVtRWdCeDE1QnhLbUZa?=
 =?utf-8?B?ZENIalJwbzlxR2JncG1wU3EwU0VzRC9mUlBNL3QzYzc5NFY4T0dWNXQyWmwv?=
 =?utf-8?B?Q29tRUZlVGpXKzh3Ym1yeWRCR0YzTFg0Q2huMXNVY2VWODVyVE1hV2tzREc4?=
 =?utf-8?B?eG1QK3BUaUZCamUwaENiVVFXZmpiYkR3VDNFVGIvdDVtYTNUaURwYzFXMGxG?=
 =?utf-8?B?SEppMENYT2s1bmpYU0l0Q2paNUdFL2w0Y3gyNjlCT05ObFh2bDJ6TFQxblc2?=
 =?utf-8?B?cjBhbmgzaU1PWCtPZTlIS3JTUTdpNG15aHV5SDVLaXdNMWdKMnFGa2RkckZv?=
 =?utf-8?B?NEtWMVRwaTIzdjZtK0JFcUNOcVNWbC9ab2hjYnVTWW0vZG5lK2tjcnJFeDlZ?=
 =?utf-8?B?aFpTTXpBdGs5ejBKL0pzc3lLdDBvWkQzc1F1TGlCa0R3alc3eUEvZFBjeXpt?=
 =?utf-8?B?OHBKZ1lJMVRDK092NHl0V1F2TlNFRVArQTFTdlBXVTJWQWlwNEtuTXdtM2ZS?=
 =?utf-8?B?RGtzdWIvZGptZWxTbnNBczJ6TGNDUGxXVk1yQWV4bnlyNWd3dytxWHFRUGRy?=
 =?utf-8?B?dGYyaFQyYjV1NWFnZlRieVhoZG9LT2dhclBrcGhJWXV5TFh6ekhWdmdETW9I?=
 =?utf-8?B?VG4rS0Q1NFQ0T2lPSUM5VEJjWGVLenhaTUxhd3pIWTZPTEE5d2dycTdNeXlU?=
 =?utf-8?B?eEtndjdWOTA0V29ML1UwK2s1b1hNSDlWY2sramNac3p6TEthZEsySHB0VXZo?=
 =?utf-8?B?clUyRWVmTmRRZDZ3STlMWm1NRFdwNzFwSEZrS3Z0eTcyeXNuQ3d4bGFsZFhz?=
 =?utf-8?B?RE5wRXpYL0VMRzZLUEFBWENWNzhGSUZuMFVPVzFuZnQzUEZBTDk1V09la0F1?=
 =?utf-8?B?OUx0SzU1Tm5JTDl1c0FVcmZKeHFhaW0za1JHOU9EcDMzVU51VzNRUlZrSFJS?=
 =?utf-8?B?dllxOUtVOGI5dWcvNXpQOGgvY0ViTHM2NGV3SWhTSDZSR21yWkxlcXIrYnE4?=
 =?utf-8?B?RGhTVGs1TWN4czlqM1I1VkZpcERIUmJUemZmTXJlUzVXcFhRdHk5Wno0cTZw?=
 =?utf-8?B?TmdLbzFCNWR3c2ZHKzduOFdabSswcVRlR0psZWlrWGZ2cW55STluaDA0ZzBr?=
 =?utf-8?B?Wmk2ZW5yNVdmcmo4RE5jYlVnMHQ0OXhqam5ob3ZKdWd6RXR5OFZLQ2d4OWg0?=
 =?utf-8?B?UDdDckVUNTJHSW5WLy9pOGJDTkEzRTl0WTJUbTV4bFBEek9oT3JWalVia3lZ?=
 =?utf-8?B?bnJHT0l4ZU5wL3BJLzNNQkVlRStKdDYvN3I2a04vbGdENU1BSWRxMXcwYVhV?=
 =?utf-8?B?S2VQaER1WGtpZFkxSnZWOXNKRnVMR2RFUkxXeTBiT2VaUUhkTkdvNXpINDNB?=
 =?utf-8?B?c0hGN04zRFJweWhnZXVrK3VHMEVKU3UwU3Boc3A4U2lUQ1MwdlhnL3p6cmMz?=
 =?utf-8?B?Z01RS29ma01GOGxYSVhWWFVhS29tdmFSUkF6aEpBMDROaFVBZWlyQklPKytC?=
 =?utf-8?B?NkFyYzBPakowZGUvVkNGWXhvZm40WGkxMk9MU0NSend2RVh1T3BRS3lMUU9I?=
 =?utf-8?B?dTRkSmgyN2ZpZmdiYWJnZTc3YlVNK2w2MlEyL1lkM0lvZmVSR2Y1QXcwbTFI?=
 =?utf-8?Q?X0hQ=3D?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_0094_01D8E574.BA6DE180"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a5c3ac-2c4b-44a5-f67b-08dab348d07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 09:44:14.3098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +sd47YPH03zPLY1P8so2Ppd1uZFfjbQFcYJxOLujijp5EUDJwa1suPa09N1vO5pFDj+5p19KoOr6lRLprCkjYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0094_01D8E574.BA6DE180
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> Subject: Re: [PATCH 03/15] arm64: dts: imx8mp-evk: fix BUCK/LDO =
voltage
>=20
> Hi Marco
>=20
> On 10/20/2022 7:02 PM, Marco Felsch wrote:
> > Hi Peng,
> >
> > On 22-10-20, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> Per PCA9450C datasheet, the voltage range as below:
> >> BUCK1 0.6 - 2.1875
> >> BUCK2 0.6 - 2.1875
> >> BUCK4 0.6 - 3.4
> >> BUCK5 0.6 - 3.4
> >> BUCK6 0.6 - 3.4
> >>
> >> LDO1 1.6-1.9, 3.0-3.3
> >> LDO2 0.8 =E2=80=93 1.15
> >> LDO3 0.8 - 3.3
> >> LDO4 0.8 - 3.3
> >> LDO5 1.8 - 3.3
> >>
> >> So correct them, and also add LDO[2,4]
> >
> > In the DTS you specify voltage constraints for a specific hardware =
and
> > not the one supported by the PMIC. What the PMIC supports (min/max) =
is
> > specified within the driver.
>=20

IMO, the dts properties regulator-min/max-microvolt in the regulator =
node should be properties
to list the ability of each regulator of PMIC. If these properties is =
not for PMIC itself,
how to define the board range using these properties? ^_^

And in the PMIC driver, no each PMIC's min/max range define.

BR
> Technically we could set board voltage to PMIC voltage range, it not =
damage
> the board from hardware level.
> but I am not sure whether Linux could work proper.
> Saying set VDD_SOC/DDR to pmic min voltage, system will crash, because =
it
> could not support higher freq.
>=20
> I am not sure how to proceed on this, just update commit log to say =
that the
> board voltage range could be set to pmic voltage range?
>=20
> Thanks,
> Peng.
>=20
> >
> > Regards,
> >    Marco
> >
> >>
> >> Fixes: 5497bc2a2bff ("arm64: dts: imx8mp-evk: Add PMIC device")
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>   arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 44
> +++++++++++++-------
> >>   1 file changed, 30 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> >> b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> >> index b4c1ef2559f2..a4cddc5a8620 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> >> @@ -248,8 +248,8 @@ pmic@25 {
> >>   		regulators {
> >>   			BUCK1 {
> >>   				regulator-name =3D "BUCK1";
> >> -				regulator-min-microvolt =3D <720000>;
> >> -				regulator-max-microvolt =3D <1000000>;
> >> +				regulator-min-microvolt =3D <600000>;
> >> +				regulator-max-microvolt =3D <2187500>;
> >>   				regulator-boot-on;
> >>   				regulator-always-on;
> >>   				regulator-ramp-delay =3D <3125>;
> >> @@ -257,8 +257,8 @@ BUCK1 {
> >>
> >>   			reg_arm: BUCK2 {
> >>   				regulator-name =3D "BUCK2";
> >> -				regulator-min-microvolt =3D <720000>;
> >> -				regulator-max-microvolt =3D <1025000>;
> >> +				regulator-min-microvolt =3D <600000>;
> >> +				regulator-max-microvolt =3D <2187500>;
> >>   				regulator-boot-on;
> >>   				regulator-always-on;
> >>   				regulator-ramp-delay =3D <3125>;
> >> @@ -268,40 +268,56 @@ reg_arm: BUCK2 {
> >>
> >>   			BUCK4 {
> >>   				regulator-name =3D "BUCK4";
> >> -				regulator-min-microvolt =3D <3000000>;
> >> -				regulator-max-microvolt =3D <3600000>;
> >> +				regulator-min-microvolt =3D <600000>;
> >> +				regulator-max-microvolt =3D <3400000>;
> >>   				regulator-boot-on;
> >>   				regulator-always-on;
> >>   			};
> >>
> >>   			BUCK5 {
> >>   				regulator-name =3D "BUCK5";
> >> -				regulator-min-microvolt =3D <1650000>;
> >> -				regulator-max-microvolt =3D <1950000>;
> >> +				regulator-min-microvolt =3D <600000>;
> >> +				regulator-max-microvolt =3D <3400000>;
> >>   				regulator-boot-on;
> >>   				regulator-always-on;
> >>   			};
> >>
> >>   			BUCK6 {
> >>   				regulator-name =3D "BUCK6";
> >> -				regulator-min-microvolt =3D <1045000>;
> >> -				regulator-max-microvolt =3D <1155000>;
> >> +				regulator-min-microvolt =3D <600000>;
> >> +				regulator-max-microvolt =3D <3400000>;
> >>   				regulator-boot-on;
> >>   				regulator-always-on;
> >>   			};
> >>
> >>   			LDO1 {
> >>   				regulator-name =3D "LDO1";
> >> -				regulator-min-microvolt =3D <1650000>;
> >> -				regulator-max-microvolt =3D <1950000>;
> >> +				regulator-min-microvolt =3D <1600000>;
> >> +				regulator-max-microvolt =3D <3300000>;
> >> +				regulator-boot-on;
> >> +				regulator-always-on;
> >> +			};
> >> +
> >> +			LDO2 {
> >> +				regulator-name =3D "LDO2";
> >> +				regulator-min-microvolt =3D <800000>;
> >> +				regulator-max-microvolt =3D <1150000>;
> >>   				regulator-boot-on;
> >>   				regulator-always-on;
> >>   			};
> >>
> >>   			LDO3 {
> >>   				regulator-name =3D "LDO3";
> >> -				regulator-min-microvolt =3D <1710000>;
> >> -				regulator-max-microvolt =3D <1890000>;
> >> +				regulator-min-microvolt =3D <800000>;
> >> +				regulator-max-microvolt =3D <3300000>;
> >> +				regulator-boot-on;
> >> +				regulator-always-on;
> >> +			};
> >> +
> >> +			ldo4: LDO4 {
> >> +				regulator-name =3D "LDO4";
> >> +				regulator-min-microvolt =3D <800000>;
> >> +				regulator-max-microvolt =3D <3300000>;
> >>   				regulator-boot-on;
> >>   				regulator-always-on;
> >>   			};
> >> --
> >> 2.37.1
> >>
> >>
> >>

------=_NextPart_000_0094_01D8E574.BA6DE180
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNv
bT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0
aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Js
hi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsG
AQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2Ul
MjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29i
amVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDA9BgNVHREENjA0oCAGCisG
AQQBgjcUAgOgEgwQcGluZy5iYWlAbnhwLmNvbYEQcGluZy5iYWlAbnhwLmNvbTANBgkqhkiG9w0B
AQsFAAOCAQEAkIoVu8Z7nAqHdZlesSa/ZKQsoGVN/KXyw5UDkWZc8QH5EUPRhmwPk4j2IO+7zGl5
X+G5pRc1FmjT5MiJx7HJqWjYauI2HmGU0UtwSTqT+s9286vF5h1AEOLUBSUzB3E/O/cWvpDL3IEe
+stzIGhRpwg6OxDOSb9iHElZoDTqpRvLISF6Wy4ktrom24/n6ePTPb5FlWB1y6OPMAiI25YSb9zW
fWumZL+I1EMZHtie+S5axIcNlXke5UxtPzCF8dxKoviZiTOvR2n3XAQd+qDDPHRsev2Bv30I+T7J
W0qNC2rInm5LczdALMKrDUU//+Uy/XT5IyabR0eufpNuTyD7lTCCCDowggcioAMCAQICEy0ACHtC
5W6zRq9c0YAAAAAIe0IwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMjA5MTUwMTA2
NDNaFw0yNDA0MDgwOTE1MDRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
OTAxMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANNFIocz15YTXOTeRm2hof07RVzy
FI/qsJNt0XyGB/wK/65x2QtQ0HDcdvQj1pEewRA3RgcBAWge8vRYfQd2PCICKlfVXfabIwJfbfU+
p4WdW2cvGzGt4/XwXniyYeZwnL96Z5M+FZ/h/GlIT72K7/woP+zA0wzTw6ga9jLJ1S74Kyfbh+9i
eZ6kjokCEZFKwu1AkryMMpkSsWN96z1IghrCwv2D33WjffHy+g8BG0NQ92zvuLShwVU15VBMed2Z
I30PEta+A20b/ygJ1Yb+631JDoPC8bewk2vPi1u3fjB5T1QDNYKxjts9PSzUsdFapd6hSSAk+Z9N
mqnHts9s6iUCAwEAAaOCBFkwggRVMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFIQg+lXF6qukHLDnGFCWIGXQ
7e6oMB8GA1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50HMIIBRgYDVR0fBIIBPTCCATkwggE1
oIIBMaCCAS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049TkxBTVNQ
S0kwMDA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1D
b25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxp
c3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIYvaHR0cDovL253dy5wa2ku
bnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0dHA6Ly93d3cucGtpLm54cC5jb20v
Y3JsL05YUEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcw
AoaBrmxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1BSUEsQ049UHVibGlj
JTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9
bnhwLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1
dGhvcml0eTA/BggrBgEFBQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50
ZXJwcmlzZS1DQTUuY3J0MD0GA1UdEQQ2MDSgIAYKKwYBBAGCNxQCA6ASDBBwaW5nLmJhaUBueHAu
Y29tgRBwaW5nLmJhaUBueHAuY29tMFEGCSsGAQQBgjcZAgREMEKgQAYKKwYBBAGCNxkCAaAyBDBT
LTEtNS0yMS0xOTE1MjA3MDEzLTI2MTUwNDAzNjgtMzA3NjkyOTQ1OC02Mjg5ODUwDQYJKoZIhvcN
AQELBQADggEBADQRSIt6fqoWHqVz8Cp9E9E/O/wJhHJyaY7bNTVWSVpVptyvbVm1rFmj6xTPxQy2
kZGnpCkDQrQIAhY0P/PQGecdI7HmBUkFqlXrhugCHG9vtbeG+kVjDCecvtlWMPsYqER3ZCzACSFc
HJKvWOZdnEc2yfI3LGkDqVMZWzfc4urLk+1H7sYi4psI8Z6EDbEweuSznBtthG8+jomjtqxGhOy6
Uxvh93xFu7X2efPBxxsno44HnWsLrwkzisI8oItaHPqfcIt2W0nyVjvW6rAI0LduoAhJwLsD9RB4
FYZwB4ain11hWJYlP9P19PmMPdoiKQBqQQvnXcujc/rq2sKm/3sxggTDMIIEvwIBATCBzjCBtjEc
MBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBC
LlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJ
k/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJ
BgNVBAYTAk5MAhMtAAfU7dCrf7iXk2FuAAAAB9TtMA0GCWCGSAFlAwQCAQUAoIICxTAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjEwMjEwOTQ0MTFaMC8GCSqGSIb3
DQEJBDEiBCBOsQtXbbJGDKhBegcyB7p7c6bN3t9BHEv0mR8tl2PjKTCBkwYJKoZIhvcNAQkPMYGF
MIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsG
CWCGSAFlAwQCAjAHBgUrDgMCGjCB3wYJKwYBBAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNOWFAg
RW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcM
CUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTET
MBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0A
CHtC5W6zRq9c0YAAAAAIe0IwgeEGCyqGSIb3DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNOWFAg
RW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcM
CUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTET
MBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0A
CHtC5W6zRq9c0YAAAAAIe0IwDQYJKoZIhvcNAQEBBQAEggEAH9F+M8A0IIud1N78ih02GExwdKxK
uf8ABdX1HDuojF8wpQ3xHhKlZjtkeNxCKmdZVmrHeYFxrcaUMrrzJzEbpZNCYYd2N81VZ7v2HRDT
JiZsnvR9134ODjZSiLjc0hdzASKMmU7vImlAN/ucjTFFh+l06XHxRwmgr4pMl3nttYWjjE+IbbSl
HiCHqimIF86+mEQjq9EJ1kA4TfqSvseVz7KhtlqygBig8AGSQp9RVMVZFK1HhFD5AEwv0dY3rwbq
ZMtsvmyeT5QKEGDiaivdTG3xtrOPJ5CtaN8N2tuuurKq833AS22S4wUhT7BfvF3bI2WxFeuQuLHB
YtZ7MfO9UAAAAAAAAA==

------=_NextPart_000_0094_01D8E574.BA6DE180--
