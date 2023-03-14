Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8A6B87FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCNCDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCNCDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:03:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04747136E9;
        Mon, 13 Mar 2023 19:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678759400; x=1710295400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=42DkDh+TikTLHtwtqU/NI9qAJooXuNAiEhS83CQ09Mc=;
  b=GR9bihMSLxD9tAHh4uWJKWwapqmkBEJa/ogyChFg14TWkqGOCxbx/3da
   FNuEJdBqFwklTOCeUctg2NaQi26sIWTIDmzFo899S4GJFZgkjWxzv/xaM
   Cp+DjT+l1sBHHtIrTIlE6J6wpetrG86VeNfpmVC9XCEwbPsF/UPaXQjVP
   6AXwb6DVYIFeHD1WQobk2fwd8+erC0BatRXfsguWXw8Tgew/l16PCN7Pc
   jzsmmnE7YyTarrmfdBOqDVFUcBHQAnQ7e4McKz51rjgY45eU3gdhpsEZx
   3Pwk9mY+kd4DT9LpQry867aDzyeZqiZdBAEP1mnuU5O8eT5H9TghlTqRP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325671245"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="325671245"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 19:03:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747827248"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="747827248"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2023 19:03:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 19:03:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBJ5cfPt2/v0gGUFHuHoeX5/EQnQqXh+/K9DI9MgC+S7GFwlwhOOQ55AsAOHyzm7lLK7VVXFmO+MrPsPLRV4gcum6ZFykwnVWa3UWXi6WRBLUOyM3M0tJ4lq6KEybnwWy7wWRq7Q4CqewYGDyzNF0vf4rV1d3+cVMOeE0om1CtkUcPfEqI0E164AwPqBiHiY/7/0aRDExdIy7cHnsZBLdkvzcgyuKmwqADfCgKjrDFEkJyEnRkr5sLxuYw5+FvUi3RSuX7cySOg217LX7Nym+pSIO9ARJv5/xzePjmGpxd3Y9muEZ42oPgcKqN0iDfo+9u9WBk585FcJdOwpy19iLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42DkDh+TikTLHtwtqU/NI9qAJooXuNAiEhS83CQ09Mc=;
 b=bjcuNLdNd/amGTyrfMMNpzyak3gxnd57TYBj6mrDAQN4wpFgsc5wgJrPpMd/ZKJo2zlvYXRGY2fYHbkIdzeyCg5wbTdi492jaczldl9Vbj1qRyoZ/NkSPxN29h/gmNyyG/6l9EazIcRxrX4l/03E1F7QXZcQlKy3KruUj2ugJnDcPTcyXctx0wZCAA7weChcq7uPqqe3VFkjZYekihcB3SxmYyDc6pE02g9lapi4M7tu37feiRAszpHRPjb3+wn+uMngvp6095z1vaRxYpQS+Uu3qWtUqli8xHin68Qf1KsC1aYHwWy0RN+7QFtAMyK0y3orFzMAGw7FAIk4p+dwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Tue, 14 Mar
 2023 02:03:13 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:03:13 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] thermal: core: Introduce
 thermal_cooling_device_present()
Thread-Topic: [PATCH v2 2/4] thermal: core: Introduce
 thermal_cooling_device_present()
Thread-Index: AQHZVbj3JROhUeuk/0G9RpRXN9sXQq75htEA
Date:   Tue, 14 Mar 2023 02:03:13 +0000
Message-ID: <73f967b1d112a02fd3e48f999f713355da052d9a.camel@intel.com>
References: <2692681.mvXUDI8C0e@kreacher> <4488488.LvFx2qVVIh@kreacher>
In-Reply-To: <4488488.LvFx2qVVIh@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB6452:EE_
x-ms-office365-filtering-correlation-id: 3020ba9e-7b06-4f6b-190f-08db243044d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYq02N5AmDY12Z2YwFRW8ktrtsWozywZbem7+X7Jcsfa8UJT8U/8umvulXYudWS96vtMFS9MEiEGDa3JbMxDzoU/5Nq+SzekRHVD4C/BkDEwspNCYo3FM6oq7JA4bKtMcs+GdxoDEskeAAWDlrZp+cN+cIV/IfA79fTUz02hqseJHQwIZkXcJ7/OrTvE3E/xZwxTFfO4Zzf80YZpPQD3pNJyZkExgeL3YVO1PtQ/101RUiigkI1mkILlX/LUaoiadZFOtUfU67eYNi9p+oNbk51dIdsg7MxfG5vWLGsue0EBNpUNM4gDUl01pW+3G2Vgs3tsfZVDZ/RByOgVLl4D+JW5kVbLuILqfHnVW78GRc0HEcrdvlaMr1HWEtiguwwoYIPtZ1L/pw5Hz9ud15L7CvgHG/8hiCBselSFO9tX4zVcsBMwgV/KatOQ8xcj+3qDvmVe36b88HJAF2KyuC/GNC3zXF4MMLZvHlDuvqK3yCP25EROP0MIkbz7C7Vd5Tn1jD5SkhKRZEiBZjVCnTnKiDpLIWLy+gzNa5F0DJLJq6mLaWJFwqzSkg30TqtEmgjV6VVO1rh46AyKJ+fvQ7C2Y9VLbeWACwSXHpMHrunBqw2lc6jVV6/242gItfQxKK0Wd5NB7ZgtgmEyk70r9GAW5Cd8lGp/rDkUn/u6eRyNGGVmmdYKWvSOErZwJYRbu64H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(84970400001)(2616005)(2906002)(186003)(38100700002)(122000001)(82960400001)(26005)(6512007)(41300700001)(38070700005)(6506007)(83380400001)(5660300002)(478600001)(316002)(8936002)(64756008)(54906003)(110136005)(36756003)(66476007)(6486002)(91956017)(86362001)(8676002)(66946007)(66556008)(66446008)(76116006)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWpMeXZBWWVJUStHWjJ5VWtKODFXbEdFdUZNZHhqcXNidFYwSDl1QlpzaDZ5?=
 =?utf-8?B?eFhmTU5OZEg2bW1xSlBhZEtGS01rWFNwOUpRK3h4T0xBSUZsOHlaSUFIaGox?=
 =?utf-8?B?R1kzUDZjejNXYjBuSlNldEl1OVBJbXZRek5DVTVOSkhoWUkvZWxGaVNSYUxk?=
 =?utf-8?B?Z3VjQW12dmxPUzNnQlRVVWtEOEltNlBzYlZBVTBGKzNtNndxL2ttc1ZieGhQ?=
 =?utf-8?B?YVRGcklvbzh3TkNPNzRNY2VLQlBIdWdmMXYyalFEK3FxZWEzdFZ5S1dMYmVy?=
 =?utf-8?B?eGNRZ2tvN09EcE4xbWI3OEFIdUNlTWh4MElYZGc4aHREclp2TVlieEJ1eVBi?=
 =?utf-8?B?bkNDOEZ1ajB5KzhDMkxVcG1aRGYwUDFGL3hvaWRGcUhYWm95MEhNeDZtbVhK?=
 =?utf-8?B?TXc2S0Q4UytYOXFlTGNYb1RPOUNWSmxUQUdpa2FacU5zVjlhellkWm5vcERU?=
 =?utf-8?B?VTRkQU1zeGNZZ2czWFhYQ2NrRmdjMjUwU3FwV0lHTW9FbnlabzJGZHpxRURv?=
 =?utf-8?B?ZldBRlc3dExIWGZyNXloZURKK0tJTFoxd2JsT0tsbTV4d0srbGk4VFptUWVT?=
 =?utf-8?B?bjFqc1VGbkgwM21jRnl2dFN4MFhDdXZXUTUxWEx5S21wVXg5SmpYMURLVmFm?=
 =?utf-8?B?TnlDblg0QmVuRG9ybTFacU5zSVI1ZFZXWTZrSjhRSkVKNk5tUGlVcXgzSXVK?=
 =?utf-8?B?MXZPaVpVNWNhRENKTkMxY3k2UVFtWlU3cS9MeFkraFRnYUsvUWpFQXhiRFVU?=
 =?utf-8?B?Q0tDeGhmRnhTbks2RVh5b0NzbDJER2c1TXQyNHd1RVlYYjVyZnc1OTF5dkZa?=
 =?utf-8?B?QUxBanBBaEY5SllqZnF0QnRuL3ArV2hSOXNYU1BMREoweFZ1bEpjcjF5eTJ0?=
 =?utf-8?B?TWhnNHc4OWdxUE11UmF4OFQzcm9NMElJLzRCa1hIT25taVBiUDFTT2laeGJn?=
 =?utf-8?B?WXh5QTk4bXF3NlVKd0drQlc0UWdJSXVzZFQ2NEM5N3JSVE9yeHZEUHFzVzF2?=
 =?utf-8?B?OGQyc3EweXJhRjhmWHk3K3FsbUdOMTEwY1I2c0tvaTl4QlNyeUxFb2FTN0ZN?=
 =?utf-8?B?L3A5bUZPYnhXRU1aWWpudVJ4dWFxMGlqM0lJYkhvNS9JYytLU1FZNTBXc1B2?=
 =?utf-8?B?ank4UzQxS25JTFpOeUdoM2YyMXd0SGFRa1I4YVJvbTlFaW51UkcrckRITTk0?=
 =?utf-8?B?bjIyQnJBVkVVQ1ZZRGNkNnRKZWlJblkxRUUyN3ZNa3d1ck5xRVJPbXNJRkJu?=
 =?utf-8?B?NmJYUDJWSWh5MEZvYmdnTFY5TXB6MTYxeFpaTHM4OFJSdGNMdlV1cG5zZXdk?=
 =?utf-8?B?WjJkSmowQmc1bVRBTWovYklsbmFnNXBQQlphcGVzVlBURDdweUE3QUNjQXcy?=
 =?utf-8?B?OUo5WGZneUQ3eXZvczVEQm1WWVZLdFVzbS9JQ3MyUkdvV2RzMGtyMUZHU0pl?=
 =?utf-8?B?eWgvOFFsSmZNbjJnZGRlaDQxWWlkcGRiTitOQXBFK25WK0tjMmpDMkJ2OUhm?=
 =?utf-8?B?YjBlR0tHUmpOSUZUcG4xUWg3UVdIV2xNMXJMRVhQUC9mSWliZXl0cUJPeExa?=
 =?utf-8?B?VllGZ3JVSDJEaE1aKzlURVdqK2xtOHdHWFM1c3NQVDUvMlNnMGtKQVJKOXhO?=
 =?utf-8?B?cklyLy8wdkNxL29YbXZTZ0pEOUkzTHF3SG45QmhUNGJNWWwvdDY5Ti83OVBs?=
 =?utf-8?B?N1UrS3JtRG9sYktQamY1b2J5akJ0aENmUGRYWmg1RDJpSDFnWnpTTkdyOTVj?=
 =?utf-8?B?Rms0RmRJU1JFaTN3R2tIeVZGakNYTkF2SG1ZcGg5QTZvMmg0Z3A5TWFsTzVl?=
 =?utf-8?B?djJqNVdjMkpaZllOQ1h1QzZ1Y25RWXYwNHZDZXF5ekVZM3FhNEhJVjAySTdj?=
 =?utf-8?B?djBUeHJnSnByeHlNQVN4Wm9pYW1LTU5LcVVYS2ZpN2tvU0hOc28vaWZra1Zi?=
 =?utf-8?B?NmQxMWlWMDNFUXplZkxxMHFNRjhmemd0UlRoU3ZnSWI4WS96YmFnT2FMc053?=
 =?utf-8?B?cHJOYXcyK3BwVlJkVnRJc0VEQjVCK3c4UEtzTjE1dGtyallCODNqaWdpbTdn?=
 =?utf-8?B?a0hVZ3pVRTk5M3JlTi9HeEg2SWZvU2NKczBFbFlCQlc5SlFWZi96RlpFd0Uy?=
 =?utf-8?Q?SesC1Cm9IopcRK0Ix1biTwmkm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5E0BE2B4337AA40B54EEC4852132E5B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3020ba9e-7b06-4f6b-190f-08db243044d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:03:13.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGzu4sNn4+l7/KzGTDPcDz+exyd+eDpMfXUNuQ3QU2aD5R9rX+XbNS8e1bGFqBFyc5jGti4imrWGl2BKUKjSig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE1OjI4ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gSW50cm9kdWNlIGEgaGVscGVyIGZ1bmN0aW9uLCB0aGVybWFsX2Nvb2xpbmdfZGV2
aWNlX3ByZXNlbnQoKSwgZm9yDQo+IGNoZWNraW5nIGlmIHRoZSBnaXZlbiBjb29saW5nIGRldmlj
ZSBpcyBpbiB0aGUgbGlzdCBvZiByZWdpc3RlcmVkDQo+IGNvb2xpbmcgZGV2aWNlcyB0byBhdm9p
ZCBzb21lIGNvZGUgZHVwbGljYXRpb24gaW4gYSBzdWJzZXF1ZW50DQo+IHBhdGNoLg0KPiANCj4g
Tm8gZXhwZWN0ZWQgZnVuY3Rpb25hbCBpbXBhY3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWZh
ZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQoNClRlc3RlZC1ieTog
WmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8
cnVpLnpoYW5nQGludGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVpDQoNCj4gLS0tDQo+IA0KPiB2MSAt
PiB2MjogTm8gY2hhbmdlcw0KPiANCj4gLS0tDQo+ICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9j
b3JlLmMgfCAgIDIxICsrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBJbmRleDogbGludXgtcG0vZHJp
dmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gLS0tIGxpbnV4LXBt
Lm9yaWcvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ICsrKyBsaW51eC1wbS9kcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gQEAgLTEwNDUsNiArMTA0NSwxOCBAQCBkZXZt
X3RoZXJtYWxfb2ZfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIoDQo+ICB9DQo+ICBFWFBPUlRfU1lN
Qk9MX0dQTChkZXZtX3RoZXJtYWxfb2ZfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIpOw0KPiAgDQo+
ICtzdGF0aWMgYm9vbCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3ByZXNlbnQoc3RydWN0DQo+IHRo
ZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXYpDQo+ICt7DQo+ICsJc3RydWN0IHRoZXJtYWxfY29v
bGluZ19kZXZpY2UgKnBvcyA9IE5VTEw7DQo+ICsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KHBv
cywgJnRoZXJtYWxfY2Rldl9saXN0LCBub2RlKSB7DQo+ICsJCWlmIChwb3MgPT0gY2RldikNCj4g
KwkJCXJldHVybiB0cnVlOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBmYWxzZTsNCj4gK30NCj4g
Kw0KPiAgc3RhdGljIHZvaWQgX191bmJpbmQoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6
LCBpbnQgbWFzaywNCj4gIAkJICAgICBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2Rl
dikNCj4gIHsNCj4gQEAgLTEwNjcsMjAgKzEwNzksMTcgQEAgdm9pZCB0aGVybWFsX2Nvb2xpbmdf
ZGV2aWNlX3VucmVnaXN0ZXIocw0KPiAgCWludCBpOw0KPiAgCWNvbnN0IHN0cnVjdCB0aGVybWFs
X3pvbmVfcGFyYW1zICp0enA7DQo+ICAJc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6Ow0K
PiAtCXN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpwb3MgPSBOVUxMOw0KPiAgDQo+ICAJ
aWYgKCFjZGV2KQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAltdXRleF9sb2NrKCZ0aGVybWFsX2xp
c3RfbG9jayk7DQo+IC0JbGlzdF9mb3JfZWFjaF9lbnRyeShwb3MsICZ0aGVybWFsX2NkZXZfbGlz
dCwgbm9kZSkNCj4gLQkJaWYgKHBvcyA9PSBjZGV2KQ0KPiAtCQkJYnJlYWs7DQo+IC0JaWYgKHBv
cyAhPSBjZGV2KSB7DQo+IC0JCS8qIHRoZXJtYWwgY29vbGluZyBkZXZpY2Ugbm90IGZvdW5kICov
DQo+ICsNCj4gKwlpZiAoIXRoZXJtYWxfY29vbGluZ19kZXZpY2VfcHJlc2VudChjZGV2KSkgew0K
PiAgCQltdXRleF91bmxvY2soJnRoZXJtYWxfbGlzdF9sb2NrKTsNCj4gIAkJcmV0dXJuOw0KPiAg
CX0NCj4gKw0KPiAgCWxpc3RfZGVsKCZjZGV2LT5ub2RlKTsNCj4gIA0KPiAgCS8qIFVuYmluZCBh
bGwgdGhlcm1hbCB6b25lcyBhc3NvY2lhdGVkIHdpdGggJ3RoaXMnIGNkZXYgKi8NCj4gDQo+IA0K
PiANCg==
