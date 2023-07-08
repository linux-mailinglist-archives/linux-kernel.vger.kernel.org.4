Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AFD74BB95
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 05:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGHDfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 23:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHDfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:35:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280C61FEA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 20:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688787306; x=1720323306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AEY0Rk7WHR36m11IuiDAaZ03CAJjGxf56SGrVs33iJY=;
  b=MA79zKyHU7bv3e59TABJn/eJBOHBMCHQHz5PCk/z0QAfOS8aDCFFZN3E
   n7xpSLDCNVvkK2/O4/rcGPuubmAwetlbt26VAk5MnNi5/fWEVv/4tPHay
   BwgDBFKCgRWWIyWRFOhZMDVKDQDkq3/lq9WWLUeMBz5lKYxpmgasflKho
   1VCbky/LpffGXI+d2fmhKRHVk/oEH943YC5BlfgfBM4meIT1EUZKZp018
   5Tv77vGLF+JHjD9SATDVzQharMsQ/RBylRV6ylZ0OJ3qguzivsf8/StD+
   G9THTn2DcBLJ8A/Wa5JaKfJ05XKhMvOFqTF1b9bFOqXFPq+19Lze9QtZI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="364065203"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="364065203"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 20:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="894194093"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="894194093"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2023 20:35:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:35:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:35:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 20:35:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 20:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3ZNpzeOWeFw849HfAsX7mKSi6aV/vzewTLxQnrIPMphTxFMfSVgAjEFFcssY0nEjWA/ZDFn2/silt2DpMvOi8g/j90TsGsKmUFElFS2OHrQL7jNlZpcHOUsXDM5OxnN9IVB4QkU0FNBddU56gPJVZ1QpOarF/r0T1vvoR5QWm3Dsc0ySe+EIsKpOIftN55ptfAAS0Vfj5vQXz+pnZJuK7k8YWN/hSWDKEMExrYAm9Bh/UM8+SBIA8i6X2f6+LSlazmo4CKSlN/oa9A4wSOAy5butgJEQHzUd7O/+v+4m2+KbIBMehxSFUtqytPFnJWBOS3/mQ6ci/TEtpmaDDmvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9k8KSUaHUSVF1dsriJvmzkOcUSaClNIxUOj2A6p+6c=;
 b=Ct52Kpd3mXvhoxA3Q/09PseWrRdVmdY/Ehj/9rsjPvYdXjaiXqgXzYqaNHodFhYGNQNXgZ/hBru6iMYGQeJhpEm+9jiitFxPVk0tOoYTKmJjPfwiBbFDVpyIYB3TbHZ6+4jKZP6ff7f8axHK5FPPk9MGTwkrP2+qKdkjaDe4DIqjdX52mDuSrqHdHKwZmo8sq5JWFU9kq8/Yu5lz45MaSAZ1bFnCDM8pUcR6lPUewoKC8Ufjepxs1m2nbc+VEY5lRyFh9XbtRosgU6ldwAPs6YzZiEOesdoGPQNxmuCRj3Yf1BnwiyssparHD2oQmFOJ481+VbEHu88QLE1gK34T+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 03:35:01 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 03:35:01 +0000
Message-ID: <55b79652-12ca-6afb-8718-bddb76bf4d8b@intel.com>
Date:   Sat, 8 Jul 2023 11:34:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yuzhao@google.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: aec23998-3789-4d8e-79cc-08db7f644fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8e5B9+B0Zb3U7sdJ+kqYzhSASHq2WzEI7R5uEjoRQduBoxavb6ijDUWoX+4PHtSMPqeZvAj+u4NTiJ9rzFxWZLRcJnuYBNBb4deyit0qOViXriwfRmFMY5lUibrqYgniIkKqMg2KVYz3fKUd/+NJUfpPMi2/KHSe6Xl6WRHtyxjCcWC9lKMUc88ulSnc/NQ1/cus+TUM3ZZ7tPYPOFtjx/xmTng+pMUiYpnej3eLRFG41TpaKR0xshoqs9AdgqXh/grUuSAl+JK483S0TEjde8YBjOvv+VehK67/dKsJwx4m5IdsFQ0rUlV29Tdgf9AT3Hh9tCM3fGaHsupRsjHUUjD37cqkIT+4Zc28W9aKjPoBWzcW0KwwsbvJSxnKsXijelCwUJFLxjY8mbU5PX7Q3nfDQ/fuACqYE0wtGKNorm7onqyRIZsdAnAIGq/0FpmyAAyDKPuVEz+He59sm62GbkaWT334lY2E4jopeowV5z2ISKyk5RYb6V0TkpPLSI0L5mS+d0nJ9blDHtlK8U0OEAQPqH72enar8R2ISZeBcy6wO7I47p8E4xhYuC1SCY6NfULzf7vQ2HbEYN4BFRKZU0KEfeNDjjELerxz3pJLeZwTDe08otEEaBJxD2jB3P9+SwmfVkibuACVny+Q5Y7NHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(6666004)(478600001)(6486002)(110136005)(53546011)(6506007)(26005)(6512007)(186003)(2906002)(41300700001)(4326008)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(66556008)(38100700002)(82960400001)(86362001)(31696002)(36756003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3ZEWWN4Y25qK1pYUVNZUXhRN2ZPVG5DUkFjUFZ3RERycUd6aXcvS3JZTmNG?=
 =?utf-8?B?anEvRk9RS2l4cmhURTBkdXdYV0xUTk8rNEdEZWcydlpQbCtGNVhkVXRFemU5?=
 =?utf-8?B?emJzN1pNSDB1RjRNSDBRZ2VCdlBHNm9SN2FhZDJCN1RrTlZVTG00WHNHaHdI?=
 =?utf-8?B?bHBSUVcxQjlTc0diRUo3dThFcnBnR01ST0gya1BtY28xbVNmOWcxZ1kwUU1k?=
 =?utf-8?B?ZVhtWk41eXJocTFYd2F6Y2d1L3ZKcEgvUThZNitaSmEwMDE1K2IzLzA2NlIx?=
 =?utf-8?B?NE85VzFVZ2ZDNS9MMVdiK2RTWXN6VWRLZHpPYWJWRTdNRDI4bzlTcHJ6VHlj?=
 =?utf-8?B?NGRYYlFSdi9vaHFKZ21ZL3p6VG45MXBZVGwybkJUbjlDUDZpa29zVk56UlVl?=
 =?utf-8?B?S2YxbEhxYVJBVnVrdEtjQmhsYzBZQ2ZGWjFNU0xlV1dLSFVwaXpPK0lGanQy?=
 =?utf-8?B?b3FGL1RkYktiMEt6eElBSkRtV3F1WDRoa2ZzeFN5TXhkMkNDZElTZjhWMnpZ?=
 =?utf-8?B?UUpTbGdITVpqZTBSajg3TnlRZmVjd3VjNFQ1SGgzcXQxaGVwREZVNG82S1Fw?=
 =?utf-8?B?S0VzS2ovL3M1RnlNbXVIdzlVV1V0cGJjaC94UWRVVWxlVGhTY1Z0dVdXS2E2?=
 =?utf-8?B?NkgyVzdxbElHOXJPTlJwV3pycENrOFNZM0k2NGRXekJDcFNDZko2MlBHMzVx?=
 =?utf-8?B?eXRUcjBrS3JOZ3RHSFpvZzRTSmR5THQ0cEpQb0tYRTI0RHAxTkY0OHRHU0Rm?=
 =?utf-8?B?OWtpYW5lQTJxTE1UeWFoOTNobWJNNUhlOGdEcGxaTzJsNHkyMDlRR0F2OWpt?=
 =?utf-8?B?Q0pQWlBoVFhlSStqZHpJWElDTXE2S1VHRnNNcmVVT1BDVDN5Zk1nbWdUdXVs?=
 =?utf-8?B?Q0VCSE0rTGlRSy9tYTFVdWdhYm00TlE3eWpJTU1Uc1dQZ2NUcHFha2pBYmU3?=
 =?utf-8?B?aDk0SHdRTldyTGJxYVFSamZBamlHbGFBRkMxTkpVOXVKbXdCVDBOWWdYbndI?=
 =?utf-8?B?Y0cxbHBIdnMvdDhYeldzMnV3WWtTOE9ZMUxjZE1aZVl5dHBrcFd0L3hhbFlz?=
 =?utf-8?B?R0lGb1dJaDVhTFZFM2p0eDRzb3VMcVYvUTh5MGxITGxVVHVnQlcweDJyMFIv?=
 =?utf-8?B?WTZyeURIWE4zV29ZbXBIM1FpQm1GRjE5N3loVjk1RmdXZmo1U1o3UW54T2VT?=
 =?utf-8?B?UlN6TTY0TzJZNVJMa09RSUMwR01IOU1UTUlKTmdsV0tCc1ZSYXd5bk1BMTlI?=
 =?utf-8?B?MVJuQnQxL0FOcUw5RGVUNGk3RDRWRnIzb3JmWUdaMS90WGNwUW8rb2ZoL0NN?=
 =?utf-8?B?SjRoSWZWWXlsNG8wcjBTSlliYlp5VUwzZXQ4NnRqS3VnRXBxRjhKWVZhcnpz?=
 =?utf-8?B?c0pVMEFxOFJRc0x0cTBwazd4UzFZTHFNd2Z2cDNwaWlzY3h0RHpMWEZ5Yk1Y?=
 =?utf-8?B?dUFsK1N6ME1ZbkZXQUVUQk1uTk9Ba0Jpa2NOR0p3M0dyWGpFek1tRk5ldzNG?=
 =?utf-8?B?YUZJSFNjU2l1aDFHVU1sWFBVVWlYbVRHaWczb0xld3k2MHoyYnBTODl0OXF4?=
 =?utf-8?B?dnRGdnBGa3c5czkvY2pNWUZ5dExVbms4L2ttRWZmSzhzUFc2WHI1ZHU3aFJE?=
 =?utf-8?B?UHpRQ0UxMFBuUUx1VEZCVUFWV3hkNGtET2I5MUh1YklUb3c4TGhVL2VCQ1A1?=
 =?utf-8?B?d08waXJXTXRRaHhXdklaWjBrUFVrZ0hnQWxEaVpBMzJoRU9NZk80bGJiZFRF?=
 =?utf-8?B?Y0REdXd1SW9zOTVkNmY1dHFTZytJZ0tXdlhvNWhOV2RYSEZxTkNpaVJrSnJW?=
 =?utf-8?B?TEE0Q1ZISVpjSW1tOEorc1dUdFVvNC9kbmRyemh1cHdFU3d3d0RuRHJWdDRz?=
 =?utf-8?B?MXlFVW5QdEkvL29aQnI5WEdNZEJwUGduS3N2Y0wyaDUwM2hvU0J3bUJ3Tmp4?=
 =?utf-8?B?RTlIaGVwZ3BGTlFvOTdHR1FpT1NrcE9YaldENFhwYVloZUJWVlVKbVVYdy9H?=
 =?utf-8?B?MlBXMDBicW9NcEd5a1ZrOVBnTGhDNFF6MXlFQUNTL2FjSmNvTHA5SU93Q0h3?=
 =?utf-8?B?RlBvRkZJQmxCMHg3aWYzeGZaRTduejl3eXM2Rk5pZDhCQllDNWxIV1AxTU03?=
 =?utf-8?B?c3ZQcVVYUXdEK1dsd0JnL2QrV1FWdEFkdCtlMFV5UTBYRnhoRjc4SXFFM3BQ?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aec23998-3789-4d8e-79cc-08db7f644fee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 03:35:01.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpApEqnGDx+KqQj+oGmNF272eLVwpCt2TlwYiiIQH80IdHO7aVF3Fdi2WuTViSOip0lpKPO3tDrb+tmncjpRSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2023 2:54 AM, David Hildenbrand wrote:
> On 07.07.23 19:26, Matthew Wilcox wrote:
>> On Sat, Jul 08, 2023 at 12:52:18AM +0800, Yin Fengwei wrote:
>>> This series identified the large folio for mlock to two types:
>>>    - The large folio is in VM_LOCKED VMA range
>>>    - The large folio cross VM_LOCKED VMA boundary
>>
>> This is somewhere that I think our fixation on MUST USE PMD ENTRIES
>> has led us astray.  Today when the arguments to mlock() cross a folio
>> boundary, we split the PMD entry but leave the folio intact.  That means
>> that we continue to manage the folio as a single entry on the LRU list.
>> But userspace may have no idea that we're doing this.  It may have made
>> several calls to mmap() 256kB at once, they've all been coalesced into
>> a single VMA and khugepaged has come along behind its back and created
>> a 2MB THP.  Now userspace calls mlock() and instead of treating that as
>> a hint that oops, maybe we shouldn't've done that, we do our utmost to
>> preserve the 2MB folio.
>>
>> I think this whole approach needs rethinking.  IMO, anonymous folios
>> should not cross VMA boundaries.  Tell me why I'm wrong.
> 
> I think we touched upon that a couple of times already, and the main issue is that while it sounds nice in theory, it's impossible in practice.
> 
> THP are supposed to be transparent, that is, we should not let arbitrary operations fail.
> 
> But nothing stops user space from
> 
> (a) mmap'ing a 2 MiB region
> (b) GUP-pinning the whole range
> (c) GUP-pinning the first half
> (d) unpinning the whole range from (a)
> (e) munmap'ing the second half
> 
> 
> And that's just one out of many examples I can think of, not even considering temporary/speculative references that can prevent a split at random points in time -- especially when splitting a VMA.
> 
Yes. The case that folio can't be split successfully is the only reason
I tried to avoid split the folio in mlock() syscall. I'd like to postpone
the split to page reclaim phase.


Regards
Yin, Fengwei

> Sure, any time we PTE-map a THP we might just say "let's put that on the deferred split queue" and cross fingers that we can eventually split it later. (I was recently thinking about that in the context of the mapcount ...)
> 
> It's all a big mess ...
> 
