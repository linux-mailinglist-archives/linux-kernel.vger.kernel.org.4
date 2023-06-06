Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914847243CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbjFFNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbjFFNJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:09:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F510FA;
        Tue,  6 Jun 2023 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686056934; x=1717592934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X1NJnHmrE0AdhXUtsefgU7cHGSvMR+7WVY1418vngQ8=;
  b=Q20kRloraCnu/npuLWzHt1/YAIGOGmMLltojeg2ZWhnuRxX21CxpEkpG
   k5JFzx8LnydWCeG6jnu7FXvy6p8m+RFHiFmCLaoTczLXPTKK2mYtydSSq
   VCv4WPy+/6bLziTqeaZWUMU5hqga8ApmHdxI3QCl7B0EmezucNaCMDU4j
   lym34e4BXy0Fy5tQL9tnSfJc/HiqMUZejsXrroBbqMlBGbS3dt2QLaq2U
   qNYTziBsiZJJao1y7/wJyf3lhcxNK6IqqknGD6F04GBofO1645dCROX2i
   qnmnRH6+VsLzz6qGunwfRN5f1VwdpLL3yzgAKBoBcx5oxxOdXE7KHxjZJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384976069"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="384976069"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="774116908"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="774116908"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 06:08:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6WQO-001dHB-1W;
        Tue, 06 Jun 2023 16:08:36 +0300
Date:   Tue, 6 Jun 2023 16:08:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] pinctrl: moorefield: Fix open-drain pin mode
 configuration
Message-ID: <ZH8v1Fvm2TnoKm1r@smile.fi.intel.com>
References: <20230605154523.11799-1-andriy.shevchenko@linux.intel.com>
 <20230606051547.GX45886@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606051547.GX45886@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:15:47AM +0300, Mika Westerberg wrote:
> On Mon, Jun 05, 2023 at 06:45:22PM +0300, Andy Shevchenko wrote:
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


