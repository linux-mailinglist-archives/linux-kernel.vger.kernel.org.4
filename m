Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29215EFB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiI2RF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbiI2RFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:05:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585A211E0CA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664471153; x=1696007153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A/dAfP21QTi8Sig6o9uQZ3ANU7FzAp+/LZ0SsDa/BVM=;
  b=JIKzRgngPjwGyzA5L8q/w+7JE++onAX66eUf1czLeDeefIdmvO7DVQfN
   biI8XNh0io5daCbGJxvW8b3wUubVzLVJW92gdE1kkCtiK1oaiX/BgETon
   ShAZC5qnGWzPOpdZBjKgPVn1/LeZ9+/OCNV/C6so+Xmh4Kw0RITAPVZ6A
   aY3jo7G75CxvnvzgeS5rf5qjuGv7wHjYHN/kSKoHnaTS+EvbHjsouhH1c
   M5PRER3mRNGg9ki1kk1K+Vk+H5FTTo/xy8Jw1OMLegtYrgdtRwoyaqi0O
   ONoCGr1QKD3YPDJfiF8TyPycGoaY+0kSnXrY3Dy7iYas9y4RhWwiJJqAG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="302879008"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="302879008"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 10:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="617681072"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="617681072"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 29 Sep 2022 10:04:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odwxB-000474-0F;
        Thu, 29 Sep 2022 20:04:05 +0300
Date:   Thu, 29 Sep 2022 20:04:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] test_printf: Refactor fwnode_pointer() to make it
 more readable
Message-ID: <YzXQBA5b71OohRar@smile.fi.intel.com>
References: <20220824170542.18263-1-andriy.shevchenko@linux.intel.com>
 <20220929120632.2bc01e9f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929120632.2bc01e9f@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:06:32PM -0400, Steven Rostedt wrote:
> On Wed, 24 Aug 2022 20:05:42 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

Thank you for review, my answers below.

...

> > +	const struct software_node first = { .name = "first" };
> > +	const struct software_node second = { .name = "second", .parent = &first };
> > +	const struct software_node third = { .name = "third", .parent = &second };
> 
> I personally do not find the above more readable, but honestly, I'm not
> attached to this code at all.
> 
> > +	const struct software_node *group[] = { &first, &second, &third, NULL };
> 
> Could this just be:
> 
> 	const struct software_node *group[] = {
> 		&softnodes[0], &softnodes[1], &softnodes[2], NULL };

It could, but the issue is that it will loose the self-explanatory naming
scheme. It's much easier to see what we test and what we expect in the below
calls...

> >  	const char * const full_name_second = "first/second";
> > +	const char * const full_name_third = "first/second/third";
> >  	const char * const second_name = "second";
> >  	const char * const third_name = "third";
> >  	int rval;
> >  
> > -	rval = software_node_register_nodes(softnodes);
> > +	rval = software_node_register_node_group(group);
> >  	if (rval) {
> >  		pr_warn("cannot register softnodes; rval %d\n", rval);
> >  		return;
> >  	}
> >  
> > -	test(full_name_second, "%pfw", software_node_fwnode(&softnodes[1]));
> > -	test(full_name, "%pfw", software_node_fwnode(&softnodes[2]));
> > -	test(full_name, "%pfwf", software_node_fwnode(&softnodes[2]));
> > -	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
> > -	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
> > +	test(full_name_second, "%pfw", software_node_fwnode(&second));
> > +	test(full_name_third, "%pfw", software_node_fwnode(&third));
> > +	test(full_name_third, "%pfwf", software_node_fwnode(&third));
> > +	test(second_name, "%pfwP", software_node_fwnode(&second));
> > +	test(third_name, "%pfwP", software_node_fwnode(&third));

...here.

> Then the above doesn't need to change.

And that's why I want to change them.

> But again, I'm not maintaining this code, so I'm not attached. Just adding
> my $0.02 to this (as I'm triaging my inbox and found this email).

> > -	software_node_unregister_nodes(softnodes);
> > +	software_node_unregister_node_group(group);
> >  }
> >  
> >  static void __init fourcc_pointer(void)

-- 
With Best Regards,
Andy Shevchenko


