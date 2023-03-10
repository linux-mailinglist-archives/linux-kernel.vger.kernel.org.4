Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE00E6B408A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCJNgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCJNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:36:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA1C10D319;
        Fri, 10 Mar 2023 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678455405; x=1709991405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Y0N0ck8GbBPqM/2NGrwd6Ue+TCZoePj+AemAN9U8qS0=;
  b=Rd69WQISP1SUEXPXWf857dqfwarLgdNqDBPbcW+rIP1pPpqIvlyy1axh
   QvVFNvWuoXm5DwWiBXo15bmVqhgA+Z6pCY4wtBam7leJg0NjJ8zDhDlJs
   Ufi+c33Ldw9FGs0jjESbpHwLflseHn9sq/+iPoqU49Njr1fqRrJiLcv2+
   JiDajmIVi5a1R23E35b3SF1KNc9u1YBU/zZikPEJrszt8hDj2NGy9mSCa
   Gq0TuBfuK7nvBRkrDpnIOyW29t8thY0cLRVGinbywBhAt9A59wkGcA7Ll
   W0MU6/IrVnbxVFbOS5on2lThoNC6N3DjgllS+OAclGRX2/epVSpuVwzzg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="317116550"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="317116550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 05:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="746717467"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="746717467"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 05:36:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pacvJ-000tUF-0u;
        Fri, 10 Mar 2023 15:36:41 +0200
Date:   Fri, 10 Mar 2023 15:36:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
Message-ID: <ZAsyaNzhbcWuJS2q@smile.fi.intel.com>
References: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
 <20230310114150.GA62143@black.fi.intel.com>
 <CAO-hwJK+yF+0u6cbw4CoV8vS80Vx5xkC2vwPjOQvnUox2SMdTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJK+yF+0u6cbw4CoV8vS80Vx5xkC2vwPjOQvnUox2SMdTA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 01:51:38PM +0100, Benjamin Tissoires wrote:
> On Fri, Mar 10, 2023 at 12:42 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:

...


> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Thanks to both of you for the reviews.
> 
> Andy, should I resend a v2 with the rev-by from Mika and the Ice Lake changes?

Yes, please.

-- 
With Best Regards,
Andy Shevchenko


