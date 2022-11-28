Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3959A63B131
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiK1SYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiK1SXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:23:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0062F67E;
        Mon, 28 Nov 2022 10:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669659171; x=1701195171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xaWF9C0/0D+j8i7P82sI3ZUSgtkWKl8JwJRUvbYeeK8=;
  b=VN4efkW/4/rPV8edTo/WptaEG7cVmMPzBzpn1p62mEye8J2DA3BSBHR+
   715LdMFDfPPtfpfMhsQoKnTLHV+eojFRpwWBPVrd64sBuT62V37DFw+TH
   SjAYhEAo0XA1AXoSZ9fvk/fT1uORC33kyelUc6QEQ23MVWFAHcxfGPADf
   RedXCbfEUnmegxRipudZxkiqNh6ES/uAi8HlGGWcCCxsDhCUZXYmEt7hF
   Hf1XblvbzvOE5kMBXovP8Ey7KIczNPOj1PeYkFOOOSPdxwiVR7QH/WOUD
   vjpjiBi6DuXO38vgFuC16edPOA9c+70a3dey3tKLbqkJWJ/zgp2qiMdBW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316748383"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316748383"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 10:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643486605"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="643486605"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 10:11:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozibQ-001Kan-0S;
        Mon, 28 Nov 2022 20:11:36 +0200
Date:   Mon, 28 Nov 2022 20:11:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v1 1/1] gpiolib: Unify access to the device properties
Message-ID: <Y4T513bRjE0dptt+@smile.fi.intel.com>
References: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
 <Y4EJv2gCR8nj3hHj@smile.fi.intel.com>
 <CAMRc=MdBDsN36CEvmFB_1pH9o5kzMMuSfGQmWKgDA6iaOqURYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdBDsN36CEvmFB_1pH9o5kzMMuSfGQmWKgDA6iaOqURYw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:01:42PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 25, 2022 at 7:30 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 16, 2022 at 04:17:28PM +0200, Andy Shevchenko wrote:

...

> > Bart, can this be applied?
> 
> Sure, now applied. Got carried away with this use-after-free from
> userspace problem.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


