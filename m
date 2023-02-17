Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E926169AAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBQLqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBQLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:46:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E65BDBF;
        Fri, 17 Feb 2023 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676634391; x=1708170391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z8H6GHcokuSBjqedsYVRyDoC8v6B+xEonu94L+Hujgg=;
  b=iB0UoIGMTN1gsCeVamNHVadlz5km3+Vjx8TfT+mDIQYyLqK4I//oNM4h
   QQa5bfrZ4fA96x5uU1C4b0m65VQ6wL7tAotqcxIbx4cNhstJPL2OAKLF6
   3hSb3LElQT8gva0jTqsH9G9WXBHCu47xX3WnF5unqMK2m96O3NlvAlUg0
   nInUSDVvMZSbwbtnZBw4mfpR3++8MwDlSnzt8UxvfBPFuljjQ3rGUEubi
   UQiM9/LJG40XZV0RLPivx54LmsCVrc6/QvaHy0oE/h/2CZlouStNtOXGx
   c/xmECGy7a3zfUOIrmSpABM/fs+kbVRRHBksTKBn1jI4iFPuWpkGs5Rt6
   w==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="201107213"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 04:46:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 04:46:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 17 Feb 2023 04:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/TCzGDNhjK4h6wt6pEtyUNeMILmQGa3mjwDTEsMFK2InVRkVlBbT7XO5OmeTYgDddxEZnAiJwuYrBAP5LsxR5XFOjHjYY81iA5EsPCcZekOhwCxNP0kmZuabqC4/kPruX77gb8nI6KgSoQIZ0CJgidpuN2MaLH95sNPW5CkMN8DFvWDd0WekU0gGHrkqOtMydR7Km+IgNYdN6T8QzZuuJDUDqbcxvyILlk5OTd0Y5fDhd9dgbsqljm1YGG2yigI6Unbpab95Gz2p4eLQ4/46EsdsRTFfZmNg1VeglEsHGOsRWgCzUdZAMcluIPHmKd/90zAeR7XNYGSRLkDzj74wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8H6GHcokuSBjqedsYVRyDoC8v6B+xEonu94L+Hujgg=;
 b=ZYamJ8fQyi2xLhO/LE1VWZ4s/VSCzNPVBuP9sRcJNbGEbKbgiyiuAbSnRiyojj9lI/cJRiMyOOSGOi6D5h6eFn/Wo/Gf62n6qXYe4fL67WU0dsw0angXyooq9ZzubhwXiCTbGJK+QURGhTU+dHxwkWdhDuJe6EeFPojOYeDZLCPKFzpDkkhhMDg6JjmJQPQxrQsWXqnmpO5yMjSkFZjejkqr49v3F+CYjn95YHL2N4F9bn+pB6DahWt41XKCPaxEz+V9qpMbSSm6v2hMMgoqZdW0SdelKVNLm/gP94YQTQlPtdhT0xl/BEpchkAVl1YyWvCE0OGGBmLCrOmlOv9Vbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8H6GHcokuSBjqedsYVRyDoC8v6B+xEonu94L+Hujgg=;
 b=vmea0+nHkL8rrKlfGzb60mQwLaMBzhH/WZhQgbVfy8O/P9o3kVuy3hYIdA+M1uABQTtgxJotTmFkl2stGbQITWhcmzrqWA7SjGjIor7Lb4gnxK6ScwmCtmkNkIVfLj4EB9uZFwHHJeoktn9JGqaBZcKpprmdMGPWV67p73MyUig=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BY1PR11MB8032.namprd11.prod.outlook.com (2603:10b6:a03:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 11:46:16 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 11:46:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <broonie@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linus.walleij@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pinctrl: at91: Make the irqchip immutable
Thread-Topic: [PATCH 1/2] pinctrl: at91: Make the irqchip immutable
Thread-Index: AQHZQsVxhIdG46TaXkSpsuL/J9cBjQ==
Date:   Fri, 17 Feb 2023 11:46:15 +0000
Message-ID: <c5e900c4-92fe-b3cd-e3f6-9bfd18ee2b9e@microchip.com>
References: <20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org>
 <20230216-gpio-at91-immutable-v1-1-44f52f148ab9@kernel.org>
In-Reply-To: <20230216-gpio-at91-immutable-v1-1-44f52f148ab9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BY1PR11MB8032:EE_
x-ms-office365-filtering-correlation-id: 92a31467-9291-45bf-cbf4-08db10dc93af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUVXrPcQEz7l2LXUIQK830a4lxpIb88PIZIY+OIR8yhJ7x51jy4K1N3Dwu3l2IY01ddzLz17nhva3z1tVSrZjr0/mEMAJJvApO4yImlYahKadhDb/vP7LdE7ZbD3+e4xQ/q7wrc8hC5p/lbSq2vMOI1XqIuFxZthnIKwtVNup/N8TnnRSu7bIzU26PhGZfvr+tOpmA3SPAxCsI/LZODylQcCjc3NS623TWbIIGt9vNDWwyTZO0LLplDMcvaJ6ohgiM0ePgdtxJ1BnT4XLXHS+sUrgpUK0xCpL/n6IjmLUEtE0ZyOqggaEi5z5Z6iI8zABxPZaxawKhdxD6e06wIU6xBzcvpa8opkBOGu3+d0Fsyap3gwGfLY9vdkYjz+Qkqhz3v3Ld3oGudq2LuOe2BV/zE8YGVB8St7EM7R3d3N89FaQ/zxJqLOFHlR2zHAq8EvHDdqtjuu6v/8Q0UPQNZ8cyyuwFTAHHOb+0Y5JfEccF39P2ErH2vGorkSEmO2O2/t5NwJ8FdTDzkmcTyH2IgT6c7R5lWrUB7bgeThWh2BRtH/O1aT710MOXKWeFPRpp2ZD5ZCbrNDyKqWazyYgnj2EyVzFstXe1TXIDXuEogh5ef4AHZlpHryorNVLPv3GJ7l1b5eToNlrVEAEQIl2x7KUtXBegd4PfFXgzLd1ApHHXXCuz1ZE2bEkSIZuEWki2mULsML4wcR68in9Y83BZvSt5dfzgeKK6k/vLTCpvpsLpfJGvmhQhCidpIi9a2wy5XOOfjSdy/PIgeIrDWSilhWYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199018)(66476007)(91956017)(64756008)(38070700005)(66556008)(66446008)(31686004)(83380400001)(8676002)(4326008)(76116006)(41300700001)(38100700002)(316002)(8936002)(66946007)(54906003)(6486002)(110136005)(5660300002)(2616005)(122000001)(26005)(86362001)(31696002)(186003)(36756003)(2906002)(71200400001)(6512007)(478600001)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjlxTm0wV1hOandrWmpHVUN4S1JaOWs4VlFXUTlHTjE5ZkJvNFdaSUJCTkRP?=
 =?utf-8?B?RUVTS2QwdCtqWkdIUEtZcWN5dlRQNkJ2NkY0SWZjNXBJZTBzK284OU8zRENK?=
 =?utf-8?B?K0dTYSt6TlpRZTkycTBrOXpyZWh3NHdmM2dyVHUwNjZtaVN6R2NLZ3JIdTc4?=
 =?utf-8?B?WFBZanFabmU0NkM5cXdWYkRkZVlQY0JMakIvZGpNZ0NmbmlybVN4WWVwM28w?=
 =?utf-8?B?YUN6SFdsZ0RnSEhScXdNUGZ6UmxaWVNKYVZvRW5oRlZyRXlBdzBGMDZ0OHBC?=
 =?utf-8?B?a1Q0MzlRbUNmT0xqVHIxSzYzZ21OMTJxZ2YzZmgwNTA4aStzZGJoR3RjMVFS?=
 =?utf-8?B?NjN6U2VXSFVGRXRYT1ZXN0R4NEtWQ3VQelZaTXlBRHpTVjdsZDFaV3RidjlD?=
 =?utf-8?B?UnRod1ozWG0xK3NRcDlCUlVVaEUzaG15NVM5dEEwR1lHM3NwSUFjOUErL0Zw?=
 =?utf-8?B?RlFWSFYyYkQzQm1Zd2NodlFiUUxtcUp1a1kwcHdqaVFncXVOSzc0MFZWT2hZ?=
 =?utf-8?B?WVlkb2FLWWduY0JQeVp0aGlVS0dBaVdpYUxndHdudkJYU000eHVUMTk3K08z?=
 =?utf-8?B?L093MlFkVzVwc1VXS1Nlc01qaTZ2S0licFZqUzBERE82eVBwNHdVdmphTEYw?=
 =?utf-8?B?N2MxRDVPU1N0Qkw5UklDZHlQZWZlY1ZnWnVNRzcrZ0h2bnlNenFEZVM5Qyt2?=
 =?utf-8?B?WXp4eXV6RE1rZXhBb29udHNiVWk4cUxZbTVOb3NJWXVjd0lBbFJkWXdRNmlC?=
 =?utf-8?B?Q2VnUUZwNzhJZTdVd3g2czVueVlMZVlCUWNoQVZyaGdVSnQ0ZHcwaXFnMVBu?=
 =?utf-8?B?a3BlNm5DQzNaZTRrbUdFNUg2SFByWEkwWUJ5TElvV24wTVhYT1FaZjlIZ0xN?=
 =?utf-8?B?a01YRytSTytJeU03cm45cVlYdG9YRFkyRmVpZGxDTUxYOHdoL1hVZjBWWjdk?=
 =?utf-8?B?em9DY2hIcVdJWHFZeWwzZkxRT0l6UzF0bW1CcnZEbjRCNmNzQS92blU5c1JR?=
 =?utf-8?B?Vlc5OWx4UHNZQStuNnJxbERGcFhJbTk0QTluRzl4RnFPR21SL2laeTJnWnJn?=
 =?utf-8?B?V2lINmFVWGMwSzNPcFd3bHlDbVlmN2hZb0pJUU9Ra0tuQWQzU21Jeis5RW1O?=
 =?utf-8?B?VmdRcVQ2eTA2ZTJvU2ZheHExNlRuL0h0S05DVkkvT05uT2NMd0cwTW0vaDB3?=
 =?utf-8?B?VjZxUkpUWm1Xb2trQ3V2aHRhSU93Z3NlTnNjaG9DTlEzWXNudUpreG9kQUN0?=
 =?utf-8?B?NnRrT3F3UHNhZDZhWENtUldWazQyd2tHZXF2U3lodjlJMEdKVnkyK3RQaG83?=
 =?utf-8?B?U203RzRBVVg0R01CMG5DZnpMVEE4NjFnVUdSQ2NxcTNIZHNEWFpaWXVUa1dD?=
 =?utf-8?B?OTBkeGhzNW1QM0JRTU40c2w2REkrQXdqV21JK0JGUHczK2ZTZVhiNjhaelAy?=
 =?utf-8?B?YnVMVzRSWjN5ZU15S3BGVnBRR1RoZERiK2RqbjBVYTk5TW96am0reXcyV0lK?=
 =?utf-8?B?NVluU243ZVJ5bHl1Rkl1ZlZ6cXRuVHAxQTkyUTNEbCs5dXBQNFVuTVlvQ1pJ?=
 =?utf-8?B?RHFINzY3dWdBcVIrL2xQYmxBN1FXREtBRHZXNDRhcFFzWmVTQVkrK1N5Z1FT?=
 =?utf-8?B?Zy81NnhkMWxOTVBsblZiNUhqNUFobjdwM3RobkE0bnFmM09UNTk1OEF6ZTRm?=
 =?utf-8?B?ZmZQcjh6NmptbWxBbE1YMkhSeUQxNTNqMFR6VGZuUHhqTnZpKzdlejlRRmZv?=
 =?utf-8?B?ZGtqZ3ovQVgyRjNuNDVQeDRRVW1EYXJ2UkRqdDVMWEZJNkdlVEtpWUIrRGRH?=
 =?utf-8?B?Q1BLS2w2czJXbjRPa3N0cXdMbkEzMDlhVDg1cUxtd3A3Q0pDb0grSXB1YnM1?=
 =?utf-8?B?UXZKREx3SWFGc2loVERIMlNLSGZQSFQ5bzJxeG5nMWJLRU1lTGxGSUVqL2FK?=
 =?utf-8?B?dWxGRFk0aG4rKzZ0d01VQjdDa0FKdEk4MjZKcVc0Mk14RnNpZG1NakZpdVFi?=
 =?utf-8?B?Wmk0ZG9pUk5LZTZpR2JUL3ltMTQ2a0k3Z2JZREYwaStDSGhleE9mMDB4R0hM?=
 =?utf-8?B?ZUpwMTdzUGpxRWhKUGo4RHRLN0QrckNtMmw5TVArMXA0R3NiSkZHOWg5MHcx?=
 =?utf-8?B?WnhFTnMxWHZmcnkwUmk2UTBTODlHZFN0bHZodEVBVS90ZVBXQkFXMC9PSHBE?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <143658BDE24D904B8374274C3DBE4ACF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a31467-9291-45bf-cbf4-08db10dc93af
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 11:46:15.9209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Gfdsdrzy81ENG9Pz2eRUwnc004npyBBWdnHPXIs9Y9c4G7zfepAO2ZrKbBbDSSRN4644bjzEsHsDfYiCmG6o3jxfwreoC3T7GGVxcBUrAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8032
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDIuMjAyMyAxNzo0MywgTWFyayBCcm93biB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUbyBoZWxwIGdwaW9saWIgbm90IGZpZGRsZSBhcm91
bmQgd2l0aCB0aGUgaW50ZXJuYWxzIG9mIHRoZSBpcnFjaGlwDQo+IGZsYWcgdGhlIGNoaXAgYXMg
aW1tdXRhYmxlLCBhZGRpbmcgdGhlIGNhbGxzIGludG8gdGhlIGdwaW9saWIgY29yZQ0KPiByZXF1
aXJlZCB0byBkbyBzby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVA
a2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgfCAy
NSArKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3Ry
bC9waW5jdHJsLWF0OTEuYyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYw0KPiBpbmRl
eCAxZTE4MTNkN2M1NTAuLjhlY2Y1MmVjOWI5YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5j
dHJsL3BpbmN0cmwtYXQ5MS5jDQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEu
Yw0KPiBAQCAtMTUzNiw2ICsxNTM2LDIwIEBAIHN0YXRpYyB2b2lkIGF0OTFfZ3Bpb19kYmdfc2hv
dyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHN0cnVjdCBncGlvX2NoaXAgKmNoaXApDQo+ICAjZGVmaW5l
IGF0OTFfZ3Bpb19kYmdfc2hvdyAgICAgTlVMTA0KPiAgI2VuZGlmDQo+IA0KPiArc3RhdGljIGlu
dCBncGlvX2lycV9yZXF1ZXN0X3Jlc291cmNlcyhzdHJ1Y3QgaXJxX2RhdGEgKmQpDQo+ICt7DQo+
ICsgICAgICAgc3RydWN0IGF0OTFfZ3Bpb19jaGlwICphdDkxX2dwaW8gPSBpcnFfZGF0YV9nZXRf
aXJxX2NoaXBfZGF0YShkKTsNCj4gKw0KPiArICAgICAgIHJldHVybiBncGlvY2hpcF9sb2NrX2Fz
X2lycSgmYXQ5MV9ncGlvLT5jaGlwLCBpcnFkX3RvX2h3aXJxKGQpKTsNCj4gK30NCj4gKw0KPiAr
c3RhdGljIHZvaWQgZ3Bpb19pcnFfcmVsZWFzZV9yZXNvdXJjZXMoc3RydWN0IGlycV9kYXRhICpk
KQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBhdDkxX2dwaW9fY2hpcCAqYXQ5MV9ncGlvID0gaXJx
X2RhdGFfZ2V0X2lycV9jaGlwX2RhdGEoZCk7DQo+ICsNCj4gKyAgICAgICBncGlvY2hpcF91bmxv
Y2tfYXNfaXJxKCZhdDkxX2dwaW8tPmNoaXAsIGlycWRfdG9faHdpcnEoZCkpOw0KPiArfQ0KPiAr
DQo+ICAvKiBTZXZlcmFsIEFJQyBjb250cm9sbGVyIGlycXMgYXJlIGRpc3BhdGNoZWQgdGhyb3Vn
aCB0aGlzIEdQSU8gaGFuZGxlci4NCj4gICAqIFRvIHVzZSBhbnkgQVQ5MV9QSU5fKiBhcyBhbiBl
eHRlcm5hbGx5IHRyaWdnZXJlZCBJUlEsIGZpcnN0IGNhbGwNCj4gICAqIGF0OTFfc2V0X2dwaW9f
aW5wdXQoKSB0aGVuIG1heWJlIGVuYWJsZSBpdHMgZ2xpdGNoIGZpbHRlci4NCj4gQEAgLTE1NTUs
NiArMTU2OSw5IEBAIHN0YXRpYyB2b2lkIGdwaW9faXJxX21hc2soc3RydWN0IGlycV9kYXRhICpk
KQ0KPiAgICAgICAgIHN0cnVjdCBhdDkxX2dwaW9fY2hpcCAqYXQ5MV9ncGlvID0gaXJxX2RhdGFf
Z2V0X2lycV9jaGlwX2RhdGEoZCk7DQo+ICAgICAgICAgdm9pZCBfX2lvbWVtICAgICpwaW8gPSBh
dDkxX2dwaW8tPnJlZ2Jhc2U7DQo+ICAgICAgICAgdW5zaWduZWQgICAgICAgIG1hc2sgPSAxIDw8
IGQtPmh3aXJxOw0KPiArICAgICAgIHVuc2lnbmVkICAgICAgICBncGlvID0gaXJxZF90b19od2ly
cShkKTsNCg0KVGhlcmUgYXJlIHNwYWNlcyBiL3cgdW5zaWduZWQgYW5kIGdwaW8uIEFsc28sIGly
cWRfdG9faHdpcnEoKSByZXR1cm5zIGENCmlycV9od19udW1iZXJfdC4NCg0KPiArDQo+ICsgICAg
ICAgZ3Bpb2NoaXBfZGlzYWJsZV9pcnEoJmF0OTFfZ3Bpby0+Y2hpcCwgZ3Bpbyk7DQo+IA0KPiAg
ICAgICAgIGlmIChwaW8pDQo+ICAgICAgICAgICAgICAgICB3cml0ZWxfcmVsYXhlZChtYXNrLCBw
aW8gKyBQSU9fSURSKTsNCj4gQEAgLTE1NjUsNiArMTU4Miw5IEBAIHN0YXRpYyB2b2lkIGdwaW9f
aXJxX3VubWFzayhzdHJ1Y3QgaXJxX2RhdGEgKmQpDQo+ICAgICAgICAgc3RydWN0IGF0OTFfZ3Bp
b19jaGlwICphdDkxX2dwaW8gPSBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkKTsNCj4gICAg
ICAgICB2b2lkIF9faW9tZW0gICAgKnBpbyA9IGF0OTFfZ3Bpby0+cmVnYmFzZTsNCj4gICAgICAg
ICB1bnNpZ25lZCAgICAgICAgbWFzayA9IDEgPDwgZC0+aHdpcnE7DQo+ICsgICAgICAgdW5zaWdu
ZWQgICAgICAgIGdwaW8gPSBpcnFkX3RvX2h3aXJxKGQpOw0KDQpkaXR0by4NCg0KPiArDQo+ICsg
ICAgICAgZ3Bpb2NoaXBfZW5hYmxlX2lycSgmYXQ5MV9ncGlvLT5jaGlwLCBncGlvKTsNCj4gDQo+
ICAgICAgICAgaWYgKHBpbykNCj4gICAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKG1hc2ss
IHBpbyArIFBJT19JRVIpOw0KPiBAQCAtMTczMSwxMiArMTc1MSwxNSBAQCBzdGF0aWMgaW50IGF0
OTFfZ3Bpb19vZl9pcnFfc2V0dXAoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gICAg
ICAgICBhdDkxX2dwaW8tPnBpb2NfaHdpcnEgPSBpcnFkX3RvX2h3aXJxKGQpOw0KPiANCj4gICAg
ICAgICBncGlvX2lycWNoaXAtPm5hbWUgPSAiR1BJTyI7DQo+ICsgICAgICAgZ3Bpb19pcnFjaGlw
LT5pcnFfcmVxdWVzdF9yZXNvdXJjZXMgPSBncGlvX2lycV9yZXF1ZXN0X3Jlc291cmNlczsNCj4g
KyAgICAgICBncGlvX2lycWNoaXAtPmlycV9yZWxlYXNlX3Jlc291cmNlcyA9IGdwaW9faXJxX3Jl
bGVhc2VfcmVzb3VyY2VzOw0KPiAgICAgICAgIGdwaW9faXJxY2hpcC0+aXJxX2FjayA9IGdwaW9f
aXJxX2FjazsNCj4gICAgICAgICBncGlvX2lycWNoaXAtPmlycV9kaXNhYmxlID0gZ3Bpb19pcnFf
bWFzazsNCj4gICAgICAgICBncGlvX2lycWNoaXAtPmlycV9tYXNrID0gZ3Bpb19pcnFfbWFzazsN
Cj4gICAgICAgICBncGlvX2lycWNoaXAtPmlycV91bm1hc2sgPSBncGlvX2lycV91bm1hc2s7DQo+
ICAgICAgICAgZ3Bpb19pcnFjaGlwLT5pcnFfc2V0X3dha2UgPSBwbV9wdHIoZ3Bpb19pcnFfc2V0
X3dha2UpOw0KPiAgICAgICAgIGdwaW9faXJxY2hpcC0+aXJxX3NldF90eXBlID0gYXQ5MV9ncGlv
LT5vcHMtPmlycV90eXBlOw0KPiArICAgICAgIGdwaW9faXJxY2hpcC0+ZmxhZ3MgPSBJUlFDSElQ
X0lNTVVUQUJMRTsNCj4gDQo+ICAgICAgICAgLyogRGlzYWJsZSBpcnFzIG9mIHRoaXMgUElPIGNv
bnRyb2xsZXIgKi8NCj4gICAgICAgICB3cml0ZWxfcmVsYXhlZCh+MCwgYXQ5MV9ncGlvLT5yZWdi
YXNlICsgUElPX0lEUik7DQo+IEBAIC0xNzQ3LDcgKzE3NzAsNyBAQCBzdGF0aWMgaW50IGF0OTFf
Z3Bpb19vZl9pcnFfc2V0dXAoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gICAgICAg
ICAgKiBpbnRlcnJ1cHQuDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgZ2lycSA9ICZhdDkxX2dw
aW8tPmNoaXAuaXJxOw0KPiAtICAgICAgIGdpcnEtPmNoaXAgPSBncGlvX2lycWNoaXA7DQo+ICsg
ICAgICAgZ3Bpb19pcnFfY2hpcF9zZXRfY2hpcChnaXJxLCBncGlvX2lycWNoaXApOw0KPiAgICAg
ICAgIGdpcnEtPmRlZmF1bHRfdHlwZSA9IElSUV9UWVBFX05PTkU7DQo+ICAgICAgICAgZ2lycS0+
aGFuZGxlciA9IGhhbmRsZV9lZGdlX2lycTsNCj4gDQo+IA0KPiAtLQ0KPiAyLjM0LjENCj4gDQoN
Cg==
