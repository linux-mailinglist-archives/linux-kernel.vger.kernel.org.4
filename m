Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9089068F0D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjBHO2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBHO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:28:45 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F377D5BA5;
        Wed,  8 Feb 2023 06:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOQhXoKfVMm4CP3HW9cmBOBxZKpD0+FVYwoJ9D2kSpDZaiL+tViijYKsx/3Dq+jm/MhaIvg51vSc++NTTaniWYNlZNhZrud7qT1LbDvaLPRgHLMWGRtWbpv+DXHuxSaXbwfeNfxu8i5fzOK0XTg8d4AyFeGTbz6BQEOb6URtn2tguAeBZWIrLLAyHsrQd1St3B3MAnvwLoAbmpSgOjp5zQIgzZSDk6hCNq/eos0K+j/9RBKhr7rWBjqNCdWvL6SteybbZ2nn+rcLimeXKI4dPOdJ8ia7q98PmY4i4K8JdXdmHvqm+0zWmrguPhOTalwPohLIO57uP4eawGD3r/dJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq5ARUZp61NJSEF0E2Mnpyw/Y43pKfbbTzuZxslXqqY=;
 b=k8GiaW1/CJcKeAy4HyWJN2Wtdks/fv+79LuYpsYuSp5rnyR4VG+/GsXh7WqO/F+tA3hcJUZqesUsjfSi2HnWR215WxR8aR6Keib7Wzs3ubn4atJFZYJfdk9GN0R9jeBRyI7CE+1vLGhJfFEDTj8C0mWmkBiTDw40WZKpCoVllUwMWHB7f6+6seBXZwrylCGb7LkaIyVRFieKa0j1rKZ98Gl3Zf9KpLFUflJNrC/VA0EeGSoJmZA+z/ch/K4U4dkmm10LA2wy6xGnnRkf6ft0E/xabDRbapCK7MyN7LBhFekMfG4kFjqFa3/HuqXI1amgY2PHMYnujcPmFHlgvnvTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq5ARUZp61NJSEF0E2Mnpyw/Y43pKfbbTzuZxslXqqY=;
 b=TKBenpZDk+VsKRQwbiOgjs3s1/uDfnbl81I4isL2SfCg8d3N2S2Yb3Web6Zk8ZA3TYA8ZZJ2p5j8ocwfEZZRwwDLMACZFGJeGpioTTeiqZqC5JHhZXPnfdneJbz7Qkl0efW3ZzIljme1x0x8sCZf2eICZ5pZkne2UonFRdGSob4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 14:28:37 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 14:28:37 +0000
Date:   Wed, 8 Feb 2023 14:28:24 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Jinzhou Su <Jinzhou.Su@amd.com>,
        Meng Li <li.meng@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: amd-pstate: avoid uninitialized variable use
Message-ID: <Y+OxiFNRsL39t3tW@beas>
References: <20230207161256.271613-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207161256.271613-1-arnd@kernel.org>
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bfb395-431c-49da-8ff4-08db09e0c405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6rvb76ycSlTOCLRwAgU8IflH2tdGBhKivuv7zzpsNk6iHB3wsseyWFXorASFyB3OnlVD5/xGgSd9sleXnsVFZZtE14485TcQDARSrcjyNzD2M+avG3oCWLlO62fsnZfulGeBog4OcX9BPkwKs1BaEbgZtkXYY8E17DQIC6fjgyJzlrVilbN4u3ET5w4lqFTvEyeH06dgGZ5/XAsOr+V/Mh3C7Odp9tU+fhfPJtDtBIJ97XfK6hc8PsJpsZ6W3nXy9zOSbgrQa5prjulhD1/v0UvQ/yUANes5frRyTal1Ffupp6gpj0X8es/XmI+fgB6FnVYoccyYX9Nz9zdsfFMkEo6HiMu743U/1zbEMCG/2/9QiGI2yFjbLkfr49Mpf/Xbd9gQ3kFkwGT3VDc5JuHPtTxzmeTKtgRwuGNs0Bfk3QjK+XJ5yV0rIbgpDDcLQmv/Z2BDqfyeU+4YsOcOUXg6R8bsPlOuVxL2xJ/V8klWugJ2IInE2Cjr9hkePR9pItSdu2RVJ++DXVL8KM43AQd3j0UHvVixG49C3QL+6vN3pptgjmrPsDiBREa+5Rqhe0oPDl5fXM2uzYCtw0WI16xT1HSjgFT/RZgZB4u7XWk3rOWJEZIE9US4PABWH5rN32TFFINwhATHEcDjTYihdgmFZbLj+Xxm20b1wIwtrt/lZStC3pdR6t0XPX/CMvhfbZB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(44832011)(6512007)(26005)(9686003)(186003)(6506007)(2906002)(6666004)(5660300002)(478600001)(6486002)(41300700001)(8936002)(8676002)(66946007)(4326008)(66476007)(6916009)(83380400001)(66556008)(33716001)(86362001)(54906003)(38100700002)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dt2f+XH8KA1hwr1uEsvYLesl7oGa0Yywh6tGGsJcXpaMe5dsWu6TAZobdKNq?=
 =?us-ascii?Q?Ob99GLv7M2IwbLrxQuB4MHmDyD1eQRynpkKarE7Hkn724DJE3aFGMrHHJeTA?=
 =?us-ascii?Q?hrG7bj4RCClPgLu4qCHWgOHelkThv8IuwiSA+FDw4onwAyXTcu6uclURFty9?=
 =?us-ascii?Q?ri9GO9MysrsnUZoBVGU0lDWuSo0HW6I9GVmUBc/wTFCZb93Vne1i0ZM6Ey9p?=
 =?us-ascii?Q?aVRxg+n8XhzuX9p51g51Vfr98+GiPOyo7QeA8FxqXMFxkMLDcsmv4gVK5Rax?=
 =?us-ascii?Q?b271ZTu7OnrfjCpRVqPlSNOOub/MYmazJQXXTmIGxq1q0W4e+dhE4woyJbbL?=
 =?us-ascii?Q?nEDZ1NMIreHgrtm1raei7o2f5W+3bSFTUcEj/CJdo+GaLVpxuvXh1/Ezh22f?=
 =?us-ascii?Q?8k6MGlJ8mSoQLGx6enSfUGjiL38FpVO1ITM0GMBrL65k90CWKrwc6fV6uUWN?=
 =?us-ascii?Q?rzm/WW/+oZHDnE9ju6OZKvJSdWj59sz3H6mLZeZ9H4AXrgSXlT/vEVx/5Xu9?=
 =?us-ascii?Q?1V6aQ+YccOZF74zemu9WTLng2dP97NygYdHjWobDzNsq9BaZ28waS0FnT15l?=
 =?us-ascii?Q?2Iu6+pSo8VEOeq+sheQq0H/dER8imbb8X5hbyuTJlRw041jTOAS8St8Vr2Dl?=
 =?us-ascii?Q?AQH+5iJKbePEc2tztn3hc6TXJaSdrBt2eLQXZKUqAHUD6dFtkF7wK0b3vPA5?=
 =?us-ascii?Q?rRCmbmF07aj7gFm6sMRFFENWaetK4pqbOCskIYfk9TtBk1requmNk3M9f1eG?=
 =?us-ascii?Q?KuIumQZdavsPYmdofUNQ+2qqESrwuH7++Tum76UpRmld2FYBPvI3CHHb9+w3?=
 =?us-ascii?Q?SqjWOuH7RLnWoVbYCVt9zlwEsrGOdjC0pIc28Ep9gYcIWcpxHU8zAYT9Hkmt?=
 =?us-ascii?Q?DZpCr+nX+H167A4BxgI4mv1axMVq8R5Jw+hL/iJ4gfzD/uhM3bnJyO1+LpKO?=
 =?us-ascii?Q?98zZee9+eyYxDM8XHvaxKjCDMSnR4mb7iU9NTjbyIy5t1RY91ghLSQcb2MFw?=
 =?us-ascii?Q?tnaH3C8D+vzUTPRvNCSpmK+2dO1qBILXi4SH6I1iBXO+duJQ68OK3YgFwXzr?=
 =?us-ascii?Q?Hejqyr9FQKvc1xWdi/mS96QQp98ZgDo15215e/bpEuiru+Idh0+0NRCPr04s?=
 =?us-ascii?Q?Jqp7QLS5Xcdypr3pEG2yZbBHp9wwmXCdotX8XAxWWSUhJeGHeq9rHpV5LbJI?=
 =?us-ascii?Q?QTBrEnd7HiNGnYdsHBZ9wXja6Hhg+Ym6tzGsHAKzayeKY9eHyKB5kaXFPcoZ?=
 =?us-ascii?Q?KvB0CNWQn6nthokW6NyRQ8N2niiUsJIfLqYtRB4J3LBx/xQgDYALWNVwsUDR?=
 =?us-ascii?Q?avp+z0YnJdH4k47BBgMJxWEAaBSdV80ENLkJI8oSTNUh6PP8mMH8Tm9HhbWl?=
 =?us-ascii?Q?kS4/pLbHviA6NzWYdCp2TX4HPO0tSUFmdwBdUGM4/Wlx6JNcig9N8LX4C4wJ?=
 =?us-ascii?Q?Itq37xEITKbLOq+oWc0AoxDMp1Ys6b/1TyCFhCvp2bNHBppuaxx/1rSNzFgY?=
 =?us-ascii?Q?zmuQOuLkNPXd/FXRyj4e0cSvpFthgdldxZz/zZqxBkIPsyeO40Wd0DG74iKP?=
 =?us-ascii?Q?HQQaIgMw9RmbnmAhG+wNuk5HkEveisfZ0/2Zm9lV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bfb395-431c-49da-8ff4-08db09e0c405
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 14:28:37.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjdGJ1fxCuUCulATJQpr0XmlLBrh+e/Q61Q2JcUNSkqZ4qh618u0kXMocuRleM1NieWf5C2HnaTaL7QIC6In5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Feb 17:12, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new epp support causes warnings about three separate
> but related bugs:
> 
> 1) failing before allocation should just return an error:
> 
> drivers/cpufreq/amd-pstate.c:951:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (!dev)
>             ^~~~
> drivers/cpufreq/amd-pstate.c:1018:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> 
> 2) wrong variable to store return code:
> 
> drivers/cpufreq/amd-pstate.c:963:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (rc)
>             ^~
> drivers/cpufreq/amd-pstate.c:1019:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> drivers/cpufreq/amd-pstate.c:963:2: note: remove the 'if' if its condition is always false
>         if (rc)
>         ^~~~~~~
> 
> 3) calling amd_pstate_set_epp() in cleanup path after determining
> that it should not be called:
> 
> drivers/cpufreq/amd-pstate.c:1055:6: error: variable 'epp' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (cpudata->epp_policy == cpudata->policy)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/cpufreq/amd-pstate.c:1080:30: note: uninitialized use occurs here
>         amd_pstate_set_epp(cpudata, epp);
>                                     ^~~
> 
> All three are trivial to fix, but most likely there are additional bugs
> in this function when the error handling was not really tested.
> 
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/amd-pstate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 168a28bed6ee..847f5f31396d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -940,7 +940,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
>  	struct amd_cpudata *cpudata;
>  	struct device *dev;
> -	int rc;
>  	u64 value;
>  
>  	/*
> @@ -950,7 +949,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	amd_perf_ctl_reset(policy->cpu);
>  	dev = get_cpu_device(policy->cpu);
>  	if (!dev)
> -		goto free_cpudata1;
> +		return -ENODEV;
>  
>  	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
>  	if (!cpudata)
> @@ -959,8 +958,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	cpudata->cpu = policy->cpu;
>  	cpudata->epp_policy = 0;
>  
> -	rc = amd_pstate_init_perf(cpudata);
> -	if (rc)
> +	ret = amd_pstate_init_perf(cpudata);
> +	if (ret)
>  		goto free_cpudata1;
>  
>  	min_freq = amd_get_min_freq(cpudata);
> @@ -1076,9 +1075,9 @@ static void amd_pstate_epp_init(unsigned int cpu)
>  		value |= (u64)epp << 24;
>  	}
>  
> +	amd_pstate_set_epp(cpudata, epp);
>  skip_epp:
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	amd_pstate_set_epp(cpudata, epp);
>  	cpufreq_cpu_put(policy);
>  }
> 

Tested this on AMD Milan (Zen 3) system.

Tested-by: Wyes Karny <wyes.karny@amd.com>

> -- 
> 2.39.1
> 
