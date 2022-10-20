Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9EF606875
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJTSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJTSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:52:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9AD198441
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666291958; x=1697827958;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=onhjjxRevk7EATVvTQthZ1sbwDRH98Ux/UKzlaPEIHQ=;
  b=PzUUtjbI/+O1QaeInXPchWk22bXgmkdaEglxcYVwavlxd7gw+RKjQFQU
   S918fGvLqu72iJ16CHqi7NCEzQekQ1apGmO8EL+fV8psElmD/nIQzIIBz
   OG+H5juRWdMMpl3NpfXW3rgioJSKamUriGTJldEqT3iQTf8Jfwdc8TB/t
   b+jIndLCIOzB70AbHkKTV6SNL5HtJGPeBuJC+QqDGzfJoP+mFrlIuMclq
   PIzauI0zSufVFCoSPw6L1a0XwDgzmKzmpq/OBP0oJ2F2Jz1mVlSwAczCo
   8nouLET1hbGaC1a9mT7yPwqVSiO48HPRan+jXOABo6PFuF51ZnFPc4QH0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306801955"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="306801955"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 11:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="755324771"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="755324771"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2022 11:52:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 11:52:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 11:52:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 11:52:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 11:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnEbfPPdWoD5ACgBAsHfNYWagEI/OVUAtzZp4KYLwOqI49fk3NqkKVdt+7nBk1aCNEsHsUSA/gsK0Oi+8Fhtds/+BP0a2d3Muto7QIxGSv7HnIDTlEaOmtu0OMBtsz38kJXCik5A3iG5WNSv+roDBSZs7YCa7gCaVvzWDFVJZKZUvkVwkRW8q/w0dn1rG0JWG1ADo25m1uKy1qVaKvaHPmqCZkj88FxFjklxtSOuhnjBw84lHMSYELI2LEotFKZ8+WDlCstt11sKdxMSQ2Jvm+XcGpYNkx6z7evf2McrMCxX2mgtphhKsOBvvC1UgoTxgPycIXuMUDnCWdJWJAxHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o66YCOomvD9h1uz0k/U06mHYeZoeQxa5VB59c39/hLY=;
 b=dIy8Lz3FwSi/O6xnwPs/GkiAxwPA/53pEIbREb7Ks0d9iWWrgUV8OnXjkNZV0cbjhwQJ6ekt2fHUYlrBt4w5C48oQT/IYvQDx5vVCxr4K2cpeIRww/04Hbr/HZCsAS4YvzCl2ZP1QcxveXTep9vbWrTeT57Av0Nucchlh8pORntSD6JI2cO08LWRPOL2mf+Mo9+6FUJnJKYMGx6o0/dUd9obBYpVSL0hnyIXI++iOHy8lV0ub8QwgrtA27uHmayQ+sdNmph5Alm/SNEglguxwRE2yV5l2dnaeSHj31/nbkjrPd3XLo7azL04mzxCDhYtKaTIAAR6H9OyozL825dkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Thu, 20 Oct
 2022 18:52:28 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 18:52:28 +0000
Message-ID: <8cc1bd3c-3b6e-6c3c-31e6-f39206013e67@intel.com>
Date:   Thu, 20 Oct 2022 11:52:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/1] x86/fpu: Fix copy_xstate_to_uabi() to copy init
 states correctly
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <yuan.yao@intel.com>
References: <20220824191223.1248-1-chang.seok.bae@intel.com>
 <20221018221349.4196-1-chang.seok.bae@intel.com>
 <20221018221349.4196-2-chang.seok.bae@intel.com>
 <f086b776-75ad-47b1-e87a-7fb07c1cee3b@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <f086b776-75ad-47b1-e87a-7fb07c1cee3b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CY8PR11MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: f68bd54f-55f5-4f52-598d-08dab2cc3c4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zI+P+b7l3zgTC94sWr+rWSpD4h7LHRbg3+6K+tT5MWyTWezHRvBnMZbPhDahQrK0JnDf772+99avQDSvDKpvYFXnkMdUwIcP1lbh3ry6tfSxcHigqBF18rbT3uceLN8UBA8X8XiYFkdbnl/AVpejpx0fs9HP7QJGAIfntucvl80c1RW1whH0BmiHOjppqGSwl92RD3RZbLqsf9BOw9cLwvt8Ef8GRbXtH6rCw9jpkVbrC56OullPezJp9VtKRFE5dKudW4QdNvimSwZ3+7MuI3zOH8TS/brZemz9MRXEFz73xXCGuo0KNMuJ/VOYxf1NtbOYsWZ4jB82PHc48wgqm5k9aAfCvF1aMAI+D5NATDyjc0zrt2gJT+s54zYOcADMtAuI8DUHWQfCVC/TvsWcJ3zbIy4dj4VjOB96n2qF4qZ/LLm8rjCNvhURZ6E0mPtIIFCRaPPzauLEcpB5iA8kNQgB+tUN+n3YE0WwyjkaPLMJV5b1+LhS2FqSYB7OrD62RBAcIbfwfLNtFVKzIclMTbjSUTr1pnwxTAGkil8+dDa3vMKN1Ck4L/KOGN7+DqScm4uLGhIux274xSU2g4MYGyHjT6sRvQ2MJHWzJ06B7PNOfXYw98yx/AhwmeSqo7ZD0lh7ePgyzucYB6I+wRfvLonpnjJB8IdIyGcPSa8HOyeFe6Ri2fGEdf+KKM3nhKslR8g00pNXoKklxFqu2NLsvDl6MTKOfpjcAbnEsMAHHxes9sOpXcqBeXXPkvggySmzSuOlngJRZ9KCZJAt4BhnsrUYOU5dkbDAB8B0E6MvulE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(36756003)(31686004)(6506007)(2906002)(86362001)(2616005)(31696002)(38100700002)(26005)(5660300002)(6486002)(82960400001)(186003)(478600001)(6512007)(316002)(53546011)(66556008)(66946007)(66476007)(41300700001)(4326008)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0tGSDBSVnB6aXo0NW9zME1JY0RPTTVxdS8vT3FvaHFLQitSRm1UNlM4eDVk?=
 =?utf-8?B?NTliUWIxRXhQc3VxM0ZLR0lMeUJkcEVhZWxNTEtROTU4RWpIanNIR2daelFu?=
 =?utf-8?B?Q1JJZXNqZHc4RkdicHVKY3dWZnlJSi9neXBuemZ6Q0ZRRUJ1VWc0MUFENHpD?=
 =?utf-8?B?eDNkT1lva1d5VTNYbUQ3ZHNnTlJFUXlNcDcweE9Wa25xZnBZT0JKQU5PWVdY?=
 =?utf-8?B?VkJidlZPeWdXNGVPdldLSWZWQ2FYdTcxL1ltWDZVTTUvRkZiUTl5eG9aYVZJ?=
 =?utf-8?B?ZmhxclRvbndxSHRKeEphL1ExSHAybDFzZ0ZVZHRNNGEvTm1GMHNTd2pyRUZC?=
 =?utf-8?B?aE5jTUNvR1N0a2lQV2ZnTlAyWVdNWHBWZFNITm5kV0NCWlpHUDhURHc5cVNo?=
 =?utf-8?B?YXYwbzNRalhucnAvbE51ay9QcmpLcE1UaEw5US9rLzJsTDVWaTNDMzVzMDRq?=
 =?utf-8?B?Y2pmSHpJdHZ1c1lYL1dFdFViUnZYWjB5OTNXV2pLMkZwcXoxa0EzOWlqcmVv?=
 =?utf-8?B?NUw4NWg0ZDBtRmZoU0F6cVhQdi9GM2RlM2RWWTZTT0xFalJadUtxTk0zanBr?=
 =?utf-8?B?cE0zdGNmSHgzVmUrbGhSaFBNOUhmZGVoQkJzR0NYeWtHd2szVDBTTXpzVGtJ?=
 =?utf-8?B?QjJmVXVWNjdMa0hwenZQUzFrT1VkNUhIeDhuL0ZQOUdEM2JHeVZRd0pYL1BI?=
 =?utf-8?B?bDM1NnNUalIzaEJTa1JldVhORE0yTWNiTzlOaCtTZlJ6U1hadEpKZDFzWDJQ?=
 =?utf-8?B?bThTMG5aMmhibC9UYzR2ZHBQaEZXd2l6NzNhZkZKemRSaGdsQi9JY1I1L29O?=
 =?utf-8?B?d0xha2dIenJjVXJQVUVOUlRaNUd5dlRDeXp2cjdhSzhzNDc5Z29nU1U1aEsw?=
 =?utf-8?B?eDVQTUVGSGZ6Ymhod0RqeGY2amY1MTJTejF6b3lxQkxJRk56WjYwU29mQk9B?=
 =?utf-8?B?OEQyZ0tadU16UHhZR0t1ZHRNNThPMDR2aUFpS285bVBrSG94QkVyRS83azY4?=
 =?utf-8?B?Q0hSTXJqMzRScXg2eHM5WUF0bFVPSFVXK3dOT2NpQi95b1BZTkptYm4yMGl1?=
 =?utf-8?B?ajhadTV6UVJJQUt3YjNSRGdLd2RLNUc2bjVuUEUvZDU0b0t4Z1lia29MYXdG?=
 =?utf-8?B?M1doUk1LaEhMSWdiaVNneWd0OWQzSjFhQ1A5cThyTUtvVTlzemJONytIbndx?=
 =?utf-8?B?Nys1VTdVQmlMOElFZDNab3g1Y2lrTndJMTRJdVE4N2pxVXI4UGpqdmZEQ2g2?=
 =?utf-8?B?VWlCaG1KUlBPaHd5R3VhTFE4V0Z2TEEvcGthVjdwcGxwZ1g2RkZjQy9xTmlv?=
 =?utf-8?B?SENmLzJHUXpIdFFWYzJXUldUcHRIYlYxRGFJcjZoeEUyYlM0KzNGVWhhakdR?=
 =?utf-8?B?OVBkSkRFMHRDYTZZN3Q0Wk4rc2pDZHlVUERaWXJlTGIvZUd0OXl2YjVmN0JV?=
 =?utf-8?B?RmZjSzNVYzc5YUNvakhaM3A4UkV0bENVQ3FCakhnMnNLQkpvc1ZwYVNtekV0?=
 =?utf-8?B?NUlhaVdBdWdRRzFrWDVPQUtpc21KV2JWb094d3J6K3F2NDFTUHViNXlCK1RN?=
 =?utf-8?B?WkpWUUVqdTZEdkZ4UXpROVZFbW14Ry9Ycmd3MHZESlhUaElLZDlpU1hVUHVL?=
 =?utf-8?B?L0oyK1c4Mmd2d1oza3JKYVpWMHR1K0RQY3NTc3MxTXBRY3E2c1dSbkc3d2RQ?=
 =?utf-8?B?V3VzVXRVUWRRR0U1RlM2aFdwWml1ZVI2QloyTWpUYTRrOXhMOHVuLzRraW1C?=
 =?utf-8?B?NmVvai9LclBMMkFacFVzNGM5VHVVVnNkNmYrMU40NmIzWlRYMnhTZ1pEYjB5?=
 =?utf-8?B?TnQ5NjlJZUhUdUVLdjFiUXFaTzVNQVVkZXZrb3dTQm9LU1JQYTcvT1dUQWxI?=
 =?utf-8?B?ZGVtVW5OZGNFckZvQlZKelN1dVhoV2NVVFc5eUt3R1k5TzBVVlZkMy9ycDQ2?=
 =?utf-8?B?TXZDOE11YTg1Z0xVOWFVNnBGZzdIOWlNZVZHSTJtY2FBRU1IaE13SDZ3WmU4?=
 =?utf-8?B?U0ZSN0xRUmdzNjhFODdxazg2bjVTUWtjUG1sK2hrOTFIQkE3dG9DWjdxQTdK?=
 =?utf-8?B?YVIvNWlPMEZrMjBQcDdSVTdTc2U3NVJzTXo0RzZiZWpQK1BFdUJEVkQ3Wkox?=
 =?utf-8?B?WlZ3d21xOFRGaWQrM1llN0dNYTJSSk9wdUxRNWJLN21QemtoSHUvZ0loTUVV?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f68bd54f-55f5-4f52-598d-08dab2cc3c4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 18:52:28.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5V1S+jxBYA2aX8Aq/2mvbIF8r9pslfFRCQbZMEtr7Y09jIVRcY7EnF4GFNLLmqO5X3rPtH/Tlli+dhWY1e2IqXI3pMoyW+BI3mFw3Iq5U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2022 9:57 AM, Dave Hansen wrote:
> On 10/18/22 15:13, Chang S. Bae wrote:
>> @@ -1141,10 +1141,14 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
>>   			 */
>>   			pkru.pkru = pkru_val;
>>   			membuf_write(&to, &pkru, sizeof(pkru));
>> +		} else if (!(header.xfeatures & BIT_ULL(i))) {
>> +			/*
>> +			 * Every extended state component has an all zeros
>> +			 * init state.
>> +			 */
>> +			membuf_zero(&to, xstate_sizes[i]);
>>   		} else {
>> -			copy_feature(header.xfeatures & BIT_ULL(i), &to,
>> -				     __raw_xsave_addr(xsave, i),
>> -				     __raw_xsave_addr(xinit, i),
>> +			membuf_write(&to, __raw_xsave_addr(xsave, i),
>>   				     xstate_sizes[i]);
>>   		}
> 
> Just to add a bit more context, this is inside this loop:
> 
>          mask = fpstate->user_xfeatures;
>          for_each_extended_xfeature(i, mask) {
>                  if (zerofrom < xstate_offsets[i])
>                          membuf_zero(&to, xstate_offsets[i] - zerofrom);
> 		...
> 	}
>          if (to.left)
>                  membuf_zero(&to, to.left);
> 
> In other words, the loop and the surrounding code already know how to
> membuf_zero() any gaps in the middle or the end of the user buffer.
> Would it be simpler to just adjust the 'mask' over which the loop iterates?

Yeah, right!

> I think that would end up being something like:
> 
> 	 mask = fpstate->user_xfeatures &
> 		(xsave->xfeatures | xinit->xfeatures);
> 
> Logically, that makes sense too.  We're copying out of either 'xsave' or
> 'xinit'.  If a feature isn't in either one of those we can't do the
> copy_feature() on it.

Yes, it is. But, one tricky part here is xinit->xstate_bv is zero. 
Instead, xinit->xcomp_bv appears to be relevant. Also, we want this for 
dynamic features that rely on XSAVES. Then, the change can be something 
like this:

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e77cabfa802f..3f3286d7e1a8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1125,6 +1125,15 @@ void __copy_xstate_to_uabi_buf(struct membuf to, 
struct fpstate *fpstate,
          */
         mask = fpstate->user_xfeatures;

+       /*
+        * Dynamic features are not present in init_fpstate since they have
+        * an all zeros init state. When they are in init state, instead of
+        * retrieving them from init_fpstate, remove those from 'mask' to
+        * zero the user buffer.
+        */
+       if (fpu_state_size_dynamic())
+               mask &= (header.xfeatures | xinit->header.xcomp_bv);

Thanks,
Chang
