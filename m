Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFAD605516
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiJTBgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiJTBgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:36:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2054.outbound.protection.outlook.com [40.107.113.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0C1B9DA;
        Wed, 19 Oct 2022 18:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuRP85NAioOz/SxDcR7rQjB7rAPiVt1h3cL5M049i3Pwqiq8PnyoZyOal3mYW+kWvHbiRhASesmLxso0O8aOrdwdDhteMgIQu0D4q9/r0BVvRWJ2sWkBQYOgCB4k/8Ijto38g3kvkUNv1OGBBGjJg/nAyyih3PhnwAj7q0mP/NU4ew4Lr4CCnPCvHhzsTQlJ6IVoP5uUfs5SZrSwIRwzPTjwS5oNjgnsMjR9OMDE3Sq9tZZkTMEehZVvIyZl/IoBrvNy2QNipOMoHrMoK82x7dhX1oE+WrGfERHh/4YvFebgYZd4OH8sm56D5GKWVVfvIkZ+KL4DajUV4g2KB1egtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ElJiG4d/8y8Ab6zbHQR7yB1dmjhxpAB+OwOyXqu4nc=;
 b=ONwcT55phYf5nTUi4/YhFBA4vYVLZTrNeuO33KvTPWKLwFUmoGCc1gaM7wCW8gFOndFBrTpPAnUCKcsdPiHDRJ+OILyOzcL3JLGSMWn08MteZEMZZznbgnG5ZI76G2F6FDSrc558kcOTTB4HfFAWzthABD/Hh+WMa8AOMf4LkHO4XEi82Vc+Euz4o9gGdA5kz2ez5JAuKnj6ZyQtpBhyJGYInRYz1UM+ew+1IJq1YgDs7EBoXSejyWHPh0tDxIpUN3I+13VXS7GJNvD7LqR8Vf7u0XRfiHkOnE8Jcip2VU9MM+oblSix4G8naElztTD7rRok4MuO3IqZCCJxn4xZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ElJiG4d/8y8Ab6zbHQR7yB1dmjhxpAB+OwOyXqu4nc=;
 b=UzxkL931acbvMUF8lXGvOeabTruQm82jNQ0Pxh6CZ9D95Cmg4yfvJhk38TGlLY8wZcSonaErfy2zRNkUxMUdDxHBEHs0uzytyRh2qGnmFgFb9h1KGHE5MwNQ8LnTcopM9YsW8l3hExGyJXcmGUWYCmPJSvztqSIFfKd4HuSfE08=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TY3PR01MB10237.jpnprd01.prod.outlook.com (2603:1096:400:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 01:35:54 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 01:35:54 +0000
From:   =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>, lijiang <lijiang@redhat.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "crash-utility@redhat.com" <crash-utility@redhat.com>,
        "heinrich.schuchardt@canonical.com" 
        <heinrich.schuchardt@canonical.com>,
        "hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
        "yixun.lan@gmail.com" <yixun.lan@gmail.com>
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Thread-Topic: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Thread-Index: AQHY4sowOW0HNCQqKU+2PSWxrOMtua4T3VOAgAAEI4CAAAqigIABCJqAgAAQ6ACAAAdlAIABdgGA
Date:   Thu, 20 Oct 2022 01:35:54 +0000
Message-ID: <52023285-172a-97cc-bad4-4ab4e709885c@nec.com>
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
 <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
 <a66a5b16-5f1f-3d80-3cdc-4b82d38d604f@linux.alibaba.com>
 <0f0a77a9-c824-8aa4-77de-a75c2139d791@nec.com>
 <811bdf09-be38-ce2a-a1d3-ada9f7c85b97@linux.alibaba.com>
In-Reply-To: <811bdf09-be38-ce2a-a1d3-ada9f7c85b97@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TY3PR01MB10237:EE_
x-ms-office365-filtering-correlation-id: 574cc036-d99a-43ae-1d4d-08dab23b6e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0KJOPhrzTedlucBPpsYgXFe7k/eskFkVsNlEZGegfWXQ3FUlKZLK4erWR0FEStZ7Xfvpb2LT/ziY9d4Cl/vDz+hdTGD+t1xxsnVUhSmE77BP8wrR2flq5/VV7lQEgsdgHSVihTpwL1kyscxSp1NZcUOs4KL+SUf1J3hQ7tBCJ31EprJZenMkIbbRg4SCrwWiPXKpNk1jD+8IifnKPlQ0bbQChm7UsaO8azrL9BCxl7xaBLhUF1x7Z+UkIBMnkRurG8eVeclXHneQfXgtEAqmKIo4oQB94Du/j3BRVJB6f++zX+VGVpaQDRpt29ZXudiLn+3ws4E6fqmL+j1ZDdc7TDSZ/u+S3IGzqH4kQYOevQsv75ZGc7e7/m2lMm+hXzs+z1sNFfnh7JptadFv0dkS1n4XKpcnteykE1I1N5hHyscjdcIClcmR31dK1wUt60bFAwup5p9QSzphHZ5de5JU0fNtn6Tf4KNWa+Euks4rtTjOJZRXkdRaiQIk4bBg9ZH7nFCuclkAAWKse9LOajx/iFsdf8rSK7pXZ7jBL+4iPF9GRQqjg2ClLsoCesGIDUjQ9XNGV5LaOyCQbowqcRE7GAhi0qREkYWB9X3C2FDKwgIFaf5BSZBuRZW/P5uzhF8kkb/8fXI2m6qer+FvR8jgfQXBDRyl9HpBSACjC6QJ5gWsRq8A7l/vUHiNsaALxYwGqtXP1KFDIdctrV10SmsOaHatDQNlzMPOiS5Bklr2JQ3gLh5GSPIt2HpFEz0q1RF7vlWutnxNfzCw2NYgLhz8gawGDZiyiwjL+OBZ+ZU8k1xMEf4rbFbW6i+d9Xd8dDj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(85182001)(31686004)(38100700002)(122000001)(76116006)(66946007)(66556008)(66476007)(66446008)(7416002)(5660300002)(8936002)(110136005)(31696002)(86362001)(82960400001)(38070700005)(6512007)(26005)(2616005)(6486002)(71200400001)(54906003)(36756003)(316002)(966005)(478600001)(55236004)(8676002)(41300700001)(64756008)(53546011)(4326008)(6506007)(186003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1JHRHM4eDNoQ1pOWnVkbFJhdWJobjA1alNsNXh0Z3BEWnpVOHAwajhMaUV0?=
 =?utf-8?B?MTkvcFUwRGw1amdVYlFqTlFlZUZvNmJvRjhLTGpQdkorVHMrTVRnQ0lwbnRQ?=
 =?utf-8?B?VzQwUGFUVitjNGJVZU5hMWlPU0c3MkYxcG9xbjFXNDlzbEhnckxMQkdUSDZH?=
 =?utf-8?B?a25HR0lncGZzMjlqQmdxQ0p4NE4yQzZGYlM3YWxjY0lhS2V1Mm4xeDdkK1VW?=
 =?utf-8?B?b1VNa05oRWx2T0hmMkxoUThBRi9DTmEzckxobGk1dVFlV01nZzN4U3ludVlX?=
 =?utf-8?B?SDZscFdlOTBWTi9zaGhLcXZKS1RlT3d2azZZeUFabWpZb29QWGZBVENkbkJL?=
 =?utf-8?B?bmpuU3NrOUcwcndNNTV0YjNqWktnQzNPMk1BSkVVL28vSEQ0cVlOVDFqNk9i?=
 =?utf-8?B?Mk5DbkJHL3hLNjRlM0R5Zk5tQy9WVVk4d1JnTnFONnl0VmxhNFM0VnBFQVpl?=
 =?utf-8?B?M2F6dm8vZHMrbUZoMHl6ZkE0TlZQNXpJak1zdExucU4rSFRZVklqYm0yVWV0?=
 =?utf-8?B?dlVLVEVoOWVqWjNzR0RRQlFNUklLUkFzZmdFSGxicEtqRllhbmhhRUd0QWVE?=
 =?utf-8?B?NGswOGdGQ2VXdmd4L3ZXN1JNdmxJZHRtdG5nL2VPY0JLZk5xbElVQjdUYzY5?=
 =?utf-8?B?d1BpOE1qUmhuRElSY2dFZnhVUXlib1pyZHZ4Z1hRVGl4ZUU5dkdZNVhBVkVz?=
 =?utf-8?B?TmJ6Y2MybWZZR0FVdnlTeVdIVml6TFRKUmxlT3BUZ2huOEZ0NzVDNHFaTkxy?=
 =?utf-8?B?b21HRk5jS215STFJWXlKdWZTT1NrRkRlOHNCU0xRL0xVdHQ1bzBOWWkvd2FB?=
 =?utf-8?B?d2RBRzhsbjY1TTk0aklnOElOUi9QbEZUaHZmK3NxcDhXM0NoRmdwMGllQlE1?=
 =?utf-8?B?RnJVbzBKNHN2eGhPcmFJZEJFZ3g4SFNLVkdlQzZBdGxPWGljS3hjRzV6TTk4?=
 =?utf-8?B?dmtqRzVCeTVVUUJ3QVcxOVloRlljdDJINFI5MXl4dW9HN2NWU21CU3pnNGwv?=
 =?utf-8?B?T1VzbFJyM1FhTjJXWTdiSTBsRm8zd1REQWpJQllobGI5a1Z1M3pEV0E2cFBO?=
 =?utf-8?B?QXNZRk40QjNlVTRXR0FoRnpXYitWUys2S1B4UGpEeVRTTm5OZ1JLUG9qWjlJ?=
 =?utf-8?B?LzR5dmU5b2Vja3Jrd05DRGxxZXNjQmtlajBHM3FrQWtqMWpqd3NDTzNubVdG?=
 =?utf-8?B?K2tlMStJZ09nZFdZd3pjdVozUysrdXNzRHdRN1pwQkxZN0NaZWFabk91dEJC?=
 =?utf-8?B?dGxBOVhWeUY3eGFyRlFnalpDVTNUaFFjOU5MWUxEUjZLYUh1aWYxeVUzNUxq?=
 =?utf-8?B?ak9Qd2h6Z0diNXZrRFNrQTRPRW9FSVhucjkvVDJhdU9hNVYzK3BBeXJGRnBQ?=
 =?utf-8?B?VlNmeSs4YytYTWRtZDRhVEVxZ3JBM2orWFR3TEtXdEZHSnUvdDEzbGNPb3FU?=
 =?utf-8?B?REl5c2t2bzNOZzVWN0wvbWl1KzR6bkZaZFNjYlRLQWtYOWFXSjJrNXZtekRk?=
 =?utf-8?B?dUplWWNKaFR5Qkx1U3BITWgyT1VvbVNkUjJYZVNIeEdFL1JCN0NLc3dSV2lx?=
 =?utf-8?B?TkNMK24zR2VoOXF1dmc1MHZYOUFrS0RHWTNicC90N205c1hxZUEwbjBLMTNa?=
 =?utf-8?B?UGgvZWtqUVJjZjVNRTZENE1PbHRWYTNwMmhZSnRacFlUazgvWVB5N2dIT0lq?=
 =?utf-8?B?OGxTNENJbUljZi9CUGxKYy9MVFBVelEzVUU1U0NETzAxWXJWVlhhVU8wWjlv?=
 =?utf-8?B?V1UxeHVCSDB3QU11WGRiNEVsNmRPVHpTa29sL0taK1VpdGdFOGFHbjRDeUp3?=
 =?utf-8?B?VDFvZHpQd1d0bVZ6VEliS0N1dVdFVzdVL0tTQlIzVDR1MWdkd3FqanBKTWNk?=
 =?utf-8?B?Wkx6c1M5ZWNMMnJkN1MrYWtUUHdvRUc1N21NVlkwVlJVcEhqQU5RRG9vWWJT?=
 =?utf-8?B?cURwQXlBSXRLZERKS2xYdTRXV09hQTh5RWpEYTBuY3hscWlUbWtRQ2tkYndZ?=
 =?utf-8?B?QTJrZ0dWNUdYc1kwQWl4TE1VTXErMEFZSWVHNDNGblRqSVZQUThoVTRId0xB?=
 =?utf-8?B?ay9HOVFaQklvLzZWalRZVEtjQWsvcHlvS0xaYnhFWEtqZUxwaTUrWjFUb3Va?=
 =?utf-8?Q?dBiowdL77R0EeOWUirYjBtfAo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0F47EB0810B1242B641467531F5751A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574cc036-d99a-43ae-1d4d-08dab23b6e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 01:35:54.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9t+I14rII6rHuNw441pIWC0JFaoMUsyL2KfGH+yuiP1uK1KfVDLW9rAf7z/f3PVI33zH3GE3PKrU8Qn42wFZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMC8xOSAxMjoxNywgWGlhbnRpbmcgVGlhbiB3cm90ZToNCg0KPj4+Pj4+PiArwqDC
oMKgIGlmIChJU19FTkFCTEVEKENPTkZJR182NEJJVCkpIHsNCj4+Pj4+Pj4gKyNpZmRlZiBDT05G
SUdfS0FTQU4NCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHZtY29yZWluZm9fYXBwZW5kX3N0cigi
TlVNQkVSKEtBU0FOX1NIQURPV19TVEFSVCk9MHglbHhcbiIsIEtBU0FOX1NIQURPV19TVEFSVCk7
DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihL
QVNBTl9TSEFET1dfRU5EKT0weCVseFxuIiwgS0FTQU5fU0hBRE9XX0VORCk7DQo+Pj4+Pj4+ICsj
ZW5kaWYNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVN
QkVSKEtFUk5FTF9MSU5LX0FERFIpPTB4JWx4XG4iLCBLRVJORUxfTElOS19BRERSKTsNCj4+Pj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKEFERFJFU1Nf
U1BBQ0VfRU5EKT0weCVseFxuIiwgQUREUkVTU19TUEFDRV9FTkQpOw0KPj4+Pj4+IFNlZW1zIHRo
aXMgaXMgdGhlIGZpcnNyIEFSQ0ggd2hlcmUga2FzYW4gYW5kIGtlcm5lbCBsaW5rL2JwZiBzcGFj
ZSBhcmUNCj4+Pj4+PiBhZGRlZCB0byBkdW1wIGFuZCBhbmFseXplLiBKdXN0IGN1cmlvdXMsIGhh
dmUgeW91IGdvdCBjb2RlIGNoYW5nZSB0bw0KPj4+Pj4+IG1ha2UgdXNlIG9mIHRoZW0gdG8gZG8g
ZHVtcGluZyBhbmQgYW5hbHl6ZT8NCj4+Pj4+IEtBU0FOX1NIQURPV19TVEFSVCBpcyBub3QgdXNl
ZCwgS0VSTkVMX0xJTktfQUREUiBpcyB1c2VkIGluIHRoZSBjcmFzaCBwYXRjaCBzZXQ6DQo+Pj4+
PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmlzY3YvY292ZXIv
MjAyMjA4MTMwMzE3NTMuMzA5NzcyMC0xLXhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20v
DQo+Pj4+IE9oLCBJIHdvdWxkIHNheSBwbGVhc2Ugbm8uIFNvbWV0aW1lIHdlIGdvdCB0b25zIG9m
IG9iamVjdGlvbiB3aGVuIGFkZGluZyBhbg0KPj4+PiBuZWNlc3Nhcnkgb25lLCB3ZSBkZWZpbml0
ZWx5IHNob3VsZCBub3QgYWRkIG9uZSBmb3IgcG9zc2libGUgZnV0dXJlDQo+Pj4+IHVzZS4NCj4+
Pj4NCj4+Pj4gRm9yIHRoaXMga2luZCBvZiBuZXdseSBhZGRlZCBvbmUsIHdlIG5lZWQgZ2V0IGFj
ayBmcm9tDQo+Pj4+IG1ha2VkdW1wZmlsZS9jcmFzaCB1dGlsaXR5IG1haW50YWluZXIgc28gdGhh
dCB3ZSBrbm93IHRoZXkgYXJlIG5lY2Vzc2FyeQ0KPj4+PiB0byBoYXZlLiBBdCBsZWFzdCB0aGV5
IGRvbid0IG9wcG9zZS4NCj4+PiBIaSBLYXp1LCBMaSBKaWFuZw0KPj4+DQo+Pj4gQ291bGQgeW91
IGhlbHAgY29tbWVudCB3aGV0aGVyIHdlIG5lZWQgS0FTQU5fU0hBRE9XX1NUQVJUIGFuZCBLRVJO
RUxfTElOS19BRERSIGFyZWEgZXhwb3J0IGZvciB2bWNvcmUgZnJvbSBjcmFzaCBwb2ludCBvZiB2
aWV377yfDQo+Pj4NCj4+PiBJbiBteSBjcmFzaCBwYXRjaCBzZXQsIEkgZG9uJ3QgdXNlIEtBU0FO
X1NIQURPV19TVEFSVCwNCj4+PiBBbmQgb25seSBnZXQgdGhlIHZhbHVlIG9mIEtFUk5FTF9MSU5L
X0FERFIsIG5vdCByZWFseSB1c2UgaXQuDQo+Pj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LXJpc2N2L2NvdmVyLzIwMjIwODEzMDMxNzUzLjMwOTc3MjAtMS14aWFu
dGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLw0KPj4gSW4geW91ciBjcmFzaCBwYXRjaCBzZXQs
IEtFUk5FTF9MSU5LX0FERFIgaXMgdXNlZCBpbiBWVE9QKCkgYW5kIGxvb2tzDQo+PiBuZWNlc3Nh
cnkgdG8gbWUuDQo+Pg0KPj4gVGhlIG90aGVycyAoS0FTQU5fU0hBRE9XX1NUQVJULCBLQVNBTl9T
SEFET1dfRU5EIGFuZCBBRERSRVNTX1NQQUNFX0VORCkNCj4+IGFyZSBub3QgY3VycmVudGx5IHVz
ZWQuwqAgSXQgbWF5IGJlIGJldHRlciB0byBhZGQgdGhlbSB3aGVuIHRoZXkgYXJlDQo+PiByZWFs
bHkgdXNlZC4NCj4gDQo+IEkgYW0gdmVyeSBzb3JyeSwgSSBtaXNzZWQgaXQgLCBLRVJORUxfTElO
S19BRERSIGlzIHVzZWQgaW5kZWVkLg0KPiANCj4gS0FTQU5fU0hBRE9XX1NUQVJUIGlzIG5vdCB1
c2VkLCBzbyBJIGRvbid0IG5lZWQgdG8gc2VuZCBjcmFzaCBwYXRjaCBzZXQ+IGFnYWluLiBvbmx5
IG5lZWQgdG8gcmVtb3ZlIEtBU0FOX1NIQURPV19FTkQgaW4ga2VybmVsIHBhdGNoIHNldC4NCg0K
SSBzZWUgdGhhdCB5b3VyIHY0IGtlcm5lbCBwYXRjaCBzZXQgZG9lcyBub3QgaGF2ZSBBRERSRVNT
X1NQQUNFX0VORCwNCnNvIGl0IHNlZW1zIHRoZXJlIHdvdWxkIGJlIG5lZWQgdG8gY2hhbmdlIHRo
aXMgcGFydCBhbmQgcmVsYXRlZCBvbmVzDQphdCBjcmFzaCBzaWRlLg0KDQogICAgICAgICBpZiAo
KHN0cmluZyA9IHBjLT5yZWFkX3ZtY29yZWluZm8oIk5VTUJFUihBRERSRVNTX1NQQUNFX0VORCki
KSkpIHsNCiAgICAgICAgICAgICAgICAgbXMtPmFkZHJlc3Nfc3BhY2VfZW5kID0gaHRvbChzdHJp
bmcsIFFVSUVULCBOVUxMKTsNCiAgICAgICAgICAgICAgICAgZnJlZShzdHJpbmcpOw0KICAgICAg
ICAgfSBlbHNlDQogICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQouLi4NCmVycm9yOg0KICAg
ICAgICAgZXJyb3IoRkFUQUwsICJjYW5ub3QgZ2V0IHZtIGxheW91dFxuIik7DQoNClRoYW5rcywN
CkthenU=
