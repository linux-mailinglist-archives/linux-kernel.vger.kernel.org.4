Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27266CC762
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjC1QC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjC1QCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:02:19 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA83E3B4;
        Tue, 28 Mar 2023 09:02:15 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SEHqNN023719;
        Tue, 28 Mar 2023 12:01:25 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3phtt89w2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 12:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCqCoO3epXJ4kLPutFtNhpSvGIG+N6EoqmcM8bmmDSaThwbvFzl/GCKMJyUM8LJmFJCqmaxHewRVFL67ihz9QI3qForg9adNkP41c2tCnOLz4dt0FxQGrScWki5L1QG6wCp1lzsEjv6oTYJrUIk4AL8kibr0njhJnJBJQQ1xUEQhY5uQypNC5zbEdbYaCnMzS9Fuym9giB47ySW8Pn+bSWQ4vaMIlm4JyZa/wX1xEuCL+nvhZlIuhlhRju1IEnCkKT9l125GGSjpXbxwitx27rf5rcUvntgKJVmhpN8P8VcDq0p7W8U8B8/hqk+x039J3Q55fMxhD1cGwMSikCNtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQX/5joFTvvRf+XNiPrR1Ex8IImixlcPrNWlgSh96k0=;
 b=M/zOM0TWVypmE6lScAI4p7SaIAZ5kMpkihCwXPeThI9qVcTfslG9rhm+7r0TYblbT39Ox74QXn3lgMlFQUI66usYznZRXlwv8PVnQIJiC/iMxRkSqAcz4Y4rZ9dc2KqcDN/sbn0KI/KEg6bwkCjLmEBVozvewhEFFxkn/s9fGAPGItCKfufTO1slu7borQzQxaIZd5oqmUo/4EfvCIp2AIK4IPJySiM0uT4T/24GmizcnzNklb1wuXFaqjBpuW9XwVCr4d/tABFwWOs5kWGvwVxnopwsdTc2OlwTUFSC3nq1OPxTMsmi1+eHUMnk+lAEfGopz/he19w5MLPSvHdM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQX/5joFTvvRf+XNiPrR1Ex8IImixlcPrNWlgSh96k0=;
 b=sz/x9rX7jRulpoXcdGXLyYxjulho532A3zzIkIteJCwEP9NNdprGK4L3dVvv59sxRtWrclQlnvZU2LImD9E56nI2LQDeEPr8NDnD7LBYfZbyzxZ+1IZGr0GqRz4P4WwXuQrwYTmL8ZeIJIJRW1de90pSHnC0lUvIzq3gUJNQJCc=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SJ0PR03MB5759.namprd03.prod.outlook.com (2603:10b6:a03:2d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 16:01:21 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6222.029; Tue, 28 Mar 2023
 16:01:21 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-9?Q?Nuno_S=E1?= <noname.nuno@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Thread-Topic: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Thread-Index: AQHZUOiqG6ZyiGxaUE6S5aTx5qv2Ta78K/mAgAAAKICAE8FVcIAAWNsAgAAJvgCAAAWSAIAACOQAgAAEs4CAAAR3AIAAD8MAgAACyAA=
Date:   Tue, 28 Mar 2023 16:01:21 +0000
Message-ID: <MN2PR03MB51688CAF5DDF0628ED6B0B06E7889@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
 <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
 <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
 <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
 <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
 <60bbad1b38b8e3c9c3efefb0fb7b8d3cad7fa98c.camel@gmail.com>
 <ZCMMHl5ENSuCstFV@smile.fi.intel.com>
In-Reply-To: <ZCMMHl5ENSuCstFV@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-9?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYW?=
 =?iso-8859-9?Q?hpblxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?iso-8859-9?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLWM1NWQ5MWRkLWNkODEtMTFlZC1iZW?=
 =?iso-8859-9?Q?JkLTU4NmMyNWQzYzNlNFxhbWUtdGVzdFxjNTVkOTFkZi1jZDgxLTExZWQt?=
 =?iso-8859-9?Q?YmViZC01ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjE2NjMiIHQ9IjEzMz?=
 =?iso-8859-9?Q?I0NDkyODc3NDM4MTAyMiIgaD0iWlczazd0SXh6T3ZUQlB6OGJESTQyNFp1?=
 =?iso-8859-9?Q?a244PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUl?=
 =?iso-8859-9?Q?VGTkNnVUFBRW9DQUFEZUhiaUhqbUhaQWZDUGg3cUNHT1FZOEkrSHVvSVk1?=
 =?iso-8859-9?Q?QmdEQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQU?=
 =?iso-8859-9?Q?FBQUFBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFRZGlrNVFBQUFBQUFBQUFB?=
 =?iso-8859-9?Q?QUFBQUFKNEFBQUJoQUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQn?=
 =?iso-8859-9?Q?lBRzhBYWdCbEFHTUFkQUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhN?=
 =?iso-8859-9?Q?QWFRQjBBR2tBZGdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-9?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-9?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbm?=
 =?iso-8859-9?Q?dBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFB?=
 =?iso-8859-9?Q?R1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-9?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-9?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-9?Q?FBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWVFC?=
 =?iso-8859-9?Q?a0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdvQVpRQmpBSF?=
 =?iso-8859-9?Q?FBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-9?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-9?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-9?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SJ0PR03MB5759:EE_
x-ms-office365-filtering-correlation-id: 887d6b2f-0f55-4ed2-ef35-08db2fa5ac67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H51NSq3jX1Rx2ZiZKTS6BsPRRsPB2VAKnA47Wi4Rjhk3hrmDL7RJnW5JtDV+O6drU9xJpVVak6l+BnQrioUvt8OWc5Au7XZRvGopVyWeSHdFbLZQEUm0bz+tNSewmORLR9xYj7okqvhaL13NZezIb8sImDYMO1HlD3/hRwm1QheHMtl0KHrXlfKIHbIL8/LbVUrm9VGSeMNg54TsqqHXy+rjpU/pqhw7+15nragE42qyJYQWj2sShGKm7NGtAW3FCEqUhSJxNDzcWDhexk7W2WMjVdsYvme0WNQ4/RS8h2uA2AhibAfzDUTitjXITCm/7hmKRmrwhV0uEA9zWKbwEdLu7QWPjqrIFNjAH/xlFBau4oQGMuxxxZ3Suol27aoMw3nMSpnsJ4HCS4JUP0Yzb88ZnwzDo6REmOGFhLk2WuqusIo98DqsKw0m+4eb0CAanTV6r9+ECXlU8xi7ZyDdyf80PL+y5jAhw7QA+HeCZb6PBgDJtufDw7z/V9pOPEU8aROzU1gWNFClEMJ0IrZlE9RUvrttMeIgqu0GSeyK8fApNu4wU2+PABWH6uBnac2t+XrcEGddBmNdCr96ih00z/2QzpCpOAY9GeiWVGOBki1ou7XyKQ2bx/znXLuDswjU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(110136005)(54906003)(316002)(83380400001)(186003)(9686003)(6506007)(26005)(71200400001)(7696005)(122000001)(86362001)(7416002)(478600001)(33656002)(38100700002)(38070700005)(5660300002)(8936002)(55016003)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(4326008)(8676002)(41300700001)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-9?Q?cgEWp12vSWhPuUU6cp85ptmmAi4jdL9RyZUhvkZ2H0d0StOz6Box66AI1G?=
 =?iso-8859-9?Q?cZE37kDt1MZka74+3/xPVhUAea5IUEw0D2nZ1EV0tgjkaiu4GHQSL2+7j0?=
 =?iso-8859-9?Q?IbuGcJq5+5kzq6lB3CyuVk5HQEjXLfyv95ZfbfDO9DeIoC8IXsUagohxM1?=
 =?iso-8859-9?Q?Acdv+V73kQaJ/f9wcUTwj9m1bxUP4GdykHBopnSomVJm3fYrS1YGRiomgC?=
 =?iso-8859-9?Q?wZT+9nUD+M7tn2BHsPaDX5OJz+CtUaCbR5eBqAp3xa3W5Z0P1Y/lSug6+0?=
 =?iso-8859-9?Q?sif6KJo5bzkxOnEie7bR4Vm90rzSGFo512i7HL0209k4D0Hdft8DINEVtP?=
 =?iso-8859-9?Q?eNtU6EHob80m75liHwr4bfuzE7Y11CbzcwSqAfgu98Rfqccf6TqR85mn8w?=
 =?iso-8859-9?Q?diBSe+QiAc/CV1CEc16KJTW6HnrqBE6H67PzfYzMfMQdnKxRUVnbQTOPZF?=
 =?iso-8859-9?Q?IIQJL1ZaxBC41mq2duDzg6flHXSEt3w28Ike63A8uIJuQYy4iwwwo7apX4?=
 =?iso-8859-9?Q?lA6h1PYD0YYVuriqCqPOT+sDX6UOIHB/pYG50MSRQFeFgSi8G1l8aoVcbw?=
 =?iso-8859-9?Q?9waRHJZhXjJeOcNDaJ7VoxUf7JiC+24F5U8B7L2QkLzrJjfS/PrdZhZ5Fy?=
 =?iso-8859-9?Q?CR+ioR5hh2ew0xeLNVf0eRo3nDKaYOh43hrYNtRY0ljwpk+em71HfAwGO1?=
 =?iso-8859-9?Q?Oeea/3vcoATLWB8VI0GCnUMcOKMh49TRg/kIEPPbXuWZLLesukGXgFjXdr?=
 =?iso-8859-9?Q?BipDHRwPQ1mWqdnYEn0u3aEo2QPKscT0Ow5aaEu8ud9O56M0F2Fxg2TUkc?=
 =?iso-8859-9?Q?3by2/ilVeWj0LJGYBICnsDzdTs2Nsi1F0924fMo3q6T5Ku3kpZJVvhPpz2?=
 =?iso-8859-9?Q?eUaTnBdNVwvJyCHg0HKqVNfnMHZbL3KMXDpTZFM3xjIchyM3v7pZrqeS4S?=
 =?iso-8859-9?Q?8dTytrVk0xJr1wMnK4IUp+BNuCYghab+rCu/B9MsoJygnobye868h3rNaV?=
 =?iso-8859-9?Q?K/JiGoc/8QcCGe0IATbwKAuNjyTyr1e4IEw3HMAg1R0pzWXr6d37xn0XYA?=
 =?iso-8859-9?Q?GYaLL8esikqs7Fjms4xA6Vz+xeToTVi/gTxGHUtKhbtyivKRBxv3KGBQhp?=
 =?iso-8859-9?Q?TqnvPAFY9GPkK6nOQqsF4PMFRwK8hyE+Kg4HEY3LpFrf1tP34OyWIk9nx3?=
 =?iso-8859-9?Q?2Cw9xeBGVSp68OSuVR5JjJ4tfQ/0bCwCxFOICQSL13SUE7aqANd0/Aex25?=
 =?iso-8859-9?Q?DUSP57J3HyPcwxwBaPtteHIahfMOic480wwcEyLAMCDpLH6ElumF+CUFQN?=
 =?iso-8859-9?Q?AsGn7RwYqdzrX3cpJYL+1HTk3VLVSg8PtlLiXwGomexYdzFuaDiD6X5J9T?=
 =?iso-8859-9?Q?qFNpiLlaA+OeoXL9RIpe/xj5L/mUR8hX3I4TcV6NCexaXrhLQYR1rnNK8H?=
 =?iso-8859-9?Q?hkHyB+SZoDeJmeSOFY6Qz8KwhIP8qGbAB0AfPNVGMR7PCNZy6XvV3CYtfT?=
 =?iso-8859-9?Q?X/t9GqBxyGvsIMqLg5affGd8eWQYGcI02y/9YKnlXQ2ZVHO8Cv1QkU9m1G?=
 =?iso-8859-9?Q?dwKzv7R6tFufJCOH2w8Q7sM5UAuAc3eQ7D5rjjFmN0NPNnP5g+aI/xL6zu?=
 =?iso-8859-9?Q?ua8tqSejtPn6DefRoEmbWn2FmFn4K24x60?=
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887d6b2f-0f55-4ed2-ef35-08db2fa5ac67
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 16:01:21.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQLNQQtPWmuYK72pkQOayIbxJZJgl2F1ljFPJxlitP3fAEjoVRFMKFj+a/zrAX/lAj/YKnnuMjn+Mn0hES8dnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5759
X-Proofpoint-GUID: oEygBh_I08DWOPMso1Sk6HUngXHtgJPo
X-Proofpoint-ORIG-GUID: oEygBh_I08DWOPMso1Sk6HUngXHtgJPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 spamscore=0 mlxlogscore=630 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280125
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Mar 28, 2023 at 04:51:18PM +0200, Nuno S=E1 wrote:
>> On Tue, 2023-03-28 at 17:35 +0300, Andy Shevchenko wrote:
>> > On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno S=E1 wrote:
>> > > On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
>> > > > On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno S=E1 wrote:
>> > > >
>> > > > > IIRC, regmap_read() is not really reentrant and it is used in
>> > > > > the IIO driver on the sysfs interface. So, yeah, I think you
>> > > > > need the regmap lock and better just leave the config as is.
>> > > > > Yes, the lock is
>> > > > > opt-
>> > > > > out
>> > > > > so let's not disable it :)
>> > > >
>> > > > All the regmap operations are fully thread safe.
>> > >
>> > > Even if 'config->disable_locking' is set? I think that is what's
>> > > being discussed in here...
>> >
>> > In case the driver has its own lock to serialize IO how on earth the
>> > regmap lock is needed. That's what I asked the author of the driver.
>> > He told the code
>>
>> Well, if the driver has it's own locking, then sure we do not need
>> regmap's lock...
>>
>> > doesn't require the regmap lock, and I tend to believe the author.
>> > So, why to
>> > keep it?
>>
>> However, if you look at the adc driver, I can see plain regmap_read()
>> calls without any "outside" locking.
>
>Then author of the code should know what they are doing. Right?
>
>--
>With Best Regards,
>Andy Shevchenko
>
Hi Andy,

Actually, I do not want to disable regmap lock that's why I did not update =
it.

Regards,
Okan
