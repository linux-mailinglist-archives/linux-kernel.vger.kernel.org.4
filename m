Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFCA5BC27F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiISF1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiISF1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:27:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C759FD30;
        Sun, 18 Sep 2022 22:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663565235; x=1695101235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t5ci4GcddYy6dspitAIhJY6ECPmGK+TtTYexIRMJN58=;
  b=JYVWE0JLVBBmB/qe6rYqrLyRrfDoaFbNKRgHkMd0VdnZLtdPr5aFFZia
   4191VDbmW1HmjhDVyZVSRjhfU6gFQAqGEB0o6pAz07oXT2VfVE+G4l9C0
   wswNeDOGNaE8HVGlqbkBt4rnrpDQprSg0s5r1QBmVMy5C/VrcOXnRyNuG
   gj3fDAMatk+7YMWl7XyRl6aXvPk1qTy1KUZvfYLR14851TTTqY6D6IBSY
   ef8HA6i7AV4xFFg++ukqwQNLCKbh/0L+uTTuqU+eJSjWX7JG5Kj5aYarS
   scC3/oWLOaD4d5/s+MX4yp0l+zhquZiXICMwAg5xpV8hm/9Om+9GzUkCd
   A==;
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="177769484"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Sep 2022 22:27:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 18 Sep 2022 22:27:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 18 Sep 2022 22:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og4PmSPdU00JZSPT/eQsLKLyEXpmSIEL/9N+IYpKk0sz9O/6ahkH7tej/HXGBbOKLofYjuBxYUy5X+d+u37anovXs/ivSDylBRCwIn5h6G6FybqfJEzBfJFCnBx1uE83npouvoaEe2Z2KWfwaiuC1+n5YfNapHKEkSrKiKX4wgGeCipMg6pyxHUml94JypzqGCS7O+r2pxjr7b2Ol/h6x4jH6ARSgzWJFirSUgIsLtyGwpOziSYfnKCaYp5ohb69yv8jxfVImaK8MYifVNEew8rN6TAGgQgCtFX9/fUPO1w1MsDo82USObz12+YD4YEGqDSi7XNSadKNvbkSn+sY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwMQeRio8n2OSPMfd6Zz1Xj7x8xtpfMoI6vHvdxfXzw=;
 b=ntxhkyfuJfjKg6FYPwk7CZlJie8SBeKSZ+FijJUUj+jXTL5gh+coxi2jAncuqQMMBs5ESIWj+u40AwP/JGHXAL88MLQUwrLWoCJABGlg9LvDWv/CiJbPMCjXkJape/ARqy0+oQ8BS9RxvBxvGp7IyzT10F1iZoO4F3gbs4ruHDY3sVWJCAXP+hlfcIFqnEzXCnRe6NsF9QTyKHnO2JOjjWTb8oEU84oqFRbKASbL/hJMY9PcUWgoNHnDwfSMoqeCv6R7L7CFSiw04tMuu3/MI4elpcl0dtqU/k7Wg4GFxG5Ca/t/4J9PkF1jS2yN/vJ0sggE7TMGHY0pbDBW1Eadrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwMQeRio8n2OSPMfd6Zz1Xj7x8xtpfMoI6vHvdxfXzw=;
 b=IAd8dJEsv1lD7TgpMWhVfKFulVNsFF9+tXG5eahfnVLE/pKvA09umNQrklIo9T0vsYQHFP2anemvyRD/Fdz8HFYdcRa2r0261HmtIFqMOnWjAwkMD6akTlVeGIIsY9DZkpLZ3Ro/GNvzSaSYqyN1r8U3qgfh5OQoEKRJChzGz6o=
Received: from PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18)
 by SJ0PR11MB5086.namprd11.prod.outlook.com (2603:10b6:a03:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 05:27:08 +0000
Received: from PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::3782:ca8d:1fc0:d1c8]) by PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::3782:ca8d:1fc0:d1c8%3]) with mapi id 15.20.5632.017; Mon, 19 Sep 2022
 05:27:08 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <lee@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Sergiu.Moga@microchip.com>, <robh@kernel.org>
Subject: RE: [PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Topic: [PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Index: AQHYyaIeVUwkv8i5FkKvir4kOM7/yK3mPQXw
Date:   Mon, 19 Sep 2022 05:27:07 +0000
Message-ID: <PH0PR11MB48728124A13E40C1E5F4198F924D9@PH0PR11MB4872.namprd11.prod.outlook.com>
References: <20220916075744.1879428-1-kavyasree.kotagiri@microchip.com>
 <20220916075744.1879428-2-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220916075744.1879428-2-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4872:EE_|SJ0PR11MB5086:EE_
x-ms-office365-filtering-correlation-id: e9f92dff-9b17-4cc3-f1de-08da99ff986c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mAWecaLVwGyWeb+6IVFB2rNlxHHO8TlFvB/QlkZzL294zf+z3LKvp7lzA8Oyk3t0jKTxjCwZz22D/w847uOr1cfa8OaC0cDsnEpHquchGjAzNReesyg0pEtr5qb9tcJVMk36rAaCxhAPMjkFvTmSSB6INIaOaHa0/X9Q9XC6PUxMexfDhCdU3wZKCcqPsRggtVp6DTgYv3TdIJEC/g4ZtKcE7eRx4q4sn+jnuZSNMGT42DkKoafX4qUJN/+EyNu+04/kJ0Y0QJPNXlxg51nUepohk/wVsaWjhDyKO7Fvt9aX4A77+vOWA9sOAkLycIR9QaNv4ld9mfrSIJRkER/N1FCZU8BxPrBsjsaAIxHLQyA1aaLfhfhbfnCuWrFv1OA+upozh26nR6/ufbNjS8P1yNR60h29ESW4yRfhCnzQ0kn4ymhwvtUgnKh/ZRNKtFJi7cxi2j40ZA4LtKch+LPMKU2qVnNtpc3/3P6bqWmv8hAKG20xsKbEXgMkJXgMVdDfbjyGuYHgySU2AAQz7b2Gyw1KHOGotg66hvW14rx92xQZsncC9JgIfQJaV6W/wmzN8kYt2E0NKp8m/rlF6nfRoSQRaVZaGiIO9sN44gHPY/jn7lmgp4GkjWhYLbbQ2ZzqiKyCPfmT03eUqjp7nJvpg3De/mF5H40FnES6YyKnTe2YBoGO4Q5fbg301LzIfIG8+5CWBATVe1/qKEpYcsmA/eblpgboSzGZ2HYZ8bVf9OssdGqXIM5tF8FbnHbOmYdVlQm8QzLn5/owwIyvNEPKL9S2S6IeZMEPlYuMQobb8NSivZ/8FBv6REkkbi6+N9na2kOUQDsnZzzD+pWvIQ6hGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(9686003)(38100700002)(26005)(122000001)(55016003)(6506007)(33656002)(8676002)(76116006)(4326008)(2906002)(966005)(41300700001)(38070700005)(7696005)(71200400001)(86362001)(186003)(5660300002)(478600001)(8936002)(66446008)(110136005)(316002)(54906003)(66556008)(66476007)(66946007)(64756008)(83380400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DLgDWSs7fxEvcjv2SiljTvXVum19L5f/E56SFCHrHxe38/a3UMo6pe3Fla+B?=
 =?us-ascii?Q?kRZEC9iyN4I1pSj5wv82D0Dpo+1YzawEPrqYEEHM0984srp+wdABMo1ZryO4?=
 =?us-ascii?Q?aZYjcFyjqvH5QQYJse9EXgalaAF2R+/aaMG8ted7O3mD+3rmYeHhRWCNg/1g?=
 =?us-ascii?Q?xBL7bnATJeDyYeMJHAiOKsTfi8W+XQeZityJVafJo4IWxGxjQmMmyNU+gRhp?=
 =?us-ascii?Q?3afFUnS+mtAHTen/XuLj5HMsJ5e0tlZOriVPKJFhg7GT8B8K1vPSOBMM5MzN?=
 =?us-ascii?Q?Eoo1mfnzKY9cMEFy6A/AvmEPfN9UuYonY0m0b7/g85CMvidePPcH8DLkwIKI?=
 =?us-ascii?Q?ctj6/a0tnRZkUS+g+bASptYG0uFWcIWdSMTPP+5+Jzryf5V6wBJbMpItXv86?=
 =?us-ascii?Q?xy1aGwT9ugia166Y/nTclnI8r6tpRo1FSnDK3FnB+BlhKwEcmNzUSVdKzojx?=
 =?us-ascii?Q?1qnN8rRUBq7FJhpR5kR/f7Sc5matFDcMVO+QfxMCztkQx+wf+E7lExptzZw5?=
 =?us-ascii?Q?xrciVDzvH5WR5H8PxM1EPaL9n/LnjdTJVnMpCuWuNTzYZQuAnAtkCxVGdp+P?=
 =?us-ascii?Q?ZSt396AsjmzVm/zVIlqpRZIlUOIgRlc5VGeV9qqlEISEVMDYhwsM9LPOpPNi?=
 =?us-ascii?Q?4JWpLw5cw+7kJCyd/Uld9QMpeHW/YSS5bEKH8/txHHjB6b8Sz2lnskD4rxce?=
 =?us-ascii?Q?5PgBrrxDQQZLVirZgu/sLoBfJiIcM4xOMkYnZzWIpih60BbQhEBqVYxy712m?=
 =?us-ascii?Q?2w8B0uTehdHhEotz7mL5pDEW294SpoddThMlhuJDTOU8OTU1tXdjlh2J05DU?=
 =?us-ascii?Q?09RFukfv6BnEnulL71PEBbt+OHz8olFTHKo+9G2enpWoNCmmQ26lqrYJm5b0?=
 =?us-ascii?Q?YGRpIibLhpfRDwNOheHHJSmMOvWcsnK6EQql7id/cYNdphcMRj+9xxnK/06L?=
 =?us-ascii?Q?Hk9avumNkttQ6rfskGksaV5GDP2/Fop/4K+u/ahGjm9tupkTVaoCtlhCJZ3M?=
 =?us-ascii?Q?Z0V/Spo8wHtCIu+7UyEukEf+NDIJwS4cKfG9QHCZxERj5XSy7JI1WKl1ce0a?=
 =?us-ascii?Q?Qad1r5GerDryFoJKF4m4UqXcjuJsiaOpucyFJaXt7r7htIcAseR2yArnbpyw?=
 =?us-ascii?Q?rwy01BLDb1Y3l3zPh4bKq6F10NZDmcf4PtmC6tC5Hq/9bJkypXp5CTuj4CEg?=
 =?us-ascii?Q?2sM85pR6eSn8Q21Ns7xpktFuYE28GHeU8eBOoc1LKgsL2VbPuSBMP1bikkIt?=
 =?us-ascii?Q?SJVt/eUeY8894K/rnJ9WVJRaO96+E9V4meAI1/5B705RaTX86SKCR88gJ7TS?=
 =?us-ascii?Q?lC/LPAO/fJKyWBXnC7xR/Atxu7ToxzwCyQ8Dg66RPEnyVtYSxze5N3ZiORoe?=
 =?us-ascii?Q?r0cdwAPjGu282BVDqnAnQS8UmcjTq6S9b8Nnop7Ma/tFP/QTgMuajot/fKTn?=
 =?us-ascii?Q?e67touEceLR7SVCig9HEoW93alX+tsI4hV9RoyMo3SSVTE843GCDNv5Qbb52?=
 =?us-ascii?Q?eep8Kz3O8p6pJ3GmYmsPSzcGtvBhB3/X43hkEg+sWPXlezSVLSW14AGbwt9V?=
 =?us-ascii?Q?WOjYd1QxGsuy/5I9R1vBNCXoGq+9gGXzPvlZJAMeXb3aiQQgL6WShXFxEDv8?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f92dff-9b17-4cc3-f1de-08da99ff986c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 05:27:07.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 643RJ4RcxDRk6Y0kqNwClXNsGDTDINRUU3VBF5h6ugvj5zNnJBGPMnaEu6ESn+6jPkvl2bYNTDx3m9VZMSW+e6K8u0KIAsYj08sd1s6slcWHyKQzKVzF/d0k24Dt/WHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5086
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Convert the Atmel flexcom device tree bindings to json schema.
>=20
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v8 -> v9:
>  - Use full schema path for i2c bindings.
>=20
> Changing reference to SPI yaml bindings is covered in below patch series:
> https://lore.kernel.org/linux-arm-kernel/20220913142205.162399-6-
> sergiu.moga@microchip.com/
> https://lore.kernel.org/linux-arm-kernel/dad37ca0-a44b-59ec-0be9-
> fb121de12244@linaro.org/
>=20
> v7 -> v8:
>  - Added back patternProperties for child nodes.
>=20
> v6 -> v7:
>  - Change filename to atmel,sama5d2-flexcom.yaml
>  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
>=20
> v5 -> v6:
>  - Removed spi node from example as suggested by Rob and
>    also pattern properties(spi dt-bindings conversion to yaml patch is un=
der
> review).
>    Once that is accepted, I will add back spi example through new patch.
>=20
> v4 -> v5:
>  - Fixed indentations.
>=20
> v3 -> v4:
>  - Corrected format of enum used for compatible string.
>=20
> v2 -> v3:
>  - used enum for compatible string.
>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>  - fixed dtschema errors.
>=20
> v1 -> v2:
>  - Fix title.
>=20
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 92 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -------------
>  2 files changed, 92 insertions(+), 63 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> flexcom.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
> flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
> flexcom.yaml
> new file mode 100644
> index 000000000000..f28522cd987a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
> flexcom.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Flexcom (Flexible Serial Communication Unit)
> +
> +maintainers:
> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> +
> +description:
> +  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
> +  an I2C controller and an USART. Only one function can be used at a
> +  time and is chosen at boot time according to the device tree.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,sama5d2-flexcom
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description:
> +      One range for the full I/O register region. (including USART,
> +      TWI and SPI registers).
> +    items:
> +      maxItems: 3
> +
> +  atmel,flexcom-mode:
> +    description: |
> +      Specifies the flexcom mode as follows:
> +      1: USART
> +      2: SPI
> +      3: I2C.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]
> +
> +patternProperties:
> +  "^serial@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Child node describing USART. See atmel-usart.txt for details
> +      of USART bindings.
> +
> +  "^spi@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Child node describing SPI. See ../spi/spi_atmel.txt for details
> +      of SPI bindings.
> +
> +  "^i2c@[0-9a-f]+$":
> +    $ref: /schemas/i2c/atmel,at91sam-i2c.yaml


Hi Krzysztof,

I added full schema path for i2c bindings in v9. Please let me know your co=
mments.

Thanks,
Kavya

> +    description:
> +      Child node describing I2C.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - atmel,flexcom-mode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    flx0: flexcom@f8034000 {
> +        compatible =3D "atmel,sama5d2-flexcom";
> +        reg =3D <0xf8034000 0x200>;
> +        clocks =3D <&flx0_clk>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        ranges =3D <0x0 0xf8034000 0x800>;
> +        atmel,flexcom-mode =3D <2>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> deleted file mode 100644
> index 9d837535637b..000000000000
> --- a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -* Device tree bindings for Atmel Flexcom (Flexible Serial Communication
> Unit)
> -
> -The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2=
C
> -controller and an USART. Only one function can be used at a time and is
> chosen
> -at boot time according to the device tree.
> -
> -Required properties:
> -- compatible:		Should be "atmel,sama5d2-flexcom"
> -- reg:			Should be the offset/length value for Flexcom
> dedicated
> -			I/O registers (without USART, TWI or SPI registers).
> -- clocks:		Should be the Flexcom peripheral clock from PMC.
> -- #address-cells:	Should be <1>
> -- #size-cells:		Should be <1>
> -- ranges:		Should be one range for the full I/O register region
> -			(including USART, TWI and SPI registers).
> -- atmel,flexcom-mode:	Should be one of the following values:
> -			- <1> for USART
> -			- <2> for SPI
> -			- <3> for I2C
> -
> -Required child:
> -A single available child device of type matching the "atmel,flexcom-mode=
"
> -property.
> -
> -The phandle provided by the clocks property of the child is the same as =
one
> for
> -the Flexcom parent.
> -
> -For other properties, please refer to the documentations of the respecti=
ve
> -device:
> -- ../serial/atmel-usart.txt
> -- ../spi/spi_atmel.txt
> -- ../i2c/i2c-at91.txt
> -
> -Example:
> -
> -flexcom@f8034000 {
> -	compatible =3D "atmel,sama5d2-flexcom";
> -	reg =3D <0xf8034000 0x200>;
> -	clocks =3D <&flx0_clk>;
> -	#address-cells =3D <1>;
> -	#size-cells =3D <1>;
> -	ranges =3D <0x0 0xf8034000 0x800>;
> -	atmel,flexcom-mode =3D <2>;
> -
> -	spi@400 {
> -		compatible =3D "atmel,at91rm9200-spi";
> -		reg =3D <0x400 0x200>;
> -		interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pinctrl_flx0_default>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clocks =3D <&flx0_clk>;
> -		clock-names =3D "spi_clk";
> -		atmel,fifo-size =3D <32>;
> -
> -		flash@0 {
> -			compatible =3D "atmel,at25f512b";
> -			reg =3D <0>;
> -			spi-max-frequency =3D <20000000>;
> -		};
> -	};
> -};
> --
> 2.25.1

