Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0281C74C6C4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGIRfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjGIRfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:35:48 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2185.outbound.protection.outlook.com [40.92.63.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFDF4;
        Sun,  9 Jul 2023 10:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl+iNhjNGXNoOeQAjZ8brMIEbFoBYPp3kO/vmomOjrYBSHoVTyxF3wMdQtg4svqk5BNItmYzLximLHfrDsf3aJpXiMDUbEiOlgxm6OJ9dbTY2I03THGLiFHTq9qkZapFiGE2UI6TJMJP3k0mW+V6JIMsdLuvt7n2yrn0VwLIxRsc54x2DyRSsG66zgOXQ3uMUbsvWWBaC8wZjrgiK+bZISBXq18ErCvfnu2bCIkUpCv5h2D7zJxE0283YorX13norpkX9zRjypRYl6+MYFEiDL/kJKI6lBOY3ifT809lJaBwx5kd7F/Ub98I+XNnV5IhJZszSoVEUqwl4uMXwwstow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgoM1eOWzRFuygPZ9Hw72yHzt/+8zIcx5WY7MWUpJM4=;
 b=joXofKr8khbyN/hJoiEWExo7yubr5WFBZ7c7ph6+Vl8KKc9pK6qz8RUYLTbOo4gYFZ35/2ZM5CZHGYZg1uHkEaetBO4iAmVv4iJ3SlUrxirtOUWAjihSMWUBuZ5Xd8d3CZKyq2JWf8+reNq0UUa06ipjEWmC0+fOS1TEJiGyV5tnmyUBkh3+vXe+s/WqtqzCqbslx6MeBw2Aaz7JoSAaP7CdmdvGamMV5Y62MLgwoVE/ep5j04I1McbTrikez/uu6desAqPN3JyJS6qvcA9NRp5Kc1amJkpXOAoG9f1cvGFdd7beQuKDefrhnQhvTcAKydyRAJUOBB80x7mvKXn4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgoM1eOWzRFuygPZ9Hw72yHzt/+8zIcx5WY7MWUpJM4=;
 b=lSNq1NqaFNw0HEcjRvm8ek+Xifd6AlNPKGeDl+zXLMyFCqUte4z2yQrMc6rsz0/fLF0wJsjS6NF3hzjnYxfiajUtusPB+8alAgTkw69guWCt40qneWgpWR7a2ztVfdNBNn9w5bt3rrcgLoh0xiNEwcfOFVvATwPQvO+/y8mhm9zqWlcwxeOGRXFk7S9IH8Ynw6/gv4yXVSlNtv/yfRn8UW+NEg/rHHUxOHpDC0cGmFDuHzULkfmWkIQQC6mMyvSg+pDuSGtAqQI4cFB12OTHjlS/w2GuteKpoHjfbM3RVx8n5igV40G4ZYsXO0zKjYuaaLU1YJ2S87Fs3gKAuai4og==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by SY4P282MB3873.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Sun, 9 Jul
 2023 17:35:39 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 17:35:39 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>
Subject: Re: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Topic: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Index: AQHZsmnnf7L6P8pq70KmLgqGjaEZu6+xk0wAgAAfbAA=
Date:   Sun, 9 Jul 2023 17:35:39 +0000
Message-ID: <93faf53150732ac776e68e34709a9aa8c88b5944.camel@hotmail.com>
References: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
         <380911b1-13b0-2c69-7adf-f40abb604c6c@web.de>
In-Reply-To: <380911b1-13b0-2c69-7adf-f40abb604c6c@web.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [0l2uxp0+OlDjh67Rp+TUlvRi4UAW6zxJfSlZmB0IqoHa5Fu4YYTUG2v1NRkIb4gS]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|SY4P282MB3873:EE_
x-ms-office365-filtering-correlation-id: c8b6ad6d-bbfa-415f-3896-08db80a2e9c0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1q7ZUqWG6/Sy1wYmUnv/ihoVpL90Uv5uYdTdZ1W08j/BJiX05jcUynW9bP9jCAOJeYVhlwM6uw12sq8mt8BI7+SnhIZ6eIznvqj6I13XdwhTkjXJvY/VsAqMD4criKQjKg6nWiEpZkgAvCqu1LUjNoM52sVdpwvBMvDbhix8f8RzZgIdUdnLNqt15MiW0g4vlvyzs14F+0nJhaMpTYFOd2FLDZJW7p8MLiXiuzDjSp6bEMCEsf+N7Vhwg8Siz0vBKVY7eaEj5qhgibxS35o9nSd8L8lhbpPP/P2rxm1U57ZKDZHrT9fusRjcI+TUkrmbvNOXU+As7AIxJaTZY82rwdAOoq1WFDgcZUFG3uDFc+zoZPOBaVmzQ5e79ACAoTAFsGUd+ZWLeOgLEU4ov8kQFhl0uCMsDnXUCqV/e97dHXZmd6XL0nfqsq3jT4zP5Q+r/hzTQezmxY6VtcjFIhVDkMvwf4Fv59g6ZBWysypW6xp680A0l6m9MdlGtyMhTvP6dktkROsiiUnjw09s/7W+H5x6zc0nWY0Upa61K20/wQY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDVBUDFmcnBUcFNlWEZsczE5NmVMWk8wSkV5RG1BUHdZMGdJT2J4RXJxTWsr?=
 =?utf-8?B?R1YvdTRzbFUwM2l1SzZjUXY2a2tzajZoQ1o1ZGoyelN2VGJ2aFlTbzdUbnNm?=
 =?utf-8?B?aFl0VGk3QTM1S0QxR3pwQUZCKzRsdk4rbUh5eWhEVU04aDM2QmFLZldNMWk1?=
 =?utf-8?B?VkJ3ZExOdjI3UGZ6OHI2S01zT2djRmJYTGs5b2RlMkRnZm4rUHFiUDFmbVZC?=
 =?utf-8?B?bjdkOHd6amFlZmFvd0NJemtQWWdWL3RldVU3VDdRMjNiM1VMUGtkTEJqSHNI?=
 =?utf-8?B?R2g2V0owdnJNSDNXT1lYd3FuOWhJSlpubmx2SVVQOUpjUFpob2sxT0w2b0ZL?=
 =?utf-8?B?N1JKemk2UzJnTDY3Skl3SDdVN0UvK2U2ZVc3cFkxQTYzMnZzak84Q3Rlek0w?=
 =?utf-8?B?aXYvbjdLcXF2TmtpWVAzbTAzbFgveDNMdlAvVGNNcmFLeDRZZkVVa05aUEZU?=
 =?utf-8?B?ZGxTaWtycEJYalVScmoxc3lacm95ZU45QVZ0eHhKd2VXN1MrblIwbk9rRFJz?=
 =?utf-8?B?UjRlSlRSTm13MWNmZHJxTWNjMmt0YXhaY3BwblMvTlNKWXArQlB5VlBYS1pY?=
 =?utf-8?B?ZDROMlNQNWEvVkNVTnlvQ1l1aGQ2bHJEM1RXYzZueERtbHpWYjZQeUFOd1Bo?=
 =?utf-8?B?aFhIbXE1OStGL041NExnS0dhS0grZEQrWlhhT3ZIVlhvOVlmL3pXMWlObWpx?=
 =?utf-8?B?WkNHdlZDeTJKb3VMR042eFNlekR2Zko1dkFsN2VYdEJPckxXTkEyeGJOdnhx?=
 =?utf-8?B?VDZWS1FnMEZYSTdwZHFSTEpESUVnSXl2L1JZeDdrSUZGbm5EaGhTYjR5L1dw?=
 =?utf-8?B?TjFtazZIMUZ5WS9GSEszQ1M2S2ZUSkxnYzJMVzdtZWJtYVN5emhRSnZyZnp2?=
 =?utf-8?B?STJzV0EvYkZ5a0RYYUcvSXo2by9vZGxkeitzWjFyaktML3hXbllwNlNsY1Iy?=
 =?utf-8?B?SU11TUxydGRkY3l3Rnp3NkRrTXBRVGE5RkVBaVlUUE1ldUF4T3J1djc0VnZF?=
 =?utf-8?B?UjJQWjlmdDkxTkVlOTVFaStJamVBL3VlY2hoQ2hueTRtRWhOa3J4T2owMkxJ?=
 =?utf-8?B?RXhBQnlBN0lrNUF1cHFNNUhvYlkxa1dianNnRHMwWG5MTjFlWjNHSDBqYWtD?=
 =?utf-8?B?bGZkRFRLbTVKWnJqZ3ZFZGFkOUdyMklHTnpLalJqdGswcEtRR3oweXMrSVNH?=
 =?utf-8?B?TGpuNEVDellCT1RDK3dtTnBwRlhnQ2FHZjg1alBDWU13Wnh1NzZHUWZsZWwr?=
 =?utf-8?B?ZkJQb2ZDb0ZoTzczbnNtMCtRVnM3dnFsT0JBTXNCay9FdXVPSzhhOEIvdnRi?=
 =?utf-8?B?a0xBRXRhdmo5UUpvR2tvbCtVdjRUa0w2Z294YWQ4c2xsRUNsUnFOZGErbjhJ?=
 =?utf-8?B?cHR3M3JWY1IrRlVDem5nRGwyM1daYWYxQ0UwL1BEU0JjTFdBVnI3bFBJK0ZM?=
 =?utf-8?B?eXZFbWlsM1pkWkNCTG9NaEtpRkQ1MURkSjhUemR3YW53N0licHpPVE1rb09m?=
 =?utf-8?B?eEFQTEN0elluM3dxcGJDUEFEMkN0dVdTWkplY1RzclQvMGxDZjF2aUNrQlZs?=
 =?utf-8?B?VTNJeTJJVGx5ejkzd3pVWkVUNTlRdlpLVjAveU0xMWRFbnRDU1VEa0k4aUJZ?=
 =?utf-8?B?QlowSWdqaTdmdXMzczk3cVhSQ3hMbldxQm14aUJVVGFoRnV2UVIweU5DR3ZP?=
 =?utf-8?B?NjU4SzU2alFQRGtXUnFkN0xVM3pDc3pyTEtKVkZiMGxQNkNXYXJZczRvRlha?=
 =?utf-8?Q?fE92bOPUQSt7zIV/ck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E35432C1F40264FB8995EB3FEE484E3@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b6ad6d-bbfa-415f-3896-08db80a2e9c0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2023 17:35:39.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3873
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMDnmmJ/mnJ/ml6XnmoQgMTc6NDMgKzAyMDDvvIxNYXJrdXMgRWxmcmluZ+WG
memBk++8mg0KPiA+IFRoaXMgcGF0Y2ggdGVuZHMgdG8gZml4IGJyb2tlbiBDT05GSUdfQ01ETElO
RSwgd2hpY2ggaXMgbm90IHdvcmtpbmcgd2l0aA0KPiA+IENPTkZJR19DTURMSU5FX0VYVEVORCBv
ciBDT05GSUdfQ01ETElORV9CT09UTE9BREVSLiBTb21lIGNvZGUgaXMgYWJzZW50IGluDQo+ID4g
YXJjaC9sb29uZ2FyY2gva2VybmVsL3NldHVwLmMsIHdoaWNoIHNob3VsZCBoYW5kbGUgYnVpbHQt
aW4gY29tbWFuZCBsaW5lcw0KPiA+IGluIENPTkZJR19DTURMSU5FLiBUaGUgYWJzZW5jZSBvZiBz
dWNoIGNvZGUgY2F1c2VzIENPTkZJR19DTURMSU5FIG5vdA0KPiA+IHdvcmtpbmcgaWYgQ09ORklH
X0NNRExJTkVfRVhURU5EIG9yIENPTkZJR19DTURMSU5FX0JPT1RMT0FERVIgaXMgc2V0IHRvIFku
DQo+IOKApg0KPiANCj4gV2hpY2ggY2lyY3Vtc3RhbmNlcyBkaWQgaGluZGVyIHlvdSB0byBjaG9v
c2UgYW5vdGhlciBpbXBlcmF0aXZlIGNoYW5nZSBzdWdnZXN0aW9uPw0KPiANCj4gU2VlIGFsc286
DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNo
ZXMucnN0P2g9djYuNCNuOTQNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQpJJ20gdHJ5aW5n
IGJvb3QgdGhlIHN5c3RlbSB3aXRoIGEgc2luZ2xlIGJvb3Rsb29uZ2FyY2g2NC5lZmkgYW5kIGdv
dCBzdHVjayBvbiBtb3VudGluZw0Kcm9vdGZzLiBJdCB0dXJucyBvdXQgdG8gYmUgdGhlIG1hbGZ1
bmN0aW9uIG9mIGtlcm5lbCB3aGljaCBkcm9wcGVkIG15IGJ1aWx0LWluIGNvbW1hbmQNCmxpbmUu
IEl0J3MgcXVpZXQgYW5ub3lpbmcgdG8gYmUgbGFja2luZyBhIGZlYXR1cmUgY29tcGFyZWQgdG8g
b3RoZXIgYXJjaGl0ZWN0dXJlcy4NCkFsc28sIGEgZmVhdHVyZSBzaG93biBpbiBjb25maWcgc2hv
dWxkIGJlIGZ1bmN0aW9uaW5nLCBvciBiZSBjb25zaWRlcmVkIGJ1Z2d5IGFuZCBnZXQNCmZpeGVk
Lg0K
