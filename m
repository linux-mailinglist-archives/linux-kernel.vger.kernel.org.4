Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD13720822
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjFBRFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjFBRFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:05:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7A1A5;
        Fri,  2 Jun 2023 10:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLpfqch2IU4M66Pc5FKvs5jDGadb9Kux7O5KUuO1fo+y45KkgPahh338x7KQ48PJqMUiNdTOlPgnsNuj6avwigM38ZuJ1pRN2l2TPclUde0HgYr61XvftEaidZ2ftOQve/VrSjo5xR63u22nCFaQAvW2Svx+oNb2nLJh2iOEN7ykqHIRyEFoG3iSpx6HXTnHEUhHAxbkzt+NHhYROn7VeFk2REKYtikCahFI09HUTOzsZfIvyzd3DWSdcjmHwQ+65d4z0brUfs27FAIdUrzSOZ2O9HyZkM91F0qWyjxVRzIr6/G3x1a2jOrgrH9Hri4jU0dw/YJPQxVSN4lzsJaxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh5MrlMg4aEM8znYcuWU/wS2XsNKEskXmeOAQherkDQ=;
 b=HAxRc+K8bavjKe2b3e/f+iqT8tOaXHTHXEQ6Hj+HaoP1PZXGs56REgi42OuULnBiBICBibnedgJSncfCY2GeGUvsAXW6i6ZviYzXps0BqluXpRruf5rdAoJAwLo+H4zTW+GQy+kR+TGgY2WGb1yUZ3uVyRLPOmcEXtev9jcjZxuCzlhHmvArv+2RW4Fznv1SeOvza50dlI7CKCW1eReC4oBW1TTlDWGjrXcengxTv2FKJUEA8aBwvOMKHs/9O2v2VaVKjHHcG5tepDIAfb1RlNStsw/negtan8WJBGkXabtiDnV3f9pT4IzrqjWTzeH03l161hNb1Lt0Af+PvF6eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh5MrlMg4aEM8znYcuWU/wS2XsNKEskXmeOAQherkDQ=;
 b=Iqe5EE/SUDJ7V4JQyku97VGH11u1mpYgeiKm3tsq4yrN/FP1+7xHlwqOY50ZSANqeF/kpLiUBguIz6z/fkPblLGdtpRGr8EM4jhA66R64VNJbHCv8JYHLaJcAoQq2IwWDNaUage4MY5URRnkqJ6Z8OSWLwX557cZJgtQuzIdpaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 17:05:42 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 17:05:42 +0000
Message-ID: <757c8df5-7ba7-1ff4-40b6-a1fa69f0fa37@amd.com>
Date:   Fri, 2 Jun 2023 12:05:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
 <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
 <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
 <2d8ae093-dd9e-ea49-d6f9-3fdb2fb84e4d@linux.intel.com>
 <BYAPR21MB1688EF2A57E90FCE02B82F84D748A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <9fbc3760-7239-2323-ed90-210a0de9e286@amd.com>
 <BYAPR21MB168826D6C870542E5BD3372BD74EA@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <BYAPR21MB168826D6C870542E5BD3372BD74EA@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:5:333::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: a220e4d8-f7b2-4b1d-6c35-08db638b9915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9a5HLjlXNxescBvhL1K6ew89rWvJDCXZ0qBPP6zTsyIRQ0nn+Uvmt7+1whsH4s+kz74jK896/SWAVnfvZgpviqo2DE7LRoFCsZKnxswKVvMy9yFdanQcF3IMVakSh8KCwrju8uENQy2Lu4B+o/Oromzj4+Snzb5FNhUtksX6Sr5LH5+BHOsWpFpbzb4VxARoF35ArKp/9//wYs+PtaRu7H+X4hKhnoE0VEoiV3SfRgYmnc6nisbY1AxV4tUayhiIf9uWWqHBVGh3179AB+Dnp+99wxDaCy65+MU97eop5xHRSsY3MdguEJW+rqMj8X5i4eRPlbw0ouE8kC7rZSkryPUedBMo9LW5QLq4CHVqQz5vr3qjiPcaW9OO/GKinz7Iw1O8RPVa3Umw8Y7nRZe6AYQ3aIn1mQ6Eq0FjRg5y3sE/yvBBkbDCSt/W1xTidH9hwkjRQOuvrQ+uERgUs0MCk9p5QZCrco1h6k8gOWkTo8JjQlk81kAy/25GTC1EwlRcZDPE8tb40SY9trQUsA3CfwIo+7R4tE2Td1THu6NH4bFzIPWJpY52li0auOHLB6iV4Pi52LWrModflx7GIPaPY5i9WDVD/g/KGSItePXzhcQ3RMbj5M9WQ1R8r6sDYc57ZJGOPpDnt2pLUU1aky4mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(53546011)(6506007)(6486002)(6512007)(26005)(186003)(316002)(83380400001)(2616005)(41300700001)(2906002)(8936002)(8676002)(7416002)(5660300002)(66946007)(66556008)(66476007)(110136005)(86362001)(36756003)(54906003)(478600001)(31696002)(4326008)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzRFM2VxYUd0UjRaR2pJaUw2a1JhZmlUZ3BNVnVpOU9xak51UkduL3A5NURm?=
 =?utf-8?B?MWREVWgzS1N0cnBMRE1PZUgzMnZGNDlENDFCaUMzZTRBY2ZZaEV1VkR3dlJt?=
 =?utf-8?B?V0t1UlVTMVN1cUYveUxsbHlkcmZNdTBSNFd6dWdGUklNMUxzbFJzd0lmUDdV?=
 =?utf-8?B?Yy8zaERPZTdWYjlzdE15bkJ6SmVielNnUDNyUmpXVVgvM0FVR3JETE9jSUFU?=
 =?utf-8?B?VUlsNmE2aEo5VEozRlZvclJTNWwzVThVaUd4SEJLT3VlYXcwSVJTK3NsSUdE?=
 =?utf-8?B?OVhYQXdXSFA0WWJLMHFQcXlGdnhUNjcyeEU1Qnc1VWNKZXJoMUlsdFU4eFNo?=
 =?utf-8?B?cWZxN2dpLzcrUUFYSk9jcWpMemVyODJoaGQ1czNrUlMvWEpBSzA2Tm5Zb1pD?=
 =?utf-8?B?V1hHcXRDeUI5QmFzN1IxWlVoaTVudW5aTTMrdTNZcFVFdGRnSHdKTzdaWGJn?=
 =?utf-8?B?RWdPSUgwSDlJaDVqNWFCNlF5U2tEZGE3UEhhT1BidWxnK3A5MjFvNGVGNk8z?=
 =?utf-8?B?cm1MRVd5K2dLSjV3Y1dBNkYwQ291bTlWVWdEMjFLazFycjlOZ2NRWTNOVXI0?=
 =?utf-8?B?aTJ5NloyQ1c0MmJNL0ZrQi8wQi9YbXk5YnBnd0Z3L3VWeUU0OG56U0FJKzBI?=
 =?utf-8?B?QkJXeGlWVGIwSVkvTGR4ZjZjenlmdHpSSjNJZVZmalA2OTd3MG5RZm1teEZS?=
 =?utf-8?B?YXVhQTNuSUZpaW5hS2F6K3BzUEFWWjNGK3krVVJDdzU5Q3NVWEx6NVFrd3dB?=
 =?utf-8?B?SlpSQVJwUHRtbzhLNm4zdTFQNlJZbjM2Y1J6UkRlZkJxSW1USlRIelh5REE5?=
 =?utf-8?B?T3JKMW51cHQ1bVNSTVo3Wm1DUytjcG1lMTFwUTVnRG5YbFVzT3NsNmc0NUJR?=
 =?utf-8?B?R3NqWC9kMVphOXRaWDZ0UEl0dUxvamw5c3UxVjh0NytucDMydkx0V3IyL28w?=
 =?utf-8?B?YlR3VzhCdWhnYTVHTmlIdG5XT0RWYWExSEtUbGZsVFRleURmTWhXbFFWM2sw?=
 =?utf-8?B?U3FiaCtKMUxXelhnV2dvZjFFWUJ3NWVydDF5RHV4QUNRQ2djdFhJc3o3OEtW?=
 =?utf-8?B?aGlQejJMVEpaNlJjbHVvdEdvNGdnSXI4QWRXVDc5VnB2QzNhM1QraXBaaG1J?=
 =?utf-8?B?amNTQ0FHV3VlUEhmWjZkbVlaNVQzck9Na2dQTmVsQSs2NjhuWXRDNVE5TDl4?=
 =?utf-8?B?ZzlDZHJ2OG5GYVNnM05zUG50MGJ0RnRlU2NXSXp0WWczRzUwSTJ5VlRLeUpD?=
 =?utf-8?B?RnBqY0JUeUtOT1lIcko0bG1RM0NlU1hGL0VTc3RXMmNKYWkvSU14VThsQ2R0?=
 =?utf-8?B?VTVBanpQenBSZzE1NlZUV1VqeDdmWnJWOEFzRmRRRlkzTGFKZDEzRjI4Q3lD?=
 =?utf-8?B?Q1F6eU90eTd0aXFia3ZGUFozQyt4OGxOL0hETmMrZ0c0YkpRN2pQU0Z3bjZn?=
 =?utf-8?B?UzZ1bTZFdXV5a2doMWt4MnpPU2R2UDcwOVJPSStycHRWNmI3VFVhL2tmMytl?=
 =?utf-8?B?cW9ZNlNJMmFnOEZXbjdzblk2YkZUOGQxcUszcEEwUmJGNmg4Y0FkNXBPdFdU?=
 =?utf-8?B?UmdLM2xWRGVPQ0FjVkUvbm1aNmMzbTlhSUZBRHU4dUI2VU5WRjNld2JraEVy?=
 =?utf-8?B?dDd6bGpuNVUvYVdjQVJJMWJHcWxaQWZzNTBvdElGa0Nqbmw4SkkySHRKS3dm?=
 =?utf-8?B?UGxLR2FGT3VJY0dNRXZTUWtzaVFEN0crRUxCYnV4UGZZMHFMMjdzNUpFdGxW?=
 =?utf-8?B?SllIYVl0aFpkOCsvSld1V2owQ2luZ1FxUmVYWVZJK3dPeU0vZ1NpaGdCZk1U?=
 =?utf-8?B?ZzFLenlUQUtrVFJrMlg0R21LaWFVM01ORlUyUnFXMDlPblhZeFY3ZnlxT3R4?=
 =?utf-8?B?YVNNOXZnMjN2UnNPSWFMMkpVU3kxSWJTMi9DYlU5em5FOUZBL0d3MHBENTFu?=
 =?utf-8?B?ODRhQlB5aXRQY2NIL1Z1cHhjamV2TmVZa0dpQ0tpN2Z2QU04SGNWbFZLdnZP?=
 =?utf-8?B?bVJQZG92eUNUWkhXeGJRNURNMzhseS9rZE5ocDlkVWpHRDVVOS9CR1dodjZH?=
 =?utf-8?B?T1RYbUh4L2k2LzAvQkNONll5QTVzT3lxMDFxVStMd1d1TnBVaHQ0eGc0RmIz?=
 =?utf-8?Q?kOjUV/4hPNP9d/ViSRuo1EGc0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a220e4d8-f7b2-4b1d-6c35-08db638b9915
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:05:42.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bTQ89akRgF1YopC481M7Oid72GlVCYXTWaOahgZef2hknIGgVzTSofYDz/nvN9TIAIQiniwiKm5hgYWCxxlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 11:11, Michael Kelley (LINUX) wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com> Sent: Thursday, June 1, 2023 11:19 AM
>>
>> On 5/31/23 15:00, Michael Kelley (LINUX) wrote:
>>> From: Sathyanarayanan Kuppuswamy
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Sent: Tuesday, May 30, 2023 6:22 AM
>>>>
>>>> Hi,
>>>>
>>>> On 5/30/23 5:57 AM, Tom Lendacky wrote:
>>>>> On 5/29/23 19:57, Kirill A. Shutemov wrote:
>>>>>> On Fri, May 26, 2023 at 03:10:56PM -0700, Sathyanarayanan Kuppuswamy
>> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 5/26/23 5:02 AM, Kirill A. Shutemov wrote:
>>>>>>>> Touching privately mapped GPA that is not properly converted to private
>>>>>>>> with MapGPA and accepted leads to unrecoverable exit to VMM.
>>>>>>>>
>>>>>>>> load_unaligned_zeropad() can touch memory that is not owned by the
>>>>>>>> caller, but just happened to next after the owned memory.
>>>>>>>
>>>>>>> /s/to/to be ?
>>>>>>
>>>>>> Yep, my bad.
>>>>>>
>>>>>>>> This load_unaligned_zeropad() behaviour makes it important when kernel
>>>>>>>> asks VMM to convert a GPA from shared to private or back. Kernel must
>>>>>>>> never have a page mapped into direct mapping (and aliases) as private
>>>>>>>> when the GPA is already converted to shared or when GPA is not yet
>>>>>>>> converted to private.
>>>>>>>
>>>>>>> I am wondering whether this issue exist in the AMD code?
>>>>>>>
>>>>>>> IMO, you can add some info on the window in set_memory_encrypted()
>>>>>>> where this race exists.
>>>>>>
>>>>>> I don't think AMD affected by load_unaligned_zeropad() the same way as
>>>>>> Intel does. But I'm not sure.
>>>>>>
>>>>>> Tom, do you have any comments?
>>>>>
>>>>> Right, shouldn't be an issue for SNP.
>>>>
>>>> Thanks for confirming.
>>>>
>>>
>>> Tom -- For my education, could you elaborate on why this problem can't
>>> occur in an SEV-SNP guest?  There's still a window where the direct map
>>> PTE and the RMP as maintained by the hypervisor are out-of-sync.  If
>>> load_unaligned_zeropad() does a read using the direct map PTE during
>>> this out-of-sync window, isn't that going to trap to the hypervisor?  How
>>> is the scenario is handled from there to provide the zeros to
>>> load_unaligned_zeropad()?  I need to make sure Hyper-V is doing whatever
>>> is needed. :-)
>>
>> Ah, I think I misunderstood this when it was being talked about. The issue
>> SNP would have would be between setting the c-bit but before the PVALIDATE
>> is issued. Prior to the RMP being updated, referencing the page will
>> generate an #NPF and automatically change the RMP over to private (in
>> KVM). However, after the guest is resumed, the page will not have been
>> validated resulting in a #VC with error code 0x404 being generated,
>> causing the guest to terminate itself.
>>
>> I suppose, when a 0x404 error code is encountered by the #VC handler, it
>> could call search_exception_tables() and call ex_handler_zeropad() for the
>> EX_TYPE_ZEROPAD type (ex_handler_zeropad is currently static, though).
>>
> 
> Tom -- Does the above sequence *depend* on the hypervisor doing anything
> to make it work?  I'm not clear on why KVM would automatically change the
> page over to private.  If there's a dependency on the hypervisor doing
> something, then it seems like we'll need to standardize that "something"
> across hypervisors, lest we end up with per-hypervisor code in Linux to handle
> this scenario.  And running SEV-SNP with multiple VMPLs probably makes it
> even more complicated.

No, it doesn't depend on the hypervisor doing anything. If the RMP hasn't 
been updated, then a #VMEXIT(NPF) will be triggered (see APM vol 2, Table 
15-39). The hypervisor is free to do what it wants with that, e.g. just 
resume the guest (and immediately take another #VMEXIT(NPF), possibly). 
Since it is a different thread/vCPU trying to access the memory than is 
changing the state of the memory, eventually the guest kernel thread that 
is changing the state of the memory will issue the page state change to 
the hypervisor and the other thread can continue.

Thanks,
Tom

> 
> Kirill -- Same question about TDX.  Does making load_unaligned_zeropad()
> work in a TDX VM depend on the hypervisor doing anything?  Or is the
> behavior seen by the guest dependent only on architected behavior of
> the TDX processor?
> 
> Looking at this problem from a slightly higher level, and thinking out loud
> a bit, load_unaligned_zeropad() functionality is provided only for certain
> architectures:  x86/64, arm, arm64, and PowerPC 64 (little endian).  There are
> fallbacks for architectures that don't support it.  With two minor tweaks to
> Kconfig files, I've built x86 with load_unaligned_zeropad() disabled. Maybe
> with today's processors the performance benefits are past their prime,
> and running with it disabled in CoCo VMs is the better solution.  Does
> anyone have a sense of whether the perf impact would be measureable?
> 
> If doing the load_unaligned_zeropad() enable/disable at build time is too
> limiting, maybe it could be runtime based on whether page private/shared
> state is being enforced.  I haven't looked at the details.
> 
> Thoughts?
> 
> Michael
