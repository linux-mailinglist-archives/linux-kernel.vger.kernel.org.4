Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3B61FD3C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiKGSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiKGSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:19:16 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278E218F;
        Mon,  7 Nov 2022 10:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDyrfkhXYWfaF/ZPWqAvN1dY70NV5lwIGwvp9bP4/40esRk1EcxkVD2+760DgvD6RmZ+2iPDK9WJlfnVnrQ2qVkE8qX5ZCPPybZ7a5+SONEuyNWtYcKTz6+bM1oU1DkV+tm+9olmHGD1JteQyJokK0uhKtN4rrkOdkmZ9KH+9jNyJHh6AV5jTWsbZMi068mNx+BWo58359ZgFQXOvBkeCrbMT3DDBjgnvDh1+dP3I9MQrGy9ftBRzNZuBUdh8fs6HQAVn2SAWcACzPoHLgPX9iBizfu8d1aCLpSBDmLsS3zi3NAatDQPTU6x7D5P0mmabkHsr3DYYt1y3jTqSQux9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYasbIiL0YgH5mZOOE/OQZlOBJ9vDc+0nFXIHERWJq4=;
 b=KerET0GiUDCobJ7wMLvmsNpnbeSBQO4cJQosNei21OwbxuZJRyA6+LNZop4xDFFNBg1uUcOBJdpGAD4Z9nvHW6yDHvMQLpubzf50NlLbhX5CDAvBSLatGj2iIsLKRJuVGwWt3TTKOumCtK/o9F//w2so1h2u0tOYet0aKofJUSytWGxXu268iTgJVAUz0j7JkvMB68U66s7As5tq+IGB9gJcPGAITMeqVlHLQLAQj2bpMNqL/855iuiafBLlfBduuTZvEluyeO28pXKfLpqDb/vQkBtSwqwrNj6D8LjOYrKyPE5DKY2LKsiPk0IawPxfWvQoeviGbYxUX7QzwMS3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYasbIiL0YgH5mZOOE/OQZlOBJ9vDc+0nFXIHERWJq4=;
 b=x5gr0WnZl5qjd5qSOhaBPpyZyuZfRw7evnY9lbh0shiI93VivaFjCPpkKZOZIqMO9+nc41jYRQq9k5HR8S/1QXCqVVnpLrBJg23TPhdFnm4qlgpIjXTLZmAOLPVQjusmY+oKYA+FUAFgvBa06Tjr0mXpIZzJ+d9UN0npvxaqZzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 7 Nov
 2022 18:18:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:18:13 +0000
Message-ID: <30690bad-e3f4-36ee-c957-a2cf750b7775@amd.com>
Date:   Mon, 7 Nov 2022 12:18:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 6/8] cpufreq: amd-pstate: implement suspend and resume
 callbacks
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-7-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221107175705.2207842-7-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:32::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 520170b1-647c-4862-2abd-08dac0ec6ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNUcTLeFUJXAQHbfvGUymHey4PUl9TOJzKQWIa33Wg0YRZm/utcnHgeyx7/HCu7/VddZbnxS50ilsxUT9hcQh/16RUG//5rs7gJezvjuMtQm166z2VndeXXTFxyd21cNchU8xNxynRCGE1jSJNbLbcst8feaQ/geW3BkwZzo5GcXxoZOBWRxHMivg6ijIXW8nuUr+7g+9OxZ39smAh/QV9jbzA+ID8mwQ1IG7lB6VjEKR7nztedkssaCcmhldvo5njjwhrHcB8f1C1BgDiJp66Cl1y2DShGEBswA3AbG/ERVkN1WOG9zWZTkKDJhfyhDDIH73Cn3XTj33Ro/dh4Odle7WRfFwgtYIQ8sPEpQTc3+o5edyIlQOF8it2Yc/m0kqwmHC8UUWt9kgnfmAmtkSOXgvSl5gXLfGW4PnxpsAjCt6F0WWU+RtQDdUGEoggZVGyh56TQREWXH01IaZ6a85ZabjK6uiLYAxyh8kdzIJT1qp88swL/N/WFjLHD1Lb6HAUv/6aXwaM1gIewHkYJ/5lve+ds2LsWrf89HNM4ly6SJ4rN6O2Y8of0w9b/vMvgYZejO1J5d+/w1M4jdH2kt5Q+Ic7WNXEzGpteC3vVInHAaeci41pyjl7EY+eHd3sYjbJay3Jkw54QkzjvuvHZJHx1DBbIpMI7xGUleE6rGSosqBOILA+p/ZlIfboeiQNRYPXbOt7aiDzXBmBQrxS/ZSX+bOw2TQH4W3Ug3mysoWcOpNSfGOV5PIfYtn8uZOJOcYSNWcqU6gP23mjwRZU6P9BAVEpfPfgGpE7o/BTVTNE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(26005)(186003)(6512007)(83380400001)(2616005)(38100700002)(2906002)(5660300002)(8936002)(15650500001)(53546011)(6486002)(478600001)(6666004)(6506007)(4326008)(66556008)(8676002)(41300700001)(66946007)(316002)(66476007)(31686004)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNJYUw0NytmREEzeTY1K2xONUJEWlArZGFPNVJvR0ZvNS95dysxd1duOWh1?=
 =?utf-8?B?ejRpMHNENW1TN2pWd1Y4bGg2MktTT2NVWTFvQXlvdDM3SFE3Qm5VZGhqZEUx?=
 =?utf-8?B?MXVCbHZQMFI4RDA2NWtxNTN0REZiUHZybTVPKyttTHNwSWxRbFJ3NnpnTk9S?=
 =?utf-8?B?RU1QWThNR1o5NDdwZGFVaVowdm1pdE1tNUFLeThlWHY5UEdYUU1icHA0ME1M?=
 =?utf-8?B?bTdVY0owcTdCVlM0T0dRUm5BSmpsSUtFbktIa29HUXg4eHdpaWV2eE5ZU0k1?=
 =?utf-8?B?MG03MFpkSEp6K3ZQbnZBSEZRTWpZeGxYT3pZOXlrSVlxc2VsTGZjNXUzSWhi?=
 =?utf-8?B?b213Q0dlakE2OHp4Nk9xTnI2OEd2WHpDSVkvNnd3cGljRW5QS2tULy81aUJI?=
 =?utf-8?B?aVVIN2w4SUZGNXZVR1pTdXR2LzZvYzNqUWNwUUZ5dWM4ck9BeWRxSWs0K2VZ?=
 =?utf-8?B?eFhhMWYra0M1SlRJSCt4b1pDUCt3MkdZbFA4b21Fa2hpekZ2RGVyNTdleTJM?=
 =?utf-8?B?T0U3dkhYaUMvMnRJaFNpN2hNeWI5ckc2VElvb3JPNVpUaUFrMS84WEgvcEQr?=
 =?utf-8?B?c3lQdDAwNTB3Vk9JblUwZTlPekJRcGpCTDNtWk1LbkxLcXRLNlFFTGJFRHZ5?=
 =?utf-8?B?cklUZ3gvRDZlSlJ4emtBVjUySncrNFk0UEpJTXRMTi9tSTZPaDJpVFN2cE5w?=
 =?utf-8?B?cEh2eEZUTXBqQWIzanZhYitueWlnZlVxc2dFV291bmxSSkJyUHk3Nm5GTUla?=
 =?utf-8?B?WjdidkFYNTg5OFNUL3BCNDU0RFh3QzVVcmFESUNHM1BIVzlUN0ZhRVd4UzV3?=
 =?utf-8?B?bWVuTGNidHZaZFZreHJ6K0pLZitlK3RMaFFPZkdBY1RvU0xEM2hCZ3N6OHlJ?=
 =?utf-8?B?UU0rRk43dEZyNk9IQ2xZZDVkZU12ZnJFbkc5bFRYZ3NhdzFKMmZOb1F6M3Vs?=
 =?utf-8?B?akNaTW9ydWp6UjRRVjFiQlJCRWFCU0g3UWZvUUhRY28rTEtFQXR1Y2wwc0Rz?=
 =?utf-8?B?N0JUZGtiY1c3OFJpU2w2UC9KZEl3cjErazJrcGJBVG0vSTZRY0t1TmRBdy9Y?=
 =?utf-8?B?dnF2MGJGNWhjZFVBcUZtcCt4U1YyTUwxTVE2TENoMGFVRkg0c0tvd3A5b1NU?=
 =?utf-8?B?bkR6NEJWcTVNN3Mrc2xSdUpjNnl2ZEFxcGpPZE9kM09CTU85ZzJjOHlXQXQ2?=
 =?utf-8?B?ZDNZM0V2UmZ6cDM0ZjlxZkdBaElKTVA3ZFlDUFNUTjA5OEN5OW8vamhtZlRW?=
 =?utf-8?B?VnlVZERNNS8xYXg5V3VKeFVrdkloVlJ4U1BKNnV1WW5sN0wwbCtvQ0gzcmgr?=
 =?utf-8?B?YUtTQ3pFNGhjOTQ4Nk84eVRJWVFLU1R4ZXgzcVZHdzh1MnkzdTdoQmlYV3Ju?=
 =?utf-8?B?QTV5WkZMSnN1MU9Pd2l3bVlCUlM0aHU3WUt3YTRQNTIyQjFTWmQ0c095cC8v?=
 =?utf-8?B?dStpRm4zVUpTbTd0QmZMT2ExcnpEbHdEbk5hMzh2aFlxRzI1R2h2YUFXSkh3?=
 =?utf-8?B?eXZsVjVKc3RrT0FHQWV3NTE2VlhaT3kvdW8vTWxMTk9Qdkhqd3E1bXdXSHll?=
 =?utf-8?B?b2NRMUZEdzBkRGxBYWFOYUxOZW1JU3NvU1lJMXhOZ0FUSEZGdm9FTDJlSkQx?=
 =?utf-8?B?ZEloU0VlZU8vdXEwT2xJVjlMbkhFQzFnUWJrUkZvZnI5d0x5U1RqaGI3ZTlN?=
 =?utf-8?B?V29WbHpPUDlGcE9RQW9wVzgwdkVyNVpUL3NSR2xweWhseExTK0ZOdno2VW14?=
 =?utf-8?B?K1VHeS9nTGFrdlkwSU5oZFBWQXo4RldSTjd3ak9HNERDL1lPdlEza0MvV3BJ?=
 =?utf-8?B?OGRWRmpwQ0lYWmdvSWNiL2xBVWJzR1g5WmxkRVF0SnpDZGQzU1I3RVhldmQw?=
 =?utf-8?B?U3BjRHFtbVI3TTh2dG5BVk5sMmE0MTkvamgxejY2OHVUZlhCTmdVREJSVUI2?=
 =?utf-8?B?Y2RmWGNOOUpGS1d1aUhaamMvWjFKL2xpOXRrUEgveEhtbWg1UGl6Wll5cXNJ?=
 =?utf-8?B?aHBYZFdGRXU5QS9ER1M5d201M1NJS2JKZWZ0WDJOSVFVRVpwd1FDbjh4c29P?=
 =?utf-8?B?OVhyQzAwWEZ2VDI4eGg3eS9rWTgreUtXd1Y0ZWFVeDVpRUd4dmE2V1h3T0xk?=
 =?utf-8?Q?OwrLq3j6ooWe8OIvOvvDdDY7c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520170b1-647c-4862-2abd-08dac0ec6ec4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:18:13.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blmvPNbYFObLVrQLLJiglwq1cjT1fu/Y+JZCfT3yYW/uW6lX5vuabOBcKfSyfYaRv1zkfDjZBbawlM549r+zCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 11:57, Perry Yuan wrote:
> add suspend and resume support for the AMD processors by amd_pstate_epp
> driver instance.
> 
> When the CPPC is suspended, EPP driver will set EPP profile to 'power'
> profile and set max/min perf to lowest perf value.
> When resume happens, it will restore the MSR registers with
> previous cached value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6ce9fca0a128..841b1e2383b8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1282,6 +1282,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>   	return amd_pstate_cpu_offline(policy);
>   }
>   
> +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +	int ret;
> +
> +	/* avoid suspending when EPP is not enabled */
> +	if (!cppc_active)
> +		return 0;
> +
> +	/* set this flag to avoid setting core offline*/
> +	cpudata->suspended = true;
> +
> +	/* disable CPPC in lowlevel firmware */
> +	ret = amd_pstate_enable(false);
> +	if (ret)
> +		pr_err("failed to suspend, return %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +
> +	if (cpudata->suspended) {
> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		/* enable amd pstate from suspend state*/
> +		amd_pstate_epp_reenable(cpudata);
> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +
> +		cpudata->suspended = false;
> +	}
> +
> +	return 0;
> +}
> +
>   static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
>   					   struct cpufreq_policy_data *policy)
>   {
> @@ -1318,6 +1356,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.update_limits	= amd_pstate_epp_update_limits,
>   	.offline	= amd_pstate_epp_cpu_offline,
>   	.online		= amd_pstate_epp_cpu_online,
> +	.suspend	= amd_pstate_epp_suspend,
> +	.resume		= amd_pstate_epp_resume,
>   	.name		= "amd_pstate_epp",
>   	.attr		= amd_pstate_epp_attr,
>   };

