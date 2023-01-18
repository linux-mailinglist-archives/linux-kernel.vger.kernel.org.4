Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3749D6714A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjARHIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjARHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:07:20 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDA06B99F;
        Tue, 17 Jan 2023 22:35:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2oxdx46KV6llEn8w0tJ/EcCji4yMzj4HRRex5A9GXDtKOKCtZdOjH38OCo4bW7nRG4AmR5FzN/Xtp0/mIdcQMkdW+NADo/Y+pmcS8uA03iNP8VC0AijMXnN4Cx31qEvHRMoB3Ixt8P4tttP6djl462DXOsjAD9CCPGicada08H9vJ3p/sdJIqOyDGfAnllQqU3jPWdqFPCKX6zCdm4/d6sOYmXx83AeUBF4/nZ02OlhKfQg4ILC3+QxKks9+MzBsqLl373+YH3Jfjd0yJSd5MBMT4CEBaKxSDvPqHYiz73EMdWATZCBsGqrMgYW5LvazEqnwImwbIMYT++LZkyFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtWhAlYafxkQPReNzFmbAn1By0NLnkp2IMJRZ8rNRP4=;
 b=Zquq5oXeICALRrCR4JZhwiDPgQUP+kCNbgytnU6M+d0BIhYzJrc8vM6uwUmaWrv66Y7Lh9fj0BJ41A+2zmuFsWoHnWrwIjLJ9LMOWpv3z1hm8UGfYIIz7cw7gAebiCk9x7Obx6vBqdc6f9fMqcxUOZUrYGHYsvmCw24KzQAUInP57p7GHC2oodjeWqGr9Muie3IfFP8HDjGHcyWqjsDgnuWL14sJXuNF3ySbDTvlhOhC1sY1QwXauzMaVZRutN1ehRZP0ppEhzH6wKhFuWRNkBn/YDM6HigjGtskassfNdA8o83F5F8sBhV/dDYi26MceGbLLw5rcU9yQv0PM3VZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtWhAlYafxkQPReNzFmbAn1By0NLnkp2IMJRZ8rNRP4=;
 b=jMo24aMkdxD6E6Gt+n2x84GAtMvJe/3mO/XKs/xGw0DSA02bpQD2KIln/56RIXenHo+TyyaJMbBc+uvaM+gknIG+EeglRPx3mgvIn4JzzqqUE/6OR/LYOfXCXbdZuZCPLBsJNrakqWsKYsojmAWTBt3Zhe78yGzZzLN3YErz5f4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 18 Jan
 2023 06:35:03 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Wed, 18 Jan 2023
 06:35:03 +0000
Message-ID: <57ce2408-ef8d-c133-4c10-73f226c11c44@amd.com>
Date:   Wed, 18 Jan 2023 12:04:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 08/12] cpufreq: amd-pstate: add driver working mode
 switch support
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230106061420.95715-1-perry.yuan@amd.com>
 <20230106061420.95715-9-perry.yuan@amd.com> <Y8apIMZ3b+dLrpA7@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <Y8apIMZ3b+dLrpA7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::10) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 9038918d-47c2-4c02-104d-08daf91e212f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2C/+F7KFpNo+9Va26j6lOQG/lweqBjrkOqEe9zxt/AqXsvTUXCL/nSXuripjWMCPjHgPrLRgYdCoLwcZo8kweNS3o106/OBtcfnYbyJPM6epTF/by5uavozrA2Ac3WrFpsJ66tbsScG4s1bIAB0UUYCykA5vhUVoxGGY48GCkkjxydAdvrqwL/0JH5Dzjbd5raqEsYW+VodPXD/S2ZP8aNImiKzVdkoToA7My8HMcFE/OOZu+Q2Or6AqbPPoEEDE71dDNn5E+0YqR3vJx38qI3iN1em4HfyUiaakhDYiKrUOluI5aq/Ox76HXk/OnyAo03tXl/uxd7gk9739X9D4niQLVtuvut2qbCLT0GvgFajU+GeeVmouLm6tAIq5Ydy3Ws6HGvmYSi6epuuKGBW9vJcuVCaItiHRqx5oEtbBOWF10riA4aK4M8n6cCLBqSLolPci6ZSWhpU7ELs24SN8TbpuuU8GzXHgg0n2w5izNsYHEHXrzQ5hX+oJ9YODnS6yWD//TZRe9mlSKOgPQjO5Py+hVMZegJZKfj08wH6LiWjZGM2/cI6Fhgh/CHmdhavV5ZpvxMbu3J0vi4wK8tO9z6fuljXGRAjhvqBNQP60mixEzHuamnD/keE5YSS5ZwfKY7gO4ncYTH+tO6j80WYMrqTalXgH6xfnmG0uqAphOZKpR6OBPEPtwVir9H+UbTRwnPGEdQrI1kMT9Yp9W1DAMPt48XaO9wDvVidkUOPmgsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(31686004)(38100700002)(41300700001)(2906002)(44832011)(5660300002)(8936002)(36756003)(186003)(26005)(53546011)(86362001)(6506007)(478600001)(6512007)(6666004)(31696002)(66476007)(66556008)(66946007)(6486002)(2616005)(83380400001)(110136005)(54906003)(316002)(4326008)(6636002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFiQzA2RkFKbUE5U3FMS1J6aVNmWEJkWDl2dk5GWWd5SE84UjFEeUhMZEhL?=
 =?utf-8?B?b1R5RDNibFJYNGU3dGtMSTI3LzhXTE5KbE9DZ0theEFLZDBYNnhmVVkvT3RV?=
 =?utf-8?B?ekYvancxWldOSGdzUitLWVBCQU9MdUNWZE1vM2g4YWNWeFdNNXRxeFdvQzZK?=
 =?utf-8?B?d29CWmwvNU45ZXhWY0JJU1F5VzMyNXF1ZWhEQ1dBN3o3NjRuWVZkZms2QVBO?=
 =?utf-8?B?engyRWpNREFjeklnekR1UFQ3WWdaWTk5aXBNL0FuRVhGNVBhemJUeHplUTFD?=
 =?utf-8?B?SEdGNDMwUGh3ZTFlSmJveHZoNGRJekp0SFcvQ3VERUFrVysrZ1dSMGYzekpj?=
 =?utf-8?B?S1Jkb3ZvVENDTytaODVxSHUzUUxUVy8rbk82Ujd5YU5sWlROMStDRlRlSFlK?=
 =?utf-8?B?V25UWlFMSGk2VUNSVlY0NWpGWHVVSWtrUit3aVNpaS9UUTQzcHVnN2VUbW5W?=
 =?utf-8?B?dkxHL2R5aWdYQkdzT0RBa0d5c3NweXlPYUFSekRGajJjWlNtaHNLcXVPNzhC?=
 =?utf-8?B?dUVDVG5UaXhOcWlaem11Wm9xVmw4U2lNRlhsUG9RWUxBSVdBQktzcnlCTVRY?=
 =?utf-8?B?bDkxZzlVVWVPK1lhRDNhZ09Vd2l6ajBvS3plLzgxanEvSEppSGNQWklBN3Bu?=
 =?utf-8?B?YWU0WXZURVBYWDFZWWMzams2TFAramFBQmlhaFpGRHZ1WXJoM0RtVUdjSlRO?=
 =?utf-8?B?cHZqK3BCdVQ4cDE5bjd6ZXZhbkJub1laaE1zN05temVjS2NsNGhYT3VYRHcz?=
 =?utf-8?B?US94ZXg2azBSbmtESDVhVWE4clA3cnN3bU4vaG1HbU1rMVg0aGdFeEhldmVw?=
 =?utf-8?B?eHg5TnNPS3pIS2lWd1hMam0wTkN6c1hwcERPU1VvaG5OT3ZYaThVWnJWZnha?=
 =?utf-8?B?ckpNVXNrOEpncDd5K3M1K0hUV0M3ODZua3lpVjlTbThQbEkrYUxuNTN6SktK?=
 =?utf-8?B?Y3JaSU8xS3QzcVhxUWNMMitTblhYZGhhMUE3cWFaT1o5N2Nsb1BKQUdUTW96?=
 =?utf-8?B?c3BYc2FHY0pOOWc5YzRHSzFtaUpVM1Y2MlBOZ0ZZSWV3Mm45cmpGV2xnam9Q?=
 =?utf-8?B?M21qR2pZRUhmTEZpRC9JU3Y0OEU3Vm5pQ0JqMzFpSlFhbnA3TjNEMHo4aGg1?=
 =?utf-8?B?RjN2S3l5Yzg5Y2hWby9pTksveDhrN0RTOVZFazhIckttdStWVW15ZzZrQzhV?=
 =?utf-8?B?c3NKUWxOWkxzYm83NXRFL2M4Wi8xSnVUWDc2MmhvbUcveWhPMTVRTUVQRmRP?=
 =?utf-8?B?dWV3N0ZFN01oMHRMVE1CeHJzMndHeE94dFI3VktFQXhNRDljOU93aFBmOHQ5?=
 =?utf-8?B?Ykh2RUF5eE00WGIyTERYUEhzUDk4RjZHa0Q2SmUzYUVSUVB2ZDJMWURRbEdW?=
 =?utf-8?B?bG1mNUYyKzNwVFFrUTNVeEtrOGtkWGg4cUdnWW1qMVgwa2VwaDExV1RtdWo5?=
 =?utf-8?B?alNJZXpJMXJpNkVPN29pNVpRdHMvYSt2eXVqOCt4YlZYSWwvZC91aUFuYmRz?=
 =?utf-8?B?UmRtb1Jwa0VaU1pIY3hYSlVJT3BNR1FLMDkwbVZLN08yOGFjNG0vb3NvSkx5?=
 =?utf-8?B?Q2ZQYU1qWHdoOUhkdkc2d0JnSVBxZjVaVDRRaFQxMm5iVmErampERVNuTXRs?=
 =?utf-8?B?Uzg4dDZ1SDYxWjBhV2tZenJEaVVXVElmMkFQb3JyVHRzZ3ZuU1ovaDNuaFU4?=
 =?utf-8?B?cG03MFRuQkdrKzdGY3dMNGFUcVZPeGFMbjFVYnpFRHpjUW9XUmRrZm9CbEZZ?=
 =?utf-8?B?bGFSekdoaThiYm9nREtTc1ZxNGp0NDFLeVZIMmd4ZEdTR0QwanhIY0NoWUU1?=
 =?utf-8?B?UEEraUJkSENUOVlDM3FBS0orMmlqdzlwZGhkeDh0UUErUFNBUVNtcXhJUjY0?=
 =?utf-8?B?L1E3a0N5UFRrZDg5TXAvakFodWJNZHVobG9lOFV0VlhSeWF1aGtxaE0vUU9L?=
 =?utf-8?B?R24xcUlxTEpiOWJ0VlV3bVlLN3ZmRmw2T3NPUlUyaFFNdU9iNDBjYWFpanVz?=
 =?utf-8?B?NUtZdlRFRHF6MSttc3FLZC9CQi9ENllsZGw0TndmT21OK3hST0ROcFErTnl6?=
 =?utf-8?B?TW1jbzlXamZXdnVKWW9hek1YU1RVZ2kwNFRQSkZJcElCL1JGTXNBd0VibENy?=
 =?utf-8?Q?sx2gD30XchYrl4E3J5ceFR+tb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9038918d-47c2-4c02-104d-08daf91e212f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 06:35:03.0695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwxovMsIMYVv3AdDxfDF+4bKRC+y5lgpDaAxwPocDv5fcCNXXDLxp0Lx7QCbi/hUKhz7k0ZABWms5pgVLtiASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray, Perry,

On 1/17/2023 7:26 PM, Huang Rui wrote:
> On Fri, Jan 06, 2023 at 02:14:16PM +0800, Yuan, Perry wrote:
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> While amd-pstate driver was loaded with specific driver mode, it will
>> need to check which mode is enabled for the pstate driver,add this sysfs
>> entry to show the current status
>>
>> $ cat /sys/devices/system/cpu/amd-pstate/status
>> active
>>
>> Meanwhile, user can switch the pstate driver mode with writing mode
>> string to sysfs entry as below.
>>
>> Enable passive mode:
>> $ sudo bash -c "echo passive >  /sys/devices/system/cpu/amd-pstate/status"
>>
>> Enable active mode (EPP driver mode):
>> $ sudo bash -c "echo active > /sys/devices/system/cpu/amd-pstate/status"
>>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> 
> Patch is Acked-by: Huang Rui <ray.huang@amd.com>
> 
> Wyes, may we have a ack or any comment from you of this patch, as you are
> working on the new guided autonomous mode?

This looks good to me.

Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> 
> Thanks,
> Ray
> 
>> ---
>>  drivers/cpufreq/amd-pstate.c | 118 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 118 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 2c8b126cec5a..d3f4cdd803f3 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -63,6 +63,7 @@ static struct cpufreq_driver *current_pstate_driver;
>>  static struct cpufreq_driver amd_pstate_driver;
>>  static struct cpufreq_driver amd_pstate_epp_driver;
>>  static int cppc_state = AMD_PSTATE_DISABLE;
>> +struct kobject *amd_pstate_kobj;
>>  
>>  static inline int get_mode_idx_from_str(const char *str, size_t size)
>>  {
>> @@ -631,6 +632,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>  	policy->driver_data = cpudata;
>>  
>>  	amd_pstate_boost_init(cpudata);
>> +	if (!current_pstate_driver->adjust_perf)
>> +		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>>  
>>  	return 0;
>>  
>> @@ -771,12 +774,99 @@ static ssize_t show_energy_performance_preference(
>>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>>  }
>>  
>> +static ssize_t amd_pstate_show_status(char *buf)
>> +{
>> +	if (!current_pstate_driver)
>> +		return sysfs_emit(buf, "disable\n");
>> +
>> +	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
>> +}
>> +
>> +static void amd_pstate_driver_cleanup(void)
>> +{
>> +	current_pstate_driver = NULL;
>> +}
>> +
>> +static int amd_pstate_update_status(const char *buf, size_t size)
>> +{
>> +	int ret;
>> +	int mode_idx;
>> +
>> +	if (size > 7 || size < 6)
>> +		return -EINVAL;
>> +	mode_idx = get_mode_idx_from_str(buf, size);
>> +
>> +	switch(mode_idx) {
>> +	case AMD_PSTATE_DISABLE:
>> +		if (!current_pstate_driver)
>> +			return -EINVAL;
>> +		if (cppc_state == AMD_PSTATE_ACTIVE)
>> +			return -EBUSY;
>> +		ret = cpufreq_unregister_driver(current_pstate_driver);
>> +		amd_pstate_driver_cleanup();
>> +		break;
>> +	case AMD_PSTATE_PASSIVE:
>> +		if (current_pstate_driver) {
>> +			if (current_pstate_driver == &amd_pstate_driver)
>> +				return 0;
>> +			cpufreq_unregister_driver(current_pstate_driver);
>> +			cppc_state = AMD_PSTATE_PASSIVE;
>> +			current_pstate_driver = &amd_pstate_driver;
>> +		}
>> +
>> +		ret = cpufreq_register_driver(current_pstate_driver);
>> +		break;
>> +	case AMD_PSTATE_ACTIVE:
>> +		if (current_pstate_driver) {
>> +			if (current_pstate_driver == &amd_pstate_epp_driver)
>> +				return 0;
>> +			cpufreq_unregister_driver(current_pstate_driver);
>> +			current_pstate_driver = &amd_pstate_epp_driver;
>> +			cppc_state = AMD_PSTATE_ACTIVE;
>> +		}
>> +
>> +		ret = cpufreq_register_driver(current_pstate_driver);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t show_status(struct kobject *kobj,
>> +			   struct kobj_attribute *attr, char *buf)
>> +{
>> +	ssize_t ret;
>> +
>> +	mutex_lock(&amd_pstate_driver_lock);
>> +	ret = amd_pstate_show_status(buf);
>> +	mutex_unlock(&amd_pstate_driver_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
>> +			    const char *buf, size_t count)
>> +{
>> +	char *p = memchr(buf, '\n', count);
>> +	int ret;
>> +
>> +	mutex_lock(&amd_pstate_driver_lock);
>> +	ret = amd_pstate_update_status(buf, p ? p - buf : count);
>> +	mutex_unlock(&amd_pstate_driver_lock);
>> +
>> +	return ret < 0 ? ret : count;
>> +}
>> +
>>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>>  
>>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>>  cpufreq_freq_attr_rw(energy_performance_preference);
>>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>> +define_one_global_rw(status);
>>  
>>  static struct freq_attr *amd_pstate_attr[] = {
>>  	&amd_pstate_max_freq,
>> @@ -794,6 +884,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>>  	NULL,
>>  };
>>  
>> +static struct attribute *pstate_global_attributes[] = {
>> +	&status.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group amd_pstate_global_attr_group = {
>> +	.attrs = pstate_global_attributes,
>> +};
>> +
>>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>  {
>>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
>> @@ -1153,6 +1252,25 @@ static int __init amd_pstate_init(void)
>>  	if (ret)
>>  		pr_err("failed to register with return %d\n", ret);
>>  
>> +	amd_pstate_kobj = kobject_create_and_add("amd_pstate", &cpu_subsys.dev_root->kobj);
>> +	if (!amd_pstate_kobj) {
>> +		ret = -EINVAL;
>> +		pr_err("global sysfs registration failed.\n");
>> +		goto kobject_free;
>> +	}
>> +
>> +	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
>> +	if (ret) {
>> +		pr_err("sysfs attribute export failed with error %d.\n", ret);
>> +		goto global_attr_free;
>> +	}
>> +
>> +	return ret;
>> +
>> +global_attr_free:
>> +	kobject_put(amd_pstate_kobj);
>> +kobject_free:
>> +	cpufreq_unregister_driver(current_pstate_driver);
>>  	return ret;
>>  }
>>  device_initcall(amd_pstate_init);
>> -- 
>> 2.34.1
>>

-- 
Thanks & Regards,
Wyes
