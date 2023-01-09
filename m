Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA743663367
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjAIVpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjAIVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:44:54 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0657E3BE84;
        Mon,  9 Jan 2023 13:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHHwgct2nET1fT4Tu48f1mFXdfIPuA5INejxc1vbkt4DiceM8r0Ase3aYbyP4SOzN1Sk9u1sBKbO/ZOo+7mFyebH2cIqDKctQIYmh6e92kDsMQRqNa9ev6lfIZLLcoTufVhO8KUv/T2WObcl7P89i8TD02AM7mPJwfIj4P+UPvFsWoZNh0V8mkE9mChaSBwEz9w/NsElaR7nlMHABwBQd7JjvHwCMfBWq0K4v1T24ksSzpNQBiCnhYv2VB4KIptQwRqcdQz+NABJ4J1q7cqLpBHCsFZCqG8rk9z+IAdyawel3eO/taAbYq9SWq+cpzCkwcwRuTUH6C/J/LRThebuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZnGwUf+vUXT2wV5iyDB6q/YZST9qoe1kgZf0ICMZG8=;
 b=jtjGAqdHwX6MIUYNzRuPTEWGeVbmYcCl1/22shoRvpWIC3wCHcrI4k9G49nbnczziw1JrNXrqUzz7hn1FuQASt40G1GcxXMRR/Y0zsNZZGozzAI4OfJMWV+1fcJaVExrapVCbtFEuvhpBfG8yoawzWeU75RR0cNgvjX06HRrziOoi4xQgfrZnLH+/2QE12RqFv9jCuh3u0upAR3fjSmtiNxQl3aDLgMKR+4E5QMGyUll2qx5pz9xD+CKCb5tY+Lrj3NPOSjzxcvhR4mQeI/3ZRCCaSkllUlrsTIRX1WefTx2EStNS4wC00/8NR+J5c3Yg6MFUWpFHvrQDFL2vW/9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZnGwUf+vUXT2wV5iyDB6q/YZST9qoe1kgZf0ICMZG8=;
 b=ZcfhjbxmPGm0zamqjmyfFp3NI3gt3v+R3hkMoE4wEfpbr20KD+AeoONCdqSJLNs3oXZgqY3JZ1CX5du69qMUZFQlAIy5QhEyTbM1zkZ55CPvwussawh2tQyMvkmIfW8BVSptwHpCEyoJW/tCyeTWjyRMoj2wLtbqymNYu8UN8RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 21:44:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 21:44:36 +0000
Message-ID: <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com>
Date:   Mon, 9 Jan 2023 15:44:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-5-babu.moger@amd.com> <Y7xjxUj+KnOEJssZ@zn.tnic>
 <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com> <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:610:e4::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 0702c13c-af33-448a-92c2-08daf28ab3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+aVxufxT6j+5V38VRaA4AelwPH+8zfhlJCoTckp93JOxCvz7ir/hV6w2RKxnq57LIuekraf6lRIcj92N5yTtK08LLI5vJTRgJlh/TB/DtMKZBXjJQWAlT/+rN/3XH/7Q3pZeHrUy9YGhBdnID20zTOntxEy2CLkdZHAdEfO3Ft+6tYZKH5RITYG7un3kxFtWBuYbmC0bGLa1Y1fdKi1YtqluARC3TwhqryYPG+V0sUlfYczkMtPv+X/sIZPZZLC/tpoCTVK7hVlWZUaPpJF1U7OorQeWL0AN59iIor8w8B/ssibjLakICq5Tn54+fM3isWBvbPpIX1V0M1YJSBjTZlEFV8FfSFRlLdVJBIgpYdJCHoHuhCbOKv1KlDs3VowyP3vVPsP6n1s6+ynjnABIn8jvWuGHSQlpPMZVosph4khGhHlB8MxjSXpmw+kAOStLYkRZLmHIKTGOzq2pckh6xNjEB7+IDnsLZXFJgNs7DDugsv3lnUZ6TypTB8j/WACv4XmVIQ9bx5964RR5/KonLB7bqo1g2rn6/rsA8ZF2GqZyRddPAmqhoWO5d25UxOGtRnLQ/9oyeB/Uh9jJSgkT2G1GwqH8UZ2To72MuyT5MMcsv3perSeVC5vkimQL7LVM1nrRGfIkEVCUN633+7KpgHJ9+T/Dm5izBqxwBLjS15AHvBXDnaK3h3jefxRdmI0jNKbRkBK2jxQlzsuyx9C21xl8DTLRA8LeeF6f2R8M3sABJEqlS5F2wkgXvoVJb0kZdZ2GMdg0Ifc6n+PwOxk9w8uebgQxnKOj+FXvXSZc90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(7416002)(7406005)(316002)(5660300002)(26005)(6512007)(186003)(478600001)(6486002)(2616005)(31696002)(41300700001)(110136005)(54906003)(4326008)(66476007)(66556008)(66946007)(8676002)(8936002)(83380400001)(86362001)(36756003)(6666004)(53546011)(31686004)(6506007)(38100700002)(2906002)(3450700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHoyV2hBTkY3Um9ES1VYRlQ2OEcrb0IxZ1NIckFnNXViM0NjMmdsZ1ZaSmRy?=
 =?utf-8?B?OFMwNHlUUExPUy9yemFIc2ozSnlmTitWLzJreFlwb1JJd2FjbnRKNVc2MXB3?=
 =?utf-8?B?TUwreEVtQjc4aTBrelJYVUF6TWorb1hEdVdaMGxaMk5DQjUyaGd5TmIrU3lo?=
 =?utf-8?B?V1Blc3VLNnhlUEI4L2lBZVVTOG13VU96Ny9HZS9xNmdlbXlKSVlmSTVhcThq?=
 =?utf-8?B?bDV5eVoyS3B4M0thZzNPc0s3N3FmNCtqWFFBbWE4UkhNZGxBN0tvNE10elRw?=
 =?utf-8?B?SjlEdlhwTVZScVFud0RlUzFhZWw5UWlQQlBoelJzNGVKVThlMCtMY1V0cTlH?=
 =?utf-8?B?ZG1LaXh2TDBJWnRoMW9WQzFQZGtxY1BpZ2RLd3lQbktTdTE4bTk5bGwyYXVX?=
 =?utf-8?B?cVNIckljeFlaVDBCNGhmSWJ3ejJVM1NVRk94Sm5JL0lSQkJ5QUY4ZU9Udmsz?=
 =?utf-8?B?R1hvaHFFSlRnV05XanljTU02TUM2eDEvSDg0RlhRNVFpYXdDZTIvTm5HR2Ew?=
 =?utf-8?B?dml4WWNpUHJad0RnM0wyM3ZHc09NZDVVTDMwQ3N2SXFPTlQxamIwb2ppbkhm?=
 =?utf-8?B?SGlUbzYwV3Bid2srb1gxZW9nRVpJSXp2cVI2ajZhUGttL3JPb2Z4dWxDZkVL?=
 =?utf-8?B?a3NBSi9DR3p3NTJ0TVFlY2w4SllZeXBZU01VR3diUG1KTFJ6VHdldzh0dzI5?=
 =?utf-8?B?VXRUd1FvT0pqTzZBQzl3M1JHZ0RXaXplK0Rvd05WeER4clZ5NVFwQUxLWmFM?=
 =?utf-8?B?RytycW0vS3FadGpzdkFkc0xLdzEvK1hLREVta0pkV2RnVkZxU0V1N0tRREJI?=
 =?utf-8?B?NGlHRVFFcGdhNWpmWVYvL0NhZ3JRUmJ2NjAwTm4wandXUVAxblpBNzlWbDF3?=
 =?utf-8?B?RUxXcmtEQWUzUm4vZzBBL0wyWlRkZmhJVk1NRFQzUm5XUG5rZTZSRHRZMk1K?=
 =?utf-8?B?VExtbmRkeTNnY3JqeExQOEIvTGd3ZG5QSlhSN0hDRTdDL1J1QmtwOWVCbkxN?=
 =?utf-8?B?Vnl0bXNTMFgxblZtYXFZNm8zZVRxN1dpR3pxNWIxTGRSeVEvYitna2NzcGJH?=
 =?utf-8?B?STRLOGlwR1l4V0NDWVpMY0pDcytTcGc1Y0xBVUNpUjVjV0dzbUtiOWJzWFZQ?=
 =?utf-8?B?cTRodUNEVENwK05ZOHZDRGNvUWxpR2lVb1hXWDJ6TU9neHluVjRVc1JOMjgr?=
 =?utf-8?B?YXBCWGQxc0EyVFQreW5kRWVSc0pJbE5NaHdPVmFXdCtsVG1UYk5rWWh4OGp3?=
 =?utf-8?B?dWVGNktDZ0g2NDBXWVNTQUZRaVZ2T3drTFhmdjNFSkw3aytPQUZCclhCV1JL?=
 =?utf-8?B?WEtCNXBKRUNlTjhHdjE5cTI4dWN1RlVhUGIzcWVQM01rNlZvTm1TMEgrbFp5?=
 =?utf-8?B?VElSK0ZMYnRLK0E3cjdCM29KdEtGQkIxL2o0QnkwdmttUnkrRGxFTjZYNllt?=
 =?utf-8?B?bjVkbjVRaTJZOGhMb0QrdnJvRlg0Smx6R0FlV1RoTjV4Tkh4c0dRazE3T2U0?=
 =?utf-8?B?RVoyempwMjF1dEsvaERKV0hadVloT3h1M0NjUytDQkJ5TlZnNDV2SFhBbWpn?=
 =?utf-8?B?NHN0Tm8xdk5rYVhmTS9LSFRqR1dLMkxZb0w3amV5azNkZ0dreVZIUndUaTV2?=
 =?utf-8?B?RWV3SyszQWk2VFBSYWNPWGN6MllNRDBnS3dEQ1JWeklEWEpSOFpOamttVGRq?=
 =?utf-8?B?Vy9QbjFySDlYMElVWlBWTW05czNiVFgraHFyN3hYTXZKRVU0R2hsUEhvVjRa?=
 =?utf-8?B?V0dpRlZ1TG9SU3JxQUhPUTZmRURER0lMM0lhMWRrdXlJbGJXa1M4bXpLUWZi?=
 =?utf-8?B?VnZaVGsweXMxNnV6NkkrR1lkZEcyUFRRdkNWdm01T09BSTVyUU43djdYVWFr?=
 =?utf-8?B?Wk92RkwrNjVvbDlNNzFaSitSZzRYdnlVbTJzbDhkOU9lSnVJY0s4bDdMYmxh?=
 =?utf-8?B?MjN3VXNlVi94NHp5SHVjQlFFQVAxUWoxS3hOL1RiQlNtQzFOcmdQZGpIWExP?=
 =?utf-8?B?Mkd6NGk3S0dFZWZiaWsrcmdmWFJIYmh1YlZQTjEwb1NvSXhicytGSHlKMStP?=
 =?utf-8?B?RVRDUS9HNExLNjRTR2d6ZTM1ek1FdDBtY0x3SldMd1JxK1VjVStOajZrK2t1?=
 =?utf-8?Q?3FuOe09hGAzqY/G5s9p8H6vIM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0702c13c-af33-448a-92c2-08daf28ab3aa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 21:44:36.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVgVpxnAaGnl3CbvED4yNrsBj8Yr+TqeMpJMLFpZs3CuhlPjHPXn5+9pDYImeICX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/23 15:25, Luck, Tony wrote:
>>> All the QoS(or RDT) features are visible so far. If we make them visible,
>>> users can easily figure out if this specific feature is supported or not.
>> What would be the actual, real-life use case where the presence of those flags
>> in /proc/cpuinfo is really needed?
> It feels like the old "rule" was "make it visible in /proc/cpuid" unless there was some
> good reason NOT to do it.  But that has resulted in the "flags" line getting ridiculously
> long and hard for humans to read (141 fields with 926 bytes on my Skylake, more on
> more modern CPUs).
>
> For RDT I don't see a lot of value in knowing that a feature is present ... all of them
> have parameters on how many things they can control/monitor ... so you have to
> either go parse the CPUID leaves, or just mount /sys/fs/resctrl and look in the "info"
> directory to get the extra information you need to do anything with RDT.
>
> I don't know if we'd break anything if we dropped:
>
>   cat_l3 cdp_l3 mba cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
>
> from /proc/cpuinfo.
>
> Perhaps the "rule" should be written in Documentation/{somewhere}?

Actually, these feature bits are referred in Documentation/x86/resctrl.rst

This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86
/proc/cpuinfo
flag bits:

===============================================
================================
RDT (Resource Director Technology) Allocation   "rdt_a"
CAT (Cache Allocation Technology)               "cat_l3", "cat_l2"
CDP (Code and Data Prioritization)              "cdp_l3", "cdp_l2"
CQM (Cache QoS Monitoring)                      "cqm_llc", "cqm_occup_llc"
MBM (Memory Bandwidth Monitoring)               "cqm_mbm_total",
"cqm_mbm_local"
MBA (Memory Bandwidth Allocation)               "mba"
SMBA (Slow Memory Bandwidth Allocation)         "smba"
BMEC (Bandwidth Monitoring Event Configuration) "bmec"
===============================================
================================

So, if we remove them, we need to update here also.

Thanks

Babu


