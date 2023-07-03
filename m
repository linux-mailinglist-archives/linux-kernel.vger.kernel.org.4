Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BF3745B63
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGCLmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGCLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:42:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2101.outbound.protection.outlook.com [40.107.114.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235D0B8;
        Mon,  3 Jul 2023 04:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU+SxVcdl6N7mw9kLZE0wnq+xAn9M/KK5bIuxJEccmVIkkhz9u/iUhXpJqKXATQ4ywhxD37R0AVXpbH86a0rVuMY4fULZcVjhuBiiek7pf9QwhSjLDFrhC9HB11jD4FopBbmgDCv+a4m1YrdcxKRkjfw98Ryc4aDujnZZn4Oi9QgfercbVYjZ4jjp+abVzpS57oSLkTP+xMeW/RrCZsqeQ62mn1TDR9N7jA0VFEQDqmZtucrXSmT6GQkDgVf8VoDaN5HK/PjV8zdUfPOp/GXF+rarzYguGfaZOWW/FzWZVySasEyYC849iIdYiBPFhw22ELXbA+0tSav1KyHpPf6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnYjJKm2AZnIywk19McAl73zCf4kKMFHuKt8cGU3dHE=;
 b=JMPdVZI4ipz15tmJcPRgtaSbYymffJfzurX/Wt7LpijplrzJuy4KEUEN27nx1zUZbvzuGMRwGC6yv/moZC9t/G55Zw/gdmOA2sO5qOeaTfAXiWVgmkxTKNkGFe83pCXwTYQY9cby9lBTiyTohwERgl3caNmenAMjElniNChJoPBW4JYu8B19zRKNINKR0gFhYihGb+9ZmVEe9AAuniG2HgpFn2oZzyk0DFB3UqnPbePLNCBc6WMJWsEuMWnlNfPp2L+JuCZMLKuCCFycTCStz5JDcYNjKcPEP10KKjMFJisZGepU3ELuRLSXCpgJYFB0f0a9mmUA0Hv7HYXZ0TUpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnYjJKm2AZnIywk19McAl73zCf4kKMFHuKt8cGU3dHE=;
 b=daXV3xovLlPUuZiJasDKRDtAcU5o74ugifR1rJXONMpebtIqu/IjoO8Vf155MwQgFibq1+9YUQ3taCP+HHV0M2Q3IUOk6p1YwoapLOKSURTF7FU3YRtGR6y/Umhj2g30bBNT3OhrMsg5jHfk9UD6JsSf1nVX/L8aeBlU7jumDcc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB6219.jpnprd01.prod.outlook.com (2603:1096:402:3c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 11:42:43 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 11:42:42 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
Thread-Topic: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
Thread-Index: AQHZq0sktriyRHMRaU2I/KvG3PLB4a+n7sYg
Date:   Mon, 3 Jul 2023 11:42:42 +0000
Message-ID: <OS0PR01MB592217C4028606B67B39C6858629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB6219:EE_
x-ms-office365-filtering-correlation-id: 00c6a3c4-a795-45d6-e569-08db7bba9cd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H9bEKG+eqD8hS9ajSxPwDDvjb70e81Lp2p/+yc3eV+/waXcZ6YdQ4JIYgEH6i/0TjZqWJhIhoDDI34t8is2Tg/gP6nXqQP19Ur72+MXVZjgkIlLuElgzqsYIhOQD9mtFVfDfVNiumM4MQp4rNGrxNjRW/MBSPtJ9wk2oA1gwb41su8J/lWSsSraM/53ni4xCVjiDYG0gbXwkTLObUJEqGXRRfM51SrV72EIAk0Yld26LUe+atmcdN+je2i3qDZaYywJHK6k6HlwaF/3cckmT4ddVBR6MiGcuk6EdPel4eaZbEVLn0eTZq/E6sEyUoE1npjRNbhEAKQcJbj11f/U/2QcCP8J99250Cj6Egcj/7kA3U2KsaBKCsEtl+2hfyJULbt7f11wuk9BfCNKWyPWHzdB5t6XJbeY1Y6/XaanRZA2aiA6nb/oD66k6kXTIFCgxr1xv2m97rUDe3I3WW1bzHDiMlJyscWCfP+rajR8iOde7283mSQuPuIIm2BvciaUlQjX+dsKVbpPq0UHoE/kIZrGDzrGdHNmOa0GqS5b34pXmThNs3/iS8bC5d+lFCTIbwgE5w9rlD4apUwwtiMImiM4cJMUx/0AD2R8Q1VehWZyo4erbNoz9uNi8Vg+f9vY+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(107886003)(316002)(41300700001)(7696005)(53546011)(83380400001)(26005)(9686003)(6506007)(186003)(478600001)(54906003)(110136005)(71200400001)(122000001)(38100700002)(66446008)(66556008)(64756008)(4326008)(66476007)(66946007)(76116006)(55016003)(52536014)(5660300002)(7416002)(33656002)(86362001)(38070700005)(30864003)(8676002)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?izEfZmCEw4kEw7ZmBds1fywpNV7uqMQbIfjQlUcODOLUlC1ERsLHDtV2guKf?=
 =?us-ascii?Q?HRzUgHvSw5xU/49D/590mPPCMUh5Ukx7eBkl0gs6BKGVsvKJuJxW1SH8Oyb5?=
 =?us-ascii?Q?hWoxZ7Ek0uUZj4cFVLK2BF/xw6BPGoApB2DWVNr7Stg/CdsnuM3Ooei+GEVa?=
 =?us-ascii?Q?SLtKJdj6Wz0ICaNuKP7DSqHK4tQJk2X8ibjvvCOGwmdMEfyKqG8MCBWeEYCa?=
 =?us-ascii?Q?5f0UkI8UnvrNQMcGYer2y9e9Hf2w0uKL/xaaBvQGbqWGXyk1raso6FLK5TVY?=
 =?us-ascii?Q?aeFJRhv+lGa6uXxKwTU2CJMNMFzJLcfgz8sCS0EptJED1hHQQpVi8iyCfGwZ?=
 =?us-ascii?Q?lZalQKeowa7NzUrlFy3MDVkBwwUv87ZyfTOM3xyfWEPC6pX4itZ2uQJoyre0?=
 =?us-ascii?Q?67FfpTlIyouxsCYnTaHUN2f7rZaGdjp0qQxL6cZMia7JxyBkYsuVbpq9TPa6?=
 =?us-ascii?Q?a81Lc34xmow1gpbzFulU3ry0WALGbW3sIbE01IylkMszPRIEIOtWvaf7mJPZ?=
 =?us-ascii?Q?WGHZoKSE288R9UYP3FIEJTHyA/HtzROI4KZnM1s13yi/1IJFuQShZ77imF5M?=
 =?us-ascii?Q?tdCVURDdInaAD0EBqWSqZGzBxZpeLKO8t2zIZ20zKqmsHAGamTUMo63Gtv5Y?=
 =?us-ascii?Q?a/aTcx3bx8w4a7XngpCX7in78EE087G9jnbW5EYoTjzYHzjbthPP+qWDjeY8?=
 =?us-ascii?Q?JkaSUJ9J10KjW5W0Dl1ef1tPNlxjsi8UFWWKwlDfSzieYR+NwgIvYm3mBpK6?=
 =?us-ascii?Q?To7bc/JelCnc2KuCt6fWhK6k04bPihzx6qtWgukLqKB35ROWORWP4KQMEwtl?=
 =?us-ascii?Q?w11bZaZwe/N70XaPAEwQMWh4iCX5DK7kWZiNaUJhEzL387nX0bj5MADnQrer?=
 =?us-ascii?Q?IrLtP2wtBbKUonvvK4n1VCoRVwldLJ9YNQTouh3Hzo3AFlGb1bPmOg0aI2KG?=
 =?us-ascii?Q?10z5svD2dBWpgqMZIxPlSBoulnLPBHU0Y96Qz1cj2AiXVkCmeq1r6jWc+5O/?=
 =?us-ascii?Q?iEkvTlS5I6pkJNuTOD0ZkK/sBOT/ioap4Vk83/qoXij5NSBqiKjqb09fxSoZ?=
 =?us-ascii?Q?Kk6j0jVSlAqORHBz5B5TUjP8FYQ06wi3IyE4DxdvkEgmpp4tXzXFyfCP4Ayn?=
 =?us-ascii?Q?pYvVSNA48jH8PSH5hLf561eqq8EDIzBgRa5B70W1Eq7VEyLEhZTWGytjTnWF?=
 =?us-ascii?Q?n8JWYtm1s3HxnPqxt+GN4OrTjGzPpKchKoqBc22gVoNKZ67sAWQUTDg9Ag60?=
 =?us-ascii?Q?jhJLqNFD6AjLjSSr0edF4oC4B9UbnxoHhx2K8slbEi4fNlH8d506U7fv9kSx?=
 =?us-ascii?Q?bTM6zsrIGKsBHf5iPVEAeY8xhA8Im3ltByeHBbKnYv4T/mIhLuB3IjcHBf/D?=
 =?us-ascii?Q?S77T5Gv/zks39momtJWEuReqXiI0MF31HGxDGHOszbwj6wtcAGdwfIsicKDA?=
 =?us-ascii?Q?81mL6mMUWziYA8Cyn/N8wrv1iS07+Npm2UP5mwLwFjDbelp/YbJl8CREsaxZ?=
 =?us-ascii?Q?97W6S6xiTOeixG+IVHRT5poIqutqe+6FgLmOdJExF//OUepqspx6ZSrEkrsZ?=
 =?us-ascii?Q?6YYhSlNTdMDqNjQy+5w6iiZB8FfDIBH2onUAfQ5w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c6a3c4-a795-45d6-e569-08db7bba9cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 11:42:42.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+DthxQw44oVkb1uyIf3ojo88XuU9naXttFQ4ZQoGQ3khrkUovGF9EqwA+RmUPlR+K14MARIUs6FzCRz2GbI89wX/IdP/JbL0LS550VDooo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6219
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for the patch.

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: Friday, June 30, 2023 1:05 PM
> To: Geert Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> <magnus.damm@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Linus Walleij
> <linus.walleij@linaro.org>; linux-renesas-soc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-gpio@vger.kernel.org; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar <prabhakar.csengg@gmail.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
> RZG2L_GPIO_PORT_PACK() macro
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Currently we assume all the port pins are sequential ie always PX_0 to
> PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pins P19_1 t=
o
> P28_5 which have holes in them, for example only one pin on port19 is
> available and that is P19_1 and not P19_0.
>=20
> So to handle such cases include pinmap for each port which would
> indicate the pin availability on each port. With this we also get
> additional pin validation, for example on the RZ/G2L SOC P0 has two pins
> P0_1 and P0_0 but with DT/SYSFS could use the P0_2-P0_7.
>=20
> While at it, update rzg2l_validate_gpio_pin() to use the port pinmap to
> validate the gpio pin.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 167 ++++++++++++------------
>  1 file changed, 86 insertions(+), 81 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 9511d920565e..a0c2e585e765 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -67,10 +67,12 @@
>  					 PIN_CFG_FILCLKSEL)
>=20
>  /*
> - * n indicates number of pins in the port, a is the register index
> - * and f is pin configuration capabilities supported.
> + * m indicates the bitmap of supported pins, n indicates number
> + * of pins in the port, a is the register index and f is pin
> + * configuration capabilities supported.
>   */
> -#define RZG2L_GPIO_PORT_PACK(n, a, f)	(((n) << 28) | ((a) << 20) |
> (f))
> +#define RZG2L_GPIO_PORT_PACK(m, n, a, f)	((UL(m) << 32) | (UL(n) << 28)
> | ((a) << 20) | (f))

I guess, you can still achieve RZG2L_GPIO_PORT_PACK(n, a, f) with=20
((UL(PINMAP(n)) << 32) | (UL(n) << 28) | ((a) << 20) | (f))

#define PINMAP(n) GENMASK(n,0) ?? Then you don't need to modify rzg2l_gpio_=
configs.

Cheers,
Biju

> +#define RZG2L_GPIO_PORT_GET_PINMAP(x)	(((x) & GENMASK(39, 32)) >> 32)
>  #define RZG2L_GPIO_PORT_GET_PINCNT(x)	(((x) & GENMASK(30, 28)) >> 28)
>  #define RZG2L_GPIO_PORT_GET_INDEX(x)	(((x) & GENMASK(26, 20)) >> 20)
>  #define RZG2L_GPIO_PORT_GET_CFGS(x)	((x) & GENMASK(19, 0))
> @@ -129,7 +131,7 @@ struct rzg2l_dedicated_configs {
>=20
>  struct rzg2l_pinctrl_data {
>  	const char * const *port_pins;
> -	const u32 *port_pin_configs;
> +	const u64 *port_pin_configs;
>  	unsigned int n_ports;
>  	struct rzg2l_dedicated_configs *dedicated_pins;
>  	unsigned int n_port_pins;
> @@ -445,13 +447,16 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev
> *pctldev,  }
>=20
>  static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
> -				   u32 cfg, u32 port, u8 bit)
> +				   u64 cfg, u32 port, u8 bit)
>  {
> -	u8 pincount =3D RZG2L_GPIO_PORT_GET_PINCNT(cfg);
>  	u32 port_index =3D RZG2L_GPIO_PORT_GET_INDEX(cfg);
> -	u32 data;
> +	u8 pinmap =3D RZG2L_GPIO_PORT_GET_PINMAP(cfg);
> +	u64 data;
>=20
> -	if (bit >=3D pincount || port >=3D pctrl->data->n_port_pins)
> +	if (port >=3D pctrl->data->n_port_pins)
> +		return -EINVAL;
> +
> +	if (!(pinmap & BIT(bit)))
>  		return -EINVAL;
>=20
>  	data =3D pctrl->data->port_pin_configs[port];
> @@ -501,7 +506,7 @@ static int rzg2l_pinctrl_pinconf_get(struct
> pinctrl_dev *pctldev,
>  	struct rzg2l_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
>  	enum pin_config_param param =3D pinconf_to_config_param(*config);
>  	const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[_pin];
> -	unsigned int *pin_data =3D pin->drv_data;
> +	u64 *pin_data =3D pin->drv_data;
>  	unsigned int arg =3D 0;
>  	unsigned long flags;
>  	void __iomem *addr;
> @@ -591,7 +596,7 @@ static int rzg2l_pinctrl_pinconf_set(struct
> pinctrl_dev *pctldev,  {
>  	struct rzg2l_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
>  	const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[_pin];
> -	unsigned int *pin_data =3D pin->drv_data;
> +	u64 *pin_data =3D pin->drv_data;
>  	enum pin_config_param param;
>  	unsigned long flags;
>  	void __iomem *addr;
> @@ -965,78 +970,78 @@ static const char * const rzg2l_gpio_names[] =3D {
>  	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6",
> "P48_7",  };
>=20
> -static const u32 rzg2l_gpio_configs[] =3D {
> -	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x24,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x25,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x26,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x27,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x28,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x29,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x2a,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x2b,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x2c,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x2d,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x2e,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x2f,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x30,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x31,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x32,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x33,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x34,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(3, 0x35,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x36, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x37, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x38, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x39, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(4, 0x3c, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(4, 0x3d, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(4, 0x3e, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(4, 0x3f, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
> +static const u64 rzg2l_gpio_configs[] =3D {
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x10, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x11, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x12, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x13, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x14, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x15, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x16, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x17, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x18, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x19, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x20, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x21, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x22, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x23, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x24,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x25,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x26,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x27,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x28,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x29,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2a,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2b,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2c,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2d,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2e,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2f,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x30,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x31,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x32,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x33,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x34,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x35,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x36, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x37, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x38, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x39, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3c, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3d, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3e, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3f, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x40, RZG2L_MPXED_PIN_FUNCS),
>  };
>=20
> -static const u32 r9a07g043_gpio_configs[] =3D {
> -	RZG2L_GPIO_PORT_PACK(4, 0x10, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(5, 0x11,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(4, 0x12,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(4, 0x13,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(6, 0x14,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(5, 0x15, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(5, 0x16, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(5, 0x17,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(5, 0x18,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(4, 0x19,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(5, 0x1a,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> -	RZG2L_GPIO_PORT_PACK(4, 0x1b, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(5, 0x1d, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x1e, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(4, 0x1f, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(4, 0x21, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
> +static const u64 r9a07g043_gpio_configs[] =3D {
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x10, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x11,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x12,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x13,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x14,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x15, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x16, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x17,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x18,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x19,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x1a,
> RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x1b, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x1d, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x1e, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x1f, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x20, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x21, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x22, RZG2L_MPXED_PIN_FUNCS),
>  };
>=20
>  static struct {
> @@ -1396,7 +1401,7 @@ static int rzg2l_pinctrl_register(struct
> rzg2l_pinctrl *pctrl)  {
>  	struct pinctrl_pin_desc *pins;
>  	unsigned int i, j;
> -	u32 *pin_data;
> +	u64 *pin_data;
>  	int ret;
>=20
>  	pctrl->desc.name =3D DRV_NAME;
> --
> 2.34.1

