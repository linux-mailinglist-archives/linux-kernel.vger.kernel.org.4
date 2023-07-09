Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E96874C46C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjGINnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGINnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:43:37 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2152.outbound.protection.outlook.com [40.92.63.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDE2118;
        Sun,  9 Jul 2023 06:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrh3qU0aJNe6d4xqD0Gua8FOyYJ3fGUpC86oefey5a29Z88DjEq/H00xio7yS2bHkGqLeTqJ6RZFEMUCtauvJMI2XdiWNyFWTdFYll5WwrGZ/7V7IVNeRarZ5p+4OnWPDhjNwHfV2wlvC0PnE1Hb1tEEzMd7Bu1zOvFllET0Qft73FL2njgO7pvZu4wr90dL/H/5Z9+V/RRKqVtvYmQSVCdLJWcu5Klyn292f8aJTPD5IQ8AcWwVh5jPmMxedhnPDTfY4xXztE8nFBZZHZj+TOVDXmZZshQrAQTLhHrXj52lZPtKa1tWysVX2svIE++ru/5+YSU8ptrwFHIecfjYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN/uFT2zuimlOkEJlTbmLRHlmJpcsIb7lI7CMQ0KNzw=;
 b=GjJ9+d71IvQo7/sV0wCSTXhWjlPhgzxu6brID7EkrXpeshR5uqf2ZBbvOle+MenQNqoA0V3gEQEFdPlvcnbMU7rAqCpxChP+0/FKhxQPNEna1dTv65LqZT04K6OolPasz3X4OW8h81WmlJZkEZ0aqFyWJZGl6idypj7cDY00mMgCJPBysdUCpobOi+j+MgFtCgLCnvEcHRf4Kas3HBsTKSQUfXsKHHKkm8e7ZcIHy7S7lSP7tcZtCKKExJs20OqXq4LVr8t28/VBjevZiVXYBcY6GBvXBn/8tx0TFOVsZ4+r8RrXATaODjwkbGm+8p7jNBA8S6di10bbSwWebLNpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN/uFT2zuimlOkEJlTbmLRHlmJpcsIb7lI7CMQ0KNzw=;
 b=OBCifdgVy4au8VvXylr/4Hh3LRcynlL5FbGPAoLkYQE18FzYqZVkGVQNc6eV5ICsHwsNmZZs2gvSwq0IBosXk/z+8pkCvB65CqevMhiuRZH/hoRSw4AYN5sMdhfC7sH5yXdeff5c4yiiOxWSNf3EEeK+SRhQJhUfgjGdlNPlmqhTNmvSLPCdviaEO63iXuL+AqZosMYyMp8BZL1mBptdYnX2Qyd+ylt9ESMaXP/aPStUTE2WZLTk3ihDZCD5WLhwfRSLSO3qgOiI2cbbrCN4R+sBNcgsVTxIMEajM7bGdiJ1fEKVPQSeFaaJb1nOGAY+IZ0nVTFqVPii568xXrDkaw==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by ME3P282MB2761.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:13e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Sun, 9 Jul
 2023 13:43:31 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 13:43:31 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@xen0n.name" <kernel@xen0n.name>
Subject: Re: [PATCH] loongarch: Fix broken CONFIG_CMDLINE (RESEND 2)
Thread-Topic: [PATCH] loongarch: Fix broken CONFIG_CMDLINE (RESEND 2)
Thread-Index: AQHZsmtZvHusIdxVcUqwh6trtfIWLg==
Date:   Sun, 9 Jul 2023 13:43:31 +0000
Message-ID: <160653e3eefb53d00c3bb17aa803b4f12569de50.camel@hotmail.com>
References: <3ddf48d97c90e4203e328180763a0d8124890216.camel@hotmail.com>
         <6011256b-f4a9-a410-dc62-cb7a308bf07f@web.de>
In-Reply-To: <6011256b-f4a9-a410-dc62-cb7a308bf07f@web.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [mxaWISIv3U+jbh3Av11Qv7Eapuw8rUJP6VTuTRfu37TDve4h1zYvEHvwLopT6AH3]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|ME3P282MB2761:EE_
x-ms-office365-filtering-correlation-id: 9ce60f1a-190a-4432-8483-08db80827ba8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xq0heFSw/GP2hFBGIpreqnTTK0aDFsLdtlFQyCtsxK83UMCDLx76c41fOtXZGt2shxXVox4PPWP4I0sG//B6RrWlKa6mwHkhZLmwSxFCn6N8Mx9HtfcSawY7PlpM9t5skPyIKFk/MH3kpLiFUE8MxXQfnc/6NJjayNKUEJk6ovDQCnumxW7m1MUwbds10GWJVOoIPtmot7nhyXZtPgzYDxfguzkVb5CvjnFfUimiCf5mjrnNnOo25tLn+eKILzGfEVx4ukKbLXj2dKZ9apaXfW7AOjMSrJwFJ4h6X2eJE25IZSdnGsI4FB98zGADcn6eeHZ/mys968bFUiJoWbsAz3dNXxgnyDeQ6wipnxCurmOvKhP5UNgl8T47XkD7YxCSMM5DBIiYMNscrPv6G5bIPDgJinLUwhQXgQYzWjbv1uvfNSUk0LjVgMpc9e5kaMR+/EUmrsgBt3PVayQsoWaulpdRn/mEy+l48iqJd4zoWf3+6Dcow1X//x5eozxsWvQe7EF9drHx5DEBlW6k+B3lP1HpyCEaMgho0dpCRnafZWc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2trN0wyTXVKM2g2cGpqeWQxVGpoamdtMjNDZmpMdkZSZTV5V01LaVJmUVE1?=
 =?utf-8?B?QTM0bDkxL0lLRGhvVlpNalRLTFU0eUZGQ2ZHaGtlVC91S0xkWWxIVTh4aVpE?=
 =?utf-8?B?MjlKMERBVGtGemhtQ2NSRm5jMzFtajVUeG9vSTQ0SVNVWm1yZmpHb1JXSmg3?=
 =?utf-8?B?SkxXRkFaMStiSzdTNlI3Tnc1a0ppdk1zVndGZHg2WnVvc3VYNm51WEQ3anpU?=
 =?utf-8?B?TE0zTWEvQ00wNGIvNGgzSjIyN1RMTDhqOS9HS3ZOaVc2MnlyblVDc2xhUkxE?=
 =?utf-8?B?MjRPTUMrc0QzOFZIU1Q4TzZjWHNsalppNGNzaFQ1V3VIY1VVZndFM1VaU0Ix?=
 =?utf-8?B?UmY0VCtyTlBsQ2U3WUxzUm5GaHFHQ3NIeWkyVHY0TERvdjFFZ25oSzNNanFQ?=
 =?utf-8?B?UjBpaDd3SzE4RVlrZXhYVEFOV3laYXNwMTdtSzR5cjJhQUtDaHNKRUlKZWVC?=
 =?utf-8?B?dXJ4bklSUitkTkRiZGx1cjJ2WEhHS1VKZDZ4b3ZyUGNNaURHdHkwTlcvRkRX?=
 =?utf-8?B?NHlCWmFoQ0szMXl3K2tTa3NvUmswOGNsOEtFZUJTRm90b0ttSVRPOVFEdzNt?=
 =?utf-8?B?VEQ1S2NFRkZjdzFmT1hrdmlPMkk2OW5hMHppYXpldnJ1UmIvTUwwcXBldGdM?=
 =?utf-8?B?eWNTYlh2UHkwZmZSYjE2bHBHNHRickwraVNIbG84UVJXQUZOOFpCRGFrTmZ6?=
 =?utf-8?B?aTUxQzlaWE02aHdYMHlOY2hPSGZpcnVKMU84bmdHRlVybmE5UXBCRjVRRDNv?=
 =?utf-8?B?Tm04RmxQT1JwNjJUc0lkdHJyRGdROUV1cEUzdnpJWUF1R1gxTnRmMWFVMDFY?=
 =?utf-8?B?TkNtWnFrcytHSWFpRm5NUUtoemN3SmxKUi8wR2hvNTJ1dFUvWDZOWmtleFlt?=
 =?utf-8?B?TjNDTmhuZmQxblpUUUlTMDB3N2tiYkY4TTNTN2JyLzBrM01aWWdqMEJVL0hk?=
 =?utf-8?B?QUdCa3NYRGY1VXFyUlZDaFBDZ1VIR2xxa2lrTTdHblJzakhzcHYwbHBET3Yv?=
 =?utf-8?B?UzlIOHZkT25sU0xHUzNZSkJzSEFJNDhSRVozWDNSRlFFOEhVVGlXaXE1dmU5?=
 =?utf-8?B?ZnlvZGppSVN1ci9rMllGUzBncG92aGV4N2o4d1laeWxSaFQyUkdLb2wwUmdL?=
 =?utf-8?B?WUZOdmNRcWJpY2hSdEQwOXhEMUJIZ1ZMZjlOWkdyK2t3WGlrNkZEblp5YXdy?=
 =?utf-8?B?RVZQSEpsQm0wbHllZStJUHE0aFN3a29GdjZOcTdZZ1dBYmpwV0M3dmE0RUNw?=
 =?utf-8?B?TjY3bDNtaEF1SStwOGx5VE44MXE1L2U4QVozMlZ1NllCd3NXYm0vRWk5U281?=
 =?utf-8?B?a2FMQTR3YjFyeGtzMzNXblpyVEQ5MGRtVFNaUFVIa2c5bVhrS1BTb2NWNFNq?=
 =?utf-8?B?aGVFZTBOTXBFamRsRjQ4eXVUbURkVGR3RE5NQlBFckhGNGk0VkhjKzRXa0JQ?=
 =?utf-8?B?UDhwcm5kUDhrTlRlM2kveFpuZFV4d1AwVFpxUjBnS241SGdjTjhxTDBUWWdC?=
 =?utf-8?B?SSt5U3dDeHA4ZjRIS1lqRW9FZzJXeXdQY3BJOEdwUzZhMFJ4TzlVaHhpbk8v?=
 =?utf-8?B?aE1LQjZnSjg1LzBkcTlkdHpmWHBUZHV2M05RVkJUeEtvOHhvS2JqM09QWHZJ?=
 =?utf-8?B?UWI3d3Bua1RueTNrRzh5UzIvZlE3UFpBQ2VrSUVJQS9ubkpQWk13RjYzNGUw?=
 =?utf-8?B?SjFDOUtEYm9udlA5M0tUY0xsREMzMW5GVkV4Y214UGpVREU2c2o1MWVGUUlE?=
 =?utf-8?Q?Dibe8676t82Ekpl+Wg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <367F0FACA9431948A307FEB3212AA9B3@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce60f1a-190a-4432-8483-08db80827ba8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2023 13:43:31.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB2761
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMDnmmJ/mnJ/ml6XnmoQgMTQ6NTYgKzAyMDDvvIxNYXJrdXMgRWxmcmluZ+WG
memBk++8mg0KPiA+IFRoaXMgcGF0Y2ggdGVuZHMgdG8gZml4IENPTkZJR19DTURMSU5FLCB3aGlj
aCBpcyBub3Qgd29ya2luZyB3aXRoDQo+ID4gQ09ORklHX0NNRExJTkVfRVhURU5EIG9yIENPTkZJ
R19DTURMSU5FX0JPT1RMT0FERVIuIFNvbWUgY29kZSBpcyBhYnNlbnQNCj4gPiBpbg0KPiA+IGFy
Y2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1cC5jLCB3aGljaCBzaG91bGQgaGFuZGxlIGJ1aWx0LWlu
IGNvbW1hbmQNCj4gPiBsaW5lcw0KPiA+IGluIENPTkZJR19DTURMSU5FLiBUaGUgYWJzZW5jZSBv
ZiBzdWNoIGNvZGUgY2F1c2VzIENPTkZJR19DTURMSU5FIG5vdA0KPiA+IHdvcmtpbmcgaWYgQ09O
RklHX0NNRExJTkVfRVhURU5EIG9yIENPTkZJR19DTURMSU5FX0JPT1RMT0FERVIgaXMgc2V0IHRv
DQo+ID4gWS4NCj4g4oCmDQo+IA0KPiBQbGVhc2UgY2hvb3NlIGFuIGltcGVyYXRpdmUgY2hhbmdl
IHN1Z2dlc3Rpb24uDQo+IA0KPiBTZWUgYWxzbzoNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRh
dGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12Ni40I245NA0KPiANCj4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogZG9ubW9yIDxkb25tb3IzMDAwQGhvdG1haWwuY29tPg0KPiANCj4g
V291bGQgYSBtb3JlIHVuaXF1ZSByZWFsIG5hbWUgYmUgbW9yZSBhcHByb3ByaWF0ZSBoZXJlPw0K
PiANCj4gU2VlIGFsc286DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9z
dWJtaXR0aW5nLXBhdGNoZXMucnN0P2g9djYuNCNuNDExDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJr
dXMNCg0KSSdsbCByZXNlbmQgdGhpcyBwYXRjaC4gSXQgbWF5IGJlIGEgbmV3IGNvbnZlcnNhdGlv
biBzaW5jZSB0aGUgc3ViamVjdCBoYXMgYmVlbiBjaGFuZ2VkLg0KU29ycnkgZm9yIHJlc2VuZGlu
ZyB0d2ljZSBiZWNhdXNlIE91dGxvb2sgV2ViIG1lc3NlZCBteSBtYWlsIHVwLg0K
