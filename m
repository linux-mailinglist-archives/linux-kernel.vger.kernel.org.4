Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32829600BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJQKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJQKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:04:31 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA73BF71;
        Mon, 17 Oct 2022 03:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6Tg2Qf9HHT1k4nw8HhgfnubPRA90T7KLwvl2H2WZzjmVaKuw7lPt2aBIxnIALKo2JYeNKYKLE+HEKRUR7/jXVNFND3KxNikyqxGzS5bCqaCSlqUUjU9X983UyhHK8Nw87qO+lXkgxncrXj4ngNNzHTS+PTfNFhdyXP9ofoUS6tRqjonIo7nMtf2pOoNBjxqlVYsxKJf5wxU1H6R5jjFD16jZOxnXxma4xk8zG48PNTvlw4BAjKmEZLM82qCWIhqmZIIfL6SDOXWUYSJmnH3mndUSTMwADonyimydzeTGZfZ7+bDq/evCiZ4JTotdUlmnrtwxEdsjXiZimxUyhZvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTaXzuA9YbZVTtilJV9qP/ePr7jsNodlP8GE04DLojo=;
 b=nCwxVTmTil39GcY0IBcHqabI/J6U2W9SibkAbhi4QA8XazohOHQfzGx/P3/5kO+f592hrR6qEN/V1ROrzB11GUeaCd1UwpVBbOsHa5ABbAoDa3VfixSn7USAQNS5YrV8qmdDccLiq5IuO/JsSSITRcIVfDvao9NTS3Z0CMWIpS5Ef8txFBEBh9Z40x0oEW9McmYmLTRkEWFQ69nm6ppOGntm9fZAEWQlXNayh6BuguWfo1GO1zSBoN/qoXpmm17/G0BL2/qHmibICc2QqLxFVwjI9VwopL7T6GlYG6lUqMpJUrR0uvtqxZY4EdoyYxYjFHWg2y5uRNeQEfCoh7VEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTaXzuA9YbZVTtilJV9qP/ePr7jsNodlP8GE04DLojo=;
 b=P1WHyP1OTCSKzyzxRCNs+k4eBHuXkCg/aZElKM9yoBO7j+mLrmDGDJl7U5Lwk0IVAyJ74C8l1hS5kdr2ENMp3T7ynkGxWNhjB6XF5ZsVcWBv9RY2JvUgAUmMjysFkEoAx34I+eskQCtyLd2ednviWh7l5SLgMyjSeDmnbKcdQ8MjP2qmanwQzU5VrmFJ+d8kHU4c6NY/KYhOLmpJx5AHcgHEOeq7nwmQF3OdoS2VfwEiR8wBZPjdfpy63MyGBIt6rwW/0ura1z6MpHjTpXnG1M+98YGJW0QsZznhhYDwqHtiJSVxiegv6geec/ISVTHYv94LRyZJhtf0HVBQBlRs1Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 10:04:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 10:04:26 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Thread-Topic: [PATCH] null_blk: allow teardown on request timeout
Thread-Index: AQHY4R8DFU2LJu/Wy0udZZqXPfzvLK4SUpaAgAABcQCAAAV8AIAAA+wA
Date:   Mon, 17 Oct 2022 10:04:26 +0000
Message-ID: <52913ebc-5f01-bff4-9b2d-2ee9caf4719d@nvidia.com>
References: <20221016052006.11126-1-kch@nvidia.com> <Y00fkc1N+Cif/Kxt@T590>
 <0af3d1a4-8166-ea1e-8710-c51479c587a1@nvidia.com> <Y00lYIhUNv1CxqiK@T590>
In-Reply-To: <Y00lYIhUNv1CxqiK@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6861:EE_
x-ms-office365-filtering-correlation-id: a7ace457-f2c5-401c-e7e0-08dab026f94c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xn6HXftiFl5Qla/BVSG4El8L7rFXBylNkW8EAbRKQJc3heZkc2KB4K+FreuxEG77V71FE5Nkp0/ijnCon41N+BALK/BvH1mOlmbkpgb23p7ZUzV8K4qMKFzegSL6A7EBKM5zfiXhHcvbtlds7phsDLVT8vEU2VQTKylJ2jX/aqmB8jTnS8ZRxWTr2/PQFebIhpMk7kY3O3+jc/4z48h2eA9ZmWLNRbV1b0vHXidnw0bMZAo+cWjukgPr/Xh1Zftuzvfwl1Rhj9gOzZiVWzpkICvT8IfeMMONorEaOeitgg7dWkcW2fUNybPVN+Ldg1VMuD4H6AyscO9Zk85gFFaYz3v0OwWD/Qy8akKYt1O0m3z5lnIJpNaASuO3/5hMmbhKg/xTTlkxSGK65IVkRw2LmWdZ4P6YMn+BKzAFMLbKxF2VaMOZJajIZbNL25xYBxGyQzNwCHeSWEM/vVcATxM22m5ICeUhPjmqaT97DBgREkw/rAexYJCEfblfYCcjWwdIjeDpvgldbLqP6HqRZRP8rKI2ukhBoX3vWQ7iEjrKre+bKqYNj/BDndrohOA0dHmGGK9idsjWNZ9QkUGaxdvrPzx/K4MxiRWipbntpVNdttlC4WKWLUucOGgZn29MI3A7kj3b4gEPNOLjJ7CXg3VWHbaDi9BRfU+Noy5wLd43HK7wqr1ORL+xR4OBojjhDeQUCJLVaZvLq+/RHdYDvGNLZJ6bKws6Emb64r59yGYSGnUql3tnClS2ePSFYNIb9pU5TRnM+CE/gpm47JGKpgjjavBCRKn2BEaaCjOj4Lm90s5n7bTJ1jfcKMaLMf8zc+y4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(38100700002)(122000001)(71200400001)(38070700005)(6486002)(478600001)(54906003)(6916009)(36756003)(6506007)(41300700001)(186003)(2906002)(53546011)(2616005)(316002)(64756008)(66446008)(66476007)(8676002)(4326008)(86362001)(31686004)(76116006)(66946007)(66556008)(91956017)(8936002)(7416002)(6512007)(5660300002)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V29NU0ZrdGUwdWFNc3FWQ0Q2V09ZUFJZcFFVdkQ0OWZmaDN1WEcyeVp2RkpV?=
 =?utf-8?B?aTJ4bzVIYmFacGdzU2RvRGd3SGtiZ1hHUXJLU1NtSTdZZVd1d0NSTnFJSldO?=
 =?utf-8?B?bGpGb3VYdDQxWVA0WkhjdFNNU1dEY2ZBVHFtdjQ0cjU3YTlUUlNFY2pVc0Fw?=
 =?utf-8?B?R3ROUlMrZGlzNjFtdk1OT2ZlNG85SW9RUnUyMlF3TWJ0d3hXM0FIVDhZZnZB?=
 =?utf-8?B?S05oNE9rTFhpMWdlTVRCUUY4bkxjYW5Nc0h1Zno3eDhnSTNmVGZ0Z04xR3h3?=
 =?utf-8?B?YVlJeWhWeFJGSFNsbDFrcjhyOE82NXVjemloUk1JS2N2cjNNWnpaR01VbEhM?=
 =?utf-8?B?QXFkY0ZMR0Vwc1U5S3hYeDVVYzRuN25paHJHMVhHQUxFRlEvdlk1dnVXUjVs?=
 =?utf-8?B?czhoTUE3M2J0aXpDNkpsd3gyTEdETVI1dW4zYXJJazlyT29EQUdKTUFpbnJP?=
 =?utf-8?B?ZHgrL1RKaG1vWHhaY041QU5lYmhYUUN1RXZ5bkVrLzY1cnlXOUt2TE1TZEN3?=
 =?utf-8?B?QVluN25IK0xBTFdCK0dNNDg2Znp2MGt4MlNZa0FENkwxNzJXTnZLamFKa0NM?=
 =?utf-8?B?SjNBRlpRQU9Camg0V2FVODhXMXFmb0N1ZzFjazBpV2YwMnFaTHEzc3haZFk5?=
 =?utf-8?B?OUE3VjhXcmduMHo5d2hlT2VHUDlsZXpzSFRGV0c3RmJoRk1YYkdlc3lkdGRz?=
 =?utf-8?B?S3BkbWVJVlc5SFBnNmRIOHhUdytHdERKNllxRUtiSHhCeE5kYnNwb0xuS3hR?=
 =?utf-8?B?OXhPcnhZZXNxTXhyQUJ6OCtTcHVBZVMvbXZHRzdieFN5N3BjQmluUGxySDJ6?=
 =?utf-8?B?dFlVa1hnQ21CVE4rYlAyOUZWQW9YL0FjZlVMK3hCWkVsb2MzOFFRS1RmZ3Zn?=
 =?utf-8?B?NjJjcDkveTQ1dnVXYVJIVitMVXhzZjQxMXRSc1dOczllTSt0L0hCbHU4cGd2?=
 =?utf-8?B?blg5RGdKTlNDekZNUEJ6dGg3eTZqaCtZMThseFNjYTI3djl5WWZmZWpHT0lt?=
 =?utf-8?B?YVEzZlFsK1JkZWpmWHF3WUpuOVh0SGNtYXU3ZlV3NDFPT2wzQ2FjZUo5dy9T?=
 =?utf-8?B?aitOUUFYVGxGWmU1eW91ZldqRWVkZGtRNFhjRGs0RThWZUNQcUtoK085MUVN?=
 =?utf-8?B?VGREaFpEc3BUSTdGWWpaWnNHQmFjVDk3dUh0c0Y0a2NVbEZ6bEhQei9PVFAw?=
 =?utf-8?B?SW5FRzRNd2ZZeGNOOWhyZzMxTTZIOEpHZllxYzN3MEZyLy80eGVJMndJdWNt?=
 =?utf-8?B?dktWc1MwM0N1Umc4RGtseVFKVHFCNVUvekJYVGlKOUZweDV6aktwM1pkTUhC?=
 =?utf-8?B?RFVlS1kxaVhjMHcwZWkvaTFVYjhmZ1B6UExmMGZISFhoWUFicHZhMFkwZWw0?=
 =?utf-8?B?dmxIelA3ODRZdVVEZ0YvdTZzV2x2cTFZTldMcXdzQzk4TEw2aXNrZStCMnFl?=
 =?utf-8?B?elYwT01YNkZYeWk5NUpqMFRvOFVrUUJkRUVtQU91T0l0dVUxTk5lWkhmT2pD?=
 =?utf-8?B?Y2tPaDgwL3FNaGsxclE4MVUwRjJBU3VQelBPWmYyTTZvQVhFNnBNb0ovY0E5?=
 =?utf-8?B?TTRCOEZRY0Q5UFFybG9SaEFyTVltenVNemE1Qk15TG52enZvaUh0VnZONFQ1?=
 =?utf-8?B?MXhDaCtmMmZJYlIvR21BaFp1NHF1V0hYbi85U04rc1ZWSUczQWpWMHRJWCs4?=
 =?utf-8?B?TGlSTldjOUlSVTFhWnFLL3hrSWtCOTZ4dXl5clFMTGtmaFoya3FDQ1JmTUU1?=
 =?utf-8?B?SWhXN0sxaHpLMCtYRWhBVnJuYVJLZ0hrQ05MQk1KN0htMzBqbkFYUlFibFJk?=
 =?utf-8?B?VlhQOC92Q28rT1VRemFBT1JBM3RhV2Zob2RXeDZFUTRibyttOUNRZEl3YTds?=
 =?utf-8?B?TFcrOFlpcXRYM2N0K3RzL0h0T3pyNnc1OVQ0OWRoZVJndHE4ZGZoQmg5NGlZ?=
 =?utf-8?B?QmhlejRZYjk4bnBpWkFlY1AyZEtrWjA5aG0rTEZBYklOK1dkRjZ6c2JDTllH?=
 =?utf-8?B?NEJEdmRBZFhDcDBpU0tlNFgrK0lrdStTSml1RkhjT0xyNTIwRjVXR284bExC?=
 =?utf-8?B?VVM0WTd3L0xtajRta3Z4WEphdjd3c1l0d0hnNWVaZngvWktFc3l4aHgyUUhx?=
 =?utf-8?B?dVFZaVdrZERDRW12Q0x3bkk0R0RPTHVIbElrSmlHbFhLWU56NGVFS2xnVmpM?=
 =?utf-8?Q?6IGhwCzaKPBCSLVJq7b2yIV+ZDS6uDn3ald2jv87x8D+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5834491A48CD774D9ED7CBA1BCB009B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ace457-f2c5-401c-e7e0-08dab026f94c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 10:04:26.4002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I92+oDUgVKKts6mwUzVRJh1Axbzi6gA2tUPbu2ytMYwxmBfm/pHUtIJXTV1JbAR5dV++unl+WGQyIJw3hQ82lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTcvMjIgMDI6NTAsIE1pbmcgTGVpIHdyb3RlOg0KPiBPbiBNb24sIE9jdCAxNywgMjAy
MiBhdCAwOTozMDo0N0FNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+Pg0KPj4+
PiArCS8qDQo+Pj4+ICsJICogVW5ibG9jayBhbnkgcGVuZGluZyBkaXNwYXRjaCBJL09zIGJlZm9y
ZSB3ZSBkZXN0cm95IHRoZSBkZXZpY2UuDQo+Pj4+ICsJICogRnJvbSBudWxsX2Rlc3Ryb3lfZGV2
KCktPmRlbF9nZW5kaXNrKCkgd2lsbCBzZXQgR0RfREVBRCBmbGFnDQo+Pj4+ICsJICogY2F1c2lu
ZyBhbnkgbmV3IEkvTyBmcm9tIF9fYmlvX3F1ZXVlX2VudGVyKCkgdG8gZmFpbCB3aXRoIC1FTk9E
RVYuDQo+Pj4+ICsJICovDQo+Pj4+ICsJYmxrX21xX3VucXVpZXNjZV9xdWV1ZShudWxsYi0+cSk7
DQo+Pj4+ICsNCj4+Pj4gKwludWxsX2Rlc3Ryb3lfZGV2KG51bGxiKTsNCj4+Pg0KPj4+IGRlc3Ry
b3lpbmcgZGV2aWNlIGlzIG5ldmVyIGdvb2QgY2xlYW51cCBmb3IgaGFuZGxpbmcgdGltZW91dC9h
Ym9ydCwgYW5kIGl0DQo+Pj4gc2hvdWxkIGhhdmUgYmVlbiB0aGUgbGFzdCBzdHJhdyBhbnkgdGlt
ZS4NCj4+Pg0KPj4NCj4+IFRoYXQgaXMgZXhhY3RseSB3aHkgSSd2ZSBhZGRlZCB0aGUgcnFfYWJv
cnRfbGltaXQsIHNvIHVudGlsIHRoZSBsaW1pdA0KPj4gaXMgbm90IHJlYWNoZWQgbnVsbF9hYm9y
dF93b3JrKCkgd2lsbCBub3QgZ2V0IHNjaGVkdWxlZCBhbmQgZGV2aWNlIGlzDQo+PiBub3QgZGVz
dHJveWVkLg0KPiANCj4gSSBtZWFudCBkZXN0cm95aW5nIGRldmljZSBzaG91bGQgb25seSBiZSBk
b25lIGlmZiB0aGUgbm9ybWFsIGFib3J0IGhhbmRsZXINCj4gY2FuJ3QgcmVjb3ZlciB0aGUgZGV2
aWNlLCBob3dldmVyLCB5b3VyIHBhdGNoIHNpbXBseSBkZXN0cm95cyBkZXZpY2UNCj4gd2l0aG91
dCBydW5uaW5nIGFueSBhYm9ydCBoYW5kbGluZy4NCj4gDQoNCkkgZGlkIG5vdCB1bmRlcnN0YW5k
IHlvdXIgY29tbWVudCwgY2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlIG9uIGV4YWN0bHkNCndoZXJl
IGFuZCB3aGljaCBhYm9ydCBoYW5kbGVycyBuZWVkcyB0byBiZSBjYWxsZWQgaW4gdGhpcyBwYXRj
aCBiZWZvcmUNCm51bGxfZGVzdHJveV9udWxsYigpID8NCg0KdGhlIG9iamVjdGl2ZSBvZiB0aGlz
IHBhdGNoIGl0IHRvIHNpbXVsYXRlIHRoZSB0ZWFyZG93biBzY2VuYXJpbw0KZnJvbSB0aW1lb3V0
IGhhbmRsZXIgc28gaXQgY2FuIGdldCB0ZXN0ZWQgb24gcmVndWxhciBiYXNpcyB3aXRoDQpudWxs
X2JsayAuLi4NCg0KLWNrDQoNCg0K
