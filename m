Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171CF72CACA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbjFLP4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbjFLP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:56:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802FDCA;
        Mon, 12 Jun 2023 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585363; x=1718121363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3bEUjQ1to0LdMiTIveRka4/accmCyL64o9ed0zW8PI=;
  b=gnMsU8+fCrP8wwgIlS1ishp65QpbfJJAnVoEomnfMlixu3xM/gwnnLFF
   wnmA+8JPsE45NpMA7EYotpbZ290pQyZsIfhKa8d3X+JDgi+SvvKY6kfSq
   sjBswEj8Qyd98XUpL7x7mn+vKhr6d53I6Bah/3Fn80qMd2goLB7L9qczM
   Ou88IJJa2m1N21Y2/aDmp5AxJ9SlUXXflKsxvQoFESvx428QZxQ8I5pHQ
   dgV0NjJnV7HZKgUnrTyxuxYmIUs7hgJLtK/xFyGZ18bytyg6Z2jceyFTE
   6kbjS9k+0y4YiizYtqq6M7U9RmGeA72zlq7ijaw4dvLAEcFrGhHHV+chE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386472754"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="386472754"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="781264000"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="781264000"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2023 08:56:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jtf-0039Vn-1w;
        Mon, 12 Jun 2023 18:55:59 +0300
Date:   Mon, 12 Jun 2023 18:55:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZIdAD/yA0LuauNun@smile.fi.intel.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
 <d09d2c60053158cc85147641eaf7bdce38ede66d.1686578554.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09d2c60053158cc85147641eaf7bdce38ede66d.1686578554.git.mehdi.djait.k@gmail.com>
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

On Mon, Jun 12, 2023 at 04:22:09PM +0200, Mehdi Djait wrote:
> Since Kionix accelerometers use various numbers of bits to report data, a
> device-specific function is required.
> Implement the function as a callback in the device-specific chip_info structure

...

> +static int kx022a_get_fifo_bytes(struct kx022a_data *data)
> +{
> +	int ret, fifo_bytes;
> +
> +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> +	if (ret) {
> +		dev_err(data->dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)

> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;

You can return this constant directly.

> +	return fifo_bytes;
> +}

-- 
With Best Regards,
Andy Shevchenko


