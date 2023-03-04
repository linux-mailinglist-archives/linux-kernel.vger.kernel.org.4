Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080776AA830
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 06:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCDF32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 00:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDF30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 00:29:26 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC111167D;
        Fri,  3 Mar 2023 21:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677907765; x=1709443765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVPfBCoIjCLkTg7DpcxOzEwQE9D9xZe5MJ7Ol99QRBE=;
  b=CDmdbCzrn1CLAFLQSkcJ77M0dq0Ify2avO6PVNOfhviiwD4XKccuo1YW
   qK4xdAjPYs4Z+NEe7xphI70yibXQmorT3YLALXojhPIcS+j7GOfs8K32Q
   9PkLKUaDH/YD5N0RdA1ZtJxhM8Dkyv1xp6nVQM5IlyZx5vIYMMLb/UoeM
   IG4RgEj5bY3MzqeejZBIfdH0mNBDhxvquSr5PlUShxuXt5KLpmHUP1Lp5
   bdljoxeX/aLtmIQMARrCof/HQun9rzHaPCT2S5X8LH8qJU9vRThGyEJ/X
   rJEAI0HfPtrA+MPqwZlZNQ2VwFpx6e43PWnE5jo6twrtxtYYWkPkjvEjl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="397813470"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="397813470"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 21:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="799442092"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="799442092"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.155.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 21:29:24 -0800
Date:   Fri, 3 Mar 2023 21:29:22 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <ZALXMliQOjG5pjrj@aschofie-mobl2>
References: <cover.1676685180.git.alison.schofield@intel.com>
 <cba540061d48defc0008638bef0cc42cb1f6762e.1676685180.git.alison.schofield@intel.com>
 <20230303154245.00007b4b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303154245.00007b4b@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 03:42:45PM +0000, Jonathan Cameron wrote:
> On Fri, 17 Feb 2023 18:18:51 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a boolean 'true' is written to this attribute the memdev driver
> > retrieves the poison list from the device. The list consists of
> > addresses that are poisoned, or would result in poison if accessed,
> > and the source of the poison. This attribute is only visible for
> > devices supporting the capability. The retrieved errors are logged
> > as kernel trace events with the label 'cxl_poison'.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Hi Alison,
> 
> The dates and version in the docs need an update. Otherwise
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks Jonathan!

Fingers crossed for the March 2023 date!

> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++
> >  drivers/cxl/core/memdev.c               | 56 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h                    |  2 +-
> >  3 files changed, 71 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 3acf2f17a73f..d9421c965a3b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -415,3 +415,17 @@ Description:
> >  		1), and checks that the hardware accepts the commit request.
> >  		Reading this value indicates whether the region is committed or
> >  		not.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> > +Date:		November, 2022
> > +KernelVersion:	v6.2
> 
> Needs an update.
> 
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
