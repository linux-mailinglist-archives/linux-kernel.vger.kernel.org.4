Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EF063407B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiKVPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiKVPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:43:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145C2C653;
        Tue, 22 Nov 2022 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669131811; x=1700667811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=upTqDhnYPbQQtcnEG3sH1opy5XLziUPK5oFbYqhMYmU=;
  b=ZytxulGXf+HT9nbIy4zeIQLwvfUgMldnG9pkXVffsd+MScvgv2aXP0P8
   ELA0+XAO3ttYQLULfmSiosxX3lcoLPgeceltz+FXz/XV2cpemJY3utPuP
   ze0HsxLEX+rBZFqrOB95jrhn7/F0EPPn/1rwaK14kT6QqtwuFx+mt+Cqi
   r0iF5lysVzZxdVVi9wPpybPJx2/lLVDTFxu3uZgBY/vI+zMh6oUFzXofX
   MMDOSwleqkLC1FR54fdf6CTkbFGPsLgH3qO7TxP+AUE5QwlGvbEaHOQ40
   n2RO+MVRPxcdQuwjqKXh0nXDI1Xbtt8upwAgqMUVL1KHZ5V7oZ3jqQ3fy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315664620"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="315664620"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="643762489"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="643762489"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 22 Nov 2022 07:43:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxVQh-00FtHg-2h;
        Tue, 22 Nov 2022 17:43:23 +0200
Date:   Tue, 22 Nov 2022 17:43:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 1/4] i915: Move list_count() to list.h for broader use
Message-ID: <Y3zuG9bRePqCzbxz@smile.fi.intel.com>
References: <20221122153516.52577-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122153516.52577-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 05:35:13PM +0200, Andy Shevchenko wrote:
> Some of the existing users, and definitely will be new ones, want to
> count existing nodes in the list. Provide a generic API for that by
> moving code from i915 to list.h.

Sorry for the noise, forgot to squash one part, so it get's not compilable.

-- 
With Best Regards,
Andy Shevchenko


