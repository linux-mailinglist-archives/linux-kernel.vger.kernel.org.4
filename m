Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF25EDDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiI1NlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiI1Nkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:40:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347F3925B2;
        Wed, 28 Sep 2022 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664372439; x=1695908439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J5h6n9qgLKyvzXPveHko95e1eP2rnwHvggEMNLzh/dk=;
  b=eq/qZSI83k1GedY/ELxpVLxgH5U9re9nAe74wEoka6oTbrdOPOKDDtfJ
   qMLozKOZvtC+nn+VLh3u5BOt90qLALB/Zb1Egxe4rcljS1ijmk16E23BP
   4SaguAMWpH4N/WXugstDKikj6WF5S0TgAsDGyLLsc/zjIaOnTzfJW/SAV
   1nIxPmm9JP0DWjUcMsN/mNlSfZritsMfFUoIGRJrGEIBPTHQLZm3F+9LL
   HFsd6cLSo+qzMl03NneqkJkANa8HFwNmhpyzGshR6ao1ojWXP2uCnvaSQ
   F0NfGZaoKCyLI7ebhAaCf0Oc5bsR8HHibTrf/7fkGeNL1MGVfpXDT5z/m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="281973023"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="281973023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 06:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="764293561"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="764293561"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2022 06:40:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odXIh-008x0t-2W;
        Wed, 28 Sep 2022 16:40:35 +0300
Date:   Wed, 28 Sep 2022 16:40:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Message-ID: <YzRO0xrzlrHAYdaI@smile.fi.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-3-andriy.shevchenko@linux.intel.com>
 <YzQ9+Wzhfnila1s3@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzQ9+Wzhfnila1s3@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:28:41PM +0200, Thierry Reding wrote:
> On Fri, Aug 26, 2022 at 08:07:15PM +0300, Andy Shevchenko wrote:
> > For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
> > instead of the raw sprintf() & co. This patch replaces such a
> > sprintf() call straightforwardly with the new helper.

> How exactly is sysfs_emit() safer here? In all of these cases, the
> values that sprintf() writes are the only values that are written into
> the buffer and we know that none of them exceed PAGE_SIZE. So the
> additional checks that sysfs_emit() performs are useless.

This is a recommended way to use sysfs_emit() mentioned in Documentation.
Care to fix documentation?

-- 
With Best Regards,
Andy Shevchenko


