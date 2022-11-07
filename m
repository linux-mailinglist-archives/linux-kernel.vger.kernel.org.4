Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D6361F32D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiKGM2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiKGM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:28:01 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482241B9CA;
        Mon,  7 Nov 2022 04:27:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/iXQxSZGwdP9VpWa5lbE8ihMVPNXcOBshsIu58JqwhA46xYa7wl1Yj+6thLEq5lmfnqXnX72j7K4DzF3uQEl8ZuPjmSa0i2t8gQGRDJ5+GXWfrviL+btd3d+awSYNoCkk3K64AvA3gCsXTMSpdethaJEvEMVEnhrfCrJO+0eK+BxqFoSeITwmXvEFqh7gUPPHKgr/iEalz9gfK0ou0q1tRCfX7wPqoaU0i/YUZowoTwP/+9fcZojo4O0PnxkIb8Z/m6Tky/jRedrOLUHvPrDp83Ist9kakXwyt6MbXXvlaTt6iKcq1WY4uS0TEFDtZYB84hch7OeCJpV7pTN0GQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYv3TcwYWP3CQ5Kp82VOOe+0JfZAt0pqj6iTTC60/xc=;
 b=RYlGybRx7jOp83svipxac5bXfu6BAR6QqBgpy7cEkK0Y+0sB2MdLHqCDJsR66l97JMUrpRPhyW9ikCguuKXakVVKr/CTVMsYUr6ovIi+eMowW242O74IhhND66VqsepCW2Lly6yhPSl8roq/8p5gJIpTmY7E+KlqU/5nWepFKvBdre9N1wCnXJw1Zl/CLO04slVZcJBJ76S4Js3eIHSmxzGzxM11RvjBKRuMHT5SRHjuFlBEpTDxFCG2ZS5ebsEfOQOM/zSxVoVd6l7RO2W56dlWe1CfWkc78de8R8gQALYkZL4igawJ/9gsR5U3PqaAYtxfbRabGFmAqhumshJ0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYv3TcwYWP3CQ5Kp82VOOe+0JfZAt0pqj6iTTC60/xc=;
 b=JlMVmRIPLB/VyDoooYsNhBZcAvJvWJXx1qSPYO55ty1MYePHdbpQTkeoshQhnnjNEZZBW0aRjtSvQ8gCt+0AX3jOytY+g5T0dYEwf7vJ83czUx3ORz0cQ80Y/7CBOv9QcLvLLNWfT+JgrcibnvVrQzxYmVxJoXLcFkEG+DTcFKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 12:27:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 12:27:53 +0000
Message-ID: <721f6a1a-1144-4fe4-e722-2ba2d7200680@amd.com>
Date:   Mon, 7 Nov 2022 06:27:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency errors.
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Yupeng Li <liyupeng@zbhlos.com>, Shyam-sundar.S-k@amd.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        caizp2008@163.com
References: <20221026072531.346013-1-liyupeng@zbhlos.com>
 <0910bcc4-d55f-6f3a-b2df-4e30d164aeeb@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0910bcc4-d55f-6f3a-b2df-4e30d164aeeb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:5:14c::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 53553c2a-3ae0-434b-e4ee-08dac0bb7e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmtfFVQaZeloDQmj8IwaFPWEj2CjVUxZcyY6AATW808mhqg4ebpezcOVis/QmdSmUO5d6PhjxWnXswdFsx0YbzmMrmx28SY2rHuxZWeHncWK4OzTakwMhPWKCqYKCmwFwQ34xhJ9IqfpeMWkxMNnYKxEuyNE+wrAkSS9k9UJxuwYTfbIgfR0RZr5VDYkiXGBA2240iWHpOdkBrgJfVgF0tMDqMXHuHANKOB6nCxlw/qxN+NwFxCwE5pEOFlCB/JYCTyl5ig2Ac+yR/C3ggL6CtTT23n4BunCyK3M+3Z62iwchgaDcPeaHcZaBFMwdUEZh88w7Uy2Rj9yaHw8LNrGkRpyyrcMq2ZCRIvU0RxDe8OZi5i4q7599AbBcYxnpYadATfS078admU8NciP+odTxMo//DpmC/fzTDl2JIPn1y5xBtzTjwABJRVb4xMuChdDXpRYDqgDTYiT29ji8CoI3FQ2Qw3uDPoWxqiZv32Fo05tc31oToGF16qjaA6ocjGwlqsCBR2TTDPBiYy+CbPhmIxkV7ZSkjYURKy4exNfL/U6ESckVRRDMP1DL/O2CJ6gMPdisvcbZzaCykFOGTDNSPDzZsGAv3al9PTWqCkh5i4eTts197Zu1VgurmmWoQaYMmUxMK/7h1Tzmq6VqWocuqc0P8wzTF2cnngfJKwFAZliX0SCG7Q0HmaFVce83dGdVoEJMvY9GMoO66NsHJMqK77rpvaso8UlTrdLu9HcH9ZOiqGdq9eR5L01j1ACVx8xFA/NgSzpaWsSPYz+MIWF92t66LktODDackj+z3nZ+0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(66476007)(8676002)(4326008)(66946007)(66556008)(316002)(110136005)(38100700002)(36756003)(8936002)(5660300002)(41300700001)(6486002)(6506007)(44832011)(2906002)(83380400001)(186003)(2616005)(6512007)(53546011)(478600001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkYxZHdST1lZNUxjNE0zdzJiamllMmZ3K09YN0Z4dkJHZzYwU0ZGK2djZTRL?=
 =?utf-8?B?VEttRGxEcks5dVVaM2FneUEzMGFpbkd2VGNPOXpuY0RkRUpPOC9yZG1aWW5n?=
 =?utf-8?B?UW9XY0o0ZnZVM1N1eTFRNVpwTWhzWkNPTUo1Q3FRZWp2UTRDK1NRZWR0cVh3?=
 =?utf-8?B?dE9NR2tVWXRHTGI2UUdIZTFHQzczREk2eW5TMUtMam9tTEIwM0I5WUxZWGp4?=
 =?utf-8?B?a3BCcmV5TWFWUUpLUWxickZRZTZ2V21LblRPYjJ4VWpCRDdDZldESVhGeUEv?=
 =?utf-8?B?S1RXYUgxTzAvZDBnL2pkL241Yi9BTU1EWUJWSkdYS0RsalZaUHBTc0wyUzVR?=
 =?utf-8?B?cHpFQXlHUC9nWmZSa3VqZlU3eGEwWnAybk9maGxEL2ZwaCt4cXpIa214dTR0?=
 =?utf-8?B?cld5T1pSWDlkZnR2RE1TN0JSNmV4NlpmeFFUeXJPUnBXNVdDeENzZk9aQWor?=
 =?utf-8?B?WS9sem1rbFRFa05XZjhFYkhuS1Zha1FNNXRWc3MwbkRKUDdPWEhLMXBsNWJk?=
 =?utf-8?B?TnJhR3lhV2k0NnorQUpkek9aSURLRk4yTkNyWWRWWTNsS2RWOTZmQzR5SERO?=
 =?utf-8?B?Z2p2eFB5ZmZETTRUSjhWeWtVTmFpZXRLTmVhVUlsT2gwd01Lc3ZvdXY5MEdE?=
 =?utf-8?B?eGVJT1FaNk9HSkwvelNUNEVWcHBBUUUvMGhBWTJEc3ozR1NvbjhqYTVSTWRv?=
 =?utf-8?B?cjd3b25aRVFJR3ROdzRqWTZQNVdOc2dZdm1rNlpHNHhiNVpRL1dMeG0wSDcy?=
 =?utf-8?B?bUQ3c3dma0wwZCtvM04rZGowUDc1TnBZN24wZG84aGg5QU50K0NxYkRSRTdz?=
 =?utf-8?B?NElhQzRLZUpDR3hpTUQxMENEcFNVRjlXZHhPK0FUV0wydkJCU1JYU1FLNVox?=
 =?utf-8?B?ODJPREVSVmxGNng1S0V0TmkxblZZbWM4bU11ZzZCMXNYa2ZLV0FVcUlaNlJr?=
 =?utf-8?B?Y0RpdzVyaXk3bHFkbFZra0ZjU013TTlqZ1VtYW5HemtvL1JoUk9sOXlteFFM?=
 =?utf-8?B?KzFkdGRBaTRVNVgreHVhM0phS2RYQ3d6TE9EblZDS0xRUEJwSTdYbFJsTHUv?=
 =?utf-8?B?bzlHT2lPUzRsVm9zcStURGlGaDdZT3MwZEorNVJJQU9DeEZwUjJ1VytsT0Zs?=
 =?utf-8?B?ZFJQZGMraU92SmhJSUR0aHlEek1aREsrTXVNMjhwUlZqaHErTFAwODdrdk0v?=
 =?utf-8?B?WjVaNHBBblh3Q2FHY1U2cVRsZnhORWRTTWlwWkZ0V2NzQ25pc0ptc1hyaTNR?=
 =?utf-8?B?SS9QSDhBUTBCbUQ1cUd2VzRVdWoveHBWMWV6VmZVekMxRlZIUklOM2E0S2pC?=
 =?utf-8?B?S3o0dG1mTW5pRjM0R0MrV3RHa3M2RmdwNFVzYkJGcW8yV3ZjY0dYTkdrUEJa?=
 =?utf-8?B?NnYxcUZTbkZnUVJtektUN0RMaUVOU1RkYzRaajhFZUw1TXlvVGNjempIY284?=
 =?utf-8?B?UHNFcHNjUGpJaUpPZ2FMZ1JseWx2bkZIcGdmeE9JRDFvZkxhMzlIRS94RytB?=
 =?utf-8?B?OEFlWDIrSlMxK0I0anN5cG15eW9MVEptaU56T056S25yTnl4eWdXTkdJZzdU?=
 =?utf-8?B?SFVmVWdpcWM2UTdUMysxZXF3NUo5RStCN0VJTjYvNXRRUW15S3JMU2pudS9Q?=
 =?utf-8?B?WDB5QnJhU2FVUjNVWk5mbTFrTGJCZnRwcFRJRHhmaCtiVUdrTU53aW43dFdM?=
 =?utf-8?B?UlVsbWcydUNBaEpDRWVqZXRnaGsxbjF4dnh2eTh5QVVNYks1Q1hUcHBJRjdp?=
 =?utf-8?B?cjJ3QVVCcmpVeEVJS1l6RDVTNlRsdWFrcXJTS09nYTh4ckMvSkZJQzJ1UWVu?=
 =?utf-8?B?MWRSZysrd1A3M285YUxiZ2o3QUZwUmdEWUtwUDYweUQ0RUVocEVYM090VDNK?=
 =?utf-8?B?czJlcHdzanY0MHAzajI5WmxLck1xK1dnNWowQWMrc3NCS1dodjV4ajg3VS84?=
 =?utf-8?B?UFdISmJGMkVPZmFFWE5jQTVDYko3d2JsWXhGdlhRZHFMck9rcGNxWTRub3Ir?=
 =?utf-8?B?dUk3ZkU4dnZieEoxcXRpL2phOHpSQTUwWU9MWDBvYzlsZzdNOHJNeG4rRlRK?=
 =?utf-8?B?OTNGWDc3Smc2S3FFbktiTmc3UExLWUR2VjlpMmtiN0dPRUsrdCthb0tpQnQy?=
 =?utf-8?B?TlE4Q3BuTDluMXp4MStwWExLNTBrK2sxMXpTK2tkZDdsWERTT0NmSWViaDFT?=
 =?utf-8?Q?bt8MC6prPC3gHFF7TYDk3i/+Wvc03vzrRO8nhTB7NJGw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53553c2a-3ae0-434b-e4ee-08dac0bb7e56
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 12:27:53.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPdL5g+4eLQnDdkD9gc+89riPYfjAXAyFkwkrtdD+U4gM1toXlis8MN/lBNKWkMnB71GsAvFx+6pEqenzv9Q2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 04:28, Hans de Goede wrote:
> Hi,
> 
> On 10/26/22 09:25, Yupeng Li wrote:
>> When disabled CONFIG_SUSPEND and CONFIG_DEBUG_FS, get_metrics_table
>> and amd_pmc_idlemask_read is defined under two conditions of this,
>> pmc build with implicit declaration of function error.Some build error
>> messages are as follows:
>>
>>   CC [M]  drivers/platform/x86/amd/pmc.o
>> drivers/platform/x86/amd/pmc.c: In function ‘smu_fw_info_show’:
>> drivers/platform/x86/amd/pmc.c:436:6: error: implicit declaration of function ‘get_metrics_table’ [-Werror=implicit-function-declaration]
>>    436 |  if (get_metrics_table(dev, &table))
>>        |      ^~~~~~~~~~~~~~~~~
>> drivers/platform/x86/amd/pmc.c: In function ‘amd_pmc_idlemask_show’:
>> drivers/platform/x86/amd/pmc.c:508:8: error: implicit declaration of function ‘amd_pmc_idlemask_read’; did you mean ‘amd_pmc_idlemask_show’? [-Werror=implicit-function-declaration]
>>    508 |   rc = amd_pmc_idlemask_read(dev, NULL, s);
>>        |        ^~~~~~~~~~~~~~~~~~~~~
>>        |        amd_pmc_idlemask_show
>> cc1: some warnings being treated as errors
>>
>> Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
>> Reviewed-by: Caicai <caizp2008@163.com>
> 
> Thank you for your patch, however I do not believe that this is the correct fix:
> 
>> ---
>>   drivers/platform/x86/amd/pmc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
>> index ce859b300712..2b08039921b8 100644
>> --- a/drivers/platform/x86/amd/pmc.c
>> +++ b/drivers/platform/x86/amd/pmc.c
>> @@ -433,8 +433,10 @@ static int smu_fw_info_show(struct seq_file *s, void *unused)
>>   	struct smu_metrics table;
>>   	int idx;
>>   
>> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
>>   	if (get_metrics_table(dev, &table))
>>   		return -EINVAL;
>> +#endif
>>   
>>   	seq_puts(s, "\n=== SMU Statistics ===\n");
>>   	seq_printf(s, "Table Version: %d\n", table.table_version);
> 
> The table variable gets used here, but now it no longer has been initialized by
> get_metrics_table() so just #ifdef-ing out the get_metrics_table() call is wrong.
> 
>> @@ -503,11 +505,12 @@ static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>>   		if (rc)
>>   			return rc;
>>   	}
>> -
>>   	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
>> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
>>   		rc = amd_pmc_idlemask_read(dev, NULL, s);
>>   		if (rc)
>>   			return rc;
>> +#endif
>>   	} else {
>>   		seq_puts(s, "Unsupported SMU version for Idlemask\n");
>>   	}
> 
> Same thing except now nothing gets send to the struct seq_file *s,
> so this is wrong too.
> 
> Shyam / Mario, can you take a look at the reported compile errors please?
> 
> Regards,
> 
> Hans
> 

What kernel is this?  Shyam removed CONFIG_DEBUGFS in b37fe34c83.  So is 
this failure still happening in 6.1-rc4?

