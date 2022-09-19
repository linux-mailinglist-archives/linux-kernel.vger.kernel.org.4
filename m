Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE15BD1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiISQHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiISQHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:07:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F13103D;
        Mon, 19 Sep 2022 09:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu8voVsvkYJoTmBvIJ/OmfIIoTBgPgr9BPXpMhvCIoz91sToRgDM7zSqFaA39e1jNIj4lyRs0OjwzasCob/Ln+PUSGtNs+QCUAhBKZ3xtrbZm1kra/KcwBMjrpYphHy0WMlU1JZqnwVztB8BJd/8Qvaj5GOO54wcl4lLpQBIfZqjcSQlHO7vBnB5+ymWYlYO8JM2vNm7lRvuwy/IHDGVonOk+I4pXUi4KrSW6SDrnIqQYFsX5mAsMJgARzPNMEW8CRZFi96IuXFzoP0wJoa72xk6bUsQIZYh2IFuvnLFjiEHzMVhrYJUuN2s7/mHRpaazjdYXs+hInT2o99bHKJkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6WrajInYYuEqAWqHIeDBxXABw99WCg/pEMXYuDJaCk=;
 b=TKzgnQcQ95+phtlM6sTnedl3rTkNvgSwF5P9BzsdMash7CdNCqsuGTg560Gvkmhu220M2CJR6hYqJK0/O7SdYg8hnGuIrN9vswUewvbplxJI3EaWTvcsqATymAcF8IkDtVST1AwOP17N9SanNTRFly5AFSi2WZFBxxe1LsPwIVzkbtXn58R5ruTxSbjfVHK15KDm21TbItLPoZOlBxzi9gmv6/t6pAH1QhmKkx5KNZi8Ibp3U29Wm3/rkFdirBIwh7j4i/PNx4olxs2H1OEKZCQ/3MVM6GCwnpZcddkn/N5SJwTAmVlVzpgBAR24Lc5z5k7loJMUU0CgZIwbthPsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6WrajInYYuEqAWqHIeDBxXABw99WCg/pEMXYuDJaCk=;
 b=tXiJcxaH2f+H5YPE/MZHx6LTqJYADZeJmHa2NgSnCD8jAfrWp1pJYwFxzlQ1o+wbFi4ZCQTFkBJuoPuqmLp7N2/Ti2t5NWwbyWLDjKa1e4SpVbrH+Zl094EcNgVwyg8mj+sMVsONXmrRe/mC93saGnOq1lNk/FhbTHTkg55YAdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 16:07:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 16:07:41 +0000
Message-ID: <930cccea-00b6-3000-af2c-04fe8f464ad0@amd.com>
Date:   Mon, 19 Sep 2022 11:07:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 10/13] x86/resctrl: Add the sysfs interface to read the
 event configuration
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
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257366902.1043018.16087054015308149859.stgit@bmoger-ubuntu>
 <36f0466f-517e-050d-5fae-9325ec28ebd6@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <36f0466f-517e-050d-5fae-9325ec28ebd6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:208:15e::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BN9PR12MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb7a50d-a607-4867-d39d-08da9a591498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pVOmmcXrkzJxjjN37rkJo/2brTLr8CklTW6dGpHDRf16tFS/GzUs55VpINRkjifA+kjxq20ACNZtSpdDWdr97zkY6cGJsv8dcI2Kyvat+6WHQs+uGeD2rTNTyjuMTXAUVu43NyxmwXeB6JFCWEme0QicNANzLuVOofYZ1iNpPWDI4GtcmV2j+8yk/bvYHPa1egRJDLFeVmKfo2C3dZ3VlEauQ1aqDiKWqAY3PRderxUOsxS47A+5r9j9cBdCg0tI+84Q2lwHgBlw6fuZOo0kv1S/sYbQxKVyT2t3AeOSetSgMqAd/Yf/hye8kJZ4gAI1Lrho9VJmuI7Zrfrg6ilkYNNMZBBDLfy0lEMQJ1VvmS5a41djyUDUIEMJWHuDAAhBo/FfOfc6KEYvFAjq6IIizOpXDeo/fEnbOSrNYKTEbMlKs+fIgP6KX4+dKKDR5oxV2B0WGjkkE16ybfjJFQwc3HaKs5YhRwRUKu513PDVoC/AJVEcylp1bd8jl6oHInJZdzcXLB/5gbqYctDb+BWX5IsLB/hDTB5QC6VAi6xSBZo7fp2V3JsQLPhplgsAKzcD5f9qbgvtfnndYvzLypE3Dx9H0fdv+sWbwU2Mn70BLiLCLBlW0M4MkWDC1/G73ETqwwfBxM/d9cLgzUXthh2MoLYZqNhn3rkvwJ0gJn15U8pbWuIyoteFEvjQTnGdFEcjr8+gWujDcAUo2PWieY/xWGfFPhUwLZg958QAM/+qo5Eo78ePfvlEENVG4J3NzE/9qM5NmL/tzIT/iIGOXiIWsChfxCZK0tTOQyoW87bpRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(6506007)(53546011)(2906002)(186003)(2616005)(3450700001)(26005)(6512007)(86362001)(31696002)(316002)(6486002)(4326008)(41300700001)(8676002)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(31686004)(7416002)(8936002)(5660300002)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZzMFFPV0RjOElLMXNmUzZURWU3SktVTzBGL3RyZ1VoM3BVK0g5MUJUc0Z0?=
 =?utf-8?B?YVVxV2w3aW9xR1Q1cE5xdHg4U3g3SnV2SVJoUXJ2NEdDMFhRdmZVTlpkdDRF?=
 =?utf-8?B?TjJEWHVNb3BVWHNOSUtjYTgrcTJXSWowc1JRNWIvaVgvdis4Z2JONnlUNVJC?=
 =?utf-8?B?elU4bjY5a0VvbElhczhFc2xjZ1VWRkE5SUd1Z0E4eWxDY3hCaWdlRnFUdCtU?=
 =?utf-8?B?VVpyY09QZSszVm5Hd3pDMTR0MXRGdUtOa2V4TXI3N0JFZ0VkbER0Zld6aHBE?=
 =?utf-8?B?RTlqVmN2TkRZU2pnVFViUytEaDFLMU1iUVJWNFpMQlgySDJ2SmYxdjYxVFJz?=
 =?utf-8?B?TnFCbjF0N1hwU2NmR3FsUjd4TDhwSjlMUTFlRUNxRlBNUkJoaEpOb2hMR2h4?=
 =?utf-8?B?RUdnamM0QXFTblVMZUFGVm1PMy96UEVKTG5ZcHYwU2t5T3JlMXdQQWhDRW1H?=
 =?utf-8?B?K0phVWVnVmQ4WmhGaWoxK1R3ZitmUGUveDVuMFRkc1lLVTVXYkNHUVB5YVIx?=
 =?utf-8?B?dEtUaSt0bUJsWEtyQTJFSURxUDJCTkdPVWxvVkxxODRXTWZMNkQzRGFiY2tW?=
 =?utf-8?B?WnBxM1pOYjNORjRiQWtaZDVsclYzcG5jNWwxYTNyQm1yN2NnaE1ySEtSNHV6?=
 =?utf-8?B?d1BrVW5lMk5qY01FY0Y4cVpuNkRNblNXeHp0MVhLWXNBbVgzaHMzUHhxWDBH?=
 =?utf-8?B?Qkg0U2VLc0J3aU44bUpJZGI4c0FsT2JUbkMxNGtTWlR5TW11ZElGRk9tRmFk?=
 =?utf-8?B?dkdCUGNhNGdpVjZhVzFLRnkxYkpyN2VuZVVMNFZ4b0N5UUJoamY5YmxVMGRz?=
 =?utf-8?B?U3ZzbHdpektwd1gxTjhVWm5JbHd2WEJubWhnUGJvbE0vTXMwT3I4RzdFRjVu?=
 =?utf-8?B?YlBwdFRaaTVYSDVnVUI0K2Y4enRCeW0wV3VKNVBzaXBRY0RubjhQS0ZvRXZ2?=
 =?utf-8?B?Unc0cmZlUzFXZUc3bmdlVWJhVWE5bzRCbTcxT0MyY2dKYVhXR1QxcmZBUDZB?=
 =?utf-8?B?WndWZ1E1c08zbWl0YmNiNkozRWpsMWV6a0I3YUcvaTA4VFFZYkVYbTZxSGFE?=
 =?utf-8?B?dUdPbnNwb3ZuMEZPTW5UdDd2RG9kQXZxa0kzZ3dmdFpXSXpYTXZpSStUajMy?=
 =?utf-8?B?MDZZYXpIdG9wOHFOMVB0d3RYRy9kSDFWdmxoRXlqeU1JVXF0ME1kMktBNFc5?=
 =?utf-8?B?bk9nMS8zOFVwZXFTeG41aWQwbEJXOVQxdXNUN1dxTWdESmtmVndieWxsUEFX?=
 =?utf-8?B?bmIyTHZ5L0M5VDBvQ2xOdlh3dFNVa3NZUkhabFpENXVZOEVTVWZFTjlKNFo1?=
 =?utf-8?B?Z3N3aVZsMGk0YUVQcVJvekNLSEpxR1ltN29tUHBDVDFJMmtRUGp0MFZkakFE?=
 =?utf-8?B?ajEyYnRRbGE4NnNOaEhPeXhDL2VObHZjUFhJSTdHaTFSQ1JZZUpHRGM4WTlU?=
 =?utf-8?B?K1JoNmE5aytwa2dBWW5CV0M1OEhKeEtoUHdRTmVOZlBsdVFHcldiclJUVVZW?=
 =?utf-8?B?L0xKcGFhK2kvYzlzZTBlc2grdzhTTUhOcTBsMDE3UDh3dlp6UlQxbWEvV1or?=
 =?utf-8?B?djM4eGNPRnlSQ3AyNm5kQklzS1l5TlpWTnd4cDdybUpsQkpmMzhGSXFhNEdV?=
 =?utf-8?B?VWt1OEdjM1RxaFFiOUZveURNQ2NkRmZIM3Azdy9PK3ZKdC81SVNrcCt0N1hT?=
 =?utf-8?B?WnJzdmM1a0JkSGI1QlpnOWdPQTZmRzV6bmlZZDZpUTEyUVFhZFExcE41NTEz?=
 =?utf-8?B?Wm5ISEhFTThJeE85aDd3OEtiL1R6NFpoakRGUU5xYlRQaWJ2RjZyNkNFTzdj?=
 =?utf-8?B?UWd6R0pscjRKMmlBMnFPWDFNbUlmT1pGbmF1WFQxYXk5Ri9IRXRTR1QyUVox?=
 =?utf-8?B?bjJzS3JBN0NLREd3ZWorVy90QUtQQmhySSt0THgwVThaczhOZ0JheXFYc0Vm?=
 =?utf-8?B?M0dpTU1UbDZRTmk5dzBwSDRCaWEyREovV3pJNGdVeXJFVW1sZmdLUW5tenMr?=
 =?utf-8?B?dFVIV25rNzRLNitRMklsZDRKb1pTUFJaQW9OU2NBbDZKZ0dIOGdjbTg1bFp4?=
 =?utf-8?B?bkFSQUl1LzdBRS96WitRM1dEM1RTeVlneWVLa0oycHFETkZBNWxsdHZLdzhh?=
 =?utf-8?Q?t1LuVA4+9deQr3VuGZm0XUxdK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb7a50d-a607-4867-d39d-08da9a591498
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 16:07:41.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UY9ss31FPZ6LSkoSIhojT5Hu+TMMwBVb4x4F2VqOBAHKGKDvQ1O1lSYeQ3AovKzn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,


On 9/16/22 10:59, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/7/2022 11:01 AM, Babu Moger wrote:
>> The current event configuration can be viewed by the user by reading
>> the sysfs configuration file.
>>
>> Following are the types of events supported:
>>
>> ====  ===========================================================
>> Bits   Description
>> ====  ===========================================================
>> 6      Dirty Victims from the QOS domain to all types of memory
>> 5      Reads to slow memory in the non-local NUMA domain
>> 4      Reads to slow memory in the local NUMA domain
>> 3      Non-temporal writes to non-local NUMA domain
>> 2      Non-temporal writes to local NUMA domain
>> 1      Reads to memory in the non-local NUMA domain
>> 0      Reads to memory in the local NUMA domain
>> ====  ===========================================================
>>
> ...
>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 45923eb4022f..96f439324d78 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -15,6 +15,7 @@
>>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>> +#define MSR_IA32_EVT_CFG_BASE		0xc0000400
>>  
>>  #define MSR_IA32_QM_CTR			0x0c8e
>>  #define MSR_IA32_QM_EVTSEL		0x0c8d
>> @@ -50,6 +51,29 @@
>>   */
>>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>>  
>> +/* Reads to Local DRAM Memory */
> What prompted the terminology switch between the
> changelog ("local NUMA")  and the comments ("DRAM")?
oh. ok. Will change it.
>
>> +#define READS_TO_LOCAL_MEM		BIT(0)
>> +
>> +/* Reads to Remote DRAM Memory */
>> +#define READS_TO_REMOTE_MEM		BIT(1)
>> +
>> +/* Non-Temporal Writes to Local Memory */
>> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
>> +
>> +/* Non-Temporal Writes to Remote Memory */
>> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
>> +
>> +/* Reads to Local Memory the system identifies as "Slow Memory" */
>> +#define READS_TO_LOCAL_S_MEM		BIT(4)
>> +
>> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
>> +#define READS_TO_REMOTE_S_MEM		BIT(5)
>> +
>> +/* Dirty Victims to All Types of Memory */
>> +#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
>> +
> Could you please fixup the comments to only capitalize 
> the first word of each sentence (unless it is an acronym
> or required for some other reason)?
Sure.
>
>> +/* Max event bits supported */
>> +#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>>  
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index da11fdad204d..6f067c1ac7c1 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -254,8 +254,85 @@ static const struct kernfs_ops kf_mondata_ops = {
>>  	.seq_show		= rdtgroup_mondata_show,
>>  };
>>  
>> +struct mon_config_info {
>> +	u32 evtid;
>> +	u32 mon_config;
>> +};
>> +
>> +/*
>> + * This is called via IPI to read the CQM/MBM counters
>> + * in a domain.
> This comment does not seem accurate - it is not reading the
> actual counters but the configuration of the counters?
Yes, That is correct.
>
>> + */
>> +void mon_event_config_read(void *info)
>> +{
>> +	struct mon_config_info *mon_info = info;
>> +	u32 h, msr_index;
>> +
>> +	switch (mon_info->evtid) {
>> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +		msr_index = 0;
>> +		break;
>> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +		msr_index = 1;
>> +		break;
>> +	default:
>> +		/* Not expected to come here */
>> +		return;
>> +	}
>> +
>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, h);
>> +}
>> +
>> +void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>> +{
>> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
>> +}
>> +
>> +int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
>> +{
>> +	struct kernfs_open_file *of = m->private;
>> +	struct mon_config_info mon_info;
> Could you please initialize this struct? I think this is important considering
> that there is an (albeit unlikely) chance that uninitialized data can be returned
> to user space.

Sure.

Thanks

Babu

>> +	struct rdt_hw_resource *hw_res;
>> +	u32 resid, evtid, domid;
>> +	struct rdtgroup *rdtgrp;
>> +	struct rdt_resource *r;
>> +	union mon_data_bits md;
>> +	struct rdt_domain *d;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (!rdtgrp) {
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	md.priv = of->kn->priv;
>> +	resid = md.u.rid;
>> +	domid = md.u.domid;
>> +	evtid = md.u.evtid;
>> +
>> +	hw_res = &rdt_resources_all[resid];
>> +	r = &hw_res->r_resctrl;
>> +
>> +	d = rdt_find_domain(r, domid, NULL);
>> +	if (IS_ERR_OR_NULL(d)) {
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	mon_info.evtid = evtid;
>> +	mondata_config_read(d, &mon_info);
>> +
>> +	seq_printf(m, "0x%x\n", mon_info.mon_config);
>> +
>> +out:
>> +	rdtgroup_kn_unlock(of->kn);
>> +	return ret;
>> +}
>> +
>>  static const struct kernfs_ops kf_mondata_config_ops = {
>>  	.atomic_write_len       = PAGE_SIZE,
>> +	.seq_show               = rdtgroup_mondata_config_show,
>>  };
>   
>>  static bool is_cpu_list(struct kernfs_open_file *of)
>>
>>
> Reinette

-- 
Thanks
Babu Moger

