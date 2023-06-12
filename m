Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF772CA47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbjFLPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjFLPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:34:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AEA10C7;
        Mon, 12 Jun 2023 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686584084; x=1718120084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Eb3Mm09adN6K9gUBCgKSk4MjwnPUfaI+/HnXTw8x3W4=;
  b=nVhOB+xgzMhBjN7BAhOIi+SMkUYePriThgZTKYloD1Tnh3fDUIXzM/04
   O0DYJfp0dDB4mJkYpoKRWV4hk8LaaYPhzV49d/fORbs+ySidH+N7GJkgg
   mTRkEZdBIfnEZALhkmt5YT3Bfidh63bvOGsuAfsN82wGQEKOHQECUUjOE
   W/BzvJBY0C2dCFxwdmUtE8XbgFPAIQCEmXELhmdkyAWH1Sju7PP9H/TBS
   0XVvolS+MNq7pZBKnkTgAZpqATUlVX6O5iUc5kYHd7FOtscmCC6aJf0Ho
   Ma1ZupUEgQukd965KFM7FafrXXsBIXBCgnLiWU9ODGabqu7IqeEETPRrj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="337712746"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="337712746"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="781252297"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="781252297"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2023 08:34:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jYy-0039IC-2J;
        Mon, 12 Jun 2023 18:34:36 +0300
Date:   Mon, 12 Jun 2023 18:34:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter
Message-ID: <ZIc7DJME7yDfrOf+@smile.fi.intel.com>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230610204044.3653-1-demi@invisiblethingslab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 04:40:40PM -0400, Demi Marie Obenour wrote:
> Roger Pau Monné suggested making xenbus_scanf() stricter instead of
> using a custom parser.  Christoph Hellwig asked why the normal vsscanf()
> cannot be made stricter.  Richard Weinberger mentioned Linus Torvalds’s
> suggestion of using ! to allow overflow.

As Rasmus articulated, NAK w.o. test cases being added to all parts where your
changes touch.

-- 
With Best Regards,
Andy Shevchenko


