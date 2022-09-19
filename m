Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD15BCDBA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiISN4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiISN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:56:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AC2F003;
        Mon, 19 Sep 2022 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663595790; x=1695131790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AjcgzWD7CucZKEGxIHwZzvqFw7+SwSPAEDI0ygxB5Ns=;
  b=CBeWLsk/EARwI8PSkVwcrVmMDGCxFfIMXZjgXA0lmcCsRA8f6bYQCA+v
   bhMzuD1Gc3bl0IXztQ4aIXius3lQNmkOMaQu6AVkcdZTaWmlOU4zovbP1
   qoBSwBHpdgYKVAFNvyQmdYdiDp8WRBmw+oteJthrgaUolw7gnmhSM0mDV
   FbmrM5L0uK3Ad2dFmgSzurrSRkPHlloDt2CuUBK6OSFhDPz7qhexRG8hd
   lOE8xFj1QRaxY++GlLJyG4X9w3ACcSnYsD4SMVc1mlRvyeXV052Ycb60s
   GBcCCv5utVwoY1b7fzdhUH9Xfr/1/YT28r34BcJ02/yiyvGnLL8gI7hl5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="385694444"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="385694444"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="620862578"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2022 06:56:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oaHG6-004Zz8-0d;
        Mon, 19 Sep 2022 16:56:26 +0300
Date:   Mon, 19 Sep 2022 16:56:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
        Alex Williamson <alex.williamson@hp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennert Buytenhek <buytenh@arista.com>
Subject: Re: [PATCH v2 1/1] serial: 8250: Turn IER bits on only after irq has
 been set up
Message-ID: <YySaixqlQjkMYPUB@smile.fi.intel.com>
References: <20220916133804.15196-1-ilpo.jarvinen@linux.intel.com>
 <YySX8E3PjAvRr/ld@smile.fi.intel.com>
 <YySZ8M5OQqAaaT1b@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YySZ8M5OQqAaaT1b@smile.fi.intel.com>
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>) id 1oZDYp-003INI-2M;
 Fri, 16 Sep 2022 18:47:23 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 06:44:49PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 16, 2022 at 06:36:16PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 16, 2022 at 04:38:04PM +0300, Ilpo Järvinen wrote:
> 
> Side note:
> 
> $ git grep -n -w setup_irq -- drivers/tty/
> drivers/tty/serial/8250/8250_core.c:382:        .setup_irq      = univ8250_setup_irq,
> drivers/tty/serial/8250/8250_port.c:2341:       retval = up->ops->setup_irq(up);
> 
> which rises a question of whether we need the setup_irq member in the
> respective structure.

And to be confident, the files that include linux/serial_8250.h and have
setup_irq word in them (recursive `git grep`) in entire source tree:

drivers/tty/serial/8250/8250_core.c
drivers/tty/serial/8250/8250_port.c
include/linux/serial_8250.h

-- 
With Best Regards,
Andy Shevchenko


