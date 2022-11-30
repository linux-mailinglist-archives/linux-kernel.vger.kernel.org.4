Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B563D1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiK3Jbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiK3Jb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13025288E;
        Wed, 30 Nov 2022 01:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669800684; x=1701336684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TT7L0XdLW/CWHw8vL3+dJ2O7O5cRfmle+DCm8jMTmD8=;
  b=f0k47oxoBrCh6uFSYeK8mkD8QjPOfc3TKoky3w440qpdi0DT/1kZwn8E
   4rcuZNxxQ8UquilGxUYCk9h1hEoFJVitwz3gL1GkshNstWfDD5jGeeJXE
   /ZGIlGXkrxHxTyH8KskVytfUykOGbQmt6pEkZNjvI46ioGGu9uBRgrv1C
   DCaOTazvJUHwWRkFwOyPrl0hFj5aop276drJ/Iramjp7TJVm8HdqRP3sp
   3RMz3a+iEY9mzvM5FXpG5ljDMjn1HyMRSdmnvQShIzqgaEKSMx7+KiENr
   bkYnmWhag2OuQ8GbFZxcxv4JBlZqiPRh0g9YNupUCP31AUFHeYuZiX3pu
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="191112877"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2022 02:31:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 30 Nov 2022 02:31:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 30 Nov 2022 02:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=merHmsyJMmXo49T4QHLIZgsIEIbhxDCL6u46jBlZKtlOI9RyElxLva4Zt+H4+a5aFBwJSJlawANEnzp+7ZA5P1ReUGJD9a/EeNJOnnHxrIl3PyUDqpC6sHkOxNdN4DfFRUyhJtt6T66assrYfJQNgBFYLCm5dSdzeZ/4qEhiWymcy39BqyLqOKNloF0cU/KQ5+XWprRMoj2hatb/KDr1MER4fXDHAoLY9Edcyi9kefq7ZsnameeacakadFfwBvIsXu//a8JKJNhCIYr9s9xWrn2hHAPODCBZfRnqU4CEsIHFINPI9H35Fa3ary6ShNSkPNvpg+qsAfYfeUI0onoTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT7L0XdLW/CWHw8vL3+dJ2O7O5cRfmle+DCm8jMTmD8=;
 b=S3GS/8ID3k+k0PSBPp09rp9mQV6V2H2XoNylxGty+DYC+LpLcCP9RKkvcbIXzIaGB4s1Omf1iBi/09K2QbkP1+DCDSYMD/URx4G9mz1RBe811qKd/MVsiFe3SknYo5DfGHCkWJ45YfTcpSsL4L/BvkE4Y8NqdFyyqe9vdtDIgktiOk1wuJIQmvzEorbSWtGIFjRcucN3zKOGWKJalKqZLMd2PS8yPpr9VJAtvsJDrdjQmKikg41whNoJcIetkON95wzRxj/gGMQKHnD3xo4ONkVjVcJ/5V2kCXLS2T6KEL5eHWj0L9vRnMtkFnYb3bh+UUquUHa9VzZhlEPOdqgU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT7L0XdLW/CWHw8vL3+dJ2O7O5cRfmle+DCm8jMTmD8=;
 b=uvX173mT2syeEL3+Yknk3GE8qtnwKR/jJkFepjKiwjWZ5PBy24KvaihK7rB9Z1lgWnFhBYfG3hSs16xoc8t376XLi2pmpbab0FlgRCg0qnjORMBvChsLBY+4zSM882Vkhn49zgq8KAYTFg+r4jOuG7xWhIEhAixMw+znG41RwiU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 09:31:20 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 09:31:20 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jiajie.ho@starfivetech.com>
CC:     <robh+dt@kernel.org>, <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>, <kernel@esmil.dk>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Thread-Topic: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Thread-Index: AQHZBIAP/gm/rABRl0G/ucRICubdnq5XM+2A
Date:   Wed, 30 Nov 2022 09:31:20 +0000
Message-ID: <1673ef8b-179e-3b03-b3f8-8d347c70d8c3@microchip.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-7-jiajie.ho@starfivetech.com>
In-Reply-To: <20221130055214.2416888-7-jiajie.ho@starfivetech.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH0PR11MB4871:EE_
x-ms-office365-filtering-correlation-id: 03a06994-bf0b-4fe7-1f5e-08dad2b5a3be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2L2CNPL+Ud/Ic/u/IsbM2bxapwHoo6eeJukFsvtGpjo2/QKwTnQ6ZF1WL/G6Xnn+pdXmGccYXFH5Z/BjMWnDkA/pEvhN5dzHvYW4pYtOgACcylcU3D6CxorCHWUqr7PVWs3nsrEGp0YihcEucHvPL/AEcSlKGiaUrDjw/TJo8chIoCtRx7w0X7vy4pTNfg8kfCMeEUc1UV7a0/TB5b4OeHEVMC0Z/qMJaJbHKm0DCfQXyUomLEaBIVhNemA5ANH02d1b8VAT49582UV3njjiBjXsiHYAKz3loJBDPv5agcHBYVssiTC+kGhNnjQY4UzaypSCH8YnbnhMm3QD7zw3XQjxF6kfSejbI+ozgmkKd1zRIonRV+zKlCbgWp367uwSmH8ak97+wlc3V3Ml2Ziz/WLVHwADmnKsmGb9LEvGf/5m9VzawysKN1rRC+Ojdy1DWu4d/UhE7lFdXqLj3pcuEpnfYXHYkY4wd6J1N9SpvyUf/lqpBLSuaFL/CMqFmr17ZjnFYVOsfekY98aSX+4kgLLOj9qh9oZlJzi7wxwtEF9ZsHkll0srMkyZcwBp1SPLwvYa9ZnmV0bE+Xl8p1B3fCXHrbqgEs6slU5F7iXMzEt8wsMmFA5I4pd0Fg0bNSV0+JC6fwUcid69pd8BPwAPjrV8qWk9Noc7FDsxhvIitLXNDwT38kl9XchopcJvv0MlP0X7aSYC0Ww6B37uvnLyd3Fq1u+BvWiufqzFQpF1/47vhG5/MXhW7HHTluUUlFRp3lCAu3fcFmP8yy1XAIaTMxbGBqDGnnOKsGI/R4F3HKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(2616005)(186003)(31686004)(316002)(86362001)(478600001)(6916009)(54906003)(38070700005)(31696002)(36756003)(83380400001)(38100700002)(26005)(6512007)(122000001)(6506007)(53546011)(6486002)(2906002)(66946007)(966005)(91956017)(66446008)(8936002)(4326008)(41300700001)(66476007)(71200400001)(5660300002)(8676002)(76116006)(7416002)(66556008)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmE3d2xrMFJKVnA2RmxKN2ViNGs5SGk1RkUyWmc2S2R0aWV6cXNyNlgxWm9D?=
 =?utf-8?B?U2RJNU5xam5TL29jWlZITGZldDBpUjlpNG1pZGdLVldkRkN5c01iNUp0Mjcw?=
 =?utf-8?B?QWdwT2Z6eUw4cndpcVUyK0VxRnM3T2ZqUW5JWnFSOFVGQTNjeXlQS2NyY3Az?=
 =?utf-8?B?bVowN2ZpUTArd1BZRzByWi91NTYwWWx0NnkreEY0elVidnVmaUg5MEY2S01T?=
 =?utf-8?B?eSswUlpRaW1IM01zL1BQSXBBejRhNkVoYVkzRVkyTURaQm5NR0Z2cDM4a3Vv?=
 =?utf-8?B?UncwbXRZbHc3UjlEcitLMVlsWkJWWjZZZmJpS3JlN09wcmM1M1pubXh6dVVG?=
 =?utf-8?B?dDVTMnJWTEppZGh3dmVBNE92MkdGdUF0cVlKNXg0WGsxRXhmLzdnZjY1Skdn?=
 =?utf-8?B?R3ZqeWpubUhJaFlhUFJqWERGMkg4emhzaHFjcVczTWpoMklHQXZBZG16V2gv?=
 =?utf-8?B?K1JSVmdNUmNYbitQV0d2V2NlNEc5Y0pQcE1QVTJ2S09vOVFwVHFVMDNGMGx3?=
 =?utf-8?B?aEN6akRsWFVML3BMV3Y1cWMwS2pOQnY1SGVaZitlWkREd0JTQTU0bk94ejhE?=
 =?utf-8?B?Qi9sbU4zMWUxbE9PRnVNWEZzcWlBNlFkWkNxbS9uL3FzNThIaGVNeW9QNzRy?=
 =?utf-8?B?RlFKKzhwSmFrdXRMblJCbElHRUR2NkxoYm9obENkck9ZV1ErWTQvSmMrdmNE?=
 =?utf-8?B?MHpGSVJob0hieHZIeGQvOE1tVG1oSkUxZk0rbTMySTFOOW0xRHVIOGloOU96?=
 =?utf-8?B?cXpabzVvS0o4VEE2elcwUzVIQ0lkcHUwZzd2VkVLM1F2ZDBxQTdPbDROTmJw?=
 =?utf-8?B?QTVyeitnaEovaVorcmVKTVd6azhPZFNuL0lmRllCN3hGbURVMzNPRUlrc2NK?=
 =?utf-8?B?Nnl6VHVzQUhuWlJLZjBpZU5ibTA3YjM2eU4xaDBKSnBLbUtLcmxNNDZ3T0hn?=
 =?utf-8?B?V3ZabEU0OVgxWHNnQnlGNzJqeGhHaWRlR0V3L3RsbjFZSCtPRzM4OGtUVENs?=
 =?utf-8?B?RVZ5d3EzOC92RzRwdWJ6bk03R1hDR044OVAvMzBxUkJIWDQ5WDAwTktFcVZM?=
 =?utf-8?B?UHZyWmV4YXRoZE1IQkEvamZZSiticE5SQS9zRnFJWi85Vm5USHE3UWJ5MUFT?=
 =?utf-8?B?QVpkakNYN1JwMnZJZXU3N1phVFJ2aDdScGNJeWY2RkJMaWNxOE9Gcys0L1J6?=
 =?utf-8?B?bHoxQ1hSRDNKNlVHMCtpdDF1WXlFaStRODdjYXBpME1IRGQ5OXk0NDBsWUVE?=
 =?utf-8?B?R1oxN0h2dytTZWRkUHFVQ2ZWK3hTbVdod3ZGOE1ZYW4wSXljRnUwang5eFpo?=
 =?utf-8?B?L2xzMFlJRzNiSUNkYnZiU3FvbWtXb2dKc0RSU2V1eXp5QzdSd012MTJJa3lt?=
 =?utf-8?B?NjgyRjA0Z1hpcHdGZElmTzdCTHcvQ3FSdDZwc2ltcXdma24vdlluVkUrOEVK?=
 =?utf-8?B?QXlDQnM1KzBLV3Vhdk9XTGZQbi9aWHl6ZEJiN2FZYld6NlVwaDExVmdFaFEv?=
 =?utf-8?B?MmxPeHF0L05ReUFSOS9wU2k5b2puWU03ZkpCZjRkeEU4YlNUS09GRWZBdytJ?=
 =?utf-8?B?MG44TjRLd0loK1JnOWovSE9STkdTOUZpb0ltcEp1MDEzMFVsZnlxWEx4L1l2?=
 =?utf-8?B?L3NjZzc4RHlrRld4NElPTU5tUXV2ZUlnV2ZsS2duZmZUZVM4MHpteVJTUmtS?=
 =?utf-8?B?TGRweVgzVjlIU1VZZjQwY3loQmt6UlNkOWMxalBKclZGWGhHNTJ1bWVVVi8z?=
 =?utf-8?B?WVdIaVZlMWdac2EwT1V3cTM3MWgwdDNxb3JTNlFBbEtUY2tSckh4MkFiNnFS?=
 =?utf-8?B?cTBOeWRiY2QvSzc0cmhveEE4SUhMc0Fkcm9qQjRXVmpKcUhDdTJHbytLOWpM?=
 =?utf-8?B?Tk1Mc3ExblNaNmFrYlk1emRmV1A0amQ2ZDRzNjl4WmU3NUJCb3hmeGU3QURZ?=
 =?utf-8?B?M0tIUTBMdW90bm50MGtUaTk3V1hydlMyZkpNaVRLQnE5a1FrcExxT0tQekc2?=
 =?utf-8?B?SVJTTUJWSEdzMW1VU3JCbFJXU3NNVEFvRWJoMUkrWXR2N0czNGs1QmU3Vk1U?=
 =?utf-8?B?VVVrWVRxekJ3S1NIOC82TGRSWUFYd1BMK1F4empFNGkrRU04MU5XTFdUTFpk?=
 =?utf-8?Q?L9KKQ2uY0i0u+RnsFlBPGyaU6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE7758849522CB4A9EB55FE9724A61D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a06994-bf0b-4fe7-1f5e-08dad2b5a3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 09:31:20.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7lRInTD3avPiXQ2oRXf422TdoaW/Fs+LH/Ejd5jVKLEJ0Db1Vb+ADqSO2tiBEEmUhskMByC9a7Kk1QAuG0bo41M/hZ2zKVoJP1OQvF4f6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEppYSBKaWUgSG8sDQoNCk9uIDMwLzExLzIwMjIgMDU6NTIsIEppYSBKaWUgSG8gd3JvdGU6
DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gamlhamllLmhvQHN0YXJmaXZldGVj
aC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFy
bkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlDQo+IA0KPiBBZGRpbmcgU3RhckZpdmUgY3J5cHRvIElQIGFuZCBETUEgY29u
dHJvbGxlciBub2RlDQo+IHRvIFZpc2lvbkZpdmUgMiBTb0MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBKaWEgSmllIEhvIDxqaWFqaWUuaG9Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogSHVhbiBGZW5nIDxodWFuLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCg0KT3V0IG9mIGN1cmlv
c2l0eSwgd2hhdCB3YXMgSHVhbiBGZW5nJ3MgY29udHJpYnV0aW9uIHRvIHRoaXMgcGF0Y2g/DQpE
aWQgdGhleSBjby1kZXZlbG9wIGl0LCBvciBpcyB0aGVyZSBzb21lIG90aGVyIHJlYXNvbj8NCg0K
PiAtLS0NCj4gICAuLi4vamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtdjIuZHRzICAgICAgICAg
fCAgOCArKysrKw0KPiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kg
ICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysNCg0KSSBmaWd1cmUgRW1pbCB3aWxsIGxpa2Vs
eSBzZWUgYW55d2F5LCBidXQgd2hlbmV2ZXIgeW91IGdldCBhY3R1YWwNCnJldmlldyBjb21tZW50
cyBhbmQgc2VuZCBhIHYyIC0gcGxlYXNlIGRvbid0IGRyb3AgcGVvcGxlIHRoYXQNCmdldF9tYWlu
dGFpbmVyLnBsIHRlbGxzIHlvdSBhcmUgcmVzcG9uc2libGUgZm9yIHRoZSBjb2RlIGluDQpxdWVz
dGlvbi4NCg0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZp
c2lvbmZpdmUtdjIuZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3Rh
cmZpdmUtdmlzaW9uZml2ZS12Mi5kdHMNCj4gaW5kZXggNDUwZTkyMDIzNmE1Li5kYTJhYTRkNTk3
ZjMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0
YXJmaXZlLXZpc2lvbmZpdmUtdjIuZHRzDQo+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3Rh
cmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtdjIuZHRzDQo+IEBAIC0xMTUsMyArMTE1
LDExIEBAICZ0ZG1fZXh0IHsNCj4gICAmbWNsa19leHQgew0KPiAgICAgICAgICBjbG9jay1mcmVx
dWVuY3kgPSA8NDkxNTIwMDA+Ow0KPiAgIH07DQo+ICsNCj4gKyZzZWNfZG1hIHsNCj4gKyAgICAg
ICBzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmY3J5cHRvIHsNCj4gKyAgICAgICBz
dGF0dXMgPSAib2theSI7DQo+ICt9Ow0KDQpJbiB3aGF0IHNjZW5hcmlvIHdvdWxkIHlvdSBub3Qg
d2FudCB0byBoYXZlIHRoZXNlIGVuYWJsZWQ/DQoNClRoYW5rcywNCkNvbm9yLg0KDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpIGIvYXJjaC9y
aXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAuZHRzaQ0KPiBpbmRleCA0YWMxNTlkNzlkNjYu
Ljc0NWE1NjUwODgyYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2
ZS9qaDcxMTAuZHRzaQ0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEx
MC5kdHNpDQo+IEBAIC00NTUsNSArNDU1LDQxIEBAIHVhcnQ1OiBzZXJpYWxAMTIwMjAwMDAgew0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnLXNoaWZ0ID0gPDI+Ow0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gICAgICAgICAgICAgICAgICB9
Ow0KPiArDQo+ICsgICAgICAgICAgICAgICBzZWNfZG1hOiBzZWNfZG1hQDE2MDA4MDAwIHsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0scGwwODAiLCAiYXJtLHBy
aW1lY2VsbCI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGFybSxwcmltZWNlbGwtcGVyaXBo
aWQgPSA8MHgwMDA0MTA4MD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAg
MHgxNjAwODAwMCAweDAgMHg0MDAwPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnLW5h
bWVzID0gInNlY19kbWEiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0g
PDI5PjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZzdGdjcmcgSkg3MTEw
X1NUR0NMS19TRUNfSENMSz4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwm
c3RnY3JnIEpINzExMF9TVEdDTEtfU0VDX01JU0NBSEI+Ow0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBjbG9jay1uYW1lcyA9ICJzZWNfaGNsayIsImFwYl9wY2xrIjsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmVzZXRzID0gPCZzdGdjcmcgSkg3MTEwX1NUR1JTVF9TRUNfVE9QX0hSRVNF
VE4+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXNldC1uYW1lcyA9ICJzZWNfaHJlIjsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgbGxpLWJ1cy1pbnRlcmZhY2UtYWhiMTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgbWVtLWJ1cy1pbnRlcmZhY2UtYWhiMTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgbWVtY3B5LWJ1cnN0LXNpemUgPSA8MjU2PjsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgbWVtY3B5LWJ1cy13aWR0aCA9IDwzMj47DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICNkbWEtY2VsbHMgPSA8Mj47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ICsgICAgICAgICAgICAgICB9Ow0KPiArDQo+ICsgICAgICAgICAg
ICAgICBjcnlwdG86IGNyeXB0b0AxNjAwMDAwMCB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3MTEwLWNyeXB0byI7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJlZyA9IDwweDAgMHgxNjAwMDAwMCAweDAgMHg0MDAwPjsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gInNlY3JlZyI7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGNsb2NrcyA9IDwmc3RnY3JnIEpINzExMF9TVEdDTEtfU0VDX0hDTEs+LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnN0Z2NyZyBKSDcxMTBfU1RHQ0xLX1NFQ19N
SVNDQUhCPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAic2VjX2hj
bGsiLCJzZWNfYWhiIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVzZXRzID0gPCZzdGdj
cmcgSkg3MTEwX1NUR1JTVF9TRUNfVE9QX0hSRVNFVE4+Ow0KPiArICAgICAgICAgICAgICAgICAg
ICAgICByZXNldC1uYW1lcyA9ICJzZWNfaHJlIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZW5hYmxlLXNpZGUtY2hhbm5lbC1taXRpZ2F0aW9uOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBlbmFibGUtZG1hOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBkbWFzID0gPCZzZWNfZG1h
IDEgMj4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnNlY19kbWEgMCAyPjsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZG1hLW5hbWVzID0gInNlY19tIiwic2VjX3AiOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArICAgICAg
ICAgICAgICAgfTsNCj4gICAgICAgICAgfTsNCj4gICB9Ow0KPiAtLQ0KPiAyLjI1LjENCj4gDQo+
IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBs
aW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJp
c2N2DQoNCg==
