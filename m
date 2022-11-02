Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE76161611A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKBKou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiKBKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:44:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051C205C4;
        Wed,  2 Nov 2022 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667385879; x=1698921879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJ3Y4C/MhfSQfBxw7jsHZujVpv2WrFsLiudBIJN2Ldc=;
  b=OWBGsJf96lRmMc7p75l96dhq1t4BiIATbgnqkTvTeO0xHJCFf+KXqlRl
   o+7BOrf6jVZdyyIFblcEmzjbVzuq43yWtzRUao7FK3unenE6/VRLEuDvA
   nFadlna7TtHlWrjf2H3fXWOrY/zqpx1ClvNraiPWBy7tmO6s3lw6v8yA9
   xYxGWOAEql4OoSt4Wi/zNLc6dvfhK3AX+9qM1dVCal5A6iDi7XHGo+ewe
   rb50f0fWwh3eC3ct0tAqzjBnylWu5nsp3ARQOtNZkysV4MhnKNaQx6iiA
   YLJJWXyg9sD0i6LBb0co2cNEkYbUYOvnDdqcy+rNJr4j/+BLIHwP1PcAS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310477847"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="310477847"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:44:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776846592"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="776846592"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2022 03:44:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqBEY-0068Mu-2c;
        Wed, 02 Nov 2022 12:44:34 +0200
Date:   Wed, 2 Nov 2022 12:44:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] platform/x86/intel/sdsi: Support different GUIDs
Message-ID: <Y2JKEjSridtRubSm@smile.fi.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
 <20221101191023.4150315-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101191023.4150315-4-david.e.box@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 12:10:17PM -0700, David E. Box wrote:
> Newer versions of Intel On Demand hardware may have an expanded list of
> registers to support new features. The register layout is identified by a
> unique GUID that's read during driver probe. Add support for handling
> different GUIDs and add support for current GUIDs [1].

> [1] https://github.com/intel/intel-sdsi/blob/master/os-interface.rst

Link: tag?

...

>  #define SDSI_MIN_SIZE_DWORDS		276
> -#define SDSI_SIZE_CONTROL		8
>  #define SDSI_SIZE_MAILBOX		1024
> -#define SDSI_SIZE_REGS			72
> +#define SDSI_SIZE_REGS			80
>  #define SDSI_SIZE_CMD			sizeof(u64)

> +#define SDSI_SIZE_MAILBOX		1024

Why do you need this second time?

...

> +static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table *table)
> +{
> +	switch (table->guid) {
> +	case SDSI_GUID_V1:
> +		priv->control_size = 8;
> +		priv->registers_size = 72;
> +		break;
> +	case SDSI_GUID_V2:
> +		priv->control_size = 16;
> +		priv->registers_size = 80;

Maybe it makes sense to use previously defined constants here instead of magics?

> +		break;
> +	default:
> +		dev_err(priv->dev, "Unrecognized GUID 0x%x\n", table->guid);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


