Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A861729374
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbjFIIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbjFIIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:41:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E059EB;
        Fri,  9 Jun 2023 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686300088; x=1717836088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pzhTaeScbQmK/XTZZyOGV5CmQjygnx9/45Vh51ZbOqo=;
  b=cJ/nXdtaHe1yeMVGCS1+rHSfCnNVapvaxWacWgiLRMTg9VVspb41Crta
   1EhTG46RlwhUUW2hJXp/qxYNO/ivejIJ0AVxxnEoeB953bB7KTnpSAvyf
   96+kcYEVTn1bX9GUVW0dMQbiQH+9Y5Rpsi6Mzp1WXoUQnyxt/WACW29np
   8A3S1u9sQpIXcSTWd1+Qt+9zyrfw32Tvxmz+hhxfpfb0l6SY2hBIbWrRx
   5uvILnZLN40BlJug8VJ6iMSeVPP+i79DdF8pPgEwQ0PpwNaxQs+nmNF3x
   SGN59DXPiu86SLr4do+KSFNIv0ot8+NY5ue8nECDJniFF3wUvpYMHroBi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356442541"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="356442541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="822978077"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="822978077"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2023 01:41:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 26C6934C; Fri,  9 Jun 2023 11:41:33 +0300 (EEST)
Date:   Fri, 9 Jun 2023 11:41:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v2 2/2] pinctrl: cherryview: simplify exit path of
 gpio_request_enable hook
Message-ID: <20230609084133.GO45886@black.fi.intel.com>
References: <20230609083356.24849-1-raag.jadav@intel.com>
 <20230609083356.24849-3-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609083356.24849-3-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 02:03:56PM +0530, Raag Jadav wrote:
> Simplify exit path of ->gpio_request_enable() hook and save a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-10 (-10)
> Function                                     old     new   delta
> chv_gpio_request_enable                      296     286     -10
> Total: Before=19199, After=19189, chg -0.05%
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

and here.
