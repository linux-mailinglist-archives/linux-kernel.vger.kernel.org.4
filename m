Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC52872CA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbjFLPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbjFLPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:44:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7E10E2;
        Mon, 12 Jun 2023 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686584682; x=1718120682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mA/68H48x8hWu82F/Ja97GwHQawxRn+pP/gPATMBwfY=;
  b=e1FZX8dknvYDf0KoAujqjePprGptrwOl56El7kl5L4EIpQXSEKvw+ZFq
   Qc54oUDRC+WW9KyAZ+ICHrWWbXNVOMqnW0ap7utulbpE66EZe6Ayjmnae
   LXisPQhFQC4tPKLqucQxve4gmiZyeX3kvYIRQAV6IWJvRaVsZhT1UujOO
   plFnr4ycNeBxoA8RxfXkFxminSWhpTNbLsNKkWfFzsAyDlk8Eo6bFWqrJ
   UEx5Pc9MOn1d5kpWdR1G29NfWxKvgDOMxkQwR24cJr/GLgL225kL+TXDn
   HLBvT0YjFoCUFn3VxwORZTcEuBtIj4J5QnUZ2W23uKeHfXoFAwMr4NGI3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="423961618"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="423961618"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:44:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688680173"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="688680173"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2023 08:44:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jif-0039ON-1M;
        Mon, 12 Jun 2023 18:44:37 +0300
Date:   Mon, 12 Jun 2023 18:44:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] rtc: isl12022: add support for trip level DT bindings
Message-ID: <ZIc9ZUsEt+KNaiKD@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113059.247275-5-linux@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 01:30:54PM +0200, Rasmus Villemoes wrote:
> Implement support for using the values given in the
> isil,trip-level[87]5-microvolt properties to set appropriate values in
> the VB[87]5TP bits in the PWR_VBAT register.

...

> +	for (x85 = 0; x85 < ARRAY_SIZE(trip_level85) - 1; ++x85)
> +		if (level85 <= trip_level85[x85])
> +			break;
> +
> +	for (x75 = 0; x75 < ARRAY_SIZE(trip_level75) - 1; ++x75)
> +		if (level75 <= trip_level75[x75])
> +			break;

Does preincrement give us anything in comparison to postincrement?

-- 
With Best Regards,
Andy Shevchenko


