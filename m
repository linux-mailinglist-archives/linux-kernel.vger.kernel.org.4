Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85166289E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiKNTz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiKNTz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:55:26 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140053.outbound.protection.outlook.com [40.107.14.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7030DF56;
        Mon, 14 Nov 2022 11:55:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQFkC4ASypGhoGG+rsSpgebKiPuOWVftT2So95Y/rG5zgQQa9xXHhVNh0iPCAxhV57hbBEmI4Iaizm+ODAFMrbO23l1UuiEyl9GmTvmfaCmF4RE7SfBkIcMUAXU98LMRbHf3meOZWFYbMHGmBEbCtwvumMnloMaLzxRTb7wrMAGHbjJ+/FVQwujaNBHfMl0jK2HGaOtxb79qCR+jDIKbkhZv+qJOXg2i6CyVBOUNerLR3X9tr+3cNeyWALDALmk2bPLTu2emO1ebpq3EEgN0WrCOXzEhz4kNK82Noq+BkVibzAmF5twEpvorqRpko7ixqoS790uQSkONGu9I+MevMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBdoAd2KSXMUQQtYZbWeZmoTs9vIBQWFmQZv6T0bUEM=;
 b=K9oqjajoyFPe5u6XPpHXjiMTUvNTcmUfxSMOXVpKInSxmZI7SAf4jjdv+EV6LaPJh28GNG6lB5wQwXgpnajKyWC7g5MDtm7rEJYa1a1U6FuGOe7/6wTO/6UgyeXc/lEqEiwq6LbvdNgBNJT3A3woG/ZSaHRdeM1L485AC0wbjYz/A23hT4FhZ+Ku82tVUrdWvay4kBz3By+IiiUqLSqOC4w+B7bIFvkdkyCXqF43SslrM8bglevo0lbkqLLHQlnV4Dil4Ms0OJIofPXe0UsRxylZmkh5uTj1+MeK0xNnIMOZG92sDDwtJHA8HyJZgDRV9k6XWTThR3GXIZaFBGGlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBdoAd2KSXMUQQtYZbWeZmoTs9vIBQWFmQZv6T0bUEM=;
 b=dPob5+YTKIR4pg+mdVg4O5oQEBwJgGv0sv3KYesTo+f6piknwSI/FWM6qZqj7X93E/I2sOvenQ8uOrNSjoP/2ocHIRKiknkApLwfq3CJAmq0g6EDMS8OvCW4gtaekwxlhkU0ZVZ0JnvGVqZSiWCVAt99PNN/e0KdtCEchZH1qwk=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 19:55:21 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::857:ce88:de77:5823]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::857:ce88:de77:5823%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 19:55:21 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Rob.Herring@arm.com" <Rob.Herring@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Chester Lin <clin@suse.com>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>, dl-S32 <S32@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 07/20] arm64: dts: Update cache properties for freescale
Thread-Topic: [PATCH 07/20] arm64: dts: Update cache properties for freescale
Thread-Index: AQHY7Qn1HioIfePw+0+dxwF9jO4Npq4+66pg
Date:   Mon, 14 Nov 2022 19:55:21 +0000
Message-ID: <AM0PR04MB6289C97297803675DA5A57178F059@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20221031091956.531935-1-pierre.gondois@arm.com>
In-Reply-To: <20221031091956.531935-1-pierre.gondois@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|AM7PR04MB7080:EE_
x-ms-office365-filtering-correlation-id: d809e196-6196-45d9-2297-08dac67a2995
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlrcKHUJrOVS8zqqw6RVRFTL11NlEbCZBQyQDQOa4CITG6xL6VY9xeAgqPWxkyNxXgHPA0wU2hlc4LsAAA+NIRshA5vi2aNEy/WBAt0ueOZtU7w32rFyIPlKtjgXPq0T6Be2FdSGcp3t9i/YS6jAeibf4a94I7cWO3Fk5VUVG+5vN/LO/zOd5uZREZon1HshrWqO1z1/O8lxKvjtjrlPybfU/Kjxo1SN9IlFeL+AgupPCXQP/6ReUfONoUmMx/9ca5ytsfgCxvwuq5QPIiNzah2CvOs4bbNq8cLMsmCmqCwIh0WCPn0p4ChVK2qBbGgDqA9i6io0Ed+NfdQ8qej62mzpczmsbvk36GEUc/2f5wpr549vzRU73zJIn1XboIv4vY7dNifSk1eA1Y6tl+gG+A1SC1bwh1NiU3euis5VDG/D6sjsr3GbhsO6eCaDc6SnEKqhoXgL+779Zu7bWxE5rCXWI6992sM8UcWTqXokkVZRSmbmVe/O7BjG2HErSmjXJjvZmQrx9+PtThWgSriXSqQ5zQpTikgqW0x9x11Fauwr9LN/Osqw308kD5Zm0W8o7mPDV+h12pQmnGXHw6bZer4SZOiVrdPs7mYk7V12R87osRRp/ZwJsX2j7GxUn+K0U+ecTeKfugro7s1EmnJbOB7VQ8pbxNnZcaaG3XQfpTJk1b9SmFmysyqctDBdRJW3EoWuFn4DoKq57+3xn60NG0PKaRobePkI6UEjU2yOoZczhYd/fEdopJ2uDatsspoT3NjSrXTgpEsydu4CdvQ11Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(66574015)(71200400001)(83380400001)(86362001)(33656002)(64756008)(15650500001)(8936002)(66446008)(41300700001)(7416002)(8676002)(38070700005)(4326008)(76116006)(66556008)(66946007)(52536014)(5660300002)(316002)(66476007)(122000001)(38100700002)(7696005)(55236004)(110136005)(6506007)(54906003)(26005)(53546011)(2906002)(186003)(478600001)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Nz80fc8hrfCNrdaX80VmchR5Kz5eEAcZW+PJCSAW95P3g+8tiuq8ldSKU2?=
 =?iso-8859-1?Q?eepTTLBMiVrU06mU7IIu4T3VYPjPjv7hHYeYcBNj1tE9QpIGm3ARA44NYH?=
 =?iso-8859-1?Q?d3CZDJguaRx+r4COa8hqNzUhmmiAZWjX24uwVz87ApCvL4WMrrb4n12KSM?=
 =?iso-8859-1?Q?WU2nC3oK8SdAgofwoksg5dl1y5Rhn3b0FwpT2Mnv+dDkXbuiXwrzJMkUPa?=
 =?iso-8859-1?Q?ABPI0A1PHF/TIwTnR1haM4EY5Svz3DIuvwkhqdmm4XQAgvXvDeDw4vwutj?=
 =?iso-8859-1?Q?mTTFYezL2NUthVj1wl2j4Kmopgk51hw5ZvGWdcH8LQ7sSvTpCWdwoyFwue?=
 =?iso-8859-1?Q?Cb/vZhgYpkYTrtUdRxDRzTQjTiLYKPW0JCc5fDF3BH3HvpAkHCrk9/Onts?=
 =?iso-8859-1?Q?QVkwpU9iPY05WbmqUi1q8Ft7lMR4ICzW2Vsar65ciPPeM/e29Fkqo0pqWR?=
 =?iso-8859-1?Q?9RQ4t3UCfZs8+8P34R8/GabXNwcOCv3lZHAdBjwt7gM7StPeaptMBL680J?=
 =?iso-8859-1?Q?GJPTY/alU65Y1CBs1LdB4GAIrYp6CcO4AML2BqITaw02FGpKQvpDtES28l?=
 =?iso-8859-1?Q?Dt+0hQqr+9kgRwyVYlWkS1Mcaz5fGGAPE1gcrrxCJY4t4d/RMyRbD0Miot?=
 =?iso-8859-1?Q?t47Inpa1mSreOAJDlIaTQG+eBit5wfsrLdumqdqaCtkLT3EEYu1EAqoYka?=
 =?iso-8859-1?Q?hty6bwUjeg9MrrXDBogvJpce+q6Y6ujtezGo1W9kVRXVpltWRPenUDlFsC?=
 =?iso-8859-1?Q?lMedCjrTBiiap/oXlMCzMDwmJzzcEtukEWDaZdZKMsZQ0Hwf/yxX9014G6?=
 =?iso-8859-1?Q?nu0/htboA26zlv/ut7h+wKudCQ1obIeU2iOII3a0sunX+KkuoyAcS8sl/E?=
 =?iso-8859-1?Q?AIoo68cvvQ/FLENKP6o5hqw8FB0NPGoylym0p2FfSnGJXJmBjQ/BfCmlD+?=
 =?iso-8859-1?Q?adQ4iR4V2XgqHpgQfMq6tI1rMlC7zR15gqxsoCIwD486F/KruUK22NmCVr?=
 =?iso-8859-1?Q?GHTnESkKF4Ak+WZfDYcc94v8hqz4/LKPT3j8Wlp6Zp5Xe9dCWuWWd3stVP?=
 =?iso-8859-1?Q?ulfTIYMlw10kj1WobB8O5aeHZdiEx9C9J7CVCGJT0LfiiSZ0OlTfwkqOwB?=
 =?iso-8859-1?Q?gp0VlYdMXd4JXQCgEIJQpyzpmNiniZKd6B6mz4XY23Tq/mSS11K1HjHhtE?=
 =?iso-8859-1?Q?xecwA1yHyzH3WsxgZlK8Lkg5q0TcbLTyg0edjSWpPj01Y21vdShyxk6SAp?=
 =?iso-8859-1?Q?YfTS7TCIY/ivYd2OANP7RKQJ3UN6QaZZe/sGG8oFQeZ5aUejDoj34ZyyzS?=
 =?iso-8859-1?Q?SDvytxc/mg9NXc9+kjxq30hD3zluoaVdLGqfxmDnTLt2IQMVM3V3VHD+eO?=
 =?iso-8859-1?Q?gXnOjDMIaWxzHUfdY1VW7katZES2teTHSALZDRTSFqoVKMddoFcTcQABoj?=
 =?iso-8859-1?Q?YfuTXhlDuYALr8uySou81JcowQWuVd/bvStvkh254WKEJUOfoPWzwjPacd?=
 =?iso-8859-1?Q?nOK/cYEVfvzg9E7D40X9Cwn+DAROf3fDrH4ZH9rPP6hlYfnOseQ+sXTEq/?=
 =?iso-8859-1?Q?8Fr+l+q2Tf+rA/iiko65oTu2tDnDCrN2SGo1CZMxkuOGIYJcblrvrERmNn?=
 =?iso-8859-1?Q?9I8uFou1BNltEaFK0Iqu21foLLkbwc5G4o?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d809e196-6196-45d9-2297-08dac67a2995
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:55:21.1670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJz8kqPd3qq8XmpNB4VGwGncWin3g3annhJwjo8D1HwOUc8CSYOWur35AE5AcOIGDn5rdc969AJLUMNXK0VRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Pierre Gondois <pierre.gondois@arm.com>
> Sent: Monday, October 31, 2022 4:20 AM
> To: linux-kernel@vger.kernel.org
> Cc: pierre.gondois@arm.com; Rob.Herring@arm.com; Shawn Guo
> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-
> imx <linux-imx@nxp.com>; Chester Lin <clin@suse.com>; Andreas F=E4rber
> <afaerber@suse.de>; Matthias Brugger <mbrugger@suse.com>; dl-S32
> <S32@nxp.com>; Peng Fan <peng.fan@nxp.com>; Jacky Bai
> <ping.bai@nxp.com>; Sudeep Holla <sudeep.holla@arm.com>; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org
> Subject: [PATCH 07/20] arm64: dts: Update cache properties for freescale
>=20
> The DeviceTree Specification v0.3 specifies that the cache node 'compatib=
le'
> and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
>=20
> The recently added init_of_cache_level() function checks these properties=
.
> Add them if missing.
>=20
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
> arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
> arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
> arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
> arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi     | 1 +
>  arch/arm64/boot/dts/freescale/s32g2.dtsi       | 2 ++
>  arch/arm64/boot/dts/freescale/s32v234.dtsi     | 2 ++
>  8 files changed, 16 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 5627dd7734f3..ed0cc1a5d17e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -46,6 +46,7 @@ cpu1: cpu@1 {
>=20
>  		l2: l2-cache {
>  			compatible =3D "cache";
> +			cache-level =3D <2>;
>  		};
>  	};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index ca3d5a90d6d4..c8b1202d2584 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -83,6 +83,7 @@ cpu3: cpu@3 {
>=20
>  		l2: l2-cache {
>  			compatible =3D "cache";
> +			cache-level =3D <2>;
>  		};
>  	};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index feab604322cf..4590bdc076b7 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -78,6 +78,7 @@ cpu3: cpu@3 {
>=20
>  		l2: l2-cache {
>  			compatible =3D "cache";
> +			cache-level =3D <2>;
>  		};
>  	};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index 6f6667b70028..2a7e13b6ef8a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -95,18 +95,22 @@ cpu7: cpu@301 {
>=20
>  	cluster0_l2: l2-cache0 {
>  		compatible =3D "cache";
> +		cache-level =3D <2>;
>  	};
>=20
>  	cluster1_l2: l2-cache1 {
>  		compatible =3D "cache";
> +		cache-level =3D <2>;
>  	};
>=20
>  	cluster2_l2: l2-cache2 {
>  		compatible =3D "cache";
> +		cache-level =3D <2>;
>  	};
>=20
>  	cluster3_l2: l2-cache3 {
>  		compatible =3D "cache";
> +		cache-level =3D <2>;
>  	};
>=20
>  	CPU_PW20: cpu-pw20 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> index c3dc38188c17..c12c86915ec8 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> @@ -95,18 +95,22 @@ cpu7: cpu@301 {
>=20
>  	cluster0_l2: l2-cache0 {
>  		compatible =3D "cache";
> +		cache-level =3D <2>;
>  	};
>=20
>  	cluster1_l2: l2-cache1 {
>  		compatible =3D "cache";
> +		cache-level =3D <2>;
>  	};
>=20
>  	cluster2_l2: l2-cache2 {
>  		compatible =3D "cache";
> +		cache-level =3D <2>;
>  	};
>=20
>  	cluster3_l2: l2-cache3 {
>  		compatible =3D "cache";
> +		cache-level =3D <2>;
>  	};
>=20
>  	CPU_PW20: cpu-pw20 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 60c1b018bf03..187353458673 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -50,6 +50,7 @@ A35_1: cpu@1 {
>=20
>  		A35_L2: l2-cache0 {
>  			compatible =3D "cache";
> +			cache-level =3D <2>;
>  		};
>  	};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 824d401e7a2c..d8c82da88ca0 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -52,10 +52,12 @@ cpu3: cpu@101 {
>=20
>  		cluster0_l2: l2-cache0 {
>  			compatible =3D "cache";
> +			cache-level =3D <2>;
>  		};
>=20
>  		cluster1_l2: l2-cache1 {
>  			compatible =3D "cache";
> +			cache-level =3D <2>;
>  		};
>  	};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi
> b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> index ba0b5305d481..3e306218d533 100644
> --- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> @@ -61,10 +61,12 @@ cpu3: cpu@101 {
>=20
>  		cluster0_l2_cache: l2-cache0 {
>  			compatible =3D "cache";
> +			cache-level =3D <2>;
>  		};
>=20
>  		cluster1_l2_cache: l2-cache1 {
>  			compatible =3D "cache";
> +			cache-level =3D <2>;
>  		};
>  	};
>=20
> --
> 2.25.1

