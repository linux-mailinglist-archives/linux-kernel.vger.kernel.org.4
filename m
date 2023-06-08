Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23372893E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjFHUQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjFHUQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:16:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C162D75;
        Thu,  8 Jun 2023 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686255353; x=1717791353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QAp+kYwaScBK4VZ09ZgMJcakoJpfSo+LW4kAHloT1K4=;
  b=DAfelpB/NoNBMLJrX3Jd8ZHCcZBJDXaV+pLoIAesIxxwwfyfLoAlm8BO
   /GN6b0t6K3zkO3ztQftvI4c/nDOEm0OAjOBCu9dB6eF8TpTvqMBdMGwfy
   dI5S+MHbstFAnn22WydbH7haF5lH1BRyZIGlX4RsMP1QOmYqg12HXfsGN
   mbwDTj68uvf7OfMhhTZawOQwM9EzGGDlVbNHP/NpwO4oU+3FadHDATbpf
   YGnrTQ+B5l05n1BG3ds1O23uv49tKv3yPLEGOJecmjwosD8EgAr/bgojH
   mNzBGi8dkUgomcK3DG/nknjfNUMOVry7q52l3VJSQ6ENdAExIGOYddU6F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="421008847"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="421008847"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 13:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="710095171"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="710095171"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2023 13:15:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 13:15:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 13:15:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 13:15:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 13:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILbU/zuH5O35v6TixsheW7Rh8iQ+fO4jEyhL7QKRwuEO+YKvUPLkViTa75cEC3gwnpRwVStmJiXOzzili8XL/jgmbsbLsZPnDe7PbQc5wJJUTiHicyEjBSLOtVbjFYySfriKzYSWgjWGdjgLB7JyPe5nOw/LOzCoNm3nxgCeO0r6TILx1A9u1R6fHqzarCsFOSOd+bJbq0iAS88696AU8y3XJDNO2iNTJW86Z/rTCyslKKDS2zCemBZg+p++tSFapL6PBRJ5lSIyhUrTh4aRqDAJeLa58RKxXPpB+fFNSGB6qotgqAA6zxCvbfpuWFUEtGIvd+8WaLG26TRpnlOFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAp+kYwaScBK4VZ09ZgMJcakoJpfSo+LW4kAHloT1K4=;
 b=lQ1bXGiGzvcdsRaGxDL0yTsqnqiY3KFf6NjVIs5PZ54jrw7Sfu2IgDIFm1P+eVMgDufMoX96J4hbPVXCVor+J2xb5620bvBi0Bc7vbccgvycl0hHmmW2uoqJ/kmB6v2+tgIXUPWkitta6PWRQnMy3CJp6RJjIeMyZPUNM/sEsxrCOn5ThmBk2isRtAH+KuvASDnKwWw0N56xaRCfRrXrmCLxNmVHFJVtoclaQbhWBEldk3CBEk27Ok2D1YLxle10D3VSJVIH477N9mJdgQio/NWhkEeLJ4jl8ti7pxbv23bGAc5OCL6pN1XLQctUJsTMbpUzp8Xl/p56An3mUlhvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1SPRMB0002.namprd11.prod.outlook.com (2603:10b6:208:3d5::10)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 20:15:49 +0000
Received: from IA1SPRMB0002.namprd11.prod.outlook.com
 ([fe80::f79f:b1c4:89a1:25df]) by IA1SPRMB0002.namprd11.prod.outlook.com
 ([fe80::f79f:b1c4:89a1:25df%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 20:15:49 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v2 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Thread-Topic: [PATCH v2 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Thread-Index: AQHZl+s7AtYa6Ply606ZWi23sy9bL6+BAOeAgABbRYA=
Date:   Thu, 8 Jun 2023 20:15:48 +0000
Message-ID: <6666972e336a6749f24ce3aab7dddad63a796974.camel@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
         <20230602-vv-fw_update-v2-1-e9e5cd5adb44@intel.com>
         <20230608154905.00007551@Huawei.com>
In-Reply-To: <20230608154905.00007551@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1SPRMB0002:EE_|CO1PR11MB4932:EE_
x-ms-office365-filtering-correlation-id: 3e3ca566-bd27-4eef-2425-08db685d2653
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3gJayd2UrUxovzbUhvyrU2XQnt8u1CJFKgZ1ba+YU81f+J+sxBie7zR5p1uJWQTQL+UgYFy7DmZF9qQy/Pe4/OQv3kot1uWh5AmQ/BYufeKEM2JMS7QduwCCk3BmHfkzFqlv/pa8WFJqyLNdexSgbIuFA1ELgUeSPhcY0t/FgF3Lf4jupcqJvG/Oeq0wmAvb63qYK1cWRPGI4RnuJkAKjJzte8BAI9KVuTnwZSyzMoC10b3Za8rvryMxJ+4R6epi8xe0mcKuxsKUwnG3NgURXGsExlL1u55Qsg5y8bl8hx65ortbRG3W8OKVDVIL0WQ1gnUCb1NCi5LGnYhW3/R6jjzo/BdC6hHMTTH0mg+E/AKSKo/E9XHmkE1NQdbhfZkQWUd9orwR5lgqhLp8LB/k+UJjBHGAXnSxjueIsQXQ9OFOvTfljGgLkpFqDIXg/nVej6m/nhwTJDmss7wjPnMbQkTuClJdyix9ifYx95bYsdtU2UnYhlA9QDL5lqvvcI407BXhksCgkboyVTjF/zm+XOGqSagnXiD1KtkHzn6Z8FSMsIsoW1byM2v79Mae97Ik1eeuopbXo3oP0z7edcciWYsanllAJ5BmwRyU3P6bhY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1SPRMB0002.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(71200400001)(91956017)(64756008)(54906003)(478600001)(6916009)(316002)(8936002)(41300700001)(8676002)(66446008)(76116006)(66946007)(4326008)(66476007)(66556008)(38100700002)(82960400001)(2616005)(186003)(122000001)(966005)(6486002)(6512007)(26005)(6506007)(86362001)(38070700005)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGkxTDBJeDBrc1dHSEdLd0hvb3BnSGZ6eDZSbDhuVVVwOUltRDFMZytIbXIr?=
 =?utf-8?B?bzlVdTFjZS9ab1NMT3NQbDdZV2U1NkQ5NHY2MGpyeitadytYdFRYbGVvUW5I?=
 =?utf-8?B?RzQwTUM4RmxZRmdyRHY0bGliMmlhUnhPY3NuZHZHVmd5L0NBS2p6T1ZOYklD?=
 =?utf-8?B?SGZSMTV3YjBUejMrbmU3TmIvYWhobkI3d3hnVEJab0pnSitVSmJwRzZyT2hE?=
 =?utf-8?B?d2Y5aXVsTm1VTmpkMTRHd080MFVXZWxTRkc1dHIvdFBVWjZhVXdzYjhpVThj?=
 =?utf-8?B?RjllR21BNFBwNXBlVkVsK0o1UFJ3b3AzT054Uy9LR0lqQVJRUHRuVXpPbkNS?=
 =?utf-8?B?dmxmRi9MZDNpSzExMFVLa29uS1pmY1FCb1lnVktpREg4RXVIdURsQnY2Yzhk?=
 =?utf-8?B?VnlpQUxiQzg5Zy9NWk5Sc21TK3Rwek11bzRJdTNjTEo5bmgvUjZ2TnJwOUVJ?=
 =?utf-8?B?cUd0THB2S3k1RzJpR1daNUNUSUFRUnBCY3hPYnBadGp4bzQ2eHlDaWc0WWVL?=
 =?utf-8?B?T1laSCtaeTRJd0RIOXU0czlhNEVnQlNFdE5OMzRZL2h3azBJS3VSeDJMbGtS?=
 =?utf-8?B?V3dYcWloOHRTeU9NV3VRSXlMb1JWTGxMRTZ2azdodHZyV293NU5jL294MVNH?=
 =?utf-8?B?eERiV1k1SlNuemliZ0R4YVJ4S1c5ZHkzYkZpUEpDZmQrZjZDSlFIWnN2enll?=
 =?utf-8?B?RU10eTZmMkpCaXVsRzVHY0tOOW8vNVNDaEQ5cFNhWG1mT3VNcjJiZnFmS1o2?=
 =?utf-8?B?enJWQXgySnVBQ1FIeG5oTW1Cc1ZyMDRrT0ZjZlpMaEZIaitsRWh6RVBFSFpF?=
 =?utf-8?B?Vm9qbTQ4Q0EvSU9RZGEyTjFoVWFQam5SR3p5Z01qZ3VMbFVCNmVXUmk1VkVP?=
 =?utf-8?B?Z0ZCRVVWaHZFZVRhS2o0blVnTEcwTWNYbWFaemFOSS95WTZ0aEVvekppeFdB?=
 =?utf-8?B?N24zTk5nSURsRDk5bmE2T01DN2xmTGY1bDJIVW9Fd0NBVnROMzI0M25Rc05l?=
 =?utf-8?B?bWYrTmR0WmlLT2RzenIwNVJuV0VheWFGcEtzZUY4Yi9lMXFqZ1Bpc1RMNGY0?=
 =?utf-8?B?SkVXU3ZSbG8zTHd6VmRFOFZkSStxMExpNzB2akFVYis3YzRLb1ZKN0lUdzEv?=
 =?utf-8?B?WUdOcU9ZTTVEdk1pVi9XeHNUYllveFprMWdHNmZFS203L2czc21VRmo3UHhL?=
 =?utf-8?B?bndWWWZVUnR0ZXVZMERpZWlHc3dyZSs5b0wzdXl5ZmYxOVhCZ1JtRm82a0lB?=
 =?utf-8?B?T0ZJaktkL0h1YmxHWTZFL0JuSThQdkR3akd6a2ltUnJBRU95YXVwT3Izbm9H?=
 =?utf-8?B?dCtEaHF0dkhCeGlabUVRelBucUpBdVlvajNYa3lIWFdXWUMrOWJaM0RvUXho?=
 =?utf-8?B?NVZROEtWdjdMOC9MSk5vcVZBUWptR09hek9tNWpKcDJ6S0dkek9ZaWpFSEhY?=
 =?utf-8?B?TElXcEtkaVpHc0VLdDRMbUZpd0poU2N1eTdZRTY1RlNUQi9CWmJmU3JFMnNl?=
 =?utf-8?B?bHNEeG5jSlRhQXdzTXN0TkVaTHBoamQ3S21nTi9DUURXV2xEN2VsQWF0L3ZE?=
 =?utf-8?B?VXNLOXBHY29jYVRuUEhtcVN5MFdBSUYzbnNNVmMrWGFpa1hpUTNHNjYwc1Z2?=
 =?utf-8?B?Z2xBeER5MkJLM3ppK28xTm9ueElZYjhiQ0Q3NmRwNjVVbVp3VU9tYjQ4V1hq?=
 =?utf-8?B?SEllUWlZcitVT2V6QkFlamRiY1cwVnh3aGxlTHZOSCtVZFdWV1FrZDRNOWNw?=
 =?utf-8?B?NExTNW12YzQ2UHNyNjR6djczK1V1Uzc1Q2J4ODhrR1l3Vko2c1lkNnpxOHM5?=
 =?utf-8?B?VFFBTjlzQnMyTUR5VmExQWQzN0ZTa1BNZzA5cGtwazdpSGN4MjI0UVQyYktB?=
 =?utf-8?B?bHQybTkyeXd4ck56RzZWb3hDQVBJcHdzMUxESkRibzhxVloyZm5tOVIwemdN?=
 =?utf-8?B?UStPRnZ0UkpGUE5sWmZHaVlFVE9RZTJyeThKbFlzRnpIaEsvcHZTL3pqNjAx?=
 =?utf-8?B?UnloTG9QZm9TTmlLK1IrQkRtcDEvUVRuNjgxSlgrWEZkREtxWFM2Y3AxaDJJ?=
 =?utf-8?B?M2dCc2c2R1B2L09XQUFrL2paeEphSDd0Q3hIVjNMbmRINHhqc285enNEVVdR?=
 =?utf-8?B?UjNVTWlmemtaYUUrRytSN0d1S0NWcFNrUjltWEk5YkJrbFNWUWRGN2RsMGd6?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7AE17B56C2869409111BA50FC469DB2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1SPRMB0002.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3ca566-bd27-4eef-2425-08db685d2653
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 20:15:48.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2dO44ObFCB+zk9HNBHErcbvhqgVLOdbJ2UljI5ROp/OpdY0d8srcQoSTVhA7DmeJN3052tqZP4zN0TblJrQ+a2VzY3Vp4FFZSGS7uMM+CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTA4IGF0IDE1OjQ5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IAo8Li4+Cj4gPiArCj4gPiArc3RhdGljIGVudW0gZndfdXBsb2FkX2VyciBjeGxfZndfd3Jp
dGUoc3RydWN0IGZ3X3VwbG9hZCAqZndsLCBjb25zdCB1OCAqZGF0YSwKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1MzIgb2Zmc2V0LCB1MzIgc2l6ZSwgdTMyICp3cml0dGVuKQo+ID4gK3sKPiA+ICvC
oMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfZGV2X3N0YXRlICpjeGxkcyA9IGZ3bC0+ZGRfaGFuZGxl
Owo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kID0gY3hsZHMtPmN4
bG1kOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9tYm94X3RyYW5zZmVyX2Z3ICp0cmFu
c2ZlcjsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfbWJveF9jbWQgbWJveF9jbWQ7Cj4g
PiArwqDCoMKgwqDCoMKgwqB1MzIgY3VyX3NpemUsIHJlbWFpbmluZzsKPiA+ICvCoMKgwqDCoMKg
wqDCoHNpemVfdCBzaXplX2luOwo+ID4gK8KgwqDCoMKgwqDCoMKgaW50IHJjOwo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgKndyaXR0ZW4gPSAwOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgLyog
T2Zmc2V0IGhhcyB0byBiZSBhbGlnbmVkIHRvIDEyOEIgKENYTC0zLjAgOC4yLjkuMy4yIFRhYmxl
IDgtNTcpICovCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIUlTX0FMSUdORUQob2Zmc2V0LCBDWExf
RldfVFJBTlNGRVJfQUxJR05NRU5UKSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRldl9lcnIoJmN4bG1kLT5kZXYsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCJtaXNhbGlnbmVkIG9mZnNldCBmb3IgRlcgdHJhbnNmZXIgc2xp
Y2UgKCV1KVxuIiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgb2Zmc2V0KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
RldfVVBMT0FEX0VSUl9SV19FUlJPUjsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvC
oMKgwqDCoMKgwqDCoC8qIFBpY2sgdHJhbnNmZXIgc2l6ZSBiYXNlZCBvbiBjeGxkcy0+cGF5bG9h
ZF9zaXplICovCj4gPiArwqDCoMKgwqDCoMKgwqBjdXJfc2l6ZSA9IG1pbl90KHNpemVfdCwgc2l6
ZSwgY3hsZHMtPnBheWxvYWRfc2l6ZSAtIHNpemVvZigqdHJhbnNmZXIpKTsKPiAKPiBJZiBzaXpl
ID4gY3hsZHMtPnBheWxvYWRfc2l6ZSAtIHNpemVvZigqdHJhbnNmZXIpIHdoYXQgZW5zdXJlcyB0
aGF0IHRoZSBzdGVwCj4gd2UgdGFrZSBmb3J3YXJkcyByZXN1bHRzIGluIHRoZSBuZXh0IHJlYWQg
aGF2aW5nIGFuIG9mZnNldCB0aGF0IGlzIDEyOEIgYWxpZ25lZD8KPiAKPiBJIHRoaW5rIGN1cl9z
aXplIG5lZWRzIHRvIGJlIGZvcmNlZCB0byBiZSBhIG11bHRpcGxlIG9mIDEyOEJ5dGVzIGFzIHdl
bGwuCgpUaGUgZmFjdCB0aGF0IHNpemVvZigqdHJhbnNmZXIpIGlzIDEyOCBieXRlcywgYW5kIHBh
eWxvYWRfc2l6ZSBpcyBhCnBvd2VyIG9mIDIgc3RhcnRpbmcgd2l0aCAyNTYgc2hvdWxkIGVuc3Vy
ZSBhbGlnbm1lbnQuIERhbiBub3RlZCB0aGlzCmhlcmUsIGJlZm9yZSB3aGljaCBJIGRpZCBmb3Jj
ZSBhbGlnbm1lbnQgZXhwbGljaXRseToKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4
bC82NDZjMzEzZjIwOTA3XzMzZmIzMjk0MTJAZHdpbGxpYTIteGZoLmpmLmludGVsLmNvbS5ub3Rt
dWNoLwoKVGhpcyBwcm9iYWJseSBkZXNlcnZlcyBhIGNvbW1lbnQgdGhvdWdoIC0gSSdsbCBhZGQg
dGhhdC4KCj4gCjwuLj4KCj4gPiArCj4gPiAraW50IGN4bF9tZW1kZXZfc2V0dXBfZndfdXBsb2Fk
KHN0cnVjdCBjeGxfZGV2X3N0YXRlICpjeGxkcykKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgY3hsX21lbWRldiAqY3hsbWQgPSBjeGxkcy0+Y3hsbWQ7Cj4gCj4gY3hsbWQuZGV2IGlz
IG9ubHkgdGhpbmcgdXNlZCwgc28gSSdkIGhhdmUgYSBsb2NhbCB2YXJpYWJsZQo+IGZvciB0aGF0
IGluc3RlYWQgb2YgY3hsbWQuCj4gCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZndfdXBs
b2FkICpmd2w7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmM7Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoIXRlc3RfYml0KENYTF9NRU1fQ09NTUFORF9JRF9HRVRfRldfSU5GTywgY3hsZHMt
PmVuYWJsZWRfY21kcykpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IDA7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBmd2wgPSBmaXJtd2FyZV91cGxvYWRfcmVnaXN0
ZXIoVEhJU19NT0RVTEUsICZjeGxtZC0+ZGV2LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9u
YW1lKCZjeGxtZC0+ZGV2KSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmY3hsX21lbWRldl9md19v
cHMsIGN4bGRzKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIoZndsKSkgewo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoJmN4bG1kLT5kZXYsICJGYWlsZWQg
dG8gcmVnaXN0ZXIgZmlybXdhcmUgbG9hZGVyXG4iKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gUFRSX0VSUihmd2wpOwo+IAo+IEl0J3MgY2FsbGVkIGZyb20gcHJv
YmUgb25seSBzbyBjb3VsZCB1c2UgZGV2X2Vycl9wcm9iZSgpIGZvciBzbGlnaHQKPiBzaW1wbGlm
aWNhdGlvbi4KCkZyb20gd2hhdCBJIGNhbiB0ZWxsLCB0aGlzIGVuZHMgdXAgbG9va2luZyBsaWtl
OgoKCWZ3bCA9IGZpcm13YXJlX3VwbG9hZF9yZWdpc3RlcihUSElTX01PRFVMRSwgZGV2LApkZXZf
bmFtZShkZXYpLAoJCQkJICAgICAgICZjeGxfbWVtZGV2X2Z3X29wcywgY3hsZHMpOwoJcmMgPSBk
ZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihmd2wpLAoJCQkgICAiRmFpbGVkIHRvIHJlZ2lzdGVy
IGZpcm13YXJlIGxvYWRlclxuIik7CglpZiAocmMpCgkJcmV0dXJuIHJjOwoKSXMgdGhhdCB3aGF0
IHlvdSBtZWFudD8gSGFwcHkgdG8gbWFrZSB0aGUgY2hhbmdlIGlmIHNvLgoKPiAKPiA+IEBAIC01
ODEsNyArODg4LDcgQEAgc3RydWN0IGN4bF9tZW1kZXYgKmRldm1fY3hsX2FkZF9tZW1kZXYoc3Ry
dWN0IGN4bF9kZXZfc3RhdGUgKmN4bGRzKQo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqByYyA9
IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChjeGxkcy0+ZGV2LCBjeGxfbWVtZGV2X3VucmVnaXN0
ZXIsIGN4bG1kKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmMpCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIocmMpOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyOwo+IAo+IFdoeSBpcyB0aGlzIGNoYW5nZSBoZXJlP8Kg
wqAgRmFpcmx5IHN1cmUgaXQgcmVzdWx0cyBpbiBhIGR1cGxpY2F0ZSByZWxlYXNlLgoKQWggeWVw
IEkgdGhpbmsgYW4gYXJ0aWZhY3QgZnJvbSB0aGUgcHJldmlvdXMgcmV2IHdoZXJlIEkgaGFkIHRo
ZSBmdwpzZXR1cCBoYXBwZW5pbmcgaW4gdGhpcyBmdW5jdGlvbi4KCkFsc28gYWdyZWUgd2l0aCBh
bGwgb3RoZXIgY29tbWVudHMgdGhhdCBJIGRpZG4ndCBhZGRyZXNzLCBtYWtpbmcgdGhvc2UKY2hh
bmdlcyBmb3IgdjMuCgpUaGFua3MgZm9yIHRoZSByZXZpZXchCgo=
