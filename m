Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826C2680DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbjA3M3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbjA3M3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:29:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA82685F;
        Mon, 30 Jan 2023 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675081773; x=1706617773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GTJ6w3MJ1SfsvWS4BfXt9H5te7g7wWNJybMqFlzag0I=;
  b=DwAzY7g74/yMxT7CKQT8mDsUjxw6rzmZH1DbIPHBObnCYmFkgqa793ZT
   Cvc1T17Pypy59EGwMDl3bpzdVzpMvnHcojNww2R7pqNc8NC1eEWlGHCCH
   ttUZetzkTRezgu5RurkKsewRwMDG4CiQ1ZbGY4lQ7SEKS4JsciEEZ7iYo
   T3Y9WgbHBNv+49KOVW/qJBTLGTa+cu3B0BYurj49R5JnMv7PL65PadZm4
   tUigKNGuvQnolENe6KsHtNoiupkJS11lV20n6ohX8+1V8hoQ3kvaS1o7z
   06zwHpwS5zcJ3TFRq001WSucXlN6vYTozCIMq/mf8iEca2kFvbDbLzapc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="325241052"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="325241052"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="752803767"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="752803767"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2023 04:29:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMTHs-00HLRv-1r;
        Mon, 30 Jan 2023 14:29:28 +0200
Date:   Mon, 30 Jan 2023 14:29:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: pressure: bmp280: Add nvmem operations for
 BMP580
Message-ID: <Y9e4KFhB2E6E4EQb@smile.fi.intel.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
 <013686653a60092227c842ae2fd0197f2509ad7c.1674954271.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013686653a60092227c842ae2fd0197f2509ad7c.1674954271.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 02:33:09AM +0100, Angel Iglesias wrote:
> The pressure sensor BMP580 contains a non-volatile memory that stores
> trimming and configuration params. That memory provides an programmable
> user range of three 2-byte words.

...

> +#define NVM_READ	false
> +#define NVM_WRITE	true

How is it helpful and why it's not namespaced properly (can collide with
NVM framework)?

...

> +	/* Wait until NVM is ready again */
> +	do {
> +		ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
> +		if (ret) {
> +			dev_err(data->dev, "failed to check nvm status\n");
> +			reg &= ~BMP580_STATUS_NVM_RDY_MASK;
> +		}
> +	} while (time_before(jiffies, deadline) && !(reg & BMP580_STATUS_NVM_RDY_MASK));

regmap_read_poll_timeout()?

> +	if (!(reg & BMP580_STATUS_NVM_RDY_MASK)) {

	if (ret) {
		...
		return ret;
	}

> +		dev_err(data->dev,
> +			"reached timeout waiting for nvm operation completion\n");
> +		return -ETIMEDOUT;
> +	}

...

> +	while (bytes >= sizeof(u16)) {

sizeof(*dst) ?

Or sizeof(data->le16)?

> +		addr = bmp580_nvmem_addrs[offset / sizeof(u16)];

Ditto.

...

> +		bytes -= sizeof(u16);
> +		offset += sizeof(u16);

Ditto.

> +	}

...

> +static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{

Same comments as per above function.

>  }


-- 
With Best Regards,
Andy Shevchenko


