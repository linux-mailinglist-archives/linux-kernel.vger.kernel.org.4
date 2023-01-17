Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470266DFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjAQOBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAQOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:01:30 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037538B7D;
        Tue, 17 Jan 2023 06:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DveMGMsecYHE+/yRowY7mZBF3e0wKrbekHTQsYAdGq/T81UTbt6VduqGxXCoaKzmnwnGGyfBS6bXh7jFi8Yd5X/ynzdlc+MCA+Hp0X10ZYXBmuUvJMVxlIHgduxOhoigzxx6Af+4eR6fENUhMa3GhH6n/3ypzI7JY0KOXw/qB7AB61GsHQI/cb0f+vCMaYSlzrifjHkyonWcuTUxEZzXl/fFNFTy1DcNdhlkzBFYA+svIkjf1oB6gmThqiGqPZnlxPjflIboQ/25ST9ixNrdHWVeyZX29c+WFfN5/bREOtzP1iFUjhb/jPSAKdoVBgHL53O5Syx2mUhhPp6AFtLutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiKQYPNi90ZZJ1kwPRtjwN31GpCp49qJ1RrZSiFOSUc=;
 b=O9l353DhQW+0CGl1F04WnpHa/u+WohR6ly4JYSesgS1jujiwrgBhQtFfLX3TX0K7nqBJ6jmsfO4MfhHk/gwffpLmPa1qqJch2g5owg6CZ6uLkP3lT79sF9z+QelDRywpzS2teYYZU0WMWtUfLj9vvIG5+LieJmV6TL54acWIrpVRCwFOLL+vxLyUoMcypZJxbw/FEa9FQxC29W6tz6ArmET0iZrKITZr7XhLs1xO6aAb0ylNMopGQArEK9KP+AQ8UxgsLtzuaZ7NZ0HWY+pYJt9pNZmsZvI+tItYeyhtbWGRq4T10G9UZ5kIu2QIAlUrRMOt4r/HxVgDyqqcqGxuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiKQYPNi90ZZJ1kwPRtjwN31GpCp49qJ1RrZSiFOSUc=;
 b=siamYYwufa+2Oe9opeYWgNwvsrFZPPnLuw47uCllV1xuYY6dGQcf8zx10pUkmesIh/CvDkcaMANaskTCcKxqT8unK01nX0tJskN+d4ygdWn5Rm34QlLUGra5OujDLrfncmz6Pb+G8pbZUGPI39/WjNEGcVB79B7oufua3Rf3TAc=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 14:01:25 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 14:01:25 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] gpio: vf610: Support building gpio-vf610 driver as
 module
Thread-Topic: [PATCH 2/2] gpio: vf610: Support building gpio-vf610 driver as
 module
Thread-Index: AQHZFFHE+TqZaCNrb0O4Jmc0Jmu/F66EJgMAgB6nWUA=
Date:   Tue, 17 Jan 2023 14:01:25 +0000
Message-ID: <DB7PR04MB4010B71F54175CD7C73C3FC490C69@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221220090248.1134214-1-haibo.chen@nxp.com>
 <20221220090248.1134214-2-haibo.chen@nxp.com>
 <CACRpkdaPQODoiG+ARAiT-6X2u6n7_aCO7Ywj4z=76A65iUhTpA@mail.gmail.com>
In-Reply-To: <CACRpkdaPQODoiG+ARAiT-6X2u6n7_aCO7Ywj4z=76A65iUhTpA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM9PR04MB7540:EE_
x-ms-office365-filtering-correlation-id: 4387a2e5-bb2b-446c-bae8-08daf893529a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKkrp+FPMHphPqnCyClpiqRZpRfNpc84ijpPwJpJtffaBYG9rvxVJpUFguYwaZM1OhUPI+Bvua3lH5I5z5IlK6thj4wTNDEHGWwUR8RbMZg4gT97OZsGrSpbNjLRK4d1CK4kk8D3jqZ1C3ZwtT+1MGQjFYQO1UgjKprd1Ka5sNJSoj/DQB0tTXrDaATHRzqRT+c9tJN17n6PAy2uHLKSRBZ4r8Djd3J8LG+5N4F02rYVyMrj0ZZV//9XHahrN2T/Hhy7/ln/hC/xCKz1DDSlULzyixS8wSKpw9VDZpeK30pjjAJKF4D7B3FG4P0FqR1NMBx8CVsRDRzMyB3b2Xzij6dUlFBVobcY8aLczVnbx/lZ4MV0SpNjE7b8mGc2tttOqqe4WuQ+5XE9mVvj7gk4PBeBrukSXLVxfFAd9+BpszKKYnlyRlxuOWpD5bhWDpv6randO5m6fjXjTbY3DP8s3jPLvB8tXr3+K1BCVnXk/CCyjwgUYL+7bRhLnSzuzTQF2gaBWWvgIMqlG6uoDUlCpa3bg+6eqhtvsj1/eoPtiGsFF07+YvkqDaBN3r8eBaXw64kNtAhbZeWP9kAlmoypt4NbGDoslpr4gqxXj5t11g5a+g7nn59xRzVY2Z+6noBcX20fV02scb/SuGniJXohBgjEdM/yGFjYhhpdFasmUT/F0OHsl5JTJ9t7oxTIVIY5nvB2FMh7vcJ+ewlZFzZPqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(86362001)(33656002)(64756008)(6916009)(53546011)(186003)(4326008)(8676002)(76116006)(66946007)(66446008)(66556008)(26005)(9686003)(41300700001)(66476007)(83380400001)(6506007)(316002)(7696005)(54906003)(478600001)(122000001)(2906002)(38100700002)(38070700005)(71200400001)(52536014)(5660300002)(8936002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTNlb1Q4Z0tJaHdpNjVzWFVzU3NJNE9Yc3NhVFhuVTVZNHZ2R3ZRWlY3ZWVF?=
 =?utf-8?B?YnhxV3JDakFJNTF1OVlmd1AzdUZHZk1IME1RZkVpYnRoMDd5M2J2NXNwUkpu?=
 =?utf-8?B?VmExcHBqMGYvbzFiQnA4WjY0QzZtUjd4c3U5cW5OaDhsSnFVWkw4TnZOR0kx?=
 =?utf-8?B?NG9YK2ZFOUh1TXpSdUtlN3BpVGg0ZFlqcTZ6TkRiaDkrWngvTkJWVU5qQkh3?=
 =?utf-8?B?WFNtaFFqeVBoWEtFWU43WWlLRzlHaXE5ekhFdDBtQ0NJNzM3RDZ6UzE5Y1pI?=
 =?utf-8?B?QjMzVGxseXJ3WTlMWDRNakFvbHJTNmM1MDFDU0F1Y25LYWNFNVoxZ09NMEpa?=
 =?utf-8?B?ZklrSi8vakc0anZmbWc0TWdwWmNhNDNSQ2I2VGtsSzRsWnVjRUM1SWhaQUdN?=
 =?utf-8?B?TjNVZlVoczlFek1ZUWpSc0lWMVRudE9ESGVMRUE5MFA5b2RZQkZITzcydElj?=
 =?utf-8?B?dXNxa1IzdENRdFhzd3pLTWU0TENkNFNaRWUzYjB2Y0k4QjZZNk01OFozc2Y4?=
 =?utf-8?B?MEN3YWxrTVhMSzBjTGx3MFh0QjdsbTBHRDVSbFVPVzRJVXFSenZnVXU5R0gy?=
 =?utf-8?B?dHhPUU9KSXU4Rkt1blNyUEJYMHZSeUtRWjZ4Q1BvdWxLeTc5U1E5dzg5YXZP?=
 =?utf-8?B?SFUxU0pZc3lhVTdxYWpOdkY2VitEUWZrQnkyYkF3dHh3UmxpY3lIb211bjZ1?=
 =?utf-8?B?TlVZT1NKcWxIdCt1UnU0U1E2SFJPYU95VW5lRVZSOTUxekJFaVhDZ2FRLzFO?=
 =?utf-8?B?ZWJMYWEyNUR3a0llcEdIT0Q3anpPRjVxd1BWT0Z3U2hrZmhsUW1VNUcvdHl5?=
 =?utf-8?B?bW1zUFVhNExkakh3QzV2VEpPRWNjMHdwZjFFNG5OT0JqcTlxdjVRWTgxeE5m?=
 =?utf-8?B?a2F6TWFNZ0NkUXBZdytVbEJTRTJVcmkvSTJ3WCtaOVdmSnVlYVUvaVZaWk1J?=
 =?utf-8?B?a2tMSVRyUllnVFdaaXlTYUFVa3JKSk4yV2xyWHAxeEEvNitIbFNMZldBdFdm?=
 =?utf-8?B?NXRGWEp4QkRpRjNsT0piRVJ1RFR0TnZkM1JQbFNnQWV6aWtBMTlrejZzNEdv?=
 =?utf-8?B?bklMdTFpUnhQL3lmZmIyNGgxZFdsc2VWbmtDOFUyaE50SjhySUlHQTZrc1VG?=
 =?utf-8?B?SGFPOFRpSzRDQTdMc2RUYnN1bHRIdlVoL0RsVHU2UDR0bFIwOTRJRzlXa2hY?=
 =?utf-8?B?Y3I2ZUdwVEdXTjV0emgrT2VCKytLZXl6a1NwMzNqQ2hpYWhEcU1YbU9yN2ly?=
 =?utf-8?B?bkFUamd6MU1EK0g0UHFHckpNL2UyYWxXYytFaDczVkVUZUg1U29acWUzenpv?=
 =?utf-8?B?NTcwZUlUSE9uS3d1a1liREFWM0FycGZyMThJT1lTL21KN2xlTTVWNzF4dFh2?=
 =?utf-8?B?Umd5ZkJXMk5PYlBYUmpNRDhQYUwxMWdOdDNvWWE1Y0VwRnFEYmwrYWEyTGpy?=
 =?utf-8?B?eU16QkFiTGxhY3BWS0ZzdXJBMXkyenFaQXo2TjhNRHBUZFNCVmE0Wkljc25p?=
 =?utf-8?B?RkFVQ1o5SEl2L0hrcUpHaFFENFFLQVpEWnBLc0dyR3cvUjBqTzZ3dW01WFFC?=
 =?utf-8?B?cjErU3RXOTFBOTRsSU9ISkRtbU9IOEF4ZHFqRXlxWEpJUnV3S3hPRzdtbmtE?=
 =?utf-8?B?Zkd0RWpJQS9GRjFOOVN3WEdtcENBMndpVHpxQy9yUWdEeW9QN24rSmlkbUM4?=
 =?utf-8?B?WmJlNllsZ1ZyYmlabHAvSE5lOXFndE10OFNaS0dvVUlKanMvcW04Qkd5ODlD?=
 =?utf-8?B?bnVaMTVORVVJTDkrMU5wTnRRUDQzM0JreFVoTWpwalNBa1dpbVc5U05lRDN0?=
 =?utf-8?B?Nk4vOEJuQlhKdHYyTmE5K2xkZ1Y5a00xNEtoMnB1T0FrY290cmQ0VU9vNEFo?=
 =?utf-8?B?cFRoUEZlWWZCU2ZqRUZqT3V3Ym5vN0U5aHBhdlZGNTJRMmpoV3VsbHYySkpB?=
 =?utf-8?B?SThmYnNVQTZraTQ0LzhocFM3M0VpcHhydFVxTFZ0YlFNRzQ1Q3lBT2k5WkdO?=
 =?utf-8?B?K3R3cGlWYjhnRGdVUmlwZzNobHNpQWhYUVJUVEVQQmx4MHM0WDREa3hpWDJQ?=
 =?utf-8?B?K2g2djVJSlIxSVl6NjJJMVYzZ1pGR1RUYWpVdGZ5V1M2aEFkMzIwZVgxaHNk?=
 =?utf-8?Q?mqCDq8wKnXn6vNXdlpi99bR/4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4387a2e5-bb2b-446c-bae8-08daf893529a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 14:01:25.5474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gq6h/zBU2yS7duP1ezOqtg54Dpw33bd/wZ8bVUFb13Z8PxHrX7oLxr+iKg97On96xxdNVzUAt4sBEcNlq/XWoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjLlubQxMuaciDI55pelIDk6NDYNCj4g
VG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGJyZ2xAYmdkZXYucGw7
IHN0ZWZhbkBhZ25lci5jaDsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlt
eA0KPiA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBncGlvOiB2ZjYxMDogU3VwcG9ydCBidWlsZGluZyBn
cGlvLXZmNjEwIGRyaXZlciBhcw0KPiBtb2R1bGUNCj4gDQo+IE9uIFR1ZSwgRGVjIDIwLCAyMDIy
IGF0IDEwOjAyIEFNIDxoYWliby5jaGVuQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBI
YWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBUbyBzdXBwb3J0IEFuZHJv
aWQgR0tJLCBuZWVkIHRvIGJ1aWxkIHRoaXMgZHJpdmVyIGFzIG1vZHVsZS4NCj4gPiBTbyBjaGFu
Z2UgdGhlIGNvbmZpZyBhcyB0cmlzdGF0ZSB0eXBlLCBhbmQgYWRkIG1vZHVsZSBsaWNlbnNlLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmluZG9uZyBZdWUgPGppbmRvbmcueXVlQG54cC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiAN
Cj4gT0suLi4NCj4gDQo+ID4gIGJ1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKHZmNjEwX2dwaW9fZHJp
dmVyKTsNCj4gDQo+IFRoZW4geW91IHdhbnQgc29tZXRoaW5nIGxpa2UgbW9kdWxlX3BsYXRmb3Jt
X2RyaXZlcigpIGhlcmUuDQoNCkhpIExpbnVzLA0KDQpIZXJlLCB0aG91Z2ggbmVlZCB0byBidWls
ZCB0aGlzIGdwaW8gZHJpdmVyIGFzIG1vZHVsZSBkdWUgdG8gdGhlIEFuZHJvaWQgR0tJLCBidXQg
d2UgZG8gbm90IHJlYWxseSBuZWVkIHRvIA0Kcm1tb2QvdW5iaW5kIHRoaXMgZHJpdmVyLCBzbyBk
byBub3QgbmVlZCB0byBpbXBsZW1lbnQgdGhlIF9leGl0IG9yIHJlbW92ZSBjYWxsYmFjay4gDQpJ
biB0aGlzIGNhc2UsIHN0aWxsIG5lZWQgdG8gY2hhbmdlIHRvIG1vZHVsZV9wbGF0Zm9ybV9kcml2
ZXIoKT8gDQpJZiBzbywgYWZ0ZXIgdXNlIHRoZSBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyKCksIGlz
IGl0IG9rYXkgdG8gbm90IGltcGxlbWVudCB0aGUgX19leGl0IC9yZW1vdmUgY2FsbGJhY2s/DQoN
CkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoN
Cg==
