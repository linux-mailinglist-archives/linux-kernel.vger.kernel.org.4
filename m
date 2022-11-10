Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118CE62413C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiKJLSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKJLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:18:05 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCAD6F37E;
        Thu, 10 Nov 2022 03:18:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhI3Db1q6qotfkbOt7ea2knoPJ6D7YYpjkPFPmBGPBfyPiyfavULMN77e/SMyrE3wFgejXoTKl4ma6+qO+7x8swJIV/IxImRi7Iw0V/t6znB0cp/O1Za/UzsKHgopV/N6sfQeO5ouXz1g8h70xEOD/tYpNGEqX/ygnrNMsEgBCB2QycEGhinOwZWmb3AUjtv+6nzpJJNOrUxBdzDWI3ft3+K1VJuh495LpCLV1OZiqDEDFzhQXVGvoaYKIZ/Li4y9CKvdbwAru6A6ShAjz2lRuMMESQ2+hFpFmoNExWL65fnC12Aqr41Hyz35z3+rbkQUB7aFfm3P2L0cwiJZuH7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwczaVuTaZI7TmYI7ucJkuJDkJWzLs/7MKo70fhTUsE=;
 b=efzzE5I/+xasdL+cXCM5E8rbrV3hERYua8t4PEah4YzAz4VwoS3XrfZoQ84Snlcsg1K4bcP5NBi/RXQVvHiTFujnYaMUsZ0RRPeMj3wjN/y4opI8g4fCAfWXHa3ASRNOMkHwy6RslVbsbhJLRZNgLgSW2oKo4FhDjesRI25hQXzxEzAF6AJrq03qEktXDAOHE4z9f/VNZqykUJqHuUULQO+sL4lx3IlPLZbd2icPKU0KK+1pcyudowZGxY+SWccm1oiF0a8g1xcVesGBQnWT0otl4vyD0pumV+fBFIWr7uTHtc8mPRxSAzsfUw+6/bbGodz1pYREijJJREQiOBTS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwczaVuTaZI7TmYI7ucJkuJDkJWzLs/7MKo70fhTUsE=;
 b=iIyA2HmGf0HGERm8/5+1Ln+RvJQ8iK+98XjOjrj6eN4f3Dyty1kl0fUUzXV/NihptNqds0rFf4hQs+Gj4iohsbFTaTZTa/bV0feegOY72/ZQOaCjTUAJ92az8AIlVNr7VOHFLFIfQ1hRwVKBTyk49f6xM2AmIdmJAHgTv67AzcM=
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by VI1PR04MB6893.eurprd04.prod.outlook.com (2603:10a6:803:133::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 11:18:00 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::2a4f:4339:4af0:f901]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::2a4f:4339:4af0:f901%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 11:18:00 +0000
From:   Andrei Stefanescu <andrei.stefanescu@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chester Lin <clin@suse.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dl-S32 <S32@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Thread-Topic: [PATCH 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Thread-Index: AQHY9PYXG39bmzC7cUykOHTCPV1jaw==
Date:   Thu, 10 Nov 2022 11:18:00 +0000
Message-ID: <AM9PR04MB8487997B859BFC9ED36D4E59E3019@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20221031100843.14579-1-clin@suse.com>
 <20221031100843.14579-2-clin@suse.com>
 <CACRpkdY-uaQ--vFM+vVPbwa-q9nbSU0rQB+qbL=9m0wVMwA3Aw@mail.gmail.com>
 <Y2vZJaoWThP2aipE@linux-8mug>
 <CACRpkdbW=WMA-9OkJgBoBov7ewGMN_Coy=KOQfS_uwzHNsuGwA@mail.gmail.com>
In-Reply-To: <CACRpkdbW=WMA-9OkJgBoBov7ewGMN_Coy=KOQfS_uwzHNsuGwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|VI1PR04MB6893:EE_
x-ms-office365-filtering-correlation-id: 0b9d80c9-b5ce-460d-3230-08dac30d3a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fs9CfW8ogQb3bUVoGYIA3niuH+H+rpoBmuJp0jQFfSn86SiRJImxxJC5Wv87JZr0wfa9b+yHa+z2DUjBecbQwZ9p/A81ri2qjMqiwtVgceMw67VJ3hhJD95rsLpyXC0N+kmzc82NX+mUAwqtkp8Kl+LFjnPbml23AXdR2CC1pcovvirzfldLl4/E/gDAI50Q3RqASdNy7HA/W5PxPWAeBhWKGDwjvTlICyUhrFnuXM9iCdzBrB4kCsQo4MiXu/Dqn7KXk4dFTRuiv4yhEN19HoWkqS1ZRNL1j/PCuHpX8414sKwU8jCvds8doN+HZFPxpHBc5MADbEYtIc3GxTf7xJO6iYgLr2SiG87GnE35DwJddwoMMwQmwoEajQv8zKMRS3YZuNDZVkuFkYqBbpjiW7ZTHiTXKrUhSxHfJDDweCLs+qVSoclOmS3RD9wt4Y6uesMu8HkczwJ6JJ4RZPPozZKW9OfDBvxz9nzpmxkfHh7o1MukAR2Ti+aYUNxPVtLYbtsew1SlaDAkOezSMr6d9dk5HWWPtJMGPw9q1PBJZFwb9VKCLXJXqYOK62UB8y6yodkueKwouyv0G1CtvLWw1S+7JI+iKD6ivOyq4Ckj9cFVPAZXHU8FQW+6ngzaMmXqghgWELgYtl5Khq8h6khVbBDNm3Dq6uuNojgFqk3kLigbautKaTZAi0VRiPNHQzlGABwJgKoD+tVoLmZygw59V1clhNOoaInO8vj/Viz1Ssg1wGUuvw+nnNlocJIyJpDtDRKAAaMVGBcIYhCudA9t4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8487.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(86362001)(83380400001)(478600001)(122000001)(33656002)(55016003)(38070700005)(71200400001)(66946007)(4326008)(5660300002)(7416002)(8936002)(8676002)(316002)(54906003)(66446008)(66476007)(64756008)(66556008)(110136005)(41300700001)(38100700002)(9686003)(186003)(4744005)(2906002)(7696005)(26005)(44832011)(6506007)(76116006)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEljdTI4L01EWjRXUS9aUTh2RUtJUDhLR0ozMjloY0c1UEpGNlRJNVA1dVFq?=
 =?utf-8?B?c3FLbzBlS1NNMnhQV2x4bm9YV0UvM1VqYUQ3THZLTW5sVXVlOVFPYUZVcHBX?=
 =?utf-8?B?MmlMUEZsRDVWV2s1WlBRNXNST0cxQ0xNaVU5NXNCcTlKWFVLeHZYRlAwYzFw?=
 =?utf-8?B?SVY0OEh1UmxNQy8vb1ErRUw2QUdyTURDRGFCR2xCRmRkeFlXbi94b3Q3cnZo?=
 =?utf-8?B?QzFnWnBlaHVhelMrSmlOanpKTVgzKzVGZEpNczVnamFoS2VOSG9UNDRldzNr?=
 =?utf-8?B?QlhqeUQvOTdscmxGNlNPVjVMRERzVW9sMWN2ZjRvSC9McC9RcHJ3QUhuTGpP?=
 =?utf-8?B?SE1uUTl5TkR6R0dtLzlmZ25ScHZadTAzZkRuWWJwTEpoNXRLZSsveFZSd0x3?=
 =?utf-8?B?cWxGR08zNlhpcGRhRzZKMkYweEVsbllTb3VFL0RVTmxDZVRGQUZvTWxJcGIv?=
 =?utf-8?B?TzVuSFhWRVk2UHBHbjJHdnZHRXV5QkFvRk1FY2praG11cTBleTBwZVVxMHRl?=
 =?utf-8?B?ak5DYXZOVlZ6ZlIrdSs2OEZlQ0d1dlg1dG5GVFFFRGJ2d0c3QUNCQ0N5R1Er?=
 =?utf-8?B?QVhBTzJIOTMraXpIRUM1cnNLeldpRm1sbm1KZjRWZ1FmWTlPRVBNYTBhSk1G?=
 =?utf-8?B?NGlFNmRKN1kyOTFsOWdpd295b1Npb1VPdmlyelVlSWVrMTVRZlc1Mm85aHBV?=
 =?utf-8?B?emxFcjJFWkhGT25rQnpteW5ZcmJ2dTAvbkE0T09OQzFmYXNCclQ2WTRsbEFh?=
 =?utf-8?B?L3RycFM3OXQ2MVFDYkVhSGZ2dzd4ci9wZWRtN3NCWWg0eENlMGtLeTZQRVh6?=
 =?utf-8?B?VHNnR0tQZmdxZnRIOGt3U3B4VzR4RW9JY1pIenFybGJUR296Wk5DejJ4bkhn?=
 =?utf-8?B?WUdGNU12bG5PTkpLQUxyazBLY0d0N0YyTkhkS05PcDJhZEpvSVNuQ3dLT1JV?=
 =?utf-8?B?L1pIOVJJSWg5alBIdE1oUGs3WXVMTUhZQlRtMjdrd0FUMVFPM3Rnc29vR0Zz?=
 =?utf-8?B?NjRRd1FqMUZXM2p4cGQySWZ4K3JBUGFTNys4MkV0Uk04c3M5TTdjOWIzWmZF?=
 =?utf-8?B?WmxjVE1ldXFEYUcrWkFiSkUxcDV0WmRURDNUSmhFT3E2ZGRTdmRPdC8yaHpC?=
 =?utf-8?B?Nm9oMUdIOTlWUFdQMFZVTUNtNmg4M0Q3QTc3bmkzWTBITXh3cktEU2RBek1y?=
 =?utf-8?B?ZUp6TWZ2d3pkaG1aSVVWUGE5U25pUjJyTUVaclE5UFBYalhKNCszZWxydEZ5?=
 =?utf-8?B?MUVUY1NpeWRzL0c2WmhJcGRYL1U2OElvRm1XK295dzk5N0ZOcm9BNTVaUzkz?=
 =?utf-8?B?VE0xb21VZnVFeUZvRUxxNzhPR3pqVWNZSVhGK2d2Mm82U2NDM3VKaUhIMUth?=
 =?utf-8?B?ZzZqdEpNaWl1Mjc0UGs0ZitxQUhHM3NWNHRWYTc3UW5sYlhvcXJtU0pCQ2Vu?=
 =?utf-8?B?MXdNajIvY05MY0lVWHh0UFFJMFBDWllVSXVjbStlRmpFQ2xhMnZiYlFVNU5E?=
 =?utf-8?B?S1IwV0R6MCs4VVRoZUJIL3I3VEsvdHlLdDV2TFZUOU1kdFVJT0lrbThpckIw?=
 =?utf-8?B?OTExd3dQdFpHVE1VWlkyRTJ4dCtSYVgyRVJ2WFVoTVJFUk0xVGxvLzFTb0Qy?=
 =?utf-8?B?K0RjV3VHcjlOZWExSjJNQmpWWFJvRVlEU0poVWR0bXhVSldxMEw3SHIyTEt0?=
 =?utf-8?B?TjN3MmpGOWx0QlZ2Q1VvbXpLT1NaSG15SVd4Y2Y4cVlGb3BJbDAwMTI1RElN?=
 =?utf-8?B?RDNuWm1uREdtcENpYUwzMllsZ3Z1aDF6cjMzYmZ2azI3ZmVoNmp2MGNjSTNR?=
 =?utf-8?B?Q2hrQjJBVGZmY2dSenVKSVhzdzVOeENrRys0em0xMGw3NlFLMGRQUjBpbEFn?=
 =?utf-8?B?MEgvL1hjeEZUVGRmbklKRWlmSkhERGtZL0xoa2dCN1VjcS9CSWFwQVJmdjY1?=
 =?utf-8?B?ckZBcTlwRnNDY2xick16aVBHNEM0cmlERnhmcHo5cnFsWHBjV1AzWlQ3MnA1?=
 =?utf-8?B?ZmxmeHVUMTRWQ3JMWjZoK1J0d3hMazRPT0dUNzhKRUNSNkc5UFB6QmJkbWZE?=
 =?utf-8?B?dGh4ME0weUVQZXZFYTBXVmhyY0VtT2xlTFY5Um1DSitpSy9lTmdjNjYrZ0Jy?=
 =?utf-8?B?OFhncDMwUHQzZzVYTi9UWitTOTU1NXR6d1c0SDNZck5nU3o1WkJpaElveElV?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9d80c9-b5ce-460d-3230-08dac30d3a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 11:18:00.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IS8PtBuDqqbtx70O64iEXaKGImkuxkr6A3emPlxupPTgpZsuSUOkQfd5DAjndoAEbbEGpzpeVDzh25VjiDbh2nCWIYK6TSkbIT1uOpOzYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6893
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hlc3RlciBhbmQgTGludXMsDQoNCj4gPiA+IElmIHlvdSBoYXZlIHRoZSBjb21wYXRpYmxl
LCBzdXJlbHkgeW91IGtub3cgdGhlc2UgaW5kZXhlcyBmcm9tIHRoYXQgDQo+ID4gPiBjb21wYXRp
YmxlIHN0cmluZz8NCj4gPg0KPiA+IFRoZSBueHAscGlucyBwcm9wZXJ0eSBpcyBtb3JlIGxpa2Ug
YSBjb21tb24gbGFuZ3VhZ2UgdGhhdCBib3RoIGtlcm5lbCANCj4gPiBhbmQgdS1ib290IGNhbiBz
aGFyZSB3aXRoLiBPZiBjb3Vyc2UgaGFyZGNvZGluZyBpbmRleGVzIGNhbiBiZSANCj4gPiBhY2hp
ZXZlZCBhcyB3ZWxsIGJ1dCB0aGF0IGFsc28gbWVhbnMgdGhlIGluZGV4IG1hdHJpY2VzIGluIGJv
dGgga2VybmVsIA0KPiA+IGRyaXZlciBhbmQgdS1ib290IGRyaXZlciBtdXN0IGJlIHJldmlzZWQg
YW5kIHN5bmNocm9uaXplZCBpZiBuZXcgDQo+ID4gYm9hcmRzIG1heSBoYXZlIGRpZmZlcmVudCBy
ZWcgYW5kIG54cCxwaW5zLg0KPiANCj4gSXMgaXQgbmV3ICpCT0FSRFMqIHRoYXQgbmVlZCBhIG5l
dyB0YWJsZSByZWFsbHkgb3IgbmV3ICpTT0M6cyo/DQo+IA0KPiBJIHdhcyB1bmRlciB0aGUgaW1w
cmVzc2lvbiB0aGF0IHRoaXMgaXMgcGVyLXNvYyBhbmQgdGhlbiBpdCBjYW4gYmUgZGVyaXZlZCBm
cm9tIHRoZSBjb21wYXRpYmxlIHN0cmluZyBhbmQgc2hvdWxkIGJlIGluIHRoZSBkcml2ZXIuDQoN
ClllcywgdGhlICJueHAscGlucyIgcHJvcGVydHkgb25seSBkZXBlbmRzIG9uIHRoZSBTb0MuIEl0
IHdpbGwgbm90IGNoYW5nZSBmcm9tIGJvYXJkIHRvIGJvYXJkKGJvYXJkcyB1c2luZyB0aGUgc2Ft
ZSBTb0MpLiBJdCBjYW4gYmUgZGVyaXZlZCBmcm9tIHRoZSBjb21wYXRpYmxlIHN0cmluZy4NCg0K
QmVzdCByZWdhcmRzLA0KQW5kcmVpDQo=
