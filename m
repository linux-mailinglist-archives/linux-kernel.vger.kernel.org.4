Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAB46237A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiKIXqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIXqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:46:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5961654B;
        Wed,  9 Nov 2022 15:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668037576; x=1699573576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Eyfc7lNbfX6ZpOZ36o+i78IEYwlUYcvf+3iSnYSrrpU=;
  b=dJf9nLXXg9QxnuO/o8gLveeWH4hGsKCYQPK9WealNAYMTdgayzHzRqBu
   XoSzyHk0gf3GC5Y8S9TWrR9pNXIrmA2RGuUA9u5QNwwgDh4TLjawf2Ph8
   QFGCyWAN216srJSjwqgYDpKAdpcp8K/cE3N86V/JJuPABsCftjSWzJvTN
   nqIV3hojGzudHvoHkl25B9nJv1zZ94Z7hW4ycipfExPUQ2cNx7qPe0Qyy
   khgPiQZ+KSyr8eVXbq8uJeDg3usnp83WQIDp9qVtrDqAU6bCXrDMvHxJ2
   2oPy4u7u4T4kE2Sn20VDVlfxR+GFdBXTQeCjuKa9zRcF+sZ52zhP28QgQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312923081"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="312923081"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 15:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="700567382"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="700567382"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2022 15:46:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:46:15 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:46:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 15:46:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 15:46:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0LRZoJZzB6RyCntUWUM6s2twc9vkoJJ9hYpL9NRS5DvE5NBMi5dtEyiSozWida3JkI5Heub8SKued+r4r8eFKeFBMmfzclMcBf+3eOh5VU6Q7XSZEUJN6dOraEiZ2/q8Vyb3nBEAmEZ40VvvtLXfcJAJCW2fhcbKN5w85PNp+AfiWtrs8AFT7fspfCnAlnqgUtk6RHZzKj7kYgRo/2N5dn3cZ5ONTb4BegVFwu5Np9tegACZwA4GjFNXy+9rIGjMsxcukICxZ77NRiucxHweVWjns27XWYCq+O2QV+fx53emxw+F7Jtbz7pPDD+U63W5oDPo6+xJ3Wrd2uryrpsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOq6UJREX5Wg4kI63Qe7uGZhSOARzO4JUlyx9Mfev84=;
 b=NDrUOBVL7D/8MOHSaKl4L1+6CxCMzqO/UkX67JMBBJ6OPCocp8prtYWJOz+Hfds1GhbtK6XIV8OsUtghLvAKU7aMgClGNCwNQQGTEvFQ+0S0cVTKNbiQT+AiErkapFXbhoTM2absiRBXZW2MMa3Fq79jyGMq4rWePRawXZB7JPtzENnhwNvotODH1Y+0CgG+qawfug1rMiILO2sfCL3VsZufS1CQIcwjrrG87em6wJMfgyjeiJfxA6hmr0WPszrGYjvbhHjjZatQUlOLOhj7BD8j7HH27HdJVmDoXIxIQ8SkdyfptQkz6PEiEd+WzyCoWpTkmGB3EPKG3W1Pnci9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MN0PR11MB6230.namprd11.prod.outlook.com (2603:10b6:208:3c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 23:46:09 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 23:46:09 +0000
Message-ID: <1826887b-dfad-30a2-16dd-412e5556cc84@intel.com>
Date:   Wed, 9 Nov 2022 15:46:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
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
 <20221107225323.2733518-13-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-13-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:a03:167::39) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MN0PR11MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1cbf56-a03e-4b6b-731b-08dac2ac938a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2K8GmWx/H1y07s0ZSRdL1G525jj6k8rJnfSGNaJ1a5l9tOdMKxG/15MrIWCqH0VO3myFPdr/oVso636f1Lki/gO3QAFHUgNnmq/Fr7eyfLAyOBurCN/TWoTRBldGhQFuVn/4ZiTybqNT/5RhaNe0LRj5O9VkVW672S2O3T0Cb/5y73dEI/8BBFCeWEZpf51ZGvK/LbvlGBM8S4uMtaQltQr8+a6n1VqAV8To/899t9NPQ+8KOCkrhviXIVdGh8x3JjLL7szdJGki0sSXUdOCAudmFji84r7A5BPAGGf6IGCHBYuHJ8qVYRVQnVJfBESPa3aXVTza5ctmnceq7vPvzF8ObD2m6PWufWGBhj+KvJlIjYNGjb8WBoQFiQHdsHjPUx2zs/WbAice+q50CBrnG9onoBmFS1w2XJ2pi44vN9d8q2nq4gawi3iNTqVx8knkDbSnpWz084lfEDshcz4EzmLvy72DX6jHvK+NGVyFl5/eu37lLZwEzc08gkS+yZRro9fnyEatb5DIFLlV6vMOzwkVeAkG8Va2RGhtG5FuA2KgoUtLPgb6aa45OViLZnykFJEmi+5FK4CA0+S3qSARJ5mPhd+d0qVEzy2bi2ldQpp/Jn4z7j2gelsYQxGqiJF002bxZhsm9R8wrP3EsQDpwnqTaZIlErnEk0Jo5uIEGhNnVmgo/tvhLkJ2NKvcvYAa6jiWelb9nqtBVPXcyk1Dl8VrBGimKIabVqu1DPln18Hc7X1b7ktOflx6VA1eFYV6e6U2qLTzwvN9FsZKJX4CTiEG039OF1NMLqVmKToGKIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(31696002)(66476007)(66946007)(26005)(4326008)(66556008)(6512007)(8676002)(41300700001)(186003)(2616005)(478600001)(7416002)(5660300002)(8936002)(53546011)(6486002)(44832011)(6506007)(36756003)(83380400001)(38100700002)(86362001)(316002)(82960400001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1qU0VoZVFYcEZQam5icjc3b3ZLZHlmUWFSV3F4VWNrZTMvNFpyZEJ1cU5Q?=
 =?utf-8?B?d3A1ZU5PMVh3Z3dab3FTQmEyNStsZTJoYUNneUNIdENRM1E1WFhqNFJLWjFm?=
 =?utf-8?B?TmRzNzBGS21idGYrNzlzZVgvSzdnR0o3Wm5aS1MvbUdEekF2VUtYdGxZVVRp?=
 =?utf-8?B?Y3dya2N3SWxnR2QyRGlFMlVySTJ2MWV3dXBXWEN3b29pMEg1a1d6VWJZWlRG?=
 =?utf-8?B?VEkzSlBBV215NlYyMUptaDhNM1RyVU1xQ3BxU3ljWWpoSHZpR0pvR3UrMWNQ?=
 =?utf-8?B?blNQeURxR1VnYnZZQ3k0cjdXbXk2WHo2aWZmZDBZQlZYcGpCc2VONU42amNW?=
 =?utf-8?B?T2JuL1lKdGF6NU93bXZndzNIdWYxVVZUL3ZIRk5DSmZXMzdvUTlsaENQenF2?=
 =?utf-8?B?b2ZNZFVONnRMSXUxdnpqeE0wM1hIcXZWR3F1SnBaWHMzS2xpeXVkdGE1WVV5?=
 =?utf-8?B?NktjRGUzWnhudWFBKytyZUE1THNvNFRFTVJ5U3VoNFBtaVhvOWxCYnFpWWRM?=
 =?utf-8?B?L0E0aUNiZXJEa2lUN0J2WDd6TkhuQmd5WSswMmlJUlJFeGFzWmU5eWhLMmtx?=
 =?utf-8?B?Q2lyT2IzT1Y3YWxveWZQNEovNmdlb2RBY0drZjAzeUVoem42SHRySzFRWXlX?=
 =?utf-8?B?eE5FV3BQVmRUWFQrZXBtTU5kZXkxck5lYXh3TURrZkc5TzB4QmlWZGdZWk5z?=
 =?utf-8?B?cXp4SEQyeWpHUzYwb3FJcGh5Z2JEbXN1c3ZiNTQ0cnlJSnpFYVp3RGhMbVM5?=
 =?utf-8?B?SkdUZVdQeWNKL3hTMDZYam5oNEpsZGMzM2NBTlplV1BKdEtPV0FzS2h5OEl5?=
 =?utf-8?B?TTJ0NDhBMFNBVDI5R21RMVNyRjZteEpIbWp5TXlQNzJJWCsrRmJ3TjA3ZnBG?=
 =?utf-8?B?bXJicHYwZFZrNDhOeEZZYjZBQ2JuOW1ucHVkWXJwUjJMcCs0QlE4TlJaa3FD?=
 =?utf-8?B?L1QxdHpmOHdHUXJJRkJrSHEwRXVxYkpGdnRiMFZEdE8xenFucUtVSEg5Qjds?=
 =?utf-8?B?SzNDSjloTEhROHlsaDVFQVZHY1FuSmZ6dHo5UTl0WnpORGVhL01lNXdhRWZo?=
 =?utf-8?B?bWxnemt0VVdIYkFuQkNkeDcrOGRkcnNIK01BaGtNcnpmYjFySS9EZzA4L29v?=
 =?utf-8?B?Sm8ybWtpZVRNMzFpVkpqTnAxeDF6Yk1ORGdvemsvODlWTmJ6U0d0ZHVXUHdF?=
 =?utf-8?B?R1J5VXhDd01DTmNCYm5FaUVDRXVEVlVyS0gvem9nbmRuYmNBdWtRNE1VM1Fx?=
 =?utf-8?B?YTNjZS9SL3pmOXJOZFUzVFF3aW5Qd1V3WDUvaVB0Z2p1dWNCWjNoNUlZN2hN?=
 =?utf-8?B?NlNCNUNRYSsxUXNVYlJVZGZsZ1FwYTJMSCtaL2hXaHJvVXg2K0hmWncxY25G?=
 =?utf-8?B?cmRrTW5uSWo3ckZKUHptR2RhV1k3dDFoeEN0bTIyNHBqM2syVDNvWWJOaHk4?=
 =?utf-8?B?MHBHQWVTcnFtM1VHeUJNTlFWcFNmMlRqYm5HUHZDWHZtZEZRYU5XUWEzTjJN?=
 =?utf-8?B?U2NmYm5zcW0waEJXdXdjVjd1SzUvbk1PM2wrcjN4Z1d5VXlGQXVwTHJockRv?=
 =?utf-8?B?aGdpOHV6bVdXcG5pV2dkSisxUm9hR1hERDAwNVdnc054NkhqeFRTM0tXbHdW?=
 =?utf-8?B?UjFlMmF4ejlsd3cxVitxVVNTZkE1UUNJZ1dRd2U2cjd6VnhINDNwUDhDb0FW?=
 =?utf-8?B?dzM2MmFOdE53TG9lU0RyQ2NJVHdZVnZ0ZUlkKy9EZXQ3d3pubnFFR25EdWcw?=
 =?utf-8?B?TjF5T2NDL0E1dmJKTDlMN2NkdHNNMDRhTWNYT2NINHhITUtzWWNWTWlMOVB3?=
 =?utf-8?B?UFRFZDBrZXcyK1ppR0REcXlIOXd4SXNqVzNJck9peUpwdmh6b2VLYnRkdTJv?=
 =?utf-8?B?SEZSOEY4S2F1VlE3dzFUNGNRUk9qTkIvaFhNVFZ3ZHhvZElaZ2dyaURSOC9t?=
 =?utf-8?B?MmVsM1lWZEdIQytBMEFLWVBtZVpXWU5LU3c3SHdlUjJlTVhMN0Q1ZmtaRThW?=
 =?utf-8?B?Q29RaTNzS1lDL0Nya2tTQlJJZWE1bnVzdTJVcmdDQlRXTmdNc2Y5Q3VWazJW?=
 =?utf-8?B?SEFGN2ZrSUhNdzlHazNmT242aW5ORFVJUnFYZTFweUI0cHZkMVlCM043WmRU?=
 =?utf-8?B?Sk1GZHJKYkFtcnlYdXZTRXAzQWZGWmZMU2l5S1k0YnpyM0VCeHBGTmVRNTZ3?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1cbf56-a03e-4b6b-731b-08dac2ac938a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 23:46:09.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZOsvq53ORa5MCl4iP+SwlspfnF8ot3h6S/HFu2Ntu+QBsZQGDfeRBYeRcVY+1w0Jle2DfPHUnwESCHKapGdQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6230
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
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>   drivers/platform/x86/intel/ifs/ifs.h     | 23 ++++++++++----
>   drivers/platform/x86/intel/ifs/core.c    |  1 +
>   drivers/platform/x86/intel/ifs/load.c    | 18 +++++++----
>   drivers/platform/x86/intel/ifs/runtest.c | 10 ++++---
>   drivers/platform/x86/intel/ifs/sysfs.c   | 38 ++++++++++++++++++++++++
>   5 files changed, 74 insertions(+), 16 deletions(-)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

A Nit below.

> +static ssize_t current_batch_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	int cur_batch;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &cur_batch);

Should this be kstrtoint() since cur_batch is defined as int? Or maybe 
it might be better to define cur_batch as unsigned int to avoid the 
negative input?

> +	if (rc < 0 || cur_batch > 0xff)
> +		return -EINVAL;
> +
> +	if (down_interruptible(&ifs_sem))
> +		return -EINTR;
> +
> +	ifsd->cur_batch = cur_batch;
> +


Sohil
