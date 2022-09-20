Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9C5BED89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiITTVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiITTVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:21:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60763286E7;
        Tue, 20 Sep 2022 12:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu7A7Ge/LCnQ+KWhDFuKISASblK32QtiOetn8vJsiHGw+IZ5AECEqopM8e04g8MfyqVJCxNJxZzCsWtIqnnXlr5D5rQ/mvOu1IrgnRrCeW0pgQGNg5XlpNMYdPPWzQmT6BN85ltyOah/bxV98fTlvFCj38xnVOpX2q3ILUFa1eGqINixVHqt3Vc4j7ckLxqNDRmGAZaVnwJh4CwvGrO0wyQ02VTMZ6f1LnUnFbQMiL8s92L49aqroz6oQs3NEeMnvtDFgWge6VPkfE/tlKVM0dOcq2IVnBNsqCmxBJ7BZBZLOLa1Tk1zzYLHIKQ6zowz3d9dVimdqNcr51/3SCvaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y9/dYQl1wFdi1kGbflvTYCnro2W8NXgSwTEUDLG/EQ=;
 b=apzdEam0A6LEZbUfZzQ/BjKL+9AidlhgRtBcweBTsORDpO0oWEiJOMpML0pAMxcIapL1L5/ApI0UU/zkGeQKb8mCwPOSlxAGF/LlY2MWJHs0EKTcxHDOxNzWtCF6cDw2KYEdvtcErietd6+oOCbKqqR3QO98S977svlpGMqD6mOpiUAxNXnt23DIC7XdnZ9b1KsBIEexZD5D00xmTbnqfhAA1cB8/GTGknvMs7vTbPTshuEup6Zv7FncCC42/8nwwjdxYkhm3V8f/ngl1uRmmb0fGocmsSpdkX9v+PB9hVnTzjk2XJ0Hby+SA20GZfKFXaWVc9QeRNGrH/90s+BM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y9/dYQl1wFdi1kGbflvTYCnro2W8NXgSwTEUDLG/EQ=;
 b=MibWNEVWUj7Sp06AgYzrDG5RfdwrUNRpKVDkMTZrFie+huLJATuZgG3s/0oXmjkWYuMwNNW9pK9DP9D+nzAeKzcRWd57ssshX4IteP23nPH3qKLK0CHFuvfVCRx8Sht42HGaj8NuH1ufH7aODDv9d33ibiUKaR8aEphBDQUiM6g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9830.jpnprd01.prod.outlook.com (2603:1096:400:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 19:21:46 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5654.015; Tue, 20 Sep 2022
 19:21:46 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder nodes
Thread-Topic: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder nodes
Thread-Index: AQHYzSHUiYFQxotF30GY+2sg2SrZHa3oru6A
Date:   Tue, 20 Sep 2022 19:21:46 +0000
Message-ID: <OS0PR01MB5922AFDAFE3DEBBFFF875875864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220920184904.90495-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220920184904.90495-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9830:EE_
x-ms-office365-filtering-correlation-id: 1fea970f-a740-4654-5979-08da9b3d5bdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8twCaBRtAt0xACQx+3/CHcde/1/LX6CFC6qfx669/20NgpcVz/JiYTqMBjh6gPUeGOcAhsAeCE1mA2FJwFlvrAVt5NlLw2lxWv+EmpFnLoSVRi+wtyY3eAL7zhcPIT+s00ySiRUeq4VQWoKTABYyQ6Az5sA3RxdG2GLsU4q8TGh5SspGBbBdqw3xOuv8pAW3bvk0vkqAKQX0io2SHiEt1X1ecUyB14SCIWMM0bZgvr/KVuPKXeVzfCgr/jWtLnNjRvsleRzWNSVpz3PiZzNnowARIcsyvTEYu9PJTkz5NmhyOElBDpHRlGVTUOWpa2cU07N2F8x9RNk/yFDKTFfpNvKT+rNMF2NYnQ/ZncV6ZHRwTQLXzHNxzOroyIDoadYn55kygwQMsOwP8Hg8I0Hj5uz1de263/JzYA87AZWmhnSloDSy4eOY7++chnBdYaydPvg6tTRjknaz+TBOP0iyufPHB+FOxtctTIu38RAwgPUaG7KcyxFcdIzarM2uQvXDHdZ9OrVLchIpNb/92l9hTvNPLNftKaUm5J+d/4MlFsfpHsNsfH0283Flwemz7F1bczxNiq+YlJ2EFqjZcITyvUcnddtXorhMGsROCP/WYJyIhzrHydSuJm8WW5ry5dWjqzF1rOVSBLKi6t7t/RBSh3ALA2DkG/Q96eamqXc6quIS+/nnVRbcukHE3aHDTiMlYv1higFjk7lVYdZLzrUd82uaEwaiqf966jYTU66tkGBdHjcN7Mt7HNT5q0ZCKHc3G18Ylsl7sbenZd6BoziiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(186003)(83380400001)(6506007)(7696005)(26005)(9686003)(86362001)(66476007)(66556008)(64756008)(66446008)(55016003)(52536014)(66946007)(7416002)(5660300002)(8676002)(4326008)(76116006)(107886003)(478600001)(41300700001)(38070700005)(71200400001)(316002)(122000001)(110136005)(54906003)(8936002)(38100700002)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?98anw5LLcUvQPomDduJhOXyDy6J92OB68ElbrYKgX/BCrgJNGi3z90RLmd+0?=
 =?us-ascii?Q?sgFAKJddJTK6WuOkC6mt2I3fIhRupUYjZ2IufwqBvPGLZupXvZoqIEk4BBNg?=
 =?us-ascii?Q?nJEkinoOdl2fecpq4jR/0K8DCOyvDkJJkiB+CyR5qqp4EWhZs+i0sGHs/28b?=
 =?us-ascii?Q?ZYahmrvfU5Kz2b2OEGrFIKp68hW/9mmJ7vk520C2+3lhUKU/46oKvZLWapbA?=
 =?us-ascii?Q?cfRvubic9xPowfah/rv73YMsQAyI7PKIVzbxN+o1UNQdw53yDo3352+h63ZZ?=
 =?us-ascii?Q?ahlBtTgkTnEI6YIHOTRZx7zYz6IBDdGRjHZ2el4V8hhaTmQyrXkJbOX5Xss8?=
 =?us-ascii?Q?9IqFHzpwk1ja3nl0uP+U4G5BnMTQ+tWNg5ZAslEqRsIr6mSkU/AaUH7HJzTn?=
 =?us-ascii?Q?xExsO0a4tOpWOd7WpCencnpuyEcxfOAZehKHeq3V95hyE7TDq+LjgI6uGr3b?=
 =?us-ascii?Q?hLoKmJ6Wv3JEW/+ymfVc791daNrvuvnrxOep3cJfk3LqLBFXNcMO8cfKX7Wu?=
 =?us-ascii?Q?oogrCFXDFO4kccr2Rx9DMSLey6q+kmM+hxLsS5XVRCKb+V7zV6MaHHbyLgfa?=
 =?us-ascii?Q?SSp/2u8rVWfUFxDdpzJg0dLX6KidkaJVzNMFQ+2NZt/XFQt3urwNzEDbKMkr?=
 =?us-ascii?Q?iI01eJadO55ytT5ZDcRq//hUXMxhbz6k+EvN5dfcKTrAOCsbxrwjJyTpRK0v?=
 =?us-ascii?Q?zDzprK0QAkyJ+k4ZOOg91hQDf413VItziZk2lowvevcOBPUSBWv9dBA+k2d8?=
 =?us-ascii?Q?6ugRm0P4TZ1v0OS/kG6+lw9Isd+RgsvR+Ofzrnq+hA48liVwh8GZ5uy9JczE?=
 =?us-ascii?Q?1FCmNhQ2r3f0KECV2KTP43OOHRmGiG0leEhbwzJdQITrqxQNX56piZQl/uvO?=
 =?us-ascii?Q?TLa+2FhrFdANTQxncMVHIqHhe4Hryofo1ky5fbcSe7QCo8iLStUl41DAijI1?=
 =?us-ascii?Q?0fLcfYSa9x3jU6CEUXC+TL/0vH6eipnwOuBRquGomWcFu6i4z1u6n10bV7dB?=
 =?us-ascii?Q?Z0SAlMO4/2bct0/LmDlmrOZZ+lSlBwSm7magOvlA77UJT9RV0RDb43ATy7Z6?=
 =?us-ascii?Q?EgPFR2Exy5W+s1r9xGGFxb3e2XAUunVOPzf7gpqly7tFE5yvECRncWZBzNS1?=
 =?us-ascii?Q?syYVT8DOfWANwy/NEPiXLxnIlg6IJZpnxnrpsMNTbGsbLJ0yJtNrZF/WxRAz?=
 =?us-ascii?Q?B9/GQbMypu4bErNFg0ZCay8tQ7AAYyePGtLGUcf49oV7DRwd+VElJDqzSE2R?=
 =?us-ascii?Q?c9RM0O46ZcU57/6A5k67wOVvhSaxGCcUsU3a8bWQ4yxICfVofnEM5dRaVKNG?=
 =?us-ascii?Q?0tKe9T/3WmJLMjZOTiwHKehULlyIRx4UMaxqiWx2uIC0Tq+zJ3as09ppAoeo?=
 =?us-ascii?Q?7oC05jGynr0gJNvI8SI4xQHQ6AL+GOgMz8PmJeDcXMj/qijGZ05F9kIzcu06?=
 =?us-ascii?Q?Q2Avww6qBZQJYf2O58bmgzmX3gSX0qV3osemuZLWd+IaYVehdGFk1yJbsqIK?=
 =?us-ascii?Q?fTMZqPUFb5GugFD0jJQLFjtBm5AsL+ghR4rZVuwwbH7KSURrfea84GsbVR5x?=
 =?us-ascii?Q?k2+v5RECyn/XX1TXqTw4KAGg1qGrxso+2EnNsvcB8GyI4796nNc9/alKCyXF?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fea970f-a740-4654-5979-08da9b3d5bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 19:21:46.2198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5P8vv0BMTMTHepWGOgEInvcO698P0aasDkllYKBfEVcjFn2GuqoWgCaOAStX5Y/pTuCk48hVa+E2hYN/lJI7cPpt62N/UbPTdIMcqztuDx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9830
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for the patch.

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add empty placeholder nodes to RZ/Five (R9A07G043) SoC DTSI.
>=20
> This is in preparation to reuse the RZ/G2UL SMARC SoM and carrier
> board DTSIs([0] and [1]).

Just a question,=20

Why can't we reuse SoC dtsi as well, as 90% of the SoC nodes are same?

Split common stuff from arch/arm/boot/dts/renesas/r9a07g043.dtsi=20

and add ARM specific CPU, IRQ to arch/arm/boot/dts/renesas/r9a07g043u.dtsi

RISC-V specific CPU, IRQ to arch/riscv/boot/dts/renesas/r9a07g043f.dtsi

Both r9a07g043{u,f} dtsi will add common dtsi.


Cheers,
Biju


>=20
> As the RZ/G2UL SMARC EVK enables almost all the blocks supported by
> the SoC and whereas for the RZ/Five SMARC EVK we will gradually be
> enabling the blocks as a result we are adding the placeholder nodes to
> avoid DTB compilation errors (currently we dont have support in DTC to
> delete the reference nodes without actual nodes).
>=20
> [0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
> [1] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3 -> v4
> * Dropped status and reg-names properties
> * Updated the commit message
> * Note sbc node is not enabled in RZ/G2UL SMARC EVK but will be soon
>   enabled so added a placeholder for this too.
>=20
> v2 -> v3
> * New patch
> ---
>  arch/riscv/boot/dts/renesas/r9a07g043.dtsi | 150
> +++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> index fb6733f3cc2b..d90d263b1b13 100644
> --- a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> @@ -13,6 +13,14 @@ / {
>  	#address-cells =3D <2>;
>  	#size-cells =3D <2>;
>=20
> +	audio_clk1: audio1-clk {
> +		/* placeholder */
> +	};
> +
> +	audio_clk2: audio2-clk {
> +		/* placeholder */
> +	};
> +
>  	cpus {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> @@ -54,6 +62,19 @@ soc: soc {
>  		#size-cells =3D <2>;
>  		ranges;
>=20
> +		ssi1: ssi@1004a000 {
> +			reg =3D <0 0x1004a000 0 0x400>;
> +			#sound-dai-cells =3D <0>;
> +
> +			/* placeholder */
> +		};
> +
> +		spi1: spi@1004b000 {
> +			reg =3D <0 0x1004b000 0 0x400>;
> +
> +			/* placeholder */
> +		};
> +
>  		scif0: serial@1004b800 {
>  			compatible =3D "renesas,scif-r9a07g043",
>  				     "renesas,scif-r9a07g044";
> @@ -73,6 +94,41 @@ scif0: serial@1004b800 {
>  			status =3D "disabled";
>  		};
>=20
> +		canfd: can@10050000 {
> +			reg =3D <0 0x10050000 0 0x8000>;
> +
> +			/* placeholder */
> +		};
> +
> +		i2c0: i2c@10058000 {
> +			reg =3D <0 0x10058000 0 0x400>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			/* placeholder */
> +		};
> +
> +		i2c1: i2c@10058400 {
> +			reg =3D <0 0x10058400 0 0x400>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			/* placeholder */
> +		};
> +
> +		adc: adc@10059000 {
> +			reg =3D <0 0x10059000 0 0x400>;
> +
> +			/* placeholder */
> +		};
> +
> +		sbc: spi@10060000 {
> +			reg =3D <0 0x10060000 0 0x10000>,
> +			      <0 0x20000000 0 0x10000000>,
> +			      <0 0x10070000 0 0x10000>;
> +
> +			/* placeholder */
> +		};
> +
>  		cpg: clock-controller@11010000 {
>  			compatible =3D "renesas,r9a07g043-cpg";
>  			reg =3D <0 0x11010000 0 0x10000>;
> @@ -104,6 +160,82 @@ pinctrl: pinctrl@11030000 {
>  				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
>  		};
>=20
> +		sdhi0: mmc@11c00000 {
> +			reg =3D <0x0 0x11c00000 0 0x10000>;
> +
> +			/* placeholder */
> +		};
> +
> +		sdhi1: mmc@11c10000 {
> +			reg =3D <0x0 0x11c10000 0 0x10000>;
> +
> +			/* placeholder */
> +		};
> +
> +		eth0: ethernet@11c20000 {
> +			reg =3D <0 0x11c20000 0 0x10000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			/* placeholder */
> +		};
> +
> +		eth1: ethernet@11c30000 {
> +			reg =3D <0 0x11c30000 0 0x10000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			/* placeholder */
> +		};
> +
> +		phyrst: usbphy-ctrl@11c40000 {
> +			reg =3D <0 0x11c40000 0 0x10000>;
> +
> +			/* placeholder */
> +		};
> +
> +		ohci0: usb@11c50000 {
> +			reg =3D <0 0x11c50000 0 0x100>;
> +
> +			/* placeholder */
> +		};
> +
> +		ohci1: usb@11c70000 {
> +			reg =3D <0 0x11c70000 0 0x100>;
> +
> +			/* placeholder */
> +		};
> +
> +		ehci0: usb@11c50100 {
> +			reg =3D <0 0x11c50100 0 0x100>;
> +
> +			/* placeholder */
> +		};
> +
> +		ehci1: usb@11c70100 {
> +			reg =3D <0 0x11c70100 0 0x100>;
> +
> +			/* placeholder */
> +		};
> +
> +		usb2_phy0: usb-phy@11c50200 {
> +			reg =3D <0 0x11c50200 0 0x700>;
> +
> +			/* placeholder */
> +		};
> +
> +		usb2_phy1: usb-phy@11c70200 {
> +			reg =3D <0 0x11c70200 0 0x700>;
> +
> +			/* placeholder */
> +		};
> +
> +		hsusb: usb@11c60000 {
> +			reg =3D <0 0x11c60000 0 0x10000>;
> +
> +			/* placeholder */
> +		};
> +
>  		plic: interrupt-controller@12c00000 {
>  			compatible =3D "renesas,r9a07g043-plic",
> "andestech,nceplic100";
>  			#interrupt-cells =3D <2>;
> @@ -116,5 +248,23 @@ plic: interrupt-controller@12c00000 {
>  			resets =3D <&cpg R9A07G043_NCEPLIC_ARESETN>;
>  			interrupts-extended =3D <&cpu0_intc 11 &cpu0_intc 9>;
>  		};
> +
> +		wdt0: watchdog@12800800 {
> +			reg =3D <0 0x12800800 0 0x400>;
> +
> +			/* placeholder */
> +		};
> +
> +		ostm1: timer@12801400 {
> +			reg =3D <0x0 0x12801400 0x0 0x400>;
> +
> +			/* placeholder */
> +		};
> +
> +		ostm2: timer@12801800 {
> +			reg =3D <0x0 0x12801800 0x0 0x400>;
> +
> +			/* placeholder */
> +		};
>  	};
>  };
> --
> 2.25.1

