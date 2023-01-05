Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC765F495
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjAETfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjAETes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:34:48 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522211C3A;
        Thu,  5 Jan 2023 11:32:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLyOlw9aXus/pXWfd4B4v51xrGKq3FVDA5laCBvR4vVAYM9eftNDGMYces5IpNds2u11LzVuJCmxzyZoWYf/UteroXNhzB7KFQDG050qq1mwlX2c6xbFf+i6eAjpHjKozZ4TVAgp90EBC5/n++hUGTnT1YF+Y2xDVwXkFS7a8FVJbf+UMUkzWSjXRaHZNBylRUlyJtb+5AfckEjqRVY1WKSqivgGcro+ZkCnVpmnUizJ+gA9HAgpIJO/oilXJKVB1VDL1H1u8n3AGs+V1x2m06Pmjo/DWSV1Hl5WXs8qx6KpKcIZX8TAIZPZOPJQ64kos4IeWmo5W1iCiM2WBUsVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4/YVHMjvRz3E0eSWhLEI2jfdlH3eTpZJLBmu1vydd4=;
 b=SrsGjmq8ZsCXPiH6jmy6EiAM7I/xG270Cc+jz3iTVmZUfKkF46MnJp++c1zrYNPUiQiziuSbZUhCSdSV+4G6wJYfa8Z6+5vUhU8iU6Vu1CaONJDZnD/Ec89suia/1fbC3Xrzw/IwYd2jQB3bW/PwDGSye3NpDW/vQ3xC/bkN4ytX2ZmiQ4pKMFmytR7b6YiuC5MpTblwN2Ha2tiymQ00Z6CbHdzBEo2+tm/ssf2bDlCduESe0lEpQYMGkiRemdEDWZPNOcwTpIkEpu3TdWeMin4OR09LdLyUHaHA6j8uzaM39rSgY+vq6PaWbczGh2/5MJGA739I2dbU66oiKhM3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4/YVHMjvRz3E0eSWhLEI2jfdlH3eTpZJLBmu1vydd4=;
 b=YzyUFUFLZhcDrPU+QbH2pMhWzzW45kTPZVe5Ow7HfoFfYZwpXblevrDpVWFLnGc0UaoiKfqUDwpsAqQ5OPYHEGUKoWmE2nDWIpkpvB6dpQPg2jcm6BbTPdNR71EzALjw306FdwOOTIM1iG9G/J3N6FrCNej6MCsS+53wjgudPfE=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYAPR01MB5499.jpnprd01.prod.outlook.com (2603:1096:404:8033::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:32:48 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:32:48 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: mfd: Add RZ/V2M PWC
Thread-Topic: [PATCH v3 1/2] dt-bindings: mfd: Add RZ/V2M PWC
Thread-Index: AQHZITQ/OTCDBsfXiUysXg/AmECLyq6QNl2A
Date:   Thu, 5 Jan 2023 19:32:48 +0000
Message-ID: <TYWPR01MB8775EA593651880E51C8D962C2FA9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230105183319.144366-1-fabrizio.castro.jz@renesas.com>
 <20230105183319.144366-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230105183319.144366-2-fabrizio.castro.jz@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYAPR01MB5499:EE_
x-ms-office365-filtering-correlation-id: d86d5303-163e-4967-5b79-08daef53a09c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nO8x8G72WxHjpFnBUCv6owCwbgkvifFgUxpFGBM3a7nL9rt4fJqvIHW0PyvBcfeCZVu9r4oHl+34aUiLLi68DblL20SvF5i+fqz8amMEyCaoX9QhC5HI9eoUnHlPldDvtg93k269gCZ7/UFI+EjrugkZD+xbs+Lf1bqvpzMjUpOj4/blpRrpWz+FCa8TyXY/hvU4nlX3a3MmnhCXF2ZP/6jnmWk1HpsCTrzKX+EknyY1xbp5GYnmB1IaIX2PzsZUaIZ6S92TS1aY0ofBRKzU6UCMedQwszaCjOw+abPVr6HQVsW5SLVm8HRg4LHoOMQDOZEYkNgX4GvSkh6Yfo8+5wkWR3tjEXDcqA/jVyyk2NoSILJGZpf3K36sohESAV3nzaONSUdpqLa7f59Y1VOqyBwhq6ESH0H6htuZfyXcbsYiu5Q0Gr4swT1ODMN4Tff74QovxCJtYZcjcLdmiXScS8pCYr2US/jpUyBfh6CuiDv0J89U6sDTu2jhc3HwxGrkB2/p/8m1stUSLj/UXIbw5kNxpA/0EKWpOcyjne3SDI395l+wefT3MM5QfYWs68W2Wv2ECscBi2HVbRUaQo50ZdiHWhHOan6uoPPI15y9xmxHCqqkx8Nkur1m9n9uTqIkk+nZ4DkoZzWj/d4qVrZWC0Jx3S+/arK3VFmjuTEyymY5ZlACPbI8AggkOKQ/Q3bUjVVyrf3L+GZrCj5b/YMttA9TNbmDq7jtiVs7MIHYtNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(186003)(9686003)(26005)(38100700002)(122000001)(83380400001)(55016003)(86362001)(38070700005)(66556008)(54906003)(4326008)(41300700001)(8936002)(52536014)(8676002)(66446008)(64756008)(5660300002)(7416002)(66476007)(66946007)(76116006)(316002)(966005)(478600001)(7696005)(6506007)(45080400002)(110136005)(2906002)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DCiDbVuTmYIUKvRhNXF1Z8E7dxpK7n5VvYebEreN9fWX2sYnRxhL1v88oXTD?=
 =?us-ascii?Q?6jf9CCfG/p9ocKd++NbS6br/sBfhUx+c9+cURtRzPPp7VFG+2YX9YO4fjiKN?=
 =?us-ascii?Q?QVMi22e75Bfq8KzEUqQd8vtkR8ZdgQ87lIIB30DAb/5isapn3zUTIX7fJrJ0?=
 =?us-ascii?Q?c0M3UQCy2KkuDQJgaUr9HTUvrOWzwRL/TOo9b/TNyUQGeUiYhzlKLHGQD2L0?=
 =?us-ascii?Q?MtE0ckcl3b2l31LzoMdgmLzYVGi9X0gr1C/+iKYrACWI/lUwdA0OPljBGtqJ?=
 =?us-ascii?Q?3XCZ17p00Sai6wnGaOdbKl95dViEkXGy4fPPIeg0EiefVQdO6+G2UeN9mV5H?=
 =?us-ascii?Q?DKvXIcqeql9lTy13XsUfgBbKiLyZjYwsGbLzD6bWLkUGKxpKf4RI0Yoae2/a?=
 =?us-ascii?Q?YQIC5XyErRkwDlIUZQF5T7MtQNZlxBAXg2XMYM8qeRxLs80WqJq8XCDqOhd8?=
 =?us-ascii?Q?5ucoC4InN8QwRNkrOH/fTHM5JFYzlNh0BFCj8lz6uOR/TUkGAWHCXxakHA07?=
 =?us-ascii?Q?4crmrQTQpXfJ84O5fDMkzezbzQa73ZTUjiPilZRM7BdtU9pgzQ2oTvP2rpoR?=
 =?us-ascii?Q?lPQ+yo3AQtsoGZAQCJseRHFHVhx4RwPO1i7Tlb9t/intDlTfbYYM/ewq34ON?=
 =?us-ascii?Q?NrOJ83D0ChkLiFzB78wJZ96g6ttF72uKTg2cCdlXCtqfLmRd9NsAcnpqH7S1?=
 =?us-ascii?Q?Gh9VZ/JW4gKC5zLOUIy7b90acpl3EJJ9x5113rK27BENDhRfTVC8VAfaNKYj?=
 =?us-ascii?Q?8gXLqkn7m0pnRIIr4GmOTz5TcqyCvErzuIDX+O9ZUKq3rsI2U7YIDXmJ8qmP?=
 =?us-ascii?Q?TQO3Yub2JK6mWC83ivDM1AlWFnicurdV/K+l9QgkLGPSVVEFsRyOGFn3btAl?=
 =?us-ascii?Q?IuLsra28/V0sSYppOd2YmrV5c7A/+hS7YOjcfKjm4Nqr4m9SypWSjW3F+rFc?=
 =?us-ascii?Q?4CesStKNsa3SDoOcFP/hNHK2LyBMCWWbTH1hV+YjjbJv9f6TWcNYReZSk0DE?=
 =?us-ascii?Q?eDDKfnWj/64VjYGAwEawFhwu8bIPLnz6bMsY6DWY0nLYCwhoBU4wTZ6hCULL?=
 =?us-ascii?Q?BQGSgZweHsZ95JPE0xxhQEkMipgJhmzg+aDROBN0njPcS48GYAKmmxLU6BXW?=
 =?us-ascii?Q?b9iIpwyBbN/yih1gdqXdyZGPZ4UK0ImTKTyR2q9fdWYClSzgGHdpsaGseaIe?=
 =?us-ascii?Q?5VdzjeDfBxzSIlKwMJrTKCJLDmywLk5zGVUEJ2ZDYEeyHd28W4/16ycDuaZY?=
 =?us-ascii?Q?thZXYoeZOmRHOZHu9aaFxTTzYsT1eiXdcqEe20ulowNKd9dliYBC51Ye2CIp?=
 =?us-ascii?Q?hDkdsJ+Yb8wYm63WvDliYEVEwlNtIl+L9tIV783JBej75aON1zye0XxtNnJK?=
 =?us-ascii?Q?fYLtCwumUKeHEK5ZNaMAYixWQ9D9wOV9FamyGyMjfg40pJf5OSnRSFb9vIqK?=
 =?us-ascii?Q?nuqD1PkUsMH09DjS2kL0CN4yEwxT8kv7YZUvMpJxrAW8lNeQ83KVWjwTUhhG?=
 =?us-ascii?Q?Pu453v6rfUyCbiW+hlgg69hJFO+RkpP17/s/rUhx0EFJJy+sZu1BEq5Z39vZ?=
 =?us-ascii?Q?ugIjnfTFAHs6rtsnTIabw+nl7J7PuqyB0z8sV6ZKT4fiRkuLCZKbls7Vc471?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86d5303-163e-4967-5b79-08daef53a09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:32:48.2115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvMdWtOx+ZIN/ZTsapfkFcZdhdxsGlw026yx4gjFl7q0MDG9sXNXgdc+N5X76JgsKj76NQjc5UpXU+XBuI40MwbX84eR7qa+JypsQ5jb3Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I need to move the dt-bindings document to a different location.
I'll send a v4 to fix this issue.

Thanks,
Fab

>=20
> The Renesas RZ/V2M External Power Sequence Controller (PWC)
> IP is a multi-function device, and it's capable of:
> * external power supply on/off sequence generation
> * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> * key input signals processing
> * general-purpose output pins
>=20
> Add the corresponding dt-bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>=20
> v1->v2: I have dropped syscon, simple-mfd, regmap, offset, and the child
> nodes.
> v2->v3: No change.
>=20
>  .../bindings/mfd/renesas,rzv2m-pwc.yaml       | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m-
> pwc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> new file mode 100644
> index 000000000000..e6794c5152d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tre
> e.org%2Fschemas%2Fmfd%2Frenesas%2Crzv2m-
> pwc.yaml%23&data=3D05%7C01%7Cfabrizio.castro.jz%40renesas.com%7Cfa21d14e8=
18f
> 446be6fe08daef4b611f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6380854=
0
> 4270173899%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
J
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DB0Ev3%2BkIYpOz%2FVEQR=
1Px
> JDbMvh%2BcRTZc5IrWKV742Cc%3D&reserved=3D0
> +$schema:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tre
> e.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cfabrizio.castro.jz%40renesas.com%=
7Cf
> a21d14e818f446be6fe08daef4b611f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C=
0
> %7C638085404270173899%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
i
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D1bkDZKNx%2=
F5O
> TmPFUeFIM%2Bivg0b2DVkzjFEuIBY%2F%2B2Bg%3D&reserved=3D0
> +
> +title: Renesas RZ/V2M External Power Sequence Controller (PWC)
> +
> +description: |+
> +  The PWC IP found in the RZ/V2M family of chips comes with the below
> +  capabilities
> +    - external power supply on/off sequence generation
> +    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
> +    - key input signals processing
> +    - general-purpose output pins
> +
> +maintainers:
> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a09g011-pwc # RZ/V2M
> +          - renesas,r9a09g055-pwc # RZ/V2MA
> +      - const: renesas,rzv2m-pwc
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  renesas,rzv2m-pwc-power:
> +    description: The PWC is used to control the system power supplies.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwc: pwc@a3700000 {
> +      compatible =3D "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc";
> +      reg =3D <0xa3700000 0x800>;
> +      gpio-controller;
> +      #gpio-cells =3D <2>;
> +      renesas,rzv2m-pwc-power;
> +    };
> --
> 2.34.1

