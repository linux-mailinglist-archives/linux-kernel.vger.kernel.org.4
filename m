Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97DC65D086
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjADKUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjADKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:20:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C97193FA;
        Wed,  4 Jan 2023 02:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672827612; x=1704363612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NPxQWNdyTdWqkzxmEAyoSSF71GDzFceR3vK9LEhdjnM=;
  b=MthnFznTiRTzQ3v8xqp/RJdfQ43alquLjWC8DqbAOmet/rw9oOqf6uKN
   J0QyGNgNQF39K8/DiSgj1JOJzJykVfo4WIUgJCL8xL5t8/ExIxKbTHev9
   exthv+HbIghs3t0gv6Q7bK++HmQjSAMnKjLM56HSgKDwJCdrNUQz+C5CW
   E1nRYQOQ6qy9bOvpyazZe8WLu7UTOI7I5djYMH75CwBxZjfJgnhFSR3jc
   unv0/4TqCq/t4ezM+01oIjBpSPJSYKh/DzddNmlV9kcRZHH5dODe4uuek
   2YbmcAbX6/UaFciMGoBJiavWX4fdZQD+SZhlwP2VcFBfqh+blmmRLXZqn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="349124524"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="349124524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 02:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797481111"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797481111"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 02:20:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pD0sT-004G40-0m;
        Wed, 04 Jan 2023 12:20:09 +0200
Date:   Wed, 4 Jan 2023 12:20:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: i2c: st-vgxy61: Use asm intead of
 asm-generic
Message-ID: <Y7VS2LuKGVQkcyrU@smile.fi.intel.com>
References: <20230103145219.40226-1-andriy.shevchenko@linux.intel.com>
 <b2ad42cb-fe09-73f5-8d7d-ac4f22817bac@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ad42cb-fe09-73f5-8d7d-ac4f22817bac@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 10:27:14AM +0100, Benjamin Mugnier wrote:
> On 1/3/23 15:52, Andy Shevchenko wrote:

...

> > -#include <asm-generic/unaligned.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> > @@ -15,6 +14,9 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/units.h>
> > +
> > +#include <asm/unaligned.h>

> Any particular reason not to keep the alphabetical sort ?

It's kept in an order in each of the groups of headers.

The main rule here is to go from most generic headers to the particular ones.
asm/* are definitely more particular than linux/* ones.

> >  #include <media/mipi-csi2.h>
> >  #include <media/v4l2-async.h>
> >  #include <media/v4l2-ctrls.h>

-- 
With Best Regards,
Andy Shevchenko


