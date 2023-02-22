Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D163869FADC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjBVSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBVSNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:13:38 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2030.outbound.protection.outlook.com [40.92.102.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBD227B1;
        Wed, 22 Feb 2023 10:13:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0kN2WVwQLl5hdnonh9eIvPWpDkNCXsybN/NqFU9GcQm664DMyGbuNaR4QEhYQQaysisWynGvh4jK7s8N6bhfpC8pMgeo+mdiJzMVccYsFOkpgX7f+lSpR3rgtMQQE3mr/JHWCMXNzViS8og0z5Qz45SId2IdDBVhJIXS9ORdlZVP280y/VrmqHaFX8aOHgNOQUD1mXk6qOJ6X4vqHREgA1m4kaxokzd6gWhPQXnwAQS3xDDEu74CVY3jnz5ZZu1cGuap3EstMjqAxjPRe41P5KNCXVgW/l8cSNSOnVp/9Lo6dlaF90o0g68nuT/ijtqWSmghU5ikr3rj35OgjBEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gcv896YmC+tEVEF8G+2S6Gi6RYWMqX1SfRgJtAF+njI=;
 b=ec/+bw18yxmGtcaU0s1uR1lfVrxlcKIGdYW20uhJT1fW5QYYfU3HL/PtJ065N/k5OlZj7mDYcgP2sNGfVCU6VKkz/Ako1Jact4kM4+WKcQNcCfEVawWtF6qnKeU48E0ERS3SiYvhampdwTipKaSefK1IHamSS0EmJMIpdF42GPS25F2R5bmMsMJvpBCvnlcwLi8k+5ltTdA7wudNeWO6eqbJJCf+iEfiDhvpx7BksW+or2n0fWvHAIEOOwa2jw46VY85fUIkyX41jRbR8eHqZC+NrEsRTAcuQ14u626NNsbpAJVKhc6w/StxNm4frXxtLDQNSj7+S0qKVA3nF/V4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gcv896YmC+tEVEF8G+2S6Gi6RYWMqX1SfRgJtAF+njI=;
 b=DN32qyyaJNLfL62vsslfbyBDmnFmqwbbiwR/MbreFkgmvf1fBXElqYDSiWtPAvnTV59EvZd9FaNeBL6ozZNHqUwmhB2/ml/9XkAl2Uja2ojyyIolPEwkiOm8NXJ+kRqrDU6MIQti/v23OrFGpOFz3ZFrIW9lJ7cb4MDx4c7BsFQi4sXtonuT0UQ2L94m3u8aZk5cyyXys0jmGZiG7k0Z+F3eBNc2sJ82AxOX8znsEQ7vXBVVfHfjosQQturdOqVLghxh2asTY5SVOiT62BlIaZEq2A6waGlL1P2aE4ZbFBIIISqhW3FmQ9qE7lHNQT6w/Z+jGRLuZj/0nmAo/D0G3A==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB8180.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Wed, 22 Feb 2023 18:13:31 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f156:868f:a45b:aeee]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f156:868f:a45b:aeee%11]) with mapi id 15.20.6134.019; Wed, 22 Feb
 2023 18:13:31 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Thread-Topic: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Thread-Index: AQHZRdZPnsOA0zlv+UikzIJmE+f5Ta7ZVTYAgABwQxiAAYGTnA==
Date:   Wed, 22 Feb 2023 18:13:31 +0000
Message-ID: <BM1PR01MB09310531DC4ED55B73764743B8AA9@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
References: <BM1PR01MB0931B467250831916F7C55B3B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
 <60dad2c6-9f37-86af-5f37-aa5d45c33afa@redhat.com>
 <BM1PR01MB09313E8C98F63BD65CCD3362B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BM1PR01MB09313E8C98F63BD65CCD3362B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [X32L/uTL1RI+ThEkuNVVi6pMApVpqFjfksr++lWjDoT3V7+BYFTt52Ekpf2p0hqv]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB8180:EE_
x-ms-office365-filtering-correlation-id: 3cfad8b7-2c62-49a7-e3e9-08db150080f2
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9OUBXzI41CsTm/y4Otn1UqtS8Qxy1RIdo2Pl73boyuBO55V+so7CjcPnpBgJMvv2sZVG8kixoaWUnwifvShyQv7APzX7NtyTj05HkscVxBkqlpQCDl1fWSVUKW/MgnRiq0kGCcVCy/3LHd5HSN6IZ0+pw2DV1/93Hv/Kkx0vyMajS7DocxA3ayL5IMarxs1+ztPn6/PXXcRtWFSc9qlYQrnj6d1LmKmWlkHl1howxKsob9yYO8j8nbjK+bA6bwIOMio0/6d1ThphIAspjbV3O9dVY/zGRPxfxMC+0eCO4NuqYPCYEZV/NJoFeopGNI9XJU1snJTYZKs+0cvk/HJw5IBGL4popcP+ltSeGkucH37WUe+repD/We+qS62/iowpag7PxQCGgazEKUeziRpbAVekuQPOwGM5pF3wF9wwp45IngFgJPWbgWvDMxZqUPb6hyZ1meJhsbzou0uMcn4LsU1EHzfao56CqQ885jXUrc1wJA7cTPIcY0BrkVkNaPL/PsFve/ivfkO+jd7qLK0ZE42TMZnkoOXadi/5jYpFs5n5TSvkQJeHwPv5bW2JKG3a+QpEvXDRfMZ/rZjkL2aEYegykWFWidRwfrP+jy+5s0hdRCG58UFwqfCF3LUwXWzio/Zna6wsGPJubnJIC2mHg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0E2b055Z09qSUNLOUdlbkJrSXVXd0swMVhEOFg1VzVjRGpuOTI2a3B4TUdJ?=
 =?utf-8?B?SEhCOEhsQXlPNXVFUFdUd1ZibXU2d2xvdXZWRjRCZi9ZZDZpSnNOaThZcDQw?=
 =?utf-8?B?WHdkaVV1T3IvQXFObG5reHh0U1NHSGRaK2ZVVUVENXFsRWdWMC9VK2U2Q2Ix?=
 =?utf-8?B?OW1oYmg3WjY2RGI0Y241OXd6ZXdGNVhlRU5nY3UrTTQ3cFNJN2o5Q1ZnL2M4?=
 =?utf-8?B?emwzSXYvajJqUEkxNXNwZDUyditoR0RUd0wwUnozMFJWcDBySXQzZk1qQ2ti?=
 =?utf-8?B?QjJhVVJrMmpJTnlDa2pUMXN5UWhpbjBmY3g0dDVPaHFQdGtSWW5jZlkrcnh5?=
 =?utf-8?B?WENmR2FHSDdzMjRIekY5RVVPZklOdXNjU0pkTVBaQXo4dFZJdVZrcnJVdlRS?=
 =?utf-8?B?UERoUm5VRW9JMWJYMXhjV3pnWDJod2FCT05OODlyRzh5NVFFRStlV1I0S3JE?=
 =?utf-8?B?N2ZSNkd4WWs5NGx5clY2clVpWk9YdFhZS1liMFJTczNheHhzbWltbVJKdEI5?=
 =?utf-8?B?UngvSW5BVFppTTRodTBtczVJQlQ4ZmlZSlREaEhiM3cwbDBMV3UwUUNuVVlo?=
 =?utf-8?B?eGIrSlVXaEp6Mmp1TS9IYjlENy9LbGtVZWZrMzJpL3NRRlovSE0vWDNLRUs4?=
 =?utf-8?B?ZXJWcjhrV1hnNkYySGZiaStxTHpVRmpDVWMxa1hnUUZsL1VBSHVxc2htMVVq?=
 =?utf-8?B?VHR0dDRwSlRzZXlYdVEwbW42bC9iZTgzNmtlVmtGQVc2N2YxYTNoNEJxVTJ6?=
 =?utf-8?B?WlJIMlRsNlREcjBVVmdwWTgyNjdRcGV1Y05GRWp4WDlDb2JsN0hobVlIR3ZM?=
 =?utf-8?B?Y0VJMjRGdnd3cFh2bkg5U2MvSGR6OXFNUVNIYVkwNXJka2lmbG4xcmdUTnVT?=
 =?utf-8?B?dnhBZ1ppWVVhQVlrUFhWcWQrSzlZRjBqd01ObzlCZ1JFSEE1dS93elZCS2RF?=
 =?utf-8?B?NnZQTlVOOVNVV1pXZXVmY2ZhekZHd1o3ZEkveGducy9GZGtIM1lQQ09yKzI4?=
 =?utf-8?B?dUpXTnVNUUlmTGZNZmRvMG1DeXhPam14TGlxaS96QjEyNG5Gd2JWQndIbEkz?=
 =?utf-8?B?N0pGZE5jNjNBTnJLS3F2b0Q3WElJeTIyeTlpVzZpdHpSdTkvdUt4aWJKamtj?=
 =?utf-8?B?L0E0QUZsQnNKWjYzZWlqaW02SUtxOGJlOXlmSjZyYXRTQjFBUVJzMU5SMjlw?=
 =?utf-8?B?YkZQTXRNcjdkektJdTJNdWUvbFlCZUhCQ0Z2MGJmQnNLb1NGNmZYRDhkOCta?=
 =?utf-8?B?WUZSRG0xZWkxbzlpTjhkQm5KV3llY2E1ZXJwQ0diM3dTQ2c3N0MydnQ3RHUz?=
 =?utf-8?B?MGx5ZHE0blFDK1BRSDBWMXphL0UwcTZiRzJubUFzZjM5VGJwMUs0L2hVcUI1?=
 =?utf-8?B?ajJRaEhQaEM2aWR5dEptY1ZCbkF6RzlHTi8xN3A3Ukh2M0kxck4wZXV3MGZa?=
 =?utf-8?B?YjBVOU15dnYxcnQ0SFByQzJRejNmZ05lb1g5ZXJnTmlKMGZIL3BOOVFEQVRH?=
 =?utf-8?B?YzRFeHlYTC9iMlA5SktIR005M1BHSzFsS1ZXYTFQeGUxdDQwK3NFemd1R01H?=
 =?utf-8?B?NXZ3clhrdFo4NWlYZmhCWGp4MVdIN0NvT0ZUUFBpMTEraUY4T0NLWTNzVEpJ?=
 =?utf-8?B?V3luVlZsSzBPQ1c2dWU1bHRWSi9jYmVzQUFQeGcrVVRpTlB2TVhzSUV5UWp4?=
 =?utf-8?B?MTRSdGdaMUJTK3JCMzU3ZnhGVWlzVVhQRlRhdHZYcUZUd0w1ZnU1NWF5eWh2?=
 =?utf-8?B?YVZsSjZKbXYwMjY0dlAxOUFNWDlqc2ErbFpCSkdZREFjZnpvZXRPVTFpRkxP?=
 =?utf-8?B?U2JxV1g4bEJCa3lCMUh5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfad8b7-2c62-49a7-e3e9-08db150080f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 18:13:31.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8180
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gQWxzbywgYW5vdGhlciBpc3N1ZSwgSSBoYXZlIHBsdXltb3V0aCBlbmFibGVkIHdpdGgg
RlJBTUVCVUZGRVI9eS4gQWZ0ZXIgdXNpbmcgdGhlIGdtdXggcGF0Y2hlcywgdGhlIHNpemUgb2Yg
dGhlIHRoZW1lIGhhcyBiZWNvbWUgdG9vIHRpbnkgZm9yIGFuIGluaXRpYWwgZmV3IHNlY29uZHMs
IHRoZW4gaXQgZ2V0cyBub3JtYWwuIEkgdGVzdGVkIHRoaXMgYnkgY29tcGlsaW5nIGEga2VybmVs
IHdpdGhvdXQgdGhlc2UgcGF0Y2hlcywgYW5kIHRoZSBidWcgZ290IGZpeGVkLiBJIGFsc28gdHJp
ZWQgdXNpbmcgYWNwaSBiYWNrbGlnaHQgdXNpbmcgY29tbWFuZCBsaW5lICh0aGF0IG1hZGUgbWUg
ZGlzY292ZXIgdGhlIGBhY3BpX2JhY2tsaWdodD12aWRlb2Agbm90IHdvcmtpbmcgYnVnKS4gSXMg
dGhhdCBhbHNvIHJlbGF0ZWQgdG8gc29tZSB1cHN0cmVhbSBidWc/DQoNCkhpIEhhbnMNCg0KSXQg
dHVybnMgb3V0IHRoYXQgQXBwbGUtZ211eCBoYWQgdG8gYmUgbG9hZGVkIGluIHRoZSBpbml0cmFt
ZnMgZm9yIFBseW1vdXRoIHRvIHdvcmsgcHJvcGVybHkuIFNvLCBpdCBhY3R1YWxseSB3YXMgbXkg
bWlzdGFrZS4NCg0KQWxzbyBJIG5vdGljZWQgdGhhdCB0aGUgcmVzcG9uZCB0byB5b3VyIHBhdGNo
IGZvciBtZSB0byB0ZXN0IGRpZG7igJl0IHJlYWNoIHNpbmNlIGl0IHdhcyBhbiBIVE1MIGVtYWls
LiBTbywgeWVzLCB5b3VyIHBhdGNoIGhvbm91cnMgYGFjcGlfYmFja2xpZ2h0PXZpZGVvYA==
