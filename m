Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4160067A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJQFze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJQFz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:55:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34526D5;
        Sun, 16 Oct 2022 22:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY1R8aEN/qcOCaNu9qGKzR7NDDDlpwQtTXFjPVEsyc2pMuWDn5Wntz1XArw7Pme+M50LUQtQtqXqldZJDxw5zJBGvoW59BDGguvCMgVbEq9qD0lkKh0litIUEb0rryayOfYg2+y2S5xNNMnvBlrbBtumjVK8uNOMiChgIPL6X55raDEEp0AK3kSt28DYKdWoSyLB8rWuFeBNHfxqKSe7muEzZqeXCIoitloFWaOGUq2JKtEbobJneDpO3wL8n8dP8zZtVKmc2L3kOhf8CmBp4yBc0fk+bA011TFqmAso+iS6hUWEt5lqzS7cZ1vA9o7PoOl1D5WEnIpWBFsoPImP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIHb5IkzAeR2f40oVRnHc7jvc1ysfgf3OhJX22DK+9g=;
 b=PJtkk38CeywkKAN5ZfWc10mVGOgrkvHRrPAK60Fy3QOoDs+QSEFolZiXCp6QTPzGebUvO1mhEA9UMuKTQNa721JU/96Yx5hdBDd4I3qMxfXerw2bXM2W//rWv1pbALPpAkR7kBxy9NPTyEB/EBw0nn2DLh4r2N0nDZ2M0cm6w718nxaepSEeDIj0WmaDeJe4vkpLfwPh8zUAZgl4FQjyhSIlCLMDFHYGflWzmrrktHs87gzPCjSDvsT9MSaakVoCLqQBmV4EGQB/mt2TYXoGuggAF66vjL08k7TJF/3m4+f4rb7BxGW7NBJIqhDvoSIND8l8JV4LO6UweDxaFxyJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIHb5IkzAeR2f40oVRnHc7jvc1ysfgf3OhJX22DK+9g=;
 b=a9b9+zJpJydo1YYL8kzXcYO0Fl580GaVoRRNlnN83iBY24oKRNpAHCh0VYtCRAm5yD4xLKuYm7zkoOGuG4a3f5yd47+1PUvIAWGX0q5KPk6aixJZr/pKFKbKOl5OO8j/yAOxECPvYBZzJs7rOICg5SXLMONPir1w4Cinht3NJAw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 05:55:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 05:55:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH V2 4/6] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Thread-Topic: [PATCH V2 4/6] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Thread-Index: AQHY37JprV1rugCYiEuEviVPf0orFa4Pjd6AgAKMDYA=
Date:   Mon, 17 Oct 2022 05:55:26 +0000
Message-ID: <DU0PR04MB94174301DB7C9C5322EEFC9D88299@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-5-peng.fan@oss.nxp.com>
 <419bdedb-bcc0-e58c-d1f8-1d66cbc4edf9@linaro.org>
In-Reply-To: <419bdedb-bcc0-e58c-d1f8-1d66cbc4edf9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8609:EE_
x-ms-office365-filtering-correlation-id: 7f8d4763-0c48-4c5d-d44c-08dab0043042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1zjr/UXcYswrQqXTbhxyCZZ5G18CoDk1Z8x3dhWjXoAtnoZppphE116H/D2L08i1o9q1c2h+tk3HCTy5i85CPQ4+lh6fRKUkgq7d5CJNUJ3kMRy/oshpagZOmPoYe7DnyLSd4C/Lf9Ngv0+oH/uMTUfGSQPRtrFIGkklpuvEfai+ZkU8ntRbX5ytxhjfVfowunEb24RszhVjfRXTRmp1F7mMSKUf2DNMbAXWFZWumsKu+j1W5UMSwW/l1UXPK1b2BiHrjE1ZTwJUrUEGLZUC0vtHNZj0R378TMfU5dNs188AmKeYXnvCHNWjX3v6xqCnaX9Xs+4znQybo0uVvnGeqZfJKcc+1OV1oxN52JF6yoG7GNnlhESN/bJHefVq2Ub7kN+8p8uhaOtDe3IqJmN/Cu0q6hqSipxXhp8LOVMpZi/0chStx0Q1KHUJFCLNuUnPOHlg6uhiXmiDWIzQCB4t6uthGN51R3BUkSsKHxeqhdo6W/qB0s56/6Pwgk2IhV7w0HoM3b8+yIiW1Cjm9GDCAuF+qXzkjCjs6cEx1GJoIQ6CMoYy7bdiwOt116ZlTtzSfTvB+oceg9Oj+5qjUfLABhbEA8T2j/bAQqtpC8VjWaNsieR9CyNG3IlZs7npivEAyPgHL24MlvC3PNv0U+HmrDAjMSobNisWTB+lqSRNS9fTbC7MDI1u6JPL+25nfgw5lLH+BeliEDzI61cLmxrU9jnimUYWzVvU7ktcdPtIkzCmrdUtU1Q3/EM27LLsizQdLZqBYprDigo4sjJULKSFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(55016003)(478600001)(71200400001)(54906003)(6636002)(86362001)(110136005)(316002)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(53546011)(186003)(2906002)(6506007)(7696005)(38070700005)(9686003)(26005)(33656002)(38100700002)(44832011)(122000001)(7416002)(5660300002)(83380400001)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzJuUmI2SVFhMjF4S3NJVE9kOWplRm9idTlwNFhxYTJ5NHNmUmdOZG85eW4y?=
 =?utf-8?B?aGovN2hOSWlqeFhTOW9RSU1UbXJraVhNWEIvSW5KQVhoN2hMVGR5ZCtJRzJk?=
 =?utf-8?B?d2VqbmVEN3ZnMlg4Q0E3TVg0TUI5OTlha1F1TThPeHc2MSs0ekkwUTlkdmhl?=
 =?utf-8?B?Z3ZVbkRhaGN1UnhDZFZYQlBqTlc3ZHo4TmRJZWhQdTloNmVxK3A5VHduNmQz?=
 =?utf-8?B?YUo4aTUxdUhwKzdTUThaSmEreVlRZE8xWk5jZGhIZ0taeldJQU5mR1NYeGZS?=
 =?utf-8?B?aUhqQ0Z5RzlpOVJnVnE2amhCRk5NSTVEd3FYSVVmeGpBWlBCemZnSzlmbXhW?=
 =?utf-8?B?SWdBQzg0RkpqaGVSZnlWdXdQR3hxeE1zbGJybTlGSHo5TEE1eCtvQUJ4V21P?=
 =?utf-8?B?cGpTM2haWlE0TDFNRHlHOU01VXRmbFVSMFZlK0orU1M4OHY1VVZqNzIwRFVj?=
 =?utf-8?B?WTQ5NDAvYlY0N3RvSDdORUFHNVFIbnlmWWhQMk9YN0pFRFVaekRyWjZUVCtU?=
 =?utf-8?B?TkVUYWlNS290czB0K0IvdnBoTmN4ekkrMGRyUTlPUlAwWm5XTDFGZlJzUmky?=
 =?utf-8?B?UjM2RWpLc0hQR242bEpRUVV6ckQ2TFkyVEVIOWFPbXd5My91Z1p3VUFOUHdS?=
 =?utf-8?B?dXAxTG1meGQ5SzlsL0xuYjFMWnB6YTE3aEJMemd1VDN5ZnFJYkFBNzZ5NnBi?=
 =?utf-8?B?K1djMHMvZCs5YTFFTlRHbjQ5QzRKWWtjWkZJN0VkeEZHTmR6SU1zNFkxUkdl?=
 =?utf-8?B?ak9WVS8waFh6TDJEbUxxSHhIMGF5ZWVaNlNFSjIrblAzbGtBbElxODFaYURG?=
 =?utf-8?B?MzJBQVFtRkhnODN4NDdKOW1EM2VzVDY0dFRwd2R5YUJ4Z2VCNTV6T0gvSUZv?=
 =?utf-8?B?bmdYV1FjcDg2MkNQeTJNUHltNkFzMGZNZENmU1BVNHBMMERQakVSYmxnYU5j?=
 =?utf-8?B?OURnckZoTFVBVnlZYllKc0N2TXB3WjIrUUdtSkZZeW9qcDRtdElDLzhJc1RZ?=
 =?utf-8?B?ZXZ1UXd0clMwVlZsUDJoalVHZjd4NGw3ZEFodHBma1IwSG9ReForV05lNVRP?=
 =?utf-8?B?ZUhyQytodUZEL1cycHpnWHBGdmJIVmRlUHVxU3lIVzU2TjdETjB4M1NjdmtT?=
 =?utf-8?B?U3ppNHBJS3A3MHhyNVIyYmVjS2lPYmk3NHdnYTYzRnI3ckh1RWk3cUtDbDMv?=
 =?utf-8?B?elUzUHRqM0YxZi9VNGoyd2NsMnRxR1d1TjhZMG9CeWt4TnVvV0RTaWZTcldJ?=
 =?utf-8?B?cjNZcXoyVGFpa2ZXbjdiVGN3dmloNWFHay8zWDdOU0x3a3gxSnZCVFR4QVQ0?=
 =?utf-8?B?VDAzRUhzdUhwQ2c3M0dvWXgvU1dmdjJqdDVpb2JSQlFaNzN1a09RT0xMc0VF?=
 =?utf-8?B?VmVldXJFbVBmbENYeGErRFlWUDZISjNYNERhZC9xdEVrZFRRN2w5MWxwYjhM?=
 =?utf-8?B?SUF5T1R1aEhZdUp5TElQU2VuU3M0d1JQZDFXd3VoNWN4MVljQ2VVWEVjOXA4?=
 =?utf-8?B?b1NjTmpaazA4ek9kR1U3R1kzbWtXdmFrM1NHR2gxRDNmREwzNWRoN3djcnRk?=
 =?utf-8?B?eWhhWGo0YTkwci9IQ0NnNndXL3FBelpGYnlaU1Q4K2ZEZExBVis4elJmUC8r?=
 =?utf-8?B?U2FLSHhCWFhRSVhNWjVCNmR0aUtFQVg1VENQZE1EcmpUQlF0RDV0TTI0T3dr?=
 =?utf-8?B?WFRoZTdjWE5pdnJCdW5lR1prbm1wSUZwOEpZdmI5SXNWWVd1YUdUeWtzRmxG?=
 =?utf-8?B?SEZsTE04M3YvTEgvdzROTnI5VEhNZ2ZBSWtUZ1pHam1MVTluM0t5bGhzazJE?=
 =?utf-8?B?RXJ2NlJHOWhoMUFUYmk3UjgzS0lDK0R4M1owZmxRRzFDYVRYQmdMcjh5MGxn?=
 =?utf-8?B?Zy9QNit4aE1lTkNRanFEZlV3bnhJWCtDVHQ1VXI4d0Z6ZjdacWhWT3pUc25H?=
 =?utf-8?B?U1VvUlVzazZOZXpPZkt2VDE0N2VxSmJUNCtzd3hDS1F5RG1rb2c4Tmxlb3dW?=
 =?utf-8?B?UWlaOHBnK2s4d3R3c1E2WjFKcUkyOVZmMVl5Q0MyT244aitTUnBCTzN5Rk1C?=
 =?utf-8?B?TWw5dkdQYnkyODZUUE5tU091cnBFcVJyREJrN2N1QnZTakNKRTlzRTNNbEh6?=
 =?utf-8?Q?Myi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8d4763-0c48-4c5d-d44c-08dab0043042
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 05:55:26.2234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QUxis9zAagXTrNAXN8b7MvZRvZVHmI9VlG4l8pOaD92+kAShgQ7M1qCmdQUt+PJmDilGoZLfdy+trc0a3S5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDQvNl0gZHQtYmluZGluZ3M6IHVzYjogY2ktaGRyYy11
c2IyOiBjb252ZXJ0IHRvIERUDQo+IHNjaGVtYSBmb3JtYXQNCj4gDQo+IE9uIDE0LzEwLzIwMjIg
MDU6NTEsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiANCj4gDQo+ID4gKw0KPiA+ICsgIHZidXMt
c3VwcGx5Og0KPiA+ICsgICAgZGVzY3JpcHRpb246IHJlZmVyZW5jZSB0byB0aGUgVkJVUyByZWd1
bGF0b3IuDQo+ID4gKw0KPiA+ICsgIGZzbCx1c2JtaXNjOg0KPiA+ICsgICAgZGVzY3JpcHRpb246
DQo+ID4gKyAgICAgIFBoYW5kbGVyIG9mIG5vbi1jb3JlIHJlZ2lzdGVyIGRldmljZSwgd2l0aCBv
bmUgYXJndW1lbnQgdGhhdA0KPiA+ICsgICAgICBpbmRpY2F0ZSB1c2IgY29udHJvbGxlciBpbmRl
eA0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRs
ZS1hcnJheQ0KPiA+ICsNCj4gPiArICBkaXNhYmxlLW92ZXItY3VycmVudDoNCj4gPiArICAgIGRl
c2NyaXB0aW9uOiBkaXNhYmxlIG92ZXIgY3VycmVudCBkZXRlY3QNCj4gPiArDQo+ID4gKyAgb3Zl
ci1jdXJyZW50LWFjdGl2ZS1sb3c6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogb3ZlciBjdXJyZW50
IHNpZ25hbCBwb2xhcml0eSBpcyBhY3RpdmUgbG93DQo+IA0KPiBUaGlzIGlzIGEgZnJpZW5kbHkg
cmVtaW5kZXIgZHVyaW5nIHRoZSByZXZpZXcgcHJvY2Vzcy4NCj4gDQo+IEl0IHNlZW1zIG15IHBy
ZXZpb3VzIGNvbW1lbnRzIHdlcmUgbm90IGZ1bGx5IGFkZHJlc3NlZC4gTWF5YmUgbXkNCj4gZmVl
ZGJhY2sgZ290IGxvc3QgYmV0d2VlbiB0aGUgcXVvdGVzLCBtYXliZSB5b3UganVzdCBmb3Jnb3Qg
dG8gYXBwbHkgaXQuDQo+IFBsZWFzZSBnbyBiYWNrIHRvIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9u
IGFuZCBlaXRoZXIgaW1wbGVtZW50IGFsbA0KPiByZXF1ZXN0ZWQgY2hhbmdlcyBvciBrZWVwIGRp
c2N1c3NpbmcgdGhlbS4NCg0KSSB0aG91Z2h0IG5vIG5lZWQgdG8gYWRkIHR5cGUgZm9yIGJvb2xl
YW4gcHJvcGVydHkuIENvbXBhcmVkIFYxLCBWMiBoYXMNCm1vcmUgY2hhbmdlcy4gQXMgSSB3cm90
ZSBpbiBjb3Zlci1sZXR0ZXIsIEkgbWF5IG1pc3Mgc29tZSBjb21tZW50cywgc29ycnkNCmZvciB0
aGF0LiBJIHdpbGwgZ28gYmFjayBhbmQgcmUtY2hlY2sgdGhlIFYxIGNvbW1lbnRzLg0KDQpUaGFu
a3MsDQpQZW5nLg0KPiANCj4gVGhhbmsgeW91Lg0KPiANCj4gPiArDQo+ID4gKyAgb3Zlci1jdXJy
ZW50LWFjdGl2ZS1oaWdoOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgT3Zl
ciBjdXJyZW50IHNpZ25hbCBwb2xhcml0eSBpcyBhY3RpdmUgaGlnaC4gSXQncyByZWNvbW1lbmRl
ZCB0bw0KPiA+ICsgICAgICBzcGVjaWZ5IHRoZSBvdmVyIGN1cnJlbnQgcG9sYXJpdHkuDQo+ID4g
Kw0KPiA+ICsgIHBvd2VyLWFjdGl2ZS1oaWdoOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHBvd2Vy
IHNpZ25hbCBwb2xhcml0eSBpcyBhY3RpdmUgaGlnaA0KPiA+ICsNCj4gPiArICBleHRlcm5hbC12
YnVzLWRpdmlkZXI6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogZW5hYmxlcyBvZmYtY2hpcCByZXNp
c3RvciBkaXZpZGVyIGZvciBWYnVzDQo+ID4gKw0KPiA+ICsgIHNhbXN1bmcscGljb3BoeS1wcmUt
ZW1wLWN1cnItY29udHJvbDoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIEhT
IFRyYW5zbWl0dGVyIFByZS1FbXBoYXNpcyBDdXJyZW50IENvbnRyb2wuIFRoaXMgc2lnbmFsIGNv
bnRyb2xzDQo+ID4gKyAgICAgIHRoZSBhbW91bnQgb2YgY3VycmVudCBzb3VyY2VkIHRvIHRoZSBV
U0JfT1RHKl9EUCBhbmQNCj4gVVNCX09URypfRE4NCj4gPiArICAgICAgcGlucyBhZnRlciBhIEot
dG8tSyBvciBLLXRvLUogdHJhbnNpdGlvbi4gVGhlIHJhbmdlIGlzIGZyb20gMHgwIHRvDQo+ID4g
KyAgICAgIDB4MywgdGhlIGRlZmF1bHQgdmFsdWUgaXMgMHgxLiBEZXRhaWxzIGNhbiByZWZlciB0
bw0KPiBUWFBSRUVNUEFNUFRVTkUwDQo+ID4gKyAgICAgIGJpdHMgb2YgVVNCTkNfbl9QSFlfQ0ZH
MS4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQz
Mg0KPiA+ICsgICAgbWluaW11bTogMHgwDQo+ID4gKyAgICBtYXhpbXVtOiAweDMNCj4gPiArDQo+
ID4gKyAgc2Ftc3VuZyxwaWNvcGh5LWRjLXZvbC1sZXZlbC1hZGp1c3Q6DQo+ID4gKyAgICBkZXNj
cmlwdGlvbjogfA0KPiA+ICsgICAgICBIUyBEQyBWb2x0YWdlIExldmVsIEFkanVzdG1lbnQuIEFk
anVzdCB0aGUgaGlnaC1zcGVlZCB0cmFuc21pdHRlcg0KPiBEQw0KPiA+ICsgICAgICBsZXZlbCB2
b2x0YWdlLiBUaGUgcmFuZ2UgaXMgZnJvbSAweDAgdG8gMHhmLCB0aGUgZGVmYXVsdCB2YWx1ZSBp
cw0KPiA+ICsgICAgICAweDMuIERldGFpbHMgY2FuIHJlZmVyIHRvIFRYVlJFRlRVTkUwIGJpdHMg
b2YgVVNCTkNfbl9QSFlfQ0ZHMS4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgbWluaW11bTogMHgwDQo+ID4gKyAgICBtYXhp
bXVtOiAweGYNCj4gPiArDQo+ID4gKyAgdXNiLXBoeToNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBw
aGFuZGxlIGZvciB0aGUgUEhZIGRldmljZS4gVXNlICJwaHlzIiBpbnN0ZWFkLg0KPiA+ICsgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICsgICAg
ZGVwcmVjYXRlZDogdHJ1ZQ0KPiA+ICsNCj4gPiArICBmc2wsdXNicGh5Og0KPiA+ICsgICAgZGVz
Y3JpcHRpb246IHBoYW5kbGUgb2YgdXNiIHBoeSB0aGF0IGNvbm5lY3RzIHRvIHRoZSBwb3J0LiBV
c2UgInBoeXMiDQo+IGluc3RlYWQuDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4gKyAgICBkZXByZWNhdGVkOiB0cnVlDQo+ID4gKw0K
PiA+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4gPiArICAiZXRoZXJuZXRAWzAtOWEtZl0kIjoNCj4g
PiArICAgIGRlc2NyaXB0aW9uOiBUaGUgaGFyZCB3aXJlZCBVU0IgZGV2aWNlcw0KPiA+ICsgICAg
dHlwZTogb2JqZWN0DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy9uZXQvbWljcm9jaGlwLGxhbjk1
eHgueWFtbA0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4g
KyAgLSByZWcNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArDQo+ID4gK2FsbE9mOg0KPiA+ICsg
IC0gJHJlZjogdXNiLWhjZC55YW1sIw0KPiA+ICsgIC0gJHJlZjogdXNiLWRyZC55YW1sIw0KPiA+
ICsgIC0gaWY6DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgbXV4LWNvbnRy
b2xzOg0KPiA+ICsgICAgICAgICAgdHJ1ZQ0KPiA+ICsgICAgdGhlbjoNCj4gPiArICAgICAgcHJv
cGVydGllczoNCj4gPiArICAgICAgICBtdXgtY29udHJvbC1uYW1lczoNCj4gPiArICAgICAgICAg
IGNvbnN0OiB1c2Jfc3dpdGNoDQo+IA0KPiBUaGlzIGlzIGEgZnJpZW5kbHkgcmVtaW5kZXIgZHVy
aW5nIHRoZSByZXZpZXcgcHJvY2Vzcy4NCj4gDQo+IEl0IHNlZW1zIG15IHByZXZpb3VzIGNvbW1l
bnRzIHdlcmUgbm90IGZ1bGx5IGFkZHJlc3NlZC4gTWF5YmUgbXkNCj4gZmVlZGJhY2sgZ290IGxv
c3QgYmV0d2VlbiB0aGUgcXVvdGVzLCBtYXliZSB5b3UganVzdCBmb3Jnb3QgdG8gYXBwbHkgaXQu
DQo+IFBsZWFzZSBnbyBiYWNrIHRvIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uIGFuZCBlaXRoZXIg
aW1wbGVtZW50IGFsbA0KPiByZXF1ZXN0ZWQgY2hhbmdlcyBvciBrZWVwIGRpc2N1c3NpbmcgdGhl
bS4NCj4gDQo+IFRoYW5rIHlvdS4NCj4gDQo+IA0KPiBBZGRpdGlvbmFsbHk6IEJsYW5rIGxpbmUN
Cj4gDQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBw
aHlfdHlwZToNCj4gPiArICAgICAgICAgIGNvbnN0OiBoc2ljDQo+ID4gKw0KPiA+ICsgICAgICBy
ZXF1aXJlZDoNCj4gPiArICAgICAgICAtIHBoeV90eXBlPiArICAgIHRoZW46DQo+ID4gKyAgICAg
IHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgcGluY3RybC1uYW1lczoNCj4gPiArICAgICAgICAg
IGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBpZGxlDQo+ID4gKyAgICAgICAgICAg
IC0gY29uc3Q6IGFjdGl2ZQ0KPiA+ICsgICAgZWxzZToNCj4gPiArICAgICAgcHJvcGVydGllczoN
Cj4gPiArICAgICAgICBwaW5jdHJsLW5hbWVzOg0KPiA+ICsgICAgICAgICAgb25lT2Y6DQo+ID4g
KyAgICAgICAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAgICAgICAtIGNvbnN0OiBkZWZh
dWx0DQo+ID4gKyAgICAgICAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgLSBob3N0DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgLSBkZXZpY2UNCj4gPiArICAgICAg
ICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgICAgICAgIC0gY29uc3Q6IGRlZmF1bHQNCj4g
DQo+IE5vLCBqdXN0IG1pbkl0ZW1zOiAxDQo+IA0KPiBBZGRpdGlvbmFsbHk6IGJsYW5rIGxpbmUN
Cj4gDQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBj
b21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgICAgIGVu
dW06DQo+ID4gKyAgICAgICAgICAgICAgLSBjaGlwaWRlYSx1c2IyDQo+ID4gKyAgICAgICAgICAg
ICAgLSBsc2ksemV2aW8tdXNiDQo+ID4gKyAgICAgICAgICAgICAgLSBudmlkaWEsdGVncmEyMC11
ZGMNCj4gPiArICAgICAgICAgICAgICAtIG52aWRpYSx0ZWdyYTMwLXVkYw0KPiA+ICsgICAgICAg
ICAgICAgIC0gbnZpZGlhLHRlZ3JhMTE0LXVkYw0KPiA+ICsgICAgICAgICAgICAgIC0gbnZpZGlh
LHRlZ3JhMTI0LXVkYw0KPiA+ICsgICAgICAgICAgICAgIC0gcWNvbSxjaS1oZHJjDQo+ID4gKyAg
ICAgICAgICAgICAgLSB4bG54LHp5bnEtdXNiLTIuMjBhDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsg
ICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGZzbCx1c2JtaXNjOiBmYWxzZQ0KPiA+ICsg
ICAgICAgIGRpc2FibGUtb3Zlci1jdXJyZW50OiBmYWxzZQ0KPiA+ICsgICAgICAgIG92ZXItY3Vy
cmVudC1hY3RpdmUtbG93OiBmYWxzZQ0KPiA+ICsgICAgICAgIG92ZXItY3VycmVudC1hY3RpdmUt
aGlnaDogZmFsc2UNCj4gPiArICAgICAgICBwb3dlci1hY3RpdmUtaGlnaDogZmFsc2UNCj4gPiAr
ICAgICAgICBleHRlcm5hbC12YnVzLWRpdmlkZXI6IGZhbHNlDQo+ID4gKyAgICAgICAgc2Ftc3Vu
ZyxwaWNvcGh5LXByZS1lbXAtY3Vyci1jb250cm9sOiBmYWxzZQ0KPiA+ICsgICAgICAgIHNhbXN1
bmcscGljb3BoeS1kYy12b2wtbGV2ZWwtYWRqdXN0OiBmYWxzZQ0KPiA+ICsNCj4gDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
