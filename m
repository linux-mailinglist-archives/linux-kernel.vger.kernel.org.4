Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51663626F86
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiKMMm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:42:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128ED12A85;
        Sun, 13 Nov 2022 04:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668343374; x=1699879374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+j0oNtGEaWU57mtrA0OycgFLPKMPBzs0k05+bUidqxE=;
  b=B/0ed++lmjFb4E2/ZbGLpCqPjne3Gtkl+rE1i8sBgdvVCPkCTClmKeAk
   I9N7tU2wF5aJVHnNLHWV+TyG3/bJW2uNUdldT66u9qFSRRvAgAXeANaDT
   4agblnQ2lXteH9GY/bvfLJwe1Y91cKrKt2Im8nsJRPnJvfMq+yog6oJz4
   jye3AFGYZ2SnAf/F3gvcEEVO0XuGLGFsSTvKBjjum0o678k1/csUFy9xQ
   UWKu8NcqsGvpyQdFbcgTJ61T12QbWnAYwCTaBOHcSoPyTc3jeWAIizyeI
   Ca/XbsEBIfE5bWiipzZc929wP7AwV6QoUNQsXOpIHk6S/wJsvVU7tpgEM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="292206469"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="292206469"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 04:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="967264507"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="967264507"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2022 04:42:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouCK2-00Bg6k-0i;
        Sun, 13 Nov 2022 14:42:50 +0200
Date:   Sun, 13 Nov 2022 14:42:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v2 2/4] regmap-irq: Add handle_mask_sync() callback
Message-ID: <Y3DmSfdG9ZeV8inu@smile.fi.intel.com>
References: <cover.1668129763.git.william.gray@linaro.org>
 <53e9e89cc9d7e9c20cbdfc13b360dcb43d07f832.1668129763.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e9e89cc9d7e9c20cbdfc13b360dcb43d07f832.1668129763.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:55:51PM -0500, William Breathitt Gray wrote:
> Provide a public callback handle_mask_sync() that drivers can use when
> they have more complex IRQ masking logic. The default implementation is
> regmap_irq_handle_mask_sync(), used if the chip doesn't provide its own
> callback.

...

> + * @handle_mask_sync: Callback used to handle IRQ mask syncs. The index will be
> + *		      in the range [0, num_regs[

Not sure if it's a typo ([ vs. ]), but if you want to say "not including the
last", use mathematical notation, i.e. "[0, num_regs)".


-- 
With Best Regards,
Andy Shevchenko


