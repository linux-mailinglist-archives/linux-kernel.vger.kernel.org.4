Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D7672D164
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbjFLVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbjFLVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221C6212F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686603666; x=1718139666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mrVl+bp40EUDrLYzLK2irxG+GLfNeJEEGBShFcfU674=;
  b=lQ1wqYZEwhD1uj7rq4CoSoQRZTT9ZOCMvT1IzI0d0DGyhdJy9XkS84zC
   i+PaI7m9LE2HyyPE8Ck17Pq33DB+3Ah1RZh7UBiVk6yQW82WNm+XokjDa
   XtWYWwg1kosoJoMwY3K/Gu47RSSXJVuSuBybijd0o+ZVrYVyapeNJI7br
   FGjMQM0qtswEQ+AILhgESSyLHiwzv08ycNqMzqDxrcNDL47nBXDJ0ALoV
   T/GDUvy81gPGyV75A/14ruFw80UDNcp+1L4vCRc3YwK/Bz/J79os6VQgg
   GZZ5iopb8bybSE83MOkr0/3ykm3EXHEOV7a+CPU6n0KpD/RZ4r8gNSKRy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444538187"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="444538187"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824110378"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="824110378"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2023 14:00:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8oeb-003Ix8-0d;
        Tue, 13 Jun 2023 00:00:45 +0300
Date:   Tue, 13 Jun 2023 00:00:44 +0300
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
Message-ID: <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZId/IA41c2sJyvE0@itl-email>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:25:01PM -0400, Demi Marie Obenour wrote:
> On Mon, Jun 12, 2023 at 02:59:38PM +0300, Alexey Dobriyan wrote:
> > > +	bool _placeholder;
> > > +	return simple_strntoull(cp, INT_MAX, endp, base, &_placeholder);
> > 
> > This can be done without introducing dummy variables:
> > 
> > 	void f(bool *b)
> > 	{
> > 	}
> > 
> > 	f((bool[1]){});
> 
> This is more consise, but (at least to me) significantly less readable.
> 
> > > > lib/vsprintf.c:3727:26: error: unknown conversion type character ‘!’ in format [-Werror=format=]
> > > So NAK.
> > 
> > Yeah, ! should go after format specifier like it does for %p.
> 
> I hadn't considered that.  Is the typical approach in Linux to use e.g.
> %d%[!] if one wants a literal '!'?

It might be that the cleanest way we have is to create %p-like extensions to
sscanf(). %p takes alnum as parameter and that is usually works since it makes
a little sense to attach alnum suffix to the pointer.

(I don't like to have %dX, where X is alnum as we expanding our hack to
 something which people don't expect to be altered even in the kernelm, you may
 refer to the discussion about %de for printing errors)


-- 
With Best Regards,
Andy Shevchenko


