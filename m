Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446086C1D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjCTRJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjCTRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:09:04 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0612.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4425FE04A;
        Mon, 20 Mar 2023 10:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFG2eLPqq3SpIVw9zv/oqfjW4kh9DRlWjLdgieRRXpHI7RldYrkPJ9DccMpblm0W7X1CimdzxYVgKaVVC5mCRqwdZAT9DxzONPnwnwSZihFEiuzxWkgae3GEUGbZdgtq4ZZHOmC+9JX6uj47Nttml6w7tyVsAyNhYGrOIedfxN1nNolb/vZk9FtU4PhY0f2DiTxN2DMNSqXXWdHXOHpXVYDaTZgbmC8vQgmRPgyDPMC6U1nvi6efmBc3bHP83TwPGAkbcBMcu1qEXqJfp9qgaded2hoWQ0latBwEz2sUjEhlA5EES/fcDNypyk/S7zBcFk+A1X/dwgVFhbtgPQbUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIf1xVxj+0v1F1M8XBlaG8ILZ7RvGgCZSFzbMi967wU=;
 b=grzJK8Yil1tBw/vDIHnTmeYeQOXSBSot6+VFMaWo9+rEuGTFY5+ZIpQlVUaeGnddLQHO4MMFFl56nPlL9VnDgAeKDM0khDibAsOzT3qtCxV6mSssmSf8YYsP017IGW3pfA/8n0d9dR+BcuDWANvWwVyuOL3kbYAe24QHerxcuhvMcTIJw5+LkOYp/2zKRaaGFqEByaZUahir67Oqwl9x+mnDdvgsGuMWle/+IQSTqZr1lpZZ4B/DRnam0wZUwjv+9XBb2YM9+TlF2kRTtq5EcF0xWs9LWfF1kUBBin9NUjbDtyBEeXLEPbSON2tvrOs1R2UGU01FJ//afntmwFCrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIf1xVxj+0v1F1M8XBlaG8ILZ7RvGgCZSFzbMi967wU=;
 b=H8CVCNl3Bog+hS8KcZX47EFvSjoE5ZZzVIFYUf9c746H9Hkyfc21F2ZaZYQvTekLHx3fmPAkSXyCwmjOvpphv8r7MLjEwCQ2siddC5ZHMZSN6+9HyZE33EFR+hNzCXwHK5gzxZpAFWWcwA2OMUTuMzUDVkv6O9cgTMLCyeK4iOs=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7597.eurprd04.prod.outlook.com (2603:10a6:102:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:02:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:02:57 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZWE4ev2xmRcSa20iFYFwtFRu1OK7+r7IAgABftWCAAueGAIABzLvggAALc4CAAAzzgIAABQcAgAACqiA=
Date:   Mon, 20 Mar 2023 17:02:56 +0000
Message-ID: <AM6PR04MB4838C6B05F46AD94153DDC8388809@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
 <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
 <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <1fd1fe42-3da6-1598-a04d-cb99a9b4b145@linaro.org>
 <AM6PR04MB483800D7CDCC7AF48F88BF9688809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b8801c83-f2dc-f144-de58-03e5c24436fd@linaro.org>
 <AM6PR04MB4838F5C9EF13A588E799D5C488809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <fc5c76d1-51cd-5992-9bfa-06f57874fc03@linaro.org>
In-Reply-To: <fc5c76d1-51cd-5992-9bfa-06f57874fc03@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PA4PR04MB7597:EE_
x-ms-office365-filtering-correlation-id: 64433ae3-8ff2-4671-a02c-08db2964f3e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0nGLd7r8FoHu5QM4gzijt69LoYinI7y6JN/00ftDXpSU0ymFAr3wul55wEWfN6nR9OdJ+gBCUq5K7CEIkF4OVBqMVvPrUbT1Kn4qU9momluJK+KPVb6mfk5ubSJfiZGVGdExB3LiiAVQEhjd+czriStzmTfb+nmWfxLdHRmxZb3+JRrQdc28CHwxLqRyGgOhCmIj5tScO3Q1qWddM8zul7NUv3pkNpHP8KokMNnxNuXqdd8m2caBFG1/WAayelcB+vaqNx/NGgCFjquAsy7tf8PVwuIiw/skxIntk7cwYJRPMzMoZqKpEZ8cbt0mNw+ZxeVbG4NG1BjRotd7P2hw+EbePfEqkU528W+a425XCdCjW8iZxhcscE6RQ+COqYcubm0IuzcpiggNrGNDiI+fi7cUMqCvvnMSb61bvotjldnADVSwWq5ZRB/vtUjcuB6GyxwM1bDOulAqL3LBd3NaYMx+UxT73hF262cBjS6nWi/KmLQDVCPOPXBFNnw1dUWjG8W3T2DMEgIVRTBM3ZY93lveDwj7WogX1nzg9HVnPob0v9sL9yAFe7UHHQWaYuq4X5USqABYc9b8pWOZ+gt/UtWsxDwu0Ozl5a1xWbqTkzI9teBsZJobPM6E+GgpdBLQ7FNeR0f1BUHybtnWlUCWydUHK6cZXp3oEfY7hWm0w57OnRWsjkOYGHMGMn4U2+EYVW7+nj7acI3eCpBJHKNqIjsiseph2UUwxdKmX4iHSZ1gFArHmWOoPJuFMCykMeu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(38070700005)(966005)(6506007)(186003)(53546011)(9686003)(26005)(55236004)(71200400001)(7696005)(38100700002)(86362001)(55016003)(44832011)(2906002)(478600001)(83380400001)(122000001)(8676002)(33656002)(54906003)(110136005)(316002)(5660300002)(8936002)(64756008)(4326008)(76116006)(7416002)(52536014)(41300700001)(66446008)(66476007)(66946007)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amE1NmxOWnZ2N0xyYWlUaUtiWUR6Y0NGOXpxK2M5QmQzaXozb2dIcHYyK0F1?=
 =?utf-8?B?QVBEbXVQL05GcFJvdjFjS3RpQ1JvUVB0NnBQZkpyYysvc2E0RXplcmZ1aHFx?=
 =?utf-8?B?NjBvMWVVY3o1YTd5ZytNSHFRMWc0TlJWZHJkbVRyRXQrcGhJZ0p4alBzU3FD?=
 =?utf-8?B?QTIvSUJzbmdtc0hDaHA1QjNTZ0xjZDN4VW5jcEVFZ083RzZVcFViVUVWUkpW?=
 =?utf-8?B?SFZwd0ErZDFweC9Ld2Jjb3NJaXNianV2U1BKcHQyR2w5MW1LYmJCV3NTQlFQ?=
 =?utf-8?B?b1h1ZmZWS3BNS1FnbVJOSk1xUVZXK3dTcGs2Z1U1UEpQdkx0OHFZNy9jMzBY?=
 =?utf-8?B?ekQxNGE1ZVNYZW11Y0lxYkxKcHRMSk9tckVVcGphc0dGQkxQZDdFMU1FeWZB?=
 =?utf-8?B?OWxWR1ZJZHptRTBRaGxoSVRyTkdabWtHc2ZCUE1OSWZ1K0haa3pIWjA1UkFp?=
 =?utf-8?B?Mnk4R1lGMjVlZWp4TW9vNEcxOU9xdWpBRjQvQXVTaHl0eUYzOFZCS2llSUJB?=
 =?utf-8?B?YkJYOWoxdzNmY295QXF6ZjgxMnFKdTVJVFZMVUo3OU1vdnZWcU41NTNYdkdh?=
 =?utf-8?B?MldoYUlQZG9udUozaEIvTi9lRHppWkQvM0o4V0I0aDZ0eGlsSlJXRW9NS3Fl?=
 =?utf-8?B?WE5FenArUENuTnZiWXZ0TktVRmpZYWZMQTkwOGlPYWpZeGFWcmlwdWlIQzhM?=
 =?utf-8?B?dGJueHg1QXlBT0M2V0JyN0dOUU1EcURoRUg3dC84ODdjT3dybXRPNksvQXRU?=
 =?utf-8?B?YlordTBRbSt1R3YzaThrVXJQRXFvcXF2bnpNMFlNcTNmVUVzMkttc1l2bWpH?=
 =?utf-8?B?TGh0aVVZT0lBNXNFM2w5SzdqRlZ5bkFUblIrbkJSVUFzbjZNMFl4ZlQreDFX?=
 =?utf-8?B?cDdEZ2V3OVpkcXZwNVR3Z2dOQmdmdUpjMys1Q1VuNGVITGw4REJla2I3OHk3?=
 =?utf-8?B?NTR2TVltcEZrZ1FaVk9rUC9CeG1TaWkvQzAyeG5rRHBwZ2ZYQ003S2Jxb25p?=
 =?utf-8?B?ckdIMzlTbUxnVGRXcGQxV3lLSXgrWGtibzNwRGhOMzAzNW9QQnlTWXZPSVlO?=
 =?utf-8?B?bEhGKzhnTXVkQVJpT2lNb3lMNS9VNGNnRDJlMjU5UEttUndQdGliTHFWdFUx?=
 =?utf-8?B?bldwTEk5dTR4TVNOTm9nTUVYY1dMeW9kMDFBWjVDNktlSWFad0NCcGVpVzRt?=
 =?utf-8?B?TTlyTWxON3ZiZ3piSUxTcUFIZkw4aUlYWFJpeW9oT0tLTFdYZ1h6bHhwZVB6?=
 =?utf-8?B?WXFPVmMrczlZVEV3aTdzT29EQU1PSnVhZUxQYktSMUNQam1QVXMrYTVGOXNT?=
 =?utf-8?B?UWQ0UXR5RVUxUCtOZnZaa1Y3aWlFS0VTTHdrMGFUalI1UlEvK2E5MzZuVUw5?=
 =?utf-8?B?Z0Q4ZjFNWkZuOFdYQTVzcklQZmZCbDE3YTVka21tY3liaWR3UGVUcHV4MnFr?=
 =?utf-8?B?ejRWZHU4cGtaTmlQQW0xS2s3T3QybFVBRVZHWDczS01jeWlMVnVkclZORkh5?=
 =?utf-8?B?V0xsblp5dFlYVktqeEMxSXVxWWxMZ2p1QS9jVkxYQnB6WTMxSjZ2Z0x0VzRI?=
 =?utf-8?B?UGlmMklIa2UyclVQVlg0WDc1enNwa3JES0p1TmlQd2pIbjV5aC9XeEkwRFl3?=
 =?utf-8?B?d0NlSnhmMjZ4Y2laVWFzd2tZRVEzU0poTDl6a1hwVVZZVHA3aXgvS2pRUWN3?=
 =?utf-8?B?SDlKSTNOQXdrc1FoQlhYYm9GSXJYUnIyejh2em10MURNa1BWNGFBQ05nNHo0?=
 =?utf-8?B?UGpKdGt6NUhNTXkwMU1OOEU5Z0dZclgvM2Z3a01naFJ2UmtHSVBYVm1LV213?=
 =?utf-8?B?aGJyZmg0Mkw0bjVibTVhU1VrN1V5UVltUkFHY3pLZTdDVjhsb09lckxKYWx0?=
 =?utf-8?B?WVpMTWdSUXpIcHlQWmJ0S1R1VGJGQWwrNGNGV0swWGM3eGdpZWJTNmtDcDFY?=
 =?utf-8?B?T3FyeTdjcnlULzZ2dkFhR1pIdWtQRDYxcTYyWGowWXBsZmlzOFJWQStMWjJ1?=
 =?utf-8?B?TllrRUZKZ0xmUEgvdlJLeGQ0WWdlcU1LNFJHY0U5bHFUUHBkVUZsU09GUVVS?=
 =?utf-8?B?OUk0dncrSzZpRTVVOTE2TVFXREcxSmF2WWJObERmdzluZWFYRmUvMkxCd3oz?=
 =?utf-8?Q?xrn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64433ae3-8ff2-4671-a02c-08db2964f3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 17:02:56.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncIL+ApsHoIWpqSx0DZ+jRqybpTxRKgoF0RH9z2xoIvZMOiHiu15gEPunwBzVNIPcs1LtIpdjn3qJxU2UTWq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7597
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIE1h
cmNoIDIwLCAyMDIzIDExOjI3IEFNDQo+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
IHNoYXduZ3VvQGtlcm5lbC5vcmcNCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBm
ZXN0ZXZhbUBnbWFpbC5jb207IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51eC1hcm0tDQo+
IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9y
Zzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRD
SCB2MiAxLzNdIGR0LWJpbmRpbmdzOiB1c2I6IGNkbnMtaW14OHFtOiBhZGQNCj4gaW14OHFtIGNk
bnMzIGdsdWUgYmluZGluZ3MNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gMjAv
MDMvMjAyMyAxNzoyMiwgRnJhbmsgTGkgd3JvdGU6DQo+ID4+Pj4+Pj4gKyAgYXNzaWduZWQtY2xv
Y2tzOg0KPiA+Pj4+Pj4+ICsgICAgaXRlbXM6DQo+ID4+Pj4+Pj4gKyAgICAgIC0gZGVzY3JpcHRp
b246IFBoYW5kbGUgYW5kIGNsb2NrIHNwZWNpZmllciBvZg0KPiA+PiBJTVhfU0NfUE1fQ0xLX1BF
Ui4NCj4gPj4+Pj4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogUGhhbmRsZSBhbmQgY2xvY2sgc3Bl
Y2lmb2VyIG9mDQo+ID4+Pj4gSU1YX1NDX1BNX0NMS19NSVNDLg0KPiA+Pj4+Pj4+ICsgICAgICAt
IGRlc2NyaXB0aW9uOiBQaGFuZGxlIGFuZCBjbG9jayBzcGVjaWZvZXIgb2YNCj4gPj4+Pj4+IElN
WF9TQ19QTV9DTEtfTVNUX0JVUy4NCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pj4gKyAgYXNzaWduZWQt
Y2xvY2stcmF0ZXM6DQo+ID4+Pj4+Pj4gKyAgICBpdGVtczoNCj4gPj4+Pj4+PiArICAgICAgLSBk
ZXNjcmlwdGlvbjogTXVzdCBiZSAxMjUgTWh6Lg0KPiA+Pj4+Pj4+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBNdXN0IGJlIDEyIE1oei4NCj4gPj4+Pj4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogTXVz
dCBiZSAyNTAgTWh6Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEkgd291bGQgYXJndWUgdGhhdCBib3Ro
IHByb3BlcnRpZXMgYWJvdmUgYXJlIG5vdCBuZWVkZWQuIElmIHlvdXINCj4gPj4+Pj4+IGhhcmR3
YXJlIHJlcXVpcmVzIGZpeGVkIGZyZXF1ZW5jaWVzLCBjbG9jayBwcm92aWRlciBjYW4gZml4IHRo
ZW0sDQo+IGNhbid0DQo+ID4+IGl0Pw0KPiA+Pj4+Pg0KPiA+Pj4+PiBDbG9jayBwcm92aWRlciBk
b24ndCBrbm93IGZpeGVkIHZhbHVlIGFuZCB0dXJuIG9uIG9ubHkgdXNlZCBieSBjbGllbnQuDQo+
ID4+Pj4NCj4gPj4+PiBTbyBtYXliZSBmaXggdGhlIGNsb2NrIHByb3ZpZGVyPyBPciB0aGlzIGRl
dmljZSBkcml2ZXI/IFJlcXVpcmluZyBieQ0KPiA+Pj4+IGJpbmRpbmcgc3BlY2lmaWMgZnJlcXVl
bmNpZXMgZm9yIGV2ZXJ5IGJvYXJkIGlzIGEgYml0IHJlZHVuZGFudC4NCj4gPj4+DQo+ID4+PiBJ
dCBpcyBub3QgZm9yIGV2ZXJ5IGJvYXJkcywgaXQgaXMgY29tbW9uIGZvciBhIGNoaXAgZmFtaWx5
LiAgT25seSBhIHBsYWNlIHRvDQo+IHNldA0KPiA+PiBmb3INCj4gPj4+IFFNIGFuZCBRWFAuDQo+
ID4+Pg0KPiA+Pj4gVGhlIHNpbWlsYXIgY2FzZSBpcyBuZXR3b3JrIGRyaXZlciwgd2hpY2ggcmVx
dWlyZSBhIHNwZWNpZmljIGZyZXF1ZW5jeSBhdA0KPiA+PiBjbG9jayBhc3NpZ24uDQo+ID4+PiBH
ZW5lcmFsbHkgZnJlcXVlbmN5IGlzIGZpeGVkLCAgY2xvY2sgc291cmNlIG5hbWUgbWF5IGNoYW5n
ZSBhdA0KPiBkaWZmZXJlbmNlDQo+ID4+IGNoaXBzLg0KPiA+Pg0KPiA+PiBJZiBmcmVxdWVuY3kg
aXMgYWx3YXlzIGZpeGVkLCBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHRoaXMgaXMgaW4gRFQNCj4g
Pj4gYmluZGluZ3MuIEkgd291bGQgZXZlbiBzYXkgaXQgc2hvdWxkIG5vdCBiZSBpbiBEVFMuIFdl
IGRvbid0IHB1dCBpbnRvDQo+ID4+IERUUyBwcm9wZXJ0aWVzIHdoaWNoIGFyZSBhbHdheXMgdGhl
IHNhbWUsIGJlY2F1c2Ugb3RoZXJ3aXNlIHRoZXkgd291bGQNCj4gPj4gZ3JvdyBjcmF6eSBiaWcu
DQo+ID4NCj4gPiBBbHRob3VnaCBmcmVxdWVuY3kgaXMgZml4ZWQsIGNsb2NrIG5hbWUgbWF5IGNo
YW5nZSBmb3IgZGlmZmVyZW5jZQ0KPiBwbGF0Zm9ybS4NCj4gPg0KPiA+ICAgICAgICAgICAgICAg
ICBhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJTVhfU0NfUl9VU0JfMiBJTVhfU0NfUE1fQ0xLX1BF
Uj4sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xr
IElNWF9TQ19SX1VTQl8yIElNWF9TQ19QTV9DTEtfTUlTQz4sDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWF9TQ19SX1VTQl8yDQo+IElNWF9T
Q19QTV9DTEtfTVNUX0JVUz47DQo+ID4gICAgICAgICAgICAgICAgYXNzaWduZWQtY2xvY2stcmF0
ZXMgPSA8MTI1MDAwMDAwPiwgPDEyMDAwMDAwPiwgPDI1MDAwMDAwMD47DQo+ID4NCj4gPiBzb21l
IHBsYXRmb3JtIHVzZSBJTVhfU0NfUl9VU0JfMiwgb3RoZXIgcGxhdGZvcm0gbWF5IHVzZQ0KPiBJ
TVhfU0NfUl9VU0JfMy4NCj4gDQo+IFRoaXMgSSB1bmRlcnN0YW5kLCB5b3Ugd3JvdGUgaXQgYWJv
dmUsIHNvIG5vdGhpbmcgbmV3IGFuZCBteSBjb25jZXJucw0KPiBhcmUgc3RpbGwgdGhlcmUuDQoN
CkkgdGhpbmsgRml4ZWQgdmFsdWUgaXMgbm90IGdvb2QgcmVhc29uLiBBbGwgcmVnIGJhc2UgYWRk
cmVzcywgaXJxIG51bWJlciBhcmUgYWxsIGZvciBmaXhlZCBudW1iZXIuIFRoZSBzYW1lDQpMb2dp
YyBjYW4gYmUgYXBwbGllZCB0byBpcnEtcHJvdmlkZXIgZHJpdmVyLiBCdXQgd2h5IHN0aWxsIGJl
IGRlc2NyaXB0IGluIGR0cz8gSXQgaXMgaGFyZHdhcmUgcHJvcGVydHkuICAgIA0KDQpodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92NC44L3NvdXJjZS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvY2xvY2svY2xvY2stYmluZGluZ3MudHh0DQpoYXZlIG5vdCBzYWlkIHRo
YXQgY2FuJ3Qgc2V0IHRvIGZpeGVkIGNsb2NrIGZyZXF1ZW5jeS4gDQoNClRoaXMgaXMgcXVpY2sg
Y29tbW9uIGNhc2UgZm9yIG5ldHdvcmssIFVTQiwgU0FUQSwgUENJRSwgIHdoaWNoIHByb3RvY29s
IGRlZmluZWQNCkZyZXF1ZW5jeS4gIA0KDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92Ni4zLXJjMy9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2F0YS9x
Y29tLXNhdGEudHh0DQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4zLXJjMy9z
b3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9xY29tLGR3YzMueWFt
bA0KDQpTdWNoIGZyZXF1ZW5jeSBpbmZvcm1hdGlvbiBpcyBuZWNlc3NhcnkuICBXZSBjYW4gcHV0
IHRvIGR0cyBvciBjbG9jayBkcml2ZXJzLiAgVGhlIGNsb2NrIGRyaXZlcg0KQmVjb21lIGJpZ2dl
ciwgb3IgZHRzIGJlY29tZSBiaWdnZXIuICBJIHRoaW5rIHRoZSBrZXkgcG9pbnQgaXMgaWYgcHJv
cGVydHkgdG8gZGVzY3JpcHQgaGFyZHdhcmUgaW5mb3JtYXRpb24uICANCg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
