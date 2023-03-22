Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8016E6C5953
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCVWPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:15:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0613.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D20655BE;
        Wed, 22 Mar 2023 15:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0GKzJPUbHeA4Kyp9G0brph5Lpe6Rfwcmk+b/b7sC88d6cK7nGox+XgKpxiblbTw7UeXiS/xAR2VQBh2T8WZ5KR9/iKA6/R8Ia/JeoCvgiHQN8JK8dG2EUXJrl/bNhcND0H8fZs8HMe7zMMlzU9Z3JAJx0cxkYKIczjHp4CFatZsnDVyEYjyPnNlS7BH3FA1aiRDjt05Kn8405uGjm2bc1uTmuKcsO6+cXfNeTt/yAwWhnV5SvIAl4cZYkvpOGYBS1kpXAola6qAqeeNCIYxUAqsxkRpwEBan8yELH+armkE2YBnO/o//XXUJv8tXXlZE4bowXPcWve3TdQhP5oA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJhs3hAqkU4ZQB9vAM4SuxrOaZ2T9X41wwRFmCR9SN0=;
 b=Fh5p8oAAFyAor2JMimd8HUdR8xUzsMlIE55/wgwWBbNl/C2JsRStayq3gHyfOyL631nGSTpqy0jO9OrJn/hjoZJU1veTJf0W1ERx9oGXYAoxLjBmqpMytmbEIsCPNMWYWYhv4UER3HpsHjgXCjpT3MG1YSTzj9/3rkcTcqCg9VF2d0LtX4fQMpr4NkM9Q+08+8wgxJJHJx3/6wFabTAXwshrqwwY/Mbc0gaZGB6fotA9CrkpPgqUhMGMwfQLcpCzuLyRZsQfgJIEURbfLN1FhvcE7r+H9u7BOXTPCP7RMSOewes0daqQP5GX+i/4FcpRMeBMnY5J+ReVpbc5j+mFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJhs3hAqkU4ZQB9vAM4SuxrOaZ2T9X41wwRFmCR9SN0=;
 b=XbN580rzDyjDXRiCIlKrR8/ChNpMnUzKHgXnCeqbDymNh3haQ12vYNrat5IFYYhkpv0FrfTvQV3HjAzP6n5w6IPiGPUpHueAQ8tTHV63y6xz7WMWFD4ck96ew+6hFKLCYBLS15ent+pzpILzKnDMcxbdsfbLyBMuirggC5uFSq0=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 22:15:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 22:15:25 +0000
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
Thread-Index: AQHZXAih0MCX1q8KWEWxpTpi/nrVFq8GaNGAgAByipCAAHgTAIAAAD6AgAABboCAAAA0kIAAAREAgAAAXdCAAAbzAIAAALZw
Date:   Wed, 22 Mar 2023 22:15:25 +0000
Message-ID: <AM6PR04MB483887C7F652AD96F92D002488869@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
 <20230321151951.2784286-2-Frank.Li@nxp.com>
 <1ce3bf91-6bef-b4c1-1ec9-3a345518efeb@linaro.org>
 <AM6PR04MB483828FC1083E3C98930DF6488869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b5d67af0-ed08-e243-2c0c-92f1f002e552@linaro.org>
 <AM6PR04MB483841E17BEEE4F9EC596DBA88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <835cda64-5d42-1ff3-aa8f-0802fe3d705f@linaro.org>
 <AM6PR04MB48383C58EF1D9CFD8F7C401E88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <24767874-0b26-78c8-43c2-6cc3adb901f8@linaro.org>
 <AM6PR04MB4838ECE2917EF132943830EA88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <6cf27e09-af76-34a5-1913-77165866480b@linaro.org>
In-Reply-To: <6cf27e09-af76-34a5-1913-77165866480b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DB8PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: 262adda9-d1a4-4324-d9a5-08db2b22efd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: icagQlXK3QFWc0H/qIOO+vmg9prE4xmVPwed081iMgIjo3aCnut7949m4phL88eIxsxA32Mgse2CnOLQhmqVNMIqv2iwBF1ddVEhDnzEJonWSP8Mf3zFqbNuoch+WG0XSyE6Jq/+BCZfhmdq65TjsvaMBGgWz2ou6ZMskTpr5RcrmB/51dHAOCb88F8mJlD/B2WHVuFVBtHw/FFuPJZZZtzDVs0FOmT0HKvU0CiVBY6KPd8G6GGeUuxzxE9toPtpcqzZcnXtDuy7ZYP26G9U13XwRDvTdEnUQWj/40JBSTQiE+bS9TRXEQUYz3xN4sVZ45wra133zRybjcRQylF3ljrzqbsRS8lg8dzx3zJJsF6PtERDBJ2qEDVk0QsJgeg6jfrIigadSQreLmD4NfakDDgPcP7d5lWQnte5V75b3iDPkA7a2dDDyb9s6oiE6D9YWyAuNZARc+eAcCHWkSJKOXJz3slRr4iUSSl9Ar3g8FXN8bw61dKI+I0sdYji8f/elMuJoDHskp2h+IVSfSf0XxTDRMDZt8dip3K2enlup3Att0A/8Bf/vipEB5+Bwui9g+PAH4Z51LHzS+PfX69Kp/KxQswAzM5Ys4GqIN5TkTcq5uy76Enh9SzziPsKzdnJIdMG55XUjAlK3F8k7cedgRknRUtr2jEbx8ms/pO4mnISAF+7tXocMfL/K2gMz6z93CT0h5lG4Dn6dhGmJzWmY2pEAz3VlB5eDh4ZbAse/T4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(9686003)(186003)(55236004)(53546011)(26005)(55016003)(54906003)(316002)(122000001)(6506007)(83380400001)(38070700005)(7696005)(71200400001)(33656002)(5660300002)(7416002)(4326008)(66946007)(86362001)(66446008)(66556008)(38100700002)(64756008)(76116006)(478600001)(2906002)(8676002)(66476007)(8936002)(41300700001)(52536014)(6916009)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yks0RVVFRTg4K091Wlg0elFYcFlLQ2ZzQWNEc25ZMG5xWjd6NTJVK3NIU1or?=
 =?utf-8?B?YldyV1NldkJNRy9aL1BhNUUxTHkrRGNSQndyNmFROFhzN0NtL0hzSUREbnky?=
 =?utf-8?B?YjR6RWJYMFNTa3daczV1dGFlbEFhSnN5cWpCUk9RVTV5T3RidEtibUpXejB3?=
 =?utf-8?B?YjFEZWRnYlNPTkRMd1lrYjRIRHF2REhkYStyTW5ZY1RkK0JXVUtKTUh2WHly?=
 =?utf-8?B?MEFEcHNXbTVxKzA0Vkk3bkZNU1pxS0pwTXQzdzJLdkV6aVpENUxDaTNOdm93?=
 =?utf-8?B?T0JHem5xSzdhK2VNKzM4Yng1djEzT21Sa2N6Y1pYamR5RjFRV2pYTE4va3ZJ?=
 =?utf-8?B?dWxUM2U2Q3NDTUx2V0ROOUdiWWRpMmMyUjAzQ2V0c0h4aS84MXpTTUo1SlBy?=
 =?utf-8?B?bVAzOTdZTm9vQmt0ZDZXNmc2OG1uYi9JUW1LbG1aM3gzZkl6YXZqU1ZFRGRG?=
 =?utf-8?B?eFJUbnRUUzFLVFZWOWRoNE1LZDBpMjNNemx0NjF1WFByVC8wV0Q5RjdJeXRQ?=
 =?utf-8?B?dkh1Z25CODNpY25BSlliMlAzczU3WUtlL2M5SWZsRDkxWUdPSmdpMDI1dC9L?=
 =?utf-8?B?cHBEWUJkS1IyN0o2cEQvdWNLaHdtdDNpSGNCTi9QQ21KOFUwTlJici9aNDZE?=
 =?utf-8?B?WG4vZmMzZW9na1VGdGkzc3h3dmJDbmgzVFYrL2x4Wk5CZk41Z1R0MElxN2I1?=
 =?utf-8?B?VURBS01qMlI3WGIxMnhoU085Mlp1L2tSb3JDc3hOSXdLWXJmWUVjeklpS0Mr?=
 =?utf-8?B?bFdNdlVqQXROZmIvenEvU1VHSGFUMEZ0WjJzSjloamFYZ0tiSEdSVVNvR3Ux?=
 =?utf-8?B?c21WbUxMV2VQRUxLWm5IWGRiNlVuQ1ZHNXZzSEpVcWtybkh0UTZBUDRRbEIx?=
 =?utf-8?B?QmxlQUN3RDJteUJocjVVZDF4YmRtaVR1VGptYlZtSWtCMVBCL0dRNFZ4MUg5?=
 =?utf-8?B?MkFFd1djNkNETStSeEhFZ2Q1Z0VuSXJ3eUZGSXEzaWpMMkF0UGh2VCtIQnBo?=
 =?utf-8?B?b0lnRGQrRy9lbm5XQXJxemF1RFI2Z1J6b0Z0anBTM2VMK21YakcwZ2U5c2NM?=
 =?utf-8?B?VmIwQWdGcDdXN0Y4TzJ5VHVyeVlmbVhPcnhQQW9kN24wVzYxMjdKZ1ZucWdC?=
 =?utf-8?B?Z0VZYlVNWlFhL0t0RC9Ganp6MWJBcFpvNnR4MEN0a3pWQWlrcno2ZXY4Rmh3?=
 =?utf-8?B?T3VTWVBZbUFsVDQ1VE1mNEVXMEJ0NVZNTDNtUkE2a2RVN3R0ekFSVHlSL1NP?=
 =?utf-8?B?YlNpT0RoSlRPUTNiRjFIQUJSV24vMm10U0RSaWNCNjFoVENiWlNDcnorS2JU?=
 =?utf-8?B?YnlGQ29LU3FhSlNmaUtoZXlCN3lhaEJXUHlHUTF1N3g2dGhSZEVobFBhMCts?=
 =?utf-8?B?VGtPZS9Yamw2UlV1RjdPVkdHbDNDUHlIaDBWMXVmalRseURMb05HUmZQbnJJ?=
 =?utf-8?B?aGtIbmVjTXUvdWlRRk1LQ2xQSXhldks1ZnBqdEhENmNyLzdBdndIcHlNQ0Zk?=
 =?utf-8?B?MW9uVUNTNkN5Q0ZPQVY3TEhRaE5NVE9YWGp2VFlpVkw5ZXNnamxsdmNvMFlX?=
 =?utf-8?B?alpKWml0dDdSaTV2VlRxTytrSjRMUVNXZUdsTnMvZEZIdGRGb0NpR0NUNXRP?=
 =?utf-8?B?RkRXeTZwVDdZWEpWZUpNcXc0dmVVVDVuMUVVanJHUzk0aklnYjlHTTFUU1NJ?=
 =?utf-8?B?YnlmY2xRN09nSlZXaDB6S2orTE5wM2RhaldNOUFVUFJDQTlmakg1aXVuZUNr?=
 =?utf-8?B?M2VvazY5Nkh3Wk9HTTNvUFRYYXZpdjljREIraGVXVUZ2anZUN2pMVGY5Ums5?=
 =?utf-8?B?SW9NTDBsQnBjMWoyNit0bmR5K2lMNVVhUlhaclgwbkZ1d0VNc1p2eFpMZ09G?=
 =?utf-8?B?SHMwN1FYYzBtMXZ0M2tTd0tRdXFlZVFCTEZUTWFCakdhckllT1B5SzB0dXBn?=
 =?utf-8?B?cDZxbk5OVklwMSt1Qnd5aDA0eGJIQnNDZWozdmNRcVgvL0Zwbm1XTFpiSmc5?=
 =?utf-8?B?cEZnVGVDSFkrNGsrbHhoZzUvaTBmYytJTlVSQjNEUEl0a0svc1VEU0NWSGpm?=
 =?utf-8?B?algzK05ZNUVLRjUyalB2Y3B3NWJnRlhZa3RmQ1JvYXM3K05RTmtRNG96Q1F3?=
 =?utf-8?Q?ylSoA2/6NHH9Lx9H7nsM/Kprs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262adda9-d1a4-4324-d9a5-08db2b22efd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 22:15:25.5018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzAOCVNzRuxeFeuan3KbClo63dcPXeRIFTfyKJuqsiADb8ms3ngUXuhVP/DB41HltC7ovM7Rgm/76uxEmYJ7Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE1hcmNoIDIyLCAyMDIzIDU6MDkgUE0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
Pg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGZlc3RldmFtQGdtYWlsLmNvbTsg
aW14QGxpc3RzLmxpbnV4LmRldjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTog
W1BBVENIIHYzIDEvM10gZHQtYmluZGluZ3M6IHVzYjogY2Rucy1pbXg4cW06IGFkZA0KPiBpbXg4
cW0gY2RuczMgZ2x1ZSBiaW5kaW5ncw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBP
biAyMi8wMy8yMDIzIDIyOjU3LCBGcmFuayBMaSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAyMiwgMjAyMyA0OjQzIFBNDQo+ID4+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4N
Cj4gPj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGlteEBsaXN0cy5saW51eC5kZXY7DQo+ID4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsga3J6
eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51eC1hcm0tDQo+ID4+IGtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgbGlu
dXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsNCj4gPj4gc2hhd25ndW9Aa2VybmVsLm9yZw0KPiA+PiBTdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiB1c2I6IGNkbnMt
aW14OHFtOiBhZGQNCj4gPj4gaW14OHFtIGNkbnMzIGdsdWUgYmluZGluZ3MNCj4gPj4NCj4gPj4g
Q2F1dGlvbjogRVhUIEVtYWlsDQo+ID4+DQo+ID4+IE9uIDIyLzAzLzIwMjMgMjI6NDAsIEZyYW5r
IExpIHdyb3RlOg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmc+DQo+ID4+Pj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyMiwgMjAyMyA0OjM4
IFBNDQo+ID4+Pj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiA+Pj4+IENjOiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+PiBpbXhA
bGlzdHMubGludXguZGV2Ow0KPiA+Pj4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51eC1hcm0tDQo+ID4+Pj4ga2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC0N
Cj4gPj4+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4+Pj4gc2hhd25ndW9Aa2VybmVsLm9yZw0KPiA+Pj4+
IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYzIDEvM10gZHQtYmluZGluZ3M6IHVzYjog
Y2Rucy1pbXg4cW06DQo+IGFkZA0KPiA+Pj4+IGlteDhxbSBjZG5zMyBnbHVlIGJpbmRpbmdzDQo+
ID4+Pj4NCj4gPj4+PiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPj4+Pg0KPiA+Pj4+IE9uIDIyLzAz
LzIwMjMgMjI6MzYsIEZyYW5rIExpIHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+Pj4+IEZyb206IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4+Pj4+IFNlbnQ6IFdl
ZG5lc2RheSwgTWFyY2ggMjIsIDIwMjMgNDozMiBQTQ0KPiA+Pj4+Pj4gVG86IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPg0KPiA+Pj4+Pj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4+Pj4gaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gPj4+
Pj4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnOyBsaW51eC0NCj4gYXJtLQ0KPiA+Pj4+Pj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC0NCj4gPj4+Pj4+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPj4gcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsNCj4gPj4+Pj4+IHNoYXduZ3VvQGtlcm5lbC5vcmcNCj4gPj4+Pj4+IFN1
YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYzIDEvM10gZHQtYmluZGluZ3M6IHVzYjogY2Ru
cy1pbXg4cW06DQo+ID4+IGFkZA0KPiA+Pj4+Pj4gaW14OHFtIGNkbnMzIGdsdWUgYmluZGluZ3MN
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBPbiAyMi8wMy8yMDIzIDE1OjM0LCBGcmFuayBMaSB3cm90ZToNCj4gPj4+Pj4+Pg0KPiA+Pj4+
Pj4+DQo+ID4+Pj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+Pj4+IEZy
b206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4N
Cj4gPj4+Pj4+Pj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyMiwgMjAyMyAyOjMyIEFNDQo+ID4+
Pj4+Pj4+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLg0KPiA+Pj4+Pj4+Pj4gKyAgICAgIC0g
Y29uc3Q6IHVzYjNfYWNsaw0KPiA+Pj4+Pj4+Pj4gKyAgICAgIC0gY29uc3Q6IHVzYjNfaXBnX2Ns
aw0KPiA+Pj4+Pj4+Pj4gKyAgICAgIC0gY29uc3Q6IHVzYjNfY29yZV9wY2xrDQo+ID4+Pj4+Pj4+
PiArDQo+ID4+Pj4+Pj4+PiArICBhc3NpZ25lZC1jbG9ja3M6DQo+ID4+Pj4+Pj4+PiArICAgIGl0
ZW1zOg0KPiA+Pj4+Pj4+Pj4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBoYW5kbGUgYW5kIGNsb2Nr
IHNwZWNpZm9lciBvZg0KPiA+Pj4+Pj4+PiBJTVhfU0NfUE1fQ0xLX01TVF9CVVMuDQo+ID4+Pj4+
Pj4+DQo+ID4+Pj4+Pj4+IERyb3AgdXNlbGVzcyBwaWVjZXMgc28gIlBoYW5kbGUgYW5kIGNsb2Nr
IHNwZWNpZm9lciBvZiAiIGFuZA0KPiBuYW1lDQo+ID4+IHRoZQ0KPiA+Pj4+Pj4+PiBoYXJkd2Fy
ZSwgbm90IHRoZSBzeW50YXguDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiArDQo+ID4+Pj4+Pj4+
PiArICBhc3NpZ25lZC1jbG9jay1yYXRlczoNCj4gPj4+Pj4+Pj4+ICsgICAgaXRlbXM6DQo+ID4+
Pj4+Pj4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogU2hvdWxkIGJlIGluIFJhbmdlIDEwMCAtIDYw
MCBNaHouDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFRoYXQncyBiZXR0ZXIgYnV0IEkgc3RpbGwg
ZG8gbm90IHVuZGVyc3RhbmQgd2h5IGRvIHlvdSBuZWVkIGl0IGluDQo+IHRoZQ0KPiA+Pj4+Pj4+
PiBiaW5kaW5ncy4gWW91IG5ldmVyIGFjdHVhbGx5IGFuc3dlcmVkIHRoaXMgcXVlc3Rpb24uDQo+
ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBJIGFtIG5vdCBzdXJlIDEwMCUgc3VyZSB0aGUgcmVhc29uLg0K
PiA+Pj4+Pj4+IEkgdGhpbmsgZGlmZmVyZW5jZSBzeXN0ZW0gdGFyZ2V0J3MgIGF4aSBidXMgZnJl
cXVlbmN5IGlzIGRpZmZlcmVuY2UsDQo+ID4+Pj4+Pj4gQW5kIGp1c3Qgb25lIHRpbWUgd29yaywg
bmVlZG4ndCBzb2Z0d2FyZSB0byBtYW5hZ2UgaXQuDQo+ID4+Pj4+Pj4gRm9sbG93aW5nIG90aGVy
IGRyaXZlcidzIGNvZGUgc3R5bGUgbWF5IGJlIGFub3RoZXIgcmVhc29uLg0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4+IFRoYXQncyB0aGUgcmVhc29uIG9mIGhlYXZpbmcgaXQgaW4gRFRTLiBCdXQgSSBhbSBh
c2tpbmcgYWJvdXQgYmluZGluZ3MuDQo+ID4+Pj4+PiBZb3UgZG8gdW5kZXJzdGFuZCB5b3UgZGVm
aW5lIGhlcmUgaW50ZXJmYWNlPw0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIGRlZmluZWQgaGVyZSBpcyBk
ZXNjcmlwdCBBWEkgZnJlcXVlbmN5IGZvciB1c2IgY29udHJvbGxlci4gU3VwcG9zZWQNCj4gPj4+
PiBkaWZmZXJlbmNlDQo+ID4+Pj4+IFBsYXRmb3JtIHdpbGwgaGF2ZSBkaWZmZXJlbmNlIHdvcmtp
bmcgZnJlcXVlbmN5Lg0KPiA+Pj4+DQo+ID4+Pj4gSSBkb24ndCB1bmRlcnN0YW5kIGhvdyBkb2Vz
IHRoaXMgYW5zd2VyIG15IGNvbmNlcm5zIG9mIGhhdmluZyBpdCBpbiBEVA0KPiA+Pj4+IGJpbmRp
bmdzLiBJZiB5b3UgZG8gbm90IGFkZCBpdCwgeW91ICJ3aWxsIGhhdmUgZGlmZmVyZW5jZSB3b3Jr
aW5nDQo+ID4+Pj4gZnJlcXVlbmN5Iiwgc28gd2hhdCdzIHRoZSBwb2ludD8NCj4gPj4+DQo+ID4+
PiBGb3IgZXhhbXBsZTogaW14OHF4cCwgaXQgbmVlZCBzZXQgdG8gMjUwTWh6LCAgaS5NWDhRTSBu
ZWVkIHNldCB0bw0KPiA+PiAyMDBNaHouDQo+ID4+PiBNYXliZSBmdXR1cmUgY2hpcCBjYW4gc2V0
IHRvIDQwME1oei4NCj4gPj4NCj4gPj4gQW5kPyBTbyBhcyB5b3UgY2FuIHNlZSB5b3Ugd2lsbCBz
dGlsbCBoYXZlIGRpZmZlcmVudCBmcmVxdWVuY2llcywgc28NCj4gPj4gd2hhdCdzIHRoZSBwb2lu
dD8gV2hhdCBpcyB0aGUgYmVuZWZpdD8gRHVubm8sIG1heWJlIHdlIGRvIG5vdA0KPiB1bmRlcnN0
YW5kDQo+ID4+IGVhY2ggb3RoZXIsIGJlY2F1c2UgSSBkb24ndCB0aGluayB5b3UgYXJlIGFuc3dl
cmluZyBteSBxdWVzdGlvbnMgYXQgYWxsLg0KPiA+DQo+ID4gQmVuZWZpdDogTmV3IGNoaXAganVz
dCBuZWVkIGNoYW5nZSBkdHMgZmlsZSBmb3IgdGhlIHNhbWUgSVAsIGxpa2UgY2hhbmdlDQo+IGJh
c2UNCj4gPiBSZWcgYWRkcmVzcyBhbmQgaXJxIG51bWJlci4NCj4gDQo+IFRvIHJlbWluZCAtIHRo
ZSBxdWVzdGlvbiB3YXM6DQo+ICJUaGF0J3MgYmV0dGVyIGJ1dCBJIHN0aWxsIGRvIG5vdCB1bmRl
cnN0YW5kIHdoeSBkbyB5b3UgbmVlZCBpdCBpbiB0aGUNCj4gYmluZGluZ3MuIg0KPiBJZiB5b3Ug
ZHJvcCBpdCBmcm9tIHRoZSBiaW5kaW5ncyB0aGUgYmVuZWZpdCBpcyBzdGlsbCB0aGVyZSwgc28g
d2hhdCBkbw0KPiB5b3Ugd2FudCB0byBwcm92ZT8NCj4gDQo+ID4NCj4gPiBZb3VyIHF1ZXN0aW9u
IGlzOiAgIndoeSBuZWVkIHRoaXMgYXNzaWduZWQtY2xvY2stcmF0ZXMNCj4gSU1YX1NDX1BNX0NM
S19NU1RfQlVTIHByb3BlcnR5PyINCj4gDQo+IFRoaXMgd2FzIHRoZSBwcmV2aW91cyB0aHJlYWQu
IE5vdywgcmVsYXRlZCBidXQgc2xpZ2h0bHkgZGlmZmVyZW50LCB3aHkNCj4gZG8geW91IHN0aWxs
IG5lZWQgaXQgaW4gdGhlIGJpbmRpbmdzPw0KPiANCj4gDQo+ID4gTXkgYW5zd2VyOiBpdCBpcyBv
bmUgb2YgaGFyZHdhcmUgcHJvcGVydHksIGxpa2UgcmVnIGJhc2UgYWRkcmVzcyBhbmQgaXJxDQo+
IG51bWJlci4NCj4gDQo+IFN1cmUsIGl0IGlzLCBJIGtub3csIGFuZCBiaW5kaW5ncyBhbHJlYWR5
IGFsbG93IGl0LiBKdXN0IGxvb2sgYXQgbWFueQ0KPiBEVFMgYW5kIHRoZWlyIGJpbmRpbmdzLiBE
byB5b3Ugc2VlIHRoZSBiaW5kaW5ncyBkZWZpbmluZyB0aGlzIHByb3BlcnR5Pw0KPiBOby4gU28g
d2h5IGRvIHlvdSB0aGluayBpdCBpcyBuZWVkZWQgaGVyZT8gSSBhbSBhc2tpbmcgdGhpcyBzaW5j
ZSBsaWtlIDYNCj4gZW1haWxzIGFuZCB5b3VyIGFuc3dlcnMgYXJlIG5vdCByZWxhdGVkIHRvIGJp
bmRpbmdzIGF0IGFsbC4NCj4gDQo+ID4NCj4gPiBJZiBjYW4ndCBtYXRjaCB5b3VyIGV4cGVjdGF0
aW9uLCBjYW4geW91IGNoYW5nZSBhbm90aGVyIHdvcmRzIG9yIHByb3ZpZGUNCj4gbWUgYW4gZXhh
bXBsZT8NCj4gDQo+IFllYWgsIGp1c3Qgb3BlbiBzZXZlcmFsIERUUyBhbmQgbG9vayBmb3IgYXNz
aWduZWQtY2xvY2ssIHRoZW4gb3BlbiB0aGVpcg0KPiBiaW5kaW5ncyBhbmQgYW5zd2VyIC0gd2h5
IGRvIHlvdSBuZWVkIHRvIGFkZCBpdCB0byB0aGUgYmluZGluZyBidXQgYWxsDQo+IG90aGVyIGJp
bmRpbmdzIGRpZCBub3QgaGF2ZSB0bz8gSWYgeW91IGhhdmUgdGhlIGFuc3dlciwgc3VyZSwgYnJp
bmcNCj4gdGhlc2UgcGFydHMgb2YgYmluZGluZ3MuDQoNCkRvIHlvdSBtZWFucywgTmVlZG4ndCBh
ZGQgYXNzaWduZWQtY2xvY2sgaW4gYmluZGluZyAqZG9jdW1lbnQqIHlhbWwgZmlsZT8NCkFuZCBk
dHMgZmlsZSBzdGlsbCBjYW4gdXNlIGFzc2lnbmVkLWNsb2NrIHByb3BlcnR5LiANCg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
