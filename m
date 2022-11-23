Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF5635BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiKWLfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiKWLe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:34:59 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB9488FA1;
        Wed, 23 Nov 2022 03:34:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpSQ5iv/VpXw6NwcVbfQroGhBv4uzAoCCj2JYUR8NvQBPgQdwz3dh/7ciFFAN3nlZXinlXv9EFZV4JNgZ805IFF9hBnrqtY/qhTciR9cH/3PkdN1Gv/rw+b9YB9+apKiV3O0AEmX1+uKBGqP0cRVd9CxWSublUzKjJ5Cs5XUoakTiZRUtUPDvQuyypQlcPOcimxL9NeqFKWl24aF4MR/dZiap4iQnDBmoGGSuoC0kMdiiQi1PQhhNDdTkyaFZ9EUr/nP+glbTs2Q4xymblKdUlsEgKuYBXuT59dEKZElb8qj//cWOz0yKZaJ8JmzKzQALbSy3m5Vgqs3At6ghHvh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3pdXDo0hlhSaX8pn8zvfRMzWlX1k3YnB44t8AGsCRg=;
 b=lbzb2754S3Un+Rs5JsWZosz5kDJNAMTBpcOX/N6i5nevhWAiTyB454kJhp0XaK4CYhptjosuOnwfnpIAuwhEJD5TyNbsEDsw5Q+JxmnZmTwlKqPt0keEAIVkyvLvHCRsjE15XGOmgsTwRMQWoPjb5K0tRHrQ9l6Olfo4eO1HMiqLFgQgO6yvk+aki3eOtQrlzmYDgBRioggfETda7IguUARvv3QM3JwFgwv/lSE1IrLBlw2OxUsHwAfmuJ9ZBPxhGhFmO3CvZoNsSGRUu1UgJqvF5Y8iNXxDb+0/AoJr7/yyedJFORWCLIzA8HTA6O4RMUeoToeB/pQXt5suQ0DanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3pdXDo0hlhSaX8pn8zvfRMzWlX1k3YnB44t8AGsCRg=;
 b=mFYBPDwJ1oJdYW5QcPaOVGmPWmJQskf07ntlkdkl9pO65LMYmWEQstcREFInjJ+jVAkKc3Y7SEtyVBPvhZOX100QTK6KDQOTTkzHGLIxl5Hn+A5gpG4hN8RwDr3s/rXSP16ec+qF3a9CbwZK7NQDWBLTLo4L/wo524o+y1oz7f0=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB7655.eurprd04.prod.outlook.com (2603:10a6:20b:292::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 11:34:55 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 11:34:55 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 5/5] tty: serial: fsl_lpuart: clear LPUART Status
 Register in lpuart32_shutdown()
Thread-Topic: [PATCH V2 5/5] tty: serial: fsl_lpuart: clear LPUART Status
 Register in lpuart32_shutdown()
Thread-Index: AQHY9N0vT16321PxhkCpnjSTC/9M9q5MZSEAgAAPrcA=
Date:   Wed, 23 Nov 2022 11:34:55 +0000
Message-ID: <AS8PR04MB8404E8AD2739F5C2DD79ABBE920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-6-sherry.sun@nxp.com>
 <9c4a8eb97e6566c8a704d69b176d889b@walle.cc>
In-Reply-To: <9c4a8eb97e6566c8a704d69b176d889b@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB7655:EE_
x-ms-office365-filtering-correlation-id: 0a0be90c-69ea-44ef-8b98-08dacd46bed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SY+utiFvtyW4uemK3N6p08/Yfk7g+pmftMUuhUYlAeZqwW56ehHivsk4JKWkFAy3xeETrkXZoQcOXJ0pRmInuLJTNE2rslh2F4NfXQhOw2CJJ/BVsVXWb1T6y9Jx7KeVp5UQ3NduuBA1Xs71mJB+Mvg0//HA8qxeY/8uJBBUjBxCUQaIQcAylWTx+XU+/4o5vA9VeTRXqzcj7H1fG94kPrQ/6LQyBvX7a0wvWNN6wDodDqv7r5GRoTVl07GbZG/GsQQ1Cdp30/xgWYYZBQ1d8dltcXmoIkzvvZhmxO2BzwGFa3ccBPAq7aAWpmb/V6RJzVmqvbqVzUIWXoFokifYUUQ2Q4MfyBqi95lZ39PhC6b807QzklggKIC+owsc8iVnF7GfSAFaztZPdGwkd15wo2Rot3Sn4vbZH1QBsuNrOMSWWY+nL6DSsfy5mFnpwu8JKWYQRuE9C67pQq+tHlSWFldW1Vy3xf1MS1AQB8C8Jz4koS4LtIXoqPKemAiHeP+dVJMcpuVoUI22ojhlr2YZcU1/2Ld0kS7t1uSh3xUoY8EWlwxV5HtwE+80ZAF4bGIH14B1dlN4Z5jDCKm2GEp4l5DzKAsvmBrUBUOIlIqTNi4rSbdeT2a2G2jLitW+uZPTabntjNdX68rGKOiwt3AfoDiXzQYY+RvgMfcKmClUJsYFXe9X5mJqw/HShZ1qFjZCoHg6DfMigt4TJmbknTcaqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199015)(4001150100001)(83380400001)(2906002)(33656002)(55016003)(76116006)(41300700001)(66446008)(66946007)(66556008)(186003)(66476007)(86362001)(64756008)(38100700002)(6506007)(53546011)(6916009)(54906003)(122000001)(38070700005)(8936002)(7696005)(5660300002)(316002)(44832011)(8676002)(4744005)(52536014)(4326008)(26005)(478600001)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d25SeS82anQ0YkZPc00vZ2dHZFdHWTdnL2oxRHgxR3doTjh1RG85V0h2ZUFV?=
 =?gb2312?B?TVZlb0o5bHFiKzZpSjgyS3Nxalo3dnozSitiRFY2UHN1SWR1NmxkVWZTMi9r?=
 =?gb2312?B?S1dsdU92dHRuVVpjR2hqcmNVb28rUllBcHVBUkFvNncxNVREM2xpRE5yeVR5?=
 =?gb2312?B?RThmYktXZGpZUWpyaE8vdlZWSFQ4bGpkbmh0WlNEN1RSamMzWnhuTmhwQmcv?=
 =?gb2312?B?OVN1YzBsZk0vaG9qQVN6Wit2SEhMZzUzbjRMemlFeGltQ3Vra3BtclZTS0xT?=
 =?gb2312?B?TGN3ekdwcGN5dE93akpXd0t4NFoycmlmTmhWQnVTcXpjdWVhcXVyUHJ2ZHVs?=
 =?gb2312?B?RkVkdXBSL2RtWEZDY2N3SUwvU085SjJvY2o1UHErU3lrSWY1TEJPa1JxRWJG?=
 =?gb2312?B?Tjh2U1Y1aVhMRTlTUjh0OUMybk1Idk9iSXRoSDZvMTN2bUh2c3FjZVQ5eTZN?=
 =?gb2312?B?K0FJcnRpdWlMcVhlOTNDVi9aWVlVMFhvRXk4U2dIaDdUMC9vM1M1UENLTTJT?=
 =?gb2312?B?bFMvZEoyOGZ3ZFJXNU14MzhXODNqSTU1QWY4anlNYno1bkFIYUdwTmk0bnVN?=
 =?gb2312?B?MVJqYW1ZUkxnaUZtYlVMWVRLQnhiNmtlc0kvTGlLeXE5cjNKQkt2S3hVUHJQ?=
 =?gb2312?B?aFdEVXJNcE5qM29wNERzcW9TOTlmN25mOHAyVXV2czlKTHRLVHQrYkkzdVJP?=
 =?gb2312?B?QmxvcVhna1R4L25LV0FhT20xd3VDbkYreDZEc0UvZlBWd2JWY1dGSXVnU05a?=
 =?gb2312?B?cCtVZDVKY2dKd3NKV3JwRmZpWFJlbDRvK1oyMXpSMFhiMHR2aW9qRmg5Ync1?=
 =?gb2312?B?RjZKcDcrM08rQ3VuRzFaSndHazVIOEI1T3BQSGFNc2dzTThHbG9KdkErbTBM?=
 =?gb2312?B?bUpkYlpuWHVXR04vUlRFR01JaXM5Ni9OSVZrOWpqeHlFL2FaYUNXWHJMaFhV?=
 =?gb2312?B?N0FDQXFVSU9rMy9SdWxjeC85MVVKTmZoVGRBUzBsaFdQMGRwbWJpbjA0ZERu?=
 =?gb2312?B?ekFyNEFRYXljU1VXUDhoZk95dFo0bml2TTEzeitEM1dBdjVTLzczK3ZrNjcv?=
 =?gb2312?B?djltVktkcENhT09wYzd3UG1zQUs0WDlTakhLVHZZWVVUWEZuYUtDSS9zQ01l?=
 =?gb2312?B?OTAzekt3bWFkbkhQNGVMamM5UkNac3pYQ2U0RVBHcHhSWkM2YTZZVGVFaEZD?=
 =?gb2312?B?aTdOaVJ5am10VThPaDJCdUVlUGVwSVkwSkQ0WDNTMURLUjgybTJQMjJYS3hw?=
 =?gb2312?B?ME9BUENDQzNmdmQ1aGR5d01GcEs1Rm5LZTcwS3BIaG9YOHloZUQzQjNUZmg3?=
 =?gb2312?B?c1hmdnk3amh3RXowQkwxOWl3OEZCRVc0L1ZqM3FhcldoUklhK1NxbFJZdmQw?=
 =?gb2312?B?dk50SFdKUnFkT0ZoREFXZ016Z0oraFhUU2Z5ZzlPa2QrWlJrQUJTME5BSVFC?=
 =?gb2312?B?M3BDbGJaZ3p6bFJoL01jRnVWc1pHclZ3cDFvYzljTVpaMFk0SjFKR0prcFJk?=
 =?gb2312?B?WG9DUDBhRVJvODZrcUczODFVdU5hWXN4MzVMMkJLczRkSUxqN1d3REJyRjJi?=
 =?gb2312?B?ZGNVM3JQb3J2bjY3aHlDV2l2eWl0QnhpZ24rRktzWXdYYVJwRms5V2NncUph?=
 =?gb2312?B?RndiRnhKaGdBYWE0YnpOczBFR0QwWXNtOTdlZTNTZUorQlNTL2pzY1ZqcVRr?=
 =?gb2312?B?ckpEc2JJdWZpYmNkNlJuRkRvVGpjSkFsbWRpUmlkUjZHZktDYUFHZ1NqWGZC?=
 =?gb2312?B?bHdmeDZaSnpQNTErcFdJaUgwMHV5WW4vL093WmRnUzZ3Q2xzM0JiaU5ZTWNh?=
 =?gb2312?B?QTRSUFAydGZOZW93RVlhTmcvNmlyTmFpU2wyY1JDYitQYTJpTTQ5QUZ6Lzho?=
 =?gb2312?B?UGFleDhqWXVsOTdpS2dLT2xuNWVMcEtqQXRKa1lzUDJuMHgyZGh1cThpVEcr?=
 =?gb2312?B?K0lmSUhZWDZLRW9FK2ozeUVNTCs5VnRjTnQwRG1pUFVjQzY5QmQ5Tnhva092?=
 =?gb2312?B?QU1sWko5UW1BMitBNmxKRENOOGpoS3BjZ1R6RVBoYUx0Q1lvclhSL0tiSWJ0?=
 =?gb2312?B?TW9oV0svT3RJK1Z0OFZIdVJoZno0YW5QMXVDSE9HaFVQblM2eWxlaU96ckZZ?=
 =?gb2312?Q?W6NZZHaUZFA7KF+WAg5YhRLQ5?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0be90c-69ea-44ef-8b98-08dacd46bed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 11:34:55.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+fvvDki1iNnn2ketulkPCW/cOrO+l6qdLScgNVgYoaA3afgTMEKAbrcv8v+KdLzbSUbFgkt0JKXaSqUld8Row==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4NCj4gU2VudDogMjAyMsTqMTHUwjIzyNUgMTg6MzYNCj4gVG86IFNo
ZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOyBqaXJpc2xhYnlAa2VybmVsLm9yZzsNCj4gamluZ2NoYW5nLmx1QGZyZWVzY2FsZS5j
b207IHRvbW9ub3JpLnNha2l0YUBzb3JkLmNvLmpwOw0KPiBhdHN1c2hpLm5lbW90b0Bzb3JkLmNv
LmpwOyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCBWMiA1LzVdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBjbGVhciBMUFVBUlQg
U3RhdHVzDQo+IFJlZ2lzdGVyIGluIGxwdWFydDMyX3NodXRkb3duKCkNCj4gDQo+IEFtIDIwMjIt
MTEtMTAgMDk6MTcsIHNjaHJpZWIgU2hlcnJ5IFN1bjoNCj4gPiBUaGUgTFBVQVJUIFN0YXR1cyBS
ZWdpc3RlciBuZWVkcyB0byBiZSBjbGVhcmVkIHdoZW4gY2xvc2luZyB0aGUgdWFydA0KPiA+IHBv
cnQgdG8gZ2V0IGEgY2xlYW4gZW52aXJvbm1lbnQgd2hlbiByZW9wZW5pbmcgdGhlIHVhcnQuDQo+
IA0KPiBTaG91bGRuJ3QgaXQgYmUgY2xlYXJlZCBvbiBzdGFydHVwIGluc3RlYWQ/IFdoYXQgaWYg
dGhlcmUgd2FzIHNvbWUga2luZCBvZg0KPiBldmVudCBiZXR3ZWVuIHNodXRkb3duIGFuZCBzdGFy
dHVwPw0KPiANCg0KSGkgTWljaGFlbCwgc2FtZSBhcyB3aGF0IHdlIGRpc2N1c3NlZCB1bmRlciBh
bm90aGVyIHBhdGNoLCB1bmZvcnR1bmF0ZWx5IHRoZSAuc3RhcnR1cCgpIHdvbqGvdCBjbGVhciB0
aGUgc3RhdHVzIG9mIHRoZSB1YXJ0IHBvcnQuDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQo=
