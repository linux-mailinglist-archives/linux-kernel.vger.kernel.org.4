Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1F63884C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKYLKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKYLK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:10:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6023E9C;
        Fri, 25 Nov 2022 03:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669374626; x=1700910626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AgdAOTngFZVbDb53Q7ibohofZmh0StQBMpgxiClQWcw=;
  b=k6Ds7NRpnMp6lYx43JLgvbvmFB3dWNlpQQV1PdtPJ6R2wO0yLc+LfGV4
   OQsucRyHkWS1UG4ludyKOeLEaNryh5HOCDLLr7JnY6IIs8/NZwz/uWLoW
   flFmipino5vqDNwGN8vMx+NIUa0NfT5Qum0mAYfZivD+OWziDLbuHneol
   UYu596mTYWiosJ05Cj3t1aaw1qLF6IrBUXZGo2BhvfJUKy0UkZqHvYKHe
   rJWkYj4yywcesLmY5RD5BXRJSMOSqNZjux1mADKLyhTHrrTFoQ2U/k4YO
   eDOqUQMR2GF2SFfnJFbyWVtsbRkilW2euqHg5blJVEGq52GA7k1xeve/o
   w==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="185162335"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 04:10:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 04:10:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 04:10:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS5qge47dkC1y/j92Ib2xwnCYer/KEuvGCnhWNmIJv8uLrBBRoyRXqIC4mpjBGqTuKsLG/yk8owJuR11FhzM3JE6yovZk72PLwva/B2DaBu65fB6CQWG3kh8o5fLzpQH7qer1HhSfJmkYFEeDYhxMTr+mKRMGoBZwqRDIWdW7rq2y0XrhMP1GKtH6fSZnaPN1FutJkEZE9J/W7Dotpkl7hfmyYK4K/Uwp47YRtXwe+EUm2ewKO4PTCmInlRnxiM+NexiqVVlrIwX/iiIsG24S3o0GAqq0Or79uwFErrVoAy9qzccWsuZiAQgQDMnY6KaZ3f5lqD+47RDzhIAQwpffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgdAOTngFZVbDb53Q7ibohofZmh0StQBMpgxiClQWcw=;
 b=OxJGWl9vwCqqnFbSIsQ50XZDLf25GssOpuA2oSBulGHXATbw2hc7A4YYSJabZatLqBVLi2uSgWLGpmtOa8ffhuSaKXx8zAjDvWanojOcvuBWQ5eTy9nXyT4m5DATACYkZUzM+8XkLGYVrE+upP/jG8DaSls2sTfZQJavbr/3d6f/46ZE6TBpn/xuXp4keSaKcCwg/OD9XbkEklUrkxV8TOevLzDuwWZf++ERwOnA6XBB2YoSJ1Vk7JGW0vswr/ZKlcxfoDGG8XxoyQTvghSx4796mRrVTb8QMJ8ZI/iIhyUkvfPRuaK0Rda1dZt41Y+SNkcwxCmeRewnzuCDIcE8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgdAOTngFZVbDb53Q7ibohofZmh0StQBMpgxiClQWcw=;
 b=rSwhYERyHshKUqQ1GNHS2cdJAyn/y6/XFw0XdOL5z/JFKUlnUavH52pv4gmrg1nyyuBK+WCPCVR7ykqNL9WjSCziaUOMkYrccZPM4JomTBdgiOptWoqJZxtPJvtIZHopHNXRgb9zfCGpleH9pWosZQq5k1t0aq8cKhE7fpbfnZM=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 11:10:22 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Fri, 25 Nov
 2022 11:10:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Topic: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Index: AQHZAL6CRHAQHfqThE+/atmdombgtA==
Date:   Fri, 25 Nov 2022 11:10:22 +0000
Message-ID: <9302133d-e217-e44e-5372-7bd05865f36a@microchip.com>
References: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
 <bdce1cb7-a771-4ec6-c75b-f547d26f95b3@microchip.com>
 <20221125100144.332tizam7tonqqtz@soft-dev3-1>
In-Reply-To: <20221125100144.332tizam7tonqqtz@soft-dev3-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SN7PR11MB6559:EE_
x-ms-office365-filtering-correlation-id: 84c90d21-d83e-4c29-d6ec-08daced5a576
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N90ndB9r25B4qR75aIt39EGGuKmfVU+2Qq6bOGmvvZqKKxOTVIWRNCwlPMxOQ9uqSDN0EGH9nlqMbNiSmm2KO/YKHKiJulDnU7mmhM82tyOaYlTSKCP0eCNA1gY/QPGaVTzY1qGln8o1toJhMK2kc2gtGRBl0xyadDgTxf0XJgz+InjkRKfQGJQzXi39P8Zxjb7i6Bauaw443OKq/mkllQR0JwqlpDes55CXkvrF2KBY2HBn/197nK9J8TuRt1QPRSkiK7Fguxi7OzYL2otrZCaZNSPBrIF1EZPkVY2l1C0RVZ4IyfF4AMpy/SFOfupDiuwSErH8F+fSFeRXg/hanw1zgTwbwSfLlLCHqSLTg0SWTs21Rk2nNmVlLOHasIkZBDQMJUW5fAofaohM2HpvJCieklacr6wEYFc+RQjE6vDSzrp4+pBiDQHC0n9ud5O7Kd30DVqrGj3V9dJ55/o4vpJAvs177CpMkk/LR5d5qkK3HkJk7RPAsx5JHcbDZuyRXu1Srcm9zVIMSAcUX1bOMH9KVelpe41H62ed6cE5fFPXK7t0EIWpJs/QSrQBPOLiSuvdU+w9ymcVJL7JYKVo8d65d03o5xJfv3DCVNSPL69mB8zY8HBiTfr7mTO1G/TdtKbHxuCR40yi/4kx9bIE3eDfV9tojr+lYUam6trIRzZ1Uqu+3Jmj7KvfuggsyruOshwbb9mJcv+KqpUSwOr50M6mkrIpGrQ9EFPo841S9eosMeZoVzoHYI/o3C1YRGOb1jX9jdIZcMLA3DBaO/zbXcGOSKMrPWOudyD0euGuhpA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(8936002)(2906002)(5660300002)(31686004)(6862004)(316002)(91956017)(64756008)(66476007)(66556008)(37006003)(8676002)(6636002)(54906003)(66446008)(122000001)(76116006)(41300700001)(4326008)(66946007)(36756003)(38100700002)(966005)(71200400001)(6486002)(478600001)(107886003)(38070700005)(6512007)(6506007)(53546011)(86362001)(26005)(31696002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1RnVWtMemdJZVc2bHg0QWJwWWR3VzV3dzZ5UTNKWVA3QmJIc0p2aXFkZ0Ix?=
 =?utf-8?B?bDhlR2RjT1IzYWdxTnE0TnExQm1pUkVWK29YQXBLNXdmUm1pcHZ6OGdpSXdV?=
 =?utf-8?B?ODNFdDNaclo5ZFhwTzVKM1l1NHhvWWlzSmVrcDlNL1M5Q0M3NUl5ZEtXK3A4?=
 =?utf-8?B?MTZyTnN0RndBam1qR0VNMU9EeG5zams3U09GVk1ndDZrcEJpNFNDcjlQY29R?=
 =?utf-8?B?THMrNzEyS1p1ZFZMNGs4ZEp6K201MEc4eThlQ3NyWlRxMjNHVXI2aHc1ck1O?=
 =?utf-8?B?bUJUTmZ2Qmo5UXQ0L0Q1Uk42NlVYZEpzZC9xT3d2V1o0RXRnMkxKUGc3akpz?=
 =?utf-8?B?cnFoZldOYVBhZFdIMFU3dFQ5R2xGZjFwSE85VlM1bE5Rc3VoLytVSWdFR0Iz?=
 =?utf-8?B?b04xbFAzVTlreGVUb3k1WTJ1dGJsS0xLaW95NWdtdlJBSS9PTDFjTjJuQitZ?=
 =?utf-8?B?L0Z5ZWdPdGUxNFlIcmljbDBLazJsMSs0SUgvZTUvMUtRV2FVWTJ4TWQ4Z0lL?=
 =?utf-8?B?MDdWZnBHWmFQN0RWaXN2ekVTQ21pUGE0MHdkV1cveWdKRFlOWGw4c3JYMlF0?=
 =?utf-8?B?ODh1M3FXUEhKU3NWQ0JlNXYvN3NEYWhhOW1KSEZVdlhNRjNTT25TVVh2UCtt?=
 =?utf-8?B?RDlZMVh4WWs3cS9NZUw0cE1LT2tJem9lUisza2RMbUxKWVZXdWc4YytlV1JJ?=
 =?utf-8?B?L2srSnRJeGRTZVBGSlpyM1Nyb3h3a2FMZW02VDY0VHhiazZnM3RjVHVzbDJ4?=
 =?utf-8?B?N1U2NGlRdTdDbkYxbDJFTkt1SGFPZUYzUzVKbnhTMDFRczhYOGlJNHp5QnR5?=
 =?utf-8?B?UWYvNng4Uk1DVlYrVm1kZC90b1Nhdlk2L2xSSzhhMVMwN0VLSW15UkxIR05C?=
 =?utf-8?B?SU1HL2cwM0lWSHA3TVMyMTRMNS9FanZ4MGw4NmxNTnBqSWY4Rk1oSmNwMTFk?=
 =?utf-8?B?WGhWNFJMUUhwK3QvQ3NoTnh0NDN4LzB2Z3ROL2M4UlVIRnVMR0FZK3M4bTZa?=
 =?utf-8?B?QkZZNktXd29iK1k2aXRVVWp2cDRzOVdTZndWRTJCc1RXcVo5WnlYamhHQnpB?=
 =?utf-8?B?WVZlRXRhQnJscHRPN2tjUlVDVDlKaUJaUGdBOWUvV1RpTkhPU1g5TVVEbzlr?=
 =?utf-8?B?dTRvNFpxb28xUHcxb0UwSU9KOUkwSzc5S0xNWUhXT04rWVgwaUV2ckp6bHRK?=
 =?utf-8?B?RE9aaHJnVUlFcTVUQzlNeGxMYlZKM21xVTJ6ODRTV3VScWl4NFdON3BQZFdr?=
 =?utf-8?B?WkxibHZBRncyUElqckNYZ3JLcEl1djhaUEdQb215dWVnTjJQVC8wZnIzTDNU?=
 =?utf-8?B?RU0zWFVFRkl5UnJZYlNubjh2TGNWTVpwMk1HTHdVK25TZVllTFgyNzRpa3F4?=
 =?utf-8?B?QmNYWlRZVFE5WHhXYlg3dGswaStzRklKNXNjaDRlNW5TUFMzTEpBMzBTSDQ5?=
 =?utf-8?B?Z3JGbDJYNERsZE4xTlVVRWhoSWIwYWhFOGo5QjdyQjdoc1ZRZHFEd1BRVGwy?=
 =?utf-8?B?aHV6ei9KYW85TUh1RjkrTlBuRnp2ODFHd014dkVIaDFvNEZFQzJpTitrTEoz?=
 =?utf-8?B?cVhtTFlENTd1TUExcncvS3NrdVlIZ0l6UDJHT3o4bWlsOHlRblcrZ1pqWmxv?=
 =?utf-8?B?Rmo4SEEwMkhpeEZzN054RXp0b1hmYkdYQ09oQzBReUNyNmF0MFFnKzJDY2Er?=
 =?utf-8?B?Ni9EMG1zYWtWR2xzUzlDWUcrVjBURVBIeGxjS3A4NVdPaUNJTExSMDI3Zm5v?=
 =?utf-8?B?ZWVXMVV1V1N3NlQ4QTA5VkpTRlVhRExyQ3YzSDB6SUxnNHJidjFIRFhCbVRX?=
 =?utf-8?B?ZzNPMFhmVGZKazErZWhBc1ZrbW5Oc0M1aWlaRVh2d0g3ZUlEVTJ4b3praW9u?=
 =?utf-8?B?cW5FdUxON3FEOWd6Y200R2k4c2hLaXUyL0syRThQd3hHbkhxSFlYaGI4WnAz?=
 =?utf-8?B?MXlmVytCSFc0T1ZPRUlyTjZGZVlydVNIdXlLc28vQlFIaEozSTJvMWFCejYr?=
 =?utf-8?B?ZGIzUVNFMUZoYWw4SXFwQjdwWDAzY3NrUUJoYjNCN3ZPTFRGUXo1bVZyY013?=
 =?utf-8?B?T3RNL3ZKMzF0eTNvQjRsL1VFeXRJWTIyN1hxRmVGZDIyT1dMamMzSzJ2WHdK?=
 =?utf-8?B?QjE5SVQwZ3MxZnpKdjNkVjJzY0pPaU9xYVFqd3ZIRWc1QUhCeStTZzJwS3lM?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1713988422DF449BCDCC90088C59F11@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c90d21-d83e-4c29-d6ec-08daced5a576
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 11:10:22.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9HEi4TX6/egE8tzFUrocWs6fy/0Iaxrqfnv5cvtPM98iDU0txs+RfGV9Ui5bOG+dP+jo56lYZf5NG/ZDahpzG2v5TaXdWasAw8x9NuoqBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMTEuMjAyMiAxMjowMSwgSG9yYXRpdSBWdWx0dXIgLSBNMzE4MzYgd3JvdGU6DQo+IFRo
ZSAxMS8yNS8yMDIyIDA5OjIzLCBDbGF1ZGl1IEJlem5lYSAtIE0xODA2MyB3cm90ZToNCj4+IEhp
LCBIb3JhdGl1LA0KPiANCj4gSGkgQ2xhdWRpdSwNCj4gDQo+Pg0KPj4gT24gMTYuMDkuMjAyMiAy
Mjo0OSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+Pj4gQWRkIE9UUCAob25lIHRpbWUgcHJvZ3Jh
bW1hYmxlKSBzdXBwb3J0Lg0KPj4+IFRoZSBib3RoIGxhbjk2NnggU29jUyAobGFuOTY2MiBhbmQg
bGFuOTY2OCkgaGF2ZSB0aGUgc2FtZSBPVFAgSVAuDQo+Pg0KPj4gSWYgT1RQIElQIGlzIHRoZSBz
YW1lIGZvciBib3RoIGxhbjk2NnggaXMgdGhlcmUgYSByZWFzb24geW91J3ZlIGFkZGVkDQo+PiBj
b21wYXRpYmxlcyBmb3IgZWFjaCBTb0MgdmFyaWFudHM/DQo+IA0KPiBXaGVuIEkgd2FzIGFkZGlu
ZyB0aGUgZGV2aWNlIHRyZWUgYmluZGluZywgS3J6eXN0b2YgbWVudGlvbiBub3QgdG8gaGF2ZQ0K
PiBhbnkgd2lsY2FyZHMgaW4gY29tcGF0aWJsZSBzdHJpbmcgWzBdLg0KDQpJIHdhcyB0aGlua2lu
ZyBhdCBoYXZpbmcgb25seSBvbmUgb2YgbWljcm9jaGlwLGxhbjk2Njgtb3RwYyBvcg0KbWljcm9j
aGlwLGxhbjk2NjItb3RwYyB3aG9ldmVyIHdhcyBmaXJzdC4NCg0KPiANCj4gWzBdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvNTUwZTY1MmUtNDU0MS1jMWU2LTMzYTctZDU1NTVmMGNiMjY2
QGxpbmFyby5vcmcvDQo+IA0KPj4NCj4+IFRoYW5rIHlvdSwNCj4+IENsYXVkaXUgQmV6bmVhDQo+
Pg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVy
QG1pY3JvY2hpcC5jb20+DQo+Pj4gLS0tDQo+Pj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngu
ZHRzaSB8IDUgKysrKysNCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPj4+IGluZGV4IDIzNjY1YTA0Mjk5MDYuLjc4NGNh
YmEzNjk0ODUgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNp
DQo+Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+Pj4gQEAgLTE2Myw2
ICsxNjMsMTEgQEAgcG9ydDc6IHBvcnRANyB7DQo+Pj4gIAkJCX07DQo+Pj4gIAkJfTsNCj4+PiAg
DQo+Pj4gKwkJb3RwOiBvdHBAZTAwMjEwMDAgew0KPj4+ICsJCQljb21wYXRpYmxlID0gIm1pY3Jv
Y2hpcCxsYW45NjY4LW90cGMiLCAibWljcm9jaGlwLGxhbjk2NjItb3RwYyI7DQo+Pj4gKwkJCXJl
ZyA9IDwweGUwMDIxMDAwIDB4MzAwPjsNCj4+PiArCQl9Ow0KPj4+ICsNCj4+PiAgCQlmbHgwOiBm
bGV4Y29tQGUwMDQwMDAwIHsNCj4+PiAgCQkJY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWZs
ZXhjb20iOw0KPj4+ICAJCQlyZWcgPSA8MHhlMDA0MDAwMCAweDEwMD47DQo+Pg0KPiANCg0K
