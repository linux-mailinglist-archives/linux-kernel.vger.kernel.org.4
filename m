Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B65EB34A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIZVkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiIZVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:40:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B4E72FCC;
        Mon, 26 Sep 2022 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664228406; x=1695764406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xhyLBgf649ayDq4epEkAJ7hHZa4FdgwMU7cIvz2MiY8=;
  b=Hl+ktm/P8NV/rJnZe3xL1oq6+f2VLBtA1zdIhUFQUivbJ3rSpK3m03Ux
   yw5wWas50W3B2LSxeirOjDvCnIxMoNHtoWTIwv96NL7ZURerk4W3o3zTs
   oMsIO2rHYYlMe5E9iY18AoZsO+TcS+/D5Gt3ZvmlxOOsxTH5QIK4m7Ouh
   Sp/+mPiZJqm3v2OYfseCPLX7TVIH7sFQJP6goxASQu/Yz/allwllTnFMC
   +XosTwaGyQHHgwABeeSSlwTXUGKIEYZe1RUz9HhW022rG0MIozxW/JOuF
   axFucUrMV3FQi0bTQIQ6iHeb/IlmVST6xqecOh3o+f7m+HpL1dQU3Atsr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="281521912"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="281521912"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="652003705"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="652003705"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2022 14:40:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:40:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:40:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 26 Sep 2022 14:40:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 26 Sep 2022 14:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq4wkCjaAO4a3b/QB/lrK2AVAhHvDGI7aDWZo4GC98MRoL4qe1U3dX5MHnTYGxMfJpDkDfopPvtbiEioBeg4rqFrBhAWg2xK6PiUkgicu8WWB51Jn720odUQ0U0Fh1ZcUuh5DU/YZaYRo995Qiht8eYcsnQYxTs6Iq+W+4eX+CTSNijaeDEtoCi99Gnru7G+ZVk4qlqkRZvZgBGzIFz5e9RVToj2zenFjUf8p/98FtDXe34pSqkkZr1z+bcEmqm0uIpu2ALA6eT8bMYrdIcCnWvuATBAR4tKhuCr6ZOI4fISNS7Iqf3xUXJLEBSIEGEsdToW6i5dtVlgS2J5ghJphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lev+Q8i7oKKCvOXgQHkltA/LHeJ0IF2zKu+VjsP4/ko=;
 b=dhhNt0DpoteGPknNrGjX4DU8/Ks8RRq6OY6uohR0n2SGgtd+JF5S8RSSgQXzLjValLvrFMbHFHfXxxndOoMMp7elXzDkMpcpGNJvB9e9dZMnGyHoPY/8vR2IKWFxFSjxjTAoV+6kUBdF6DUcUVN5qpKPG7qBc+oQ2H6oidk+Pv0KbKNTlhyDTEVpgmyShJsmBkYFOgxYxzYCHMVclQkPlA1fXHbN89zREggzURniVm4PqOhSkc+UunSoRcyawJ5pdOEbnNpBJd1v5gcAqEFpfqO0ImgrueAv8RuyEpgxod7JNyE9XumOvnXl+SyB1zCx3LC2803io5X9xyk0TRqh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5581.namprd11.prod.outlook.com (2603:10b6:a03:305::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 21:39:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.022; Mon, 26 Sep 2022
 21:39:55 +0000
Date:   Mon, 26 Sep 2022 14:39:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 7/9] cxl/test: Add generic mock events
Message-ID: <YzIcKFSRtXHiuG0+@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-8-ira.weiny@intel.com>
 <20220825123119.00000705@huawei.com>
 <YyN0qY5yaXwTwLDF@iweiny-desk3>
 <20220920171748.00001260@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220920171748.00001260@huawei.com>
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: a262663b-518c-4961-f119-08daa007a73d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRydyY62/+RIcHHEu43GbqgN6CmJQpEUzbOJcZURpWiN7HllJ84vPtASxHkRVihw9YRjzLDPr6la/rdRPZC338KQcikHmZtJnUr04KfnNHZQbZz0LRC5IeTuEnFnnivyzDDKHwkyHl3ykMTlFYkqfYbZ4tV2NaiJg4THxxNEMCpOAMvbOFQ+LM7/7uUT72f+6Y9WNwwppZVpyAer2f4/bPtzEsqSKnep/bwySHKEuIfguSN50PzAapRPFaYSU4eWQHWzyQMbY1ATUoCzUnDwgURIlhCVFAd+dbpgThA3UJ0S87vGpPgjm0eR6cJ8Wa+c+IRaRCPzLR9PUJUXTN7QixYj0XN9MX1veIJyAMS/WlPxdsOdNrEUfSC5a2IbB5gH6t3Nir89Qm04qRqtvom/3JkXM9oLZn5dJirscQdUD6sitHH9zyKHjcTPWaGCuxNuWJm8/Bm63lC5XjGd3sa+v5J0+aBfMWoWj52FU3WVo7j1uXe/W0hK6pY0Xb2bGKsnlunKkSXj4BwWBykp1/CsUDj94z0txoRbpODLsXHaWej/K9QD8Doss/TYdQXHCi378T8jmvh6Xd48HCXiBoyaFSKWslt+tLChg42F0FUHERzWL7Au25fFsoifZux2ngAP6XiOMI8fio8O1i19aeiGt0y5eHdTJ/B+erR4FKsSHK/SWYBm+ha+V6aznL1xoOJkui40NznKDoFDgFu+AWCY1U+7027T/z9EQExMqGREWLeAwSFp89Y4fu2q5lM/WxT+pshj8ZsNrEgo8ovppywXyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(8676002)(66946007)(41300700001)(9686003)(26005)(6512007)(33716001)(2906002)(44832011)(86362001)(66556008)(186003)(4326008)(5660300002)(478600001)(6666004)(6486002)(8936002)(316002)(82960400001)(38100700002)(6506007)(6916009)(66476007)(54906003)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gR7aeh6m47x66eS/KiucHyOd3H56YSyHck0jRPnJoPFOr6QfD0QMKBNA7Vqb?=
 =?us-ascii?Q?T+K1ARNP/EC7DA8/V8avKuhv2O0qFapE+r5fhFC/hWrGKKtJH8ymaqcmGrAy?=
 =?us-ascii?Q?3IUsuWncE0PTn6OzH79cLTwdcw2tWQT7Hd7652cgegb5o1RNN0IwYBIpp6EO?=
 =?us-ascii?Q?i7VcukgIuzhhwbsMLk8Te3yPwqKOqdhlQGO/OO+/vsb5du6WcdkkFl3dRQuv?=
 =?us-ascii?Q?5cbQFIn5ir6W5XJsqZsoAYVKiCTBv1MjAh/327xW7jtS+ozSxcjm75rtXuCn?=
 =?us-ascii?Q?51k8hbJLLLAfgrojHyiakYHbu1XO0nRAcf4z6hKfC/PgpIBr2AcZWR1csS/H?=
 =?us-ascii?Q?mRAWAWS1sEgTsO0hTINWV3P3VZLka9K350/vZ7F1578raomyZWL/EoAEjqaj?=
 =?us-ascii?Q?yX0jQbKPRwZaoDYUkT34ytgnmw59+HLCXgEom6TwZM++/mEfCT8q+d1/7L2E?=
 =?us-ascii?Q?WGtkYkyheKiYYGB5qH4Kldn81dOdSbuCiYcTBCJlfMFI9TCD4S7YtX0VMeS3?=
 =?us-ascii?Q?8oVaqDG/PF7NSgmniUdvDsA10Efp7X8186iklV987EiXKxgSnOZucoadTMN+?=
 =?us-ascii?Q?6OmpoIucVJL7fBwdyhK0x/q4Qd8b8pbkJ8aHgwcc0/yIEkMQ4BGbnz7KWNUX?=
 =?us-ascii?Q?+xz+4BQlMmrSllTDsUgjZY8R4iO/4vPYFjpBSY0KoP8cPQ3vBSjq8/lGLN20?=
 =?us-ascii?Q?pkKfF6hytfUreMQzA4TLadpL+K99y+aCJX3W2/GGFFg14w7j5sJLdNxydZN3?=
 =?us-ascii?Q?BhN87fsy7u0ETyVvvNp+18vk/PbLTFAxinvJXgFR29PvclcQ4s/IwYDZ9inn?=
 =?us-ascii?Q?Q5pjaUfi66ImLzRcwSRy+pimRhDaVYCCDP3jMEmypyWtKy54dQXINS13lBzb?=
 =?us-ascii?Q?i+rO+2KdxeF2vKbblhMGI+1QlqVvXjulIgGLxMiebyb7ehbxz0ZWWsdZ/Rj6?=
 =?us-ascii?Q?m15+Zv0PGOmZFtjFPyCM4QSFcOnMO00UYBwl1xkJjd9h4r+9xwlLLqbeAHGs?=
 =?us-ascii?Q?JVFK/Doon5MgkapydRetVnoW7vClXKZ81SITH3xfMaAiXmMsFcHYhZjH6Glu?=
 =?us-ascii?Q?uCoFUbf3oFl1u0YYFNJPmTs1NLy2oyJvRB3ytkQd0JwWVxpNoUFN3KQNg0D1?=
 =?us-ascii?Q?UtKl8iBu1Un7BEHT5281URX06ofVQ/3FSlrGOI0FIZD5hSLENJuaNWccTWhV?=
 =?us-ascii?Q?tbvL5fE83Kl1FfJOt5MZ4vSM857UWjSYGvWRk++x6J/k01wNytUoQUv0iS/j?=
 =?us-ascii?Q?jMGrx6k3td4Jmt+IAsVNqJaJFCBBR9RioX1tTzeJusuXjT6fWSa48sfezego?=
 =?us-ascii?Q?iyEb96LHnXmVY2/TRJOiWNznmuLes6xX6lW/0xM8e6GFRJWtY0L/mQqp4VbD?=
 =?us-ascii?Q?lKIbD9dDZyDaHVa2a6hZUkBZZ2vgNBz3d5G7FViuQM17GrzodSQYNWzup4ZH?=
 =?us-ascii?Q?ktqMm+O+9DSiNllwuoifOCds41mMCxMoywm2OhH4bEsNHLD7KmfiClee/NDt?=
 =?us-ascii?Q?Mgs3hja0YJ/meVvivwuK8TfRJYLQ7buc4lVEGP9uq7Fg18jAUBunwmsIFnra?=
 =?us-ascii?Q?P8UAjz6GKjsWmr63ttmFFLMfsvCtxLrLUA8mqXMO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a262663b-518c-4961-f119-08daa007a73d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 21:39:55.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBlKFxZF0HKSxqtOUfZyUZq7IG7k7MER/PV6kovhCakop3tSZqg6THXzY4iGtEOFpYPn3epHJyH+oI9JaIQDNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5581
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:17:48AM -0700, Jonathan Cameron wrote:
> On Thu, 15 Sep 2022 11:53:29 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Thu, Aug 25, 2022 at 12:31:19PM +0100, Jonathan Cameron wrote:
> > > On Fri, 12 Aug 2022 22:32:41 -0700
> > > ira.weiny@intel.com wrote:
> > >   
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > Facilitate testing basic Get/Clear Event functionality by creating
> > > > multiple logs and generic events with made up UUID's.
> > > > 
> > > > Data is completely made up with data patterns which should be easy to
> > > > spot in trace output.  
> > > Hi Ira,
> > > 
> > > I'm tempted to hack the QEMU emulation for this in with appropriately
> > > complex interface to inject all the record types...  
> > 
> > Every time I look at the QEMU code it makes my head spin.  :-(
> 
> You get used to it ;)`

I'm trying...  :-/

Question though:

Is there a call in qemu which is equivalent to cpu_to_leXX()?  The
exec/cpu-all.h is having compilation issues for me because the
TARGET_BIG_ENDIAN is not defined (it is defined in a meson generated header).

So I'm afraid that the tswapXX() calls are not what I'm supposed to use.  Is
this true?  Are those some sort of internal call?

Ira
