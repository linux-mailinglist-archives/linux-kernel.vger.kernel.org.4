Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682EA7046E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjEPHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEPHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:50:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8835BB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684223429; x=1715759429;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uObVFa7fQsFHrecR6JkCzACfXzIcDpOoPZP4f6Q7tmc=;
  b=fG4jDCd+oRwsO9aXPzHL72563Cbt4HLhWFWbFYSCXMvzvFa71DnUf8aI
   o8isYMq4pztUh6KH/OLaBJduVQVsnOSLmqQUekYf+j8J5RqNK3TR5c5VP
   FydMcJ4FKopLKD4E1dpD82+AJPbsgg75wefDzLIqLrb8sK+RPUqcrO49A
   MpyCG8Ke9GJ4Auwyn4tDoyQ++BBnT+hua89AyiEKe+BTT3Hj6Rd9tTkGN
   X65hio635oQ+yymCT84ZHa0GsNdodZbC2nKuiM8JJmPsWAHBGjncNNXoO
   0K/pRov56GXM/oZMgEs+eFgocLuUkVd/nnEC5p2G50ueNj+aVGNpIFeF/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="414817869"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="414817869"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 00:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731898502"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731898502"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 16 May 2023 00:50:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 00:50:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 00:50:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 00:50:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 00:50:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9+jNVZuvFp2zXJ9lfcAaxZFMiepNbShadwPoLal8CVUxYo3AhqE6D+qjzSyh5f8EaHnwJSp+Ia+DuIIviH4XtQBv9jgOoXTPtNbSPxBQjmToUcT457QL7KRDTQS+u/Fl+zgw79qHtyHhdTmrq6Yk9sQnr7A0TeV6QNcOJZdIpa1DWaCL91lvYifbvNGgUMDhWvwoEaOKi6srMFJAxNt0PXz4QDbMkuPJ1z+6gBiHd6v/WgcAPeKHNWanznm+blVf5u7S14CCxdbHzIJMDCl+JelcVkmzNZ9XOOdVPX+95lJ0o6+u6IJZ1WWaXjuum8YpPqotwxB/pOsLMXBj9+zSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY+DAB5MiSXRxuXhhi7XwXVf7yjY/ftqcXWn7mXEYlY=;
 b=Ge4hPVOAO0jzyCY/76Khv7M41YzUCwYpBzpqhbrBZ9j/YVFbuLA2gUlWuyJGo4Xnww711oZFsFb6jrovLOb4bn1wtXBDSxHBxH6XnW58cBFsgMsobmLHfYPIjQxo/qk58XgcCcAqiQOS8FHnOTJcn0womG1tgrC+O6V6BBoFOkV+a1PAyHrNY8YLT9UC3F6Ty168eVGdi58YR/e3zr+1teVgR9AMVXnjI5lZkTsco1J62jOT7jyXpE2OnKyFg1CHLOaZPlYa4iy7J0E0JpRNqO8s/m2oT4PAO2uFwD+DEFLR/TkKGBo2EcH+TsFbqpjBQr0+rMqhx4vuAFi29veoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Tue, 16 May
 2023 07:50:24 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::eebf:2b53:89e9:4a09]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::eebf:2b53:89e9:4a09%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 07:50:24 +0000
Date:   Tue, 16 May 2023 15:50:11 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230516075011.GA780@ziqianlu-desk2>
References: <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230412120736.GD628377@hirez.programming.kicks-ass.net>
 <20230420205201.36fphk5g3aolryjh@parnassus.localdomain>
 <20230421150559.GA162558@ziqianlu-desk2>
 <dfkllxtzchrxeqykzyk24ppgwxbztk6rbbb6xyizpbhg7ctibi@fhk77qxo7yia>
 <20230504102746.GA137823@ziqianlu-desk2>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504102746.GA137823@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d433565-731c-4d0e-d805-08db55e23498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWABfc0f3n19xjVPnM8Lg89Q0Qoz1KajH1DuPYAKiYURMJN/MT8I91/99fNAQJ2ePy6mVZfWyn3k5fs1+Hy6u3wVzwPym32ESBRjyvDnCIMT5NxS9sGvFe8O0WfuZOvEyXBPhCpScuWzLp/leFwC5HjgJtF6d0aNHiw32KxiUcSCRNmbs8JjiFFJSmUolLYKX/vCMpV8m4jBWseV20xL1CudzqzpMuoewzbGUMsqNVZYqcrMce1OD6iNIQaSaTUi10F99TOam9esprpH1tCj3USmQJleKjZ1+Sr2/fWLdpcpe+P4DnViWJr3UpgAO2IxwUShvjQHLIXsD/N0Sne30fRr3Or709LU2hISX6exAiVpdwa93V1zwQAUDsFbMl+02bvbTX3QPMfHl5TjRNxqEuSXzQ2PRl72yA44ic68vNNZiTsC5GzPwN/XhK3MlRS597h4YOWhgxED0SgClrtuB+pTbq8iF7pcPKd6FZwvz3rShNIRigKyvgqefwU0O7vpDSVZPt4sS9umYZkL1aYUq4yXyCHO5vH+ozEl1fKL2wXVC5Sfk/fUEFGm9sv9C8Aosa0S18cu0ikmBZOMbGdVNMrWzh3k5l1iOcjhMCjHD/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(66556008)(54906003)(4326008)(478600001)(66946007)(66476007)(6916009)(186003)(6486002)(316002)(8676002)(33716001)(8936002)(2906002)(82960400001)(44832011)(41300700001)(1076003)(7416002)(26005)(5660300002)(6666004)(86362001)(33656002)(83380400001)(38100700002)(9686003)(6506007)(6512007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SSczia7LDjt+PFv/GRB1WmyClZf+LViYxyhb4g3wVTI/j8lunc7ZH+oJL1?=
 =?iso-8859-1?Q?lDAUsOFEteVJnOIQqBfetJHb6oZk0IXzyjC6kr5789L763K84ZgvnKffjW?=
 =?iso-8859-1?Q?FTU9SrwR9NGK4QKyuTNWX8BlP7XFppr7c7KMFp1x7Ks0fzUXtPvQh3tcfA?=
 =?iso-8859-1?Q?MUE+xl9JDVl+YXWmH4EGUuSlodwGldYzLCcK/OhCm+0PbkqSKDADXdK1+H?=
 =?iso-8859-1?Q?zm7k3BYHUFAnFVT1FksvuS/GklLdqR8CtaPMSNabawiw9O9iEA2+7dQOx8?=
 =?iso-8859-1?Q?cstvvaNy0Kn+GY7NSKuH2ZYbbGgI+tMp7alB1vXp8xw7rAzk9tlmS/+MHe?=
 =?iso-8859-1?Q?JHkJC7YACf67VhwOXLFEd0yhA64jdIkpvXdCT5cHinLBltw2v/6Y/natar?=
 =?iso-8859-1?Q?Jb3Bza0MbscJgoxl+DoORJN3etGUZL0QWjVV2JAz+/GEx6532jbSyisaA7?=
 =?iso-8859-1?Q?Z+HZ5+atGHcFRuVtkYZGFx+rikuMNRn5RRlX0inBm6yU8GxWBb126l1DvR?=
 =?iso-8859-1?Q?DDqb8clje0sUT7yDlTbJQYzsiWF+u4ZWKaGWLgnXnF+wWQpRmOC6Q5kqrT?=
 =?iso-8859-1?Q?8hWvHa8sBctjXZ++NW214PVWPzBJ7TlGxdqf6zDqpVuMK1wghBYJ6Cu9GS?=
 =?iso-8859-1?Q?bm/ZJ5NTS72YgMpONWKgfGxns2a5UGkgU6OXIVy3R7yQ5Nh4A1En5rSLti?=
 =?iso-8859-1?Q?45kzMWnRBtfOWvCunnBKSxKMbMQ++eXDziOX3yp2KDkuUhSctDza6MPjTB?=
 =?iso-8859-1?Q?jpDhahIQ/z5RsJEm/rOtKDsmfhtVWxrFoK0+OeHiI97+QzfUlHAKt4e2KL?=
 =?iso-8859-1?Q?bYADOJBk+uAnAQLnrCt/kxLgau31AXsyCdzuQYtPuT1NO8TrJk6wGLpRCC?=
 =?iso-8859-1?Q?NI+Fm2rw9G9mgTpw5zxNy6nOoQVApogmMXER06Pc2sP1OTLPWAuFcST8Hd?=
 =?iso-8859-1?Q?yscmr2v3v95fJhbXQOKyFRdZLHdhR4pBm/RWYkfN8JMJa0By6ofpSDmfD3?=
 =?iso-8859-1?Q?5BCogWwdBuyaMgFGdoaNi0LQ2/BtCBnhG5Y2dusWqQAmicwYCtXHJogeP1?=
 =?iso-8859-1?Q?rzHRCiqyfcMq4/EtLGpfYyKCcMbJhgKYAMSRyUv5fGMoms7iWif1RQZB2J?=
 =?iso-8859-1?Q?PeDSltVVoUdxXqNGm2yFmeYVdRJ4UCKe1yIV1x0CcgmBXULmZEkZLOlKnR?=
 =?iso-8859-1?Q?FepDtzgGr/6vEpKRMpgA6fSZ4TMfNWP9ET6vyo7TEwkfhW/yf/MI+QxiUD?=
 =?iso-8859-1?Q?qVa2CFvwHJVvt1R9clFuXfB4Lvo7+WiA8+L5sSAdTuwJo9G6S51TabjZs1?=
 =?iso-8859-1?Q?N5Bq0O+m+dJG6WGfPu6dfrlFlQPQPsxxWiExVf62ksj4m/+vyNgcIuU3QI?=
 =?iso-8859-1?Q?4eftkVIUjs31zf+dKs/+rL6ayFpgRw/3LqBipaQHMyYkhIBq5PyM/Psd+e?=
 =?iso-8859-1?Q?qvMgGGnJenjdmJsoKu1MWp+gssLHZxsLCetg0lSkvIZ9i6r58E8UAHYFSx?=
 =?iso-8859-1?Q?E5xQ3Xd3W4fHiy2zpPRjRtK/qzyZKKlP67ZvzKiCfPV191CbLTfvjpwWzi?=
 =?iso-8859-1?Q?C3xdxay2WlircVjCcB6W9L+WrReaOmtLRgQ669Zdgd2FAtkF/UqCGoDDVN?=
 =?iso-8859-1?Q?tK6a20RDNtclNoQ0BfXfg1WcjY19hTMDvF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d433565-731c-4d0e-d805-08db55e23498
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 07:50:24.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3q8i1e0jZZLOd7K6dJnVbWMRcxugvQ7CeUvgFEbf4UpjMxXX8Q1iA8c+Yn79dKO24bOFDnsweoijoelZ1aHIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 06:27:46PM +0800, Aaron Lu wrote:
> Base on my current understanding, the summary is:
> - Running this workload with nr_thread=224 on SPR, the ingress queue
>   will overflow and that will slow things down. This patch helps
>   performance mainly because it transform the "many cpus accessing the
>   same cacheline" scenario to "many cpus accessing two cachelines" and
>   that can reduce the likelyhood of ingress queue overflow and thus,
>   helps performance;
> - On Icelake with high nr_threads but not too high that would cause
>   100% cpu utilization, the two functions' cost will drop a little but
>   performance did not improve(it actually regressed a little);
> - On SPR when there is no ingress queue overflow, it's similar to
>   Icelake: the two functions' cost will drop but performance did not
>   improve.

More results when running hackbench and netperf on Sapphire Rapids as
well as on 2 sockets Icelake and 2 sockets Cascade Lake.

The summary is:
- on SPR, hackbench time reduced ~8% and netperf(UDP_RR/nr_thread=100%)
  performance increased ~50%;
- on Icelake, performance regressed about 1%-2% for postgres_sysbench
  and hackbench, netperf has no performance change;
- on Cascade Lake, netperf/UDP_RR/nr_thread=50% sees performance drop
  ~3%; others have no performance change.

Together with results kindly collected by Daniel, it looks this patch
helps most for SPR while for other machines, it either is flat or
regressed 1%-3% for some workloads. With these results, I'm thinking an
alternative solution to reduce the cost of accessing tg->load_avg.

There are two main reasons to access tg->load_avg. One is driven by
pelt decay, which has a fixed frequency and is not a concern; the other
is by enqueue_entity/dequeue_entity triggered by task migration. The
number of migrations can be unbound so the access to tg->load_avg can
be huge due to this. This frequent task migration is the problem for
tg->load_avg. One thing I noticed is, on task migration, the load is
carried from the old per-cpu cfs_rq to the new per-cpu cfs_rq. While
the cfs_rq's load_avg and tg_load_avg_contrib should change accordingly
to reflect this so that its corresponding sched entity can get a correct
weight, the task group's load_avg should stay unchanged. So instead of
removing a delta to tg->load_avg by src cfs_rq and then increasing the
same delta to tg->load_avg by target cfs_rq, the two updates to tg's
load_avg could be avoided. With this change, the update to tg->load_avg
will be greatly reduced and the problem should be solved and it is
likely to be a win for most machines/workloads. Not sure if I understand
this correctly? I'm going to persue a solution based on this, feel free
to let me know if you see anything wrong here, thanks.

Below are the test result details of the current patch.
=======================================================================
Details for SPR(2 sockets, 96cores, 192cpus):
- postgres_sysbench score increased 6.5%;
- hackbench(threads, pipe) time reduced to 41s from 45s(less is better);
- netperf(UDP_RR,nr_thread=100%=nr_cpu) throughput increased from 10105
  to 15121.

postgres_sysbench:
nr_thread=192
                 score          update_cfs_group%      update_load_avg%
6.2.0           92440±2.62%       8.11% - 13.48%         7.07% - 9.54%
this_patch      98425±0.62%       5.73% -  7.56%         4.47% - 5.96%
note: performance increased 6.5% and the two functions cost also
reduced.

nr_thread=96 with cpu offlined to 128c (2 sockets/64cores)
                 score          update_cfs_group%      update_load_avg%
6.2.0           75726±0.12%       3.56% - 4.49%           3.58% - 4.42%
this_patch      76736±0.17%       2.95% - 3.32%           2.80% - 3.29%
note: this test is mainly to see if performance incease is due to
ingress queue overflow or not and the result suggests the performance
increase on SPR is mainly due to ingress queue overflow.

hackbench(threads, pipe, groups=10, fds=20, 400 tasks):
                 time           update_cfs_group%      update_load_avg%
6.2.0          45.51±0.36%       12.68% - 20.22%          7.73% - 11.01%
this_patch     41.41±0.43%        7.73% - 13.15%          4.31% -  6.91%
note: there is a clear cut of profiles on node 0 and node 1 -
      e.g. on v6.2.0, the cost of update_cfs_group()% on node0 is about 13% and 20% on node 1;
           on patched, the cost of update_cfs_group()% on node0 is about 8% and 12% on node 1;
           update_load_avg() is similar.

netperf(UDP_RR, nr_thread=100%=192):
                throughput           update_cfs_group%     update_load_avg%
6.2.0          10105±2.91%            26.43% - 27.90%      17.51% - 18.31%
this_patch     15121±3.25%            25.12% - 26.50%      12.47% - 16.02%
note: performance increased a lot, although the two functions' cost didn't
drop much.

=======================================================================
Details for Icelake (2sockets, 64cores, 128cpus)
- postgres_sysbench:
  nr_thread=128 does not show any performance change;
  nr_thread=96 performance regressed 1.3% after patch, the two update
  functions' cost reduce a bit though;
- hackbench(pipe/threads):
  no obvious performance change after patch; the two update functions
  cost reduced ~2% after patch;
- netperf(UDP_RR/nr_thread=100%=nr_cpu):
  results in noise range; results are very unstable on vanilla kernel;
  the two functions' cost reduced some after patch.

postgres_sysbench:
nr_thread=128
                 score          update_cfs_group%      update_load_avg%
6.2.0           97418±0.17%      0.50% - 0.74%          0.69% - 0.93%
this_patch      97029±0.32%      0.68% - 0.89%          0.70% - 0.89%
note: score in noise

nr_thread=96
                 score          update_cfs_group%      update_load_avg%
6.2.0           59183±0.21%      2.81% - 3.57%          3.48% - 3.76%
this_patch      58397±0.35%      2.70% - 3.01%          2.82% - 3.24%
note: score is 1.3% worse when patched.
update_XXX()% percent dropped but that does not translate to performance
increase.

hackbench(pipe, threads):
                 time           update_cfs_group%      update_load_avg%
6.2.0          41.80±0.65        5.90% - 7.36%          4.37% - 5.28%
this_patch     40.48±1.85        3.36% - 4.34%          2.89% - 3.35%
note: update_XXX()% percent dropped but does not translate to
performance increase.

netperf(UDP_RR, nr_thread=100%=128):
               throughput       update_cfs_group%      update_load_avg%
6.2.0           31146±26%         11% - 33%*            2.30% - 17.7%*
this_patch      24900±2%          14% - 18%             8.67% - 12.03%
note: performance in noise;
update_cfs_group()% on vanilla can show big difference on the two nodes,
and also show big difference on different runs;
update_load_avg()%: for some runs, one node would show very low cost like
2.x% and the other node has 10+%. This is probably because one node's cpu
utils is approaching 100% and that inhibit task migrations; for other
runs, both nodes have 10+%.


=======================================================================
Details for Cascade Lake(2 sockets, 48cores, 96cpus):
- netperf (TCP_STREAM/UDP_RR):
  - Most tests have no performance change;
  - UDP_RR/nr_thread=50% sees performance drop about 3% on patched kernel;
  - UDP_RR/nr_thread=100%: results are unstable for both kernels.
- hackbench(pipe/threads):
  - performance in noise range after patched.

netperf/UDP_RR/nr_thread=100%=96
             Throughput         update_cfs_group%     update_load_avg%
v6.2.0       41593±8%             10.94%±20%             10.23%±27%
this_patch   38603±8               9.53%                  8.66%
note: performance in noise range; profile wise, the two functions' cost
become stable after patched.

netperf/UDP_RR/nr_thread=50%=48
             Throughput         update_cfs_group%     update_load_avg%
v6.2.0       70489                 0.59±8%                1.60
this_patch   68457 -2.9%           1.39                   1.62
note: performance dropped ~3%; update_cfs_group()'s cost rises after
patched.

netperf/TCP_STREAM/nr_thread=100%=96
             Throughput         update_cfs_group%     update_load_avg%
v6.2.0       12011                 0.57%                2.45% 
this_patch   11743                 1.44%                2.30%
note: performance in noise range.

netperf/TCP_STREAM/nr_thread=50%=48
             Throughput         update_cfs_group%     update_load_avg%
v6.2.0       16409±12%             0.20±2%               0.54±2%
this_patch   19295                 0.47±4%               0.54±2%
note: result unstable for v6.2.0, performance in noise range.

hackbench/threads/pipe:
             Throughput         update_cfs_group%     update_load_avg%
v6.2.0       306321±12%             2.80±58%              3.07±38%
this_patch   322967±10%             3.60±36%              3.56±30%
