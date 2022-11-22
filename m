Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866336334F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKVF44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiKVF4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:56:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E427FF5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669096576; x=1700632576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iuYY/B8rtcOWnpAjdKuIf47VXRK38SuJ+gp0gGy3uNA=;
  b=I128HqLb3YVOKxQwR3xySGD7oSh0/po1ijl5fnGJQ/Tr5c8/Y2wC9F4l
   kGMDjdxwD3y/TNebnSG/phT5mrX0xNJ7g3/CN5UdfxCt7CJgkAwTdPlye
   W3mKuOO4TjJjJVKtjOHA+Ty0LY1NqigpXXfFrbIEUNk3iONCbdImNSU8U
   9E4PYEB3uGN0bSQVnLKfcM0GrJNGK8Npl+cv7Da6AI00JDjUvpjqcVbOU
   7QCEX3U2+BboC7IivpyV0LwKOyUo5qE1AW3DMTwcmEfzYAEK7CxWsrjfl
   7uRIoOlIOxXsZ/MQf865XvGk2vsLc6AU//vRUU81WRIzMQEjJk5cN+kFT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="313770057"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="313770057"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 21:56:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="886400719"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="886400719"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2022 21:56:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 21:56:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 21:56:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 21:56:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 21:56:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KePthGXk3B13MIDVFfVtA/xemdl9NdL7uM1D7sE71NQstFO6wgEPoElZc1INOgYEjTHbZBVKGoKcBFs2N63zxsN8WOm5TTqld5vtTIIPjxkyl2ZHi3Hx7dQ1EnSPxyGafMLmIx1TjZ23+txUjvhz1bnjfjm5oUv04wxEGXg2ESZVXWrYd/ErSDc0w2rdRVTzf3QeAlkUa64bxdnH98e2CysbNlMA+kJMMDIRbkhI7nUsxtwzWFSDcOdivspz7JHMyQHHkJJ83Bgkn6845u8fOUntVUFfhwxbNx9OUHdh2DjQ6NsM6UncOnPWxXWL3g9pz0WQpKEWXSlZEF4ymk7qCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF6qPXaKqxhGSXqh3AWtACQPDPbyowwg6Brpzydxj8g=;
 b=mEVTkhIeJu6YQiB2ZaCzBGTrYB9eqzTNiIwnSecD7b8SivjNNs20kfxQFYTsNzFfXpzP++IGjQZH6oNZxlTPfkEcMlrWg16tG/mua2CGKqWRBAV6EdjOQSxWiOyJU/8w2YdvftNl6f3NmJ0i1+w/2yszi3R+JoRcbXllhSF6e9bamV5Fa6GrNfdHOWBifM/Po788xCb7Nv5r2fJW8cqIdBYbjM2p3JaTP9GfvuIBwLaJFImodsXPCdnV9CHqXDBWvchzdyjII9Jg60VH+t1e7bJmF39whXx4C+AxfYEQ1EffoqLnmSKd1Aup4WryB/dTnWBF4NVKV4f6Y1tnIpyvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:56:08 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d3d0:e250:56:26a0]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d3d0:e250:56:26a0%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 05:56:08 +0000
Date:   Tue, 22 Nov 2022 13:55:53 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Josh Don <joshdon@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <Y3xkaaioFNVQtN8q@ziqianlu-desk2>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <Y3twWYeAW6U2/D92@hirez.programming.kicks-ass.net>
 <CABk29Nsxg2AvUzsvn4kLpE8rzWRJNt-EKwFi1HcK7c6uY_oUUA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABk29Nsxg2AvUzsvn4kLpE8rzWRJNt-EKwFi1HcK7c6uY_oUUA@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH0PR11MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 2861938e-334a-4bf2-3039-08dacc4e4014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsahsCQ3CDHTbyIl3xLxr2X+uacudDbAqn0t45ptxW725O1XsB9rhUB5iabXh81oAY2Hf2vd6dI6vSR0xQBWSLjK7RyYdcnze9VKzuQY44JxM3IfFxMC8NY+tTzH2tKVEAG1YUwSwiCKbF3GgufUVTCfeswgjt00F8vLXLylvaiKezS1jCHXL3tKaSIgJBBDP97sEcU5l7liLAGGL1zq5LRSQIezNgqRYNm9/x3v/NWAmKKFkLi2b/OVyHL7yLPvlgd/sJ3xoaJFqQTyrPlVYi3aUVj86jVOx59b4+a2U0ULbuxStioTYu7byJdWa7iY7PTPMne2HAqc626RwIGEtjBKmBDi2MzxpGoeuxvcc6uk3cEQEIPng44sTRW7pEUhDXX8vqm8XcPJisx0pbBWCyYOKy+4enfcyfFbcL/MNJWc3fltAqBQA506Wz9bIl6td3KBpnrX6IIrz52NQawTRbdAMkEElun0y97g9YqKtTTMUOR8OBdZMP32BtLg1hP3k5Ka/njZ4xq6lWrv9N+qDHqeWomf/+UsJYVyJQRqfE7RqRFJKqC90iq/T3enluV39bmDct9HBZmzUzu6QN7jfLFCpo/14pLP9bse5x5JsM1iTA3IVS6ZNpO13fO4eysF362KrV7rWTABpIJd9NXHOKxIpeqIG2a9qACWyG0+If8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(86362001)(38100700002)(26005)(33716001)(82960400001)(186003)(83380400001)(6916009)(4744005)(9686003)(44832011)(2906002)(54906003)(6512007)(8936002)(5660300002)(6666004)(7416002)(6486002)(6506007)(478600001)(966005)(66476007)(41300700001)(316002)(4326008)(66556008)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/yLbo6dUcrQMpi2ZdJir3FMtUSBCvvXK7qBVMEYbFUWIhfzQ2JFs2u0AV+BS?=
 =?us-ascii?Q?570grBEkPRx7UmoFMtgbwkbaRDbroIg2BGLefnQpXssLgN9oRJUM2wD0DR00?=
 =?us-ascii?Q?mJGoRWaJoqlQN1J9IwFtsEuPYErPfRcYGOakb3C0xsKOboyxG4gTkJmyWgX/?=
 =?us-ascii?Q?G3ZC0NxmnCdceHI0ilkDhN9or/yOZjF57uYzN3WG4SDFA14tj3YE/dP2bc8F?=
 =?us-ascii?Q?qUN3keLDXD0PpboT13RyiVbNGzriQgB66sTTvZS8VfS1inZYaneHfe6Su6dz?=
 =?us-ascii?Q?5krTP5FcRcNDUEr9nmLJTYock6oyU41lrcha2r6L6bDEGpGSMXrveBzJSH31?=
 =?us-ascii?Q?DbnWeGRajg3tFKslJAnFw3WdF+vdeJ2v8J0F62LYhk2zerPJ3Su3oFRXScjd?=
 =?us-ascii?Q?XlPXMEAZd6ijZ1/abIbnGRXMtjSEiPyw+koUxx6Xu+T8RerivOZY31KOI3Y0?=
 =?us-ascii?Q?XIJpgJzKlX1cXAi61LpHjdxq8a42BIpT9cAVuf0h4ucIwL59y8hbXCna4Ktb?=
 =?us-ascii?Q?/dZjYZWMfLeCvrGwctkkVY/9GaewN9V1++/0b+gCPq9VTzh9KM9mcLuoP/zV?=
 =?us-ascii?Q?KexZPA81sjfhza8KWH8snsRLRIDbAb/EfsFkvGp4gOr0MQiImjUB6CuxQrlr?=
 =?us-ascii?Q?L7iNSmxmqqX87/GY03s7rM5CsEHBTiIidUwUK4DsnZPHmYojMaKHNBnS3YwW?=
 =?us-ascii?Q?sjaFn15U8lk5o6oiGdCEav3kNRO8cEbUwPVeLyszZGpFtw5/YgP4dS5lDpID?=
 =?us-ascii?Q?AU2B/gIsx5i8IgjlwdSalDFpZ24bxXM8krQdkAMWNQ0ljcIvVR/qjwFv4xRI?=
 =?us-ascii?Q?j6ZotyTUy3M+RRJbG7YIw6uZOux65msyIYK0JmSBo99fuPXV4pILL3Em8hUq?=
 =?us-ascii?Q?r/7tEbsUQ9KxffS0UcuKjTln2YPyUlCodQImfTFWY1FKPfqdnhUcNkKeP3HO?=
 =?us-ascii?Q?DEMkagw8PjcXn6KdGiw0ssffbo/VZm2RdnHna2HbyciMTQaTVoMfxIyzHzTT?=
 =?us-ascii?Q?MZur5t91F9GWSt37kxrRUbjP6FuaFTeNJZAdCD1hoOL9XW1iF2ZQWXcyk8mt?=
 =?us-ascii?Q?W0NvZAD8kFZLLCHJgHPQoUoT47odAWXDmmh4F5TZHb14bflo58Bar7xvJffG?=
 =?us-ascii?Q?apFQPmm3qJ/oQkhPHLJNsZfyquBQFNsCywjX5Cjpwrv+sa59VXYUPnMImssk?=
 =?us-ascii?Q?XjIgNtm6drx3PFudaRtmSIZAeV7b9E7ziiKl2V+/FJgi757g325leGKb2Vaa?=
 =?us-ascii?Q?wLZDuAommGXyUy75G4T9IgzlruTwTT6q0jWY419epPkVvB+a05J1BvGFE/px?=
 =?us-ascii?Q?RZsYmeNTts3diYrsJH06GytYlr88kpMtwiEqDLALYEwY6p0g16XBjGKGllcC?=
 =?us-ascii?Q?O34o8dBZvd6gWSNIeFkqLNNbA+7OSHF/jvnmVUpVlnS/17x+R/oi8BV9AXvV?=
 =?us-ascii?Q?3gSB8xlNipTr0tmAeZMQ0lMS85VXoIPvQ90AqlKDksv8h3Ic+KdsXUD1fTbJ?=
 =?us-ascii?Q?rW6axIhitXE8CGU1ph9MSW1d0OR0zWbWPiqRDCmMbdVj+Qcke4/wMqW/q1S9?=
 =?us-ascii?Q?3JgFRjXAm9Ua1sBJi0Y0KHb5z7eD9h6fj8HwfWtC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2861938e-334a-4bf2-3039-08dacc4e4014
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:56:08.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNdewDzTcS4CQrCn0R9CZEuNapxhdzQ+1yhBYGirGDm/GpkBD7n4zcRV8jnjtw1cdUxOxryJoo9PkVdPIycGiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:31:20AM -0800, Josh Don wrote:
> > Please test the final version as found here:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core&id=4e3c1b7b489e218dfa576cd6af0680b975b8743e
> 
> Thanks Peter, the patch looks good to me and continues to work
> correctly. Note that I needed to make two edits to get it to build
> though on sched/core:
> 
> - local_cfq_rq doesn't match variable name used in function (local_unthrottle)
> - rq_lock_irqrestore -> rq_unlock_irqrestore

I also tested it on a desktop bare metal with 800 cgroups under 2
cgroups that have quota set. Before this patch, the majority of durations
for sched_cfs_period_timer() are in the range of 512us-1ms, with outliers
in the range of 1ms-4ms; after this patch, the majority are in the range
of 128us-512us with no outliers above 512us.
