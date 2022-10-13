Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5FE5FDF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiJMRdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJMRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:33:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985D181
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665682416; x=1697218416;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OlqvMayxMW56g0cfW/Qgeoslxz3cJw8H/atTYM0/SRY=;
  b=d3u0UHBiX0UPQkiuJEwQaqsHROZPoCWheRCbMfiaDdX36Swto9mnZP7V
   seIfunCHzDuAFHw8PGp7+nezgfSv/pXrkVfltEkTXlo5D7LOIPhCoqxxA
   Zb6oj93vDBYyJEHR0NvBlxmvI6lNZAcAQpyb71o/KPiwsFrsEWiyEmSKi
   rSLRUmg7QYBNWTlWFJmelxd+qncS96gaHyKUTkTDp/JIN385xDmuXF2nZ
   7102MpwlZEJaaj7Qh+SgLGl+UamzkijaOsTGnQhNRvjILAnrHRSKzKNbY
   B7syZN/AqXixQPAAglEs+veOl9l4XgUgAbNh/zPOhoZtaIPzo9dnx0z90
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="369338279"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="369338279"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 10:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="605065579"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="605065579"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2022 10:33:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 10:33:33 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 10:33:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 10:33:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 10:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCbJ5mF8xiOitrZpAkvDWNP8Ylky3ggqsux737zQnum0A9Pf79Es8suDhbYUUjxPtdI8xbd8adelnn1TGpGzFovJFyuwsDecTI1f2FWsz0V/V00lqNSVOX/m4nQgWnVajF/rsu8znCu509PA4nhNK1ufamnbXpFXDbN2b59rmA5NZn7giobEciE7gChcqR9112y+wz/ih9/S7OV0hMvDnfsnY033Pv1YAVtGJOfZLyaP9nOEoX7z+FhgQB2ThpifogGRVZ3P3KIUUlUS6eKlrnakraGLYhEYQHHMx2ssn3AX+5UStF9Fer/oejzi9Of8XHxQQMk+P7JlzodYrIJxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWDH8e8m/P3FVm1Y/PBY+c5dM8/Jyqbg600+VrtCWCQ=;
 b=FcsM5kbtk9shq4eBty8B119l7Dfr7sst+STXQspz77XU/CI8nBGErD4jnTzqRjkJM5N6mbTuFu2vfU6BHarHyAuvw6UjCJOsL7uasgC7LCiLfVXpPGkbxJOf4IajixcIDGhtvc6FGMOwAH+OqoWhZng8DjuzxBFiU4JUk3sfYlGSouBtS0Ah/4v5ymL+R/KsmKxZ6if++RUbHDeHrFX7KeBf1iZwZO/fY/pTE9fzvbZYh/XreX163preaxkcBO/XASwEJ1ed2B/V3Lobgc3w3h25VaISmqLnMh7QVnxa5dWYz0sxH9yAb5IQ1CO0ZYXgBkfSrkWtwl7zqKky8CJizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 17:33:31 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5709.022; Thu, 13 Oct 2022
 17:33:31 +0000
Message-ID: <9be1413b-ce30-acf8-86fb-3e302dc98396@intel.com>
Date:   Thu, 13 Oct 2022 10:33:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>,
        "Yao, Yuan" <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
 <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
 <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
 <78f2021e-339f-9dfb-2aee-51f58ea77ec9@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <78f2021e-339f-9dfb-2aee-51f58ea77ec9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::18) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d71074-2051-44fe-449a-08daad410bc4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Phxr+fkofakcfxNtio2XtNgRh0DCFCwBF0zSW+w8KBSA0nczYAUxAYHtoNAqcE+UmEh6s0LaBp8nHNJEFOfqhx8Hyc0eo7TmGuJ6fxHSe458EzQomousYTO6ZrTTDdiZo3nl5dLYUh93BELYowTJ+u95lMkk6FAyPtLg40pJzxhBDZMR/aV9zgpe8pXIs0xUJ0VAOniEjEYwULpqLWU4WIlb+Lg4X5GSbLm9uSxAwfHuLdwSGhNgMeZdeQM7KkdDYwQq4fozzO9rC073j1tNRVNfavIy0HjFZ2eBmyKgU1JVnIzbw0JWrYZ4BFrbK6Hfg6cjB4+br89tjYvC4ZMbdJMtALxaedXAepgBqJD6ho//scyI0sRta4UTX/WumXDYvo7ctf0zzjEctA8eQC/696qusrf0CKqScB4m4L7wbaS4xv1lU1btfl7HfTGD1TdFTAyttUU753misF8nX23pcAw7wUOYnsgyqbH4Hlo2W3KbA7BlY9rT3iR9KmrzUhpGF7+6sxwzZRK7x1uxpFnah7iPRP6OBgQUhqId8ly/djrsSqMPId6QIGzTemLBL6tNOP7frXUZiaELI9it3u74mxVL8FV+x4MOCj61hUnqmuwf2aBBa7lN3RZJoF2NpjCRqkcIuuwHajsWNY8nhyROOTWWhB9zhcMQk7K6+NNkm8GNgU9EIQpzzgnR01SSvgguTNXOiqULc1a88uznhk5S9ClZeGUhkAaZQGFN40eZKwD+7AlEZp8tGzzoHxFgtLZNf6snh1FXipgYBvNI5imw5V0AlHxkhYCfAKHtHlYPGyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(54906003)(110136005)(316002)(4326008)(6486002)(66476007)(66556008)(66946007)(8676002)(31686004)(478600001)(6512007)(26005)(8936002)(41300700001)(53546011)(6506007)(186003)(5660300002)(2906002)(2616005)(83380400001)(36756003)(82960400001)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRydkZpQmp3U2JHR3Q2Ums5VHgxMkNzbTNyUlZOZ3RrZjVjdzRML0tadlFz?=
 =?utf-8?B?aDgvSHdNTzc5Rk13U2Z0MzljaksxZUFUVTl2c1cvMC94dXdhS254cDJ0Tlpy?=
 =?utf-8?B?VWFDdjBHWE9sRXBlVytRTm9BZzBjM3VaV1QzZXFKWkZSSEpOMGJqY29YSjYv?=
 =?utf-8?B?cy9zNDRhemt5Wk55V1BsV3Mxcm93NlJWOXZmTm5LNEEyaUc2Y2l6d2VRUDVK?=
 =?utf-8?B?Z09NYzEvcDhubFJyeWdJaW5raHlQTEx6VVRkUmdULzJPOUJ6c29VVm5UOCsw?=
 =?utf-8?B?dTR0NU16M2t1Lzk3TmJnL0tjanlOYUc0OEtyNC9maHYvdGxNaTZYb1NpakJ4?=
 =?utf-8?B?QzJ3dGF1VGFhWU90Wk1aOXpwUkRURmpaUXpEblVFT2dXSW0xcjZlQml2SE1k?=
 =?utf-8?B?RXBCeW01NDZRYnk1V3NBaitYSW50bWVtQU5wcnJVYjVBSUJ4VlcveTRIK1Yz?=
 =?utf-8?B?UWk0SjhyQUFPaFJmVCtudnhVNHYyZFU3NTU2WTY3U3drby92ZHZnczJ1RzJk?=
 =?utf-8?B?VENzY1FPbHVmSzR2andPZUtZM2ZtQkttMXJ5L1VZK1RlZTlXV253MGtWZUZX?=
 =?utf-8?B?R3U1ZnJIWDhHa2JuT3FnSFNaYVZmM0JGa1UvY2FRNUpuZWxONitzTlFZcWFw?=
 =?utf-8?B?dlcxUzFJK0dZSkZUT1M3RnQxZ2RTQ0tHcjF5QytMV25qcEN6d0hHcWJHb2hH?=
 =?utf-8?B?ak94NFhxV2xjcTA5RWtrb084eURBRmhOdlpmMjlkQXZOWUExeFFpK3haY2Ro?=
 =?utf-8?B?c1cxZXVXOVZzSW5Fbjdnc0ZFM0pGRVU0NlcvVURXQ2RCN3hqWlkvOFVFRXda?=
 =?utf-8?B?Yk5qTVNRc1ZOSXdRLy8zeGxPRHJvVjFYSVgydEpMZ1NIWHdrTjZLNit4Q0hN?=
 =?utf-8?B?QW1tTkxEQm13S09rNjZnMTJpV1IxSlRad0xiNDBlOWVyTFYrTUt1azNwejd5?=
 =?utf-8?B?Ris4WHBGTUxSckxHSjNkNmFPZm5Ic0FHNGdaeW8zOUhvaXgrRHJLV0pXRTRw?=
 =?utf-8?B?WTBZTHhzVEJiRFh5eEhFYTRHa2VCcHhtMkhZL3VVWGZoY1c4MG9LWTlhbERO?=
 =?utf-8?B?Smt2RjRWc1B4dlhpaER6Z3VkR3hNRjJBRG9XOEZJeHphTFpCSlNiQTVzc2I3?=
 =?utf-8?B?VFNwcGlITHBwZGpSSzBqMWNhQXVOa2dHS3FMem42SVNpTy9ER3pQSnVNK0Rs?=
 =?utf-8?B?NmEraDJKVmcrRlhMYktkY1FSbmpmelljS1RkMzArTGJ4YXQ1aURMQ1lFRWRx?=
 =?utf-8?B?ZVhoN21ZQytkZHByb09XTlNCNXMxZXFuOFB6Nk1rUDhhcW55NHlJalppMHFO?=
 =?utf-8?B?dlp2QmpWUHd6d2tYZU02NnZwWlM4aThLN3JDZmg3VDJZaW9zTGFZSGFKWHpK?=
 =?utf-8?B?Ui83OWN4U1gvUXBCcDgrOFVXYzBwSlkyb05XbFZHUFIzY1FEcVgrWWpsMjE2?=
 =?utf-8?B?aEpWTzhMcGZUZ2E2RmVISGd4dDI0UWhFTXBWN25WR2NJTUpYbVNybWFVM3RP?=
 =?utf-8?B?ZXdZS3N0Y1VoQUQ4VkZYY3JpNGYyYzAwNWx1UXhCclB5ZTc0WVJhajVRSm52?=
 =?utf-8?B?NEV0TmFQR3lpRUV2RXVEaDYrY1JtYVlMejJQUHpuN1R3cGtVR2tzSllhT2lk?=
 =?utf-8?B?akdxQzVLTVJBd0dOUTBzNjJOdFNya3ZMY2dBZXkxdHNKVURhOW1URVdFbmdv?=
 =?utf-8?B?SFBFNFZtOGVxc0dNbW8vTnp2UXFhYjRkbXNhb0Z5cHYvVGM5TE5BRkJYTHJW?=
 =?utf-8?B?ZmxaSmpnZFlpcDUyQkNGNWlLczNwWWlBUVVXdjd0d1UxNS9qWU54QjBVTVk4?=
 =?utf-8?B?S0l1dkhEYzRnUm54QjA2YU5xeDVQd09aNlhzZUIyTGlUcEQ1eTB0ajA4MmZv?=
 =?utf-8?B?bXFlbnlYaVd0ZnF5U3dqTnFFRXJJenFVZjV0UFlUSS9RbFZHTWp0Z2lXSUtZ?=
 =?utf-8?B?U1NwMEZJNklxQ3JLdm1xL3VWSFlwT3RzamRSVEFXMk1zNHdTVXBFdGM1MDhs?=
 =?utf-8?B?cXc1V3ZIWDk0NncxOWo0UDZ2Z1NsRGJOK0ZKL25uRU5MQ3pFUytwb0haaWY4?=
 =?utf-8?B?ems1Rm8zaTcwQUZCbzdKU3JJc2lnRWU5SCt6eFc2UWlVL2RHSzFoTzB5ODRt?=
 =?utf-8?B?VXBIVW5YSXQ5cUdyckdmYndLSTFsaGtqb1pPdTgvSUJUMlpHY1FDRVg0ZHdO?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d71074-2051-44fe-449a-08daad410bc4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 17:33:30.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50x1laLWZBr1N8UCstp79/KhSRzj82/IpmI13WqLcFtWvtDlSx1KMETjwk0sk95tR+UYFHYj/7bDmotgqY1nkHpMTQ1WmwLcJRWZbbKXalI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2022 10:21 AM, Dave Hansen wrote:
> On 10/13/22 09:23, Chang S. Bae wrote:
>>
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -1127,8 +1127,12 @@ void __copy_xstate_to_uabi_buf(struct membuf to,
>> struct fpstate *fpstate,
>>           * non-compacted format disabled features still occupy state space,
>>           * but there is no state to copy from in the compacted
>>           * init_fpstate. The gap tracking will zero these states.
>> +        *
>> +        * In the case of guest fpstate, this user_xfeatures does not
>> +        * dynamically reflect the capacity of the XSAVE buffer but
>> +        * xfeatures does. So AND them together.
>>           */
>> -       mask = fpstate->user_xfeatures;
>> +       mask = fpstate->user_xfeatures & fpstate->xfeatures;
> 
> I'm not sure this is quite right either.
> 
> Doesn't kvm expect that all of the ->user_xfeatures will end up being
> copied out?  We surely can't copy them from 'fpstate' if the feature
> isn't there, but we can't skip them entirely, can we?

No, we can't skip them. IIUC, the code will zero out:

	/*
	 * ... The gap tracking will zero these states.
	 */
	mask = fpstate->user_xfeatures;

	for_each_extended_xfeature(i, mask) {
		/*
		 * If there was a feature or alignment gap, zero the space
		 * in the destination buffer.
		 */
		if (zerofrom < xstate_offsets[i])
			membuf_zero(&to, xstate_offsets[i] - zerofrom);

		<snip>

		/*
		 * Keep track of the last copied state in the non-compacted
		 * target buffer for gap zeroing.
		 */
		zerofrom = xstate_offsets[i] + xstate_sizes[i];
	}

out:
	if (to.left)
		membuf_zero(&to, to.left);

Thanks,
Chang
