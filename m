Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730AB6F6DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjEDOih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjEDOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:38:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB2129
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683211113; x=1714747113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yscE/EXxIs3ILhu3Zi/w5fu3RtSME8+868CDgimHdJg=;
  b=bqttr95WctuKQC+Z7DydJS7Nfk+dDVyjM2VQ9MGjctorN7emhTzxL6Em
   iWifaDKdz/qw4NpVArxARE6MIEasW8627rUgbcjx9/N+DWZQ3y58aa1Ah
   kZVIbnsCqvQPfl5Bmp8NT72OpdoTnCirZ7aNPjp2QhJsZKPPtR54t83CQ
   BGrlSzfBkujkXBajRlY6Xw5R7qqtTnzSi71kIb5fWH4pickVImhwYVyES
   BSX49H2ZvgUtei5ut8gr0JLCPe3/gAqOCYk8TSjmEoyvWR4je5efGv5WN
   0ljnN+lvZpXkqIdXz/AjlNv6Fsdc7hJZjzC4ezTV/r+vYxedYblm/DvN6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="346420587"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="346420587"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 07:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="808745880"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="808745880"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2023 07:38:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pua6G-0095oy-0R;
        Thu, 04 May 2023 17:38:28 +0300
Date:   Thu, 4 May 2023 17:38:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        hdegoede@redhat.com, jgg@ziepe.ca, saravanak@google.com,
        keescook@chromium.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] devres: provide API devm_kstrndup
Message-ID: <ZFPDYwa8ko6ZUEEL@smile.fi.intel.com>
References: <20230504075754.372780-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504075754.372780-1-peng.fan@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 03:57:54PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patch introduces devm_kstrndup API so that the
> device's driver can allocate memory and copy string.

...

> +char *devm_kstrndup(struct device *dev, const char *s, size_t max, gfp_t gfp)
> +{
> +	size_t len;
> +	char *buf;
> +
> +	if (!s)
> +		return NULL;
> +
> +	len = strnlen(s, max);

> +	buf = devm_kmalloc(dev, len + 1, gfp);
> +	if (buf) {
> +		memcpy(buf, s, len);

besides this to be open coded devm_kmemdup()

> +		buf[len] = '\0';
> +	}
> +	return buf;
> +}

you can always use devm_add_action_or_reset() for a single user before
we introduce a new wide API.

-- 
With Best Regards,
Andy Shevchenko


