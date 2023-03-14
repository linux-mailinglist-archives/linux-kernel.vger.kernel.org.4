Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5C96B86D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCNAVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCNAVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:21:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95E8F50C;
        Mon, 13 Mar 2023 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678753282; x=1710289282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nqIJ06djTPFbgwgF2ddzmVu+X9eX2DTyRRWcHDMiYhc=;
  b=FoCuP0/c2GB3uvIm5q3gX7O71qRigg62vMtVt+snQwL/FgS2pLX0Yi0W
   OlidSRlwqljj7A+BJhB2yRaynP2eFBTvfbCyBtyNKq1+zGNywf68fDdEF
   kugVI7R2Orf94o2SUSmkv0lq1ROxBlwlKAPBmyGm7s0olpbAOPTW9SFFx
   nSRAC0d3MBUvzENvzb3tXbD0tNz9eraL9XSIuJJUvCq3WV10KkyonSxSV
   JLmK9v2UJu4/pF1siertENEheAhx4LacEg4XpqDaP0VbrJx0rGxh8tHKy
   sGO4wki4csoxDJPlV/tZ/pfe41V/d6DK43okb5SbH9Vr+8I8QSsulc/TC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="364954389"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="364954389"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 17:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="678895605"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="678895605"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.44.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 17:21:21 -0700
Date:   Mon, 13 Mar 2023 17:21:19 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 2/6] cxl/trace: Add TRACE support for CXL media-error
 records
Message-ID: <ZA+9/x5t4tdDWe/L@aschofie-mobl2>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <a77d5513c55177361749a27544409cb6a0c94dd5.1678468593.git.alison.schofield@intel.com>
 <640fa806f2321_22c07f2944f@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640fa806f2321_22c07f2944f@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:47:35PM -0700, Ira Weiny wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices may support the retrieval of a device poison list.
> > Add a new trace event that the CXL subsystem may use to log
> > the media-error records returned in the poison list.
> > 
> > Log each media-error record as a trace event of type 'cxl_poison'.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/cxl/core/mbox.c  |  4 +-
> >  drivers/cxl/core/trace.h | 84 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 87 insertions(+), 1 deletion(-)

snip

> > 
> > +#define cxl_poison_overflow(flags, time)				\
> > +	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
> > +
> > +TRACE_EVENT(cxl_poison,
> > +
> > +	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
> > +		 const struct cxl_poison_record *record,
> > +		 u8 flags, __le64 overflow_t),
> 
> FWIW I made event overflow a separate trace event.
> 
> Will this make all of the poisons in a single GetPoison command marked
> with overflow in the trace buffer?

Yes. Every record returned within a poison payload, gets the same flags and
overflow_t reported in its trace events. 

I took a peek at what you did.  (Perhaps we should have called that
cxl_event_overflow). I don't think the poison reporting allows a
similar, singular overflow trace event. The overflow setting means
the device has overflowed its poison list and the list may be
incomplete. I think we repeat the overflow state on every cxl_poison
trace event until the overflow status goes away. (Scan Media)

Alison


> 
> Ira
> 
> > +
snip

> 
> 
