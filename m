Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2AF74C18C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGIIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGIIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 04:12:37 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2183.outbound.protection.outlook.com [40.92.63.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F6DB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 01:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD8uWi0FeTQhTjwjHlEbGCwNlbmH7ub/HZHZeRx0bJ5PEMm7w5qLmwxfAxh4ao/k3ybuSfVxvcl1Lgf/QJw9Vf17vSW0vePztJpoRh32WrKjfVZ60Kqja5UOKMFf7q0knMhPkLEhICLtNnWVYlxBcObDLbs2kYecNZnBxzSVFDKe1tpMjJHk2l/cjtYJ+e+mBHps2IXH6uYAwRAx5NctvEm1yoOgps8zMGuckZ4OD5i0slIV1uDwI4Y6+lEquT+eBGcMa5NUGV4IxkDrgKEcXJXs/JWAmfWHTPIuYROG5mO8yQ+7qQnywAeuAE7i4wjhuIZiOvsiTYilGWf1r2CxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcUrVUIjq80dKRiktr182DEFQloGzQM64p5gB250t/I=;
 b=jaxTzyC0X2OeGk/99Jba3V3zRhWs7sVZHpTuKM3LMSh05hTJXVkaRJ5pwEAljSADL7JK6WRUg2iB8NyzqpZDzdRqxZhhQR6KJdbSjUNZGyLmien76+yaeQYZYA9D/rvLTfAawl8s45ufJPTITkYq0qbq3aS2Nqtge6TkR4M9gBYRBaI3psz7dAPgYyVQNmIjeQa++eFsEh6OmDFhmxsXUlB6Pv8oMPrsebspN/fP9k5lDxZpBufTwSoNOE29XVtbcTgIXWTidIrD8sQafa48zSZCdkQGu5prr+aCPjnSLF7ZLYX0ni9Lw11O42hLxWBgJMLO9xiE+g9/2FwCBIBrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcUrVUIjq80dKRiktr182DEFQloGzQM64p5gB250t/I=;
 b=pJTA9X7O7APDTbRzpqPNDTKGfwQY4nQmiSRCRyyMnscJ9A38tIVZEUJ6XL7EaamdqaHTnIsfI7uFIhPj517zXa2m9pyw3zs7iVsuc8htVjLaW9Cg/PTdKvm5j7BZ56LzQbRGZLzbbaUY5LVvru1UGIQNcqFMcQYEdCuywLBY65CstK3wZP0deLpRri1COwwfW25rDDymQ2V0GalkYidpz1gOb+W/t1ThOa65rzhkz+xI17xZEDEKNgUdb4Zw6ERPQDjs+myuFwL599wp0RFLLSCryXt3QwcqBh4El1nRJTx6+cqU45j1Keqnoco9P1/jNNl+2zwHEE+/rv/kR2Fu1A==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by SYBP282MB2368.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sun, 9 Jul
 2023 08:12:32 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 08:12:32 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>
Subject: [PATCH] loongarch: Fix broken CONFIG_CMDLINE
Thread-Topic: [PATCH] loongarch: Fix broken CONFIG_CMDLINE
Thread-Index: AQHZsj0c5K+h8nQnc0m437rXpxjTeQ==
Date:   Sun, 9 Jul 2023 08:12:32 +0000
Message-ID: <3ddf48d97c90e4203e328180763a0d8124890216.camel@hotmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+/HjbJIcr477hmC4e0q0J3k15cr8vwAHJCjJsKZ7WjyH47xWNdWOmqUd5k9Q2wvR]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|SYBP282MB2368:EE_
x-ms-office365-filtering-correlation-id: e1d8feb2-a8f2-4626-b2dd-08db80543ec7
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kDYLbWRAU/1vgK0+sWQmZO7WkHMawy8w2IbskQq99cCfRqixGj06zfd6p2fQw8YguFsbayy5Rjf6BhzpMh7BwZ+vcJ06hbYsJqyzvsxDpgEeqLx3bEI+SrFlR9GMKFFFRBd4Eae0iS6OHun9NEGy04WV59b7flNPaYtc5ISPOylOuycCQNvJMko3h9jGAnV82LzDVBknvwY8gF002q31EMVUG0U4OKAeIUsCfpEYc5ZT07V3MpY8E6i1W6NoAGbEGaydXPsgA4SWuyptERwquYHfWV16BZhpmaM1aOocX0+WX348ZnSKEKIf8y95uoDZJfi4QqzneuVq4Nf25uAb5fAoy856viNbjVRwr1B//lhsgjehQYe4meCylleWr+ERJz9pibT2tfqCudQqJWvCZYp7JARqgqmBzHSqv4fpzwPeZFeKgYV7yF5qusnnNZv3JNEO5KXJ4xTPnE8gRKI6/5Epj6qRu8KdfBe3U2xMmEHwwNpFpcNq/11nneXVPAc5jS04lBkTpRBpcBwVcKzkyMee8/9GRSWswq6lUXUalS41MJnwr4++jyjChQJG/VQ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnNzYUdxaVY5NTRsdG0vN0NvUnNPRUp2aUUwR3BHVHd1alRzQVhQOXdyYTd6?=
 =?utf-8?B?c1dad0x5dnB6cS9nZVFyVXhUbW1VSXRBOVJkVlBJcjkxVHRGRlZ5anV3VGVp?=
 =?utf-8?B?NWhidzR2NmxqcVRuMjlNMThrRitpVk9hS2xRWGptOGsyQk5wWlI4SlFEV1RZ?=
 =?utf-8?B?ZXdUbTRhS0lnbTZIdXd3REdNbzNCZ3lHZHUwZHdWRDEvSmhtVXRLWXJxY3Vk?=
 =?utf-8?B?bVIxWUVWWWl5dFd0TzVqUEh3bUlyT3FEL3VEWEdDQVM2Q0lMd0NWTDdHaHNO?=
 =?utf-8?B?ZnB2N1NvU0MwcHZtOXlEL0drTWJXc01QZUplRmlpeGpJRTRqYXdhS2pyRStD?=
 =?utf-8?B?MDFLMEFidE5QVTI4ZHdIb1kxa3dUanFsU1o5OEoxRVpzQ1pHa052RjljQVRF?=
 =?utf-8?B?VFM0RjQxc1FkWjgyU3R4TVhuUXFoaTRqN0R4MFA5Nno5M2dxeU9JWkkwWDY5?=
 =?utf-8?B?YTJlUlErbUlRdWw4cVhPV0pabjdmUm1QNjEzVmRRU3laWWdoNktLWS85SEFm?=
 =?utf-8?B?VHRQSEhVdXkvcDhIazN1TXZna0ErZFgyRjZsNlo0ZDlub2NuYjZHUGYyN204?=
 =?utf-8?B?bGo4ZTRPZ3NQN2FiT0xUc2NpS2djaEFBKzJJbnpqRGVReE1hRzkrNG41ZFA0?=
 =?utf-8?B?aWRDUHBtRVRzaWhxKzd4ZjFGbGl4Y0hiKzFjWUZDTDVvYWpBcFo2L1B5SkVO?=
 =?utf-8?B?QkNFTndacS9oR2ZoN3Y4NFRHUysvMUd0c3gxVGU1UGkyY2NleThoeHduTmxn?=
 =?utf-8?B?NWxMSzMyZVkrZE9OU2srTHJyc3ZYa3pBSGlJRTUzcjNuakhpbnpjT1FobTFw?=
 =?utf-8?B?T1doTVUxOWJ3VmhXT0hJSUpGY2VvMERiUHJRaHNFQmFBL3RDK1NackgzeElq?=
 =?utf-8?B?aDFlLzBXbmFiNEk2aTFqQ2ViUlpGZXEwYUV6UzRGTGRBVFNDUXFvZHVIeXBa?=
 =?utf-8?B?VzkzelNCQzlBN2VqMC9wMHdiMkNEQXJYazRta1JGSDZCY2IvOXVyZ1lnZ1I4?=
 =?utf-8?B?ZldZV2tRdkkvZTZnT250S2FWQmxSNStJK29xbGM4YXhLMWNReTVPK3JMYVZH?=
 =?utf-8?B?QW5MQzFYcVMxKzVrT0J0NnBQbGJPNVN0YnhvRUdrV2ZOcFR1TEdERVJ2V1Ew?=
 =?utf-8?B?cjNKUVVhRlU1VWtwL3J0N0lwem1Qd01ybEpEWnIxcmwrbEhZMC9Td1U0Lzhp?=
 =?utf-8?B?bXpuU2U5Sy9ndmhlbFRtZXN5Rnc5WjVrV1M3cUFrU0Y4blRTcncvSTRYVzdX?=
 =?utf-8?B?L0RQQWpZUWpFOTUzVUQvWlFCNHorQklEUlZEMDArTktlSUszMjlWZ250UURZ?=
 =?utf-8?B?VGZhNzZIeEhkRC9GZzByTUNIcU5MYWIxZVVVbURTQitmMWdzYmRsOGJ5aUpl?=
 =?utf-8?B?SDM4aXZKMnlTNVhzcjhQaW9neUJkZ25GZk1Gam9GK2pON3g3Zmt0R1ZCZWRk?=
 =?utf-8?B?WUhESVR0RS81U2NWWUc1SzQ1MVlBaEhXenBLYm1GSitoMzZaV0FYQXZWeEF0?=
 =?utf-8?B?alBlN2dYYlU5Y0VmekRXL3RidktLYWRxQVVpYmF4M2pFclZxcXBlZS9IbjIw?=
 =?utf-8?B?N2lSUWt0VUFqb3hGTDNmV3Z6N2hmWWkzYTNUWklGa0Y5QjlRRUxwb2lsZTJj?=
 =?utf-8?B?R2JTcm03eis1MjMra0s3U1VuY05teDJOLzJ2VTB0MXhTaGxhNnB5MFMrblNv?=
 =?utf-8?B?Zkx6K1YzNTRGQ09rMTlramFJNUZLc3VJc1VFczRVeEMxZjFhRDNEbXJhd25L?=
 =?utf-8?Q?6AynWu5FjqXPNn9iL4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29E895E4677BE84191FBAAB7B141AD8C@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d8feb2-a8f2-4626-b2dd-08db80543ec7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2023 08:12:32.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2368
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

RnJvbSBlMDAxODI5NDRmZWU2NzMwMWMzZWJhZGUzMTQ3YjI1ZDlmMTU1NWFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogZG9ubW9yIDxkb25tb3IzMDAwQGhvdG1haWwuY29tPg0KRGF0
ZTogU2F0LCA4IEp1bCAyMDIzIDEwOjQ1OjIxICswODAwDQpTdWJqZWN0OiBbUEFUQ0hdIGxvb25n
YXJjaDogRml4IGJyb2tlbiBDT05GSUdfQ01ETElORQ0KDQpUaGlzIHBhdGNoIHRlbmRzIHRvIGZp
eCBDT05GSUdfQ01ETElORSwgd2hpY2ggaXMgbm90IHdvcmtpbmcgd2l0aA0KQ09ORklHX0NNRExJ
TkVfRVhURU5EIG9yIENPTkZJR19DTURMSU5FX0JPT1RMT0FERVIuIFNvbWUgY29kZSBpcyBhYnNl
bnQNCmluDQphcmNoL2xvb25nYXJjaC9rZXJuZWwvc2V0dXAuYywgd2hpY2ggc2hvdWxkIGhhbmRs
ZSBidWlsdC1pbiBjb21tYW5kDQpsaW5lcw0KaW4gQ09ORklHX0NNRExJTkUuIFRoZSBhYnNlbmNl
IG9mIHN1Y2ggY29kZSBjYXVzZXMgQ09ORklHX0NNRExJTkUgbm90DQp3b3JraW5nIGlmIENPTkZJ
R19DTURMSU5FX0VYVEVORCBvciBDT05GSUdfQ01ETElORV9CT09UTE9BREVSIGlzIHNldCB0bw0K
WS4NCkNPTkZJR19DTURMSU5FX0ZPUkNFIGlzIG5vdCBhZmZlY3RlZC4NCg0KU2lnbmVkLW9mZi1i
eTogZG9ubW9yIDxkb25tb3IzMDAwQGhvdG1haWwuY29tPg0KLS0tDQogYXJjaC9sb29uZ2FyY2gv
a2VybmVsL3NldHVwLmMgfCAxNiArKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1
cC5jDQpiL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1cC5jDQppbmRleCA3OGEwMDM1OWJkZTMu
LmRjNmUwMWMzNDBiYiAxMDA2NDQNCi0tLSBhL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1cC5j
DQorKysgYi9hcmNoL2xvb25nYXJjaC9rZXJuZWwvc2V0dXAuYw0KQEAgLTMzNSw2ICszMzUsMjIg
QEAgc3RhdGljIHZvaWQgX19pbml0IGJvb3RjbWRsaW5lX2luaXQoY2hhcg0KKipjbWRsaW5lX3Ap
DQogCX0NCiAjZW5kaWYNCiANCisjaWZkZWYgQ09ORklHX0NNRExJTkUNCisJLyoNCisJICogSWYg
Q09ORklHX0NNRExJTkVfQk9PVExPQURFUiBpcyBlbmFibGVkIHRoZW4gd2UgdXNlIHRoZQ0KYnVp
bHQtaW4NCisJICogY29tbWFuZCBsaW5lIGlmIG5vIGNvbW1hbmQgbGluZSBnaXZlbiwgb3Igd2Ug
YXBwZW5kIGdpdmVuDQpjb21tYW5kDQorCSAqIGxpbmUgdG8gdGhlIGJ1aWx0LWluIG9uZSBpZiBD
T05GSUdfQ01ETElORV9FWFRFTkQgaXMNCmVuYWJsZWQuDQorCSAqLw0KKwlpZiAoSVNfRU5BQkxF
RChDT05GSUdfQ01ETElORV9FWFRFTkQpKSB7DQorCQlzdHJzY3B5KGJvb3RfY29tbWFuZF9saW5l
LCBDT05GSUdfQ01ETElORSwNCkNPTU1BTkRfTElORV9TSVpFKTsNCisJCXN0cmxjYXQoYm9vdF9j
b21tYW5kX2xpbmUsICIgIiwgQ09NTUFORF9MSU5FX1NJWkUpOw0KKwkJc3RybGNhdChib290X2Nv
bW1hbmRfbGluZSwgaW5pdF9jb21tYW5kX2xpbmUsDQpDT01NQU5EX0xJTkVfU0laRSk7DQorCX0N
CisNCisJaWYgKElTX0VOQUJMRUQoQ09ORklHX0NNRExJTkVfQk9PVExPQURFUikgJiYNCiFib290
X2NvbW1hbmRfbGluZVswXSkNCisJCXN0cnNjcHkoYm9vdF9jb21tYW5kX2xpbmUsIENPTkZJR19D
TURMSU5FLA0KQ09NTUFORF9MSU5FX1NJWkUpOw0KKyNlbmRpZg0KKw0KIG91dDoNCiAJKmNtZGxp
bmVfcCA9IGJvb3RfY29tbWFuZF9saW5lOw0KIH0NCg==
