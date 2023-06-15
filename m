Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EFA731674
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbjFOLYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbjFOLYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:24:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C51FDB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686828248; x=1718364248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wZealJFBuKHllUbXwzgu9RKiUrb3oBvFvTlLh890Dvg=;
  b=F6wvQgZX7P3aH3k6QKOKh0heCmVXLvkGn9G4lfsb8v8wqk7eZVQ2OUGZ
   gwTCaiafS8FjEbx14qD68/NPnTSEQu1ScyZhHaP1oyTRdg4B8QH0lkh8O
   5F3p8nj1HO0mipYeqfKGmI50WorjVkuO/+voz5D0kRL+qMAu6tJBtWmXa
   ArXQYfb1Fl+Zs9UVBh2gbmZll+mv679/PK84roqThta1gUv1n+mTFD7gu
   EFJIW2QUhdt2fh9ttBg+Noy5nPvc3wlm/72pXLD3W1jNbPoaIwbNf9QJs
   3b1BtTrRUM3aGUzzg0AT9rPWszehHBE4hH8fw6KV5XRCXQGi142YBfETS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361363997"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="361363997"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 04:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886607456"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="886607456"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2023 04:24:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9l55-003vZr-1M;
        Thu, 15 Jun 2023 14:23:59 +0300
Date:   Thu, 15 Jun 2023 14:23:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Demi Marie Obenour' <demi@invisiblethingslab.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <ZIr0z6u17xogE5+n@smile.fi.intel.com>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email>
 <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
 <ZIoeVjC6offUywop@itl-email>
 <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 08:06:46AM +0000, David Laight wrote:
> From: Demi Marie Obenour
> > Sent: 14 June 2023 21:09

...

> > > What sort of formats and data are being used?
> > 
> > Base-10 or base-16 integers, with whitespace never being valid.
> 
> In which case sscanf() really isn't what you are looking for.
> 
> > > The "%s" format terminates on whitespace.
> > > Even stroul() (and friends) will skip leading whitespace.
> > 
> > Yes, which is a reason that strto*l() are just broken IMO.
> 
> They are not 'broken', that is what is useful most of the time.
> The usual problem is that "020" is treated as octal.
> 
> > I’m trying to replace their uses in Xen with custom parsing code.
> 
> Then write a custom parser :-)

Hmm... Usually we are against zillion implementations of the same with zillion
bugs hidden (each buggy implementation with its own bugs).

-- 
With Best Regards,
Andy Shevchenko


