Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA0069B7DD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 04:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBRDSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 22:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRDSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 22:18:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0110AA5;
        Fri, 17 Feb 2023 19:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676690283; x=1708226283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cari8Fr28XcEMyp7V1e0Wza2PRNRGsyKyRIW6+H6KvA=;
  b=G4K9YhKDxbZJVVsDwpeyHfMiFwRr1mAsSb1amFFDEQ6WDIZad80UrCAO
   iTJEwVNXBLYwgeDNMUJHgH7Sfw3nlPfBnGQDMgKLvg2TqLMY931bfVA+u
   Ft1KsCr4tm8vkZc2DYTVXWXOcjkb0p3c69T7tZzBcIuMX4FMGeUomOJIV
   lhDcVy78RtBcg2AmkFffleB5LAWMoa3vZ2U1kVe1LFvFmcZgmG1/nJHAu
   dFk8q4lVjDAqDVNYHTxm6ULSBAdnssRKThTXH0g2IaWVSiemUgt1eOHKf
   y1xbGPUBZXwaS7I7cCYigikUqIREBpDf1NXaYZYUblVxGZRKsVXJ6NvZV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="334336947"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="334336947"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 19:18:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="813560361"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="813560361"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2023 19:18:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 19:18:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 19:18:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 19:18:01 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 17 Feb 2023 19:18:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixCaafEv+Hgn6emdN6KdDGNs2/nec0vfGdRdSOmJHrb2EBugX1sI/gk7Hva1HLwU/iXRiT+hWZeSA4N7IauiVS/ebfxHq+3WpE0rozuYXsF9Go94Rx5DzOZMZj+IyWWdLECWaEdjE4p22FXedRVCedqfWnXJ6bW/wQ6QMAjABA31Hl+C4fn/J6pcVKZfEmVLsy9IVEf3Z8kfilLEEbmkv0T2gjR9HFxjxh3hOaGzU5r02HaWZDUemL2N1xn7PGHMkqNtgK7vaYsmEUSB86zn27SUX5sYN7lSUOJfMGnYMgJzI95UTk+Cbeh5sLsLR828z8DM1fqELKvS1s9rYPp9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cari8Fr28XcEMyp7V1e0Wza2PRNRGsyKyRIW6+H6KvA=;
 b=InOncW3Db/xL6GJfcRm2RrvXo70Yq7px25Ot7gMiuWliNTqqAsbjkd3uyEni3mx98GGzI0JSjO4ZAZcjzYV2Lw53EmREulsa5bHAZ91vPo2soLfHtDk2NUJ/1flYJ8v+gGKU6AeNYGAImL4imVe25Rm031cQxwGDf3EFpEsK7/JbHehpuoZJnhFy85bestZKkXVSxg1rz8ILgz6vR2yNdyfTrNlIAVCi1EJm8ufHIGSeug0zVnlFuV9UvON87/HwsL3VB9enr3AINVMlxfORSyfa0PhfPfdmT3oO1kxhKcRtDuhFQIM+WNQQGrp8mKbNP3D1BatBc3xsiM6pXXJAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 18 Feb
 2023 03:17:59 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6111.013; Sat, 18 Feb 2023
 03:17:59 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: dev_warn() on unsupported mixed mode decoder
Thread-Topic: [PATCH] cxl/hdm: dev_warn() on unsupported mixed mode decoder
Thread-Index: AQHZQzm/e5yCfnRjT0CayL76WPu6zK7UCLwA
Date:   Sat, 18 Feb 2023 03:17:58 +0000
Message-ID: <0b4ec83c92cf850b111c248dafdbc2d9439445d0.camel@intel.com>
References: <20230218013834.31237-1-alison.schofield@intel.com>
In-Reply-To: <20230218013834.31237-1-alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|MN6PR11MB8146:EE_
x-ms-office365-filtering-correlation-id: 78d512e3-c6c9-41bf-eed0-08db115ebc00
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrzGZO6p0O8G0LKIYiqqjVwx3dTrCD/QFAIE8qQ8ZjcB/J7Bbk6n44xAmrOGP6ke7t88iDMNcJkROwMkm9HI5h+M+ynx1IV9WuonK2RhQOMaCabRMETgqC3STxVI11u9ZyVjIbRpA3ZjP/8N26S9usggRyFY7c/rt7vy8smgikYP+ZUwF/GfQLIvcsjazGVldHknIyXNv2C3yepyDi3Nr4alsvBlRnhbY8F+CSoYIxoL+BKJRUuJi+Bmp3KwCYczoQRZcb9CYuAZNSSy7kSq1DdH6DVBGdv2LPvpdpJ+tUxb6/OC040QX1JHshYmHKk4zbC9uebnjBSiza96RzISAdI037tsWIFSR6KBKrc8uJxAhxZIhf9Q93SZo+YTZ9/cvp+fSICuzqUWAQ5gSvm7aI+U3+qEhGSw2TMU3z8xFebC+bjALBPtROytZjmitQ8PS5DQhnftIlkOvlc+eAwNsVyGM+upBhG7Eiw8PdE2jLtJMTdb3JFkkgpPcsahxFEZB8Gd2S1HwrC97O2aIEDvNYqlkjSPEMwQZ18YYnc3HLl+IKImQYUi31CIxarm1AkP7Eu1u5PDCgoXodE7lS4D7oItZD7xFFJ3jipkGCjDW8pGEVAwo3dXVOa6ksZOrLKGlKyNzEY8+veXXM4XpGpGWG62Qs1H3ZDa3eHjc7BL6h+38zh0Jj44CFLGq7VlKvEXGO/zFQ1lBpum3LOLozxkdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(2616005)(26005)(186003)(110136005)(38070700005)(6636002)(6512007)(71200400001)(38100700002)(6506007)(122000001)(36756003)(478600001)(6486002)(82960400001)(41300700001)(83380400001)(86362001)(8936002)(5660300002)(316002)(66556008)(4326008)(76116006)(54906003)(66946007)(64756008)(8676002)(91956017)(2906002)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWtLSVhtbGtFdXBuanV6YllFMUNEWmVpRHUzMHI5QzlRSTJMUVJlMnVVaDJY?=
 =?utf-8?B?OEhlMFB0TkN2dFBqQVVhcDhVdHoxNkNpY3lxdlB6NncyN0FFWHBGWXNobGdh?=
 =?utf-8?B?eStYM0xYeWZ3dy9TNnVGK1haVURxTWFoaTh6S3VkMHcxSWprMmgrZnBSMW0r?=
 =?utf-8?B?MjNxODJvTDRKbCtxcjhnQjI5L2F0bnMyVXBqeUlHTXpiVGQ4MjRoV2ZnYUVt?=
 =?utf-8?B?bk5QS3BITCtaN3MxMlVqQ2diaHpkR1h2UVpOMkJVdmRYa1c5dUwrbVRxR25E?=
 =?utf-8?B?OWZ5NUNNQ3hXYlBiR29YYklzaU1WU3BuTWY0OVQyWjZtcG9NSCthMmFybStr?=
 =?utf-8?B?NUdFMThDaTFJaHlXOFF3N0JZRlNRMXZGVE52OUZzSzIwZDUweHZoMWpTTzdu?=
 =?utf-8?B?YWMwbk1BaXc3OXJ6cUhZazZJaEhnbFNUZDhWWGYyUldhRmZLT2pZckJ0Q01Z?=
 =?utf-8?B?UTJlZFVyVk1XSk5NUWZ6YTQ3Y1NRYUJhaVI3aHVmN21XUlNSVEFZakxaVVVt?=
 =?utf-8?B?YXJRLzltRXBuYWw2OGlQWTJNK1pHdFlDRzVjRCtvREQ2RkF3L3RvUW95amZ3?=
 =?utf-8?B?RU9Jd1E1QStBTE9uK2dWS2FWcUZJUGx3RUUrV3lrc3dmNS9veFlISm9Dai84?=
 =?utf-8?B?cFliZGJ5emVablptYk9MVzMra1ZGSkFHQUpTanFubFVaa01hU3R6ZVdpQ2NS?=
 =?utf-8?B?OG8yb3JtamNmQ25ZTTYyckIwNE4zZ0ZmcXN3aG9NdUZsN3BScHpxRnZUNHZh?=
 =?utf-8?B?REZ6RGgzcklBandPbFNsUGQ1cW9DajBiUk0zR2xKOE9kZWoyWnZaTXNoUTl4?=
 =?utf-8?B?YzNEVnRJWVJ4VUQySmJCZ1RyemRqeDN0NUYwVGYwekhFeFZVZVdxc2hqSXJq?=
 =?utf-8?B?WldDYXlBcC9MaGQ2OVhLbE5CSEtNb0hUc2xEQ1Zzc3F3ZlAvRWxWbmY3aE44?=
 =?utf-8?B?enVaRkdJZG1QNmVzSUtjanBPeFN0Zi96VkRIMUlQVkswanptbFAxM3BlOXZW?=
 =?utf-8?B?NTV2VGg1b0RqS0FzTmo4TGZxcFpCdmZKVzhYdm52aVpINE1CaUo1aE12SjBn?=
 =?utf-8?B?Q09BRjBtOWQ4VXhDekJIRUpRUVFBa3VIT1o0dmJ3RTlLc3NjRXJxSHhmdU1z?=
 =?utf-8?B?WnhnaW4rVTQ3clEyMUJBdzBLRTMycllHejMybXpIODRSaFp0QlNZM1JUMk96?=
 =?utf-8?B?cEp0eWxPencxU2cvKzBTK0I0V2dzYmllaXQ1QUgvTEpGZFI3b0Z2UmZobVhF?=
 =?utf-8?B?ZFgxSWtkODkzakx5c0JUQ0Izc2g0ZXNiS3hJL3pOc0dUaHZZYjFaK3krQ0Fv?=
 =?utf-8?B?Z2NYcG9aV0lhY1hIaWJ4RkdMVVB6K3hGMGdkSFZKZnZjVDduR2E0anAvdzJv?=
 =?utf-8?B?ZzgzclEwcmRTWTh3NDFqdFRZSWdaTGNDWGJ3M2Y2VzA5NnArVS9JUmNzWkJN?=
 =?utf-8?B?TklDTSs3SFJ5U216c3kyYjNlajgxSUkwYjZKeDgvbVp2eWFmMU5rWkpVZzlz?=
 =?utf-8?B?aGdJb2VtWTAxc2EyR014SDBFMm1tZURRL2J2dmVSUGhuaWdPUk0vdnJNUVIy?=
 =?utf-8?B?bkRRT3Z1Vk1CT1kzZlBkMmhsVE9pSld3ZUpDU0ZxYkNYc2F5NWVRUWkxT0Rk?=
 =?utf-8?B?RmJndGZFRGxrT3lPWENCdlFOdm8rS0xxSWNLcWZpbElCeExKeWJUaVBudFZz?=
 =?utf-8?B?RnlKODc3a1ovSjE1ZktDZCs2RktpaWtyWG1YR1FYK3U5dkdDVHc3UkdNMXl3?=
 =?utf-8?B?eEo1aEpRSnZqYXFYdzVDeVZJMThSampRa1Z2RkNHTzVYMG1qdXZZME9XbGhN?=
 =?utf-8?B?ZzRPajZYQmRqZ0w0SjdCMFk5SndNTklaRlhyK0hESjNpVWhlWm84OFBVaER5?=
 =?utf-8?B?d0pKU2ZkcnI1aEdDVFBKU1p6R2tFbTdJVTJkSmpESnBvaitHQUQ4d3hCdzB6?=
 =?utf-8?B?S2I3R0RacTNoSk5wNWJlVVZneTNVSm56UUFHSGp2RGRLNUl0Nlovc2xQU2k4?=
 =?utf-8?B?RlFGbjVDajVmQ0w5Lzc3dGhuNnh3cFllaEpSNVRlTDdOalBtL0QxMSt4Z2Zl?=
 =?utf-8?B?TzYxcWxuS2V6cXlyclU4YVhDR3JTV1BxY2xQQlVUeFBkMktvak5xR3pVdnpP?=
 =?utf-8?B?SmpkcTBlaGZXNEg5TGVpTEF3bTFrQU1SL3h2QnM4MmlLbjRnS0JDeFFmMjNM?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0649D26E851A0041945487589DE7201B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d512e3-c6c9-41bf-eed0-08db115ebc00
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2023 03:17:58.1207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7uYwoKKk8kVO7bOUyPf1KQlrWKayltu9B0JGDaGm1NrsFZ4P8QsHfhvHcEatu5zqzTHys2PNYD1G+LpR2LYDlCInkc2wb1iNRzyVuZIBk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTE3IGF0IDE3OjM4IC0wODAwLCBhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBp
bnRlbC5jb20+DQo+IA0KPiBBIG1peGVkIG1vZGUgZGVjb2RlciBpcyBwcm9ncmFtbWVkIHdpdGgg
ZGV2aWNlIHBoeXNpY2FsIGFkZHJlc3Nlcw0KPiB0aGF0IHNwYW4gYm90aCByYW0gYW5kIHBtZW0g
cGFydGl0aW9ucyBvZiBhIG1lbWRldi4NCj4gDQo+IExpbnV4IGRvZXMgbm90IHN1cHBvcnQgbWl4
ZWQgbW9kZSBkZWNvZGVycy4gVGhlIGRyaXZlciByZWplY3RzDQo+IHN5c2ZzIHdyaXRlcyB0aGF0
IHRyeSB0byBzZXQgZGVjb2RlciBtb2RlIHRvIG1peGVkLCBhbmQgaWYgYQ0KPiByZXNvdXJjZSBi
aWVuZyBhbGxvY2F0ZWQgaXMgbm90IHdob2xseSBjb250YWluZWQgaW4gZWl0aGVyIHRoZQ0KPiBw
bWVtIG9yIHJhbSBwYXJ0aXRpb24gb2YgYSBtZW1kZXYsIGl0IGlzIGFsc28gcmVqZWN0ZWQuIEJh
c2ljYWxseSwNCj4gdGhlIENYTCByZWdpb24gZHJpdmVyIGlzIG5vdCBnb2luZyB0byBjcmVhdGUg
cmVnaW9ucyB3aXRoIG1peGVkDQo+IG1vZGUgZGVjb2RlcnMsIGJ1dCB0aGUgQklPUyBjb3VsZC4N
Cj4gDQo+IElmIHRoZSBrZXJuZWwgZHJpdmVyIHNlZXMgdGhlIG1peGVkIG1vZGUgZGVjb2Rlciwg
aXQgd2lsbCBmYWlsIHRvDQo+IGVuYWJsZSB0aGUgcmVnaW9uLCBhbmQgZW1pdCBhIGRldl9kYmco
KSBtZXNzYWdlLg0KPiANCj4gQSBkZXZfZGJnKCkgaXMgbm90IG5vaXN5IGVub3VnaCBpbiB0aGlz
IGNhc2UuIENoYW5nZSB0aGUgbWVzc2FnZQ0KPiB0byBiZSBhIGRldl93YXJuKCkgdGhhdCBleHBs
aWNpdGx5IHNheXMgbWl4ZWQgbW9kZSBpcyBub3Qgc3VwcG9ydGVkLg0KPiANCj4gU3VnZ2VzdGVk
LWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb20+DQo+IC0t
LQ0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvaGRtLmMgfCA0ICsrLS0NCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpMb29rcyBnb29kLA0KUmV2aWV3
ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9oZG0uYyBiL2RyaXZlcnMvY3hsL2NvcmUvaGRt
LmMNCj4gaW5kZXggNDVkZWRhMThlZDMyLi45ZWFmOTNjOGViYjAgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvY3hsL2NvcmUvaGRtLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9oZG0uYw0KPiBA
QCAtMjk0LDggKzI5NCw4IEBAIHN0YXRpYyBpbnQgX19jeGxfZHBhX3Jlc2VydmUoc3RydWN0IGN4
bF9lbmRwb2ludF9kZWNvZGVyICpjeGxlZCwNCj4gwqDCoMKgwqDCoMKgwqDCoGVsc2UgaWYgKHJl
c291cmNlX2NvbnRhaW5zKCZjeGxkcy0+cmFtX3JlcywgcmVzKSkNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjeGxlZC0+bW9kZSA9IENYTF9ERUNPREVSX1JBTTsNCj4gwqDCoMKg
wqDCoMKgwqDCoGVsc2Ugew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2Ri
ZyhkZXYsICJkZWNvZGVyJWQuJWQ6ICVwciBtaXhlZFxuIiwgcG9ydC0+aWQsDQo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3hsZWQtPmN4bGQuaWQsIGN4
bGVkLT5kcGFfcmVzKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl93YXJu
KGRldiwgImRlY29kZXIlZC4lZDogJXByIG1peGVkIG1vZGUgbm90IHN1cHBvcnRlZFxuIiwNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9ydC0+aWQs
IGN4bGVkLT5jeGxkLmlkLCBjeGxlZC0+ZHBhX3Jlcyk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY3hsZWQtPm1vZGUgPSBDWExfREVDT0RFUl9NSVhFRDsNCj4gwqDCoMKgwqDC
oMKgwqDCoH0NCj4gwqANCj4gDQo+IGJhc2UtY29tbWl0OiBhNWZjZDIyOGNhMWRiOTgxMGJhMWVk
NDYxYzkwYjZlZTkzM2I5ZGFmDQoNCg==
