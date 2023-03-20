Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168886C1D17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjCTRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjCTRAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:00:49 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196EB2A6FE;
        Mon, 20 Mar 2023 09:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqv2QhQbAWYnlFFndNoFregVPOVdc4L+b2buKpcXFWB/OiR/bjXms54c1xg7nsbO6QxD8hfUyk9GPN6so3MSl8aJsdeqF3H5mkmSI5tZxLQRwEU3/peiIJRcUL3/SHGGiZphw1tLYY8Rd2U7WxC7ueDdhf82uXn+h0dDMKetQeRTsqiwkJzVkeenKh3pTU0+YUZ7pEBhCQgfBLSvsmpOI6GweQ6lsKR9gYKtDCQpsH7L6slLiQJ1h1hiy5JZEV9svMoF/Y84RMqPmQshkZK847M5gRPiJfwySmmS+rv8IsJmPegywh1vhGgsnXbvVSWnAs0fvfzdIbLGQfInCnudCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+eOFTCEVDTploFGshm87ta0/knicpbKs/C+ISLKy0c=;
 b=JcSe7eipd04FDFP/3bspeY1rp4PfEX7KXdbQltc93boP6WWSkFHug/bw+QynY3gtc7cG3L+5wQVTYFNU0s0pH4xCdoSg0HJypOV+jJPJoVJVZfue/HJa/EsEDpNba+kGZpMORkSbAodyoVHHdW5+JAYw297Sv08311AfKlvz+kppFzolKoaOIu9Je5T7CwzCLOMmGxQ+TUzyQABbC32NAgsQiSDIV/eYjpaczgfBRnytCfWwHcDyiZTEZUrW2fzR6EPkqOI0zFKFd+YU1ZcmlEwJO5WWABIJuRCZCSHgBSk1oQVQ1ePRG8u8W+0mW3t1P1W8GcERMuRmdfGfR6YBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+eOFTCEVDTploFGshm87ta0/knicpbKs/C+ISLKy0c=;
 b=32qM2GG7FN7W7zsfhO/d85HC3RNoXgyaNbUvxc+Rkj/u6mE3+7MckuDUM+/7Z8HTKe0uCw7jfxejsmWZdU+Wvtx/tMZQ2zYN9Cu9JRjy7XqIteKWE97VmlgTl8NwR9d6wIZHihNXzecPkpWxnxOcocpde8FyB2Pu1w+JBw+foGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:53:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:52:57 +0000
Message-ID: <567d0e3d-4eab-5da3-7566-bcee5623c0e8@amd.com>
Date:   Mon, 20 Mar 2023 11:52:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 5/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
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
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
 <f31e9db6-2ae7-83de-1b4b-4dd802a9da02@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f31e9db6-2ae7-83de-1b4b-4dd802a9da02@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:208:23d::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: dd334b49-7f80-4ff9-fe41-08db29638e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kghLn4MgVsCB6Fytu8Ee3kLBgwhsj3rio8+n8rkoCIQaOMJcxB8tsFNqWnZGSOj8otM7A0poz7YuGuPoG2fHjLNQIBsO8PGJi/a0RoPZcv9ZltlVZdLEziuuWvN0k9hYGDplAznL2AcrqccRuRrir1op15SGxn3/tm9ynwjTgz2xqSlO+Yg+7R7tKFzvQmBp2lgtTUMdtntRZg+QXbvw4CXsnpheU9An029zkTq4xiBmRDwGD/j/kwVG7dox2u5ke551uTt59gmQhSiy5tVEU5A3Uc5sYVIBehoBzcJ0TemE6xL+uNWDv/l3fthiTsEebWVccEGRsNqy4eLc5BI+C1XqmmjCMcwZOSFEIr06n4iW4jlA/J5dTiM53pZzVaUl4udUHVf0+8ctvmYzm8TpSYYR8ItqNnZZFw+to7eY9ezjjf2BjNxpZMxJNIq57uDzo8QLhvDWdqQb8ZAQbxa+gpTiCkpecCLPtGDmKOaHJryn2NwQhgppAzmVGKYacXva0Ly6tNN0ton+rXGKyJGEegWfNnkOx8QmqwT31CqEHgvkmEPfTcIYbztpPH25TEqOxnOam4c6Ux8Xu9XqjKPwfZb9l47MIXODozLTwt8ng46LSY5l3cU33w+5GUjVN94ab9Xn4DMNFNpvyEfmBXM6YVqBphUjIlPjOasyMSmCjudxozJnosRx3hDysu9ZYM+atV0r5m/llCJxfvE2W8XWlfKKrNFFC5AZkyXRrWVZEgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(8936002)(7406005)(5660300002)(7416002)(86362001)(31696002)(38100700002)(2906002)(36756003)(3450700001)(4326008)(966005)(6486002)(83380400001)(478600001)(6666004)(41300700001)(2616005)(186003)(6512007)(53546011)(26005)(6506007)(31686004)(316002)(8676002)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3hVeTQ5dTVxaEFXZWdVbis0OVZRMWVLQ2FiVUZ0NTg1a0VaaFFMNk9RK1FM?=
 =?utf-8?B?LzFYVlA5NTM0WDJqb0FZSDI0SEFWbHM2a01TdmJtQTIxOGNuOXA4Z2lNT2tU?=
 =?utf-8?B?ZnJKUk12Q3REMFhCL2JqM1AzdWJsMW4xRWRQSmNmd0hlZ3VzcVhqUHB1OGNF?=
 =?utf-8?B?Nk5qRzZJeS9ybHFMWXUyUTRYTTlhUlFtaGlaMXg2MFZIMnZhdFUyKzVFYWwr?=
 =?utf-8?B?aExDcUZTc29hKzVrRXZjM2dETkM3aXBZdzBvZGhvM3R0VmFySlNHeDZTWGR6?=
 =?utf-8?B?SEZDUlZwWUFCZkVUSzI5ZXA1TDdsSWpweGI2QW8zL05kWU5XQmRwS2lSYmVY?=
 =?utf-8?B?R0lLbTJoNHE5Q2krRWNuNHB0djlLYUlvQlkxYXRNWFV0Tm1EdnNzYUptUlRm?=
 =?utf-8?B?STJjc2xDM2xPUjJtamFKL1hLdzlqMHQrY0FrV1ZvNG9oNlpFT1BNcXZaeXQ1?=
 =?utf-8?B?NGZEYlkxN2FHdTkzaEluNytHTG5oM2VaWkRQc1JFVjVYL0lKOVRKcGx0TGZC?=
 =?utf-8?B?Z1F3QmdKdm4zdjhZcldPRFVNT2xTTXVSR0Z2RVVNS0tHK2M0ZE5kcm85OFRY?=
 =?utf-8?B?QUk2eGg5THpnc0d2MkY0TFRpNHkrd3ptZUVRN1B6YnBTTm5ZekZNY2lYM1hB?=
 =?utf-8?B?UWJ2WlNmeXpKa0NGQzFHZjMzZDVlWUJ1MXBQWDFFMDNITDIyaEdMelIyWVFE?=
 =?utf-8?B?c3poLzdNYkE4dHN1ODVvMWQ0NXVtYTB6bkhreG9DRC8rOUlRakkwTHhXcjJJ?=
 =?utf-8?B?WE9PclNEVU9nU3YyZzU5K2xnVFJZZnpCVCtlWmIrU1kyQXNYWTladEpGdVpV?=
 =?utf-8?B?S2trakMwT3dBUzA4aE0zbU9YZ2IwVS9CbGxTRDI4bmc5NTMwSHEzQW9NbTlp?=
 =?utf-8?B?VFUxZEVNK3RPVzRIcUtZR0lOd2pkYUwxNzRmMlo2SnZyYUx4TjZTM1l1Q1Uz?=
 =?utf-8?B?RTZtUmRKQXJwcG1XVmU4R1FWdGU3TS9hazBxQVQzT0JiNXh6OTBCdkN6MTFN?=
 =?utf-8?B?RVJpSFR3WHBPUEpKbFgyNFNMeW80T012anBOcTZqYzh2b2EvUUgyZW55Rnlv?=
 =?utf-8?B?VEs5MVgyYTBMV1JUSTQ2OVZpTXFtWHVjSUN1UU1MRldyeGRuajJSR0k2Rjd3?=
 =?utf-8?B?UTZ1NHJ0bFRuMlgvYWx5UEovTlhPNVVuZ1hkbnZ5MURaSzNBUVhhQndTbk0w?=
 =?utf-8?B?SFhQL1ViUHhMc0Y4RW5SZndOZXYxMWVzMjFOb0xjRDh0c3dLeDh5Z3R1aXh6?=
 =?utf-8?B?Qy82YWJ1RWJUZXRJMXdPb3JHdEh2YmdKbmV4VVBBczk4VVRLTEJVeTd0bnZZ?=
 =?utf-8?B?dnpUQ3lDS1lOSkhVaTVjTkhpM1Y3YXhJaWFXbnBUei9ERlhaNXd2bEMvSGFQ?=
 =?utf-8?B?WVdPeFQ0U0xLNDR6ZGoxYUVSZTE3QTFPYlpqTUgwcFBsY3BkaW0zejFuZWpB?=
 =?utf-8?B?Ymg2WmZZVWdhMThZUmtUTHJkYk1FSWlYdHVpRlh5Vk5DdjMwbGxaVjFBZ3V1?=
 =?utf-8?B?MFNwSjBwOGs3TU1RTVU0dlNOMm1kQmJ3L2ZhRC9RVm84U2N1U2dCWmpFN3lT?=
 =?utf-8?B?UXlWUEk1Q3d5eTJxZEh0R2FUQ093MkpGREVETE4ydExtVTQvaDlCZDFUVm5j?=
 =?utf-8?B?aGpieWN1SGpZSFlLQXhLa1pJdUlJQTdSeDhMMW95dytSMzNsQ1dwM25aaXAr?=
 =?utf-8?B?enczSk4zVGdaQ2M1eGZmL0JSNzNQNnlxSVQrYnI4RTNiYkgxdTlaWFZHTWVE?=
 =?utf-8?B?b09vNUVncVVEWkZ4SUxBVDNkeGdPSThHYTNCMWMrTVBVUW5kK0JEcXVDcXNl?=
 =?utf-8?B?SzQwV0o4b1JnaTFlazRNQVJKU3RnaUJZZ2RQZnI3UGk3REpqZVNDRGdOMEQz?=
 =?utf-8?B?WTlxR0NTbG9jZXdmTHFOaFZ6R0JmTnZVUi93MXAwQWZSYmFvdU9pS0lkZE83?=
 =?utf-8?B?UElkTndjcFViOXpBV2VWTER6dVdlK1lRQjQ3alZ3ZHdaRjMrTjUrTlRVYUx0?=
 =?utf-8?B?TUZ3cnN6SDR0Ukc3MzJqUWV6eEViNFFXK1NsK0xnZWVMN3hKYXdRL3YrZk9N?=
 =?utf-8?B?SkxLZ3JEM2t0RWVYVnpQa1ZGSThSS21EUHNKK3hYaW9VV2d5Z0hDU0s4bS8r?=
 =?utf-8?Q?PEUrCYHk3kpxnQ+P2dRT4mHcR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd334b49-7f80-4ff9-fe41-08db29638e62
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:52:57.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BYjaAutu0WumwkPEAqFZIzrYUK5w9aP4VIzEde9HHFMX3rLyqRPFQc7SNhp/cs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 3/15/23 13:42, Reinette Chatre wrote:
> Hi Babu,
> 
> Please note "COSID" (CLOSID?) in the subject. Even so, you already
> know and have been reminded when you submitted an earlier version
> that resctrl needs to support Arm. Adding x86 specific bits to the
> user interface complicates this enabling.
> 
> What happened to:
> https://lore.kernel.org/lkml/9ca06669-7826-b3b7-0977-02185be7ce08@amd.com/

Yes. It kind of loses meaning if is renamed differently. Kept it same.
I will change it to mon_hw_id and ctrl_hw_id respectively. Will change
subject line accordingly.

> 
> On 3/2/2023 12:24 PM, Babu Moger wrote:
>> When a user creates a control or monitor group, the CLOSID or RMID
>> are not visible to the user. These are architecturally defined entities.
>> There is no harm in displaying these in resctrl groups. Sometimes it
>> can help to debug the issues.
>>
>> Add CLOSID and RMID to the control/monitor groups display in resctrl
>> interface.
>>
>> $cat /sys/fs/resctrl/clos1/closid
>> 1
>> $cat /sys/fs/resctrl/mon_groups/mon1/rmid
>> 3
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/x86/resctrl.rst          |   17 ++++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++++++++
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 25203f20002d..67eae74fe40c 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -321,6 +321,15 @@ All groups contain the following files:
>>  	Just like "cpus", only using ranges of CPUs instead of bitmasks.
>>  
>>  
>> +"rmid":
>> +	Available only with debug option.Reading this file shows the
> 
> Where can the user find documentation about "debug option"? 

I can change the patch order. I can bring patch 7 before this.

> 
> Also please watch spacing.

Ok sure.

> 
>> +	Resource Monitoring ID (RMID) for monitoring the resource
>> +	utilization. Monitoring is performed by tagging each core (or
>> +	thread) or process via a RMID. Kernel assigns a new RMID when
>> +	a group is created depending on the available RMIDs. Multiple
>> +	cores (or threads) or processes can share a same RMID in a resctrl
>> +	domain.
> 
> Please make this not to be x86 specific. You can surely document the
> x86 details but that should start with something like "on x86 this ..."

ok. Sure
> 
> What does "a resctrl domain" mean to user space? Did you mean "resource
> group"?

Yes. it should have been "resource group".
> 
>> +
>>  When control is enabled all CTRL_MON groups will also contain:
>>  
>>  "schemata":
>> @@ -342,6 +351,14 @@ When control is enabled all CTRL_MON groups will also contain:
>>  	file. On successful pseudo-locked region creation the mode will
>>  	automatically change to "pseudo-locked".
>>  
>> +"closid":
>> +	Available only with debug option. Reading this file shows the
>> +	Class of Service (CLOS) id which acts as a resource control tag
>> +	on which the resources can be throttled. Kernel assigns a new
>> +	CLOSID a control group is created depending on the available
>> +	CLOSIDs. Multiple cores(or threads) or processes can share a
>> +	same CLOSID in a resctrl domain.
>> +
> 
> This also should not be x86 specific. Also, please check the language
> and watch spacing. 

ok
> for example, "Kernel assigns a new CLOSID a control group" -> "Kernel
> assigns a new CLOSID to a control group", "can share a same" -> "can
> share the same".

Sure
> What does "a resctrl domain" mean to user space?

It should have been "resource group".

> 
> 
>>  When monitoring is enabled all MON groups will also contain:
>>  
> 
> Shouldn't the "rmid" (to be renamed) entry be in this section of the
> documentation?

Not sure about this comment. Did you mean to move the rmid (to be renamed
mon_hw_id) documentation here?

Thanks
Babu

> 
>>  "mon_data":
> 
> Reinette
> 

-- 
Thanks
Babu Moger
