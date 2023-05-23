Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD89570D8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbjEWJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbjEWJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:14:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352D18C;
        Tue, 23 May 2023 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684833241; x=1716369241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p11Fh3zV0aO7V1029S8TVD+DK0K/zYni8ofbYQ7Ur8U=;
  b=dhjVFSoymcX7tLWEY1tE4i6E5V9Hi2pI2RP3t6LQzFhjY6nNfICgtWri
   tgVhPUASZjT54s7XPSlhtjN4Vj1xayWdbV7k4zIKj/EfkBCvheO/1TjaD
   rm0qGTIrBC1ftVZe/f+rPghk1C6l64thEWrReyT5fh26QuCAuWrw7Ck39
   0MtZ2y36vFEci8VNzsKi/MlMw9kmkJS8hBZPjyQyVJWkBAkuIvHz9sHCj
   MUz+8QXQgS69FvrIgfOZxKioDHD/xNKXjG9P4otYKBNxP54xHhLZHJGKk
   IouYIpqm2YawlllW16qEMf/bMNvXskXjvEondvjOMx1YSpQfjEnjdJ6rM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="439538453"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="439538453"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697986976"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="697986976"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:13:46 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id E8B301202A8;
        Tue, 23 May 2023 12:13:43 +0300 (EEST)
Date:   Tue, 23 May 2023 09:13:43 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Lee Jones <lee@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] i2c: Replace all non-returning strlcpy with strscpy
Message-ID: <ZGyDx4Jg9j2zmjD6@kekkonen.localdomain>
References: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
 <20230523090540.GC2174496@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523090540.GC2174496@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee, Azeem,

On Tue, May 23, 2023 at 10:05:40AM +0100, Lee Jones wrote:
> On Tue, 23 May 2023, Azeem Shaikh wrote:
> 
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > [2] https://github.com/KSPP/linux/issues/89
> > 
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> >  drivers/leds/flash/leds-as3645a.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Please resubmit, taking the time to check the subject line please.

I'd say also shorter description will suffice. Nowadays people understand
the motivation replacing strlcpy() by strscpy() without too much
elaboration. Lines may be up to 74 characters long, too, and period isn't
automatically followed by a newline.

The patch itself seems fine.

I also prefer my @linux.intel.com address, as in MAINTAINERS for this
driver.

-- 
Kind regards,

Sakari Ailus
