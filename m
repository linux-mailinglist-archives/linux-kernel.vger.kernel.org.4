Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A272B83E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 08:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjFLGpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 02:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjFLGpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:45:02 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on20716.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e23::716])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BE819B3;
        Sun, 11 Jun 2023 23:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYzNc31ooxHUGaRbBo2Ykg/FGwOM8dkR8ZsbyUARATsbep3xF+aDJjYXk8tZ7OhJcco+jStYsWXSSb/G1E8/mQfvk9QnZ7VRWVGBGjwRhty0+rm8LUbO+kVjUaqjgcPspKikKiDKU1M3Q52FGZJbvGHBln2hKeDrT19/2KWoWdxFY7W8WBTeM7Mlz6MHBUQiiY5awgEbMQ7otsZYKt9y9k1b8q6FskSiBwYCESVMRz6VBnDiCVInX+ecC7ri9IFprPIMhmrI+1gzJrNiK57ejrXyjpSdImyN3NrZIh7mc+vDUmpw4x0VlJME/fxHAgjm36wR0+9/ZIphkxb3gjvAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyKKYDEJSv715d105WquCPDlX4ukKcDD1CG+ZFYLfZc=;
 b=AgEF0o8nLWa/dKO8CUsw0uwgeVPNFpyEkIjGobUgzAm8F7ZZYZzSfMc+piFssqtDpQXes/gyCHJtM8h2jcSW0epSGpHRp6YujHF7Uig+azFODXJvD5sIyHcm4H2PVpRwdMdVRCLuvKz+DPl2r94vqrZMtiFCWYEf054plXqh9bwjfxQWyvrsmaJwQIje6ZeQ78yM0cxsHP0WSDl/n5ZwE6n507S5wfSFKEYMAaVsw2YkrkNC/UgJW/wsSgo2fuklBklqj/VSdUuM/sehk9b+M9yzuRk8PQP6FJMT9MP+315/c0ylvhog/hU7MuDNqInkgVXIzYtLNs45ZLZuIwSWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyKKYDEJSv715d105WquCPDlX4ukKcDD1CG+ZFYLfZc=;
 b=kTzgXqJ98upNu10LQuXOaDnpyEYIAl52B3JuKpAV6ihvqA/xk84iimVYxfpKH2ymZfLsLUL0Z7P1SkQbjkO0WBxxe7dfVTJ+WhKxxhuNnR/g2Aex0kP+Or4OJfdtBq+utYUZJkV/0+SBVw2MgyACUzQyPL4kwQjf2/Dhqjd4yHo=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR0P281MB2829.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:20::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 06:36:39 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::addb:ecc6:a883:dd68]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::addb:ecc6:a883:dd68%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 06:36:39 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v5 0/5] Support ROHM BU27008 RGB sensor
Thread-Topic: [PATCH v5 0/5] Support ROHM BU27008 RGB sensor
Thread-Index: AQHZgZgqjKGejQ6Xf0iuWNJwX42hWa+CnZiAgABMc4CABAM/AA==
Date:   Mon, 12 Jun 2023 06:36:38 +0000
Message-ID: <ca1999c9-910b-558f-d4ca-267809db8cfb@fi.rohmeurope.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
 <0173eb2b-b6a5-b90a-9740-7a65f806fabc@gmail.com>
 <20230609181959.00007c82@Huawei.com>
In-Reply-To: <20230609181959.00007c82@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR0P281MB2829:EE_
x-ms-office365-filtering-correlation-id: 3e1c9bf2-d8b1-4078-8a12-08db6b0f6022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOtpeYDR2dEOf3+klg1j0v1xEkPzIYgqG9bmAp/oXm5AteyNkav+4GkCfRDkgcXPoH9TCqFcuoDsr2ZPypHs0hjYYmZ0Lw7ULNWIOxTH4/h9Stq4Z4yVv4712POWRwFUEBvBSw093kZfV6CuyenITqSUv0pZRiORHEOtoM7vmCsDt1gJcWBV97dHzUhqH8YzqGxgidB9oFy6UybbgemAet/S25aV7e0GAFJwklFHfO54ZC0jOo0mDYjp3Bg7CNbQjbdQZewhXcRCcVdbZN8kOYM7H9afxOtLpnu7xy/hCNK8GkhTF2PUCqDYgbjQAQz30l2M34NGo1Gt0HJhDk5Mqpv51w84m1jSO4tWGTdpuJX3mIGd5E64FOs3oyckUGtKu0MNH/AqfUeCtnOlIhdeuDrl1DYTzsCCcHqFm8vepsFsaZXGl6IXbFf1qs9GYFGKVKqZUFaerP17ltwRD1QE6DN/+zaWCCHh4StHtN6UWR14DHGGMCUSPNfgcvJq5wM/hrNJIu37r+lWo04A6FCoxLJMrk1HCseJ7ltczYADWxZnR5n/cxvuqiX2p4rkyTuQ3sCz5VIXexSl1GpbErs2o+ILhuVAIYNcg1b5Xr3O53wnmHbqg6eBs5vBrJa1QZIX2z4MKEQyB4t7OyTwTFzjC2os2yObjxowrZ8VXFzSKS8NscYCAq1OONfZhud7UkfK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39840400004)(376002)(136003)(396003)(451199021)(316002)(6486002)(41300700001)(2616005)(83380400001)(31696002)(86362001)(38070700005)(53546011)(6512007)(6506007)(186003)(7416002)(107886003)(2906002)(122000001)(38100700002)(5660300002)(8676002)(8936002)(76116006)(66946007)(91956017)(110136005)(54906003)(64756008)(66556008)(66476007)(66446008)(478600001)(31686004)(71200400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEF0NGFPOWQvR0FJOFZUbnI1VzVoSmlBSmhwMCtFYTdPNnZTZms0SlpLaXRN?=
 =?utf-8?B?MFU5Wk5TWFl4U1NxVUxIOUg1YmZjc3ZFSEJwNk54ZW5DamxSbW1oSzBCYlhR?=
 =?utf-8?B?QUlpMytEZ2YrR1AyVjJUWlJSWUpoWktxcjVTZFNYeGM4UEZnUTBpeGlDOFpN?=
 =?utf-8?B?M2NmblRBRkVEKytSOGN3dzZLSDZPdXNoZG85ZmVqRDA5aTlkZGpLUHhKc0FW?=
 =?utf-8?B?U3gxVzRTdU5BVEViSk9pRnFCRmIvNUh4SkV5TXRySFYwdzFUUWZLcG14TDM4?=
 =?utf-8?B?MlVQMmwwQ2FsbkIwMmE2YXJ0ZlhaSXNLenJrYTVjb3M0amM3RzR0d0tVN3B6?=
 =?utf-8?B?N2JvTHJiOEtYL0hkR2RQemljQUlGeSsxeXhiZ25yRTBmd21UL3Z5R2F3eEU5?=
 =?utf-8?B?UHVoS055ZEZ0MXpwajBCQk1nUUl6UzFDQW1GSlc2TnRJck91NGZ3enVqWW02?=
 =?utf-8?B?cit2WTVCS1k5NVNkc1pvd2t4UFpoQjFiQ3BBc25zemVHeE5Qdnl4UzRDVGpy?=
 =?utf-8?B?ai9xWnh4YmxqR0RTZHJLUXF3WDIzNmNCbmM2emVwc0pmQjg4cE9GYWR1VGZl?=
 =?utf-8?B?cndKL1h6TllFVHNWUGVWNW5mMzRFM21GMFhSYzdHNzFDOEN5ZjVwUHQ3TzVB?=
 =?utf-8?B?MVFVcEdqZUlHQlAyNUc1ZzA0Z1RGbFBVcW5LV1pqL1g4WG45eUlJR2tPcnJP?=
 =?utf-8?B?T0FpSzZ5Y0FpcDVIZkZtN0o2T1NlRGZDc1VXWjlDbFN4OXJ6dDZZTXhsRTVC?=
 =?utf-8?B?ZFpjeGlDUXV0ek9ldytqSmpEd0hVZ3Y1ZXhwN281RUJJSDFlR21ZUG1qVGtK?=
 =?utf-8?B?WUU2S2lLeXI4NC9Kb2EvczZTeWpXd0dKMGM0MjdzOHRNR2l4bVU0MkFINzRZ?=
 =?utf-8?B?eUExb1M3Mk52ZU1YZHp6UmZxY2t3RUJYMUg2d2ZlQXFkTUlKMUpjQTZwVDRp?=
 =?utf-8?B?WGF3VXhUdmtGSlRReVVYTEhORzl6Vk1wenR1NmxBRmVZUUhKZmpGUUFCcm5u?=
 =?utf-8?B?TG5pTjhiMEpXQml4RkZtcWhqVzlPcmdkU3I2ZEZwcDFRdlBLdjg0RlplTUJY?=
 =?utf-8?B?cjU1cDVmcEZPT3kwcE1NcFhndE9iV3Y1ZmZyNk9nUnhGdDM0d1kxNkdkQjhm?=
 =?utf-8?B?SXJnSkNQNFZ1anNLcGVJL3daR24yYzdIWE1pY0o3Wk5rWUFZQnZpWGU5dC9Y?=
 =?utf-8?B?aktwV1M4Rm0rS0JSbytuYTF2YjJWbExEY3RoYkwwUGFtTWtTS2dHRlMwWXVk?=
 =?utf-8?B?eXlZbmdyRStFZ0ZSYUQwMkNFWVBWK0l1MzJmOFBQZkhURnRkZThrTXBOS2VL?=
 =?utf-8?B?dHVzdnVUT0JUSi9YOWdFOU1FY3BoTXJqR05NVnFMNjVlaHFuWmlUNGxRcWpH?=
 =?utf-8?B?bGlhZk92ZWxJZ3ZKNFhucjcyWHc0RVNTSG90NHYxQnFrQXBiem1Tc3dTTW9K?=
 =?utf-8?B?ek1BN0xNV3hrMnEzQXMybXFJK0VOd2pyNUhvaUFVekVRNm1Yc3NITnhER0Rm?=
 =?utf-8?B?N2VzSTdOejBmVU5BM3lYTmxnZGFVMHZWS1BLNEQwcDVyRjBWRWhBbUtISSt3?=
 =?utf-8?B?V0E3NThHMmxWdnJtYXRNYlY5eUowamVXbGhvRTZGZGVlNWFTVGQxUEZRZXNN?=
 =?utf-8?B?WnJKYWNZZCt0NFA1MGxPS1lxaGM5Zk4rMTJyU2FvdG5mSjNSY0dPOU1pdDVq?=
 =?utf-8?B?eWlHd01kZktBUXd6a1FyYjBjdGNPM0NXU05qdmxjYzBhaDQwNmtUdWtIelkr?=
 =?utf-8?B?ZXJoQTloQXBUVGV4Nm9FRzVZSHVKV0V2bFVTNEs4UWFzT25DY2ZSVVk2bkFn?=
 =?utf-8?B?aE5nbDB4OU5mMmlUUC93M2NnM0NkOE5ZL1prRUM2VmNjODBCbDcweThLWEdW?=
 =?utf-8?B?YjlUSWVlZkRmb3h4djNpcS9tSmRBY25DVDF1NXk3VWkxN3VUbFNhdG5adEhJ?=
 =?utf-8?B?VXpXWHdxVC8rWTZKSzcxRThvWmxXU2RDT0YxR1JDTFpVSE5oZm00VXgwRnl1?=
 =?utf-8?B?Y1dnNFdnVHhCNWg1aU0xT3pOWHFWQWlLeFh5bjZDZ3ZkM1JDWWl5U3RnaThH?=
 =?utf-8?B?aXFCYXJkNUlnTk8wT0E0bUx4aFI3ZWp1OWZ2UUVzRzZrOC9iYkRCVER1QWFo?=
 =?utf-8?B?N0VVNFFMaWFJdTgwRllVeFBEd3lkazdsSytvZW80eGlYQ3FZUGo2V2xFM1Zi?=
 =?utf-8?Q?lzAjkkZeidNNo3AgHXdxJo4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B42AB5C5E737674EA52A04DFB7114146@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1c9bf2-d8b1-4078-8a12-08db6b0f6022
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 06:36:38.4602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDpunATH93tol+qVus5L4g5J36uc533GJpHrNN5yTZkHc/bMe+fYdR+pzPe/916BuJrwPQ+8BA5td3uwbLG4UcVVqm2DOBKU25/t+MTnDpK4K0i5TqkC486ss/1ApeDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2829
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi85LzIzIDIwOjE5LCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiBPbiBGcmksIDkgSnVu
IDIwMjMgMTU6NDY6MjEgKzAzMDANCj4gTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBn
bWFpbC5jb20+IHdyb3RlOg0KPiANCj4+IE9uIDUvOC8yMyAxMzozMCwgTWF0dGkgVmFpdHRpbmVu
IHdyb3RlOg0KPj4+IEFkZCBzdXBwb3J0IGZvciBST0hNIEJVMjcwMDggUkdCIHNlbnNvci4NCj4+
Pg0KPj4+IFRoZSBST0hNIEJVMjcwMDggaXMgYSBzZW5zb3Igd2l0aCA1IHBob3RvZGlvZGVzIChy
ZWQsIGdyZWVuLCBibHVlLCBjbGVhcg0KPj4+IGFuZCBJUikgd2l0aCBmb3VyIGNvbmZpZ3VyYWJs
ZSBjaGFubmVscy4gUmVkIGFuZCBncmVlbiBiZWluZyBhbHdheXMNCj4+PiBhdmFpbGFibGUgYW5k
IHR3byBvdXQgb2YgdGhlIHJlc3QgdGhyZWUgKGJsdWUsIGNsZWFyLCBJUikgY2FuIGJlDQo+Pj4g
c2VsZWN0ZWQgdG8gYmUgc2ltdWx0YW5lb3VzbHkgbWVhc3VyZWQuIFR5cGljYWwgYXBwbGljYXRp
b24gaXMgYWRqdXN0aW5nDQo+Pj4gTENEIGJhY2tsaWdodCBvZiBUVnMsIG1vYmlsZSBwaG9uZXMg
YW5kIHRhYmxldCBQQ3MuDQo+Pj4NCj4+PiBUaGlzIHNlcmllcyBzdXBwb3J0cyByZWFkaW5nIHRo
ZSBSR0JDIGFuZCBJUiBjaGFubmVscyB1c2luZyBJSU8NCj4+PiBmcmFtZXdvcmsuIEhvd2V2ZXIs
IG9ubHkgdHdvIG9mIHRoZSBCQytJUiBjYW4gYmUgZW5hYmxlZCBhdCB0aGUgc2FtZQ0KPj4+IHRp
bWUuIFNlcmllcyBhZGRzIGFsc28gc3VwcG9ydCBmb3Igc2NhbGUgYW5kIGludGVncmF0aW9uIHRp
bWUNCj4+PiBjb25maWd1cmF0aW9uLCB3aGVyZSBzY2FsZSBjb25zaXN0cyBvZiBpbXBhY3Qgb2Yg
Ym90aCB0aGUgaW50ZWdyYXRpb24NCj4+PiB0aW1lIGFuZCBoYXJkd2FyZSBnYWluLiBUaGUgZ2Fp
biBhbmQgdGltZSBzdXBwb3J0IGlzIGJhY2tlZCBieSB0aGUgbmV3bHkNCj4+PiBpbnRyb2R1Y2Vk
IElJTyBHVFMgaGVscGVyLiBUaGlzIHNlcmllcyBkZXBlbmRzIG9uIEdUUyBoZWxwZXIgcGF0Y2hl
cw0KPj4+IGFkZGVkIGluIEJVMjcwMzQgc3VwcG9ydCBzZXJpZXMgd2hpY2ggaXMgYWxyZWFkeSBt
ZXJnZWQgaW4gaWlvL3RvZ3JlZw0KPj4+IHdoaWNoIHRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uLg0K
Pj4NCj4+IEkgc3RhcnRlZCBhZGRpbmcgc3VwcG9ydCBmb3IgdGhlIEJVMjcwMTAgUkdCQyArIGZs
aWNrZXJpbmcgc2Vuc29yIHRvIHRoZQ0KPj4gQlUyNzAwOCBkcml2ZXIuIFdoaWxlIGF0IGl0LCBJ
IHdyb3RlIHNvbWUgdGVzdChzKSB3aGljaCB0cnkgdXNpbmcgYWxzbw0KPj4gdGhlICdpbnNhbmUn
IGdhaW4gc2V0dGluZ3MuDQo+Pg0KPj4gV2hhdCBJIGZvdW5kIG91dCBpcyB0aGF0IHRoZSBzY2Fs
ZSBzZXR0aW5nIGZvciBCVTI3MDA4IGlzIGJyb2tlbiBmb3INCj4+IHNtYWxsZXN0IHNjYWxlczog
MC4wMDc4MTI1MDAgMC4wMDM5MDYyNTAgMC4wMDE5NTMxMjUNCj4+DQo+PiBSZWFzb24gaXMgdGhl
IGFjY3VyYWN5Lg0KPj4NCj4+IFRoZSBHVFMgaGVscGVycyB3ZXJlIG1hZGUgdG8gdXNlIE5BTk8g
c2NhbGUgYWNjdXJhY3kuIDk5OTk5OTk5OSBpcyBzdGlsbA0KPj4gZml0dGluZyBpbiBhbiAzMiBi
aXQgaW50ZWdlciBhZnRlciBhbGwgOikgVGhpcyBhbGxvd3MgdG8gaGFuZGxlIGdyZWF0ZXINCj4+
ICJ0b3RhbCBnYWlucyIuDQo+Pg0KPj4gVGhlIElJTyBzY2FsZSBzZXR0aW5nIGludGVyZmFjZSB0
b3dhcmRzIHRoZSBkcml2ZXJzIHNlZW1zIHRvIGNyb3AgdGhlDQo+PiB2YWwyIHRvIG1pY3JvcyAo
NiBkaWdpdHMpLiBUaGlzIG1lYW5zIHRoYXQgd2hlbiB1c2VyIHdyaXRlcyBzY2FsZQ0KPj4gMC4w
MDE5NTMxMjUgdmlhIHN5c2ZzIC0gdGhlIGRyaXZlciB3aWxsIGdldCB2YWwgPSAwLCB2YWwyID0g
MTk1My4NCj4+IEN1cnJlbnRseSB0aGUgQlUyNzAwOCBkcml2ZXIgKGFuZCBwcm9iYWJseSBhbHNv
IHRoZSBCVTI3MDM1IHdoaWNoIEkgaGF2ZQ0KPj4gbm90IHlldCBjaGVja2VkKSB3aWxsIHBhc3Mg
dGhpcyB2YWx1ZSB0byBHVFMtaGVscGVycyAtIHdoaWNoIHRyeSB0byB1c2UNCj4+IGl0IGluIGNv
bXB1dGF0aW9ucyB3aGVyZSBzY2FsZSBpcyB0cmllZCB0byBiZSBjb252ZXJ0ZWQgdG8gZ2FpbiAr
DQo+PiBpbnRlZ3JhdGlvbiB0aW1lIHNldHRpbmdzLiBUaGlzIHdpbGwgZmFpbCBiZWNhdXNlIG9m
IHJvdW5kaW5nIGVycm9yIHRoaXMNCj4+IGxlYWRzIHRvLg0KPj4NCj4+IFJlZ2FyZGluZyB0aGUg
QlUyNyogZHJpdmVycyBJIHNlZSB0aGlzIGJ1ZyBhcyBhbm5veWluZyByYXRoZXIgdGhhbg0KPj4g
dXJnZW50LiBCdWcgd2lsbCBhcHBlYXIgb25seSB3aXRoIHRoZSB2ZXJ5IHNtYWxsZXN0IG9mIHNj
YWxlcyAtIHdoaWNoDQo+PiBtZWFucyBnYWlucyBvZiBtYWduaXR1ZGUgfjEwMDBYIHdpdGggdGhl
IGxvbmdlc3QgaW50ZWdyYXRpb24gdGltZXMgLSBhbmQNCj4+IGFzIHNvbWVvbmUgb25jZSBzYWlk
IC0gMTAwMFggZ2FpbnMgc291bmQgcHJldHR5IGluc2FuZSBhcyBlcnJvcnMgd2lsbA0KPj4gcHJv
YmFibHkgZ2V0IHF1aXRlIGJpZy4uLiBTdGlsbCwgdGhpcyBpcyBhIGJ1ZyAtIGFuZCBpdCBib3Ro
ZXJzIG1lIDopDQo+Pg0KPj4gV2hhdCBjb21lcyB0byBmaXhpbmcgdGhpcyAtIG15IGZpcnN0IHRo
b3VnaHQgcmVnYXJkaW5nICJ0aGUgcmlnaHQgdGhpbmcNCj4+IHRvIGRvIiB3b3VsZCBiZSBpbXBy
b3ZpbmcgdGhlIElJTyBzY2FsZSBzZXR0aW5nIGFjY3VyYWN5LiBJIHdvbmRlciBpZg0KPj4gdGhl
cmUgaGFzIGJlZW4gc29tZSBoZWF2eSByZWFzb24ocykgdG8gb25seSBwcm92aWRlIDYgZGlnaXRz
IG9mIHZhbDI/DQo+IA0KPiBIaXN0b3J5Li4uDQo+IA0KPj4gKEkNCj4+IGhhdmVuJ3QgeWV0IGxv
b2tlZCBob3cgSUlPIGZvcm1hdHMgdGhlIHZhbDIgZnJvbSB1c2VyIGlucHV0IHNvIEkgbWF5IGJl
DQo+PiB2ZXJ5IGlnbm9yYW50IGhlcmUpLiBGb3IgdXNlcmxhbmQgdGhpcyBmaXggc2hvdWxkIGJl
IHJlbGF0aXZlbHkNCj4+IGludmlzaWJsZSAtIHRoZSB3cml0ZSBvZiBmb3IgZXhhbXBsZSAwLjAw
MTk1MzEyNSBpcyBzZWVtaW5nbHkgc3VjY2Vzc2Z1bA0KPj4gZnJvbSB0aGUgdXNlci1zcGFjZSBQ
T1YuIElJTyBkb2VzIG5vdCB3YXJuIGFib3V0IHRoZSBleGNlc3MgYWNjdXJhY3kuDQo+IA0KPiBJ
SU9fVkFMX0lOVE9fUExVU19OQU5PIG1pZ2h0IHNvbHZlIHRoaXMNCj4gYW5kIHlvdSdsbCBuZWVk
IHRvIHByb3ZpZGUgdGhlIGNhbGxiYWNrIHdyaXRlX3Jhd19nZXRfZm10KCkgaWYgeW91IGFyZW4n
dA0KPiBhbHJlYWR5IHNvIHRoYXQgdGhlIGNvbnZlcnNpb24gZnJvbSBzdHJpbmcgdG8gdmFsIGFu
ZCB2YWwyIHRha2VzIGludG8NCj4gYWNjb3VudCB0aGF0IHRoZSBkcml2ZXIgZXhwZWN0cyB2YWwy
IHRvIGJlICoxMF4tOQ0KPiANCg0KSXQgc2VlbXMgdGhlIGJpZ2dlc3QgcHJvYmxlbSAob25jZSBh
Z2Fpbikgd2FzIG15IGlnbm9yYW5jZSA6KSBJIGRpZG4ndCANCmtub3cgb2Ygd3JpdGVfcmF3X2dl
dF9mbXQoKS4gSSB0aGluayBZb3UganVzdCByZWFsbHkgc2F2ZWQgbXkgZGF5ISBBZnRlciANCmEg
cXVpY2sgZ2xhbmNlIGl0IHNlZW1zIHRvIG1lIHRoYXQgYWxsIEkgbmVlZCB0byBkbyBpcyBpbmRl
ZWQganVzdCB0byANCmltcGxlbWVudCB0aGUgd3JpdGVfcmF3X2dldF9mbXQoKSBjYWxsYmFjayBp
biBCVTI3eHh4IGRyaXZlcnMuDQoNCkkgd2FzIGFscmVhZHkgZ2V0dGluZyBhIGJpdCB1bmNvbWZv
cnRhYmxlIGFzIEkgaGF2ZSBwcm9taXNlZCB0byBkbyBmZXcgDQpvdGhlciB0aGluZ3MgYW5kIEkg
anVzdCBoaXQgdGhpcyBpc3N1ZSAtIHdoaWNoIHNlZW1lZCBtdWNoIGJpZ2dlciB0aGF0IA0KaXQg
bm93IGlzLiBPbiB0b3Agb2YgdGhpcyBJJ2xsIGJlIGluIEVtYmVkZGVkIExpbnV4IENvbmYgZm9y
IHRoZSBsYXN0IA0Kd2VlayBvZiBKdW5lIChJIGhvcGUgdG8gbWVldCBzb21lIG9mIHlvdSBndXlz
IHRoZXJlISkgLSBhbmQgYWZ0ZXIgdGhhdCBJIA0KcGxhbiB0byB0YWtlIGEgbW9udGggb2ZmLi4u
IFNvLCB0aGluZ3Mgc3RhcnRlZCB0byBwaWxlIHVwIG9uY2UgYWdhaW4uIA0KTm93LCBKb25hdGhh
biBqdXN0IGxpZnRlZCBvZmYgYSByb2NrIGZyb20gbXkgc2hvdWxkZXJzIC0gYmlnIHRoYW5rcyEN
Cg0KSSBob3BlIEknbGwgYmUgYWJsZSB0byBjb29rIHNvbWUgcGF0Y2hlcyBUb2RheSBvciB0b21v
cnJvdy4NCg0KPiANCj4gR2l2ZW4gdGhhdCBJIHRoaW5rIHlvdSBqdXN0IG5lZWQgdG8gaGF2ZSB0
aGUgZHJpdmVyIHRlbGwgdGhlIGNvcmUgaXQgd2FudHMNCj4gSUlPX1ZBTF9JTlRfUExVU19OQU5P
LiAgUHJvYmxlbSBzdGlsbCBvY2N1cnMsIGJ1dCBzZXZlcmFsIG9yZGVycyBvZiBtYWduaXR1ZGUN
Cj4gc21hbGxlci4NCg0KU2V2ZXJhbCBtYWduaXR1ZGVzIGluZGVlZCENCg0KPiBCdXQgSSBtYXkg
YmUgbWlzcyB1bmRlcnN0YW5kaW5nLg0KDQpObyA6KSBJdCB3YXMgbWUgd2hvIGRpZG4ndCAob25j
ZSBhZ2Fpbikgc2VlIGFsbCB0aGUgY29vbCB0aGluZ3MgcHJvdmlkZWQgDQpieSBJSU8gOikNCg0K
WW91cnMsDQoJLS0gTWF0dGkNCg0KLS0gDQpNYXR0aSBWYWl0dGluZW4NCkxpbnV4IGtlcm5lbCBk
ZXZlbG9wZXIgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KT3VsdSBGaW5sYW5kDQoNCn5+IFdoZW4g
dGhpbmdzIGdvIHV0dGVybHkgd3JvbmcgdmltIHVzZXJzIGNhbiBhbHdheXMgdHlwZSA6aGVscCEg
fn4NCg0K
