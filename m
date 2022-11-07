Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356BB61F196
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiKGLLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiKGLLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:11:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119F6388;
        Mon,  7 Nov 2022 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667819463; x=1699355463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=osqOlVd9Zlo/C60qv2PnE4vOKO4mByuvaWgk1xnsyHU=;
  b=IG5PB92exL2l4G2aLBI6neoXoOMW8Uiwrq0BIgE2Unpveh0GCEH95cNe
   4YT9/mZBcfAy4qU7Shx1ZZ3PATlVLieGBPCVe3uj0gglv8UY27LuCe3aR
   hEWr/5nWLirdPb8cJSIc6qJL6L5zpgd4Ngmj1tUmdC0q2npV5P0+cS1eH
   Emg7/B8Aq53/6olnhOi4raGy9zBJX2TXrKd7oIVKJnwnCd1ln+VLfY4FB
   Q6gm90/Q9CwZY3NI23gogzf4i3VJNB4hA47+YPs22jsef379eccuIT2xx
   0OpxrdY4JL6RHUOzeCrR0FQ538J7P9/nxGEDh10aUOb0Tu0ZihimpXk1B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="372506401"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="372506401"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:11:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="778452254"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="778452254"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2022 03:11:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os01q-008bSw-2e;
        Mon, 07 Nov 2022 13:10:58 +0200
Date:   Mon, 7 Nov 2022 13:10:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] leds: is31fl319x: Wrap mutex_destroy() for
 devm_add_action_or_rest()
Message-ID: <Y2jnwgdUiFYjyXvE@smile.fi.intel.com>
References: <20221104235940.74044-1-andriy.shevchenko@linux.intel.com>
 <5f1a31ba4a53f8461bad7747ae09e73fcfe0af1c.camel@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f1a31ba4a53f8461bad7747ae09e73fcfe0af1c.camel@mailoo.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 01:37:55PM +0100, Vincent Knecht wrote:
> Le samedi 05 novembre 2022 à 01:59 +0200, Andy Shevchenko a écrit :

...

> LED still works fine after applying this patch,
> also after rmmod'ing and modprobe'ing again.
> Please let me know if something else should be tested.
> Thank you !

Thank you very much for testing, I believe it's comprehensive what you have
done already.

> Tested-by: Vincent Knecht <vincent.knecht@mailoo.org>

-- 
With Best Regards,
Andy Shevchenko


