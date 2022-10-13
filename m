Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F315FDBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJMNzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJMNxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:53:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B1E09F1;
        Thu, 13 Oct 2022 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665669113; x=1697205113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X7aongCjckz71SIO3KHY/ii7Gp05g5q/Z14NYlZzVcs=;
  b=UKhb9mk03f/toIb4+Qs7Wkq2U5CDJbFj/wFo+8kile6AA2lXHuKhxFvz
   RVAuJ8gBXW9Nx0ezDOq9HTnfaO9xN2gRfHBfTQdWK5U08ZwSzqIOSwwyo
   EOz0FUh1P5NIKyr+Nb1MQ+/ZjA+t0ZIJJtPfRmINH2w2a4I74zOyOB79E
   mKCFj9GDW5nsDwrEyPg6X34jN/d/rUO+lG5yfSyXy6UqzqZ6iaItPf5k5
   7T1wC0RSpsIQF6S6J9UTirpO/nI6MAJhSSrvNnbgzKT6J/3tNlGNCGhwU
   JoRPLG5vS3TEQYllwWxlQ0B/pNP1RfsCr2EhZiuvVZ1WfVeDMaFmrJr/T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="306718692"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="306718692"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 06:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="956170486"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="956170486"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2022 06:51:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 06:50:24 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 06:50:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 06:50:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 06:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAEoAyCZDP0LLaMt0pgwa+0JCUy2Sb/y7yDRrKeYDDp5qLEzYGT9fQ/zvd7KgAzHLpQb0LVj3KyhiTXpC3EjjQPaWntHzYDbzlapVob/1kdAOcJovU9HFa4i4IVDcQFr3WzOCIS861BekNFRdEP2WtxwjFztqSuWEO8gtLLlmublWVZxs8l4OudUmSQ1XenwTkK7Fp9VJmGdNPJxmLDEp8whob7wprPED88xEohYGeDenjYvOTIiliG/9BmnpP/Zlxy/4Qg6eGCVjUBn2EQNSKCoEPOxM2FmZZvdQs7vhyB9TMMmAj+FmbpMLy8LVjVxYUh8BgZJr4rpPx7EMDNGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1QuSBCEr9owWXwWgovhqK75tDezb+mp0DLUzXEC09o=;
 b=iYsx119lyh1x+CXljlj71/hnPyjl0hQlvi6ctBREzPgzlY+8onEYE8tI97B/vCVPZdLGkLhET6QctSs0ykE1r+FEchuZ7IiYj/9GSvPsFcC0EOk7+XCr5IV3sVTzsMuyDidfeagIqyRSSmfBahcsqM9KDy7XDDq3cddtt+UU2ta2fegwWyP2qWo5Nc11O8vy//wkom8DwTb3Lco+/i2blmEoY67Xi1og7W0znG6W0wXr4W8alFX6L31/ahqdKryzQIhs/GeSzR7mFujwlbYtCQW3ejbrYK/O+aQsc0msqpptVAPA5cv1DZVAYLMFgKI3DkX4jZhagpjPHKcygORQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 13:50:21 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%3]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 13:50:21 +0000
Date:   Thu, 13 Oct 2022 21:50:10 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] thermal: intel_powerclamp: Use first online CPU as
 control_cpu
Message-ID: <Y0gXkhZ8gA+8vhWO@chenyu5-mobl1>
References: <5633735.DvuYhMxLoT@kreacher>
 <Y0gOI9hiP9NXsuJP@chenyu5-mobl1>
 <CAJZ5v0jyYB7PVQm-q3UQAaCu15LbMpfZ+8bCckZWS93w3y2XRA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jyYB7PVQm-q3UQAaCu15LbMpfZ+8bCckZWS93w3y2XRA@mail.gmail.com>
X-ClientProxiedBy: PU1PR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:803:29::32) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c6794d-d414-459d-8f5e-08daad21df15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/5nuIr4vvAZM9ZvgBFRcpgI+xNxZEOxkWlbU9K3GzWm8vst3WQpih8TT0OrOkaqQIZYWZxQeH/o0XKQsEMTejP3LA8FhLqrJJrBHFBHGztVKVJu3jlVvbnOO3XJpJPO2ULvIJIPhOod3gcrctvTtVpyE27fsn6I6+gSYH0o7ev6hvP6OEzESNqH7Yvu8wZD7LEY+vCbesoyLqw1Cfaenz9r8c/LjzFYzcLih/aeNrjBDsv5cOPXRImBsmekXCcaIM8lPNwC6LhgdLuD13d2KQMlsPWCq70pmZ3hlMTy04NzLPDtLsvjBRYruM4ybZUBTJgK5iAhWNbOUV/0PbJDHyRImWo92+tEvRILAzlDio1QrYnjjFcqOEq/ig/k29EpWIYznE4SXhGC6TRsUlwoZbI/tqrRVAoiGvyJJCb58J0akg0mRcAt7vsjU/M8RtxNyjB1uJLLhaHw/H1ruqkG1dJwQ+DU7R6UI6lAnTX8UkhOozG8dAAfcc4JKLNs89PfwGe7+KD2o9KBkqv3f/wfR1/iQVmNmFmO0WjqJvbN8zk0vvHIjaMFR6osVpx6sFl/da8hIn1atL3C/Ihl4ZcPoKJkdE19SwpK/UoPW/a85TGVb/ll0An+mZjaF+/tti9HpegznMwk/CCcvaL7W8SxhuIKcFqR2OrciKO75lxoJx5dxzpf6Rkyr+F3ShGp/yWnPJsG7yT4dMRTvswj7jB5KNX/q443t0P9siFEijpL1hVy7BodYU4mXPNSq0fkLnZzBLwSp9JJiU1MyJbW2YBsXuUa4W3l+321POVd9LBIu7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(53546011)(26005)(83380400001)(54906003)(86362001)(38100700002)(6916009)(4326008)(6506007)(8676002)(66476007)(66946007)(66556008)(2906002)(6666004)(82960400001)(4001150100001)(41300700001)(5660300002)(9686003)(6512007)(8936002)(186003)(316002)(478600001)(33716001)(84970400001)(966005)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zm/hLnasQZhSBK6cclmEqfOumomUtthOL9b4de/0rXqAqozF1gxa9dDvU0iq?=
 =?us-ascii?Q?llbD9mNaJsvNh8Fq+VA64Np0WL2CdUYvRtNtEvXs98cQZSeML+/fFe0IHh1q?=
 =?us-ascii?Q?6lxyBKJ1UQlPG7GsY3DaUkiBwUma05xdyR/iZDNHkAkD5vAzkZKcX2FLNmxr?=
 =?us-ascii?Q?oe0IEsUqLw2WEJZWB8WmnUc9M60uTrAgRSj01nVQV/ipxs36EKNEILAl+LMb?=
 =?us-ascii?Q?9hzOtUIkNXuaaZ995c5WMBt+PpOJzYawu27NiEzy+psGaFcfoXf5Z6BM5uRT?=
 =?us-ascii?Q?2EfMIv0j3lLlz1IvSx+I/JuulwMasYYXHU79NSvGZ8PytO8rHmVo4rfUwJhO?=
 =?us-ascii?Q?tkFHUWXXAchOLdRXPVMWsU/1rAp+pZ8Q5aqjE4JdLCXZjsvp72Ye+MxIxwCf?=
 =?us-ascii?Q?nY6h8T2E7kJRdeP/YN+ES/LElHHmovpvE54lUswESOHVvc2K0DMxvciBzM+Q?=
 =?us-ascii?Q?KDlBSLhHyyS6/0Fxaa0TvepcUS2pr45H4ddsw/8ZIAZgAYlUiL9mJNMpRt95?=
 =?us-ascii?Q?p2be1cZbdRJLHoKCzNED/we4C7/6aIOhQ6DJ/16/5b00PsZ/KDHUbhTAClil?=
 =?us-ascii?Q?PngcHPSHenyDKQXjjz3PyNg66caD83DCXuANnSld6pGXtoYiB1l2Fu8odTNs?=
 =?us-ascii?Q?vy3rSy3Air7NASnMl7wbqXTF4PcB3lnnonesz2ujQqJO6LtB60SnQ6A+VVHu?=
 =?us-ascii?Q?Qp3MAmlrIgXqf4+Kr8qN3+IKoTO7/pRxB0+VrcEBBEMLjnnMg/wKLqkayjDo?=
 =?us-ascii?Q?F5ZUp0SSZm5Xwk5QS156JdGrbzRj3B+hAoSAdxDMWNrq/3TORowVstlX8wrY?=
 =?us-ascii?Q?Vgygndi0fUn76uzzKbMxmBaWGln1Yh3tDoV6F43aH28mCdET7wNyC7aMHC3T?=
 =?us-ascii?Q?7wlY9yVfYM1H0U9a6T4IugJS3kl77rbqS/0u8zCIytaCp0iRvRhbMNAKYOwD?=
 =?us-ascii?Q?F+hXuQQmNYQ5SOkTeKxxwm2oVv5dlIm8OGQmRaidKH01K8SR2KShLG14QOHc?=
 =?us-ascii?Q?IftjnZAbruJKK93CqWGz2ZiQKFAgbxnjBxI5FeziTeCATLAhthieemjwSXL/?=
 =?us-ascii?Q?XQIlOPjRAvsDjGGTbUmuuMlp+GDYJvfTjbm7cWiW6iOG/ZH0eDZpdePAHmHW?=
 =?us-ascii?Q?Oj/76IplhXtizF/mC4MjheAE7cGyvgc44DZT3qO1UNWv+psY0XgHdyhnuIIC?=
 =?us-ascii?Q?CZM6t+pFY/+ZGJCUwQYQr+cHv0Hx/ZPS/bEH3JAsxGJEbYK6rz+snoNrPkXl?=
 =?us-ascii?Q?9AtoQ0fmo1Yy/yv+yw4XN/llJ7yhUeQOqtmxRq/8j3wE16HTIyd89xH9HM5N?=
 =?us-ascii?Q?wHhyAiBYhjsTr695Fh56bcv+HnEKXOiO8j4idpwPXXElJNNh6gwigIFaBQTw?=
 =?us-ascii?Q?6IPeK8Id1lwlRvaqTgUyZuNEJ8Mu7ZGEpy2LaODmKUSpfhiMv6swD/P9YezC?=
 =?us-ascii?Q?FlRSYDwX8NokAPUYRMLKtOTYAoGHynknai4XZelSAPndZw9mtH1joS2Gx1ez?=
 =?us-ascii?Q?7nQEWkCf0SCdzheYZ0shKuH/YyBE0E/D3dfMEehK8pUrXsOCGHsPcqGf/Gcl?=
 =?us-ascii?Q?L7wIB4rv3qIiQDdUpj1Aiz7Ip0JS4wlNX3943AKC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c6794d-d414-459d-8f5e-08daad21df15
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:50:21.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBknffGKY3gwLAqeK4a8Xw6/IDJhWqHvA75aFuJq26oncLLQQUdYkAa7qkc5tJj4PtQsWkWd9ZulXTVH7ioX2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-13 at 15:27:30 +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 13, 2022 at 3:10 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On 2022-10-13 at 14:50:28 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 68b99e94a4a2 ("thermal: intel_powerclamp: Use get_cpu() instead
> > > of smp_processor_id() to avoid crash") fixed an issue related to using
> > > smp_processor_id() in preemptible context by replacing it with a pair
> > > of get_cpu()/put_cpu(), but what is needed there really is any online
> > > CPU and not necessarily the one currently running the code.  Arguably,
> > > getting the one that's running the code in there is confusing.
> > >
> > > For this reason, simply give the control CPU role to the first online
> > > one which automatically will be CPU0 if it is online, so one check
> > > can be dropped from the code for an added benefit.
> > >
> > > Link: https://lore.kernel.org/linux-pm/20221011113646.GA12080@duo.ucw.cz/
> > > Fixes: 68b99e94a4a2 ("thermal: intel_powerclamp: Use get_cpu() instead of smp_processor_id() to avoid crash")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/thermal/intel/intel_powerclamp.c |    6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > Index: linux-pm/drivers/thermal/intel/intel_powerclamp.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/thermal/intel/intel_powerclamp.c
> > > +++ linux-pm/drivers/thermal/intel/intel_powerclamp.c
> > > @@ -516,11 +516,7 @@ static int start_power_clamp(void)
> > >       cpus_read_lock();
> > >
> > >       /* prefer BSP */
> > Above comment line is not true any more, might delete it as well?
> 
> Well, why not?  If CPU0 is the BSP, it is still preferred as before.
>
I see. Got it.

thanks,
Chenyu 
> > Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> 
> Thanks!
> 
> > > -     control_cpu = 0;
> > > -     if (!cpu_online(control_cpu)) {
> > > -             control_cpu = get_cpu();
> > > -             put_cpu();
> > > -     }
> > > +     control_cpu = cpumask_first(cpu_online_mask);
> > >
> > >       clamping = true;
> > >       schedule_delayed_work(&poll_pkg_cstate_work, 0);
> > >
> > >
> > >
