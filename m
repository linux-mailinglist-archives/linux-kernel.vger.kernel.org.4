Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7522E65C018
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbjACMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbjACMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:45:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427E910555;
        Tue,  3 Jan 2023 04:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672749933; x=1704285933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SSUE81wdRuUTVzOamequD/U7YIhLiarh81TX7xfLs6c=;
  b=1xIUdZtgf8pWgXVF9bPR2bOLV/J5EHJNkUfB9a76MYYvapHrzy3JCi+m
   RvWd8wiSktu3tKnLf2VIedtiDLCOBK6+glJKzag3NKQHW8hAsa78NlLQH
   +ldwGFP1A5p+uWB8COwIMheYw4ZtP7ekQsCW7iG0DUrM3hXTK/UsRatps
   HoQxTTLW0D/FfC+RgzJtMjRUx/SkATgIICm5K4l3bBT3Zwn8qct4JKVNd
   ogCWYt3TDyBmr6/Z0BcJuxmSZNPDv+1aBj7ko/LmAFxj2jAT9g2obTP+8
   kRjolFDm1SYVUcFT3N2N8MDdcGh3qOblv3HBJ60nhE/vri/zkXyNDsL7W
   A==;
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="194026134"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2023 05:45:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 05:45:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 05:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvzS26ohMPNyF2jdeza+i0CEjSss8rdIErBhzielL0zVRZBVqn/+9dihHPBsHkaX45utJtr5+u9gS0nxdauEUizS/32EE/2mjkPp58pqBrunCCkTLHLmjOGi2188K75GBGEvgBTqjt9JDaEiDddmYYjw3r8GCOb0OtYYq0Pq1x8IeUqVC7zlr2htjCbI3WfLs0FLSIjl9jiQpoJzXFG+mAUdnedcd9T3r5xo194esogMzs5W2VFyzgz7heFNSEtLhB/Yd0vZsKJXJfbgmCZa70+9woVu+l09cALY1m/HMNiD+MZuzY9evfgIeUc9CC6yn5tSEqBP0kxyIkwjv3se+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSUE81wdRuUTVzOamequD/U7YIhLiarh81TX7xfLs6c=;
 b=bHscc405G0YQF5csGaq+602hkxz5zliWCGIBfAPAFvdQkfoaF0seEK4Xm3FEE3PQKv2lak6g7appHXOlr/mpdNJNRUQ1kNAm0+kYMJ3iXuIaAybV95XJL+JWSaRi/pU6xYEHjFDF8dQAeWaGUJ/Gg6F61hXz9GehZnt5O1dYxNbi0fhe1d5QY5NyNnU0EanEodeEMFMJbL4I8kFY4usc4EhTs0MF3wAgqJfWC0F2SMH3ZKd9jKfv5HM82KcrTCq84fqeflieh5tbw/AkhmbM16tShrjhfx6juwvnu/88sr/QjA6Nm22Pddx5IO/ZnhwVwlB5pZd3Yx7iYiuPIHuXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSUE81wdRuUTVzOamequD/U7YIhLiarh81TX7xfLs6c=;
 b=SOjs3JRZHf7CGQEjUwR5NyG8w2scpmOV1q8SCSepSDZ1Z1RvzRA87ll57aLHvSp8DiwYbwfv56kebk1aNU9cvNvSuQOKCwUhW9nHLFgEdNilCVLY8s/hKB49j9kYdoQ/k8uR/1oL64AwXm2Lyy3We76yDXf4z88egG8a59oK2Vs=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 12:45:09 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 12:45:08 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Thread-Topic: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Thread-Index: AQHZH3E2/WaTIB/FbUKF2r3BUsw1zQ==
Date:   Tue, 3 Jan 2023 12:45:08 +0000
Message-ID: <92347fcb-46b3-d1bf-82f1-960f69300a29@microchip.com>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-3-claudiu.beznea@microchip.com>
 <2f9793fb-8840-fd3c-8af1-42c6c11ed475@microchip.com>
 <9054a7cd-2993-840f-1f4b-7837b43a1800@linaro.org>
 <23389f8e-daf4-67ca-1e3b-c5a6433f3986@microchip.com>
 <4632f71b-2b67-b634-1cdb-69ac741a8ef0@linaro.org>
In-Reply-To: <4632f71b-2b67-b634-1cdb-69ac741a8ef0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB5298:EE_
x-ms-office365-filtering-correlation-id: 7eba1c8a-1bd8-4c9f-fa55-08daed8858d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlccJqRwmaDFjWgS1ysx+YJutYKoldLGybl9IcMXoBSf808cZ5NG2lrJ2G6K93ACfQa1LSxrsYHtDCYr3JynhdEIOdYXn7E3IgHFlVAP/Ckxg7DtRICKQiJ4Zg7MFWlIUhdnxYvbkPi3QIWMeheUVH5OC0JH/YGPeU1GEaqmCLJx15b1t/3OVbwzvyJPSkOcDZHNo8Wsdn1DzgTwnygdcptsEfzglFTaLhOmKYHi+3IdUNbMKA4UzFkbghaLwGAPRAuUPRIkn8m1gdn57lIl0Qt2wwOXbbPhXar5+iA8Q4vtAVCdUSeXt8k7NHVUx72eWVlsfUQ5/EVvVycxYAyRN6wum4bSuU5GoBUzsBMsN2hEm11y3cPag1Up/HY111BJzDKWxSE3rUzuipaJJfWUtQdhrQSdtY4NFRfo+RzlwkhpeGuW8em1YXiEdo0ibT40eobDB4zKQyZQsZlBE0zwso0jOvPjtyToO4GptT6g5bgoIsDty5AiRmJvtuyvQ1yOgFQflYVDs79EUC9nBaVhAdMuhV/egQh6AOr9ytkt8EkE9+ShTdbdhCbN7+ZIUp8jtxXdbn8ZPaCsR05sWUlh4sfhqXs6Pq0qDoY381wRQzmW+G0PbUjjgjCqpIKUVgB0xDv4cg378XMv7Twz1gxDgM5HIu/tSYxm/9Fxtp6pIVGUWaZNXVOFwjOXmdldr5kzhe7CkFcKxqEdgirvHBudTlTqYdpScGcVYejTsueUMnqoP9dmpqdg9Z5olY+9BTOo0v3FQbFTLW+9L1FaAIwd3bZaKB8URAZi6nnSN3YHSgw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(5660300002)(2906002)(8936002)(31686004)(4326008)(8676002)(41300700001)(316002)(66946007)(66446008)(64756008)(91956017)(76116006)(54906003)(66476007)(110136005)(6486002)(71200400001)(478600001)(66556008)(2616005)(53546011)(6512007)(26005)(186003)(6506007)(83380400001)(38100700002)(86362001)(38070700005)(122000001)(31696002)(36756003)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUNxRzliN2FObGp2RVBGNVlMMUMzS1ZwSjNEM3B6bGtIR01kR0dPQW5OaFd2?=
 =?utf-8?B?YnprVmVPZjc3V3o1VjVKcFFiRHBMSFMxS1ppZUhuZVArdHAyc1FHclVVZ2pp?=
 =?utf-8?B?ZUU4UHV5aUNlVDZUU2s2NjNXOEozWnRHV1lwRzNJVkw3azFYY2loZTVsUVJR?=
 =?utf-8?B?b1VxUlBBbnV5UDdua0NFWGxVMzZ2RW04SHdobFc4UVFRNVVOYXpVcW9PT2Z1?=
 =?utf-8?B?UWRPQ3JTQ1VuMUJWRlVoangvOUc1QzhCZG9oV3BvYlZBQXpJM3dFbXc0VGZh?=
 =?utf-8?B?cG0rQ0FtNUxGVVU3QkZYczRuS25jM0NHaGhZaVFzRGF3bU1ZWDdjcGNodmRx?=
 =?utf-8?B?OGUxN05icGdreE9ZaTNlMGxqVXFHS3E4MjZuNUZZeWdsQkxZejRrdWMwbUk2?=
 =?utf-8?B?TlRoTm1DVWppS1dwZ2ZqYkJRbHl2Nk1EWTZXejNPQU5SNjMyMzQ4a1R3RFNE?=
 =?utf-8?B?NnVvUjM1VGlwcU9QWllxSGdsM2JnR09yZFpiZDFmaEhxS2lPOGFLYkJWNzZF?=
 =?utf-8?B?bGpobHlyakszbU11ZmRkNncwMEVxUFd3UVIxT3NOSm8vQWZJVHFOdVI2TXdG?=
 =?utf-8?B?RTBxdU8xWmlUNk5SY2crWmZRU1cyZkFvYlV6bmMyRVJHZTg2Qng2M041ZTl5?=
 =?utf-8?B?SGdub1NQc0IwS2FlN1E4TUZhcUtpdCtUQ3NnK1NxL3NRQVhoQUU3QkcxL0kr?=
 =?utf-8?B?YVpPNFJZa053dE93aUI5NXBqV3pIbUl0bU9CYjNvY3FhVnl3YVhHSHFGKzlG?=
 =?utf-8?B?Zk11alFFZ3RMWm1qZ3hEckpmZHNZNlREMitNTmVJdHRWT2I3eWpnQTM4REhh?=
 =?utf-8?B?cWY0WEVkMDNudmtrc3Jqc0diTUsvZEJjL2dsOHdNWXVBSWM0cnVoUzZHbWtZ?=
 =?utf-8?B?UlozM2xVTjNwT1hteE40RHhQcTRkL2EwWWtHaWIyclBxUitEQW1leXRxV2Ex?=
 =?utf-8?B?RXppOHlwWWdyYzZJeGpxTmZ4R2p5cFJiWDVFS2h4WEI3RlE0ZEtsMnJTS05X?=
 =?utf-8?B?TE9XK3FOSjBSOFVONStwQmpibGk4UXBpNWUrVUdaNW10ZWU3Ymk3MWRRdFhz?=
 =?utf-8?B?VXJkZGlBVWE4M3JQM29kWDNXbU5wMTBVa0JPRjBlRlBGMmF1NGtqUlVxTXJw?=
 =?utf-8?B?NmVqcHUyN09WSmNCY1AxT09kY0trcnZjUHltRENlc0tmRU9kbGUrcHRaUzZs?=
 =?utf-8?B?SnR0ZXV4QlRZSEFwWDRMU0JmNXRiajZNZlR1TnFYcFZHc1pNRThXNGtRM3dl?=
 =?utf-8?B?Skd6b3dlYzh4Rm9UcUNaWUVyaXRxcWN6TDVpSHBXZlpNVWMwdHcwMFp6MDhL?=
 =?utf-8?B?UDNDUmI0MkJxMjMzcFB3QzlYYVJ1VWs5RTEwWU42eHJ5VXp6VXlwQ2tXcXEr?=
 =?utf-8?B?ZGQxa05TUjF1M0hDMWprQ1ZiNU5RM1ozWlNDOXhvQUZWczB1MmI3UGJpZ1Bn?=
 =?utf-8?B?MU9jdWFmQTgyR25jRjNHNmg2Zit6ZlZnUUNQdG54a3pOS0RJK0tiZDJNVFFG?=
 =?utf-8?B?ZWMrbG9LV2V3WXN1eERFVnN0NVB4ZzF0S0JSZWJvVnZVaHZvSVpRRThoaWpi?=
 =?utf-8?B?TFh3Tkl4Z3p3Q3haZHB2OWhUUC8xbkVSMVY4bk5DdFFqYnZraEdtS3RDODBK?=
 =?utf-8?B?Q2V1bWNyRHFZUzRUaW5tbnRpb1Fqcm52UFY1dlFjc054dnJoak10enRhclZ3?=
 =?utf-8?B?aHdSVGRqT1FYUWNkaTFYN1JZZFFGR3NLN1B4MHFJZklobDZVTmk3YmVUSjA2?=
 =?utf-8?B?dHluSXFwc2p6MzVFSGhUOGtiRDNOc1hTQU9Ib1BsM2o5QmZqTm1tMU52cnpG?=
 =?utf-8?B?Z3p0amtWell4OVRRb2pEaGMrTjBEbUNkbnhLODZXcUVlTVBxUW5nVzEzRU5n?=
 =?utf-8?B?YTJkYlBxd0NUZ0EyZGNhNlV6NWwxcHFFRzhXamtYRldTWTBFTHBLcTROcWZ0?=
 =?utf-8?B?SVFNWW9LV1l3YllubWs4aEhQWW9xdzNBUU5FdTVBZHYyYWZ6Nkx5a2s5bmpu?=
 =?utf-8?B?UDdMM3N1RkZmLzBHV3R3QjB2V25jd3JyVmNFV25wUXNmSUFvWGg5WmRBQ2lY?=
 =?utf-8?B?SEdwV1lpc25BNW5ZdU81QVZpN25NWStUWVVkRi9yczA3bEw5OXlqM251MzFW?=
 =?utf-8?B?WkFCeGdSMzdtYisyelRqZWphcFgrYzRESkV0MzFYSTc4czZyMUJLQWFCZy8r?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66C1DBD4039EB94D842A42973E9A915C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eba1c8a-1bd8-4c9f-fa55-08daed8858d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 12:45:08.7343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOXr8GJ7kBUphwgznnd0SBR2vPQmmHGz54pZrMYpvSyfZ5RCLVE3oJHBakrKtLe/0TRUEZAE+dBVCNAwuIw871NETGzffyCzu5RJLzSZQkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDEuMjAyMyAxNDowMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwMy8wMS8yMDIzIDEyOjE4LCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMDMuMDEuMjAyMyAxMjow
NiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDAzLzAxLzIwMjMgMTE6MDAsIENsYXVkaXUuQmV6bmVh
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IEhpLCBLcnp5c3p0b2YsDQo+Pj4+DQo+Pj4+IE9u
IDA4LjEyLjIwMjIgMTM6NDUsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+Pj4gRHJpdmVyIGRv
ZXMgb25seSBjbG9jayByZXF1ZXN0ICsgZW5hYmxlIGZvciBERFIgY2xvY2tzLiBERFIgY2xvY2tz
IGFyZQ0KPj4+Pj4gZW5hYmxlZCBieSBib290bG9hZGVyIGFuZCBuZWVkIHRvIHN0YXkgdGhhdCB3
YXkgaW4gTGludXguIFRvIGF2b2lkIGhhdmluZw0KPj4+Pj4gdGhlc2UgY2xvY2tzIGRpc2FibGVk
IGJ5IGNsb2NrIHN1YnN5c3RlbSBpbiBjYXNlIHRoZXJlIGFyZSBubyBMaW51eA0KPj4+Pj4gY29u
c3VtZXJzIGZvciB0aGVtIHRoZSBjbG9ja3Mgd2VyZSBtYXJrZWQgYXMgY3JpdGljYWwgaW4gY2xv
Y2sgZHJpdmVycy4NCj4+Pj4+IFdpdGggdGhpcywgdGhlcmUgaXMgbm8gbmVlZCB0byBoYXZlIGEg
c2VwYXJhdGUgZHJpdmVyIHRoYXQgb25seSBkb2VzDQo+Pj4+PiBjbG9jayByZXF1ZXN0ICsgZW5h
YmxlLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1
LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4+Pg0KPj4+PiBBcyB0aGlzIHBhdGNoIGRlcGVuZHMg
b24gcGF0Y2ggMS8zIGZyb20gdGhpcyBzZXJpZXMsIGNhbiBJIGhhdmUgeW91ciBhY2sNCj4+Pj4g
Zm9yIGl0IHRvIHRha2UgaXQgdGhvdWdoIGNsb2NrIHRyZWU/DQo+Pj4NCj4+PiBVaCwgd2h5IGRv
ZXMgaXQgZGVwZW5kPyBJIHVuZGVyc3Rvb2QgdGhlIGNoYW5nc2V0IGlzIGJpc2VjdGFibGUgYW5k
DQo+Pj4gcmVtb3ZhbCBvZiB1bm5lZWRlZCBkcml2ZXIgd2lsbCBoYXBwZW4gbGF0ZXIuIE90aGVy
d2lzZSBpdCBpcyBub3QNCj4+PiBiaXNlY3RhYmxlLi4uDQo+Pg0KPj4gQVQ5MSBkZXZpY2VzIHdp
bGwgZmFpbCB0byBib290IGlmIHRoaXMgcGF0Y2ggaXMgYXBwbGllZCBhbmQgMS8zIGlzIG5vdA0K
Pj4gdGhlcmUuIFRoaXMgaXMgYmVjYXVzZSBjbG9jayBmcmFtZXdvcmsgd2lsbCBkaXNhYmxlIERE
UiBjbG9ja3MgYmVjYXVzZQ0KPj4gdGhlcmUgd2lsbCBiZSBubyBjb25zdW1lciBmb3IgdGhlbS4N
Cj4gDQo+IFRoaXMgSSB1bmRlcnN0YW5kLCBidXQgd2h5IGRvIHlvdSBuZWVkIHRoaXMgcGF0Y2gg
dG8gYmUgYWJsZSB0byBhcHBseQ0KPiAxLzM/IA0KDQpUbyBhdm9pZCBoYXZpbmcgQVQ5MSBkZXZp
Y2VzIGZhaWxpbmcgdG8gYm9vdCBpbiBjYXNlIHlvdXIgdHJlZSAoY29udGFpbmluZw0KdGhpcyBw
YXRjaCkgaXMgbWVyZ2VkICBmaXJzdC4NCg0KPiBUaGlzIGlzIHByb2JsZW0gb2YgYmlzZWN0YWJp
bGl0eS4gTm90IHRoZSBvdGhlciB3YXkuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KPiANCg0K
