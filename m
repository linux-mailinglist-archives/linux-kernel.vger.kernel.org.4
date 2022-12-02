Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D9963FD24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiLBAe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLBAey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:34:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D571C60;
        Thu,  1 Dec 2022 16:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669941293; x=1701477293;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F/V23CMaRuPETr/74rjBgRTQ1XPGTQRtWtyxgDHg/Fc=;
  b=gQPnA3DILAgA8Fgmb3Durw47rHLrya16e9P9g8MYgw5g8qVz6PHp22Li
   YvuIL+fjC3XRnS0yfz5On9MCSv9ufiGdutiUDEx0rl7WikQ3fM+74cv/m
   GPRBqAl5JAou1a1y3gdWAAZtkmh0VsTbLn2zwwFSb25b7R5nAyDETkXOi
   zp4lvxQXblHi8IAaedvGdGvakdjxEkQx9vosbeQ58GCZr2xtwiPwFDKXq
   ryZdFmX+2h90u28ng5W3bp0WQrsk4FpjAlP658QMT1hhyW+Qr1oYjikxC
   FtB4dqZgLSafI/L4WahiQ0GeVnX7L1t6J843U0M/zW53mhleIYd39vzu7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="377993526"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="377993526"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 16:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="889945987"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="889945987"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2022 16:34:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 16:34:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 16:34:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 16:34:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 16:34:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK0lb3/VFEZMyO9kz2luU6Go/ulgxqxVQZcWr4FJYS9W3J8YOjBZX9OXYRC+APek5gqshfpp6ccCcU2YDtlSnbPZjCIANpSBz2LTpddVLXVg1wJl6t5BT6sB7teaTISLU3l+1BMXEcY4YbgiEur2IJ1bSR0Q/2/Qtu3PgfZhxbVNAWj6KKJv6oraQDQ9RxjEPGej9t9rJGPqXtQxNYmumzB4u5A70i6P0M/jnIWNY7N6H89P3RC77nrblUcM6t00iDVk88T2CPwQuCPM0/rzldTYOIPsIuT4xInkxzPhXBh+Atr6wDpuJJP3eO+z4Md3F0xpEQxFOJ5CK1SaRzJ+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu/1BcfURshQbDDRrl4PPerP6yAcmCCgjoqO1OHuSI0=;
 b=CA35elFbMV2VzaSgAB9XxnHFWA+NqSRtqmE/fKH7QXMdqUxyX8wijmMs/gI1ZePOipGAdHBl86WPNPJ5eUOqgF1g7eq2gjqJCVFziAO924+r5b/tq8h0kENC4/BOfwd6lMn3T3F5A/vT3tz0iPwD7uuRHhEqiKr/yWnxpNWiRsEtNACIQ0vK0tQw5zIPhSIR7cY4fCJ/MToyB0GM2rzAfBgH+T0O9lAcV7wXaz5FO1DV4R1I9hapRvb7GxQNUqUbXVdYxl+sAi7ZciPPtKo24ygdusIXwgwXmK+HliD7bABMxPnicN1Jj/TNmjeymn/l9WNlF5Bdh7F3mfeGqljQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 00:34:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 00:34:32 +0000
Date:   Thu, 1 Dec 2022 16:34:27 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <Y4lIE7Fyctj6GagE@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-2-ira.weiny@intel.com>
 <63894579bf550_3cbe029458@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63894579bf550_3cbe029458@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb19f82-b759-489d-1aae-08dad3fcfae4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b09mdPN2Pjsv3/0KKFBSkdY3FELoyD8SabnCXZLDgBHk7ZAuYK5BuaGwP/yvoP1C+sh84cqKExyrdfKBMfnilSGcmzU1nHliBxLPAiOc4SDsrjT88yTNj0L1XwLmORmfrJdh/CgeXaOAVc7rhgt/T8p75JU8GYG4cgcLDBEift47cqHHKY7fOrZ7zvn0AWmsHJGOh5mXVs7pc7HRp5kHm79t6UlyU0ACtzJTH1iYXG/BysRsMI+/rLLAyFxzVUujvbzH46vn8+Gk5C4+GFS+8NIhAjSntcu6KLi1t7BDI2MAvsTcCbdTDZKoiirhXUdSWH5BEsUSuSEEOlO3VWCUFCaYrhcMHieJ7RqWFnvyrqqXBQQOjZr6MvDA7WAMp3v6r1E82iwY/RKre1OlhX8g8I1IGxAKdKWsdeQ4wIju8ebHBeoaximYqNhWb02QQ0yEivGPtf5r8aCQ+EhbZmIbqNqZ/aSFZGvw/eqaTKD/JtN46PkC89fvK34LvQPkCqIioQY/EvvMTlDqp3k5RHHRxzTQMiFhYW2LicGXHZt1e1OYgeiQjih8iPlvgIGXyiKT6p1pn5kGdX8K41UvfS/TuYSTh1eK4hL8g3vhJeHFLbRWFN9pcKxqDjyyUIpNaECUt/4S6ut5Xis7SXNqB/lbxBqeCWEJ2mKo1L2mngvfG8GpZJ+LGNyOp/+5yEEUdX7j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(44832011)(66899015)(41300700001)(6506007)(6862004)(66476007)(8676002)(4326008)(2906002)(86362001)(5660300002)(66946007)(6636002)(316002)(478600001)(8936002)(82960400001)(54906003)(6486002)(66556008)(38100700002)(33716001)(83380400001)(6666004)(9686003)(26005)(186003)(6512007)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vHC16S+gpcNh1iYV8Ywrk9ZxAk1izHrkRDmJVl40GMdrC3Cb2GeMLQJy77yb?=
 =?us-ascii?Q?+JG/eM/bWo82LtEGMPEdHSd1ZTIRlK2h0mktz6h946O9mEBmJspuNQ4zKIcK?=
 =?us-ascii?Q?YqfG6hEJEyuyQehAQwAAOgGNL4GYP+7tLnq+3pKrHNZo/o6NZZy7bRe59ufQ?=
 =?us-ascii?Q?22LfHZQqoKpcAwsICKOnDJ4lGL7MRVWrs5JewkYRBtbWlYscZNBlQu89JgR8?=
 =?us-ascii?Q?wH1fNoquQ/Ux9qcAU6w0oGy6Oy5wZ+VpNzIOV66hduXzlqq6Bd7ogK3x3moK?=
 =?us-ascii?Q?h1fYmkQDNUbWWYUbKXSbEjnfUqile2Mj79FGcpWaITeIJqNQ8xwSgAn99vQI?=
 =?us-ascii?Q?QC2O/Q9vlJJtpnIuvOqyLfJcnBXduooMFPQP/Jy53rnmzgXzl4wbyambmdYR?=
 =?us-ascii?Q?VspCRe4VRw+8+SXbOIvrPLcT6wGXFPFkXJZhWyoLRu2tvICxMfRmSbBXY8LH?=
 =?us-ascii?Q?e6J5CQ13O5iqF0+x0ljALXjcUgToIpoAUK8pPz05UpKAbkcR7NHnTQKB7vmG?=
 =?us-ascii?Q?1NFXoVgcPs7bqvRG4MzDwlm5XbfWqDs4omSR/XkmCt8PzQyEAq4Mk8FVY270?=
 =?us-ascii?Q?w5ZcAA44RzcswWaf+4pRh//vDjT0UFPfQxXXu6ij6+9EwsKR/a3HVxkQvEXV?=
 =?us-ascii?Q?yp2RRiIVsl1I950x/DQznrhVQeysJqaoJlphWG+8VLUm/WVxxufzN6JLKN5z?=
 =?us-ascii?Q?aES630aj4DeVayUd0hBzP3xag+/2lmGmrgTItLPpjyAvDWmeI8ewAzjqnDkE?=
 =?us-ascii?Q?ExbNW0M+HhpjqFuE+/LnuveHL56sMM/KzD/0p+/IiWAXo/0q0oSinU6NdclJ?=
 =?us-ascii?Q?sDWZOyeaIWvUt/Z12wSoZo7TTFkwZQrTwq2l3liZKI6FDwfM7ExmQgY4r+A3?=
 =?us-ascii?Q?/BEaDUx6VQnw2KEZnkw4Q7n49OXK9NbXE7lHRlo05RFyT1lLnNSYQ7EZizx+?=
 =?us-ascii?Q?zUMUXGkzU8AY93kSNCu/LWolkW5t1iXndjDii0czeu1k2X3yY+sLrenBaqkH?=
 =?us-ascii?Q?rq6Ss6HyyOp4Fl6q4OAQkjKTAooLxdkceaUtudHdZDMRnwzv3vPJAlagmi0E?=
 =?us-ascii?Q?Gaoa55bKn3PzgjQ+vJsUJzxkicBnmuTxe2GvATa+JuzJgiVNqP1kEubBgl9o?=
 =?us-ascii?Q?MfmTPol9SThGv1TL4axI7TrRCHMAhoktjX1ahSN9iUZaCJIHqq667lzClyki?=
 =?us-ascii?Q?lSR1M6FbR1ztIJPb2/tTIyN2hqvUs4FXfx/ZYfV+Uok0EbJ+GeY872ARp24H?=
 =?us-ascii?Q?FWQi0E1I295zaW50HXY+FKNUPFn9e8A0AcRBvgrQtsTT9J+mzV5Y8UaCmeeT?=
 =?us-ascii?Q?9twX31AcZisxbj8OmOarMJAeWAckL4c6mNB38BGGTxGZK4DueJ947dwCdZJM?=
 =?us-ascii?Q?vwh3mnrmlsNvp08WruT/BxoH1Z+vSnlrj7Ipg4zJB0T0ZxGc5F5azKWP42m2?=
 =?us-ascii?Q?ngMZ+yeMXM0kZ6npYXN9J7i0WoI0UqkHt5lGl1FjlDWmxqTJO4POphFzIQAa?=
 =?us-ascii?Q?3XIVXtliL6HNcp1JNFfEPxmlMFJZysGsu4eaBjF6V12UMeiptDO93XKJnxOR?=
 =?us-ascii?Q?53Y6HU6Q8P1CfefCZgY8JB/wIRAqqMnl2DAYdS/0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb19f82-b759-489d-1aae-08dad3fcfae4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 00:34:32.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaSrZb9BDEQ02SGickDhhdM5BptMHcQKk8ib8Rr44JbHlUl2eoz+I0cQEZ6eWu21PCbNb3kXp3IUS4XBl7IVOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 04:23:21PM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > Currently the only CXL features targeted for irq support require their
> > message numbers to be within the first 16 entries.  The device may
> > however support less than 16 entries depending on the support it
> > provides.
> > 
> > Attempt to allocate these 16 irq vectors.  If the device supports less
> > then the PCI infrastructure will allocate that number.
> 
> What happens if the device supports 16, but irq-core allocates less? I
> believe the answer is with the first user, but this patch does not
> include a user.
> 
> > Store the number of vectors actually allocated in the device state for
> > later use by individual functions.
> 
> The patch does not do that.

Sorry missed updating this message.

> 
> I know this patch has gone through a lot of discussion, but this
> mismatch shows it should really be squashed with the first user because
> it does not stand on its own anymore.

It is separate because it was Davidlohr's to begin with.

I'll squash it back.

> 
> > Upon successful allocation, users can plug in their respective isr at
> > any point thereafter, for example, if the irq setup is not done in the
> > PCI driver, such as the case of the CXL-PMU.
> > 
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > ---
> > Changes from V1:
> > 	Jonathan
> > 		pci_alloc_irq_vectors() cleans up the vectors automatically
> > 		use msi_enabled rather than nr_irq_vecs
> > 
> > Changes from Ira
> > 	Remove reviews
> > 	Allocate up to a static 16 vectors.
> > 	Change cover letter
> > ---
> >  drivers/cxl/cxlmem.h |  3 +++
> >  drivers/cxl/cxlpci.h |  6 ++++++
> >  drivers/cxl/pci.c    | 23 +++++++++++++++++++++++
> >  3 files changed, 32 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 88e3a8e54b6a..cd35f43fedd4 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> >   * @info: Cached DVSEC information about the device.
> >   * @serial: PCIe Device Serial Number
> >   * @doe_mbs: PCI DOE mailbox array
> > + * @msi_enabled: MSI-X/MSI has been enabled
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   *
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> >  
> >  	struct xarray doe_mbs;
> >  
> > +	bool msi_enabled;
> > +
> 
> This goes unused in this patch and it also duplicates what the core
> offers with pdev->{msi,msix}_enabled.

I tried to argue that with Jonathan and lost.  What I had in V1 was to store
the number actually allocated.  Then if a function reports something higher
later it can't be used.

I admit that at this point I really don't understand PCI interrupts at all.
Every time this patch is discussed I get (what is to me) confusing information.
And I've been unable to discern from the spec how exactly this is all supposed
to work.

> 
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> >  
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index eec597dbe763..b7f4e2f417d3 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -53,6 +53,12 @@
> >  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> >  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> >  
> > +/*
> > + * NOTE: Currently all the functions which are enabled for CXL require their
> > + * vectors to be in the first 16.  Use this as the max.
> > + */
> > +#define CXL_PCI_REQUIRED_VECTORS 16
> > +
> >  /* Register Block Identifier (RBI) */
> >  enum cxl_regloc_type {
> >  	CXL_REGLOC_RBI_EMPTY = 0,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index faeb5d9d7a7a..8f86f85d89c7 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -428,6 +428,27 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> >  	}
> >  }
> >  
> > +static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int nvecs;
> > +
> > +	/*
> > +	 * NOTE: pci_alloc_irq_vectors() handles calling pci_free_irq_vectors()
> > +	 * automatically despite not being called pcim_*.  See
> > +	 * pci_setup_msi_context().
> > +	 */
> > +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
> > +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> 
> clang-format would scooch that second line in for you.
> 
> Might also be worth a comment for the next person that goes looking for
> why this isn't PCI_IRQ_ALL_TYPES.
> 
> From CXL 3.0 3.1.1 CXL.io Endpoint:
> A Function on a CXL device must not generate INTx messages if that
> Function participates in CXL.cache protocol or CXL.mem protocols.

Seems reasonable.

Ira

> 
> 
> > +	if (nvecs < 0) {
> > +		dev_dbg(dev, "Failed to alloc irq vectors; use polling instead.\n");
> > +		return;
> > +	}
> > +
> > +	cxlds->msi_enabled = true;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -494,6 +515,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	cxl_pci_alloc_irq_vectors(cxlds);
> > +
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> > -- 
> > 2.37.2
> > 
> 
> 
