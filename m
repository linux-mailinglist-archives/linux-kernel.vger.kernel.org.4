Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10560E9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiJZTw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiJZTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:52:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1735AF63D6;
        Wed, 26 Oct 2022 12:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHgddwOQWkFnW+g80E0Qg8t8Mz2Oyqcluq3PrRDNFI5f2iod++QIMjRx7yz35jkTwOayBMs2o7JAoUi3Njf5w2HYAZvaFhyCFwiEfysazHIjNXRB1m23Hd32SZE5nde2SyR4674U2V5uwDx9bCKpEnH8P17qERxBdye9P8lwV3PSKtnxLewIWXhTl08OupSYtNuLumcroZldjyA27A4YRIZRWpvP0+fP27UA9IoBfT9ADVPmYQPWLowmrINe0nUQNMkuKwJ+5S9ogUVYU5FrPc2sT8oUuYafmpEE7+rPtAXAJNS1SlGO2wZKh/9D7+zhGyMhgkXV+A6DW6yb0Gfs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sar5G3Ugsq40EbPqLtZm1Rm+13CTFTp2UyFrAFdZ5d8=;
 b=fIlwRLGGZQJaSULH/S5BUWUGRLS8KjBTve91yGlx7WRuq8XSxx6pvV+AJqvSwlhyCQgJ6qmcJQYhzVky8J2goO5aL2J/9qvrxPh6HroC2PUxzNr5eFtZfh8yxkY2qKLlzlh1XOF0JZ/Mr4QyWTmW132CmyD7BU0iRyGunhRbYm/3LqE67LnV98eU8KyfVdi8aKKfIMkddLwGnnUC5P58r1ZgknP/SWqW6PWJmKON+rYyKdZrmV8hbtQQELF/7RZIvOrgQlFr/CBdfacb67FObjpAlUBjekp6chDWk62M5vmedMdMXMTNgHSY9EYD3RVMWVBi9p1WHFodW3nLRltoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sar5G3Ugsq40EbPqLtZm1Rm+13CTFTp2UyFrAFdZ5d8=;
 b=fTeyp7QQuAOOi0D3HZUsELl2bgXigBT+Qykz79/3QH7q3XZQs3tbtrSqugbKywRGtoLMAyQHK8BmVB5a40pmZW+cV8euWwGE6p5fCtyfugz3wh95tJ+VwzAkajsBYdU86XIYz4OGgTtR0WlITIrwWoCr3Vs3ydtNY1ePRbfgDvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 26 Oct
 2022 19:52:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 19:52:49 +0000
Message-ID: <66e7e5b1-463b-c238-e3d4-f729ac65efd0@amd.com>
Date:   Wed, 26 Oct 2022 14:52:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 09/12] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes event configuration
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
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604563304.5345.2402589906956965706.stgit@bmoger-ubuntu>
 <28a0c3e6-a746-edbd-e7ec-06ec5eb414c9@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <28a0c3e6-a746-edbd-e7ec-06ec5eb414c9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:610:54::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 1763f9e1-0c7c-4e93-cff5-08dab78ba8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRuD+WxrIVlAgzHGqDbeise+PdOGTgZhOmQd5O/j4tNTCKXXn6hFrR/dc1P4uKpQf/x7NOcMqqTEYGzuWmiz9VfGFTDjfWbzsjZCwcI9HGwDCZGBSVAouzNAOwR3Mb6iZU/pLubnI8UkDo0O6l0lbtEpGVK1TKENJVKe9H0WEQw/bCopQ457iJ4jc3EBoQ/AEdTKM+9zrWurahVcOY7DNr+g4P4s6kYfc8St9gqzW7dO0RFcGPbUtEyN15hwmCaKl11JU2Qzu9npJhTwKHIZETmySMHOf2LpPr/XdUF/oluYWLZk4UgP6/ip0FmtXNj4zy2cEQW0XLMGu+Q1A5rvWITEUqhn30q9V8d3a1F/V/QPvgm9N+xMfcYmErEW/2p+kwZh5+7boKYLgcH+jcFG+PwURFHBb900EnY7DcNsap+i6J09SM744njA2EygjHUNudZPsGbtoC3WluG6UtO39frHX1fhoG4OQbNXhG9lCSueG926on+cYh99ubHbFck+dIQ5yQCrCYxbfE9Gzf5mZ8m5Rw6pSbxsnb6gF2eN1b8HwgqEOXUQ82MdP1R57HszJnA50qpp4OEKVOyyG55Fsv9wPb/eXsNaBZNoyWQGxDqfdr34mioiI9OZaw3+EIVtlZbtpVMtTqw7IuwaJlkSK3taJsaAPIYTX1bqMWZeXKYKo+r9QZD3c+5NN/s5UfFNKGjCcY/rABeUDcvsVK6NY+sUHf4x3/Va+PC8J4xuJbMrwM/8OqYa7lMkYms8TgIWZPnyWwmKSYFR+rmc+ifxRjLn2NTmRkbMeUmAjTPOM+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(5660300002)(186003)(31686004)(66476007)(2906002)(38100700002)(3450700001)(6666004)(26005)(41300700001)(6512007)(86362001)(6506007)(316002)(66556008)(8676002)(8936002)(53546011)(6486002)(83380400001)(31696002)(7416002)(4326008)(478600001)(2616005)(36756003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3cwa0x5NzN6eFloYzR6QTRUdnVSWG9hb3FmdVZXWnVGNkY2MklYMGZGV1A2?=
 =?utf-8?B?ZXdwUk8wK1plL1UrTGd2Q1VBWXRab0cyZjVnRk8yNnpSNVdaRzFmWmEwS00x?=
 =?utf-8?B?UXBTTkQyZTZTNmtMTi9lbmNVQnYwK0JEZlJudklwY3B4RnJKeXA2dG42TE10?=
 =?utf-8?B?OWowQkZEcityRk9UYkpwNFpvemxaWEdYT1BpUkptUWdsSlZ2ZHQ0cy9uTStm?=
 =?utf-8?B?VHhXRmw1THpYK1FWdUh5ajVmZzlmekliU0kyWmF6bmxSbG5UL0xseDROSWR3?=
 =?utf-8?B?Umtic1J6Y2pCYXREQkhIdzgvRlhPTHlBR08wV0dNbmJRVDBuNUZVcE5wN1c4?=
 =?utf-8?B?RXVHdjd1ZDdaTTlRWHk5ZXh3cVhOMnZZYWVQdXVWajJDWWtIN1o5UVd5QXdL?=
 =?utf-8?B?SDBCcjFNWGlIQmhmYUVzS0RKeitEUEFCRGNRdGh3blYwcGIwOFE3L3VBN2Vr?=
 =?utf-8?B?cFhESjgwM2tmUWRyMkh1T0QvZUc4VlA0aUxJM2VhSGtCRFBaTDBrY2RFZHBI?=
 =?utf-8?B?RXUrYlpNUlgrZCs3Sm95c2xmclUveUV3TVc2dzlDbDVScVVQTlNRT0djOXZp?=
 =?utf-8?B?clZXaWFOWUtqQjlJdE81S0l0TFpzenpPd0dZM0xma1E3ZjhMOUlSeFVGMmNX?=
 =?utf-8?B?R2lKNEthVDBjZEltY1hCTkYrQ3Nnc2hZWm1wTDMyWDRGQTNGai9qRzNOR2Vp?=
 =?utf-8?B?TGNRTTZZYXRkYnplQ1lKQmN0TmpCR1NINGw2eVhmdUFMS3ZiSnpBZ2Fock5U?=
 =?utf-8?B?RU8vdjBZWjEzQ1FNd3UrT010RlhuY3h2Y2tjMDlFZ0xtOUtKVjMveWR2TXJK?=
 =?utf-8?B?c0ovYlJYbW5JdFZVTE9EZ1NpY3p3UWVMUmxXdzVhUjRBMjB0RjdGWGV1VUpN?=
 =?utf-8?B?cFQySUUyOTdBK2lXWFlIRHZQekZkd3V4TFVlSjhqMmRYTjVqOGF4YW1YazF0?=
 =?utf-8?B?ZjgwYzY1WTdXbnBBSm9OL1k1b3o5SVk3TDF3dlJ0Tm1FaGFMZ3UwUmRvMXh2?=
 =?utf-8?B?WnpZRnArOGRpRGNrY3FlN29xUU5CVEw5cjhFTG1PVExNMHpUODFUdXgrR3Nt?=
 =?utf-8?B?R1JrQjU5MnRCWEt3YnlHbVI1ZUp5QWFLRW1ETm5UQUlsdnd2TkNCWDBvcWxv?=
 =?utf-8?B?MnJwaTVWdnFmcnhsQ1hxdlJBZXlNd002YmVPbDM3ZUZBalExbnRaSVNNMWFH?=
 =?utf-8?B?bUFIZXVYVzFRdWZsTFVMTGVQWTNFazV1VURNYklwMXdPNkdVMXBvVUVGcmVl?=
 =?utf-8?B?MEpkU1QwNFF3VmtpY2hXMldOMnp4Vkw3dXh0cXFCU0pQS0FRcjdSSkF1U1hh?=
 =?utf-8?B?NmltdklvKyt6Ym1vSVJZOG1jbERQSzdyOWJoVFpIOVVTSFl2amhDWkpyeVVu?=
 =?utf-8?B?bVl0d1RTUitxakhhTWhndm1mc3cySVJpNXhnc3VSSnhFQXB1NXZaYUllYmlw?=
 =?utf-8?B?TmltN2Z3M0JUMkZNUGRFY2o3V2gxb0tPc0JwOVNGUlp1VEg1NXZyOVhvMm9k?=
 =?utf-8?B?TGJYVXlXMUNtTUhsNGo3NWhaTldYTERCV3lTc2hwQ1dCN1RoTk5KNG9uUHpG?=
 =?utf-8?B?eDhZdS9tWlRxdVhpaWdmMmVkWkNUUGdmQ3JVeURyMmprUnB6bi8yNkRqa0Ft?=
 =?utf-8?B?eExuZklxUEtlaTBlS1UrbXdUZzMrejRxVE1aTXhNS1lSWU4vQWpoK0hjT1Nr?=
 =?utf-8?B?YitIcXNaaytCZ2hlc2R3VTEzZ0lNR3FuUzBWT1Vtak9PcGo3TDl6VDNpY3o1?=
 =?utf-8?B?RHR3ZVJZSktPNi9QV0xxWVJha3V5UmthVUFObDBVL1M3N0NveUFOOXc1VHlC?=
 =?utf-8?B?RDEwcGRuSXZPc1VvR1FJcWxHTnNsNkJiS04rcmc5K2IyM2FXV2labTZQQm1Q?=
 =?utf-8?B?Y0ExL3l1N25ZWDVqWkFiK1BGSTl0aElwdDNJSEhseUtGU2lkNlV2dkwwK082?=
 =?utf-8?B?ZHl0aEhHSWVTYlNHc1BqUDNORzcrcjh2cVRyTDlETW93UTRiSjdCeDJkbmdl?=
 =?utf-8?B?L1g1UDNtRE1xOHJ2YTllTFdaVkVtekZSMmgySEgvUGRHK2kvaVlwZ0NTUys4?=
 =?utf-8?B?ZDZ0WGdqL0N4bUNnYXYramNFYTcwOXVRNUJlcHJzT3BPdXlSa3h2a0lraTdM?=
 =?utf-8?Q?dOHloegjyq1bSOkc2LCw9+4J2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1763f9e1-0c7c-4e93-cff5-08dab78ba8e5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:52:49.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMcicVjiHuC+tjFhEzNASNdPHxohipFX7grJipL6IQ8hhTh63KV2PvHYQdgpM+QF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,


On 10/25/22 18:48, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/17/2022 3:27 PM, Babu Moger wrote:
>> The current event configuration can be changed by the user by writing
>> to the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_config.
>> The event configuration settings are domain specific and will affect all
>> the CPUs in the domain.
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
>> For example:
>> To change the mbm_total_bytes to count only reads on domain 0, the bits
>> 0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33). Run the
>> command.
>> 	$echo  0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>
>> To change the mbm_total_bytes to count all the slow memory reads on
>> domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).
>> Run the command.
>> 	$echo  1=0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |   23 +++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  146 ++++++++++++++++++++++++++++++++
>>  2 files changed, 169 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 326a1b582f38..c42b12934a0e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -42,6 +42,29 @@
>>   */
>>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>>  
>> +/* Reads to Local DRAM Memory */
>> +#define READS_TO_LOCAL_MEM             BIT(0)
>> +
>> +/* Reads to Remote DRAM Memory */
>> +#define READS_TO_REMOTE_MEM            BIT(1)
>> +
>> +/* Non-Temporal Writes to Local Memory */
>> +#define NON_TEMP_WRITE_TO_LOCAL_MEM    BIT(2)
>> +
>> +/* Non-Temporal Writes to Remote Memory */
>> +#define NON_TEMP_WRITE_TO_REMOTE_MEM   BIT(3)
>> +
>> +/* Reads to Local Memory the system identifies as "Slow Memory" */
>> +#define READS_TO_LOCAL_S_MEM           BIT(4)
>> +
>> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
>> +#define READS_TO_REMOTE_S_MEM          BIT(5)
>> +
>> +/* Dirty Victims to All Types of Memory */
>> +#define  DIRTY_VICTIMS_TO_ALL_MEM      BIT(6)
>> +
>> +/* Max event bits supported */
>> +#define MAX_EVT_CONFIG_BITS            GENMASK(6, 0)
>>  
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 305fb0475970..25ff56ecb817 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1494,6 +1494,151 @@ static int mbm_local_config_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static void mon_event_config_write(void *info)
>> +{
>> +	struct mon_config_info *mon_info = info;
>> +	u32 msr_index;
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
>> +	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, 0);
>> +}
> This duplicates most of mon_event_config_read() from earlier patch. Would a
> utility like "mon_event_config_index_get()" help here?
Yes. We can do that.
>
>> +
>> +static int mbm_config_write(struct rdt_resource *r, struct rdt_domain *d,
>> +			    u32 evtid, u32 val)
>> +{
>> +	struct mon_config_info mon_info = {0};
>> +	cpumask_var_t cpu_mask;
>> +	int ret = 0, cpu;
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	/* mon_config cannot be more than the supported set of events */
>> +	if (val > MAX_EVT_CONFIG_BITS) {
>> +		rdt_last_cmd_puts("Invalid event configuration\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	cpus_read_lock();
>> +
>> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
>> +		rdt_last_cmd_puts("cpu_mask allocation failed\n");
>> +		ret = -ENOMEM;
>> +		goto e_unlock;
>> +	}
>> +
>> +	/*
>> +	 * Read the current config value first. If both are same then
>> +	 * we dont need to write it again.
> "we dont need" -> "we don't need"
Sure.
>
>> +	 */
>> +	mon_info.evtid = evtid;
>> +	mondata_config_read(d, &mon_info);
>> +	if (mon_info.mon_config == val)
>> +		goto e_cpumask;
>> +
>> +	mon_info.mon_config = val;
>> +
>> +	/* Pick all the CPUs in the domain instance */
>> +	for_each_cpu(cpu, &d->cpu_mask)
>> +		cpumask_set_cpu(cpu, cpu_mask);
>> +
> Why is it necessary to create a new CPU mask just to populate it
> with all CPUs in another CPU mask? Why not just use the original CPU mask?

I thought convention was to create a new mask when calling on_each_cpu_mask().

But, I dont see that requirement. I can use d->cpu_mask for this directly.

>
>> +	/*
>> +	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in
>> +	 * cpu_mask. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
>> +	 * are scoped at the domain level. Writing any of these MSRs
>> +	 * on one CPU is supposed to be observed by all CPUs in the
>> +	 * domain. However, the hardware team recommends to update
>> +	 * these MSRs on all the CPUs in the domain.
>> +	 */
>> +	on_each_cpu_mask(cpu_mask, mon_event_config_write, &mon_info, 1);
>> +
>> +	/*
>> +	 * When an Event Configuration is changed, the bandwidth counters
>> +	 * for all RMIDs and Events will be cleared by the hardware. The
>> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>> +	 * every RMID on the next read to any event for every RMID.
>> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>> +	 * cleared while it is tracked by the hardware. Clear the
>> +	 * mbm_local and mbm_total counts for all the RMIDs.
>> +	 */
>> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
>> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
>> +
>> +e_cpumask:
>> +	free_cpumask_var(cpu_mask);
>> +
>> +e_unlock:
>> +	cpus_read_unlock();
>> +
>> +	return ret;
>> +}
>> +
>> +static int mon_config_parse(struct rdt_resource *r, char *tok, u32 evtid)
>> +{
>> +	char *dom_str = NULL, *id_str;
>> +	struct rdt_domain *d;
>> +	unsigned long dom_id, val;
> Please use reverse fir tree order.
Sure.
>
>> +	int ret = 0;
>> +
>> +next:
>> +	if (!tok || tok[0] == '\0')
>> +		return 0;
>> +
>> +	/* Start processing the strings for each domain */
>> +	dom_str = strim(strsep(&tok, ";"));
>> +	id_str = strsep(&dom_str, "=");
>> +
>> +	if (!dom_str || kstrtoul(id_str, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
>> +		rdt_last_cmd_puts("Missing '=' or non-numeric event configuration value\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	list_for_each_entry(d, &r->domains, list) {
>> +		if (d->id == dom_id) {
>> +			ret = mbm_config_write(r, d, evtid, val);
>> +			if (ret)
>> +				return -EINVAL;
>> +			goto next;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t mbm_total_config_write(struct kernfs_open_file *of,
>> +				      char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	int ret;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	rdt_last_cmd_clear();
>> +
> How is this code protected from interference by other actions? Needs rdtgroup_mutex?

Yes. Sure.

Thanks

Babu

>
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	ret = mon_config_parse(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
>> @@ -1597,6 +1742,7 @@ static struct rftype res_common_files[] = {
>>  		.mode		= 0644,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= mbm_total_config_show,
>> +		.write		= mbm_total_config_write,
>>  	},
>>  	{
>>  		.name		= "mbm_local_config",
>>
>>
> Reinette

-- 
Thanks
Babu Moger

