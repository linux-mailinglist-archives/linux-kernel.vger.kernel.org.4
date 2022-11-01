Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F90615347
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKAU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiKAU2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:28:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF6167F6;
        Tue,  1 Nov 2022 13:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667334527; x=1698870527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9VMz/FH2R+qpDxAyuwGGvjDvvt1U4ax3yjK1oWN1CTY=;
  b=doXS8nQDTb/54OawG8INPhvuTiHxlKf7hss0gO/j/oHe0f2Il90R0qan
   BCjQVdlGLW38nrgFS7HtAeCGmqx0fJGJ++Xrcochx3XCdB/wRCrBzp/h3
   Yqq9N8n3GdOXPEAMp1SrnQccQ5tt+mTCojQOPC9zvIgkJX3KA27lJBHcl
   nrcoV/pmdaZsWfIcaPQPWj0j+AyoML09eLAFOc0A61z+Gm06QLP+4+3X7
   lpZzGz7cWCYKBjtHGRSnZdMmu5IgyuzIe2tu1H1gVEgw3rip26O1hQpnR
   jlcktSI0INV5yc/IiMPNRm33MUROy6rLedlfWjxFLYI2qC83BdoZNas6v
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373456015"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="373456015"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 13:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697536243"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="697536243"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 01 Nov 2022 13:28:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 13:28:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 13:28:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 13:28:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 13:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxQbOScsvVzIkCjccAQ7c1SrGMeAuK4neO6PZgl9YWLk8KUxzkF8RnnI3MZO1k5AOvAX9j5kacv4V3Wmdj1dKxNAnarHTxWFYXtbw8N1w6Ckc88DZ8EXLEfRlAKB0bjAokTJ57fb5Nz2LmVEghyj1YrCSQ4fFttsPKlN8ZXNDQR8/6v94FqfqgBIO8kOznx7S4ptqrfdQtBewa8fAtHUQki+MZ2i1gtC0doBT9JN4ZORfb5K0MtFQ5sykVhHM3uzzfCcT3oi/rvin6+EJDXaKejQlRERY/RFW4rbjeKWJ+b+KC1HYpcP4SKTBM0CuxzDeDn2jj9Y+9RTrR4EPOvXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRTg4rlU0uZWfPGPnVUkQ+lZ9MIsF0qC62Jk0BRu7ss=;
 b=FCdm2Sw0UuTbNcFGEXQp+oqO9g0vhnkkRK/ThX8j1uRLnhOs3E0M6pYCXekTnByHtwWgkSo+1fae+h18I3yQag+AHvxrzG8Bsx7YoR73XcrzfZbfTN6rIse9c37vq8Wod2E/+H8W4s6qqNKTIGgIoT3QqY+hxVOzec3lv96nVEuRNfB7FNLbqVajOUdlxpy52gfvswCLEIbhzaKZEw6MQuXoEZZa4DVGMTOuJDWeFK6tQdYmt31Zf2uNHpRS+hZCNnMZReoB/NnH82T/8t5THvJhttgvahaoe3QJ78Y6HbwfRD/ZEnxo5Ev7885mSHfX5ktUW8BW9VYBxiSJfV+xRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BL1PR11MB5335.namprd11.prod.outlook.com (2603:10b6:208:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 20:28:31 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 20:28:31 +0000
Message-ID: <5aa498ab-1ad6-900b-75eb-003ea2d4d8b1@intel.com>
Date:   Tue, 1 Nov 2022 13:28:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 10/14] platform/x86/intel/ifs: Add metadata validation
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
 <20221021203413.1220137-11-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-11-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BL1PR11MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: f01f9e06-c05a-49a7-aec7-08dabc47a3fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBBlYHX/y21IrC6YPM2aqkJDr27d8iUOoUooQavZRSsSVj/znLlqeoZd84qQKD4FUj02RPNWt0+aVGmm7XeuwCj5GpEk+aMk+olC2i3EcjFDm0HjOH0KhbUBtb0s9JZPdGEzEMJHWeRmbbWRU4yfKjCjsQRHgdUuVka1pWv5/myPMVYVwtfFMEXPR79n+j7O74jXgP+JZokGczqzuSM4cEWgqZTFrQZQjyyMJf57rZJ1qIGH6of6oThHcoGELoJCXjaFm+b7IfOSxOdtxZbzLU85NkKeiQJ6OyIxhTx6XRQvXUzUSdpymxPCp1+Z5vBpLIsKsZAqWA1FfGy7MMFCj0Kvw9gED3WU8XkQTmnBEoSATKK3hHjNv2/I2YdAUZryzzpLwhHO4XMSnLWq/K6xZrBrG+M8Qb/a06horQ/F3pO7LWUDEpQxYUBbsSmvxrO8ExfbaT1Ed73tFsjiA0HvIqzBKmXyBNFPPE3J0tDcWV1vYCMJe5vhKMYgUq3sIbA9iMMhRJ8+o3hgMzyVE7YDTf78vgQVZ2IeLFpxhTGb7EbOK59c27eFEYuT6fd2mH8j22z2M8Mbd042gcuLmdkvSDN9kNb4Mi9g8r7sq04ALJ7YneUzi4Cd2OFdBgg420lcTN6ar4k+JIElbNaemB99s9yhwGMDVLYNS60t9K8JjvYpqOjV6LK3Qu97cmZR7v0Cz6jcLXXFoqEsya9VGfyHOrF0FoCEH5PYgxJDmWXJ0XHzK1OOeEac6AF5cGBuWKwtVTVOxKJxnwcoPMaIOH31lSTqipeA2hSqr3knF3s8ph8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(31686004)(36756003)(82960400001)(5660300002)(44832011)(7416002)(83380400001)(2906002)(86362001)(31696002)(38100700002)(6512007)(4326008)(26005)(186003)(316002)(2616005)(6486002)(478600001)(6666004)(66556008)(66476007)(8936002)(8676002)(66946007)(41300700001)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEFEd3BuS3hjZTRWR1l1NmxYQXE3T3JYR0NTaG9Ca0xMdmIraHZKSFFoUkhk?=
 =?utf-8?B?dkwrYzZaVGlkQWNnYU9qZWxUbmpSUjNkNi9VUGhtTEtqeTRkdGZibGl0RzZ3?=
 =?utf-8?B?U0FxaFVWbkVXc2lYSWtibUh6TGE2Y1ZzRm9hTVdEMjdZbVRTQm00VzF0aWZC?=
 =?utf-8?B?a3pZVmdHRHZ0TnpwbE52alBBN3lnMm9aNklDdngvTUVWT05HWUV2RGpuZG0y?=
 =?utf-8?B?NU9Ed1paenl1T2cxWlR2VE1KTXpTV0xORkxjUVJ1VFFsS2ZnTjZ5NENPL3Yz?=
 =?utf-8?B?dFhwU1ZLTlgreml2Q05IdkI0UEhXMUNjUkx3bnc3SWZJQ0xMTHNwZStseklG?=
 =?utf-8?B?TlEzQ3pDczNKTCtyQS93ZmplVy9zVkY4QjRwOW40T2VPaUJvME9JeEprUnFC?=
 =?utf-8?B?eGd4bWlmdituSHZWalh6ZmpaZGlITnJDcUdVbG45a3prRWVzcEo4Q0pYeWVH?=
 =?utf-8?B?TnNsR21oanIrb1RkN1cvTkxxS0ZmcjRiekIxWEJqS2k5WW1EQS92dE53QVc0?=
 =?utf-8?B?dlorREtDd3I0aURNZk0vOEtrcVhHZEdBVmhFZ3laOWdlK2h1Sm5PZlJHVDVM?=
 =?utf-8?B?am8xL2t2WkhOZ1UzaytyR2s4eUlMS2c1aFRhQXdaV0wrR2JUNXdVSXBCRzRV?=
 =?utf-8?B?QlhjZXpvaVhVZG5uVFdTSEtIRWw1K2VLOG15RkRrWWZDSzB2L3N1VjBUWW5w?=
 =?utf-8?B?WXBGSTg1MTE4MUpVa3FtaWI2TldiRXNYMEw0SW9mTmxuY2dVU0RxNUx1Qzhx?=
 =?utf-8?B?ZmJvQUk0ZnA4cGVXNGsyeGxheTdIelhuNVhBbmdUVzExSFczaGFMKytLMnV3?=
 =?utf-8?B?YmJnL1g4RWZKWG9OZjZUZnBydW1KQ29MQXhkdmJJRGw1REwrTEVRbDRvNStV?=
 =?utf-8?B?dkYra1I1cUJ3bmVPUG9uUzdlaStBNWx0T3ZRVkFBR1pFWGd5S1ZtVXNKWC80?=
 =?utf-8?B?ZWhUbnIxenF0SWY4WkhoRHlscFEybTh2Qmtrdkc1MDdZb3ZoNlZtTUN3U3NO?=
 =?utf-8?B?djV2ZC96UENwYjNGMmdwWUxSK1VjL25VM0UzZlNQZVlkeS9mVnQ2YWJQQUgv?=
 =?utf-8?B?dE94TEd1Vmxya0lUZWJlZ2tlcHk4WjNaaUczenRDZEtyQVhmc2M0WEF5V2RM?=
 =?utf-8?B?SU9PSXE5SUpRd2VhRzF2OWxZRzVEeUZKMHFZTk9NWithZ1JIeWpxZEpxeStB?=
 =?utf-8?B?N292Q3llY3hmaEpyU2VWZkc4R1hqM2FHUDkweUV0ak5GR0FFQ01YVDhJTHhO?=
 =?utf-8?B?Qlg5UE54ZldvcTVpdDBVQXRsNThQQnRKQk9XTkplN0N1TW12ZmU0ZGNLZWNN?=
 =?utf-8?B?cDUyQ215eEUxZXRjSFhxN0phcUxVNDdvN3lkYThRWDNJKzR5STJIQWVZd1Yv?=
 =?utf-8?B?Yk05b1NISmJuUXlIY1hpbmV2LzcwWXBnWFM1YUMrSks1c0NWY3ptUGFWb2VG?=
 =?utf-8?B?QjY5UnRKYTF5a0N1ejU3K2QwVklzL0dDVklLYjZNTXd4VWtlYWJhWER3MUpL?=
 =?utf-8?B?SUlNV1hrQkFHV1Z2UFliUEZvN3kwb096R21BSThKYU5MNDl6d0RWcW5aSDZZ?=
 =?utf-8?B?SEFkcXA2YzBLbmFEalFvYTJnbzYxclI3ZHdzQVMvMCs2VHBCYmQxc05lc1dq?=
 =?utf-8?B?R25adExyTXo1Um5vU2p0Nk8yNGxhTjl2MXp4OUVDSlBpKzFIaWV4VHhOMUF6?=
 =?utf-8?B?b2FIQlFvTVNpZlBkN1h2V1ZwNVlrM2dnNXRPZURKU2huUDg5cTd1bXlBcXZ4?=
 =?utf-8?B?c0V3T1JMU1VkcXcxckEzclVtbzZuTDFVWlJwSHk0akRuZE9tWkN0T2JXcmFs?=
 =?utf-8?B?YXBsUkFlNUVld0ZWSnBNdmpndXk0OUpSL0xJRnRyNG1tSWFTMndoWFQwRklV?=
 =?utf-8?B?dGgxNmZSak9iTUZqSThZY0hZc09LeEtkYU1PMkpOVU1qNmdYNjlmVWVmUkd2?=
 =?utf-8?B?QURYM2RYOGttMDNlbFlkNVRwd3NOelJZNERzZlJaUDNpdG0zK0ZBeUlldGNt?=
 =?utf-8?B?Um1pTmM4R3lydkhQVFN0TGNvWmh4bFE3SjJGaW5YcjV3T2hsV0R6bzZScFpK?=
 =?utf-8?B?TDcwRHA5OFFzZTFVM3FFKzdXaGxOb2E3dGdPc3ZnM0NkMlAyOXBhUlJVbzZm?=
 =?utf-8?B?L3NxTytoSGF0YkhXYXUxMDBWUHJjSjk5dytGOWVkQ3R2TWliTXZ1czY5L1pQ?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f01f9e06-c05a-49a7-aec7-08dabc47a3fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 20:28:30.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75sr5RhCuRtAEocWY1xAm98187Cb0IqIWA6Pb7IhwRcsugqgMhSwt0qoP9YJIocQOqLKAubRg2NxqlWU8b+N2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 1:34 PM, Jithu Joseph wrote:
> The data portion of IFS test image file contains a meta-data

Can we be consistent with meta-data/metadata usage? Multiple patches 
have this dual usage.

The popular usage in the kernel seems to be "metadata". I would suggest:

s/meta-data/metadata

> structure in addition to test data and hashes.
> 
> Introduce the layout of this meta_data structure and validate
> the sanity of certain fields of the new-image before loading.
> 

s/new-image/new image

> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index be37512535f2..bb43fd65d2d2 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -196,6 +196,7 @@ union ifs_status {
>    * @valid_chunks: number of chunks which could be validated.
>    * @status: it holds simple status pass/fail/untested
>    * @scan_details: opaque scan status code from h/w
> + * @cur_batch: suffix indicating the currently loaded test file

What does "suffix" refer to here? I feel how you derive the current 
batch information shouldn't really matter.

>    */
>   struct ifs_data {
>   	int	integrity_cap_bit;
> @@ -205,6 +206,7 @@ struct ifs_data {
>   	int	valid_chunks;
>   	int	status;
>   	u64	scan_details;
> +	int	cur_batch;
>   };
>   

...

>   #define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
>   #define IFS_HEADER_VER	2
> +#define META_TYPE_IFS	1

What namespace does this meta type belong to? Is the expectation here 
that IFS will have different meta types? Or in the generic microcode 
header IFS meta can be found using this type?

I am asking since microcode_intel_find_meta_data() would be eventually 
called from other non-ifs places as well.

Can you please point me to the architecture documentation that describes 
this?


> +static int validate_ifs_metadata(struct device *dev)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	struct meta_data *ifs_meta;
> +	char test_file[64];
> +	int ret = -EINVAL;
> +
> +	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.scan",
> +		 boot_cpu_data.x86, boot_cpu_data.x86_model,
> +		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
> +

There are multiple usages of ifsd->cur_batch in this patch. AFAIU, the 
variable is still uninitialized. Would this validation patch make more 
sense after patch 12? The "cur_batch" terminology is introduced there 
and the initialization happens there as well.

> +
> +	if (ifs_meta->current_image != ifsd->cur_batch) {
> +		dev_warn(dev, "Suffix metadata is not matching with filename %s(0x%02x)\n",

What does "suffix metadata" mean? How about:

Currently loaded filename %s(0x%02x) doesn't match with the information 
in the metadata.

Sohil

