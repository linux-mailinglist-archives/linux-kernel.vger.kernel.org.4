Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81967EDA8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjA0Si3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjA0Si1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:38:27 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C41EF88;
        Fri, 27 Jan 2023 10:38:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LedsnBsXKaOGyoLUOHskTDzZ9slR+N5xsQUYmJl9vQ/FjNver6vMeq8Gr9ZDRP4Tkj0/Gp4aVrwdQCqzcTEUUL/j4yJITdLaaFCTOXXRhCb7DF17YZfqEjWkfaNnGdgVYtQpRh3B3uhnk+kOC1DYCTRplJbUW0MuczlE8eB44FHphHSHVx4evUfCnnpudXzDgD8ZxpDPzgunG1vK2F16XWAjr4sS1XE9l9nL3Vri3+yKYHpvCJ/0bzF4lYxH0Bwi2+L2sv1wncWPOiZ+D8UDS/ehWpn7j5PmV17OmsKA5Rl4AXPeJz+IftjGFL5O0FVJfSIATAfzZ2MwhispdglbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS+iweqvaCqqqd2HcUSof0XUEUxYHfKM8HkjOZmeQ7k=;
 b=nAaH4w/sb17ENawhujPuCfGEj/m+zHJE8J5hpStm80gNjXtaldYez/e4L/jiuQJoRZZyNdpwurDRdJv+1QNTzfDl2IhjZsVJGwhp3xAba8YjhDSxTLwWIPYW66ZZhcvyAKeLCEcMlxiYhtr5lAsGIEgu2J5cPBYVm+VJzaUeVW+p/X++rawv1exaoKEEMKm85fQAweJBDfXUKdTqxCirR0Ay6St77N4fMFu6R6t2C1N97RGA52XwQOrVoqiIDPk8Bh2wFASjWLYmogHpO3BFaOdlbVOOIU0w0/Xsnkfn4riQi8uhTZzVIND3wj46M76FkqjDwLOvwC0S6RqkgglCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS+iweqvaCqqqd2HcUSof0XUEUxYHfKM8HkjOZmeQ7k=;
 b=CLhZfHmqAYbBxP7Jc+DufyJ9FCNOx7dnUk7z2I8fVscjx6VM4ohP9j2ParqzTQ1yvrr9+2pDyL3aTl4WznN6+y8i8Xpq43WoN5xMpC/74q9ot9yZBS+z4fY3CIvEkixxtN5gt4ghFduy9rdwksqOH5RI7TshVDoMTJ5brwNWcHY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB11011.jpnprd01.prod.outlook.com (2603:1096:400:3aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 18:38:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6043.025; Fri, 27 Jan 2023
 18:38:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
Thread-Topic: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
Thread-Index: AQHZMnZx18nss4OApUidU5RRdrsm4a6ylwAg
Date:   Fri, 27 Jan 2023 18:38:05 +0000
Message-ID: <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB11011:EE_
x-ms-office365-filtering-correlation-id: 0e7eed83-86e7-43ef-3bd9-08db0095a11f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PG+Lmk1QcU4HuVLdWfF4cofhDtahpOrb3R6RpbdDWjcxkyqqRVXkSPHjOWFQv35wilmOcllebTx43gjGlpwLPRTrk7RhpLybwGpo/azpCB+kxag9v0djxCzy8cWAdAPQ/HgvM/wwQc7ygi3m++GB8S5DaFXyfTNtT+4nQZxXYu5o49q948eVlQhtN4mAMvZgdx/X4RNvbnXcmpFZy1eaZG173b+qwVAO/OuGHVpTc5SdBN5x6B/gHc0loXuRC2fxj2UVFlb/8TU1FH6f91Zw8ijchCM/J/GWQAiuSkuSas35VJ44vZzW0+7mDCrs/7V9fSkIXUx5VxZgsu3Vq+D8oXUIm91dXRC+kCE+LPuXxoel8RlYnnj4qLOJ0Z/HwxeI+crrXp0ilcpYOuscT6+j/uC/0BleFzPLAMqlhENahYCzNW/Wv5i5yn30HW9LJOu5f7vyI+WcCmDD+13rD+pRXq/fm8AxnjXzLb/hgg6VUVI9b/KUnXrOmk9yUb7UmlwnViM9PjggEA+YHzU4c639R/I8CVOrw7rBrfuSTt1Ywlnq4mqhZ2LESwpAtJ3CEpcvsrJKGirnvL0veQCLGOjZL0Gh+BxKzrOHgB9oamu/kfL8Ts3WtbDyEHfkaYsOli0qc56rpi5SvVRkSRZM71MWLYJtFRuhOXbhKHYEP1BHb/W5YcCVMf4KMS32cZNr5TPFixwtett0/gCsDwI5Zw/OuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199018)(2906002)(52536014)(5660300002)(41300700001)(8936002)(33656002)(478600001)(26005)(8676002)(186003)(9686003)(76116006)(107886003)(6506007)(4326008)(55016003)(38070700005)(38100700002)(122000001)(86362001)(66446008)(64756008)(66946007)(66476007)(7696005)(71200400001)(66556008)(54906003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JUttNkMIcmSZ/+fG24U9gNk2jYuzuRD4OUdZbPkrbvX3e3+MaamzgbhgxLsh?=
 =?us-ascii?Q?vUG2GRGjMzsORFmFG4vCeaoBbT3IZ2S2460CtAJsosTp22zfZ3rsWIT026M6?=
 =?us-ascii?Q?4+mvL6IyTUQSqxwqMD1CcLpI2MsYeMjMKlQoCRNVKBt39oqTUwuqBZT8B2Qj?=
 =?us-ascii?Q?cIlEiXzjpw9m0+rEuvGLawJPy/7byNiBcgJq3cjiN9lZDgqo7Y2K0sGtGpDk?=
 =?us-ascii?Q?WuleCKQn8mb4x8ybASoHM6ST98kDkiBpRb0TVo51JCXatKdvBse7ywWNqeJq?=
 =?us-ascii?Q?byxy4BFp9enbRaW3RBvL9R7V7bUR5oLycNrOAmb9px2M/g8ed5bDxzCfXtbm?=
 =?us-ascii?Q?1pnlcP1dwIYcVTXKHLWevCESuuGAvEFbqk4JWJXJlFRIW4ld6/0wJX57A7i+?=
 =?us-ascii?Q?SzKoA2RIHKYeknUpr8qBI2jGbeeIfwq0h6EvRSHDajJNVB4YVDfj/sxwRNMu?=
 =?us-ascii?Q?d45ciipOOu3AeX/idOPiI5Sahls4Qiti0ParlBvFTYVrdMRWVq7HcCZhc4J2?=
 =?us-ascii?Q?046Ad/01XkhWM9tzoaCmn8OPqgkKInQD3QbQ4S2vw8mvofK3BgfgYjKOD1Tu?=
 =?us-ascii?Q?eLWWgVLvSGOMJlRXBW5iCX5lrvdL0UfxBGvlDX/WpdOeFk3Ldye0R5daqoUD?=
 =?us-ascii?Q?RTQKNgRBGZSeJXZSggu7h4cSzLwgeqqaVa4vS6LLaDsWqZqiX+/VLJRCr9wv?=
 =?us-ascii?Q?vxQI/p9qk9xJrtBysnLtfhY9uTGfsOJmQ/JAUezyzYD/7ZOxC0qctVwkb0mL?=
 =?us-ascii?Q?pto6krHQuBNtdxI40Oh0YNedU6SUXC4D1RVlwDkGtn9lekQbhWrRtIU0RKgc?=
 =?us-ascii?Q?/jI2ltddtFBilumZAXm5aXLTH36YWlO2khPDawFT85g4D3Lt+76vAyVRDnFL?=
 =?us-ascii?Q?TloAeKnkAbfdJK8/pwUSPzDQwg+EfTRAc6JU+WepCSXzO2g+ywDW4xw/zIl8?=
 =?us-ascii?Q?S+un2tJrYDCsWWeW+d+FWNhb0pqi+6YgzE/l6eiDkpDeWA6ffnlHAzTDvTiI?=
 =?us-ascii?Q?K5LogtLFrrP3BEIgGI+vuux8WrT2f1EdUo/7POvRGNgxGq9hNRxTPH2zfwDj?=
 =?us-ascii?Q?vBKT0CLD9NrWSQV1xLThtZjO3r9xa5IvHW3oRugZQDHgKZ/h74Y/Q2Kb8yBD?=
 =?us-ascii?Q?TeUb7o9EjtFToScOzZyIVxTyhp6sMy6YodR1+DhU1m6I455zr9rH4iw6Bmkk?=
 =?us-ascii?Q?MxK7K70ElJNjNj284lTzKY/O7xpirRoZGsoQMPe7f+p4zrs971jbkV07ehgJ?=
 =?us-ascii?Q?sHEYEwaWWkgpnbiYUFUE+ag2oRILs5eYHE+R7cFfVtThnQ5GDTV0qBpN4/7c?=
 =?us-ascii?Q?d6elkI81gSrGF9eFSnjNUdlWMGx0oI4NyzbOfCCkWXSqn3WWK2avM2wp/0Mu?=
 =?us-ascii?Q?CxfEnGfPUQFtvDjniOLPnQUYKQjMq7IVwWknAl/kSv6vtPmLqLIZCY2/hZYe?=
 =?us-ascii?Q?rvtlyf4ptzGlKszLK4m7xJO1P/6ZR6QgAqLV33lCy7KetOiF96A4QPN7Pymr?=
 =?us-ascii?Q?h83Rhgq+Q70/3S+wvhgcjAGIUmfxXQfcmOkxEMZPs6/SgOA24+h0XVmDLm1k?=
 =?us-ascii?Q?l46vyuUAtmD/KwfYFY7FrU60IdpiE8GblZLEds0ak0gZvP/G1mzw78C0icoP?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7eed83-86e7-43ef-3bd9-08db0095a11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 18:38:05.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TBVopO6oXEII7u32DvaQ5HQi8yN//hK8aAgh8nQtV5JF0X29LJQnhGA/OXKF13yXEofvvQJJcSa3GE+FPft1sB4X9pEIsu+oyn1/Sklffs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11011
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

> Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Enable the performance monitor unit for the Cortex-A55 cores on the RZ/G2=
L
> (r9a07g044) SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> index 80b2332798d9..ff9bdc03a3ed 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> @@ -161,6 +161,11 @@ opp-50000000 {
>  		};
>  	};
>=20
> +	pmu_a55 {
> +		compatible =3D "arm,cortex-a55-pmu";
> +		interrupts-extended =3D <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;

Just a question, Is it tested? timer node[1] defines irq type as LOW, here =
it is high.
Also do we need to define (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW) as =
it has 2 cores??

[1]
timer {
		compatible =3D "arm,armv8-timer";
		interrupts-extended =3D <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TY=
PE_LEVEL_LOW)>,
				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
	};

Cheers,
Biju


> +	};
> +
>  	psci {
>  		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
>  		method =3D "smc";
> --
> 2.25.1

