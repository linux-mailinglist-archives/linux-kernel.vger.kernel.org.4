Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8C6AC357
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCFOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCFOcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:32:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065252CFFA;
        Mon,  6 Mar 2023 06:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678113143; x=1709649143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vtucr2yLpXVjxM6kKYdgM+VZU+5ECJriaQlTav+FrgA=;
  b=WhUF392g9usvhtBhoUoAaT/uMLM4jzZW2JKaEMEhQTX/47b4AgZKs/6H
   w58BCUE7Y9vqPP+xb2wfLrOzpsj7wcYIJkGXK+aroFOPORqJ1AtEUKyMz
   CgZTiepK/ovJyFnqx6ZYZXOExp458ZYlXAL8hAjulSmv2NpJNFG1PmcYM
   j3x7Z4LREUaQF1Et3ywFSkHdB9PnjJzqHfgGVHAw6oGW3wtw/LtrtFTo5
   K3nvF16BRx3RBOPntIBj74MOmfsmQwTl+RVoyjEcfROmpd5Y1DU6w7wF5
   K3LNuuLtg8/bBvg/NcAjgj2qZ59dAtsRIzX5KgOKcZanwW96nWlH2c1Tu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="323871046"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="323871046"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="740340842"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="740340842"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2023 06:20:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZBh6-00GTMN-09;
        Mon, 06 Mar 2023 16:20:04 +0200
Date:   Mon, 6 Mar 2023 16:20:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: Re: [PATCH v4 3/3] gpio: ws16c48: Migrate to the regmap API
Message-ID: <ZAX2k9gW1AA88T/P@smile.fi.intel.com>
References: <cover.1678106722.git.william.gray@linaro.org>
 <4b6cd42426521808962d68a44952b95818fc5daf.1678106722.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6cd42426521808962d68a44952b95818fc5daf.1678106722.git.william.gray@linaro.org>
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

On Mon, Mar 06, 2023 at 07:59:53AM -0500, William Breathitt Gray wrote:

...

> -	raw_spinlock_t lock;
> +	spinlock_t lock;

This is a regression.
That said, do we need a support of raw spin locks in the regmap IRQ?

...

> +	u8 irq_mask[WS16C48_NUM_IRQS / WS16C48_NGPIO_PER_REG];

Can this be a bitmap? Or is it too over engineered with it?

-- 
With Best Regards,
Andy Shevchenko


