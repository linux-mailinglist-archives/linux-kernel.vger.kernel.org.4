Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4D6D8EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjDFFRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjDFFQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:16:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD218A66;
        Wed,  5 Apr 2023 22:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLgHkAp6gm4Ait9v4nUmIp9kGRu8E7lqcBWh8QcfbywTRr0GgE0DoC3OZJ18O9BA0G39e6j0AN13o9vc1fPbIXLRG8RpOcFPrDLRMgUahp8M4bhFot/S/0hIacaSVO5DWWezS9dz8h0altucWhX6NSlieOV063bAerwXiv6ZvXRF3gY5Uz8CCvaU4iELq/j0c6asVxz9+2szuQ4jt6Lhfr14TN7QmKHsdKr4ZP/Cf2J7/3RvEHLKxUKh0swCOY6p0Dc76kC0EAwUZ1q+1ZngckvaZ+gjAmNlN6lio1sNPHZgk6oDKh94QwvqKo5ohNHRd4TZ+BPZtV1Gxibar0nh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7edqYaIKDiXvK0e9GzJV/MbfRxPcGjPwfyCRZbI638=;
 b=Fy446DpEUmD4otB1EdETqvdpwAHBBTlJ9AxNsRshJHGavHzBPZzswmgi9DdxjfDQCwSdAA31LKr3qmyxP3Dk2Pn/kM1CrxFkD3YwIuADnNqw5OAhrf1pjzylD2H2Vg2bYq8BTgnvazGxKqy+NA7Ss1vuq/17DSTt7D+Bx/LxIU95231EQq7ZJazc6SM9rHnNaURW+pUrHrFjXuVUxRBP4U1VGN2zI/1VfcPca5vepDA6ruIcHiFgP1EFzlU0siFx82Qt5G56nth8B9/LLzkjJavnlhedVz8955y6nNflS7kcpYiyWHmlE4AAvqF58TiXeM7uaqIJmHxLMS5lST1f4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7edqYaIKDiXvK0e9GzJV/MbfRxPcGjPwfyCRZbI638=;
 b=UjLRsMJPTeRhOA4KHtsfdZn0glgpcq095U1Gpby2o0By4jvu5kDzUeRa1q4xy9xQDXS2cKtCKkVquIk0i4GIPOXGaaKBUK23e6Sa8nMbu6wdNLnxCl9aTnoO4VfVvYDwkk6K5R4HvcYuqKL3k7zatW7ptn8QtvbdemVafyWFgKc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7574.eurprd04.prod.outlook.com (2603:10a6:20b:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 05:16:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Thu, 6 Apr 2023
 05:16:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the
 SCMI reset controller
Thread-Topic: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the
 SCMI reset controller
Thread-Index: AQHZY+gfFgW91EuCRkiIW9Op8za+hq8am2PggACtU4CAAn0YIA==
Date:   Thu, 6 Apr 2023 05:16:49 +0000
Message-ID: <DU0PR04MB94170A9BD5F46D4157196D0888919@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
 <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
 <DU0PR04MB941747DDF6FD2F157A24183288939@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <6bfaef82-458e-256d-b9ba-d6d84c574d4b@foss.st.com>
In-Reply-To: <6bfaef82-458e-256d-b9ba-d6d84c574d4b@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7574:EE_
x-ms-office365-filtering-correlation-id: 49a3498a-c28a-427c-b3f2-08db365e2005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/qcKWHWzI3mX7XL8XCM2IMZacQCnAx3sqP4e40Gn0eITboU9RPlQiNTdWcE5R1jBlZZbfE/wSx/DI2P9wUfigJu+ZVTDSQMRV+p78uJn9aOusH3vh+XO2q9GPYxzZbGqWhfO8X00QV2QI8cvYwoQiaVlLVyzEJqVUeoYQfu66QISm4fPgxs6Lxf63xLCUeIYzrApmu7KUNDSziBrSn+UqbReaqRWphZXELDH3+FUu7DwxnIk2+ocCwc3nhwhKTfLtTQ9OXpCoikpxTFZ5n5vHi9B2BIw3fD0B9qrG1sp9YhC/oF/O+HX6IR06FeTccVCNlBXo3dPaqd4GYkkle36c/OIAYGTQv/IZxCOfQKKGOdnCyt8ut5spKdfG2DwGdwQyo2waJrv30bIsYpjEUYKXnKXDI8X+UMcMWilQtnKmz3yHMUjwNWHEi3geSZrWzK3yl43X9frOwgYZ2ByVWfDBVJ4VU0nUlnZaJWl0wPZuNyiQ50U3SAgfGD+TmacU5E9GZexWsnpYZtdl1Sc2TWRHXGGyWlxnW0lVwl7NPiuOHCJtM+b9i/0L+i/FYW69/p2W1rhQfjvI455I95VMpN8mtF5k0kXzW3CzZgmrYC8ArUXgPJ5LzVka7pYMyHsrdL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(83380400001)(316002)(478600001)(71200400001)(7696005)(110136005)(54906003)(26005)(6506007)(9686003)(186003)(53546011)(5660300002)(2906002)(44832011)(7416002)(33656002)(38100700002)(4326008)(66946007)(76116006)(66446008)(64756008)(8676002)(122000001)(41300700001)(86362001)(66556008)(66476007)(52536014)(8936002)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUM0Y3E3WmFhNHY4aXcxWWxhMHU5elRaNVpwdy9WaW1ZZ1BVZ1AzMlJGa3lr?=
 =?utf-8?B?aXBNOUVaMXF4MVZqV0dzdi9xN05NOUJINkt0REFQRmFnaHZOYUt1OXB0NzN4?=
 =?utf-8?B?ZTR0VGdSaVpyNDFVSG4zK0FwcW9IOWlOaGo5RWV1elBycytWdDUzaDNOQlE2?=
 =?utf-8?B?M2JCdmNZS3hpS1pkSUxmeVhnNytZbEpUK0t6N3ZwcStLUExQOFQrUThvRWpZ?=
 =?utf-8?B?aUJhS1AwaHRESXEvNGZVSjAvWXJlZEdBd1JTTVFqSk9ONThuN0p6dFI0Zk5u?=
 =?utf-8?B?ejEzdEQ1MWhEWitvWG50ZjdISDROUnhSYXkzWDgzWXJmRGFFTjM5TVVobmUw?=
 =?utf-8?B?b3l6YjhES2VWLzE5RGhzMXBhYmtmZEs3c3NuTmdOZ1IxV0JjcWNRa0prMzhH?=
 =?utf-8?B?aWlwWHBjb1RyanF2VTFmS1ZEMDhiTzc1Qm16OXYzU2VvaGlIR1lBZ0VIaW5o?=
 =?utf-8?B?WUI3SmxoOXJsU2d1OG1xdUhYUWxHMWQrOHZLZXlYWWFMdzJIMTJrcURXOFNF?=
 =?utf-8?B?TENzd1VXWjFZSEVJU0FIcWozUVNibC9oeWNyZnd5UEh4c1RYWU15SVJVVy9m?=
 =?utf-8?B?Z1lZWVZxNFJFRCtyOXVnSE9raDJZb3d4YnNuN0hXRms0ZjdsYkFrUzR6dHVI?=
 =?utf-8?B?M2pvaE12a2Jvd2lFUmpGZTZ0QVdNaktxVEpCNmtzVS9jbDR3dFdrdDRadHNK?=
 =?utf-8?B?cUJpOVBFNHNUTmVVV2diNWdOaWQwbTNJYkRqbFVlYzhKd3pwVmM3eW9GaUxO?=
 =?utf-8?B?aHQyWkZKZUtpNk8wTDBHRVM5Vk5EZ0ExNG9YUjRJcmFtc0VGekd0QmRkSG9q?=
 =?utf-8?B?T2JHQmpPMlQ0NVYxY1pHc2p1clVxbGEzWUJoTkM4U2FhZ2ZBblVRV0tDeFMy?=
 =?utf-8?B?OGs2ajZYc24yNnQzS09sRE9KdkdmUzZYWUErdFo5Zms0ZEQ5WW0xV0dkMGww?=
 =?utf-8?B?alltaHRFVEFrMFV0Z2laL1RKZ3I2YUxMUVpRV2FuTHlIbCthVDJsUkRuWXN3?=
 =?utf-8?B?cGtzUmpocExBa1N6YkwxZlB4UEtKdmpxbnZ1NWUwOGdNNndHOG9maHhaSm9R?=
 =?utf-8?B?Y3ZINGRnaG5oNTVZeHhDVU1vTVNDclBTYUJtSFlLZ0JuekdFT3BsNW9aSko2?=
 =?utf-8?B?U01LNy9YdHRlM1IzN2ViTk9iU0NQUTk1RTYvaUtIaktTcHlLN1BsOVRQU0Jw?=
 =?utf-8?B?REFTL2hBMzF5cndITFNaZnZzVkNiMGhvem5tYnZtdWJrMGpCYlE3Z2laUHcz?=
 =?utf-8?B?NE05YWVjYjZEOWRCTkx4dUpwQmRtekhEZVE4K09zRFdDL0N1NHJ1aktFTFFG?=
 =?utf-8?B?QnlDa2lGOW91TFh3SzhnRjRBaEtDVmV5VXY1V29obHJnR3VPc29Xc3ppQW1M?=
 =?utf-8?B?QWRRd09pNFpjdmE1OFl6NU5vQW14dGxldk12UmRWdjJodnFaZlpZeVE3RGt1?=
 =?utf-8?B?QVd3WXJnajcrVFFQa3V0dkc2NWJNUjlLa3I5d2RvdHBhbFhYRG1raHRxQ1lX?=
 =?utf-8?B?dllzaExXWVRla2YxL0hkSGQxWDduUnErS2R3MjUwNnd5VDR5NnJ3MjBEcWtH?=
 =?utf-8?B?R0pYdzRNb0hLeVEyS3phaEtQcm4vYnA5VzBpdElkNW12NnVjako0ZzByZ1c2?=
 =?utf-8?B?dzBHNzk0OHZQY0NkRkNBZ2RqZTZnbnhYUUVXQ3NBSlBXcTdadHJLem5PdDJ1?=
 =?utf-8?B?ZStsN1RPS21PTXVwOEFQdFpqNGNMb3p0M25sK1Z2VXRheXlXZmFpZjVBQ2ZP?=
 =?utf-8?B?ZCtFbVZkSCtuM1krUHZXME85Mk9Wb3c1N0dsVkdNVDhFdDU5V2NDU3FEa3Z4?=
 =?utf-8?B?QkQ4OXFzdzEraXBjaS9qVXNBQ0ZiQys1Z3RnM0h2MGxFQk5RcFhEVzQ1dHJu?=
 =?utf-8?B?Q1hvM2dtdG1UaGk5VEh3N3M0bTU1ckU0VXJMTkt3TjNZVlNJOUhWdHdSM0Qz?=
 =?utf-8?B?S21aS3dXVW5jYTc3YXlycVVYY0wyRms4QjVPNlFLLy9EKzd4WUxrN1EwU2NW?=
 =?utf-8?B?U0QzZGNhekFmakU2VjRFYjBGczhIV1R5M3F1YUtOdWZJVitzNVBydWZWMlZP?=
 =?utf-8?B?Y3lvUTVlejN1YlgyOFlXTzQ2SkJyM1BoVURra05HQzJDK3lyODBxNGtNU1dK?=
 =?utf-8?Q?w/7E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a3498a-c28a-427c-b3f2-08db365e2005
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 05:16:49.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D54KQ9wBT5YVdbuEe0XPtQeyZ1Tf4pibqh1ww90ikESJWT5oo4I7KFBrZyyNSLfiR11lW9aTmxUe4PaKozkSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7574
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gcmVtb3RlcHJvYzogc3RtMzI6IEFsbG93IGhvbGQg
Ym9vdCBtYW5hZ2VtZW50DQo+IGJ5IHRoZSBTQ01JIHJlc2V0IGNvbnRyb2xsZXINCj4gDQo+IA0K
PiANCj4gT24gNC80LzIzIDA2OjU1LCBQZW5nIEZhbiB3cm90ZToNCj4gPj4gU3ViamVjdDogW1BB
VENIIDQvNV0gcmVtb3RlcHJvYzogc3RtMzI6IEFsbG93IGhvbGQgYm9vdCBtYW5hZ2VtZW50DQo+
IGJ5DQo+ID4+IHRoZSBTQ01JIHJlc2V0IGNvbnRyb2xsZXINCj4gPj4NCj4gPj4gVGhlIGhvbGQg
Ym9vdCBjYW4gYmUgbWFuYWdlZCBieSB0aGUgU0NNSSBjb250cm9sbGVyIGFzIGEgcmVzZXQuDQo+
ID4+IElmIHRoZSAiaG9sZF9ib290IiByZXNldCBpcyBkZWZpbmVkIGluIHRoZSBkZXZpY2UgdHJl
ZSwgdXNlIGl0Lg0KPiA+PiBFbHNlIHVzZSB0aGUgc3lzY29uIGNvbnRyb2xsZXIgZGlyZWN0bHkg
dG8gYWNjZXNzIHRvIHRoZSByZWdpc3Rlci4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQXJu
YXVkIFBvdWxpcXVlbiA8YXJuYXVkLnBvdWxpcXVlbkBmb3NzLnN0LmNvbT4NCj4gPj4gLS0tDQo+
ID4+ICBkcml2ZXJzL3JlbW90ZXByb2Mvc3RtMzJfcnByb2MuYyB8IDM0DQo+ID4+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPj4gLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDI4
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3JlbW90ZXByb2Mvc3RtMzJfcnByb2MuYw0KPiA+PiBiL2RyaXZlcnMvcmVtb3RlcHJv
Yy9zdG0zMl9ycHJvYy5jDQo+ID4+IGluZGV4IDRiZTY1MWU3MzRlZS4uNmIwZDhmMzBhNWM3IDEw
MDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2Mvc3RtMzJfcnByb2MuYw0KPiA+PiAr
KysgYi9kcml2ZXJzL3JlbW90ZXByb2Mvc3RtMzJfcnByb2MuYw0KPiA+PiBAQCAtNzgsNiArNzgs
NyBAQCBzdHJ1Y3Qgc3RtMzJfbWJveCB7DQo+ID4+DQo+ID4+ICBzdHJ1Y3Qgc3RtMzJfcnByb2Mg
ew0KPiA+PiAgCXN0cnVjdCByZXNldF9jb250cm9sICpyc3Q7DQo+ID4+ICsJc3RydWN0IHJlc2V0
X2NvbnRyb2wgKmhvbGRfYm9vdF9yc3Q7DQo+ID4+ICAJc3RydWN0IHN0bTMyX3N5c2NvbiBob2xk
X2Jvb3Q7DQo+ID4+ICAJc3RydWN0IHN0bTMyX3N5c2NvbiBwZGRzOw0KPiA+PiAgCXN0cnVjdCBz
dG0zMl9zeXNjb24gbTRfc3RhdGU7DQo+ID4+IEBAIC0zOTgsNiArMzk5LDE0IEBAIHN0YXRpYyBp
bnQgc3RtMzJfcnByb2Nfc2V0X2hvbGRfYm9vdChzdHJ1Y3QNCj4gPj4gcnByb2MgKnJwcm9jLCBi
b29sIGhvbGQpDQo+ID4+ICAJc3RydWN0IHN0bTMyX3N5c2NvbiBob2xkX2Jvb3QgPSBkZGF0YS0+
aG9sZF9ib290Ow0KPiA+PiAgCWludCB2YWwsIGVycjsNCj4gPj4NCj4gPj4gKwlpZiAoZGRhdGEt
PmhvbGRfYm9vdF9yc3QpIHsNCj4gPj4gKwkJLyogVXNlIHRoZSBTQ01JIHJlc2V0IGNvbnRyb2xs
ZXIgKi8NCj4gPj4gKwkJaWYgKCFob2xkKQ0KPiA+PiArCQkJcmV0dXJuIHJlc2V0X2NvbnRyb2xf
ZGVhc3NlcnQoZGRhdGEtDQo+ID4+PiBob2xkX2Jvb3RfcnN0KTsNCj4gPj4gKwkJZWxzZQ0KPiA+
PiArCQkJcmV0dXJuIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KGRkYXRhLT5ob2xkX2Jvb3RfcnN0KTsN
Cj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gIAl2YWwgPSBob2xkID8gSE9MRF9CT09UIDogUkVMRUFT
RV9CT09UOw0KPiA+Pg0KPiA+PiAgCWVyciA9IHJlZ21hcF91cGRhdGVfYml0cyhob2xkX2Jvb3Qu
bWFwLCBob2xkX2Jvb3QucmVnLCBAQCAtDQo+ID4+IDY5MywxNiArNzAyLDI5IEBAIHN0YXRpYyBp
bnQgc3RtMzJfcnByb2NfcGFyc2VfZHQoc3RydWN0DQo+ID4+IHBsYXRmb3JtX2RldmljZSAqcGRl
diwNCj4gPj4gIAkJZGV2X2luZm8oZGV2LCAid2RnIGlycSByZWdpc3RlcmVkXG4iKTsNCj4gPj4g
IAl9DQo+ID4+DQo+ID4+IC0JZGRhdGEtPnJzdCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfYnlf
aW5kZXgoZGV2LCAwKTsNCj4gPj4gKwlkZGF0YS0+cnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dl
dChkZXYsICJtY3VfcnN0Iik7DQo+ID4gW1BlbmcgRmFuXQ0KPiA+IFRoaXMgbWF5IGJyZWFrIGxl
Z2FjeSBkZXZpY2UgdHJlZS4NCj4gDQo+IFRoYXQgcGFydGlhbGx5IHRydWUgYnkgdGhlIGZhY3Qg
dGhhdCBJIGltcG9zZSB0aGUgInJlc2V0LW5hbWVzIiBwcm9wZXJ0eSAoYnV0DQo+IGFsc28gc3Vw
cHJlc3MgdGhlICJzdCxzeXNjZmctdHoiIHByb3BlcnR5KQ0KPiANCj4gQnV0IHRoaXMgc2hvdWxk
IG5vdCBiZSB0aGUgY2FzZSBhcyB0aGUgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1MS5kdHNp
DQo+IGlzIHVwZGF0ZWQgaW4gcGF0Y2ggMi81LiBUaGUgRFRTIGZpbGVzIGFzc29jaWF0ZWQgdG8g
dGhpcyBjaGlwIGluY2x1ZGUgaXQuDQoNCkRUICBtYWludGFpbmVycyBtYXkgY29tbWVudCwgZnJv
bSBteSB1bmRlcnN0YW5kaW5nIGlzIHVwZGF0aW5nIGRyaXZlcg0Kc2hvdWxkIG5vdCBicmVhayBs
ZWdhY3kgZHRzLCBzYXlpbmcgNS4xNSwgNS4xMCBkdHMuDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+
IA0KPiBUaGFua3MsDQo+IEFybmF1ZA0KPiANCj4gDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFBl
bmcuDQo+ID4NCj4gPj4gIAlpZiAoSVNfRVJSKGRkYXRhLT5yc3QpKQ0KPiA+PiAgCQlyZXR1cm4g
ZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoZGRhdGEtPnJzdCksDQo+ID4+ICAJCQkJICAgICAi
ZmFpbGVkIHRvIGdldCBtY3VfcmVzZXRcbiIpOw0KPiA+Pg0KPiA+PiAtCWVyciA9IHN0bTMyX3Jw
cm9jX2dldF9zeXNjb24obnAsICJzdCxzeXNjZmctaG9sZGJvb3QiLA0KPiA+PiAtCQkJCSAgICAg
JmRkYXRhLT5ob2xkX2Jvb3QpOw0KPiA+PiAtCWlmIChlcnIpIHsNCj4gPj4gLQkJZGV2X2Vycihk
ZXYsICJmYWlsZWQgdG8gZ2V0IGhvbGQgYm9vdFxuIik7DQo+ID4+IC0JCXJldHVybiBlcnI7DQo+
ID4+ICsJZGRhdGEtPmhvbGRfYm9vdF9yc3QgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0KGRldiwg
ImhvbGRfYm9vdCIpOw0KPiA+PiArCWlmIChJU19FUlIoZGRhdGEtPmhvbGRfYm9vdF9yc3QpKSB7
DQo+ID4+ICsJCWlmIChQVFJfRVJSKGRkYXRhLT5ob2xkX2Jvb3RfcnN0KSA9PSAtRVBST0JFX0RF
RkVSKQ0KPiA+PiArCQkJcmV0dXJuIFBUUl9FUlIoZGRhdGEtPmhvbGRfYm9vdF9yc3QpOw0KPiA+
PiArCQlkZGF0YS0+aG9sZF9ib290X3JzdCA9IE5VTEw7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+
ICsJaWYgKCFkZGF0YS0+aG9sZF9ib290X3JzdCkgew0KPiA+PiArCQkvKg0KPiA+PiArCQkgKiBJ
ZiB0aGUgaG9sZCBib290IGlzIG5vdCBtYW5hZ2VkIGJ5IHRoZSBTQ01JIHJlc2V0DQo+ID4+IGNv
bnRyb2xsZXIsDQo+ID4+ICsJCSAqIG1hbmFnZSBpdCB0aHJvdWdoIHRoZSBzeXNjb24gY29udHJv
bGxlcg0KPiA+PiArCQkgKi8NCj4gPj4gKwkJZXJyID0gc3RtMzJfcnByb2NfZ2V0X3N5c2Nvbihu
cCwgInN0LHN5c2NmZy1ob2xkYm9vdCIsDQo+ID4+ICsJCQkJCSAgICAgJmRkYXRhLT5ob2xkX2Jv
b3QpOw0KPiA+PiArCQlpZiAoZXJyKSB7DQo+ID4+ICsJCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0
byBnZXQgaG9sZCBib290XG4iKTsNCj4gPj4gKwkJCXJldHVybiBlcnI7DQo+ID4+ICsJCX0NCj4g
Pj4gIAl9DQo+ID4+DQo+ID4+ICAJZXJyID0gc3RtMzJfcnByb2NfZ2V0X3N5c2NvbihucCwgInN0
LHN5c2NmZy1wZGRzIiwgJmRkYXRhLT5wZGRzKTsNCj4gPj4gLS0NCj4gPj4gMi4yNS4xDQo+ID4N
Cg==
