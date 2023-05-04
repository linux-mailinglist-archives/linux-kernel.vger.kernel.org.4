Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180326F685D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjEDJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjEDJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:34:41 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB27549CB;
        Thu,  4 May 2023 02:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPU6g4shwJDQ7XIOYASrXlRzTqJbYov//+/TtgLTOjb0u3PAEpFX3NwgIU9TnhDiEktiJwRBsSsbWzNDE8bA0cuQoqysr3QE0DyyR7/xw1/TONo+FRoGldZsmXsks1u/s34eb8yYn8AK0JVysjJyGR1+PcC892ySMxT36O4y/JMZK0se3vkrEgQ7YDNpMYLO/FSu+EJ91mEeDUJVNfHaOiJbU+BLBcQpR9lIbymPUKjj8suiL/kMz2ZWFyfZFbifdPw4IMrVhWtWmj/bcQc885uEhBfh2aS0Qob1R9AS7k7HZmFE9qgufMxEATHMzM4pzS3j14U7n+MBusHxp8mFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ3cGLiBdi6WmjZkdwz5/gsvmpkDqLv43fhYnbDiQNE=;
 b=QK6d0TeNGkrhKBtoRHn2HZrzu1qCvf8h+al0iUxdBqSI9HXbVy7JnjD7BeYrIKOh3AjYDCKkj98hWRJVxnqL0zHsFbj3sLM1KBhBxTXOs/TFRGQ+e7BgQinMaEUc1qpzlg4Q5MgCxbTZ8WM1OhCxnnbnM2QQUYAq1pOH1hqVeh3gauiATh7tMBi08TJ7qp3pJa/CFkWa64PkDhpsjxMV5XGa7riHjtE7/C3mFLPlsZm4CXVYMa0IkzbxjIzO+NepF26UfFnXD2q3anZ5u4k2zuwMuQ7RHFcNUg1DGZGkPyYxPXnMP38WuuEoI8SAPGcIHYKDoaqZzV5K3DO5bTfQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ3cGLiBdi6WmjZkdwz5/gsvmpkDqLv43fhYnbDiQNE=;
 b=YF5s/LUQKgeSR646f+/iCFeAbC821A6S0ltewthgY6NHkxS+HYD3LDOgpc36c1vv+UeP50ALGQl7PJ6+YzvNlNL9AJ2wLV27UhYimeXexk1OghHizbcBW4nCGqKx+jDoieqDPxWZS4+qjmVJVeODBif4MNxYLM4cB+I54HDjZGs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9465.eurprd04.prod.outlook.com (2603:10a6:10:359::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Thu, 4 May
 2023 09:34:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 09:34:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg KH <greg@kroah.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Thread-Topic: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Thread-Index: AQHZfmVsUoWhON65f0ewGxlg24Oc/K9J088AgAAAwyCAAATkAIAAAJXA
Date:   Thu, 4 May 2023 09:34:36 +0000
Message-ID: <DU0PR04MB941792F2EF3DB5ADB0B1A75A886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
 <DU0PR04MB9417F9CBB5C9EE1FC85B10A2886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <b09998bc-9ff7-3a18-89af-9778521ab127@linaro.org>
In-Reply-To: <b09998bc-9ff7-3a18-89af-9778521ab127@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9465:EE_
x-ms-office365-filtering-correlation-id: 131ffc7d-7688-4552-a65c-08db4c82c669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aoYH8RMPTEhI3hRmhHeXToF4EDy3Ua/CtVeljIeYyRaOKfH5WPaRNARKg68m29+sYb3L6Qu07dvXY3T5rnfyloHlPqPZw+fePsFU4+XiJQaPUfQ3lihBTTmYA9SgClNg8jmA6cT4pjgv37LXLMvf6aSLpPA9JVLa/Q2EmXvtkWvhrGNVP5g906Ns+L+XMd4TEMOUBitiYIC7NF7TAfjEmX9ss5mAfWliOv36WVSnlUsWR+cL971vEhu+mikV/znxqSXJljDTqJtj6JNf32IrUioy9VCOgaWmIYqOnBr4JEC6fmJ9hWCrgkAfPSVid+DLbYm4X7Q/wx7VWF3LQ/8y657XufLbnzoe+l/hPJO7N2T12Iqg9JTKvdVtSzesSf86EeX12ddBKTmS34TRtcF8z/+Qb8eHu2W7rNp1TlhJTKmPGHizZSl4xQvGk4VTxwcQo3Hq6YWqL0BbOKJspbyewESELi49iPGBx/vCinpZ6Gaw7aSl+KMTLzr2JLtkHKRO5NLVCgnzyc7sfKavRimCIz2I00wjbWtOlXIHA/EDT4Kybw+ehmlKt08ZHJ57k1K6J7aML0t28N2d2iIfbYIxT1yafHzkem1yQaDf0I/Q1R1Uvap4ndlT+4p38usZpNlk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(8676002)(8936002)(122000001)(41300700001)(66476007)(71200400001)(66946007)(64756008)(38070700005)(316002)(33656002)(76116006)(86362001)(4326008)(478600001)(110136005)(38100700002)(54906003)(66446008)(55016003)(66556008)(7696005)(2906002)(44832011)(52536014)(7416002)(53546011)(9686003)(6506007)(186003)(26005)(5660300002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjZrT093c1k4a2EyWmNiK05scnc4eDBBb3J5WDlsbEtkZ0RmZzNsQmgxUVpF?=
 =?utf-8?B?SzdyS3k5Mk1xaVFiRkk0Qy8ya2FGVWYxd0ZhY0lsNFE3djZnVkx2ZWx0ZFVr?=
 =?utf-8?B?dEJSYVRBS0J3QU9FM1k3UUlCNWh1Z3M0a2llS1FXSEFpa0pYMGVqWE1JVWtY?=
 =?utf-8?B?MDVLdFNvNUZXTGNLVDBrN0RSTEVZMWJLWENJSUtFZW1MM0FlekhpbmY3VDlR?=
 =?utf-8?B?ZDBES2MydklsQ0FMcmhUQng3T3MyMVZPdCtHdlZwMUVhOGo1SGhydUFhdmcw?=
 =?utf-8?B?WlBMaVQ2aGxoYlpnYnVnNmJHUHJ0UEprbGRyTHBiY0I3ck5JeDhGY3lCdUJr?=
 =?utf-8?B?TGdPZ2ozdnJZdnQ5a3RmUzFNeDdneWdvSXlsU3BvL3l6T2RubzRCVkFGd3ds?=
 =?utf-8?B?SHNtK2tPa0svQWU1WmhYYzBCbmJHeklEb2M2eTh1djMzNUszQ1AxcXdEaVdQ?=
 =?utf-8?B?TGVBRFRHRm03Yk1xbFRBcTgwZk5WNE5qblFwYUN3eVVZd2dVUWpjWTlidGdQ?=
 =?utf-8?B?Mm1LSEhLZWtrQ2lzcTlkMkhaRE1VYWIzdXlyaG1FamZXVEZhUVl2N1k0ZmFP?=
 =?utf-8?B?SXEvWWQyNVB0dGRjVWh4SGpkbmtDaVpIYXpCK3BlU21SRXlMTXQrSE1vZmM5?=
 =?utf-8?B?eWZhbXNuRWRnQ0gyM3p4MVo0cmdxdlJoc0p5bjhFalE5S3VhOGZuQnl4c1Mz?=
 =?utf-8?B?QW1ldEcwbHYrelZGMGlSWTNac0dadFRGMUJQcTNpWHNpTUc0SmxteHUwMkNG?=
 =?utf-8?B?ZHV2Vm5ta200c2RIT3dwbmsvQk1QNjNvQTYrbkZ5bWJzZDdTNHI3bnlyY2JS?=
 =?utf-8?B?aHFpTDJWSUpXYTJLWThmOW5JRmtjeWtuT0ZncXl6aDVwTFNWVGpseTViWXo0?=
 =?utf-8?B?WFg1T3dBOVFXVDhzdlVsa0VjWFRMT1YrakN6VXhmZkRPdnhyRC8zSDF4UWRC?=
 =?utf-8?B?N3pKV0lTN3FEdzhOYlFaTVJMa012UTJuU2t2SnZlWFFoY0ZmR1FMRDA0Y1A5?=
 =?utf-8?B?Z1FCR3ZWbUhSR3l4UmdEOWp0ZmFSL0E2QmdCREpweHRjd2g5MzdWYU5IM3dk?=
 =?utf-8?B?QnJ5amp5Ty9kQ0ZIQlBUellySUpiYVdVQXlYU2dhMUxXMWcxaGFydHFZRmF3?=
 =?utf-8?B?Nlk1dlNpYSs4UElJYnRkRHVEdUpXQmtoNzc0OTZWeGovUU9NNSthbythblZD?=
 =?utf-8?B?eEJGVzU2VGdnb2FmdHlySE96MTMvaFY4OVE5aHRUY3ZNdFVNRFVQQjVqREY3?=
 =?utf-8?B?S2Z5clpLbDBxQU5GdldtMXZJNVNIMTdxZ2ErS0ZsRDhLZEJXeVdCYWx2S3BV?=
 =?utf-8?B?T3FlTS9MazZKWTZUR1RvNzZwNktSK0x5Z29ZN1BHaFJxbmRFRC9rcFpMV29n?=
 =?utf-8?B?Rys1eW1jcURVYXpLcGFWOWdtY2dkTDUrbXJJcHZ0RXcxcll4MDU5Y1F6Q1pm?=
 =?utf-8?B?UFJWOGJRMnYxa0JMZWh5cG90WVBqbHVvQVZEc3Q2cEt1dm5vWkM4MkdzRE5h?=
 =?utf-8?B?TXg4QjFYRmlDN21ocHdLVlZwV0wwUGNadGpxQTFuOEdQTEkzSER6R1lYWjM5?=
 =?utf-8?B?ZlRUdmZGR28ra016bnF4ZytMYXI0R1RTbGEyWHQyQzFBMlVxclZlcnYvY2Jt?=
 =?utf-8?B?QXVaSXZxUUI2L1IvZEdpcEw2Q0JVRzRmK2oxVzQ2cEhJSWJzZThPNFF2UHZR?=
 =?utf-8?B?ZFYzR3R2V3JBWlZxcndwSjdZRnk3aEdFbnBIOVdKT016bTRkOVJPQ2YwcmRq?=
 =?utf-8?B?K1BUdjNTbE9OYmFwb1pSVHdiQ2o5MU9GbjMrVkF6a1oxamY5UW9zNm9JZjdP?=
 =?utf-8?B?M2l0Z0k2MGxkbmN3SHZnbVI4VnlkbUx1U1Eya1VxaW1zbjBBUHlZOFFTMHN2?=
 =?utf-8?B?a1NzQjBuOEpqWGVxMGlJQkJobEtBT0taS0ZRMW8yREtzT0tOaTlYbVR0WmZm?=
 =?utf-8?B?d3dTWnd4YWxtSGxlR3RzR2M5bXRleVZ1OGJoVGltRkhCdG1WVVdVaUNKQW5F?=
 =?utf-8?B?RWE3Ny80Nk5LdkRKbWxwRzdadWZDaHFsM3NOallUeHhwVW4wUFVRV2cwTERH?=
 =?utf-8?B?OVJLYU41ZmNjck4ySmdUNGNSZHErS2pvQTJvOVNEbUI1bG5QUUhCVSt3U1Uv?=
 =?utf-8?Q?3XQE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131ffc7d-7688-4552-a65c-08db4c82c669
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 09:34:36.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THug8kYPxaqfRiAkZ+VOtP8Lw+Kg7Ap9P1B5D13R9vaqxU3qV4OoGhQLhGBVGUDm7XShEeVbWBw5IzbtemB5AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9465
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDIz5bm0Neac
iDTml6UgMTc6MzENCj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgR3JlZyBLSCA8
Z3JlZ0Brcm9haC5jb20+OyBQZW5nIEZhbg0KPiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+
OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4ga3J6eXN6dG9mLmtvemxvd3Nr
aStkdEBsaW5hcm8ub3JnDQo+IENjOiBhYmVsdmVzYUBrZXJuZWwub3JnOyBtdHVycXVldHRlQGJh
eWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBn
bWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC0NCj4gY2xr
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBj
bGs6IGlteDogaW14OTM6IGludHJvZHVjZSBjbGtfYnlwYXNzZWQgbW9kdWxlDQo+IHBhcmFtZXRl
cg0KPiANCj4gT24gMDQvMDUvMjAyMyAxMToxNywgUGVuZyBGYW4gd3JvdGU6DQo+ID4gKyBEVCBt
YWludGFpbmVycy4NCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDogaW14
OTM6IGludHJvZHVjZSBjbGtfYnlwYXNzZWQgbW9kdWxlDQo+ID4+IHBhcmFtZXRlcg0KPiA+Pg0K
PiA+PiBPbiBUaHUsIE1heSAwNCwgMjAyMyBhdCAwNDo1NTowNlBNICswODAwLCBQZW5nIEZhbiAo
T1NTKSB3cm90ZToNCj4gPj4+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+
Pj4NCj4gPj4+IFdpdGggdGhlIGNsayBuYW1lcyBzcGVjaWZpZWQgaW4gY2xrX2J5cGFzc2VkIG1v
ZHVsZSBwYXJhbWV0ZXIsIGdpdmUNCj4gPj4+IHVzZXIgYW4gb3B0aW9uIHRvIGJ5cGFzcyB0aGUg
Y2xrIGZyb20gbWFuYWdpbmcgdGhlbSBieSBMaW51eCBrZXJuZWwuDQo+ID4+DQo+ID4+IEFzIEkg
c2FpZCBvbiBhbm90aGVyIGVtYWlsLCBubywgcGxlYXNlIGRvIG5vdCBhZGQgbmV3IG1vZHVsZQ0K
PiA+PiBwYXJhbWV0ZXJzIGZvciBkcml2ZXJzLCB0aGlzIGlzIG5vdCB0aGUgMTk5MHMNCj4gPg0K
PiA+IG9rLCBidXQgdGhpcyBpcyBmb3IgYm9vdCwgc28gb25seSBEVCBjb3VsZCBiZSBjb25zaWRl
cmVkLg0KPiA+DQo+ID4gQnV0IERUIGlzIHRvIGRlc2NyaWJlIGhhcmR3YXJlLCBoZXJlIEkganVz
dCB3YW5uYSBnaXZlIHVzZXIgYW4gb3B0aW9uDQo+ID4gdG8gYnlwYXNzIHNvbWUgY2xvY2tzLiBJ
cyBpdCBvayB0byBhZGQgYSBEVCBwcm9wZXJ0eSBzYXlpbmcNCj4gPiAiZnNsLGlteDkzLWJ5cGFz
cy1jbGtzID0gPElNWDkzX0NMS19YPiwgPElNWDkzX0NMS19ZPiIgPw0KPiA+DQo+IA0KPiBJIGRv
bid0IGtub3cgd2hhdCBpdCBpcyB0byAiYnlwYXNzIHNvbWUgY2xvY2tzIi4gVGhpcyBkb2VzIG5v
dCBsb29rIGxpa2UNCj4gcGFyYW1ldGVyIGZvciBzeXN0ZW0gYXQgYWxsLg0KDQpDdXJyZW50bHkg
dGhlIGxpbnV4IGNsayBkcml2ZXIgcmVnaXN0ZXJzIGFsbCB0aGUgY2xvY2tzIGFuZCBtYW5hZ2Ug
dGhlbS4NCkJ1dCB3aGVuIE0zMyBpcyBydW5uaW5nLCBNMzMgbWF5IG5vdCB3YW5uYSBsaW51eCB0
byBtYW5hZ2UNCnNvbWUgY2xvY2tzIE0zMyBpcyB1c2luZy4gU28gSSB3YW5uYSBsaW51eCBub3Qg
cmVnaXN0ZXIgdGhvc2UgY2xvY2tzDQp0aGF0IE0zMyB3aWxsIHVzZS4NCg0KVGhhbmtzLA0KUGVu
Zy4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
