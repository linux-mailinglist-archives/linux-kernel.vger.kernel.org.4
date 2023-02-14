Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8DD6961EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjBNLG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjBNLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:06:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7B28D01;
        Tue, 14 Feb 2023 03:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676372745; x=1707908745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z5WrKge1vukgvGF4MsPSiRgZWARqvoyhLsb9kr8S3nY=;
  b=aJbfyKrAuzeF/PKpx/W44nvGappCSlU3PITiO26RPOrIXNp8dI9sza35
   FdY7bP/uHYyKpUt6IV4awNbSFWg0HvvBrMU6Y6+LXyiIvgOGLGIIQ4pWp
   su9NzXEoKO/D84YrLav/ZeEuIxamU6G8V9b39pc/NupvnDYsS8BzDESo/
   pLGhJhFmiLI0t1m1X+p1FNjfD33ogfqjPrzB3ZHzZllEEOhsP4UU0fdW0
   dUH7Yj6IsS8lNoY39G3yWu8L+OP9ujfFqMP/0vJAziwJ651zN7bOqtEx7
   ntlFslT+F95XtehTSpXEJuEUgMOQAAtq6wn+5Nap1oPhONSSgmawFaQsT
   A==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="196828434"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 04:05:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 04:05:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 14 Feb 2023 04:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJDdYuofposeYG+NZNf4mzDvu4q8o7i3TUKXZ0/F6NfxfDI5OGVhD6UV60gYcYUzPrPUI5L+Cu2SMhEG9cGqzlvXeHcNO3CDl2O8D6RxYlf+aXy+cFibGJQ8ge6EmX/MkJwgVyFqiN2PnlNnjQ73RI6fwinj3WjK+WpzQDs94y7C1lOfF+iL97mQ6nwo4Pk3FbKMk4R7xwBW5Bp0Xi/YFo5oX5pcvrDrryUFknh6bbX5Njlu0vR7O491k6t4h9ExTHDKmZaPvrbT0Jtn7g6ADLS/ituOgaSLMGVQFJlOPD6z6fmFP90VkLbIRqEtktFS3RtHTl+nbUKl3hx+iNTgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5WrKge1vukgvGF4MsPSiRgZWARqvoyhLsb9kr8S3nY=;
 b=LKhNujfxOmOoStFyZs0EabzkU/lBntH5c1AXKJNGScPbjQLWvQX2L1Gswaea++GXaafumNjsYKpOlV5vd+4q1Pav3FYM1nJiVsZI+5YXZab4jJA/hOOSkqoFijjSDfzDACD5kSfwaKp9Tn2qHc7w5qN7i/H7WbT/Y21qybv73/SxoEkeel2r9KP5LyXkx1sYSJJBi+hnOscn/3IcJTGKq343s14CPxygvxjNwFI8yCHZOlp7SrBer+sKc7z1mbd7xpUUYxc5npTuWTd0EHf0OSp+tx0Y4mHciB6vrbkZvJkC+pINhYedsDl6lQ+PsTig++KHwWyDSoEvJ6fe+g658Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5WrKge1vukgvGF4MsPSiRgZWARqvoyhLsb9kr8S3nY=;
 b=OwNg2W8aOW9kcPTEHq4prrmy29Z/ZF8ySAtlj9lDj3qvcryITX7CJgoYg9zAV+EgKxfU+ztlfpXVIqRG7dyuvoBulGU5ifZFvZFePdJumr1yeiPrApcwsLnqIJKcTdaIOUNeN/hiTPKBb74rtnwKB7GM/oCIfoUGLqXJ8BBFvNs=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 11:05:06 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 11:05:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <linus.walleij@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/5] pinctrl: at91: use devm_kasprintf() to avoid
 potential leaks (part 2)
Thread-Topic: [PATCH v2 1/5] pinctrl: at91: use devm_kasprintf() to avoid
 potential leaks (part 2)
Thread-Index: AQHZQGQxUYplTZ/AM0O/Sp+/Ibheow==
Date:   Tue, 14 Feb 2023 11:05:05 +0000
Message-ID: <b64bd722-5ce7-9cca-9547-be84d0ef381a@microchip.com>
References: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
 <20230213154532.32992-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230213154532.32992-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SN7PR11MB7637:EE_
x-ms-office365-filtering-correlation-id: cf44cd75-5dd0-4333-969d-08db0e7b5427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67Ot7H1PJPNcgySJ9zDzn7MnqacC4TPC2OJ6A3mzRLefb4Qfm/W7rlsjXqExnTiNLnmxyQwRQX/NRMo0FhLSnbksW47xziSTH4aNBuqhvkiUf7cTebng0cxT8EssQRV44gtvyAebXc8kfnVoH4n4eZcM3a0qQZtGn+ps7PQczzlnpRH4Almz7P6y/E+EyOFrpWNVnUVrHX8CvnTJYacP4CuHBtFIEEF3OrdSNZcZvfcrB4olyNAQYzXckWQWhjC8DTzLvG+MFN6rQikEJCWkCphnVNFBKOGZTwYZNiJLb/I4kmNiibbs/xdMONVelNj+KwjzZ6lrYshKBwiNONkMsKqMkxSkCdeysPeu6ZgZfvYAA+8cxPUwcraypMzW3Fs/RRJ7lvctxJtz8Mf+XnzLRoQPx3dAhIMcwyEqXVScCNv040Qs8r41hGFofw5UfQ7ZrfPEioMxlDWbDO8siHhH9+dLAg6em/wvG5Nme5G0jot0ilCcFoPyZldvRAybq9XZ/zDgdwW60ziZPDOLM/ljk2hEOYTIVzdddlYC+4V5aHBTuaH6PMoHjGe8UojVbt+RvRZQG9wTuqmwSxWAJ/lJYQ34Qvmo93Jtp4FUZXGJBQ5tgL3dxRZG4Tl5/mj2HmdQnYHsbjmkMvTE0MheGQmn/OdRMCfHDMBEJD+Tp+5aczokgzpLl2BNDoZCWsHWk4Z3Qvozap2o2v1jO3XQBZuaMMp3fCdqj/cRjoHEqZ/vCOoCQxqrepZ4HRi1sSU0IWAU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39840400004)(346002)(376002)(396003)(451199018)(2616005)(122000001)(478600001)(6486002)(36756003)(41300700001)(31686004)(6506007)(53546011)(5660300002)(6512007)(26005)(186003)(8936002)(2906002)(66556008)(38100700002)(71200400001)(31696002)(54906003)(316002)(66476007)(110136005)(86362001)(38070700005)(4326008)(83380400001)(8676002)(66946007)(64756008)(66446008)(76116006)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEJqT3N3NU50Y0lzaUp1YmhUQ3JQcDU3NThWai8veHd4SS8xODhnbU4yVUs3?=
 =?utf-8?B?ZWJILytJMnNCekhncFlXY296K1FXT1JSN1FLL2hqZVF0QlBBUkNIZlMvc1J0?=
 =?utf-8?B?NmhRUDZDN0kyZC8xUnRQZS9wbnFieEJLRTZpQUFXTjNvS0xxQUg2WThkNGFm?=
 =?utf-8?B?L3g4ZlpIekpiNkxBMWgvdHFYVjB4WWFrVFRRZjRIV281dW81TjJDbUwvRUpE?=
 =?utf-8?B?OTFGUUo4a3dkRFcxb2V0L3dKcTRYUyt4K1lES1RiVHdKS1FOOTZTTUlac1Rw?=
 =?utf-8?B?dFZpV1JyaTkxWUVVQzkrK2pQTG1US3pSMzNBelkySTBXYUh1QnRrMmFzZ3dY?=
 =?utf-8?B?dmczZzVnUXJZQ2YvZm9HR1NxUC9sYldFQ1hUQW1FZWpsbDV5SjIrWGhEUFAv?=
 =?utf-8?B?TVkyUnQwZWZRQ3A0T2VoSTZTZHh6R040QTlCQkNLM0JvS2I2b2hHaHBiZXVY?=
 =?utf-8?B?T1JaZlQ3SDRKRGpxRm8rZjZ5eVZCUjBIYUZHY0RKKzBuc1lhdzNVaitiSGxJ?=
 =?utf-8?B?S1JyaWlyTDF6VUgzdFhBQk9tbW5SSTdvUTdFYzdBS09wMzB0bG5vMjR1Q1Ir?=
 =?utf-8?B?NU56dzZMSEdLRVFkSEV5Y2RGb2wxeHFWdFBmVmtvUW9RaURwbnkxSEVJT3FC?=
 =?utf-8?B?b0J4WEI0SnBDN3hLekpYR3czUVZFOEM3NURXSnZyMWNLeWV5c3NnYmVFQVRq?=
 =?utf-8?B?d0tQd3JzV0ZzSkpWbXNuRGpYMklyb3A1aUo4K09QVG5CQUlsUGhDbGpEYkMr?=
 =?utf-8?B?aCtxT3hUS3hlN001VHc0M1hhZG1KQ3ppMGx2UWIyYUVxaU9HOGE2bG9Uc016?=
 =?utf-8?B?V1VhU05RdVozUHR2MlYvck96WDlDY2RFK29JWGNWZVNGaUpaMzV6TmswUXEx?=
 =?utf-8?B?NWNPNGVYWk5iNDBCdGJkblczcEwxeTFTa1ZBVDBHYWQvd2xKU0dqVE1MdmhR?=
 =?utf-8?B?RmJuWXBQREI4ME9JUlhvQkFFeitMbkNWLzBFOThYOXR6d1owZkdpVzhsMDVr?=
 =?utf-8?B?Ti9Ebks2emhsYUpGSFpVcy9VSkRpRmsyai9XNzljZjVkUmNTbTB2aDVETUtu?=
 =?utf-8?B?dlVSZnFYQUZqYStlbU5wODlzeEdrVHdOSkRZRVBRZWYvalBTNHhFZzdYQnZP?=
 =?utf-8?B?Z1hOOVN2RTF2UFJFQlNCVXBZWTBkMlBKSTVaY1luYWRwQ0RmRENUU0p6N0NN?=
 =?utf-8?B?dWxTem1GS0MwT0NubE5VY3JPZ1N5NUhzdXFmd1BvTGxTZlN3aUJNRWpFa2NK?=
 =?utf-8?B?VndTWjJ1cjNGdjVWMkZPU2tkOVFOWDY5UDVtU0NjR0Rkd2d4VE9aamcwTzhZ?=
 =?utf-8?B?ZkhKT0hLSGlpYjYwZ0Q5Zk1NMVpFSWgwaGJydGxCWVl6dFdhWEg1UWF0Tmlr?=
 =?utf-8?B?dk43bW5ROTNSbHU4L1hLYjd2SlZWU2tFbFBWWk9JYi9qYkY1SEl5VnZIZ2F0?=
 =?utf-8?B?LytKUjEwS3JhZzJmVVdCSzJ1aDRxTUg5Y2RKOXplbGxVNUcwVkhyRzFYeXhq?=
 =?utf-8?B?YnN0cVJUVWIvK3JmZTV6aWpTUjNvMEhMZlFVNDhFSUJ1S3hJRHVMUFFRalpR?=
 =?utf-8?B?RUZSOERjQjA5bjkrMFI4M3lPODJsRHVRRXBaeVcydm1ERkFqU2VuRGNHc1Fs?=
 =?utf-8?B?MFVXZ1dHUUVMcVFMYm8xZ01MWXJhQkR3L1d4aGJ2dDhSanVlN2w1UUZHNWc2?=
 =?utf-8?B?T081RTNyZHczcFVvNTlVemo1bGl4aFZOVkdYT2VBTFRCRUFKbHhoK3NMUndV?=
 =?utf-8?B?SGxxVDF0Vk9mS2FBNlZYSmdmRTcwQWRHVkJSSVdYYjZEdFdFYzExaTlrS1FU?=
 =?utf-8?B?RVhwR1U1LzZHY3lXK0NRbHZnUXJvUWxNQWx1ZlZnYkFBckxWVHI0UU5RTHhP?=
 =?utf-8?B?U2xoMDBHSVB0VUdiSk1RejFQdVh6aDdHYU90NW9HZE9xYjQ0cGZJc3NKdU5x?=
 =?utf-8?B?L0w0K3pQWjFPU3RsbmI1S2tVSWNJeXhteHpncXlPL0FPZ2RhZHlnMlEyUWkr?=
 =?utf-8?B?eFFtVFRwbEszdWNUV1gyN0J6NlhhN212Ukk3VVlRd00rM21RZkhFUzN4K1Y0?=
 =?utf-8?B?U3NvNTZMYVZjUFdGcU82R1Jrb0hGdzVsMWl3S0lTRnNaZFFBckxycGJQZk9T?=
 =?utf-8?B?VWhSQTU4NlRsbURGYklmRXEzZ1ExOUZhV2FueCtaazAzb29SSU5mQzJudHRZ?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A72C41B7062D543A2CC609E4561B7B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf44cd75-5dd0-4333-969d-08db0e7b5427
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 11:05:05.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1G9huSRfsI3eBIN5qFBG2BjL1rPttIsEbdYyxPP7sgSNfvzneVsMWtIrLGQ7nBAjMzxJfW9umCxNUzu7/19GgpODD8wxHNvXPQIYlsZe8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDIuMjAyMyAxNzo0NSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFVzZSBkZXZtX2thc3ByaW50ZigpIGluc3Rl
YWQgb2Yga2FzcHJpbnRmKCkgdG8gYXZvaWQgYW55IHBvdGVudGlhbA0KPiBsZWFrcy4gQXQgdGhl
IG1vbWVudCBkcml2ZXJzIGhhdmUgbm8gcmVtb3ZlIGZ1bmN0aW9uYWxpdHkgaGVuY2UNCj4gdGhl
cmUgaXMgbm8gbmVlZCBmb3IgZml4ZXMgdGFnLg0KPiANCj4gV2hpbGUgYXQgaXQsIHN3aXRjaCB0
byB1c2UgZGV2bV9rYXNwcmludGZfc3RyYXJyYXkoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFu
ZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KDQpSZXZp
ZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpU
ZXN0ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0K
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgfCAyMyArKysrKysr
KysrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwt
YXQ5MS5jIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+IGluZGV4IDJlN2RlYmI5
MDVkNS4uNWMwMTc2NWM3YTJhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvcGluY3Ry
bC1hdDkxLmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+IEBAIC0x
OCw2ICsxOCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvcG0uaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9zZXFfZmlsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9zdHJpbmdfaGVscGVycy5oPg0KPiANCj4gIC8qIFNpbmNlIHdlIHJlcXVlc3QgR1BJT3Mg
ZnJvbSBvdXJzZWxmICovDQo+ICAjaW5jbHVkZSA8bGludXgvcGluY3RybC9jb25zdW1lci5oPg0K
PiBAQCAtMTM3MSw2ICsxMzcyLDcgQEAgc3RhdGljIGludCBhdDkxX3BpbmN0cmxfcHJvYmVfZHQo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gDQo+ICBzdGF0aWMgaW50IGF0OTFfcGlu
Y3RybF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiArICAgICAg
IHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAgICAgICAgc3RydWN0IGF0OTFf
cGluY3RybCAqaW5mbzsNCj4gICAgICAgICBzdHJ1Y3QgcGluY3RybF9waW5fZGVzYyAqcGRlc2M7
DQo+ICAgICAgICAgaW50IHJldCwgaSwgaiwgazsNCj4gQEAgLTEzOTQsOSArMTM5NiwxOSBAQCBz
dGF0aWMgaW50IGF0OTFfcGluY3RybF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+IA0KPiAgICAgICAgIGZvciAo
aSA9IDAsIGsgPSAwOyBpIDwgZ3Bpb19iYW5rczsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgICBj
aGFyICoqbmFtZXM7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIG5hbWVzID0gZGV2bV9rYXNwcmlu
dGZfc3RyYXJyYXkoZGV2LCAicGlvIiwgTUFYX05CX0dQSU9fUEVSX0JBTkspOw0KPiArICAgICAg
ICAgICAgICAgaWYgKCFuYW1lcykNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQo+ICsNCj4gICAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBNQVhfTkJfR1BJ
T19QRVJfQkFOSzsgaisrLCBrKyspIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2hhciAq
bmFtZSA9IG5hbWVzW2pdOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnJlcGxh
Y2UobmFtZSwgJy0nLCBpICsgJ0EnKTsNCj4gKw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBw
ZGVzYy0+bnVtYmVyID0gazsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcGRlc2MtPm5hbWUg
PSBrYXNwcmludGYoR0ZQX0tFUk5FTCwgInBpbyVjJWQiLCBpICsgJ0EnLCBqKTsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcGRlc2MtPm5hbWUgPSBuYW1lOw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICBwZGVzYysrOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4gQEAg
LTE3OTcsNyArMTgwOSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0OTFf
Z3Bpb19vZl9tYXRjaFtdID0gew0KPiANCj4gIHN0YXRpYyBpbnQgYXQ5MV9ncGlvX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+IC0gICAgICAgc3RydWN0IGRldmlj
ZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiArICAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldiA9ICZwZGV2LT5kZXY7DQo+ICsgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRl
di0+b2Zfbm9kZTsNCj4gICAgICAgICBzdHJ1Y3QgYXQ5MV9ncGlvX2NoaXAgKmF0OTFfY2hpcCA9
IE5VTEw7DQo+ICAgICAgICAgc3RydWN0IGdwaW9fY2hpcCAqY2hpcDsNCj4gICAgICAgICBzdHJ1
Y3QgcGluY3RybF9ncGlvX3JhbmdlICpyYW5nZTsNCj4gQEAgLTE4NjYsMTYgKzE4NzksMTQgQEAg
c3RhdGljIGludCBhdDkxX2dwaW9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgY2hpcC0+bmdwaW8gPSBuZ3BpbzsNCj4gICAgICAg
ICB9DQo+IA0KPiAtICAgICAgIG5hbWVzID0gZGV2bV9rY2FsbG9jKCZwZGV2LT5kZXYsIGNoaXAt
Pm5ncGlvLCBzaXplb2YoY2hhciAqKSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBH
RlBfS0VSTkVMKTsNCj4gLQ0KPiArICAgICAgIG5hbWVzID0gZGV2bV9rYXNwcmludGZfc3RyYXJy
YXkoZGV2LCAicGlvIiwgY2hpcC0+bmdwaW8pOw0KPiAgICAgICAgIGlmICghbmFtZXMpIHsNCj4g
ICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+ICAgICAgICAgICAgICAgICBnb3RvIGNs
a19lbmFibGVfZXJyOw0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgZm9yIChpID0gMDsgaSA8
IGNoaXAtPm5ncGlvOyBpKyspDQo+IC0gICAgICAgICAgICAgICBuYW1lc1tpXSA9IGRldm1fa2Fz
cHJpbnRmKCZwZGV2LT5kZXYsIEdGUF9LRVJORUwsICJwaW8lYyVkIiwgYWxpYXNfaWR4ICsgJ0En
LCBpKTsNCj4gKyAgICAgICAgICAgICAgIHN0cnJlcGxhY2UobmFtZXNbaV0sICctJywgYWxpYXNf
aWR4ICsgJ0EnKTsNCj4gDQo+ICAgICAgICAgY2hpcC0+bmFtZXMgPSAoY29uc3QgY2hhciAqY29u
c3QgKiluYW1lczsNCj4gDQo+IC0tDQo+IDIuMzkuMQ0KPiANCg0K
