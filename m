Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D397C5FAF92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJKJpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJKJpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:45:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD6C1B7AC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665481499; x=1697017499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9TB/KC0/xhHrJ6fWrvy5aYo8+dqPpfMOw5aSJ61Aquc=;
  b=nboIORbshO0vbuRcCI65LdwyFprGsCuJaddqrAg3YqnOhKvJz19Skms5
   lizbCJ16T7IfK29Mzp/jBfrKPIvt/mJrkPaADVLvw4O5+LnDUawyn2Kcg
   mK5/EuqGPEWt3DAv870XtixJNbr+ODSSbarMHtCTzfbuIvHb+G8AdVfBy
   p34wjuWgYtGlex8x/+ds+0KJW0RrutvrcrzLRbGBGvn5r43XbkEgicxHv
   T10EeExP64F+XGg8tuV32o/yLDhz4auz0hXnk//rULrnpY5GKbaHVadnG
   MMK/wHTP93CVCqYTG71TFskFUmSGLlAWhfXlugTYwaNHFCGk/QFxas7xD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="368623950"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="368623950"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 02:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628629842"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="628629842"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2022 02:44:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oiBol-005FYk-25;
        Tue, 11 Oct 2022 12:44:55 +0300
Date:   Tue, 11 Oct 2022 12:44:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mfd: syscon: Remove repetition of the
 regmap_get_val_endian()"
Message-ID: <Y0U7FzeKzGYZATC4@smile.fi.intel.com>
References: <Y0GZwkDwnak2ReTt@zx2c4.com>
 <20221008154700.404837-1-Jason@zx2c4.com>
 <CAHk-=wiqN9EJ6zKXh21EQ2CV-B7_oDJKy73+yhRwtbNMWCzfVA@mail.gmail.com>
 <Y0HKeTWneX12OP+Y@smile.fi.intel.com>
 <Y0Udqwp9j1HNEwn8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0Udqwp9j1HNEwn8@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 08:39:23AM +0100, Lee Jones wrote:
> On Sat, 08 Oct 2022, Andy Shevchenko wrote:
> > On Sat, Oct 08, 2022 at 09:45:16AM -0700, Linus Torvalds wrote:

...

> > > And if not, please just send me the revert through the normal channels. Ok?
> > 
> > Yeah, revert is a good move here.
> 
> Could you review and provide a tag for the revert patch please?

Done.

-- 
With Best Regards,
Andy Shevchenko


