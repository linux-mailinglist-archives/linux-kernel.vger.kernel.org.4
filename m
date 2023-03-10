Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B66B4DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCJQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCJQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:57:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925FE166EF;
        Fri, 10 Mar 2023 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678467301; x=1710003301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WoEGJdebKJebfYrTAKR9oKIh74jFLLaywLyGJMrb4Gk=;
  b=cISCux83Ea8PAXsQucnmREddmvvpKSjusXBkc9rBPSeyz064IpoE3nNO
   gWEqV3gXYIKLzIT1oOoBe1onlinKSdtbc7GeWjaRkQ4iQKC2d2Z+jxtDH
   0uaPxqlNTNTGPXovMiaVOO058RuwFuypYA8kZh4Tl3KSscfKECmR2wsRk
   SWGhZ8MnABCLOEGlPYqzxriboYHg9yp5/3IAo3gwex6txB6UVxdtZSJjY
   NWvDGMFXFtFoP8+xp9pDvNhhhREtyMNB34Ksrw0E/XRlyy1esaUOoX4J4
   o8fDdff771ieAFAzQ0K5ynLoMhwz35w4GzSFpyGu2a9+JtvsaBWqidQaR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336793240"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336793240"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:53:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="710336629"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="710336629"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2023 08:52:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pafzC-0012Jg-1N;
        Fri, 10 Mar 2023 18:52:54 +0200
Date:   Fri, 10 Mar 2023 18:52:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liang He <windhl@126.com>, Wan Jiabing <wanjiabing@vivo.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: c8sectpfe: switch to using gpiod API
Message-ID: <ZAtgZppUrfBBs2Mu@smile.fi.intel.com>
References: <Y92VLGLQJZ/UDRx1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y92VLGLQJZ/UDRx1@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 03:13:48PM -0800, Dmitry Torokhov wrote:
> This switches the driver from using legacy gpio API and to the newer
> gpiod API. Since ordinary gpiod APIs operate on logical and not
> electrical levels, handling of the reset GPIO is adjusted accordingly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is an important patch for the further cleanups in the GPIO subsystem.
Can we have this applied, please?

-- 
With Best Regards,
Andy Shevchenko


