Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A744D5F00F9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiI2Wu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiI2Wuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:50:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB8B10CA66;
        Thu, 29 Sep 2022 15:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKi6DShRm3OI2thVQA1VuyP71ssBwiOIR6dINR7kERpOTCgDmLlPB57yuhxO2xCmrRMxrU4gmVJ7Z4xrJVMBrNSPTdxbnCGYyugm2sHAee2vdciHw16ZWNdGXSe4ZGWgsvPq89qKylCp9NhoPzM+2JSLLlQqRLNNhgFHQfOxI/yKkPIh6CRIBs1/kvDifWRsn4nJRnIUUl1p3sxCRfYJs2k5vqYBr+koyPWqOPFrV88AaOCstv0BnXLsQp6M9b7q+u6Kkt3mgeni3D6J4uEZe2VRw1bZ0dqdnj+m0d1icQGFESynogkWLDdo+R1818qOJ6wmckmDuhbuoB2TVnIKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Meu8iyP/u5eWmxG08l6HIpmM4GhPqQncPIzcDNXO8=;
 b=DqJ7WN/tqEYK88U6lnfG0tiL9ueck3LVZdSmzeNL+Y3YtFASCVqsZls0IXvtJiW5V9zsXWs8LAJlMInIDY6O6DW7CByn2T0owYhJWmT631LnwqPstU1igO9gWxebakHIKXdhEhWbUeM4Cn7mbsOdg/KvbiL+gdYZhzsCFYARKobxgbnaO9Lyc3mRhovoDczzfTVXSLnxqoqJa3rpKU0XxkkPNxSZMzq8nuxqe9QazxLrjXlJT2WNRiPVNt83CDFlWgtPjJHWym3MnT9WDpYYEzfAaOpYGm3bND8x7x4w0EZSMMnpKRdoQVzqTKULfWE7P7SRO5NHGBxGIT+CGvXWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Meu8iyP/u5eWmxG08l6HIpmM4GhPqQncPIzcDNXO8=;
 b=Qwad5fmb0em+81hr+yj0k709+gI2mDhZnX/Tfn0/lY6CRtsYBkLPPGNrcy8sJmpxHSssJbznMlHSyIt8YdbXPfflWKEziztHweECtdSDActnWP+Y09T3DsiS3s+oNjIF+gB9eHKqRKkPGWeCCkiDh9s2CYAAGFepJLK2EUKRofk=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 22:50:43 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::b9ee:95e9:e8aa:7853]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::b9ee:95e9:e8aa:7853%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 22:50:43 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Larson, Bradley" <Bradley.Larson@amd.com>,
        Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Thread-Topic: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Thread-Index: AQHYtM86gXzQRkjAqk6/46/G7K6NoK26/IIAgA61EQCAAItaAIAA3uMAgApmjwCACIuFgIAD7Y+AgBVGvAA=
Date:   Thu, 29 Sep 2022 22:50:43 +0000
Message-ID: <8ce3ee59-bc37-ea97-c94d-b6f4f9c28751@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
 <20220822142544.GA3770388-robh@kernel.org>
 <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
 <936c5623-07b9-c49d-e113-fc056a4eb9bc@linaro.org>
 <b064ed4c-d5a7-614f-008e-61ff2ac27f88@amd.com>
 <0852ffa5-9996-0f42-c5a8-d1fe9d39887e@linaro.org>
 <9a98d026-7f70-a69b-64de-c77419888e42@amd.com>
 <9e006307-f7c7-c68a-e5c3-d0d0b2807d87@linaro.org>
In-Reply-To: <9e006307-f7c7-c68a-e5c3-d0d0b2807d87@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2401:EE_|BY5PR12MB4241:EE_
x-ms-office365-filtering-correlation-id: 66e38c38-f84d-4b5a-4508-08daa26d0a5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fs277G6rIqusDDbNUZMr1+XIjLXH2dZ5HbMvSRGf4XyjdxNRhNQ5IdJmI/XqGziH2LVb/eOz+pG4xTLWSzHeTNABzrGoweqjhSzPm9bpOEmME/04ZfJJR4tpDw8/pERdpgIhRnMKmnoWAakkg9frhYAIaQz2gi0f/rSCp2/WAYrJ4ilRbU4aaGIn/CTR2ZORoiU3MdyZ8/nlxPrO+nov38sJMwD42TthJxoVQ6QMba2jxSHNxWFjdC9nNh213PXiI18KfrO1wjnvUDsrjpFkMnGnAJ+lxnmkVPHrG3H5FU3EyCFv8fveRFXm4FADWtDTw50Pruz7GkaEqjjycQfIMrOLBlrb3YsIl/qwB5feJ2A6g05qPFGQUvkbuRkL4OzWk8PhqN+GlAVX0nEGZymJatvftjKjmM77CKtpqwDxlaeTQ0zR0tb4CQoYRUxeWuxwhYyRc8Axc/Cp1vigPxFbND5JwAz3ea05ZW8Fg+V7l1YmbaMreYPzLx1mXvx2YKqR5qKifIfBvDRI3I5IJn098dSkY/YRclOmxNzfBwkrAvNR0MrwTLHXBh8bqVi9OwlGiNb4VtvwDqJiQIthvMlJ8ZbpEiAbnt6/UcCpKN6jnHtWSvJicLDzcfzFhZi7tqoHDxbGDTyk6hGIZTT6EhKDVk0mVS9QNGZ9XCY4NAzEQXRXpi2V4d2V9lp1FbjnbfyZI7X0Mkc0yO4kBmlG5hwfRtdc1lzR0sU3gUK67SZk7RsTm+wXXpdfGqmg+0aiA0X1+Qhhk84FM3VB8bKEV3QZX2hG2oPAPw6xU+a29v1t5pQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(4326008)(478600001)(31686004)(6486002)(71200400001)(66556008)(64756008)(66476007)(66446008)(122000001)(66946007)(6506007)(91956017)(186003)(53546011)(76116006)(7416002)(36756003)(5660300002)(2906002)(6512007)(110136005)(316002)(26005)(54906003)(8936002)(38070700005)(83380400001)(86362001)(8676002)(2616005)(31696002)(38100700002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUVvL044bjMrREZsTzBteGRsUDhIZE5ubkNhZ01ZckxXVGFXdTVsR1RkQ0hI?=
 =?utf-8?B?QVVvbDNIZ21DK2lpS3lpTFd5NGVVekJVWGhCZ0JRT0s2c3lndzNyWVg4T3Fz?=
 =?utf-8?B?TjZWd0xCR3lrcXd5S2NHN3hsamdsbkt4YVlKVENFVGdGcHZ0dWk4REY0aUZp?=
 =?utf-8?B?ZWRaTS9BZVIvUjhIQjFlQTlwVlVCK1ZvVGJxbXQwb0hZT1lSR0VtZktqMGM3?=
 =?utf-8?B?eEJwRnFoaEdDVXhtcFh6TzcwcWlVYnlHWUh5RjZVNWlMb1RTT3l0SmtBU2VX?=
 =?utf-8?B?YnBLRDJZeHp2cjhIUzBmUnhCSm9XRnpmK3pSYTB5NTN4dzczSyszM0tDU1hp?=
 =?utf-8?B?bW1oQ2FsSzV3aU4yWmRiOTBBWXNRSjRqY1p1NDgvYnNJM2lZcFAxd3NRdFRQ?=
 =?utf-8?B?dmc0cjVNUGhwVmc1VWkvNmdybHV5blZCYlduRVdIUmhJdHIvU0R5ZmxTNVJv?=
 =?utf-8?B?V3BsZC9OanB3RnVBUjFkdTdwc2xINlQ3bUFWQ3hIeVlDdTFvaWc1TVlQQWtp?=
 =?utf-8?B?aHFwOFIrSTRlc1Q4eXRsK3Y0ekhXcXBPT3prSXppUTQrOVlNbHFaVCtrUi9Z?=
 =?utf-8?B?KzFZMVdaV2FVcXhvTWFuOE9RQ0MxbUl2Z3ZpanZhUldlK2k1OUJCQ3JjUEZv?=
 =?utf-8?B?ZXZUWmt4YjYwQnpjMkIzeWFOOHVNbTRiV1NxbEZ0YWJabnZkclc2NGhQZGFR?=
 =?utf-8?B?MXFHeHNicEpvWVhrejVwQ3ZDeVN0YVU5MTQzUElScGcyWURWSENUaTkwTE80?=
 =?utf-8?B?YzFDbG9nSmtUckJmMUFjcDNlUjlNdWUzQXlKZ2lrUUlyZEZzUTlqTk5uWmJp?=
 =?utf-8?B?MXNKV0VPK01mbkRyNXV0UUN5ZW1VclBsRjhicUdjeGdqSWxrbHVCV29Gejg1?=
 =?utf-8?B?YXY3TVM4czhqVFZoalZrSnJWcEh5OHdXbTVBQ1JQdDBCcUJia0p6d3gweDJQ?=
 =?utf-8?B?UDlFOW1LdW5VQzI5dHNpZXVaWlVQSVNReW53dHlBNGxDdHZEWGtZRER6cWNa?=
 =?utf-8?B?K1NHWnpsclBDU2w2d212UDlkMmFwRlNYS1pEUmpDTzdZNHJEM2Era3J1cGRu?=
 =?utf-8?B?WFp1YVI5ZGw3RzVtYVJQZC85QWg1c3ZJVEpFM1FYV2VIN1RtajM5U1BueTBM?=
 =?utf-8?B?cFZoVlIwSUpXK3ZXOUxVa2loeUtNR29aZWZ5OU1ZVE5Od1FaYVU5ekNIWk1k?=
 =?utf-8?B?V01hNWR1ZUVZRW5yQkpxL0l2U3FsOFlBUVRXSlRKUXF0M1hFRDNFY250Mkl2?=
 =?utf-8?B?UUI1ajJ3WGZSdzU0Q3lCMDVwUmF6U1Rmd2pkYWVaRllTdkZ4S2xvMU03VjF0?=
 =?utf-8?B?R1lxNENYbDVhU2Y5azNRSWVLNkhLSTZEb2JvejlsNTloZWV0VUR6b0EwY2sr?=
 =?utf-8?B?NWZsVWxLSWVPY2VtNlNNU096SU9kc2NrV3VLbVhYTUpMQ1lKdmJvY3hDdCtO?=
 =?utf-8?B?QzZkbDg4RzVKL1lWTHJnRXJIdzNQNi9oRGVMZWlndUVxcjlEYXhQaW1ZV2ZI?=
 =?utf-8?B?VzZ3Wm5vMGFhUW5VTkFIUE5uZm00N0MxTEhJUXJuODRCVjU3SlE5YlFyVy9x?=
 =?utf-8?B?dmlkVzA2WWV3ODFwRzE0Qk02UFErZ2pIMEs1UDVHZTNweXNFVjErZ25Hb3Nq?=
 =?utf-8?B?NkZsN0VUQWRvdkptTlg3clNzc0JPWXQ1d2pVOW9QQnpSZWh0cUltRkt1bWhi?=
 =?utf-8?B?SVh3eVpxcnBkaTM2eGxXb1lzK0Y1cGpFSFJiWVBLQ2NzZXBVMlpTSTc4TWZi?=
 =?utf-8?B?RnIyemJmK3psc3piblNlMXd4c1k5dUNHUWJMaHRkSVZDSFV2NUVudHBob0Rr?=
 =?utf-8?B?TzhiYlYxVTNpY1JEQ24vK29mYVVDVS8ybVhZSkUrc1Q5VDdYejhMNVpLd2Fm?=
 =?utf-8?B?U0JLRUJIQVRaWkhpMVcvT3A1Q1pnTVRtc1Evclh0ZlYxam10cmY4WjJlYlRp?=
 =?utf-8?B?OW5BMU90amJMaWVqMU1yV2xzc1ZEM1UySHNITWtsT05DQWZZcDhNZUFDTmVP?=
 =?utf-8?B?eTlXSldxNm91RWhqTFpOVHFkd1grMzkxZU9FSXZIRm9CejloQmI4QXZBWkdn?=
 =?utf-8?B?MFdsYkpzWWVqaFdZWmNJSEswVyt0d2lVVFM5cll5YXBqRmhQbE1EYWZnUjdN?=
 =?utf-8?Q?RfeU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A4E5B49E95BB2429A97F175D8FF0227@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e38c38-f84d-4b5a-4508-08daa26d0a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 22:50:43.4922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8nItwFSZslWmkal2o0U/YQ7SdxffukwX7+2b5/CkymJhKR3JrjRjFcZZElDMh0v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMiAyOjU2IEFNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBDYXV0aW9u
OiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHBy
b3BlciBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9y
IHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIDEzLzA5LzIwMjIgMjI6NTcsIExhcnNvbiwgQnJhZGxl
eSB3cm90ZToNCj4+IE9uIDkvOC8yMiA0OjI3IEFNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3Rl
Og0KPj4+IE9uIDAxLzA5LzIwMjIgMjI6MzcsIExhcnNvbiwgQnJhZGxleSB3cm90ZToNCj4+Pj4g
T24gOS8xLzIyIDEyOjIwIEFNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+Pj4gT24g
MDEvMDkvMjAyMiAwMjowMSwgTGFyc29uLCBCcmFkbGV5IHdyb3RlOg0KPj4+Pj4NCj4gV2FpdCwg
Y2FuIHdlIHNraXAgdGhlIGRyaXZlciBlbnRpcmVseT8gSSBhbSBub3QgcmV2aWV3aW5nIHlvdXIg
ZHJpdmVyIA0KPiBhbmQgd2hhdCBpdCBjcmVhdGVzIHVuZGVyIC9kZXYuIA0KDQpZZXMsIHNlZSBw
cmVjaXNlIGFuc3dlciByZXF1ZXN0ZWQgYmVsb3cuDQoNCj4+IEluIGNvbXBhcmlzaW9uLCB0aGUg
cGVuc2FuZG8gZGV2aWNlIGlzIGFsc28gb24gdGhlIG90aGVyIGVuZCBvZiBzcGksDQo+PiBmb3Vy
IGNoaXAgc2VsZWN0cyB3aXRoIC9kZXYgY3JlYXRlZCBmb3IgZWFjaCBmb3IgdXNlcnNwYWNlIGNv
bnRyb2wsDQo+PiBhbmQgb25lIGNoaWxkIGRldmljZSBvbiBjczAgZm9yIGh3IHJlc2V0IGVtbWMg
dGhhdCB0aGUgTGludXggYmxvY2sNCj4+IGxheWVyIGNvbnRyb2xzIChzaW5nbGUgYml0IG1hbmFn
ZWQgb25seSBieSBrZXJuZWwpLg0KPj4NCj4+IFBlbnNhbmRvOg0KPj4gJnNwaTAgew0KPj4gICAg
ICAgICAgIG51bS1jcyA9IDw0PjsNCj4+ICAgICAgICAgICBjcy1ncGlvcyA9IDwwPiwgPDA+LCA8
JnBvcnRhIDEgR1BJT19BQ1RJVkVfTE9XPiwNCj4+ICAgICAgICAgICAgICAgICAgICAgIDwmcG9y
dGEgNyBHUElPX0FDVElWRV9MT1c+Ow0KPj4gICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+
ICAgICAgICAgICBzeXN0ZW0tY29udHJvbGxlckAwIHsNCj4+ICAgICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiYW1kLHBlbnNhbmRvLWVsYmFzciI7DQo+PiAgICAgICAgICAgICAgICAgICBy
ZWcgPSA8MD47DQo+PiAgICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+
ICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gICAgICAgICAgICAgICAg
ICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTIwMDAwMDA+Ow0KPj4NCj4+ICAgICAgICAgICAgICAg
ICAgIHJzdGM6IHJlc2V0LWNvbnRyb2xsZXIgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImFtZCxwZW5zYW5kby1lbGJhc3ItcmVzZXQiOw0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAjcmVzZXQtY2VsbHMgPSA8MT47DQo+PiAgICAgICAgICAgICAgICAg
ICB9Ow0KPj4gICAgICAgICAgIH07DQo+Pg0KPj4gICAgICAgICAgIHN5c3RlbS1jb250cm9sbGVy
QDEgew0KPj4gICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhbWQscGVuc2FuZG8tZWxi
YXNyIjsNCj4+ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwxPjsNCj4+ICAgICAgICAgICAgICAg
ICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDEyMDAwMDAwPjsNCj4+ICAgICAgICAgICB9Ow0KPj4N
Cj4+ICAgICAgICAgICBzeXN0ZW0tY29udHJvbGxlckAyIHsNCj4+ICAgICAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAiYW1kLHBlbnNhbmRvLWVsYmFzciI7DQo+PiAgICAgICAgICAgICAgICAg
ICByZWcgPSA8Mj47DQo+PiAgICAgICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwx
MjAwMDAwMD47DQo+PiAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwb3J0
YT47DQo+PiAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgSVJRX1RZUEVfTEVWRUxf
TE9XPjsNCj4+ICAgICAgICAgICB9Ow0KPj4NCj4+ICAgICAgICAgICBzeXN0ZW0tY29udHJvbGxl
ckAzIHsNCj4+ICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYW1kLHBlbnNhbmRvLWVs
YmFzciI7DQo+PiAgICAgICAgICAgICAgICAgICByZWcgPSA8Mz47DQo+PiAgICAgICAgICAgICAg
ICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMjAwMDAwMD47DQo+PiAgICAgICAgICAgfTsNCj4+
IH07DQo+IFlvdSByZXBsaWVkIHdpdGggcXVpdGUgYSByZXNwb25zZSBvZiB3aGljaCA5MCUgaXMg
dW5yZWxhdGVkIHRhbGsgYWJvdXQgDQo+IGRyaXZlci4gUGxlYXNlIGJlIHNwZWNpZmljLiBXZSB0
YWxrIGhlcmUgb25seSBhYm91dCBoYXJkd2FyZS4NCj4gWW91ciBsYXN0IERUUyBtaWdodCBiZSB0
aGUgYW5zd2VyLCBidXQgeW91IG5ldmVyIGV4cGxpY2l0bHkgd3JvdGUgDQo+IGl0Li4uIFNvIGxl
dCdzIGNoZWNrIGlmIEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0bHkuIE9ubHkgc29tZSBvZiBlbGJh
c3IgDQo+IGJsb2NrIGNvbnRhaW4gcmVzZXQgY29udHJvbD8NCg0KWWVzLCBvbmx5IHRoZSBlbGJh
c3IgYmxvY2sgYWNjZXNzZWQgb24gQ1MwIHByb3ZpZGVzIHJlc2V0IGNvbnRyb2wuwqAgVGhlIA0K
b3RoZXIgMyBibG9ja3MgZG9uJ3QgaGF2ZSBhbnkgcmVzZXQgY29udHJvbCBhbmQgbmV2ZXIgd2ls
bC4NCg0KPiBUaGlzIGhvd2V2ZXIgZG9lcyBub3QgYW5zd2VyIG15IHF1ZXN0aW9ucyBiZWZvcmUu
Li4uIFlvdSBrZWVwIGlnbm9yaW5nIA0KPiB0aGVtLiBTbyBwbGVhc2UgYW5zd2VyIHllcyBvciBu
bzogIkFyZSB0aGVyZSBvdGhlciBzdWItZGV2aWNlcz8iDQoNCk5vDQoNCj4gIiBhbmQgeW91ciBi
aW5kaW5nIGlzIGluY29tcGxldGU/Ig0KDQpObw0KDQo+IGFuZCBhIG5ldyBxdWVzdGlvbjogIklz
IHJlc2V0IGJsb2NrIChhbWQscGVuc2FuZG8tZWxiYXNyLXJlc2V0KSANCj4gcmUtdXNhYmxlIHNv
IGl0IHdpbGwgYXBwZWFyIGluIGRpZmZlcmVudCBkZXZpY2UgKG5vdCBpbiANCj4gYW1kLHBlbnNh
bmRvLWVsYmFzcik/Ig0KDQpObyBpdHMgbm90IHJlLXVzYWJsZQ0KDQpSZWdhcmRzLA0KQnJhZA0K
DQoNCg==
