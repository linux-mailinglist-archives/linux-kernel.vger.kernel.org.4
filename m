Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1068993B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBCMzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjBCMzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:55:53 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2088.outbound.protection.outlook.com [40.107.15.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B89B6EF;
        Fri,  3 Feb 2023 04:55:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDooL0LJaA7dkRUiS63dKDDzC9znKaeA8yfn4IpjKUaJc74hIqsN4sbrY9maBZy/gsJ6ZMbQaQzOCkzLxX7ofScqpqG1zwmB4rXBm4dX/5agqCgsI/cBohr0/Uvz9P4fre4qkIjpu2KS7b671ayxm51+823F1Sldy0kiDlkHlvGfWSfR2qfEFVjDTZauJOcKPWfCq2PCbf0Cgm4SF+iXCXTZTTX+LeUClEiiJLS/8EBMSZOL5KKQUsaPPoAKh0ZoXczVacmEvtWKvoua+0xapLzVq7rBfvJwYytNAh24kgwoTlkYKEq+i3M8fGBJ//697WNEBWitkSqi4SdDRXprdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5NaiRWUfkQ5xvPYgo73QwckEukXji1wLtMS3Zo8jZs=;
 b=ngxuRdPBXvFKYe3HUHQ2EcMwQk1ru+3qsvX9IE/+PHKyxGPRiTsVf0PqnNXUZ5ujGmGnrcDUPq/3Br/HkNdsE0PAI7ucPlyyjnSVkHFLVu0bIfd1I0TRJwHdpHSRNnNX1OBKI2sxw/ZxiCU8ovJrW4Fi1WyS8EiqGsaSPQtsa5Qb/W9PbPtrDEQciyNhvLklvjmMvb/j66OUNnIiFQ9Ix8xxQEFOL7232tDUe2Feqg9RAMisWTCSWK5/i7O2MI2fquy8B3aKlj9i2RKgjlBGosgZWvPcGloOHaTLe9Yx2HU8qCaYinVwrx5lAD3VMhLAraxK+qFQObvhFpokiDWPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5NaiRWUfkQ5xvPYgo73QwckEukXji1wLtMS3Zo8jZs=;
 b=GTTlMg36PZqheHEHiqKpyTQYvPTadsVgsxTAOIwWsi+O850OPDFwlYAFqGd0izsCk994hMNl1M7QIvN1+GoVzCiQD1aE3qstHr5j0KbfKrzxdmtK2YLpnOiTiPByq4062xTZv7vcwzHVq6k+H0PvKhHoJLK0C569elb3WTjr6YA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 3 Feb
 2023 12:55:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Fri, 3 Feb 2023
 12:55:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/6] remoteproc: imx_rproc: support firmware in DDR
Thread-Topic: [PATCH V2 0/6] remoteproc: imx_rproc: support firmware in DDR
Thread-Index: AQHZMjC8eVSH+Ql4bk6j5wi0DyGm+K69N56AgAAA3tA=
Date:   Fri, 3 Feb 2023 12:55:49 +0000
Message-ID: <DU0PR04MB9417C6008B6352F7FB34355F88D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
 <CAEnQRZB4ZLWcz-2jqZ7UDFxc60U9BFu_QuV9AvRYdqvC=Y-zwg@mail.gmail.com>
In-Reply-To: <CAEnQRZB4ZLWcz-2jqZ7UDFxc60U9BFu_QuV9AvRYdqvC=Y-zwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS1PR04MB9359:EE_
x-ms-office365-filtering-correlation-id: 1134907d-14e4-40e7-07d5-08db05e5f977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSVk/9v4TNIBSDhPSmZvcTJXq71FTrQKjdr/gqBPC1ZYtl2wH0s+L8W2rYRgF0fBGMZqgTRlPHxNQvYcqLVVVCxzXa18e5o3MHTahu+oXEllh6qFnHb3k1KNd0pUuKFJRzPRlGV5wzA9bFfUXkK3P8te7pOGmUhUVBHBshhDcf7MaGliv7xdTfDv0AqvNtfvKmTrEq4GH+BQPvEr/jFMPL/QzSt91iKIBIW2VcOAEmE+jG2YYoPTQYqniSLRAC2QLm8XKIoOeXlsVePHuHKPgwofkvOKNUIVhV2kqqf6vnk2mAK/h7J2AdN0l6D9Pr3lSVfXv0GMSUMjhwF84gJ4UhBBAOEXeGuSXMsaagYOO7XolrbKtgLgJnFaAR9of7b8sCq1eC5CkF+FRt6689BlXyUL2ULbXl5xwwVA9Nqqhe9+RSwoyKIidxZ1cKwrqGWB/QT2dvd45aHBUU42FPbJOxuEuz2YlmDX9H4MZjfysCvfmIR7yiOFGcCOJl7MQi4n4w/rxrsOKx3e0qLhAjTbwOs9S7ziJal811F5urFPJ6W5hhOz3/jYpR2cQYGNX6UYXfMSknrRF+xI2LwB1hJ5lvQHNCmYA0Z+4VP1xyYq/EgZlFSEVDSr06/dliWV8RlKQN+LeivZoGNOg1UOrzjVcutxWW2JEGxYCVMqdueF1gczeBRwkKzGFh5tkiFmqYsDH3wIKr7x7u6pdM44WirUWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199018)(33656002)(9686003)(6506007)(478600001)(53546011)(26005)(186003)(110136005)(54906003)(5660300002)(8936002)(316002)(7416002)(71200400001)(52536014)(7696005)(122000001)(8676002)(38100700002)(44832011)(2906002)(41300700001)(55016003)(66446008)(66556008)(64756008)(66476007)(38070700005)(86362001)(4326008)(83380400001)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG5KckFvM3NidmpqQUFSVzBINEQ0dzdRcG1XVTZBaXgyRjJUMjMwSldTYVFr?=
 =?utf-8?B?Vmh3MkJTNU1RelVuMDNVN0Izd01SbW05a0Q4SUxCRjRob21CR2FHbjRjMEVZ?=
 =?utf-8?B?KzFYT2RlcElvWDh5UWsxZjRtWVN3ckZocDVtalN6Z2M0eEdacno4Z0xWOGlX?=
 =?utf-8?B?YUNDNldvUFIwa3FobllWRm1mVlBTL1VBUjllTTdKQTNQNlhoWXBJUTdvb29D?=
 =?utf-8?B?Z2FLa2Vpc0l6OXRHeUltNlRVMmlDL2lYMWxYUmJsY2ZMMklLRFZoK2J3Sy9T?=
 =?utf-8?B?Sk9CT2RVdUdoYXdWQk9mZTYwem1pUzZUNlVyWXprWGJNWEg3Zm1FUWVBUWs3?=
 =?utf-8?B?YVBXQUpUZGpuTFRmRC8yVUJoMnB0VENjem5pYlZWaTRhZW1uN2szQlZkS3pz?=
 =?utf-8?B?SlkrSXB6NytVeTRSU3RwV25FamxlMUR3b0NxQjlybmFhUUw0S2xaM3IrOXFv?=
 =?utf-8?B?bU1aZnI3UXF4S2FXNnZSOXZtK296TmZLOVJ0Q0J1Vnhpc2xTWkM5NnlJQ0xN?=
 =?utf-8?B?d0dJOFBBK3cxdS9wb0tvaDl2cW1wQTl0Q0NZZXA0Q2pqWGFSV20zTWZPdWZR?=
 =?utf-8?B?MmRFbWU5Y0IzMGlUWWV2d1RGSnQzUEYwQkljbEgwUkxQQ1ZWeC9qMTFtcWYz?=
 =?utf-8?B?SkExdXpHb05kcmVDZCtta0UyVjYxWmRuYXY1dFB2ZHI0OWxNcE80RXhMTy8x?=
 =?utf-8?B?c3FTdGJKb05lWmhSU085M3AvWHA0ekZmaWU5Z2dKSU9mM2FCajhhUEcrOW15?=
 =?utf-8?B?TytoMi9CN1JuU3M2My9HeTlzZUpUV0Y5ZFRTNjRHT1ZUem16OWROUnZBZVJh?=
 =?utf-8?B?cWhMc0o2aG1ncmIydWZMRXFRNW1rVXplYjA1RmZkbjdnT3ZTL0ljKzRFVEZJ?=
 =?utf-8?B?b0paSm4zeGtpcE1WclNJdUpGbndlSmpiaGtJRVVHZkRWbUdBLzdhRW9Ddmwy?=
 =?utf-8?B?bCtSZ3BSM09HeEowSW1xYmVIeXh2QzJ0KzBsZUV5U2MrMTl4UmhJV2V1a1l5?=
 =?utf-8?B?RGx0RDEydjBXR0JjUWw2cEJ4VVU3U0R0dTVOVHB6RkRVNDQ0d29DTUNUTW0z?=
 =?utf-8?B?MGN5SkpVQ3ZQMG1SaDlOQTdsMkJKSFY5YmxDWVVrZUJYQTBlSDZ2eXdyZndD?=
 =?utf-8?B?ejdhV2NJakVRdTBXZU1jNEJ6elIzYWFWOEViOW5QckZ3MVlmZUJEYmlVSUlK?=
 =?utf-8?B?Vy9KL1lnZFJuSEtVN0JMVmVlSGd6WWFVSXl5MlVydzNHT0kzam1PMC9OMWtQ?=
 =?utf-8?B?SU10Y2NDSW1CV25LTkZXclByQ3dKTjd4Z2syN052Z3Z4RnFsNTJjZlIvZGNU?=
 =?utf-8?B?UVJzeEsvdjBmc2dhd1M1WWNyT1pMWW1vMWRYdisrQU1CVEhzOHhWeDgvVWc4?=
 =?utf-8?B?ZitiSk1pbVJuZFF4VkZwQnAyRXEzdkw4VEY5K2FtdHJ0YmdYaU5ZdHpUR3Yr?=
 =?utf-8?B?WndFYm1zdHNaR1Zldk0vKys0UmxObnlaZVFGRG9SNXM2bnhrUnd6TURwNnhz?=
 =?utf-8?B?QmtBWlBVdU51ZzMzNFE1QXpTMnBRMG1TWEJ2eEo4UGFQZnBiRHRBbTNBQWlR?=
 =?utf-8?B?RmFmdXhOOUlZVUliOUthcitoMG5YYzk3NVNHdWM3K2FBL3hxYmlHZHBlQ0pQ?=
 =?utf-8?B?YmVxSFU5d0lacnlRbXdkSHFYNFIzN1NDQTkyVEJ0QytheGFSaVI3ZFg1WXBn?=
 =?utf-8?B?bWFiMkZ6dkY4UEs1amFodHk5Q1RFRTBTZU4xOGZnaW5wWkVabzEyRjloM0ZG?=
 =?utf-8?B?ZUNUVDJlT0JBRG9idENlMjhSRzdlS0VZc0NMSHNMZUR3NENUUjBmRXVyb1gx?=
 =?utf-8?B?b0pJYWpFQXpGRzNaMno2Q01IbUdpaURveTRtN0lUY3A5ZzNJL3BKdVM1YmJV?=
 =?utf-8?B?MVdjbzU5dFVjaWFCRmlXcnJSRStNU2diK3BxR0Z6UmpGT3JTMXdOdDdGa09w?=
 =?utf-8?B?dE5HbWoyVHdsZGFBcTlIS01DMTBHWGFrUEpFbElWVVh5T3YzWnkxY0h4c3E0?=
 =?utf-8?B?TWh5MnN0bytqVTBGaWdxVTdpMWV4SlhZeEFRWnJ5U0hnMUJxdTVjRTJJZHkx?=
 =?utf-8?B?aGgrRzFwWHF6MUNMVjRIVzJ1V3o1TS9XZ1dFWG4xNkdReWZVSHVkLzB0SC9s?=
 =?utf-8?Q?9cvc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1134907d-14e4-40e7-07d5-08db05e5f977
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 12:55:49.3395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyN9lLgD6DfIOHjbICqq2h7nf6sHJGzx09qO7RA7HC10taRVFRrJUOJsnqqAwuOn8P6qEmrtvI797jnpVYsUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMC82XSByZW1vdGVwcm9jOiBpbXhf
cnByb2M6IHN1cHBvcnQgZmlybXdhcmUgaW4NCj4gRERSDQo+IA0KPiBPbiBGcmksIEphbiAyNywg
MjAyMyBhdCAxMToyNiBBTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4N
Cj4gPiBWMjoNCj4gPiAgcGF0Y2ggNCBpcyBpbnRyb2R1Y2VkIGZvciBzcGFyc2UgY2hlY2sgd2Fy
bmluZyBmaXgNCj4gPg0KPiA+IFRoaXMgcGFjaHNldCBpcyB0byBzdXBwb3J0IGkuTVg4TSBhbmQg
aS5NWDkzIENvcnRleC1NIGNvcmUgZmlybXdhcmUNCj4gPiBjb3VsZCBiZSBpbiBERFIsIG5vdCBq
dXN0IHRoZSBkZWZhdWx0IFRDTS4NCj4gPg0KPiA+IGkuTVg4TSBuZWVkcyBzdGFjay9wYyB2YWx1
ZSBiZSBzdG9yZWQgaW4gVENNTCBlbnRyeSBhZGRyZXNzWzAsNF0sIHRoZQ0KPiA+IGluaXRpYWwg
dmFsdWUgY291bGQgYmUgZ290IGZyb20gZmlybXdhcmUgZmlyc3Qgc2VjdGlvbiAiLmludGVycnVw
dHMiLg0KPiA+IGkuTVg5MyBpcyBhIGJpdCBkaWZmZXJlbnQsIGl0IGp1c3QgbmVlZHMgdGhlIGFk
ZHJlc3Mgb2YgLmludGVycnVwdHMNCj4gPiBzZWN0aW9uLiBOWFAgU0RLIGFsd2F5cyBoYXMgLmlu
dGVycnVwdHMgc2VjdGlvbi4NCj4gPg0KPiA+IFNvIGZpcnN0IHdlIG5lZWQgZmluZCB0aGUgLmlu
dGVycnVwdHMgc2VjdGlvbiBmcm9tIGZpcm13YXJlLCBzbyBwYXRjaA0KPiA+IDEgaXMgdG8gcmV1
c2UgdGhlIGNvZGUgb2YgZmluZF90YWJsZSB0byBpbnRyb2R1Y2UgYSBuZXcgQVBJDQo+ID4gcnBy
b2NfZWxmX2ZpbmRfc2hkciB0byBmaW5kIHNoZHIsIHRoZSBpdCBjb3VsZCByZXVzZWQgYnkgaS5N
WCBkcml2ZXIuDQo+ID4NCj4gPiBQYXRjaCAyIGlzIGludHJvZHVjZSBkZXZ0eXBlIGZvciBpLk1Y
OE0vOTMNCj4gPg0KPiA+IEFsdGhvdWdoIHBhdGNoIDMgaXMgY29ycmVjdCB0aGUgbWFwcGluZywg
YnV0IHRoaXMgYXJlYSB3YXMgbmV2ZXIgdXNlZA0KPiA+IGJ5IE5YUCBTVyB0ZWFtLCB3ZSBkaXJl
Y3RseSB1c2UgdGhlIEREUiByZWdpb24sIG5vdCB0aGUgYWxpYXMgcmVnaW9uLg0KPiA+IFNpbmNl
IHRoaXMgcGF0Y2hzZXQgaXMgZmlyc3QgdG8gc3VwcG9ydCBmaXJtd2FyZSBpbiBERFIsIG1hcmsg
dGhpcw0KPiA+IHBhdGNoIGFzIGEgZml4IGRvZXMgbm90IG1ha2UgbXVjaCBzZW5zZS4NCj4gPg0K
PiA+IHBhdGNoIDQgYW5kIDUgaXMgc3VwcG9ydCBpLk1YOE0vOTMgZmlybXdhcmUgaW4gRERSIHdp
dGggcGFyc2luZw0KPiA+IC5pbnRlcnJ1cHRzIHNlY3Rpb24uIERldGFpbGVkIGluZm9ybWF0aW9u
IGluIGVhY2ggcGF0Y2ggY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiBQYXRjaGVzIHdlcmUgdGVz
dGVkIG9uIGkuTVg4TVEtRVZLIGkuTVg4TVAtRVZLIGkuTVg5My0xMXgxMS1FVksNCj4gDQo+IEhp
IFBlbmcsDQo+IA0KPiBGZXcgb2JzZXJ2YXRpb25zOg0KPiANCj4gLSBidWdmaXhlcyBzaG91bGQg
Y29tZSBmaXJzdCBpbiB0aGUgc2VyaWVzLg0KPiAtIGluIGNhc2Ugd2Ugd2FudCB0byBwYXRjaGVz
IHRvIGJlIHB1c2hlZCBiYWNrIGludG8gc3RhYmxlIHJlbGVhc2VzIHBsZWFzZQ0KPiBhZGQgIkZp
eGVzOiAiIHRhZy4NCg0KWW91IG1lYW4gcGF0Y2ggNDogc3BhcnNlIHdhcm5pbmcgZml4Pw0KT3Ig
cGF0Y2ggMyBpcyBjb3JyZWN0IHRoZSBtYXBwaW5nPyBPciBib3RoPyBGb3IgcGF0Y2ggMywgSSB3
b3VsZCBub3QgdGFrZQ0KaXQgYXMgZml4LCBJIGp1c3QgdGhpbmsgdGhlcmUgaXMgbm8gcGVvcGxl
IHVzaW5nIHRoaXMgZGRyIGFsaWFzIGFkZHJlc3MuIElmIHlvdQ0KcHJlZmVyLCBJIGNvdWxkIGFk
ZCBhIGZpeCB0YWcgZm9yIHBhdGNoIDMuDQoNClRoYW5rcywNClBlbmcuDQo=
