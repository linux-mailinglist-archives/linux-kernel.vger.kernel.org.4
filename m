Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D7689841
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBCMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjBCMIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:08:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E0EBBB6;
        Fri,  3 Feb 2023 04:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675426087; x=1706962087;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=2DtSCHnFcdY1Yt6QhDsoGs4rwgmtIX8m3OXUtguGOlc=;
  b=nLywewauWEqRNhzK22VZr3SseUqnsHykbN/1TTziGxcZKyxVz2IDbu9J
   qPLgWdCI8OQkw5TjaAJtm+Uzu5KOc9GYAtFDg9qm55ugJZkAc+nrBJBeU
   rd09lO1XPoZJ5CiA/nOCqMJ8OEIC+xVY9DlUQfp3gUyoTuAHKhXsIiFB6
   i2RNnaeeFE3tE2hw0sIYsoITRIrPls3L4x3RnHIjUpDV0SA3F7XthkABT
   CXv/UHTM8fuEklP//mFipsVSF6ir0nLpYQMpSvDJm7AaxvdaMTCyJU6Sf
   7v22Hi497rH5o5oP+Xn5BldXqbjXRbXNoBonDl1bpAOxbkjjvpKh41AWr
   w==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="135422649"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 05:08:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 05:08:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 05:08:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bupOw2/SSAd9+8/hPGS8vXqGKSxkc4iJXRKhPJPJsBjhSpNwXBLPw1pJse9Bfyyaj2ymNBGemHmOWGWLUFOF8wj332D7CMdN25DL8NCMvR7+Tw9mGsttGYI7kFYu0j8sEsa1Le2zwoxYroiuPUMX0xLvpKww6f3GuEYFvEp2hXiRJQqZ2q2qBAdeL2TgL9mUwhH7z3wiiPEQ7TJzXEU+PO66fMWxSPSXSJp2lOlKgefA7mH5VyTwKglrfa5LyXmG0889eODX3u0iMCWIXclXEXqdsBYXzXWKRYWJTBTgvkRH+iwZKlc1hBN54Wg0gkI8kI3BmpJGzZP3cDfPWojNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DtSCHnFcdY1Yt6QhDsoGs4rwgmtIX8m3OXUtguGOlc=;
 b=TwbvwpUcQ7eZVbIWiIriJMGTb3ye//c5fTrBMdQm5Jg0H/gYggm1gNW29rMN9tOURXmwATexLxvN+DT8ku5BuDgOfDZBx/vU7AsNF+uGqF1lgfChmI93MT76McBUxF+sxl+IX9LxnG0TOMPr11p4T9xdzb8rAldhCUYvYhikdhBRaDEATOTXQg6vSMHMeQXEPcbv9bpo2hahSyy88IGUcb/DZ4HmVFo60TfpQ45FtUnHhL7rNKJ7p8PjAR4jkAjL9248z7XKE1b+RByel4X9wGLnNL912z00EvABPmN7V0UDplZa8RHZQH8WEU1Ls0qfceUfE8/0d+KR1+KLDwlzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DtSCHnFcdY1Yt6QhDsoGs4rwgmtIX8m3OXUtguGOlc=;
 b=KxhEDTsz9sKHiaBKLJeGmOCgKvBVWNm8ToKdkdpuQiUDMcYT1BiD8jKbS6iJk8Xye+DVOeNiDxeV/LBiCauE9jN0qQuNZWkiN4Hmf2ftL4IjjRneJ9T/N9pV3C8BHmsufVYWgTWJe3MBpla9fur+qXAMq2Q+t7azvwimldX5b3A=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 12:08:04 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 12:08:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Balakrishnan.S@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v5 2/8] ARM: dts: at91: sam9x60: move flexcom definitions
Thread-Topic: [PATCH v5 2/8] ARM: dts: at91: sam9x60: move flexcom definitions
Thread-Index: AQHZN8grrE84my+SfUyJ1nsb7nPNuQ==
Date:   Fri, 3 Feb 2023 12:08:04 +0000
Message-ID: <c714d161-7cda-8a9c-de05-692416e4d7af@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
 <20230203034833.451461-3-durai.manickamkr@microchip.com>
In-Reply-To: <20230203034833.451461-3-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|IA1PR11MB6148:EE_
x-ms-office365-filtering-correlation-id: 1ee8319b-fc04-4ad5-28cd-08db05df4d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjrOlfSiiGRCXfGD/GbcCKIM4lg2XZsTm//XmqFSLlBdt3p0O90EFn+nFxwp16PyAA1MuvNeH8HVZKRgJXhNeXH5pYHtdgtqQw0orq7iz8Uhe2wkZpsR5GjUUU19Yg3r53ixcj2RjMCjqOQ/LLRQriz6rcYNxs8yLV5iMI2NEtLHU/DEtfzxl35+dqjjRfPd7kdFanvMojO9FFdiomyS3BzHgjWkFpZBqmEp3KsA21jRFfx3trqc7oKxPQaEtIobRe5Hi8+U6nQFKsjy8VwtgW9nw/mzeAV6qSxXotz2JxmnpBXhHB/WzccX7YuQ9Fpgl6hYRnLVCVbOcWXnBoH6tX5HBJY100t6qIBUNtAZFMwydr8LaksigGywdkFxtI8Jaj/WQvIpFDMi06n+rQyr4HDM8Mxv+ngxZECoMKtm26CITwyev/V3pBoLRVqkqSERyCy5OXL4eMAUwXjaBMTRxXwx/HqrCvUyxue9xQz40TFGeXntPuw5RT6OQqaZwL9kUGCfJYpyPz4GIXDMILe3XAxFeVfYiQPvq2lsFpRDHs++dVs65GN8KzMVD5troAQnrR1E4bYMlfJiOGY9tUMvM6/EAp73n4i9vQ787dKFWpDpPmh/nK6r4wM6anI61SIeqgLpD4qwNBTi7qdw4YtI5GEmsRqDwx5NxtZ8PDbD7gMK0gQq5bik/mNjD8HYFdkaU2Vc7N64SrUNPjB7/CpbVl/Ns6wfFLQaBPFebZVbmfz0lUxfRDaNX0iB1WFA5MKqm89+OP3Y95urb2Nhy1h8EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(66946007)(76116006)(8676002)(6506007)(6636002)(6486002)(478600001)(26005)(110136005)(53546011)(6512007)(36756003)(316002)(186003)(5660300002)(86362001)(7416002)(2906002)(91956017)(41300700001)(66556008)(31696002)(66476007)(8936002)(64756008)(71200400001)(66446008)(2616005)(83380400001)(38070700005)(122000001)(921005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDNzbHNDMnNyMUNRMlUwUDhXN0dSOWwvcGl3Z1NqYUp1eTFYa2w0dkxYK1hj?=
 =?utf-8?B?a3hhMkNIUjlZbUZ1ODFxaFZjWnh0dy9MTjF3Wk0xRzNIUzZJWml0WmVYL2k4?=
 =?utf-8?B?ZjNkUkVjbkpYUGpvMUhqV1BLM2lGRUdYVWt0Z3JhVlZsN2wvc1d4WHU4RkFo?=
 =?utf-8?B?d0t0K3J6T1NPSTk0Y01VdjV4aUt6YzBqNFRBMVFnTzYyOHNwVmZ5ZHhXald6?=
 =?utf-8?B?OE92dDlnNDJCQ2VZa252NjI5R3RRSUl1OWhob2g3UzU3R1NRVFUzb0tocWg0?=
 =?utf-8?B?UWI5Tm8yUDBXM0tVUUpOSVBEVGFmZmNVeVdnenFUd0d6QXFZRDVLS2hJQmxT?=
 =?utf-8?B?YUg1Ulp0WUtGa0lTN3NOZE10NUl2bGhJMW82OFdDSVI1RDRkdVFZUlI5ellH?=
 =?utf-8?B?NXl5c2NSZEY0N0FWdFJpTVcwSUw3Wm96SWtsWWZnOFVFbmdaQXBEZUE1ODVS?=
 =?utf-8?B?ZUEvUjFwaHV3SEhFT1RXekVtL3JFcy9aa2ZES2tnNU9sSlY2cFNMV0xHTmFp?=
 =?utf-8?B?NFBzMENGdkc3cndtL0VHdUQxa1h5by9BcmtBbThxVmN3cnIzRFFIZHJ4UWwy?=
 =?utf-8?B?dEIraEJ0Ukk0cTgrVGNVMTRjNXhOSTluQ29kVUE2bTAwdEowNnp5TDc0N1Zl?=
 =?utf-8?B?NzUzS2U3c3lueUQrZzhDZXNLcHY0UG0yZGxaZnU0bGVkTzFhU2hRWkM2QkhH?=
 =?utf-8?B?UjZRMm5QQTB1T0Y4K1FINkxLSVVua3JCOGUyV1dZbEdxUUMrbU5XU1VUZWsw?=
 =?utf-8?B?NDB6WnVkaE9CYUd2YmgxZVhEOFRQMkpBc3VOd2R6c1k2TlhjMEg0YVBnd3F3?=
 =?utf-8?B?RWtSN2hWQ2huNnpaTEZVTXEzZDZyWklEV2FzSjcvelBFVlVab0dmZEI1T3hZ?=
 =?utf-8?B?NURKdnBMWHBET3BSY1VRR3VoOVpvaFFzNis3UnkrdDBYRVpDZHE1N0M3ZUxT?=
 =?utf-8?B?akduRXVHU2g2aWRwQXk3eWxtWHg5RXIrNWVSZ0k2UUo2ZzlSUDF0c21SOXB6?=
 =?utf-8?B?ZTQxVUs0aU9MeWRqbEFyNjVKc2U5ZnJNYnFjNjZpdEliZ3BWa24zR1R3ZDk5?=
 =?utf-8?B?aW8zZ3ArOFU1cnBsWFpoOXRoREovTk5oM240em5zcXRwWDJSR2VYam51emJS?=
 =?utf-8?B?UHdhdEhFeXROT09wQ2x1MHovRXZ6SG9yUjJYb0s3elhrYlJ5eHgzbUdROXhN?=
 =?utf-8?B?UXNKK3ZZUk9ZL2haSTU1bHlxU0RlUHovYjc5ME43RVkxZHczWHliOVBWK2pk?=
 =?utf-8?B?SlNyblFSdzN0REttV1B6czBmcjllTXdPTEZhcmFqN3JmQ3ExVmVyR2U2Znc2?=
 =?utf-8?B?RGxyRTdNNHcvZmhSdVdNbHpEeU10T2xqVEtrY1JQazdqakhJUmpiQnRRQitJ?=
 =?utf-8?B?U1RKb1F2L0puV1BPT2dTNVVlY2tEeUFRdEUzbzl0M0cwYWNiSklEanA5bWg1?=
 =?utf-8?B?cnRkNGk5U0NFOW05Qm1mb2czN0xPc096U2w4eU9mZlBsaXVneUY3OTBrYnBv?=
 =?utf-8?B?VUxjSU90cW5uTnI4ZGVuNXlIN3hiNW5oOTY5SkJHWHhMd0p2Ym82S3VjY0pM?=
 =?utf-8?B?UXZ3dmc4VDlzUVVaWkdobUR0eXhyMmo1U2lUajJxQVpzb2xLVWYzZUV2Y2l4?=
 =?utf-8?B?eEhhQWZQZWJtNlMyUU9vVnI3aDlNa0N6QWxPRXNncTZzYUFkS2JlUkFaNnYz?=
 =?utf-8?B?TkFkNjZ3ZEMyTFQvL05UdVY5WXBwQWNQS2MvY1pHdjV3UzFzVWR3OS93WHZz?=
 =?utf-8?B?NzhGOEhjRnBYUURTRWVFUkI0VEtLRjFpMjc2TWFHN2ZMYlJXcjdpRDFLdFFU?=
 =?utf-8?B?NmwyMi9YZGh3WjBjeE9mSEcrUG13cUNsWUhLNExhQ0FCV0EwYUN1ekZCTTBm?=
 =?utf-8?B?dFZzaTlkdjBRdzNnSXlzSWowMXNjdmtUZWx0dUlZbENzaDMvclVaM29XNVRP?=
 =?utf-8?B?RHFLN2RnaGxCVXJHaThVcE5JZTNPM2RMTlh5eWlRQ2dmS3RGeTA4MzBjL3c1?=
 =?utf-8?B?MkpXTld5N0NzYmwzNG80U21Sa0E2OTFYcUdVdnJseEhKOENLMS9xeXFJL3NY?=
 =?utf-8?B?aWxvV1pqOGFlN0hlZXZrbXFMclhpdm5SQjBqbFJqVWdWOEFXOVBkaWNaUkRT?=
 =?utf-8?B?L3ZBUDVNeTBHNGtOanZPekJLSC84MXRaejFIb3U5YXRNZ1YyK083R2k1OUZX?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA790E81389DFF439D319386130B2F82@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee8319b-fc04-4ad5-28cd-08db05df4d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 12:08:04.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p07JjTWRcUz5tFDUIxwbEjFDlpCqDCOeGzCYZsDBsO8MnWmLRM+UC5tIryJQV3sCIC930DLCYZg6QIVGS/IDSKJdrqhV5kslhy3QZDcDIQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6148
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDIuMjAyMyAwNTo0OCwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEZyb206IE1h
bmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gDQo+
IE1vdmUgdGhlIGZsZXhjb20gZGVmaW5pdGlvbnMgZnJvbSBib2FyZCBzcGVjaWZpYyBEVFMgZmls
ZQ0KPiB0byB0aGUgU29DIHNwZWNpZmljIERUU0kgZmlsZSBmb3Igc2FtOXg2MGVrLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gPG1hbmlrYW5kYW4ubUBtaWNy
b2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYXJpIFByYXNhdGggR3VqdWxhbiBFbGFuZ28g
PEhhcmkuUHJhc2F0aEdFQG1pY3JvY2hpcC5jb20+DQo+IFtkdXJhaS5tYW5pY2thbWtyQG1pY3Jv
Y2hpcC5jb206IExvZ2ljYWwgc3BsaXQtdXAgb2YgdGhpcyBwYXRjaCBhbmQgYWRkZWQNCj4gIG1p
c3NpbmcgVUFSVDUgY29tcGF0aWJsZXNdDQo+IFNpZ25lZC1vZmYtYnk6IER1cmFpIE1hbmlja2Ft
IEtSIDxkdXJhaS5tYW5pY2thbWtyQG1pY3JvY2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KQWxzbywga2VlcCB0
YWdzIG9uIG5leHQgdmVyc2lvbnMgeW91IHdpbGwgcG9zdC4NCg0KPiAtLS0NCj4gIGFyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVrLmR0cyB8IDMzICstLS0tLS0tLS0tLS0tLS0tLS0NCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSAgICAgICB8IDQ5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMzIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1z
YW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IGlu
ZGV4IGNmNWQ3ODY1MzFmMi4uNGZmODQ2MzNkZDQzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9i
b290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMDcsMTUgKzIwNywxMCBAQCAmZmx4MCB7DQo+ICAJc3Rh
dHVzID0gIm9rYXkiOw0KPiAgDQo+ICAJaTJjMDogaTJjQDYwMCB7DQo+IC0JCWNvbXBhdGlibGUg
PSAibWljcm9jaGlwLHNhbTl4NjAtaTJjIjsNCj4gLQkJcmVnID0gPDB4NjAwIDB4MjAwPjsNCj4g
LQkJaW50ZXJydXB0cyA9IDw1IElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICAJCSNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiAgCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gLQkJY2xvY2tzID0gPCZw
bWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA1PjsNCj4gIAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0
IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDBfZGVmYXVsdD47DQo+IC0JCWF0bWVs
LGZpZm8tc2l6ZSA9IDwxNj47DQo+ICAJCWkyYy1hbmFsb2ctZmlsdGVyOw0KPiAgCQlpMmMtZGln
aXRhbC1maWx0ZXI7DQo+ICAJCWkyYy1kaWdpdGFsLWZpbHRlci13aWR0aC1ucyA9IDwzNT47DQo+
IEBAIC0yMzUsMTQgKzIzMCw4IEBAICZmbHg0IHsNCj4gIAlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiAgDQo+ICAJc3BpNDogc3BpQDQwMCB7DQo+IC0JCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNh
bTl4NjAtc3BpIiwgImF0bWVsLGF0OTFybTkyMDAtc3BpIjsNCj4gLQkJcmVnID0gPDB4NDAwIDB4
MjAwPjsNCj4gLQkJaW50ZXJydXB0cyA9IDwxMyBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAt
CQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDEzPjsNCj4gLQkJY2xvY2stbmFt
ZXMgPSAic3BpX2NsayI7DQo+ICAJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAJCXBp
bmN0cmwtMCA9IDwmcGluY3RybF9mbHg0X2RlZmF1bHQ+Ow0KPiAtCQlhdG1lbCxmaWZvLXNpemUg
PSA8MTY+Ow0KPiAgCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJI3NpemUtY2VsbHMgPSA8
MD47DQo+ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IEBAIC0yNTQsMjMgKzI0Myw4IEBAICZm
bHg1IHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICANCj4gIAl1YXJ0NTogc2VyaWFsQDIwMCB7
DQo+IC0JCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtZGJndSIsICJtaWNyb2NoaXAs
c2FtOXg2MC11c2FydCIsICJhdG1lbCxhdDkxc2FtOTI2MC1kYmd1IiwgImF0bWVsLGF0OTFzYW05
MjYwLXVzYXJ0IjsNCj4gLQkJcmVnID0gPDB4MjAwIDB4MjAwPjsNCj4gLQkJYXRtZWwsdXNhcnQt
bW9kZSA9IDxBVDkxX1VTQVJUX01PREVfU0VSSUFMPjsNCj4gLQkJaW50ZXJydXB0cyA9IDwxNCBJ
UlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAtCQlkbWFzID0gPCZkbWEwDQo+IC0JCQkoQVQ5MV9Y
RE1BQ19EVF9NRU1fSUYoMCkgfCBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+IC0JCQkgQVQ5
MV9YRE1BQ19EVF9QRVJJRCgxMCkpPiwNCj4gLQkJICAgICAgIDwmZG1hMA0KPiAtCQkJKEFUOTFf
WERNQUNfRFRfTUVNX0lGKDApIHwgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiAtCQkJIEFU
OTFfWERNQUNfRFRfUEVSSUQoMTEpKT47DQo+IC0JCWRtYS1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+
IC0JCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgMTQ+Ow0KPiAtCQljbG9jay1u
YW1lcyA9ICJ1c2FydCI7DQo+IC0JCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbHg1X2RlZmF1bHQ+
Ow0KPiAgCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAtCQlhdG1lbCx1c2UtZG1hLXJ4
Ow0KPiAtCQlhdG1lbCx1c2UtZG1hLXR4Ow0KPiArCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4
NV9kZWZhdWx0PjsNCj4gIAkJc3RhdHVzID0gIm9rYXkiOw0KPiAgCX07DQo+ICB9Ow0KPiBAQCAt
MjgwLDE1ICsyNTQsMTAgQEAgJmZseDYgew0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIA0KPiAg
CWkyYzY6IGkyY0A2MDAgew0KPiAtCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWky
YyI7DQo+IC0JCXJlZyA9IDwweDYwMCAweDIwMD47DQo+IC0JCWludGVycnVwdHMgPSA8OSBJUlFf
VFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAgCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJI3Np
emUtY2VsbHMgPSA8MD47DQo+IC0JCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwg
OT47DQo+ICAJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAJCXBpbmN0cmwtMCA9IDwm
cGluY3RybF9mbHg2X2RlZmF1bHQ+Ow0KPiAtCQlhdG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiAg
CQlpMmMtYW5hbG9nLWZpbHRlcjsNCj4gIAkJaTJjLWRpZ2l0YWwtZmlsdGVyOw0KPiAgCQlpMmMt
ZGlnaXRhbC1maWx0ZXItd2lkdGgtbnMgPSA8MzU+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvc2FtOXg2MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+
IGluZGV4IDhmNTQ3N2UzMDdkZC4uZWU2Y2M0MzI5YWU0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9zYW05eDYwLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2
MC5kdHNpDQo+IEBAIC0xNzAsNiArMTcwLDE2IEBAIGZseDQ6IGZsZXhjb21AZjAwMDAwMDAgew0K
PiAgCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJCXJhbmdlcyA9IDwweDAgMHhmMDAwMDAw
MCAweDgwMD47DQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArCQkJCXNwaTQ6
IHNwaUA0MDAgew0KPiArCQkJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLXNwaSIs
ICJhdG1lbCxhdDkxcm05MjAwLXNwaSI7DQo+ICsJCQkJCXJlZyA9IDwweDQwMCAweDIwMD47DQo+
ICsJCQkJCWludGVycnVwdHMgPSA8MTMgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gKwkJCQkJ
Y2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCAxMz47DQo+ICsJCQkJCWNsb2NrLW5h
bWVzID0gInNwaV9jbGsiOw0KPiArCQkJCQlhdG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiArCQkJ
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQkJCX07DQo+ICAJCQl9Ow0KPiAgDQo+ICAJCQlm
bHg1OiBmbGV4Y29tQGYwMDA0MDAwIHsNCj4gQEAgLTE4MCw2ICsxOTAsMjcgQEAgZmx4NTogZmxl
eGNvbUBmMDAwNDAwMCB7DQo+ICAJCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICAJCQkJcmFuZ2Vz
ID0gPDB4MCAweGYwMDA0MDAwIDB4ODAwPjsNCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiArDQo+ICsJCQkJdWFydDU6IHNlcmlhbEAyMDAgew0KPiArCQkJCQljb21wYXRpYmxlID0gIm1p
Y3JvY2hpcCxzYW05eDYwLWRiZ3UiLCAibWljcm9jaGlwLHNhbTl4NjAtdXNhcnQiLCAiYXRtZWws
YXQ5MXNhbTkyNjAtZGJndSIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCI7DQo+ICsJCQkJCXJl
ZyA9IDwweDIwMCAweDIwMD47DQo+ICsJCQkJCWF0bWVsLHVzYXJ0LW1vZGUgPSA8QVQ5MV9VU0FS
VF9NT0RFX1NFUklBTD47DQo+ICsJCQkJCWludGVycnVwdHMgPSA8MTQgSVJRX1RZUEVfTEVWRUxf
SElHSCA3PjsNCj4gKwkJCQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNfRFRf
TUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJ
CQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMCkpPiwNCj4gKwkJCQkJCTwmZG1hMA0KPiArCQkJCQkJ
KEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9J
RigxKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMSkpPjsNCj4gKwkJCQkJZG1h
LW5hbWVzID0gInR4IiwgInJ4IjsNCj4gKwkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVS
SVBIRVJBTCAxND47DQo+ICsJCQkJCWNsb2NrLW5hbWVzID0gInVzYXJ0IjsNCj4gKwkJCQkJYXRt
ZWwsdXNlLWRtYS1yeDsNCj4gKwkJCQkJYXRtZWwsdXNlLWRtYS10eDsNCj4gKwkJCQkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJZG1hMDogZG1h
LWNvbnRyb2xsZXJAZjAwMDgwMDAgew0KPiBAQCAtMzc5LDYgKzQxMCwxNSBAQCBmbHg2OiBmbGV4
Y29tQGY4MDEwMDAwIHsNCj4gIAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCQlyYW5nZXMg
PSA8MHgwIDB4ZjgwMTAwMDAgMHg4MDA+Ow0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ICsNCj4gKwkJCQlpMmM2OiBpMmNANjAwIHsNCj4gKwkJCQkJY29tcGF0aWJsZSA9ICJtaWNyb2No
aXAsc2FtOXg2MC1pMmMiOw0KPiArCQkJCQlyZWcgPSA8MHg2MDAgMHgyMDA+Ow0KPiArCQkJCQlp
bnRlcnJ1cHRzID0gPDkgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gKwkJCQkJY2xvY2tzID0g
PCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA5PjsNCj4gKwkJCQkJYXRtZWwsZmlmby1zaXplID0g
PDE2PjsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsN
Cj4gIA0KPiAgCQkJZmx4NzogZmxleGNvbUBmODAxNDAwMCB7DQo+IEBAIC00MDksNiArNDQ5LDE1
IEBAIGZseDA6IGZsZXhjb21AZjgwMWMwMDAgew0KPiAgCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0K
PiAgCQkJCXJhbmdlcyA9IDwweDAgMHhmODAxYzAwMCAweDgwMD47DQo+ICAJCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gKw0KPiArCQkJCWkyYzA6IGkyY0A2MDAgew0KPiArCQkJCQljb21wYXRp
YmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWkyYyI7DQo+ICsJCQkJCXJlZyA9IDwweDYwMCAweDIw
MD47DQo+ICsJCQkJCWludGVycnVwdHMgPSA8NSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAr
CQkJCQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDU+Ow0KPiArCQkJCQlhdG1l
bCxmaWZvLXNpemUgPSA8MTY+Ow0KPiArCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQkJ
CX07DQo+ICAJCQl9Ow0KPiAgDQo+ICAJCQlmbHgxOiBmbGV4Y29tQGY4MDIwMDAwIHsNCg0K
