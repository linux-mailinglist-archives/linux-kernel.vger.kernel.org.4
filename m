Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA670F175
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbjEXIvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbjEXIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:51:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC4FC;
        Wed, 24 May 2023 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684918269; x=1716454269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OZNz0OrFGAK4XUWh033nwyOtzGDbwMxOmPcPTslnGhM=;
  b=WTmNLXetjs/b4l6JaSmTAdE6c8VrR2NbgfGUmcvCbEos9q8lCVwAn5lG
   /Jrjr1hkrVJ0ai26tTv+wBTTl0bUN5rVBnzLF/wV05FWh/hOPVJn/Vy5U
   hnCDXhwtaPQF80UUDfAWrLh61/py9f0ffAQW4tzxLXmy3u8X4lFvgPTft
   /kzIKFjEuaLEM56k4VTE1JoVHbD1dNc0dbSpoDr8XmqW0vme/lTJetdw/
   nzNSfTGDE0FkeZC25Kp8U7J+NCHqc7DYvQXIgqJHK4PxypewTcCT6/UvL
   6QZYGF1HKrbTLT809LdcimHFtVOdJ+DhnxCbb4TL/RSuluDFO8GtH4n4B
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="215244695"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 01:51:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 01:51:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 24 May 2023 01:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwDCxNByqXYgMJP39dWENcsWNPUw1ZG40QWFCBV78ArkPV/qko6hNZ7kVrsxGzt24Z93XAQbyopIH66x3UypgjHzOq8BYw8NX+x1Ge+/S5I5Ks9RHJU52mogDqpRn5pyVhP/bu+z0ULl+HYspf4i9evauc4VUn22lYSMJ7JP3xuVYfwdGfO01i5m8bR7DejT0d9HyyPXW+vKvsYgHc3GLFbVSK9NwsHLx/C02gEM4ngwI1d6CCUwNzUPZwP6tsgAoJN7o3v0vXExP64tBITfinPIY8k+IbYGSMISt9Cw/PdSmBqpUc+vIlFhRmWoUP189HhJO9XOuKQO/kawQfSxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZNz0OrFGAK4XUWh033nwyOtzGDbwMxOmPcPTslnGhM=;
 b=hzSfxH+ehhsV2GggzguZIe9sIpyGNvqU4xEGaWYaFFwib5JALgJ9Pc12J3UhByjnEgNBZbwBDwgx6hcFcV0IoARmurWN7HQjdjkCOWVRHdyuCE1Y4abFDif628aIRYWs8TahxW8b+19tX96E96ZseBuV6Ph2jCAIEzRXfAg6hLEwXKJR/W14G3OILaRXoISktZ1WltBNQG2eJbvFgT5uOuOGsImfzVwE2K/dTKfGFAW3TNepKc+AvyOVfJpzUy98H/HmODNOx17VPAH/ZwMKryHRSLIfkLclSHpEaSymmLS5ksAwdPq7og0UdpZtCGfV02uU6uXdlSIc+UI/pVVxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZNz0OrFGAK4XUWh033nwyOtzGDbwMxOmPcPTslnGhM=;
 b=eGLDWMqIYtM2OktD8AzCEQts10PEqmFxx+8QBOSX7hgoCrdqtnzjJMYxl9suaPhtwqmb2b9gbmlL10Fgqo2lQXhtT16PE+eN8dvT1UVG6D9EP6HeF3tp5zyR1xN2R/Rs+BioNNsgYmBWHggGsy/efQwfT2aQupcV0D1vNvzh5/I=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:51:03 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:51:03 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: fix debounce delay property
 for shdwc
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5ek: fix debounce delay property
 for shdwc
Thread-Index: AQHZjhze1D0zKebrWkiWk6zNdBE7Gg==
Date:   Wed, 24 May 2023 08:51:03 +0000
Message-ID: <0ba93a4e-c91e-af36-f2fd-3b35e9209600@microchip.com>
References: <20230523052750.184223-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230523052750.184223-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CH0PR11MB8214:EE_
x-ms-office365-filtering-correlation-id: f94061f5-5ea4-4b5d-b679-08db5c340151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8cmZydHXJDU5cocdCJqd05w2WdHl9MbdjJrcK53dcwg/tMqHYdQsAhC8j/UG5GdjA8hAMdG6vS0xKFWv+47Vcsz3SBEywYH2hH6Hyn8YYKjaDmF33GxEWzLV1s/3j9OGWeqs9VpjIT0y1V9+Ul+WufagKpVivruCsX8Sm+vLNMG2uU6Y/+uDj37NMdG+9OrEUXxAm8vdi57Cz3DdqzJtjnSuqnekKDWeyehkBl9BtSN7Io0l7S//huW8U2XbQPvzNNIVGhSNi1uNk3s+QvRCh7YdqBsPx9LbUfCjC54BWReI6T4jVnhJdwLkBFbprVhHGLGXK2aLwnTUXWijWt9zE/chROvyjWSNfLfuBhWjh/fPcKUNck7qnMdME6DrS8x6+wq0aqlGa7jJ6j9HjqVGrQV0YHmzpkbAUmy+7dW2ut8D80iQjOJ+IIw5iSem6gYs6X5snRHqLVUGQAAyJ0tvnQC6a3UUjtt0uoWSkht1uTxf1AqwwLjmoUTBUig4YhRSXhoUyhGKZMN45Oj4mskh3AoPGhHSRzY24eTMb29pJ7UT12PcV58UVB7muc320tat3YN0s0bjt4RQwsTstOrB9Ru3DZPVHm5lTrgL/sExTkPmnHGlGxVyvbfeItaz53kXhEaCXlzZPb7nehlPorCKb6lVbe1rDJv85IMguHaSAVFQ1MeUh9mFQTHXpEUVhamExuSCA5Cb/ua96ZV+UriUKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(6486002)(31686004)(186003)(478600001)(6512007)(6506007)(53546011)(54906003)(2616005)(26005)(71200400001)(122000001)(38100700002)(91956017)(76116006)(66446008)(64756008)(4326008)(83380400001)(66476007)(36756003)(66556008)(110136005)(86362001)(5660300002)(31696002)(8676002)(4744005)(316002)(2906002)(66946007)(41300700001)(8936002)(38070700005)(17423001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFlqV0hiUlNZdCtYNzh5Z2ZldjNZT1BUb25yRmJUZnhlMFREOUtiZ0hLeU9k?=
 =?utf-8?B?b2U2b0cxc1UycDFrODZYa2piV1hEOUVxZmR2SFV4YkhwcjVUNUMxRUZ3U3dv?=
 =?utf-8?B?a1pXZk9kUURta0ovSzFPYXIxRG9tbnFWMnhHUVhLOXAzeW9HcnRZbG1SdURN?=
 =?utf-8?B?UVdJMWZvQjZ3RWQ2TVNMb3NMMlJCS3N2QmM4SWJkbVZiOE5zZ09zeTZYWmNh?=
 =?utf-8?B?c0Q5QnFkWDMvVUo0Y29NNVBiWC9nblZLU3EvYnM5ZDlwczdKcGx3ck9WdWJD?=
 =?utf-8?B?S2NDc2ZKZlkrUGUvNU5JV2xndHN1Y2t0N1IyUHUxbE5IcVFwd1V3VFNJa2lL?=
 =?utf-8?B?bkVmV2dKOFJqNURwMWFJbEIzdmRIL2NVREhkQkIrT3c3bnl2NmZONCtIT2dk?=
 =?utf-8?B?UVBzOE5DdlF3dHdpT1FyTDdudzVKWE53NnY1R0sxZ2tqbjNyQzJEczVKYldz?=
 =?utf-8?B?QVJ0R1o3ZURtRFZjbUdYbWxOUzY3YVgwNkhtV09lSkduYXplMWFEdm1qYVRZ?=
 =?utf-8?B?UGlWUlN4eXdZK3d2NU1BcXVWcWh6Z2NDeUorSFFOUGFVeXBlSEYra3h4dHhD?=
 =?utf-8?B?T0U3VlZrMGhoK1FmbzBDZFFrSVdLc1JCQllmWkhQQnZNdk9RZ2k0d0F2ZmI0?=
 =?utf-8?B?WmwrNkF3UGJhVkRETHlWbVRtS1NJZ2RpUjYwQXBwSm1tZ040UHNrTGtmT3FD?=
 =?utf-8?B?aERsa21TSUZ6eTh6L1RrOW1VZXUybmd1Sks5WG5rOUVkaXdZRnArMTgvYS9V?=
 =?utf-8?B?anJQTk9hRVpCWVNlazk3S0JSbFpINlJZa2JzbTRtT21halhNbzBYZkxKT1dV?=
 =?utf-8?B?QU1WQ0l5UlhkMUZROGJRay9ZTU9QWW02MWNabG9vdXBNcDRtd1c0WVpLODQv?=
 =?utf-8?B?ck5TTHVYczB0SGdrZ1VvL29BWDd5emkyU20zNDR0M0w2M0h4aDZSWTJSR3cr?=
 =?utf-8?B?cWRpc1VRMGVaVU9uNTJjODdyNlhmRGNxNHBSVEM5SXlJVDdEM0QxV1orWDY2?=
 =?utf-8?B?NmdadFpXM1p3VDdJRHRMZG9vcGxiUDhnWHdWcE5sN08yMnVXZU1kQ1JpekJp?=
 =?utf-8?B?SGYwYi9oOVhuL05YNWxqRFpVOEZqQ3diMGRVRXBGQVN5U0lWZUpua2xoUllH?=
 =?utf-8?B?enNKNnNIMDlRcDE0cy9NcWxPNFFoR2NJU1h2cG5jU01mb3Q2UTNrWXlsbDl4?=
 =?utf-8?B?STl5cWlxSVpvVzMxTDlueDVIMUxWNytOaUk1OVlVTjNjazA5SG1VODhSNTFi?=
 =?utf-8?B?c1cxU2RzZThVdU1mMEVSRndvMmM4dC9mRFlnS0hWaWpmM0E2WFpDSktHMlFp?=
 =?utf-8?B?MEx4STFxUnl3aFBpSXJ0UVVSWmpsZ242dU51V2o0Y1N4Q1RWdElnKy96YmFv?=
 =?utf-8?B?WjJGSW8vR3NEVVEzSklrNXdESk14SEE5ZUQrd1RlWnhxRVptVzFKc2hMTk16?=
 =?utf-8?B?ck9wR0gyd3JuME1Za0loU3R5cWlNdXFaTWRMUGE2K2Jxdk1jUnlSeXJVemN6?=
 =?utf-8?B?ajQwbENQNEM0c3lHKysvRkJqWEpqZjRoNEZ4RXRvY1ZFZXlRY1pMR2YyZ25x?=
 =?utf-8?B?Y3F1a3lmQnltVS9mTTBIUEZURWVyWmdpaU1qdkZobnJsVCtwM1Z3RU1mV2pM?=
 =?utf-8?B?Q0FVQ1NROWFDcWJVUjB5R2ZXYy9JbXd3cFZUWENvTGloZ24ya2lWWEtqd2Fl?=
 =?utf-8?B?R2ZvSFZDbnBaYjlRd0R6Zkt3SVpKZG5EVi9BS1pJUHV6V0t3aDV0c3RLcFdI?=
 =?utf-8?B?RXlSdVF2Z2JWVTNvZU82WVBYUWNhd3lzcnVERzRWb1hMSDVOVStwWGc3a0U0?=
 =?utf-8?B?NGplemFnb3lmdG1LcU1vRFlNdjZBbWx3RDdTLzFTcGFLV0F1Y2cwMWcvRnhk?=
 =?utf-8?B?TTI4SjFlL1ZuYzZYbGRwZDIyNUtId3lBSjlIN0lkSGZMSTcwQUkxUkdiZnVT?=
 =?utf-8?B?MDQwTVl5Z3hrTmUxTnZnaXVYOXNZdDM3S3Q4WFRHVWRDSURhWjJLMjlGTXRm?=
 =?utf-8?B?TkRxWkcyVEpsL2FzSWhodlo5ZE5Kand2a2kvSjByRUpaNnEyUXhNdmpoMENJ?=
 =?utf-8?B?RHZvVVRDcnZ6ejlqUkxvUUdndS9WMTNjeXkvcWpFMlEzeW0wSHQvaHhoZGVQ?=
 =?utf-8?B?NFA4eUY0ZXp6eGJLOC9tc0J3ZkJwMWJTbkp1Q210SFdDZE5qbjVKWWtpNzBi?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <147356C9BB42B04F9496324D3247634B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94061f5-5ea4-4b5d-b679-08db5c340151
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 08:51:03.3080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81mzg8p2IuZn+jQ4TqNW7IUDgm3B5fVybXWnS+iQ7moQdGNl0sxgn0kVjrTWHiwYo/dlUYXg4HtSlcjN52KmrlmayssNy7Xj48YY3ZAC4S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDUuMjAyMyAwODoyNywgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IFRoZXJlIGlzIG5v
IGF0bWVsLHNoZHdjLWRlYm91bmNlciBwcm9wZXJ0eSBmb3IgU0hEV0MuIFRoZSByaWdodCBEVCBw
cm9wZXJ0eQ0KPiBpcyBkZWJvdW5jZS1kZWxheS11cy4gVXNlIGl0Lg0KPiANCj4gRml4ZXM6IDE2
YjE2MWJjZjVkNCAoIkFSTTogZHRzOiBhdDkxOiBzYW1hN2c1OiBhZGQgc2hkd2Mgbm9kZSIpDQo+
IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAu
Y29tPg0KDQpBcHBsaWVkIHRvIGF0OTEtZml4ZXMsIHRoYW5rcyENCg0KPiAtLS0NCj4gIGFyY2gv
YXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEt
c2FtYTdnNWVrLmR0cw0KPiBpbmRleCBhYTVjYzBlOThiYmEuLjIxN2U5Yjk2YzYxZSAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hN2c1ZWsuZHRzDQo+ICsrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cw0KPiBAQCAtNzkyLDcgKzc5Miw3IEBA
ICZzZG1tYzIgew0KPiAgfTsNCj4gIA0KPiAgJnNoZHdjIHsNCj4gLQlhdG1lbCxzaGR3Yy1kZWJv
dW5jZXIgPSA8OTc2PjsNCj4gKwlkZWJvdW5jZS1kZWxheS11cyA9IDw5NzY+Ow0KPiAgCXN0YXR1
cyA9ICJva2F5IjsNCj4gIA0KPiAgCWlucHV0QDAgew0KDQo=
