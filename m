Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCEE5EBE0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiI0JMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiI0JL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:11:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEEBB4435;
        Tue, 27 Sep 2022 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664269917; x=1695805917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9FnPcgQtTHrK9cMpe6H8Z8u8xJV6QqQHpQsdETl+9+Y=;
  b=Qgq9CH0ceU7bW9z1BcQCGpZa1TBjW7IVZTQrGolm9p+L3t2hq/gBqEbf
   RQ7Rx0jxEgdTmvnR6cKOQUzQzVrVk1bopqbtvRdImvFdxLImHUjL70Stt
   MhZvtaGC55A/cmssSCJCwkXhfLp6p5GY2BJmKsBm5plAg/xcSblLL0b8I
   W7mis4HyHztuQekH9mmlYvtn10F4vwoT7bM0yR/4ZJcpwoJ0ozHFikhYq
   xz9QgZ6QKpoZCYIOn0FluOrSG0nJ+83PJ4WLWfaHnbvLGgnhuS9raDUzs
   h59Tq7fsLI/r5f6RbUt98wwuiQK8LhmLcbpi6QY7xL3Gi8DrcbwT5GdN1
   A==;
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="179080695"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2022 02:11:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 02:11:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 27 Sep 2022 02:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvqO2VCjDhyeQMPy76aJMTGE2H+L+KlcshTOp9PdW3Lm94BmifKg5sqq+qCfQbOuRmBl5iFxMdooixjC5chUscd39Vdgi8r5TOFF+zp3AUBJeFS70H9V2Shig68nQSR3+ibPTsaMx4yfjP3LpO36SPgRFbJPKZzZgpkvqya7Raz9M4dIjEkduFIgz2/aKiCpqiGW9FQUB/If6K7JCet6j/T+XT7ZH/Yxr8yg3g1Dchq5gK3PQzeMfoZq5e0liBPGRBQqpQ1dnaSd4E1t4O3FTdTNo97GmI4JnPhwSH9c1Um8A7TzD0XC7PEpWrCpdM46phu32xoTxavX1wQzhHhktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz5DrXN3kbj2iVFe8adjy5TLDE0p7LDcjoh/N2JrQ8Y=;
 b=Ud2yKfJCLc2XMN330Sq1Pw/2lZo41vHp9HfOq+zvGt0KEvma6M6TSiPqvh87DisPIVkbXtETXAHzjGFN+QTsEN6igyfR8A88DLo1TjSt9kVt7I3+D73YOBH86as8WarTBovCcgSDcYBeUR//ItGL3RdebsmST8JcLtUGpmJp7i0doaLUEC32weoZ4SFWDj9cgrWY0dRl2NrBNh5RoEcc8JL+fTxjQDjnC6eEtlsWxVY8RNI1OTK03DB+C+dAgeZHF7SLST2Tq2wRl/fQSXZN1kgltX0VjGQrcYpXy7HEMeVg9nWQO4Av+YkBXyOEZvsEthQ9j5Mv2ul0SG/zqcr0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz5DrXN3kbj2iVFe8adjy5TLDE0p7LDcjoh/N2JrQ8Y=;
 b=teiuIb4BTahIyUzrfnCAfMUjR4JLMX4w8lgUli94q0DnXOb+3R8P8/sqfrA597wEhim1x5lHls85ycPO0vqjnwY2oxuX6QZ1F789hs2eNqQCewxG7RVtUdc37hMQt7/aUo+bg4PAJn8KEf4QOQHNzq3l0ksJbZwIx6Ve9Ei7zI0=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 09:11:47 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1622:37:9ad5:ee3b]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1622:37:9ad5:ee3b%7]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 09:11:47 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <lee@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Sergiu.Moga@microchip.com>
Subject: RE: [PATCH v9 0/3] Add support for lan966x flexcom chip-select
 configuration
Thread-Topic: [PATCH v9 0/3] Add support for lan966x flexcom chip-select
 configuration
Thread-Index: AQHYyaIWPGJNFwlu3k2cFq9XfVDvYq3zDoMA
Date:   Tue, 27 Sep 2022 09:11:47 +0000
Message-ID: <CO1PR11MB4865F20789584A034BBDDEF092559@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220916075744.1879428-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220916075744.1879428-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4865:EE_|PH7PR11MB6451:EE_
x-ms-office365-filtering-correlation-id: 90c65ec2-cabe-46c8-6dec-08daa0684e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jD5KB6GZsTMlhrRYeNX4ANikOxMlv5q3a3ma04CN/udZWnUdsSmxO3fCZOCXwM15mR6xjZGryE0bM8e1WByyQFqm5jk6zSLpBTS3QFzM0KKUkul8/jPXWYn8gRPMIjpkaDFnzp6FY3Zg/J1UhyNMcjbpiGv+iipYrba//fqxNLMYov9ANwDPaopOPSslyRRdiDF8i1A56fKqfVBCfj/TpnqJnNsYNNeibzbp5wAWpJ5HP4l/OLZa+uPH1z1Fu9wmD1wGlks4sFgTZW0bh3+gOVbHoX8IJrxnD2GP+iV0P/AqZoa/cHnBt7FwX2KuSQKecN+m1hQfLtY/rcgjvTQz1hRmUESh5A50be5aTtyhsv3AZAMSeTnv1Lf78i81gUbZDg3y7tNX6d4aOB2QK3uLHj7FEVuyvmrqDegILHvqLKcjdNcrQbjcVYhHDa00muk83K/96V63H+6dNUsuMLm0DPUkBq1YrTVoAj6m2GHkN6SkGLEP8xC89t7Iohch3ul4q/UVFif6gWo4PlMu84zkGpblZk1IaM/btHlMmomrOaHu2IrQYW1iaP+2E8G9F7HV0tnQPLkHuni1YEwgGwy9nB44b5MuhaLsoftq0fABBSiYoP74UBofmigXWY04PulKzYSLtnZMygRir5Ox4XIUjMdggK642sEhkaCg9DWP/73LU0HQcL5xI2i1e8ZNj/Y8aKN28fDIxzVt2ojeMMzr3Hxtq4e3aJ0fSI+q4bvRbPq1PRhvC7PyoZHp5eynZD+HcdnoBcj82rzLKp77X2QvHhvZ9E1XZsALTH0MUDG3WOI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(122000001)(9686003)(26005)(478600001)(2906002)(316002)(8936002)(38070700005)(54906003)(52536014)(110136005)(86362001)(4326008)(8676002)(41300700001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(107886003)(33656002)(38100700002)(7696005)(5660300002)(71200400001)(966005)(6506007)(186003)(55016003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g+8cjSeTE69gnfhN4F4Fkfi7rng0osaiMCOvm0RLDfm4bhp0/OtRMqZ/fBvB?=
 =?us-ascii?Q?WOlIwsafjsTwc++tW0ndosk1gcCRuA197n7fVf7SZanyhIRTUIOCp4dwhy2A?=
 =?us-ascii?Q?oVXqgnjXM+D+mAPOyUPZ2DlO1MAVZMS6kXncW5jtrwurne0wxlw5YPxA/CGG?=
 =?us-ascii?Q?Krvh7nSI7wxetti/Fief1eTqKpAFZJbNz0GX3RgemN23hLtxisdFvSd/dVwG?=
 =?us-ascii?Q?ak7SCVkXEOaGV5fg2H1uJmgoh4leU7fXb7nlCqFl0XLhD/cHcNguqe/mxrAO?=
 =?us-ascii?Q?TuoiroXiJm+EDDLTRHMb62T35ofG74GXJX20aGWtRR3PhB4q40uTc4MS2ggo?=
 =?us-ascii?Q?X7KRkXrhL+h5gANBhATXGexSJxURoPXn1yL6xORLNLYi2RRfJ4926ZWMZQyt?=
 =?us-ascii?Q?fjjI/t/wUEsRwC3h6UhOSzsYVInbHpfslH7fWnQ5yiYjJ6b51TGXcuGe5Brg?=
 =?us-ascii?Q?jnl1HqKBBqsu0qdYKNZZjRF4gACLXT9ZcmFW6MGHnhX4F3D+GJk0GiX7UqSO?=
 =?us-ascii?Q?o4Ay74eLXvlbJWpBweoLnzHqNkNktmV91E+2tORLVFl6elH3Ck8A7uvi7ZgE?=
 =?us-ascii?Q?a8FXJlD7fIfu/rH7chiNtyeZyPqxtlphcqb552svMy/a8NFdjtp/NMJ9KAnC?=
 =?us-ascii?Q?sGA1QlzhDAX59FM0AZYGX4sDX29LEOgvwpx5G0maZ38cmB1XB6wDI7NA3MZu?=
 =?us-ascii?Q?QBYf+9UsWLwD6+tcMLTTFCNmB9Sq1bxWOnzti73A/f/fyRZMLeuNivN+xtK3?=
 =?us-ascii?Q?qNP9ecak69tOYA5IGEViS0L3hPFP7GidfYwz9+kzSbH1VSUBMjvC9gUIsAFI?=
 =?us-ascii?Q?BN0KqnXxzmNCQMJEzbpqRwYjwkjqdB31vL/GjevUf0vt4zHdylpUWSy70mXp?=
 =?us-ascii?Q?KCUrz2AySg8iAfkYpjjUpMimYAz2vCGvyScIBm01RDbvIaL9mTP0+p2Wg7xl?=
 =?us-ascii?Q?ZC3vSlHHETsZYUxYbNv5gPCRWsq5kLM4rFmzMR7vYafiIsXNByis4F59Mbcq?=
 =?us-ascii?Q?099n/oxnLxLsg6z8KCVxJBGj57LvjSIbcCf4Bu6CiNbK89YASXQwZ+W1yj3h?=
 =?us-ascii?Q?rPvn9N8JVoDdeOOBMWzJjA1Q4kEChYuA00jo1fAPQsmwi5LB3r2jdiQDR+UU?=
 =?us-ascii?Q?VrOS9qL/AlXJhT2nr60MWMcQ9qwcqmpMpWegC9AftO+I76A1CUsaRV4zjA4g?=
 =?us-ascii?Q?NdzU8zUvrLfZXzQ+HTCPRIZRor3Krjujrmq6xcW13URlJS8OsIRDp+xbc5OT?=
 =?us-ascii?Q?OozQoDdDLReOQLLGTiVYuhlGwe2bM3954atrPUysZEPAkZdWyqnvW3Knl1Dv?=
 =?us-ascii?Q?4/a2z4tcvt2J8DPPlNVq0rNMeZlvX9AjkB6b/vqJyjGsyppA6bd6NjdnpAsw?=
 =?us-ascii?Q?KE8BBT6+aJg9EACfoaRfiRuxnzej81lVpBKlG2NdYZfFSxWXcrJo6VT9t/yI?=
 =?us-ascii?Q?h8YrsHJIqO/Ljr+W1zFasK+zwgm7HQgwr5wNs0+5L6RR3UZMoP4Y158MDs4y?=
 =?us-ascii?Q?m/lw4zbsVaB7+op1xaCdHPC7+glEC6R1QmX1pDOY1WE+LwAY6GK6q1etYS50?=
 =?us-ascii?Q?nEu5GWV0nh2RhIcpbJaQFN9hCKLYOBmrGTm2Mih+rXOeNM5pFBKDNRrzxeqq?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c65ec2-cabe-46c8-6dec-08daa0684e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:11:47.4495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h16EI9y6MoDx0x1rXLcwWb1zCAi4FK+ZfrUVkHE1MwbcFRBCNifzCS9XLWLY5Kym3XPo5jS+CX4Bo5EwH1tPFNLX9jTJ7c1bHZHUN6y4HDl8tpZiX/7Faikvt4zNRxpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6451
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch series converts atmel-flexcom bindings into json-schema format=
.
> Adds support for lan966x flexcom chip-select configurations and its
> DT bindings.
>=20
> v8 -> v9:
>  - Use full schema path for i2c bindings.
>=20
Hi Rob & Krzysztof,

Please let me know your comments on v9 patch series.

Thanks,
Kavya

> v7 -> v8:
>  - Added back patternProperties for child nodes.
>  - Changed compatible string to microchip,lan9668-flexcom.
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
>    https://patchwork.kernel.org/project/linux-arm-
> kernel/patch/20220629125804.137099-1-sergiu.moga@microchip.com/
>    Once this is accepted, I will add back spi example through new patch.
>=20
> v4 -> v5:
>  - Fix indentations of DT example.
>  - Fix dt-schema errors - removed minItems, maxItems for allOf:if:then
>    "reg" property as it is not required.
>=20
> v3 -> v4:
>  - Fix dtschema errors.
>  - Add a condition to flexcom chip-selects configuration as chip-select
>    lines are optional.
>=20
> v2 -> v3:
>  - changed IRQ flag in dt-bindings example.
>  - added reg property specific to lan66x which is missed in v2.
>  - used goto label for clk_disable in error cases.
>=20
> v1 -> v2:
>  - minor fix in title of dt-bindings.
>  - Modified new dt properties usage in atmel,flexcom.yaml.
>  - Used GENMASK and macros for maximum allowed values.
>  - Use u32 values for flexcom chipselects instead of strings.
>  - disable clock in case of errors.
>=20
> Kavyasree Kotagiri (3):
>   dt-bindings: mfd: Convert atmel-flexcom to json-schema
>   dt-bindings: mfd: atmel,sama5d2-flexcom: Add new compatible string for
>     lan966x
>   mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
>     configuration
>=20
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 155 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -------
>  drivers/mfd/atmel-flexcom.c                   |  94 ++++++++++-
>  3 files changed, 248 insertions(+), 64 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> flexcom.txt
>=20
> --
> 2.25.1

