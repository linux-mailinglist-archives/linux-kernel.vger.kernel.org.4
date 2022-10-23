Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882AE609756
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 01:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJWXiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 19:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJWXiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:38:50 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2066.outbound.protection.outlook.com [40.107.114.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B063376
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZW2cAjLr1hGYRcwV05znZH0nNZ2hhJ3g9BvZoI1HNpN67TRoYYJznrVOAJCVf+TTo7a24W/HX3ghK9I8BVvD508GTj8Y5VgupoO3wwNZYhXvJC9EQ5jBwQjqx2je6Q26SUUZYJJY8e4BAKizCc+3+jWgNfxBCfxORkK6g0/xaQJ1whfCA036eOjmec1kJfAY4CJnBw9ouqdayCCRLzlVLQjiZbKRI1mcIjiLmYOQ1ezlZP0C1KS+J1kHMDkOp5+NZ7sZ2VFUXheIbyLCY5divWXsFZ6LTw+42yjfjGjmgDNBhbNJyC3xuBlpNN6Am6Foq+FLTmZvi/K+qankzILSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc8I2XW0QSrLjnQ6PAZLoTo2MAywKhu3Ohy/MVYIy0g=;
 b=EYUjXz9V8lc02C+C6nTcbYJ+luBj9Lx52mn9C71Cz5WDHrDzKloaEDrehiDkllJMcfizRzO4HqfhqcyQTVSL68R1XLUr13MueRbH9eru+1tejl5yv9DnjqID29cikVVAgvMi2rbsIToYGDFFHOlIiHlrLDX7NxNVsyGbbZeUGZgV2KazuoxD9YuMhpfnBaxSNWc01hlEKZ270t2htZ1p9AJjTWijcEZiJPUvHlMU86naYguYu/v8VhUwJ7TbF43icybJr1f42NOU08bYZYG7xO7cyy91soNFTNb1dS0X3oaDj91DScL316iiJqCWyU2k8cfg8RY9sh8Qw35HU6B9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc8I2XW0QSrLjnQ6PAZLoTo2MAywKhu3Ohy/MVYIy0g=;
 b=cZaKONpuglSf+7e5i3LnV2E2bXfXBROYZCyQTw0UaO6MUvi504rRlPjHiU3H+bh2SCnL0tRKjs/OErGDdDfm8fDuaVUwF7VBmdek0UXNUoCtR5PyD5RSfBaKHyYb/VM+Esyi+xz4JXixs0NfnP/jtyqFG66+rheKkWhxQ86eD2w=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYVPR01MB10815.jpnprd01.prod.outlook.com (2603:1096:400:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Sun, 23 Oct
 2022 23:38:46 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%9]) with mapi id 15.20.5746.025; Sun, 23 Oct 2022
 23:38:45 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: memory-failure: make put_ref_page() more useful
Thread-Topic: [PATCH 1/3] mm: memory-failure: make put_ref_page() more useful
Thread-Index: AQHY5Sb7jb31bIelbk6KVs5aKklnx64cptmA
Date:   Sun, 23 Oct 2022 23:38:45 +0000
Message-ID: <20221023233839.GA4024629@hori.linux.bs1.fc.nec.co.jp>
References: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYVPR01MB10815:EE_
x-ms-office365-filtering-correlation-id: 0c31d6e2-8dd6-4d7b-4594-08dab54fba57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yyBKhDCWLtxlYPOnLrsLez+3q2Vk380NcabR1PyhPFDQ7VhvjOFnwJ6Ut+0F6S/3WGFKMHj/XGQKrn6m93t0JYbrTucFM7na0v3lK1RhUnpCYoBtcigoGLfMn+5zEwfGnmdH/jwRbIGDyeadL3gnfBTGkDhnU45ddmAMnPBG4dwDxsZvLfKsPc9jbCqES5nbfaJ+sAhjO141cG4uUhpsX2MVi28Idy6vMHIYA7t2AbRzjTxYgOstfC0ObDf0opvGK2WwuDacXceSLIdzw8zJpJmusxz7LmPZEyPtmGj37nXZF+wEBIocwtZEMiOPbrDtpS217SL9yaCfPOhSG0jTWhI25hE4KC+FDemaqoZQtT9rQxwpwLFKGfXw36ebslbwvYzZJ/gcU6ZXnyHmmJpbQhpVGst7SDQSYjHrYj0J78v2D8v3V5PC6b7KyqgO4tTHOeO7e4epCPgVpTDvfPaaJyPk/Mv5FrIx5MVoBTxml85ueMXWpg7I6CBRNVE67QAboaeyjB/FCKxUaVtdAER29lakv1ZgP41vWrdPd5LmxAn0K+edK/ZBRKt3dYmb9SQbrjs7SbRz/hVfYqyTrD5nbcAlFbMT80Lc9FzlZH4AWIvSlxz5mVgoWQhB/1UjUTctq2G+SUY1PCLCPriDWyUUNNCJmF3CgOyfd8Mv/bBZgaRAOsT5PU9ivtaAmcHExJkDgwd1jEPzE63gQTqA+yhF1Kbz773nI3j4OoHX1rCs0R1FUfh5HWZtQY5KAhaiIZFY1XJfSyf8HDUs7pBKLHurBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(85182001)(2906002)(1076003)(6916009)(54906003)(66946007)(6506007)(316002)(41300700001)(33656002)(76116006)(8936002)(66476007)(66556008)(558084003)(6486002)(8676002)(86362001)(5660300002)(4326008)(66446008)(64756008)(38070700005)(82960400001)(71200400001)(26005)(478600001)(38100700002)(122000001)(186003)(6512007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkVTaTNWNkRienRObXZYc1lPenlFeE1OMTMxNXgyMzFFVDJiTWJCUGFjVytn?=
 =?utf-8?B?Vk1DWDkxNWpVa2UzNEd0TUx6cDMzNWJ3UWo5Z09wR3BpWVJsclZ6b0haNFpw?=
 =?utf-8?B?cnZ3NFR2SW85L0FOTzNDUkp0VS9WRTRmYXo3UVdSbUJieDErbU9OSVA2TXls?=
 =?utf-8?B?RlBTVHJwcGs4SUtBMFAyV3ZUd1ZIVStxOG05UERGajZqNC9nNGpteGNuVDFp?=
 =?utf-8?B?T2ZCL244ejVFemY5SGo2Unl2NjA0c2RpQlZHNHhLTGFDTEhZNExFV0FBeWlY?=
 =?utf-8?B?eDEyK2dOL3d4SmVkY1c1RG1jcUNoM1Q3TXhGNnhBclFWTGlLVVNWTzhiQmVF?=
 =?utf-8?B?YnlUdXhJVU1HV2RBT3hOQWRCVWF6LzVsR1Jld0QyVVc2ZWJRSDF2dm9oOFdv?=
 =?utf-8?B?VmY5OG1lb0FLN1VNRWV6M2prYVB1UE5GdUUrZ3FrL1FhYzZsdzJDR3FSMCtN?=
 =?utf-8?B?MmZrTjhvR2EwZkY2anB0aHViTjgwbjVXdjhtUTN6Mk1FQ0Q0dXpWSUxqdi91?=
 =?utf-8?B?Y3RCekdpYWQ3ZFRYajJGSmN1T0crN1dTSC95YW04Y1g0ZXNpWUFudzhWWUhD?=
 =?utf-8?B?cFNHVWVRc2Z3ZlBRYXZXd1Z2UUdRS3NlK3orVTVDZlVZTTc4TTdVbU5FZHlK?=
 =?utf-8?B?VDliTVdJSElYWHZPd0R2WFlPaU9EWHZSVk5XTG1TMjdGbVVKV01Ec3lBY2pq?=
 =?utf-8?B?cmRuZ3lmS29Md1Nqc2Fuc2ltamNzQ0RjV0J0Q2k0YU9jYzRBdjZFakFsOU1r?=
 =?utf-8?B?WUVPWVl1aGgzV0YrQ0JaRzZ1UTJ5VFgyMGdlNWc0K3pLeWFKWkc4blV6MUJN?=
 =?utf-8?B?Ym5wZVk3d0tsVHVlY0VPZkFjZElrbmdFS085eVBXak1uemp5SE5mMHJqRXJ2?=
 =?utf-8?B?WEVwbVFYV3FpRGVXSmRmYTBnLzlzT0NXQkZGSXp1b1hBRDhrNCtOYzN6NFBC?=
 =?utf-8?B?N01ncCtUSUFrbmRYbkE5cW1YMTE0OGtWTlhoK1FNeU1QbXBBdndkcmhtWC9m?=
 =?utf-8?B?aitNK0s0Q3crOXRuNjZRZVhEUEdDaXBlZGloek0zUUV2TnJSVDdIeVNuNUc0?=
 =?utf-8?B?ZHZMenRHVWdEUTA3b3pVVWR0Q0FKNi93NkVzSU9RZ3NQV2FxOTBBMC9UU3Ji?=
 =?utf-8?B?cFpZblQrNkora3ViMzZMSDhlMHB3VWhlRkhqWTI3Vi9lZHpKZDc4WGlDV0pU?=
 =?utf-8?B?QzQ1WERhL3lzdWt0NG96SGxqZnAwdm10MExINzQzZ0h5QTRvUXg3T2NRTjNE?=
 =?utf-8?B?MXF1SFNLeDZWajZjTkxGcHljWFFERkF0ek1ZVUI3WlgvRWI5aFJia1I5Vkp2?=
 =?utf-8?B?ZXJDOWtlcExjdWljbmZmSzZIVjRuYkdnaEl3WW5zeUpqSHc3S01JVk1YRDg1?=
 =?utf-8?B?dHlYaDdIdmpMUUIvbFZMaTBtTXcwRjlYU2tqZWRlZis4ejlDaGYvRC9jT0Zv?=
 =?utf-8?B?aE5tRmhPU0lhdUFkTjc5ZHRCZ2VZSjViY1hoV0tsT0RyUUw0OVhJb0JZbXFG?=
 =?utf-8?B?c3VYWXVwSDZ5eWRmU1RLUGR2bXZIOVFXRnVqZk1yZGQxT29NVWZzYnhwUU5B?=
 =?utf-8?B?bmw2UzdwMTRzZ1h6bGdkdUxoVDZTNUEyZ1hyNjBXc2hyYnFkU3JJaEpPUEox?=
 =?utf-8?B?Wm1RL2VrNXFDamd5OSszdUphREgwRVFFaW53WFNENkRrMHN4TmZUWmo4aTll?=
 =?utf-8?B?dHlPNUZZRGRZSm8zMXJvS3hYMU9MeWRXNnp5c2ZVTEpRbDZWc0VsZk9HNHFZ?=
 =?utf-8?B?elo5MlhIWnU3a1RLRWZlY2VmNUQrU3VVN1p4L01SZUpxNEtsZ1NLdXpGV1NV?=
 =?utf-8?B?eHBQV0srVCtnKy9FN1MvRG15VnlpZWNtRFpia1R1U0ZJWGtuRWN3MjNUeXFl?=
 =?utf-8?B?emxqT1hTQVNvZmdIUzRHc3I1NmRlTkNLblFKaGY5bWZLaFJIMXYwR29HZkdK?=
 =?utf-8?B?c0gwQzVwQkhKNlNmcm5yUVRkbkRtOE5Md1ZyUFU2M1dUTWtxSlp1SHo0ZXVK?=
 =?utf-8?B?QnYrSWRXNzNLWnRCKzVNRHNGckJpRU0xTldSeFNFY2xFNUpMalVsRWxFYmhE?=
 =?utf-8?B?eGt3WTFCdlp5VzFxc0FOOU0rSi9pK1BDc1Z5L3ZZc251RHQyakp0OEkxQmRl?=
 =?utf-8?B?MXdaZ3ZiK2RYb3RVY2NxdlBHWTQzOGFJV2tEMVcvTWNoMExtaDBxQkMrSW1C?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4374269495B784E8099E7AF64E960F7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c31d6e2-8dd6-4d7b-4594-08dab54fba57
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 23:38:45.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwkOnchqQFlXukVReovsQcsfmGVmzWSd2qc5RkUlU/JfqWK0UY8aQHMTonJJrqiDeHAd9GfNDca3KmDgIpYJzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMjEsIDIwMjIgYXQgMDQ6NDY6MDlQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFBhc3MgcGZuL2ZsYWdzIHRvIHB1dF9yZWZfcGFnZSgpLCB0aGVuIGNoZWNrIE1GX0NP
VU5UX0lOQ1JFQVNFRA0KPiBhbmQgZHJvcCByZWZjb3VudCB0byBtYWtlIHRoZSBjb2RlIGxvb2sg
Y2xlYW5lci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5na2VmZW5nLndh
bmdAaHVhd2VpLmNvbT4NCg0KTG9va3MgZ29vZCB0byBtZSwgdGhhbmsgeW91Lg0KDQpBY2tlZC1i
eTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4=
