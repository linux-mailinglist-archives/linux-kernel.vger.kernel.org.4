Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F51652C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 05:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLUE3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 23:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUE3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 23:29:05 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE13F599
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671596943; x=1703132943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rrg6ZirKAJKzzWyHqSEHzbDEpTTNdv3aQvkob1KWQVk=;
  b=nXAdaX6txklFHvbd3rPBqlxnR7x7Vx3zFekNRtD6Moxd6aSKkiesfhVK
   sYYeIIzmM8tXFM1AqnO+ckhvNjhMTSrrexpV1dOcj/1kOAHrmst5Od2Pl
   onLcRpenN9KDpDIt46cRFLkoZAKcVdUAefVWBtTAKBaC59Zj2mnPTMnDC
   LwNDDNgz0DWbgY4ZHLxTTYWyxIetwfvv6yUVQ8ib5J+yvfc40sebbbHs2
   2phXNaX6qUC7RvgR236XMWXzzJJVj8Jbk7m24p2EEbCOUoNI26PlxmFep
   bqyguGZrWa/zkE8ldoF7TieqhvYPArY+swQoOzV6+6XpnLjmFR+/m6tWR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="382010119"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="382010119"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 20:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="714684195"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="714684195"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2022 20:29:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 20:29:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 20:29:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 20:29:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 20:29:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5Hdnn/lMhNRJnMz9XN5Qr5G/q7A3cAzHE6J+4zwqiLVZcA9QpC4TcVWU+usjI4TeqU0eperWZcdCRHx2QEJfXPzXBctobfwi2NC87z9FfiDkn5sTbls/iN4XUj+A7wazqH0vLc8FrGEz9Dj0x1mZ9/XKFP7W5p2YoHxIw/jP9vWTccmQHSTtYTlmlSTOxhdTKTrixu2WVwRPmPZIHYhS5CceBSW7HB3a5csa752QTJJGnMc58zT1VqTxcfBFv0ZuLLUqgplCCqOM9AqA3hRKR3HioMnnkgFrUfNMzRAudk1BDU0hJq/YrD7Oa0fjLaFHrNguInZRYgCL7pjU9DyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNlotSaugcvfkNFioNY0OVf0EwrlruOTd2bPWJcknts=;
 b=Oz/91+uYLPSUrP2MMo4hU00ROmEIWZujAfWZxkatgvZrHazgfydPO4pUD25EscyBjp/rp5vgZIIXq8EH/rXHyicS7d+LOxwabJRuLT8VfEu0hnevxd69i14spZ+Nowo1LsT44L+bmfSRuPPfG80sKO9YqysFpv8oksg/rmiZ4TTdkhbOo0TqFlh3TcNwZ6vhx8sZfwWVSENZ2RE4YaHfCBtnY9VsjQnnKKKUaemiauP/QMsxRXbo4BQmLRkS7NpueKP/UehNtBZ4I2xLPOcVI6SM1zVFQg5XGYqLS3RaiAMsitnZRE7fJG5kKN5n/unlgBLVn9PviMEDDXyWn1g3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 04:28:58 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 04:28:58 +0000
Date:   Wed, 21 Dec 2022 12:28:39 +0800
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
Subject: Re: [PATCH RFC 3/3] locktorture: Make the rt_boost factor a tunable
Message-ID: <Y6KLd0X0aJxxyNLJ@chenyu5-mobl1>
References: <20221123012104.3317665-1-joel@joelfernandes.org>
 <20221123012104.3317665-4-joel@joelfernandes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221123012104.3317665-4-joel@joelfernandes.org>
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA1PR11MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 623b4167-5ba2-449c-85ea-08dae30be0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owOwxwjVHiQYojkZwoSqwL7CykjMNuwp2FI//tUeDozbdfUjtWp79jVeJfhwoOsEt6wpb9BJ8J6wHeKa/gLMLa2Z3idtl6dAUip+B4x9f45d8upUmir+VjB+zx2/aOXegEEW8iI6fm4U1LFoni8BQKRecAGecg/jayT4U5TQ56YZmYETtnCGTkO7MsCNHa6Cc7WgWHxoWKxPkS6Des0VT8byIBNxuzNbSmjFz1GBDZQHi67y+wS+qo45Qb3dP6QTMhUH2NlwGdg3n6AP3Eq+oPKy1Hp0dk7IRzRolFW8J3V5tbsBDl/I17iFMymbyJdP5Uh+hj637IN4HjofQTnMFNOBKz1YdCDr9csD7G2NpMGh+zOVtUnH9xHV8GV0pUTHqaC1e/1OrP354RrVRdxo3cvOD149Pp/pdU0LYnv14FDQTU+9Mw1cdRZvoUM1ZsFr2aFtQUzmCGKm4+hpncFS19yp4CX1VwTLiV+r0cDMOxl73B39HhWth1a3ST+Tt8gwD47ExqnEaP+aD4YpEfpTowhaULjFVUqx6zecQ09sSm5dy6K9knPYCjWRCuIfTduM4xPFuBbkEVZY1rFitf14P4hiJgf0ydcwjor4gSnU+yRny4U7ERpoIfrQV8iITclWWBuUZWOZTMRJiy4OZBYbmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(7416002)(33716001)(53546011)(54906003)(6916009)(316002)(478600001)(6506007)(82960400001)(6486002)(38100700002)(8676002)(66476007)(4326008)(86362001)(66946007)(66556008)(83380400001)(5660300002)(6666004)(8936002)(4001150100001)(2906002)(9686003)(41300700001)(186003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4szjev4a54g/rvlZQZhZXSef2d/b1wL/Zm87+IrjbSVE/LIpv6fRRgO7jpxt?=
 =?us-ascii?Q?0xj9VxB8dodWQHXVD7M74F9lLBAn3p4e+MmUkaya5LV9errBE8Nj6KGWGVha?=
 =?us-ascii?Q?XmdVMBEP6eCn41iiNNEmvvLfIfgaIyS1xCm3sC7vivofAqO0O59/czyovD1B?=
 =?us-ascii?Q?HdvbBCQSu2hoOLSCIEq5Eef0GisJXUFwFbB743XvfouXE3Bi9iIUBUIQLm6r?=
 =?us-ascii?Q?qjMymWZhpe4DFgFwZP44ZEKgbzV6ZS8UQ55Ze2zazcx1g/h+Y2rFzowr0QFs?=
 =?us-ascii?Q?B5mHZaCl0wQHGoAXZhO/a5HzteW9OKxD5r5i3gLFGX7r4LMr+XOSJj5OHjtd?=
 =?us-ascii?Q?5cKP5hfnJvSw9wikDGkhJY9bUREv/LWcs+df8AFaOmb0NgD3qOwvBiiQQhKS?=
 =?us-ascii?Q?acfCKs5AxKhem0f8eG5pv4Hdd03CIMhBdP6ZxHZu7jJIK86byAok72SVt85u?=
 =?us-ascii?Q?BSS1xEKL7jsDoXF7Z2WAxYwzy4gKRpIP95hxcG7dx6RbDxqOz4jfjOULMO7A?=
 =?us-ascii?Q?0EpnQlorRZNBtqvUStaEyX44l10rsOmJj6p9ucyh4T526mVaJv9OGyGh02i/?=
 =?us-ascii?Q?SJt0N77w6oxnvxEjBa60gzB96RWYJFk3r0EKeiEF7SEAsIMsB3PsQ8aW1GZi?=
 =?us-ascii?Q?b8dSi83evkHAJUdRDHqOXRfM2f8q3saHDE56Y28IApcZaA3lmWaioL//TaUx?=
 =?us-ascii?Q?yP6KSwGrcyEQRiIEEKWEpWese+95/QoOHfh6DIOudlLlmjyeRGNkbjMqdimz?=
 =?us-ascii?Q?ICsUZtGOGDBcyhMeqnO0Rmhf8FEET8ynMpLPm+6URf2+XeKO8tsUznr+cEKr?=
 =?us-ascii?Q?bk3XiOmMYn224mQNaZSytBpgT3Xn2vxKon+zWVWRTUJkapx5YaTamhdXHDVy?=
 =?us-ascii?Q?ygramhkNFv8VF/Wab30Spf8kMijT0/2ynqaEKE8otKeGXkglrES8JC7DIel0?=
 =?us-ascii?Q?NnA6Cq0rpyW+2pR0593mh+WmyLyRnfauLnitKnIHolLCce1+WPX+wjJIkKQJ?=
 =?us-ascii?Q?jYNI/zWhjZnlIyiyibkTQNv2iQwMNOmqWyxfCxy0MxIyorl5/SRI3g9CApKZ?=
 =?us-ascii?Q?bT3fCKBzsfnW9OKGeyMi7isLJCHhflOqKcFKyoD5y55mfEFt5mHh3mlikqf8?=
 =?us-ascii?Q?DqcIzNfiCsggvrXGGwHi+AIwVI+GRwSrecrCAaPrIYnPejUn4v8LIm8xpf3C?=
 =?us-ascii?Q?QhZoKx1WO0Sxu7Hq8ZwiNhUHEJX47LIVZtsIMkHUgwzp0/jTZynCl/HgGp0/?=
 =?us-ascii?Q?JCt+VJ5pgWSGBSqwBJVJiOuLqSAvHOUa//xdp4TDPyrMmGqpqFqSqih0wc7F?=
 =?us-ascii?Q?01zpYfU2j1ZL8hrjhAkinKEhQVe/ilukci2ic6CD3XwXj8ABKwRfwrxC41P6?=
 =?us-ascii?Q?FMq4YjnLBtD/XeHWUbEJfcrXU9MrhVj0O6avJg/4OdwoQVBQom4RljlPrtQh?=
 =?us-ascii?Q?ibzcacceuSTd6e+VQr2WyQ9thwdQ68GXvICZ1n4On8nvSQk7tG2rxkV+WKTs?=
 =?us-ascii?Q?xEm8WJoJMTKxwwoyTNlkTyA3mdx2SiPje8Mrbww5hCggEUTIyoHsxQLI9kJj?=
 =?us-ascii?Q?ZAAsY2AXZxRKD5PbQOCcfHQlDMv6fzqtN8UH7XSq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 623b4167-5ba2-449c-85ea-08dae30be0a6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 04:28:58.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3GNN6SJpJ2NbGUVQQkNOn92lLiyeJNsXNMsKT1pf6o1NimgwMRQBJjK5UFDbQahEVwTl9yb+xCxnkGaawGJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-23 at 01:21:04 +0000, Joel Fernandes (Google) wrote:
> The rt boosting in locktorture has a factor variable large enough that
> boosting only happens once every minute or so. Add a tunable to educe
> the factor so that boosting happens more often, to test paths and arrive
> at failure modes earlier. With this change, I can set the factor to
> like 50 and have the boosting happens every 10 seconds or so.
> 
> Tested with boot parameters:
> locktorture.torture_type=mutex_lock
> locktorture.onoff_interval=1
> locktorture.nwriters_stress=8
> locktorture.stutter=0
> locktorture.rt_boost=1
> locktorture.rt_boost_factor=50
> locktorture.nlocks=3
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/locking/locktorture.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 5a388ac96a9b..e4529c2166e9 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -47,6 +47,7 @@ torture_param(int, stat_interval, 60,
>  	     "Number of seconds between stats printk()s");
>  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
>  torture_param(int, rt_boost, 0, "Perform an rt-boost from the writer, always 1 for rtmutex_lock");
> +torture_param(int, rt_boost_factor, 50000, "A factor determining how often rt-boost happens");
>  torture_param(int, verbose, 1,
>  	     "Enable verbose debugging printk()s");
>  torture_param(int, nlocks, 1,
> @@ -132,15 +133,15 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
>  
>  static void torture_rt_boost(struct torture_random_state *trsp)
>  {
> -	const unsigned int factor = 50000; /* yes, quite arbitrary */
> +	const unsigned int factor = rt_boost_factor; /* yes, quite arbitrary */
>  
>  	if (!rt_boost)
>  		return;
>  
>  	if (!rt_task(current)) {
>  		/*
> -		 * Boost priority once every ~50k operations. When the
> -		 * task tries to take the lock, the rtmutex it will account
> +		 * Boost priority once every rt_boost_factor operations. When
> +		 * the task tries to take the lock, the rtmutex it will account
>  		 * for the new priority, and do any corresponding pi-dance.
>  		 */
>  		if (trsp && !(torture_random(trsp) %
> @@ -150,8 +151,9 @@ static void torture_rt_boost(struct torture_random_state *trsp)
>  			return;
>  	} else {
>  		/*
> -		 * The task will remain boosted for another ~500k operations,
> -		 * then restored back to its original prio, and so forth.
> +		 * The task will remain boosted for another 10*rt_boost_factor
Maybe I understand incorrectly, the code is
cxt.nrealwriters_stress * factor * 2, should it be 2 rather than 10?
May I know where the 10 comes from?

thanks,
Chenyu
