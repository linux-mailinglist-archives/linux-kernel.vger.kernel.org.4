Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E015A5F110E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiI3Rmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiI3RmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:42:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34848170B31;
        Fri, 30 Sep 2022 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664559742; x=1696095742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frSbyhVpNySk0Rm2XauruAvwsaf78K6x1ptT3JAqffg=;
  b=aEb2kuuB9miBdiVLvp2GLtfp7dtUC8Ne55OL3dJlZgfoUM3Q57csA3hB
   o5Y2UEcPrmdbmtNi55aCqohQu7yVMl5DFYjQhVJBKt4iYhsIqeZdBXxf9
   gc1F23/4/JN5GY3ZVh7htOc8ZQB8leGZVoUAhpb6fFfNJPh7PfCbNMxtQ
   vRHKw+JXNkuaGb5AjeicWWQdlmmpQ9rTLMkEoQdrve52sD+ttVyuKFhLC
   829wbFZZbPtrUSoT/H97iCf5+x/YwSwvSwyGCLXarXR85U8RaodorzwN+
   Lll1EctihlUic1M6U6F4lWItGmPuB/iNUPiH/HHqJHGjI3RZEFYOQB7nU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="303735843"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="303735843"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 10:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="685367753"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="685367753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2022 10:42:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oeK1e-000d1L-0Y;
        Fri, 30 Sep 2022 20:42:14 +0300
Date:   Fri, 30 Sep 2022 20:42:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul Rangel <rrangel@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to
 acpi_dev_irq_flags
Message-ID: <YzcqdTxLMF5028yz@smile.fi.intel.com>
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
 <YzYowYJpRTImmg4m@google.com>
 <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 07:13:37PM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:

...

> I think that patches [5-8/13] from this series are significant
> framework changes, so it would make sense to route them via the ACPI
> tree.
> 
> If this is fine with everybody, I will queue them up for merging into
> 6.1 (probably in the second half of the upcoming merge window).

I believe it's fine from GPIO ACPI perspective (there shouldn't be conflict,
but if you wish you always may take this PR [1] to your tree (it's already in
GPIO tree pending v6.1), it may be considered as immutable tag.

[1]: https://lore.kernel.org/linux-gpio/Yym%2Fj+Y9MBOIhWtK@black.fi.intel.com/

-- 
With Best Regards,
Andy Shevchenko


