Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5C6C11E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjCTM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjCTM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:28:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67999F774;
        Mon, 20 Mar 2023 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679315316; x=1710851316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CbVcOZqtXR8vUv9FtTu9RwPSlg9/R6QPP9oi+nsyhGg=;
  b=iXJJoMfI+tjz2yZq3DDMhfBbJlxD1caVlo1WcnZijAEOGxKPAym8zNpm
   Er7MFQNjFwyw7FPdWkDo8QGdP28D9+s1jyGLxr+9S5kdp6YtfTNNsMAfj
   sEBQyQjTdp+qS7CxVdUmT97A9XgZ06rMmK6ZVDAyeHzdnC7ckEYsKId+e
   fkwt/uK81sPqx6XZ3mUND1JR10uiMm/ipVLbGNvzz8W6AhCV5LLpuP2aj
   nDoY666Ms4YzIrDxsxiqEuZtD4CLz8BoK7FzpPLq5wNZ32LsGV5qvu8Vb
   CLcrKuLUTw0HhpQK2dAl/cNo0omVLRGNJacYbWaz2ocuXXVMyx2RlyL+B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="337365190"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="337365190"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 05:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="824461816"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="824461816"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2023 05:28:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peEcp-006GRm-1H;
        Mon, 20 Mar 2023 14:28:31 +0200
Date:   Mon, 20 Mar 2023 14:28:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZBhRb+v/8+vSwjz6@smile.fi.intel.com>
References: <cover.1679149542.git.william.gray@linaro.org>
 <71496f9295e68388ce07f3051bf5882177be83c5.1679149543.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71496f9295e68388ce07f3051bf5882177be83c5.1679149543.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 10:59:51AM -0400, William Breathitt Gray wrote:
> The Preset Register (PR), Flag Register (FLAG), and Filter Clock
> Prescaler (PSC) have common usage patterns. Wrap up such usage into
> dedicated functions to improve code clarity.

...

> +static void quad8_preset_register_set(struct quad8 *const priv, const size_t id,
> +				      const unsigned long preset)
> +{
> +	struct channel_reg __iomem *const chan = priv->reg->channel + id;
> +	int i;
> +
> +	/* Reset Byte Pointer */
> +	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
> +
> +	/* Set Preset Register */
> +	for (i = 0; i < 3; i++)
> +		iowrite8(preset >> (8 * i), &chan->data);
> +}

May we add generic __iowrite8_copy() / __ioread8_copy() instead?

It seems that even current __ioread32_copy() and __iowrite32_copy() has to
be amended to support IO.

-- 
With Best Regards,
Andy Shevchenko


