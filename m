Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432B06FD7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbjEJHO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEJHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:14:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D64C3583;
        Wed, 10 May 2023 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683702864; x=1715238864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fv6mA4QcvDqGLqB7Gky7WINmONotkmViUvHqXWfHYNg=;
  b=mNVqtZn6c/sW2/FZI6rWFjxWZd2Y9YN/VMwsWdy1GEgHE5Jm+RrhSUyQ
   hSL3qVjCVQ2MP+8vI0A6UlLLljeCTfk/JPr8vcYoq6UdXVns8jXnXruG3
   wqIE6HabBoLVpqIRAl8kW1bhfzX4eaFjuE7KRSLyQbmkhhCEK7AT711vg
   5Lzpph6igPuqwjIAwfg/we+NEhUYcb+7OriU8FZdgCnJegn5KFGzbBTpe
   1OcDF1P0si8xn6uo2hvZ655xC5Hq+H5iiUrqGUe4O9uMSTujEB4HlcLUs
   00DHRh0nlF4vJJel+mSRbH5FBEqXf1dxI7FBJsn82WhK6khiOTTT3obMc
   w==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="scan'208";a="151273000"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 00:14:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 00:14:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 10 May 2023 00:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwmFjBcs9HUkZssh/wP2/7O/dkOEKngtgvWKCCrnjLPSXM1Y/mWsKx+LPwArWv+2idhK1flcrZkc24modKsLzgt+3/+4zQ1KIjS5B/JYcwoakdfJo1XTi+L64p8uqmOw7B+Bcxx4FlGgAZaoFMbn4+6STn4HQlM8pnXdkfA0yozKm3usZ+M4uQK3tC3u11EAGk64MTs00dsvnE7d5XNqODCBwXbKMAQI5nawrFxAsoI3wgqmN3hiGnfTLzzXMonyS8yii6lJ72XoGk8UNL+UviZ9/5Yd0agR9sAnMJaJksjWS2JMSGdkYC3/TrWWbUvWExhIG/ZuTBNgVun0Rfxqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv6mA4QcvDqGLqB7Gky7WINmONotkmViUvHqXWfHYNg=;
 b=nb2pydgGq3oFjbBDEqV0vvoSM0838wdyfcymg189Ryyu8GCyUD6vgoVDpe0TggcDV4Me60FfQpSdY0+2EuPgpXJG5dcGLdeWxhbgvpOzw8eOr1W8BkB3FoLG0EB9l3XlM+0zdo8z3DVNZ1YgJ077xkvwZVbX3Gks076fXORHubXUwh4RBl3d/XdZDak7QJfLZMEnDRhf8HCWM1Dv1im77MaPxqz/+XB7vgGNOAnDPz2a+pfrtocJVGrrq1wxXVD8xu+kIQtK99yjw6/Aoufl0FJMWP8gAcC+mt37mJSU2EeYABU7+9zsM+ogpw9k5qIxOTuh31ENNBqTQQvOA/+d8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv6mA4QcvDqGLqB7Gky7WINmONotkmViUvHqXWfHYNg=;
 b=ZwIGSsHlRKQ0UQqYwSLRL8d0FIGtTfXTXRApuyz4zeaFiwMIsVkSebZr8vWnGYN0ggQchxG4AYAZodv1QlyQU6W0Bf3aHWtM0YWdYfApcOJGaMIBURPmNPIP1fDl+2wtW/+ESzBz1+o8ZNtybTieBZCdHPx8usHeq+Kt0q4ROpo=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 07:14:20 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 07:14:19 +0000
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
Thread-Index: AQHZgw8JcyZE36zEyEuD5bnsC6neBw==
Date:   Wed, 10 May 2023 07:14:19 +0000
Message-ID: <a4d934c6-ec28-50d0-b9bb-9b11fee7ebb6@microchip.com>
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
 <20230509052757.539274-3-claudiu.beznea@microchip.com>
 <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
 <773d0d90-29c7-b1bd-bd16-898b435eafb6@microchip.com>
 <b3c7db03-6614-47d9-a9e0-a8e51c836d86@linaro.org>
In-Reply-To: <b3c7db03-6614-47d9-a9e0-a8e51c836d86@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM4PR11MB8180:EE_
x-ms-office365-filtering-correlation-id: 4d341eaa-750a-4817-e448-08db51262c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MsOc5lJsQjh4FhMXX/x8TsBRmKfTV6AmlB+U55XGvg3M8M1rkFPtC3VoL95yFtx5G5UMsAjgTJR1DKHJ8he2AautyFMXtdT4oZjC/XRZYE5SaSal1PQlPBNvP+LJ31MjXzBxt3evJQxBKsQ22VJ01j6//evhKf8Ue+gSll7vLqnFZX8XyMr3t2DwGYiOEyg7AUGVMLgdkB5O3Qur2Tzh4yXcwcXD9vU6N0/So3LJMARD7r6aTEmw0fBWHSDpv9JpJCdR74JCwM8jgUqH+L2fyzPRk0aj6d6OmTPv4h/mCrvE7tEHrrGPkGqSc6alKWY7frcvkQFHXzEv2ozFuRPSPvOUwKewM1+k6P+EhHxTZ2rLOTjKB6oVxTX8bBAuKUg7fzLPS5vQdJOtVhXHQhiykYIyp1io94HZeNeDuuubv31BCTthcAhqna62FG6QfLFntwYC6IeWt4nUr+Oj5GiyADzNTL94z0uQKbPQBKdh6K4N105FF9FdD1jeaxOZGmo8solGFrJBiIl/cBKsrSn8DyFqaLr1u2G2WVGZ993necOoFUPrAEF1EuPA4Ah4511/fvkHsfWVBOS4N9D1uqD3zv9csRuN4hJYhI+PUMVKVX0EH4AxmctDcqVX5GngjAXeqA0TxLy1CEZzuNMD7NnHJvZrlLDNvwdfaeFkiNFwFi1Vq4WDRftcuxfSlNs1hvkL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(53546011)(36756003)(31696002)(66476007)(4326008)(66446008)(110136005)(91956017)(54906003)(316002)(76116006)(66946007)(86362001)(66556008)(6486002)(64756008)(478600001)(5660300002)(41300700001)(8936002)(7416002)(8676002)(186003)(38100700002)(122000001)(38070700005)(2906002)(71200400001)(6506007)(6512007)(83380400001)(2616005)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlQ0WkQvRjJLaTN5RjA4NkdYMFlMNitaQjg2ZGM2dEJVUUduRkh3Y0QrVTFL?=
 =?utf-8?B?ck82QkFKb3FQSjFpc2FBVmtPN2ozRzFYMVd2MVBCYi9VT1NWWDczUktrbkh3?=
 =?utf-8?B?Q1p6UFQ1UFBnQlJ1aXRuazVxWXg4R01zQzJOMWpaejlPWTNvQVNMSFhGRWFJ?=
 =?utf-8?B?TjNWK1B4SVh0K0ticWZnZjQ5cm0wUjFTU0NDcW9hNThqY0NpY1FDMVNnREg4?=
 =?utf-8?B?N2hoRVlYdjlTVW5TYmxyUFYvcC9jaTBDem5MbENQeHd6MHFGOElZQlJmMSth?=
 =?utf-8?B?Q1k5c0lBczdtQ1E1YmFhYnQ1bVNGK2IzVnprYTg4bU1UYnBVOHJndmdBeVo0?=
 =?utf-8?B?OHJYd3Fhc0I5d1NxL3NlQ3ZvVlgwZGxDOXJtNVlvWnRlUzlya1RnQkhmVStn?=
 =?utf-8?B?THorWHFxUlQyMXZOS0syR0tYVFlKaGhWWkdQYVlab2ZOMUJUWEpHam0veWVO?=
 =?utf-8?B?L2xNTG1pUjV3bzgvYUJzN3FZckNRV1Rwd3NLZnRPTjd5MTJjbnNDUHJpTXIx?=
 =?utf-8?B?TERJajJCZTBvbytKSWtrejNrbW8rNFZzOXVwWFBEcHVWYk5wcFFnUEhSNU9y?=
 =?utf-8?B?M1UzeXRISG1hVHZCd21VWHUxejRaQ3R2bFRqa3I4MWFvSTZzRlFVTHBpTHpG?=
 =?utf-8?B?a0RCQUw4NHF6VCtTWkdtRm03bVVIbEJjU1JIM2hvVXpGSGh5NG8yVk9zZUNG?=
 =?utf-8?B?WGIwd3Y3UnZMd3ZxUDFweG0xSzlHTWxCemVxS1JaT2FtSHhnbnUyQnhGRmhh?=
 =?utf-8?B?Sm01aGdIOEgxK1BRUjN0MWxra3Z5U2wxTVZELytLYzRYZ294TWR3OVpmNW1W?=
 =?utf-8?B?NzZiR0ZDMWxZYkQ0dk9ndWFDNHpIdHRWcC92SDlVcGdrMnRIc3dPNnoyYml5?=
 =?utf-8?B?TkhoVkZxUExZSlpMSDYwYmp0WTVYTjBoZXg2NkZKT1E1MEtDUDNuWE02dnFi?=
 =?utf-8?B?SklMd1JONmI5SUxqOHgwZmV2aWZhdFM1aitOWG5uTlQrZzdkK2N2WlhTd01v?=
 =?utf-8?B?VXhKNU1YZXhLMnJtb3N3VlNKUGVkeWxNd1A3bGR2YStoWi9kL2MxelgveGx5?=
 =?utf-8?B?cTZmV29sQk9VbGsrUlZwN1NaTDlSSmprVytnRVp4SUNFMmdFcnFOQnJaVzRX?=
 =?utf-8?B?cmt4UVVxUkU4TUZtc3IzWTh3UWttY0x4SU1hUGl2MEFYQ29VN2hEUHdwbWRU?=
 =?utf-8?B?Z1o0dmNPRGoxRjVRVU1jTFNWUnd1aE5RNlBhSFZDSitDS2ptaFNDYTV4R3I4?=
 =?utf-8?B?UWEwWjhNNjQ0UkF0N0FNWitNR0ZlWjY0eTR3ZUVJUldkYWgyNkR2YzYzL3Bj?=
 =?utf-8?B?b2paV1FzK0w4aTNBOTFGenpoNE55NGlKeTlpMVlsbE9MYWY2a0hoYUx5eFRx?=
 =?utf-8?B?YWhqUjFjVWpEa1VjOFZmZkNtOEUxSzk2S1ByOGpxaW13WXJjaFdUdjJ6TUNE?=
 =?utf-8?B?anpIVzF6ZCtXbTdqSjUvVEJEeWQ0Nk9USDBKcU85WERwY2hqU0NzSWpMT3pR?=
 =?utf-8?B?U3k3LzRvRXpYcmFCWTQ4Y1FJOTdCWjdnT3NQR0E4TlV2eFdRMDNOVWxmK1NZ?=
 =?utf-8?B?TFQ0SUdjMlN4T1Vqd0t0MFNvSlFKQXpTemYzSW1PZjU1TjZLZkJuN0x1UVJK?=
 =?utf-8?B?QjRXaG14MnRJSmlMR3ZidHU2ZWpzYkRySGMwRFhJL20xMTNIcjdEYlBhWWpT?=
 =?utf-8?B?aHcrS09SWXNqa01SV3d4cStlQitzVDRSOUpPUTRXQ0NoTVkrQ29aSW5VcUcv?=
 =?utf-8?B?WjJBbzkrZFBjaXFobXY5RmxEWG5UZ0p4SGh4MW9uYzRnMEkyS0p0L0U0d0Iw?=
 =?utf-8?B?N0t0OW9RNWY3N0o0S3lqS05WUVh0ZlJzT3QweGhKYVBMa2VtT1A0Mm9maURJ?=
 =?utf-8?B?alYrb2IvY2phdXV0ejZkTFhmSnBqNWh6ZEVmYkV3Mm5rZVpoUmllSzRnTS9T?=
 =?utf-8?B?RXZJaGt1TlRkc2ozWktlblYwY3NsMFpWSysxYnc2VDk5TjhlOFBWUExRNTBM?=
 =?utf-8?B?KzhIWlZPUFVBV09xTzIrelVVVnMvRjcraVJ0MzF0UVpiTlhFMENIMDd4UVIz?=
 =?utf-8?B?UWt5eUh5NkJLV01tSFBQT0J3MEhadFlzR3o1bDkrVWpkMWhwRmk3WTBNajFK?=
 =?utf-8?B?SC82NXNXVkIyRkEwa3VIRkduNzZnTVRuT2VMWFhCWjVSRTJrcXB4eHZraTRR?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21F60961A04C494EB689F3BAFD40AECC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d341eaa-750a-4817-e448-08db51262c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 07:14:19.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6T8YSq+1cQNI75Yro6XcDaNa97EiO7q3aN8qSYmuFbYy/JSXcfdriMcM70gz4BBP/xmfikLpOTm0WMhYzx+lgvsa7sC/5y6VpfHu8dICTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDUuMjAyMyAxMDowNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMC8wNS8yMDIzIDA5OjAwLCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMDkuMDUuMjAyMyAwOToy
NSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDA5LzA1LzIwMjMgMDc6MjcsIENsYXVkaXUgQmV6bmVh
IHdyb3RlOg0KPj4+PiBDb252ZXJ0IEF0bWVsIFBNQyBkb2N1bWVudGF0aW9uIHRvIHlhbWwuIEFs
b25nIHdpdGggaXQgY2xvY2sgbmFtZXMNCj4+Pj4gd2VyZSBhZGFwdGVkIGFjY29yZGluZyB0byB0
aGUgY3VycmVudCBhdmFpbGFibGUgZGV2aWNlIHRyZWVzIGFzDQo+Pj4+IGRpZmZlcmVudCBjb250
cm9sbGVyIHZlcnNpb25zIGFjY2VwdCBkaWZmZXJlbnQgY2xvY2tzIChzb21lIG9mIHRoZW0NCj4+
Pj4gaGF2ZSAzIGNsb2NrcyBhcyBpbnB1dCwgc29tZSBoYXMgMiBjbG9ja3MgYXMgaW5wdXRzIGFu
ZCBzb21lIHdpdGggMg0KPj4+PiBpbnB1dCBjbG9ja3MgdXNlcyBkaWZmZXJlbnQgY2xvY2sgbmFt
ZXMpLg0KPj4+Pg0KPj4+DQo+Pj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBUaGVyZSBpcyBz
b21ldGhpbmcgdG8gZGlzY3Vzcy9pbXByb3ZlLg0KPj4+DQo+Pj4+ICt0aXRsZTogQXRtZWwgUG93
ZXIgTWFuYWdlbWVudCBDb250cm9sbGVyIChQTUMpDQo+Pj4+ICsNCj4+Pj4gK21haW50YWluZXJz
Og0KPj4+PiArICAtIENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KPj4+PiArDQo+Pj4+ICtkZXNjcmlwdGlvbjoNCj4+Pj4gKyAgVGhlIHBvd2VyIG1hbmFnZW1l
bnQgY29udHJvbGxlciBvcHRpbWl6ZXMgcG93ZXIgY29uc3VtcHRpb24gYnkgY29udHJvbGxpbmcg
YWxsDQo+Pj4+ICsgIHN5c3RlbSBhbmQgdXNlciBwZXJpcGhlcmFsIGNsb2Nrcy4gVGhlIFBNQyBl
bmFibGVzL2Rpc2FibGVzIHRoZSBjbG9jayBpbnB1dHMNCj4+Pj4gKyAgdG8gbWFueSBvZiB0aGUg
cGVyaXBoZXJhbHMgYW5kIHRvIHRoZSBwcm9jZXNzb3IuDQo+Pj4+ICsNCj4+Pj4gK3Byb3BlcnRp
ZXM6DQo+Pj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4+ICsgICAgb25lT2Y6DQo+Pj4+ICsgICAgICAt
IGl0ZW1zOg0KPj4+PiArICAgICAgICAgIC0gZW51bToNCj4+Pj4gKyAgICAgICAgICAgICAgLSBh
dG1lbCxhdDkxc2FtOWcxNS1wbWMNCj4+Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2Ft
OWcyMC1wbWMNCj4+Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWcyNS1wbWMNCj4+
Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWczNS1wbWMNCj4+Pj4gKyAgICAgICAg
ICAgICAgLSBhdG1lbCxhdDkxc2FtOXgyNS1wbWMNCj4+Pj4gKyAgICAgICAgICAgICAgLSBhdG1l
bCxhdDkxc2FtOXgzNS1wbWMNCj4+Pj4gKyAgICAgICAgICAtIGVudW06DQo+Pj4+ICsgICAgICAg
ICAgICAgIC0gYXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+Pj4+ICsgICAgICAgICAgICAgIC0gYXRt
ZWwsYXQ5MXNhbTl4NS1wbWMNCj4+Pg0KPj4+IEkgbWlzc2VkIGl0IGxhc3QgdGltZSAtIHdoeSB5
b3UgaGF2ZSB0d28gZW51bXM/IFdlIG5ldmVyIHRhbGtlZCBhYm91dA0KPj4+IHRoaXMuIEl0J3Mg
dXN1YWxseSB3cm9uZy4uLiBhcmUgeW91IHN1cmUgdGhpcyBpcyByZWFsIGhhcmR3YXJlOg0KPj4+
IGF0bWVsLGF0OTFzYW05ZzIwLXBtYywgYXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+Pj4gPw0KPj4N
Cj4+IEkgaGF2ZSAyIGVudW1zIGJlY2F1c2UgdGhlcmUgYXJlIHNvbWUgaGFyZHdhcmUgY292ZXJl
ZCBieToNCj4+ICJ2ZW5kb3ItbmFtZSxoYXJkd2FyZS12MS1wbWMiLCAic3lzY29uIiBhbmQgc29t
ZSBjb3ZlcmVkIGJ5Og0KPj4gInZlbmRvci1uYW1lLGhhcmR3YXJlLXYyLXBtYyIsICJ2ZW5kb3It
bmFtZSxoYXJkd2FyZS12MS1wbWMiLCAic3lzY29uIi4NCj4gDQo+IFRoZSBlbnVtIGRvZXMgbm90
IHNheSB0aGlzLiBBdCBhbGwuDQo+IA0KPiBTbyBhZ2FpbiwgYW5zd2VyLCBkbyBub3QgaWdub3Jl
Og0KPiBpcyB0aGlzIHZhbGlkIHNldHVwOg0KPiBhdG1lbCxhdDkxc2FtOWcyMC1wbWMsIGF0bWVs
LGF0OTFzYW05MjYwLXBtYw0KPiA/DQoNCk5vdCB3L28gc3lzY29uLiBUaGlzIGlzIHZhbGlkOg0K
DQpjb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05ZzIwLXBtYyIsICJhdG1lbCxhdDkxc2FtOTI2
MC1wbWMiLCAic3lzY29uIjsNCg0KYXZhaWxhYmxlIGluIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFz
YW05ZzIwLmR0c2kgKzQ1DQoNCj4gDQo+Pg0KPj4gTWFueSBBVDkxIGRldmljZSB0cmVlcyBjb21w
YXRpYmxlcyB3ZXJlIHdyaXR0ZW4gaW4gdGhpcyB3YXkuIFRodXMgd2hlbiBuZXcNCj4+IHZlcnNp
b25zIG9mIHRoZSBzYW1lIElQIGhhcyBiZWVuIGludHJvZHVjZWQgdGhlIGRyaXZlcnMgd2VyZSBu
b3QNCj4+IG5lY2Vzc2FyaWx5IHVwZGF0ZWQgYnV0IHRoZSBjb21wYXRpYmxlcyBpbiBkZXZpY2Ug
dHJlZXMgd2VyZSB1cGRhdGVkIGUuZy4NCj4+IHdpdGggInZlbmRvci1uYW1lLGhhcmR3YXJlLXYy
LXBtYyIgKHRoZSBmdWxsIGNvbXBhdGlibGUgYmVjb21pbmcNCj4+ICJ2ZW5kb3ItbmFtZSxoYXJk
d2FyZS12Mi1wbWMiLCAidmVuZG9yLW5hbWUsaGFyZHdhcmUtdjEtcG1jIiwgInN5c2NvbiIpIGFu
ZA0KPj4gbGV0IHRoZSBkcml2ZXJzIGZhbGwgYmFjayB0byBhbHJlYWR5IGluIGRyaXZlciBzdXBw
b3J0ZWQgY29tcGF0aWJsZQ0KPj4gInZlbmRvci1uYW1lLGhhcmR3YXJlLXYxLXBtYyIsICJzeXNj
b24iLiBJbiBnZW5lcmFsIHYyIGNvbWVzIHdpdGggbmV3DQo+PiBmZWF0dXJlcyBpbiBhZGRpdGlv
biB0byB2MS4NCj4+DQo+PiBUaGF0IHdheSB0aGV5IEFUOTEgZW5zdXJlcyB0aGUgQUJJIHByb3Bl
cnRpZXMgb2YgRFQgYW5kIHRodXMgd2hlbiB0aGUNCj4+IGRyaXZlcnMgd2VyZSBmaW5hbGx5IHVw
ZGF0ZWQgd2l0aCB0aGUgbmV3IGZlYXR1cmVzIG9mIHRoZQ0KPj4gInZlbmRvci1uYW1lLGhhcmR3
YXJlLXYyLXBtYyIgRFQgcmVtYWluZWQgaW4gcGxhY2UuDQo+Pg0KPj4gUGxlYXNlIGxldCBtZSBr
bm93IGlmIHRoZXNlIGNvdWxkIGJlIGhhbmRsZWQgYmV0dGVyIGluIFlBTUwuDQo+IA0KPiANCj4g
ZW51bSArIGNvbnN0ICsgc3lzY29uLCBsaWtlIGV2ZXJ5IGJpbmRpbmcgdGhhdCB0eXBlIGRvZXMg
aW4gYWxsDQo+IGJpbmRpbmdzLiBEb24ndCBpbnZlbnQgc29tZSBuZXcgc3ludGF4Lg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==
