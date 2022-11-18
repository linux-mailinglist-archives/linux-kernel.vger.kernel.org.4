Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB86304F6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 00:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiKRXts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 18:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKRXsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 18:48:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4944EC086;
        Fri, 18 Nov 2022 15:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668813986; x=1700349986;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vp+CJOm5pf5iKRgP8dPRRn8jkFOO7Qp61rR6ZpATJ8s=;
  b=ixVTC7d8slajsfJn2TOoYyI0clzG8IgFpZhjoMVY7uy62iAla4tjAkwy
   L2fwMXeLsnUwZsCmUlslx2z6MrtbR/xSpj0ezIHFbJ9N7iUmDJUREeiKL
   SoOvRUYbhflZHOfmyflC3vBcQOwV9R4v/QDH8CGa/cSQ7cfmCrKC2LxpB
   AH87b5lKxBtffGvzXAYAoLA4BsenHGspMA8QIGC+UJHxzFc1K+lkQjLNl
   Y9NTHFyBhNspfA4vIQkm5hxECLvBh+eJzPwffrSB9pBDkvTzvksfo0Gfz
   dqJ/cL1i/1cyENBOEX2jwjd8XnrxssBXkTqlBcgAzW0TiSxra9VoMl910
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375406897"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="375406897"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 15:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="729404736"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="729404736"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2022 15:26:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:26:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:26:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 15:26:25 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 15:26:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0r2VNEjQ/InZ3ZgrSydamOwhrZm1afIvOU8LtumDanxIDQtSqebW2IfuwAs3JrL2lhe+Ej3JCzXXFhq9AubnVNTUtkR2PoXjHfg/puPh9gl/UadjmIuuAxtjET1mBuW7eLNdNopi2+pBV29bP1J/+UXWiLa0WZkHK12kPz5lqfW+pih7zXFf3n1wDvg45Kj+AD07siBsl606bUT7lS0ib+a6tL4ExqGgE/XCrQppZuj9e8/vp62ZhZREC3cNElrhZ64omWIzrluyknASUIPAqBKC4W+Dn13uMbCqSa4xbFeNWt8jKdZxLa6Tn4yp+szP4p8TYvb0A7fBZ1ROedwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJg6DMb3rc9IXZbEj/6nHqU1FxA0JjufHHduhAb++8A=;
 b=N785pjTGaWLRxQintGyehmwZjkyv238cu1FLHNzxoa2N7sYUswScyE3rofpbrdhuSWWefCZPMq/UzeZZAKM+hVnP6nTeLp/r/ydZ92MU3YiCmEdlynkiuPHlZYZlQm6hzRRFg5YifYbgeu7BILM6ddyS/4lYIuC8n6u3xMYHV7yOt+VjxYjCKAC/XDNxW8RI36E+s+m2IR+KG2A8PsPfUkvb7U9VxGfqbtch5w0AMrydVeG3BRb+nsKvlbIUyYu5dAClGetCyIsnaer1fJzLbxZmcBwbrHQry9/C9PskEyB0JJnXLhd4D0MXkhYhs7TRNVbiwlyy9e5POq30OfYo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5887.namprd11.prod.outlook.com (2603:10b6:510:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 23:26:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 23:26:22 +0000
Date:   Fri, 18 Nov 2022 15:26:17 -0800
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
Message-ID: <Y3gUmSuR3OxUwkDm@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-3-ira.weiny@intel.com>
 <20221116151936.0000662f@Huawei.com>
 <Y3WEmMlLfPoYG1R5@iweiny-desk3>
 <20221117104337.00001a3f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221117104337.00001a3f@Huawei.com>
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d151f10-ba18-4161-6561-08dac9bc4dbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfdM+qw28/J5RvnQSS0Nvtzr/BgKQtiVzgmRnZWpPo51EW2j8yuEn05mvsIri373ppAM6Hik8k8MbgIHxvshhJsNlNhkfwz6HSEY2isLknYDOcq2pyd26Y0Ephe20FV0dDNvv8Tgo+UUaOqSWVlIUudvKUArYT1X0yt+OVVyja3Cr8tLBIt8x85LbkaXAglJgQufQlGFxTJzJSHwhjgvEcoVthi5JEECZUvL1HGc7D1T2XQVxVDTfa92xs93xxmRfqnkEDJX0kmmcwy3gMVoK6f/l1yMO8dVH25h1mbFJCdBSsQGQDntGnJ4XRvPsc+UAwV1f38q9V2Se+WGvZb3CqxhPMK44CTsf8WbZKHZk2L3z33ClONiAynPgyvcmt6yoH/5RrdtGkwhWvex4+4goQFV4Y9En0qhOUv3PGCTuUrUTtLsX9kfw/2bKZeUnBR/bu2tCzR21ESiVDIJbS1Dbl3TFA00sSIOx79gZzSOpw7tAlYrJ7XDrQgrrtTesgkICsmq5Z8/x2jYkMs8j6aZdgP0rP+phEqfzQu17enE79WmUkUaSZj4kM5XtWBF0UNkjR2TR4bvWHha8TOz4OiXrflabm0QnRKDgP4ciy+H98pB/J8Fqfk9NfTwgVLh15JWpxo6x8PB73qlEKQ7yJcixg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(66899015)(8936002)(44832011)(54906003)(6916009)(316002)(4326008)(86362001)(66556008)(41300700001)(66476007)(66946007)(5660300002)(8676002)(186003)(6506007)(9686003)(33716001)(6512007)(26005)(6486002)(2906002)(6666004)(38100700002)(83380400001)(478600001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aqk/8dnkMziPVZvZkilumPmAFDzdVEZUp7rDmnUBQ9sUQJbx4ubVxim70aHU?=
 =?us-ascii?Q?tpV9aUc+ApT62ZEOQP0bigaXNeEOhztvAzE0or2ZGpCf9ye3niwGHBy6dB1U?=
 =?us-ascii?Q?fyreVvsYNMXgtv5UgykkxLawKNyatjCM1xDutASlgJ5bVFGX6uwHCxddzkQc?=
 =?us-ascii?Q?t3BxK9oDq97SXUBnxPhF8QGDb1njbNWJrprowgV6ePyd/CCxr7WxUhHeObfE?=
 =?us-ascii?Q?RTU1wblPpe8VdMpaMe1aDhXm1Lnd6VcR+zU++BpkE2CNkaTiinTF0au56/BN?=
 =?us-ascii?Q?CGCujPZaYnZxDZc1AQrClsP0B7UNRdrV5AOhQV4hDGKsoi0+pDd8BhTRfDwC?=
 =?us-ascii?Q?HK3OAoMeYgY+ocTD8qVP+IJzyI91o2xs91CCrdyvyogbJCP2ph5kgvNwOik3?=
 =?us-ascii?Q?HoOMqEoos9T6cGqcBQFKFr77pkwoUxuIi52uI+3WbkqBsad0xDfJcT1HUw40?=
 =?us-ascii?Q?oFmIf3fugSnZNarEdxss6QjS2WRK2cq3CVEtSC+Eq7UJK5Rvslm1H7FSTy9z?=
 =?us-ascii?Q?EyZ3JkgWA9BYI6VihItmFYc1cgLcGuWfDZ2qobEIF/E1JIiSiXHq9/U801ZO?=
 =?us-ascii?Q?g4GhWaqFwzJhyYIBsi3N5bbq+gk12R9xgrY5gvc+S2Bz842TOWeO0J+Lc8tC?=
 =?us-ascii?Q?aXI6z9tulCZfWazbTE2phxyU6sGvC7HAj0ppo8iC/bfsXo4l7uW7gfm2rG29?=
 =?us-ascii?Q?jdw8hI1+JIOdkUqNQ1bM9vNBYmMaN1vA/rlMnfANHSHsQWrYRp9Kq+SN+3We?=
 =?us-ascii?Q?LviCwG/HTmg1Q/perTGQTN+ytOdON2dxhEOcRhvzKTKBPn/0y8pIn5TCufBs?=
 =?us-ascii?Q?97YLJE8TKq3QQwUcy5FZS3LMHgZXO4zpp9MiYXMOs7p7ax2r/fGrblgR1sS0?=
 =?us-ascii?Q?RlWwBfxx0GgofU5SuolP94wuLgUGqIV2J9AVM6MQ8y64rnuAxy8OTvhJDv9E?=
 =?us-ascii?Q?5Dgd/47Vt67WY46T9xDH6s9f+1w/XJXm4S1x5Yda1pzNM3b+YYh1p3bfMljO?=
 =?us-ascii?Q?NwMhex36mLX0NgLgq7CCLgv4DJLwqm15/5151I/r02qx5utvam16t2XqeRNO?=
 =?us-ascii?Q?nLKjiXzRA5BnHwArjdzO59CrFYoy/ISGEtBeLJxLPQY6jS+nCIciuW4EDKwT?=
 =?us-ascii?Q?lxNP6dWOVIkGAHENJ0PbxrJ5NIkI6EGKBjDlqdrpVyEgw4y4G5gqI9wAKMwa?=
 =?us-ascii?Q?F+q2mtsG6RUa+cdDg9fY3vUUDeR7LGGmq94eiSOcX9Ey7+6Q/7BaelwCXwmS?=
 =?us-ascii?Q?j3H2WChK6Tu0twRIOZxwwWP3NtWuaMEVnRlRxKFckU37kw2apZbgvky4MnK3?=
 =?us-ascii?Q?J3K4U7yVC3jgqWKtory2ECpS8Bun7OYJgrF/+okE28Y6V52WILoYWkJXfWZ1?=
 =?us-ascii?Q?nC1te28xN3ckjI8NtsHG+USvSCiEElfzByELuGLsyVod8HdFvEGpO6dfzqJm?=
 =?us-ascii?Q?o3dtgnDHXhN/czp2W7UiAtHzLQpkEuyjvWBgWjIQ93aZ/odmx7Tig+ZM8pzW?=
 =?us-ascii?Q?2E21ChRPZr/6lpJtQcBbsJlSuiEKNpk3GNSr4vjDMaRwZ+W2uiS9S6ZwZVdm?=
 =?us-ascii?Q?jSmHar+kQAnBzaAga7EC139aJdoQ2MOVAtydkJKO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d151f10-ba18-4161-6561-08dac9bc4dbd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 23:26:22.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYIml33voLQZ/qbe38Z36dM6hGmsJrYPE9sjAOeWyWsqDzN8LlEIfSjYLON962X31LRQzp93GYHMN9CvUnXUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5887
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:43:37AM +0000, Jonathan Cameron wrote:
> On Wed, 16 Nov 2022 16:47:20 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> 

[snip]

> > 
> > >   
> > > > +			int i;
> > > > +
> > > > +			for (i = 0; i < nr_rec; i++)
> > > > +				trace_cxl_generic_event(dev_name(cxlds->dev),
> > > > +							type,
> > > > +							&payload.record[i]);
> > > > +		}
> > > > +
> > > > +		if (trace_cxl_overflow_enabled() &&
> > > > +		    (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW))
> > > > +			trace_cxl_overflow(dev_name(cxlds->dev), type, &payload);
> > > > +
> > > > +	} while (pl_nr > CXL_GET_EVENT_NR_RECORDS ||  
> > > 
> > > Isn't pl_nr > CXL_GET_EVENT_NR_RECORDS a hardware bug? It's the number in returned
> > > payload not the total number.  
> > 
> > I don't think so.  The only value passed to the device is the _input_ payload
> > size.  The output payload size is not passed to the device and is not included
> > in the Get Event Records Input Payload.  (Table 8-49)
> > 
> > So my previous code was wrong.  Here is an example I think which is within the
> > spec but would result in the more records flag not being set.
> > 
> > 	Device log depth == 10
> > 	nr log entries == 7
> > 	nr log entries in 1MB ~= (1M - hdr size) / 128 ~= 8000
> > 
> > Device sets Output Payload.Event Record Count == 7 (which is < 8000).  Common
> > mailbox code truncates that to 3.  More Event Records == 0 because it sent all
> > 7 that it had.
> > 
> > This code will clear 3 and read again 2 more times.
> > 
> > Am I reading that wrong?
> 
> I think this is still wrong, but for a different reason. :)

I hope not...  :-/

> If we don't clear the records and more records is set, that means it didn't
> fit in the mailbox payload (potentially 1MB)  then the next read
> will return the next set of records from there.

That is not how I read the Get Event Records command:

From 8.2.9.2.2 Get Event Records

... "Devices shall return event records to the host in the temporal order the
device detected the events in. The event occurring the earliest in time, in the
specific event log, shall be returned first."

If item 3 below is earlier than 4 then it must be returned if we have not
cleared it.  At least that is how I read the above.  :-/

> 
> Taking this patch only, let's say the mailbox takes 4 records.
> Read 1: Records 0, 1, 2, 3 More set.
>    We handle 0, 1, 2
> Read 2: Records 4, 5, 6 More not set.
>    We handle 4, 5, 6
> 
> Record 3 is never handled.
> 
> If we add in clearing as happens later in the series,

I suppose I should squash the patches as this may not work without the
clearing.  :-/

> the current
> assumption is that if we clear some records a subsequent read will
> start again.  I'm not sure that is true. If it is spec reference needed.
> 
> So assumption is
> Read 1: Records 0, 1, 2, 3 More set
>   Clear 0, 1, 2
> Read 2: Records 3, 4, 5, 6
>   Clear 3, 4, 5 More not set, but catch it with the condition above.
> Read 3: 6 only
>   Clear 6
> 
> However, I think a valid implementation could do the following
> (imagine a ring buffer with a pointer to the 'next' record to read out and
>  each record has a 'valid' flag to deal with corner cases around
>  sequences such as read log once, start reading again and some
>  clears occur using handles obtained from first read - not that
>  case isn't ruled out by the spec as far as I can see).

I believe this is a violation because the next pointer can't be advanced until
the record is cleared.  Otherwise the device is not returning items in temporal
order based on what is in the log.

> 
> Read 1: Records 0, 1, 2, 3 More set.  'next' pointer points to record 4.
>   Clear 0, 1, 2
> Read 2: Records 4, 5, 6 More not set. 'next' pointer points to record 7.
>   Clear 4, 5, 6
> 
> Skipping record 3.
> 
> So I think we have to absorb the full mailbox payload each time to guarantee
> we don't skip events or process them out of order (which is what would happen
> if we relied on a retry loop - we aren't allowed to clear them out of
> order anyway 8.2.9.2.3 "Events shall be cleared in temporal order. The device
> shall verify the event record handles specified in the input payload are in
> temporal order. ... "). 
> Obviously that temporal order thing is only relevant if we get my second
> example occurring on real hardware.  I think the spec is vague enough
> to allow that implementation.  Would have been easy to specify this originally
> but it probably won't go in as errata so we need to cope with all the
> flexibility that is present.

:-(  Yea coulda, woulda, shoulda...  ;-)

> 
> What fun and oh for a parameter to control how many records are returned!

Yea.  But I really don't think there is a problem unless someone really take
liberty with the spec.  I think it boils down to how one interprets _when_ a
record is removed from the log.

If the record is removed when it is returned (as in your 'next' pointer
example) then why have a clear at all?  If my interpretation is correct then
the next available entry is the one which has not been cleared.  Therefore in
your example 'next' is not incremented until clear has been called.  I think
that implementation is also supported by the idea that records must be cleared
in temporal order.  Otherwise I think devices would get confused.

FWIW the qemu implementation is based on my interpretation ATM.

Ira

> 
> Jonathan
> 
> 
> > 
> > >   
> > > > +		 payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> > > > +}  
> > > 
> 
> > 
> 
