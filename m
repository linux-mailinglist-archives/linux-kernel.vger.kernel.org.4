Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD160DC41
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiJZHkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJZHkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:40:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA0F14085;
        Wed, 26 Oct 2022 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666770001; x=1698306001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M2HimUb/c3UI8VqpZgxY6ps1XBhx1N7DDvwdi5CnNjc=;
  b=hWHWTRqA2h83Hqcy5W3ax0k/rQxRjUhdVZWr2WaB7yUPx2RvFs8krLQv
   /9vhC9NdlYNH9k8cRgEzNNbWkrluYp+atWj++2kDY6VMU6uQfMXswP3fI
   bKtbGUNRwnju/s6UNSiG12+mI+sl7Y3AUo89zTrVizLcJcFSS/vv+12G+
   WkIXPwnxQErcBt3IcbbmtcCZ8P44HHaKPcJYOSdUBYYFThHrv5Ro1z9/H
   0CDTTXpRb/89lSm7pObDAhhAYAiLigU4wS00KPydQtvUpPOG4NNp2ud6d
   SjDOT8GK/7m+C9TdjUlvR9PV+3OlvJyxkPBqSVQg5p999u0ibsSMq5J/7
   w==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="197073637"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 00:40:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 00:40:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 00:40:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0sqKLTwyLA9k+CM58EiUgG2p6XKPWzpHQALUChxTR7MdZfVEawE2mklO9elROwFYFqN4m/+cH0buKbeqpnic5B7jMaL2M8Dq5Z0L3xeZ2kw1tyRIiJiHzha+vJgAM9jvinhWSX/vWZ7qdcPqYhArxkLjHrfXCmuTZEJy6VIEjeKzLf48Fmjvefzn2Z8y5K8mF+wzMg3IAUbqCZgDxHu1BLU7+Fu9QrIf6LEAP8V07yYfPZ2ev6sbSVKdkSvGC2ldVk9QknO+fUa3V9SHYpwt7+yfAuNTZ7GZlwK/EImGehnpm5dDr/pVanYtrtNZRH/6bsSN1M3SQStUzp4kG4lKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2HimUb/c3UI8VqpZgxY6ps1XBhx1N7DDvwdi5CnNjc=;
 b=mudXxMjsp4iKWomm83LozgUfHAvVW5575gqiv04WNNzA63pZiWIPoycQsJRFTqUBAfLjVU4hG+LW45h8p0Vars528PDIUy4uKr8Gf1Rb7PKz61t1I+iDWzlOzP2bbb43zFF+7WmQcCrEd6QDSUVwxya+xLcKroIsvpaoq0QrrScPYz2+Uw/9vYEfUZlp/LXA/AlueTap0HnkFvAY6FdEO2dR1QVPoUuIUb/qjD68OIVLg7LPlmAaSdgss5n+cTdnio0gdo6MQ4U7dMHI/qwFiGD5SNTCGYcldCi52D+VLqimc1jT4r1qTPUHHp5x7pkhfIQmUzd3w58I5HjgUKCxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2HimUb/c3UI8VqpZgxY6ps1XBhx1N7DDvwdi5CnNjc=;
 b=fJzgJZlR/vgi0diuTIrAgoDQOZBLi25k9f759W1XA38FjTjIQoK39UbcwsipaHn9zCI3wXpzSArtRKRbi+an/psbB8pwszxVNQ/x5e0NWmgRSBCfEDCPBOFzbTyBQ66bVSHk8wOkNJWxaov3SmcvzCeGPzz9/i7T5rl58Mx0VBI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 07:39:55 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:39:55 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Add interrupt support for PHYs on
 pcb8290
Thread-Topic: [PATCH] ARM: dts: lan966x: Add interrupt support for PHYs on
 pcb8290
Thread-Index: AQHY6Q4kghSNWG+JpUGDxfR5KvoM8g==
Date:   Wed, 26 Oct 2022 07:39:55 +0000
Message-ID: <23b5c3e7-b32b-3785-56e4-5adf3d6a161d@microchip.com>
References: <20220915064112.1935051-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220915064112.1935051-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SJ0PR11MB6574:EE_
x-ms-office365-filtering-correlation-id: c59fae03-e115-4950-3e45-08dab72546ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQoovLJX1YusKAW6cI837fjXcvMNpDHD8HzuO8L3w0A6VYhz2aD15yemtloFLkLu27Pgpqp74qHnwKFBVHGf8xhoQLJy9NNC8tqrerC93Bed2Wv0C22UEab2UAP7Ll8uoeQka1TOSvvCb2bBhEnrtuCfWB3RTWuvGcL06wltZV/oGXrvJRx3oD0mkMq/X2OV+uSdo5Mpf7dmmEAGJ92R65XY3LQbgWy5zmpNmR+xXI7P8rKU4Dl7ughIaVZoUdvioMs0yLTKF3kXFGONQOd04Ir8d0486jd4j0xA3k6uruJvtF8dXZWmFt7BNoCGeQDsfF0LLq5Tk8SEVNrZW+4AX3xaeGm6L4PQwto7Jdj/zNxiTs8aRJYyTs/+C3dss+xIh3+dMgUAgl0TVUInz8XSpPogi4BPZOmNdb8RVZKeK1b5IXFNG3v+cYPpvpQwNCj7b2FYu6ZFJk22xqp2vOk7GN99ZXboA0DR6YtdsTkfqeIMZvN2TCGFeoXMnF60QHbXI0i23ECXPpDfx+JoruZVURM5ZJPeHwN31vHxL9JqOpRNy2S3298NxMIcnB9rEaTWYsAkZ+BIt7USAqhkuHQ5znktxyQP41jd2f9/2SiklqkgNv4gNL88OZG3ObhfuF4J4pUpXWY5fvn9QJy5Qg8G8xvcQQ/teOPdVx4DGzXaV3rv0rVTVoYPVz9okJBEkQ3ew2EbbViyq9EKbLemjHpm+vMJyz8Io/bnazhC8ia0UZmgBS2KujNnJoF+7bEKmB/e4IkEdbL5SRJv2adpsa3+ZGhnWOwzIUnsPWvZVc/F5QhklqgxXVs5luLnAixa/uTUG7u3LKoQhcecb2Guk80SIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(71200400001)(6486002)(31686004)(76116006)(478600001)(31696002)(86362001)(83380400001)(53546011)(64756008)(122000001)(66446008)(66556008)(66476007)(5660300002)(110136005)(54906003)(91956017)(2616005)(186003)(41300700001)(8676002)(316002)(38070700005)(2906002)(558084003)(26005)(6506007)(8936002)(36756003)(107886003)(38100700002)(66946007)(6512007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU9OUVd3QkJUVVJ3R1RvRkNYV0JKL1B6anF5aWkrWHQ3UHVaTWgvc0R4TWZS?=
 =?utf-8?B?N3ZPeXQ3NExTMUZQS1ZTTTk3MUUzSlB4RDUvQmJLM2hVVGtRbkg2M1JUdDBp?=
 =?utf-8?B?bHRJbTc4NURUL1doMi94ZEE2SGI0Uk5aMmhiWTcyd0ZMV0hCelp6c04vUVRt?=
 =?utf-8?B?VUFMT2p0Qlo5V3AxMlBQSnhVZFR1cHVKRXBDekI5Z1puWFF2eHJha1czZGhS?=
 =?utf-8?B?VWFqUGk5ZWorWTg0aW1EemtuZDBlcmlUaURPVE1PZ2RNNDc3eUNoNlFKUWtp?=
 =?utf-8?B?OW5obDNiVmZidHVRMkF4bE9TcjRxbFFWcUE2R1UyU29tWEs2M1lpMnFTRnBL?=
 =?utf-8?B?UkJsU2hGM2N6d0VSRG4wNlBhL0RZSlkvYlc0MDNIK1FkSHJCYjErOHB0cFVM?=
 =?utf-8?B?QVNnMjhuMHpGaWxsYWNNZVNsenJ3NFN2QTVUeHVYVlV5b1dBNzArV3Bud1ls?=
 =?utf-8?B?SklTVHB2VTNqT2xPNXpHVWtSTjc0QmQvaVhXQ1RtUXJ6YmVzWHo1ZUxGclJm?=
 =?utf-8?B?djltb2Q5SHdNbDdTWGhXcTJPKzJMVmY1VURJYmQ1Z09leXFXbVR0RjlCMjdk?=
 =?utf-8?B?TUp4ZmdWdlNJYy9DeUtETUNrSEorSnp5MVdzeVdkeis2Y05wRTQ4RlNTZXpH?=
 =?utf-8?B?QWtBeUR6dU1sdmx0Zm1JRG14UmpubWsxdVg3ZVVHTjdvU0RqT3dpUXdZeWh3?=
 =?utf-8?B?ZFppNCtINEVaWlFkSGt4ZVJtRTdlMkNPa0VOdnE1RGJNM0lJcHRqZFVwTU1t?=
 =?utf-8?B?RmNMdThpaVQ3YnV0cWgwaHp5cHdrc3dUT1h5VVlaUVM0TUtaREFKYTdKcTEw?=
 =?utf-8?B?dXlPUVBTUjVQYWJqdUpHNWtlc0lzNTVnWFYybDVJOWFEaExnUGFOKzZxbnBP?=
 =?utf-8?B?MVd2aW5ReExCT2J5aW0yNGt6d0tDMjhqZ29QSG9Jbld0SVBMU0NrQVdwcVhZ?=
 =?utf-8?B?N2h2c054RFhHWW9xMlhzTTJaejByVVJnVVh5Q3Y1bWh4TkFIa0xwbEVqVFpu?=
 =?utf-8?B?Snd1YmtjME55U0tLdzBqNzF2eTJoVUk2ang0UEI2UHFyelAra3NDcVpVM0hO?=
 =?utf-8?B?MmRieUh2bjJITkxFckxsT1FRUjhOWFVyQXJaZUYvMXZHRkJaWld0M2FFMEVi?=
 =?utf-8?B?eG5hTGY3SGdzVDFXZzFwalZZZmxGb0RFOTZPdjZTcUY3VjZZZno4OG1zWWVm?=
 =?utf-8?B?S3JLczNGNEZOQmNiaHZBdlhPYXBBRncvanhlaDBHODRmOUJLNDdWeTFRT2Nz?=
 =?utf-8?B?aExzdi8rcnlHckdqOGVhMmxwc2YvTGZ0a2xoTnBJQ1VwV2RTUk5MbnlLa0Rw?=
 =?utf-8?B?RVE0bHNLUVpZT0RTVnpIOGJrWmlIZ2ZVUGluTUl1VVdWVWdDNlAvRjBhNnFo?=
 =?utf-8?B?MkFCVVNvTHd0VVJ4b0tScUIzTzl5UWRLUnUvVHZQWjZEMGMzd3hYRjcwMmhG?=
 =?utf-8?B?ZzE4Y3Z1RzB3VFJvOVBERzUxTUx6ZXRtcUptQU1sSEJRN2V0UTUvbFlUNXov?=
 =?utf-8?B?ekV2R21GRFEvYlNYcS9sck83N096NDZTeWF0a1BSWEp2RG5ITmlqT2tiQ25p?=
 =?utf-8?B?RDJreUhJWkJZdWtnVm15WFJ3Z3k5aDM3MldxVklhajdLbUV1K21lMGUvV1lh?=
 =?utf-8?B?eVlVbjBLOUFuWWxObVJsM21MYkdpRkxmZHlsY1UxVm1EaGVicTQrSW81eXYw?=
 =?utf-8?B?alpQSzF4NXV2WFJNYklBMVVhV2o3aGxsWUtkTFRGV05ldzdpRW5Zc05kZTJz?=
 =?utf-8?B?ZlJqZER1My9YOVVqMmFRdDY4bGQwa21aWnE5UHE3V0RTNU5QODFpbXJURnJu?=
 =?utf-8?B?UWVjUzdMK1NhR3NuaGJnUTF0R1hQajNRODI5RUtXL2JMVDREczYvWTlxRkhn?=
 =?utf-8?B?NjhHMFRCaW1YVVhPbjB3ekU5ZmpVVEdUQktMMzB1UHdtTng3a3JxTEk0bzVs?=
 =?utf-8?B?eFVkVDYzUU4yeHV3K3kwSFZKZkhrR0pZYjlQSGVKS2NCNkdmQWRtVkZxL1BE?=
 =?utf-8?B?c1dMVW1zbTNKakdXaGwvSUI2cHhKM013LzJ6SnhVSlRuWEpmNjIwLzdid2Rp?=
 =?utf-8?B?MTlIM0tDL1B6WlZsQTcvZHVzUjlpWlRjamJBWllwMmJZamZvZTY5ZERxdW54?=
 =?utf-8?B?Nm1sZEZYTkhyaTdrQVREZHdIcW94engvdDRLRjhxbVhmNjhkamVVNDlNT0xa?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F01BB1CAE6872545BC61239A558CC1D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59fae03-e115-4950-3e45-08dab72546ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 07:39:55.4317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnpTHOf6P5/NuBXp4XNoM9roE+0rDVRiOA1iOoFs90PyyUhtR0LYQz60uWxZ+ZRgOmakOEgvLTaha5PMKApdMaDWoiQfci9C+hrWUCueHYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDkuMjAyMiAwOTo0MSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBpbnRlcnJ1
cHQgc3VwcG9ydCBmb3IgdGhlIFBIWXMgZm91bmQgb24gcGNiODI5MC4gVGhleSBhcmUgYWxsDQo+
IHNoYXJpbmcgdGhlIHNhbWUgaW50ZXJydXB0IGxpbmUgdG93YXJkcyBsYW45NjZ4Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1pY3JvY2hpcC5j
b20+DQoNCkFwcGxpZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0K
