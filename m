Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47E0647FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLII5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLII5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:57:06 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338CD13DD8;
        Fri,  9 Dec 2022 00:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2ewCV+KL5t0OSUyFgdxZ0k/GqqgOPJHKJnGqwXNTPQfBj/EN3ndn4wQWSpkxKjxbxZteNf4vXmsJZx7wvETqGMksGj7toe53wIyYd9b3nIaHJmHhebrpcwYLiFBDQEP5uXYzN6jymac2VFHAnDPnGevSaXwSvM4cD6vXhISFEq+CiZ2KDJ+Ry7Ol0tMVCGX/rzM8VjLOftmIYN+i70DFL3GTONjJvsTFNxfRG8VBx1G3UmYOUVe4gZJWPYqhWW0Xbg9CaZVxAHq1VMMlHdOj75unZjy1/e9QeJs6f3Mo9Od+5lSPwYd6e/6bziomzjSb0dYe6mNa59bvG0tDQP7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwFL3HvjECzYE5NurQcSkvEQGlrTGJHhS9+Pt+pA/dA=;
 b=ezdkmbGyuCBKMQxYYoai0kdxft+zZKBPpNAcKN4kZJxpqYv+nYpT0OSc+6PUvuek/lJTR0VIBSuyN5K4jqMKZf52ntQeTmGvjyMmdV+8x7rfwgDrUsDI0CTSyhUAMSKgQM1adbyIL7YjObpruTpkRxdFZ47vsTFFw/bnLzgMyiwLBCc/5nnfARCC5Opzfx4S4xgiX0T3Wprz/UbzIKO+9fwjoPxSURY7flVFH/5tMVCDnk1Cw/Akj+btXIAmS54CGzWOld7M7HfWhMFQZunCvgUs68Kzc9OF2j4iSu/ahZPKWG1ATdEFOOigiqievzy5fPE160r/X7aQuvPVa7Bfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwFL3HvjECzYE5NurQcSkvEQGlrTGJHhS9+Pt+pA/dA=;
 b=pW4ZK+fjfLxdwgCgwuEgi9tlc0WTVGz8XB0+PkY8WrsG+QQIW7EqmLDdt1XKi81LDNJyj5xZI21mr3CqnIUWaKqZ+ZlocPBlq07dckNcnkTNSzBJogZNiYs1iN2j6uQqNdleMXGEPh9Eq3eca9VCgsoOPCy9YuQlxb37/46U2ZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 08:57:02 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 9 Dec 2022
 08:57:02 +0000
Date:   Fri, 9 Dec 2022 16:56:37 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 04/13] cpufreq: amd-pstate: fix kernel hang issue
 while amd-pstate unregistering
Message-ID: <Y5L4RWjrfV65/eKD@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-5-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111852.386731-5-perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 7946be34-15b5-478e-372b-08dad9c35690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZfDKg7Fjn9dR1ds9L7m+CB6/9qo2iv8LPslO1jAMBbrspWjLtIrTy6fwkv7Od+UmhrD1p+hUvfjp87vxBzfmMdsRc2vf3q+gcjsuRqvPOT0OKJDhiD3Oi46fnbdOWakgN4/af5lrq6AgekkxMoD1Y97sYScUjHa/xGwcRV7oM9n4eTjw0ynzOhXZTUueevxY55gP5u5XD17uaBPNMZF2GdTCoxFuOHPI4jKY+fPHnKG77K7GOaHmGDE9fo6JRv7LFkir0Bkyr0t7/+IO21KCV9BM0lLEgVquqsZN4Ne7Zp+AJLFo7vvoY6AJi7cPnxiJRdTWKKY/mLkbYT5R4pOOuCJ03Rel+NLPMIP+EcYumwSm99PJ68YLLaD5VZe5BCc2SPJtM/wm/ogQElli85I7yo0nRUtZnNHvEeoi7p6KMk8TXBbI7DZwfPoBxGx7tSVysaDoeS/A7KWRQgM/J/gU8yNiNEsd4hDPF6cg3Kmd3DruE+ge1uayZbJ8YBVbvUBuwEYgXO+ZvttUJirSa4XPnPLJ8KTXeaXOZ1CkpQIP+NSQaGQjwikHkH7vtlHvnVr7zR9Fkaay6tx7ysTfNXo6etDIByasVs/mY3mcQVx8cuWZmgKopdMbh1M9ABIbFYE9ISEQ6botb1pF9SuGk5kFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(83380400001)(66556008)(6486002)(66476007)(8936002)(6636002)(4326008)(66946007)(5660300002)(8676002)(6862004)(41300700001)(36756003)(6506007)(6666004)(478600001)(186003)(316002)(2616005)(6512007)(26005)(54906003)(37006003)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?74l5rrp+QlxNWUQk6E8si91EMVJgZawhMbE5TIFAPFfNbVsQrBKNbrjz7lKp?=
 =?us-ascii?Q?Uu7rL1RC6Tj4DdJtBNXsdvstvnBIGJOBgXF7kmhs6vEBH/2k8HVjtbYobRxP?=
 =?us-ascii?Q?0oUXlqfs5Dnswy2CNtXgJvJ5pZ7SWZMZ5/HLhisNNZV55beZ0UxHSzeQ25Dl?=
 =?us-ascii?Q?VDKxv9wskbl28jbQ/o9V31bCt6Sud/WQznQRaKV/fZ0wLV0cnuqHkI2HztML?=
 =?us-ascii?Q?1OITy9tOVWj43OGcQBEBLXGETnc5MSrbq4f6aUehqdyP/06lfvC9ktvL+Yjd?=
 =?us-ascii?Q?GQGGBB5ena1mvsHFyoAEgz9ouAs2r+nTdN5xgObZwQ2cdxmWfOb3U2M0k8ng?=
 =?us-ascii?Q?n4vcSvch1LlwPbODAJPNK5vT4Pt3D6wMS35CJLNjbbMXT8QYzaYNPxmWnsR4?=
 =?us-ascii?Q?8w59TNS3kLwNlMkoDPzxY4CoRmP4H67Oc6vbOvuq0286aepbvXnqzYh6Vu1k?=
 =?us-ascii?Q?q+CHGvkSyHzKiaCkwHAWpJ9YRWOwHBF6s9xAWUCmARhBJLPCcoWaXm3LjpRD?=
 =?us-ascii?Q?+Urn8DHuBu8yBd2oQEvlH1+8whn096/w5i5nhet/8aeDg4dUaHfTIDg0gVT7?=
 =?us-ascii?Q?7IexGWPrb/vITJMiyFBAAQwAKEnYElFpYX7z8QfbLV2eNPrLFApJ45OE/jbI?=
 =?us-ascii?Q?Noz5Di9xTPbz2uMG5SG7FQDo4rnNJFvEqAhG/pUyU7UfRSfuu0y1i6cY4Yts?=
 =?us-ascii?Q?BwPSjYuvi51AJaAFnym37G0UtN4nlPKDctETCyIWOqohXAootSZeS5jCvCrE?=
 =?us-ascii?Q?OIgJFH4HKh03AHQtf6K4mcOFzjM4XIXOWs9e/ftTRNTlvqGtSGANKfsiaJ+5?=
 =?us-ascii?Q?h3Ygv1jgLvlXSxZC2aF/2Tx5LXDfzgiCuWNd0m82t08HDbUO2OMi/lPdqSDw?=
 =?us-ascii?Q?5ZNOB2HlIJPjXUSCSjzHE2/HSf8VBAcNCqCpUpVclau8PBzvcVOBceTpnrRC?=
 =?us-ascii?Q?1MkSlMUfgBtkaWA3k4O5hz0hyw3UVDpzdxDfw3+p1woy1CobH+MxhYef8/j9?=
 =?us-ascii?Q?aKqfoLKnEed5msGmA9gjZGRO8VMTrzaovFXZAq2wmOtALny6csG2sBHHwtyb?=
 =?us-ascii?Q?GBiYfDNM7N4cWuKyd/vB0PSgpC0PoePZq9tl8QxxEAfg+rkHJrHXwIJ9B2Wf?=
 =?us-ascii?Q?sbSXsv2kk65YuAzDrpw0gexBel/kAa/eibeEhTsl4LciLYxFJGgSV8zCMnig?=
 =?us-ascii?Q?MkNJcArTe8tpmGXUwEbD3SV+2j1r44V/8gvbyPCAHiNnn2lA/EE6p3LbEorv?=
 =?us-ascii?Q?0PT+rm5EcoqnpRBXUZYQWMmDLgWZSq3GINhPl+XagB8QAT9KNbsX9sNBAeOP?=
 =?us-ascii?Q?q9ykxDECfrDNJ4vo9wB/Mzwxdu5TgXeJzQAaBhNEyjkSDvhZE3xv350ZU8zF?=
 =?us-ascii?Q?2w3CVlwMYiDt+9IPKh0LePhUi7E/GvU8LEvTyzodvd4v5241X2nEHgJBi1i5?=
 =?us-ascii?Q?PX24cDh6hcNvryqNx/5BmUQGsbAfTSDU49+WqnmzgnP6vUtgbjcTntd7VtVf?=
 =?us-ascii?Q?NL5TuVZR4JGA7wUASfDsLZwttSceg7Zdlim7ZTAhbVZZ8Fsss7x3eW94xHnB?=
 =?us-ascii?Q?k9LD61y1ta9PcXfEngUxiea1K7uJBZiyLTZWXUQW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7946be34-15b5-478e-372b-08dad9c35690
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 08:57:02.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWJrhm24nNv7ZjQBh1ObC5wdLVg4CFXeZrEfykdd1j5Y1Tgm0SYYMiFIcD0E1O3Zmo2gbcwm327TFc/o86M+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:18:43PM +0800, Yuan, Perry wrote:
> In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
> increase increments the kobject reference count of policy and make it as
> busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
> decrement the kobject reference count back, it will resolve the kernel
> hang issue when unregistering the amd-pstate driver and register the
> `amd_pstate_epp` driver instance.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..c17bd845f5fc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  		max_perf = min_perf;
>  
>  	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
> -- 
> 2.34.1
> 
