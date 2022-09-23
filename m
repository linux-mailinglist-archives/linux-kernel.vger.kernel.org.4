Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136405E802B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiIWQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiIWQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:53:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568221252
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663952010; x=1695488010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a09Jpxnm6bXG39M+h3rU0X8ChfwEa6vjCETaBB3rp6Y=;
  b=IQV2Me7ta3fMYQShk6bzx4Lu7NqPLoKaxZj0P8a8C9YB59SPFUBy6g8N
   AqpanJQ/r6c4/PS50FvwEQyKuUY99icegR/f7JU5W6BgBm3/W3D/LkY3e
   qn+mXdfRxIvVAt3xDBR1d/ieKsLKvXfUgigvewTcfXKue0DUjiD4dWMcM
   wMayXUzAmfKeqMG6XD0DUh02polQwSiCApTufGDik+315ZAPdLHpMZXOL
   k4OiIBMu2qR0yo9bWDPJ7FbDVs/Uto92pl2wzuSf5IAlIB0NNcr3QBWUp
   DTVvZwI458iuNEXHwR2fA/IG+19t23xPdBGVDr5lpT1ZnozFu9IS0zFJt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="280997737"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="280997737"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="597928013"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 23 Sep 2022 09:53:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oblva-006ZnC-0y;
        Fri, 23 Sep 2022 19:53:26 +0300
Date:   Fri, 23 Sep 2022 19:53:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <Yy3khQ4ERr+z16Wj@smile.fi.intel.com>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com>
 <202209230932.1FA2FF39@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209230932.1FA2FF39@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:41:19AM -0700, Kees Cook wrote:
> On Fri, Sep 23, 2022 at 05:40:01PM +0200, Jason A. Donenfeld wrote:

...

> > +		__clamp(val, lo, hi),						\
> > +		__clamp_once(val, lo, hi, __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
> 
> *complaint about line being >100 characters, but I don't really care* If
> anyone is really bothered, this looks fine, too:
> 
> 		__clamp_once(val, lo, hi,					\
> 			     __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })

Actually }) should occupy a separate line and it would be nice to have it for ({.

-- 
With Best Regards,
Andy Shevchenko


