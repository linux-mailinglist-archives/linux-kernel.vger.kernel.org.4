Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FD6292AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiKOHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKOHsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:48:45 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2114.outbound.protection.outlook.com [40.107.114.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAD61D0E9;
        Mon, 14 Nov 2022 23:48:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHV4JPUfci2yg4dKqvHgvZGOvY2H3tILCcVr/aUq96zfccAvf6/Y1UitSIVUVPNsWCG0zFJHcnIN41WW5T8VeHZIpjtE03gLW+61uLoGSdIHUQ9c94WnlV0vEiG+mQLNB3NsVTlPCuAs9MN00fHFsCaf4zF2ArDQ/9ZeN7dHIKIO/oNAsE1Bq1uzBi+kSKzuH0R0B2wpfzbZpLVeQkH2Jhfslk9j3OaBU5duffJXc/cf3hmrU58gVHnZSDJN/Zvwx4nuvg0znEnBUw0V6FEQdW3657u/p2g7dSK16+eHVtYJ3dJ8q3swiiBkeoRKwTzOffE+KZwrw6DtvS/Il6q6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fRIf0D+vYEMLZVnA61moAuhwYMqx6SeYW6MTT1HQJw=;
 b=DBWnGNbUEl1vYBk7U8OmfoZCxJn0p0NAzsKCMcppp9A3CDzulx3MAZDdt3rmTuR6ilFmzj7ox3wLPiit69czR66f2DWINVrlirjlk/hOhRiDh7z8mcFcT27fH6eaoB/9fqN97sYkuqdSqPyWOrXonyJX4cTNoXHR/uR8wElBBmXuqWPSXb8DO9/+XLURY4PljntLIkS12ebjfjU+IRAEAW0OrdtH8pDjg8XjrQLkrEzMI+7CAJTf+0rAMD9MlOiyiMPG5RUMfDl4Rb0pbDaYd7wtFxFEIQgmalZpY0s9eoazUDTlVo2oD4KfpA5J6pE05aasogSPr8t/o0pJPunhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fRIf0D+vYEMLZVnA61moAuhwYMqx6SeYW6MTT1HQJw=;
 b=dZBHTMWYiF2An0OHeftBtZZRqo5HYJaIlDB4Po1KjEQG0O8kRPLGNy9Plux2RjIjEX/SGoKT3xEeRy6WN63ab3bls1IqhbGz3eisURa7v+2yYcOAIec9B4fcMFWLIxoLDFTjqiT86qGEcNs4hoV+oPxgCaWb/lZ8N95hb02hlRA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5767.jpnprd01.prod.outlook.com (2603:1096:604:b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 07:48:41 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 07:48:41 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Topic: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Index: AQHY+FQ3i7+8G/jXAEWaK/AAUJtKua4+wHcggAAGgYCAAAGLYIAA0q6w
Date:   Tue, 15 Nov 2022 07:48:41 +0000
Message-ID: <OS0PR01MB592239F10E9C768888F41D1786049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
 <OS0PR01MB59224DF03590185EFD5AF91386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59224DF03590185EFD5AF91386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5767:EE_
x-ms-office365-filtering-correlation-id: a1d3aa31-ad78-4bee-89c2-08dac6ddd0a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ynpjuofPPiKxqlERVtdRWPgXCSA2ayKNqa9Ur1RIMg85NT5L2xh5YGJXQuLQQ6zGTsxoEM4+m2Oh7nyPKm/cRjcT2Q+gAzQftu3GrGCR/I0Rn3parouVw+4fk1TEKesqCYDtVSA0Mm4hbB6AvYHto7Vybx03YpzpRRa91OjsMoEvYSLFK4v3BxSZGBtjZgRyAmwnXLFDlIXJqgv2r/83T78xhDImENyv0JS8V6+g5s1G6MhL7jQ8vMGcQgQBF6yC2u8SeEVD4G4kF7Au1Uf5mdkMdeVZdtYdoWgEeDjtPSwRrwpAbtUwKUHHS4VtOFCveLAvroCJ6u0EDBsikXQ+r9bUZZjLVVrbtLqbhXL13j3N7pDisZOYgkH/g+azj7f0u983EvgkmgEydow69N3aUGQSsacgYTVcj9OgQYq0xzESSpmV4nFMaUHbSBv+FjQfM9/DpocQRkefjCbzoWSqKa08WhBCFb8imf5ZYFg7ki/YhComWOXX78X8UAoMPIhKiaMrSqOJG3sZ5rzfcpzWfcP/rFAJKQIe7fmtKIxduAafCEdMhsegjrddvsW3grejLb+mhtt/MjypTVni2cboKWvTHwRapz0cNjsD9z5XK+tzptJ8OhZF6MQDlVqLtbVnnl6evphgzhkHW2DVSrCYblpNDrObAgFynu6mAR3FsxPLnWdcd/n6SK7xcE5iDQwoMFJWDTOleXmuSL2w4J4xDf/7+43MOP5uayJFbMAUsSeds6p5PRtnSQZ90+VWzVVrMdT+EVOpR4CvbZ1ndzLsxxtgT7/TlTYeYBFqF8Kdl4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199015)(86362001)(33656002)(55016003)(66556008)(66946007)(41300700001)(66446008)(76116006)(66476007)(64756008)(4326008)(8676002)(71200400001)(5660300002)(52536014)(186003)(107886003)(478600001)(26005)(966005)(316002)(9686003)(6506007)(7696005)(54906003)(6916009)(53546011)(38100700002)(122000001)(38070700005)(8936002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVMvVnZROWE1aUFzSW9UNjUrZElES0FLeVBSS0MyZVdqVGhtTVhPVGdLNS9N?=
 =?utf-8?B?LzR0cExOY1J5aEpTc291YlNGT3hYcmN5Sll1SGZaeVlwa1lJQkNsSDRreWJM?=
 =?utf-8?B?TUpPaG0xU1ozdHVweEJRNGZ2Z0t6UmNVQmlhZGJ2RDlkVEdKRERUem53TFQz?=
 =?utf-8?B?MS9jRHZNWDVHcEx4SVlLVGt3d09PblEzVmxVeSs4R2k0NHBmTFFSVlhBbUJL?=
 =?utf-8?B?c3Vpck1hN25NSmlCcWd1SVgzaUNWMFZjWDFUd01QY1VkWDBzZTNoNThvcEhL?=
 =?utf-8?B?N0t3b0hmQnM3NGdvL0lRdkU5RFVjdlJyOU1nUytiSUFNbTJ6ZW92UFdiOHVT?=
 =?utf-8?B?SnBIQmxOK0RrL3FrZWRoQlRyQ3o0dlFFL0FoQWxUcDNGQzJwais0dCtYS0ZM?=
 =?utf-8?B?Z2dWTFZZM0g3cXVYdDM1Z2Ftc1VOd0ZPM09kMTcvMEl0NW5HMndqRW9aMHFR?=
 =?utf-8?B?MWhOZFZuL01BTCtta1dlTVZDRHN2VUZLTndhSWd2c3AzSmdqeVJjRlFqekdp?=
 =?utf-8?B?N0JoeFVwa2xPY0xLYUtwREQ2eFBDT3FFTHNoQWRnYllGSE1mUXN4VHI3ZTl2?=
 =?utf-8?B?a05CVGI2RkdzQ0huckpldk9TOGxDZTJuK0hNSUlWTmpuRU1GSzNoRnE5dHhY?=
 =?utf-8?B?UlFJSHFqMDQ2N3NNZVgyM2h6ZFh0MlRVK3huNllPbHdWNkxWUDg3NHZ3bDFO?=
 =?utf-8?B?em83NCtTVVB2T1VsS3lpUEYwdUpQY21USTZPU1N0azNTWkdEZ0w2NlJoRFFw?=
 =?utf-8?B?T1ZqZlZDOVZmVzRKc0tvcWtuWmlJRi9nZU9HcDVRWEFTR2t3dnVyOUVMQTJr?=
 =?utf-8?B?U1RYMlJYNVYwckkzWUxZOFBjWkJ3Ym01VytGaXBYYnF6dWVraVBWbndOckVY?=
 =?utf-8?B?OXM5cTJ0SnZuOThMcjRSS0h3UEdXT2JKdU9USmVFOFVlanQzakhUS3FlQ1ZU?=
 =?utf-8?B?ajhhWHVjVU8wd2d6WUFvRVY3UVFqSkFWWE5UT2hQSkZYV2F2RmFWckg3aFZK?=
 =?utf-8?B?NXhEUnVqUXRrbTVWZnk1RHFIdlJVRExGMmRhbEZSUWpKRlJRcndIejMwc3hq?=
 =?utf-8?B?OTk2amNlL1hSaUJoZ29icnpvSEpITTlsbzh5NDJDMG9ic1IzeEhKUHExMUlo?=
 =?utf-8?B?L2tYT3l6dGd0UDJpV1pqekVpcnhodkVxbEJ6NG1VenBmM0VNN0huQ3M1eno0?=
 =?utf-8?B?ZkExY2h0c2MvaDJQbThGd0haeEhVTmEzRjJxSW9HSHpyZjl6bE9KODR3S0ww?=
 =?utf-8?B?Q0ovdXVPYU51aEhLWkRXZTNIeFA5MVRKVEFYQTdEdk1XMmVmSUFZdTQ5aU1T?=
 =?utf-8?B?MHNsK2dYd0QyczZpMU0xcVo4YUxTc2tIczlZTzBtTWRGSVRod1dmWUJKVmZ1?=
 =?utf-8?B?MXB0ZkNGQ3dHcjZTQUY3eVhRZG13cG9CY3I5RzZOekNZMFpLR3RRYXZndFZX?=
 =?utf-8?B?dmZBSkR3Q2pFQXhRRmFLQ3haSmw5a0E3QXlvREVSSlJmd1lvdExDemxlTGxC?=
 =?utf-8?B?NzRHOEJIZncrNzFRZlN2L3UxaDB4Tml4dDNreXp6WHg5TXZUMUF4RUtxOEpV?=
 =?utf-8?B?YS8vcmJ2SCtURTNZUEdLQjRVdStua2R6bk5naHZENU9JMHUwS2FnNVRoUkl0?=
 =?utf-8?B?Zk9pTEJHMUYzZ2RsbGZMd0lLL1UvVWJGUnExMFZJSDRyU2J6bXlLWE1JMVF5?=
 =?utf-8?B?aFNOVlhQbnBWb0VuYlRxT2lGNFhOOW1XTy8zR0htQlRZa2hOMGVPWHg2aUgw?=
 =?utf-8?B?YjArVHU5Q1hUYStUMVV1TG13Qi8rMS9UZ2lnTW9tcUp0RkxFV1hONGI0Q3kw?=
 =?utf-8?B?K21DUFJCTFhZQXI4WVIzUnNLcXh6MUFLeEh0RmRiNVBLVGgyYmp4d3daV0wr?=
 =?utf-8?B?bWNTVDRuSGhOdUJKaFN6VTE3a2FmcW5uUVRXNktOU29GWVZnTFJRaWZGckU3?=
 =?utf-8?B?emYzTHFSVVRpNkxkZzBzRzlrV0RvY2ZXVGVYZ3VyTnR2S1FZWnRScHpZZ3o3?=
 =?utf-8?B?RjVvNkc5ZUlpbDFWNDV0WkVLVWlvUlRzbEZkaVhHMjRvcE5tdUFMYmxFSzBy?=
 =?utf-8?B?b2R6cUhZZkk5UEtzVHl5cDZvV3RDaFlvcUZKU0xUOXBaTjVsZXNWYk9RK09p?=
 =?utf-8?B?K09zZ0RTYnRncithY2c4TDlNUFpveGpZbGhPbWZXMkJKemtaVE5oYXprTUhU?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d3aa31-ad78-4bee-89c2-08dac6ddd0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 07:48:41.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+9dOF4qH8k2vQ1yyOhBCI3QhbBwK5hm0mXnkGi8lp76UVTCyKZW4XeWz7CL938zVwjzFRjxTGfaxsWUoo+loKujF1AF2N7WnwDfA+u5ENU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5767
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIXSB3YXRjaGRvZzogcnpnMmxfd2R0OiBJc3N1ZSBhIHJlc2V0
IGJlZm9yZSB3ZSBwdXQNCj4gdGhlIFBNIGNsb2Nrcw0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBs
aW51eC1tNjhrLm9yZz4NCj4gPiBTZW50OiAxNCBOb3ZlbWJlciAyMDIyIDE5OjA0DQo+ID4gVG86
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiBDYzogUHJhYmhha2Fy
IDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT47IEdlZXJ0IFV5dHRlcmhvZXZlbg0KPiA+IDxn
ZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IFdpbSBWYW4gU2Vicm9lY2sgPHdpbUBsaW51eC0NCj4g
d2F0Y2hkb2cub3JnPjsNCj4gPiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+OyBQ
aGlsaXBwIFphYmVsDQo+ID4gPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+OyBsaW51eC0gd2F0Y2hk
b2dAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LXJlbmVzYXMtIHNvY0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gRmFicml6aW8gQ2FzdHJvIDxm
YWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+OyBQcmFiaGFrYXIgTWFoYWRldg0KPiA+IExh
ZCA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIHdhdGNoZG9nOiByemcybF93ZHQ6IElzc3VlIGEgcmVzZXQgYmVmb3JlIHdl
DQo+IHB1dA0KPiA+IHRoZSBQTSBjbG9ja3MNCj4gPg0KPiA+IEhpIEJpanUsDQo+ID4NCj4gPiBP
biBNb24sIE5vdiAxNCwgMjAyMiBhdCA3OjQyIFBNIEJpanUgRGFzDQo+IDxiaWp1LmRhcy5qekBi
cC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiA+IEZyb206IFByYWJoYWthciA8cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb20+DQo+
ID4gPiA+IFNlbnQ6IDE0IE5vdmVtYmVyIDIwMjIgMTg6MDkNCj4gPiA+ID4gVG86IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+OyBXaW0gVmFuDQo+IFNlYnJvZWNr
DQo+ID4gPiA+IDx3aW1AbGludXgtd2F0Y2hkb2cub3JnPjsgR3VlbnRlciBSb2VjayA8bGludXhA
cm9lY2stdXMubmV0PjsNCj4gPiA+ID4gUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25p
eC5kZT47DQo+ID4gPiA+IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiBD
YzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gbGludXgtcmVuZXNhcy1z
b2NAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiBQcmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dA
Z21haWwuY29tPjsgQmlqdSBEYXMNCj4gPiA+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
PjsgRmFicml6aW8gQ2FzdHJvDQo+ID4gPiA+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5j
b20+OyBQcmFiaGFrYXIgTWFoYWRldiBMYWQNCj4gPiA+ID4gPHByYWJoYWthci5tYWhhZGV2LSBs
YWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gd2F0Y2hkb2c6
IHJ6ZzJsX3dkdDogSXNzdWUgYSByZXNldCBiZWZvcmUgd2UNCj4gcHV0DQo+ID4gPiA+IHRoZSBQ
TSBjbG9ja3MNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogTGFkIFByYWJoYWthciA8cHJhYmhha2Fy
Lm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBSWi9G
aXZlIFNvQyBpdCB3YXMgb2JzZXJ2ZWQgdGhhdCBzZXR0aW5nIHRpbWVvdXQgKHRvIHNheSAxDQo+
IHNlYykNCj4gPiA+ID4gd291bGRuJ3QgcmVzZXQgdGhlIHN5c3RlbS4gVG8gZml4IHRoaXMgd2Ug
bWFrZSBzdXJlIHdlIGlzc3VlIGENCj4gPiA+ID4gcmVzZXQgYmVmb3JlIHB1dHRpbmcgdGhlIFBN
IGNsb2NrcyB0byBtYWtlIHN1cmUgdGhlIHJlZ2lzdGVycw0KPiBoYXZlDQo+ID4gPiA+IGJlZW4N
Cj4gPiBjbGVhcmVkLg0KPiA+ID4gPg0KPiA+ID4gPiBXaGlsZSBhdCBpdCByZS11c2VkIHJ6ZzJs
X3dkdF9zdG9wKCkgaW4gcnpnMmxfd2R0X3NldF90aW1lb3V0KCkNCj4gYXMNCj4gPiA+ID4gd2Ug
d2VyZSBjYWxsaW5nIHRoZSBzYW1lIGZ1bmN0aW9ucyBoZXJlLg0KPiA+ID4gPg0KPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyDQo+ID4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi1s
YWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBOb3RlLA0KPiA+ID4g
PiAtIFRoaXMgcGF0Y2ggaGFzIGJlZW4gdGVzdGVkIG9uIFJaL0cyTCwgUlovVjJNIGFuZCBSWi9G
aXZlLg0KPiA+ID4gPiAtIE15IGluaXRpYWwgaW52ZXN0aWdhdGlvbiBzaG93ZWQgYWRkaW5nIHRo
ZSBkZWxheSBhZnRlcg0KPiA+ID4gPiBwbV9ydW50aW1lX2dldF9zeW5jKCkNCj4gPiA+ID4gICBh
bHNvIGZpeGVkIHRoaXMgaXNzdWUuDQo+ID4gPiA+IC0gRG8gSSBuZWVkIGFkZCB0aGUgZml4ZXMg
dGFnID8gd2hhdCBzaG91bGQgYmUgdGhlIG9wZXJhdGlvbg0KPiBQVVQtDQo+ID4gPiA+ID5SRVNF
VC9SRVNFVC0+UFVUPw0KPiA+ID4NCj4gPiA+IEl0IGxvb2tzIGxpa2UgdGltaW5nIGlzc3VlLCBO
b25lIG9mIHRoZSBwcmV2aW91cyBkZXZpY2VzIGFyZQ0KPiA+ID4gYWZmZWN0ZWQgYnkNCj4gPiB0
aGlzLg0KPiA+DQo+ID4gVG8gbWUgaXQgbG9va3MgbGlrZSB0aGUgZGV2aWNlIG11c3QgYmUgY2xv
Y2tlZCBmb3IgdGhlIHJlc2V0IHNpZ25hbA0KPiB0bw0KPiA+IGJlIHByb3BhZ2F0ZWQ/DQo+IA0K
PiBZZXAsIHByb3ZpZGUgY2xrIHN1cHBseSBmb3IgYSBkZXZpY2UsIHRoZW4gYXBwbHkgcmVzZXQu
DQoNCk1heWJlIHdlIG5lZWQgdG8gbWFrZSBpdCBjb25zaXN0ZW50IGJ5IHRha2luZyBjYXJlIG9m
ICBbMV0NCg0KQ3VycmVudCBwYXRjaDogQ0xLIE9OIC0+IGFwcGx5IFJlc2V0IGZvciBWMk0uDQpb
MV06ICBBcHBseSBSZXNldCAtPiBDTEsgT04gZm9yIFYyTS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXJlbmVzYXMtc29jL0NBTXVITWRVV2JUNlZBcm05QjU2VkUweVVZV0NU
bT0zdk1HcnJPTlN2OWNkc1FRbmhwZ0BtYWlsLmdtYWlsLmNvbS9ULyNtZGI3ODUwMzUyNGE4ZjQy
MDdmNTlhNDBmN2ZmNTczZTIxMDY1Njk4OA0KDQpDaGVlcnMsDQpCaWp1DQo=
