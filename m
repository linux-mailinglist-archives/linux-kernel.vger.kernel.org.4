Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5334962229C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKIDaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiKIDaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:30:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B76426;
        Tue,  8 Nov 2022 19:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667964608; x=1699500608;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D6TNx5JqwIPfZpPtoewVMNIJvtcnqHk/4Iqgn6hrJKM=;
  b=FA10wR0ygdssRVvBSPwt5CybVBjdBfuVoUeYlT/sAgWXR93vPyJUc0WL
   h/bMIeg2XxuHVVw3ee38AMOwOpPZFUNOVp3uwmpVNcn5EbBjsTYUFdamD
   oWe4DGoHAaBuCLAZnFhrFOlueUNuzYl9ys6ohPtDP7379ZMhVEmxrEPRg
   gf1KIBpaputC5aoCKBtedIeEoizg1jT5LiEvTQ7H0oo5tB6sstx5loTqG
   v5o4fWTVUJzA1vHSnLuomD2Wybl3iHCBUefBYO7DtUbld0gxEY2N6k6F4
   ETTABysjiY6r9TsBnl0BzSnz91Pe5knI3kCnW0hgeDbFk6xJ8sMKrQKRC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375150950"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="375150950"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 19:30:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700183035"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="700183035"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 19:30:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:30:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:30:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 19:30:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 19:30:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg93nRCa8rzH/4NwLRxkzv6bUcu6eQGKq1NZy8ZFu9C6m552rINOJBCtNHlvvmi8k5Heh7Dp3+VlSJOr8uoKuBT+a/FlivsnPa8A/G49N8PDW7sJOBr32zHUrXDW4SLIg6pB5DaKHmFsxBd77vZqDXJIzY2dlrJaVT1x6HredPN66fpKRz8STw6lc9wMJSqKiAOxNjdOL+9rOw9Tp7L4J+4GzB6RraLDFzNdMn2uXNAvXb6sfsyA4YYwfx3FgCX8DPO7BUAVWxpQRLIHTFerMEYeWtRrfLgZNxiUyi7BASshyS9fBH9pr1Vpv74InYyVWkpZCYQMQOINm/9TIKVh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwVnci62ZbDyEzRNydsubKZOTNBJ59gRkVfAghTfm6s=;
 b=KvWoKcZZtwIINBe6AyHZkQWwPtGWznDdmZXFAZBNvnuez2FlFKj3e1LergZNK5vs1JhvmzOaxheH0CRVDh0SNMY9jqo9T1gs53LCfyJ0ZejBgJKM/HnHlJhwXG2Knk/fP4HmXSBzxoJmqQxTSK5z548Vgs4YTWs0aW3uMG5fmARqpXFnj/4LbyVxNutYygX7I+SVxdwOVvJCgEvvvCdI/sCTzC/CbtCYK4H4cA67PPxZ2KPL6Ls0HUlSpmVc3T1lEZwowwRJ1GG7KZxSNLJ39GW+XCwJL2h0c9FfJl0lWwkgrlLSLwQ3qMB0dEJJk33rFZlJ4ZZL0S36FnZzIk3I/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 03:29:57 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:29:57 +0000
Message-ID: <1af04fc9-3207-d9aa-4464-cdb14b983997@intel.com>
Date:   Tue, 8 Nov 2022 19:29:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 09/14] platform/x86/intel/ifs: Use generic microcode
 headers and functions
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-10-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-10-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c12404-8a27-4dd0-0929-08dac202ad15
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hp5kO8TiXRu9Z2O/l3196WgYrYIHsONNi8ury6KQ5edhanZUWcbkYkRHB7zU39hlYspC3MRlW90ydFyktCfrBfLATYNykIUdCNhRwVLLh6y4OjYOs8G2wa/dlckLbnQF4WjRYgIccqfAIbifZ6uwgWCcVXrBJUi5gm4nLNRSdYh8N7yT6fJKLK0IlG9mHuymPWjoePNt6kSHfFn7zgdzBGnhZnVeWIpktbnmzxNdABI4wJHckQP0K5ahClRVW3IOJnGEGmliK62k3swWiiVE5oyW9dMFWSstF7YSHrVpeeXV0LZ84SgLJrpYS3ii/4bG1CwNnDRdqkEYblSbDmZVXltB30vaA+MnyrJcRE8jXipWgQQ5dHgbqOEicGV0E6G+BSWYfJldkIP1FZCqc1djJ5UvCX4RSwTFOhCqAp/eiMQpgyrNVzJCfc1Ga/Z8OwgcyAula5/F8KnphXEAySOoYrKYMrhy6vcy9RZ+fDBMZNp9NP72lMqLQLfL7KaNaCWh/OYZmfXO2MUXzp7qx7DTV5WRlZQPbHjY7VHVNsmgpQ7fUpjkP9Wh3GlFpLvTMeXFKhDyRlizeVLVE7QkpS9cvrXla6zI1epMzOCLFzuU+4qm08eTnT4kfEKrMbH733tmc8/B7oTi214bAttRyKzaA1T7ev+pGmuZJOIYyK0sJPXXjm0BI0Tw7IClo3EJQtpOfMbqAr+LHBNRMaR4ybOLwAHgIFgG4nw2LgpnOqwdE1woKVOa+oUmBXXh95uPwKjIYV3ujd1wOjb7k06hZJ/05OANwC7mlf9SV/BwupHIrQTc8qD5QDIWTlV1kDfN2yT8YyNYjS6ggC5qhfQfX+Urjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(6512007)(26005)(6506007)(53546011)(2616005)(2906002)(186003)(6486002)(478600001)(82960400001)(38100700002)(41300700001)(8936002)(31696002)(5660300002)(7416002)(44832011)(86362001)(316002)(66556008)(4326008)(66476007)(8676002)(66946007)(36756003)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZhMHhuTzRjTW40a3VQb0txUHFsL3FnakQ3aGd4dytnTVFxYkpyZTU5R21M?=
 =?utf-8?B?QWhiK011UndGdXkwS2xnZFdRR09lYWtlN1ZXa2sraVdjc2ExN0U2TkZWK0pI?=
 =?utf-8?B?NCtSZWY1aFlCbi9WeGozUjltdXVkZllrZzQ5WVhtZFRQbC9sMmdzaDVJMHhM?=
 =?utf-8?B?eVFHTUcwRmk0Wm5KQlhlMUtGU3BaRHVreVFGbmhJUU5Yc0NBNStKMjJ5WjRQ?=
 =?utf-8?B?QmNYZFB3TldSU25Hbi9TWXlMUHR5MmZEMXFacUVwSFhPVElXaEczR2lXbGhC?=
 =?utf-8?B?NGNPbjFaZmprY0RKN29QQm8vcGx5M0VmYjd2VFZ5b21TSUx6amw5M0N1TEVp?=
 =?utf-8?B?WitPL3ptZThBZjVNS0ZkNGJnV21keDAyeFh0Ly9vU2JvVGl0QUUvN0lkWElk?=
 =?utf-8?B?ZWNqbks3SUFybHZSUzJwQ3Z3NDdvaThqY09nZVhGQTAvNUR3azNneGIzd0cw?=
 =?utf-8?B?K2lKbVlSWFBFc2xnRHVFSmxsRFZ2MWNaSWZ0MGhRakFzeWFZRkdZclRiVVNM?=
 =?utf-8?B?aFhtNjM0R1hPY2ZkcHl2c1JwelJsTy9TQjVIQkFoYTgzZUtXazArMnNMNnBN?=
 =?utf-8?B?R3lYeXZJR2VNd3BIWCt4QTdxS0I0Ym1YalhObTRwSWRkUFV1Ti9wRUVqamRv?=
 =?utf-8?B?MG1SUSttb0J1NVNtb3l3ckV0Tm90OFplU3g2VFp5OVZzVXpPaEVnTVdLV01V?=
 =?utf-8?B?STQ1dUF5UVJKWmVGTGxLTnZjdXBkL0JLQUd4ejZDL1JzYTlJdVVncFZjd2pI?=
 =?utf-8?B?Mk5Mc2psS3ZsdTV4U2lML0NCMXJzSGVEdGd5alg0K3VoSWo2Nm1tbC9HbWo2?=
 =?utf-8?B?RCs4V2swWTNUSTRBQnMrRC94LzZseFhwOHVDOTYxb0FCblNPNW1VbGNtTHBz?=
 =?utf-8?B?V0wvSFZ1SVZQUEtBUHc3Mkl5NHVtZnRvZEVkdDB6TGJrRWMwbFBXUm1SYmt6?=
 =?utf-8?B?THhReDJBczNrMEJhREdqUFVlWlA2SW13bG1mbjBPckNjQ0RPNTVEazVRaXRO?=
 =?utf-8?B?elUrSHR4NW5xSEpicEJrMkdTK0RJYzkybkk0a1d4SGllVEJwSkRUMWxHTDJM?=
 =?utf-8?B?VTFxOEYvZVBpeDY2THdLMG5BSTFzUmp4ZnRXd2t5QWY2R3c2ZFV4empycEhl?=
 =?utf-8?B?dlpRb2pRektEOHVrQlB4alRQMElzQkNRaHpGS3RJbjBiVVFCSTQyNGpYNlVG?=
 =?utf-8?B?aWlMTm9SSTl0TWxIRTB0c0VUcmY3YUZocDhZUU1BR1IvcWx2NEIvZE9QUjJo?=
 =?utf-8?B?QzlwYWdUYVVieFlHcUlOVHQ5ck42VTg0WmlMbk5iVC90RmhRN3FaVVZPSmFh?=
 =?utf-8?B?emowVGk1UWFwbU1IalVrbVpXZ0kvUkoxOEhkMG8wRFVXTjNhY3R4TlRiU29y?=
 =?utf-8?B?SkFSZTVJRnpic0Z5NWNPS09URldndkJJb1ZJZm1jMXBCMjV6Mkk4WlhVaTcv?=
 =?utf-8?B?YWFaSld6US83R3lKZ2QwclV3NTg4Z2Fqc212a3RmSk9oeUpjeWcxcW5xYTY0?=
 =?utf-8?B?M2MyM2tleGdLV05DR1VLbnIwdVh5ZHY0RnpIdlF5NzVOdkMxRzh4ODBXR1pJ?=
 =?utf-8?B?VXZBZEVQY0NjNi9CR1BmQjRwL2tEQ0JUekxJN0N4WGYzdm43TnlnMmQwanhv?=
 =?utf-8?B?dHMyUStpTi9NS1NYQ0NPeHdCeElaMjRzTUdCa2hpY0ZZRlc3Nzk5Slk5MG1C?=
 =?utf-8?B?QytPOVcwRnQyNkwxWEVPVm1uemtudnlBUW9LT2t4T3lFSWU5S1IwNlYrZFFB?=
 =?utf-8?B?cU8wVGwxS3lRYU9KZW04Q3VtTW5PdmErNklvV004NnhxTkNTdnhSamI2ZmRG?=
 =?utf-8?B?S1NXK3BXZDd0M1JUZUdac2t3L1FCSUlRM3pEUm1STTllbDlvR3NXaFNqemor?=
 =?utf-8?B?UmorOTBtclIweVd6SnVvdzlLaU5weE5hQ3VYcm9HWjdSWldKNHZudzFDbE5Y?=
 =?utf-8?B?cW5qSWxXVG1aSFVTQVVJWkRiRERFdTVYMnJkbnFPelRKdEZ4WTVSU0p5Z0hm?=
 =?utf-8?B?cFR2OXptNTRlTzF5bFJkaCs3clFCaG95VGVtQ0RPRUtVMitsZy92Z2hsVnZT?=
 =?utf-8?B?SlUvOGpCd3R1cTlXMFhUc1VDU1dOVDVndVJYdUJqekhWeGxpNDZCMHVyVmdT?=
 =?utf-8?B?RmJMVlpiaHFnMzlCRTVvb1VtSThham10c2pqdGo4c1dRVXZJczJBSlZiZzVx?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c12404-8a27-4dd0-0929-08dac202ad15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 03:29:57.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yww7Gx/Rm08tUT1ddkpA4Sd8lFMhEV90MMlMqTVLhNbOF4FxdyE4UWKwelH1Qo5cDWIrhIMsnT6YInHljKa+Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> Existing implementation (broken) of IFS used a header format (for IFS
> test images) which was very similar to microcode format, but didn’t
> accommodate extended signatures. This meant same IFS test image had to
> be duplicated for different steppings and the validation code in the
> driver was only looking at the primary header parameters. Going forward
> IFS test image headers has been tweaked to become fully compatible with
> microcode format.
> 
> Newer IFS test image headers will use  microcode_header_intel->hdrver = 2,
> so as to distinguish it from microcode images and older IFS test images.
> 
> In light of the above, use struct microcode_header_intel directly in
> IFS driver instead of duplicating into a separate ifs_header structure.
> Further use existing microcode_sanity_check() and find_matching_signature()
> directly instead of implementing separate ones within the driver.
> 
> More IFS specific checks will be added subsequently.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
