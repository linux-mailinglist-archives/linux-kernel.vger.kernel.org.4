Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18924630D07
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiKSHv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSHvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:51:25 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120075.outbound.protection.outlook.com [40.107.12.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6069980992;
        Fri, 18 Nov 2022 23:51:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvsAgv/LE5QmWAaNF8evvUxu1RhjvIGz4hojyhLRzf32SHl+7DrssPiiocOsxJDrL/yLSYB5mSFxbvbeqXFPNrvn767GpyRAnvz/a6eGiBQn4lrn2VDq2PRDBdSGuLuGC44hQRu893xJacJDACXK23mm4z3O/DrHTeqBYhESeoDalOLOa90o7oZTKEHnTjMciRWm3MMNL927yKlFdeJWG+WWTXK2KB/4tRBOSMNBxlzYV8Fo+KjBFKrvC8K+0SMKVn2nvBYh+qSQjhpGSZ2ypxXTqyRLBnYI9RXs2jjBFpubwrrktAhH54E5HKAYKFtYzBzILp3fZfvRuBdL2D+f4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMP35sRiesSvJVKLekcYnfhebN1vD1uCh7kNyk/UtxI=;
 b=ZLJ5HM/m6f1PqCMSaMAhkVtj7EyNveJrljtW7I15DYW7WlQxlN09D7J9pne8ufiYXarhj7oITBclVvJDB0V6b/SU75O9Tl+8VHJm2w4rph1Jy2wNBFpgbiKjHrHWtyjwfCB38xvab9crIwfLMdpeBf+85PLdLCjLOBaxEYrE2j7Qponpfe5j2/7Aa7BdcQnqZR3kLvRIDtV/axyix0jkiHQZVs9Xve4tCkkrrF6ZrelHvXQutxnHUvbj6yeiQyva5v0XuJJVxXe3MV20iwrzs8bqhVD6RM9bw/9sUXRKzwEqrLFXvU+bFkCHZmpmFqKnRPykNRP+4lehL728DIcYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMP35sRiesSvJVKLekcYnfhebN1vD1uCh7kNyk/UtxI=;
 b=r2Sv8OlippliaJELKLVAb8MOzN3OkiwOVJaNN/s1GnGAJL+8RQsUY3rul17eTuY49QViMPP1ThWCBjdQJHTThCaXY735o3yyyyaH3Csnz9eLZfTSaVXocIHhUhn7IddCFNkx/c2oJt30IYLc89OlmKSgCu9wPKZ3SuejgVOWmp/c4s1338YdeupVkvPgYZBEua1V36MdAAeaDuVjd4+KzAMjABoVNJ/eS/bUo5m70udVredjhy2hXZdteuv9qI5KQQdBUSU92rFS7ruHCvwXBm+n/KVcR1orgGFc1mwYQrYS0KO/9h9dY6+toJPNbF9ZEuVEy/5b99HmlL3aEwUmew==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1877.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 07:51:21 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 07:51:21 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v4 2/3] random: introduce generic vDSO getrandom()
 implementation
Thread-Topic: [PATCH v4 2/3] random: introduce generic vDSO getrandom()
 implementation
Thread-Index: AQHY+3O4zDHynjEiUE6xFq7Mo++rLa5FEqEAgABI0ACAAAKrgIAAgmsA
Date:   Sat, 19 Nov 2022 07:51:21 +0000
Message-ID: <2571f72a-3420-977f-7b08-8f6216bba6a8@csgroup.eu>
References: <20221118172839.2653829-1-Jason@zx2c4.com>
 <20221118172839.2653829-3-Jason@zx2c4.com>
 <ecfd265b-49e7-79b2-1818-e08a2c652db0@csgroup.eu>
 <Y3gbVorxZyb4SBJa@zx2c4.com> <Y3gdkxq4FjXcmAwA@zx2c4.com>
In-Reply-To: <Y3gdkxq4FjXcmAwA@zx2c4.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1877:EE_
x-ms-office365-filtering-correlation-id: df81e593-984b-45d7-8cd8-08daca02d9b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8zPsBRPNcu/O3sLgRCqW4Vo6ZnoF64GLrXd7OEfYbQt7uRlo+itNsfLPoh1R2yEuVy4tFOAcw7Gy8Xr2zR88gX/FACKwrWkRCqRFhVfJlfnrSaoFaExt8Hp25yAxnxpNTE6y4Q6DxLjdKhaLUjcPVfPUWa8Ch8uHjB3Y5iTpGJKj9yyrktHZShIUC7UaMueBVxYOUzM+ChjCvJG5w5yK+yCSSsmp4nJ5RbfLGXUqO8vdzhlCw6T55HSGDLL2YReduuVLKKCe5S02IgzMfDRyUVqzyCiNdG6pIyTJeSJEB76nlowfiQh4f7KU6krCF/axJIpoASPFgLo5K0JoU6wsGa2dtrbcizqbCsMfDzAKUOHjv2qXIJmn3CBdG63kFG+VDXfDgbBuin9fcr8UgA6p1xWYNh9rSmPw+S4p99u6iDJA1U04FuXtuWpH7jnE/SNU9sSdCIwizSr+KO5VjMdhH4kH0Y1heUa6RqzMK0QsaPl7da2jPfe3RcCPYL2wp2nqtBJEWTNt5tqm7cokv2c75wEyF1VOemG1MtBt8+MKs6Ed4GgXeHnuizBxUE+9LlqEPzheXalErLhNGk2w/xUTcawgOIA4uvmR+yla8dEqHzpwvExts7E4IFlgma+zbQmfh3CQDXD8g8k769zWM1fncvXchFU8mN2QT8Zmky7xPiOANrK81Ygvj1gW96Jn4QDUiXJonoNMgm4iHaeqbtA5cQZPiwEybiiAbYPGCF5aX5KDqEdScXjz1g+3ItcjSu1s+AXLOe2hJVTy5vtrzJZcZ00MbyfSLVGowCIJA4ucTtA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(451199015)(6506007)(316002)(6486002)(4326008)(54906003)(6916009)(66946007)(6512007)(91956017)(64756008)(66476007)(66556008)(26005)(76116006)(8676002)(66446008)(478600001)(71200400001)(31686004)(5660300002)(44832011)(8936002)(186003)(31696002)(41300700001)(36756003)(2616005)(2906002)(38100700002)(86362001)(38070700005)(122000001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2EzNnNMYWE4OWhkeVZ2UWdOT0Y3VVhCNlFmRUZUc3VEZS9tVVNyRlZDd2Zk?=
 =?utf-8?B?cnRMWjk5MERKZEk3dENFZEpNdWRaSTVWTmcyYUpqNFNpM0FReUVqOG5qampz?=
 =?utf-8?B?a3VRM2xoMndCR056S1VqQTlhTlJIV0dOemkzT1RrcVl0Nzk4Y0hNVk1TZ1RI?=
 =?utf-8?B?ejJtYVN3enF2allLOHRiZjZqa3NjYjRuUGRNY2pQQ2tUMU1GS0FnUmM4ckx5?=
 =?utf-8?B?SDJJRTU2bkZ4bk03Ny9abGlZL0s3Um5PdUpqTWJDNG81b0FBT1JXVWNYei9U?=
 =?utf-8?B?bktqZGk3MnJqYXhyVzlQYWUydDg5ZW8wNTZLVlJSREMxcFBBQll3UWVCcjdN?=
 =?utf-8?B?WHNyT0NJaTJTbXlQWDdEU1lia1dPTjRLd0IwaE5NTlpQaFFYbmI2MVdnYW43?=
 =?utf-8?B?TGxHLy9oK3Bla3llZUo0dFVLcDhZSis5a0dHVkJ5VHdLVlJaVmJTK05QU2Ew?=
 =?utf-8?B?N0xqZ29GdUNicjc1Yy9OeGo2M2loNnZGUFQvKzdhSXNWZEx5b25jM1hZeXdV?=
 =?utf-8?B?WXJkell4MGZpWHNxRDR3d1h5K2IzNDBTY2VxSnFoQ25VTUloR2hCZHUyRkEr?=
 =?utf-8?B?ckdNdXErREtFY3hQdWRsbWFrRDI0bmdJelcrUGtBOFdJM3kzQ1d2QmdlUnhi?=
 =?utf-8?B?QktCMnk2aHVqMGg1dy83eXRUVmJqRmdzVVgyT1I5RUVpU2V5R2hIeExFRGJt?=
 =?utf-8?B?amljaGxoTmFQd0s3eldqK1o1MkRtbnpLUlBZUkJiNUtjR0E2d2ZyNXhoMTlR?=
 =?utf-8?B?TzFFbWk0L1MwWHpJRzFKbDRmRXQ0NlVNK2tlcFdjY3NOeDBYTmpWclppN29l?=
 =?utf-8?B?YW9kTUcyWnlLTVFQT204VWFLenVJNzhVaWt5MEx5U0VYc1pQQ2tHN0N2SDFU?=
 =?utf-8?B?cisyUDRQMVhHN1ZJNko4ZmVXQXRkYkZ0bWEwWE5HSnArR0F0bzZpKzRoQXJo?=
 =?utf-8?B?cEtoWmI3UERYSDVVdFJ2ZXI3UnVESXRDbnZjTCtNRTVqb1gvOS85cGtMY3Rl?=
 =?utf-8?B?TGRvTmZwdnJGQWIyRlNzbXRndjZuTnFKdTE1N2cwNkhreThyWVZ4ZzFvVWZX?=
 =?utf-8?B?Q2NFTDU1M0paTGcweFZibFUySkVVS3Q5MUk5RHhpQTdBTUFBL25MTXM2R2JW?=
 =?utf-8?B?cDRYYnpNQ3FrY3krWTZndk1Ucm5wQ0QyK0FxdDVZNHZKdnZLa0xPS2FvZlZL?=
 =?utf-8?B?NHpEWi8wdjVEblhQNVJhQ2lyM0Rrbzlxc3lMcDJxaFc0RzJkbXF0VzBSMEhJ?=
 =?utf-8?B?aUhUaTR5d3QvUmw1Q2hvY3hKV20xY0hPSktzblg2VGlUUzY4Rnpjc01wWXJl?=
 =?utf-8?B?MjB0NC9rRHlTYTRRV3IybE1xTERIbEt3bVhvSDJiZTF5RUNpYndyWjJOZUor?=
 =?utf-8?B?RnFianhpZWVzNVBWRGI5anU4aXlKaGJxZUwyOTNwSFpMbW53SEx6Z0N4SDRz?=
 =?utf-8?B?ZTBGakNEaldBalhtNjVqVUFTQVRhNnFwVUtFZWljcW9lMHZjUjBpdmFDVmpO?=
 =?utf-8?B?UFJ6QUNnbVFJR2VlNGlyWXlBK0tYdm56aUZGSjBhSGNMQnM2OGF0YUNMTHR5?=
 =?utf-8?B?elpCLzZPYVEyUFBpWDJzN0wwTWNKckZHS0ovajNHMGR5K0pWQ2hKczNyQnZa?=
 =?utf-8?B?VUxwdWliVjkwUTFGZkQxNmpOcXZRUWI4THNnUHc1SytQUmJ5MHI2RHV2U0lE?=
 =?utf-8?B?WWIraDRQVWJtdkpicEdmc3ZVbnRqaG5seERxYTJzTndGZ21Udk16bk5XUnNZ?=
 =?utf-8?B?WmZDczltV3hqRW1pYkx1QnppZ3lQV0pFV01oZjJtczFVNVBHS0ZzejFzdXlX?=
 =?utf-8?B?N2tqZHh5NDVsbDFPUXFVQ2JSK21Db0UvVWpiYitDVFk0cTlXTlhpZm9VRk5a?=
 =?utf-8?B?WEgrdzNtbk91amNPcUtVZ3dET05mcEJPckxCR3VBOHk1Tnp3OWVJVXFWcFNv?=
 =?utf-8?B?bW9zbWc3a0gzcTh5UmdOM2k5cys0UlRHeFpGajlWM2V0UzNBbnFvS20wOURp?=
 =?utf-8?B?RjRsQTlEby9McWNadjd0Nm5DV0szaEJXT1JDSnErdHJiaWVmSjVmakpCMm5T?=
 =?utf-8?B?aE1MUjYxVXRHelh5dkhhRTE5UFJtYksySjBGQzFrTE1oa0FCbklCczFaSWZu?=
 =?utf-8?B?Zk9lT3p3bTd6OWkxeUpxSTlROUVXSlFBTFdidTVoZm12MXZzWVpBcStpeTBJ?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9AE67101A4B6747A33AA08FD32330CF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: df81e593-984b-45d7-8cd8-08daca02d9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 07:51:21.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRbzvInFvQwQA2Am4s8zcUjz67SE0v0NJeutrj16royMYrLhv67BqUop+0pt5J5tPkqEvZHbnpnboDKg3IYW+shYqVYRfzLzykNPIft5jwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE5LzExLzIwMjIgw6AgMDE6MDQsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBPbiBTYXQsIE5vdiAxOSwgMjAyMiBhdCAxMjo1NTowMkFNICswMTAwLCBKYXNvbiBBLiBE
b25lbmZlbGQgd3JvdGU6DQo+PiBTb3JyeSBpZiBJJ20gYSBiaXQgc2xvdyBoZXJlIHRvIGdyb2sg
d2hhdCdzIHVwLg0KDQpNYXliZSBJIHNob3VsZCBhbHNvIGhhdmUgbWVudGlvbm5lZCBjb21taXQg
Y2U3ZDgwNTZlMzhiICgicG93ZXJwYy92ZHNvOiANClByZXBhcmUgZm9yIHN3aXRjaGluZyBWRFNP
IHRvIGdlbmVyaWMgQyBpbXBsZW1lbnRhdGlvbi4iKSBmb3IgeW91IHRvIA0KaGF2ZSBhIGNvbXBs
ZXRlIHBpY3R1cmUuDQoNCj4gDQo+IE9rYXksIEkgdGhpbmsgSSBzZWUgaXQgbm93LiBUaGF0J3Mg
YSBjb21wbGljYXRlZCBwYXRjaCBmb3IgYSBzaW1wbGUgaWRlYQ0KPiBiZWNhdXNlIGdldHRpbWUg
aXMgbW9yZSBjb21wbGljYXRlZCB0aGFuIGdldHJhbmRvbS4gSSBzdXNwZWN0IHdoYXQgeW91DQo+
IHdhbnQgaXMgc29tZXRoaW5nIGxpa2UgdGhlIGJlbG93LCBjb3JyZWN0PyBTZWVtcyBlYXN5IGVu
b3VnaC4NCg0KWWVzIGl0IGlzIGV4YWN0bHkgdGhhdCwgcG93ZXJwYyB3aWxsIHRoZW4gY2FsbCBf
X2N2ZHNvX2dldHJhbmRvbV9kYXRhKCkgDQpkaXJlY3RseSBhbmQgcGFzcyBybmdfaW5mbyBwb2lu
dGVyLg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL3Zkc28vZ2V0cmFuZG9tLmMgYi9saWIvdmRz
by9nZXRyYW5kb20uYw0KPiBpbmRleCBiMjUzZTkyNDc3MDYuLmIzMjgyZDdjZmI1MyAxMDA2NDQN
Cj4gLS0tIGEvbGliL3Zkc28vZ2V0cmFuZG9tLmMNCj4gKysrIGIvbGliL3Zkc28vZ2V0cmFuZG9t
LmMNCj4gQEAgLTQxLDEwICs0MSwxMCBAQCBzdGF0aWMgdm9pZCBtZW1jcHlfYW5kX3plcm8odm9p
ZCAqZHN0LCB2b2lkICpzcmMsIHNpemVfdCBsZW4pDQo+ICAgfQ0KPiANCj4gICBzdGF0aWMgX19h
bHdheXNfaW5saW5lIHNzaXplX3QNCj4gLV9fY3Zkc29fZ2V0cmFuZG9tKHZvaWQgKmJ1ZmZlciwg
c2l6ZV90IGxlbiwgdW5zaWduZWQgaW50IGZsYWdzLCB2b2lkICpvcGFxdWVfc3RhdGUpDQo+ICtf
X2N2ZHNvX2dldHJhbmRvbV9kYXRhKGNvbnN0IHN0cnVjdCB2ZHNvX3JuZ19kYXRhICpybmdfaW5m
bywgdm9pZCAqYnVmZmVyLCBzaXplX3QgbGVuLA0KPiArCQkgICAgICAgdW5zaWduZWQgaW50IGZs
YWdzLCB2b2lkICpvcGFxdWVfc3RhdGUpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgdmdldHJhbmRvbV9z
dGF0ZSAqc3RhdGUgPSBvcGFxdWVfc3RhdGU7DQo+IC0JY29uc3Qgc3RydWN0IHZkc29fcm5nX2Rh
dGEgKnJuZ19pbmZvID0gX19hcmNoX2dldF92ZHNvX3JuZ19kYXRhKCk7DQo+ICAgCXUzMiBjaGFj
aGFfc3RhdGVbQ0hBQ0hBX1NUQVRFX1dPUkRTXTsNCj4gICAJc3NpemVfdCByZXQgPSBtaW5fdChz
aXplX3QsIE1BWF9SV19DT1VOVCwgbGVuKTsNCj4gICAJdW5zaWduZWQgbG9uZyBjdXJyZW50X2dl
bmVyYXRpb247DQo+IEBAIC0xMDcsMyArMTA3LDkgQEAgX19jdmRzb19nZXRyYW5kb20odm9pZCAq
YnVmZmVyLCBzaXplX3QgbGVuLCB1bnNpZ25lZCBpbnQgZmxhZ3MsIHZvaWQgKm9wYXF1ZV9zdGEN
Cj4gICAJbWVtemVyb19leHBsaWNpdChjaGFjaGFfc3RhdGUsIHNpemVvZihjaGFjaGFfc3RhdGUp
KTsNCj4gICAJZ290byBtb3JlX2JhdGNoOw0KPiAgIH0NCj4gKw0KPiArc3RhdGljIF9fYWx3YXlz
X2lubGluZSBzc2l6ZV90DQo+ICtfX2N2ZHNvX2dldHJhbmRvbSh2b2lkICpidWZmZXIsIHNpemVf
dCBsZW4sIHVuc2lnbmVkIGludCBmbGFncywgdm9pZCAqb3BhcXVlX3N0YXRlKQ0KPiArew0KPiAr
CXJldHVybiBfX2N2ZHNvX2dldHJhbmRvbV9kYXRhKF9fYXJjaF9nZXRfdmRzb19ybmdfZGF0YSgp
LCBidWZmZXIsIGxlbiwgZmxhZ3MsIG9wYXF1ZV9zdGF0ZSk7DQo+ICt9DQo+IA0K
