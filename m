Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFB68CE29
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjBGE1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBGE1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:27:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF112A992
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675744024; x=1707280024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o39rLAEF2o7nT1jds5a4iVEOVIgAZcsBAAw8cOVBgxY=;
  b=b8Ds2LDY99xxawBGGGDOUpaIV7X9oqtdHhuxxwtB4rOVrw2LPYsttK8W
   SiO1gqItngIf9Ecs+2BK9PG3CtElcxIY3hFYmTy/Q76EN/ljT2I33VVsR
   oqoaJXrdETrGwheDXghmE+FiLeKGrcj3LMAT1FP1sgqcpoXFDUNU2Ir7p
   N63AmpBXsl527jasXnEw1w0ZpdXGVMMOJxhrmG3eNGT9bpWzHBwDY4HXD
   DDr+a4hLyLDXAkdepCOcfytlu9WJH7x7SWkW3InpmfYmTbVH02tkvse3o
   IhHPpRKbKT30i15lROegMNk5ApxluexyKvdseH/RNe+59meLHBObwiBU2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327088119"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="327088119"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995591700"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="995591700"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 06 Feb 2023 20:27:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 20:27:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 20:27:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 20:27:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 20:27:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Priiqd12IcmWW3cG+Rg+zOQe3mvL51InPqxWRieHKqHORlA4l2YPydKOvkbA6+SrjG0+Tde3mqjXtWMCNcBwjb1OKChW1Hor7KiMY4OLOwToW8VmrupTXZ4Bs5dP1XJqVxAe5pE+BrZ+i3K3PqCAZbS2VERl70PUAb2nprRcDGxkekkg42QaVhNajiNlHrbj/TZUuNvHdH3/DQV5FRObTKJRHR15guvCvk5PXy/KNS7wojzSKlWvuPuAv7wU2qaWZWSdEMB4RdnX/2S0fdmTJdmemoUeZrS+bQf5WJ8Frk8OV0Ffh/Lmiy7nyE/k5i6WaMfmltdh1oAVAYpCRGBXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o39rLAEF2o7nT1jds5a4iVEOVIgAZcsBAAw8cOVBgxY=;
 b=IJ9UAxBE9YM2trem5Xpriy8HrWkpFwpBHP3qoSyzRifrSfZlK1drILWgYXnWg/OK3zalgdBS60sf8cnZxldljfaTwZjKFy9kVaTjiLEapS4COZipt6b3ovy7pWU+Ih6SM9XnDVU01xYZUpoguymQkvA0qN3g8SOOzNaLppGv+VQtQvZq6bUDEZmOHHPNkTdZHhPHDvgpX0bWlZbH4/JEsEGS/dEahna7XDs0GdQM4LLeTT7lJQUlZQo19kMzRycAKFUBW2uBef6/e4MNW1S3I14PBm7ixHP/8xtR5RLSgXkJMWHxnKfJH+UoNFeuz6qsnD/QDGiI8Nj475V6rn+AtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB5267.namprd11.prod.outlook.com (2603:10b6:610:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 04:27:00 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3%3]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 04:27:00 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Topic: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Index: AQHZM14a8sLMOu4lm0Wu+eywCVc4o663EP2AgABKGICAAAZKgIAABAiAgAAIrICAAkADgIAAlbUAgAAfq4CAAA5XAIAADUMAgAhxpPA=
Date:   Tue, 7 Feb 2023 04:27:00 +0000
Message-ID: <DS0PR11MB7529B172C42CE49EA45A72A9C3DB9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com> <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com> <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com> <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
 <Y9qK3nJHjU4Bvxaf@nvidia.com> <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
 <Y9qxdinaS6anoWhH@nvidia.com> <Y9q8llC0JVokHLf7@Asurada-Nvidia>
In-Reply-To: <Y9q8llC0JVokHLf7@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CH0PR11MB5267:EE_
x-ms-office365-filtering-correlation-id: a49647d4-aa8f-4c1e-0416-08db08c38ea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VjJc8KNuNPDfIFvaiKVZ6TCP7TqIXcQYuiUL02W2pM+JOzHOe09u5x7vNg6vfKIzWJSweZOD69vfglf6VQfX4BkK2EUuI0ADBa/AUfwcS8JosvM4HK9heHyEs5eF6QzWB5dVxy8xjQFrJf5az5MaOr/HPTXDhjnnMAIUA7uQkImLpErQSn7Ib58QN0r6ZK/Os6I+o6D1tdY2HXBeA+MkGzBE3LsnJzZxSJGFcC55OQwIE6Feg1PBp8glzR+Wrhzd3s6aJitMIhdc5WGGLvZTDq/3y+B4yk36H6K2JP1MzbnJpQmyxJSczlWM9A9bI9Qq5AUaLdCAgOSwD/HyCkIqd+nNxhitLdIBYnNOdts3McgObgfoswY1ngVf88/fW6y7Grwi1H+nXBcIpQ0gEUjZXV5LX75fzq+zyvt9bw+kQC5rUkt7Fi+YYDgHzEK1NecFUVpXWQB6rOW1U9tTUc8hENkLj1HdpwlNhiU2aAceEjgD3mBv6xGe009uTIMpGnC1z2SXFSNOpEW1L0v+Unp905Oj7oweqdlKbYvrljdT93qB/hXqgPvbdytAQxlf2eXgTBboZKPUXhdoxuTgQsvOJAbS4M8ixYR8bodZp+nDoydTyjt7tD3T/G4lhNDW7YaQWKCl2gDOcd11e4QwmoCfviyJPxdszm/HN+wJNgxtwDOoc59Ctlesd/dUQ1b9HGsNUzLw4egVd1xgUI9+FYvD9WDXvpJjPccCQRAEskUjOg1rxpyVXPWvbERfjkrY8I2Tin3uyXFmiMb7DI6Wg5e1JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(186003)(6506007)(33656002)(966005)(9686003)(26005)(38070700005)(82960400001)(38100700002)(122000001)(54906003)(478600001)(110136005)(52536014)(41300700001)(8936002)(2906002)(55016003)(5660300002)(71200400001)(66446008)(7696005)(66946007)(64756008)(4326008)(8676002)(66476007)(316002)(83380400001)(66556008)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3RHMUFVeVJURGdGcFhseTB0RkplcFJPWm1NclBySUtid0h0MkNZT3RMcDJP?=
 =?utf-8?B?R3dpcGdIV29vMDdCTEdTTVBWZEIxKzZmSjBTZXpzVW12aStBWFd4QlYza2hI?=
 =?utf-8?B?SDNYUHI3b0FGS1MrQkQ2WWZGU0ZFVmFBTDFLNThSV1cwWHFSY3ZlTEwvbXR3?=
 =?utf-8?B?UDYxcVZ3MEdUQytDVW5tQUJvcUdQWE5QbEZ4S2pMSFBRaElkdUdtbjk4VGxW?=
 =?utf-8?B?SC9CMmU3UnAyUmZmL1BaT0ZwK0duME4wN25BL3lsNjZJZVpvdTNIaTR5NXhM?=
 =?utf-8?B?SWNzZWVWOXVRUkE5YTJzTWxBWUVLbWxicHM0OXBGTXQycitsejZkaElna1F3?=
 =?utf-8?B?R1Rjek9DMUQ5OVA1Q1dwUEZoS2RBQnFTdVJhTkduQWhKTFRhNm80QURyTDNP?=
 =?utf-8?B?SUVITUI0dE1pZFNmdk0xbTFKczEzbXM2Y1lqeXpzMWowZjdPcFgzWUlUaVdC?=
 =?utf-8?B?bENlbTZyUjVQT3UvN01SSnUwUFVpMmxoTFQ4UjBTL0FVd2pDWFRTUVlRZllq?=
 =?utf-8?B?Ymh3UmRoTzR6WDRtcmphSEwzRnQvU09kbFVGUm8valFwSFVkQUFYVlRJNlhF?=
 =?utf-8?B?WlpTUWFrYnhQYWhEcUZpS3drcUdvaTdqcThPM2toNFVWMXY2Q1VxQXhBRlIr?=
 =?utf-8?B?cmxkRmtWWElhLzRTNzZkM1dtRHhkOU5WOUl2REFIQWZNRXhYN2xic2Vnd29k?=
 =?utf-8?B?bnRLeXY2U2F5SVFTUWFKaUlEclJQcjErN0tqQlFFNFRNd0JGN3FmUytScmhD?=
 =?utf-8?B?TjNLU0tqdmk5NjArdkxCMkVydFEzMnRheWIySlVSejVzd1B4ZExWVHVkUTVJ?=
 =?utf-8?B?cUtOcFZ4eFZUWERyQ01RWFlRUWp3a2RJdEZZQU8wYTh3UXlZL2ZZbjBudUwz?=
 =?utf-8?B?ellhQnk3VGtWdW9ZZ0ozTTNuZ0xqZUZlUW1xd0lXUHZqYlA3SkNpbURsRWZH?=
 =?utf-8?B?UG1JRmFHcUhURlZmdVV2N3NjTTJQVXZYWXVCc0ZkSTFLVG1MS2JEQWRHZEpa?=
 =?utf-8?B?c2srOGFaamZlVzJ4REtGRlBsOC92Vm5YajNIOE9XTFhoSXYxK3FBdDFwWW9q?=
 =?utf-8?B?Q0FWdXlDZ21XTHc3QVpGUE1iQVd6eGJMNG1UT29neWI5Y1FjL0dtUm9TdzBY?=
 =?utf-8?B?ZTAwYnRFNW81dklhS3JaMlFQb1kxb2JpdWppZ0RZT0plR1Z5dWJXajdmMzVV?=
 =?utf-8?B?aUdYSE5sVnZjRHZWVDVsSnZBVnNnNGJlcTJHaHYyMFJKUWU1ZmdZNEcwZ0FX?=
 =?utf-8?B?VEdkSkphVXZRUHlhVVdSN2UrNGh3a0EzSzJxWlduNlBLdHM5ZWdkSlM2Si9O?=
 =?utf-8?B?aVo3cFpxUjNJSHFScTdlSnNJUkNtVGxla0VJWmJNODhCNzJBbTZ5NHl2Q1BV?=
 =?utf-8?B?cDdtcnA3RzU3QXUxU2U1Nlp5d0FmWVhkdk82OEFBVVFtUmNzY2NvK1ZWNzF0?=
 =?utf-8?B?NlBmd2lGUW9raDRTWEk0SjdpWUNyZkNWbFZMU0NUWWRaUFFHNktVQ0dXUm1W?=
 =?utf-8?B?QWpoZld0TlI3eWp3QkNYSEdCTTZISUh2U1hkU3BhQzJvdjBFOWwvaGxJU2Ev?=
 =?utf-8?B?RHgwZmlPVlEwR2Q2U0pCTldoOVNUTkVwS0l5K1dmTEdqYmREbzRqTCt1L0dW?=
 =?utf-8?B?SXhIQ0RrOGxSSTlFS205OW5CbWRzSk9HbWc0ZVE4WGd2MUw1M2F5bGlKMjhS?=
 =?utf-8?B?RzFJZ3J2WDdCbU8wTHo5SVFXeUR2c1BLVVpMNmdBS2VzNnFtWHFtYVYzZ2M3?=
 =?utf-8?B?dzMrOVpjZE1qdGMxU2FsOWRvZzhoQm93bmV5b3ZvZHB0UEl6VWlhcmx6V2hJ?=
 =?utf-8?B?R25MYXIxbGRiSTlPbFhFMW9ORFNFQzVKZ3VaNkNCamdpa0wyd0dIUGF3RWdW?=
 =?utf-8?B?ZE1mOHloUXo2YllnUGVhUy8vMWlTQnI2aGE0VklHWmJaZVR2REtXck8zR3g2?=
 =?utf-8?B?Zmx3WEtVL0xpa0l4Zy9YN2I1Y2M1MzNNc2Q1ZEttalJld1hBeER2VC9yTjBo?=
 =?utf-8?B?ZkJuVStyNklMaTFFK3dpUDZUQTBCQ1ZPUXpZK0FOUUZQcjdIQlNMZVVWRE9l?=
 =?utf-8?B?OEdaOTVvNTVOV1Fpd2ZjMDZTK0xjWjhSb2pvWE04S0xGd1dIalN1a1dLT3lp?=
 =?utf-8?Q?bnDsmK3Yw2t0mbY7vzckjHHQO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49647d4-aa8f-4c1e-0416-08db08c38ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 04:27:00.7060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b087OLNVr4xfmJtZ84bKdyAMhmQ6vT18Ix2Byd7/gEN7FBdYP5/koldzba9wEsCyE3Gt1VB9AkhsIWR9Zsdv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBGZWJydWFyeSAyLCAyMDIzIDM6MjUgQU0NCj4gDQo+IE9uIFdlZCwgRmViIDAxLCAyMDIz
IGF0IDAyOjM3OjQyUE0gLTA0MDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBXZWQs
IEZlYiAwMSwgMjAyMyBhdCAwOTo0NjoyM0FNIC0wODAwLCBOaWNvbGluIENoZW4gd3JvdGU6DQo+
ID4gPiA+IFNvIHRoZSBpc3N1ZSBpcyB3aXRoIHJlcGxhY2UgeW91IG5lZWQgdG8gaGF2ZSB0aGUg
ZG9tYWluIHBvcHVsYXRlZA0KPiA+ID4gPiBiZWZvcmUgd2UgY2FuIGNhbGwgcmVwbGFjZSBidXQg
eW91IGNhbid0IHBvcHVsYXRlIHRoZSBkb21haW4gdW50aWwgaXQNCj4gPiA+ID4gaXMgYm91bmQg
YmVjYXVzZSBvZiB0aGUgYWJvdmUgaXNzdWU/IFRoYXQgc2VlbXMgdW5zb3ZsYWJsZSB3aXRob3V0
DQo+ID4gPiA+IGZpeGluZyB1cCB0aGUgZHJpdmVyLg0KPiA+ID4NCj4gPiA+IE5vdCByZWFsbHku
IEEgUkVQTEFDRSBpb2N0bCBpcyBqdXN0IGFuIEFUVEFDSCwgaWYgdGhlIGRldmljZSBqdXN0DQo+
ID4gPiBnZXRzIEJJTkQtZWQuIFNvIHRoZSBTTU1VIGRyaXZlciB3aWxsIGluaXRpYWxpemUgKCJm
aW5hbGlzZSIpIHRoZQ0KPiA+ID4gZG9tYWluIGR1cmluZyB0aGUgcmVwbGFjZSgpIGNhbGwsIHRo
ZW4gaW9wdF90YWJsZV9hZGRfZG9tYWluKCkgY2FuDQo+ID4gPiBiZSBkb25lLg0KPiA+ID4NCj4g
PiA+IFNvLCBub3QgYSBibG9ja2VyIGhlcmUuDQo+ID4NCj4gPiBXZWxsLCB5ZXMsIHRoZXJlIHNv
cnQgb2YgaXMgYmVjYXVzZSB0aGUgd2hvbGUgZmxvdyBiZWNvbWVzIG5vbnNlbnNpY2FsDQo+ID4g
LSB3ZSBhcmUgc3VwcG9zZWQgdG8gaGF2ZSB0aGUgaW9tbXVfZG9tYWluIHBvcHVsYXRlZCBieSB0
aGUgdGltZSB3ZQ0KPiBkbw0KPiA+IHJlcGxhY2UuIE90aGVyd2lzZSByZXBsYWNlIGlzIGV4dHJh
LXBvaW50bGVzcy4uDQo+IA0KPiBUaGUgImZpbmFsaXNlIiBpcyBvbmUgb2YgdGhlIHZlcnkgZmly
c3QgbGluZXMgb2YgdGhlIGF0dGFjaF9kZXYoKQ0KPiBjYWxsYmFjayBmdW5jdGlvbiBpbiBTTU1V
IGRyaXZlciwgdGhvdWdoIGl0IG1pZ2h0IHN0aWxsIHVuZGVzaXJhYmx5DQo+IGZhaWwgdGhlIHJl
cGxhY2UoKS4NCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9uaWNvbGluYy9pb21tdWZkL2NvbW1p
dC81YWU1NGYzNjA0OTVhYWUzNWI1OTY3ZDENCj4gZWIwMDE0OTkxMjE0NTYzOQ0KPiBCdHcsIHRo
aXMgaXMgYSBkcmFmdCB0aGF0IEkgbWFkZSB0byBtb3ZlIGlvcHRfdGFibGVfYWRkX2RvbWFpbigp
LiBJDQo+IHRoaW5rIHdlIGNhbiBoYXZlIHRoaXMgd2l0aCB0aGUgbmVzdGluZyBzZXJpZXMuDQo+
IA0KPiBMYXRlciwgb25jZSB3ZSBwYXNzIGluIHRoZSBkZXYgcG9pbnRlciB0byB0aGUgLT5kb21h
aW5fYWxsb2Mgb3ANCj4gdXNpbmcgUm9iaW4ncyBjaGFuZ2UsIGFsbCB0aGUgaW9wdF90YWJsZV9h
ZGRfZG9tYWluKCkgY2FuIGJlIGRvbmUNCj4gd2l0aGluIHRoZSBod3B0X2FsbG9jKCksIHByaW9y
IHRvIGFuIGF0dGFjaCgpL3JlcGxhY2UoKS4NCj4gDQo+ID4gPiA+IElzIHRoZXJlIGFub3RoZXIg
aXNzdWU/DQo+ID4gPg0KPiA+ID4gT2guIEkgdGhpbmsgd2UgbWl4ZWQgdGhlIHRvcGljcyBoZXJl
LiBUaGVzZSB0aHJlZSBwYXRjaGVzIHdlcmUNCj4gPiA+IG5vdCB0byB1bmJsb2NrIGJ1dCB0byBj
bGVhbiB1cCBhIHdheSBmb3IgdGhlIHJlcGxhY2Ugc2VyaWVzIGFuZA0KPiA+ID4gdGhlIG5lc3Rp
bmcgc2VyaWVzLCBmb3IgdGhlIGRldmljZSBsb2NraW5nIGlzc3VlOg0KPiA+ID4NCj4gPiA+IAlp
ZiAoY3VyX2h3cHQgIT0gaHdwdCkNCj4gPiA+IAkJbXV0ZXhfbG9jaygmY3VyX2h3cHQtPmRldmlj
ZV9sb2NrKTsNCj4gPiA+IAltdXRleF9sb2NrKCZod3B0LT5kZXZpY2VfbG9jayk7DQo+ID4gPiAJ
Li4uDQo+ID4gPiAJaWYgKGlvbW11ZmRfaHdfcGFnZXRhYmVfaGFzX2dyb3VwKCkpIHsJLy8gdG91
Y2hpbmcgZGV2aWNlDQo+IGxpc3QNCj4gPiA+IAkJLi4uDQo+ID4gPiAJCWlvbW11X2dyb3VwX3Jl
cGxhY2VfZG9tYWluKCk7DQo+ID4gPiAJCS4uLg0KPiA+ID4gCX0NCj4gPiA+IAlpZiAoY3VyX2h3
cHQgJiYgaHdwdCkNCj4gPiA+IAkJbGlzdF9kZWwoJmlkZXYtPmRldmljZXNfaXRlbSk7DQo+ID4g
PiAJbGlzdF9hZGQoJmlkZXYtPmRldmljZXNfaXRlbSwgJmN1cl9od3B0LT5kZXZpY2VzKTsNCj4g
PiA+IAkuLi4NCj4gPiA+IAltdXRleF91bmxvY2soJmh3cHQtPmRldmljZV9sb2NrKTsNCj4gPiA+
IAlpZiAoY3VyX2h3cHQgIT0gaHdwdCkNCj4gPiA+IAkJbXV0ZXhfdW5sb2NrKCZjdXJfaHdwdC0+
ZGV2aWNlX2xvY2spOw0KPiA+DQo+ID4gV2hhdCBpcyB0aGUgaXNzdWU/IFRoYXQgaXNuJ3QgcXVp
dGUgcmlnaHQsIGJ1dCB0aGUgYmFzaWMgYml0IGlzIGZpbmUNCj4gPg0KPiA+IElmIHlvdSB3YW50
IHRvIGRvIHJlcGxhY2UgdGhlbiB5b3UgaGF2ZSB0byBob2xkIGJvdGggZGV2aWNlc19sb2NrIGFu
ZA0KPiA+IHlvdSB3cml0ZSB0aGF0IHN1cGVyIHVnbHkgdGhpbmcgbGlrZSB0aGlzDQo+ID4NCj4g
PiBsb2NrX2JvdGg6DQo+ID4gICAgaWYgKGh3cHRfYSA8IGh3cHRfYikgew0KPiA+ICAgICAgIG11
dGV4X2xvY2soJmh3cHRfYS0+ZGV2aWNlc19sb2NrKTsNCj4gPiAgICAgICBtdXRleF9sb2NrX25l
c3RlZCgmaHdwdF9iLT5kZXZpY2VzX2xvY2spOw0KPiA+ICAgIH0gZWxzZSBpZiAoaHdwdF9hID4g
aHdwdF9iKSB7DQo+ID4gICAgICAgbXV0ZXhfbG9jaygmaHdwdF9iLT5kZXZpY2VzX2xvY2spOw0K
PiA+ICAgICAgIG11dGV4X2xvY2tfbmVzdGVkKCZod3B0X2EtPmRldmljZXNfbG9jayk7DQo+ID4g
ICAgfSBlbHNlDQo+ID4gICAgICAgbXV0ZXhfbG9jaygmaHdwdF9hLT5kZXZpY2VzX2xvY2spOw0K
PiA+DQo+ID4gQW5kIHRoZW4gaXQgaXMgdHJpdmlhbCwgeWVzPw0KPiANCj4gWWVhLiBUaGF0J3Mg
eW91ciBwcmV2aW91cyByZW1hcmsuDQo+IA0KPiA+IFVzaW5nIHRoZSBncm91cF9sb2NrIGluIHRo
ZSBpb21tdSBjb3JlIGlzIHRoZSByaWdodCB3YXkgdG8gZml4DQo+ID4gdGhpcy4uIE1heWJlIHNv
bWVkYXkgd2UgY2FuIGRvIHRoYXQuDQo+ID4NCj4gPiAoYWxzbyBkb2N1bWVudCB0aGF0IHJlcGxh
Y2UgY2F1c2VzIGFsbCB0aGUgZGV2aWNlcyBpbiB0aGUgZ3JvdXAgdG8NCj4gPiBjaGFuZ2UgaW9t
bXVfZG9tYWlucyBhdCBvbmNlKQ0KPiANCj4gWWVzLiBUaGVyZSdzIGEgZGlzY3Vzc2lvbiBpbiBQ
QVRDSC0zIG9mIHRoaXMgc2VyaWVzLiBJIGRyYWZ0ZWQgYQ0KPiBwYXRjaCBjaGFuZ2luZyBpb21t
dV9hdHRhY2gvZGV0YWNoX2RldigpOg0KPiBodHRwczovL2dpdGh1Yi5jb20vbmljb2xpbmMvaW9t
bXVmZC9jb21taXQvMTI0Zjc4MDRlZjM4ZDUwNDkwYjYwNmZkNQ0KPiA2YzFlMjdjZTU1MWE4MzkN
Cj4gDQo+IEJhb2x1IGhhZCBhIHNpbWlsYXIgcGF0Y2ggc2VyaWVzIGEgeWVhciBhZ28uIFNvIHdl
IG1pZ2h0IGNvbnRpbnVlDQo+IHRoYXQgZWZmb3J0IGluIHBhcmFsbGVsLCBhbmQgZXZlbnR1YWxs
eSBkcm9wIHRoZSBkZXZpY2UgbGlzdC9sb2NrLg0KPiANCj4gPiA+IEkganVzdCBnYXZlIGFub3Ro
ZXIgdGhvdWdodCBhYm91dCBpdC4gU2luY2Ugd2UgaGF2ZSB0aGUgcGF0Y2gtMg0KPiA+ID4gZnJv
bSB0aGlzIHNlcmllcyBtb3ZpbmcgdGhlIGlvYXMtPm11dGV4LCBpdCBhbHJlYWR5IHNlcmlhbGl6
ZXMNCj4gPiA+IGF0dGFjaC9kZXRhY2ggcm91dGluZXMuIEFuZCBJIHNlZSB0aGF0IGFsbCB0aGUg
cGxhY2VzIHRvdWNoaW5nDQo+ID4gPiBpZGV2LT5kZXZpY2VfaXRlbSBhbmQgaHdwdC0+ZGV2aWNl
cyBhcmUgcHJvdGVjdGVkIGJ5IGlvYXMtPm11dGV4Lg0KPiA+ID4gU28sIHBlcmhhcHMgd2UgY2Fu
IHNpbXBseSByZW1vdmUgdGhlIGRldmljZV9sb2NrPw0KPiA+DQo+ID4gVGhlIHR3byBod3B0cyBh
cmUgbm90IHJlcXVpcmVkIHRvIGhhdmUgdGhlIHNhbWUgaW9hcywgc28gdGhpcyBkb2Vzbid0DQo+
ID4gcmVhbGx5IGhlbHAuLg0KPiANCj4gSG1tLi4uaW4gdGhhdCBjYXNlLCB3ZSBzaG91bGQgaG9s
ZCB0d28gaW9hcy0+bXV0ZXggbG9ja3MgaW4NCj4gYWRkaXRpb24gdG8gdHdvIGRldmljZSBsb2Nr
cz8NCg0KQWhhLCBzZWVtcyBzby4gWW91IGNhbiByZXBsYWNlIGEgczEgaHdwdCB3aXRoIGFub3Ro
ZXIgczEgaHdwdCB3aGljaA0KSGFzIGEgZGlmZmVyZW50IGlvYXMuIPCfmIogbWF5YmUgdGhpcyBp
cyBzb21ldGhpbmcgaW5jcmVtZW50YWwgdG8gbmVzdGluZw0Kc2VyaWVzLiBJbiBuZXN0aW5nIHNl
cmllcywgYmV0d2VlbiBpb2FzIGFuZCBzMSBod3B0LCB0aGV5IGNhbiBzaGFyZQ0KdGhlIGRldmlj
ZV9sb2NrLiBJc24ndCBpdD8NCg0KUmVnYXJkcywNCllpIExpdQ0K
