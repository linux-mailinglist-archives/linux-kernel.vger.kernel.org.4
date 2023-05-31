Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB42717D49
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjEaKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEaKlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:41:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC1123;
        Wed, 31 May 2023 03:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJaUm5J+xwr4QIW2QHSXVPdee3AXP3juJHNPopYPGh9FOINODcnl8doyJhMAl/mEpJrX8Y+lpeSxebDrPlkSRxQcrRrL9lYAaVsV9dufoUSsUHAfOsBvZvhAPKpYE9lkcqB2fujBRE9hTR4VjuixAYpgqSWgI4qxHxpjGz8x4vS2i9pviuK0gayHB//hQjx2Nzb44oHHttN6j4QnYni28ILngMlFMJLg4jj05WPK5LNZRzTCcAMm5rydEf2DqfMtQBAkLQadMt9p0TPORWZPs1Ih6NHL4fcKF8trVubE9gGPbY0eaQ+LlmBVfA0qHQ2kie+Q57g5O4KN8IJOC1wucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjiYugdAhp8EnKd/O4ifUGZIcudHvxPYXm4eIQ2KfmE=;
 b=LH2Q+3kCeuJLncR15w2WPbXF3tBi/dp7eheei68m6PjElZnzcVMyRKUAKWq8MvPj5o+GuU0VwvVt4XAdA9dyVBrpwvWtWw4Ahe0XAUAzRfNqR9yLKBt3u2fAE3ZVXo0pb1tM0oJ/9jWehhARa1z4Ke7T3dWQdvzl7cKYjIVmg4MuHaPzPNousZZleZ8s2etoW9hBRzIz0GzBrQBbuFBUNL9spe3k5cghPOhCZ2nieJSDO6qpCzE5iKlLBLnX5JLr2eQ2ecGM0XEJwaSVMIyQexFkuYAO0TZvPAm9Imiq75w+iCfrfr3uF5Gkf6213OEyg89vIuvsVcl5ondbzayZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjiYugdAhp8EnKd/O4ifUGZIcudHvxPYXm4eIQ2KfmE=;
 b=CeSgGoU61IU+aRPJQHldBzvXcTTAh4qN956bYJyTleiYU3kjpCnoYAq9pB7Itt6KzHCTlpaOZgcdms8sAvwUjkrSGqGSs+vTORhSy4ZcYY+J2W0YAlGVwr/igDhJ4j4c7ed+LFLCDZj1s2C7CP4blbbVdvR5zdbvWbAI69hzvO4=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DB9PR04MB9553.eurprd04.prod.outlook.com (2603:10a6:10:2ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 10:41:01 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c%5]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 10:41:01 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add
 pca9451a support
Thread-Topic: [EXT] Re: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add
 pca9451a support
Thread-Index: AQHZk4yOFzh1S8pCcU2cJ06GozpCXq9z8twAgAAHboCAAB5uAIAAF8/w
Date:   Wed, 31 May 2023 10:41:01 +0000
Message-ID: <AM6PR04MB5925ABC6199D2D17D17CFAFAE1489@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <20230531065724.3671795-2-joy.zou@nxp.com>
 <f343458e-519c-1e5c-e48f-acfed2c00ad7@linaro.org>
 <25e6d735-f191-68a1-84cc-d7e1ae4c3217@kontron.de>
 <0de8cecf-ec36-9300-656b-2c073f60c407@linaro.org>
In-Reply-To: <0de8cecf-ec36-9300-656b-2c073f60c407@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|DB9PR04MB9553:EE_
x-ms-office365-filtering-correlation-id: 4bf1f9d3-d432-45eb-ebbe-08db61c38702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MayeDjx4GEDlzNtRyvlOO7oRoWoqKot0I77vI1GZgc0LmzoXpPzOdBnaK7UdoT1cxOrfWWopym//Bh4UDQwY3Cyb/Rn3isDUS5y7qYpy6zSag/8r38wqkhX++Y2UZ5imNPhLqdYK65k0y3+EeLw21DdGtf7HVNIV/f7f1feoP4BHG9I/CMUQJQUBcPGpFM37242LvgMMJo7T7E3RICgfM/lyFGX7xHQwHWf2eYJz1BlTA7GiQjPRZOIs/+UEqgrqkwYOYmG1hrNUlVJDodnpuMTIUzYMZIyVHrMQEzAuo4MSSD9q3LIDivOSuDv4XKDosxy6xEcL3OvLiHBHRXfpU7tDVFxDHT7UaXfq4uQyII1F1p6X2oTxixDcvEW+TrOTYieUO+T76rvxNEocJzptRA3GrpTjsugzWywokwG3A9ULVpqh+o07iZ08X4CB75Q8MSp2C4nE7vfNUoCWKSr0OTi7VQ/zL0vVPfE+PeO/WAWi01gMs1w4LI4vsH250QgczX+dbnH1/+n0VcWI6JMAOwNCUCTBKocnDyvGYZcSxN9UJT1QPwrVHGa+PdNSbE9NUpMebpkN0gjQeEZ4Hv39/sy27PiIN17J8jnOT+QPDD7KPQYN6FK+u98fegqBPbYMLgmmSU7yRCM53mULeZ2d0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(53546011)(38100700002)(186003)(9686003)(6506007)(41300700001)(83380400001)(7696005)(478600001)(71200400001)(110136005)(66899021)(54906003)(66946007)(4326008)(66556008)(66476007)(76116006)(64756008)(316002)(921005)(55016003)(122000001)(8936002)(52536014)(7416002)(66446008)(5660300002)(8676002)(44832011)(86362001)(38070700005)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M21MeEJtTUNsVUFmSzVKK1hqQnAwUWVFUy9lUS9oV1VSd3UyeWlrTU4wK3px?=
 =?utf-8?B?bzNkNksyUzRRN1R4SnRwbVU4NCtmUDRyRjAxWkFPS3oyS1dHT3VMZWRiV1Rp?=
 =?utf-8?B?R2QzZ0VNMWl5WVZjWDRCM2FyNXA3TUJ3c2lESXZPM2lUOXBseFE2SEhUa1kx?=
 =?utf-8?B?SGhvTUVweTZxNnRwZGc0aFRBS3dyZmN6UnpjWnJBYkhYN3NVa0RCbE9sVzVD?=
 =?utf-8?B?TUVoTExpOUw3TkRPNHpGeDgrSjh1NzM5R2JzdHhzSEU0ajVsV0tLMXRHQ0JJ?=
 =?utf-8?B?bndEbUt4U3h1NmtSZFZnL1djVEd1OG51cE1hV1M2bEhGT1N0VGZteFZaOWo4?=
 =?utf-8?B?M2Q1bEFleHNoSkZwVm1sNVYvbEV0YjVOM1ZubEFFTnpVRWdHUzJDcWJ4RFJT?=
 =?utf-8?B?MzZON3RhYVBkdGFqUVFlcnlHM1ZNUHNLbjVQVEtuTDJuWkpudGxJSXVCa0JO?=
 =?utf-8?B?K1lYbC9WQklCU3hKc1hTczExdngwa0dkN3dlV0Z4c0t5VE5aMUJkRllTNUg3?=
 =?utf-8?B?bEZGRnpSNk5VUzExeG8xbFVRZU5ZWE1iVFc3RE8xSlVzb1BLNlpnQXJwbCt3?=
 =?utf-8?B?VTczYXYyaWlzSVd6SDlpakNkbUloZzNvN1lCMXRnUlNoTjc0UlF0c1VwbXhv?=
 =?utf-8?B?M00yZGorVlBsSGNLdXZTUCtHQk9HT09zeFQxSTM1MGU5eFh2NlRXeW5uSUNh?=
 =?utf-8?B?eVJpb210Znl2UFNZYVl1MHl6T2lnazdWTG51eVMzZHF1Q0FsTDNzWkNsVVpB?=
 =?utf-8?B?L01wOEZpWjY3VEFZcGFsZ29UTGhkVFlTeWthZjZDRy8zaFVXbHJ6VFY0Ky9i?=
 =?utf-8?B?aFVuMGhHZXZ6MlgxMTVyak4wWXE0VldRL2F2TU9WYzRJanNYSkNQd01FczVs?=
 =?utf-8?B?TEpBdmpRUkt2clhqcWI2TkxWai9MNmVYVE9CK2tubzYxSnVjWldMd2N3Y0M4?=
 =?utf-8?B?a2d4ZkRFcGl2R1RYaEFEajd6MGwwNWNlZjU0Ui9pVkwrcXpHeENZZmt4VVR5?=
 =?utf-8?B?czk5M0p0cUdJUnVRZk5ZOGVvYXNUSHhSbTBBcmRvdWJoNEY5SlZrUjBkWEVS?=
 =?utf-8?B?TGc2U1RGVUNXZnpZMkRoOW4wSGZ3L3NzcStBVUc3eXBkclc5SjRKK2xyZXlK?=
 =?utf-8?B?Y3NXRW1wOG1nQnFXOTltV1dGZHJsYTVlOGpsV3EwSm9ITmc2UDBOalE0QVRz?=
 =?utf-8?B?bEtPbmd6OUhqZXZBL09UeUk4QW9Ha3FOd090V0RxWkdBWGRwU1B2UU1xNHRT?=
 =?utf-8?B?Y1IyWVB5SmN5ZERoMGZMNGptUXJRTkI4bmxZQ2NRQ0JLdk5GWUhtc1ZMUUpi?=
 =?utf-8?B?WEZBMjRJelUyM2ZTWE1memVPWXIzb0lUZUdLQlBuNDRONDFtN0JlbWtaU21X?=
 =?utf-8?B?R0UwU29CY2t1TW82S0VISC9sN2E3WTNTZElzSkkvdHBlL3NSTnpFYzd2WFZM?=
 =?utf-8?B?WGd3bkVLemszQkRmaGtYV21teU0yUGZKN1ltYVpKU3U4TFd0NExyNHkwUVVP?=
 =?utf-8?B?Mnc0eHIweXZNbDNNaC9qc2JteVNOaGt1L0hEd2srUHdjYnFqQXVWTDRmY0hm?=
 =?utf-8?B?TlYzNU8wTG5VRnhMdm5hUytRcWszNldUWFY4bm9hYkxidUNMYzUwekhVTUVw?=
 =?utf-8?B?aVV0ZXFVdkNrLzBmUENIc2VLcUlNd2FHYnpMTHYyYWV3VitpNWZyQzVSalF2?=
 =?utf-8?B?ajBwbUN4R2ZTcHNWRStVcnExZXZtSnZxYmgyNElrU0FIcXVlUTdYbnMyQldP?=
 =?utf-8?B?eXZxOXp0Tjl6THRIWFVpK3Vpb1RrK0kyY3NneVpOUjFkVlNtTjhablQ2UGpX?=
 =?utf-8?B?OTN0TDMrdTFVWVNxcThoV3BMTnAzdkZ5WEdwUHozWURUZ2J6T0Zwa0k5Nm1q?=
 =?utf-8?B?eUFjekppclFVSFZveGhHaEV4K3IrdU1kdmxYMmVpTXd0eG85ckUvbUVTc0Ri?=
 =?utf-8?B?Y2xIc1p3OFMwNjl6Nk9KaEgzVE9sTzVuOHdkYkt3aE1PQkRNMWpndVhwVjRR?=
 =?utf-8?B?SFpGbUV1MnlrYzNyZjAyOEJ0Q3JFeWJoQ3FkTFlVbEFrazBzMUxKS0dBMk5s?=
 =?utf-8?B?SC9TdWZLZ1FRZXNjMVdoN0tjbUlOS2p0cjloUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf1f9d3-d432-45eb-ebbe-08db61c38702
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 10:41:01.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yetMKcA3SQjPNnumEtLpfsz7qUCstoYksGZLnq/FvBj2F25ZW2cs7WVZ2Mcd8jFj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyM+W5tDXmnIgz
MeaXpSAxNzoxMg0KPiBUbzogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250
cm9uLmRlPjsgSm95IFpvdQ0KPiA8am95LnpvdUBueHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJh
aUBueHAuY29tPjsgbGdpcmR3b29kQGdtYWlsLmNvbTsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBy
b2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4g
Y29ub3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRy
b25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjEgMS8z
XSBkdC1iaW5kaW5nczogcmVndWxhdG9yOiBwY2E5NDUwOiBhZGQNCj4gcGNhOTQ1MWEgc3VwcG9y
dA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2Ug
Y2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4g
aW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVt
YWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiAzMS8wNS8yMDIzIDA5OjIyLCBGcmllZGVyIFNjaHJl
bXBmIHdyb3RlOg0KPiA+IE9uIDMxLjA1LjIzIDA4OjU2LCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiA+PiBPbiAzMS8wNS8yMDIzIDA4OjU3LCBKb3kgWm91IHdyb3RlOg0KPiA+Pj4gVXBk
YXRlIHBjYTk0NTAgYmluZGluZ3MuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSm95IFpv
dSA8am95LnpvdUBueHAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+DQo+ID4+IFN1YmplY3QgcHJlZml4
IGlzOiByZWd1bGF0b3I6IGR0LWJpbmRpbmdzOiBwY2E5NDUwOg0KPiA+DQo+ID4gSXMgdGhlcmUg
c29tZSB3YXkgdG8gaGF2ZSB0aGlzIGNvbnNpc3RlbnQgZm9yIGFsbCBzdWJzeXN0ZW1zPyBNb3N0
DQo+ID4gc3Vic3lzdGVtcyBzZWVtIHRvIHVzZToNCj4gPg0KPiA+ICAgZHQtYmluZGluZ3M6IFtz
dWJzeXN0ZW1dOg0KPiA+DQo+ID4gQnV0IHNvbWUgdXNlOg0KPiA+DQo+ID4gICBbc3Vic3lzdGVt
XTogZHQtYmluZGluZ3M6DQo+ID4NCj4gPiBDYXN1YWwgY29udHJpYnV0b3JzIChsaWtlIG1lKSB3
aWxsIHZlcnkgb2Z0ZW4gZ2V0IGl0IHdyb25nIG9uIHRoZQ0KPiA+IGZpcnN0IHRyeS4gRXhhbWlu
aW5nIHRoZSBoaXN0b3J5IGlzIGV4dHJhIGVmZm9ydCB0aGF0IGNvdWxkIGJlIGF2b2lkZWQNCj4g
PiBhbmQgb2Z0ZW4gZG9lc24ndCBwcm92aWRlIGEgZGVmaW5pdGUgaGludCBhcyB5b3UgZmluZCBi
b3RoIHZhcmlhdGlvbnMNCj4gPiBpbiB0aGUgcGFzdC4NCj4gPg0KPiA+IENhbiB3ZSBzdGFuZGFy
ZGl6ZSB0aGlzIGFuZCBtYWtlIGNoZWNrcGF0Y2ggdmFsaWRhdGUgdGhlIHN1YmplY3QgbGluZT8N
Cj4gDQo+IEkgdW5kZXJzdGFuZCB5b3VyIHBhaW4uIDopDQo+IA0KPiBNeSBleHBlY3RhdGlvbiBp
cyBqdXN0IHRvIGhhdmUgImR0LWJpbmRpbmdzOiIgcHJlZml4LiBJdCBjYW4gYmUgYW55d2hlcmUN
Cj4gLSBmaXJzdCBvciBzZWNvbmQsIGRvZXNuJ3QgbWF0dGVyIHRvIG1lLg0KPiANCj4gVGhlbiB0
aGVyZSBpcyB0aGUgZ2VuZXJpYyBydWxlIHRoYXQgc3Vic3lzdGVtIHByZWZpeCBzaG91bGQgYmUg
dGhlIGZpcnN0IGFuZA0KPiBoZXJlIHRoZXJlIGlzIGEgZGlzYWdyZWVtZW50IGJldHdlZW4gc29t
ZSBmb2xrcy4gTW9zdCBtYWludGFpbmVycyBlaXRoZXINCj4gZG9uJ3QgY2FyZSBvciBhc3N1bWUg
YmluZGluZ3MgYXJlIHNlcGFyYXRlIHN1YnN5c3RlbS4gTWFyayAoc3BpLCBBU29DLA0KPiByZWd1
bGF0b3IpIGFuZCBtZWRpYS1mb2xrcyBzYXkgaXQgaXMgbm90IHNlcGFyYXRlIHN1YnN5c3RlbSAo
cmVhbCBzdWJzeXN0ZW0gYXJlDQo+IHNwaSwgcmVndWxhdG9yIGV0YyksIHRodXMgdGhleSB3YW50
IHRoZWlyIHN1YnN5c3RlbSBuYW1lIGFzIHRoZSBmaXJzdCBwcmVmaXguIEl0DQo+IHNvdW5kcyBy
ZWFzb25hYmxlLiBBbnl3YXkgaXQgZG9lcyBub3QgY29udHJhZGljdCBEVCBiaW5kaW5ncyBtYWlu
dGFpbmVycw0KPiBleHBlY3RhdGlvbiB0byBoYXZlIHNvbWV3aGVyZSAiZHQtYmluZGluZ3M6IiBw
cmVmaXguDQo+IA0KPiBNeSBjb21tZW50IHdhcyBvbmx5IHRvIGhlbHAgeW91IGFuZCB0aGVyZSBp
cyBubyBuZWVkIHRvIHJlc2VuZC4gSSB0aGluaw0KPiBNYXJrIHdoZW4gYXBwbHlpbmcgd2lsbCBk
cm9wICJkdC1iaW5kaW5ncyIgcHJlZml4IGlmIGlzIGJlZm9yZSByZWd1bGF0b3IsIHRob3VnaC4N
Cj4gTGlmZSwgbm8gYmlnIGRlYWwuDQpPaywgdGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIGV4
cGxhbmF0aW9uIQ0KSSBiZXR0ZXIgYWRqdXN0IHRoZSBwcmVmaXguDQpCUg0KSm95IFpvdQ0KPiAN
Cj4gV2hldGhlciBjaGVja3BhdGNoIGNhbiBkbyB0aGlzPyBTdXJlLCBxdWl0ZSBsaWtlbHksIG9u
ZSBqdXN0IG5lZWQgc29tZQ0KPiBQZXJsLWZvbyB0byBhZGQgc3VjaCBydWxlLiA6KQ0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
