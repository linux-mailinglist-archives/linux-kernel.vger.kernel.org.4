Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF13640FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiLBV2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiLBV23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:28:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610C92A246;
        Fri,  2 Dec 2022 13:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670016508; x=1701552508;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wH8YCOLjy33ZSdHYht5jTJxZqjMCs4y9aTBejgfG5ds=;
  b=J5sPOxQNMtEkOQkAyU4+gOovBDWDy1DZ3sLbKhPRAYTigAnm/bup6/I4
   urNTm9ZdzbOmcmDW/xJInDrJubU3n5AP7YLkHWZag5Il09LlPFX9Pj70w
   I3BV50e1XxXaUHZ+8oFPvFKTZkzUYjJ4zuzeOE9HtFE+ULJ+PVWArhbGI
   kifF4k9iwPHTB/aGn8ifW/LbbVtZqbePjx3NHg04WTnm3GLmR6eLpKxZT
   u7kf4EvzVlTa1/o/AaR7sMlSXdY5nTuW+xlC47gbqDnuVwJvyDsMoJzdT
   waNtcf9hPblyusUpLecEy51LjPsHQ3/ESpOmRZ+V0fuE0tpK2W5sm8cYt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313685391"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313685391"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="733950081"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="733950081"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2022 13:28:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:28:27 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:28:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 13:28:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 13:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac93WcHYHCMa8ZSaiPILWFkgdrQ14wFhGWDzowfpDOBZgLxtHU9WFEVZQx+9LJ3pWrr71OlttUDwnsq/NgrW33bkgSXFc0kSKSInGe3+XL6JlQSntv6lc4qsTTb3/fkEAqwipYofU3Hk/hOn4BsRv1fkd3VqtmKHb7mBE+deCXz2UCXFGAGMAqAnWZiHTc/tyq9UGvj+F79qUp/tcxjQ2Y+i4K024QshbFR+v0zPrHk6+evbShBKJCD8IVZQe/1XxqtaG95w5Kq1RcvsjF8qaBw2tZTjGxjZX3dKiRkVy+j9pmeCoo/dA+IID5b/FaMhcgA2adI6/6EiYLQmXy2KUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB1Rw5j6bZ1HpP7tQttCsqdcAMJa8l41Z2MM07DtNFo=;
 b=N9aSLkvqFPW5/qGRlQtTRxBiDZaQVee8FGNF+m+f+YNIN71hAV6Kxcs0h+xT1AwRbeSoQnFIzTF1eCTWeRBThJOHN1ty534CN0ZigZMpq/1Xc9+eMLBv1WaR4HHNira42MQcnT8fin8qMhpKsTu4jx/LcG+RHlsarF1g41AZWsT3CrLJYYCotIOvp7GB83/15qtJEqDxgff0jrl395NLdVRB/n9qtsLWJWirPuVToAKHxPP8RZPIuYhPIuGAsoU5NdJFepY4qt/sy4ihnC3swY4uY8o77ha6M+9Iy+rfkuc0II4L7DPEIhek/vCDb/q49KNwZq3D2slbk/tmEbT2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 21:28:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 21:28:22 +0000
Date:   Fri, 2 Dec 2022 13:28:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <Y4pt87Lr2D5Hkycj@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-4-ira.weiny@intel.com>
 <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
 <20221202083448.4b3b3254@gandalf.local.home>
 <638a518b9c9b5_3cbe0294b5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <638a518b9c9b5_3cbe0294b5@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::47) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: bb684a37-6308-4f34-f6e5-08dad4ac23c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Smr8zaDi9zFZTy55rL6d5jB4HX61k1YKac4Sp2+uJAAYH0YogWS3LnaUtL8lHvYo4iaLq9cTOH9KpID/QRO4VQs8H2b+QwGCLCqh2tGVUohLHZ02ZOG0y85ko+ss4U41l0Updnhwn4hOx1mk4A5ALk8XXyT8Zc3wG8esx3YWYGxkOla/dBXFlbC4KwYrTqF/XwVQ4TAmVhVEEkSjN2k/0SPFiyb2V7I4NRFrkIbB8P79FPhFdkA733Ztbjo0AXWmD5RlrAXtRwGpQlQCn2qQhF+oFitc/jZCmf7WLxoluz3TcJ6jyFGFPcCTcdXRaem7wNq9pnk+f0guw86TUfaBJXiFK9ngR8Sw6AdRqP8Jxxg1yXVVkYXmagbs8nckBgSmEPjB/2BxFtlGRPFKyesehuWk54joxpxuEjPjGpQQ+0Gsi80Kt9jNUXl9Lu0mYXND6QryGQ1O4P/j/RVnoaiLim7d/I+ETsOQZk/rlQlWygfWW6MUPTAIGxE42JJVyomvg43pqYXjL5BCPEQDrcUHmcN/tfZAUrGqmzzh6aFGwpbxv265aT0pd+fLl1nNWWJvD9kvYD+G3WF9ql326BIDzEjVwlbYEX/lcNCbE/yicgzeKfdNW/3ycSGHeJWBhOJMMhkP47xpE5EO9y0Xsmr3SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(66946007)(33716001)(66556008)(44832011)(38100700002)(5660300002)(54906003)(6636002)(316002)(6512007)(9686003)(186003)(6506007)(41300700001)(6862004)(8936002)(6666004)(26005)(4326008)(66476007)(8676002)(82960400001)(6486002)(478600001)(66899015)(83380400001)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?azJOU7/uxdTAjWfXu9VNldhjiT9jkwv0Tm9ggGsNEHiBsRpJvTC2xHsnIdJU?=
 =?us-ascii?Q?4H7N+ZBQN+R1vkI1vjuGTCSKURLN3iykVTWkSnEl8GRYWVmQ2tjkYJg6StBT?=
 =?us-ascii?Q?+JNwvJKqPMPomSH6jt1WFrio+hATQot3ySvg3kV8HqnxJZ7I5mmacsUERpwB?=
 =?us-ascii?Q?R2gnqkwgDMavn/G+qgPjVuVKLB15Hf1QFa3ngz1czusiWgf5nzMXafswOcNy?=
 =?us-ascii?Q?euhrxZKX85WOZBqksHm9JoHBOAItSnFU+4VqyFhbDgwaeUtniz94+TSTLimS?=
 =?us-ascii?Q?2VR3vNdwCa+hpgRXo/OP7RGOp/Bj7evDx4kVjO3mwSHSDGpcSCOBgUwjW9Pd?=
 =?us-ascii?Q?slURisqsU4I2cEZOKjuaKDWXRCSSOCcUZFmYta/2BxPgj5Kyol7dfXKs9UjL?=
 =?us-ascii?Q?8C5A17DvCT7I67Rn0JQt2tyDdV0fRbPf2jPS2c+Fc5beknDpSwygSUMHFba6?=
 =?us-ascii?Q?RYchwynOEu/7e6pjdyeczgHLIElKgNZoHoGEVWGzUBdnb1Afpr5/9PXwPPgM?=
 =?us-ascii?Q?nZDT2xMYR5Dag8QPLC2gq1uOkbX/a8N5DGn40NYbfXhEni+Am2RrfZTgu3nL?=
 =?us-ascii?Q?SosYd8UPzWWxeSBjgpMF0oJgq61lekGzbnf6LgA8Kchcg66I82CLnNNW3NkS?=
 =?us-ascii?Q?U2/Zd5VH4q0SxC7xj5EpbfFbMMHlEjC0PFIbCoTbYvpnmOoWdMPeJcUAr73E?=
 =?us-ascii?Q?nXg3MzvNpHd79c8EglcBAh0mJT5xXLFsTT52Y+zItHf1CxZMttWwDtBuKTDr?=
 =?us-ascii?Q?yvbK7Dp6TM7oEeLKdoTbsB+8GyfbcsFv3Uact23FXUJmc/37Wi7l8QvM6bre?=
 =?us-ascii?Q?D27o5kn5/XLTe3wm5hjxo8SCRqenoPkwzUj+kBHYh1UK0PoRvXK3B4O4a2Lx?=
 =?us-ascii?Q?CbRd2QOjNI7DOa9JBVkM94b9p0OZJWlSvgnSK1z7Z3y9lhaY88QlvJpi2Nl6?=
 =?us-ascii?Q?dtm6tAqVhwVIPYkvUwxvFJFfihlymdt5BxJgHNZIZihd/x9KiCPBWhYs5NnE?=
 =?us-ascii?Q?dTx+G9SUBGWzbsfxcZsAf28hrEGxv51RXCAJJurka9LNalrwyjE/7dP0viPd?=
 =?us-ascii?Q?xzg+e7jD5U05QGmoIN4QGiD3OM1/CjKYZ3qSP+JNCpxXRyyM+5pK75ERaJm1?=
 =?us-ascii?Q?j9c582NA/d4iOvc6N4uFN07o5fOJbVsTPmhTi1fgUtg88TTFQMpn1wj3KqQz?=
 =?us-ascii?Q?rGtk9lZTZPRSKHTFSYPTNXdpL/MDOiHxmakP5LdgcNun59qTC1b/KRmRGUf0?=
 =?us-ascii?Q?pseUlU8ci1AwlouDKdLQ+zrZnGR8n5bZEaceRyA8AhRPFER1Uw398HKuO+bM?=
 =?us-ascii?Q?e/pvb7iszC551SfcI9S9QB9RFIZb4o261kkgffsLo9h3VYGfP58+QBNzgZC3?=
 =?us-ascii?Q?PoeHlTbNmTJ26ZUkxq9feK6jQv1lj2xc6wn4/6H4g8Ms2tVRBsrLkPKPiOxf?=
 =?us-ascii?Q?FvR1ryPN7iVtLGeC4R5e6Zl3OTsFDsU5M24CO7slZosrwgf3Gw2gACrFgnPW?=
 =?us-ascii?Q?xC9QCps54pAqmoZIUpp8iWgIsDsEP7Jl4UD2yaFD6+3nf48BH+NNcDIyAGYJ?=
 =?us-ascii?Q?WipHwzpZapuuVEILe1Fip+biz0xyhJ0QEjiTlYZ3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb684a37-6308-4f34-f6e5-08dad4ac23c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 21:28:22.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/MVrq2Unzk9fshhZsXjeFwDtc1TB0qxoD6/NQn/AVZRs8Vb5jxpzOTL7wknY2xBX5rhXLjdjKNaxyhAHyU/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 11:27:07AM -0800, Dan Williams wrote:
> Steven Rostedt wrote:
> > On Thu, 1 Dec 2022 18:29:20 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > >  static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > > >  				    enum cxl_event_log_type type)
> > > >  {
> > > > @@ -732,13 +769,22 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > > >  		}
> > > >  
> > > >  		nr_rec = le16_to_cpu(payload->record_count);
> > > > -		if (trace_cxl_generic_event_enabled()) {
> > > > +		if (nr_rec > 0) {
> > > >  			int i;
> > > >  
> > > > -			for (i = 0; i < nr_rec; i++)
> > > > -				trace_cxl_generic_event(dev_name(cxlds->dev),
> > > > -							type,
> > > > -							&payload->records[i]);
> > > > +			if (trace_cxl_generic_event_enabled()) {  
> > > 
> > > Again, trace_cxl_generic_event_enabled() injects some awkward
> > > formatting here to micro-optimize looping. Any performance benefit this
> > > code might offer is likely offset by the extra human effort to read it.
> > 
> > This is commonly used throughout the kernel, and highly suggested for use to
> > encapsulate any work being done only for tracing, when tracing is disabled.
> > It uses static_braches/jump_labels which makes the loop into a 'nop' when
> > tracing is off. That is, there is zero overhead for the for loop below (and
> > there's not even a branch to skip it!)
> > 
> > But sure, if you really don't care as it's not a fast path, then keep it
> > out. I like people to keep the habit of doing this, because otherwise it
> > tends to creep into the fast paths.

Thanks for chiming in here Steven.  I should have pushed back on this.

> 
> Duly noted. It makes a lot of sense when you are tracing in a fast path
> to skip any and all preamble code. In this case we are doing it after
> doing a whole series of uncached PCI mmio reads with all the stalling
> and serialization that implies. 
> 
> Speaking of which, this probably wants a cond_resched() after each loop
> iteration.
> 
> I'll note it is also a tracepoint that is likely to be enabled most of
> the time in production.

Ok I did not have any of these in there originally and I will remove them now.

Thanks!
Ira
