Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E32732857
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjFPHFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244549AbjFPHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:04:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865CD3C29;
        Fri, 16 Jun 2023 00:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xru9jpJqVgT9bSHXh7EgdbvpDbSc6luxqUloRYfW/iS4zz8DMJksYdBN9y2CQIzD7aG+hUqn1zbH9UXyhgJFcI6ui8NA+YRRxSnpjSi0iQIEAik+czB8HqKNmmw6tCzpXn8SGQI4QoXOyE6xwzllYOr124PvaivEb2KhNg1ZuAlFCQ6b6AkV62lMOW1TtY/K2elxhTW+z6q2O10qegLjRyoz1qfLdt71BPzHXwxREPjiBK7RzLGZavAc9ORG58jApemYkTNHFh7wTV2uwzVntznNkFMNZZdYlJAG+EZLtedBil5pd0tEqcjucqVgmrId77ao3ff0tk9Ah3j8k66ccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4i2TjRBgtbgiBjPhAhhea8Isqp+2niXBEMOHs3dIs8=;
 b=SmAH5Ob6d2E1UccavnK7QMZ0XZnYCOYPCDGU8YXSCEbpa4zqQ+VVhgq0x2yThqtkhFkbR7NcVzwHGUww/st9krCNQV7nwZz/ZwINC+7l2uSs3ekec4vuyLyF80R/brVcRfaBDo2HUsQsDjrDFCKJj91hdIzu9jplg9Wpq2XFlV5Ttp+h1ndpA+J+F1rXcWo9yqRNwkf6H3llHrUpgGm08H/vUD4/E/rNtEs2mvqC3feG0ccHJPiZAEJYq+3uZHIyXMmPG5ZbOBHoQjPi7YGH4+sBpzGI9d1uwEzedRs2jKgdelGPuWvz9z6ZdIWXeS2KeU1kAxWPL0lYl/yRIpH75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4i2TjRBgtbgiBjPhAhhea8Isqp+2niXBEMOHs3dIs8=;
 b=kaw/adwl2I2aamWzA0Dj4a7K7lrrNjsSP5zgyUJBg0+eSVa/L5atuytxkcm2X8FFk0hPRbF/fK0nBvQfZYWfNxt120VQiXZtFr8EM3ewtIkXpLHJpFLhczLuNtnGkUzQjlYGeZXf53wKk7Kxmc8eqmzkDWt2W24nuByA9aADXIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.27; Fri, 16 Jun 2023 07:03:34 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 07:03:34 +0000
Date:   Fri, 16 Jun 2023 15:03:09 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Write CPPC enable bit per-socket
Message-ID: <ZIwJLbNa8qRDlkNn@amd.com>
References: <20230530131348.4135-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530131348.4135-1-wyes.karny@amd.com>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8051335e-741a-4ed7-f19c-08db6e37cc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTWrvPmybBjXYuytJ0B6q8LJihQGP0CQbgqOKw97Sn4PUZl/Aj/XGR4TzwX//X00kiv/flojkdafc+tT9v/5oko4DfzCdnAYq6BbpKa6Mirb5F+ColqCIPCOR0xiCdmgHMQhw197bAnOQO+vtXP1x1ay90H/mrNbhyEE2IFGJGf8CjWK2afQDuQQipbA/jzQlF/pt9sAyo9jXk5DeUwdq9yzHROhCTiQu5mV04oBQEVqyXV/2h9dXnEh04FZJ8spGflJosDyCRYSowPfTM8hRbVBENp5dGV0AdqMxxPebyEMyeFooJj8b/efuObFTXW9rYHIZ87/GnbpYLQrlsHN2TWp+e27LmJoHO+j4WT+ExuD0/33DeYUS5gdwSSXAi03QAOMTtOhV7e5f9sM0jha3tKxMF1cLPfqJDY6hRdKKt0YMnf3DGm25fQ+/1q5XdqE5f5q4nP1zgBDd7WCjc4NQB7fzqh2JwE9llXqrq6Uy3pj7Co+0fepmAzEaLbtbBEZxydWEwedo4vNKcA3g4nopOR4ymCAn0iW6WscWZ4o6onqB0+nsqb7keWw2dkgdUcb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(5660300002)(8936002)(41300700001)(6862004)(8676002)(2906002)(66476007)(66556008)(66946007)(4326008)(316002)(6636002)(37006003)(54906003)(86362001)(38100700002)(478600001)(6486002)(6666004)(83380400001)(6512007)(26005)(186003)(36756003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iT32N3D/cJL9yS+MigARB9ojN9ft6FN5Ybl8r+wq5UO22AHZatw+v+e67hEn?=
 =?us-ascii?Q?50Nfgdtb0vfYq16HRzhSbcyhkQCBaZEGu9ZlEK7w0TuxZOdAoPGn4/LqSD7F?=
 =?us-ascii?Q?P60NmsWvaR9BfEN1ZS8QrHqPCKkrDzbeurOFXNVnJQNezxxb3x1XA34AvODH?=
 =?us-ascii?Q?nGFeYmKZBfefxc0GJcoFz/BgPU9RUGGROoDSs+QCYylGqc34is1656NqKDQm?=
 =?us-ascii?Q?RbpbUTn6Z4BIk47UCYI7wzs4dhKUERtcMTB7J65A9mi3rVmALv2lPvqUMWF0?=
 =?us-ascii?Q?NNVhHMN2DzhH0DwPk7rH5VvEM3UWycaYO+TQDO9xMidk5YnczsnEstyvczpU?=
 =?us-ascii?Q?tGPef+tl5pKjFMn4fnSsppSolC+dqh19aXhVEDt0yXxEM2xthWNH+D1P282f?=
 =?us-ascii?Q?kWciCWjgpugwm1A626szouR6k0NXpRrKo3ub4g03jT9CiF8Q9qqaSsfL5F/Q?=
 =?us-ascii?Q?zrKmc3cIZClOATi3rWU7QXPnB9byCLDvYcOc9Tdfna5CZCpAmlRGWhBHEuKP?=
 =?us-ascii?Q?9cE4RYk8SkXXdVPY8Zcln8DR4sXA+fhCA0NLqt3sJjOs0G12Se6qAE5pwTEF?=
 =?us-ascii?Q?GQun1/ezIAp7+9GYw/qjphFzUsMg2tQybjOAxqzmokQHBQLvECO/hBoUj72c?=
 =?us-ascii?Q?YVtWtqr5/DiPsmc/WnsZ57GBsPx+4y6yozW2kjWz+i7WYRbHGr7+rJldtIMc?=
 =?us-ascii?Q?cbvJZiJhPn+TpT5eZxXSQZz1Bus5fG1wUEJwle7Gh/uEro/PsbOZjnZl1KcP?=
 =?us-ascii?Q?VQ9fcxxbuwUt1bY9nRYL0PYbA6PdVspLHQYRn3LRx9So0R/CorQwOFqtdQAj?=
 =?us-ascii?Q?upgBDAMEqSO2F94LHbOAs7Ffr7cHZDXw1g8qBeTuBLVSwsPObj68SL+XrnJp?=
 =?us-ascii?Q?PkmcjGJjoMQIp8uYhSSoam7oCubaCY583I+k3uIqR3PY3IFXALSsQeFcxBhM?=
 =?us-ascii?Q?OBZBT95TKYefyPlrh+KbPw66Mdth6z5ZBgIDthHTZ2zamEfOaAx8qH9Of9Wj?=
 =?us-ascii?Q?dPEtw9E51pNBpYey+n6pJB50BUnJybaXvLLh87OpDc6UtGG+711QmUj3IvXQ?=
 =?us-ascii?Q?B404uwqDeJt5yweHX5mxQT7Bpf4y3D1N20glfw3K3+KBMxxHQZxBGN6csXSH?=
 =?us-ascii?Q?r8t13RJTdCrNLnrul1fxNGh6cUdFbjx3YlKyVFBWH3aqPmGHzgW5Zr3CBroH?=
 =?us-ascii?Q?iRHFAPNO0sWayUERpVL7xJ1XQpDrbNghpkM0PyPY+aHj37QKSw1BxPhI2Lj9?=
 =?us-ascii?Q?+hJapPEm9F8rW8isPWYBjXzQzf8RWvEE67qF0meaVZgUVI0xOVjGTeZjzTs+?=
 =?us-ascii?Q?/DVo+ulgFSWhiE+T++FijOPx7LvZI5RhU/wAndoi/ayZTxpLZ0/rmEb8q5BB?=
 =?us-ascii?Q?4l1a+yUszPn41H9hkW9HKE65Dyrsq34Yu+W51g5SS8Kg00R8Usx50vgaash9?=
 =?us-ascii?Q?+DDUwrN9EqTJPF+jpH6gUPuD05GLS41Wm/2jx8Xdz9v2mgI3Mw4rN/ADhRTk?=
 =?us-ascii?Q?OX4koS6yhOR2UAR8NPE+KH+eoj7+R64tUvxwLQYwJjaDruK6P940qaWGsvvP?=
 =?us-ascii?Q?KqhMfGFB9vr9Xzocc8WYlTTpwrulEVMYbWmATgOS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8051335e-741a-4ed7-f19c-08db6e37cc97
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:03:33.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4qApQCgY6XFqTuP3+dkIHdsZVPzyr1s2pLEvnW+j9G9fNZdCX2Xc2ohLXTWPsz/ZPnS9RIjlPxRSid2gvwxQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 09:13:48PM +0800, Karny, Wyes wrote:
> Currently amd_pstate sets CPPC enable bit in MSR_AMD_CPPC_ENABLE only
> for the CPU where the module_init happened. But MSR_AMD_CPPC_ENABLE is
> per-socket. This causes CPPC enable bit to set for only one socket for
> servers with more than one physical packages. To fix this write
> MSR_AMD_CPPC_ENABLE per-socket.
> 
> Also, handle duplicate calls for cppc_enable, because it's called from
> per-policy/per-core callbacks and can result in duplicate MSR writes.
> 
> Before the fix:
> amd@amd:~$ sudo rdmsr -a 0xc00102b1 | uniq --count
> 	192 0
>     192 1
> 
> After the fix:
> amd@amd:~$ sudo rdmsr -a 0xc00102b1 | uniq --count
>     384 1
> 
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
> v1 -> v2:
> - Made CPPC enable read/write per-socket
> 
>  drivers/cpufreq/amd-pstate.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5a3d4aa0f45a..45b9e359f638 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,6 +63,7 @@ static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_DISABLE;
> +static bool cppc_enabled;
>  
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -228,7 +229,28 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
>  
>  static inline int pstate_enable(bool enable)
>  {
> -	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> +	int ret, cpu;
> +	unsigned long logical_proc_id_mask = 0;
> +
> +	if (enable == cppc_enabled)
> +		return 0;
> +
> +	for_each_present_cpu(cpu) {
> +		unsigned long logical_id = topology_logical_die_id(cpu);
> +
> +		if (test_bit(logical_id, &logical_proc_id_mask))
> +			continue;
> +
> +		set_bit(logical_id, &logical_proc_id_mask);
> +
> +		ret = wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE,
> +				enable);

Thanks Wyes, that makes a lot more sense to me. The MSR is per package on
design. We should only write once per package.

Patch is

Acked-by: Huang Rui <ray.huang@amd.com>

> +		if (ret)
> +			return ret;
> +	}
> +
> +	cppc_enabled = enable;
> +	return 0;
>  }
>  
>  static int cppc_enable(bool enable)
> @@ -236,6 +258,9 @@ static int cppc_enable(bool enable)
>  	int cpu, ret = 0;
>  	struct cppc_perf_ctrls perf_ctrls;
>  
> +	if (enable == cppc_enabled)
> +		return 0;
> +
>  	for_each_present_cpu(cpu) {
>  		ret = cppc_set_enable(cpu, enable);
>  		if (ret)
> @@ -251,6 +276,7 @@ static int cppc_enable(bool enable)
>  		}
>  	}
>  
> +	cppc_enabled = enable;
>  	return ret;
>  }
>  
> -- 
> 2.34.1
> 
