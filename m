Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B586F925A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjEFN7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjEFN66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:58:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2098.outbound.protection.outlook.com [40.92.98.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F824519;
        Sat,  6 May 2023 06:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9M9UPtnY5c8ndjULjERz15YIA2A6dC26huGWqEAeSn5uNDYKi+dqN8s0cXWWq/6Nv4uaoCMweM9oou/0ZBLdlwAGLoioMd/3KduRItUZTOQKDut7f0+AOBsHzKyuinODZ9PzwA9mOOCqR+hyNv3zpi9xojzF+jIg24i2mFPwHElZGpUYV0n3NOBMz7GOA4Ekw36iccjBVQsm7TRyXDAraOVmv3PpBR3xieY2oKV0/yOvWK6UTtn3ZmAihwOVZNVYPfaUGqEgO4eL/SzAdhhMUH1CaICdLJg1jICsGY1wuI6ibL5B5Sz2AAKkm26nFNzXw2CpeEv8f5O37DwpVYYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89BEjvhrZAoPSYZOXgQyALATXR0UJ8Z5fecJwTPNA1I=;
 b=Cky6XZcW+v4pYL0bb4WlyyX8Ybldx5wEWKKcn2Y7NCCRS5iqaix7IUSOMpnDHYvV3/4/UTwE2MKMf9QJrDVzwiudLvW+zEfoiVAPjacgsSVAwr90pzQ6QT+iOmX+wCXqpXnqigHvTOanZD8WYd+hhOZ1z2nFm60AGydxIfLS1eO1ftoFarclfRfPxULJPwj8r8Cq2T6ELOSEnTyZttE7oDX+ZdPW/QLnvzaa4mEmgXhUbIIOczDOCiBuiWVzqnqj0eb2uVBYrFRAfuaCh1CgI8/uaXG3HmCXamslLfX8ofdbu66h48UCQa6aA/aYvu9O3bMdKSrDZ8hEEoxM26IKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89BEjvhrZAoPSYZOXgQyALATXR0UJ8Z5fecJwTPNA1I=;
 b=UuFj/F5m7U1rzGdLhgkYNVfYdr5F1SVaKPn5WjpBjfAlrjmH0BBxg/nc+K8yZhDWFqy7kf3IgKFHF4qxzpTtp0Yow0NkyJxj8S+G+ALa/QOXn6RHTxzQCHsCS/j7Gw6r3LurVCrTsQ1UQlaHWlr5j+KWFrziJ0FCZ64K5WqBTcL5VjVW4oYQdnOYhRhfNO067doyFfMGvbOwYRM624Sp2w9U73qrbgX+0I/0AJ/2R0qW5gmpVtEcuR2zxu5ou/OI4Hc8vs2QrbBDcf3Ql1oZT/z+b2dn9ed7iQTlfPPhzXvCuGbYrHDRfHfy7eQ+guXBJQToOm+VmGcmgWKQQwkIrg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB1755.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 13:58:50 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 13:58:50 +0000
Message-ID: <TY3P286MB2611D930A36FDC4EA431D77398739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sat, 6 May 2023 21:58:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     wiagn233@outlook.com, Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RESEND v2 5/6] soc: starfive: Add JH7110 AON PMU support
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-6-changhuang.liang@starfivetech.com>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230419035646.43702-6-changhuang.liang@starfivetech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FNWH933Kx0KL5j0yqhamAFdV"
X-TMN:  [dmLQ+T4gg0DSvzM516xQ24Mv6ncBBf9H]
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <aea4cd83-05c8-8791-80e5-236b52be974c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB1755:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cdb94e-2400-43da-6e6e-08db4e3a04f5
X-MS-Exchange-SLBlob-MailProps: dx7TrgQSB6dyQk8NjdEKM5kIQ3nurzksORwKiqBMbx8Hs4PfRoUYD8xR5c82pmwHCB0XCkaM2kV+ndK7ljeKZxM6oTvF59qoJRbPWBM14rrxmM4vRiZuVbbZqAxZ1jn6iY0tCMmaP/dRmU3S2Fg5bCj3iLd/7r1uQgCZGyEJKdCYFg4wi+Jh7wjuuIDl9Z1wh90b6Yd3SGibebSTCTRE/41BADJKn1OdxnwdSzItCPJGQ39HF4jM+YcKv3V+meP/Lh5ns/ap+e0LLezbt0vdJDXW8j1Ec6UcEXoh0TA/ulOJajn/gbfkq2Z0kJzEMdj2dc3kovtjViRUaOkl+4GZzYGwB9OgnHgIl0jrGJ2D9k8behjP8zfsfRRkscqhbWd+sKUufrEesoMA2hWpmF8/ytJjfGD0IHv9w95uBZVEVkMXtQEznMjg8ySBCLIiV8grAIEXKo7eqdW+SLtBUC21ONeLtnxC9I1ZUvyCSKtke1rukwmewpJ9n6gCeMiMuuM2tmKc4+TIbi00ofAaJOnGavqbwG6BiSmEh2jBXHjCkVA9PNlPu0BeFEHy6+C5/Mu14B5rOjrtnq6Z1A/avV4CmNk7yz3gHRofSULn8k3aJUDivmAXUw1zjR8i3Y+c+RG81ANZ8hKWkQ2owxfu1IeHLq43+9NkAd3bfQZ1a1WrHb5QR6t60/4/OUWRJySGfGlhOXsxShMxhzBAZH+seR4rn2Y0ymYe+kbhhj8sEnQR3WNYQyQy/UWfaZkSm2U3J9tJp8qtSpCrKNk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lHeRlQkG3n00BTxEVgRtCv2OmX66ucUYY3a6KI8upxp6noOKaLBdbSxOC5kQXr+L94KWkEZpxTyFgxPo/LANz+/TqykoJUMsnD5/8DZo5IUsvA/jHGT2R5buqeMfusQQw908NZxeZQzdTG7ClR5h5qS29ljq8DRalse5KIGmEeB9Y4djShBMgwQpxDqwfXyttwsLwfmk0gf+lrtIPtg2ZmWPoRKiHxeu7/2r4lSjAia23WDPshzsu8/TyFmkQusCJc8PyydVK3TeGUPM1ULebdW5s8phvELPPIUGC71Mtmv8r1ejdLT/Go9CMXuBwV5u4CO8Cod3SZJOqZimcijueTaYowbjkNkyliXwiHAEH4EQQmgoysFtByE1ye84YlR1U6Z0//upx7+DyTU0V89gAivNZc76XG567P8i9+iiozJVLWy8EtNS3zK9g2MYJeQOniHDR0og79b0WY20A8ZcKQRdks04XyQ3A1hbi5kqgEaHZyQXDioCKBKja3NK0jl+aDMIEs/0vIigPiNIh1D8QxgUP4DPaNU/JO7awGkoU1EsxVigDsvSLPsm5rJpQYVaUwHjL2p9i/LzTgphF8Wp7WhVhik1O9PfwPnDNQ0yk069klXobNi0NhMVvyAjtlRWQrZx8WHTtRn+lCEjJvKeek1CB3Lg5Sx6hv/DPjAd9dQfVi5c5ygmiu0aoc3tT8G
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU9YeTNpSUxKMWdQZUVvYVk5VnpwdERLQzBGY1BuT0w2T0pvOFAya1RlcmZl?=
 =?utf-8?B?b3FWVkJkMzhxZ0Z3bEY1eFhYR3JJRGNyaGJiRnNndSs1OUxCcFpjV25JVlAy?=
 =?utf-8?B?MFFWbjA4RkNzd3UxZDY1R0pHVkJ6MG12bWVyK1gwWlBFY1BDVTc5d2tHYS9X?=
 =?utf-8?B?VU42NDVuZVlwVE82cmdOUHo5UjlRbjVGdmtWY2RGTU5sRnJObitHdklqWXgv?=
 =?utf-8?B?YmlRZExnWTdqTmV0R3YwM1RScEdFdTBkR3lZbkh4VWRuOWdVOWJtTjhPMjV3?=
 =?utf-8?B?Z2ljTVFKOFA1SHVHRysvNHlzRGlYQ1Z4cXovc09tWElreVkxTlZYNUJCeXdu?=
 =?utf-8?B?ZFhWNzJnRnFKclkzb2NVU1hTUGZIMTgxWnNaa3k1Ulk4c2xsUUJ5V3VRSUdX?=
 =?utf-8?B?eFVaNGZpQVpKcGd0SExwMWRsTDh6T2xnSzg2aGc1alZyUFczY2VUc2xudzRv?=
 =?utf-8?B?UUhtQVZZb2VYTS9jU3BmcERGUy96QUNiMzdOSGNwT3RSUVJwMTNkUjVKTzlI?=
 =?utf-8?B?dDBNYTVCSGdEZ1M5b2pwNVk2T1N6UGNOSTFINzFCaS9wVCtJMkNtczF1SG5X?=
 =?utf-8?B?ZUF4b3ArdHJqMU5zZlZ5anpLVnV4RnlaZ1V1TVJzZnJWUjJUNy9yajQza0c2?=
 =?utf-8?B?aXNmZHR3NmlHT3dCZFRGWk1vTzhUK1gzUlErNmREbnlhMGhKdnQ1VkcyaE5r?=
 =?utf-8?B?R2pMUWI1TE9GaWxWL3dMOFd0VXFYZ3MwSmNieXpjVCtYOHRpKzBiUE1hZklm?=
 =?utf-8?B?aFFyczd1VXVXY2xJQmh4RlR0K3dCODhhL3RKSDZCbnJrV2wyOGhrVm05bmxU?=
 =?utf-8?B?KzQrdWJhRXVGMVRVcXQ4OEswUzlmQ3MzL0hNYzVLVDR4dkVnNHpPekhTU0pH?=
 =?utf-8?B?VjFRMEdlMUs3ZitrRlRDVlVtdEpiS3NjOUljQTZ0YzUwL1hnbkxrcWFkdFJT?=
 =?utf-8?B?blRxc2txclZRQ1IrTWpMMzU4TDI2V3FiNGVVR01KTTFnVmhPc3g3V1dzTkNY?=
 =?utf-8?B?MFNISjZ6SkREWU9QNmtWa0dzV3lCRnFXcjBvSzB4US9qazlrQlIrclpCek5H?=
 =?utf-8?B?OHU0WUM4cVpacGtsbkNJaG14S0Rlbk5mRzUrTFBOUUE4aVRQZExySGloSnJR?=
 =?utf-8?B?STFwYURmaXI5L1o5U0s5Rm4wUkFNbkZhTTh3cTNJWGdXSTJkT2pKL1J1eEYz?=
 =?utf-8?B?UGpoVDVETjVpQWdoY2ZFZEF1amFtN1NaTWxuYit5cnV5RVRvQSswSzltVlRD?=
 =?utf-8?B?Y08yMlR3UFVIdGJmYnY3ZEczaU5UWjhvQXVvdWY2RzNhZ0w3UXkvYzU3NzR6?=
 =?utf-8?B?eFBYVWpReXllTitpeTZSTjVzdnVxeERKM3VZS01Uc0Z6OStTcmoyTDQrUlhT?=
 =?utf-8?B?aC9GOVFOOVNSZDV1WXZpalhsZUhOY1Z5SThCR3VKb2QwQ2I5SWdFQjZWc0tp?=
 =?utf-8?B?QUQ2Qk4xeVp2S0dNUXhlL2hBTG5rYjRDSTZuUzBET3NqMUFoTWIzd250aXZt?=
 =?utf-8?B?YmFtcEZxSm5VRE9BREFiV1duYU80c2huSEUyWmFyYytxYlVWS1ZrWW5LMFhZ?=
 =?utf-8?B?RWZkUUlORmZDb092RGxNdzdJTU9kVDNlc1FCTzF3b094SGdXWHlSRHV4bHRz?=
 =?utf-8?B?TVJZa0cvWWE0bmtvN2VqWlFKbFk3VHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cdb94e-2400-43da-6e6e-08db4e3a04f5
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 13:58:50.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1755
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------FNWH933Kx0KL5j0yqhamAFdV
Content-Type: multipart/mixed; boundary="------------8EDt0PZsBN2yIqtC4wpOT5FQ";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: wiagn233@outlook.com, Walker Chen <walker.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Message-ID: <aea4cd83-05c8-8791-80e5-236b52be974c@outlook.com>
Subject: Re: [RESEND v2 5/6] soc: starfive: Add JH7110 AON PMU support
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-6-changhuang.liang@starfivetech.com>
In-Reply-To: <20230419035646.43702-6-changhuang.liang@starfivetech.com>

--------------8EDt0PZsBN2yIqtC4wpOT5FQ
Content-Type: multipart/mixed; boundary="------------bovERISIBeDOMx7yMEsevebd"

--------------bovERISIBeDOMx7yMEsevebd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCj4gQWRkIEFPTiBQTVUgZm9yIFN0YXJGaXZlIEpINzExMCBTb0MuIEl0IGNhbiBi
ZSB1c2VkIHRvIHR1cm4gb24vb2ZmIHRoZQ0KPiBkcGh5IHJ4L3R4IHBvd2VyIHN3aXRjaC4N
Cj4NCj4gUmV2aWV3ZWQtYnk6IFdhbGtlciBDaGVuIDx3YWxrZXIuY2hlbkBzdGFyZml2ZXRl
Y2guY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFuZ2h1YW5nIExpYW5nIDxjaGFuZ2h1YW5n
LmxpYW5nQHN0YXJmaXZldGVjaC5jb20+DQo+IC0tLQ0KPiAgIE1BSU5UQUlORVJTICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxICsNCj4gICBkcml2ZXJzL3NvYy9zdGFyZml2ZS9qaDcx
eHhfcG11LmMgfCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDBmYWZlZWE4
ZWJkYi4uOGYzMmQ0M2E5YjY3IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysg
Yi9NQUlOVEFJTkVSUw0KPiBAQCAtMTk5NTAsNiArMTk5NTAsNyBAQCBGOglpbmNsdWRlL2R0
LWJpbmRpbmdzL3Jlc2V0L3N0YXJmaXZlP2poNzEqLmgNCj4gICANCj4gICBTVEFSRklWRSBK
SDcxWFggUE1VIENPTlRST0xMRVIgRFJJVkVSDQo+ICAgTToJV2Fsa2VyIENoZW4gPHdhbGtl
ci5jaGVuQHN0YXJmaXZldGVjaC5jb20+DQo+ICtNOglDaGFuZ2h1YW5nIExpYW5nIDxjaGFu
Z2h1YW5nLmxpYW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ICAgUzoJU3VwcG9ydGVkDQo+ICAg
RjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N0YXJmaXZlKg0K
PiAgIEY6CWRyaXZlcnMvc29jL3N0YXJmaXZlL2poNzF4eF9wbXUuYw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zb2Mvc3RhcmZpdmUvamg3MXh4X3BtdS5jIGIvZHJpdmVycy9zb2Mvc3Rh
cmZpdmUvamg3MXh4X3BtdS5jDQo+IGluZGV4IGJiNDRjYzkzZTgyMi4uMTMwMzgyNmFhN2I1
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9zdGFyZml2ZS9qaDcxeHhfcG11LmMNCj4g
KysrIGIvZHJpdmVycy9zb2Mvc3RhcmZpdmUvamg3MXh4X3BtdS5jDQo+IEBAIC0yLDcgKzIs
NyBAQA0KPiAgIC8qDQo+ICAgICogU3RhckZpdmUgSkg3MVhYIFBNVSAoUG93ZXIgTWFuYWdl
bWVudCBVbml0KSBDb250cm9sbGVyIERyaXZlcg0KPiAgICAqDQo+IC0gKiBDb3B5cmlnaHQg
KEMpIDIwMjIgU3RhckZpdmUgVGVjaG5vbG9neSBDby4sIEx0ZC4NCj4gKyAqIENvcHlyaWdo
dCAoQykgMjAyMi0yMDIzIFN0YXJGaXZlIFRlY2hub2xvZ3kgQ28uLCBMdGQuDQo+ICAgICov
DQo+ICAgDQo+ICAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiBAQCAtMjQsNiAr
MjQsOSBAQA0KPiAgICNkZWZpbmUgSkg3MVhYX1BNVV9FVkVOVF9TVEFUVVMJCTB4ODgNCj4g
ICAjZGVmaW5lIEpINzFYWF9QTVVfSU5UX1NUQVRVUwkJMHg4Qw0KPiAgIA0KPiArLyogYW9u
IHBtdSByZWdpc3RlciBvZmZzZXQgKi8NCj4gKyNkZWZpbmUgSkg3MVhYX0FPTl9QTVVfU1dJ
VENICQkweDAwDQo+ICsNCj4gICAvKiBzdyBlbmNvdXJhZ2UgY2ZnICovDQo+ICAgI2RlZmlu
ZSBKSDcxWFhfUE1VX1NXX0VOQ09VUkFHRV9FTl9MTwkweDA1DQo+ICAgI2RlZmluZSBKSDcx
WFhfUE1VX1NXX0VOQ09VUkFHRV9FTl9ISQkweDUwDQo+IEBAIC0xNjMsNiArMTY2LDIzIEBA
IHN0YXRpYyBpbnQgamg3MTEwX3BtdV9zZXRfc3RhdGUoc3RydWN0IGpoNzF4eF9wbXVfZGV2
ICpwbWQsIHUzMiBtYXNrLCBib29sIG9uKQ0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+ICAg
DQo+ICtzdGF0aWMgaW50IGpoNzExMF9hb25fcG11X3NldF9zdGF0ZShzdHJ1Y3Qgamg3MXh4
X3BtdV9kZXYgKnBtZCwgdTMyIG1hc2ssIGJvb2wgb24pDQo+ICt7DQo+ICsJc3RydWN0IGpo
NzF4eF9wbXUgKnBtdSA9IHBtZC0+cG11Ow0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
ICsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmcG11LT5sb2NrLCBmbGFncyk7DQo+ICsNCj4g
KwlpZiAob24pDQo+ICsJCXJlZ21hcF91cGRhdGVfYml0cyhwbXUtPmJhc2UsIEpINzFYWF9B
T05fUE1VX1NXSVRDSCwgbWFzaywgbWFzayk7DQo+ICsJZWxzZQ0KPiArCQlyZWdtYXBfdXBk
YXRlX2JpdHMocG11LT5iYXNlLCBKSDcxWFhfQU9OX1BNVV9TV0lUQ0gsIG1hc2ssIDApOw0K
PiArDQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG11LT5sb2NrLCBmbGFncyk7DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgamg3MXh4X3Bt
dV9zZXRfc3RhdGUoc3RydWN0IGpoNzF4eF9wbXVfZGV2ICpwbWQsIHUzMiBtYXNrLCBib29s
IG9uKQ0KPiAgIHsNCj4gICAJc3RydWN0IGpoNzF4eF9wbXUgKnBtdSA9IHBtZC0+cG11Ow0K
PiBAQCAtMjcwLDYgKzI5MCwyNCBAQCBzdGF0aWMgaW50IGpoNzExMF9wbXVfcGFyc2VfZHQo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3RydWN0IGpoNzF4eF9wbXUgKg0KPiAg
IAlyZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgaW50IGpoNzExMF9hb25fcG11
X3BhcnNlX2R0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHN0cnVjdCBqaDcxeHhf
cG11ICpwbXUpDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAqcGFyZW50Ow0KPiArCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICsNCj4gKwlwYXJlbnQgPSBwZGV2LT5k
ZXYucGFyZW50Ow0KPiArCWlmICghcGFyZW50KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiTm8g
cGFyZW50IGZvciBzeXNjb24gcG11XG4iKTsNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsJ
fQ0KPiArDQo+ICsJcG11LT5iYXNlID0gc3lzY29uX25vZGVfdG9fcmVnbWFwKHBhcmVudC0+
b2Zfbm9kZSk7DQo+ICsJaWYgKElTX0VSUihwbXUtPmJhc2UpKQ0KPiArCQlyZXR1cm4gUFRS
X0VSUihwbXUtPmJhc2UpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gICBz
dGF0aWMgaW50IGpoNzF4eF9wbXVfaW5pdF9kb21haW4oc3RydWN0IGpoNzF4eF9wbXUgKnBt
dSwgaW50IGluZGV4KQ0KPiAgIHsNCj4gICAJc3RydWN0IGpoNzF4eF9wbXVfZGV2ICpwbWQ7
DQo+IEBAIC0zOTgsMTAgKzQzNiwzMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGpoNzF4eF9w
bXVfbWF0Y2hfZGF0YSBqaDcxMTBfcG11ID0gew0KPiAgIAkucG11X3NldF9zdGF0ZSA9IGpo
NzExMF9wbXVfc2V0X3N0YXRlLA0KPiAgIH07DQo+ICAgDQo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IGpoNzF4eF9kb21haW5faW5mbyBqaDcxMTBfYW9uX3Bvd2VyX2RvbWFpbnNbXSA9IHsN
Cj4gKwlbSkg3MTEwX1BEX0RQSFlfVFhdID0gew0KPiArCQkubmFtZSA9ICJEUEhZLVRYIiwN
Cj4gKwkJLmJpdCA9IDMwLA0KPiArCX0sDQo+ICsJW0pINzExMF9QRF9EUEhZX1JYXSA9IHsN
Cj4gKwkJLm5hbWUgPSAiRFBIWS1SWCIsDQo+ICsJCS5iaXQgPSAzMSwNCg0KV2hlcmUgYXJl
IEpINzExMF9QRF9EUEhZX1JYIGFuZCBKSDcxMTBfUERfRFBIWV9UWCBkZWZpbmVkPw0KDQpC
ZXN0IHJlZ2FyZHMsDQoNClNoZW5neXUNCg0KPiArCX0sDQo+ICt9Ow0KPiArDQo+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IGpoNzF4eF9wbXVfbWF0Y2hfZGF0YSBqaDcxMTBfYW9uX3BtdSA9
IHsNCj4gKwkubnVtX2RvbWFpbnMgPSBBUlJBWV9TSVpFKGpoNzExMF9hb25fcG93ZXJfZG9t
YWlucyksDQo+ICsJLmRvbWFpbl9pbmZvID0gamg3MTEwX2Fvbl9wb3dlcl9kb21haW5zLA0K
PiArCS5wbXVfc3RhdHVzID0gSkg3MVhYX0FPTl9QTVVfU1dJVENILA0KPiArCS5wbXVfcGFy
c2VfZHQgPSBqaDcxMTBfYW9uX3BtdV9wYXJzZV9kdCwNCj4gKwkucG11X3NldF9zdGF0ZSA9
IGpoNzExMF9hb25fcG11X3NldF9zdGF0ZSwNCj4gK307DQo+ICsNCj4gICBzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBqaDcxeHhfcG11X29mX21hdGNoW10gPSB7DQo+ICAg
CXsNCj4gICAJCS5jb21wYXRpYmxlID0gInN0YXJmaXZlLGpoNzExMC1wbXUiLA0KPiAgIAkJ
LmRhdGEgPSAodm9pZCAqKSZqaDcxMTBfcG11LA0KPiArCX0sIHsNCj4gKwkJLmNvbXBhdGli
bGUgPSAic3RhcmZpdmUsamg3MTEwLWFvbi1wbXUiLA0KPiArCQkuZGF0YSA9ICh2b2lkICop
JmpoNzExMF9hb25fcG11LA0KPiAgIAl9LCB7DQo+ICAgCQkvKiBzZW50aW5lbCAqLw0KPiAg
IAl9DQo+IEBAIC00MTgsNSArNDc4LDYgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgamg3MXh4X3BtdV9kcml2ZXIgPSB7DQo+ICAgYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIo
amg3MXh4X3BtdV9kcml2ZXIpOw0KPiAgIA0KPiAgIE1PRFVMRV9BVVRIT1IoIldhbGtlciBD
aGVuIDx3YWxrZXIuY2hlbkBzdGFyZml2ZXRlY2guY29tPiIpOw0KPiArTU9EVUxFX0FVVEhP
UigiQ2hhbmdodWFuZyBMaWFuZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29t
PiIpOw0KPiAgIE1PRFVMRV9ERVNDUklQVElPTigiU3RhckZpdmUgSkg3MVhYIFBNVSBEcml2
ZXIiKTsNCj4gICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo=
--------------bovERISIBeDOMx7yMEsevebd
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFaz
LV3FGBjT+9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q
4Ww/W87mQ12nMCvYLKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx
0HJ92zTBMzMtYsL7k+8ENOF3Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/
SJv0w2YmqZDIAvDXxK2v22hzJqXaljmOBF5fz070O6eoTMhIAJy9ByBipiu3tWLX
Vtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1el5WW/qxqrKCSrFzVdtAc7y6Q
tykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdromSrsD0gEmGcUjV7
xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB+X85sxcr
4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0x
i/KZIRpSlIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQAB
zSFTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
AQIXgAAKCRDjUgzJGSnI57GwD/9O6kei9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ
8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSiOnyyHrg8StmGLksQE9awuTnl
nQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHaJwFi1KATSI1AhsF3
CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9voraKhx+0Ds
ZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISF
gvZoGYdB9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaa
LZH/jzQf7FpIGGhDYnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2
yVu3w4tIchRT3wekMh2c3A3ZDeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yA
j6Ey0YrIUbW9NOhIVCGkP4GyJg756SGzyPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AE
H2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4TrXUR0ScTy1wTKV1Hn+w3VAv
6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23Fj4LK2mKTBoEwtC2q
H3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8aiQQUKyZ
dG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM
/pM4L0tPVCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwh
agPSYDV3cVAa4Ltw1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVyk
k4q2DDi0dSC6luYDXD2+hIofYGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjn
zuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQ
zRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoDIbtRm3xt2tFrl1TxsqkDbACE
WeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3CizcOmgc61pDi/B6O2
IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DBbUslCmkA
EQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3P
Pt4wkQkdbF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZO
pxb1EwWwvnVUwrLxCuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsN
VeqrWU0mDAOgvqB86JFduq+GmvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEy
uRmtKtqxTP/u6BzowkV2A/GLxWf1inH5M81QgGRI2sao6To7sUt45FS+y2zhwh62
excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFOjeBOYr+ZCCeARh+z4ilo1C2w
upQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrrmnEaZMsoRdS22fne
CVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/1aPc2Iox
cQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/a
LzG+FguuGNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2zsFN
BGK0OekBEACw8Ug2Jo4DF9q3NFOZ7/Vwb6SlKpj3OdBjGTPwRZjV4A5CzbEqXrkl
TKFNE9CRbxyoNXN1UXXrBb7VHKgyu0rnGPqOb0rtUABz+wMvYuShKOPcWmg6n9Ex
9UGIsYBMJ01IQMU87qcZUmfxo5eYfniyBnOGB+pbVf1jhOhZWIXlVdmxYbMc+xeh
W+VHI98BiL14vXWFmpBWFc85BO4AbijDzPtkZhPvB9mj2he+z/XUND+nG3to7xAY
I0Kxacw55w8HL35Nuv+G7EtUWX5uhpO/dDB0BMcW05s6L6rebpEAAMFVBKIAJUKy
pvTYcAN+E7yfQAzvl8mNtcVMsFHTr54wTSHR0Xx32G72Ad7dkeqy8HhfkT1Q/5V/
xzUz1qgmtQtWgA6jnSCYISGOXMjnFhzMG3DVuE5cI/RaPlybHfBsqrtQoxeMMoX1
qD3Tt3TvwFojOEw4KE3qz1zTcozqLHScukEbNhlcLRUv7KoqSIcnN56YEnhjMu9/
ysIbFuDyQo9DaieBBWlwTiuvq5L+QKgHsGlVJoetoAcDojCkZxw6VT7S/2sGCETV
DMiWGTNzHDPGVvutNmx53FI9AtV09pEb2uTPdDDeZZhizbDt0lqGAianXP+/2p1N
Zh0fMpHJp+W4WXPQ+hRxW4bPo/AXMPEZXkaqqDrMcsTHrwrErCjJ5wARAQABwsOs
BBgBCgAgFiEEl+T1FV1DUmhlU9h/41IMyRkpyOcFAmK0OekCGwICQAkQ41IMyRkp
yOfBdCAEGQEKAB0WIQRP/KgY/enlmX5EpW5fvkoEB8mxGQUCYrQ56QAKCRBfvkoE
B8mxGVNQEACNCgyibR1+BY00hem9CCIZGHqyWfJn9AfiPYIY1OB80LUJXhJULtT8
DeUUOgMZtywhJvu4rIueOufVzeuC5P0lfO4htBmi2ATQu8bT2h0YxcNL3YKYFoqe
+FiVI7RxR1G2C+fDecyCXUrPtry++NiXdLVeFdDxumCuHZKffqiqFpL/8yDLnaoc
3aVHPT2Wv0iDU1JeSOC5LKPWFNznA5ZX6uxfiKzSc4E1qi/vr+1twXqwiwfIc9Ib
NniN59mzfXyKd64Geu1UT2wf1dZzVAcsXWDM4orCyx11eVh7ZKPmmVe9mpwcdh+s
4t76/WDFbbUe6ZSixOwINRUn16CvUNBxpCKI5RXmpCLj8Z+oUBpyR6c1sdw0uk7F
o4TcjBsvQXtpkewqyXXyy4NcCpveWPICbh8RmvZx4ScTufXH0FmLMkthuRgH+TqD
HHFvKNyhHoXWeIQT7oez28oY2a81CKQ+m/TkgNeA6vqmBZYJ1kKK6nc3vbFLc4Jk
2SRVCNpIvr+E38hxHz5e2n6dtgfgCCb2EEA83TjmX8/2dWZJA4ndML7AaCjw3Xqr
NbTrVgP99oH+D+7tFxJ+LlLAhIjKs1efKEFlOsXH7QqyO13BUYldhFL+2KjrNFoG
X9s7f57xIaqwdTd/okf4eBNYkg1+Pcj/AMgEAvRcagMATy2pAGmxMF2YD/9Z6y3I
oPB+lkSrP3AE1fhBRL/OH7UaLB4pyCpeGLhG5X8xdM9dwRPX+kadflKH2F0GPqUi
x5O1tJUMEdCb/WpQ9gUAb6Ct1Zntis8hd8pNQIGUT+kpwnpiLVEhbeg5DX459ho8
N+o6erYR34cUz4o0WFa1TVNFQGKRTWfzyUxxGUUcW2QC5mCwPCPZv69zvW5c0Ddi
RwUcYGGruslC7cHWXbO8zQ/R2zQcCjnyIniqoyQDTsQlK1oBM6iQMALhej6fsMe7
zWlA8/0FNj27Ub6biaWmK9aohWTkZtv7bD3IKaQRaq/lBg+2OmDGrSHNREt5T4EO
85QqMJLnjzQ2/FbA62E+piWzRaChJVUy0Ol6SVJHGascnqT4fWBX0lpZx9A7+XQh
CtCbX7ETzHPzugeXXyAhVuleaV+yzoSc9+aF2y38WrFczSzFX5APegWZ/8JxEbhJ
KqOwqSlC+IMwblPA3naZbCiKuTYxiU0Ys3CSdZeFFvSXuvhLJk185anQQjQS874J
8pkvTd2ueYxp46hde0rCZaAKlhNrp3G1NNUpt5QpjLan6NhmpQ42XfILC4v1Qg7A
T4vGG0QPhmMhbGgPn+44EYuh8/941mkyaYL0fXyu6l2HoKEZiLerr8vqgc08NvAl
QW/1QnKz4zA5XUvOrxQsLFF9ie2eG6DWJkdh1M7BTQRitDoIARAAtZRhbhuAfenu
NS2kPytShodMn4bfP1lSNi/P6vSWVym6s+bQPIbuRYfNvMZMKR1hPF93ERpSCAx9
bEsLtXJ3w9p2gFOUkn77sw/14v0jPJokQbTfg3dO0PKb+/89q1oVuOyGLhgXW1P/
ZGdIred56i2vsVfz7NmvPkSATr1bPTocYgpqdGf1+FQp8pDN60aXQ0RJ7rZpOTGx
/5BvgeraLXCbpy3ibaJF92HDU5QM1AeBs7LpXybFc+DZ+wktULeKemAF2EDnFauQ
CfGi66MHXGz2Dgy77ladSpz+OvpLTMpubzVeiGXwkNsa/Fs6lv1+arY2dUtHjvvU
0kLf/arNT+mOCMD8c2aOapgUQhOhM2U2OwRgbJ1y6OVKyN0UN76kDpKSpSsQelpV
/TfUk4LMTOB+rIfeAwG0NfKsYCzxV2dvX9E4wgAupsryeHYhidFuUwQncPqckOVg
xXCwOA6GGtMVEQFR0snuVn4ulLgAJy0rJXbYSj8vac4V67X6l2CK8xvgvZUgm2C/
MoV9XcjoxQzNIMySFDNBmM+rtTOW7Rxn1mlI7se5TOKAlnq+cTuLAu+L/LKNRSoe
dKYsUUTjHGmewyUNlcHHHQcjMS3jwzZ2a9+YP5KpKJCsT/eqBZoiPAL6V9iCBiM+
02BKe2R86wK8OqehvxvR2mpFwVPk/H8AEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1Jo
ZVPYf+NSDMkZKcjnBQJitDoIAhsgAAoJEONSDMkZKcjn/ecQAJ1Da87OZQnYugWr
vPQOfsdV9RfyyXONrssGXe8LD/Y6rmzZVu+Bm49F9TF0Qxc+VOrJpv9VVsfOqFJi
0wykOwyESdVngNrAW9ZWzfIvkEDSpTlaxvzbNEY7pBpvb1xFoSMrou1ro3299XKf
tlA29RYHiwH1HIC1JPJBWsS4tlahZ9AtGo5p5wVoEKxN6D/SrjLCcFiQJlH1yISc
sZVFm3qgTuo2g0uzJM0o1Y2B7T8mK/rsm3hUHJlbCrPl/rkYEAlhSUKpawKhldRh
OeqUUCcjnfdmFgTH/HtTMIlEQA+Ck/T8M5+Zp/nhCpPCx0pTuDdUTRo3tWHL+Nri
wK+AuZNR+0pevuTYOyD6CV0Hng/3lU86i3gN16GVxNWQjUdQ1ps9InaQhLxsgevQ
msgzOqo6GUiHQIdxvAtcG7pXv7HRhxsZA+68h8lixiMeE1W30PH1nxn5gN/Ekldj
c5F9xBu1/vTSX9dGzer1zZZFn4J8lbD6R+keOaroF8Q9S1cYnQbh3vASshmzNgi+
ISmLtR1a4zjxY2AlKNv+jkdpItjot5dewxVeU5x5i1sXWJ3Dt4xNyFSs2PZs1IuP
Solmy00hVZdFiGmr8QuMmOo6YagSdVvrryw812k5vAskD5AMC9EGru1Y8e9FddsL
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------bovERISIBeDOMx7yMEsevebd--

--------------8EDt0PZsBN2yIqtC4wpOT5FQ--

--------------FNWH933Kx0KL5j0yqhamAFdV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmRWXREACgkQX75KBAfJ
sRkGCBAAgd9RYsG8IwFkhFKF8frVUqCa5Mwa2J2tXcqCWhi4tLvgn7nnEDPF71/E
dJNJNQ9zS/G3fSJPZFOMh4GKx7Pp/ktB651s0L7gkxZYKE/bAZIql+UUoD/NGfHn
FYquxdmosoIN8if+YA4O8ncViYMKSd9tjWLDlLTpBKcS3vGTLQ3OAVDW6vSX0HdW
iLJOscomhvrLV61p0jZUuIsmTOtu+BMFrhFuF0gIzA7UBXmDVTufySkOn41eivYG
YeEUJaQGUhOGWJ3/J5YVGzR30vaHL81JlggpQkXZjMLh1M8tFGRulLr5Ijwa7IUF
l+W4qaFMce37SMk+UnsMsQXzyzRSdA4V5daeU/R47ynAcalSxAZyvzw053XhhyQe
wI7BG7Vo4JW3UOBNVFaetOyggLQixZJXzrW6SDl0tduGwELyJbNJ5UB1xIkCxe3w
x0q7Gdl6mmsSP4HNopFgNCEaSWuZBAdL2WWP4EeWjQmZyqsmWP/A+qX7ynO9QZ9z
yngQOvvo8g5seSG/M88IHKOktl6+iA8o9aFCxH+BtwMAG1LwlJX1PD4Fy1eNLAaz
wtNysP22LPPDUfMmoNF9NaC7bmnvPdbzrDr6k2/pMEft25ThZuW3sHWLr/oG44xI
rzZl7jZ9gX2o3P5whR4TTxvt0GOWZc3MFt7UsTiuiLEvNsvu4P0=
=nYng
-----END PGP SIGNATURE-----

--------------FNWH933Kx0KL5j0yqhamAFdV--
