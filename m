Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10F16C2E22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCUJmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCUJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:42:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912AE41B4F;
        Tue, 21 Mar 2023 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679391742; x=1710927742;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r9qDKw+GZZsTOciu5nb78KASUBkEw3pcGFflo3DvV30=;
  b=MU9YiP9wi8qxbLAQlD16CBGvytyi2IREVq0AXVS1J1KmVS0IRaxS87o7
   hCYhOeOkBD2sbWrQKP0WEtaetrl/F0CK69Qioa8l53eq3MXSQJ/l3CG23
   rlPutTk4Eu69ZmfuU9hTOr8m9XjnSkqVopEHj8CuvbNWJSoCQeJ/cjsCy
   ulW+EYtYO/QISXoJffTRNNYQ9fFy/a5W3mU2Y1i4MgrnYb+GzrSBzpLMd
   YUOBR64ltzF3PHnSAFfSHZU3/YYnU7cct0dtHxRKdDCtIcUZtYZSOzm4z
   3EiVKzcD5dYMKmJG1+xhEZYrvdLVFm6sgCsNqYrIXFjtNe0WxMwmBiZl4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425169865"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="425169865"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 02:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674761907"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="674761907"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 21 Mar 2023 02:42:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 02:42:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 02:42:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 02:42:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 02:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txq7i1NMzDnwuUaDg17cFWNvxvAe9lnFBSUOfTXinAyNelok33J3kNb3IUrY/yLAwFJFJVBiWW6awEjhmvnWa4lVYMaqvGjSTIbXAB7eG65eQSHiznSzQ2avmyMC2WjN4zF3wV716GaT826ZUSmFChPfAsDudtXSHTIROQ+pWxd3fRibDKjjNsSYFg/FXk1Md2uZcUpBuDIvSqt4bngH4092/VUBOGUR4ucc1bGWq0IS0MB4efaZP8vPjvHoN9uoslk0FUVVD5CrTDEDBLtkP952alvtQXN7dvbOtIvtSdbrrjDPplPZ1U1ZUGON4hdYQKf/vL4Uyj3FegrM8KgPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5TG2giR7VbITHnt9s7zj3XTaXNDnB9pwKrOC0YV0qw=;
 b=TYEmR2bgVheK7bUAwmKAlNzHTno8poW7UJ2CNH0YCnMcpCJmokUupNZQ1352HGoWDziSxPcw5ggGHzQE4D2yG7NwOk+MwLZ3wo19JW0zXzMzZ3R/QhDrUAYNlUHNyqXPTl5K4glnneyaxhpkWertUxVIluCcZ2yGa4MYBMXGceFVdD9hlU1DbY7IooFnFZUE//4DgcWfLbZNUg+aOUEdTkENuHnrxPBtEsNv8KrkHEMaF+9lDm1e9ziKeLEYPDmecvcc/U8pLHTqrwxm/xlFxP4ziH5QHf06DJzMq2At0jPnLtY9e+5AhgJXLzdmx8t5jrtLQ1D/8FZLBpbKRpEsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 09:42:16 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 09:42:16 +0000
Message-ID: <c09ed847-d230-0370-3035-86539159b543@intel.com>
Date:   Tue, 21 Mar 2023 17:42:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [smb3] 5efdd9122e: filebench.sum_operations/s -50.0% regression
To:     Steve French <smfrench@gmail.com>
CC:     kernel test robot <yujie.liu@intel.com>,
        Steve French <stfrench@microsoft.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        <linux-kernel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <regressions@lists.linux.dev>
References: <20220826022031.GA76590@inn2.lkp.intel.com>
 <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
 <95e604ff-516a-4f7c-7f2c-8ff3d2cc66fa@intel.com>
 <CAH2r5msk7R4qZ-GQT2mKnCWzZ_MzYPUyJwWXuLRUMtt2XtApoA@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAH2r5msk7R4qZ-GQT2mKnCWzZ_MzYPUyJwWXuLRUMtt2XtApoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 28082641-aa80-481a-00d9-08db29f08e10
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i35R8xC4s/SRpO2aZdDdqBLQJeB+/XStVrad820wxerkrR4hlm3/+MN2I09ZOcPuYXMNuDR6nYKKvscVExwmjAqO0IWbOZaRNUj4zN4uXQVKKhizcGcm23l46JPQiXze1uFnQYhGo+52uZ0reW6m0Kjkt2gM0Qv6wTK5UcB21E4GDuDVClia6N1BGKWH4v3qjtsBIgxZCkts2u2UQ9RAuMTjmkMFsnlB67zuZBDftF418XGmHRrpdJb4fYfOQObpKgeBQqjgdLhrq2ulBhfC6WBzkUCrvoLKpx2b1ytQyq9QovWtzxGmgpWqmtkH+t6vmEzOmfcGSn1I8Qxf1/FkZUK4Z67nkxafwsiq32d+uhx46irslE36N6EJCgZiGb63OyCTWLOZoGbSDT+u3IXDww6p4VM2nCF+pBmJ+t0WXmrl7t2qWdoeG5PqVg6PISiSvfulpXEHWBPp1mwMhRiwuPKJh5HOihwBM0tPvogtQ7NOpexQ2+DsDL0qVljjYG2KGb1mV2IAKtBjrBjok0CVVnL1eBQXleJESWkgd0nClmY1NIiNBbYrXvR+j5onpqbRfWHGKEybSh+8WVSbOZsFR5Xx+CJ+xFXLgZRv4WGJY9i39OGNFkm0k9J0Xm730Ia5F1YkJHEyGwJ3AQZJzDQW9tnFyR1blMLLaJtvuIXfOxkQC7fi4ouOo+pd4fU1EaCajA3crAS79kmGKTA8PzrFFdJ/6TL5QIoA2kV0xtSY6dB435ZeL7tJqxmSfQ5Wp8NMRmovO7acfQcQQOXRSMCCPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(8936002)(5660300002)(7416002)(30864003)(41300700001)(86362001)(31696002)(36756003)(38100700002)(2906002)(82960400001)(4326008)(966005)(6486002)(478600001)(83380400001)(6666004)(2616005)(186003)(53546011)(6506007)(6512007)(26005)(31686004)(54906003)(66476007)(316002)(66946007)(8676002)(66556008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1pKeFdNaVBVK3g5ZE83M1JYMkJpc3NuMW8xdkFKTlJNVkNUdmpXZFFnejVK?=
 =?utf-8?B?RUd6YnU0UE1YdEJOQ2lPek1XRmdPMitGUzBPM0U4VEtxWndyWWJXdVFGMnA3?=
 =?utf-8?B?ZG9FWUlMMklJUlZZYk96dDBlWnFXc2RjeWxqcHB2ODZJb2E3MVhibFB2aDVa?=
 =?utf-8?B?TUpWWm14NEpoZ2F2Sm5ML2FXWEx0YVEzVVh0NjJuSWJzNEtRTUlFOTE3YnIr?=
 =?utf-8?B?di91aVNEY2lqYk9FMllYVllxK2RCQ2xmY3AvQjhTTUdjWTZWeFlENHRvTU1k?=
 =?utf-8?B?RXVVVHI5V1lVSzhDZ1VJM25nQlRobWxWRUFiV2FuVkUrU1JTU1lwTFE3Tnpx?=
 =?utf-8?B?MmgrcWtLWTk3b3FFNG5YZlIrNm9lUFR4b3U1ejQyZFZNNHJCWWFvWFY2SGlz?=
 =?utf-8?B?SlFSejRaeDVMd0d3aUw5THg5TmFGcm5zLzd5ZCtVbEN3bWdJSDg3NkxRVkR1?=
 =?utf-8?B?ZU05TE9NMWdtbUNNUDJQTURkRVprc29lZG1PTS9TZUNlYmp2WW5vYzFXNDVS?=
 =?utf-8?B?YXo1Wi9lOERrMUZuM3A1eUdmN2E0Sm9UVTRrSGxPTE1Kd295Q0ZqRWs2Y1lG?=
 =?utf-8?B?NXVzMU9lZmhVbk5zbllYZDIrUm0ramg5QzBIYXJHUGlCR29vVE5JQ2U1MkJ4?=
 =?utf-8?B?NmxPTnF5MDhJTDd6c0F1NExtVVBGeGVYUENQTUtNckdkT21hWnU4eUVvdkFr?=
 =?utf-8?B?TExZdkg3TCtFZGM1YS9JbTRrU0pPa2FtMFFrZ2FCQ3kzZHFqTUl1V3FBZGtl?=
 =?utf-8?B?WGJpS2V3cTVDNXNuZDNXNE1tOWRqMnZ0MDE5M3hjMjdZOXljU1pGWVk3UkZy?=
 =?utf-8?B?N1ltQ0xjUHMvTllKQmxhZkJWTFE5WWdWTzU0MEI0clkrKy9FUnl4Q2c4QWR0?=
 =?utf-8?B?eFJleVZRUDFNdDhMcURMVFNzVUttWWRPWHJ6SFNSL3pucU52ZzlKVSt4S1Nm?=
 =?utf-8?B?bkRodnhqWGdZN2laWHdsRmVCV3VwTW9DVkdaaXh0UjRnK2U0R3UxK0NwQk1M?=
 =?utf-8?B?T1JZcDlSR1h2RlVnYnRaanNCVElnMUk3RGdWRGdhMS9PS2oxSi9hRmhJeDky?=
 =?utf-8?B?cjVGZFdaVENTbzlYNkpNQVZFSXRTYXBXNkkzVmxGM1hZV0puSlBod2dJbnlU?=
 =?utf-8?B?ZGRzWkRuaW5RaVlqTFg0VVErZUdpMmRwcGYrUmpZVzZoRXdKRlNMbnZMeUF5?=
 =?utf-8?B?eGE0SW9qTEp3b3ZjR3JjejJlUWllTVF4T283Q2pVYjF2Q1hoNkN3d2dQaW42?=
 =?utf-8?B?eGwxQmhPWG43N0pYdDlCblhYekREb0FVakR4UnBrNWlqbzhOQU9lTGc3c1Qv?=
 =?utf-8?B?SHpRakoxY1F5RVpHK3NseXdUd2FWbG1VSlNYLzB3VmFuL3ZmU3NXdGROTXo1?=
 =?utf-8?B?amY0SnkzRGhuYWJ2NktVYXFnZ0NockZBUndvNmo4RmlFNEYrcHJudE9VZU80?=
 =?utf-8?B?ejArWWZwUklVWUh5MUQxdXRSUU0zSlVDemlXaVZlSll0blpkQ1NZRjdUL216?=
 =?utf-8?B?U1NhQ2U4c2hGUGU4T1RacHNXQ3RYNmdvNHg0VmVQM2pDbG40ZjNJK1poTnZi?=
 =?utf-8?B?NDJFUXFrNk5SQldKUURoZFBHR2IvNFBFTTg4UFBUSy9PYmhma1V4QzJEbE5p?=
 =?utf-8?B?cTZWaUlFaE8vYy8rRlJqRTA5U0ZHRVVPWDB1OGRlZXhXSnJuaDFzUTRyTVdC?=
 =?utf-8?B?eFpnWWJjTnowdVYwVWdxQTNUc3B1NVlubXQ0YlBPVDVzYlgzSWp1L2JQc0l5?=
 =?utf-8?B?QmRBT0pFWFI5RHAzTzhHTGhyMXUzZ3RESXNmaDBVUkpBbEF1cGd3Z2xiaDVl?=
 =?utf-8?B?VURKQUoyNWx1S1k3RnN6UCt4SkRZdVNhZXB0RWYxVXBHVGJYbHFqYkMxeHZO?=
 =?utf-8?B?NEwyN05lZy9LLy9rZlcybnprQ3RRWkZyd2g3WE9JQlVTb1Z0UzhrOHd3MDFC?=
 =?utf-8?B?akpiemxkQ1hxSk9FN0VWcW9URVd2VU1nNVBpOG5OTWFjV3lFbGVWNURwblZW?=
 =?utf-8?B?d1QwRFFFdVFjQmp3aTdXQmVlYUlLN09iaXFUZWplRVl5bkg3eEpHOVlqSGJo?=
 =?utf-8?B?SjJqQnA1bUNYbjJrdGp3QWIyZTdiZDR2UHJ1SzFWblRsTFYrSkJ5V0xGaUw4?=
 =?utf-8?Q?ugeBc0/OOku+7GkZh0JCwxsGR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28082641-aa80-481a-00d9-08db29f08e10
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 09:42:15.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2euLgKUIzT67xXuXuTsUyJg3mw6eEi/oVi9+bCFpwwO7EGPyRFgju+ZhGXugHam/wR2MU9AQ91c2KEEMJfRhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2023 10:26 PM, Steve French wrote:
> Can you verify what this perf looks like with "closetime=0" and "closetime=1"
for commit 5efdd9122eff772eae2feae9f0fc0ec02d4846a3, if the closetimeo=0 or
closetimeo=1 is used when mount cifs, the regression is gone.

> 
> Are there differences in /proc/fs/cifs/Stats when you run the same
> steps with "closetimeo=1" vs. the more recent default (5 seconds)?
I am still trying to figure out how to dump this file in our automation system.
I will send out the data once I get it work. Thanks.


Regards
Yin, Fengwei

> 
> On Wed, Mar 15, 2023 at 2:46 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 8/26/2022 10:41 AM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -50.0% regression of filebench.sum_operations/s due to commit:
>>>
>>>
>>> commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3 ("smb3: allow deferred close timeout to be configurable")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: filebench
>>> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
>>> with following parameters:
>>>
>>>     disk: 1HDD
>>>     fs: ext4
>>>     fs2: cifs
>>>     test: filemicro_delete.f
>>>     cpufreq_governor: performance
>>>     ucode: 0x5003302
>> Please note, we still could see this regresion on v6.3-rc2. And the regression is related with
>> the commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3. This commit changed the default timeout
>> value from 1s to 5s. If change the timeout back to 1s as following:
>>
>> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
>> index 6d13f8207e96..6b930fb0c4bd 100644
>> --- a/fs/cifs/fs_context.c
>> +++ b/fs/cifs/fs_context.c
>> @@ -1537,7 +1537,7 @@ int smb3_init_fs_context(struct fs_context *fc)
>>
>>         ctx->acregmax = CIFS_DEF_ACTIMEO;
>>         ctx->acdirmax = CIFS_DEF_ACTIMEO;
>> -       ctx->closetimeo = SMB3_DEF_DCLOSETIMEO;
>> +       ctx->closetimeo = CIFS_DEF_ACTIMEO;
>>
>>         /* Most clients set timeout to 0, allows server to use its default */
>>         ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */
>>
>> The regression is gone:
>> dcb45fd7f501f864                    v6.3-rc2 32715af441411a5a266606be08f
>> ---------------- --------------------------- ---------------------------
>>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>>            |             |             |             |             |
>>            :25           0%            :3           33%           1:3     last_state.booting
>>            :25           0%            :3           33%           1:3     last_state.is_incomplete_run
>>          %stddev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \
>>     515.95           -50.0%     257.98            -0.0%     515.92        filebench.sum_operations/s
>>       5.04 ±  7%    +833.7%      47.09 ±  2%      -2.9%       4.90 ±  2%  filebench.sum_time_ms/op
>>      10438          -100.0%       0.33 ±141%    -100.0%       0.50 ±100%  filebench.time.major_page_faults
>>     167575            -4.1%     160660            -4.4%     160140        filebench.time.maximum_resident_set_size
>>       7138 ± 11%    +141.4%      17235 ±  3%    +147.6%      17677        filebench.time.minor_page_faults
>>      28.68 ±  9%    +199.9%      86.00 ±  7%      -2.4%      28.00        filebench.time.percent_of_cpu_this_job_got
>>    2453485 ± 54%     -63.0%     907380           -66.2%     830273 ±  6%  cpuidle..usage
>>       0.61 ± 38%      +0.8        1.41 ±  3%      +0.2        0.80 ±  4%  mpstat.cpu.all.sys%
>>     142984 ± 13%     -45.6%      77725           -47.5%      75106        vmstat.system.in
>>      34.23 ±  7%     +27.9%      43.79           +27.8%      43.74        boot-time.boot
>>      17.09 ± 11%     +66.0%      28.38           +65.5%      28.28        boot-time.dhcp
>>       2661 ±  7%     +37.5%       3659           +37.2%       3651        boot-time.idle
>>     104737 ±185%     -87.8%      12762 ± 10%     -89.8%      10631 ±  4%  turbostat.C1
>>
>>
>> 32715af441411a5a266606be08f is v6.3-rc2 with the change to restore the timeout to 1s. Thanks.
>>
>> Regards
>> Yin, Fengwei
>>
>>
>>>
>>>
>>> =========================================================================================
>>> compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase/ucode:
>>>   gcc-11/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/filemicro_delete.f/filebench/0x5003302
>>>
>>> commit:
>>>   dcb45fd7f5 ("cifs: Do not use tcon->cfid directly, use the cfid we get from open_cached_dir")
>>>   5efdd9122e ("smb3: allow deferred close timeout to be configurable")
>>>
>>> dcb45fd7f501f864 5efdd9122eff772eae2feae9f0f
>>> ---------------- ---------------------------
>>>          %stddev     %change         %stddev
>>>              \          |                \
>>>     515.95           -50.0%     257.98        filebench.sum_operations/s
>>>       4.81 ±  2%   +1038.4%      54.78 ±  6%  filebench.sum_time_ms/op
>>>      29.00 ±  8%    +212.1%      90.50 ±  3%  filebench.time.percent_of_cpu_this_job_got
>>>      24629            +2.7%      25297        filebench.time.voluntary_context_switches
>>>  7.685e+08           +19.3%  9.169e+08 ±  4%  cpuidle..time
>>>       2.53 ±  6%     -20.6%       2.00 ±  3%  iostat.cpu.iowait
>>>    1506141 ±  8%     +22.4%    1843256 ±  3%  turbostat.IRQ
>>>       2.00           -50.0%       1.00        vmstat.procs.b
>>>      21969 ±  2%      -9.5%      19885 ±  2%  vmstat.system.cs
>>>       3.06 ±  7%      -0.7        2.35 ±  4%  mpstat.cpu.all.iowait%
>>>       0.79 ±  5%      +0.5        1.27 ±  2%  mpstat.cpu.all.sys%
>>>       0.89 ±  3%      -0.1        0.79 ±  3%  mpstat.cpu.all.usr%
>>>      34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>>>     119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>>>      34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.util_avg.avg
>>>     119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>>>       5249           +15.8%       6076        meminfo.Active
>>>       3866 ±  2%     +17.7%       4552        meminfo.Active(anon)
>>>       1382 ±  4%     +10.3%       1524 ±  4%  meminfo.Active(file)
>>>      69791 ± 14%     +39.8%      97553 ±  6%  meminfo.AnonHugePages
>>>      72709 ±  2%     +12.5%      81779 ±  3%  meminfo.Inactive(file)
>>>      23219           +13.5%      26352 ±  3%  meminfo.KernelStack
>>>     966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_active_anon
>>>      74302            +6.3%      78977 ±  2%  proc-vmstat.nr_anon_pages
>>>      81133            +6.0%      85973        proc-vmstat.nr_inactive_anon
>>>      18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_inactive_file
>>>      23213           +13.5%      26348 ±  3%  proc-vmstat.nr_kernel_stack
>>>      17983            +2.3%      18400        proc-vmstat.nr_mapped
>>>       7446 ±  2%      +5.5%       7853 ±  3%  proc-vmstat.nr_shmem
>>>      26888            +1.6%      27306        proc-vmstat.nr_slab_reclaimable
>>>      47220            +3.4%      48803        proc-vmstat.nr_slab_unreclaimable
>>>     966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_zone_active_anon
>>>      81133            +6.0%      85973        proc-vmstat.nr_zone_inactive_anon
>>>      18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_zone_inactive_file
>>>     361460            +2.5%     370454        proc-vmstat.numa_hit
>>>     946.67           +18.6%       1122        proc-vmstat.pgactivate
>>>     361562            +2.5%     370553        proc-vmstat.pgalloc_normal
>>>     187906            +4.7%     196761        proc-vmstat.pgfault
>>>       8189            +2.5%       8395        proc-vmstat.pgreuse
>>>  1.097e+09           +15.5%  1.267e+09 ±  7%  perf-stat.i.branch-instructions
>>>   39079265 ±  6%     -20.9%   30915354 ±  4%  perf-stat.i.branch-misses
>>>    5093263 ±  4%     -23.7%    3884752 ±  9%  perf-stat.i.cache-misses
>>>      29213           -18.7%      23764 ±  5%  perf-stat.i.context-switches
>>>  7.666e+09 ±  4%      +5.7%  8.106e+09 ±  2%  perf-stat.i.cpu-cycles
>>>       1877 ± 15%     +75.1%       3287 ± 12%  perf-stat.i.cycles-between-cache-misses
>>>    1735450 ±  3%     -12.9%    1512060 ±  3%  perf-stat.i.iTLB-load-misses
>>>       2898 ±  3%     +34.4%       3895 ±  7%  perf-stat.i.instructions-per-iTLB-miss
>>>       1493           -20.3%       1190 ±  7%  perf-stat.i.major-faults
>>>       0.09 ±  3%      +5.8%       0.09 ±  2%  perf-stat.i.metric.GHz
>>>      48.47 ± 11%      +8.4       56.83 ±  7%  perf-stat.i.node-store-miss-rate%
>>>     283426 ±  4%     -21.6%     222190 ± 10%  perf-stat.i.node-stores
>>>       3.57 ±  7%      -1.1        2.44 ±  6%  perf-stat.overall.branch-miss-rate%
>>>       1508 ±  3%     +39.8%       2108 ±  9%  perf-stat.overall.cycles-between-cache-misses
>>>       3022 ±  3%     +23.6%       3736 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
>>>  9.585e+08           +18.8%  1.138e+09 ±  6%  perf-stat.ps.branch-instructions
>>>   34151514 ±  6%     -18.8%   27725316 ±  4%  perf-stat.ps.branch-misses
>>>    4450329 ±  5%     -21.7%    3486409 ±  9%  perf-stat.ps.cache-misses
>>>      25524           -16.4%      21333 ±  4%  perf-stat.ps.context-switches
>>>      77139            +2.5%      79105        perf-stat.ps.cpu-clock
>>>  6.704e+09 ±  4%      +8.7%  7.287e+09        perf-stat.ps.cpu-cycles
>>>   1.06e+09           +11.3%   1.18e+09 ±  5%  perf-stat.ps.dTLB-loads
>>>    1517349 ±  3%     -10.5%    1357716 ±  2%  perf-stat.ps.iTLB-load-misses
>>>  4.582e+09           +10.8%  5.075e+09 ±  6%  perf-stat.ps.instructions
>>>       1296           -18.1%       1061 ±  6%  perf-stat.ps.major-faults
>>>     247613 ±  4%     -19.5%     199283 ±  9%  perf-stat.ps.node-stores
>>>      77139            +2.5%      79105        perf-stat.ps.task-clock
>>>  3.697e+10           +35.3%  5.003e+10        perf-stat.total.instructions
>>>       8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.calltrace.cycles-pp.getdents64
>>>       8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>       6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>>>       6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>>>       6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.open64
>>>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
>>>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>       6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>       6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>>>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>>>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>>>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>>>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>>>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
>>>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push
>>>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
>>>       3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
>>>       3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
>>>       3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
>>>       3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>>>       8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.children.cycles-pp.getdents64
>>>       8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>>>       8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>>>       8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>>>       6.25 ±107%      -6.2        0.00        perf-profile.children.cycles-pp.open64
>>>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.__x64_sys_getdents64
>>>       7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.iterate_dir
>>>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>>>       6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.get_signal
>>>       4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.children.cycles-pp.perf_mmap__read_head
>>>       3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_vmas
>>>       3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_page_range
>>>       3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pmd_range
>>>       3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pte_range
>>>       8.54 ± 43%      +8.6       17.19 ± 38%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <yujie.liu@intel.com>
>>>
>>>
>>> To reproduce:
>>>
>>>         git clone https://github.com/intel/lkp-tests.git
>>>         cd lkp-tests
>>>         sudo bin/lkp install job.yaml           # job file is attached in this email
>>>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>>         sudo bin/lkp run generated-yaml-file
>>>
>>>         # if come across any failure that blocks the test,
>>>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>>>
>>>
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are provided
>>> for informational purposes only. Any difference in system hardware or software
>>> design or configuration may affect actual performance.
>>>
>>>
>>> #regzbot introduced: 5efdd9122e
>>>
>>>
> 
> 
> 
