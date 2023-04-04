Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674566D66FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjDDPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjDDPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:16:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E904499
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680621362; x=1712157362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fsz4xKKj7S13Wt0OpmePJyG1VZWOZpLRj35/07wEbeI=;
  b=CkldRKV7nKRt43DDBpVgeHR3hsxrKK5SPih+gGnuAlxFYqxzfMWvYS+b
   NO+R+tIiBKsVcyIaj+DnrBrwG3sYrY/6ysYouNzeIFJWrNAPSc5oiW5p1
   PdOoKiFxJh/HQRj5x2e0KSqbET+8Xu8v4AnIA/8KMGV7EGk+0C3As3Jqk
   5Js0tPRAL5RBsE7muYUya5xXL+Ek3Lk179OQoY3kwwXLN2tHL3wYi9NnE
   /63MFP9ASwXSa5yO6RhpTkbws9Ks2eZQbhQIzOqVGp7Egt6Gu5J2Lhd7S
   WUgIvsnRsLD9V3fVOBTkzek6f4TL68tsRWpMwIiQRWInoRSafk2WFq0Lw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="370031329"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="370031329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 08:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="1016143751"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="1016143751"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 04 Apr 2023 08:15:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 08:15:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 08:15:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 08:15:56 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 08:15:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H40RXI204sSObvlhqv1wG1YvZPcGUepMraUs27Uv8yCq7bMqlD57Y1lcvF1DpmJEsHU1T6d8aet7Menuwj8dqpdljs+B3+q8+TqTeJDRiVNd4ybDKl873aMOfpeUfL5dF78hy7TPv54CE4DC+cHoWDbCpHDR3KFO9yCrwgte+PGyEEHWggpV0sX32ARoaWITSjGPaz1ahK6GCUr+cO57K0wWuN/IFwOi5C7eyi+MT/6GcjGb4/RBeo9nXaSM76KX7hxPZ1rzec4l1sOEvkIihfK+WeM50LQzpAab2VokrkcYBRToRNrKQjkQJRqCm5FwFWf9ZgwJhii52O7RVxrkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLEsVSPT7Ajl8E2yowKxL5TfcbnILBNOfjYPKmz2Pi0=;
 b=jjStMY38Hrnn1LHbElE/irkY7lfr2IG+mZaB6Qpnu/6t3+dXoQmjF0VzPRagcCvK+z/2jU50U7tzwGCQHtv/FHdeQJnJi2ArA92lOQe+wySIwagib2xHTTGlPWTvyeoSKQggzNzc1J13RP1RILCG/96SWCHuylMcJQvpPHkOeCu+vvDTcB2mXSLdlwrCDIWkgrCucFfKLWTx/bJR5BeVcmMstgIClGlBfX4uPB7zK3ZTzOjZpn6Zr9ixVMP9AWlajSWEBhTeV0KysLDG6kGYrWkr6E0uZXE1SfyXnKXvPKIqQ7vvoQapbLuHXFbpcqbQ/IYXfYfISYnMhlTyGFw8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 15:15:53 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6254.034; Tue, 4 Apr 2023
 15:15:53 +0000
Date:   Tue, 4 Apr 2023 23:15:40 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yu Chen <yu.c.chen@intel.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230404151540.GA51499@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230327053955.GA570404@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH8PR11MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b03d218-f0c0-4b74-4f9b-08db351f7b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Sc1vwADfgW0Rsci0zVCqqme03cIJ/C/2d/Jy9WwWFxfJ19WaJ5hBkhT7m+TRdLjfHnh4Yk4A94lPGGh7QjjytwjirAvHINb/ZqPm3j16gqA/GVy7qOjsmzu1zECJGYa2kdtRbZmN85RCswVCpT3YY6Yh9rsiPb6nJ7yAYHDecrPGRD54oCJanqE8sWN2bzFzfZtdZ281NYJooo4ArM/RF4WhUIpz0TjHMyXkXD/uv57GqlKalfiPFHY6vUWrOxbXwaMvS2GqtmcD9iJz3+girSJ+3X1/H5NU43u2unHz4PeIwwhIZkDE7Cfcj6XdOhilDiIPeDA9CyAZK3tMx6nJf8B+zmC+XcgxioqvBVxlM3YLE4qFk5bFQCVc46X0b54FemTE0u1tskoSGvJglzEzvvO1AFABNjWqnX59DIASfZOFwHONHJraveYUtd6mjnRO5x8o7E5+bZ1qfLvv6WKp+h0ZSuata0cPNtD2JkVvJ6z5dL9GQgY/KWMJ0A7KqmWOnrEknjCbcn5EdxjCr4D6McVMjwMrGm8uRsejzAj9BmHRdyVci5FvuZx5+ERpfUg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(33716001)(8676002)(6666004)(4326008)(66556008)(66476007)(66946007)(54906003)(110136005)(6636002)(478600001)(41300700001)(38100700002)(316002)(86362001)(9686003)(83380400001)(6506007)(6512007)(1076003)(186003)(26005)(6486002)(82960400001)(33656002)(2906002)(8936002)(7416002)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dmTLUIAOoJtVnGUNJoqKg+ZDclXveIZXxtcXlj6OQV0ZhxxD2H/uKGGTjWdL?=
 =?us-ascii?Q?Fu8TCDcyj4ltVSsHlN3vMx+ME9I0HvI3Po9rRxZzjODEjt/RPZmJ4rUUu15G?=
 =?us-ascii?Q?bCl9apAQyBQsUm0USuzwq0+Yx50he0mD9DzvJyuhO2MowuQnPUVLEsDBG2NV?=
 =?us-ascii?Q?KqejPDvBOqYYN7zLDe1XCRrRVYBoWYBR18P7jB4epIeYqZW64VQYvrl9YooH?=
 =?us-ascii?Q?tuwp2F1XH+tT10WuOjy7d0Qi/ht2PrSEp6hs9s9DER7MXtINo3BkLEDlgGLg?=
 =?us-ascii?Q?XUq5XnwrqVf4fo6UxzJx44SWjrk/nwsXJbg4pE04kShlSrgMDS+oEgdgTCUg?=
 =?us-ascii?Q?tkj8Wbr/tyO8hIxwTl+34J+hnwad9bhraVQu2H/lL7xw4kwf217rjUzcv55U?=
 =?us-ascii?Q?BjYH7+QfAwjZEJKxq6FvgATYpKOuG+sxmm0hESSAH6CPco2Kk6myQu75+5Yv?=
 =?us-ascii?Q?KgrYtYQDw83OYkzS1Z/9NguXguM41xJRPRDYT6dn4XeA91NTqqBlb6K1basU?=
 =?us-ascii?Q?txae1RhBBNJdSgEJkvFQgKSNHdO26wiYk8xsFC86Ql0HuuTAWRpxW6nKFdlP?=
 =?us-ascii?Q?MHfPBC7WnHhJmU558qEwLOGwyWbjuzsdHB/Rch8hxJJZSOWKmXxvWMJzUF0Z?=
 =?us-ascii?Q?XbNXnwZotiUEUCipENtb6z1KyRz5rV9ToIPEwy/KlkXyAoYPK+NC3FpeF7wR?=
 =?us-ascii?Q?0L6Gwh9pqDanSWx1HGHEQnIVqrhMoNAFFoEMqCBXtYmyxXygkmZAqmEtQdBB?=
 =?us-ascii?Q?Z0lFYfe1ftsVVs03vLUj6hwJugP4dyrcThakEx1QIf8DST9QYcdzSsYdT3Ou?=
 =?us-ascii?Q?kCWX8YCD2Km2Da6m52Hqlc89tRIIArsSjjSU6RdO1Spc8G8/rT2YnoWl61eq?=
 =?us-ascii?Q?hCtM0xXnFz40lRvthT1ne/GQod30SWXKzFzc60GT7VRekpcUoa/9G2VsdVdS?=
 =?us-ascii?Q?g56bG2rpccBhI5ee7wprj2vPCfZ9EvxMUfsTeaDFkV31ujHQbISOMQ2pkp1y?=
 =?us-ascii?Q?kwtlEezl8GGBR8LCOR1WH2HMoR3DZxSJ9aSc2D9JIn8JE/iI2wqVLyb4x3+Q?=
 =?us-ascii?Q?bPJ+1E5SATzRPrbPdh2/DXDBKi9zN/zb6NCZZIZVzP8pOQFq6qmKcZvtk6ae?=
 =?us-ascii?Q?j+vK7XBXUddE3MFJpGeSvnR66DrBBzjey01KGrb3nVbCxEuvQC7ri28Co2x9?=
 =?us-ascii?Q?BuxnC8piYvh/WqVMsPkoBgEqJ27e0cY7ZnhDatHMJg6jYDR0RnQ1Q0nPRgrM?=
 =?us-ascii?Q?TKN+m/S0OeJwyirKMt2p1BItdgbUrF1KdowCG8cWu8OQOLHfyhq+cOPznU9A?=
 =?us-ascii?Q?M+jK1CbY4inYAzVeUeabOJnZe0O6y769uDMTKoDIa25TOPnO7y/d8B9GFB5Z?=
 =?us-ascii?Q?vvUEA+tYyIoLzmco5pzAOhmBEGA3oisVHxS5L8JsrPdeeOMVjx1CIxwi9MFk?=
 =?us-ascii?Q?OdqpqpD6S0+uVRzZpWLCEW71r8RSkMAMMASePI4cbkfG+wS3GzNTnZq+VNd9?=
 =?us-ascii?Q?r9Av7RqIm6KC4rt2H1I3k6j4OymUjKX9ixMph6Ars3diGqrJP6Ko+ILvsQw1?=
 =?us-ascii?Q?zGjSieTEZt1ZrskNVVEZ+WYmx/lS6ef8aBGOqNjQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b03d218-f0c0-4b74-4f9b-08db351f7b51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 15:15:53.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: disYp7wicJ0RbWN8oDsyV588zFvvZpXyUkTubpH+9Aw2hVAXh9XE0xNi1Tut72Fv/Utf+VLdFMF+uXZfu2r5gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
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

On Mon, Mar 27, 2023 at 01:39:55PM +0800, Aaron Lu wrote:
[...]
> Another observation of this workload is: it has a lot of wakeup time
> task migrations and that is the reason why update_load_avg() and
> update_cfs_group() shows noticeable cost. Running this workload in N
> instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> task migrations on wake up time are greatly reduced and the overhead from
> the two above mentioned functions also dropped a lot. It's not clear to
> me why running in multiple instances can reduce task migrations on
> wakeup path yet.

Regarding this observation, I've some finding. The TLDR is: 1 instance
setup's overall CPU util is lower than N >= 2 instances setup and as a
result, under 1 instance setup, sis() is more likely to find idle cpus
than N >= 2 instances setup and that is the reason why 1 instance setup
has more migrations.

More details:

For 1 instance with nr_thread=nr_cpu=224 setup, during a 5s window,
there are 10 million calls of select_idle_sibling() and 6.1 million
migrations. Of these migrations, 4.6 million comes from select_idle_cpu(),
1.3 million comes from recent_cpu.
mpstat of this time window:
Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
Average:     all   45.15    0.00   18.59    0.00    0.00   17.29    0.00 0.00    0.00   18.98
Average:       0   38.14    0.00   17.29    0.00    0.00   14.77    0.00 0.00    0.00   29.80
Average:       1   52.07    0.00   19.88    0.00    0.00   19.78    0.00 0.00    0.00    8.28


For 4 instance with nr_thread=56 setup, during a 5s window, there are 15
million calls of select_idle_sibling() and only 30k migrations.
select_idle_cpu() is called 15 million times but only 23k of them passed
the sd_share->nr_idle_scan != 0 test.
mpstat of this time window:
Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
Average:     all   68.54    0.00   21.54    0.00    0.00    8.35    0.00 0.00    0.00    1.58
Average:       0   70.05    0.00   20.92    0.00    0.00    8.17    0.00 0.00    0.00    0.87
Average:       1   67.03    0.00   22.16    0.00    0.00    8.53    0.00 0.00    0.00    2.29

For 8 instance with nr_thread=28 setup, during a 5s window, there are
16 million calls of select_idle_sibling() and 9.6k migrations.
select_idle_cpu() is called 16 million times but none of them passed the
sd_share->nr_idle_scan != 0 test.
mpstat of this time window:
Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
Average:     all   70.29    0.00   20.99    0.00    0.00    8.28    0.00 0.00    0.00    0.43
Average:       0   71.58    0.00   19.98    0.00    0.00    8.04    0.00 0.00    0.00    0.40
Average:       1   69.00    0.00   22.01    0.00    0.00    8.52    0.00 0.00    0.00    0.47

On a side note: when sd_share->nr_idle_scan > 0 and has_idle_core is true,
then sd_share->nr_idle_scan is not actually respected. Is this intended?
It seems to say: if there is idle core, then let's try hard and ignore
SIS_UTIL to find that idle core, right?
