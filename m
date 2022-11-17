Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825C562D038
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiKQAto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiKQAt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:49:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2D66C71B;
        Wed, 16 Nov 2022 16:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668646049; x=1700182049;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i89mYylvvffIYCnulvPrlzoXsy4ed8b1zLh+AEV2x4E=;
  b=A+XYHxvQzxYFBUMoBLOKZdjGmU8/NGagpWCrGngyk4cDRQHeabsSE7Ln
   J2kao0BjjcslBq7oeYZBQt6jdrnbnCHTPr1OH3XyawASzbq6VGgXExIC9
   mFe8KhZUaF/A/sHviQvC6BrDHnLI/MXxKWYppc0wkPhLOrMtnocDqeAVR
   bR4ZC8khm8kdX2LvbNvwqRxtGGcf2eP+aDob3+mPhPwI08QpoYQIZDS+m
   fLQOdhOo8QWz3qd8HDWLZfzqv9dDyYypIDL9IXKnCoeW2IRr7e291Vklx
   pPrr5w6JS87mQYP4mhX7vSsuENgeNoLvirBRXOLXHTeW7VWZkMpo8Srku
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="311417350"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="311417350"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 16:47:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670709432"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="670709432"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2022 16:47:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:47:28 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:47:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 16:47:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 16:47:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt/A9KbSrRbM9nAdrLPhfrd5eDyyCt/8+ACCWfMjcJngMBMH8rmssHb28RyASxxx2EKkpRGSZsvkPMw/Wihlpgf313qcLD5nSYZ1axgO0YDTBAdXklhO6VUmDf6stlExxpNxIMM5FWyb/Z/hq4QD+OurhA3Y/BD8HMltCfG1qIyq8bGBblJ9HlFGVA3rTeeMsrSc7l1ZZecZWG/Y5i3HMYhsMNfM4qfZgGxFyK/Q4hJ3GSgzTyK4EFx1HR+QkRHQf8hmBGdx95U+3q8eFnuuzjiWv/7mua85p0ejSOalyo7UlSUht9/rrNBfABa8tBtX1BuFtArt1V+pLuuuGwPABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eni19mgdeb9CtbXkkPqzN1j/cui7WAcQ+3Du5ToVU+0=;
 b=DtJiE7q0UEO57V2MntKsEk7awAeCAKhkr/vzhh2NJcnfw0PyIXFwlNHAtfiFOygaatOBW9YTPz8rgnQzEwCHXzNYMCYumMnNhhbrVuDxl5cBXVoNYoRcztihwFpfJEzqoQQMFQ+zCoKfjTwiH/qupucuC69vk7SpMKOOeGeEexmsThX/P05daZ4/qOuA21g4Xnk9C6hXA6rHPHj0jMbah2sAHjLRQPLqk2j/H4I9bU2zFuZkqGppI5ZRQKIoVg+ckBS4HPLa0J3zmd1k1Vo56QjqM2Av4+0pgOeK4Xq2ziVQLSPkq7JWwwctk1fo4qXo/Tr36fBSg6ExXoXI599MgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 00:47:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 00:47:25 +0000
Date:   Wed, 16 Nov 2022 16:47:20 -0800
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
Message-ID: <Y3WEmMlLfPoYG1R5@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-3-ira.weiny@intel.com>
 <20221116151936.0000662f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116151936.0000662f@Huawei.com>
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abcc5d5-afa0-4221-1ad5-08dac8354b58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfMN/aCYB9cYg52JZOwcAB+A2bm97fMMT34Mt9euXuH8CTNT6hQEc/WgoD03s+TSkJOshriqt+5HakA2JaTCfOiqa9OvToo181suz4791C7Hhz0gjKHwX4JdiQhBawLKf5QKKFgfmUugtPihOdSt2a+sXX+0rL4j/gR70sn1cxGnEB2wDrcYLsjFqo7RDcWGri6v4O80CNCNYW6NXTePftFPptxNz3PIbql4uL4fXFU0M6iCW1Lu533tmel5LxqDmi4+8sW0NBTcRrDVI6+ZpNuTmVXSw7RRlQv3wS8pA2QzqpeqAF+n8FNAQIcRaoAmZD7944XZWWKe7gyEfu6wUzXzhBRbSNk9AnLh75h/p2lxSrAikrZDvQz3TCiDhAeU0Mhr4hawivucA8SBwfuJQozM8AGW1e6jz76UXhbNq+BQWAI/ez6SM4YfC4bd4CigMd+DSYv/dl5rExabfptfGEhJSLujO+bvU9AnaTZ2PdyiSPQHzfzYavFQ8B+fqkynfAd2yW8UZMS5gNJwKsx2a9VW8gswB2tsj7gYEGwJ8nlIDg8ORdnBfv9jX639+ughAT277UXWmlSU17heW4jT/mtcoVh6ZWUCwqNdlWj1fJRIPq/VT17ufEraafyKIumCE1Y3kcnQ7+jcky+2+m6hed0c1dkYXRQ4EIe/iDaHg7eNR85F5yB/kqZwp8m9HS1RI6g0CUXe0VQNUsDbORJPtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(6486002)(478600001)(6666004)(54906003)(6916009)(66556008)(9686003)(8676002)(6512007)(66946007)(66476007)(4326008)(8936002)(33716001)(26005)(41300700001)(38100700002)(186003)(6506007)(5660300002)(316002)(44832011)(82960400001)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZHJoYaHqJ2SZUZlzUBc9pj3jPOn31MgB4TGfAj8J0YH7MwNTDbUyfwE7Uxx?=
 =?us-ascii?Q?JdL5hRfmFBcPgtnYgjzkl6ZhOMprO6renRUIfI04aC41AxA6P9q9EK8APmXJ?=
 =?us-ascii?Q?oLYRA9zgW5fUrvRDwTLBIB0JGNAGKNpIt7GJibCic3/WGgR0ce7qPi/6XLyQ?=
 =?us-ascii?Q?xJwEnR1xXPZGK2IypMUQSYRcfexUGq6Cti4zLXhkMPOuUoAE7rj3rt/CZ+7k?=
 =?us-ascii?Q?VtIJ+qu1zgwWJZsAnuvxqGzS03KGyKW8Elfdd1pCIEIfCxc6kHNL4k1sjUIA?=
 =?us-ascii?Q?z//lO0Z0oGsGZyKxkBrcuPYxcIN0iSn1++VDY4rEExWiwiLbS7dmgDWPm+Jl?=
 =?us-ascii?Q?RvomKGLxZupIR+7OhXpKURW7gJHLOEUCAz+rIuv/6kaD26mCzmIsevJRF0Ih?=
 =?us-ascii?Q?Lovk1tunNd3jVYIlVLCpiQ/1J/MbBdDbwUQ6kMSjS3EY/f7DeD/3IONXAOrl?=
 =?us-ascii?Q?xpjojDs7JVjgHJtPPeU736B5RHmt4gysF7L2W9pg/sRCig0ApZsKklvHyPmi?=
 =?us-ascii?Q?rZAh0He/aS3MdQwjaJI6FRZ6O3FyAumOw4xS2r7Y0tnpqG6JW9kyr03duYkQ?=
 =?us-ascii?Q?arPqhzaD9DKiofBYwwuHQRrhSBc152scFWSmK+1Scu56JmMLOK2DV91fdRsE?=
 =?us-ascii?Q?TD0Ph6MHSCjfeo1Jy7+l1uCvaa4IBmnF2ts57Hcrbwv6aRDfYmtFvr9dKTy1?=
 =?us-ascii?Q?C6bOpY6kDk0iH4HUigZAV5bmArVRwXrRX9WXy76GWo05j71wKXpYBeD/K8Bo?=
 =?us-ascii?Q?0/Ds+Iwgm6bZEaJgHFaKKe4JQPu0ZVe6Pz7ErFTWJGJ3SGGdjnyZVonjwFJG?=
 =?us-ascii?Q?An+2phh6eM6dIlKGz2Q3fCPMFaQ4DZFfR+3tKduAvT7+04y82HjkO+wbwOgv?=
 =?us-ascii?Q?XCWcM61wEi1lgLl6h757K9WH2mF5zya64/GV5kbhFIf/8aUMlB5OxU1aCtHu?=
 =?us-ascii?Q?sYfYJ+yH+CEH9+9xeXcIckbV3IQM1p839+nJKYLd8xgPTDKQ9PQCElCDIG5P?=
 =?us-ascii?Q?rfRVscUe860xnT7fs2rwc/0CAeNqIxjknG3XoqyYgf5Nfoc1PwvZ1R2DomoD?=
 =?us-ascii?Q?gDPQTw4YoJLfs/+ld8ukvvVsagg/Vm+/WZS7NsIlX8dIUuw1iG22iW/O+ExG?=
 =?us-ascii?Q?7ZsjhF+WFSwDvLF7nBBMlO1wkOGbUxK/bnkNYqaCvxVDBdzLFrl3thUKRd+y?=
 =?us-ascii?Q?gGysQTVStRnJ+XLJZBiP6oKW1pzQhNAE+UVwIOSRZJx4AcKgjNe3vUOQu+Eq?=
 =?us-ascii?Q?wzc0CkoEdWkZBWx7bQoQSXs8Hyc82cdwRY90idT3XHZr1k9TF733sIGkQaBP?=
 =?us-ascii?Q?J9e8m/1j1bpXnWCqasyALdTQ9WSGtAyqyJMAgqaO7FLdk4nn+eT1o+gOcGJv?=
 =?us-ascii?Q?XfAlSjJiqfpJHYTUjf1U8rzOK349+sKAX01DYtKG/NzDy+fs9jIk4H40b4BN?=
 =?us-ascii?Q?LGo3XIjG+VIXTBl8g+Im/PvlV1GhdBlPja8a/FhjuCcnRZK1XZhpAzsVK5YG?=
 =?us-ascii?Q?o0bjwsuVXMxVP92HXQgrDW2rrvlb6Ya9fACEKHGrOzbhDXEbGcCDx+DVkIry?=
 =?us-ascii?Q?wKQj+r7aAfDyVKqKiBt3C4Tjh1E1+RRraQ9CuzTK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abcc5d5-afa0-4221-1ad5-08dac8354b58
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 00:47:25.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyQ0TQrvUOJdJjNymVSFzyXoulPUCuMeCz2159ADNN+cYfsrDdgBDoNmYO5LaMstU2I+6m+R1GxvIbl6eDOX3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:19:36PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 10:57:49 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL devices have multiple event logs which can be queried for CXL event
> > records.  Devices are required to support the storage of at least one
> > event record in each event log type.
> > 
> > Devices track event log overflow by incrementing a counter and tracking
> > the time of the first and last overflow event seen.
> > 
> > Software queries events via the Get Event Record mailbox command; CXL
> > rev 3.0 section 8.2.9.2.2.
> > 
> > Issue the Get Event Record mailbox command on driver load.  Trace each
> > record found with a generic record trace.  Trace any overflow
> > conditions.
> > 
> > The device can return up to 1MB worth of event records per query.  This
> > presents complications with allocating a huge buffers to potentially
> > capture all the records.  It is not anticipated that these event logs
> > will be very deep and reading them does not need to be performant.
> > Process only 3 records at a time.  3 records was chosen as it fits
> > comfortably on the stack to prevent dynamic allocation while still
> > cutting down on extra mailbox messages.
> > 
> > This patch traces a raw event record only and leaves the specific event
> > record types to subsequent patches.
> > 
> > Macros are created to use for tracing the common CXL Event header
> > fields.
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Hi Ira,
> 
> A question inline about whether some of the conditions you are checking
> for can actually happen. Otherwise looks good to me.
> 
> Jonathan
> 

[snip]

> > +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > +				    enum cxl_event_log_type type)
> > +{
> > +	struct cxl_get_event_payload payload;
> > +	u16 pl_nr;
> > +
> > +	do {
> > +		u8 log_type = type;
> > +		int rc;
> > +
> > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> > +				       &log_type, sizeof(log_type),
> > +				       &payload, sizeof(payload));
> > +		if (rc) {
> > +			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
> > +				cxl_event_log_type_str(type), rc);
> > +			return;
> > +		}
> > +
> > +		pl_nr = le16_to_cpu(payload.record_count);
> > +		if (trace_cxl_generic_event_enabled()) {
> > +			u16 nr_rec = min_t(u16, pl_nr, CXL_GET_EVENT_NR_RECORDS);
> 
> Either I'm misreading the spec, or it can't be greater than NR_RECORDS.

Well...  I could have read the spec wrong as well.  But after reading very
carefully I think this is actually correct.

> "The number of event records in the Event Records list...."

Where is this quote from?  I don't see that in the spec.

> Event Records being the field inside this payload which is not big enough to
> take more than CXL_GET_EVENT_NR_RECORDS and the intro to Get Event Records
> refers to the number being restricted by the mailbox output payload provided.

My understanding is that the output payload is only limited by the Payload Size
reported in the Mailbox Capability Register.Payload Size.  (Section 8.2.8.4.3)

This can be up to 1MB.  So the device could fill up to 1MB's worth of Event
Records while still being in compliance.  The generic mailbox code in the
driver caps the data based on the size passed into cxl_mbox_send_cmd() however,
the number of records reported is not changed.

> 
> I'm in favor of defense against broken hardware, but don't paper over any
> such error - scream about it.

I don't think this is out of spec unless the device is trying to write more
than 1MB and I think the core mailbox code will scream about that.

> 
> > +			int i;
> > +
> > +			for (i = 0; i < nr_rec; i++)
> > +				trace_cxl_generic_event(dev_name(cxlds->dev),
> > +							type,
> > +							&payload.record[i]);
> > +		}
> > +
> > +		if (trace_cxl_overflow_enabled() &&
> > +		    (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW))
> > +			trace_cxl_overflow(dev_name(cxlds->dev), type, &payload);
> > +
> > +	} while (pl_nr > CXL_GET_EVENT_NR_RECORDS ||
> 
> Isn't pl_nr > CXL_GET_EVENT_NR_RECORDS a hardware bug? It's the number in returned
> payload not the total number.

I don't think so.  The only value passed to the device is the _input_ payload
size.  The output payload size is not passed to the device and is not included
in the Get Event Records Input Payload.  (Table 8-49)

So my previous code was wrong.  Here is an example I think which is within the
spec but would result in the more records flag not being set.

	Device log depth == 10
	nr log entries == 7
	nr log entries in 1MB ~= (1M - hdr size) / 128 ~= 8000

Device sets Output Payload.Event Record Count == 7 (which is < 8000).  Common
mailbox code truncates that to 3.  More Event Records == 0 because it sent all
7 that it had.

This code will clear 3 and read again 2 more times.

Am I reading that wrong?

> 
> > +		 payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> > +}
> 
> 
> > diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> > new file mode 100644
> > index 000000000000..60dec9a84918
> > --- /dev/null
> > +++ b/include/trace/events/cxl.h
> > @@ -0,0 +1,127 @@
> 
> 
> > +#define CXL_EVT_TP_fast_assign(dname, l, hdr)					\
> > +	__assign_str(dev_name, (dname));					\
> > +	__entry->log = (l);							\
> > +	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> > +	__entry->hdr_length = (hdr).length;					\
> > +	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> > +	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> > +	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> > +	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> > +	__entry->hdr_maint_op_class = (hdr).maint_op_class
> > +
> Trivial: Maybe one blank line is enough?

Yea I'll adjust,
Ira

> > +
> > +#define CXL_EVT_TP_printk(fmt, ...) \
> > +	TP_printk("%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "		\
> > +		"handle=%x related_handle=%x maint_op_class=%u"			\
> > +		" : " fmt,							\
> > +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
> > +		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> > +		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
> > +		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> > +		##__VA_ARGS__)
> 
