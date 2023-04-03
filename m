Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACC6D450C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjDCM71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjDCM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:59:25 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F76A68;
        Mon,  3 Apr 2023 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680526762;
  x=1712062762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kDzldnVFlwdtC+KTpfCDivGkteDbLxv7pprErSk51uM=;
  b=CDj2AWgMCBvX42ZEUxWc8WU6fEIUniFaytaXasyHmuqYHH3B9Zd+z9TI
   grNl69JecFnWKjgL3LYjGxz9u1hTzq8PDUWPK3OBpwOMF9jarWO4h0vWZ
   eGg2yJAcMCU2b2h/9x59zSBdMIHGcEmHBAXAfvvRhpskO4cyhDh70rDQU
   UjwVhizvxhgr6FfZdjB5UJQlp4S10Wb8kTTgMZKGgtT+MfD2c+AAgxrOr
   lcPhUT7u/529zQCFu/Gs5PZfA5qIO/dGFWymkutFp6lf6P4u0c8uAPWgF
   byzsjFFtjLkeA/elX5ywz9s90aO3hKdv2pCZhUfHC60zjJf1I+A4onrpf
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ0LnB2NgX7FTV0IVQmiZX5dxO9NfaH84f6gxU227lrhyc6blPjuYY7pcUy4GKZeVsx/XdH21wfcQESzZkdCfF8m/+0PRwcOY53fHhcjG19tUvBJ2QUJS4Dl7c6WVMyJcW3zhAFZkqaBBoNrtbqqkcRUzoYcCQJSVApY+VNIhzB4bUOf6WKfZuXL6TEMvSAEbxjKn8Af70/Y/Kt+aFm0czCkSNNxqVbH7lSEh+tNJNF/0KFsQ0xj4YXNN39VHvkGQcYEf44Hf0jb9lkV7F1mExX+0t9H+dx8kE6U0fKP3GWcK2VAOlZ+0P843lZR4hiGQEm5KucYdPTpNtzfddkj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDzldnVFlwdtC+KTpfCDivGkteDbLxv7pprErSk51uM=;
 b=TUca8kNyJa8D5xa/biEqd0TyaUdU/sNWfOauQxgQbAF12oCBa3WJNgMU7krr05z89u3UmU47aYyXncMgzf52yu+ynumG11GLMullfiSKFvuW73ilaI9yLsF6SmoZKEh0m9x2VW+4tY+GAWZyohbnTt5Ah07mMNZu/Y8XDG2k9yex05IL5FZ9Gp2lkwusZq+OQbVt4hobl6wexzCSBiQ7xGk+jHO6K3FcC9X9Cxr6T6WW0++KVqvI93duNZGkIIl6NXaVW9oQg4YV1SefLs4xhslZs1htktpBhK/7EJhnFCOKScI1xWqzvIQIglCVcp5CulyvzXBlhhIo9AxegyHVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDzldnVFlwdtC+KTpfCDivGkteDbLxv7pprErSk51uM=;
 b=V3Ht4QMuTZim45spQR6NcKycP/GW4K3QaTnHWPrDw4BxLKqxiebmApCyq2ZDtCgGl8ezhMjlwmmDa8FkcPZicg86Zr24plidclgPF3JMcjWolvhDRcsKC+kA+zz/UgMux9PezVCtCTzlKqkN0wxbrZJzZailabr+DZUfc5zH9hk=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>
CC:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "error27@gmail.com" <error27@gmail.com>
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: explicitly return 0 for
 shared timer
Thread-Topic: [PATCH] clocksource/drivers/exynos_mct: explicitly return 0 for
 shared timer
Thread-Index: AQHZZhBPqLxFH3AG7kyrhpgtTMEf0q8ZjBAA
Date:   Mon, 3 Apr 2023 12:59:17 +0000
Message-ID: <db70b75c3eb4160ae25e6f0d6a8219f032cfb416.camel@axis.com>
References: <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|VI1PR02MB6429:EE_
x-ms-office365-filtering-correlation-id: 13e0e2ab-72ef-48b1-7ae2-08db34433ba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0FXznqg6UAUZ24FKXbcxsgg+u1Yhz1GGcG1YEzYawKvpfLfjru7gmHypoSQvosdHnipr6Vd2Nz8sNpQBq6OSXJuaRTDVANW9VzLp9ztHHKsufzmLYtC8XPZgBcnPYt1kVz2mS4ihz+5MW+ARLkkvf0UiAKZ25vHLTdNfc4tGhByMWbUEXeadwoQTsxQMFeNo/mdjoX2ObCW9endjL5yMpcuLPHf97NTGrEOubQ9zS+EBo7nVbNujFByae0Dn1a9Bce6d178C++ilKsaUaba1aFwk8a/7uZmR7vhSpWklmFTfFdSbadhvMOBMZVLZRAtsNAWiSATx9W5iErcHM+E4A2Zv0yI0SoqQ8WEWb6tzGkl+8wV1p9UHYiwP92E1FGJBKgHDlE+k/FvO8IEPub0WNvt/u/lr56s/31vL/h+lDJ0131UoyJqfteeoeJBSr611qdJKojPqnhyTW3Gtp/F6LcXxOrW02H8VgIIaw1Exe5abMkkRg/cnmq4vmhq6FZc1O1n7GO8P+T2oYgN+Ent0nuPVugnSh0GPI3wwJbiGoUuLtPEs0bERuq4N0TOWTft0KnjyFEDxf5DXnirkK4XZKp+qKtP6zT1U/dgfVjAiws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(451199021)(91956017)(8676002)(66476007)(4326008)(66556008)(64756008)(66946007)(66446008)(76116006)(478600001)(316002)(110136005)(54906003)(8936002)(4744005)(41300700001)(38100700002)(122000001)(5660300002)(186003)(83380400001)(2616005)(966005)(71200400001)(6486002)(26005)(6506007)(6512007)(86362001)(36756003)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm96eFlUK2d6R0MzY1UrOXVML2NuZld0WERhcmRRQU5wWm9aQVE2N3ZmRFY4?=
 =?utf-8?B?ZGNZcEoyMTh2YmxGdHp3MmVoVFZ6WWE2U2ZnZDNRTEg3bUJQS3ppN0hGQ1hS?=
 =?utf-8?B?OEVIak1EQThrZlljalRNSlRMNDNPeXlwRDlscXNmcHprNWljU2YvSWp0bHI1?=
 =?utf-8?B?VG50ajFBdkVpYkFkTE1TUExPUmV1aEhkandzOFpVamZLRE1hU1N3N3hoMGlC?=
 =?utf-8?B?bEl6VGpGVFFHaXdVb2ZmTDBrenhiZWdHUlBZSXdONm5pZlc3eHY1bTJjWnQ3?=
 =?utf-8?B?aW9Gb0FUc0hqbnFwdDR3eFpBVjZ3NVRJZkNONUVvc25zYnl2b1VlSDZCMllw?=
 =?utf-8?B?OWhVckhEdjNKL01qOU93bVBDM2NLMkM5TjRDZlNVU0xBZlp3cHlDTFVvRVNG?=
 =?utf-8?B?Nlo3SWh6MjJteXhacDhLdXJleGxzcE1DdTR3Yk9qR1hVazNPZWZOSUczY2lL?=
 =?utf-8?B?QVlxQUM2MmdKVDVSN0ZQWHVIdDMvcG15aGNhNHJtV3JxZnQybGhOK0g4dWFC?=
 =?utf-8?B?c3A5ZUtCdVBmcUU4VlA2dmUwdmlRVk9yZzkwMFlKdDA4M1NYa0VQUEphVHlh?=
 =?utf-8?B?ZXVpRlVPQ0k3Smo1SjE5Ulh2V2s0NTl3cEhkaCtjUjZYbllIZjIrS1Y1UTg5?=
 =?utf-8?B?M0xKRUJCbFBmeXBVRmVxMzl6MmJEOE1zYUJRZGFxVTBSWnFpNDdHMW51NXNN?=
 =?utf-8?B?TTFPK3lwaktncEp2RC81TGJJYStvS2k2b3RCWmxKVkJieUtuRVJINEtUYW82?=
 =?utf-8?B?aXRrbjNtNjlOUVJ5bnpENlJvM3FhTWEyM0huNGI3TFdUOVNWaHZpamtoMGRs?=
 =?utf-8?B?cmFPbjhCRzZnaDVDM20vTUxZaHBIdlIrUVpsQXlydVRJOGwvZFJUTGh2VzZi?=
 =?utf-8?B?WEpxaGtER084RlUvVEgvbVdiYUlhUWZiRlpSYS9wNWFySzUwZGNrNWFGWHpy?=
 =?utf-8?B?Yy9FRTBOQW9QdFJuemxhcWRoN2VGbFdER2x5R1NyRldBOUlSSjQ0clJ1c2M4?=
 =?utf-8?B?anJYaVdqaGkzdlZPbUd1N05mbDNNdG1YZlpJWHNSRDBNYkk5ZnVpN2FrUkZ4?=
 =?utf-8?B?M040WXF4VnNzV3o1OEx4aXVIYVBra2RjOHBtNTFRdFhxUHF1elhKUWRtNzY1?=
 =?utf-8?B?TGhuMGlCZFZoL1RXaGhRMkhZQjBKUi8yQjV0THBOdTJmV0I1VnhHNnY4Ymdn?=
 =?utf-8?B?dTNLSzRNRWVwY2EwOGpVUkVGUmxRN05oMXJ2VDZRWnV0L1AwTGFKandPSTVk?=
 =?utf-8?B?YkpoS3lsS292TU9GcWVFeTFhMUQ3S1Zmb2hZRkhGWmtxd1BEVVhnTFNZK3My?=
 =?utf-8?B?cnNqRFYzRmhqdjI5ZDZmM0M2YzlwK1l6aVBicHVaZmN3MDdvRkpDMFpxMm9K?=
 =?utf-8?B?d0dmTHdwZEptOWFuYk1OMnRsNVJ3R2hYRkp2UEk4eTA5OTBqSHVuVnd3Q2sr?=
 =?utf-8?B?Y29aZjJVcndITnAwYWZKSTMxSEZFUkFkSC8zVkFjS1dzODFxYlJrTFZQL0U3?=
 =?utf-8?B?d1pBYThNQ2NVNXUvRkNkWThHczYrN0lIQkFBMncrVlZjMzBZdkt6Qkh6WE1t?=
 =?utf-8?B?OEZiY0E1WUs0bitKb3BFYVZ6Q2p3azFBK2lHcmttR21OS2UrZWh5dzdtVGlz?=
 =?utf-8?B?MzAwN1R0UENjYVVvMVh4b0xPclJ4RkhiWStJODVlNklpVW1HWVBDcFppK0Ux?=
 =?utf-8?B?c2Iyakpvb3A1bmZOVjZlbUxXMFBXeitSMDV2VlVsNTEvMkJpVXFVQUFaenl4?=
 =?utf-8?B?dXRFdXJYUDB1aTZUR2lZQXlrSTRIdWxFd3UydHZiM3hFaXA5UFJnbllXWDZO?=
 =?utf-8?B?Z0xFa3dHY3pYdWF4M1NvSmV4eDd4WnBhc0o2bURtc0llN3FlTUVORThjYmNX?=
 =?utf-8?B?cU1uNGw0RFQ4aG13REEvV05jV0psQXNEQ1VuOGJlTW5XVEtZWWZWNkFwd3k5?=
 =?utf-8?B?Z2hreTJkZ0xobDAxVkYzQ0pmRFcyTzVSTStOcmJSb202RHZGUXVXWVJiWUNo?=
 =?utf-8?B?OXVNM2lKNEUwS20rRUw3U1Q0d1crRGUxd1RnTUwyM3dKMWVUd05iOEJvdCty?=
 =?utf-8?B?bnpubDFTd2pxYnFjOFhmc2NaQ0IwN2JsVHZSSUcyUWd4QW1qalhKa3NMRTQv?=
 =?utf-8?Q?PEx+oL8oAs6QEH957bN1HH69h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37D465D065048240B9A2FAAB8ED41A7E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e0e2ab-72ef-48b1-7ae2-08db34433ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 12:59:17.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqS90Hz+Rr/eo770+RBG/9ZTC/H9GUoO4B9+zSj6ldDdrAKQezPnxx58y8GgxuaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6429
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDExOjQwICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBGb3IgYSBzaGFyZWQgdGltZXJzLCB0aGUgbWN0X2luaXRfZHQoKSBzaG91bGQgbm90
IGluaXRpYWxpemUgdGhlIGNsb2NrDQo+IGV2ZW4gd2l0aCBnbG9iYWwgY29tcGFyYXRvci4gIFRo
aXMgaXMgbm90IGFuIGVycm9yLCB0aHVzIHRoZSBmdW5jdGlvbg0KPiBzaG91bGQgc2ltcGx5IHJl
dHVybiAwLCBub3QgJ3JldCcuDQo+IA0KPiBUaGlzIGFsc28gZml4ZXMgc21hdGNoIHdhcm5pbmc6
DQo+IA0KPiDCoMKgZHJpdmVycy9jbG9ja3NvdXJjZS9leHlub3NfbWN0LmM6NjM1IG1jdF9pbml0
X2R0KCkgd2FybjogbWlzc2luZyBlcnJvciBjb2RlPyAncmV0Jw0KPiANCj4gUmVwb3J0ZWQtYnk6
IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogRGFuIENh
cnBlbnRlciA8ZXJyb3IyN0BnbWFpbC5jb20+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyMzA0MDIxNDQ2LjQ2WFZLYWcwLWxrcEBpbnRlbC5jb20vDQo+IFNpZ25lZC1vZmYt
Ynk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4N
Cg0KUmV2aWV3ZWQtYnk6IFZpbmNlbnQgV2hpdGNodXJjaCA8dmluY2VudC53aGl0Y2h1cmNoQGF4
aXMuY29tPg0KDQo=
