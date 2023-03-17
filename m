Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489586BE8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCQMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:07:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA4A62FD6;
        Fri, 17 Mar 2023 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679054873; x=1710590873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vNLnjZikE4RdId1Cq2J9A17DtYNPqaFjScBpOb1vhXw=;
  b=aQTe3xGKWuo4KWV9mUkkL9Cfa1EIm1zZ41yleWZ2XGH8h4j7W7t0vnec
   1K6oYL3XF4NzkTEvz+oxAeXe1v9ivPjjB8QlhoL4sBqECdCOEOqCg9okA
   gapMyQlzubiOCGgJPk9XtKTxSWcfJC3qwF/XPEVOVKavcdxlpTynwo+p2
   46+ZxuqOlDBtgL6HVh/ApIMkMA9RlfrcWbT8f9EDa4MdAQtqcdQCZ/TIF
   CaYf7olQxImdO8/kBJCwfsw+CBjEvxJney6H6eng1OdCnocYBMM8qxPVa
   qgfoh8678XBsklLkFFU6iVuas7NLyVfs33yuthDcezBHfJJt4n+y9+bKh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="336944820"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="336944820"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 05:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="749233351"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="749233351"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2023 05:07:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pd8sA-0050nr-0Z;
        Fri, 17 Mar 2023 14:07:50 +0200
Date:   Fri, 17 Mar 2023 14:07:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
Message-ID: <ZBRYFb7iGSRsRvgT@smile.fi.intel.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679009443.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:48:34AM +0100, Mehdi Djait wrote:
> KX132 accelerometer is a sensor which:
> 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
> 	- can be connected to I2C or SPI
> 	- has internal HW FIFO buffer
> 	- supports various ODRs (output data rates)
> 
> The KX132 accelerometer is very similair to the KX022A. 
> One key difference is number of bits to report the number of data bytes that 
> have been stored in the sample buffer: 8 bits for KX022A vs 10 bits for KX132.
> 
> A complete list of differences is listed in [1]
> [1] https://kionixfs.azureedge.net/en/document/AN112-Transitioning-to-KX132-1211-Accelerometer.pdf1

Is it really the first version of this contribution?

-- 
With Best Regards,
Andy Shevchenko


