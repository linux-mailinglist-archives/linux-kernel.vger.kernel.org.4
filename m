Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381DE69A794
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBQI5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQI5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:57:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F84233;
        Fri, 17 Feb 2023 00:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676624261; x=1708160261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vv5W5juNealk9We1X4z3SYce19g8u9qUsFg4qcMKnT0=;
  b=dJpf3DrkFZOLAo4J82eau6Hnvo9Mk/mstFUTadcGNhlDVg0jLNTrjM15
   075mIfOoGqFy83jKJNXpWR8RB5gIyOlNs5EEo6S43PrSz/oQfmY9R0dHo
   pB/po6cFyjNRoJpbI3cCD9tVqwMj0lOYFJjJWPkFUdCP7Gvgyi5ToSjzM
   KT9R96MEvhNnhM0YKyB9YjctuRUkcxwOavnSkd8zxjIAve/LWh4EZwni5
   JYDwd3F+ijeBnFHMxhpNqHsgCMWp46hpJ/Bo8YWoERaeWJ8HoSjqahcy7
   2yAzZxcDtoTzBwbLL9yki58xO1NgsIvz1Eu15IT8v2k4NQJleP80F/Knp
   w==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="201085204"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 01:57:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 01:57:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 01:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+T2miRGqG+ryYfMofI+FsNWKSfW3Z/Ki4j2MfHu2cXEV4MxpeSN30GXw3udOvQSxSo1M/VNIJhJ7iN8+IYRk3O8ztna4y0QoMpQTYv3j+9jM5B30toscPSoknUIdVde9NDxbfXBt51q8tgIo2Y3pBME9NqAAhWU2reIwOR5Cevn7GZO57WgAX/3NGIm9SmKPm+XNy4VbGe6opTzT+YhP9X1wl5K1pIkzhInKXMY8e4nn069t/lMce2D9N63xDQmNM7jdAFrWbT3HX3Zmnj+nCoDmrINXdhXWWAEJ3l5Wqt2EG8YljDjUPaiUu6pFL2edpDB+8NWNwOws/PAvImcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv5W5juNealk9We1X4z3SYce19g8u9qUsFg4qcMKnT0=;
 b=cFcZ/70PBKd0WXsvlxb99W80BTi8MM73+7/xAcaOwkoTHkOkK6nvI+iXgDMB1ox7P1ae1/bT54Q7rC/A6ck53UoZpvjSixzfi+L6PEGKwJ0HDKT5bUt2VJBryXezpu5yjgQXkaEAWCmM+SXQPhGh4hdYBlq/sIY55Rf81FOgLe40GLnrE/Eeg/vNaYFRTrvVaYTtu9amhSDtkZF7eMdhrQyU8U/0c7viZGguvDUM13EbJ5cyOevpzVZK+iQ2oVQ8q/7OrCcdrNYEBvLg3GamvRO1cc0okbKCUgL+MjHyWfqNr+Goif4W7xuzm12weRfMhFGXYmtMIA7HOjzAsMnoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv5W5juNealk9We1X4z3SYce19g8u9qUsFg4qcMKnT0=;
 b=fZVRFqQBPjVLtIw1DN3Ihg6ZJIV67I30Z3UrftUjOYUKnAoLMQl3qWMWswWPrS7kyk+9Y9JcShqtfa54pcjrhPizTqrfdIQdeWHDfBPhidfVCpC32D31uhxh+Tjy86wnqvcd+v4PeNIbT/XCCIgguHtiC+r4bdaAdZ6L0q1dEi4=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 08:57:33 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::df96:2404:8ae1:8b9c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::df96:2404:8ae1:8b9c%6]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 08:57:32 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <linux-gpio@vger.kernel.org>,
        <michael@walle.cc>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>, <arnd@arndb.de>
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5vK269zMPJUW175op5Ze6367OH1cAgAFGAaCAAEoeAIAACswAgAAHKBCAAAiScIAAHpeAgAFb50CAADe8gIABYnaA
Date:   Fri, 17 Feb 2023 08:57:32 +0000
Message-ID: <b8663c30e7b46955c5da4794919acf5f518aae52.camel@microchip.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
         <20230214082804.2761756-1-michael@walle.cc>
         <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
         <7276bef47792e489abd093e4bd0044de@walle.cc> <Y+yeyNCA48IbKOKC@kroah.com>
         <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
         <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
         <Y+zFo4SP5L/KkT/v@kroah.com>
         <BN8PR11MB3668C37EFBB42FB3FFC7618FE9A09@BN8PR11MB3668.namprd11.prod.outlook.com>
         <Y+4YO7HSmETanIU2@kroah.com>
In-Reply-To: <Y+4YO7HSmETanIU2@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|PH0PR11MB5173:EE_
x-ms-office365-filtering-correlation-id: bcde58f6-211e-4249-9016-08db10c50181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvXrqwXBDD9PzXIUdcPZUFnJ/WV+A52ogPqahTjq1whWux0pvCWA6pdx0d8Us9eSl83QaqX5ftckzr4yzdrjOi5cR3Hj0a5HdKJSylGH3ChqZ372ckAuczO7QJm60J4UMty8KSPXfpR43Q65MNW7itueCoDEjDpzA2yT6P1S6dXIEKFRWWRx3rJDkLSMQqPrL0q3iAFM9nwaJvPH4O19n5DGrhtgiNHzRBXPXKMJbRW6eSH7832gaFxWh0voehTlwloumZ2f+ZgP7CJd6MieV55P3YurX10bm54A/8bRX1RyZ36FeiMgED05chyugnxH2U9ZyR2thA64H7QMTDVszhLKzVsMioujiCgan313V/WSDbIqIksQJYq1ygfNB1sjRDG/Qx5Rrp5AOqm6ydXdl4wEVe8Zp0zAPDEsOOmj7eWBJnjMP0wKeYnCRu0CvBLz0djR6njWJ6/kYwZCj0D3BjQHrb3N2Ja+S41bHE5MiEzR/rDAQKURoFg9IWlqEZTucul7oYNRmDxtFxa/OTGxBVYvJEsOqe4z+F0tFsY6/HXGfRqGOliRsUFPUxbOMuQBlNz/CiL9Aj4V0NgvHggs3RVYZXWsG+aR+8Pcr8JhOoqaLBf+1XAfVw9ARX/JRM6jZrbSgFCy93eTHxmvRc+3cdSJ6kTaDqAwaC4mIWEpH4I3ZDAv/NkZ8b53FWhQCpDe6EM7/a3sDCUfuDe6Llu6Z6SFCM/z67AdDBbnArc1XLE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199018)(316002)(54906003)(66476007)(76116006)(6916009)(4326008)(66946007)(91956017)(64756008)(66556008)(66446008)(38100700002)(122000001)(8676002)(38070700005)(5660300002)(36756003)(86362001)(8936002)(41300700001)(6512007)(26005)(6506007)(186003)(6486002)(478600001)(2906002)(2616005)(83380400001)(71200400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ly80L2x3cWVtYzMvL0x3RUtNTTMveExQY2kydzE4V3ltWXZ0bk5sZjJLRGZi?=
 =?utf-8?B?U05WWXZEeTFiaXFCTzlGSVpCV3NBelNEQURTemQ4dlVEQTY5ckdKMDZyd2JX?=
 =?utf-8?B?SEg4TjVkbDBVaWpUV3FjOHZScFhpMy93S2FyT0k4VzNiUFRIN1FvK1pveW54?=
 =?utf-8?B?QVBhUHBSdVgyUUJOcEJvQ0dIUUR4ZXBDY3JTWUJDR3lTTFUzazR0RjVvSlQ4?=
 =?utf-8?B?aWw1VDlXY1czcVRkTU9IcGQ1cGliaHdxNnltZTdQRmgxNVNLZENkTEZQY1Bp?=
 =?utf-8?B?RDZLbGxUVkszTHd6MGlPUVlCdE1sNUZBTlpJWlU5RXZTYm44cUJnb0pBSGsv?=
 =?utf-8?B?K1V1TE1lNzN1OEk2SU8zSlpQUkIyZElycWZ4YXlRNmJia0kvZHB5RHcvcVZx?=
 =?utf-8?B?aDZLTDRKWWlRT3VjRmIxN1RiZjZycWNBdC9TODc1Y2w5R2FsU20yS0pCVzZE?=
 =?utf-8?B?QlVpeUFBcE45a1FjNlNjRXR4MnBtYU9sdkh4eGVKcUJoZzNtc0RoaGRHVkJO?=
 =?utf-8?B?dDJldjhpT2pjN1VJS0hqMFR6M0NINC9zcjBNQ3VCbDQwMVpjSWtnWW5hSGpV?=
 =?utf-8?B?NFpYUlE5L0J4RTBrNUlrdFNEVWtZRlRPWFRmRHJLRkNyRGhva1AzU1pSWjdQ?=
 =?utf-8?B?T0Fxa2xYbWZqVXJvMWNJWkxUanVGaE11Um1CWnh4eUhpUXNUK1Q3VmRjL2tv?=
 =?utf-8?B?SGF1Z3BHbmF3OFZjaEpiWi9oQng4ZVNGdTV1aG1haU9nNE9GUkY2Mi9Pb3RB?=
 =?utf-8?B?V05SRmR6QjRsVlMyMHVLV1RWTmpUNy9FVEtuWEs3NGE5ZTRyRER2RStLNENM?=
 =?utf-8?B?Q3ErSmZaZDROaVhJZVFxOGY5ZHhLbUJ3TWZVZzVhb244Rll0VjYyNkphSTl2?=
 =?utf-8?B?M2wvS0VHbEZ6Q0VQR0VoK1o1Q3hTaW80bytGeXdQY25EbDdUVkgveGVndndR?=
 =?utf-8?B?ZFRRbnEramFETUFoTVVVN2lIb29qT2xTaGJWNDcrbkdvYmhOV1VYcFBPcUJN?=
 =?utf-8?B?UlpXRkdXdTdaUlRqODJzaGg4MlU0UzcxazFNNlFsendRZGM4ZW9uTHRFY25O?=
 =?utf-8?B?bUhFT3lCS2JsRkJvREx6MmNMWXhpYWYzRmJDS1l4bmxSWW5EQWJFeERTWkNL?=
 =?utf-8?B?VTk1bDFweG92QnRCL2VVRCtkOVNVQytieG8rSk9xZno1VXlSZXpWT2RqbFJp?=
 =?utf-8?B?NWdaNWZkcUZSU2ozRE5CczNsdVNVTSs5bjVHSE02TmVKamt3K1pQanR1bTNx?=
 =?utf-8?B?aHo3cjNmVzZXdlhZNFZrR2tlVWY0akVrSDhCTVR3ZFZSTzRGTy9pbHQzN3Nv?=
 =?utf-8?B?UEY0alpWekxsTTVGS1RvU2x0ZWQ2ME5uRnI5MkNkTWtSZ1hlNnBIQW5GZTRE?=
 =?utf-8?B?L1NVc0t6bjBaQzU5SDBwWmcvSU4vOFloLzVIQjVucWMzUHZvTndNN1Z2VGpT?=
 =?utf-8?B?S1orNExLZ2x4dy9wR0xIaTBMdlJTa3IvYnpWSGtZZThuZjd0UzUrcCtIZXRR?=
 =?utf-8?B?MG0xektHSFZrM2tIaTU2dStHNWIxMTFwV2htNUJQT0JZUGFrdjY5YVFBVVZr?=
 =?utf-8?B?OGI3N3dnTmF0NkJCUFIrZTJ3L1I2L2Z0bnFKRU5wQmtETmFPMkFNM2hEcjJ2?=
 =?utf-8?B?Wjd4eVNHUWlsMGx6UHlXNU5VRVUwMUJZblVuc2lzc2RaMGpuYXg0dEtoNzBj?=
 =?utf-8?B?cDJGdzA4aHRqN1Y2dk1hVmZtK3JIWUk3RkppRlBzUmtWZ3Q2cUMwLzEyUG95?=
 =?utf-8?B?S2dubkZGL25nckZhN01IM0JuU1plbjB2S1Mya0R5LzFiekdlVW4ramk2Nmhr?=
 =?utf-8?B?ZTF0eHl5bDh4TEY5Y0Nmc3RxMUpKZis3UnNQRTREVWJ6US9xaHZDcngzN3Z3?=
 =?utf-8?B?Wi82QSt6MElTcldzbHdlVVFhOWNGNUpJS3ZocEgwTFV6Z3A5dUptSWxNWXJI?=
 =?utf-8?B?ZExIMnRIa0NjWWJWR2FDcFpQeittV2pCTWpuYzNkbGU2SHZMUGJxNlJzd0pO?=
 =?utf-8?B?QmdjN0tmYytqTUFyVURhckllRDlrNkJIV1owZldRSDcxOS9Vclh6TDA3amQz?=
 =?utf-8?B?RkR3ZXY3NTJERTdvL1hsd1hEV1haVmdqT3Z5NWNwckl4dytNVkYrbGhmYXFB?=
 =?utf-8?B?STd6UU1ORWh5K1RRK3phVU9ad2hYd0lwMFJJaFIrNkozNzJyd1A5Y1dpYWdC?=
 =?utf-8?Q?HPKCUD93AxwtlhnPoisY9+g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71370E9C2E8D044894C3BBCFBA98B80F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcde58f6-211e-4249-9016-08db10c50181
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 08:57:32.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DInhZ/i2I387sj/GdpaGojHVkmTItU2tBHlNka4zltih5DrK2UspRGZSpCh/QpC8TGeN+w/o4J0Ai54YDaGAer3YEEFXEHu3l42KhnnSFNPXttgkkZqCSgycYBzbtjDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTE2IGF0IDEyOjQ5ICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4g
PiA+IEdyZWcgJiBNaWNoYWVsLCBJIGRvIG5vdCB3YW50IHRvIGV4cG9zZSB0aGUgZW50aXJlIG9y
IGV2ZW4NCj4gPiA+ID4gPiBwYXJ0aWFsDQo+ID4gPiA+ID4gc2V0IG9mIGRldmljZSByZWdpc3Rl
cnMgdG8gdGhlIHVzZXIgc3BhY2UgYWNjZXNzIGRpcmVjdGx5IGZvcg0KPiA+ID4gPiA+IHNhZmV0
eQ0KPiA+ID4gcmVhc29ucy4NCj4gPiA+IA0KPiA+ID4gQnV0IHRoYXQncyBhbGwgZXhwb3NlZCBo
ZXJlIHRocm91Z2ggdGhpcyBibG9jayBkZXZpY2UsIHJpZ2h0Pw0KPiA+IFRoZSBibG9jayBkZXZp
Y2UgY3JlYXRlZCBieSB0aGlzIGRyaXZlciBkb2VzIG5vdCBleHBvc2UgdGhlIGRldmljZQ0KPiA+
IHJlZ2lzdGVycyB0byB0aGUgdXNlciBzcGFjZSBhcHBsaWNhdGlvbnMuDQo+IA0KPiBXaGF0IGlz
IGl0IGV4cG9zaW5nPw0KVGhlIGRldmljZSdzIE9UUCBhbmQgRUVQUk9NIGFyZSBub3QgZGlyZWN0
bHkgbWFwcGVkIGludG8gdGhlDQpwcm9jZXNzb3IncyBhZGRyZXNzIHNwYWNlIHVzaW5nIFBDSWUn
cyBCQVIgcmVnaXN0ZXJzLg0KVGhlcmUgaXMgYSBPVFAgY29udHJvbGxlciBhbmQgRUVQUk9NIGNv
bnRyb2xsZXIgaW4gdGhlIGRldmljZSBhbmQgdGhlDQpyZWdpc3RlcnMgb2YgdGhlc2UgY29udHJv
bGxlcnMgYXJlIG1hcHBlZCBpbnRvIHRoZSBwcm9jZXNzb3IncyBhZGRyZXNzDQpzcGFjZSBhbG9u
ZyB3aXRoIG90aGVyIHJlZ2lzdGVycyB1c2luZyB0aGUgQkFSIHJlZ2lzdGVycy4NCk9UUC9FRVBS
T00gZHJpdmVyIG1hcHMgdGhlc2UgcmVnaXN0ZXJzIGludG8ga2VybmVsJ3MgdmlydHVhbCBzcGFj
ZQ0KdXNpbmcgZGV2bV9pb3JlbWFwIGFuZCBhY2NvbXBsaXNoZXMgdGhlIHJlYWRzIGFuZCB3cml0
ZXMgYnkgYWNjZXNzaW5nDQp0aGVzZSByZWdpc3RlcnMuIFRvIHRoZSB1c2VyIHNpZGUsIHRoZSBk
cml2ZXIgc2hvd3MgdHdvIHNlcGFyYXRlIGRpc2tzDQoob25lIGZvciBPVFAgYW5kIG9uZSBmb3Ig
RUVQUk9NKSBhbmQgYm90aCBvZiB0aGVtIGNvdWxkIGJlIHByb2dyYW1tZWQNCnVzaW5nIHRoZSAi
bGludXggZGQiIGNvbW1hbmQgd2l0aCAib2ZsYWc9ZGlyZWN0IiBvcHRpb24uDQpUaGUgZHJpdmVy
IGhhbmRsZXMgdGhlIElPIHJlcXVlc3RzIHRoYXQgb3JpZ2luYXRlIG91dCBvZiB0aGUgZGQgY29t
bWFuZA0KYW5kIHRoaXMgd2F5IHdlIHdvdWxkIG5vdCBuZWVkIGEgc2VwYXJhdGUgdXNlciBzcGFj
ZSBwcm9ncmFtIGFsc28uDQoNCj4gDQo+IA0KPiA+IFRoZSBkZXZpY2UgaGFyZHdhcmUgcHJvdmlk
ZXMgc2VwYXJhdGUgc2V0IG9mIHJlZ2lzdGVycyB0byByZWFkIGFuZA0KPiA+IHdyaXRlIGludG8g
dGhlIE9UUCBtZW1vcnkgYW5kIEVFUFJPTS4NCj4gPiBUaGUgZHJpdmVyIHVzZXMgdGhlc2UgaGFy
ZHdhcmUgcmVnaXN0ZXJzIGFuZCBhYnN0cmFjdHMgdGhlDQo+ID4gcHJvZ3JhbW1pbmcgbG9naWMg
aW5zaWRlIGFuZCBleHBvc2VzIHRoZSBvbmx5IHRoZSBtZW1vcnkgYXMgZGV2aWNlcw0KPiA+IHRv
IHRoZSB1c2VyIHNwYWNlLg0KPiANCj4gV2hhdCBtZW1vcnkgaXMgYmVpbmcgZXhwb3NlZD/CoCBB
bmQgaG93Pw0KSSB0aGluayBleHBvc2luZyBpcyBhIHdyb25nIHdvcmQuDQpPVFAgYW5kIEVFUFJP
TSBtZW1vcmllcyBpbiB0aGUgZGV2aWNlIGFyZSBlbnVtZXJhdGVkIGFzIHR3byBzZXBhcmF0ZQ0K
YmxvY2sgZGV2aWNlcy4NCj4gDQo+ID4gSSBkb24ndCBoYXZlIGFueSB1c2VyIHByb2dyYW0gdG8g
cHJvZ3JhbSB0aGUgZGV2aWNlLiBJIHVzZSB0aGUNCj4gPiBMaW51eCBkZCBjb21tYW5kIG9ubHku
DQo+ID4gSWYgSSB3YW50IHRvIHZpZXcgdGhlIGNvbnRlbnRzIG9mIHRoZSBtZW1vcnksIEkgY2Fu
IHVzZSBhbnkgaGV4DQo+ID4gZWRpdG9yIHRvb2wgaW4gTGludXggdGhpcyB3YXkuDQo+IA0KPiBF
eHBvc2luZyB0aGUgbWVtb3J5IG9mIGEgZGV2aWNlIGFzIGEgYmxvY2sgZGV2aWNlIGlzIG5vdCBu
b3JtYWwsIGl0DQo+IHNob3VsZCBqdXN0IGJlIG1tYXBwZWQsIHJpZ2h0Pw0KVGhpcyBQQ0llIGRl
dmljZSBvbmx5IG1hcHMgdGhlIE9UUCBjb250cm9sbGVyIHJlZ2lzdGVycyBhbmQgdGhlIEVFUFJP
TQ0KY29udHJvbGxlciByZWdpc3RlcnMgaW50byB0aGUgYWRkcmVzcyBzcGFjZSBvZiB0aGUgcHJv
Y2Vzc29yIGFuZCB0aGUNCmFjdHVhbCBPVFAgYW5kIEVFUFJPTSBtZW1vcmllcyB0aGVtc2VsdmVz
IGFyZSBub3QgbWFwcGVkLiBIZW5jZSBJDQplbnVtZXJhdGVkIHRoZSBPVFAgYW5kIEVFUFJPTSBh
cyBibG9jayBkZXZpY2VzIGFuZCBoYW5kbGVkIHRoZSBJTyBmb3INCnRoZW0gaW4gdGhlIGRyaXZl
ci4NCj4gDQo+ID4gPiBBbmQgdGhpcyBpcyBhbHJlYWR5IGV4cG9zZWQgdG8gdXNlcnNwYWNlIHRv
ZGF5LCBubyBuZWVkIHRvIGFkZA0KPiA+ID4gYW55dGhpbmcgdGhlDQo+ID4gPiBrZXJuZWwgYWxy
ZWFkeSBwcm92aWRlcyB0aGlzLg0KPiA+IENhbiB5b3UgZXhwbGFpbiB0aGlzPyBBcmUgeW91IHJl
ZmVycmluZyB0byBhbnkgc3lzZnMgZGlyZWN0b3JpZXMgLw0KPiA+IGZpbGVzPyBXaGF0IGlzIHRo
ZSBuZWNlc3NpdHkgdG8gZG8gdGhpcz8gSSBhbSB0cnlpbmcgdG8gdW5kZXJzdGFuZA0KPiA+IHRo
aXMuDQo+IA0KPiBQQ0kgZGV2aWNlIGFjY2Vzc2VzIGNhbiBnbyB0aHJvdWdoIHVzZXJzcGFjZSBk
aXJlY3RseS7CoCBJcyB0aGlzIGp1c3QNCj4gbWVtb3J5IG1hcHBlZCBpbiB5b3VyIFBDSSBkZXZp
Y2U/DQpPdXIgZGV2aWNlIG1hcHMgb25seSB0aGUgT1RQIGNvbnRyb2xsZXIgcmVnaXN0ZXJzIGFu
ZCBFRVBST00gY29udHJvbGxlcg0KcmVnaXN0ZXJzIGludG8gdGhlIHByb2Nlc3NvcidzIGFkZHJl
c3Mgc3BhY2UuDQo+IA0KPiA+IElmIHRoaXMgaXMgZm9yIGFueSBkZWJ1ZyBwdXJwb3NlIGFuZCB3
aGV0aGVyIGtlcm5lbCBkb2VzIHRoaXMgdW5kZXINCj4gPiBzb21lIGNvbmRpdGlvbmFsIGNvbXBp
bGF0aW9uIG9yIGlzIHRoYXQgdGhlIGRlZmF1bHQgYmVoYXZpb3I/DQo+IA0KPiBJcyB0aGlzIG9u
bHkgZm9yIGRlYnVnZ2luZz/CoCBJZiBzbywgcGxlYXNlIGRvY3VtZW50IGl0IGFzIHN1Y2ggc28N
Cj4gdGhhdA0KPiBubyBvbmUgYWNjaWRlbnRhbGx5IGVuYWJsZXMgaXQgYXMgYSB2YWxpZCBidWls
ZCBvcHRpb24uDQpJIHRob3VnaHQgeW91IGFyZSBtZW50aW9uaW5nIGFib3V0IC9kZXYvbWVtIGFu
ZCB3YXMgYXNraW5nIHdoeSBrZXJuZWwNCm1hcHMgdGhlIG1lbW9yeSBhbmQgZGV2aWNlIHJlZ2lz
dGVycyBpbnRvIC9kZXYvbWVtLg0KPiANCj4gPiBFdmVuIGlmIHRoZSB1c2VyIGlzIGEgc3VwZXIg
dXNlciwgc2hvdWxkIGhlIGJlIGFsbG93ZWQgdG8gYWNjZXNzDQo+ID4gdGhlIGRldmljZSBoYXJk
d2FyZSByZWdpc3RlcnMgbWFuZGF0b3JpbHkuIEl0IHNob3VsZCBkZXBlbmQgb24gdGhlDQo+ID4g
cG9saWN5IHRoZSBzeXN0ZW0gb3duZXIgd2FudCB0byBhZG9wdC4gUmlnaHQ/DQo+IA0KPiBBZ2Fp
biwgaXMgdGhpcyBQQ0kgbWVtb3J5IHRoYXQgY2FuIGJlIGFjY2Vzc2VkIGRpcmVjdGx5Pw0KT1RQ
IGFuZCB0aGUgRUVQUk9NIG1lbW9yaWVzIG9mIHRoZSBkZXZpY2UgYXJlIG5vdCBkaXJlY3RseSBt
YXBwZWQgaW50bw0KdGhlIHByb2Nlc3NvciBhZGRyZXNzIHNwYWNlIGFuZCBvbmx5IHRoZWlyIGNv
bnRyb2xsZXIgaW50ZXJmYWNlDQpyZWdpc3RlcnMgYXJlIG1hcHBlZC4NCj4gDQo+IEFuZCBhZ2Fp
biwgYSBibG9jayBkZXZpY2UgaXMgdmVyeSBvZGQsIHRoYXQgaXMgbm90IHRoZSBub3JtYWwgd2F5
IHRvDQo+IGFjY2VzcyBhIGRldmljZSdzIG1lbW9yeS4NCkkgd2FudGVkIHRvIHVzZSBkZCBjb21t
YW5kIHRvIHByb2dyYW0gYW5kIGFueSBiaW5hcnkgZWRpdG9yIHRvIHZpZXcgdGhlDQpPVFAgYW5k
IEVFUFJPTSBtZW1vcmllcyBpbiB0aGUgZGV2aWNlIGFuZCBJIHdhcyBhYmxlIHRvIGFjY29tcGxp
c2ggdGhhdA0Kd2l0aCB0aGlzIHNvbHV0aW9uLg0KPiANCj4gVGhhbmsgWW91Lg0KDQoNClJlZ2Fy
ZHMsDQpLdW1hcg0KDQo=
