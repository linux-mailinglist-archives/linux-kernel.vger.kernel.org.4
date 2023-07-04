Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58FE7466C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGDBJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDBJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:09:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADED185;
        Mon,  3 Jul 2023 18:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTlB5q6hsFpoZpOIcdwUXPfRnasdb3ohvUw0a9+KA/IyCHkag28VJuFVfe7C2CVnXhNfGWL+8M4egSsH1h0hnY+tIIVOGAZn1LRwyiEFERIAf1LqFSlI7kn0YGqbNvM/94GOb2KsLy+k39iY6sCsrB/JLunZeBpt51uS7OYcDnLKv+71xA9VDKqRP30K83k1w/sIEK6OcGGvnVQrKJwO9zXQJHGOr9Yc8Ctmzf0+5Cl2HEE7zQkjQOPhvik7YrA9e3Vl7NntwkwrGbqVxd0rc+VzewaBtuqJyFqpcvfRZjIcUGnMio/O2d7q8FDw8CHoqNi935sg/XS5T14vNDsMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU6t85qN1dRQjMe7+Pm8VCWneyk8lGimR7FEWGJ5CC0=;
 b=FveFjEsU48W1i47iYgvXiCeXzJUYqqxkDuUMAn3mhOAt/NBLPtKiJPDzHSdrEHplFdhVmQVH7V2yU44XngNeie65rSkplW/xDV7vmWHgVW+sRuj2EC4BIfl0M2m9+kmhqev8khxFPuvkWxXBsFWyHLr0rA14NKxwWVxGsUfdcYk7ZSPdtF3tQ0mTQyrBokJk/0drkLLo4+aaf29P9BLl9cXyQA8cjRH4d5tKhT0MAVIpqloqLDcszXdnBshHUdb9iaJ8wnCZ7OmmDsHEWA6ioQIj70HwLs8A9hnHs83qkAMolJ6dkJmwumBXKmWMzBjg3z8k1Ta6ozdPzOfyWU1xOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU6t85qN1dRQjMe7+Pm8VCWneyk8lGimR7FEWGJ5CC0=;
 b=Tb1Ki/2X03cbofQFAVG6Qg+8AHOHSsFqEWjUUaV/HfiSLE65T1NtNccmfKtKyfLYWixtYaS0eXX8OyoHf4UwSX+Bu5p9LzpP5F4YYMT/kTT9a+TcEkgjJG+DJx7iBBMDQrMpoA+H8PmlmHbCBhnj50U8ypmmRQ0RNWODVtvN+fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 01:09:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 01:09:22 +0000
Message-ID: <1ca42aaa-3864-2143-b29f-31016eb7304f@amd.com>
Date:   Mon, 3 Jul 2023 20:09:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] cpufreq: amd-pstate: Add sysfs file for base frequency
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20230629135454.177421-1-mario.limonciello@amd.com>
 <ZKJzfbbMFRQO7xov@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZKJzfbbMFRQO7xov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:5:334::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b07447-11b2-4e72-b074-08db7c2b4cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sv1n1UsUhaKlqcimQtsgMJ3HX/FsuterSXjY609hkvvBUzeSVcT75MQ3yz9rpAsXYS/RqQVJPJJ8MjBSvfEH4Y2FtbGnxn5vKHEd9y/JnHDKXSLoY9w0aBhMDykUybQEXd8z2WP3OnQMVHAfD8AxtxkBAiyNXyvVJfol58X6u/8gs6MgZCgy5y9oJwszDGTW9ynlfU57owmY9REkkVuMF46W+swKH5aG0tFww+pCQ1Nm7dJco2/jSwelM7pm48RvKeZ1s6wcVXm5CKUPWaTB+QTKjbiKMLw74OHCs+t8lNUMipigcvrUshMnZB30pzVhN8q3EMtspAVyxpMFIMErn7LhAzzTfrgpNfox8cDf04qgAzNswx3UDURE+mM8aGaumFiO9BwSALVccZ9byhp2Dq0Cnd1fzefXh3lQ4pMdYHY6xUgS+HcQAcpFGcTSx3/wWcsmoxTbL+KNcHLWVQYS7kXul8niqJAhywzm8lFRq8BY1VeMGd5tls7chD9oQWtTeHovs+CMicYnpKbjdPOOpvHs9hjRzfPptKrIY5OIxQax0OoCqhWe98ASUc5BF7NvRbWetXL6sIL0yQGGzocax77X40zK1GYX76W+yllFhq4QAAoC7Qm9wJtjkpj529DMkWmVLq1HKZTlQIWUuyPJXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(4326008)(316002)(31686004)(66556008)(66946007)(186003)(86362001)(6636002)(31696002)(66476007)(6512007)(6506007)(53546011)(83380400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(5660300002)(44832011)(478600001)(6862004)(37006003)(8676002)(54906003)(8936002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZnUjBJbTBmR3l6dzVsSkxQK0c2QXd3RjNEOUl4Ym4vY25VMUE3bXRrSWlJ?=
 =?utf-8?B?MEFIRmxCRkszMituVSt1WllxdnEwQnNvQmxIUHQvRmVPTVl3QjNOZWkwZ0tw?=
 =?utf-8?B?ZVFCSzVwRk5LYmxCUGkva0ZpYTRxZ3pJYUtXUk9qNVRiSWFocFVZY2VQdlo1?=
 =?utf-8?B?SWpWc3M3dU1rbTJFTEpyajdhT2FxbHZhakhmNDdMWDFWRndMMHcrUXk0bXgx?=
 =?utf-8?B?aG5uWEhTQ0xXNkFJYUxnSFN4UHRYQlZFSUpEVlJ2YzIzS0JtR3NGUVp2Y2lz?=
 =?utf-8?B?VDhiLzZ1K3dXSW9BVXIweEQwY2R3dVZLZmlFM2xYUjR1akxWWEJ3bktzY3di?=
 =?utf-8?B?ZnJ1QmJ6M3BQcWZPa3dVMFE5YzdtZ2JQQzVlR3FTZW40bzNoVjV5Wkp4SXo2?=
 =?utf-8?B?UmhvSWNLMUJyWWF0TDB2ekwzWnljUjFxTFNqQ0wwQ01WV2VLemxNZStkaGFw?=
 =?utf-8?B?RFJMa3hySTN5bzRNSFRHY0U4SFQ3N0hxbmVkMjc2RG9VbFRXUU96UUZITVBn?=
 =?utf-8?B?dTNscjBBcHZ1SFFJUU1nL1kvSmhPVXFLMW5QMzlYWHkzS0ppY1hha3pNM0gw?=
 =?utf-8?B?ZnRmcUYrNXFReTBHL0F0RFFoSGloUUhESjZGOUVqWTh0Y1NSZFA0VGJ1Z2Zn?=
 =?utf-8?B?c1BBVzZ2bkwrMGhXN0pnZkJBVlhpMnZKZk9sL0t3SjBlWFR5b01JSlRqMHcv?=
 =?utf-8?B?RTNHYytrcHFUVERtNG16NHJ5SkI4SHdUcTlpN1Fyb2dsL0VpenJ0NHRGRk1C?=
 =?utf-8?B?eHg2N2wyOTRiSmIwQUlpVDBod3dnblRJVmUyL21CdDRMeU5zcGNBamIrZ2VE?=
 =?utf-8?B?ZzZ5ZXp2YTNoemE4YUdWQ3RjMXV5WG1EbldDeGpSQ2VXeUpmVUpSRnpBY21H?=
 =?utf-8?B?dnV4cjh4K3g4V3FYUHZiOWpNRUtOTTY0NWJKVDI0NkJUcFNjSStNcjVsdGUx?=
 =?utf-8?B?TUMrNnJEc1VaTGp5RzBUYUdIRWE1N1JFRndOTzdkTWxPNTQ0RHRUR1QrYUIv?=
 =?utf-8?B?Y3N1amZBai9DMnovTldQRm9IY0FJNzA4MGl0MCs4bDBrTk96OWwyL2MwZEs4?=
 =?utf-8?B?Skl1dk9TSGw3QWF5QzAwdVd0elVWVTcyK0tJR0RXdUdNY1IzalI3WDI3b0ZS?=
 =?utf-8?B?WWoyazhWdnN1aGpjMmZ5L0VaMHpUa2hDL3l3TVMvUWdheERWeVZTTlBIdnFj?=
 =?utf-8?B?QVdZUllvUlJjSWFYNml3bzZ0ak9YSFhBV0ZjQ1pjWTg1WklRc3JQeHlrY3FC?=
 =?utf-8?B?d0I0d0k5VHVTK2hKbUlINDd1ZTRSclkwYm9uYnJmNllodEs2YXZ0VVFqREZD?=
 =?utf-8?B?WTdoNVppdks0MWdrdmdkYng4VFd1WFE3QURzRkJMT0NYdUJ4TllLUHgvTjJX?=
 =?utf-8?B?cmtuaWkyUlRKcHZIZjFtR21vNWJla25rUTBHV3VKNkRjSEI1cUtQcnJxS01B?=
 =?utf-8?B?QWhZYy9oZGF1Wks1Z3lHQTNxSlRDdDRrU1BKUFNjdVM5bDRsMVFTWUJGS1N4?=
 =?utf-8?B?dEordFVUcGh4Q0xXQnhXVmFuek4weUtTRTdkMDEzWnd0TmxnZnREbDB5VCsz?=
 =?utf-8?B?VUlyeGdOeURHcUJ2NjY5bkZtYlY2S0JPb2h1NVdOUEtxaHd5Y2VHMWliZUd6?=
 =?utf-8?B?STBXL0t0bGEvajNtM0VYNnVDZjJ5alZ3T0p6Mm9OOFpqZUZ6dU83Y1N6eUVa?=
 =?utf-8?B?eG5RTlhYVWkwVjhjS1BmL3YrYVFHbmQ5UU9wSzcrOTA3dCtLY05pMEliek41?=
 =?utf-8?B?cm5oeHRqTlB2UG0yeU1sb0dLZzdyOUZQUjBSYXNlZmZDVWt5WnVqSVNsdjBo?=
 =?utf-8?B?MmhVT1dNVTBVTTliRzVPOFRjSFJOcnF6OWhDZGwyK1VNWkN2d240RkRJTGxT?=
 =?utf-8?B?VGlxVVBJcElVVjBoMFBQaitOcnd1MnhFOE1tbkJuZTlnOWlJU3ZzdlFUUmla?=
 =?utf-8?B?NDNqSzJKT0hoRGRZUUE1eHRlMDVtUEtHVmhZWDZGTG4zV1JPK3pBVGVhK2hR?=
 =?utf-8?B?eGxWKzhhYUh4V25kQmZjU1BHQU8yNU1LVGk5RlNxTExPM1puTFpDRzE2VURQ?=
 =?utf-8?B?QmRQVU9xSFd3UDZVelROWU1FZkxWN1lyQVZ5bmZpeElmTlJGbG4zUVFoTG9X?=
 =?utf-8?B?dTVZd3ZBRnA2ZjRjOWloVFRrcERIRFZrakY0WmRmYno0TEtlRTZwc0Z0Z09V?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b07447-11b2-4e72-b074-08db7c2b4cde
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 01:09:21.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aj7BZOq/2a4liRi+rKmXCUgchEpaPWd00tLWnI7YwrXRS3t2p31IIAZrWbRo5dpoaBeHFDMKBGbbqa/Ym4/sxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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

On 7/3/23 02:06, Huang Rui wrote:
> On Thu, Jun 29, 2023 at 09:54:54PM +0800, Limonciello, Mario wrote:
>> Some applications may want to query the base frequency to tell when
>> a processor is operating in boost.
>>
>> Tested-by: Wyes Karny <wyes.karny@amd.com>
>> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
>> Co-developed-by: Perry Yuan <perry.yuan@amd.com>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   Documentation/admin-guide/pm/amd-pstate.rst |  4 ++++
>>   drivers/cpufreq/amd-pstate.c                | 15 +++++++++++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
>> index 1cf40f69278cd..e68267857e859 100644
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -281,6 +281,10 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
>>   firmware, if EPP feature is disabled, driver will ignore the written value
>>   This attribute is read-write.
>>   
>> +``base_frequency``
>> +	Shows the base frequency of the CPU. Frequencies above this will be in the
>> +  ``boost`` range. This attribute is read-only.
>> +
>>   Other performance and frequency values can be read back from
>>   ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>>   
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 81fba0dcbee99..0fec66b3f7241 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1037,6 +1037,19 @@ static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
>>   	return ret < 0 ? ret : count;
>>   }
>>   
>> +static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
>> +{
>> +	struct amd_cpudata *cpudata = policy->driver_data;
>> +	u32 nominal_freq;
>> +
>> +	nominal_freq = amd_get_nominal_freq(cpudata);
>> +	if (nominal_freq < 0)
>> +		return nominal_freq;
>> +
>> +	return sysfs_emit(buf, "%d\n", nominal_freq);
>> +}
> 
> User can get it from nominal_freq at drivers/acpi/cppc_acpi.c:
> 
> show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);

Thanks for sharing that, I wasn't aware.  This patch is unnecessary indeed.

> 
> Thanks,
> Ray
> 
>> +
>> +cpufreq_freq_attr_ro(base_frequency);
>>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>>   
>> @@ -1049,6 +1062,7 @@ static struct freq_attr *amd_pstate_attr[] = {
>>   	&amd_pstate_max_freq,
>>   	&amd_pstate_lowest_nonlinear_freq,
>>   	&amd_pstate_highest_perf,
>> +	&base_frequency,
>>   	NULL,
>>   };
>>   
>> @@ -1058,6 +1072,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>>   	&amd_pstate_highest_perf,
>>   	&energy_performance_preference,
>>   	&energy_performance_available_preferences,
>> +	&base_frequency,
>>   	NULL,
>>   };
>>   
>> -- 
>> 2.34.1
>>

