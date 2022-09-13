Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D485B687C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIMHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIMHSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:18:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B202F64F;
        Tue, 13 Sep 2022 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663053486; x=1694589486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zfAyZtWiu3C0SsEp229HZQKkGT7RVND2g/o8f7EyIR4=;
  b=wowGDo7QYoeqdbU9Wy6fyoOezCztank8uRfUOdeJ+zLvrU7fi5Ab52f1
   S5dYaCTYmf9d3uFouTmaWV/OeI/Trlyq9hmWw1V5YXyZZDJTqGkv0y1MV
   2cERK+TEezXA9eZH9gD1fFv03Fvk4AjmXnTiHtY0i9JKZ+GlzLItavJ+D
   0OLsWPOsf/Yj9nA9LznkOLHgX4WFZ0axYfw3OXXJKfmDradsGxsCX79Is
   +zyTGbP40d/SZSqWtBuHHOhefV3qlXPufD9KThY1IxlrcySx5pCGkyIJO
   cql8PwJYsWAX5kVsd/r3L04tT2ViGgeTG5cXEo4D2vJWhNkRgzY4CFzDB
   g==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="180250166"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 00:18:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 00:18:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 13 Sep 2022 00:18:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN762+5+5H2aLD7/DZdPXTmLSKZMcXDs2KYz+eoDOXA8zSc4qvD8u7aDXREtErUJj29RNA3+VnKJmWVFc9SrXYzD/jm/k4b71lsgXqXZonNBTXt8yni4WgLEjznSmBsVREwgR84I46kpBQwcXcECQlokpAh6FHyHSDD6ixVY7Q2Dd+9XgOUd5enpJ7EV+7n3L4xSwtC3JB8i8AaGLaoTTXAzKUZiFC/2Tu+Eg732XG1LBBCE4dU0mzbV8pfugo5OeqbbgEb4ux7m2q9n8CcPWzznosVzH/KlAEzTMtbrKnoLXKvyYiQj4eSk989zJZrE8bFLb06FN2u+5RXCzl80lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfAyZtWiu3C0SsEp229HZQKkGT7RVND2g/o8f7EyIR4=;
 b=eVkGKatFc6u0xbECXj7vWKy/zOHKoFkTGyall+ajJQsbfBHVpTEiGOPBnvaWQNhysmGgqzPg5hNrQ9xdwTXabfQR/ShyvCjz30sgHvGfb91CUru7kw+b1kJwx/Vl23U151QQVhTPayM4GwB+3Kza5tA6b/98IXfjRvZarPBSqgoQqAFwdCiLj85YkFIfyTOuhMHZ/2Z9mBaT/ebK+miIp6USVx9ApORVJXLEGyEvFPzh3xZbzDA064K78furTZb4czt2oJ/YlLGpylXhW8LdINOS+cC+wjCi7iHbTmd1mQltMzoGF+aNTbliibhBA1t2hrT8KTW5DJtg80zzGDVi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfAyZtWiu3C0SsEp229HZQKkGT7RVND2g/o8f7EyIR4=;
 b=gvGTKavzjBRFTubNeOY/ARIHPCEWd9SHznCUR3o0ZPC8HSlHvJAK2Em6GikBNwUuO+eycZOPXZcGoopzZ6wsslsK/SDN6ASv9nO16cK/y/bkuc9U0ams8f7IdCXubm6BtTQ8CaQXn0kjXvd2XFlBcB70fhpgqCsVwBxCfrSgYmw=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CO6PR11MB5649.namprd11.prod.outlook.com (2603:10b6:5:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 07:18:04 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5612.022; Tue, 13 Sep
 2022 07:18:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: disable aes
Thread-Topic: [PATCH] ARM: dts: lan966x: disable aes
Thread-Index: AQHYx0D2wF/cUwkfb0uFNAHyGn+r5A==
Date:   Tue, 13 Sep 2022 07:18:04 +0000
Message-ID: <4c0ae8be-dbfd-8149-7ef0-da198e96ea60@microchip.com>
References: <20220908070451.3730608-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220908070451.3730608-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CO6PR11MB5649:EE_
x-ms-office365-filtering-correlation-id: 942d2a0b-a0c9-47ed-d12b-08da9558195b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoI2vHvx9o0f/3S16mQeg/subXYwW0jVeRbcI7kbc5ftkmbnril7mMh3NlibK0ripNYYHfoMItpsh9ktJrfF6ozGuT8mv6476jfKdf008gbMGMrt9Dm8OANyPffKsdZRhu9mX6/kKpWUFpsWTAjuq1V4JIT5eMgvzHMRNqEceXXZOXuvueKwukVHvh24l2Up72bPqkPPWbRi/+P9/j1m/iQ3YvTowkEs1P0j0JMan+Kct+Pxn25L53/FKK2LFVT85p8CjTGsBEzCOO4CXCVIFChDQIQCQsr7JIiaiGOES5S/PYAytJEYWOchWPXeMS/suGafhwD/gmOW3Q0pAM48n+PEBuQmclwihO7ThiTQlXg+mzjJoDqRE6S5IGv/7xZFQD7EnrP/Q13ale/NYX1xHi0sJo4Eam5qhPe5I8jJZbsdeDGjy5dxCcq0A5jVyrd2wiuO4oF43o+Z8kwH0fYeiEg+9BstR0T5b3qLlSFN88bG3m72iRHFbItLWqKFPx0hf1dBdl7ubW5rj6WPZrmYZsAPIutHzQ0ryzv6oNNL4r4kcJbipamO7aMHmH3rffqjh/Rh3we/RtDq6Fz8udXfralhgE/gNnxCCAyCixA2ffxBHgxF3if06MBTWG/H8cp+0JEd5epP1nBbT2NzDhivsQ4KYeYOdBE2e3AKJUjZXOM1DEBFdedQc4BLuzLQW/n4OXCsN/E3y0KmL6fb7e0kYZPGjFNVsA8J09Zx0LANtSpQtcqxv8V3oCfOJDuyJpEWft2LJAecvEfSiAvbQoSREmvv4b+ARqNMvajMExqcijIMWEpjyu6xgrImntK16admltzgsGg1R8866rT0wSuO+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(122000001)(66556008)(8936002)(64756008)(31686004)(8676002)(2906002)(2616005)(66946007)(86362001)(76116006)(4326008)(478600001)(71200400001)(38100700002)(186003)(36756003)(41300700001)(66476007)(6512007)(83380400001)(53546011)(6506007)(6486002)(91956017)(450100002)(110136005)(38070700005)(54906003)(31696002)(316002)(66446008)(26005)(5660300002)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkt5SjIyc1B0SnV4eHAwWjViZUxjamFYZTkzMzEvRlRwUGRaNnhHWHNvNThx?=
 =?utf-8?B?UXByVEhyNDdEZ0g4RGxsdnpwbTJOZnZPd2NKSG00WmpVYlRRb2R4VW1aTUJO?=
 =?utf-8?B?ZVJaYTlMTlZ3MS90bDA3S1Izb2pyK2F5eGRiQUFlUGJZY1VDdUJ6TGhldEJE?=
 =?utf-8?B?MEQxVFNIV05oOG1zQUx6Nk9Gem5xNFNBaDFoRFoybno3algzdUdYMzRJa0Ro?=
 =?utf-8?B?YmQrck5vWlNIRHlLWGVwMjRUY0kwSUVGbjhjUnZOQTdyV0FUdkJOTXhiYjdZ?=
 =?utf-8?B?QlFha2xkdlppUnVYWktkZmNjakZpdVdhZzZPVEJPRDUvdEZiNllXK3Z5TXVt?=
 =?utf-8?B?by8zdkNMem1XZm9NbW8zMDJveGVzQlhLajZHUVRIWk9LTGtkYncxQ29vdkJm?=
 =?utf-8?B?a3c5OStxcXdIc2txZlFJK3FDNmFpaERCbHdyY2Z6amcyQXQ5eXl4bUFkTEcz?=
 =?utf-8?B?czVGd3IyWDNCU0dmN1duREFqcU10QjZuR2tIODJMelFxT3JPWnBrYzY5MDcr?=
 =?utf-8?B?OUxvNmk3Smd2bGlnVGw3OTJpeVo2cGlsMEp0NEdNMkZMSTdZNWFzWnJ3b1FR?=
 =?utf-8?B?MFpmQnphWVdRK2l1VHlPc1RsMU42VEdTclg0WGFNS2h0UGJxYVh1d0xuMlk2?=
 =?utf-8?B?djExMlJRcXJGQkQwNW9zdmx0UmNlY3VXN1g0UmFXREVJbFJtYXcrQ0JMc0V5?=
 =?utf-8?B?azE5eG1rZkZtZTNjY3FpVFowQXhQQ2wvK3RtVk5seWswQ2M0SFovTDlZc2x4?=
 =?utf-8?B?Z0ZVMk43eVFBSENSRmVzTUkrNWxDWE9sNE5ZcFVYWjlxNWltL1BXY1ZwcGtX?=
 =?utf-8?B?S0NxK1NTcnE3OEx2YWNNOUd2cm5zcld4R0l0Z1lMUXpiellKRUlROXhGNVpR?=
 =?utf-8?B?N3ZUR01EZTVDMjY1MjJpVTlVS2Z2bkJRZkVvcUNCcVc1dFhxaWFqZTlKbGRP?=
 =?utf-8?B?Wmlkd0ZGRzVvT0xpRnMyOWFWSkpIQkw1dUpIM1Zhdi9wVXpmcWxTbUFIQSt0?=
 =?utf-8?B?Zm5QbTdoT1lmZU1TQTJXdHJmdlZFeW0vWVhTVnM1MEtWY1pXVlA2cVhjMkFM?=
 =?utf-8?B?TzhtanJGYmFFdnN3RkJsUkU3R2lrQjczZkVUTmsvelRRRHJxclNESXdqNk5L?=
 =?utf-8?B?amdFSTBwTjJrRUEvNDJydlVEQ1BId1h4UVJxUXFkeGRFYkxRM0NHeTlScmxW?=
 =?utf-8?B?R1Z6WXZlOUpieEI1MEttNXFKdjVUb0ZGdzJRS2FZbWVSY25iSlVvTlJSQUhj?=
 =?utf-8?B?dmt2MVA1L2NZMzl4M0IvZVB0OWpjR040MFJFVnAwZitrUGh6YVEyYTcxSGtT?=
 =?utf-8?B?MEJ0UzRMOVNMelZCQWZqRXpaRTI4cVhDd1FtYXBRa2xhMlg1dUF4b01zdE5Z?=
 =?utf-8?B?RUxKNmptY2h0dzdpREFxV2NaSjY0WnJ6K1J2dW0vUEdWZ1h3RkNwOXNDM1dH?=
 =?utf-8?B?MnZYaHRtZjBaU1lLOTRhVnVYMXhnVXhaUGVWRXRzaFRQTHgrcWpmL0FKMVpt?=
 =?utf-8?B?SUJjLytjUVlaZWlBdk85dFBwcFdDd3B1aEJEK3ZoUjc1Q1NrYkxpTTh3dGYv?=
 =?utf-8?B?QWRmVWhHcEpLZ1Y5dkFkeVByK0NGVXRzeFN5U0dLWnhjSHlMTkl2VUNsb0dr?=
 =?utf-8?B?dCtkOW85Q2JFc3J2bHVwemdFQXVSWFMvcURvOS9IaGJDOGNwaGlGaHlENE02?=
 =?utf-8?B?a1BBcFZFZjBTcVQ2d29qQU5FTStrT3JtdTlHeWRzUWRCdkg4ZnNhelE4dmRK?=
 =?utf-8?B?TlNzYVF2YnhteGU2cUV0cEt5U3QxTTFXL1ZuSVlEOWVvcVozclBFQXpVVUJL?=
 =?utf-8?B?QUpiYzFiaXdkWTN5bHdGajJUWUZCWkVuTW1Hdkd6bTRUc01ZcDIzTDUycHBN?=
 =?utf-8?B?V1gvdmp5eUZLVzdGRmxHdUFKMmZmbU9ncnNublhXdTBHckNabWJiUVZDSTQ5?=
 =?utf-8?B?Y1pqVnNQWU40N3lKZW45anBmSnZ6dTBDYUtkUk1GbGJUSVBqL3JCYmowT1Jv?=
 =?utf-8?B?M3JKU2MvVC9TeE42UzNUckNkc2dKaWRva2J0QlUzRTIrY2R0M1E3UURxc3Ax?=
 =?utf-8?B?TTZVNnovTkxSZWxSTnVFV1pRS2wxTWRqZERKU09UR2w1MU9iVnlaakRVdHJZ?=
 =?utf-8?B?NjRaSFlxd2JSSXdtRVlBT2RuTTIzOCtYY25NSFYvbTg4c1JDbWlHOGVKcjZX?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96CB812916B17148A711811A0B31FE33@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942d2a0b-a0c9-47ed-d12b-08da9558195b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 07:18:04.0829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myygpC84o3KnRAH1B2V62xhWkBI+K09daP+4ZqTMSkzHrqXxJ9V0LZ++eBdraNcanobQ9NcaSsPsZg7aLOC26BKzYTV/QpAEfzq/59Nh2yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5649
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDkuMjAyMiAxMDowNCwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IERpc2FibGUgQUVT
IG5vZGUgb24gbGFuOTY2eCBwY2I4MjkwLCBwY2I4OTEgYW5kIHBjYjgzMDkgYmVjYXVzZSB0aGVz
ZQ0KPiBib2FyZHMgaGF2ZSBsYW45NjZ4IHRoYXQgdXNlcyBzZWN1cmUgT1Mgd2hpY2ggcmVzZXJ2
ZXMgdGhlIEFFUyBibG9jay4NCj4gVGhlcmVmb3JlIGl0IGNhbid0IGJlIGV4cG9zZWQgdG8gbm9u
LXNlY3VyZSB3b3JsZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhvcmF0aXUgVnVsdHVyIDxob3Jh
dGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPg0KDQpBcHBsaWVkIHRvIGF0OTEtZHQsIHRoYW5rcyEN
Cg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MC5kdHMgfCA0ICsr
KysNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMgfCA0ICsrKysNCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODMwOS5kdHMgfCA0ICsrKysNCj4gIDMgZmls
ZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4
LXBjYjgyOTAuZHRzDQo+IGluZGV4IDhhMzA0MjEwNjUzYS4uMmVkNTNkYTkxNGFjIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTAuZHRzDQo+ICsrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MC5kdHMNCj4gQEAgLTI3LDYgKzI3LDEwIEBA
IHBoeV9leHRlcm5hbF9yZXNldDogcGh5X2V4dGVybmFsX3Jlc2V0IHsNCj4gIAl9Ow0KPiAgfTsN
Cj4gIA0KPiArJmFlcyB7DQo+ICsJc3RhdHVzID0gImRpc2FibGVkIjsgLyogUmVzZXJ2ZWQgYnkg
c2VjdXJlIE9TICovDQo+ICt9Ow0KPiArDQo+ICAmZ3BpbyB7DQo+ICAJbWlpbV9hX3BpbnM6IG1k
aW8tcGlucyB7DQo+ICAJCS8qIE1EQywgTURJTyAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngt
cGNiODI5MS5kdHMNCj4gaW5kZXggMjg5YTMxNjQ5NDIyLi5mNGYwNTRjZGYyYTggMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMNCj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0cw0KPiBAQCAtNTMsNiArNTMsMTAgQEAg
bGVkLXMxLWdyZWVuIHsNCj4gIAl9Ow0KPiAgfTsNCj4gIA0KPiArJmFlcyB7DQo+ICsJc3RhdHVz
ID0gImRpc2FibGVkIjsgLyogUmVzZXJ2ZWQgYnkgc2VjdXJlIE9TICovDQo+ICt9Ow0KPiArDQo+
ICAmZ3BpbyB7DQo+ICAJZmMzX2JfcGluczogZmMzLWItcGlucyB7DQo+ICAJCS8qIFJYLCBUWCAq
Lw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MzA5LmR0cyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODMwOS5kdHMNCj4gaW5kZXggY2ZkN2M4OTMz
NzAzLi5jNDM2Y2QyMGQ0YjQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2
NngtcGNiODMwOS5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MzA5
LmR0cw0KPiBAQCAtOTcsNiArOTcsMTAgQEAgc2ZwMzogc2ZwMyB7DQo+ICAJfTsNCj4gIH07DQo+
ICANCj4gKyZhZXMgew0KPiArCXN0YXR1cyA9ICJkaXNhYmxlZCI7IC8qIFJlc2VydmVkIGJ5IHNl
Y3VyZSBPUyAqLw0KPiArfTsNCj4gKw0KPiAgJmZseDMgew0KPiAgCWF0bWVsLGZsZXhjb20tbW9k
ZSA9IDxBVE1FTF9GTEVYQ09NX01PREVfVVNBUlQ+Ow0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCg0K
