Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B69643DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiLFHfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiLFHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:35:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01517E0C;
        Mon,  5 Dec 2022 23:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670312131; x=1701848131;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+FEGfCQAe1/rhU+XXgahVll/HgaLNzd7pYhtOctbE3c=;
  b=NPyd2pTBxPk5e4iWTp3UGLvVo0FbIXBi5K3Y8FGNfalSqWmhudDVPBFo
   2ApDDGoO41bq5cMP8+qRvCS//yCc64v0SYTsvdvLP27RUcTfxDol6OLWx
   4TJEh2tmod/0RyNCFPNxk+ovCTzHVAC7QVvuyQDf47kXMNGguoRGJRCgb
   ih7qjv17nVfipCCdcJQq1DUTLQCFqQkfUHZ1vMuR2hnUbfwz2sI5uhWC0
   8d40DxGQPq3Mo/dRqlMdza8GetEiEjr0ogCThwAZ2sxRU6kGqsqCnmXTv
   9OdLY+M350QONIlw1sYZ9rqbiByQsYcFY2yZ5PhdVDRjt2kAYF8rME2tb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="314202389"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="314202389"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 23:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="596483155"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="596483155"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2022 23:35:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 23:35:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 23:35:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 23:35:29 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 23:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzUIQQxFEuGHGYYanqRxE9Cp2Gw/YMcvElG8OBXQC1h4Ns3ZtvJrYhL+alVn4kg8GZrDghjbNethXuZ2wQs+qWJAMXzcxcxlzh1VcDLw32ay+qi0CDmsN1Xt2C4Uh6MU70b7ySdMgqwIL9MotmAPBJffJTbN6vNNtGwKeIWJ6rvy7oNI2ufqOqgWUD9Ns7SRWAGPHiCcwh345oOc59lZTZM24yEoXJ+FbhqvUjzu78v3+4j/lUtkVpa1kH5rT8kHasXSh3se804ntzBJkSItPD+V2V5o27hLTvw4XLM5NLdTibQIBzAgmh3Omq071NMVIEYyYArcJyK40QHrWjDJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqolMq/NwLgR5PqgAtMIjDfRITS+rAJoYoZq+2sESeA=;
 b=GA92yK4WGETSYZtTXhoLH0MAC09jD0ChvQjQi8fecLjS1u2+wvk3+HbjLssLJSUd7MllJl5iMmySErPpiyBCPpLfd615xKUGL/QADkTo5kykWItg11JHK5k9YIbyw1gV0KpqTmUKyP9b4KCG6IaNUBVi4r4gmmlJ28Fx4AHCi3tQEgcpl4Yyk7VztwGiOxp+PZ7ZnPahRzx4P5HYH+AydwvHXQmCVed7h5w3gXpP+T1tRGa3Xbo6IiwQtUtkr2xmPQ6Hch9KEfVkvzFwHvunoBXxvgR4cs6gRWGFSrO0nayy+XI0irS+33c+1FCofWZj3ngyFAXCBiaiXULFepAPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7076.namprd11.prod.outlook.com (2603:10b6:510:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 07:35:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 07:35:28 +0000
Date:   Mon, 5 Dec 2022 23:35:22 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <Y47wuiu2RG1ygH/9@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-4-ira.weiny@intel.com>
 <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
 <Y4qPAi/DZAyz/Djl@iweiny-desk3>
 <638aa2f3349e_3cbe02943d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <638aa2f3349e_3cbe02943d@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb40311-19bc-4ae0-c0ee-08dad75c724a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYy8iBpMVof3O5Cuh+q/0F8zSXvQfxYHsXn/QVRORJ3Bd60Xl1I+jhpVTcFsRi6sB0KqHsktqx6QdTPu79crWHZ40NhK9Hubm5xoSTHPsZM/1/tKd7DSrbWsBUjnCxrpprjQGiZL8aZoZ9HYxHDwbcoT6G3XvzRmp+kA3CKNx38IQ2nLgdk6C1/U987UJ52j4ZjaA47gQzdyDQOSM8oZ6sbD9PRDFZT6N4Tf8ZHJ+ybmZEss+WiKkGLPrql8NIKkNUN9/49EMfzV68mXEKa5GCb+NOBt9le0GUdMJ1DN6LvScQZ5Ph7leWDt1HI8rpuPPXdSCaCW3R9v80TTB2SbcvSoNqDQpX5ru8QSQ3xhr2gx5zKyXsbL91ox5bJk0MtImuX2RIqJp76D13N0n9odzpzcR26YnOO8vqGPQ628PJcb4vFKPioFrhRCPDwQz7G47YSm3j4f/IyWTInvTxZo5lwrWc3M5JqjNHLICDYHqS80+nvdD5Se3Q4tSe17kJc5olT4kuIJVEkXBT+XOnmBhRwUkcQUOrDSvjCgjjEIIO7ReIc1jeYG6Y75uN9csQ8SdMbs/YVPwnlaIX/zvxb6HdNy0x1AGUJvDMtSoJ26IDTRaX6cU+HGq7Y/jpJNEbE5kbrAh16tVHvYcUe5/n3Xjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(5660300002)(82960400001)(86362001)(8936002)(44832011)(2906002)(4326008)(6862004)(41300700001)(83380400001)(6486002)(66476007)(54906003)(316002)(6636002)(66946007)(66556008)(38100700002)(33716001)(8676002)(6666004)(6512007)(186003)(6506007)(26005)(9686003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NfWxsomyyHSxARZsD52iePpp63X2tifClR5EA6fQSz0UVoqyRKA9Lf4rbItp?=
 =?us-ascii?Q?bOMC1Q1uThujJjpJdkQ3dl/oPEq82mC4WuG3ekaUlM9SQbFhONXSMeMWUrAy?=
 =?us-ascii?Q?74l+ldza8D7AE2PCKiZ4BFAk7hD+B/HEQ4dh1JIF11FQYgmNyvITRogXvRxF?=
 =?us-ascii?Q?NRkPxfBs0NkpbSXm0W00l0rCc/9mxIIMNlkYrI9+AERLa2/eJD/yGtyOnSYD?=
 =?us-ascii?Q?FnWX5DuG8feT2LQd0sW69H/GUhst+76XvcBRMdmsR+JujztIxYaQOx4WTZdp?=
 =?us-ascii?Q?1bBbD/DsK4r1EGcXdZv+Y1bA0bv3E9lD/sK6EkZVxoq0vCedb+Zc4NNyrUHy?=
 =?us-ascii?Q?rM5NBl1lCPMj3bgnippRm/eAnk6SpL3BJw1lWu1Y1E1Zaw3kkMage6ekuzR3?=
 =?us-ascii?Q?FMhsAD1HM6xdL6XFvtoec1BWnqUJNr1yT8xIRbKTiocaknJO2ZE0zjZb3oAs?=
 =?us-ascii?Q?O6OW/4EoQqCUKVM6o6oUTB+6eKacgw1QYNLc+axZvyjCOet4GFRwgPSAvgX7?=
 =?us-ascii?Q?cyJykrNKK0U8sWdVbbcX/Ldff8LcZG6mrjubuVYWcpTq2VWEhC9AfMw8jc3y?=
 =?us-ascii?Q?2bmYFjTL2ffmL5qAk+4XpDKLs7HRvCx5/tLtMqHcJOx5l9tJ0gjsREfKNX7b?=
 =?us-ascii?Q?av1lBYcp9BT/VTc0lJC1WKF71WrM4Wis1Sj5BDGZuNMzVrz4BrEQ8CG7+aO1?=
 =?us-ascii?Q?WtsspXlPTmWL6GjX6HmJYq0MPiAJXiOBlloUDkMU24X0mmrIHoCJuOp3jBMG?=
 =?us-ascii?Q?BBwRp4un6z+xJzgGqtNEXX+0nr7G8TOEetIyBtSyLnbsrjVKUi3iUB4tBid5?=
 =?us-ascii?Q?atSQPR0IlByRzVJi455EUbQz2d9R1vysmghzypwKV+2qvcc1fiWdbr4E2qrB?=
 =?us-ascii?Q?BssvKjOCcLmYLqoMfCgWzN8rznAiMlcMPJY6CsCfq6mmmL9dyc3sspImrz0j?=
 =?us-ascii?Q?PhH7HIRuLRR/8kZ9opzIIQGd+1JygowH7OGqj58N+5s0GigB6P6CFgtYJeL+?=
 =?us-ascii?Q?r1JyPHShcaiNAbkGGmmocnt0n8cSQqTTLlfouwJjYjp4dVR+TN0omBIXcIEu?=
 =?us-ascii?Q?NWJPttbWj0mzLTqZ1qktnOHiGrYopMoREQd/4GvLGjjNmvi8mVxwr/g5mTOq?=
 =?us-ascii?Q?BpNADwLxMBgOIrSEwClrUX1jkoPrdZElaWSay0prlnsVU6EGOOfEKYT/oAU2?=
 =?us-ascii?Q?md68ma12FJnpRHIOVS2I78fytP/wENPJJuVWrGDsPuZbHdZKm/Y2JO7eU86s?=
 =?us-ascii?Q?csiTrGCWuOVD6/vc5D4NloQQHup1iEzHSAVEiVQ82dlHNAiDA+AFvg8s082P?=
 =?us-ascii?Q?HIIUCWW2FJLnw2pYOq8lplk8KnDA8nwaldYGvOD51MTxRI7X6VNlzm9GARh+?=
 =?us-ascii?Q?R92gq0REnzvCKKj5cTNTkpK6I16EI3KEBbv4WosMreNkMlF4eyn+Ufnu/lKN?=
 =?us-ascii?Q?MA0dVYvvQRlyJ+HBV5tTKbdg8chBMElOBFAzJcVSOIBph7+hBSoZipe9e7vN?=
 =?us-ascii?Q?736UtSY8YwIbgYow2Bm1JerhJTz7H0/7kclA29gB0fD2sWsnsSaqOksIbcaz?=
 =?us-ascii?Q?fjxdrmmgrZb7qPjYiTwWq22K5u4GRWQ5paeJ5km7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb40311-19bc-4ae0-c0ee-08dad75c724a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 07:35:28.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMcf9iij3XiM9He6hmz0Zmtq/T0lt0jQPIqyd49PzmYWF059zZAsJMXNqTD0xStQfdCISnqB6+BXeZEtXtX2mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7076
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:14:27PM -0800, Dan Williams wrote:
> Ira Weiny wrote:
> > On Thu, Dec 01, 2022 at 06:29:20PM -0800, Dan Williams wrote:
> > > ira.weiny@ wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > CXL rev 3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> > > > command.  After an event record is read it needs to be cleared from the
> > > > event log.
> > > > 
> > > > Implement cxl_clear_event_record() to clear all record retrieved from
> > > > the device.
> > > > 
> > > > Each record is cleared explicitly.  A clear all bit is specified but
> > > > events could arrive between a get and any final clear all operation.
> > > > This means events would be missed.
> > > > Therefore each event is cleared specifically.
> > > 
> > > Note that the spec has a better reason for why Clear All has limited
> > > usage:
> > > 
> > > "Clear All Events is only allowed when the Event Log has overflowed;
> > > otherwise, the device shall return Invalid Input."
> > > 
> > > Will need to wait and see if we need that to keep pace with a device
> > > with a high event frequency.
> > 
> > Perhaps.  But yea I would wait and see.
> > 
> > [snip]
> > 
> > > > +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> > > > +				  enum cxl_event_log_type log,
> > > > +				  struct cxl_get_event_payload *get_pl,
> > > > +				  u16 total)
> > > > +{
> > > > +	struct cxl_mbox_clear_event_payload payload = {
> > > > +		.event_log = log,
> > > > +	};
> > > > +	int cnt;
> > > > +
> > > > +	/*
> > > > +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> > > > +	 * Record can return up to 0xffff records.
> > > > +	 */
> > > > +	for (cnt = 0; cnt < total; /* cnt incremented internally */) {
> > > > +		u8 nr_recs = min_t(u8, (total - cnt),
> > > > +				   CXL_CLEAR_EVENT_MAX_HANDLES);
> > > 
> > > This seems overly complicated. @total is a duplicate of
> > > @get_pl->record_count, and the 2 loops feel like it could be cut
> > > down to one.
> > 
> > Sure, total is redundant to pass to the function.
> > 
> > However, 2 loops is IMO not at all overly complicated.  Note that the 2 loops
> > do not do the same thing.  The inner loop is filling in the payload for the
> > Clear command.  There is really no way around doing this.
> > 
> > Now that I've had time to think about it:
> > 
> > 	Are you suggesting we issue a single mailbox command for every handle?
> > 
> > That would be a single loop.  But a lot more mailbox commands.
> 
> I was thinking something like this pseudo code
> 
> int tosend = le16_to_cpu(get_pl->record_count);
> int added = 0;
> 
>     for (i = 0; i < tosend; i++) {
>     	add_to_clear(added++);
>     	if (added == MAX)
>     		send_mailbox();
> 	added = 0;
>     }
> 
>     if (added)
>     	send_mailbox();
> 
> ...where it batches and sends every 256 and one more send afterwards for
> any stragglers.

Ok I'm not convinced it makes that much difference but I don't have the
fortitude to try and look at the assembly to argue...  ;-)

Done.

Ira
