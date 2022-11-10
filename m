Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D586246B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiKJQTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKJQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:19:51 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7D1403E;
        Thu, 10 Nov 2022 08:19:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjUEKG4NrjElenrOhS5VqUuRW0WnggiPnkgjg6g7A6SeU8SwPNAr6mdrIAzSEKf9P4wXkLm2dVVJ44NqGYD8kU43ntQRUS3rw4ATiXdeGVTM3lCF5wDdxtIo//dWW0hx6m4GAhYB6v23MRJwfjucz2g1Gzf2Hc54DmMt+ApklDP1BIShijBGNBf/fRi86kaboSnCuKUm2evzc5HBbRD1i636z8owX1RSrU+gBTC6NruvmCarI2p/UY1rZ4zErRsEMFVPpBxXHif6jQiLSTrj42DceNaG5rjYpW+A8eap9MsuW4X59WbapiDQDkSKyJ+Wh5rFhGzEbX8BNKwebsA2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hp3iB17pbA7+G8+j6v1p5BvCtwUdz2KxmcBH51ukQ4=;
 b=efKfggzyC+IHPfuItD/K+dOPTuen+3H25JL8Tt/U6Z+QNPeHIUzKIeGrJiB500S6JkivH0xoRaTdsWpXjHJ/aOaVUmvLNOxapKtFAA0Oo1ivKYy8fGl0CNIjfI5l6V4dVy3UInbw141cRcw9lnXdgNVxMn4r9CofoSnwbin7kcrqSTttXiyGLKMkP61U7nDDLrk+zrzzyDVD73n+f9odZLvPKKm0oX6Jq7CG21suzDT576tngbALxT0R0hWzPLG1LbQIMQljmpwG6D2KWYK2FS5FLt29MdyJHfriuKeduMDytYBYiRFRvISFHnu1tVBJEGZawY0s8lxoCkbZ38sEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hp3iB17pbA7+G8+j6v1p5BvCtwUdz2KxmcBH51ukQ4=;
 b=LQ/LDLKHfQEUgMATZ/K0unKL2EtjY0ecQQF+w4b55Q66fJysjW/tE9jkH0m/iEXuH5YwWKra/BU2Zl40QLMw1GCsZBZmH1Dm6Z63uKKvsVzUvil5vogpKzXRvsfVY9TpWx+5HywxyM4w0uxLPonyF0IxML1mOT4evEgW6h0c+Ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 16:19:48 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::a404:1a79:53c:453d]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::a404:1a79:53c:453d%4]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 16:19:47 +0000
Message-ID: <abc1fcce-3614-1896-5465-0249fb897702@amd.com>
Date:   Thu, 10 Nov 2022 10:19:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 6/8] cpufreq: amd-pstate: implement suspend and resume
 callbacks
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-7-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nathan.fontenot@amd.com>
In-Reply-To: <20221107175705.2207842-7-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:610:b2::16) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc0bdc4-990a-4994-4066-08dac33762ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrrHY/hCGhJPZYiJt4fvJLzA9QIhU1AcIAKtuGns70osawJ4/sgs7V2fEv3Vx2LdFbhrBWILp73e5PyjBu4nY5NYOEQAw/89u6ZrzUNG87mA8zeS13Em2hQMNIN2E8Ws+sF26lDhTtixZ/UEh2exzC3AZvL+WdNO8Os5kDuwqVYqp/UGktKTPISGEyhw74/k/zXFikrzsu5pgeN899UJD2D11BbDKLeK2rdvjhPcYlWlds06A3wXgV0DsZ0RIS9ZBDpe8BEO+ZVMHS3DMpVXWdiKUp/iYzne490T+VFApwasldYkD+LnoJPoWAWg4NeQKZsxS9ebNASUqJxR8PwuVR8/FIR0wUdG5bPDLFRqnYLOlT95TxvD/f+NsNpy1LfRNzEGypWdtBHziH04H7QbsbcyA1SvesKRP9nsJSwvFUVjN+Bx8IKaH6Di+C6/qBgsVKuQPX8sZEKSQ56qNoxQLPJZQxaZnXw6wiQAq+qaitf9o2pdb+WOU7X2Ccw0LV2IGgZxwAG0mQULliuFlNbahjRKjLP2Uyj27hmS2MPh/YlxhA6UxFZzBpI/+uHaiA89wlEqOxc0A5/CeAD+xRZSZqnhxzo6rOzH6/5l89E+ZzfhzhDQnFy58KtQpwzIMrRzUiYvNtbod/4QM128fLw/gm/noJb8cW4lSw23qIZTbACUrBp+rrUrYAZX5PSiTi8rRJguqDeTXtiU7tNqYHbMA0h9SwLmi2ycS3u3IlsJsp7C59YzpofpwhiQg4wR9DRW+vEDLJKOG8QVWwu+iZbV5F4Jxp4V/8E+xqB3oPEc2BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(31686004)(83380400001)(36756003)(186003)(6506007)(6512007)(2616005)(26005)(38100700002)(6666004)(53546011)(2906002)(66946007)(15650500001)(6486002)(478600001)(44832011)(316002)(8676002)(8936002)(31696002)(66556008)(5660300002)(66476007)(4326008)(86362001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpSQllRdEVPbVAyKzhRRGplbVhhRU8yMEVxYncrSnBMOUFJMVNrZEFhY0xL?=
 =?utf-8?B?RStXZmdGMFlEZU5vYThMTFJzeUc3WE9XbjR5eDZJS2kwZDJ5UmVtUElPU01L?=
 =?utf-8?B?ZERwS211R3V5TjRvZENTSFdOTVcycm56RU96OWt1R3AzaTFVbVhyTnJLYlZu?=
 =?utf-8?B?SDkrd3lqRkJBVXhXbzdZa0pEcE5oUmo3bGlkd3d6SEhwUy90V0xGK09QbytJ?=
 =?utf-8?B?ZnNiKy9TWWwvbERpTHBWZkFJRkpQSHpvMkhEWFY4NHh5ME1iNjRlaTJMdms1?=
 =?utf-8?B?WWJONmNGUGJTTkNKcmd5bkpTbEZDQWRtejFlWWRGVWNjQWpXRGc4NGtndkQw?=
 =?utf-8?B?RmRhdWFsdCtMNUhvVWMwOEZSb1MrK0xmdlBGSEhPRVJqZ1ZtV2Z0Z29ucFlY?=
 =?utf-8?B?RUl6d3Y3YjFwQkExVFovR01HZStSMmo5ZlkzdXU4K3JPSVJ5TElINTJJMTdR?=
 =?utf-8?B?ZDQ0dHF4dDRQN3RYOWRxWWRiUTI2WnJMNVdLaHd1dU02NnVhM0lYOEk2Zk9o?=
 =?utf-8?B?ZEN0Zy9KTWRzRWN0eEhIRlNnWkdUZ0duaGdBb2xhK1dRQnVpM2FjTmZqbUM3?=
 =?utf-8?B?TGVieXR5VHluaUtoN1ZYMnFxRjVLVDBUMkpqNjlzQk1LclBDSlVQcXZIcE9z?=
 =?utf-8?B?RllpV1FZU0wzTEdXNlpsaUsxUm1scWx5Sy9VU0Q3eWVZY0ZSUkNDcVRobVV2?=
 =?utf-8?B?TXo0c0VzWVc5VExRSXpmdmVLNk94MmFERTdZRVJFZHhGZWlpb1ZlckZGYmNT?=
 =?utf-8?B?MEx0L2V6eUZiLy85RmxLZ3JVVUhBRytjcjNMaVVwdks3VUczaXhuVXk4aVds?=
 =?utf-8?B?OGtLSE1EaDE4SGFqNVA5Nmp1M1N0OSttWm5TVjFOSWNTUWxnMzNkdnJyV0NS?=
 =?utf-8?B?V1c0eVNKTXFLZmNVRXFPVHVQNmxLM0hkRlh2dGRoWW1JMzc1OHAxV2lxV1Vh?=
 =?utf-8?B?YUJnZFJRd3grL0ZXZTJ5WWlBUVFhUndVZzI5cU1mVUFBUEE5dDRyS2VVSkQ4?=
 =?utf-8?B?OXVFRGQwY0lYU0pLTzRwQkhReVR3RnlaNTlGUDJ1NGlqL3hUTVBFcTN3bURW?=
 =?utf-8?B?dWRLdW1NanFQbkdBN0xwbURBSlROM2oyVkRWOHAvU2E1bzN0WFpRMGNack1L?=
 =?utf-8?B?Nnl5ME9SYis0VnBza3lMQ3NpRmx1Q1lGM1pzcE5NYUU3OHJIV0labkxpbkZR?=
 =?utf-8?B?OHNTU2YxNTFxWnlaYTMxTGoyZXNNVlJySGN3KzkzNWhPeUJsRE90UEVNSzc2?=
 =?utf-8?B?MTlHTTVvNkJLa1psVE1nb1hlOS82Q3RabG0xd0RqdjhIQTFjaFZDdk9sUDRN?=
 =?utf-8?B?WmlpVno5SWdIQkZ3UERheFllbEE1Y0pYaG9Zbm9VTVA3cy9Lc3VKUGtabTUw?=
 =?utf-8?B?bnpLTVhkRHdpYjUvYTZPL25wMnkxcGV5US9Sd2xKcGJPWW5WUWsvalQybGti?=
 =?utf-8?B?ZnR3L0NYNmhPRmdrelFSbUJ6SkFOWnhLY3A3eFd2RnB2T2hiN2ZPY3lSdENH?=
 =?utf-8?B?K29SekRyUFA2NnRKaC8rRmdBV1hTeFdjcnlidE5keWw5bjk1M1VjTU4yMERD?=
 =?utf-8?B?MFBnckJJVVgxOXR5eTdZQzlYellNZ0dNbTZzemdLMUdRNkk3Z2JvL2xuU25r?=
 =?utf-8?B?bE9LZStCbS9aL0NaZW1ZaDh5bm90S1pjMnNHSXhRSlNFVk5sZTJuNDFoUTR6?=
 =?utf-8?B?TWxncytLM0tZSlhDRmVMT0RkYXFNTm8vKzVrS1VaQklJT2RZK0FIVUtKVXhw?=
 =?utf-8?B?L25wOS9LaFdOZFpTN2J3c1VRb1ZndTE3NXBQa1N6R1hIaWFvQWlPeURXMFRs?=
 =?utf-8?B?ZGVHQUpHNDJ1Z2p6V0VGUW03MmpNeGFBQnkzbVVXK3I0YWZuWFVrZWhSZE8r?=
 =?utf-8?B?NlQwemdMcUc0MFFKL3daQkVQdFhjeUJ4OGJpbjZycndlUlk5RjNSdFFWVmdE?=
 =?utf-8?B?U1hMMnIvc2gvNDh6NnpGTmZzbmZYbUxKWnBwZVdFSTBuejBrSEgrbkZ2WmhU?=
 =?utf-8?B?RUhXaHhHclVGUXBrM2R0NmRqeHFycjBkYkR1U1ZGNkZPVTFROUlQOXZIQVB5?=
 =?utf-8?B?ZTJ2NHJHSEJOWUVUUW1EcFIrbU40TXF5cVV5Um5lVjBzN2s4a1JFdjZGRnpF?=
 =?utf-8?Q?4r8H/zeK69EkiDLCW6Ao9QlHn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc0bdc4-990a-4994-4066-08dac33762ef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 16:19:47.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67FMbAwLMHmGXDAiwnWml9kilZ5TTgdlMeCF9ygv+ygpW/nSY/NQthDqYTxj4vvvmlFpkgMghMthELTxxC9pxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 11:57, Perry Yuan wrote:
> add suspend and resume support for the AMD processors by amd_pstate_epp
> driver instance.
> 
> When the CPPC is suspended, EPP driver will set EPP profile to 'power'
> profile and set max/min perf to lowest perf value.
> When resume happens, it will restore the MSR registers with
> previous cached value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6ce9fca0a128..841b1e2383b8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1282,6 +1282,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	return amd_pstate_cpu_offline(policy);
>  }
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

Shouldn't we set this only after the amd_pstate_enable(false) call succeeds?

> +
> +	/* disable CPPC in lowlevel firmware */
> +	ret = amd_pstate_enable(false);
> +	if (ret)
> +		pr_err("failed to suspend, return %d\n", ret);
> +
> +	return 0;

You could drop the checking of ret here and just return ret. The caller
cpufreq.c:cpufreq_suspend() already does a check of the return code and
prints an error message.

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

This call can fail, we should check the return code.

-Nathan

> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +
> +		cpudata->suspended = false;
> +	}
> +
> +	return 0;
> +}
> +
>  static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
>  					   struct cpufreq_policy_data *policy)
>  {
> @@ -1318,6 +1356,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.update_limits	= amd_pstate_epp_update_limits,
>  	.offline	= amd_pstate_epp_cpu_offline,
>  	.online		= amd_pstate_epp_cpu_online,
> +	.suspend	= amd_pstate_epp_suspend,
> +	.resume		= amd_pstate_epp_resume,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
