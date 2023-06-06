Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3727243C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjFFNIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbjFFNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:08:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D010F5;
        Tue,  6 Jun 2023 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686056893; x=1717592893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ab3KlbnKediTOPcSqZkVfD1wTdlGFRKustedT15lhrA=;
  b=bE8LX/JRig/w6bD3Mf5P6Nn2DnIrBXT3I194JQfS7P4NHV0M7W5smfJX
   AmjyjvLW02VmVPsf8Tex2oG1JdrGTbgNWOYWfxGv/Wjl5o6o0Oozx7RQy
   zVMUPOvgTWMrTtd9SAK+KOAd5eE4zve1XUvv00qvqzUQM2TX08pNssP9N
   wSAbCrFsOLxQ26LZdqhh+UD41KlwVYJs0rIBpVSeGlKyUelXbknVk0MoK
   zAdVIglEWrc1Qdm2HQaedRhGXVCVCrYqTqOyiXjHtkuQIZMVOee0NAt6K
   7w2Z5Vx61uiTZnYATkJ0LwsjcvD9jiCj+91IV06LGpdhi/iuipTjrCh2m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356671154"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="356671154"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="703152942"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="703152942"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 06:07:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6WPY-001dGg-27;
        Tue, 06 Jun 2023 16:07:44 +0300
Date:   Tue, 6 Jun 2023 16:07:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] pinctrl: merrifield: Fix open-drain pin mode
 configuration
Message-ID: <ZH8voLL0RBgqmcYp@smile.fi.intel.com>
References: <20230605154509.11616-1-andriy.shevchenko@linux.intel.com>
 <20230606051210.GV45886@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606051210.GV45886@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:12:10AM +0300, Mika Westerberg wrote:
> On Mon, Jun 05, 2023 at 06:45:08PM +0300, Andy Shevchenko wrote:
> > Currently the pin may not be configured as open-drain in some
> > cases because the argument may be 0 for the boolean types of
> > the pin configurations. Fix this by ignoring the argument.
> > 
> > With that, allow to actually restore pin to the push-pull mode.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Both pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


