Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3B56D64A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjDDOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbjDDOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:06:05 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DEA46AF;
        Tue,  4 Apr 2023 07:05:44 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Ck8eV013904;
        Tue, 4 Apr 2023 10:05:08 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ppecd6v3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 10:05:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYm1QwwKln5S77L0gwrRZK1Bv2lLeMY579wwC7PTsIA2tSpQrG2z/6+Du8sWZOQGfjjZWvKZ+b6sTlW4IeQMXREX6UWsErJs3h9RG2Dorj5uGG/QmKBlxMxWiR/5Fu9Xt5VdxzjHdS/1oSbvOXbh+XZEjkKRsWZfP0wm1OQSjMe57R4N9w+PBs0wbroqWJBlfEqqpbkaH3LjKudOsMNaG3n7XmjAjd0wul9w3Azr+u06AN42WzSpMQyR5SnBU6hvu5OsB6QVlmkY54NmLKLwidyyg/n2glIl9t+HYbMALfIPX+17x8CuIfNun/RLRAeRDPCpjmwXTcd9/3/KERRIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tfkWb/vBYUP/IxKyt18FKyzKYdrx1MXit2JHCsarAI=;
 b=m7IfPo8EYhMef9YTsV/9sD6dtkfu++fOVaqXG6F9+fhTiKeiNSX16r1efDOCGKFPglQrf3hX3jeRqMPYpNU+JJBk4kwUYFhwcVfxCIw7injQkSoVEgRbpKu0FfbamrcoJUwKAh9PQoiOiBtcgaz+5XN/9K1pgVTOYpFuuxJcjbzYece2QjdwaA6auMLCQCoR7NrUq2YkkTlk60IhidVeKfpENm+wXOuAPA15eWFD1rVKGWnMl7Ds7uu2n8/rHZyC3R9dbrfU+bhkVnY/SUkK0WLLrGzUBn2oC0NAnUrwNfzTeCOkCdSlNid8GbLpZ/qIqpk9Fl04isnM/D6UWH8sWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tfkWb/vBYUP/IxKyt18FKyzKYdrx1MXit2JHCsarAI=;
 b=40SvxVYrbbdP5fQD9VsZCxUVYHy4Js0pHMNrpj145ucE1r9BPEFA6Rt4Sbl6TcE5e1T4xxSfVtSvmEGvggnlPWTX6bdOwvSoLnXMrGvrzDy1hOtVOUWAu2El4F+BjaUI6Qyt214JX99CdrmcnALsSCmAUbX2sadrf7NXMVfmuXI=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SJ0PR03MB6988.namprd03.prod.outlook.com (2603:10b6:a03:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 14:05:04 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 14:05:04 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v6 2/5] regulator: max77541: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Topic: [PATCH v6 2/5] regulator: max77541: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Index: AQHZUOhK4+ouoKvMhkWOBhvjITphT67vPEuAgCwdhdA=
Date:   Tue, 4 Apr 2023 14:05:03 +0000
Message-ID: <MN2PR03MB5168ACF92AFF775003C29B12E7939@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-3-okan.sahin@analog.com>
 <ZAcrzYNesiTYLCH3@smile.fi.intel.com>
In-Reply-To: <ZAcrzYNesiTYLCH3@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWFmNjkyNjFiLWQyZjEtMTFlZC1iZWMxLTA0?=
 =?us-ascii?Q?N2JjYjVhYzA0OFxhbWUtdGVzdFxhZjY5MjYxZC1kMmYxLTExZWQtYmVjMS0w?=
 =?us-ascii?Q?NDdiY2I1YWMwNDhib2R5LnR4dCIgc3o9Ijg3MjUiIHQ9IjEzMzI1MDkwNzAw?=
 =?us-ascii?Q?MDQ4MTk4MiIgaD0iMTRSRlNvMjhIN3o0RlF6V1NrMmJiL1ZhbEt3PSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFDK0tNTngvbWJaQVlRMVZZeHVKaUpuaERWVmpHNG1JbWNEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFRZGlrNVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SJ0PR03MB6988:EE_
x-ms-office365-filtering-correlation-id: 6fbae053-72ba-4d49-c56c-08db35159694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRFicBcw3O4nwXhqPgRzejX5yiiN4untfipsuB90qGjxxOLLBibYbpGCVh1uuGP+CstHGCl2jIAFysKQ88YqLEd9YgTrhGNDIizMMLmKGH/IsZdoAUNWuS4dQpKR5uZqr7qjhHTlXNsQQEE0AFDf1ZQK/bQ/b4Gg6MqQP9VQlWHtCI8eZoHLP3nLH4I56EvzKUkagPhX1sRhpRzmbeYz4wrwPhyGyRAbxRZrIt2e/YWh5sr3t+dAZvSeES/kkP60K9shNwOOtHsBKRNuMJL0LQH659cdeP5+4V2ZxdhMeMRc8huyPjSD8oqnxTs+tfp/MaZti6V/SGocNKcfN6fScBQQZyVuAEaUmAC2U189txQWxpMIyjMIep7aufozrNT2preuU6wXABAmrzXP63/JjK7lr+q3F3wS0qhyK7qnd1wvYNTxKE8ifv/Mb2tWPN7v49iGC2cAa+2w0l+34Vx/wd4Mqq8w3xdt2FFlaE2d5maQU0GhHQPzrOAeaIYCoW8bv6lRytQTJ3yUaNSSTYGTAbMsFn0LRLh7VppoU4WqkLuF8UfZlBBCPMQ0z7cwFNwPqN7Awy3K+TaVI+un2xicfnaAUfD2g6EfBxmtdIxx91KYw5FQB9dcC13caRjcw9Uf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(186003)(55016003)(41300700001)(66556008)(7696005)(66476007)(66446008)(64756008)(4326008)(6916009)(66946007)(76116006)(8676002)(71200400001)(2906002)(38100700002)(86362001)(38070700005)(122000001)(33656002)(5660300002)(8936002)(316002)(54906003)(52536014)(7416002)(478600001)(9686003)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JbsDYpcSBweEa6/3HbmqBfeHIcFVDnwjTJ2CvAIzh4uY4lybo7AfvJrYWHFW?=
 =?us-ascii?Q?PEURev0HAkQV1SrH79BXPZwZZNuyZWn3W4/ZWqGpOqMTXCqOhpP6fZLVV/Sp?=
 =?us-ascii?Q?PXQrXZv+ZKznjuSlztLu6fQDyZ0lvKEUp7Jtrp3a+0UgHqsSrcdMKUmLGa/D?=
 =?us-ascii?Q?cfSlXZVWzJ38Gb/19vE+kvaaTLDIzlIsJcoZDjRB5qGmdgZz0LnyvvTY+4we?=
 =?us-ascii?Q?duTEqPrgvecqRIU6/FLAmyPGQFIOtFBiJupEcaGbzqcGZfZaMDADULTsV4km?=
 =?us-ascii?Q?Xxqvxvt0D7yqEybXyzVds05xf83pWIb0yjN9GvCA4zEYriegjMrfbfg+VzWT?=
 =?us-ascii?Q?qhF3d1kfjmgSNYjcN0Y0Qqauh0Ku+llXBtzvVVVpAMESISo8hZAdJ0EE5iHz?=
 =?us-ascii?Q?AHOVQvru6XhfiehhppYPiqo7CyhkS5h+lcE6SsO+sPNHsU9zBEPy/LVLs86V?=
 =?us-ascii?Q?Pyls5fVGgSG14qaUVT6WUgJd38jS3R/fh7oY6EG2uCuCEwub8xeFLTOx/Euu?=
 =?us-ascii?Q?nyCs6LWCjg6DiqZcmosDUHvLizOL/fjy6D7TBNjky7E9nBx5zW1ceFMHcIv5?=
 =?us-ascii?Q?vpdCVM2B0NS8mL2SBxbDrBu9W+EguflleBlTVBGkjnvESeEUNujj2jNdOvYo?=
 =?us-ascii?Q?gapnMjMTAK5NzEMNozEhUHi+xrlzqYSnygJAAVWJWV/+JURHQFrpPJ1HJCVk?=
 =?us-ascii?Q?T0QIQ+tz8h2rzbwVFZQrt3QOY8rlEH3YoC3gJddXFEF8HkAjl++mZYPoRg1t?=
 =?us-ascii?Q?KamM+56fdHiuNrabSQbqfAark+8KuxJjOqLs0tbOOYrHOQcI0pDdxbCZ3kXg?=
 =?us-ascii?Q?v5rZ8cmFovSCYvPajeyOXPE8fkFksJ0dr0Kn3uDYCkLWrG1MSHX6LfJhT7/v?=
 =?us-ascii?Q?DQeb542LMD2zJCLv6ZWpuFtCYDpNNrtSVHzH4TNCwvz2Zp3rhbmFq4K1qyt+?=
 =?us-ascii?Q?5quiho+1bq9PL9UcGVvxurHUwRSL8r6vKiUqMXij8XGWMNxRy2nw0jeGLX58?=
 =?us-ascii?Q?KghllJ8EqIFur2NxRF/Gao5QQvKg9rerPjVPYJ4q//Ifje+kExLm6dRuEf6Z?=
 =?us-ascii?Q?/GwJYNRZ8ygLMWXaqP1V/I2bmPtvckpVgWcZO/Kc4eXcWLNrEo8vitiTYi7P?=
 =?us-ascii?Q?hpt981/4SVVK13s196Lg4zfINfwZMGzEj6pLfHSU02t3S+OhM2j6VaIX3cbU?=
 =?us-ascii?Q?xu9DOYGH/ifB46Gi6Gbg2MKLyQdm7rzRA7dnaOd9MXgwsfTRUCckN0eKVXxE?=
 =?us-ascii?Q?SC3T2do8U08agsUhogHOfuc0/oUjSsZTNf3l42esi5BEhlbQ/B95nhQgbVh5?=
 =?us-ascii?Q?ePGVbPnOXcDNkfh1hOr5NYknbd5s1JlY+yiv0i1Uus9oF8xakAw+1JU4xsi3?=
 =?us-ascii?Q?J6GXjwirW9GenVO8TTV+GVqIwJUzBpuBV5Ji2JSbNfBHjSHjDyDnmMtLLuj0?=
 =?us-ascii?Q?JjQmvMfyG8Y0DLEqEpaCd91fTdOtha2DGvWSJ6MYo8E/P2AD/W6MTcGOEFJ7?=
 =?us-ascii?Q?HkR4pgId/Ec9ZPd3/NfTps1tfZ9bToRzrrnMrwYQXGFHikey+dsnku/3m66X?=
 =?us-ascii?Q?oiS+RDHy7RJBa4PWLYw9umG4ZVPoXQurI28vEb68?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbae053-72ba-4d49-c56c-08db35159694
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 14:05:03.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WeNZz/8VSEANd6owUOKe4nl7K2NwFfBKAmrmDwDJ4Z4/gE8ZKuzn+wWPaFunF9x3XQdIVt14aSgrnKiTQnUryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6988
X-Proofpoint-ORIG-GUID: fC252vvT-aQIybF4ojxWVlR_whzWlhg_
X-Proofpoint-GUID: fC252vvT-aQIybF4ojxWVlR_whzWlhg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_06,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1011 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040131
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Mar 07, 2023 at 02:28:12PM +0300, Okan Sahin wrote:
>> Regulator driver for both MAX77541 and MAX77540.
>> The MAX77541 is a high-efficiency step-down converter with two 3A
>> switching phases for single-cell Li+ battery and 5VDC systems.
>>
>> The MAX77540 is a high-efficiency step-down converter with two 3A
>> switching phases.
>
>Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>But see below.
>
>> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
>> ---
>>  drivers/regulator/Kconfig              |   9 ++
>>  drivers/regulator/Makefile             |   1 +
>>  drivers/regulator/max77541-regulator.c | 153
>> +++++++++++++++++++++++++
>>  3 files changed, 163 insertions(+)
>>  create mode 100644 drivers/regulator/max77541-regulator.c
>>
>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>> index aae28d0a489c..f0418274c083 100644
>> --- a/drivers/regulator/Kconfig
>> +++ b/drivers/regulator/Kconfig
>> @@ -556,6 +556,15 @@ config REGULATOR_MAX597X
>>  	  The MAX5970/5978 is a smart switch with no output regulation, but
>>  	  fault protection and voltage and current monitoring capabilities.
>>
>> +config REGULATOR_MAX77541
>> +	tristate "Analog Devices MAX77541/77540 Regulator"
>> +	depends on MFD_MAX77541
>> +	help
>> +	  This driver controls a Analog Devices MAX77541/77540 regulators
>> +	  via I2C bus. Both MAX77540 and MAX77541 are dual-phase
>> +	  high-efficiency buck converter. Say Y here to
>> +	  enable the regulator driver.
>
>Maybe adding what would be the module name if M is chosen?
>
>>  config REGULATOR_MAX77620
>>  	tristate "Maxim 77620/MAX20024 voltage regulator"
>>  	depends on MFD_MAX77620 || COMPILE_TEST diff --git
>> a/drivers/regulator/Makefile b/drivers/regulator/Makefile index
>> ee383d8fc835..1c852f3140a3 100644
>> --- a/drivers/regulator/Makefile
>> +++ b/drivers/regulator/Makefile
>> @@ -68,6 +68,7 @@ obj-$(CONFIG_REGULATOR_LTC3676) +=3D ltc3676.o
>>  obj-$(CONFIG_REGULATOR_MAX14577) +=3D max14577-regulator.o
>>  obj-$(CONFIG_REGULATOR_MAX1586) +=3D max1586.o
>>  obj-$(CONFIG_REGULATOR_MAX597X) +=3D max597x-regulator.o
>> +obj-$(CONFIG_REGULATOR_MAX77541) +=3D max77541-regulator.o
>>  obj-$(CONFIG_REGULATOR_MAX77620) +=3D max77620-regulator.o
>>  obj-$(CONFIG_REGULATOR_MAX77650) +=3D max77650-regulator.o
>>  obj-$(CONFIG_REGULATOR_MAX8649)	+=3D max8649.o
>> diff --git a/drivers/regulator/max77541-regulator.c
>> b/drivers/regulator/max77541-regulator.c
>> new file mode 100644
>> index 000000000000..f99caf3f3990
>> --- /dev/null
>> +++ b/drivers/regulator/max77541-regulator.c
>> @@ -0,0 +1,153 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 Analog Devices, Inc.
>> + * ADI Regulator driver for the MAX77540 and MAX77541  */
>
>I believe Mark asked to have this C++ comment style as well.
>
>// Copyright (c) 2022 Analog Devices, Inc.
>// ADI Regulator driver for the MAX77540 and MAX77541
>
>> +#include <linux/mfd/max77541.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/driver.h>
>> +
>> +static const struct regulator_ops max77541_buck_ops =3D {
>> +	.enable			=3D regulator_enable_regmap,
>> +	.disable		=3D regulator_disable_regmap,
>> +	.is_enabled		=3D regulator_is_enabled_regmap,
>> +	.list_voltage		=3D regulator_list_voltage_pickable_linear_range,
>> +	.get_voltage_sel	=3D regulator_get_voltage_sel_pickable_regmap,
>> +	.set_voltage_sel	=3D regulator_set_voltage_sel_pickable_regmap,
>> +};
>> +
>> +static const struct linear_range max77540_buck_ranges[] =3D {
>> +	/* Ranges when VOLT_SEL bits are 0x00 */
>> +	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x8B, 5000),
>> +	REGULATOR_LINEAR_RANGE(1200000, 0x8C, 0xFF, 0),
>> +	/* Ranges when VOLT_SEL bits are 0x40 */
>> +	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x8B, 10000),
>> +	REGULATOR_LINEAR_RANGE(2400000, 0x8C, 0xFF, 0),
>> +	/* Ranges when VOLT_SEL bits are  0x80 */
>> +	REGULATOR_LINEAR_RANGE(2000000, 0x00, 0x9F, 20000),
>> +	REGULATOR_LINEAR_RANGE(5200000, 0xA0, 0xFF, 0), };
>> +
>> +static const struct linear_range max77541_buck_ranges[] =3D {
>> +	/* Ranges when VOLT_SEL bits are 0x00 */
>> +	REGULATOR_LINEAR_RANGE(300000, 0x00, 0xB3, 5000),
>> +	REGULATOR_LINEAR_RANGE(1200000, 0xB4, 0xFF, 0),
>> +	/* Ranges when VOLT_SEL bits are 0x40 */
>> +	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x8B, 10000),
>> +	REGULATOR_LINEAR_RANGE(2400000, 0x8C, 0xFF, 0),
>> +	/* Ranges when VOLT_SEL bits are  0x80 */
>> +	REGULATOR_LINEAR_RANGE(2000000, 0x00, 0x9F, 20000),
>> +	REGULATOR_LINEAR_RANGE(5200000, 0xA0, 0xFF, 0), };
>> +
>> +static const unsigned int max77541_buck_volt_range_sel[] =3D {
>> +	0x00, 0x00, 0x40, 0x40, 0x80, 0x80,
>> +};
>> +
>> +enum max77541_regulators {
>> +	MAX77541_BUCK1 =3D 1,
>> +	MAX77541_BUCK2,
>> +};
>> +
>> +#define MAX77540_BUCK(_id, _ops)					\
>> +	{	.id =3D MAX77541_BUCK ## _id,				\
>> +		.name =3D "buck"#_id,					\
>> +		.of_match =3D "buck"#_id,					\
>> +		.regulators_node =3D "regulators",			\
>> +		.enable_reg =3D MAX77541_REG_EN_CTRL,			\
>> +		.enable_mask =3D MAX77541_BIT_M ## _id ## _EN,		\
>> +		.ops =3D &(_ops),						\
>> +		.type =3D REGULATOR_VOLTAGE,				\
>> +		.linear_ranges =3D max77540_buck_ranges,			\
>> +		.n_linear_ranges =3D ARRAY_SIZE(max77540_buck_ranges),	\
>> +		.vsel_reg =3D MAX77541_REG_M ## _id ## _VOUT,		\
>> +		.vsel_mask =3D MAX77541_BITS_MX_VOUT,			\
>> +		.vsel_range_reg =3D MAX77541_REG_M ## _id ## _CFG1,	\
>> +		.vsel_range_mask =3D MAX77541_BITS_MX_CFG1_RNG,		\
>> +		.linear_range_selectors =3D max77541_buck_volt_range_sel, \
>> +		.owner =3D THIS_MODULE,					\
>> +	}
>> +
>> +#define MAX77541_BUCK(_id, _ops)					\
>> +	{	.id =3D MAX77541_BUCK ## _id,				\
>> +		.name =3D "buck"#_id,					\
>> +		.of_match =3D "buck"#_id,					\
>> +		.regulators_node =3D "regulators",			\
>> +		.enable_reg =3D MAX77541_REG_EN_CTRL,			\
>> +		.enable_mask =3D MAX77541_BIT_M ## _id ## _EN,		\
>> +		.ops =3D &(_ops),						\
>> +		.type =3D REGULATOR_VOLTAGE,				\
>> +		.linear_ranges =3D max77541_buck_ranges,			\
>> +		.n_linear_ranges =3D ARRAY_SIZE(max77541_buck_ranges),	\
>> +		.vsel_reg =3D MAX77541_REG_M ## _id ## _VOUT,		\
>> +		.vsel_mask =3D MAX77541_BITS_MX_VOUT,			\
>> +		.vsel_range_reg =3D MAX77541_REG_M ## _id ## _CFG1,	\
>> +		.vsel_range_mask =3D MAX77541_BITS_MX_CFG1_RNG,		\
>> +		.linear_range_selectors =3D max77541_buck_volt_range_sel, \
>> +		.owner =3D THIS_MODULE,					\
>> +	}
>> +
>> +static const struct regulator_desc max77540_regulators_desc[] =3D {
>> +	MAX77540_BUCK(1, max77541_buck_ops),
>> +	MAX77540_BUCK(2, max77541_buck_ops), };
>> +
>> +static const struct regulator_desc max77541_regulators_desc[] =3D {
>> +	MAX77541_BUCK(1, max77541_buck_ops),
>> +	MAX77541_BUCK(2, max77541_buck_ops), };
>> +
>> +static int max77541_regulator_probe(struct platform_device *pdev) {
>> +	struct regulator_config config =3D {};
>> +	const struct regulator_desc *desc;
>> +	struct device *dev =3D &pdev->dev;
>> +	struct regulator_dev *rdev;
>> +	struct max77541 *max77541 =3D dev_get_drvdata(dev->parent);
>> +	unsigned int i;
>> +
>> +	config.dev =3D dev->parent;
>> +
>> +	switch (max77541->chip->id) {
>> +	case MAX77540:
>> +		desc =3D max77540_regulators_desc;
>> +		break;
>> +	case MAX77541:
>> +		desc =3D max77541_regulators_desc;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i =3D 0; i < MAX77541_MAX_REGULATORS; i++) {
>> +		rdev =3D devm_regulator_register(dev, &desc[i], &config);
>> +		if (IS_ERR(rdev))
>> +			return dev_err_probe(dev, PTR_ERR(rdev),
>> +					     "Failed to register regulator\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct platform_device_id max77541_regulator_platform_id[]=
 =3D {
>> +	{ "max77540-regulator" },
>> +	{ "max77541-regulator" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);
>> +
>> +static struct platform_driver max77541_regulator_driver =3D {
>> +	.driver =3D {
>> +		.name =3D "max77541-regulator",
>> +	},
>> +	.probe =3D max77541_regulator_probe,
>> +	.id_table =3D max77541_regulator_platform_id, };
>> +module_platform_driver(max77541_regulator_driver);
>> +
>> +MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
>> +MODULE_DESCRIPTION("MAX77540/MAX77541 regulator driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.30.2
>>
>
>--
>With Best Regards,
>Andy Shevchenko
>

Hi Andy,

Should I change comment style to C++ comment style for whole patchset?

Regards,
Okan
