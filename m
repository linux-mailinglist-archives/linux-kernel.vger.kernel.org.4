Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15D7279A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjFHIKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjFHIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:10:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217D2139;
        Thu,  8 Jun 2023 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686211817; x=1717747817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2VSNd7BM9yQB3Ojk2ngdB69CDz91byt8YSHBWP9alw=;
  b=TBx33opxvsRCY15O8xdQvN8RRITXpCW6xXGFCc78PXeompFoMZzNONqi
   Qxdo7otxXqT2Jzz9bj+snOJ4pRsE7nK4lo5PwDZVfjbyB+xQl3AZow1iS
   CFuzY/P76A8S9BogLTaBeYAowYAQQhTM+F2SZs1R6jul/frjW/QasLjZM
   IOcrpWG0nYFzo1ydlThsv7AQjZ3H7A9/5Gw3mfHWGm5cXnYtTl/EEcchs
   Lrddenb0nifqc9oyW6zRr3YLoEDthekqlAoOAzVpPFyhH5J1WQBw3h1RZ
   hUw9Hy3OsjJbZsdzgRQfhBBYrxeO3OoTPB8E9nBbNS/Iolh6zTBzZWjEO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337600459"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="337600459"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="713025956"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="713025956"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 01:09:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 637A134F; Thu,  8 Jun 2023 11:09:31 +0300 (EEST)
Date:   Thu, 8 Jun 2023 11:09:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 3/4] pinctrl: intel: simplify exit path of set_mux hook
Message-ID: <20230608080931.GG45886@black.fi.intel.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
 <20230608070017.28072-4-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608070017.28072-4-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:30:16PM +0530, Raag Jadav wrote:
> Simplify exit path of ->set_mux() hook and save a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-22 (-22)
> Function                                     old     new   delta
> intel_pinmux_set_mux                         242     220     -22
> Total: Before=10453, After=10431, chg -0.21%
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index 3f78066b1837..1b5745202058 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -393,7 +393,10 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
>  	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>  	const struct intel_pingroup *grp = &pctrl->soc->groups[group];
>  	unsigned long flags;
> -	int i;
> +	int i, ret;
> +
> +	/* In case we never really enter any of the below loops */
> +	ret = 0;

How can that happen?
