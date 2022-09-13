Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCA55B78CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIMRtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiIMRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:48:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A96582F;
        Tue, 13 Sep 2022 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663087603; x=1694623603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fc6kEHNTUMdgAG0K4WZBBRY7ye92NWQr9HXY98MxtQw=;
  b=V2cd43w0Vv3tqXE3e8rb5cULFwY+MF3ObIpNpzLVNxT7Eri1Mejem1L5
   M+HLYEDrAIxhS7mIyKlSQ46wzET/1ZfVDaJ103Y8hrWeJKWv4XrIIe2Q/
   5kBY3/3vWo/0nXhJ2UBEkCSzXDBwlz/vURDXlpY6AHW4AyouAv/6bND/9
   uWvaOdDg2xrSbse6hEmvKRWMDy98nre8500jBriBM0UP6ebwSoFKxN/Px
   m7sH2bow5FA5j6NUTXyAFmBGfd7wbu+Osx76zXs79KYK853i9hdmTN/Mn
   IVO0w6RI39KwlnheXQLziEJCRlGPIRh+r+Qsm88jRe40WJ9/lWekCWkB1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="277922645"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="277922645"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:46:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="649726016"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:46:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oY93V-001qVR-10;
        Tue, 13 Sep 2022 19:46:37 +0300
Date:   Tue, 13 Sep 2022 19:46:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/9] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <YyCz7HR+0xsyw21M@smile.fi.intel.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
 <f1da2a2f1bc5bb083f318335c23b4f3d9bb8e536.1663025017.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1da2a2f1bc5bb083f318335c23b4f3d9bb8e536.1663025017.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 01:52:13AM +0200, Angel Iglesias wrote:
> Adds compatibility with the new generation of this sensor, the BMP380.
> 
> Includes basic sensor initialization to do pressure and temp
> measurements and allows tuning oversampling settings for each channel.
> 
> The compensation algorithms are adapted from the device datasheet and
> the repository https://github.com/BoschSensortec/BMP3-Sensor-API.

...

>   * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
>   * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
>   * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
> + * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
>   */

Shouldn't it be based on your patch to fix the links?

-- 
With Best Regards,
Andy Shevchenko


