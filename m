Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B465E913
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjAEKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjAEKfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:35:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A4C13F10;
        Thu,  5 Jan 2023 02:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672914918; x=1704450918;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=F7pMysK3vhIgzzzU65vzrXOMYMAC7rXnDBD89LDsLd4=;
  b=UoxRo+w6R0HgQn9UUNvZl1PuG4hixqcy7Bh1zoaSuHg1h065gHsUW7A8
   ij3s5U74mcAZaU+YIixsvnlO+TDZB25Oz3RHN6SVew5Q4fLc0fE1oJ5d+
   nmbFJUY8+3c2EYWMsxNKAXooSa6IHA/B0mLVCEoCh1IEAiFbA2Df255Ib
   arVMCo0akBaCJjh3HITHJg5yMAkwW6ZisjZlDw6R7ohfChC5jP3SrKa8P
   2f1/fGy0kMn52eRUER5A47vo3kp0Orr0PfuStwlnjlZrGaWXAz/XNovkg
   ZyC3iksFFtd5IRJPrD+FqKFGoQXVsinSUZC/c5pGPr5zETwIO4KXH3PiM
   A==;
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="206513134"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jan 2023 03:35:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 03:35:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 03:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpuWQVhBc7LPtqlmS4N6aQhHFNx0ugbc1CzYa62G0FFtTvBNH9oe7i5mXCZxmR04LAJk7x4DFWnOcSxVy98bYuV55nxWrcBRm5pzZtZXxE1YIMKOZNlkmLH80mhMdOV9BUxjpWaiHiHqV4uLc6ByLMm3R3ThWCF/RoHibBCXS0ePDwdbzNG+V1HUfK67uYhkSwNBGIppT5BaUDAhVpQusS6VY2fVFhDWQ5fdZqkRGkC/A3E+cWTp+0vHBfieN5TLDR/adUxwnt29DAi96A16W73nQUy1xTMsgRsb3OknP4VVxrx61ikyuMUw4z+AF53zrM/GZF0bpmLNS/0uufsAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7pMysK3vhIgzzzU65vzrXOMYMAC7rXnDBD89LDsLd4=;
 b=Zdv1yi5AbkqD+rjpdxWgpHe7aoUH4n9Tm8rHHAzDC9L+bIG8WKQLj9xVScezyjSGUGX4kFesnnkYLlQoQODJMgZENWpIt0L71s8+xyqRRBLQ1EchfWc80yRKRVQwCWnx3HKbXJZfh/F4+GiWBr1koWC67RNL2ZbUVbDvtb2QsoPJv38uH9ac7tq9vL3aQqi44J1puv5Hvr1KWc1pK1IJx0aj6lodWohTTgNZ2VnI6fe28y+/GaPQYBcNvjHN+cXkqXkyeZhlAAtQd6dyGrjkO9aY6CMGpPhcoZ9FkmOfEPtcJZL2p8QzK0ux+LkviQCEYnhOO7hFhOLcKJRYv2VnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7pMysK3vhIgzzzU65vzrXOMYMAC7rXnDBD89LDsLd4=;
 b=AvjK1fG8ngVdovJiVaEvw2mNjz+NqgztwcMcT54Ltm/Pi6E53o/q24Q0BpVQzR9QtGE5SYb5ZwkauIL/MHTiVQNBrKaNY7fiw9wyAnokfbU3ltmG6AJVR5EBnfk0LJ0mvCQXOiHIT5501MispVTM2hDbG7MSdBsUmjEW9dKPKeA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:35:14 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:35:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <quic_srivasam@quicinc.com>, <swboyd@chromium.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
Subject: Re: [PATCH v3 3/4] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock
 registration
Thread-Topic: [PATCH v3 3/4] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock
 registration
Thread-Index: AQHZIPFl4WiGbuQ8gEutVwa5IhrkiA==
Date:   Thu, 5 Jan 2023 10:35:14 +0000
Message-ID: <c4863514-942f-eb31-f79c-d08522f3d2b5@microchip.com>
References: <1672838955-7759-1-git-send-email-quic_srivasam@quicinc.com>
 <1672838955-7759-4-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1672838955-7759-4-git-send-email-quic_srivasam@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SN7PR11MB6852:EE_
x-ms-office365-filtering-correlation-id: 61571c0d-f010-4ae4-015a-08daef088805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9yk1K+LB5dab4r0oKzBcaUuBaVXDhEqRW10oOWN3C7Z7cjApwDQ3xnBnbzi8nJ1UCIJBpdxe8MzGD3ClfOy97wOLSKcB9XzsGJLAN32bUPLFIFEBntEJsqMnOq8ln+Ppp1TBYLbFif8R+/XsmQlbwVx6TcPuumyUEzWiQhKjWTlRxXmPO4Z5Oxkzh3dyHv5Hwn5FQz3C5kvYyMgXkIWuC8y11q4PHkzEl742O2DrdDlX0/A8BlY3VAKZEKS7tVLReV9PQI3sD+W/CVhPbdmoEm9Uw0F8LS+YURZghYdTmHYrZPMWzIVwT4sT1rLAhxRWNOlr91vlExMquax5MfhlVTkvudTwUQ8miZK/PTeKdIV8/1Y2JM+0Lz4YsJ4HgiZLujKZrFONhKMnT7SisXLjy9J0P9dC1r1dlgiWFeXyRIQ456MMD12yxQm+eV0XCPJ6E1fbRjTAld1vqSBy/+H3XHs2/77s/kYDH7hAzxD4uYa7MrHDQ3uhHEtfSe+b9mvjTjlRJaV3Hjb9YBfcboCrM7+hmkVbdPpJjv75fvhbsCSS1Zg+riJOXKHZYCLDvXk4t0muf83YcSMWHvjj+37NIvRfFRQL1lNu7V9ZE8HSsdE3PZFi8ea2YMxiUPauB15YkQK0aihganhdVIlx6vlfMflAAG+EFJ5fB0cgI8PPiL9HU80wsCENK5IwmUW2RCGyHGxJ4b5APHEKyfQ0VH/pNfTLZ1GuNYx21U94ai3jrNtCaD779jShSXdsfcuI6d1pL4Z/kNwW4ihednQq15AukTDJM3p7aj90PTa+ppVw00WlEwf9w+JxmyShJ2Fv0WyM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(38100700002)(122000001)(83380400001)(86362001)(38070700005)(921005)(31696002)(66446008)(7416002)(5660300002)(2906002)(64756008)(76116006)(66556008)(66476007)(8676002)(66946007)(8936002)(41300700001)(6512007)(26005)(186003)(6506007)(53546011)(110136005)(316002)(91956017)(478600001)(71200400001)(6486002)(2616005)(31686004)(36756003)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVRIQ0lvaUx5ZmFGKzhsYkVVMFFmSXZZQm1KaGl1czljWmpIYTNRbk9FT2dl?=
 =?utf-8?B?THhmNkFvNFhaUzhnU0puQ21HRkkvNkFqMnBDYitLM1FGL2pwTzIxWWhSalIv?=
 =?utf-8?B?cWllUTMyeXUxV2pITEEzQUdWOHNCbDNQbHY0dmE3cFZWRXhpRDZQQ2hFUTFi?=
 =?utf-8?B?cDBjZkVML3R1YUpidHllR0dtcG1qamt4TnFTUmpoU3B1MXp1QVhkWlpZRWVs?=
 =?utf-8?B?R29iZmNiRGVEcnVoeVNiRlFwbDhBVVozMWRobHdJTTBaV29USTRZckZJVDJh?=
 =?utf-8?B?UWI1VXNlNWN0cEVOK3ROdHRERzB1cFBTYzkxQUFESG1kUkY4aW5NVU1oSS9S?=
 =?utf-8?B?SEF6ZFlvQVBsVS8raUd0QndlVjdNV0Qwdm00blF2NHZFbytSeEUyTnJKTHhV?=
 =?utf-8?B?U1FXNHJwWVFHVkhtbWtQanRvc0NMZzZTM1E1OUd1WkExaEZpSWE3UnZGQW53?=
 =?utf-8?B?RDlobFVnbmJ3WkpxWUVqWXpJK0NIOUVkazhkZVErdndyZVlzdmJ3aDVnMlNC?=
 =?utf-8?B?cjRnbjN1SzBOLzNsTkRzOFpaeXZFeUhzRGVEYjUzbnU5SGhQa3l2ckNHcHZu?=
 =?utf-8?B?RUpPL2tWTWRRaUxxOWt5RG9nUXp2SXNPVkdyck5BZ3V3eC9sRmR5RVM4OG1l?=
 =?utf-8?B?UHdGdGNwWkdDbzVvNlV0cVpNaU85Vkl2T0lIdDhRWklOTVB2VndDU1dmM3FF?=
 =?utf-8?B?RWRNMWMrYklBMGNXUDBuQ3NXaTB5VUFTRWZpSGw5Q3RNLy85N3djQXU4QUwz?=
 =?utf-8?B?RTlzZWxROTY3ei9jbWdOVWVpNWdQT1FMbHVyaXo0dGtYVjZvWllzQjVqMWk0?=
 =?utf-8?B?UDI1TkJ0YmpQLzFxZmZPYzFBQ09mTkgyK09sN2Erc1hUNzlmeFpTcWU4K3RS?=
 =?utf-8?B?V016alFieDkrL2FIaXZBc0tsZjgyY253akxObVdVaUNOaUVienArT015ODNY?=
 =?utf-8?B?ZFZ3TFJZNzRjWE8razVzdDd0QnF3ZGROYlZYY1FNNkRmYzJBK0NMSU05dXNG?=
 =?utf-8?B?L3dUVGdrUzV5dVNJZ1NPY3d2eTdqVjhUaDQ2VCs0cE1LWXRUdVByTjUxWG5z?=
 =?utf-8?B?eG5uNE1EMHBEbzhhcVV5eHlHRVh6ZjU4RFdsWGl4cUpuUjAyRHpTbWJUZ0Vx?=
 =?utf-8?B?czlIdEwrYTFVRUQ5WDVSYkJYTW1jaEt5OW51dWZCYlhJUnp3anhranRQSUpr?=
 =?utf-8?B?TTFvMXJ1dTRCQnJDaHJSR205MHREU0RtRWdXTjg0MmZ1MTNmN1FnSEpHYlM1?=
 =?utf-8?B?MGE3UWt5NlFnUmk0QTRWZENNcTN6bXM5Nnd3dDN3UDkwaytxSkcyeHJHSzEy?=
 =?utf-8?B?STBCOEJROFE4OFlzWjJ6NTZETmVoSVhXUWFPRk5pckNKRmhCZ2pUVVNHYVJh?=
 =?utf-8?B?c0FndG9PSFlLV1l3bnhqMlk3T1hrVE1JWEJiUjJZYjQ4bUFKdmVDdDJYTTJU?=
 =?utf-8?B?TXRKOHJuR2poQnh3aTJmU2NhL01UWHRGdVhucE5Wam9MWUVTYUZEdzl6bUgr?=
 =?utf-8?B?UEUwbEJJRGJCUVR4S2NoR1p3L0pDdTRFenhiTXBCbWRFMkl2dmc5MHhOeEZv?=
 =?utf-8?B?RW5Mc1BNTTY2RmhXd29xRnovQTVveXpzUjdoK1gzcG9hV2c4eHk5djBaVXNx?=
 =?utf-8?B?RXNZNmZPUlBtMXUrelNjLzl3emRUa01FN2FySEV0RU00L1pyMVpuaFFHbkJU?=
 =?utf-8?B?a3AxakpFNzBLdWlHQWIzdVhRQnpsK21nSWErMkVPOGc5ZzBaNWxWdUgzTUZP?=
 =?utf-8?B?NHR2L1hlN2JZRXBneFEyS0w1eWdVZ2RIUXp1UFUzL25BTjUrdHRGUjFIR0VB?=
 =?utf-8?B?ZVBaMGl5UWxjSzhhVzFFL3A1ZkN4L0N3ZjMzZ1ZXWVoxT3VoKzlxenBPcDR3?=
 =?utf-8?B?SGVpVTZVcXBJYXpwaHkwdTBWK2lxM3RXQ3VnRmp2azUvaDVsdFI1ZVhpVms5?=
 =?utf-8?B?WVo0ZUZhd1V2dUoxc1o4U1JWWWNQMFJJVUJ4dnpzQWFlQXV2bmEwQ3R4eFZs?=
 =?utf-8?B?dkdXRWVTczhRT09IVGpGUEMzOFdGRExjWms2b25qTUN0Zi9kS1ZkNjd3Y2w3?=
 =?utf-8?B?b05SNjNtcDNuZU9VNkZTWXhVM25nTFRzMmVacXlQYUpDZFZMUmk0QUVQdXNI?=
 =?utf-8?B?M1p6cGovMzlmTFlydmdRY0lBOGtwZm83T2RjT1A2RSthTVE0ZHc5ekJseFgz?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03EF8D838D1E2C44A1500C4D47B34794@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61571c0d-f010-4ae4-015a-08daef088805
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 10:35:14.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmLXW2Q+28sbtTvlopBlN87fx61IIxqyWTkxE6sqAyem6l8fAqpMKVr2H/IgGty0kCx6z313YCc5mIRqHzECvYn/K2FeFib5Uz1zB0gvHL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDEuMjAyMyAxNToyOSwgU3Jpbml2YXNhIFJhbyBNYW5kYWRhcHUgd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIHFkc3A2c3MgbWVtb3J5
IHJlZ2lvbiBpcyBiZWluZyBzaGFyZWQgYnkgQURTUCByZW1vdGVwcm9jIGRldmljZSBhbmQNCj4g
bHBhc3NjYyBjbG9jayBkZXZpY2UsIGhlbmNlIGNhdXNpbmcgbWVtb3J5IGNvbmZsaWN0Lg0KPiBB
cyB0aGUgcWRzcDZzcyBjbG9ja3MgYXJlIGJlaW5nIGVuYWJsZWQgaW4gcmVtb3RlcHJvYyBkcml2
ZXIsIHNraXAgcWRzcDZzcw0KPiBjbG9jayByZWdpc3RyYXRpb24gaWYgInFjb20sYWRzcC1waWwt
bW9kZSIgaXMgZW5hYmxlZC4NCj4gDQo+IEZpeGVzOiA0YWI0M2QxNzExODEgKCJjbGs6IHFjb206
IEFkZCBscGFzcyBjbG9jayBjb250cm9sbGVyIGRyaXZlciBmb3IgU0M3MjgwIikNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNyaW5pdmFzYSBSYW8gTWFuZGFkYXB1IDxxdWljX3NyaXZhc2FtQHF1aWNp
bmMuY29tPg0KPiBUZXN0ZWQtYnk6IE1vaGFtbWFkIFJhZmkgU2hhaWsgPHF1aWNfbW9oc0BxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9xY29tL2xwYXNzY2Mtc2M3MjgwLmMgfCAx
NSArKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvcWNvbS9scGFzc2Nj
LXNjNzI4MC5jIGIvZHJpdmVycy9jbGsvcWNvbS9scGFzc2NjLXNjNzI4MC5jDQo+IGluZGV4IDVj
MWUxN2IuLmUxYWYzMmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL3Fjb20vbHBhc3NjYy1z
YzcyODAuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9xY29tL2xwYXNzY2Mtc2M3MjgwLmMNCj4gQEAg
LTExOCwxMiArMTE4LDE1IEBAIHN0YXRpYyBpbnQgbHBhc3NfY2Nfc2M3MjgwX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgICAgICAgICBnb3RvIGRlc3Ryb3lf
cG1fY2xrOw0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgbHBhc3NfcmVnbWFwX2NvbmZpZy5u
YW1lID0gInFkc3A2c3MiOw0KPiAtICAgICAgIGRlc2MgPSAmbHBhc3NfcWRzcDZzc19zYzcyODBf
ZGVzYzsNCj4gLQ0KPiAtICAgICAgIHJldCA9IHFjb21fY2NfcHJvYmVfYnlfaW5kZXgocGRldiwg
MCwgZGVzYyk7DQo+IC0gICAgICAgaWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgIGdvdG8gZGVz
dHJveV9wbV9jbGs7DQo+ICsgICAgICAgaWYgKCFvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wocGRldi0+
ZGV2Lm9mX25vZGUsICJxY29tLGFkc3AtcGlsLW1vZGUiKSkgew0KPiArICAgICAgICAgICAgICAg
bHBhc3NfcmVnbWFwX2NvbmZpZy5uYW1lID0gInFkc3A2c3MiOw0KPiArICAgICAgICAgICAgICAg
ZGVzYyA9ICZscGFzc19xZHNwNnNzX3NjNzI4MF9kZXNjOw0KPiArDQo+ICsgICAgICAgICAgICAg
ICByZXQgPSBxY29tX2NjX3Byb2JlX2J5X2luZGV4KHBkZXYsIDAsIGRlc2MpOw0KPiArICAgICAg
ICAgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBkZXN0cm95
X3BtX2NsazsNCj4gKyAgICAgICAgICAgICAgIH0NCg0KVGhlIH0gc2VlbXMgZXh0cmEgaGVyZS4N
Cg0KPiArICAgICAgIH0NCj4gDQo+ICAgICAgICAgbHBhc3NfcmVnbWFwX2NvbmZpZy5uYW1lID0g
InRvcF9jYyI7DQo+ICAgICAgICAgZGVzYyA9ICZscGFzc19jY190b3Bfc2M3MjgwX2Rlc2M7DQo+
IC0tDQo+IDIuNy40DQo+IA0KDQo=
