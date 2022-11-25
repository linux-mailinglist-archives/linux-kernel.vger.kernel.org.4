Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70258638609
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKYJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKYJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:23:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E411431F8E;
        Fri, 25 Nov 2022 01:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669368225; x=1700904225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iO9Hg4rIbf3Sky7D6XQPVeSOkHC5WoAvIlicPP8njKo=;
  b=rrPxejFgionWH6+Fs4lKfsZqaJVonM0JZ+nRlBhXxtPfNkO2g0mWEaFA
   v+cb1NV0n7CTJZiykt4eUksjs+p15+9BRwYPylCBbJRlfgLe665sNBWO0
   cmRpJRghip6/5kpnyUve7axi62PCba0CJ/OywO6YUK9WpCCNzPYPoSrTj
   /XshsSXaPmQRlJz5s/GzrihKVHw40FC0DTgrEd08Y68bVIf7M5RMGxyyF
   lee5dxnfxjGHNUwz3MUlO0DzAMnSxPWVgykLA3RuWDvk+hir/Sof/JXGV
   0znVM1PLHLzbf5x7X6mkKxA9LXbTNGpgKlctMXab4bBuCS8TuuajVTfqg
   w==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="190514640"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 02:23:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 02:23:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 02:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6eUjW+kZl6T7g+PvQ/A5HTPvnWrIx+yx+FVawoc6STNTrmRxzbDmiL3kyvh0VEhxkZ5EHTxLK1iV/Faf1eziE/vLJdQYQUWzt3Ll7Wz4Ms5MG2BDDfwH0NXv1KWsKr59Xud68wGmur/bk8bJiwtHJ/m6n88AxLc+18dABt9UZTjVR9ndoYBjaDcvjQklXQPBc1+EHS0FeFmEhxI5JfEgi9A7EhbTNTpbgTvqlSXIli4YIkzQSn/LF3+9sr6uW2INiOks+psb/ZQaAbIy5rcOztTrT0YqkID1dJAhbHgAC/HMC+RbiiGMUO+r1DNUO2YYO5AN71HqMh2T+uycG3EOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO9Hg4rIbf3Sky7D6XQPVeSOkHC5WoAvIlicPP8njKo=;
 b=RiXwwZDaPqz4hjyJsVSBdhdR1fiSMN8iUS6MlknZ8wpJri10tYx6ODOeUXKriSF/DnvI4enSaSAbWfJRymbNuoxqmNMEfalgu5/2nXl8mLftor9J/G6Ee4bS9Y38gE5+HCyoREolquiwf0FppQJzR4ETmFduBuOd/ZZAzjRfZgX2kOftmT2mPj1OpiRaRGNyUaSYIuT1zDhCZhnJms6badQF5/3ZiV2K2gKdXUDaO9VkAGJwcrdt+/xyDWHU8oEQ96WFwkWbFY3KKhyBkGOzDSNEe7lOpbsdgzfsMEaQ9FaSocBg+JO+uEqGXaE1fAjF3JCTsVn1kX/RbEw7F6wHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO9Hg4rIbf3Sky7D6XQPVeSOkHC5WoAvIlicPP8njKo=;
 b=vhGYR/XEGdr3PqidPLFlA5JSuyiC2AqkQ+7HWAFwLRaMn/QFAnzvL/O1dEfx/kzG6iQI8BY+DOtxnfLZjXaDRXZCcY6wX0bGA1yuNHxbBefagU8xkcbu4rdCZHZPskxs+uxEV7bYKtDaYLHNOCkPyTnPrznxMHXM6pP3tIrurRU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB5374.namprd11.prod.outlook.com (2603:10b6:5:395::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 09:23:42 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Fri, 25 Nov
 2022 09:23:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Topic: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Index: AQHZAK+bDDrCqgr1WESzQT9bOyCpdQ==
Date:   Fri, 25 Nov 2022 09:23:42 +0000
Message-ID: <bdce1cb7-a771-4ec6-c75b-f547d26f95b3@microchip.com>
References: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM4PR11MB5374:EE_
x-ms-office365-filtering-correlation-id: 73c9238f-63d1-4f45-5e0e-08dacec6be91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3mt4dXUQlon9Xr9nN+DRYouQbg4HvnSXTkXd7uuFhqYI7MTZpKxHpOjOWItESegHJVXOWNTaEIXgrbqFXs/rr0+hord6PhhPOKt2xJBfcXKnMsyRcNkHXQLMgOba6Tr3rV9IF9LuJH+HeGtvWfCFpGRATKWXMmWC/8l0ovn4M5c9avB0yTjP1PMcaP0N17AFXZwxSlJDpu5uf1H5YNY8b43vse4jQ5GIxzerA2CWOW/NKnJx9pugj/tHRS4zJuSDRk/Pbw2TgBGf0nJucA6WC5oCsAEBJSntLwS0fQ4/q4WhiutP/FZkuP78y5yQD5Xs1ktbTmiMi7/oNm9pKoRlOT/ctSTcK6x9U4PoSPi6h4DYXQJ0FnELs4j2kmOjIH9mtmL3DmJtkA56KLJTcWXX6yAgO3zFgN93+ab3XikNnP3B8xnyyyRrvMZO4EqVJDI7kkB5CvAcDBbYrKMLBp5Hrlvy3HzzwNyNdwWBkCCGmzHF+I2mLI2fm0Ez5ktt5C7AJ10rc5Ls5ZM8b05B4h5+dNDHjk3CIOvuvRxKcV3KtaUN640yEjwR/ophjKkJCjSso1AMg9IOsh/Ob1ftqciH5ZjUQNuxR+BkAS2zMyeGnt3SZ71s0D9KaMdzvLAYkHi31QYVHrUBFVyjNhL/PPZpKbIdn9rdXAMWvn8iBZfokqNqgk02bp8QG3tCL+0a1NImsq8L9GH3VMQihZfX30daeprm0Xj00tGg9kiSEQNG0LHzKa5XHwdq3ZGjlbWAv/5dFnJd/nSmd4FIbMRl2ADJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(36756003)(31686004)(38070700005)(122000001)(8676002)(76116006)(66446008)(71200400001)(66556008)(4326008)(66946007)(66476007)(31696002)(64756008)(91956017)(86362001)(38100700002)(6512007)(478600001)(53546011)(2616005)(26005)(6506007)(107886003)(41300700001)(4744005)(8936002)(316002)(5660300002)(110136005)(54906003)(2906002)(186003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFZnVDRheWZ4R3hkcktlNmxSOE94V2JuUFNoTkUzL0J3UHZKU0lTaXpPL2JK?=
 =?utf-8?B?ZWs0QmRxbVZSL1pFZkNsM0d0WlFCOXJUTkdSbS94aStYR21UZUpaaTdnVEFC?=
 =?utf-8?B?N0VZcExubUFKUEFWOGVva2YzTXRuTGtWck5WMVRiR0ZGWVJCbzNVSTF1Ym1i?=
 =?utf-8?B?VG8rVnN3bG9MYThCeUNFd1R5ZWx4eDViQkNqZE4wVHEzZXo4Zm5BeTlWU0Nx?=
 =?utf-8?B?cUg2eng4a1dnK01NTisxUzA3bENwYXBBUXRETUlvMDhzSE03c3RRUG1TR1Vv?=
 =?utf-8?B?L2k2b1RkdWd0blFBeHFRRFV6TzZETjRUOTZhbjRrRzhCWDNCN0U0V05vRHFK?=
 =?utf-8?B?aldqUFc1Z01Yb0hTcVZ2dC9qSWFJUlBBd1RFWXlnRXNqYk0zdlhGRUpUVXlN?=
 =?utf-8?B?U0kwQW5Ycnc0bVRlVWp2R3REWUIvUjg0WUNjY1RHQWxWcEt2alNzUndZMDh5?=
 =?utf-8?B?MmZuMmppSFhZRnVpY2VOVjIrNnBaajVFMy81dTluNXhTUjV3Vnp0TUtRRitX?=
 =?utf-8?B?d1plVG42SDJueTRvM0RFbU5VaTVNbks4dmJ6TXhHM3lDRUV4UHFteHZTaWQw?=
 =?utf-8?B?MCtqdVExMVpIOEhibkQreVNLdUpBUTZNQWVPaTNqK3Bqa0UxNUlGNzNJMFJl?=
 =?utf-8?B?QnpOSFY3dExiS3lzN1Y5cWJYVzRMVTlpNVpkd3FWb3p5MnUrWDNYY2s1ZjBF?=
 =?utf-8?B?bzREU0JYN09VSy9OZW41UFk0K3RWejVLSSt3dSt0NXQwU0R1VDV5UGdSWGxO?=
 =?utf-8?B?UXd2aHZIYWZUb25PZnkyaXdnUmhYZVFHdmJyV3FYYnYvL1lvQy9tVUsvbGhF?=
 =?utf-8?B?Qi9oTHZDbUxPelArVEc3OEY4R21BbXRsdXJQWEJBWGlsaGtkMmtmcFQxVGhh?=
 =?utf-8?B?R2lHSEErWHRPZmF5bi9xMi90eDhwRHg0ZlpweTFtcW1EQUhwNmZaUTFQdk9x?=
 =?utf-8?B?KzE5OXY1WDZPbW1BWG0xVUM4UFJlclE4MGdKaTRmOGdjL0VCTGlnTFNEYXRt?=
 =?utf-8?B?Yy9oblBZV0FTQmlmZnVQM3orbEZTcjFlRk1XQVpacE1nOGdlcWxDTGREenRq?=
 =?utf-8?B?NWpVQm8rM05CeWRXQmEwMXlJYnFacHBDV2k2TGVZRVAzUkljckE4S2VnRjhX?=
 =?utf-8?B?SXkxVlMya3lUSTdLM0R1aWg2dUxsdTZtbC9La2UzNzQzbHROQ25Yb2lYU3dv?=
 =?utf-8?B?VmszUkdIb2hYZ2lsd2szTDlLMmNFSlRRTytVTjhmWFM0cXA3dko2OFJiaDVU?=
 =?utf-8?B?L1BlVUJSOGlVaWRxVS8yZ3JyV0NTR2x4a0ovcEVyZHhHUnIzZW5TcUtIelpq?=
 =?utf-8?B?aysrQjdMb1BWTDJDT0Q1bzI5eEZ2Z01IM24wamt4bWpxTGZKZlB4WHRaditJ?=
 =?utf-8?B?dnUxdTg2RDh5S2dPSEtQZE1RaGpoREd0VlhNQ21Lb3ZBRFc2OG93ZmZDdHJD?=
 =?utf-8?B?VzU4bEpyWCt3UmFXWjQ3ajBXd3kwRVFvdFd4TlNqRDlESmFvWlJpcDUyL1Ru?=
 =?utf-8?B?TnlrL1dKQ1FBTU5kaSsreFo0Ym5CVzh1MElBeDBpdzBDZU13RFF2TzIzN3oz?=
 =?utf-8?B?R1JjbzNTNWJ2Zm43RmdiSzBpZDdYMVl3VEdxbE16UnZpU29PY3lMM3JoTTRz?=
 =?utf-8?B?VCtXWWlsbXlQR0lsb3RLams3Qk1mV0pOTE9IWmZpRzZUajJkQzd1RWlwOUlp?=
 =?utf-8?B?QytOdDdxSVQyajZuSHRIUjBrY1pVLzBiVnNKejBmYTdJc1o2bVhKZll0K2gr?=
 =?utf-8?B?Y0liMlpJZ2ppc283NVRtVXNnNTR3TE1GWlpRTC9wekV5SmQ1RUhUNUY4eWlK?=
 =?utf-8?B?TWo0a1dxamhQL3FJdXE2M3dIbFdkRnlYUE1Sekgxb0FBMVRGRUx2a2h6Mmh2?=
 =?utf-8?B?TWVLMGMvTTVadWVmOUxhb3RycERoc2lpS0E1RkNkNVlqbis4REw3akg2RG42?=
 =?utf-8?B?TUtVdnM0bGh6OHFPTnVmay9vU3JMb0Jjb1pHc0RqVGxZbnV0RXgxOWFLc3VC?=
 =?utf-8?B?K3g5S2hBcC8raTl4UGlldDRUREpjbkFycFlETEI4cE9yT2g2VkwxaURZNk0y?=
 =?utf-8?B?MGtyaVcvY0d3QTVsVEtyQXBhU05QVVh5a0M5TzlBbVU2RTRZcVhmYzFrQldW?=
 =?utf-8?B?Uzdobkp0bFUvUUZsYngwWHR0ZmJaemNUeE1WdjdUREVHVzc2Ykt6OW5qMnpD?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <053677930F951C48894688B0253921FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c9238f-63d1-4f45-5e0e-08dacec6be91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 09:23:42.1922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNuui5UnZhGdp4FujvpV5I9X2aF6Bc/OsKxDelM7HcqdQPM11WP7lmobKj2+nMgIePBxrW+6C0oQmnt6OUHAPsUvRyE9252KA+EX41Due0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5374
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhvcmF0aXUsDQoNCk9uIDE2LjA5LjIwMjIgMjI6NDksIEhvcmF0aXUgVnVsdHVyIHdyb3Rl
Og0KPiBBZGQgT1RQIChvbmUgdGltZSBwcm9ncmFtbWFibGUpIHN1cHBvcnQuDQo+IFRoZSBib3Ro
IGxhbjk2NnggU29jUyAobGFuOTY2MiBhbmQgbGFuOTY2OCkgaGF2ZSB0aGUgc2FtZSBPVFAgSVAu
DQoNCklmIE9UUCBJUCBpcyB0aGUgc2FtZSBmb3IgYm90aCBsYW45NjZ4IGlzIHRoZXJlIGEgcmVh
c29uIHlvdSd2ZSBhZGRlZA0KY29tcGF0aWJsZXMgZm9yIGVhY2ggU29DIHZhcmlhbnRzPw0KDQpU
aGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JhdGl1
IFZ1bHR1ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2Fy
bS9ib290L2R0cy9sYW45NjZ4LmR0c2kgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2
eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IGluZGV4IDIzNjY1YTA0
Mjk5MDYuLjc4NGNhYmEzNjk0ODUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xh
bjk2NnguZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gQEAg
LTE2Myw2ICsxNjMsMTEgQEAgcG9ydDc6IHBvcnRANyB7DQo+ICAJCQl9Ow0KPiAgCQl9Ow0KPiAg
DQo+ICsJCW90cDogb3RwQGUwMDIxMDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlw
LGxhbjk2Njgtb3RwYyIsICJtaWNyb2NoaXAsbGFuOTY2Mi1vdHBjIjsNCj4gKwkJCXJlZyA9IDww
eGUwMDIxMDAwIDB4MzAwPjsNCj4gKwkJfTsNCj4gKw0KPiAgCQlmbHgwOiBmbGV4Y29tQGUwMDQw
MDAwIHsNCj4gIAkJCWNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1mbGV4Y29tIjsNCj4gIAkJ
CXJlZyA9IDwweGUwMDQwMDAwIDB4MTAwPjsNCg0K
