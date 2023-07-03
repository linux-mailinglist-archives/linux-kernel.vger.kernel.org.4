Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26197745F37
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGCO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:57:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A6E42;
        Mon,  3 Jul 2023 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688396220; x=1719932220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aOA/niQKcCZkM1rgJCS0UVrH0z4BabtgnywIhgk6Au4=;
  b=OBSrlVYmsqWOOIcirtpu+dV34GLu+25iEAHZQIOF4tb0pYNPDdO7bkz/
   L5/WuKjGnOLyKFqgMe0chQigcIjZuv5eTfjwOhyqMZsL068581mhRUw7A
   0jfzQrL4XptgT93XHaa7RPOdJrl9QdYQocpuOfduENvZXtK4+D77bLmEO
   TTtkcWKL6ED6LP0AMHUmesUDiAy7Ca+MRQ1QkmtDrAIuUbOKwO0yzM2PK
   BjmSWnlhpk51Z9j/Cdrs4K/WwcyE0gyNsuwwDjo5q3sN6e0TDr66hCihp
   9+TLS5TxyDmesIpaTT4ngRHQc8Kpf7kh7glNXDqBGuiazrNeQhO2Q0NHv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="365473205"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="365473205"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808614089"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="808614089"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2023 07:56:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGKz1-001tMw-0C;
        Mon, 03 Jul 2023 17:56:55 +0300
Date:   Mon, 3 Jul 2023 17:56:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH v2 2/3] gpiolib: acpi: Don't use GPIO chip fwnode in
 acpi_gpiochip_find()
Message-ID: <ZKLhtsVBxqEsr1FT@smile.fi.intel.com>
References: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
 <20230703142308.5772-3-andriy.shevchenko@linux.intel.com>
 <CAO-hwJ+HPLe3XQuGtbZT2wky4wMRpR2kVWj3-euCrrQRkpoVBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJ+HPLe3XQuGtbZT2wky4wMRpR2kVWj3-euCrrQRkpoVBg@mail.gmail.com>
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

On Mon, Jul 03, 2023 at 04:43:05PM +0200, Benjamin Tissoires wrote:
> On Mon, Jul 3, 2023 at 4:29 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> > -       return ACPI_HANDLE_FWNODE(gc->fwnode) == data;
> > +       return device_match_acpi_handle(&gc->gpiodev->dev, data);
> 
> Quick confirmation that using "device_match_acpi_handle" also works in
> v2 (was easy enough to test given that everything was already set up
> locally).

Thank you! I would be very surprised if not :-)

-- 
With Best Regards,
Andy Shevchenko


