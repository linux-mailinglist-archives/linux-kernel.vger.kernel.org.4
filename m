Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C532729371
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbjFIIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbjFIIlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:41:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800742D7E;
        Fri,  9 Jun 2023 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686300066; x=1717836066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XFEmxaqYNZWfe7AaILsM69VZtz6IwceTV5OeCXpNMVQ=;
  b=BcRxzt6SGXB3PqUOIro/BI03dyXKJJvkLhZrNC6ASLBEKywLrIbaVp6W
   +r3YMm+dHodm5oQFOKMuqdYf6474Y1uDU1LnGFL/9LWUw3n1SSwTBTNhq
   gSPf3D4KaGXTXl/rFDuGr+3DWXZzCTTWXYnvBKh5CEpQYTl5T5yITiIQX
   55qHfez1Tk7m4FgbkEOFB6ckRocPAgvjeZxxGQlBOUIMHmrsdJ2Q1JFfl
   8iaCZNiV4NN576FTHYq1VtD/xVq0TQt6Sl9MfxyBnSDJBsVDv7e7bGQ0q
   AQlGfqfhenZYnJ7K2WGzFLfofdDmFflXfs3YQFtSHSqsOJEYBrjDVyi7J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356442515"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="356442515"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="822978051"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="822978051"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2023 01:41:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1A49734C; Fri,  9 Jun 2023 11:41:12 +0300 (EEST)
Date:   Fri, 9 Jun 2023 11:41:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v2 1/2] pinctrl: cherryview: simplify exit path of
 set_mux hook
Message-ID: <20230609084111.GN45886@black.fi.intel.com>
References: <20230609083356.24849-1-raag.jadav@intel.com>
 <20230609083356.24849-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609083356.24849-2-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 02:03:55PM +0530, Raag Jadav wrote:
> Simplify exit path of ->set_mux() hook and save a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-34 (-34)
> Function                                     old     new   delta
> chv_pinmux_set_mux                           640     606     -34
> Total: Before=19233, After=19199, chg -0.18%
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Ditto here regarding simplifying.
