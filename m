Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1027672934E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbjFIIgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjFIIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:36:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF930E3;
        Fri,  9 Jun 2023 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299752; x=1717835752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SrqOqEQbozaVAjlR+PMI9fwjHqDp6IjKyh5d/Z9Nh0E=;
  b=NnLniI0tUCGdXwvYMJt0scSkhyTGi4r/EVItaieB8Regf1TmQ/sJ6+hQ
   sVJjat3b0FZ+U+53sIZ0vn05rbQFBNGZsCo3F0x1ietunaUuSTWSGJRms
   ntiIDhiwgDt68b/YXTNj1b7i60IqJbG6eGb1c2bKOw3sHRTevlCfs1Ork
   xzWimhEDMZJA8kJ7qMbA+G6WhYjAmEiEtRYDKH18LsB291SQQRWksMSUQ
   S+IWq75+80ICsesQxmLWHQeD5KkqLzxKM7aSyArrXLqY2hfK4hFtdJF93
   48oxZ7gn+P8b6OSrVF1VMSQRRh559b0bhy9ophaxqolPSwEAxJ8NApg3G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="443918029"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="443918029"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="775415722"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="775415722"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2023 01:35:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 018D534C; Fri,  9 Jun 2023 11:35:52 +0300 (EEST)
Date:   Fri, 9 Jun 2023 11:35:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v2 3/4] pinctrl: intel: simplify exit path of set_mux hook
Message-ID: <20230609083552.GM45886@black.fi.intel.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
 <20230609082539.24311-4-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609082539.24311-4-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 01:55:38PM +0530, Raag Jadav wrote:
> Simplify exit path of ->set_mux() hook and save a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-22 (-22)
> Function                                     old     new   delta
> intel_pinmux_set_mux                         242     220     -22
> Total: Before=10453, After=10431, chg -0.21%
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

This adds one more line so it is not simplifying ;-) I think the
original code looks better.
