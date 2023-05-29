Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237D8714983
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjE2Mc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2Mcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:32:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C9C2;
        Mon, 29 May 2023 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685363572; x=1716899572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HB4gxScIGd9IqnHH1fVNuL9PNql0WMEdkqbYeAzvGLM=;
  b=o/nLVkj496mXTo7exiLfBA8hPxwxdZ5ezxI8FGnGqGOqBq4buTQlzJ6P
   ehQw8A6dq8D7ZNouuQt8rwFcqpo2UetO/FjnsMyWeZ3ORfkgZvy7fKAL1
   nUwFBWqmksntp5YCPwM9Y0IJHGUVFAZnS+Z10SzwFAGMtZcuVn9sDYRF8
   4H6mCCdTY63BwFb3XOWCaNHqfQb8+Go2F2CvKwkjEUwF5YDNbUcRxhzvF
   4Qpc2c3FUbeX/9aQvc/Ni40JI7LeYdVU3xXUpOKlvQx9fR+vzhhihw0xh
   JWoweb/KLoLKa4/ZYoP697qAY3qgxkZyNIaDH7RyOGHA1B+UGYSShlYKW
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="227437633"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:32:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:32:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 29 May 2023 05:32:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTHkZ92bQ9cYioM7k8M7BhaAob1rEqXkFnnJNrSmeYDFjUAkdyNl7GEr/+UioI2Hr87A3Uc6vyUWUWfCIm/POzGQfIHYb8j4+Td1Uf7pAWCvYfGU/KrLtj+9B4a1hibqml9IAmt7RNsyeCQ3qALoHqVe8o0rJlwjD4J7+lVbLv1Jm40zRfCUqtglaGRncdq3NX3nliMazZeIUAQEw8fmXcXCOVeWEi2yAxmnwrKJ+0b+YbdduPN63bptAVyucejEaGNEdtDzUvTmPFJ56E2Jt6f0e7L26d0QVsY4PuaWXmyJtUzUcjO8Og6SsV3t9N5ZdW4MxjP1Gdbwc6slIVw4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB4gxScIGd9IqnHH1fVNuL9PNql0WMEdkqbYeAzvGLM=;
 b=DgwGRuPeFjGe8KQV3RpmDM2n4BbxRIvnkbA9opmqnT6WCdlmKuvUFywElS+a6Vw1+Z/gO/oSZYXpasRTpK6zPZ8JnVBsDOSRFTq6h7+ePNpdA7iueKeqslt+HciYH8XexZ3ECwyesbFtVbYwJe78/9jBwZGy6OkDVv3yoLMk5sQ5E+nE7o7ePw2mXpvLxHRFmit70AjI7t4aFDFabIPFy1IRoMrZa5ymhU2RJ39IxEobtXrL1Vhqven7n069IK9TXrSHNlWohOtYNDkewlS5AWiebX+fm5d0R8r/42k2qeS39g6sjB77liPrKYhR4EJYJWCrZvsC8khKkhlabBGyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB4gxScIGd9IqnHH1fVNuL9PNql0WMEdkqbYeAzvGLM=;
 b=tzAgu7mLnu67pBQCdcRmCjtBzLjcoobU5eDYK+6yCNIjAV63hoO1PMv2EXRQoxPyJHHQ51PxV24reZ3xr73Y2bUOE5zy3AhpeEelO+iAFeiOVYLc+YmHAcgk+7+MSDvBXDbyZaeCUFm9+kwtDpauG6VslryqW8vxLrp/0CKD6XY=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by IA1PR11MB7812.namprd11.prod.outlook.com (2603:10b6:208:3f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 12:32:49 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 12:32:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: timer: atmel,at91sam9260-pit: convert
 to yaml
Thread-Topic: [PATCH v2 2/4] dt-bindings: timer: atmel,at91sam9260-pit:
 convert to yaml
Thread-Index: AQHZkimtu/9ZIBr1u0Wsj4dgIw7Lmw==
Date:   Mon, 29 May 2023 12:32:49 +0000
Message-ID: <f4c04190-c90e-bf5f-f666-c979a7aee8ce@microchip.com>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
 <20230529062604.1498052-3-claudiu.beznea@microchip.com>
 <20230529-chuck-turbofan-a8aabbdd9341@wendy>
In-Reply-To: <20230529-chuck-turbofan-a8aabbdd9341@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|IA1PR11MB7812:EE_
x-ms-office365-filtering-correlation-id: 752b2355-3b1d-4c1b-bbcd-08db6040d068
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WznvPzgSPmLxD+KvE/qzGI4y28hesmcvk2y5KXewVViMAm43ljhyAQ7yVJ27OFxRSq6NYKLQCNU0+GmqnjbejgqM7VGmHfJgCL/BesyoUpv3ds3rDD32sF7W1hiMqlgWECa00a8DEHpufwOdyEPxhbGpv7T6usoDiO5p+49r8lym+oX3M2UI3Tk1dN4ZM0suYnL8/9z0t6wYUsP5GgokVv+41LUkm/ajP+j32JQM/PmrkYmVdto8oCipg+kWrv80ICBmta41446CyxLUa0dTbxJEIGSWq+n06R16fJQiE4w4opIw9oHkoAxtdBDalBDiEOQJCiEC0a2uPQKzFN1kFoOUDujKO7ecX6s3YbsNkWeu3MozREmppmq+QmJBekeZtTVj0l4zURzl0kSaEfucnxFAM7BA4DtV5xG49h68454LtGSSQ2gKyeTZqwiu8qtU9QwDcdQDWje/mNCLiVYU0rb2rK2iOZiGSafw8RB2oUf7xOGgH+G/ZsD4VVyIZBYHJULKGxRw40E5MCvPjG4M2DYQ356RsBTMCotlMZZrgcFJacApDbbuWVkFYuJumJgNQ6cQ0oMawXyUQg9RmjA1ChEm96CGzzjzONh1beuKAQdpRhQzsVYq98zIWwrelli6F5f6/BYEKP4eNiH1K61sPuF6YzvMQCSKK/4Cr2RK8BtoM/A9tBGLdha3QCEBCETZtKW8K5s1rDfdESvUh7w6iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(83380400001)(36756003)(71200400001)(5660300002)(316002)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(7416002)(91956017)(4326008)(6636002)(31696002)(38070700005)(966005)(6862004)(122000001)(8676002)(8936002)(41300700001)(38100700002)(6486002)(86362001)(54906003)(53546011)(2906002)(2616005)(6512007)(6506007)(37006003)(186003)(31686004)(66899021)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGRSRHlXUE9jbWNvMFZjRHNJTjdlRmVvZjlHR3F2cGY4dUhVSmVRWURiMDNC?=
 =?utf-8?B?M1NpMVFNYi9hejM0UFZLWFBQR01wQ1JDM3ZTTVRPbEt0dzllTjloL21IaHFu?=
 =?utf-8?B?SVRWTkdSKzc2Tjl6cUpQa3dTWlg4RnhYa0E1YW5lNWFDSnZRUUlNdGw3R2c3?=
 =?utf-8?B?SUZiK2ExOEVpNTlCbXRmWENPekNYRE82VUFHaE5FS1VlSVFuYXBHRHphcEkr?=
 =?utf-8?B?NkRxd2Rtc1FsYUdSSWxWeklSWDZCejJudm1neThRdFVTak9VU09EVzVMT2FJ?=
 =?utf-8?B?QyswejYrSUt2d2VKREh3Q2ZqbVhRK2lYSHhKc2RwODMybndyeGhqSTkyN1F4?=
 =?utf-8?B?M3p3QnRET2VIMjdQaEFwQWFUSGYwb1BiQXlUMmYwakdvZzNaQzBFeDBuUGRJ?=
 =?utf-8?B?RHVsczZvY204SlBHMTRmN3Juemw1dXUyM2VIU0NUVW5xQzgzeUdMeVVFK2Y3?=
 =?utf-8?B?TmlvUzlyNDZrek9IZFpOVE9wdEJhQUFJeEgyc3hwTi9sT3R1akZyZjJEN1Yw?=
 =?utf-8?B?a0trN0tQd3ZpY2xMTnlzK1h3dXB0R05zOEZFWkErcjBKUy9qak9YTjR2elQy?=
 =?utf-8?B?ZkNMTTJ2RHJXYkloaHU1TlJWZFYxYjlyUFBncEZYY1hNSURWV2tBTFR3dFVa?=
 =?utf-8?B?bmlUTjVKZC9yek9Lem5jODVwRVByaFVTWVNORU13YTFGcXlDUEthWWhVbDNz?=
 =?utf-8?B?Rk1UTUoxSmhqaFpURXRka0NtUTh1QXRLdHErd3BheUY2ZURpUEE3eEhFbk9Q?=
 =?utf-8?B?emkxWnlYMWt6M1FMWjROR2NKRDBHUmdoRkRlRWI0YXoyVWZjOTlkUEE1Ykt2?=
 =?utf-8?B?dUhvZkJaR0NrTUg0QUdGaWx5MFpYMHM1MCtxRUE3WlhVSEdaOVh1c3E4TzBs?=
 =?utf-8?B?YThuQmZ4Nk1Tai9lenU5VDFVNlhGU3pWbHNYODBFaC9idmJBRDU1UTlzUmg4?=
 =?utf-8?B?bjFiblZDbG5aODVtNGhldVZFL1V4dUJwV1UzUTE3d1ZzU2s1MXdpWVFwSmV2?=
 =?utf-8?B?RUE3c1BST0RFMllVNDZIZXVkb1hhaXEvVk93Q1JrVDhKWjgyNzVWejRQUmxF?=
 =?utf-8?B?V1FuZGpJZ1ptbENhN1M4Zkt0WDlzUDZNbWF3ams2MHVOLzh5RndNTVJrSm5Z?=
 =?utf-8?B?ODBESWpoK1NtSlZKWnVMeUNzZU5jQ1BDdHpjVDhQeU9EdG1xcHNNaHNrOWw0?=
 =?utf-8?B?Mks1Vk9Sd2VTeng0ZWgzbElSWFlDcG5qZnhqbjlDQmJ1N1RxWTJQa2huVCtQ?=
 =?utf-8?B?WUZqNW9Lb2JtakkxZzNlUlIvcHBoRStobTdSTWJRcVZldk91MUt1eDRaL2gx?=
 =?utf-8?B?NElkdHR1aktQbWNVcXZhNlBlSTdEeWQraWs4NmhNWFBFZkhRay9RemduUDBQ?=
 =?utf-8?B?dlVwcmtrTFFVNXRjOHpydXlZVTdUOGtNc1RSZEgyd2xXUCs1WnFUZE5oNDBz?=
 =?utf-8?B?b3poclRmWW5ObFFXa0NvNGJaNC9LZGlrQy9DNGE5MDhheUJlQVM2S0FvWTQx?=
 =?utf-8?B?QXRyUUtBb0RvZnF0dkZrMDJmbk9idnJXYlF4NUdzU3dDQTVWbVJodk5pdWZV?=
 =?utf-8?B?Y2g2RTQ4R1E4R1FkcWtiT3dES2RNa3R2cktDNWJUK1FERVNsWURWYlNYdWpn?=
 =?utf-8?B?YTg4cmZxckhpSk44NStHVGlOak1ZR1BmWGVJQzJBVXV3M0c1c1JKcjBEVzhM?=
 =?utf-8?B?dGtDdjFWT1BTakhoMXp1TzFlN090TVhkWm5SR3NvSjAvMk15bmNvQUxmdWFy?=
 =?utf-8?B?dUlPbHpRckRNZCs1NzFwbnBaalVsN2JkcHA1WHMzckk1QzNEV1BMeHozV1BR?=
 =?utf-8?B?WFByNFdyd2VGa21DK0dLUks1eldPbmFwajYwMVdlRUJBZjI2SE5HVUJhNm1p?=
 =?utf-8?B?SU84aUZZanRBcUdvWXlRVStRL2NoNkVRZFE0dUloTDMydUg5K3JrSWJmN2VR?=
 =?utf-8?B?WS9UTkZUS3hROTBKZXRUVVJOdWNiVWNPaHFSR1dOVXFHU0ZlR1Y3YnhuL05p?=
 =?utf-8?B?YzBEbmZVVUMzQTVkc0VXcGFPQ1ZUWGNKMjY4K3BqdFlGRzkwY0ViaXBhWU8r?=
 =?utf-8?B?czFIbEdLWUVydThEbFNoOXErMUI3Um9hUXZiQTI5ZVo4dnFhenVSOWg1TUE4?=
 =?utf-8?B?VllkTjIxRWo5YlB3RUYxZDFoSEdzUVExWHcvNC8rcHVxOFpPK1JxT2d0TXJI?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B676E14F376954694F59886EDBA8704@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752b2355-3b1d-4c1b-bbcd-08db6040d068
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 12:32:49.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlb/snO7mVCLx3IqhhcFECL+aiGj48kMKnuWxlsu/IGfdxYtpJB2CSz8HzghNj9zzVEoEE5FyWnxeoJENs5MCNDk131qQ3r+jKoS6lwLe0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7812
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkuMDUuMjAyMyAxNToxNywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgQ2xhdWRpdSwN
Cj4gDQo+IE9uIE1vbiwgTWF5IDI5LCAyMDIzIGF0IDA5OjI2OjAyQU0gKzAzMDAsIENsYXVkaXUg
QmV6bmVhIHdyb3RlOg0KPj4gQ29udmVydCBNaWNyb2NoaXAgQVQ5MSBQSVQgYmluZGluZ3MgdG8g
WUFNTC4gQWxvbmcgd2l0aCBpdCBjbG9ja3MgYW5kDQo+PiBjbG9jay1uYW1lcyBiaW5kaW5ncyB3
ZXJlIGFkZGVkIGFzIHRoZSBkcml2ZXJzIG5lZWRzIGl0IHRvIGVuc3VyZSBwcm9wZXINCj4+IGhh
cmR3YXJlIGZ1bmN0aW9uYWxpdHkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQgfCAxMiAtLS0NCj4+ICAuLi4vYmlu
ZGluZ3MvdGltZXIvYXRtZWwsYXQ5MXNhbTkyNjAtcGl0LnlhbWwgfCA5NiArKysrKysrKysrKysr
KysrKysrDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RpbWVyL2F0bWVsLGF0OTFzYW05MjYwLXBpdC55YW1sDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3Mu
dHh0DQo+PiBpbmRleCA2N2E2NmJmNzQ4OTUuLjU0ZDNmNTg2NDAzZSAxMDA2NDQNCj4+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQN
Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lz
cmVncy50eHQNCj4+IEBAIC00LDE4ICs0LDYgQEAgQ2hpcGlkIHJlcXVpcmVkIHByb3BlcnRpZXM6
DQo+PiAgLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgImF0bWVsLHNhbWE1ZDItY2hpcGlkIiBvciAi
bWljcm9jaGlwLHNhbWE3ZzUtY2hpcGlkIg0KPj4gIC0gcmVnIDogU2hvdWxkIGNvbnRhaW4gcmVn
aXN0ZXJzIGxvY2F0aW9uIGFuZCBsZW5ndGgNCj4+ICANCj4+IC1QSVQgVGltZXIgcmVxdWlyZWQg
cHJvcGVydGllczoNCj4+IC0tIGNvbXBhdGlibGU6IFNob3VsZCBiZSAiYXRtZWwsYXQ5MXNhbTky
NjAtcGl0Ig0KPj4gLS0gcmVnOiBTaG91bGQgY29udGFpbiByZWdpc3RlcnMgbG9jYXRpb24gYW5k
IGxlbmd0aA0KPj4gLS0gaW50ZXJydXB0czogU2hvdWxkIGNvbnRhaW4gaW50ZXJydXB0IGZvciB0
aGUgUElUIHdoaWNoIGlzIHRoZSBJUlEgbGluZQ0KPj4gLSAgc2hhcmVkIGFjcm9zcyBhbGwgU3lz
dGVtIENvbnRyb2xsZXIgbWVtYmVycy4NCj4+IC0NCj4+IC1QSVQ2NEIgVGltZXIgcmVxdWlyZWQg
cHJvcGVydGllczoNCj4+IC0tIGNvbXBhdGlibGU6IFNob3VsZCBiZSAibWljcm9jaGlwLHNhbTl4
NjAtcGl0NjRiIg0KPj4gLS0gcmVnOiBTaG91bGQgY29udGFpbiByZWdpc3RlcnMgbG9jYXRpb24g
YW5kIGxlbmd0aA0KPj4gLS0gaW50ZXJydXB0czogU2hvdWxkIGNvbnRhaW4gaW50ZXJydXB0IGZv
ciBQSVQ2NEIgdGltZXINCj4+IC0tIGNsb2NrczogU2hvdWxkIGNvbnRhaW4gdGhlIGF2YWlsYWJs
ZSBjbG9jayBzb3VyY2VzIGZvciBQSVQ2NEIgdGltZXIuDQo+PiAtDQo+PiAgU3lzdGVtIFRpbWVy
IChTVCkgcmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICAtIGNvbXBhdGlibGU6IFNob3VsZCBiZSAi
YXRtZWwsYXQ5MXJtOTIwMC1zdCIsICJzeXNjb24iLCAic2ltcGxlLW1mZCINCj4+ICAtIHJlZzog
U2hvdWxkIGNvbnRhaW4gcmVnaXN0ZXJzIGxvY2F0aW9uIGFuZCBsZW5ndGgNCj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvYXRtZWwsYXQ5MXNh
bTkyNjAtcGl0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIv
YXRtZWwsYXQ5MXNhbTkyNjAtcGl0LnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBp
bmRleCAwMDAwMDAwMDAwMDAuLjFjYzdiNzQ5NGU0Yg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2F0bWVsLGF0OTFzYW05
MjYwLXBpdC55YW1sDQo+PiBAQCAtMCwwICsxLDk2IEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+
PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy90aW1lci9hdG1l
bCxhdDkxc2FtOTI2MC1waXQueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5v
cmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogTWljcm9jaGlwIEFU
OTEgUGVyaW9kaWMgSW50ZXJ2YWwgVGltZXIgKFBJVCkNCj4+ICsNCj4+ICttYWludGFpbmVyczoN
Cj4+ICsgIC0gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+
PiArDQo+PiArZGVzY3JpcHRpb246DQo+PiArICBNaWNyb2NoaXAgQVQ5MSBwZXJpb2RpYyBpbnRl
cnZhbCB0aW1lciBwcm92aWRlcyB0aGUgb3BlcmF0aW5nIHN5c3RlbSBzY2hlZHVsZXINCj4+ICsg
IGludGVycnVwdC4gSXQgaXMgZGVzaWduZWQgdG8gb2ZmZXIgbWF4aW11bSBhY2N1cmFjeSBhbmQg
ZWZmaWNpZW50IG1hbmFnZW1lbnQsDQo+PiArICBldmVuIGZvciBzeXN0ZW1zIHdpdGggbG9uZyBy
ZXNwb25zZSB0aW1lLg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0K
Pj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gYXRtZWwsYXQ5MXNhbTkyNjAtcGl0DQo+PiArICAg
ICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1waXQ2NGINCj4gDQo+IFRoZSBtaXNzaW5nIGNvbXBhdGli
bGUgc2hvdWxkIHByb2JhYmx5IGJlIGFkZGVkIGhlcmUsIHJhdGhlciB0aGFuDQo+IHJlbW92ZWQg
ZnJvbSB0aGUgZGV2aWNldHJlZS4NCj4gDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0
ZW1zOiAxDQo+PiArDQo+PiArICBpbnRlcnJ1cHRzOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4g
Kw0KPj4gKyAgY2xvY2tzOg0KPj4gKyAgICBtaW5JdGVtczogMQ0KPj4gKyAgICBtYXhJdGVtczog
Mg0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0K
Pj4gKyAgLSBpbnRlcnJ1cHRzDQo+PiArICAtIGNsb2Nrcw0KPj4gKw0KPj4gK2FsbE9mOg0KPj4g
KyAgLSBpZjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY29tcGF0aWJsZToN
Cj4+ICsgICAgICAgICAgY29udGFpbnM6DQo+PiArICAgICAgICAgICAgY29uc3Q6IGF0bWVsLGF0
OTFzYW05MjYwLXBpdA0KPj4gKyAgICB0aGVuOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+IA0K
Pj4gKyAgICAgICAgaW50ZXJydXB0czoNCj4+ICsgICAgICAgICAgZGVzY3JpcHRpb246DQo+PiAr
ICAgICAgICAgICAgQ29udGFpbiBpbnRlcnJ1cHQgZm9yIHRoZSBQSVQgd2hpY2ggaXMgdGhlIElS
USBsaW5lIHNoYXJlZCBhY3Jvc3MgYWxsDQo+PiArICAgICAgICAgICAgU3lzdGVtIENvbnRyb2xs
ZXIgbWVtYmVycy4NCj4gDQo+IEkgdGhpbmsgeW91IHNob3VsZCBkcm9wIHRoaXMgJiB0aGUgY29y
cmVzcG9uZGluZyBzZWN0aW9uIGJlbG93LCBzaW5jZQ0KPiBib3RoIFBJVCBhbmQgUElUNjQgaGF2
ZSBhIHNpbmdsZSBpbnRlcnJ1cHQuDQoNCk9LLiBKdXN0IHdhbnRlZCB0byBlbXBoYXNpemUgd2l0
aCB0aGlzIHRoYXQgaW4gY2FzZSBvZiBQSVQgdGhlIGludGVycnVwdA0KbWF5IGJlIHNoYXJlZCB3
aXRoIG90aGVyIElQcy4NCg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo+PiArICAgICAg
ICBjbG9ja3M6DQo+PiArICAgICAgICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICAgIGVsc2U6
DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGludGVycnVwdHM6DQo+PiArICAg
ICAgICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgICAgICAgIFBJVDY0QiBwZXJpcGhlcmFsIGlu
dGVycnVwdCBpZGVudGlmaWVyLg0KPj4gKyAgICAgICAgY2xvY2tzOg0KPj4gKyAgICAgICAgICBt
aW5JdGVtczogMg0KPj4gKyAgICAgICAgY2xvY2stbmFtZXM6DQo+PiArICAgICAgICAgIGl0ZW1z
Og0KPj4gKyAgICAgICAgICAgIC0gY29uc3Q6IHBjbGsNCj4+ICsgICAgICAgICAgICAtIGNvbnN0
OiBnY2xrDQo+PiArICAgICAgcmVxdWlyZWQ6DQo+PiArICAgICAgICAtIGNsb2NrLW5hbWVzDQo+
IA0KDQo=
