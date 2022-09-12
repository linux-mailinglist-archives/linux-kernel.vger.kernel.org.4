Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07375B55C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiILIQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiILIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:16:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8A825EB8;
        Mon, 12 Sep 2022 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662970582; x=1694506582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bMkQSCJc9PjRMa8f/uzcRApXYCMs0BNdkgj25Cw1fa4=;
  b=shm85FHEg2UmqpJJ5b/VDMxYU5h97BYTpJHyE6+h1kWQ8h4cvkmu1gr6
   lAM29oqQRyQwea0bONRMf/SyMBH+09lrxqnfPxB3CJEPcWco/o7YC6ief
   OQeLc377rmuZ6IoQZlDb13Vsr9qbCX+5AH8Seag6rCzRSr8E8ps9eyBdi
   y0bXtzxdcjwuQCornZ6qixm9KsjYoAg3j37lSEXYXw8Uan8PBcB0nh947
   A8HybXRPBoSHCYS+dWXH1K4g2B0/XJyi46n9At+tYE5xqoYwZfTwy5bQL
   LZc5IBsgnVtZNKed5hJHJIq+cwZLqLAzfgX4SlpXBgeH/8ZwV6hoOmMy4
   g==;
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="176666001"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2022 01:16:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 12 Sep 2022 01:16:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 12 Sep 2022 01:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNWt5xemWGQnJMfkFCk9lsYMcCLW9JMtDar6aM7BaW8lXfLOEOY5Ic70z/GL3MoKTlYvmM2GRTo/3aGWzvkKv4omOM+LRfG0tZQuc+Eu5jjKxHRlQFSlXSZdZ7if0P5lFdLK7zm3gfDEz/RqfPVPCBvpM9z+HNoLIMnFGbH6HFey39FZZT3FA+p66MWmz1GBTYg9QuD8vCsWlSLqZCMQguOVr6q1dsXdt1gi5tSNeElecZWUqyKeZ+TjyFyLpgJe/rhiy73MSzsUOx2KN5ggBJO+EsgLavGGZxDUA/UcE6WnumoSXntVYXEBWxHkkILJ7nIAKGzW1C2AZUjll0vZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGxCscTlyYjZ1KNZy+fuaKEIN6h9wlGj9xjBFGmApn8=;
 b=ipQ6n1nEkhPGr+1W4GPB58OMLZKjH+/m6QzzFW2OPtCoSzqOuYkbrq2306SbN6kj3SQ8R5PNwf8QQzb//cvM0ctVb21VLeelDa1trDohHSHlnHXLwmMGmsbOvhBB8ctOqr4rAg4NbBBRKQKAXweQ4UrcJl+S/8hxkxZft7JhXbaPdml1Bq1Imc31G5t2zL6d0GQrlJ1tH5oBNDualIR8Adlt/el39wJKR80FXQNbizDRxTTz7QBKLhxnN6FhKtoD2ZK2/Xrs2rSPY9qM5QUnJZhZHvKY400WYMoXSI2CphpY/pqSLsRTPEptP6xd7/M/cZ8j3Fis+6fMymIv1V4eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGxCscTlyYjZ1KNZy+fuaKEIN6h9wlGj9xjBFGmApn8=;
 b=OjkGNMCHmEGDtPLLypQyeb597TBQEXzmcDo7DmvL3plCcVdRIk2zCiVMQEq5pQ/5hR6UIp1UUo1qC9K83U/HrOJaiUoHN8lDcy/PFEnJADJZOlLHDtVJsVQ0Wm5Zoa8PMtDJuKuHW99OF3/fA68ZCgM+G6XDMxQ6Q2AlG0Tff4c=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CY5PR11MB6306.namprd11.prod.outlook.com (2603:10b6:930:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 08:16:16 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 08:16:16 +0000
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
Thread-Index: AQHYw5S351ZiP2+bvEqYZuXgNIsbDK3WCUwAgACWniCABNh4sA==
Date:   Mon, 12 Sep 2022 08:16:16 +0000
Message-ID: <CO1PR11MB48654A4239AB7A760193497992449@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
 <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
 <SA2PR11MB48742AF8A0C9BC6D32D57A2892439@SA2PR11MB4874.namprd11.prod.outlook.com>
In-Reply-To: <SA2PR11MB48742AF8A0C9BC6D32D57A2892439@SA2PR11MB4874.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4865:EE_|CY5PR11MB6306:EE_
x-ms-office365-filtering-correlation-id: c5804287-154a-47a2-048d-08da94971080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyKcinMda/mYEP0k7JbWPCjd6iXKdmRIXxtXTUSugvTrc1lc9SuF7ElI2Rjak+K/endhxDjIE6p6i+UUHPQaKCwUUN1aBN2BionZ2NsWtZbX81zZ/rQ7yIFYmIPvJUrNaCuKxtjelj4DdcB9rFHfpBbW9ZDc8GF0bvpYtui8+hImgj5pO+8yIZJpmJdR0HB3rR+xRnglnEJo5U5QF1C6F2g5eH108+zjpaW30YBS7v6s5fcywrQE+/rQc8B9Db+DCun/wacd2vDvHwC43PJp1TxlP2Fb6fTPvFSrYGf3RC4iopvXYIFw+9mc2PlAyFUZz/SuIhAqOECsE2cZkvq5qU1gqsAhPzPLMfmaLTmO9Ux+OKmRCueYr6JsT9wrlMTXKkDtG/Dqtbuxqn9jP5hqMIXgtafLWwgTl+EVjJ1BxoICQB/qv7dK7uOMf6YtAcgqMT9cMqPYy7wQ9h8xR3YAu54eENkH5UNX2rkwxQ0pPUypVb/BBxFNz9HTHcXdglYPkdoFRY5UaWiv8G8nK3XMMBTYM2gVGhGDYcf26FTmSL93S8FkrGta/JdL9+Io2iYal7FO1u71P6BfRfI+EZ5odmMhblhhHyUzxMceIxJVNaTV0+EN67RGC+aPugX0rHDXnW3NdhbuTld1K/JrOxvBfRUN/Fwwk+o+9bBMo6hkW/RLm/CXXtmbQxMG+mlcRSmOMAzigF2O/LkxrR6MgPu5pVYs0PawvxHcoOLajElFJ1aGEMDVpdgtb4Ivh8KsGuG2c8FQ/JRdSuloRXNuu/DZZKuvRMlZKh1y2i82LVpXOC7YXqzL2/j+iaVOjB1u/m2xK5tC/qSvWkmKZJIgp/BDBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(366004)(346002)(376002)(66946007)(186003)(64756008)(8936002)(52536014)(66476007)(5660300002)(2906002)(66556008)(4326008)(8676002)(76116006)(7696005)(66446008)(9686003)(33656002)(6506007)(86362001)(26005)(107886003)(55016003)(966005)(41300700001)(83380400001)(478600001)(38100700002)(6916009)(38070700005)(54906003)(316002)(71200400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PWJ4SJMKE5c5R45TGcuYWHFmeqm6uQdS4qLmv+CIGLvgCr7n75Eo4uCNLH9X?=
 =?us-ascii?Q?kbjYhFacsLduBJXaMC0NnwEltgMBnGMukA9iCMHVSuO5xqwMl+5Mu1/4xgnS?=
 =?us-ascii?Q?wksoP1Dqih7S6fJ7gThyhZzp+mQpA+NnPlPnIZYCrtBt42zKYWXD8eSFpIrn?=
 =?us-ascii?Q?2W1BE4gTHxYFi/5a6whRdt0KZAQnODp+zZqB8yo0LBkNFmM4n5l5ms1oFwWA?=
 =?us-ascii?Q?Auka4sB/Oj2kJNmaJOfohgCMwF+U2mfyK4a4+w87s5EkAOcP8xCb/G8QTWi0?=
 =?us-ascii?Q?+kZP1/Ld89gd1/XiQEyWt4hr1HX9BifOXx1kY79z9yIue4okFpITVpUkV0DH?=
 =?us-ascii?Q?1E48/ByaE0RNPtTQeylB0OYCYT0x9FQlBf8pLQsbyntBnxp+cJagXq0DuR0s?=
 =?us-ascii?Q?4JjfG6TP6V3/5Uho+fxVgTvmuf+FgFHeM+Si6BQO6L3EgSL9YJuNCj8IUVEh?=
 =?us-ascii?Q?nsjKTcD18oDeb/3wL11ywnfElXsbRsCOXqZFlQL5aUfrIj1Q+IQm5YFhaCAN?=
 =?us-ascii?Q?StJWBTldO5itYODdrZTV32FgGuD9j9530WROGOBif+YEIfvp2FE151yU7XJi?=
 =?us-ascii?Q?IykdvBiqplqgWOTXR81XkcusCHLFasgEbv2UIyNbo3YXTAoiB33Te+YGTbYY?=
 =?us-ascii?Q?3awOfq01rv6JVqdLs2j3QhB5fVY0OqcL2bGOoL0Y2BJbL3aXbGrKcp7tCagz?=
 =?us-ascii?Q?w/hJh3ZandJaItGfdTu/KEu3Mbv7O7LTHCpK1dRvQx8FNfEmnEMPALpoRDnU?=
 =?us-ascii?Q?mkpOqd++3PQUqDBmJGAvZ09g5uCazCsvNswTHcXvegJHzyXyDgjFWjqJhe9n?=
 =?us-ascii?Q?U3l+/JX6Tm2GlgMjbNQMe9Xpx9VLJUA79hwl2XeHExkFBE/kE3Pbi4Hcze1E?=
 =?us-ascii?Q?2deY64usEuq42nHBuhAm4eO3GLwDHkA0mzUUwXHyU/cHaW+eJfpIlUuyvaOE?=
 =?us-ascii?Q?PaFuGtwIa2lXEG93sRCfIt2GGra469HBgDeSnjxJXvshcWE3vYm/81rYgZcb?=
 =?us-ascii?Q?IYNDR16uiCHBebcjCsb7ep7X5sTag0mCns4ebYRBqyvIXqJl10Z8PfNJcFZo?=
 =?us-ascii?Q?rLzm8ROgIF7f3fkQqjw6Ro6QbU4d9WAB0cDFe/SMrBKq4o5JC0Y3sm4BGu3K?=
 =?us-ascii?Q?viqROEo5V4kvy92yy/sEokJcuoU2kpXyfjO5HOIxNjZKSrn/5GIzhl+4I0Sa?=
 =?us-ascii?Q?hOnRZKxs8ucvdzGqJfNs9wwNkCYv+BCF44WzFXRY8D1AGc8c2j1GqAUb98pS?=
 =?us-ascii?Q?gU53Iit3ZrkgqKRjHaUmxh8FGyQnXa30otrwzBlrI04NdbUCd0/M0ABhRfLX?=
 =?us-ascii?Q?xqBwN0BnzLm+F4QIZLCqMJ/CusYzapOMMX2kjKacbevZc/JblNm8GxbtS8yg?=
 =?us-ascii?Q?xVJCu/0VqhhdpmBo51AUYXD/YwwAo73qCR4ZBJt/Tmi4A92rxn8O2W2iwTET?=
 =?us-ascii?Q?AZkeprkoOaxQ4Nqzn9PCw3Ic/4LZgicK4gowrkM2U4Xp44C6ziIfW61PjW92?=
 =?us-ascii?Q?C+hRiIzXofhDsClSoBFSfAgT8VyWR3iU74VtuMksyoC4+c3UCiPkHqHNpYwU?=
 =?us-ascii?Q?qc6QUUVzcr/d6wp0n2hGx858B1XTX8ERQbLFNJ9OMSUZfqNCetqWV5iWlJK4?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5804287-154a-47a2-048d-08da94971080
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 08:16:16.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qy5+t0y+s7lVCKOF1PZEYcBEK0KvEdkdUbqU0eKPI4YUcABw9isN56SXST3zxXuFu1p9hsfSVwAjsREGlG4SRQQ5aDKRYaBQXR5sKvGIZmC13r3Jyo2hga7j0vy5iy9F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6306
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Convert the Atmel flexcom device tree bindings to json schema.
> > >
> > > Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> > > ---
> > > v8 -> v9:
> > >  - Changed reference provided for spi bindings to atmel,at91rm9200-
> > spi.yaml
> > >
> > > v7 -> v8:
> > >  - Added back patternProperties for child nodes.
> > >
> > > v6 -> v7:
> > >  - Change filename to atmel,sama5d2-flexcom.yaml
> > >  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
> > >
> > > v5 -> v6:
> > >  - Removed spi node from example as suggested by Rob and
> > >    also pattern properties(spi dt-bindings conversion to yaml patch i=
s
> under
> > review).
> > >    Once that is accepted, I will add back spi example through new pat=
ch.
> > >
> > > v4 -> v5:
> > >  - Fixed indentations.
> > >
> > > v3 -> v4:
> > >  - Corrected format of enum used for compatible string.
> > >
> > > v2 -> v3:
> > >  - used enum for compatible string.
> > >  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
> > >  - fixed dtschema errors.
> > >
> > > v1 -> v2:
> > >  - Fix title.
> > >
> > >  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 91
> > +++++++++++++++++++
> > >  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -------------
> > >  2 files changed, 91 insertions(+), 63 deletions(-)
> > >  create mode 100644
> > Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> > flexcom.txt
> > >
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check=
.
> > This will change in the future.
> >
> > Full log is available here: https://patchwork.ozlabs.org/patch/
> >
> >
> > flexcom@e0040000: spi@400: Unevaluated properties are not allowed
> > ('dma-names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
> >         arch/arm/boot/dts/lan966x-pcb8291.dtb
> >         arch/arm/boot/dts/lan966x-pcb8309.dtb
> >
> > flexcom@e0044000: spi@400: Unevaluated properties are not allowed
> > ('dma-names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
> >         arch/arm/boot/dts/lan966x-pcb8291.dtb
> >         arch/arm/boot/dts/lan966x-pcb8309.dtb
> >
> > flexcom@e0060000: spi@400: Unevaluated properties are not allowed
> > ('dma-names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
> >         arch/arm/boot/dts/lan966x-pcb8291.dtb
> >         arch/arm/boot/dts/lan966x-pcb8309.dtb
> >
> > flexcom@e0064000: spi@400: Unevaluated properties are not allowed
> > ('dma-names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
> >         arch/arm/boot/dts/lan966x-pcb8291.dtb
> >         arch/arm/boot/dts/lan966x-pcb8309.dtb
> >
> > flexcom@e0070000: spi@400: Unevaluated properties are not allowed
> > ('dma-names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
> >         arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
> >         arch/arm/boot/dts/lan966x-pcb8291.dtb
> >         arch/arm/boot/dts/lan966x-pcb8309.dtb
> >
> > flexcom@e2824000: spi@400: Unevaluated properties are not allowed
> > ('dma-names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/at91-sama7g5ek.dtb
> >
> > flexcom@f8034000: spi@400: Unevaluated properties are not allowed
> > ('dma-names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/at91-kizbox3-hs.dtb
> >         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_icp.dtb
> >         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
> >
> > flexcom@f8038000: spi@400: Unevaluated properties are not allowed
> > ('dma-names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/at91-kizbox3-hs.dtb
> >         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_icp.dtb
> >         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
> >
> > flexcom@fc010000: spi@400: Unevaluated properties are not allowed
> ('dma-
> > names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/at91-kizbox3-hs.dtb
> >         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_icp.dtb
> >         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
> >
> > flexcom@fc014000: spi@400: Unevaluated properties are not allowed
> ('dma-
> > names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/at91-kizbox3-hs.dtb
> >         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_icp.dtb
> >         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
> >
> > flexcom@fc018000: spi@400: Unevaluated properties are not allowed
> ('dma-
> > names', 'dmas' were unexpected)
> >         arch/arm/boot/dts/at91-kizbox3-hs.dtb
> >         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_icp.dtb
> >         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
> >         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
>=20
> dma properties for spi node is already being covered by Sergiu in below
> patch:
> https://lore.kernel.org/lkml/b4625526-8f9b-ada8-f854-
> 751a48545576@linaro.org/
>=20
Hi Rob, Please let me know your comments.

Thanks,
Kavya

>=20
> Thanks,
> Kavya
