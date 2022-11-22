Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F5163401A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiKVPYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiKVPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:24:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB93520F42;
        Tue, 22 Nov 2022 07:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669130652; x=1700666652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMOdI3P7VdfIy2nfD0+wdUsYo7XnmOvFsyP8v8HsR3g=;
  b=IODGBlFEXnxIhF+/GPzCoB/MwSfEt5Bt+qRJrcxRMG6ydNVpAPhBXrv7
   19QiuU++fFlefpkCoFFnfpsG03eA2NAL80SGY2IvR7mNoMHtRsj3nAcMy
   LbRBIRko6Mg+4rgKW0JMjubwls3zEPjwHC5dmE7IZShVa3WYMOgHFfZsu
   GYXkhendRYc+NxuaDf4arlon6U8sYOBfhJeLebnMLDn/R+6SufoLLN/Eh
   7vQB4R9FjODYw5UaYD+Rwl/Dk5ugcH5AOUAljfLhVOnRy+Wd46uc0Pk6L
   QErhHOuAxd6ZUcuidBLJ5wZMQFvc/A/fhJ7m9Klfc1zXmYVaIw+0b6b6o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301389399"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="301389399"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="705004007"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="705004007"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2022 07:23:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxV7h-00FsxN-2Q;
        Tue, 22 Nov 2022 17:23:45 +0200
Date:   Tue, 22 Nov 2022 17:23:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/4] i915: Move list_count() to list.h for broader use
Message-ID: <Y3zpgRd89Dz/LTPk@smile.fi.intel.com>
References: <20221114162207.62559-1-andriy.shevchenko@linux.intel.com>
 <87leoc2pbf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leoc2pbf.fsf@intel.com>
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

On Tue, Nov 15, 2022 at 05:46:28PM +0200, Jani Nikula wrote:
> On Mon, 14 Nov 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > Some of the existing users, and definitely will be new ones, want to
> > count existing nodes in the list. Provide a generic API for that by
> > moving code from i915 to list.h.
> 
> I think I'd find list_length() a much more natural name for this.

i915 suggests my variant :-)

> *shrug*
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> regardless of what you decide to do with name or static inline etc.

Thanks! I will check which one looks and feels better and update for v3.

-- 
With Best Regards,
Andy Shevchenko


