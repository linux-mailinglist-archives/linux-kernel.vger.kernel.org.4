Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0F5BA103
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIOSxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOSxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:53:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C2870A9;
        Thu, 15 Sep 2022 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663268019; x=1694804019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=marwgCJNg2D9Qn+9xZyNtnV5BvBFGTyvsfYa5KrOPuk=;
  b=TONTN+J9NDCYQnmbO10KsAWKprMVX/KHi7UQd+lWjS7ectb4+ixI6m7X
   pHWwAmnvMxXGpVjKrYEsE37uBzxjMy0Bml9BWiB6SQrZLVcLObae5mif+
   MzFS5/YbM1r4z2VkGlLlHSVCL95MnXrRmSVJ4dQcHiuXxbgVzJyv5/obm
   mMImnk7nmleYf2Z5LiLbK0emvJdEIMhhZjQVS/EQgRFE0snNrHGt+Sz2S
   UvKCRNbDj278ucuHQPFI8eUPrqsim3+Tjx8Bj76Gv6gx2LgNfmGXH/XWy
   A6cSnWx3Dc2ju25Jc2SXA2Gvye4oAGeyPIZPxKKgaTdSk8Z8nIiHuZJCk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325072505"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="325072505"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 11:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="612998756"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 15 Sep 2022 11:53:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 11:53:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 11:53:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 15 Sep 2022 11:53:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 15 Sep 2022 11:53:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+oFJq8A70qOhIbflqRbLe2zG5SEpj0eb0LYI7GksS/DsYtcHxMKwv6zAW1Ze2xUPwP+kEe6uRc0rByhz0Of3QL7RZ5bSNINlnFSrCC3qUzGqJyvYihsnQLmASovBA8BZYFNei7AWJCMnsV8cjI4spvXDARxjWKWoU3Bt2aKhKJYcOG9eRtImDKsqBF++CLvA+clI64TOfwDzS37GOjidDG6mqtqikMLPIeFLbAYhMXBIdrWcB4SY+CV+/k3ebUJ3ftId0UN0CDtHrvf95unrV0YZ5i45FUotlnD1ImWQHwwUnxW5SRx/URNOXZgPxLOupXR/BbaSSpzEOZZbgN0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb0xM9XukhBd0D1RvU08YVsew4zs3Z6mb4aekW16J+o=;
 b=lOKzPofK9kkUzEPGAf01P41VTKj/Wl1ab3aHrhgeHVxqLiEEYBi1NZXcu+Y34z1Iz5kuOAbnbGlwSoc+nSYKXj/BFUhvIvj8q8z1c1Yeywj8MpA+EBmJN47MnRCht7Nk49WQrBOUh0tXxvnWRSFq5UsBIAtzts7SLa3pSOQLbfgqyYb57ESOYiGYm6VaSolWDxtNWAzfM9WIG07pi9iDFronPGCIhrf1aJIMfybxexfJaPBEELO8RHRioe818ze27MI/KH03bwmn7ehB/0ZpF9P1AsT/VkJrz81HQox2MLqubtODyBw8Y++agV8SOd1ehxl3Wbcod0RCfHWNsJdcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5451.namprd11.prod.outlook.com (2603:10b6:408:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Thu, 15 Sep
 2022 18:53:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::1967:b7cd:c851:cb91]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::1967:b7cd:c851:cb91%3]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 18:53:34 +0000
Date:   Thu, 15 Sep 2022 11:53:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 7/9] cxl/test: Add generic mock events
Message-ID: <YyN0qY5yaXwTwLDF@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-8-ira.weiny@intel.com>
 <20220825123119.00000705@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220825123119.00000705@huawei.com>
X-ClientProxiedBy: BY5PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:180::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd82dea-aaa3-4b9c-f290-08da974b9724
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1gzBkZVzHW2U8/vbj8P7wVs3wrEbG3aO6jUfy9wynVv4HkmITyydTuoPp6g+R74ygWKFSJs6rT0mu9Lcfbi/oGvptyGD8XPlFkB2xWFQn17JFlKI5dMOnCuZ5sp9swhlgawrwUSi0NstGq5vtl4LQwMaQgxMoah43d9R7k1WqcqYhJnbBCFEl2/AHGfap4L3oMMHIBgXHNBdW8EKgxhffvPUREgdk5+hBCzI/8cnXJRQYValCOtsmLVbECIjsaFJOwtr2pyotXrkCChmyC6RO7tHhH2lLsDpba4mmvOBykIdEoy+HmCrEtnK00ex8y+pAxSFivAWbfd8RpiKN1Hc3y2/k8CFgVwGSzR7CvAinnYoqMuGiZnr7EtN1bQBsKioH8hpmu2/G7+l56+dk5YRyysOAcB0Hbax+Pxd8f3AUFniXP7zx4DirM3QI61avSxNRjJ/vp3I9+4dkMpPDraVUtO43tncEG54fdAIMHrp49mMkZtvm4MM9PPCF7COTFgNfGHquYqQ1aSZBhO2tj7jxHHrZLvBPfe2LqLZh/eTQlcol752bEDt1OnmC2XAn/+a85KdZlWY8XIeJQ7fB3oGvDPdLz+a5SwFbpeTac9ALeapqK34HT3fG1VAeUr7xqff07IecO5RBtuDEUD4aHeODgDZDKWbdg0e8N3DqNLpdnNzR7toX06OD1DDfAgLQAwIB4vl1cGBhYqiNqBj8nk7xvsG+K9Og2rdWsx02tSd9dnhAULjmYDaz1ngAWLI558
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(26005)(6512007)(66946007)(5660300002)(38100700002)(83380400001)(8936002)(478600001)(6506007)(8676002)(33716001)(86362001)(6486002)(9686003)(66899012)(316002)(4326008)(2906002)(44832011)(66476007)(66556008)(6916009)(54906003)(6666004)(82960400001)(186003)(41300700001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IOKXzzSbgrLiy4TGD/VsnaE/594KXLFKsn9FHxy6XEPuG939+WZUVS0REifT?=
 =?us-ascii?Q?tN7Z8ZN9fjV3m2TcjrDf/2J7g9bNzxtNJllVFL3tVNW//ryqx4G5mcdtPnSM?=
 =?us-ascii?Q?NB3D/yILPOiIDaH68808DcADNoAj4gnw7BkjXeDyqGhqEBw0asSfG6GaAMYb?=
 =?us-ascii?Q?HIADkMe85juo1Akr7WLb04aCu92GNvsVvHF2zrXb9CfNoUVRhItnj/LwWcBf?=
 =?us-ascii?Q?bbNmMSnoxExK7+2mUg2cUKQGKSFQDC/YtDp8FTBhFHX0Yu6zckAzwMuaySHt?=
 =?us-ascii?Q?EVq6M4H6t3bq58eofedko0xFaQkdFPod5N4RnvrbAsZpbXLrInOv+UE/5Y7R?=
 =?us-ascii?Q?/NWxylAPlM0wo6AltixKmFUsEzBit1YQH8RPaZEWz7FDqAQjk9g9deh0B03e?=
 =?us-ascii?Q?MWU0vsASuOlkSQpRKzlbIzLwGCSDgW10APwhqi4ZpsTI3YTKAHmVnQmkIYa0?=
 =?us-ascii?Q?LhjA6cZm4Ep8U/I19Kz4w6FrXepRkv7MG+AJ0eIgpZwl+Adx8Phrrhpq1pA1?=
 =?us-ascii?Q?G021hM9l8PWXxKt4oOicc+nhbrtMq5GF3WpegNaj77VuSeGVuVArm7b9I59N?=
 =?us-ascii?Q?DJq3/g4YZWkf9eE1NzgPy6tqwwKhxPUnPxa5Uvl+5sZg4DPkeLuG6TSxzTlf?=
 =?us-ascii?Q?7ee+TYlIxnjHGux2XsebsErUurBK1ff4b+PieNv1hprGxv8Dsd+BFwVkLVYI?=
 =?us-ascii?Q?6+aLgq+bSuGqxx4vfsO79Ag/fv4NVlW0uFDIysSvWDqPVmEJEjv5AnD4Y4my?=
 =?us-ascii?Q?GnzTo1Zgc+69QfnX4ITrSqqb+9Blu2FNomJZnAn3qp+tKpGA82tzEvAV8kKO?=
 =?us-ascii?Q?KmkNmhgiajrHx5AxGw+6fQUTJQKVY0vAIVeLS/FS6CWV8eb9Ew51JcVsnv8g?=
 =?us-ascii?Q?zGuJKILOPW0tC9pjjAtl7o7kUUbAXZRT2ILkObx9WHrdLN15WORHI0tfXGkv?=
 =?us-ascii?Q?AHowZ+NT2qNEUHpZ1/3xpC8uaDeuX7Jll2y/iQH8kAK6tjYnFLkeyHmxKBTG?=
 =?us-ascii?Q?T3oCmExhEbsMSmg/sFpYB94yqr1R4o/fNUuy97CqcdpGGG4xppDnioYwaCmq?=
 =?us-ascii?Q?VnY6m8tGKXHTfJ9ry+10e/JDjhtLrpIpydAGyWk9+bldZSc68Y9QDXNmQV9m?=
 =?us-ascii?Q?R9Q3WOaFoitagc34qAjFCSF28DUJC4HHAPhH2DemmzKLgvaadS8X7ljnNC21?=
 =?us-ascii?Q?BXp9Ja9dSh/lyhl3ucNEoflOMA/PQL7FzuUqIgFf2eus1/0qsFHzL0cuJlVP?=
 =?us-ascii?Q?PD/pBAgUPVWXENRt+LhUnBiIsCePthmDuk9hG8bdVmE66YtJ96MJ6LV+V0wI?=
 =?us-ascii?Q?/3lxpn0qz0QgQ+/fsmF/NbI6hFqs/PCMHzrPjG7w21AalRxNYm9RY8ai+rn3?=
 =?us-ascii?Q?18I7V41ad3zrvsJ48lVlXcXjMIzneSxjR22OIm4xzAUHnU5sxOlplijyvjcl?=
 =?us-ascii?Q?4ySqNlycTAoyTomoSJfd3v2dCfYu36RVVk/1syTn1dHb05Apw+FzAYfPw3fl?=
 =?us-ascii?Q?UFfZW6bPNhVgm693KjkyFN1y/IVQIGN9vCYcEGvZOPQ/eM2JYXslLL31/1h2?=
 =?us-ascii?Q?psJt8GBLLmuBC7Apoax/hjygKQEFeBiDOK9B20Ns?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd82dea-aaa3-4b9c-f290-08da974b9724
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:53:34.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4N5x0m7M3iJbo/qIqR9F8O/wWwqAruNGdomnNckkYoQb2A/wV3EtjKl8PmkcsxZwfiBS75hjDQci9DXNEiF+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5451
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:31:19PM +0100, Jonathan Cameron wrote:
> On Fri, 12 Aug 2022 22:32:41 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Facilitate testing basic Get/Clear Event functionality by creating
> > multiple logs and generic events with made up UUID's.
> > 
> > Data is completely made up with data patterns which should be easy to
> > spot in trace output.
> Hi Ira,
> 
> I'm tempted to hack the QEMU emulation for this in with appropriately
> complex interface to inject all the record types...

Every time I look at the QEMU code it makes my head spin.  :-(

I really thought about adding some support there.  And I think for irq's it may
work better?  But after your talk today I did a quick search to see what it
would take to do irqs in QEMU and got even more confused.  :-(

> Lots to do there though, so not sure where this fits in my priority list!

I bet it is higher on mine!  ;-)

> 
> > 
> > Test traces are easy to obtain with a small script such as this:
> > 
> > 	#!/bin/bash -x
> > 
> > 	devices=`find /sys/devices/platform -name cxl_mem*`
> > 
> > 	# Generate fake events if reset is passed in
> 
> reset is rather unintuitive naming.
> 
> fill_event_queue maybe or something more in that direction?

Fair enough...  Naming is hard and I'm one of the worst.

I've changed to

<sysfs>/.../event_fill_queue
<sysfs>/.../event_trigger

Thoughts?

[snip]

> >  
> > +/*
> > + * Mock Events
> > + */
> > +struct mock_event_log {
> > +	int cur_event;
> > +	int nr_events;
> > +	struct xarray events;
> 
> I'm not convinced an xarray is appropriate here (I'd have used
> a fixed size array) but meh, I don't care that much and mocking
> code doesn't have to be quick or elegant :)

I rather thought the xarray was more elegant than the fixed array.

> 
> > +};
> > +
> > +struct mock_event_store {
> > +	struct cxl_dev_state *cxlds;
> > +	struct mock_event_log *mock_logs[CXL_EVENT_TYPE_MAX];
> 
> Each entry isn't terribly big and there aren't that many of them.
> Make the code simpler by just embedding the instances here?

That is a good idea.  Not sure any more why I did it this way.

[snip]

> > +
> > +static void event_store_add_event(struct mock_event_store *es,
> > +				  enum cxl_event_log_type log_type,
> > +				  struct cxl_event_record_raw *event)
> > +{
> > +	struct mock_event_log *log;
> > +	struct device *dev = es->cxlds->dev;
> > +	int rc;
> > +
> > +	if (log_type >= CXL_EVENT_TYPE_MAX)
> > +		return;
> > +
> > +	log = es->mock_logs[log_type];
> > +	if (!log) {
> > +		log = devm_kzalloc(dev, sizeof(*log), GFP_KERNEL);
> 
> As above, I'd just embed the logs directly in the containing structure
> rather than allocating on demand. init them all up front.

yep.  Done.

> 
> > +		if (!log) {
> > +			dev_err(dev, "Failed to create %s log\n",
> > +				cxl_event_log_type_str(log_type));
> > +			return;
> > +		}
> > +		xa_init(&log->events);
> > +		devm_add_action(dev, xa_events_destroy, log);
> > +		es->mock_logs[log_type] = log;
> > +	}
> > +
> > +	rc = xa_insert(&log->events, log->nr_events, event, GFP_KERNEL);
> Not sure using an xa for a list really makes that much sense, but
> doesn't matter hugely. 

It is much easier than trying to manage pointers and allows the events to be
inserted more than once.

> > +	if (rc) {
> > +		dev_err(dev, "Failed to store event %s log\n",
> > +			cxl_event_log_type_str(log_type));
> > +		return;
> > +	}
> > +	log->nr_events++;
> 
> Having an index into a static set of events is more complex.
> I'd either switch to a simple array of pointers, or actually add and
> remove events (or pointers to them anyway).

xarray was much easier to deal with than an array of pointers.  Using a list
was hard because I wanted to reuse the static definitions of events rather than
have a bunch of them defined.

[snip]

> > +
> > +/*
> > + * Get and clear event only handle 1 record at a time as this is what is
> > + * currently implemented in the main code.
> 
> Duplicating this comment seems unnecessary.

I wanted to make it clear this test code could only test what was currently
implemented...

>  
> > + */
> > +static int mock_clear_event(struct cxl_dev_state *cxlds,
> > +			    struct cxl_mbox_cmd *cmd)
> > +{
> > +	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> > +	struct mock_event_log *log;
> > +	u8 log_type = pl->event_log;
> > +
> > +	/* Don't handle more than 1 record at a time */
> > +	if (pl->nr_recs != 1)
> > +		return -EINVAL;

... and this check ...

> > +
> > +	if (log_type >= CXL_EVENT_TYPE_MAX)
> > +		return -EINVAL;
> > +
> > +	log = find_event_log(cxlds, log_type);
> > +	if (!log)
> > +		return 0; /* No mock data in this log */
> > +
> > +	/*
> > +	 * The current code clears events as they are read
> > +	 * Test that behavior; not clearning from the middle of the log
> > +	 */

... and this one; prevents it from blowing up.

[snip]

> > +
> > +static void devm_cxl_mock_event_logs(struct cxl_memdev *cxlmd)
> > +{
> > +	struct device *dev = &cxlmd->dev;
> > +	struct mock_event_store *es;
> > +
> > +	/*
> > +	 * The memory device gets the sysfs attributes such that the cxlmd
> > +	 * pointer can be used to get to a cxlds pointer.
> > +	 */
> > +	if (device_add_groups(dev, cxl_mock_event_groups))
> 
> Whilst it might not matter in a mocking driver, it's normal to jump through
> hoops to avoid doing this because it races with userspace notifications in
> all sorts of hideous ways.  It makes the sysfs maintainers very grumpy ;)

<sigh> I know this is a hack...  I really wanted to hang this off of cxlds but
it did not make sense.

> To do it here, you would need to pass the group to devm_cxl_add_memdev()
> and have that slip it in before the cdev_device_add() call I think.
> That wouldn't be particular invasive though. 

I guess that would work and yea I guess it is not too invasive.

I'll throw it together for the next version and see how it looks/works.

> 
> 
> > +		return;
> > +	if (devm_add_action_or_reset(dev, remove_mock_event_groups, dev))
> > +		return;
> > +
> > +	/*
> > +	 * All the mock event data hangs off the device itself.
> 
> Nitpick of the day: Single line comment syntax ;)

:-D

Done.

Thanks again for the review!
Ira
