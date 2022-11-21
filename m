Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835DE631869
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 02:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKUB7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 20:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKUB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 20:59:04 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955918B0D;
        Sun, 20 Nov 2022 17:59:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXXXf/WYoLI9PrKSHMfJPSF4YzALQ1BDn1V8pknX3dy20Uctt3PColjNWE22qq0H50rd8MgBfzUWGvcfszo1gkqiktnDzLKf3x9SdBFpaTEm4SMNDTSTcKXtvU0zgGm+5bQz+tMVuzgy4Pl1yOTkRBA5atkdJooeGkkvUjDMhAbPHTIi1GE81hxBy1UGSd9uZVArr2D5Tk3l1PhNdjhtZ4ZNeNPC4MKS/HdQCcnqpmUYTDhrn36I22HK6EtVQPTJx+bxJBRp6p3O9Fk3Go06cx6FApbIc8oHk2nBiR5tNdZvqxwSMYCyg9OjcS+CE3EaxECUTWfGVxOLSlCk4ZYocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtk+Wd31/wQD7WAS90DOgaki3UPFB0GDf/TPN8eZ+C4=;
 b=mbe64vzzfbKWT0zOJJRmSJCqftTIY/GOdLM3zh4eopUW8bVp/Oe2c2NKSU6jX+vSCyHcg1V9JKms0ujcNCLAmfAIDaWG6OSlFYmqmfYPrNlEbk7VVba5R5woSRgiO+iWYhQBdHLtOCsKH0lg8ApzTLTbfhd59F2srWjmecr6uOZZ3rClVkUcVuwtWi+vc8cUOUIKdhqv/UHUOsjmSP4S4AleAwLpTDKfMXsy+cZk0EldeBrIkqpMSTusTF8Qws/Cd5rf4yG2QA49mSYXigGsDWDTBznxCceFAFr+feuXviK+ilXN/FWMancOPb1zwpytJ8XTYSpdfrUDmUsANxwRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtk+Wd31/wQD7WAS90DOgaki3UPFB0GDf/TPN8eZ+C4=;
 b=eICstiw3GZPSMrdk1xtC2HhLvUrp1FfTXR+r4JO1OBJE3uQhTxLreSSpN/rO7WIU3Qxikdb8rhk8xB99Hcujz/fcebJt1mF1Me1H3pTJLFbuUV0VvpvcXW12AqMcB+QIi9FW/NXAkDb+j/+venbBsznT3g1+pdV1XBlxQDyWaqQ=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU2PR04MB8568.eurprd04.prod.outlook.com (2603:10a6:10:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 01:59:00 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 01:59:00 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: check and cancel vpu before
 release
Thread-Topic: [EXT] Re: [PATCH] media: amphion: check and cancel vpu before
 release
Thread-Index: AQHY7cjK7ScEa5e1Lk6265YsaSliH65E0IOAgAPrFgA=
Date:   Mon, 21 Nov 2022 01:59:00 +0000
Message-ID: <AM6PR04MB6341786F7D506609C161E6C9E70A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <afd6674a68c02d25cdd57a70db8135217c70a358.1667289237.git.ming.qian@nxp.com>
 <5b77b349-16d2-e020-e4a7-43815088e1b8@xs4all.nl>
In-Reply-To: <5b77b349-16d2-e020-e4a7-43815088e1b8@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DU2PR04MB8568:EE_
x-ms-office365-filtering-correlation-id: 28a1b281-a556-49f9-0a35-08dacb63f53b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e27LYbx8UOZArN0v01j0UFjm8PrwKcRZuGLH/taqdFW9ZrsB/BkYlqZaUsKLmHMwX4O3bGpQdIycG/Ox9sbjQoiYCeop5bf2G1Qq04Lhbv/eosynD6Fr+mgEF4FidwekRjtomfPMibmBSnS75OS67lOgAu/WWH4gqnUm7KbuqrmCxsAUsQLuhevgA1mEoxJETb7ePugq+uwBhVOjPuI5XX55HhGZnM0HOJ07MH4Imkx/GmZd0mKKhFMqMCaNXTC1m16KEia5JfxVpCzPl+nxl31QAyhTuhpF0otE2NotJO7YbIV7IQOXLfRZ1F1yICMO29+SaP24SRbcw+53pTsVHa4ndyAHS88JEyVRqdROWOWNVieoDZ7DOj3nXq7szhx1N2ZSMR/ItLsn85ti6rnbRACXVofuvLSsgODM/ofnPj//8odQBDkg0UEZXZBWKc2yTh5fNCht/bT6C0kAdT9mPobDLAKClFUchiQr47gi1VFFVHi1Gvf52SAq9vSOhfPZFgS+r9Gve7v6Kp8RNusAFSwZn2bHGa3tjS4c+4UBZsdF+/rezt47CWlGpz030ehD8c/mKLyl6jBBrnvhpswSbiSADYyLIfLLFEy84lffns6BgjpkmK+9Y5Ux1DH7qy+l8/pDvomK4wVe5SdBzEu5G+Qc1wYA/GNtxm8N/EtOVa9887Epf4SEtJttQrmjA2bb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(55016003)(2906002)(38070700005)(186003)(38100700002)(33656002)(478600001)(26005)(7696005)(6506007)(66556008)(66946007)(76116006)(5660300002)(316002)(4326008)(64756008)(8676002)(9686003)(66446008)(66476007)(7416002)(8936002)(44832011)(83380400001)(122000001)(52536014)(86362001)(41300700001)(54906003)(71200400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDR1REV2aW9veURwZUpLdXpvdktVTnhRU1VsSkNKSVdBV0dwTFNiTW1Vck1T?=
 =?utf-8?B?UmRhOVlXTUt1VUhCVi9nU0RUSVg4R000cWFIVTVpbUtvNXQvdldVcTZSUkJP?=
 =?utf-8?B?MTBPWkFtRUs4RkxlWkEwbUhlWkk2b0FydVkwcC8vTzhqb2sxbkRPV2UyZjBL?=
 =?utf-8?B?dEVtM3YxUmpxUGFwVmpYTG9lL1BsRTg2ak1VWDRrcmlMWlRxSDRBVEd5MkY5?=
 =?utf-8?B?RGJNb1BVMnJ1N2Z4cGpTZDZmZzdsZ2U0QTVBcVVubkZyMmdURVh5TUF1REZm?=
 =?utf-8?B?VE4rcmlUMjhEajVKR0hyUjY4M2RXN1ZHTC9RQnB1Z2lvazJkOEdmSTRHK2J6?=
 =?utf-8?B?RnJ3ZW0zVmhBNFdobVJWVElCdHBtUEtxN3RTaE0vSDN2TVhIL0pEWitYZE04?=
 =?utf-8?B?N0J4WVZkOFpjN2ZoU2FMWUkwbHhSMjJmcndaYzdmTDBUY3hkZDVBemRnVVNC?=
 =?utf-8?B?MlZEdmpxa1U0YVNzRWR5NVlLQ0xqcmlWMXk1Wm1jOHk3U1NWdnB0RWZ1MjRD?=
 =?utf-8?B?ci9aclFsci9JRU1wRlhLNGNYczFIMDFOdDFjUFhxOXdKT1R4cmJXNURPZzgv?=
 =?utf-8?B?aDVxRDVGdy9tcEV0cDd2OWRsOGxtWXc1WlBXWHYvZDF0MWN2Z21IdE05TDNs?=
 =?utf-8?B?STZrdURqM0FhRjBkVXNNd3FmN0VrZVRSQW1tbzBGUEE1eUtDVlVna3A4UURM?=
 =?utf-8?B?TlQ2OXFVbjA2OEVkdUZjSGtVNmZMKzZMQll3WkxSMDZlc3BkRnpvTkY2cjFI?=
 =?utf-8?B?VG8xdWtUM1hGODNveklzTEludjRtV0diYWtUZTV6Z2dvVGFnYjgzNzlLNkJv?=
 =?utf-8?B?UUtyblZPazQ0RDUvM0RZYWRZbzVKbkdCU0ZKUUJqMmZtRzZyNnVWbkJjMXlX?=
 =?utf-8?B?T3RFY202WnVjYWluVGRDTmRIRDdPZTFMMmhrdEdqamRSS1FNZXFSRC85Nmpl?=
 =?utf-8?B?cWVSVVJrSnI1cjVOVWRhRlhxSXQ4R3g4MFdaVHR5MkdnZi81enJ2bHNaMTBB?=
 =?utf-8?B?bjFQWnVOaDdrZmhlZDlKOUxiYmowRDI2QjJDQzFFSVV1YnVlQ3pDM1Y4U1ly?=
 =?utf-8?B?am9RWlU5ZmJ4YjZnZVhBZGc1QTgxNXpGRTEweG9EVUdsZmw5dU9LUTM5SDN4?=
 =?utf-8?B?RVJwRVJZeHBSa0p6ZVFvWGk2QjJpeDhmL3BlRnVUcGNoSFNCUlVOeTBkUXNE?=
 =?utf-8?B?aWJ2dkRIb3NzOWxEeVBXelRkSVJOLzU0R0p5MDJaSFlJQlI3NERGdWxBZCtr?=
 =?utf-8?B?UlJWYXpzbENZSDJ6S21GZW1Ba2dlcFduWUlnVmF4eDFDekFtNEwzK3g3VFRO?=
 =?utf-8?B?L2djMk5UdEx1K1l6MFBncUQvYTJUclRHd2JibDJTWkVGR2lKSGtBWHV2MVlC?=
 =?utf-8?B?NUJVN1dnRkdkMzg5NHZlZktTdlVNNjFNSHJ3b2c4bHhiRytyWTgwQ3U4NStI?=
 =?utf-8?B?WjlvT3NvaFR4WnlmR29HZGhEVzNGcGsrT3R1aGJFeElWbTU5NlBhWTdyUVda?=
 =?utf-8?B?cE9wTTNyOVMyWnZlZ3BVb21qQVJCQTVnbXdmb2tDZTZMNkhpWmNpNE5YNnVR?=
 =?utf-8?B?bTRCdXdGQ2UxSlQxVHprVnJReFQ4MWZOa2FacDR3djdkendLM3NMR3Jmd0dO?=
 =?utf-8?B?RGxOdUVSbkJSZDFHWkJua0pVcEJ3VnZobjhoUW1yQmVkRnZoZnJObHlpbXds?=
 =?utf-8?B?U0p6MDJkZ1JnVVVDZHdqRldQaFdRaHRjS0RaMzZoR2J3U29HSHU4MHBEUHg2?=
 =?utf-8?B?Qmp4cDdLcHErNmFMaDZsVHhvelp0YitHMU1URmFTNFU3OGF2a0VFRU9vZ0hq?=
 =?utf-8?B?TDZXRyt3RTh5QUdOb1dqSkd3YUFPaVg2TnFzUmdpeGRZMkRmbER2VkF0amtT?=
 =?utf-8?B?am1zTHZLaGRCWTMvMDFoc2dqYVhENWVhNkY4OUpsNTZtbmw2SUlPWWVnQlJh?=
 =?utf-8?B?SFBSMTNrOXhUeGVKeXBIRjA0TUlHR2kwUGcvN293TDQxVXdqRnhjbk9kTS9i?=
 =?utf-8?B?aFd4RW9PaDVnVnArQWtLcTRTVGdjUlJiM2NnL1h4NkxRL3V2bmFJUzVBdG8z?=
 =?utf-8?B?emtTbzYrWXgySE5ubHVRd3ZIZGpHbHh5NDB1dkdLWldaa0QvOEMwWk1Xa0dJ?=
 =?utf-8?Q?Sx5g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a1b281-a556-49f9-0a35-08dacb63f53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 01:59:00.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRWQX3SFnyrcA6kb9+4bGXc9lJNxZHxO4SLZ1afCm3hPRr6ndZ15/rkuHHawBhnr5nSL7/NNJGx20FAyk1uPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8568
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkhpIE1pbmcsDQo+DQo+T24gMTEvMS8yMiAwOTowNSwgTWluZyBRaWFuIHdyb3RlOg0KPj4gZHJp
dmVyIG5lZWQgdG8gY2FuY2VsIHZwdSBiZWZvcmUgcmVsZWFzaW5nIHRoZSB2cHUgaW5zdGFuY2Us
IGJ1dCBpdA0KPj4gZG9lc24ndCB3YW50IHRvIHJlbGVhc2UgdGhlIG0ybV9jdHggYmVmb3JlIHRo
ZSByZWxlYXNlIGNhbGxiYWNrIG9mDQo+PiBpbnN0YW5jZSBpcyBjYWxsZWQsIGFzIGRyaXZlciBt
YXkgYWNjZXNzIHRoZSBtMm1fY3R4IGluIGhhbmRsaW5nIHNvbWUNCj4+IGV2ZW50IHdoaWNoIG1h
eSBiZSByZWNlaXZlZCBpbiByZWxlYXNpbmcgaW5zdGFuY2UuDQo+Pg0KPj4gY2hlY2sgYW5kIGNh
bmNlbCB0aGUgdW5zdG9wcGVkIGluc3RhbmNlIGJlZm9yZSByZWxlYXNlLg0KPj4NCj4+IEZpeGVz
OiBkOTFkN2JjODUwNjIgKCJtZWRpYTogYW1waGlvbjogcmVsZWFzZSBtMm0gY3R4IHdoZW4gcmVs
ZWFzaW5nDQo+PiB2cHUgaW5zdGFuY2UiKQ0KPj4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxt
aW5nLnFpYW5AbnhwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1w
aGlvbi92cHVfdjRsMi5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9hbXBoaW9uL3ZwdV92NGwyLmMNCj4+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9h
bXBoaW9uL3ZwdV92NGwyLmMNCj4+IGluZGV4IDk5YWQyZjFjNWE1My4uODQ1ZmM1M2Q4OTM3IDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV92NGwyLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfdjRsMi5jDQo+PiBA
QCAtNzY3LDYgKzc2NywyMyBAQCBpbnQgdnB1X3Y0bDJfb3BlbihzdHJ1Y3QgZmlsZSAqZmlsZSwg
c3RydWN0IHZwdV9pbnN0DQo+Kmluc3QpDQo+PiAgICAgICByZXR1cm4gcmV0Ow0KPj4gIH0NCj4+
DQo+PiArc3RhdGljIHZvaWQgdnB1X3Y0bDJfY2hlY2tfYW5kX2NhbmNlbChzdHJ1Y3QgZmlsZSAq
ZmlsZSwgc3RydWN0DQo+PiArdnB1X2luc3QgKmluc3QpIHsNCj4+ICsgICAgIHN0cnVjdCB2YjJf
cXVldWUgKnZxOw0KPj4gKw0KPj4gKyAgICAgdnB1X2luc3RfbG9jayhpbnN0KTsNCj4+ICsNCj4+
ICsgICAgIHZxID0gdjRsMl9tMm1fZ2V0X3NyY192cShpbnN0LT5maC5tMm1fY3R4KTsNCj4+ICsg
ICAgIGlmICh2YjJfaXNfc3RyZWFtaW5nKHZxKSkNCj4+ICsgICAgICAgICAgICAgdjRsMl9tMm1f
c3RyZWFtb2ZmKGZpbGUsIGluc3QtPmZoLm0ybV9jdHgsIHZxLT50eXBlKTsNCj4+ICsNCj4+ICsg
ICAgIHZxID0gdjRsMl9tMm1fZ2V0X2RzdF92cShpbnN0LT5maC5tMm1fY3R4KTsNCj4+ICsgICAg
IGlmICh2YjJfaXNfc3RyZWFtaW5nKHZxKSkNCj4+ICsgICAgICAgICAgICAgdjRsMl9tMm1fc3Ry
ZWFtb2ZmKGZpbGUsIGluc3QtPmZoLm0ybV9jdHgsIHZxLT50eXBlKTsNCj4+ICsNCj4+ICsgICAg
IHZwdV9pbnN0X3VubG9jayhpbnN0KTsNCj4NCj5UaGlzIGZlZWxzIHdlaXJkLiBUaGlzIGlzIG5v
cm1hbGx5IGRvbmUgaW4gdjRsMl9tMm1fY3R4X3JlbGVhc2UoKSwgc28gaWYgeW91DQo+bmVlZCB0
byBkbyB0aGlzIGhlcmUsIGRvZXNuJ3QgdGhhdCBtZWFuIHBlcmhhcHMgdGhhdCB0aGUgb3JkZXIg
b2YgcmVsZWFzaW5nDQo+dGhpbmdzIHNob3VsZCBiZSBjaGFuZ2VkPyBJLmUuLCBmaXJzdCBjYWxs
IHY0bDJfbTJtX2N0eF9yZWxlYXNlKCkgYW5kIG9ubHkNCj5hZnRlcndhcmRzIHJlbGVhc2UgdGhl
IHZwdSBpbnN0YW5jZS4NCj4NCj5JbiBvdGhlciB3b3JkcywgYXJlIHlvdSBqdXN0IGZpeGluZyB0
aGUgc3ltcHRvbSByYXRoZXIgdGhhbiB0aGUgYWN0dWFsIGNhdXNlPw0KPg0KPlJlZ2FyZHMsDQo+
DQo+ICAgICAgICBIYW5zDQo+DQoNCkhpIEhhbnMsDQogICAgSSBhZ3JlZSwNCiAgICBJbiB0aGUg
Zmlyc3QgIEkgaW5kZWVkIGNhbGwgdjRsMl9tMm1fY3R4X3JlbGVhc2UoKSBhbmQgYWZ0ZXJ3YXJk
cyByZWxlYXNlIHRoZSB2cHUgaW5zdGFuY2UsDQpCdXQgdGhlcmUgbWF5IGJlIHNvbWUgcmVkdW5k
YW50IGV2ZW50IHRyaWdnZXJlZCBieSBmaXJtd2FyZS4gQW5kIHRoZXkgbWF5IGxlZCB0byBrZXJu
ZWwgcGFuaWMgYXMgSSBkaWRuJ3QgcHV0IHRoZSB3aG9sZSBldmVudCBoYW5kbGVyIGludG8gdGhl
IGluc3RhbmNlIGxvY2suDQoNCkkganVzdCB0aG91Z2h0IGlmIEkgcmVsZWFzZSB0aGUgbTJtIGN0
eCBpbiByZWxlYXNpbmcgdnB1IGluc3RhbmNlLCB0aGVuIHRodXMgY2FzZSBjYW4gYmUgYXZvaWRl
ZC4gQnV0IGl0J3MgcmVhbGx5IG5vdCB3ZWxsIHRob3VnaHQgb3V0Lg0KDQpJJ2xsIHJldmVydCB0
aGUgcGF0Y2ggIiBtZWRpYTogYW1waGlvbjogcmVsZWFzZSBtMm0gY3R4IHdoZW4gcmVsZWFzaW5n
IHZwdSBpbnN0YW5jZSIsIHRoZW4gY2hlY2sgdGhlIGV2ZW50IGhhbmRsZXIgY2FyZWZ1bGx5IHRv
IG1ha2Ugc3VyZSB0aGVyZSBpcyBubyBpc3N1ZSBpZiB0aGUgbTJtIGN0eCBoYXMgYmVlbiBmaXhl
ZC4NCg0KTWluZw0KDQoNCj4+ICt9DQo+PiArDQo+PiAgaW50IHZwdV92NGwyX2Nsb3NlKHN0cnVj
dCBmaWxlICpmaWxlKSAgew0KPj4gICAgICAgc3RydWN0IHZwdV9kZXYgKnZwdSA9IHZpZGVvX2Ry
dmRhdGEoZmlsZSk7IEBAIC03NzQsNiArNzkxLDcgQEANCj4+IGludCB2cHVfdjRsMl9jbG9zZShz
dHJ1Y3QgZmlsZSAqZmlsZSkNCj4+DQo+PiAgICAgICB2cHVfdHJhY2UodnB1LT5kZXYsICJ0Z2lk
ID0gJWQsIHBpZCA9ICVkLCBpbnN0ID0gJXBcbiIsDQo+PiBpbnN0LT50Z2lkLCBpbnN0LT5waWQs
IGluc3QpOw0KPj4NCj4+ICsgICAgIHZwdV92NGwyX2NoZWNrX2FuZF9jYW5jZWwoZmlsZSwgaW5z
dCk7DQo+PiAgICAgICBjYWxsX3ZvaWRfdm9wKGluc3QsIHJlbGVhc2UpOw0KPj4gICAgICAgdnB1
X2luc3RfdW5yZWdpc3RlcihpbnN0KTsNCj4+ICAgICAgIHZwdV9pbnN0X3B1dChpbnN0KTsNCg0K
