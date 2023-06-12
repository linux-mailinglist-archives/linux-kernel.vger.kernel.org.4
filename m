Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56AC72CCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjFLRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjFLRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:36:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A51BC5;
        Mon, 12 Jun 2023 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686591319; x=1718127319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WukTNRen46NQ+J1/agJdZz6fX5veY5abkQR/wVmN5ec=;
  b=PZ8E0pbqivhM1J/K+H5Q613i5seEZ2hQJamG+Rapoz2mssybPr+7QW+z
   KhXYlbJCbqD7mRRmn/acaeyiRvmph+s4sMON7+5LLfPqyMsySxQzF7eVH
   bA9jGSWFJuo7grJB9SY+u/0bcC/L/uLUSQ1pHXUZC8oANBfq/kDu8o/dL
   /jHJvYibar+PHofD+i2cNF9q6afn5n3j7BcBORYVU8O41+3lMKaBBo63f
   3cJtZeX9YfvV0RuSEEH1HibBL/KkXrfPcDdisN/01hazkTK6h/dV/3IyT
   u4XJDACYGovr3nyS2MZWVvk0HTClxfCmST9k3utkBE4HgU12o7jSgk3ra
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338476749"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="338476749"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 10:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="744400263"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="744400263"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2023 10:34:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8lR9-003GYj-2h;
        Mon, 12 Jun 2023 20:34:39 +0300
Date:   Mon, 12 Jun 2023 20:34:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Stein <linux@ew.tq-group.com>
Subject: Re: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay
 support for individual output pins
Message-ID: <ZIdXL2Net/5ttmXB@smile.fi.intel.com>
References: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbaf3UzW+x6emER5J5KJUQoJmdipwY_RQp0Ovj2N6RnsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbaf3UzW+x6emER5J5KJUQoJmdipwY_RQp0Ovj2N6RnsA@mail.gmail.com>
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

On Fri, Jun 09, 2023 at 09:50:37AM +0200, Linus Walleij wrote:
> On Thu, Jun 8, 2023 at 6:22 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The aggregator mode can also handle properties of the platform, that
> > do not belong to the GPIO controller itself. One of such a property
> > is signal delay line. Intdoduce support of it.
> (...)
> > I don't like the idea of gpio-delay or similar. We have already GPIO
> > aggregator that incorporates the GPIO proxy / forwarder functionality.
> 
> You are right. This is the right solution going forward IMO.

Thank you for the support.

Take into consideration 1 kinda neutral and 2 for votes, I'll going to split
and improve the patch (series).

-- 
With Best Regards,
Andy Shevchenko


