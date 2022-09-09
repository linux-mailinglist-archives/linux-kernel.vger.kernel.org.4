Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55415B2E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiIIGSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiIIGSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:18:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED54804AD;
        Thu,  8 Sep 2022 23:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662704296; x=1694240296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2P1MqUe1Ad4YuN4EK16MflkSP1SVGjMGVp56HxDYy9c=;
  b=Mx1C5KVZIgfpeLOvtUK8LDDCPXd2soxxBKkE1YsyISGHvxtcSWjCrdcz
   JLjtF/nmOh/38tPfmbhcNYe81R3q3ejHcQwFKD6SKYugi5pI5ahCqWZN+
   1PChB8FwrHdZr69xFPg8qqqE5Vs/AS2ULYKK/7eQY34faxzK2q3yds4U2
   GxIebo1e17AQe0DjsTYZA8B+XAJ9KQ+RuowOmN24jJDLTCZWvVgu+svBq
   SgunnHnLMTlTT/hY+Z83fPlDb98lEcYzk2bjaILU8cFxS5wQt5SR4FTrS
   yIEdmgp6TKpRNDFngBo3jbo1T/XsqnoAousVOqSvo9IlVYEAqklUGXdOG
   g==;
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="112887400"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 23:18:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 23:18:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 23:18:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOVd5lLO/Mm3pt1F7nK5Y9rM+1XrAseNfwSRrzwMT0atgO4rY4ew8oSvndAIjdjCcExvMt0LxdMML3TzBMSBt0Er5+YogI0AFf1Ri83DUffv4N6lZ1r45Yilv89vKGhjWM7Pi8+/n78sUY9fncvKe1LS3gVE11s0x8bJye/aYPr84UKH+UrE6AcxQAJKwplkzJqMBMnjcz6Oi37piJVgI1boC+Jakeyghd14xWINcQj0Z6mscd3NaLJJtoR2JkWGoFNQUUpnUhAZXTwvRcpoetsJzNu0VZ43B0/v4wfjqH8RZMT+woLyAoFv48YNQiYfBlezEAYs1LZE1Vq0lKrEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oTEAZO7k5wUPiubpTLWTrhEBWGYxvLultNPd7R2Kfc=;
 b=HB6aifr/dLjakHZvz1/c331jnpMXVf0NxJXYwE+RWQoq2hiaUlfFVwoatYK/1chwLFvXStZarQPGHnK7BTvnKfMcCteVL6cyzTmzKOL0oqmO0YxWt0fvqz2czDAwYOjVvPLXxjDHZA4U+Gm3kT57TZIRHa2u6eAaN7K+UTvsrOiaRGu3erxLGCmSkjVBukQAmVeqDiMvtYq2rXL7Or3XkE/BATA+IyizBMkmfyhSwTFpmhL8d+a8DS9IlzVtXwN4p+UFbU4FOCL4Ab+hJ2GtecAz2w7BNOoAp1V2D+AxVjLgtvVmMMFY2KWBVg/IWXTtIAS1I5mlOmBCNILE5TDlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oTEAZO7k5wUPiubpTLWTrhEBWGYxvLultNPd7R2Kfc=;
 b=jKYDyGzV3+KcC341xzb/rB4nxdt/2mDBlX+ORxgF5Cceo+n6DlUYf55jHMwKRFqJIZApt32vv/AIN82tpX8QsENmpKfP1bQ8qHYO3rj6dF8SnAlYTh3j82pstvKMt8HeGldWUF9UP2CIHfnaulIF/2pT7z/vj6WWMn+oTm9CK7c=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL1PR11MB5542.namprd11.prod.outlook.com (2603:10b6:208:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 06:18:06 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6982:4db0:989c:c097]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6982:4db0:989c:c097%9]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 06:18:06 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <robh@kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>, <Sergiu.Moga@microchip.com>
Subject: RE: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Topic: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Index: AQHYw5S351ZiP2+bvEqYZuXgNIsbDK3WCUwAgACWniA=
Date:   Fri, 9 Sep 2022 06:18:06 +0000
Message-ID: <SA2PR11MB48742AF8A0C9BC6D32D57A2892439@SA2PR11MB4874.namprd11.prod.outlook.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
 <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
In-Reply-To: <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4874:EE_|BL1PR11MB5542:EE_
x-ms-office365-filtering-correlation-id: 4ac8872e-ff56-493c-32dd-08da922b0f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mk3gsJ65lPrZdbZ2dhInox0tDUN/a5SROGPdVZq5/cRVm4uptS+s23G42IwMqW9M79CAOXCJGB70XLtbDrrm18/FZ/yvvl9Vij3lT5uZG6ZEIrGcJrFHLiDCiFoU9KlHK04hMupWb4H+QhJbl/TiPOtLmpqPWBOvbncR5nToc6qhhAUFVeVoAj20g0/3Reyg7Bs61hielZ9aQ4IQs8mCKDys72Rkw/vgeBp6b3qdwp6AWHdCwM2LfIEzEhX2k6Fg38liHyPsN5qKcJMBxtWR+eXTRu16yz05drz5ryKm8Z5QWj5PDAzqK8Q89QCd3aeIOnNkl51hNwJxu3Umqe4BoTMRZRKSOmO7efXe0T8srQq/ZcDZIHPDVYilpU3ezbTa/JH/6rmcAz7+abquJRkGotBu+AwP7LD1vfP7zBvxicxYkVnTmPMpgb3zj7z4HBYrSAaWhwEFeepbdg1X/5pHG8P3o3DArR3liQ37+4uT3FkE1niBqXIAVQ2JnJKbplK2hqCPsCv2a5Ks4K3bVyG30UqE49l59CXLJqii1pR3BXbp9hf/QTYK35l+qPRGvXq7DgNaiFbOhpHTufbo9w5pokLwzuVIuZvVsJEnEQIsJuEpMqDiA3rVrorbp1+UTiQELeI1YEW9UEW5FHzKjaE/ILN1RPY+twzD/2NljFuTHcPdBtWedh0uEeE/6sSUOC4OCx4ISDSGZRIcMLChWjSnO64KGxWHzoCfNA+H2QKmdo0DjnZxDRegJD2JfLnkHN4gaIDG/ZiuJb7d2Cs7cOTB81Y/aQgAPHhUYHDOj9qmrfkqsHFWmW6JR+Qk7k0zLRKl3jAjidShrG4kng02otQp0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(136003)(366004)(38100700002)(54906003)(6916009)(316002)(86362001)(2906002)(66446008)(38070700005)(8936002)(66476007)(52536014)(64756008)(55016003)(66946007)(5660300002)(66556008)(107886003)(122000001)(4326008)(76116006)(8676002)(71200400001)(966005)(33656002)(478600001)(41300700001)(83380400001)(186003)(7696005)(9686003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MjVz3pI4wCIfLGkjpVzJudU82/o+G6IsWwUr6A7uyrm1MAobXOhoqjTxjFaf?=
 =?us-ascii?Q?qGHdIcwHyLJ8oOB+s98WdKYbFmx6r9m/IUQBsHQB1hyd9KQZAFx8I6QkWjzW?=
 =?us-ascii?Q?K1EJ9EnK8eJyXgismQeig3kGnqtE9mIZ2ayAILk70yaQnVWWW1+QPLda5C80?=
 =?us-ascii?Q?0S2yu9r0EWJwQz3o1eq14wrqKDne2d2fj7lhLWVQJK9zEovbsu6MLVDHFJrQ?=
 =?us-ascii?Q?iZm+Odr83F+qSSuwShnxmkpNb7h/CjTTsQpc3GbovPn4f0K4sId6T/NChNse?=
 =?us-ascii?Q?we2tCHfJQNX5oYO+d3AsJYhc8ruX+nJ/x1jCpuByDkLWV851i24C186OGjdz?=
 =?us-ascii?Q?HkATVc7g9XOG5clAPfZyN8qLCAQtLRsZlAIe/ln17jQZMHOOTwq/9cV/35vA?=
 =?us-ascii?Q?OYvEJZleqMVcgNKHYoZpUuucYKK48G8gfhctZsOPuTI1eCtwGEGyi8g/EI1e?=
 =?us-ascii?Q?vLL3+6kTillgcgRi8r9zZYqhdFontkMlw78xX14+WgTkkrAcsQavY/WPKBZB?=
 =?us-ascii?Q?OmhgOvmz0eaCsS9q8CdBa42L0hc2/VaHx04NE7lfXjPRfL6qOsk7VD+6HagF?=
 =?us-ascii?Q?s50bBgZmSYhaZjqsoTRvAcvGz0I2z+8VwCPgmzyJNG8vTj0Ig5wFptWGfbCQ?=
 =?us-ascii?Q?MGnpb0o/8uDYLC8HWA2Yu9QViP9fiDZfl7mYvagPKjf6ubY4EKT5THriZr2L?=
 =?us-ascii?Q?+D61vz7Z4MJ6bJIFScLvPbm45U67oLjr1vdWMsskZ7YUjd2+L0svo6o1TudW?=
 =?us-ascii?Q?kYEQDlQOxPIJC5BUX/RqAslxUu7Glqb15eDzJGb5HTsHIYRPSVqbKCWf4wVi?=
 =?us-ascii?Q?E2dg6ydZBxLuvRlNsC6yXq2dp//vnDcKs9ORAjHobCFNEfQf5bF5fBNooD3o?=
 =?us-ascii?Q?yEM0vOk+kzRWnHLZy3anxwNm/KRrCuxBrGL7k/k9g3R6rfP+4/NZFN+8ow8z?=
 =?us-ascii?Q?q+2BN5Ec+e47TRXMSLNFSjDy9IUHgqLtiiZH/vtJf8vMpDfI7ihKtJPVUMl7?=
 =?us-ascii?Q?/4VRDmEyySXAj9rcqGHdWv6n9zXdTcvLP2q68KSh6VtNKn9ETjhIbc/bXhKp?=
 =?us-ascii?Q?r6LpH7CTWGuXafe0F2XAHI+a4kBr0/qPRxEqDpWXovUl4qW6WYJ1n5bvgpIE?=
 =?us-ascii?Q?5mnea7BhRjrRdpVLxiGaWgJI9zGzrZnK7Vt5pz+kouE6qaZk29U2GE4G79MV?=
 =?us-ascii?Q?L1H0qP8AiFXqHC4ORF2Q9uYR5L8A5YRIytMzpCLIOOAmvQ7YjDBs41oJ/NcB?=
 =?us-ascii?Q?xM8GexKJ2dGiZXp7PT6vqr+LQSaF7xHIFqDICtAJfLkUE56lT/ctsyHXd6fa?=
 =?us-ascii?Q?nO974x70+XcisTACeOCcjv4lz1qv59u4P04/GRj2weE6TOKtMX/JTwUfYlNk?=
 =?us-ascii?Q?GdQQonLzxCroSdD5XO8upOGr9m0B1096hHKonQpI3mtmxjma5BMqiQuyhDk6?=
 =?us-ascii?Q?PbzcK+YYsvUDgyKU0nldKWs6cTkLz+DKllVqXn429UEPPkp3NdZiN1kbAWtq?=
 =?us-ascii?Q?kGfqd5QeHAVULrwROzoPcAuBYV+62fkJas32ixoZQ0b9xb3uaFaJHV+sEzFB?=
 =?us-ascii?Q?uZkwXj+tD+kCg+DWk9NvDM2sbHtikA7Oq2gNga4v0SZ7pWNczDek4Ro7Wz3w?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8872e-ff56-493c-32dd-08da922b0f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 06:18:06.3400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmaAA+fDjKxMjvCCgp2FGI1vIV801r3ILXd7+4FWhVCDKQCxDcimPMIqrNM9ZsIXpvNjQboswPtiKcaElRNdZfPV+scwvn1ToYPlxvQwzIQXWsaVVHDai4mBll3axSFX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5542
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Thu, 08 Sep 2022 13:06:56 -0200, Kavyasree Kotagiri wrote:
> > Convert the Atmel flexcom device tree bindings to json schema.
> >
> > Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> > ---
> > v8 -> v9:
> >  - Changed reference provided for spi bindings to atmel,at91rm9200-
> spi.yaml
> >
> > v7 -> v8:
> >  - Added back patternProperties for child nodes.
> >
> > v6 -> v7:
> >  - Change filename to atmel,sama5d2-flexcom.yaml
> >  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
> >
> > v5 -> v6:
> >  - Removed spi node from example as suggested by Rob and
> >    also pattern properties(spi dt-bindings conversion to yaml patch is =
under
> review).
> >    Once that is accepted, I will add back spi example through new patch=
.
> >
> > v4 -> v5:
> >  - Fixed indentations.
> >
> > v3 -> v4:
> >  - Corrected format of enum used for compatible string.
> >
> > v2 -> v3:
> >  - used enum for compatible string.
> >  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
> >  - fixed dtschema errors.
> >
> > v1 -> v2:
> >  - Fix title.
> >
> >  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 91
> +++++++++++++++++++
> >  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -------------
> >  2 files changed, 91 insertions(+), 63 deletions(-)
> >  create mode 100644
> Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> flexcom.txt
> >
>=20
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>=20
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>=20
> Full log is available here: https://patchwork.ozlabs.org/patch/
>=20
>=20
> flexcom@e0040000: spi@400: Unevaluated properties are not allowed
> ('dma-names', 'dmas' were unexpected)
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
>         arch/arm/boot/dts/lan966x-pcb8291.dtb
>         arch/arm/boot/dts/lan966x-pcb8309.dtb
>=20
> flexcom@e0044000: spi@400: Unevaluated properties are not allowed
> ('dma-names', 'dmas' were unexpected)
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
>         arch/arm/boot/dts/lan966x-pcb8291.dtb
>         arch/arm/boot/dts/lan966x-pcb8309.dtb
>=20
> flexcom@e0060000: spi@400: Unevaluated properties are not allowed
> ('dma-names', 'dmas' were unexpected)
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
>         arch/arm/boot/dts/lan966x-pcb8291.dtb
>         arch/arm/boot/dts/lan966x-pcb8309.dtb
>=20
> flexcom@e0064000: spi@400: Unevaluated properties are not allowed
> ('dma-names', 'dmas' were unexpected)
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
>         arch/arm/boot/dts/lan966x-pcb8291.dtb
>         arch/arm/boot/dts/lan966x-pcb8309.dtb
>=20
> flexcom@e0070000: spi@400: Unevaluated properties are not allowed
> ('dma-names', 'dmas' were unexpected)
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
>         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
>         arch/arm/boot/dts/lan966x-pcb8291.dtb
>         arch/arm/boot/dts/lan966x-pcb8309.dtb
>=20
> flexcom@e2824000: spi@400: Unevaluated properties are not allowed
> ('dma-names', 'dmas' were unexpected)
>         arch/arm/boot/dts/at91-sama7g5ek.dtb
>=20
> flexcom@f8034000: spi@400: Unevaluated properties are not allowed
> ('dma-names', 'dmas' were unexpected)
>         arch/arm/boot/dts/at91-kizbox3-hs.dtb
>         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_icp.dtb
>         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
>=20
> flexcom@f8038000: spi@400: Unevaluated properties are not allowed
> ('dma-names', 'dmas' were unexpected)
>         arch/arm/boot/dts/at91-kizbox3-hs.dtb
>         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_icp.dtb
>         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
>=20
> flexcom@fc010000: spi@400: Unevaluated properties are not allowed ('dma-
> names', 'dmas' were unexpected)
>         arch/arm/boot/dts/at91-kizbox3-hs.dtb
>         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_icp.dtb
>         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
>=20
> flexcom@fc014000: spi@400: Unevaluated properties are not allowed ('dma-
> names', 'dmas' were unexpected)
>         arch/arm/boot/dts/at91-kizbox3-hs.dtb
>         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_icp.dtb
>         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
>=20
> flexcom@fc018000: spi@400: Unevaluated properties are not allowed ('dma-
> names', 'dmas' were unexpected)
>         arch/arm/boot/dts/at91-kizbox3-hs.dtb
>         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_icp.dtb
>         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
>         arch/arm/boot/dts/at91-sama5d2_xplained.dtb

dma properties for spi node is already being covered by Sergiu in below pat=
ch:
https://lore.kernel.org/lkml/b4625526-8f9b-ada8-f854-751a48545576@linaro.or=
g/


Thanks,
Kavya
