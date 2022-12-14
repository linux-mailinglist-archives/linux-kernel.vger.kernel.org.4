Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D864C254
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiLNCnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiLNCnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:43:21 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04314CE9;
        Tue, 13 Dec 2022 18:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl6KZj6ZfkiVZT+4LxR/cnfIao+XVpt7LhK8fa38vilLCxvr7DQsHOK6esCqRVFN98ZJpbuwr8xqoKb3BdXG3IWDC7KZNsVWx5VarxqABtP9qw2aDAufHrWu+B9xdo/CHR88Fvh0zhj4VckKJWI0pX9Ond8LOmbgm+hbJGA7ImUngR2JED3/F7QoulxBHXHg4BTvs4POKqrphPfKcZhG46boVE67nwkN3tHZjJIIZf5E8xML5PMYu+o7YcQrlvs3yA4+8QejBxhfq92DplBY/Fwuceeq4SlZnBMUKLd/mxOqz+GnE43h7d2nI0HqC3pH4xt7MKpxwt5KPx2VbjDyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdfsJnmjXPUFCv3KfISIPHhSVPL7tnujtjxT/nwhbSU=;
 b=PlrRZyefZjVg9HrEe2nrPYoQ8MoxaRmyoTB2QbuXKbAzfvzOGSEg65m3ratu0nm7ktilwQIKcBiY4tieULYOIxFcjP3GjkNCcc4IFdL4pKGdb7J6BJUjIYMsRR6vWcDGr4g51nYVcbaZ8FjgjAUiwYO6oHzzA3Daqo07DPEfCYpHMCXMVem33Qr7+UV7ZDibeJZUPmnaMne8wmyTaAcStpXVsN+AgGGdZ7C/fYrQEMdxS7cL1KbVwo+XiDkQ58gBnIRUUdqr0YrdM+RyTAd8NtAuxmdExaAra4Fw/al9A3BStXF4K5YRF/j/1kmTZIh2+uwvue+/9h/1mf/B3zz2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdfsJnmjXPUFCv3KfISIPHhSVPL7tnujtjxT/nwhbSU=;
 b=p2Bs6OCk2BsriInpn7VTlJ0rLcZf4KFih7XAUVAaqXvRzQ2FA59XhKN0nT1fn6ti1rWgJmumTvfFo9tcaVpKt+3UEX9/etL84lUFidTzBpPe6hFcBcDtM2PeUcybA7+1VunE940EwkaJDX1Hbb+37lfJY8R+OBuNCzloRwRrJq4=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 14 Dec
 2022 02:43:17 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 02:43:16 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>
Subject: RE: [PATCH V3 0/3] fsl_lpuart: improve Idle Line Interrupt and
 registers handle in .shutdown()
Thread-Topic: [PATCH V3 0/3] fsl_lpuart: improve Idle Line Interrupt and
 registers handle in .shutdown()
Thread-Index: AQHZALf6SzRM0ICZj0mTAd+zWQtpoq5syguQ
Date:   Wed, 14 Dec 2022 02:43:16 +0000
Message-ID: <AS8PR04MB8404BABDC0FD4FAB0D89534B92E09@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221125101953.18753-1-sherry.sun@nxp.com>
In-Reply-To: <20221125101953.18753-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB8497:EE_
x-ms-office365-filtering-correlation-id: 819d0804-e69a-4c00-99fe-08dadd7cf43a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wAAbHiX67PqF4ikdmA3RhPaJo3GBGAc1oW1ubUshelaRi0VHh932sH0sOCb1sRtZ8PNhTYJLGhk0BTn9rU0fiHtFUzouddInpGCzwNxb92R3f/k7vUI/Qfr5IJ8V8FKxknwvN7hG40xgO2zx/f7GbBF/fjn/z+q/vL3GT50NTWO66eeQUxS/9pQpnKeSTGeoRL7Kn60gZUvuE3EA/7BQ7MYLl9voudVhGW5TaeSUQkyRFeBKcdLtz9PUh1nwRVnE6A3KfcnZ6fkfSFzqVmM8mhSVaTqDiUG7Vl9Xb2iteOqtN/5HtXj/ONuAIG8HNr3Fs7WoDBNSjRuRZM1mnDCreJ9970ju67UfhzAkEFIxEzqt4k06CydrAWtJQB4fHumQo6EMGARlibfc5OKxol5YjdX0vn6O8MS+LxgohlfdC4CBNSB5qw3eUZa31l/ZUzTVn/K0Wrrqk4hK+70mMMfJffPSnEVgD9xNRRgYUmUJ5A5QOe4vCXtpZHvgETbA7//a4WsBemEuVPofrT1mMYvrvGpBEWB2JG2H9thro51B6ie6xC2vK5BjeN63cga5NgZ5U8niyoPDfYJGDA0XlBHH72hiWMfChY3KUruVerdgBH3uXTIl+l+eOn2Td1I0IdKMa6GvBQD89WZwL6zzmAZjmXRbaJ+ZSDyJlhA0L7XyZ/KBeU7scHgdDTvgtIQ+OjTpZ8O+JILgVq92ZVfGqqNBuG2F2uq/1ixcOTaXZJwumgs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(33656002)(54906003)(316002)(110136005)(66556008)(66946007)(8676002)(4326008)(66476007)(38070700005)(41300700001)(64756008)(66446008)(76116006)(83380400001)(38100700002)(122000001)(55016003)(86362001)(7696005)(6506007)(71200400001)(44832011)(52536014)(8936002)(5660300002)(2906002)(478600001)(9686003)(186003)(53546011)(26005)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QXh4WUQxdGFpU2VEczZUZUVzL2xzQ3BqWG1ZNXFmbytESzIzY1lyNXdycmY3?=
 =?gb2312?B?UncwYTVVb1ROWXpDRTFrOHpBeHZwbTNkVjh0eDllRUp4cDFxMVgwaGJRZnZ6?=
 =?gb2312?B?STh6dnVSNW5aUnR1Qnl3MG9iZmhuSzBYd1RvR1o2ZmplMGtGWTlYZGFuekpj?=
 =?gb2312?B?MXhBbU9MV290UngvK0tJdDJQbHJaUUUxMzF4SjBLSzhLM21vd3BiWUNjWFZF?=
 =?gb2312?B?Z0w2MDVYRkp2TWpRc1N5OHlpdHhYc0c2cU9wQTFoUjFibTZPUmJGTWxXT2F0?=
 =?gb2312?B?bERnUUdTcUJ6YjVKR3oyR2RvSUMvWTdqUk9GTm54QmwyZW1NNmJ0YTh3UXNx?=
 =?gb2312?B?Y0FkVGxSVk8wbE0vNHF6am9mVVEyK3NTSWQ4cnNOMXd6TTFvYUF1MVZQQUsv?=
 =?gb2312?B?QmlvSlBUNEtMUVVCaWNpQXpwS3YvU0hMUE1IdmhSM3M4a29OTGlXL2xTdU12?=
 =?gb2312?B?ekJqWHlUOFVKd0Z6SnlETHlFdFNBS1RBN2RjM1RjWCtrYk5mWG5KMXRzY3dx?=
 =?gb2312?B?OTY0MnJvQjhmdXVEWk9wZWw0UUpYVW9RU1RBY0VxempsR3FxdXA3N0x5Yit1?=
 =?gb2312?B?TTVOZU85dks3V0dDUktNYVIzSXMyWUs2U1FGWXA5aXJMQWFQTUJsbTJBTWhi?=
 =?gb2312?B?MzdEaFNKWFllekFSaElQSVZWQVNtTnFsSzdDVVFHc1VoR1A2VDNxQjhwdDZr?=
 =?gb2312?B?b3EzU25ya0hIVVRraitLdkpzc1ZXYjVodFNweDdaMmJXU08yMnlNdWp2SzZv?=
 =?gb2312?B?NW1LaDJGczBYUnZISWxJYkgwSjFpQzlKMWEyOWZRaWNna2xISFpJQUlpL2cx?=
 =?gb2312?B?WkE1M0RWYk1ybDhVWENmdnFUOElVaVRzVitEU0k4SXFMZWtKOStBdkxzczNM?=
 =?gb2312?B?ZlNSVHl4bHEyaDdJZVdvNFcyY1ZGeEhyNmR4blZUREpXa1BJL1Zuam9FV2k4?=
 =?gb2312?B?bXU5M0NGbFlKM0k3Qm9kZG1DMEg0NnBaWENpRDVEaXRnMEc2NDIzeXhsMlow?=
 =?gb2312?B?c2JvS2NNR2ZtK2FOekdnRjVkUDdPZnBiVXdUdlVKc2YwN1loQVZ4L3dSSkM0?=
 =?gb2312?B?ODI3d1ZYUU5sb2tEZFBDYWJVV1hVTFRDelZ2aUk4MkxtcDlHb2xjdXBEWnpO?=
 =?gb2312?B?amhGZjVYcGtUMzUzNUFZdmZJaTFCd25rdFd6M0czbmpxQnkvNXp0ZE1oNTZJ?=
 =?gb2312?B?UkNtOU9kcWQyRFJ5R2NESDNqSk8rZWcyakZ0Tys2WDdOWUN4WExkemZpNXFq?=
 =?gb2312?B?SGZkNG04VkI3Uk1mSTFKcU5VNmdXV0g4QmVHK1ZoSkdOQk40OWFhODV0TEs4?=
 =?gb2312?B?ZlQ1Q1IwNHdGTnpHUkJIc1NCZ2M0SVVZT0kreFp2WEI0dzlmaGdaQ1k2MFpK?=
 =?gb2312?B?RHltc2w0Q2Nyelo4Y0lTZ0VFQ2RBRXBtb3FqRWFXbmJuNk5neTgvYks0dmpY?=
 =?gb2312?B?eEJxK0p3eENrUEJsWnY4R2hjN3o3NVcrd2ZSVmJpTkxxUXJhaWU5dGt6SXdO?=
 =?gb2312?B?K3ArSDJuT1F1VEJnZWZzQ3FMOVRqYVVOU1NuWVRadWQ5N3dLSGVhL0ZIcXdL?=
 =?gb2312?B?eHBOL2Q3bWRQWU9KU3lXc1Z0NDc4aExPV2dGVUN4dWtNeCs3d3VOYnNPclVF?=
 =?gb2312?B?aGZ1aThJZHlIMll1bGgvc0VqbTJtVFVXY3VqRXA4NzZxa29uaTkrVC9yUE1o?=
 =?gb2312?B?STIwUFA4OXFicUVQWFR2clg3NmxrZ0l0WGZMbUFtT3JsRE5EQmMxOWNvSjIw?=
 =?gb2312?B?TVRxNDRocHlZeTBWQm4zOUlERnE0UkZybzhjTHJUOEdHS1dMcys0dCtkMFBu?=
 =?gb2312?B?TVdvZklKd2RUWWlsZnIyR2pZb0dvL1VSQ0J3SkJwblFaVDZ2NTBtb0dSTytV?=
 =?gb2312?B?NXBkeFl0Y3A0c3M0b2RyY3AyYndFZjdvU1czSU1nS0w0S2dXanNJcnFTSzRr?=
 =?gb2312?B?cDlCcnRyWkdwVklXVVVDRERIVnZRNU5WRTljNEIyZ1g1RWhxQ3JzM2N0N2ZO?=
 =?gb2312?B?aVEyS29XaXZ0Nk9Qdkw0a3dEWDQ3U0gzSHJpekxCTkx4R01BMVMrYWxQU3dp?=
 =?gb2312?B?VGd5YlZCOHhqdHZMR0dPMVVPRUJ1Vzh5c3Mva1dlMTZyV3pCekxVcEtIVjJX?=
 =?gb2312?Q?LKxUyHLroZRIX7h8/H9FPuKOk?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819d0804-e69a-4c00-99fe-08dadd7cf43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 02:43:16.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nF7mZitW8tx4tKIQduAaF0nFKL4lgMbXrw7Qb9mPJJgQcoqQvTZxApeBCm/529qwUOy0vlokmEQkHqSEoCUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2ggc2V0Li4uDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hlcnJ5IFN1bg0KPiBT
ZW50OiAyMDIyxOoxMdTCMjXI1SAxODoyNA0KPiBUbzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc7IGppcmlzbGFieUBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPjsgYXRzdXNoaS5uZW1vdG9Ac29yZC5jby5qcDsNCj4gdG9tb25vcmkuc2Fr
aXRhQHNvcmQuY28uanANCj4gU3ViamVjdDogW1BBVENIIFYzIDAvM10gZnNsX2xwdWFydDogaW1w
cm92ZSBJZGxlIExpbmUgSW50ZXJydXB0IGFuZCByZWdpc3RlcnMNCj4gaGFuZGxlIGluIC5zaHV0
ZG93bigpDQo+IA0KPiAtLS0NCj4gQ2hhbmdlcyBpbiBWMzoNCj4gMS4gQWRkIHRoZSBjb3JyZXNw
b25kaW5nIGhlYWQgZmlsZXMgZm9yIEdFTk1BU0sgYW5kIEZJRUxEX1BSRVAgdG8gYXZvaWQNCj4g
YnVpbGQgYnJlYWsuDQo+IDIuIFJlbW92ZSB0aGUgcGF0Y2ggMiBhbmQgcGF0Y2ggMyBpbiB0aGUg
b3JpZ2luYWwgcGF0Y2ggc2V0LCBhcyB0aGUgbG9vcGJhY2sNCj4gYW5kIFJUUy9DVFMgZmxhZ3Mg
bWF5IG5vdCBuZWVkIHRvIGJlIGNsZWFyZWQgaW4gLnNodXRkb3duKCkuDQo+IC0tLQ0KPiANCj4g
VGhlIHBhdGNoc2V0IGltcHJvdmUgdGhlIElkbGUgTGluZSBJbnRlcnJ1cHQgZm9yIGxwdWFydCBk
cml2ZXIsIGFsc28gaGFuZGxlIHRoZQ0KPiByZWdpc3RlcnMgY29ycmVjdGx5IGZvciBscHVhcnQz
MiB3aGVuIGNsb3NpbmcgdGhlIHVhcnQgcG9ydC4NCj4gDQo+IFBhdGNoZXMgaGF2ZSBiZWVuIHRl
c3RlZCBvbiBpbXg4dWxwLWV2ayBwbGF0Zm9ybS4NCj4gDQo+IFNoZXJyeSBTdW4gKDMpOg0KPiAg
IHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBvbmx5IGVuYWJsZSBJZGxlIExpbmUgSW50ZXJydXB0
IGZvciBub24tZG1hDQo+ICAgICBjYXNlDQo+ICAgdHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGRp
c2FibGUgUngvVHggRE1BIGluIGxwdWFydDMyX3NodXRkb3duKCkNCj4gICB0dHk6IHNlcmlhbDog
ZnNsX2xwdWFydDogY2xlYXIgTFBVQVJUIFN0YXR1cyBSZWdpc3RlciBpbg0KPiAgICAgbHB1YXJ0
MzJfc2h1dGRvd24oKQ0KPiANCj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCAy
MiArKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuMTcuMQ0KDQo=
