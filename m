Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41A671EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjAROJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjAROIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:08:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E96258651;
        Wed, 18 Jan 2023 05:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674049691; x=1705585691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9y57evGyC9vMEhbfaWXyd6Gh/8bStxSMERrG7ryflHU=;
  b=Br5wHJqsnlZDj24nZzCvHL2Dhqnm4C1qrcpsBGBfK2/38C2+ugzBquGV
   nrS6qiXVdj8ESXXok/9CMQ4T2UvJpMLhR4Noeyk/JWmluYKlv/JhJzXTS
   Lqf1X4XmhsTNzPwU7VxiCSkWx8lthwTQJliSRMOmgyGVrrOw+zFuTlZ8+
   BSonmr0l+wk08f+5UC98LtLh94utw5H8VvJRpN9WVMp2mVEmrEQX1Z+fd
   8wd9IyuUbwMNMQ4+F9uIpFunPhNvgIEk5mPOQYp7/FIu4hG3qZhhmt2mi
   LUhqvcFb5oxFdEP5YxJzNEXRl+AGAFLZc+rT40x+288oLxgxD8X46EX93
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304665027"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="304665027"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783683641"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="783683641"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2023 05:48:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 05:48:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 05:48:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 05:48:09 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 05:48:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoQZxPwZ1knf7K7a2fTGMqSMv7aS+z3LZd/UJPfZDX0Dkc2cLF7YrcDGt+5DNsyBMDsNrCIFpNOpjNZrWJfIRG41o0a+QfiUU37gEyMnR4c3ljzUJN6EOD3viabAMABEpP2RjHOUvoyuRhZTzBJZvrIclGsR2G2NwJR3XhKKo1csXTAW5LYut71nDSdZ2laBxvMwJ9iLECImZqVjF/P3Q64XjA9ByFZrt7CJxzgnqomcJun+ruf3TCRBc1lOUCkN61yNlX+J/WHhFv+YNPn838XZRhtyjrf2EWWHfRKBedGwLKVuf3sgi3s65o8823SccKFsLTJwBPgL6KcUuHEr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y57evGyC9vMEhbfaWXyd6Gh/8bStxSMERrG7ryflHU=;
 b=jNv9VZI1ou/nOce+P0zxKH+lNp7/8Yhmoz7Tw0bMwB0vxOi94eNutfWg83wN5bRhruNjShqGD91zwHQvldttcbZwkHAluxFW1Ms+JR/P2Ue1WO8afHytLTSO6e08HtMdFg77ImUPu3K336ledgzkkGWLgz1dHY4m5rPtGr0+GRPQ1uIEEZyQSwFfp/OGF/BTNa4dBsWWPRqcPIX8X7Qm80wkQL2szu4APx8Ws+BG9xGbQRPtVnV5Wq2gC5p6uqIX1d8UmDF93gn8ypbcPyn2+KaBGFyZW0cxj27zNBc/PEXWl3LE8pfPjOhvr93oBvwlBAqLAmz1DEqWIXPqNMgD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 13:48:05 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 13:48:04 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Thread-Topic: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Thread-Index: AQHZJ3lIhuInf5xny0Wr04WwU0b0066j9nKAgABBkYA=
Date:   Wed, 18 Jan 2023 13:48:03 +0000
Message-ID: <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
         <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
In-Reply-To: <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB7856:EE_
x-ms-office365-filtering-correlation-id: d8b39f94-a9bc-4ea5-0682-08daf95a9f31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cbUTumh+tlnwqOU1PkC3EsLvyo7tkKppYFeca7CUUwWZHp3dxglBC9O/Kq/cAOM8a+bWy0rgqH3trMVyLXGAIynYQtp9M0Lv1vsAnXPYOdymH6ojIZEbmJf3GntVd50l6l80z0tyPzUrEZkqdvO6wEGVkoRDoYyGO9GHlxsnFyjx512vcms4UQCZxYJyQxae6wAI4ZzctX4qJZgnUWGB1wixNZJxuXxzhPIn8O+yxHPqLoNP9eO8XeaV9ltDl99eUlyr1RXJATYIgplkaE8EBTRpNEgpURgED3ISC03bx3/W4AXo80YTDVscEIECs2jDIBp93X+B8iWyCEA9JE8IsgWZZiK84obKT6Z5tAH4RfxLo53RfZAE0eXg5EHDTyvT+WnAG8FNwaW9ofb1uSAVl/zxKnOWJXotV+q5gpPtSehhwFqdyAd0z7+8cdp8MY6FooK3INgzZFqqVivcd5CSGeg/9JBEjtJ8XK0YFk/zwqpQpGxZIKqX3PtyibKpda2n5OxGGdUFz1hNH/m0xqbUYVgO9izbn4Dv4jI7MZ7/vFMNQJ9tHlhqJzNKeHlvb2OQUMgqJ2sS8dt+5WiETcHWfiKsrOzMOmL5ZCzimPlne344gPoU6fTlQ/KOUfAnhfHpOmAHfrUdQenhRg+9Sahoj7+MWaJxC2IUqvKu18s8siBR6nnmm8TERcVMrgWsp4Xj9cH5kYY4PSFycaWoK/+HU7ipHZsGqYkQrgxu9n6uUw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(36756003)(86362001)(66476007)(2616005)(66946007)(91956017)(8676002)(6512007)(64756008)(26005)(41300700001)(66556008)(4326008)(186003)(76116006)(66446008)(83380400001)(71200400001)(6506007)(316002)(478600001)(110136005)(54906003)(2906002)(122000001)(38070700005)(6486002)(82960400001)(38100700002)(8936002)(53546011)(5660300002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VSt6bWhOZHpOci9wVGdBdVNwdXBjeHl5ZWs4eGlYMnJ5dTJTYnpFZnJZeUhI?=
 =?utf-8?B?dWVQSUFFRTBVSThSWnpTOUVOMHJqYUt6MktOOVJPbUw0N3RLSEYvc3lrTHhJ?=
 =?utf-8?B?Z0VvejhnWmgvVUlqN3RIRVpmcjZHVDdUNGhrVk9TcWd3VWU1NGQyeHYvZkNv?=
 =?utf-8?B?djJFcXJrRnBnUDVFemJxa0orbWQvcXI0cHlBdGlab0FKQjAvWi9maWMvaUxC?=
 =?utf-8?B?WjhmVkYvb0Z2LzVFbCtwc0REU0ltOW4ybWNSOXA1TGJqZlZCdFovNjhFNUN2?=
 =?utf-8?B?d0s3UUNZOGg1b2xTWmUyWXRRRGgvQTVTdTVtdjh6Q1dsVjRyb0R4Z2VkQmlh?=
 =?utf-8?B?dHg5UDdjbXJiV1dKa3l0WXl3QmFQY2xTWmFxcDc2TzhyamZNb2x6V3dYZTQ5?=
 =?utf-8?B?TWJHSWlOaldTOHk3SGVCcDNZUE5WbGxPVC9QVzU1WXVFVjIrditnb2dlWG44?=
 =?utf-8?B?ZWNsZHVwTVVYcjFURUptNWJFWVpqaW9DakNvTVozUnlYUTQ3VXFheURCZTlH?=
 =?utf-8?B?NXhzd283V0c5K1RQRnN3Zk5IYklKYVF6WEY2TmFmcWFrNCtXZVZ3OXg3NTQz?=
 =?utf-8?B?MXRTLzBFa3pHV2p2T1gyL0o3V0kxbFFObEM1VXZmNE9SUVYwZXl6MFVTTFZw?=
 =?utf-8?B?ZUdabTBQMk1zeDI4a2tNVEplWDB3bVlBVXRhMEIrWVFtbUlwSjMreVFlWTBV?=
 =?utf-8?B?TTYzbEF1aWFMTnc2RThQS1VDS1JSQ005N1NDSk5KeE5FYlVpd3VsTlBjcXd2?=
 =?utf-8?B?S1NpcWZTK2s1TlkvNm52UWc3U1VIc1ZCK3BKcnU4S1ZPcDl2Yk94YTFqTDEv?=
 =?utf-8?B?bksveW5KU1ZYNDI0K1lPWkorTmZ2WlJGbHZzN1k5ODc2VTU4MUNpNjNvNDNi?=
 =?utf-8?B?Vjd6cnB0Z1V0VENXZ0lDRUxLMldhVkVsay9qd2ZnTXVnOE5MamUyUWw1WUp3?=
 =?utf-8?B?NXFOSGNvd0cxSWpINGEwVEZVdm9rSERCZlR2RTdhVnBhM1psb2pncjJkUHNm?=
 =?utf-8?B?OHBkazQ5WXNsTGUyTyt1cFQxSkFnMkRaekVLYThJemJxMElvYmJmMVpJcmg5?=
 =?utf-8?B?N3ErMEV0MkFwTzNDZ2dUMGNJaFkvUGhvMkNlUFJXc0hhMlFTMWdKNkF0N0lT?=
 =?utf-8?B?NTM1ZlprMzYxM0ZpTXJZMlFZVXk5VE5IanpXTFcrcXI1UWpGdGpLVFliZjRM?=
 =?utf-8?B?NDZxNEdUVnBQT0tjWUFLTVhHQjJaSFVPYy9LTmlhUk9HclUxOHBYYU14Sng5?=
 =?utf-8?B?aW04UmU1OG9iUzhaZFdGdXhZV0U0WkU0enUyemtRNXdpeGt4MW4ySElQUmxh?=
 =?utf-8?B?NlBGbm1hYStvekU0amZReEJDc3QveGdlZHo1ZEJPa28vOS9tMWp4TGpRRnlV?=
 =?utf-8?B?Nk1JeGo2SHBYSGNHNXhRSnBlSGJGbUhTaDdtVll3UnJFcm9XNmppZmZmV2do?=
 =?utf-8?B?LzdhRlQvN1N5d0RidXUzM2FDa05aWDhZZUtTSm1RY3YvaU4rUWsxbHJBdVNN?=
 =?utf-8?B?dUREUVVsanVqRTUxb1dVejdtRDlLSWxuaGd2enhrZVR6SnZ1K2JzcUpoNFZM?=
 =?utf-8?B?a1Y2QVhzaWpHZHRCd1gvZWI3YzJsQ3pLRjZ6b1F0eGw5Y3RFR3lwN0czWnRo?=
 =?utf-8?B?Y2dyTCtlaER6WXZ4aTFXanZDLzJvdWU1NHVFZ1lKT1F3Y0xwZ0FTWG8vOHE5?=
 =?utf-8?B?QlhTYnc5azNGYXJwV1IxOVNiZEJROUl3Y29YNnpHL3U0N3dUSjRCWUUzN1pO?=
 =?utf-8?B?dlFFRFhOT1JLVnc5STNvVHpmWENSKzNJeHJObnUrTVNVZmJzdWhkWmprOEIz?=
 =?utf-8?B?K0Q3M1pMRnV3c24ycWRMaytYSEdpZkdWbFo4ZjUxVCtiWStoMXhUM0E3VmJp?=
 =?utf-8?B?Zy9WNzhpWmpybEtUTHdkY05sV2tsdWp4WVdhM2ZrWFkwOERsS24vZFFwN3Fh?=
 =?utf-8?B?YnQ4eGZlMUoySzdkMkFjTlkwZzQ3Und2SGVVOGkvSUxsZ1ZIdmRjU21raGFD?=
 =?utf-8?B?cFRYamFoODg1aHlnOUZEQWJrS1RINDdxKzhUR0FQeEwvTnBOZXlKQjgxclJQ?=
 =?utf-8?B?dUgrQWk4Z1dMVmRtOTN5VXp2RWYvT0VXMklrNVdYaW5XeFpWS0xUaVluUUdV?=
 =?utf-8?Q?YCtTAVZjmu7Jl3jovUbUWDEPr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22DB60290809B3419565DA4A119519D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b39f94-a9bc-4ea5-0682-08daf95a9f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 13:48:03.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EeDUyfQs3td/VcSRRwPRUsuFROU/SVjvyy9O0INMZBbsBBzKdHQKeS/2+mV6vFGO/eDivkYGCkK8yhWfGRlNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDEwOjUzICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gSGksDQo+IA0KPiBPbiAxMy8wMS8yMDIzIDE5OjAyLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gPiBSZWNlbnRseSBzZW50IGFzIGEgUkZDLCB0aGUgdGhlcm1hbCBBQ1BJIGZvciBnZW5lcmlj
IHRyaXAgcG9pbnRzIGlzDQo+ID4gYSBzZXQgb2YNCj4gPiBmdW5jdGlvbnMgdG8gZmlsbCB0aGUg
Z2VuZXJpYyB0cmlwIHBvaW50cyBzdHJ1Y3R1cmUgd2hpY2ggd2lsbA0KPiA+IGJlY29tZSB0aGUN
Cj4gPiBzdGFuZGFyZCBzdHJ1Y3R1cmUgZm9yIHRoZSB0aGVybWFsIGZyYW1ld29yayBhbmQgaXRz
IHVzZXJzLg0KPiA+IA0KPiA+IERpZmZlcmVudCBJbnRlbCBkcml2ZXJzIGFuZCB0aGUgQUNQSSB0
aGVybWFsIGRyaXZlciBhcmUgdXNpbmcgdGhlDQo+ID4gQUNQSSB0YWJsZXMgdG8NCj4gPiBnZXQg
dGhlIHRoZXJtYWwgem9uZSBpbmZvcm1hdGlvbi4gQXMgdGhvc2UgYXJlIGdldHRpbmcgdGhlIHNh
bWUNCj4gPiBpbmZvcm1hdGlvbiwNCj4gPiBwcm92aWRpbmcgdGhpcyBzZXQgb2YgQUNQSSBmdW5j
dGlvbiB3aXRoIHRoZSBnZW5lcmljIHRyaXAgcG9pbnRzDQo+ID4gd2lsbA0KPiA+IGNvbnNvbGlk
YXRlIHRoZSBjb2RlLg0KPiA+IA0KPiA+IEFsc28sIHRoZSBJbnRlbCBQQ0ggYW5kIHRoZSBJbnRl
bCAzNHh4IGRyaXZlcnMgYXJlIGNvbnZlcnRlZCB0byB1c2UNCj4gPiB0aGUgZ2VuZXJpYw0KPiA+
IHRyaXAgcG9pbnRzIHJlbHlpbmcgb24gdGhlIEFDUEkgZ2VuZXJpYyB0cmlwIHBvaW50IHBhcnNp
bmcNCj4gPiBmdW5jdGlvbnMuDQo+ID4gDQo+ID4gVGhlc2UgY2hhbmdlcyBoYXZlIGJlZW4gdGVz
dGVkIG9uIGEgVGhpbmtwYWQgTGVub3ZvIHgyODAgd2l0aCB0aGUNCj4gPiBQQ0ggYW5kDQo+ID4g
SU5UMzR4eCBkcml2ZXJzLiBObyByZWdyZXNzaW9uIGhhdmUgYmVlbiBvYnNlcnZlZCwgdGhlIHRy
aXAgcG9pbnRzDQo+ID4gcmVtYWluIHRoZQ0KPiA+IHNhbWUgZm9yIHdoYXQgaXMgZGVzY3JpYmVk
IG9uIHRoaXMgc3lzdGVtLg0KPiANCj4gQXJlIHdlIG9rIHdpdGggdGhpcyBzZXJpZXMgPw0KPiAN
Cj4gU29ycnkgZm9yIGluc2lzdGluZyBidXQgSSB3b3VsZCBsaWtlIHRvIGdvIGZvcndhcmQgd2l0
aCB0aGUgZ2VuZXJpYyANCj4gdGhlcm1hbCB0cmlwIHdvcmsuIFRoZXJlIGFyZSBtb3JlIHBhdGNo
ZXMgcGVuZGluZyBkZXBlbmRpbmcgb24gdGhpcw0KPiBzZXJpZXMuDQoNClRoZSB3aG9sZSBzZXJp
ZXMgbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdA
aW50ZWwuY29tPg0KDQpCdXQgd2UnZCBiZXR0ZXIgd2FpdCBmb3IgdGhlIHRoZXJtYWxkIHRlc3Qg
cmVzdWx0IGZyb20gU3JpbnZpYXMuDQoNCnRoYW5rcywNCnJ1aQ0KPiANCj4gVGhhbmtzDQo+ICAg
IC0tIERhbmllbA0KPiANCj4gPiBDaGFuZ2Vsb2c6DQo+ID4gICAtIFY1Og0KPiA+ICAgICAtIEZp
eGVkIEdUU0ggdW5pdCBjb252ZXJzaW9uLCBkZWNpSyAtPiBtaWxsaSBDDQo+ID4gDQo+ID4gICAt
IFY0Og0KPiA+ICAgICAtIEZpeGVkIEtjb25maWcgb3B0aW9uIGRlcGVuZGVuY3ksIHNlbGVjdCBU
SEVSTUFMX0FDUEkgaWYgQUNQSQ0KPiA+IGlzIHNldA0KPiA+ICAgICAgIG9ubHkgZm9yIHRoZSBQ
Q0ggZHJpdmVyDQo+ID4gDQo+ID4gICAtIFYzOg0KPiA+ICAgICAtIFRvb2sgaW50byBhY2NvdW50
IFJhZmFlbCdzIGNvbW1lbnRzDQo+ID4gICAgIC0gVXNlZCBhIHNpbGVuY2Ugb3B0aW9uIFRIRVJN
QUxfQUNQSSBpbiBvcmRlciB0byBzdGF5DQo+ID4gY29uc2lzdGVudA0KPiA+ICAgICAgIHdpdGgg
VEhFUk1BTF9PRi4gSXQgaXMgdXAgdG8gdGhlIEFQSSB1c2VyIHRvIHNlbGVjdCB0aGUNCj4gPiBv
cHRpb24uDQo+ID4gDQo+ID4gICAtIFYyOg0KPiA+ICAgICAtIEZpeCB0aGUgdGhlcm1hbCBBQ1BJ
IHBhdGNoIHdoZXJlIHRoZSB0aGVybWFsX2FjcGkuYyB3YXMgbm90DQo+ID4gaW5jbHVkZWQgaW4N
Cj4gPiAgICAgICB0aGUgc2VyaWVzDQo+ID4gICAgIC0gUHJvdmlkZSBhIGNvdXBsZSBvZiB1c2Vy
cyBvZiB0aGlzIEFQSSB3aGljaCBjb3VsZCBoYXZlIGJlZW4NCj4gPiB0ZXN0ZWQgb24gYQ0KPiA+
ICAgICAgIHJlYWwgc3lzdGVtDQo+ID4gDQo+ID4gRGFuaWVsIExlemNhbm8gKDMpOg0KPiA+ICAg
IHRoZXJtYWwvYWNwaTogQWRkIEFDUEkgdHJpcCBwb2ludCByb3V0aW5lcw0KPiA+ICAgIHRoZXJt
YWwvZHJpdmVycy9pbnRlbDogVXNlIGdlbmVyaWMgdHJpcCBwb2ludHMgZm9yIGludGVsX3BjaA0K
PiA+ICAgIHRoZXJtYWwvZHJpdmVycy9pbnRlbDogVXNlIGdlbmVyaWMgdHJpcCBwb2ludHMgaW50
MzQweA0KPiA+IA0KPiA+ICAgZHJpdmVycy90aGVybWFsL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA0ICsNCj4gPiAgIGRyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArDQo+ID4gICBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0
MHhfdGhlcm1hbC9LY29uZmlnIHwgICAxICsNCj4gPiAgIC4uLi9pbnQzNDB4X3RoZXJtYWwvaW50
MzQweF90aGVybWFsX3pvbmUuYyAgICB8IDE3NyArKysrLS0tLS0tLS0tDQo+ID4gLS0NCj4gPiAg
IC4uLi9pbnQzNDB4X3RoZXJtYWwvaW50MzQweF90aGVybWFsX3pvbmUuaCAgICB8ICAxMCArLQ0K
PiA+ICAgZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3BjaF90aGVybWFsLmMgICAgIHwgIDg4
ICsrLS0tLS0tDQo+ID4gICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9hY3BpLmMgICAgICAgICAg
ICAgICAgfCAyMTANCj4gPiArKysrKysrKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvbGludXgv
dGhlcm1hbC5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArDQo+ID4gICA5IGZpbGVzIGNo
YW5nZWQsIDI4NiBpbnNlcnRpb25zKCspLCAyMTQgZGVsZXRpb25zKC0pDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfYWNwaS5jDQo+ID4gDQo=
