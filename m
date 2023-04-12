Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D66DEAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDLEjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDLEi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:38:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C401BF1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681274337; x=1712810337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IyQkUCDMxhtlpZzRgvFQtd7N0paz7Rw4j84schWQrQs=;
  b=QXWV6wN8DQ4QIpSJz8THttenNZeVO2PY7lwdQ7T2WlF2Xl/qnAb9mT9u
   lMbp79ZKtEuYO+pD/Hy36kqLbRvlnKb+N6vjOvtwKTN+ZHY2BJT71lX9Y
   h1hIgKD01+TJI66eHyvdv6DnVckl5N6PdBNrlW6H/QxiAq+S4fnNmyEZC
   O0J9UCC2dPHPOpzsuIZGm9mihszWZiANrLTOF2HV568QbBjdGw1IZ+AFc
   u8BbgupZyxyLcUgZ1cCOCSyAjfaRnXd80lckGC437sSCgB7VzPlz2FAo5
   abftkpn/st+VCr9Ea1GSk6Et3EmbKSCwMQSNUnSVVSnbDqfpCQ05zS6s/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343803309"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="343803309"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 21:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="666204355"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="666204355"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2023 21:38:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 21:38:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 21:38:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 21:38:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 21:38:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmzY++E5lhYWtIbvTUXBhbr2/Seyw68U+j5UJOq054cHy0kLZkoG/H2tkRevYjdfftMeBm59UhhIr2ovYa1LIAFHEL7x+sY/a5I2T85uxFZVP3RPECi1MVumCFI1GYZKFrEB2bJ0t4Qmg99FSRR+RKW3lGPA06YGW2D63K8LG06XThrHhQBTJczv0XQkZRUp8gzbVam45/8ChXpQ0bK5WCXhPkqIB4+KVpoNcsN0BCG4eCY9F7iuBu5qekP6LKfojsaIfQY+V6eaMb9cDkRWOOnxiuCEvJYjfxT+0jUKqaCGJ0qeaPv8EQNp9+FEdTBpo0JenYiqD8wBbkobJ568XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76TOwK6nePc53DrsFbVWHA9FcQ4/FyLSP+YjNLhIdiY=;
 b=BuYg0Fughp6+0j7YVxZG/m22be+/mo7TZG5iViQ96+uVVvZaGroCYwtJguFz5W5HDHxMVM/sFoPtezL34fdhOR28lh1I15tOcUqCbRCVOmzC8jlFo1fXrtVvtvy43d39nfSUHVycve5Z4keTbzmAsUvFKDTFkjzBWZ4mNuQJnZu7JA2JuMbwiiMrsyrfbuGsWPDjwVL+5kfnBFyH9ZAqrxeIwgFPJVu202JL2yIsowjiW/MhP3CNx4UzTC2/ES6rTq3EtfZmHBP2guLbEQZP3I6IwgnOWjyW8kgLigyZsc3GkkQpMRj2gzOPSJtrL6jDSuNYLuH89USRY+ZOqMVCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 04:38:53 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77%3]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 04:38:53 +0000
Message-ID: <388b09ea-7eb4-2878-5292-97475fde8a5a@intel.com>
Date:   Tue, 11 Apr 2023 21:38:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH] x86/fpu/xstate: Add more diagnostic information on
 inconsistent xstate sizes
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Chintan M Patel <chintan.m.patel@intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>
References: <20230405183942.734019-1-fenghua.yu@intel.com>
 <113918f9-0e44-3d46-8b48-028277ec26bb@intel.com>
 <c716e021-99ad-2cb7-44c0-ec8393a3440d@intel.com>
 <2af114b9-2737-70e5-f534-e60416b52246@intel.com>
 <50e67263-33ba-9921-1bc2-a37b99bc2459@intel.com>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <50e67263-33ba-9921-1bc2-a37b99bc2459@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|IA1PR11MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b72210-f517-46c1-4897-08db3b0fd1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnfjKD4r6Qd6i5VwzIyFJCpDfbCJuZw4a+5kJ/diCgP+/J+cU+OfO84Tp67Bx4Oo98mpE6DcuaCgXEy/e+cHZJrsENUdaWnNZuT1yXB6O8grWLU7nhzaiuegAc2mC7qOWBWkGL6M7YD6Iat6wv2y94UIl832s/SviedNJlL0rLjDW4x6m7G5sfFGVIKfPuSaLwZb/xVQ53tp+apRVUQTWaUg40ab9d8QhWMCFs4yEz6TgtH/FsGQD4cOCTPBk2r7RrIpm8Nct57uvT/T0zceSyc6aC02yLYFvwaaDWpx572B872rYtT0HHPqh+SGl70j7FfBXlJrJZcuAIL7/rQMTYYC432uDyrtquRjIp+EuwzTNEapT4T77bP6BxAOS80w/Zu9NV9wx7Za5mDND5PB0z0Tcm8ELz7VwpWXOcUuP1hNKowGykpRNANAaJtDBSJJrKa4Vy1E1y32BHBLhBFKSJzP1JdAXwGafRAAFO7+cHk+gvOhsxQLjYjoEIsm24lvpc/U1hSCAtlIKIM/+NOHhN+Lmj1ORg3gEC/Dl+IW44hR9Jn0655iP5T4Hvy2p3wSqk5F2eLPVtcvJrYyPt/HbY625WKJL9rJVEYa9mQ4IEHlIHlxkoD53Fpk1R9oiCbrtUzdLt8q5VFbfhGg3G+0r++9/Lhx5zw24YIIv6MWxeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(36756003)(31696002)(86362001)(6486002)(41300700001)(110136005)(316002)(66476007)(8676002)(4326008)(66946007)(54906003)(478600001)(66556008)(5660300002)(2906002)(8936002)(186003)(82960400001)(38100700002)(6506007)(6512007)(26005)(2616005)(53546011)(31686004)(69864005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXRtemRvQzMwMU9XMUhjTlF0aEkrZnVnUmNMY1hxQTFnT1JkbGQyOG5kLzJY?=
 =?utf-8?B?c3NrWG5zU2wyZUo2VE1yc21kYjdHYnQxbjVrMTBHcEZRaWdYbG4wUzh1N0lP?=
 =?utf-8?B?NCtybHI3RWxGZmZCU2Y1RStqeElOYU41cmhzUXJzTDc0ZExib1VNTmFmNk9M?=
 =?utf-8?B?ZTRraDhmbmVGaXNsdXVYRWhSM056R0tqd3FBbHJOWnpybGNIb0dwb0d6T1hN?=
 =?utf-8?B?M2VsTTZCSWFvV3NyV3FjWHk2akhmWkNIZDJkOU1STW1Fc2ZFQWdBZ3AwUTFD?=
 =?utf-8?B?QlpiYUR2L0pzUHMzMkJLNURDSU5VUXp1cm91ZWRXaGRNOGF6Rnc0WG9GU0F2?=
 =?utf-8?B?WTY3cjlVV3N1K0ZkZUdwNnRkamFXaW5odFY2NXppMytvcWd1RnMxSHBhblFO?=
 =?utf-8?B?d0FLdG5KQzFqdE1BemtxVkZrQWw3T09nYnRJQk1ZQjlMR211Q0N4bFc2dFI5?=
 =?utf-8?B?WFdnUkYydEYvMUQ5WmJUMkVzeFFIdTdJc3IxQ3l0dm9LTFExT2Q4STJtVVI0?=
 =?utf-8?B?aGVPUVdBbUVrZ0d4dUYwZVZKL0FPTlU5dnpUazFVQTVUWEZCQVNLVUlWQVJO?=
 =?utf-8?B?MVNYSFdvd1JZTmJqRWJrQmRPRXQ4WkVka1pIc1FHSHR0RTRkUmQ5Rlk5ZkZq?=
 =?utf-8?B?YlVsRjBCdDlXc21kdnB4RlVTc0R4MysrWEVzd1ZpMGltWlZTOTVMVWFhMURm?=
 =?utf-8?B?RjRyTzRFblM1Y0dWWThHdEZ3TWFod0pqVDFmc2NuakxnaW5PVmJlSUJ0VlEw?=
 =?utf-8?B?anZEeU94UDZGSHE2U1U4WGZ6Vzd4YnNLTHYvQ0NOTDJ5ZWMrK09Obm53NEp2?=
 =?utf-8?B?UkJPYnVFU1hBdEpQTkJtZmVKamVabmZsNjdGdDl6UjFKdTRtUTFwQ2hRcGRw?=
 =?utf-8?B?N2hwV1BFNHJvU0o0dzVMS2RxWGsxZ2M0dzJnMktjcjhSdy8yaXNtL3I5Z01o?=
 =?utf-8?B?Y25nekhFbURPYkkxUTdYWXhVRWFFRExnYVFQOGkrNXZVSHo3RFlrOWxzaFdn?=
 =?utf-8?B?SGowbWNTak5uNSsycmlEUXlFczJOanVNVnlSTzhXanhUQnZ5K0ZYc0dhdXVO?=
 =?utf-8?B?U2twTzNHeUtZSTZ4Q0tWMnA5aEp1d0RJUXFETC9HdXRwQXRUeVR1SGJoV09F?=
 =?utf-8?B?c1NmWnF0VUFpYWN4Uk1aQWpKZ05WT2ZjZ2pJQk4yTnpJeTR3bE1NYlNER0tE?=
 =?utf-8?B?TnRoUVVXbThpVDI1WGdBT1JWSlhuRjNPbllwelFDbDZ2MVV3S0l5Y2YrZTVY?=
 =?utf-8?B?Nk4xU1FjRWYvRzdRZlFtd0ttNjZJUjRNM0R3bnk0c0lxd2NLdWl6OFhYbzhL?=
 =?utf-8?B?RHpjbDNrem0yc0lJaW5FTmkzM0k1SGpUd1g5MWhDOExhSlBTU05qRzBlRGlZ?=
 =?utf-8?B?MXRyZEZzL2JsbDNTWVF1M3dHanJoSHhZL3phNFBGclJ2c3B6NFB0Y2lOeGt0?=
 =?utf-8?B?L1Z4TVoybVo1eUEreXlwSEZpbnlGeDZDNUdQOCtlR1hOQ1NmQTFLS0phMWJk?=
 =?utf-8?B?UEF4azBBSXpxMG9WVWhnQ2FyTGk4STZkSC9YWGhVT1QyL2dDcituUU9RZFZt?=
 =?utf-8?B?RW9YRmlJYWZyMzZqOUFYYXltMkRDZ25vaitmNE11MFNKVkE1ekhaeitzaCtD?=
 =?utf-8?B?L3F1K1U1dkd4VWx6bHFFbm0xU2x4N2d1SWRNakd6OExNb3N1V2RGenQzOVd1?=
 =?utf-8?B?eG1tUGtZVC9wSk5UM1l0eGlwR2xURE5zWThRd0hvUDVXUnhxY2pDVUpublVI?=
 =?utf-8?B?b2IwcTZ6cUwwOEJNcTlDSk4wSWM2NWFCMzFsKzcwWit5WnJIN0M4YmhiWUZp?=
 =?utf-8?B?THdmc3RjWGpWQXdhZVNCWkljSkQzeEI0ZE45NDR4TXNScWl1UlVxcFBGMDBK?=
 =?utf-8?B?aGJjSklHNWk2L1hrVkZCbVMycXh5ckNYSFpPQVNhSENqV0hMVGdLTnd3d3V6?=
 =?utf-8?B?R0sxQkNodW1TZ3RCL1U4Zk1FdXUwWS82UVZTeUFRSlpnU3Y3ZVgvRCtWUGt1?=
 =?utf-8?B?eGI1bXU4MlZ6eXZZUDZoVzV1SUlZTjZhYlN3cnFqSmFnUHlYQ21xelU3eEtG?=
 =?utf-8?B?N1NEQ1ArSDEybzErYzN3S1Q4em1BZS8vdEhFdnZ0Y1ljc0JmTGNZKzJpWjI5?=
 =?utf-8?B?NjNqb011bTZUdStRT0Q4WjV4VHE5YVBJd25HUDNZejBNVUR1ZW1vOTFuc1du?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b72210-f517-46c1-4897-08db3b0fd1cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 04:38:53.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umzs+GdAIPjEn/4gytNyEvczahGS5FJQU76yFrZ4fR9eAVxTdtKjydGfsivrirN9Z7YbupJLuJz51v0HSkAQua/K5bKGtcKVOzwfi943LNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2023 6:21 PM, Fenghua Yu wrote:
> 
> First of all, max_features is shown already.

Yes.

> Kernel_size from CPUID.0xd.0x1:EBX takes XCR0 | IA32_XSS as input. 
> Platform may take wrong XCR0 or IA32_XSS and get wrong kernel_size. The  > purpose of this patch is to provide more debug info to help debug
> platform/kernel issue. So instead of a whole max_features, xgetbv() to 
> get XCR0 and xfeatures_mask_supervisor() to get IA32_XSS provides more 
> debug info in case platform may have issue in XCR0 or IA32_XSS.
> 
> In other words, splitting max_features into XCR0 and IA32_XSS and 
> showing them individually provide more useful debug info than one single 
> max_features value. >
> Does it make sense?

Hmm, I don't get it. I don't think whether the microcode takes those 
register values wrong or miscalculates the size does matter here.

print_xstate_offset_size() or something can decode the mask and readily 
shows off how it was calculated here. Then, probably that's it.

>> I still expect some acknowledgment of what is coded here for the 
>> kernel calculation details.
> 
> The kernel calculation is shown in
> +        print_xstate_offset_size();
> +        pr_info("x86/fpu: total size: %u bytes\n", size);
> 
> Isn't that detailed enough to show offset and size of each xstate and 
> sum of sizes?
> 
> After that,
> +    pr_info("x86/fpu: kernel_size from CPUID.0xd.0x%x:EBX: %u bytes\n",
> +               compacted ? 1 : 0, kernel_size);
> shows how kernel_size is calculated from CPUID?
> 
> Using the above debug info, a real platform CPUID issue is shown clearly.
> 
> What other details are needed?

I recall it was also asked to show which features are off or mismatched 
as compared to the CPU calculation. I'm not so sure about it.

Thanks,
Chang
