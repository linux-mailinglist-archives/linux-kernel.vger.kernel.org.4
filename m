Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AC6690064
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBIGdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBIGdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:33:01 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B281D2ED59;
        Wed,  8 Feb 2023 22:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0lqpqKEcVa8X6F/hkKkmvXu72Tv7qcwk5k6y4/W9Y8Dg1QjYCiNAtOjdI+fLV1vDF5v+EzUT0iF9S6R80ZOjgqKnc7oCfJndPzHdT0WybBs0jrHM0LREuxZ0NBFlg7TDkTjZd3p9jkaPaEkLbPHoGWNtOG6ty5gZmEZBCUsY/QIxocX1M6qWH2HazHmFEYoHnDs/IApWt6HohdguZUHItG8BqP0lLUZ6QoovhTUZe4nY6zd3YiybJyBdivHGpsyUQpMbzyqY++lgMRJKUEu9czktYUUy09nIt4a0err49VKDuRnvz9WXasLZSuBe3C8TVgEyjFBHgSNBFpfZaq4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4q3DlmGBfcKL/ZewvlGNzldWm6U08N54Wdu/JotdsA=;
 b=aPubvtyVtJiNSZORetsceQE9A1Y3PNc6oOchyNmn00RKsOauinzdtZp2hpAV5JLxLSeTgHQQEmOpWqsp8Jrw1x6AzybGVYT/48WUdveLoq/Y+cq9snNigrCuGwMsIlXeH5A3xqU9UfbHnHPvkMR0DujvfVuaCf+ZivllFTPGvdawSiY6StsZPInBgdmf//xXhSEy0phHIl8tC1/PsYksE6uXFaC+YbLaJrtKjJCvrQXLeSdTSITI71MG5mA2RqLD7ac+2x5BuDSZXLHk58kYiEcS0j/U9KWDhTvmTjrrcxodKKDlBl9XWFC+xjicNcAnyOCKZ4xqUhPNUGtEth4xig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4q3DlmGBfcKL/ZewvlGNzldWm6U08N54Wdu/JotdsA=;
 b=Co94oUGM+USkDyvFL4TnHRUL5yvWIM9ySYrFscMPU42BhAyyMgOmU1TdOXRGz117opmyimSjbzNoyVDUoJIMDzYehpPmr8QrbaOWHJ5Xlk3itb1ufT4Wdvo7clDL2VEIPvtGpRvhhKU98ljGAlR8wlkcRrJDJj1JSPlyzsV28407YZTaLcyNQZrEUkPzhKjPcKGS3eRtxhWUteMbnjgk5SgMqSNvYpFj/WQEPFmNT2+74g69DtOrVbEt/AufQGVcOz8/eIQPcDhjfHEV6BIeEu6MlUr0XMk4FVFzpYp8dq9vFuX40PGv2sGKo4FuaV4uzHpWPe6T1a5Mo3yo21UFpw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2183.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 06:32:53 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 06:32:53 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Song Liu <songliubraving@meta.com>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v10] module: replace module_layout with module_memory
Thread-Topic: [PATCH v10] module: replace module_layout with module_memory
Thread-Index: AQHZOosZZk5xmhlffkGn7YoYAd2Wp67FVf+AgABArQCAAJTpAA==
Date:   Thu, 9 Feb 2023 06:32:53 +0000
Message-ID: <3fc59750-eccb-4b98-f64d-0ec64618748f@csgroup.eu>
References: <20230207002802.2514802-1-song@kernel.org>
 <b40ec330-8c9e-0265-19b9-d82b516c95c1@csgroup.eu>
 <1574471D-D1A6-4720-A57D-626204E8E746@fb.com>
In-Reply-To: <1574471D-D1A6-4720-A57D-626204E8E746@fb.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2183:EE_
x-ms-office365-filtering-correlation-id: 4fd116df-ab35-4f64-159b-08db0a677912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZXQW5JL/hJck3poKPfwYpX9DK4g0tznUhEMA8LtnLnDhM3Iu98UCB+TDmDFc41UgIXaqzRUesGbdKMuHtDAmO5rnUCiabP/ot5yq5za82soEnX3ma/eVU0lJX4WEU2j6veq5Yi6uNZjNz0iAp5hbgGDoS/PoRTmg/6lt7DwdKZ8kl9P9oJ/C7vy4W6Ffg11WXz34pyPnG/0zru5apfdxebh5cN9/GP6CWVSw3pw05FVPoI68+HNfsF/ALbzXeqzRS4/HlebB6/bhwudoSS4Y4KArH+HFcI1gAZ4Uahy7hqRVWAukYOFF3Q+4nUTzdWpG7nkHwsw3KHKzPfKU6jmcg4dfQqcl1W3YKQbH5mz1qMWrwAXzSzZ7+wWlokhKy/n2djIhqqiwEW1p51br0q4xpHw8cwC5ys9VCCZFNFjsAJrnK6iUQT5yXuYaIpfcUcYgURH6cxMX0FlUbc3jJWUlUCg/HPCUCsvF9vsyZJlNs5zqgjigkFCyvXvJj04w+X1dyYoiM4+MbEXfFpWaNFHa5Mb2577uWbaXSZF2a0SrdWy3iJjmRA7SEWSBclbN1HStA8mN0GRalozyDdkZfoe5030FaKAEd9vrxWVIFdsnn97itQErw/CcdXcXmMbyjnI+s4In7eEZxvVoh7cR0c2VvVqxJjZo0OfwkCZQKw0WPJEEHEgeLx7kQybxLWSvYgrywcqLx5AqYxDZE8gn4UO+E9cf97bv0lVd4/j4b7cPUL55uBT7jaJOy+1QcPXBMcjABRHlKQKQDNJ3IgW1Uh+zlv+eKd2RaONrGLE0DmGgAt1vtJFDPmWA4i3JwlXDjbvJVj/NBvbCr15TIz7vr1oR8oq+MqR4RK6zM3yShVtfrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39850400004)(396003)(376002)(451199018)(31686004)(122000001)(83380400001)(66574015)(36756003)(44832011)(2906002)(71200400001)(966005)(6486002)(478600001)(53546011)(31696002)(41300700001)(6512007)(6506007)(26005)(186003)(38100700002)(38070700005)(86362001)(2616005)(316002)(8676002)(7416002)(8936002)(4326008)(6916009)(5660300002)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm1OUkh1ZnYzN2Nhb0VIaWczTTBmQUZ5eGd6bm5rdVZkQzN0YUpIbThndksx?=
 =?utf-8?B?M21RU0FWRFlBRGZHTW90SzRpT3FNV2pRNTBZZjIwSjRxaXdsMFY1cXFtTGNL?=
 =?utf-8?B?bGdQTm9kUng1L2U5akVSOHo3eStKa05DZU0yTVBZYVFkOGZidTl2LzlOZXhr?=
 =?utf-8?B?WDBFRGJrZ08rWFhyYlFYTjZzMVBQQ2FQU1A4QmNPUldCYUlDaS9RaEpiK1Z0?=
 =?utf-8?B?SmJCR2hNNDBmQzRTc1FHd2JUZjE2elY3UFh3QitldFNQRTliN2UzYlhVZHl0?=
 =?utf-8?B?MWRrclFBdXF6WVNhb0JnTG9EWEdjMzFtQTdvb0FVSElJeUFKUWlJWXpxbThV?=
 =?utf-8?B?ak9jRE5UOWxYTDZIdnNyUXZzV1lua2o5a3ZJRHZGZkVYUWpCVk54K01pNVNF?=
 =?utf-8?B?WDJaR0M1V0RsYktCVHphM2FoWWNuc2xMTlg4UzJwUWlWeHdURTR1L3BYQ3FO?=
 =?utf-8?B?ayszZis4N0phSVdaK0xVbU0rV1JacnJHc1FvOWtDNFpZVDZBb0Z4cmpBd2ZI?=
 =?utf-8?B?NWJQY1dyRCs5OFJnMDBhV1hwWlpOYkNBa3lqdEloZXlGeWowWnljN1h6YTYx?=
 =?utf-8?B?Q24vVmc3M3BubWpienBKRzF5SzN6djlReUloS3F3Q0d0VUJiZkxCV3Y1TjZS?=
 =?utf-8?B?eVVxUU1SeWh2bit2dko3MndKVFc1cU5EQnk1TVlFNkpkbUt5OTRrMkE3SHFO?=
 =?utf-8?B?alNWMVpXb3hrc3lIaHhOQ01pd1NnL2JEQ1M5ZkR1ZjBEKzlFRTFRNWpKS3VN?=
 =?utf-8?B?WUsvdDIzNXF2ZUREbUdIa0tNczd3V1NXZkU1QW1tdUFhUDBMRzFRUG1EMU1W?=
 =?utf-8?B?MVN0aFBlaUFGT0tCbmozb0I4dmVPVE9jbzJrb3dNUzBQNUQzTVhzTWVoYklG?=
 =?utf-8?B?ZEZ1dW5tN1lNblowZTlFY2hJeitkLzdremNIZTU5WGFGbU1nRHMvY25VRkRh?=
 =?utf-8?B?NCs3VSs5bWZHeUlnUFBHVlFWNmVSb05jb0szN0lKU0I4UzZMYWxvRVdESGIz?=
 =?utf-8?B?TVovNy95QmhKdVE3dUVQZUttLzNtVXQyQ3B1NGVlbTQ2Z2REOUpSVjUzZ012?=
 =?utf-8?B?YlNwT0tJeFMzZXRMQ0MrejJiQUlZalNXZFVObTFnd1ZwcjlKSGpIbWEwTGlj?=
 =?utf-8?B?RXpXaEZDUDRxb2UrOVAwRk9GaXNYeG5ZVEIvdHgvQUZoUU5GUFlUbExqVXFn?=
 =?utf-8?B?UVBObXRsbUNJblZQbjY1N0JWYnFmRUZRSm14RGlibGRlNTJkc0VTc1JrVUhB?=
 =?utf-8?B?cFVNSm1CY04yUW1QaGg5cDNaM3dpak0xTDIxclJWYkUxaENjOHpuNEtKK210?=
 =?utf-8?B?SlMvY045bXhLZEs4c1ZMdjlWU2RtdXJVSFg0WFh5dFlmOVZHRUpsaTJZSnh0?=
 =?utf-8?B?QWttQnJNL3BEbTMxR3djNXRLTmFtaisyck1hWWx5VTFPdGE5TUozZzRwVWs2?=
 =?utf-8?B?SFBHWXA1cW9odEFGbjRFZjZOR2M4bHQ1cWlvTGRIcWtLd3Bzb2QxOHBXbDRw?=
 =?utf-8?B?VW52a1NOV0R0SGo2TDIxUVBHL1lrWUFvMjQzZTYzK1ppcHhFeCtRQWNBejAr?=
 =?utf-8?B?VzFjTTUxYmg2RHpkZEJNa3VuSjdSaHJnMlpvK1orK1BqOUpQSWVlWFBBK0xj?=
 =?utf-8?B?cnlGc1pzUUdjQ1hyWVlUNGwrMXp2MjFPSXZMd1hVVC9LL1FSWlFVTFplOW51?=
 =?utf-8?B?WEZ5NTJEMVNZajUvVWVFQ2t5eUVBL0xjZ2QrWmpDRDY0MHRFMithTE8xK2xC?=
 =?utf-8?B?WFZzOFdCVGdlSEYxcmR5WnJwTC85NHVBQ3JjM3B6V0QrRTgzY0NtVytvZ0hy?=
 =?utf-8?B?dUxJU0NLcStLblBrczlYK2p3U3FEOE1uUU02bHdicEFYenZWREoxMnJJdFUz?=
 =?utf-8?B?ZWdRTHI1YTlKNytzNFpmZS9KUktFemxwcWV5bjhWY1JtS1dLc084cmkyR3lW?=
 =?utf-8?B?L3RIbW9VVVJ3cGQ2K0w5eU4xSFNWZzVzTDFlZGtnWmdBcXE4cWJXYWxON09B?=
 =?utf-8?B?TVlwVDBpbVNib0pEbEVwSTE0N3pFenZ6bzVXSkI0SUg3UGt1Y2h5aFFYRjVP?=
 =?utf-8?B?RFpxeVh4clJtdTg2Ujdjd2luNi82NStiSEZyeHQ4UlpsbDFTdHRBQlVPb1By?=
 =?utf-8?B?ZWYwN0dJdm1YemFXMmllaU5sRURoWVc3cWxFbllmLzkrcSt4OGdNQzlvTXBE?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BA504743B61C04AA76F8036B324EDB7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd116df-ab35-4f64-159b-08db0a677912
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 06:32:53.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xlCjVga7mN/ySoxwhXZQCSOvABeWxLW5H0uVsTRTbGeX1XUN0DUld9ptDKxyIWb/nMOG4Dqr6uJghYkWFB/sDIVTSjeWJ7OJu4wkGz1G6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2183
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA4LzAyLzIwMjMgw6AgMjI6MzksIFNvbmcgTGl1IGEgw6ljcml0wqA6DQo+IA0KPiAN
Cj4+IE9uIEZlYiA4LCAyMDIzLCBhdCA5OjQ4IEFNLCBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3Rv
cGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+Pj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJjL2tlcm5lbC91bndpbmQuYyBiL2FyY2gvYXJjL2tlcm5lbC91bndpbmQu
Yw0KPj4+IGluZGV4IDIwMDI3MGE5NDU1OC4uOTMzNDUxZjQ0OTRmIDEwMDY0NA0KPj4+IC0tLSBh
L2FyY2gvYXJjL2tlcm5lbC91bndpbmQuYw0KPj4+ICsrKyBiL2FyY2gvYXJjL2tlcm5lbC91bndp
bmQuYw0KPj4+IEBAIC0zNjksNiArMzY5LDggQEAgdm9pZCAqdW53aW5kX2FkZF90YWJsZShzdHJ1
Y3QgbW9kdWxlICptb2R1bGUsIGNvbnN0IHZvaWQgKnRhYmxlX3N0YXJ0LA0KPj4+ICAgICAgICAg
IHVuc2lnbmVkIGxvbmcgdGFibGVfc2l6ZSkNCj4+PiAgIHsNCj4+PiAgICBzdHJ1Y3QgdW53aW5k
X3RhYmxlICp0YWJsZTsNCj4+PiArIHN0cnVjdCBtb2R1bGVfbWVtb3J5ICptb2RfbWVtX2NvcmVf
dGV4dDsNCj4+PiArIHN0cnVjdCBtb2R1bGVfbWVtb3J5ICptb2RfbWVtX2luaXRfdGV4dDsNCj4+
DQo+PiBUaGlzIGZ1bmN0aW9uIGlzIHNtYWxsICgzNSBsaW5lcykgc28gbm8gbmVlZCB0byBoYXZl
IHNvIGJpZyBuYW1lcyBmb3INCj4+IGxvY2FsIGZ1bmN0aW9ucywgc2VlDQo+PiBodHRwczovL2Rv
Y3Mua2VybmVsLm9yZy9wcm9jZXNzL2NvZGluZy1zdHlsZS5odG1sI25hbWluZw0KPj4NCj4+IHN0
cnVjdCBtb2R1bGVfbWVtb3J5ICpjb3JlX3RleHQ7DQo+PiBzdHJ1Y3QgbW9kdWxlX21lbW9yeSAq
aW5pdF90ZXh0Ow0KPiANCj4gV2lsbCBmaXguDQo+IA0KPiBbLi4uXQ0KPiANCj4+Pg0KPj4+DQo+
Pj4gICAvKg0KPj4+IC0gKiBCb3VuZHMgb2YgbW9kdWxlIHRleHQsIGZvciBzcGVlZGluZyB1cCBf
X21vZHVsZV9hZGRyZXNzLg0KPj4+ICsgKiBCb3VuZHMgb2YgbW9kdWxlIG1lbW9yeSwgZm9yIHNw
ZWVkaW5nIHVwIF9fbW9kdWxlX2FkZHJlc3MuDQo+Pj4gICAgKiBQcm90ZWN0ZWQgYnkgbW9kdWxl
X211dGV4Lg0KPj4+ICAgICovDQo+Pj4gLXN0YXRpYyB2b2lkIF9fbW9kX3VwZGF0ZV9ib3VuZHMo
dm9pZCAqYmFzZSwgdW5zaWduZWQgaW50IHNpemUsIHN0cnVjdCBtb2RfdHJlZV9yb290ICp0cmVl
KQ0KPj4+ICtzdGF0aWMgdm9pZCBfX21vZF91cGRhdGVfYm91bmRzKGVudW0gbW9kX21lbV90eXBl
IHR5cGUgX19tYXliZV91bnVzZWQsIHZvaWQgKmJhc2UsDQo+Pj4gKyB1bnNpZ25lZCBpbnQgc2l6
ZSwgc3RydWN0IG1vZF90cmVlX3Jvb3QgKnRyZWUpDQo+Pj4gICB7DQo+Pj4gICAgdW5zaWduZWQg
bG9uZyBtaW4gPSAodW5zaWduZWQgbG9uZyliYXNlOw0KPj4+ICAgIHVuc2lnbmVkIGxvbmcgbWF4
ID0gbWluICsgc2l6ZTsNCj4+Pg0KPj4+ICsjaWZkZWYgQ09ORklHX0FSQ0hfV0FOVFNfTU9EVUxF
U19EQVRBX0lOX1ZNQUxMT0MNCj4+DQo+PiBBICNpZmRlZiBzaG91bGRuJ3QgYmUgcmVxdWlyZWQu
IFlvdSBjYW4gdXNlIElTX0VOQUJMRUQoKSBpbnN0ZWFkOg0KPiANCj4gV2lsbCBmaXguDQo+IA0K
Pj4NCj4+DQo+Pg0KPj4+ICsgaWYgKG1vZF9tZW1fdHlwZV9pc19jb3JlX2RhdGEodHlwZSkpIHsN
Cj4+DQo+PiBpZiAoSVNfRU5BQkxFRChDT05GSUdfQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFfSU5f
Vk1BTExPQykgJiYNCj4+ICAgICBtb2RfbWVtX3R5cGVfaXNfY29yZV9kYXRhKHR5cGUpKQ0KPiAN
Cj4gWy4uLl0NCj4gDQo+Pj4gLSBzd2l0Y2ggKG0pIHsNCj4+PiAtIGNhc2UgMDogLyogZXhlY3V0
YWJsZSAqLw0KPj4+IC0gbW9kLT5jb3JlX2xheW91dC5zaXplID0gc3RyaWN0X2FsaWduKG1vZC0+
Y29yZV9sYXlvdXQuc2l6ZSk7DQo+Pg0KPj4gV2hlcmUgaXMgdGhlIHN0cmljdCBhbGlnbm1lbnQg
ZG9uZSBub3cgPw0KPiANCj4gQUZBSUNULCBlYWNoIG9mIHRoZXNlIG1lbW9yeSByZWdpb25zIGFy
ZSBhbGxvY2F0ZWQgc2VwYXJhdGVseSwNCj4gc28gdGhleSBhcmUgYWx3YXlzIHBhZ2UgYWxpZ25l
ZCwgbm8/DQoNCkFoLCBPSy4NCkl0IHNob3VsZCBiZSBPSyB0aGVuLg0KDQoNCj4gDQo+Pg0KPj4+
IC0gbW9kLT5jb3JlX2xheW91dC50ZXh0X3NpemUgPSBtb2QtPmNvcmVfbGF5b3V0LnNpemU7DQo+
Pj4gLSBicmVhazsNCj4+PiAtIGNhc2UgMTogLyogUk86IHRleHQgYW5kIHJvLWRhdGEgKi8NCj4+
PiAtIG1vZC0+ZGF0YV9sYXlvdXQuc2l6ZSA9IHN0cmljdF9hbGlnbihtb2QtPmRhdGFfbGF5b3V0
LnNpemUpOw0KPj4+IC0gbW9kLT5kYXRhX2xheW91dC5yb19zaXplID0gbW9kLT5kYXRhX2xheW91
dC5zaXplOw0KPj4+IC0gYnJlYWs7DQo+Pj4gLSBjYXNlIDI6IC8qIFJPIGFmdGVyIGluaXQgKi8N
Cj4+PiAtIG1vZC0+ZGF0YV9sYXlvdXQuc2l6ZSA9IHN0cmljdF9hbGlnbihtb2QtPmRhdGFfbGF5
b3V0LnNpemUpOw0KPj4+IC0gbW9kLT5kYXRhX2xheW91dC5yb19hZnRlcl9pbml0X3NpemUgPSBt
b2QtPmRhdGFfbGF5b3V0LnNpemU7DQo+Pj4gLSBicmVhazsNCj4+PiAtIGNhc2UgNDogLyogd2hv
bGUgY29yZSAqLw0KPj4+IC0gbW9kLT5kYXRhX2xheW91dC5zaXplID0gc3RyaWN0X2FsaWduKG1v
ZC0+ZGF0YV9sYXlvdXQuc2l6ZSk7DQo+Pj4gLSBicmVhazsNCj4+PiAtIH0NCj4+PiAtIH0NCj4g
DQo+IFsuLi5dDQo+IA0KPj4NCj4+Pg0KPj4+ICAgIGlmIChzaGRyLT5zaF90eXBlICE9IFNIVF9O
T0JJVFMpDQo+Pj4gICAgbWVtY3B5KGRlc3QsICh2b2lkICopc2hkci0+c2hfYWRkciwgc2hkci0+
c2hfc2l6ZSk7DQo+Pg0KPj4+IEBAIC0zMDYwLDIwICszMDkxLDIxIEBAIGJvb2wgaXNfbW9kdWxl
X2FkZHJlc3ModW5zaWduZWQgbG9uZyBhZGRyKQ0KPj4+ICAgc3RydWN0IG1vZHVsZSAqX19tb2R1
bGVfYWRkcmVzcyh1bnNpZ25lZCBsb25nIGFkZHIpDQo+Pj4gICB7DQo+Pj4gICAgc3RydWN0IG1v
ZHVsZSAqbW9kOw0KPj4+IC0gc3RydWN0IG1vZF90cmVlX3Jvb3QgKnRyZWU7DQo+Pj4NCj4+PiAg
ICBpZiAoYWRkciA+PSBtb2RfdHJlZS5hZGRyX21pbiAmJiBhZGRyIDw9IG1vZF90cmVlLmFkZHJf
bWF4KQ0KPj4+IC0gdHJlZSA9ICZtb2RfdHJlZTsNCj4+PiArIGdvdG8gbG9va3VwOw0KPj4+ICsN
Cj4+PiAgICNpZmRlZiBDT05GSUdfQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFfSU5fVk1BTExPQw0K
Pj4NCj4+IENhbiB3ZSB0cnkgdG8gYXZvaWQgdGhhdCAjaWZkZWYgPw0KPj4gSSBrbm93IHRoYXQg
bWVhbnMgZ2V0dGluZyBkYXRhX2FkZHJfbWluIGFuZCBkYXRhX2FkZHJfbWF4IGFsd3lhcw0KPj4g
ZXhpc3RpbmcsIG1heWJlIHRocm91Z2ggYW4gdW5uYW1lZCB1bmlvbiBvciBhIG1hY3JvIG9yIGEg
c3RhdGljIGlubGluZQ0KPj4gaGVscGVyID8NCj4gDQo+IElJVUMsIHdlIHdhbnQgX19tb2R1bGVf
YWRkcmVzcygpIHRvIGJlIGFzIGZhc3QgYXMgcG9zc2libGUuIFNvICNpZmRlZg0KPiBpcyBwcm9i
YWJseSB0aGUgYmVzdCBzb2x1dGlvbiBoZXJlPw0KDQpBbiBpZi9lbHNlIHdpdGggSVNfRU5BQkxF
RChDT05GSUdfU09NRVRISU5HKSBpcyBmb2xkZWQgYXQgYnVpbGQgdGltZSwgc28gDQppdCBtYWtl
cyBubyBkaWZmZXJlbmNlIHdpdGggYW4gI2lmZGVmIGluIHRlcm1zIG9mIHBlcmZvcm1hbmNlLg0K
DQpIb3dldmVyIGl0IGhhcyB0aGUgYWR2YW50YWdlIG9mIG1ha2luZyB0aGUgZW50aXJlIGNvZGUg
dmlzaWJsZSB0byB0aGUgDQpjb21waWxlciBhdCBhbGwgdGltZXMsIHdoaWNoIG1lYW5zIHRoYXQg
eW91IGRvbid0IGhhdmUgdG8gYnVpbGQgaXQgDQpzZXZlcmFsIHRpbWVzIHdpdGggZGlmZmVyZW5j
ZSB2YWx1ZSBmb3IgQ09ORklHX1NPTUVUSElORyBpbiBvcmRlciB0byBzZWUgDQp3aGV0aGVyIHlv
dXIgY29kZSBpcyB2YWxpZCBvciBub3QuDQoNCkFzIGFuIGV4ZW1wbGUsIGlmIHlvdSBoYWQgd3Jp
dHRlbiBtb2RfbWVtX3VzZV92bWFsbG9jKCkgd2l0aCANCklTX0VOQUJMRUQoKSBpbnN0ZWFkIG9m
IGFuICNpZmRlZiwgeW91IHdvdWxkIGhhdmUgZGV0ZWN0ZWQgdGhlIHByb2JsZW0gDQppbiB2OCBl
dmVuIHdpdGhvdXQgYnVpbGRpbmcgd2l0aCBDT05GSUdfQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFf
SU5fVk1BTExPQw0KDQo+IA0KPiBUaGFua3MsDQo+IFNvbmcNCj4gDQo+Pg0KPj4+IC0gZWxzZSBp
ZiAoYWRkciA+PSBtb2RfZGF0YV90cmVlLmFkZHJfbWluICYmIGFkZHIgPD0gbW9kX2RhdGFfdHJl
ZS5hZGRyX21heCkNCj4+PiAtIHRyZWUgPSAmbW9kX2RhdGFfdHJlZTsNCj4+PiArIGlmIChhZGRy
ID49IG1vZF90cmVlLmRhdGFfYWRkcl9taW4gJiYgYWRkciA8PSBtb2RfdHJlZS5kYXRhX2FkZHJf
bWF4KQ0KPj4+ICsgZ290byBsb29rdXA7DQo+Pj4gICAjZW5kaWYNCj4+PiAtIGVsc2UNCj4+PiAt
IHJldHVybiBOVUxMOw0KPj4+DQo+Pj4gKyByZXR1cm4gTlVMTDsNCj4+PiArDQo+Pj4gK2xvb2t1
cDoNCj4+PiAgICBtb2R1bGVfYXNzZXJ0X211dGV4X29yX3ByZWVtcHQoKTsNCj4+Pg0KPj4+IC0g
bW9kID0gbW9kX2ZpbmQoYWRkciwgdHJlZSk7DQo+Pj4gKyBtb2QgPSBtb2RfZmluZChhZGRyLCAm
bW9kX3RyZWUpOw0KPj4+ICAgIGlmIChtb2QpIHsNCj4+PiAgICBCVUdfT04oIXdpdGhpbl9tb2R1
bGUoYWRkciwgbW9kKSk7DQo+Pj4gICAgaWYgKG1vZC0+c3RhdGUgPT0gTU9EVUxFX1NUQVRFX1VO
Rk9STUVEKQ0KPiANCg==
