Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5E65772A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiL1Neb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiL1Ne2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:34:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F4AF5B9;
        Wed, 28 Dec 2022 05:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672234467; x=1703770467;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NJVHZCXe0yagOIM2MEPQPtUNUeq7CHFTwp3ZcCtUXuk=;
  b=lKmWTFZKqplrCqBG3iEP6w7o+37oHg8WS0GS17q/1lSf5sP8WfZx7XGz
   sAgFQnuTgt7QA7fiT+x5AQ77ub2Q/mSmChd7twT2vsi1448T6GUpWuOwQ
   nXJsT7r9slQLSJoYZdBGGIHT6bk1ot0cN1C+R5kREWchzh/d/L1TWaR0o
   BzhlRiVRzO3Ym/thfW7WrEK4G9DgFDyNJ99Hz4rcOLGxUx6WuHkKin50X
   57FCGXGfochycz07e0bSfW+KM0DnIUCE4GbIcrhl8yL5Bo8gj0VKyOuso
   8uMUtysXAVAvpi4EK24bVLLIMnJvnr8QFJYYzdnL5JXItc236sAnNB+pe
   A==;
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="193482698"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Dec 2022 06:34:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 06:34:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 28 Dec 2022 06:34:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8VQ958jR98WZ62WCdzwseHFQhiMUPu1ku7AYDBcy8T4XatT5zzZ0/DVvI9nJWcR5gfDC/6VomUr+9aWHVVMVTvmS+b2YWhrP+J4pvFqEXHki+PNm8V3ehnPu2Lkh2i0h976y+aCOxLQBlKxeLkS6NgI//uGPjTINp3JSY6sJK1Tq0sNTp9eaUmtjQP6DgVK+FSn3jf8VL/fleZHEIWJVZY5RijFxyU4CSsW+yxN4eItzOZUO+ggG6/NnXE2E1OIXJ0kpEc+JczvFZf9at4jQSuRrLy+WI5CdjqzPr5VSi5vWKTTL8cyJ6CikKQLhE/w1jfHzYJy7ZSisKWELqn8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJVHZCXe0yagOIM2MEPQPtUNUeq7CHFTwp3ZcCtUXuk=;
 b=ZybPg0HIQ+ErzwKvkWtXLjdQSszaoZrqzjMsEiZKGrcjyjHKgIm48FjVbqiBUu1AHuiy1Hf8yAXiDeG2kuUVeD+L3bl7o/vOTVJy/JhVuKuUoSqgmI5QYNqsc/272z80hV7fhDxnV+IVZm9ky/oKaj0ZaB5W5nENjOKIvPpKAMJvzwIpx1mZmV+przPBTtsxwh7kfCTdaYkcGQGLNszN+Mze6lBycK0W4oQm4+LCdFD4dYMn3QW59qMVfipR5DWp7frjc3FEwRcjyHupt1W/YIpWcWEUjS96ohLtLNTOTm7pijKPyuhUF+2HMQTcRQT3MyFzHhBWqJxWMpt5xoczuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJVHZCXe0yagOIM2MEPQPtUNUeq7CHFTwp3ZcCtUXuk=;
 b=O2xUas4nxHyc8ITAzDOFvUygW1kkb3L4HkAbS5p1OWjecoL/HJgeO4rEhw+apVck1KBNadaqkhfzuHdqujPypwOkjWSq4pfROpPwJFhTa5uByI5XTy4Lu5yEgrfzRNjt9YmOaKb2PQc6gF5u/gwYSsZGhaI5AW/csNqeKJYkz/Y=
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by IA0PR11MB7284.namprd11.prod.outlook.com (2603:10b6:208:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 28 Dec
 2022 13:34:15 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::19c4:9f66:4615:2691]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::19c4:9f66:4615:2691%6]) with mapi id 15.20.5944.018; Wed, 28 Dec 2022
 13:34:15 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <Balamanikandan.Gunasundar@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        <Hari.PrasathGE@microchip.com>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
Thread-Topic: [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
Thread-Index: AQHZGP1DsXto4h2lr0yhHFRIlVN3ZK6DUC2A
Date:   Wed, 28 Dec 2022 13:34:15 +0000
Message-ID: <96b15c2f-8726-516a-b609-f15a52877b4d@microchip.com>
References: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
 <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com>
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
x-ms-office365-filtering-correlation-id: 8cd508de-4f5e-43ff-a976-08dae8d836d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJ3n+joVhuj7z1dGHF1j6E6ItD1O1iCd1QxeZABwjIzcEwbDQ9LBGFAdU2ZrtGOgZ1vVwMvXfneMIjvaKYhfT/yox9oYQCJBci06GDFx5UVeaye0tonCQttAvlpukxk54Borg8mdLKwISoZpYK5tSY9dRoV/0KueoNWAQC5vKvlj5ZxkRT3SX3+uUB5q5AoVZravsAGDypCy6P3X9Kzut58mpqgXTj+GjjE3gr0VlpG7aCgYOSHGoiKdGuvrhQdJ1GfYLJlLKFrxPJYD2tKJBhRXLUQy/uXllhkUgteE+tNDu7xGQpcLen/jecVW03+nPLRfSJt7NHBIpMXKQqy4HWocZOnl+aV+9XJBNftjs8oLp0SXLxw6d+qefqwlegrHos9LP6WJxcAZUR8ngNOtAIHJq8sSVo+LoGkHr0yO8YLtgrWrOHUD16AxO1D9aJ19ov0vPyMdIWmLpw7DRSafjEYf/Zi+vg6QbV8EoOGnGy1LQzKCbJ53g7aN/PeNxZqNxGPkJa5uGbqaXXs5p1wg8pmDp6FeFhkw9+iQgFiFTUIRItqnonfUi4gY26AZtKyN18BtJaBramvOR6eW1VPZ+JOc7XzN5kOhokm6SgbIcOieHlqhBT/BDUWOUMCkbim8NJa69ucAyGda7JmjLLcqLQnocNeVmFhUpnrcyWfH5zX4vO4Hawctk0yHrFdVyBy+rvIaINEzZ0eUdruTXY4M33WiXDCYVurpUkFjkHDc0IReRPzicahGwERwJZFtc3ECEVeb02DufEbP+B1rtdNN9kp5q6L2J/cmb2rrnkfAi+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(38070700005)(316002)(122000001)(83380400001)(76116006)(66446008)(66476007)(86362001)(64756008)(66556008)(6486002)(5660300002)(66946007)(31696002)(8676002)(26005)(41300700001)(8936002)(6512007)(186003)(53546011)(110136005)(6506007)(2616005)(478600001)(71200400001)(38100700002)(2906002)(91956017)(921005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUljNUd6WVlwMUduQ0VBMWMwdTZaaUYwUlAzY09ISU1FejJUR2RDZ3h2R3RD?=
 =?utf-8?B?KzYxSUlVbUdrUW10T2xWd1B5V0lIWkdsalVPLzEwZWVRU2h1cGhaV3I0cGh1?=
 =?utf-8?B?RG01bFNIZWZUVTVHc0YwcGNnVTJEamtkMHBLTG1zaGNCdVZqcjZ5emdoaFA2?=
 =?utf-8?B?Z1pNQ3hLdFdTbVplSGNLRzIzOWYyQjcvQnYzeFRXMnM0RGxremh1YXFadmVH?=
 =?utf-8?B?a1g5c2c5dkxveXNjajFUVTFjRTRUUHl5NStjZGRaNUx0VGczZ0VHcFppZGFL?=
 =?utf-8?B?UkJ1QjNFZ2ZDSkVIWDhWb3dZemtXV2l3NytBd0dqNDNRNVZJV1J5bjdTSnFa?=
 =?utf-8?B?NVBIRzFJMzFpWEVWTk9rMklKckkrWmZyR0Z6ZnlnajRtWnY2VmRYRDdJZmNl?=
 =?utf-8?B?WVhzNVF2ZXMzeHdjUUdOYzVOVVg0eTM4RGxMQ1VOSTlxQ09HOU54OEFralZY?=
 =?utf-8?B?Z0pUVFBlVDJTcERTYXI1WmZzZ0Z3V3IwR3k2aGlBNnQvSXFvZjNGc3MzLzlJ?=
 =?utf-8?B?QjhITHRSdUkxZE5mOVBybjN0WTVuUjl6c1JuM3Jib3FZSGpVKzVLU2VzWVhp?=
 =?utf-8?B?QWhiL1NzdDNqOU5TSGhZbHNBd3BVNFcxdEJoY3ZucEtsNjErRlBKOVdIOWtX?=
 =?utf-8?B?Szl6RWorbS9DblhCT2NUV1l6czJjMFM4YXl6bkRhZjVVQ01NYkovYjEwNitQ?=
 =?utf-8?B?cXFoVVRQdGRHU3IydUhrd1hLUGJVNUlyQy90ZndkNHRFMGYxVUE0Sy9CcWRF?=
 =?utf-8?B?czA4QUtpWllSd0FHc3gzZm9hWnZ1a3V1RWZtVlVrZ0pubzJkTW5VN1ZsREJh?=
 =?utf-8?B?SE1rWUNHNTF4RzUxMU5KakZxTS9ETXVMUUVWTGNkMzkyMmh3am8wbElkbUJ3?=
 =?utf-8?B?QU50aGpoMGYxczNMNE1rd1hVZEdBblRkUVMwdUZOK2F6RU1XemRoL3ZrOU5m?=
 =?utf-8?B?ZmtZdGlQYmtQT3FKQVB0TXVrQWpQR09vNklsdnVIT0NiOUxURExZcW9pOVdB?=
 =?utf-8?B?Sk01RTNyR2tENVE5NjVOclVuVk1BL2YvV0hHeFV6QnlrU0pkNEplKzlGSitv?=
 =?utf-8?B?NkhlS3BRSEhPNGdzaUcwMk1GMll2Z1FqaVhKUGJleUI0azAxU21YR3NPWW5x?=
 =?utf-8?B?T0tZdkt1UWh2cDNDK0FGTm9VTEM2aVloQnpQSzRMdlBPMWNFeEllKzhDV0p2?=
 =?utf-8?B?WjZVc2VTQndFREh2QzhCdEFtR0tBS1I1d3BZM2luVUFOUTQ2ZnNCRTQrSytE?=
 =?utf-8?B?TU1lVDhJV3VnOVZOdS9XNGVreWtuMVNaZUVDaXRLaENhclZhbXQ4YjRNTWpH?=
 =?utf-8?B?dXF6OUwvTU83OS9xNDU4Q01YTVBWekkrRDhyekRSaFMwRWwwV0ZXem03aDBL?=
 =?utf-8?B?WGxwWXZ5ODVxbi83VkYvZFA3ZWVtdzZBbjY5ZHFaK1VNY25BdWlNYjUwa0Np?=
 =?utf-8?B?b3MzYzlWL3lLSW40a3ZwNmo5dUJ1b3l2bEdJSVhQdjV5cm5MbFEwNUIzSDJQ?=
 =?utf-8?B?QzFhNEF5YWFhTzI0UC9YUVJzRWVuZVA5RjBaaHRPNUtQMDlSK1hWbGxoR2tt?=
 =?utf-8?B?dEdLUG1LNjdQaHBHc3drWkhLRlZRMzBJK2g4TTFldllxeGowZTVBbEhQMDVF?=
 =?utf-8?B?MHpQZXpxRkR0Lys1bmtWY3ZSc3BzYkRZZ29VeDZESWRrR3lZS0pMQmpyUGg4?=
 =?utf-8?B?ZDhFN1BBNDhOalVLSHB6bVVMWW5XcFQxRVdtYVMzTWJWamFYbGdIMFR0cm14?=
 =?utf-8?B?Ri84THE0Q3dmUkJHTWdOYktpTlRCcmtjVkRhbE14ZEtFaXEwR3FWck5tN1RY?=
 =?utf-8?B?dy9VVTlpcWVmZnE1YTM0QkZIWmxCVWt0cmxSUGgxemc3MkFmQXMycHNwVkZT?=
 =?utf-8?B?ZkVGMlNDdHRJVkFIUFI4VDJ3QW9iWWNWbHJ5TjViMlA3ZkFyTVJJeXVwdy9n?=
 =?utf-8?B?M3Qya2J0UnBZdG9SYmJrSG1MUXBlQ2crd0hqbjFOTCtjeEN1VkhFQlhkNHV3?=
 =?utf-8?B?bmEwS254djhyQzFPWitqamFVV1dwSC9IT01Md3NUSGsrWjBLZVFkbXhiSG5p?=
 =?utf-8?B?ZWsxbGhlNHlBb0IyR1BYQ1F3SGRXTzUxR3FhR2lCTlE3U2JnMkc0OG1XYmc4?=
 =?utf-8?B?YXY1cmlCdHQra092UjhoL1JMeldUS25LMHFDd0MvbGovR1ltNkxMZXN6cnVw?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6748351402ADD14B87582D339D2EC621@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd508de-4f5e-43ff-a976-08dae8d836d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 13:34:15.6323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkuiWqoN5XdSB+KYAYlkKUzGl/t+yhnGIpR9c2WhioUm6QsPNBbbOrJtpa8cF6syi0JqyF9Qecw0NfTzb8PHtS/AU8VSoq4pyCyTuoqzD70=
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
UmVwbGFjZSB0aGUgbGVnYWN5IEdQSU8gQVBJcyB3aXRoIGdwaW8gZGVzY3JpcHRvciBjb25zdW1l
ciBpbnRlcmZhY2UuDQo+IA0KPiBUbyBtYWludGFpbiBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LCB3
ZSByZWx5IG9uIHRoZSAiY2QtaW52ZXJ0ZWQiDQo+IHByb3BlcnR5IHRvIG1hbmFnZSB0aGUgaW52
ZXJ0aW9uIGZsYWcgaW5zdGVhZCBvZiBHUElPIHByb3BlcnR5Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQmFsYW1hbmlrYW5kYW4gR3VuYXN1bmRhciA8YmFsYW1hbmlrYW5kYW4uZ3VuYXN1bmRhckBt
aWNyb2NoaXAuY29tPg0KUmV2aWV3ZWQtYnk6IEx1ZG92aWMgRGVzcm9jaGVzIDxsdWRvdmljLmRl
c3JvY2hlc0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbW1jL2hvc3QvYXRt
ZWwtbWNpLmMgfCA3OCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBp
bmNsdWRlL2xpbnV4L2F0bWVsLW1jaS5oICAgIHwgIDQgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDM5IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2hvc3QvYXRtZWwtbWNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L2F0bWVsLW1jaS5j
DQo+IGluZGV4IDY3YjJjZDE2NmU1Ni4uNmFiNDM3MzNiYTlmIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL21tYy9ob3N0L2F0bWVsLW1jaS5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvYXRtZWwt
bWNpLmMNCj4gQEAgLTExLDcgKzExLDYgQEANCj4gICAjaW5jbHVkZSA8bGludXgvZG1hZW5naW5l
Lmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+ICAgI2luY2x1ZGUgPGxp
bnV4L2Vyci5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L2dwaW8uaD4NCj4gICAjaW5jbHVkZSA8bGlu
dXgvaW5pdC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gICAjaW5jbHVk
ZSA8bGludXgvaW8uaD4NCj4gQEAgLTE5LDcgKzE4LDggQEANCj4gICAjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L29mX2RldmljZS5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L29mX2dwaW8uaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9pcnEuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+DQo+ICAg
I2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9z
Y2F0dGVybGlzdC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9zZXFfZmlsZS5oPg0KPiBAQCAtMzg5
LDggKzM4OSw4IEBAIHN0cnVjdCBhdG1lbF9tY2lfc2xvdCB7DQo+ICAgI2RlZmluZSBBVE1DSV9D
QVJEX05FRURfSU5JVAkxDQo+ICAgI2RlZmluZSBBVE1DSV9TSFVURE9XTgkJMg0KPiAgIA0KPiAt
CWludAkJCWRldGVjdF9waW47DQo+IC0JaW50CQkJd3BfcGluOw0KPiArCXN0cnVjdCBncGlvX2Rl
c2MgICAgICAgICpkZXRlY3RfcGluOw0KPiArCXN0cnVjdCBncGlvX2Rlc2MJKndwX3BpbjsNCj4g
ICAJYm9vbAkJCWRldGVjdF9pc19hY3RpdmVfaGlnaDsNCj4gICANCj4gICAJc3RydWN0IHRpbWVy
X2xpc3QJZGV0ZWN0X3RpbWVyOw0KPiBAQCAtNjM4LDcgKzYzOCwxMCBAQCBhdG1jaV9vZl9pbml0
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgCQkJcGRhdGEtPnNsb3Rbc2xvdF9p
ZF0uYnVzX3dpZHRoID0gMTsNCj4gICANCj4gICAJCXBkYXRhLT5zbG90W3Nsb3RfaWRdLmRldGVj
dF9waW4gPQ0KPiAtCQkJb2ZfZ2V0X25hbWVkX2dwaW8oY25wLCAiY2QtZ3Bpb3MiLCAwKTsNCj4g
KwkJCWRldm1fZndub2RlX2dwaW9kX2dldCgmcGRldi0+ZGV2LCBvZl9md25vZGVfaGFuZGxlKGNu
cCksDQo+ICsJCQkJCSAgICAgICJjZCIsIEdQSU9EX0lOLCAiY2QtZ3Bpb3MiKTsNCj4gKwkJaWYg
KElTX0VSUihwZGF0YS0+c2xvdFtzbG90X2lkXS5kZXRlY3RfcGluKSkNCj4gKwkJCXBkYXRhLT5z
bG90W3Nsb3RfaWRdLmRldGVjdF9waW4gPSBOVUxMOw0KPiAgIA0KPiAgIAkJcGRhdGEtPnNsb3Rb
c2xvdF9pZF0uZGV0ZWN0X2lzX2FjdGl2ZV9oaWdoID0NCj4gICAJCQlvZl9wcm9wZXJ0eV9yZWFk
X2Jvb2woY25wLCAiY2QtaW52ZXJ0ZWQiKTsNCj4gQEAgLTY0Nyw3ICs2NTAsMTAgQEAgYXRtY2lf
b2ZfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAkJCW9mX3Byb3BlcnR5
X3JlYWRfYm9vbChjbnAsICJub24tcmVtb3ZhYmxlIik7DQo+ICAgDQo+ICAgCQlwZGF0YS0+c2xv
dFtzbG90X2lkXS53cF9waW4gPQ0KPiAtCQkJb2ZfZ2V0X25hbWVkX2dwaW8oY25wLCAid3AtZ3Bp
b3MiLCAwKTsNCj4gKwkJCWRldm1fZndub2RlX2dwaW9kX2dldCgmcGRldi0+ZGV2LCBvZl9md25v
ZGVfaGFuZGxlKGNucCksDQo+ICsJCQkJCSAgICAgICJ3cCIsIEdQSU9EX0lOLCAid3AtZ3Bpb3Mi
KTsNCj4gKwkJaWYgKElTX0VSUihwZGF0YS0+c2xvdFtzbG90X2lkXS53cF9waW4pKQ0KPiArCQkJ
cGRhdGEtPnNsb3Rbc2xvdF9pZF0ud3BfcGluID0gTlVMTDsNCj4gICAJfQ0KPiAgIA0KPiAgIAly
ZXR1cm4gcGRhdGE7DQo+IEBAIC0xNTExLDggKzE1MTcsOCBAQCBzdGF0aWMgaW50IGF0bWNpX2dl
dF9ybyhzdHJ1Y3QgbW1jX2hvc3QgKm1tYykNCj4gICAJaW50CQkJcmVhZF9vbmx5ID0gLUVOT1NZ
UzsNCj4gICAJc3RydWN0IGF0bWVsX21jaV9zbG90CSpzbG90ID0gbW1jX3ByaXYobW1jKTsNCj4g
ICANCj4gLQlpZiAoZ3Bpb19pc192YWxpZChzbG90LT53cF9waW4pKSB7DQo+IC0JCXJlYWRfb25s
eSA9IGdwaW9fZ2V0X3ZhbHVlKHNsb3QtPndwX3Bpbik7DQo+ICsJaWYgKHNsb3QtPndwX3Bpbikg
ew0KPiArCQlyZWFkX29ubHkgPSBncGlvZF9nZXRfdmFsdWUoc2xvdC0+d3BfcGluKTsNCj4gICAJ
CWRldl9kYmcoJm1tYy0+Y2xhc3NfZGV2LCAiY2FyZCBpcyAlc1xuIiwNCj4gICAJCQkJcmVhZF9v
bmx5ID8gInJlYWQtb25seSIgOiAicmVhZC13cml0ZSIpOw0KPiAgIAl9DQo+IEBAIC0xNTI1LDgg
KzE1MzEsOCBAQCBzdGF0aWMgaW50IGF0bWNpX2dldF9jZChzdHJ1Y3QgbW1jX2hvc3QgKm1tYykN
Cj4gICAJaW50CQkJcHJlc2VudCA9IC1FTk9TWVM7DQo+ICAgCXN0cnVjdCBhdG1lbF9tY2lfc2xv
dAkqc2xvdCA9IG1tY19wcml2KG1tYyk7DQo+ICAgDQo+IC0JaWYgKGdwaW9faXNfdmFsaWQoc2xv
dC0+ZGV0ZWN0X3BpbikpIHsNCj4gLQkJcHJlc2VudCA9ICEoZ3Bpb19nZXRfdmFsdWUoc2xvdC0+
ZGV0ZWN0X3BpbikgXg0KPiArCWlmIChzbG90LT5kZXRlY3RfcGluKSB7DQo+ICsJCXByZXNlbnQg
PSAhKGdwaW9kX2dldF9yYXdfdmFsdWUoc2xvdC0+ZGV0ZWN0X3BpbikgXg0KPiAgIAkJCSAgICBz
bG90LT5kZXRlY3RfaXNfYWN0aXZlX2hpZ2gpOw0KPiAgIAkJZGV2X2RiZygmbW1jLT5jbGFzc19k
ZXYsICJjYXJkIGlzICVzcHJlc2VudFxuIiwNCj4gICAJCQkJcHJlc2VudCA/ICIiIDogIm5vdCAi
KTsNCj4gQEAgLTE2MzksOCArMTY0NSw4IEBAIHN0YXRpYyB2b2lkIGF0bWNpX2RldGVjdF9jaGFu
Z2Uoc3RydWN0IHRpbWVyX2xpc3QgKnQpDQo+ICAgCWlmICh0ZXN0X2JpdChBVE1DSV9TSFVURE9X
TiwgJnNsb3QtPmZsYWdzKSkNCj4gICAJCXJldHVybjsNCj4gICANCj4gLQllbmFibGVfaXJxKGdw
aW9fdG9faXJxKHNsb3QtPmRldGVjdF9waW4pKTsNCj4gLQlwcmVzZW50ID0gIShncGlvX2dldF92
YWx1ZShzbG90LT5kZXRlY3RfcGluKSBeDQo+ICsJZW5hYmxlX2lycShncGlvZF90b19pcnEoc2xv
dC0+ZGV0ZWN0X3BpbikpOw0KPiArCXByZXNlbnQgPSAhKGdwaW9kX2dldF9yYXdfdmFsdWUoc2xv
dC0+ZGV0ZWN0X3BpbikgXg0KPiAgIAkJICAgIHNsb3QtPmRldGVjdF9pc19hY3RpdmVfaGlnaCk7
DQo+ICAgCXByZXNlbnRfb2xkID0gdGVzdF9iaXQoQVRNQ0lfQ0FSRF9QUkVTRU5ULCAmc2xvdC0+
ZmxhZ3MpOw0KPiAgIA0KPiBAQCAtMjI0MSw5ICsyMjQ3LDkgQEAgc3RhdGljIGludCBhdG1jaV9p
bml0X3Nsb3Qoc3RydWN0IGF0bWVsX21jaSAqaG9zdCwNCj4gICAJZGV2X2RiZygmbW1jLT5jbGFz
c19kZXYsDQo+ICAgCSAgICAgICAgInNsb3RbJXVdOiBidXNfd2lkdGg9JXUsIGRldGVjdF9waW49
JWQsICINCj4gICAJCSJkZXRlY3RfaXNfYWN0aXZlX2hpZ2g9JXMsIHdwX3Bpbj0lZFxuIiwNCj4g
LQkJaWQsIHNsb3RfZGF0YS0+YnVzX3dpZHRoLCBzbG90X2RhdGEtPmRldGVjdF9waW4sDQo+ICsJ
CWlkLCBzbG90X2RhdGEtPmJ1c193aWR0aCwgZGVzY190b19ncGlvKHNsb3RfZGF0YS0+ZGV0ZWN0
X3BpbiksDQo+ICAgCQlzbG90X2RhdGEtPmRldGVjdF9pc19hY3RpdmVfaGlnaCA/ICJ0cnVlIiA6
ICJmYWxzZSIsDQo+IC0JCXNsb3RfZGF0YS0+d3BfcGluKTsNCj4gKwkJZGVzY190b19ncGlvKHNs
b3RfZGF0YS0+d3BfcGluKSk7DQo+ICAgDQo+ICAgCW1tYy0+b3BzID0gJmF0bWNpX29wczsNCj4g
ICAJbW1jLT5mX21pbiA9IERJVl9ST1VORF9VUChob3N0LT5idXNfaHosIDUxMik7DQo+IEBAIC0y
Mjc5LDUxICsyMjg1LDQzIEBAIHN0YXRpYyBpbnQgYXRtY2lfaW5pdF9zbG90KHN0cnVjdCBhdG1l
bF9tY2kgKmhvc3QsDQo+ICAgDQo+ICAgCS8qIEFzc3VtZSBjYXJkIGlzIHByZXNlbnQgaW5pdGlh
bGx5ICovDQo+ICAgCXNldF9iaXQoQVRNQ0lfQ0FSRF9QUkVTRU5ULCAmc2xvdC0+ZmxhZ3MpOw0K
PiAtCWlmIChncGlvX2lzX3ZhbGlkKHNsb3QtPmRldGVjdF9waW4pKSB7DQo+IC0JCWlmIChkZXZt
X2dwaW9fcmVxdWVzdCgmaG9zdC0+cGRldi0+ZGV2LCBzbG90LT5kZXRlY3RfcGluLA0KPiAtCQkJ
CSAgICAgICJtbWNfZGV0ZWN0IikpIHsNCj4gLQkJCWRldl9kYmcoJm1tYy0+Y2xhc3NfZGV2LCAi
bm8gZGV0ZWN0IHBpbiBhdmFpbGFibGVcbiIpOw0KPiAtCQkJc2xvdC0+ZGV0ZWN0X3BpbiA9IC1F
QlVTWTsNCj4gLQkJfSBlbHNlIGlmIChncGlvX2dldF92YWx1ZShzbG90LT5kZXRlY3RfcGluKSBe
DQo+IC0JCQkJc2xvdC0+ZGV0ZWN0X2lzX2FjdGl2ZV9oaWdoKSB7DQo+ICsJaWYgKHNsb3QtPmRl
dGVjdF9waW4pIHsNCj4gKwkJaWYgKGdwaW9kX2dldF9yYXdfdmFsdWUoc2xvdC0+ZGV0ZWN0X3Bp
bikgXg0KPiArCQkgICAgc2xvdC0+ZGV0ZWN0X2lzX2FjdGl2ZV9oaWdoKSB7DQo+ICAgCQkJY2xl
YXJfYml0KEFUTUNJX0NBUkRfUFJFU0VOVCwgJnNsb3QtPmZsYWdzKTsNCj4gICAJCX0NCj4gKwl9
IGVsc2Ugew0KPiArCQlkZXZfZGJnKCZtbWMtPmNsYXNzX2RldiwgIm5vIGRldGVjdCBwaW4gYXZh
aWxhYmxlXG4iKTsNCj4gICAJfQ0KPiAgIA0KPiAtCWlmICghZ3Bpb19pc192YWxpZChzbG90LT5k
ZXRlY3RfcGluKSkgew0KPiArCWlmICghc2xvdC0+ZGV0ZWN0X3Bpbikgew0KPiAgIAkJaWYgKHNs
b3RfZGF0YS0+bm9uX3JlbW92YWJsZSkNCj4gICAJCQltbWMtPmNhcHMgfD0gTU1DX0NBUF9OT05S
RU1PVkFCTEU7DQo+ICAgCQllbHNlDQo+ICAgCQkJbW1jLT5jYXBzIHw9IE1NQ19DQVBfTkVFRFNf
UE9MTDsNCj4gICAJfQ0KPiAgIA0KPiAtCWlmIChncGlvX2lzX3ZhbGlkKHNsb3QtPndwX3Bpbikp
IHsNCj4gLQkJaWYgKGRldm1fZ3Bpb19yZXF1ZXN0KCZob3N0LT5wZGV2LT5kZXYsIHNsb3QtPndw
X3BpbiwNCj4gLQkJCQkgICAgICAibW1jX3dwIikpIHsNCj4gLQkJCWRldl9kYmcoJm1tYy0+Y2xh
c3NfZGV2LCAibm8gV1AgcGluIGF2YWlsYWJsZVxuIik7DQo+IC0JCQlzbG90LT53cF9waW4gPSAt
RUJVU1k7DQo+IC0JCX0NCj4gLQl9DQo+ICsJaWYgKCFzbG90LT53cF9waW4pDQo+ICsJCWRldl9k
YmcoJm1tYy0+Y2xhc3NfZGV2LCAibm8gV1AgcGluIGF2YWlsYWJsZVxuIik7DQo+ICAgDQo+ICAg
CWhvc3QtPnNsb3RbaWRdID0gc2xvdDsNCj4gICAJbW1jX3JlZ3VsYXRvcl9nZXRfc3VwcGx5KG1t
Yyk7DQo+IC0JbW1jX3B3cnNlcV9hbGxvYyhzbG90LT5tbWMpOw0KPiAgIAltbWNfYWRkX2hvc3Qo
bW1jKTsNCj4gICANCj4gLQlpZiAoZ3Bpb19pc192YWxpZChzbG90LT5kZXRlY3RfcGluKSkgew0K
PiArCWlmIChzbG90LT5kZXRlY3RfcGluKSB7DQo+ICAgCQlpbnQgcmV0Ow0KPiAgIA0KPiAgIAkJ
dGltZXJfc2V0dXAoJnNsb3QtPmRldGVjdF90aW1lciwgYXRtY2lfZGV0ZWN0X2NoYW5nZSwgMCk7
DQo+ICAgDQo+IC0JCXJldCA9IHJlcXVlc3RfaXJxKGdwaW9fdG9faXJxKHNsb3QtPmRldGVjdF9w
aW4pLA0KPiAtCQkJCWF0bWNpX2RldGVjdF9pbnRlcnJ1cHQsDQo+IC0JCQkJSVJRRl9UUklHR0VS
X0ZBTExJTkcgfCBJUlFGX1RSSUdHRVJfUklTSU5HLA0KPiAtCQkJCSJtbWMtZGV0ZWN0Iiwgc2xv
dCk7DQo+ICsJCXJldCA9IHJlcXVlc3RfaXJxKGdwaW9kX3RvX2lycShzbG90LT5kZXRlY3RfcGlu
KSwNCj4gKwkJCQkgIGF0bWNpX2RldGVjdF9pbnRlcnJ1cHQsDQo+ICsJCQkJICBJUlFGX1RSSUdH
RVJfRkFMTElORyB8IElSUUZfVFJJR0dFUl9SSVNJTkcsDQo+ICsJCQkJICAibW1jLWRldGVjdCIs
IHNsb3QpOw0KPiAgIAkJaWYgKHJldCkgew0KPiAgIAkJCWRldl9kYmcoJm1tYy0+Y2xhc3NfZGV2
LA0KPiAgIAkJCQkiY291bGQgbm90IHJlcXVlc3QgSVJRICVkIGZvciBkZXRlY3QgcGluXG4iLA0K
PiAtCQkJCWdwaW9fdG9faXJxKHNsb3QtPmRldGVjdF9waW4pKTsNCj4gLQkJCXNsb3QtPmRldGVj
dF9waW4gPSAtRUJVU1k7DQo+ICsJCQkJZ3Bpb2RfdG9faXJxKHNsb3QtPmRldGVjdF9waW4pKTsN
Cj4gKwkJCXNsb3QtPmRldGVjdF9waW4gPSBOVUxMOw0KPiAgIAkJfQ0KPiAgIAl9DQo+ICAgDQo+
IEBAIC0yMzQyLDEwICsyMzQwLDggQEAgc3RhdGljIHZvaWQgYXRtY2lfY2xlYW51cF9zbG90KHN0
cnVjdCBhdG1lbF9tY2lfc2xvdCAqc2xvdCwNCj4gICANCj4gICAJbW1jX3JlbW92ZV9ob3N0KHNs
b3QtPm1tYyk7DQo+ICAgDQo+IC0JaWYgKGdwaW9faXNfdmFsaWQoc2xvdC0+ZGV0ZWN0X3Bpbikp
IHsNCj4gLQkJaW50IHBpbiA9IHNsb3QtPmRldGVjdF9waW47DQo+IC0NCj4gLQkJZnJlZV9pcnEo
Z3Bpb190b19pcnEocGluKSwgc2xvdCk7DQo+ICsJaWYgKHNsb3QtPmRldGVjdF9waW4pIHsNCj4g
KwkJZnJlZV9pcnEoZ3Bpb2RfdG9faXJxKHNsb3QtPmRldGVjdF9waW4pLCBzbG90KTsNCj4gICAJ
CWRlbF90aW1lcl9zeW5jKCZzbG90LT5kZXRlY3RfdGltZXIpOw0KPiAgIAl9DQo+ICAgDQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2F0bWVsLW1jaS5oIGIvaW5jbHVkZS9saW51eC9hdG1l
bC1tY2kuaA0KPiBpbmRleCAxNDkxYWYzOGNjNmUuLjAxN2U3ZDhmNjEyNiAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9hdG1lbC1tY2kuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2F0bWVs
LW1jaS5oDQo+IEBAIC0yNiw4ICsyNiw4IEBADQo+ICAgICovDQo+ICAgc3RydWN0IG1jaV9zbG90
X3BkYXRhIHsNCj4gICAJdW5zaWduZWQgaW50CQlidXNfd2lkdGg7DQo+IC0JaW50CQkJZGV0ZWN0
X3BpbjsNCj4gLQlpbnQJCQl3cF9waW47DQo+ICsJc3RydWN0IGdwaW9fZGVzYyAgICAgICAgKmRl
dGVjdF9waW47DQo+ICsJc3RydWN0IGdwaW9fZGVzYwkqd3BfcGluOw0KPiAgIAlib29sCQkJZGV0
ZWN0X2lzX2FjdGl2ZV9oaWdoOw0KPiAgIAlib29sCQkJbm9uX3JlbW92YWJsZTsNCj4gICB9Ow0K
DQo=
