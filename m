Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1841C5FD9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJMM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJMM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:58:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4519914704D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtvOGMDw95K/C99iJb0AtCZxDAs2bsizHN5HifbVL0qwjrlnWCB8D5k0USkKMIvWdT6JP89tWifWslFghEyF8qvmzIl4OCxV2TVRNjRIrqLQexcXbFEaOldqk31dYeH4YKZTKh3jJxyTFL+N+7frLIr/3ugsmZukpgIb0Vnh7ebTxnDzpPctQumPT5VXObVl7ynAtrC5RDMDOrNwKtyCeeGUamcwv30Uqha9w5LRQoJZi38w74lUw1PbFqYBpbUAdHVKmcUbKr9/vOdn91Wb/XYjKUCJhKPdutmEIMI79sEGje2ufaGbe8btFtp4MTLMNLu3zTpk4x+Q2wXBY31qDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qF+4dOji3jiabOOKVedCZomQkNTZ/3ei1RoIBm/bPY=;
 b=AYWSWFIx9r4Dm506M+S54pPdryLPukCUZphO1xcj3NseR/Dq6G9Y7BIXXjw7HZ0jbxkqiTJ9ImHA3RAxUXz1n6a7qc1Aq8DNMmmDxfyAMr/sBrLxhZpTbjSAbk6MFnPO6Xp95q+Usto6PCcGEu+aa234AG09epzsUZCYE1YRnIxMu7wD3c0aO0hOZXZi5kRy3sjJxYS02LFp07FtHO+GpFxWkPCMHinxcrev/5od3K32q4FeNyAqfWV+Vkigu43W+GhtUMvTEEC1nMd0xH/98DOc5VnJEdG+ZrvdbDJoQzFXk0zxTUKDOqNUiJKVsui6yt48wmty39WFqHu4aYEusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qF+4dOji3jiabOOKVedCZomQkNTZ/3ei1RoIBm/bPY=;
 b=sdGVP2iqicfJX99JU2sa967mN+6hpYkiRHQUoZyQ5pUQ6m7Vbdf+BmeWcoQBkRq19pPQvzDL0eirGwyyKCfkcQcB8oWyLwMIFNazprhfyn+xKYPuvBkFQdtZvCtcxiSvN7MbTHfW2CPXz+wF07uvkpPzGKg3MPkSNWI8x31njx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 12:58:10 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::269b:c6f1:7b3d:f193]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::269b:c6f1:7b3d:f193%3]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 12:58:10 +0000
Message-ID: <24eb9e75-5f0e-6936-eb29-c2a88b141fdb@amd.com>
Date:   Thu, 13 Oct 2022 07:58:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] x86/sev: Add KVM commands for instance certs
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220902000439.875476-1-dionnaglaze@google.com>
 <669cedbc-e127-92ba-2e98-e0460b45bd4d@amd.com>
 <554407c3-197b-0e52-fc92-9c383a37175b@amd.com>
 <CAAH4kHacW+hd8vB8QgkTjdw6+z-0ngjCqgr=zuGTwqqRnqUPQw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHacW+hd8vB8QgkTjdw6+z-0ngjCqgr=zuGTwqqRnqUPQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:610:11a::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: f57c8edf-abb6-44cd-8a31-08daad1a9462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efFMRzgJ7eicug+K8oiquU75bRFv4V/GpZiHVoOBvVF1UKCJIHKmL0nxvA/UK/1Zt3rnkVAjhZnB4Hre37HnBYjwhjal3C7riqCFXOkGsHq7B5wyM9Mc4zmGa83RyAlI9QlP0PrD6FlG65pSHjqEiz3pdf1sgl3qDNOWrlLMBZmFGlqkoCi5P2aF6mp+VVt0l2hyqA7BC7pIlwM69kMOmPJnkCGmoSdJIhSjOLNpIMOjen3zEALfdDpRYS8yW2HpH665Ua9entGrSOqh7lmgil8j5IQNVkPX2nBXpDlthd1BvmRpvwYBpsZq3nrkIc6NRs4vE+tgSMcfwrYUa3bpEHkHJhoubhMBMEBW1N4a/QZfVB89J4JjOp1+Jo7JlXUg4j/jTS15qwGGEmjBKerdQqGFf3xqvOdjFdVOZ9VmPXmpOJ9q7lzRF0Xeq2vXy8w86ZAaU5rq3w5pz12ESKE7NiZjAxoMvhTpSa5fJrJ3DLm3jjQms37ihyVkOyQK6hhFMsNQ9j0RaMV4GDGoBjP7qdsF312bLR79NSpFU+NQP2ETY1ZD4KTHfGywLU2J77VfXMVEyu5dTqhInl07WClECdmEn30wmndgcSyZ2o6NwNEeqqNhiHtZzH9oVXPqAe90Ys8V5MW1HuqxBgG9PdVZSssDPziIWR+D2iK5UJh1agLOmOdNQek32JO9d2feTE+GDW0zTsXg41xp94KV0/r83rVM70ZAHMzKl48oJYX6vg2HJ47yYwt2KAY++MsX96H6D+AXYd91lsWwLJ1MNvI4r8pC4JX3S2rLBD2FGfTvUio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(6486002)(54906003)(110136005)(478600001)(316002)(31686004)(6636002)(186003)(38100700002)(66556008)(66476007)(66946007)(4326008)(6666004)(8676002)(41300700001)(5660300002)(26005)(6506007)(53546011)(31696002)(8936002)(36756003)(6512007)(83380400001)(2616005)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJqTnVQTlA3S3plSjVzRWg1cEttdktDeEVVVHBkVmdBWkxlY2dmQ1Y2QTRT?=
 =?utf-8?B?L2JYOUdwLzhpc0pOYTFhZHVvZDhkM2RReFg0MW1SQ3UvUHRoQTdIUURjNXlw?=
 =?utf-8?B?U3Voc0JpaVdpS1VmTnFacEtRdEtsZjVpYzBVSzI4SVJ4MVJyUC91bmIvczJ2?=
 =?utf-8?B?bG5pUWl6YXYvcXJPZ2ZvU3ZvMTF2dXIvdXYxT1JlV1ljanFEdWhNbVFjVU13?=
 =?utf-8?B?VjlQVEEyTk5wUzR0dkNybk9mcU5FVVJHOTcvQ2tVVnIxNDNEenJEYWRlVlh4?=
 =?utf-8?B?TUpPYjczcW1Lb05XeWZLMkxOblRFT0ozK3pGdWFTcVBYRnVpNVpldkZOM1BL?=
 =?utf-8?B?dEQ3T3FaUVFqTFNNR0FFaUp6cnF2OUYvYU1XMFlDNzlyVGtZMWJkRkR0RmEr?=
 =?utf-8?B?RVBWRTVkdFFrMGhmcXlSZ2IwdkF5WjVXTU9Rd08rb1N3eUZ0aTZCZ0F2Mllw?=
 =?utf-8?B?RzRJN2kwVm9QWFczQzVSOG5oNmNEWUFOeWIyRk8vWXIzTFp0blpKbFRZNWZz?=
 =?utf-8?B?dVFGSm9aVTFNT2NJTUFkY1B4ZFFud1lpZ0ZiNmxNZkRBK09tUy94YnE0aTk4?=
 =?utf-8?B?TDIxNVZUNVY2dzl3QzNESEF0M3A5NDUvbytJZzhaRlVoTnhHZVdiYnFFQlIv?=
 =?utf-8?B?L3Q2a0NaaURPb0Nma3NNZkc5MWF6RWhhU051Tk1HeVBFeHh0eW11OWRlczYw?=
 =?utf-8?B?VEVQYU5yVDZqYmlOZDRPemZLQjMzM29wUEQrb1ZYUTNJZG02QmhJQ1JaeGVs?=
 =?utf-8?B?ckhoT2pOeCtWa2dxRGN2OWx1QzVqQmtEdm9MNFk4RjU1MytKR2hZUHhpNjEz?=
 =?utf-8?B?d0JCTzFTa2dIemZ0dXNSUnRqd0tiOEFRZlR3TmRzUGQ0WjV2SEJNY2srQitp?=
 =?utf-8?B?ZHQ0RHJ0THpRUXRDelhhTlN0Q1FPdW51RElRRWxyUktyN0wvL2taNzczQk9T?=
 =?utf-8?B?am96cVJ5OFhibW05b1ZwdjJmWUk2SUtXb0kyL2RhZUZUZ2o3b3B6RFBCSllP?=
 =?utf-8?B?ckpacHlUeHJicG90cXgxeXkwcVNSQ0ROMkZPdVJpODhhN3Ixc1RSSTYrS3Q1?=
 =?utf-8?B?RUtSV2xqWEpuci93NWs1NUE3NEJOamJCSjlESmxmOU1oc2ZOc1ZQTU1qL2Rr?=
 =?utf-8?B?NDBaQlY5UU1SZTZBclFIeVN6ODFhNDBFRnE5SEtyNUxsdGt0YzF0K0dCUnNF?=
 =?utf-8?B?NzZndVE2eEtOYm9ub1A4emhpcUMxK0h3Rk1aTWdXeEs2TkdyYXlOZ0xseEtn?=
 =?utf-8?B?YjVrd0RLRTZ2bnQ5QlRmTmowZm5WendjUEhiaGNFcGUwWVlvV3pQUDAreDFN?=
 =?utf-8?B?enBlVmZ0cXFYZ2VpS2RYVnZhTmdQWU9ucHBubXgyNk4zN2F2eGFDUGdWZWg1?=
 =?utf-8?B?amZNckk0Y2FzdHJKYXZoUm10MHNwZ3VSYlI4dlZ5YXlIWC9EdGlGV2R5eExC?=
 =?utf-8?B?Z3RBM2x5NmpZOWdYc2Q5cWNQZVBzdkJnSlh4cjlLZnJaOWlaNDRCWFBiTE5s?=
 =?utf-8?B?QUNnSWk5MjlIZVdSYkNDOS83K2toTTVVMGxlVjkxcy9SVFJPOE9sOGtzZ090?=
 =?utf-8?B?TVovUzB1YTJLcjdURXR5aUE1L0ZpakszN0pyaXhVUlNTUFV0Q3VnS2JoSVpW?=
 =?utf-8?B?ZzFJRG56YmpYY3RqRnJ6bkRNaUdod09uQ0V5eGtxYnQ2YWZvOHRwNGZJMFpr?=
 =?utf-8?B?dVA1ejlCVUVtcTM5Tjl6OVhkbDA4S21VZGxtaW5qWmZjL3J0ZmNRV0QzYnIz?=
 =?utf-8?B?R2dzMUZ5QjUxRVZFeVhrZ01qQ3Z2ODVjL0VrOXg0Qk1OdTZwTVRkMHd2R0xi?=
 =?utf-8?B?Ukk1WGFlN050cTFVLzUwdStLdURielBsY0tqaTN5c2Rjc0Eyb2laam93anBC?=
 =?utf-8?B?Y2tWUnVQM0JuQjN6VXUvWDIzOVYwWUd0aWJiTldadnM3SHpBaGpEd3ZxU01D?=
 =?utf-8?B?MjN2TitnV25xOElCWkx5U0ozY01FYkY5KzN4L3FMVGl1UDVPaloxYmZsbUpk?=
 =?utf-8?B?b0d4V3hzb2Z6blExTEdKeUVEM2hUazQyY0xIVVFXcnlwU1pzVXRwS01qWHhJ?=
 =?utf-8?B?aFQ2NERBUlhnVEFtMUdkMHRpMGdXL0xaQnB1NWRtNGRVZC9DT3Z0UG5WakNJ?=
 =?utf-8?Q?o6lvhuuxvhqyuyxOmHJP4ptbd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57c8edf-abb6-44cd-8a31-08daad1a9462
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 12:58:10.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0FEuvu5Xmk862WP/ufnFQ0qRErTrZQE7qVBmKezo0JzwlSZ5nb7+sKLXAjUyoCkrnp3A/XUeTpFBR+n5GIKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 20:02, Dionna Amalie Glaze wrote:
>>>> +    /* Page-align the length */
>>>> +    length = (params.certs_len + PAGE_SIZE - 1) & PAGE_MASK;
>>>
>>> Probably can use PAGE_ALIGN() here.
>>>
> 
> Ah, thanks. Will add in v2.
> 
>>
>> Though, one thing i don't understand is that why do we need to issue
>> the SNP_GUEST_REQUEST to FW if we are going to return the VMM
>> overriden certs back to the guest ?
>>
>> Thanks,
>> Ashish
> 
> If I'm reading the spec right, certs are supposed to come along with
> the guest request when the user issues an extended guest request. If
> the length is correct, we issue the command to get the report and we
> simply override what the psp returns for the certs.

The SNP Extended Guest Request doesn't override anything from the PSP, it 
just supplies additional data associated with the MSG_REPORT_REQ so that 
an additional call does not have to be made to obtain the certificate 
chain needed validate the report.

The idea is to not have to make two calls, since, theoretically, it is 
possible for the guest to be migrated in between a MSG_REPORT_REQ call and 
the call to obtain the certificates, at which point the VCEK would not match.

Thanks,
Tom

> 
> Is that your understanding too? If so, are you saying there's a bug in
> this implementation?
> 
> 
