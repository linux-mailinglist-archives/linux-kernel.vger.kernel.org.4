Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48766D4019
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjDCJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDCJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:19:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4935599
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680513550; x=1712049550;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3XOyVUncHM/s9qgtSmxhzyImH0OgqbT73vd+PM0XeQI=;
  b=Aek0DQ6VYaKoymL9nILATFJVB2lJ6EUEsjwIO5nQc/ksZ+aZnavOh/fB
   sFX6UFD5vEmaATNsfkTrS/3Y39XIHiSOVy/okxUNRHSWC1u3CY4Fc3/j4
   skBOksFh93s/2rToDq/2iGF57Vs7gTXJvAiTsmBP//D/mmW90VgOGyeTD
   4kbZVL0g76WjnUJJP2qohvc5DnfXl6Und7muizxqhKl76GIPZCCCrSLYy
   E0lKCa0P4j8x9pMAD7yIomudgu0HAjFsUz1z9YTWaND4t7GNU7duD7GRY
   8mEIJdzr/GROCfUGbvNi4tdHcB3vtOX3AoRmgl5o9LPPb7pVVrQVVHsPI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="341876422"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="341876422"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 02:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="1015635831"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="1015635831"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2023 02:18:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 02:18:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 02:18:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 02:18:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 02:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLEhtr3w6Y4oYumH68nn7NnrvF5dPEMkxDDuKrf0Y3MaX9RAz+r1FW4g0Ioueb1KJuAHsmsFg08T4vu1Mgtrc1QQnKkK9cqc8jgg7z4GsvmOqUfMgGh4MlNhAEzD2d0oW8qdOkSjAbPYGFBdlDnivEKZShOOq0XXUFfuKLZHnrSx7iqzxFpOW4E2xZyZnf5p5TMxIJ+//MIR8b5ubGCf6stUXgheadtVgryqr9MXeR9ifB39gH8Czz93ou12LnG1HSnPfqB/yP014ovk3lARNTi14FyCW1WV4N6duFyUKebPc4x1ceOyPI2rH+AiSjFqEvaPSJQq3eK7nVr7kipRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65nRjOdOSYWedWLUyDfoD87ImROB7mp7reloGi4zcoA=;
 b=JBTRgjK0rL+Sj7+ebhxA97lUtTNCxxC7t4NkzkJCi+gM6fMw1Pz7JDL9qcojJOS8GkxzfH7wb0PNBC9vGox2a+8l+s8AscN4WXGdaprkY5J18QJJgXgzvb4wBMXOWFYZ+1s4l186SHGPAOXGy+x/439021PZ6j29fJhX/LHn18fA4rMiFXeVFlS4Dr76xQ+fg/dPxmBkAwgIyZhgNXrryszsusUfzOGXfCW0I1HOI5M/g/5E1DM9UH724w0ntOgbqSSxzXrA1e4BoCtUDektnlj1HlKsnoUYJk48jEvDxBJV3ulgbdG6+06Lql3Z40r6GHHNqDfR1Zbrn1P/YbGykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.30; Mon, 3 Apr 2023 09:18:30 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 09:18:29 +0000
Date:   Mon, 3 Apr 2023 17:18:06 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@kernel.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <corbet@lwn.net>, <qyousef@layalina.io>, <chris.hyser@oracle.com>,
        <patrick.bellasi@matbug.net>, <pjt@google.com>, <pavel@ucw.cz>,
        <qperret@google.com>, <tim.c.chen@linux.intel.com>,
        <joshdon@google.com>, <timj@gnu.org>, <kprateek.nayak@amd.com>,
        <youssefesmat@chromium.org>, <joel@joelfernandes.org>,
        <efault@gmx.de>
Subject: Re: [PATCH 06/17] sched/fair: Add lag based placement
Message-ID: <ZCqZzp98q806qfip@chenyu5-mobl1>
References: <20230328092622.062917921@infradead.org>
 <20230328110353.988000317@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230328110353.988000317@infradead.org>
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM8PR11MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d88aa0-913c-4c9f-3922-08db34246378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6XEWDmSddjUU8Flp6E51zzJcUrhpiBzaYYizIwtKZ9piy2fniMFLapIAfWAe8ZeyNKgSXW99YKIkK4i7xtEcQKkp3FPuEIaH0W63iA7ia1KYAOgj9QPLJ+Kgmsj5tF2+AEn0Rtw4GJ+65brAT2t9QTFeMHICket8OkeeDOIvfGg+bUjtCUrR2MSkSGM2Bgy5Ucf7yKf7e5ynt5KwIAFqKzS1Zu90Af7ozc66tIZqViEZMOngJjXQj2/z6JPw6ixGb/gfUYOigxtISnP4NwtPEkGF3mvwPiqmI3NNF1yPkYpfxAM747YEkJpL2obWASW4bIMN+cKetg9Ni5mE38fXprfpn7P4s7D+MQh2sdKioDpgZ6JCS6xarpu3KdGK1SAqgcXpZ/vhbEp1LFyHyhNiLGH73V2VzlZxHWisYH62OowvTvwn6iYR4JExZgqm8hqMkiYXHlQuQ5isGb5pVR3cST7P2YUzCQLuIS0P8ZLT77wLR9R6u5yPeizJJs5UVIZ4yQXkPDPKyvhlxnNXm1nW1tWdY8UKfMa8XCyJbGYje0XR2fSHaMJCRLoE5wTH7tv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(86362001)(33716001)(2906002)(53546011)(186003)(6512007)(6506007)(26005)(6486002)(6666004)(9686003)(6916009)(4326008)(8676002)(478600001)(66556008)(66946007)(66476007)(41300700001)(82960400001)(7416002)(38100700002)(5660300002)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MT+Uy4mpjaO1Aqsl8YBSFqzfRUriu1G6QwwZtiwdjr6vCHJ+5fF9ocp3RzbU?=
 =?us-ascii?Q?XMpTDqMXCOG8EqT64xIPuAAvD9VF0XeFffquN1pMD15QuogBnPsA2RWFMEC8?=
 =?us-ascii?Q?bb5cDD3XoZXDNV7SaldiqLlWgDahPqXNipsxtfQBOtAcGSfCbWjYC+0WQp8L?=
 =?us-ascii?Q?T9gIKbwlwUld7ybE7m1vUnmI4TAKV6G6NFe0OLAArCNFqvAFQCgCt6/QOcXc?=
 =?us-ascii?Q?Emwp/NPGVqNyaZsnbgsze+iuQm7M4aOsJvjiHS7OHLsvFKKHGbglVa9u3CL3?=
 =?us-ascii?Q?6FYWVdX14pR0PHn4c5pl5psBagojrt83iIEHNqZchOw9MSQUe0XsrO37zx+u?=
 =?us-ascii?Q?NeAftVFrgZuDOGn9b44HhpewB6I+1hMBGBHzKqatM62iOcxT+qrhwufXvQjA?=
 =?us-ascii?Q?g55BvP7NNuFim7COrjN0Bz6HnbVetfxqXReg7Nex1S9ynt+8uQFS3kvqm1cN?=
 =?us-ascii?Q?XA9PQQX48jzq7lZk5JcghglbP7tr+lwSXWLYJ7ApVOn0vj97ke6LoknenXF4?=
 =?us-ascii?Q?RQYfo9p+ovSTBv/8qH5Py52eLSxT3S6l+8/eSywiEseGg8QX/pf66oU9Qyqb?=
 =?us-ascii?Q?YLRCEqwDO+z1yRbtweTnEwLS6+yhzb3Z2Fq3youZ73TiuaXgATmuQ1f9XuRs?=
 =?us-ascii?Q?qoBsVO6qPKj8U5m6hgJguIX5Z47Rl9+L6aKSebwmgUBOSjuH8TxQMOPLgYqt?=
 =?us-ascii?Q?9e4ui2WK6JdOktVCrNPzKA/AMMRHJ6TfDIPUoil4ii/MuS0vdU2eEMyvyWKo?=
 =?us-ascii?Q?2qyDitN7/Gk4BfR0xy6YWfmswE/S2ZvoH22rh6QWubt2BH9zwpX1KsHWKb26?=
 =?us-ascii?Q?mBGUERsRNOUQoL/v2yKspZUsdoOAbnQ0rYW8hGebEzqK5l3ri8IAuyb3f5rO?=
 =?us-ascii?Q?atZ/V0w7AYrhKR9oCTiUm1VpJEfgw+jNHJBOxReSnNHH0E0OH2xy0gB35JOF?=
 =?us-ascii?Q?dlvlIIW7FCJCp1scd1d6RTd/gWtVOqR3D8AZFwDEWDmLMbA1vGr4W9kR8dHl?=
 =?us-ascii?Q?TCrWlCfaFo14A5UoXQKOpdXv3YERpQERWN1bUim8gVmOX6CytNhGczJywTL1?=
 =?us-ascii?Q?hE8/ezOhSN4cszwtOpkbryzAzykbkgZPIna7AbzzTBmAvM3effSg0+uJDIUl?=
 =?us-ascii?Q?uQvqmydEUkq30coqqpExbadXd1wCxQMFzGALRR5bOJ/x1TBmTQaf4kGFDwLf?=
 =?us-ascii?Q?oo8FNbN2J5fy7h8jzV0+pimZD3qX+WtPyWuEZLvULt/5Kw+Lc9G8rD2M40S/?=
 =?us-ascii?Q?CCpmBIQRfIQKuHfxTuIH6saNhqThwvoWIiNgFWmFqSj+C63gneY7yI8cbA97?=
 =?us-ascii?Q?mq4PrRPjFuKjNrRIUbj4UgSxouPJ3zvhW2k0ANkG/c+Iawd4+Kya1em9X5fY?=
 =?us-ascii?Q?som8Xl5dHF1xRLftIklEQF7XqMlpaqMfnwCnsgXCqylru/gAcwuYdGxPocx2?=
 =?us-ascii?Q?ADqXF8DAnUVhPhmxf5C47CrAdQvP8JihyQtzP5sQMC5zONPCfBTxSTlgC8yw?=
 =?us-ascii?Q?v1pN4sAXFmZiwrh5RYGiWe69ppSLhy13SW6WhYV98bkWY7PGERGaPZAU83R8?=
 =?us-ascii?Q?TCbVu05S00qKaJfWh49rWedn6q0FEZuHPxxzffCt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d88aa0-913c-4c9f-3922-08db34246378
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:18:29.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7w8VuwLXK6n2eg2PIcjgoqCmGbdaTIiuzL0Y2sQfYxXwunSMJPQ46pDr7Cq22FfGNUsXewJ9cmH1BhItNhv3pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-28 at 11:26:28 +0200, Peter Zijlstra wrote:
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
[...]
>  		/*
> -		 * Halve their sleep time's effect, to allow
> -		 * for a gentler effect of sleepers:
> +		 * If we want to place a task and preserve lag, we have to
> +		 * consider the effect of the new entity on the weighted
> +		 * average and compensate for this, otherwise lag can quickly
> +		 * evaporate:
> +		 *
> +		 * l_i = V - v_i <=> v_i = V - l_i
> +		 *
> +		 * V = v_avg = W*v_avg / W
> +		 *
> +		 * V' = (W*v_avg + w_i*v_i) / (W + w_i)
If I understand correctly, V' means the avg_runtime if se_i is enqueued?
Then,

V  = (\Sum w_j*v_j) / W

V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)

Not sure how W*v_avg equals to Sum w_j*v_j ?

> +		 *    = (W*v_avg + w_i(v_avg - l_i)) / (W + w_i)
> +		 *    = v_avg + w_i*l_i/(W + w_i)
v_avg - w_i*l_i/(W + w_i) ?
> +		 *
> +		 * l_i' = V' - v_i = v_avg + w_i*l_i/(W + w_i) - (v_avg - l)
> +		 *      = l_i - w_i*l_i/(W + w_i)
> +		 *
> +		 * l_i = (W + w_i) * l_i' / W
>  		 */
[...]
> -		if (sched_feat(GENTLE_FAIR_SLEEPERS))
> -			thresh >>= 1;
> +		load = cfs_rq->avg_load;
> +		if (curr && curr->on_rq)
> +			load += curr->load.weight;
> +
> +		lag *= load + se->load.weight;
> +		if (WARN_ON_ONCE(!load))
> +			load = 1;
> +		lag = div_s64(lag, load);
>  
Should we calculate
l_i' = l_i * w / (W + w_i) instead of calculating l_i above? I thought we want to adjust
the lag(before enqueue) based on the new weight(after enqueued)


[I will start to run some benchmarks today.]

thanks,
Chenyu
