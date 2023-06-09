Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03A57296E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbjFIKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbjFIKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:30:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C3B26B3;
        Fri,  9 Jun 2023 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686306146; x=1717842146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pLrRLcBhhQfYebrao6kmyChGtyle/26byYSVOzCOtag=;
  b=FmDECXDKx38RY9cCkT9S4uvpFj3pQnVJcN54jAKLUyIqyqxs5fGZE3Dw
   WyKMSooI12xtkTJAMzTDfF8+rEkuwHwGKJiUTIMWfARmldiXz09e4PFUm
   PxHnftWZ3zaMnWpAF5VXiQu4HuTeRUQp8RhMD+Qdk2uH8wZdSpDaj6cqJ
   1ojHYEnF03QoF7aej3Bcw1z/GnR5sNqRiNbXyP/4tJj5BOv//WKDHBC7C
   VoCsw4QSRJCWdit5+dL8EDGyq6mmQI3Qsa8zkzyO8dDQPd085Pff6zdhA
   +GbvcehYkpISmriElcBKrlDJyvb5rWqkafXqnJn2SiusRtjejT9Amtzc1
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="229291051"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2023 03:22:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 03:22:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 9 Jun 2023 03:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDe0si1duRSuHXrlUCcP6Y2lCUBtViugvtIIxdKaBvQHEe3EFp3kTSAKXfUVc+FNtQBiozHPg7JEPdlFn8rg/m+QtTl/XlQak9WVHDNp0ksQ7bs5iUjjWnayMzLUN0a5xhiE7W5bZeYxpJhHWwiOGBT/GRP6cY1fz+8W/iLeg5PHw4j7s5xCIvsfaLMnZAkrD/dcQKyLEsV0SyWaFdeD3I8BIdpVGLHMzLlIrKISK6hoAzqQuz2YTTZeyXgjVnxTtMjTWZ3G4v+QO/bhzYp77TTVeqAk/GwOCfxH8WMRkVMip+enX2egUDhzvdC0B3WKuK4WN7z2jSBq2nIGCnJFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLrRLcBhhQfYebrao6kmyChGtyle/26byYSVOzCOtag=;
 b=LC65n6oFw7ISW/ur3NH6NN+0HsiyN+wlHn8GjpRPMBf6lPjIw6sagA2FElg0g/nKoNc3uf2uQ4PMF6MqXvH9yqcv3mVOz+ZohEVEX84cknhQRa6d/9CJEU3d3yjJKrptKTd9mN0s/z3iXhW+wYKhQTxzFzIl+8HXi3+xy1ZxHFVsQVllJUSwYVWRu03ZHccqaV+z5xDziIhhyV12iv0W+A3XLBjKvrVVQaxw4EY/mlY1QH8XWK9Rp7JIHbA0nsdBH+1o2zxQMWjWW35zUHY60xtPCLuAh+w8XqflJQufxjg536VqNSvD9JtokDfK2T5dvmf34JFQTlecQ8gtFPdPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLrRLcBhhQfYebrao6kmyChGtyle/26byYSVOzCOtag=;
 b=ujhVptYuvgNTqenLQG2xv13opPwY0S955Y3uhNhxDtruLSRtK9uvjXrlJ97mgKXnRwzkovQQt63ASKynMFNCeARBs7sv6ijpatmCoSN8Pvla453ngZyTflr9pod5xmsjvndRHBY0ddNsarYxcgvLBNWySq2MbbF3y2wpRZ1Kn0Q=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:22:25 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.024; Fri, 9 Jun 2023
 10:22:24 +0000
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
Thread-Index: AQHZmrxHeXTCrM8iOUqn5Rsuw9IWYA==
Date:   Fri, 9 Jun 2023 10:22:24 +0000
Message-ID: <e816a8c2-e4fb-a608-f8e0-232135243c8a@microchip.com>
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
 <20230530090758.1652329-2-claudiu.beznea@microchip.com>
 <46eced08-5bf6-3e4b-7a91-ff4d16c7dab9@linaro.org>
In-Reply-To: <46eced08-5bf6-3e4b-7a91-ff4d16c7dab9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|PH0PR11MB5208:EE_
x-ms-office365-filtering-correlation-id: bfd6aef6-c603-4b06-a626-08db68d36b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u86/IOX4n7dtHov4sBTyFVNelt4cvJWQfE5DtWXgkvO26kpUlG1U2OFgDHNB4D/d/1ar3C96pUslz+k4SXHzljfdz4k+rhoP+Z9MAp011U5haZM7Ivpk5QhuUfDjAo4iw22fIhF/7EkXqGIjiP7JicPYy+KGqVK2Y1U69IPAV7mnUHIBgevjAwFcr3xKYu1ixi3nT+DeXBT794L8cLCoztreshF1Bawf2aej8bs8Vd9j0Y2ojzDNE2zttKQQHSAW3SAFRF3cGg2Z5UK8E1AUjpOuK4WWLePI8sYIWAjyY1yKlzASpy17UnT8jBv4DncE3bsWmXzqea2tGgaNeBfd08PWZJWLUx++Pj8a58xAajySYlB0s5nB/HMLuJ8AgFSywusNAfBgFD/TqNx5fwPgxc/21YPHx7WgK5rG77vOXPctAm7WnHcCg5YUoYefnw+XMRDmbbHDszp8K+BOhEN5yrEBgu8+DA1xQeq53KdSjpTo7IgA5Fv62Xfp/CM2Re8vkW5TW9Cyb7H4dZqLm4dDacFttFNa4VR8hFvow7qMovhCuv+9EzltpyFbXHkbuUhbUIN/GdDoyfjBdd4WoGzk49Z4r7YG9abq/Hduop7UbPG7EdyFCPvUCdZCXDJ12w/MVUq/44HHBlaHXp7NdQK0e6sO4MgLsli60iJfVSveOhLIQWvrBvJPgqAAKm0MsmhG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199021)(71200400001)(36756003)(966005)(6486002)(2616005)(31696002)(86362001)(83380400001)(921005)(122000001)(6512007)(26005)(38070700005)(6506007)(38100700002)(53546011)(186003)(8936002)(5660300002)(41300700001)(316002)(8676002)(7416002)(31686004)(2906002)(54906003)(110136005)(478600001)(66899021)(66946007)(91956017)(76116006)(66476007)(64756008)(66446008)(66556008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0dSSUx5SElpUEpDQUQyYjd5SXFyY2s5MldFbTdXSkhibE5iOVVxSERDbDht?=
 =?utf-8?B?ZG4zV0puRzBJaG90ak1tU0xJdDQ4TUhlNWlhaVcxYUJ6UHFKNSswMHpoLytR?=
 =?utf-8?B?aFd0NkxySDF6R002WFp4Q2wzbkxTdkZLalBObHlZTzhjYXJFNXpSMm9IWit5?=
 =?utf-8?B?Um1FMGxkM1NvbHNHeHJucUVjYml6VEpXb0F4ZUYrWkRJRjFWUHFKd2s1VlYr?=
 =?utf-8?B?NUQ5VVV6dVV6VDNYWVg0dVR5MFA4S1pTdkpwdk5sS0NBZlN2T0RWNGJxelU3?=
 =?utf-8?B?cUtTaGY4RU93NFZGUVNEUDJPci9KWnZoMUVFdW9xQWdqUFNrYVNwRGhEb1lp?=
 =?utf-8?B?UXBwdkNJaFpFV1gxVVUyU1BVMFRuWkxMUmN1Z2FYeUhJeVBmTWdnTk8yaVBv?=
 =?utf-8?B?S29IT24vSjFmU1RKTTY3VGlhM2NZejNzU1FhbnkvVGpqVzlKZHhUVUpORlk2?=
 =?utf-8?B?dXBSVVcyakt3czBEMWx3azcwWWZGN1p0aEVxVlc1T0hvZGRiZGJBSURkUk9P?=
 =?utf-8?B?WjQwbWpzM2NXeGFFM0pqZWNGQXVxNkw0ZTJScTN2ZEI1UCtOSUhYUUlOOWxr?=
 =?utf-8?B?VUprT3JReWJxQ2NPOGs2b1NtSHhQUHBCMklxYzZySFF2Z3NxMWJxM2IxNUpW?=
 =?utf-8?B?Q0RudXhvWnRJRVJjS2JSV1JiNVF1bFhWNTBia3dIRnN3R1I4ODNWNzFVTkI3?=
 =?utf-8?B?UlUwbklvUkpkeVM5aUR5bmNnMHdNbStERlI3T1hFaFlhWkJCbHU1bFRqYjhC?=
 =?utf-8?B?YjZoRDdadkxnSWNtOTMrTThMSzRoWU9lbHdQaXBRNXp2N3B4SWlSY0FZN1pl?=
 =?utf-8?B?andhOEFvV3N0eVVPUUFGcFYxdlZLbVljbE5xelFDRTQ0VW1rVncrb2UxNUQ3?=
 =?utf-8?B?QVRZa1FjMHM3Q292T1E3UmRyOUx4cFZoQW5HOVVSZVVQRXdKVW5mRHB4bFAy?=
 =?utf-8?B?M096UjZ0QzBjV3R6K3BmMVo0RUZvRkl1TEwyakkza2lIWkFCWXk1Y01ZQXcy?=
 =?utf-8?B?NFlUY0xLeTNjSnBXSjdJZytrNmdOOVRMcXl2ZlcvaW9jYlpuNWwwQVIrZXg3?=
 =?utf-8?B?VkRBRkVTRzJZMUhqM2JCTGtXcVVEdm1ROGhENVZXTmxSQ0s1bTF2cFVSakJD?=
 =?utf-8?B?bi9nUEo1MEVGbDhnQWZ4dDhtZTg0RVBPZnFIUmlmeU13c0pONURyVGRUTHdv?=
 =?utf-8?B?Y2p1cEZ2YlN5SzM0alBHR1B6VW9HTmZCZExCd3Z5elFHcGZmZEFmNW83N0E1?=
 =?utf-8?B?M2QyRjQ1Q21vMVkwVWtmRFdoVi9iUFF2dXBva1JMeXRxRERRSGVVMXhYU0Jn?=
 =?utf-8?B?bklScUdFdGgzeTRtcWJSWUtSc1hsTDhSOTJ2YUJ5dldwSGE1WE5XV0kwY3hD?=
 =?utf-8?B?V3h3U2tNeDJ4Tk9TaUNaRyswRkd4Vm5KWXp4clp2MG94Tm4yckJDVWNXWkRs?=
 =?utf-8?B?bmZpNW9BSyt6TWVlajdoTVJwZ1oxa0hsNGJPZ0NMbDhiMjIybFgxZzR4aVdO?=
 =?utf-8?B?MytvRXpiTm1HT1gvcXRWUUxqMUVGZ1lBd0RGOThiTS92ZjRIMktvdVBFaWRN?=
 =?utf-8?B?ODFDTE5DTy9FaHJDa2xzWlBkQzhDSEVBWDZFLzZ4QllDMGM5SHEzNytVWmpq?=
 =?utf-8?B?eUh3UHpnZDI0OE1hWFc5UVBmcWZ1WEJzUjE3UGRoWGU2ZjJPYkJpZXkrVEFp?=
 =?utf-8?B?T2MvK01WQTFKZUo2UlJYYnl5dFgySHJhTzVwK1RQYTAwbFprUlIwblhUQk5u?=
 =?utf-8?B?amg1aHFMdGhFSFU0SlgvZERvMFVCVFdKc2xEaE5zRHB5OWIwaEozQ09hMkgw?=
 =?utf-8?B?bE5uanMvSnE1UEJXUkNscXpHUDRRYnU1czBaWVh3cVZGVDFxN2JobTk0VU9J?=
 =?utf-8?B?UFMvbE52RXFqMDU2bmlNbkR3WU8zSTM2Q0crYjdwMS9qK3BqL3BOV0w1azZV?=
 =?utf-8?B?MjJSZXUwdGhyV0FLd1UvdFZMeUhzOEpSd3pKNU1Hei9lVzRXVEVwblVYK2ph?=
 =?utf-8?B?OTMwaU9oUmNURUhtQ2o3ckVLUXAxL1Q0SkQ0V0JtSFZvT1pxMC9wR05XL3pn?=
 =?utf-8?B?SUpZVVJIR1Fja1I3TXNWRURPcGRoUm5GNXlQc1pkWUI0cmprV1JoRXVGV1Jj?=
 =?utf-8?B?NGdESGR1V1B1SS9jWXVpdTY0QjdZbGJsZGNlZWp2K2FzRzRGaWJaTngxcGRM?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BB70539A800504592690EAFFB2C2496@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd6aef6-c603-4b06-a626-08db68d36b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 10:22:24.7005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/gjhzEVEEEQHFtYCLIG7S+tFREX5IK12wCegAZ4QPaJC5GyyxQ3phVrk/JJ60whYkU7J7mzUOeBwVVZUeG8QPKxVyIT7402eks9BSPNpOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDUuMjAyMyAxMTo1NSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAzMC8wNS8yMDIzIDExOjA3LCBD
bGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IENvbnZlcnQgTWljcm9jaGlwIEFUOTEgUElUIGJpbmRp
bmdzIHRvIFlBTUwuIEFsb25nIHdpdGggaXQgY2xvY2tzIGFuZA0KPj4gY2xvY2stbmFtZXMgYmlu
ZGluZ3Mgd2VyZSBhZGRlZCBhcyB0aGUgZHJpdmVycyBuZWVkcyBpdCB0byBlbnN1cmUgcHJvcGVy
DQo+PiBoYXJkd2FyZSBmdW5jdGlvbmFsaXR5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0IHwgMTIgLS0tDQo+PiAg
Li4uL2JpbmRpbmdzL3RpbWVyL2F0bWVsLGF0OTFzYW05MjYwLXBpdC55YW1sIHwgOTkgKysrKysr
KysrKysrKysrKysrKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKSwgMTIg
ZGVsZXRpb25zKC0pDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy90aW1lci9hdG1lbCxhdDkxc2FtOTI2MC1waXQueWFtbA0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5
c3JlZ3MudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1z
eXNyZWdzLnR4dA0KPj4gaW5kZXggNjdhNjZiZjc0ODk1Li41NGQzZjU4NjQwM2UgMTAwNjQ0DQo+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3Jl
Z3MudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0
bWVsLXN5c3JlZ3MudHh0DQo+PiBAQCAtNCwxOCArNCw2IEBAIENoaXBpZCByZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KPj4gIC0gY29tcGF0aWJsZTogU2hvdWxkIGJlICJhdG1lbCxzYW1hNWQyLWNoaXBp
ZCIgb3IgIm1pY3JvY2hpcCxzYW1hN2c1LWNoaXBpZCINCj4+ICAtIHJlZyA6IFNob3VsZCBjb250
YWluIHJlZ2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQo+Pg0KPj4gLVBJVCBUaW1lciByZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KPj4gLS0gY29tcGF0aWJsZTogU2hvdWxkIGJlICJhdG1lbCxhdDkx
c2FtOTI2MC1waXQiDQo+PiAtLSByZWc6IFNob3VsZCBjb250YWluIHJlZ2lzdGVycyBsb2NhdGlv
biBhbmQgbGVuZ3RoDQo+PiAtLSBpbnRlcnJ1cHRzOiBTaG91bGQgY29udGFpbiBpbnRlcnJ1cHQg
Zm9yIHRoZSBQSVQgd2hpY2ggaXMgdGhlIElSUSBsaW5lDQo+PiAtICBzaGFyZWQgYWNyb3NzIGFs
bCBTeXN0ZW0gQ29udHJvbGxlciBtZW1iZXJzLg0KPj4gLQ0KPj4gLVBJVDY0QiBUaW1lciByZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KPj4gLS0gY29tcGF0aWJsZTogU2hvdWxkIGJlICJtaWNyb2NoaXAs
c2FtOXg2MC1waXQ2NGIiDQo+PiAtLSByZWc6IFNob3VsZCBjb250YWluIHJlZ2lzdGVycyBsb2Nh
dGlvbiBhbmQgbGVuZ3RoDQo+PiAtLSBpbnRlcnJ1cHRzOiBTaG91bGQgY29udGFpbiBpbnRlcnJ1
cHQgZm9yIFBJVDY0QiB0aW1lcg0KPj4gLS0gY2xvY2tzOiBTaG91bGQgY29udGFpbiB0aGUgYXZh
aWxhYmxlIGNsb2NrIHNvdXJjZXMgZm9yIFBJVDY0QiB0aW1lci4NCj4+IC0NCj4+ICBTeXN0ZW0g
VGltZXIgKFNUKSByZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4gIC0gY29tcGF0aWJsZTogU2hvdWxk
IGJlICJhdG1lbCxhdDkxcm05MjAwLXN0IiwgInN5c2NvbiIsICJzaW1wbGUtbWZkIg0KPj4gIC0g
cmVnOiBTaG91bGQgY29udGFpbiByZWdpc3RlcnMgbG9jYXRpb24gYW5kIGxlbmd0aA0KPj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9hdG1lbCxh
dDkxc2FtOTI2MC1waXQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aW1lci9hdG1lbCxhdDkxc2FtOTI2MC1waXQueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDBmM2Y4MGRiNGNiDQo+PiAtLS0gL2Rldi9udWxsDQo+
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvYXRtZWwsYXQ5
MXNhbTkyNjAtcGl0LnlhbWwNCj4+IEBAIC0wLDAgKzEsOTkgQEANCj4+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAx
LjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3RpbWVy
L2F0bWVsLGF0OTFzYW05MjYwLXBpdC55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNyb2No
aXAgQVQ5MSBQZXJpb2RpYyBJbnRlcnZhbCBUaW1lciAoUElUKQ0KPj4gKw0KPj4gK21haW50YWlu
ZXJzOg0KPj4gKyAgLSBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIE1pY3JvY2hpcCBBVDkxIHBlcmlvZGlj
IGludGVydmFsIHRpbWVyIHByb3ZpZGVzIHRoZSBvcGVyYXRpbmcgc3lzdGVtIHNjaGVkdWxlcg0K
Pj4gKyAgaW50ZXJydXB0LiBJdCBpcyBkZXNpZ25lZCB0byBvZmZlciBtYXhpbXVtIGFjY3VyYWN5
IGFuZCBlZmZpY2llbnQgbWFuYWdlbWVudCwNCj4+ICsgIGV2ZW4gZm9yIHN5c3RlbXMgd2l0aCBs
b25nIHJlc3BvbnNlIHRpbWUuDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGli
bGU6DQo+PiArICAgIG9uZU9mOg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0g
Y29uc3Q6IG1pY3JvY2hpcCxzYW1hN2c1LXBpdDY0Yg0KPiANCj4+RnJvbSB3aGVyZSBkbyB5b3Ug
aGF2ZSB0aGlzIGNvbXBhdGlibGU/IFdhc24ndCBpbiBvbGQgYmluZGluZyBhbmQgY29tbWl0DQo+
IG1zZyBkb2VzIG5vdCBleHBsYWluIGl0Lg0KDQpvaywgSSdsbCB1cGRhdGUgaXQgaW4gdGhlIGNv
bW1pdCBtZXNzYWdlLiBJdCBpcyBmcm9tIHRoZSBhdmFpbGFibGUgZGV2aWNlDQp0cmVlcy4NCg0K
PiANCj4gDQo+PiArICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDYwLXBpdDY0Yg0K
Pj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIGVudW06DQo+IA0KPiBUaGVzZSBhcmUg
bm90IGl0ZW1zLiBKdXN0IGVudW0uLiBEb2VzIGl0IGV2ZW4gd29yaz8NCg0KWWVzLCBpdCBjb21w
aWxlcyB3L28gaXNzdWVzLiBJJ2xsIHVwZGF0ZSBpdCBhbnl3YXkuDQoNCj4gDQo+PiArICAgICAg
ICAgICAgLSBhdG1lbCxhdDkxc2FtOTI2MC1waXQNCj4+ICsgICAgICAgICAgICAtIG1pY3JvY2hp
cCxzYW05eDYwLXBpdDY0Yg0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0K
Pj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsg
IGNsb2NrczoNCj4+ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgbWF4SXRlbXM6IDINCj4+ICsN
Cj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0g
aW50ZXJydXB0cw0KPj4gKyAgLSBjbG9ja3MNCj4+ICsNCj4+ICthbGxPZjoNCj4+ICsgIC0gaWY6
DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+PiArICAg
ICAgICAgIGNvbnRhaW5zOg0KPj4gKyAgICAgICAgICAgIGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2
MC1waXQNCj4+ICsgICAgdGhlbjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAg
aW50ZXJydXB0czoNCj4+ICsgICAgICAgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgICAgICAg
U2hhcmVkIGludGVycnVwdCBiZXR3ZWVuIGFsbCBzeXN0ZW0gY29udHJvbGxlciBtZW1iZXJzIChw
b3dlciBtYW5hZ2VtZW50DQo+PiArICAgICAgICAgICAgY29udHJvbGxlciwgd2F0Y2hkb2csIFBJ
VCwgcmVzZXQgY29udHJvbGxlciwgcmVhbC10aW1lIHRpbWVyLCByZWFsLXRpbWUNCj4+ICsgICAg
ICAgICAgICBjbG9jaywgbWVtb3J5IGNvbnRyb2xsZXIsIGRlYnVnIHVuaXQsIHN5c3RlbSB0aW1l
cikuDQo+PiArICAgICAgICBjbG9ja3M6DQo+PiArICAgICAgICAgIG1heEl0ZW1zOiAxDQo+PiAr
DQo+PiArICAgIGVsc2U6DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNsb2Nr
czoNCj4+ICsgICAgICAgICAgbWluSXRlbXM6IDINCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0K
Pj4gKyAgICAgICAgICBpdGVtczoNCj4+ICsgICAgICAgICAgICAtIGNvbnN0OiBwY2xrDQo+PiAr
ICAgICAgICAgICAgLSBjb25zdDogZ2Nsaw0KPiANCj4gaW50ZXJydXB0cz8gVGhleSBhcmUgc3Rp
bGwgcmVxdWlyZWQsIHNvIHdoeSBubyBkZXNjcmlwdGlvbiBoZXJlPw0KDQpJdCB3YXMgaGVyZSBp
biB0aGUgcHJldmlvdXMgdmVyc2lvbnMgYnV0IENvbm9yIHN1Z2dlc3RlZCB0byByZW1vdmUgaXQg
YXMgaXQNCndhcyBub3RoaW5nIHNwZWNpZmljIGFib3V0IHRoaXMgZGVzY3JpcHRpb24uIEZvciB0
aGUgaWYtdGhlbiBicmFuY2ggSSBrZXB0DQppdCB0byBzcGVjaWZ5IHRoYXQgdGhlIGludGVycnVw
dCBpcyBzaGFyZSB3aXRoIG90aGVyIGRldmljZXMuIEluIHRoaXMNCmJyYW5jaCB0aGUgaW50ZXJy
dXB0IGlzIG9ubHkgZm9yIHRoZSB0aW1lciBpdHNlbGYuIFdpdGggdGhpcywgd291bGQgeW91DQpz
dGlsbCBwcmVmZXIgdG8gYWRkIGl0IGJhY2s/DQoNCj4gDQo+PiArICAgICAgcmVxdWlyZWQ6DQo+
PiArICAgICAgICAtIGNsb2NrLW5hbWVzDQo+PiArDQo+PiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVz
OiBmYWxzZQ0KPiANCj4gYWRkaXRpb25hbFByb3BlcnRpZXM6ZmFsc2UgaW5zdGVhZA0KDQpIYXZp
bmcgYWRkaXRpb25hbFByb3BlcnRpZXM6ZmFsc2UgaW5zdGVhZCBvZiB1bmV2YWx1YXRlZFByb3Bl
cnRpZXM6IGZhbHNlDQp0aG93cyB0aGUgZm9sbG93aW5nIGVycm9yIG9uIG1ha2UgZHRfYmluZGlu
Z19jaGVjayBhbmQgbWFrZSBkdGJzX2NoZWNrOg0KDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvdGltZXIvYXRtZWwsYXQ5MXNhbTkyNjAtcGl0LmV4YW1wbGUuZHRiOg0KdGltZXJA
ZjAwMjgwMDA6ICdjbG9jay1uYW1lcycgZG9lcyBub3QgbWF0Y2ggYW55IG9mIHRoZSByZWdleGVz
Og0KJ3BpbmN0cmwtWzAtOV0rJw0KDQo+IA0KPj4gKw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCj4gDQoNCg==
