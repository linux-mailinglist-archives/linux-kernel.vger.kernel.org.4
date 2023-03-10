Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652196B40D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCJNqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCJNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:46:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3010BA5A;
        Fri, 10 Mar 2023 05:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678455981; x=1709991981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bRieUvM7mwqpEqyRNij92CPtcQ20rS/UHWcE93X/HzI=;
  b=bzFR3Sfgl8v+ER/8roMsxPE5WaXZnbPvZGC9MKzTCaIJj5nq34EKZ6RO
   F6VnhIwNOnJg9RfFExYaI3oqi6QmKaWxPFPOgNxoAL6NopbH/vq/ZKvUA
   zJxVp9mVtEtH2MSi7ugvGYqZQKmyXnFd1NKLQYh17S7Nr01DOGqlCVzOS
   m+RyegZoNMcJ2B91pegaKZnCjXIY/sn3qbehisYNJMB2Roc1gnYi+GL5x
   ypldTtZeQf29g6YteTnJfSVzt+qIYyTONpGkyRMMstTIxzeigIcJhfUYx
   SAQosFlHB3VctHAV/tTh2LvzKcgnD8iK0Z8CWTSBfhPdUMoTgEbHdNjHp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335426020"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="335426020"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 05:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="741981046"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="741981046"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2023 05:46:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pad4Y-000tiL-1B;
        Fri, 10 Mar 2023 15:46:14 +0200
Date:   Fri, 10 Mar 2023 15:46:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        oe-kbuild-all@lists.linux.dev,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZAs0pvTByHWbb+9N@smile.fi.intel.com>
References: <20230309085713.57700-1-tony@atomide.com>
 <202303100516.22vtkWv4-lkp@intel.com>
 <20230310065238.GJ7501@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310065238.GJ7501@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:52:38AM +0200, Tony Lindgren wrote:
> * kernel test robot <lkp@intel.com> [230309 21:31]:
> > >> drivers/tty/serial/serial_ctrl.c:17:34: warning: 'serial_ctrl_pm' defined but not used [-Wunused-const-variable=]
> >       17 | static DEFINE_RUNTIME_DEV_PM_OPS(serial_ctrl_pm, NULL, NULL, NULL);
> >          |                                  ^~~~~~~~~~~~~~
> 
> Thanks I'll tag it with __maybe_unused.

It requires to use pm_ptr() macro, it was designed exactly to *not* spread
__maybe_unused.

-- 
With Best Regards,
Andy Shevchenko


