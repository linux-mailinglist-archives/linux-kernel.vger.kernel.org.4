Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA71472244E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjFELMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFELMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:12:36 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2135.outbound.protection.outlook.com [40.107.14.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C4DC7;
        Mon,  5 Jun 2023 04:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ1ExVNbzzTPhH5PqslLOp/UoUCuAi+eXJ8YsL6XMCXViUYlrhAq2g/dvVbDNGaC92yN/9zkN0YgjWRTfL5VJj6Wm1sv7fejIDSz4N4JjkyzmE+trUVLCHWUnkDGIhTbM8KsKq8EN1LUUhViEHKVUnSIuQb8IjxRdKzFGbHw0dEvSXND2oovQT7/clKoTHkcuD5edEzmqEjxtFlNufLu4rw0LmUaAI4WIn+yIhLdUIpiaF6I55hqCyaVm0Yy7NmBWadkM9QFcTSP/68qSH04sGVg5npzotmxERxGNyLfzgwDSmwJd4iOj76S95UAXf9lnneJgM3zA2X+OTw1+gckfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCrTkN562VS7GT6cgDyoBBF9OgxEB7GIWjKwW5MMyjo=;
 b=Nj9EYyZCQIYKvyRrbuuR5Bwj1KWTn6MhT2ue2rO2Vhp/wYcRJGvCRmZO3kGUnkw9bNMeCUchhB7oUdOHqXL35LxG6p9EsXz4BOGmSJvyGpDjvVWuDXaqZsoaaUSfwZbHvSlateHBVMmq1g5Yw/Zl6G44HEeqWx1gRUhCdcEYOz52w2YEyvU2vIeKzGQ3lBuFQ9/fEcNEVh/ejXmyvn++k40EOi+FkZuHCiRMCzjdq/jW7eWyy34JkNJh05R3uE/YbBV+Q7B8QKaft9x1atZdCsi3cQGBP5wGZUgoHF6kGnjs6mX4AZlqJ8x3Hu+QiAd2WlVdT7faFhlsy1KXH4KPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCrTkN562VS7GT6cgDyoBBF9OgxEB7GIWjKwW5MMyjo=;
 b=TKzNn7vy89Td2D9rbMkbuZbWFqyTTVYhi7f0U2COuDErs3sPloCbqaMqJXlTLk0XHaMVOBVA8aMJ+npUG9i8pUZ8KrIbKl7grbRnCOdhI8fSlbh+2LYfc6lz7Ts12wHtqAiU0dS9TjQ11Bim+NBcyYa/WobFrHUfR11CHS296BU=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by GV2PR03MB9380.eurprd03.prod.outlook.com (2603:10a6:150:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 11:12:24 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 11:12:24 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ASoC: simple-card: parse symmetric-clock-roles
 property
Thread-Topic: [PATCH 4/4] ASoC: simple-card: parse symmetric-clock-roles
 property
Thread-Index: AQHZlTEmzSsAiiQ6yEWWnHGiSn7lVq97XtgAgACz+wA=
Date:   Mon, 5 Jun 2023 11:12:24 +0000
Message-ID: <onadw4rqupe5t63rmrxi4hwvkgulyon65e24fha5ynvid5txbc@rvsoiljtmyey>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
 <20230602090322.1876359-5-alvin@pqrs.dk>
 <873536iwgx.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <873536iwgx.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|GV2PR03MB9380:EE_
x-ms-office365-filtering-correlation-id: 7cc2b7e7-3064-47ed-bb5e-08db65b5bd8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AoW873TS+Q1YUB88RzURSS+vCtfASGFH/UMnBQO4VWuvOOG+/lN1KSuAYnuerIgladdd2KNGYtg0QAzH6HRTJdUbJrNYRqG0aymuUVdjvbQGOGSOlhaxGLK/mnMmE1kFUTkPbXGvq4gh+uMRut4R09egdpAOSN++dgDeyGTkvUxUB0Fo3ISkqgg0dbgxdgaTLj//o3JfwODbyLZ5HJBD9KYzWkLHjS3jSKJAhe5NqUStKci1pBzWSqXzYhhhYJmiip3puawj0It3oTSukd7UQT1diDBgEi3hWZrKWrmw3BvKYWfIpm9Jy6mVLPxUiNGjltzr6arppkF7VCi/s34wlXLBf9U6NgZlR7y8hhueVKj2XTU6PbaCMxOzU0R2Ue5gm1Wd3kOc7ybZey136AomvKP7dhyq+rMC3iHDPEjC6Kmbwwe4G/PEdyf276p7vef7CV2N3FiiZjNatdilC3ChWAc7nKuqHDrb/E1PMlPwP9287Jb71MnkaLTpMG4E7hoACWo3eos6AgGKf6HVG2is7mgAAD31FXqyiTmNuQx0QpfveRuUoeoFL7Y5REbkNTqti9UltormVpSZUJP1eOxxGwGMyfARE2T+qPGTnjBv+o1evxoKtyftn7HJGjjv4waarHS7ZCuMed+/f8kpf+0Ydg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39850400004)(346002)(376002)(136003)(396003)(451199021)(54906003)(478600001)(91956017)(6916009)(8936002)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(64756008)(122000001)(316002)(38100700002)(66446008)(41300700001)(186003)(83380400001)(71200400001)(6486002)(6512007)(26005)(9686003)(6506007)(86362001)(33716001)(5660300002)(7416002)(38070700005)(2906002)(85182001)(85202003)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGV1M1JwQjZLbStUbzFYNjVrWnYxNnZYMzFXcW9RWmRFQ2loam1RNEZsN3BQ?=
 =?utf-8?B?T1BnQVdHRU5nZWNEaWJmSThNeFAxTlZSTXF5UEJPZFpRNG9FNWVCY256Z1dx?=
 =?utf-8?B?c0lqVFg3cFB2ZDE2NDkraUFFa1RJSldQRnhuUVNkcWxtU1VjbS82RlpQVnVn?=
 =?utf-8?B?cGIwSWJrbHN3cmNxOGNLb01zNnNjenJrdC9sMXpQd2pzM2JoL2ROS2xwTGw2?=
 =?utf-8?B?VG9DK0Ntek5QbGlFeTlUQ1VNci9Wa1RoVGN5ZVlrMElVTGtYUFVEdUE4RnRl?=
 =?utf-8?B?L2RaS3BrcWR2ci9MUnRFYnJxTzR0YkNwbUtjakJ3dThiWS9hSDlteE9wanAv?=
 =?utf-8?B?cHlmU0wzUWZJRUtzTmRHYVdwM2V4VDhwbGNoQ2dsNXBSdUJyVkZlVnFhRlh0?=
 =?utf-8?B?Vml1UEM2cVhTR1JrNUhmSzduaHhxWWZJVk1DcUlTbkd2cjc4eDNTZVF6Qzlt?=
 =?utf-8?B?MTF4d3Z5RlovaXc5ZlcxMEYyTVVVZXdyVlcydk1PUk42bjRwWGhXWEw3dlFK?=
 =?utf-8?B?YklCMFJtZTZ5cGc1MFQ1ZWozMDBib05pZlZnTVJhSFlkeWV0TkEyMEd6OU1G?=
 =?utf-8?B?OUo4cWwzOG9nY2c2b3djeEJET1FaOUR0ZW00bGgyN3lCbndGN2JxbC9YNk8v?=
 =?utf-8?B?aDd1eDNMQi9BeHdQWFZZM3NiL21oemNMNnVpVEZTNEptZDloMGVCWnl4K1Ft?=
 =?utf-8?B?Wlg0TEJrUFNySUxmeXlnL1MyRDNjdVdaUGxxTFFZYTBsSTB1bWRZYzdGWGI5?=
 =?utf-8?B?bWdtbGYybktaT1BrVk9UTTBOTkdNODRpd3NBemJDeDFsL2RwWWZzcUpWTDA4?=
 =?utf-8?B?SElnK3hDck8xRDhtdFJObVdVZEFXdFBQREVVRkpXZi9QU3BYdWhIamRXTHY5?=
 =?utf-8?B?dEIxY09kaS9BOXh4SW1WZUtzOUxSakhGYzhWZUNxT3NuSnIzNWczd1lscE9G?=
 =?utf-8?B?eXRBNDJkQTFvb1ZrM1FveTErUW5OSkZLMFJKUkM5Z0QwTWRLYVE1VEZTMTk1?=
 =?utf-8?B?UHRKQUJ2SlFTdDBzWFh3K2VTQXF0QTJiTnRyUmIweVY2ejVnVGVFakhzMVBH?=
 =?utf-8?B?WVdVelkzWEt5OWFybURLUEt3TmpnaUpQZjV2enBDMlVFZmRuV0diRU1LckRL?=
 =?utf-8?B?a3RyOWRsN2V3YlMvMENtZStCK1J3QzBvOFhDTklMNkF0UVJRTGtrYWFna0R6?=
 =?utf-8?B?emZtVklvZkk1bjVDa2RNdTE0TFJwRTJ5RXh0djN3MHBaUmU2WERDS3ZxVWxx?=
 =?utf-8?B?WSt2d2RSTWI5ZGFGSUlweEdPTDQ3OVMrNzBRa2dKdmc4dVZRblpmajlURUZT?=
 =?utf-8?B?bEVjaWJDQWZBVEJCbEMxTzRQNnpGU0pIZjQ5aXlkb3NiOG45aGVaRWJTNEZV?=
 =?utf-8?B?TWxudWZ6Zm9tWHMzdlp6YUpPaWY5UC9ZUTN1K1RSbVg2ZFJaWUg2YWdqbU80?=
 =?utf-8?B?dmVHY0ZYNUdPcUhIUEFLVzZaMWRZYUJkMVpGRlJ1TXNlN2lrV3VUMW1vYmVR?=
 =?utf-8?B?TDJPUWJtRGpJR0pjd21HTW55ZGVrVitXMVpZUkRlVXJpWm1iWmhBQm5yVlFM?=
 =?utf-8?B?Z0h3L0dRZjdGaFRaUnFiSGtiTStqcmx4czdvK3NCUXNUSEdWeXc3SU4vc1Qz?=
 =?utf-8?B?WndnTng1S05nYWNqZkFzdlRUMU1DMVJVMkJTbmdSYW9uR1pzWDRaQjFwZHFh?=
 =?utf-8?B?NXNuQlVFbWgzRVRNTWViRzUyRittc2xCdkp3S20xK3NFYTRhRytPUXZLT2c0?=
 =?utf-8?B?NjRTeWlvSHhqRUMxWCthYzBhZmo3MDM5bnNyeVVCR1hqN0dtWmtsT2dVTGhU?=
 =?utf-8?B?MmM1YmNPREJIS093a1BHSDlxeGtsYXFkRHZYRjlKb3RuSDlhQlFONlFSRFR2?=
 =?utf-8?B?cGhWZnloaDZQc3pQMGwyWmVwUHJleG4xSmV2N1V6WmRnbDBqVmVRUVlJeHFY?=
 =?utf-8?B?VXZLTGZGWE5odEtkcTQyWnJYRjl3MjhPcTZUcG5RZWI2S0c3djA2Z3Exc2Yw?=
 =?utf-8?B?RGUzV28wajdNMlNmUldnMk5SdnQ1TUtYbVJWbmJYMGp0R3A3SGFEUHhNWldD?=
 =?utf-8?B?ekp6WUZkeENteWdWTE9oUXZKQUFuZkQ2bm4yK1dtMmV0MTh2aEVsRmhqWlFa?=
 =?utf-8?Q?CU6rRZiLv1S2G5OMn6MF77/nf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14F22809469A3744A0A6E297C364CDC1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc2b7e7-3064-47ed-bb5e-08db65b5bd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 11:12:24.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynEhONBJ4I6oTFw3uyHS2rUuTDxlpXWhV2uVFGOxRdyLSLAL9ZT4HJIM2e7oirK+0b6s+Wx96YtZ/zHVa7nzxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3VuaW5vcmksDQoNCk9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDEyOjI4OjE0QU0gKzAwMDAs
IEt1bmlub3JpIE1vcmltb3RvIHdyb3RlOg0KPiANCj4gSGkgQWx2aW4NCj4gDQo+IFRoYW5rIHlv
dSBmb3IgdGhlIHBhdGNoDQo+IA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9nZW5lcmljL3NpbXBsZS1j
YXJkLmMNCj4gPiArKysgYi9zb3VuZC9zb2MvZ2VuZXJpYy9zaW1wbGUtY2FyZC5jDQo+ID4gQEAg
LTE4MSw2ICsxODEsNyBAQCBzdGF0aWMgaW50IHNpbXBsZV9saW5rX2luaXQoc3RydWN0IGFzb2Nf
c2ltcGxlX3ByaXYgKnByaXYsDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9IHNp
bXBsZV9wcml2X3RvX2Rldihwcml2KTsNCj4gPiAgCXN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpk
YWlfbGluayA9IHNpbXBsZV9wcml2X3RvX2xpbmsocHJpdiwgbGktPmxpbmspOw0KPiA+ICsJY2hh
ciBwcm9wWzEyOF07DQo+ID4gIAlpbnQgcmV0Ow0KPiA+ICANCj4gPiAgCXJldCA9IGFzb2Nfc2lt
cGxlX3BhcnNlX2RhaWZtdChkZXYsIG5vZGUsIGNvZGVjLA0KPiA+IEBAIC0xODgsNiArMTg5LDkg
QEAgc3RhdGljIGludCBzaW1wbGVfbGlua19pbml0KHN0cnVjdCBhc29jX3NpbXBsZV9wcml2ICpw
cml2LA0KPiA+ICAJaWYgKHJldCA8IDApDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4gIA0KPiA+ICsJ
c25wcmludGYocHJvcCwgc2l6ZW9mKHByb3ApLCAiJXNzeW1tZXRyaWMtY2xvY2stcm9sZXMiLCBw
cmVmaXgpOw0KPiA+ICsJZGFpX2xpbmstPnN5bW1ldHJpY19jbG9ja19yb2xlcyA9IG9mX3Byb3Bl
cnR5X3JlYWRfYm9vbChub2RlLCBwcm9wKTsNCj4gPiArDQo+ID4gIAlkYWlfbGluay0+aW5pdAkJ
CT0gYXNvY19zaW1wbGVfZGFpX2luaXQ7DQo+ID4gIAlkYWlfbGluay0+b3BzCQkJPSAmc2ltcGxl
X29wczsNCj4gDQo+IGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBzaW1wbGUtY2FyZCAvIGF1ZGlv
LWdyYXBoLWNhcmQgLyBhdWRpby1ncmFwaC1jYXJkMiB3YW50IHRvIHN1cHBvcnQgc2FtZSBzZXR0
aW5ncw0KPiAoQnV0IHVuZm9ydHVuYXRlbHkgaXQgaXMgbm90IGNvbXBsZXRlbHkgc3luY2hyb25p
emVkLi4uKS4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgYWRkIHNhbWUgc2V0dGluZ3Mgb3IgaW5k
aWNhdGUgaXQgb24gdGhlIGNvbW1lbnQNCj4gKGxpa2UgLyogRklYTUUgc3VwcG9ydCBzeW1tZXRy
aWMtY2xvY2stcm9sZXMgaGVyZSAqLywgZXRjKQ0KPiBvbiBhdWRpby1ncmFwaC1jYXJkLCBpZiB5
b3UgY3JlYXRlIHYyIHBhdGNoID8NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBoZWxwICEhDQoN
ClN1cmUuIElmIEkgc2VuZCBhIHYyLCBJIHdpbGwgYWRkIGEgcGF0Y2ggZm9yIGF1ZGlvLWdyYXBo
LWNhcmQgYXMgd2VsbC4gOikNCg0KS2luZCByZWdhcmRzLA0KQWx2aW4=
