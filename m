Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8890773D069
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjFYLXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjFYLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:23:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A09F9;
        Sun, 25 Jun 2023 04:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPhUGubTBCVtndScTkH3GcBNjxSzOQfEuxmlQIufumN7XaLDRzH6X8L7tY2qo6elXIMzolK6wNKZYBMlU1khmAAYuMhsjR3Yl849vnsEVLhFoXvaiBZ8P20gUmFQFpjYiU88G/EhfF/bwkCHymHPF+IR4mWqfEFtv4ni4ZCOGAY2AxCw+U0qXvX7n4iElmCRJ7W4BBlhlNo4mYV19NCL/0+HCmdOE16drwVLCOtr/sHTwc3c8BYZ6x25bpIJv2bkW16uj7KOQg/o6Gx1ZcIrbLFUbixdENsLC3F4qYkHwK/EtzDXb7F1BlSTSDKYyyhIUK/MiIIV6nxv48pJk9EZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1MwO1odUyn/o0znNE+a164PSWdc46KdGfK9hhEYYvE=;
 b=n0+3D8EtxL80c+5MPd+wRswIYKhJB5lqDFYoRehRhK0JmLCTY3rmVtxUx2h0Z/HcmqDHVbCJYohQvlutssIDuBejHRl+U1leHMwObJ1MytHXM+yHouf4yyOAlUGPgk+NL7tQJyKnfdmguZX7M4wnP49CDQbrt4adulSQqIlslLgL/ytpTDd2DyyHwLmEXPU2asJo8EvOkbnF8BPwBkIpNF34gfy7RmtJSb9bJRvO92OPWhQLjoYga4OmlQ0AWh53RhR/NR4FSTc4WcgeUIq7Nm7kYHNCUefA6cfHo97j5cefaqJZNIgypltqD3IgykuyMo9WsDJT1w/ryfKCtpE40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1MwO1odUyn/o0znNE+a164PSWdc46KdGfK9hhEYYvE=;
 b=qCflylnDXI7gkbuSeR68j55Ay7HrSAktdLiw6VxhaD2FI8m1lmRa1wPDLqMKzj7HkdeK2G5SUHEbdUmeWfiS3WWzyOQakkPkwuIlwJ9eFqmPCg+GisppvoSCihZ7oQY5uUC1yIntvLdTKdEQ7/si4aGVVguc3udb9sSuontJ1sw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9932.eurprd04.prod.outlook.com (2603:10a6:800:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 11:23:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 11:23:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] arm64: dts: imx93: enable CM33 for 11x11 EVK
Thread-Topic: [PATCH 4/4] arm64: dts: imx93: enable CM33 for 11x11 EVK
Thread-Index: AQHZp1NFfzlRCz2SX0GB15W/MQmdSa+bX1gAgAAANLA=
Date:   Sun, 25 Jun 2023 11:23:30 +0000
Message-ID: <DU0PR04MB9417A0C5546DFCB0F34516FA8821A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
 <20230625105528.4057850-5-peng.fan@oss.nxp.com>
 <60efe832-b982-7ea7-abd3-5e9bfd41d064@linaro.org>
In-Reply-To: <60efe832-b982-7ea7-abd3-5e9bfd41d064@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9932:EE_
x-ms-office365-filtering-correlation-id: 07b2a8d8-0d6e-4e00-3380-08db756e9a99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfP3t7W8H+rlrgH/geBMSzl1iQTJKDtcz0D4+81Il98YSp4po/8jB4gL0H6kik3jm4Zn/Lolk2pfZCO4ZR/Ig2+IJvEJBVhr34D7h19SL5SiqM9Qtn/NJwlU2ogB2irLigW8EFfNQ1uzuEpPIFFnATJ0snyLxOceDFKvRpaTJt03MMDbPI7UWMUAmcRG5UKKaU/JEy5Qvy9ikY05djY4gDuXAVNLs+54iOzlJsyxovHeHnAVKKQMKLXKis046IzgfUfL+vWPtXHHvXCDNmQCZdS+p5pAFDUK6ufdasj6+bZTgxkJ8Mc2HjKBSkYGj1ViqTmtsWz1EipK1NWO8961sLz/h1P8vsvxgLC+BIwZLE3gbzV1bZc5f/kwEjDDPMq0vERpDSNfodlRcyRJLlaG1xj49AZR1H/RuEbHhkq7emZKuMagPaHUhknq0zNgwNJpn9l0FoXtzti7ZI4oGMt2yH1ZeYN0p1YPh//43y+q5CvZTT/MZmk2InGVkiMTxi2lUYsODSH2JZRIAzRFtx3v8No+RhA98tCJz8kNF8425yglQSqDoXyO0mOKnMCTC5clfy0SeLnlr3iuWWWyyMlqeQqUQ7n3JG+dIQ5UtjFhQhMBa4mo5snDsZblpk5Sdp7x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(7416002)(44832011)(5660300002)(52536014)(4326008)(76116006)(66556008)(66476007)(64756008)(66946007)(66446008)(33656002)(478600001)(316002)(8676002)(8936002)(4744005)(2906002)(55016003)(110136005)(54906003)(38070700005)(86362001)(41300700001)(7696005)(9686003)(53546011)(186003)(6506007)(26005)(38100700002)(71200400001)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVdhdFJzYUg3WjV2V2RDUVZ2eExrd043TVFFQU1mNjQ1clhMRlA5Y0pndHlZ?=
 =?utf-8?B?aUp3NmFZTnRIUTR0NG9JcHFhUXZidzVRR3V0U0ltaHFxSXdSREdZa1NqQTdI?=
 =?utf-8?B?MnE4ZXFrZyt5c1RzR2w1T2o2WmppTzV4ZG1IOTB3OWhVV2hYMzZCalNPeXJJ?=
 =?utf-8?B?Z05vRjVWT1NjcU5IZW4vWDF3OEk1amNBYUN0a2FkdlQ5UzRYM2ZJeHpOaHN6?=
 =?utf-8?B?bTVIL2tqSXU4V2VMeTVIaWVWeG5XY0xoUW45aUozbUZ4VU5nTUx1M1M3d2lu?=
 =?utf-8?B?eGNVNzdUT0lvWWorRXU4Tk5nS3Z3ZXFPVVhTSnphN0NwNDFiOVpmY2pBbHVB?=
 =?utf-8?B?MTZKMElTRTNaMitBV3VPRHZZZWlVR2swdlBiQjhhUnRaNTNXRFVIYnFxdW5w?=
 =?utf-8?B?bVplVitkN004dm80dFFNSzZ2T0crb2wyYlNEV2psTVJZbjJJZHprUUxMK1dz?=
 =?utf-8?B?R1VRRVVlM2dwZDVpNitEWFp1OEZzR1BsTTRyZFcySFBKZG5LOXlpK3Y5VnJ3?=
 =?utf-8?B?dXJBWERkS3U0L3RVYVhhMXp0OXc2K0ora3VOejhJL25CWjRzc1JPWGFpUjBJ?=
 =?utf-8?B?Q1dFQTNLc0R1MlVXam5nU0xKY0lId3lvYVNEMmwramRoSWFhMTQ5bnBnTjhl?=
 =?utf-8?B?Ykpzc0VnUUhyN2l2ZXFtRDRXMDh5Ri9lTlFFalFtSDlRU1FnekZvZVNqNmFC?=
 =?utf-8?B?cnM1M3QvVERWTkt0UFd4V2Fpa2pVZE93S2tIYit5a2NzY0ZUd0IrOG9McjUv?=
 =?utf-8?B?UVdkbFdDYXg0TU9UM0dwNGVRN0NJeVZFaDVic2owM3ZKc3Z2L3o1ZjFOMW5S?=
 =?utf-8?B?MXRVL2lST25jMVVDcXRaSlNKN0c1YXpPY2x4ODNobVNWTkJkZElxd2lsOG40?=
 =?utf-8?B?RW5HaWltanl1R2hrMU01aUZLSlVjMGIxVHAvd2lQVDQxSFVHdVZBMnhldVhW?=
 =?utf-8?B?VUhOZ3VuTkUvY3Q4Qzh0U2c2dWJuOEU4c0Q0S3BrMzVMamFFeW1DQVp3OU0y?=
 =?utf-8?B?RktsVXpSY3kzVDVRNEdBT0xnMmpoL1piRGFDQzVhNVFFc2lDMElSWTFUT2Z2?=
 =?utf-8?B?UzBSQ04rcllqZmhJb2VUREZqOTQ3L0ZUaTFESHl3T0ZSV1pkK25Da3VsMDNT?=
 =?utf-8?B?OFd3QS9ESi9KT1kwRDIwYWxBc1R2M2pjZkNBZ1NzS3ZVV3U5WW9PV2xkN2ZR?=
 =?utf-8?B?aGREOGJUL01HV0FOZVhnZUxpQVlrck9UeHRvMmQvMkhHOEZwYWxXN1JWWi9i?=
 =?utf-8?B?dE1OWWJReFBCZElUWVJ4Y3lkUjAwRXE0VU10UnZGMytMamRScnNGbDF3Y2I3?=
 =?utf-8?B?OW1YOUZkNGtnL2IyQlNPM0ptSTREZmg4a1JaeExSNFJLajRIem96cU9uM3pE?=
 =?utf-8?B?Y1hFOHFwUm1sL201SlFTNnRRZnN0d24vVjJKK1FOeUJPeU1sS3RDc3VUdmJl?=
 =?utf-8?B?cmFLbW1HVkNRNGRYOElTTHVnWWo1RXorME9kWG1pbnlXZldyU3Z3eW1UWWJR?=
 =?utf-8?B?R01rekJSVEFZTS9pKzNlZ0h2emxVNnkwZXNiRFBTbng0SHpGOEpLK3dZQnpM?=
 =?utf-8?B?dEdGV1pPUXpPOXN4M3VmU1FsR2pRV0lJU3NseklyVDR3aVV0d09vZ1doRWRm?=
 =?utf-8?B?QjZnTkpkU0p1ZTFENGN4NFRROWNpd1NmM05STzBtL3BUYnpIWGNBOFM3TVdq?=
 =?utf-8?B?YldQYmt0UWZvNDZwU0N0citzNkkza2VFWStWV1JlV0NCMEhWVmx2NDF3cStl?=
 =?utf-8?B?bzFIYWRkcHdWclpwRjd2TlFJM21laGFDbnhmZXA2Vm5odit0ZmR2VlB3WkpM?=
 =?utf-8?B?ZlFvQngrU0F3TnBUYW1tY2dCSXdNZHhXcFlEVUpjS3hBbDVnL0tMN3pWSFRS?=
 =?utf-8?B?WldNdTlDY2RQY0lwRklUdmQ0aUJtZ3FxRFFFSytsYnJtYXFxYUhoaWlIRk1r?=
 =?utf-8?B?Nzg5NzdwcGQxOG9GNENXVGdHTm13d3hUcVF1ekNmeEYvWmduTUFTYzhSbUFx?=
 =?utf-8?B?TVlDVndVY3J1Q3RWbGRadjJLNCsrdjJKalVwWlVvOFJQNnZSeGZkS1FnVTlw?=
 =?utf-8?B?enBDMkdZTm04b3BwR2RtSlVnY0t0TzUxSk94K0JGRXBwTGlqblFNQWQ4MmJh?=
 =?utf-8?Q?c4Ok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b2a8d8-0d6e-4e00-3380-08db756e9a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 11:23:30.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQj5FSdIWCWeNoZsqEOqzeRcym2BAoDXCEJa4J3NKI4ZQy6UqvRtBvR/vYxmpJI0bwiPEJjQJdSKBdmqdQuOCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9932
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gYXJtNjQ6IGR0czogaW14OTM6IGVuYWJsZSBDTTMz
IGZvciAxMXgxMSBFVksNCj4gDQo+IE9uIDI1LzA2LzIwMjMgMTI6NTUsIFBlbmcgRmFuIChPU1Mp
IHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4g
QWRkIHJlc2VydmVkIG1lbW9yeSBub2RlIGZvciBycG1zZw0KPiA+IEVuYWJsZSBDTTMzIG5vZGUg
d2l0aCBtYWlsYm94IHByb3BlcnR5IGluY2x1ZGVkIGZvciBkb29yYmVsbC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gLi4uDQo+IA0K
PiA+ICAJfTsNCj4gPg0KPiA+ICAJcmVnX3ZyZWZfMXY4OiByZWd1bGF0b3ItYWRjLXZyZWYgew0K
PiA+IEBAIC0xMDcsNiArMTM5LDE2IEBAICZscHVhcnQxIHsgLyogY29uc29sZSAqLw0KPiA+ICAJ
c3RhdHVzID0gIm9rYXkiOw0KPiA+ICB9Ow0KPiA+DQo+ID4gKyZ7L3JlbW90ZXByb2MtY20zM30g
ew0KPiANCj4gVGhhdCdzIG5vdCBwcm9wZXIgcmVmZXJlbmNlIGJ5IGxhYmVsLg0KDQpPaywgd2ls
bCBnaXZlIGl0IGEgdHJ1ZSBsYWJsZSwgc3VjaCBhcyAiY20zMyINCj4gDQo+ID4gKwltYm94LW5h
bWVzID0gInR4IiwgInJ4IiwgInJ4ZGIiOw0KPiA+ICsJbWJveGVzID0gPCZtdTEgMCAxDQo+ID4g
KwkJICAmbXUxIDEgMQ0KPiA+ICsJCSAgJm11MSAzIDE+Ow0KPiANCj4gVGhyZWUgZW50cmllcywg
bm90IG9uZS4gQW55d2F5LCB3aHkgbWJveGVzIGRlcGVuZCBvbiB0aGUgYm9hcmQ/IFRoaXMgaXMN
Cj4gcXVpdGUgc3VycHJpc2luZy4NCg0KVGhlIG0zMyBmaXJtd2FyZSBkZWxpdmVyZWQgYnkgTlhQ
IHVzZSBNVTEgZm9yIGRvb3JiZWxsLCBidXQgb3RoZXJzIG1heQ0KdXNlIG90aGVyIE1Vcywgb3Ig
ZXZlbiBub3QgdXNlIE1Vcy4gU28gSSBwdXQgaXQgaW4gYm9hcmQgZHRzIGp1c3QgZm9yDQpOWFAg
Ym9hcmRzLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQo=
