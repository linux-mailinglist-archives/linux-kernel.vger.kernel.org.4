Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617474FBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGKXTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGKXTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:19:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E20E7A;
        Tue, 11 Jul 2023 16:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijG0AXTCzP3errg3+eTnJl5eoK0SWAIA2AjofepJTARrN35ZZsw3+8W+ogJ8b/NclpFT9Q0lkLrbZ5pQOelpT46gFE6U9CwyQAizgVsk8oqVjMgvfqpSVvkVaiMwbnBrabzdXYUi9YBljI+jKkYgJGf7PZJrzP5bCGIshI1bsKNodJqGJWbet0cdo6U8FttlP8AcAgO4nZxfbbJfsCJ/bO5X2luORivMM7gzA2wbS/JAGaxa0y6hlfjegHpwbZyFpqyMt5GDiV0xLsMGwm5cbArrNoR5AUTbcEJZM3dw3ny5r1faGYniNE4xjQ6ms26TPsO0aYOjI/jBur8ooWEjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRn7wfGdAOp6fqDKgOxihSDpz6actBxyVpdAkY4ZYvQ=;
 b=SBhKFnXWkY/9SpfV3Qiak1Vkf4sOmTXCBJCo3FzYEb2M/rXmBdwoHh9Vh2s9Zbt3TYWhLEDTrtLy+bH7MhW+8EHy3mspNGNWN/Yx8se3TW5ArVfq9mnTZw4pBSRWcZXLrhBLxxNAgnVmnWUHVTf1MR0H3kAIN3umV1d8gCqvRgOUb7xAOYU5Vh7mTaCKu5ymEdjKG8aykACh2OEJ2ofeG4sJHZ70OPfoWv7Pb0ViyKzl2TTSjq72tCmZNj3j2Dl0naX6ySactNfLJ67l/thSeCpLmuIkdysKuZw0qDMC7D+socZg+I+twQgquey3Maeol11gOS1nbYIBhcjAGk8NIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRn7wfGdAOp6fqDKgOxihSDpz6actBxyVpdAkY4ZYvQ=;
 b=QL4ol+EEpHZDbuBHDuyOFP5BNuBpd+6K8tMIvbVfAa/V2nHqclWrUPKCyS8aOV37b/tzD2O1RmMeYpOrEdBFRIoMa0ZGiR60LuAph925emlnq2YmDFVeWgTU3eSkK7olPgiphbXP/8DCkG357S/eMud1y0jI8zGlL+3lVv2kt9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 23:19:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 23:19:12 +0000
Message-ID: <fe2990d3-eb98-332e-4720-0a01b55f80ef@amd.com>
Date:   Tue, 11 Jul 2023 18:19:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564609148.527584.17320328540832247657.stgit@bmoger-ubuntu>
 <ca0f3541-5d84-8996-9fc6-b473387d8f35@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ca0f3541-5d84-8996-9fc6-b473387d8f35@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:806:d0::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f97b54-1b0e-4dbf-9bc2-08db82653c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEqHIcVY7JyeMRTVJHSZGi4bs5PawaTA4AcQPCfNuZ2aQ1PBdADfsR+Vy3h7KdxnOpZjuIvlIq3NqMPyYjGt3BSXps8Vo+xjowwkXXoA+vP1uggJ4NKy+K3unLYE5CQDh0QkXPKKHirqb61UKFSZNwSj+/JBXzJuzgv9x9kssdAIWLLnfuIdsYaqe/Iiz5yLmZQFAkdM7x3aL5/9TVh3ZfZVY0kkBPeSuu7fETJWhGmTxhV/KfVZ8HVNzbyIphunaZLQAgu6i18oAra9zCsUyPBs2dRRlvF9d9rZE8I+3EITz4pzT83EvKQQfYQWcF3wCi73f8MRwJnxgx8edVidZ/LXduOK9ga0Z1I7cSXHeByj97awqJhU9lHHfvQzuxzagrrXX5m95Sg7JMEsZfszfe4sCxfel/PVKVMN2SFcU5VSO+wASMKzEOmj+P/WkUc4dH8hwCCZ3udbxxcHbBM0fdlX2y33QBBrBDUX6FoBWamKjhoHmr/GvNAMnGfXJ3UvgVGRQNQ6qHkgd62H43JMX3FBD1m5bZv/BxeXV/4dBR0LLkdH3gHIGuooU7jLS0bT1nCy3Y8BBZMpQ97JBWEDH376owZsEopYsVbiWtDDr1Bn2Slc9SJd4LIJHfHcZDE3o55QQLzxdBil7h0QcbBRWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(31686004)(66899021)(41300700001)(2616005)(7416002)(7406005)(3450700001)(186003)(36756003)(2906002)(5660300002)(38100700002)(26005)(4326008)(8936002)(66476007)(6506007)(53546011)(66556008)(8676002)(316002)(31696002)(66946007)(86362001)(6512007)(478600001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9ZMSs3NkRBRHI0ZHpWSzNpYXMrYTdCWk1ZRW15c3lRK0JsR3JwOUQvQ3ov?=
 =?utf-8?B?YmtRWmEvbEk4eVpXdE1xSVJyRVVOQmVQRVRORWp0K2hWdWN2RndjSUNUaTl4?=
 =?utf-8?B?a2ZYczQwaEgyZEVTY3h6TmtlRm5pY3lBd2hqa0FKZU1COFdpN2gwKzVpMldD?=
 =?utf-8?B?cHgram9YNmNJbnhLTnFGVXR5UUwzS3JmTDNBeEg1dVRFUW1sUXFNVEU4djhJ?=
 =?utf-8?B?NFpzZWJhV3B5Y29kT2s2Z0NWcHV6VGZUbVZndVVxcTJDc3c3eWFiZnVOdlhW?=
 =?utf-8?B?SUg2VVRCMmpncHlUZmtGMndiaGZ5ZHhWazZCMk5aMnNoWHpXV3JpeTJmbmto?=
 =?utf-8?B?SGdSb2o3OUQ0bXFPbU5ZZXowRzJjbjdFeERUYUNndnFYdGdwWXllMGZOZjdq?=
 =?utf-8?B?UVB1dVJtaXNxMHpMUmg1dmNPdUVpMWs4Skszem44VGRvWkRKcmpnQ05aQjBZ?=
 =?utf-8?B?S0tQNlh6Y0FXai9DVnVqd2lNRmFidHl3dFlFaFRyQ1FyZ2ZUK2xLSWVMMnZS?=
 =?utf-8?B?Sk41bmhFbUM2NklqdWNMVkNYY2haeTl4Qk9ubGlsVm5iM0JaUFB5aURMY2Fn?=
 =?utf-8?B?cEQzWkliRDR0L0N1L251cXhucjRIK0xBRlhtVFNXOXg4Mml1bXloeGI5NjFC?=
 =?utf-8?B?TnYzYmtTTHI3bDc2MmNSVXFRTXZiMzFyWnhTQ2hMV0VuWklwV2F1bFpPampP?=
 =?utf-8?B?NG5TZkE1aThjWmpyc1hWS29SLzRGcjVsVFo3Z2l0TFlDMUc2SVBxVTR6RE83?=
 =?utf-8?B?MDg0Qk5ZSTRya0Rza3FqaSs3MWhzR3NpNnc3RE44czRZMjBlVEFOTGVCY3RV?=
 =?utf-8?B?MjlTekdkYmxMbDJJTzlOQ2RlWjZmTFFrK2tkcFhhT1JkcXhhTlNmTkhIWCtr?=
 =?utf-8?B?d0RxTDBSTWVQa3QxYWJIVUdMbU9xYkJ5dnFKaW50V0lnNXcreWF6SUE5M3dE?=
 =?utf-8?B?Y1dqeEcrRDBDbVdoeFIvd0YrV3ZoRS9ja2RTNURyb2pwS1VDZkFua2NTN3lR?=
 =?utf-8?B?QjVtOVZXYnI3MVFlRjlOWGVCbm0zcGc5SnQycXN2L3NOd1lDZitXdUVNY0dl?=
 =?utf-8?B?aTV6VEhxRU0wa3g1TUVTYnJuUHI2MU02OTErTEVUNGUzYzc0bEhxSFRYaktj?=
 =?utf-8?B?Z2tkSXZrYVlsWkxxc2Vvc08xTHBKcE50M1ptZG5QaHRZU1ZDZjZUV2UwOS9K?=
 =?utf-8?B?RVYzWjhOR1dSNGd4SVJ5REZqUDNGVHVuSmNrTWtSRVYwMXhYb2tMS3JCL014?=
 =?utf-8?B?V01IOTY0M2hwY3FzdngwYy93T1hBVDVORlR5YmFEeGJTMzBMSWZ0Q0dveDNa?=
 =?utf-8?B?MklaWFhCSUJIbE9vT2g4RHlha1c4QVBKR1hKYmpGN055UUpSaURmb0FYRzZy?=
 =?utf-8?B?VzJ1R0dydmtjSnRRNC9UOTM0QSttVzRiV1VZQU9rK1QrVkQ2RnlINmxFUUNw?=
 =?utf-8?B?a3ZFVU0wYjhGeS9UVkwydDc2WlhJYTNjN2M3dHd5WDJaOS8zNFd5V2lsRllK?=
 =?utf-8?B?K3NxbEU3TlF4NkowS0kzWFF4OHVsNWYrcnR6WUFBMzliZVhoUVh4bkhwcXNV?=
 =?utf-8?B?dlZTdUVpQUtkSWxyVzZoVVRtZ1FDZ0VpL1phanE2akkvcWd6OVVHcEt5MzY0?=
 =?utf-8?B?SDVzdExHTnlHQS9BenYxZEVuUHgyR2NyRWx2cTF6cHR4UmpMYm85KyszMG5U?=
 =?utf-8?B?czh5ZjVBRkUzTTR2U3J0QkZ6ZUFKdlVBbXptKzczY21BNzVjSU5GZlo0bDFD?=
 =?utf-8?B?WVFjNmE5MlV5ZVVtdzdSMm9raVVzL29Bc3FLa0daKzlRYUFQamVvMXNqWlF5?=
 =?utf-8?B?Lzcwa2E3Q2VoM2JuTFkzWE5FbjNxbUZtQVNLanduYWpqb1AxWFRjTjUzcWdu?=
 =?utf-8?B?cFNzUFRQL2lHVHN4Ni84QWxsdWJKbk4rYnRkWGszVDNrQXIyQ0lBZi9DLzAy?=
 =?utf-8?B?M0RrWVFnQnp1a01zc3pySE1haE1QaW1ibmNQNGh1TlBKdjRzUUdSajZmaTJN?=
 =?utf-8?B?VU1xMXJQSHNQTFVyUGNPcmpmWEp0b1NwK3JtUkM5Q0ZKLzhrdi9GQ2pCMkZ0?=
 =?utf-8?B?R1FJRjhROEhUV3RNWWZZazdTTDdWL3c0REJFK05vaFh0QVVJK1ZxamRReE5t?=
 =?utf-8?Q?SMJs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f97b54-1b0e-4dbf-9bc2-08db82653c26
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 23:19:11.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKcrTnYJR6zlaN9QFhUYdBCqqwn6f6pF9674coXVmIwu8Spwf5q/oISaqFyecFTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
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

Hi Reinette,

On 7/7/23 16:39, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/1/2023 12:01 PM, Babu Moger wrote:
>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>
>> Definitions and directory structures are not documented. Add
>> comments to improve the readability and help future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |   45 ++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 2051179a3b91..c20cd6acb7a3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -240,6 +240,51 @@ struct rdtgroup {
>>  
>>  /*
>>   * Define the file type flags for base and info directories.
>> + *
>> + * RESCTRL filesystem has two main components
>> + *   a. info
>> + *   b. base
>> + *
>> + * /sys/fs/resctrl/
>> + *     |
>> + *     --> info (directory and provides details on control
>> + *     |         and monitoring resources)
>> + *     |
>> + *     --> base (Lists the files and information to interact with control
>> + *               or monitor groups. Provides details on default control
>> + *               group when filesystem is created. There is no directory
>> + *               with name base)
>> + *
> 
> In the above I think it may help to split the comment into two parts:
> (a) which directory/directories are referred to, and (b) which files can be
> found in the directory/directories.
> 
> For example,
> 
> --> info (Top level directory named "info". Contains files that provide
>           details on control and monitoring resources.)
> 
> --> base (Root directory associated with default resource group as well as
>           directories created by user for MON and CTRL groups. Contains
>           files to interact with MON and CTRL groups.)
> 
> Please feel free to improve.

Looks good.

> 
>> + *     info structure
>> + *    -------------------------------------------------------------
>> + *    --> RFTYPE_INFO
>> + *        --> <info> directory
>> + *            --> RFTYPE_TOP_INFO
>> + *                Files: last_cmd_status
>> + *
>> + *        --> RFTYPE_MON_INFO
>> + *            --> <L3_MON> directory
>> + *                 Files: max_threshold_occupancy, mbm_local_bytes_config,
>> + *                        mbm_total_bytes_config, mon_features, num_rmids
>> + *
>> + *        --> RFTYPE_CTRL_INFO
>> + *            --> RFTYPE_RES_CACHE
>> + *                --> <L2/L3> directory
> 
> Maybe a nitpick but I wonder if it should be "L2,L3" to not create impression
> that it is either/or?

Sure.
> 
>> + *                     Files: bit_usage, cbm_mask, min_cbm_bits,
>> + *                            num_closids, shareable_bits
>> + *
>> + *            --> RFTYPE_RES_MB
>> + *                --> <MB/SMBA> directory
> 
> Same here ... perhaps "MB,SMBA"

Sure.
> 
>> + *                     Files: bandwidth_gran, delay_linear, min_bandwidth,
>> + *                            num_closids
> 
> Missing thread_throttle_mode

Will add it.
> 
>> + *
>> + *     base structure
>> + *     -----------------------------------------------------------
>> + *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
>> + *         Files: cpus, cpus_list, tasks
>> + *
>> + *     --> RFTYPE_CTRL_BASE (Files only for CTRL group)
>> + *         Files: mode, schemata, size
>>   */
>>  #define RFTYPE_INFO			BIT(0)
>>  #define RFTYPE_BASE			BIT(1)
>>
>>
> 
> I think this is a helpful addition. Thanks for doing this.

Sure. Welcome.Thanks
Babu Moger
