Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421865B8DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiINREX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiINREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:04:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770DA844D0;
        Wed, 14 Sep 2022 10:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUyDBq+h4gJP5/YJNbAPIPu3C3wL/x4vMoGCFENNU9ilmHOC2nP49dpGDEYpjj6OUguSns9alUZUUbIbQ7Ee3mFDBi4texiZhPIwLU3DBGQsLvK6XJfnRJ8/aPfkxzZhZZFqc/nX2Gi1qvUhZHsK/Fo8t44R1H/JjixjG+x0Ef+gwqW98CYq6tFmWkbg2ujVI1qXe/qdnVrWvqtS6h68kmIWkBTfVS2s/+tTfEpk2guLL2+L4pHWGDCLuhHG1Pgn8DtkZHYrWd9kUs7z9K3RIEpO7KGERpeTej/EOo/8OMKAwPiN3Sv2AgoAyXpPdzfI12yjUGPoTN/fASSGO7Faog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFn6PMsLkrihjcMdK9cQ4NrfNLrksYlBtG7x9oZuC6M=;
 b=BmCZBUsIVYlJsnqZB4ZZdPWwi+pBC30txrG3LcvF23iowwjj5siUcHGE5GNiUO87PtXLk32scPzHwceBOu3iqcm3lUjyDqHyHyoDlmADRSIBVvoA5OJ1jgj5d7MuxQq4+sy3q6Tt4V7tNDtojh8WjCMRxhxu2nTNf9iddZKYJF6Hd/d4HUIm66L6r8fsq/4H/JxsPhDgMaIe8MJeRawttYFCWGHvuDxWY2s5bpuQ7rem6Fx0bqdBozm8EEWlcQvNlevUM353u8brKpHWKv9egpwG9gwXbckGS0WVQBVBrF60iS6Ip+bx2UvTVcv+KHbFny6f5jJGXFv+Q2JWa4sDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFn6PMsLkrihjcMdK9cQ4NrfNLrksYlBtG7x9oZuC6M=;
 b=QMEXZNHS6Cbpd2cSy8/SDvMq0G1SEA8dBrcpdO77f4viFrtDMWmyoEXfWdwUfWPMjPI1shAkG0PKl6FZ8jxAQsEDL8EoBd3Ek0fm67+qa1GjkvBGiyRipnSX9YnsGTyfO9AOYLrSFcYsmgxWH6pSVP1LUC8fQnJmKSE/5UQyNIc=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:03:40 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:03:40 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        "Larson, Bradley" <Bradley.Larson@amd.com>
CC:     Brad Larson <brad@pensando.io>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 12/17] spi: dw: Add support for AMD Pensando Elba SoC
Thread-Topic: [PATCH v6 12/17] spi: dw: Add support for AMD Pensando Elba SoC
Thread-Index: AQHYtM9FM9muhs4ErEO9IKdWE4XmXK25q0sAgA+zMACAEU40gIAEoY6A
Date:   Wed, 14 Sep 2022 17:03:40 +0000
Message-ID: <2f53b4be-7e94-1941-3e33-35b14b06decc@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-13-brad@pensando.io>
 <20220821181848.cxjpv2f4cqvdtnq3@mobilestation>
 <4aab1595-53a6-32af-8cfb-90f5e258d29e@amd.com>
 <20220911182021.i5go6lfsedggq6wl@mobilestation>
In-Reply-To: <20220911182021.i5go6lfsedggq6wl@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2401:EE_|DS7PR12MB6094:EE_
x-ms-office365-filtering-correlation-id: f19cf26f-b69c-4dc1-c0ac-08da9673128e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BJzjmMcejdzGBiCDKKbkn/g0nrm0T4bcdED4ysaR+imFxzM29LE9S6QUoZgcAbuwO8yNdgsyPM51g3d0ZOY1iR6DM8xamWvXd4C49oTdMafzs4psMOAKg0igDET7dfD3COFFnVuwiVJO5LRoU/kIIiy7T+nLkHMPKokmYk7Zqm7mMkqF6WDXY9z+T2kXVwsqR3k1IpUL/T7i6HpyyIFl1VcJO4hkC+T5p2ZCm02dS5q96kuvdfwAHDwh9DFDXRZGS6borQTy4DdbDa7A6ZBjgAYmUYFU0wX/zQBucCLZXBmA0u1HCHnBy50iW+DSQcWdlTgIOc9juoJk+3Ps9NDRyTqp56G8skjOE0hyrWxkCU/Kd/bOCdAQ6HDyqIGhPgm8rkZgHyTRi2u0bN0+Uv9XWnCPUDCeCSky+BQpmio+xL2L0h4JGBt98hBLhi1rmWO25+8Y5ZKWgpEYkTvNCOT/SG/m+WH9e1Fx/Q5xy7Vys5VXkOYPv5G2ZD12P5enhEXtoDIsvV6WvPWtiVfV+gB/Q59+HA+eOJweS59WHwUfFc6pE11EDJaVXcYxKoZcGL2U0XlNq5vkJHbhfwBhQzgboQI3HkaBCs4Ccma2gB9sQY6MUo3T1tUbjCvdWcVeTbMsQAa2KLWb30DqmAaw8GhIoLdh7UF2kvDYxU0wGbuWEl5XQ8KDZUQaTwZos0GvF+iECpJpuZiQxbzrqryME1saBDX68NTaBb317SsJ1tE5cOptcsLeLTslEEJVP6g8rHhshpLGfMqhXt1FNPpZdPuoG+k71qSdB0voE9yY6BlHItonhm/jHMvL254H6TIxrEpU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(36756003)(38100700002)(31696002)(31686004)(86362001)(122000001)(38070700005)(53546011)(6506007)(2906002)(7416002)(478600001)(41300700001)(966005)(6512007)(2616005)(6486002)(186003)(83380400001)(71200400001)(66946007)(4326008)(91956017)(5660300002)(76116006)(8676002)(8936002)(66556008)(316002)(64756008)(66446008)(66476007)(54906003)(110136005)(45080400002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkNqVzFWOGw0UVdkanFxTVVFa2U2Wis1YlhBaDNBanFXUENHTDNpZ1dWMmd2?=
 =?utf-8?B?V0dmclFXcnkyeEYyWEg0eTZtUFZpYWV4aVdEODY4N0FEYWZ2dmVJR29jL1ds?=
 =?utf-8?B?K0NPcFh0YzFlNjd0K2Nqa1E4QXdRb3h4Y3lxZkNSRFA3azZlU0o0Wm5qdW5E?=
 =?utf-8?B?SjlWL1VYd1pDRWJOU3g5S1RoWXFQdTQ4UU9mbHFqTm1JdTA0UllQOVJ1RExh?=
 =?utf-8?B?S1lIWTZwUjh1ZTlIWHZZLzhOR21NMVpmMFFtalhodzNMeHlwV2EwVFQ0azlv?=
 =?utf-8?B?TTJiRlNiK3JabkJCQmdLNy8vNWg1SmFxcmQycTVHcktvWEVMUUZVb2dVMWlI?=
 =?utf-8?B?Yk1EY05NV21majBRSHcxK0l6VEFhVG9EK2k0RFdtRXQzeVRSNStJTlNhZVdD?=
 =?utf-8?B?YzE0SGlqUWgzYUI1a2lzdjhHWG5EZUlSUTc0OW1raUp5OHVFcUZLMm5EcEhp?=
 =?utf-8?B?MjIyNkRPNDE1YjZWR3BwTXVXeEJpY09MNEk1KzVvZExTcGtlSHRqQy9KWEI2?=
 =?utf-8?B?UlMwdHBPRENBNDdxNVhzZVBmaFU1cWhUTWVwOU00V2w3YnVQcmZkYVRQQk1X?=
 =?utf-8?B?Y2pGblBnbkRCVVZ3V2ZGT1ovODBtb2JkVlFBSFh6dFc3dEY1eG45T00vWDB4?=
 =?utf-8?B?NEZUYnVLaXM3d0I3VnZCd0wwaXJ1YkdOTm5Yd1M5VFVPNG9BOExEZ0xDM0hZ?=
 =?utf-8?B?MU9pYmJxYU95S3huUnpqQTBMMC9iMEpzKzVVY09yU2pzdi9pd2RrbEMrajBh?=
 =?utf-8?B?SkZqcVJkOTFTQXA1dEdjVWhYblh0N3hKYzJqQUR0czByRVFPS0lTQ1Z0K1Zt?=
 =?utf-8?B?OGZ4WUJtQlY1L1lNbmcwMytaY1F3NG54VE9DemdsT01xWkFaSmp0MVpqbHBi?=
 =?utf-8?B?L2p5OEJxNDZWRHI0Y21zNjE5cmhZSERUTCtxNXM3Z2ZReU1FLytKUnBBZmlm?=
 =?utf-8?B?RytoMTZacVEvd0prbnYySTBUaTFLaEVnck5qSmY3SzJJWGcvaFNVSFB6UDlk?=
 =?utf-8?B?ZmNjRW15RUtOWnZqNjVGalAwUXRuazNWb0FwSGcwTmZiYlZPY1p4dFVNMEJP?=
 =?utf-8?B?ODd1S0VQWEdFY1cxVWJWK2xaVXNTT05zS3J5K21TZ2QrTXJWay91cENwdnRw?=
 =?utf-8?B?a1lSSERDM28vRmJqaUh3VkxWWE1UME92eGV6dkluZnIrU3hhTGdmRFV4VTBj?=
 =?utf-8?B?QVZvbW9lZTN1V2Y0emFFTVRiazJLSlVnMGxRU1dmMnMvYldGY3lmTHVuL2Z5?=
 =?utf-8?B?TVp4TnNJa1hEanZ0Z0h5VW1jRlNQelhuM2JVTjA2cGlsd0dMcHQ5VGdnMmtD?=
 =?utf-8?B?NFNPQ2ppRHArUUk0ZFpUOTAxTUpHUEJOc3paVXBUZ2xyUUFPZkJKMUVscXYv?=
 =?utf-8?B?YmtONVpreVhwUzZHUDkwaHlWVXJ5aStzaXV4SXE1MThkUW4ySmZ3Y0F6SWVK?=
 =?utf-8?B?OGovNGdueGxvejNJRWNKcGRncmptdTAzUk5wU0dLcEZHVmFqQjVRNnFwUHND?=
 =?utf-8?B?cWREL0x6Q2dEVFBhcFo3aUZrQUN5N0Zhb1MwWmlRa3Y2RlAzdksxa1lwMzJP?=
 =?utf-8?B?OE43N2RLaEhkZHFDV0M3SFNFMVIwcmpkZWg5YVpxQ1htQThwTWxrZ0U2Nm05?=
 =?utf-8?B?M01XZnI1blNWNis5ZGFMYXVhUThCVjFqMTZrUVJNWllJTW0wOFVVVnpuYm1t?=
 =?utf-8?B?T3ZqOHJnT0swMXJMNTFJb0ZaaG9PdVRWakx5TEJ2MHJybGwwNy9SanVvSlVB?=
 =?utf-8?B?N1BycUo0bHM0cTVRUDAxK0JXT2tVeUdKbksra2VUTE1hSVFPdVBQbGFicVda?=
 =?utf-8?B?MWtUZU5CdjFubVpJSUs0dUhMNDVUT2dwMzNBUXhJYnJvQW01UzlpYVBOMW90?=
 =?utf-8?B?L3F1RWdSNkdpZ2ZvU1MweGJSTERFaWtaNjRRMUVVcTZwRGR6NEVmZUgzUjF0?=
 =?utf-8?B?bHJhT1RvalVRdkRROFU0WG03YTVvTmk4SzFlR0czQVFBa2s1cUhZMlE4OUFM?=
 =?utf-8?B?R0FzWXJtcHgrRktyenVoTVZTVHFjMzhmSFhIYk8zL0FxYWtCbTRnOUxVcVFa?=
 =?utf-8?B?SHVSRVAzMHpZWVNxVGxSc1NLekcxUlAzdCtDVlFWcHhNQzVobHRkVlB1RWtp?=
 =?utf-8?B?WFpVK2JEcjdwRzR4cHpUZStFOVhHc2xGQXVJcmM4NXdIem5oM1YxVXRRb0tZ?=
 =?utf-8?Q?ZDl7E8b60tSXqHJvnxYj6vw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83D987D07B463F44908F6BFA03E0CA52@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19cf26f-b69c-4dc1-c0ac-08da9673128e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 17:03:40.2472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVs0fbAWCOC/uVZrVpccS7FE+4vnse/2iGGi6id31amQEtyl00UVCbs0ABpPO3FR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMS8yMiAxMToyMCBBTSwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDMx
LCAyMDIyIGF0IDA2OjA0OjAyUE0gKzAwMDAsIExhcnNvbiwgQnJhZGxleSB3cm90ZToNCj4+IE9u
IDgvMjEvMjIgMTE6MTggQU0sIFNlcmdlIFNlbWluIHdyb3RlOg0KPj4+IE9uIFNhdCwgQXVnIDIw
LCAyMDIyIGF0IDEyOjU3OjQ1UE0gLTA3MDAsIEJyYWQgTGFyc29uIHdyb3RlOg0KPj4+PiBGcm9t
OiBCcmFkIExhcnNvbiA8YmxhcnNvbkBhbWQuY29tPg0KPj4+Pg0KPj4+PiBUaGUgQU1EIFBlbnNh
bmRvIEVsYmEgU29DIGluY2x1ZGVzIGEgRFcgYXBiX3NzaSB2NCBjb250cm9sbGVyDQo+Pj4+IHdp
dGggZGV2aWNlIHNwZWNpZmljIGNoaXAtc2VsZWN0IGNvbnRyb2wuICBUaGUgRWxiYSBTb0MNCj4+
Pj4gcHJvdmlkZXMgZm91ciBjaGlwLXNlbGVjdHMgd2hlcmUgdGhlIG5hdGl2ZSBEVyBJUCBzdXBw
b3J0cw0KPj4+PiB0d28gY2hpcC1zZWxlY3RzLiAgVGhlIEVsYmEgRFdfU1BJIGluc3RhbmNlIGhh
cyB0d28gbmF0aXZlDQo+Pj4+IENTIHNpZ25hbHMgdGhhdCBhcmUgYWx3YXlzIG92ZXJyaWRkZW4u
DQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiAgICBkcml2ZXJzL3NwaS9zcGktZHctbW1pby5jIHwgNzcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCA3NyBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9z
cGktZHctbW1pby5jIGIvZHJpdmVycy9zcGkvc3BpLWR3LW1taW8uYw0KPj4+PiBpbmRleCAyNmM0
MGVhNmRkMTIuLjM2YjhjNWUxMGJiMyAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9zcGkvc3Bp
LWR3LW1taW8uYw0KPj4+PiArKysgYi9kcml2ZXJzL3NwaS9zcGktZHctbW1pby5jDQo+Pj4+IEBA
IC01Myw2ICs1MywyNCBAQCBzdHJ1Y3QgZHdfc3BpX21zY2Mgew0KPj4+PiAgICAgICAgIHZvaWQg
X19pb21lbSAgICAgICAgKnNwaV9tc3Q7IC8qIE5vdCBzcGFyeDUgKi8NCj4+Pj4gICAgfTsNCj4+
Pj4NCj4+Pj4gK3N0cnVjdCBkd19zcGlfZWxiYSB7DQo+Pj4+ICsgICAgIHN0cnVjdCByZWdtYXAg
KnN5c2NvbjsNCj4+Pj4gK307DQo+Pj4+ICsNCj4+Pj4gKy8qDQo+Pj4+ICsgKiBFbGJhIFNvQyBk
b2VzIG5vdCB1c2Ugc3NpLCBwaW4gb3ZlcnJpZGUgaXMgdXNlZCBmb3IgY3MgMCwxIGFuZA0KPj4+
PiArICogZ3Bpb3MgZm9yIGNzIDIsMyBhcyBkZWZpbmVkIGluIHRoZSBkZXZpY2UgdHJlZS4NCj4+
Pj4gKyAqDQo+Pj4+ICsgKiBjczogIHwgICAgICAgMSAgICAgICAgICAgICAgIDANCj4+Pj4gKyAq
IGJpdDogfC0tLTMtLS0tLS0tMi0tLS0tLS0xLS0tLS0tLTANCj4+Pj4gKyAqICAgICAgfCAgY3Mx
ICAgY3MxX292ciAgIGNzMCAgIGNzMF9vdnINCj4+Pj4gKyAqLw0KPj4+PiArI2RlZmluZSBFTEJB
X1NQSUNTX1JFRyAgICAgICAgICAgICAgICAgICAgICAgMHgyNDY4DQo+Pj4+ICsjZGVmaW5lIEVM
QkFfU1BJQ1NfU0hJRlQoY3MpICAgICAgICAgKDIgKiAoY3MpKQ0KPj4+PiArI2RlZmluZSBFTEJB
X1NQSUNTX01BU0soY3MpICAgICAgICAgICgweDMgPDwgRUxCQV9TUElDU19TSElGVChjcykpDQo+
Pj4+ICsjZGVmaW5lIEVMQkFfU1BJQ1NfU0VUKGNzLCB2YWwpICAgICAgXA0KPj4+PiArICAgICAg
ICAgICAgICAgICAgICAgKCgoKHZhbCkgPDwgMSkgfCAweDEpIDw8IEVMQkFfU1BJQ1NfU0hJRlQo
Y3MpKQ0KPj4+IFBsZWFzZSB0YWtlIHRoZSBAQW5keScgbm90ZXMgaW50byBhY2NvdW50Og0KPj4+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmxrbWwlMkZDQUhwNzVWZXgwVmtFQ1lkJTNEa1kw
bTYlM0RqWEJZU1hnMlVGdTd2bjI3MSUyQlE0OVdabjIyR0ElNDBtYWlsLmdtYWlsLmNvbSUyRiZh
bXA7ZGF0YT0wNSU3QzAxJTdDYnJhZGxleS5sYXJzb24lNDBhbWQuY29tJTdDOWU3Y2FkZTgyMzM0
NGI3MmYzNDYwOGRhOTQyMjRkYzYlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3
QzAlN0MwJTdDNjM3OTg1MTcyMzM4MjkzNzM5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
MCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPXVzUUhXeU94YW9ENmlhc1AyUjlWTDVpMFpr
U3pCYmRwc1BsakV4SGVtZkUlM0QmYW1wO3Jlc2VydmVkPTANCj4+IFllcywgSSBoYWQgYSB0ZXN0
ZWQgY2hhbmdlIGZvciB0aGlzIGJ1dCBtaXNzZWQgYWRkaW5nIHRvIHRoZSBwYXRjaCB1cGRhdGUu
DQo+PiBUaGlzIGlzIHRoZSBjaGFuZ2UgYW5kIEknbGwgcmVzZW5kIGp1c3QgdGhpcyBwYXRjaC4N
Cj4+DQo+PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktZHctbW1pby5jDQo+PiArKysgYi9kcml2ZXJz
L3NwaS9zcGktZHctbW1pby5jDQo+PiBAQCAtNjYsMTAgKzY2LDYgQEAgc3RydWN0IGR3X3NwaV9l
bGJhIHsNCj4+ICAgICAqICAgICAgfMKgIGNzMSAgIGNzMV9vdnIgICBjczAgICBjczBfb3ZyDQo+
PiAgICAgKi8NCj4+ICAgICNkZWZpbmUgRUxCQV9TUElDU19SRUcgMHgyNDY4DQo+PiAtI2RlZmlu
ZSBFTEJBX1NQSUNTX1NISUZUKGNzKSAgICAgICAgICAgKDIgKiAoY3MpKQ0KPj4gLSNkZWZpbmUg
RUxCQV9TUElDU19NQVNLKGNzKSAgICAgICAgICAgICgweDMgPDwgRUxCQV9TUElDU19TSElGVChj
cykpDQo+PiAtI2RlZmluZSBFTEJBX1NQSUNTX1NFVChjcywgdmFsKSAgICAgICAgXA0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgKCgoKHZhbCkgPDwgMSkgfCAweDEpIDw8IEVMQkFfU1BJQ1Nf
U0hJRlQoY3MpKQ0KPiBXaHkgZG8geW91IHJlbW92ZSB0aGVzZSBtYWNyb3M/IEp1c3QgcmVwbGFj
ZSAweDMgd2l0aCBHRU5NQVNNKDEsIDApLA0KPiAweDEgd2l0aCBCSVQoMCksICgyICogKGNzKSkg
c3RhdGVtZW50IHdpdGggKChjcykgPDwgMSkgYXMgQW5keQ0KPiBzdWdnZXN0ZWQuIFVzaW5nIG1h
Y3JvcyBmb3Igc3VjaCBjb21wbGV4IHN0YXRlbWVudCBpcyBhIGdvb2QgcHJhY3RpY2UuDQo+DQo+
IEFsc28gcGxlYXNlIHJlbmFtZSBFTEJBX1NQSUNTX1NISUZUKCkgdG8gRUxCQV9TUElDU19PRkZT
RVQoKSBzbyB0bw0KPiBoYXZlIGEgbW9yZSBjb2hlcmVudCBDU1ItcmVsYXRlZCBtYWNyb3MgbmFt
aW5nIGluIHRoZSBkcml2ZXIuDQoNCg0KWWVzLCB3aWxsIGFkZCBiYWNrL3JlbmFtZSBtYWNyb3Mg
d2l0aCB1c2FnZSBvZiBCSVQoKS9HRU5NQVNLKCkgYW5kIA0KcmVzZW5kIGp1c3QgdGhpcyBwYXRj
aC4NCg0KUmVnYXJkcywNCkJyYWQNCg==
