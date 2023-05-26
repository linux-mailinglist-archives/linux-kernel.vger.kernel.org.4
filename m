Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1D712737
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbjEZNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjEZNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:09:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D89F12A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXs/JXLDNQywZdS5XvWjkHRR7tU/SZ+VR9ZK1hmrejcJKyimNeO7aeNK9xj3RlzzQ/vazJEKixu2KDLjv9isJg2903Qu1B0jWHUHL7b44fKRSUhD8lQ93H1Xnnk6hLSXImKy4cfo0+nWxYihzwIg9V0+A8UgXko2IksJOwJln2As5DqV/eElPqV+lPE4HUp6E1Lt+qx2jCZOR41DD80pyyIAVCbSrw0ijgslnPfOFNqLQqAD6+FvhU5DqdyAt6ztjC6Zvan4ogHiVqSLCEY+BA7RmowfBey8IHfycFXE9k0QR8EnE/HbkNENErtg1voK09ntvvXa81M4tBD5UK9q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xk6wrEPFM/zSdTwqKShweu04ec9wmoxBiVYPIKcZDo=;
 b=B9yq5AKv+gBpFTqX/EUg/fBfh1J4gGtxGJSgEkeJeDfF32UzTHeljMzuOsmC8903xIrWik38ySO7fXPtogFHDJjAMDsryIEMRGcenmTLy5+Ra95gSemUJPTprCo1/yW+aZNy50XAEuYy5QHvjCOySj9aiJr0ybM1hHbIXVhSG8MOdKd8IXhIg0Ld+IwM1f7EwhhqeFkxxyIsBKxTFbbZSb5rznxD9qrOp+4/4FVUgC1aEYrXOJGzQyr26JobFKlSUs3OT8rKWjmuPyHsYk0UbQ5z+kBsAV+7ZhFs4LIihCng8uKOKMmEmPAPG8cptgfOOkNdp7gsyNIly/muZgfAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xk6wrEPFM/zSdTwqKShweu04ec9wmoxBiVYPIKcZDo=;
 b=wshs8kOEk+5gWtLec+bqM1XMbAnKm/B/EIU9OEWCSEowlKYXZLaFnq+BH2dEUEkpCJY3zTXxKN/XwgAxI+zZUzJQH0tmEPwGe6AbMZ9ljaWEfw5zYSxzSr/GGTPjDxQWCp8k6EDtw4n4d5YYd1xwvxMm1Np0GM2JQMArYrrtIis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 13:09:19 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::67e:11bb:a322:98e1]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::67e:11bb:a322:98e1%4]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 13:09:19 +0000
Message-ID: <8a250f71-bd21-a0a7-f1f8-5e6a3bffb18b@amd.com>
Date:   Fri, 26 May 2023 08:07:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/head/64: Switch to KERNEL_CS as soon as new GDT is
 installed
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Joerg Roedel <jroedel@suse.de>
References: <6ff1f28af2829cc9aea357ebee285825f90a431f.1684340801.git.thomas.lendacky@amd.com>
 <57e7b3df-5ca3-b400-d99a-a430bcc35a7a@intel.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <57e7b3df-5ca3-b400-d99a-a430bcc35a7a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:8:57::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW3PR12MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: 83de7c5e-6b51-4bb2-5210-08db5dea6a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSFtjjeEYr70bMFiNg7RrCk+qHOklX4EJ5BO8tuBrb/ObBjAKlghOelEBzqwPVnXUyfIHbHgSPvkLD/P0xFSIhy7hLUzNPJV2gbn5f98m2qBe+bVPJEI8OZr8QKA+PgmOHdiHFU2FEUiV4CWBeLzBs19QSUs1sLG0fED4541Ss5nqUg6x2WifRNbbdHiXYUUaAGsEvV3kU+3E+Y31iE69oeyA62lqA14LNLXUA3h0pOnu2Nv3h9pAUynq4m1WWrqOeTGupg9Mb7N98fSxpDSv5lXPqWSKPf/BkSyogMEdjC1Zk9QS2yAE12HNHKTz/HGwQbcj0rsoKmv6T63pHyhRNkYif2XecpVVPzRsKyuw+ldJd/6tAVvXLOsw4oEXr2ny8RRR+lf/14fQzzSNfLcfBua1NSVA6vhmPSOvgPqpCj4AUCktpvw+Qkaj+abHyQYUUGKOuWtfOTqCl7T1+rCg8ANQGGm0sAnK9Gc0VDGvjJa+EIxk046fGNRD+lgtJ/4AlMWEqGh1nCJP+7IlzryyDNVFsWI9YgaMwj2n+57+PPhWMlT0M4tfmeXWv4L+xHQBlsdZoNHJqdR3RIJRuFaUhyKz3vHWWJfJm0MxLPs30/suTPQTuTuxHvVZD4DlQL9rUk2FBUrwUn/QFJt7Dq8SK47OLdtJRYDSC1I2OAZOzs3ON3T5fpPzbySmNqROHm4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(86362001)(2616005)(2906002)(186003)(66946007)(4326008)(41300700001)(66556008)(66476007)(36756003)(6506007)(6512007)(53546011)(26005)(31686004)(31696002)(83380400001)(8936002)(5660300002)(966005)(8676002)(38100700002)(6486002)(316002)(6666004)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJ1YkVLTmtENFZDTVk1WDBuSmJUWFdGcTZxQlhEQU00U2Z2bDZ1NjYvRmhm?=
 =?utf-8?B?TFdBYzN3dkdzTHJQVUFtZkpiekJsVDRLQkphR3RVOXVQZnczeWxhT0l4T0Q2?=
 =?utf-8?B?WXdYZ1Y2MDNUdEdsMngzNTlOSDBrY0dnblNKOUhxL1YvNk1oWDdxaXNpK0t2?=
 =?utf-8?B?Z0JzbThRR0ppV1I2Y1dpL29TZ0xDMGcvZFJaZnVMYlRTUE5MN05oRGllRFo3?=
 =?utf-8?B?MWR3aFU5QUkySmRiYXlabzBsdUczWStQSC8rbDhEN1EwL1J2US9JOGxQVlJ3?=
 =?utf-8?B?MWtDZHNOb3FxSU5tS2hUQzlKaWFpNFhJeUVLbVpxaUxLMFNvV2NwV1JSbUJt?=
 =?utf-8?B?dkVmRVYyUjY2b3JkOGgwRmRqWHZUUnZkU1M1ZlFsdkY0OEs2ZGpXMDE5ODBT?=
 =?utf-8?B?RDFVZ3JGZHNWQXFUcWRTcVgvM29GaXNmWWxIRkVsN0h3ZS9Eb1NVMGQ5WmhR?=
 =?utf-8?B?Skl3Y0Y0NE1EMmNrZGswRWZDaW12SW9ISmJzQzNpa3Y1WjNxZ1U2dEtHOFFT?=
 =?utf-8?B?c0ZGc2IwVmpCc25TVGtGa0tsYUZPaXVrQ2xrY0tncXFVODl5YnVkWEttOC90?=
 =?utf-8?B?L0E0UEdhTFVOSkptSzVLN3NtSytMV2x6QVdnQndsdFVlc1ZxTHdKRVQ1MkRS?=
 =?utf-8?B?MVFsdjFPcVNwdko0eW5JWk1iM09CR0RtdCtyNVpna3NWMy8wT0RielhMZmVs?=
 =?utf-8?B?SS9LOHg3UVNvbDE1Z0pscHE0L28zenM5ZGlmNnZjcU5vV2h4aGJTMFpValhy?=
 =?utf-8?B?Zmh0YmV3emRpOHVnRG9pWFc1QXRCYlNUTHBJb05LVXREOUZLOHJBZ1JhZzNG?=
 =?utf-8?B?N3ZITDV1SktSZkR3eEdCWDNYc1U5Y3J5bURaVXEyQ0FVSUowRWpMVkIyTm96?=
 =?utf-8?B?Sm5mdUdCQmMwQWtVOC84Qi9SUllIYXlmM1VzOEEra24yYTMvcmF3K0N3d0FU?=
 =?utf-8?B?aTd0OVVHTDhib2RNL2FodVA0RDNuY0Z4V25yTHdtWEc5NHBLeDNVRk1LTEIy?=
 =?utf-8?B?S2tLcFRNYWVSbFVEd0gxRnZEa2hqOFp0bDlIWHRMUGdZWWo3TEp6MWdJRS9E?=
 =?utf-8?B?STVQT0VnSzJrMjhyZTZ0OFhZYjZKd3Iya3ljUTFHS0hzNDhFT0Z2UFUyMmxq?=
 =?utf-8?B?WEx2TTRvWjdJVHlGTDNBTzQ0NVFrMVBEMTlEdVpqZlFkZjJrcEVEQTNrbGJa?=
 =?utf-8?B?YXlobnZFcUpLN1hacjJWYVZnWFVuWFFWem55MVJEM2s5bmJqa0c4QlpOWHhj?=
 =?utf-8?B?cDk4NFIzd0dhLzFDeG9BQzEvaFQyNUdiR1U4cjVWYWtHQUs5eERsaVVseG5F?=
 =?utf-8?B?T3AxNHJRVEdoU2FiMUFnMWVmaDBLZ0I1UmpPOXlXcDM3cmVXRkZCM2dvMm9i?=
 =?utf-8?B?emROY1BURWpPWEMvNnM4djQvUmwwUUVkME9Zem1hVVh0YjZac3Z5REVvOTgv?=
 =?utf-8?B?YkFzTWMwSEJKWFJvQ25HeTh1eUdXekZScnlkaG1veTYxVytWb0V5djZwams1?=
 =?utf-8?B?cTNCYzhiQU9Qd0VQOEYvbUNrM2pQaFVqOE5zOTFSTkc2MVBQNVJJNm56aXgv?=
 =?utf-8?B?aXk1TlVhWU0vZXF2S08wQkZnaWsxL25ySFlXbkZWQTBOcUhqYm5uWk5NZUVR?=
 =?utf-8?B?c2Y0cnJwN0pKSUlCOHYyQzQrcnpiZjlKOVJHbG9sT0dWeEZDSGhwdVpaeDFL?=
 =?utf-8?B?bFlnVWFDUjkzMEJWRk1ISkI3SzkrVFR1U1RIOHY1KzRLRngxVWs1TmE1R1dK?=
 =?utf-8?B?cFhtNE1lb2QzMHVVQ09sMXpEU2ZKY3lYQ1FRWlFPRDlYTEkyRFpWUmJDNjlQ?=
 =?utf-8?B?L0REZHYrMDVwa0V6QUo5S05CaWNVN1V3aC9QTGdsNm5CY0ZkSk5xRE5oR01Z?=
 =?utf-8?B?VW40S25mY1ZPOGdiNVlZVXZwNFN1bnQrQUY1ZWhSRmluOEdNdUFScU5TdWxU?=
 =?utf-8?B?UmZIeWpaL2FoSG1vYWtNRDJ6dmFwbnJLazZuck04YzBNdHozS1VaYWRsaXhr?=
 =?utf-8?B?Q2hBVXJRVWtFQ1BvS1dqanZ6QmxvUHJ3empPOHNTWjZWMDRpbjYzK0NwR1RP?=
 =?utf-8?B?cnhvWFBXQWR1Rkkvbkp6dUVDYkdjbU9xM3dvNm5XVVJ6T1hCZnlzbWNJSDUw?=
 =?utf-8?Q?nzOttgF8kSz1nvKYseaK9/Apj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83de7c5e-6b51-4bb2-5210-08db5dea6a25
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 13:09:18.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSsSB134lx7tqEeQhTcCc9XfHy++D0rGpmiJmFpC0vqSlxR+8AbMIm4vcmFHDWBi+mzOfePnja+LpLSW+G8pQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
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

On 5/25/23 18:17, Dave Hansen wrote:
> On 5/17/23 09:26, Tom Lendacky wrote:
>> However, a recent patchset that looked to avoid using the legacy
>> decompressor during an EFI boot exposed this bug. At entry to startup_64,
>> the CS value is that of EFI and is not mapped in the new kernel GDT. So
>> when a #VC exception occurs, the CS value used by IRETQ is not valid and
>> the guest boot crashes.
> 
> This confused me a bit.  Nobody merged that patchset yet, right?  You
> just happened across this issue when debugging a crash in that *other* set?

Correct, it was Ard's EFI decompressor patchset series that he submitted, 
but has not yet been accepted, that I was testing:

[PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
   https://lore.kernel.org/lkml/20230424165726.2245548-1-ardb@kernel.org/

I reported the problem to Ard and submitted this patch before I realized 
that he also included a patch in his next version of the series:

https://lore.kernel.org/lkml/20230508070330.582131-16-ardb@kernel.org/

> 
>> Fix this issue by moving the block that switches to the KERNEL_CS value to
>> be done immediately after returning from startup_64_setup_env().
>>
>> Fixes: bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in boot")
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Any thoughts on whether we want this in stable@?

It probably doesn't need to go to stable since the current decompressor 
code switches to a new GDT and uses the same kernel CS value that is being 
setup in arch/x86/kernel/head_64.S (which is why it hasn't been a problem).

> 
> I also wonder whether we need a comment in that little chunk of code
> something along the lines of:
> 
> 	/*
> 	 * Do not add anything which might take a fault or exception.
> 	 * IRET does not work here.
> 	 */
> 
> Michael, do you think you would have spotted something like this had it
> been in the code when you were patching it?

Let me know if you would like a v2 with that comment. I'm also fine if you 
  just want to add it as part of applying the patch, too.

Thanks,
Tom
