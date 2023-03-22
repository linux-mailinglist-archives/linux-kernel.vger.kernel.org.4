Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D376C58DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCVVhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCVVgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:36:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6813D5B;
        Wed, 22 Mar 2023 14:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sbm58a4C6aWASgASsNYLqQmbnQGRIzipWGUM9nnQ2o+cK2WKBtxFdgksBSGJh2mTnT7nEKDBBe+y5G2cYuYyNFYEdY+XcxpCvwp7DK/vPsYmFuO0aS+XqmBRySqoS7KT97IB/TCvxDYO/abuj/m3hcF7Wif16Qdd0JctCaiBYm9YzC4TvQvmjgSGmAwkp74h0z04jCJVKcyufOZ5AYWFB58vTrxibT8um3nnBVIUHKWLFCszH4g8SmlPrck2HoBsC30fEgpzjLcfJiil/m10d5t99FX+WksYLp8C7uI4BF1xz94AtpdrILrIkHlNyuQi0FXEzhYu/P6sz2RjJdg1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oguo2bYD43giRI2k/1N70CIRB8K9z72D3pp6TqFbQY4=;
 b=AtPhKSp42oRpmDcSy7wyuB7pRDxgYl3a5hFc42D5Hn4u/dDX65Ijo2Z8FYsa648BMch0o+hn0/K0G0tuIAhEg1QVIrF04LXL4AYzgfDeQ1IDgPsod/OuE6iaBpKabv4O2q/hFwgePJbC1FadITJgbTq2CUgBpa2C4cvJJe9gg8n1PM8AlVpBwypVk7S/DmKigStnx1ivkd4vaat7iMq63RRKUBdIClZqqw4Okp5aXUJgV73rcLOBUWEA0xgiVxx9vCLhGEBlQXNRm89divwgICSjUOmwQOR+17hRVzUWj2b0gTqkDEnYmD31L/DcTDBO28cl8IkQ0eCBS3BHXLSkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oguo2bYD43giRI2k/1N70CIRB8K9z72D3pp6TqFbQY4=;
 b=MtZMKyGQ+p4TDiu61YdKSphYkEiBcJLtQbgyjBliUPs/Hq/RTPip2zZBPMLPP4u990OXNTpR0K1anZLt6uLsB4HKbhkVcj1eV+TPSHuaiiAvf84s6d5j+a0GX1n0Zhq2Iv5rMkbuOSxFfaiInvK3vvRcsqrCijwsNYBfIl4942A=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9277.eurprd04.prod.outlook.com (2603:10a6:102:2b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 21:36:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 21:36:48 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZXAih0MCX1q8KWEWxpTpi/nrVFq8GaNGAgAByipCAAHgTAIAAAD6A
Date:   Wed, 22 Mar 2023 21:36:48 +0000
Message-ID: <AM6PR04MB483841E17BEEE4F9EC596DBA88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
 <20230321151951.2784286-2-Frank.Li@nxp.com>
 <1ce3bf91-6bef-b4c1-1ec9-3a345518efeb@linaro.org>
 <AM6PR04MB483828FC1083E3C98930DF6488869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b5d67af0-ed08-e243-2c0c-92f1f002e552@linaro.org>
In-Reply-To: <b5d67af0-ed08-e243-2c0c-92f1f002e552@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB9277:EE_
x-ms-office365-filtering-correlation-id: fc4058c0-4c28-4db2-3d1f-08db2b1d8afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RnkS3ceSLrCloyQQlRyreIhpf9jvlIRK2IT9dkknJ9DLe5rNOhfqcNVabI5GEKGtSRUrt0H8w4dbbJpVDvwMFRRM0sBqVV5nMCaxG7l46FxM252TRkdcNO8gBpMTQj0WD+rQ0D9wsZqXBF9xgZi1ZuGoSSgvCiAIbubteuZADkOerC2OHwf+mCO8MsWl+0mgIky43FlehQiBdFeNQD9VFLgP8s9oqiyZjupBKkGl0qYqOW+QNbuoHJABeye8l6muot1VE5fg5OO95XfWyZYFs3iiZpdrZuOqQKsSpQDPx7gWsUoWo4EryQWM08F+PxncFYz0xvwxwbT8AB+o7EWkXfGK6l6r5cSTliada9V6qiX+7wlBFY0uAkjDwYitO1EsX/s5HqaTX7WTlZ270TQfLqA9wuLtillcgkS84iO2ZJ+DVcJXqu19ftJoWbW8XeeqmsCAsuainUTZ5jO65IL5R7iVvne+U4kFlJMTwHk/GdWsA4XbnraILhu8tAuxOxYwMJjj4x460EDB71lMDTLqGlNknHid6biXNR3gGfqs17AvUj/d2qXkGqR//NqYAfdbgRpM4YyQXIKHQS++EZ3An5bvl0h7GxAlSkTCEBJQC6DaPeMh2qWmahpjW5Z72CUEGrg2nih21y2xsz73APQ4f5KfF/UF0tCRDS8wYPH7niO/f7Zn8Q65XAkG8FjXoxG8yWzyqe4Mdme7uLs81tIymsoiv+kJFNpdn9ppdlbMqZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199018)(8936002)(5660300002)(26005)(6506007)(52536014)(55236004)(53546011)(66446008)(478600001)(38070700005)(41300700001)(66946007)(55016003)(8676002)(66556008)(76116006)(64756008)(6916009)(66476007)(4326008)(7696005)(33656002)(83380400001)(71200400001)(186003)(122000001)(54906003)(38100700002)(44832011)(9686003)(316002)(2906002)(86362001)(7416002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zys5SkVEaWcvNGw4ZkxiT0ZhQ3NYZ1VSSkQ3Zm0xT3RqL0pkR0RZY2ZuUGR4?=
 =?utf-8?B?Z2ZOVXFZMUZoS1dvMzlUK0piOXhuMVhiNWtvd090dlJNUWttVndLZ2RjYlZL?=
 =?utf-8?B?QnduR0pDK1pxRlAxOEY4NnltaVMyTE1pUEl5ejZNODZQZ0ovY2JTUzNhNHBn?=
 =?utf-8?B?VzVIeHhxOW9nKzYwb3BhSnJEOG13STUyTXg3MzFkdWZOd29Ba2ZWOXozYkkz?=
 =?utf-8?B?clhQbkh6V2U4cXdiZUtmbEZHdWNlcnp4UWpldTV3N2VqSlhiRTFCdUZGazdN?=
 =?utf-8?B?M3Fub281ZHFqU2hzUTZuQ1p2NmMyQnlkMm5hRzFWMEJEdTY3VE5FOFVnaStL?=
 =?utf-8?B?czV2ZDJUNDNLN1RkTlFpSHI3emNPdFQ4L3lVY2w1amFUK0loNlRtYjgwangv?=
 =?utf-8?B?RmVuWnRiWCsxaWVxUnBPMllFblkvT1IxNktqNXNRYmpCYlNFM2VPMlFiWmNj?=
 =?utf-8?B?Z3oxR3RIbDRGRllNalpvNzhBRHkwOUF0MEF5bmJsQWdxQ2xBUlJ3OE91cXJD?=
 =?utf-8?B?ZVFwd2VsVUZRZ2djb0xLcVgzcnhSbHNVM3dyeE9EOWFjVWRxajcxWE9ReGVM?=
 =?utf-8?B?WW9lMTNUdmxVdFptbWgrQnpOcGI2S0lXSW4yNnpham05dk83eUhMUXE3UXRp?=
 =?utf-8?B?M2RvNkZtUFk1alhXT3RKa1pZV2gvcnhhT1Exc2N5dzVqbHVodU53c3IrUVlC?=
 =?utf-8?B?NzF2eTdoVk8renpDVXlIS2FKYzIyZndMT1dPVGUvaWd6NWVheDFDdlQ4OVNs?=
 =?utf-8?B?RHpnRTRHM1ZmdVYzYVovOGdTemJCUlIvYXFObGNick1TUURhVDBMdHIxUmp3?=
 =?utf-8?B?clRSYk43RmVWUHVPOFZ2eTdzanp0VXhSSmcrWW1oUmdJTWNpQmdsTno0TFhU?=
 =?utf-8?B?a0dlQXdWc2o4TTdWczZBVjYzcW1iTytJMnp5ZFRzWUcvMU5ueGc3Q1VTd1pN?=
 =?utf-8?B?d0drQklESjVtTWFWVmlhcE9QU0k5NVlsU0twdjl3TUZ0Q3VnWWFGZTdHSzda?=
 =?utf-8?B?NjE5TU5WamovekNHelZiSnNvWnR3VWdLRU42ZmNqaFhrZlNacUxDTGhORFp1?=
 =?utf-8?B?MCtPbkc0bnpQdG80ZXg5ZUlEQk81TmJyd2F4SDhHSGpOMDIyUmtTUG5LeE9E?=
 =?utf-8?B?bERhZHJGUWpkK0FGM05na3FhcnIzQW1HRzcwaEdQanF3SFJrSzBGSmlYdWtk?=
 =?utf-8?B?ZzdXRTZ3MmdpeE9FQ2YyM1pZMlkyVlNPei9SZ3l4MEpZejIzRXFrdFhpNDdr?=
 =?utf-8?B?REJURjJ4ck5lTWZWaUw0eURqU3FpZU53NDZHeHBuYWZoL0Jpc1lPL1lIVXo2?=
 =?utf-8?B?TVJiK0N4Z0JQYXpMU0JWZkhKZ0VRU1dTRWcwQXZOT0t4M0R2dnU2amhReFhx?=
 =?utf-8?B?Y3JDY0xuNVNqekdjWmk4YllSWjF4REl1aXUvdjBsTG9MTE1wbm5rVjExZzdl?=
 =?utf-8?B?YlVBUllxWFY4a1RDZm9TNFdQdHUxNm0zL0ZzRzlQa0pUdDgyZ2ExNmM5SFln?=
 =?utf-8?B?cEVNaDBycmFBeXFoVlJ5L3pRaUcrUXhwb0UvUEt3V0g4SlZJd1R1OG1IM3Fn?=
 =?utf-8?B?bDlLK0krTzZSQ2NFQnV4V3R2Si9VYStLQ1QvK3JOR0thTnBBcE9ycGtKZFQ2?=
 =?utf-8?B?L090ZGpSM3JObFppRWx1WjRPbm9BeGtqdUFyZDlRM1RlcTQxcXpORjlIeUp6?=
 =?utf-8?B?MFpWc2ZwZ2laWkpoV21yYXowWUNRektXZE1ndHkxclR5NWlpZ3NwVEdXWkVR?=
 =?utf-8?B?L3lUMmp6OStRUWk0UFRlZ1RNMjdhZXdGb09oT0s0b1RtdzBGbU5QOHZtQW9Q?=
 =?utf-8?B?K2wrbjhyb0NGSUlFeXZUbzJNZ3M2aUhYeE9aNW5yWTRHUXJQakFaWkgwK05p?=
 =?utf-8?B?TDFlT3ZtWUdRQnB1R3pvT2laQ21tN01MdjNDL0pJWU9FNkpmTHhMYzYwTWFC?=
 =?utf-8?B?cGlVMUtKcmQ3NFN4Y3VJc0IzL3RCMk5FdDFVcFZXZVBjc2p1R2ozMVY3aGd2?=
 =?utf-8?B?UWsrQzF0M2ZhVGZGS01lZjYyWmIwOHhaaXZtSTVoNlhqb2xRTGlTVzhpMUx0?=
 =?utf-8?B?MjJTTTQ5bHpHNVRwNXpockg3WHpUQVNWekFVVUhrSS9QMnY1MDlxVk81Y0ky?=
 =?utf-8?Q?HxJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4058c0-4c28-4db2-3d1f-08db2b1d8afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 21:36:48.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiwAvrFRFaxeViZZg+FTpyDdPtcxMvnSybneOmzef0qfQyhdJ19+ZiKMH7yV8Fw7Ew4uDpTKqT3u/t8QeukdvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9277
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE1hcmNoIDIyLCAyMDIzIDQ6MzIgUE0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
Pg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGZlc3RldmFtQGdtYWlsLmNvbTsg
aW14QGxpc3RzLmxpbnV4LmRldjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTog
W1BBVENIIHYzIDEvM10gZHQtYmluZGluZ3M6IHVzYjogY2Rucy1pbXg4cW06IGFkZA0KPiBpbXg4
cW0gY2RuczMgZ2x1ZSBiaW5kaW5ncw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBP
biAyMi8wMy8yMDIzIDE1OjM0LCBGcmFuayBMaSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAyMiwgMjAyMyAyOjMyIEFNDQo+ID4+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLg0KPiA+
Pj4gKyAgICAgIC0gY29uc3Q6IHVzYjNfYWNsaw0KPiA+Pj4gKyAgICAgIC0gY29uc3Q6IHVzYjNf
aXBnX2Nsaw0KPiA+Pj4gKyAgICAgIC0gY29uc3Q6IHVzYjNfY29yZV9wY2xrDQo+ID4+PiArDQo+
ID4+PiArICBhc3NpZ25lZC1jbG9ja3M6DQo+ID4+PiArICAgIGl0ZW1zOg0KPiA+Pj4gKyAgICAg
IC0gZGVzY3JpcHRpb246IFBoYW5kbGUgYW5kIGNsb2NrIHNwZWNpZm9lciBvZg0KPiA+PiBJTVhf
U0NfUE1fQ0xLX01TVF9CVVMuDQo+ID4+DQo+ID4+IERyb3AgdXNlbGVzcyBwaWVjZXMgc28gIlBo
YW5kbGUgYW5kIGNsb2NrIHNwZWNpZm9lciBvZiAiIGFuZCBuYW1lIHRoZQ0KPiA+PiBoYXJkd2Fy
ZSwgbm90IHRoZSBzeW50YXguDQo+ID4+DQo+ID4+PiArDQo+ID4+PiArICBhc3NpZ25lZC1jbG9j
ay1yYXRlczoNCj4gPj4+ICsgICAgaXRlbXM6DQo+ID4+PiArICAgICAgLSBkZXNjcmlwdGlvbjog
U2hvdWxkIGJlIGluIFJhbmdlIDEwMCAtIDYwMCBNaHouDQo+ID4+DQo+ID4+IFRoYXQncyBiZXR0
ZXIgYnV0IEkgc3RpbGwgZG8gbm90IHVuZGVyc3RhbmQgd2h5IGRvIHlvdSBuZWVkIGl0IGluIHRo
ZQ0KPiA+PiBiaW5kaW5ncy4gWW91IG5ldmVyIGFjdHVhbGx5IGFuc3dlcmVkIHRoaXMgcXVlc3Rp
b24uDQo+ID4NCj4gPiBJIGFtIG5vdCBzdXJlIDEwMCUgc3VyZSB0aGUgcmVhc29uLg0KPiA+IEkg
dGhpbmsgZGlmZmVyZW5jZSBzeXN0ZW0gdGFyZ2V0J3MgIGF4aSBidXMgZnJlcXVlbmN5IGlzIGRp
ZmZlcmVuY2UsDQo+ID4gQW5kIGp1c3Qgb25lIHRpbWUgd29yaywgbmVlZG4ndCBzb2Z0d2FyZSB0
byBtYW5hZ2UgaXQuDQo+ID4gRm9sbG93aW5nIG90aGVyIGRyaXZlcidzIGNvZGUgc3R5bGUgbWF5
IGJlIGFub3RoZXIgcmVhc29uLg0KPiANCj4gVGhhdCdzIHRoZSByZWFzb24gb2YgaGVhdmluZyBp
dCBpbiBEVFMuIEJ1dCBJIGFtIGFza2luZyBhYm91dCBiaW5kaW5ncy4NCj4gWW91IGRvIHVuZGVy
c3RhbmQgeW91IGRlZmluZSBoZXJlIGludGVyZmFjZT8NCg0KSSBkZWZpbmVkIGhlcmUgaXMgZGVz
Y3JpcHQgQVhJIGZyZXF1ZW5jeSBmb3IgdXNiIGNvbnRyb2xsZXIuIFN1cHBvc2VkIGRpZmZlcmVu
Y2UNClBsYXRmb3JtIHdpbGwgaGF2ZSBkaWZmZXJlbmNlIHdvcmtpbmcgZnJlcXVlbmN5LiAgDQoN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
