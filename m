Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF21B63D29D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiK3J6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiK3J6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:58:14 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4962B185;
        Wed, 30 Nov 2022 01:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUxQa6490LdVUXibfF7L0sk4QQoX4q/HAlkOCLpu137dl06oEoPGJEHNj/ND3LvSHXQZRWHo5reA1m9ze1EIp6r0aFJj9AKNj586Q6nw1aOy9Pjvzcl+m9DeWREW8MmNG037GDrlztcPruU8if8pTqL694xPFoCscQlPgqIYYWiChSAtFQo5e5SVzglR5L5HJ7wtW1X+5JPPoAxGs1dIbIbWfp7AoWbawnBnz4pSebURjjR6ULW9Yn5+1VafZ/lWuJLqKFJtuqXiSe308rTkAdmmEujRGL0jnzKlbbxKa8nJAnsxaU/4oCJBI1RGrh62I7xI5mo3DfJGMdPblKzOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiDY+3d1u+WoU2ktmTSe1v2hQ42C+ZuDGN/LIN8acpE=;
 b=T5J8UfrWCe1QRPGiXpZF2X0HnN0DB5qHLA+t/sYIdvcA0sU2E+Asi6/GHucLMSoY6CnKrKAr3zIpSDD7K/sA8Z4GniFwd/Ux0D2Xe/F5i+O8NjCS0VzvVcFali/nLmW5K9ocJanu9PhscRlJHupE4py36MQ7g7b8JWl3Gjtmqu37ZSBuEJUXP5EFRE2qbBGcJ/rNfgBQm5yiny72jCrAIHG+lvM11Daw9IEaEoJlNnanbQe+al/BW2pf75x0i03dPWGuH+RUCQrS2z/IcUTy3cUlJLdfUeggEHZqdl9c6+OWge47OpJcn2o24TpcsvckIfMQbxGnTl+U/3czLdzwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiDY+3d1u+WoU2ktmTSe1v2hQ42C+ZuDGN/LIN8acpE=;
 b=Nh+m9cV7M8F4dHbEKJvtkTavU9GuGqborUwt0lmv/turEPXFchYwdMAShP/MNQODKRflidQhYYCy7M0W3W4mne2RuCK8H64Jop1rq5ZV9Rw3uN6Z7EVnwGEX3jOq0o7mgP0NBqkzhKdrLXxe32Rf0bKMIZJtTOgEBTQQsR0Vov4=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB8PR04MB6780.eurprd04.prod.outlook.com (2603:10a6:10:f9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.21; Wed, 30 Nov 2022 09:58:07 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 09:58:07 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Frank Li <frank.li@nxp.com>, Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:NXP i.MX 8QXP ADC DRIVER" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Thread-Topic: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Thread-Index: AQHZBBIUlqmzwqloNUOgnXwBwjHtL65WG9cAgAEfRGA=
Date:   Wed, 30 Nov 2022 09:58:06 +0000
Message-ID: <DB7PR04MB401094B273FB9F851CE9A06190159@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221129164531.2164660-1-Frank.Li@nxp.com>
 <20221129164531.2164660-2-Frank.Li@nxp.com>
In-Reply-To: <20221129164531.2164660-2-Frank.Li@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DB8PR04MB6780:EE_
x-ms-office365-filtering-correlation-id: f73e4236-c38c-49b9-c481-08dad2b9617b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdqhAvmbwwYijM2fhlZYD7IzEJorsxzv/kWXX2gfhBOAmhOiSfTyczxYFl7NOry3DgWMR5GYXfRv005RMWpFx5YUTPgGX1YZekTXZNaZtf8lfB0E43DdkQbtga9pknk8BPPoJL6FFfXgRdVZattPlGhNz80yCLWMH6Z9kh9TYZlUzNB3anpS6gZOYMXoQsGbPesWyKQYi9T84yDzg8E/UBuh6xlRWFkKxZBNnReiMa8pRYx29neVjxmuL+yJEcgTaynZR2yZeYKWPzohR6D8oYyJNWEZMRbiT+aAtEK1unYuO7+MaE/lyx/odnL4pQ03O/k3wCKu6AJUg7BBQxQ0p5lWldKqlyDAnn96koXXZStslh4aB80kgAnzydHIIxX5l2I5vTVbW0JGx7rBNprPoE8DEUevmPy6dV1Z7PhOI+P2ozhmO8EeoZk31bYYh4vF7Mc1DtiiZOHDa7EynZqt6SV2PEhhVF0imHMJu9vAZs5CX/7P1keRGZE7MkYV4cLsf9dNeQQUd6AYpgN1EgdDQo78KMqGkSJexCeYdJjvdOjzv9WIScs+tgq9XBFK2nAwvD77gtA2MErSjxsce+XIZd1OGKcFaUq8LL6p4fQHjZHpgUT+AoHCmOrNEcSZv4qW/HM5hCWTCXrLNzmDV4Km+Z92xlCHCil4TkkC7M2QHsGeR1Ylw63ZVTijIj/DK40py2UUpYc98gfc3U+dbUgsJ8buxQYip47jtO4F9YtTN5sz4aaC+rKq/lhjehJTjA9I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199015)(316002)(122000001)(53546011)(38100700002)(6506007)(7696005)(41300700001)(26005)(8936002)(52536014)(5660300002)(186003)(7416002)(86362001)(66556008)(4326008)(66446008)(66946007)(8676002)(66476007)(921005)(9686003)(64756008)(71200400001)(110136005)(2906002)(76116006)(33656002)(83380400001)(478600001)(55016003)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WjFwUlBYYWNEOEVNSnpFWFp6M2xSNEMvM1dHenFDdk1zK3FiTUowalBoRm5P?=
 =?gb2312?B?TGkzMTRybzgrbmFJaG4vMXBzc09mYlZSR2xkcjAzT2tISXZrZ3VjVytuZ28r?=
 =?gb2312?B?Nk1qUW4zSjBYd1c5WFZkQURldUxKTGpjaktkdXM1QWZJNlVONXhtSUI5QnF5?=
 =?gb2312?B?M0d1TysvL3pnL1BtTXBES2k4MXp2alcrUUNQUDREVjFXMkpCUmVaaXBxVVJ4?=
 =?gb2312?B?aUcrcElWOXdicVFmWDZZUVRVT05BN0dHcFZVYmZZbGdNSk1laHErRUZYUGh1?=
 =?gb2312?B?T1kzQlpWNWZSQkpsOHY1cDN0d2tSVTh4Z0RReFZOcWhTNGl2UWFHYjhMMUxk?=
 =?gb2312?B?QWpLTGRYT0p6OHdQRStveml6SUhWVEx5OTZCL0IxeisxWHB2TEFKNytoWm5p?=
 =?gb2312?B?TkdKOVc3dzF4QmtxVk9yNUZYamZ3Z0p1ZEpRM2w4aXF4V3dxMXhycjRrQlM3?=
 =?gb2312?B?aTNXRFZ1SUJwM1QrWkF2VlVWejBqV2FyT0d6ZkxOUHV3NjhsVFFIempTbTZF?=
 =?gb2312?B?YkJoMm9LdHJoTTlud3FoeUg0aDc5WS9nQ3JsS09rVTB6UnU2R3BRbzN5VXVE?=
 =?gb2312?B?WGNWaHNiWWJwdHNpamlTeTVRNWZOeVU1dXljV2pWdXJWbUM5dUFBcXR1SE50?=
 =?gb2312?B?NGI5UHFLTGFYdHNnaFRnTk92dzUrVTR4NHB0TUlaaVJSdnBjTm45dUxEY1U0?=
 =?gb2312?B?TW91L3ZzQ3lvTENCeHFaeVEyVEFLdWUwWlIwaDh1cEREVGFnd1N0azBZQUQ1?=
 =?gb2312?B?Y1k3cEdOT0Fnc3BRK0xDWUQ4QjdvYjJxZnFYQUlmU2pHZEx6U2ExbVVOY2Jv?=
 =?gb2312?B?cmFzcWQ5elJYenJwd2xiSG0reTJpQ2xza2pDU1hvSW8zcVo3RDUzejhyNFRn?=
 =?gb2312?B?VU84Zjk3THBIVm0veFRIU005NmtzUFpkaVFQRG5WUG1XbTdrVDdGRklKZEc2?=
 =?gb2312?B?bGhReXJYYkF4cXdZdUFWcXBIWU1QVFYvUHgrQUlrY0V1ck1iS2F1Nk5UZjBt?=
 =?gb2312?B?MTRTY3h0T1JjeE1VME13aWlpdDNDUHQvT2dpcDdjMGhhMWhZT0JPNCtBRW5X?=
 =?gb2312?B?VkI1Z3ExcFhCb05tU2JNSGNTTFVDaCt2ZzV4bmRWVnFnc1JjZmcrdjVPWGFE?=
 =?gb2312?B?dURrd2FteDVzTUtmb1pOVFVnYjlRWkZPd0lsNTRyOThxUUFjbVU1Q3AyODV4?=
 =?gb2312?B?czRIZm84UXgzUEljS0Z0MzVjVEx0U1RJK3BFWjh5WHJBR2R2ei91NGg2d04v?=
 =?gb2312?B?cW55RVowb3gvcGtzS29PbWNJMTd6QlhFL0lGdktCWTlzUTg4aXJrNU1mM1RM?=
 =?gb2312?B?NmhCckU0QU85Uks0cVlnbmhjSTRheEx3SEdPYUl2Q1B0SlFucWxYc3hrV0gv?=
 =?gb2312?B?VmJzYkN4MVAvMDM1NGprdXQ5WUg2MjZsb0Z4U09ZOW9GRVk4M2xZV2todjQx?=
 =?gb2312?B?bUJxYlRvcDJ3dmNzaU4yeTdFZ1hhdm9FZmcxaTFRcjJEZEtZUEd1UE9veDVk?=
 =?gb2312?B?bkJXV2VqR29GUkVlQWYvU2JDVUY3c3VXWlIyb1E2SkRjRGxjY1ltSk9FSGRS?=
 =?gb2312?B?VnMza29TTE92Y3JvQkhsbE4vY296MkM1Wm9iNXhxRmEyY2dLMGJ2T082bTU2?=
 =?gb2312?B?WlQ3V1VSRnFtellxOEpoNGpkY3VybWpiN01FT0lweEIzMnEvYzhNOE5xUFVF?=
 =?gb2312?B?RGt3TmZBaDBwZkx1Vm9ZdHAzSFU2REQrbHRyaTZmVmh0dUVGYk9TUWs5cHNi?=
 =?gb2312?B?WG9kVnk0N0c0bDltNHJVVmJTL29zd0lxYm0veGZ6QlIrTzRuS3lpK1BNNVRH?=
 =?gb2312?B?dVp6QWwyWmhXcmxsOUJFYklodWtwZXNwNTRUZzNxbzg4L2luT3dpQzluKzVH?=
 =?gb2312?B?NmYwL1BiL29LYnd4RzM3S1pTcXdhaTVuRlMxY2trdWo2YzJ5VVo3bVNta0wz?=
 =?gb2312?B?Z211Yk05blJRTlVha0lHRm55K0I5a0tSUjl2ZVBLN1VKSFZkc0R6b0Y5S09Y?=
 =?gb2312?B?SjVSbW1rMGovUHhlUVZvVVZPOXYvQlpTM20zZGdCMEpRMTUrelo5TFRMNkph?=
 =?gb2312?B?cTFXRUo3S2QxRGpRRTZDNWtPZEFTRUo0MWlnajk0TEU5UjlYNXp3aUdUSnpM?=
 =?gb2312?Q?Gmw8ZwAO3nkE8TYyCP4JVLuF6?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e4236-c38c-49b9-c481-08dad2b9617b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 09:58:07.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMKFs63TvzEqrBiPQQorCGjICYGDjHJLUOg3ETeEHYO1SKMAeNVYp28tI5VCO9mB4lg8aMu9wf7FEmEbg/4WWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6780
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyMsTqMTHUwjMwyNUgMDo0Ng0KPiBUbzogQ2FpIEh1b3Fpbmcg
PGNhaS5odW9xaW5nQGxpbnV4LmRldj47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47
DQo+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVz
ZW4gPGxhcnNAbWV0YWZvby5kZT47DQo+IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47
IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47DQo+IFBlbmd1dHJvbml4IEtl
cm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtDQo+IDxmZXN0
ZXZhbUBnbWFpbC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgb3BlbiBs
aXN0Ok5YUCBpLk1YDQo+IDhRWFAgQURDIERSSVZFUiA8bGludXgtaWlvQHZnZXIua2VybmVsLm9y
Zz47IG1vZGVyYXRlZA0KPiBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNISVRF
Q1RVUkUNCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IG9wZW4gbGlz
dCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IGlteEBsaXN0cy5saW51eC5k
ZXYNCj4gU3ViamVjdDogW1BBVENIIDEvMV0gaWlvOiBpbXg4cXhwLWFkYzogZml4IGlycSBmbG9v
ZCB3aGVuIGNhbGwNCj4gaW14OHF4cF9hZGNfcmVhZF9yYXcoKQ0KPiANCj4gaXJxIGZsb29kIGhh
cHBlbiB3aGVuIHJ1bg0KPiAgICAgY2F0IC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2Uw
L2luX3ZvbHRhZ2UxX3Jhdw0KPiANCj4gaW14OHF4cF9hZGNfcmVhZF9yYXcoKQ0KPiB7DQo+IAku
Li4NCj4gCWVuYWJsZSBpcnENCj4gCS8qIGFkYyBzdGFydCAqLw0KPiAJd3JpdGVsKDEsIGFkYy0+
cmVncyArIElNWDhRWFBfQURSX0FEQ19TV1RSSUcpOw0KPiAJXl5eXiB0cmlnZ2VyIGlycSBmbG9v
ZC4NCj4gCXdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZV90aW1lb3V0KCk7DQo+IAly
ZWFkbChhZGMtPnJlZ3MgKyBJTVg4UVhQX0FEUl9BRENfUkVTRklGTyk7DQo+IAleXl5eIGNsZWFy
IGlycSBoZXJlLg0KPiAJLi4uDQo+IH0NCj4gDQo+IFRoZXJlIGlzIG9ubHkgRklGTyB3YXRlcm1h
cmsgaW50ZXJydXB0IGF0IHRoaXMgQURDIGNvbnRyb2xsZXIuDQo+IElSUSBsaW5lIHdpbGwgYmUg
YXNzZXJ0IHVudGlsIHNvZnR3YXJlIHJlYWQgZGF0YSBmcm9tIEZJRk8uDQo+IFNvIElSUSBmbG9v
ZCBoYXBwZW4gZHVyaW5nIHdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZV90aW1lb3V0
KCkuDQo+IA0KPiBNb3ZlIEZJRk8gcmVhZCBpbnRvIGlycSBoYW5kbGUgdG8gYXZvaWQgaXJxIGZs
b29kLg0KPiANCj4gRml4ZXM6IDFlMjNkY2FhMWE5ZiAoImlpbzogaW14OHF4cC1hZGM6IEFkZCBk
cml2ZXIgc3VwcG9ydCBmb3IgTlhQIElNWDhRWFANCj4gQURDIikNCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9pbXg4cXhwLWFkYy5jIHwgMTEgKysrKysr
KysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2lteDhxeHAtYWRjLmMgYi9kcml2
ZXJzL2lpby9hZGMvaW14OHF4cC1hZGMuYyBpbmRleA0KPiAzNjc3N2I4MjcxNjUuLjNjZmJhNWMw
ZmEzNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2lteDhxeHAtYWRjLmMNCj4gKysr
IGIvZHJpdmVycy9paW8vYWRjL2lteDhxeHAtYWRjLmMNCj4gQEAgLTg2LDYgKzg2LDggQEANCj4g
DQo+ICAjZGVmaW5lIElNWDhRWFBfQURDX1RJTUVPVVQJCW1zZWNzX3RvX2ppZmZpZXMoMTAwKQ0K
PiANCj4gKyNkZWZpbmUgSU1YOFFYUF9BRENfTUFYX0ZJRk9fU0laRQkJMTYNCj4gKw0KPiAgc3Ry
dWN0IGlteDhxeHBfYWRjIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ICAJdm9pZCBfX2lv
bWVtICpyZWdzOw0KPiBAQCAtOTUsNiArOTcsNyBAQCBzdHJ1Y3QgaW14OHF4cF9hZGMgew0KPiAg
CS8qIFNlcmlhbGlzZSBBREMgY2hhbm5lbCByZWFkcyAqLw0KPiAgCXN0cnVjdCBtdXRleCBsb2Nr
Ow0KPiAgCXN0cnVjdCBjb21wbGV0aW9uIGNvbXBsZXRpb247DQo+ICsJdTMyIGZpZm9bSU1YOFFY
UF9BRENfTUFYX0ZJRk9fU0laRV07DQo+ICB9Ow0KPiANCj4gICNkZWZpbmUgSU1YOFFYUF9BRENf
Q0hBTihfaWR4KSB7CQkJCVwNCj4gQEAgLTIzOCw4ICsyNDEsNyBAQCBzdGF0aWMgaW50IGlteDhx
eHBfYWRjX3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19kZXYsDQo+ICAJCQlyZXR1
cm4gcmV0Ow0KPiAgCQl9DQo+IA0KPiAtCQkqdmFsID0gRklFTERfR0VUKElNWDhRWFBfQURDX1JF
U0ZJRk9fVkFMX01BU0ssDQo+IC0JCQkJIHJlYWRsKGFkYy0+cmVncyArIElNWDhRWFBfQURSX0FE
Q19SRVNGSUZPKSk7DQo+ICsJCSp2YWwgPSBhZGMtPmZpZm9bMF07DQo+IA0KPiAgCQltdXRleF91
bmxvY2soJmFkYy0+bG9jayk7DQo+ICAJCXJldHVybiBJSU9fVkFMX0lOVDsNCj4gQEAgLTI2NSw2
ICsyNjcsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgaW14OHF4cF9hZGNfaXNyKGludCBpcnEsIHZv
aWQgKmRldl9pZCkNCj4gew0KPiAgCXN0cnVjdCBpbXg4cXhwX2FkYyAqYWRjID0gZGV2X2lkOw0K
PiAgCXUzMiBmaWZvX2NvdW50Ow0KPiArCWludCBpOw0KPiANCj4gIAlmaWZvX2NvdW50ID0gRklF
TERfR0VUKElNWDhRWFBfQURDX0ZDVFJMX0ZDT1VOVF9NQVNLLA0KPiAgCQkJICAgICAgIHJlYWRs
KGFkYy0+cmVncyArIElNWDhRWFBfQURSX0FEQ19GQ1RSTCkpOyBAQA0KPiAtMjcyLDYgKzI3NSwx
MCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgaW14OHF4cF9hZGNfaXNyKGludCBpcnEsIHZvaWQgKmRl
dl9pZCkNCj4gIAlpZiAoZmlmb19jb3VudCkNCj4gIAkJY29tcGxldGUoJmFkYy0+Y29tcGxldGlv
bik7DQo+IA0KPiArCWZvciAoaSA9IDA7IGkgPCBmaWZvX2NvdW50OyBpKyspDQo+ICsJCWFkYy0+
Zmlmb1tpXSA9IEZJRUxEX0dFVChJTVg4UVhQX0FEQ19SRVNGSUZPX1ZBTF9NQVNLLA0KPiArCQkJ
CXJlYWRsX3JlbGF4ZWQoYWRjLT5yZWdzICsgSU1YOFFYUF9BRFJfQURDX1JFU0ZJRk8pKTsNCg0K
SGkgRnJhbmssDQoNClNpbmNlIHRoZSBBREMgbW9kZSBpcyBjb25maWcgYXMgc2luZ2xlLWVuZGVk
IDEyLWJpdCBjb252ZXJzaW9uLCBldmVyeSB0aW1lIHdoZW4gdHJpZ2dlciB0aGUgQURDIGNvbnZl
cnNpb24sIG9ubHkgb25lIDEyLWJpdCBkYXRhIHB1c2ggaW50byBmaWZvLg0KQW5kIHdlIGFsc28g
Y29uZmlnIHRoZSBmaWZvIHdhdGVybWFyayBhcyAxLiBTbyBoZXJlIG9ubHkgbmVlZCB0byByZWFk
IG9uY2UuIEkgYWxyZWFkeSBjb25maXJtZWQgb24gbXkgYm9hcmQuDQoNCkJlc3QgUmVnYXJkcw0K
SGFpYm8gQ2hlbg0KPiArDQo+ICAJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiAgfQ0KPiANCj4gLS0N
Cj4gMi4zNC4xDQoNCg==
