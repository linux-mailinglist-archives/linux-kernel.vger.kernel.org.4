Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB0C5BCA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiISK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiISK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:57:58 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D612527B1C;
        Mon, 19 Sep 2022 03:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+63kmMAFLA4dLoxVOZi3eesLK8wETg8tXp+lY8L9VC1VExHzKsYok3zVC709TE6AD27hC0F2u/8zaEtU/PkN57QzggHk5s2YA5zpO44Zmq62v4DTnHAOjtslGVAxce9QputCowWAz9w9+6bCDMbsIAQqVoIAa5DryV7j1gbQVpx1zIdjKYssnVEzmXqMxDLUbd40Zg2dKsY4WJyJ+WqVsQ/mZCdzjRCWyTRwhz7wFLOWhTUDKqhPKkCO+Hd/BpftUYjthvhiTwz8+M/EM8+f813eBvL6aEYqb/YtF6VNbJBAzZ/hTXIExtUZH5BjlDkB+ui7zNiPsXnyFsD9cYITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhC5eRWqlNRicwOVvTvbILqCZfxejX8QedkxDbXXDWA=;
 b=ZQZht4DC24f0BEsIRQnAVL7HBFip7khx9ZZFyvWENBoy0wtq9XB/ptm/u4AYFaPMGJP+jDjMz6Q1Kd7sECnmNHq+K5qzkXjOEvFQ6bhOv3PaUcXcMF1cS4zU5rqDouTZ6mdJEAmQheODAdrGAFyL3ymV0xYJyFK58hYQhqaxCk9NoZt/asr/mlXA6chlvd6gJ31+YZnpbcQgy9kd8+5hTs8CsWYsYUrx9eQRZqRFH+yrtmKVTmA4yDwTiNifTIXyx1Rwb5mutLRkR5gObjkONkzYJTshSdHaJVwbAUqX5roTSEspwvSQwv3eBr5od90F+4krUwwuRCSBhI6Z6mIrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhC5eRWqlNRicwOVvTvbILqCZfxejX8QedkxDbXXDWA=;
 b=s/ryaR5u1O2jBTrCbJzSi0l2aP1q/QinxCcDKC8S10LCONEXi31EQtG6r9cERXAtuVmdeLn7BNDDZwM5b2tNsWJT7iyiLy/NhBQkfMD2ootU6ELV3j0oseq8PwUf0VmGQMeHwr14qRp7x1qMjP9HQfRsmxNUnfzNzKlRdwIM0E0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB7973.jpnprd01.prod.outlook.com (2603:1096:400:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Mon, 19 Sep
 2022 10:55:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 10:55:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
Thread-Topic: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling
 wdt2
Thread-Index: AQHYyD/rtz77kMV/LUKpS1dYBqhnjK3k6tOAgAGecYCAAAScQIAAAboAgAAA8+CAAAhtgIAAAoaQ
Date:   Mon, 19 Sep 2022 10:55:11 +0000
Message-ID: <OS0PR01MB5922A255CBA720023536A151864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
 <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
 <OS0PR01MB59221867F12797CCA685F954864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utMR5GRnNGYhn_hhRnDpxtBLjEhqBXmoNZXmiBObojmw@mail.gmail.com>
In-Reply-To: <CA+V-a8utMR5GRnNGYhn_hhRnDpxtBLjEhqBXmoNZXmiBObojmw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB7973:EE_
x-ms-office365-filtering-correlation-id: 31f09b8a-3a10-4d40-ed53-08da9a2d6d13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSI/d2izJ3EzK2bp6Ui7OCgp6ChWofZs17AMBdW87maZu3h5/RfPchoQl9JzxFd0kfTkPxSeTtHWL7sHM56qPiV1IzdwMgpaTeQnpGq4/ZlYW4NGBXL/yqbt6oJfxQYP9lEH3TJzARgKCN+2Ws0DzYJ242MtZSa15ibGWSN6HT4h5nlppTgJjoY8rcgHkumCfAKYuh62HWvKfWLuo2wcVJezqrywjhLnIfDLPI9lSGhnQ+AgZUG6DUKzoFKhq9oAgp/xXwcEkiQdgc7/3m+eFwuEh4kafWpXaOIM/FeIWpJGEOW0Wqa+2Iu29I1DNKQLUbBS/uLc0J3VrHtOvHfRsZ0FfRPV5ZF+nDGKxPh1lc+mVHkfDuWlMYtPh/br1hr+q9y3q+TEPCoEm5mPwUgmyWvjL0vZdUPSUu23hwcSGefN5vrjtqaqEXx6kFaIEVv4HyXh/3sUj7L8gzv9jemt2+NPzOboOkRRwOPvgcayMo6a3g6KZYRgfKUWw4+iKqkZRXM9iMSE6inuIl596wQyDbMTq2cWrLoNwyO3/Yo0wqTIAg/cLj9jHFi7OPfkEyndshNUL9gdWOPHU0KrZj9hv5ifZybhpvfdbWMgWKw8aYM1oEsZgSBLjIDYsCLXAa9m5qD1JSMkATpNTKgOB3ohxOLON2Q9qCKSxLa9baeDyJKihyW3EQBol8v6xHAwyA7n0EiEvJVg8habj13Xh8JM84TN6dmQbmC6vXEb31alUp0tqVMSKPL7VGqlng8OL1urVh/jPOKgJZrhvuITbAKsl+S6jABo5x84I51zpFbzaPg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199015)(38070700005)(6506007)(4326008)(7696005)(2906002)(71200400001)(66946007)(66446008)(86362001)(55016003)(53546011)(8936002)(9686003)(26005)(76116006)(66476007)(122000001)(66556008)(33656002)(38100700002)(8676002)(64756008)(41300700001)(107886003)(966005)(478600001)(83380400001)(186003)(5660300002)(54906003)(6916009)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3F1NndnM3YxYi9DaDNCZ2ZsazhnZ1JvR1N5T2pVVlFyUUxPOE9KTmdVM1Z2?=
 =?utf-8?B?RC9obzF0Z0pkUkdMKzlqN3lwQzZLQzluZDR0U2EycDRjZG8zZHdBVnB6em1l?=
 =?utf-8?B?bXEvczZnWmJDTlh1RGg3MkZoVHZWd1B4Wk9SZzJCdktYWjlacHpKcjJKa0xw?=
 =?utf-8?B?ZU83czVNaXFjMWdDS0ExR1dZeFVoaHpOLzVDdzZQaElkVnMvYWIwaUQrcWtp?=
 =?utf-8?B?ZnV0cVkxdzB4MkpvRUVHbWRabGQxV3kxbUo4UHJJT0s1NVVNK3MwdWMvdkpQ?=
 =?utf-8?B?dEo2RGpDeGhQZ1VTNlpGdjUzYlVOcGVxWVJjR0MxcElTUWxHV21kUmNOUHNj?=
 =?utf-8?B?WnZtR21PRS9CaGZrQkorb0I0Z0tHdGtYcWdMQVlibTVyM1Irc0EvblFZYkUr?=
 =?utf-8?B?Vy9sWDl6bnYxMEo1dW02cE9WQ2RqUVpzL1pocjFEVk4wSzRTOTRQcUYrS29U?=
 =?utf-8?B?MzU1WGFVL0hlbm1rdWxpQTlNRnl4bzZOa0txOG10QXd5dGVjLzRVUzJIYWt1?=
 =?utf-8?B?bEgvaTlnSy8wRER3OVRxWWwrUWMrTU9qQ3JFa09oTEdINkV6VHNVTlpoTFdw?=
 =?utf-8?B?Z3pNUXhEQUs2ZlpscUozOTBET0poMzNkZmFRUjVHeXRNYW1McGhNUlJqTlNt?=
 =?utf-8?B?VnhqVjliTk1vSUxpQUZ0ZmJvZjh5R3JzY1hCNVg5UkZDWFVXeVk0b3E4b3VP?=
 =?utf-8?B?NzcwdE1WYmp1MC9BdElLZTlMNlpFQXg0ZlNFS2E3MU9RdFBOK1NGV3pPWFJE?=
 =?utf-8?B?QVM0aGhPaFNaMHFXU1MyR1dPdG1ud1h6emJtMGtYNUIvRlE3blpSM1R6YjEy?=
 =?utf-8?B?Qm8yYmEvRTZOSXdZbDBRaDdFbUlsSk9rWWxPaHkzWXAzVUV0V1BnRm1IcCtx?=
 =?utf-8?B?V3VkTWVQb2NHclRaMUNkWUtyZ0Y3WnNYTGVaTEVabmJnbmNacU44TndSaStZ?=
 =?utf-8?B?WVg1SGpFT1JLZVFZTUdXZEJaSEc3dHUreVdYSUhuVTAwK0RMYnlrSGNjN25q?=
 =?utf-8?B?cmpzMzJhOGZTWUZocmd5ZDJZbENjL1loM0R3Ym9sMTIwdEZXaWZJN1g0R3Bo?=
 =?utf-8?B?Y2MzTFNTR0x2YTI4YjlzbWNORzNGK0hkM3EvdVhQUlNuUlh4ZnUvbU1kSEhW?=
 =?utf-8?B?di9QdjZiR0lsbklrMTVnQk9ZRnZwMkFpb3IzWkQvU3ZoUHBwSU9nQ2lJNG9W?=
 =?utf-8?B?UlBoenZSZmZYdXRteCt4M0M0UjFvL25VZEVuL2ZBbkcyK0tBZGkzNUpIMUMz?=
 =?utf-8?B?L01NN0VMdFAxWVFndlladmlNUGV1WmNWQjlqc3BTR0VzYWJlTGhsb3JxbTVv?=
 =?utf-8?B?TUwyYUpiL0hacG85V3RGN1U4ODRCTC9vcHdWSTY5R3Nkb01MRldkSVhFRHV6?=
 =?utf-8?B?STg3dFM1ZTh5Q3AvOEtEWHRubGlFSy9TWWpwMkN1dnpGZWkxL2dNeVRMQTJY?=
 =?utf-8?B?Um1RcFZzem9zOXhLbk15TTBXekc4T2laZFpFdmI3SEwrbVJ0L3dvbllEcUdJ?=
 =?utf-8?B?V3ZxNHBEVVJLZE1qbFdtVGp2RUlvWDBkdng5SEFEdVdpNXJ0eDBhWWRIajFU?=
 =?utf-8?B?V3lrL25UVVcwZTZ4S1F4alBQc2t0WXR4VjFkL1R1eVlrSmd1cW9uVmV4UENm?=
 =?utf-8?B?NmxwcUZXT2E4SDQzUXZ6dDh2M0xQNTNRbHJwT1QxeXRhVXN0NkpUek96ZVZH?=
 =?utf-8?B?aUNOWnNucS9BQnZBRXVtQVY4cFVjV3Y5ZFQreG5OajYrZTBjK1ZqcjI1Nndu?=
 =?utf-8?B?MDhSWTBlUlZGVTFxWDFQWE01dG50Z1o3bm1wbThMTHZIY0wwY1hESWRKbTVZ?=
 =?utf-8?B?cU5kUUVwd1RHOVlFejQ5V3ExbGUzcVd4VENtenZwanhWdzdIb1pKRGtxc0dn?=
 =?utf-8?B?S0kzeFJHa1ptTzg2V2k3TWpSdFhKOVB6T0dkYkN6VmZXVXJJNDFkWEo5bkZT?=
 =?utf-8?B?SURXQnBCZkc5VUxFb1lrVG82dEpseUprZjZuejl3T3hGeEJ0NVFRcUxkQytx?=
 =?utf-8?B?NkVWRVFvNytDRHR4RkRvWUthZWx6N1JaTkhPR0lkNnRpdExTWGlkQ1QveUEx?=
 =?utf-8?B?c05LZ0R4b0J4SlliR2pWbmlVeFVQeHQ1Vi91TFZjRXZjVXQzQjZuZE1wQ3hz?=
 =?utf-8?B?U1g1YUdadmFKUUJRUTR1a0IzWEsxNVJTRzVsU0UvYmFtUTIrUnRjajl0VkxW?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f09b8a-3a10-4d40-ed53-08da9a2d6d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 10:55:12.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RC65pfXEXyvknyPLERD2FhGq+yDs88dPmL5bHRaXaVjPQ1D8zWzDNJlLWAgn1gzUXqFuiqyhi4G2cfJydS2UE7BhdiyXiS8FdOvCCQZJd+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7973
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkLCBQcmFiaGFrYXIg
PHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KPiBTZW50OiAxOSBTZXB0ZW1iZXIgMjAyMiAx
MTo0NA0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBDYzog
R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz47IE1hZ251cyBEYW1tDQo+
IDxtYWdudXMuZGFtbUBnbWFpbC5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnPjsgbGludXgtcmVuZXNhcy0NCj4gc29jQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQcmFiaGFr
YXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LQ0KPiBsYWQucmpAYnAucmVuZXNhcy5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzJ1bC1z
bWFyYy1zb206IERyb3ANCj4gZW5hYmxpbmcgd2R0Mg0KPiANCj4gT24gTW9uLCBTZXAgMTksIDIw
MjIgYXQgMTE6MTUgQU0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEhpIEdlZXJ0LA0KPiA+DQo+ID4gUHJhYmhha2FyIE1haGFkZXYgTGFk
IDxwcmFiaGFrYXIubWFoYWRldi0NCj4gPiA+IGxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzJ1bC1zbWFyYy1z
b206IERyb3ANCj4gPiA+IGVuYWJsaW5nIHdkdDINCj4gPiA+DQo+ID4gPiBIaSBCaWp1LA0KPiA+
ID4NCj4gPiA+IE9uIE1vbiwgU2VwIDE5LCAyMDIyIGF0IDEyOjA2IFBNIEJpanUgRGFzDQo+ID4g
PiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBP
biBTdW4sIFNlcCAxOCwgMjAyMiBhdCAxMDowNCBBTSBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gPiA+
ID4gPiA8Z2VlcnRAbGludXgtIG02OGsub3JnPiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFdlZCwg
U2VwIDE0LCAyMDIyIGF0IDM6NDMgUE0gUHJhYmhha2FyDQo+ID4gPiA+ID4gPHByYWJoYWthci5j
c2VuZ2dAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gRnJvbTogTGFkIFByYWJoYWth
cg0KPiA+ID4gPiA+ID4gPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29t
Pg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBXRFQgQ0gyIGlzIHNwZWNpZmljYWxseSB0
byBjaGVjayB0aGUgb3BlcmF0aW9uIG9mIENvcnRleC0NCj4gTTMzDQo+ID4gPiBDUFUNCj4gPiA+
ID4gPiBzbw0KPiA+ID4gPiA+ID4gPiBkb24ndCBlbmFibGUgV0RUMiBieSBkZWZhdWx0Lg0KPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+IEZvciBjb25zaXN0ZW5jeSBJJ2xsIGRyb3AgZW5hYmxpbmcg
V0RUMiBmcm9tIHRoZSBSWi9HMkx7Q30NCj4gdG9vLg0KPiA+ID4gPg0KPiA+ID4gPiBEb2VzIHJl
bW92ZSB1bnVzZWQgY2xvY2tzIHR1cm4gb2ZmIFdEVDIgY2xvY2sgZHVyaW5nIGxhdGUgaW5pdD8/
DQo+ID4gPiA+DQo+ID4gPiA+IElmIHRoYXQgaXMgdGhlIGNhc2UsIHdlIHNob3VsZCByZW1vdmUg
ZW50cmllcyBmcm9tIGNsb2NrIHRhYmxlDQo+IGFzDQo+ID4gPiB3ZWxsPw0KPiA+ID4NCj4gPiA+
IE9yIGFkZCBpdCB0byAqX2NyaXRfbW9kX2Nsa3NbXT8NCj4gPiA+DQo+ID4gPiBOb3RlIHRoYXQg
ZHJpdmVycy9jbGsvcmVuZXNhcy9yOWEwN2cwNDMtY3BnLmMgY3JlYXRlcyB3ZHQyIGNsb2Nrcw0K
PiA+ID4gYW5kIHJlc2V0cywgc28gdGhhdCBzaG91bGQgcHJvYmFibHkgYmUgbW92ZWQgaW5zaWRl
IHRoZSAjaWZkZWYNCj4gPiA+IENPTkZJR19BUk02NCBzZWN0aW9uLg0KPiA+DQo+IFllcyB3ZSBk
b250IHdhbnQgaXQgdG8gYmUgbGlzdGVkIG9uIFJaL0ZpdmUuDQoNCk9LLCBTbyB0aGlzIHBhdGNo
IFsxXSB3aWxsIGJyZWFrIGV4aXN0aW5nIFJaL0cyVUwgdGlsbCB3ZSBoYXZlIGNsayBjaGFuZ2Vz
IHN1Z2dlc3RlZCBieSBHZWVydC4NCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9oPW5leHQtMjAy
MjA5MTkmaWQ9MzE5ODllY2U3MDdhZGM0NTNlYjlmNGYwMTlmZGFjMTE4ZjhmZWU3Mg0KDQo+IA0K
PiA+IFllcywgYm90aCB3aWxsIGRvLCBJIGd1ZXNzIG90aGVyd2lzZSBXRFQgZW5hYmxlZCBieSBD
b3J0ZXgtTTMzIHdpbGwNCj4gYmUNCj4gPiBkaXNhYmxlZCBieQ0KPiA+IENPUlRFWC1BNTUgZHVy
aW5nIGJvb3QuDQo+ID4NCj4gQWdyZWVkLg0KPiANCj4gQ2hlZXJzLA0KPiBQcmFiaGFrYXINCg==
