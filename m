Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF06686F66
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBAT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjBAT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:57:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172C96E438;
        Wed,  1 Feb 2023 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675281475; x=1706817475;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dPXJryvveKvRsuHz7Sem1CH37G3vT3NOHxSweHk0wDg=;
  b=GHTnWIOeGuAW7xr80/r0QaKTbI8GxjhEvo4LpPNY9QVmqIE/Crrxga0Q
   KHatHzoZacbB5jf6tV0rpCOChRAw0Ak4SX/FZWJIRsMzi0azjXCRqGLIg
   eo0lmVPyygbvVJxQujxXPaSxbMKLYjiPB2KMvOQHp6MenE5JZr74G5nCV
   nePyNYy72fwfmyw2cS85Z/d+Db0bxLhk4dWvF9Jk5o/v0cSU3BCPuYpMA
   vd0a96hzC0IZFNKrLdfgzD4mRBcnpbU1KqFKgKj2OU/bNFXqZxR1B6LqW
   XpQNhGVrHXC8eealgXs46QKQiC2OPyfKAHjDB4Y1L0Xt7r8HnZz0VwZi9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="390648960"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="390648960"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="728547809"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="728547809"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2023 11:56:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 11:56:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 11:56:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 11:56:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 11:56:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl+Fp0/dinAlpbsUKvUjyxEeEi9ILKpcuoQa6LaHc1iJlJVFfySOYCTbjJwYAKjg0C/9xao5LrGv9BqBiS6BhW96NLGpdNjnbJBmy8wGUrfCtNhlislYjNn4FuYXn3/W3L914q1xqLZEH9RBNZ9jUmtEk7jvuaihuI1c8xX2OxEGnnLwtwEOMRAi3UX6w3/VymlZ5ohfeyIE3RvAZ5TIZa5UPsrMTMaOZP0CxJLrvw/fK2/TTDMzWFTgDdEld+6VsJi+ZMoBhfC0vuj9HEAA94Nq4kcvuVcQw5AKY+aKY6si/CBBwLq+SusaIynJYsh0U6xkNspth5qRnTpI6kUarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q19DnxVyuftG8QJtllTZdn94015cdKMov1Vh5ZnMLQ=;
 b=eit4uGdcuBbNb2LSLNwcSp55ANAmIDBeGR9GMt7pOadkIJLDb2r1/NX03Wefz/OJV1Ok3Je4SkbmBXDrzVSxnnzfM4W6U5Q3DfOblwfUHai2dIrxgvzF4NvHMJM7emOcXfEb5AjzYYLAGGgkXqVo0AqoA/LxAhUwPVk0kOCjQpYnLhQBeJIm7xoHH/LwEcxt/y0KTgA6HdEj2xAUlLY8gut3/6ecQFNusCMy0F6vbqXqBeGOwLSyiT8L/B57Kzyy2y2+hU6fqgs4RTEKiSK2c7rN8uacSTRd/xJ1TXD2+gdVnZseRCtybtCQG4w2IX2AC7hXwaR78qvakyt43mdHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 19:56:55 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6064.024; Wed, 1 Feb 2023
 19:56:54 +0000
Message-ID: <c04c1aee-b84c-324c-e7db-c004e778ef4e@intel.com>
Date:   Wed, 1 Feb 2023 11:56:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
 <6a675f9b-2bbb-9317-2015-0b3362e49fdc@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <6a675f9b-2bbb-9317-2015-0b3362e49fdc@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DS0PR11MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: fa610188-2b27-44ce-d9a0-08db048e7771
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3D3mAqwJKouVuZJREahW8Wk9Iw7pWqAEPGyOBtvb838iPwQNkmNerpoJ/UYFYgybvJ36uBjojcfZ+C0/b0pd7E0BfbOz1+axMvp+gf67Q5SjbkyJ3qH9J7zlq3eV09pgzyLc9PiNKCyqgzia2MuY8ykoQKSbNHlU3UQ8T0OpcrxqhlfS3Vbm7xy9bGxIyw6RHpybalcfhpXfA9u/nwIIIT8xONcve5/JRBxMuM6XQ/KxpxwEhc2u5X5XXoKS9MN+wfvOixEErE4SaL+ijk14qF292ppgPDWvKiohchnFbgQkadRAN6i4AZFFBwiAQ5OfRrIPuBRXkhA8SEvXkexWyHvI/lpYuBjXI0WU5RC+2odj9bWC7opJ/zs6FBXgFeetwUetGSJ4FFpBlTlbwwKXgSWNoDjMEVdW+HVDWGiS7nKHjl4+VXMdsQInM99DQogyicIGaymwFUUf4C0GM/CDC7rT7+YXE5Cnwcn0ZEftOQOCcuYN61jUMz3XKfHoBRzc36WzuLjTGc+B+1BOnbZl/wgfTIjpHDvwrLnY6e+e8VqKIxXOnLRrH2KLfmvP5a1I4/1tTvz3Zu1hoPP7D7RAbN2hc4LTwsqwVMNH9CJe0AbiH4pEnM1lLqxdFyRw4JvH0rvR9/21bJdIy1rjz1zC+wDWjovd/NcJpd56WW/cYI7dVXbozM1M0DStvAEon1P+1YX7H2yMbv5TdibAEX7kq7m+f5WT7TezCQuFtlDHWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199018)(83380400001)(66946007)(66556008)(66476007)(6486002)(31686004)(4326008)(8936002)(41300700001)(478600001)(8676002)(7416002)(82960400001)(86362001)(316002)(2616005)(31696002)(38100700002)(2906002)(36756003)(6666004)(6512007)(5660300002)(53546011)(26005)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBncmJySFlPck1hTTNDRm1aUWVkQ3kraVgzc3JsSENQMWNWU0lEcFhDMk51?=
 =?utf-8?B?cXdqMm0rNmhpdUZ6WGl6dkZ4MU5EV3lwelpqT3paSUpWcU4xbWFsMEdCRk5i?=
 =?utf-8?B?YWlMZjNNa1FsZlIwNWdNQ24zUGU1WFVUNGVmUklDRUE4OWJVT0dzSEFLUGIv?=
 =?utf-8?B?NnhVbVlMeUFyV0xvcnJOM2VYcXcydkZOWkV4SVJVNUtQVmlrelphZ2hyUkxr?=
 =?utf-8?B?emFLanV3dUp5N2tvZC94UDFKbkgvdTU1cFZSVC9IOUJaZUFEQW5uVVNtZG4r?=
 =?utf-8?B?SDJQVTlzRkE0TG1yL3pYN05Bc1A4MGJzQXo5VWZaY0hmRzQrc09UKzJUM1BW?=
 =?utf-8?B?cFBkalRyRTRiWG9MaFhQQ1Y4SEJ1Ulc1WVhlVUlzQ1BWcEtPMUtrOUp6elVm?=
 =?utf-8?B?azFPN3J2UThIek4vU1dQUW9XTHNMYXBDN1RxRmZlUGlHRWZlQTlObHJLQVp2?=
 =?utf-8?B?MjN3UGphendCSndVVE95QmF5ZXdlcXdMaDhScGpCbXZNNUJ1NFJOR2MyK2cv?=
 =?utf-8?B?VEV6NHJQb0puWm12T1lMMHhpMTR5OHk4WlIxS09NZGdxZDYvZllUdFc3Q1V4?=
 =?utf-8?B?WGtONlpLZWQwbE5ocDgwVWs2ZHY3b2x4YUFZY3ZxMWJhbEdxVUJhMExET1hM?=
 =?utf-8?B?SFBrYzhJNVQzRmtTbXBtRXR1TnpNVGVtbDhyYkJqQ2FLSHUvdjMyMXAwMWNv?=
 =?utf-8?B?YTF5UjZMR1B6LzRUWkszejhoOFY5QUZvMVpKUDZpbFRnZjlSVVZkUSt2Unpw?=
 =?utf-8?B?OEFCS205VkEyQ0E0eXMxVlJYMVY0N2J4R1hmTW5wNHFkRktGQ3RlYUx2Qkxy?=
 =?utf-8?B?SThsNnRTL3NkTU8wa1pSWk9rZFZ1VEFKUUptdEtqaG1pV0NDekJwRmVuMmU0?=
 =?utf-8?B?SWR1c21oWFdMcHVEUDhuVlRzRWpUWTFvK2pjQmE2VVVRNEJUQlNGSXBtNksw?=
 =?utf-8?B?VFJvZHJhbWFDRHhqYnhiVXZuQVd0QWZ5OHFqS1dIaTFyUjBESGRvNVhibGt0?=
 =?utf-8?B?eTB0ZWcxd0k4RTc5VG1KMHhIUFdGaFBadEJES25Nb2JzNjdrSGpaNmI2eVZu?=
 =?utf-8?B?YVY1dWJJQXc2by9EYkZ1KzNxWkNMbmJDeDdROWZlRFRHN3MyVzlFRVc3MVBL?=
 =?utf-8?B?cTVaYnl3K0hsNis3K2t0QjZYcGR0OHNSYzJYK09lRHdTWFhlYXpISjU1QUhW?=
 =?utf-8?B?bXEvVllMWnczVWlwSFBPaFo0TkU0RkI5V3QyaS9nZDJLdjFXejlkcmRKdERG?=
 =?utf-8?B?REk2Yi95c3dXbjNNNjdSelIwcWNvVDNYU2lmRmY2RjVHUlpSZ3ZONEJoa2Vr?=
 =?utf-8?B?eWlDMCtqeWV2M0pPZGhTSlNZMFJ6OG9VMnpFS0VVUkFRc3RzVnlhcGsxRmdS?=
 =?utf-8?B?L0xSQXBqK1A1dHdhT25VRTlWU2t6NUtCSFIrUENSRTJOTjM2Zzg4L2N3R1Z3?=
 =?utf-8?B?TFc5aGEvQXp3QnRRVXIwUmsydDVSS1RjZ2xLOEVzelFkY1UzU00xR095VlFL?=
 =?utf-8?B?SVRuL2JGS0tHOW55YWtxcjdIYXUzZWNTNEhubUVjY1VIclNDeWdRWEo1K3Fs?=
 =?utf-8?B?RURuNU56U2kxcE85ZHljQ2tVZDIvWTFtUGdSSklhWnRtOUpocnZjTDVZMkxZ?=
 =?utf-8?B?QTJhd25ISjltL2Y3dUNpQy9WVDdxdlB6dGRtWVpGSTlBaGRqampTZTN5Vi93?=
 =?utf-8?B?Q3dxWUQzODdRTnAzTXIyZkk2UHVSMzkvQmdkbyt4WHlHZ2NtM1NvdTZQYVlt?=
 =?utf-8?B?SE10TjdVUkdnVzJLeHdVN1JwQUI0WC9LellzWnBHUEV6Qk55NEZON2Y3dExa?=
 =?utf-8?B?a1QxY0ZGVHVSeWt6TnhobHI2RTFrQXFjK0VJWkJMeWlvOTdsTWQwYjI0cElK?=
 =?utf-8?B?M3h2bitSZW9IOE5rL1dMUzVqUUpyalNOaU5vNHkrM2ltRUs4aGEwM25QTkVk?=
 =?utf-8?B?czViaVdQZElUTjFtc3pCSThkUlJqTXNDdmVOdEFQNWwyRytLMUFVVTVTV2dK?=
 =?utf-8?B?N1hBU0t4OVJSNUFhdjdib0hCY1dCRGZqTlpENHNoRmNyZkhkQzhkTTEvaE4y?=
 =?utf-8?B?eDI4WGpRV2oySnRjVmowNWJCdlVCSHRNRkZyWGNVVlU2ZkJUemF6M3lWWWlj?=
 =?utf-8?B?elJJN092bHVGcDlqYmVGemk0VTVMY2xieWR4cTdqUXNNUzNweUZaNlRLTHNR?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa610188-2b27-44ce-d9a0-08db048e7771
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 19:56:54.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDivw8zhSP4ZRj001sux9izYmTC4L5fII2m0sapgv5/j2gYp3YZlnEpeJhMb5Lh46a0w4A5yiUQD69RyWxPX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2023 11:45 AM, Dave Hansen wrote:
> On 1/31/23 15:43, Jithu Joseph wrote:
>> +static void ifs_array_test_core(int cpu, struct device *dev)
>> +{
>> +	union ifs_array activate, status;
>> +	bool timed_out = false;
>> +	struct ifs_data *ifsd;
>> +	unsigned long timeout;
>> +	u64 msrvals[2];
>> +
>> +	ifsd = ifs_get_data(dev);
>> +
>> +	activate.data = 0;
>> +	activate.array_bitmask = ~0U;
>> +	activate.ctrl_result = 0;
> 
> I think this whole 'ifs_array' as a union thing is bogus.  It's actually
> obfuscating and *COMPLICATING* the code more than anything.  Look what
> you have:
> 
> 	union ifs_array activate; // declare it on the stack, unzeroed
> 
> 	activate.data = 0; // zero the structure;
> 	activate.array_bitmask = ~0U; // set one field
> 	activate.ctrl_result = 0; // set the field to zero again???
> 
> Can we make it less obfuscated?  How about:
> 
> 	struct ifs_array activate = {}; // zero it
> 	...
> 	activate.array_bitmask = ~0U; // set the only nonzero field
> 
> Voila!  Less code, less obfuscation, less duplicated effort.  Or, worst

Agreed, will modify it as you suggest above to remove the duplicate zero assignments

> case:
> 
> 	struct ifs_array activate;
> 	...
> 	memset(&activate, 0, sizeof(activate));
> 	activate.array_bitmask = ~0U;
> 
> That's sane and everyone knows what it does and doesn't have to know
> what unions are involved or how they are used.  It's correct code no
> matter *WHAT* craziness lies within 'activate'.
