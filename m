Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEF45BE7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiITOEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:04:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60068.outbound.protection.outlook.com [40.107.6.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03733A19;
        Tue, 20 Sep 2022 07:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1s5EJumQTfH8u5+nQQdkhY2rGFBYYBG6ISx51O48nBSDXe+KsLJ+Ap5xpFBwZl9XpfCBlYX5WluAbzIl95QA3v6/JkKXsyB7LA2eYMkajIsOngc8pC72kkVw9s9DUB8QC+CQ+x3o22pS4RJpH/pmErSSem3inCwYncd1G9X6mxAb62ASXfsJosTVAs4KgUbpQ+ZwMk1hQ2ZYJ+DoVJQCaushhi0SmZosapFmLupaewYR9mkcpKsQ9DIMdI4qc47s7ZakQMoaF3SH+CBoMMN/wkYmKjefoNt+wccJ0FllaFneLZZ6IjBRJz6LM6C45n+yONYv0SQn0TkmBZ59tCb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khKyq+lMYw7Kf6HIAh+dkqrBhhZgYRstCCQ/oFZWHTA=;
 b=XoXpPL7NkD//dZe1VDNckMS30AQRpY0MXrKOgIaSPvDcxHnjPGaJvg286/B5KQvS4Y7mqTqGj7ZMykKUwALBTqkd8SsUx2K6OE7+kRQLqNe8QafU9yxQTM+yLHZfSAuW6FuhzPbBpM91OhYGUCKJhrCWoPB7FJO36XUH10sdLfbo8VOT0naUaHRpE0AqRV6sR/XvxEUqXY4+9DCeHGK1coc4PGPrVuQgtlTZSPgcLiXFwpgx99ZjeG5C+PZHJ0+1zIraImr2Juv/GC7iheOO563wq3EoViOzgiHP+msd3QegbkAWJpSZTZSW5DPSz/TRKxrwcsDMurOZEyM2xjQGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khKyq+lMYw7Kf6HIAh+dkqrBhhZgYRstCCQ/oFZWHTA=;
 b=HLVrUB2gOuAOtA7GSgofALKTYfbehiUz46+Wo949XUV0AfYL4v/jmAG6bVEiEYN0pLotpkab6SLa8UlYtnOFrLRf5Gksu9warecyZN+epl8mPvubjzfg8ZagaElcLmkCsFOrIXszrthX3XUUVjumKOaS/NuaTANYYnkYLiq0QsY=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 14:04:05 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 14:04:04 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "bhuvanchandra.dv@toradex.com" <bhuvanchandra.dv@toradex.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: disable dma rx/tx use flags in
 lpuart_dma_shutdown
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: disable dma rx/tx use flags in
 lpuart_dma_shutdown
Thread-Index: AQHYzONQq3XMfMWY1E+X54tNGbt8Yq3oPm+AgAAaaXA=
Date:   Tue, 20 Sep 2022 14:04:04 +0000
Message-ID: <AS8PR04MB84049C72D2B47640CC32BBDB924C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220920111703.1532-1-sherry.sun@nxp.com>
 <ba937cd2-8a79-5352-c6bc-e553ee9baeed@linux.intel.com>
In-Reply-To: <ba937cd2-8a79-5352-c6bc-e553ee9baeed@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DB9PR04MB8187:EE_
x-ms-office365-filtering-correlation-id: c78dbc5d-f654-4c0f-9fa0-08da9b10fa6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsz5YwYO9O1G1zHmUZeSC6WMtSS2E0iUmzhzpgBtwGaMNZCSwh1R9N9SEJYN+igeNHzZo3gH3U2HZyGGyD8V8FHxW2z8utOooPtGqsyBk24ZpixXsPo1H0HhGVSnU8qEC5nDjywEuOYPF3XL0MFLp1ltaSziTFJCu0ZxEUvt1cC83PjOrPE/OcNDlwpcb5UXt2wWQEO2dxOjTdv//1bFMvtDL4Q6M64biCBKMK+ZvpMuJt3CSGJyuAllmrlFx5vqIXgQvVJq4h66cwDSxzUI9eGgCGEi/K2BFoyTdh3IytYy9aQTQJwjHPcOsW92RvDNWeJqrLfdh71y/dW2lhbTaIrEidQAzzPJd6zMPQqxIdQfzVJsJVIY+2VdQcsQz5qgk4Pkh2jHK3k3iam+zIhGNGxIonXpI5m4tvkQGAeOmo/MWFekPZMJUByYG6WoQaQhhAi8NZE+7p/Nac4Iv98a0+Q8gEXRJdJD1DVh2fw/eJvaioolAcctm/4sUQhhRuUAJq6wqmK3+96k912+NnVdcZb/3DZhHh8A5W1b3AgTjfyYQXe2MCaUbbqrlWTN2uKyUS5I/s5hJNVKxSWcxgOAfTEYJn56i6qpobFf3IVIQ2biIb+/2gzc13E2pzoxgSqrVaVn5V37kkn4QlLW/CZ6cSaEnUDrfN9f5AEatEJl/q86FnpAIaWA1rWkvcnQ0f11Lnuxj/Gpcg4WyFira9GoTpp8lziDLHn6BnzRDP5E8fbLeO3W1/juvR5Be8Hg1mEY5Ia8UR8q/3l0gfYngCnYZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(478600001)(66556008)(45080400002)(76116006)(66946007)(54906003)(6916009)(71200400001)(33656002)(66446008)(64756008)(8676002)(4326008)(41300700001)(7696005)(6506007)(86362001)(53546011)(52536014)(38070700005)(66476007)(8936002)(26005)(55016003)(122000001)(38100700002)(83380400001)(5660300002)(9686003)(316002)(186003)(66574015)(44832011)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SExON0tzY0R3UUx4aWs5SFBueE43bWIrZkk0dXhjUWVCRlB3TU5yQmRDcUxS?=
 =?utf-8?B?cXZXa1lsM0hBNndjWVViTkNqb2FVdjlId1h4SzBDU2JJTnV1Yk1HdTVUbzdM?=
 =?utf-8?B?YXJJUUpmd2pPc1pjR0FlWTVpSDVtVkt3RDhpMk5MRm1GWjN1NnVpOFUzOXZn?=
 =?utf-8?B?aEJLS244N1B6QXFlZmVmZ1R3blQ2WlFaUmtwVG9OaTRsN3orZTBBeisxVGFa?=
 =?utf-8?B?bk1KNVhUTjcvNkZmNXdkbm9RazF1NUJDL3RZNnUyb3IyMDkxeVZ1UFd6bTNq?=
 =?utf-8?B?TEMzc3NRVG9qOWdhbTc2cFduUjg2dVJyYUFJRjdpTDZBdklHVWFWYy9zMTRo?=
 =?utf-8?B?WVZUVDVlUGdOUUFNUXV1MWRoWHo5S2QyZjdmSnl6WlN4YjJsbzFVcDh6Qm1O?=
 =?utf-8?B?K2dpaUE4bEhiSkpTRGhYN2gvUVJoWDhWTzVoVDRhc3REVThmRDVBOVF2VGNF?=
 =?utf-8?B?OXBRS1JhaHJIcldWWlNOeTYraWtkbkpLM2RMcXZTSU9CVkN4YmU5TjZoai9Y?=
 =?utf-8?B?ZGVyUWRaV0U3QzFPTEwrTys3WmJKNGxJRi90NE42ZlRsTFhlYzN6VHdVbkVE?=
 =?utf-8?B?ZjZiQTNMbFA5MTNYUE13VllyL0VOaGdSZkdKNGF6QS91b1pUTm5tSERlTkZ1?=
 =?utf-8?B?Ry9KV2lSTkRQTzJBZCt5dFVXN01zQmlJY0Y1bVRNVHY1UjNVUEJIZUd2SjFj?=
 =?utf-8?B?MGlFNC9TOUZpRmRFaWhZMXpCVjhIckpieVJnalZSWkVLaEhmOWhiOXFnVUsv?=
 =?utf-8?B?VjlHbUZLVlVEMmVzUXkvUXRKUTZZTUVKSXFPQi9hOVJtSldkRmtvRXR6ZXZO?=
 =?utf-8?B?Ri9GYy82R1lWTXdEZkg5U2UzRUFPNGY1VllvNXVvVWdjRzYyeS9uTm9IRHZi?=
 =?utf-8?B?dEZTdUhqVm1PYlN1enVYU1Jkc3VqUm9pSSsrNzRlWFFCNlMzSERJbi9GTU1y?=
 =?utf-8?B?MFhUMGNhSmJXNUNKaDBBNVI3dW5ONGJWM1RKeTVVSlh6MFEyVTNmU3Y2SVlT?=
 =?utf-8?B?V2loM0IrRWlWekVxb1htZmVRdTh2eXVlRHl1QVh6WXJ0VFdPbzNyUGFJWEhX?=
 =?utf-8?B?TkRFZitZYVBrV3dZMkVEVnpUczFiOW9GNTIvYWJwNGJLY3Vid1V3T25kUG5z?=
 =?utf-8?B?RCtVaDBUbnBmc3R2QUpXLy9LOFEydW9EYy8zL1JIRzVKa3dyUWUxWm1MOG1s?=
 =?utf-8?B?WFc2NldLSjJrTTNscVhSUXFNbzV0b0hJcXhUNkxiNnl4WTIwaktWMDF6L1N0?=
 =?utf-8?B?RXZxajlLSlZ0REhXanJVbWgrWmUzbkRCbkpYMkY1MEVKMm9NSVZSRVE2Rk5B?=
 =?utf-8?B?VWVwTUI3dXZtNWZoQ3dGcFJZUjZmNWZnVHJuNVl3bm9jeTFVZk14Z3VzSkhD?=
 =?utf-8?B?R2xpMytFUGRqTDE3WHA1QlB4aVhoa3FWM1pHS3NiVGdXZU81MjZ6M2ZvdDdB?=
 =?utf-8?B?aUszNEdQcFkzWEsrWVBad3g3QlhXQWlFMmE0NXFuVjk4eUE0ZHBhZjdxTlky?=
 =?utf-8?B?TDB2VE9HOUEyT05QN2p3SUFPYitrOVVDaEMzb3IyQlJ3SGRkY1JMWS9EdGtW?=
 =?utf-8?B?b2dJZGN4L2JaaUpQMmY5aHpLRzZ1ZW1IdXh2VmdSb1lzK0U3T3paZnEvLzRu?=
 =?utf-8?B?T256ZkdPV3BtSVhDVXY0SEtwVFRMZEJCMFJSSXZaTWVZRzFqSm44a0Fqc044?=
 =?utf-8?B?NjA4K2xDR3lWWDRhOHl2QTYrem5nRGwwMlhHbXlQZ0NVdnNOK050M2JzNGd6?=
 =?utf-8?B?TXRydXBKM3U5dXBvNWY0QlA0cFI2SnZKeUJFTkZCRTNFN1g1UndXYUhYMWpi?=
 =?utf-8?B?eDNndjJybDdlVkx6bHRRNkorNHFoUGZKdGZlVUJ4WWFCWE90L3FsUVFVNngy?=
 =?utf-8?B?OStSUHNiVElMQ0EySXNmVmVDc0VTWlJsWlpBbTZwdDRWdHdGaUtRTSs2WTJv?=
 =?utf-8?B?T2luNWRXSDJ6anl1cXRTMGNsZzZOakNmcEhXZmRWK1RsVkN1amdlYTdKNzJZ?=
 =?utf-8?B?bUZ5VCs0NzUwLzkxVnU0dDY0bHMyQWZCQjk0SXM2QXh3dG9xTUZvcXYwMXgw?=
 =?utf-8?B?dkRuUjlKUEFXTDZsM3hCM3M1QTRra2VpM3ptV2lVeXhkdGxjamNOMXJJdUky?=
 =?utf-8?Q?pXX2eH+KE35WcDX+twVlsnLcN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78dbc5d-f654-4c0f-9fa0-08da9b10fa6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 14:04:04.9173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rc83C9fjUZKi0vbeZypQJTMXknw64H50+q18sLsC2ET+/3cK9U2ZhWxMH+/t1dBnSt7Bx+LcrJeZag6FgTtRWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187
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
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDIy5bm0OeaciDIw5pel
IDIwOjI2DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZzsgamlyaXNsYWJ5QGtlcm5lbC5vcmc7DQo+IGJodXZhbmNo
YW5kcmEuZHZAdG9yYWRleC5jb207IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0dHk6IHNlcmlhbDogZnNsX2xwdWFydDogZGlz
YWJsZSBkbWEgcngvdHggdXNlIGZsYWdzIGluDQo+IGxwdWFydF9kbWFfc2h1dGRvd24NCj4gDQo+
IE9uIFR1ZSwgMjAgU2VwIDIwMjIsIFNoZXJyeSBTdW4gd3JvdGU6DQo+IA0KPiA+IGxwdWFydF9k
bWFfc2h1dGRvd24gdGVhcnMgZG93biBscHVhcnQgZG1hLCBidXQgbHB1YXJ0X2ZsdXNoX2J1ZmZl
ciBjYW4NCj4gPiBzdGlsbCBvY2N1ciB3aGljaCBpbiB0dXJuIHRyaWVzIHRvIGFjY2VzcyBkbWEg
YXBpcyBpZg0KPiA+IGxwdWFydF9kbWFfdHhfdXNlIGZsYWcgaXMgdHJ1ZS4gQXQgdGhpcyBwb2lu
dCBzaW5jZSBkbWEgaXMgdG9ybiBkb3duLA0KPiA+IHRoZXNlIGRtYSBhcGlzIGNhbiBhYm9ydC4g
U2V0IGxwdWFydF9kbWFfdHhfdXNlIGFuZCB0aGUgY29ycmVzcG9uZGluZw0KPiA+IHJ4IGZsYWcg
bHB1YXJ0X2RtYV9yeF91c2UgdG8gZmFsc2UgaW4gbHB1YXJ0X2RtYV9zaHV0ZG93biBzbyB0aGF0
IGRtYXMNCj4gPiBhcmUgbm90IGFjY2Vzc2VkIGFmdGVyIHRoZXkgYXJlIHJlbGlucXVpc2hlZC4N
Cj4gPg0KPiA+IE90aGVyd2lzZSwgd2hlbiB0cnkgdG8ga2lsbCBidGF0dGFjaCwga2VybmVsIG1h
eSBwYW5pYy4gVGhpcyBwYXRjaCBtYXkNCj4gPiBmaXggdGhpcyBpc3N1ZS4NCj4gPiByb290QGlt
eDh1bHBldms6fiMgYnRhdHRhY2ggLUIgL2Rldi90dHlMUDIgLVMgMTE1MjAwDQo+ID4gXkNbICAg
OTAuMTgyMjk2XSBJbnRlcm5hbCBlcnJvcjogc3luY2hyb25vdXMgZXh0ZXJuYWwgYWJvcnQ6IDk2
MDAwMjEwIFsjMV0NCj4gUFJFRU1QVCBTTVANCj4gPiBbICAgOTAuMTg5ODA2XSBNb2R1bGVzIGxp
bmtlZCBpbjogbW9hbChPKSBtbGFuKE8pDQo+ID4gWyAgIDkwLjE5NDI1OF0gQ1BVOiAwIFBJRDog
NTAzIENvbW06IGJ0YXR0YWNoIFRhaW50ZWQ6IEcgICAgICAgICAgIE8NCj4gNS4xNS4zMi0wNjEz
Ni1nMzRlZWNkZjJmOWU0ICMzNw0KPiA+IFsgICA5MC4yMDM1NTRdIEhhcmR3YXJlIG5hbWU6IE5Y
UCBpLk1YOFVMUCA5WDkgRVZLIChEVCkNCj4gPiBbICAgOTAuMjA4NTEzXSBwc3RhdGU6IDYwMDAw
MGM1IChuWkN2IGRhSUYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUw0KPiBCVFlQRT0tLSkNCj4g
PiBbICAgOTAuMjE1NDcwXSBwYyA6IGZzbF9lZG1hM19kaXNhYmxlX3JlcXVlc3QrMHg4LzB4NjAN
Cj4gPiBbICAgOTAuMjIwMzU4XSBsciA6IGZzbF9lZG1hM190ZXJtaW5hdGVfYWxsKzB4MzQvMHgy
MGMNCj4gPiBbICAgOTAuMjI1MjM3XSBzcCA6IGZmZmY4MDAwMTNmMGJhYzANCj4gPiBbICAgOTAu
MjI4NTQ4XSB4Mjk6IGZmZmY4MDAwMTNmMGJhYzAgeDI4OiAwMDAwMDAwMDAwMDAwMDAxIHgyNzoN
Cj4gZmZmZjAwMDAwODQwNDgwMA0KPiA+IFsgICA5MC4yMzU2ODFdIHgyNjogZmZmZjAwMDAwODQw
NDk2MCB4MjU6IGZmZmYwMDAwMDg0MDRhMDggeDI0Og0KPiBmZmZmMDAwMDA4NDA0YTAwDQo+ID4g
WyAgIDkwLjI0MjgxM10geDIzOiBmZmZmMDAwMDA4NDA0YTYwIHgyMjogMDAwMDAwMDAwMDAwMDAw
MiB4MjE6DQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gPiBbICAgOTAuMjQ5OTQ2XSB4MjA6IGZmZmY4
MDAwMTNmMGJhZjggeDE5OiBmZmZmMDAwMDA1NTljODAwIHgxODoNCj4gMDAwMDAwMDAwMDAwMDAw
MA0KPiA+IFsgICA5MC4yNTcwNzhdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAw
MDAwMDAwMDAgeDE1Og0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gWyAgIDkwLjI2NDIxMV0geDE0
OiAwMDAwMDAwMDAwMDAwMDAzIHgxMzogMDAwMDAwMDAwMDAwMDAwMCB4MTI6DQo+IDAwMDAwMDAw
MDAwMDAwNDANCj4gPiBbICAgOTAuMjcxMzQ0XSB4MTE6IGZmZmYwMDAwMDYwMGMyNDggeDEwOiBm
ZmZmODAwMDEzZjBiYjEwIHg5IDoNCj4gZmZmZjAwMDA1N2JjYjA5MA0KPiA+IFsgICA5MC4yNzg0
NzddIHg4IDogZmZmZmZjMDAwMDI0MWEwOCB4NyA6IGZmZmYwMDAwMDUzNGVlMDAgeDYgOg0KPiBm
ZmZmMDAwMDA4NDA0ODA0DQo+ID4gWyAgIDkwLjI4NTYwOV0geDUgOiAwMDAwMDAwMDAwMDAwMDAw
IHg0IDogMDAwMDAwMDAwMDAwMDAwMCB4MyA6DQo+IGZmZmYwMDAwMDU1YjM0ODANCj4gPiBbICAg
OTAuMjkyNzQyXSB4MiA6IGZmZmY4MDAwMTM1YzAwMDAgeDEgOiBmZmZmMDAwMDA1MzRlZTAwIHgw
IDoNCj4gZmZmZjAwMDAwNTU5YzgwMA0KPiA+IFsgICA5MC4yOTk4NzZdIENhbGwgdHJhY2U6DQo+
ID4gWyAgIDkwLjMwMjMyMV0gIGZzbF9lZG1hM19kaXNhYmxlX3JlcXVlc3QrMHg4LzB4NjANCj4g
PiBbICAgOTAuMzA2ODUxXSAgbHB1YXJ0X2ZsdXNoX2J1ZmZlcisweDQwLzB4MTYwDQo+ID4gWyAg
IDkwLjMxMTAzN10gIHVhcnRfZmx1c2hfYnVmZmVyKzB4ODgvMHgxMjANCj4gPiBbICAgOTAuMzE1
MDUwXSAgdHR5X2RyaXZlcl9mbHVzaF9idWZmZXIrMHgyMC8weDMwDQo+ID4gWyAgIDkwLjMxOTQ5
Nl0gIGhjaV91YXJ0X2ZsdXNoKzB4NDQvMHg5MA0KPiA+IFsgICA5MC4zMjMxNjJdICArMHgzNC8w
eDEyYw0KPiA+IFsgICA5MC4zMjcyNTNdICB0dHlfbGRpc2NfY2xvc2UrMHgzOC8weDcwDQo+ID4g
WyAgIDkwLjMzMTAwNV0gIHR0eV9sZGlzY19yZWxlYXNlKzB4YTgvMHgxOTANCj4gPiBbICAgOTAu
MzM1MDE4XSAgdHR5X3JlbGVhc2Vfc3RydWN0KzB4MjQvMHg4Yw0KPiA+IFsgICA5MC4zMzkwMjJd
ICB0dHlfcmVsZWFzZSsweDNlYy8weDRjMA0KPiA+IFsgICA5MC4zNDI1OTNdICBfX2ZwdXQrMHg3
MC8weDIzNA0KPiA+IFsgICA5MC4zNDU2NTJdICBfX19fZnB1dCsweDE0LzB4MjANCj4gPiBbICAg
OTAuMzQ4NzkwXSAgdGFza193b3JrX3J1bisweDg0LzB4MTdjDQo+ID4gWyAgIDkwLjM1MjQ1NV0g
IGRvX2V4aXQrMHgzMTAvMHg5NmMNCj4gPiBbICAgOTAuMzU1Njg4XSAgZG9fZ3JvdXBfZXhpdCsw
eDNjLzB4YTANCj4gPiBbICAgOTAuMzU5MjU5XSAgX19hcm02NF9zeXNfZXhpdF9ncm91cCsweDFj
LzB4MjANCj4gPiBbICAgOTAuMzYzNjA5XSAgaW52b2tlX3N5c2NhbGwrMHg0OC8weDExNA0KPiA+
IFsgICA5MC4zNjczNjJdICBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweGQ0LzB4ZmMNCj4g
PiBbICAgOTAuMzcyMDY4XSAgZG9fZWwwX3N2YysweDJjLzB4OTQNCj4gPiBbICAgOTAuMzc1Mzc5
XSAgZWwwX3N2YysweDI4LzB4ODANCj4gPiBbICAgOTAuMzc4NDM4XSAgZWwwdF82NF9zeW5jX2hh
bmRsZXIrMHhhOC8weDEzMA0KPiA+IFsgICA5MC4zODI3MTFdICBlbDB0XzY0X3N5bmMrMHgxYTAv
MHgxYTQNCj4gPiBbICAgOTAuMzg2Mzc2XSBDb2RlOiAxN2ZmZmZkYSBkNTAzMjAxZiBkNTAzMjMz
ZiBmOTQwOTgwMiAoYjk0MDAwNDEpDQo+ID4gWyAgIDkwLjM5MjQ2N10gLS0tWyBlbmQgdHJhY2Ug
MmY2MDUyNGI0YTQzZjFmNiBdLS0tDQo+ID4gWyAgIDkwLjM5NzA3M10gbm90ZTogYnRhdHRhY2hb
NTAzXSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDENCj4gPiBbICAgOTAuNDAyNjM2XSBGaXhp
bmcgcmVjdXJzaXZlIGZhdWx0IGJ1dCByZWJvb3QgaXMgbmVlZGVkIQ0KPiA+DQo+ID4gRml4ZXM6
IDYyNTBjYzMwYzRjNCAoInR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBVc2Ugc2NhdHRlci9nYXRo
ZXIgRE1BDQo+ID4gZm9yIFR4IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaGFyYSBHb3BpbmF0aCA8
dGdvcGluYXRoQG1pY3Jvc29mdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8
c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNs
X2xwdWFydC5jIHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+
IGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBpbmRleCBmMjE5MTUwMTVkNjcuLjA2
NGJkMWYzM2MyMQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xf
bHB1YXJ0LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4g
QEAgLTE3NzEsNiArMTc3MSw3IEBAIHN0YXRpYyB2b2lkIGxwdWFydF9kbWFfc2h1dGRvd24oc3Ry
dWN0DQo+IGxwdWFydF9wb3J0ICpzcG9ydCkNCj4gPiAgCWlmIChzcG9ydC0+bHB1YXJ0X2RtYV9y
eF91c2UpIHsNCj4gPiAgCQlkZWxfdGltZXJfc3luYygmc3BvcnQtPmxwdWFydF90aW1lcik7DQo+
ID4gIAkJbHB1YXJ0X2RtYV9yeF9mcmVlKCZzcG9ydC0+cG9ydCk7DQo+ID4gKwkJc3BvcnQtPmxw
dWFydF9kbWFfcnhfdXNlID0gZmFsc2U7DQo+ID4gIAl9DQo+ID4NCj4gPiAgCWlmIChzcG9ydC0+
bHB1YXJ0X2RtYV90eF91c2UpIHsNCj4gPiBAQCAtMTc3OSw2ICsxNzgwLDcgQEAgc3RhdGljIHZv
aWQgbHB1YXJ0X2RtYV9zaHV0ZG93bihzdHJ1Y3QNCj4gbHB1YXJ0X3BvcnQgKnNwb3J0KQ0KPiA+
ICAJCQlzcG9ydC0+ZG1hX3R4X2luX3Byb2dyZXNzID0gZmFsc2U7DQo+ID4gIAkJCWRtYWVuZ2lu
ZV90ZXJtaW5hdGVfYWxsKHNwb3J0LT5kbWFfdHhfY2hhbik7DQo+ID4gIAkJfQ0KPiA+ICsJCXNw
b3J0LT5scHVhcnRfZG1hX3R4X3VzZSA9IGZhbHNlOw0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlpZiAo
c3BvcnQtPmRtYV90eF9jaGFuKQ0KPiANCj4gSXNuJ3QgaXQgc3RpbGwgcmFjeSBiZWNhdXNlIGxw
dWFydF9kbWFfc2h1dGRvd24oKSBpcyBjYWxsZWQgb3V0c2lkZSBvZiBwb3J0J3MNCj4gbG9jaz8N
Cg0KSGkgSWxwbywgZG8geW91IHRoaW5rIGFkZCB0aGUgZm9sbG93aW5nIGNoYW5nZXMgc2hvdWxk
IHdvcmsgZm9yIHRoaXM/DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xw
dWFydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KaW5kZXggMDY0YmQxZjMz
YzIxLi5iM2M1MzkzNWZiYzggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xw
dWFydC5jDQorKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQpAQCAtMTc2OCwx
MCArMTc2OCwxNCBAQCBzdGF0aWMgaW50IGxwdWFydDMyX3N0YXJ0dXAoc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCkNCg0KIHN0YXRpYyB2b2lkIGxwdWFydF9kbWFfc2h1dGRvd24oc3RydWN0IGxwdWFy
dF9wb3J0ICpzcG9ydCkNCiB7DQorICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQorDQogICAg
ICAgIGlmIChzcG9ydC0+bHB1YXJ0X2RtYV9yeF91c2UpIHsNCiAgICAgICAgICAgICAgICBkZWxf
dGltZXJfc3luYygmc3BvcnQtPmxwdWFydF90aW1lcik7DQogICAgICAgICAgICAgICAgbHB1YXJ0
X2RtYV9yeF9mcmVlKCZzcG9ydC0+cG9ydCk7DQorICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2ly
cXNhdmUoJnNwb3J0LT5wb3J0LmxvY2ssIGZsYWdzKTsNCiAgICAgICAgICAgICAgICBzcG9ydC0+
bHB1YXJ0X2RtYV9yeF91c2UgPSBmYWxzZTsNCisgICAgICAgICAgICAgICBzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZzcG9ydC0+cG9ydC5sb2NrLCBmbGFncyk7DQogICAgICAgIH0NCg0KICAgICAg
ICBpZiAoc3BvcnQtPmxwdWFydF9kbWFfdHhfdXNlKSB7DQpAQCAtMTc4MCw3ICsxNzg0LDkgQEAg
c3RhdGljIHZvaWQgbHB1YXJ0X2RtYV9zaHV0ZG93bihzdHJ1Y3QgbHB1YXJ0X3BvcnQgKnNwb3J0
KQ0KICAgICAgICAgICAgICAgICAgICAgICAgc3BvcnQtPmRtYV90eF9pbl9wcm9ncmVzcyA9IGZh
bHNlOw0KICAgICAgICAgICAgICAgICAgICAgICAgZG1hZW5naW5lX3Rlcm1pbmF0ZV9hbGwoc3Bv
cnQtPmRtYV90eF9jaGFuKTsNCiAgICAgICAgICAgICAgICB9DQorICAgICAgICAgICAgICAgc3Bp
bl9sb2NrX2lycXNhdmUoJnNwb3J0LT5wb3J0LmxvY2ssIGZsYWdzKTsNCiAgICAgICAgICAgICAg
ICBzcG9ydC0+bHB1YXJ0X2RtYV90eF91c2UgPSBmYWxzZTsNCisgICAgICAgICAgICAgICBzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZzcG9ydC0+cG9ydC5sb2NrLCBmbGFncyk7DQogICAgICAgIH0N
Cg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
