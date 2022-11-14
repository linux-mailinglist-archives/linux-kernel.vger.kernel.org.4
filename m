Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB146289F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiKNT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:59:46 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65DC38A;
        Mon, 14 Nov 2022 11:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhmQ6v1cr1ea1A+tEw0K8pnnISJXTKxW/dBtwBBY4PVAvbK17pyVvYwO30KS8wOSfKSqaD54KjVk4+9MpjrDoaPaDBHhTum2bjc/6kMKkAbfNC/tEbRIgJwAfOkyGd19r7P637yAF0aRa4DPZ6iyb88DGqH1OCiWcL9Ug2cgrjD74KMhiRahcxWCmHM0oIlrUl57A/8NYM3DB91e6Qu/+Cn2I93gEZSi24s4HP72suSYrQCoXgZ6eY6qZAiGd3nZ4CtUaPuza6aPb6BRwbwcBi2cNIw6BuFdjEE7hkq38LvYJxnlN3bS3UiGzo7QHjNB+Hr2BrkgEMw2BDH7B9xjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzYd6To2qWnEjrtCCDJCqIVHOo2HgbDRji6loqetztI=;
 b=Ic5ZxVQIVait1PQTjKsBi7+XTBfXaeR7V1gX6mH9JXz22jRUnWWPRZMVxAGAMXciTMKLGmOnULdSI9/7H7448JxqqrkCdmiKNFmngsnbWz7XjBx2utlMRo8KpwB1j3vdnqYit0g3wirjhr8ZrXQ6UOYMYNJDFkqkmVN6BJKDqFMLjt+aiUJtlrC54Av7XlLusAyCRZ0zsTGkcKdO9h4iHC2TROj2naELwTlcIV1CZrVrS7bdt6StcsF893s+MISr3vDwvD3TYOGfeJbWw9fWZxQyo17QLsx4BxDDUmkplr8YnluYX5/dCj1wLwL94EpTFTaBik7J7/2RJAFvYLDIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzYd6To2qWnEjrtCCDJCqIVHOo2HgbDRji6loqetztI=;
 b=FTCyNaOXuCqeXmfdkEGn28iyW5QP5imho3lCSmcy4ksDHlk/Qs+C+W/lzheqfaiGISFBSO00WcJJJ+NyOiOx5RgvzZn34hh/pUfZR4CkgHSHW/6DVcdgYHwv1OBJmI5X2rJy69phGx7Z3TjSoE47KSNsrQO5QPb8etcAq3PV3FY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7895.jpnprd01.prod.outlook.com (2603:1096:400:184::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 19:59:42 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Mon, 14 Nov 2022
 19:59:42 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
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
Thread-Index: AQHY+FQ3i7+8G/jXAEWaK/AAUJtKua4+wHcggAASNwCAAAGycIAAAUqAgAAAYhA=
Date:   Mon, 14 Nov 2022 19:59:42 +0000
Message-ID: <OS0PR01MB5922E8AC8C77B54A6572763B86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8tRKxpq4LiDDKd98MW27X7DnMEUw0FoL=8MLXK11tD-ng@mail.gmail.com>
 <OS0PR01MB5922E8CB8DB680347BEB997C86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8u0X2isaMWkPhyteqPnKLKEwcR1K=TOarQQMFb8UcGLvQ@mail.gmail.com>
In-Reply-To: <CA+V-a8u0X2isaMWkPhyteqPnKLKEwcR1K=TOarQQMFb8UcGLvQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB7895:EE_
x-ms-office365-filtering-correlation-id: 2f859047-ae31-4e74-63b8-08dac67ac56a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PS0fQFmOnKzBnxiwbuBpXGMphz5q9+0QLwEWuhWDfMzcb+DVhEu/0ZybgiDtbJOqbzt1KBS0/7xmPqvsG1Deg513HYerrSu3vwGLm7ibWsesT8T9ic7wHcTzpaUmlSqnXt0y3Ch8YjV59YmmdL/ScMdd/1ybv5HAet1aFjRth8SP0KqH2Sv76xi8u3dv9QAC+arxwvwHyHoEt3/naItipPFAFo3SZuF6mCLGaKR/2dXvRhpX1H9fnEqb+lZvNkEJq0VTIPc1GxFOY+1FI4THuKXYJWm6prMUJPJAPtH49ECsdPWQlUcuLLpH+srFz8afH9YXVceN+x8c/MS7WiFlHuZPEEMMCG/rif9iYGn8SO9hnHbiVCKeiIaVhVoyYlz/zldt0kgEZ2WpQGTeVU1kGlzc42q3Q5rly/U6Gf2rONdNPswQHQpWqgEb6WLgoIafcd2W8EsBHNW+heiaxqPtzL9h3yTVWCtiut7dDH3blZjNWO7jH2a8eR2b7m7KhI1InzdOhZUBE0zVNc5aejax4yruoIUpa90TJTh0RNRGygpUu9g55Ga9sZlsm6LLYylH3wu9n+hwTembZZ79IW8oWE2BGXfu+D6XnAP20UcZevi8BSZbWxwjffZmV0kahKjuZVL7W9AFAsI1tMc1w7idOOA043MmzhOOX7uusr1NxGw6LPX45vEYMLOrPnCcTUukA08sMSlHOEHQFUpINJlo8ckaO4N2QESuMWTinrWbujtSHA4G36iDrHanuAMkHZLqa/IUR/FStAopFYbYPpT4pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(2906002)(66446008)(66556008)(66946007)(76116006)(8936002)(5660300002)(83380400001)(4326008)(41300700001)(8676002)(53546011)(6506007)(54906003)(6916009)(122000001)(38100700002)(52536014)(66476007)(33656002)(316002)(86362001)(71200400001)(55016003)(478600001)(107886003)(38070700005)(64756008)(9686003)(7696005)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tjd6MDVnTjRzYXJGWWNMdDJZWjRxWWRQaDdJZnNUQytIbTFDeGE5WnRrNHZr?=
 =?utf-8?B?L0NTeHFLYlZZeGZkb2tpS1pMMjJaZnc0WEtkc2VQWkpVb1JmNUVRSFFtNy9j?=
 =?utf-8?B?eTk4bzdZU0xPelNaN2Zna29DS0pBMGZSZXMwckwySlhMWXF6aXQ4UFdiLzhN?=
 =?utf-8?B?cHNNYUtRcGIya3FPUDlqaDAyUlZRaFlDS3VJYXdhVW5FcFZOeW03WSsxb1N4?=
 =?utf-8?B?c0E3OTlRTGJ2ZXBOazl2SlZrL2dwcUkyekxQTHhUKzAvR2F1U3kxd0ROUUJ3?=
 =?utf-8?B?SU9lYWtUOUxyR3JDa3Mra0hpZUhrMlZrWUJucVFFcTR1TTU3YXJHdHl4VU1j?=
 =?utf-8?B?UzJLTVZDVDJ6VFJMV01icFdTNW0vUHZYWFBKQkNOdHJ5bFNaWXNvM3F1THZl?=
 =?utf-8?B?aWdoME9ndzI1NDMyUk9iNmU1WVg4dWtWTVRDRElBL0JrYmxFakx3UU94NUxO?=
 =?utf-8?B?QW9ORFlWTnYzNGp5Yk1qZnNvWHFHUGNJa3RtUXA3NTNaS3JXQlhnZ1Y2Smht?=
 =?utf-8?B?ZUZZSDkranhPV1l5eElhSm8rZUV2Z2R3cUpMZHhrdEZTeXREZkVqa0IzU2Z1?=
 =?utf-8?B?ZkVTZVBPZkFyUzkvSlNyYW83NUJFYldFVUlrNVpXejByWDB1bUI1UW1Mayto?=
 =?utf-8?B?c0dZM0VuamNQSElHQ3Z4SFBNT1phRmFZVlNwNWZIaWVhSG81TzM4T3poK3pG?=
 =?utf-8?B?N0RFaFhmVlNibnlBUVlVTVp5eDRpYWt1SXFkTmxhektwSG5xYmxqZHR0N2FY?=
 =?utf-8?B?VE11bUNIYXhhRjhzeVdGNmtXRnRkNU56bW4rKzhrVWRJSHdYQ0ZQRWlhKzVh?=
 =?utf-8?B?UEFtcHM0amFlWVpsUlQ4WXRnYTlxQis1dk85N3NxbDVUWVpUWnNBcDVQbHZx?=
 =?utf-8?B?SEppVk5JYXpya1l4aHFVdHJxOHFobG45ek5ya1VwVlNZZFo1dmRTKzJnb3pJ?=
 =?utf-8?B?UUdYS1Z5VnhrTnk2dFU1ZlUrZkl1MS9VY1AzQ3cyY2dIaEdYVk1mU0ZkVkVq?=
 =?utf-8?B?S3FIWTNuSnBPV0lVUVhlMmJnRUluZlY2VEIvaGxsTk5TTzRablA0WFFGK2Nh?=
 =?utf-8?B?M1crc0NmZ3U5Uy9PRUkzV2dPQ0R2ZEs0S1pJOW5EMmRkV0RrWXk3bmF5bXFJ?=
 =?utf-8?B?RVcyRXZVVUowYmpnb0N4amZNZEZOTklKOTN5Y0dWYmkyNWZTZGxFWWN1Z05J?=
 =?utf-8?B?RlB2bE9qOHVUVC9TOG9ReFBvZytnQm9yMklkbEpySEtqSzdWeU45Rkk3a00r?=
 =?utf-8?B?WjdkSjVvRm91UEY5QzR2VVJLK0VpK3pxVG81ZGttazVTNDVDa2FkT29yVjJj?=
 =?utf-8?B?bytsanhWRWszdEdjOTRyc284OVAyLytyRWFQRStBWSt6dVQrREExOTBBS091?=
 =?utf-8?B?NHI5K29pN01wamhoNXg3UW5yVWVtRXNEbjZ1OHNUaW0wOGptVXF0MlFBSnZ4?=
 =?utf-8?B?ZU1lZ2JGSDA2OWNvSGRSVngwTU1IVkJGdm5kVmtJenRZamZwUFBhVEhDS0V4?=
 =?utf-8?B?Wm11Rit4M0QycEoyK2pra0Zadkg0ZnV3aDhwQWorU3YyU3hsRmtnemxKVXNo?=
 =?utf-8?B?MUg3UlJvUHlySWphandnMFRGUlVlSURHd2VoWk01RDJ5bytHdnA0WFVCUGlT?=
 =?utf-8?B?cjY4M1c1T2loWXdVOCtxY0E0UlhZQ0JYS3VLazRRUlQ1cmNiVHRMaFI4aUdV?=
 =?utf-8?B?VDMzQ3M4c3Rwa3B0SWNVcHBpeXFKcGFCcy83UG14SDZjMDh2eTYzOHIzUWZW?=
 =?utf-8?B?OWo3bWFndWVsRC9tcVFyZ2tYS3BMbVZjRitjbk96QzJHQjgzL2F4cUlqdFJv?=
 =?utf-8?B?TlN3akZGc2lubVFQTWU4b2c1VDYwVmZsTldONHhRVm5GMXpmbU5WcUxLdDVQ?=
 =?utf-8?B?Y0NXUTR5VTVXQ3lhWWgzbW85MlpJaWNwRjV0Qm9Od2VSUXJRV3ZnMVN5Sk1i?=
 =?utf-8?B?b29lODNxdzIzTU41OVNjT2NXQzIwSk9JTmdFd0NlMlRocTdPZVNVUmtnT21B?=
 =?utf-8?B?SHdDN21IdlpuM0R0OGlFV29UZi93Nkd2Y1FkRVhXWm01cENBMFZIeUwzSzRa?=
 =?utf-8?B?V0t1YlhqNHlpTWp0TEthd3JSb0xWejNxYzJFbW44NHdjZnNRejBnMEgvRUlX?=
 =?utf-8?B?NUF0ZkIyUHZVNzNJVE9pL2JsSXBDVk5SdWVVUmtSZVF5ZDRrVlpzRGQ2TXgx?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f859047-ae31-4e74-63b8-08dac67ac56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:59:42.6583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlCBO7t4/+383g4r6osRKnQQRqtjsExicU7RaczSIh15hdWf9ACONePpSnVzZgMBh84BvaeeXIUkuquO+1Sv+bgc7q4zcPfJWJ7LOAQGWiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7895
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkLCBQcmFiaGFrYXIg
PHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KPiBTZW50OiAxNCBOb3ZlbWJlciAyMDIyIDE5
OjU2DQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgV2ltIFZhbiBTZWJy
b2Vjaw0KPiA8d2ltQGxpbnV4LXdhdGNoZG9nLm9yZz47IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJv
ZWNrLXVzLm5ldD47IFBoaWxpcHANCj4gWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+OyBs
aW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IEZhYnJpemlvDQo+IENh
c3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPjsgUHJhYmhha2FyIE1haGFkZXYg
TGFkDQo+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHdhdGNoZG9nOiByemcybF93ZHQ6IElzc3VlIGEgcmVzZXQgYmVmb3Jl
IHdlIHB1dA0KPiB0aGUgUE0gY2xvY2tzDQo+IA0KPiBPbiBNb24sIE5vdiAxNCwgMjAyMiBhdCA3
OjUzIFBNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+
ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogTGFkLCBQcmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KPiA+ID4gU2Vu
dDogMTQgTm92ZW1iZXIgMjAyMiAxOTo0Ng0KPiA+ID4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+IENjOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3Jl
bmVzYXNAZ2xpZGVyLmJlPjsgV2ltIFZhbiBTZWJyb2Vjaw0KPiA+ID4gPHdpbUBsaW51eC13YXRj
aGRvZy5vcmc+OyBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+Ow0KPiA+ID4gUGhp
bGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47DQo+ID4gPiBsaW51eC13YXRjaGRv
Z0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4g
bGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOyBGYWJyaXppbyBDYXN0cm8NCj4gPiA+
IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+OyBQcmFiaGFrYXIgTWFoYWRldiBMYWQN
Cj4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIXSB3YXRjaGRvZzogcnpnMmxfd2R0OiBJc3N1ZSBhIHJlc2V0IGJl
Zm9yZSB3ZQ0KPiA+ID4gcHV0IHRoZSBQTSBjbG9ja3MNCj4gPiA+DQo+ID4gPiBISSBCaWp1LA0K
PiA+ID4NCj4gPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCj4gPiA+DQo+ID4gPiBPbiBN
b24sIE5vdiAxNCwgMjAyMiBhdCA2OjQyIFBNIEJpanUgRGFzDQo+ID4gPiA8YmlqdS5kYXMuanpA
YnAucmVuZXNhcy5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IFBy
YWJoYWthciA8cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb20+DQo+ID4gPiA+ID4gU2VudDogMTQg
Tm92ZW1iZXIgMjAyMiAxODowOQ0KPiA+ID4gPiA+IFRvOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgV2ltIFZhbg0KPiA+ID4gPiA+IFNlYnJvZWNrIDx3aW1A
bGludXgtd2F0Y2hkb2cub3JnPjsgR3VlbnRlciBSb2Vjaw0KPiA+ID4gPiA+IDxsaW51eEByb2Vj
ay11cy5uZXQ+OyBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gPiA+
ID4gPiBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gPiBDYzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy0NCj4gPiA+IHNvY0B2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4gPiA+ID4gUHJhYmhha2FyIDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNv
bT47IEJpanUgRGFzDQo+ID4gPiA+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsgRmFi
cml6aW8gQ2FzdHJvDQo+ID4gPiA+ID4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT47
IFByYWJoYWthciBNYWhhZGV2IExhZA0KPiA+ID4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi0gbGFk
LnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gd2F0Y2hkb2c6
IHJ6ZzJsX3dkdDogSXNzdWUgYSByZXNldCBiZWZvcmUgd2UNCj4gPiA+ID4gPiBwdXQgdGhlIFBN
IGNsb2Nrcw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRnJvbTogTGFkIFByYWJoYWthciA8cHJhYmhh
a2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
T24gUlovRml2ZSBTb0MgaXQgd2FzIG9ic2VydmVkIHRoYXQgc2V0dGluZyB0aW1lb3V0ICh0byBz
YXkgMQ0KPiA+ID4gPiA+IHNlYykgd291bGRuJ3QgcmVzZXQgdGhlIHN5c3RlbS4gVG8gZml4IHRo
aXMgd2UgbWFrZSBzdXJlIHdlDQo+ID4gPiA+ID4gaXNzdWUgYQ0KPiA+ID4gcmVzZXQNCj4gPiA+
ID4gPiBiZWZvcmUgcHV0dGluZyB0aGUgUE0gY2xvY2tzIHRvIG1ha2Ugc3VyZSB0aGUgcmVnaXN0
ZXJzIGhhdmUNCj4gPiA+ID4gPiBiZWVuDQo+ID4gPiBjbGVhcmVkLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gV2hpbGUgYXQgaXQgcmUtdXNlZCByemcybF93ZHRfc3RvcCgpIGluDQo+IHJ6ZzJsX3dk
dF9zZXRfdGltZW91dCgpDQo+ID4gPiA+ID4gYXMgd2Ugd2VyZSBjYWxsaW5nIHRoZSBzYW1lIGZ1
bmN0aW9ucyBoZXJlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTGFkIFBy
YWJoYWthcg0KPiA+ID4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5j
b20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gTm90ZSwNCj4gPiA+ID4gPiAtIFRoaXMgcGF0
Y2ggaGFzIGJlZW4gdGVzdGVkIG9uIFJaL0cyTCwgUlovVjJNIGFuZCBSWi9GaXZlLg0KPiA+ID4g
PiA+IC0gTXkgaW5pdGlhbCBpbnZlc3RpZ2F0aW9uIHNob3dlZCBhZGRpbmcgdGhlIGRlbGF5IGFm
dGVyDQo+ID4gPiA+ID4gcG1fcnVudGltZV9nZXRfc3luYygpDQo+ID4gPiA+ID4gICBhbHNvIGZp
eGVkIHRoaXMgaXNzdWUuDQo+ID4gPiA+ID4gLSBEbyBJIG5lZWQgYWRkIHRoZSBmaXhlcyB0YWcg
PyB3aGF0IHNob3VsZCBiZSB0aGUgb3BlcmF0aW9uDQo+ID4gPiA+ID4gUFVULQ0KPiA+ID4gPiA+
ID5SRVNFVC9SRVNFVC0+UFVUPw0KPiA+ID4gPg0KPiA+ID4gPiBJdCBsb29rcyBsaWtlIHRpbWlu
ZyBpc3N1ZSwgTm9uZSBvZiB0aGUgcHJldmlvdXMgZGV2aWNlcyBhcmUNCj4gPiA+IGFmZmVjdGVk
IGJ5IHRoaXMuDQo+ID4gPiA+DQo+ID4gPiB5ZXAuDQo+ID4gPg0KPiA+ID4gPiA+ICAgaW4gY2Fz
ZSB3ZSBuZWVkIHRoZSB0YWcgaXM6DQo+ID4gPiA+ID4gICBGaXhlczogNDA1NWVlODEwMDllNiAo
IndhdGNoZG9nOiByemcybF93ZHQ6IEFkZCBzZXRfdGltZW91dA0KPiA+ID4gPiA+IGNhbGxiYWNr
IikNCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy93YXRjaGRvZy9yemcybF93ZHQu
YyB8IDcgKystLS0tLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvd2F0Y2hkb2cvcnpnMmxfd2R0LmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvd2F0Y2hkb2cvcnpn
Mmxfd2R0LmMgaW5kZXgNCj4gMDA0MzhjZWVkMTdhLi5kMTI3MWNjNzc1MGYNCj4gPiA+ID4gPiAx
MDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4g
PiA+ID4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9yemcybF93ZHQuYw0KPiA+ID4gPiA+IEBAIC0x
MTUsMTYgKzExNSwxNCBAQCBzdGF0aWMgaW50IHJ6ZzJsX3dkdF9zdG9wKHN0cnVjdA0KPiA+ID4g
PiA+IHdhdGNoZG9nX2RldmljZSAqd2Rldikgew0KPiA+ID4gPiA+ICAgICAgIHN0cnVjdCByemcy
bF93ZHRfcHJpdiAqcHJpdiA9DQo+IHdhdGNoZG9nX2dldF9kcnZkYXRhKHdkZXYpOw0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gLSAgICAgcG1fcnVudGltZV9wdXQod2Rldi0+cGFyZW50KTsNCj4gPiA+
ID4gPiAgICAgICByZXNldF9jb250cm9sX3Jlc2V0KHByaXYtPnJzdGMpOw0KPiA+ID4gPiA+ICsg
ICAgIHBtX3J1bnRpbWVfcHV0KHdkZXYtPnBhcmVudCk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAg
ICAgICByZXR1cm4gMDsNCj4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIHN0YXRp
YyBpbnQgcnpnMmxfd2R0X3NldF90aW1lb3V0KHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UNCj4gKndk
ZXYsDQo+ID4gPiA+ID4gdW5zaWduZWQgaW50DQo+ID4gPiA+ID4gdGltZW91dCkgIHsNCj4gPiA+
ID4gPiAtICAgICBzdHJ1Y3QgcnpnMmxfd2R0X3ByaXYgKnByaXYgPQ0KPiB3YXRjaGRvZ19nZXRf
ZHJ2ZGF0YSh3ZGV2KTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gICAgICAgd2Rldi0+dGltZW91
dCA9IHRpbWVvdXQ7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgICAgICAvKg0KPiA+ID4gPiA+IEBA
IC0xMzIsOCArMTMwLDcgQEAgc3RhdGljIGludCByemcybF93ZHRfc2V0X3RpbWVvdXQoc3RydWN0
DQo+ID4gPiA+ID4gd2F0Y2hkb2dfZGV2aWNlICp3ZGV2LCB1bnNpZ25lZCBpbnQgdGltZQ0KPiA+
ID4gPiA+ICAgICAgICAqIHJlZ2lzdGVyIHNvIHRoYXQgaXQgaXMgdXBkYXRlZCB3aXRoIG5ldyB0
aW1lb3V0DQo+IHZhbHVlcy4NCj4gPiA+ID4gPiAgICAgICAgKi8NCj4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gTWF5YmUgdXBkYXRlIHRoZSBjb21tZW50IGFib3ZlIHdpdGggbmV3IGNvZGUgY2hh
bmdlLg0KPiA+ID4gPg0KPiA+ID4gICAgIC8qDQo+ID4gPiAgICAgICogSWYgdGhlIHdhdGNoZG9n
IGlzIGFjdGl2ZSwgcmVzZXQgdGhlIG1vZHVsZSBmb3IgdXBkYXRpbmcNCj4gdGhlDQo+ID4gPiBX
RFRTRVQNCj4gPiA+ICAgICAgKiByZWdpc3RlciBzbyB0aGF0IGl0IGlzIHVwZGF0ZWQgd2l0aCBu
ZXcgdGltZW91dCB2YWx1ZXMuDQo+ID4gPiAgICAgICovDQo+ID4gPg0KPiA+ID4gVGhlIGFib3Zl
IGV4aXN0aW5nIGNvbW1lbnQgaG9sZHMgZ29vZCB3aXRoIHRoaXMgY29kZSBjaGFuZ2UuIElmDQo+
IHlvdQ0KPiA+ID4gcHJlZmVyIHNvbWV0aGluZyBlbHNlIHBsZWFzZSBsZXQgbWUga25vdyBJJ2xs
IHVwZGF0ZSBpdA0KPiBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IE1heWJlIG1lbnRpb24sIFRoZSBy
ZXNldHRpbmcgb2YgdGhlIG1vZHVsZSBpcyBkb25lIGluIHdkdF9zdG9wDQo+IGZ1bmN0aW9uLg0K
PiA+DQo+ICAgICAvKg0KPiAgICAgICogSWYgdGhlIHdhdGNoZG9nIGlzIGFjdGl2ZSwgcmVzZXQg
dGhlIG1vZHVsZSBmb3IgdXBkYXRpbmcgdGhlDQo+IFdEVFNFVA0KPiAgICAgICogcmVnaXN0ZXIg
YnkgY2FsbGluZyByemcybF93ZHRfc3RvcCgpICh3aGljaCBpbnRlcm5hbGx5IGNhbGxzDQo+IHJl
c2V0X2NvbnRyb2xfcmVzZXQoKSBhbmQgcG1fcnVudGltZV9wdXQoKQ0KDQood2hpY2ggaW50ZXJu
YWxseSBjYWxscyByZXNldF9jb250cm9sX3Jlc2V0KCkgdG8gcmVzZXQgdGhlIG1vZHVsZSkNCg0K
PiAgICAgICogc28gdGhhdCBpdCBpcyB1cGRhdGVkIHdpdGggbmV3IHRpbWVvdXQgdmFsdWVzLg0K
PiAgICAgICovDQo=
