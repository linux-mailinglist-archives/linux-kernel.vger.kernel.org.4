Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4161EF0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiKGJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiKGJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:31:05 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B951658A;
        Mon,  7 Nov 2022 01:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+VjB2vAG6BG2jnbAAktZkLS56gDtbhI0RB5KBOgynCHKLOuDQHI84F0GBfztgbxFvvgypeRcVn15+NlsDZ7KQnOl1ZkeU+yyZd3VSk1itctxI1mgB5zzgDxd3pStNOl8Mvo3gJ+zMBV8zuRJXCiMKk0H/ULJPSSeVDEsNMVhbGZPEzkFKlBx9bpejYbvhsbCmebQQD9Au5H8zwv2VdIBpj/oDe7DGBFxu/DRCAhi8000eBd1uXdtdOp/2MWDNznehmgNJAzD7vxow6HPinjVxNBnFBav1Rps52+P8yu9PMCepujuF+T8DNMmMiMlOdy7bfEYAaG9NpFmtBkmPT+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX/tsZBtgo1YdEHwPUe4wDKnR5TREIpnm+L+IUynA1A=;
 b=fvMJdI9Emf5wcVVqTPz7Bg9HtLnDUsGCHz+32SZckpjZY6e0hDqQdVMnjEtDu37Qk0/PWd+xjwea2OMwc2GhzwTIrMi0QA84mT4FgFF4t/IDuhBQFRP5IUY9Ye4rWj9MJpvqbriBnI5542RsXw923Sa6PiCm4YsHQmP/6L3ck9XrMGHlgWVggVgDXZfncn/tMX70SXvI2HOVcXxrXI5Dq5gw19iz9HltI4N2z0SHNkIo7ybu8f2p3aHQI4790p1tsrblpXGuYBLNqVZU5aYoQpqoSFeHZb8pHJhxBh8dhdXTO0L0Wki4kcu9XNiWxYgXpuOjL3WEuIR0uGzdOE+Zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX/tsZBtgo1YdEHwPUe4wDKnR5TREIpnm+L+IUynA1A=;
 b=HkuPdr/TiyE9GIgDIX25QSLgikA1AKlfNi651TfVzsRZw1cZJJ9Y3Wqk6NQL/5lTiap/FbKlYB6s9QZpqEcp5k1ONNIHH2phgtQc25Dv+Qd0HM4RSYksFKQm/NE1pf4f8ADBlKNeHPgFuHDU4ME5t89kheVWKVlk1tN9B4v6c8g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10366.jpnprd01.prod.outlook.com (2603:1096:400:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 09:31:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 09:31:00 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
CC:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHY7p7kl1T9YGA12UCEvmgRzmEVOa4ryCswgAdlwYCAAAAiYIAACn6AgAAAV3A=
Date:   Mon, 7 Nov 2022 09:31:00 +0000
Message-ID: <OS0PR01MB59228483527685F943A3F5D4863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-3-billy_tsai@aspeedtech.com>
 <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <C7224BE1-D81E-4FE0-8B7C-5A3CA69898D2@aspeedtech.com>
 <OS0PR01MB5922EC7AB73207DF30F42A0A863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <E3A2DC80-3D8D-451F-9EA1-A3262F4A3C43@aspeedtech.com>
In-Reply-To: <E3A2DC80-3D8D-451F-9EA1-A3262F4A3C43@aspeedtech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10366:EE_
x-ms-office365-filtering-correlation-id: 538f2cf9-95e6-41ac-fd44-08dac0a2c83b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7w8K5FdoW7NtCMo2lPjZ78lMs0YR3ZNkXxP8UxXgDSVOdOz5zGsyLBdV0BT/P6VdJOPG/FBQLMJ5gi/y+vgXeOWjR9VrMrAvg0QK9ExxLufxYSP3lVVHlB1uTH6lLM3RGBI/SMkxkNpUh7CfEpSzBE0q8RUILhglo6GqpgqETgHIt7OZzOP6nVFojHKC6ziww5psw5bZw+WJdRb60ueVEQNGHVZUTFIPjEv/vC+fx7ERlX56L9u+FrnL26P6er/hfXH4ewHiYdEhkJc93AIfR2OkA1QzBJWh3VzZoQFSzKk0jGs7koisAbH/ZlV9Jke73KlXz9yvQPhnwTIOMuDfrgdLGlosapDlB9Lar7WsTZyx67w+r4pTLdIoFGNnZQqzHcNBCkpJ1ZJ6jCgGoyQVPSUZr9UdSN+htLlc7IBdt4omQsCYE/HzaIGaQfJf7QERS7gypdnP3JPPxqKDfcJh1GRuw+XnAIb6QAIcFWl/mntHIPtwaEmsnsR0VZVaMS0ajCoedN17uawIGWTc1VFpLoEBYSOzxunjXvZJwDMShIV4YIT3wUMnkBa97e9fOMOtFA2uSgVblTidXsttX+s50cHQ3NizVSkoBDs8PUJrBcZQsuBCTCTeWwYG4L10kXR3X57wzjY0d6Q86MCmRRXyYW5Yt9y83ydomsNEUeFsaJqTstmGQWw/BIoDpnquTi1xbz7T7+gLmM5fctJHjVmHKCTmfjb+I5U7PSlD4phpueUxiK4Dwh8XKGYcm3WC1PLRwL6IjqmRQzg1S/sg0bBPgNYwIcywE9YN6vB5c77FdWM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(316002)(110136005)(33656002)(54906003)(86362001)(8676002)(2906002)(64756008)(4326008)(76116006)(66446008)(66946007)(66556008)(66476007)(83380400001)(186003)(9686003)(921005)(478600001)(71200400001)(55016003)(38070700005)(6506007)(26005)(53546011)(122000001)(7696005)(38100700002)(52536014)(7416002)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkNWY0FmbkcxVjEva1ZZSlk0b1dXamplVTcvNXdGTGpBOUZ3algvR0c2ZE15?=
 =?utf-8?B?bE5JemtsQVpyNWZoemhvem1tMGZlYThlWXRBa1B0STJHWG1xZkRUUDlOWTJy?=
 =?utf-8?B?NG5oQ1NhSXRQUFE3SStFT1gvc2VCNXhNbEpmOTU1R3pQTHBjL25PTjdDakVC?=
 =?utf-8?B?dEsxdXBUNGZ3K3JITllRNVY3MVhPSHJ3VEFPSk5Qcnp1SXN0OUVtMkNzN2xS?=
 =?utf-8?B?b2tiVDFFdHBza2l2OWVyS0g1dXdZeUhaaXhCQ0x6ZVVmUi83VkNCK3VuaStM?=
 =?utf-8?B?a29XRXJBbUt1NjNuTkp5djd2V29tYmlSR3oyQVBmdjVibXIxOXYwcDZEaDdK?=
 =?utf-8?B?aDNUOUlsSCtPUTRxR2o2QWZmeXRPM013MFV5WVZudEhMdGdIRTFocWlIb1NU?=
 =?utf-8?B?d2hOaUk2alpGeGxkeDlIZkhHZCtsTVdXYnpwRWdUcGswUUhBS0F3UXlFV3d5?=
 =?utf-8?B?d3NzZmNZcEhxeVo1cDRzWjBnMUNsNlpmUEErUmtPMnNlYU01RVR6QlA4V1Zs?=
 =?utf-8?B?YXhnS1FoYnB6R0lFNmc2NzZ5TllNczNUZThJL2Y3OFVxdG15cW9KcTZtVnFt?=
 =?utf-8?B?Z2hLemF4RXQyb1hSUzU1TXRNNU1oc1NobUZwRWpjZmtNTlRGdE13TisvOVpi?=
 =?utf-8?B?cEpmUjhFYXUxeGV6ZUUzQmhkSGF5Uy9OMFJJMWNSQUxJZjdnQ2FPQlRLblVK?=
 =?utf-8?B?QVZkaDI1N1UzcFdkcHBnMWoxMW9KWGt2T1BIVmJTSkQ4dTM0N2FaSTZydGtw?=
 =?utf-8?B?bzJzK1dLQytuS08rMHd0ZThMY1VEOWg2MjFtaGlJMWM2eEFWSmNTbGRnL25L?=
 =?utf-8?B?anhHSTJQY2d1VHc5eEZMOXVMdXdRdE1pVFB4MWhhWkZGMkFUeFl4VFlQZFlF?=
 =?utf-8?B?WWk5SjhwZHludjlUcUFxTXVRL1pDNGZsUXlSWUxmZityNnJXdkJIQ1NIdU1P?=
 =?utf-8?B?bWM4eWxDTzhGaEpvK1pZSmhhQTF0Z3JreVBheGJuL3R3RWlJSTI4cFBPcXdD?=
 =?utf-8?B?UmJkZnNIVXRZUUFWYmkwOVh5THllcFlFZGR0Wkw2Zi9RaVRVMGw4QUgzc2p2?=
 =?utf-8?B?TWQvdHNGK0t5L2JTOW4yL2FIV1JlVEU5cEsxVEhnUjNaTHJvby9sVzFOMjA5?=
 =?utf-8?B?ejNONHpyVEdmck9vQ2xQanJRbzRvNGpDNzFEUC94ejluWGF1SnlIZW1ySm1p?=
 =?utf-8?B?KzhBTld6THlSQldjVkJIVzJ0NWNxNlFtNVc2cFg5R2xpSkFKSUFLNlZwS0lP?=
 =?utf-8?B?NDl0UjdTS3o0SnBIYnB1dTgrMytaRSsxa1F4Tk5XcFE0NEdrRFpsUjZPRU9V?=
 =?utf-8?B?eDBQUWdCOXE5eC90dXlJQTJ0dlNCZVlkc29rNnFaOWVOcWFqN2xHZEw3ZmlT?=
 =?utf-8?B?VnlqcjduRU40cHk1V1ZKMHByb21oeTdROU5EMFFETXhOYW1DdVZIeFZPYUZm?=
 =?utf-8?B?MWh5d0NxQXoxNFRsSEVlUGVjUjhqUzNvWUFObUlIZXlpc3lXRlJVWFNJaWJW?=
 =?utf-8?B?UUVqZTJlUUw2anZWVVJscHpqU1ZhRk9RK0lGeWxMTmdkL3RRb2ZsZG4wNTNn?=
 =?utf-8?B?WXQram9OVzh2a1ZPRC9pR08yT1F1a2svcTN2OXdidGNObG9RaW1hQ09IVy90?=
 =?utf-8?B?a2JVUjRiZm9mb1BoakZvRndZQm9WTXJqVVVHZ3dCN3hmdVlhNEY3Smx3bVEy?=
 =?utf-8?B?d3FUUDkvZEtUbURUV1kraTg2ZW4rTGNIWWJtNGNNMDA4NXZTNWQyYXVZTWhj?=
 =?utf-8?B?R25kYUZkZlhjak4veVgzQy9jMzF0QTBzSStaNzhPS2FpWGpMc1BoQzZjeGZi?=
 =?utf-8?B?Q1o2WlVWZlluTTg4MFl2WDdGZ3liL2tiS2dXUFBsUEdTWkRiUnFRL0lnUGxq?=
 =?utf-8?B?RXdJdU1jZVptSitoakRZalF1ajEvUUxicmk5M0NxenVmYml3K04xWFl2dk94?=
 =?utf-8?B?YTRKWmF1cVJiNmxHWFFUc1FoOHNBNDFCb3VGVWpnejhXTkZBdW5EK1V5VEd5?=
 =?utf-8?B?QTMwRndjQWphSWZtWEtIRnNtc2FGWERRRkRpUk5NeXlqVTFDU3NDZW5uaXdy?=
 =?utf-8?B?TVEvbTdOR0dmY3hhR3pmRElhMTg3ZVZ2MjZSRDgzSUVST3JCSk9HbmMyc0Er?=
 =?utf-8?B?TnlPZUJvVWNibE52Q2RtdHpNNG5GMjE3TXZ5M3VrbWJPbWR3OTY3RzNKak5V?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538f2cf9-95e6-41ac-fd44-08dac0a2c83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 09:31:00.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/wt0vN9duHE5jpW20Ofpj4En5ssXAz4bq2sdv/gjd44kkNj5GxMMpXh4IjFVOwFnnG7bwZL3UkC1DgxlkUgHddPPczq01KCDYzvt0UQXc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10366
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmlsbHkgVHNhaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBC
aWxseSBUc2FpIDxiaWxseV90c2FpQGFzcGVlZHRlY2guY29tPg0KPiBTZW50OiAwNyBOb3ZlbWJl
ciAyMDIyIDA5OjI2DQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
OyBqZGVsdmFyZUBzdXNlLmNvbTsgbGludXhAcm9lY2stDQo+IHVzLm5ldDsgcm9iaCtkdEBrZXJu
ZWwub3JnOyBqb2VsQGptcy5pZC5hdTsgYW5kcmV3QGFqLmlkLmF1Ow0KPiBsZWUuam9uZXNAbGlu
YXJvLm9yZzsgdGhpZXJyeS5yZWRpbmdAZ21haWwuY29tOyB1LmtsZWluZS0NCj4ga29lbmlnQHBl
bmd1dHJvbml4LmRlOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1od21vbkB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBhc3BlZWRAbGlzdHMub3psYWJzLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHB3bUB2Z2VyLmtlcm5lbC5v
cmc7IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPjsgZ2FybmVybWljQG1ldGEuY29tDQo+
IENjOiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT47IEdlZXJ0IFV5dHRlcmhvZXZl
bg0KPiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IFN1YmplY3Q6IFJlOiBbdjMgMi8zXSBw
d206IEFkZCBBc3BlZWQgYXN0MjYwMCBQV00gc3VwcG9ydA0KPiANCj4gT24gMjAyMi8xMS83LCA0
OjU1IFBNLCAiQmlqdSBEYXMiIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+
IA0KPiAgICAgPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ICAgICA+ID4gRnJvbTog
QmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4NCj4gICAgID4gPiBTZW50OiAw
NyBOb3ZlbWJlciAyMDIyIDA4OjQ4DQo+ICAgICA+ID4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT47IGpkZWx2YXJlQHN1c2UuY29tOw0KPiBsaW51eEByb2Vjay0NCj4g
ICAgID4gPiB1cy5uZXQ7IHJvYmgrZHRAa2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7IGFuZHJl
d0Bhai5pZC5hdTsNCj4gICAgID4gPiBsZWUuam9uZXNAbGluYXJvLm9yZzsgdGhpZXJyeS5yZWRp
bmdAZ21haWwuY29tOyB1LmtsZWluZS0NCj4gICAgID4gPiBrb2VuaWdAcGVuZ3V0cm9uaXguZGU7
IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LQ0KPiBod21vbkB2Z2VyLmtlcm5lbC5vcmc7
DQo+ICAgICA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtDQo+ICAgICA+ID4gYXNwZWVkQGxpc3RzLm96
bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiAgICAgPiA+
IHB3bUB2Z2VyLmtlcm5lbC5vcmc7IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPjsNCj4g
Z2FybmVybWljQG1ldGEuY29tDQo+ICAgICA+ID4gQ2M6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPg0KPiAgICAgPiA+IFN1YmplY3Q6IFJlOiBbdjMgMi8zXSBwd206IEFkZCBBc3Bl
ZWQgYXN0MjYwMCBQV00gc3VwcG9ydA0KPiAgICAgPiA+DQo+ICAgICA+ID4gT24gMjAyMi8xMS8y
LCAxMTo1NiBQTSwgIkJpanUgRGFzIiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdy
b3RlOg0KPiAgICAgPiA+DQo+ICAgICA+ID4gICAgID4gPiArCXBhcmVudF9kZXYgPSBvZl9maW5k
X2RldmljZV9ieV9ub2RlKG5wKTsNCj4gICAgID4gPiAgICAgPiA+ICsJcHJpdi0+Y2xrID0gZGV2
bV9jbGtfZ2V0X2VuYWJsZWQoJnBhcmVudF9kZXYtPmRldiwgTlVMTCk7DQo+ICAgICA+ID4gICAg
ID4gPiArCWlmIChJU19FUlIocHJpdi0+Y2xrKSkNCj4gICAgID4gPiAgICAgPiA+ICsJCXJldHVy
biBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihwcml2LT5jbGspLA0KPiAgICAgPiA+ICAgICA+
ID4gKwkJCQkgICAgICJDb3VsZG4ndCBnZXQgY2xvY2tcbiIpOw0KPiAgICAgPiA+DQo+ICAgICA+
ID4gICAgID4gV2hhdCBpcyB0aGUgdXNlIGNhc2U/DQo+ICAgICA+ID4NCj4gICAgID4gPiAgICAg
PiBJcyBwd20gY29uZmlndXJlZCBieSBib290IGxvYWRlciBpbml0aWFsbHkgPw0KPiAgICAgPiA+
DQo+ICAgICA+ID4gICAgID4gT3INCj4gICAgID4gPg0KPiAgICAgPiA+ICAgICA+IHB3bSBjb25m
aWd1cmVkIGJ5IExpbnV4LCBub3QgYnkgdGhlIGJvb3Rsb2FkZXIgaW5pdGlhbGx5Pw0KPiAgICAg
PiA+DQo+ICAgICA+ID4gICAgID4gT3INCj4gICAgID4gPg0KPiAgICAgPiA+ICAgICA+IERyaXZl
ciBuZWVkcyB0byBoYW5kbGUgYm90aCBjYXNlcz8NCj4gICAgID4gPg0KPiAgICAgPiA+ICAgICA+
IEp1c3QgYXNraW5nLCBiZWNhdXNlIHlvdSBhcmUgdHVybmluZyBvbiB0aGUgY2xvY2sgdW5uZWNl
c3NhcmlseQ0KPiBoZXJlLA0KPiAgICAgPiA+ICAgICA+IElmIHlvdSBuZWVkIHRvIGFkZHJlc3Mg
YWxsIHRoZSB1c2UgY2FzZXMuIElmIGl0IGlzIGp1c3QgZmlyc3QNCj4gb25lLCB0aGVuDQo+ICAg
ICA+ID4gICAgID4gSXQgaXMgb2suDQo+ICAgICA+ID4NCj4gICAgID4gPiBIaSBCaWp1LA0KPiAg
ICAgPiA+DQo+ICAgICA+ID4gVGhlIGRyaXZlciB3YW50IHRvIGhhbmRsZSBhbGwgb2YgdGhlIHVz
ZSBjYXNlcy4gQ2FuIHlvdSB0ZWxsIG1lIHdoeQ0KPiB0dXJuaW5nDQo+ICAgICA+ID4gb24gdGhl
IGNsb2NrIGlzIHVubmVjZXNzYXJpbHkgaGVyZT8NCj4gDQo+ICAgICA+IEZvciB0aGUgdXNlIGNh
c2UsICJwd20gY29uZmlndXJlZCBieSBMaW51eCwgbm90IGJ5IHRoZSBib290bG9hZGVyDQo+IGlu
aXRpYWxseSIsDQo+IA0KPiAgICAgPiBZb3UgYXJlIHVubmVjZXNzYXJpbHkgdHVybmluZyBvbiB0
aGUgY2xvY2tzLiBZb3UgY291bGQNCj4gDQo+ICAgICA+IGVuYWJsZSBpdCBkdXJpbmcgcHdtX2Vu
YWJsZQ0KPiAgICAgPiBhbmQgZGlzYWJsZSBpdCBkdXJpbmcgcHdtX2Rpc2FibGUuDQo+IA0KPiAg
ICAgPiBGb3IgY29uZmlndXJpbmcgcmVnaXN0ZXJzLCB3aGlsZSBwd20gaXMgaW4gZGlzYWJsZSBz
dGF0ZSwNCj4gICAgID4geW91IGNvdWxkIGp1c3QgdHVybiBvbiB0aGUgY2xvY2sgYW5kIGRvIHRo
ZSByZWdpc3RlciBjb25maWd1cmF0aW9ucyBhbmQNCj4gdHVybiBpdCBvZmYuDQo+IA0KPiAgICAg
PiBCeSB0aGlzIHdheSB5b3UgYXJlIHNhdmluZyBwb3dlci4NCj4gDQo+IEhpIEJpanUsDQo+IA0K
PiBUaGlzIGNsb2NrIGlzIHRoZSBzb3VyY2UgY2xvY2sgZm9yIHRoZSBwd20gY29udHJvbGxlciAo
aW5jbHVkZSB0aGUgYWNjZXNzaW5nDQo+IGZvciB0aGUgcmVnaXN0ZXIpLg0KDQpPSywgQnV0IHRo
ZSBkcml2ZXIgaGFzIG9ubHkgb25lIGNsb2NrIChwcml2LT5jbGsgPSBkZXZtX2Nsa19nZXRfZW5h
YmxlZCgmcGFyZW50X2Rldi0+ZGV2LCBOVUxMKSkuDQpZb3UgYXJlIGFsd2F5cyB0dXJuaW5nIGl0
IG9uIGR1cmluZyBwcm9iZS4NCg0KDQo+IEZvciB0aGUgb3V0cHV0IG9mIHRoZSBQV00gKHB3bV9l
bmFibGUvcHdtX2Rpc2FibGUpLCB0aGUgY29udHJvbGxlciBoYXZlDQo+IGFub3RoZXIgcmVnaXN0
ZXIgdG8gY29udHJvbCBpdC4NCg0KVGhhdCBpcyBlbmFibGUvZGlzYWJsZSByZWdpc3RlciBmb3Ig
Y29udHJvbGxpbmcgdGhlIG91dHB1dCBvZiBQV00uDQoNCkNoZWVycywNCkJpanUNCg==
