Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE106F0497
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbjD0K4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjD0K4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:56:07 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2045.outbound.protection.outlook.com [40.107.12.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D8612A;
        Thu, 27 Apr 2023 03:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyM70l90pS2NVM4uUsau9M0c8g97FsM8dJf541ZAw8KCBc09GnzJJPlSNEs0z4Yu7C2q2BonA1iOSPH1V/aFAfEnG5bt2UQdjPE4AA7oy1j405kU0v3aKhED3QeyOfCy5G0oxfWh1k7Bq91K/x9yVzWSVYBYSGZOcFCcAU0/81kp2hL7DR588WdqL3Ihlc4XSGNILYwtSHISmVZanEEwMTVNXv9v5HLe7BqNATy3D6iZ4y/PPr321XQ296/iiv6jnRnsKlfv2NCea1C+WWh1Xg6wZxDxRyOf7TAIEMNfci/1uCPUi3uP4MIPNRmmuGY/I2B1lqOiQthP82cXwFVZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOIRV1v8ubdycKpFtKYYOHuwOUV+VnRb1dKTDnNRdv8=;
 b=chuCou1ZmBvJEC2sqc7YQoqmc4CWOB3Kzpfw54twbFYGAgjnLAdjZGiAVBC7CFzlhaDKzui+qZMrsyzY3x4YP5f7lyBFBcPm4ZlaZwABDB0Sxphy09w1+sSyems39Vu3D0OKAASUeQReBu1JwJ+MMMjVkw1JZA2lrikc8DiC4mb4Ka1TOiS3RjA3q2jx09Q2uvp5V7KEVrG4EnhI88j3221Sltov6SRitpQFF3OUcSQ6tNA5Fw9GZliFkKYN72Sx+0CJ3TQnhK5kYevhs8WhWmpJnws05DCB2zOapnI46wTz0eJGgjOVuzIartyqwY3rf0ilLrvWN+uwdRKOuuZMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOIRV1v8ubdycKpFtKYYOHuwOUV+VnRb1dKTDnNRdv8=;
 b=XB/jdZe06YFDB2bwnRfvpSnhIMOjaFe484yIjsHCYcrUaKRw80+uqMgnW4iN42H8eNCA1w6p4VIPp626u02P+f5baO4Y6uIpoOBNrHP19HuMC7Edjjuj6Lllz6RDTUzbcniFMPbXa6meHY5/p7orTNEHPTa2fGAMf87rjgW0nydF9vXoNkJiTkqPp85N3JSD2E1FBzz3VAgtk+tKMTG7/0IV9Uh4ix0UrbtW/VyGx5ikyRGcclqV8HXwj1AZMzDN0g/cxz76E9hxJY6UBERvPl7M0GyqopbITxN6TZZsHp1diqAkvjNC41oRv5CfpMp0ZTMHUFSBkkfEyCpdJlW4Tg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3284.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:21::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 10:55:57 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 10:55:57 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ": Tony Lindgren" <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
Thread-Topic: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
Thread-Index: AQHZeIsM14bqQdx5QUm8jstSB2yPI68+pFKAgAAF0ICAAAWGgIAAR86AgAACXYCAAALGAA==
Date:   Thu, 27 Apr 2023 10:55:57 +0000
Message-ID: <d585bdd8-978a-8172-bd55-4494d25299e1@csgroup.eu>
References: <20230426220338.430638-1-andreas@kemnade.info>
 <f6b261ad-3267-db70-c173-154a12c42bea@csgroup.eu>
 <CAHp75Vep8VSirY7mvGGCubNi-O4jS_inTALS3Ei9mQu98RV+7Q@mail.gmail.com>
 <52453352-74bd-979f-03b6-322489800538@csgroup.eu>
 <20230427123733.15ad4aa3@aktux>
 <CAHp75VezDMZkRTRHRACtJZCW2S_1NoZL5GDK7tmA2vzjrAhOKg@mail.gmail.com>
In-Reply-To: <CAHp75VezDMZkRTRHRACtJZCW2S_1NoZL5GDK7tmA2vzjrAhOKg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3284:EE_
x-ms-office365-filtering-correlation-id: be1b0885-4e81-4994-de31-08db470dfb2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfDxdR3eTGRIzttG29ZOwu6a2+XYOV1xD/SkgMVCWCOqykyIieaYYVULmlCOqSzTiXIpA9BJllTSzYyY1pxY/HiXmUm7HXD4hKbntfgV2Bd9BkeV834KvSOLB7f/jrSIYlh3RylSH3T91z/DzLT6DOlDHHa0u12wcAhRqFQlqp8m94qIWxIJzDd7XoEqpBhZsoyfTMfiVnztro4VfgNdVlSwwJxgokuh4dDHJqsqMuaqTZCdg6JaKiAQHruE/GEBx9/gYzALRIHvFA25l0FyI/ihczOSnRWvw8ohiiLfP45vODtAMa5c+jqwfxrYWBLKEyQPz6+Ogmd/nd3CapZ+hXbfH3buai23EQvAPe9SbwI9IEAKFKY1SejHRXcDSNXjQr6fyKkyodQ6LrWyzM1E6SAITN/SfHVkcThwm8y6KSMDIiH+gz4rdWnAPypUEkB5IVJXnO00i8HpCTcNcpp11ybQHL1twOcXQiP9DgxWz1O3qjkToQkIJ23hVjyxkjoopPkFTC++CqMqf/LDC71VUo8RzXVt3Ir3fDSYRxDpGEX+6lxKB3pQ53zFg6u+COre+1dEs1UpynxmwFywNkCZvlJMUI5TPoqWnKj2wLKWVd6e2CV2TSLGzmPKbPaLvybLI0mpk13PhLce2qfgp2zJLAe1+6W56usttkeaIFpMxX6dGVXhJ/1j0gzj36wFzOWu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(136003)(376002)(346002)(396003)(451199021)(8676002)(38100700002)(8936002)(316002)(122000001)(91956017)(41300700001)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(4326008)(38070700005)(2906002)(5660300002)(44832011)(186003)(6506007)(53546011)(6512007)(26005)(36756003)(66574015)(31686004)(2616005)(83380400001)(54906003)(31696002)(86362001)(110136005)(71200400001)(6486002)(966005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW1UekN1V0kvc0g4S0dQYWg3QXNLMm9FN1V3blVwRFBweWdFNEhZenVMeGQ2?=
 =?utf-8?B?bTNwKy9Bc1RXV0Z6SitaMkI4bUlBSDdORVlMSDhDZ0RwN0VORzJxYWRmR255?=
 =?utf-8?B?NkNaS1lBNFp6MjJUUVJlM0ZuNElNL1VPTUV3RE5IR2F1bHk2blAxVXFPc0Vt?=
 =?utf-8?B?SFJkcnVTckhoYmdsMGVWb0cxZnNVak9OcUFIQ1MyR09yVnV3REQ0NnpMY05t?=
 =?utf-8?B?V1EwdGJNblZwNUNHenFVL0VkUHRQRWloVE5oYTErRW9ldWVkQVVrSlc5LzJC?=
 =?utf-8?B?M2twK05MWVJuZzkyckxIM092ajNGbmQ1c0pEZkxQdVl4YVYxaHFnRlpPMDRw?=
 =?utf-8?B?alQ2eHBGQnE5Wlhjd1dqQ0VsajRZUTd3WnJ0WE9rV3Y0R0hxcWdoQjB0T0tN?=
 =?utf-8?B?a3BRRTl3dDUrTXEwdURUZHpSUEs1eW5mZ1pncjlwSUVYN0VLcFErWmtqeStj?=
 =?utf-8?B?ZDNXZXdhYmN3RHpqZnB5bG84bFJ5aGRqRzNFbllSSXVKbis0MFhUdERTbWF4?=
 =?utf-8?B?MWtia082c2Z2eFo4bEIzWGVPRkgreVBrWDNmSWwzNFJpVEZ4N3BUSE9sRnM4?=
 =?utf-8?B?UHcvTzBIeTFtUHhUYXZ6Mlk0cHQ0MXBMbzE4bmpJeWJiTUV0ckM3OEZYNlFB?=
 =?utf-8?B?SFdHRkdjeWIxNm9HR2tYcnI0Wk85NWJxWk5rWE1mcGw3NmZGOHhTWDhoVmdU?=
 =?utf-8?B?dGtCOTIvOHJEREcydWovZVZCWWlnV0locThWUGRWeHBXZzdMOUlvajBrQkVT?=
 =?utf-8?B?ZktqRnFXMUlyUnJmWlMwZEVlaGdPOHNMZ2NRNEVzbkJkMnB3dktxR3liS2FG?=
 =?utf-8?B?a00ybDZyQk4vVzB1WGl0UXZ6Qk9vM0RnSExBUXFML2hxbkg5blhaQWQ4SmlM?=
 =?utf-8?B?ZVZsaGRDb3owdWZZZEZya0VSMzNIR1NCTXd4ZktERmcwcFNTRjU1eXVIWTFv?=
 =?utf-8?B?alM5UytUOTdlcUZPY3ArdDFxVWxULzRYK2cxdHc2U2NsQVJSVm9ac3JEektu?=
 =?utf-8?B?NnJ3WXZ5SzlNQ29oajNTSEEwY1VUSzNjakNaVk5BTmo5MmorVUxIc1hwUjA5?=
 =?utf-8?B?WHBmS1FPcmsyRU9lcWxSNDFydWJXb2NtVWJIWkt2UDlIY3hML1luS0Z6SGU1?=
 =?utf-8?B?U2ZsZ0ZyVWlnMEhEMk0xTUUveGQ0WHNXY01Bd093eHgyYWNtcTFrbmF4aGU2?=
 =?utf-8?B?REVJQU1xU3NJWDg4VHdzR09TMFhWYlNPUXRqNmZGdERLdkNwMlBvM2FyMThN?=
 =?utf-8?B?Q0FWVHk0TEVEZ0ljMm1OdjFPeC83WXdMYlUwNGJSVmhYRkp5Y1RNZytDcGZT?=
 =?utf-8?B?NzFZTG5XaStNdEhQZ2ZjOERjOWFnV2VNdGpkN1FuVjJKK3huTDFYV3NZbXcx?=
 =?utf-8?B?Ym13cVNvaFI2YnlZNnFyNmw1cXpUMjdnd2l3WmFnV0tSelpqY1J4Q0htanpU?=
 =?utf-8?B?YytTZWt1MWV4S2F3aklmbFJlVmhDV3RqUGNRa2hEMkpKUkhFSlJ2KzNGcUtZ?=
 =?utf-8?B?Q29ZZnA1UTNFMkZMR2NnaGF0VmFsYy9XT2VWTEdwWm14NGJSbm1qd3A2WXpk?=
 =?utf-8?B?WXNiVFpMNU9aUGNxdGhvSkNEMHVLclZmY2x4Mk81K0JFYWpIajBqMEFBOERN?=
 =?utf-8?B?V0o2WnlyaFBjVGZxeVlDVWVTcjYwVlV1SHVpVEJuempYZlNEZjJZRnhiMlBN?=
 =?utf-8?B?UU55ZXFqbXg2dURIYlBkeFRNWm0zcGNHZmQ3NWh4Z3dqR29EOExmM1Y0RHVP?=
 =?utf-8?B?NWhVNGhpK294aEpoTjdVUDZJdmVKRjhRaFJBcWFtaytiMXdxZVVNTk1jZi83?=
 =?utf-8?B?YXE5ajhqS0Q5TUhQMDRWNlpIbFo0cnN5ZjdsUjFPS0xKNlBRV3Z3UDkxUzdQ?=
 =?utf-8?B?SEdQT3RJOTVvcHRibGdYT2FXUVh6cVFoVGpybDRpWnNqWTVGMlQ2cHJONnBW?=
 =?utf-8?B?NlpjOFBxTjFIcjZFNTNmWUNxSnp0YXhONHRDR2ttQThPNU5rcUtuck83WjJY?=
 =?utf-8?B?NnhVMlF3elRiNU45cmFuTjkvU3ZtUTFMVjNRK1NNQUd0TEhGQlI2ay8wbGJP?=
 =?utf-8?B?OHRUSWgxenFXNTg1ZGhvSWdEYWVvelpFeU91VTRQRVNFZXgvMW5LOHc1Qk9j?=
 =?utf-8?B?TTFSNXlwUnNKbHhtb2VMRzY5TkVtYTEvZWk0aVMxTGV4d3VLWGVBODI0TXVV?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6476C45FBB6C554D95CAC6D6BC3FF40E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: be1b0885-4e81-4994-de31-08db470dfb2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 10:55:57.6559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEHE7+j7jCxnGZb+/GYQWr/a3oZeYoFiGKm4PlzylZOrGVuyt/bgKDXj7ctOEdlrjlMq6/3O0ujlF6oBxjoMNW35qqlg4sFZ7TfyCdfhisQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3284
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI3LzA0LzIwMjMgw6AgMTI6NDYsIEFuZHkgU2hldmNoZW5rbyBhIMOpY3JpdMKgOg0K
PiBPbiBUaHUsIEFwciAyNywgMjAyMyBhdCAxOjM34oCvUE0gQW5kcmVhcyBLZW1uYWRlIDxhbmRy
ZWFzQGtlbW5hZGUuaW5mbz4gd3JvdGU6DQo+Pg0KPj4gT24gVGh1LCAyNyBBcHIgMjAyMyAwNjoy
MDozNCArMDAwMA0KPj4gQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3Vw
LmV1PiB3cm90ZToNCj4+DQo+Pj4gTGUgMjcvMDQvMjAyMyDDoCAwODowMCwgQW5keSBTaGV2Y2hl
bmtvIGEgw6ljcml0IDoNCj4+Pj4gT24gVGh1LCBBcHIgMjcsIDIwMjMgYXQgODo0MOKAr0FNIENo
cmlzdG9waGUgTGVyb3kNCj4+Pj4gPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6
DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiBMZSAyNy8wNC8yMDIzIMOgIDAwOjAzLCBBbmRy
ZWFzIEtlbW5hZGUgYSDDqWNyaXQgOg0KPj4+Pj4+IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZl
bnQgZGUgY291cnJpZXJzIGRlIGFuZHJlYXNAa2VtbmFkZS5pbmZvLiBEw6ljb3V2cmV6IHBvdXJx
dW9pIGNlY2kgZXN0IGltcG9ydGFudCDDoCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVy
SWRlbnRpZmljYXRpb24gXQ0KPj4+Pj4+DQo+Pj4+Pj4gSWYgc3RhdGljIGFsbG9jYXRpb24gYW5k
IGR5bmFtaWMgYWxsb2NhdGlvbiBHUElPcyBhcmUgcHJlc2VudCwNCj4+Pj4+PiBkeW5hbWljIGFs
bG9jYXRpb24gcG9sbHV0ZXMgdGhlIG51bWJlcnNwYWNlIGZvciBzdGF0aWMgYWxsb2NhdGlvbiwN
Cj4+Pj4+PiBjYXVzaW5nIHN0YXRpYyBhbGxvY2F0aW9uIHRvIGZhaWwuDQo+Pj4+Pj4gRW5mb3Jl
IGR5bmFtaWMgYWxsb2NhdGlvbiBhYm92ZSBHUElPX0RZTkFNSUNfQkFTRS4NCj4+Pj4+DQo+Pj4+
PiBIdW0gLi4uLg0KPj4+Pj4NCj4+Pj4+IENvbW1pdCA3YjYxMjEyZjJhMDcgKCJncGlvbGliOiBH
ZXQgcmlkIG9mIEFSQ0hfTlJfR1BJT1MiKSB3YXMgc3VwcG9zZWQNCj4+Pj4+IHRvIGVuZm9yY2Ug
ZHluYW1pYyBhbGxvY2F0aW9uIGFib3ZlIEdQSU9fRFlOQU1JQ19CQVNFIGFscmVhZHkuDQo+Pj4+
Pg0KPj4+Pj4gQ2FuIHlvdSBkZXNjcmliZSB3aGF0IGlzIGdvaW5nIHdyb25nIGV4YWN0bHkgd2l0
aCB0aGUgYWJvdmUgY29tbWl0ID8NCj4+Pj4NCj4+Pj4gQWJvdmUgY29tbWl0IG9ubHkgd29ya3Mg
dG8gdGhlIGZpcnN0IGR5bmFtaWMgYWxsb2NhdGlvbiwgaWYgeW91IG5lZWQNCj4+Pj4gbW9yZSB0
aGFuIG9uZSB3aXRoIHN0YXRpYyBvbmVzIHByZXNlbnQgaXQgbWlzdGFrZW5seSB3aWxsIGdpdmUg
eW91IGENCj4+Pj4gYmFzZSBfYmVsb3dfIERZTkFNSUNfQkFTRS4NCj4+Pg0KPj4+IEFoIHJpZ2h0
LCB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkLg0KPj4+DQo+Pj4+DQo+Pj4+IEhvd2V2ZXIsIHRoaXMg
Y2hhbmdlIGlzIGp1c3QgUG9DIEkgcHJvcG9zZWQsIHRoZSBjb25kaXRpb25hbCBhbmQNCj4+Pj4g
YWN0aW9uIHNob3VsZCBiZSBzbGlnaHRseSBkaWZmZXJlbnQgdG8gY292ZXIgYSBjb3JuZXIgY2Fz
ZSwgd2hlbg0KPj4+PiBzdGF0aWNhbGx5IGFsbG9jYXRlZCBjaGlwIG92ZXJsYXBzIHRoZSBEWU5B
TUlDX0JBU0UsIGkuZS4gZ2Rldi0+YmFzZSA8DQo+Pj4+IERZTkFNSUNfQkFTRSwgd2hpbGUgZ2Rl
di0+YmFzZSArIGdkZXYtPm5ncGlvID49IERZTkFNSUNfQkFTRS4NCj4+Pj4NCj4+Pg0KPj4+IFll
cyB5b3UgYXJlIHJpZ2h0LCB0aGF0J3MgZ2Rldi0+YmFzZSArIGdkZXYtPm5ncGlvIHRoYXQgc2hv
dWxkIGJlIGNoZWNrZWQuDQo+Pj4NCj4+IGFuZCB0aGF0IG5vdCB3aXRoIHNpbXBsZSBjb250aW51
ZSBvciBiYXNlIG1pZ2h0IHNpbXBseSBzdGF5IGF0IERZTkFNSUNfQkFTRS4NCj4+DQo+PiBJIHdp
bGwgc2VuZCBhIHYyIG9mIHRoaXMgcGF0Y2ggd2l0aCByZWZpbmVkIGxvZ2ljLg0KPiANCj4gQWN0
dWFsbHkgaXQgd291bGQgYmUgbmljZSB0byBpbnRlZ3JhdGUgYSB3YXJuaW5nIChpZiB3ZSBkb24n
dCBoYXZlIGl0DQo+IHlldCkgd2hlbiBhZGRpbmcgYSBHUElPIGNoaXAgd2l0aCBhIHN0YXRpYyBh
bGxvY2F0aW9uIGFuZCB3aGljaCB3aWxsDQo+IG92ZXJsYXAgdGhlIGR5bmFtaWMgYmFzZS4gQ2Fu
IHlvdSBhZGQgdGhhdCBpbnRvIHlvdXIgdjI/DQo+IA0KDQpBdCB0aGUgdGltZSBiZWluZyB3ZSBo
YXZlIGEgd2FybmluZyBmb3IgYWxsIHN0YXRpYyBhbGxvY2F0aW9ucywgDQphbGx0aG91Z2ggdGhl
aXIgaGFzIGJlZW4gc29tZSBkaXNjdXNzaW9uIGFib3V0IHJldmVydGluZyBpdCwgc2VlIGNvbW1p
dCANCjUwMmRmNzliODYwNSAoImdwaW9saWI6IFdhcm4gb24gZHJpdmVycyBzdGlsbCB1c2luZyBz
dGF0aWMgZ3Bpb2Jhc2UgDQphbGxvY2F0aW9uIikNCg0KQ2hyaXN0b3BoZQ0K
