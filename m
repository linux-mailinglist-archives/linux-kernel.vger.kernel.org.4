Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36449629184
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 06:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiKOFde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 00:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiKOFdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 00:33:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2FDDB;
        Mon, 14 Nov 2022 21:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668490410; x=1700026410;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Bzw7syRZrAZHfxfKmQhcCaKZuiunvTG7kMseji7LSGA=;
  b=qJUQ1SL85H6dZ8deQmMBS9NQY2PGPEJ846Es1+hDnNVpNfhe7VnN11vj
   bMpzHuTThrIJf+GWO08U8N+j+3H/dz47GX07qA9jv3FwXyqYOjDV/2CMo
   ZjbFWA7urJJCvnPmTGDokJVWabgG+e85XHb44YlWy9F+Oap5b7O8wV8pN
   FVsB0c6F89Y6ko9PYXCsy1wUVfLWCiMQ96b3lm5r4llJhZwmzlUQvzjzl
   LSCMv+3Mn1JW5ACyB8k317KjbJp5ALtsW/HkGZeffsYYpL/7lm6PFXKUJ
   yRxRitLBrQu51JubLokMk54XJ5loahbM8mHl0LURGYdgRm98u0Vwcw6K1
   A==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="123431456"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Nov 2022 22:33:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 14 Nov 2022 22:33:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 14 Nov 2022 22:33:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJhtGjJTCKUlI0a7DCnQIlnolEu1H6U6w81UXvJ/KgXOA9fqqe9f7xoMNwfCfvmLro4ggfjkk6dtFHHvmvE2IObUg065bZTNHwKATYGXjArusLG7HWq0ZJIT/L8koOe9H/N2ngLcuDL3YiiDPRTHFTgYfGsOWKqVhh3KSrvixazL+CorIkPQtLeIf4Y1x3dvUaiyp2dMoVhFN8Q/KLBYg3YkzhuTqSdtG6GklflsTTF+/FWHxmSUSf8XDVzRleYCi0vonmSLWMwEwWnyLsRqF7cRp6Vc11VtAP2u1vrlDfNw6qreNGOdaNaUG9rOJUtEUpRvuEqTE7biFRcwS57pNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzw7syRZrAZHfxfKmQhcCaKZuiunvTG7kMseji7LSGA=;
 b=Wi1YzDs7WZ8YJMSEwIkh9IngYyGi/gnHdvzhM3XEFVNSAWhAqajWjhM3Yd0fw9XcCO2Ilr7zNskmL/XZn3zMTulFcmNcxZoEMwHXGB/7debr6oGo5jVvU1ehLo4rbxEUky5Ng2QQG95lu6+baheHf8b8lH4enTnxmJ0dxJjrfEgPZum+9vMIRyYnb18vxj9BpZvUB1A5WabkOQBtb3zDmzOfRaihTj1W+X+BXn4itRcBP2y3kD4sMOEx6SjtCCiTz1/eHmskzloxuoQlE4Qb77/RxqKSklB2POO16Fhg3PNMEIB13YQX2MUps2nqPXTNbqH2AATCitj4iQC6/dPIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzw7syRZrAZHfxfKmQhcCaKZuiunvTG7kMseji7LSGA=;
 b=HZfDdYfx30YKKmMVBbMK6XA7aBYZ4A9gNu64WAtA43et+mnY13rO0Fvko8lIVyCqAYfX0+mk+mUQ5V6leAzRekCIOh60skgq5jUiRKG6QCS9MrNe2sXBfeKi21U2PLA9zrDmLr2gppRhqiY2VbdEAGJoYal5kzupPOOuJtjhjIM=
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Tue, 15 Nov 2022 05:33:22 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::c758:1337:ced7:bac6]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::c758:1337:ced7:bac6%5]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 05:33:22 +0000
From:   <Durai.ManickamKR@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Manikandan.M@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCHv1 3/8] ARM: dts: at91: sam9x60: Add flexcom definitions
Thread-Topic: [PATCHv1 3/8] ARM: dts: at91: sam9x60: Add flexcom definitions
Thread-Index: AQHY7NojOiWV0pa21UyKefnNJhEH6a41FOIAgAp49YA=
Date:   Tue, 15 Nov 2022 05:33:22 +0000
Message-ID: <cdf28cfe-2407-b416-742d-939b361c454e@microchip.com>
References: <20221031033653.43269-1-durai.manickamkr@microchip.com>
 <20221031033653.43269-4-durai.manickamkr@microchip.com>
 <ae1744a5-c042-7549-10ad-6185c0d007ec@microchip.com>
In-Reply-To: <ae1744a5-c042-7549-10ad-6185c0d007ec@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6541:EE_|MW3PR11MB4682:EE_
x-ms-office365-filtering-correlation-id: 1e0b2a54-18ad-40f9-7717-08dac6cae943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KjsBRzpkuPOcRoX9E1N9HQDjsU06pW66+lhltUvRCrykRC7VtRsTVVn5lq0gEMZ/j6Rgs9RY9Sdi10/GurSJcBtP+flSaP7X3Dg0QMM9+tdhvU+OjszC3JiXgCKGQ4jjLEfz4DCyaf09siGedWEbRE8VgbXCs29Fyji4LwqJ8vYglfTqqT9QSrX9vt+vorNjThGF4THDJ7cRBO8YV9D6hnYJIgFsdIctupXF6Kw/ypmVaDgbKiOlA5lhhukhWxaneQMTuVPlXU/0QYE+v8171QkG99Qv49hXbwTh60+/NK6WKCY273Ju1AFdvuu30XcT6xQ9W+CWiVNYKe5QtvUtMepBlKZcbcaldpAVA6ZaBHN55wSn7ZyftYG85mxL/PK1b7We1UvOnG11HWkTZbHvgTJE88vh1PSb4hasX6ztU2Xzc1bGasmQsDN0FzRzT83ZOgi+qiqSX2bgxT8LJbPlbcYtS9Zl/EFTEo0+3AQ5vN3QOdR+IKm+cvXi63Ku/T1O6RgeM+orEzibFVLV/+i+hOeg1CEZV7wqO928Gj8vjktt3gycxBYLc+IEKRyIM+fgUFETATV9WvZnZOiL8NEuctLYkVyjxQ8tiBJcIB3tdKv5dSYrvx7ZQBcPtK16gNY8tG37y3UuSUDdx4BdWH5Hlw9bWpOteQrYJcVTMxRkDRIa8IjHtOVE6x/8QNp1tC5nsFoBMI+5TQJGC/4muMeS3OpCC8MbECGQTjH/n8O5NipYiuqHFLI+JCz8TwPgncGZmt2b2C+aFR8cmq8zw8X4lWeyGnr9dyl2DMrrowwSmRKTX1SxZV0MKIVQyRdV9REO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(122000001)(921005)(38070700005)(36756003)(31696002)(86362001)(38100700002)(31686004)(316002)(6636002)(53546011)(76116006)(26005)(91956017)(6512007)(6486002)(71200400001)(66946007)(6506007)(110136005)(478600001)(2906002)(5660300002)(83380400001)(66556008)(41300700001)(66476007)(66446008)(64756008)(8676002)(8936002)(186003)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2MrMmlBWCszWlVtNGhoNlVVQnZtVXJlWDFDMGhwYWw3WElGRE9ubUxzUEcx?=
 =?utf-8?B?OGpXL01SZ1R1UExHSzR0SUUrVzdMQ1czeDJ3RWZkdDVJWitTTkQxU3pKZ1Vr?=
 =?utf-8?B?MThzckJ6RTZtUkVyQ05aZzdUa0JSV0RHeHEwbE0zVUgzS0ZBT1c4REc1OHNn?=
 =?utf-8?B?Rng2UDFiNXRyQlNocUFLN2lFM2dlZmNNQ2ptNDJ0R3FmUUlyMEwwSmIyWFlx?=
 =?utf-8?B?Q2hKQS81L0hvcll4TjZUdEJGSzFLbytiMVVlUitweGd0N3FpeVlVTi9HSTZj?=
 =?utf-8?B?VEwzblc4VnkxaW5KMXcwQ1ZhU1VEQWNkcE8vRTJwZnFtdmxQbFplNmYvOEkx?=
 =?utf-8?B?L3ZMdXJuTFhBVnJSQ2VJK1hLMkcvVTBFSnFLOFNIOHAxcjFjTTBYTjVjMVU3?=
 =?utf-8?B?N2JiWCtrVUkwVThIYVlkYjBZeW1IY2JWQUtBZmRXNWtwY2g4Z2tMS1ZEVUtM?=
 =?utf-8?B?RjlWdEl4amF6c2lNRjFocnJLekkreVowYmZQc3BVNk9qVDlUYzFieFNHN21h?=
 =?utf-8?B?UElIMVpWaHBtS29tRGJ0T29KKzJYYU44eXRwQWIvVGZOZEpGYytPWGlyY1hI?=
 =?utf-8?B?VzRmY3FRYTFzVW52SkN5T0VPNUdiTFJScE12bVFoMGhFUmVBOFRpMFZCMHBa?=
 =?utf-8?B?VnQ2Zlo1Z1htRnNHc3JwaWpGejNWWlVGY212Unkza1BBRzNQd1lyNSs1NGNi?=
 =?utf-8?B?Ti8vMW5GckpiT3pRT3JGNGlvTFlPdk54bVI2d3JYTVE5cnVkdVZZanJuUEVO?=
 =?utf-8?B?UVdGakNwZHk2RXlqeHFYR0g4ZU05VVFza0hQaXp2bmR2RmpzSlovZE1hbmts?=
 =?utf-8?B?MjhJeFA2YVdneVp4d1VGT0VCaXljR3pwa0JoRFdOaFFPZm50bWIvcXl0eHRk?=
 =?utf-8?B?c2dqYU12TGZqaUdmQ1lLWCtxTk1VZ3Q3OGZHOEFRTTdYQ0xrc2VsWnNxOWlz?=
 =?utf-8?B?MWtodHVNUS96cVFucDdGRVZUZlVBZUZOWS80dFcrdXoxTzd1SFk3WDZ6M0pn?=
 =?utf-8?B?d1daTEFyemt5am4yNmZ3Sk8vdi9oV0wvVmNBYjNyZ0s3K0YzclJBYzRqRHEy?=
 =?utf-8?B?WFN6a1FWK3I4NGpqNnVVNWJ5RC82R3ZhMi94aXMza3g5a0RYZWFUSGUvcDFq?=
 =?utf-8?B?Mll1dkkwek9GazRocmEwcHdjY1RGeEpBZVk2WEE2cjNwN1ZGa3kyNHlLZ2pZ?=
 =?utf-8?B?bkh1SUdic3RNcEJVNTVOWXl5ZjBRbkowUjd2Y2FSRVp3K1ZsbjdEZko1Z1lQ?=
 =?utf-8?B?VGRrUys2dDBsK2JZcVZSTjJjVVVZc0RKYm4wN3Vkak1mT2ZqZkIrQ3FmcVdk?=
 =?utf-8?B?N3NYZnNKMHlWemF6S1plUjZGN2VlbDU2NkVidXZONVc2NVRNMUpKRS9QZkxL?=
 =?utf-8?B?QlJkcjEyeGdVbG1Qai9BQlB5OWljZFpiaDRlRlphQ1RWTEptMkJvb0VHRFFv?=
 =?utf-8?B?NHcvTGFIT1Vpbm1oZHBXcGF0WDhUemJUeDZid0haa1U0WGp4bjBaSzQ3bm53?=
 =?utf-8?B?VFVJMVJCSEtYZFFGSmZkMHQxbndGUWRoY3pLY010a3Y4Qm9US1JlcXh2cldW?=
 =?utf-8?B?ZE1hVmZicWdmK1lMdUE2VzhpUVZOOWl0WTZUYzF2TW1qOEZEcEh4QWJZeklD?=
 =?utf-8?B?SVkrbHZzM05vYjd6d21IdGVWMTFBcjhMa3Y3emllcDlmSjZBdFJQd093RFdM?=
 =?utf-8?B?NGZBNlVkcG9mTDI1OTJPeHowU09nTzZ1QW9EVUg4NDdGVzR0YWp3U1BnSTVG?=
 =?utf-8?B?bGhrSUk2YWZibjRGa3BENnJCcG8zSFdBNXdmbHpDd1ozaEZsZXZ2eW9TQjZZ?=
 =?utf-8?B?bHFNbXFHaVU2TnVpUC9aZjBlcWNXcGhBT2piMEVCQ3lnZHhwZktWOTgvdUJ0?=
 =?utf-8?B?Mm9nZVo2K2xZQWFnTllId1IrYWYyVG1NVEVFbEJsRE5QVDhEd252eFdIVGdY?=
 =?utf-8?B?N3VDU0MzRUplVGRMOURTclE2aHVyWlRnRmsrdWszR082TnRiKzZGRFB4czhN?=
 =?utf-8?B?VGxFSk1QbWpJM3hNclBRR3hXeWNvcXFrNUFrVnM2TXVxRGl6QjRTcld5U2hu?=
 =?utf-8?B?dzBYcXRDcDlBd1BpSDhSamZMUVQxSG9tTSs0S2hZb3FZME0zVFpXNVRocEc4?=
 =?utf-8?B?dm1TWjJOVGZrcnVTMlNNZDhiYzBOTXJRbUFTUWM2ZkxjTHYvSTR6QWpFQjVH?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AF750014F986F49A8C6B1E96987CA2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0b2a54-18ad-40f9-7717-08dac6cae943
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 05:33:22.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBsIftT2hGpz903F6/T3hQqdrKBBaI+Fp8PbRGn3OnYhcSiTRwNLcm7vkm8Izq9mp4RxFrrkcFRrDX20aOWiJ8N7VLLkWHjxBJ6na3aloaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMTEvMjIgMTk6MDcsIE5pY29sYXMgRmVycmUgd3JvdGU6DQo+IE9uIDMxLzEwLzIwMjIg
YXQgMDQ6MzYsIER1cmFpIE1hbmlja2FtIEtSIHdyb3RlOg0KPj4gQWRkIHRoZSBmbGV4Y29tIGRl
ZmluaXRpb25zIHRvIHRoZSBTb0Mgc3BlY2lmYyBEVFNJIGZpbGUuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogRHVyYWkgTWFuaWNrYW0gS1IgPGR1cmFpLm1hbmlja2Fta3JAbWljcm9jaGlwLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEhhcmkgUHJhc2F0aCA8SGFyaS5QcmFzYXRoR0VAbWljcm9jaGlw
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW5kYW4gTSA8bWFuaWthbmRhbi5tQG1pY3Jv
Y2hpcC5jb20+DQo+PiAtLS0NCj4+IMKgIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSB8
IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+IMKgIDEgZmlsZSBjaGFu
Z2VkLCA1MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kgDQo+PiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L3NhbTl4NjAuZHRzaQ0KPj4gaW5kZXggZWYwN2QyODFhM2RiLi5mZDRmNWQ0M2Y3YmIgMTAwNjQ0
DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kNCj4+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPg0KPiBbLi5dDQo+DQo+PiBAQCAtMTgwLDYgKzE5
MCwyNiBAQCBmbHg1OiBmbGV4Y29tQGYwMDA0MDAwIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MT47DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJhbmdlcyA9IDwweDAgMHhmMDAwNDAwMCAweDgwMD47DQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiAr
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVhcnQ1OiBzZXJpYWxAMjAwIHsN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0g
Im1pY3JvY2hpcCxzYW05eDYwLXVzYXJ0IiwgDQo+PiAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQi
Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDIw
MCAweDIwMD47DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50
ZXJydXB0cyA9IDwxNCBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYXMgPSA8JmRtYTANCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChBVDkxX1hETUFDX0RUX01FTV9JRigw
KSB8DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMCkpPiwNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwmZG1hMA0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKEFUOTFfWERN
QUNfRFRfTUVNX0lGKDApIHwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBVDkxX1hETUFDX0RUX1BFUklE
KDExKSk+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYS1u
YW1lcyA9ICJ0eCIsICJyeCI7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCAxND47DQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2stbmFtZXMgPSAidXNhcnQiOw0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0bWVsLHVzZS1kbWEt
cng7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXRtZWwsdXNl
LWRtYS10eDsNCj4NCj4gSXNuJ3QgImF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47IiBtaXNzaW5nIGlu
IHRoaXMgYWRkZWQgZGVmaW5pdGlvbj8NCj4gSGkgTmljb2xhcywNClllcyB5b3UgYXJlIHJpZ2h0
LiBJdCBpcyBhZGRlZCBhcyBzZXBhcmF0ZSBwYXRjaCBpbiB0aGUgc2FtZSBwYXRjaCBzZXJpZXMu
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gImRp
c2FibGVkIjsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQo+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkbWEwOiBkbWEtY29udHJvbGxlckBmMDAwODAwMCB7DQo+DQo+IFsuLl0NCj4NCj4gUmVnYXJk
cywNCj4gwqAgTmljb2xhcw0KPg0KDQo=
