Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6765F8A8B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJIKXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJIKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:23:17 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50081.outbound.protection.outlook.com [40.107.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8B2D746;
        Sun,  9 Oct 2022 03:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcJP6kxsTfU9wkki8w5kQR9dzoaCNjUU0zzpEuiH/tSy10ULfkKs4b20Ws3wsRBoVL0i2Y4h+s/V8gE7D5Rer0yk3sA0wphqrVNpFBrJLSET6kZrbLubXTkTRpMFf12nb/Q35j5G3R6o25P15fT4IvBzFnurARuDRHpccgGlE4INYn1+CNefxvw8eUxajARfx48aeJFwfekot5u2o7et+0CkqEnEirv01NS0DMu1QoyidL4dmi2ahg7oXfN342EhOWInWLaLN77L3dqH6P5TKgC2A8fZjcuE1721XUxp1m/ZXJgwxoKiot4y2tsGQJCN9LPHRScTf4eG+/J0nP1byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx0Equ7osQEaX5u4gzFBsvhxH6P/pWr0VX/tpNlpIPs=;
 b=DarI8k1PhHUz92GfOnJ6M5Otrrr9exZ5qWvOt0AtnuAbuItNVObhgqsd3wPSBVwLs7LmZfEpb3BE71zdbu+QHdKCulJtM8lI0L8t3GP1sV8QPb/ZQXivUpkY47sIcsHGDRf5CCy+sz2IOtYacxVPRggkrkU6k7/+neVCZTAyrkEsNaQgoun+QYkOALocdUq4NBZGblO3uRIu3sRqVuid6oISSq0ohGRHLCs8NEi6dSVKi5WcQ5e8Chlv14zUbhlqbZiQCLKY0n6nW6z4rISThXgSdZrDpzEmRskuO/YrjiYENqdijL1qNiZcDF4aId1fVIORLrQmHC4yEzho7C9WIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx0Equ7osQEaX5u4gzFBsvhxH6P/pWr0VX/tpNlpIPs=;
 b=VVfVAYvmbHR4TL1phJdPv+xHFQr9zjc5oxHAzVXrYsKio9mK+31UpXL0uNL0g1DQ5ChN9nmX4O81m2qZQJL7u4Ioyj5Wv3bXpm73FAQn7l2O7dwpsjdVC4gNynJLxRSXEoCTCgmwDKNmOG1OMRpq9G/SiSjNEVhxqUl9FynObnM=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8134.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sun, 9 Oct
 2022 10:23:13 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6a46:130:6b95:645]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6a46:130:6b95:645%6]) with mapi id 15.20.5676.034; Sun, 9 Oct 2022
 10:23:13 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Thread-Topic: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Thread-Index: AQHY0+EeaAH9c/DrIUi1YG5YmLZWk632OyYAgAAB3mCAAAXMAIABWEgQgABV9gCADfVVEA==
Date:   Sun, 9 Oct 2022 10:23:13 +0000
Message-ID: <AS8PR04MB84047F39CD10C00CEE29213F92219@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
 <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com>
 <AS8PR04MB84044F397918A3475B5D8D1D92579@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <39c68295-947-2353-d9b-3bd654c38c7@linux.intel.com>
 <AS8PR04MB8404FAD25C9881FAD2754FB192569@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <b4779edd-200-c7df-4bde-7f434fdefa@linux.intel.com>
In-Reply-To: <b4779edd-200-c7df-4bde-7f434fdefa@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB8134:EE_
x-ms-office365-filtering-correlation-id: a430429d-abcb-42d9-7560-08daa9e045b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUiUMJpwtnGA2TokRrpxYm2uZnKhF2dOacMWUj5SEuAs7ctfIJhpmPBQIrLdXIb8D6cMl9KfPhkkphlgZsBxgfzCVUvjz+/bjmMDJ4WgJeGbk+QHlUZUwaZDM506r95jSDnItk5XSzBKUEDpw7ykGrrTM3Sp1VFx3ikj2BMk53Z2pPQu8FtEk9d9gk+PCnti5eoZ1yuAAW3UU8Ivy1Fs8FI0Jso5T/K+uw7ZhFtWftQ0RFBGmTsMvD1rsHrEumdC8WY1vdZr6QmvkTC0CcYrau0HiFFHcfiAkGKjG6xaTXYau04Dra2ttSW0UzdiTrXdWUj1zrpMC1xeSV5JYoIXofGDmTUMfA+wwfgotRdL3mUxYw36XUWdiEozEpext33jicyGIRwJ/p5WbhHQL4Jzzun3nd1o+fHMxc4+vId6DTVXZeHdnWmoLycwF9AyzaUusgyaNDm2jX4lp8RV+LV4QUrDXVGmaeUzLxxEf/MCoHmNkgpe1SNw4OXu+qXmBsAO/bus6ti1E/QHMUXH39kVRKcRdxD9mA29vkechNU0bJAizOya8PsdggojoxuJAxakbVeMSD4SWsWJFnItRIMogz7mGh5VipDQ7GgUizjD+MBz3DLUXBPZH7oUS72sz6hp7n4hKPFpnOR2Wsbl+w5nJcV9qo1wTAtOqxpthrMR/aGPkmfsApPWuh9E0LEG8J0ROwR2Mw5ybbnhH2pqQTcEWzxU+25A2TpfXRlusvlM7ZHNPSc3aNzf1KuoOlYDH/Clkfhklp6pncFo4qBxpFbNlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(66946007)(4326008)(66446008)(66556008)(66574015)(8676002)(76116006)(38100700002)(44832011)(2906002)(122000001)(64756008)(186003)(41300700001)(66476007)(8936002)(33656002)(9686003)(83380400001)(26005)(52536014)(7696005)(86362001)(55016003)(5660300002)(38070700005)(53546011)(6506007)(71200400001)(478600001)(6916009)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVdndGV1allmNUs3dEZIYW96T2FOeFNKamliaXh2d3dUWWtkeWVwMWJxZWpB?=
 =?utf-8?B?Ky8yNSt5QnZKRUJ2WVA0bXZBaUgzQTB2NmtQdHJwQTB2cURSTTlTMmVqbStH?=
 =?utf-8?B?UkxnQ0M5RTVHd2dXUWxvMUZ5Q0Z0OThzYW5zSW96UVozMTF2WnA4UTEySnJD?=
 =?utf-8?B?WnNEcWU3aHdhU2hFWktHbmpmZTVxMEtqQit0cEExclMyeEpmUEhRU2cwNXBX?=
 =?utf-8?B?ejJJektFRWNHbVNVU1BOd3JuR0JCSVI4NStKVjl5R2IvWmRLZyttNVJQaGk4?=
 =?utf-8?B?WVhtbzlXaXJ4NkV5ekpDdzVlSWV0eUl6b3p0c0I5VGRReGZYNlVkY1dhV2R4?=
 =?utf-8?B?d1FQK0g4aWJQZVB0TlpsOFNkbm5LelNhWlhRL1ZPMy80dE9kVnVhWW5qcXp3?=
 =?utf-8?B?TmxiZEE1eDd0YnVVcDd5QWw1UEc0UnRBaTB6NnhrVGVjVE92SXN1QTE4cW9p?=
 =?utf-8?B?SGhHOFBuYllsb2xYeEtjcjdzZ3BjbWJ2V0g0dmdpeVo5ZFNhNDhDU082dTho?=
 =?utf-8?B?SUp2Q0FuZ2xNaGNDUERVc1dGbDdZd1dyMTdHR1dBNW9OcmNOU2M2UmhRS3Jt?=
 =?utf-8?B?NDRmeitCVUxreFRvT3VnNlRsb2FjTjhUOW9GTDAwWVVlakJiUmw3L0pyZ2NU?=
 =?utf-8?B?UEQ0WGFPYXNlMEFjNDlaVGkxWlJndEZzbnp4UkdSM0FaQzMyYlcxelZUMG04?=
 =?utf-8?B?UzZ2K0t3T1VsSGt4RDZ3QnZpN21rbUpGRWhIbkY3ZWQ2WXN6SEE4ci9DVmpk?=
 =?utf-8?B?R0dCSWFVd3pXNCs0bXBvYmFwODJ4ZUt3UmR2U2pOZFYrQjBRODdPR2pKRlY2?=
 =?utf-8?B?eGdQa1Q1c21VMXBCcXZ3UTZZaXpvd0tEVDkyTkVYcDhIaDM4Nm10MDlDdTlN?=
 =?utf-8?B?bFdNQkNXY1ZzamlSVHpkRWpSczUvM1hZQUxiYU1nRkxuYkFEcDBpYkt2WnpQ?=
 =?utf-8?B?aVcrczNCWHdDRU9mZnBzemlESUdCbFV2WjlXcmhzZTFpcnlJL1RLekZOYWxx?=
 =?utf-8?B?ZWNiQUl4SUhWQTZSaDIxU25ESnlLZnpMNVJMZUxPak15aE1TMFRtcEhpU0F6?=
 =?utf-8?B?bmRrTWJ5V3RxdEVTT3A1T2JlYktwTFVNUS9MVXZpRDhvRXJQVWtLZkFsa3lm?=
 =?utf-8?B?VWRNeU0yVDZ6WEx3dzR4NFRPRHpjTnlKSE14ZDlTVnpYMEdmSUFzMlBWWVNT?=
 =?utf-8?B?emdpeVBqTHlRaElIT25XSnF3dDg2blVQejI3S1R0TkJKRFEvUWxUeEl0WXZ1?=
 =?utf-8?B?dW1sQnJRNW4rSzJkdGVuaWtkYzExaG51V3duUU91a0NTS24xcnF0Y1Z1bVc5?=
 =?utf-8?B?Y1JWVEVMdGdYT09UZmtid0dSVWlzUUZOb3J2aVorV2pMMUltN3h5UFpTMnpS?=
 =?utf-8?B?amd3aURma0wvQlZXcU5GZCthYkE1bVZPQ1ZzdXZ0MzBmUmFOd2I5WFdMYlVS?=
 =?utf-8?B?Q2FENXhiekRIT3Y3MHJNMDV1U0QwL09RK0x4bGx5M3ZIVm9PM2Z3Tjd5MjlX?=
 =?utf-8?B?dk9MUU1nSXFka3hEUmVTdFhKUllia0prQ3lINmhCZVY3b1l5TXBYNG1weVk4?=
 =?utf-8?B?dWJQRU9Vd1RSUE5wdU15OWVyZXpkYWxtYWRZTkJIbUxWTzdFMFBLSmp4U3Q0?=
 =?utf-8?B?WUMrME16VW4vV1kyZTVKTlBEOCtiekd6bitFZyt6ZlpuZkhGRnV1WTJ6bmNK?=
 =?utf-8?B?d3NrVlZBK3NVeGV5c1lHM2Y0TmtJUjB3elZYMS91ZzZIWmtNdUE1Y1hIWW1Q?=
 =?utf-8?B?WU8yR05VMjd3VG5TcWxMc2NZanJBN0VZeFV3Y1BCYWFNU3ZnbnFnRnJvY2Fm?=
 =?utf-8?B?ZlJoSHlmZmJuNGhuK1dqZFd0UVJCMWdwbnhzMmFmMVYxaHBjQ2NBcFNEdFdL?=
 =?utf-8?B?RmFSRFdJamY5NU13R3dXNVAzNzZGWW1zNFgzenFEMzhtSGVNbHNqeHRzQjNJ?=
 =?utf-8?B?YTZvTjgyelB6TXdOVFYzMDluVHhmUHBqRmJNeWdZaE8vVjlURUdoTTUrUE5w?=
 =?utf-8?B?bDJTenppTFFpN1NYMjVoc3NTa1dOZXY5NUg2c2hzTmNvQklmRStNWUdPeXBG?=
 =?utf-8?B?clF1OWE2bGpaN1Bmb2c2cGRxd0ZmaWZ5dWJ2N1JISXZpa0VxSXJZcVZ1akpS?=
 =?utf-8?Q?aDfYhDeuzEeK5lZAW3IZDW3TI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a430429d-abcb-42d9-7560-08daa9e045b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2022 10:23:13.3125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNgUcPeUE0pghi5szJA2psvwH82VuZI6/H0KwxmEdiRMQRy59Kl+OMBkN4lbJi08PvpAXkLZpABXZUV5R4xs9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDIy5bm0OeaciDMw5pel
IDIwOjU5DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieQ0K
PiA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT47
IGxpbnV4LXNlcmlhbA0KPiA8bGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZz47IExLTUwgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBkbC0NCj4gbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gUmV2ZXJ0ICJzZXJpYWw6IGZzbF9scHVh
cnQ6IFJlc2V0IHByaW9yIHRvIHJlZ2lzdHJhdGlvbiINCj4gDQo+IE9uIEZyaSwgMzAgU2VwIDIw
MjIsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDI5IFNlcCAyMDIyLCBTaGVycnkg
U3VuIHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgNjBmMzYx
NzIyYWQyYWU1ZWU2NjdkMGIwNTQ1ZDQwYzQyZjc1NGRhZi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBjb21taXQgNjBmMzYxNzIyYWQyICgic2VyaWFsOiBmc2xfbHB1YXJ0OiBSZXNldCBwcmlv
ciB0bw0KPiA+ID4gPiA+ID4gcmVnaXN0cmF0aW9uIikgY2F1c2VzIHRoZSBscHVhcnQgY29uc29s
ZSBjYW5ub3Qgd29yayBhbnkgbW9yZS4NCj4gPiA+ID4gPiA+IFNpbmNlIHRoZSBjb25zb2xlIGlz
IHJlZ2lzdGVyZWQgaW4gdGhlIHVhcnRfYWRkX29uZV9wb3J0KCksDQo+ID4gPiA+ID4gPiB0aGUg
ZHJpdmVyIGNhbm5vdCBpZGVudGlmeSB0aGUgY29uc29sZSBwb3J0IGJlZm9yZSBjYWxsDQo+ID4g
PiA+ID4gPiB1YXJ0X2FkZF9vbmVfcG9ydCgpLCB3aGljaCBjYXVzZXMgYWxsIHRoZSB1YXJ0IHBv
cnRzIGluY2x1ZGluZw0KPiA+ID4gPiA+ID4gdGhlIGNvbnNvbGUgcG9ydCB3aWxsIGJlIGdsb2Jh
bA0KPiA+ID4gPiA+IHJlc2V0Lg0KPiA+ID4gPiA+ID4gU28gbmVlZCB0byByZXZlcnQgdGhpcyBw
YXRjaCB0byBhdm9pZCBicmVha2luZyB0aGUgbHB1YXJ0IGNvbnNvbGUuDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29t
Pg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9s
cHVhcnQuYyB8IDEwICsrKysrLS0tLS0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gPiA+ID4gPiBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5kZXgNCj4gPiA+ID4gPiA+IDY3ZmEx
MTNmNzdkNC4uN2RhNDY1NTdmY2IzDQo+ID4gPiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiA+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiA+ID4gPiA+IEBAIC0yNzIyLDEwICsy
NzIyLDYgQEAgc3RhdGljIGludCBscHVhcnRfcHJvYmUoc3RydWN0DQo+ID4gPiA+ID4gPiBwbGF0
Zm9ybV9kZXZpY2UNCj4gPiA+ID4gPiAqcGRldikNCj4gPiA+ID4gPiA+ICAJCWhhbmRsZXIgPSBs
cHVhcnRfaW50Ow0KPiA+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLQly
ZXQgPSBscHVhcnRfZ2xvYmFsX3Jlc2V0KHNwb3J0KTsNCj4gPiA+ID4gPiA+IC0JaWYgKHJldCkN
Cj4gPiA+ID4gPiA+IC0JCWdvdG8gZmFpbGVkX3Jlc2V0Ow0KPiA+ID4gPiA+ID4gLQ0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gU28gdGhlIHByb2JsZW0gd2l0aCB0aGlzIGJlaW5nIHNvIGVhcmx5IGlz
IHVhcnRfY29uc29sZSgpIGluDQo+ID4gPiA+ID4gbHB1YXJ0X2dsb2JhbF9yZXNldCgpIHRoYXQg
ZG9lc24ndCBkZXRlY3QgYSBjb25zb2xlIGJlY2F1c2UNCj4gPiA+ID4gPiBzcG9ydC0+Y29ucyBp
cyBub3QgeWV0IGFzc2lnbmVkPyBDb3VsZG4ndCB0aGF0IGJlIHdvcmtlZCBhcm91bmQNCj4gPiA+
IGRpZmZlcmVudGx5Pw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT3IgaXMgdGhlcmUgc29tZXRoaW5n
IGVsc2UgaW4gYWRkaXRpb24gdG8gdGhhdCBJJ20gbWlzc2luZz8NCj4gPiA+ID4gPg0KPiA+ID4g
PiBIaSBJbHBvLA0KPiA+ID4gPg0KPiA+ID4gPiBZZXMsIHRoZSByb290IGNhdXNlIG9mIHRoZSBj
b25zb2xlIGNhbm5vdCB3b3JrIGFmdGVyIGFwcGx5IHRoZQ0KPiA+ID4gPiBjb21taXQNCj4gPiA+
ID4gNjBmMzYxNzIyYWQyICgic2VyaWFsOiBmc2xfbHB1YXJ0OiBSZXNldCBwcmlvciB0byByZWdp
c3RyYXRpb24iKQ0KPiA+ID4gPiBpcw0KPiA+ID4gPiBscHVhcnRfZ2xvYmFsX3Jlc2V0KCkgY2Fu
bm90IGlkZW50aWZ5IHRoZSBjb25zb2xlIHBvcnQsIHNvIHJlc2V0DQo+ID4gPiA+IGFsbCB1YXJ0
IHBvcnRzLg0KPiA+ID4NCj4gPiA+IFRoaXMgZGlkbid0IGFuc3dlciBteSBxdWVzdGlvbi4gSXMg
dGhlIG1haW4gY2F1c2UganVzdCBsYWNraW5nIHRoZQ0KPiA+ID4gLT5jb25zIGZyb20gc3BvcnQg
YXQgdGhpcyBwb2ludCB3aGljaCwgSSBndWVzcywgY291bGQgYmUganVzdA0KPiA+ID4gYXNzaWdu
ZWQgZnJvbSBscHVhcnRfcmVnIHNpbWlsYXIgdG8gd2hhdCB1YXJ0X2FkZF9vbmVfcG9ydCgpIGRv
ZXMNCj4gYmVmb3JlIGNhbGxpbmcgdG8gcmVzZXQ/DQo+ID4gPg0KPiA+DQo+ID4gSGkgSWxwbywN
Cj4gPg0KPiA+IEFjdHVhbGx5IG5vdCBvbmx5IHRoZSAocG9ydCktPmNvbnMgbmVlZCB0byBiZSBh
c3NpZ25lZCwgYnV0IGFsc28gdG8gZ2V0IHRoZQ0KPiByaWdodCAocG9ydCktPmNvbnMtPmluZGV4
Lg0KPiA+IDIzICNkZWZpbmUgdWFydF9jb25zb2xlKHBvcnQpIFwNCj4gPiAyNCAgICAgKChwb3J0
KS0+Y29ucyAmJiAocG9ydCktPmNvbnMtPmluZGV4ID09IChwb3J0KS0+bGluZSkNCj4gPg0KPiA+
IFRoZSAocG9ydCktPmNvbnMgaXMgYXNzaWduZWQgaW4gdWFydF9hZGRfb25lX3BvcnQoKSwgcXVp
dGUgc2ltcGxlLg0KPiA+IDMwNzYgICAgIHVwb3J0LT5jb25zID0gZHJ2LT5jb25zOw0KPiA+DQo+
ID4gQnV0IHRoZSAocG9ydCktPmNvbnMtPmluZGV4IGlzIG5vdCB0aGF0IGVhc3kgdG8gZ2V0IGlu
IGxwdWFydCBkcml2ZXIsDQo+ID4gbm93IHRoZSB2YWx1ZSBpcyBhc3NpZ25lZCBieSBjYWxsaW5n
IHJlZ2lzdGVyX2NvbnNvbGUoKSBmcm9tDQo+ID4gdWFydF9jb25maWd1cmVfcG9ydCgpLg0KPiAN
Cj4gSSd2ZSBzb21lIHNrZXB0aWNpc20gdG8gdGhpcyBjbGFpbS4gSSBub3cgcGxheWVkIHdpdGgg
ODI1MCBteXNlbGYgYW5kDQo+IGNvbmZpcm1lZCBpdCBkb2VzIGhhdmUgbm9uLU5VTEwgLT5jb25z
IGZvciB0aGUgY29uc29sZSBwb3J0cyBiZWZvcmUgdG8gY2FsbHMNCj4gdG8gdWFydF9hZGRfb25l
X3BvcnQoKSBhbmQgaW5kZXggaXMgc2V0dXAgdXAgY29ycmVjdGx5IGZvciBjb25zIHRvbyENCj4g
DQo+IFRoZSByZWFzb24gZm9yIHRoZSBjb25zIGJlaW5nIHNldHVwIGlzIHRoaXMgYmVpbmcgZG9u
ZSBpbg0KPiB1bml2ODI1MF9jb25zb2xlX3NldHVwKCk6DQo+IA0KPiAJLyogbGluayBwb3J0IHRv
IGNvbnNvbGUgKi8NCj4gCXBvcnQtPmNvbnMgPSBjbzsNCj4gDQo+ICh3aGljaCBJIHRoaW5rIGNv
dWxkIGJlIGVhc2lseSBiZSBkb25lIGluIGxwdWFydF9jb25zb2xlX3NldHVwKCkgdG9vKS4NCg0K
SGkgSWxwbywNCg0KSSBhbSBub3QgZmFtaWxpYXIgd2l0aCA4MjUwIHNlcmlhbCwgYnV0IGF0IGxl
YXN0IGZvciBpbXggdWFydCBkcml2ZXIgYW5kIGxwdWFydCBkcml2ZXIsIHRoZSBmb2xsb3dpbmcg
YmVoYXZpb3IgaXMgc2FtZS4NCkZvciB0aGUgInJlYWwiIGNvbnNvbGVzIChldmVyeXRoaW5nIHdo
aWNoIGlzIG5vdCBhIGJvb3Rjb25zb2xlKSwgdGhlIChwb3J0KS0+Y29ucyBhbmQgKHBvcnQpLT5j
b25zLT5pbmRleCBhcmUgaW5pdGlhbGl6ZWQgdGhyb3VnaCB1YXJ0X2FkZF9vbmVfcG9ydCgpLT51
YXJ0X2NvbmZpZ3VyZV9wb3J0KCktPnJlZ2lzdGVyX2NvbnNvbGUoKS0+dHJ5X2VuYWJsZV9uZXdf
Y29uc29sZSgpLCBoZXJlIHRoZSBjb25zb2xlIGluZGV4IGlzIGFzc2lnbmVkIGJ5IHRoZSBjb25z
b2xlIGNtZGxpbmUgcGFyYW1ldGVycy4NCg0KSSBhbHNvIHRyaWVkIHRoZSBzYW1lIHdheSBvZiA4
MjUwLCBpdCBkb2Vzbid0IHdvcmssIGxwdWFydCBjb25zb2xlIHN0aWxsIGNhbm5vdCB3b3JrLCBh
cyB0aGUgbHB1YXJ0X2NvbnNvbGVfc2V0dXAoKSBpcyBvbmx5IGNhbGxlZCB0aHJvdWdoIHVhcnRf
YWRkX29uZV9wb3J0KCkgYWZ0ZXIgdGhlIGNvbnNvbGUgaW5kZXggaXMgaW5pdGlhbGl6ZWQsIHRv
IHNldHVwIHRoZSAicmVhbCIgY29uc29sZXMuDQo+IAkvKiBsaW5rIHBvcnQgdG8gY29uc29sZSAq
Lw0KPiAJcG9ydC0+Y29ucyA9IGNvOw0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0KDQoNCg==
