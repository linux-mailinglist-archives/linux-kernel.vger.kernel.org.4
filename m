Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727A7609B74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJXHhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJXHhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:37:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6434AD6A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666597054; x=1698133054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b+OnGgLSpNDnjaWsZi8UREHJC2QETSQbSfOs+r8WmjU=;
  b=JaWAVQFPl447CQLkRBNcVEifNEJcSMIggK4ZwcjCtdr2ZihQ4KBscZhn
   ODN1FRK6Tz1vfYk8WkvMCuZ0uYJwGRSgNzMRs12F4PnqjJVX1/FCNordN
   vukoFdz8f8v6ISagy9nTWg2U+kecfbgYHIyfPcnJn+m/ns7tmNOKgaLPi
   QFsaiTqA+B7yyNlvYzO+oTIFvunlo2r+P1C8iCZ/sTmPhNlQi2vtubPrN
   9l44bKb2nzjJmY+MDvrGJcV6si7qAYc2QLqWbsrYb47RRXWP3zeOvciJG
   BdRHne34/dG7NweS9kKRnflhWgfr3VwSi+aRfS8iEGgP2/LkCXveyX79p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="294758102"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="294758102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 00:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="582338051"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="582338051"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2022 00:37:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 00:37:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 00:37:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 00:37:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 00:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0JeKDpnJyv70lqq/k4/u47ZQxLTJczO5HoP+JsELNA82xDFQEuJdha1TcOC+TSeGfUQU3rLkcIvVAIvNZAtuE1MOk5g7tfvzflNFfvQHF9uteqdMORxNJZ4y1Wr2tDlHCtdHSRz7LZkNKr/HfXRt2X/Ceij60/eeNgz3dG/vBYU5U9jBLQcfeFk8CH09IKyb6x+MFXrfq+1h4lWI2eXdW7DPTDi+uPELYoNzX+9U2OlBAnycbqBXNl93O7uB6PaebCRRp09gXt4ol+TPtOOtTzmqgyVYBLJcFAh6l6EfiApI6jasYpkAZL0OvAIfXK2kQ2ab+fho6mUFZg7sJ5a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFs2InQhjO/bWz5v4gNSOM//n0GmZzobv8EB5tDt7as=;
 b=lDUaxglV/c7jFsqy3gZAZ0HXso+cXtpUJyQ5OcbohptV8KiZqShuf4hF4LVv5n8yMuDO/klsIRw+3txSNgctqxpESbsMMmFMaXUX+1L9dStmGYmgu3WUq6mQPqy6n2d7oVTuSubwzxRxme6WZ31IUXu0uQmhaiYyPqOJ+yaRlC6ICCkWLtfdHyZmQWmWleCwCGiGdQWq+czgN6zO5kjG3X/SLlghzMT0mlZNiY2F+95rxRJlX19TT+td1ZuhAI3xdLD4YaHiSPLFSCdNAYgDJTC8zWbvk+XVvaGQdwWe/Jtyldl1dkl2kFcc6tOtnS/w/XmXaukMv8xdtdSV2Fcm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 07:37:29 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 07:37:29 +0000
Date:   Mon, 24 Oct 2022 15:37:18 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tim.c.chen@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <liaoyu15@huawei.com>
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
Message-ID: <Y1ZArguS/rVEjXOb@feng-clx>
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
 <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CO1PR11MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: e8607278-719c-4308-bf16-08dab5929af1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8YqqNDJ/KOQm26JBevGVokuzkcc77r4fShP73aIWLxrJSxuOoBwYdR3IZK+uEu0DATp2TQmqC59XDpA8DRC9BGbBvWA1IUuGfU+pxR64KHovrOZQeJxawdsGXjbgCJE+fusTahXx3VPL5Zngz04ov5zvx4XOcEaEEKBEABUnTc9Cr3iainWpo/L/UHxk5Cz+klNeSNOxL0BriS8D9t9LUr5tM4r9O69+5amkFf98wffbkUMx8E5rsSBMV/zOrTzqgVTv3SunsOLF5nQILjXFTi+6pHhDHEYQzZGwv6VhvYNn1eT72q30GvEtYHQXNWlB/2xBdOiiFhJt2dRUMT8pMmxrRnd2KbLfWD9Hw/4ruBBVWVEt0CXa9tIbYtK7j/7yQhoORpZBnoBxjYf8Mp4AUZacxP72b5qnpxuxXF3tsqPFfCm/yiF/2Gf8IZ+xIIMDyzTwh1W1z4iE4OCZdlLfhf7RkE0rSRme9HS8YhLOkD8ZQOaKle3gTIjFFMXOUkiahthMzDK5w+Lu2pErhNu0Cn/fr9uuDSClHm9eVMkh561q2e1P26CugHsJBulj2I9QznvO1sLSr80bUp0XRQms0VyN32wOdq2ZG5V/9x5ebsjPxBS/bZTCN5IzPn86avKA/MghiaOgbKlrxfl8ApiKbeQmIsFVEVZO2zXqfYhlgL+LSgr5iYaVoejtxQ+sds1luhWuJmVrk7VWjOU8KYEUTT4V6k5RC4CcWzrrnt0vjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(53546011)(66946007)(6506007)(8676002)(66476007)(4326008)(83380400001)(66556008)(2906002)(44832011)(9686003)(41300700001)(26005)(6512007)(5660300002)(478600001)(186003)(8936002)(86362001)(38100700002)(6486002)(966005)(316002)(6666004)(110136005)(82960400001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K3J7TMkm4QElXwxo/la3yvXAFINkJZbR1eeFrI1qByWmUzmHnwaEkq8y3tLP?=
 =?us-ascii?Q?lSq3OCVw8fe0Fq5CQ+iNWLJA09J8qDQDzERvhXNDhFnfFL6ju01QtBFgLJ2m?=
 =?us-ascii?Q?eVjbjM/fA7ONhK3rV+GKlCakYy5mvyJsJK6G/A16IBK6PeBWi1bJHMbjA0kw?=
 =?us-ascii?Q?jY55LVDpohegrlSd6HPkejBXpgkf1C29PaehkLhn3IbPj098A5qbxnNGi4zc?=
 =?us-ascii?Q?BbOUu/uN2KEwj1kK2FrJZ003rT/XJ8XX+op/iff5nbgzEnj4n5YKWPG1ceCd?=
 =?us-ascii?Q?Q/0055LU1Ib8MjaKzaIgS6t1+OjcsOiks1eABrRdTHojs0tDxnDpYLEl4wec?=
 =?us-ascii?Q?Xh6X16sguQfnWZVvM+OZIs+uIWyNQbBFit4Ov39aIIov0/s2ou5yxUTMyZRH?=
 =?us-ascii?Q?jVfz/qJcsYcBSsA3c2+Ia/Sh9TJHn1FxtA6cBFJz7ZaaZrOzuvsHDh41I/IN?=
 =?us-ascii?Q?0P/Off3g9TDYS0WIF08LD92TgsJeUs9dNRCfaePHQNIS8UrKZHIzTjfZziWY?=
 =?us-ascii?Q?xfr27d8XHLIZQ9DOsEHJHcgYkAb7g/J9KVPghuGtNd9DpqIGcJczMVswEzVc?=
 =?us-ascii?Q?hrFETV1HHDSx91dY96NIji0DscnLFvU26PsTmX5QGuqzjTZzzgGMcabx6OnR?=
 =?us-ascii?Q?erpCb8gzNGOZ3n5GtDO+DVxXSQbzDnZq2MnVLgx6itl7Z9hnLP2f/AJw9XVS?=
 =?us-ascii?Q?WdpksKP+5OKAtRaXRcpAOieuoyjVUQ95ZfD8ILq17X/xeBR8OQtkuliQuyxh?=
 =?us-ascii?Q?aullwDAedEeqePLVh0OAoUidI632zMIBw9Yh1Nj8E+1AoBFuydIGKanFuz7Q?=
 =?us-ascii?Q?bv9vReU8R2gIC0Sdn1lhpICHmST5bGKJ8m28yc+lsIziMs99TzHuwGlL4D5k?=
 =?us-ascii?Q?rbWmIzlhRobO8d1KPfgOyfLF7CVNkSCuPWSz9AS7i8GSVVewS6MFfaPv5LnP?=
 =?us-ascii?Q?IBqLWXhD6f5RUGbjM5Q48BnSFcUj5TfUA7YR1meBPXc8Ryt0Ba7GY2SuRnOP?=
 =?us-ascii?Q?ucZz+DRupC9dV8/Y7yLt1Sxkk/NsStXg+yM42GbyDHhtV8ZMWei6nVgGfDab?=
 =?us-ascii?Q?3IIvEht7wDF0FtHT05KDTIzLaJium9PutE4NNdnYrLlFkKIOx+W1AOihmTEK?=
 =?us-ascii?Q?OJ+qi7aGe/sMXxq0tr5+FmBJ1581Ie95w+EngJZl6z8/0aYyVzOl1184EbN9?=
 =?us-ascii?Q?NlL6K6XH4PZBMODCdyzuPkW6fv6OvqUVCVt5NF2yUYBOqKUQdTLDzhplyYZd?=
 =?us-ascii?Q?s7rchEJponP7hiM1e+ZXFqk1rDVJhu3Y3/c+idig9uy6+AZ6y/b2cmvqPdWb?=
 =?us-ascii?Q?8KNQupK/nTgYBzKFHDjjjM3m2swQF2IHDMuYt6lQlz/m7e1Mq8M0qVtRbfH+?=
 =?us-ascii?Q?AYQfMdEk1REGFDT7lm/T7XbfNVfBdy9jpX+E58GHY3Pdd4yDhld7POBrUG2q?=
 =?us-ascii?Q?pPuG3/7LPQvXqZxw7+4mqN1JkeL5bkK4ea2x4leNazyvEmwHRMEIhYityFVH?=
 =?us-ascii?Q?Jri5LorgsRmjbwMLFEeip4IIRNubF3k81oXY7Fzaum/fefopZMOsiNqxnWb7?=
 =?us-ascii?Q?RAr5KHoV10XIGD8QerPK2sS6XR/XH5Z/JBUhbybe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8607278-719c-4308-bf16-08dab5929af1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 07:37:29.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: co4tZHahL7bbYA4O9U7DBlxQQ/Z1h/DiBxRiUsPgvZMjVnKuxW9563cm0zqWNqAXOzyqCuLWgV9wfQV6tsttKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 09:21:02AM -0700, Dave Hansen wrote:
> On 10/21/22 08:00, Zhang Rui wrote:
> > I checked the history of '__max_logical_packages', and realized that
> > 
> > 1. for topology_max_packages()/'__max_logical_packages', the divisor
> >    'ncpus' uses cpu_data(0).booted_cores, which is based on the
> >    *online* CPUs. So when using kernel cmdlines like maxcpus=/nr_cpus=,
> >    '__max_logical_packages' can get over-estimated.
> > 
> > 2. for 'logical_packages', it equals the number of different physical
> >    Package IDs for all *online* CPUs. So with kernel cmdlines like
> >    nr_cpus=/maxcpus=, it can gets under-estimated.

Thanks for raising this new case! For 'maxcpus=' cmdline parameter, I
run this on 4-Sockets and 2-Sockets platform, and found the
'logical_packages' is still correct if the 'maxcpus >= (total_cpus/2 + 1)',
but gets wrong for smaller numbers.

SRAT parsing solution [1]. can solve 'maxcpus' case, but it will fail
for other user cases like sub-numa cluster or 'numa=off' case

IIUC, 'maxcpus' are likely for debug purpose, I think 'logical_packages'
is the better option for socket number estimation in the several
existing solutions.

> For instance, I can live with the implementation being a bit goofy when
> kernel commandlines are in play.  We can pr_info() about those cases.

Something like adding

pr_info("Watchdog for TSC is disabled for this platform while estimating
	the socket number is %d, if the real socket number is bigger than
	4 (may due to some tricks like 'maxcpus=' cmdline parameter, please
	add 'tsc=watchdog' to cmdline as well\n", logical_packages);

and adding a new 'tsc=watchdog' option to force watchdog on (might be
over-complexed?)

[1]. https://lore.kernel.org/lkml/Y0UgeUIJSFNR4mQB@feng-clx/

Thanks,
Feng
