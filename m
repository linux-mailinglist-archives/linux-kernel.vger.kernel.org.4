Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9934A7160C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjE3M6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjE3M6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:58:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56057E40;
        Tue, 30 May 2023 05:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKrhiiT2rTvLPEyu1v0ct7nQzltztXrrU+Dicjuz4S2cwnwGiuAGEXRg5w7PEbJoEI1MmstUQKw9ZifPJnlhivtn1SbPbKFLHYJTzk3xJQglUUf3Nox874UFAafsfvD7nWJKSyLJjMKn7Gtaf1P2jMIZd/9LzTyeCbX81IkRa5ZQoLuzk9bUtRQf4E+ELiqY+ahrjUeERtBcDWbnwUQcsfF38t8Y/CUd5412lG2UgJiJPY5vnYdNDCjKAPRKwZk7Q0UfUStgIMSqV37ikYFDYZPmKshfV18y+rtxqtIVmiUp8VK2+kdjD8GJO0shoPdDdNHDleFUZf6Pzw9Z83taRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1b7HSroptQ+cVDgWRIXUrkmLiWjS5Tc2PHlocSVa3A=;
 b=mAXsymd/ZijTou5SmD/JKKoDxSMEIbhHkcSkf/3Qq+XDCYLpzPiA0oOSWVlhXzQv825/duJM9t2nxaGPeN7cs5bIdtckvXKvi2K56PiN+jETfO8LOVLu/RBI1cKuRH3HdmvlegQaL777HAweK/OXFXWpLoyanDVYh43FWShBBx9/8oHgftoBed8S5rt1JiZpoiYLh23B9pfhC1tdXtGw/M29DfmjJ5FTn2+bYUQtiGkxlTO1OYDAyevbJRiuNrtMR2Pc3pK/nCW6+vCdJ5eyrlg/OgYZxlNvI/4vV8TA+RCQhf51FsXEpG2tuRn/ufUd6leTl2Xvf46I2xb9I9bLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1b7HSroptQ+cVDgWRIXUrkmLiWjS5Tc2PHlocSVa3A=;
 b=4YEh0Xw+r3oRwHKKTNzHFgGhvZSDBYFXjzXop04rSrZk/u/BeERDxSiLsvB4AB9dwYAoh5CxWUxJxE+LDer3vz2zHVov+i/svPfRsAj85gPpf++64UftaMWwZ5DtG/qSNPpk9OGqd65O0MI5kI2hR4RFmw5eCS6CsJjIXdFLKlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 12:57:04 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 12:57:04 +0000
Message-ID: <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
Date:   Tue, 30 May 2023 07:57:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, decui@microsoft.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
 <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 5819fbb8-0a71-4279-c1b4-08db610d5de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkjW60+mzVLtAmRzy7ECmYb32tqWKDfNbmGSpy0LO+mvp/ouDwCjPlQJYNqj8PiqijckOJyhlNJvEDymXGRvPjNjWRhTNxcYGBVQEAD2Ptcb3+gtRWqzif/Gw2ZzUI5gBCjDAec8U2bzaVToPrkK1YvVXb7AUUg6zA4aZOkaWj+yfG4c2aDd8ekrREZGv0W6ClvZyhXMExNG1+H4UWrEVKP3h2ySl7V3opjlQukoRJ7kRjSMokIsC8HxBWt96/p8pv6AxWxzrMNtIy7o+BNq0+utk0doQQsrVrIy7pXdwUlYcmnhnrUdpuHN+k0Zze4MgE/Pfv8SPyM/z092oiZSxTcmQ8vaxnJF+VK+OSarnifyAjK/xfHGXdMKsf4tysTBWGUXwUvvAi+ki49eLiObUl7p7GHgFJ17xE0DF5j1b1ycFeTBnLBOaDXHrJHphrOrhVM2G7eqa+pIVGcG6Mae59Ca/QljzpV8YyZthpOashkfmp4J9e1Ic++/GuvmJ94FliE09V+WD/yIBEP6UzSxgBt0EtzN5nrb2sHyr0NEToYNcGavRCNRrYs2FNX58bVqa0mUzOynkGr0dr6Ad5YCqmH1LdMV8kVMEmEJmMOYpyflkYNFshHGePeN07rbGH7jcFfREWz5dIridIW874xLWUyemxp/OJL3kLmKvlETSwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(31696002)(6486002)(41300700001)(86362001)(4326008)(316002)(66946007)(66556008)(66476007)(36756003)(5660300002)(7416002)(186003)(2616005)(31686004)(83380400001)(478600001)(53546011)(6506007)(26005)(6512007)(2906002)(8676002)(110136005)(66899021)(8936002)(38100700002)(87944012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdIeGdnTnp4RS8yL0pCU2R3dnVKMVNNeDhHNlNLU1BtNFVPMmxkK1lybjh3?=
 =?utf-8?B?Z0JLZlhjNGRBOTcwUmx2ZnZ1Sk8vbkN1R215STBxK2RLMy9DL0Z1b0YzWHpK?=
 =?utf-8?B?RmxVRnRFd2E4YWJ6ZUk4N1V6Zk1UbjByWkRTL09kSGFIaDc2K290RklNaUsy?=
 =?utf-8?B?YTl4SUJDalJiVW55UU1ncndLV0NJT0lvbHpCMFB4L1FvUGtQM2M5NWJVcFNV?=
 =?utf-8?B?U3laMXg4dmMxTDhQUGwvK3pqZzY0SktucXFaZnV1QXYwVXl3MXg0ZXpZUXY2?=
 =?utf-8?B?c3ZSOE5POXg1Q1J1bDRCUCtzdTN5OEtwTUVCMWxNSmp5T2pLcjNPOVNXY1Js?=
 =?utf-8?B?RitwTEZKUVJIRUtGSXNJWjVNZCtxTkFiMkFRdEtEa1ZVQkJ4RHlRREVqdDQ3?=
 =?utf-8?B?TnFqcS9zcnFhbnhJTmVTdzlINlB4RTc1TUV0RFRDUUtua2RDWUQwbVpSWmZZ?=
 =?utf-8?B?MVU5VnE0Y2RpOEJqR1ZzV3RHTG5ESDZ2VkNzMUhuekFzR2F4cXR6QWk0cTBX?=
 =?utf-8?B?L096N0NpQWRPWVVGT1kzNlQ4VW8yOVdXa1FaQlorWTFoWlB6UHU1ZFBXc0cr?=
 =?utf-8?B?cDZBUnppVEVhbk51MFpKZkNLd0NHcldUV1J3VmVBREdBZWFsRUIwQW1MSnFF?=
 =?utf-8?B?aklZNzJPeHZDS1pyVjNLbDAxcURNNTlzSkIwMTlZUTcxcjFrSUZSTUJld3Ar?=
 =?utf-8?B?NzdmLzNxUktHTGZhRlN2Z3RibFVWb2RCdWJ1aEozNzllRnNxZ1RHVDk3QmNB?=
 =?utf-8?B?bHJEOTU5N2sxclNvN0VGMzB1Qjl3WER5QmdPUzlCK2oraDluMzEzR2Q4UGN1?=
 =?utf-8?B?VnNlVmRMSU55MVMreUtDZ3AzSzBPTFFWcXFaTDNyWTVwNlQ1Y2hBdXFqVzli?=
 =?utf-8?B?MTM0ZGpJZkloMDNyYkkySEZVYk9DRStNZXB5NWRYcDcwQlcycVo3dkpKUUR0?=
 =?utf-8?B?OXBEd2VtZEdtcURDUHFpV1ZNV3l4c1VlMEJ6Smthdmx2YXdaYjZxUDBhSmhN?=
 =?utf-8?B?SHBDUUV4WGg2SXFXN0VwclpqcDdoNWE5Si9BdUhEVHZ3b0hPMk8zNHRWZVdC?=
 =?utf-8?B?aGo4SEVkU1EveUg2K3VaZHJ3NlY1VDJ3NTZxRUVQYm1ZaHE0enNpM3ZxaHpL?=
 =?utf-8?B?UStpTnR2RUhBZzJEampwak9ETkxKU2JRemhpNm4zK09RaXplM2Vjc3RrTFd1?=
 =?utf-8?B?dWVqNzlZVXlHMWxOaEVoQXpNZS9oeXBncjFFdmdmMW5kUVBVbHpUMFcyU01M?=
 =?utf-8?B?UDAzSTk5ZHUwZi9LQkVEcmkwVXBnMWphUVhxMktneTV3SEQ2Tm9GVUliTjRL?=
 =?utf-8?B?anVQNkJuNHU0SS9EVFBRL08ycmNiOUZ6RzlFUzJxRFFGWXRwRXdvTG1RcU80?=
 =?utf-8?B?ZTJBak1MbXpkUzE5Q28yNWo4TWpjZG1GWWtLSGFpcG44WUdmNHFvaE5JZy9P?=
 =?utf-8?B?bUoycThKb0QzKzJrRGFWNmZsdVBNNHVDaFJEVjBKZEdXSEY2dmZ0ZjZ2dzR0?=
 =?utf-8?B?R2tTdjRVQVEwMkwrNjcyLzZSV09OREl4U0JhRHJ1RmxQYWwzMlNEWTIwa3Y1?=
 =?utf-8?B?SFlYM0o0VVRuRXhBcVZjV2hLeEt0RytHWDVFWnFzOTc4OEpZOUhXQVpVWlk5?=
 =?utf-8?B?ZC9ROEpuMGx6WkNYOERkejg2NEpiZzhaMGpOY3lBTVhRQm15MDZFSVZJbldG?=
 =?utf-8?B?L255QzNiQVd5VUtLejBSUGNyVThjQnMyMUhYOEF5S1g2d0dOZTFNbXA3eEpP?=
 =?utf-8?B?TWI0MWJVSFlMOW0yRUgyMk93QnI0SExESnBJOXVHSXlaZjRTOEZiUmRqOTBB?=
 =?utf-8?B?cmdxeEcyT0F4aTVMMmUzNFVhM2lzbTdJdWl6VDJjQkcwNFpHcW9YVmhKK2RE?=
 =?utf-8?B?WkZVQzNjS2FJcG1DOEpCYm9yTVpZai9Kdk4zWDI2NEZqRlFKQzF5cUhKdkRK?=
 =?utf-8?B?SlVtZWVpQWZTMUdRNGgvbm93bzArdTZWZkVoTWpwNi9EMnJ0V1Z2cGJldXdv?=
 =?utf-8?B?SE9odE93NngxNWk3d3JzcWJkcEEzMUZibThIQ2Mvd0lBVm94N3czQzV3OGcz?=
 =?utf-8?B?bGl2VlBDRmFCemp4ak5iN2FCSk82ZFNSanBhOVFibW9XenBDeTdseXFGZkJI?=
 =?utf-8?Q?tdEuPfhhfqeO6+wvp+IyTSvIM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5819fbb8-0a71-4279-c1b4-08db610d5de7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 12:57:04.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW6JUNntySpfxDoJ1JKk0vOn0/4KIKVufaPJ9R5pX8rRYAcpR5BnTDQAwv55bhkrSlb5Jd4YzglomLjI7jKYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 19:57, Kirill A. Shutemov wrote:
> On Fri, May 26, 2023 at 03:10:56PM -0700, Sathyanarayanan Kuppuswamy wrote:
>>
>>
>> On 5/26/23 5:02 AM, Kirill A. Shutemov wrote:
>>> Touching privately mapped GPA that is not properly converted to private
>>> with MapGPA and accepted leads to unrecoverable exit to VMM.
>>>
>>> load_unaligned_zeropad() can touch memory that is not owned by the
>>> caller, but just happened to next after the owned memory.
>>
>> /s/to/to be ?
> 
> Yep, my bad.
> 
>>> This load_unaligned_zeropad() behaviour makes it important when kernel
>>> asks VMM to convert a GPA from shared to private or back. Kernel must
>>> never have a page mapped into direct mapping (and aliases) as private
>>> when the GPA is already converted to shared or when GPA is not yet
>>> converted to private.
>>
>> I am wondering whether this issue exist in the AMD code?
>>
>> IMO, you can add some info on the window in set_memory_encrypted()
>> where this race exists.
> 
> I don't think AMD affected by load_unaligned_zeropad() the same way as
> Intel does. But I'm not sure.
> 
> Tom, do you have any comments?

Right, shouldn't be an issue for SNP.

Thanks,
Tom

> 
>>
>>>
>>> guest.enc_status_change_prepare() called before adjusting direct mapping
>>> and therefore it is responsible for converting the memory to private.
>>>
>>> guest.enc_status_change_finish() called after adjusting direct mapping
>>> and it converts the memory to shared.
>>>
>>> It is okay to have a shared mapping of memory that is not converted
>>> properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
>>> stepping on it.
>>
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Fixes: 7dbde7631629 ("x86/mm/cpa: Add support for TDX shared memory")
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   arch/x86/coco/tdx/tdx.c | 56 ++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 53 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>>> index e146b599260f..59cc13e41aa6 100644
>>> --- a/arch/x86/coco/tdx/tdx.c
>>> +++ b/arch/x86/coco/tdx/tdx.c
>>> @@ -840,6 +840,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>>>   	return true;
>>>   }
>>>   
>>> +static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
>>> +					  bool enc)
>>> +{
>>> +	/*
>>> +	 * Only handle shared->private conversion here.
>>> +	 * See the comment in tdx_early_init().
>>> +	 */
>>> +	if (enc)
>>> +		return tdx_enc_status_changed(vaddr, numpages, enc);
>>> +	return true;
>>> +}
>>> +
>>> +static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>>> +					 bool enc)
>>> +{
>>> +	/*
>>> +	 * Only handle private->shared conversion here.
>>> +	 * See the comment in tdx_early_init().
>>> +	 */
>>> +	if (!enc)
>>> +		return tdx_enc_status_changed(vaddr, numpages, enc);
>>> +	return true;
>>> +}
>>> +
>>>   void __init tdx_early_init(void)
>>>   {
>>>   	u64 cc_mask;
>>> @@ -867,9 +891,35 @@ void __init tdx_early_init(void)
>>>   	 */
>>>   	physical_mask &= cc_mask - 1;
>>>   
>>> -	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
>>> -	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
>>
>> I think you don't need to change the order here.
> 
> I wanted to emphasise that the comment is for _prepare/_finish callbacks
> and I hoped re-order would help with this.
> 
>>> -	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
>>> +	/*
>>> +	 * Touching privately mapped GPA that is not properly converted to
>>> +	 * private with MapGPA and accepted leads to unrecoverable exit
>>> +	 * to VMM.
>>> +	 *
>>> +	 * load_unaligned_zeropad() can touch memory that is not owned by
>>> +	 * the caller, but just happened to next after the owned memory.
>>> +	 * This load_unaligned_zeropad() behaviour makes it important when
>>> +	 * kernel asks VMM to convert a GPA from shared to private or back.
>>> +	 * Kernel must never have a page mapped into direct mapping (and
>>> +	 * aliases) as private when the GPA is already converted to shared or
>>> +	 * when GPA is not yet converted to private.
>>> +	 *
>>> +	 * guest.enc_status_change_prepare() called before adjusting direct
>>> +	 * mapping and therefore it is responsible for converting the memory
>>> +	 * to private.
>>> +	 *
>>> +	 * guest.enc_status_change_finish() called after adjusting direct
>>> +	 * mapping and it converts the memory to shared.
>>> +	 *
>>> +	 * It is okay to have a shared mapping of memory that is not converted
>>> +	 * properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
>>> +	 * stepping on it.
>>> +	 */
>>> +	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
>>> +	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
>>> +
>>> +	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
>>> +	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
>>>   
>>>   	pr_info("Guest detected\n");
>>>   }
>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
> 
