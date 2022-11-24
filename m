Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB1636FED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKXBkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKXBkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:40:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E9CFEA8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669254028; x=1700790028;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xve5tb222m/OnXhmMMT2OMF8KV2adRz4SOQD2L7Nq0M=;
  b=Zeh0jXXYZV5rKqft0nbHT5YUTYw/s2B7b5jUnOJtHrljSuN6XHH0P76N
   19QMWryx2fw+UTjXc62yWz9AFoaES+rEBI22k2dcgDoGzKCz/aKzHtkpT
   3wy2wGx0EPogGKepEhRKQ0dfmTP0RrJlzdCG8x7yjMK+QaLfcxHKfvHyC
   JdTLZg79helqxXZr7U+0wUz5oZffRVz7+DYCBufTqkUs4/axvfIBf3lQ9
   lAde6lQfF5qGNz8+8rhK9C4cN5JcQOM0X6S9FVHUjFYAXR18F46KQllvg
   G3LgMN7N5Ry+t2EnTZnfrmfo4yX3U9LTkn03iBtIXjCZwmu8shPC7oAq+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="400485428"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="log'?scan'208";a="400485428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 17:40:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="784448510"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="log'?scan'208";a="784448510"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2022 17:40:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:40:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:40:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 17:40:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 17:40:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwIhT7ljCqLFxYlCV48dT9HmghHoSzel2OPgUAcEtMqKNxMHdEy2NlqQc46F2WjH7rcMmJw6tQLBCkX8ix9FiSg7m2X+AKJtVb+fI16KAe7jfENMadT957vrsXVBTTOk6qTCINZTIaIQQ3p54rOLvfsiZbqaCmtCsiHwReqN3nlzCMcen0RWm3cQ0gkTwd3ZyvrYkLR1l6ptFgrwaJuliDQIist8Aq9N66fHIyniFOwRli1lRnU7w2bxxb6jqvMzsIXYGubY+LMXtyGpOhgqJKCvfEZFpHJfz0eXyMIQyqkTzbEJ+Jk3XI2c3mW4yzy4C/OWWxW3vXEcEYcPRIdvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c5DqsgX07ISPJcJ4jx1IVDFeK+hDNaabG90jPm4B/c=;
 b=PppRt80k44BA+cRxBy4NlVlMIojhrNbh4hTHDFtoV0CGCG7Zw5A/xoaiQMqVT83kyyFWAzS6KKnNnqDH0IzDNCQeQ/YjwBqU2X8YlxJWMN8Gg+cofesXe3Jp1PgyWrkmCH6WCCkiR3z/BG34E+/WZUxRtsEvmEZZZoBfJLmGXMc41q2+tNYiTieaNlSJTACAoLKI6LrlecAIH3P6fbENiDJ3zqD2M6IGmB2Drk2BbsNq0eMw09Er45tyNw5gyVYiqwAAAG8rAkO0G6ZYF3UawaDsScCZsA5UQY76uWtCbptMDSg+9SEirAMH40N9XKMOGRPwcZLlaCSw4oAFln0r9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 01:40:24 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%5]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 01:40:24 +0000
Date:   Thu, 24 Nov 2022 09:40:51 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <peter.zijlstra@intel.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y37Lo4n6MKoMABAu@xpf.sh.intel.com>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
 <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
 <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
 <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
 <Y347syXAYqnAsSDK@xpf.sh.intel.com>
Content-Type: multipart/mixed; boundary="MaGdtKmJws5JEouo"
Content-Disposition: inline
In-Reply-To: <Y347syXAYqnAsSDK@xpf.sh.intel.com>
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f72ebd4-2f11-403c-158e-08dacdbcdb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAAnTztwbm2jHes5jW3NdJ8+ElHSNsna1BdmGKwtLGHbOtCvS445VzqEZPk/2WNRJuaYWFQY9JZvkRRWiUdAt6e7eZ7tys5aApM9p/+E+8s+QjpC3W5kroEBKlPEazigFf+CZQNwZjB7ApryJMTOevOrH5kEEbLRcv2lr6wOOyHmhbFL3C8/0Bdm74YvBIdX0O7zNUPcd6WVnznWlHbtnsqijmh1Pq1EJm5fXTYInqwAIMcO898nqA57FYdsPmcxgAp5Er3w/oIHbTcTRTZbuEuEBPvB6fEb6CyI7KaeNPiA2ogUV3A4JdSEabsyOMojVp9MnwmNZDn4Nq0Q/Rm/GKabFXD4LK6UW6xMIiounsm4cmOLlApGcImUC9puWft4ecUyiEJ5TbcgKCb7DMoE/VvykPApSZEj4Uc18IkEq6Xw4twattBw8eC1w2ZRESzuHbApXYDqRwMR5zf3sImlAqD8iFz2itEdNbZuKjpdCDKb3As7inBVc4RHlpuA7pSarkhrqe9qQYhS42wo8fdzTJmK/HDCTC8L5QLaiJuUglORzULCY7UMgyZ5/3TgxK+9adYKsYfN/l0/Y7pDjtwcIrXkdDPRcsX5eADN/A6HqE8iir2CQY5ZhLle+/e1ATeEocMaL2G3wbqV7Srcp7lgv5IIPxWZcbDzo+D0m/sO3Fyg5QVHcGkUOW022tA5ffLxIFHqJhWAmjpgTQMBOFteifGgNf3YFnuv/oTEVbGWyBh+iTv+Bh9I+XIJbEJLyw12BnSwcCiHRCu0fuaFsCNafg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(38100700002)(66946007)(66476007)(66556008)(478600001)(6666004)(6486002)(966005)(8676002)(54906003)(6512007)(21480400003)(6916009)(316002)(82960400001)(44144004)(53546011)(26005)(86362001)(6506007)(41300700001)(4326008)(83380400001)(235185007)(2906002)(4001150100001)(5660300002)(44832011)(186003)(8936002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJBG0egrbbxenn1OPMW5sFSj7bW+fLSn28lT9rmMa1EoRJQwV1jcUS+UV8kc?=
 =?us-ascii?Q?8lxzh5riifEWVUgNHlGL6ULedKCiYu5BIr9IhKixV4ga17P0dCOljkdXTgLp?=
 =?us-ascii?Q?AWNDJXB4N0E8+Za6yi/RG1/0YMCuDSOrT6oan+QgZodaEIQnHmQGXAKMr+tc?=
 =?us-ascii?Q?wP1QV0VEpMe7MEAp731oZ2iWxDRGrAGoYhyKHmXxxqU4ikGZnx9f/iwHqNGz?=
 =?us-ascii?Q?n5JXZ4yAncOymiYTFcassBpMwh5LnG2hJ48SLu/L5iOOp0fhtjKV1m09voIy?=
 =?us-ascii?Q?sGjIsXfR39/GQDtbWzGUqvZ4WoXLmb51VEDP3fH2YCgiwNNCMPXmZdKcGSoV?=
 =?us-ascii?Q?oX4yDOSnlaI48GP7stJxgv4K5sR6Ct5NZsf+nSnqQUaigmyNAFqwVz7hvCp5?=
 =?us-ascii?Q?0bORqI5x+KYqCXmP6KzBTlht/3D9BTal1dPabowfDSFNGSJtDy7fr8hvVf8p?=
 =?us-ascii?Q?4UjS0Uj+fvrYKTTOjAwrsaoaidySYF0QIZNQ7ukggLiX8d6qqUy24ffwCai9?=
 =?us-ascii?Q?DE7UZ71GluQAI7wFerXo3+SWux7TkySFEkylFa1cqZTf79FQN4zGgEyDvcaU?=
 =?us-ascii?Q?rR+9/0mYN4jMtj9ueXwfqT8OvD/ExMyoM03b4WYzvqD5VmJLglg1AL8Ao8n4?=
 =?us-ascii?Q?bD7b2nytzetMwekcHQaCDbj9RCMaLzSiVQKTQp/NVCoRZ2RmAwUPcjbuXoeV?=
 =?us-ascii?Q?mLq1leT9CkgoPq3Os8AAYSOnILR0HoMCNufM0QFyI/nOCOn1JpgXN+s8VOre?=
 =?us-ascii?Q?LefPT04vvFGVtdpH0qDy4ny4b2q3pPJBw5gVGxG/tlq94PYtRm/7X14VOK9k?=
 =?us-ascii?Q?NlCKdBrZzqnRZaUN+bUIfMMll2GC6IO5BQIjHhECQ5PDtP879o+KiJ+kApWf?=
 =?us-ascii?Q?E3P3rv/b4LdHVxDX+/RQnV2gQcSR1GsobGnBy4RJHv4dCJHkdtjVJV6D6ns3?=
 =?us-ascii?Q?kjRl8WmY3zsyvYtq/kcQfLb5yKK4INW0pMJx8feuhBhjljthKdmzRnB1I2u7?=
 =?us-ascii?Q?s1ng5tSF++mOzrfGUAJe8OcXRdOw5HHN5dVp6TDRAWqzUeU1q4rSlRFx4LP6?=
 =?us-ascii?Q?XsmF99Lxm/LsYDvHbheucTuiuyHF8lC/2tkn7q3XU3Ij8iVbPO37eR07b/1r?=
 =?us-ascii?Q?pOhlx+K/IdMwoKurBlHCHiD6r6AUF2Cy+X7oNM2CuTjssRH6oEjeIV3SsgRn?=
 =?us-ascii?Q?PUwl9szFTLYfA21AaWS+TD5hwzobRYHn/nkD0yyvQtvZBNeIiD2IjF2KTnSx?=
 =?us-ascii?Q?NPED6jngIfZE4ZUDQDMoDf4wxcFcPSSPZ6GLnAqxF4RF+KwwL4V1ErI/9wPU?=
 =?us-ascii?Q?KSELHpHCQ1YhlwCFK6DZhE1lddWlYaYJed0tDw4Z0742FeDtmszAmI9SCDMD?=
 =?us-ascii?Q?XBTmQHSvU6Vmx9832+Fuj3/5AHvhAHWW3y5YJkL9QcoqBubiKt5u1Apnw+An?=
 =?us-ascii?Q?MwH4iWF5RlQ6VjQCCgnu/GVs1F5MkbOMnubkncx0ZWpNfvYxSx7G5XZDxHk4?=
 =?us-ascii?Q?AWEPZiAjTbCVBOgbQvqLfFzvWt0B/yw1GLmRyOvzvTYibqYNo/CwU1R/sGLT?=
 =?us-ascii?Q?nIpMDwajMsAvLQv5+9rHI2quYw5eECf39EkpQqkl6sIWgTKJ1s5zSdvUvKyx?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f72ebd4-2f11-403c-158e-08dacdbcdb03
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 01:40:24.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/2DULefh9/Bu8F66tUewKXwt3Z7TQQVY7z0Dt6z9w/+GFhwpO5kqs+swjWQs7Wa0Z2rK30uHZajCfaAPOIXbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_HK_SPAMMY_FILENAME autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MaGdtKmJws5JEouo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Peter,

On 2022-11-23 at 23:26:43 +0800, Pengfei Xu wrote:
> Hi Peter,
> 
> On 2022-11-23 at 16:05:14 +0100, Peter Zijlstra wrote:
> > On Sat, Nov 19, 2022 at 10:45:54AM +0800, Pengfei Xu wrote:
> > 
> > > The result shows that your additional patch fixed this issue!
> > > If possible, could you add Reported-and-tested-by tag from me.
> > 
> > After talking with Marco for a bit the patch now looks like the below.
> > I've tentatively retained your tested-by, except of course, you haven't.
> > 
> > If I could bother you once more to test the branch:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
> > 
>   Yes, sure, it's my pleasure! I will clone and test the origin/perf/urgent
>   branch in this repo and update the email soon.

I tested https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
perf/urgent branch kernel, in the 53171 times execution:

Only below dmesg info print, there is no any "__perf_event_overflow" Call
Trace, the result show that this issue was fixed in above kernel.
"
53171 times ./repro
...
[   59.184213] perf: interrupt took too long (2554 > 2500), lowering kernel.perf_event_max_sample_rate to 78250
[   59.658503] perf: interrupt took too long (3303 > 3192), lowering kernel.perf_event_max_sample_rate to 60500
[   60.157042] perf: interrupt took too long (4183 > 4128), lowering kernel.perf_event_max_sample_rate to 47750
[   60.917294] perf: interrupt took too long (5312 > 5228), lowering kernel.perf_event_max_sample_rate to 37500
[   62.370105] perf: interrupt took too long (6758 > 6640), lowering kernel.perf_event_max_sample_rate to 29500
[   64.074435] perf: interrupt took too long (8457 > 8447), lowering kernel.perf_event_max_sample_rate to 23500
[   66.916168] perf: interrupt took too long (10578 > 10571), lowering kernel.perf_event_max_sample_rate to 18750
[   70.556182] perf: interrupt took too long (13232 > 13222), lowering kernel.perf_event_max_sample_rate to 15000
[   76.730150] perf: interrupt took too long (16561 > 16540), lowering kernel.perf_event_max_sample_rate to 12000
[  557.595321] perf: interrupt took too long (20732 > 20701), lowering kernel.perf_event_max_sample_rate to 9500
"

Dmesg is in attached.

Thanks!
BR.

> 
> > ---
> > Subject: perf: Consider OS filter fail
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Sat, 19 Nov 2022 10:45:54 +0800
> > 
> > Some PMUs (notably the traditional hardware kind) have boundary issues
> > with the OS filter. Specifically, it is possible for
> > perf_event_attr::exclude_kernel=1 events to trigger in-kernel due to
> > SKID or errata.
> > 
> > This can upset the sigtrap logic some and trigger the WARN.
> > 
> > However, if this invalid sample is the first we must not loose the
> > SIGTRAP, OTOH if it is the second, it must not override the
> > pending_addr with an invalid one.
> > 
> > Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> > Link: https://lkml.kernel.org/r/Y3hDYiXwRnJr8RYG@xpf.sh.intel.com
> > ---
> >  kernel/events/core.c |   24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> > 
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9273,6 +9273,19 @@ int perf_event_account_interrupt(struct
> >  	return __perf_event_account_interrupt(event, 1);
> >  }
> >  
> > +static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
> > +{
> > +	/*
> > +	 * Due to interrupt latency (AKA "skid"), we may enter the
> > +	 * kernel before taking an overflow, even if the PMU is only
> > +	 * counting user events.
> > +	 */
> > +	if (event->attr.exclude_kernel && !user_mode(regs))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  /*
> >   * Generic event overflow handling, sampling.
> >   */
> > @@ -9306,6 +9319,13 @@ static int __perf_event_overflow(struct
> >  	}
> >  
> >  	if (event->attr.sigtrap) {
> > +		/*
> > +		 * The desired behaviour of sigtrap vs invalid samples is a bit
> > +		 * tricky; on the one hand, one should not loose the SIGTRAP if
> > +		 * it is the first event, on the other hand, we should also not
> > +		 * trigger the WARN or override the data address.
> > +		 */
> > +		bool valid_sample = sample_is_allowed(event, regs);
> >  		unsigned int pending_id = 1;
> >  
> >  		if (regs)
> > @@ -9313,7 +9333,7 @@ static int __perf_event_overflow(struct
> >  		if (!event->pending_sigtrap) {
> >  			event->pending_sigtrap = pending_id;
> >  			local_inc(&event->ctx->nr_pending);
> > -		} else if (event->attr.exclude_kernel) {
> > +		} else if (event->attr.exclude_kernel && valid_sample) {
> >  			/*
> >  			 * Should not be able to return to user space without
> >  			 * consuming pending_sigtrap; with exceptions:
> > @@ -9330,7 +9350,7 @@ static int __perf_event_overflow(struct
> >  		}
> >  
> >  		event->pending_addr = 0;
> > -		if (data->sample_flags & PERF_SAMPLE_ADDR)
> > +		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
> >  			event->pending_addr = data->addr;
> >  		irq_work_queue(&event->pending_irq);
> >  	}

--MaGdtKmJws5JEouo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="6.1-rc6_perf_urgent_fix_dmesg.log"

[    0.000000] Linux version 6.1.0-rc6-kvmpeter+ (root@xpf.sh.intel.com) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10), GNU ld version 2.36.1-2.el8) #1 SMP PREEMP2
[    0.000000] Command line: console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000007] kvm-clock: using sched offset of 2648030348 cycles
[    0.000562] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.002344] tsc: Detected 3110.400 MHz processor
[    0.011148] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.011171] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011194] last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
[    0.011833] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.023704] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.024500] Using GB pages for direct mapping
[    0.026408] ACPI: Early table checksum verification disabled
[    0.027049] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )
[    0.027704] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028687] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.029627] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.030540] ACPI: FACS 0x000000007FFE0000 000040
[    0.031028] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.031926] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.032816] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.033735] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ffe1870]
[    0.034486] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe17fc]
[    0.035275] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.036043] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ffe18f0]
[    0.036795] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ffe1928]
[    0.037569] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ffe1950]
[    0.039553] No NUMA configuration found
[    0.039999] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]
[    0.040797] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]
[    0.045324] Zone ranges:
[    0.045599]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.046269]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
[    0.046904]   Normal   empty
[    0.047210]   Device   empty
[    0.047511] Movable zone start for each node
[    0.047943] Early memory node ranges
[    0.048334]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.048981]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
[    0.049646] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdffff]
[    0.051200] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.051407] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.086650] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.087630] ACPI: PM-Timer IO Port: 0x608
[    0.088741] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.089397] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.090114] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.090784] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.091470] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.092174] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.092888] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.093613] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.094290] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.094835] TSC deadline timer available
[    0.095261] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.095870] kvm-guest: KVM setup pv remote TLB flush
[    0.096448] kvm-guest: setup PV sched yield
[    0.096991] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.097810] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.098594] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.099377] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.100180] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.100816] Booting paravirtualized kernel on KVM
[    0.101351] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.102515] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.105733] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u1048576
[    0.106516] pcpu-alloc: s217088 r8192 d28672 u1048576 alloc=1*2097152
[    0.106541] pcpu-alloc: [0] 0 1 
[    0.106734] kvm-guest: PV spinlocks enabled
[    0.107221] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.108031] Fallback order for Node 0: 0 
[    0.108466] Built 1 zonelists, mobility grouping on.  Total pages: 515808
[    0.109178] Policy zone: DMA32
[    0.109488] Kernel command line: net.ifnames=0 console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg
[    0.113612] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.115250] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.116229] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.120882] Memory: 1999736K/2096632K available (30736K kernel code, 4081K rwdata, 7528K rodata, 3624K init, 10528K bss, 96640K reserved, 0K cma-reserved)
[    0.123715] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.124507] kmemleak: Kernel memory leak detector disabled
[    0.125200] ftrace: allocating 66320 entries in 260 pages
[    0.161261] ftrace: allocated 260 pages with 2 groups
[    0.163906] Dynamic Preempt: voluntary
[    0.164427] rcu: Preemptible hierarchical RCU implementation.
[    0.165078] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
[    0.165875]  Trampoline variant of Tasks RCU enabled.
[    0.166605]  Rude variant of Tasks RCU enabled.
[    0.167262]  Tracing variant of Tasks RCU enabled.
[    0.167978] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.169102] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.204201] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
[    0.205163] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.214837] Console: colour VGA+ 80x25
[    0.215273] printk: console [ttyS0] enabled
[    0.216162] printk: bootconsole [earlyser0] disabled
[    0.217240] ACPI: Core revision 20220331
[    0.217959] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.219032] APIC: Switch to symmetric I/O mode setup
[    0.219815] x2apic enabled
[    0.220339] Switched APIC routing to physical x2apic.
[    0.220968] kvm-guest: setup PV IPIs
[    0.222397] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.223067] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2cd5a8bb032, max_idle_ns: 440795365915 ns
[    0.224232] Calibrating delay loop (skipped) preset value.. 6220.80 BogoMIPS (lpj=12441600)
[    0.225120] pid_max: default: 32768 minimum: 301
[    0.225813] LSM: Security Framework initializing
[    0.226324] Yama: becoming mindful.
[    0.226934] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.228249] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.232285] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.233470] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.234119] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.236314] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.237284] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.238442] Spectre V2 : Mitigation: Enhanced IBRS
[    0.238912] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.239725] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.240231] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.241052] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.365972] Freeing SMP alternatives memory: 56K
[    0.366829] smpboot: CPU0: Genuine Intel(R) CPU 0000 @ 2.20GHz (family: 0x6, model: 0x8d, stepping: 0x0)
[    0.368134] cblist_init_generic: Setting adjustable number of callback queues.
[    0.368220] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.368220] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.368220] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.368246] Performance Events: Icelake events, full-width counters, Intel PMU driver.
[    0.369160] ... version:                2
[    0.369552] ... bit width:              48
[    0.369965] ... generic registers:      8
[    0.370359] ... value mask:             0000ffffffffffff
[    0.370879] ... max period:             00007fffffffffff
[    0.371398] ... fixed-purpose events:   3
[    0.371790] ... event mask:             00000007000000ff
[    0.372531] rcu: Hierarchical SRCU implementation.
[    0.373009] rcu:     Max phase no-delay instances is 1000.
[    0.376357] smp: Bringing up secondary CPUs ...
[    0.377130] x86: Booting SMP configuration:
[    0.377544] .... node  #0, CPUs:      #1
[    0.378068] smp: Brought up 1 node, 2 CPUs
[    0.378068] smpboot: Max logical packages: 1
[    0.378068] smpboot: Total of 2 processors activated (12441.60 BogoMIPS)
[    0.383597] devtmpfs: initialized
[    0.384335] x86/mm: Memory block size: 128MB
[    0.386381] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.386381] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.388382] pinctrl core: initialized pinctrl subsystem

[    0.389409] *************************************************************
[    0.390072] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.390727] **                                                         **
[    0.391380] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.392034] **                                                         **
[    0.392226] ** This means that this kernel is built to expose internal **
[    0.392876] ** IOMMU data structures, which may compromise security on **
[    0.393529] ** your system.                                            **
[    0.394186] **                                                         **
[    0.394838] ** If you see this message and you are not debugging the   **
[    0.395490] ** kernel, report this immediately to your vendor!         **
[    0.396154] **                                                         **
[    0.396224] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.396877] *************************************************************
[    0.397588] PM: RTC time: 01:07:06, date: 2022-11-24
[    0.403066] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.404166] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.404241] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.404981] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.405782] audit: initializing netlink subsys (disabled)
[    0.406410] audit: type=2000 audit(1669252026.340:1): state=initialized audit_enabled=0 res=1
[    0.406410] thermal_sys: Registered thermal governor 'fair_share'
[    0.406410] thermal_sys: Registered thermal governor 'bang_bang'
[    0.406410] thermal_sys: Registered thermal governor 'step_wise'
[    0.408228] thermal_sys: Registered thermal governor 'user_space'
[    0.408838] cpuidle: using governor ladder
[    0.409849] cpuidle: using governor menu
[    0.410574] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.411517] PCI: Using configuration type 1 for base access
[    0.421875] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.664745] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.665462] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.666136] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.666817] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.669825] ACPI: Added _OSI(Module Device)
[    0.670279] ACPI: Added _OSI(Processor Device)
[    0.670734] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.671211] ACPI: Added _OSI(Processor Aggregator Device)
[    0.676564] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.679908] ACPI: Interpreter enabled
[    0.680299] ACPI: PM: (supports S0 S3 S4 S5)
[    0.680725] ACPI: Using IOAPIC for interrupt routing
[    0.681264] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.682180] PCI: Using E820 reservations for host bridge windows
[    0.683362] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.697143] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.697809] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.698650] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.699678] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.701941] acpiphp: Slot [3] registered
[    0.702423] acpiphp: Slot [4] registered
[    0.702889] acpiphp: Slot [5] registered
[    0.703350] acpiphp: Slot [6] registered
[    0.703815] acpiphp: Slot [7] registered
[    0.704286] acpiphp: Slot [8] registered
[    0.704749] acpiphp: Slot [9] registered
[    0.705225] acpiphp: Slot [10] registered
[    0.705697] acpiphp: Slot [11] registered
[    0.706171] acpiphp: Slot [12] registered
[    0.706645] acpiphp: Slot [13] registered
[    0.707119] acpiphp: Slot [14] registered
[    0.707604] acpiphp: Slot [15] registered
[    0.708076] acpiphp: Slot [16] registered
[    0.708283] acpiphp: Slot [17] registered
[    0.708765] acpiphp: Slot [18] registered
[    0.709244] acpiphp: Slot [19] registered
[    0.709719] acpiphp: Slot [20] registered
[    0.710191] acpiphp: Slot [21] registered
[    0.710663] acpiphp: Slot [22] registered
[    0.711149] acpiphp: Slot [23] registered
[    0.711632] acpiphp: Slot [24] registered
[    0.712107] acpiphp: Slot [25] registered
[    0.712288] acpiphp: Slot [26] registered
[    0.712757] acpiphp: Slot [27] registered
[    0.713228] acpiphp: Slot [28] registered
[    0.713709] acpiphp: Slot [29] registered
[    0.714197] acpiphp: Slot [30] registered
[    0.714670] acpiphp: Slot [31] registered
[    0.715121] PCI host bridge to bus 0000:00
[    0.715547] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.716227] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.716921] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.717688] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    0.718449] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.719225] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.719848] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.722829] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.724148] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.725950] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.727400] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.728139] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.728229] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.728957] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.729916] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.730879] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.731636] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.732495] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.736272] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.740066] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.745679] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.746933] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.750736] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.752114] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.752903] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.757012] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.773216] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.774204] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.775186] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.776132] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.776400] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.778500] iommu: Default domain type: Translated 
[    0.779022] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.780557] SCSI subsystem initialized
[    0.781147] libata version 3.00 loaded.
[    0.781273] ACPI: bus type USB registered
[    0.781787] usbcore: registered new interface driver usbfs
[    0.782402] usbcore: registered new interface driver hub
[    0.783010] usbcore: registered new device driver usb
[    0.783616] pps_core: LinuxPPS API ver. 1 registered
[    0.784157] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.784235] PTP clock support registered
[    0.784817] EDAC MC: Ver: 3.0.0
[    0.785311] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.786311] NetLabel: Initializing
[    0.786676] NetLabel:  domain hash size = 128
[    0.787130] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.787758] NetLabel:  unlabeled traffic allowed by default
[    0.788491] PCI: Using ACPI for IRQ routing
[    0.788938] PCI: pci_cache_line_size set to 64 bytes
[    0.789036] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.789049] e820: reserve RAM buffer [mem 0x7ffe0000-0x7fffffff]
[    0.789149] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.789782] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.790346] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.791212] vgaarb: loaded
[    0.792081] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.792228] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    3.793006] clocksource: Switched to clocksource kvm-clock
[    3.911698] VFS: Disk quotas dquot_6.6.0
[    3.912213] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.913112] pnp: PnP ACPI init
[    3.913769] pnp 00:02: [dma 2]
[    3.915025] pnp: PnP ACPI: found 6 devices
[    3.925973] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.927212] NET: Registered PF_INET protocol family
[    3.928755] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    3.932799] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    3.933711] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    3.934639] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    3.935768] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    3.937062] TCP: Hash tables configured (established 16384 bind 16384)
[    3.937893] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    3.938679] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    3.939611] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.940879] RPC: Registered named UNIX socket transport module.
[    3.941498] RPC: Registered udp transport module.
[    3.941974] RPC: Registered tcp transport module.
[    3.942480] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.943255] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.943860] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    3.944476] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.945310] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
[    3.946118] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    3.947023] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    3.947618] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.948438] PCI: CLS 0 bytes, default 64
[    3.949190] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2cd5a8bb032, max_idle_ns: 440795365915 ns
[    3.953540] Initialise system trusted keyrings
[    3.954187] Key type blacklist registered
[    3.954784] workingset: timestamp_bits=36 max_order=19 bucket_order=0
[    3.961243] zbud: loaded
[    3.962675] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.964691] NFS: Registering the id_resolver key type
[    3.965231] Key type id_resolver registered
[    3.965640] Key type id_legacy registered
[    3.966127] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    3.966776] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    3.968303] fuse: init (API version 7.37)
[    3.968962] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    3.971007] 9p: Installing v9fs 9p2000 file system support
[    3.980798] Key type asymmetric registered
[    3.981214] Asymmetric key parser 'x509' registered
[    3.982816] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    3.983522] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    3.984371] io scheduler mq-deadline registered
[    3.984929] io scheduler bfq registered
[    3.986010] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.986945] IPMI message handler: version 39.2
[    3.987506] ipmi device interface
[    3.989059] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    3.989902] ACPI: button: Power Button [PWRF]
[    3.991093] ERST DBG: ERST support is disabled.
[    3.992030] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.992819] serial 00:04: GPIO lookup for consumer rs485-term
[    3.992831] serial 00:04: using ACPI for GPIO lookup
[    3.992844] acpi PNP0501:00: GPIO: looking up rs485-term-gpios
[    3.992856] acpi PNP0501:00: GPIO: looking up rs485-term-gpio
[    3.992865] serial 00:04: using lookup tables for GPIO lookup
[    3.992878] serial 00:04: No GPIO consumer rs485-term found
[    3.993126] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.999688] Linux agpgart interface v0.103
[    4.000585] ACPI: bus type drm_connector registered
[    4.010431] brd: module loaded
[    4.017494] loop: module loaded
[    4.019648] ata_piix 0000:00:01.1: version 2.13
[    4.021003] scsi host0: ata_piix
[    4.021847] scsi host1: ata_piix
[    4.022314] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    4.022999] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    4.024095] mdio_bus fixed-0: GPIO lookup for consumer reset
[    4.024106] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    4.024115] mdio_bus fixed-0: No GPIO consumer reset found
[    4.024399] tun: Universal TUN/TAP device driver, 1.6
[    4.025187] e100: Intel(R) PRO/100 Network Driver
[    4.025746] e100: Copyright(c) 1999-2006 Intel Corporation
[    4.026333] e1000: Intel(R) PRO/1000 Network Driver
[    4.026906] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    4.126917] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    4.180429] ata1: found unknown device (class 0)
[    4.181382] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    4.181947] ata1.00: 16777216 sectors, multi 16: LBA48 
[    4.182741] ata2: found unknown device (class 0)
[    4.183860] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    4.185097] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    4.186026] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB/8.00 GiB)
[    4.187034] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    4.187766] sd 0:0:0:0: [sda] Write Protect is off
[    4.188294] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.188535] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.189894] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    4.191570] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    4.213689] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.220732] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    4.455489] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    4.456198] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.456992] e1000e: Intel(R) PRO/1000 Network Driver
[    4.457511] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.458148] igb: Intel(R) Gigabit Ethernet Network Driver
[    4.458724] igb: Copyright (c) 2007-2014 Intel Corporation.
[    4.459480] PPP generic driver version 2.4.2
[    4.460345] VFIO - User Level meta-driver version: 0.3
[    4.461336] usbcore: registered new interface driver uas
[    4.461910] usbcore: registered new interface driver usb-storage
[    4.462626] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    4.464037] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.464541] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.465555] mousedev: PS/2 mouse device common for all mice
[    4.466582] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    4.468156] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    4.469035] rtc_cmos 00:05: RTC can wake from S4
[    4.470006] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    4.470431] rtc_cmos 00:05: registered as rtc0
[    4.471666] rtc_cmos 00:05: setting system clock to 2022-11-24T01:07:14 UTC (1669252034)
[    4.472538] rtc_cmos 00:05: GPIO lookup for consumer wp
[    4.472547] rtc_cmos 00:05: using ACPI for GPIO lookup
[    4.472557] acpi PNP0B00:00: GPIO: looking up wp-gpios
[    4.472567] acpi PNP0B00:00: GPIO: looking up wp-gpio
[    4.472576] rtc_cmos 00:05: using lookup tables for GPIO lookup
[    4.472585] rtc_cmos 00:05: No GPIO consumer wp found
[    4.472648] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    4.473557] i2c_dev: i2c /dev entries driver
[    4.474069] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    4.475457] device-mapper: uevent: version 1.0.3
[    4.476124] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    4.476963] intel_pstate: CPU model not supported
[    4.477520] sdhci: Secure Digital Host Controller Interface driver
[    4.478241] sdhci: Copyright(c) Pierre Ossman
[    4.478779] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.479427] ledtrig-cpu: registered to indicate activity on CPUs
[    4.480236] drop_monitor: Initializing network drop monitor service
[    4.481340] NET: Registered PF_INET6 protocol family
[    4.483493] Segment Routing with IPv6
[    4.483905] In-situ OAM (IOAM) with IPv6
[    4.484366] NET: Registered PF_PACKET protocol family
[    4.485094] 9pnet: Installing 9P2000 support
[    4.485620] Key type dns_resolver registered
[    4.486665] IPI shorthand broadcast: enabled
[    4.487125] sched_clock: Marking stable (4472056370, 14355862)->(8546483179, -4060070947)
[    4.488290] registered taskstats version 1
[    4.488762] Loading compiled-in X.509 certificates
[    4.490275] zswap: loaded using pool lzo/zbud
[    4.491155] Key type .fscrypt registered
[    4.491539] Key type fscrypt-provisioning registered
[    4.492829] Key type encrypted registered
[    4.493263] ima: No TPM chip found, activating TPM-bypass!
[    4.493810] ima: Allocated hash algorithm: sha1
[    4.494276] ima: No architecture policies found
[    4.494741] evm: Initialising EVM extended attributes:
[    4.495236] evm: security.selinux
[    4.495558] evm: security.SMACK64
[    4.495880] evm: security.SMACK64EXEC
[    4.496254] evm: security.SMACK64TRANSMUTE
[    4.496662] evm: security.SMACK64MMAP
[    4.497020] evm: security.apparmor
[    4.497352] evm: security.ima
[    4.497644] evm: security.capability
[    4.497992] evm: HMAC attrs: 0x1
[    4.502487] PM:   Magic number: 14:3:105
[    4.503236] RAS: Correctable Errors collector initialized.
[    4.504108] md: Waiting for all devices to be available before autodetect
[    4.504566] md: If you don't use raid, use raid=noautodetect
[    4.504932] md: Autodetecting RAID arrays.
[    4.505195] md: autorun ...
[    4.505377] md: ... autorun DONE.
[    4.514777] EXT4-fs (sda): INFO: recovery required on readonly filesystem
[    4.515220] EXT4-fs (sda): write access will be enabled during recovery
[    4.533528] EXT4-fs (sda): recovery complete
[    4.535374] EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
[    4.535931] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
[    4.538323] devtmpfs: mounted
[    4.547356] Freeing unused decrypted memory: 2036K
[    4.550245] Freeing unused kernel image (initmem) memory: 3624K
[    4.550633] Write protecting the kernel read-only data: 40960k
[    4.553741] Freeing unused kernel image (text/rodata gap) memory: 2028K
[    4.554750] Freeing unused kernel image (rodata/data gap) memory: 664K
[    4.660373] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.660840] Run /sbin/init as init process
[    4.661110]   with arguments:
[    4.661116]     /sbin/init
[    4.661122]   with environment:
[    4.661126]     HOME=/
[    4.661131]     TERM=linux
[    4.755876] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[    4.780538] systemd[1]: systemd 239 (239-49.el8) running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +G)
[    4.782044] systemd[1]: Detected virtualization kvm.
[    4.782390] systemd[1]: Detected architecture x86-64.
[    4.839652] systemd[1]: Set hostname to <test>.
[    5.904236] random: crng init done
[    6.005325] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    6.011242] systemd[1]: Listening on Process Core Dump Socket.
[    6.012298] systemd[1]: Listening on udev Kernel Socket.
[    6.013212] systemd[1]: Listening on udev Control Socket.
[    6.014223] systemd[1]: Listening on Journal Socket.
[    6.032445] systemd[1]: Mounting Huge Pages File System...
[    6.204262] EXT4-fs (sda): re-mounted. Quota mode: none.
[    7.920284] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    7.921178] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    8.182278] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    8.183001] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[   59.184213] perf: interrupt took too long (2554 > 2500), lowering kernel.perf_event_max_sample_rate to 78250
[   59.658503] perf: interrupt took too long (3303 > 3192), lowering kernel.perf_event_max_sample_rate to 60500
[   60.157042] perf: interrupt took too long (4183 > 4128), lowering kernel.perf_event_max_sample_rate to 47750
[   60.917294] perf: interrupt took too long (5312 > 5228), lowering kernel.perf_event_max_sample_rate to 37500
[   62.370105] perf: interrupt took too long (6758 > 6640), lowering kernel.perf_event_max_sample_rate to 29500
[   64.074435] perf: interrupt took too long (8457 > 8447), lowering kernel.perf_event_max_sample_rate to 23500
[   66.916168] perf: interrupt took too long (10578 > 10571), lowering kernel.perf_event_max_sample_rate to 18750
[   70.556182] perf: interrupt took too long (13232 > 13222), lowering kernel.perf_event_max_sample_rate to 15000
[   76.730150] perf: interrupt took too long (16561 > 16540), lowering kernel.perf_event_max_sample_rate to 12000
[  557.595321] perf: interrupt took too long (20732 > 20701), lowering kernel.perf_event_max_sample_rate to 9500

--MaGdtKmJws5JEouo--
