Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A075B55B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiILIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILIGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:06:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156601BEBF;
        Mon, 12 Sep 2022 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662969985; x=1694505985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FIstPrAUkE8iAFPtm+LsWP/af9oWUp3m/GKfxBzBAwc=;
  b=PelOxcHzTiK48MVWQLix4R2NbBiP2Oowhv5ecFOKNfoFlfq64G0Y3pxA
   jHCXqrFl4Ps3TZ3AV1ZdCkRPzTH7W6O5tvxmRN6QD2Cf0pvtiKkzTApcX
   CKq1CMOxwz5PwUR9o9wvYQIFyTiDAsR384tBWgSHyGr9KPpTy9ljI0YxM
   pzjmhgFz9JKPHrPztgtPlhpjnz1B8Yjv3BnUS4JxWVxCen05XiinlXTbc
   2kOI3reJzEBOX1NAAirxc2j7VJDROFwNlOQLlGzgfWQniXXQjh2aMyKYx
   dCpKIEDAcLEwLQYIcLlwYtHZeml7a882xpXGBqat+Jt67zO2VWUGqhrlx
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="179985783"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2022 01:06:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 12 Sep 2022 01:06:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 12 Sep 2022 01:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzwAdjspPw1S/DmKJVswX4O6L7R4QoHw0/WsACRxr7rftyv5Ll2bsdZ26vFIoS09Y4hAY5VlXzo0IXFU8kOSSPToIO3ac/QD4n8JW1j3NwHro1PT4efZgwyE0tYTM9LHJfM3GNBzAqofJAQGkF6aU5ZR8RRazWrT2xdxfHPEgoiNMhNrMgaiukjXEDr46mUKNLJTWakfRqQqVHXm+T7bllqivKrLXZZbzRosh9rjZzNH884DfdPbnSFWwA7hdOHyfdjoGQ9ZEGLYYAWVCbPazKpj5CIvtlwXBhlJDtRKGocdTYkkrTm7dehGe9hiaoFu0kswhQL5kTEVL3JSXmbuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIstPrAUkE8iAFPtm+LsWP/af9oWUp3m/GKfxBzBAwc=;
 b=lPdcSg169RfzQP02Wqqq3bWTB1XNTPQVE0rpohwRVZUqYYjdwxDX1/KT4AqZR6dJuJdxsm6GQAQyF7QUAFcPGvi0DtIsPZkA4bfFr2vochXP4jt3IGEaz60q7tlDdPTi7LCYSFglSmprFTf93CwygtzA07Ae+n5JzIJBy93m477PBxEWOnFsy+uNqABjZ4kB4y+VSKLXOFIaYa/egd+qVlGQywqMQl2JgZXkX3SGtRvguLuwulRUZYhWySzKwEER3Rpq71Gcqjl6nfzYYWw+OFhXddFTI4BsAg/SUi8FGu6RDKR276jstlOskLna7OvLKG6JoR6RFySOGAiV5t+3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIstPrAUkE8iAFPtm+LsWP/af9oWUp3m/GKfxBzBAwc=;
 b=te4Rjm2w2ckQ0gceVVB6FceI4FGOohk0iHvm/YTnXE5e/9Rb/weNNWu8ri/pWPgl0wdohyymeLFAeKbI9A7UsuJPXyuUpZpyadFhvYskRZLnlQ2WqJjnytVIGTClhcyKbZP1gYfs5N5qz7XTEXULfby7MreYhIrWoM42xTfMQBk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA1PR11MB6919.namprd11.prod.outlook.com (2603:10b6:806:2bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 08:06:21 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5612.022; Mon, 12 Sep
 2022 08:06:20 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 12/13] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Topic: [PATCH v2 12/13] tty: serial: atmel: Make the driver aware of
 the existence of GCLK
Thread-Index: AQHYxn6KZaLerZulKUOw6RtadR8rpQ==
Date:   Mon, 12 Sep 2022 08:06:20 +0000
Message-ID: <4b669bd6-e7bc-8cd9-ad60-03a31c7e8b1a@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-13-sergiu.moga@microchip.com>
In-Reply-To: <20220906135511.144725-13-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA1PR11MB6919:EE_
x-ms-office365-filtering-correlation-id: 8d632d29-5fc2-4c58-6b6e-08da9495ad7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrjDCiiEtXkHiyZ8zqpmrPD33yOULVvolST2xrX35+nO0OQ7j0oyc9UQ3s9muQ+BAe6SuymfUY52xYhYrZ86AT7BQ9NLJSYEodWwkQcXpJ81MjhtiEcjl9f9eXqEfAZVb0JuAiUNy6mA8khMlV75Dig+kwZebCmRI1VaI5rJgEXtinvXqBuwlv4+v3Cv4J5iWR8FiWjAaT7L5DFn0F9mvTcEqMhwP8hJinvxafoUP77AAGC9oxfVPeDfIW1tEKkaigIXR6JDCWdxZlxOd/dRPb5CgGX6vBWIANmg7vkK+eTX9RVfg5NeEgp3aTsDz6G+Y6AskjfjxeNEJJKOl3fbEjHYK5H9stOTE5APP3wOS9fApZ0pJu+BAJj9tiKFY/ihzGGlc3SWknoUQrCzzQ5goBVlyYRNhz7N3gG+NXQcxcj73bOyitazsWXdOPcfeiHhx0/4qwi8tilfPzL5quglCVCrkdNagoIPOQr2YD+/zw3tsfYQSvhQkTcHHmkI5jRa8PG6QZfsyB0/C2VslkoYYcsmYrIF330lGbHOwTexgcdSzM+f/HWRoublorW4KkT6UAo8ydrq2ta2Wm7/+sRmjoemN7UtgBs/xShkuAGkTXxmpFgJwWck4edbNUwmZuKT1Q/j++dBfCpiRng2ljyOzUmQzEmduxBeVEPeVvZ+Sc/BU9lNq+AuO2nBohLywkA75lwFgl02OCfKTgawsZfHz/JL+/1UVb0ItWoYWMhqeVpwACH1nAqXUAxlVHJuk5D+GkL8dSX7DBTDz0ddSK3jK3lub5FTa3zdlWmwAf1KbaknB8AFAAgSk+kDvHef1m8HJAY7MkhvpGlmLV40dUwtYaWFMQqqvlJrkDGb5YSUQuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(39860400002)(376002)(396003)(2616005)(186003)(26005)(83380400001)(53546011)(31686004)(6512007)(31696002)(86362001)(6506007)(41300700001)(478600001)(71200400001)(6486002)(91956017)(66446008)(36756003)(316002)(2906002)(54906003)(110136005)(66476007)(66556008)(8936002)(7416002)(8676002)(4326008)(6636002)(66946007)(122000001)(38100700002)(64756008)(5660300002)(76116006)(921005)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hwMmhjM0Vya2VsSnNxMFpvTG5JNjhNYUhVdElxandSY3QxWmI5QTBRb2hy?=
 =?utf-8?B?dG9UZDI0RFpNUjl1ZzllZXg3c2RCU1J2QkF6dEc0c3BwSGRFWThrOTIwSkg4?=
 =?utf-8?B?WUNuUmhnaXk4azUySkQ0MW4wMFljckRURDY2WmFPbDQ3SkNuaGVDODY4ZWhY?=
 =?utf-8?B?UkFFWHh2TjdyTlA5elAyTjh5MTJmc2pBSFErTFNBRTF4OU5ya1I2Z25HQW5x?=
 =?utf-8?B?RTRIOXdiak9MQWVTK1pxaC9iZjN6ZCs5a1RMMDVWd0RRUnFjOXNMd0JSc2FL?=
 =?utf-8?B?NTZPTHk1NVNPQ1A2Q0ppcmt5U1JxM0tiQzY2Ky9NUE1GYTg2dmNWVFlUb3hG?=
 =?utf-8?B?ek40ZEx6bW9VS2JZT2t1S1lMSUIzNmV4VmxGSGJhVXRSTUsvdnpsOFlwY0o0?=
 =?utf-8?B?Z0ppeHdDNHNRd1ljeGRZaytWMkNRZkZzdmVhRmtXS0lPWUV4OGwwdXRqTmNr?=
 =?utf-8?B?ZnFUSTBucHhSOWpaazRpZVp2WkZsSk1uU1JZSEh1NkpCL2VqZTlobDcwVlpW?=
 =?utf-8?B?WlZLSDludXA5cC9mMVV0MUR4UnBPdnFNUSs0K1hRekhGOWIvbTlHSm9YNlZ6?=
 =?utf-8?B?UkNUYmhFUExNbTdxYXdLVDdma2o0UTEvVDUxOEI2U2VZKys1TVR5ZDdkejg1?=
 =?utf-8?B?cHBPNlA4cnFqdTM0dGZjTStYbHFEU2VJM0tST1Qzc1JXbGlwcytSUWhjb3RV?=
 =?utf-8?B?ZHBRa09qSkRGWnE5aDJQM0RsQ2ZqQkl0Wldvc1U3TWZzcU1rQ1d3NDdqM3Jw?=
 =?utf-8?B?Z0NrSUZsaUFaeTNmaEpsZVFxblYrdGd1UElMZWpoV2xpblNMV0NGSEFZUkhT?=
 =?utf-8?B?NHFDemZhUG5uL1hTcmlhUmVVSUlua0V5cEUwQzJoQnNUMG51NlRkbmZSdkpX?=
 =?utf-8?B?K3ZrUUNDTWhWRlpGdEd0VFpnR1ZUNmx3OVdBSFZJYmErRE82bGszWVhBTHhW?=
 =?utf-8?B?eFJrSWNmS1F2K3B4QXp6V3c2eVE4Mys5WWMxQTVVYkE2V1BIbWhxZEROSzc2?=
 =?utf-8?B?WmszUkw5bHFVVHJ0V1lkcHdNMXdZUVRCRnQ3M21GSUNNUk5yMzZkUVpsZVdO?=
 =?utf-8?B?a2pTOVZpZzhBL0dkQmtlbDU3TmR2dm9hN1JEMkZhRzJmK2RLcjFFbmljVERm?=
 =?utf-8?B?bmFGcDRZZ1ljNk5MZzl6SGUrcGVBTFh0OWQra29SZHBFZzh1M1I4Y0cyY2Mr?=
 =?utf-8?B?N2VWUGdyVGFKOVBYTlJ3WWdLUjBDMUdWM3RRK0tHQW4vZlN3MWJML0wweVE1?=
 =?utf-8?B?VlJJYmo3UzhQWG9Od1pHdGFsWmh2OUQwa0M5T1RwaithS2NhcysxNzJEZFZy?=
 =?utf-8?B?K0oycC9wUklHUjlUL0JJcHZOV3dDd0dtYkhmTk5hZEtSS0d1UGZKN04rY2hG?=
 =?utf-8?B?bDMxa3RSNWJtbEt4aXpjNy8xUFBvaVpHL1V5aWtFLzdXV3lIa3NOQnkvaW8x?=
 =?utf-8?B?ditBdjVFejlLVEFFSjA4RzYrNm1kTi9TYXZEWk9GTXJPb1c0bmhFZWlHenV5?=
 =?utf-8?B?aVM2T25MdkRLMm9tcmNnMlVoL0Nld0RWRVdhazNrTXN3RTc1Z0p2akVNVXdr?=
 =?utf-8?B?V1FDdHF5YWpBUmliWXFaQnlTaXVIVVJjQnk0bEh1cmFYK1lWU1dUMmNTMVVy?=
 =?utf-8?B?UEhHNWl6SnNiNVVsVm5kWnFib21YY0lya3F6RUJ3c1UraWlnTENOaG5TOU40?=
 =?utf-8?B?dm5xdG9BWlZJa00zYmlnN1NZYnpQU2lLUTlqbDFtNkdNMm5QZUpvTEVuSnVq?=
 =?utf-8?B?bnB6SHFUV0FtaHRuZHRyeEUwVVNXbFN4RE5mZ1RKZDhiODNXNmQ0YitGZkpS?=
 =?utf-8?B?NjRHcDRseDE5Y3dEWUZJdE1lL2VvSUw3T1BpM3lERTF5S1dpVlljSGwrSUJq?=
 =?utf-8?B?SWpCNjFzOEJFb2dHTElTS1Z0dHBDRTdHRjR1YnBDVnZ3UktLT3Rud2x4emFr?=
 =?utf-8?B?YmZMaHZIRTdKMDU1S2daQTQ5WEJVTFF1ZnRLem9JUFVlRkUzTzVMOVRhWUhk?=
 =?utf-8?B?c3Q1MElVSHc1NUd3UGwwZ21UbWZTRWFqZlhvNHJ5MHNSUEZCcnl2N2s5bnMw?=
 =?utf-8?B?QXJXdm5vMSs0Q2g1VUpkdCtmak1wVndybGNHcGxobzdPMWNlcEhCOWc5S05Q?=
 =?utf-8?B?UUYxcWhpNHhYMGNRNkpsalI2RzYzYmRpWE5MRVdhQjdMZURFZEtYZzZpc0lC?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3C5B12F77AB164C8DD1BD7F6E1D8C7C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d632d29-5fc2-4c58-6b6e-08da9495ad7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 08:06:20.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4etZ6FTRyYynD66cNar/BCnL+uKVFGTQ0oKx7F5TBhGUm1eaLvlagoRT18hUaKbu+P7QwcNheDb4ZIR/5z9H3aqAMyceCwaowoQyKQTEJds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6919
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYuMDkuMjAyMiAxNjo1NSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IFByZXZpb3VzbHksIHRo
ZSBhdG1lbCBzZXJpYWwgZHJpdmVyIGRpZCBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhlDQo+IHBv
c3NpYmlsaXR5IG9mIHVzaW5nIHRoZSBtb3JlIGN1c3RvbWl6YWJsZSBnZW5lcmljIGNsb2NrIGFz
IGl0cw0KPiBiYXVkcmF0ZSBnZW5lcmF0b3IuIFVubGVzcyB0aGVyZSBpcyBhIEZyYWN0aW9uYWwg
UGFydCBhdmFpbGFibGUgdG8NCj4gaW5jcmVhc2UgYWNjdXJhY3ksIHRoZXJlIGlzIGEgaGlnaCBj
aGFuY2UgdGhhdCB3ZSBtYXkgYmUgYWJsZSB0bw0KPiBnZW5lcmF0ZSBhIGJhdWRyYXRlIGNsb3Nl
ciB0byB0aGUgZGVzaXJlZCBvbmUgYnkgdXNpbmcgdGhlIEdDTEsgYXMgdGhlDQo+IGNsb2NrIHNv
dXJjZS4gTm93LCBkZXBlbmRpbmcgb24gdGhlIGVycm9yIHJhdGUgYmV0d2Vlbg0KPiB0aGUgZGVz
aXJlZCBiYXVkcmF0ZSBhbmQgdGhlIGFjdHVhbCBiYXVkcmF0ZSwgdGhlIHNlcmlhbCBkcml2ZXIg
d2lsbA0KPiBmYWxsYmFjayBvbiB0aGUgZ2VuZXJpYyBjbG9jay4gVGhlIGdlbmVyaWMgY2xvY2sg
bXVzdCBiZSBwcm92aWRlZA0KPiBpbiB0aGUgRFQgbm9kZSBvZiB0aGUgc2VyaWFsIHRoYXQgbWF5
IG5lZWQgYSBtb3JlIGZsZXhpYmxlIGNsb2NrIHNvdXJjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gDQo+IA0K
PiANCj4gdjEgLT4gdjI6DQo+IC0gdGFrZSBpbnRvIGFjY291bnQgdGhlIGRpZmZlcmVudCBwbGFj
ZW1lbnQgb2YgdGhlIGJhdWRyYXRlIGNsb2NrIHNvdXJjZQ0KPiBpbnRvIHRoZSBJUCdzIE1vZGUg
UmVnaXN0ZXIgKFVTQVJUIHZzIFVBUlQpDQo+IC0gZG9uJ3QgY2hlY2sgZm9yIGF0bWVsX3BvcnQt
PmdjbGsgIT0gTlVMTA0KPiAtIHVzZSBjbGtfcm91bmRfcmF0ZSBpbnN0ZWFkIG9mIGNsa19zZXRf
cmF0ZSArIGNsa19nZXRfcmF0ZQ0KPiAtIHJlbW92ZSBjbGtfZGlzYWJsZV91bnByZXBhcmUgZnJv
bSB0aGUgZW5kIG9mIHRoZSBwcm9iZSBtZXRob2QNCj4gDQo+IA0KPiANCj4gIGRyaXZlcnMvdHR5
L3NlcmlhbC9hdG1lbF9zZXJpYWwuYyB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJp
dmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+IGluZGV4IDZhYTAxY2E1NDg5Yy4uYjJi
NmZkNmVhMmE1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFs
LmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+IEBAIC0xNSw2
ICsxNSw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3NlcmlhbC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L2Nsay1wcm92aWRlci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9zeXNycS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3R0eV9mbGlwLmg+DQo+IEBA
IC03Nyw2ICs3OCw4IEBAIHN0YXRpYyB2b2lkIGF0bWVsX3N0b3Bfcngoc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCk7DQo+ICAjZW5kaWYNCj4gIA0KPiAgI2RlZmluZSBBVE1FTF9JU1JfUEFTU19MSU1J
VAkyNTYNCj4gKyNkZWZpbmUgRVJST1JfUkFURShkZXNpcmVkX3ZhbHVlLCBhY3R1YWxfdmFsdWUp
IFwNCj4gKwkoKGludCkoMTAwIC0gKChkZXNpcmVkX3ZhbHVlKSAqIDEwMCkgLyAoYWN0dWFsX3Zh
bHVlKSkpDQo+ICANCj4gIHN0cnVjdCBhdG1lbF9kbWFfYnVmZmVyIHsNCj4gIAl1bnNpZ25lZCBj
aGFyCSpidWY7DQo+IEBAIC0xMTAsNiArMTEzLDcgQEAgc3RydWN0IGF0bWVsX3VhcnRfY2hhciB7
DQo+ICBzdHJ1Y3QgYXRtZWxfdWFydF9wb3J0IHsNCj4gIAlzdHJ1Y3QgdWFydF9wb3J0CXVhcnQ7
CQkvKiB1YXJ0ICovDQo+ICAJc3RydWN0IGNsawkJKmNsazsJCS8qIHVhcnQgY2xvY2sgKi8NCj4g
KwlzdHJ1Y3QgY2xrCQkqZ2NsazsJCS8qIHVhcnQgZ2VuZXJpYyBjbG9jayAqLw0KPiAgCWludAkJ
CW1heV93YWtldXA7CS8qIGNhY2hlZCB2YWx1ZSBvZiBkZXZpY2VfbWF5X3dha2V1cCBmb3IgdGlt
ZXMgd2UgbmVlZCB0byBkaXNhYmxlIGl0ICovDQo+ICAJdTMyCQkJYmFja3VwX2ltcjsJLyogSU1S
IHNhdmVkIGR1cmluZyBzdXNwZW5kICovDQo+ICAJaW50CQkJYnJlYWtfYWN0aXZlOwkvKiBicmVh
ayBiZWluZyByZWNlaXZlZCAqLw0KPiBAQCAtMjExNyw2ICsyMTIxLDggQEAgc3RhdGljIHZvaWQg
YXRtZWxfc2VyaWFsX3BtKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHVuc2lnbmVkIGludCBzdGF0
ZSwNCj4gIAkJICogVGhpcyBpcyBjYWxsZWQgb24gdWFydF9jbG9zZSgpIG9yIGEgc3VzcGVuZCBl
dmVudC4NCj4gIAkJICovDQo+ICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5j
bGspOw0KPiArCQlpZiAoX19jbGtfaXNfZW5hYmxlZChhdG1lbF9wb3J0LT5nY2xrKSkNCj4gKwkJ
CWNsa19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4gIAkJYnJlYWs7DQo+
ICAJZGVmYXVsdDoNCj4gIAkJZGV2X2Vycihwb3J0LT5kZXYsICJhdG1lbF9zZXJpYWw6IHVua25v
d24gcG0gJWRcbiIsIHN0YXRlKTsNCj4gQEAgLTIxMzEsNyArMjEzNyw4IEBAIHN0YXRpYyB2b2lk
IGF0bWVsX3NldF90ZXJtaW9zKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlv
cyAqdGVybWlvcywNCj4gIHsNCj4gIAlzdHJ1Y3QgYXRtZWxfdWFydF9wb3J0ICphdG1lbF9wb3J0
ID0gdG9fYXRtZWxfdWFydF9wb3J0KHBvcnQpOw0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
IC0JdW5zaWduZWQgaW50IG9sZF9tb2RlLCBtb2RlLCBpbXIsIHF1b3QsIGJhdWQsIGRpdiwgY2Qs
IGZwID0gMDsNCj4gKwl1bnNpZ25lZCBpbnQgb2xkX21vZGUsIG1vZGUsIGltciwgcXVvdCwgZGl2
LCBjZCwgZnAgPSAwOw0KPiArCXVuc2lnbmVkIGludCBiYXVkLCBhY3R1YWxfYmF1ZCwgZ2Nsa19y
YXRlOw0KPiAgDQo+ICAJLyogc2F2ZSB0aGUgY3VycmVudCBtb2RlIHJlZ2lzdGVyICovDQo+ICAJ
bW9kZSA9IG9sZF9tb2RlID0gYXRtZWxfdWFydF9yZWFkbChwb3J0LCBBVE1FTF9VU19NUik7DQo+
IEBAIC0yMjk3LDYgKzIzMDQsNDMgQEAgc3RhdGljIHZvaWQgYXRtZWxfc2V0X3Rlcm1pb3Moc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zLA0KPiAgCQljZCAm
PSA2NTUzNTsNCj4gIAl9DQo+ICANCj4gKwkvKg0KPiArCSAqIElmIHRoZXJlIGlzIG5vIEZyYWN0
aW9uYWwgUGFydCwgdGhlcmUgaXMgYSBoaWdoIGNoYW5jZSB0aGF0DQo+ICsJICogd2UgbWF5IGJl
IGFibGUgdG8gZ2VuZXJhdGUgYSBiYXVkcmF0ZSBjbG9zZXIgdG8gdGhlIGRlc2lyZWQgb25lDQo+
ICsJICogaWYgd2UgdXNlIHRoZSBHQ0xLIGFzIHRoZSBjbG9jayBzb3VyY2UgZHJpdmluZyB0aGUg
YmF1ZHJhdGUNCj4gKwkgKiBnZW5lcmF0b3IuDQo+ICsJICovDQo+ICsJaWYgKCFhdG1lbF9wb3J0
LT5oYXNfZnJhY19iYXVkcmF0ZSkgew0KPiArCQlpZiAoX19jbGtfaXNfZW5hYmxlZChhdG1lbF9w
b3J0LT5nY2xrKSkNCj4gKwkJCWNsa19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5nY2xr
KTsNCj4gKwkJZ2Nsa19yYXRlID0gY2xrX3JvdW5kX3JhdGUoYXRtZWxfcG9ydC0+Z2NsaywgMTYg
KiBiYXVkKTsNCj4gKwkJYWN0dWFsX2JhdWQgPSBjbGtfZ2V0X3JhdGUoYXRtZWxfcG9ydC0+Y2xr
KSAvICgxNiAqIGNkKTsNCj4gKwkJaWYgKGdjbGtfcmF0ZSAmJiBhYnMoRVJST1JfUkFURShiYXVk
LCBhY3R1YWxfYmF1ZCkpID4NCj4gKwkJICAgIGFicyhFUlJPUl9SQVRFKGJhdWQsIGdjbGtfcmF0
ZSAvIDE2KSkpIHsNCj4gKwkJCWNsa19zZXRfcmF0ZShhdG1lbF9wb3J0LT5nY2xrLCAxNiAqIGJh
dWQpOw0KDQpUaGlzIGlzIGEgcGVyc29uYWwgdGFzdGU6IEkgd291bGQgZG8gbGlrZSB0aGlzOg0K
CQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKCk7DQoJCQlpZiAocmV0KQ0KCQkJCWdvdG8gY2xr
X3ByZXBhcmVfZmFpbHVyZTsNCg0KCQkJLy8gYW5kIGhlcmUgdGhlIHJlc3Qgb2YgdGhlIGNvZGUu
Li4NCg0KPiArCQkJaWYgKCFjbGtfcHJlcGFyZV9lbmFibGUoYXRtZWxfcG9ydC0+Z2NsaykpIHsN
Cj4gKwkJCQlpZiAoYXRtZWxfcG9ydC0+aXNfdXNhcnQpIHsNCj4gKwkJCQkJbW9kZSAmPSB+QVRN
RUxfVVNfVVNDTEtTOw0KPiArCQkJCQltb2RlIHw9IEFUTUVMX1VTX1VTQ0xLU19HQ0xLOw0KPiAr
CQkJCX0gZWxzZSB7DQo+ICsJCQkJCW1vZGUgJj0gfkFUTUVMX1VBX0JSU1JDQ0s7DQo+ICsJCQkJ
CW1vZGUgfD0gQVRNRUxfVUFfQlJTUkNDS19HQ0xLOw0KPiArCQkJCX0NCj4gKw0KPiArCQkJCS8q
DQo+ICsJCQkJICogU2V0IHRoZSBDbG9jayBEaXZpc29yIGZvciBHQ0xLIHRvIDEuDQo+ICsJCQkJ
ICogU2luY2Ugd2Ugd2VyZSBhYmxlIHRvIGdlbmVyYXRlIHRoZSBzbWFsbGVzdA0KPiArCQkJCSAq
IG11bHRpcGxlIG9mIHRoZSBkZXNpcmVkIGJhdWRyYXRlIHRpbWVzIDE2LA0KPiArCQkJCSAqIHRo
ZW4gd2Ugc3VyZWx5IGNhbiBnZW5lcmF0ZSBhIGJpZ2dlciBtdWx0aXBsZQ0KPiArCQkJCSAqIHdp
dGggdGhlIGV4YWN0IGVycm9yIHJhdGUgZm9yIGFuIGVxdWFsbHkgaW5jcmVhc2VkDQo+ICsJCQkJ
ICogQ0QuIFRodXMgbm8gbmVlZCB0byB0YWtlIGludG8gYWNjb3VudA0KPiArCQkJCSAqIGEgaGln
aGVyIHZhbHVlIGZvciBDRC4NCj4gKwkJCQkgKi8NCj4gKwkJCQljZCA9IDE7DQo+ICsJCQl9DQo+
ICsJCX0NCj4gKwl9DQo+ICsNCg0KY2xrX3ByZXBhcmVfZmFpbHVyZTogLy8gb3Igb3RoZXIgbGFi
ZWwgbmFtZQ0KDQo+ICAJcXVvdCA9IGNkIHwgZnAgPDwgQVRNRUxfVVNfRlBfT0ZGU0VUOw0KPiAg
DQo+ICAJaWYgKCEocG9ydC0+aXNvNzgxNi5mbGFncyAmIFNFUl9JU083ODE2X0VOQUJMRUQpKQ0K
PiBAQCAtMjg5Miw2ICsyOTM2LDEyIEBAIHN0YXRpYyBpbnQgYXRtZWxfc2VyaWFsX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBlcnI7
DQo+ICANCj4gKwlhdG1lbF9wb3J0LT5nY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2
LT5kZXYsICJnY2xrIik7DQo+ICsJaWYgKElTX0VSUihhdG1lbF9wb3J0LT5nY2xrKSkgew0KPiAr
CQlyZXQgPSBQVFJfRVJSKGF0bWVsX3BvcnQtPmdjbGspOw0KPiArCQlnb3RvIGVycjsNCg0KVGhp
cyBzaG91bGQgYmU6DQoJCWdvdG8gZXJyX2Nsa19kaXNhYmxlX3VucHJlcGFyZTsNCg0KdG8gZGlz
YWJsZSB0aGUgcGVyaXBoZXJhbCBjbG9jayBwcmV2aW91c2x5IGVuYWJsZWQuDQoNCj4gKwl9DQo+
ICsNCj4gIAlyZXQgPSBhdG1lbF9pbml0X3BvcnQoYXRtZWxfcG9ydCwgcGRldik7DQo+ICAJaWYg
KHJldCkNCj4gIAkJZ290byBlcnJfY2xrX2Rpc2FibGVfdW5wcmVwYXJlOw0KDQo=
