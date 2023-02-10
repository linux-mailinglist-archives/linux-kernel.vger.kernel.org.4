Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCDE6918D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjBJG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjBJG43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:56:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07EF392BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676012187; x=1707548187;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5XQISiDBpLKNH4SfF5+kqhJN+3zjJNotdEb0zpfTkDQ=;
  b=GQJE2e0PbikC6ZAe8at5mqhqE3GuAfAVpC3lGuSR+jgJRo6H88ElXoC0
   SAPi2o53jPLSPqAORpu8rfN5OayL79X52khuuw8A25gDQt9ZFrpUdcLEl
   bewVspHcywRAijUonvPYwzgJ0x5R7dGUVg3Yzg8zC8u6aOO9uLpNP/DNB
   O6aoWoz6o7IojvV2jjzpzSGtCQ0TF108doi5CJQli8JguXk4iQsxWMxZk
   qkCpB5R5GCLyJpSmW/9kAP1r241Lav7uRhi8dQ9IWw3jYdT3/QJynZ80B
   i7g/DXc0pA7H8v5BJXG4OQXCtyGpWapPZDBPjWjdSALZisiFJQeCzDZse
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="309984069"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="309984069"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 22:56:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="617793716"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="617793716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 09 Feb 2023 22:56:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 22:56:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 22:56:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 22:56:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 22:56:20 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 22:56:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN31Vn7bMoZL0bxyIRdr9/z9lsWthP8zrJ8vqdy8gVqf10183627KV25kfrYruGT1eG87c4K8bKC5VkhTYLIkO6c2IeMA8bqGiZMLiDfrvFEr8yjD8CInigrXlbr2hADXDZoPXP6vA4BsX8QJCxCUVJrXejdRWLK+wXIJRzITAZ98HxwQSR6Bqk+rSrHTrx/ppNUbsTVaMqwY/sk273aerwloW4qeDhodRCga+eP/l7hQW/ZhzfQP0tAQ1P4FzDGiis0anY2CT66JNW+Lm5qZBKICvEKjcs6Jt200UJxd8fZW+wHvvuKjkQUfJGuzrdmt6p46bx96Fmo4u1TZkrtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPooCpK3jUzeVqSXMwmtwQOSms4i4abZ/VqXg9CqBVc=;
 b=A+qHaqVJuxUjl49u1OT8L+GxoMfiWXSvg0yYiYr/dbw5HmYQk6lUIJo8owcXH1ayvdc922hK+7ZQqQUBNb7nI34UFy3sDhKoW29zDpdoD3zBgdFbrG9NGSM01S6+bTPqZ6QyQyO1OqqtLnhxfVluKGQupT98ctjwtQD6HromKR90x+7J2ualVkQT8WZNE6S/rdxhNicw/H9GV1kv6pqZVA1WHcPki6hOK8i7tlaDPisqCf7ftrJiIVi69czNC5lAoxzjt81a1inF+4/+pBd7tCJjgs7Nag+205RnX6XMedjOlkUt8CZCF52bVD0RMdf0dkuyl7SD8d/yEO2rzmx5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 06:56:18 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%7]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 06:56:18 +0000
Date:   Fri, 10 Feb 2023 14:55:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
CC:     "Chen, Tim C" <tim.c.chen@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Brown, Len" <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <Y+XqfXVHyqrv1/Ae@chenyu5-mobl1>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+TyUZg86LYhtWeJ@chenyu5-mobl1>
 <DM6PR11MB4107F95164772B40B92F66A6DCD99@DM6PR11MB4107.namprd11.prod.outlook.com>
 <fb63369b2fc686730adefb6800eae4877e62e3b6.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb63369b2fc686730adefb6800eae4877e62e3b6.camel@linux.intel.com>
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f80d89c-4b5a-4036-568c-08db0b33e865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9DC0QeOGsNz0K54KKm5krDQK3KTIqK6X1+ymcZJLC51qFeSnNyMTCutFvoOC3M3vkgwfc74qpbGzmMyXgMpg/N6P5nB4L+4GeqEjptXIQ+lXiWr94cb5UrfpvU1jGhmh6MMi17qXccOR2a6Yjj7GzumtaZce8qx3+9Ds+0ujBTF/t8N3POYHj3rZKuaJCVbvYm/wBBxmMkA+shi4F5SMAurgYK1TXs1MmZJ2c6GABXE6I+wdPaPO+6VAAUkeFEfq+ZzdW3c+rpcm6SKwIl+BmTxHSYxIG8PV6ip9NH/F7Vtqb9bEKXR6zPBsc4EroKF+wuJF5/NcL92HTs7vxf7Hyny7+YdRdFlsHNHvI08sMwhvWJg00ciBsldvPZBvEXTIbtl4ZiYrmAxrVqHGhuplMmWQ73pnF2tOo5mcRjt3d56mWutS4Zuo2ne//2jTFSlOdTUbRqd6pC7Tp6OdpayPYbvz4FiqX9iiiLlQds4K17Kn4WMoDh0VvsYpVt/3d3t9FvkCWqZrf58EDGk5yQYbdAutca8LE9itf3SZ0g/2xGF6BotwxTzj6EXVy4BajIKEsqrzSMgpNvIOovuLdNs+Q7XBtw1Rlrk5lUHzaaHqzvywBzYEHNaqTQRTVeiXgdG7HduxRbNas0hfxroTq8Y1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199018)(6486002)(478600001)(54906003)(316002)(2906002)(4326008)(66476007)(8676002)(66556008)(6916009)(66946007)(41300700001)(6666004)(6506007)(8936002)(186003)(6512007)(9686003)(7416002)(26005)(5660300002)(53546011)(38100700002)(83380400001)(82960400001)(33716001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3L5tdx467ADPTfw0zotRMCfN3lmw5lrDgn/XflgvhT5vIxYbPpioHi+n7X?=
 =?iso-8859-1?Q?qFAVICzsmie3504GLYjPkOCbWQFWn7/YbdBLfHdVr5Iphsar/CtTZZtT26?=
 =?iso-8859-1?Q?SdnIM0YmhQtleHNSM7ueYN+g3WqyQ+TfTRFpc3tmZYha2Kr06sk2/cyjRG?=
 =?iso-8859-1?Q?1eD3igBCARlFDpcUmG2ffyzd1/h5u5IfcrlIn/1qvejKtvwMrnx71w2yYx?=
 =?iso-8859-1?Q?hiU7sX1jXbSPHjvgSVEimbRva3grmnccF6EfZa51cpvS9szv1x8GlRRt6A?=
 =?iso-8859-1?Q?XHULWDJWFrBlMTmNf1Rv049B1yjMgN+M8LP7d5KYvKzoVdroFFbkuS3cB8?=
 =?iso-8859-1?Q?W1rFivr9Q8fArz1p6yw4NJpzHdiMOelxU3En1gBuHW+O7vT3WZPd7QwQt4?=
 =?iso-8859-1?Q?KTAmYjqOLh/CqcVQKNKdNYrvpQIupjT7T+3GM/87OT0oKowX32XTfgT3Nq?=
 =?iso-8859-1?Q?xpI54OeUJs9cWDAZKBlEb0EHjqc0lAsj5+UWAjsZ9kQjvR84KNVjqKsvar?=
 =?iso-8859-1?Q?HnoybV8kPJHX8MaKtHKYKBep5Sby5YZt31UNx7W9REI03eARS7RKBfsIrv?=
 =?iso-8859-1?Q?PBf2/FXgcYFqsnjA0AAGLPK3Hzbod/SyhqKr1AGh7y0utHkYLMO9HBPSHc?=
 =?iso-8859-1?Q?9GHC8WvLXdQIS8t4yCeCc3Yil3g2F+8OL2PBUtjnT3u1YpSAL7tsIop7gD?=
 =?iso-8859-1?Q?VAoloDx+YjqocQt3hWGjwRB8GXtqlD682crviJ8Kj4OCZLg8x2JYyxd1Kj?=
 =?iso-8859-1?Q?rmOC9uj1MHF7QW7F2otkvBekdMDa+xr6D8TdbE3pycp77TUBC9HlVOHwRI?=
 =?iso-8859-1?Q?Lbv1et1/z/eUY4d6a8pMUF+4JKMv/Om5V74m4r2PhHUQdCTi8VlCbvh8em?=
 =?iso-8859-1?Q?7h2qkD8lWTMjuYFcJmvwXgdfzB4S3Y74xDgu/gjAk6uBcVZSHZ9HjHGmsd?=
 =?iso-8859-1?Q?6hfkrRyTWABKEeBQYaITGcALbg4FCNEZTdhKZy2vrxMtuV1f0FqdMt/0jH?=
 =?iso-8859-1?Q?txZO7YrwKehfFPIXfvaqM3EN99GQKzKgMKtmlGMBXOObSFjd3+XNOERd/D?=
 =?iso-8859-1?Q?fCEmUipu1cyE7F6phRfYH9iXIumaS/w7aMiCiWKJ5zv2/gpc4keDbB9SUZ?=
 =?iso-8859-1?Q?Hz7xz6g+umLXONHsGoHkKwXnRnxHth8XBW9kBDazPNZKiejOEhaVuFWhST?=
 =?iso-8859-1?Q?Jj58IHSgxNjWs4XAvPUiug1Iv/GJGEvMLL53qem4jpoV4hbfiI5NsOGZQL?=
 =?iso-8859-1?Q?9MTgxTGrfGFo0nIsPh2Vi3kCQ/OgaMT4MZhX8VA0UMwm1584B/8CYQ3uB1?=
 =?iso-8859-1?Q?VB5JKa34Zf4Y6CkwDpTZ3bN7TO5dB80jsowJnwnzHG66lq9nTecVMs6B2r?=
 =?iso-8859-1?Q?1az61ninG2ZBkWnhEmC6ohfN1HU2Z/mFUbH0+1F6TBomm+R6lth1xf2UHw?=
 =?iso-8859-1?Q?gzQajkWNV6UTo1c0qQMLHyP6thTx6YwOfNX8NaZjS/q3YALXEazQnqanAL?=
 =?iso-8859-1?Q?+ONBKfU+cqHeP/rb/ZidF9JFnwoUqNBT2G4a3cQwtUT8wxY3NZrRWrUfRm?=
 =?iso-8859-1?Q?3vnMb/4HWHo9s7nhWZQUMRN78XR3+2gOYcq/mFFeJB7Y53uQ+ythc+x/ok?=
 =?iso-8859-1?Q?UHDGaxl8h9XBnT15UdB9OhIUY/dXf86nj6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f80d89c-4b5a-4036-568c-08db0b33e865
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 06:56:17.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odIdToYfBeILZlVd95IKZAvnfGIsrMEWG+G+8wAsYdjksCia6ZXAGV/X5Bj7GqyeCCSVXeKfkQGJ4n7PeANXAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-09 at 15:05:03 -0800, Tim Chen wrote:
> On Thu, 2023-02-09 at 20:00 +0000, Chen, Tim C wrote:
> > > >  static inline void update_sd_lb_stats(struct lb_env *env, struct
> > > > sd_lb_stats *sds)  {
> > > > -       struct sched_domain *child = env->sd->child;
> > > >         struct sched_group *sg = env->sd->groups;
> > > >         struct sg_lb_stats *local = &sds->local_stat;
> > > >         struct sg_lb_stats tmp_sgs;
> > > > @@ -10045,9 +10044,11 @@ static inline void
> > > > update_sd_lb_stats(struct
> > > lb_env *env, struct sd_lb_stats *sd
> > > >                 sg = sg->next;
> > > >         } while (sg != env->sd->groups);
> > > > 
> > > > -       /* Tag domain that child domain prefers tasks go to
> > > > siblings first */
> > > > -       sds->prefer_sibling = child && child->flags &
> > > > SD_PREFER_SIBLING;
> > > > -
> > > > +       /*
> > > > +        * Tag domain that @env::sd prefers to spread excess
> > > > tasks among
> > > > +        * sibling sched groups.
> > > > +        */
> > > > +       sds->prefer_sibling = env->sd->flags & SD_PREFER_SIBLING;
> > > > 
> > > This does help fix the issue that non-SMT core fails to pull task
> > > from busy SMT-
> > > cores.
> > > And it also semantically changes the definination of prefer
> > > sibling. Do we also
> > > need to change this:
> > >        if ((sd->flags & SD_ASYM_CPUCAPACITY) && sd->child)
> > >                sd->child->flags &= ~SD_PREFER_SIBLING; might be:
> > >        if ((sd->flags & SD_ASYM_CPUCAPACITY))
> > >                sd->flags &= ~SD_PREFER_SIBLING;
> > > 
> > 
> > Yu,
> > 
> > I think you are talking about the code in sd_init() 
> > where SD_PREFER_SIBLING is first set
> > to "ON" and updated depending on SD_ASYM_CPUCAPACITY.  The intention
> > of the code
> > is if there are cpus in the scheduler domain that have differing cpu
> > capacities,
> > we do not want to do spreading among the child groups in the sched
> > domain.
> > So the flag is turned off in the child group level and not the parent
> > level. But with your above
> > change, the parent's flag is turned off, leaving the child level flag
> > on. 
> > This moves the level where spreading happens (SD_PREFER_SIBLING on) 
> > up one level which is undesired (see table below).
> >
Yes, it moves the flag 1 level up. And if I understand correctly, with Ricardo's patch
applied, we have changed the original meaning of SD_PREFER_SIBLING:
Original: Tasks in this sched domain want to be migrated to another sched domain.
After init change: Tasks in the sched group under this sched domain want to
                   be migrated to a sibling group.
> > 
> Sorry got a bad mail client messing up the table format.  Updated below
> 
> 			SD_ASYM_CPUCAPACITY	SD_PREFER_SIBLING after init             
> 						original code 	proposed
> SD Level		 	 
> root			ON			ON		OFF      (note: SD_PREFER_SIBLING unused at this level)
SD_PREFER_SIBLING is hornored in root level after the init proposal.
> first level             ON			OFF		OFF
Before the init proposed, tasks in first level sd do not want
to be spreaded to a sibling sd. After the init proposeal, tasks
in all sched groups under root sd, do not want to be spreaded
to a sibling sched group(AKA first level sd)

thanks,
Chenyu
> second level		OFF			OFF		ON
> third level             OFF			ON		ON
> 
> Tim							
