Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A05BFD56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIULur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiIULuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:50:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C1B854;
        Wed, 21 Sep 2022 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663760983; x=1695296983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nzNYvcOAd+V2bxmKPLaPpyS3vQWjlJkynrLAsFXAJiQ=;
  b=H0LzjNuGfP0NREFm8ISI8NNfPX1/qP5OQR3FBJu+yiFJ/cT8NMPCNday
   qTRHzYr1eZ3ZxGlGDoYR79eoxhvLfdFyoGPYWpkcaXiDmOKWg4jxAsR6j
   auB9JNQmRiSetxSxOKdPq8Cn8mETYeU5fI0dsRx8ELUMflGYh3FfjhZXv
   4PYzgl+jX1IpfL0buqox1lHBW6J8PU2/mBuhX1ONElJ/D+9KveBQW9ndQ
   uab1p+xThLso8T7fDCpCI8X/Qcx90DgicMWL4mxTPJUQhbFcqO/ZJ2yRo
   Sg6/00GWgGLHpVtBj8STLI0lla5kLK4Lb3iD1ufnUf4KY223CtLjd6D4y
   A==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="191798026"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2022 04:49:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 21 Sep 2022 04:49:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 21 Sep 2022 04:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvciedJRxOnBB5ttQSk4NEkEmjUMlktWobWWYDJ1FR/Wecy9/4p6XSzeni1ef3J+9+2BiyYKWMiKMfI3HTTIjmVx4kwGOXVzitEJ2Xdkt0TlNcv3GEEQ4IJwAHYUFWPUcyML4kLO5AxLBlGtpZA+NAivc92dzKHCjKt45kN5VtHbfFB54Ifmo+c0FZFnK4gguDFll06oAa8O6zVvg8LJc6GW7NTpRtpk5Io+i4hOWr1kJuO5R1gQymQeLue6UJ/f9WW5Irr1f+eMi445ta28WzhKZfrgc+6aLo8Z+UXBw5Ts/nlTNMm9y/eYTqFR3N1xdk58e5H9id8wg53GqAHuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzNYvcOAd+V2bxmKPLaPpyS3vQWjlJkynrLAsFXAJiQ=;
 b=l4xgbgR7c90Awzhrk1dy2T04Nr3PBtB3zhePoixLOhMoYmsWo/WM0G4Bc1uxDrp0WxYhoe0YH4PuuaD62n1dkUKAA2oEpWXfj38QK1NYXVwAoxKS8f5izOlYtlzF2UINIiQFNQurM4HKqBH2BEShd5gCuJ6HUovAR2BHvVdMY+E5/689Aa4JwUYrDMOcw46KNjUv+FdPzMniHJi6OHgK559xPydQIUEZVvQEP+u3yl6abYJUkK1A7diAXY3WLltF6rynk33BIxsLYlbBAkzCtoMhYAU+MzK33zh8zricC9/XwKADFiBuhGQlKopNIAbrIHCvsF6hJpQvqYfqu2hDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzNYvcOAd+V2bxmKPLaPpyS3vQWjlJkynrLAsFXAJiQ=;
 b=pmzb9GEL1U9HXIXkgNjOkUSATsNMN4NkRlMY2pnHs0ueraYxqJ89XpQAe/Ath9LoRdZwp/8qNLSnhxVXp9zJ/rvqT56P/IXkTAu8VKkDLyk4NveikWIxNF8KIL378QORVd2GSulhdC2u9xgytRA+yscYCm4zE5go5kFU7EXFdCE=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 11:49:34 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::2cfd:fc73:ba36:ae64]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::2cfd:fc73:ba36:ae64%4]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 11:49:33 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 9/9] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Topic: [PATCH v4 9/9] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Index: AQHYzDqe0wl2uU+iSEmCXg4v70M/fK3pY9qAgAAKDACAAFoUAA==
Date:   Wed, 21 Sep 2022 11:49:33 +0000
Message-ID: <de576d19-4132-c039-f543-8800024f87a7@microchip.com>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com>
 <20220919150846.1148783-10-sergiu.moga@microchip.com>
 <342f5733-25df-9409-2a15-47b3f801a4a7@microchip.com>
 <2894e7db-78b1-59ee-ad5f-e45c8597e9cf@microchip.com>
In-Reply-To: <2894e7db-78b1-59ee-ad5f-e45c8597e9cf@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|CH0PR11MB5332:EE_
x-ms-office365-filtering-correlation-id: bc4d4426-e714-40a1-ecaa-08da9bc75a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92abCt3Sh3ShmOzd9Cgt3M7tT4F4Xj4F+xhsBw2C3S9Lc4v6JkkyQNwV8R6Hz87CSaPGn1DQFBNXrTz1LjlAzobdliGhFHxFta6CLGq+nF9VMM3JhkFkLPBv8wciBkVFE0tczHxfNMY1QLNURPZnvjb1ZyuJGbS7TciJHIji063u1NOou8fd6gKv1BgEOlR/FuZ2DOfx+Auhta3eLhB6KLIkn8EcFIeOtfD46VpJb+m7VQyVE2qAfdK04MHqLT2pY3diDXrzGd6F5BeGmHbYu3L5CssShTImWjn+eyuv1jz3naH7ooRxof8CrW0B8V6rg+PCx+fbpI7ldVIXMCImloJDKFxcFvfojxD7F7+V7ge/iV+t+MeCkPs6cUxkSHNGW3z0VHRJr2XnEhubGbyvx7UuaMpL/UXoZ7lVBrWim5a7RyiZcTqSoKq8FbtCuBdX1p/iEumeOTPJbxn5kalXvmdIvl4uKvtE4c8oELN2RrbPRdupmgBTpM/vUJOrChH2rYJp4uOzK43kU2n8GQxlPeYJMchb5b5NRaNB9Jz0yN9LitDRUDLANkVO8oZFY+IoadqsuHVjgKGFEj0usTOuz0a8WQ0NUlqtJu0DNhqS5Qh7z8865siCruvKfDgZ8TNoWBq3TbTPWM3+v5IUJBw8SrwdMCvxb5uLOxU4EEoLVJFzC4siAMkWhg19UNJmbL6jtuoDm9ILbF0LDwKTf1KkgYkF4hLE7cjVbxkiddsuO66zxgwHKu1eWdKWKK1CPE/iufwTq7tnBxO1JjDioeuzl+kytl/s9BZF8NbomqtUn1E1OhbmeAYduivNmiYEvBAE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(6506007)(53546011)(83380400001)(41300700001)(186003)(2616005)(36756003)(6512007)(26005)(86362001)(31696002)(31686004)(921005)(38070700005)(38100700002)(122000001)(64756008)(66556008)(66476007)(66946007)(8936002)(66446008)(8676002)(4326008)(91956017)(316002)(5660300002)(7416002)(76116006)(110136005)(54906003)(2906002)(6636002)(6486002)(478600001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1poaE5KZ05KT05NaG9PV1lLYnBRUGtLVjFheDBVMVd0WkN6cEtDZ1RJekhR?=
 =?utf-8?B?NmI0ankyeE1IWElrK3h3V0c5ektnc2s2cXN0eUs1MG5DSkEzQ29PY1V5R0ly?=
 =?utf-8?B?d3grbmxxYWRkb2pQNzg2RDN5Q2ViYU5QUElaWEh1OW5WSXVXTnJTTXRIVElO?=
 =?utf-8?B?Y29lS3FORE1KTDlwUEpuV2g3N2o1Nk5IRWdNM0JraWRJZks3VkNpN1Jkc2NN?=
 =?utf-8?B?aVhaWmNQWHdNQi9jUjl3c1RSMzJaOTA0TUJ6bzJ6QTRmU2tQME14Z3ZtaGVM?=
 =?utf-8?B?OXNucDNjUGo4OHEzWUFnd0t2TzdHMXdkUy85TE9rbzJDQmowQ2JWTk1ucHBW?=
 =?utf-8?B?NFZFMDlGQldpeFE2VDlhcG1odVJibUgrWWRjVTNIYjFPemNPZUVNTktxTkI0?=
 =?utf-8?B?YWgwbGNEZ3oxbmpEeFpiSXFRbGlUWXdGdGc5UWhkMVFsODF4Y3MzY1U4aFdX?=
 =?utf-8?B?VnZlQlN2UmkzUDZjL1B5WXZJN2ZtWGxTUGNpZnJNNTd3b2ZTU2pPVnRCTGlJ?=
 =?utf-8?B?Tk1KYnFQSEU5NzdmZjQyZXl2QXpkTExacStvTTBQc1B2MS8xQW85MzRCMXQ0?=
 =?utf-8?B?dzBTNnZLYjI0M2h0OWZIR1F4TWFUR0hRMjRhaXFNOFpBTDNpZDlncGRqWnEz?=
 =?utf-8?B?VFUrTjdjQVdTT203WjB0UnFoaTFsZnhkanJkd3JrQVg4MWpUWXNxcUgwdXRj?=
 =?utf-8?B?c2Npck1ORStWRVZLbnhoMGxEOGdheGhJSzFLb2Jqd1BxZWdYb01DWnhvU3p3?=
 =?utf-8?B?K2JKOWdsYVZWSmxOT3QxUDZ3ZHpYeldtQzBQY3JxSnlYeWMyZEdxR3M0dDU0?=
 =?utf-8?B?aTdxeS9sc2g2WkF5VCs5bEZJWjZsRmJOZGlFWVFQRDZqZFhJNmhJSHpvVGg3?=
 =?utf-8?B?TWphNmNjMWI1OFM3OVZIYUpjWVpjZEFCNy9GY2NadkFialYyVWlrUDQzTnlB?=
 =?utf-8?B?dGgxT0w1T1dVSG9MTWVFSzRMdFMrZk5wTE9SRy9lTFZ5OUFKaW1YdE5WeUFs?=
 =?utf-8?B?bFMvUE80Y0xXMDd5N3pDL2FmQU12M3p0Qmc0WjU2OFE1TUZuUkk3ODBzeUl5?=
 =?utf-8?B?UllvOUVRRU9vUGVXQjEvZXUzcGdTalNoMnF6NFpYQmdCVk1vRGJCdGFUWm11?=
 =?utf-8?B?YWdUenp5WFFFVmNQcWJQVjZrS082TUNlWXlIRDVUU0ZxN0s2UFpwQ0VCaGd1?=
 =?utf-8?B?NkNUTWdnODVrZWxwRUo5U2tiaVY4Tmt3VDBCWFZVSk8xWkVid3FOd1M2N3E1?=
 =?utf-8?B?aHU0eWw0eCt0amltU1E1dmkwZDJLZlZkZHM3RGdNcTkrNGd0M1M2aEFyMkpr?=
 =?utf-8?B?NEt5bElPQjFUS1J1SGE4MFE1YmRLem9LemxoWEFIMDdVazhRVUJQcXFybnVJ?=
 =?utf-8?B?UmsyaDRmMEJ6N29KbENUODljMW12YlFrMXg0bHdOSEx6WnNxV0RKSVo4YnFO?=
 =?utf-8?B?YllDNzdYZXRkRDhjRHltY21yUm1mUEVBV21oeE9WcFhSUWJhZTVhK3Y2SXJL?=
 =?utf-8?B?OGZaQW5KZFE0aWgrOXBieUpJMkY5akRLVjAvSThla1RwZis2QmdCYlowa0tu?=
 =?utf-8?B?QnkzYWR0enZNQklMUnRRNXBMWWh2UUM3QUJIc0JRbnVCVCtVam93V2FnejZ1?=
 =?utf-8?B?ak1Qd3J0cGQ0UUJnUVAzcklHYlRIR0FHWHhTQVQ5bUhzMTZwYVUwcHJ4Z21i?=
 =?utf-8?B?SU9wdEx4Y3dkTE1PdjZEY2xWVnRjK1pBd3M3QjgyalFDT3JxYXo4MTMyalFJ?=
 =?utf-8?B?QStiM0V4bzhpMEl4c1IxQm9tQ1AwM0VPbXF6d3hYZno2a3NpRW95Q3dQSS9Z?=
 =?utf-8?B?MlI1VVZWeEV2Tm5kTTJIR1FVenpGVjAxOUFzM2wrMC9KZGRHMHFlOXFnZ3oy?=
 =?utf-8?B?aXNJUlRzRkZqRnZ0Q0M2SWx5T1BnY0E1VWw0bVpXOXVrQlBpMWJWakUyQnFn?=
 =?utf-8?B?RjBwNlZPSktveUl4NXV4aVkrY1JHUnBxd3ZJdDZjS2ZtMG9Wa1dpVHpsVVBW?=
 =?utf-8?B?Wk1hNkZrenVPT0lKZVhoczI2aURoKzlwaXI2Vk15eDBuTFNDZUc5eXFkaGFq?=
 =?utf-8?B?OG1WeGFjU3Z1b1hIQjFWTVB1dmpLWi8rWU05alpCM1IzTDV4TkE4dGZMVFcr?=
 =?utf-8?Q?6uDL3Hlq+qzMVTkPG9151L0rl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DDB29EFD1F81F43BB1BB6B77BA2A274@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4d4426-e714-40a1-ecaa-08da9bc75a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 11:49:33.8177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpGr7x6fA2pmrw/DVdy8RD/goOariEY4HHiOAsMUlLdn/aMDFyA3ZlAKn5rTk+iCDAG4vzITS6gb+pQxt/WJACxEJ7u0QKkQB3f6vAzHgJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5332
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEuMDkuMjAyMiAwOToyNywgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDIxLjA5LjIwMjIgMDg6NTEsIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0KPj4gT24g
MTkuMDkuMjAyMiAxODowOCwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+Pj4gUHJldmlvdXNseSwgdGhl
IGF0bWVsIHNlcmlhbCBkcml2ZXIgZGlkIG5vdCB0YWtlIGludG8gYWNjb3VudCB0aGUNCj4+PiBw
b3NzaWJpbGl0eSBvZiB1c2luZyB0aGUgbW9yZSBjdXN0b21pemFibGUgZ2VuZXJpYyBjbG9jayBh
cyBpdHMNCj4+PiBiYXVkcmF0ZSBnZW5lcmF0b3IuIFVubGVzcyB0aGVyZSBpcyBhIEZyYWN0aW9u
YWwgUGFydCBhdmFpbGFibGUgdG8NCj4+PiBpbmNyZWFzZSBhY2N1cmFjeSwgdGhlcmUgaXMgYSBo
aWdoIGNoYW5jZSB0aGF0IHdlIG1heSBiZSBhYmxlIHRvDQo+Pj4gZ2VuZXJhdGUgYSBiYXVkcmF0
ZSBjbG9zZXIgdG8gdGhlIGRlc2lyZWQgb25lIGJ5IHVzaW5nIHRoZSBHQ0xLIGFzIHRoZQ0KPj4+
IGNsb2NrIHNvdXJjZS4gTm93LCBkZXBlbmRpbmcgb24gdGhlIGVycm9yIHJhdGUgYmV0d2Vlbg0K
Pj4+IHRoZSBkZXNpcmVkIGJhdWRyYXRlIGFuZCB0aGUgYWN0dWFsIGJhdWRyYXRlLCB0aGUgc2Vy
aWFsIGRyaXZlciB3aWxsDQo+Pj4gZmFsbGJhY2sgb24gdGhlIGdlbmVyaWMgY2xvY2suIFRoZSBn
ZW5lcmljIGNsb2NrIG11c3QgYmUgcHJvdmlkZWQNCj4+PiBpbiB0aGUgRFQgbm9kZSBvZiB0aGUg
c2VyaWFsIHRoYXQgbWF5IG5lZWQgYSBtb3JlIGZsZXhpYmxlIGNsb2NrIHNvdXJjZS4NCj4+Pg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29t
Pg0KPj4NCj4+IFJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWlj
cm9jaGlwLmNvbT4NCj4gDQo+IEFjdHVhbGx5LCBJJ20gdGFraW5nIHRoaXMgYmFjayBhdCB0aGUg
bW9tZW50Lg0KPiANCj4+DQo+Pg0KPj4+IC0tLQ0KPj4+DQo+Pj4NCj4+PiB2MSAtPiB2MjoNCj4+
PiAtIHRha2UgaW50byBhY2NvdW50IHRoZSBkaWZmZXJlbnQgcGxhY2VtZW50IG9mIHRoZSBiYXVk
cmF0ZSBjbG9jayBzb3VyY2UNCj4+PiBpbnRvIHRoZSBJUCdzIE1vZGUgUmVnaXN0ZXIgKFVTQVJU
IHZzIFVBUlQpDQo+Pj4gLSBkb24ndCBjaGVjayBmb3IgYXRtZWxfcG9ydC0+Z2NsayAhPSBOVUxM
DQo+Pj4gLSB1c2UgY2xrX3JvdW5kX3JhdGUgaW5zdGVhZCBvZiBjbGtfc2V0X3JhdGUgKyBjbGtf
Z2V0X3JhdGUNCj4+PiAtIHJlbW92ZSBjbGtfZGlzYWJsZV91bnByZXBhcmUgZnJvbSB0aGUgZW5k
IG9mIHRoZSBwcm9iZSBtZXRob2QNCj4+Pg0KPj4+DQo+Pj4NCj4+PiB2MiAtPiB2MzoNCj4+PiAt
IGFkZCB0aGUgZXJyb3IgcmF0ZSBjYWxjdWxhdGlvbiBmdW5jdGlvbiBhcyBhbiBpbmxpbmUgZnVu
Y3Rpb24gaW5zdGVhZCBvZg0KPj4+IGEgbWFjcm8gZGVmaW5pdGlvbg0KPj4+IC0gYWRkIGBnY2xr
X2ZhaWxgIGdvdG8NCj4+PiAtIHJlcGxhY2UgYGdvdG8gZXJyYCB3aXRoIGBnb3RvIGVycl9jbGtf
ZGlzYWJsZV91bnByZXBhcmU7YA0KPj4+DQo+Pj4NCj4+Pg0KPj4+IHYzIC0+IHY0Og0KPj4+IC0g
Tm90aGluZywgdGhpcyB3YXMgcHJldmlvdXNseSBbUEFUQ0ggMTRdDQo+Pj4NCj4+Pg0KPj4+ICAg
ZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIHwgNTkgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRt
ZWxfc2VyaWFsLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+PiBpbmRl
eCBjOTgzNzk4YTRhYjIuLjQyNmY5ZDRmOWE1YSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3R0
eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRt
ZWxfc2VyaWFsLmMNCj4+PiBAQCAtMTUsNiArMTUsNyBAQA0KPj4+ICAgI2luY2x1ZGUgPGxpbnV4
L2luaXQuaD4NCj4+PiAgICNpbmNsdWRlIDxsaW51eC9zZXJpYWwuaD4NCj4+PiAgICNpbmNsdWRl
IDxsaW51eC9jbGsuaD4NCj4+PiArI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPj4+
ICAgI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4NCj4+PiAgICNpbmNsdWRlIDxsaW51eC9zeXNy
cS5oPg0KPj4+ICAgI2luY2x1ZGUgPGxpbnV4L3R0eV9mbGlwLmg+DQo+Pj4gQEAgLTExMCw2ICsx
MTEsNyBAQCBzdHJ1Y3QgYXRtZWxfdWFydF9jaGFyIHsNCj4+PiAgIHN0cnVjdCBhdG1lbF91YXJ0
X3BvcnQgew0KPj4+ICAgCXN0cnVjdCB1YXJ0X3BvcnQJdWFydDsJCS8qIHVhcnQgKi8NCj4+PiAg
IAlzdHJ1Y3QgY2xrCQkqY2xrOwkJLyogdWFydCBjbG9jayAqLw0KPj4+ICsJc3RydWN0IGNsawkJ
KmdjbGs7CQkvKiB1YXJ0IGdlbmVyaWMgY2xvY2sgKi8NCj4+PiAgIAlpbnQJCQltYXlfd2FrZXVw
OwkvKiBjYWNoZWQgdmFsdWUgb2YgZGV2aWNlX21heV93YWtldXAgZm9yIHRpbWVzIHdlIG5lZWQg
dG8gZGlzYWJsZSBpdCAqLw0KPj4+ICAgCXUzMgkJCWJhY2t1cF9pbXI7CS8qIElNUiBzYXZlZCBk
dXJpbmcgc3VzcGVuZCAqLw0KPj4+ICAgCWludAkJCWJyZWFrX2FjdGl2ZTsJLyogYnJlYWsgYmVp
bmcgcmVjZWl2ZWQgKi8NCj4+PiBAQCAtMjI5LDYgKzIzMSwxMSBAQCBzdGF0aWMgaW5saW5lIGlu
dCBhdG1lbF91YXJ0X2lzX2hhbGZfZHVwbGV4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQo+Pj4g
ICAJCShwb3J0LT5pc283ODE2LmZsYWdzICYgU0VSX0lTTzc4MTZfRU5BQkxFRCk7DQo+Pj4gICB9
DQo+Pj4gICANCj4+PiArc3RhdGljIGlubGluZSBpbnQgYXRtZWxfZXJyb3JfcmF0ZShpbnQgZGVz
aXJlZF92YWx1ZSwgaW50IGFjdHVhbF92YWx1ZSkNCj4+PiArew0KPj4+ICsJcmV0dXJuIDEwMCAt
IChkZXNpcmVkX3ZhbHVlICogMTAwKSAvIGFjdHVhbF92YWx1ZTsNCj4+PiArfQ0KPj4+ICsNCj4+
PiAgICNpZmRlZiBDT05GSUdfU0VSSUFMX0FUTUVMX1BEQw0KPj4+ICAgc3RhdGljIGJvb2wgYXRt
ZWxfdXNlX3BkY19yeChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPj4+ICAgew0KPj4+IEBAIC0y
MTE3LDYgKzIxMjQsOCBAQCBzdGF0aWMgdm9pZCBhdG1lbF9zZXJpYWxfcG0oc3RydWN0IHVhcnRf
cG9ydCAqcG9ydCwgdW5zaWduZWQgaW50IHN0YXRlLA0KPj4+ICAgCQkgKiBUaGlzIGlzIGNhbGxl
ZCBvbiB1YXJ0X2Nsb3NlKCkgb3IgYSBzdXNwZW5kIGV2ZW50Lg0KPj4+ICAgCQkgKi8NCj4+PiAg
IAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGF0bWVsX3BvcnQtPmNsayk7DQo+Pj4gKwkJaWYgKF9f
Y2xrX2lzX2VuYWJsZWQoYXRtZWxfcG9ydC0+Z2NsaykpDQo+Pj4gKwkJCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4+PiAgIAkJYnJlYWs7DQo+Pj4gICAJZGVmYXVs
dDoNCj4+PiAgIAkJZGV2X2Vycihwb3J0LT5kZXYsICJhdG1lbF9zZXJpYWw6IHVua25vd24gcG0g
JWRcbiIsIHN0YXRlKTsNCj4+PiBAQCAtMjEzMiw3ICsyMTQxLDkgQEAgc3RhdGljIHZvaWQgYXRt
ZWxfc2V0X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwNCj4+PiAgIHsNCj4+PiAgIAlz
dHJ1Y3QgYXRtZWxfdWFydF9wb3J0ICphdG1lbF9wb3J0ID0gdG9fYXRtZWxfdWFydF9wb3J0KHBv
cnQpOw0KPj4+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+Pj4gLQl1bnNpZ25lZCBpbnQgb2xk
X21vZGUsIG1vZGUsIGltciwgcXVvdCwgYmF1ZCwgZGl2LCBjZCwgZnAgPSAwOw0KPj4+ICsJdW5z
aWduZWQgaW50IG9sZF9tb2RlLCBtb2RlLCBpbXIsIHF1b3QsIGRpdiwgY2QsIGZwID0gMDsNCj4+
PiArCXVuc2lnbmVkIGludCBiYXVkLCBhY3R1YWxfYmF1ZCwgZ2Nsa19yYXRlOw0KPj4+ICsJaW50
IHJldDsNCj4+PiAgIA0KPj4+ICAgCS8qIHNhdmUgdGhlIGN1cnJlbnQgbW9kZSByZWdpc3RlciAq
Lw0KPj4+ICAgCW1vZGUgPSBvbGRfbW9kZSA9IGF0bWVsX3VhcnRfcmVhZGwocG9ydCwgQVRNRUxf
VVNfTVIpOw0KPj4+IEBAIC0yMzAyLDYgKzIzMTMsNDYgQEAgc3RhdGljIHZvaWQgYXRtZWxfc2V0
X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwNCj4+PiAgIAkJY2QgPSBtaW5fdCh1bnNp
Z25lZCBpbnQsIGNkLCBBVE1FTF9VU19DRCk7DQo+Pj4gICAJfQ0KPj4+ICAgDQo+Pj4gKwkvKg0K
Pj4+ICsJICogSWYgdGhlcmUgaXMgbm8gRnJhY3Rpb25hbCBQYXJ0LCB0aGVyZSBpcyBhIGhpZ2gg
Y2hhbmNlIHRoYXQNCj4+PiArCSAqIHdlIG1heSBiZSBhYmxlIHRvIGdlbmVyYXRlIGEgYmF1ZHJh
dGUgY2xvc2VyIHRvIHRoZSBkZXNpcmVkIG9uZQ0KPj4+ICsJICogaWYgd2UgdXNlIHRoZSBHQ0xL
IGFzIHRoZSBjbG9jayBzb3VyY2UgZHJpdmluZyB0aGUgYmF1ZHJhdGUNCj4+PiArCSAqIGdlbmVy
YXRvci4NCj4+PiArCSAqLw0KPj4+ICsJaWYgKCFhdG1lbF9wb3J0LT5oYXNfZnJhY19iYXVkcmF0
ZSkgew0KPj4+ICsJCWlmIChfX2Nsa19pc19lbmFibGVkKGF0bWVsX3BvcnQtPmdjbGspKQ0KPj4+
ICsJCQljbGtfZGlzYWJsZV91bnByZXBhcmUoYXRtZWxfcG9ydC0+Z2Nsayk7DQo+Pj4gKwkJZ2Ns
a19yYXRlID0gY2xrX3JvdW5kX3JhdGUoYXRtZWxfcG9ydC0+Z2NsaywgMTYgKiBiYXVkKTsNCj4+
PiArCQlhY3R1YWxfYmF1ZCA9IGNsa19nZXRfcmF0ZShhdG1lbF9wb3J0LT5jbGspIC8gKDE2ICog
Y2QpOw0KPj4+ICsJCWlmIChnY2xrX3JhdGUgJiYgYWJzKGF0bWVsX2Vycm9yX3JhdGUoYmF1ZCwg
YWN0dWFsX2JhdWQpKSA+DQo+Pj4gKwkJICAgIGFicyhhdG1lbF9lcnJvcl9yYXRlKGJhdWQsIGdj
bGtfcmF0ZSAvIDE2KSkpIHsNCj4gDQo+IElmIHRoaXMgY29uZGl0aW9uIGZhaWxzIGFuZCB5b3Ug
cHJldmlvdXNseSB1c2VkIEdDTEsgZm9yIGNsb2NrIGdlbmVyYXRpb24NCj4geW91IHNob3VsZCBy
ZW1vdmUgYml0cyBBVE1FTF9VU19VU0NMS1Mgb3IgQVRNRUxfVUFfQlJTUkNDSyBmcm9tIG1vZGUN
Cj4gdmFyaWFibGUsIHRvIGF2b2lkIGNvbmZpZ3VyaW5nIE1SIHdpdGggR0NMSyBzdXBwb3J0IGFu
ZCBjbG9jayBub3QgYmVpbmcNCj4gcHJvcGVybHkgc2V0dXAuDQo+IA0KDQoNClRoaXMgd2lsbCBu
b3QgaGFwcGVuLCBzaW5jZSB0aGUgY29kZSBibG9jayBwbGFjZWQgYXQgdGhlIHZlcnkgc3RhcnQg
b2YgDQphdG1lbF9zZXRfdGVybWlvcygpDQoNCiAgLyogcmVzZXQgdGhlIG1vZGUsIGNsb2NrIGRp
dmlzb3IsIHBhcml0eSwgc3RvcCBiaXRzIGFuZCBkYXRhIHNpemUgKi8NCiAgICAgbW9kZSAmPSB+
KEFUTUVMX1VTX1VTQ0xLUyB8IEFUTUVMX1VTX0NIUkwgfCBBVE1FTF9VU19OQlNUT1AgfA0KICAg
ICAgICAgICBBVE1FTF9VU19QQVIgfCBBVE1FTF9VU19VU01PREUpOw0KDQp3aWxsIHN0aWxsIGNs
ZWFyIHRoZSBBVE1FTF9VQV9CUlNSQ0NLIGJpdGZpZWxkIHNpbmNlIGl0IGlzIHRoZSBzYW1lIGFz
IA0KdGhlIEFUTUVMX1VTX05CU1RPUCBiaXRmaWVsZC4NCkl0IGlzIHVnbHkgYW5kIGl0IGhhcyBi
ZWVuIHdvcmtpbmcgc28gZmFyIGp1c3QgdGhyb3VnaCB0aGUgY29pbmNpZGVuY2UgDQpvZiB0aGUg
Yml0ZmllbGRzIHBsYWNlbWVudC4NCkkgZGlkIG5vdCB3YW50IHRvIGNoYW5nZSB0aG9zZSBsaW5l
cyBhcyBJIGRpZCBub3QgcmVhbGx5IHRoaW5rIG9mIHRoZW0gDQphcyB3b3J0aCBiZWluZyBwYXJ0
IG9mIHRoaXMgcGF0Y2ggc2VyaWVzIChQQVRDSCA4IG9mIHRoaXMgc2VyaWVzIGlzIGFuIA0KZXhj
ZXB0aW9uIGFzIGl0IGRvZXMgaW50cm9kdWNlIHRoZSBuZWVkZWQgaXNfdXNhcnQgYm9vbGVhbiku
DQpJIHdpbGwgc2VuZCBhIHBhdGNoIHJlZ2FyZGluZyB0aGlzLCBidXQgc2VwYXJhdGVseSBzaW5j
ZSBpdCBpcyBtb3JlIGxpa2UgDQphIHB1cmUgY2xlYW51cCByZWxhdGVkIFBBVENILCBpbiBteSBv
cGluaW9uLg0KDQoNCj4+PiArCQkJY2xrX3NldF9yYXRlKGF0bWVsX3BvcnQtPmdjbGssIDE2ICog
YmF1ZCk7DQo+Pj4gKwkJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShhdG1lbF9wb3J0LT5nY2xr
KTsNCj4+PiArCQkJaWYgKHJldCkNCj4+PiArCQkJCWdvdG8gZ2Nsa19mYWlsOw0KPj4+ICsNCj4+
PiArCQkJaWYgKGF0bWVsX3BvcnQtPmlzX3VzYXJ0KSB7DQo+Pj4gKwkJCQltb2RlICY9IH5BVE1F
TF9VU19VU0NMS1M7DQo+Pj4gKwkJCQltb2RlIHw9IEFUTUVMX1VTX1VTQ0xLU19HQ0xLOw0KPj4+
ICsJCQl9IGVsc2Ugew0KPj4+ICsJCQkJbW9kZSAmPSB+QVRNRUxfVUFfQlJTUkNDSzsNCj4+PiAr
CQkJCW1vZGUgfD0gQVRNRUxfVUFfQlJTUkNDS19HQ0xLOw0KPj4+ICsJCQl9DQo+Pj4gKw0KPj4+
ICsJCQkvKg0KPj4+ICsJCQkgKiBTZXQgdGhlIENsb2NrIERpdmlzb3IgZm9yIEdDTEsgdG8gMS4N
Cj4+PiArCQkJICogU2luY2Ugd2Ugd2VyZSBhYmxlIHRvIGdlbmVyYXRlIHRoZSBzbWFsbGVzdA0K
Pj4+ICsJCQkgKiBtdWx0aXBsZSBvZiB0aGUgZGVzaXJlZCBiYXVkcmF0ZSB0aW1lcyAxNiwNCj4+
PiArCQkJICogdGhlbiB3ZSBzdXJlbHkgY2FuIGdlbmVyYXRlIGEgYmlnZ2VyIG11bHRpcGxlDQo+
Pj4gKwkJCSAqIHdpdGggdGhlIGV4YWN0IGVycm9yIHJhdGUgZm9yIGFuIGVxdWFsbHkgaW5jcmVh
c2VkDQo+Pj4gKwkJCSAqIENELiBUaHVzIG5vIG5lZWQgdG8gdGFrZSBpbnRvIGFjY291bnQNCj4+
PiArCQkJICogYSBoaWdoZXIgdmFsdWUgZm9yIENELg0KPj4+ICsJCQkgKi8NCj4+PiArCQkJY2Qg
PSAxOw0KPj4+ICsJCX0NCj4+PiArCX0NCj4+PiArDQo+Pj4gK2djbGtfZmFpbDoNCj4+PiAgIAlx
dW90ID0gY2QgfCBmcCA8PCBBVE1FTF9VU19GUF9PRkZTRVQ7DQo+Pj4gICANCj4+PiAgIAlpZiAo
IShwb3J0LT5pc283ODE2LmZsYWdzICYgU0VSX0lTTzc4MTZfRU5BQkxFRCkpDQo+Pj4gQEAgLTI4
OTcsNiArMjk0OCwxMiBAQCBzdGF0aWMgaW50IGF0bWVsX3NlcmlhbF9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICAgCWlmIChyZXQpDQo+Pj4gICAJCWdvdG8gZXJyOw0K
Pj4+ICAgDQo+Pj4gKwlhdG1lbF9wb3J0LT5nY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZw
ZGV2LT5kZXYsICJnY2xrIik7DQo+Pj4gKwlpZiAoSVNfRVJSKGF0bWVsX3BvcnQtPmdjbGspKSB7
DQo+Pj4gKwkJcmV0ID0gUFRSX0VSUihhdG1lbF9wb3J0LT5nY2xrKTsNCj4+PiArCQlnb3RvIGVy
cl9jbGtfZGlzYWJsZV91bnByZXBhcmU7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICAgCXJldCA9IGF0
bWVsX2luaXRfcG9ydChhdG1lbF9wb3J0LCBwZGV2KTsNCj4+PiAgIAlpZiAocmV0KQ0KPj4+ICAg
CQlnb3RvIGVycl9jbGtfZGlzYWJsZV91bnByZXBhcmU7DQo+Pg0KPiANCg0K
