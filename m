Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C365FF6E1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJNXdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNXdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:33:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2135610F8B8;
        Fri, 14 Oct 2022 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665790431; x=1697326431;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PbcFdDfy0wjAoiIqHLGDVUNq6xpC92Qw6FIu1awKcG4=;
  b=hWc+EQms4uT5UCsBcgse+so40swUu9zFaLEb5AlGmV4mZzxPxZoIWU0T
   0mh9yn25JIj2/BMYdGlAoYUO3sz9Al+RHYWaLu8jiUysYifseKu64HP4S
   nugXa8eWmW0+iVZc1+CCbcvBJjnXvzFdb37QB8v+bsSXsSGtQoBRk/uhC
   sYb0erbNdyv0r5KRdpq6F608fYgnin8RJOPYCn1wH8MLsdZkatK5Z9Nbb
   zVWAomRQSiF5oCfYV99AGTXqqDTO+zWkAgACX2pfeSlf4pPQ4qJ6lgvQi
   ncJd35IJ2dacerGdDA30jxwsXoWETeAkFPDbvmKwQgXkvKf8vOXuS8001
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="369690283"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="369690283"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="605536241"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="605536241"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2022 16:33:50 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 16:33:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 16:33:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 16:33:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 16:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmfGNLQHas9CducIXU8eLem9FHPbRLUE6eMsqGO0B/H/jrJDqFfHY3E6P6d+6PxGKm8rRFaNPWAPGoXJpEhDS7a81af9sFnGZ1f/6FCkCB4/excugfZsngJnrI1ouhuSqOyUdugofLw4eotCzGjWG7lZnDehb7G/SWYHaotkD4cSrMXkqIWPNObFd2sYBJbTekkfTTGhcGkAq9qCeBbYOW4aBLYutaE/qMzQXA11klpjEGXxkU07r8MrjtLxCzy1IS6h7Nm8NiI3PAbIvK0c3Wxy05lch5lJpvhHUxXWZZRBVJbMhZhSsEYKKrBmLrWFzn4aXOeEgTWRQozZXBUh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4MlsjIX47UJo8OcxJJ3P7aOKwBVvjVgQcNtHt6hxSU=;
 b=iJAnlSXz5MScTGkNvVnnZRH9c9c/iGdijHRIosvLiBkKgvQoZqtFgMAeYMcsPMxWYtzu4U2g0rhfa7IcIb9lFKvxtLx105uwugqR49Sc/3rwEmP4fJepWSNqgiXDDyywoksHkkQPkjPLBJ/3gkP2lN/zttT04lzy9ZHaUbe7EFQHDar/ATxeAhLdxWJu/waZGcLn1SO3mDxfKqnoQjz7vXnbtJP9myvbXt4C5N/cYeEGChk8rBKyp6RV+7maS5sGUnhH2J6ADNxLu/PBmWtlKZbH6VEUvJJYBbDlYibjXpwD/YnPPDizhruTlgJALOFeldOzLm1up6RaowLC92a6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 23:33:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 23:33:46 +0000
Date:   Fri, 14 Oct 2022 16:33:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 05/11] cxl/mem: Trace General Media Event Record
Message-ID: <Y0nx1UOeYfQu5WYO@iweiny-desk3>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-6-ira.weiny@intel.com>
 <20221011135702.00006f74@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221011135702.00006f74@huawei.com>
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1893d185-675b-481e-9ded-08daae3c8a3a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFNIR/IKNqRYq4wywsSR+0+G9mME0vSIPJtLnaqnXIYvP/71hRC9fTeHcuY/qz7byNrqxY2SxCUyvveFpC2fIw5hgonF+KRJL2c2sKo4BvWgR4IgSYhlT6+AYX4tGeGz65akTfZnsspHwG0LjqwDy6VsulMMnlE/4NGiiGSbF64hnzR2evmo21HrVRN3akLtU9pekkmxzKHLnh8klKtMO1O4XGZXLDxysOH0wt/IJf0wydk0qEv7nWzIE+78oX/0F1PDn8ZdmXYdNTbTRdNXei4x17kaQdXGG+ZIk2y+SgMM9naSmx/d38AHu0+fTDeFjNDE9zLCcwPO4gmoIXFxKg5q0rwudF/BrO2ZD1GO0q3LqkgPxT3e9LCyORZIRqp9aXvDVX4KQuDPa/75PUWmfJWklJ3FGKjI4HsxDtcv6jBVPkpfZhflWIzq+W11mY5Lqz0Bb08E3GvLAyIvlAgTcBqIX3woWEpGn3peGpWHguMzJ1F/YFIZNmgXLUzep6LZKkNaDwiLHWOVD7tDRSEe1S1aFKzGY5RrkqdolTo4aylfUlKo6CJHQV2B3gx9k7AbXYRSt9v5K5qhMXvNuyv1DhQZva4mbOWE42gfCqMWa20BBnVcdy/YpOyaU+BZU3HAAh/aGSaDZsiPZMqtmiAV8cbz8nJb+iorX/uBC+GdU8vqWqq7Mu17eh9HhjeVQjiaJHvLzgdlIUtNjMjo+fj/1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(8936002)(8676002)(2906002)(66556008)(44832011)(4326008)(41300700001)(5660300002)(66476007)(86362001)(82960400001)(33716001)(38100700002)(6666004)(316002)(478600001)(83380400001)(6506007)(6916009)(26005)(6512007)(54906003)(9686003)(66946007)(186003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tcc8JvuAlxD9GIqOZW3MCZfycpRvCPztisWwt3wtYHrmhrrMjezEp1Zxx7wy?=
 =?us-ascii?Q?q0jZTTtCpLZvnPcvXG3mHNuUImrf8FEaMKkFxNM3IUleBfzkT3AjNY366ZmI?=
 =?us-ascii?Q?IbkjHX6+tpu8ImZK0tNiFqvM9n9ZsS/ax27PXBb+csstgjnwKnN1/GKBdsWD?=
 =?us-ascii?Q?uZTzoIifkmScxB2TJOcSd0kgNuP5iK9lxiIYN6RZemIYJgSv5fWvJcsOqXNc?=
 =?us-ascii?Q?PrVOidjVwoLudl5ckUbDyvrPMWIn7INdBiX4Gabo1BBLSXlrAsdpGp1058Yo?=
 =?us-ascii?Q?QlTPedHZ/xEVUBQ73IMnuw25ZOphwwvWrHIabDlk80OcZgRhsFIeodNbC5G9?=
 =?us-ascii?Q?Edkwk9Ix+MjfuO4We7nTtd9y9p7mVBwk8Ygx1hdf5Fxz7PoWadvxtew41yAI?=
 =?us-ascii?Q?fv8CbzjcgEN21dr38yU2cHOgGY0GWJccJdjSURVBMy1swfpEDR63BS0lPKY+?=
 =?us-ascii?Q?uti9hDTuveC6zXHaDYQycRDbYrLnwdflm/akgpdcHNA9/J1K8rC1SYKc7LXt?=
 =?us-ascii?Q?EUCn5AhGOJO+lmFO4zjBr7/Jnx666d3dXwXfZJJ8pJXtzcQ3NAzNm8K9oZY0?=
 =?us-ascii?Q?H742JbA+eO0waqrEXVNU8Stia473KUBf2XQl6L8NQjNZhGOYgIauP+YKGfUo?=
 =?us-ascii?Q?zH7j78gGGrTlqz94xQCpWfuuvz2+LnM6RVydQiFAD1x43JDqOVrTIbKh9j59?=
 =?us-ascii?Q?hf0y4/lSS+hwT0u2whUZaACBSP+fg5NAyQQb2LBe35TYTynvrUb8gYjdOoxw?=
 =?us-ascii?Q?Mq6fOtD8DcNTDrJax2d5JXjsOCPVQ7WIBoEBL6ghxsJo4xDzSP3WfVeDIg4b?=
 =?us-ascii?Q?RdOQYjta9gDTHSg5eUCwCfe1RQCtkBwgBBKFC7IE+en210X0S10uxjK5p4Mi?=
 =?us-ascii?Q?mMlVuLEvzt3Homn7iMXwbHY2Hcs9/jzgrUHShSRIbTUQg96b6LSwwxGUc9jA?=
 =?us-ascii?Q?KbNXxlR9uSTlU/RPAHp1FmSutt4emS96389XfHKMOlEDp6F88xmYvNm7G6d5?=
 =?us-ascii?Q?ncb3HnGhdSCKKm7shSrv59iJDSZoU0DncMqVGh4sHEnO9HzPfmejIM6o27VR?=
 =?us-ascii?Q?OPDpRN/gi5NeSp/yic7UpW5H/0CRqG0YUBlnc2bhnqsvpOObRx+uI+zi4bch?=
 =?us-ascii?Q?K8a7DU0nfKVp4dZYhvRL6fUBF43OnaFuD4sWvEyChif8riJQ1R7kV9NZilS6?=
 =?us-ascii?Q?VL2/TAfVJUosifKJ34KI2t8dcCakGYW99qfs9VTlAkC4KajuIUmI2jATDyo2?=
 =?us-ascii?Q?n/CmnUKIRTPQqIhnn0EKP0hszYSs2ejoTbMeDU31OVTFsh8oXCKjQmichraB?=
 =?us-ascii?Q?gp739+g49770OyP2A33tpJ+wV4ZnJT5xj+MYn1kIggF1O5qIVKlvZZV4OQcR?=
 =?us-ascii?Q?W018zlI2rcLAMijmPuu6E7bF1toSph8mB5oIGdF83WQeG1PyRjk5GhwZxjpb?=
 =?us-ascii?Q?2Rh0TOuqs7B8lyUSzDHhyvdtc5RFnztwDC6QA8tw41ieEvLwKMfBhFz1Ojec?=
 =?us-ascii?Q?C2/opNC/2JoS7Q8IgzudQ6k1NbJN1IXpdt1SNYAI9NY0gT2OQYsPU8bqn8jj?=
 =?us-ascii?Q?g2kqOW0ZAvXlkvA1OfiFfX1Q21QGG+ggPLjkrx8R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1893d185-675b-481e-9ded-08daae3c8a3a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 23:33:46.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUw86UWG0WvqcLhto95u7wDiI+V42Z4Em6PNwV84Z9R0SBah+Q2vljQBum0kzRvvnpBqxBzHqodzHEvNAI3sBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6187
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:57:02PM +0100, Jonathan Cameron wrote:
> On Mon, 10 Oct 2022 15:41:25 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> > 
> > Determine if the event read is a general media record and if so trace
> > the record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> I'll review the rest of these with the assumption that the question
> of reserved bytes in tracepoints will get resolved before these go in.

Yea I'm removing them.  I think I messed up somehow because I thought I had
removed the reserved fields from the records.  But perhaps that was only in my
dreams...  :-/  Sorry.  :-)

> 
> One minor comment on a comment inline.  Other than those lgtm
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks!

[snip]

> >  
> > +/*
> > + * General Media Event Record
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + */
> > +static const uuid_t gen_media_event_uuid =
> > +	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> > +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
> > +
> > +static void cxl_trace_event_record(const char *dev_name,
> > +				   enum cxl_event_log_type type,
> > +				   struct cxl_get_event_payload *payload)
> > +{
> > +	uuid_t *id = &payload->record.hdr.id;
> > +
> > +	if (uuid_equal(id, &gen_media_event_uuid)) {
> > +		struct cxl_event_gen_media *rec =
> > +				(struct cxl_event_gen_media *)&payload->record;
> > +
> > +		trace_general_media(dev_name, type, rec);
> > +		return;
> > +	}
> > +
> > +	/* For unknown record types print just the header */
> > +	trace_generic_event(dev_name, type, &payload->record);
> 
> Looks like it prints the whole thing now...

An unknown record is dumped yes.  I'm ok with skipping this but it was
discussed early on that any unknown record would be passed through.

> 
> 
> > +}
> > +
> 
> 
> > diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> > index 318ba5fe046e..82a8d3b750a2 100644
> > --- a/include/trace/events/cxl.h
> > +++ b/include/trace/events/cxl.h
> > @@ -122,6 +122,114 @@ TRACE_EVENT(generic_event,
> 
> 
> > +#define CXL_GMER_VALID_CHANNEL				BIT(0)
> > +#define CXL_GMER_VALID_RANK				BIT(1)
> > +#define CXL_GMER_VALID_DEVICE				BIT(2)
> > +#define CXL_GMER_VALID_COMPONENT			BIT(3)
> > +#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
> > +	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
> > +	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
> > +	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
> > +	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
> > +)
> 
> I'd still rather we only had the TP_printk only print those parts that are valid
> rather than the mess of having to go check the validity bit before deciding whether
> to take notice of the field.  But meh, not that important given thats
> not the main intended way to consume this data.
> 

Ok I spent some time really thinking about this and below is an attempt at
that.

However, I must be missing something in what you are proposing because I don't
like having extra space in the trace buffer to print into like this and I
can't figure out where else to put a print buffer.

Also note that this will have no impact on most of the user space tools which
use libtracefs as they will see all the fields and will need to do a similar
decode.

Do you really think this is worth the effort?

Ira


commit 54c4ee67bcac6a38cbc9b0ea2ef952e197356dee
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Fri Oct 14 16:15:27 2022 -0700

    squash: Attempt to print only valid fields per Jonathan suggestion

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2add473fc168..9e15028af79c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -720,6 +720,28 @@ static const uuid_t gen_media_event_uuid =
        UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
                  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
 
+const char *cxl_gem_print_valid(u8 *buf, int nr, u16 valid_flags, u8 channel,
+                               u8 rank, u32 device, u8 *comp_id)
+{
+       char *str = buf;
+       int rc = 0;
+
+       if (valid_flags & CXL_GMER_VALID_CHANNEL)
+               rc = snprintf(str, nr, "channel=%u ", channel);
+
+       if (valid_flags & CXL_GMER_VALID_RANK)
+               rc = snprintf(str + rc, nr - rc, "rank=%u ", rank);
+
+       if (valid_flags & CXL_GMER_VALID_DEVICE)
+               rc = snprintf(str + rc, nr - rc, "device=%u ", device);
+
+       if (valid_flags & CXL_GMER_VALID_COMPONENT)
+               rc = snprintf(str + rc, nr - rc, "comp_id=%*ph ",
+                             CXL_EVENT_GEN_MED_COMP_ID_SIZE, comp_id);
+
+       return str;
+}
+
 static void cxl_trace_event_record(const char *dev_name,
                                   enum cxl_event_log_type type,
                                   struct cxl_get_event_payload *payload)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8fbd20d8a0b2..3d3bfef69d32 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -429,6 +429,13 @@ struct cxl_event_gen_media {
        u8 reserved[0x2e];
 } __packed;
 
+#define CXL_GMER_VALID_CHANNEL                         BIT(0)
+#define CXL_GMER_VALID_RANK                            BIT(1)
+#define CXL_GMER_VALID_DEVICE                          BIT(2)
+#define CXL_GMER_VALID_COMPONENT                       BIT(3)
+const char *cxl_gem_print_valid(u8 *buf, int nr, u16 valid_flags, u8 channel,
+                               u8 rank, u32 device, u8 *comp_id);
+
 struct cxl_mbox_get_partition_info {
        __le64 active_volatile_cap;
        __le64 active_persistent_cap;
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
index e3e11c9055ba..27bb790cb685 100644
--- a/include/trace/events/cxl.h
+++ b/include/trace/events/cxl.h
@@ -161,16 +161,7 @@ TRACE_EVENT(generic_event,
        { CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,     "Internal Media Management" }   \
 )
 
-#define CXL_GMER_VALID_CHANNEL                         BIT(0)
-#define CXL_GMER_VALID_RANK                            BIT(1)
-#define CXL_GMER_VALID_DEVICE                          BIT(2)
-#define CXL_GMER_VALID_COMPONENT                       BIT(3)
-#define show_valid_flags(flags)        __print_flags(flags, "|",                  \
-       { CXL_GMER_VALID_CHANNEL,                       "CHANNEL"       }, \
-       { CXL_GMER_VALID_RANK,                          "RANK"          }, \
-       { CXL_GMER_VALID_DEVICE,                        "DEVICE"        }, \
-       { CXL_GMER_VALID_COMPONENT,                     "COMPONENT"     }  \
-)
+#define CXL_VALID_PRINT_STR_LEN 512
 
 TRACE_EVENT(general_media,
 
@@ -191,6 +182,7 @@ TRACE_EVENT(general_media,
                __array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
                __field(u16, validity_flags)
                __field(u8, rank) /* Out of order to pack trace record */
+               __array(u8, str, CXL_VALID_PRINT_STR_LEN)
        ),
 
        TP_fast_assign(
@@ -209,17 +201,17 @@ TRACE_EVENT(general_media,
                __entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
        ),
 
-       CXL_EVT_TP_printk("phys_addr=%llx volatile=%s desc='%s' type='%s' " \
-               "trans_type='%s' channel=%u rank=%u device=%x comp_id=%s " \
-               "valid_flags='%s'",
+       CXL_EVT_TP_printk("phys_addr=%llx volatile=%s desc='%s' type='%s' "     \
+               "trans_type='%s' %s",
                __entry->phys_addr & CXL_GMER_PHYS_ADDR_MASK,
                (__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
                show_event_desc_flags(__entry->descriptor),
                show_mem_event_type(__entry->type),
                show_trans_type(__entry->transaction_type),
-               __entry->channel, __entry->rank, __entry->device,
-               __print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
-               show_valid_flags(__entry->validity_flags)
+               cxl_gem_print_valid(__entry->str, CXL_VALID_PRINT_STR_LEN,
+                                   __entry->validity_flags, __entry->channel,
+                                   __entry->rank, __entry->device,
+                                   __entry->comp_id)
        )
 );

