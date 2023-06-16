Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A748173307D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbjFPLyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjFPLyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:54:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4862944
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686916480; x=1718452480;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Icsxzc+KuD9XlEWigqjZ8U08CKH7c0fpfu2Jt1x3Dag=;
  b=AfyjuWRTasq7Ha2pAkl+Wu+abbZ2Seq6357ovOAYNpZfF8nzJB1s/8rU
   JLN+ZFxyYUpwrSe2Kt7DlAsZn4983y/4hbDd5FhgfkMbh2E6Sng7kJcMK
   h9p2quAuXIE+paKPrqy+36wkIj1eNLpILi+gFIPHAK/NAMFIKFqex19sn
   Eb/45cQabvE7rlQjGaHWg2XMKsdnDuncyyQ3GPmjSHoO7TReKujokfLaa
   gX27klR3lfmxiYT4tonH0ReIv66FLceI2R+ejtrSSxRs6d+rh5EHHaiyt
   v9/23oEPCaV1VCXwSFijkI+J5l6e9I0GyVv7S9YK2P4pje5RhWEGEX8I7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445578557"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="445578557"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 04:54:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="857357398"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="857357398"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jun 2023 04:54:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 04:54:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 04:54:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 04:54:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 04:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZebgUyHGARc9PnSMqeoRWNmH6h5ld9aWe0B+O2h08NdOnco5DX88wTkb7lL9DSVqCoAoaOmPv8miVZt7J9n7x6aPpzo2h1D4PwS1WMgQyFgm2qar32bGw1j1wSDY9axvA98tOV4i86qd24gyTAKRg8wX6s9mfSjAXlNcV6/XOcnp313X3nR5K1XOBwkEVPnwJrinVM9Cr6vEcGuSaCWVmKsV92pF7C1TM62YiUENmNknj+pRdd5bl9LJmCOuWR3W1kW4Net/sx9EOJWav3d8TYgVO06qGucmkC9i+2CJP3s63M1eXr0e4wHtnbzEnef46XjGUNPV7YYJB8UmcYIMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqBVtlitK/F9R2YnLE2kcuGBj2eCEcRmhBvXZPKA7N8=;
 b=cv8VbfoXMt2a2ARfbbq+GboGFmKw+5XrvHB4st2Dtn0i+NtONU/WRclwli7VPXLK+H0leMAfwMb2PtPg3MoXCBIaiT0dUFw3pYpH6h5J4SiqjmpZLxUZRFIl4kqr7qAzYsDNCO0C6Rt3nNC+tcS/tRMhyLKbpX1tUJaPHnTqcSYJblQxrynG1nmU0Qc1zH+n3YRNQoCf1UhiPNlRnStSmDdjSm7/53CzSq2l8qgZiyAWLiHxIV5uGLEGR3Vg4qydb0YdUdur5vir2WCDdVuWTOaYkBejLCkO4svCtQcnml8iox6a+5j6W1vEvaWDyoPWefd1mZxoocA/T7hXJVROmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH3PR11MB7893.namprd11.prod.outlook.com (2603:10b6:610:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:54:24 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 11:54:24 +0000
Date:   Fri, 16 Jun 2023 19:47:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <ZIxLtIsWABFCSFg/@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
 <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
 <20230616081025.GM38236@hirez.programming.kicks-ass.net>
 <d100b30d381b9d28b6fceab5e9c5042c3ca79ba8.camel@intel.com>
 <20230616094205.GC4253@hirez.programming.kicks-ass.net>
 <dd0a7053f762edaecdf7613da5281a2c2c73ca77.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd0a7053f762edaecdf7613da5281a2c2c73ca77.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH3PR11MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 54aab1a2-c119-4158-56da-08db6e606d87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8I3JOu22YC48qsLTZ44DZ0r+NCuntOeiWseXM0FCTpHWVGUJZfFS7l6npJJKHJ+GZzOOYmoKQj9Sv+ZlmVOnbQsc7VYMUcZl7fAj9g9HOD0DNnTTfiCYTMPWFx3QinY9sB/B1EzJDd35BhinRD9+G50HelH6g6d9/SEYvtO+GpgCJrWGfQ9z9Fotioz/uRtUiY91x9yVgBHoruEgdN3cKnZZZCQbj8DN3XwzYcVzKHBxOwNikvzIHmNYqdS7pB0sDFn4dKWe/PTwZB/D5QDoAaysfPXL+m6YJObpggVdHCyrnKsgL1BVH9ggeKfEt7a2OkdW/olAXk4EqJLJ+58mjBQQnCx5v/qxXvcz4KLBNvS8WjQCMAHbdsxmmV159jLJJ/YSWjkvghxnP4gnxx8yLuOdzr/8SB3MvINNevUhLlXFU/kh7tNz26bm5PVbvv/1OyDPC3lEpZEEdqQhBuZczgNcZ1VPJKQgZNqWuRaMv+OgRDX4niT9daJuJCxs5rrIGqp1Up4LUT3Ry7L39vlyRe2IYDZD8bfOarr6DE8IaV6qT9ENJ+IRTGW4Zs12/vno
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(478600001)(54906003)(6486002)(6666004)(5660300002)(8936002)(44832011)(82960400001)(8676002)(41300700001)(2906002)(86362001)(33716001)(6862004)(7416002)(38100700002)(66476007)(66556008)(316002)(6636002)(66946007)(4326008)(26005)(9686003)(6512007)(6506007)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZNamdQeE9VVGxhOEhuNWVFcHMydjNLNEdKbzhIU3pjdE15dGIrY2lXVldB?=
 =?utf-8?B?ZUhtbC93VUR5RE1aR1VvN0pCTlFwSzdrK21FcW5JN0xDR1prZjNzMkdCMWlx?=
 =?utf-8?B?eWo3c05LQ1MwL3NyWGI4T0ZyalN3QUg2WHN6OVhFNmhyVlpIYk04dDQyTEdj?=
 =?utf-8?B?cE12L2RXMmpMdHRmbE9XUkQ1dXpRUCtxM2JYUmJqTUhraXExWElncG1TeExj?=
 =?utf-8?B?R0tmK1VRUWFUUU9kSCt4dU81bjlwa00xdVFpODV5UjY1WTVvRklMMlp2cGhT?=
 =?utf-8?B?RkZzQ0dQWmJEbjh4NHc1UjVGSlFkUCs4VHlyTFVZRkFWbytaSG1zTFZpaE84?=
 =?utf-8?B?OVVnQWJaa0RHZVI1dEMzQ0N5NHJ6ejdTVUJLSEhIVURCcldKRTZZTFZvMStB?=
 =?utf-8?B?UTRpSWU0OUhaL1RkcjQxOGtEbDBFNExwbU8xK2V3L3lDY3JFS21oakZZL2F6?=
 =?utf-8?B?c3h2OTlPQVZ0RURvVmo3MXBQYmI5bnh0Umhpd3AyL25vcXgwVkNzNFdKMGV4?=
 =?utf-8?B?NFJpaDN1M0hzcGtkV2EvMjNtVDRjQ2FoODloaWt1Q1BDVCtPL08vU21kZ2NS?=
 =?utf-8?B?RW1ZRVFUYlFnaXA0TDZtem45MEVtQ2tUVmVHMFlDRVBkZ2pIQ2MzV0FlQ1ZS?=
 =?utf-8?B?NnhrZm4rRGdBNExramFQVTFQZDVLdkQ5SFVKZXJYV3JrTWR1L3hNVjFOdnhR?=
 =?utf-8?B?U0NNZ1RTbndCbG41YzBSQ3VpZ1VzSEF4OG1DQm1aYnJmVmMrQWFsdmtuTExL?=
 =?utf-8?B?ZE44eXY5RUd6TzZsZllrb0kxUUpZU2RZOXFnM0M3YWdvR29CUGpxU3NwRWxu?=
 =?utf-8?B?cnlYRmdsbDlMNCtZMXpwSU4vSmp5c2JncjkxbmNWc2lUMTBPYi9IaXhNbnRR?=
 =?utf-8?B?OGdkamEwckFUcEFlaHpIZEJCcHM4Z2hSbjQxdWk3eHV6cThDeDRzN2VNQm80?=
 =?utf-8?B?UE4wZENwbmJWY1JTOHhxR09NcnJIQTU2OXIzd0dJdER0U0E4UUlyY2lnV3NJ?=
 =?utf-8?B?bEhCTDFuWGNjZjZGNFZpVVY5N2cyMDhUOGFsK2d4WXpydWc1ekxiUDBIVXNR?=
 =?utf-8?B?S25Ia1RTRG5abzNTam9tNjhKbGw5eWFjT3hJRWc5Ny9ReW91S0o0V2NKZUJi?=
 =?utf-8?B?TmdWRWorT21MSlloMSs3N1VscW9NRzlmdkxWTVorYUhUaG1hU3R6QUVVTGxh?=
 =?utf-8?B?czl0N3lMU20zdXU1THBqUDdyYzFqUTErTzJERWpHM04vTzBxZDU2OFZmR2Rx?=
 =?utf-8?B?eGJTa2ozbzl6SThMMTBRa2c5RDkwM3RETER5bVR2eE9ycHZ1MFdmOUZRWGo5?=
 =?utf-8?B?YjVEaGJxdDE2M0Y4dE50bGRiUnU1RXVhMFRGclVOVk8rbDJtYTZwaGFRWDFp?=
 =?utf-8?B?VnpqSVU4MCtJd1A4MGd2aGpKbnhNVDFpYnk1M0dKMXBLdW01TUZGOFZCbTI3?=
 =?utf-8?B?bFhjdTBoL2MwQXA1MTZpU29JaTdiMnFrWlBwNlpwRUpYMnhoTm1ublFkVFo2?=
 =?utf-8?B?ZmlCbFpBWkRodDJaQ2JWSHdFcFAzM1I4NnZXTEp5OWdMZnRnd2tMcHV5cGxp?=
 =?utf-8?B?dXR4eVZOLytvSFpmV1JUV1R5ZUpLbzRxdFYydUJhcFNGTXpTMUY1dEtZWXh0?=
 =?utf-8?B?czFUWldoOU5NOXBEc0lqeTgyeGY0R0tqOE5GS292bHVvTFpYUXZHMXVxcHBV?=
 =?utf-8?B?dXdyU294RGxrcmppckgzWCtTYzJJQVBiakZHTU4wNGxzMVBYSXRpUDBEWFBB?=
 =?utf-8?B?UzhqeG9JNHRKclJ3TUlXVmtLR29DMmZYRkZTWGd2TEVUMUZKS21xR3lKdjZC?=
 =?utf-8?B?MkhyNjdsWmpmeGwxS0NxQTFvOWxWQ1NKSTRpVVBpcWlENW5qZmdLRTQxbHMw?=
 =?utf-8?B?NVkySmpTcDlXLzRNV0J6bnFNR0EyZUdxaDBrV3dDSEFFQ0xKelppSnpsYVJS?=
 =?utf-8?B?eUYxeE16R0xGTEZpMUNjY0QzblpDMnBLcmQzRm04TVJWQXhqOUhLVTlxZlY1?=
 =?utf-8?B?QVQ3NUxxbkZ1R2VBMFRhLytaUEJ2T3NhbkhXUUpiMEJuKzU1YUJYZWwzaUFp?=
 =?utf-8?B?bW92eWhCdHRZK016MmdEM3JIcDJ4aDNlbWtrUXYwVGJjVXNtakpBMjI3NTA3?=
 =?utf-8?Q?GI7Nw0fboBF5SZJn068FeXh3/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aab1a2-c119-4158-56da-08db6e606d87
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 11:54:23.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2gHtkCmD7abmO7Ji+fPuzNA87ReriCOWVTcrMMTcw9afbxtih2eOOzqVylV60nvwciW+JQM6Y4J70ee+XLueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7893
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 07:23:12PM +0800, Zhang, Rui wrote:
> On Fri, 2023-06-16 at 11:42 +0200, Peter Zijlstra wrote:
> > On Fri, Jun 16, 2023 at 09:19:18AM +0000, Zhang, Rui wrote:
> > 
> > > According to the MADT, there are indeed 40 valid CPUs. And then 80
> > > CPUs
> > > with 
> > > 
> > > APIC ID         : FF
> > > enabled         : 0
> > > Online capable  : 0
> > > 
> > > a dumb question, why are these CPUs added into the possible_mask?
> > > I can dig into this later but I just don't have a quick answer at
> > > the
> > > moment.
> > 
> > I really don't know.. I've not gotten around to reading that part of
> > the
> > x86 code yet.
> > 
> > 
> I did a double check.
> 
> The MADT is composed of
> 
> 1. 40 valid LAPIC entries.
> 2. 80 invalid LAPIC entries with
> 	APIC ID : FF
> 	Enabled : 0
> 	Online capable: 0
>    I'm mot sure why "Online capable" is decoded because this new bit is
>    introduced in ACPI 6.3. Maybe a problem in the acpica tool?
>    These entries are ignored because of the invalid APIC ID.
> 3. 120 x2APIC entries with
> 	APIC ID : valid value
> 	Enabled : 0
>    As "Online capable bit" is not supported, these 120 x2APIC entries
>    are counted as possible CPUs.
 
Nice shot!

So IIUC, this is a firmware bug, and deserves a warning or error
message? And without 'possible_cpus' or 'nr_cpus' parameter, system
will waste quite some memory due to "nr_cpu_ids == 160".

From Peter's log:

	[    2.664257] smpboot: Max logical packages: 8

it also revealed again the problem in 'calculate_max_logical_packages()': 
	
	"
	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
	pr_info("Max logical packages: %u\n", __max_logical_packages);
	"

But 'logical_packages' should still be correct in this case.

Thanks,
Feng

> That is why we got 160 possible CPUs.
> 
> thanks,
> rui
> 
> 
> 
