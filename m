Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285045FB3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJKNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJKNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:53:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66077FFB1;
        Tue, 11 Oct 2022 06:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSdfLeJ0znL8RmJrgaFaAd97R+YRvdftQHerxjnqN2Rkoy6TwNObD0tdqET5JHqD3COrZYcyxbYxZ5BTKObkMhCepTJaX4u4xHgN43N9SNkF2ZyW7CzoPfI0faNhlGEmKwxDbDykGw2g3HOQv/dzle5tclUQGx475jm5Qb2U83YMsSYpzF716tBKFlLgcCYWXzaWWJ4FdfgrZo8IDBGSaj7BLzLCkOO+UbikKS2rrdy+6ok+n1dTq8y5u+X7G949eMUK/eoVUKLHttumPYLHP7QAmWokN14J8TQLmYR3h5IsMB8E9onuPdVWqxq0NCST+WYZlYUfh/ImFdlncEr6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgisbe675RzvTfKdPH2Vrh0ZCeKNYFfLfUm5saWN9xM=;
 b=VMjbUJjbDvxHl2YUbXDxzdE7OsSQxImfVK2D+SFPt2TevruC8uZpKFPkHRsACT/hwaUG4bNxmsdbuvjm1TLzt9c2KAk500blvryIq9dc2pJ5BNnvyVqXJq+YNoBP9CSox/DbOQVRwWk0/Xr/5vPQBY2fz4zbASjLa5cKTh8i/U7SFSWoiu74W0JOfnNxJLvKnM2hyq7Eh0daZahQuGP6rso86wPST8UyzhSOzFyEKHJhWJpK1S80KDnBK4NpGFTEQZZUCkc7cspbbc7AwDUWYUWdk7ZE4UG2NR4Y4Q7vjMi1+heu9DZSIZXhUdV7OE1Uyg3IVd/doF75LZLsd0ffcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgisbe675RzvTfKdPH2Vrh0ZCeKNYFfLfUm5saWN9xM=;
 b=sC78gnJGTaPVClPOjQbO59pRdXnSNSMygvLKM6pSoUFb1RGHg/dCf70k7zV9y5DkrY2N/+GzLPXgENzQI+CSOU9Ko6yVEvvPDWf7vqjcoPgH8j7hQxlHEKXN11swrIO5qNPQxnhk+TrXw2H9SUR4OEquQ0Fp0AwHlnNZLKWTvGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 11 Oct
 2022 13:53:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%7]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 13:53:18 +0000
Message-ID: <5e160f16-4a85-2d18-90ae-dfd24d41037a@amd.com>
Date:   Tue, 11 Oct 2022 08:52:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
References: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
 <166543384024.23830.1715326237069935949.stgit@bmoger-ubuntu>
 <Y0UyFRJNjqBzCX8Z@debian.me>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Y0UyFRJNjqBzCX8Z@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3d95f9-4582-4cbc-fe81-08daab8ff3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oS2rL80vxt9Gh0nqdF/kO9iuVyCRKJHjHtlURhvVGij/Bj1ouYZsqLZ0gqPPg3kECRezcQfIBEzWQvlinlNx5tSbpeCVUlq/4EQywmruLYYo232/uiDzLvJDAIClYm/TzsAlBs8UepBCIZ+rRIeuWloNPbjhMbk9SPY5MKF5Hu/w8zj7/fbsyvHNZUF3wr3P6IaPlaS45InQwx/6gRnWDTW6igeCvIIUxfukfXsxFqIN+truixSE/RLxQGBn5pmnCgKC2EMfca/wtTBFot6bJvnRFKaWYXpLCwzKRT70tavoxhThGzvfmfmgZytzX9LdQilEKmu8vczfe2NGYyWfUHVzsvd+5FIAoEWeQQQGUMVEqzlYE8lY090GQ0cH2QDrOGqBPALo7SCoaDxs4Y2nTGcnjYMWZadpVm95WHK9TDuenVDZv6PEz/qOeD+xfY3piwyf6/XvSH2UbK8j01YVfMT0tFdN1MmdnIuMVQL+X3WiNL7RwBeFFXLcXE2SrclMhlMwljCPZpG25DACon4WJq/qf6+boBAXuBWV+gGexxsTMmWPkQ0fg9yZx1ArCgbC8Bq5zNLu4OJrN0pDcsFYaEfKO+LLq7rbcHHj0qeSQl0ZQlA139Q4fDaPQyZEW0uK4Sg7ozyScFe25h3ScDZ8P2KgML9edDdEjUg66ZMMws7WDU343+MxoTZso2rRrN7kXmUrvF7SaANVdWnhuegHIgwQnSmcEdftAMEalqg8TzctwizbfaNrUWLVNponeE8FZvwlhH/AnLpF2RS1oI0aeSpjcuaq83sUff9j91QEyS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(31686004)(6486002)(478600001)(83380400001)(6666004)(66476007)(186003)(8676002)(53546011)(3450700001)(66946007)(5660300002)(8936002)(36756003)(4326008)(316002)(2616005)(2906002)(6916009)(86362001)(66556008)(7416002)(26005)(6512007)(6506007)(30864003)(31696002)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2ROS1d5S3N4Z3MzcXJ1V3MrVWJXUjRYT3BNUVpxVWFrZy9xWURibVJ6NVZR?=
 =?utf-8?B?QlZhVlNBNkhwWjBDL2ZTVkhMOFZIRWNNWG52aEluUDJtOTZWTkNJYUpZbG9n?=
 =?utf-8?B?RGY4cUpHbFp5WG94Q2t0V2JpZ0VWNk1lNDhhRlJXTUNQUklBbXlzSHB4SFRU?=
 =?utf-8?B?ZGQybC9SaHN6NHFiVnRaakVJQmltOVdxL1BQaVRBcnRlVWFhN0JaWXlsNno4?=
 =?utf-8?B?TlducThoanIxOUx6NUxRd1VmQi80Z2pmOFRNeUxscFMyellJRUpNcjdQMW42?=
 =?utf-8?B?ak1pMVlySEJ4eFlQT1NvNXhsRmZ1TnRJUlViWFRQb2F6aUk4U0YyaVZWdm1B?=
 =?utf-8?B?RmZPUi93Nm9YNE5aTCtoQkFEQW1KRTRtNklwWkx1djJtZ1RoeEdvdnkzV0Nr?=
 =?utf-8?B?c0VscHBDVnNXSnVPN2FBbC9ST1FEU0FBOXpxUkZvOGRDd09Mdlc4Z2RKTHlx?=
 =?utf-8?B?QW9XSU9lbk8rbzZJV0NRTjdXeTY2QVJZbnNnQ0tVUVdKU1NRSEs3S0JkQ0VM?=
 =?utf-8?B?Um1uY3U4WTIxc0wwQ3FpUk9jMTNyTTdpeFNrYmlJN3dZakdJc0Z2RFBNRlF3?=
 =?utf-8?B?eEd5VllObUFkdUtxbCtDY25DVk1sNnkwM25aazBrSkdHUUZwVmV6U3p0WXVD?=
 =?utf-8?B?QTVTKzNLOHpZK2R3UllIVjhTT3lsaEcybk01c0VHZWlka1lvZ0cwcWVOQ3VS?=
 =?utf-8?B?N3NhZFlDRkhLNEpEL2dBbE9IUWdCYVdnRjVKS3BoZmVpV1VpWWFyU0xRby9V?=
 =?utf-8?B?RlAwZFJkTUNyTkw5MlM4V1NyTXl3U25zRWM2RzNsOXZ2UThTeGkra1FFM3lr?=
 =?utf-8?B?NmZPcE9Jc1J6cUNMYktzK29IR2ZQTWdxZUlsckpkbkkzYWhjdU5GN0dvNG40?=
 =?utf-8?B?RDVjTkhhYncvV1VOaTdPYzU3aUNIY3VVWlA1RE9aeGhUOXVzSVgvT0pKMUV5?=
 =?utf-8?B?a1JYMHFYSExPQ05BdFJrSWFmOHVhQ2MrOExSbGZQWHFhQ0pMZWVrUjN4aGg4?=
 =?utf-8?B?VjhtRVB3NFdtSXltS1pFS3ZRaEZvTlY3clBkWm0wcmluMUpOaXBjUmQzZXp6?=
 =?utf-8?B?bFo4eGlQK1FlL3N4Zm1OTHA2dWlxcy9qRGR0K2xwRnFqcEQ1VVFucUQvKzI2?=
 =?utf-8?B?Q2llSHZ6T1NXdHRaU0o1NU1qYjFNZUlwdWUvL2xnVWFwSHpNb0xpMnl6RzRm?=
 =?utf-8?B?VysySktKRjQwYmxmSHdrTzhYVndrRHc1cTI0amlhVCtjWEJScElPNWduTWNq?=
 =?utf-8?B?VlJHYUptNHJDR25TSWY1WUZiWWZWQWFSNVJjYWhFemhoSzVwTG14V3ZvREty?=
 =?utf-8?B?NlZTd2did2JDRjFkYndNR2w2bS9JNGxuZkVDNXJDRjkydVdZbWQyVEQybE40?=
 =?utf-8?B?UWlJZlZvNUM5dW1jek81U2RPRUxBYmQ0cXloVEMwa2NFQUZvWHgyTzMvYnkr?=
 =?utf-8?B?UlBZN2xwN2FnSEQ3MlRXM1QxaklCdHdtSTRzV3ExSEluYiszZjNmL3FjbDd6?=
 =?utf-8?B?WUo0WnUyVFhnTzF3cGhTTVBjcmV5Y1VPWnd6ak9FaFZoQkF6c3BwaXpFblNL?=
 =?utf-8?B?MUFCL2J1RU9JTktVTkdIL2lBYjZhYnU5NkU1SUp6eXNqUzZmbFh5clo3S01a?=
 =?utf-8?B?S3pTbEU1b2FoVmt1NUFVZ0k1RmJ4QzJyQ21EdVpQc0ZjMHRIVHRYWVk0YVc0?=
 =?utf-8?B?ZW5DTWRWMUd3dE1xS3VqbzgrWUdFUTRZQkRUaU5nZnUvUGJESmNEeDBnM0lw?=
 =?utf-8?B?WGxUWjZxb0lxNzJhVldsOEEzdDR2NmFCc29odmIvRlRvYk9nOUd3Sm0zYTZL?=
 =?utf-8?B?SE8ySEhHUFI3c053SGZjY0FMcE0vTHdjaW9LYk5Hdldhc0tCbVhwK3BUZlVB?=
 =?utf-8?B?dkJVNzk3ZkJJOXhiT0JYampMcE13cTBGTnBNZFQ4cEpneDhUakdTckRhbkNR?=
 =?utf-8?B?QTI1bHVKV2hnTzJNc3RWQmZhNnBIZ2U2OTc5MXRXTXBjNnE5czY0QjJ6N0gx?=
 =?utf-8?B?aGtmeXlEeHBUL0s4NlY3ejRqVkI3UmNYanN4R3VJa0poRU12eHlmQXRpUS9D?=
 =?utf-8?B?ZTNPcU1aMnJPbGNKdGJtVTBSeVdPaitobGFDN1lSajNHbTFDZHVOejZKeTFw?=
 =?utf-8?Q?+XTw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3d95f9-4582-4cbc-fe81-08daab8ff3b9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 13:53:18.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdxK5bQjVX66XOdeMJZ1fEv9FYMKoa8X08Op0GSx87liQozM5nsgN35j8hUaTnUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sanjaya,

On 10/11/22 04:06, Bagas Sanjaya wrote:
> On Mon, Oct 10, 2022 at 03:30:40PM -0500, Babu Moger wrote:
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 71a531061e4e..e2a59249d183 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
>>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
>>  flag bits:
>>  
>> -=============================================	================================
>> +===============================================	================================
>>  RDT (Resource Director Technology) Allocation	"rdt_a"
>>  CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>>  CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>>  CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
>>  MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
>>  MBA (Memory Bandwidth Allocation)		"mba"
>> -=============================================	================================
>> +SMBA (Slow Memory Bandwidth Allocation)         "smba"
>> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
>> +===============================================	================================
>>  
>>  To use the feature mount the file system::
>>  
>> @@ -161,6 +163,79 @@ with the following files:
>>  "mon_features":
>>  		Lists the monitoring events if
>>  		monitoring is enabled for the resource.
>> +                Example::
>> +
>> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> +                   llc_occupancy
>> +                   mbm_total_bytes
>> +                   mbm_local_bytes
>> +
>> +                If the system supports Bandwidth Monitoring Event
>> +                Configuration (BMEC), then the bandwidth events will
>> +                be configurable. The output will be::
>> +
>> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> +                   llc_occupancy
>> +                   mbm_total_bytes
>> +                   mbm_total_config
>> +                   mbm_local_bytes
>> +                   mbm_local_config
>> +
>> +"mbm_total_config", "mbm_local_config":
>> +        These files contain the current event configuration for the events
>> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
>> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
>> +        The event configuration settings are domain specific and will affect
>> +        all the CPUs in the domain.
>> +
>> +        Following are the types of events supported:
>> +
>> +        ====    ========================================================
>> +        Bits    Description
>> +        ====    ========================================================
>> +        6       Dirty Victims from the QOS domain to all types of memory
>> +        5       Reads to slow memory in the non-local NUMA domain
>> +        4       Reads to slow memory in the local NUMA domain
>> +        3       Non-temporal writes to non-local NUMA domain
>> +        2       Non-temporal writes to local NUMA domain
>> +        1       Reads to memory in the non-local NUMA domain
>> +        0       Reads to memory in the local NUMA domain
>> +        ====    ========================================================
>> +
>> +        By default, the mbm_total_bytes configuration is set to 0x7f to count
>> +        all the event types and the mbm_local_bytes configuration is set to
>> +        0x15 to count all the local memory events.
>> +
>> +        Examples:
>> +
>> +        * To view the current configuration::
>> +          ::
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +            0=0x7f;1=0x7f;2=0x7f;3=0x7f
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +            0=0x15;1=0x15;3=0x15;4=0x15
>> +
>> +        * To change the mbm_total_bytes to count only reads on domain 0.
>> +          To achieve this, the bits 0, 1, 4 and 5 needs to be set which is
>> +          110011b (in hex 0x33).
>> +          ::
>> +
>> +            # echo  "0=0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +            0=0x33;1=0x7f;2=0x7f;3=0x7f
>> +
>> +        * To change the mbm_local_bytes to count all the slow memory reads
>> +          on domain 1. To achieve this, the bits 4 and 5 needs to be set
>> +          which is 110000b (in hex 0x30).
>> +          ::
>> +
>> +            # echo  "1=0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +            0=0x15;1=0x30;3=0x15;4=0x15
>>  
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>> @@ -464,6 +539,25 @@ Memory bandwidth domain is L3 cache.
>>  
>>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>>  
>> +Slow Memory bandwidth Allocation (SMBA)
>> +-------------------------------------------------
>> +AMD hardware can support slow Memory bandwidth Allocation feature.
>> +Currently, CXL.memory is the only supported "slow" memory device.
>> +With the support of SMBA feature the hardware enables bandwidth
>> +allocation on the slow memory devices. If there are multiple slow
>> +memory devices in the system, then the throttling logic groups all
>> +the slow sources together and applies the limit on them as a whole.
>> +
>> +The presence of the SMBA feature(with CXL.memory) is independent
>> +of whether slow memory device is actually present in the system.
>> +If there is no slow memory in the system, then setting a SMBA limit
>> +will have no impact on the performance of the system.
>> +
>> +Slow Memory bandwidth domain is L3 cache.
>> +::
>> +
>> +	SMBA:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
>> +
>>  Reading/writing the schemata file
>>  ---------------------------------
>>  Reading the schemata file will show the state of all resources
>> @@ -479,6 +573,44 @@ which you wish to change.  E.g.
>>    L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
>>    L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
>>  
>> +Reading/writing the schemata file (on AMD systems)
>> +--------------------------------------------------
>> +Reading the schemata file will show the state of all resources
>> +on all domains. When writing the memory bandwidth allocation you
>> +only need to specify those values in an absolute number expressed
>> +in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you
>> +need to specify the value 16 (16 * 1/8 = 2). For example:
>> +::
>> +
>> +  # cat schemata
>> +    MB:0=2048;1=2048;2=2048;3=2048
>> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
>> +
>> +  # echo "MB:1=16" > schemata
>> +  # cat schemata
>> +    MB:0=2048;1=  16;2=2048;3=2048
>> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
>> +
>> +Reading/writing the schemata file (on AMD systems) with SMBA feature
>> +-------------------------------------------------------------------
> The heading above produces htmldocs warnings:
>
> Documentation/x86/resctrl.rst:595: WARNING: Title underline too short.
>
> Reading/writing the schemata file (on AMD systems) with SMBA feature
> -------------------------------------------------------------------
> Documentation/x86/resctrl.rst:595: WARNING: Title underline too short.
>
> Reading/writing the schemata file (on AMD systems) with SMBA feature
> -------------------------------------------------------------------
>
> I have applied the fixup:
Thanks
>
> ---- >8 ----
>
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index e2a59249d18322..145916828f2bae 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -592,7 +592,7 @@ need to specify the value 16 (16 * 1/8 = 2). For example:
>      L3:0=ffff;1=ffff;2=ffff;3=ffff
>  
>  Reading/writing the schemata file (on AMD systems) with SMBA feature
> --------------------------------------------------------------------
> +--------------------------------------------------------------------
>  Reading the schemata file will show the state of all resources
>  on all domains. When writing the memory bandwidth allocation you
>  only need to specify those values in an absolute number expressed
>
>> +Reading the schemata file will show the state of all resources
>> +on all domains. When writing the memory bandwidth allocation you
>> +only need to specify those values in an absolute number expressed
>> +in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you
>> +need to specify the value 64 (64 * 1/8 = 8).  E.g.
>> +::
>> +
>> +  # cat schemata
>> +    SMBA:0=2048;1=2048;2=2048;3=2048
>> +      MB:0=2048;1=2048;2=2048;3=2048
>> +      L3:0=ffff;1=ffff;2=ffff;3=ffff
>> +
>> +  # echo "SMBA:1=64" > schemata
>> +  # cat schemata
>> +    SMBA:0=2048;1=  64;2=2048;3=2048
>> +      MB:0=2048;1=2048;2=2048;3=2048
>> +      L3:0=ffff;1=ffff;2=ffff;3=ffff
>> +
>>  Cache Pseudo-Locking
>>  ====================
>>  CAT enables a user to specify the amount of cache space that an
>>
>>
> The rest of prose can be improved:
>
> ---- >8 ----
>
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 145916828f2bae..92b2c4e03a4a26 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -217,9 +217,9 @@ with the following files:
>              # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>              0=0x15;1=0x15;3=0x15;4=0x15
>  
> -        * To change the mbm_total_bytes to count only reads on domain 0.
> -          To achieve this, the bits 0, 1, 4 and 5 needs to be set which is
> -          110011b (in hex 0x33).
> +        * To change the mbm_total_bytes to count only reads on domain 0
> +          (the bits 0, 1, 4 and 5 needs to be set, which means 110011b
> +          {in hex 0x33}):
>            ::
>  
>              # echo  "0=0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
> @@ -228,8 +228,8 @@ with the following files:
>              0=0x33;1=0x7f;2=0x7f;3=0x7f
>  
>          * To change the mbm_local_bytes to count all the slow memory reads
> -          on domain 1. To achieve this, the bits 4 and 5 needs to be set
> -          which is 110000b (in hex 0x30).
> +          on domain 1 (the bits 4 and 5 needs to be set, which means 110000b
> +          {in hex 0x30}):
>            ::
>  
>              # echo  "1=0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
> @@ -540,20 +540,21 @@ Memory bandwidth domain is L3 cache.
>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>  
>  Slow Memory bandwidth Allocation (SMBA)
> --------------------------------------------------
> -AMD hardware can support slow Memory bandwidth Allocation feature.
> +---------------------------------------
> +AMD hardwares support Slow Memory bandwidth Allocation (SMBA) feature.
>  Currently, CXL.memory is the only supported "slow" memory device.
> -With the support of SMBA feature the hardware enables bandwidth
> -allocation on the slow memory devices. If there are multiple slow
> -memory devices in the system, then the throttling logic groups all
> -the slow sources together and applies the limit on them as a whole.
> +With the support of SMBA, the hardware enables bandwidth allocation
> +on the slow memory devices. If there are multiple such devices in the
> +system, the throttling logic groups all the slow sources together
> +and applies the limit on them as a whole.
>  
> -The presence of the SMBA feature(with CXL.memory) is independent
> -of whether slow memory device is actually present in the system.
> -If there is no slow memory in the system, then setting a SMBA limit
> -will have no impact on the performance of the system.
> +The presence of SMBA (with CXL.memory) is independent of slow memory
> +devices presence. If there is no such devices on the system, then
> +setting the configuring SMBA will have no impact on the performance
> +of the system.
>  
> -Slow Memory bandwidth domain is L3 cache.
> +The bandwidth domain for slow memory is L3 cache. Its schemata file
> +is formatted as:
>  ::
>  
>  	SMBA:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
> @@ -575,11 +576,13 @@ which you wish to change.  E.g.
>  
>  Reading/writing the schemata file (on AMD systems)
>  --------------------------------------------------
> -Reading the schemata file will show the state of all resources
> -on all domains. When writing the memory bandwidth allocation you
> -only need to specify those values in an absolute number expressed
> -in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you
> -need to specify the value 16 (16 * 1/8 = 2). For example:
> +Reading the schemata file will show the current bandwidth limit on all
> +domains. The allocated resources are in multiples of one eighth GB/s.
> +When writing to the file, you need to specify what cache id you wish to
> +configure the bandwidth limit.
> +
> +For example, to allocate 2GB/s limit on the first cache id:
> +
>  ::
>  
>    # cat schemata
> @@ -593,11 +596,11 @@ need to specify the value 16 (16 * 1/8 = 2). For example:
>  
>  Reading/writing the schemata file (on AMD systems) with SMBA feature
>  --------------------------------------------------------------------
> -Reading the schemata file will show the state of all resources
> -on all domains. When writing the memory bandwidth allocation you
> -only need to specify those values in an absolute number expressed
> -in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you
> -need to specify the value 64 (64 * 1/8 = 8).  E.g.
> +Reading and writing the schemata file is the same as without SMBA in
> +above section.
> +
> +For example, to allocate 8GB/s limit on the first cache id:
> +
>  ::
>  
>    # cat schemata
>
Thanks

Babu Moger

