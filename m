Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51386576F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiL1NcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiL1Nbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:31:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108D11151;
        Wed, 28 Dec 2022 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672234303; x=1703770303;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=swKUnD7rwz0rX2a2S/Gy2BMNU+GSbp3tqoD3th2Nz5Q=;
  b=xo/PEJ6eTYvNaBwUiu+xEYa9c+okGw+vMrjSu7g1Fo0yiVeH9N1za1eU
   yyCuwmLGQS6kCdqXrwG5Nx5MnbrysJcfDlrBXndsbjqoDBpflLmZN480d
   42i2keZTIHdchhc7VeLTZ9XjkYPisQjMl8Y7qcv8ybmHvmdOGYNjusU0p
   +mvdfD0+3ej9Gs04T1C+aKvP4dohl9sw6019zkFrL1i9OFey2kIkZo1jT
   JPZGs2MqfQhFUh11MU541HD+Y7t2P9dea17/MyWBQD+1AhKMkqrHEauOV
   QIGCMOeAyHeYXqSV8M+RHmGjNsf9GRvOLZ0mQap+fsC83OdGYBqRbkIur
   g==;
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="189959383"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Dec 2022 06:31:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 06:31:39 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 28 Dec 2022 06:31:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8yKbbJDUs/QceRKiP4BKZK8dxOuaRrM8JB1AQXf5bQsBBrNgzzoaZn8svv3Ap5JhgCiL7Rd3+i/QSus3UWbgL4oId4CWzO1U6oibQhQFwzAN/h6XfQ4FMpy8fwmJHrG2XLfu03+fTxU1PZzQRRgQzA+SrF0/uSeKNvIT6E13fEvLVsgphqbRS4TutqVDQ+hKEtSdyPok4Pf1lc3KZoW3Y+aWQVFjhWrIfIfneTnEBl+TK4XIWQHnstIFIz9m9aDmZBBD6haS7qlerEfEc7NwUZyoIF+acCTdJ2TFDumbvzVCxPYrPzBNOeB1/mqR3qonRr2P0c7+SHrBFNhHt3Wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swKUnD7rwz0rX2a2S/Gy2BMNU+GSbp3tqoD3th2Nz5Q=;
 b=SeSuoKLanp2w2Hhe984yjIopXtMDHzIpJ223hWqfNqN+TXXqUxiKMvLWXbHFqC+TNCjSSOVlDktQexnn1knSDNOhj5AxmBlsEbDR4ahcYME3PQFWkGemXvpo6hq9UHHRjxXllbOaVXXoaxUjiPTMPGJ2uMMm0SWG2Gi7BAZJpevQ9IcU728of7Q59Y2h+lF4kJ6RdjkTuYurwt6QIZu4VV7ro5ahqWTHjNhsXmAUgCTgoJfQKJRAY0/ulzgoGh5g/AaXyOWyDXaUZzYcFNOT57ZKG7vDuQ3YJmU5a3Zf9HYVEkoXXWBePmGIMXL980ZrCycdUmZoNgvimanVk3YuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swKUnD7rwz0rX2a2S/Gy2BMNU+GSbp3tqoD3th2Nz5Q=;
 b=KfbGUk9CIu0yyFoigP6ugUdH0pZeON0wQTG6Ku2maMI/BnZYcsl6FoBGXWVosy+V6wTHC0BAxP/IbwLZ7Sx4Fy4JCWkk2fkkZalC6hocZaPc8RMi5GlsjpOX6oWaGVnbPnVG9nGwMvsnByWfYsYdrncBXmhhTbAuq+a2e9R/3qw=
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by IA0PR11MB7284.namprd11.prod.outlook.com (2603:10b6:208:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 28 Dec
 2022 13:31:37 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::19c4:9f66:4615:2691]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::19c4:9f66:4615:2691%6]) with mapi id 15.20.5944.018; Wed, 28 Dec 2022
 13:31:37 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <Balamanikandan.Gunasundar@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        <Hari.PrasathGE@microchip.com>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/2] mmc: atmel-mci: move atmel MCI header file
Thread-Topic: [PATCH v3 2/2] mmc: atmel-mci: move atmel MCI header file
Thread-Index: AQHZGP1G0f0vgLeM3EOaGWkhnB546a6DT28A
Date:   Wed, 28 Dec 2022 13:31:37 +0000
Message-ID: <327badfe-1c17-4e8a-4d5e-7102089bcd22@microchip.com>
References: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
 <20221226073908.17317-3-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20221226073908.17317-3-balamanikandan.gunasundar@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|IA0PR11MB7284:EE_
x-ms-office365-filtering-correlation-id: bdbc0a64-df49-42dc-e2a9-08dae8d7d856
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jy3F+90HdwfrAyMYFPSyOvjJWLyUp5zHFWJBEvGzONwZs5JpF8QNpa8nlb8Um0zP9T+dXV4V67rj2b3tmOWFQdPJqSQ4p3JcvRxweiP5NFovpzPca9YvqBE92FoF71uJh8k9mVIIxa0nIGMMHItpx75hW3KjJxZN284V6xP839EkY6By6gJom3ypR+5eLBtN/Y5mzyJQhB3cm8BneQYlYtDw7gNnCOq6kiKQEIjZ8xJJtsexh977aHxOCNBBWd70fihyBJ8vQjiQBoPAX2KAuGSTUgoyuz3VDHvcTwgWlDyfTNS69f/6RXWw6tEb8tXqB4FRLW1Ekvo3jRP80qwPBL3/qFS/Wkwx5mYN9zTmf5WCYTWotn5t7H/sN/JHD/Ft6fe7tvZC/XwYcvjwytV3/jNoBXemPdw3Ukc9KwqxqS92o0tVfklmlrhn4ICcaOYQnDBOJUsRKP3cylqf/5+VEabc7jm5wIYDzK/Yug2zKnAvbyCYFoT5J+0HKm/cHaEArfV7vWw3YZCfaGFmJ5adz+bB97VJTAvZ6jJShibKRv7Do7qD6rx553RePXuewAsZez0YHYHUySlN78WyiDaHuu1p2tOhDCiPvsH66tz+6PabXvsCP05Ijyxg8Xu0yuBLeMoTy8OHRag3RmH5YcIDEtGAcC89M0Je6rXdtLJYe+ORRtnmDr7cL6j6vW8BrlN70ZIN2K+JFC9dzVmdujxFScL8vsNae4Q6SASZYta98i7FMyszSyg7BodTOgyoibUY9cwkNM02jajJBJsldfv2Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(38070700005)(316002)(122000001)(83380400001)(76116006)(66446008)(66476007)(86362001)(64756008)(66556008)(6486002)(5660300002)(66946007)(31696002)(8676002)(26005)(41300700001)(8936002)(6512007)(186003)(53546011)(110136005)(6506007)(2616005)(478600001)(71200400001)(38100700002)(2906002)(91956017)(921005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkJ2WmtGdGFHWHR5elUrU1JpY29iZ3ZydlJrTU12NTM2RzFSTVhGelZXZ05x?=
 =?utf-8?B?Ukh2YlUyeVhrQUdTK2lwZE5GOUhFQ0hKSkJHK1BaVFRPTG1VWkVZUldPNkk2?=
 =?utf-8?B?UTBzUW8ySjNVS2JMcysxb0pwRloxK3M1ZU1YdzVrcDg5Tjc4U1JVbkNSTmE2?=
 =?utf-8?B?ZEt5aFducDk4bmlBR3FmSkJLc3RjY3BJdmtYSEd3dmtaa3JrTTQ1bHZWWFNW?=
 =?utf-8?B?NFdFVDVQczFTZ0VROWhoNmM5YVVYYW56bmRVVFBZSlVFT1N4bmZMSlhSZ1dm?=
 =?utf-8?B?bUduaFFYYUxEWW4vSXIyVk4yUmxtaGFvbHpSU2FuYXdxY0pmUWhTbWhxNmdy?=
 =?utf-8?B?dlNTWEtuWEx2R3dENlVpa3ZNblJVQlU5Tk1YTnFaanFFcnR4VWwzKzNXaFNJ?=
 =?utf-8?B?VGNram51SFgwK29JdzZmRzBFZ2EzRnJsd2NSNUg3SGRHb3pNQ1hYc3pqbFBK?=
 =?utf-8?B?cGZSQVJpVUNqcGdrUU12TDZiUGZFbG9lelBTS1YrQWdiY1lJdWM5eklmNngr?=
 =?utf-8?B?ck1PV1pSVEpqOEl4cmtLRXRyQjFxQTd2TWRSSkx4LzA4WWRjVVh2aUpjeUlm?=
 =?utf-8?B?OG5RcjRBMnRjaVFLMTJGNmFUdTA4b2x0Vk9TeGFOdWNMREJaYW90RnRabkRy?=
 =?utf-8?B?VGRscHRhcXRDL2tiY3hrSzErM0pMM1I0MVdpUzlaMkdaNmVseEczZ0pER2hm?=
 =?utf-8?B?TzRXTU5JcW5ncVRxRkpTNk1TZ2lpY2x6Z1V4cS9HOU9MSmhWcUppUE05eElp?=
 =?utf-8?B?SWxyZEtsSjBSRmZha2pyc3pBQ3EvZ1FBNXRWNFhCYUJNczY4T1R3R3VJb0la?=
 =?utf-8?B?VEdGYlVWcjFpUkdtckRtZVA5SG5PV0hEV3RRc1JBRWp2VWlRVGpDZHJqSFZE?=
 =?utf-8?B?UTVUdWJGNE0ybVBDeWxGQjR2QldLZXovTFBzcFVEUjU2U3hUTzNZNzFGdkJQ?=
 =?utf-8?B?QXJ1MnBVZnVUaFBNU0krbXdQN0tLMlB6dWNLZ2VEZGFEZ3VlYnpGNnhpMHFx?=
 =?utf-8?B?bVQxZDJCTHRBbnp3WlI2VVN0Tk93WkRmaDFrMExLZ0RYR2gyV1RCWHR6OFF0?=
 =?utf-8?B?bWNPTU12UGk2ODdvd0VmQ1E1cEVVNUxFNzd3SS9KNFdwZWFEai9xenZXR0F3?=
 =?utf-8?B?Mmc5Unh4MjkxYWRMQk9odlBZcW9XbjVlRUNveWpMVnRpRHpsOTlzb2REQVZX?=
 =?utf-8?B?djVuTUYwSjE0Y3hzb3ZBQ3Jyekd6ODFJNGZ5akdpVVZnNFVwaDZFRjBBdDRY?=
 =?utf-8?B?dTc0QlE4cUcvOSt2dFhnY09sRlpVVlZWbU5kNm1aNHdSbU1vUkU1L3JJeUtK?=
 =?utf-8?B?aEhTdDgvSzJEMzNINllRbGxYZVlkZmZ3NkpVVzJ3d1UxY1pHcjc3UzQ5Z3RK?=
 =?utf-8?B?T0cweTFiTHlmUUNXSlE0NzJyMG0rNVdZd09TemdmZ294anphNFJKSlhNUnVP?=
 =?utf-8?B?cWlDdVVUMXlJaEJpcEJjcjJFZm5OUSs2UXhPRXhLb2l4ODI5dUlsUEl1YTgx?=
 =?utf-8?B?NEtONGUrVE1nYkFvSWlBK280VXVQNzN0dGZwdUlZS0UvZFBxcUVTZzJtTXY0?=
 =?utf-8?B?Vk5DaUhaVjZrbU0yTE5iSkVIZGdhWUdRd0hjT2ZCTVRLZHpDUmxHUXAwZ2d6?=
 =?utf-8?B?V3RHWEhnV1JjUEF2bkhzY2VSYS9kcVVWM1k0WWxxVzgzZmNqUjZOSElKTi9T?=
 =?utf-8?B?S3U0NXJwdFJFZEVidlFrcElnSmVlT1VmejA5aWxPeW1hQlhEM1lBOTg0bkVY?=
 =?utf-8?B?Z25PMWNVMzZ0N0ZYenV3YUhxalROelFJZmNMWHB3OExmY1NnSS92NHRBcytn?=
 =?utf-8?B?U1dxcUlSeFVpZUd4aXh2d2JkL1FrUnpFa0t5WTh6TUpUeXorbXZ6ZldsWlhw?=
 =?utf-8?B?QmVTb3A5Y3ppMmZMeEZtK0NJdDQxM0hxMXRzd1U2aGdxOW5uMW1lVnZkWnVk?=
 =?utf-8?B?eDcycXNKVUNIWWw2NUhRWGRlNWZ0QUVxcFhUR3FPZFYwRnFhd1d0eFFBSXVj?=
 =?utf-8?B?WmUyYkREZmQ2bHpDMGpkTDhuaFROd3oyWkhmSXdSTm9mNHFFemFydDJMQTlu?=
 =?utf-8?B?ZnZlTlo2WlJwWjZsZ1ljNlBmWklXWnpBZ0kxdnZEZE9QVU1xaVRRdjkyQnp3?=
 =?utf-8?B?TTNVWUhDc2RqbDExR3Q3NmFkSThYVm1TUFRiaVZUT2xOZHFUVWV6V01hdmtu?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54909DD2A30C4F4D9EC6147C60A4BD51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbc0a64-df49-42dc-e2a9-08dae8d7d856
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 13:31:37.1063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyVHknMMce84jcfbBHH5SuUAMBAWaocLSTXzb1g3/p866q+EztvBottwAw4oorqKPy6gMKfMUfmnnjqh8AasoqPnFLJZSx9NtG3wFzx575g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7284
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMTIvMjAyMiAwODozOSwgQmFsYW1hbmlrYW5kYW4gR3VuYXN1bmRhciB3cm90ZToNCj4g
TW92ZSB0aGUgY29udGVudHMgb2YgbGludXgvYXRtZWwtbWNpLmggaW50bw0KPiBkcml2ZXJzL21t
Yy9ob3N0L2F0bWVsLW1jaS5jIGFzIGl0IGlzIG9ubHkgdXNlZCBpbiBvbmUgZmlsZQ0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQmFsYW1hbmlrYW5kYW4gR3VuYXN1bmRhciA8YmFsYW1hbmlrYW5kYW4u
Z3VuYXN1bmRhckBtaWNyb2NoaXAuY29tPg0KUmV2aWV3ZWQtYnk6IEx1ZG92aWMgRGVzcm9jaGVz
IDxsdWRvdmljLmRlc3JvY2hlc0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMv
bW1jL2hvc3QvYXRtZWwtbWNpLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gICBpbmNsdWRlL2xpbnV4L2F0bWVsLW1jaS5oICAgIHwgNDYgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCsp
LCA0NyBkZWxldGlvbnMoLSkNCj4gICBkZWxldGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9h
dG1lbC1tY2kuaA0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvYXRtZWwtbWNp
LmMgYi9kcml2ZXJzL21tYy9ob3N0L2F0bWVsLW1jaS5jDQo+IGluZGV4IDZhYjQzNzMzYmE5Zi4u
YjQ4ZTQ0MGEyZGY4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L2F0bWVsLW1jaS5j
DQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvYXRtZWwtbWNpLmMNCj4gQEAgLTMwLDcgKzMwLDYg
QEANCj4gICAjaW5jbHVkZSA8bGludXgvbW1jL2hvc3QuaD4NCj4gICAjaW5jbHVkZSA8bGludXgv
bW1jL3NkaW8uaD4NCj4gICANCj4gLSNpbmNsdWRlIDxsaW51eC9hdG1lbC1tY2kuaD4NCj4gICAj
aW5jbHVkZSA8bGludXgvYXRtZWxfcGRjLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3BtLmg+DQo+
ICAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gQEAgLTQxLDYgKzQwLDggQEANCj4g
ICAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KPiAgICNpbmNsdWRlICIuLi9jb3JlL3B3cnNl
cS5oIg0KPiAgIA0KPiArI2RlZmluZSBBVE1DSV9NQVhfTlJfU0xPVFMJMg0KPiArDQo+ICAgLyoN
Cj4gICAgKiBTdXBlcnNldCBvZiBNQ0kgSVAgcmVnaXN0ZXJzIGludGVncmF0ZWQgaW4gQXRtZWwg
QVQ5MSBQcm9jZXNzb3INCj4gICAgKiBSZWdpc3RlcnMgYW5kIGJpdGZpZWxkcyBtYXJrZWQgd2l0
aCBbMl0gYXJlIG9ubHkgYXZhaWxhYmxlIGluIE1DSTINCj4gQEAgLTIwMiw2ICsyMDMsNDIgQEAg
ZW51bSBhdG1jaV9wZGNfYnVmIHsNCj4gICAJUERDX1NFQ09ORF9CVUYsDQo+ICAgfTsNCj4gICAN
Cj4gKy8qKg0KPiArICogc3RydWN0IG1jaV9zbG90X3BkYXRhIC0gYm9hcmQtc3BlY2lmaWMgcGVy
LXNsb3QgY29uZmlndXJhdGlvbg0KPiArICogQGJ1c193aWR0aDogTnVtYmVyIG9mIGRhdGEgbGlu
ZXMgd2lyZWQgdXAgdGhlIHNsb3QNCj4gKyAqIEBkZXRlY3RfcGluOiBHUElPIHBpbiB3aXJlZCB0
byB0aGUgY2FyZCBkZXRlY3Qgc3dpdGNoDQo+ICsgKiBAd3BfcGluOiBHUElPIHBpbiB3aXJlZCB0
byB0aGUgd3JpdGUgcHJvdGVjdCBzZW5zb3INCj4gKyAqIEBkZXRlY3RfaXNfYWN0aXZlX2hpZ2g6
IFRoZSBzdGF0ZSBvZiB0aGUgZGV0ZWN0IHBpbiB3aGVuIGl0IGlzIGFjdGl2ZQ0KPiArICogQG5v
bl9yZW1vdmFibGU6IFRoZSBzbG90IGlzIG5vdCByZW1vdmFibGUsIG9ubHkgZGV0ZWN0IG9uY2UN
Cj4gKyAqDQo+ICsgKiBJZiBhIGdpdmVuIHNsb3QgaXMgbm90IHByZXNlbnQgb24gdGhlIGJvYXJk
LCBAYnVzX3dpZHRoIHNob3VsZCBiZQ0KPiArICogc2V0IHRvIDAuIFRoZSBvdGhlciBmaWVsZHMg
YXJlIGlnbm9yZWQgaW4gdGhpcyBjYXNlLg0KPiArICoNCj4gKyAqIEFueSBwaW5zIHRoYXQgYXJl
bid0IGF2YWlsYWJsZSBzaG91bGQgYmUgc2V0IHRvIGEgbmVnYXRpdmUgdmFsdWUuDQo+ICsgKg0K
PiArICogTm90ZSB0aGF0IHN1cHBvcnQgZm9yIG11bHRpcGxlIHNsb3RzIGlzIGV4cGVyaW1lbnRh
bCAtLSBzb21lIGNhcmRzDQo+ICsgKiBtaWdodCBnZXQgdXBzZXQgaWYgd2UgZG9uJ3QgZ2V0IHRo
ZSBjbG9jayBtYW5hZ2VtZW50IGV4YWN0bHkgcmlnaHQuDQo+ICsgKiBCdXQgaW4gbW9zdCBjYXNl
cywgaXQgc2hvdWxkIHdvcmsganVzdCBmaW5lLg0KPiArICovDQo+ICtzdHJ1Y3QgbWNpX3Nsb3Rf
cGRhdGEgew0KPiArCXVuc2lnbmVkIGludAkJYnVzX3dpZHRoOw0KPiArCXN0cnVjdCBncGlvX2Rl
c2MgICAgICAgICpkZXRlY3RfcGluOw0KPiArCXN0cnVjdCBncGlvX2Rlc2MJKndwX3BpbjsNCj4g
Kwlib29sCQkJZGV0ZWN0X2lzX2FjdGl2ZV9oaWdoOw0KPiArCWJvb2wJCQlub25fcmVtb3ZhYmxl
Ow0KPiArfTsNCj4gKw0KPiArLyoqDQo+ICsgKiBzdHJ1Y3QgbWNpX3BsYXRmb3JtX2RhdGEgLSBi
b2FyZC1zcGVjaWZpYyBNTUMvU0RjYXJkIGNvbmZpZ3VyYXRpb24NCj4gKyAqIEBkbWFfc2xhdmU6
IERNQSBzbGF2ZSBpbnRlcmZhY2UgdG8gdXNlIGluIGRhdGEgdHJhbnNmZXJzLg0KPiArICogQHNs
b3Q6IFBlci1zbG90IGNvbmZpZ3VyYXRpb24gZGF0YS4NCj4gKyAqLw0KPiArc3RydWN0IG1jaV9w
bGF0Zm9ybV9kYXRhIHsNCj4gKwl2b2lkCQkJKmRtYV9zbGF2ZTsNCj4gKwlkbWFfZmlsdGVyX2Zu
CQlkbWFfZmlsdGVyOw0KPiArCXN0cnVjdCBtY2lfc2xvdF9wZGF0YQlzbG90W0FUTUNJX01BWF9O
Ul9TTE9UU107DQo+ICt9Ow0KPiArDQo+ICAgc3RydWN0IGF0bWVsX21jaV9jYXBzIHsNCj4gICAJ
Ym9vbCAgICBoYXNfZG1hX2NvbmZfcmVnOw0KPiAgIAlib29sICAgIGhhc19wZGM7DQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2F0bWVsLW1jaS5oIGIvaW5jbHVkZS9saW51eC9hdG1lbC1t
Y2kuaA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDE3ZTdkOGY2MTI2Li4w
MDAwMDAwMDAwMDANCj4gLS0tIGEvaW5jbHVkZS9saW51eC9hdG1lbC1tY2kuaA0KPiArKysgL2Rl
di9udWxsDQo+IEBAIC0xLDQ2ICswLDAgQEANCj4gLS8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wICovDQo+IC0jaWZuZGVmIF9fTElOVVhfQVRNRUxfTUNJX0gNCj4gLSNkZWZpbmUg
X19MSU5VWF9BVE1FTF9NQ0lfSA0KPiAtDQo+IC0jaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4g
LSNpbmNsdWRlIDxsaW51eC9kbWFlbmdpbmUuaD4NCj4gLQ0KPiAtI2RlZmluZSBBVE1DSV9NQVhf
TlJfU0xPVFMJMg0KPiAtDQo+IC0vKioNCj4gLSAqIHN0cnVjdCBtY2lfc2xvdF9wZGF0YSAtIGJv
YXJkLXNwZWNpZmljIHBlci1zbG90IGNvbmZpZ3VyYXRpb24NCj4gLSAqIEBidXNfd2lkdGg6IE51
bWJlciBvZiBkYXRhIGxpbmVzIHdpcmVkIHVwIHRoZSBzbG90DQo+IC0gKiBAZGV0ZWN0X3Bpbjog
R1BJTyBwaW4gd2lyZWQgdG8gdGhlIGNhcmQgZGV0ZWN0IHN3aXRjaA0KPiAtICogQHdwX3Bpbjog
R1BJTyBwaW4gd2lyZWQgdG8gdGhlIHdyaXRlIHByb3RlY3Qgc2Vuc29yDQo+IC0gKiBAZGV0ZWN0
X2lzX2FjdGl2ZV9oaWdoOiBUaGUgc3RhdGUgb2YgdGhlIGRldGVjdCBwaW4gd2hlbiBpdCBpcyBh
Y3RpdmUNCj4gLSAqIEBub25fcmVtb3ZhYmxlOiBUaGUgc2xvdCBpcyBub3QgcmVtb3ZhYmxlLCBv
bmx5IGRldGVjdCBvbmNlDQo+IC0gKg0KPiAtICogSWYgYSBnaXZlbiBzbG90IGlzIG5vdCBwcmVz
ZW50IG9uIHRoZSBib2FyZCwgQGJ1c193aWR0aCBzaG91bGQgYmUNCj4gLSAqIHNldCB0byAwLiBU
aGUgb3RoZXIgZmllbGRzIGFyZSBpZ25vcmVkIGluIHRoaXMgY2FzZS4NCj4gLSAqDQo+IC0gKiBB
bnkgcGlucyB0aGF0IGFyZW4ndCBhdmFpbGFibGUgc2hvdWxkIGJlIHNldCB0byBhIG5lZ2F0aXZl
IHZhbHVlLg0KPiAtICoNCj4gLSAqIE5vdGUgdGhhdCBzdXBwb3J0IGZvciBtdWx0aXBsZSBzbG90
cyBpcyBleHBlcmltZW50YWwgLS0gc29tZSBjYXJkcw0KPiAtICogbWlnaHQgZ2V0IHVwc2V0IGlm
IHdlIGRvbid0IGdldCB0aGUgY2xvY2sgbWFuYWdlbWVudCBleGFjdGx5IHJpZ2h0Lg0KPiAtICog
QnV0IGluIG1vc3QgY2FzZXMsIGl0IHNob3VsZCB3b3JrIGp1c3QgZmluZS4NCj4gLSAqLw0KPiAt
c3RydWN0IG1jaV9zbG90X3BkYXRhIHsNCj4gLQl1bnNpZ25lZCBpbnQJCWJ1c193aWR0aDsNCj4g
LQlzdHJ1Y3QgZ3Bpb19kZXNjICAgICAgICAqZGV0ZWN0X3BpbjsNCj4gLQlzdHJ1Y3QgZ3Bpb19k
ZXNjCSp3cF9waW47DQo+IC0JYm9vbAkJCWRldGVjdF9pc19hY3RpdmVfaGlnaDsNCj4gLQlib29s
CQkJbm9uX3JlbW92YWJsZTsNCj4gLX07DQo+IC0NCj4gLS8qKg0KPiAtICogc3RydWN0IG1jaV9w
bGF0Zm9ybV9kYXRhIC0gYm9hcmQtc3BlY2lmaWMgTU1DL1NEY2FyZCBjb25maWd1cmF0aW9uDQo+
IC0gKiBAZG1hX3NsYXZlOiBETUEgc2xhdmUgaW50ZXJmYWNlIHRvIHVzZSBpbiBkYXRhIHRyYW5z
ZmVycy4NCj4gLSAqIEBzbG90OiBQZXItc2xvdCBjb25maWd1cmF0aW9uIGRhdGEuDQo+IC0gKi8N
Cj4gLXN0cnVjdCBtY2lfcGxhdGZvcm1fZGF0YSB7DQo+IC0Jdm9pZAkJCSpkbWFfc2xhdmU7DQo+
IC0JZG1hX2ZpbHRlcl9mbgkJZG1hX2ZpbHRlcjsNCj4gLQlzdHJ1Y3QgbWNpX3Nsb3RfcGRhdGEJ
c2xvdFtBVE1DSV9NQVhfTlJfU0xPVFNdOw0KPiAtfTsNCj4gLQ0KPiAtI2VuZGlmIC8qIF9fTElO
VVhfQVRNRUxfTUNJX0ggKi8NCg0K
