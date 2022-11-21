Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8E63244B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKUNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiKUNvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:51:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD331D66F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669038662; x=1700574662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oD7jQSUn6iQTweDFGXJ3+xK0Slbw04eh0Yc42V08hMM=;
  b=oy4iSs1dGu6WZ8SLa5VkJ+aIXnBN3XoMFabD4R9PxbWBQcR0wewB4s7Z
   vmpF8axTilP7slLINpP2hSMeQmKG2CI8wKcwtYruF0To0X60P2uSpB4Rj
   cX6K0xJMzE91F2t7LEFmrzEH829CYRlsu8RjP/1gHBT/tqwZvZw5QyoV6
   kjZSwR91ZrhgENvfpyjAXvs0bmZ8o5Tu7T010UrH88cfkuuA0btGyIG+Z
   75soPma1s0pBYdYKYX6yDSpqgXjyPSULSH08dYdMDaR86jSqnCVWjTozt
   ms7C/sUH04rErbCQ/s740EYLXKU4KSTOy8Z0M/N9S1n7nf30kYQoO6VpC
   A==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="184484810"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 06:51:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 06:50:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 06:50:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkkAhMeaUp2iRv6QhDqt59tDTNF2vXwjD4p8b+938HeRRWB4G+DfGGc0TTFzUODhJWp1WOpDkOG5tdSBf5228bex4dOUKgl+Guqn6zYI6RaxMLkRkh6j3uB5Abo0aUKJ1AnBs2fXX+2/l5EpB8lEKKH3j/nr6Em4p1nyTFS2QSARHLU51VQxH9DZmmZDCa2DF1YytB2gtgFrcvZY526CxnvjPqYcubW8/2m8ILH6NPu1CitY0QAsIADQe/TKf5wzfXX+EhEKWo6DUe3ud1kHTEwp60nuljyRnpqlRfFWYo7B1UhZxQOns0OHl1NunIFR+KQcAdkq6M41doD7Zzdomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD7jQSUn6iQTweDFGXJ3+xK0Slbw04eh0Yc42V08hMM=;
 b=eF24r6Joqm/FJB6aR9Nr7dBWYpM1AZhApUqr/M4gi5aFarse7zy6slNk0PLGqcBL/yImOCe1rxnuXci/8aZZccLPGzHwdqTLtBCWTupmNnRzRX9sWrvHPU/SG6SvndOh/KylwgO2WDUYqyr4oOqyjgN/1U5wlLsGeZwkuhOB0BJIVeYCoLAMkwxSwFe/UqZrPOzrb1GksjTA5CkDZ9aTd2su4zIS4SbD6UUGvQzNkkeYJToFV5nE9iHdkQURakWpV/rJ9RKytcxvyNYz94nzP5R0DiRdk5wfyPg9/BtBOP4Mba21TQ+YGqwlRt1OXj0gRuZpLGpCCzpalMKHaBBBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD7jQSUn6iQTweDFGXJ3+xK0Slbw04eh0Yc42V08hMM=;
 b=E1JpvxKW1Y3M77mxtkCVwahtDD3vNeCkp9WeiI9JD7nXMiRYCMhB0T9Ted8ZEx9S2rLWZjqZ415XGWR/o/dWGJIcb2tcTG035yrxdxMCVB8DYQa3OOS1DLYDVOWgEba0ncBEeX8svuWJ6yml2u/Fkcv3MToQWc6aX2RfBDCOxNI=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 13:50:50 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%5]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 13:50:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <potin.lai.pt@gmail.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <patrick@stwcx.xyz>, <potin.lai@quantatw.com>
Subject: Re: [RESEND PATCH v4 1/1] mtd: spi-nor: winbond: Add support for
 w25q01jvq
Thread-Topic: [RESEND PATCH v4 1/1] mtd: spi-nor: winbond: Add support for
 w25q01jvq
Thread-Index: AQHY/bBDkvNhDvCA9kGXcdF6je3OVQ==
Date:   Mon, 21 Nov 2022 13:50:50 +0000
Message-ID: <4817515e-2833-6d39-03c3-30470344ac3a@microchip.com>
References: <20221111060530.2201084-1-potin.lai.pt@gmail.com>
In-Reply-To: <20221111060530.2201084-1-potin.lai.pt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|SN7PR11MB7511:EE_
x-ms-office365-filtering-correlation-id: 919efef3-4b99-4010-974e-08dacbc76649
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TieCTqKyvGqwuyg0Xd8Hfm1qYQ6pn/XcEsom4yZYthiFIheEnUO0rzSHVNJN/xWVXDJYwmtsTXCVKyfOTVdSj7222wvpgQHhtqsmVs7QH48p9vYfgcfoNUmEchQyNEEshBMfVKqzo+TODjaaquA0axFN2xy0P2CZmsD4Z43KHMcqhbwxoQ3qhBdC7N7wvbFxi95+FaFCi9cjHv90anDJCmhWgUOMYcuM452hGbcUXg9x3FbKmVjo2aSMBFW/3okSGrfyPhEFq8hkVlpkrIAHjYtHwI/OOoUxi6ifZVaTd90DHrMX5KwJ4RpjVn6ik+byTZfdhHS4zijXj5qtJr/yqijYQHX9U6CThU7saHK+FhXRT/k+jNG+PR38JsI2lkJOFRtpsRvkRGr5tV7wz4pI4OVUBV01BUE4xIOGbalGBJm+85cUVV7ucQ0gUdN5e76lystp1QYyiS+680LabylKVtjBruskucFTD3zobDq/X9yv9s9TF8KFchJZ3VSnBegLJ2/DbUq2kkeZiHYlPGbChBwABvO1mZoZ5nwXJEIa6o4Lm5nEDcm48qJog/XAlNy7Bh472zTO8RHazWhzZhUIAHW+tM9cN56Kq4Z4hlV4kJ/7MnD++wf1xDN4gHK5v5tNWV4Pn7IuoRurcn2nKzIeRfLPXIb45XmpTJxvEmdZNFmLxHhLnH6gJ5UTRvbq/NorwiYZWeNhJEwDJ6FnK/4JSeZTk3TJcOC7q2+USYJhBc5UcdqE2H7Zp8JhleLAfnEm77fcc8CD1dlJLz8w0GxbaTSriCm8GsALXzIjShyyw8TWvufDwgMyCJjCTytyf7orMpM/EhfSRpOgBpGb774Pd+RSe3M9yWzO6Cylr0aTsi8vl5L/I2aiJJpw1Cefd9vj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(2906002)(316002)(53546011)(31686004)(122000001)(6512007)(26005)(6506007)(54906003)(110136005)(36756003)(86362001)(38100700002)(31696002)(7416002)(91956017)(66946007)(186003)(4326008)(8676002)(71200400001)(66476007)(66556008)(64756008)(66446008)(2616005)(8936002)(38070700005)(5660300002)(76116006)(6486002)(966005)(41300700001)(478600001)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDg2MUJZYlNxRVR2Nkltd1ZBZ0UvQ2JpOUpxd3U2djMyUmFpNGh4Nks1dlRl?=
 =?utf-8?B?UG4wVHJYVkFBMVBudHFkU29acVNVaWRWUE00eUFiRExIUmtDNHNWb216SWxY?=
 =?utf-8?B?QkxPVyttRjVhSFUvaWZGdGZ4bGJjODFUZmpCalZxNGZFV2d0U2RJSzl4ckNn?=
 =?utf-8?B?eEV3a2lRMWNoVjNmZ3NPRFNNSlpWVFJnYkpCVmpiNHhBU0RmbjZHRnpGdmQ0?=
 =?utf-8?B?Y1UvQURYOHZFRG5kMDl6OUVkRnVkSVV4QWFJOGJjdi8vSndFd2ZWaVoxOVJp?=
 =?utf-8?B?NlREc3A1TkhyTGh4dWxQa3hESDNmTkozbHRmalRHT2YxMEEzWHZPc3JETTRK?=
 =?utf-8?B?Y2xHQUlVb2wrMnBLQ1IxSDU2WG1QVFM4VGp0NjVRRzQwM0hmZDk2Z0cwWWZ5?=
 =?utf-8?B?SC9OUFlmWVNQRUc2UWxZUzVDV2ZNYjl2R0M5eElhbmtYY29NZFQyc3JyblJQ?=
 =?utf-8?B?OFV3NE51ekhKS1BQbXd2YjdZQkRvSjhjQXFaQTBkb0x5YVBRU3ZQd3M2cG1x?=
 =?utf-8?B?bXcvZEpzRk11M202dDZkK0hWYTdQQ1o1aGNIT2Fxbms2bkd5MzJ3YkpLYzBu?=
 =?utf-8?B?VFFSR2Q4d3pNck91ck14MnNjTkZ6ck5seEJOenhDTkJoSkVzWHpzeE1UVUwv?=
 =?utf-8?B?a29HZ1ExbmFZbmhSdnVhM0hOVjZqWGhhTEJ3bVNPbENPcnoyMU5RY3RqelJ6?=
 =?utf-8?B?c1pVOUFGUlF4SUhuRElmNWFxTTVpak9oZ2l6bFlLZWUwaGFWWm00NVkraFFQ?=
 =?utf-8?B?SXcvdkt1eVdYSTdES01sN1Zad2x4dEhibThiUkxIbWltWXphbER2UTU2cUUr?=
 =?utf-8?B?eTlTT0pVVkh2bnRWSkM3ZUFXbi96OHN2Yk91c2JTVDNrUjd4THVqeEV1eTJP?=
 =?utf-8?B?MUdPSXpJOFBWNlJWei9BTzdZTlZ5TGNkUEthNWdMeWY2SHhsNUhIdUxRZ1Er?=
 =?utf-8?B?WHRYcVV1YlpOZE5FRmphWEV1NC8wOExrS21jd2lVajN1UjJhdHRZQ05QbnJG?=
 =?utf-8?B?WXZkUWlwNUhLclZBTFJhZ2pEdVEyVDVGZUtoMHFFU2RVYVRuaW5tczNsdEZz?=
 =?utf-8?B?MXFITkIwQnB1bzliMzU0dmYxdVJzbFRNT0RyM2piSFBmMERRNHRvL1lsYm42?=
 =?utf-8?B?YnhTYThBcXpVeFE4bzlzWk1XYkJQQmFFWDJTL2RabmpvZ1NBSFZxVUJpV1p3?=
 =?utf-8?B?SFk5ekxwb2FCdmlETDdlbGZFRDlGem5oTmppd2lZcjlZU1BNclQ5RmQ4Z0dQ?=
 =?utf-8?B?aTY3bW9GaVQwemQzZmp1RlBhMEViR2xTRHQyaVhlOERSdkV1dDdyVjNUZHBQ?=
 =?utf-8?B?Uy91YlNiR3JVUlJqOVNwaEw2YkxSZXZRSGZkWjlJNDk4NUFBbGloYzhkbFdu?=
 =?utf-8?B?SlNVb2JGTGUrNksvaERlSEVVUnpxZ2toQ2FUTlpvT0pHUnhCTzIwUVlMLzY1?=
 =?utf-8?B?RWlPMmROVzFtZDE4aUVXbVRpZXBUYzNLZUF6NWtBd3NmM0RmSm92eHk1bTRS?=
 =?utf-8?B?SVZWR0QwcW40cnhQWllYRVhaRlNSbExPRFMzM2lxODNveUU2WStJVnZJUTVJ?=
 =?utf-8?B?NFRWM1Z1NkdZTVhPbVV6ei8xOGpkazVRQXJGY0VldDlGL0h2S2JpREcwYVEw?=
 =?utf-8?B?QmhCcGtmaEk3Zm50VlVIcUhzODN6UnpySUk2UmtBOUd6ODNBaDIwVUZVMnpF?=
 =?utf-8?B?ZmVHUWoxS3RaNk9UUmhhS0VqbHNFNHh2N3EwZ0Y1UFVkUHZaWUpWVnc5RXZh?=
 =?utf-8?B?bmFDSkl4WTFHZmZLSDRSMVk5REFNNkVSd0xTSWpPRkpPSG9yRCtXdFNNK2Fm?=
 =?utf-8?B?OE1sOFZzRVVkL3VGTFMrNzJtVE9LUVU5WnB4ajFGSHJPMkMvV25tMXF3cnR1?=
 =?utf-8?B?NENKTjBtb1hoNkYwbW01Yi9Qbm9PN0NBSzhQWWd3NVQzMkhCNHJwTzE0Sm9i?=
 =?utf-8?B?UitseWw4ODFwOUxpRkNVQlFYODJFR2hIaUU5aWltdFpJazhQRlJ3M2pGaTY5?=
 =?utf-8?B?SVl0ZC9IT1VWSFZpQ0QyL3lJTi9uTytzVldERTJqU1JBQUVXZmkxUzVKdVVO?=
 =?utf-8?B?bSthWXcwNXpIWTZ1bWVaK05GZTdxM1d0Vm1nZjNOajBmbVE0S2tUbGVDaHJH?=
 =?utf-8?B?N0J2U2lGZnRka2pSV2hicGE4akNmRHNFRUl2dnBwdHlXUzlYVllocENzbk53?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE850F057EEAF6489C7AA94E2FE29F3E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919efef3-4b99-4010-974e-08dacbc76649
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 13:50:50.1063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goaHA+ekDR1v/zDeXK9uhj2dwwS3G2wWueLV9D0Ob/hkHd/G7TZCNaYNaeYC5400pK2orJVa2oWW+3JHtV7/UF6w5oAQ0T1Uwqv7KhjG6H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTEvMjIgMDg6MDUsIFBvdGluIExhaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBQb3RpbiBMYWkgPHBvdGluLmxhaUBxdWFudGF0
dy5jb20+DQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Igd2luYm9uZCB3MjVxMDFqdnEgY2hpcA0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUG90aW4gTGFpIDxwb3Rpbi5sYWlAcXVhbnRhdHcuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBQYXRyaWNrIFdpbGxpYW1zIDxwYXRyaWNrQHN0d2N4Lnh5ej4NCj4gUmV2
aWV3ZWQtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IFNpZ25lZC1vZmYt
Ynk6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+DQo+IA0KPiAtLS0NCj4gTElOSzogW3Yz
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjAyMjIwODUxNDguMjE1OTQtMS1wb3Rp
bi5sYWlAcXVhbnRhdHcuY29tLw0KPiBMSU5LOiBbdjJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIyMDIyMjA2NDIyNy4xNjcyNC0xLXBvdGluLmxhaUBxdWFudGF0dy5jb20vDQo+IExJ
Tks6IFt2MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjExMjI0MTA0NTIyLjI0NjE1
LTEtcG90aW4ubGFpQHF1YW50YXR3LmNvbS8NCj4gDQo+IENoYW5nZXMgdjMgLS0+IHY0Og0KPiAt
IGZpeCBjb3JyZWN0IGNoaXAgbmFtZSAidzI1cTAxanZxIg0KPiANCj4gcm9vdEBibGV0Y2hsZXk6
fiMgY2F0IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9haGIvMWU2MjAwMDAuc3BpL3NwaV9tYXN0ZXIv
c3BpMC9zcGkwLjAvc3BpLW5vci9qZWRlY19pZA0KPiBlZjQwMjENCj4gcm9vdEBibGV0Y2hsZXk6
fiMgY2F0IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9haGIvMWU2MjAwMDAuc3BpL3NwaV9tYXN0ZXIv
c3BpMC9zcGkwLjAvc3BpLW5vci9tYW51ZmFjdHVyZXINCj4gd2luYm9uZA0KPiByb290QGJsZXRj
aGxleTp+IyBjYXQgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2FoYi8xZTYyMDAwMC5zcGkvc3BpX21h
c3Rlci9zcGkwL3NwaTAuMC9zcGktbm9yL3BhcnRuYW1lDQo+IHcyNXEwMWp2cQ0KPiByb290QGJs
ZXRjaGxleTp+IyBtZDVzdW0gL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2FoYi8xZTYyMDAwMC5zcGkv
c3BpX21hc3Rlci9zcGkwL3NwaTAuMC9zcGktbm9yL3NmZHANCj4gYTdiOWRiZjc2ZTk5YTMzZGI5
OWU1NTdiNjY3NjU4OGEgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2FoYi8xZTYyMDAwMC5zcGkvc3Bp
X21hc3Rlci9zcGkwL3NwaTAuMC9zcGktbm9yL3NmZHANCj4gcm9vdEBibGV0Y2hsZXk6fiMgaGV4
ZHVtcCAtQyAvc3lzL2RldmljZXMvcGxhdGZvcm0vYWhiLzFlNjIwMDAwLnNwaS9zcGlfbWFzdGVy
L3NwaTAvc3BpMC4wL3NwaS1ub3Ivc2ZkcA0KPiAwMDAwMDAwMCAgNTMgNDYgNDQgNTAgMDYgMDEg
MDEgZmYgIDAwIDA2IDAxIDEwIDgwIDAwIDAwIGZmICB8U0ZEUC4uLi4uLi4uLi4uLnwNCj4gMDAw
MDAwMTAgIDg0IDAwIDAxIDAyIGQwIDAwIDAwIGZmICAwMyAwMCAwMSAwMiBmMCAwMCAwMCBmZiAg
fC4uLi4uLi4uLi4uLi4uLi58DQo+IDAwMDAwMDIwICBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgIHwuLi4uLi4uLi4uLi4uLi4ufA0KPiAqDQo+IDAwMDAw
MDgwICBlNSAyMCBmYiBmZiBmZiBmZiBmZiAzZiAgNDQgZWIgMDggNmIgMDggM2IgNDIgYmIgIHwu
IC4uLi4uP0QuLmsuO0IufA0KPiAwMDAwMDA5MCAgZmUgZmYgZmYgZmYgZmYgZmYgMDAgMDAgIGZm
IGZmIDQwIGViIDBjIDIwIDBmIDUyICB8Li4uLi4uLi4uLkAuLiAuUnwNCj4gMDAwMDAwYTAgIDEw
IGQ4IDAwIDAwIDM2IDAyIGE2IDAwICA4MiBlYSAxNCBlMiBlOSA2MyA3NiAzMyAgfC4uLi42Li4u
Li4uLi5jdjN8DQo+IDAwMDAwMGIwICA3YSA3NSA3YSA3NSBmNyBhMiBkNSA1YyAgMTkgZjcgNGQg
ZmYgZTkgNzAgZjkgYTUgIHx6dXp1Li4uXC4uTS4ucC4ufA0KPiAwMDAwMDBjMCAgZmYgZmYgZmYg
ZmYgZmYgZmYgZmYgZmYgIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmICB8Li4uLi4uLi4uLi4uLi4u
LnwNCj4gMDAwMDAwZDAgIGZmIDBhIGYwIGZmIDIxIGZmIGRjIGZmICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfC4uLi4hLi4ufA0KPiAwMDAwMDBkOA0KPiANCj4gQ2hhbmdlcyB2MiAtLT4gdjM6
DQo+IC0gbW92ZSBzcGktbm9yIGZsYXNoIGluZm9ybWF0aW9uIHRvIGNvbW1lbnQgYXJlYQ0KPiAN
Cj4gQ2hhbmdlcyB2MSAtLT4gdjI6DQo+IC0gcmV3b3JrIHBhdGNoIHRvIHdvcmsgd2l0aCBuZXcg
ZmxhZ3MNCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyB8IDIgKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5j
DQo+IGluZGV4IGZmYWEyNDA1NTI1OS4uZTYwYWQ5MmMwYWNlIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3dp
bmJvbmQuYw0KPiBAQCAtMTM5LDYgKzEzOSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hf
aW5mbyB3aW5ib25kX25vcl9wYXJ0c1tdID0gew0KPiAgICAgICAgIHsgIncyNXE1MTJqdnEiLCBJ
TkZPKDB4ZWY0MDIwLCAwLCA2NCAqIDEwMjQsIDEwMjQpDQo+ICAgICAgICAgICAgICAgICBOT19T
RkRQX0ZMQUdTKFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiArICAgICAgIHsgIncyNXEw
MWp2cSIsIElORk8oMHhlZjQwMjEsIDAsIDY0ICogMTAyNCwgMjA0OCkNCj4gKyAgICAgICAgICAg
ICAgIFBBUlNFX1NGRFAgfSwNCj4gIH07DQo+IA0KDQpUaGFua3MgYWxsIGZvciBzZW5kaW5nIGFu
ZCByZXZpZXdpbmcgdGhpcyBwYXRjaC4gQXMgdGhpcyBlbnRyeQ0KdXNlcyBqdXN0IHRoZSBQQVJT
RV9TRkRQIGZsYWcsIHdpdGhvdXQgYW55IHNwZWNpZmljIGZsYXNoL3ZlbmRvcg0KaW1wbGVtZW50
YXRpb25zLCB3ZSBjb3VsZCBpbnN0ZWFkIGRvbid0IGRlZmluZSBhbiBlbnRyeSBhdCBhbGwNCmFu
ZCB1c2UgdGhlIHNwaS1ub3ItZ2VuZXJpYyBmdW5jdGlvbmFsaXR5IGludHJvZHVjZWQgYnkgTWlj
aGFlbA0KYXQ6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tdGQvMTY2OTAzODA3ODEx
Ljg1NTAxLjY4MDMzODYwNzU4ODE5MjI3NDIuYjQtdHlAbWljcm9jaGlwLmNvbS9ULyN0DQoNCkkn
dmUgYXBwbGllZCBNaWNoYWVsJ3MgcGF0Y2ggc2V0LCBwbGVhc2UgdHJ5IHRoZSBsYXRlc3Qgc3Bp
LW5vci9uZXh0DQpicmFuY2guIFdlIHdvbid0IGJlIGFkZGluZyBuZXcgZmxhc2ggZW50cmllcyBp
ZiB0aGUgc3VwcG9ydCBmb3IgdGhlbQ0KaXMgc29sZWx5IGJhc2VkIG9uIFNGRFAsIGFuZCB3aWxs
IGluc3RlYWQgdXNlIHRoZSBnZW5lcmljIHNwaS1ub3ItZ2VuZXJpYw0KZHJpdmVyIGludHJvZHVj
ZWQgYnkgTWljaGFlbC4NCg0KLS0gDQpDaGVlcnMsDQp0YQ0KDQo=
