Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0463A6BE75F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCQK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCQK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:57:44 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2130.outbound.protection.outlook.com [40.107.135.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25BD10DE40;
        Fri, 17 Mar 2023 03:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NifCIfMMnjaLkOR/QddqL7me0u905cfD4co8+I1IDeftNGwzgINmFi4kp8eq8fZwYa4KgSKopKjos01wMHjmDJmpj9MH3RmoDedQeBy3X9FJcUrdj5bNWI17c4JoPL4u5dYgrO6glrx0mCiAi1jExfOQCWSr3HfRjOeNX5PII8uNU7/Mrgpv56C6V/+Q5szMKcr2einfCV2MP1fN6o6E4doEEDBuYwVCFPr3bwLB4zTIJOjxBYCixntuNlvmwHIwYQh/XHmU7YXPKq5LrEPoGlks3Jc/Px+8oneV4SoJJtggZwwtRsX49/3A3N7JzNdVTuaoY/9r0aO4nlN/P49oQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLz0Bcrg4MB6IFeQg2+LqqES5AL/k42jOsnaIOa0mNw=;
 b=isSyuko8gu2bHw+K64WwvedDee2a8MyXwir/hq/DXFli4D9P+m0r/ZLfSUeiYrlVbUcZu33lUUMLyyx/H/CvYJ615EUdGTsKNXqIGa0EwgC7dcJvzkiioSvXn7f2PLNb+4jmzvxg41RMASvPJPY+TNtUAhwh/3ELeV/tw1xB+dRyAJwz8pWySroIV2s6HpZXfBrkSIQmwmyy0uWev+RqcOI+3gjJxyVGBGmSViOCOsjlc/opo/13/E/JBmzYX0ucq95DttXnDy+2lR6+KQix1xkwB3Jx3kz8v6dxu/hxSVIw9m/EH0BynXzOHlkOLVlxhLPcsuG8ri2X6egoxyfIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLz0Bcrg4MB6IFeQg2+LqqES5AL/k42jOsnaIOa0mNw=;
 b=UOJzPkUvj/P9CAuPHktLTBHM36+1cOl8MdpjazQIY7bSeF5CXvUdOgu00lKV/ltJlBYDOisY0kF6XXZjPN/iFi1SxPJPwLnhiNbIXGTRilWb+8pAjx64/6ByQ6BQrCkhku5EOuaQqNkqtn17i/l8ufgvXQ/yeIPBWQax5gfue7M=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BEZP281MB2552.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 10:57:35 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%5]) with mapi id 15.20.6178.029; Fri, 17 Mar 2023
 10:57:35 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Thread-Topic: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Thread-Index: AQHZUAx6fUf10mXfYki+7tKCTx+0v673aeoAgAAAmwCAAUd4gIAACKoAgAAE5wCAAAiBgIAC8AYAgAMb3ACAAAqFgA==
Date:   Fri, 17 Mar 2023 10:57:35 +0000
Message-ID: <8912d34b-ae45-d62f-6d39-a52cf76df098@fi.rohmeurope.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei> <20230312170848.651b5b2c@jic23-huawei>
 <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
 <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
 <ZA8lNBPCB4BNnfUq@smile.fi.intel.com>
 <39a7b489-4856-8dc1-d0a6-f27d0c1324a2@gmail.com>
 <a41874be-f0bd-1570-8a4a-5b28079b9fed@gmail.com>
 <20230317101956.ebe4bhpwybjhvsq6@houat>
In-Reply-To: <20230317101956.ebe4bhpwybjhvsq6@houat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BEZP281MB2552:EE_
x-ms-office365-filtering-correlation-id: 3a286f55-d398-45b4-db75-08db26d66a99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5AwyzBfd+Zm9oPMoVXKn8rJFo42LyqVNxTxqLYgfxo4/Gpj8J/NADgfB2ht3JQVe7+d5OwwBWD/PSc7dfL0hmNFOFt/tMAe0q71jfLlRqTEAJS0MkvAmkC6wznkGMx1j7+K9nhUhF/KPG4xBPJ94Wd6HB6exIM9bGPiuoXyEYVgMGyHR9BzzvItIXx0y7fqZQmVj+XFnj2KO5lvLI0ht4miZNSlzE3tfT/0Z5Lfg/1ii6iGD35q3NTGnUxcNY74R+TD59XxJn5vefzMAYaB1IQqQZ0D6fazy4FN+Vb4Cc4LPVfGB3UW6r2e+ofw4yETKpyXukjrXA2J7zYZv2JXcHrnj8ux3+hTLXG1Pk91zakTBIuMVbXk0jMiTj5dQoyivyD89dHYjBSImpcLb5jNC24NyvP2W0lA/hRrmmyIzhAUeiKhqBnh3lA8o0P9mvkakCdIslx4FUGFkIgTzT9BHCjFAKwl77R3DfElFp+nvANUf76ukqXisEhd30vN0djeHjU1ul3VRr6LobW+a5akT02/LRG7lmt1MSmXQ2Hs3MYzXwQ0eYLPqyD+BEOJYtsWATldqqAWyDwXd3Ag6EAlFu3e7ADlls4kKYSABN3v7IjLs+Fnys6jTcROUjukmxE9v02RGVUv97h2ji1jnO0La7ueiPiyiQ6HeJGhtDbqTnhZkn89KMGPUIVoBT8sP2kO6NtQ6e8J2RJ2YKa51zbFZZWTV+vBpKxxSq9U79v8HDLimF/ZYygoYxtgJZ7f9d7fX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39850400004)(136003)(396003)(346002)(376002)(451199018)(86362001)(66946007)(66476007)(64756008)(8676002)(66446008)(76116006)(2906002)(41300700001)(66556008)(4326008)(38100700002)(122000001)(7416002)(31696002)(8936002)(38070700005)(5660300002)(6486002)(26005)(6512007)(966005)(2616005)(186003)(53546011)(54906003)(83380400001)(31686004)(110136005)(6506007)(316002)(71200400001)(91956017)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVUyMTI3TWl0Z3NLc3dqeHFYNGtQOUxEeXRtNGxWMXhsaC9PZUN3dnkzT2JX?=
 =?utf-8?B?Um84Z3lWTnBRYUVBMEdOdXljRWI0UDNvT1RacENpVE9iU1JmMXh3NVZPbDlz?=
 =?utf-8?B?bDBpenRxQ0JnSDJrcFNvRmVrWStvYmFQOHYza2MxekRlZENwME9YWDdZT2Rw?=
 =?utf-8?B?ZGtFeE1hZnNqYldiQVg3NkwwTjdwbno2djh0cURBcGhaaFpBRUsvOVgvSkN2?=
 =?utf-8?B?V1czZUJqQmIvRk9ZaWthVUxmbDRJOWQyRVloUGdGVzBnY2t2MDdQZHowQWpF?=
 =?utf-8?B?T2ZJa2tjNTRTb29waUwzME5HTEZVekNpSmpudms0bkNSTEkzSkVuMjRleW1M?=
 =?utf-8?B?RGVWSW55Yy9SMENUY0JNc1RVRGx3OUxLQ3ZaL2lQamtnRU1PRUpZOW80Skoy?=
 =?utf-8?B?UVN6L1IwOVRFS0xJSVROcXRvcVhkSEJxYnhwTlJyVlRxbCtLV1JCQU5UTU5K?=
 =?utf-8?B?RmtQQkdnUUlyaEc4NGpYenhDWUNLYk9uZC9VUzRuM1VhN2doR2V6WFBoUkNm?=
 =?utf-8?B?TkMwSE5mYWV2YmdwU0dUSVdKVmJmdlB3b0piUE11cjJxL1RmOEI4cjN1dmdo?=
 =?utf-8?B?eFRYQUlhK1NHeFBFQmRZWXdCWCt0SzZiRHdjejJLaGNHWHNqY0ZWWTVVcFlT?=
 =?utf-8?B?Zzg4cE5tOEc1OGY1RGh3UHB4VTg4Y0V1OWVtSzVtWFh6N3IrclQzc1pMelNW?=
 =?utf-8?B?bGtZeHUxM1l5SmNjVmhXL0w2ejBTMWptc0daWmZ6ancxWlFaWlJTeHp0RjdX?=
 =?utf-8?B?K25hY2czaWRJUVpIcjQ1b1lTRG05N1NiZUJ1WWcvV1loT0RrNlF2UVRZY0xr?=
 =?utf-8?B?eWFTakNnSmY3VlpHQUZXNjZTbzFGK2xMLzVBZjI1elJyYzJHYjhkQ3V6M2oz?=
 =?utf-8?B?MkdHN3ZZanJYd2R0aHlSOGp2MjNzNER2NHF3UzVyUVR3amtySU5oY0RNckxC?=
 =?utf-8?B?WWk2NEx2OWw4YTZWT1g1aUgrdXJuU2pHRjVDODNNQWEvS2xpa0NaaTlkNzc1?=
 =?utf-8?B?QVdSTDFpUlB1QWVHMjJyaDR1SjFNaStjMTJ5TXNsMDFkYWZFNVFIaGpGUk84?=
 =?utf-8?B?OWxTM2VRTi9zc3Y1Q0NEdk9QWFA0S1hSaGgybE5qMGliNjQxU3ZzWHNCT3ll?=
 =?utf-8?B?ZXJxdithQTNETDNpNzZiOEliaTJrWG9pV1F5RlZ1eEh0S1hnZWpjZ2Zzc09a?=
 =?utf-8?B?a05hTXhkMFNmajMzZXRoZDd0ZDIrVFBQRmVYdmkvNmdtdG9MdDlxazBaSGlo?=
 =?utf-8?B?L2RjSk8yay9FbGhZWHk0eFAzeXYxQ0tVWHd4M29pdkVFU3ZxMUJSdUh0Qnh3?=
 =?utf-8?B?M2xhVnJ6ZEFLYzlHNkRuWUw2WUFPU1hKbkpaNnoyZXIxVkUrOUYwNWM2Q05R?=
 =?utf-8?B?K3ZpeTJhblI0aVNsbzZzTXlORlc4d0xCTnV5eXM2QWpXRlNRVUJnYWxIY3JR?=
 =?utf-8?B?Y0plWTRBTHZTZEtBUTVqVnExdFRyOTQwRTg0ZURMS0pmM21HT0VucGZhSFdk?=
 =?utf-8?B?SjkzT0M3MTBSQndZdzNwTk1EZWl2enRqWEZ3M05rZWlzQWtWK0h1WVF4dDdI?=
 =?utf-8?B?dDVLQmpXV2V3azNvOEZWV3JNbVlmaG42SWZtMysxSEV2VzZzcWFkZWZZR1lz?=
 =?utf-8?B?NGlrcjE0cDYyTm9uUzZERSt5anpRWXpyMDN2VC9EV2NQUFNjQ1d0ZkUyS0t0?=
 =?utf-8?B?cVVkOEJRa1FZcGlYMTRIOGdBaWpXeS9KZjFodkZhNUhJRHo4VFVza3pNTWt5?=
 =?utf-8?B?VC9VdDZkWWE5aVA0VWliWmI1TUNYVy9BN3FDMjR2M09EYi9LZDNyamJwNkFT?=
 =?utf-8?B?Uy9RL3FXNjV4NzM2R3hyZ0NSd0hnSTFtZ2pyeHRGUVhoaE9WUGd5bEIwWFdJ?=
 =?utf-8?B?U0NGeDkxM2IyYVJ6UkRGeDB3cEtUVFNkL3VWZldGZVFLaGFxQTNIci9vVklN?=
 =?utf-8?B?Zi93bUkvT2dTeFpiQ1U2Qkc2VzRSVTdPYjFFbE5jNDF2MGJmOHdVV0UySWpY?=
 =?utf-8?B?U1Q3bkpKZU1VYm1vbG05bjFZMmdnbzRnalk4QTJLdWNIek83SFFCQWE4bEVR?=
 =?utf-8?B?MGtXM21mV3lObnppRzhuaGtqdjExZVFVRzQwcmFrY2k2L21SU0lCOXE0T2Vq?=
 =?utf-8?B?QnljWG5JRXVKZXk0cGRTQ2JXSC9uK1oySzM0T3hNak9lZ2tINk4zSmxkbmFO?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEE11F7B43C0B542A29C2D289D4D3EC0@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a286f55-d398-45b4-db75-08db26d66a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:57:35.5913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwegVS/ZM2bCGvPQY4s/cSBgNmqb18jzw54HKt5CLibElIcJgpAkYZUbabnbMqqIWY8O8ndX6fdVwFaESoLOu9PcbFrZ25UAEjxB09lZrQaEKO81WIDeVBeBR66EMqlb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2552
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNy8yMyAxMjoxOSwgTWF4aW1lIFJpcGFyZCB3cm90ZToNCj4gT24gV2VkLCBNYXIgMTUs
IDIwMjMgYXQgMTI6NTE6MjZQTSArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4gT24g
My8xMy8yMyAxNTo1OSwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4+IE9uIDMvMTMvMjMgMTU6
MjksIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4gT24gTW9uLCBNYXIgMTMsIDIwMjMgYXQg
MDM6MTE6NTJQTSArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4+Pj4gT24gMy8xMy8y
MyAxNDo0MCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+Pj4+IE9uIFN1biwgTWFyIDEyLCAy
MDIzIGF0IDA1OjA4OjQ4UE0gKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+Pj4+Pj4+
IE9uIFN1biwgMTIgTWFyIDIwMjMgMTc6MDY6MzggKzAwMDANCj4+Pj4+Pj4gSm9uYXRoYW4gQ2Ft
ZXJvbiA8amljMjNAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+DQo+Pj4+IC4uLg0KPj4+Pg0KPj4+
Pj4+PiBBaC4gSSBmb3Jnb3QgdGhlIHRlc3RzIHRoYXQgZG9uJ3QgaGF2ZSBhIGRldmljZSBzbyBj
YW4ndCB1c2UgZGV2bS4NCj4+Pj4+Pg0KPj4+Pj4+IFdoeSBub3Q/IEkgaGF2ZSBzZWVuLCBJSVJD
LCB0ZXN0IGNhc2VzIGluc2lkZSB0aGUga2VybmVsDQo+Pj4+Pj4gdGhhdCBmYWtlcyB0aGUgZGV2
aWNlDQo+Pj4+Pj4gZm9yIHRoYXQuDQo+Pj4+Pg0KPj4+Pj4gSSdkIGFwcHJlY2lhdGVkIGFueSBw
b2ludGVyIGZvciBzdWNoIGFuIGV4YW1wbGUgaWYgeW91IGhhdmUgb25lDQo+Pj4+PiBhdCBoYW5k
LiAoSQ0KPj4+Pj4gY2FuIGRvIHRoZSBkaWdnaW5nIGlmIHlvdSBkb24ndCB0aG91Z2ghKQ0KPj4+
Pj4NCj4+Pj4+IEkgYW0gbm90IGEgZmFuIG9mIHVuaXQgdGVzdHMuIFRoZXkgYWRkIGh1Z2UgYW1v
dW50IG9mIGluZXJ0aWEgdG8NCj4+Pj4+IGRldmVsb3BtZW50LCBhbmQgaW4gd29yc3QgY2FzZSwg
dGhleSBzdG9wIHBlb3BsZSBmcm9tIGNvbnRyaWJ1dGluZyB3aGVyZQ0KPj4+Pj4gaW1wcm92aW5n
IGEgZmVhdHVyZSByZXF1aXJlcyB0ZXN0IGNvZGUgbW9kaWZpY2F0aW9uKHMpLiBBbmQNCj4+Pj4+
IGhhcmRlciB0aGUgdGVzdA0KPj4+Pj4gY29kZSBpcyB0byB1bmRlcnN0YW5kLCB3b3JzZSB0aGUg
dW53YW50ZWQgc2lkZS1lZmZlY3RzLiBBbHNvLCBoYXJkZXIgdGhlDQo+Pj4+PiB0ZXN0IGNvZGUg
aXMgdG8gcmVhZCwgbW9yZSB0aW1lIGFuZCBlZmZvcnQgaXQgcmVxdWlyZXMgdG8gYW5hbHl6ZSBh
IHRlc3QNCj4+Pj4+IGZhaWx1cmUuLi4gSGVuY2UsIEkgYW0gX3ZlcnlfIGNvbnNlcnZhdGl2ZSB3
aGF0IGNvbWVzIHRvIGFkZGluZw0KPj4+Pj4gc2l6ZSBvZiB0ZXN0DQo+Pj4+PiBjb2RlIHdpdGgg
YW55dGhpbmcgdGhhdCBpcyBub3Qgc3RyaWN0bHkgcmVxdWlyZWQuDQo+Pj4+Pg0KPj4+Pj4gQWZ0
ZXIgdGhhdCBiZWluZyBzYWlkLCB1bml0IHRlc3RzIGFyZSBhIGdyZWF0IHRvb2wgd2hlbg0KPj4+
Pj4gY2FyZWZ1bGx5IHVzZWQgLSBhbmQNCj4+Pj4+IEkgYXNzdW1lL2hvcGUgc3R1YmJpbmcgYSBk
ZXZpY2UgZm9yIGRldm1fIHRlc3RzIGRvZXMgbm90IGFkZA0KPj4+Pj4gbXVjaCBleHRyYS4uLg0K
Pj4+Pj4gQnV0IGxldCBtZSBzZWUgaWYgSSBjYW4gZmluZCBhbiBleGFtcGxlIDopDQo+Pj4+DQo+
Pj4+IGRyaXZlcnMvZ3B1L2RybS90ZXN0cy9kcm1fbWFuYWdlZF90ZXN0LmMgPw0KPj4+Pg0KPj4+
PiAoc29tZXdoZXJlIHVuZGVybmVhdGg6DQo+Pj4+DQo+Pj4+ICDCoCByZXQgPSBwbGF0Zm9ybV9k
cml2ZXJfcmVnaXN0ZXIoJmZha2VfcGxhdGZvcm1fZHJpdmVyKTsNCj4+Pj4NCj4+Pj4gd2hpY2gg
c3VnZ2VzdHMuLi4gd2hhdCBleGFjdGx5PyA6LSkNCj4+DQo+PiBUaGFua3MgdG8gcG9pbnRlciBm
cm9tIEFuZHkgSSBmb3VuZCB0aGUNCj4+IGRybV9rdW5pdF9oZWxwZXJfW2FsbG9jL2ZyZWVdX2Rl
dmljZSgpIGZ1bmN0aW9ucy4gSSByZW5hbWVkIHRoZW0gdG8NCj4+IHRlc3Rfa3VuaXRfaGVscGVy
X1thbGxvYy9mcmVlXV9kZXZpY2UoKSwgbW92ZSB0aGVtIHRvIGRyaXZlcnMvYmFzZSwgYWRkDQo+
PiBkZWNsYXJhdGlvbnMgdG8gaW5jbHVkZS9rdW5pdC90ZXN0LWhlbHBlcnMuaCBmaXhlZCBLQ29u
ZmlncyBhbmQgZXhpc3RpbmcNCj4+IGNhbGxlcnMgKyBhZGRlZCB0aGUgdGVzdHMgZm9yIG1hbmFn
ZWQgaW50ZXJmYWNlcy4gSSBoYXZlIHRoaXMgaW4gcGxhY2UgaW4gbXkNCj4+IHBlcnNvbmFsIHBs
YXlncm91bmQgd2hlcmUgSSBhbSB3b3JraW5nIHRvd2FyZHMgdGhlIHY0IG9mIHRoZSBzZXJpZXMu
DQo+Pg0KPj4gLi4uDQo+Pg0KPj4gQWZ0ZXIgdGhhdCBJIGFza2VkIGZyb20gTWF4aW1lIGlmIGhl
IGhhZCBhIHJlYXNvbiB0byBub3QgbWFrZSB0aG9zZSBnZW5lcmljDQo+PiBhbmQgYXZhaWxhYmxl
IHRvIG90aGVyIHN1YnN5c3RlbXMgYmVzaWRlcyBkcm0gaW4gdGhlIGZpcnN0IHBsYWNlLi4uDQo+
Pg0KPj4gQW5kIE1heGltZSB3YXMga2luZCBlbm91Z2ggdG8gcG9pbnQgbWUgdG8gdGhlIGZhY3Qg
dGhhdCBzb21ldGhpbmcgbGlrZSB0aGlzDQo+PiB3YXMgZG9uZSBpbiB0aGUgQ0NGIGNvbnRleHQ6
DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAzMDIwMTM4MjIuMTgwODcxMS0x
LXNib3lkQGtlcm5lbC5vcmcvDQo+Pg0KPj4gSSBsaWtlIHRoZSAnc2luZ2xlIGZ1bmN0aW9uIHRv
IGdldCB0aGUgZHVtbXkgZGV2aWNlIHdoaWNoIGNhbiBiZSBwYXNzZWQgdG8NCj4+IGRldm0nLWFw
cHJvYWNoIHVzZWQgaW4gZHJtIGhlbHBlcnMuIEkgZG8gYWxzbyBsaWtlIFN0ZXBoZW4ncyBpZGVh
IG9mIGhhdmluZw0KPj4gdGhlIHByb3RvdHlwZXMgaW4ga3VuaXQvcGxhdGZvcm1fZGV2aWNlLmgg
d2hpY2ggbWF0Y2hlcyB0aGUNCj4+IGxpbnV4L3BsYXRmb3JtX2RldmljZS5oLg0KPj4NCj4+IEhv
d2V2ZXIsIEkgZG9uJ3Qga25vdyB3aGVuIFN0ZXBoZW4ncyB3b3JrIHdpbGwgYmUgZmluaXNoZWQg
YW5kIG1lcmdlZCB0bw0KPj4gSUlPLXRyZWUgc28gdGhhdCBpdCBjb3VsZCBiZSB1c2VkL2V4dGVu
ZGVkIGZvciB0aGUgbmVlZHMgb2YgdGhlc2UgdGVzdHMuDQo+Pg0KPj4gTWVhbndoaWxlLCBJIGRv
bid0IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGdvIGZvcndhcmQgd2l0aCBteSBjaGFuZ2VzDQo+
PiBzcGxpdHRpbmcgdGhlIGhlbHBlcnMgb3V0IG9mIGRybSB1bnRpbCB3ZSBzZWUgd2hhdCBTdGVw
aGVuJ3MgY2hhbmdlcyB3aWxsDQo+PiBicmluZyB1cy4gT24gdGhlIG90aGVyIGhhbmQsIEkgZG9u
J3QgbGlrZSBkZWxheWluZyB0aGUgZ3RzLWhlbHBlcnMgb3IgdGhlDQo+PiBzZW5zb3IgZHJpdmVy
cy4NCj4+DQo+PiBTbywgYW55IHN1Z2dlc3Rpb25zIHdoYXQgSSBzaG91bGQgZG8/IEkgc2VlIGZv
bGxvd2luZyBvcHRpb25zOg0KPj4NCj4+IDEpIERyb3AgdGhlIHRlc3RzIGZvciBtYW5hZ2VkIGlu
dGVyZmFjZXMgZm9yIG5vdy4NCj4+IDIpIEFkZCB0aGUgdGVzdHMgd2l0aCBhIHlldC1hbm90aGVy
IGR1cGxpY2F0ZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUNCj4+ICAgICBkdW1teSBkZXZpY2UgZm9y
IGRldm0uDQo+PiAzKSBBZGQgdGhlIHRlc3RzIHVzaW5nIHRoZSBoZWxwZXJzIGZyb20gZHJtIGFz
IHRoZXkgYXJlIG5vdy4NCj4+DQo+PiBvcHRpb24gMSk6DQo+PiBJIGxpa2UgaXQgYXMgaXQgd291
bGQgYmUgYW4gZWFzeSB3YXkgKGZvciBub3cpIC0gYnV0IEkgaGF0ZSBpdCBhcyBpdCBtYXkgYmUN
Cj4+IGEgaGFyZCB3YXkgYXMgd2VsbC4gSW4gbXkgZXhwZXJpZW5jZSwgd2hlbiBhIGRyaXZlci9o
ZWxwZXIgbGFuZHMgdXBzdHJlYW0gaXQNCj4+IHdpbGwgZ2V0IGZpcnN0IGZldyBmaXhlcyBxdWl0
ZSBmYXN0IC0gYW5kIG5vdCBoYXZpbmcgYSB0ZXN0IGF2YWlsYWJsZQ0KPj4gdXBzdHJlYW0gd2hl
biB0aGlzIGhhcHBlbnMgaXMgYmFkLiBCYWQgYmVjYXVzZSBpdCBtZWFucyB0aGUgb3V0LW9mLXRy
ZWUgdGVzdA0KPj4gbWF5IGdldCBicm9rZW4sIGFuZCBiYWQgYmVjYXVzZSB0aGVyZSBpcyBubyBl
YXN5IHdheSB0byB0ZXN0IHRoZSBmaXhlcy4NCj4+DQo+PiBvcHRpb24gMik6DQo+PiBJIGhhdGUg
aXQgYmVjYXVzZSBpdCBtYWtlcyB0aGUgdGVzdCBjb2RlIG1vcmUgY29tcGxleCAtIGFuZCBkdXBs
aWNhdGVzIHRoZQ0KPj4ga2VybmVsIGNvZGUgd2hpY2ggaXMgbmV2ZXIgbmljZS4gVGhpcyBjb3Vs
ZCBiZSByZXdvcmtlZCBsYXRlciB3aGVuIFN0ZXBoZW5zDQo+PiB3b3JrIGlzIGRvbmUgdGhvdWdo
Lg0KPj4NCj4+IG9wdGlvbiAzKToNCj4+IEl0J3MgaW4gZ2VuZXJhbCBub3QgbmljZSB0byB1c2Ug
ZnVuY3Rpb25zIGV4cG9ydGVkIGZvciBzb21lIG90aGVyDQo+PiBzdWJzeXN0ZW0ncyBzcGVjaWZp
YyBwdXJwb3Nlcy4gVGhpcyB3b3VsZCBob3dldmVyIGtlZXAgdGhlIHRlc3QgY29kZSBhdA0KPj4g
bWluaW11bSwgd2hpbGUgbGVhdmluZyB0aGUgc2FtZSAiSSBzd2VhciBJJ2xsIGZpeCB0aGlzIGxh
dGVyIHdoZW4NCj4+IGRlcGVuZGVuY2llcyBoYXZlIHNldHRsZWQiIC0gcG9zc2liaWxpdHkgYXMg
b3B0aW9uIDIpIGRpZC4NCj4+DQo+PiBPaCwgaW4gdGhlb3J5IHRoZXJlIGlzIG9wdGlvbiA0KSB0
byBqdXN0IHNlbmQgb3V0IHRoZSBjaGFuZ2VzIEkgZGlkKCopIHdoaWNoDQo+PiBwdWxsIHRoZSBk
cm1fa3VuaXRfaGVscGVyX1thbGxvYy9mcmVlXV9kZXZpY2UoKSBvdXQgb2YgdGhlIERSTSAtIGJ1
dCBJIGd1ZXNzDQo+PiB0aGF0IHdvdWxkIGxlYWQgc29tZSBleHRyYSB3b3JrIHRvIG1lcmdlIHRo
aXMgbGF0ZXIgd2l0aCBzdHVmZiBTdGVwaGVuJ3MNCj4+IHNlcmllcyBkb2VzIGludHJvZHVjZS4N
Cj4+DQo+PiBBbnkgc3VnZ2VzdGlvbnMgd2hpY2ggb2YgdGhlIG9wdGlvbnMgdG8gcHJvY2VlZCB3
aXRoPw0KPiANCj4gSSB0aGluayB0aGUgYmVzdCBjb3Vyc2Ugb2YgYWN0aW9uIHdvdWxkIGJlIHRv
IHN5bmNocm9uaXplIHdpdGggU3RlcGhlbiwNCj4gYW5kIG1ha2Ugc3VyZSB0aGF0IHdoYXRldmVy
IHBhdGNoIHlvdSdyZSBkb2luZyBjYW4gYmUgdXNlZCBmb3IgaGlzIHdvcmsuDQo+IA0KPiBPbmNl
IGl0IHdvcmtzIGZvciBib3RoIG9mIHlvdSwgdGhlbiBJIGd1ZXNzIGl0IGNhbiBnbyB0aHJvdWdo
IHRoZSBrdW5pdA0KPiB0cmVlIGFuZCB5b3Ugd2lsbCB1c2UgaXQgYm90aC4NCg0KVGhhbmtzIEFu
ZHkgYW5kIE1heGltZSEgSSBhcHByZWNpYXRlIHlvdXIgaGVscC4NCg0KSSBndWVzcyBJJ2xsIHBp
bmcgU3RlcGhlbiB3aXRoIGEgc2VwYXJhdGUgbWFpbCAoYWx0aG91Z2ggaGUncyBpbiBDQyANCmhl
cmUpIGFuZCBDQyB0aGUgcmVsZXZhbnQgcGF0Y2hlcyB0byBoaW0gYXMgd2VsbC4gSSBhc3N1bWUg
dGhhdCBnaXZlcyANCmhpbSBhIGNoYW5jZSB0byB0YWtlIGEgbG9vayB3aGF0IEkgYW0gZG9pbmcg
YW5kIHN1Z2dlc3QgY2hhbmdlcyBpZiBuZWVkZWQuDQoNCk15IGNvbnRyaWJ1dGlvbiBpcyBhbnl3
YXlzIHNtYWxsIC0gaXQncyBtb3N0bHkganVzdCByZW5hbWluZyBhbmQgbW92aW5nIA0KdGhvc2Ug
dHdvIFNSbSBoZWxwZXIgQVBJcyArIGNoYW5naW5nIHRoZSBjYWxsZXJzLiBNb3N0IG9mIHRoYXQg
aXMgDQpwcm9iYWJseSBvdXRzaWRlIHRoZSBzY29wZSBvZiBoaXMgd29yayAtIGl0IHdvdWxkIGp1
c3QgZml0IHRoZSBzYW1lIA0KZmlsZXMgaGUgd2lsbCBiZSBhZGRpbmcgPSkNCg0KWW91cnMsDQoJ
LS0gTWF0dGkNCg0KDQotLSANCk1hdHRpIFZhaXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3Bl
ciBhdCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3Mg
Z28gdXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
