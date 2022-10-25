Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147DD60D739
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiJYWhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiJYWhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:37:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2128.outbound.protection.outlook.com [40.107.94.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F0C29
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4p95i20OtUwYq9QYcFqYA2hr7qmPDB0EEgcNz10TI4K/mvrZihH6NIc1xebPbLBPWVZNL7fAsDpy6wwdtsjGytQRRmleIQOz4BNK5rg2kCg6VDxWuXpzGEBR5IokhSrsfNqYufUJg53SvnOiti0gZ53bQImR3SEH69o3wFJ3eJOMvfU0MQszbKXu4iDebq93VglbXapKcCIcsKeP6bVa6ZN/SaQWnV7UU/ZGa9NWP+5nZcXO3jXiCgTZ+6aX9Cq54eMIhpdcMw+O+bA9BfqMKtDn5txwYV+9l5Wl0ijGfuPodtj3f2BOhoeQgr+fuOHaIoLSqxHBnYIuauQvdbeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3AZq+94E+b6yTYe+qRysqBMyRNvOh1WolneogsMqPU=;
 b=AxdAIQ4Tw1lcNbWdijRWFnjEeaGh8SKCX0KP9dmQdr8h+Ce/+jNLwx9crKazG08bVXi0L+ZMSCUojl7B3N++Fg/ArPrRZXWc5yrTUczl+6rT6OQ5bABXiT5LRQn0nYJPNRqJe21Lm63FUT9rHZCC9Iug9OU8P5Jko8JmJypPCOFU/LfulNKARrnO71llqz6hsfeK6rsJuKOBXvCWB4H+uMmGqsxKX2bDzqpKOzdvnM5c38Vq4I4fyWor5fRivOca7WxXgKUmFwawAbD4sOl9K+qmpYfD1as+uI+XNnDyvR8KjHDiVzT9ykj+87tHUBt4/YtM+7jvynC3EbP4dHc6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nathanm.com; dmarc=pass action=none header.from=nathanm.com;
 dkim=pass header.d=nathanm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nathanm.onmicrosoft.com; s=selector2-nathanm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3AZq+94E+b6yTYe+qRysqBMyRNvOh1WolneogsMqPU=;
 b=hC8Xy5D09SW7L2QTZxev899x6ndS0CZ7K6HEl0m01l22KxhSXCWD0+BQDd4wrvV/6T89Lg0x4dSQ/0FDV+NYT8HRRvauoIJEdklx3qYtLAQe1bEQnn6CQvebh7yvAqPiGAKD+vJIOkghXDV8ZG30PMT3xEFdD4JyHRA6dBhiCFY=
Received: from BYAPR06MB5573.namprd06.prod.outlook.com (2603:10b6:a03:a8::18)
 by MN2PR06MB6109.namprd06.prod.outlook.com (2603:10b6:208:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 22:37:27 +0000
Received: from BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497]) by BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497%5]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 22:37:27 +0000
From:   Nathan Moinvaziri <nathan@nathanm.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
Thread-Topic: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering
 if chars match
Thread-Index: AdjoEtBynXV7SUtxSVy5+tznV2O0qAANQzQAABj3HAAABagYAA==
Date:   Tue, 25 Oct 2022 22:37:27 +0000
Message-ID: <cad4345a-9a51-34ca-b599-f8f98db40200@nathanm.com>
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
 <7695dbae-0fc6-d53c-5b9f-b3bd7e7fe8f8@prevas.dk>
In-Reply-To: <7695dbae-0fc6-d53c-5b9f-b3bd7e7fe8f8@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nathanm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR06MB5573:EE_|MN2PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: c740362f-a1b7-4e21-296f-08dab6d97e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pt7O1F3lP+EFyX7RrtAiPBa2oHqzx40vfyCZzAtic1/m9WTqwPCOZeiHbqaKWDAbYsDy2cDOkJtU+75gtso9YA5KmGgxGtK3+AU9PA6JD+k/Q0YtlFMZPQNbUuatGNinNBMvuA/EjP/mdY53iwv2ZcPPdNlz4VH4r2aMKrZHggasU9Tgy4Mb7Cw8HZlLG0nvQC2GvEJ+tPrsjSG/+mjJ4CSkC1m3jZmQzYVe/P4ye0iwhO5kIVmzk0mYTu1NMpz3QJrqwgcJlomR+VFPNDkQIwKvz3YFCzDruH5SYb/y6PL11IuqhPaoPIETFyVX4G43S80Okxq0ob+PeQ6KfEkGJRwZDLE8Ttqm3K8fIL0k6ZO+bQU/gIAjvGUtUhc0WIRE7CWJixmZWTkWfZgVCbU3BiYlm42HG7R9Icpz6CF2I4wzGNynbZ2kYDkVQCqHuQNVCJBcgfOGPGbyhGvSJRK9mhuT+TY+cNe4l+Mtu2syRYwESYVAOOET8bDhjesw94NgbIGtOh5mNafXUx2LWGjmCcUNQcdYXI3OpwobZrsT20qaFSgbehqnaq5F4qfd221MosZKIHcjpBhbC3l9v3HGpglvhFUGMeDBHb5A4HXbarZ2CvB8fojZHzyeE3uA5YYD8G6xTgO4kgdffWTmYeGWJvkPJnfN7nky3VyIPOPbblGxivJMf9CnWc42Qr2Zbfbo0UJ5HWuriMMTjk3I1H0L6pcLCBQ9W+yVzoGH30aiqDpNetwJJzIz2a1QJq9jaunkHmpSc2nrfzCCEXbq/EsWogW6WVfJQosavkWMMfnD8jAEKdxnxXZxbbrxWRCG5TX2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB5573.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(39830400003)(366004)(346002)(451199015)(6506007)(53546011)(478600001)(4744005)(5660300002)(8936002)(41300700001)(8676002)(6486002)(31696002)(86362001)(31686004)(2906002)(26005)(186003)(6512007)(2616005)(122000001)(38100700002)(316002)(64756008)(71200400001)(36756003)(66946007)(76116006)(66556008)(110136005)(66476007)(66446008)(38070700005)(54906003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDJ0WTNXRTMrZnJMZkpYM1AxcmQvZCtTdXhram5oMEYrdlh5bURZM3JqR3ZB?=
 =?utf-8?B?Z1pzMVBSK0pBR2p6RXR0NHFGRjVDNUZhOUZQSWk4dTMrYXRma0hMWVBvQ3FR?=
 =?utf-8?B?LzFpWk15K0FzYy94RFNGWUUzYlVVU3VYRzlDdy9EQXY1cmE1WUhoQmNEa3dG?=
 =?utf-8?B?bXI2SXZnd3V0citqUVJwTmlRb3lZUDBqSDlpVVZ3eEVqeEFOZWVOL3NLa0JY?=
 =?utf-8?B?L0cxbi9qZzIzcThUVkFXbkZTN2VEUklaTXhGL1hyOFNCNGl5eGp2Vkt5TW1s?=
 =?utf-8?B?VTFuaWM4UDVTVU5mY0FXd0daVFE3MTJ1RmVhVjJBbzFiTDFJbFpYWnhMZHI5?=
 =?utf-8?B?MEZjY3c4TG92MHV0S0JMVXBYSEkwZHVGVU96NG9yem9GZUZuTkZMVW5WNGE2?=
 =?utf-8?B?cll6L2VzaXBqZkpEUVNxM2tmR1JXZVJibnpScjVrNEFUVktkVFVtWkdtYXZW?=
 =?utf-8?B?eW4vUTJxbXcyeUJhc0tNWlhBQjBWc0NKRFovU3Z3MDg1OWpXZGZBeC9LSmQr?=
 =?utf-8?B?QlRKcElvVVB6WVl3bVhLYmJOS3psdmlUa1NLZmxkOTJyMU95Rll1Y2tPRmc3?=
 =?utf-8?B?QWg1VFVqMlNwbk1xbmpGQW5FeHg5SCtMUlhFeFFQK2h3Z0lnU0xnVWJBQ1FI?=
 =?utf-8?B?RjA0Z1pUOUUxbXhnWk5LU29xNFFLajRZU0ZSc1VhRnFEc01pdjQ2MnhyUktQ?=
 =?utf-8?B?d1l3WEVpTFVWMGwybEhZL0lsYzBteTBHdnl3aEVkeTM2TytlS3p1cy94alMz?=
 =?utf-8?B?aG1GT1VzMVhOWWlUYXVybzhVd0hoMjQ2aG4rd3l5QW13RTFveHpLNUxDaUN2?=
 =?utf-8?B?cVI5SjBsTUx5aWlHUnBGalF4UEUzYTdpSXJnbVpjOS9aQSs1cnNxUmVmeUVD?=
 =?utf-8?B?MWxpcUU5ZGRKU2l2Wm9CamNDTWRLS2Y3YVA1bGt6RVV0TmZvcXBNUjdnUVlX?=
 =?utf-8?B?V2xhMEtqV2ljN3JNcXBVQ2tMSjk0Skxpc0NEbHdtWFU4ZWhWYW0ydklzZklj?=
 =?utf-8?B?VVlwRkE1ZUtoVTdHdXEweXFrWmk4cWhTN2JBRlgwNzJscjBmbGZ3S1BUaGpF?=
 =?utf-8?B?L082dExLdXNWQ3JUOTUranNnNndDRHVYTmxTRGduTHJMcW1wcFZaeGpEY3B0?=
 =?utf-8?B?QnlTb1RsbmlPMzhwMTIvNGZUZzZEL1NPQjA0TDljUHhaQU1lZXRVVG9nWGtY?=
 =?utf-8?B?ck9QeERQNW1McXBiQ2RTRE84Q1dFS0xKMi8wdEtRbWNjUGtDZDBRbE4wZWZF?=
 =?utf-8?B?Yjg1cnc1M3lYbHRCVUtYR2YrOWdiUXZXNXIyY2VwczAra3VHdWxFWVV0STB5?=
 =?utf-8?B?UWdJaThvOGxtNlltbmlBRmcxcnJTcmVKQzZWeEg0ZG5oeGdxMGR0MWE3cE1R?=
 =?utf-8?B?d3pkUGtic09FZTRzL3ljbXJNWXBrM2pQTkFxQUJaU3A2OGdmTzRCUUk3ZW5V?=
 =?utf-8?B?akZ5enRMUjdKdUxDZGdSWWlZMGJaNEJvODBKN2QzQUdwMHl3OGZ1SjlnMG4y?=
 =?utf-8?B?cjNsWW9nTFlGSk5NTDA4TUVHTFc1M1BidkMxRG10c3FLVkt3QW1DQmdsNGN0?=
 =?utf-8?B?M1Y1YXF2QjhJNGVOcFc2OVpTL3hYaitpN1k3bGtrQjl0QmlTZzdqVmFRUHVO?=
 =?utf-8?B?TThEUVhOSi8wU3gvMzRNZGFXMEw2MEQrNTdIUUJWdGtUTWd5WWxIcDJPRFJr?=
 =?utf-8?B?Sm9IaXc3c1JpdDZwaXRkbk9yenJ4RDZsUTdncFdCWTJ6cmFOV0h2bHlzbVpR?=
 =?utf-8?B?enRTdysvd0kyTFlUNk9teVg2WHlpRTBxc29RdVQzc01OYk93OHk2MUI5ZHZM?=
 =?utf-8?B?aFVqV2JoRHdYc3pwM0JJcERYTFdpODhUaGluYUsyQUt3NllyQXR1Zng1L1Yw?=
 =?utf-8?B?QkE4bDdpbWNhZTFwQmhHVFVVT2dVZVFta1d1b3ZRU1ZnYjc0SFNza0lMWE1w?=
 =?utf-8?B?Tnp6T29KOGU4VDJ5SkN0RmYyeDA1cEhqL1E3dGhUdFZiall5NE93R3pKUFQz?=
 =?utf-8?B?cU5lVEd3UmdsM1BtV0g2Qzc5S2JUdW1BR3hYRVM3VHFwaDkzREdxQXRhUysy?=
 =?utf-8?B?UEhGd2FpaEdMc0lNdnVpR29XaFhiSEJpcWIrbk1HbWJVVGcxaGpxelM0d0pl?=
 =?utf-8?Q?PctI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C55D41853FB001488C4870D0EEC69510@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nathanm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB5573.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c740362f-a1b7-4e21-296f-08dab6d97e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 22:37:27.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e74266a-92ff-414a-9879-2149aecc5932
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIKhPKH9mEj/10ABcAJ08DcqRpFlE7Lbu73qTQs1lOJtBWFVZln5WhfO/31R6uIhnAcklpuruhn2sP+LJaiQ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR06MB6109
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjUvMjAyMiAxMjo1NSBQTSwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4gQXJlIHRo
ZXJlIGFueSBjb2RlIHBhdGhzIGluIHRoZSBrZXJuZWwgd2hlcmUgc3RyY2FzZWNtcCBwZXJmb3Jt
YW5jZQ0KPiBtYXR0ZXJzPyBzdHJjbXAsIHN1cmUsIGJ1dCBzdHJjYXNlY21wIG9yIHN0cm5jYXNl
Y21wPyBJIGRvbid0IHRoaW5rIHNvLg0KPiBJZiBhbnl0aGluZywgd2Ugc2hvdWxkIG51a2UgdGhl
IGNvbXBsaWNhdGlvbiBpbiBzdHJuY2FzZWNtcCgpLCBhbmQgdGhlbg0KPiBtYWtlIHN0cmNhc2Vj
bXAoKSBzaW1wbHkgZG8gc3RybmNhc2VjbXAoYSwgYiwgU0laRV9NQVgpLg0KDQpJdCBsb29rcyBs
aWtlIHNldmVyYWwgb2YgdGhlIHN0cmluZyBmdW5jdGlvbnMgY291bGQgYmUgY29sbGFwc2VkIGlu
IHRoYXQgDQp3YXkuDQoNCk5hdGhhbg0KDQo=
