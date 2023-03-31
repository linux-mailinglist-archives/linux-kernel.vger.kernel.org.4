Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAA56D2BAC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjCaX0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaX0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:26:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0945F751
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680305177; x=1711841177;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eEoSWc83hGNYTYq0Ol4JlZlI6veabQcMrK7YHsB6Gy8=;
  b=W6RYgeiz08QEPFgI68z/C+7obTJgcBhLFO1NimefAFwuTypKpkYotyJO
   NYauHIbBHsKn5FUqB62N8xZu7dxJ9sZJnv6fxszLeXjm2R+LIOc29InuS
   nwMzRjx/Y7JCCSYpB9YQPpQBgEkyvUnNIg/qYLLmLB4lf0okFJmR6o/Pp
   J/br6YNXQAA3sWXMZYd9mRVdMY2kmi5Y44/nDQCFe41/MgQhJwzwxBcPe
   ZBcAEV30CqbBQHr/CRBHzwfjAgfC57JQ7LRYakELgVm1pT2XAnWFqJdDJ
   nqM0dBXNS0Y5UuHGlV2Tkc27kGZ77o3wO5NK5Jf1K6OSOxJ9Exhm7mssX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="369371344"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="369371344"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="809199477"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="809199477"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2023 16:26:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:26:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:26:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:26:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:26:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htmRHqxLnQ5OD22hOE4FzFfQ8oLa7590BmJ8IHuHNZg9/5JY5xFGyeWM8vXMo2n4pSGZdTMS4MAEgG2D67NJPQyiNU8PdFsKkmAq+2RCz5DXVuOz6n3GgsKAKz+JKQUYgiIqHitAZyhGB7or2UyEEZj2EJVVhxi8OUHj8zg9rRHoEvMy5orGniZ4mzO2Du+BRZfikb5XB3id8lALedFBC0p4uiwyJJD6fXfDTn+pXNttl4L0lENVoKt5N2FxK6AsWmr1b0fX+1qkkb/lkSjaQdsVSN5ALKe8PIPN83DaQtFKPetVU46FhNrd3uV6sG3J4RfKhq0NVnfnPj++2Ab/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75H6gt9pQqAK/cqtk/F3tSUYAtrhsLa8/lp0pMb83C0=;
 b=PC2fOZKd/kqzbOGRnHp8A4yzvSR3sPdRCMh6+G4V4XhkA7I10fggiRy4vtlf8Aw+s691K+bn+g8SfQmcmoqRxN21b4QCQZlNEdu+q42ZNhW2g7YDOvJyX7J3SSBIlDXdkgE/KsRdPLUYTVKPoRWH9GS9jxU+JlJjUBXRowDZuPCnGRPz9y5ySmcoIyPIyChGXONvuXwwCOwA9lHlNS1egwKJ4WI/IBi8tnpw7ih77txwWBTALdM8tSGX/og7qz+S3HoW8Nbrl1iY0vsF1pSd+XDofxYMjlW9dfXa8SYx7ZkIIG/q7cHjE2ui7zZNDm7evuQT4cyXGarI+9PDtLMvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 31 Mar
 2023 23:26:14 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:26:14 +0000
Message-ID: <db59f6df-feb0-280d-88bd-6bbf1b6e7a1e@intel.com>
Date:   Fri, 31 Mar 2023 16:26:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 10/19] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-11-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 51144a62-c754-4d0d-892e-08db323f51c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQjHLrW3GccHOitBA7o5AuV8yEz6C2sXtdeY/eg/wPkrI/dXG9XlN1nAezAMGFCr5QytztJmrVX736aeZt9Zr9TUMrH0r7WWJq9j95ihHXUb598nNFQbmGnl3/4vHPtbPVsD7KxLe2tmq+NIP0LVZGgVpn2aU4zJDJyEH6HrUhSr/z1E7/V7VDrofPJBtW+nks0IeBU802gajvwyp917IdpLz9rqVdMfocG9ah7FeqbXloLeC1/IwhfhDA/v64IvN5Yu3I7N5I3CKi7glLPd4dAx9yY5y0GZq+QXcyd3CoYGAtIYVKr4BWkAJ4eWdD4wav/3K+Uz2NvPJ9p9Q0yPKXrBUgM+QCoQU6DDNDzJnsE72LXrER7AvI0cBMVmcWFfNQf5tW399i59yE8g2IBSkTrmHmRwSvd1cUPKzB172En0x6FCe5BV2gae6wosHDnd3oyZ3y0M8jfVUAHdxp4XPS6R7v76MlxSMMyYfV9WU/JKO+YKVcCbbPv0J34ma3ToWQWzk4iGWrBILEMwBNHxRjhQV9ehs/luFZDZS5CGV/lcKAK1p2yGwofRtRF2iOhs8VRAResfehbkay3qzWBXB+MVGbh1gwKSvU2/XewCFLSrsopW+t4dYz/k8Sm6QfubD0FjCZONUifLz+Qpqmwt3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(36756003)(66556008)(44832011)(7416002)(8936002)(5660300002)(6666004)(2616005)(478600001)(8676002)(66476007)(6506007)(4326008)(86362001)(316002)(26005)(66946007)(31686004)(31696002)(54906003)(53546011)(38100700002)(6486002)(82960400001)(41300700001)(186003)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmo5cHdPeWJnVTFVOEJLM0hIeitMRnN1ZkVYQnQ1YXQ2OHgyNVlBc0tpWUN3?=
 =?utf-8?B?aHN5VHFKNDl0RWs2Tjg5YmlyR3hJRm1Xa215UkNRcE0rOGZPd1RoV01Gc1Zn?=
 =?utf-8?B?TlJtNllwMzdzb2hXcTZ1MExMMXFUdVZDT1RIb016cmdSM2d0NEYrZElzRXBL?=
 =?utf-8?B?Tk5haEx3NG5JeEM0L2JjelQ2VmVEQ2dRNUFobjEyM0F4MzVVN3NDUkpTT3Ir?=
 =?utf-8?B?M3doaEZBL3Y4ZUJUVjlwMFpTRDZWSE1JekZ4U3RGaEkrb1Y2dEFtU1phbkxR?=
 =?utf-8?B?bm5Kd2swdmN5ZmxRZXNEaW9HQkhETTllbWtBdHJlWWdEYTB4cWZOdE1OcEZC?=
 =?utf-8?B?NExjWkhtRGlDZUdSNENBVDFmeWVBRGZLM0dBaVFQcnFVcnVZRzhiNktkZmN5?=
 =?utf-8?B?WXlLZERncWE0Yyt6VGNMQ3pxVEVNT1dPQlFMOGY4dWFGNlNzR3J5dnV2SnNv?=
 =?utf-8?B?dUFENmRCU3dsUmpXRkltU0VKR1d0L05YLzdWdE5RbEl6VWhYNzNEZWs1V3NY?=
 =?utf-8?B?T0xDV3BzWlcwdFFSMDlnMlFzR0RPejlLSjB1UHMwRndtWnJxN0g2YUZTQ2VN?=
 =?utf-8?B?bEhKbzlrQkxpMi90VExySEdkbXFXWHVDakFOaGpSdVh4TXg3ZHo2dzFOVXl6?=
 =?utf-8?B?Q2dxM0RqcTFPZW5XUXhHOEwrNUxmd0ZDL1lyVFo4cTlnekwwK0VRQytDK2J4?=
 =?utf-8?B?RW1OT0k2bUluUkovV3ZHWFUzSEsvRjBXaHA2TVN5cDQ0MUJ4ZlEyZ0Q0UlhI?=
 =?utf-8?B?Wm1YSTdnU1U0bWVCekxPY1h6aURaNGNjTVU2Q0UxVkZBZ1hyQWkzZ3lTMzN1?=
 =?utf-8?B?TzlEMW5sZ0ZkQUpzekZtQk5Wc2xFekkzdDBrRlRUR01FcmpKMUw2bzNya1Fu?=
 =?utf-8?B?V1NwYUk0YzYydkRaejJMb2tlUjhya2d5MFhOaFpPZ2xTVXQ4SlNFclh3ck1h?=
 =?utf-8?B?eEh0dkpYL25seDdXYmY4N1B5LzFidHVsdzd2K2dSbnhzSVRiSXlOVWtRajdh?=
 =?utf-8?B?VWI2TTVPQ2pKeEhsbDFwajF5SUp1ZlFEUGkrSUFLQjhXeWFSK2I3aWdOWjJH?=
 =?utf-8?B?U2RVVGtHbnZ2Z1VNVG1MV2IzK1pZOVpmbTJsVFIzREsrUkhrdUpvTVQ1UmRk?=
 =?utf-8?B?cWV0amdIbHdacG03UzlBc0JpM2xZVXp4cmRxVXFURWVZUnVPRDVwWDdST3BQ?=
 =?utf-8?B?NGJGT2Jza3RWM3g3U2JzNG9oVGRVbVdIakJyVEU0Y0JGVlMzV1E0WkxmNnlG?=
 =?utf-8?B?dWtvSWRYQVR0NWIySzN0L1RNWWorWWUySXdZbWdDRVYzTWk5ZHdpQWwxK1pJ?=
 =?utf-8?B?ZUpZeFJvUHllMFZuSytOdjVFRm93Q3VmNmdUYlYzSm1Tdy8ybjljRlBUVVFL?=
 =?utf-8?B?TGVFQ1ZGYkdUaUpoeWxhNkl6Q0xWN1BNaVh6UHdjYlE0eEJMR0lIL0Rtc1l4?=
 =?utf-8?B?ZVdocXNja2FtQjQ4c0VKbU5QeEc2T29oRlA2UW5XUGQ2RjV1QStIaWZhNk5M?=
 =?utf-8?B?ODhobUlGb250WVNjaTcxejdJcm9sZ3FNRnFGdGVLbExyQnljN3Nuejl5Uzh2?=
 =?utf-8?B?SnpzOGM5QUNsMVBrRTVMdWQrYzNUeWVtNHkrcWJhUFFndXM3NFlHSkllWFBU?=
 =?utf-8?B?V2RCOEt2NCt3d09zdjh6M0NCRGhMaFNkaVFKdjNZYloxaDNheHVqdmVldUxr?=
 =?utf-8?B?Yi9RSlpWWG9iS01zcFRwTnNKSnBsM1E3RWx0akxGRkJ5bkV6azgwOVZCYmxG?=
 =?utf-8?B?U1p2SEpaZWZidE5aeDJhVkFreWwxNVhyS2MrYjhaMi9lWjZxaXk5aUdDdUZQ?=
 =?utf-8?B?aGZNYXBxZlhjVWhFMzNSWEt4WGhWaEplL3lCdC9HTUcxSUJjekQ2M0NlK21G?=
 =?utf-8?B?ZWk4NGlYTTNaMERpeTBKa2FTeDFWam52TXl1c2xYdU5aNyswMTBnUStzMm5D?=
 =?utf-8?B?WGJnVkE1c29WaHVmOFJ6UXVJb1ltRnV5Nitoc0hIby8veTNVa1BwVGs3WGFX?=
 =?utf-8?B?UG41aUhYVitnbmtIUUEwZHAvZVFDdkUvQ2g4S3Z3R3htT3BSTWZFcmZIaGtG?=
 =?utf-8?B?WVBweFV2YWhPQnVvbG9CMU11aml2eXhKb3hBdlJuQTkyMWgwQkVQZUllQ0or?=
 =?utf-8?B?UEZ4WXJpRVEybmx0QlEyN1UyM21CTU5nUHNtMXNCQ2VmcFRWVnBpb1ZNZlRL?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51144a62-c754-4d0d-892e-08db323f51c1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:26:14.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBenBToiXCHWcA0tWYcWnLfvzpnnJDXZYpQImYqFwHsagF+9OafzYU3R1JJvYrnUysZ57IdueyFp1nUudEe+da63DsdH3J9mVnimB+BFnhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:

...

>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>  			   u64 *val)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	struct __rmid_read_arg arg;
>  	struct arch_mbm_state *am;
>  	u64 msr_val, chunks;
> -	int ret;
> +	int err;
>  
> -	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> -		return -EINVAL;
> +	arg.rmid = rmid;
> +	arg.eventid = eventid;
>  
> -	ret = __rmid_read(rmid, eventid, &msr_val);
> -	if (ret)
> -		return ret;
> +	err = smp_call_function_any(&d->cpu_mask, smp_call_rmid_read, &arg, true);
> +	if (err)
> +		return err;

This seems to break the assumption of expected return values. __mon_event_count()
does: 
	rr->err = resctrl_arch_rmid_read()

and later rdtgroup_mondata_show() only expects -EIO or -EINVAL as errors, with
default of success.


> +	if (arg.err)
> +		return arg.err;
> +	msr_val = arg.msr_val;
>  


Reinette
