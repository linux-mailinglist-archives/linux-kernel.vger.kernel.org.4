Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1669A609D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJXJA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJXJAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:00:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428139B97
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666602021; x=1698138021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TM0l/s+rG+hN32SDo2o0Gc0+BtXVKCquC3rTP//FhsE=;
  b=mfy9/Ux8EvhS/hwDcV9eVZ0+ZOP2wZbl4eyXGCm9XYaYW/SZCM5aacJT
   IMa2Z2ZoM2zQsRIYJ8IxH9sn7pwynZ0sRJsCTz/oiJiPxowt7bX3Apdsn
   RejuKMEvP/3xJpWLuYGFtl1geqbOmKVnbqK9ESwi6SYm7Zv6VnfJSQhrz
   sqndu0gYcpLqNlYSh9sos9rLbEBqs2o2WT6ghkCuLNoTOmtNr/yj8jNyl
   1NVP05wc30QvJsZHjJ9kIeAtEDDj0C3ClPxBlGlyAxbXYtdy513TT3Eot
   hWIFJJtQAASTEvNlHHz0zPkCPwtOkUZ2mcp+BSRMf2kTuzIUERHyIpBsD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="290672840"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="290672840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="736338740"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="736338740"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2022 02:00:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omtJg-001MKr-10;
        Mon, 24 Oct 2022 12:00:16 +0300
Date:   Mon, 24 Oct 2022 12:00:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1ZUIEYcjQZMdSfp@smile.fi.intel.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZQpcdK4sdy+5QZ@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Kees

On Mon, Oct 24, 2022 at 10:45:25AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 24, 2022 at 11:26:10AM +0300, Sakari Ailus wrote:
> > > container_of() casts the original type to another which leads to the loss
> > > of the const qualifier if it is not specified in the caller-provided type.
> > > This easily leads to container_of() returning a non-const pointer to a
> > > const struct which the C compiler does not warn about.

...

> > >   * @type:	the type of the container struct this is embedded in.
> > >   * @member:	the name of the member within the struct.
> > >   *
> > > + * WARNING: as container_of() casts the given struct to another, also the
> 
> Wrong function name here.
> 
> > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > + * @type. This is not a problem if the containing object is not const. Use with
> > > + * care.
> > 
> > Same comments here.
> 
> Wait, no one uses this macro, so why not just remove it entirely?

Kees, do you know why and what for we have container_of_safe()?

-- 
With Best Regards,
Andy Shevchenko


