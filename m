Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C91C6D6763
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjDDPdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjDDPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:33:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803C19AF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680622385; x=1712158385;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=03HtnfiWLRMJTk3Gup+G7jm+fTyHzY99KT3GETp2d3I=;
  b=MnN7dqe9J1eXPHbSp7jWXeqHd1FpzoARnsGKVrQuAZGD9aDtpW3LFKnz
   ZSbQyLPA1CEZD2nLl5x2SV5+660GeMRPAISAlsXsO1ZQ4UUfhe20Pt2vw
   YRgIw+Su9TqsSy13ZttsUu0yT1B0PEs2bcFJTpZDn0PpRpoYsRi6zueVw
   FOA91t83KsjmJWyTKrINmNDMreJj9UttT/8n29zSbbG+MCzvHNVSz3bmj
   0CQ1DLpNEizBYYJiUcAyyjeQD8sVw6JC/Y8JrYrCcZoE3SQKZReNhcytw
   Sd6CtukW08QsFAn5VwfkYDLXRups82NAe1VKX89kLQ1nxkDJuWhdQgRj2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="370037205"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="370037205"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 08:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="1016146709"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="1016146709"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 04 Apr 2023 08:33:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 08:33:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 08:33:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 08:33:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 08:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5qJF76BP6FOVjm4InghuBQXjmBFcptJnfglfOkUKAMwqe8yvV0L6bh2Gz1G6LpviGPrAHjHegiLwlUtDlz+vhmqU/O3vQK9c2mn4XZYlVDJIhGG7qe7NtGXAaCoEAlpzl2I3qwzLpns4pZqKdpfPDNElc8YDxWgxYVWV+/VAPe7R6eyzHlSWXoOAJtKqpfXAlkV1Jtvo4nFYbVZly+XpQfIXB+axtdWStXS8jRqpWAX4LbBcFpIyCAcTuFsWZN4MLz5BC8i8wI4o07E70dVbRtuipk/jneQ6AbPmJ1FtPIFrcVPTZUcNpNy2dEwNr6LXCNekkI3TjMcKV5RslgHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOnxVFym34dp4OcADxBfuIkNA+kAmFeURiKvOsrbcBw=;
 b=FOBORO/FYafMQ5tyotcr8ybdQ8xW99VLoaFiI2WI55a6f7Oqs3D4Xfd0WRa4GS85ChJPv6DvtMLUzgvK5lzuGM2htRWrHfMYUEQprIWDYQKeM0fgMh9ErMt6iq426Aug29xKLyG7QIwMad51qop4f5MB/ACSt3fnX+ca/ePoYiUw0gVJqGyBEIYWdf1ljm1n/iABwXXycZe7U3ltYJ03ocQpuluGNOsd0MBQs+UyCh6cy8N58Mvrh6bX86xH5JhoIgZLXqEIlhg+Q5zFgHEvQc2wfbT+pAWr0IbUnOScSxb7o2JMAlIMWpgenb8GdjcM1dhJAPcVy/BuAZfLnmu7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 15:33:02 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 15:33:02 +0000
Date:   Tue, 4 Apr 2023 23:32:48 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     chris hyser <chris.hyser@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Message-ID: <ZCxDICwfUojWTGr5@chenyu5-mobl1>
References: <20230330150757.547423-1-chris.hyser@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330150757.547423-1-chris.hyser@oracle.com>
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ff8196-eb34-4227-f184-08db3521e0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKNpsRB5WErKjwvCiR4oEEUrQgC9sM1LSWmaA/AFxu/TZ9IldmPXBxnp8NMz9QzV0FeXcXlzOzGp9B0Ow5yjNrk2Pv9xASOz0yoxNPAI7BwxESyP3Nl6OICugA9nhGGET71veduEaObOoeECRJEumcaRFdjaJKlIuCL9sdeIclA2qrOu00H/aQ+1OhpEvafLCOkzLq1hyb0/FyDmQQBNa+Dj7la3NHiIzK27MHXlsLWq0ImkHshM9qG6Oe9JZxC3RU6cAX4cWtmFO43c94MHpt2U4seKksKTiPqLWg7u7QJNDISzNUxapikIp4PoP8cTPR8xVaFW9iOtb6OXLWnuHTLT9WbcxYc62CHItBFWtmZXjJIa8KYBaKVM8iTOXPe3wmyh1/aBK+3GijkNOoG1Az46tsBTUSv27gaaj5/KaWnMRkDUPpuCaZNCdgx9S+4tHYv4kmNtiKxPXt/hTuhxhNYi2FiW0HQrptdCpZMzUxsFkCmipNIdSi/aDjCZZwjHgzEMyQ3LgYIbcVeDUg9GTIJ0lWquLjQi5scpsZmEnvppwysqi9DGAs5Rzftf7dNT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(6486002)(186003)(8936002)(8676002)(66946007)(41300700001)(83380400001)(6666004)(9686003)(6512007)(53546011)(6506007)(26005)(6916009)(478600001)(316002)(66556008)(86362001)(2906002)(33716001)(82960400001)(66476007)(4326008)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9C1AUM2gcKhzSy55VpUoc+n8d3CiY3GUIvFEr6oTejxLuZW0YMHa8khyytyn?=
 =?us-ascii?Q?nAMA4cRC9maR601drtOcfN7cHrO4GBCiCD3Np/F357gogx5HDUsmE4ZnzIzH?=
 =?us-ascii?Q?FY3Hf8Le7IaMniiZeO/z79p3S3qhTrt4q/iM6laiTbJZhfLt4m/Cdllx7gAl?=
 =?us-ascii?Q?Pawc8RbQ6fwQlNGOLctpu6+b118jfZhbFroQJLL5e06yQkNduEdICSSHxjZz?=
 =?us-ascii?Q?MYmgq3CDqrEP2c50tlrTxMLydcG8YJ8Cr0xTmDm8BeEsCyQ4nKah9SJNRlii?=
 =?us-ascii?Q?8zVu3UajGcsnOTR/PP/C33o7Aigj89Jh71wRgNYv7B7mg3hkrokEfnsKfufZ?=
 =?us-ascii?Q?grLtQlxMYgZf6ejdpNe35e9E5AlqfwB3dXLt5cgOaOe0XMybXLQIfCdFzCsP?=
 =?us-ascii?Q?H9+ea18VYRBjP/O1S8QuCoVhiLzbFDhvsojw5NF4f8aPdQJcYwcbsvu+xFuh?=
 =?us-ascii?Q?yyNSAcqOmPA4waW7q7kPcCstFCmhsKxxmKoufpT28yUE7bT50xsw4KcnrSFH?=
 =?us-ascii?Q?2k6d3ISgxSNG2NYfjmNm6rHVL8xGbOZVqvIJjzM1THTMKM6w/9LZLPPNkjSw?=
 =?us-ascii?Q?YK14IlL5pxTeTx3uY3arwj5BNbXWR/lT0ejSlcdHTK6NYAO9TiHwJNru02Py?=
 =?us-ascii?Q?ANu2GsZ8+1E9Olt3TqBxPYkNT1tpjrBzPWDzmx+oxeCC3QfjWjG8TyhIVNIn?=
 =?us-ascii?Q?K+MR/pj8lWgvWQa20dyN1wZBjCN6/rL9kj1weDQLA5gKaSuQBmt2U4MAe2qA?=
 =?us-ascii?Q?waEYSO2fzb3T65nJaAYvHSyfn+cXGWmCjWLOvgtOvsAsRsO17zIYsYaTdPrt?=
 =?us-ascii?Q?cYxC29d6a08EAioJkm8FsWZdaPgWViXDULxgsWLaXUuNZX211Ym+qOsvgN5n?=
 =?us-ascii?Q?gT6dkbDcfo8K5oQ2aqe7/Tgd2JcVtcKGr3AOoZp1m+2sAGhyE8gNRZBJpDic?=
 =?us-ascii?Q?uz2Z39FN0a4jIWLW70x4crpaQDT/02hmbpM0ufKPRyRLvYQeoXeYTb7d18kQ?=
 =?us-ascii?Q?/j0s84m/AibKwGrt7rjdaXDJqZ4nj/zplwf5HSE8tjvTjNxxV/5tbbDBw5/Z?=
 =?us-ascii?Q?cAzfHSH0u1SbFuILuRk/W7/rwrUg9ojWuCO2LuMj5d8w+RY3ZYAvW/InE9uc?=
 =?us-ascii?Q?7ncuYX3vJCZb7xGUxf4DJ9m5MjkWBkgNFteL3HaF6HUxEaw3Xir/aX1YxFq4?=
 =?us-ascii?Q?rIxbKA7bhkI6ujaiL3C+XhMJHXZqC2FbY5YW4B3EcDeaGBR4KhPu60ZM8enk?=
 =?us-ascii?Q?juMdksTh8ijWH3tPakAMmbghQ6tKSWeiYPXz372RbMf8aNiTvmc4oQVlmDHV?=
 =?us-ascii?Q?cBc4fsJ35afVdkTHLRYgq/1JJ4V0MtJ9FFdzXFhqcqPkOzNySIrSVc5gUwkG?=
 =?us-ascii?Q?eq6P8Vs2dpnCMC45n8Djn3ZVaVfPuzwW/S6eATX7rkc7/m8B60axtXGPmRF8?=
 =?us-ascii?Q?yctTCDwIoNiPKvfs2LeVqCvXRdNBbTM/a/4ijCP0Lnx6AUszgM/k4j5NkjHj?=
 =?us-ascii?Q?i7djhxaLsVulJLchkTGmF94VG2qT6Qkm6l6cWBfRPVMhdgOZiTTNJo8TQiIW?=
 =?us-ascii?Q?2/GutLD60YaYOmt/M6cOTOV5hkNRLnrgTA3MYwAL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ff8196-eb34-4227-f184-08db3521e0bc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 15:33:02.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSEhQaVgCpwo/3ejPg7AXWym7qzc2Jc+ui1V/JzF1sURPy1h9T4FVHuCE0wRxzsagpa81dwxsY1e0VrYgS9cvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-30 at 11:07:57 -0400, chris hyser wrote:
> Commit 6419265899d9 ("sched/fair: Fix division by zero
> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
> value of zero. When moved from a sysctl to a debugfs file, this checking
> was lost.
> 
> This patch puts zero checking back in place.
> 
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> ---
>  kernel/sched/debug.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 1637b65ba07a..b5fc7e250128 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -278,6 +278,56 @@ static const struct file_operations sched_dynamic_fops = {
>  
>  #endif /* CONFIG_PREEMPT_DYNAMIC */
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +
> +static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
> +				     size_t cnt, loff_t *ppos)
> +{
> +	int err;
> +	char buf[16];
> +	unsigned int scan_size;
> +
> +	if (cnt > 15)
> +		cnt = 15;
> +
> +	if (copy_from_user(&buf, ubuf, cnt))
> +		return -EFAULT;
> +	buf[cnt] = '\0';
> +
> +	err = kstrtouint(buf, 10, &scan_size);
While testing the code, it is found that there is a
kstrtouint_from_user() could do the above. Not sure
if it is worthy to use that?

thanks,
Chenyu
