Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B8C5E53D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIUTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIUTaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:30:24 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2101.outbound.protection.outlook.com [40.107.135.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9699B4A;
        Wed, 21 Sep 2022 12:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PimheE3nWZwq3otYeqsKjOMEBaIaXXbOXwPaRJenXjc9tkWK9pJ0eWHBhjduCyDG6V1d2OHURHg/HvX+4BFMvxNXglEMQuVBYPlWeYM1AdI1KHYNlHfoGJbz2vcdTH/u0ad0vPXo8jG3UWtgwVobCfe38knDYMLuQ6YMHh16iMbyIAuCqiECn2FBbPXaf+bq8FbK8uTvRf778UImM8i3QfQbW0JSRsNu5Nxxbxe43cWu6SbAnJ7/p3dE8sASLNIa0cOQyxda4Uw25Gn51wtAuCIt9WrzrSq+89w/KY0398v59gbjL4my3uH+rhCEAo9uri2sQEWrQ7pIpMtuZvv4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54SI8A4BVwKETD+MZd/ypFzryNN+8wMpJl8S7uHXDVc=;
 b=fCJpixubLVkKbOE97AHEdJGGAMz4Yd7s+uq+TIfe5dnfvdSrz5xr4VRidfH/3f8W02deanFYaeERgS7Ud3zGblEFirLpnL3Su7U8Hn6R0hida3u3DB/NBciiTu2LXWI0Nfs/kfxizHZpZhRLN7VXL9iVkDBu/XAxBfD1Ygo9Ud8Fl2IdE2JjlPIMQf/7MrOvR3zO60LbTNenrfUbxcrRvE7YQ1nO4tZdxLeEGAfATCCna5jXx6j4IA1494CFgEnaS3HwOhcU2kVI0neB4GDlPLClbCR3HjTP1camjgqBROcM2TeY/E6ltJ2LfZ38cb6P6lmu548LhNvAn1qObejZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54SI8A4BVwKETD+MZd/ypFzryNN+8wMpJl8S7uHXDVc=;
 b=zjgJi7Xt5YLEEAUyizxwwK5UM3XWQ6/kDRrmoZN4Q8GpKp9TGCrOJHnBp9cOMiLaJrsMzbcnOySBl2dEQ4L/VzML8cgeDdWfjU/CbflL1OsCIX83noHj6u9lyizo+jJN3hB34feVM2PlgiPlCoBAeXcso04ODUV6KTv1hilteIs=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BEZP281MB2852.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:73::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 19:30:20 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 19:30:19 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/5] dt-bindings: iio: Add KX022A accelerometer
Thread-Topic: [RFC PATCH 3/5] dt-bindings: iio: Add KX022A accelerometer
Thread-Index: AQHYza+i+6l5MUCtKU+QKUjUE7CSiq3qQKMAgAAFKIA=
Date:   Wed, 21 Sep 2022 19:30:19 +0000
Message-ID: <7582e9e9-4558-ac33-a0f8-cb4e69d0628e@fi.rohmeurope.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <eb3edbb63c117f93e8ec534f50d8e3cf91ab3041.1663760018.git.mazziesaccount@gmail.com>
 <482c5a54-3d53-5760-fc8e-8aa3b9341707@linaro.org>
In-Reply-To: <482c5a54-3d53-5760-fc8e-8aa3b9341707@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BEZP281MB2852:EE_
x-ms-office365-filtering-correlation-id: 42872cb9-7dc9-48b0-5172-08da9c07b869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uuhmv5Ku7ydKAldvnhVI7Pful4KrYAY53V+AJM0wKk2fDNVlwiGs4qI9C7Z8MHXcWF1dg8wmH6n/W5l7Hi0eBRvKpHLDvNpN4PBbTw/JX0tfAM3WRJOmXck6vIPqXfub8pj5dSWiPfOlx6XZuVoDo9nmahvYU+SebEWlQTpKPtto0wMnDOnTV1TlVA+p5ou0MUq9k1oo7iqhg3XOise6bg5t/0QPGNPyx0wToVcTEQ2DIvYzuIlEwc6TdKdkelLZwZbyVsPCzhfEt0IffVbqAaHEPnh8PwKEzzauxWs3yo4RQQXV1MYLNOLnB9mhTAkddfYHNA+kp0hWFx3WWVk3Zo4tndUPXhPHNbQExp1KhC3JfS7BvnP9c5bIpD0Y9uxUQ1TeZ3+bD4eh3tkeZkrUHMgZalibeVmw4Beme7QLAbA04UfNHNUoUROwocdT7FclL/4P+fV2QxmuOxOodSL3vPE44FO4yXy6uR6ebl5F2qe6aB5IjPQhemEmeH0KnmvEr33fWwtzElxpTmMEym1JSZhxe1ZI1oIkdJb+CotYNAnc+k5GPuqoEYO4HHPL2dCJVA08ISjXhnNv71+dEUNfcQoYjc4hexZCgDWuDtj0fM4oSgkYmF30SIYr0mo0PS3aDSjr8+56kedurbpyjAW4PPGg5zRpNCG+21igMVpqHdVeGvIMWBiMyI4j7ryWXLOfT3drnB9oJf5m4JQ0EzxDfdcZrRdwEwm6XjFroxuZgy53b6vhu6+IQiH8wgX5x8bDfdN0PgzADRfXQtsFTL/ZI946GDQhgH0IcB5zKJWH9+gV7Wz9u9aqso1DXNTknq6LJ95FC3ZXYQ85O1xp7N0onQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(346002)(39850400004)(451199015)(66476007)(83380400001)(66556008)(66446008)(4326008)(66946007)(38070700005)(2906002)(31696002)(7416002)(5660300002)(8936002)(478600001)(6486002)(8676002)(64756008)(76116006)(53546011)(6512007)(6506007)(41300700001)(2616005)(38100700002)(186003)(91956017)(71200400001)(122000001)(316002)(110136005)(54906003)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1F6dWUxTkJiT3QrcGt2bkhvbmlSWEVySFd4WVlLdDlxRHZLVDZnMzU1cUps?=
 =?utf-8?B?bWlFUlIrWjFUZFdVYmhKbTRJV3pTT2xiM01NSitVV3BkeXQ5YytWYjVmWWZq?=
 =?utf-8?B?U2l1MmxLNEhvTk1NRWdIYTRTRTdVeHNTTGNtNlRpdENhVlY5cGZwc3pUbllt?=
 =?utf-8?B?RENjVWJDTzZ1U3RFNE1qNnJNb3B3VXpoWVpwWEttZTRmNzlIVzVZeEkwQWVo?=
 =?utf-8?B?ZmJraHZKMzI4T2VzcHErUWtqQlMyeWtFQTVnVU51c2p1MWVoemNzY2QvMTBI?=
 =?utf-8?B?N2tkcVNYV2JYMklZYzdGU0xxVy9zUk5oekhoNyt3WWZaNkpTT2J6UjZrZ2Zp?=
 =?utf-8?B?d1E2U0N6ZXFrL1ZVZERpS0pLMldWQ0ovTXBnb2wvY2Q0dzlVcWFDdFRQaWtq?=
 =?utf-8?B?NS9abGh6S1hkYlB1eWdPVUFCQnQwajZUQzhtQlpGRk1vazFzbE1Qc0ZZZjA5?=
 =?utf-8?B?ak5yaWxtT3gycG1pNHJNVDNBaVNJTFBsN1dzUi9MdUdJc3NSTVFocWR6WW1T?=
 =?utf-8?B?OHRTanA4RkVIeS9xdmNxeXlmdGVQajRWUUI3M2RZNHNVQ1RMOGRrb2VNaXgw?=
 =?utf-8?B?S3hYL2FnN3NkOVl5NDJuV1JZVXk5Z0g5ZjFxQnpadzhqTGVzclhxblhYUWlO?=
 =?utf-8?B?bW5xRitNOS80Y2p0bkoxc1NySjVkZWZ5bVNtOG9sRVlVU3dLci9CSGJCVytq?=
 =?utf-8?B?RDRuclptNVNaTnpMZENuazNLK3pXWGJ0dUdtNTlMQ3Y1VjhlSC9JVWVYVGIr?=
 =?utf-8?B?VzVDbmpERHhuUE54ajgvTVFQVHZGcTZaK0xldTZDZjZ3YUlXRFl3ZXFzSDZZ?=
 =?utf-8?B?YXgvNnhFbUdGdlI4Ylp4R3JoelVUcHhOQ0lwbnlrNmF5SEhXSXh5S0s0Tm52?=
 =?utf-8?B?dWFseTdGZzNIeG1jUHgweDh6WExjNkJzTnF1Y3Uwa2dKZG13bEkyRHMwWERp?=
 =?utf-8?B?dGxWdWo4bnZGNE1ZVUlQbWw4UGV5dXRadjR5VVVlM0gyTzNEWVBOcUNmemlF?=
 =?utf-8?B?cDlhV1UrUHBVVUZKOGVGeTNWeVEzckFUTHYyWllJMlNsd1orYWY4L0thUjFu?=
 =?utf-8?B?YWtWa1BZY21GYzZXbWg3Vk1KNnJ0TTllMXoraWp6KzFPZFF1bVhlNVllRmhY?=
 =?utf-8?B?QlNFcTF6YkgrQUR2R0tudlFUYTNZdlgvcnB5cmc4R0duZ1dZYTBZYjhud0tG?=
 =?utf-8?B?OWNVUjBJRlNCZDFNOExibjV3Vm1RK3RzM202TFpUdEFjUHRJTXhqeUxiTUM0?=
 =?utf-8?B?UzcxY2QrYkxEK1JzRHg4MzM0d2Vhd0tlcFoyV2pabzgzY2MxcGRvdDZCdzZi?=
 =?utf-8?B?OERrcHc4czhMSjVnV0VZc2ZOK25XejFEdXlYdktOZXZLVjlyN1NlMjVIUkpM?=
 =?utf-8?B?RDY3L1FybHM2RWt1RDhZTHMzNmN4QjNYWkYwZVk2U29SWFNWVmJ3a3JFMnhR?=
 =?utf-8?B?OHVIemJVdldsdWUyaGtVcXFlOHNkYldQbEcvTVhFZXhNKzMzakx4Snkva3p2?=
 =?utf-8?B?TXdiemN6VTdIa0JDTlRQdXBRVS9COE5vRE1qeUd2bS9QY3VvY1pBdXJKK3A4?=
 =?utf-8?B?VXV0dzdKWUxpQXhIUktKZCtLWmFsbmFCN2RWeFpudjk5THZpdDFWZW9CcExs?=
 =?utf-8?B?bTNSVjA5cU0vUm9LUGxyTlZxaTNNelQ5bzZNeFpqd3NrZGJQa05QNXZIRDZP?=
 =?utf-8?B?U0xhak1NQngrVVNIRXhKM3FtbHoyLythdjVnaDBUM0tPbTJOUTJ4VEJweWlU?=
 =?utf-8?B?bTI3N2xuaDlVVkpzVmF6ZlFoVUpsNzRnR3VQOG82dGVsQTF1T2ttR2tQZmY1?=
 =?utf-8?B?bzJkeE1JbkwxTVpjU2pQaEdFOG1HVzRSdW1QWlltYUJMVmsxb3hVYTJ3NUlJ?=
 =?utf-8?B?ejNSL3RyeDlXTmJUMzN4NDloNDh0cnlxcTArN0N3T0U4NUJDSlErZHJBTkhO?=
 =?utf-8?B?Z2RnYUloS0NWUjZKaWRvN3kwd3RhZi9sK2J1ME9XN282V3Vkd3pTYmJmd3RC?=
 =?utf-8?B?VDlQOXVnaStIRHRyTjJEeGwvVS9wQ0FicFF2NFFoL2JablFldnJQajVVazBR?=
 =?utf-8?B?R01obDFVU1BEVy9GR1ZhMVRsY2wrZmk0VngzWGEweDlGQ1NmOENXN2pyeVhS?=
 =?utf-8?B?cERVVU9UTmh0RERZN0Zod1V1bFVZb0Uwa1RNRXpRZHY0RnVmOFp4YVR1cFVh?=
 =?utf-8?Q?qa7yDWQ+dOJ1+lZ2LvN4AIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE36C9FBA080824EB4A72F4CCBBFDABA@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 42872cb9-7dc9-48b0-5172-08da9c07b869
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 19:30:19.8648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVdTvJVMHTg7M30qR3pwK0b7qR00ZGiqolURA8Eaz/zi4xtCTeTwKLHS2iFp0AnN3eO2iIxd7VGzkGabgu+yEFQvhSpLFiteaOyN4MMuEqe/r2YB/mlR5WX74hSjsPwD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2852
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZGVlIEhvIEtyenlzenRvZiwNCg0KVGhhbmtzIGZvciBsb29raW5nIHRocm91Z2ggdGhpcyEN
Cg0KT24gOS8yMS8yMiAyMjoxMSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMjEv
MDkvMjAyMiAxMzo0NSwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4gS1gwMjJBIGlzIGEgMy1h
eGlzIEFjY2VsZXJvbWV0ZXIgZnJvbSBST0hNL0tpb25peC4gVGhlIHNlbm9yIGZlYXR1cmVzDQo+
PiBpbmNsdWRlIHZhcmlhYmxlIE9EUnMsIEkyQyBhbmQgU1BJIGNvbnRyb2wsIEZJRk8vTElGTyB3
aXRoIHdhdGVybWFyayBJUlEsDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIE1hdHRp
IFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KDQpNeSBvd24g
Y29tbWVudCAtIHN3aXRjaCB0aGUgZW1haWwgdG8gdGhlIGdtYWlsLW9uZS4gQ29tcGFueSBtYWls
IGlzIA0KdW5yZWxpYWJsZSBhdCBiZXN0Li4NCg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOiB8DQo+
PiArICBLWDAyMkEgaXMgYSAzLWF4aXMgYWNjZWxlcm9tZXRlciBzdXBwb3J0aW5nICsvLSAyRywg
NEcsIDhHIGFuZCAxNkcgcmFuZ2VzLA0KPj4gKyAgb3V0cHV0IGRhdGEtcmF0ZXMgZnJvbSAwLjc4
SHogdG8gMTYwMEh6IGFuZCBhIGhhcmR3YXJlLWZpZm8gYnVmZmVyaW5nLg0KPj4gKyAgS1gwMjJB
IGNhbiBiZSBhY2Nlc3NlZCBlaXRoZXIgdmlhIEkyQyBvciBTUEkuDQo+PiArDQo+PiArcHJvcGVy
dGllczoNCj4+ICsgIGNvbXBhdGlibGU6IGtpb25peCxreDAyMmENCj4gDQo+IE1pc3NpbmcgY29u
c3QuIEkgd29uZGVyIGhvdyBkaWQgaXQgcGFzcyB0ZXN0aW5nLi4uDQoNCkkgb3JpZ2luYWxseSBo
YWQNCm9uZU9mOg0KICBpdGVtcyBjb25zdCAuLi4NCmNvbnN0cnVjdCBoZXJlIGFzIEkgaGFkIHNl
cGFyYXRlIGNvbXBhdGlibGVzIGZvciAqLXNwaSBhbmQgKi1pMmMuIEkgYW0gDQp1bnN1cmUgaWYg
SSByZW1lbWJlcmVkIHRvIHJ1biB0aGUgdGVzdHMgYWZ0ZXIgZHJvcHBpbmcgdGhlIGV4dHJhIA0K
Y29tcGF0aWJsZXMgOnwgLSBTb3JyeSEgSSdsbCBmaXggdGhpcy4NCg0KPj4gKyAgaW9fdmRkLXN1
cHBseTogdHJ1ZQ0KPiANCj4gTm8gdW5kZXJzY29yZXMsIHNvIGlvLXZkZC1zdXBwbHkNCg0KVGhl
IHJhdGlvbmFsZSBiZWhpbmQgdGhlIHVuZGVyc2NvcmUgaXMgdGhhdCB0aGUgZGF0YS1zaGVldCB1
c2VzIHRlcm1zIA0KdmRkIGFuZCB2ZGRfaW8gKHdpdGggdW5kZXJzY29yZSkuIEkgd2FudGVkIHRv
IG1hdGNoIHRoZSBzdXBwbHkgbmFtZSB0byANCndoYXQgaXMgdXNlZCBpbiB0aGUgZGF0YS1zaGVl
dC4gTm90IGEgYmlnIHRoaW5nIGJ1dCBJJ2QgcmF0aGVyIGtlcHQgaWYgDQpzYW1lIGFzIHRoZSBk
YXRhLXNoZWV0IGlmIHRoZSByZXF1aXJlbWVudCBvZiAibm8tdW5kZXJzY29yZXMiIGlzIG5vdCAN
CiJoYXJkIi4gKElmIGl0IGlzLCB0aGVuIEknbGwgZHJvcCB0aGUgdW5kZXJzY29yZSkuDQoNCk90
aGVyIHRoYW4gdGhhdCBJIGFncmVlIHdpdGggYWxsIG9mIHlvdXIgcG9pbnRzLiBUaGFua3MgZm9y
IGNoZWNraW5nIA0KdGhpcyEgQXBwcmVjaWF0ZWQhDQoNCllvdXJzLA0KCS0tTWF0dGkNCg0KLS0g
DQpNYXR0aSBWYWl0dGluZW4NCkxpbnV4IGtlcm5lbCBkZXZlbG9wZXIgYXQgUk9ITSBTZW1pY29u
ZHVjdG9ycw0KT3VsdSBGaW5sYW5kDQoNCn5+IFdoZW4gdGhpbmdzIGdvIHV0dGVybHkgd3Jvbmcg
dmltIHVzZXJzIGNhbiBhbHdheXMgdHlwZSA6aGVscCEgfn4NCg==
