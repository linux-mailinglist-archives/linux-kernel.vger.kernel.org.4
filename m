Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B666CF2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjC2TRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjC2TRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:17:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECEF55A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB+Uh05700uAcRTrxxTLdHXz+fGUV4rQpdqCU0a7rPSBaCtkQ43LvwLaqbx2Cn4zKqa6NTJVBfxVR/z8+RPEZ7JVOoSZbMf+uuqAOQnsdVuxqdtLlGwpVqNFl5sNuU+iBkC3gXMXvOvGMNlLO9ozmz8fIuQc/9tQ9DKGLQz/EUPFzxs/CBkrf7EH2z47nO+lyNrxYVWi2VsajCHHuSqMfB9kCvXxd1Gg3F3ZBXBTnlcxmf9WmmT6SXfCEyDTNeu7Wa5GX0uQR6NOBguO4lRB9MeMLarnwCeGDb0+gYKF3K1rWwC/QiSFtCVS6xG4tUIXJd1FHUwh678lJUavr9NHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qANreurDvRvw/VxeZjuMGX7Rjmmmn1Q1TI9+kO4QumI=;
 b=FIXtZlyDEzIP6b8gx4DLIlRZ9QITuTCCqDpyIgi62YfcokRHWZkcX86KuZqpZJf8q5hPTlkgWS4bY4/1fAvnTY1sLnlHbZBhf2Al/ebP3mc7MtrwKg+CNuFbEZFB0SNsESiHZcEHILeNoa0fej1FJdJV1d4p9JglYxMBKnW6UVu+AmXPhix2WwnF1JpK5WyT+oiXoUXgz3NffyLF94b3QECJzmNABKCI7glZUNfSjLWsUVuDWZ68Z87J3QQdrwoYv7TvtGqMTKpQB0e4bEa5R0740WNUh92x1nk/LcLUlb6vnUezsDq8O7Z55USQHmaQbc697ptNDHWTeUja8YciYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qANreurDvRvw/VxeZjuMGX7Rjmmmn1Q1TI9+kO4QumI=;
 b=qaMnM79KZZtvSg6dUPRwMpipFeV5lp4Grti4vk3+EtIy/1OknUktP5+icxrOAabyIAlEsUdqMVty3mdyAjoKB7JsAi9dEpV1xVQ2vzVN7IXceN8Yi7X72HGPPuTZuggKnutdFMzudDMszGL1LEZ6e5rzWxt5blzodLbcg72CFnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 19:17:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 19:17:09 +0000
Message-ID: <e4a6e5bb-d014-aa55-5eee-65f1c5f59875@amd.com>
Date:   Wed, 29 Mar 2023 14:17:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-US
To:     David R <david@unsolicited.net>, Borislav Petkov <bp@alien8.de>,
        Gabriel David <ultracoolguy@disroot.org>,
        eric.devolder@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
 <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
 <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
 <9ed16be4-051d-c20f-0410-b8a973c4c09e@disroot.org>
 <20230329103943.GAZCQVb1n3tKlGOAWI@fat_crate.local>
 <20230329161450.GDZCRj+rz9lTEZFNBz@fat_crate.local>
 <f033acad-593c-a741-8f4f-a9962eb8aab9@unsolicited.net>
 <e8fd7cdf-b6a5-1c7d-bd08-0d60a1c10495@amd.com>
 <eaa97a25-27b2-187c-1db2-9c56e35d3463@unsolicited.net>
 <b65c4f1f-4990-f7ce-e4c0-85912d187eaf@amd.com>
 <a0ca1e4e-891c-273d-e2d8-eeb9fc4d0c77@unsolicited.net>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <a0ca1e4e-891c-273d-e2d8-eeb9fc4d0c77@unsolicited.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 169fc501-3555-4214-e103-08db308a3173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3o/y5GN7kKCH31bXxTU5OMZhqpVUfnmg5re5/gT/BMdYsnuJWVYCgMyORMGvi60EgMZeCp91V0e4q3NVCVcEx3HPty1SvFmdJn8s6aIcFyc8C5dOZJ0WNs4uapMywUOLUcpphtiN+NQPCZ62rSOQ1l2iHq/FnyAORFq4GWxfpNhKgIvJBDd4p4h/LEYWrjzqGbEgQtYmxsc/gfbdDDEMsE/GQyq69Au5JWWVSIv5eEeNVeHr9uzd3LiXMFOz6H4ecuKoTbB1lI5IRvtxSsPUpbWVdzgRUuirL6qiLA/rk7OLkayE0wYJSOEQRjwqPgFvbxFSgu6ZtcB4T41kvledn2uOwpUFSXnEM9+Q9GQI+zFZpxwrcVgmGO0/Jo+eMYkoIYSve8cr0au7GJ5loYWyTz0jj+jC47NZWPCcRyWcorxYdMiYcxRa/L7da3EP+z++x+sOB75/e7BsLfa1tnUm9JEC2o5Fq/2E+j4h4MERJ4+LkSJOaof/KvE4bno+PgBqhLwN5uXE9PV/qB1JUeucpxIgyLPzgQLvqWr7tywwsFo27oHxORzcdZfqGHPtndhgVNhSEjohQrQKkSmDUSqkazOBdcdQ5mwCLWuDEFyCQepO9fuzc+wfNNAAramdNs2JEwulkAK+WD/H4CJw5T6c/M+0Q9g2RWzOhPcYqfkgqrGJPdToQbCkEMVQGKkwdIr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(316002)(110136005)(478600001)(54906003)(31696002)(86362001)(8936002)(36756003)(5660300002)(66556008)(38100700002)(66476007)(4326008)(8676002)(2906002)(66946007)(6506007)(41300700001)(186003)(6666004)(53546011)(6512007)(26005)(2616005)(83380400001)(31686004)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9BaWF2a2dhdXNkNExyTTNZWTZadXR2eFZFY2Vkb0UrV1puQm43MkNpOFBj?=
 =?utf-8?B?TEFKUVBKMVpZbS9RblM1THg2RnFsb1hSSW1CRlhrUFRhaWhqV0c4ZHBkRnBS?=
 =?utf-8?B?UkJZbDlvN1VITkttNkh4RDZob0l6UGVOZEI2cW9aVDJZMEVhL0wwM2RHbnB2?=
 =?utf-8?B?ajQxVHhZTDZTeE5CNFZmV21YNmhVTTJxYXE1R3RYV0Q4WXFaUTRCeTc3VmNm?=
 =?utf-8?B?a3p5TTI0N3dTNG5RcG9tcE9iZ010YTJrY0dQYmVYRmZJZjE4b1BRQjdMdkky?=
 =?utf-8?B?M21WY3IrL21aNDVXVFpzZk1YTVlPTll0Vk1YcWNNUGFRTTlKVnJiOS9nUzlh?=
 =?utf-8?B?VWlGM2E3T0ZQc1haZVpqSHZFRUFHUzlNbUZBZkhyMzdqYzhRN0tzMEhGaDNl?=
 =?utf-8?B?V2VFRTNlRXJoS0Z4T3ppb0JzaUw1dTFzd0srNm1sZkNjVzNTZWV4amlCR2RT?=
 =?utf-8?B?a0lUc3I1b1JiRVlCbFNKam5CTU5odGlIeWc5UUt1SmZ2cVpkK25SZHdGZ1RP?=
 =?utf-8?B?YnBoU1ZlSldIQ2M0L1ROTU4rcXMwZ3oxUC9LM3Jxcy9HTGFabVNWT2EzSFRF?=
 =?utf-8?B?TDJtdWNlOG1vUGJkTnUwM1lnak1TdjYyWnpIVEg0b2NZN1ViWUtkYmJKT0Z0?=
 =?utf-8?B?UDJPQUdPYU5scS9iZHNqMkV5OWRqU0R2TnUwRTBya3hDeW1qYlhnblFGYU1a?=
 =?utf-8?B?YUUvVFBhMzlkNVVMblYwYkFuNTVHNUNRTlRtY2IxaytaeXkzYTBwYlB6cXhr?=
 =?utf-8?B?bkNFaWk2Um94NElScEduWi9WeFQzTTEzU3JmOHFKYmdYSFNqTzFFK0xCZ0sr?=
 =?utf-8?B?K2dWODU4bldsVUNVbDZpN3BQbVpxVk93NnlZaEhZWE11WkJmNDFaRDZ4bTdG?=
 =?utf-8?B?dmJLSCttaFlCUm9ZaUtPTE4ySERHcDlWUVRBUkdFQW5jcUppMHVJSnJIVVcw?=
 =?utf-8?B?bXVQSGdtQUlKSE52OXFpV2dGb2o5SlJVU1JmS1dDYkJpY2lTQzE5M1ZkYURG?=
 =?utf-8?B?VjRXUEtYZXFaUFFKamFEYmxQeUo2SC9yY1RsZjBYbDFQL2ZsTTFjVzBTL2Q0?=
 =?utf-8?B?bi94R01DWkRlbWl3d0RDTU91MCtITXJQNlRWdVJOM01EWUxwa2kwSGhVRTFi?=
 =?utf-8?B?cWhNSjViaEZ3ZmpPUWp3bGlKdXFBeUpNMDFBRi9vVU5oTUhpZ0JYK0ZRc1c2?=
 =?utf-8?B?anp3MTM1T0ZpV2VnS2J6N3NkOE9tSlVMeFUwbTRpL2lpQ2pzSE82Mjh4MUlo?=
 =?utf-8?B?QnFidS9mSE5vYkh2WjZqWHZaLzRpZDZCbVlPd3RCc3AxNWdGNWN6V1JCdElD?=
 =?utf-8?B?RWYyRk5qd0lHcEExNXNxKy82TXZocFBGQ2ZmSjAzQjg1ZlowRXJWWUhmT09H?=
 =?utf-8?B?SlNGa0ZmYmtKSFRkcjI0VUVvVUQybjBXRXROeHRPYmMyTkNBNFpYRGVXUGVH?=
 =?utf-8?B?cUEzUlluN2Q5cmpQaDgySmVDRE5lVmRhSHlweDNCVU13ZUlBa3AvYWRYYURa?=
 =?utf-8?B?YWxoQjJHSjNDM29tYXNQRDhkaERXQW5HVTl3bGFpRDRITndOOXQ1Mmxpc1du?=
 =?utf-8?B?S1dBYXYrVWxqS3BMVGhWYVZJN3A0MnRwcUFjdnNGRit4cXpMYnJ4bWtFeExw?=
 =?utf-8?B?dW5LblFuM2tRRmxWaGdsNUxtY3gzOUgxL0NSZEh5VjhWUlFlZ1lKK2t1ODlh?=
 =?utf-8?B?YkRiUUhlZUk2cGZsM1NDVFJ4NSs5NlN4VE4vR1NhOFhrMDVBTkQ0ZnhPMmQ4?=
 =?utf-8?B?MXdUVUZXMEs5dkx3SVk4VWs2MEhlZkdkL1BPdytGdG9wZ0NaQUFwQ0VZQjZB?=
 =?utf-8?B?MG1QNkRHcWdTRnFrY0MxTFgzbWZrSHk3aWlTeVE5cUdQYlFLYXRPbTA1TlVh?=
 =?utf-8?B?SnBUVmhKamsyeCtkUHlpbktBQ20zTFFqVmwybnNqbXFzMHI0QkpwdVZEbkk5?=
 =?utf-8?B?YmhZSEdTSlJSY1VqeGh5Vy81cUV0TUJRTzIwQnJ0NXoyYnM0K3lwa0FFZmFB?=
 =?utf-8?B?cE5hQjFCLy9XQ3FqN29NeFA5REdZczRUbWFQS0hhcnRZWW96QUhORVhNWUhM?=
 =?utf-8?B?RGNQdkdQQjM0RVVmd0xPUVdHVFNjV1BQcHZJdG9IY01rMnJCVEZNWFhnblVp?=
 =?utf-8?Q?zQ1QUVL5jI9ydw719XO1PoTDm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169fc501-3555-4214-e103-08db308a3173
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 19:17:09.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30zx5QNobkstiISTNXQV8SY9PI/FNe5E4awwIut1UHEQpVuH7DTuDODgiGV6sTutRObslpSwUr03cREGhJv8Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2023 14:14, David R wrote:
> On 29/03/2023 20:07, Limonciello, Mario wrote:
>> On 3/29/2023 14:03, David R wrote:
>>>
>>>> Can you guys have a try with this patch to see if it helps the 
>>>> situation?
>>>>
>>>> https://lore.kernel.org/linux-pm/20230329174536.6931-1-mario.limonciello@amd.com/T/#u
>>>>
>>>> Thanks,
>>>
>>> Your patch on top of 6.2.8 brought the crash back I'm afraid.
>>>
>>> Cheers
>>> David
>>
>> Humm.  In that case I'm a bit worried there is some conflicting 
>> patches that caused this result.  Could you try with both
>>
>> e2869bd7af60 and aa06e20f1be6 reverted?  If that also fails, I think a 
>> more complicated bisect removing those commits is needed.
> 
> I note that 6.2.8 still has:
> 
> static bool __init acpi_is_processor_usable(u32 lapic_flags)
> {
>          if (lapic_flags & ACPI_MADT_ENABLED)
>                  return true;
> 
>          if (acpi_support_online_capable && (lapic_flags & 
> ACPI_MADT_ONLINE_CAPABLE))
>                  return true;
> 
>          return false;
> }
> 
> The flag getting set to false won't help unless the patch I tried 
> previously is applied ?
> 
> diff 
> <https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/#iZ31arch:x86:kernel:acpi:boot.c> --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c index 1c38174b5f01..7b5b8ed018b0 100644 --- a/arch/x86/kernel/acpi/boot.c +++ b/arch/x86/kernel/acpi/boot.c @@ -193,7 +193,13 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)   	if (lapic_flags & ACPI_MADT_ENABLED)
>   		return true;
>   
> - if (acpi_support_online_capable && (lapic_flags & 
> ACPI_MADT_ONLINE_CAPABLE)) + /* + * Prior to MADT.revision 5, the 
> presence of the Local x2/APIC + * structure _implicitly_ noted a 
> possible hotpluggable cpu. + * Starting with MADT.revision 5, the Online 
> Capable bit + * _explicitly_ indicates a hotpluggable cpu. + */ + if 
> (!acpi_support_online_capable || (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))   		return true;
>   
>   	return false;
> -- 
> 

You mean specifically this change:
https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/

Yes; I suppose that still makes sense.

