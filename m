Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D009707C21
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjERIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjERIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:31:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388C2E4F;
        Thu, 18 May 2023 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684398713; x=1715934713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yfbDmT5dF9ntgt8UhdzbjMuNEQvZlsxOduCUMttewrA=;
  b=m1FemBw6QVmYTxv7vjgxEm5hSGKqAO2v8cSYJLVEIsEk61hq8APqfYnQ
   W+uSxswCGW7LW93KqfffybfpfNpv/wN48EnhlHkyhblEDBsgW5t8ljgWu
   mSwVMPyZEXl6rVKdaNWdPCU6HNc9M/wzjfe3B4r3b3EHCMyIQNiM7bbRi
   1m3rbgsEPsSTRMlUjbHtPAfi21t2bMQrp4F1+Iafq26SVd2U333OzUg5P
   6uNpubhENBgBxGLZuBlJG9V0MZNF2MXnepM9Od0ZibKwRrv0HNZ4x479j
   i61nOzFAINxcVlgLas8SYzlorfmXfuiDO3ZPk1njgdlhleFTyiW2AmyEz
   A==;
X-IronPort-AV: E=Sophos;i="5.99,284,1677567600"; 
   d="scan'208";a="152714509"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2023 01:31:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 01:31:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 18 May 2023 01:31:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZTStKym1F/LAdU74S89aMdYhsB7aWgZ3iFQxgjebTqqksPlRnnwYn4B3jl5grEGoBjHezp0A9spZlarYRF/+vuf0tFJp6dc5PJKGha3hkG3JPbOqQVv5CgQ9WBr12A9hcGkwIOl62Irt7gnHf40gZ3PZk9MPOmTcZWa14N7JrTsrgK16QUX4HULICoMLvlotJPdwUPCCv5y92CyXd56L0w80MUO+5B1tJ/9vkvtB1090SbakKCQTNIFieirkzCeU1ONh/O8gQyNqJW7vi868G3ntWo+NY09j5YRgVu6w9v/TFOwREcR+2uErVS/Mqhpp4dQ+sy7yb0ABVVzufUmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfbDmT5dF9ntgt8UhdzbjMuNEQvZlsxOduCUMttewrA=;
 b=YEy3kbo9QcPtfbP3ExDgAre3Z7dQw8ReWBSZjzdFUb0IxJyqdD+iTWIEX1NOfIZAdzsRhWe6kxaSWGVKbvXJ621O/q+V2hz2Wi0CL8PTxM1zLetGjeDsFqItnCK4w2v2QngHNvJIbTxoqRWT/ERWqUdd3rB3gcp+gU3Xp4oLFYjqL61ysnVcrt7P9D+ljRjw7y+yypB9s9jH2TBBEwXnJNgpQL22oAGMfu5jA2EGGp6eFe7jsNbCubziNvByHeW5oCIjSZLJNYpSO4ujVooPViFbtZCAZRfK5EPEnR9ugk9tiQN5a1MSwOWDLFBcmytfQw9PTR57d/33ybhh0chirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfbDmT5dF9ntgt8UhdzbjMuNEQvZlsxOduCUMttewrA=;
 b=e0uUFpL23g8u0cnwN4/9pttr4Sv5yJwWxrc9ZluwJYCeaYT+keg0RZ2U5PFy1AdgqEhrfmYBoQus/NgwN45yoiP5I5Zwyerw6LeBbrYMb/SjvHBoRNRA5j0v88wOfnGaLZSNT2hzXiACHNffriYA4uou0wSRaoYuBAq1yMphnpA=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM4PR11MB6453.namprd11.prod.outlook.com (2603:10b6:8:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 08:31:48 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 08:31:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] dt-bindings: clocks: at91sam9x5-sckc: convert to
 yaml
Thread-Topic: [PATCH v5 5/5] dt-bindings: clocks: at91sam9x5-sckc: convert to
 yaml
Thread-Index: AQHZiWMvRXpOwbLQK06FvdZc2/L/LQ==
Date:   Thu, 18 May 2023 08:31:48 +0000
Message-ID: <79b77cb4-1e18-3c19-15dd-66951541abdf@microchip.com>
References: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
 <20230517094119.2894220-6-claudiu.beznea@microchip.com>
 <20230517141508.evb6jg5bcpjzhqve@krzk-bin>
In-Reply-To: <20230517141508.evb6jg5bcpjzhqve@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM4PR11MB6453:EE_
x-ms-office365-filtering-correlation-id: e0b08402-da3e-42a3-4f16-08db577a5257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYmJK6dBTb0RhOfHxX8N6KoqLOhR6v+zU7LyOsO0OhpWrkz9+uK3ia1DJul9EOMOJEB3KEevYSYlVsNpHX1PUlfqVTMe+9R4tyO0qXOxPeQfPk/KiW2v00CTJcPT2PesWcnS9NQVUUXiNRJSG1J+vrYsVwbwg1tbXPx+DQvQ80JH6rkx9Oij3g45HYq8/irAUOe4SJiPHeLEaNeTgUdjX9w9ILWu+v3EiqqC0x5a9eceYDANe1dBnMQE4l8rruCvHEmgKk2r4lnWh7DGGCIh76hYErFHS/cbFPn6a1T5Dwd+JFGJnx3/qPKhqDOVGSBqhr8K62MA7GETy/QxLMHVodf+f/h2Bdfbsyj5ARecS/6zWHTfQFTcs5aCB2PzLqpa+q3lIX8gVYuvj0Is71S0NMyU7Bf6z5ctGVXheAQfVn7w/qr5woVOgsQdfyZ5ggB2AwyYL9EUDxwsUGm8qVNH8d0MeoWmCl4QCEw+r2roO68Cb4VHO3/EK2QHfZrjVkRIXDlXyq3yKHMYOqIh2R74dEJq4SDjod9wwCI+uqKjep720SyLS3cJpt7B0zewPA19dtF6kmLjCTtLjQlRwiQ63FyMu8adyp/geYRYCDYVNoO93jPjQF0D1EyjYG0SN9J8TZ1kye0eq3MvgCK6L7mDA3IOS3bRFbI4ejnofT7aEmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(91956017)(76116006)(66946007)(4326008)(316002)(6916009)(64756008)(66446008)(66476007)(66556008)(2906002)(2616005)(86362001)(31696002)(7416002)(8676002)(8936002)(6512007)(6506007)(186003)(5660300002)(26005)(53546011)(36756003)(122000001)(83380400001)(38070700005)(38100700002)(41300700001)(71200400001)(54906003)(31686004)(6486002)(966005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2crWEJqSTJnWE1VS1Q2ZHNOT2VrVmljL3ZEQ2U4YVJwVnJyUW1nOUVVejRR?=
 =?utf-8?B?cm8xVFlCSkFVME4zVzlSRDJ1YlQ0aHJ0dWZqeldLcjNRRWYzT203U05Pczcz?=
 =?utf-8?B?cGoyeUlRVFlGdXhkYklyNnF5WFE2bTZza0FtQy9Fcm9zN0plazRFYTNwU2pz?=
 =?utf-8?B?RkxHWFRaTEoybnVnN28wU1kxeWNkbEZpNzV6Q0NBVi8rci8vYWRaUVJVcDlW?=
 =?utf-8?B?YWtWdnhDMHd2QXZoQnUyWEkrRWNaNEZZMndLTUZqcWNoRytVM2RtUHlkcVd2?=
 =?utf-8?B?eUJ5ZXVQTW9TMEtOM3dWZ0krcDU0R0JVaUxqVmRWWHdsWk1uTFNZcDZIQnM0?=
 =?utf-8?B?aXVQNEVlVUxId3pKN2VlcldrbDFjTGVyYlZMTk03RUVTSXdab1ozNFNEUGZS?=
 =?utf-8?B?MVhWQnNHV2lhL1k5WnlocHZ0bXRkMlp3Qk16UnRPa3N4L0tOUXhPWlY1MHJR?=
 =?utf-8?B?UnFjWlIxbVh4em9TdWQxYnpmWC9zbFMraEQxSmZ0MkZTdStkRElKbTNTcERP?=
 =?utf-8?B?Y0RMbG5qWFhXL0N6eXJIaldsK3NvcGM3c25XVFNVQzBzMGZkNWRvZUZmUGEv?=
 =?utf-8?B?MGZVMXkrQWVWeTBjSW5vR08zam95cktGQXg0OGl5WXFHYTIvY0NqQ0xOdGxy?=
 =?utf-8?B?ZGcvS2lIY2NFVlJTWUoyZW1tNmJiZ1UvN2tiTGU4U1MyTGdVK0crYkZlM3Nq?=
 =?utf-8?B?dTJzUFpkRklQcjV3MkIwSHR3WUFzRnF6bXVLc1dwbFF1ZnFyeVBCS1F6WGdo?=
 =?utf-8?B?bFZSRFJjN2gwdVkzeVN6eE00dytlL0g5MXhneXNET3dLellvcFVrNEdmL25r?=
 =?utf-8?B?SWowTncxa3IwcXVhR01pSWZoL0ZCdkQxck1WalhQNkxYSVl1cnlvZzdkRVBa?=
 =?utf-8?B?QUpMcWxqc2tGMmt2eE01L3o2K3A0eUt1YUovSVNVVjhmMlgyMWdWWjRNODJ0?=
 =?utf-8?B?N1NmUDdQMFk0YUR4czFjVTdLbVFsdis1L3ZUSmRpNUxxb0U0emtldFlHbHgy?=
 =?utf-8?B?d3QyTlBJb2Z1Z3BvQ0pBRkxvVFhSQ3l6NGZLL1lPWWc0bWFYWTUxSFNWOW5N?=
 =?utf-8?B?WlBJNDVHQThaTC9WWVMzWmFIU2NaWUlMRkRLa2FVdWVYbjNsK2Z5UHdaVEd1?=
 =?utf-8?B?NkR0aTZQSzY5Yk9FaHRDdW9HRWp5VURMSHNrVnh6MUt2VXNTT0l3dnRGVFhk?=
 =?utf-8?B?T2pLMjdmM08yaXo2QURUeC94SzZTQVpjcktaZ016cUNnVllJcWRDME5BL29C?=
 =?utf-8?B?WTh2dDF2U01IU3J6cDRmazRLWldJRG1mMVQvUVY3NWowemh5RlVwMnU0QzdX?=
 =?utf-8?B?RldlamExN2UvZW1aSXhnYk5sb3ZqcjBTZnU3YmY3aHh1Z2cxVnk4K3pJK3JH?=
 =?utf-8?B?MmovajJBb2NacDlUU2QxR2JzT0VjWmV0TjFIeWZGdHJWTllLeGxwZ0FtNTZH?=
 =?utf-8?B?NnVEUE9sakRlSmw0QVNQc21yc0dOVG0yOUJwUVpBMUZYN1ZuN3NUMGtYMGIz?=
 =?utf-8?B?andwa2RMM05nY3BpVHBaODIrMnNON29oTXpVVnMxU1BJK1Y3bytvK0tUbER6?=
 =?utf-8?B?Q3RycFhUTklia0RaVDVpREVDaWg2SkoxdTVQenBNVHRmT2hOVkRTbWxGWDVt?=
 =?utf-8?B?YWhwbkdzU1dlN25tNjYyb0hTWUpTcXhQUGp3U0s2a3BtME44S0RkdVRvVmdw?=
 =?utf-8?B?bFZ1Tm9OYlgwR251eitETlI5TjdkWGF4N1MwS283MDJSRHJTM1B0VjJML1N0?=
 =?utf-8?B?SzlLODZRYXNtbW16c0MrbGVTQ08wT096d2ZnYlFlakkxMVg2bW5JMnlUZDhV?=
 =?utf-8?B?b0hUZHZpSjdZS2tWU1JHQ094Mm80SUNEODRGNjhDc0h4blBtaDUxbkFjZk9y?=
 =?utf-8?B?ZHRJbHlncmltOWp4U3AyMDJZL20yZHdmTnduQXk5QjdKYjZWUkRyRm9Qek5u?=
 =?utf-8?B?RW1WclZGcGZDV1djVHE1c0FCOU1STFNMdFBIVEptQnhPNjdQcG8yWFNYUzAz?=
 =?utf-8?B?QXJIYThVckxVd3JWZkUwR0RJeDNocmRIT2dYeVplek5BU084NWtRczdyQlpM?=
 =?utf-8?B?VVNzOXhWT05kclRWV2JhKzVpQXI5TGRDYVc4M0pXVzArSWVVUW03OVFiT2I4?=
 =?utf-8?B?V1VreEdGSkM5MWNPSVlmN1BlKzFqUGk3cU4xbVhKOC8rQmNNMDMxbnJQSldv?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9224242F47629746AC2ED7E901C76D17@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b08402-da3e-42a3-4f16-08db577a5257
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 08:31:48.2127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVc2SUYsijeuOQdIC4etuML977d41C72kUps4g7C6Q41tXHc1m49lwuyTANPIxKfnwxxYsWqKe505MzOBKSIbXYSZSOKJmzrWfmaW5GlnCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6453
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDUuMjAyMyAxNzoxNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIDE3IE1heSAyMDIzIDEy
OjQxOjE5ICswMzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IENvbnZlcnQgQXRtZWwgc2xv
dyBjbG9jayBjb250cm9sbGVyIGRvY3VtZW50YXRpb24gdG8geWFtbC4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+
IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxp
bmFyby5vcmc+DQo+PiAtLS0NCj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkx
LWNsb2NrLnR4dCAgfCAzMCAtLS0tLS0tLQ0KPj4gIC4uLi9iaW5kaW5ncy9jbG9jay9hdG1lbCxh
dDkxc2FtOXg1LXNja2MueWFtbCB8IDcwICsrKysrKysrKysrKysrKysrKysNCj4+ICAyIGZpbGVz
IGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPj4gIGRlbGV0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXQ5MS1j
bG9jay50eHQNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Nsb2NrL2F0bWVsLGF0OTFzYW05eDUtc2NrYy55YW1sDQo+Pg0KPiANCj4gUnVu
bmluZyAnbWFrZSBkdGJzX2NoZWNrJyB3aXRoIHRoZSBzY2hlbWEgaW4gdGhpcyBwYXRjaCBnaXZl
cyB0aGUNCj4gZm9sbG93aW5nIHdhcm5pbmdzLiBDb25zaWRlciBpZiB0aGV5IGFyZSBleHBlY3Rl
ZCBvciB0aGUgc2NoZW1hIGlzDQo+IGluY29ycmVjdC4gVGhlc2UgbWF5IG5vdCBiZSBuZXcgd2Fy
bmluZ3MuDQo+IA0KPiBOb3RlIHRoYXQgaXQgaXMgbm90IHlldCBhIHJlcXVpcmVtZW50IHRvIGhh
dmUgMCB3YXJuaW5ncyBmb3IgZHRic19jaGVjay4NCj4gVGhpcyB3aWxsIGNoYW5nZSBpbiB0aGUg
ZnV0dXJlLg0KPiANCj4gRnVsbCBsb2cgaXMgYXZhaWxhYmxlIGhlcmU6IGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcGF0Y2gvMTc4MjU4Ng0KPiANCj4gDQo+IHNja2NAZmZmZmZlNTA6ICcj
Y2xvY2stY2VsbHMnIGlzIGEgcmVxdWlyZWQgcHJvcGVydHkNCj4gICAgICAgICBhcmNoL2FybS9i
b290L2R0cy9hdDkxc2FtOW4xMmVrLmR0Yg0KPiANCj4gc2NrY0BmZmZmZmU1MDogJ2Nsb2Nrcycg
aXMgYSByZXF1aXJlZCBwcm9wZXJ0eQ0KPiAgICAgICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFz
YW05bjEyZWsuZHRiDQo+IA0KPiBzY2tjQGZmZmZmZTUwOiAnc2xjaycsICdzbG93X29zYycsICdz
bG93X3JjX29zYycgZG8gbm90IG1hdGNoIGFueSBvZiB0aGUgcmVnZXhlczogJ3BpbmN0cmwtWzAt
OV0rJw0KPiAgICAgICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05bjEyZWsuZHRiDQoNCklz
IGl0IHBvc3NpYmxlIHRoYXQgdGhpcyBoYXMgYmVlbiBjaGVja2VkIG9uIGEgd3JvbmcgYmFzZT8g
SSdtIGFza2luZyB0aGlzDQpiZWNhdXNlOg0KLSBwYXRjaCAzLzUgaW4gdGhpcyBzZXJpZXMgdXNl
cyBwcm9wZXIgYmluZGluZ3MgZm9yIHNsb3cgY2xvY2sgY29udHJvbGxlcg0KICBvbiBhdDkxc2Ft
OW4xMi5kdHNpICh3aGljaCBpbmNsdWRlcyAjY2xvY2stY2VsbHMgYW5kIGNsb2NrcyBiaW5kaW5n
cyBhbmQNCiAgcmVtb3ZlcyBzbGNrLCBzbG93X29zYywgc2xvd19yY19vc2MpDQotIHBhdGNoIDQv
NSBpbiB0aGlzIHNlcmllcyBkb2VzIHMvc2NrY0AvY2xvY2stY29udHJvbGxlckAvIGluIGFsbCBB
VDkxDQogIGRldmljZSB0cmVlcy4NCg0KTW9yZW92ZXIsIEkndmUgcmUtY2hlY2tlZCBhbGwgdGhl
IGluZGl2aWR1YWwgZHRzaSBmaWxlcyB0aGF0IGRlc2NyaWJlcyBhDQpzbG93IGNsb2NrIGNvbnRy
b2xsZXIgYW5kIGFsbCBkZXNjcmlwdGlvbnMgaGFzIHRoZSAiI2Nsb2NrLWNlbGxzIiwgImNsb2Nr
cyINCnByb3BlcnR5IGF2YWlsYWJsZSBhbmQgbm8gc2xjaywgc2xvd19vc2MsIHNsb3dfcmNfb3Nj
IGFzIGNoaWxkcyBvZg0Kc2NrY0BmZmZmZmU1MC4NCg0KSWYgbm90LCBjb3VsZCB5b3UgcGxlYXNl
IGxldCBtZSBrbm93IHlvdXIgY2hlY2tlciBjb21tYW5kPw0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1
DQo=
