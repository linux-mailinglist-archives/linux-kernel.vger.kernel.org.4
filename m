Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2401749E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGFOFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGFOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:05:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702571BF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688652307; x=1720188307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wrpfq+FXTdMZfXeDd8SX7ScKSjrBxvyZlIlzWJ+lh1Q=;
  b=QODVlEJSRMp4SKM//vM7d5bhBJjUkE1jiCM1N2VaHEzcGXtJAlnUvWtc
   4rCFaI8a1UaUkDUOCiWIa+BO7zP9pTTGtUO6dXuX18/jbdHki35TUJ63E
   uDDzpKjBDJUnfz9+rdnNfgsbIzdX8ni6Jbt919nJ7BiVoezuJmVDQSNVs
   S5Hw6c6r/iLYZy6CsFG3jCkK67MvIVYBp5LdO14XUpEPT6SpoUXr7tKqW
   0wMYTXkk8WPUkJTEUzeJGWvSSDZRIPEnr4Y//hCa7I9oUBW9GQUWArEJg
   AWYL7Aft0svfZbVmIYjKoA7ZSDlScW573fdbvXlfFlJzbn6vOE5t4kQ2b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="343198178"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343198178"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="719585510"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719585510"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 07:05:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:05:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:05:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 07:05:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 07:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrCMQhgK3inM8tHXMe/3BsdijOXkswK2Aq/saXMEuVmfbnUxSFG2txLdQgGN0CezqVarnWMUpZ5SDE1WekzcLii/oWsbXJkXKTxSmAfZ5rgpA/4LjZ14LYbZCK/W/s1XHqFhPiZV0chQpEsG5nuuj7SJIjL1VE0vQLLV0+9ZoRwYE11LbmRsJPv/jNimLHMFPpNk5Yvmx8YyXF/1WtBoNUduQDzdU0I3wuj1oB6TuEOo8mLJQpavpsJ5FZ1R8DV3aDxTONFhYYHJQrtiCtGFhu8+W8YrPNcf/t15dcNspKoyPXvMqmFhzNOB4jEXRP4264dnB0YYo5v53i+tBaVsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMMQHdIcouvHfZ4v4mgH/mFKrqYMNao7aFglDcdR6MA=;
 b=avfPv9ua0ejEWqXGGqPDgSUAp9zaBzIZj18mGESUBNGi1bBkXk0S36qf7UoZ2LNHkqR9+eJWG6EXL/vSg97ePICIooGurDzxmdwxUfT7r+rbdpO8Jr5+DdJhK6m+lIqQX5kildG6M/1FMdB8ucTK7s0f7rmWLzXEtmENDN7oDG0pjTlaHyO3zzECOGjpph0gVKW3ghtp1vI7QYVJ8VxTcQ4BeH/lZYZDvlOL4wlpM9TgtFrOaZmAIEpU1P7AEI+oLNYhd0KmsxGSk/T9ZoUNqyhQAIQMUHJ2unakFoD5Me7Ly8RB22y9HBoYYJzbdyegMsWmlez0PS93kjyqPtIdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3260.namprd11.prod.outlook.com (2603:10b6:5:b::30) by
 SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 14:05:02 +0000
Received: from DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::5dbb:4867:7dc0:c5a8]) by DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::5dbb:4867:7dc0:c5a8%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:05:02 +0000
From:   "Deng, Pan" <pan.deng@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
CC:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Tianyou" <tianyou.li@intel.com>, "Ma, Yu" <yu.ma@intel.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Thread-Topic: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Thread-Index: AQHZpBf8y9gtMyr/606YJQEIlMf8Fa+cm1MAgAHc14CAAGHSAIAN/vVg
Date:   Thu, 6 Jul 2023 14:05:02 +0000
Message-ID: <DM6PR11MB3260465D9B5D636F6EE85C64962CA@DM6PR11MB3260.namprd11.prod.outlook.com>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <20230627101437.GY4253@hirez.programming.kicks-ass.net>
 <DM6PR11MB3260026F33333A70AF2F02169627A@DM6PR11MB3260.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3260026F33333A70AF2F02169627A@DM6PR11MB3260.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3260:EE_|SA3PR11MB7414:EE_
x-ms-office365-filtering-correlation-id: d687a78a-21b2-4f15-5faf-08db7e29fe2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8L1eNp8s1lTt2L0tO+sEpnyhKkxB+rYXt0hSICGNnVCj9cF1iSLuVRAc3MdchwkzatRnRrajhMqE+HjvLPKVg6Zp/o/vGqd31+mlz0gbgpB46bHhZRL+VtJlGhuPts67/kV3KcpRPIXztq+QTMB7uQq2MIS9cl5DIfnfDbGsx0eZi19UxwXFou04201Rqyv9b99jw0TvrOeIx8yyb6Q7NNd8s4ceqpplTVzVf5mlDjAmLG87yxuWUr1AoXsY3pUCDWO6UhXVl9sgUll7Fydd/ueaAyFi+0lsWBbIW+VzMb70QJDoOFgTVaT18tVyGJ3OgugXxUvCh7N2HPeiaegHx7KhvsNQyNseYfzuXyWDNmcQsZdeqzT3kdweCL+HJZ6TG/LezMOYRL0wdqwrFazmbB1lzKLhYid4QrTYXhX+qWMJhEFP+aYyYLIhxV2uxCbZrqalLSp8jxRw5NjL/OA5zLrQEjTFRW8huFKTS8AhCKnLcE4FyUlNhzEdmznCO05fZkg5GcW5aHyZfx23PPv8IlU86G1FactAYxoYyO2WRi4jZessibKgh36ez9jPICrgmKN2M4chWSoImOrZknKRSIypIpS5L29ZgQMw3YViaA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(8936002)(41300700001)(316002)(4326008)(6636002)(66446008)(66556008)(66946007)(66476007)(76116006)(5660300002)(64756008)(8676002)(52536014)(38070700005)(2906002)(54906003)(478600001)(110136005)(33656002)(55016003)(9686003)(53546011)(7696005)(71200400001)(26005)(186003)(86362001)(6506007)(38100700002)(82960400001)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SUszkB2Tjf2vDquPOBsGjH7bddmjzc4o6MSWXNQWcD/hzP5sXV+Z9fVimncY?=
 =?us-ascii?Q?G+zrXXKQmvtQUlA/GsGbTnuIOA+xGNDjGxEFXqBFdD97c8nwvxRuaONokNB/?=
 =?us-ascii?Q?nJbYhkBV2zriRuYynw1L/eAFvXMSgvRzoo8qfhb/9wzhF+mFIMuuLJyQ8O1w?=
 =?us-ascii?Q?T0punhr/YB9usDzf8KxoBTveEPqsHn+lIRgOL5KPTnrNL3lBF5tjizpgPqKv?=
 =?us-ascii?Q?ER5681QqVzwg9ut/tb5Isv6x614KOTpYpVWc5khw0mQ6R6UttF9cXPfRZXmy?=
 =?us-ascii?Q?m1kSeHfygdx5g7LKxmRn+xJosFkN6UFcuQ0xFSSUtNBeEzh12h+iTQ8yUWSc?=
 =?us-ascii?Q?lND9QbCSR0Xck22l78OISK7UaahRUKKZb/Eom1Q6JBtvc9HGAzyKa2cN+3JT?=
 =?us-ascii?Q?jjObfY3WYzPUK/XXKZICXddOaolhWtnMQ1g0UA9SqFQ9usEzGUU8mY0A1Jia?=
 =?us-ascii?Q?9UlJ/thBYBgQG24iBz64NWhIdwxVZL1+KlFWIjX1FqyDSGulqn3h2rMb6lP4?=
 =?us-ascii?Q?Aclr6cmpsiUZsolb0DaRRxvwKCLD9Gp9YzM7ExiCGnfNGYPKEn3B3bb0zhHS?=
 =?us-ascii?Q?/vONDkbpPtgxgbIkp3l6koLxZBEOYmQtgTj7b9J1ti1tMbXC2mY8KyPOBhEU?=
 =?us-ascii?Q?1ByVdvXzZAD6kwpV66Uz3kcT9y1jEmYt/LkAgsU7XF4Kl/VwVY9CV6Du0pX2?=
 =?us-ascii?Q?bQobfANiffo+O/oUVN5AKlSkDR95R/DgRqxAaWH6XKFr5nCoKmLlXfYli3/E?=
 =?us-ascii?Q?j6hxAHFyhO/ue1aKv/5xhktCFOok4c5ddhsEZd0rOS3VM/5cBStAaVRtFUp3?=
 =?us-ascii?Q?BrulWopTOI4oUJbr6+k1ru8/YmuNmoxToya/MU4f1Qq6DP2bOo/IH7XMoSfA?=
 =?us-ascii?Q?cBLFUakkxowh98e1V3J8mHa/ymPZSmtGg4kVuvZ640TF1wjGKGfAc4uR32cg?=
 =?us-ascii?Q?2DFaFr6YlkeZ4mNuzCfhQV+9lflEW3ZdCd4ksCe73uslEju2w6igAuINMrWK?=
 =?us-ascii?Q?zdGDDtBGjYAopQcdD6PEEBYYtwrXFgyUgre5eMSpUjJdUEnDZFAblH7rkvg+?=
 =?us-ascii?Q?yyOeY4PIkXW4PoMTlGtTN2m5Tq2vwdTOE3FnMdIu1notgpR1QaF/nlfJJuHB?=
 =?us-ascii?Q?Ev2gQQgePwDYfSPIDvJfuW+tQtVT1GkkVaWTcRDNkkJrvkePimh72KXun/O/?=
 =?us-ascii?Q?GhHZVI2eGObLegj2nVWJXbNu1LI19XeSPjBlYBngnM7wcJGrG/Z2DuNrhm/a?=
 =?us-ascii?Q?MsWrwIxpe6JdZWooO2Cs7IS/AMbgarTRRK6IRT1nIXxQ09GlBI7zdu3hs59h?=
 =?us-ascii?Q?iFiuVvYKs3zwi6YXa/VY++3N7gUnFY0rI1T6JD/UHEZkAGCt3u3hrbrUoehh?=
 =?us-ascii?Q?ewsbO/9fCq17VUh8eBXDDmOak45BvgnJ4GzIhqPAlzcZVwWmwEsbP/T00iFI?=
 =?us-ascii?Q?EX+G2Zy1tYXm/BQsLBpeaapNjBLG0oUay2vSn3gNahG9I+NYWavLOAZhae2/?=
 =?us-ascii?Q?SpdiPlvqff/VNII2lZlJNIWydR+ljuZtMV8lHlbVf/llsQ11eJ+8fBzouH4c?=
 =?us-ascii?Q?+5jC+f8w7exlE+bBOGwJoTBjrvaj3LXHPtthYc4c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d687a78a-21b2-4f15-5faf-08db7e29fe2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:05:02.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4uKI966Uz2EU3UEu67DhINqFLT3Y+rKQTlaBQahBfSO8tK5Tw4xF80Cf33SxjfDcfgzUWubrGunfirz2ocg/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> -----Original Message-----
> From: Deng, Pan
> Sent: Wednesday, June 28, 2023 12:13 AM
> To: Peter Zijlstra <peterz@infradead.org>; Lu, Aaron <aaron.lu@intel.com>
> Cc: Chen, Tim C <tim.c.chen@intel.com>; vincent.guittot@linaro.org; linux=
-
> kernel@vger.kernel.org; Li, Tianyou <tianyou.li@intel.com>; Ma, Yu
> <yu.ma@intel.com>; Zhu, Lipeng <lipeng.zhu@intel.com>; Chen, Yu C
> <yu.c.chen@intel.com>; Tim Chen <tim.c.chen@linux.intel.com>
> Subject: RE: [PATCH v2] sched/task_group: Re-layout structure to reduce
> false sharing
>=20
>=20
>=20
> > -----Original Message-----
> > From: Peter Zijlstra <peterz@infradead.org>
> > Sent: Tuesday, June 27, 2023 6:15 PM
> > To: Lu, Aaron <aaron.lu@intel.com>
> > Cc: Deng, Pan <pan.deng@intel.com>; Chen, Tim C
> > <tim.c.chen@intel.com>; vincent.guittot@linaro.org;
> > linux-kernel@vger.kernel.org; Li, Tianyou <tianyou.li@intel.com>; Ma,
> > Yu <yu.ma@intel.com>; Zhu, Lipeng <lipeng.zhu@intel.com>; Chen, Yu C
> > <yu.c.chen@intel.com>; Tim Chen <tim.c.chen@linux.intel.com>
> > Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to
> > reduce false sharing
> >
> > On Mon, Jun 26, 2023 at 01:47:56PM +0800, Aaron Lu wrote:
> >
> > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h index
> > > > ec7b3e0a2b20..4fbd4b3a4bdd 100644
> > > > --- a/kernel/sched/sched.h
> > > > +++ b/kernel/sched/sched.h
> > > > @@ -389,6 +389,19 @@ struct task_group {  #endif  #endif
> > > >
> > > > +	struct rcu_head		rcu;
> > > > +	struct list_head	list;
> > > > +
> > > > +	struct list_head	siblings;
> > > > +	struct list_head	children;
> > > > +
> > > > +	/*
> > > > +	 * To reduce false sharing, current layout is optimized to make
> > > > +	 * sure load_avg is in a different cacheline from parent, rt_se
> > > > +	 * and rt_rq.
> > > > +	 */
> >
> > That comment is misleading I think; you don't particularly care about
> > those fields more than any other active fields that would cause false
> sharing.
> >
>=20
> How about this one:
> 	/*
> 	 * load_avg can also cause cacheline bouncing with parent, rt_se
> 	 * and rt_rq, current layout is optimized to make sure they are in
> 	 * different cachelines.
> 	 */
>=20
Does it work for you? Please feel free to drop any suggestion.

> > > > +	struct task_group	*parent;
> > > > +
> > >
> > > I wonder if we can simply do:
> > >
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h index
> > > ec7b3e0a2b20..31b73e8d9568 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -385,7 +385,9 @@ struct task_group {
> > >  	 * it in its own cacheline separated from the fields above which
> > >  	 * will also be accessed at each tick.
> > >  	 */
> > > -	atomic_long_t		load_avg ____cacheline_aligned;
> > > +	struct {
> > > +		atomic_long_t		load_avg;
> > > +	} ____cacheline_aligned_in_smp;
> > >  #endif
> > >  #endif
> > >
> > > This way it can make sure there is no false sharing with load_avg no
> > > matter how the layout of this structure changes in the future.
> >
> > This. Also, ISTR there was a series to split this atomic across nodes;
> > whatever happend to that, and can we still measure an improvement over
> > this with that approach?
>=20
> I just ran unixbench context-switching in 1 node with 40C/80T, without th=
is
> change perf c2c data shows c2c bouncing is still there, perf record data
> shows set_task_cpu takes ~4.5% overall cycles. With this change, that fal=
se-
> sharing is resolved, and set_task_cpu cycles drop to 0.5%.
>=20
I mean even the only 1 NUMA node situation, this change benefits.
Aaron posted his performance data of "split atomic across nodes" over this =
patch=20
@https://lore.kernel.org/lkml/20230630093500.GA579792@ziqianlu-dell/,=20
looks they are complementary, so is it possible to merge this change firstl=
y?

Thanks
Pan

> Thanks
> Pan
