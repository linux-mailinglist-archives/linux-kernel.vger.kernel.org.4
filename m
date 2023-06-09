Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E207E72955F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjFIJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbjFIJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:34:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964DA4682;
        Fri,  9 Jun 2023 02:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686302972; x=1717838972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dclsg2l71sUOby1QnDv4BuruCw/RbBovIuoj+9y2pYM=;
  b=nzf7Lvf1jn/aEUimPwdRPFoyk0ZutW8S+b2YYo2dHfSSWxygRv2Emo+U
   hunYVlAmOeW2NrNDsNNQPKAaCggxFHt3pWYtpiyzEO9Ufiucj9ZXyrYF1
   pKq5HqJ4QC0rtuQKDvXJwyOHYRfU9rqd+Jma/VdniiacbxwJ2DZma4gdH
   bPjRJMjd2M/7nZlC6NUpZOcX01+e+1XSVkuAf7Fiy7Zd8FlgazZoFEfNF
   xlZz7G0jb3M7Wv8O15HBg1qSqil+2C8chPXcfChVh8jVbhhlC2AWanW7z
   kk+9L6Jb0KzxartQe7sfTWzkTR4XUGZMDu5LoFNUV2TF5JEVoUkmiC2At
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356449349"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="356449349"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="740108873"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="740108873"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 09 Jun 2023 02:29:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 41B6634C; Fri,  9 Jun 2023 12:29:20 +0300 (EEST)
Date:   Fri, 9 Jun 2023 12:29:20 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Jadav, Raag" <raag.jadav@intel.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: Re: [PATCH v2 3/4] pinctrl: intel: simplify exit path of set_mux hook
Message-ID: <20230609092920.GQ45886@black.fi.intel.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
 <20230609082539.24311-4-raag.jadav@intel.com>
 <20230609083552.GM45886@black.fi.intel.com>
 <DM6PR11MB27791AE074AE94F8CA5C02A58C51A@DM6PR11MB2779.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR11MB27791AE074AE94F8CA5C02A58C51A@DM6PR11MB2779.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:10:42AM +0000, Jadav, Raag wrote:
> > On Fri, Jun 09, 2023 at 01:55:38PM +0530, Raag Jadav wrote:
> > > Simplify exit path of ->set_mux() hook and save a few bytes.
> > >
> > > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-22 (-22)
> > > Function                                     old     new   delta
> > > intel_pinmux_set_mux                         242     220     -22
> > > Total: Before=10453, After=10431, chg -0.21%
> > >
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > ---
> > >  drivers/pinctrl/intel/pinctrl-intel.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > This adds one more line so it is not simplifying ;-)
> 
> Would "optimize" sound any better?

No, I think this patch is not useful at all.
