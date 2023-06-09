Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77B729923
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbjFIMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbjFIMKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:10:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB3180;
        Fri,  9 Jun 2023 05:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686312601; x=1717848601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=orMM5h0DrHlTKo7HgRhArB5Ez/1cleYzHxVOnmEhhdY=;
  b=dTNEgWBnWfPQ5xfcYZJFYi4ofbeq1rdLKcJzjnBx8hibtvzWSJZvkLuz
   Wfgl4Dbu6gJcFcm0h96mJq9omI4XrE0UphFToQfQ823qMyi5LyDkkLgkc
   qPEZurkT+GVqAAbr1pGeYaw4T/x2F4g0ZCPy8jZvmS1XL95iXtLChB7eO
   TIYmML/zL9fi4qNUHxKk+DzgFvHDKvaCgLlB39TXcNi2f915jpk2SjF2l
   cNNt0Decxb/LNN7rrwyxSwLW8dsrtbbvqCXmBf3zyc+OL80F3TjF7TKdq
   0pZt8sNVwHsERVXSQZuIeM6Xldn6J/jMsKiUcgC4ZXtxO5pFY92cCSg5w
   g==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="229300299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2023 05:10:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 05:09:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 9 Jun 2023 05:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHdUWXW0hnJnW+UOVc59zF0PJs7D4ed9bzw9+EoK6KysqA3UtFSM2HHd0UW/Z5TXowS8lqILk5nSTI2eJQt3C+yPzyxSrIL3jPIiZEPC2KHOIGTxWAvu+CYJswlyUh5Gjg5eZ47FOheJ2N9ceMNSy3tP06F3xsrPY6C+Y/QjyL+yfzzfNXCMnnivaJGAkqXBu07771UMDPDXRQ0TrGHEWItJ5NxgZd00wHJmltaob1IMceB+hrlmYnWsHqXodFGe1/bvnrXWsAvotOgPC73Hu3Z/UoQC9fkH/0s6M0eiwP/7uL/xSC/YBZXpf8EN/1B1WCiFJDyICuG3s5FbDBhTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orMM5h0DrHlTKo7HgRhArB5Ez/1cleYzHxVOnmEhhdY=;
 b=KmksTD4iLaPC8/HuUUjxV1jLXFRO0mN9sopvIzc7OcugaJfNEyYpNT9ooOvqGAmzgsfsq9FKvgdkczvp4cRcopIPFybHzk9LulonBjL9e8J3l1F9/QpTU3oBnoRdi4ugaI9UmWFkxkjdHJ3HgVrmArKD7IhwyqIkET3KVKyiiR4c4N61VGllZXw2wwbtnt984D37LUEawrBgl90pZvjNEeIo44OvLSryMYLwF/pWGSMXtb3lOdJcJaC9KNoNqfhWUGUIIYhw1j2IPDhdr2AqcjZD0bJgLdX5dyOhvR9+Sqll1m5hS3HKtQew6Eavb8qt0V9MBm07HjqUpudLRuIRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orMM5h0DrHlTKo7HgRhArB5Ez/1cleYzHxVOnmEhhdY=;
 b=ippWBkVhWlBtnLnSq3Wjv5sJdfajzPoDRvlEL111oq/DZHVbUFQOvRsnnj7PEukwwURhgQrb8/sMVYM3clMWoNxdnfWHkaCtM0o+3KvG5H/Da3Znr9BJjKsq3bDGjbQ500L2mhqjcVNXvlS8LqtB6qxbB1y1qucDxswziI18WPw=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Fri, 9 Jun
 2023 12:09:58 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.024; Fri, 9 Jun 2023
 12:09:58 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: timer: atmel,at91sam9260-pit: convert
 to yaml
Thread-Topic: [PATCH v3 1/3] dt-bindings: timer: atmel,at91sam9260-pit:
 convert to yaml
Thread-Index: AQHZmstP+VYzi5XWtke7Fl5xBMWXlQ==
Date:   Fri, 9 Jun 2023 12:09:58 +0000
Message-ID: <e8fd0340-da21-0cf7-7ec3-a3f278716c15@microchip.com>
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
 <20230530090758.1652329-2-claudiu.beznea@microchip.com>
 <46eced08-5bf6-3e4b-7a91-ff4d16c7dab9@linaro.org>
 <e816a8c2-e4fb-a608-f8e0-232135243c8a@microchip.com>
 <9e4a0756-8b42-81a7-5b5c-60c0ebea0d7f@linaro.org>
In-Reply-To: <9e4a0756-8b42-81a7-5b5c-60c0ebea0d7f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CO1PR11MB4801:EE_
x-ms-office365-filtering-correlation-id: 04391c40-4dbd-4921-2652-08db68e271a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXGtzlmUPx4PpixoB+/crBLvZgdNUGWcNH/5tv+wzVFFwh9sCW/4xxCVNNpCFONwb2XxUnJ+7WwAwbGVemgis8to0gS1IZosuixQsqw9QT/xfbWjghvvmJFHMbRa7zx+nE/NuvFcxNLYZH0ouz6GZMkc8c6K7CWVOlDi1LUuNe/nrgDIOfC6P8SzeTToHuMCPAkHX6DgFNrNB7ewy/xlfLkAqMI13bbY/PZhV3hD9NqA9Ko7ZmswW11q9CBZeUMUtsOrSCwYJXE49oIeuGkOumFhfMn+DhblvFhKX9FeiHf3106TNTM3JYQEel9JT32AWY0Xgm0HZVakEe9o7J/ZnL7eQrmd00FM0MlO44+R55esKsk9fE4vRF+ehUitdzlRDfLZP2u3C7zYRnF7u1mRrnLtl+p7S32OumTVtgxmPkOquNYstejoVWnpPXQkQ4SNC0ofKg/fguAfqSuUyepNuzaWU5bCmI25xjJ2lnzwU1EBkSI/sHf4CHUzyrJef2VOS1/jws3UMCxg+Ma0B5PRjVQH+/Mlah1DwtGknPNfgmNLFs+hdeXWVdeXUXXozmaY1uKVXWeXkJYmNcAfI7n0M8VWaVyfsUxsLydQoyQr7rSHI6f1F7VwNyxp8TQipbf/Apc1z65rAPUlCrEsktmX4aQ5aOl9wUBosOpj486NBzmJrzaw1TgqdrQ3HpztbzSlR0T6FNgwjWMeG/KJWVx+wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(31686004)(76116006)(91956017)(54906003)(110136005)(6486002)(478600001)(316002)(66556008)(66476007)(66446008)(64756008)(4326008)(71200400001)(66946007)(41300700001)(5660300002)(8676002)(31696002)(86362001)(53546011)(186003)(6512007)(26005)(6506007)(7416002)(4744005)(2906002)(8936002)(921005)(38070700005)(38100700002)(36756003)(122000001)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N283bXpLSFR0U01xa2p2bTJOeDRJZm1KNGM3aXlnUitOcC9IUUE0bm1rV05D?=
 =?utf-8?B?TTV5cDlBQ296MDEyTmxhaEhmd1BxQTNIOWVnR1lleUo0TmppSWJmVzdaeXRM?=
 =?utf-8?B?cWFkUFZaaFJ5cUJxeU1xTWdGc0ZzWlFGa1BOcGVadWU0U25OMlMwUkVLZWYv?=
 =?utf-8?B?TGw3MUtld0krK2RTbjRQc1ZKS2J5dGJQWk5ubW16ZDQ0RmRFZS9jZGZmWGFC?=
 =?utf-8?B?U0Q2WVQrRFZvYUNzN09GQ3BldVBWakhKVFBkK29TSlpzZlNOeTRZM00xU05Q?=
 =?utf-8?B?MXRrZUE1alN5V3BFa2MzQzV1NnV0a0hYaHpRVVFPUVA5R29LNnFuVnFQUUZR?=
 =?utf-8?B?YWJNeXNpYXdlNTIyZWlaSnBQVzV5R3JySytIUWN1aEp0OHdDZ0E0Szc1UW9y?=
 =?utf-8?B?RGdFeW5MYWN1eVhHWm0zNW9zajhtOEFWeEl3Z2JGMWwwck5JOVVBT0pDZFhH?=
 =?utf-8?B?Y2hUeVlUcGJEa2NMenpDMko2UWlFNUhHeTV1NllqMWNJaXY5UEtEYThuUUht?=
 =?utf-8?B?UmQvczVCRUIxRGVnd0xaOUM2WDNuQUdPNnp2cUJ2bTJ3akVNM3dYVWx6Tit0?=
 =?utf-8?B?ZkljNGhxQ2hZV0xpUEJML0xtMDJxNDdHckJWUnpJa2VBcHJvVWdqK2hyaU1T?=
 =?utf-8?B?VnoxLzEvaG8rUEZhZ0N3NzB4em9YUnlDUFRDQXdRS1Y3aXpTNzFXWkVIYXJa?=
 =?utf-8?B?ODFvdXN6dU9WK2JjZmVzM0xoZ2tsaFk2bm5BYk5XcEdvRktBcExoOS9tQjBX?=
 =?utf-8?B?dllCRWlVZERWVU1zekdYUEJxemN2S3oyWmkvMjBJMUlTb3JhbDRlV3NzbTA0?=
 =?utf-8?B?L096RjF4RHZIVmtWK1JNdEpBQklGeDBWMGFvZjZYckh1MFhKRFFCbW5PaUY0?=
 =?utf-8?B?YTAreHZOa1VOOW1XOW1vU1VVOFZjSnVPc2htakJiR3BOUFNlYnl1OHpZdU5Y?=
 =?utf-8?B?bXhkcGJOSHBRQk93RHBDR3ZvT0F6T2RNUmx5ZCtDcW0rSitBYjdBUTBlNDRF?=
 =?utf-8?B?alFpa1ZjVytrMFduOGVZQkY4eVJvRTl4VmFXb3ZCZWlCamNqTlFQRUR5MFdq?=
 =?utf-8?B?Qk04UWgvS0l4SkpBaGNubElmbjhYd2ZaMFk0clpvYnVCanRQcDJxZitjYmNX?=
 =?utf-8?B?UUlMTjJQVjFmcllKakpwbnEyZml5T1VlcVpPcnZuMm1oNmlXNHF2YmFNZ2N1?=
 =?utf-8?B?L3Q2VjN3Tk1qb25GTjlRM2IyQmZzeUluQTJUUDVuU3NWOFdTODFwdXR3c0JL?=
 =?utf-8?B?TVF4UUV6TGovcjFaQXk2Q2hWVEowbmJhOW82TlpYQVQ4MHBseHN4bHhQV2dj?=
 =?utf-8?B?eFJFcDZaU2NpQms3MiswNzZQL2s3WU8rbDFxUWQ5RTRXck1OR2lRenhSMmtV?=
 =?utf-8?B?N0ZIWjUrRDIyVC9wMDJsbGZhRjZ4VllOYWdRSHc3VTNic090empacWF2L0gx?=
 =?utf-8?B?cENTZ1E1YWdYWE93TWt6empidnBkTUhZVHB4bnVPSGx5ZkVEQnlOMEE5Ky9j?=
 =?utf-8?B?U3U0N290cmJkN1o5eC9VdkhoYzl1L2xsWE1xUHB1cGgvWllmU05PeHFxOGxx?=
 =?utf-8?B?K0lvTkVkTk1tQ1BvY2VJMzZyTG5LVHY1OExoOXdodDBKczcwUGZaUk1kV0I1?=
 =?utf-8?B?U1k4WGF6Tlg2ODB1QWdWTkFxYTlWOWlDMVI2Ym9qNVR6V0tnZ3lwQW41U1RF?=
 =?utf-8?B?cjFjMVgzbVlvZU9GZ0J3bXV1UWlwWmU4WUwvZ0M4UVhqWUtKYTdFcC8zV2R1?=
 =?utf-8?B?ZmVVNkRwZmVGVFI5SHZrb2RFRXlLOHZERDRST3c2V250Tnk5VENWOXFSeGJz?=
 =?utf-8?B?cDRId3hEYThiY0t0MEdLUmRLWjZPNmpRSzZMc2pPRUlHcmlGSytGOXcvMGp5?=
 =?utf-8?B?Nmw2Vkg0SkFGemZEbTRSRnpsbXczc1VGek9nSVlXUHA1eGFHREd0STdRRmxL?=
 =?utf-8?B?c0hRUXMvYS9pTGRWOWdNMXF3RjFWajhvdkZvYUVLMHliMVBiZno3dzNYcjVr?=
 =?utf-8?B?STBEbk9JNlVRZjR2NGNmOGhjOVQzWlYvZDVvV0NZN2JwYW1ZdHpmTU51SDND?=
 =?utf-8?B?alQvMllZb2trakpsa1F5UXJmV0lQQ0swUnlhV2pmc1RBT1NQWGhIVWZIbmEr?=
 =?utf-8?B?eHRwK24yS0psSEpKdWk4QkVEWExFR3VTNytjWEZoZ1cxNFNzLzZGdVAxY3lJ?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F28B4EFA87507E4FACCA4532BF6D6546@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04391c40-4dbd-4921-2652-08db68e271a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 12:09:58.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tuILDdtXVxa9BHqDEj5X4pejJA1r1OCONfUxHv92b0u6JMEnHGWE6096GrH09ejKaO0QfJhUmo4P0aoV9tBZAqUG0XTm7NF4XQqltcL9mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDYuMjAyMyAxMzo0OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCg0KWyAuLi4g
XQ0KDQo+IA0KPj4+PiArICAgICAgcHJvcGVydGllczoNCj4+Pj4gKyAgICAgICAgY2xvY2tzOg0K
Pj4+PiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+Pj4+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0K
Pj4+PiArICAgICAgICAgIGl0ZW1zOg0KPj4+PiArICAgICAgICAgICAgLSBjb25zdDogcGNsaw0K
Pj4+PiArICAgICAgICAgICAgLSBjb25zdDogZ2Nsaw0KPj4+DQo+Pj4gaW50ZXJydXB0cz8gVGhl
eSBhcmUgc3RpbGwgcmVxdWlyZWQsIHNvIHdoeSBubyBkZXNjcmlwdGlvbiBoZXJlPw0KPj4NCj4+
IEl0IHdhcyBoZXJlIGluIHRoZSBwcmV2aW91cyB2ZXJzaW9ucyBidXQgQ29ub3Igc3VnZ2VzdGVk
IHRvIHJlbW92ZSBpdCBhcyBpdA0KPj4gd2FzIG5vdGhpbmcgc3BlY2lmaWMgYWJvdXQgdGhpcyBk
ZXNjcmlwdGlvbi4gRm9yIHRoZSBpZi10aGVuIGJyYW5jaCBJIGtlcHQNCj4+IGl0IHRvIHNwZWNp
ZnkgdGhhdCB0aGUgaW50ZXJydXB0IGlzIHNoYXJlIHdpdGggb3RoZXIgZGV2aWNlcy4gSW4gdGhp
cw0KPj4gYnJhbmNoIHRoZSBpbnRlcnJ1cHQgaXMgb25seSBmb3IgdGhlIHRpbWVyIGl0c2VsZi4g
V2l0aCB0aGlzLCB3b3VsZCB5b3UNCj4+IHN0aWxsIHByZWZlciB0byBhZGQgaXQgYmFjaz8NCj4g
DQo+IEkganVzdCBkb24ndCB1bmRlcnN0YW5kIHdoeSBpbnRlcnJ1cHRzIGFyZSBpbiBvbmUgYXJt
IG9mIHRoZSBpZjogYW5kIG5vdA0KPiBpbiB0aGUgb3RoZXIuDQo+IA0KDQpBcyBwcmV2aW91c2x5
IG1lbnRpb25lZCwgQ29ub3Igc3VnZ2VzdGVkIHRvIGhhdmUgaXQgbGlrZSB0aGlzLg0KDQo=
