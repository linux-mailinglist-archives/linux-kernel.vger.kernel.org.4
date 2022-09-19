Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05345BCF42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiISOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiISOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:38:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2120.outbound.protection.outlook.com [40.107.113.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3F273A;
        Mon, 19 Sep 2022 07:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObPELX7xCWt95bYloNNriQZ2wDhkpQpgpwRba+pL3OBF8BELUtCIlhvEeGrKJlrqINhvTekqHQVVls11uQnP1goEAqt11L5Et8F20JZNxNxHoahsbeJ1tLFIjwh2uqJYRfG5BPbZopHFUwb8Uen+N40GWmfgW3sSb2dk+R+08QRKLiGHcm8PECXX0SGwb4ZAqy378fxTv7kijZn9LNu3etTpXIAtewPtIJBB0TUiFxzjkJnHY5Wmok3YmhjfzI9IqSv/yMhVooNappDOGbCDfO/Apv9/RiRNrDlp8KZxFvauXxReXg0VmBzLvL8jUrZd8jg87CEOCg5NBjLDQL6Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mijxY2U1esX/PMfQUrk20/fPCFtbjwt7SSQUxKx5MEk=;
 b=EF6Q5lGlCpkMdrmKhDR7+prDCp8km5LhzswE805Pdtx2lYIlJcI0GZ1mmmitS8Bf8ixFSfW45q9+y9DV2SDnGvU2wo8zLdlFiJ+dJUXIdwmS7g5zJ9/8Nu99uw9cUSWh/MDTDG+HFzeuRkmo2kcJlNupiCtNEwWFvlqUeh7B9CCpnAlyYzkqQxhtfy4zTxAfu2mdIs7u0WmhNb/b9ur3kOsua7nwROm/UhbVYDueOON6AliHqddlNWWg+OWtdxLJiQhjeOOqWfjAQWjAUiZ8Mfa9VVVp8fsd89DbK/Na+cBOhzVRbEZv9fyp0LdewyjflkGE4xue1HSOtulQGSp/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mijxY2U1esX/PMfQUrk20/fPCFtbjwt7SSQUxKx5MEk=;
 b=eGRHK9dYytqhSJyaBM/Qdwoztl/+pjCSbBQoT/mKNKyju5h7k+lIL0DwjuPMnEOB6iTfE7MTFKpQWjOb87kfNtMbinehLfvQzTzs2yeOKvqV3ZYJBP0OEkBMt7icDz+i5LXOjNaIpZg4ipf7nZZk63MHuWA6VlleUIhKzm/vs4E=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10275.jpnprd01.prod.outlook.com (2603:1096:400:1d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 14:38:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 14:38:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
Thread-Topic: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical
 list
Thread-Index: AQHYzCwlVjlhhutYXUubI25P/bpXfa3mwNiQgAAA1QCAAADfEIAACcsAgAAFgUA=
Date:   Mon, 19 Sep 2022 14:38:44 +0000
Message-ID: <OS0PR01MB592278FB3E443C84130FCA7D864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com>
 <OS0PR01MB59227B5F87C7FC3CEC271B0A864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utdkb61v_1=G85O6OCtQDv-+5YuyFy4r7BW+fR2E=WkQ@mail.gmail.com>
In-Reply-To: <CA+V-a8utdkb61v_1=G85O6OCtQDv-+5YuyFy4r7BW+fR2E=WkQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10275:EE_
x-ms-office365-filtering-correlation-id: acaa53b7-3b40-4121-d103-08da9a4ca7ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPfmKaJ+KUugx+GNBxt90nTmhkRxLGfvEIqsNA+9NOHUHPOD5sIWZOaNp6agh1X8aVY7xzseoh9/WTXeUrQdUBLCFxq93rQTlYX2GRAGiR5CNGTmGEj6wPqs/Hg6o0Dd69PlvpZa1GjuSh8s4igAmZHfmKSQc7MFM12FrQS4+LbOO1i9GgtNE+xeApkuSS3FdHvFICyya21jySyLSZYpUiYLAbI0ydSgc260RKZbSqzNOiVsGXlPN9jBHAXibjoApEblRbK5kRd3cPMLF+Q4FRkJuV/Vo4JfWPuwkIcx97dmeTTa+j+Unbh+twXe/eVM3Lpok2sLHXDr9ZxxMP7jWfE3gmhBNMxCa7kEuqB8myL+Rwpl36OiNKKBivH6zc+pg7xDDMLeR9Z0vaMaPksN8OBsY8g4DJ9i+XxtMZrwEFPJ3fFuN37Pm23C2b5V3+iY4r+rOkjFrIUpgRwpPvtr4tI3yi9Lz/Fgwcp2OXOgXGsYRXrF+Fq/pFVuxTay3NcWN8MEU2ozoxSpggCzgMgDRMdWG6xVGdU/l/yYc7LhIvEICA+UyY+kg8p7CFJLZbDxAsuJDEf9tBYXStnIrNjJ/4rtFaQUW6P5BCXpvOh/8MOilJ3naOZSKksGDB6MOmcSiKZxctZTksbr+PYI2mIolP3lGSO/x+zNNJ12Cool0od6HkuW/ioj+suYpJmL4BQ4tnybkXoMbQZZnfBXoyW8dj36xOEaalSwLhgEkrO3R46WvG1Mh+wtOMRu7uuNm/ayYOliJRangQeD9lcj3Yi8mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(6506007)(4326008)(7696005)(2906002)(38070700005)(66446008)(71200400001)(86362001)(38100700002)(55016003)(26005)(53546011)(8936002)(9686003)(76116006)(8676002)(66556008)(33656002)(66476007)(122000001)(66946007)(64756008)(41300700001)(107886003)(478600001)(6916009)(54906003)(83380400001)(316002)(186003)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDk1N3JVQzcyU3ptc0NlenNaTm1oT0Vzc09RQ2dueUYrV0ppRXJyUDRhKzRE?=
 =?utf-8?B?QjR0R3F5MnlGSXhLUE1JWmpyWmJCK1h5b2ZPRnhONjFmZjN1RFpkeG5jblk1?=
 =?utf-8?B?RmZMU0J5WTB2VkFaczJiQyswSjd0dVM1bnhwbzZ2aXQ1U29JbTc5TmhkRlkr?=
 =?utf-8?B?bW5VaEtvVGM0K2xxTHZsUlcrWFRONzgwRmd2NTJGU0p0aTltZXZSYzF4cU1S?=
 =?utf-8?B?NkJ0b21kK0pJTGF6NkdxR3NkSDNjcHJDUVl2SG1YaFhvem1uYy90Z211V3BO?=
 =?utf-8?B?TTM5ajVMeFprUEhKWURkM1phdzNwRHY1SnhFTEdWNzVlSnhSeTNXK1RBVFpY?=
 =?utf-8?B?YWt6ZExMYjl5R0RLY1BlamFKUko3T2JBcUlKTGZ3NHgrVzZpaEY2Wjh3bCs2?=
 =?utf-8?B?Tkc2ekpKSVQxblAzNGt1TGJ4MUlld0hnUllLeHlNT0VqeldHNEMwZXJSQnhw?=
 =?utf-8?B?TzJYOEVYUWNtY05nZy9VUG03b0ErUVc2cW9kTGRJR3dkQUtOUVJONFBkNzdR?=
 =?utf-8?B?dUt1U1llWVlhUHpEb2puSVVQTFJjTFpGR1BjSndBemF5UU9rZ0FDbWh4NGJH?=
 =?utf-8?B?bEI1anF1WkVtYXBPQnRPV0J2UldIM1htNThlMnEwZWloM2dzcklFTENYcUQr?=
 =?utf-8?B?cFJFaEE0Tk9GTSthTDNjVEt5Nm5ubkZlazFyOTJxQjh1SUhpN3RiYmxUWWRU?=
 =?utf-8?B?OXQydzNaSGJiRTZ6OExlcmNOaXcrVFRyMGltZW5OSVdMK3RPeVVCNll3MzRJ?=
 =?utf-8?B?N1crazFpb25zMGtGSmtveEJWVzdTa3R1Z016dFNPVGNBMnV4Wng4TXo5Z05I?=
 =?utf-8?B?N0NZK3NxNVZkejdqRjJ4NUJUT2hCWDZMVFBqbjg3aGZvb2R3WDV1Mys2clhO?=
 =?utf-8?B?OXR4bHY3bkwrSGhWQ2dRZkppOUM1dGc3R0I3ZHAwRWdHTm5RWFFXRnFnazVi?=
 =?utf-8?B?cEhHbG5wU1pZa0NyMmZ3TmFWdTdrMDQ3Um83QkMrNHhzZE5Yd1REYXpmNjlo?=
 =?utf-8?B?cEtZSUpEcWF1VmtIVEQ2WlRnS0hUSnY3R0ZFbHRJeXBJVW5qZnZqWXAzVStR?=
 =?utf-8?B?NzQ3Qnl3SUF4YnVacUtyZGNJamRFZXN1OWYzVEpVRDdPYzRJRjI1RStsK1pY?=
 =?utf-8?B?S0pGZG1mbEQyWStnSjZaRmxMSXhRK1lwbjlDMWlmV3pDRExlREV1R29CZXht?=
 =?utf-8?B?N0FtVWoyc2ppZEw1ZWI3R2Q3OXZ6OGthOFRlOWhzVDNrL29mWFZmZnJ1UjYr?=
 =?utf-8?B?emtuL0IyaHJVaWZKK3Z2SGVqNEM0V3dHczZsOVFXVzh3cHNBcnpOR3NaTU9l?=
 =?utf-8?B?NXFGUUNmR2RwQlRHK0FicW1VMmxYYXBMT0JuYlJTRThWMytLeXNlMjhQNGp4?=
 =?utf-8?B?SytIa1ZOMVFsOXBIYjc3YklyL1ZiV2JMc1M1WG9TQ2Uxcm1zdEU2NWp3dmkr?=
 =?utf-8?B?VFJDVmdiNkRLOVY0bDBLQmNjMEUvR1pyYkRhOE9vbGZ1dnhaMDN2RDVxdG5p?=
 =?utf-8?B?TDZoNzFxSEVibS9FR09LMXI0ZGdZMW1rRmJrMUlRSzd2K0l4TCtqU2RMbFhm?=
 =?utf-8?B?V2d4KzFBRGVtTDIrajVqTllCL2xUUTM3YlowVFhhcjBKc0hXR1Fya3dxQWRp?=
 =?utf-8?B?WFhYcWovaklzMmNVVEYzbmNlM1l6T0hhbVBjYjRIWnorNmN2emV4MFNtRWNT?=
 =?utf-8?B?MXpncG1iQ1VWeXJwODFXNTcyZS9NQ1JZSVBQbXVoanRKU2kvQXBTMTBGS2VR?=
 =?utf-8?B?T05pSHRSWFByU3NRVnJPa3F1SUN2eDdhUXNvK09RdHFOeHN3NGxFVGFhdjRV?=
 =?utf-8?B?ZlFLMlY5TE51Yi81Uk1NU1RDMVNWdDA1QVNlcTNjWVVMNkRhUUIyajdjWkM0?=
 =?utf-8?B?Tmphbk9XZnhISUxlYVd6OURDMHJIVUpiMDAyZS96SXY4YlpRVzVOeHlzS1h1?=
 =?utf-8?B?OE9wcklDTHA3VTJJRktuRXRlZlU1NmhoUzJZU3djaTR4Z3VwRGdsaUhDOEg1?=
 =?utf-8?B?Z3V5RmRucmRGSndZOStUb2twTkpGejlOTnJRQnU4Z3ltTGw5THY1NjVzdzhv?=
 =?utf-8?B?ZFN2SS9SQXB0cG5SOWttYk1Uc2lnZDVaaGgyR25WWW5lL2VqQnZNMnNSZmVL?=
 =?utf-8?B?UXdGR3ViM1dYNVlGV0NHYVNxNnM4eTBJRDN2ZlNNQW5kM0Qxdks4ak9NWEFN?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acaa53b7-3b40-4121-d103-08da9a4ca7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 14:38:44.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWDOWf4JUGlKXAjRtd2+5CHMrEZ+SlPt/xL4CHis8EZreLfxwgokl0aXQrzYTW18niFsdQw5KHXlpvJMLxkvzlIZ4mm9OQy8CGdNHQ/GQaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10275
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhYmhha2FyLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNsazogcmVuZXNhczogcjlh
MDdnMDQ0OiBBZGQgV0RUMiBjbG9ja3MgdG8NCj4gY3JpdGljYWwgbGlzdA0KPiANCj4gSGkgQmlq
dSwNCj4gDQo+IE9uIE1vbiwgU2VwIDE5LCAyMDIyIGF0IDI6NTIgUE0gQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpIFByYWJoYWthciwN
Cj4gPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xrOiByZW5lc2FzOiByOWEwN2cwNDQ6
IEFkZCBXRFQyIGNsb2NrcyB0bw0KPiA+ID4gY3JpdGljYWwgbGlzdA0KPiA+ID4NCj4gPiA+IEhp
IEJpanUsDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBTZXAgMTksIDIwMjIgYXQgMjozNSBQTSBCaWp1
IERhcw0KPiA+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gd3JvdGU6DQo+
ID4gPiA+DQo+ID4gPiA+IEhpIFByYWJoYWthciwNCj4gPiA+ID4NCj4gPiA+ID4gPiBTdWJqZWN0
OiBbUEFUQ0hdIGNsazogcmVuZXNhczogcjlhMDdnMDQ0OiBBZGQgV0RUMiBjbG9ja3MgdG8NCj4g
PiA+ID4gPiBjcml0aWNhbCBsaXN0DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBMYWQgUHJh
Ymhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBBZGQgdGhlIFdEVDIgY2xvY2tzIHRvIHI5YTA3ZzA0NF9jcml0X21vZF9j
bGtzW10gbGlzdCBhcyBXRFQNCj4gQ0gyDQo+ID4gPiBpcw0KPiA+ID4gPiA+IHNwZWNpZmljYWxs
eSB0byBjaGVjayB0aGUgb3BlcmF0aW9uIG9mIENvcnRleC1NMzMgQ1BVIG9uIHRoZQ0KPiA+ID4g
PiA+IFJaL3tHMkwsIEcyTEMsIFYyTH0gU29DcyBhbmQgd2UgZG9udCB3YW50IHRvIHR1cm4gb2Zm
IHRoZQ0KPiBjbG9ja3MNCj4gPiA+IG9mDQo+ID4gPiA+ID4gV0RUMiBpZiBpdCBpc24ndCBlbmFi
bGVkIGJ5IENvcnRleC1BNTUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGlzIGlu
IHByZXBhcmF0aW9uIHRvIGRpc2FibGUgV0RUIENIMiBmcm9tIHRoZQ0KPiBSWi9HMkwNCj4gPiA+
ID4gPiAoYWxpa2UNCj4gPiA+ID4gPiBTb0NzKSBEVFMvSSBieSBkZWZhdWx0Lg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gUmVwb3J0ZWQtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyDQo+ID4gPiA+ID4g
PHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gPiAgZHJpdmVycy9jbGsvcmVuZXNhcy9yOWEwN2cwNDQtY3BnLmMgfCAyICsrDQo+
ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA3ZzA0NC1jcGcuYw0K
PiA+ID4gPiA+IGIvZHJpdmVycy9jbGsvcmVuZXNhcy9yOWEwN2cwNDQtY3BnLmMNCj4gPiA+ID4g
PiBpbmRleCAwMmE0ZmM0MWJiNmUuLmNmOWIxYmQ3Mzc5MiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA3ZzA0NC1jcGcuYw0KPiA+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvY2xrL3JlbmVzYXMvcjlhMDdnMDQ0LWNwZy5jDQo+ID4gPiA+ID4gQEAgLTQxMiw2ICs0
MTIsOCBAQCBzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50DQo+ID4gPiA+ID4gcjlhMDdnMDQ0X2Ny
aXRfbW9kX2Nsa3NbXSBfX2luaXRjb25zdCA9IHsNCj4gPiA+ID4gPiAgICAgICBNT0RfQ0xLX0JB
U0UgKyBSOUEwN0cwNDRfR0lDNjAwX0dJQ0NMSywNCj4gPiA+ID4gPiAgICAgICBNT0RfQ0xLX0JB
U0UgKyBSOUEwN0cwNDRfSUE1NV9DTEssDQo+ID4gPiA+ID4gICAgICAgTU9EX0NMS19CQVNFICsg
UjlBMDdHMDQ0X0RNQUNfQUNMSywNCj4gPiA+ID4gPiArICAgICBNT0RfQ0xLX0JBU0UgKyBSOUEw
N0cwNDRfV0RUMl9QQ0xLLA0KPiA+ID4gPiA+ICsgICAgIE1PRF9DTEtfQkFTRSArIFI5QTA3RzA0
NF9XRFQyX0NMSywNCj4gPiA+ID4NCj4gPiA+ID4gRG8gd2UgbmVlZCB0byB0dXJuIG9uIHRoaXMg
Y2xvY2sgdW5uZWNlc3NhcmlseT8NCj4gPiA+ID4NCj4gPiA+IE5vLCB0aGlzIGlzIGluIHByZXBh
cmF0aW9uIHRvIGRpc2FibGUgV0RUMiBieSBkZWZhdWx0IGZyb20NCj4gUlovRzJMe0N9DQo+ID4g
PiBEVFMvSS4NCj4gPg0KPiA+IEJ1dCB0aGF0IHdpbGwgbWFrZSBXRFQyIGRldmljZSBpcyBub3Qg
ZW5hYmxlZCwgYnV0IHVubmVjZXNzYXJpbHkgdGhlDQo+IGNsayBpcyBvbi4NCj4gPg0KPiBBZ3Jl
ZWQgdGhlIGNsb2NrcyB3aWxsIGJlIE9OLCBidXQgZGlkbnQgd2UgYWdyZWUgZWFybGllciBmb3IN
Cj4gcjlhMDdnMDQzLWNwZy5jPw0KDQpZZXAsIHN0aWxsIHdlIGhhdmUgYSBjaGFuY2UgdG8gY29u
Y2x1ZGUsIHdoZXRoZXIgd2UgbmVlZCB0byBtYWtlDQp0aGlzIGNsayBhbHdheXMgb24sIGlmIGl0
IGlzIG5vdCBlbmFibGVkIGFuZCB0aGVyZSBpcyANCm5vIHVzZSBjYXNlIGZvciB3ZHQyIGNvbnRy
b2xsaW5nIGZyb20gQ0EtNTU/Pw0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+ID4gTm90IHN1cmUs
IElmIHdlIGhhdmUgYW55IHVzZSBjYXNlIGZvciB3ZHQyIGNvbnRyb2xsaW5nIGZyb20gQ0EtNTU/
Pw0KPiA+IElmIHRoZXJlIGlzIG5vIHVzZSBjYXNlLCB3aHkgY2FuJ3Qgd2UgcmVtb3ZlIGl0IGZy
b20gU29DIGR0c2kgYW5kDQo+ID4gY2xvY2sgdGFibGVzLCB0aGF0IHdoeSB3ZSBkb24ndCB1bm5l
Y2Vzc2FyaWx5IHVzZSB0aGlzIGNsb2NrDQo+IGFueW1vcmU/Pw0KPiA+DQo+IEkgZG9udCBoYXZl
IGEgY2xlYXIgdXNlIGNhc2Ugb2YgdXNpbmcgV0RUIGNoMiB3aGVuIHRyeWluZyB0byB1c2UgaXQN
Cj4gZnJvbSBDQS01NSBlaXRoZXIuDQo+IA0KPiBDaGVlcnMsDQo+IFByYWJoYWthcg0K
