Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4166C82B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjAPQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjAPQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:36:21 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2092.outbound.protection.outlook.com [40.107.113.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708C2B282;
        Mon, 16 Jan 2023 08:25:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X91Qx0Bn59a9Hv9+oYKHk/lv+hh62W73+qY8a6Ne0n1dYRUn6KovoEe2LfpDV0EqrdmDPBKQrEhJru39s/AIYayJ2UB3mEU5Yww7GDrHPKV9/MktmD5iS0nwa6RUPYrknQiTRb0soevs4FZ7kaaAygbZ55SvkmwUbttBm6xSKkczTnBoh2bFutR85u60z1lVUiUItxOVPZZhdHWwJMNEKfJk8HVS7kW0pK1zs+HbXNWkRYAPucSs2UitDbSKtmj2HpvQbP5B+vt4ykF9e8m+3kEl55TAnPzKPJM7YN6Hv00f/wDxHIrQPDusDHAW/cyqU1kQEocvyanICQWPt/r8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x9dsNAFDOjjkDR09uLbSh4Dmm9R5EDz7G0JLYp/ECs=;
 b=FwmVxvltiS0MZRHncmVIxR6mcPkOlB1E0hBBgHSC1Emw7s4nFh/gu3yQesbJNYAaIS1d/o1cZC8WhjF2xxENSQOx3HTwJ7KfSV++01oJMZUmljqs/Ur/5onJNVK5dJhYcSMXrcY5UVTz9sPcA5a3OuKWBAuGVfoGhFKnGxC5lj7WHxTDMUOKU4HKo90as88h8Aq94LA9umzIieNyjLDQWIuJ3NDYtyTJIPFb2knrUaEbR4vmwsEELe7JokU0JG8DJVF4RkWqkaLC1gWJEw6jdChd2HerLM7PO7SkU0pG8qq7ZnLmr+CeesiK7FneRJQ6i+jrrZuQQoiV7V5LXC8Apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x9dsNAFDOjjkDR09uLbSh4Dmm9R5EDz7G0JLYp/ECs=;
 b=EsoZitlH0Mp+1lUdeuqk95gDKtNLfTjvpOhKk4MOY5Xj3WGRWmiYA9SWPxo2+SiKcTdB/ys5obRfEY7TsvCBPiUHuenSrYMwGggAECW3JccwqQSaK3gQOvOXrGVj0iPwqdR0WMMs8sUPFb9PrDiKgF6ovlA/QAOOXCAR9UOKhDg=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYAPR01MB6171.jpnprd01.prod.outlook.com (2603:1096:402:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 16:24:57 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 16:24:57 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Thread-Topic: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Thread-Index: AQHY+nqpy1QulZVqxE28XPYMi1eo7K6hkpCAgAAAPXCAAAWlAIAAAFow
Date:   Mon, 16 Jan 2023 16:24:57 +0000
Message-ID: <TYWPR01MB87757FCB3CDA549DB4DC4743C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
 <20221117114907.138583-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUzkAjF=v__r2vJrYugBuDt13LnToCW66n-5r-jcVV+8A@mail.gmail.com>
 <TYWPR01MB877570EB023D2ECEB7896F84C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <CAMuHMdXxri6GgGxJy9WC-ktM_zoXDkzRz-6yBqQcikVe3DPShg@mail.gmail.com>
In-Reply-To: <CAMuHMdXxri6GgGxJy9WC-ktM_zoXDkzRz-6yBqQcikVe3DPShg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYAPR01MB6171:EE_
x-ms-office365-filtering-correlation-id: bc9e7508-44f0-4d39-631d-08daf7de3578
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pq8UENokF+MN77Ii2HC6kBxyZarIHx5sKvqVY+6pwY6zE0NEyGxmD4THr1fvYgZX4lp3BCGvNiSgyEGjn8bA6tZXYCYHqLuLRav7ngMbLK3O2JQXCZbEFV0y9VoeZIV5Gugcpw2/ulvaIV5cn47bnqO5tEc7bTW8Zug0vxyI7cC2cTxKzFBJcBBorcZeK0miwzjYlZVqDc3VmROMApJkLuXKcwEQesaOxK7P7V3fmwsGEVgQmH53OzVlVAqw70BpeHV2BRCQ2JdPZ7nLROm8pn72KxwGOXdym5+tuxPOlAPfNfDKTVuY3jqEyElmwIToHCxHN0Ki8EnreS+EGiVSucPf0y2HiQMawRzUuc64bU4fKxl/kXq8/WYap26bV9fCyRDi+/xcI7AWROrvuVgmBurxwGSBW/tQiVy74ptYdq1Dn87dLxpaMfLUPfw544Do4eu9XC25F7qo+FoqdzWOr6bfPlRCsmXCgHHYPvLMXPXpl7EPDmrZdkH1Im6alvqpYdTRqFpGNSz4nvJqw9wiykRsl6852Vqe9sOv0H+HDASannxVJGMaBmjkseVii+hY7ixLaACrGtsdFHajEfcVD1bFBzZ5trm8KAbYLZO0nrYhgsxyV0V+yj7HweBTwlbTRwTTKK/DkhC23sCxcDoP3dTUzUFXV3hjLK1qLZAKWTGLG83ckOZSWsY6pgo9SPsp9Kb8mYJQtS1G1pR53I78Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(316002)(71200400001)(33656002)(6916009)(66446008)(41300700001)(66476007)(66556008)(76116006)(64756008)(66946007)(4326008)(8676002)(86362001)(83380400001)(54906003)(38100700002)(38070700005)(122000001)(55016003)(478600001)(7696005)(9686003)(6506007)(53546011)(26005)(186003)(2906002)(66899015)(52536014)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFBJQjB6QkpvczhmeE5PWGNDWkNneFNFTE1SV0ZtNGpDUkJISmY3ZXk3VFZQ?=
 =?utf-8?B?eUVYTzNGNzlwUWlWM25MVktCcnRqcUQvNEpQeVZyeEV0ZmFuZ2VXeDZVVHJT?=
 =?utf-8?B?a2J2L0tPUi8wcDJxYXgxa3Q4YUFaTWMydlpia0FraWlrb2ZNcFNJUEhWU0x3?=
 =?utf-8?B?RlV0Sk0xTHAxQzZkUEtPMUZOaFlyZWtwZm5yT2NNeWE2eTBkWEwvN2l0Z1V3?=
 =?utf-8?B?MTNQUjJuOWE4RndBeTY4c3VHZ0RCMmRUOG4xck4wTnYxY0xCaVpxMEFvZlpj?=
 =?utf-8?B?SEV6eGZOMVE0OGluMEVzRlNhc3h6ZnNlTm9lbUdoazNwbm00SGRsN3ZJNE9h?=
 =?utf-8?B?MGRMS0o4b054UlJaNEVuYllaL1hJSXRQRnNLYTlPQ1lEKzZmWXpETVo1bTN4?=
 =?utf-8?B?SWk1N1JXVmc2d1A5MEIrWnU3VCtMS2hxcFNiM1hCcHRwNTlkVnBCczBubHZX?=
 =?utf-8?B?ekU2OGY4elFzbXNPSFgyUnVodlg2YVNCZUJjYkl6Z1V1ZUY2RklHUzh6czVJ?=
 =?utf-8?B?TjB6cWYzTUY5eUFSZDFNWmNzTWEzN1QxRW1IcFhsUWdoMHpOMGRvSUNGei83?=
 =?utf-8?B?b1ZYMkRsSWxTaCtITmVTeVQ5YkVmZUk4VTdkTlVxWkh4Z01raFZ4Q2YvTEh5?=
 =?utf-8?B?cmZDN3Y5am5xaG9mQzlKQWJ6UHgxM1dFT0I0NFRycGVWWnFsRU8vQktEQ3VM?=
 =?utf-8?B?RXp2aXlOcklIb29FZ1FZTGVuYWFVVVFuRDRRVGh0T2k5Ymo4K3QzTG9IeUsz?=
 =?utf-8?B?VUM1ZXVBNVV3RUVxWFpYYWFMY2kwb2RFT2hFb2M2c0wzNWtMUkx2WTAxTzRs?=
 =?utf-8?B?cEdjTEd6N3NwcmROUGViZWpOZDd0Q3V6dXYvR1BhdDduUXgzTVNmSGVIbldV?=
 =?utf-8?B?OVptSkRDaFdKTmIwV0pKL1JYUlhRMU5vRExvUHJIcFdYallCaUkwRDlNT2dI?=
 =?utf-8?B?VE1FY3IxblhZdGhOOXdZdmhpNGswUldodG44WEIzKzk0bEowVWVxVHhkY3Zx?=
 =?utf-8?B?cXkvaXM3bHU3MFdtMXN0U3JGeUxBVGtWMFk3L21IYkFiUWhPbUZhbFJicUxU?=
 =?utf-8?B?RzBNazYraEJzOFJabDFuMytOTXVFdHk4NFJqckUrUHF2YWFuSXRQTGpxdU0y?=
 =?utf-8?B?L041bnJnam5WMGtwMHM0RXVjMzdnU0JGSG0yeDdEcEIwTDk1NVB0UnZ0dGc1?=
 =?utf-8?B?THZmRS9MSElKektJVkFHYUY2SGRnUDNxaFVNNW9Hb3p3RlNyN3ZyM1VFUFVz?=
 =?utf-8?B?UGRzVUVPb1hyYjFBVmZsd3hJOFQvb0VZRGh1ZHNOZklDSjBEVHhMc3hUUzhU?=
 =?utf-8?B?SWR4VEhqTXE1d2pUU28ra25PQ0grVitSeldTOUY3YUV1M05KWDV4TXBhWEtG?=
 =?utf-8?B?MGRtbTh0cDgyQmdDZlZRajFTYjdtMXB1K2Vzb3dUeG1ZcGIyenVTaElRQVBi?=
 =?utf-8?B?NkV2OWJVYjc2TWpkZXZGSndkNXFEQ0lPZTJ4UGJ1L0NhdFJ0UW1mM21pNW9B?=
 =?utf-8?B?LzVNdmY0a0N6M1E0RTd4bTNIOXRTQUZOc0RycEtRbC9QS2NPZmE2dlRXZUM5?=
 =?utf-8?B?VWFlbUR3RjZJSHdzcWJpajFDUFhEeU1zMnVSeHpRUFZnandXVWRaMFU1SkRy?=
 =?utf-8?B?Z2tOWnlkZ0tvYXg2aUNaL1hxU2lMa0I1dCs3R0F6VWI3Q1pyeEIxQjN1TjdN?=
 =?utf-8?B?NXI3R2dKdFhOYWtJRnlyS05BekdtL1craVVuaHR0czB4aTFhdVFCWU5ieUhB?=
 =?utf-8?B?VlUvYXRhNGw4K3dIdFVsbStQdFVEVStzblRHbUpjYXFkWEExbmZUQTNTOERZ?=
 =?utf-8?B?NzIyS1RmWVZ1Q2hqTVM3ZjFWRDI1bFBZdlN2NkFUZWJmVTNFbC9BMGsrRVBl?=
 =?utf-8?B?WjY0OXh3dUt6Z0c0MExiZllSajF0RTQ3bnJGN3haTXRZWWlBZ0RacDRJbXhs?=
 =?utf-8?B?TmpzSWxBdjVYUXd2U24vbjlsdGZjOEF5R0MzT2RnQSsxOTlZMUk4U3AvSXFE?=
 =?utf-8?B?ajliemVOVVovZTNUajlnSlhHWVFvWkZTLzIrcVBkZWZrRHFXZWNrUGFpOTVY?=
 =?utf-8?B?M1dDaysyZ3ZJcmVWekRrbCs5T1ZQYnJ2cmlHUnp6eSt2cVMzSitsQkR2Sk5E?=
 =?utf-8?B?SDZMTHRaaldrM0FCZEp6Q2VwdStCUXFFZjZQRGVoaGE2MzN1ZW5EYlFoMUt2?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9e7508-44f0-4d39-631d-08daf7de3578
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 16:24:57.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNVty+m62ZqQcBkhliVWp1C52Qa8AnXZxUROKOiMnWdSNSnXKFH9bxW/zA85JJPdJc6Uc8MMROM43mjJHab6EO5v/RXOU+c/jOyzNxfA4mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSENCg0KPiANCj4gSGkgRmFicml6aW8s
DQo+IA0KPiBPbiBNb24sIEphbiAxNiwgMjAyMyBhdCA1OjE4IFBNIEZhYnJpemlvIENhc3Rybw0K
PiA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IE9uIFRodSwg
Tm92IDE3LCAyMDIyIGF0IDEyOjQ5IFBNIEZhYnJpemlvIENhc3Rybw0KPiA+ID4gPGZhYnJpemlv
LmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiA+IEFzIHBlciBzZWN0aW9uIDQ4
LjQgb2YgdGhlIEhXIFVzZXIgTWFudWFsLCBJUHMgaW4gdGhlIFJaL1YyTQ0KPiA+ID4gPiBTb0Mg
bmVlZCBlaXRoZXIgYSBUWVBFLUEgcmVzZXQgc2VxdWVuY2Ugb3IgYSBUWVBFLUIgcmVzZXQNCj4g
PiA+ID4gc2VxdWVuY2UuIE1vcmUgc3BlY2lmaWNhbGx5LCB0aGUgd2F0Y2hkb2cgSVAgbmVlZHMg
YSBUWVBFLUINCj4gPiA+ID4gcmVzZXQgc2VxdWVuY2UuDQo+ID4gPiA+DQo+ID4gPiA+IElmIHRo
ZSBwcm9wZXIgcmVzZXQgc2VxdWVuY2UgaXNuJ3QgaW1wbGVtZW50ZWQsIHRoZW4gcmVzZXR0aW5n
DQo+ID4gPiA+IElQcyBtYXkgbGVhZCB0byB1bmRlc2lyZWQgYmVoYXZpb3VyLiBJbiB0aGUgcmVz
dGFydCBjYWxsYmFjayBvZg0KPiA+ID4gPiB0aGUgd2F0Y2hkb2cgZHJpdmVyIHRoZSByZXNldCBo
YXMgYmFzaWNhbGx5IG5vIGVmZmVjdCBvbiB0aGUNCj4gPiA+ID4gZGVzaXJlZCBmdW5jaW9uYWxp
dHksIGFzIHRoZSByZWdpc3RlciB3cml0ZXMgZm9sbG93aW5nIHRoZSByZXNldA0KPiA+ID4gPiBo
YXBwZW4gYmVmb3JlIHRoZSBJUCBtYW5hZ2VzIHRvIGNvbWUgb3V0IG9mIHJlc2V0Lg0KPiA+ID4g
Pg0KPiA+ID4gPiBJbXBsZW1lbnQgdGhlIFRZUEUtQiByZXNldCBzZXF1ZW5jZSBpbiB0aGUgd2F0
Y2hkb2cgZHJpdmVyIHRvDQo+ID4gPiA+IGFkZHJlc3MgdGhlIGlzc3VlcyB3aXRoIHRoZSByZXN0
YXJ0IGNhbGxiYWNrIG9uIFJaL1YyTS4NCj4gPiA+ID4NCj4gPiA+ID4gRml4ZXM6IGVjMTIyZmQ5
NGVlYiAoIndhdGNoZG9nOiByemcybF93ZHQ6IEFkZCByenYybSBzdXBwb3J0IikNCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNh
cy5jb20+DQo+ID4gPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gPg0KPiA+ID4gUGVyaGFwcyB0aGlzIGxvZ2ljIGNh
biBiZSBpbmNvcnBvcmF0ZWQgaW50byB0aGUgUlovVjJNIHJlc2V0DQo+IGNvbnRyb2xsZXINCj4g
PiA+IGRyaXZlciBsYXRlciwgc28gcmVzZXQgY29uc3VtZXJzIGRvbid0IGhhdmUgdG8gY2FyZSBh
Ym91dCBUWVBFLUENCj4gYW5kDQo+ID4gPiBUWVBFLUIgcmVzZXQsIGJ1dCBjYW4ganVzdCBjYWxs
IHJlc2V0X2NvbnRyb2xfcmVzZXQoKT8NCj4gPiA+IEkgdW5kZXJzdGFuZCB0aGF0J3Mgbm90IGdv
bm5hIGJlIGVhc3ksIGFzIGl0IG5lZWRzIHRvIGtub3cgYWJvdXQNCj4gdGhlDQo+ID4gPiByZWxh
dGlvbiBiZXR3ZWVuIHJlc2V0cyBhbmQgY2xvY2tzLCBhbmQgaG93IHRvIGhhbmRsZSBib3RoIGNh
c2VzDQo+IChjbG9jaw0KPiA+ID4gKG5vdCkgc3dpdGNoZWQgb2ZmKSBmb3IgVFlQRS1CIHJlc2V0
cy4NCj4gPg0KPiA+IFllYWgsIHdlIGhhdmUgYmVlbiB0aGlua2luZyBhYm91dCBkZWFsaW5nIHdp
dGggdGhpcyBpbiB0aGUgcmVzZXQNCj4gY29udHJvbGxlcg0KPiA+IGRyaXZlciwgYnV0IGFzIHlv
dSBwb2ludGVkIG91dCBpdCdzIG5vdCBnb2luZyB0byBiZSBzaW1wbGUsIGFuZA0KPiB0aGVyZWZv
cmUNCj4gPiBpdCdsbCB0YWtlIHNvbWUgdGltZS4gVGhpcyBjaGFuZ2Ugd2lsbCBndWFyYW50ZWUg
dGhlIGNvcnJlY3QNCj4gYmVoYXZpb3VyIG9mDQo+ID4gdGhlIHdhdGNoZG9nIGZvciBub3csIHdl
J2xsIHRhY2tsZSB0aGUgbGFyZ2VyIGlzc3VlIGxhdGVyIG9uLCBpZg0KPiB0aGF0J3Mgb2theQ0K
PiA+IHdpdGggeW91Lg0KPiANCj4gRmluZSBmb3IgbWUuDQoNCkF3ZXNvbWUsIHRoYW5rcyBmb3Ig
dGhhdC4NCg0KQ2hlZXJzLA0KRmFiDQoNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhv
ZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0NCj4gZ2VlcnRAbGlu
dXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmlj
YWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGENCj4gaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFs
a2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcN
Cj4gbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVz
IFRvcnZhbGRzDQo=
