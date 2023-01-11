Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D236C6658A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAKKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjAKKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:11:00 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2098.outbound.protection.outlook.com [40.92.103.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E52A11C0E;
        Wed, 11 Jan 2023 02:07:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVLyCJYnen+Z54lN8R/UqW87j8LBbcHiJYI0WV7ZdW+Lfm/YkrEACFRJKyrlHlOtyfQL+GY4GymloOoHfFAG8dAF6lX83upos61dHThIvKcRXTRV/0pj6emYOtquWD3w03TsP18ceyQ5F7QMYv6a2FkfokqctqA8eJzWOyy1eoCO10DTklgUc+WXrUevToh5rhpkn6HTdDqOpQ6LVNrePE61rna6pIyczUhgxcdtJoX/C7eSBPVzqdYlsiFFEyx7BH4oCJEZTQJdSiTAzc4jf8ck5Xmba2H9CmzCJShopBGpuvSxDm9lCceQDwHPmnZra+eCKJ3V9MY8eLFALsiPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPdutyTNJACletQHQTP1yBHh8lFOxwvU7rdYfe+bHj4=;
 b=W5JKAXettTd76Hb+vGkMJoQYQxzree7OfTJVrszs8vEvWadfvAr54o9TDAn54jWw5aGZgwHyGxZ6cqEauts1R7xfu/KnAwuNhpeGKEg1JoxpuG0DgTPfaxLqEOOUwQT9xoi3K+95AxH7QAJPjL4dMQMtoAIIDErX4nKDyqOR/9zTfuqFzMk3zZtSrs9At3GyPDggFYaHF+uni7LH86ITNQGcyXbB4Y8MnASFCLFxltz5+bjy+dBxV+PIYjW8GoyXMNHWLd6c7PSZSdNwy64+UNsRJJ1hyg3WmfLlsglsI6F4/rDD8n3n2595tWvMFH/QGrE1+G6TjCRbd90yjOOCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPdutyTNJACletQHQTP1yBHh8lFOxwvU7rdYfe+bHj4=;
 b=WuWiG+ATfmYRF3az4CUIOlSMwhJxcZY1uj0o3dfpEr9cJSGY6Dl3Ly5kMKaZn1mQ2Umo52ADQXXwjsxbKqc0meDTSxVUVaD98X+1cVA5fweT0Ve38g3NTv35opFecgIxqHcT+Mj4e41zUjjwWOxpvd1HBa7kPgbhWGTpqu75hAb4+az8+xA4LiY8v9lnu6xJucADxMCt7HoXXaJ9p6FMWTWrqd8hSJ9CmTWaole0vfQe7v1ItnZ27fAKrLhK4dDK+Lat9GZPzaUGLMJUSpm8YJTg0LI2pW07fJMEUWObcakZyiTpwV27uwIIL/LRxo3sTBYZF+VJFcvutQ3miDN5dw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB6359.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Wed, 11 Jan 2023 10:07:36 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a%6]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 10:07:36 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "orlandoch.dev@gmail.com" <orlandoch.dev@gmail.com>,
        "ronald@innovation.ch" <ronald@innovation.ch>
Subject: [PATCH v3] HID: Recognize sensors with application collections
Thread-Topic: [PATCH v3] HID: Recognize sensors with application collections
Thread-Index: AQHZJaSHSs9iTHSJpkmT7tm87pMIXg==
Date:   Wed, 11 Jan 2023 10:07:36 +0000
Message-ID: <9E66CF6F-99A0-4CC5-9FA0-3A9DCFCA0388@live.com>
References: <8DA00FF4-DB08-4CEC-A5B4-47A71DC09C13@live.com>
 <01D620E2-18CA-40F6-A330-454CBC20C542@live.com>
 <EFCEA45A-C6F4-477A-B011-9C9E6E61E488@live.com>
In-Reply-To: <EFCEA45A-C6F4-477A-B011-9C9E6E61E488@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [HX2B4FhKqfK1L+oHwPfYMEzPp3oXMZa7yZ81HyH2FRYXHEuJgRJ831Zv2510oATV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB6359:EE_
x-ms-office365-filtering-correlation-id: ea75e6fe-dd48-4bf4-ba40-08daf3bbaa45
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02yrKjJugzjWQ3GD8Gxm5w6TovvBQnKpe7rQ19obTRjzhTUVaphCF0Qoli4I4BhJpWRDn6S1l0CdeXUQgTfmaX5ysayxEM6aWkTiXelRjDmHkhhpt6TAP7hHBm4UxhpWajNAM5wAslq2SDevTScEWb+vKPwALoiwvsjrxjbLK4/WOySnmWxwYLfuyABkr6WpGq5sf6wCv5aShgnDM2CvzIRCXV8Ji6OUQUp9flpul1eYZmReKcPmpoyCJOPbs5Qe6KzvEn4mszQ8tEiBORSOQdX/taymqEHQrDxdOmbaqm4JNlq0HRb9cCsmURFwLP0v+jTeU/orTENY5VDWDc0lYyuvbM+PKoCgDHeE6XLx68QXjIYW/ADD7Qd9MWd2jtSjVnNcGyVkIZTad/JQ237ovhwZWS/VjvIwifdRHKx487c9xy8TkVzC52vq61OmHN1htrbyi+pqHSLUDhyW7cChOVRHLh3NQ6mCflXYS1D01fIbgWTqNq6j0CqKUD9WUi7QAUad0Z0SQk+BCf2XMxFxo7ioeHEaXQJMQehE0wzQmcKO5ek+vhOI+d7JIEDeqH0fID2k6wp5spkr2ymoy1djg3nZ1C45fx5t2mCDuNecJ6U=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MThnU0xpR1N0T2NBdy84OXdaRnBaYkoxVjJxVisxUWRUUkNzR1Y1ampOeHNp?=
 =?utf-8?B?UEJZNllpZkhhays2ZU9idDdIYm9nTW90ZTR2M2NvYXdlOEs4WjZGcXNHTU9n?=
 =?utf-8?B?Mkg0OHFOQmp4ZVlBdzV2OWZEMHplUjlmdE1RZmcvUDQrZFBXcWd5RWZPem1x?=
 =?utf-8?B?S0lsZVFTSTk4VzY5alVJU2dQV1lBcS9VRER3TDdvOGNSZDdOWVBncjZVQXVz?=
 =?utf-8?B?SnhkWENQWkNpOERnLzVzSVV5aTZQNVFXdUJOOXRWaXV3M04xcnB5Vng5ZThX?=
 =?utf-8?B?TUN0R3o4eDQrSmhaSnI1OFFaK2M0NWM0SnRpdTh0WjRUOXROMCtnd1ZzQnRx?=
 =?utf-8?B?WDZ0MkFkNHZYZ09TYk54eUU2U1F6d1FyY0wyUjAzTmt2UVpLNUtqYlpha0s4?=
 =?utf-8?B?NFowNXNjL2JucGVhOXhMK0djZE9CT2VmNCs1R1NLTHlBWUc3YWVwZWRZalkr?=
 =?utf-8?B?VHQ5aDlnMUNka09yTFNvbHhhVnI4RlcxYytPMzBpcEtlMTZ3WFVEZEQyVnVK?=
 =?utf-8?B?c3gzTG5LRHNIQm9jNCt0QmVTUjJEeHo0ZmwwZEFLSzJocVNlVUJMOElYQjdK?=
 =?utf-8?B?VXJXeU9acUJtc1U5U0I2U1Zna2NWNDVnbGV4Sm1ORVpCU2M1bGFSd1BBRHRu?=
 =?utf-8?B?STlNck42SUZzVTZMT3V0OS8va0RsNnRvQ2t6NHJIQjl1NEt4WUIxeWRQR045?=
 =?utf-8?B?MXYvdEN5VFArc2NNRlhvRXBNVi85SnZUU2JQMHNEazdpODVQanBNemRWTCt5?=
 =?utf-8?B?THl5aWg0OTZpVVhUZkRqdTdpeHZneW1HcWk2N3lObFAxNkpiTFVkT21Hc3lr?=
 =?utf-8?B?VmRiS2QxWTlSeE4yZDg2QmJHVEdnNXJIS2ZYSVF4eVMwZXcvRGQ0MmZlSkVq?=
 =?utf-8?B?QzhzVVZzcGhZaVJWZStTcDl3RzlJNHd2QmpDbC8yK25GeC9PVU5RM1ZOd3N4?=
 =?utf-8?B?ckxsRDExNFNZc0Zsb2NLeWh0S1cwZ05MZXdNN1ZOZVpxMGZHYlNrYWtmdkVs?=
 =?utf-8?B?TkRsMDNPVUluL2VRNmdzdUUwK0pGWkhCZkNERzBDNXk0RTdVYWU2L0p5akVN?=
 =?utf-8?B?VlM4c0FBdTRGU013eDJUZUZzaHN5bW1GNmtuczJHNWFFZWhnejR2Rlp1SmxD?=
 =?utf-8?B?UERhUWFzbVRBVHhqYjhrUE9JMTJ0eUdFdkNCc0YyKy82RkRvR3gzT0svNTl3?=
 =?utf-8?B?MDYybGxuRk5XYnd2UUhzOUFwNXpqYUF3aG9IdkczcmpvWXE5bHJkMlJpRnpT?=
 =?utf-8?B?MFVrUUt5eE1BbmdxWnd1QUZoSUNQMjY4TTRDdG40Y1piQ2NvUGRpbDg3OGoz?=
 =?utf-8?B?anM0WXE0NUVvdDZRbSt2bWFkR3l5SHo1Wnc3ZmtHOTdzdG0rVkpwZ1RORUNH?=
 =?utf-8?B?a2lkT3BKNkhhNUdUdkkyWEIrcHI0SmpoR1hvMnFraVYzOUdROWlFeG92bjNB?=
 =?utf-8?B?YTE1Y25KWlZndDY4UVJWdTJISStZTWdnTnhLTk5aUTdMS08vdjNpUVZ1TUJL?=
 =?utf-8?B?V3ViY001bnlPalhTOGZ5T3FtaXAvSkpPMlBtbjlPdjZGTXhvbXRseEFkRjNO?=
 =?utf-8?B?RFFQOVNKRlBrQXFZbHpxdTJsYzQycmNLcWt4VDdvL0pNV2tmVFNYMnZ2WXl3?=
 =?utf-8?B?QXM5ck1lUDd5TGpkbzZsYk5oeDZ0WW1aRnNBTlh3YjJzbGR4clZUeUI0cXls?=
 =?utf-8?B?TGN4UHRxUjAxUldjb1Z6MXFWUWhLcU1Ba3F1RnVNdXNoL084NUVIelZPMjEx?=
 =?utf-8?B?ZUE4eU92amFVcmFoTzNGUXJEb2hlM3Z3SzFTWTVQVENJRmRsaXRNYmNmbUNs?=
 =?utf-8?B?VW1hL2k2UWN3azZsZVkydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <181F55D8A09EE44D978B411E2F196849@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ea75e6fe-dd48-4bf4-ba40-08daf3bbaa45
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 10:07:36.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6359
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
IGluIHRoZSBUMiBNYWNCb29rIFByb3Mgd2hpY2ggZGVmaW5lIHRoZSBBTFMgaW4NCmEgdG9wLWxl
dmVsIGFwcGxpY2F0aW9uIGNvbGxlY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6IFJvbmFsZCBUc2No
YWzDpHIgPHJvbmFsZEBpbm5vdmF0aW9uLmNoPg0KU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcg
PGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4NCi0tLQ0KVjIgOi0gQWRkIG1pc3Npbmcgc2lnbmVkLW9m
Zi1ieQ0KVjMgOi0gQXZvaWQgdXNpbmcgbGFuZ3VhZ2UgZXh0ZW5zaW9ucw0KIGRyaXZlcnMvaGlk
L2hpZC1jb3JlLmMgICAgICAgfCAzICsrLQ0KIGRyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMg
fCA2ICsrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWNvcmUuYyBiL2RyaXZlcnMvaGlk
L2hpZC1jb3JlLmMNCmluZGV4IGJkNDc2MjhkYS4uOGZmMDhlNmMyIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9oaWQvaGlkLWNvcmUuYw0KKysrIGIvZHJpdmVycy9oaWQvaGlkLWNvcmUuYw0KQEAgLTgw
NCw3ICs4MDQsOCBAQCBzdGF0aWMgdm9pZCBoaWRfc2Nhbl9jb2xsZWN0aW9uKHN0cnVjdCBoaWRf
cGFyc2VyICpwYXJzZXIsIHVuc2lnbmVkIHR5cGUpDQogCWludCBpOw0KIA0KIAlpZiAoKChwYXJz
ZXItPmdsb2JhbC51c2FnZV9wYWdlIDw8IDE2KSA9PSBISURfVVBfU0VOU09SKSAmJg0KLQkgICAg
dHlwZSA9PSBISURfQ09MTEVDVElPTl9QSFlTSUNBTCkNCisJICAgICh0eXBlID09IEhJRF9DT0xM
RUNUSU9OX1BIWVNJQ0FMIHx8DQorCSAgICAgdHlwZSA9PSBISURfQ09MTEVDVElPTl9BUFBMSUNB
VElPTikpDQogCQloaWQtPmdyb3VwID0gSElEX0dST1VQX1NFTlNPUl9IVUI7DQogDQogCWlmICho
aWQtPnZlbmRvciA9PSBVU0JfVkVORE9SX0lEX01JQ1JPU09GVCAmJg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMgYi9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5j
DQppbmRleCA2YWJkM2UyYTkuLjgzMjM3Yjg2YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaGlkL2hp
ZC1zZW5zb3ItaHViLmMNCisrKyBiL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMNCkBAIC0z
OTcsNyArMzk3LDggQEAgaW50IHNlbnNvcl9odWJfaW5wdXRfZ2V0X2F0dHJpYnV0ZV9pbmZvKHN0
cnVjdCBoaWRfc2Vuc29yX2h1Yl9kZXZpY2UgKmhzZGV2LA0KIAkJZm9yIChpID0gMDsgaSA8IHJl
cG9ydC0+bWF4ZmllbGQ7ICsraSkgew0KIAkJCWZpZWxkID0gcmVwb3J0LT5maWVsZFtpXTsNCiAJ
CQlpZiAoZmllbGQtPm1heHVzYWdlKSB7DQotCQkJCWlmIChmaWVsZC0+cGh5c2ljYWwgPT0gdXNh
Z2VfaWQgJiYNCisJCQkJaWYgKChmaWVsZC0+cGh5c2ljYWwgPT0gdXNhZ2VfaWQgfHwNCisJCQkJ
ICAgICBmaWVsZC0+YXBwbGljYXRpb24gPT0gdXNhZ2VfaWQpICYmDQogCQkJCQkoZmllbGQtPmxv
Z2ljYWwgPT0gYXR0cl91c2FnZV9pZCB8fA0KIAkJCQkJZmllbGQtPnVzYWdlWzBdLmhpZCA9PQ0K
IAkJCQkJCQlhdHRyX3VzYWdlX2lkKSAmJg0KQEAgLTUwNiw3ICs1MDcsOCBAQCBzdGF0aWMgaW50
IHNlbnNvcl9odWJfcmF3X2V2ZW50KHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LA0KIAkJCQkJY29s
bGVjdGlvbi0+dXNhZ2UpOw0KIA0KIAkJY2FsbGJhY2sgPSBzZW5zb3JfaHViX2dldF9jYWxsYmFj
ayhoZGV2LA0KLQkJCQlyZXBvcnQtPmZpZWxkW2ldLT5waHlzaWNhbCwNCisJCQkJcmVwb3J0LT5m
aWVsZFtpXS0+cGh5c2ljYWwgPyByZXBvcnQtPmZpZWxkW2ldLT5waHlzaWNhbCA6DQorCQkJCQkJ
CSAgICAgcmVwb3J0LT5maWVsZFtpXS0+YXBwbGljYXRpb24sDQogCQkJCXJlcG9ydC0+ZmllbGRb
aV0tPnVzYWdlWzBdLmNvbGxlY3Rpb25faW5kZXgsDQogCQkJCSZoc2RldiwgJnByaXYpOw0KIAkJ
aWYgKCFjYWxsYmFjaykgew0KLS0gDQoyLjM0LjENCg0K
