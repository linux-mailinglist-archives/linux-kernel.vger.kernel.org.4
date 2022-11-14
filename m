Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC33627805
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbiKNIqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiKNIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:46:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55431C405;
        Mon, 14 Nov 2022 00:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668415565; x=1699951565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZY/TMu0tY879sbd8q6JUvpQrROr5zWXIKg4dZnda55c=;
  b=Et00aZWlt+yT2M6l9n40nmYx63ErGDEz0Kmo3VS/h5f6kM1kJ4Qb5IWp
   Eug6q/WS+zyhGHXOhAOyPUefsG3x2HsEFl7OXgTQdMBaAX9F3+IunjtGk
   1tnVuqxG4jOV5J0ZISUC3mQvRJfhlJx4iUQ7SkKn8WOBzn9bSzWtPGus6
   qnztJ4pSHNR3OmS8KOvSQ8crSV8fxCYaNOamtGr3I6fBQmUVvAYCxFpRg
   EeoqSQKdcf8NuJwzFmx6YZUFswXPTTzdY04qZ0sLirqIyGyDsovpz0jr/
   4mOF3yW85ESBLhhpeG4GEYR05mVwXzxvVVHt72hU5laCqCpozoOWFuIv7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313720245"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313720245"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:46:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="883457680"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="883457680"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2022 00:46:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouV6Q-00C57d-2U;
        Mon, 14 Nov 2022 10:46:02 +0200
Date:   Mon, 14 Nov 2022 10:46:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <Y3IASgDYdKElTfIa@smile.fi.intel.com>
References: <20221114151235.01e5ff3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114151235.01e5ff3b@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:12:35PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/mfd/vexpress-sysreg.c:64:51: error: initializer element is not constant
>    64 |                 .resources = (struct resource []) {
>       |                                                   ^
> drivers/mfd/vexpress-sysreg.c:64:51: note: (near initialization for 'vexpress_sysreg_cells[0]')
> drivers/mfd/vexpress-sysreg.c:73:51: error: initializer element is not constant
>    73 |                 .resources = (struct resource []) {
>       |                                                   ^
> drivers/mfd/vexpress-sysreg.c:73:51: note: (near initialization for 'vexpress_sysreg_cells[1]')
> drivers/mfd/vexpress-sysreg.c:82:51: error: initializer element is not constant
>    82 |                 .resources = (struct resource []) {
>       |                                                   ^
> drivers/mfd/vexpress-sysreg.c:82:51: note: (near initialization for 'vexpress_sysreg_cells[2]')
> drivers/mfd/vexpress-sysreg.c:90:51: error: initializer element is not constant
>    90 |                 .resources = (struct resource []) {
>       |                                                   ^
> drivers/mfd/vexpress-sysreg.c:90:51: note: (near initialization for 'vexpress_sysreg_cells[3]')
> 
> Caused (probably) by commit
> 
>   52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
> 
> I have used the driver-core tree from next-20221111 for today.

Fix is available here:
https://lore.kernel.org/lkml/20221113191027.2327-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko


