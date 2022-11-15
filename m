Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982ED62A369
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiKOUv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbiKOUur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:50:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F409F30F41;
        Tue, 15 Nov 2022 12:50:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9Atfg8yN3On0tYcUxbXGkXKCFSS84KxV4FL3QSqPnTeiTQ+PFgi4A8/knbr2VZLn8EUyiSOMIeuOe0R76L6L47jPFOGQnSEIAT0ytmjHlHAjcIxrCz0C3icRRh7W8m6RR5IUmYrvajfv3LaNt3/1Vm9sdoGSS4gTGWMh73snXxoPP79zEzVsLedGCvNf955HOmmYIu9h9Z8ZcAL0i26e55X4G6Ih8UxpyMuUcl4FrP5ryan+HRK7xyR/weF8r+rl3PuMQjpbj0vWcY5MKUjZZGSlJ7dubsdxfSOzmoIr+UCAIhVcfj1Pb0QSPK90iHLa0MJ/I9GKl8tRr2mIi2qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSMtiFvsLcDM+sBIRjylADwiccFYwMnljxKZYC3/AME=;
 b=Sgcsut4+mjt9o7fRkoHQ4ITY/rfIh+zuNmyc7U5jSQ5s5DHbyzlmqBq2KMBwjwLnHI+2+GHQMBXDasu5voYvtf0S0XP+KsowmlKVjlYDFLRusAGHpEvmsXGOgxPk20E2FJr4a9VmEM0kAO9X9WSyObB6jzNMC0el8L8Y9LLMAPZ46aGdnqcCjK49dRSPQCaylnu41+ZWR3QqGGu/7MUP4ItTeol0oJguzW6tU5QJqcd7c+Kbwk5p/t/JF5ljb1lbA1CStUIUAAi4p0ILFgECesdOfN7DtRO50KxoS8PONCgcM4s+FR+jZnMgBwCuEi6bpG3k+uIKCYkr6q20Kl1tbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSMtiFvsLcDM+sBIRjylADwiccFYwMnljxKZYC3/AME=;
 b=cpmFCdm+nmdDvS0B/J0ufp31iem+TLMzI2hBDj5Gu/IqCX4HxeaaHQnz6Lb7Gv5RLzrYjs/N+sTtbPB8oFfsJYSt7HLq1lZMAJ7DLh6/GoR02xv18u+rPmamD1c3AkR6xyx/LtFdesS+M3IhJnWeFgW41M0nGp1lBN2beDQ0eAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 20:50:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 20:50:37 +0000
Message-ID: <f69a6454-a8c0-8ce1-0356-cde0d8b89c2a@amd.com>
Date:   Tue, 15 Nov 2022 14:50:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 00/13] Support for AMD QoS new features
Content-Language: en-US
To:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
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
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:610:74::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1fca47-07b5-4774-d3f8-08dac74b0c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYDNfwNfzBMLw58j548NJo24GPZ/wc9ggDzaXTu4tkskYIJmtxyZzTdvlN4ZyygT0TQrjU6PUC+XxUzbaxvsZdnPKIDycFMeTqukPjtKbX4je7zChGfw0dzkSh6ogJLChRq5olHYryF76LU1LsPjpJnhKcy8rCzHLJHa+Pp84snKtwgpfmnRNzQw2FyaWrugdmOJlXJicGToiqGQ/4VDpTMtU4UeDHpkgRYMBFB2dAAdrkL9hzkjsT2pE7JPffSbSpR+wFx2Dshn/+hhu0yQO4MpI/XAooMkRd1juixBGJ+xxB/knJIBOFjYQOIKpGu/MbLWhAiwLk+eoMzIWL4XuTNu+3VNbcXCvHVdaGgLs3O0LMEKNFAgSkZnrXG04zvhvNJ42T9ISenHVfwJWfQIO7cgGgGqxLf2q4w17/wtyaneabA42U0Dw5mCqei+oUFp8wJFZC8wwJilZt0Eo90IhdJLhDgw72jwmeo4EprGfXgiNbfK2qzqI8AwXFf5/PPMqFPgIcLKX0pkTeXZyMaGTmxe97cLnhEpPTnxBujm720Vq9tY6cIy+++Z0CpMnLb6murnfP2kh2l8z9dsZSuBiBdHTtSzEf8d19FDrycxjIJmWMfKXkEp/dXYVNu+kKy/yi96xQ7qxsKNiww09HlgyVTyCG0gupnG0AZ8EG9f82qI+EYzM11FBm+5nO5Sn9Q56EMyhM3vZ+BVCoXy+H0okyktQtkGh5NE0gvBqu/I5S1aBCcTgCMepX+9Gt9Q4MDPDUGT7Q6E6cgd12UhER1iRFb6l7pYpPehKGzSRBwBV5PIoYyLvK996E4utXb/2ao4ZGTW9PhQBy6r4eM0FwbJKhcaDPRlnT7VXEMxVeFK1K9FtljfkTvxHHeOmuAtoL8C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(186003)(26005)(3450700001)(2616005)(31686004)(6512007)(83380400001)(6666004)(8676002)(6486002)(4326008)(66476007)(86362001)(66556008)(66946007)(31696002)(478600001)(966005)(38100700002)(2906002)(6506007)(8936002)(5660300002)(36756003)(53546011)(7416002)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3lTUEZKRmd6ZTM3MStibmpDNlZCNmozVVB2UUpwYU0wMXIvdmhRd0ZTRHhZ?=
 =?utf-8?B?cFJUVVNYREYwY0RPRm9lRUtVUHMwNUxxK2k5aU5JUlFScG5nR0VRVHMvTmhM?=
 =?utf-8?B?T1g1aDVMZUlQU2tmZjcyZjFVUmxFUTlidncreml1UnNZbXc4ekZwaCtWNGhM?=
 =?utf-8?B?MHl0bEdzUk5KZ2pjN0dQR2VyTmdsMXZ5ckZoK2hraVVoUnlhcjZzRTFhVlNo?=
 =?utf-8?B?VDA2S2ZWVDR5Zmo1T2lUNzVXcnFRTGdJNGdFalg0dWRab0VlTXEvM21TSDlM?=
 =?utf-8?B?cXkraGplSmpkVVlPcXJNK2lDcW1Sa0ZmamNGdEJyYjlmelN2ZHpzSHFwdnFk?=
 =?utf-8?B?YVRGcnlyY1pOaWROUHMvM3ZIRVM0TndrelRGcDZwVDBrekU2bVBqQnBUaUpj?=
 =?utf-8?B?WjNFZE1PREE1QWh3TU9mQjJ5N1dxc2hwcjdUNHZIK3lpSW1IaGFld1JGUFR1?=
 =?utf-8?B?Q2Q1aXQ1aVdUNU1mVHRyaVllZStUeTY5U21zUFhGZmVBTUxvMFB6Z2ZnZEw3?=
 =?utf-8?B?Z2czdUFJbDZEQTQrRWxxSTdocTVzdUxtdUhta2xFRjU3YnJLTE82NTIwNyts?=
 =?utf-8?B?VmpRWlJhVTJXbmtpZ0RNSWhFK2ppTnVrQnUvNkdmRk4rTlB3TGdIUkZFQURI?=
 =?utf-8?B?N2F1SElBc3BQVTdrcVgvYlZtbk9Cb2xjWTFacDQrcWUxSXhZZm9mbjBab0NI?=
 =?utf-8?B?dkF1dFV4bXdndWpMUmRod29ZUkF6Y2l3Ri8zRGlDS0RWVDNNRC9WQmhPeElJ?=
 =?utf-8?B?Q25SNVJhSlhPeVNIcm5nKys2d0pvRTlLOUt4alhUTjRZVXlyVkl6cmV2eTBy?=
 =?utf-8?B?Y24zOFo2Q3NlZHVzZGExa3FlaFpZM09FeWtCVzFOeG5HWDZGT3ZDNzNZNThN?=
 =?utf-8?B?YnAyME4rdDU4Znk4V21RcUFJLy85Qk5EeURwYnFlblVBTWlzOC9kejBkdS9s?=
 =?utf-8?B?RzNjYTRBRkxkSVRmamwvb0JzeUhTN1BVQksraXJaSnYrS2FOQXg5RjRyRU83?=
 =?utf-8?B?UStPbnVMWnRDZGRhWnl2WndteG5PbEh2b1pjMWRjcHZwbG0rQ2gxdmpZZ3hz?=
 =?utf-8?B?K1VZT2lIV2wxd2RUSW1YdTJlRC9hWjV2dndJRkg1Wk45czN0cnVleUkvQVdO?=
 =?utf-8?B?ZUV0SzVlL0NUNTZPeDRieHBKbE9lL040eVp2dnJaUTZCNkdRUUEzNXRPUVds?=
 =?utf-8?B?QXBmUEU1M2dWSklmSklTaURETGNYeFVtblRIZmp0eFU5Y0lLOVlyRzNyamRR?=
 =?utf-8?B?K0xQOTZUMWo1TDFMeDFVV1BQZVJxQzdBMTBLekVjZ2NvemtYQ2FQN3Z5ZnQ4?=
 =?utf-8?B?YU41eUVDNGRGR3BaYnVOajlWdjdIbmFEWmZhM1daUnRGYXN5RkVIek5TUC8r?=
 =?utf-8?B?TE1PT0hENzlFZmEzVUlqa0tocjB5UStsNnVhY0E0VzJFUnR5ZUxWdWNyYkxO?=
 =?utf-8?B?b2c5eDZiY28wSEZIUTFMaytjc1B0MzhqT1NMN2NxU3dIYVZGU2dLa1BtVWQx?=
 =?utf-8?B?dTNQdEVvb2RYc01YQWVEeWdNSDI1aXpnTDFUOTc5YUt4NWlCMlFVY29wMk82?=
 =?utf-8?B?TFd1OGtEcVFYV2wrdXhidG0zREZjTE9kNk9mNjNLdGRMd21iNGZXa3ZKY2xq?=
 =?utf-8?B?Q1BVc1c5T1BKam1vLzlYWmtCdVZiaGhpODBBWU5iQm0rakJpSW9jWklTMmdX?=
 =?utf-8?B?VnczY3J0RXNYTDFCNzRtTUtqd29zMzRXZ0NlZXZIbE5LQVNnZnVCY29vUjg4?=
 =?utf-8?B?WHQzMFcxZk5yU3hLaE1Wc1lSZ0hrc1RibE5jMENmU2gvVzc4WXBWNStreDd3?=
 =?utf-8?B?UDRKWDNiNXUrUEl5d0pGQVlLYjVrbTM3dUF0YVYwME5mbFV1OG9TL2Y4dnl6?=
 =?utf-8?B?Unh0cGpOazRoSngzWkR4TXk2ck9zTEJvdnpwNnNNVjdSUnYxL0VVNTZZSVV5?=
 =?utf-8?B?OWM3aFZoSmRIaXRycExWRzhBVS8xSUhnV0JwVVJZMHp6SVltYmxZREl1YkVW?=
 =?utf-8?B?YXdmc0J6VmxCanA1NitSZkdVNU9rNkE5V0NVWHk3QnVxYndvOUVlbDNoSkVj?=
 =?utf-8?B?azROMmh5cFFMV0QxWjZFMnVkc2UrZFRTR28rdGV0K09nT1RiNCsybGJJc2Fh?=
 =?utf-8?Q?FPSm1+kkQB2bAX7qelMqjEOSU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1fca47-07b5-4774-d3f8-08dac74b0c9b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:50:37.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oowIIvfwtcYUukd8Xi+2z43qtUzT2wvOYFmbQlXOWn7Ij2bRPlUcCKXcA/CeAc4v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette and Others,

I was planning to refresh the series later this week. I have one comment
from Peter Newman.  Let me know if you have any comments.

Thanks

Babu


On 11/4/22 14:59, Babu Moger wrote:
> New AMD processors can now support following QoS features.
>
> 1. Slow Memory Bandwidth Allocation (SMBA)
>    With this feature, the QOS enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
>
>    Currently, CXL.memory is the only supported "slow" memory device. With
>    the support of SMBA feature the hardware enables bandwidth allocation
>    on the slow memory devices.
>
> 2. Bandwidth Monitoring Event Configuration (BMEC)
>    The bandwidth monitoring events mbm_total_event and mbm_local_event 
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not enough
>    to count all the different types are memory events. With the feature
>    BMEC, the users have the option to configure mbm_total_event and
>    mbm_local_event to count the specific type of events.
>
>    Following are the bitmaps of events supported.
>    Bits    Description
>      6       Dirty Victims from the QOS domain to all types of memory
>      5       Reads to slow memory in the non-local NUMA domain
>      4       Reads to slow memory in the local NUMA domain
>      3       Non-temporal writes to non-local NUMA domain
>      2       Non-temporal writes to local NUMA domain
>      1       Reads to memory in the non-local NUMA domain
>      0       Reads to memory in the local NUMA domain
>
> This series adds support for these features.
>
> Feature description is available in the specification, "AMD64 Technology Platform Quality of Service Extensions, Revision: 1.03 Publication # 56375
> Revision: 1.03 Issue Date: February 2022".
>
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v8:
>  Changes:
>  1. Removed init attribute for rdt_cpu_has to make it available for all the files.
>  2. Updated the change log for mon_features to correct the names of config files.
>  3. Changed configuration file name from mbm_total_config to mbm_total_bytes_config.
>     This is more consistant with other changes.
>  4. Added lock protection while reading/writing the config file.
>  5. Other few minor text changes. I have been missing few comments in last couple of
>     revisions. Hope I have addressed all of them this time.
>
> v7:
>  https://lore.kernel.org/lkml/166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu/
>  Changes:
>  Not much of a change. Missed one comment from Reinette from v5. Corrected it now.
>  Few format corrections from Sanjaya.
>
> v6:
>  https://lore.kernel.org/lkml/166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu/
>  Summary of changes:
>  1. Rebased on top of lastest tip tree. Fixed few minor conflicts.
>  2. Fixed format issue with scattered.c.
>  3. Removed config_name from the structure mon_evt. It is not required.
>  4. The read/write format for mbm_total_config and mbm_local_config will be same
>     as schemata format "id0=val0;id1=val1;...". This is comment from Fenghua.
>  5. Added more comments MSR_IA32_EVT_CFG_BASE writng.
>  5. Few text changes in resctrl.rst 
>  
> v5:
>   https://lore.kernel.org/lkml/166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu/
>   Summary of changes.
>   1. Split the series into two. The first two patches are bug fixes. So, sent them separate.
>   2. The config files mbm_total_config and mbm_local_config are now under
>      /sys/fs/resctrl/info/L3_MON/. Removed these config files from mon groups.
>   3. Ran "checkpatch --strict --codespell" on all the patches. Looks good with few known exceptions.
>   4. Few minor text changes in resctrl.rst file. 
>
> v4:
>   https://lore.kernel.org/lkml/166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu/
>   Got numerios of comments from Reinette Chatre. Addressed most of them. 
>   Summary of changes.
>   1. Removed mon_configurable under /sys/fs/resctrl/info/L3_MON/.  
>   2. Updated mon_features texts if the BMEC is supported.
>   3. Added more explanation about the slow memory support.
>   4. Replaced smp_call_function_many with on_each_cpu_mask call.
>   5. Removed arch_has_empty_bitmaps
>   6. Few other text changes.
>   7. Removed Reviewed-by if the patch is modified.
>   8. Rebased the patches to latest tip.
>
> v3:
>   https://lore.kernel.org/lkml/166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu/
>   a. Rebased the patches to latest tip. Resolved some conflicts.
>      https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>   b. Taken care of feedback from Bagas Sanjaya.
>   c. Added Reviewed by from Mingo.
>   Note: I am still looking for comments from Reinette or Fenghua.
>
> v2:
>   https://lore.kernel.org/lkml/165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu/
>   a. Rebased the patches to latest stable tree (v5.18.15). Resolved some conflicts.
>   b. Added the patch to fix CBM issue on AMD. This was originally discussed
>      https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/
>
> v1:
>   https://lore.kernel.org/lkml/165757543252.416408.13547339307237713464.stgit@bmoger-ubuntu/
>
> Babu Moger (13):
>       x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag
>       x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
>       x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature flag
>       x86/resctrl: Include new features in command line options
>       x86/resctrl: Detect and configure Slow Memory Bandwidth Allocation
>       x86/resctrl: Remove the init attribute for rdt_cpu_has()
>       x86/resctrl: Introduce data structure to support monitor configuration
>       x86/resctrl: Add sysfs interface to read mbm_total_bytes_config
>       x86/resctrl: Add sysfs interface to read mbm_local_bytes_config
>       x86/resctrl: Add sysfs interface to write mbm_total_bytes_config
>       x86/resctrl: Add sysfs interface to write mbm_local_bytes_config
>       x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()
>       Documentation/x86: Update resctrl.rst for new features
>
>
>  .../admin-guide/kernel-parameters.txt         |   2 +-
>  Documentation/x86/resctrl.rst                 | 139 +++++++-
>  arch/x86/include/asm/cpufeatures.h            |   2 +
>  arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
>  arch/x86/kernel/cpu/resctrl/core.c            |  56 +++-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h        |  33 ++
>  arch/x86/kernel/cpu/resctrl/monitor.c         |   7 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 304 ++++++++++++++++--
>  arch/x86/kernel/cpu/scattered.c               |   2 +
>  10 files changed, 515 insertions(+), 33 deletions(-)
>
> --
>
-- 
Thanks
Babu Moger

