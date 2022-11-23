Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00E5634D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiKWCFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiKWCFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:05:04 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2075.outbound.protection.outlook.com [40.107.249.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C748D4B9;
        Tue, 22 Nov 2022 18:05:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/1YwI2Bn31A6V4eZ9zaxOm2C+Vaw+Sc+WVzdyduxmFJ2PRWUILKHM3p8SJ1wceHA2H3s7eJkQdRDdsJhwscmy1fJQnbjtH5ZjmtQWAaL4NHmtWx1Er/H9BDp/JYqYoHHxUSujWI3D15MHd7+hzbUd0C4unjMCq+JhgMUKrv+WkWqziSw0fhFOze8lgfszoGy5XDCDSPpdo4oEMiBpm0xqq0QGewwpQTxqZIlIrQXWnHRHYPK31FvHjDeJdeExmogLTX3OV7/0j8n4U/7y/uFOnJEsjyj6fq9TVoMyc/uv9iTjQyU/tYtOmSIOWISaghhGlmwAnJCbfTJ9QASiRB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INfG44MgXHoM37WVGPDS0I/v21/koS9XIk832EqbPgY=;
 b=KIuYBBrbFmejjSsmvKv0TBSSSPfJ55mZANFGCmDpZYF0OgvoJpueXXxRwv1rxsYiZQkBdeGAbvpjWPQ8JXvP2t5Ru4wwvRm4GDUcMAC3aX9RfIFk/gJsjkYwcWCpHUCCz8GQ0vDWazTCjsuZ+s8mQ4knqQvqimRqXeKYcXaHNm6zPUonuEkF3iyWbKlAn3MoBWrsE9d0sGbpqbrPMO2R3Sf2OTscjnS63UBxK2EQ7jR4qgCiQQkWTIZqWL9i/PUtLvi5iDt+7LruQyxrVOcLsCc9hkI3ootZ+yrDchtHQG69QP+Vq4Q5kv/0/+u3krokE0tLBqfTYLICaKpHeaQqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INfG44MgXHoM37WVGPDS0I/v21/koS9XIk832EqbPgY=;
 b=mTPl/gLLXydp+iHIjmrxNuq+28VtRd3sk0F3A0RfoJN7fPYFfZgZqwQ67mWDvuEpauEn0IoSivv5oWwnniQTs21Qg/ym6AvssAxsMB3zyHR0bvhac8Ru5lgGzf+HLImoaOt/3WXNTrx0gtvZstlEO5n3YOPIy/5NwAKaPTzaSCE=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 02:04:59 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 02:04:59 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: switch to new
 dmaengine_terminate_* API
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: switch to new
 dmaengine_terminate_* API
Thread-Index: AQHY+m9lnL48FMophUWKOVpHLXtue65LMfGAgACYe5A=
Date:   Wed, 23 Nov 2022 02:04:59 +0000
Message-ID: <AS8PR04MB840424D9B4D9281DC51634B6920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221117102705.13287-1-sherry.sun@nxp.com>
 <Y3z/T5PUQdUJ/Aau@kroah.com>
In-Reply-To: <Y3z/T5PUQdUJ/Aau@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB8546:EE_
x-ms-office365-filtering-correlation-id: 5201c1e7-7188-4091-1e20-08daccf72013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoJxnMgt2zluFI/aF1kkCTRvaG7VmgdFcOFSDRgFJUdr+w+62bVpgHzY6DcsKQk7SrQQ9BrJn8O0LUFO0xR8jqQDRa3cqmBQwhnX1RjJ8UDol5JOfGn6eLCRJUEDsy6q4h0+pHzAP7nwmTLCRzTgBqJDesOe+y/IWeQL6AGwxTK3JTEycLCQVJn8gGd4b4eINeNI+89Sz6/qVy04ibNK//1QfIL85XqEDBZAS9zkC0TIjA1gJ24rU6vKaAxGqL3Hqz6iuPiEIcbCURsJNPHndtDwsYy1Te/wc/k7N0YgFeb+qWlqFtyF64PRtq6Gb6opjk320sRDQR6r3dCNpOb+ylt7k8WcQVCSydxXuldP1zlAF0vP5xMbBLDAKpRGCXecD/V7Au9gzU2iPxtnwXiLoV5oMKHrlJJ5J3A9DMeaHKisa3H2PVPhICWscfdXKhQUsOEKdKOfBWWH3GQQEwJVc1iuaaJU+Z/AAttrPHLWRPcNl62+RYQODYRO8BYN6BfdKeVTrMivaskfADeyMPLfb4bRzZ5KuwUZoKMivpO6SDEYrEaQfT7TKOYiopXzPJ4iq1/ynThr8oV6hJyp5lVtl+ffTklou/bEx4lfGIOTx0QPjW8OsJHUTdiwyhRPbHZa3q/bzvxjp2n1caEUcMLNOy7YWIyn1bbijhalJSAqNk2cik5OvJivY2FDXcQuDl/+NLl7nvI6F8AF2SewyBtTFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(53546011)(122000001)(76116006)(55016003)(4744005)(64756008)(7696005)(186003)(26005)(38100700002)(9686003)(2906002)(44832011)(5660300002)(52536014)(6506007)(4326008)(66476007)(6916009)(66556008)(54906003)(71200400001)(8676002)(66946007)(316002)(8936002)(66446008)(478600001)(41300700001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QWF0NWV1ODluclVZZzdwT25vMXVUVGd1aXVxODRWS3NtbGFpS3hvMEg5Tlcw?=
 =?gb2312?B?eGMxbHF6aG5sdythNXl4OStQdW82WVlSZnU0b2Z0eHp2akVyd0FoamhPZFF0?=
 =?gb2312?B?VUR4TjBJRFlNUnpFSTZPbjVaSVZ2ZHowYXBSL1VjcGx6WDdKdGQxTkhwZ2JP?=
 =?gb2312?B?aWs3dE5DbVhUbm44b0M3Zllpd0N3TFhvYlljamxaSVRhWDYrSHhtL3pmL1A5?=
 =?gb2312?B?ZVMyYlFMTkk3NDJ0OEJjRVk0TDJIMFp6NTNlaWFWRHlKUkJwV2QrTWtLY3NP?=
 =?gb2312?B?TStWVGovWWpYMXhyRmdSWlpIRXU3MmpaRDA0SEc2a015Rk5KSE4yM1JBQ0Q2?=
 =?gb2312?B?ankxeHh3OWJzL0MrclhycGZTemU5WDVvM2lrT244RmhnL0xSZWdPMmZSNWtM?=
 =?gb2312?B?cWdwK2ptMGhHcG00SHh2UDI4aXd3bTdkYlE0NmpqYmVINEgyVk9iZkhMTXhj?=
 =?gb2312?B?cWxDTnl5MCtqaHZ2QVdQbXY2Z0JGZThHdXVJQk9XektDN21xSlVSR0pyTzNS?=
 =?gb2312?B?ZlVkeHFaTkY2RHR4UzRnYzdEMTFVMW84M1RJUlpiQ1JiSTBRWnp1S1VxZUlF?=
 =?gb2312?B?NzROTlhIb0ZTbTcyNlRZb0ZPUGI0MGJuRVJNS3FraVhndTNZUDZwMGh6RHhE?=
 =?gb2312?B?MFpTRnFBS3hJL3pTNUp1YUlCMlBwTmpXbTVnV1dsbkdnTWxvU1BnSW9ZTGZx?=
 =?gb2312?B?SmJCZnBEK2lzMlNmU0gxbmdDdWtpN3F5U1RiT0hmTlB0ZENoK1RibGU2RnNI?=
 =?gb2312?B?Y1p0R2JBNFpjSU0wcG0rM25ZeE9nb0xmc0xPWlF1cGlhZUUxRXZwNE8yYzd0?=
 =?gb2312?B?R012VlczbmIyTERyN0RlalB5MHRQU2ZJTkxHRUpxenJ6YUtLaWlya285L2F1?=
 =?gb2312?B?SzlUeG9kZGNHVTBOWXJsS0d6S0RwQldJR0ZsMTJoaWVlQ2h2cGJ0SC9iT2pE?=
 =?gb2312?B?YnJXUFp2eXV2VTAxNTE5MHRSZHB0cDA3cUZ2TithOGVGVFpPbXBaejFMNzFr?=
 =?gb2312?B?aHFwQ0ErMC9oZlpleU1CbDZCbEtsZlUyUFBZT2FTZ3RrUEVlMjVWVjFqTGh5?=
 =?gb2312?B?aEF6ZGZucE9EYmRVTWJJTGplRUg5UHFNd3dURDlENG4rMGdxQ3RRMm5QV1lD?=
 =?gb2312?B?Zk5LekdGZnpZZXZ6dmQzdlZzWlJoS3JuelNZUjFpYmdTcWxsNlpNUklUMDU1?=
 =?gb2312?B?VzNQQyt3NGI4bXQxdTI5ZEFRYVlxclZlV293eEFJeXdDYlJMby9kL0RWSFc2?=
 =?gb2312?B?amVwT2xjTEs0TWhwSmRabHNuTTBXM2JGZVBDbS9tWnRjRk9vZW9sMEliVUdv?=
 =?gb2312?B?MXhDb0ZEM2Y5SzlySFlMVlFsbFBQZllGUzBFWDNjQlk3S2x5ZDlNYnM0cHlm?=
 =?gb2312?B?T2srNW03bUFsTEVhc3ZWSmp2T1hiUnUvZEFHME5EdjlPQ1Jqd2dJbkR5UzVB?=
 =?gb2312?B?WlhKbzFCR1RtZ2p3VkREc1E4TUxDUG1UU3JXOUNQQXArOXhuMStQV24wTWFq?=
 =?gb2312?B?U1hPTzFOUnhrd3gxeXZhbmZNN1ExOHlxdE4zYkJWU0c0UjBKanppb082TE85?=
 =?gb2312?B?R2V6cVR4YXg1VXRWVkFFcFRDRHpMNXhIOVhIWnJvaWkwUHQxSzhWWFZwZDBX?=
 =?gb2312?B?UGxEWng2blFIV3pqL1dWVnFEK2pQR3QvWDVQWTVXQXpIdkZnYko5NE9KRGI5?=
 =?gb2312?B?c0xjREV4SFdYNWxXclVxaFlCL0xMNjcrOUNyM0JnQXVaS1VmcGNiTmg3NnZj?=
 =?gb2312?B?a0RnRHZkYjVZd3lWNDRiazI3S3M2Ti9CZ0lwSm9uc1FOZzlzMm1Nb0dhZHZL?=
 =?gb2312?B?NzdJZEU2eElKTDh5RlR6TkRDYkpJblNhQjNJcDRQdEIwbXNGaFJNaVVyNnFZ?=
 =?gb2312?B?UFF1ajh5ZjRIOVErTnpJcE5RamlidytlbmpmRXNjZkozME5GTHJLRkYxYk9o?=
 =?gb2312?B?SjNDcnpMeUpONGpQdk9YSTN4SEdSb1BhaHBnWGUvNjcyaFlUekhDVkZIQ1Zh?=
 =?gb2312?B?YW5lcjBCSGJKY2ZydEhoRWRIeXh1WG05MExuNTBFd2k1ajc2bnduL05vSDhr?=
 =?gb2312?B?L3czQWlsZGg3LzR4Q3VYa1pCOFM0UlJrK3E0d3JvRHVWaVhUbXZCU0ZyZytk?=
 =?gb2312?Q?wRibNfFtN64MAn12PUa3oWU8H?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5201c1e7-7188-4091-1e20-08daccf72013
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 02:04:59.2990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9u6Mrs2+rUAnUsMSy1rLzmL75tWZf11XFoGMyC3GDhZg/w2ehp55gaIua6biX0ZspfZslA+Cm5eW2AAx1xN4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IDIwMjLE6jEx1MIyM8jVIDA6NTcNCj4gVG86
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGppcmlzbGFieUBrZXJuZWwu
b3JnOyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IHN3aXRjaCB0byBuZXcNCj4gZG1h
ZW5naW5lX3Rlcm1pbmF0ZV8qIEFQSQ0KPiANCj4gT24gVGh1LCBOb3YgMTcsIDIwMjIgYXQgMDY6
Mjc6MDVQTSArMDgwMCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBDb252ZXJ0IGRtYWVuZ2luZV90
ZXJtaW5hdGVfYWxsKCkgY2FsbHMgdG8gc3luY2hyb25vdXMgYW5kDQo+ID4gYXN5bmNocm9ub3Vz
IHZlcnNpb25zIHdoZXJlIGFwcHJvcHJpYXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hl
cnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9z
ZXJpYWwvZnNsX2xwdWFydC5jIHwgOCArKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBGYWlscyB0byBhcHBseSB0
byBteSB0cmVlIDooDQo+IA0KPiBQbGVhc2UgcmViYXNlIGFuZCByZXNlbmQuDQoNCkhpIEdyZWcs
IHNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZSwgd2lsbCBmaXggaXQgYW5kIHJlc2VuZC4gVGhh
bmtzIQ0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K
