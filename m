Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3664F814
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 08:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLQH0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 02:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiLQH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 02:26:51 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2086.outbound.protection.outlook.com [40.92.103.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B98E17;
        Fri, 16 Dec 2022 23:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfMSRWp23f3YmHYdekfMU21wW9WTXIkq7HLanWhj5o6ovgBJZEIzRrnXche44ZUYg4e3DK5oXr5MKOJn3hrdXXxzrvG82xqLrLZniDhKkKzB5mrV14hDgZGpT9FoOVFxs6meiduYi1TUZtZnNVrpw+KjkMSLmiU0/c80ankum7/kffXKnkU6pmDvx1dgwE+Ul1Y88vyW4OfWsJ12Md61tTZ5BUuG1AIvJtEcEYg3ZxwBB/Snr4ueIFMZlKEkGIOTlleKUt0iFpwOOkn6kqZcyyV4Fc31hXFJzYv4fiRq3RpVOeMsIc2Yo4aBsNXn9/PUlD4Z3Pg72biYyTAvAMfT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk3If8EM1PQyR4GLuYT5i2TprxcQAc76MEJqrGYRHl8=;
 b=LEl3y4tt2PGaGl9QFTAq67OuHaQ6DXtootYXgAhloEcPZ7JGp/Innn4Gxg7O7jRwqIqv7BadG+/ZNrXg9WdF8KkZP9DwcE3AQMXtq5CUD/CGgFQy4uSxwjNCfLE1/9wgs58Cj2DjmCkMjV0RXvNGvgboCuP3HnCtUrSi4wbpjYtILUHkxPHGRcRboIOffCyz9MKB6sReosegTn8au49ayw8ZM0XuGSDwpRyPyX8cI0fwloMaLjaE6YxE6nS2sJCXWuJ9YnJCQXkkjTdilYq0iGB0RfXtnkC73verWhPXhilRBnXD86ljjyVblHU88q4/0pWrOgOSfafIhocy8UQvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk3If8EM1PQyR4GLuYT5i2TprxcQAc76MEJqrGYRHl8=;
 b=fFAnIpR1ffgpMh56jfOkGpqxjuxd0N7Qx9L2gD4i66y+NG+T6Egnz61WTOHVFpMF65bwDHbCD5Op41XpLLYGkRRLymVA7mvKKmjWQc6MWtdD+HfisarJs+SsBaW0WYP4agegkjuu5IaJ/kkFYMsFltw6hL8BnXF5cfP+qQWT18QAzaUJJTAXENtAAqHgXb6NcJjWK/Z9gh8lhCryqR8mjXcJuBLYNR5OQLV+bYbTF6jyCY8o1cIPUukjLEAwTAMA2ZTdjLw/zpEAyApwmjrfZ1wFpVZ0bykQna+5P7s+S33TYpbQOEAWnDintAtTxjs0KvPhnFyya/YRq3UmWvXrOQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN0PR01MB5690.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:62::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Sat, 17 Dec 2022 07:26:42 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9758:2410:fd85:511a]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9758:2410:fd85:511a%7]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 07:26:42 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH] HID: Recognize sensors with application collections too.
Thread-Topic: [PATCH] HID: Recognize sensors with application collections too.
Thread-Index: AQHZEejpxeN0O9mCjEWaxsQGHt35aQ==
Date:   Sat, 17 Dec 2022 07:26:42 +0000
Message-ID: <8DA00FF4-DB08-4CEC-A5B4-47A71DC09C13@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NbbNw7J8Oljuf0+P9kWkQurrURltQfrd]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN0PR01MB5690:EE_
x-ms-office365-filtering-correlation-id: 234b38e8-b765-4a31-7354-08dae0000b92
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TMkiTrAxrWpI/5xyy8BIPDwGjorHtInvLDhFlnd+/aAdev0/PcAITFBsaRByYwSzzBLlscql3FfW+gbKzyDklCQYzoOuceAQpKGPyEWixQ5WsyEdP/FBNYDGsVg0GanbkiirpHZQ9VigZC9jTwa6TLOrCNEe0W/irj+EtLSbCCaGw0dWsW1CiPp45sXFEqZp+OxogC8K0ZK28z0j1jGiIUGWnwySlyct0IKindVFrPouHDnF5AAn0JjFYewLq7dnQRIx4gjKwKZqxyr9YD7QfKuYbM4RYRDVitfvsJk/eV4qyZXSC53NfLnUTyzAPL3sWIRR69JpSlzU7lfgVQrSjjj1iPV9hOjjHtGUk5BlEGExUAXSNiYJh65kGiu11eRp375vDKu22OnWgRlMmyi3WWtaktnxFO6/yNdfw3ZChHeUGq4juVTdI6vV270CrSqyS4EVfap/GEj9/hL8ZBJOq1ehawAALRPIcLsGpQPJioi5ZwKObRQ4HJyU+ZUgzX4ulsU8qgFNW/IlihDZW/O9x0rTHj7jLIjE6xJYs7I2b9WIorjdDWlRPbAAWpBonEGsU8YwnFrgLI61MfJ6lFtDcnK76RhTfEsAtxqbbZAxxd0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0tPRWRyWUJ4a2lqY3ZabTRoWVo2czZ6M1BsZjhGYU1McnRSSVRQVzBjQUNH?=
 =?utf-8?B?V2lvL3hwZEJSMzh1RU1Jd3FjdUFWRE5FV0tPQ0hyOHN2Qm9GeGNZc3RoTUVy?=
 =?utf-8?B?aTZWa1oyTjlGTlZOWGdMdmZ2Z08xYkVkOXg1d1FyTUhLTWNuVUhCNHpSU0JU?=
 =?utf-8?B?aDNPamNyZFJISEt1V0RXOWIrSW16dzhISzFjUVBJcTh3TThuSHA4N1lQWUhU?=
 =?utf-8?B?ZUpJNUV4SlZJa3dGNURtOGI1RERreE9DS1hXczRTeDFxVzlFQStIYjJHRWdN?=
 =?utf-8?B?Y3p1QnN5dTRHSmtjMzNxWnZoQURWbk9Ud3JqNS80ckNOU2FpVFBFQm5QcStE?=
 =?utf-8?B?ek0yT0hvM1c5WmxiUmNHbWRmRFlSZjNnNHE3d3FtL1NuUU0xckxYSG9SK1po?=
 =?utf-8?B?ZTFQcGNqaGFMSmVqK013Z3M4RDhwZ1Y2UHZhTXpQam5EZWUyN0pvLy9YaUh3?=
 =?utf-8?B?eTFYVDhYMVJuWWpmZ3M4Nkx6WDdSL3ZqQUd5OEluby9IdisxYlpVSlAzWGw4?=
 =?utf-8?B?T3hNSWJIQlRtV2lFSXFiMGwvRkFmc1hGdURIaUF0ZEVlTE5CZmtQaERzbzF3?=
 =?utf-8?B?Q1gweFRrREd6SGQ4dTMyMGFXRXNod2xnT2x0VUVnNmdTWGZoRWdKa3lwUFpr?=
 =?utf-8?B?Y081cno0SitZS2ZLVEdPSk1aaGJRUEE0TW5melJDZmtHZHhTbEx4KzdSckZl?=
 =?utf-8?B?bFp6L1lwN3oxSHVLeE1PTUdZL1d4UGN4KzlWaWthZklIYlhsVFJBQmdDeGQ4?=
 =?utf-8?B?SThRb0hyRDJMVTV2aEw5a0pUSVFFRVNaSWQwMEFnMkpKdURKbU1ZeFRKcDRy?=
 =?utf-8?B?SW9ObmRIcldaSmZBSlM5M3JpK1lxTjNDM2MzTmVCeERlNWZmUVVSazQ0bElj?=
 =?utf-8?B?a3k5VWVnZnVYTGVtbGd1bm51azM0L3NSVEF5aXlpMXkwUlVvWXRmVGtac0R3?=
 =?utf-8?B?S3hjY05kOW5aMjM4N0hEajBOOXp3Z3RQdWg2cCsrbHZuSkZPK2hSNTBKT3Fn?=
 =?utf-8?B?M1hBWjFqWDlaNHhNcUhaRGQ4cmtLZTk1N0tGVDhDNkQ2U20vNlpuZWd4bWNZ?=
 =?utf-8?B?NWFoRGNjeUpyVUFOb0JVTjd3NjMydjBUMGdLSXd6Q0JtN0xxMVp3MkNZb1JB?=
 =?utf-8?B?dEJxcDdsaWhGMXZIaXdkQ25Rdjc4UWo5N1FYNXluRnMxUEExRys0TXh0UnNH?=
 =?utf-8?B?bmZmZkdpeVR4MHVsRWZYNkpMbEs1L2I1TXh0SU93QWhWVmxOUVNWRzN0UWxu?=
 =?utf-8?B?c3lZeTQ0T0FNdUI3VUFxS1pXNDdrQWxlM3Zla3lFQmpIVkRRTFZaYStKemc0?=
 =?utf-8?B?d0Q4d0kzNzZEKzUvaUx2VWM5Ykd5QXA0Wlc0YU9qNHhKUTFEUUFyakdlY2lj?=
 =?utf-8?B?MHc0SVFMU2l0bmNBUkdFV29NdmxINVRMVjQ5WVlleE1HYVVpdXpydmNYYnRk?=
 =?utf-8?B?RW15MjFXdE80S001UWpreVBNRFVpdXhBVE1Na0gwTUFQSExadlJ4UlhPd21j?=
 =?utf-8?B?WXArQ0tkTGhTcUt0bHRJNW9COThPMHVOMW1TcnRUSFlDaEhFb2FrVUxKanBS?=
 =?utf-8?B?RnNnLzFmL0ZER0NNNUp2Sk5ub0tNK2tsT0c0T2Nnc0lxK2Q3NGxFd2V3N3Jx?=
 =?utf-8?B?amlEQ0dWV28rWm56N3JsdGo0U1hzb1NhUWRPT3BNQ25tSzdCSVBJRjV1TTZX?=
 =?utf-8?B?MTNYSzFvbWY5RHlVRy9QY1Y3UVF4RS9jSFRrTlV6dlRNbndnNnV6Z3hRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFF2E37B147EC346BBBE17AEEDF6D8F8@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 234b38e8-b765-4a31-7354-08dae0000b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 07:26:42.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUm9uYWxkIFRzY2hhbMOkciA8cm9uYWxkQGlubm92YXRpb24uY2g+DQoNCkFjY29yZGlu
ZyB0byBIVVRSUjM5IGxvZ2ljYWwgc2Vuc29yIGRldmljZXMgbWF5IGJlIG5lc3RlZCBpbnNpZGUN
CnBoeXNpY2FsIGNvbGxlY3Rpb25zIG9yIG1heSBiZSBzcGVjaWZpZWQgaW4gbXVsdGlwbGUgdG9w
LWxldmVsDQphcHBsaWNhdGlvbiBjb2xsZWN0aW9ucyAoc2VlIHBhZ2UgNTksIHN0cmF0ZWdpZXMg
MSBhbmQgMikuIEhvd2V2ZXIsDQp0aGUgY3VycmVudCBjb2RlIHdhcyBvbmx5IHJlY29nbml6aW5n
IHRob3NlIHdpdGggcGh5c2ljYWwgY29sbGVjdGlvbnMuDQoNClRoaXMgaXNzdWUgdHVybmVkIHVw
IGluIHJlY2VudCBNYWNCb29rIFBybydzIHdoaWNoIGRlZmluZSB0aGUgQUxTIGluDQphIHRvcC1s
ZXZlbCBhcHBsaWNhdGlvbiBjb2xsZWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb25hbGQgVHNj
aGFsw6RyIDxyb25hbGRAaW5ub3ZhdGlvbi5jaD4NClNpZ25lZC1vZmYtYnk6IEFkaXR5YSBHYXJn
IDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+DQotLS0NCiBkcml2ZXJzL2hpZC9oaWQtY29yZS5jICAg
ICAgIHwgMyArKy0NCiBkcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jIHwgNiArKysrLS0NCiAy
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1jb3JlLmMgYi9kcml2ZXJzL2hpZC9oaWQtY29yZS5jDQpp
bmRleCBiN2Y1NTY2ZTMzOGQuLjhmY2Q2NjNiMTBlMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaGlk
L2hpZC1jb3JlLmMNCisrKyBiL2RyaXZlcnMvaGlkL2hpZC1jb3JlLmMNCkBAIC04MDQsNyArODA0
LDggQEAgc3RhdGljIHZvaWQgaGlkX3NjYW5fY29sbGVjdGlvbihzdHJ1Y3QgaGlkX3BhcnNlciAq
cGFyc2VyLCB1bnNpZ25lZCB0eXBlKQ0KIAlpbnQgaTsNCiANCiAJaWYgKCgocGFyc2VyLT5nbG9i
YWwudXNhZ2VfcGFnZSA8PCAxNikgPT0gSElEX1VQX1NFTlNPUikgJiYNCi0JICAgIHR5cGUgPT0g
SElEX0NPTExFQ1RJT05fUEhZU0lDQUwpDQorCSAgICAodHlwZSA9PSBISURfQ09MTEVDVElPTl9Q
SFlTSUNBTCB8fA0KKwkgICAgIHR5cGUgPT0gSElEX0NPTExFQ1RJT05fQVBQTElDQVRJT04pKQ0K
IAkJaGlkLT5ncm91cCA9IEhJRF9HUk9VUF9TRU5TT1JfSFVCOw0KIA0KIAlpZiAoaGlkLT52ZW5k
b3IgPT0gVVNCX1ZFTkRPUl9JRF9NSUNST1NPRlQgJiYNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2hp
ZC9oaWQtc2Vuc29yLWh1Yi5jIGIvZHJpdmVycy9oaWQvaGlkLXNlbnNvci1odWIuYw0KaW5kZXgg
NmFiZDNlMmE5MDk0Li5kMDNkYzRjYTA5NWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2hpZC9oaWQt
c2Vuc29yLWh1Yi5jDQorKysgYi9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jDQpAQCAtMzk3
LDcgKzM5Nyw4IEBAIGludCBzZW5zb3JfaHViX2lucHV0X2dldF9hdHRyaWJ1dGVfaW5mbyhzdHJ1
Y3QgaGlkX3NlbnNvcl9odWJfZGV2aWNlICpoc2RldiwNCiAJCWZvciAoaSA9IDA7IGkgPCByZXBv
cnQtPm1heGZpZWxkOyArK2kpIHsNCiAJCQlmaWVsZCA9IHJlcG9ydC0+ZmllbGRbaV07DQogCQkJ
aWYgKGZpZWxkLT5tYXh1c2FnZSkgew0KLQkJCQlpZiAoZmllbGQtPnBoeXNpY2FsID09IHVzYWdl
X2lkICYmDQorCQkJCWlmICgoZmllbGQtPnBoeXNpY2FsID09IHVzYWdlX2lkIHx8DQorCQkJCSAg
ICAgZmllbGQtPmFwcGxpY2F0aW9uID09IHVzYWdlX2lkKSAmJg0KIAkJCQkJKGZpZWxkLT5sb2dp
Y2FsID09IGF0dHJfdXNhZ2VfaWQgfHwNCiAJCQkJCWZpZWxkLT51c2FnZVswXS5oaWQgPT0NCiAJ
CQkJCQkJYXR0cl91c2FnZV9pZCkgJiYNCkBAIC01MDYsNyArNTA3LDggQEAgc3RhdGljIGludCBz
ZW5zb3JfaHViX3Jhd19ldmVudChzdHJ1Y3QgaGlkX2RldmljZSAqaGRldiwNCiAJCQkJCWNvbGxl
Y3Rpb24tPnVzYWdlKTsNCiANCiAJCWNhbGxiYWNrID0gc2Vuc29yX2h1Yl9nZXRfY2FsbGJhY2so
aGRldiwNCi0JCQkJcmVwb3J0LT5maWVsZFtpXS0+cGh5c2ljYWwsDQorCQkJCXJlcG9ydC0+Zmll
bGRbaV0tPnBoeXNpY2FsID86DQorCQkJCQlyZXBvcnQtPmZpZWxkW2ldLT5hcHBsaWNhdGlvbiwN
CiAJCQkJcmVwb3J0LT5maWVsZFtpXS0+dXNhZ2VbMF0uY29sbGVjdGlvbl9pbmRleCwNCiAJCQkJ
JmhzZGV2LCAmcHJpdik7DQogCQlpZiAoIWNhbGxiYWNrKSB7DQotLSANCjIuMzguMQ0KDQo=
