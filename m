Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1562666772
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjALANb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjALAN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:13:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93546D111
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673482407; x=1705018407;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=fw6NOU/HD58SJFprsTSh7xOFOjLmZahxR+TjJVPZO1g=;
  b=I0bYnbm6reTqF/qFe46JCRt8RCnN8MGlsmTmXusF3bwnTEiD/b/JxipQ
   FFra3WBMIR/egL0bkCPkDBIm+drj7bmDO6W7A1oq530CBlPtPO3tOfHvp
   dlwwfYA3XZ1JcDYPQzKg8zKCvVh48SWUlWx1VVi5QcOQ6n7GHhGhs6Lal
   DJjFU0uIBrCZdmerVVrxPRDXlvrk2GTGZipIsbmg4NeoCFH98jSctBRrT
   qOpzt6q0A5Mwf1VrLxpoffNAE5VUfnpKZsq28DUn39HV2B81GjLDazfc/
   1Z3uzZOWzJ88bTVa6mXuqv441LiRJ2YnXYVuhCJhzVb7SnFlwQkZiQrUL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311393549"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="311393549"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831491474"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="831491474"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2023 16:13:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 16:13:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 16:13:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 16:13:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 16:13:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P970kJ/c8/AAAwk0qJkOxd7LVz+hFRuYqwj9H15y74icTjl73W2msxWmca4/eS70EMZMTNnE5GHsfr1/LNDsjK+gHV2FRzw+LGpqHz9JoJzFzzdl/Wf7MHDMEIu86qrqwsGkmFfLWfADuHG9+4L4CcLYNiSTqfNZOkFlNPpiBdhY+AHe7rrzRDwc/M2ihjRjH0iRt/Cj01w5jsrt0JxDDstIybQfD4Z1Jark77uwXFNa85HMZdPPVTaUXKU9q6BIgzj501rZZOJjJIpKwSH5ULmtamqxYMn/hdWqqyRB+Z+28v7bf2jy61rZtAMY5X0Xzp10dekcuhQpvsg3rG7DLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsZU+ju0DFcnFr9zJyt8OtOkS9lqPqpENZpv53z0mZc=;
 b=LP4MkAubW1jq2S3AbBMrO46H9J+27O9CZY251z7J9a2h81mUcxVWvpl75x2DzDX9ftoqOaUymSISCivbYwejalqODgR1hrlMUQTY6chgQQWVqKBSKRZ6TDGNHz7DEDXA778vZ+3qtVaTxM7qHjFYavMwzzaMt8uOglYC3Vla0RF9/217XatszYMarxK4vIFunrSe2rFtxrKcHgZxIr/38VB1K+L32GRqIyypZuqiewC8clG7YTO+KmpjWlu4PP115su1p1KMAG1o4SfKrVb8YWC7AthHBldNRyghcxQXRCyDAbau42CYYvwDiqnpedontu93aXEJvWYqV7de4Pem3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 00:13:21 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 00:13:20 +0000
Message-ID: <47981665-0a97-7919-8eb0-e772e4035f39@intel.com>
Date:   Wed, 11 Jan 2023 16:13:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 2/7] x86: Add CONFIG option X86_LASS
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-3-yian.chen@intel.com>
 <130a0ad6-31fd-dfe4-7b9a-cabb2e726349@intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <130a0ad6-31fd-dfe4-7b9a-cabb2e726349@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|PH7PR11MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: f3142d18-8e23-47b7-b4a9-08daf431cffc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKXnh8ntaOhtfziBmXkKQFdCDA+R682lpNXKhI0MHpR5ZJg2wzipfCSkBGbVoR+Cn3SN5Nn0udMpu8SoTN6UYZXQeEtFVVl4SEzN46w+p9ZH5rJ5TyiPfOSk2KSq1iytjH5yYgMI0IMykQQ6TZjHLTFXJ6wdiFGMqolsjErTBNeL9W6mu5Tp9JVJM44ygwISzjd6Ufqfj7oAalu7u5ZRcujOkHePN+b938Tyy+glR6OMhFIE5soCq7hgM2wn0j+IP/9PQeYyEdr2cXLOgir7u2WZh38viipF+jH51vVA8h6jQHfd7H7eMJmIWEfXuhkO7jrEONOmsXfwTTYtufC2HHvHX+rRJh30OMcXJAe/D5fmeyyRLWzFbKXZ5JXWVhLaPMgB2NpcsaZaBtJaO2fkJJghLziEz0ddhXZWxJwgSrFJfb+AyXbwUgWWxqRtAN55UsX3JirPLYMGfJX+5yYR2evCJUg1azCZjQp2CfdEENlA7lEpMeeWqpsSdrspLpalV9ZLllVHKJTejWJ4wR+tP0suVYNMhBtZzGpEHd9M+9s6JT+UYl0exXxB45WkYfWYbMtDRFTbH99c5vUwCHl2CwEv7OdHd/S86gDOeMPnLij0UzhW3afb0gJxFUglAxacdF7m0bbiSwd8Mj5RZN+9CF/v3kLIIo7nZPncAA1CN2XWEEukuHVsGzMa5bsmPRL4ei9LUFKieSe+wwAKVHgy6TDKULOY/6nIbeTOy2EA8RU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(82960400001)(38100700002)(6636002)(86362001)(83380400001)(8676002)(66946007)(31696002)(66476007)(41300700001)(66556008)(110136005)(2906002)(478600001)(5660300002)(316002)(8936002)(6512007)(2616005)(186003)(6506007)(26005)(53546011)(6486002)(6666004)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjJ1Wnh6eURYSjNqV1BucmlNekhVdkZyWDZ5RjdGQzFHWktIeGd3dlhzcEtq?=
 =?utf-8?B?bFRJMGNSdWRBL3hyL1Q5ZWxSeDZKUGwxK09qSUpLT0xzM1Jvc25kOFJ6bXow?=
 =?utf-8?B?NmhHbkZYc0JUWUpUK05oWSt5TndxekV1Z1dOQWhocmpQd1M1K3laS2ZuZUtO?=
 =?utf-8?B?Tmhka3RRMitCaFp1Nm5nV1IydGlqVThGMGRaZzNMQ1BIUmdyTnVZUUxiRGFQ?=
 =?utf-8?B?ZGdhc3V6NXAyQktSNkx6NS9xSkp2VGZoaGNGM21HMjhJNGg5MmE2OUl6eHAr?=
 =?utf-8?B?ak5uZUlzcC96dmVNT3N4NW1tOTRvTS9xbFdmNytHMTdrakpNNFY3ejhCbGlt?=
 =?utf-8?B?OVhCeHpFaEhqWEQ1L0hSaHVEUmZDQmZNZ1FwYzB3elIzMzMyWUx6ZHMveVJp?=
 =?utf-8?B?cUs3RkNYS0h6RDErRDFiS1VEWlBXR0taV1NleDZBMEExWlk2dFF6czhiWklO?=
 =?utf-8?B?Y2RGNzV6M2RkZ1kvQTZURDFWSVNMLzBUdzFuS2FGQ2JXL3lldndpcldBRTh3?=
 =?utf-8?B?Z3Y1VVpnN3Z3OW5LeVptTmdTUW1JNnM0eGtLRmRyMXFRbzluVFFFbEJQV09P?=
 =?utf-8?B?cUxXT1JZTkpWMER0aEdwZFhqckFlS3FCRmdnM2t1aFV3QTdSQkV5RGIvWXcw?=
 =?utf-8?B?NGxtSTF0NVluRHRTRTBaSlpEb2dQcHZ3ZzY1b1JrTElHMEV4MEx4UEtZVG1k?=
 =?utf-8?B?MUdpcDhwVXh1NXRxcTAvbzNJZk13akFkbURCcGMyVjR2VFIxeDFQQWYyODYy?=
 =?utf-8?B?REU5RnowdDVsT25qaGNzSWpZN1ZGTUQ0MytzUmVwR1BBTUtrL2V1UDh6dFVQ?=
 =?utf-8?B?UjZETklmV0JoUHZtdnZCd1hhSFpIZU5nNitPNjNYUTZJRUIzWnkyQVFDMitH?=
 =?utf-8?B?eDFUTTk5b1VUektidy83Vjh5OE93cG1Sd3JqUkR6V0E0NVNrd3E1eCtPcC9m?=
 =?utf-8?B?NWxxQkc0QW1mdzNWU1pMNkhYbmVGQ2VFdnhMeTRTeW1LYlBma2dwVTFjcmRR?=
 =?utf-8?B?L3NGemt5QnVVV0RJSXY1dVZwR3lSSS9BL0tmZHcxcGpiYkpWenZsWGI2MjRm?=
 =?utf-8?B?Y1I5Ynd1YVVyMXFwdkZyb3V1bkhTS1V3Yjhpa1B5Sk1nRzUyRVJJVWpkMlpr?=
 =?utf-8?B?TFNtaUhNM0RVVGNBbUlhdHJMQ2NqWmlFblVoM2l4aUp5ZkluUXBWYldwSHBj?=
 =?utf-8?B?YXBJa20wUUd6SXhHcXRWTTVOWkdlVkF5TzcwNTNqMnRpcG82c2FPRXVJdTBq?=
 =?utf-8?B?LzZ2dkVPUUthenJnVUszd05ZemloV0tsQ1d6ampjQjhGRE56NVIwcFh5ZS9W?=
 =?utf-8?B?TnVqcGxVWFh6NWxRTnBzTXZZNWgzWkFsVHJ0c0hOS2JYTThlYWRhMlhpYkZ2?=
 =?utf-8?B?bW0wSXAyb1l3TWxlUXBmN0xuc0dwV3JzYk83NDJwMWtYNFFJY3BYTTVDbU5D?=
 =?utf-8?B?U0dJU0ZrYW81ZWdnN0x2MGNZdWVvY3MwKytaS3NDd1FTM2JuTGpGeG01QVpD?=
 =?utf-8?B?eGN2QXpmbzNLYTByakVUYVdYM0xheUNIMzJGY1JNOWNlVTQ2RGRhVlNzMG9a?=
 =?utf-8?B?dVFTZGF5T0ZhZjlMUkRJWjA4cU1ob2lLRU9iOXlsb3FvQVcrWTV2b2VET21F?=
 =?utf-8?B?czJ5MGY1NklSMnpOZUUwaGw0S205UEJBOCt3TkhvTGYzN1FnVmZWZDlLc2FC?=
 =?utf-8?B?WXhoS2k5cFpxeU9BQnZqRWZtUE1Mb2E3ekFuazBYN1dHdWRLSUFwMDlRdHR5?=
 =?utf-8?B?aUZGRFdZWHAyS0hMakV3cU1KREtwY0hjVFppUWpZSHJWL3FGeS9XQi9Dd016?=
 =?utf-8?B?cGIzbFdjRS9JdnlCaG1qUm50cW01Y1pKVXhsNFhrZ1lmMHI0NWpDVGZZWU1G?=
 =?utf-8?B?UExabll0WE9NVXNQSFpCY3VaSTdCeWpJYUNYMnJ4VlBtOVRMbTZOQzI3b29s?=
 =?utf-8?B?NW9vS3l0dUZoMis1TXBYVElNMEFlK2ZwOVBOdDcwL0dtYXh2UmpaRVFmc3Er?=
 =?utf-8?B?ZTMvVUN4eFZoS0lPN0Nwc3VtOGM5cVl6K2hLbFNxMUFMVkI4ZS9DTXVhcCsy?=
 =?utf-8?B?cm92akdTWW91M2VlYWJvb1ZNeDAyMEsxMElJa3VISklGclZDbThac1N5U3h0?=
 =?utf-8?Q?GtQTteEgB6XDpHrFOcNbz1ZE7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3142d18-8e23-47b7-b4a9-08daf431cffc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 00:13:20.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhTZsDZJ323WintZotyC3l6fUaP5oJvOyfkaqqa1THWLjjjKpmsIsoowuWOdp+fJIVNts5xjlpZ8VfI87pQ/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/2023 1:05 PM, Sohil Mehta wrote:
> The subject can be better stated as:
> 
> x86/Kconfig: Add config option for LASS
> 
> On 1/9/2023 9:51 PM, Yian Chen wrote:
>> LASS is an Intel x86-64 only feature. 
> 
>> Add CONFIG
>> option X86_LASS and flag DISABLE_LASS to choose
>> opt-in/out the feature from kernel binary.
>> The second sentence is unnecessary.
> 
Sure, It makes sense to remove unnecessary sentence here.
>> CONFIG_X86_LASS is enabled by default because it
>> is a security feature which should have little
>> to no overhead or side effects. 
> 
> Doesn't it have a side effect that it modifies default vsyscall behavior?
> 
> I am guessing the impact of the vsyscall change would be minimal. 
> However, should LASS be disabled by default at least initially to 
> minimize the impact on userspace?
> 
> A follow-up patch can then enable this by default once the overall 
> impact is clearly known.
> 
>> If any issues are
>> found with specific use cases, the CONFIG option
>> makes it easy to disable.
>> This sentence is unnecessary.
> 
sure, I will remove this state too.

>> +config X86_LASS
>> +    def_bool y
>> +    prompt "Linear Address Space Separation"
>> +    depends on X86_64 && CPU_SUP_INTEL
>> +    help
>> +      Linear Address Space Separation (LASS) is a processor
>> +      feature that mitigates address space layout probes.
>> +
> 
> Let's try to be consistent about what LASS is expected to do. This 
> definition is very different from the one in patch 1/7.
> 
> Also, we should include some information here on how enabling the LASS 
> config option can impact vsyscall behavior.
> 
Sure, I will rewrite this help message and explain the impact to legacy 
vsyscall as well.

>> +      if unsure, say Y.
>> +
> 

thanks,
Yian
