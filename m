Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4F5E98FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiIZFuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIZFuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:50:39 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120053.outbound.protection.outlook.com [40.107.12.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058E1F616;
        Sun, 25 Sep 2022 22:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSzbuO7OLsXNBa/6bE09gs0NLGcxz2CdkIN6UmcbZ/jYi9tED4OSB948ZIzClZKegsjIgtvuP9Lr1PYid25PHmBFAgbvMdmZnp8c/FRRPUb64sWtoKjwexyQZ7n24tMfxLuCFv/gb8xit1laYMq5WWZuNGZlZ6QFgsvPssbFtukSiEpeS4mT4IMYBIeLA3sxWOOMQosj7hVhAep0CSyDXByk6168cKjDBikeT1ZrU6mt4uAxtMJrIz91ommujts9lnCGnlXBgzB1fv/q5+NfQvWFyacAgB8dvd5ErDNrJOVaCZpNcd0HKQFUGsYoH3G7SnDxExknpWOIfN16bsN8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0BdvWzPsbSA1KdkqLTvfyHdpEuxwdXoyAuHeGsKBlY=;
 b=AshOKEESB7cqAETA4MqWaRwU25aXq9+vbVY7qL7Bl6RsXIDvNLy0lN8ZwzRnax2A8Nb68KoZf6oyyV8lOL0LV1GcpbyLy0VLbl0wsJMWXHHEu8RGkOtQMEQW1J/lrfnzIYXjhBa93i5V1kctSqidxhIF/JHuRS10u31JWm7vqAoSGHa5rmxMkPFFnmuD4w6pmJzLQDpcOh9n2QXBDgONoYug8yNK909YRznTo8Lo1yB1ujiK3Eb6tNnU+p6uy3iojbfbMvwwFexPvgmt9oWYWr+5fEaTiFYlmwAn/kVUsxu2SyElBW+MWiyHYJT27KwKBsItTUqZpsGtp3H56hnv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0BdvWzPsbSA1KdkqLTvfyHdpEuxwdXoyAuHeGsKBlY=;
 b=nLvKVmaW7AI1gZXIcOipJa8k/a2yu7PIAMb470G4YAX7zJXnlr0Di6+zVqgRIeJazPkcFZLoehbUFak6H8N51HemvSOdKb9TYAPHgInuB31HwKXPj9Ix17iq/PJwvBnP3uHEaiVvo4VV9mDNysaF6fE4nvw16QQGSztzaYEeudA6eJtAm5idt0SDDyJbQepzenMqC1QrtJkkP598ItUhedX3IGXc9R2FGEZseJStjhBJicN+0xsKgsUVqKucnPDYdhG7BuUiW3UqtVgBZN+iDHdbcXj/ZTayPbu5JViPMQ0UlgmJH1TthnJ6rQ3A2mHpQIze0rQN6wfS91EuEHW4hg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2376.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Mon, 26 Sep
 2022 05:50:34 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f4ad:3944:a7f4:fcf3]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f4ad:3944:a7f4:fcf3%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 05:50:34 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH -next] module: Remove unused macros module_addr_min/max
Thread-Topic: [PATCH -next] module: Remove unused macros module_addr_min/max
Thread-Index: AQHYz+chPhSPkZvS6kKNHdkSShHvSa3xN/sA
Date:   Mon, 26 Sep 2022 05:50:34 +0000
Message-ID: <6ddafe26-a5c3-c617-526e-f41dfb57b82f@csgroup.eu>
References: <20220924072216.103876-1-chenzhongjin@huawei.com>
In-Reply-To: <20220924072216.103876-1-chenzhongjin@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2376:EE_
x-ms-office365-filtering-correlation-id: 51a5f7de-e5bf-4503-5dfd-08da9f8307cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utW+TOFxE3u47o7jgtY5q4WJllke6aDrKhJMESP+qle4g7PeO7K2YL9DHkqwINEpWClxAEqdL+de7ooqacyRQ8/hjQkq4tEqJXkaTg9zKiChnikECLC2PJlXf1pjK7th89VXfX6u4SD4uv334bjD8yabtvGp9LUDh5h/0DtbXalYf5JYTT34dTh2FwD3RMlWpnKdeeDWnjZBRMXYVM7BKyfmP0Tka+uhAb0JN6ifwyN4ZsUuaG2ZueGWWi8AKklRRuWeQPGjIaMtdCbgt8W7w5jUsk0Zhz/oKpydN5bJLC4l+me+2CVAIts+dSgRXEnApuqTjYhsbqUkzwDGUPiIt5y40e5JPz1PtQ9Zf0puMB2MF76a1LkUujCtTj/Q5LV3lDUewexxGYc9OO1GtAUQeq+nSWx942d136doZgWHBKz59+oweAsY+MZGYLf+74JlfwJhNXYgkjs/9EaC02KvDTIvS7LX2lw+IDCaPqZnzGpqErcFlhjj0W79YyN+mW+/+m3xAmPsF8AWzXPzpYtOqQ6dYeK/XR/SCXPtTR+VI1Bh7gG8viaYaYUQ841lxMgI9ovYH9ITdR1ifCB9YyEt+qo6SSgatWjin8DVFrSS1YgkTd0YJfJkA3Ho8nkqsBQKPekW0DL9M5/9hlsrP3FiD9rtZmgwaI0B6Oq/WlSgdFeE3QiB8jgMovwFUe0iQ/kN81Sy2yASjLWUV3qVVSZUmybbITsaGpJCDNoPr93Za9N8/BstAUZrY0br5sLecw00Nx8l8sErnEdyzBZ73uIeHsi/BbJCU52LutlikWb7goIfT/KMrllOa+iMg5SwJdA2tzL+Kgbb2ysaQOcdJM22+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39850400004)(136003)(451199015)(38100700002)(8676002)(41300700001)(76116006)(66946007)(66556008)(91956017)(122000001)(26005)(66446008)(66476007)(64756008)(4326008)(186003)(2906002)(2616005)(83380400001)(8936002)(6506007)(36756003)(6512007)(44832011)(5660300002)(31696002)(86362001)(71200400001)(38070700005)(31686004)(316002)(6486002)(110136005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzF6QkR0TE5IWFN6QzloU1FvOUd3M0x2WTF2Mkl4ZGVzL0JteXRpdHdHWHNI?=
 =?utf-8?B?MHBCeGd2VzFoRlpjbGcybVhiUVdUNlZxbDNGREV4MzUvUjhWdmJuQTdPRlBO?=
 =?utf-8?B?WEk4V0FnSFErZERDNkZHVmUrKzJDUDZoSVVROTFvaFpjVFlpYW9uSFpwYWor?=
 =?utf-8?B?ZDV0cFcvUFZRdkMrZzJNS0RhUUZ5eUtKTmUzc1NtcEJnYmU2a3BEN3JLdGxM?=
 =?utf-8?B?bXlVT0VmK0ZORkI4THNoSDJ4WkRhNzJobmJ0blNTSnIyK1E3OEkxTmN2bFpB?=
 =?utf-8?B?bDRTK3BjeG1zeW5BUDZMVXNGQStXcnpBdlJweU9UUHA4bHZxRzd3cFVhSGFD?=
 =?utf-8?B?Y0g4VFVhRVU2YTVNZUhOcVc3VkF5TEV2WXdQMUJVaVU0eUNOZ0JLd2JBejNF?=
 =?utf-8?B?YmgvZmNxUWZKN2NBNGR3VDhxWjVqajNDeFppckd0WUxSTEdFTVQ2VStFR1Bo?=
 =?utf-8?B?STErNGVqQjNGNlFJZEl2RVcyMDFvM0M1b3BuQlA0K284V1VJVC8wTWgzcndx?=
 =?utf-8?B?MFFKRi9uL0E3RjIxWTJzbnZWZWt2S3NRaHp4MWNWS2pSUElBd1ZvVjhuVGRH?=
 =?utf-8?B?OElrc0MrNVQxY3EydjVkM3prQlo3Z1JIa1c4MUJvZ29NbzNuc0VrcEoyQzVx?=
 =?utf-8?B?MUtOS2drYmpDYUNFVW1DbnpiSW5ib0VZbnUyT2JxMWt6MG90TE1DS3NxcU1H?=
 =?utf-8?B?bE9FTXV0d1ZnTGsyYnRtd2NqSm1CWmJhZWpsay9Eczh4cnNJMVNRWkxYU3pG?=
 =?utf-8?B?R1UwSTlGUnJrcHB5N1FyK0g4U3pXTzJQQVVROVRQcDdYOUR4TXNhZ0dEVXlQ?=
 =?utf-8?B?dmZHVkJTT0N2eE9sTUdFdEliZ1hPZVNJRTFpcURScTRKdVJMZ2J0cnpCZTM0?=
 =?utf-8?B?MG85cGU4MU5iVGFCUTIwM2l4cHJQODJGTDNiRmUrRklJN0l0MkZHZFlGWElp?=
 =?utf-8?B?dDdRQ1dRY21IQlNZTlA2NXlzbFJlaVYxS05iZmtuUUcvSEJ5b0ozV0QxNFFQ?=
 =?utf-8?B?TnVyM01KQmY0c2tGTWVJcFd4cXVYeDl4N1BXYnUxV2JCMkk0OVhueEcyUDBq?=
 =?utf-8?B?VlVHYU9OeE5Odng0WGtIazdKNTFURHdNb0x2YUtsM0dYRHJUTDlSa0h3K3hh?=
 =?utf-8?B?UkpVZUMvSEZzSDRheVUwNEJTT1pVeVpFQVFVM0VVQjBtaEFRd2RtYkRNN0NM?=
 =?utf-8?B?Tmo5MHZYTG1kY1ZhS3RVZmpUWUJkU2YxRTZhTHBTWndTWllMeVBudlQvdU55?=
 =?utf-8?B?OTlTaWpXZ2MrUExodVRSdGVmaUd4S1pkbE84b1NzNTlXa2R3V2VuWnFFMEJZ?=
 =?utf-8?B?V3ZzWkl6b3lQazVLUzJxWFl3R1QvNG1RTnZpOUo1anl2TDVxQlZqUUltdW45?=
 =?utf-8?B?Q2p4MXlXYXMzdjFoTnBJUm02L0JWRGxmcFNiakYyK2ZOczV3K0F2d2l4bzln?=
 =?utf-8?B?OWZ4cEI0UDg4K1hPRlIva3VpbEFxdVhWa0ZlaitxTzFYOXl3eW9GaUxqTXFp?=
 =?utf-8?B?RUxHeDdkQ2tzbTFEemNUL3F0dThaY1B1Tk5BNWlDbjFTVkFOeFRTdy9aT1JO?=
 =?utf-8?B?RTVUaHVsTXkvcHRsd1FjM3ZTejFKUzFFQkVYVzlidVpIVzFnVUJ6L2xQNXdT?=
 =?utf-8?B?a1dORE5LTUgybWZoR2xFRnd0bFdQZmNsVXRxRGRUYktKMVZnTGpia0NhZGdS?=
 =?utf-8?B?bVN4b29tZmZCQURSemw1UWpmdG50eHNDUG5HWjFqVGx2RzVQalhYUDVlTTB1?=
 =?utf-8?B?K2pTb011YjdSNFJvbHJmazdscjVCZzdZU2E1TExIUWVJNm5kUUR2eG1TcmRU?=
 =?utf-8?B?VU5wcWlUbUUvVFk4VE56T2llT3RqeHNpOUVXaUxacis4dXd3L3RhdmpOUS90?=
 =?utf-8?B?SlRDb2F4K1BrSnVER1RpeVR5TlBhUHRkc0lJZS84dXFqM0JwUERNczJXOHMr?=
 =?utf-8?B?U3g3S1RuR3FXMlROSU1KRnd5OXJaWUxudUlxcXBCU0dJQ0EwekRHTERCc2RC?=
 =?utf-8?B?dGg5OFRiNWdRUWJpY3M1eTdqaEVIVUtwSzVQbTlNMUJYMTdNeTFtWkZhYWhk?=
 =?utf-8?B?K3loT3hkSk0yWnNDMVJSbTRvVkZYZ1EwbjNsbDQzcHdiT25ycFU4WURkUUV2?=
 =?utf-8?B?VDMrakRyQUwrTkhVVncvc1RJTTVPU1Z1bTJIeWJRNnZDREE0cWQrbG9McUZl?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9664349BB04B464AA6E5C48BB61F9D95@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a5f7de-e5bf-4503-5dfd-08da9f8307cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 05:50:34.6087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/t8eZPAYx/VW1dX8SiDGWuOF/+mSw0FUxdGzKI9/PptrAXmsAWnZgaTVA9a/LdZbVhZy6I8HFg/qBxQbd04NUneMIZGCP7eBWZzkgvG6gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2376
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI0LzA5LzIwMjIgw6AgMDk6MjIsIENoZW4gWmhvbmdqaW4gYSDDqWNyaXTCoDoNCj4g
VW51c2VkIG1hY3JvcyByZXBvcnRlZCBieSBbLVd1bnVzZWQtbWFjcm9zXS4NCj4gDQo+IFRoZXNl
IG1hY3JvcyBhcmUgaW50cm9kdWNlZCB0byByZWNvcmQgdGhlIGJvdW5kIGFkZHJlc3Mgb2YgbW9k
dWxlcy4NCj4gDQo+ICc4MGI4YmY0MzY5OTAgKCJtb2R1bGU6IEFsd2F5cyBoYXZlIHN0cnVjdCBt
b2RfdHJlZV9yb290IiknDQo+IFRoaXMgY29tbWl0IGhhcyBtYWRlIHN0cnVjdCBtb2RfdHJlZV9y
b290IGFsd2F5cyBleGlzdCwgd2hpY2ggbWVhbnMNCj4gd2UgY2FuIGFsd2F5cyByZWZlcmVuY2lu
ZyBtb2RfdHJlZSBkZXJlY3RseSByYXRoZXIgdGhhbiB1c2luZyB0aGlzDQo+IG1hY3JvLg0KPiAN
Cj4gU28gdGhleSBhcmUgdXNlbGVzcywgcmVtb3ZlIHRoZW0gZm9yIGNvZGUgY2xlYW5pbmcuDQoN
ClllYWgsIGl0IGxvb2tzIGxpa2UgdGhpcyByZW1vdmFsIGdvdCBsb3N0IGR1cmluZyBhIHJlYmFz
ZS4NClNob3VsZCBoYXZlIGJlZW4gcGFydCBvZiA1NWNlNTU2ZGJmOTIgKCJtb2R1bGU6IFJlbW92
ZSBtb2R1bGVfYWRkcl9taW4gDQphbmQgbW9kdWxlX2FkZHJfbWF4IikNCg0KUmV2aWV3ZWQtYnk6
IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2hlbiBaaG9uZ2ppbiA8Y2hlbnpob25namluQGh1YXdlaS5jb20+DQo+
IC0tLQ0KPiAgIGtlcm5lbC9tb2R1bGUvbWFpbi5jIHwgMyAtLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL21haW4u
YyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+IGluZGV4IGE0ZTRkODRiNmY0ZS4uOTZkY2M5NTBk
YTYwIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiArKysgYi9rZXJuZWwv
bW9kdWxlL21haW4uYw0KPiBAQCAtODQsOSArODQsNiBAQCBzdHJ1Y3QgbW9kX3RyZWVfcm9vdCBt
b2RfZGF0YV90cmVlIF9fY2FjaGVsaW5lX2FsaWduZWQgPSB7DQo+ICAgfTsNCj4gICAjZW5kaWYN
Cj4gICANCj4gLSNkZWZpbmUgbW9kdWxlX2FkZHJfbWluIG1vZF90cmVlLmFkZHJfbWluDQo+IC0j
ZGVmaW5lIG1vZHVsZV9hZGRyX21heCBtb2RfdHJlZS5hZGRyX21heA0KPiAtDQo+ICAgc3RydWN0
IHN5bXNlYXJjaCB7DQo+ICAgCWNvbnN0IHN0cnVjdCBrZXJuZWxfc3ltYm9sICpzdGFydCwgKnN0
b3A7DQo+ICAgCWNvbnN0IHMzMiAqY3Jjczs=
