Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F435F321C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJCOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJCOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:45:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BBD2AC6E;
        Mon,  3 Oct 2022 07:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/vAR56E8ipImcMPpkADYAbEjmXxjUQ1kypb8IIk1ubHoyExDXGWei4dxZEilFJy6IzIHuPipAMoLDdcQlmQWz7MwnujnjzGMpP1pYff2HSp76Bw1FseCw2VcbEG0Gd8+m8MtWvN7D/s233F6y+1s7c2o5Wy9+k6xuirlcoT1BUUy9ivuBqACp857aBuTxJ90aaVGweLC/bc0pedR8HhJ2RIuO6KfixRna3mlYOA7uoeQ6ipUCE9N4XpjJvvEINHsmxaduzya+V31lYTRnzyXjdIUb1pMonGpCVLsxbYe7VOEJzihGVMOfZI9t7rGiB9BlkBuH2+b/1Ixyk3xfBlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttN3JrcPirEC8hxJDoWItXq6mDXvC0iTvB4VAOxuSIs=;
 b=GmaICwaoeS7aVq1YTbHvlu8FYq/M+RsTzlXMlKViKzSo/Pn1OFlSHn0NbfgkhnDwmu1PHXZT4XRnBEhANGDoFkgZNayyccIlWz+6WY7M+V3yg8ZpNvlKDacbrAH24JRy/L/Fib9dCNTocmUzxSd4gwaCnP4KQeBEbeU4/dI6iPdeTM/FOH4DYfAHIuL+gaMvVjUw8GlgYglMraos1CPoapksyLQE+jdM47ySfYZ/WK1uR8HJUR29wVZ1z0iM0td0yVf2f57LRyNUJTT2tMGRqjdD+ZDq7i1TUg6Gv28S4LfzK1aWw3FZ+5PG6kWQXD72YJ8oSIP96QTuMReYqeONYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttN3JrcPirEC8hxJDoWItXq6mDXvC0iTvB4VAOxuSIs=;
 b=UW3uf+RKZZgNfoWaPOa/RLwmE3pS4fEM8wCy6A0L9DoKcK/WdVE98ugZq0m4vEvCrxwa3T/6sHKcgOp4DeXl0t8C1rWrhXAN+dF2AJrZ4USpUZcQjM9EwLb51vv1SsJ12qVtRq6BmxsRF8SkzmMbIXFf/0hihR/AEt/clJvAz1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 14:45:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 14:45:40 +0000
Message-ID: <1cc357af-326e-cf7d-1a8e-2a0c511912ab@amd.com>
Date:   Mon, 3 Oct 2022 09:45:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431033184.373387.6520785024194837522.stgit@bmoger-ubuntu>
 <9c45dbf7-854a-1a26-8cec-dde1a1d645e2@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9c45dbf7-854a-1a26-8cec-dde1a1d645e2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:610:38::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6ca59c-fb87-467a-8d58-08daa54df135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR1hHAbWVd0w/GQGB0IYgSJctxMOxuBWBk6PYBZH23AG0n+UnSxSyBZDQbq83ucFatmwSJOENh15s08GG9D0XzsCQax0pfRk2Fdje6rdTJwKtsMbRzOa60aZ2I3RZINs7BoZ+GbHYhZTuuh80hz6mbxIkVsugGjOVltGOGUARUw2ZsisGGzW50IZn3VrC+XarjzkqaoeNJ338TVdy1MBtySEIzBX57e6ezRTmH8ZIXGEvXU0Q2Owpit39uvauPENE4NYbn6Ee5YBqvvxzRz3V7XD6cXT/n0yu95NVfKVlXJMzpWge4zSrkb7vyk/KeQiki8yfNxWiZe8oZUxgEqO/34BnLIPHxPyB21bNlS8xn20iAqYlCKvwMYJO7NISO1z2OueySb/XbneCU8LYeruN3nurnltzStCPOSURsYCelsedubZJGj/3RoMGUwvOS3lktd8tdA2ilNrQC7/CtSsoX4yJvYJ7qwN2HTXRxNSodWCvTYsd8BO8xJ6F2uvt0Min8yMuTAYPyuaoDTq30gGcirjO2ldoI+SUdD6YhcHz+JKqDnh0mm5OacOWU+LSgldwfxY6SMotbD3xUZZbgGDnYn9XBfLhpa5Kid6QqdT713vsrxe//ddUySLbf6aIqlUS8DJxEWTTHnT2KEfIgLhi3E8iboKL18MLva0lX8pkKKVSsyeviAxjZo07Gn5x22Y9NYhv0Niuw4JfZaHuLn90OBRRdOjpMGRu/+mgI6Ej3oUF/occXawS+cPENJ24TOEXxgJKJeXabTO3aWu6gbofwUXiW7+x38CHJsuKmLvvBqwzOqexOzLUXlrl9dpky5W344dxe8b2LlR25/4Z4znuD4xmSwHWbOphNOuEI3kuxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(6486002)(36756003)(31686004)(38100700002)(186003)(83380400001)(31696002)(86362001)(2616005)(26005)(53546011)(6512007)(6666004)(6506007)(478600001)(3450700001)(2906002)(966005)(316002)(41300700001)(5660300002)(45080400002)(8936002)(4326008)(66476007)(66556008)(66946007)(7416002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhTNkFqWVNMcjFOQ2ZoNC8ra0ZJQklHUjlqSmRSLzRMdVRwUlZjbjk4T1M1?=
 =?utf-8?B?dDIwclRVUTZnVFhFSnkrVWkvTUk0OUxhRzNGdHZLNHR5NWIxSnoyb1FaVkdF?=
 =?utf-8?B?aGdNcUpkWGIwNmc2SC9jeVRwWXd4ZnArMG05eldwelhoSnUvL0g1MURhd3dl?=
 =?utf-8?B?YW1DTSt1MHd0WFJTVGZpaEM2ZS93cWNrL01qcXd4VDhmOTAya3VyWVd0ZUo3?=
 =?utf-8?B?N3Z3ZHpVbzRiL0FaZXRSTG4xN2s3S0VzaHQxQ3BSZENYdUFjUUZ3WHNveTdp?=
 =?utf-8?B?bTEzY29pbUwzSnpZelU0SlAzNlZOY0dldU1DSjB2ZHVjT1dxbHg2WWVzVmJJ?=
 =?utf-8?B?NFNhRU1oMitHQ2FnQm9uK0dKTlpUV0hkb25LVGdqdmFGcFZKcXJEWGpKSFhF?=
 =?utf-8?B?K1hEMnJ4OTM3TElJeHNlNG5jWDdENHJSUDVxdXFFYW8xZkxHalozamdsUTgr?=
 =?utf-8?B?ZkUzMm1NSUQ5cVdRVjIwc2lEWjNmS2NtL3F0endYRExLRDcvUi9tWnFXUDVt?=
 =?utf-8?B?TGxTb0tpMWlxWnk1eXArb2pxQ3dQMlJmdVVkL0xiZUJEWDdscU4zVlMzMmNU?=
 =?utf-8?B?aXFaeWhzMjBwdDQ0NGxQN051U013eWhWTGY2ZnE2dFloWmw1aitlRkM2clBp?=
 =?utf-8?B?TmVmWE92YkxLM1N0M29QS1hHQWhBOWo2YmZuNXNGVTZ1Q0lJU1c5RWFqWmRR?=
 =?utf-8?B?bkFCbHhXQkRCTHIzWklrMWhNOGxJOUx3S0pVdENKaEdxWlJkL3ZWaGdsSjFt?=
 =?utf-8?B?ay9hZkpMc1pxU0x4RnMrMjJGS05tVWFUZUVETGlQWWdvcTdOeVZ0Z0pVYTNn?=
 =?utf-8?B?NnZRQ2kzc2lCS004M3I5YkcvRWx4azVBK2J2SHZqQUNNVGJ4Z1A5QnNBVURH?=
 =?utf-8?B?SEVFVGFPUitxcXhrUUhqaU5zamxzU2EvTGFvc2N2ZWt6bVFhTnJHTVhEdlZQ?=
 =?utf-8?B?dFozckVkUmtJTWlRWU5jdDBlN3p3TUVYek5MZG9rNFd5NjBUM09kMjdIbjJh?=
 =?utf-8?B?MTlibURuWjcrTWNMNUlVYTdiSXpRUlhreUF6SHoybnBsTnQwc05VQldPb1lX?=
 =?utf-8?B?YjlRZ0RVVzMvdHY1MGk3Rks3U24yS3J1UDIrcS91NDhpZkRxbEd3QzJwRVdV?=
 =?utf-8?B?N3o5Q24zYTFyV2VQTlhVazhXZkF6Wm9yeGY3UkhYQlVkZlp4ZCtFVjhZRy9M?=
 =?utf-8?B?QTdNb3dlK3Y3L1RqaEtZeU9BTTZGeFBkWDBrb1pZbDRIb3JsN2hsSHhRUWE3?=
 =?utf-8?B?ZDlHcVFaNnBXMzlsMk01M1FxZjJxVWFFSENHV2lTbTNQazFUUkxUOUxjek1Z?=
 =?utf-8?B?N0swV0I1eUgycXZkVE05L1JqazlGTjZFTEN0N21CVThMaTBvV3NBQ0M1aWJZ?=
 =?utf-8?B?SEZjWHlPYnFKWlFqU0VUNU9pVWZuc2FacTRoZ3pJeHRMajVodFhqUzRRWVRp?=
 =?utf-8?B?SERjWDFyNmsxSnFaNUdkTWFQcm0rb1EyRDY5bVEraGh5SCtTRWk4YzBGT2M3?=
 =?utf-8?B?VEszb2s3TkJOYjhGM2FMSElzY3hvazBJTXN2cFVDbWhqZXlRaTE1UWpJWXpB?=
 =?utf-8?B?VTY3YTUzVFRMYjFCaWt0MjZoVjMvSmFydnhLcS9lMzRlSEVGb2loazY4V1Uw?=
 =?utf-8?B?SU1FMU1pQ3VHQXpoTUNCRjk4Q01LOHk2MmxlOWx1dEU1YStQQVRkOHJzWjZ2?=
 =?utf-8?B?QVRkUUtRQ2s4RGhlRXc3NjB4WmJKcEpYNFR0QzczdTVVck1Jcno1dkRWUVZD?=
 =?utf-8?B?eUJIVGY4ZGgrYmR1QXZzQWNnMktmNmVZWjBCVEE1TTl3QlEwRi9KcUJkUzFr?=
 =?utf-8?B?ZXpFakV1a1p3Q0hrdDhBZkhvNlBocExid09VUTk1ZmkzRXNkazV6ZytzOCt4?=
 =?utf-8?B?MUt1VWVlb0lxc2xnSTRpaUEzclNkdzZENFdBQjVyVXFIRGxtbDhDL3lZdytu?=
 =?utf-8?B?WTl6bzdTc1dlUWhVdTlBSVkybm92SnE3eU8vZ0wxUXkzVFVDWGNEbEx5Q0c0?=
 =?utf-8?B?UkVTQkRnZWkvTVNibmpDcUdRTW9sQ24za2JsUGNESGpUVVlGZnJDWm9sTVI4?=
 =?utf-8?B?N0thWXJhaDRNc0JERlZXQkY4Y2hBUjVJMjRKeFBJbmNzSG9mSDFtVDgrRFZL?=
 =?utf-8?Q?tHWg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6ca59c-fb87-467a-8d58-08daa54df135
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 14:45:40.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMXHufmWDp9LuHJTX3nfDJ4mz3qrvAWcj56iCc2rGb1gKU6YMXrOHe3Ku5dmyh7Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/29/22 16:58, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/27/2022 1:25 PM, Babu Moger wrote:
>> Add the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
>> enforcement policies can be applied to external slow memory connected
>> to the host. QOS enforcement is accomplished by assigning a Class Of
>> Service (COS) to a processor and specifying allocations or limits for
>> that COS for each resource to be allocated.
>>
>> This feature is identified by the CPUID Function 8000_0020_EBX_x0.
>>
>> CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers
>> (ECX=0)
>>
>> Bits    Field Name      Description
>> 2       L3SBE           L3 external slow memory bandwidth enforcement
>>
>>
>> Currently, CXL.memory is the only supported "slow" memory device. With
>> the support of SMBA feature, the hardware enables bandwidth allocation
>> on the slow memory devices. If there are multiple slow memory devices
>> in the system, then the throttling logic groups all the slow sources
>> together and applies the limit on them as a whole.
>>
>> The presence of the SMBA feature(with CXL.memory) is independent of
>> whether slow memory device is actually present in the system. If there
>> is no slow memory in the system, then setting a SMBA limit will have no
>> impact on the performance of the system.
>>
>> Presence of CXL memory can be identified by numactl command.
>>
>> $numactl -H
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
>> node 0 size: 63678 MB node 0 free: 59542 MB
>> node 1 cpus:
>> node 1 size: 16122 MB
>> node 1 free: 15627 MB
>> node distances:
>> node   0   1
>>    0:  10  50
>>    1:  50  10
>>
>> CPU list for CXL memory will be empty. The cpu-cxl node distance is
>> greater than cpu-to-cpu distances. Node 1 has the CXL memory in this
>> case. CXL memory can also be identified using ACPI SRAT table and
>> memory maps.
>>
>> Feature description is available in the specification, "AMD64
>> Technology Platform Quality of Service Extensions, Revision: 1.03
>> Publication # 56375 Revision: 1.03 Issue Date: February 2022".
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fen%2Fsupport%2Ftech-docs%2Famd64-technology-platform-quality-service-extensions&amp;data=05%7C01%7Cbabu.moger%40amd.com%7Cdf869c35332b477dc5e808daa265c0cd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638000855157338562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xFd6dFAZtT4jE9cPQ2LEkfxWAbG3ypQ0Mhl3K780YxI%3D&amp;reserved=0
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=05%7C01%7Cbabu.moger%40amd.com%7Cdf869c35332b477dc5e808daa265c0cd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638000855157338562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ZwBrgjVUvfriC0rM4z7XMP85CVhhI0erM%2BSFtdWa5%2B0%3D&amp;reserved=0
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/include/asm/cpufeatures.h |    1 +
>>  arch/x86/kernel/cpu/scattered.c    |    1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index ef4775c6db01..349852b9daa4 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -304,6 +304,7 @@
>>  #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
>>  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
>>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
>> +#define X86_FEATURE_SMBA		(11*32+18) /* Slow Memory Bandwidth Allocation */
>>  
>>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
>> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
>> index fd44b54c90d5..885ecf46abb2 100644
>> --- a/arch/x86/kernel/cpu/scattered.c
>> +++ b/arch/x86/kernel/cpu/scattered.c
>> @@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>>  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
>>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
>> +	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },
>>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>>  	{ 0, 0, 0, 0, 0 }
>>  };
>>
>>
> Please respect the coding style of the area you are modifying.
> This is the same feedback as provided in v4 in
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2Fba36c68c-0b13-e8a2-fb45-8b84ea9f7259%40intel.com%2F&amp;data=05%7C01%7Cbabu.moger%40amd.com%7Cdf869c35332b477dc5e808daa265c0cd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638000855157338562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WPFwZq1KCIhrGyGt5Qle9GYZBeXqTtHWGCTaK7vAeZY%3D&amp;reserved=0
>
> Looking ahead the same issue also remains in patch 3 as previously
> mentioned in v4 feedback.

Hmm.. I ran "./scripts/checkpatch.pl --strict --codespell" on all the
patches. The checkpatch didn't complain about this.

Now, looking at the line again, I see it should have been tabs between
those texts you are referring.

I will take care of it next revision.


> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2Fc4a9ea23-4280-d54c-263b-354ea321f746%40intel.com%2F&amp;data=05%7C01%7Cbabu.moger%40amd.com%7Cdf869c35332b477dc5e808daa265c0cd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638000855157338562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4tuK0pMrJsiW44IKCkeZV8ujS4z9STOa3mKfRKbHulk%3D&amp;reserved=0
>
> Also missing is highlighting that configuration has changed from
> per-domain to per-CPU and why.

Already responded about this in patch 10.

Thanks

Babu

>
> It does not seem as though this series is ready. I will wait
> for next version to have existing review comments addressed before
> trying to look at new changes.
>
> Reinette

-- 
Thanks
Babu Moger

