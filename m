Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF587434D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjF3GQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjF3GQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:16:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A872686;
        Thu, 29 Jun 2023 23:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbBwP1y+GrYaYuzOxktgM/7HBTLGkkzfXxj5F4u1MyTgt7HRGkV5DAX/+NXlH7XB/bJPs6jB+qT7PZPZBALcT8i8OiuoY7w/F3RBobndE4RUOgXky4YWLGcEu8AFCCpjsf+VUDBrqcr8uxjukv5YakY/9CuvTUA1aiPE1kykZgoL5SAs3UDUZRFyoSNB1yCi6HW9bt4oo96PFGIcCmAh3VISFopXvkZkWEfFJEMkatE8WxjkezUtKC3Ouweu09rVrw9+g+1AHZ8wUIcOZFb8HOuOmjqaLWN4VXghyw+69E7EnfuXoRJOA4wux+pONhHfHPYcYFxQfyfcErPHG55fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVB73aGl+hE3QFZVUxMRkOaEpXZuhl2VQo5//YgAFh4=;
 b=bT7X6Q1D1QwlrwCZhp5GlH/esJ1WaP8xJJrm04emVwpyRn80/VCiNl76IQUoQIWynFqllJZptA8SMX1yKx+FXU6ZtwgtMM86DMcZVtbsvC6qirs8HFSoJJrSLXqYqcgYKIf9R0z7qavJj/c4iFn3stuWQumtTx4e7mISDNs1cwGBdsdX82D1f/nzBY4DdciwVC/cc6XaVuAceYbSIY4w4OB0uL20j3oXldnxu9W8wTS2f1I8DbaASKCKQWNJ1ggtDAmDGBIWBQnmGh6S14rQayniIsrtARKGiMaPOrE+2kvnQ2FMhRc3QolQWU7OG0GzHn3gMtPfavih0mIVczqK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVB73aGl+hE3QFZVUxMRkOaEpXZuhl2VQo5//YgAFh4=;
 b=1BaAO3WMu9sQ2ZClajFH5+xDIkhdoA3UC0GtmH3VFtyWahxK7A41iVJfWee9amHtk4lD0Bli69DhLrxZN+ABWwmBk5wloeU1nY7DLZyMxM8sfvDShGuIw70oDj6FSMRc66UVzMt3Z9jeahhk0xTXMHqigsQs3cDVsUx0F0iEVxa+STYQTMnsBv8ypJuwNQEIPyo5ZGol0XoruSPX+jdu9wGMFMEc/G6iVhdbVxV+5v6sWWnw1gkDTZQceP3NbcTst9eS6wKn6cv8H8sHMPmgCZNgO/8svzxfYKiRLdKgGVAeBMyjRIHTKJ7yVnWMJkecr+QCAAQAQXFH6MgY8guhBA==
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com (2603:1096:400:465::12)
 by SI2PR06MB4074.apcprd06.prod.outlook.com (2603:1096:4:ff::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 30 Jun 2023 06:16:08 +0000
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::7bcf:584c:587c:6340]) by TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::7bcf:584c:587c:6340%7]) with mapi id 15.20.6500.036; Fri, 30 Jun 2023
 06:16:08 +0000
From:   Dylan Hung <dylan_hung@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH] dt-bindings: clock: ast2600: Add I3C and MAC reset
 definitions
Thread-Topic: [PATCH] dt-bindings: clock: ast2600: Add I3C and MAC reset
 definitions
Thread-Index: AQHZpCUufmT2Rth+wkmDz+SvGV4yjK+VCR2AgA3i2QA=
Date:   Fri, 30 Jun 2023 06:16:08 +0000
Message-ID: <TYZPR06MB6567457D1D707C026C302FFF9C2AA@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20230621094545.707-1-dylan_hung@aspeedtech.com>
 <80cd8bb9-54ad-4c5c-f3ce-c8655cd2ff74@linaro.org>
In-Reply-To: <80cd8bb9-54ad-4c5c-f3ce-c8655cd2ff74@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6567:EE_|SI2PR06MB4074:EE_
x-ms-office365-filtering-correlation-id: 6f412199-017c-484c-4084-08db79317e35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aoF089oHcKIH4LokdvjyiYYIbstF4SH8HmeH6c/JDmFukT+D54E/hnnNgAll3kt4+AD+dq0y9AQHAMsP/p5+NwKFilU7RhgI427IZOkyktz2A1Ruog1sypZZLN6b3Q3+3DpKV0/UgbscJbUc+tZp3W0hGofQo0im3y8H0k3iXZdM4bf28AJUvObp1/GO095+WiLEfquOI7x10tphRroTE7Wq3zFrl6Vj8eyofjQ4UvF8lgkDbSpnx4bq3rkD6NQC+5apUXr9dPuGQjc2LkfnNRWpp3csbeRlZKFlm4L7AottXVbOMdKHgaQIvOSwlKp8vrdr8F6+KATeF0YcLwRcQOE5Bdy9ja82YfmFFZmkOZs5duBkL8kYDwH+KMVE0vkmmAEzZHUOMs9LqNwARUo0wj7rIK04BmAzteFU5nlNw0VdGcOKSZEDF16YZ7H/lGMoFErDCdEvqHln41QJ6Anp8NTjRpBKzpqykbNYp9STkKloPSM2s0gO3mKpcyRZKdMmr1modA6Tj+uqOdvvx+xyDWWhaa4nvPPjpbmwrgyqtnaBSs0/66ylUoGOUsuI8F8lgtnVYq7m7fYaX61aOEW43TGd/vwCWCXHZuIHC3S/lhinlrOh7FiHSq43tuZb+y0Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6567.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(53546011)(26005)(107886003)(83380400001)(110136005)(7696005)(2906002)(71200400001)(186003)(6506007)(508600001)(33656002)(5660300002)(52536014)(64756008)(76116006)(316002)(9686003)(66476007)(38100700002)(122000001)(55016003)(8676002)(8936002)(66946007)(41300700001)(66446008)(4326008)(38070700005)(66556008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlZUSUFCQTIyYjZOZWxhSy9rak9OU1VDeWlNcFUrNk5oTFlwSldVempWbWZ4?=
 =?utf-8?B?RloxL2hBUmI3ZnV1aEc0YVpTRkFLcXRxcE0wZXpIU0JrcjlsakliOFJUTzIw?=
 =?utf-8?B?UndJcnAwUnpZUGl1RmgwY3lKSHF3TEpOUE9KbitZOXNoQzZ3TXdkZmwwdEtZ?=
 =?utf-8?B?aHl4Ykl4R2tIa0FQbGVub0hqNjloWmxEZDdDTmpEVVhrR0RKYlAvTHJqWVA5?=
 =?utf-8?B?VGtCUjhNWm9YSXI5dERDMFp4UUh4N3B2UXdMZk1hTFFqNU8vM1cyK2ZJYVhP?=
 =?utf-8?B?LzZDR21VdTM2WG81WkpzUjJTaXRvNWptVmh0MzQrc0JZc0lIOEgyRm4xbTl5?=
 =?utf-8?B?V2RHdU8rK1k4YVQwWFNMQmtXWWc3dGozNmJxV20rLzYrSDFBaU9VcmhmUkJM?=
 =?utf-8?B?d2IzQzlNc09jRS93QzBwNnQ5L3lGc1hNY0lRYi9qU3ZqdGFzOEE0T1A2Zmk0?=
 =?utf-8?B?Mm5oTVFUb3NOUjhzTTVHU3VFbjhGLzF2elpmMlRXMVZuZFVaQjh4bEtTMDhL?=
 =?utf-8?B?Z0l3cjNESnRTUlZKTk1BdGxWMVRrUkRBSW9ITmIzWmEzMGptaWhzMjQvdk0v?=
 =?utf-8?B?NXEzZFR5dmN0VFF4UlVJRUV0anNPS0pMNnl1NXFPQjZ6cERPZk1PT2d5cTFH?=
 =?utf-8?B?SDM3eStudFRkZnAzdUZBYzB2VjlMSXlheVQyMFVhMjNhRy9wbDdjWXBBQUlk?=
 =?utf-8?B?ZzF6Mlp6U01SUGxTVUlCbUVuOGpYQm5hTEZ6SERITitKdGRDRlhoZ3pwWG13?=
 =?utf-8?B?RnNYVzUxclJLM3o1YThTOExJS2dac1VqRE0xeGQ0MndNeisyZHJvdmw2VGwx?=
 =?utf-8?B?aVdmL3RNQ2VvOGovUWxhVjlOZ0wxdFUzWVlFUUR4eG0yMkJVV3p5dEdEcDF4?=
 =?utf-8?B?bGVWaUdZOUtkRjY2bTlIQTBpUkZrYkV6bzJ5RFNtY3Q5a2RQVEFBdFZXa3BS?=
 =?utf-8?B?QmZoSXJ3UWIyaHFlRmpCdmNUUmpWMnROaHlyMVpyKzZrL3E4ZmpOc3pBYU9m?=
 =?utf-8?B?TFBYWHhOSzdzU1N4WGhPeWh0RlhXMCtTb0F0MFBLRGd4UkZtWm1zckVaaHNB?=
 =?utf-8?B?MUFQTERWVEhHYjZ6VGJIaWpheXVHci90REM3T2lyK0ROYWdUSnAydGROenE4?=
 =?utf-8?B?UjlCM2w5eFAvT1l1blUvdmlPbWtESTNBTjZxTVZDUnJiTm9nRTRHekkxd2lk?=
 =?utf-8?B?NkpiSHpXWnBobmJNNXpLUWIyV3J0WmxySFZjejd3M2l4MnNvVzFBT2FGTXZH?=
 =?utf-8?B?Y3VGVUN5R2M4VGhqaVRIaTJHQUVRajBxM3pabGFLSGxTWS9QbHdFZUJYZ21Q?=
 =?utf-8?B?UTZCRW9RWFlkL1hEbXRFa3dpTG5aaXNJbFNCK0dEdHFGNUE5R0xzOTdJck85?=
 =?utf-8?B?Y3hVYTJ0bDVVRTdwVHprb3A0Znh0d2pwajNzcGRLNFBqeUdqdktEdDNhRU5R?=
 =?utf-8?B?WGJhNWkvcVFvU2swL0lLRWV0NERwaGpNRWRTWmFKM29udTVna3FLUWlwb3J6?=
 =?utf-8?B?Z2Vscm81QWFZQWRTMmRXbVJmbXBQMjNHRkY3QVJXMExJKzQ2bGN6UHhrVG9U?=
 =?utf-8?B?MmJFUkJhSnRWK3RwVFNWOWRiM2pDMmNSMXU2b3Y2UHd1S2xleHJuMWFPQUpI?=
 =?utf-8?B?MWlUYVFiOFVkUWliUm5lUjZDcHkwTHNRcXBIcVlxaFFla3FtYnl4azVHaTFq?=
 =?utf-8?B?dWN4QThRWW5zci84VnBCdjR1VGFvSDQ4azN4RDBCakNZZ3NCREFQSHBZS0No?=
 =?utf-8?B?eHRvUHVHZGw1OFlwbnBVb2FSQkZ4OCtMSHFSU1ZEMzBCN04rbjBkWTh2NTZl?=
 =?utf-8?B?bnh6ZTF4QXZUZVZvWmtJT3UrM0pvcmdLVTlibkdZS2ExL0ZzWXdNbzZhNEpO?=
 =?utf-8?B?MTFUcDhackVidlRMVmtxaXQ1UE5MdGR6V2liRGkwNU1ZTVpGenpnZ1Rua1dv?=
 =?utf-8?B?YXlaeXYzZk9tWmdXRUd5R05KOGxsTWkwd2tOVCtyS1ZOcWNiWHhjSjhXaUVJ?=
 =?utf-8?B?QXY4M2FTSE1qSzFrL2ZQNVNNQmhQc2FMUHB1L0daTnJWZ3lhZUlRTkVPbkx6?=
 =?utf-8?B?L2RFT1Fpa1VMT2tFcm1RSlNLTnd1UmNFRTFqbFNYZUJLbmUrcFZKVTc0TkdM?=
 =?utf-8?B?d3JaanpxUXhQdTlBY1RNb2pYVFFwTEtPTnlMVnVMclhodUlvUk12UVRyS1pH?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f412199-017c-484c-4084-08db79317e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 06:16:08.0238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9tBL0kGsreStWpFs9ZDIfIKU98guk6m5pCPG32JK14VQcxJDR9Gx1hQ+90ZwHzKcbzIDpNjd9PtzjhbXlQNdBl+p5RrhrL5sWpiBOVC6Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IFttYWlsdG86a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnXQ0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgMjEsIDIwMjMgNjoxMSBQTQ0KPiBUbzogRHlsYW4gSHVuZyA8ZHlsYW5faHVuZ0Bh
c3BlZWR0ZWNoLmNvbT47IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiBzYm95ZEBrZXJuZWwu
b3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
ZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkdC1iaW5kaW5nczogY2xvY2s6IGFzdDI2MDA6IEFkZCBJM0MgYW5kIE1BQyByZXNldA0K
PiBkZWZpbml0aW9ucw0KPiANCj4gT24gMjEvMDYvMjAyMyAxMTo0NSwgRHlsYW4gSHVuZyB3cm90
ZToNCj4gPiBBZGQgcmVzZXQgZGVmaW5pdGlvbnMgb2YgQVNUMjYwMCBJM0MgYW5kIE1BQyBjb250
cm9sbGVycy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IER5bGFuIEh1bmcgPGR5bGFuX2h1bmdA
YXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sv
YXN0MjYwMC1jbG9jay5oIHwgMTMgKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXN0MjYwMC1jbG9jay5oDQo+IGIvaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9hc3QyNjAwLWNsb2NrLmgNCj4gPiBpbmRleCBlMTQ5ZWVlNjE1ODguLjA3
Mzc3NTg5ZjhmNCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2Fz
dDI2MDAtY2xvY2suaA0KPiA+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXN0MjYw
MC1jbG9jay5oDQo+ID4gQEAgLTkwLDcgKzkwLDE4IEBADQo+ID4gIC8qIE9ubHkgbGlzdCByZXNl
dHMgaGVyZSB0aGF0IGFyZSBub3QgcGFydCBvZiBhIGNsb2NrIGdhdGUgKyByZXNldCBwYWlyICov
DQo+ID4gICNkZWZpbmUgQVNQRUVEX1JFU0VUX0FEQwkJNTUNCj4gPiAgI2RlZmluZSBBU1BFRURf
UkVTRVRfSlRBR19NQVNURVIyCTU0DQo+ID4gLSNkZWZpbmUgQVNQRUVEX1JFU0VUX0kzQ19ETUEJ
CTM5DQo+IA0KPiBUaGlzIHdpbGwgYnJlYWsgYWxsIHRoZSB1c2Vycy4NCj4gDQoNClRoaXMgZGVm
aW5lIHdhcyBjcmVhdGVkIGJ1dCBuZXZlciB1c2VkLiBIb3dldmVyLCBpZiB5b3UgaGF2ZSBjb25j
ZXJucyBhYm91dCBpdCwgSQ0KY2FuIGluY2x1ZGUgaXQgYmFjayBpbiBWMi4NCg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
