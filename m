Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881CA635BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiKWLbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbiKWLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:30:52 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62010EA29;
        Wed, 23 Nov 2022 03:30:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWdNn+d8dP85IiEKSXpTl2qdbZDrDAp2RYrof+/z8PUvsDg+bT2ANRt+2Ygs0rCA1PgLs9R9eUcyGZf1z9zJCGHSE+OEv26zNlEeLPOi2gQrhIXnuIaGupOwskEDIwXmaxr0DYsjSVSAe5It2rl7bdLYS8xn5NA0IB0PubYPPO0IQ6CFcVQGo1/CZcBq//q84Ix6w7ld1ZkYLu25//XTD3S7hznz95PBf/RTLqT/CX98H4gXbWA/fecrwta6WW2qoQ01XDavUbObiuHnDilG3/OuqgsLdUMmVXfYxmxRlzqk61iP5mbh8IZ3XxaSnUdxcH2FtUJitDMqBl0nhxWHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgZVsYG05P4148tVoNhaf7AhJRixSpx/LnmIxcNloHI=;
 b=He0OBDmitqHXSoeU/OiwfKbK8lxepZywVzIZOOi0qJjYEtMLoFBLV/4oXeapJkVbvpcQMv/U5KGIsHEtg1tUYeVWhKjcnWG+qLpLAX2vgvIX26M7oO8mZQ3gONOy0oURCz4KL1agSDTS8d4WG2MtPcmtFwshB8FOpAvLrjcqsomSQ8Y8Tu1jeMAnJUAD7ZzjwFfURntIUWurghOLam9xJugY59I1ikYS4GLeBSK0wpne2PQ7N3/H3828zo6SMCX154PS+aZC5vXRn5NQyaRhRXEnl7GKpk5z9VdhYYoJV++v5OM4fEicLqqdxC1oukeR0egkar54ISMXml3peQPIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgZVsYG05P4148tVoNhaf7AhJRixSpx/LnmIxcNloHI=;
 b=sa2zO6KJJArYEGWg6ZFVAy0GxNUT1jfMYuO5/6OXSs4NZM/rNMa4L5t929OWX4wuwKiQIrrDj2JsDhdhvixPgt93d8R0l7HFJjk38XjL5WMLe9pBLsO6AwTpMa1km+evYfi49BEK5Y63nKdY2JgCE0OR1s5NL/PF3+N11JIE43I=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7753.eurprd04.prod.outlook.com (2603:10a6:10:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 11:30:13 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 11:30:13 +0000
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
Subject: RE: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in
 lpuart32_shutdown()
Thread-Topic: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in
 lpuart32_shutdown()
Thread-Index: AQHY9N0ndaYC9LLIxEmMDBrWfgwKya5MZJAAgAAD6ACAAAXfAIAAAWKA
Date:   Wed, 23 Nov 2022 11:30:13 +0000
Message-ID: <AS8PR04MB8404825F21A72C22C6D09B49920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-3-sherry.sun@nxp.com>
 <1a7c9345e3c8b97adfbadffda7340871@walle.cc>
 <AS8PR04MB8404EBF13DF7A051650EE76C920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <7724b39dabc60f872e20ffb5ed21d1d6@walle.cc>
In-Reply-To: <7724b39dabc60f872e20ffb5ed21d1d6@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DBBPR04MB7753:EE_
x-ms-office365-filtering-correlation-id: ba5963ad-af48-4aa0-a05a-08dacd461685
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g90rhN+2wu46ucTzgFSKcqAtZtkAwFJQ6I0gNaQW7tUSkl3o8wdduvPhWaW45fLmV6Cjux+y2mSX8OwQCnqZ7iBjob/YazrWvDdr7JLh2wlMMpteIOboYhSMOpZ1eeESV7KbOATiw5llTebWdKAUb6hzB/bJOUYze2tudhpj3aHzlmb+JZ0In9/9BeL0zF8d5+rCFEHTqD21Lwvhz+dGfGJCqH/cCIudcnqEOe8wYvw7pT+cMPGu5oKWsH+nNCMubQQ8unY+Ax7EbQv9+YmcZRwzCIGJ20cGl46c+6212lvIWiTccIe6RWSaI0QGpPozJ7biBWNfvzk0CCfnSiFRz+7Bro+DG0NgFYl1lLxXOP0WEoOWcxiBCqi/fliXF2Vz7YK68WErD5vZC5XzhIO/jtuagfTBSGpHGyU+T8+euUPfVp1OQ9UGkRztYnHAR1sztPzZrwyaBNJl8+ogqgrBA4ygruu+VFkkohU/DU3QZ9JiYwSXsC7iyaxzNk3cEmtuqk41uOl8wiA6yp60eBMJWAUzC2OxQp3jdg6v8C+sfREJUfYoigUP31cdmGEa8lEm7iEKH7INDZFj6cfH8C38lBm7Dl3PzJjDm50WLLvkS6lhxRqSvqyhdCQDSkTYWdwDLfHPKM4wiTJH/4AL3YNY57r3TirhHUlUtrS+mRXs7B+WuXFwKNd96H6nFWLUO8/TR78y8k6P6HcIreazbNa6aA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(33656002)(86362001)(7696005)(38100700002)(64756008)(76116006)(55016003)(44832011)(5660300002)(186003)(9686003)(2906002)(122000001)(4001150100001)(26005)(38070700005)(83380400001)(53546011)(6916009)(66556008)(71200400001)(52536014)(6506007)(4326008)(41300700001)(54906003)(66476007)(66446008)(8936002)(66946007)(8676002)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUdkTzY0aXp1S0ZPRy9zKzJiMVh1VGdYamlWazlDd3loUUxTM1RoMmIrYWMv?=
 =?utf-8?B?ZVFxU2lEMmdUTng4RXAzc29VV3dLZGhXejRSUHErOTlndmNOUkdONkxodFkv?=
 =?utf-8?B?N01iS2NGRm9sUm4vamNpVktSL0kwdkk1aUU1WTdiRytSOFN0UW1uTmduaW5O?=
 =?utf-8?B?UHo2VUdOeGQvNjM3L0dZVmVESk5BcEpJeHNHdFRobTZCdVdOZ042RHM4TVpE?=
 =?utf-8?B?R2VGUFBuZmMyc0UvdnllbmtZN2lLT01DS2VXaFNqZlB1UjE1YXM4SzdYMXIy?=
 =?utf-8?B?eSt4N3FPUUIrT0pzQkhyeWowNHlWVjBjajZsMlBxMlFSeXk5U1RhRFhTSmpq?=
 =?utf-8?B?eHJxNXQyT3FpZTRHQjh2YlFZK2lzNkFwQlVGUUhWZlIvMmZocU1CSHZySENl?=
 =?utf-8?B?dkhPU0RnaXNGSGo0RWJsRkh4eXJ2Ri9oaUFuV1A2Smo4UGZRQVJZTkRSdHBX?=
 =?utf-8?B?THdleFRGdFZxVkROeDJvclNQdkwrT1RJNTFNYmxzYUl1ZFlSdUdZVlNybjFW?=
 =?utf-8?B?OUFVNWF0REwycGdwQ1VaQ2FzUm54cXpKL2V3UXdDTU9xQS9TYUxWK25xdHAy?=
 =?utf-8?B?VWNTdjBVRU85ODMzM05NMHp0T09wbXptUUZXNFcyVXRFeHUrVzRDZ1lJYVJm?=
 =?utf-8?B?eFB2YWNld1drdjZZNGg1Z1pJamxDdUg4Tks2NGxCcFJIYm1oY01XSDNXNE9a?=
 =?utf-8?B?dTNiZ1hVSFpzTlZiRzlNWUVMcTNjMTNJT0tNUjBRYkVqdnFPWHk5c1UzdE9L?=
 =?utf-8?B?SDB5K2ZQMndTWFB4U3psV0ZRZTlDWUIvQjh0UW82enFYc0E4UEo5VEplWU5P?=
 =?utf-8?B?cHhaeXk4VW5ITlBrcTVGdkFSS0JaSVN5K2lYMWFTYlFic3ZLVk1TeHdaZmNz?=
 =?utf-8?B?MTM4SFN5YlFtY0MyeHlCWFRSYkdSNW4wT2FZV0ZLaDBwckRlNUtjaVl5czJ1?=
 =?utf-8?B?NlRocndaUFRaMzZrMU0rZWVWc3JuVjNaU2FQOVdJZDlJdzhnQ3NNSVVVUGFN?=
 =?utf-8?B?Nk5ueHFJaFVnOFlUdk9neUpjUHRrVlljQjlCKzNGQ2ZJWmViTkJuRzU4eWtR?=
 =?utf-8?B?SkF1RmtrUUxhenNyVnpsRlIwSldxekRJS2ozOFNhNUNCVDdvT0VkWkgrM3BW?=
 =?utf-8?B?U2F3aHVOYlFLM01nTkwxUktlU2FpOGNMM21DbUJ5cjEwV2FSK2lEaFpGb0pC?=
 =?utf-8?B?QVVGYklUQUIrWDc3ZDhJTHF3YjZidENVWkRpSHZ0QlJ0YURuaTdkQjVRYWMz?=
 =?utf-8?B?SURodHRPVEhhUXdrR0hwaWRFWndCczZMY0hlZ0JzdGVxQWRMc1pTcHpWYkNU?=
 =?utf-8?B?SUhXbEZYV2FXQjZyR01YdkVyaEVXay80enJnU1RaaFM1SGtIaTlGSG51NEI0?=
 =?utf-8?B?YmhZZmswZVZFN3VnZjlLOElzTU9Rckp6RWhPTy9HaWZ6bVB6SHRydUdBOXhR?=
 =?utf-8?B?b0lqTVlRNEhiR255SzhhbHdJZ1FreUM3RE1ISEZ4dVRJRjRiNmlMN053MFBu?=
 =?utf-8?B?STFkNVJJR3ZtSCtpR0UycDNFYlg3Z2VCTzB1MlZmSU5GT05XM1l0Zk51eGF4?=
 =?utf-8?B?cnRBMXlHeXZ6RWErYTdlVlk5V3ZyNytSZnZ0MGlEdU1UTFNVM3pLc1NWSTlD?=
 =?utf-8?B?L0ZnajcwMStiQWZIejY1R2tBMDcyTDcyL0lQZnd5M1ZGTFplb1JzazJicFZn?=
 =?utf-8?B?TVBwajdRMFR4TU1JVVdaZHBNUW5DWTRmM0xnTFEyckN0dERDeFhaSGJFWFRr?=
 =?utf-8?B?NkNjaFRaVFlaMDRKVFRGZ3NlTm56UzREU01BZlp5ejhjakFTY0dyM2g0dGgy?=
 =?utf-8?B?ME5oQ0I0QzlockNHQWJ3QkFkN1V4WUZhZHg1SkgwRlRYSlFHYmtBV3dYRVFx?=
 =?utf-8?B?ZHlibWQvWjZsajczREsvNVV5NVQ4RVNFbi9HZmNXMDBNVXB6dzBLUjhRc2FG?=
 =?utf-8?B?WFM3bE1UVjIrYktjRDMxTDZXTzUwcGdRYzlCMnp1WFJuUUdDK2NlbllEOVUz?=
 =?utf-8?B?Y29IU1N1QXp6dzFOaFh5UXRUcjZwMXZSU0pwQ2RPUmpZdnBJcnZzM056Z0VC?=
 =?utf-8?B?ZXdMY1NYOUpNNmVUZmltaWQwdWFvUEZzU2pFOGlZbVNtbWhjMU5YWEF0OGNp?=
 =?utf-8?Q?TFUs8r4rnC6zkukqu1TgpHAy5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5963ad-af48-4aa0-a05a-08dacd461685
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 11:30:13.4982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T60RuhKLHZyH72DXMEcX0NnXdnSXba0rUr2/2QiFTwwundwyhu9flz/gaN5JZFj2W2pHTMKMXbi/hqdkfJFjEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7753
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
bWljaGFlbEB3YWxsZS5jYz4NCj4gU2VudDogMjAyMuW5tDEx5pyIMjPml6UgMTk6MDkNCj4gVG86
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyBqaXJpc2xhYnlAa2VybmVsLm9yZzsNCj4gamluZ2NoYW5nLmx1QGZyZWVzY2Fs
ZS5jb207IHRvbW9ub3JpLnNha2l0YUBzb3JkLmNvLmpwOw0KPiBhdHN1c2hpLm5lbW90b0Bzb3Jk
LmNvLmpwOyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBWMiAyLzVdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBjbGVhciBVQVJU
Q1RSTF9MT09QUyBpbg0KPiBscHVhcnQzMl9zaHV0ZG93bigpDQo+IA0KPiBBbSAyMDIyLTExLTIz
IDExOjU4LCBzY2hyaWViIFNoZXJyeSBTdW46DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+ID4+IFNl
bnQ6IDIwMjLlubQxMeaciDIz5pelIDE4OjM0DQo+ID4+IFRvOiBTaGVycnkgU3VuIDxzaGVycnku
c3VuQG54cC5jb20+DQo+ID4+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgamlyaXNs
YWJ5QGtlcm5lbC5vcmc7DQo+ID4+IGppbmdjaGFuZy5sdUBmcmVlc2NhbGUuY29tOyB0b21vbm9y
aS5zYWtpdGFAc29yZC5jby5qcDsNCj4gPj4gYXRzdXNoaS5uZW1vdG9Ac29yZC5jby5qcDsgbGlu
dXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggVjIgMi81XSB0dHk6IHNlcmlhbDogZnNsX2xwdWFydDogY2xlYXINCj4gPj4gVUFS
VENUUkxfTE9PUFMgaW4NCj4gPj4gbHB1YXJ0MzJfc2h1dGRvd24oKQ0KPiA+Pg0KPiA+PiBBbSAy
MDIyLTExLTEwIDA5OjE3LCBzY2hyaWViIFNoZXJyeSBTdW46DQo+ID4+ID4gVUFSVENUUkxfTE9P
UFMgYml0IGlzIHNldCBpbiBscHVhcnQzMl9zZXRfbWN0cmwoKSBmb3IgbG9vcGJhY2sNCj4gPj4g
PiBtb2RlLCBidXQgbm93aGVyZSBjbGVhciB0aGlzIGJpdCwgaXQgc2hvdWxkIGJlIGNsZWFyZWQg
d2hlbiBjbG9zaW5nDQo+ID4+ID4gdGhlIHVhcnQgcG9ydCB0byBhdm9pZCB0aGUgbG9vcGJhY2sg
bW9kZSBiZWVuIGVuYWJsZWQgYnkgZGVmYXVsdA0KPiA+PiA+IHdoZW4gcmVvcGVuaW5nIHRoZSB1
YXJ0Lg0KPiA+Pg0KPiA+PiBJdCdzIGNsZWFyZWQgaW4gc2V0X21jdHJsKCkuIFdoYXQgaXMgdGhl
IGV4cGVjdGF0aW9uIGZyb20gdGhlIHNlcmlhbA0KPiA+PiBjb3JlIGhlcmU/DQo+ID4+DQo+ID4N
Cj4gPiBIaSBNaWNoYWVsLA0KPiA+DQo+ID4gSWYgd2UgY2FsbCAuc2V0X21jdHJsKFRJT0NNX0xP
T1ApLCB0aGUgVUFSVENUUkxfTE9PUFMgd2lsbCBiZSBzZXQuDQo+ID4gVGhlbiB3aGVuIHdlIGNh
bGwgLnNodXRkb3duKCksIHNlcmlhbCBjb3JlIHdvbid0IGNhbGwgLnNldF9tY3RybCgpIHRvDQo+
ID4gY2xlYXIgaXQsIHNvIHRoZSBVQVJUQ1RSTF9MT09QUyBuZWVkIHRvIGJlIGNsZWFyZWQgaGVy
ZS4NCj4gPiBQZXIgbXkgdW5kZXJzdGFuZGluZywgLnNodXRkb3duKCkgc2hvdWxkIGNsZWFuIHVw
IGFsbCB0aGUgdWFydCBmbGFncywNCj4gPiBhcyB0aGUgdHJhbnNtaXR0ZXIgYW5kIHJlY2VpdmVy
IHdpbGwgYmVlbiBkaXNhYmxlZCwgd2Ugd2lsbA0KPiA+IHJlLWNvbmZpZ3VyZSBhbGwgdGhlIHNl
dHRpbmdzIG5lZWRlZCB3aGVuIHJlLW9wZW4gdGhlIHBvcnQuDQo+IA0KPiBUd28gdGhpbmdzLA0K
PiAoMSkgc2hvdWxkIHRoZSBsb29wYmFjayBiZSBjbGVhcmVkIG9uIGEgbmV3bHkgb3BlbmVkIHNl
cmlhbCBkZXZpY2U/DQo+ICgyKSBhcyBtZW50aW9uZWQgaW4gbXkgb3RoZXIgcmVwbHksIHRoaXMg
Y2FuIGFsc28gYmUgaGFuZGxlZCBpbg0KPiAgICAgIHRoZSBzdGFydHVwLiBFZy4gdGhlIHN0YXJ0
dXAgY2FuIGNsZWFyIHRoZSBsb29wYmFjayBmbGFnLg0KPiAgICAgICh0b2dldGhlciB3aXRoIHBv
c3NpYmxlIGhhcmR3YXJlIGV2ZW50cykuDQo+IA0KPiBJJ20gbm90IHRoYXQgZGVlcCBpbnRvIHRo
ZSBzZXJpYWwgY29yZSwgdGh1cyBteSBxdWVzdGlvbiBhYm91dCB0aGUNCj4gZXhwZWN0YXRpb25z
IGZyb20gdGhlIHNlcmlhbCBjb3JlLiBJIGd1ZXNzIHRoZSBhbnN3ZXIgdG8NCj4gKDEpIGlzIHll
cywgYnV0IGJldHRlciB0byBhc2suDQo+IA0KDQpIaSBNaWNoYWVsLA0KDQpGb3IgdGhlICgxKSwg
SSBoYXZlIGNoZWNrZWQgdGhlIHNlcmlhbCBjb3JlLCBzZWVtcyB0aGUgYW5zd2VyIGlzIG5vLCAu
IHN0YXJ0dXAoKSB3b24ndCBjbGVhbiB0aGUgc3RhdHVzLCBvbmx5IHdoZW4gdGhlIHVhcnQgZGV2
aWNlIGlzIHByb2JlZCwgbHB1YXJ0IHdpbGwgZG8gdGhlIGdsb2JhbCByZXNldCB0byBhbGwgdGhl
IHJlZ2lzdGVycyBpbnN0ZWFkIG9mIC5zdGFydHVwKCkuIFNvIEkgdGhpbmsgdGhlIHVhcnQgcnVu
bmluZyBzdGF0dXMgY2xlYXJlZCBpbiAuc2h1dGRvd24oKSBpcyByZWFzb25hYmxlLg0KDQpCZXN0
IFJlZ2FyZHMNClNoZXJyeQ0K
