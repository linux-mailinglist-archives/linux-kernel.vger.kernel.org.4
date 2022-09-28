Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBCA5EDE52
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiI1N6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiI1N6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:58:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96F54C9E;
        Wed, 28 Sep 2022 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664373500; x=1695909500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wg5C49y3dUqV2lp0/dT4U8xXQcghpcMbXMBXeb+bk+E=;
  b=dEnYCwZ2Fqqutss25trHuFXU5ZIQr5cR753RvATHK/sAPUZSFJCvZmZk
   5Su1SjN3HYT22sLDyprTzFYTfSUPbfig7yFS+DobK9w7H4kwrjfF0d5lh
   eox/l7frWqhJpz3AV7blBAIjf0HqR/QI4hleoGPCiPnjFqmNGRIxBKGIB
   kHnU9z6qKjKFTGbeafdEjgzAvSXWLKwoMfrimChY0CZuGn01Y/DhMHg7Q
   yn6bSuSC50jrNceurt3laTePQzOkfVZUMYADN9gFM6Rx5NVDOPe7yxmqg
   GG+17JxBFD2AEWJkH636DT0qu0sMOBwfGlU84KE3yZxTy/Msf1X4ISH0b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363447404"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="363447404"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 06:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="652686854"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="652686854"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 28 Sep 2022 06:58:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odXZp-008xJG-24;
        Wed, 28 Sep 2022 16:58:17 +0300
Date:   Wed, 28 Sep 2022 16:58:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Message-ID: <YzRS+VIBK1AiysEN@smile.fi.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-3-andriy.shevchenko@linux.intel.com>
 <YzQ9+Wzhfnila1s3@orome>
 <YzRO0xrzlrHAYdaI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRO0xrzlrHAYdaI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 04:40:35PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 28, 2022 at 02:28:41PM +0200, Thierry Reding wrote:
> > On Fri, Aug 26, 2022 at 08:07:15PM +0300, Andy Shevchenko wrote:
> > > For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
> > > instead of the raw sprintf() & co. This patch replaces such a
> > > sprintf() call straightforwardly with the new helper.
> 
> > How exactly is sysfs_emit() safer here? In all of these cases, the
> > values that sprintf() writes are the only values that are written into
> > the buffer and we know that none of them exceed PAGE_SIZE. So the
> > additional checks that sysfs_emit() performs are useless.
> 
> This is a recommended way to use sysfs_emit() mentioned in Documentation.
> Care to fix documentation?

For your convenience, Documentation/filesystems/sysfs.rst says:

- show() should only use sysfs_emit() or sysfs_emit_at() when formatting
  the value to be returned to user space.

-- 
With Best Regards,
Andy Shevchenko


