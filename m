Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85A72D442
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjFLWQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjFLWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:16:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E38E10CB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686608184; x=1718144184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YCFjBDLB4Ig6iZIjnUtrvpzt6xRtCATwkSb2vj5LVo0=;
  b=UNf/anWI2t4kV/cdcp70hyjW1kHODnrUIUQXqDy/YDs2JEsnfQ2YqL+Q
   a1nJ/NCAdrIhWflwKfeu/lTDzOwl59C93uv4ddOSpKEhjMdDLBSK9XU9i
   cTZnzxnFx0z9gE4/Ue0qj3wQ8PN45Ru5P3czDjRSxORX6xhSCC82FXQpk
   1jz3/S69TvuJhCna/yF72aPCAFuFBfPWz6VACgHUg+6NcRsfMkMFlkdBX
   DljCocsW5f7wOv7PPSqmhhAd2mwaicUhDfWZ0NFfJatCCtZkbkhTL90y4
   Fh7I7xpU3AeQB/GDPfSpTz6K5mcob4/F0tLnUitBx5TVKIHLfVNG1hIiu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342861316"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="342861316"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824136836"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="824136836"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2023 15:16:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8ppg-003JgV-0x;
        Tue, 13 Jun 2023 01:16:16 +0300
Date:   Tue, 13 Jun 2023 01:16:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter
Message-ID: <ZIeZL42Ik6KgHFCG@smile.fi.intel.com>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email>
 <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIeMyQXU49OcoxY2@itl-email>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 05:23:18PM -0400, Demi Marie Obenour wrote:
> On Tue, Jun 13, 2023 at 12:00:44AM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 12, 2023 at 04:25:01PM -0400, Demi Marie Obenour wrote:
> > > On Mon, Jun 12, 2023 at 02:59:38PM +0300, Alexey Dobriyan wrote:
> > > > > +	bool _placeholder;
> > > > > +	return simple_strntoull(cp, INT_MAX, endp, base, &_placeholder);
> > > > 
> > > > This can be done without introducing dummy variables:
> > > > 
> > > > 	void f(bool *b)
> > > > 	{
> > > > 	}
> > > > 
> > > > 	f((bool[1]){});
> > > 
> > > This is more consise, but (at least to me) significantly less readable.
> > > 
> > > > > > lib/vsprintf.c:3727:26: error: unknown conversion type character ‘!’ in format [-Werror=format=]
> > > > > So NAK.
> > > > 
> > > > Yeah, ! should go after format specifier like it does for %p.
> > > 
> > > I hadn't considered that.  Is the typical approach in Linux to use e.g.
> > > %d%[!] if one wants a literal '!'?
> > 
> > It might be that the cleanest way we have is to create %p-like extensions to
> > sscanf(). %p takes alnum as parameter and that is usually works since it makes
> > a little sense to attach alnum suffix to the pointer.
> > 
> > (I don't like to have %dX, where X is alnum as we expanding our hack to
> >  something which people don't expect to be altered even in the kernelm, you may
> >  refer to the discussion about %de for printing errors)
> 
> Personally I’m not too worried about compatibility with userspace
> sscanf(), except to the extent that -Werror=format can keep working.
> Userspace sscanf() is almost useless: it has undefined behavior on
> integer overflow and swallows spaces that should usually be rejected.
> I typically either use strto*l() or (as I am currently doing for Xen’s
> toolstack) just write my own parsing functions from scratch.

`man sscanf` tells about %p, and currently we have no use (if I'm not mistaken)
for %pj in printf(), so that can be used for %pj in sscanf() to avoid ambiguity
with possible extensions to actually parse our %p extension-like strings.

Not sure if others support the idea.

-- 
With Best Regards,
Andy Shevchenko


