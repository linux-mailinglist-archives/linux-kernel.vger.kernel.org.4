Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F665BD8D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjACKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjACKAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:00:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C1EE18;
        Tue,  3 Jan 2023 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672740022; x=1704276022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U0qSU3rYC6KoIIjjaxnc3BsHpbWJ2ewcA5zx5B+ulY4=;
  b=dT0OnuLd+aD0zPNh+neP6XmQMQL1/ll/TDZrJugn0PW1igjxpym3/KPL
   NrlKyC2vAfCVQ5kWHN6g7scCxH5H5gD3GjlbO2hOv3SzKNm1QfF9qNJO8
   WGycXOvHS8Rjunac+rhYtxZ+jYFnRRuSLjcoZy5Y4Y8W3mep+v3gxCu+j
   cZGj5l7BK8Xd6k+BpJUrhOgWTo7IZP3561emWJgjExjX4JR+DuHagrsHs
   M8yrDy49TTJZeeSGD8WwpFPp/vh0a5wAToi3fPKxHEOMQsSIvANqDi451
   bbn0KWUUZfad51VVLH/MvmraWknPnuJvgAE3ZNpF+P0y/yJD++O9Ro1pM
   w==;
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="206176457"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2023 03:00:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 03:00:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 03:00:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8kEQS1RbySTLhxHsgoYrd1zb2Z+kyOGN7mHQOznNum5FzRlfRl9PeoIFjcgriCcu5jDMAvbcz5uYK5bbrQ9GbHjjbtfksy1SsxVB3z4olyz9PBI1XKcBZ1B2LAqvieLngTs2FsXw5XJxMGRrkCmVu6P3hSHqg4S3Ef2p1T1r2BxrCgFfBhpzDvWOs/bahOj2FiL2Ab46fTavSd9NwaJ9L0ZqL6ayxg99XBN6xSSYh5WDCLRo4ELbe1weF5Rl7pCRQ0ZWBEeKftQfBDGyVLrHD1ZNpAWmyddcca488zQKy/CskUXaGfxY0U/EJ77k7nF0FNb2b+B90U1fXBImiYpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0qSU3rYC6KoIIjjaxnc3BsHpbWJ2ewcA5zx5B+ulY4=;
 b=Suyz0VB8Updgk8cP5P2b1F8WWARN6kzVjr+jgCEo8ZXQXjIJ3/+TEmYveDC8tfttU5RXbFjJS2hCMn5XheI5x4xBu50UKCmF2gkV4lCJVAn0HWbwCr3gKOuCHj3zTYn3ow0t9tia++oeL/s2ABMj1XryxFKXplRskDoEsmuxSq3Ksbqvfd7TVgS9koj4OU0VzqyL3vqh1p6S01Z63ye0N53YFl4pOQWNWMJyWWfNrri3YgUvmZUwOwYGGwux0hr6NZjd2raUBqAZjGEYc+2aJAJ2vYUW523Zzl5oNq2kdzgyCUldTagL/LVdFR9BQJ4fvwTbDRM1VZJWhHFwUdXxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0qSU3rYC6KoIIjjaxnc3BsHpbWJ2ewcA5zx5B+ulY4=;
 b=P3hlzyn0zdtV1dYQ2YdNPfxt2vXBq+Cm+tK3IkGPAnTVSyY4Rbm15ePkQPbs+lYdAF8U5hTCgV7Xt6h/KPfgg6LFKBMsAc4Qw+sLTz2cSEFL6udNBXM3IfcozBIvpr02GoETkh7Yr9J2ef0rlgVJMgB5Xetv3Le+1l47T/Y/M0U=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 10:00:17 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 10:00:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Thread-Topic: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Thread-Index: AQHZH1ouqVwQMepaQ02OBGgD3WEPpg==
Date:   Tue, 3 Jan 2023 10:00:17 +0000
Message-ID: <2f9793fb-8840-fd3c-8af1-42c6c11ed475@microchip.com>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-3-claudiu.beznea@microchip.com>
In-Reply-To: <20221208114515.35179-3-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH0PR11MB4999:EE_
x-ms-office365-filtering-correlation-id: fb883511-2342-4e68-5964-08daed71510d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNBBAWKXdvHybpbyfx1qgza4/Tx4hX2O9+lRLMa2h+FrW6gcgXoxkZUz2D8uDLJOqFxKpJbakk1k0tNiwy/ZmqkwNFwoRxOIxzVVHNZnMR/2/cO2HgYA3n+XP9qQ2FN23uJhQoKX7TuEBIWS8QmG1zNMK6nds+NE7YIc3zJkVHY53r+jnnCYaGFLMsPDCtveHrkEJfh/CocCtLlvlQv7y2Zt6BuJUfjnJuK+YN9qKhwHozMwVHq4hEsuiy5XieBJMmEQVFG35GswbORm3oKnzfk75MKrbq6jqoKZQG3hdLPA6i+4FBcQAs+/zAb08/9nXUzMuC8RdoIWSXRcFI+uGxgROE4ni42LIM5mZO0icNc4cv2u/6E1ZJvR2CD+YxiV8U11cj7enCesErZ9hsmpapXh4by8h81XPJdztijbq0dtzXeqJBD9+K1lpLmJqpqvVATvGJ3iYutHig8kV+ekrBoczrY5RNc75r6TngxXlmmVLARaEYZiD7nORcy+oE5wMlETr9eeFZCL6UxB/GmzT+d50ssF+R3e98yejT97FPkVPxy0dmY3upbVW8NCRnYeTBXl3Xp8TProsdEleuBxfVhw//D1okgjw3+UYbJ8rrgTEn9vPVEccwucnY8Pdg+EhYP0NfjbjzE7yZ5kQj0QR/yimuoV9w7gqIy+Bxq8t3aeYgXviprHKi87yPSL2N3DUPIAnc5ZRfC4aG9zfs0IBqhP88pXVJqKUBVlk/FpId5L/7oxIDJkZtmQIv52Mdto3Z2hyvNY223kJ6FyGS57E5XqJQSKEUN+Lvx6TukhHNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(83380400001)(6512007)(26005)(53546011)(6506007)(31696002)(38070700005)(86362001)(36756003)(38100700002)(122000001)(2616005)(186003)(478600001)(41300700001)(8676002)(4326008)(2906002)(5660300002)(8936002)(6486002)(66556008)(71200400001)(31686004)(66946007)(76116006)(66476007)(54906003)(316002)(91956017)(66446008)(64756008)(110136005)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW9HZjlqdUJBUUNqZHdwdDZZT1YzUDN2MU1nYnhJOXlIYXlSOG5tUllFSVZF?=
 =?utf-8?B?cU9HenJYckQ2cjk5NUJzZ3hJMWVJbVRhVFVhTmRGSm1WTEZWU2tmUWR6dU1j?=
 =?utf-8?B?N3lCcjRzZ2tlVGdnMTY0Q25HOE5aeWg0RFZTakVZcmJYOTNYcDhDbk9xUVE0?=
 =?utf-8?B?QU5xKzJqYWkrL0NIbnZWNG40bnBIWFdMUHV1YUtkOGo5U1NKMUpjREk1bmRF?=
 =?utf-8?B?V0pSQys0L0FoenkwVHVSam9HUmNOcVpmVWFMc3FzMlA5dUp6M2llQnRaZTYv?=
 =?utf-8?B?Slc2UzQzTEE0UnJhbFJqMGdyVW1oODZVbFdtNHR1alNuNGpsSlZ5cWpWMDdE?=
 =?utf-8?B?WWFqSHczdDJZeUoxM3FSdDZZeEl0VDRiOC9UdmRvRHorS0tkMGZBMGdybUVO?=
 =?utf-8?B?YnVhU2RWMXJNNHJ4SFNVUFYwRFo2M2FPc0MzOCtncVRtZ3RDaHVseVlTZUVh?=
 =?utf-8?B?RDhrVDc0Mm53c3BFWm1XRXc5MzZMWFpTUDRnb0hWc1BiU2t5bzhUQXhjN0gv?=
 =?utf-8?B?Q0xDejNtNjRybGd5MXB0ZVhuUDhsOWRJbWhiT2JTaDNvT25nd3hremZoOXYw?=
 =?utf-8?B?UmdTV3V4NXJZRGZiTTZwK0d0ajVPYlo4UTB5ZE8zWU0yS0JSRFl6Z2FSMFJS?=
 =?utf-8?B?a3hNKzhlTnloalVNTjBMVDl5eW1LUURoaGdzWkMzZEdHYXM2Mkk4TWdMSnR6?=
 =?utf-8?B?OHdDUEdsY0IyNnlmTm5sc1Q3N29yenhpMXdTMWNNdURGUmp5NlBzbFJvQ0gv?=
 =?utf-8?B?eFV5elkzTnA3M3JUNEpWaEd4bkxCeGZvWGFJS2xPcWNEanhVWUh0diswTDZB?=
 =?utf-8?B?WFJCNWhqVzJRdkpKQzU0U3FJYTZodXErdHd5R0VsWFltWXBJenFHN2QyOEFW?=
 =?utf-8?B?eUEzQUZtYWltUFBBL1JJTVZZVUJ5ZE5IM1Bsd1ltME1PeU1JZWlWN0RWM0Nl?=
 =?utf-8?B?S1p1TFFYcTZwbzd2WWwwdURNVVgxMFQwRXZqcWxSMEhLVkF4WHF6WjFtYlEy?=
 =?utf-8?B?c2FpWjMxSmRiTUNtK3NiU3JTYk5yNzMzVmFSVXpuMnF5bVZJYlRTK3p4Wkky?=
 =?utf-8?B?TmIvcGc2WnV3Vnd3SmpxK09uSHlxdTAvVmt4S2ttbUJmdG04UlpXbnhnd0lv?=
 =?utf-8?B?cTJUWG82OHlkQ3Bjdm4yOFlJOGxuUU41RWlyZm5tbkp1cnUvVFpnT2JGMVEz?=
 =?utf-8?B?Yk92aHdaODh5MUJVNU5wUnNjSWRmVzZ2UW1Id1RhZkMxNDROOUxJcjhCaVNt?=
 =?utf-8?B?b0VGeUtjNXJzSkhUUXZrMUpBRWN5T2NYWnRCblFZN2dxMXVBMFZMMnBhTGIz?=
 =?utf-8?B?NHVwZ2Z5dFhnOXJlUS8xdS9USW02Q0taUlZYWlhqWVc3MmdGTXRXMVFvNXZv?=
 =?utf-8?B?NU4zR2Rjbk5SRXdNL1JLakIwaWJzbEorRjhPejFCSmlGNnVjOVQzRHJ3c3dY?=
 =?utf-8?B?QnA0Q3pzeFVBNXhyRTd4OUYxcEZvYzJmWUZKNlRGbnFNSTVkYUxUTVdjS0pp?=
 =?utf-8?B?YWVOUUw5ZktZc216NmkyUjgvSXRZNTViQ0h5ME1Cd0JLSXladVZ2cXJGRld3?=
 =?utf-8?B?aHJxYVFDZXBZOTU1OTg4SGswL2hKRlYxZUJ1QThrWGpzZGlvclJDQ1BGcU0z?=
 =?utf-8?B?SjZnbnJjUzVYQ0ZQcGdpV2RDNkZOditVSnptTk1rQTBxREZJNXlzMHBBUXdF?=
 =?utf-8?B?K0Nmd1RHaTJGOWFUcWc0MkVqUDZnaVlvSTBVUklZTFYwdjVnK2M1MDJEek5W?=
 =?utf-8?B?VGsvRTR2eTkydmY5L0xjb1hQV0FwZlozSFk4YWdqSlBxMkczU0hWeDNrTzJJ?=
 =?utf-8?B?cUM1MW8zdktGRUhxeDFNYnFmSmp3ZkpFWTN0UWp3K3hvNUduTkc5UHJXUHdo?=
 =?utf-8?B?V0RVZjVheFZFT0tDdGVPTk9NT2llTlM0QWlpNld4OUpHUzQ2U3lWd3pORTJL?=
 =?utf-8?B?TUtIYTlYS2RpTG1DM3NLYlRVeU1WZjkvb0g3SjdVdVVsWmRmVW5lSGRaRkhm?=
 =?utf-8?B?KzYyRHE0ZnBaR01ER25IY0c4MzhVWjQ1YkJOSXE0eHVMRjM4R0t2UDNLYXdN?=
 =?utf-8?B?dTNubXNHRlJ0RWQxREdMcTUxM3lNTTEvbjY5aFNSRXh3QlJuODM0dlVWemxR?=
 =?utf-8?B?MERtazU1TllLN1RBeEZENUpmK1JqN2dRTWxLVmlvcTc0RmpCdStOVlBwYmNt?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53FA72F2F648564EA87703CC83174A9A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb883511-2342-4e68-5964-08daed71510d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 10:00:17.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OH7AX5IEmpF6bcWMHhqVA4T1JxiqHV8vbQoD4l3ispcvjIxXhNKSWgcLf9R0zRixtCMJI+8c44OZOpCvK9m4YtKF16zg1s9YTMtw13LJvaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEtyenlzenRvZiwNCg0KT24gMDguMTIuMjAyMiAxMzo0NSwgQ2xhdWRpdSBCZXpuZWEgd3Jv
dGU6DQo+IERyaXZlciBkb2VzIG9ubHkgY2xvY2sgcmVxdWVzdCArIGVuYWJsZSBmb3IgRERSIGNs
b2Nrcy4gRERSIGNsb2NrcyBhcmUNCj4gZW5hYmxlZCBieSBib290bG9hZGVyIGFuZCBuZWVkIHRv
IHN0YXkgdGhhdCB3YXkgaW4gTGludXguIFRvIGF2b2lkIGhhdmluZw0KPiB0aGVzZSBjbG9ja3Mg
ZGlzYWJsZWQgYnkgY2xvY2sgc3Vic3lzdGVtIGluIGNhc2UgdGhlcmUgYXJlIG5vIExpbnV4DQo+
IGNvbnN1bWVycyBmb3IgdGhlbSB0aGUgY2xvY2tzIHdlcmUgbWFya2VkIGFzIGNyaXRpY2FsIGlu
IGNsb2NrIGRyaXZlcnMuDQo+IFdpdGggdGhpcywgdGhlcmUgaXMgbm8gbmVlZCB0byBoYXZlIGEg
c2VwYXJhdGUgZHJpdmVyIHRoYXQgb25seSBkb2VzDQo+IGNsb2NrIHJlcXVlc3QgKyBlbmFibGUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWlj
cm9jaGlwLmNvbT4NCg0KQXMgdGhpcyBwYXRjaCBkZXBlbmRzIG9uIHBhdGNoIDEvMyBmcm9tIHRo
aXMgc2VyaWVzLCBjYW4gSSBoYXZlIHlvdXIgYWNrDQpmb3IgaXQgdG8gdGFrZSBpdCB0aG91Z2gg
Y2xvY2sgdHJlZT8NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9t
ZW1vcnkvTWFrZWZpbGUgICAgICAgfCAgMSAtDQo+ICBkcml2ZXJzL21lbW9yeS9hdG1lbC1zZHJh
bWMuYyB8IDc2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDc3IGRlbGV0aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
bWVtb3J5L2F0bWVsLXNkcmFtYy5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZW1vcnkv
TWFrZWZpbGUgYi9kcml2ZXJzL21lbW9yeS9NYWtlZmlsZQ0KPiBpbmRleCBlMTQ4ZjYzNmMwODIu
LmQxODM2YmUwMTBlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZW1vcnkvTWFrZWZpbGUNCj4g
KysrIGIvZHJpdmVycy9tZW1vcnkvTWFrZWZpbGUNCj4gQEAgLTgsNyArOCw2IEBAIGlmZXEgKCQo
Q09ORklHX0REUikseSkNCj4gIG9iai0kKENPTkZJR19PRikJCSs9IG9mX21lbW9yeS5vDQo+ICBl
bmRpZg0KPiAgb2JqLSQoQ09ORklHX0FSTV9QTDE3Ml9NUE1DKQkrPSBwbDE3Mi5vDQo+IC1vYmot
JChDT05GSUdfQVRNRUxfU0RSQU1DKQkrPSBhdG1lbC1zZHJhbWMubw0KPiAgb2JqLSQoQ09ORklH
X0FUTUVMX0VCSSkJCSs9IGF0bWVsLWViaS5vDQo+ICBvYmotJChDT05GSUdfQlJDTVNUQl9EUEZF
KQkrPSBicmNtc3RiX2RwZmUubw0KPiAgb2JqLSQoQ09ORklHX0JSQ01TVEJfTUVNQykJKz0gYnJj
bXN0Yl9tZW1jLm8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVtb3J5L2F0bWVsLXNkcmFtYy5j
IGIvZHJpdmVycy9tZW1vcnkvYXRtZWwtc2RyYW1jLmMNCj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAw
NjQ0DQo+IGluZGV4IDljNDlkMDBjMmE5Ni4uMDAwMDAwMDAwMDAwDQo+IC0tLSBhL2RyaXZlcnMv
bWVtb3J5L2F0bWVsLXNkcmFtYy5jDQo+ICsrKyAvZGV2L251bGwNCj4gQEAgLTEsNzYgKzAsMCBA
QA0KPiAtLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiAtLyoNCj4g
LSAqIEF0bWVsIChNdWx0aS1wb3J0IEREUi0pU0RSQU0gQ29udHJvbGxlciBkcml2ZXINCj4gLSAq
DQo+IC0gKiBBdXRob3I6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBmcmVl
LWVsZWN0cm9ucy5jb20+DQo+IC0gKg0KPiAtICogQ29weXJpZ2h0IChDKSAyMDE0IEF0bWVsDQo+
IC0gKi8NCj4gLQ0KPiAtI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4
L2Vyci5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4
L2luaXQuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiAtI2luY2x1ZGUg
PGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAtDQo+IC1zdHJ1Y3QgYXQ5MV9yYW1jX2NhcHMg
ew0KPiAtCWJvb2wgaGFzX2RkcmNrOw0KPiAtCWJvb2wgaGFzX21wZGRyX2NsazsNCj4gLX07DQo+
IC0NCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgYXQ5MV9yYW1jX2NhcHMgYXQ5MXJtOTIwMF9jYXBz
ID0geyB9Ow0KPiAtDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGF0OTFfcmFtY19jYXBzIGF0OTFz
YW05ZzQ1X2NhcHMgPSB7DQo+IC0JLmhhc19kZHJjayA9IDEsDQo+IC0JLmhhc19tcGRkcl9jbGsg
PSAwLA0KPiAtfTsNCj4gLQ0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBhdDkxX3JhbWNfY2FwcyBz
YW1hNWQzX2NhcHMgPSB7DQo+IC0JLmhhc19kZHJjayA9IDEsDQo+IC0JLmhhc19tcGRkcl9jbGsg
PSAxLA0KPiAtfTsNCj4gLQ0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXRt
ZWxfcmFtY19vZl9tYXRjaFtdID0gew0KPiAtCXsgLmNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXJt
OTIwMC1zZHJhbWMiLCAuZGF0YSA9ICZhdDkxcm05MjAwX2NhcHMsIH0sDQo+IC0JeyAuY29tcGF0
aWJsZSA9ICJhdG1lbCxhdDkxc2FtOTI2MC1zZHJhbWMiLCAuZGF0YSA9ICZhdDkxcm05MjAwX2Nh
cHMsIH0sDQo+IC0JeyAuY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOWc0NS1kZHJhbWMiLCAu
ZGF0YSA9ICZhdDkxc2FtOWc0NV9jYXBzLCB9LA0KPiAtCXsgLmNvbXBhdGlibGUgPSAiYXRtZWws
c2FtYTVkMy1kZHJhbWMiLCAuZGF0YSA9ICZzYW1hNWQzX2NhcHMsIH0sDQo+IC0Je30sDQo+IC19
Ow0KPiAtDQo+IC1zdGF0aWMgaW50IGF0bWVsX3JhbWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gLXsNCj4gLQljb25zdCBzdHJ1Y3QgYXQ5MV9yYW1jX2NhcHMgKmNhcHM7
DQo+IC0Jc3RydWN0IGNsayAqY2xrOw0KPiAtDQo+IC0JY2FwcyA9IG9mX2RldmljZV9nZXRfbWF0
Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4gLQ0KPiAtCWlmIChjYXBzLT5oYXNfZGRyY2spIHsNCj4g
LQkJY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJkZHJjayIpOw0KPiAtCQlpZiAoSVNf
RVJSKGNsaykpDQo+IC0JCQlyZXR1cm4gUFRSX0VSUihjbGspOw0KPiAtCQljbGtfcHJlcGFyZV9l
bmFibGUoY2xrKTsNCj4gLQl9DQo+IC0NCj4gLQlpZiAoY2Fwcy0+aGFzX21wZGRyX2Nsaykgew0K
PiAtCQljbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgIm1wZGRyIik7DQo+IC0JCWlmIChJ
U19FUlIoY2xrKSkgew0KPiAtCQkJcHJfZXJyKCJBVDkxIFJBTUM6IGNvdWxkbid0IGdldCBtcGRk
ciBjbG9ja1xuIik7DQo+IC0JCQlyZXR1cm4gUFRSX0VSUihjbGspOw0KPiAtCQl9DQo+IC0JCWNs
a19wcmVwYXJlX2VuYWJsZShjbGspOw0KPiAtCX0NCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAtfQ0K
PiAtDQo+IC1zdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBhdG1lbF9yYW1jX2RyaXZlciA9
IHsNCj4gLQkucHJvYmUJCT0gYXRtZWxfcmFtY19wcm9iZSwNCj4gLQkuZHJpdmVyCQk9IHsNCj4g
LQkJLm5hbWUJPSAiYXRtZWwtcmFtYyIsDQo+IC0JCS5vZl9tYXRjaF90YWJsZSA9IGF0bWVsX3Jh
bWNfb2ZfbWF0Y2gsDQo+IC0JfSwNCj4gLX07DQo+IC0NCj4gLWJ1aWx0aW5fcGxhdGZvcm1fZHJp
dmVyKGF0bWVsX3JhbWNfZHJpdmVyKTsNCg0K
