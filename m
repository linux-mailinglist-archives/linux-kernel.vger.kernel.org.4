Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1A746BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGDIbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjGDIbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:31:21 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2110.outbound.protection.outlook.com [40.107.114.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD7198D;
        Tue,  4 Jul 2023 01:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnljMZ+DhDrSd0RJSqTj86bXUiui0BjJ3zy2sm9NWqOZZh/p+RII5j8Z7kEm5VopBzYDT0+43vwrQZSgYI+q8vTPjuAZ3tVOMFdUzfF5oIqGla3jVQRcp/q9AO9E1316DhSzl8JeDG3TEpAFE3bRoR8szBn2RgNJVhitTgAUaKm0JI3BXTMO56pKhWktLSVaLXlNBZGSCIzwYbRKIioIVxhXISF7m24b8+8KYlsVRK1dCfTwbPigDogdU1L1+7aomSd2rL8wSM87AZD75scr6/4ICGrI4oVZyLBUcXPF0sK2MOo6WY4RuLbspvHsOxZPvZbfHQjO1agPzVH5m+J3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKMxXq3YrWblayMZ/o+hXtKwFgBoOTxRt874RS5wLUc=;
 b=faosEJm0iWluZ94u3k26ZXIfp+lW8Wp4gUWNlfnmxIPSJGPxYFnXaBR+m7RG07FC82F6TgrYC3tqKTjlTNL8Mi1/ZzzhQQiqY0CcA3yziO49gbTRfYhpWG+0sfuCz4BqvAmz2kpRvBs6RFmSp6i+8ZxPc0hKHuL5JgoOMcEX07PVTancsgvTmd+HhIWyK11d+dI4jheZEuhBmnWZBg64S7cXnak6ehqKNRNjgl1BPZRABAMQvt0L4YJ7Tg02S4g9UJHT8PaXI9a39Buu2VJk6mi8+G26fwi2XTdIheCW+KrdALQd+iWKem6Zi39iAMhIGcHq1kftuIt5u0QX59tRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKMxXq3YrWblayMZ/o+hXtKwFgBoOTxRt874RS5wLUc=;
 b=MUQCHvbpo/2Ntj2sr5MLGjuwqvKfJ2TzHkjMKBiZF4CcijEcevn5M+iOBZzGkATSJEKC5xOs1Og0Fv/obr0BQdUNfY6w256PoR30z7M9SB2526to0elBT2RBCsgAUS21sU/A6OyAsDit9iwPbvaQ62ZJq4fvvtEJTDaSP0PCZK0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10087.jpnprd01.prod.outlook.com (2603:1096:400:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:30:49 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:30:48 +0000
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
Thread-Index: AQHZq0sktriyRHMRaU2I/KvG3PLB4a+pTAEQ
Date:   Tue, 4 Jul 2023 08:30:48 +0000
Message-ID: <OS0PR01MB59223E030DAE587A49C9D0FE862EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10087:EE_
x-ms-office365-filtering-correlation-id: 10958868-43f6-4331-fd5e-08db7c68f80f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxSeqmmqvk+5hAtiJ4JgfrhJkVa417VcSYZZWCN6hNNg1FYjZnZ/XDvlSzkwFIsRJUF4bvYfFukIec3SW6A3GGxAx13i1mcX/YHtgsReov9JklKWfoIV0bQh9IPj1/c32sZ9Dt2AyO6OKY8WBZEozLmWEsQCnrT5fE8VqdoZFE0uc3FQKHiCTTGm+Dd+D6hDrnI0EFjyD6uNS3TTljD51m60+kXlWmn/chp81IbkHc7RE96VH8IIU109hKo+br+cJwaav7XPmZ2tqA+cFDSBPN/aUWMWuQHQhl5vGOYx4jHfvKhiIREtDtYvDI2VmOS41gQnZuJPXrei8oZw47ufsOgO++JYVbbhV2V+JWK+OAkUEtS9UfLnJ730OMUs6CtwR89Xyq9EtBu9VOYM5Y2mV3TxkWDm6BqrsXbKjbms1iqtWAA8G+E71Uokf81+UzXqqI6v8ho//D+lOpmXAL4qOsLduPD7ReMahPboWI+/dfAGPRPFnFgiLIhS0B/JNoCqVU3DLJ22kh++QI45a3NGjgj5v7ZRwf1ysvY5vCOP+WHobK64kaJX4yjDN3rUfd2lEccuxrfyJpwKdrFUeFM+uOW3YSztDrVksFf3pxdmyka2hnhSt/t50L4oki4T6wdy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(110136005)(54906003)(30864003)(2906002)(9686003)(478600001)(26005)(41300700001)(86362001)(33656002)(7696005)(52536014)(8936002)(8676002)(5660300002)(7416002)(71200400001)(64756008)(316002)(66476007)(66946007)(66556008)(66446008)(38100700002)(122000001)(55016003)(4326008)(38070700005)(53546011)(6506007)(76116006)(186003)(83380400001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lG+S/GSjtkYtH77B4WKtkgWDVAkez3K8zD3FZATVMSxHCEhpn2qzJwg0JW+a?=
 =?us-ascii?Q?YqM1LmWOhz31Esz9syKOEhJWgNGr47GOgFCQ+1zWaDukZcNVkdnHVR2iLzVU?=
 =?us-ascii?Q?6K003r0IUUm/5v1zCidLBauSa5FYGrJzUpYP/7CfbqyWNShGLCWXE+TzoRV5?=
 =?us-ascii?Q?DPlpZx9z+6pDn7NZc16hazde9jsxdR94QGBE2mb6EWzJVU4aA+0b7aSoCIWf?=
 =?us-ascii?Q?y9Ux+A3cj8e3hYpK6nBophCaLy7GcdLKzn6GCY6gNHn8Sj7tY5iy9QbTFKab?=
 =?us-ascii?Q?0BcSNKaJbRF/19xENTenyU1Qw/8dKjI3X4um8lv2vDUNv1bPjaTWWCnA6cDY?=
 =?us-ascii?Q?fAQQXteG/BbZ+CQgIsEQzCRo5d9g6KoABYPhyOB9n3PeFYACW3d4NPF0ggku?=
 =?us-ascii?Q?N6Zhbjp90jysukNgGC6k2L7xizeeJ84sygG569CM8rAAq+K2SJ96W952zjRr?=
 =?us-ascii?Q?XNT6e/lnsI448Dofezkh2e1LgRlMI0wjDaS/u6GNajzPW/MwyMzeOjP9gHWz?=
 =?us-ascii?Q?SMxIFkStSI/NArB2xbtkT7mwsDmciMkqknvg99HYRh4Y0SSUIL+13AIjBpqM?=
 =?us-ascii?Q?qteltykNEGQ+wL42LhNYbJ6fL5rZy19gEgsor4Dozs/0Hxw58KjpYPfKN1Vk?=
 =?us-ascii?Q?j6x/8O16Jwc1VRZf4NRvL/pJm25mvNR7Fd53PjTOENR2ZqCoGeMpOJVBmraR?=
 =?us-ascii?Q?GTh/+KviTVBJf9ntW/TdNP29sQymXp00nv02pRDbTwp/mzIdZDzqSBdcin7n?=
 =?us-ascii?Q?vk+7d++XBD2wKFrn0zKsjyR1cniDVS5xDlJZdN97CwUFrQV1Oqwm6iRjQP9P?=
 =?us-ascii?Q?hyPwNBhMgT5MP0/EbI8IHi7+8fB2jwIeynuu68BIQveSb35SNcTkHuTUAJ4Z?=
 =?us-ascii?Q?brrB6ky8OXdELMMGVb/Mfjhuan/q7CnIr75esiXX1fHbiK7ZF6m82U8tRe+4?=
 =?us-ascii?Q?m09sxmh5LIZgyUDpb6jc4cg3UPdliZ+jjDu5hwNuxWo8d3vDfl2gCFQgKEzA?=
 =?us-ascii?Q?qGLVDxNSZMZ81otG1Dbz7hMCoUNPxfOIqDaznAw4yRW7UxUsS3kHRb78/tDH?=
 =?us-ascii?Q?vVZ33DU7eLF6lOlrcNBl2XSXrffOZnmnhhsobKEEINocBRwXSNB+Ot59aWn0?=
 =?us-ascii?Q?AYq80Vhp+Qj4qFRoWzUP6IpgYOU20Hj0o3CgPoc1A8uCAP3Q3VqalfRKJEDn?=
 =?us-ascii?Q?OgfZR9NIp5QOeZPFi1lzC1KepZlLx0TC/tqlu2kdSZeoxNnJo42C5k0Dy/wf?=
 =?us-ascii?Q?CQg9GuPG2WWm3S1C5DQNyeAhl9JXkSekFUX8BxkwIHHlTb8UXR+6xyznY8vL?=
 =?us-ascii?Q?TA/s1kpXczbdJpPl4yOSfQu/d00MusFXyifb+mzVVgZPaDXOL1F8yNxe7HR8?=
 =?us-ascii?Q?6kLHGl1SAkGZAPyiPYkeYd0FadCy6zmKxIOqbbssGc/h8XnjZomdDg1WReVM?=
 =?us-ascii?Q?jQGGF12iuxy5YjBoGONU7aGy/DB1r4fRe6YbUMmKEu6jWylYNTIlXjAv/v8G?=
 =?us-ascii?Q?jVQWmWKU09rmRWJoVfUWPYWdIHrZy74d9yrP71ClB7xBV8nt8zSUTk/xdims?=
 =?us-ascii?Q?CAxjFW702kJuomJBD+wref8wYWCK6km/04+dn8lg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10958868-43f6-4331-fd5e-08db7c68f80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 08:30:48.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2EjlfLNO03HcGb1klx+ezIPM8M/JUiSvIzVtoLX8Lu5l4jtg96TsE50v1vtD1FByFmBahxkJTBRWeOU41exdS7CuyULN/N0Ndavhyu9TjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

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

Can this be SoC specific? Only for RZ/Five you need this changes.
Others SoCs like RZ/{G2L,G2LC,V2L and G2UL) still work with u32* as there
is no holes. With this change memory usage is doubled as we change from
u32->u64.

Cheers,
Biju

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

