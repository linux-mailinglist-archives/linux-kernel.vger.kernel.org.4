Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192A7609F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJXK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJXK6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:58:03 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2122.outbound.protection.outlook.com [40.107.135.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587C5AC70;
        Mon, 24 Oct 2022 03:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9Zm/x3/VjuGjEGgiuWm4jUpVbCBhrHz/yphxvODtxdMh8wAH8MMglCnLmm0LYivQH2WWwlU88cpHAfuUOA3EQ7ZR1+/gaNmiTIlrYlL+admN9X32fWVeccwSW/7SwxA2/eBF3QFkbf9hCSqNWNLaO2u98Naw6MSUKlc3XiaSnSF4J7aqaIbHk7zN4qTUZAEOxQBDex1DjFPOx7yUj7fwU2uCz7cDOYiQkwgRt1kYRiPb8/vPWzzQJ3Mi36MsI9qIIosSCw49+qG+/T0MpUaal9LgynUZM85GLxw8pfHv8rFrpHjC3yM7kE6wVCaWdLcJWkYeWItMnCgHju76RCz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWpxX0NdSMXL6ZUeC/42f3qpt6qSDV+ezX49eYpnv74=;
 b=gDTFRt0PlSmc+7egPTy+34J+8GyYdMfSL/b7p/+FOo/5GI9cq4azXL8P1gWXBk4YShAUW+9wlSqLAF3F6aX2GhZXXEtpIj08lzkk/pUNCOAUAd5SO/LCAUbgqB2xLHfylQbvREissFuDbS5+k5GVoQhZtWadlo2WasXwhTfCYRrtjSaXMtfRzVShMsadu6wZazgB7Um5s9dscgDJ5vImdS9QXD5eMUWsUBPFbBzkCTM7sxkitGqRSQt6CvIxFN+oAAORHILHwwexftIRJXV3RX4RKq24lYLKDQLXx6+zjmkSqSQxOtzqdspaWmBq3xd+GFG5TVDU1E10CLlaQmxRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWpxX0NdSMXL6ZUeC/42f3qpt6qSDV+ezX49eYpnv74=;
 b=IicYmcYuyDlAH6vO6rFCQVmVFpUEvfWPMAGz0booUFvPtU3u93wspHZ+7LjeYcSEcD0Fy7vSe6+zb+V6wjFSpH3jkqOD35jl6YQbVezSzzkINcSJJwMj3Ri4qYDOd9i68XTsWG2n8ddgbTdb8VQHbfpna9lmbzjwUtfolIy7hLs=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR2P281MB2859.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:69::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.20; Mon, 24 Oct
 2022 10:56:49 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::adc3:ee78:7f30:722]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::adc3:ee78:7f30:722%4]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 10:56:49 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Joe Perches <joe@perches.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
Thread-Topic: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
Thread-Index: AQHY5T+Ki+hRTsI0rUKVheWiu5nxcK4dH/IAgAAI0gCAADasgIAABLCA
Date:   Mon, 24 Oct 2022 10:56:49 +0000
Message-ID: <57582495-210b-f9c2-db80-e2ddbc76e7c3@fi.rohmeurope.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
 <db45c0ee76c3205b9253cb2200a79119c2f2b946.1666350457.git.mazziesaccount@gmail.com>
 <92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com>
 <0c1471c0-b6b0-7b2b-62af-d3221edeeac4@fi.rohmeurope.com>
 <6b9b7f9d835a271312bd5955d96b83bd14c9e6fa.camel@perches.com>
In-Reply-To: <6b9b7f9d835a271312bd5955d96b83bd14c9e6fa.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR2P281MB2859:EE_
x-ms-office365-filtering-correlation-id: 322ed95a-667d-4f19-ad48-08dab5ae7367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iQmcda/f0ZqjSOR1TZK3PXJTUX+n3mqs9pw0253bqEOeAb/8ksl0zPHCsNwqHZCs7Nt9jcwUEO+XfzZTHkFqFmjyjK6M9TEKQtw9BuRTupy32m0zT8wNFYmXSpgYt+cVBVcpRGJ6qY7VHgwvk94wvsjLmpvcqsKHZqplosbqSiWXa5tcaSsGE47a2z02Ka/gpfnOqy0W7ubI/ewdXXVAxq0KQeKLeXlD9HOSjmQUJzRV3FVeE03Xk6s1nW4QnoNVIFaCTUI1VXDdTEHqgVzf7+qHVacxXCPkZTjIpB9fFZAx7pBe3sFZxze1nTRN4MsDFqi6cjb6xfKMje7LBi0Ypnl+eKW9FdS+TyBlidUozkuJtYj0Ljdmlop04fHvviGB8PGvmZO9vMUht2xWrjd0M1H0zT788jpsxhPNv3Lrn4UfkJ8B2/dLxaHaV05B+7RdAiF8kRDaKsEsE5wwNh2GvuyKmOTmG32p4A3NLBvxel95r8QuVWckRT9+fYskTxi7lhv+tgEZXATK6q60jPqPEqGqk2MLUrRA8xjnB6qcT/Z+9OZHAxslgDLmXu8JNRyLB5+/x5gKj9eYZOeQY3qwzr0MmqDlFmUrCY+gf/cROZteQtcJsQIcPj99fNUpRiu04w9MeJIA9SUjO0TVWUI4nrUygJs0SVm28v7nlFDhkGigxkbQUc4AbAG8gusNxPL1YXx4CPskHR9RFCFaoKJvgnEiCAu1Jluze0vA0Y26UQYiM5mCOoPMcvFSKnxdd1dp+ykJwiPIpffurkGYw4BVzbKimKgHhKYUCCsOF2/24WcaTGI8Q/NRg2125FHPIuMazgg51TNVrX0XmFj1dZdJE76n6PsRPQbsl1xRAlgOSE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39840400004)(366004)(136003)(376002)(451199015)(66556008)(86362001)(66476007)(76116006)(8676002)(4326008)(186003)(66946007)(66446008)(478600001)(91956017)(966005)(64756008)(41300700001)(38100700002)(2906002)(4001150100001)(6506007)(53546011)(110136005)(54906003)(26005)(31696002)(6486002)(38070700005)(45080400002)(2616005)(6512007)(316002)(71200400001)(5660300002)(7416002)(31686004)(122000001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm5KZHUzNkMrWFlaQ012VW9RT3plMkxHVHlTclNYU0p1akhKU1RYTDRMWEw5?=
 =?utf-8?B?ZnZubjB5dUNDM1BRWTRSSEN4b21zUkQ5LzNXenR2emJBMXdaRmlnWTUrVXBw?=
 =?utf-8?B?T1N0Nk52cUs2K3BxNCtGOExUVXVBQTJGTWQ1RnNNejJ3S3EzbEV5SWh1SUJN?=
 =?utf-8?B?QlFBcUlCMjdEUGg0ekRHZDA0eG05eUR4UkdhanNJWWpRNzUwSEVDTm8xR0RX?=
 =?utf-8?B?NTUwakt4dG5MUjQ0S1JJYzhJbVV0ZzhnNUVzNGhCbkFKaWRnMHRsQkdnZEtG?=
 =?utf-8?B?THVoZkFwZ0hKVkZqS1ZZS29iTFEvM0ZDT0JaSi9LSHM5czJidVJ2YXErbEo3?=
 =?utf-8?B?SEJhUEE5UWdaaUlIKzRUUkVUc2s5dHMvUlNyaVZrUzVoY2E1Q2RnTURVYk9W?=
 =?utf-8?B?QnFXQVA4cmVUVGNreEJPLzE4Z1F3eGcyS0ZEaGJTVDRiQ05jUXlFT3pXSFJt?=
 =?utf-8?B?d1l0cW94SGExWVVMZmpIVXFDL1FBN0F3aXFyOWNmVnFjSnBFVGdNT3I2bXgr?=
 =?utf-8?B?RDBrQ0U3TDVJZHdmZmN1ckEvYzRUYWh0ck9DZFA2dmxqczhzcStLUVkxQmlU?=
 =?utf-8?B?Zm5zdUk1T3I2ZWg5K0cvU1ZmZEdoRnlPZkRIcmhvV2lCeG1hQnVlK0lFQ3NP?=
 =?utf-8?B?K2VGdWRpSERUS1FjRUxSUHlxWXJYVmVqTVJLNmx3alB4dXZEOCtDRURoZTFs?=
 =?utf-8?B?ZE1KaFI2OG5SNHpIYy9TcUU0R1dTN0NTSHdkQWN5cXp1TTd1MHdYSTdVOTVT?=
 =?utf-8?B?RFZnaXNrZS8wQnVrZ0EwWEljUXdEa3NML09waTJUdjZsOVpMZCtST3NsK2JC?=
 =?utf-8?B?T1JBeXp5UzNuVVVpR0lZZ3hWNVVmbjBlb25yN1EyaEM2NDRLdDg3Wk1Wc3FX?=
 =?utf-8?B?NVBqWE13R1JteWpWQ1ByeGRpWGlDY09Pck5lSlY5M001YURnSGZQaXRPMFZD?=
 =?utf-8?B?L3RsWm1oUEVRTkJCVVl2b2NlSWJQWG5wTWNmSnJJdU9rOGRYQ3k1aWVzVTNt?=
 =?utf-8?B?YTJPZld2S2VneTI4MDJVTzUxKzNESXNzb2dJMWpqUUtBMjd0ZGQ4L1RvaVpI?=
 =?utf-8?B?Q2RXYWozV2JhM3RTVmM2VDB0Um1Ua1h6Sk9BYU1DZFdnMFV2NWJDMWYvZVhH?=
 =?utf-8?B?c3hGcDY5UkwxSXJrQ1lZWkhVckQvRHlUeUsrL3REOGkyR3M1a20waEx1UjM2?=
 =?utf-8?B?TE1zR2NTcWIwUmxjTFlValZNV05EMW5xcDF1dE9XYysyMzlwdnk2WldKenZB?=
 =?utf-8?B?ZFVOUmFjV3Y3SUhoaDEvd2Z5ZWNYWEFOQmt3YnhzYkhXR0Q4UGdTZE1qeTVh?=
 =?utf-8?B?YXN2anpKbS9YVlpxTDFRNTlpOXpxUnZab1c3U0U4THBWTkl4cDdCcXVBK2VC?=
 =?utf-8?B?dVFLSE5PY2dKcERwSTgrRU1OVUlHRHcydVBXK2hmeW9nb1oxbkZuTjA3QWkw?=
 =?utf-8?B?QlFmbndYRVAxSWplcHJGME9vUW9yNjZ1cG5iaGk5ZHYvSnpGMERCUlVGNEpt?=
 =?utf-8?B?S1VYSnpIOUJDUzlCTWw3TlVvY0ZqYWhEVnozWmZwa3pGZU5UWGlLdVNodUNl?=
 =?utf-8?B?MmlMcW9tNHNKdTZ0NUlySnVkZ0doOEVrQ0s3RWhmZWhJNnI2TG1qL2RUME9N?=
 =?utf-8?B?WHl4UFN2V3pOTkFnSEFtaWxYNDk1U0RRc05RVG9DOVR2SVNwWmx4dTA2Qkl6?=
 =?utf-8?B?TzFRVzBCTFo0Q29QQkhtN094aEtScitwRTljQWlNNnpscERNZDhaYnFsbnRs?=
 =?utf-8?B?ZVZGNUQ2SXBjejN0cEVaUFp5NGplOGRzN3FZclBCY3F1WmVZNnhOQ0VId3VE?=
 =?utf-8?B?VGk5WmZKcy95NlVSVmZaMnArUXdJVkg3dzJTMmw4aitQU3RxaVFsNG13OWtM?=
 =?utf-8?B?U2pIa2NzbEprckFNblVEV1ZtdFV3U3grT25lSUl6VTVuODBjQ1lTZGlyOWJD?=
 =?utf-8?B?bEtqMkR3b3BqRW1weHdYWGtFTXdRSVNmRVV0OVZhME5ZNzVwTCsxQTVMdXJ0?=
 =?utf-8?B?NkFHSVpLRWt5NTlHZ2VrdGkvWkNkL08yV0ZSK2phZTMxQ0p4UGRJMTJ3RExR?=
 =?utf-8?B?RWFaeURtL0lQQlU3YjhEejlrbUZCdnk5N2dTQTBiRjRsM3FJWWRuQ2MrOElz?=
 =?utf-8?B?TVV0N3R3L3hkdzF1YW5XVDBQZGJjTm1FOUJaYWZJMVBLR0tZeXRTSThHV2VU?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94193CD673CECE4AB3CC3BD48C3427C3@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 322ed95a-667d-4f19-ad48-08dab5ae7367
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 10:56:49.1145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZWM91JJflbxvpplK89v8KJ2E7Xkw7qAlqvI4ZQa+6ieRyCgL3kODUhssvW/R3w4Mgu9dcd8875bGzcRnKJG14R55RfGqt7ghewNcHlReBzHN5tlSzDHaOFBfP2xs50G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2859
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjQvMjIgMTM6NDAsIEpvZSBQZXJjaGVzIHdyb3RlOg0KPiBPbiBNb24sIDIwMjItMTAt
MjQgYXQgMDc6MjQgKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+PiBIaSBKb2UsDQo+
Pg0KPj4gT24gMTAvMjQvMjIgMDk6NTIsIEpvZSBQZXJjaGVzIHdyb3RlOg0KPj4+IE9uIEZyaSwg
MjAyMi0xMC0yMSBhdCAxNDoyMyArMDMwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4+PiBB
ZGQgbWFpbnRhaW5lciBlbnRyeSBmb3IgUk9ITS9LaW9uaXggS1gwMjJBIGFjY2VsZXJvbWV0ZXIg
c2Vuc29yIGRyaXZlci4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVu
IDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBNQUlOVEFJTkVS
UyB8IDUgKysrKysNCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPj4+
Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4+PiBpbmRl
eCBjZjBmMTg1MDIzNzIuLjNhYjljNWY5N2RmZSAxMDA2NDQNCj4+Pj4gLS0tIGEvTUFJTlRBSU5F
UlMNCj4+Pj4gKysrIGIvTUFJTlRBSU5FUlMNCj4+Pj4gQEAgLTExNDM1LDYgKzExNDM1LDExIEBA
IEY6CWRyaXZlcnMvbWZkL2toYWRhcy1tY3UuYw0KPj4+PiAgICBGOglpbmNsdWRlL2xpbnV4L21m
ZC9raGFkYXMtbWN1LmgNCj4+Pj4gICAgRjoJZHJpdmVycy90aGVybWFsL2toYWRhc19tY3VfZmFu
LmMNCj4+Pj4gICAgDQo+Pj4+ICtLSU9OSVgvUk9ITSBLWDAyMkEgQUNDRUxFUk9NRVRFUg0KPj4+
PiArUjoJTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+DQo+Pj4+ICtT
OglTdXBwb3J0ZWQNCj4+Pj4gK0Y6CWRyaXZlcnMvaWlvL2FjY2VsL2tpb25peC1reDAyMmEqDQo+
Pj4NCj4+PiBIb3cgaXMgdGhpcyAiUzogU3VwcG9ydGVkIiB3aXRob3V0IGFuIE06IG1haW50YWlu
ZXI/DQo+Pg0KPj4gSSBhbSBjdXJyZW50bHkgcGFpZCB0byB3b3JrIHdpdGggdGhlIEtpb25peC9S
T0hNIHVwc3RyZWFtIGRyaXZlcnMuIEhlbmNlDQo+PiBJIGFkZCAnUzonIHRvIG9uZXMgSSBhbSBs
b29raW5nIGFmdGVyLg0KPj4NCj4+IFRoZSBpZGVvbG9neSB3aHkgSSBoYXZlICdSJyBhbmQgbm90
ICdNJyBpcyBzdW1tYXJpemVkIGJ5IG15IGVhcmxpZXIgcGF0Y2g6DQo+Pg0KPj4gICA+PiBJIGNh
biBhbHNvIGFkZCBteXNlbGYgYXMgYSBtYWludGFpbmVyIGluc3RlYWQgb2YgYSByZXZpZXdlciBp
ZiBpdCBiZXR0ZXINCj4+ICAgPj4gc3VpdHMgaWlvIG1haW50YWluZXIuIEkgaG93ZXZlciBkb24n
dCBwbGFuIHNldHRpbmcgdXAgbXkgb3duIHB1YmxpYw0KPj4gICA+PiByZXBvc2l0b3J5IGFuZCBo
b3BlIHRoZSBmdXJ0aGVyIHBhdGNoZXMgd2lsbCBiZSBtZXJnZWQgdmlhIElJTyB0cmVlLg0KPj4g
ICA+Pg0KPj4gICA+PiBTbywgYXMgR2VlcnQgb25jZSBleHBsYWluZWQgdG8gbWUgLSBJbiB0aGF0
IGNhc2UgdGhlIGRpZmZlcmVuY2UgYmV0d2Vlbg0KPj4gICA+PiBtZSBhcyBhIG1haW50YWluZXIg
dnMuIGEgcmV2aWV3ZXIgd291bGQgYmUgb25seSByZWFsbHkgcmVsZXZhbnQgdG8gdGhlDQo+PiAg
ID4+IHN1YnN5c3RlbSAoaW4gdGhpcyBjYXNlIElJTykgbWFpbnRhaW5lci4gVGhlIHN1YnN5c3Rl
bSBtYWludGFpbmVyIHdobw0KPj4gICA+PiBtZXJnZXMgcGF0Y2hlcyBpcyBhbGxvd2VkIHRvIHRh
a2UgaW4gY2hhbmdlcyBhY2tlZCBieSBkb3duc3RyZWFtDQo+PiAgID4+IG1haW50YWluZXIgdy9v
IG9ibGlnYXRpb24gdG8gZG8gdGhvcm91Z2ggcmV2aWV3LiAoRG93bnN0cmVhbQ0KPj4gbWFpbnRh
aW5lciBpcw0KPj4gICA+PiB0byBiZSBibGFtZWQgaWYgdGhpbmdzIGV4cGxvZGUgOl0pLiBJZiBh
Y2sgaXMgZ2l2ZW4gYnkgYSByZXZpZXdlciwgdGhlbg0KPj4gICA+PiB0aGUgc3Vic3lzdGVtIG1h
aW50YWluZXIgaGFzIHRoZSBmdWxsIHJlc3BvbnNpYmlsaXR5IGFuZCBzaG91bGQgYWx3YXlzDQo+
PiAgID4+IGRvIHRoZSByZXZpZXcuIE9yIC0gdGhpcyBpcyBob3cgSSByZW1lbWJlciBvdXIgZGlz
Y3Vzc2lvbiB3ZW50IC0gZmVlbA0KPj4gICA+PiBmcmVlIHRvIGNvcnJlY3QgbWUgaWYgSSBhbSB3
cm9uZyA6XSBJbiBhbnkgY2FzZSAtIHBsZWFzZSBsZXQgbWUga25vdyBpZg0KPj4gICA+PiB5b3Un
ZCByYXRoZXIgc2VlIE06IG5vdCBSOiBpbiBmcm9udCBvZiBteSBuYW1lIGZvciB0aGUga3gwMjJh
Lg0KPj4NCj4+IFRoaXMgc2VlbWVkIHRvIGJlIGZpbmUgd2l0aCBKb25hdGhhbjoNCj4+DQo+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvODdhYzlhNWUtYjViYS04MmYzLWMwMGMtNzVkNWU2
ZjAxNTk3QGdtYWlsLmNvbS8NCj4+DQo+PiBJJ3ZlIGFsc28gd3JpdHRlbiBhIGxvbmdlciB2ZXJz
aW9uIG9mIHRoaXMgaW4gYW4gTGlua2VkSW4gYXJ0aWNsZToNCj4+IGh0dHBzOi8vd3d3Lmxpbmtl
ZGluLmNvbS9wdWxzZS9zaG91bGQteW91LWxpbnV4LWtlcm5lbC1tYWludGFpbmVyLW1hdHRpLXZh
aXR0aW5lbi8NCj4+DQo+PiAoSSBlbmpveSB3cml0aW5nIHNtYWxsIHN0b3JpZXMuIFNvIGRvaW5n
IGFuIG9jY2FzaW9uYWwgc21hbGwgTGlua2VkSW4NCj4+IGFydGljbGVzIG9uIHdvcmtpbmcgd2l0
aCB0aGUgdXBzdHJlYW0gaXMga2luZCBvZiBhbiBob2JieSBmb3IgbWUuKQ0KPj4NCj4+IEFueXdh
eXMsIEkgZG9uJ3Qgc2VlIGEgY29udHJhZGljdGlvbiB3aXRoICdTICsgUicgY29tcGFyZWQgdG8g
J1MgKyBNJy4NCj4+IFdlbGwsIHBsZWFzZSBlZHVjYXRlIG1lIGlmIEkgYW0gd3JvbmcgOl0NCj4g
DQo+IFRoZSBzdWJzeXN0ZW0gaXMgb25lIHRoaW5nLCBzb21lb25lIG91dHNpZGUgb2YgS0lPTklY
L1JPSE0gbWF5IGJlDQo+IHN1cHBvcnRpbmcgdGhlIHN1YnN5c3RlbS4gIElmIHRoaXMgX3BhcnRp
Y3VsYXJfIGRyaXZlciBpcyAic3VwcG9ydGVkIg0KDQpZZXMuIEkgYW0gc3VwcG9ydGluZyB0aGlz
IHBhcnRpY3VsYXIgZHJpdmVyLCBhc3N1bWluZyB0aGUgc3VwcG9ydCBtZWFucyANCmFiaWxpdHkg
YW5kIHdpbGxpbmduZXNzIHRvIHJldmlldyBhbmQgZXZlbiBvY2NzaW9uYWxseSB0ZXN0IHNvbWUg
Y2hhbmdlcyANCi0gb3IgdG8gb2NjYXNpb25hbGx5IGV2ZW4gZGlzY3VzcyB3aXRoIHRoZSBBU0lD
IGRlc2lnbmVycy4NCg0KQmFzaWNhbGx5LCB3aGF0IEkgZG9uJ3QgZG8gKGFuZCB3aGF0IGluIG15
IGhlYWQgZGlzdGluZ3Vpc2hlcyBtZSBmcm9tIA0KInJlYWwiIG1haW50YWluZXJzKSBpcyBob3N0
aW5nIHRoZSBhIHB1YmxpYyBnaXQgdHJlZS4NCg0KPiB0aGVyZSBzaG91bGQgYmUgYW4gaW5kaXZp
ZHVhbCBsaXN0ZWQgYXMgaXRzIGFjdHVhbCBtYWludGFpbmVyLCBub3QNCj4ganVzdCBhIHBlcnNv
biB0aGF0IG1pZ2h0IHJldmlldyBzdWJtaXR0ZWQgcGF0Y2hlcy4NCg0KSSBkb24ndCB0aGluayBs
aXN0aW5nIG1lIGFzIE1haW50YWluZXIgb3IgUmV2aWV3ZXIgd2lsbCBpbiBwcmFjdGljZSANCmNo
YW5nZSBob3cgSSBhbSBsb29raW5nIGFmdGVyIHRoZSBjb2RlLiBJIHdpbGwgZ2V0IHRoZSBwYXRj
aGVzL3F1ZXN0aW9ucyANCnJlZ2FyZGluZyB0aGUgZHJpdmVyIGV2ZW4gaWYgSSBhbSBsaXN0ZWQg
YXMgYSByZXZpZXdlciBhbmQgbm90IGEgYXMgYSANCm1haW50YWluZXIsIHJpZ2h0PyBCZXNpZGVz
LCAiYSBwZXJzb24gdGhhdCBtaWdodCByZXZpZXciIGlzIG5vdCBhbnkgDQp3b3JzZSB0aGFuICJh
IHBlcnNvbiB0aGF0IG1pZ2h0IG1haW50YWluIi4uLiBJIHRoaW5rIHRoZXJlIGFyZSBxdWl0ZSBh
IA0KZmV3IE1BSU5UQUlORVIgZW50cmllcyB3aXRoICdNOiA8Zm9vQGJhcj4nIHdobyBhcmUgYWJz
ZW50IHRoZXNlIGRheXMuIEkgDQp3b3VsZCBub3QgdmFsdWUgJ00nIG92ZXIgJ1InLg0KDQo+IA0K
PiAJUzogKlN0YXR1cyosIG9uZSBvZiB0aGUgZm9sbG93aW5nOg0KPiAJICAgU3VwcG9ydGVkOglT
b21lb25lIGlzIGFjdHVhbGx5IHBhaWQgdG8gbG9vayBhZnRlciB0aGlzLiA+IAkgICBNYWludGFp
bmVkOglTb21lb25lIGFjdHVhbGx5IGxvb2tzIGFmdGVyIGl0Lg0KPiANCj4gInRoaXMiIGlzIHRo
aXMgcGFydGljdWxhciBkcml2ZXIsIG5vdCBhbnkgc3Vic3lzdGVtICJhYm92ZSIgaXQuDQoNClll
cy4gQW5kIGFzIEkgd3JvdGUsIEkgYW0gcGFpZCB0byBsb29rIGFmdGVyIHRoaXMgZHJpdmVyIGFz
IHdlbGwgYXMgDQpvdGhlciBkcml2ZXJzIEkndmUgc3VibWl0dGVkIHVwc3RyZWFtIGZvciBST0hN
IGNvbXBvbmVudHMgKEtpb25peCBiZWluZyANCnBhcnQgb2YgUk9ITSB0aGVzZSBkYXlzKS4gSSBo
YXZlIHVzZWQgdGhpcyBTdXBwb3J0ZWQgKyBSZXZpZXdlciANCmNvbWJpbmF0aW9uIGZvciBhbGwg
b3RoZXIgSUMgZHJpdmVycyBhcyB3ZWxsLiBUaGlzIGlzIHdoeSwgYnkgDQpkZWZpbml0aW9uLCB0
aGUgUyBlZy4gc3VwcG9ydGVkIGlzIGNvcnJlY3QuIFF1ZXN0aW9uIGlzIHdoZXRoZXIgb25lIA0K
c3VwcG9ydGluZyBhIGRyaXZlciBtdXN0IGJlIGEgbWFpbnRhaW5lcj8gSWYgdGhpcyBpcyB0aGUg
Y2FzZSwgdGhlbiBJJ2QgDQpiZXR0ZXIgcmV2aWV3IGFsbCBvZiBteSBNQUlOVEFJTkVSIGVudHJp
ZXMuIEhvd2V2ZXIsIEkgKHN0aWxsKSBkb24ndCBzZWUgDQp0aGUgcHJvYmxlbSBvZiBoYXZpbmcg
YSByZXZpZXdlciBzdXBwb3J0aW5nIHRoZSBJQy4NCg0KWW91cnMNCgktLSBNYXR0aQ0KDQotLSAN
Ck1hdHRpIFZhaXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWljb25k
dWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9uZyB2
aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
