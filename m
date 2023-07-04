Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2022746CB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGDJED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:04:00 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2130.outbound.protection.outlook.com [40.107.113.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F952B3;
        Tue,  4 Jul 2023 02:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ8sPckdiXqkI9c4nsQMy81mEzVpi88g8mRmE8nWY61ihEe6GREjnm1QQZga4lGaTQcXVstRLfqL/xBeOwmi3JJzShR0QHvjGfJPluH7yhtt3WAlxaEJuZewq8VqPysQrqem33/cHQfDnsqOmc3I4gRwMkdYIOhRqpqub5rnOdQ1aq5iSAblW93i9Mf/xhnmMHgTEW0n988AkgrxJWBXccirjmaZR10UBzMCcIBmJJnJqcE+L4L4oUrG/808VQKJip+RsqrYF/QdGtRmvR+A1p2abP8L7pAV1P7d6wVx24GY4ZK/ig4lw3H3uKUKcQaSO3/9TVaE870hRWuEr8ZfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD0b5V30CyZA46adR1TIOnq/XSDMyMX/cXjtUvgxNcU=;
 b=NmmyiGKBRf6pLIBZlWrzXIGY3bPcvOHFsre/I4SOAfK9caCny84qQmuuWYPM6w1xfhhOzrlItEPlfGgZHnr+8sPFfs9Lx/k2BzlU5DS/w7HsOvhwGB5N7PLbMbi5uI2YVQjG9i7kMHlW6sRb/iPvEIecN7dpwaL6JekSSe8UwmcceLrpPDGplXlVok5A7aNU636RHImyUpuV+xKOFs+i4F3j1w/SZCiFbJCEnXD9/+w/zgsF7cGdjAJTUAL7s7IyVRZEl0n4YROkw9PEYPmdBqxttHxM2e4ut8dEfJWYvfZesfW9ljHogZ+0YUN7nIuQDqBSq4RRxc5WYyNrZwSV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD0b5V30CyZA46adR1TIOnq/XSDMyMX/cXjtUvgxNcU=;
 b=WJm3CcoPxyZdgP+LbK07WvcEVPdHQCm7Hiixox6DTRnsrWDccr91xFRgyBexqLVgI5ZfquaEFIsk6y1pkB/peoBsS5SZWh5GRhI0+4tBAY8ZtvA+Jzjaxlm6ei0iJnYocm7qaV1QgBSU9wUWH7yrblqGc6lHBw8Xpuq3cr2TmvM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYAPR01MB5754.jpnprd01.prod.outlook.com (2603:1096:404:8059::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:03:55 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:03:55 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode
 names
Thread-Topic: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode
 names
Thread-Index: AQHZrcAMuBNq47TlH0WksypwKPtrNK+pUUlg
Date:   Tue, 4 Jul 2023 09:03:54 +0000
Message-ID: <TY2PR01MB3788EAD4F3199695E15D7201B72EA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
In-Reply-To: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYAPR01MB5754:EE_
x-ms-office365-filtering-correlation-id: b6444aee-135c-47ca-a4b5-08db7c6d983c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jg44V1F3uRpai9ZGwTwYou8NWYlVarwkPICXacScnr42SRzNHV/QkgExZyTgEvRSUszhaKjNCkco83vyzz4mNupRg6BaRVPeSmdlgWiovFWyKspW+1BhpE5LMOye1X1C70ADAkb0qbYMfmjzm55KMZhN/vYY2+mjvnHExM7VHe/UlNzTIuUo/xtjgjuUj79s0SiDhszkGIQy2VJND858iCy0BIYF8JC7IsH1uCbe0QONvRSHwB4FIscguX+Sav6Xo/9dxnslK9PJ9F7PpTANCwadFA8NZ/3v84K+hvytnv8KVn2fYCjP3C7oeLBjdOqyuVjPy4juWg1Jafi9B1Xc9zQt0hB4/JhUecXDHVeWK7ZIs1OUDpn8hlV1wq7fngGJXZYnP9MI9C3JJkuFJ69om8fnf6bs3mqSMr1GWkAW6Yyv2TYWKvE9FR9iMPuzLj6036T67oq1hMtp0Hu4tKmD/HmHX1u2I76b6W9IwYJeiNjXBOJVifgObE5OxgmRAtTDHcf7M3y1Ldmh/LxnK3WNN2FIzbVdvYa7rVFQQUI88suLtRzHTOhVI1dD9D/FbI08UmpMvvJppwoLVeCyw8PU3+Ha4HntPt07Cd2sLLhBtZcWwGB9hEbYX3q6yqNlTA0i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(26005)(478600001)(9686003)(6506007)(71200400001)(86362001)(186003)(54906003)(38100700002)(66446008)(6636002)(66946007)(66556008)(4326008)(66476007)(64756008)(83380400001)(110136005)(76116006)(7696005)(316002)(122000001)(5660300002)(8676002)(8936002)(52536014)(38070700005)(41300700001)(2906002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ptndK0CNy6E9OADE2EIrpVGgFQsHKH1hYsM86HazDZbpu8zdu/+CBF3K?=
 =?Windows-1252?Q?9wtVu4k9CWLszqteruIPFqGqtWTal9IhASKA5HPUM3oaAM8AMo0BVfQW?=
 =?Windows-1252?Q?PoRZDHk/1Gv/aYMGNAono+oMg3mgHZTlWBhmcJgBM2PfBsM5Cb0xyKAV?=
 =?Windows-1252?Q?IA87hHpx+oI+yJPffpdlJTgFFDRvY4UMtd5gAX849jaoFvq6BoLYvNml?=
 =?Windows-1252?Q?WVzqxD6vacokfxThUzsbvAtJP2+mqWokMCbvGfp1db4dM26ICxLW7E2q?=
 =?Windows-1252?Q?hpO1L9kBSzTWF6p3MUguTICakL5tWNsFgQkyeg5KRZW3DeGMc/W0D2lP?=
 =?Windows-1252?Q?nF6LcLq4aY+CHLbEG32XGhEc2d/rIQkzdEEZUVBNZDst7dCAXZ0TT8Aq?=
 =?Windows-1252?Q?h10uVEG+hbPv4ADTS9KxPFufskt0m0cnF8VB8riGkeSdI27+72zxap/h?=
 =?Windows-1252?Q?i1lGJQ6nEWxuUb5SGSTehunG7kMITooZWCh0MTjRhJcwerbvFm4BDX4I?=
 =?Windows-1252?Q?ocJrmWTcYFvWI/uMMgOVoHTptu+mWyugGhM2yHOSOsMxjH3tDqD//kF1?=
 =?Windows-1252?Q?fa2y8O2qSLvSE5mPMajRzJuhZDSLGJzyu3Bvw2iz0YCdKilZb4ApaL9p?=
 =?Windows-1252?Q?Upt9e3Z3s/L1PbvLJpGTJQ+vsOXG1rUHUll4n3uMdo7aguCWaU5HM+Fc?=
 =?Windows-1252?Q?fwqCsBejYknBb17m0N2VsrRye4jIICijLr6CGTD1CEZUZpHv5ijucMZH?=
 =?Windows-1252?Q?dAzqRBivXwulYxtyvnzQCRQZvGxClVD2TlB3x1TK+hFXQYm2P8mH7oLk?=
 =?Windows-1252?Q?qrNygdNRPf7cyRJOS2jcTQ9ViSSKqtKgjurV8qbTITeP2xQ0hCRiV+FG?=
 =?Windows-1252?Q?tGpq79uvDvDELMkjQ8ZmNaSEhM39PofgDK9U78SWpnk8oARzs7nzLq6I?=
 =?Windows-1252?Q?rw7lkandlVm7U7ruQ5304E9IhKefnexpnr4mwlVO7k1r9X+yIuodjj4F?=
 =?Windows-1252?Q?GFT1Enw8Y1nlDKYz840j4I8xkiIpoeOI24Xp1m3zbk1NoMjYCJS2tqZr?=
 =?Windows-1252?Q?ZM8OBb253CtorWKcDUOSs+S8J4cLq2JgFhJQw10f/10fEQ09GwOtcEcR?=
 =?Windows-1252?Q?4LQN3VMH6NGPh69pY9RtLl8gUE7eDK3YPWKAeDEfs2bG7f5TfFpiyXKZ?=
 =?Windows-1252?Q?3eHJDVGMmaYRqO1gcPVoc/3Q8fkx57qm+qwow94SKRy/Ig104vJQAac0?=
 =?Windows-1252?Q?rroapdOUXnrc7vKZr4RV1B2ECVwPtjRNftgqd1pZPNKTCahGmMq586xF?=
 =?Windows-1252?Q?W2VtMshvZRPCUGsQ35yzvNTs+YMNXaTRpwA5HtXbG5EyvKnebKjusBrZ?=
 =?Windows-1252?Q?GvxeDMKoa04rj8nOkPUa0FjZm6XIEe567MJVOHksf947CrIg1Q+oHyfu?=
 =?Windows-1252?Q?M2z0I3QWGZgpy2Le3aciRlYDhEcbVPLB1iZrw8e16RvnX4h0HhzZoheL?=
 =?Windows-1252?Q?OGyLal0Ead5sXhecxSshqC1VkEeL2MN4OlNygc3GD+3bw5JNsc9G1Gi2?=
 =?Windows-1252?Q?8X7yIXTHkNlFgJQrrB/UDEM0y9Yi96637HSNWJJRNEPpeBT4Vdx5IUIp?=
 =?Windows-1252?Q?6rl6xk4J9mD2HePRpHZrZXOPat/88vDuK8rcSws00gWCUO2Pr6+apeRO?=
 =?Windows-1252?Q?PG66EXYxhHvQ/WfuC9FeouIgkPgH0J6KJfAKuFzf/lrGFJnswLUi6A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6444aee-135c-47ca-a4b5-08db7c6d983c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 09:03:55.0127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChxT+MR/1s0ylIegb6ppua963jiaq88vCv5s0e4+tIe7m5Ge9aol0QSfaQr31lf5+AdJdoNdtmxMMJyIf3BDai0MQ7cMdqsDBDZ5fP/MBHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Fabrizio

Kind regards, Chris

> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: Monday, July 3, 2023 4:07 PM
>=20
> The eMMC and SDHI pin control configuration nodes in DT have subnodes
> with the same names ("data" and "ctrl").  As the RZ/V2M pin control
> driver considers only the names of the subnodes, this leads to
> conflicts:
>=20
>     pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by
> 85000000.mmc; cannot claim for 85020000.mmc
>     pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
>     renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting,
> reverse things back
>=20
> Fix this by constructing unique names from the node names of both the
> pin control configuration node and its child node, where appropriate.
>=20
> Reported by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Fixes: 92a9b825257614af ("pinctrl: renesas: Add RZ/V2M pin and gpio
> controller driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested on real hardware.
> The RZ/G2L pin control drivers needs a similar fix.
>=20
> Before:
>=20
>     $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pingroups
>     registered pin groups:
>     group: data
>     pin 130 (P8_2)
>     pin 131 (P8_3)
>     pin 132 (P8_4)
>     pin 133 (P8_5)
>=20
>     group: ctrl
>     pin 128 (P8_0)
>     pin 129 (P8_1)
>=20
>     group: cd
>     pin 135 (P8_7)
>=20
>     $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pinmux-functions
>     function 0: data, groups =3D [ data ]
>     function 1: ctrl, groups =3D [ ctrl ]
>     function 2: cd, groups =3D [ cd ]
>=20
> After:
>=20
>     $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pingroups
>     registered pin groups:
>     group: sd0.data
>     pin 130 (P8_2)
>     pin 131 (P8_3)
>     pin 132 (P8_4)
>     pin 133 (P8_5)
>=20
>     group: emmc.data
>     pin 0 (P0_0)
>     pin 1 (P0_1)
>     pin 2 (P0_2)
>     pin 3 (P0_3)
>     pin 4 (P0_4)
>     pin 5 (P0_5)
>     pin 6 (P0_6)
>     pin 7 (P0_7)
>=20
>     group: sd0.ctrl
>     pin 128 (P8_0)
>     pin 129 (P8_1)
>=20
>     group: emmc.ctrl
>     pin 10 (P0_10)
>     pin 11 (P0_11)
>=20
>     group: sd0.cd
>     pin 135 (P8_7)
>=20
>     group: sd0-uhs.data
>     pin 130 (P8_2)
>     pin 131 (P8_3)
>     pin 132 (P8_4)
>     pin 133 (P8_5)
>=20
>     group: sd0-uhs.ctrl
>     pin 128 (P8_0)
>     pin 129 (P8_1)
>=20
>     group: sd0-uhs.cd
>     pin 135 (P8_7)
>=20
>     $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pinmux-functions
>     function 0: sd0.data, groups =3D [ sd0.data ]
>     function 1: emmc.data, groups =3D [ emmc.data ]
>     function 2: sd0.ctrl, groups =3D [ sd0.ctrl ]
>     function 3: sd0.cd, groups =3D [ sd0.cd ]
>     function 4: emmc.ctrl, groups =3D [ emmc.ctrl ]
>     function 5: sd0-uhs.data, groups =3D [ sd0-uhs.data ]
>     function 6: sd0-uhs.ctrl, groups =3D [ sd0-uhs.ctrl ]
>     function 7: sd0-uhs.cd, groups =3D [ sd0-uhs.cd ]
> ---
>  drivers/pinctrl/renesas/pinctrl-rzv2m.c | 28 ++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
> b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
> index e5472293bc7fb247..35b23c1a5684d3e4 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
> @@ -209,6 +209,7 @@ static int rzv2m_map_add_config(struct pinctrl_map
> *map,
>=20
>  static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>  				   struct device_node *np,
> +				   struct device_node *parent,
>  				   struct pinctrl_map **map,
>  				   unsigned int *num_maps,
>  				   unsigned int *index)
> @@ -226,6 +227,7 @@ static int rzv2m_dt_subnode_to_map(struct
> pinctrl_dev *pctldev,
>  	struct property *prop;
>  	int ret, gsel, fsel;
>  	const char **pin_fn;
> +	const char *name;
>  	const char *pin;
>=20
>  	pinmux =3D of_find_property(np, "pinmux", NULL);
> @@ -309,8 +311,19 @@ static int rzv2m_dt_subnode_to_map(struct
> pinctrl_dev *pctldev,
>  		psel_val[i] =3D MUX_FUNC(value);
>  	}
>=20
> +	if (parent) {
> +		name =3D devm_kasprintf(pctrl->dev, GFP_KERNEL,
> "%pOFn.%pOFn",
> +				      parent, np);
> +		if (!name) {
> +			ret =3D -ENOMEM;
> +			goto done;
> +		}
> +	} else {
> +		name =3D np->name;
> +	}
> +
>  	/* Register a single pin group listing all the pins we read from DT */
> -	gsel =3D pinctrl_generic_add_group(pctldev, np->name, pins,
> num_pinmux, NULL);
> +	gsel =3D pinctrl_generic_add_group(pctldev, name, pins, num_pinmux,
> NULL);
>  	if (gsel < 0) {
>  		ret =3D gsel;
>  		goto done;
> @@ -320,17 +333,16 @@ static int rzv2m_dt_subnode_to_map(struct
> pinctrl_dev *pctldev,
>  	 * Register a single group function where the 'data' is an array PSEL
>  	 * register values read from DT.
>  	 */
> -	pin_fn[0] =3D np->name;
> -	fsel =3D pinmux_generic_add_function(pctldev, np->name, pin_fn, 1,
> -					   psel_val);
> +	pin_fn[0] =3D name;
> +	fsel =3D pinmux_generic_add_function(pctldev, name, pin_fn, 1,
> psel_val);
>  	if (fsel < 0) {
>  		ret =3D fsel;
>  		goto remove_group;
>  	}
>=20
>  	maps[idx].type =3D PIN_MAP_TYPE_MUX_GROUP;
> -	maps[idx].data.mux.group =3D np->name;
> -	maps[idx].data.mux.function =3D np->name;
> +	maps[idx].data.mux.group =3D name;
> +	maps[idx].data.mux.function =3D name;
>  	idx++;
>=20
>  	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np,
> num_pinmux);
> @@ -377,7 +389,7 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev
> *pctldev,
>  	index =3D 0;
>=20
>  	for_each_child_of_node(np, child) {
> -		ret =3D rzv2m_dt_subnode_to_map(pctldev, child, map,
> +		ret =3D rzv2m_dt_subnode_to_map(pctldev, child, np, map,
>  					      num_maps, &index);
>  		if (ret < 0) {
>  			of_node_put(child);
> @@ -386,7 +398,7 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev
> *pctldev,
>  	}
>=20
>  	if (*num_maps =3D=3D 0) {
> -		ret =3D rzv2m_dt_subnode_to_map(pctldev, np, map,
> +		ret =3D rzv2m_dt_subnode_to_map(pctldev, np, NULL, map,
>  					      num_maps, &index);
>  		if (ret < 0)
>  			goto done;
> --
> 2.34.1

