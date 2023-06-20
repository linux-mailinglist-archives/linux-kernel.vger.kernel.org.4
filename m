Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0253D736F54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjFTO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjFTO42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:56:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961381A5;
        Tue, 20 Jun 2023 07:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxd8hacJZoQ5dX637LWqNEIhi9UlLJvUZK6SSVJZ3xBpkFrSwyBzfW8rimD+1YXjWhV5MxTpGqLZyQaoK3RwWuywt7ofUXLAEGgOf4ay1K9TojouCq9Ue0vjLR45wPVQnqxfk8BLju4fB/VBIwqlpB5uV7+1MIVRdAbKxsd/DJfpzduRifQKEh5vfZpGffeOAzPxXHd4ZeD8GRTZDed/3UgyHJziS0okaLbs9QmUdkuC+2ecAc7MwLWhpnhebBm/oftOWGEWOi2yjZWjgcNhm2zeW6lAJGTsC5i7Ojz4zco1UQlX/48kte/htPqsAAf2M5F3BNzmq5r/s8MHi04t2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1ZQpq3S0PXe7Wqh47CNPb5srEkXZ7oGg3Ulg2X1e1c=;
 b=kli565t1fre/5KVfeCDQverVPAzB3g/VYyDy2WwwZoZsxGrx9V583O7vxUF5SMGBX/Z2uBgCm/e983OlnTdPrkjukCh7mDLTMUiEM7cwCf+39WGqGpl6Siwjv8PIIMdeU2ROuSInxdJqb3DgrSeXawb1Cnun+qSJDxbwFIJycaD5ZIEweRLvy6lv5aBO3x9f2c9Rdan0mmrCyXgd1gKd67JoJhcF9wWs+9NfaKwFO2ctzUxcnGj6TPZ3eDWYSgvjKtcrkxtfUvEFyGHBYqDRhcOWAlv8oaE1rsfffleDHBSJIIxyIhHIjFOvh1nA6ZJalQ0yOzyATT7kNoMDtzwjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1ZQpq3S0PXe7Wqh47CNPb5srEkXZ7oGg3Ulg2X1e1c=;
 b=xQmZ7tvbBS1s9y456R+iqqIrbKzuSNfwlG1g8V2F0VJz4W6dt4W5NYL4eCgswjfPldjEuw1YN2nS8oytqZ0X9bk3I8oTzGera+eLdURR3kr1YzTb//y8gR6d6tpEVQr6OT9LcEjlXSpy6+i6z6irWnwKdvy9ZCX4fUs7uUcd8yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 14:56:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 14:56:22 +0000
Message-ID: <45a43152-fdf1-5f1e-1a46-0d9798c4090b@amd.com>
Date:   Tue, 20 Jun 2023 09:56:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/4] ACPI: CPPC: Add a symbol to check if the preferred
 profile is a server
To:     Huang Rui <ray.huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230615063200.4029760-1-perry.yuan@amd.com>
 <ZJG8w8le9AyRWKzO@amd.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZJG8w8le9AyRWKzO@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9991e76a-aff6-4f7d-b92e-08db719e8351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBAjgrwSrZbCchob+gx7OPAbag9eBuRzz93qydyEUM8nh1XabhYEV2qE0uIUFp5dK5hYSnyuOQR7MGyhwfFkC0hUrO4lBIDsflyTxd50N3J4o+Q0XU5Uk2fnU+AGIU2Fah3wU1S5pIT+9IkqAAyu9tXUwl7B/rK9mrdio7bF5sW0tQ48p8P6W8sR43OJG03DkRQIAQ+L8nQi7txFSx7dEI5xpkI7bgl5bi5gjGvkR/TzDTDcSsmBbINIEYmsF2FZZHvdhppP5/pfVaKHerYAY8NcblBh7PMLzuVKSKv6LPXJqfPeAXx1ldF8UUUeTo/77sf45VBXjVeni46YTkX5oRuIeujVJg2p09C1+rexAxZdqfhvEzWDEI30u3NI/k9/emoOHgPKYsU5ts+IXtTkdoVrEnN0sK49EOsTzfZHIAmGmPNRsXksjni8e62j40lrSvM8X7mpsHdGkSHjPkSH59p+prwTlgSwudY+dA3DEdscTW8kdkGLdrmUfll7YkC+tOuAiVtNW8oFPdkJXhmHzAYHKB/lVhLne+wTxcqzZoA4sT11DX06wyycA6HWgB3vo6IgLRduhIn4ZISzUYGnP00FVb4oOlnW38VtLBw/MwFRrVwNiLEYPnUDgF8PTj9rYw9g15tarwv0RiefIuS2aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(41300700001)(31686004)(5660300002)(6666004)(54906003)(966005)(2906002)(316002)(8936002)(8676002)(66946007)(66556008)(66476007)(6636002)(4326008)(36756003)(478600001)(110136005)(6486002)(31696002)(38100700002)(53546011)(86362001)(2616005)(83380400001)(26005)(186003)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STBENnViM1Y0b2hIMWVlejMvTTVOZkNnUHhGTGNTVDNHUVVwZDExRUR6V1FC?=
 =?utf-8?B?dnprRE1vR1BtL3VaZEpiVHd2bjNRYkloWmJQaVZUME03YVlRZVVTZlYzMmk1?=
 =?utf-8?B?elhTOWprR0RhMnNxbURYMDlZTUZYZG9aamd2M2ZJdjJrRFBaSFFXUElYTE1U?=
 =?utf-8?B?SmtsM1hORHh6UGhuS0JkckRCZDNxWkZEYWFnQjArVC9JZndwV3p0NHAzVnBH?=
 =?utf-8?B?WmpIdXlGblAxY2d3Yit3ejk4SnVQVmd6anBzblp2NjNGckFNZ2RSbXM2TXpi?=
 =?utf-8?B?SUdvZ0t1dkEwYjVPdnVYTjNjODJrSTJHN1M4WHVmcTZ5VFp6eU5Makg4TXFS?=
 =?utf-8?B?TkZDQXJPQjB2YjQ0Nm81NWFQM0JsMGJ1dzBJL2lNUXRENEI5eHB0UmlVako4?=
 =?utf-8?B?QU5Zcm5YV0szT2JKWUxHTzlSVm53ajR2SUFvL1NYa1VqbnA4U0hrT1FmSTl3?=
 =?utf-8?B?WUM2cEQzemlMYnpxcXpiVDd0REk2QXpNSzJ4TlUrc1AzMlJ1cXNBQjdYd081?=
 =?utf-8?B?ZmZPZ3RJekQzazRKcDZZUFozanc4SCtrQmF0WVFLZlZJSzhSYmwrU1RPWjg5?=
 =?utf-8?B?MW00V2VDWTcvS3Y0WG9UVjU3b0hZM2dlVkQ2M0NQZCtoaVBmRTdVL21tY01H?=
 =?utf-8?B?d2poSXNtOHIyc2drR3BYU1dseHpwRjVzQWN1Q25BaFR1NUFURm9oZmd2dDhF?=
 =?utf-8?B?Q0laNTNrQUFna0tvVEhBajRwRVpMNEFGMHZmU0tGd3dRTzBjNjB5U2Q5TmpX?=
 =?utf-8?B?dUZWck0zcHpRM0owUkliVXFsS0g1MGN6OVRFODlIanZEcE4rWklFblBtVmhU?=
 =?utf-8?B?V2dmaWJPUmo2dFYxcHpBTFVFVUZEZHZVT1JiT0YzN3NxK2FBdFdMbnQ0YWpO?=
 =?utf-8?B?cGVlVm1IdkgwcE4wUHRRNmlNWHhoMDlPMlpPWEJTQ2tFOEVrOG5mdWJxcFRk?=
 =?utf-8?B?ZW9mZXM3NG45c3plQS9YZDdJazBZWlppMTA4NzFjTVY5emRHVTVuenJHTFpQ?=
 =?utf-8?B?R1BJTmFtaVh0M3cyc2hFWHdYVXF5Y3Zsd0JzRkhPalB5QkIxZG1GenQxSTNY?=
 =?utf-8?B?Ly9BMWZ1YXlMUjdHS0lyODcvVUJyWWI3YXRibnlJRDdlVzNKTjNzc3JrRy9F?=
 =?utf-8?B?cE9rcXlWTlpoNWpsLy9HVCtUUmdudTJvR1BRazdlKzQvY3RkelVIcXdLWkQ2?=
 =?utf-8?B?Zm41NUZhazVKMDFydUZ2aTNBQnJhOW1KOS94Sm5zek95TGJEYzgyTHBia0I2?=
 =?utf-8?B?MEtOd2hxY2RyVk15V0NhU1NMdXI3NDg0K3B2M1N3N21Uam0wVmovWXNHQklX?=
 =?utf-8?B?WE5aNFVrY2VWWXNTQUhodWNXVVU3SzlNUy95VjVVc204QllPZ0djS0ZGYjBV?=
 =?utf-8?B?ay9ud2ZkYmFWTDdJa3NnM3ZhZ2I0MWZsKzRNNWdNdkluOTNvTXd0TU1jT0d3?=
 =?utf-8?B?Njc5eWJHbWEzT08rRTBTT2dwd3RDMUdBb3ZDNm1SQ0xxYUdHdlN5alZhL05M?=
 =?utf-8?B?QjQ1eDcwNlAxUGIxeHBiMGo4REdwNmFNRU13NnVWMThaUG9GdVFMYXltU1lE?=
 =?utf-8?B?ZUI1Yy9lbVBSZzlkQTdLakdzOXNRSlNEcUw2dGQycHlPRVl5WGJQcmV6RWNk?=
 =?utf-8?B?QWg0bFdWK0NUdnRxRS8zZHkrR28xd1dOeVovM216VUlPdWFQQzQ1TWJSbDQ5?=
 =?utf-8?B?eHZyaHkvYTJZM0h1d3BOSWE3Qjl4WGJRNlU2NmZHa3Z4LzJCemhSeE5SZENV?=
 =?utf-8?B?bENNbDBvMHo5YVVsRDNEVzlTbXVUaVI5WnVJa2lQOFBNcEUzR1krZk5SbkVI?=
 =?utf-8?B?RGdCOUNOeUhNTmFoNnZCS3BLbFc5ZTZubStpOFZRVkErK3o0TW5ZMk95ZVRJ?=
 =?utf-8?B?dkMrU1lTeHBLcDBSY1JBY1Nad1JSQjh6aWFSc3BqVndNVFFTVkhVZ0RuUEJW?=
 =?utf-8?B?ZVZJY0hXRXVrS3cyYmtCWUlOL3FmUjBoa3U0Ni9wTm9BOHFWNUozQjNtdXZG?=
 =?utf-8?B?TUM0Rnc4c3BiYlVIbjlXRzlZUG9aNWd3S2JTVGZhV0NGSi9UL0pkdlNqSGRT?=
 =?utf-8?B?N3ZNdnZDU0loRXNOaHJsaS9LdFp2WFN3alhkNE40bmFwUkFodGk3UU5BV2hU?=
 =?utf-8?Q?4jHYEKgrIVHaNLPCw8G4zyb5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9991e76a-aff6-4f7d-b92e-08db719e8351
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:56:22.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbnEmckhQCCFc7ukhbseGiZ9PoLPkLcK4ZjuwNs/rhY2IedY6JIwIr60d/FgPifSZENAq8xOiZQm/LZxG5AE1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
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


On 6/20/2023 9:50 AM, Huang Rui wrote:
> On Thu, Jun 15, 2023 at 02:32:00PM +0800, Yuan, Perry wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> This symbol will be used by intel-pstate and amd-pstate for making
>> decisions based on what the FADT indicates the system pm profile is.
>>
>> Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 34 ++++++++++++++++++++++++++++++++++
>>   include/acpi/actbl.h     |  3 ++-
>>   include/acpi/processor.h | 10 ++++++++++
>>   3 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 7ff269a78c20..d8827eae3ba4 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -941,6 +941,40 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
>>   
>> +
>> +/**
>> + * acpi_pm_profile_server() - Check if the system is a server.
>> + *
>> + * Return: true for server profiles, false for anything else
>> + */
>> +bool acpi_pm_profile_server(void)
>> +{
>> +	switch (acpi_gbl_FADT.preferred_profile) {
>> +	case PM_ENTERPRISE_SERVER:
>> +	case PM_SOHO_SERVER:
>> +	case PM_PERFORMANCE_SERVER:
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_pm_profile_server);
>> +
>> +/**
>> + * acpi_pm_profile_undefined() - Check if the system is an undefined pm profile.
>> + *
>> + * Return: true for undefined profiles, false for anything else
>> + */
>> +bool acpi_pm_profile_undefined(void)
>> +{
>> +	if (acpi_gbl_FADT.preferred_profile == PM_UNSPECIFIED)
>> +		return true;
>> +	if (acpi_gbl_FADT.preferred_profile >= NR_PM_PROFILES)
>> +		return true;
> May I know the acpi_gbl_FADT.preferred_profile value of powerful desktop
> such as threadripper or AM4/AM5 socket types of processors?

I have a Threadripper for my workstation, and it's:

[02Dh 0045   1]                   PM Profile : 01 [Desktop]

> I am thinking whether we can use this way to differentiate powerful desktop
> and mobile platforms.

On a Rembrandt laptop it's:

[02Dh 0045   1]                   PM Profile : 02 [Mobile]

Given Raphael's comments about intel-pstate preferring not to
match "SOHO server" as a server, I am planning to move these functions
into amd-pstate directly and drop patch 4.
> Thanks,
> Ray
>
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_pm_profile_undefined);
>> +
>> +
>>   /**
>>    * cpc_read_ffh() - Read FFH register
>>    * @cpunum:	CPU number to read
>> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
>> index e5dfb6f4de52..451f6276da49 100644
>> --- a/include/acpi/actbl.h
>> +++ b/include/acpi/actbl.h
>> @@ -307,7 +307,8 @@ enum acpi_preferred_pm_profiles {
>>   	PM_SOHO_SERVER = 5,
>>   	PM_APPLIANCE_PC = 6,
>>   	PM_PERFORMANCE_SERVER = 7,
>> -	PM_TABLET = 8
>> +	PM_TABLET = 8,
>> +	NR_PM_PROFILES = 9
>>   };
>>   
>>   /* Values for sleep_status and sleep_control registers (V5+ FADT) */
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index 94181fe9780a..05a45ebddaea 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -360,6 +360,8 @@ int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
>>   #ifdef CONFIG_ACPI_CPPC_LIB
>>   extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
>>   extern void acpi_cppc_processor_exit(struct acpi_processor *pr);
>> +extern bool acpi_pm_profile_server(void);
>> +extern bool acpi_pm_profile_undefined(void);
>>   #else
>>   static inline int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>   {
>> @@ -369,6 +371,14 @@ static inline void acpi_cppc_processor_exit(struct acpi_processor *pr)
>>   {
>>   	return;
>>   }
>> +static inline bool acpi_pm_profile_server(void)
>> +{
>> +	return false;
>> +}
>> +static inline bool acpi_pm_profile_undefined(void)
>> +{
>> +	return true;
>> +}
>>   #endif	/* CONFIG_ACPI_CPPC_LIB */
>>   
>>   /* in processor_pdc.c */
>> -- 
>> 2.34.1
>>
