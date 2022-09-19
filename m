Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96B55BD166
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiISPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiISPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:46:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6682CE05;
        Mon, 19 Sep 2022 08:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3tgyZSAnPQk/St5G31aMNJ26d8OF1y1gZjoCmBYmtijlx8AAp1slsnaWF/SEdab5Qhye0JzOi+s71dA4xxmLdQpfePMxzpnKCDZF/Mar46b8qSCem3shoJdsz7EPPGIDKarqvGI7w1T0Pa4fiBvCauFcuTGI4nAz0VIUMHY6fG8/E6rlquinfWbqtFUN4/bn2GK0UVko2tUApxnYi+Gf4kW8mEnJWppVQ8C8FXnVP02imWIP54UbP7aTeGR/ghBbTy6Yjonz9VSCt+f3AbP791GAadfX1UKYSbvYUwJ/eM6G5hvkrF8ZTiMb9njR8HMYSxMvmsHPpmeGHig98mFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixFXGlLARMG+wFx4NyS1cKz/vAXnc2BHUDYEcZ3WPX0=;
 b=cZb8PoozNwnaQCaiWUCL3xsPYk41NMb5aEh218JdBSRFSl77bgjwl265jlI9fohQbKRdWMCIK+FGiW1kb28vk3hwudndDoM3dQ64nuZMfkRjcIjoMD5/fh8kCGh95aITCO8aerRFeu1hGPF9TtQ/rDGzBOu8Okg87NpsQwqu/Q2eqtAqR/1i3DggdNsKBKPAs4ELhd4yKf1l+QTVzvld10eHEOUCDNyeJdqWV77RR/nefi5BTLDuZ9i7pczIbdjuk89ku9k5XqahhNXg0HwqfuNjEjSq2Kx1+SAIsDMmPReimtNca5UWKj/MbNM9tGHTclK8OW/H7BZMjywjcZKXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixFXGlLARMG+wFx4NyS1cKz/vAXnc2BHUDYEcZ3WPX0=;
 b=FuY9S9tXWODflqyj2qfDzNaQDBsVlmnH57wBmVSbNJEBP5HRKJkoDzA80xzFxGHdzCl+ENsPKXStDMbYrr/Xl8K2rntoDoC6I9bC6PzPcUdyiyCkZCkNizoCUuAhMDdT2O/B9d2vbFnIHhrq7T1NyAG+DxEztswl50h6rRQVk44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 15:46:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:46:52 +0000
Message-ID: <04132d34-c69e-62a0-35ba-bafa44210c0a@amd.com>
Date:   Mon, 19 Sep 2022 10:46:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to
 read/write event configuration
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
 <166257366204.1043018.4834615270384002210.stgit@bmoger-ubuntu>
 <13294a8f-e76f-a6a9-284c-67adbc80ec7c@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <13294a8f-e76f-a6a9-284c-67adbc80ec7c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 6535dfd5-273f-4c77-18cf-08da9a562c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWza8J+ed28Dds7aOqulZOSEjo853Ay5ySzEbq2T9289RcvvwjstabGnRz21DiE0GUKtvFkV38ymZu5wyYzmnU75l9sZ6GwI6/Piz8gmJ9pK9xJHy1l4UI+XGL3VB4KGQSSXdfRsvyl9i6tMQdrm9aYbphVi/0Sd0nC/A0lL7zYOk9BJbwIRlm+9vZcmn2mYItm/n1NS7rKGY2wdHl67K2AeVOWvK2RgCn6x6vvYX8YtOFpi+c38ZED9nixRgApXe5/vNjgcjkTdW/1l9HHdq0Kkf2EHHalS/MbLhXtdAzFzhbagS4F2ZngrJgQQfucoqD8ZzviBb9H1pNSOR9SV8R6Ob5dSCSOW9imJ7Uzx4o5r2Lj5HowdYgcB3JsntY6huLkjksYjAq3km1NLhh0yxXmC7GJbZYsatRlh62T+07a9qrRBfISMlHCuYquR4TFPI+PXxRVnQ4E7hjmbrTvdtIbNSIRUop5R+dVXnRYIZTsmD+IIh/mpzgZn59qnwYy06h2N2h3WHGGKdFpGghQsnStQ/uO3JUaXbvt5YMt+WuruyTo5ag14gaWlE3gwFYJqkOHIbYqh5L+YSB7P/MQVEDssbhjLfWK3IiRa0TZ9D6OKdlkTXJ5Bh5EgNp9FmCdPR6ntCYpZEEKYhxjzSCF+J0uLvFtV5FFyLjcGxvzCeoODUcb2XBb66ZXK+OxUUE1IZdn+NFo2LYugN5myjjPgQ3npwhqy2F5D1KXeZsrBnokW7D1pvFBcoQ6hJazr9tqBYfmbgm1JgdS3z1Di4NOtUjvuVjvcSlXmMrkXyd4lU5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(2616005)(53546011)(83380400001)(6506007)(186003)(6512007)(26005)(66556008)(66476007)(66946007)(8676002)(7416002)(5660300002)(4326008)(478600001)(36756003)(8936002)(31696002)(86362001)(6486002)(6666004)(41300700001)(316002)(38100700002)(31686004)(3450700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NSZHhJanl3ZEgzL0ZmZ0lGc3IyOHJhaHk2bGJzSUFjbUFlWEhHaEUxT0Jx?=
 =?utf-8?B?MlNiUEY2b0o4bnFNbmpZSWxmOXhSQWVKRXZxTTlCQkJkMW90YWhYTHUzbWRp?=
 =?utf-8?B?TmVRZ1BVajZOZzBsOHFHdFBRK3NTQm04cUx5d0t1VG5UNWxLZ085a2c5ck15?=
 =?utf-8?B?ZWFJcHh2eGRwL3pIdWM1T1hpdWRkK2hDcU1GMjZSOGJCZ0tMblorSXMzSTVQ?=
 =?utf-8?B?SE12N3NSUHl6WTRWQXNVWE1lNFBUYmhJNlRWUTFzUkhsbTh6Unk0TmdOdjA0?=
 =?utf-8?B?REpmNmVLOVRzTS9xVmdBc0tRaVdqM3NYbFc2OFI4ZFEvRitjdWVLVmVGbFcr?=
 =?utf-8?B?MG1XZGpKM1BQbmtZdnZUMTJrZS9vSWxJTzVvcGFobGVwTm8vbmVKSVB0Szhp?=
 =?utf-8?B?blZ6cTVPTHFua0liWGQrMDEvcnF1dU1pTE90NFRHZUJmZUpHWENxdXYvWEtv?=
 =?utf-8?B?UWdpMDV4TmNwWml6QU5oMWdDVTRZZDN4ajJLOGNTUUg3cSswMmhUTEtnY3lV?=
 =?utf-8?B?UlpZZFlFL0hRc2xYUXlzV3VGYkN1QTE5dGdDdm05VkUra0hBZVBxT1JmeFZ1?=
 =?utf-8?B?MUdjRk94NysxcVU0MHVRbk4zUWI3TU5sbXVNaVVYOEVKeXFyWlI3KzFkYkhi?=
 =?utf-8?B?NzY4M2s3ZVRpSUtTOTRMSGJQaXNnVFNLZDVMVVRhU2phMThBSGNmWTJiZmNq?=
 =?utf-8?B?eHdvdG1oVy8xaGg2OGkzSGhDbFVFMUZCTFhvTEUxNDVnUEdWcFpRaXBNaWF6?=
 =?utf-8?B?ek1tNkdON0hCUzlwMy9PTmY1Zm50ZEFYK1BWenZnQTRjQ0dSZFQxN1NxaTRI?=
 =?utf-8?B?YWh3UURUK1FXbDFtYWRwNS9SUWpDZXFFMC81KzlMdmJlMFM2aGZpQ0Q0ekJX?=
 =?utf-8?B?Y1ZHTzdxM1VUZzNtWS9WNk15QVNoV0QxUGN5VnJLWVgrVzdVTXhzYk00aUp6?=
 =?utf-8?B?UlV1aEkwbzhNWC9PVmI4Zk5Va0VDZXkvYmRXOHQvRDczOHNXYTdRVDY1eXdC?=
 =?utf-8?B?QnEvWXp3NVorT2ZBYmwvWldKUFFRdThxM0w2M2lRSU11cXV1WC9qMUdGWVB0?=
 =?utf-8?B?N0RGYTdlSXY3TkxqVFo5ZmN6bmVLb2oxUUtjbGIzTGtJVG05cEdKUzUyWGdr?=
 =?utf-8?B?dXNlOTFEclBzbzNqd2E1b3dsbENhN1RMS3pDakJjODFURnhuWUhXRWwyOTk0?=
 =?utf-8?B?elQ5V0RoWnIxU0VBYTd1ek0rbWxrY0MwY2tUVkdac0lUWDBGNm8xaW9taDA1?=
 =?utf-8?B?OG9LWjBjTnhVRW96NzJ1NExHSVYwYkFMTTdPSVB5QVFSYk51aGd2eEpWaEV1?=
 =?utf-8?B?aUQyVWxnRU1ialFJUzVldUhuL1BnaExMVnhGSU9YWEhZeVZjdDNQWExOZCsz?=
 =?utf-8?B?c2kvMks3Sld4OUg1L2pFbnJpVTZ0ZnhDdFZZQTJOdEs2TnZia0k2TE5JQTlZ?=
 =?utf-8?B?blBNSmJza3Jja1hRaVB3WTlvc2YzS1JJc3VyZFVqL3oyNGh6WGprd0k4N21B?=
 =?utf-8?B?MEpuNTF4VFE5V3lmZ1NiM3R5bmlTLzdHTHNoaEdlRGNncTRRWmc5TXMrZVRV?=
 =?utf-8?B?VG5jaG5MYTNCL1BIQkJLZkFsMTVsTzlrbitZczdXcEZEc09XWDJXWnJwUm15?=
 =?utf-8?B?UFZubExjd3pZNzZxVERjR3pmT0kyeXhCWjUwRWJLWnlBTHdvSGpQTCtndk85?=
 =?utf-8?B?YjFvR2pybnFqMXl6cm43dDRwelZxZXpQRmg3TFRDYVRWaWZqRW0xazFVK2x3?=
 =?utf-8?B?amNmYmlxYnpqbjZNVnhCUnE2MzNhWFZrY1pua3FUU2N0ZmNYdmtTRjlZS1Rh?=
 =?utf-8?B?dWxZUDIvM3ZtaWtPdWxBUDdRQzZyYVIwd3JBRXJ1S2lmTGUrdlNWREFnOEFs?=
 =?utf-8?B?SkhUc01DVjhDMTJFKy8zQ1F4MjhuQXNwc2J1eG1wUDRyZUZMbktNMGpTeHlp?=
 =?utf-8?B?b2FDN0hUY3hBYXdWLzlJMGtmZ1picmxsZno5dVRIVDRoTzJvK3ZOcjM5b3Jv?=
 =?utf-8?B?MlNHZ0NHcGVOMUoyZXVkYS9pdVVsUUU5anlzTGhPZVozZVRCT1k1NER3N1U1?=
 =?utf-8?B?UTdIYkdmTTIrK3NVNmYvZUxRVGFMQlBEU1N0bzVHaURGQnhtOHlXS01TUCtG?=
 =?utf-8?Q?tllUDxrUvxdKKZOcLqPYkDnYC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6535dfd5-273f-4c77-18cf-08da9a562c27
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:46:52.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UT6UkjyV0EZlMXiRf98cd2S25OV3R/moqdCXyBcVWr1UO7QfcfpH5jfBDLeqwQvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
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

On 9/16/22 10:58, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/7/2022 11:01 AM, Babu Moger wrote:
>> Add two new sysfs files to read/write the event configuration if
>> the feature Bandwidth Monitoring Event Configuration (BMEC) is
>> supported. The file mbm_local_config is for the configuration
>> of the event mbm_local_bytes and the file mbm_total_config is
>> for the configuration of mbm_total_bytes.
>>
>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*
>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
>>
>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*
>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
>>
> This patch makes the mbm*config files per monitor group. Looking
> ahead at later patches how the configuration is set it is not clear
> to me that this is the right place for these configuration files.
>
> Looking ahead to patch 10 there is neither rmid nor closid within
> the (MSR_IA32_EVT_CFG_BASE + index) register - it only takes
> the bits indicating what access types needs to be counted. Also
> in patch 10 I understand that the scope of this register is per L3 cache
> domain.
Yes. Scope of  MSR_IA32_EVT_CFG_BASE per L3 domain.
>
> Considering this, why is the sysfs file associated with each
> monitor group?
Please see the response below.
>
> For example, consider the following scenario:
> # cd /sys/fs/resctrl
> # mkdir g2
> # mkdir mon_groups/m1
> # mkdir mon_groups/m2
> # find . | grep mbm_local_config
> ./mon_data/mon_L3_00/mbm_local_config
> ./mon_data/mon_L3_01/mbm_local_config
> ./g2/mon_data/mon_L3_00/mbm_local_config
> ./g2/mon_data/mon_L3_01/mbm_local_config
> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
> ./mon_groups/m2/mon_data/mon_L3_01/mbm_local_config
> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
> ./mon_groups/m1/mon_data/mon_L3_01/mbm_local_config
>
>
> From what I understand, the following sysfs files are
> associated with cache domain #0 and thus writing to any of these
> files would change the same configuration:
> ./mon_data/mon_L3_00/mbm_local_config
> ./g2/mon_data/mon_L3_00/mbm_local_config
> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
>
> Could you please correct me where I am wrong?

For example, we have CPUs 0-7 in domain 0. We have two counters which are
configurable.

Lets consider same example as your mentioned about.

g2 is a control group.

m1 and m2 are monitor group.

We can have control group g2 with CPUs 0-7 to limit the L3 bandwidth (or
memory bandwidth with required schemata setting).

We can have mon group m1 with cpus 0-3 to monitor mbm_local_bytes.

We can have mon group m2 with cpus  4-7 to monitor mbm_total_bytes.

Each group is independently, monitoring two separate thing. Without having
sysfs file (mbm_local_config and mbm_total_config) in each monitor group,
we wont be able to configure the above configuration.


>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   40 ++++++++++++++++++++++++--------
>>  1 file changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index f55a693fa958..da11fdad204d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -254,6 +254,10 @@ static const struct kernfs_ops kf_mondata_ops = {
>>  	.seq_show		= rdtgroup_mondata_show,
>>  };
>>  
>> +static const struct kernfs_ops kf_mondata_config_ops = {
>> +	.atomic_write_len       = PAGE_SIZE,
>> +};
>> +
> Please use coding style (tabs vs spaces) that is consistent with area
> you are contributing to.
Sure
>
>>  static bool is_cpu_list(struct kernfs_open_file *of)
>>  {
>>  	struct rftype *rft = of->kn->priv;
>> @@ -2478,24 +2482,40 @@ static struct file_system_type rdt_fs_type = {
>>  	.kill_sb		= rdt_kill_sb,
>>  };
>>  
>> -static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>> +static int mon_addfile(struct kernfs_node *parent_kn, struct mon_evt *mevt,
>>  		       void *priv)
>>  {
>> -	struct kernfs_node *kn;
>> +	struct kernfs_node *kn_evt, *kn_evt_config;
>>  	int ret = 0;
>>  
>> -	kn = __kernfs_create_file(parent_kn, name, 0444,
>> -				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
>> -				  &kf_mondata_ops, priv, NULL, NULL);
>> -	if (IS_ERR(kn))
>> -		return PTR_ERR(kn);
>> +	kn_evt = __kernfs_create_file(parent_kn, mevt->name, 0444,
>> +			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
>> +			&kf_mondata_ops, priv, NULL, NULL);
> Please run your series through checkpatch (alignment issue above)
Sure
>
>> +	if (IS_ERR(kn_evt))
>> +		return PTR_ERR(kn_evt);
>>  
>> -	ret = rdtgroup_kn_set_ugid(kn);
>> +	ret = rdtgroup_kn_set_ugid(kn_evt);
>>  	if (ret) {
>> -		kernfs_remove(kn);
>> +		kernfs_remove(kn_evt);
>>  		return ret;
>>  	}
>>  
>> +	if (mevt->configurable) {
>> +		kn_evt_config = __kernfs_create_file(parent_kn,
>> +				mevt->config_name, 0644,
>> +				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
>> +				&kf_mondata_config_ops, priv, NULL, NULL);
>> +		if (IS_ERR(kn_evt_config))
>> +			return PTR_ERR(kn_evt_config);
>> +
> Since an error is returned here it seems that some cleanup (kn_evt) is missing?

Yes. That is correct.  Will fix it.

Thanks

Babu

>
>
>> +		ret = rdtgroup_kn_set_ugid(kn_evt_config);
>> +		if (ret) {
>> +			kernfs_remove(kn_evt_config);
>> +			kernfs_remove(kn_evt);
>> +			return ret;
>> +		}
>> +	}
>> +
>>  	return ret;
>>  }
>>  
> Reinette

-- 
Thanks
Babu Moger

