Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AD4663C06
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbjAJJAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbjAJI6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:58:50 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2023.outbound.protection.outlook.com [40.92.103.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9244E77AC4;
        Tue, 10 Jan 2023 00:55:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pstq+EfPdCBsc8k+hxKksvp9CosqKGVnKuYZVXgrMU1pg+owQVXyYGgzMLEOg1emLGS1vJOQUEwi/eA6ynlekFOY/dtOtQbbkOlF83O9D08g7PHEKLWg4oLL4Cp406yimtISyfEK0Pfl1WTehpr23EsX8IIMdj8neQdshIDG60fZity9KGW1Rx2mrm+oBVJ/3I63PZRwI66WfMAYOnwmXv3VffDwH92tLrYOoIsi5rqAAqCHhTAjZaI5wD6BWE5nnw+GIL+CQCr52Kv1jbOgZ4uXo14OmZlD48a6ApZnmWhOLzBirNhdBsGix8Lh7rvG4VSCRdE4rSCceMX0afWtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OHsp8+dUn3iWBtan4/qA4fKHgByblGmY6nrAFCMBL8=;
 b=kXyRq0kCjRegrZzcF5SrklEiTtvS45gon7cx5dLkxAFFNIJy8yDBJTq8eisK2UYHl2i6D0+8tTY9UljRpIojuJBDq8ZDpV+uDPWG9C3YAZWHdkFd0OWwbQvcPAlWnM60wx+WVQ0KXV2CywuaxTFRVqJ0/F7VfcNmWpTn1D6MjXZ6Cw2kiWTpb7xecKbtE0WOUHAaHMyznfd2FvCzhSRj87KVUiu9V79PK6RKszSlF4wTV4rSM1pQCuTiZSeqe/5iuu3MS7V9EciVw28gvWPkqVOvuHSIPOVKv5rrb1snK9mJ2f4Ban6FZ5EsgHNF0JNDPAXmOiRjbV1xqJxlWlRV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OHsp8+dUn3iWBtan4/qA4fKHgByblGmY6nrAFCMBL8=;
 b=q8He3W9uKQMVCFrdhTJfroBHHaoAA/cC2q07QPQNERiHPFptb1axu95A8Flknk4i1WF2gZTajqlM586FkCilrs+v0iIqjQ2UAlr36RF3tMocMMhPC29ybT9Ia7eb9a2fOCkfLHCevj8wsdOglOMqGQuDKH1A4wUITvraSPaLU3U9OsVMfBTv8hx518lo3OIYE/ZlQ0SCXBJI+aJbzrcXxuJK9q1UVoD7MATg7OUfRMn1r20cOEiqNkPbT7zPGMFeLS5z1Mx87iRbdMpObSDKS8u81HwoECcQwymfgmWVqa0Xq0JedhJIvxpiNpP6HqHM+CrZuZ2UQkZhVkoWNs8W4Q==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN0PR01MB7672.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11; Tue, 10 Jan 2023 08:55:00 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a%6]) with mapi id 15.20.6002.010; Tue, 10 Jan 2023
 08:55:00 +0000
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
Subject: [PATCH RESEND] HID: Recognize sensors with application collections
 too.
Thread-Topic: [PATCH RESEND] HID: Recognize sensors with application
 collections too.
Thread-Index: AQHZJNE4jRay16Fg0UGqrwt+OFsMig==
Date:   Tue, 10 Jan 2023 08:55:00 +0000
Message-ID: <01D620E2-18CA-40F6-A330-454CBC20C542@live.com>
References: <8DA00FF4-DB08-4CEC-A5B4-47A71DC09C13@live.com>
In-Reply-To: <8DA00FF4-DB08-4CEC-A5B4-47A71DC09C13@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qgF/Qaro3TCCID9lJqATRFf586hRQBbVUuCI0tKoeQk8cI3rrba7gQLCP9euHN2d]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN0PR01MB7672:EE_
x-ms-office365-filtering-correlation-id: c9432737-6bf7-466e-3898-08daf2e85b54
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BPjj6eKQVBqnVDG8WLKVn6c/GtrSoTXzjYDHFHtHOF2agGKFsiMK0gyUQuZ1ZyvnSQUbsjQp5DhWPSbGGp+7nrC2SjwRw01kfMww+nEo4bw+e9zzYWNUhBlztq+8iQbOqBoew36P63qnCcW+F2gcsueIIQAPlPGNWTAw96KT9PvWErB8xwkuq2xFDdovKEetSaprSYKD/5faP68iz8krWHNQqCh6C56wsJMTpuvpRgK3ji9/2ASBoYJK1DUqn4TnDNVHrGkT8IejGX5CqvC5OAjDvyYraWuKF02fMa54bsRG0qSWm6/BhWQ+MGghD8BMZnk3nbq8bC3j1CfWi24t5X/feSGcPLpfYvxlFwTI1VAmxaF9rhLjIoTAuE+Au6jf38SLNUUAEiFUSxoPkAs1w1G75EB3ptFS2XCs1MfN2haMRfsgnQePRy7e3CYOpIES7RUwgB1TgM7Ypbu37K5JmCmDFuPlzSieyUUfXTelxcOr8UN1k62/588NLB0hthW61LZXRCwrAb83AngR8gzABVtqNB1G7624wwVQr4gpg4B0o/l51g0CfGRRQGqn+9Q+3DvJe9Pqtugqp3LLmpsnzNPYvS+oPII73cU6WHKu8o=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1BEcXJYZERNOVVteEhLeWp1OEM3RUIwQUZGd0N5U1VzbG5sdHFNbHZGV2F2?=
 =?utf-8?B?UzNIeGlDcVVUb3ZOVGs1WFUxc1FPMEt1T0h0SldUVEw2WDBVQ0ZZQi9FMGdI?=
 =?utf-8?B?ejlTOFlLUnlFV3ZoQlFpVjV6SHJnVHF6UHFJd3A3Tm4wQS9SbHc0bEh6dlZz?=
 =?utf-8?B?NTJZeGkrVnVHT3FpaXl6NStrNFMrUEdibEhYUmt1UjZ3Q2JPLzNGcnFXbm9k?=
 =?utf-8?B?NG1YYnArQUF2dmRjUHdUVUovQkRCd1BEaXlEQ0lsNWhNTHk5QkIrLzB1Qldw?=
 =?utf-8?B?Rm1sa21CYUlnQ0x3T0F1MGZqc3RNSEtPZFQvLzRhZjNaSzFnNmF6M1BaOWVo?=
 =?utf-8?B?dGs4N2RKbGJHVWZJMWRyaThLSmVnSXZJZmp2QTNuVlN5Um9sQVFGdWc0SFE2?=
 =?utf-8?B?bWJGZGxlQ1V4T0lGeGFQaTVmYkVDL1BVSVdGTlRtQlZ5MGROZlhEZmNuaTlm?=
 =?utf-8?B?UVlsbFJ0NHRPUFUwRklSN1hBcDFlWklUTUtkcmFMNjM0cFNNNmxEemRGUmRu?=
 =?utf-8?B?WVZrcmtlZVBaSUh1aU02KzdVc3RXdk1XNkpsdkRGREFKY05jeUlzUVRvRWNm?=
 =?utf-8?B?cEdLWkl1bnA3dmFQcnhJUHBWek1EdVNtQXZXQWU5MlJ2bElGeGhCM0VPaHhD?=
 =?utf-8?B?dGQrU2FlYjd5TW1jR0syU1hhRUQva3VwaUdkcG1Ic0VwQzlUcXRPUzNkR0Y0?=
 =?utf-8?B?Z2dYWmFrSm5PZzBhSit5RmM0aWVsTUN6US8rSDhYcUJLUlliLy9YaGJLcEh4?=
 =?utf-8?B?OFR1QWUxby9UTkxpOUlhL3VCOWVwQ3NmOU8xVVFXVnQ0ZWIzVHBmb28xdlhI?=
 =?utf-8?B?bEJ2a0FKUnpOWW9rMEx6VWY5OE5maWVqLzZzRXlKZks1RFJpaldZdExvMi84?=
 =?utf-8?B?dWF6SzdaZmtrUjUxVDFwYmxRTjVVQS9jYlFBOWFPOStFV0h4MTJEK1k5RE9v?=
 =?utf-8?B?YmlKdGRmWEsvcmFqRnhtdGJTY2gzczdNSzcyaDJwTEZpUXlibXhmU0V1eHdk?=
 =?utf-8?B?c1FCNFNhdTRyMlU0dXNWK3BsQ3ZLN1ErRVZPS3ZRMzdNK25NMFB4T2RRVlQ1?=
 =?utf-8?B?RkpsRTl5UFFWU01ZaVhUODFHbVA3TXB6bGdCS2RGNHNoR0RMY3pUanRkTWpC?=
 =?utf-8?B?OTdrK0s0cXJ5dHlmanJ5SFNsRjJMTUZhaGg0TlJ0ZGhSRDlkNFlUQk9YOU5X?=
 =?utf-8?B?c0NLSm5OOE1lNEtkZnNZK2FwbjROY2JrTGs4VzA1WW1kK0dWZ090b0dFM0N1?=
 =?utf-8?B?a2M5UTJiaGlSSGVkNER3MnNaSnVNNUYrREFpL3BJanYxWkZIY1NsZzlTMXlZ?=
 =?utf-8?B?aHRHWnVPdGJnYU00em9GUkJ6K2J0QUp0dnRxRUJqSTF4UjVwbDV4ODFIL05q?=
 =?utf-8?B?bmxraWorNzh1VS9JZzlTS0ZNVzQvQXdVY21BNUNPZnBTck1vNldYcUJVcUY2?=
 =?utf-8?B?eGhlb3JtRGwvWUN1d3phYk0yUVFuKzV2NEpsSFhBVzRKeHV0Z05ObWczYVF1?=
 =?utf-8?B?cTNaam1uYUxnRjVseUQ2Tkh0cTQ5SlNEOWtLUXQ3c3RBZmI1Q2tlakhveUh3?=
 =?utf-8?B?a0FFNVlJOWZlazVOS2VHbWpnaDVET2FDY3J0OXR1SWdzdHloUDY0aU9EcGU4?=
 =?utf-8?B?RFl3NXdNTzNhQ1ZTd0NVNjFQeFhPMTdmSXI2czBaWDFMK0lCTWdSdE1DR0g3?=
 =?utf-8?B?d2kxRHFQSGZ4WmxWN2lTRkdRVnY4QkZmZU5UOFlmLzI5Nzk0OFRQVnk0eHdo?=
 =?utf-8?B?TkkrOTNGbURJUE95Zm1qZkdxUmp4Q1dicWJLNHgwVVp0TWxOd0lnMHhUOTdo?=
 =?utf-8?B?a1BnWm9QT1d0M29EeVZnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39C99373EFDCD44EB46F6EA33E3877AF@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c9432737-6bf7-466e-3898-08daf2e85b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 08:55:00.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7672
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
IGluIHRoZSBUMiBNYWNCb29rIFBybydzIHdoaWNoIGRlZmluZSB0aGUgQUxTIGluDQphIHRvcC1s
ZXZlbCBhcHBsaWNhdGlvbiBjb2xsZWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb25hbGQgVHNj
aGFsw6RyIDxyb25hbGRAaW5ub3ZhdGlvbi5jaD4NCi0tLQ0KIGRyaXZlcnMvaGlkL2hpZC1jb3Jl
LmMgICAgICAgfCAzICsrLQ0KIGRyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMgfCA2ICsrKyst
LQ0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWNvcmUuYyBiL2RyaXZlcnMvaGlkL2hpZC1jb3Jl
LmMNCmluZGV4IGI3ZjU1NjZlMzM4ZC4uOGZjZDY2M2IxMGUyIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9oaWQvaGlkLWNvcmUuYw0KKysrIGIvZHJpdmVycy9oaWQvaGlkLWNvcmUuYw0KQEAgLTgwNCw3
ICs4MDQsOCBAQCBzdGF0aWMgdm9pZCBoaWRfc2Nhbl9jb2xsZWN0aW9uKHN0cnVjdCBoaWRfcGFy
c2VyICpwYXJzZXIsIHVuc2lnbmVkIHR5cGUpDQogCWludCBpOw0KIA0KIAlpZiAoKChwYXJzZXIt
Pmdsb2JhbC51c2FnZV9wYWdlIDw8IDE2KSA9PSBISURfVVBfU0VOU09SKSAmJg0KLQkgICAgdHlw
ZSA9PSBISURfQ09MTEVDVElPTl9QSFlTSUNBTCkNCisJICAgICh0eXBlID09IEhJRF9DT0xMRUNU
SU9OX1BIWVNJQ0FMIHx8DQorCSAgICAgdHlwZSA9PSBISURfQ09MTEVDVElPTl9BUFBMSUNBVElP
TikpDQogCQloaWQtPmdyb3VwID0gSElEX0dST1VQX1NFTlNPUl9IVUI7DQogDQogCWlmIChoaWQt
PnZlbmRvciA9PSBVU0JfVkVORE9SX0lEX01JQ1JPU09GVCAmJg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaGlkL2hpZC1zZW5zb3ItaHViLmMgYi9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jDQpp
bmRleCA2YWJkM2UyYTkwOTQuLmQwM2RjNGNhMDk1ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaGlk
L2hpZC1zZW5zb3ItaHViLmMNCisrKyBiL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMNCkBA
IC0zOTcsNyArMzk3LDggQEAgaW50IHNlbnNvcl9odWJfaW5wdXRfZ2V0X2F0dHJpYnV0ZV9pbmZv
KHN0cnVjdCBoaWRfc2Vuc29yX2h1Yl9kZXZpY2UgKmhzZGV2LA0KIAkJZm9yIChpID0gMDsgaSA8
IHJlcG9ydC0+bWF4ZmllbGQ7ICsraSkgew0KIAkJCWZpZWxkID0gcmVwb3J0LT5maWVsZFtpXTsN
CiAJCQlpZiAoZmllbGQtPm1heHVzYWdlKSB7DQotCQkJCWlmIChmaWVsZC0+cGh5c2ljYWwgPT0g
dXNhZ2VfaWQgJiYNCisJCQkJaWYgKChmaWVsZC0+cGh5c2ljYWwgPT0gdXNhZ2VfaWQgfHwNCisJ
CQkJICAgICBmaWVsZC0+YXBwbGljYXRpb24gPT0gdXNhZ2VfaWQpICYmDQogCQkJCQkoZmllbGQt
PmxvZ2ljYWwgPT0gYXR0cl91c2FnZV9pZCB8fA0KIAkJCQkJZmllbGQtPnVzYWdlWzBdLmhpZCA9
PQ0KIAkJCQkJCQlhdHRyX3VzYWdlX2lkKSAmJg0KQEAgLTUwNiw3ICs1MDcsOCBAQCBzdGF0aWMg
aW50IHNlbnNvcl9odWJfcmF3X2V2ZW50KHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LA0KIAkJCQkJ
Y29sbGVjdGlvbi0+dXNhZ2UpOw0KIA0KIAkJY2FsbGJhY2sgPSBzZW5zb3JfaHViX2dldF9jYWxs
YmFjayhoZGV2LA0KLQkJCQlyZXBvcnQtPmZpZWxkW2ldLT5waHlzaWNhbCwNCisJCQkJcmVwb3J0
LT5maWVsZFtpXS0+cGh5c2ljYWwgPzoNCisJCQkJCXJlcG9ydC0+ZmllbGRbaV0tPmFwcGxpY2F0
aW9uLA0KIAkJCQlyZXBvcnQtPmZpZWxkW2ldLT51c2FnZVswXS5jb2xsZWN0aW9uX2luZGV4LA0K
IAkJCQkmaHNkZXYsICZwcml2KTsNCiAJCWlmICghY2FsbGJhY2spIHsNCi0tIA0KMi4zOC4xDQoN
Cg==
