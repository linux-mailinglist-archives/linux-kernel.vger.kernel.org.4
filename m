Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26F5F984E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiJJGXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiJJGXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:23:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE9151A2D;
        Sun,  9 Oct 2022 23:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665383018; x=1696919018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9JYb5cHyGp+9KJ6PeduxCp/1k+kpG2Pd37pUyCuJev4=;
  b=NG/76/+V9XTWCMXKrOS4+HwtMygPbVjcZwisbk6a/3hc38lN6M/7MNKK
   fyMcGcpXqBuxhVSS28ABMOcxu77lccSEk1BpFqa3+CNtdyLYXVzA3CFmI
   aB17BzUpdy80U8YTkJEBAj79M3p6GfvNpxgli7YPi/fuMgupEeb4LjQ63
   CUnQJNLtTmyD3XGvjN6ETD7vl4trSlEfkytkktFTqIE32eM3WVwANS3wm
   RK/ohATqDH0AP3zdlLSKb4j6im6f/wC3ZIH24C8HOhNOGogCOEwbhxwHU
   7O0ClWXWa53yV/8e6e0FKPsoibNFOXXbOyUWvxDuazRZJuPlM0CbAh/yi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="291439346"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291439346"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 23:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="659043114"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="659043114"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 09 Oct 2022 23:23:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohmCL-004kNx-2m;
        Mon, 10 Oct 2022 09:23:33 +0300
Date:   Mon, 10 Oct 2022 09:23:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Soha Jin <soha@lohu.info>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Case-insensitive match_string and
 fwnode_is_compatible()
Message-ID: <Y0O6ZZe6RqlibDxB@smile.fi.intel.com>
References: <20221009162155.1318-1-soha@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009162155.1318-1-soha@lohu.info>
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

On Mon, Oct 10, 2022 at 12:21:52AM +0800, Soha Jin wrote:
> I am introducing these patches for the patch for ethernet driver which I
> will send later.
> 
> In Patch 1, I abstract `match_string` to `__match_string` with a comparison
> function, make the original name calling it with `strcmp` and add
> `match_string_nocase` calling it with `strcasecmp`.
> 
> In Patch 2 & 3, I implement `{device,fwnode}_property_match_string_nocase`
> and `fwnode_is_compatible` for compatible property matching.

Let's ask Rob about usage of case-insensitive comparator for compatible
strings.

So, why do we have such in the OF code and do we really need it in the modern
world?

-- 
With Best Regards,
Andy Shevchenko


