Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8767AF50
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjAYKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjAYKHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:07:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C12A168
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674641247; x=1706177247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LjlEEZA8EK7WQq4/lq4VvDqcTLqIoC7SmIUOObOhJuo=;
  b=dHuuid9+UsCMKYxWMiMqILCtAMTHO5bOaFarulfArbBGCRtL/es6AS4r
   U/wn35zggMOVMNkuE+PfBGgu+C84ypMNueQCbmxvjAekWYUXkCsznHaN1
   PVg4Fi3vso/roAzbphnu4jGj5K5E/DkuXUAR0FPCu54tlouIroFjqHUvQ
   wgX6ZPz2PRasOpbD+mapBJ+mwdn2xB0ltqj/a8mY4hUgNLD69LJMZ3Cpt
   zUXWT5t2FkBd0K/tW4+RpeperSk8nvdlqtSLAHtFQFAK6k4GFQAY8Zfsg
   VG+dHFVc3GKlFsMaPzE9FvsdaBpeNmY13FaaSjbvUuXQqP3AgPESlGmiI
   w==;
X-IronPort-AV: E=Sophos;i="5.97,245,1669100400"; 
   d="scan'208";a="133916863"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2023 03:07:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 03:07:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 25 Jan 2023 03:07:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5Xzy8ps7YvRL837aOwOrOX8YirWZQHjIvjL7Mjn9P6k6lbg4x8GED2yb0OOopOr17WwgccmUZh9Qq8OC6cqGa/aJ85p+Y0y4bCa9znCOYmHInMeVmrZsVDJn78kzWOPQKGAnGcn4mRrZ+Xr90Rw2SVqpv4loNmC2u60DXGGTv1uhxDS+HWiN6HUG0d1Xs8yOOqS1tizj8gD9Ccvpb59E9baiDHHJUtJ6+PautMTDmvDmyPknwbqHHdGPe5wa+Ggun8d3tEasGhm1JTzUTCuJATzPkXnHwcB5hW0xfs3c9LnstVZxvtt107xfdTBumMazvSSKIIWziNpYhvv1WE2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjlEEZA8EK7WQq4/lq4VvDqcTLqIoC7SmIUOObOhJuo=;
 b=SgYNePnSE9OdCzrvKOfDwTs+l5pIOrbsJy72ulnFCJaReh+gPzBiY3IMSctNRUhHi2rw68HVilYQ2BP5LxfYcBW9M1KzuRePEBztyfAQZTSdpx49ZsX3uJT+5bFO0xSYL6tCGlrk47bfDLhwMU6NBumrDSmMS+68pTnAMic8BrBC6ULc/T5o/kjgB1RCC20f0Z+fTAxDT7QHsei9IJ9MmJHpdVqP8GqDHy0BLFAay++H5/EiXLOExuT6gMu8zQJdwoQTCnQJHeWvxGFgmOplET3AT9kEP91/bUyUsKQlA7F4V0qbjyJhMfHAzh3Ep+ZMWuA/9kSVkSaSOXKURmwH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjlEEZA8EK7WQq4/lq4VvDqcTLqIoC7SmIUOObOhJuo=;
 b=Rbu0bUvUh0UdQNLjMYtiq0u3ygJyu5P2nEUnaf5DqpP9/ySQIZdq70nXuPq3yESTaThlU5Vatm42ZWcmg6xrDMzSrsx00jlezHpgDLmPSdfCi4GQVAL6hYqA21MJGphWipQmdotGWWmg7GtMtTJqzQuRQqE4GAmtnav5mWUTbpo=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB6044.namprd11.prod.outlook.com (2603:10b6:8:63::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 10:07:16 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 10:07:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jdelvare@suse.de>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: |PATCH RESEND] clocksource/drivers/timer-microchip-pit64b: Drop
 obsolete dependency on COMPILE_TEST
Thread-Topic: |PATCH RESEND] clocksource/drivers/timer-microchip-pit64b: Drop
 obsolete dependency on COMPILE_TEST
Thread-Index: AQHZMKTNVPkeCQWHfEOeLHu8KD+aRg==
Date:   Wed, 25 Jan 2023 10:07:16 +0000
Message-ID: <1ec8919b-cec0-754d-fe3d-68b31a73e4ad@microchip.com>
References: <20230121182911.4e47a5ff@endymion.delvare>
In-Reply-To: <20230121182911.4e47a5ff@endymion.delvare>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM4PR11MB6044:EE_
x-ms-office365-filtering-correlation-id: 7fe94edd-b309-4260-cefc-08dafebbf007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/uxSyfO8Ek9u3cKdlL71vX6XdtDPtJg4x9ftkPW2lmYRArsTGSq6fJMBxnb1gIUgP5KFEquzzu+33EqBH6QNbY/RF0k9sGLOigTEl/rnO4cEfmI0Ts4vta/8m28L5I8fUTHWRYAJg/Mk5dv+JkNT3jpArMnoss0lJTTTU5J9nblMZEC9YfvPjH9BD7T7BgV5PHVoIAo2tPAGkLTmI/FczakYuNvdtwbqCQCkzado66WY6A7XIcbr8fRy5lNaNH8iIgovvdUDpm6id4lJ9Eh+lh6HDYbQtOskFyru/RQMKeUp6fE4iF7EtKJU9flniF1/kI9kPVsUEmQ8RfZgc68tsiMqkAH/0CLk6D9b4PVTstYxqDEGzFfH4zr5gK4Hy6wfJtmfBQGzJJbzHH/FD0Lj9bIaq2EGWvM/Cbo4PPvu8ciM4siTzJDE7tdNMkq6henWMuo8+xdvUQVdxnSWo15LKh9XtNiw6Gl5PHINexFaIqe25/P0yQDwdtNBds4vxLxByMmJObyYDfiyESK+4zGmb8diGQ6J966xJZ/OfyGU2u6gxNfKNmKjwmx1aE6KuSZZfQeFyBACiDxN9TmOpN65r6qK3a3xM6sPEs7TWkgxGskoCNVc6AaMbCaiwQAdV3keE001UImvnieQT8mLejTdUjfiwz5C9/CFcFiW+KMf1Tr1whGGPyQ14ggQBNKXJkl1OVjipr9/8M7GaeYHYFWZFxBDIoyR+IxpVQr3ErwxL5/8dTn8+yI1YKKm1iYiyep/eYfmqR1udux/gI+TUenrrQ5VQI0WIiFDD6gR1RUI+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(83380400001)(2616005)(110136005)(38070700005)(36756003)(316002)(4326008)(31686004)(66476007)(66946007)(64756008)(66556008)(38100700002)(8676002)(66446008)(84970400001)(71200400001)(31696002)(6486002)(53546011)(186003)(86362001)(6512007)(6506007)(4744005)(26005)(2906002)(41300700001)(91956017)(8936002)(5660300002)(122000001)(76116006)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFBIZUNXR0pSbkRiaUtreXFnUFBGY1J4QlFnK3Fyd0JzeXg0Vlp6WWNmR1Nh?=
 =?utf-8?B?WDN4ZlZ0cVhiRGhqYjdZTXNkZFlvSUNxZjM2K3ozWThiaERENmdyY3g5Q3Qx?=
 =?utf-8?B?RWxRYlhhNDJmQ2NSRFRsWXM0RlRqbmZ1eFYyN25BVHNjdkpnUHFEZVl4VkEx?=
 =?utf-8?B?Z3Y2QUtJbnI5dlRuZ1JBcEFxYWk3UkZmVlQ3cm44enFCOWJ3Rm5LSUEycWtI?=
 =?utf-8?B?bXVPTU1ScjhoYTViNzB1bjBlVEQ4bkxIWlNWb1JsaW92cHFtVFJwbUhKOVdv?=
 =?utf-8?B?ZUV2ckRnaHlsN3A2UWlSL0ZPMEhUYXZuRE1NMzNTSVc3NjhQZnJaTWNQZzND?=
 =?utf-8?B?ZENiUzYyWEVkSGhieW5GSnpycDlNZHVCM3k2b2tMdWVvQXZPeURlTExUaXgw?=
 =?utf-8?B?dkU0MXVLb0F3MFJaUHQwak03QUhoUGJUVDFBTkVkN2szZEoyd0h4eHE2TFRZ?=
 =?utf-8?B?Ylo0NDZyejI5MW5oVnhwcTVURVlmRUZSOXhyQmRLbzhtU3I1MGF1SkU3clh5?=
 =?utf-8?B?Nk1iMW9uVEtBbjNuNzB4ajZGYTJuRWtkNG83L2Q1SnRSdE9zOGVlQVlNaWFF?=
 =?utf-8?B?UE4wSHV6MnpLd1h3YVBtMHBwVEZvVkk5V2pNemtscHlEbmhYZnpEdGZaSDdC?=
 =?utf-8?B?YWVHZ0hJZ0pSa01tWFhLZ3NUYWV6V0VEM0VaWE95VUJOOGtKVWp3amY5NW5m?=
 =?utf-8?B?SW5lWitmUXQ2NTB0cCs1aEJNWXFpdW9CWkJ5SUV4MnA4UGhlKzAzRTltdnJC?=
 =?utf-8?B?NGUzb2MxaW90Sk4xNU9aMGZDYUsyWGUvYng2QjBLNXV3VFh2akluTkpFM0tH?=
 =?utf-8?B?OFp3SFRZa0VYUnJhRGJ6a2svMG54WEZFbzFqRlRhUTFSNkx1dmRRUjNIUlJ2?=
 =?utf-8?B?dEd3WGlTUFBYQ251WHFNeGVOUCtlVXNyRXlKMnpqZncrV0RpQlpMWWY1bXl6?=
 =?utf-8?B?cGNmZ3Uzem1ObmRuTUY2SEFKaGxXcFVGL0tsWVJsaERKajE3bnVXcUZuTW5P?=
 =?utf-8?B?RCs4UVg2YkFzTCtFekhiUUlacVRpSUovL1dSNDZZMDZST0dGVDVFeUI5OE5R?=
 =?utf-8?B?ZUxDNnprK09Iek1saDYxY0RkWTRyMTAwRG83SWh6RDBJZmdpenVuQi9qMjlV?=
 =?utf-8?B?a3R4QmdaNjhuRlN4RGpqSklVLzYzM2RWZFVHcklPNVJyTngzckQxb1dYN1Q5?=
 =?utf-8?B?KzBkalE2OFJub1VaSzlHVzU4bG11UDJBNjRJaG5HUTU5RTZzNHZOS2w5dWQy?=
 =?utf-8?B?SkVyWGtaR3VnendVM2x5OUdLVjJVUUx6TFJDWlBQWlVibFB2cDRZVno1aUhF?=
 =?utf-8?B?M3BOalVRd0FGMjZrcEh6N1FkeWkvYk11bUtVSkZNZi9uVWc4N1VXb3ErQit6?=
 =?utf-8?B?TUVjdjlXM0kzeFNFU3VIejBFNWtzNkdsL2FhODRuQjBQcVZDNU9zd2ZQVVVk?=
 =?utf-8?B?VmNlZWxuNkZacFpmVEFGTVE2QWZYM2JOWHdyaDNJVFZEelhObkVmakk0cnRV?=
 =?utf-8?B?aEoxUmRhREsxdDF4bktOYUErZEFzVE9SeFRjY0FnM0lUY2Y4emwvOXhKQlBL?=
 =?utf-8?B?WmVqamV6d3ZqNXljNFNJdTBoMUp2QzVsTm0rcFBScXA0R0VhemMvZ2IxQVJN?=
 =?utf-8?B?TWsxVjFndS9idmFUdDJuY3ZKaXA1MjZNbVVkaTQyWVB0ck1oZHVEYUs2RDk1?=
 =?utf-8?B?RW9YNEExSmZHelpsN2YzWFIzeTZzb0dKMlRnYTdUTUlkZHVKTlpwQUVoRVNs?=
 =?utf-8?B?MXRIQ0s0V3o2blMweWJWR29sY0ZzZytYU0x1eVpzYUpSMnNjalJJaVg3cytP?=
 =?utf-8?B?M1VZTStWVTJyVnJLeVp0VERCZHBSd0w5bkwwcGovTUd1S3NVSkZETm1BdUIv?=
 =?utf-8?B?NVNBNXFGQ1R2N3cwbUptc0g5WEtiMllKTExwYmNXM3hvUFVaeXZxQ3RQV0ZX?=
 =?utf-8?B?WGV6TUlONUFkK0FxTEJ5RGlTbERLYituNUJJOFVIOWFzd0Nja29xVU9YRmZK?=
 =?utf-8?B?NWJWZEt2MlJVVVF0V1Y5NzcrekMydTVOZk1UVldYNXYvQTlOVjhHTC9IdFhC?=
 =?utf-8?B?K2VuN1ZDS3VGWFRhZjVSQVR0SStoaDNOREN0WmViNi9iQUs0SjQ1UmV5N2Ja?=
 =?utf-8?Q?aqvd4UAosaWzMxC5Lkw2vk9s3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AED7B95E03D50342849CAB0C106EAA13@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe94edd-b309-4260-cefc-08dafebbf007
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 10:07:16.5104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bksOLhRJmMdqRb51/3SGxG1LNX6X2g/3iBXv4qD8NxoO6mDXxi/jlo2OTN9Mn0wVmSeZDg+Z3whGAlcor3+ty6rkag9Vb1w8LRAKwuINMeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6044
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEuMDEuMjAyMyAxOToyOSwgSmVhbiBEZWx2YXJlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFNpbmNlIGNvbW1pdCAwMTY2ZGMxMWJlOTEgKCJv
ZjogbWFrZSBDT05GSUdfT0YgdXNlciBzZWxlY3RhYmxlIiksIGl0DQo+IGlzIHBvc3NpYmxlIHRv
IHRlc3QtYnVpbGQgYW55IGRyaXZlciB3aGljaCBkZXBlbmRzIG9uIE9GIG9uIGFueQ0KPiBhcmNo
aXRlY3R1cmUgYnkgZXhwbGljaXRseSBzZWxlY3RpbmcgT0YuIFRoZXJlZm9yZSBkZXBlbmRpbmcg
b24NCj4gQ09NUElMRV9URVNUIGFzIGFuIGFsdGVybmF0aXZlIGlzIG5vIGxvbmdlciBuZWVkZWQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZWFuIERlbHZhcmUgPGpkZWx2YXJlQHN1c2UuZGU+DQo+
IENjOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gQ2M6
IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBDYzogVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9jbG9ja3NvdXJjZS9LY29uZmlnIHwgICAgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiAtLS0gbGludXgtNi4xLm9yaWcvZHJpdmVy
cy9jbG9ja3NvdXJjZS9LY29uZmlnDQo+ICsrKyBsaW51eC02LjEvZHJpdmVycy9jbG9ja3NvdXJj
ZS9LY29uZmlnDQo+IEBAIC03MDYsNyArNzA2LDcgQEAgY29uZmlnIElOR0VOSUNfT1NUDQo+IA0K
PiAgY29uZmlnIE1JQ1JPQ0hJUF9QSVQ2NEINCj4gICAgICAgICBib29sICJNaWNyb2NoaXAgUElU
NjRCIHN1cHBvcnQiDQo+IC0gICAgICAgZGVwZW5kcyBvbiBPRiB8fCBDT01QSUxFX1RFU1QNCj4g
KyAgICAgICBkZXBlbmRzIG9uIE9GDQo+ICAgICAgICAgc2VsZWN0IFRJTUVSX09GDQo+ICAgICAg
ICAgaGVscA0KPiAgICAgICAgICAgVGhpcyBvcHRpb24gZW5hYmxlcyBNaWNyb2NoaXAgUElUNjRC
IHRpbWVyIGZvciBBdG1lbA0KPiANCj4gDQo+IC0tDQo+IEplYW4gRGVsdmFyZQ0KPiBTVVNFIEwz
IFN1cHBvcnQNCg0K
