Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF09962888E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiKNSsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiKNSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:48:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67619035;
        Mon, 14 Nov 2022 10:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668451697; x=1699987697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AHgkLYtPHhgu7JKiPxVsv3AUt6xSMXEpy9zlW59ER+8=;
  b=Hd/WpQA5Z/A2jtLwU1dRfNnaK1l7rekliILwLMGrDlFt1KkSBpFZzMHz
   1/iWOYyRrdi6OZiyyH0A81fdvkcMceTl91hjID/OIAVvRQoX1rWbpErDY
   zhuWfhL/12gZXtS/K2uhKy5IjTDVQ2vaYgrbaqDOCi5WA1ggDoAlhESRz
   AxBsCfod3SoAiPjqbfz7EqNcR2/e1C85ohMXjZ7xnwZM8uXrhduBYhNlL
   Z1de2EQZXF/442LTau/yv8OFEiTBMI13GkyCpaLsYElYYedLXfO1TOx5K
   dTzMtPkda2O1WoG3SEde5dk3rISjCClhjBfvgc6GrrXaCTGCQ1dDIzSBo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313197923"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313197923"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="813369368"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="813369368"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2022 10:48:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oueV7-00CJ1A-27;
        Mon, 14 Nov 2022 20:48:09 +0200
Date:   Mon, 14 Nov 2022 20:48:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        "Nyman, Mathias" <mathias.nyman@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/4] i915: Move list_count() to list.h for broader use
Message-ID: <Y3KNaZjhqJZYjxrn@smile.fi.intel.com>
References: <20221114162207.62559-1-andriy.shevchenko@linux.intel.com>
 <DM5PR11MB1324523623D88188493D7518C1059@DM5PR11MB1324.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1324523623D88188493D7518C1059@DM5PR11MB1324.namprd11.prod.outlook.com>
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

On Mon, Nov 14, 2022 at 06:11:51PM +0000, Ruhl, Michael J wrote:

...

> So all of the non-list_for_each code appears to be an inline.

This is not true.

> This which, resembles the non-list_for_each pattern is a macro?
> 
> Just curious as to why the macro rather than inline?

See above. However, I'm fine with the inline.

-- 
With Best Regards,
Andy Shevchenko


