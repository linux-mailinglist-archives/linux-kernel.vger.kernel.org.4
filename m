Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0CC6EC4AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDXFJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDXFJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:09:40 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2131.outbound.protection.outlook.com [40.107.127.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B664E2D70;
        Sun, 23 Apr 2023 22:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP95oSZlITihFIwltyNaATtSbfX9+fn9X1dSITqaDipiKUp0LI3SntWsuvKgA5+zwuaYPzeCiIivJRtih5RqQPMiEf3R7tY3S6GcN/1cIPGHb/a+ngS0eRjwVZTWjo2Mt3YKVUcBefepb2z5pkjwBVJTGOoOVp1pCyVTGdPpCkPKNkkMlYOufK/QYxHo6bqU4cnUiR5JtPXgpWZB7bLvlnnXLZGZ+Ntm+Xs2ZD8hOmt8PHB/Pq4zd7PNJ3uHQpARBhZ6NLaWHjdrPEsO2jrdmm4uhzXCImAk/0eb+yWHCjStBMrX9qw/1M9wN2fFflsvfS1k0mKtTH4Jj6hJndNl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb5Yw6IFz8QvOXuJmwCrXMAvWu0qqA5OXf7887Pt0TU=;
 b=a9h0ztG7SUoUmnPsaG6zRYi31xtIF9n04nmN/DS/bFTfSOZzo2NXei0sK+O62pk/o2fXr46TMvt0b55HPnXKkLAZlvmcedSLhBXsqVchWAlvMXI7ITD3jslAkp8TCYZbpKaFqTrg4eBp0P8iVYCGpg78U7/1aIZ9ecgfE+PSEk1M6BredoOzlnsWCoCPYp4sEIaV3JMUrRJiF7NpbfBukrdHKWVn4NnWWLfBzWjwt3VHC5cjD+7HpUbm1/U+6LoEn+em+UA9Y/KKc65gt+cyaT70kLEXJCfSfMdsxzujhjbUE0zotD3oj63qyTMUJWoS5Vv1u94RxC7PJ2ruP0Sbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb5Yw6IFz8QvOXuJmwCrXMAvWu0qqA5OXf7887Pt0TU=;
 b=bbgWcF8M1p4GEezBLkObXTf/HBX6k0J5ABEa3mbE6sJgmlUcaJo4PtcvkL5V9MYIdnDo9dWuO6MTqtbJiOwpBPWH9aa1BF6O3EqStrvdcFelo2uwbw9oFaOXckfC8hXGMjqaBoO1IZjl2yxqXszAjorXNTSLxvoeMSCf4G7yAK0=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BEZP281MB3124.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 05:09:36 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a%4]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:09:36 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: gts-helpers: fix integration time units
Thread-Topic: [PATCH 2/2] iio: gts-helpers: fix integration time units
Thread-Index: AQHZcQ3cxEvcR4X7g0mCvGGZUqAfKK84yHyAgAErVIA=
Date:   Mon, 24 Apr 2023 05:09:36 +0000
Message-ID: <ec06f796-24f7-c3a4-c22e-f568bcc08522@fi.rohmeurope.com>
References: <cover.1681722914.git.mazziesaccount@gmail.com>
 <eeacd192c259e885850b5a2dd8b776bccfc44fa8.1681722914.git.mazziesaccount@gmail.com>
 <20230423121815.6d7c8039@jic23-huawei>
In-Reply-To: <20230423121815.6d7c8039@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BEZP281MB3124:EE_
x-ms-office365-filtering-correlation-id: 4cd06cfe-673d-4a86-bc67-08db44821926
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4hksFLCN6WGBGfUWDWBgNOLOQNdIS9g7rr8ljTqnOEDKfYXjKu+XBO4W2Nf4rwNN7FkjA40RQcrm4Dir4bcyYFkxUOvThwMz2dzQwz7RNSYmhu7ZN9hFZsDU4iL7A33NFAeQsvnVIlFgT2d3UJB/L4oFvvWY5rmAa8hbPXIGz9UEzsdaTOgLMT36sr/lKxRljnk88LntNt1p5QDM87duAxVjmbdueLkH2oiiolgZihzzHr2FPZVJrx3HvECOmsNcp00zalpSMTK6VIjcj7TEY0CPXAsPnC21PtZuTVTGvWkPunpLE8MuCJpgK2kGwbSTlbwOcZjuZaD2LYIl23/FS0gdSgdFQo4AYUOd5trKmn2TncEeqZj+1vEDQlb6fZFCvzSo4Dgn9g3AFQ8v2NmiGc5ubXcNznnJSR2d/NIdx602YnO+ch6yQnaV0AVRQPMZsWaNoUs4i44n8uY55lblATAhiU7b2QPI2U6VBx0KgcknTFkF1XVl0OZ5KAp4kZhVv9uW7MB/dBXR46TeJJXbyPk+Bk3hmetCfAJUw7c+p6FnRA7CenORJiPtFusjx8aeoMiUNH+4hnwCEVr7ROzrLFZB0mcJR+7BwCK7u9SSw8ahv4oAmF+uttt3g05YSY+RyF0n7zPrvrwXpPVSmOxlG+/Ysb7gexvkcqEolutou50uN3XYQIh0Dbujh9+OnmIY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39830400003)(376002)(366004)(346002)(451199021)(53546011)(6506007)(26005)(6512007)(38070700005)(2616005)(83380400001)(186003)(38100700002)(122000001)(66946007)(31696002)(478600001)(76116006)(86362001)(64756008)(66556008)(66476007)(66446008)(31686004)(8936002)(8676002)(54906003)(91956017)(110136005)(5660300002)(71200400001)(6486002)(41300700001)(2906002)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk9VNytycmRtYW1HdDdaam9tVDMzNS9Sb1VWbDluejk2RFQ3SnBvVlJuUDVl?=
 =?utf-8?B?YUd3cmp0OTQyT0tRa0pMbWkyaGZCZGw3SEJ2MFpBT1J2UzlxcUtoM2ZMZHh6?=
 =?utf-8?B?NENQbUdJRDdSVVExRVB2WjM1R2Z4OGZOZ0hvc014T0VXNmZrbUtzZFJ1VS8z?=
 =?utf-8?B?d0ZCaGpyQmpyZGZ2WXAwd0xSQWpscGNqQ2xUYzY5Z3A4VUlIVFdLWWFJRWVE?=
 =?utf-8?B?ZUlyWEs5Y0o3MVdRSXpVa2hKdHNmUlEyOGd5cWpiblJPVmYxSThOUDBLeE1V?=
 =?utf-8?B?YVJDUTdFL3pNSjQwZ2tScGRDa0dCVDVpRXk5eVVleXJ3Q2diWVhQS0cwY1gx?=
 =?utf-8?B?WXpsaGlwK3gvVmh2WkIwdFY3dTVBWkdLR3Jpam1mNXJWWUxpTkoyVnZwT1JL?=
 =?utf-8?B?V0hvR2lzdGZFalBUMVd3bmpHdWpXODFRVkJRM3Q1UEtHa0JFQ0xjWlBQZXNC?=
 =?utf-8?B?QzV1QWIyQjkxeE9jZWZpTkVKN1ZvUnRsZWxpcTVWano1UGk4NEdpaHBrTDZu?=
 =?utf-8?B?WDZCanpXbVp5TTlYajZMeGpCRU5OV205SUtaRHhtSXBtakp4Rk91c296TUdw?=
 =?utf-8?B?Nyt0ZTBjMFVLcE1Ec1JSWUlRcHhZK0hqcGVERzViTkp1U1ZDMCtodFovN2Fr?=
 =?utf-8?B?bmRidlJ0Z0luTXEwK2hUZkhvY0V4NVlnbHNFWGVpaVpicFhtU2VxUFp6eEwv?=
 =?utf-8?B?bGxTMmZSZkVhMTJBbEJ1bS9nSHZNb1FyRlVDMFFObFJTZkRPa3JyZmNpVDZF?=
 =?utf-8?B?eWFmS0ZZZWR0WHRZeU16WGpuaXBuK2xGb1Bpdk0zMWdRUkZjYVFSN1cvUUVi?=
 =?utf-8?B?VFkzbnUxdU1wd0I2RU5wSVpXOGRWdHlycEZ4cjdNa3JEKytDNjhnejcrV2hN?=
 =?utf-8?B?ZEZJellrQVNEZ0YzbGFUT0ZOaG5UMVJzZmlGWG02anRKV0EreG56UWE0L3Q2?=
 =?utf-8?B?QmkxM2lYb1Nld0o3NlRLWmpid3RrMWxUcWtMdEtiMHZIQnM2MHpMZ0Jta1N3?=
 =?utf-8?B?Zk10ZGhHY1JkY2RaSDlnbEJkTWh3TkpnT01mb0tKRElubDNpNStNSHVEQXZQ?=
 =?utf-8?B?N1ozdnJlL1FSRkZtL1RYbm1aS1NISkM5N1RLd3N4aWl5R2t1eGxrSm1ObG5x?=
 =?utf-8?B?UWtPZk9NelZQT29iMUVmYTJTMEsxY2VWMXovQW1GUnJRSHBmaW53SWlMTm01?=
 =?utf-8?B?NWhuN0lFQi9LdmF1S3EzeEYvQmsxR3g3aVdtQUNVWXJMcHdrNENnS0ZqcU9E?=
 =?utf-8?B?UVI2YkQzWmRQZ3RKWUQ5OWJsMHVQQnhadGlpNE4zMXhxR3JxL3JwaXhrVXJE?=
 =?utf-8?B?UW83VmlacVNvb1ljejNpZ3dsdllIbS9jeWN4cXhHWG9MNmhiSS94aGdvZDRL?=
 =?utf-8?B?ZXJrZVFOb0RHZ3BSQnBxTDNObWVYbWhpMGtaL3RJT2NUQUZUYXpBSDVXUlVk?=
 =?utf-8?B?SHJFMjVUMVpKSzgzZDF4VEs0QnZZalNkaUZndWt4VnBEb1JzZEk1NnNoejRL?=
 =?utf-8?B?LzZTTEtXS2ZiVHkyOFlOSWp5Q25Md2RMSnVSUkwxdWEwTGkvTkNDWDhqS2hC?=
 =?utf-8?B?MG5MbTlER2VhQkpmQmRmV0ZuckJkMWtMUCsrTTZWZG53UFV3akE2NzFTMnR6?=
 =?utf-8?B?dmhiaFNodk84K2tsc0Z1bTlCZDlobzNIcWQwdHJGeGVyeTFlUXFPcTZxa1Ey?=
 =?utf-8?B?Qys0ZG44cjhUM1JML2F4SlJEMkdzbWI4STZNMTJDTEM3NFZ1aEtRY3ZBMzY0?=
 =?utf-8?B?R0ZsOFVJa3N0ckZWSHlwTENmM1Y0Wnk2SEdNNjRQTVBXODZ4Q3hsM2dYcTJy?=
 =?utf-8?B?L0t5VXgrWkRGVVFYU0JOMWtWUHdxUVppZXZsT2l0eWxLWThpKzlGUUFFaEFJ?=
 =?utf-8?B?VVA0TnZmVU5MUUc0SGpaQjhYekwxTy9SL0kzaU12cGNvZFFjRDhOeVd3azZ3?=
 =?utf-8?B?KzVDb2FjM1A5OWZqVFM4UlB5MEE0azNmcVVSaHdKbldUdkk4S2lvQjBCZHM0?=
 =?utf-8?B?cktjQS9CMVNpS2RGRHVpb2FLVCtBUWxDSU9CZ0ovbStleUdJb2M2ZHhvUENO?=
 =?utf-8?B?WDJ0eC9FWGdzQ3FoaFYwODRQQmczSUdwVlA4M0o4SU5rekhJd1ZXaDhCcVFD?=
 =?utf-8?B?Mk1lQU00WkpMakozYkwvVDFYTW5YbHNuTlNEZlFsV056cnB0WDZ0cXJMNTdQ?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBDF555DD7973C49ADE9BA3CD4811715@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd06cfe-673d-4a86-bc67-08db44821926
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:09:36.0947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rqx+5Cj1/FS7sk/JGs3o9DYX+ckWIN+DiBm1XPx0iL3vFzMXmOFJVxk1d0QuhaKyPN/W8ODxbVA8WIb+QkiMMFXYD5on2G20XKHQW0EvEfw2jgpAm3SB+3s0xie5Hd3Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3124
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMy8yMyAxNDoxOCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gTW9uLCAxNyBB
cHIgMjAyMyAxMjoyMDoxOCArMDMwMA0KPiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gVGhlIElJTyBBQkkgbWFuZGF0ZXMgZXhwcmVzc2lu
ZyBpbnRlZ3JhdGlvbiB0aW1lcyBpbiBzZWNvbmRzLiBUaGUgR1RTDQo+PiBoZWxwZXIgZXJyb3Ju
ZW91c2x5IHVzZXMgbWljcm8gc2Vjb25kcyBpbiBpbnRlZ3JhdGlvbl90aW1lc19hdmFpbGFibGUu
DQo+PiBGaXggdGhpcyBieSBjb252ZXJ0aW5nIHRoZSBsaXN0cyB0byBJSU9fVkFMX0lOVF9QTFVT
X01JQ1JPLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2Fj
Y291bnRAZ21haWwuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1n
dHMtaGVscGVyLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tZ3RzLWhlbHBlci5jIGIvZHJpdmVycy9p
aW8vaW5kdXN0cmlhbGlvLWd0cy1oZWxwZXIuYw0KPj4gaW5kZXggOGJiNjg5NzViMjU5Li4yYWI4
ZDJkY2UwMTkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tZ3RzLWhl
bHBlci5jDQo+PiArKysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tZ3RzLWhlbHBlci5jDQo+
PiBAQCAtMzM3LDYgKzMzNywxNyBAQCBzdGF0aWMgaW50IGlpb19ndHNfYnVpbGRfYXZhaWxfc2Nh
bGVfdGFibGUoc3RydWN0IGlpb19ndHMgKmd0cykNCj4+ICAgCXJldHVybiByZXQ7DQo+PiAgIH0N
Cj4+ICAgDQo+PiArc3RhdGljIHZvaWQgaWlvX2d0c191c190b19pbnRfbWljcm8oaW50ICp0aW1l
X3VzLCBpbnQgKmludF9taWNyb190aW1lcywNCj4+ICsJCQkJICAgIGludCBudW1fdGltZXMpDQo+
PiArew0KPj4gKwlpbnQgaTsNCj4+ICsNCj4+ICsJZm9yIChpID0gMDsgaSA8IG51bV90aW1lczsg
aSsrKSB7DQo+PiArCQlpbnRfbWljcm9fdGltZXNbaSAqIDJdID0gdGltZV91c1tpXSAvIDEwMDAw
MDA7DQo+PiArCQlpbnRfbWljcm9fdGltZXNbaSAqIDIgKyAxXSA9IHRpbWVfdXNbaV0gJSAxMDAw
MDAwOw0KPj4gKwl9DQo+PiArfQ0KPj4gKw0KPj4gICAvKioNCj4+ICAgICogaWlvX2d0c19idWls
ZF9hdmFpbF90aW1lX3RhYmxlIC0gYnVpbGQgdGFibGUgb2YgYXZhaWxhYmxlIGludGVncmF0aW9u
IHRpbWVzDQo+PiAgICAqIEBndHM6CUdhaW4gdGltZSBzY2FsZSBkZXNjcmlwdG9yDQo+PiBAQCAt
MzUxLDcgKzM2Miw3IEBAIHN0YXRpYyBpbnQgaWlvX2d0c19idWlsZF9hdmFpbF9zY2FsZV90YWJs
ZShzdHJ1Y3QgaWlvX2d0cyAqZ3RzKQ0KPj4gICAgKi8NCj4+ICAgc3RhdGljIGludCBpaW9fZ3Rz
X2J1aWxkX2F2YWlsX3RpbWVfdGFibGUoc3RydWN0IGlpb19ndHMgKmd0cykNCj4+ICAgew0KPj4g
LQlpbnQgKnRpbWVzLCBpLCBqLCBpZHggPSAwOw0KPj4gKwlpbnQgKnRpbWVzLCBpLCBqLCBpZHgg
PSAwLCAqaW50X21pY3JvX3RpbWVzOw0KPj4gICANCj4+ICAgCWlmICghZ3RzLT5udW1faXRpbWUp
DQo+PiAgIAkJcmV0dXJuIDA7DQo+PiBAQCAtMzYwLDYgKzM3MSw3IEBAIHN0YXRpYyBpbnQgaWlv
X2d0c19idWlsZF9hdmFpbF90aW1lX3RhYmxlKHN0cnVjdCBpaW9fZ3RzICpndHMpDQo+PiAgIAlp
ZiAoIXRpbWVzKQ0KPj4gICAJCXJldHVybiAtRU5PTUVNOw0KPj4gICANCj4+ICsNCj4gDQo+IEdy
dW1ibGUuDQoNCk9oLiBJIHdvbmRlciBob3cgdGhpbmdzIGxpa2UgdGhpcyB0ZW5kIHRvIHNsaXAt
aW4uIE1heWJlIEkgc2hvdWxkIGNoYW5nZSANCm15IHBhc3N3b3JkLCBpdCBtdXN0IGJlIHNvbWVv
bmUgZWxzZSBoYXMgY3JhY2tlZCBteSBpdCBhbmQgaXMgdHlwaW5nIA0KdGhlc2UgaW4gYXQgbmln
aHQgd2hpbGUgSSBhbSBzbGVlcGluZyBeX147DQoNCj4gSWYgbm90aGluZyBlbHNlIGNvbWVzIHVw
IEknbGwgdGlkeSB0aGF0IHN0cmF5IGxpbmUgdXAgd2hlbiBhcHBseWluZy4NCg0KVGhhbmtzIQ0K
DQo+IE5vdGUgdGhhdCB0aGVzZSB3aWxsIG5lZWQgdG8gd2FpdCBmb3IgYWZ0ZXIgcmMxIG5vdyBz
byBteSBmaXhlcyBicmFuY2gNCj4gaGFzIG1vdmVkIG9uIHRvIGluY2x1ZGUgdGhlIGNvZGUgYmVp
bmcgZml4ZWQuDQoNCldlbGwsIHRoYXQncyBPay4gUGxlYXNlLCBsZXQgbWUga25vdyBpZiB5b3Ug
d2FudCBtZSB0byByZWJhc2UgdG8gcmMxIGFuZCANCnJlc3BpbiB0aGUgc2VyaWVzLg0KDQotLU1h
dHRpDQoNCi0tIA0KTWF0dGkgVmFpdHRpbmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJP
SE0gU2VtaWNvbmR1Y3RvcnMNCk91bHUgRmlubGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRl
cmx5IHdyb25nIHZpbSB1c2VycyBjYW4gYWx3YXlzIHR5cGUgOmhlbHAhIH5+DQoNCg==
