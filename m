Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7646263F060
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiLAMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLAMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:23:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB0018E3C;
        Thu,  1 Dec 2022 04:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669897392; x=1701433392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EP/AlIx/iBNKrfQdGQpEKhAM6XUj8+gNp+3KbyqvZ/k=;
  b=gLTRKfpYo4lyvqw0eEuKcJnOkPPnOdCDnB0xXNb8zDtw+kpMnIRMzm6+
   i8HUWfE3Dzle4reIWIbUGimG87HsLNcMkLBgOZZj3Q3Rg186ZUziqIrBw
   T/xzdNGp5TJO2xzmdJxwr2TmaIeAcWuTGW1CEAWM6wyAnNQ9ow5fPTvRW
   KtUKEcw9+KP9077QfpR4by95+WTHwtQ42t6uHKs3VQ/W/dXLL0EBjw58u
   TSLUMC28hDhfUKf7jFi0jS7xgvCx7DYn2pDi81lmhgij0AtOydAD7aJss
   agrc6/tkCFx38BqZrY2Uuiy/6nK0/iyqAB+UulBQwPqRyAYqJ2zz62xoh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313301115"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="313301115"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="644623510"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="644623510"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 01 Dec 2022 04:23:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0iak-002mR5-2C;
        Thu, 01 Dec 2022 14:23:02 +0200
Date:   Thu, 1 Dec 2022 14:23:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v6 tty-next 4/4] serial: 8250_pci1xxxx: Add power
 management functions to quad-uart driver
Message-ID: <Y4icpjHDim7eAJjx@smile.fi.intel.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
 <20221201045146.1055913-5-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201045146.1055913-5-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 10:21:46AM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx's quad-uart function has the capability to wake up UART
> from suspend state. Enable wakeup before entering into suspend and
> disable wakeup on resume.

...

> +static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_pm_ops, pci1xxxx_suspend,
> +				pci1xxxx_resume);

One line?


-- 
With Best Regards,
Andy Shevchenko


