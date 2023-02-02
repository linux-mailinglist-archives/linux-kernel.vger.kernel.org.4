Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0B687654
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBBHX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBBHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:23:25 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B3964DBA;
        Wed,  1 Feb 2023 23:23:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxrJ3UlMKUTeUZH1PxuAXblU2fuPotsiv+kVgHSBDrOYXJPNXc+KeitkjB29NUg8qVvkvcaKdQPB7fF2QSq0y33iwuDv0zK1f872yoVy46UObkpj8/FPmL61OYc0YmYNiVcG15gHWXZusMBPztUrhE2kZxC58yjVELwaez7ieoWpvus3RKIQbGDJwVka32UT7N5iP+s/r/TSPeX6b7wlZCHNq0CEFmje35hWPeLj2+MqYnP6+kMeMEeH/Z+JH3qCe1HvhXtMpirBHpj/+u9WCmtqFG8MAVWLPqHVl35JT6kd5JthiP+vckf3caaWk6TbrvNURTPPGHaSwOILsyL/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpXAf4rT0EV/kp49ABgsGgUTTXI/iQzLbh1P70oKpRE=;
 b=K6Pxq0vjBz+ecDYeBNCJzybpgoSG3ML/9ipfZczLUKxA0QI+crL8qSOspOBw+j6q+dgRH6Yt+bAjdswqC3TbSUQQmyydrdLdK1pE6OwSJER1KAdaoGXhhPjT461WzxmwNlyhBeSHgkm4UcRHKqLX+eebUSft69gXgIS7mBABFMiG/No0yQICn4kvJud9mNdVQ8uVnhA6cc+zaF1o9fdDMIDXFdjw99BENGoMdE4UF3GdNMGWel9JKzd/2G0P0qbOMp4YMMi+nmaWFOtBHgMaClR1szqTNYoeyA89JT9832hWfZroRQVUwhcmI9/F+XZnQ5346MDH//MN0zuNhOhE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpXAf4rT0EV/kp49ABgsGgUTTXI/iQzLbh1P70oKpRE=;
 b=sxe7pkniP6wWLe4xj6F3lfPIeEZyFInekVeXWjPL09ooA8XyqE6kQFtlLYL4Cv7jBjJXKysU7oMLKxD3kIKpEru1kFZ6zaavJaTrV/VRWyJg2+nvKtKJvk9nufOLF289rI7vvLmUFnNcfvvp5MqygSQbQs1gVOfsdazcgDc0mF0hmy0ulmifTaTL+pTXomfboXR7NBfnQMf6BE/lCUBhaid1K6V58gKmOZhUkxQ9E5ASImgziRW5pNSirNikGqgqCoUR98fZemstGvwzmSbRwLEIlmwerqmvh24B3jl2vkgpo52vb8ybB3rrrlTnHNqrBPUqZOZRPguNXigZHjhEGg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3320.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:23:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%5]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 07:23:20 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v8] module: replace module_layout with module_memory
Thread-Topic: [PATCH v8] module: replace module_layout with module_memory
Thread-Index: AQHZNo0Y6b+trPxN0k2Icbg1mllenK67QVkA
Date:   Thu, 2 Feb 2023 07:23:20 +0000
Message-ID: <1559bd58-0cc7-e643-ff0f-7be5e39992f1@csgroup.eu>
References: <20230201223219.355006-1-song@kernel.org>
In-Reply-To: <20230201223219.355006-1-song@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAYP264MB3320:EE_
x-ms-office365-filtering-correlation-id: 20038da4-6574-427f-7508-08db04ee5cb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hV/CF1LmmL1k6hBiFNCvtiGrwPm7JJZnd3UW9FHOmennc9tBzXcdw5uD3Y94Dae5sn6XzifO77Eexh9z4bpl/PzFJTUuqqhqCESfImjX1Tfj5/kufedh3n75F9QRARMN1Pc2hH1aoBbfo3OypXis4h+a2r3ySmOqGRuIi+qlYyzptuB4xaCyhdd8x7zSmGMi6oZJ3rlpZ5B3O6j8EffdQzr8OA7Jv6Oz5uoDgMReJmDsGJJbZ5ofPdYP2pMmheszSFn3ryNZhOZFk1MiYBQzx1xZ1TMd5T3cmrpvSOXsKPJCdNNJ/1ADxXU7NkmibXKylucevphjsnZBb9MCUIvJNust7JzBCt8tAY7BtVxO/vPrUYixRBVws4E1zYusWwCs6Pgs4jWsG3FT0hdtRVXGc2CHwry1/rxWdLmO8smfQFmA1xEdGtF7mrwFgNTc0rSmXr1q5FoY4TsgmOrOChSFsNwxf9MTH6WLiknw0vZjk8HwkaW9iNpxxpxYZsEQBHEwmRQ8hYGoszi+/IQFDiCWi+xbd/skqq4nR7/L6m00WcoYOAL7SElojdsKl0yOkAGz6lDNG5UUiTlKEfuwALWeK5IH2zrDTLp8kSfsy0Ln9o2ITN+nrU80IRXE+npt8Pc/Ecuoi94guTcCAzFu5rWv3uiAN9SNPoltq4eYWRtBZyL1RvaiZoyZ2lPwOXdjDD6ajXklUAN9yvbOQPLRlj/W1cz4g4gp/UKAEr5oYUKOMuz+0lgzniUAlt2ObwjzCT2vsvYm8RsHFREy6FtE3aE0Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39850400004)(396003)(451199018)(31696002)(36756003)(38100700002)(122000001)(38070700005)(86362001)(8676002)(91956017)(4326008)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(6486002)(110136005)(54906003)(5660300002)(41300700001)(8936002)(2906002)(44832011)(478600001)(316002)(186003)(6506007)(26005)(6512007)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2dDMnBOdkhNeXU3K1laUGlLL2pEc3BhdXRsSzg0V1dLbEUzbTJTRWg0eSsy?=
 =?utf-8?B?Yk9vYW5uUi9pQjl1elM2eEhRZ3pucjBPZTFkNW45NllCR0NKZ3phNWZTdFEz?=
 =?utf-8?B?aUNLZ2h0Z0RYbVVCaWJObEJmREpNUFM4bXkvNjNScWZsc3VpN0hMWWF4N2JY?=
 =?utf-8?B?QlI3WW5QSEN0RnNObk9MMzh4RXdOQndBd3BnUnJlRVFFRVFzR2I2UFozd2o4?=
 =?utf-8?B?MzBjdm8ydDVDc1NnYUhuWUx5bUgyK1U5UUhYOGtRZSs1bmNLUy9OME85bUZp?=
 =?utf-8?B?eDJ4Yk5EeGpNMDhvT01rMlE1Y0hGc0tZbzNlNDJEc1J1elRGL25sNkpLb0xl?=
 =?utf-8?B?cTAyVUw5cUV5VFBscVJPN1l2VWVCV2NGeWpCcmh6L0R6UzZQbmM0akNzdEJP?=
 =?utf-8?B?RUFCaG0wYmhac0l5azQ1WWdLL2pCNUNPL014N2VXdGZjVHcvcDBiY3RsRjJH?=
 =?utf-8?B?cUxuc09TMUJSakJoZjVpR1RWN0pTc3BGdm9lRk9UWEUwdmMwbUgzeGxmeHhG?=
 =?utf-8?B?b0ZXQnJDdG9KWllFWVQvVStFOHRDeEl5SDg2NS9veGwva0lncy9Md3B3QXdz?=
 =?utf-8?B?aHVyTmRzWEYvblJHV1VQdk1sVzZyZkhYemtvanV1VC9yeUlMdGNUZWR6V3FR?=
 =?utf-8?B?VXB6RmxuRWFKWTBibEpmbUoyTDBJSHJjOEZpTUR0QUxBcGZERFZhcWVBZmd2?=
 =?utf-8?B?SDgrMWkxd0dCa0FUZGRESG44eSsrVHZTeEl4R0JtU3l5RXo2eXphSEZSVDdt?=
 =?utf-8?B?N3k3WjdrOTRkbVZTeDhCVHUrcXFYZzRScEl2anZGNm5JVHJBYzZoNzd4Umpl?=
 =?utf-8?B?NmpkczZWZ0N5Y1JSazFyZVlFb2hDbWdoZk54RURlazhnLzVBaVBxVjNFYm44?=
 =?utf-8?B?a3poV0c1NTZ4cEdaVzVjSjVlbEQwWDdGV0sxWUZXOUJxcGplTDlnS0pubUw1?=
 =?utf-8?B?a3JhNEtTRy8zRlU3dkhGMWovUTNXYWZ6M3h1L3JUcmFnSDZab1RjTkxUQ1lC?=
 =?utf-8?B?cGZzd0ZQZTlXSTQ4VEZ4SktZNGtEUjJFWmpiWG95V0R5SElqS0hndG9IYWpG?=
 =?utf-8?B?R0IwZEpQR1NyRzVNUHFDQklGczd2RFdPRENlaisvZm1iT09nbTdRU3FzT0V5?=
 =?utf-8?B?TXZJQUdoTkRYOGNVeHJzRms0Z3FyZjIzMVQzRG9oV3ZQWGFOcm04Z0htWU9R?=
 =?utf-8?B?cmo2YWxNaHZFMUxTR0NETTlYblBZQzYzRlp6dHJEVEp0U0FGSVZPaTBqWEdU?=
 =?utf-8?B?NmJpeXVQUlkzVTNGUElBSHJhTFI5M2hYMHo5SExjWE9tUnkwalh4ajhDWXg3?=
 =?utf-8?B?emx4QVgwZVNrOXBhTUJJVndQY3VlK291Y0V6RjdKRERLaU95UXFLeWJ1dEFP?=
 =?utf-8?B?YXc3Yko1Tmd3VzlpcEtNRFdLVXdSd25yZ04rRlZ4eng0em95QTE1aS9QR2NL?=
 =?utf-8?B?TzNjLytGbTZOVVd5b2hVNDlGUTg1aEZxTk03UnFUR044eFJJTEsyYlg2OU90?=
 =?utf-8?B?RmhnTEZMY2xqbTJpVDBjNC9sc0V2YzVlemFuNTFraXhMWEl3U3JESk9PR3dw?=
 =?utf-8?B?bzRmZWcxZ1U3cnRtbWxWN2Z1dzh3dlFQS2NRdjZhTk1BVTlYVVNHQ2JadmZM?=
 =?utf-8?B?NW9vYllENmx4NkFoOXlrcHNpYytCZkoydjQyRFdrcnFoZUNuZGhQdTZqd2tY?=
 =?utf-8?B?djB1Vmh5dGRoa3djOUV1LzNGVGlpdEhQQm1OSFA1Qnc2Ti9XTEVHMUIraWdw?=
 =?utf-8?B?R3NnaEJad0lCalF3MkFLd1RMalU2U3FoVlR6TUdIV0pHZWIwL2tMYUlKVjVN?=
 =?utf-8?B?MHYzanFqWkN6OTcwUEkvcFJEem9UOWRKWkp0eklOTGUwZkM4VFJtTzJpMHVN?=
 =?utf-8?B?VVJiMTNmMDZCT2I5eWp1eC9KcG5SVk5pcW5HcHhmWnFUY0RIc2tJY0grM3RL?=
 =?utf-8?B?SDVac0lHVUdYVGtsK2wzaG5GeU9NdVZRWHoxNU9Bd2d2elFNMS9vRzdZaDl0?=
 =?utf-8?B?MEREUGovRU1XdkRnMXp3ZTE4R3Z1RTk3U0NWUUcxVlZadnJYSllrRTJYS0Ru?=
 =?utf-8?B?YXlGZVRiT0M1cHg5OWc2TmVHQms1SmFkNmNQT0FaaDlmazNTdDZWNHlCaTkx?=
 =?utf-8?B?SjNjNTA4UGVzeFNDRmNWczVXTGExbUdLRGpQZ2NaaTNDaXBzcHBySzN0ZlJY?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9800726DDB57BD4AB30F74D52D2F0553@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20038da4-6574-427f-7508-08db04ee5cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 07:23:20.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMBF3ivoX4X9p3opjadQ7mVDzt74MnZcDSN6aDxQYmqWR5C/S6i27ZdHua6SaorTgajKveQgVlLOUi/nSaMmZxSOsG+5YAhpCZa6AXUcyWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3320
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAxLzAyLzIwMjMgw6AgMjM6MzIsIFNvbmcgTGl1IGEgw6ljcml0wqA6DQo+IG1vZHVs
ZV9sYXlvdXQgbWFuYWdlcyBkaWZmZXJlbnQgdHlwZXMgb2YgbWVtb3J5ICh0ZXh0LCBkYXRhLCBy
b2RhdGEsIGV0Yy4pDQo+IGluIG9uZSBhbGxvY2F0aW9uLCB3aGljaCBpcyBwcm9ibGVtYXRpYyBm
b3Igc29tZSByZWFzb25zOg0KPiANCj4gMS4gSXQgaXMgaGFyZCB0byBlbmFibGUgQ09ORklHX1NU
UklDVF9NT0RVTEVfUldYLg0KPiAyLiBJdCBpcyBoYXJkIHRvIHVzZSBodWdlIHBhZ2VzIGluIG1v
ZHVsZXMgKGFuZCBub3QgYnJlYWsgc3RyaWN0IHJ3eCkuDQo+IDMuIE1hbnkgYXJjaHMgdXNlcyBt
b2R1bGVfbGF5b3V0IGZvciBhcmNoLXNwZWNpZmljIGRhdGEsIGJ1dCBpdCBpcyBub3QNCj4gICAg
IG9idmlvdXMgaG93IHRoZXNlIGRhdGEgYXJlIHVzZWQgKGFyZSB0aGV5IFJPLCBSWCwgb3IgUlc/
KQ0KPiANCj4gSW1wcm92ZSB0aGUgc2NlbmFyaW8gYnkgcmVwbGFjaW5nIDIgKG9yIDMpIG1vZHVs
ZV9sYXlvdXQgcGVyIG1vZHVsZSB3aXRoDQo+IHVwIHRvIDcgbW9kdWxlX21lbW9yeSBwZXIgbW9k
dWxlOg0KPiANCj4gICAgICAgICAgTU9EX1RFWFQsDQo+ICAgICAgICAgIE1PRF9EQVRBLA0KPiAg
ICAgICAgICBNT0RfUk9EQVRBLA0KPiAgICAgICAgICBNT0RfUk9fQUZURVJfSU5JVCwNCj4gICAg
ICAgICAgTU9EX0lOSVRfVEVYVCwNCj4gICAgICAgICAgTU9EX0lOSVRfREFUQSwNCj4gICAgICAg
ICAgTU9EX0lOSVRfUk9EQVRBLA0KPiANCj4gYW5kIGFsbG9jYXRpbmcgdGhlbSBzZXBhcmF0ZWx5
LiBUaGlzIGFkZHMgc2xpZ2h0bHkgbW9yZSBlbnRyaWVzIHRvDQo+IG1vZF90cmVlIChmcm9tIHVw
IHRvIDMgZW50cmllcyBwZXIgbW9kdWxlLCB0byB1cCB0byA3IGVudHJpZXMgcGVyDQo+IG1vZHVs
ZSkuIEhvd2V2ZXIsIHRoaXMgYXQgbW9zdCBhZGRzIGEgc21hbGwgY29uc3RhbnQgb3ZlcmhlYWQg
dG8NCj4gX19tb2R1bGVfYWRkcmVzcygpLCB3aGljaCBpcyBleHBlY3RlZCB0byBiZSBmYXN0Lg0K
PiANCj4gVmFyaW91cyBhcmNocyB1c2UgbW9kdWxlX2xheW91dCBmb3IgZGlmZmVyZW50IGRhdGEu
IFRoZXNlIGRhdGEgYXJlIHB1dA0KPiBpbnRvIGRpZmZlcmVudCBtb2R1bGVfbWVtb3J5IGJhc2Vk
IG9uIHRoZWlyIGxvY2F0aW9uIGluIG1vZHVsZV9sYXlvdXQuDQo+IElPVywgZGF0YSB0aGF0IHVz
ZWQgdG8gZ28gd2l0aCB0ZXh0IGlzIGFsbG9jYXRlZCB3aXRoIE1PRF9NRU1fVFlQRV9URVhUOw0K
PiBkYXRhIHRoYXQgdXNlZCB0byBnbyB3aXRoIGRhdGEgaXMgYWxsb2NhdGVkIHdpdGggTU9EX01F
TV9UWVBFX0RBVEEsIGV0Yy4NCj4gDQo+IG1vZHVsZV9tZW1vcnkgc2ltcGxpZmllcyBxdWl0ZSBz
b21lIG9mIHRoZSBtb2R1bGUgY29kZS4gRm9yIGV4YW1wbGUsDQo+IEFSQ0hfV0FOVFNfTU9EVUxF
U19EQVRBX0lOX1ZNQUxMT0MgaXMgYSBsb3QgY2xlYW5lciwgYXMgaXQganVzdCB1c2VzIGENCj4g
ZGlmZmVyZW50IGFsbG9jYXRvciBmb3IgdGhlIGRhdGEuIGtlcm5lbC9tb2R1bGUvc3RyaWN0X3J3
eC5jIGlzIGFsc28NCj4gbXVjaCBjbGVhbmVyIHdpdGggbW9kdWxlX21lbW9yeS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+IENjOiBMdWlzIENoYW1i
ZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4NCj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPg0KPiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
Pg0KPiBDYzogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBDYzogQ2hyaXN0
b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KPiANCg0KICAgQ0FMTCAg
ICBzY3JpcHRzL2NoZWNrc3lzY2FsbHMuc2gNCiAgIENDICAgICAga2VybmVsL21vZHVsZS9tYWlu
Lm8NCmtlcm5lbC9tb2R1bGUvbWFpbi5jOiBJbiBmdW5jdGlvbiAnbW9kX21lbV91c2Vfdm1hbGxv
Yyc6DQprZXJuZWwvbW9kdWxlL21haW4uYzoxMTc1OjE2OiBlcnJvcjogaW1wbGljaXQgZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24gDQonbW9kX21lbV9pc19jb3JlX2RhdGEnOyBkaWQgeW91IG1lYW4g
J21vZF9tZW1fdHlwZV9pc19jb3JlX2RhdGEnPyANClstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9u
LWRlY2xhcmF0aW9uXQ0KICAxMTc1IHwgICAgICAgICByZXR1cm4gbW9kX21lbV9pc19jb3JlX2Rh
dGEodHlwZSk7DQogICAgICAgfCAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fg0K
ICAgICAgIHwgICAgICAgICAgICAgICAgbW9kX21lbV90eXBlX2lzX2NvcmVfZGF0YQ0KY2MxOiBz
b21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQptYWtlWzNdOiAqKiogW3Njcmlw
dHMvTWFrZWZpbGUuYnVpbGQ6MjUyOiBrZXJuZWwvbW9kdWxlL21haW4ub10gRXJyb3IgMQ0KbWFr
ZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjUwNDoga2VybmVsL21vZHVsZV0gRXJy
b3IgMg0KbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjUwNDoga2VybmVsXSBF
cnJvciAyDQptYWtlOiAqKiogW01ha2VmaWxlOjIwMjQ6IC5dIEVycm9yIDINCg==
