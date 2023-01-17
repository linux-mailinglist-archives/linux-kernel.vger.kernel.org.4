Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51AA66DB32
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjAQKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbjAQKax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:30:53 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2102.outbound.protection.outlook.com [40.107.114.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F41693ED;
        Tue, 17 Jan 2023 02:30:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V50otIc4eKvsoU6TJRbDoXXfOxH6wVBQdTC/24NvB7E+LESchHsdLTWBAq98NcUBmH8BZ/Sg8YtvlHcrP9AmIaWd154ZdntyB3MnNLeyXqGj/ZyW05/64JoFJ+Ws7IRzl3gr//CQAK8hp662tl0qh7YGycyZT2O1QudqffQrC2XySxbEa9kF9lNKn+ue2zYjVL7aXnOkJOjfKJErbDd7CMU6jKyXGG0VpoYPROgdsUItsUwO2IJIfAKu7GyTxcUF//FQY/EulMR9xMlW+RPEw8PUBZ6ujAyiLqxxkLfmo9ui9ezlA8YCdCt23R9ncHWrHg/+EHRVPVzzxYjCT145Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSzeI/5j1cBLghzz/PGYVtlAeUzT52iZSx4WFUyv5cg=;
 b=FS53EOIk1JKMajBjNWjcekXBAxVOUQzJzp147hPOvpkolqeUuB95xC4llf/1otNx9FiHATKCKuWyVhUo+nJB1pJV3ArL2KDWJHIZ1bJaNwE6ei54PcwHXWmXwRqJazV+SDZ4rr0NZzxRhi/tGtM4lCIvTi+/PW6QyBdkIk0GKtxkUipqlgDbFG960GHPhUTWyRdWV5/QWVs/p5PlMK5litiWQKVTJ10llk+aj5favnODCyHf2CiPSQa44oTuIb8NP/JbB4pP/DdtYH6zQHkpXYff7RYzqWodm9h9SsahsGaSjAUccdEmbuRR0iZsw0au171PEaH5pPOnPE2bFqDPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSzeI/5j1cBLghzz/PGYVtlAeUzT52iZSx4WFUyv5cg=;
 b=HbjSdZ0SCPJjnG/Fv0XI191J0cjoHJYwQ/CByAqhg0Nu2t0gn2EeGlYp8sw/NBIEZTyyPIpNIorlCnxw1/v0YGQBau6HCEP7ghcVBoWwH8MeikcNgkBBryHzuoOVDVjGtmnEjkipch2hDvW2VThXVpL/Xo8wgV5aJ56wjMlBbLs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8344.jpnprd01.prod.outlook.com (2603:1096:400:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 10:30:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 10:30:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp: Document
 RZ/{G2L,V2L} FCPVD bindings
Thread-Topic: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp: Document
 RZ/{G2L,V2L} FCPVD bindings
Thread-Index: AQHY/qlxicYftSpeMUKKL0vGYRE9G66iv0cg
Date:   Tue, 17 Jan 2023 10:30:44 +0000
Message-ID: <OS0PR01MB5922D9004BC2A00BF1CCA0E186C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221122193415.1873179-1-biju.das.jz@bp.renesas.com>
 <20221122193415.1873179-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221122193415.1873179-2-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8344:EE_
x-ms-office365-filtering-correlation-id: 860bd38b-3699-49ab-f810-08daf875e42f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvumeOFSV7iolQ/U9AN0eguK2CDmIIlnNtHsiG3lQjZ85vQXgrAI9jiUxxvwIxQTyff5uiVNJLZ3kZL6XDSWTjoPfjjrE0oKPwwzXnLntSK7wQcdrAuWCK6zT8zG1mmabFfHo3CqkjUNX41xbIkLjThk2ULuAhCSdor+b0PdDepwYmAeZ8eGuitnk0/je0eTqos5Wgrwh+ToqUr971zYks8uoMW/6TgK01eoME2EJfptJGIbyKdPfJ3Sqdgg1ynrwt5IdRKiEFxYzizt9X4Jmrm6Tc8tmtTsjeWziv3m0yXAxRcXtyg4pA2FSNxyb0RMF5UzQQftKpXANEVW493FSJye2dC4OO/H4E42uDOeUg+/0I/XiH3x7QQFHK2zgk5HAAv/V1V4goBXXnwqUV6M6y+iRf2gcDF126a3YhaKbTO6nZsx/j0H48XJhy7D6b0dTFN1wEC7d5A90UnpgyoMoZvvz0ybz/0OfBEYa3LPsUmGSdLsks5KbnTF4wdNp4kLVAg0Go7nsUY5ovUHlBYisPS5wpbr/ta8w6/4Y9qlEtwpRjbvr5Zdp2SMM4RyM1nRDPMTyDafv41hWZ201/knVlJV1+3+OPnDBKn7uJ7WCUAtEGLV13mYVbsYLL7PDEhihEMIkiV1sERsTsMluQgmjF75jlpHd0ZSZDcVcuQeIHti4Vpbka7TTtVOIt8QaYRuWVNu19v9d+mIlsGpV3it3Fu1WaizHaEtMP/gGV2G6Fs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(38100700002)(38070700005)(33656002)(55016003)(86362001)(966005)(8676002)(9686003)(64756008)(66476007)(26005)(4326008)(66446008)(186003)(66556008)(110136005)(478600001)(76116006)(7696005)(66946007)(54906003)(71200400001)(316002)(53546011)(122000001)(6506007)(8936002)(41300700001)(52536014)(2906002)(83380400001)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?71JsAcDhx9oa4APE9NdeudvklJAovP1YUs7QSIfxEMZEF1SS9Tsb7CYS+5I6?=
 =?us-ascii?Q?4Ot40qkxdq1ceGcMwEy2OupACZnanD3LcP1qgiMk8jzsO7cjB58CMCwnIyab?=
 =?us-ascii?Q?CB/e14aYCC6Ai2nZECjeTfEeuuZowZo+YpBDwIO7wdcEJUaZO34W7MpuZ+ig?=
 =?us-ascii?Q?cpaoS3rMr3yms/n+kdVq71oUO4TdUIJ73x7pqc6NgOTdOai9IidgmJsxIJqv?=
 =?us-ascii?Q?HtfEVvs+nzhtd4ZZk1gpnXp7M2Wrsb/fFkirWyi6SzBiwTBmQliEOef3bOQ0?=
 =?us-ascii?Q?RjTaBd5cjXeM4aOoszDn+iw6u3Sqn/ObZ4rnDxouQdvUZSoZZOOEs64b6DYC?=
 =?us-ascii?Q?7DyvB0Zk4vsc+iW0pHAw9/yRwFVtBvXOv6L8GbJB1b9iaQsR0H5yYKE9H9tq?=
 =?us-ascii?Q?nAaAr7IFc2LUiiMALM1KQedFjevS1PlVGxubdfLACRhq6Msht5vq+rhKgYdF?=
 =?us-ascii?Q?qvWOTQyn9I/VFFuFIwyxjuUtrq5wNN5AzZQi10/O6yC2EJWp8dzqO4urmBh2?=
 =?us-ascii?Q?MrQjfPlDjVhkYYG6zFXC25m1f5jykb/RYgCLhOGTUwBPlGACi/UOiWLlEaN4?=
 =?us-ascii?Q?Cd/zFrSKuSNBiaBSOHWOIFijpDesZZRYP+mz2QwxvZBIQeXttSEf5/XJTbWY?=
 =?us-ascii?Q?JujZwbA4M8KbSJtGEirkibFGcxWvavQNLL1Ej97fctJgpqLyqrH7gisers2K?=
 =?us-ascii?Q?38B4rqNWgjicp3d7nznF/kOTaDN7Jy/j87hUJEHhxuZwvt6MVaLQLAm87uPr?=
 =?us-ascii?Q?tQ45kGxSZ1FHOAoHb2tggEmjfHUkwWPux4Bg3PUOo5JfeptTFH1XukwB/ki+?=
 =?us-ascii?Q?3oDmVL2z21Nh+RUI2e3oT1dJ+32GxsBjghgmRd6KHxwzYjPSpLCIeXr1W18b?=
 =?us-ascii?Q?vTbLyWOeVKtaPVeNaidN4YDhmHf6OOhR30itphq4sLE0zkTyT6ehHW+vKMDo?=
 =?us-ascii?Q?MUrAe2dMmziB+OJSc8xgKD3RGE7fGB7qnVabpXKSYTKE7g9ffCeKGWGX7Sqq?=
 =?us-ascii?Q?xiu/a4khHem518NbiIivoZxO8+KzTGTXOrjD1o9D5r/bm+mpQuuFykCkIe4G?=
 =?us-ascii?Q?HSLR4JXqT5qGC5CoLa5P0FDTADs9ql+MoVNMh3IcPSYNdGmDnJPmSB6o70Y4?=
 =?us-ascii?Q?k9I/lWgMQtOD+SBdVLxPDgVB1jwZxOo5kh+BfGmxk2paEYs9fS1+PdBf/MI9?=
 =?us-ascii?Q?Uq3+BKWQWhYhncvwzhCQmZFvfb0pRh+h7fMkN5YHTViChH/43H/6s8XvRmcL?=
 =?us-ascii?Q?p0ipAko/4xVy5s1KSHVPS0GZMXy8SCf2zsq1fbXsbp06KCPESWH6xQOSlih+?=
 =?us-ascii?Q?Lu2FP32mTMjg4c/oOlgRbXwjVuXHUlRCYqnz04UYEqlEpeM0TvR8X48u9kaW?=
 =?us-ascii?Q?ORRaglXx045mfCaPDzRyA9BjLPCoUM+11cMiWuISFcJSEu5uvy5TRuy8CQm5?=
 =?us-ascii?Q?Jpke9tVZi2B0hICxyaN8D3sDdwqzlpSx4/FjGDbQzc/P8CpHtpP3QuEISAm8?=
 =?us-ascii?Q?59FoPsu84qz8kLIg5bikvz3m0brLrWS4M8sWRcyuLvBdvR8n1xi0WANQ3TFz?=
 =?us-ascii?Q?QT99iOcH/0AjWt0GFv6YPxwRE0SRNIAwccCGjrqeqt1/Pzjj6rhC60sp63IX?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860bd38b-3699-49ab-f810-08daf875e42f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 10:30:44.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1lRHT8YbfHKyRT8NsN9vxhfx29gYfTuJzfys5nz4nXYMx9NDgLmyX+zpLlKfMI8aIo498OZa1OZDeeBtUyeWUhr2kOcgqgh6XVutBV5WHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8344
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Gentle ping.

This patch is reviewed by Rob.

It is blocking for accepting SoC dtsi patches[1] through renesas-soc tree=20

1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221122193=
415.1873179-2-biju.das.jz@bp.renesas.com/

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 22 November 2022 19:34
> To: Mauro Carvalho Chehab <mchehab@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; linux-media@vger.kernel.org; linux-
> renesas-soc@vger.kernel.org; devicetree@vger.kernel.org; Geert Uytterhoev=
en
> <geert+renesas@glider.be>; Fabrizio Castro <fabrizio.castro.jz@renesas.co=
m>;
> Rob Herring <robh@kernel.org>
> Subject: [PATCH v4 2/2] media: dt-bindings: media: renesas,fcp: Document
> RZ/{G2L,V2L} FCPVD bindings
>=20
> Document FCPVD found in RZ/G2L alike SoCs. FCPVD block is similar to FCP =
for
> VSP found on R-Car SoC's . It has 3 clocks compared to 1 clock on fcpv.
> Introduce new compatibles renesas,r9a07g044-fcpvd for RZ/G2{L,LC} and
> renesas,r9a07g054-fcpvd for RZ/V2L to handle this difference.
>=20
> The 3 clocks are shared between du, vspd and fcpvd. No driver changes are
> required as generic compatible string "renesas,fcpv" will be used as a
> fallback.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v3->v4:
>  * Added Rb tag from Rob.
> v2->v3:
>  * Updated the compatibles by replacing items->enum as
>    it is just one item.
> v1->v2:
>  * Documented RZ/{G2,V2}L FCPVD bindings
>  * Introduces new compatibles renesas,r9a07g0{44,54}-fcpvd
>  * Added clock-names property
>  * described clocks.
> ---
>  .../bindings/media/renesas,fcp.yaml           | 45 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> index 43f2fed8cd33..c6abe719881b 100644
> --- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> +++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> @@ -21,15 +21,22 @@ description: |
>=20
>  properties:
>    compatible:
> -    enum:
> -      - renesas,fcpv # FCP for VSP
> -      - renesas,fcpf # FCP for FDP
> +    oneOf:
> +      - enum:
> +          - renesas,fcpv # FCP for VSP
> +          - renesas,fcpf # FCP for FDP
> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-fcpvd # RZ/G2{L,LC}
> +              - renesas,r9a07g054-fcpvd # RZ/V2L
> +          - const: renesas,fcpv         # Generic FCP for VSP fallback
>=20
>    reg:
>      maxItems: 1
>=20
> -  clocks:
> -    maxItems: 1
> +  clocks: true
> +
> +  clock-names: true
>=20
>    iommus:
>      maxItems: 1
> @@ -49,6 +56,34 @@ required:
>=20
>  additionalProperties: false
>=20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a07g044-fcpvd
> +              - renesas,r9a07g054-fcpvd
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Main clock
> +            - description: Register access clock
> +            - description: Video clock
> +        clock-names:
> +          items:
> +            - const: aclk
> +            - const: pclk
> +            - const: vclk
> +      required:
> +        - clock-names
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names: false
> +
>  examples:
>    # R8A7795 (R-Car H3) FCP for VSP-D1
>    - |
> --
> 2.25.1

