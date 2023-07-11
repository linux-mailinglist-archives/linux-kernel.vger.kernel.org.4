Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213A374F363
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjGKP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjGKP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:27:48 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2155.outbound.protection.outlook.com [40.92.62.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D9010D4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CccbPiNqkElFEhmFnVlPt01r1ZvCQEB55xk8bw0oKvMjnCz3oEEFwbAK1n6DBugQRbRXSOk0bttw1tRhfa5Ywx7AIOSPRwPDAAO4H2b+tvEzD9pokVSOn+EPoG4i9NPFzIEpaYPvBVEsItG6mWGucy1nsZ3VGlLDKnIulLkloB/n2YADRGayAUKUnPTwKlLknC9tcHr3VCf5Iu9mclt3vz/gA7qI0CKF9UHHJJigAOBJ1AJpWBzmilPCTsw6M0via6Y8iHMFNpqTqJY5gR2sLkpojvpZJt62J6BOQBeSEidN7wK3pb+RqiADQDNDT0eneP11YQx2IzoKYhgLmIRr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yKK7KWFcUI4qi464dG1YHEd7wtzn7kcrFUfwjWs2gw=;
 b=eTU93nIc0rgGB8w8U0cNAfPzKYHaVN9YdFRU9Qr6Ix9REeiBbCi31c3dV2yyt3emRB7kjJxOPCVtZwcNX2QnVkS9/BcFgR6Amww6PgHnHWI3D/fMPTE2kVCXalwuCBmmAsD4PN2dnI8qWg/zypjZ1cB27SbiqKxTJK69iSrmKHuhY6sAnhYpiTFYjOd534O3gmq634povdjHMdg+Pnx3GyyBLZM0NRv+xSfW6fvXv0/6OZ4CPVOnVYyKuKk3Rd1g8j2haSFLjwsNwCssa0o1GG1xaVY3b8r6yzm+Yge9/4s/jPQefRUwgYPnSIxQ5v+em213BQSh6Qfk7ZbMWKfj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yKK7KWFcUI4qi464dG1YHEd7wtzn7kcrFUfwjWs2gw=;
 b=IswNSNHpgPb+Yvg+vqBO18/+YKSjtxkl90/lNXmaDVBfkMSCB5ZNV83WjPm6Uhdyb7RUHY87G5kY8kR0etgyWfJVg86faiWv+aNi6dKFfY8YQCx3KUzNIfckNgt0GypYkyuH4Y+ZphxA+/RAO+HnDkzN7dcpOcRr0X0sneWGblDyPftJT/Cw5iAXFivMVntiR7si9A84o68IxQuFrdnv0s8OvJW7El0yj3f9xpdjs+0xzRgUtAGBLbsl/OLWGvYFrqFfx+60yNADwlv+QLyt+TequZ4Jij7XE802LqYAVeFd82lXhPfY0BN3sMzZ52nDDwqzCvKkAvKnzNVUpn8wBQ==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by ME2P282MB0084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 15:27:42 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 15:27:42 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>
Subject: Re: [PATCH v3] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Topic: [PATCH v3] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Index: AQHZs/4mjIR04u33F0GwdCBe+N7JRK+0n1oAgAARHgA=
Date:   Tue, 11 Jul 2023 15:27:42 +0000
Message-ID: <3310eb5b3c944434b6e3b53750f1801f510811f2.camel@hotmail.com>
References: <MEYP282MB2597B4BD3CDA1ED340691C9CD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
         <CAAhV-H56GhqETf=NAGzHRLk73F+-Kb=j+gzNMshVQijPi-Tc=g@mail.gmail.com>
In-Reply-To: <CAAhV-H56GhqETf=NAGzHRLk73F+-Kb=j+gzNMshVQijPi-Tc=g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [TRUC0lUE/sbJD3YfYL17WwCvLPX0AkSyANepOLr7O5iZQXq9AtmCR5o+ZXdOMjhq]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|ME2P282MB0084:EE_
x-ms-office365-filtering-correlation-id: 33e3ffbf-4903-4cec-b4db-08db82235e5b
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WEPgn0f7U7bgUygBQP59JdjFUJu5dm+EqevT5PupIn5Ako4rItp0ZdCx8lLclYv9q/Iv08VXVCXyFkMEujVTN1Wz7BBQzNowi1tdQVpx8GvembTmeXTRJV2cMa1o+zLa0czd/eZ6WCaemUzepqnTTJ7Op5fQ7xvT+w81ypK5EMBnixUM5Hv9O6knW7rHoDz1MIDbrsXbL2lK+XE9BaHm4ljFDbDDB/GnWPappVNqHBvdp6r58vrMJ2eKr4+BPMzUuychX7u4LdXyc1uhkdZx7X8QmKrwfLml8uUAxS0Mbh3qFi75ztmGHmfgahz7vB+ljPiacgVlv9ME4EpmUgBB/BZgNRHH7uOTku5BfT7Eap2Zt6smvYE+vYWEOPo3FhVzmoAuF2Q6cQvgAo+18tqSms2zbhH3aPJk7eBF0r1Fo4ETIav4Q+pQ3yRwjpbQu+ga5p40rpZ1ZkMs01hM8SJ0ilj3RwTMb7hI5xxsofXzAxfSuxnficLaXzCL+g12HrsH+73uaJcNkS4qq1ejz97ysdomyflKX9lficqYyavq+vkYsGWt5fgBR2/h/i7zFHb
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M29lZFhRSVVBd3UvTS9hNTA0aWlQemo2SmdyR1hPZllFbkF0RExZSjY0OU5n?=
 =?utf-8?B?aWwrTDByMkROZGtTSEF5cFFKdVc0cERLb0ZkUDZNR0s4bHRYSERmeVJ0bmRm?=
 =?utf-8?B?dXFmVFZGYUVjSzhEWVUvQmYvNExNSndGeTdHNXFnSDBRUzRQTkU0N1Z2dFp2?=
 =?utf-8?B?UktIRys5dEwzMnBKRFRybXpNRm1yNjgwRkVNRmhGeFRDRjh3VjU0M2FPbjln?=
 =?utf-8?B?ZWVTM2t1VmVOWWk0REpBVTEwSTZmYk1hSjBMQXlZZjF2N3ljYVhKRXBHUzNt?=
 =?utf-8?B?WU5hWVN0cmpLalQyVXBTQ1k4R0NFSkI4d1lsMHl3V0N5Yk1VMURQaHJtbWFO?=
 =?utf-8?B?d3k0U2R5UUNid080ZHh4UGtDakFWbk0wNVBOOGNtNHRDeXVJb24wNU4wZkFT?=
 =?utf-8?B?MzNmTC95dmZaYWZXbEllVm8xWHVCRVZGTld2MkpwTkVSK3hmREpkbG42K3Y2?=
 =?utf-8?B?Vkd5bGdTRGp5KzRoaFh0K0xodEdOTXNGTlc5bzFKZDEzUUFmbzR0cGhnRlpy?=
 =?utf-8?B?UU1aSzZ5eGsxMXE1OUFCZDRLSE1rS2NOZ0xaS0JFTG9xbzZqTTF3dFlBV0NT?=
 =?utf-8?B?NmdYUXc1TTR2YW0zVVdkSktaT0Q3VXFPQVRUaHlvZnNOam0vdkx1bVQ0VlM2?=
 =?utf-8?B?TmtoTTUwdUpCVW9oMnYySHhtWmp2RWhFb3JRUkJuRXlMU0dWay9hMXluWXNB?=
 =?utf-8?B?blIzN1ROeDBHVkIrNFFvcWt2UWM5TzlsekFOVXpSWlR2Y0dEYkJDcE4zUFA1?=
 =?utf-8?B?VE54c2ZydkpQZW9Gcm5WWFJnbFFCamlISWp2QjlRUzBOcjBRa3pHamtrbng4?=
 =?utf-8?B?VExLQzJ4dzJ2c3dNSjVWZ09ySGlOT1VCL0lkcDAvdk5OcElYdlpUUWtaYWdy?=
 =?utf-8?B?dkVCUUFsZm1iaExOWHpBOTFpVFhJbGU2V3pJQktiTmVCZnZIazBiR2x3eUs0?=
 =?utf-8?B?QzJvL0lLTlRzTTJBVzRua2NIdjVwek0xSjk3L3RxQTBuM1FpWlRKMUZGNHJW?=
 =?utf-8?B?S1l3REZRakVIWjFxdlYxdTluK2tPSzMzREx5YkIxRGhyZk1JcG1zeUpBbGlz?=
 =?utf-8?B?WjJaYy9GTmNmQnlaUUl3ZG83SmZJOWQ4d3Y4TzkvQWJnRkNQL3ZQNEdROVgy?=
 =?utf-8?B?SFRaWG9sUUtFNWpDeFQ0b2tYVHR6VlBMbVYyNk1pbC9xckN5dGtyQW9oSVVS?=
 =?utf-8?B?ZHJwRnJoVXRTMFRhd0dreDRxZXVYdXlGeTRoN1FzdWhyZk5UdFVveWhXVVF4?=
 =?utf-8?B?dFFpSWpmK3R4NTJWL0N6Y2V6aDBjUmVvZlBDTE9wd2FFcGpsdGI0YlFoRnBJ?=
 =?utf-8?B?Tjlmck9mekVmMkhldXlBMjVCKzFLWnBUelJWTzJDUE9OVEpld2dEbGgxWVhG?=
 =?utf-8?B?YTJCRzcyRm5HdS9LUC9JdWtyRkZmV3N5eUlvR0dWWnNUSWErUTRXY2VBUng0?=
 =?utf-8?B?Q0dURHJwNjNaZENiVGgzeHpoTzdpMUFIVXdkR1h1WXpaOHRBN1hYN1pxMkhR?=
 =?utf-8?B?bXZTSFVNRXpaSkRvWXZJQjZiOHJXUm5WNVVZazlzWW1aQ25pZUpJM3VvdUZN?=
 =?utf-8?B?aGZmeUo4VmVXMlBnUTduV3plZUFUd29KRXZxeVMwTk45cVozL09wKzBhK1pU?=
 =?utf-8?B?MzlEWU54NlNDMDBTOXJncWRSZVNmZWRHckljZmVMQ25FMC94Mnh0bmovd1Zq?=
 =?utf-8?B?UHVvTkpEaDVyRXU3R1gxTGsrMmh4dUtmUFlKLzFraFF0c2hGenRteXlnV05L?=
 =?utf-8?Q?K+R1O3fxYjL/RcA9qQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B90DE28F7C27A4985154B88D30FD2B5@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e3ffbf-4903-4cec-b4db-08db82235e5b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 15:27:42.1216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2P282MB0084
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

5ZyoIDIwMjMtMDctMTHmmJ/mnJ/kuoznmoQgMjI6MjYgKzA4MDDvvIxIdWFjYWkgQ2hlbuWGmemB
k++8mg0KDQouLi4NCj4gKyAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfQ01ETElORV9FWFRF
TkQpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHN0cnNjcHkoYm9vdF9jb21tYW5kX2xpbmUsIENP
TkZJR19DTURMSU5FLCBDT01NQU5EX0xJTkVfU0laRSk7DQo+ID4gKyAgICAgICAgICAgICAgIHN0
cmxjYXQoYm9vdF9jb21tYW5kX2xpbmUsICIgIiwgQ09NTUFORF9MSU5FX1NJWkUpOw0KPiA+ICsg
ICAgICAgICAgICAgICBzdHJsY2F0KGJvb3RfY29tbWFuZF9saW5lLCBpbml0X2NvbW1hbmRfbGlu
ZSwgQ09NTUFORF9MSU5FX1NJWkUpOw0KPiBZb3UgY2FuIHNpbXBseSB0aGUgbG9naWM6DQo+ICAg
ICAgICAgICAgICAgIHN0cmxjYXQoYm9vdF9jb21tYW5kX2xpbmUsICIgIiwgQ09NTUFORF9MSU5F
X1NJWkUpOw0KPiAgICAgICAgICAgICAgICBzdHJsY2F0KGJvb3RfY29tbWFuZF9saW5lLCBDT05G
SUdfQ01ETElORSwgQ09NTUFORF9MSU5FX1NJWkUpOw0KPiBBbmQgdGhlbiBtb2RpZnkgdGhlIGNv
bW1lbnRzIGJlY2F1c2UgeW91IGFyZSBhcHBlbmRpbmcgYnVpbHQtaW4gcGFydHMNCj4gdG8gYm9v
dGxvYWRlciBwYXJ0cy4NCj4gDQpJIHRoaW5rIHRoZSBjb21tYW5kIGxpbmUgcmV0cmlldmVkIGZy
b20gYm9vdGxvYWRlciBzaG91bGQgYmUgcGxhY2VkIGFmdGVyIHRoZQ0KYnVpbHQtaW4gb25lIHNv
IHRoYXQgaXQgY2FuIG92ZXJyaWRlIHBhcmFtcyBpbiB0aGUgbGF0dGVyLg0KDQo+ID4gICAgICAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX0NNRExJTkVfQk9P
VExPQURFUikgJiYgIWJvb3RfY29tbWFuZF9saW5lWzBdKQ0KPiA+ICsgICAgICAgICAgICAgICBz
dHJzY3B5KGJvb3RfY29tbWFuZF9saW5lLCBDT05GSUdfQ01ETElORSwgQ09NTUFORF9MSU5FX1NJ
WkUpOw0KPiBUaGlzIHNob3VsZCBiZSByZW1vdmVkIGlmIHlvdSB3YW50IHRvIGtlZXAgdGhlIGV4
YWN0IG1lYW5pbmcgb2YNCj4gQ09ORklHX0NNRExJTkVfQk9PVExPQURFUi4NCj4gDQo+IEh1YWNh
aQ0KPiANCkRvIHlvdSBtZWFuICdJU19FTkFCTEVEKENPTkZJR19DTURMSU5FX0JPT1RMT0FERVIp
ICYmICcgaXMgbm90IG5lY2Vzc2FyeT8gQW5kIEkNCnRoaW5rIHRoZSByZXN0IG9mIHRoaXMgcGFy
dCBzaG91bGQgYmUgaGVyZSwgYmVjYXVzZSBDT05GSUdfQ01ETElORV9CT09UTE9BREVSDQp3b24n
dCBhcHBlbmQgYW55dGhpbmcgdG8gYm9vdF9jb21tYW5kX2xpbmUgdW5sZXNzIGl0IGlzIGVtcHR5
LCBhY2NvcmRpbmcgdG8gaXRzDQpkZXNjcmlwdGlvbi4NCg==
