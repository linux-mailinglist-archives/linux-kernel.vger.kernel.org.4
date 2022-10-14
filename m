Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463625FF3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJNSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJNSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:41:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943F1C8812
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665772917; x=1697308917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5HAZ1HvyVRturapyBWx7ElkHi6lSJhRe4Ih2kH8zISM=;
  b=HztGg+/zWsUio2GOPGHSn2FSytoh0+xlpBO+k9vHFIyXl9rx2De8kTvJ
   VLnOzp7UQ6RBbkW7OmeHL9FESvJay8tGSyK6+ziihRtOpx0+nJLGBOyp5
   42HwVskMkObSNqTGLRKE3EMEYOkhszvIlBya066xtNK2/M/dNfdNo/OC5
   0cqI2E0TZPxfT4Xc6GdxkYHthtUxw/ab80AYTaiKXE6gHovuUcYd+/UI1
   o4iJSGNPG+aHdcKmajpBCYAg03uHuMhUaJDiWjQ2FuR3Tu80A9dLSFIMB
   UbE31a5L6Sqw1Gs73PjPXEfsLR0OwvwuYDx3Zqsgs8yrutbaGVY5nvs1B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="391750422"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="391750422"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 11:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="872829973"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="872829973"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 14 Oct 2022 11:41:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:41:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:41:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 11:41:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 11:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8kIaNMnFyu5wKTpXrA+Cq9MeOWHMlVilzAwRTRFiEioWhQ3c98YWjVaNNaOrGi8cn1EO+/AJIo5eYpXnVg/vUMiTQCREPOeXi1fk82F9POHUyAKEOwjwk4znzV9KWiGabhrG8k+358/I2Ddw1eTBfDwjR6fECaRUM24UfI8V8ytBZ8cZY+X32U+S3V4k1a/VOwSTFdULXLYzul6RxP268/Lo1yf1JMh/Wiju2XmrPEgajElrChYhjx8DlzcSKGH4uI6rOiytlZvu9LzqVLhKIVJciDrxXTrVUBlO5QbFrUvqberyzCvc7u1LRX13pLHJwSiuBNz8Qdy5okoPMLV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HAZ1HvyVRturapyBWx7ElkHi6lSJhRe4Ih2kH8zISM=;
 b=PR+NFLhKGCxhTtxXFYSp7eOJOnwgUMd7qHKI34ApMgErkcrk2AF0B5rEmI3turhyiGJe60o+IJqPaPG9y67kTYqqSawgv4YX3XipJrbEOXQLPL23+481mE4tdjYACbYkkp2asoHtZZTxMsplIhb+ubpb2CU+uZSOTE9zBjpB14XgCLfNuiIvPyWxtyJF5dzmZm45dew7LOjlIQLKSV/MINBTHYYMwR4hr6zHxKGC5nOcUiyQnTgfMnOuZdypTOTI+J2qnhXrz5Q83v3FLDQ8M66mkElh85NwvKJLiRE0WQsDe/lpZb+1qlnXh6F9JvuqS7wwTw+O4CWdf/TohTg5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 18:41:54 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 18:41:54 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "songliubraving@meta.com" <songliubraving@meta.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 3/4] modules, x86: use vmalloc_exec for module core
Thread-Topic: [RFC v2 3/4] modules, x86: use vmalloc_exec for module core
Thread-Index: AQHY2qcCivppoe8db0mS/SkQ0x4Q364OEceAgAAtwQCAAARrgA==
Date:   Fri, 14 Oct 2022 18:41:53 +0000
Message-ID: <20a730fa671fc11a71b175ff4722c4915623062d.camel@intel.com>
References: <20221007234315.2877365-1-song@kernel.org>
         <20221007234315.2877365-4-song@kernel.org>
         <fb7a38faa52ce0f35061473c9c8b56394a726e59.camel@intel.com>
         <7112B8B4-B593-45AA-A9AD-2ABEEE96223E@fb.com>
In-Reply-To: <7112B8B4-B593-45AA-A9AD-2ABEEE96223E@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN0PR11MB6229:EE_
x-ms-office365-filtering-correlation-id: 6cfa4889-c0a2-4a86-26bc-08daae13c3d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oAyuo/pa2MvgOLxGKLKRLlXotPH+sdVsJV9W2Kz6IKLW5SV/RHKwSTBjoNmheT0Lh3GbpBwwukX3GIs5hEqqrGqgrkFb+8e1FnXsW8ZPF/N1cohVeP0TOa7ycQD/VVd1cmp0nVZ/QH8/tV1KAh730SYzGiKTQi82levTJzHGuR6+x0LVE6Jbu4olSPAvKi7nOlG3srw9joe85Ee/p+Z3JsSNQCcsCoCWqOFDL1DPaIqfrUsKc6GkCUiv1ztV7YU1qgKVWIYW/VWC+DXtbC2mFZhaQYQ5JhHDHaBx66OSMp+M+voZc2J8a5SOGClzYxJB6T43/Zkb1KvdYsxE0/aSFwsZr9zkZFKFPjTIfAEf3NETUjsXwfjuvxVC4sX/uim4rIbwHgYo0z3YUQCdt7MFHPy8bg3QknFwviv/s0QfvScCrTt815mhvCvjC8PkPO9J1SjSMxOuEeBRMVWltBTLhGmRUI5tPfLxY3/XeEzYLjQET6mWASLB2OzUyi5+9LuqJok8trkuIQBcIOHwCovmc9HyTYYBwh1D9+Q31nR6dGm6hdKQ0IdzvKLHhR3bzwZFjvjrbt/Q9xgekk4l/7lZr9fazpjNGFnc/dfArJOkIkosCsQSzqa+LwXjIY+Ann8J/zjWjb8AudbGb28PR6UCmA6TmCiKUlmqaAuKytv6UqH5S6lGXIz+zidgZKl/W4hkQfCEFs+GGho1HIIzRYi8sP/RO0USUqUMrnR3LJoeEZXL5vtN3iBK7HsJXGtQgdZjgDn2bzUWrxqOjjdxMBIRQYCuzndc7NxeZey7Icf0A/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(71200400001)(2616005)(4001150100001)(186003)(2906002)(110136005)(316002)(36756003)(66556008)(76116006)(66476007)(54906003)(66946007)(122000001)(64756008)(8936002)(91956017)(6486002)(4326008)(66446008)(6512007)(38070700005)(38100700002)(6506007)(5660300002)(86362001)(26005)(41300700001)(8676002)(7416002)(478600001)(53546011)(83380400001)(82960400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEhJVEdpTjloUFlGSDRWWGJIdzNVS0swTC9qQVVOU1pYUE1pQW10ZFdDSmZF?=
 =?utf-8?B?Q0RieTF2NjhJZkNHcUIxc0c1MDQ0SU5SL29aeVAvY0tkWm42SHNmajc4NHd4?=
 =?utf-8?B?ZlVEaFAxQVQ2RHI3bGdxbkFSYzVaL3kwS29wa29GNFEvWmFnbHZWSDdzMjF4?=
 =?utf-8?B?Y0VTQ0JoN1FZN2xvRHQyNVZIMnJXcXZEQlQrL1ZjUVpqTkwwUi9PZjRLNlBi?=
 =?utf-8?B?Z1NpRkdQZzBvd3E5L2lLK0xrSlFndk1XVWlFaktMUWN1LzB2NU9IUFFrWVdN?=
 =?utf-8?B?dDZ4MldHOUdWazA2VVJ6OEJjMTNHanZZVjVWVjAzRy9kSzVJOXUvTVhCR0pE?=
 =?utf-8?B?YTFMemhac3F5eS9vblBSNGR5cXdTYUxWK3huRjI1blNYeHRKekczM1lpS1N6?=
 =?utf-8?B?RWdYMjEycEhQa0t1S1hFUEVJNlpsMnlrc0Z5QUdIUjdDeDlKVEhkUTFJMCt6?=
 =?utf-8?B?cHBac3hQSkthYUovbzB2Z1FTUHVKNG1QWkh5VktvTXJDYndkUnhFbmw3aHpX?=
 =?utf-8?B?MWFZZVlSTTVVR2hTNjhsZzdzamhYMkZ4VHorYm9lUDgvN1JnVUxmcEhTSVpT?=
 =?utf-8?B?a1pzS3NxZFJqRSt0NjhEdG1nRXZqdmxZNFNaUHloUDNSZ3YzTDJ2MUhoSUZS?=
 =?utf-8?B?UlViN1RaQXc2eWgzai95N3lJcERKUDVZSUNrTHNNbzd6RVFkVmp2dDNRU092?=
 =?utf-8?B?WTY3WmVjaWJJSXQ1NFFyUGxjSW01ZjYrWGx4dFNYQUJCYStyRjdQeEx4YzlO?=
 =?utf-8?B?TnZqNXVkNUFFa3FybUJsbFJ6TGprUWhoamRKVVQ1OGtxOGd4SHZyQm4yeExs?=
 =?utf-8?B?RVFPT1RVY1NjYXVDRGpDUlZoWHR4L3NSanM3SGRFaEplS01BOGtmckdPRSt3?=
 =?utf-8?B?L1IvMlI5NC9Td21CQzM1bzcyYWRNVmkvQWdzNjdKbkk3cWJwTmVXdkNrL20x?=
 =?utf-8?B?MDVUYitxQ09meEk0aTRRQlFlNTVRUXBrMStaaHdWUHAxRk5pNTBwRDk0R1Yv?=
 =?utf-8?B?N0o4M1Jsd2o4VXF5K1ZoVmtUYnEzYlRJZ1k0Z01GM1hTM1NFRXExbENrNjFJ?=
 =?utf-8?B?b0RVZlVkc1VGSXJqU2E4QzFPZ3Rrb2VIOG1TVStQa1FaWm8wMUNoZUsxcW9M?=
 =?utf-8?B?R3FSVzNmR0ljWE5ZYVJZYWpzYWI2dFFEODB5enQrejVheFF4RHhFOUoxY0ll?=
 =?utf-8?B?MERaUWQrT1dUdEVLdDBKMCtpdldhWTczeDBlUVhCWHlqQkRxOWJnaUZrcXps?=
 =?utf-8?B?bHNBUnJ4WDFqdGltUGFpQzlQcTBlRWVGY2ZPcGI1d3kvZC8wdUFUenRXdEZq?=
 =?utf-8?B?eTN3QmVESmhocWJvTVc3Ull4ZWpORUJ6ejZRTEh4UGZFcnpvclNVMnZacWpC?=
 =?utf-8?B?c3l4Si93dktWRXRzS0lOVHJyeXVURk5hMFh6L3FIdWh5b3lWbktocEgySFdR?=
 =?utf-8?B?SE9qamQ3WDQ3SVgxYkxWWGJ2Z3NOdVZLUnRDTS9xOVlQNHc0Vy9TNndmeC9t?=
 =?utf-8?B?MUV4QnE2Yjk3SzVHeC9JYmlKUnNaaGx6ZC9ubG54djhTSjNsTVUycHNlWGpy?=
 =?utf-8?B?eUtOczMrVmFnb3FUZnFiR3RzRUk2cEYxdVdKL3krYzg3NitzeUtUQ0RrQkhz?=
 =?utf-8?B?RVk0N3lmYTg3b2E0ZWptM3d2M1B3WUd5NWtEY3Q3STE4UVQrVk9FVzFkWXNH?=
 =?utf-8?B?NWpDa1VYZEZ4cS9XMCt1N3VlK05GNzcyVXlub1RhTkhQcjJQd01mK2I2K2tE?=
 =?utf-8?B?VVlhTUhJRXZVY1VLVWw1UkI1cnlhaStaTmlLSEpWNkM0SHBvSVNRbWR6emVO?=
 =?utf-8?B?OEpoNloyWDJBbFY3c1kzNytSbURzME9oekVHOWc4YWJiTUNVSDJ3K0VPR1Uy?=
 =?utf-8?B?dFIyeE1ERWhqMlRRdEhrUUlnR1JnWmY3eUlpSXBBL2xLVFBQZlBLN3NCUzh5?=
 =?utf-8?B?dDlNMWFnaXJQNCtlWXl5WUVVTzRCWG81ejlha2R0M252dUtDWis5eFpMSW1J?=
 =?utf-8?B?bmYwSC9jNFUwZG5OelRuOCtjVTlnNDFpeGdyZGRmbFJaamVoOHhRQnljc2xF?=
 =?utf-8?B?a2swTXNzVzdaMXNCcW1jWXpMZWxIdmVoUnBHVENzSk9yU2VuWnEvSUVjZjdS?=
 =?utf-8?B?cWpXWXNuL3VteVIrV3NWNnRtMW00QS9KOHpnR1k1RjNUaDhseFpCdm41VEtv?=
 =?utf-8?Q?22cfHKBr+q1wyuTBofxyq9M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C09479AC1CEE4A87EFFA5CC61ABE48@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfa4889-c0a2-4a86-26bc-08daae13c3d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 18:41:53.9040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVetnzrQUrAoYPHBa5aJAMW3uzFkRZLbyAhwOf3D+DbaoQhb70EAvUlF1YQGbEbJyGFyMf9laYjX8/XBfq5ZWQVSfXMVMVZwKk54lmyX8eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDE4OjI2ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4gPiBP
biBPY3QgMTQsIDIwMjIsIGF0IDg6NDIgQU0sIEVkZ2Vjb21iZSwgUmljayBQIDwNCj4gPiByaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJpLCAyMDIyLTEw
LTA3IGF0IDE2OjQzIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gPiA+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvbW9kdWxlL21haW4uYyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+ID4gPiBpbmRleCBh
NGU0ZDg0YjZmNGUuLmI0NDgwNmUzMWE1NiAxMDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5lbC9tb2R1
bGUvbWFpbi5jDQo+ID4gPiArKysgYi9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiA+ID4gQEAgLTUz
LDYgKzUzLDcgQEANCj4gPiA+ICNpbmNsdWRlIDxsaW51eC9ic2VhcmNoLmg+DQo+ID4gPiAjaW5j
bHVkZSA8bGludXgvZHluYW1pY19kZWJ1Zy5oPg0KPiA+ID4gI2luY2x1ZGUgPGxpbnV4L2F1ZGl0
Lmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2JwZi5oPg0KPiA+ID4gI2luY2x1ZGUgPHVhcGkv
bGludXgvbW9kdWxlLmg+DQo+ID4gPiAjaW5jbHVkZSAiaW50ZXJuYWwuaCINCj4gPiA+IA0KPiA+
ID4gQEAgLTEyMDMsNyArMTIwNCw3IEBAIHN0YXRpYyB2b2lkIGZyZWVfbW9kdWxlKHN0cnVjdCBt
b2R1bGUgKm1vZCkNCj4gPiA+ICAgICAgICAgbG9ja2RlcF9mcmVlX2tleV9yYW5nZShtb2QtPmRh
dGFfbGF5b3V0LmJhc2UsIG1vZC0NCj4gPiA+ID4gZGF0YV9sYXlvdXQuc2l6ZSk7DQo+ID4gPiAN
Cj4gPiA+ICAgICAgICAgLyogRmluYWxseSwgZnJlZSB0aGUgY29yZSAoY29udGFpbmluZyB0aGUg
bW9kdWxlDQo+ID4gPiBzdHJ1Y3R1cmUpDQo+ID4gPiAqLw0KPiA+ID4gLSAgICAgICBtb2R1bGVf
bWVtZnJlZShtb2QtPmNvcmVfbGF5b3V0LmJhc2UpOw0KPiA+ID4gKyAgICAgICB2ZnJlZV9leGVj
KG1vZC0+Y29yZV9sYXlvdXQuYmFzZSk7DQo+ID4gPiAjaWZkZWYgQ09ORklHX0FSQ0hfV0FOVFNf
TU9EVUxFU19EQVRBX0lOX1ZNQUxMT0MNCj4gPiA+ICAgICAgICAgdmZyZWUobW9kLT5kYXRhX2xh
eW91dC5iYXNlKTsNCj4gPiA+ICNlbmRpZg0KPiA+ID4gQEAgLTEzMjEsNyArMTMyMiw4IEBAIHN0
YXRpYyBpbnQgc2ltcGxpZnlfc3ltYm9scyhzdHJ1Y3QgbW9kdWxlDQo+ID4gPiAqbW9kLA0KPiA+
ID4gY29uc3Qgc3RydWN0IGxvYWRfaW5mbyAqaW5mbykNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGtzeW0gPSByZXNvbHZlX3N5bWJvbF93YWl0KG1vZCwgaW5mbywNCj4gPiA+IG5hbWUp
Ow0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgLyogT2sgaWYgcmVzb2x2ZWQuICAqLw0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGtzeW0gJiYgIUlTX0VSUihrc3ltKSkg
ew0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeW1baV0uc3RfdmFsdWUg
PQ0KPiA+ID4ga2VybmVsX3N5bWJvbF92YWx1ZShrc3ltKTsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyB2YWwgPQ0KPiA+ID4ga2VybmVsX3N5bWJv
bF92YWx1ZShrc3ltKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4g
PiA+IGJwZl9hcmNoX3RleHRfY29weSgmc3ltW2ldLnN0X3ZhbHVlLA0KPiA+ID4gJnZhbCwgc2l6
ZW9mKHZhbCkpOw0KPiA+IA0KPiA+IFdoeSBicGZfYXJjaF90ZXh0X2NvcHkoKT8gVGhpcyBvZiBj
b3Vyc2Ugd29uJ3Qgd29yayBmb3Igb3RoZXINCj4gPiBhcmNoaXRlY3R1cmVzLiBTbyB0aGVyZSBu
ZWVkcyB0byBiZSBmYWxsYmFjayBtZXRob2QuIFRoYXQgUkZDIGJyb2tlDQo+ID4gdGhlDQo+ID4g
b3BlcmF0aW9uIGludG8gdHdvIHN0YWdlczogTG9hZGluZyBhbmQgZmluYWxpemVkLiBXaGVuIGxv
YWRpbmcsIG9uDQo+ID4gbm9uLQ0KPiA+IHg4NiB0aGUgd3JpdGVzIHdvdWxkIHNpbXBseSBiZSB0
byB0aGUgYWxsb2NhdGlvbiBtYXBwZWQgYXMNCj4gPiB3cml0YWJsZS4NCj4gPiBXaGVuIGl0IHdh
cyBmaW5hbGl6ZWQgaXQgY2hhbmdlZCBpdCB0byBpdCdzIGZpbmFsIHBlcm1pc3Npb24gKFJPLA0K
PiA+IGV0YykuDQo+ID4gVGhlbiBmb3IgeDg2IGl0IGRvZXMgdGV4dF9wb2tlcygpIGZvciB0aGUg
d3JpdGVzIGFuZCBoYXMgaXQgUk8gZnJvbQ0KPiA+IHRoZQ0KPiA+IGJlZ2lubmluZy4NCj4gDQo+
IFllYWgsIHRoaXMgb25lICgzLzQpIGlzIHJlYWxseSBhIHByb3RvdHlwZSB0byBzaG93IHZtYWxs
b2NfZXhlYw0KPiBjb3VsZCANCj4gd29yayBmb3IgbW9kdWxlcyAod2l0aCBhIGxvdCBtb3JlIHdv
cmsgb2YgY291cnNlKS4gQW5kIHNvbWV0aGluZyB0bw0KPiByZXBsYWNlIGJwZl9hcmNoX3RleHRf
Y29weSgpIGlzIG9uZSBvZiB0aGUgaXNzdWVzIHdlIG5lZWQgdG8gYWRkcmVzcw0KPiBpbg0KPiB0
aGUgZnV0dXJlLiANCg0KUmlnaHQsIEkgdGhpbmsgbWFraW5nIGl0IHdvcmsgYm90aCB3aXRoIGFu
ZCB3aXRob3V0IHRleHRfcG9rZSgpIGlzDQpuZWVkZWQgdG8gZXZlciBnZXQgaXQgdG8gd29yayB3
aXRoIG1vZHVsZXMuIFNpbmNlIHNvIG11Y2ggb2YgaXQgaXMNCmNyb3NzIGFyY2guIE9vcHMsIGl0
IGxvb2tzIGxpa2Ugd2UgbG9zdCBMdWlzIG9uIG1vc3Qgb2YgdGhlc2UNCnJlc3BvbnNlcy4NCg0K
SWYgd2UgZG9uJ3QgaGF2ZSB0aGF0LCB0aGVuIHRoZSBtb2R1bGVzIFJGQyBpcyBraW5kIG9mIGEg
ZGlzdHJhY3Rpb24uDQpCdXQgYnBmLCBrcHJvYmVzIGFuZCBmdHJhY2UgaXMgc3RpbGwgbmljZS4N
Cg==
