Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF9621CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKHTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKHTJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:09:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A3A68C5E;
        Tue,  8 Nov 2022 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667934547; x=1699470547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1zF4U28xx2s8L04lV8OPd3qWGVCWI7ZQmC+3zobsCzs=;
  b=OiVJXZLcZdMldPKYsH4pSMsZ3iVNDxIIt29ENtWkzAUXLHHayus/dBe9
   qPYQSvc66btvzCCQJki6j7aus6H04fDUY+/eXYIGTWn/5Ayy4ffeLTy7I
   HacrKE6NQUVm8RmXPaVSnvzIM3qLqJWUaqIGVjZ4T9Ph+tAZHdtm6daBY
   ZgJQSgWKN4w32ziXImtBhcv0ImjuFQZbSHcpX2XGyGRh+MY3d1jK6GOsH
   2NS7X7rT7jTAGbncwYZDl+MPZWNms+WDf8mYMKdOCh1f+CxCIcXy/Vpxu
   Uc5upCrJEgPjYfvfRkdLjxp2BlAtt4/ECyfXIPhJTGcnFcMah4BXEfavI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="294153083"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="294153083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 11:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="725671674"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="725671674"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2022 11:09:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:09:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:09:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 11:09:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 11:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHW9a+OXZFqD4JUGupu3Y2ofoUgVUMAmxGCoD4gWyUCWjWKyvOya3CqBxVP8j/rTUFE2N+P9YNsVBGRketwjL5BqD/3mdOexgAZG6GzYM0NT/L81npxG93lY9fMVguHWF5ZkdvvNHr+bT6pMCJDdi3HnvPDEuZTWPEPQZRttWJZzE0fMfzCUY8BFWinHJ/wZnZzvaVuwx2hv97zZzBSsD/BS6fQ6leQgjY4p3ZST5hToalcUweqYOidfOKyJJnWxgqAeOz6IO7TtJb6EqIo6AIzHLbwo/Be9yToCD/VoIqUALwC39k1gpP/WIJJw8yOLC1MGc8uC40q4k18VgaQK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSU0hUbYEk/qfKWg9M4o0NXQagbHLVbnRyDwv5Ril3w=;
 b=QnjIOw9WfsfYYlidZCQdYDzmGc442U8/A99M1JMpw0+5KS6P6E3ZOZwptmRniGlJJhaITU3gsYRh8oZBS6VaLOKnY9s7Eg195UdGJ/yrQbgAhGEDbFuYLoZ9DMqu+n4JOmFJD+C+WdWyF/Xgmzg3Ff4j9mZPXttmoUbQHtE2J5rzlmco/QV1uk9esM0wMI9/5QbL4VoktcOBTUGEfUT//r7ehtPH0h1QDtb8w4yxg2M5k9MopcS6LgX/IGniQV7qSnMLtdJ6VGvrDbI+yfUgp7sjQr8/hW7P/vU8BUPrteqo20vXSok4QEiLm9Ek6UdTkXNrp6kasNiAHaMHb+ZO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 19:08:57 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 19:08:57 +0000
Message-ID: <634b7c15-0442-30ea-97f1-070ca5bf91c9@intel.com>
Date:   Tue, 8 Nov 2022 11:08:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] x86/sgx: Add overflow check in
 sgx_validate_offset_length()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Borys <borysp@invisiblethingslab.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>, <linux-sgx@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Micha=c5=82_Kowalczyk?= <mkow@invisiblethingslab.com>
References: <0d91ac79-6d84-abed-5821-4dbe59fa1a38@invisiblethingslab.com>
 <Yzy+jUeCXpYI6QvL@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yzy+jUeCXpYI6QvL@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM6PR11MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 114e614a-ab8e-4db2-8349-08dac1bcafd4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZX1WiDKs7D6sXHOQ/obzKqg0LTSYttzP4X5qExqrq9upvDpkI3wrXh3o0+GcfGcVDGrWvJgjkz06yiQHVJsD7iawCocgppU0cf8tiYebnWYR2m0e/eDoRjxaSow8Q7U7324v5+w2J2fcIy83KeTVJ9PYsI6iwITSiG8Hy2tRu1HJwYq6sutN3O08ixvHkgTOgcmjbOqO/FKWJfu3CbKtcLqzhPNCSOXIzYDg6lA5RJBN8e6juB16+cq79WJlcja89B9xAv4ib49aO6JAdzt870qg2nJvEySP46SwdQm4JfUb5rz1e3FUuMs08q9hvo/p3Mme5FNIL7iS+zis3kaxXspLYQdAn7lwm/vJSS678ftFRyyI0jkIfSbIUYZbqqEBLKihJKXd4FRKmCopIR5VY6jxJ9RKI3+8KVIs/K7RXV2KqJKArKQsOoThiHmN6UkJpBmgUVATcqGdcSLEPHrOMsjewYIfnbGfpMOI+CqRWtu3wCmkORcQftwom62Mt2fRvCuqJ0LjZRhyqfgQltOQ3InD94XMpLq2u5/mqItPh4d8CuFnQpKTP4eQ9SxOB5iOaMyVP7LI4apVbg9viWrPfrb8GPR9TwW8L61YeKcXURMP/M9SnoRff2tJbs2fqnTwFWR4XrNg2hHVXyzPMjemQyU/oKRmTbQG/nlkwm6GFNpvaQVZSeKP5STJ1C3MMqLhFWPkbsra48gt9VzhyEnEx0Rj4XthLOFMKbBdfBjmXrUxESue9K9AjvxJjBIaiSCxxqfe0faajkBXm9vC7Krp2u4yd6iuyjL/Eizgg09XcfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(86362001)(36756003)(31696002)(5660300002)(44832011)(2906002)(7416002)(6506007)(66574015)(83380400001)(6512007)(26005)(38100700002)(186003)(82960400001)(53546011)(2616005)(66476007)(316002)(66556008)(66946007)(31686004)(6486002)(4326008)(8936002)(54906003)(478600001)(8676002)(41300700001)(110136005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJTZk1DYlpwSjdlb2l6bGZLSXlEN1BrWmFFSXdqM2VFZEZEYW1CaGtlZG42?=
 =?utf-8?B?Qld1QnYzREorVWFhQUFaQ1ZDV3kzYmEyakdFdVlabHNWdGFoanBUcldBVldh?=
 =?utf-8?B?MXB1UldqTVliQUNNVlV2bnV6S1lpQmcwdjZyTlNPN2Rna0tBUi9vdFBlK2xU?=
 =?utf-8?B?ODBiOUx4Ti9ERVNVRG5sU1psM2lKTHNDbHFaeVpZWnFHTUdjWUgvTzVlcGZG?=
 =?utf-8?B?eFFOUHlON01sVGpKeTdTZml4SGNpRHlkMWhaeDJRMXFUcXV5ZDBEa3lxajgv?=
 =?utf-8?B?dHQ2R05XSTVaV2F4dzV6NlhqUTN5MEtTak1YbFB1M3BaODkvS1pJeTA2ZHRE?=
 =?utf-8?B?cmM5cnFtaG5vRERteHZkTWIvTHNydjk4MEZGbTZneFZnZFdDcjAyYzc3MUFJ?=
 =?utf-8?B?blI1Si9iMndlV21KLzZ1YjR2ckxaaFV6WXB2cmhEVzNyUEcxWHp5Z0YvQlRj?=
 =?utf-8?B?RzZldUtFaG9yMi9USUZtOUhwVk5YSEZlQTN2UGVNNnBKV3VZb2wySDlxbDk1?=
 =?utf-8?B?QWR0SkZleU43dlNzWURYRGo1TTFjeGVFL1Y1VFArUXNHb0pKMDhyQmEwK3Qz?=
 =?utf-8?B?Zno1UFlSVGlyWTFUa28rUWE0WVBwRGxoTjlMSkI5NVVnUE5pNGh5WWdKekhR?=
 =?utf-8?B?N1N0NnJXQkE5VGRZOE5OZExYbGlic1BXc3REVDBINFdNYzRpalh6ZUl2RzNk?=
 =?utf-8?B?azFZU0dPVTJEekRjKzlVVU1ZRldDQ2E1dzZha0ZoVWdhTDkybVd4bG9qOU5M?=
 =?utf-8?B?TGFHRzdlaW15RnpKczdVYzdMcHkvcE9YM2NOVmJuWHFLK2xWc2I3Ujlaa3Z5?=
 =?utf-8?B?ZXB3VTZKODZQMm5FaGluRTVqUG5zY0ltNG82ZldRdWUvWE1qbEwvRG5ycERl?=
 =?utf-8?B?QUsxT2wvMVI5MzhoTEdaZnMzdUJkR2FnZUcxb3RDdnI0MzgrMEYwYStWTjQ2?=
 =?utf-8?B?Y05wSTE4QnNNTnlobXFGdEQxb0YxSTV1WjZKUGNZSmxCTHZ3VWNPWUhiTHF3?=
 =?utf-8?B?MndZK2l1a2d2V1V5dHV2QkU2R0liYzNWNFdReVhuMWpVMU9ibS9BTjZjQUg4?=
 =?utf-8?B?TGlFKzV4WS9JU0xuNXFQTCtsTE94eXdlTWF2SFgwc2pBVmtYNE9SdzJ2dy9i?=
 =?utf-8?B?NDZyRitITllaRHUvUDhMWnNSQ2g5ZE9FTkhKR0hPTTlkdWw3SHk2Mi96K2Zr?=
 =?utf-8?B?K2Q1THRFUVFwQ0hRUDlQTm85am15SFRaWGFjamVPeFVjWUFHdERLVWJPVkU2?=
 =?utf-8?B?bitLaGxYYjJMK1NvNkR3UkZtNTNBYVR4QWR5MEp1SlRWYXU1cXpGVWRieEdB?=
 =?utf-8?B?RTd1OC9uVlBlcWFXbmMyVkV0WFZvdGFyMlZCN2UvOWF3QVB1cWRvUTh2ZWVk?=
 =?utf-8?B?SWkwdk9FZXYxbVZjYkM3RDdDeGZVR0gyT2dxRjZGMWZkYUNvSm9JdEF0SjNl?=
 =?utf-8?B?MEkzT0tmMU95aUFhdmpUM3Y3Uk95Wkk0TWlvZjI2TVA0NEVxbWd4VXYyWE1E?=
 =?utf-8?B?Sll6RzdMV3VJZXJobTR6QWR6RVJuQlZTNjNZc3FOR21mY2JCZUtrWWlBMUNs?=
 =?utf-8?B?WWp4SHBRWjZCNkxRSWpjSyt0bHFYOXp1QzM5NVJvb2lUK3puUkREUmdwRkYx?=
 =?utf-8?B?UlhvVU1KcFpPb0hueDAyaU1Cc29kWHlRMi9OUERNY0Y5c1c2YnJ3aS9DQ1V4?=
 =?utf-8?B?UER1SXR2MDkwSTdaZ2VwMFZLdUJvaDBNWE1lemJaWVRpcTBOa0dlTldZbGJ5?=
 =?utf-8?B?cGZhWTdwOGlJT1Y0VlpEbTMzNW9GQTNwK3dXVWx4NzM5eU1sQVZFbXJwMHBO?=
 =?utf-8?B?NkZ5L01Xak1uR3U1Z2pMYjlSSGFVZ05mUlRBQS9neFE2RUN3enRxQXpzTlAz?=
 =?utf-8?B?eS96Y254WjJCa3VGNEhWR1lvQ29XemltU0cxSVV2SjBBdTJLU0ZDWTI3Q0w3?=
 =?utf-8?B?OTNEdDFjWDBxUmZiT0RidHpocUFnRU8wSUkxTEZPVldFYW5NRnNya3VkWmN6?=
 =?utf-8?B?VS90d0tqT2ZIWm1rY0JIZjUrU2tocTBRZXZ4YXp3NVc3Y1VFOER0bGFXQnk4?=
 =?utf-8?B?QzZLS013eCtISzJIc2lkNEZTZXF1U3JMZUJrRWNwYkFxbDgzSjdoR2wybHFT?=
 =?utf-8?B?Y1kxR0ducExDdHpKVXVmTWxvclROekI3ZExoSHRRVGE1TkVUNWFWMEo0N3g5?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 114e614a-ab8e-4db2-8349-08dac1bcafd4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 19:08:57.5705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JI+ah7nbFIvvSN9EBMAb+GUi2lkJOf77jcy54xEYRlfmoMsjI2FyjOCZ0z+wHaiMYchcDlgAs30EDiRHd7i+Y6xW0gCXuCHgUYRqJ8pHFHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Move x86 maintainers to "To:")

Hi Maintainers,

Could you please consider this fix for inclusion?

Thank you very much

Reinette

On 10/4/2022 4:15 PM, Jarkko Sakkinen wrote:
> On Wed, Oct 05, 2022 at 12:59:03AM +0200, Borys wrote:
>> sgx_validate_offset_length() function verifies "offset" and "length"
>> arguments provided by userspace, but was missing an overflow check on
>> their addition.
>> This code was originally introduced in commit c6d26d370767 ("x86/sgx:
>> Add SGX_IOC_ENCLAVE_ADD_PAGES") and later refactored in commit
>> dda03e2c331b ("x86/sgx: Create utility to validate user provided offset
>> and length").
>>
>> Fixes: c6d26d370767 ("x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES")
>> Signed-off-by: Borys Popławski <borysp@invisiblethingslab.com>
>> ---
>>  Applies on top of tip/x86/sgx ee56a283988d739c25d2d00ffb22707cb487ab47
>>
>>  arch/x86/kernel/cpu/sgx/ioctl.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index ebe79d60619f..da8b8ea6b063 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -356,6 +356,9 @@ static int sgx_validate_offset_length(struct sgx_encl *encl,
>>  	if (!length || !IS_ALIGNED(length, PAGE_SIZE))
>>  		return -EINVAL;
>>  
>> +	if (offset + length < offset)
>> +		return -EINVAL;
>> +
>>  	if (offset + length - PAGE_SIZE >= encl->size)
>>  		return -EINVAL;
>>  
>> -- 
>> 2.37.3
>>
> 
> Thank you.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BTW, needs:
> 
> Cc: stable@vger.kernel.org # v5.11+
> 
> BR, Jarkko
