Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D866428DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiLEM7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiLEM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:59:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25987CE00;
        Mon,  5 Dec 2022 04:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670245186; x=1701781186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xOtwYkUIpy45DSSp7h99YLkqF1fUUVQ02RW/wMTRaJM=;
  b=YzfmLesATiJDAE6p6kQ/QWhoEmg0UcW8iNbtIl0lEMmg/QiP2GTcJJaf
   oobZfPEfw8R4e3k/2ceoafJwib3GIjuX1p6oNfTe1YOX13XLfQoAjH+3G
   q6T+OlNGPJVF7W3xIrfvFpLrY1+o6XvM9VR4rfKIrosQ3XpAphvG2j+1Y
   MGF40nWaxViyHONv4I3FSYfjMdXOxclTkzDQj12h8sr+4LyliKHTq2n3U
   r4oiO+ewbvU0UMVLqpbB6b4KGHQH4Lydf6upBC/V47vMXubmKj7JtguUu
   IbhsGw2YZoGfT6Pm7YUHAIigimgYFOmC8uxihlVUag76FPiQV6Hs7Mgtg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="317482391"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="317482391"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 04:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="596187263"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="596187263"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2022 04:59:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2B4Q-004sXB-01;
        Mon, 05 Dec 2022 14:59:42 +0200
Date:   Mon, 5 Dec 2022 14:59:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hainke <vincent@systemli.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
Message-ID: <Y43rPdus/9INC390@smile.fi.intel.com>
References: <20221205123903.159838-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205123903.159838-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:39:01PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Linus Torvalds pointed out that using trylock here is wrong. This iteration
> drops it in favor of unconditional locks but keeps all the fixes that came
> later.
> 
> I will also not send it for this release but make it part of the updates PR
> for v6.2 to give it some time in next.
> 
> v7 -> v8:
> - don't use down_read_trylock(), just go straight for a full lock

Yep, it was a good wrap-up explanation.

-- 
With Best Regards,
Andy Shevchenko


