Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B16A5ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjB1O1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjB1O1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:27:35 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924330B31;
        Tue, 28 Feb 2023 06:27:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZFBFdk2TimdtVWd+NUjxb+rol2Yf/fmSbIPy5o94Q5f2TpZaIHa8iRhIgkOt+VfdLoKgFQDGnwjT4pxAH25parjTK/hOQ2PJBIv7C0t2P8m1XK2D8ZPfDwIlF2qWJKzAklFJxyMFy5X8vQcXGUs0Ot8Qy/FwtNcDVcC4B4ggjKBZY5Kvlc6DP72jXITI/j7xo8fgdFW1PIMvknXBpIyZCXO/tRSJYpDKMVQEzi89QWDgbtepKRcuPiE1mBwq9qaV43fTnP3DyOG6LjIIWWSHbsO4KSjy8jcUguY9y8SWPnbFeFN9XuPXrvCvXNuefdpiVFcYMXhRb4r2VjuFf6oDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnZjSamqHAiO5Gx36Ojnued+2QUkgv7SDEM0QbBMMHk=;
 b=KaYANnUsEYVkqkFv8Y7V/o4YfnxO0YdGtfFnpJ/MCYJ4OX9DQsK5glUbQ8mKbTz5b0LtV0Ugt9ytb9FrrO124Rj6N3/fY9D2jSaCf7YwCug47a5oLUgvJjjlNv47/a6j4r9Ydfjl+fVBUJucO0tCCqMX2JE+0rYXtKEgukUXlZqf8D3p3IhmShdQec7CqYfOSlCky/V3yJ1RyPaBhUBJrazK3kJFkl1u+AvgiS0dPMho+Cosaj5Kim6n/H/o/x8Edh/MstiP0GRZEGdwcF0clloGvlHvhz1lNalJnpKM+qiyRBzta4T3/QZJeSxWbDkv228TKaJFb+veYKJL5DNo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnZjSamqHAiO5Gx36Ojnued+2QUkgv7SDEM0QbBMMHk=;
 b=lXW/edZlqq2slhFPDX5to6YiSuooVy/3km2Un9SNR5I3Zlg42rIv3JZS3MsUvBSUlTlvTYu+yglQ0wc4J3nYh4dBv2Ez+lDjINmM8Wj2LcAeGdaBDaGUZ0rIWxRLnKbjZDy8S67yO+zId7V2yzUGirgqU28PMZjJguERelP+juE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 14:27:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 14:27:30 +0000
Message-ID: <82013563-f652-2dc3-c90e-89b19fea6b1d@amd.com>
Date:   Tue, 28 Feb 2023 08:27:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-4-tony.luck@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20230126184157.27626-4-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:610:b1::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: b096dc56-8241-4875-ead5-08db1997ecc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0U3FTibRH87oBLhbKt/gXa5jTBmBM6o/1sartbztP1NiCJD9t69jpB5tm7sM/+zhS83FHiP8k7l89ZZvrJVrbZrBJMYyujXsy3kwVEDGf9G1+PIJA5Z+In+aZCYhcJ++3E4A+drYSs/TU9rNXDwHSUF3tSxYkcyBuamatiwG5CK29IQb9bKJ34B/YHfehwlNOQ3c5lq0xptguMp1aosodkhYdvjUnnf5GP6pcER5IWHzFk11LzSvuJRAEhox3K6kcjndZAaW7Zx+zn5IT4AVih92d3fHS7CdG1CVudgeEEEIYmQlWTL7FPnYQynRQyfk0OquHQbHOEauJVGKcojMby5ZHa1YE1fjrhSe6rv4I4K8xg1TtFT8hqx6pUWMZVfFlh+z3sCm4g724xOt+D9XnPRZ2nBnJZSJlSDluL/OiqyWsX8hECNRFHp6+EMCp6Lti8rkk6wanuphkAkaOeNzAsIvFrbArHlNzeku85FfmSqiNgidSWoreKNAWOZ88++jyol2uBhQS7ZNw8cf0MyZ4y91quboL0BGtziWjq5a0DVhGXHRLaExpHA9zat0e4isQ79znBCnmfnc3lS2rCsOhxz9Qlec45HYazRfeS04pVuXcQn+ccBZt9PeqUc2hNPnxf9Rwk0nUWhwl/2Jq2X/atpr73y8RCknFHPQbC4QE1Bc/saCJ3UrYV7bZC+UVfVFn09QywE/HAvHlrYNGDJnGbZ/1oSbMbUB7odEsP5FIxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199018)(36756003)(54906003)(316002)(110136005)(83380400001)(6486002)(6666004)(478600001)(53546011)(2616005)(6512007)(6506007)(186003)(26005)(2906002)(8936002)(41300700001)(66556008)(31696002)(5660300002)(7416002)(66946007)(66476007)(8676002)(38100700002)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG9uc3YyYXZSRXJua2Z4b1paMHRPeDdVMmhkRCt4aEhHMnlQV0NFYm0vNHRM?=
 =?utf-8?B?VVJDbEg1TU80Y0JMM2YxUXNzWGxQSEo2ZmZtTnU2Snl0NnNsWXQ4T2VhcTAr?=
 =?utf-8?B?R0FPdUhxR3JneGw5UXVxZHV5dmRrV0w4aThES3A0bEZKQllPL0Z2OGcwY012?=
 =?utf-8?B?SEdEWjJvUTRBUmRQRERPcklUL2NZcHpJbzR4cmgvUzhUTFRYd1dubVo4OGg2?=
 =?utf-8?B?R1kveGRxS0JrTGZ6Z3NPVFZtTGFQYXhVc3NLR3k3Q2xqaFFhM2JqanZoYlJL?=
 =?utf-8?B?ZFo2cEZFRlBMdjhhMVJndjY3TC84ODZkK2JCQ2I1dHRENmRGSXd2MnJCUzNy?=
 =?utf-8?B?aWJKa2wvaXNLZ2liekJDVWN2M1NveDdzWEs2alNRVHkyT0tlSWZPY1Rudnc5?=
 =?utf-8?B?c0xuZThha2E3U0ludkpiSU5hSHZKbnA5TUdQZldGUGh4akVBOXdhZGRQdldJ?=
 =?utf-8?B?K1NhUlkxcEtHNThNV1RyYURqb25DbnFsaFdZMW1CRzM5QzZ0RmtDaG8wSXVn?=
 =?utf-8?B?NVorMUlxcmRWdHZVU3BldnAyQUpHUE93S2RCVENtQ0w1WWdvQ2NGR0grYXRD?=
 =?utf-8?B?Z0U0MGRWeDh0aTNNZllESjNHcDF4dExmVW9uV1FpWU9sYnNHQ2ZLSnZMVXB5?=
 =?utf-8?B?aWppVzV1WHFtdTlUUEpBTTZrMDRGRnJGMGhJR2o2QWt1VEV5UE1ranh0Mzcz?=
 =?utf-8?B?ZlZFY3VWSXIzdkN0MnpnQnFCQVlaS1VyeTFtdDlXYWJjTlJ6NmJOQVhkT2h3?=
 =?utf-8?B?eVA2SXlTVmU0Sy96NjdKMC9xZ0F1dEY1RE5WTENJV3AyZXFXR0VrYXdJTUVK?=
 =?utf-8?B?QTFpUHk4WklJNHdqWFVpS1RWa1hFQysrUUpMOW40b2lqVlNyMzA4blRlZ2xq?=
 =?utf-8?B?a0JWVWZ1QlBHU0k0MFd2STZ0VFpvcTF3WlVsVjQ1M01EZk9LYnRDVjhJVXlt?=
 =?utf-8?B?ZjVFeENmUmM5cjNveGpTR0NMazJ1TXJyclFoTThWbU1VaWh4b0paREI4N3hM?=
 =?utf-8?B?bHg2VW9uRTl2RmxueGtWOU5zQUd3MFNiTXBhOGk5SjZuL1cvVFFLSURsRFEx?=
 =?utf-8?B?M0FqYW9NdXE3d3U0SVBIcFBySWc0WUZ2SXcyV1pSbENPUnNRSFZ3cWNSR0Fx?=
 =?utf-8?B?emNmcVpvU2xvVU5wTFplUHpOZXVVeXl5VVN5QjdzNmszMjBhRlNvOWtvT2po?=
 =?utf-8?B?aktXa1FxUjhIN3RUWm44RTFNaHJCRlVTd0xnTHV3QVVuemQ5SnlheDBFN1B0?=
 =?utf-8?B?d3ppd0UyQUdQWDV5YjRsemdQZkhOSEpMYk5ySk96QkJ3K1RlakI1N093VFQ1?=
 =?utf-8?B?R3lLaXRDZHR5Y2NGRFVCeEZSYklKRGZsSU9teEIrNzF0WjIrV1dYTUp4WnJj?=
 =?utf-8?B?WTZreGlYTFErQXhjcWFCM2J5UGhuSjR3OFU1QkJwYXFPOFY3bmdBdFh4MjRm?=
 =?utf-8?B?MURkQytaWVBzVkUrb1pEbFdoQ1doRHROUnVIOFV1dWd3WDhkNXg5ZW10bzJp?=
 =?utf-8?B?L2xUTkxwVXIveVUyTFgxY3YyM1NQaERKdlg5SjF2Wk9wU0pHSEluMlB1cy9h?=
 =?utf-8?B?dnZ2WkFmcHlEUkJlUWREVURheHJBcEdUNWd5Y3NYVVRzZXpDUm9OZ0Y3TEMr?=
 =?utf-8?B?a3E2RkVIeEN1TVNJcVBPbStoWW1ud2ZvOHBpTHplajcvZVRGdFlzWnBVMWtJ?=
 =?utf-8?B?NUNCaUN6NmsvOHRjVS8xQm93cFFYOXZsNkgxSzU5SVAxMnlYelprK0t2bG1C?=
 =?utf-8?B?VGlVbDQrY2QwVkRudnV3WWZzTG40QXQwQ0YzQU1PbWZJWENocGVrSzQ4Lyt0?=
 =?utf-8?B?WklzV0dJUER3OHd0K2lNY2ZjUXl5THA2U3pxM3M2Z1A4MHVxdHViSUg2VWYy?=
 =?utf-8?B?WFFHcmVwUVg3N3NzUFl2NEFSYnlTMW1JOVlkcGp4WmNVOUNpSEh5RDZaTnNs?=
 =?utf-8?B?Z2FpWm15a0toamNJK25BeldLempaam9rbDVpTjBqMVdyZEpMM255OGlaa3RS?=
 =?utf-8?B?RFhTbzc0QTNseFo3OUQ0WDRNN1NKci9VTEpVcGFEanhoQWlrKzVCb3QvUHgz?=
 =?utf-8?B?alllTm50WnovdkZHQkkvTWRMKzVOSEJiK1FOcFRHc2twUkMrOUo5Y0QxTUNl?=
 =?utf-8?Q?4OCR2c9v/UQWSQnnMHwYFLsDb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b096dc56-8241-4875-ead5-08db1997ecc8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 14:27:30.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBlYFEh0VXjJQ7W7NFAmiZlNa/QasDOI79/otj+xEPNxpt81cDfJ4rLguM+xCAtn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,
Sorry for the late response. I was looking at your patches.

Do you really need a new resource [RDT_RESOURCE_NODE] to handle this 
feature?

As far as I can see, all that matters is writing/reading the MSRs 
IA32_PQR_ASSOC and IA32_QM_EVTSEL based on cpu index. I think that can 
be done without having the new resource. Let me know if I have 
misunderstood something.

Thanks
Babu


> -----Original Message-----
> From: Tony Luck <tony.luck@intel.com>
> Sent: Thursday, January 26, 2023 12:42 PM
> To: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Peter Newman <peternewman@google.com>;
> Jonathan Corbet <corbet@lwn.net>; x86@kernel.org
> Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>; James Morse
> <james.morse@arm.com>; Jamie Iles <quic_jiles@quicinc.com>; Moger, Babu
> <Babu.Moger@amd.com>; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org; patches@lists.linux.dev; Tony Luck
> <tony.luck@intel.com>
> Subject: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
> rdt_resources_all[]
> 
> Add a placeholder in the array of struct rdt_hw_resource to be used for event
> monitoring of systems with Sub-NUMA Cluster enabled.
> 
> Update get_domain_id() to handle SCOPE_NODE.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 15cea517efaa..39a62babd60b 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -409,12 +409,14 @@ enum resctrl_res_level {
>  	RDT_RESOURCE_L3,
>  	RDT_RESOURCE_L2,
>  	RDT_RESOURCE_MBA,
> +	RDT_RESOURCE_NODE,
> 
>  	/* Must be the last */
>  	RDT_NUM_RESOURCES,
>  };
> 
>  enum resctrl_scope {
> +	SCOPE_NODE,
>  	SCOPE_L2_CACHE = 2,
>  	SCOPE_L3_CACHE = 3
>  };
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 6914232acf84..19be6fe42ef3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -100,6 +100,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.fflags			= RFTYPE_RES_MB,
>  		},
>  	},
> +	[RDT_RESOURCE_NODE] =
> +	{
> +		.r_resctrl = {
> +			.rid			= RDT_RESOURCE_NODE,
> +			.name			= "L3",
> +			.scope			= SCOPE_NODE,
> +			.domains		=
> domain_init(RDT_RESOURCE_NODE),
> +			.fflags			= RFTYPE_RES_MB,
> +		},
> +	},
>  };
> 
>  /*
> @@ -464,6 +474,8 @@ static int arch_domain_mbm_alloc(u32 num_rmid,
> struct rdt_hw_domain *hw_dom)
> 
>  static int get_domain_id(int cpu, enum resctrl_scope scope)  {
> +	if (scope == SCOPE_NODE)
> +		return cpu_to_node(cpu);
>  	return get_cpu_cacheinfo_id(cpu, scope);  }
> 
> --
> 2.39.1

