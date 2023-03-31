Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46986D16E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCaFlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaFlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:41:50 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2067.outbound.protection.outlook.com [40.107.114.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6BE1165F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZaoClGc2ThvEpBs7bF5Z2ckEG/Aq3vF+fxpMuQpMYDLzqulNKcwYpL/dYxX/xHgZ6JMN6xFOieM+f6yokU11QAEGvxMe4OxzoMwIJU6rYqbR2qgCpT+N3KW9UAxUkCUkVZCxtVnUy+nnclB+Tc/xz6iff+zh3qnGbdPYfqpOuVUopZE1X8KtLb/DKePIhzfzOxdt2AjHb/mWAvak8Kxe8ngsP0L2YS9F9++vqqvCt9vhXWsqfTwu52VM51ikSFyaZM2XKR4qzEaK2n40JSGdeX/ZB9kzz2qOvQ3nSNZYE2/ex1Be5ogIIcoslxuAgVsg1r/0kI2nWoqHmrGLAv9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bYuwQfZub4766xNS5L0FeerqZT6fscP4ZJzYrtmpr0=;
 b=aUHv5B0pY/zGh8Hq2uJV23QzowichVruAxPBcXZzW/HeH8RRTjI2s6tMehbF09vWMF8uTHiLLlWVNDMdkSkfRyoungY3it9sYeu7sOy9/wP2dU2v3p04Xih/d9r3LNYp7/xiOBLLgHuu2H4knUge4lK5ZSyaCFbUh+2UD1SKT4vlaLTeEx09jxzqUY8A31PtZFg8sjWqMOsqc6Eyq7cMZV1t60uLYSOVAwATmsIPZu63s/alDEI9OLsWEo+b+JrKgeGjlmYQfJ7swyd+cNHzIYbIly3xpIpdYpjXh06fcuYy1i3ErEfuk5rwYTLX0xx4j8cORfOSRnItd1Nc1PHayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bYuwQfZub4766xNS5L0FeerqZT6fscP4ZJzYrtmpr0=;
 b=msuAnvP0vs1AZq6bPFmSe6XozAR9jjofwHNoEoFOB/4Y2/UkCtr38xuzCMlo3FOvb4y3A5OABS58x+6htsoa0VFYcODnahbuUx7SDRoEVTiCDtWIFJ3zFDpJREsPiqOTcFPh2lJ2ynbsHf1fPPw4MR3O8u31sWOIhZzax2EJhco=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB6284.jpnprd01.prod.outlook.com (2603:1096:402:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 05:41:45 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8%6]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 05:41:45 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Longlong Xia <xialonglong1@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] mm: memory-failure: Refactor add_to_kill()
Thread-Topic: [PATCH 1/2] mm: memory-failure: Refactor add_to_kill()
Thread-Index: AQHZYtujgTVPuC7Sr02LiITw8W1aFK8UYToA
Date:   Fri, 31 Mar 2023 05:41:45 +0000
Message-ID: <20230331054142.GA1435482@hori.linux.bs1.fc.nec.co.jp>
References: <20230330074501.205092-1-xialonglong1@huawei.com>
 <20230330074501.205092-2-xialonglong1@huawei.com>
In-Reply-To: <20230330074501.205092-2-xialonglong1@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYAPR01MB6284:EE_
x-ms-office365-filtering-correlation-id: 30b25f77-cc33-4bbb-6cf5-08db31aa9cf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEhsPogjTcsPOaudJxcfBnkMENPCtfYNC8jCjoNcmol0lLYuPAdpuGX3/NicUQzXcP5kRdUXQnw+sRprDTSvU56Tsso+w2gqRTRdaHnaXdSREY0Adzvz3fBUxru1s/edYFVTy3kKfN2ZMTeLlgvIuu60eMnYYoBTLdToTVhc4vLTangAHRYEgd84lriHOJMdRDNG55x+Fd0XITr9fj2NJqGRzWZ+Z9DbT0OdPOtxHcFzFw8ik2lyJ4Se0KDaCqlyIZj2sKAVD+eH82HLC40wvUl0OCSVVAF4nIgpi+vtCgp6avKUQr3d1n3Kda+Lcliunv4l/kiDr6K4glCV9mRpusIkD4mnFk0ab1B6dsgRPAGhrUt6ZInmmvoq3RbHsuMCxk/imh1n91PwWB4cgDavAE7zw9uKQ8xknj7MptU+/FPU7LMrALAf1yH8fGNGEBu8WhKzdWJM2t4i+ItO2ZAPX8RONneYExGkMRfZVmXDBlQkXSTUPqaNuS6VPWSBywU9aKYpsFzbH2gBJNphOwi1wcZ9Kz7v42jVoLt4fyTC6yhZsx43nGCXw6QYCQMDTVFTt/kunAX5x7HxAyJbZfF/ynqp4l9ahToWHoXgJ8Zo/w9uFpPJ7PcJOUHf4qXRvn7e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(1076003)(55236004)(8936002)(9686003)(6512007)(186003)(6506007)(5660300002)(86362001)(38070700005)(66476007)(66556008)(478600001)(54906003)(76116006)(316002)(66946007)(26005)(83380400001)(41300700001)(2906002)(82960400001)(33656002)(85182001)(122000001)(4326008)(6486002)(64756008)(71200400001)(66446008)(38100700002)(6916009)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2RaNTgrcmFja0NpclhRUWZjR2N4aExqdCtKaDRlUEkwTlk4VkprMEc0L0Nu?=
 =?utf-8?B?VFozMjlSYVlaTWN4UU5CbTZ0MEhUTXdsbmkxN3lOY0lUMFZKcDA2WVBzeDJR?=
 =?utf-8?B?L1pQcGZsbFRFTEJTZmYyMHhqMUN0SVFGbzZOa0xtT25nUERmQ251Rms3SUtq?=
 =?utf-8?B?eVlGcDJWaDduZVlzY0ZrTmVGYzYzTnVwcEdML1J4ZUN3dkhWUkgrc095bVRG?=
 =?utf-8?B?SHZXVDIyY1pHbG40MkY4ckdDRjJqalN5SVpVZ1Z2Ymxic0I5MkZaOUZMYVV6?=
 =?utf-8?B?K1dnWFU4dkVxVXVOeE1GUE1qLzd5V1ZRVVIxZHB3TEZ2bUtnWGpJbUU0ek1T?=
 =?utf-8?B?SXR2M1YrYzQrT1BJMHh0QlpNd1NaMjFMRmovOWdMeFhRcit5alEya0E2VkJ5?=
 =?utf-8?B?eW1XWlFteUJjNkNwTnp1NEh1Yk55anFBYkhnREM0SlZCTE9aV2FlVk1QNnJ1?=
 =?utf-8?B?eWRGNk9YMlBuWjdIMlF1Mmh5a3BFWXl3Mk10ZWhHZjd2aDFteUhjVzV1TVpn?=
 =?utf-8?B?QnJXcW0wOW53WE03Z3VZcEJIWHI4ZUlWSDdpenE0OHFWcy85dlIyZ09hT1dz?=
 =?utf-8?B?QjlSbkMvd0h2cXZaMDl6R0p1TkdDVnliR0dKSWVrTThWQmprby9oZEM0dUhk?=
 =?utf-8?B?TXpDQWh1bW5RbUt1VmFTSmpiU3JMdUVvY2tmaDNvSHJ6WnBEelpMRjBPN1ZO?=
 =?utf-8?B?R2YzZkRLVU12N3hPK3Y1VVZ5RlFiaVo4ZFZ4dC81M1ZYUWJLWGlGVG4rNUFL?=
 =?utf-8?B?SkFUZ0R1bXR1ZFBGcnBacGxzK3F6WVVqUnVLMGhPcnM5V0dlSmtUNFczRjdo?=
 =?utf-8?B?NGdYNEIxbytXWDZJWFJtUjN6cDFoUDVoRXZ6UXNRZkI0MUloZjNYQk1hUlJI?=
 =?utf-8?B?dGl5clgvYUpCWEtqNXVLWUxpMFIrdW5EVTNNL2VramYwSTNraGRBMUgzYXlZ?=
 =?utf-8?B?ZFhLS3l6akd2M0dYeHpraFJoQnRmUThTbWVCRGl4WEFQYUVtcWhXMkhteDI3?=
 =?utf-8?B?cGkxR2RiY3Rrcno0TmJ0cFNGWi9jamppL1pGOWJjTFZjQTY1d1pZck82aXpI?=
 =?utf-8?B?bzREMnlTd3hhWVpibkc0ZnArSUVsNURrUkpUYytDNFZJbmhJS2VleXFTTUJt?=
 =?utf-8?B?WE5iOUtKR0MzSEZ4a0ZOejlaZkwzTmdGR1FQZkc3RXpETjBHV2hPNXQ2UnVo?=
 =?utf-8?B?cVNSZ1FFU1BHdW5xV1o5dG03QXVIRENXck02eVV2VDZBRlZqYm1xdDlCK1Aw?=
 =?utf-8?B?bUJKUEJERk1idFI3LzNucUJFWG1XL1lVaytMZkdTeVRuTXl2MWlkc1JtSXNk?=
 =?utf-8?B?WGRMS0dnaGc2VHQvR3NKUW10Ry9xcEZtZ3hVM1lmb21HSVlZMTloYUdHSFph?=
 =?utf-8?B?bmlYV1FBS214ckM2VlZ3Ri8xNFl4RlJDZzBDR2E5NzZ6ZEpLSVJpOS9UcStY?=
 =?utf-8?B?THJvaGo4bmkyajNsMG1RaGJsYU41a0grcGluUVIwRTU0eFZydHQ4cW9qdTY3?=
 =?utf-8?B?NUdRT1hnV0FnbW5KNnYwTmFkbTdUWGlCS1NxM25WV0RkTkwwRis5cFMzTE5y?=
 =?utf-8?B?d1hHNTMrb3l3K0pKTlgzNkEyS2J1ZEhKZ05CdVRJZDRuUFBxUGFWaGxmNGsv?=
 =?utf-8?B?eWRzVmtYZFdVY3pkTjBOWG5XRUtvb1ZrdSs2bEZLTUNXQkhkVWlWNXA1MFo2?=
 =?utf-8?B?MXk2U3ZEZGNMS1QrUlRMT1FIK3R6VEZQYi9PK0w4bXkycVgzNTUxR21ZbHZT?=
 =?utf-8?B?V3VpQnJaU1JVS1hkS2F2ZmkzOVFOblJocmNGVkpKR0FqcnFhejgrak52cGln?=
 =?utf-8?B?UFoveDl0cHMrSHhTSFlCblFYbzhwemNoeHd3UG5hTmNPUGIzZS9KM055dFZM?=
 =?utf-8?B?TUp2NjZISWZTZ0lGd2dDRm5wd3NYL250Mm03ZmZvQjBYYTFZakpyTkIzbzlJ?=
 =?utf-8?B?VHNWTkRqMHo5ZWk3WmtLWktjNXpWU01ieFZKTi9MdVBXTUNlaExxNkxHaGR6?=
 =?utf-8?B?a3NFa2dVWkV4V3RPYVlDZjVvVkdhODN5bzRmeFdzSXRPV0lXVXpLT3ZJRU4r?=
 =?utf-8?B?bktlbWIwaW5zRHNZNWp5VmFqdG1FbWdXcVk5L2xOaDliR25WZ2NKSEwrM2U5?=
 =?utf-8?B?ZHZLa3NkZHNrbWxuTGNLWDMzWk1kWnRTcTc2QkpzZU5BZlVaUlFQckRyWm14?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95A538C8E0BB634E8CF9EE2D33CA7B68@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b25f77-cc33-4bbb-6cf5-08db31aa9cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 05:41:45.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLksWyHcu8Vkt1PtQMA95rTLZA1ehz9eSi6GnC8aEXeaGu846AfZ7ERY4QpIFJuxz6gwM8w9/s1L+3g6/HAdUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6284
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgMDM6NDU6MDBQTSArMDgwMCwgTG9uZ2xvbmcgWGlhIHdy
b3RlOg0KPiBUaGUgcGFnZV9hZGRyZXNzX2luX3ZtYSgpIGlzIHVzZWQgdG8gZmluZCB0aGUgdXNl
ciB2aXJ0dWFsIGFkZHJlc3Mgb2YgcGFnZQ0KPiBpbiBhZGRfdG9fa2lsbCgpLCBidXQgaXQgZG9l
c24ndCBzdXBwb3J0IGtzbSBkdWUgdG8gdGhlIGtzbSBwYWdlLT5pbmRleA0KPiB1bnVzYWJsZSwg
YWRkIGFuIGFkZHIgYXMgcGFyYW1ldGVyIHRvIGFkZF90b19raWxsKCksIGxldCdzIHRoZSBjYWxs
ZXIgdG8NCj4gcGFzcyBpdCwgYWxzbyByZW5hbWUgdGhlIGZ1bmN0aW9uIHRvIF9fYWRkX3RvX2tp
bGwoKSwgYW5kIGFkZGluZw0KPiBhZGRfdG9fa2lsbF9hbm9uX2ZpbGUoKSBmb3IgaGFuZGxpbmcg
YW5vbnltb3VzIHBhZ2VzIGFuZCBmaWxlIHBhZ2VzLA0KPiBhZGRpbmcgYWRkX3RvX2tpbGxfZnNk
YXgoKSBmb3IgaGFuZGxpbmcgZnNkYXggcGFnZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMb25n
bG9uZyBYaWEgPHhpYWxvbmdsb25nMUBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIG1tL21lbW9yeS1m
YWlsdXJlLmMgfCAyOSArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXggYTFl
ZGU3YmRjZTk1ZS4uOWNhMDU4ZjY1OTEyMSAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1
cmUuYw0KPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IEBAIC00MDUsOSArNDA1LDkgQEAg
c3RhdGljIHVuc2lnbmVkIGxvbmcgZGV2X3BhZ2VtYXBfbWFwcGluZ19zaGlmdChzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSwNCj4gICAqIHBhZ2UtPm1hcHBpbmcgYXJlIHN1ZmZpY2llbnQgZm9y
IG1hcHBpbmcgdGhlIHBhZ2UgYmFjayB0byBpdHMNCj4gICAqIGNvcnJlc3BvbmRpbmcgdXNlciB2
aXJ0dWFsIGFkZHJlc3MuDQo+ICAgKi8NCj4gLXN0YXRpYyB2b2lkIGFkZF90b19raWxsKHN0cnVj
dCB0YXNrX3N0cnVjdCAqdHNrLCBzdHJ1Y3QgcGFnZSAqcCwNCj4gLQkJCXBnb2ZmX3QgZnNkYXhf
cGdvZmYsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPiAtCQkJc3RydWN0IGxpc3RfaGVh
ZCAqdG9fa2lsbCkNCj4gK3N0YXRpYyB2b2lkIF9fYWRkX3RvX2tpbGwoc3RydWN0IHRhc2tfc3Ry
dWN0ICp0c2ssIHN0cnVjdCBwYWdlICpwLA0KPiArCQkJICBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSwgc3RydWN0IGxpc3RfaGVhZCAqdG9fa2lsbCwNCj4gKwkJCSAgdW5zaWduZWQgbG9uZyBh
ZGRyLCBwZ29mZl90IGZzZGF4X3Bnb2ZmKQ0KDQpIaSwgTG9uZ2xvbmcsDQoNClRoZSBuZXcgYXJn
dW1lbnQgYWRkciBzZWVtcyB0byBiZSB1c2VkIG9ubHkgZnJvbSBhZGRfdG9fa2lsbF9rc20oKSwN
CnNvIHlvdSBjYW4gbmFtZSB0aGUgYXJndW1lbnQgYXMgc3VjaCAobGlrZSBrc21fYWRkciksIGFz
IHdlIGRvDQpmb3IgZnNkYXhfcGdvZmYgKHdoaWNoIGlzIGNsZWFyIHRvIGJlIHVzZWQgb25seSBm
b3IgZnNkYXgpPw0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
