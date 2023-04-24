Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD56ED0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjDXPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjDXPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:09:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B0B5;
        Mon, 24 Apr 2023 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682348961; x=1713884961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DFwbhVwB3qAZzM1M6A2mywZtxGqtlDkuA98FUDSiHUI=;
  b=H18WC9QSVbZDeNdSpDJaGW3snciIOwZeKCZNgYMLwzjnknsoHTzSyRwv
   mIjFi8sVYlozr1yvMc755G85p9DuxYqKOU5ZUeAhYjuBzMThwONNJXYiK
   BMNW1a9rpVsHYTYaq91kqiqUVJQ0jOMKrmdGvRkPxugtzMGh3fgYUoG3M
   GZqPwqgHJpXtZwpB0rGqy77VrlCM67GK4AUYfckNJysSlYUXPfY4coL+Y
   XtLJC6JqgLg9QHBwRAG9oGCyQsg2vDTcZmjSfbSc8bzpeM5BcgwP9fUni
   nFjsgK2NNpendDQdtA375PU/k2xbatdn5rogznpWkHPSYYA8hti8wEAJp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326087209"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326087209"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="695807913"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="695807913"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 24 Apr 2023 08:08:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pqxnr-004Z7o-2i;
        Mon, 24 Apr 2023 18:08:31 +0300
Date:   Mon, 24 Apr 2023 18:08:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio:trigger: Add simple trigger_validation helper
Message-ID: <ZEabb3lJzGNb/BMO@smile.fi.intel.com>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <91fffd0001e8efef90f43fa03026dc0e5e30b4e4.1682340947.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91fffd0001e8efef90f43fa03026dc0e5e30b4e4.1682340947.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 04:08:19PM +0300, Matti Vaittinen wrote:
> Some triggers can only be attached to the IIO device that corresponds to
> the same physical device. Implement generic helper which can be used as
> a validate_trigger callback for such devices.

Missing space in the Subject?

-- 
With Best Regards,
Andy Shevchenko


