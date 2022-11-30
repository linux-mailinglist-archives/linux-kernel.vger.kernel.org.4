Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6B63CE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiK3FKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiK3FKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:10:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEBC5F841;
        Tue, 29 Nov 2022 21:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669785007; x=1701321007;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l261xuR375LCoCkXoCico+/DVNhEZ3aBHJqC0ku+8dU=;
  b=PYOVvUycvd32Qo/EDNGWP1uy2o12GE2S9S3SbbPAxt4mH3C68Z6yqDTf
   DJj7DXZQw42Q7zAAyaC7t/YBS850cVWo0UZO3SEqSJAVy1+Ao5EDAuEC4
   UnHHNxnm6hBE3AvkxjHooUML/6N6k7RLjT3Ee5dfyJPZQnXHagEzO213n
   hCKzCwHQZe5ArUwGYmR13wiPOf1V6eVx0s+ELqwFx9StPzra5qCyI/igr
   XCenkuoqlPp/dUcV0/AlXukOBYkvDBr24c2QJCsYYx0e939p3ULJT2rVn
   7YDCuDhCh103TeSZD22UKv91LcWXiufeR7zyUgusNF/CZIzI7UIs+JzkB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295667898"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="295667898"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 21:10:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="786327039"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="786327039"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2022 21:10:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 21:10:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 21:10:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 21:10:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 21:10:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3GSO29SAaBDGehVu7ntQVfhaBnhnZGSFB/UEQ2Hsmg0KRFygij+caxpuccETgXyg7skn22TaZqCmi7jTBjOuQcPzhOQB9AIvoUS2I9ug3mtOGlODYTwT612tF5kI76NSY99qw2Hsa8RWSYURVZsuFg4XiQK0aWO0G1KOuI9trcBsiTNZlluDmjSlf1zVdZc9dQHdKOm9SvNMhCKeN6dEOUGPmQnos2JI0zV0ANpHIbXywuKnHy3Bf8s0IRfVOR/YhlBH2p8Z3TL+HwLeHitoW+UkxgeKYrJ07jHq91i0Nn+yg8lepgUzu+HbHcd10BghRCSvYEOtSZrFe73lSev2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtrYFGj3sApqRvxSAXHinod8ZDoqVTHeHw3yUmvyopc=;
 b=mJenDRsO+chlz+zCEaeDLjAMubaQySshI5ibLcT3a2Int+Dfu397oxE80RHuLM+NNu1qpF7x53HgMP6pTGdj5xjN3nto3y3LlsKvGSvdoonDaMFVw3LK8smqRljDTjW6/3u0IitmacuEcxWAk+bsXm4Ey4wAYpIpoHai54pl9ovoP8BCB0Wrv901OCdLBifQaAly446Yrqa4Opln0I40nkdZPVUKUkZM1DnJdrfhq6xvssiw0kc5lQm09/DVAKGG81AJvkTleTjvR4hrPK54NCW9rqSnMLlEiaa5kVQkTkjyBSXLI28cMNTWHNo0DPfcCt5s4N5WQOfYk+C6M+Bheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 05:10:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 05:10:04 +0000
Date:   Tue, 29 Nov 2022 21:09:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y4blpk/esXJMe79Y@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-3-ira.weiny@intel.com>
 <20221116151936.0000662f@Huawei.com>
 <Y3WEmMlLfPoYG1R5@iweiny-desk3>
 <20221117104337.00001a3f@Huawei.com>
 <Y3gUmSuR3OxUwkDm@iweiny-desk3>
 <20221121104714.00003bab@Huawei.com>
 <Y4VEhNNTbXj5EwOm@iweiny-desk3>
 <20221129122620.00002cf0@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221129122620.00002cf0@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6669f6-0358-471a-84f9-08dad2912380
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhr1E53vFDdar+5bBJpHbcefdRCPqFAbbg9Q+n/JK1kjl1hPgAPYxGrIp3qeyCpiva4P1YA7TtQlVQfCZrz0nG07l8BOHfCDa5tBnslr6NTqBBzVmNtfOCkqi19GW8gC3vZDrGdjUGFVoU2BzYgxsd82OPVOWab7QVzKAkwExibfetDI8Jx28iWnqi5PTlzvmHhf88sAH1dP0wQD00vSwUlwQyq1BGV4xB9ioCzwyGBetJIw6cqdgSaV94iO/id44JUXgURxrflyLnhW9q96wV5g3xI6Gi+yZAyyfoDiqbuVuGK7vAG+cG75P+HwlZvestiDtzZ5tLll02LRYc/zCSMaZdFOcrKBXLLbnjistnQAqgBYBd7C5G1Y3U9nOib5yajOcCNt1f+l73HgtNeXoPSLVaDV9EElLHVvYkI2xZtwZ3aujLf0XiZIMp+fpGtyNaV2JauzRzv524uRAnOQTTBDchR7xMweyG4JN2dOFg/YDHDa2lENuByMh12y580o7H4kX4YZFR9Z9vZFrCdX/iQurubL8kqe+kSwrLjdB63t/20rUEnFnYLZNEmFOxasN3C05WqdKGUndjbvVyZR79WYWLKuUjCiWFALdzAshMszndIZlPQ8O96S0UROohBxYhOJ3yZu577Zw4EyqhsQUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(2906002)(44832011)(6506007)(41300700001)(66476007)(6916009)(66556008)(4326008)(54906003)(186003)(316002)(8676002)(8936002)(33716001)(9686003)(5660300002)(86362001)(478600001)(26005)(6512007)(6486002)(6666004)(66946007)(38100700002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KjGJg1wMQOYD5/VDik72/vLaOzwOxKYRyFBNIpW6y0kLiokBrxpl66dGmIhM?=
 =?us-ascii?Q?6acCroTQKoXGleS2k7cQy66WGiO+cRYKG+itCGA3/GoVkT4kpcbWnWiXdm3F?=
 =?us-ascii?Q?i4Km31zHlAWTrCoTxaFx1NNQ7bkIQsGxLIr7tUhgJMJg+V/Aoej33CdTDi3W?=
 =?us-ascii?Q?weeKTL2mfGXiGd/sWHBNHbZUCtm0sd/87pju1XwbhvbMtRuu2ld7jKtOKGJG?=
 =?us-ascii?Q?O8ZBBzsoAoEsDkJyEJKneOeb8c79x/AuHOa+axjVKrwDh2cU3+HAxmaqMe1p?=
 =?us-ascii?Q?UcdC0nZdvzTuWXD96PtiV+XBHTEbZlX4QHIWbdcMXE7vwOxNpnGC3qVz9X7S?=
 =?us-ascii?Q?y1xWVhXvF1dq43bV62yI/LzxA3F8IBVU9Gf90V4uGp6OWV7fsbxnqS5Mgr1m?=
 =?us-ascii?Q?0mpJHN+KF64+FKX8RemEs8DSv1AXytytY5hh+KhlZW3z244PKL1HQiJxQvNf?=
 =?us-ascii?Q?cOcMgj3L54PdGW20oDfzUuiqR++5y6DaBhbO8dd60j6TbuymGUOQuGHhu+Nn?=
 =?us-ascii?Q?of2pDA58GUSJD1bzZd28aVodJUZ7fTABy/pAQIZXUmc6dMY2pIhdWBLBJ2eO?=
 =?us-ascii?Q?gKy7l4gj1m/OiDmBc9FoSkWQP9ALcoMnx+7e+gOAfsdtLSyr/Le7sPLVU8jj?=
 =?us-ascii?Q?Q7ZVr1GR9aRPfm3IUdj6HBJR0ks2XAsoDrXRURzKjGLAUREI2EtVJr2z3Djp?=
 =?us-ascii?Q?8B7nvV8zhs5e4fM0KMYhcB4eKGhRt73DMtDMVyDb1W7tO5n3KBRWTjIYp0k9?=
 =?us-ascii?Q?C/Jmp+eSG8H7AV3gaBNi7hpD6Ly5CdGlLqd0nvSnBhwi6HaO6XJEorARvEXl?=
 =?us-ascii?Q?ytGyu2Pe82IXQKccBLIap+RQogwbSdiCPmeOkzVKt8zPF8pVnSj19rcMT/bG?=
 =?us-ascii?Q?5/rjjEJD1gkzNq0JD7qYaUnWVu9Y8dlHIAQHLzshqq/gNCl8sQJw6x8Bjigw?=
 =?us-ascii?Q?Qt+ZIY6EVNFc+d6MWZGJBwXCbU2H6I3Vu2diPGQhtXD6qxdP0VfRRYA6nBKf?=
 =?us-ascii?Q?E/fxyEGcQ8xJJJyYIl6o3hrrhBxScZZCYX2aN2fEvWUANiT0aNrsI+9Txrco?=
 =?us-ascii?Q?VUxHQ/eeW2gZ1cW/w1d3hpqGtEo1uHB9u0NxLTvsDrYpTZZLnbVWtvfQrc/B?=
 =?us-ascii?Q?d99gXv9t1Bmah5M8G4HAp5CCet3pee20H3FwHIhodAwnIezx5S2zrP7GkrlR?=
 =?us-ascii?Q?P0TIX9AUh8Cd5apX9/gyloUQdSmpOTACCw5bgIBXYhJqC8t4vZNLS843yLi1?=
 =?us-ascii?Q?GCKAbeRmJ5ElixcmCDFbURrxLaV6q5+M13tbyYq51faPSq49cd5Flt0T/VpK?=
 =?us-ascii?Q?Fy2biTehtuPNrrZ+DAi1xpHy5SQHO+YcAnWD+gfMNYthgStap9d8GM60rQrF?=
 =?us-ascii?Q?YRjLkzMcjQ2qJYrm+9ainWBPFJUW306r+Jh5O9Ljq8MCDtLhE7QieAeWkXNY?=
 =?us-ascii?Q?/NGqw7Q7/9SWzvT4ydJVZ+xoBFeQmMYEOTtkXCCJsBb4RKwTElhxMoCSP5PC?=
 =?us-ascii?Q?T45i1O7nRSMc6gWkn/zyat0e785SQJseqj6rrTpgk+J3zDc6QrzCNrH6cG3y?=
 =?us-ascii?Q?RWTnKvHJj3OxNy/7IjrW0dSVeuHzyhKKuA7XOXIt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6669f6-0358-471a-84f9-08dad2912380
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 05:10:03.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84cHfbQYYw3gjjyr7EvT1Ychzs88AEBT4xRwjJcsyedUhE8lW4epucRBqQvxXnE+J+IC+whhuI+74EWZMph3Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:26:20PM +0000, Jonathan Cameron wrote:
> On Mon, 28 Nov 2022 15:30:12 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > > A valid reading of that temporal order comment is actually the other way around
> > > that the device must not reset it's idea of temporal order until all records
> > > have been read (reading 3 twice is not in temporal order - imagine we had
> > > read 5 each time and it becomes more obvious as the read order becomes
> > > 0,1,2,3,4,3,4,5,6,7 etc which is clearly not in temporal order by any normal
> > > reading of the term.  
> > 
> > Well I guess.  My reading was that it must return the first element temporally
> > within the list at the time of the Get operation.
> > 
> > So in this example since 3 is still in the list it must return it first.  Each
> > read is considered atomic from the others.  Yes as long as 0 is in the queue it
> > will be returned.
> > 
> > But I can see it your way too...
> 
> That pesky text under More Event Records flag doesn't mention clearing when it
> says "The host should continue to retrieve 
> records using this command, until this indicator is no longer set by the 
> device."
> 
> I wish it did :(
> 

As I have reviewed these in my head again I have come to the conclusion that
the More Event Records flags is useless.  Let me explain:

The Clear all Records flag is useless because if an event which occurs between the
Get and Clear all operation will be dropped without the host having seen it.

However, while clearing records based on the handles read, additional events
could come in.  Because of the way the interrupts are specified the host can't
be sure that those new events will cause a zero to non-zero transition.  This
is because there is no way to guarantee all the events were cleared at the
moment the events came in.

I believe this is what you mentioned in another email about needing an 'extra
read' at the end to ensure there was nothing more to be read.  But based on
that logic the only thing that matters is the Get Event.Record
Count.  If it is not 0 keep on reading because while the host is clearing the
records another event could come in.

In other words, the only way to be sure that all records are seen is to do a
Get and see the number of records equal to 0.  Thus any further events will
trigger an interrupt and we can safely exit the loop.

Ira

Basically the loop looks like:

	int nr_rec;

	do {
		... <Get Events> ...

		nr_rec = le16_to_cpu(payload->record_count);

		... <for each record trace> ...
		... <for each record clear> ...

	} while (nr_rec);

