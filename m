Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7C5F981B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJJGLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiJJGLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:11:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C921459A7;
        Sun,  9 Oct 2022 23:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665382295; x=1696918295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x0crykk8z7lX1yIdgLtCoUAR3riQQShph89bHw1joeE=;
  b=C0dBarzHScKmdbXdMYTwZoVXkjforzBA4PAFYJpT80RxnfAY18GkIw1U
   Z6awDy7BX12+D4LKTWj1LRxtKDEFl6MNMuB7Z1YVW9OJ6gQp/O1CKiRGZ
   2q1koktdjRWJ5z3/eteXU04CVQziCFCIKOvYTljZgOS1U/tx8z1UAPegs
   Ez/VLrnCQG0BRFMALjZ+qRbv9TXZLexoDe2Fe7MsxbrqyeE+w88rTzfss
   3vL0zlG+iU3uy3lQbjXNKuGmwkfNWTr9rgS0tEaPlDT7vM78SkFsHvI4X
   IH8rhAZUmEI0Zk58jvOck74F1DjugcLoTc4rYbUgP05y7PLAIF9hF51M1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="390457110"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="390457110"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 23:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="954803717"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="954803717"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 09 Oct 2022 23:11:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohm0g-004k9G-0B;
        Mon, 10 Oct 2022 09:11:30 +0300
Date:   Mon, 10 Oct 2022 09:11:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] regulator: Add devm helpers for get and enable
Message-ID: <Y0O3kcR3+vSQEErn@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
 <Yz7/o1q7p8NmGKMe@smile.fi.intel.com>
 <20221009132421.6e472385@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009132421.6e472385@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 01:24:21PM +0100, Jonathan Cameron wrote:
> On Thu, 6 Oct 2022 19:17:39 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 06, 2022 at 05:36:52PM +0300, Matti Vaittinen wrote:

...

> > > (cherry picked from commit b6058e052b842a19c8bb639798d8692cd0e7589f)  
> > 
> > Not sure:
> >  - why this is in the commit message
> >  - what it points to, since
> > $ git show b6058e052b842a19c8bb639798d8692cd0e7589f
> >  fatal: bad object b6058e052b842a19c8bb639798d8692cd0e7589f
> 
> These are now upstream in Linus' tree and in my testing branch.

I don't see them. As I pointed out the commit IDs are not in the any of the
official trees (subsystem maintainer's or Linus'). Again, read my doubts about
the above commit message.

> I'd not normally advocate working on top of that (because I rebase it), but
> if it is useful for this series go ahead.

> > > Already in Mark's regulator tree. Not to be merged. Included just for
> > > the sake of the completeness. Will be dropped when series is rebased on
> > > top of the 6.1-rc1  
> > 
> > Ah, I see, but does it mean the commit has been rebased or you used wrong SHA?

-- 
With Best Regards,
Andy Shevchenko


