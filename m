Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4D731C48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344922AbjFOPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbjFOPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:16:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5822961;
        Thu, 15 Jun 2023 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686842192; x=1718378192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WJFD1QugEMkXGpOfUddhdXOqZp7hFpJBK+3G1BIhDVM=;
  b=LV2rx4EiHYFCgj0OkMvCs8JQ1eMuGbSa00pGCo67moSzJRDe7Y7IkptQ
   UYCjTh9UTuIsB+wzOkDvysTn07rc+5Wve2eQa/aTne3GXjnHuFtayACel
   s/80ez/TRxo5rXwuu3Xu5OsYKpDg8xPN4v3kcmDdiO/h9gzoaAHj+MGok
   wCdApC2dTh19/Eu0IJHyqOMl/z3Ic8WrD0jK0YOjBYI0OoXH1DmiuBlwB
   CBoQeOw2LDCnAGmdI2EFJoImjrcbIQv3S2nOEjbdme4EzwOx3QAjgmsoJ
   sWY+nX+CrdE6eAhpuhjnmmIuXJRnj5lpIUDwzCBv9k2KNshRpf05jV2hw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387449597"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387449597"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782541983"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="782541983"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 08:16:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9oi4-003yG3-34;
        Thu, 15 Jun 2023 18:16:28 +0300
Date:   Thu, 15 Jun 2023 18:16:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jadav, Raag" <raag.jadav@intel.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: Re: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Message-ID: <ZIsrTNkW8BsUkeS9@smile.fi.intel.com>
References: <20230615125022.27421-1-raag.jadav@intel.com>
 <ZIsOvBGLJTCo45jp@smile.fi.intel.com>
 <DM6PR11MB2779FD7F6DF3A0126DB85E4B8C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
 <ZIsbg2h0u93tCQiz@smile.fi.intel.com>
 <DM6PR11MB2779545C0ACBF833E857EBD28C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2779545C0ACBF833E857EBD28C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 03:05:42PM +0000, Jadav, Raag wrote:
> > On Thu, Jun 15, 2023 at 01:35:19PM +0000, Jadav, Raag wrote:

...

> > > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-9 (-9)
> > > Function                                     old     new   delta
> > > intel_gpio_irq_type                          317     308      -9
> > > Total: Before=10469, After=10460, chg -0.09%
> > 
> > Do I understand correctly that this is your patch + suggested above?
> 
> Yes, this is tested with gcc 7.5.0 with default -O2.
> I see some reordering in disassembly even with this simple change,
> and I'm not entirely sure what kind of weird tricks gcc is pulling here.

For me gcc (Debian 12.2.0-14) 12.2.0 gives the same, +4 bytes.
I am going to apply v4 with suggested tweaks.

-- 
With Best Regards,
Andy Shevchenko


