Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209C46A3E05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjB0JOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjB0JOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:14:01 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1911E2B4;
        Mon, 27 Feb 2023 01:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVwlFjEz8q8QqRvrW88znAzvvB0ZpHEAgn3tqrSAsF9qxNDYh/hZP7gwBUsnYe4A+O+KwWm+77CVifthrKgqw9crhGtYe35rwNl0NfjWx5FAH3malJzyKzjOEg9VkhY333HYURiJbxOKBFNg3WwJkA1IbmhWTiyJQXQyCftIcPcyswxlwphlKQBx7g7NxFPNWRWvMRUmkLC8t7j8UvKuWd1gUZHTjMutnRhQdmW2rWytCjbCFkZklClP2l59uopQD/no6R+kYsv8XyJ3IdIA0OHpN81kaER2lNTRllEpUL6WCNBXnWAxb1hqb8m/mkc4D8uq5Y/oA65NYaApLDvCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7HQzS6DSCzDuU2qNalmsMljGac0CEjOT8BuUmN9X2U=;
 b=WsPx+NA8/1807jof+DAnOaYB0hHDk/2XBmDDbSoEdzcZai/BxBwUAU3AN0abYP27fnIo7zoqF0WKxtFqZh7PadcwDze+w4iOrDnUBKbFO/g8T/WFYeiYNGXCBFrsRReGe3E6uRp39fIgT89Pw6KXqQbbD2d2Uu7uBJN3epup2eqWWqPlHCgjJpd0ATchr+8la60iytoVSgqHoeF9QLSCgWKRUFoVRIKA5CUsv+6Hp74+NzGJun+83TCPsOn0PBmmbRICgevRaPSLgDKHXbJY8brjJbQXefo/geipyAFWNIb2QXGo1XFJe6xl/x1LlOCbIcDmyHiJsGWegcucyiD/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7HQzS6DSCzDuU2qNalmsMljGac0CEjOT8BuUmN9X2U=;
 b=M2DSv4AeLBh2QRUatWQZvef51JI2L6kvnI6Hlzi+a2MmYQmiBmEOA0Dl4E7VOh1zN8XA5XWpVTMIqJ+dd7F4Sbg7s2sgbKOE7OG/WOSCEOR/ce0o/OicHJOiKKIQFSuaoJQS5iCJSdqmFBDHvxZKyDK2ua8RFUDeANR0moZBsn0=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 09:06:47 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8562:affc:e0c:c610%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 09:06:47 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: Re: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to
 specify power up sequency time
Thread-Topic: Re: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to
 specify power up sequency time
Thread-Index: AQHZSorRbtnQdMRALUOohjz4HQoshQ==
Date:   Mon, 27 Feb 2023 09:06:47 +0000
Message-ID: <VI1PR04MB4222908B024D8991360EB04DE3AF9@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-2-chancel.liu@nxp.com>
 <506f92cd-7cf5-4fd5-a930-9af086732f84@linaro.org>
 <VI1PR04MB42221B1708BA02B1FA2149D9E3A89@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <c4ee1a7b-a500-5fa5-6a97-93b1eba2c852@linaro.org>
In-Reply-To: <c4ee1a7b-a500-5fa5-6a97-93b1eba2c852@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB4222:EE_|AM8PR04MB7425:EE_
x-ms-office365-filtering-correlation-id: dc3d9299-47fe-45fb-c58d-08db18a1f459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qe3NYqgETFnrqIs461sQCxxWz77OAPJ/+RVxEwWrIriFgP4XhwHi0ZtCTeEPrNKJyVVZE9pqlttJ2InFD+IVgY5h189prxnMIs5KnIam4EpDknjXYQ9UDMBJZfQzTl4aiYzaFto8sZQeu7f7N/hlC8oyCgwZkX0XXHj9wo1LVDq/KPg5MGOPi5dZfNszQDTAlAbrWYCFD4RXGkM0hklFYmTI6thaAPtzgfgG2sKCVYzKnaXenVhwa9y2eBN+KQqQkND6FFEj4XSds11Ej4yLx7W/YbWPAoqd5M+NxET/JGatSsAz3C+RtyvUSfvnYgfddwBhin5OlP+S3HjvEjZiXM1rtniecNOkFo8wX6vZqMuqwcAkla1P8z9TFFKOVp6+unDA2OePLsOliYJt1m0TRwrLGt3GRPSF0XAcdpwqtoeeZLQ97TcK9nju2bzqJrfIe7IzkxXzuHJnyHQQ0QzB4JGC2bFm70YJ8QDzPZZIiVg+QUOZikCCgIe9OKVNgnvd0zzfea0fxRLdxxfip4QOwsZqlX+Eg9Y/doSQeMnlsqOXWV/wj24ZcsQsQ22HZXMuQ4rawHxbIPkYdd8O1MdNRb178gKCjwKhSi34rAXlNdYMtYsQzyaNtzR4qG0JWyteV+ba9DQHoN/2dIVmB8Buh9aYN4b8h0UeaWBbQ9czgR+00vvFoXDnxtGQ12c6HJt+cxXea/RbnzaE7tKegTshJpksMQ9TheR7IXG4FbyJHBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199018)(33656002)(316002)(110136005)(478600001)(71200400001)(5660300002)(7416002)(52536014)(8936002)(7696005)(2906002)(66476007)(76116006)(64756008)(66946007)(66556008)(66446008)(8676002)(44832011)(41300700001)(122000001)(921005)(86362001)(55016003)(38100700002)(186003)(26005)(9686003)(6506007)(53546011)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmVITzNRcXdXcGVKVFdpNUxOeUcwM1VGeldibE5DeklyQmNuOVNKNnJ5QUli?=
 =?utf-8?B?MnRzK04wUWV2VUdZRG95YkVXdWFHS3ZjMnNDM0Nzb0p5SDRVR2cweXZEWHF3?=
 =?utf-8?B?cUdwajBXWno0enZsL0k0M29tdDh6aDRYMnErRzJ4SjdXUmFRSy9OaTBPNkR0?=
 =?utf-8?B?MFgvS1F4aXVVbm1FSTNBTldkQVdPd0tLYmg5ZENRK0RHK3VTWU5UWEZ5RUtx?=
 =?utf-8?B?NXJzZU9lYVRaSFRqaWhTQ3BybjV1UUhzNVVGZHhWMTZicHM5UHVZbjVEM2tn?=
 =?utf-8?B?RFNlRGJzUmhLa1JxZzNCZkFsSmxnNlgyc2JZdEF5TElBUkxtSDVROVpxaXRD?=
 =?utf-8?B?TkRvMmVHTUNKUlBtb3hrUHl3TWxGcTJrUzNXdWQrblQzU01lbUZsYk0xeU8y?=
 =?utf-8?B?WDRMaXdYZG5DclJGUEdNcjE1cCs3bzh1cHkya2VKMWtVcDk4U0diZlFCT2FM?=
 =?utf-8?B?MVdqSkp6YndlODhEMXpHVWtLckFtTXJOTHhOTys0cVIvWjVVZURXUWlSOGFy?=
 =?utf-8?B?amEvWUQzUkRyQkgvRUxpdFpZcVRvSXFBbGNUTkRQSlp2Z29kbEo1M3dmcmxQ?=
 =?utf-8?B?a2tlamFGWm82ZzRBM085ZDcxbktJRXVoTjdYeVpaZUZ6c1I0S1ZzeUdrN3Nq?=
 =?utf-8?B?THRLLzhORko0bW9Jejhhdkw4VG1MdTdnNGk5Q1g1L1E3cUM4dTJQK3FlcDlY?=
 =?utf-8?B?Nm04WGxwdzk0WWhoSlhOUThTcGozQ3EyMmlpSlU5SzA3S2ZydnBGTFhjRG1z?=
 =?utf-8?B?elRWMWp2MjFTb0p6TnVDSVdXSENJQk9BZlVBZXAyem92UzV1SU9RMjFaUnpM?=
 =?utf-8?B?dURRaWF2dUR2Vk9MOGd1MGlCNzcxQjdSdFVNMlBiZmVlQzZvVE1sTGVILzdk?=
 =?utf-8?B?bWtXNUJNbGUySTY0WStXaWUwaHJ1Wm54OE9EWmpRZU9FNU9iM25aUUZiUnhQ?=
 =?utf-8?B?Q3BmOVBHVlZSbWdzRVRsT2ZHNEZ5aXU0U1g1M3RsczVJSFZOMXp1WHJxMndF?=
 =?utf-8?B?VzVnQlFCbzU3ZEdCTE9IVWVTQjFBRFZrUlUwcEJxUWhNaVF5WnZOR0VWSE9q?=
 =?utf-8?B?UXQrSW50Y2tZcVFGMnl4NXBMeEc2SERSbE1FV1phaCtraGJCUnNkVXYzUVFi?=
 =?utf-8?B?akw3ZElaQ0xmeElMZEZRZWVTT0F3UEhPUE9uKzFSSWtKdE5lK3lROTFGZnBW?=
 =?utf-8?B?bTJPWS9QY0lHSGNmdmthSExHM1hsV3lFMzhKSUJRNElRV0d1RUlyTXdSZ0Nr?=
 =?utf-8?B?Sjd2WVIyN2dBVUJBWmVFeEF5YjQ2ejkrTDZoQ0NqMEpDRU1RTHBESndkMExz?=
 =?utf-8?B?NG1GQ2RtYnlqMkZhcVBYZ0lzU3hXWFZsYWNBdlMwaktVVlY1WE00WElHWU51?=
 =?utf-8?B?S1FwMmFwWGZaZEdaMHBLTU04QzM3TFpaSnhpY2dyc2RQYVdqNHpBVFRjWUJ0?=
 =?utf-8?B?eWpxdHQxZFQyTXpqT0tYNVloNFhETDZDQWVEMjVGanQwQ2ZERkpueE1iUzh6?=
 =?utf-8?B?emFMMVQ4aHlhRXNrcm9LU1FCajhDMGRlOVUyWGx5SDg1V0laVUprMVhiZW5j?=
 =?utf-8?B?Q2pXdGpHRWFCV3VnSnF0ajNNMkpRY25PNkw5VWZwUkdkZDlVYVVJaUt4U3A5?=
 =?utf-8?B?dVF4Tk9xZktwRG1oT1c4UHJBZDNIZlZMNnJ3cDBveUpnamZtYzBmaU9IWCts?=
 =?utf-8?B?c3hHeVBuZTZ0SVZZSkxsUEpJNTdhVXV6UUZDYzJ1Vkt3SFVOOVAvSDRRdUFx?=
 =?utf-8?B?VWJUOVJnc2Z1TkVyQ0hMUTdmTHZrc1d2bHpkM2Jrb3dvWlVjMCs0Y0hHY3Ay?=
 =?utf-8?B?TkQ0eEhNdGhMaEE4aGtZQ2lwNHNuK1BMN1V5THBCZjVRTHF6TEtyVHRzZXVI?=
 =?utf-8?B?WldJbDBWcmNCdW15c09Rc2M0Y3VudzI5TVRTY2E3OG1CVDBKRTczS0w5Vndm?=
 =?utf-8?B?dDNwZUVjaGRYejhQa2U3aWhtVk44T2REZG0yMVk2K09GekZKOE94cXlrSVln?=
 =?utf-8?B?UDZnS2k2eEVKaTZlNGFYbWU0ZWlzMC9SNXlaMWM2V3ZGdmQ5RTNISUI5Qyta?=
 =?utf-8?B?Skgrc2V3cndaSGhTaThoQVQzdTFmYzlOYWFjWHpaelJCdDNoTzBQT1ZLL3B3?=
 =?utf-8?Q?IpzKGso0xNwJrh/c7oxgov36D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3d9299-47fe-45fb-c58d-08db18a1f459
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 09:06:47.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAYW6FezAIIFbWNU2abk42PdDFWHcGVsUOX0f5oPqT691UD6qDEX//3XVBH+aBQaVfvnA9npYOfZzNTr60oO2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyNC8wMi8yMDIzIDExOjU0LCBDaGFuY2VsIExpdSB3cm90ZToNCj4gPj4gT24gMjIvMDIv
MjAyMyAxMjozOSwgQ2hhbmNlbCBMaXUgd3JvdGU6DQo+ID4+PiBUaGlzIHByb3BlcnR5IHNwZWNp
ZmllcyBwb3dlciB1cCB0byBhdWRpbyBvdXQgdGltZS4gSXQncyBuZWNlc3NhcnkNCj4gPj4+IGJl
YWNhdXNlIHRoaXMgZGV2aWNlIGhhcyB0byB3YWl0IHNvbWUgdGltZSBiZWZvcmUgcmVhZHkgdG8g
b3V0cHV0IGF1ZGlvDQo+ID4+DQo+ID4+IHR5cG8uLi4gcnVuIHNwZWxsY2hlY2ssIGFsc28gb24g
dGhlIHN1YmplY3QNCj4gPj4NCj4gPj4+IGFmdGVyIE1DTEssIEJDTEsgYW5kIE1VVEU9MSBhcmUg
ZW5hYmxlZC4gRm9yIG1vcmUgZGV0YWlscyBhYm91dCB0aGUNCj4gPj4+IHRpbWluZyBjb25zdHJh
aW50cywgcGxlYXNlIHJlZmVyIHRvIFdUTjAzMDIgb24NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gU2ln
bmVkLW9mZi1ieTogQ2hhbmNlbCBMaXUgPGNoYW5jZWwubGl1QG54cC5jb20+DQo+ID4+PiAtLS0N
Cj4gPj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC93bGYsd204NTI0LnlhbWwgICAg
ICAgICAgfCAxMA0KPiA+PiArKysrKysrKysrDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL3dsZix3bTg1MjQueWFtbA0KPiA+PiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC93bGYsd204NTI0LnlhbWwNCj4gPj4+IGluZGV4
IDA5YzU0Y2M3ZGU5NS4uNTRiNGRhNTQ3MGU0IDEwMDY0NA0KPiA+Pj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3dsZix3bTg1MjQueWFtbA0KPiA+Pj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3dsZix3bTg1MjQueWFt
bA0KPiA+Pj4gQEAgLTIxLDYgKzIxLDE1IEBAIHByb3BlcnRpZXM6DQo+ID4+PiAgICAgIGRlc2Ny
aXB0aW9uOg0KPiA+Pj4gICAgICAgIGEgR1BJTyBzcGVjIGZvciB0aGUgTVVURSBwaW4uDQo+ID4+
Pg0KPiA+Pj4gKyAgd2xmLHBvd2VyLXVwLWRlbGF5LW1zOg0KPiA+Pj4gKyAgICBtYXhpbXVtOiAx
NTAwDQo+ID4+DQo+ID4+IG1heGltdW0gaXMgMTAwMy4gV2hlcmUgZG8geW91IHNlZSAxNTAwPw0K
PiA+Pg0KPiA+PiBtaW5pbXVtOiA4Mg0KPiA+Pg0KPiA+DQo+ID4gWWVzLCB5b3UgYXJlIGFic29s
dXRlbHkgcmlnaHQuIEZyb20gdGhlIHBvd2VyIHVwIHRvIGF1ZGlvIG91dCB0aW1pbmcgdGFibGUg
aW4NCj4gPiBXVE4wMzAyLCB0aGUgbWluaW11bSBudW1iZXIgaXMgODIgYW5kIHRoZSBtYXhpbXVt
IGlzIDEwMDMuDQo+ID4NCj4gPiBDb25zaWRlciB0aGUgZm9sbG93aW5nIHBvc3NpYmlsaXRpZXM6
DQo+ID4gMS4gVGhlc2UgdGltaW5ncyBtYXkgZGVwZW5kIG9uIHRoZSBzeXN0ZW0gZGVzaWduDQo+
ID4gMi4gVGhlc2UgdGltaW5ncyBtYXkgYmUgc2ltdWxhdGVkIHJlc3VsdHMNCj4gPiAzLiBUaGVz
ZSB0aW1pbmdzIG1heSBiZSB0aGUgbWluaW11bSB2YWx1ZXMNCj4gPg0KPiA+IEkgc2V0IGEgbGFy
Z2VyIHZhbHVlIHRyeWluZyB0byBleHRlbmQgdGhlIHRpbWUuIFRoZSBsYXJnZXIgdmFsdWUgb2Yg
Y291cnNlDQo+ID4gaW50cm9kdWNlcyB1bndhbnRlZCB0aW1lIGRlbGF5IGJ1dCBpdCBiZW5lZml0
cyBvbiBhdm9pZGluZyBiZWdpbm5pbmcgYXVkaW8NCj4gPiBsb3N0Lg0KPiA+DQo+ID4gSSBhbHNv
IGRpZCBzb21lIHRlc3RzIG9uIGEgYm9hcmQuIElmIEkgd2FudCB0byB3b3JrIG9uIDQ4S0haIHNh
bXBsZSByYXRlIGFuZA0KPiA+IDUxMkZTLCB0aGUgcmVjb21tZW5kZWQgdmFsdWUgaXMgMTQzLiBC
dXQgdGhlIHRlc3QgcmVzdWx0IHNob3dlZCAxNDNtcyBpcyBub3QNCj4gPiBlbm91Z2guIEkgaW5j
cmVhc2VkIHRoZSB2YWx1ZSB0byA1MDBtcyBhbmQgY291bGQgaGVhciB0aGUgYmVnaW5uaW5nIHNv
dW5kLg0KPiANCj4gTWF5YmUgeW91IG1pc3MgcHJvcGVyIHJlZ3VsYXRvciByYW1wLXVwPw0KPiAN
Cj4gPg0KPiA+IE1heWJlIGl0J3MgYSBiZXR0ZXIgY2hvaWNlIHRvIGxldCBEVCBzZXQgdGhlIHN1
aXRhYmxlIHZhbHVlPyBJcyB0aGVyZSBhIHNpbWlsYXINCj4gPiBzaXR1YXRpb24gYmVmb3JlPw0K
PiANCj4gVGhhdCdzIG5vdCByZWFsbHkgZ29vZCBhcmd1bWVudC4gRFQgc2hvdWxkIGRlc2NyaWJl
IGhhcmR3YXJlIGFuZCBpZiB0aGlzDQo+IHByb3BlcnR5IGRvZXMgbm90IG1hdGNoIGhhcmR3YXJl
LCBpdCBtZWFucyB5b3UgbWl4IHRoaXMgd2l0aCBzb21ldGhpbmcNCj4gZWxzZS4gU29tZXRoaW5n
IG5vdCBmb3IgRFQuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KT0su
IFRoZSBwYXRjaGVzIGZvciBhZGRpbmcgc3VjaCBwcm9wZXJ0eSBhcmUgbm90IHJlYWxseSBnb29k
LiBJIG5lZWQgdG8gZmluZCBhDQpiZXR0ZXIgd2F5IHRvIGFkZHJlc3MgdGhlIGlzc3VlLg0KDQpJ
IHRoaW5rIFBBVENIIDEgYW5kIFBBVENIIDMgY2FuIGJlIGtlcHQuIFNvIEkgd2lsbCBtb2RpZnkg
dGhlbSBhY2NvcmRpbmcNCmNvbW1lbnRzLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3LiBU
aGF0IGJlbmVmaXRzIG1lIGEgbG90Lg0KDQpSZWdhcmRzLCANCkNoYW5jZWwgTGl1DQo=
