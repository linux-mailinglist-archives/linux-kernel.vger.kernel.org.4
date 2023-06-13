Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DD772E77A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbjFMPjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbjFMPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:39:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFF0127;
        Tue, 13 Jun 2023 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686670733; x=1718206733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/xGp+iT5zbAfOiZZknUyObKuwpoHCKHzyzKxIRVycMY=;
  b=jGZLbQclZ8mcfAS6MbEFpzULfghCxa1roIQGEa4Ct8s15WTBjuhlfRK6
   2XnNa5HSMUqzYuwMiXpNaDTH8836a+f0HrkDdUk8DtMZGEWZICj9dZj+j
   N6eIQiafSU79Uxsa5a07g6nm/gnRNAHxBKLE/LKAXJcn+ExguafsEPgW7
   zHMUASG3Qit2Z4VhRa43Dw7/feaaOs8JMSx+jMSWpk2qYGz2wzF2U7oY3
   GhvK7Q4UvPmonWabFBdaz6o92C86QX8gQFDPDmMmcqhKreqLnFoeaUjMW
   ewcsRN+uG7i9v/PXwHtCDdYGKnwLjsNRVYSWdE6QK9zu+vc7vGCiP8Au7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444741953"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="444741953"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="1041811992"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="1041811992"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2023 08:38:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9661-003UMS-2p;
        Tue, 13 Jun 2023 18:38:13 +0300
Date:   Tue, 13 Jun 2023 18:38:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v3 3/3] pinctrl: intel: simplify exit path of
 ->gpio_request_enable() hook
Message-ID: <ZIiNZQj44d0u6g0z@smile.fi.intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
 <20230613085054.10976-4-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613085054.10976-4-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:20:54PM +0530, Raag Jadav wrote:
> Simplify exit path of ->gpio_request_enable() hook and save a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-36 (-36)
> Function                                     old     new   delta
> intel_gpio_request_enable                    186     150     -36
> Total: Before=10453, After=10417, chg -0.34%

I believe Mika's comment against patch 3 of v2 of this series applies here
as well, meaning this patch won't be accepted.

But let Mika express himself.

-- 
With Best Regards,
Andy Shevchenko


