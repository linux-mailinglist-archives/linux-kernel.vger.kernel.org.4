Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890AB602757
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJRIny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJRInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:43:51 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2043.outbound.protection.outlook.com [40.107.114.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF85D731
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyujK+9Xh4hSnyCHpWnkwANphEViTGw+GcyVIaWA0flQtPCBBrlR9adBtx46+FQIkhDIOhuDz/JL0erDfOdeg8TOlhMTFoKq6AYRp+R9FSoHqX8YmvlBESikXRMt9v4vr+aZ5A3qJyOzuqrykAeSL5bNm2IisrL1RzR1rZPfXuWAZ0R0vDzncLNb2Eb84csrsNviEBByRXJcRXFpD8xPngygpWflo6jgCvsHs4KiZhy9B5fZ2F+iVEHZqssS1K2Z+TgE0LpS+oHijGk348eCYMxLRVox60Zi6dcaTYVYRhrkhrNFuvV8PnsLOSgSQ6PXgGJTvxr7QuYy1qtAfzk9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zclh8YFWp+I/kIFEMUQwPwrdkAxbHgJFmih0cJmuNno=;
 b=GsbnMaKwv+QtW0oNvDeM8EQsbss+O/MvljAYaCCVaOh95gUnq990ztvZ30yd7HoBv1E4DqZlnjCpPXQZOPBZcM1r+QwjZIZzdwtB7saDA0Kml4D9XBILm7NhE10w43JALZC278vu5BQdH70KTfGKq8Nzn0rri0H1y/aOjushbiitGBVodRzkXJGhCw0+3mShIyo38p1SD+8OLS2k4Z2yg+wR7eDkMRnpJv8tcJSfDWmdXkjsAGon8npfrIkcIw0aBezC2eLyKPiHiCJjNxXdFFWOEk0Gk/TpkXjSqtOkZ0W3mTXjcvWAQUmhpjS3ru4NQrrSlof2KZthf4SYOJNVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zclh8YFWp+I/kIFEMUQwPwrdkAxbHgJFmih0cJmuNno=;
 b=kwax8uwuGpzxk85UhKERpEfFqMo6Xa/irzmQ2g3UJaBQtI2/CA9JChTaZjbP4+hG7tv7BNxJaJdCoxX//wnxpDR/x1dnSFcD9YmmOvbkm7Zp9f6tcLHJkW7/RA9fdbrg62GtVXj18YcQZVL+1xgCu5eNrMElqZboO5AFFrPwqc4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB7902.jpnprd01.prod.outlook.com (2603:1096:400:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 08:43:43 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%8]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 08:43:43 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Tony Luck <tony.luck@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, hwpoison: Recover from copy-on-write machine
 checks
Thread-Topic: [RFC PATCH] mm, hwpoison: Recover from copy-on-write machine
 checks
Thread-Index: AQHY4oIZlVCqZIwIPkq8zJAWWgjDG64T1m8A
Date:   Tue, 18 Oct 2022 08:43:43 +0000
Message-ID: <20221018084342.GA3743869@hori.linux.bs1.fc.nec.co.jp>
References: <20221017234203.103666-1-tony.luck@intel.com>
In-Reply-To: <20221017234203.103666-1-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYYPR01MB7902:EE_
x-ms-office365-filtering-correlation-id: f779e201-d929-40ba-5cee-08dab0e4dceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CJfmw01VmWeYSH9dyoIZgK0FkjY1NnYftG/uKPUDV3FI2sBmYVCU5MOcgZyqgbUuAD0hEZhGqY7pPRaEhU3SKhrStpMeu1se9Rc02GgpzaSDBCEIuhFcbXrR5RAmUmh9wRbmtrvFUs5zZNXY4ZGPtW4v6m0oCtg3dGTSYVkoeZAsaHmCW5R8e9LD+DyTPUF+09Sce2eSkEAi0+N9eigbJry7ptPhBo6aMfl6dOBRCnnEJ6vq+LoMC0GWoyUGOQCSZaicxytsnuxQCO89f0JSzWg2IprOQktucg5CNBzBWfWY4ysNCPhNMePPOYWZbEb/ii6wcf1nREiv/hLSvh311f1UH28l0KbijrQ/MFkctMA6hf1K93XbGeqVYkTuC66+x5Rm8sAcQ2/llZJ9b+T1CM1DpObC9BgPAEZHtttWSQkmsa9n2zUo6s6tzyJvlCOGTBo/9ytchKfZ3xJbl7z0PADRoSH/HrYKhajq+GWQS4j4aXK8lSHea+v7aUkwFcb2PmlErUQI5zQOpnBShok6XAfZgmcEtd86jUmGgbrrG6BTH/c+exsvrNoQiH6ToFq47TSJd+vn/7WOEP/nWtAUOW3xPNZsw9pElkpM6XdAzZ585TzMTaVE2mmisGK8qNmiDmnf6p72UeqnE5nYokbAPAGZ15sNa39vlW+5Mcb82Vive37uF56hsspDctOXlu4o2ubnVAJDYElmHrq1e3TaSxoDrGPdnKPyt2u8OyNGjX8kzyyotl5V3aUhxy/1k3FKkor/ssS85pN81xprY+EZ7z0DMojpd65KpkaxRrWSFg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(82960400001)(38070700005)(85182001)(86362001)(33656002)(66946007)(38100700002)(83380400001)(122000001)(6916009)(76116006)(64756008)(316002)(66556008)(66446008)(8676002)(54906003)(966005)(6486002)(5660300002)(2906002)(186003)(71200400001)(1076003)(8936002)(66476007)(4326008)(478600001)(9686003)(6512007)(26005)(41300700001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEppWVJmWkNMa0E1TTlkV0lxTVA2cWxNd2ZkNVhIdUhOYWIzdnNDVU94d3FQ?=
 =?utf-8?B?cGFJWFI4THVmL20wVm5sK0doVnZkSEYweW1pSkpmZ3RwRUVpWVF1WXBqbTVF?=
 =?utf-8?B?YlRmNE1vTkthZjFWRzVvd216WVZTaHUwdVFLREVVQmF4QnpFYWZ0RW5SOUdO?=
 =?utf-8?B?ME1QazE3VCtTcHN3VXAzSnoydWI5c1JtbXZsUG1pWk9qNmNKSk5tVVZhenZv?=
 =?utf-8?B?QkxHVzZVc0taTVlPdmJ3UmVHUHJsNmNUbFFVdlFaNEpsNy96QUx6WEpKYjRD?=
 =?utf-8?B?N3YxZVhOeC9IYmlBM09DcEdLQXU2aWlhanRJZS9ZQjdQdXFmSjRDelNSUVUx?=
 =?utf-8?B?OUxEbk83NlJXRWZOdWFTYTkxRUFGOVZWRVo1YUVYa3pwN3pPZU9PSkxPcmJz?=
 =?utf-8?B?WHYrMEpNZzJ3L1cyUWhhNzc2MXErNmEzU00xdGJJaUhyc1BEbGxUVldYME15?=
 =?utf-8?B?ZVBTMTZEVldsTERlSFJFSm9Jc3B6VjhOYVZNa0YvUFBpYXlPS0FRNUwvclNt?=
 =?utf-8?B?dzhwclN0RGJ1ait0Zlo5WU5kdnJsUEduOTIrcjhJS2xVdXNHeHQrMzYwcGJw?=
 =?utf-8?B?OW5Ga0xLWThjM1oxc0FMK1JvT1dZZnlLdUNHVXh4RzcvRWRwb1Z5ZkN4cVNn?=
 =?utf-8?B?dzZmNjU5K09UQS9lMzlxSllMeEVFbXljM2lDcjZyV3BrY0VpUDZSUm5LQTJI?=
 =?utf-8?B?TWRqdnhMTkRMVDN4Rk1hTElSQXQ4akJibUZoSzhmUmI5dE8wZnR2R2hma2Vl?=
 =?utf-8?B?YzJ5VWpvV2tUR0dvZnFPVTRRYU5ESWQ4bDlybm9TVDdjeTNUV29xWTY4NXRi?=
 =?utf-8?B?ekc2czVFRDh0ZHV0bzQ4YzNVbUczb1g5RmxDazE3N1FYbXBNY05oU0NWTXUx?=
 =?utf-8?B?ajZmOGtkS0JRZFZzYmdxUHNQMHMwbHNOZFBLVjR4QXlXWWNNWnhrV2FJSWRV?=
 =?utf-8?B?cnM3VnJkU05XUmhwdituTTNIek1iVVViMG1ka1lLQm8rd0plZXluZFQwaUVx?=
 =?utf-8?B?MTNVZ29tRTZMdVd4TTlkRFJ4WEEwdXM1TUIvVmhDTkhzT3V6T0xpYUo1QjdW?=
 =?utf-8?B?RGFGcTZhRGNLVkkxUXFRMnNXdHlOMm9FYVJYTXFJVStFYXRHdVNZdUtBNE5t?=
 =?utf-8?B?dTBPalFCK2ovTGRTeUNlRUxQbjJyM08xb3hVaVZEQWpUWmhOR0lGa0R2RFp6?=
 =?utf-8?B?eEhtNURnT3JJanBFRCt3RUVoeUpVQldLOTF5MTlOMFd0WmY2Mi9sSkRqb2Vy?=
 =?utf-8?B?K2YwNmUyYzJFM3BDTW41cFlET1NCem1EMld5QTBTTVJsMm1hOTB1YWlGRC9j?=
 =?utf-8?B?YTVqQmcwODladTJjMm5CeEMrcEJRZ3h3VTJwQ01RdlFINnBLZ3EwVjlIL3VI?=
 =?utf-8?B?WlBXUlp4ZytXYlJUWTI3OXI3TThZQWducTRBSTA1QnRPQ2J3RG5OQkt0cWJZ?=
 =?utf-8?B?VU1sRnRYdyt5U0NqYjE5eUFKVlFPZm1HVmxtVGRtRVpud0lPcGRzZjMrOVpq?=
 =?utf-8?B?VUpoaURyZ1RYVDhRT2pVYjc1MHBqcjluQTRVb010ZXRhVnI0UXBDODlWSkFU?=
 =?utf-8?B?d3F4VjBzQ1ZDUVp6Q3p1Z2laV1JUdE1sMFlVSEpNbzVFQ2RwS1JjUHRNMWth?=
 =?utf-8?B?a1N1MkZhVkFnZDlqT2ZWQjlYY3ltanlaenN4OTdIUXJsY25SbmdWaTBvcUJz?=
 =?utf-8?B?WnFsN28vQnRjVS9uQm10d0o2c1lXejdFTzNjNktHeDBja1FUaDZ5d044OVNr?=
 =?utf-8?B?TE9iT3oybEhIVENhVmhSU1dwbXdKSG8rYk4yYVFNOUpGTUMzWmprMEVnaGZO?=
 =?utf-8?B?eUZLRDN0bFVwZnRsMnN3WG5DOGN4WlFLeHcyeFF6SmdCeENidUF2RVE5YUY2?=
 =?utf-8?B?MDRaMUxpYmZLcFduZFJLZDJTZkxDTjFRZDhHQzhWM2xzT0loOGc2enVmdmRB?=
 =?utf-8?B?bWJYTHNlMDZBd3pXdm1lRStRUURPUHEvcW5UWGh6U1cyd3k0dXUySDNRMHd5?=
 =?utf-8?B?S2s0cDZzTXRBRzU0bzN3T0xCeW5VS1pDRmhOMmFFN2RoMmZaV0pTbkZaOTM2?=
 =?utf-8?B?QXJZaG5ZWS9BNkswdUpJWEZRVWRNdUluZGJpakNqTGt2L0ZhRmZHUHEzYjdu?=
 =?utf-8?B?UG55cXJlaS9SaXMvaFFBZTJNT3ZhUngxTHZJNGNNZmdjR1FsV3ZjdVNoNnBD?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F2AF42E141C9C47B55AE4A9F21C5DD1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f779e201-d929-40ba-5cee-08dab0e4dceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 08:43:43.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rB4cPsS8RfWyBZ0YdvlwHVI4aFbCH9OKd3WKghDtJlCMk+1Qlp9Ta08cH/QptDu33QMumCobOsVXEZFM5e09ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMTcsIDIwMjIgYXQgMDQ6NDI6MDNQTSAtMDcwMCwgVG9ueSBMdWNrIHdyb3Rl
Og0KPiBJZiB0aGUga2VybmVsIGlzIGNvcHlpbmcgYSBwYWdlIGFzIHRoZSByZXN1bHQgb2YgYSBj
b3B5LW9uLXdyaXRlDQo+IGZhdWx0IGFuZCBydW5zIGludG8gYW4gdW5jb3JyZWN0YWJsZSBlcnJv
ciwgTGludXggd2lsbCBjcmFzaCBiZWNhdXNlDQo+IGl0IGRvZXMgbm90IGhhdmUgcmVjb3Zlcnkg
Y29kZSBmb3IgdGhpcyBjYXNlIHdoZXJlIHBvaXNvbiBpcyBjb25zdW1lZA0KPiBieSB0aGUga2Vy
bmVsLg0KPiANCj4gSXQgaXMgZWFzeSB0byBzZXQgdXAgYSB0ZXN0IGNhc2UuIEp1c3QgaW5qZWN0
IGFuIGVycm9yIGludG8gYSBwcml2YXRlDQo+IHBhZ2UsIGZvcmsoMiksIGFuZCBoYXZlIHRoZSBj
aGlsZCBwcm9jZXNzIHdyaXRlIHRvIHRoZSBwYWdlLg0KPiANCj4gSSB3cmFwcGVkIHRoYXQgbmVh
dGx5IGludG8gYSB0ZXN0IGF0Og0KPiANCj4gICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvYWVnbC9yYXMtdG9vbHMuZ2l0DQo+IA0KPiBqdXN0IGVuYWJsZSBB
Q1BJIGVycm9yIGluamVjdGlvbiBhbmQgcnVuOg0KPiANCj4gICAjIC4vZWlual9tZW0tdWMgLWYg
Y29weS1vbi13cml0ZQ0KPiANCj4gW05vdGUgdGhpcyB0ZXN0IG5lZWRzIHNvbWUgYmV0dGVyIHJl
cG9ydGluZyBmb3IgdGhlIGNhc2Ugd2hlcmUgdGhpcw0KPiBwYXRjaCBoYXMgYmVlbiBhcHBsaWVk
IGFuZCB0aGUgc3lzdGVtIGRvZXMgTk9UIGNyYXNoXQ0KPiANCj4gUGF0Y2ggYmVsb3cgd29ya3Mg
Li4uIGJ1dCB0aGVyZSBhcmUgcHJvYmFibHkgbWFueSBwbGFjZXMgd2hlcmUgaXQgY291bGQNCj4g
Zml0IGJldHRlciBpbnRvIHRoZSBnZW5lcmFsICJtbSIgd2F5IG9mIGRvaW5nIHRoaW5ncy4gRS5n
LiB1c2luZyB0aGUNCj4gY29weV9tY190b19rZXJuZWwoKSBmdW5jdGlvbiBkb2VzIHdoYXQgSSBu
ZWVkIGhlcmUsIGJ1dCB0aGUgbmFtZSBkb2Vzbid0DQo+IHNlZW0gbGlrZSBpdCBpcyBxdWl0ZSBy
aWdodC4NCg0KQXMgZm9yIHRoZSBuYW1lICJjb3B5X3VzZXJfaGlnaHBhZ2VfbWMiLCBpdCBzaW1w
bHkgc291bmRzIGxpa2UgYW4gbWNzYWZlDQp2YXJpYW50IG9mIGNvcHlfdXNlcl9oaWdocGFnZSwg
c28gSSBoYXZlIG5vIG9iamVjdGlvbi4NCg0KUmVjZW50bHkgc2ltaWxhciByb3V0aW5lIGlzIHN1
Z2dlc3RlZCBpbg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyMjEwMTAxNjAx
NDIuMTA4NzEyMC0yLWppYXFpeWFuQGdvb2dsZS5jb20vDQosIHNvIG1heWJlIHdlIG5lZWQgc29t
ZSBjb29yZGluYXRpb24gYmV0d2VlbiByZWxhdGVkIGludGVyZmFjZXMuDQoNCj4gDQo+IEJhc2lj
IGlkZWEgaXMgdmVyeSBzaW1wbGUgLi4uIGlmIHRoZSBrZXJuZWwgZ2V0cyBhIG1hY2hpbmUgY2hl
Y2sgY29weWluZw0KPiB0aGUgcGFnZSwganVzdCBmcmVlIHVwIHRoZSBuZXcgcGFnZSB0aGF0IHdh
cyBnb2luZyB0byBiZSB0aGUgdGFyZ2V0IG9mDQo+IHRoZSBjb3B5IGFuZCByZXR1cm4gVk1fRkFV
TFRfSFdQT0lTT04gdG8gdGhlIGNhbGxpbmcgc3RhY2suDQo+IA0KPiBTbGlnaHRseS1zaWduZWQt
b2ZmLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQoNCkknbSBiYXNpY2FsbHkg
c3VwcG9ydGl2ZSB0byB3aGF0IHRoaXMgcGF0Y2ggaW50ZW5kcyB0byBkby4NCg0KPiAtLS0NCj4g
IGluY2x1ZGUvbGludXgvaGlnaG1lbS5oIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiAgbW0v
bWVtb3J5LmMgICAgICAgICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9oaWdobWVtLmggYi9pbmNsdWRlL2xpbnV4L2hp
Z2htZW0uaA0KPiBpbmRleCBlOTkxMmRhNTQ0MWIuLjU5Njc1NDFmYmYwZSAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9oaWdobWVtLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9oaWdobWVt
LmgNCj4gQEAgLTMxOSw2ICszMTksMjUgQEAgc3RhdGljIGlubGluZSB2b2lkIGNvcHlfdXNlcl9o
aWdocGFnZShzdHJ1Y3QgcGFnZSAqdG8sIHN0cnVjdCBwYWdlICpmcm9tLA0KPiAgDQo+ICAjZW5k
aWYNCj4gIA0KPiArc3RhdGljIGlubGluZSBpbnQgY29weV91c2VyX2hpZ2hwYWdlX21jKHN0cnVj
dCBwYWdlICp0bywgc3RydWN0IHBhZ2UgKmZyb20sDQo+ICsJCQkJCXVuc2lnbmVkIGxvbmcgdmFk
ZHIsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcg
cmV0ID0gMDsNCj4gKyNpZmRlZiBjb3B5X21jX3RvX2tlcm5lbA0KPiArCWNoYXIgKnZmcm9tLCAq
dnRvOw0KPiArDQo+ICsJdmZyb20gPSBrbWFwX2xvY2FsX3BhZ2UoZnJvbSk7DQo+ICsJdnRvID0g
a21hcF9sb2NhbF9wYWdlKHRvKTsNCj4gKwlyZXQgPSBjb3B5X21jX3RvX2tlcm5lbCh2dG8sIHZm
cm9tLCBQQUdFX1NJWkUpOw0KPiArCWt1bm1hcF9sb2NhbCh2dG8pOw0KPiArCWt1bm1hcF9sb2Nh
bCh2ZnJvbSk7DQo+ICsjZWxzZQ0KPiArCWNvcHlfdXNlcl9oaWdocGFnZSh0bywgZnJvbSwgdmFk
ZHIsIHZtYSk7DQo+ICsjZW5kaWYNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4g
ICNpZm5kZWYgX19IQVZFX0FSQ0hfQ09QWV9ISUdIUEFHRQ0KPiAgDQo+ICBzdGF0aWMgaW5saW5l
IHZvaWQgY29weV9oaWdocGFnZShzdHJ1Y3QgcGFnZSAqdG8sIHN0cnVjdCBwYWdlICpmcm9tKQ0K
PiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1vcnkuYw0KPiBpbmRleCBmODhjMzUx
YWVjZDQuLmI1ZTIyYmY0YzEwYSAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LmMNCj4gKysrIGIv
bW0vbWVtb3J5LmMNCj4gQEAgLTI4NDgsOCArMjg0OCwxNCBAQCBzdGF0aWMgaW5saW5lIGludCBw
dGVfdW5tYXBfc2FtZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikNCj4gIAlyZXR1cm4gc2FtZTsNCj4g
IH0NCj4gIA0KPiAtc3RhdGljIGlubGluZSBib29sIF9fd3BfcGFnZV9jb3B5X3VzZXIoc3RydWN0
IHBhZ2UgKmRzdCwgc3RydWN0IHBhZ2UgKnNyYywNCj4gLQkJCQkgICAgICAgc3RydWN0IHZtX2Zh
dWx0ICp2bWYpDQo+ICsvKg0KPiArICogUmV0dXJuOg0KPiArICoJLTEgPSBjb3B5IGZhaWxlZCBk
dWUgdG8gcG9pc29uIGluIHNvdXJjZSBwYWdlDQoNClNpbXBseSBjYWxsaW5nICJwb2lzb24iIG1p
Z2h0IGNhdXNlIGNvbmZ1c2lvbiB3aXRoIHBhZ2UgcG9pc29uaW5nIGZlYXR1cmUsDQpzbyAiaHdw
b2lzb24iIG1pZ2h0IGJlIGJldHRlci4gIEJ1dCBJIGtub3cgdGhhdCAicG9pc29uIiBpcyBjb21t
b25seSB1c2VkDQp1bmRlciBhcmNoL3g4NiwgYW5kIGl0J3Mgbm90IGNsZWFyIHRvIG1lIHdoYXQg
dG8gZG8gd2l0aCB0aGlzIHRlcm1pbm9sb2d5Lg0KTWF5YmUgdXNpbmcgLUVIV1BPSVNPTiBpbnN0
ZWFkIG9mIC0xIG1pZ2h0IGJlIGhlbHBmdWwgdG8gdGhlIGRpc3RpbmN0aW9uLg0KDQo+ICsgKgkw
ID0gY29waWVkIGZhaWxlZCAoc29tZSBvdGhlciByZWFzb24pDQo+ICsgKgkxID0gY29waWVkIHN1
Y2NlZWRlZA0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIGludCBfX3dwX3BhZ2VfY29weV91c2Vy
KHN0cnVjdCBwYWdlICpkc3QsIHN0cnVjdCBwYWdlICpzcmMsDQo+ICsJCQkJICAgICAgc3RydWN0
IHZtX2ZhdWx0ICp2bWYpDQo+ICB7DQo+ICAJYm9vbCByZXQ7DQo+ICAJdm9pZCAqa2FkZHI7DQou
Li4NCj4gQEAgLTMxMjEsNyArMzEyOSwxMSBAQCBzdGF0aWMgdm1fZmF1bHRfdCB3cF9wYWdlX2Nv
cHkoc3RydWN0IHZtX2ZhdWx0ICp2bWYpDQo+ICAJCWlmICghbmV3X3BhZ2UpDQo+ICAJCQlnb3Rv
IG9vbTsNCj4gIA0KPiAtCQlpZiAoIV9fd3BfcGFnZV9jb3B5X3VzZXIobmV3X3BhZ2UsIG9sZF9w
YWdlLCB2bWYpKSB7DQo+ICsJCXJldCA9IF9fd3BfcGFnZV9jb3B5X3VzZXIobmV3X3BhZ2UsIG9s
ZF9wYWdlLCB2bWYpOw0KPiArCQlpZiAocmV0ID09IC0xKSB7DQo+ICsJCQlwdXRfcGFnZShuZXdf
cGFnZSk7DQoNCk1heWJlIEkgbWlzcyBzb21ldGhpbmcsIGJ1dCBkb24ndCB5b3UgaGF2ZSB0byBj
YXJlIGFib3V0IHJlZmNvdW50IG9mDQpvbGRfcGFnZSBpbiB0aGlzIGJyYW5jaCAoYXMgZG9uZSBp
biAicmV0ID09IDAiIGJyYW5jaCk/DQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+ICsJ
CQlyZXR1cm4gVk1fRkFVTFRfSFdQT0lTT047DQo+ICsJCX0gZWxzZSBpZiAocmV0ID09IDApIHsN
Cj4gIAkJCS8qDQo+ICAJCQkgKiBDT1cgZmFpbGVkLCBpZiB0aGUgZmF1bHQgd2FzIHNvbHZlZCBi
eSBvdGhlciwNCj4gIAkJCSAqIGl0J3MgZmluZS4gSWYgbm90LCB1c2Vyc3BhY2Ugd291bGQgcmUt
ZmF1bHQgb24NCj4gLS0gDQo+IDIuMzcuMw==
