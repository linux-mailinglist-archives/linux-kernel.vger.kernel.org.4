Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD985EDFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiI1PMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiI1PMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:12:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9E6548;
        Wed, 28 Sep 2022 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664377953; x=1695913953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tk13+X5GYGUPn8B4q29281kdTAMPBcm7q/IHC8RZxuI=;
  b=CUbRdvoqw7TWKkeyeogVmbXXsEIMtuMA4N9lEuwqwzdzboVb+vSkZiyF
   B4P5yWA0KKgBNofUW1OHBslBoPUgzQFSAGubi57QmBQyDevpdxU84xnkL
   Q+HQV5bkaIid0y5IRqyv7W3H4BKqk7NMKvxzqOc84ktC3SWA1GV1S5Agk
   CPgd4eIlGnYbfp/eS40LrPXyeIJnbHnyifC+R1d77fHM3M9orObLGD2g/
   jKhf7MZ188IRtbJ7ptOlN7qbLOWFfE5ixp8fVmeAWwWcGhJRSZ6ifS45e
   ezMaEpjivhOE5qKwuH3SEK2c7DMCYhFgxWadkIGxWGFhiG8dAYarDoAxU
   w==;
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="115844101"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2022 08:07:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 28 Sep 2022 08:07:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 28 Sep 2022 08:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+jg+61IfG0L7dri6M7e9bLFH+GkWvsV3msqOE+Q/0jAcdYVYes2J/R6e7A+1XXrwebNs9S5YXriYvwMRjKKiGsqIqzAAG62X8HdFz43jZwbxgebfOR1QKq48vEbkPmFx7L2HAICpFegwCe52ITGWo3b9Wqrs5d8OYyXEkewU0ODQvhuI5P8AmBVcwA2/xCUJBKJDKoC7ZstXW/DciJi/fNNzlONF5IDPUvTRnlf6HeM98sv7n4KXFpkTHiDnWya3s4wFHFlHfhveiuJ6TkqTpoqCQUicFU47dvJqbkXrmJOHRJoDvHcYazBQJgI855w036ygQ8CekLQe7l+XRKTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk13+X5GYGUPn8B4q29281kdTAMPBcm7q/IHC8RZxuI=;
 b=nxcgE6fZCPV5VyMCZ3iH/okG9E4iPeWGGh34V/i+pz4ersEBD+uG0k5RefdAMFuF+85u7ioSV3waRZsjGnfaDJkX+teTZT7bXC8mKxTVZDCEPD/i9wozU4m0sZhq1O0MmL/fD6+zqJ/9e3dqesDtg5+hsMJ+dzrPHrO99gdUX8g4HR2qfoBYCBqlZJl5Na2BHvWJwZg4uxkfNI64sEWd4EBh1sv0OQKAbrT3ZGP4fY0wJqLnILz/Z5EQnG5Qi6LAkEOQ7NO9pu78zC7Mxz0U5vWWwksfHRwxVu812vUig1mFvET6GUU5N8RWkoAzCP6P48kiWcvhe1WQu0qCOTrqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk13+X5GYGUPn8B4q29281kdTAMPBcm7q/IHC8RZxuI=;
 b=h8RaP9iZzLyPfdWVSM3/TKiPmRx0BLIvZw6TokkctJ9R5zdLaDD2ItyO4a7YRemp7FgrBHJorVtkDz7MiKEuCuqhDnoGkJP/ZAuH8HVbe7/9gbnqJckA1tJvTJ6UYHIMYpbKc1lmackHFVeDOfPT9q3CLSF5DWRxUzLv3cJ74/E=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 15:07:37 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::5d0a:7887:8de:b815]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::5d0a:7887:8de:b815%7]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 15:07:37 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <lee@kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <radu_nicolae.pirea@upb.ro>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Thread-Topic: [PATCH v5 1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Thread-Index: AQHYznhuMeoB1iibGk+mXpPSE0ii8q30+hiAgAABDYA=
Date:   Wed, 28 Sep 2022 15:07:37 +0000
Message-ID: <7a0c45e2-85fc-b5b0-d1de-a9e06a20bb42@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
 <20220922113347.144383-2-sergiu.moga@microchip.com>
 <YzRiVwzJYXtat1O5@google.com>
In-Reply-To: <YzRiVwzJYXtat1O5@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|BN9PR11MB5516:EE_
x-ms-office365-filtering-correlation-id: a45110bb-9f8a-4c0e-b300-08daa1632e0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ak3qGiPwN/+HGixHQjmulKEEe3WO7reCSV6lOxO5SINdASXoIQC7Q7H4dTiWZTVBWSXoOSDBguw074OUdlYx6dS+NFGikXuTTdOCPp0a8sY/sraT2MXjwMJbEBMRqK/8LVMwFNpJ/Y880D7BjhXhgPwGzFEn6YbbILvXR8Stc2xst9+iu5EeZHMeK25/r4fOtHsPCSqMQQxohcgLnaEdDzdtqtz0YMnUKSbmXh8FLwvJG3hIs7DZbJrPJSsOi9tQCKcCckNakvfUz53R3LXEPuiy4+3ZucqVy7QfkGZ8r9ZMOJFx4UEH9+QdR0HfC4cabs8fxjTrSaTMB2HytWUOVMGrJ9U6LopMscI4n4CCpbGRCZ/WcUusseT41pLnLUgHeTZjwXRc63nz08OJ5zJRzURQDjmKMEUAbquiqdSs/EsZSS4LR+8vF+k8g65gZq47fvPBN6FMQySwWwswUivNO9ei8CpHZvkFBrZ3tNH4BPOnGGJILqyVHwRRHFKFnSJx3gYEfLN0B5fB0jxdJ8oUZJ/S0tU2RBvT08Ra6hKZ8cteaQlTNy/02iXuhu+kz2Sj1HwobDrz/oa6u1VOcn1/bHECq3oV4W1TujnrNCY5rED/9vHG1ZDnu7DcKtsEClphfXb6ejgCxuyPPF3XTP/fo26MDk7aVpDUcEDJIf9FEyL2gP/eqacxUCLESd8K6M8iDo8W7xqfWStZDt61F7ArLY25Ao4L6SslgmQKk9QS0sQQglGPKhV/xA0u5OtzAXlvwXFgUrnO5ri060iv+SBPRPFuEhtGMKOU5kKRzvud60ZcE89Xi8mkvwAkWbGC7dIsEL830kL1LvqHICF/FrcM9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(31686004)(2906002)(7416002)(5660300002)(4326008)(64756008)(66446008)(38100700002)(36756003)(316002)(8936002)(66556008)(66476007)(41300700001)(66946007)(76116006)(122000001)(8676002)(6486002)(54906003)(6916009)(38070700005)(71200400001)(91956017)(478600001)(2616005)(86362001)(6506007)(186003)(966005)(53546011)(31696002)(6512007)(26005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THAwNlRlemRva1kzUjFLRnpnV1dzbjFxM3FiRjNBVWtFUnpBREpPUEx3dHFP?=
 =?utf-8?B?Sm5BTkJVb2pRTjN2UTZuSHNxRy9mSTl4VUhOeFAvbnFJeHNIUFoxa3lPVkxx?=
 =?utf-8?B?Rmg5S20zMG00NHlZTGFwVS9GTkU4UXNaVnIxdE41M3JFL1Q4d0J1UEVpbUlI?=
 =?utf-8?B?K09Jc0hXV1NGcDFxMm1VZU0ra0xGczU0S0JUNGhlM2JjTm5zcVBTYmNkbFRK?=
 =?utf-8?B?N3c2TzlHZ1NIR3k3M0tyMTRPQlBqNVZMMFpSaCtxVGg5dHpmRkJwSTNuVnhS?=
 =?utf-8?B?VXpoTGY4c3FoQWFscWFNbVVMdmFhWHd4NTJpNDkxeitsUEZqckQrZUxwVTl3?=
 =?utf-8?B?cDlZZkpMVG91aWhiWmxGTGs4TWN0UDNJLzRDNjN3SW1leUtPd2NDckZTUnRh?=
 =?utf-8?B?akNXQjA4R2xGY2FNcUo0d0xCMDNJb1A0SmMyTFVuemo1L1d1NVZha0VpR0ZQ?=
 =?utf-8?B?eWxVNDlKRHNaV05kMDg5WWZQbkFzMXJ2cG9zQktsKzJ5ZnhyanVFbytrTklZ?=
 =?utf-8?B?T2V6RkhUb2hVNG8wNDhkSzRWLzl2emplSGFTZjVRM3pZdjhXc0t5WkR6dSs1?=
 =?utf-8?B?cDREZUw1WUxCYTJvZEd3QXliSjIxc1c1VEVqcTVDV2J0OWx4dzl6aU9MQ0dl?=
 =?utf-8?B?QUt1MXNsV0RIQksyZFF6bmlGWFFDbjBhZXVFVXR4SWhYUXp1VFpEaEcyZkVI?=
 =?utf-8?B?R1FsQUtOdjF2cFpQd3VjNTdqZ2tMUndBTnVaODlYakVUa25aRGV0U1JWYlVY?=
 =?utf-8?B?OW92UjRRM2ZzKzNDUHJWdytldDh4cHVFamdZZ2FwSEVvR21xeC9wMitTazh1?=
 =?utf-8?B?d1RBUjFpQkZVVmI5SlZncllwenVTZGFyWlBqQU0rV2R3ZVdaLzJzNHcyNm1y?=
 =?utf-8?B?d0pSdDNNZ1hPM3dxNlZxOU0xRTRJN2RCSHg2czZMVnZDeTcvUGxnSEFGY0RN?=
 =?utf-8?B?SklFckpCcDhNT3AyVjg5K1hhMTJFM1hadmptclpTSkRtYmJtejZPRElwTkdz?=
 =?utf-8?B?Yk9NdE1oT01Vb0VkSk0waGU3Tm0wMXR4SkxXSGprSEhialBWYlNlSWJUMUky?=
 =?utf-8?B?STdoYVErYXR5NElncCtJc1VROUJMZVlDeTNEd0xFRGJEd3pwUjhuTFdxbjRZ?=
 =?utf-8?B?VHpHL3VNbkRUUjF1eXJ2c1VSL0tFUXorekY2TGZBUTlsbG9MdTJGaUdDWTVT?=
 =?utf-8?B?SzdxUXY2M01nR3JqdkhuMDRVL0lqN0VjbVJtMi9ycVBUVVZ6d3FzZ29EVThl?=
 =?utf-8?B?d2pBSmQ3SUJyK25DblYrclY2WFhBYndUb1pRZmNGZ2FhbU52SWlScFRFVUdk?=
 =?utf-8?B?V1ZRMElzY0pGbjQ2RHBHdkFuUmh0SXp2eVd1S21YMVFTSHZKZCt2VFBHa1RN?=
 =?utf-8?B?ZWhzTkRsUHVCWmdRQXpnZFE0NG9GYXlCYmhWSkdDUS9RdEluVEtTQUUvRG9P?=
 =?utf-8?B?SkxtN3R4YmNGaFZxa0YwcnBtQW1WY2NjMkt6Y2Jka05nZDRXU01SNHRpaDVV?=
 =?utf-8?B?RVBlVG9BTDJKZXdWR2UyMkxpNjhoMnVRbTBOd3FsalplUVRSNitlVTZ5dkFk?=
 =?utf-8?B?Q3J0R0MyeHQ4aThJb3ErWk5ZR1FlR0VaK04yc2ZYRXBUdzEvUE9SLzR2cTYz?=
 =?utf-8?B?ZENJZ0xobkZqR1g4ME1QVlJCL2ZGYlBhdzVZR21ScnFrT0hMVmg1dXVtRlZB?=
 =?utf-8?B?a2RkWk10MmwrWHY5KytIUXgvOG5OcWw1YXpGUWh1aTJYQzhqNldxNld1Yzd5?=
 =?utf-8?B?NW5yVkpVZW80bEZKV0dMd3BlZGREeWc0YkpRN3pUT0w0WmtUQTQvajdseE12?=
 =?utf-8?B?VkNxYUZTOHFpQXBocUtweVNlWlNNN2tFR3p4WGZnejJQZzhBdDJtL0YwZUlx?=
 =?utf-8?B?ZytxbVBUYytSQSt6NzZ1Nmwwc2tUQXBLdXZIcC90NUFaSzFLZVhjK25KUk44?=
 =?utf-8?B?YnhqcU1PMWsvT24zQWQ0Y21Wa1JuVVVNNzVodjJna0VvdVlYdktWN0U3RGlB?=
 =?utf-8?B?UVRPZW1veWl6TzVlbWIvVkdKTWh1RUN2Z2x3Smp2NVpzN0FDc0xtVUVNeU9F?=
 =?utf-8?B?UlduQVNBMktob042cG41K3FLc0xMODNHNXJjUGxPVFhDTG9Zakk5WFhaUzZl?=
 =?utf-8?Q?uUZQK2P2V9uSNz09MnXQ75juT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69EB307164513B45BCBF67F9EFADF409@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45110bb-9f8a-4c0e-b300-08daa1632e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 15:07:37.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAWQ2R36BVikh13WP4VzG74XQ+0iv6CdjF5w/8O7NIBL0V6mU2UYxSHbnEYSKogdY7PTuGtUMfgTvXsNf5+2mknBowgfZAmtRqz72zUg2tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjguMDkuMjAyMiAxODowMywgTGVlIEpvbmVzIHdyb3RlOg0KPiBPbiBUaHUsIDIyIFNlcCAy
MDIyLCBTZXJnaXUgTW9nYSB3cm90ZToNCj4gDQo+PiBBbm90aGVyIGZ1bmN0aW9uYWxpdHkgb2Yg
RkxFWENPTSBpcyB0aGF0IG9mIFNQSS4gSW4gb3JkZXIgZm9yDQo+PiB0aGUgcHJvcGVyIHZhbGlk
YXRpb24gb2YgdGhlIFNQSSBjaGlsZHJlbiBub2RlcyB0aHJvdWdoIHRoZSBiaW5kaW5nDQo+PiB0
byBvY2N1ciwgdGhlIHByb3BlciBiaW5kaW5nIGZvciBTUEkgbXVzdCBiZSByZWZlcmVuY2VkLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAu
Y29tPg0KPj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4NCj4+DQo+PiB2MSAtPiB2MjoNCj4+IC0gdXNl
IGZ1bGwgc2NoZW1hIHBhdGhzDQo+Pg0KPj4NCj4+IHYyIC0+IHYzOg0KPj4gLSBBZGRlZCBSZXZp
ZXdlZC1ieSB0YWcsIHByZXZpb3VzbHkgdGhpcyB3YXMgW1BBVENIIDNdDQo+Pg0KPj4NCj4+IHYz
IC0+IHY0Og0KPj4gLSBOb3RoaW5nLCBwcmV2aW91c2x5IHRoaXMgd2FzIFtQQVRDSCA1XQ0KPj4N
Cj4+DQo+PiB2NCAtPiB2NToNCj4+IC0gTm90aGluZw0KPj4NCj4+DQo+Pg0KPj4gICAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsc2FtYTVkMi1mbGV4Y29tLnlhbWwgICAgICAgfCA1
ICsrLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+IA0KPiBOb3Qgc3VyZSBob3cgdGhlc2UgY2FuIGJlIGhhbmRsZWQuDQo+IA0KPiBJIGd1
ZXNzIEkgY2Fubm90IHRha2UgdGhlc2UgdW50aWwgdGhlIG90aGVyIHBhdGNoZXMgYXJlIGFwcGxp
ZWQuDQo+IA0KPiBOQjogVGhlIHBhdGNoIGRvZXNuJ3QgYXBwbHkgY2xlYW5seSBhbnl3YXksIHNv
IHdpbGwgbmVlZCB0byBiZSByZWJhc2VkLg0KPiANCg0KDQpIZWxsbywNCg0KVGhlIHNhbWE1ZDIt
ZmxleGNvbSBiaW5kaW5nIHJlbGF0ZWQgcGF0Y2hlcyBhcmUgZGVwZW5kZW50IG9uOg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDIyMDkxNjA3NTc0NC4xODc5NDI4
LTEta2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5jb20vDQoNCmFzIHNwZWNpZmllZCBpbiB0
aGUgY292ZXIgbGV0dGVyLg0KDQpSZWdhcmRzLA0KCVNlcmdpdQ0KDQoNCj4+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLHNhbWE1ZDItZmxl
eGNvbS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxz
YW1hNWQyLWZsZXhjb20ueWFtbA0KPj4gaW5kZXggMGM4MGY0ZTk4YzU0Li5mMjgzY2ZkODRiMmQg
MTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0
bWVsLHNhbWE1ZDItZmxleGNvbS55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWZkL2F0bWVsLHNhbWE1ZDItZmxleGNvbS55YW1sDQo+PiBAQCAtNzgsMTAg
Kzc4LDkgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+PiAgICAgICAgIG9mIFVTQVJUIGJpbmRpbmdz
Lg0KPj4NCj4+ICAgICAiXnNwaUBbMC05YS1mXSskIjoNCj4+IC0gICAgdHlwZTogb2JqZWN0DQo+
PiArICAgICRyZWY6IC9zY2hlbWFzL3NwaS9hdG1lbCxhdDkxcm05MjAwLXNwaS55YW1sDQo+PiAg
ICAgICBkZXNjcmlwdGlvbjoNCj4+IC0gICAgICBDaGlsZCBub2RlIGRlc2NyaWJpbmcgU1BJLiBT
ZWUgLi4vc3BpL3NwaV9hdG1lbC50eHQgZm9yIGRldGFpbHMNCj4+IC0gICAgICBvZiBTUEkgYmlu
ZGluZ3MuDQo+PiArICAgICAgQ2hpbGQgbm9kZSBkZXNjcmliaW5nIFNQSS4NCj4+DQo+PiAgICAg
Il5pMmNAWzAtOWEtZl0rJCI6DQo+PiAgICAgICAkcmVmOiAvc2NoZW1hcy9pMmMvYXRtZWwsYXQ5
MXNhbS1pMmMueWFtbA0KPiANCj4gLS0NCj4gTGVlIEpvbmVzIFvmnY7nkLzmlq9dDQoNCg==
