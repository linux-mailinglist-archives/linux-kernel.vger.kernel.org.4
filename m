Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83214652C18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 05:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiLUEVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 23:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiLUEVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 23:21:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146D15731
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671596507; x=1703132507;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rv5ukB4xhlU32MLjFsLWxiG77cFmqOMucMOwxaO8Tmg=;
  b=mM1cw6EZPfz3AqK1uCrtv8S9qEmHTyci6sHcD68KQf8c6dOV8MsUTt4y
   4gdVNoA+PlzoGp6cqG/RVEYFh01aVc2SR9jAsc4Sp3WS4lxIaZR9UOaQr
   sWnDnCp0PhtWkeee5SI3bjbNalfXhDuLkAPcsyO4jlVNDuAIPtutmox6G
   Bp39e3bOuvD4+8n+AV/KB6mCHsNzLMEUlObTM3qOWArGoKxgkfBNBCeoA
   9NSU11HI5lthDbVr6HBTcqxH1SgubesnLaXbgN5mgj86UP5UVCD6Jlctn
   hEfw0yF7kgtVEbKxuHhj72VFxfeJu9DSOKbYIZCeKI8adTDrS7QbShx1r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="317417953"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="317417953"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 20:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="628981086"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="628981086"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2022 20:21:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 20:21:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 20:21:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 20:21:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 20:21:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRRNxOynN/g3j3P3IfqLcN8SpsUqSK0PeHzkXRDE/qQMcI0g5sYhHyXbaakSeMgTsORIktPGtRj8bQfBGLpISOV4F4gJtheAF4k4SBo8vbawSh1N/ZD17/lXrd4AbY2dxayF4CqmVV2KRPDzb8zqD1o9+XpCymMEgziZqMqkTGKBUgw4GawqZL6yW5xjJnhzBU12pn9mdY3Dj65d1FmLS8UXgRs1uC5srDJhLeNEa54/MyCDMY1jc962y6dVS8wVUAx3veImGuSPKF6R8OYHJ3XqSbn2AAyMMRN0CLXDYfvMdT/xvroILj7ZJ7/9P8bgqjUHZRUZCxo9OF14FiAszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAQkUZmBWDeFqrYF9vES6u2pAcGwfjXjjl3DCr4sMzA=;
 b=MYJxGpyWhicIJUSx4Omftc/rNcakEAsaC99L1OqtnTnOm6aqNcMgkcHLk3KD6L1NwFSApOOJrGoj3jixgLhxo9hPo0K7tGvbab6MBz6l46UhJnl//Yj+t8o1sEosm2tlcRcVh+iOHdrTyrC1lcUu8ssOAqr3RmTJJhpARPO87u13pHKrhOCRnYxGQJNBbSKQ3+QFbRNGZXQIwOLormJe2Mi3+wlN1nJeylPKIPK7JRR735gW3Q8XIyC2LOORfjHgxyHNRbW1Snz6d80OVUaW3sKk7rkMEhG1dRC+aOvtuMkaixnIQ+t1EAWpN6eDrMND4DKgx2ELH4y7hBmDMFphSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 04:21:43 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 04:21:43 +0000
Date:   Wed, 21 Dec 2022 12:21:18 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
CC:     <linux-kernel@vger.kernel.org>, Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        <kernel-team@android.com>, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH RFC 2/3] locktorture: Allow non-rtmutex lock types to be
 boosted
Message-ID: <Y6KJvtFBi7vLYEXa@chenyu5-mobl1>
References: <20221123012104.3317665-1-joel@joelfernandes.org>
 <20221123012104.3317665-3-joel@joelfernandes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221123012104.3317665-3-joel@joelfernandes.org>
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS0PR11MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 68618826-9126-488d-44c3-08dae30add6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4NdlYqGQSKqNDgstxcIZRvJqDxYOk8FmKXswg+HDMvCP1iVjXkm51WcmM6LGn5CWxpEQMlwNPfprjM/jcOg8z/qpvMumaQVY2hWiRGmuUBW9ubrzVakv0S+xlas7WWH3uU0BpNkZdXtHxjFSNI2AjBxTsqHJw59cvrEV2Hsz+xUbbM9o/J0Cr6xzt6XyrCIWDofAxOK1Jrw/qhu4gSriLrP8EU5CdqjSkGYBkFDiCqWdLfSh179nv37Q2dsJMj8ccDyATp6xLDQw75R2vYcEk0fbk8jZn8GFrGU6gXxMXrBoeFOSsG3MZF8XZZMiiqk+d25mgDrjETeRJP/Vt3xEUguJSaHAn0xhtXUIRipxA3qwdUcEVlIEG7RRVp5fjsq470hHJ82TfqKtQc/ErqrDn4y1WkjhR3CZ0Ei6z1At1BvXejK0tYUDi48+1MP+VdBeE3sU9CWN2XFMajsX1vDELtJmgtJF536J0zrj6uBMmDtauFMN3dlcdVs50U5bHcvX6kdle7U7CnUetRb1LlV2g9Ls3IGHuKqvjbsEhOOFaV5C4BLR8oNOpZslD4wEPq3whTZS3btFEM/C+Q6Kl02j2ZBVwJ5YCihIISZu39awgSaJ2MtNGeEpk/hdmd54IGn81wB90iGyXFCBxaLZ1rS7y+fq+M0u4wYmn+FO9NxXxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(66946007)(66556008)(86362001)(66476007)(4326008)(8676002)(316002)(5660300002)(8936002)(41300700001)(186003)(6666004)(9686003)(6512007)(33716001)(6506007)(83380400001)(53546011)(26005)(54906003)(6486002)(6916009)(82960400001)(966005)(38100700002)(478600001)(4001150100001)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knBOHk2vOkxve/SRgBbEFuAmlzDge2KG88jm5KeclcN1osgX66mFxSGDbL2x?=
 =?us-ascii?Q?p3Xd0u/96p/B4T0G3WFmUKp6A05rXgoUQyjGn1gSWIstau0tjOw1x1kOG4gP?=
 =?us-ascii?Q?pb5k0T5XF67ovqwhJ3fnfCRZS8jAw9GB0IpL0u7qPx8CZYqaopXImMAtSCYk?=
 =?us-ascii?Q?i7R76d7k9o3FWBR78VDx1t6Az667gkWc6fpPwWRHSGrmnxMEyLTi/cLpHjWv?=
 =?us-ascii?Q?wWWECSDqiYZBMbw4hXbknVXFkFGK+fJCNm58wDC6t+SCEJUjH35K8Y+WTFCs?=
 =?us-ascii?Q?xOeZnAU0wm+4AWU1IsMIE9PljTorKLyNYZ71H1BujpLf2n4F8odW6Etb6r4K?=
 =?us-ascii?Q?ctPaoSqV9gqGl4G7BBHAL1HN6BurHNY8iOkwyD9EWEETpe8hKky3CEPVWd+Q?=
 =?us-ascii?Q?9n+Z96zLMO2Iah56jqxv4BQo2TnSE2f/MZ1TZy+aVE2J8/gAfSeSImqSgYeo?=
 =?us-ascii?Q?NjDw+pXcDNyB4A7lk5rT4L4/6cwLNcQjN9FZ3vywjdJrKSG5LeZSLRd/XOgd?=
 =?us-ascii?Q?om0VzuZtST4DTDhVntJWo9mj+ZxewskMFAwFRDLhOj0vLYs82xkmYhZIXqNP?=
 =?us-ascii?Q?xgEzGb/0hFZCGb14iBtl3aC8QQWSkE+bAfgklOfOAnmJ6HuxP8ABmgP4UGOw?=
 =?us-ascii?Q?t1NqSmmZfh23tgNJXOa7kfQ94+SwmsjPXniheEuoi2B6Bnfz9ta00oK05u2l?=
 =?us-ascii?Q?1yhYTBdP92ZVd1aVVAULl4FWe9yQLApQ6XZWq3D084AeGcaijqgMYjaFzVIW?=
 =?us-ascii?Q?2J2504ht04kylCGoXvP8yT/YUEXbgEk5JZE46hnHFI3qxMbaks/IvB+b2XgD?=
 =?us-ascii?Q?YXviy8Ki65CKIBlHwRGhZ9tKa6nmDlDy3t0Na7OTMLYTsZSvfTmjq5uD6Jts?=
 =?us-ascii?Q?/vEKKjNdS0OspxbswtKjejGn5VWA8BTQmOEPi3GDv9UIIn8MwpHFVtIKwH2S?=
 =?us-ascii?Q?OOeg7lY5/PNpyW6K1nKnAnknllxnk/C5iFKUDjs+VzF3L/MUFIP2dpTPaSnZ?=
 =?us-ascii?Q?3jAb6/DYVr7WSJ1x/zO+HLpKDhIKTjbT7Zu1IjDZVICSUgrwBxysT5Gj66CM?=
 =?us-ascii?Q?oldJH5RmSl1fIuE1IPpt8nbVDitQHo0vfOyXKtgYUYqJKvzP5b+BofLgFK5K?=
 =?us-ascii?Q?vCV8U0V8a76JwjrNbMsvkMcI7N3VC4DbnxX+JfnSoHdr8tkdqEbZqX4cl847?=
 =?us-ascii?Q?XUt+FisZT417432cQuv0kkQwfKxSSL95mHayHLzFLl2K2IH5POL//N6JX/kM?=
 =?us-ascii?Q?NtmEiBw1vH5OmnkCvZ+Id4fJlKdQoTRswRq0uqlkJXRqMqcpwOnab3sy4p8l?=
 =?us-ascii?Q?25MxEVutmDuw7oY1dBd/WwtJQXKrdJUb0iJCgyhLNm5sxCJZkhWtnTIyRAFB?=
 =?us-ascii?Q?qq1kOj0Slt+noo5pPwEM2sywVpQuw+jmxm5ow38FtVGwuLN8yDiD0s1RhBUN?=
 =?us-ascii?Q?hUQJqDFf1YNFaqhbHd5ny1hAHOgeNv8LzfzZKLGhEmZkshu7J1nZI1WOBtQw?=
 =?us-ascii?Q?en8W7Qwz7uBbPzFnj8jB/9EPrJPIVnOtU9mn3X+LW4bWnP4BjxO6fzqAmnzy?=
 =?us-ascii?Q?pWmFWfhdXxiUiE3LSoEzQ1fd5K68OXoDPi3K2vNL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68618826-9126-488d-44c3-08dae30add6f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 04:21:43.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqeN77i55S14YlXtOzf0waT3N111I/tY+5lmH+bM+3yGtjhBAVRHW+dSGe2fKhbwJnjXSZRjUKWvwcgzzXxWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8230
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-23 at 01:21:03 +0000, Joel Fernandes (Google) wrote:
> Currently RT boosting is only done for rtmutex_lock, however with proxy
> execution, we also have the mutex_lock participating in priorities. To
> exercise the testing better, add RT boosting to other lock testing types
> as well, using a new knob (rt_boost).
> 
> Tested with boot parameters:
> locktorture.torture_type=mutex_lock
> locktorture.onoff_interval=1
> locktorture.nwriters_stress=8
> locktorture.stutter=0
> locktorture.rt_boost=1
> locktorture.rt_boost_factor=1
> locktorture.nlocks=3
> 
> For the rtmutex test, rt_boost is always enabled even if disabling is
> requested.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
I have tested this patch set based on
https://lore.kernel.org/lkml/20221003214501.2050087-1-connoro@google.com/
using:
insmod locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=1 stutter=0 nlocks=3
on a dual sockets with 228 CPUs. So far I did not find any error/warning in the past
8 hours.

I'm trying to ramp up what scenario PE would bring benefit to. For mutex_lock(), would
it benefit frequent cgroup hierarchy update because of global cgroup_mutex contention?
But in theory the cgroup hierarchy update would be quite rare in daily usage?

Besides, according to
https://lore.kernel.org/lkml/20221003214501.2050087-1-connoro@google.com/
PE could also mitigate cgroup 'priority inversion':
"One notable scenario arises when cpu cgroups
are used to throttle less important background tasks. Priority inversion
can occur when an "important" unthrottled task blocks on a mutex held by
an "unimportant" task whose CPU time is constrained using cpu
shares. The result is higher worst case latencies for the unthrottled
task." Is it applicable to add cgroup based(different shares) mutex_lock contention
in locktorture?

BTW, can we also expose the rt_boost/rt_boost_factor in lock_torture_print_module_parms()?

thanks,
Chenyu
