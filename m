Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99026740458
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjF0ULX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjF0ULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:11:14 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2098.outbound.protection.outlook.com [40.107.114.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C6026B3;
        Tue, 27 Jun 2023 13:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7rNiKQ20fhfl4y4jY+IzA83yoP4esoN1maCJAm6Q7VO/40XTfxGaHLiQyPd8qFSPEohF2GRzvUGsiLwwtgeKATfc2+OFL97yGGk9HtZQl1y6AOBqeyDGw2LLEochhhph/5gZnx2MjcTEdTSqd54GShZH36FvwbaTtN5wx32xR6DbZUwh/6kcb4WjQyByxC9zetNcAnSQiGqLW6qh3rGsemf9MK8sKENl87OWLtPEUcQ3C5z3w6uPq6PtVeSjuHpy8Kdfu881iDvRch69dW0WLRAvY0iJzPJAg/4EsW32PYUoHF0S9dX5gyRdL9NeNOUiYz2ICI+mpCuJ79ltajX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAyUm1LchO4du2S5XIgNOSaWEoYMYGVtefBlNcTmEyI=;
 b=bc+bq/DqOxinBLNQDKn8BxhyX05CdfLWo7vqlGs6rojxVZTJcFbbD2SnerswBqTCZWok5Pe2OI1AV/8MOxkAYmYSB0i6PGjmjDdgtdkJtz77pzrmagImYB28Y2NT9Yh5MuAOQpYFW9W3OFPWQIyA20Yn2ZtZpzz4VrXQJEn4r4x2TcvtSYWLvACGJWFwGGsRgfMpZluq4Mi6WUKMdUZ+1Ej+P3oIuPNMU2ym5myrUMVnKgkXRT2rjsZSsppT//mhQkmsedjhUobwkttrhaxgO3gE9wW3i+PEBwMjaUe1y/z0hLMvZig0TRIU2iHQReQSnCWoz4Mefs3/yXWda/mJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAyUm1LchO4du2S5XIgNOSaWEoYMYGVtefBlNcTmEyI=;
 b=i+OM11EcuRE+FfMzzdI+gOjd0oO/Nf7x/FvK/x7mAXds2zVw3qpHvUIJ0bQr7vi050ApsyMnfxfzvBRKLF/c0L9ocYz2yvSR1K1xhPuapxQn4jODEtkASS52//RPm6RiiCEFeKrltB+Ht7JPbGBABP9STPb52AebcfZ9DG3y5A4=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5553.jpnprd01.prod.outlook.com (2603:1096:604:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:11:08 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:11:08 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 6.3 000/199] 6.3.10-rc1 review
Thread-Topic: [PATCH 6.3 000/199] 6.3.10-rc1 review
Thread-Index: AQHZqFpOA4Fdc7/o7UqSZBE09tfpVa+fD85A
Date:   Tue, 27 Jun 2023 20:11:08 +0000
Message-ID: <TY2PR01MB3788271304EED2E66B0C24E3B727A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230626180805.643662628@linuxfoundation.org>
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5553:EE_
x-ms-office365-filtering-correlation-id: 29a9db44-f74f-40b3-df20-08db774aa557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Ktnr1TW7/rZ9U/ZM1XAYKEA5IV1YPGjTeMJa1udIsJPdyljqC5iruRHs5j77gTYTZvH01TeJofiY5g6MLLdhOmNRw+Ml1t/RiktfJXnanqq8I18mZ3+MTmYs88Rvi6xb+y1uk1MDP8vHOkQK+uLzw3peJou3J4b9XdMMTIfEWSKDpFVn/9TIua/LT30VyeRfs2HGVdzidEzDix5Ck8f2zGRqhHgTYw7TcJEOQJyX6cGz4bT7i8f6fQB14stMwW2M13lowbZHpR9JGBcHq4U8J750qeV9wIfwfodlFGtNbWhRMrTYoQB2QPavBdhn+GNEXXz3VY7XTEmeGZ4eXwxtoN0d5sDKuPi/m0pgpFx+DP23M5KAWgpusIesbtMITU3o3N/JMntC1Qq/RiDNJ2e/RiTgyNhid0JMmXlYnM8Uoi/Whx58F3Mu0TtIPYUaKa1IP7Fz+m4UaT+qdhCWSR6Sv1FvwEb+75vMO9ZxfIJgjwlvyYMNwJkoovOVC29WzugceCk3DtWpGEJU6OUwrd9Pp9AVXBAdIEfrkqYDwf4DnMTaGqiPM17eawJ2LUc7U2OCsRsmtpNwXKgGwGkdFSUtVOTceCVXaUB8zo/9yEzPN9nwjQmXL7pYeqNQXaZTwphSwy3bTb9cFzSQ4/uVJSQjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(8676002)(8936002)(55016003)(76116006)(66946007)(66556008)(66446008)(316002)(64756008)(66476007)(9686003)(4326008)(4744005)(6506007)(186003)(26005)(110136005)(7696005)(54906003)(966005)(41300700001)(71200400001)(2906002)(52536014)(5660300002)(7416002)(478600001)(38070700005)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0g3UFljTUdIeGxLeTAwMVB0UURncFd6Uk5KeEFiTEpCUFZBSHkxb0V6THFj?=
 =?utf-8?B?ZmljR3cyclJkMUU1SVYvYVFzQ2grQlZKeWFKQzhXbjd5OFBNNEo2QUd5MkM2?=
 =?utf-8?B?S0lBaXdJUTQ1N0xRM0k1blNOeEVqdWlpTVZqOWN2ck5TOU9zMlFFWjlsTkpu?=
 =?utf-8?B?bTJvTzZvOWZJT1UxU3pXN0RPYm5walUvUnBxU3dMMDhraFNJNDRUM3hXaEVx?=
 =?utf-8?B?aXZ0K3MzNDl4ekFnREpObzFrd2NyQ3YrejNrQ0NHZTB5ZHdpUlUyaDBkQWs4?=
 =?utf-8?B?eTU1VERoZkx4cnU0MDdsdFNIb2M4MmUrZyt3bWlkbnpQTHA1cEFoeFc2MFYz?=
 =?utf-8?B?MzlMTEdHQVRtajNjaE1jSVJQS29IMGVncll5OElvVnIrNCt2UENtWngzdUw4?=
 =?utf-8?B?TmtIektDVERhMU9lNnlPMjM3RnhWdWgwNERxdTZkS1FCQ1dzT2RIUzFadVVP?=
 =?utf-8?B?VlA1UEpQZFFWQnI2RmRpOEszNjJnZnA3ekJIQW1kb3hVeUMxUUlNeVhtQ1NW?=
 =?utf-8?B?ZW1JSVlKV0NDYnBvRGJwRHNGYVMyeDJWakk1SUFFLzFRUmZhQTdoaFpuaStt?=
 =?utf-8?B?UTZtWjVoTzlCZldIdE41ZGIyc0cxNjQ5Sy9MMVhCVEJaQmUxN2RWU1FlVEFR?=
 =?utf-8?B?MDZzVytwUGdFbEFudDdPYzhSK3lML2xpZURQOFpYTERJNXVYYmFNTmNGWW1a?=
 =?utf-8?B?T2FNT1R3RjRDQjJGdnl3Q01GTGg4eW1mdXJRQVZvSGUwdlpvQzV4VE9yMVNQ?=
 =?utf-8?B?Z1ZnUmdoNHE2cDRGakZiem5ZNEU5azJIeFNEbUxqN1BhR1VwdmZOcVFSeHlo?=
 =?utf-8?B?ZzZHM1dDTjcySXY2MVpFZEVVenhVOTd6Z2ttNUl6Tk03OUZCUWpBMHU3Uzc3?=
 =?utf-8?B?eC81Zm50dXMzaEZGZkRpMklETExRVkc5MmtCSUVKTmFzRFJQalVjRjg4cTFk?=
 =?utf-8?B?a3VqMlErYmxCSlRQaEFNbDJtQTVPK0NDcUN4NHpTRCtpRm03eWJMT040NHhr?=
 =?utf-8?B?ZVdsUy9LbDRUbUZwTlFDczRZOFNSSnhhc2d2b0lTcnVnN05OU3pNL1BkUHRa?=
 =?utf-8?B?SVJmcFYyenp6a1lncHcrNk1XRWxURWE4Umd6UnJMMkxXL3RiaWo4eTlkQzhz?=
 =?utf-8?B?R29kQ1ZwZ3NGV2dWVm04cCtzV3dEZXUrS1hHbi96anNkTjRkWlNBaXVSRE85?=
 =?utf-8?B?Nkx1WGNSNUNDS1VPWFNlakhXTE1VejhFd3VrL1NaVDRjZ3NrbStZaC9KWCs1?=
 =?utf-8?B?cDBwWWpOSlRNb0MyL0pqUGo1YXN0ZmpXc2ZQZ014UUIwOUJNZkF0T0pOOWlq?=
 =?utf-8?B?VzQ4S3kzM1RPRWxGRW1FZTJzZmd5eDlCZ1RidnBUZUhlcVBQWlh1T2tISEZK?=
 =?utf-8?B?NVZzakdWK1p5YjhyQlJlWG9jSWJPejRrWGQ4NGF0U3lvcmJZS2tWdGtJWEto?=
 =?utf-8?B?L0ZyKzZudCtHUUdZRmNFS0Riby80Nmx1aTFiQ0QrTzhaa2FjdEM0YXdUdmZm?=
 =?utf-8?B?SEJhK29PVDcwekFIU2lWNktmbFB0NkgxWkNUb2FtNyt0TjFTdzlCQVRpY3ZU?=
 =?utf-8?B?azdiVnpGYlRLVVMvUGxPWmh6aTBoR1Q5bjB3V2N6UHQ1NWkrOXFvT1dSRUNi?=
 =?utf-8?B?bDhER056NGtHU3JSdlN4dGFwMTR0VTZ2NTdQNVZObUhiMDJyZWswellsb1FT?=
 =?utf-8?B?WkFVOHhqUTJSTld1NTRHVUNHaUluNm52WVorSzdWR3BJa1JXVDUrTElaUjdt?=
 =?utf-8?B?YjB2ZVg4MThTY2V1ZUhncmVEbWxTeUg3OWdtWGdYS01QeDVmSjFXd0Rjckhz?=
 =?utf-8?B?UlhZRXQyc2d5eWV0S1BsRVVOak9xajJkRytWUDFGeDZ2bml6SDgxVzBzeVFn?=
 =?utf-8?B?OXZyTE11V3VBeEJ6NjI1cWN4eUlNQzFDclp5WVYxTUlMYmN3UWhScTBrTXc1?=
 =?utf-8?B?RFcvZnBZakQ0NzJLV3pWNUFHOGpsS21DdHNPbVJUeWxVZUNmQkc1S3lvTzVz?=
 =?utf-8?B?SkIvWnAwaXNydUUrRHB0RTFpTGtMbk5RYkFiUkZYRU1lZHB2bWtwc3AvbUpx?=
 =?utf-8?B?aGhjb2lJY1E3V3lUUmd1eVpSRTdLWHd5bUJRektvWi96SzcycmxsNHUvdXZ6?=
 =?utf-8?B?Ulo4Tlg4M3Z2NFdOdkk4V1R2eldKMFZmcDZvWDhJaEhXeGhxT3pic1piRVUv?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a9db44-f74f-40b3-df20-08db774aa557
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 20:11:08.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehR5erkcR/8U3FwINYpGJVJdNgbY0h3hpJALPtlmn/W2ubcXYqMi8tObyDJ+W0lRqMsYNyW++YacaOb985/1dYzZvdMxnajijFxpl2gGxMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjYsIDIwMjMgNzowOCBQTQ0KPiANCj4g
VGhpcyBpcyB0aGUgc3RhcnQgb2YgdGhlIHN0YWJsZSByZXZpZXcgY3ljbGUgZm9yIHRoZSA2LjMu
MTAgcmVsZWFzZS4NCj4gVGhlcmUgYXJlIDE5OSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzLCBhbGwg
d2lsbCBiZSBwb3N0ZWQgYXMgYSByZXNwb25zZQ0KPiB0byB0aGlzIG9uZS4gIElmIGFueW9uZSBo
YXMgYW55IGlzc3VlcyB3aXRoIHRoZXNlIGJlaW5nIGFwcGxpZWQsIHBsZWFzZQ0KPiBsZXQgbWUg
a25vdy4NCj4gDQo+IFJlc3BvbnNlcyBzaG91bGQgYmUgbWFkZSBieSBXZWQsIDI4IEp1biAyMDIz
IDE4OjA3OjIzICswMDAwLg0KPiBBbnl0aGluZyByZWNlaXZlZCBhZnRlciB0aGF0IHRpbWUgbWln
aHQgYmUgdG9vIGxhdGUuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJlbGVhc2UhDQoNCkNJUCBjb25m
aWd1cmF0aW9ucyBidWlsdCBhbmQgYm9vdGVkIG9rYXkgd2l0aCBMaW51eCA2LjMuMTAtcmMxICgz
ZDQ5NDg4NzE4YmYpOg0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5n
L2xpbnV4LXN0YWJsZS1yYy1jaS8tL3BpcGVsaW5lcy85MTIzNzI2ODkNCmh0dHBzOi8vZ2l0bGFi
LmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1zdGFibGUtcmMtY2kvLS9jb21taXRz
L2xpbnV4LTYuMy55DQoNClRlc3RlZC1ieTogQ2hyaXMgUGF0ZXJzb24gKENJUCkgPGNocmlzLnBh
dGVyc29uMkByZW5lc2FzLmNvbT4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0K
