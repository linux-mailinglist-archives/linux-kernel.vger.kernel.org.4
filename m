Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE474D00E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGJIgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGJIgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:36:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76598E6;
        Mon, 10 Jul 2023 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688978164; x=1720514164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WYiA6weZnusNRqrd+xRCXu5qbtIehTQXw+b2pBpuBkI=;
  b=pclbTClpfcju9URFr0f69t2q7mCNEr554mke3+/mCBBfRhDgQCGx8JQp
   2k09N5NIWGueUJFXvccvtD23BI4mVwDd3QDFdy2T/3II8YCvsOoG5rPkL
   QJv//4fWPyVTZxDk7Sc0sWwdqGnjIJQPHIjdQeu2bB9px1unjSCxwu5k6
   c9aZp76vU+wz2/omdmITDI1MgXilPHIA/OOrxmjamQUaNTLCZbzzreW9s
   bseid9MHNtK3IPugdJWh9oiyekG/DfQu3pJN8SQCJ3nB9M2gus7o1zTcG
   s+X93cEWB4ydBn79I4LowyWGXns8T3/YUiF6WnODPCMTjPd4la9ImDAgy
   g==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="234563588"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2023 01:36:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 10 Jul 2023 01:36:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 10 Jul 2023 01:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCSkF87RaqR9lnYcgo1PLANvF/EUNDyW763eo3L+wtjQn/811U2Zfq0GzKD8RE+gP5Rvj3t0XpGezdQYuG2a2U5yuR2A9leosngaxUdVZx566Ts/bai9gTy0bmGv20E0isWTfKlUr07RtxIv536qOU+pQITGtVHkOQFHOjjWwIV/8+00oYtqlRvL8Uxj0iZ5duPRtxKKECyECgJ1nkXqCTrypUjd/ddTYnAtnpOIvjwNTgfQ29KD7yGcd/niXHzP53D5c+9sNkR1ZF2fc4P4fHa3lLAYUnF8jVSw1Y3qsF2fIsaVHAIj1Kd0+AVfJ5C1FxeWwoaJ8qkRJdBO3CXfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYiA6weZnusNRqrd+xRCXu5qbtIehTQXw+b2pBpuBkI=;
 b=mYWRDq8ZNy/IozCZ8dRcwEOedbmCjfxDXR00skii3H8ZDTnYqTE7GtrSds02JlBcSB1R0gcYfvy7DP+M65N5JUX4bhzvy4Iz8QwgwILIhp0H55Pt4cLARxwXRuZAko8VpJupPsIDIbfxnTHnGjwIjg9nbugEflH0Vj0Q5ZjtkGu/Oq2tVEVmex43R8MIAUWWPe5FHe57Zu8zhGTA1KQRMDxJKG9kCBYyQCY75o2SPW0vVuEuW9LMFnGYGrktev7dKsjfajIBFIuLzXC5GHQKTh3hNf262X4TMIQxsmCWywKGIN7OBJT/6awCEcBqpkm6qPL7MlIi1Y+PfbcFthi8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYiA6weZnusNRqrd+xRCXu5qbtIehTQXw+b2pBpuBkI=;
 b=ktupNegBGgc09kjaC4QXbO/4jEe2mcfWkiI1t4b2D4q+15iEya8ySxT5JjqtHQi9mayLXd20IX5JQ0pfC7+Lt+fLaZIsYS1GkbUCjEquI0CEi2dRTyQ4JJfYf34ZqMKS8D7jkUqsD4oPt0avq0C2WDPgAJXHOhzv++V8clbKgPo=
Received: from SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 08:36:00 +0000
Received: from SJ0PR11MB7154.namprd11.prod.outlook.com
 ([fe80::5682:c38f:aada:227a]) by SJ0PR11MB7154.namprd11.prod.outlook.com
 ([fe80::5682:c38f:aada:227a%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 08:36:00 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <tudor.ambarus@linaro.org>, <Ryan.Wanner@microchip.com>,
        <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a maintainer for Microchip SPI
Thread-Topic: [PATCH] MAINTAINERS: Add myself as a maintainer for Microchip
 SPI
Thread-Index: AQHZswmNI3QLNXr9a0OkMq43fonpuA==
Date:   Mon, 10 Jul 2023 08:35:59 +0000
Message-ID: <646c6dad-0c47-f7ea-1493-8d546b80f016@microchip.com>
References: <20230630161700.448747-1-Ryan.Wanner@microchip.com>
 <9609c217-45b7-211b-7ec0-5e4275b1ed78@linaro.org>
In-Reply-To: <9609c217-45b7-211b-7ec0-5e4275b1ed78@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7154:EE_|IA1PR11MB7176:EE_
x-ms-office365-filtering-correlation-id: 545904c5-1866-4a7a-2ef2-08db8120b055
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s/lq3Dkkmp1VBNZnoYqSwu6tFDBeWSbv9apwqJ1sssmahGHoKQBSJ55AShyX3vXepV9M/VKRfUfYqE6nyElTAVgMeGVcRW1F1mcMj+De6hemdLmHmBfMJfjlJtTg+xc3AR1i4VUzospwV4S7exCBxZVKNYjL6bd2j+1CnVm1CbHPEVqiUQNvHqW05W7DJb2CkZV9/jP+MlspCj9s8x+vx1J1yAW+HXNea5VMSIAGwQyAj6ssEjW8/qiiH1IgWC/A6EeNLPSY3GMtSXsqGJVDeOoYE1F1fdy/eIH7YBf5jZKyLgRwl3jWZ/wdTisCD0N6GK28euHw5zDCW2JSYyGzAWTTto6K/LMgg+oYdwenMOOqN7TxBMa7Q8PUUxEdT6ukYxWoiInZaGIKfjhGcFyTlZgd184YreZW/bWfl22lJQMnIAW1hIGgDrw/yKWIod80GdWtUNbiyFXM7mqs84Gb741SKxnZ5x48zJ8GvmEgr6sumgM14PBtp5H4FyRETmTmPrx4/6fVz1pkQSVq2BT0b8/9hiSdVRVZxSUDfb9DlDKy+za/gLqV2jZFDBRuDFOki7nBJdYJhJnEXLVn2HMKh+cOGlUd/lX+v+PtUza7Lf7WET0y9IWeLvBiOLVPD5mHd+DBhaHbp6jBhaxMA+HnLj12YH8y3HWbRtybclxTQoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(53546011)(26005)(6506007)(2616005)(966005)(6512007)(83380400001)(41300700001)(4326008)(64756008)(66446008)(2906002)(66556008)(316002)(5660300002)(66476007)(8676002)(8936002)(478600001)(66946007)(6486002)(76116006)(91956017)(110136005)(54906003)(71200400001)(36756003)(122000001)(38100700002)(31696002)(86362001)(38070700005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkhHTko1dGpHNGtHS0dhb2puaFg3SU1kYlBCRCtab2NZaEduTkdrTjYvK3k2?=
 =?utf-8?B?aVNBNW1MdCsrc2MrZG5paE1reU5QSXAzRGFkdmNLUzBqc3NzMEwvYVkyZDIr?=
 =?utf-8?B?TEhIYnNrVlBBVUI5NzBzR3FRcGFkSGVONVZNY1lSUjd3bVVFeENPamZSUjg0?=
 =?utf-8?B?elcyK0loSHJLbGthY1JqcTNzQ1FrUGVBa1hkRHNEcUlLOGlWYlY4SzRnY20z?=
 =?utf-8?B?Mk5GYk84U2tCMERpVXArTS9zVVZVZWE2a3B2eTl0QjJ2MDdGVktWZXJBTUVT?=
 =?utf-8?B?ODhUVG1PcHExZTVnYzA2aE5KclIyanlzV1Q2VWtDbW9XVzlWeGZkQS94cWpT?=
 =?utf-8?B?SmRISjUvM3k1MkUzVmdLVThVc0FFQmNSZU1hSlFNNWFhazFJWFRjUk1oclNw?=
 =?utf-8?B?bTFhL0NPMzlMa3Zqc1YyREJKU1dtNWxBa3FyMVZjUlBBZzA1M1VVY2NvZWZN?=
 =?utf-8?B?SkwyVEIzaEtEbGNBYVF3NnFjekJQWWRZUlRFSDJuOUNnRzBvWG95d2JqaEVF?=
 =?utf-8?B?TU83REZCaTZ1WVpCeVA5UTNZcXpYdmZwK3h0Z1dJQmtwbTZlcWd5ZmJZS1Fu?=
 =?utf-8?B?SU1XaHI3bFE3cXBtMGtsK1UzYzRoSUcyNGN0SkZNb3N6clkvMmc5WkVCVHNJ?=
 =?utf-8?B?VHBsUjErSjVvZGNCTlR4clllL25qcjhCQlJvOVQ1QkVMbjBSVW1wYmRoK2Ry?=
 =?utf-8?B?d2xWdjdFc2NvakhFWkFvdkRESWxaUmEyM21ta3BBWmNZaElDdkVBSG1BQ0xS?=
 =?utf-8?B?MnZ4TUJYZmdENEdNdGVRblhqcTRRNVZNaG9pa1g2VnllVzY2UVlvR3cwUjdp?=
 =?utf-8?B?T09uTnRwZFdBcG5iTUNPZG5WNFd2NmhsSnBOSmlwQXArSlBOeHJSeDUvZzhm?=
 =?utf-8?B?dlVIeDM2OXV1aXVlRytoQjlTN2cwT0RnTkJHbWk2Y1h6UXpOcE5qbzhuanhP?=
 =?utf-8?B?YVYwdjlQdGRXZGhmVGl4ZFRxcDI1ZUd2QlBVdk15MW5ydVNYenBTTGplWkVP?=
 =?utf-8?B?bC9jSFFoMzNqNndQQXp0TCtXK2pWR1B2QmgvUjUvV25HdEdPWStjVkdmZFc1?=
 =?utf-8?B?Qm9kNVMxd09LdG5LTFdDR3gvbUdhVTlXNzhMcGg4T21kblVUczN2eUNtR0dO?=
 =?utf-8?B?aktqanVNVlpJMENaWm5kR3o2UFQ5dWR1dmRCa0kxbVRxcTZLdUxNYmxUWk1S?=
 =?utf-8?B?eTNRL1ZzTDUwc05mdjFvODEzQnVuTklxWERVYWR6ODNYcitFQXEzNENVSTBi?=
 =?utf-8?B?OGh4Y0dlelcvQjBkaWMxMU8zTDN0RUtZRjdUS3VjVFRZUXlMUU92ZHZVK2RK?=
 =?utf-8?B?MlNOY2V2N2lLa04wdnZIVzdIN2tyK2M3eW5qTWVIN2JTWU1JQWVZZ0g5WUJw?=
 =?utf-8?B?aUxhZXkwTUh5WTAxSmRVM1dNWEVraVVFeStiNHMrQnVJUTdXbDBtNUZOYzZ5?=
 =?utf-8?B?VkZlZ1U1MmQ5M1FDYW1TRS9oeXRZRmFVT09oY0RnV05zTzdRTmxzVktyQ0oy?=
 =?utf-8?B?VzBMYXNZWTZEa2xQZWhHZk5MQldVeDNBUlpSc3AzQmtiU2UzMC82S2h4TTly?=
 =?utf-8?B?Q29IblA5MUUyWHdraUJjcVFwdzd3WDZzYytJcjdyOEhVL0lOOXh1NVlpQi8y?=
 =?utf-8?B?aHFQN1VHdytaNlhlUENEazVIMHcxVjFRN2I2OHlVQUtLemM4TlpLV2JoZGxx?=
 =?utf-8?B?MndJYjA2cmNHdmhmZW5uc3ZaTEt0T1U0YkdxZUdKZEdsMTJkcXVkem1YbnBz?=
 =?utf-8?B?UjNIcGt3OC85c0lBN3hHRUVCTC9KMkljQnZVcUhVbUFGRHlSdjhVRTMxVkJP?=
 =?utf-8?B?cldCQVU5QVUxQzV2QThTemhKV0ZLMG5PdDhXQnN5VDk0azd6VW16dFFBUWhK?=
 =?utf-8?B?aythdTJVVGprSVFSWmJ3WldJaGkxTGlmQmdsYzdCZm9NM0dKQy9pdWU2dFc4?=
 =?utf-8?B?bUZRQ3BzbFFDOUlHM285MEhCYmxUOTlYb2Q5eXM0ZzlGeGRNRllhem1xaXpB?=
 =?utf-8?B?SWp4Wko1OUxTTXl4SVhkOHpBWVRVeVVlOUl6NURaMTBxNWZtalNSeFFtQlhU?=
 =?utf-8?B?ODk2ZVdHVnhkZVV6R1lmSGE5YVFSOTlncUJ5Y2lMcVc1MzY3WmEyS1orS1Zw?=
 =?utf-8?Q?DEoA3m+45YAhc+ihmifQIwba4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBA2B504F7FDC542B068B2A6A1550652@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545904c5-1866-4a7a-2ef2-08db8120b055
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 08:36:00.0130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoyJnj7xFpPQ/WWQ0+EuwImzYVo3HoYQtWbv3T0IwfID+XSWBXNt4d/a498ycPpV/Y3QzUlyEhKpdOKhAUi80KQSH+lwIQA8gq9GDnON9D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMDcvMjAyMyBhdCAwOTo0MiwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gSGksIFJ5YW4s
DQo+IA0KPiBZb3Ugc2hvdWxkIHByb2JhYmx5IGFkZCBpbiBUby9DYyBsaW51eC1zcGlAdmdlci5r
ZXJuZWwub3JnDQo+IGlmIHlvdSB3YW50IE1hcmsgdG8gcXVldWUgaXQuDQo+IA0KPiBPbiA2LzMw
LzIzIDE3OjE3LCBSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogUnlh
biBXYW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVHVkb3IgaXMgbm90
IHdpdGggTWljcm9jaGlwIGFueW1vcmUuIEkgaGF2ZSB3b3JrZWQgbGF0ZWx5DQo+PiB3aXRoIE1p
Y3JvY2hpcCBTUEkgZHJpdmVycyByZXBsYWNpbmcgVHVkb3Igd2l0aCBteXNlbGYgYXMgdGhpcw0K
Pj4gbWFpbnRhaW5lci4NCj4+DQo+IA0KPiBEZXNjcmliZSB5b3VyIGNoYW5nZXMgaW4gaW1wZXJh
dGl2ZSBtb29kLg0KPiANCj4gSSBhZ3JlZSB0byBiZSByZXBsYWNlZDoNCj4gQWNrZWQtYnk6IFR1
ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz4NCg0KVGhhbmtzIFR1ZG9yLiBH
b29kIGx1Y2sgUnlhbjoNCkFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1p
Y3JvY2hpcC5jb20+DQoNCk1hcmssIHBsZWFzZSB0ZWxsIHVzIGlmIHlvdSB3YW50IGEgdjIgcGF0
Y2ggdG8gYmUgcmUtc2VudC4NCg0KQmVzdCByZWdhcmRzLA0KICAgTmljb2xhcw0KDQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBSeWFuIFdhbm5lciA8Unlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbT4NCj4+IC0t
LQ0KPj4gICBNQUlOVEFJTkVSUyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIv
TUFJTlRBSU5FUlMNCj4+IGluZGV4IGFkMzJkYjZjODFjYy4uODQ3OGNjODJmMTk3IDEwMDY0NA0K
Pj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4+ICsrKyBiL01BSU5UQUlORVJTDQo+PiBAQCAtMTM4ODEs
NyArMTM4ODEsNyBAQCBUOglnaXQgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvY29ub3IvbGludXguZ2l0Lw0KPj4gICBGOglkcml2ZXJzL3NvYy9taWNyb2No
aXAvDQo+PiAgIA0KPj4gICBNSUNST0NISVAgU1BJIERSSVZFUg0KPj4gLU06CVR1ZG9yIEFtYmFy
dXMgPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz4NCj4+ICtNOglSeWFuIFdhbm5lciA8cnlhbi53
YW5uZXJAbWljcm9jaGlwLmNvbT4NCj4+ICAgUzoJU3VwcG9ydGVkDQo+PiAgIEY6CWRyaXZlcnMv
c3BpL3NwaS1hdG1lbC4qDQo+PiAgIA0KPiANCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQoNCg==
