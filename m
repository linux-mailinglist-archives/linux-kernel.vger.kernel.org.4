Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7279A6FD7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjEJHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbjEJHBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:01:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA41BE1;
        Wed, 10 May 2023 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683702051; x=1715238051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/USNHQ1/6wMWfvmNGfCNyCdOHub9WPsq8W2h/Yg4PHY=;
  b=z3xpZYE5x0yfYfmXTcOapvasn5dyiLP3vjJmqneU3X5ClnIVVmiqaJNj
   YmaifW2nQkWWXwzr94jitS51l1AAHxPq/AnP0/oDxkPVWOeM07AeN9okI
   47W3QeYrJzYUnejib1B9aZKGoDzL5k4K5b8rR6eqE5qH0uDBesxA0vzuj
   e2OQr40gdzkQMvwNvBT3WasCRplcuJHRaWsvrYj5koYEkgIQ4PH4/qKkb
   vJ5YK9YhVG1W+1db63u0uiCNnU4e+IegRxr70duCWAKwgnxbdJzWKuJLq
   FEoMplfW4m3VOyI63VfADG7T0dMOm1eaNYhSoaDvwtjj/TyhHRblG0B8c
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="scan'208";a="151270505"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 00:00:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 00:00:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 00:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tae1ciTItIj9nUBonFaftXRdDv8zvHuut94e14ASSktq9q38V1CVzF5vVghNt9X3JKTIg7Qenx0v+N+SKrcIqkx+0SAhPq81nROAqL2Sfzb7eBIjU0SjtT5qFm4NTEXYAmrrb6pHVXgFZUfBm2ZzjFgw6UuHrnP34HwcnrwhVjkZQmsgiA3X/sdotrYSQF4mCHFf3/StGheCtyG58/ytAfOgIZvJaztsDvjbrL6bpAKmGvBRSbxrmQWhnTGsqnokz8Tnd3R/JECy69WiSZePPA1Xz/UTC/XNVfJ0I7Vwb8kRuNkZ6AIp5ie4+Ur0390Y9k7idmoU/IcdYLSMnVCb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/USNHQ1/6wMWfvmNGfCNyCdOHub9WPsq8W2h/Yg4PHY=;
 b=dUBBcZfuur5iGKGg0DaBkB+yoTTmFSfwyUOyNiGsgrTx84Je9l0rVqeEBRDxKkpR7fluxrgzqcE8DmMmfYCBJLX+Cz6ZX3T6oD3xlDQGMm3KkH53Cs5BTkoToabGcgqVcJXaY8/0+IHKjMW0uE4IOvaBG3GmNavkZ8ndjztDx8j7LNpYY3gtXRfkCQn5kvYaf6uyIz0zSwEIAm5zzjATr1RQDwTITPixM9A3xhN8FZeoVPU+lTrZICtom184ysC7cL8uNbIIEJrtvsZwnLYmpmfRXO84kbqlHtCR3wzoJn0745tnHIE7S8dBiGIt0bX6yPxfUDbXgSWq/2oXSQveJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/USNHQ1/6wMWfvmNGfCNyCdOHub9WPsq8W2h/Yg4PHY=;
 b=HCtNURZIBbyfLjSkDTp6yy+4P3XMEIpDLuLIvYm0xVx0cagNN7k5mVxWA2jPjw/ezQ0kEEX/TuJg09cphx0i7cibCUMnYkb/sEuLbVKa/77HF6+XGIVXXFOgzBEs3z02Me2xaBgjzSjP8md9zEdm5fPdxIRt47S8wq+lUjDXNYk=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SJ0PR11MB6669.namprd11.prod.outlook.com (2603:10b6:a03:449::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 07:00:43 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 07:00:36 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Thread-Topic: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Thread-Index: AQHZgw0ebP/LN/JuUUmRJdjB9Y+G/w==
Date:   Wed, 10 May 2023 07:00:36 +0000
Message-ID: <773d0d90-29c7-b1bd-bd16-898b435eafb6@microchip.com>
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
 <20230509052757.539274-3-claudiu.beznea@microchip.com>
 <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
In-Reply-To: <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SJ0PR11MB6669:EE_
x-ms-office365-filtering-correlation-id: e9f67039-8592-4949-cd97-08db5124419c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvXUxtZHCSgpzoZRcjMZh8WdiPFCC1pUtZSpcBVcA0WRFB2Twp4NM5LKYmICSunBssflykDivjW32CLbd89JpR3ibNiujZ/aGOQc16Fnb44EW9O126BAs8Oeo9E+BvD01W5ubAUt5XeOBlj8HrHWwrqu/ZPQrrhDAm5aixUNTHSZMd2OXbW5IrJczISFX15xwVe0O4L4ABmmc3OlOj7QbnT0oWfY9V4noSBqgsOvo/VjviusfwwugO/Re9s87ewZIihqr0eo0nq/YhCTyU2ocy1AJv+8eA9MtraDo9BPssmP+a1mpbai2cJK8bH8WPy1AZEz45VY2YvfxnrbGZKOFyEDrxnZE1Lh2BIOi7gdwOzzOaX95/We4+62YkeOxnQH6Rybpjg3vf/zVD6Or7YCb5ncM070FQs5X7NDWCL2LTrqGavMujNq2+zYXKZ4LD/Fj7ANw5HBrFq2m7VmwXEwJycwFf2DHfw+L3zvFeSVKay2UPD4nfyZfuNSkRVZj/rExJw9CYkrvF5VxbfPrJ+det9gp2tueS0aHMMiw39ltMw6b2jQ/TYJdxURb2we1DVBly1gvTUSrV2bQV6Z/3OzwkM6TQ465LxE5RScim3z14jtQRYrtSaw55KYeVqRa5nBS1w2ggXr4MOCEHSaZb/NTDJhuxrYq+bblZ08lbfH0akxOI1H53a+Y0YMtwC3efms
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(26005)(6506007)(6512007)(53546011)(6486002)(36756003)(2616005)(86362001)(31696002)(122000001)(83380400001)(38070700005)(186003)(38100700002)(71200400001)(110136005)(54906003)(8676002)(8936002)(316002)(41300700001)(478600001)(76116006)(91956017)(7416002)(66476007)(66446008)(5660300002)(4326008)(66556008)(66946007)(64756008)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDFLQTVqbjRyK29iOWkrOGp6cStTV3RPQVdyK3JkM0tRTWZZUHBLVHF2ZnR4?=
 =?utf-8?B?Q3ZiZTlKYlFEbHRXSi9TQWVOUG1Pd2FnSExmV2h0amx2V0NIOTZZN3hxb0pv?=
 =?utf-8?B?Nzh6NWhJSVpPdzE3UjRJSDluT05zZDlnKzU1dUJMb1l6Ym1jSlVwcHFiT1pw?=
 =?utf-8?B?TE9wODhCNm1CZnU2QkovSGhzR3AxQUFhSTkwMFE3bUE3Wk94MmZackkwOWpV?=
 =?utf-8?B?VlEyVy9kSlRUTmY0bG05eWtVWmpvWGhoOXd6NFFTY21TWXA1Yjg0OW1odkJL?=
 =?utf-8?B?aFc1S1NjdW05YlpuY2pHdUtRREs4MEF4dUpGRGhMbFJldVZJMW9VQll1RmF1?=
 =?utf-8?B?QjNzTlc3UUI1NmpIRWpRUjZVQjJwZk4wZlIycUJFNjRZblNMMjdpWmF3UHRj?=
 =?utf-8?B?RFI2eXdMdGNzdmFpTmdWZ0dJMEhUZU1TZll1V2VmaFhnNHBqQlQ4cHZJaHdo?=
 =?utf-8?B?UkNkS1pOdnFpeFZFd1E4RDUzbXJaSVppYjlwdzNyMGgwNzllbWhoNW5kTVI5?=
 =?utf-8?B?c2VpbXQ1MFc5a2FzcHp5SzlZd01qSjBMY1RIeWlMOXRrYnNLWm5yTXhyRWxX?=
 =?utf-8?B?NWhXTThUZUxhWUVhelIxdFI2Q1Q2N0l2K203aXFncXI0QlJ2Q3VhWThJNzRi?=
 =?utf-8?B?R1FYMnc5U2hEb013Z1FzUXNRR1JNL3UrWS9oVC92Mi9xbkJtdUdkTVFJakJS?=
 =?utf-8?B?cWNGY0piaStBNC9kUVhDTHBIT2hHMHZha01UQncyNlZPZTdWRUdURDdVMzJZ?=
 =?utf-8?B?M1hlejRkbDVDT0Yxcm1JRkxYZzdMekVLcmg1MFd2L1RtTnBGdXRPYTRyQllF?=
 =?utf-8?B?WkhaMGFvRitvREZjaVptY1NGYVNlRzk1am41d3VtN1R1a0c4eXRlQU5penk4?=
 =?utf-8?B?dDhqOTNSUU1QZlZGRXdjeVlzbzlQcDhxdVdKR0JiMnhNZmJGYkFmU0tNMmtZ?=
 =?utf-8?B?cWF5SDNsdDErWjMrYWc5dXBiNHExRDZpTTNqM0JUSnVkQVpveTNLYW85ZHcv?=
 =?utf-8?B?NTJSWU9KNFdjWGpzbFM2M1hueG1rTU1Wd1hMVzJqeHl4MHRueTdCWlNSc1pY?=
 =?utf-8?B?NUI2bk04QjBGb1pzbVpKYmlOUng2QmZpaUE2bzE2SzRuaytGVnM2c1pPUWdS?=
 =?utf-8?B?MHZLYnRUWkZ0YWRUNVFjYjdLeXZGY3QwS2JGQmh6bHBkNWRmYWJhUWl2azBW?=
 =?utf-8?B?MFhIR1FiNCsvU2V1b1BiZm5wTVgyWHlLN1NjamhCamhxWTdlOVR1TjF1QVhq?=
 =?utf-8?B?bHJhb3p3OUlzWFFpdEk2a212N1hFdXRQS2JRUXpDUVE3WmU1NGhrYUQ4d0No?=
 =?utf-8?B?eDFQWWFpRVEwL05PQStQTW55QS9hQm1qY2FjK2tPcVo5ZVlvdDBTSEdSczNV?=
 =?utf-8?B?a2FWVS9QSVU4U3F0dG5kYTY2Z21FZlovSUZFeW9aMXlIMzc0MXdObzA3SlI1?=
 =?utf-8?B?T0prV0I1QXJ3NVpQOWZhUVVlWlVZQjRTYVI5dnhPdFhGYmdjMVNOU0Vxdzc2?=
 =?utf-8?B?bVZTTFlhbGVhTnhVYzV1S2hlUGMvTlo1WlBManNGdEo4SWtPckdKNnMwSlVY?=
 =?utf-8?B?ak82NExEZG1iWjdoRFcyaDd3UjZGcGU2bFEwMzBuVSsyZkkxNDVLQ0Y5Umc5?=
 =?utf-8?B?d1c5cUQyTTlvdVd3eTVraXVJdmdOcXM4a25scFBLTm9OWlMvd1BORUhocWZx?=
 =?utf-8?B?K3VuaU5YMHM4WDYzRXpaZGRMMDhwaTJ5VXpBWjN1aERXK2lDWnMxODJqUm5t?=
 =?utf-8?B?SnRHOVBsYmRheFladzZWZi9rckNFZnB2K052K3ZFU2Rld3ZBc3VCdXUxdkFs?=
 =?utf-8?B?VDYyR0xvVWhHMlpSWk5GdFBMWnkvU3VCbFJoek1HYVhnZkxCU3I4cEw3MTJD?=
 =?utf-8?B?MktKdmR2NUNZUmZKdnZCY2U3VEdzcjdIeWJ5bkxtMmtHT2h3RXpabVd4SEc4?=
 =?utf-8?B?R2FHSUhCaHljcUhSTVpOOEgvY2Jrbk1FaTRSVHNEeEIyc3RqcUxPMGZxK2ZV?=
 =?utf-8?B?OFhWTm9rSXorbzZ3blp3WUVjSWdZOS9zNXVLNlJNSklkMkRLQlZudGpjMHRE?=
 =?utf-8?B?TkdxeW5rTGlVUU9BZmJtNE5oOWN2Vy95YkcrMFlMSkNEb29EbnNLdVZLNG8z?=
 =?utf-8?B?cWRvaGI3aGxtdElHZGI3ai9JQ0liWWJzTWFoY3cxcjRBL0R5VjN0MWNnNkRm?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CC56B2F3B7AC546A9C33C2B309E7E04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f67039-8592-4949-cd97-08db5124419c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 07:00:36.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lDveT9DOX/ll/kywBKbM5wC30qsG6SEMYkPkro707c4cf7TB9pk/MoaR8Uce2mxlogg8WZCQPKX+/eM+5U+y9T4qAqIdbjUumRcJb39uJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6669
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDUuMjAyMyAwOToyNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwOS8wNS8yMDIzIDA3OjI3LCBD
bGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IENvbnZlcnQgQXRtZWwgUE1DIGRvY3VtZW50YXRpb24g
dG8geWFtbC4gQWxvbmcgd2l0aCBpdCBjbG9jayBuYW1lcw0KPj4gd2VyZSBhZGFwdGVkIGFjY29y
ZGluZyB0byB0aGUgY3VycmVudCBhdmFpbGFibGUgZGV2aWNlIHRyZWVzIGFzDQo+PiBkaWZmZXJl
bnQgY29udHJvbGxlciB2ZXJzaW9ucyBhY2NlcHQgZGlmZmVyZW50IGNsb2NrcyAoc29tZSBvZiB0
aGVtDQo+PiBoYXZlIDMgY2xvY2tzIGFzIGlucHV0LCBzb21lIGhhcyAyIGNsb2NrcyBhcyBpbnB1
dHMgYW5kIHNvbWUgd2l0aCAyDQo+PiBpbnB1dCBjbG9ja3MgdXNlcyBkaWZmZXJlbnQgY2xvY2sg
bmFtZXMpLg0KPj4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4gVGhlcmUgaXMgc29t
ZXRoaW5nIHRvIGRpc2N1c3MvaW1wcm92ZS4NCj4gDQo+PiArdGl0bGU6IEF0bWVsIFBvd2VyIE1h
bmFnZW1lbnQgQ29udHJvbGxlciAoUE1DKQ0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAg
LSBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+
ICtkZXNjcmlwdGlvbjoNCj4+ICsgIFRoZSBwb3dlciBtYW5hZ2VtZW50IGNvbnRyb2xsZXIgb3B0
aW1pemVzIHBvd2VyIGNvbnN1bXB0aW9uIGJ5IGNvbnRyb2xsaW5nIGFsbA0KPj4gKyAgc3lzdGVt
IGFuZCB1c2VyIHBlcmlwaGVyYWwgY2xvY2tzLiBUaGUgUE1DIGVuYWJsZXMvZGlzYWJsZXMgdGhl
IGNsb2NrIGlucHV0cw0KPj4gKyAgdG8gbWFueSBvZiB0aGUgcGVyaXBoZXJhbHMgYW5kIHRvIHRo
ZSBwcm9jZXNzb3IuDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+
PiArICAgIG9uZU9mOg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gZW51bToN
Cj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnMTUtcG1jDQo+PiArICAgICAgICAg
ICAgICAtIGF0bWVsLGF0OTFzYW05ZzIwLXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxh
dDkxc2FtOWcyNS1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnMzUtcG1j
DQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05eDI1LXBtYw0KPj4gKyAgICAgICAg
ICAgICAgLSBhdG1lbCxhdDkxc2FtOXgzNS1wbWMNCj4+ICsgICAgICAgICAgLSBlbnVtOg0KPj4g
KyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOTI2MC1wbWMNCj4+ICsgICAgICAgICAgICAg
IC0gYXRtZWwsYXQ5MXNhbTl4NS1wbWMNCj4gDQo+IEkgbWlzc2VkIGl0IGxhc3QgdGltZSAtIHdo
eSB5b3UgaGF2ZSB0d28gZW51bXM/IFdlIG5ldmVyIHRhbGtlZCBhYm91dA0KPiB0aGlzLiBJdCdz
IHVzdWFsbHkgd3JvbmcuLi4gYXJlIHlvdSBzdXJlIHRoaXMgaXMgcmVhbCBoYXJkd2FyZToNCj4g
YXRtZWwsYXQ5MXNhbTlnMjAtcG1jLCBhdG1lbCxhdDkxc2FtOTI2MC1wbWMNCj4gPw0KDQpJIGhh
dmUgMiBlbnVtcyBiZWNhdXNlIHRoZXJlIGFyZSBzb21lIGhhcmR3YXJlIGNvdmVyZWQgYnk6DQoi
dmVuZG9yLW5hbWUsaGFyZHdhcmUtdjEtcG1jIiwgInN5c2NvbiIgYW5kIHNvbWUgY292ZXJlZCBi
eToNCiJ2ZW5kb3ItbmFtZSxoYXJkd2FyZS12Mi1wbWMiLCAidmVuZG9yLW5hbWUsaGFyZHdhcmUt
djEtcG1jIiwgInN5c2NvbiIuDQoNCk1hbnkgQVQ5MSBkZXZpY2UgdHJlZXMgY29tcGF0aWJsZXMg
d2VyZSB3cml0dGVuIGluIHRoaXMgd2F5LiBUaHVzIHdoZW4gbmV3DQp2ZXJzaW9ucyBvZiB0aGUg
c2FtZSBJUCBoYXMgYmVlbiBpbnRyb2R1Y2VkIHRoZSBkcml2ZXJzIHdlcmUgbm90DQpuZWNlc3Nh
cmlseSB1cGRhdGVkIGJ1dCB0aGUgY29tcGF0aWJsZXMgaW4gZGV2aWNlIHRyZWVzIHdlcmUgdXBk
YXRlZCBlLmcuDQp3aXRoICJ2ZW5kb3ItbmFtZSxoYXJkd2FyZS12Mi1wbWMiICh0aGUgZnVsbCBj
b21wYXRpYmxlIGJlY29taW5nDQoidmVuZG9yLW5hbWUsaGFyZHdhcmUtdjItcG1jIiwgInZlbmRv
ci1uYW1lLGhhcmR3YXJlLXYxLXBtYyIsICJzeXNjb24iKSBhbmQNCmxldCB0aGUgZHJpdmVycyBm
YWxsIGJhY2sgdG8gYWxyZWFkeSBpbiBkcml2ZXIgc3VwcG9ydGVkIGNvbXBhdGlibGUNCiJ2ZW5k
b3ItbmFtZSxoYXJkd2FyZS12MS1wbWMiLCAic3lzY29uIi4gSW4gZ2VuZXJhbCB2MiBjb21lcyB3
aXRoIG5ldw0KZmVhdHVyZXMgaW4gYWRkaXRpb24gdG8gdjEuDQoNClRoYXQgd2F5IHRoZXkgQVQ5
MSBlbnN1cmVzIHRoZSBBQkkgcHJvcGVydGllcyBvZiBEVCBhbmQgdGh1cyB3aGVuIHRoZQ0KZHJp
dmVycyB3ZXJlIGZpbmFsbHkgdXBkYXRlZCB3aXRoIHRoZSBuZXcgZmVhdHVyZXMgb2YgdGhlDQoi
dmVuZG9yLW5hbWUsaGFyZHdhcmUtdjItcG1jIiBEVCByZW1haW5lZCBpbiBwbGFjZS4NCg0KUGxl
YXNlIGxldCBtZSBrbm93IGlmIHRoZXNlIGNvdWxkIGJlIGhhbmRsZWQgYmV0dGVyIGluIFlBTUwu
DQoNClRoYW5rIHlvdSwNCkNsYXVkaXUNCg0KPiANCj4gDQo+PiArICAgICAgICAgIC0gY29uc3Q6
IHN5c2Nvbg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gZW51bToNCj4+ICsg
ICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXJtOTIwMC1wbWMNCj4+ICsgICAgICAgICAgICAgIC0g
YXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05
ZzQ1LXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOW4xMi1wbWMNCj4+ICsg
ICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlybC1wbWMNCj4+ICsgICAgICAgICAgICAgIC0g
YXRtZWwsc2FtYTVkMi1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkMy1wbWMN
Cj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkNC1wbWMNCj4+ICsgICAgICAgICAgICAg
IC0gbWljcm9jaGlwLHNhbTl4NjAtcG1jDQo+PiArICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxz
YW1hN2c1LXBtYw0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBzeXNjb24NCj4+ICsNCj4gDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0K
