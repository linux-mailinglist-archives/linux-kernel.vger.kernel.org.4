Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6005372E6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbjFMPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbjFMPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:12:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC57D1991;
        Tue, 13 Jun 2023 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686669166; x=1718205166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oxh0515ME/4fPMSsCbIUJTNENfWdQwc2a7pCGR+KUNE=;
  b=OISHmMY9DXt5qo74Xu94Gqc/P3Mn8fMNoJfgTIB+rEX5k+jVi1Vo+yer
   7Xwr8qrV1EVmEtuQ3XO0Jv2P7V0foDnfQMIaDEHfYfQlSkWjCf1zQF4Pz
   8A5AoJEHLb17NVXsZZhnid4Ax/VtXdrzQzx45usaaxdh7B15pScY2UupR
   fKTJiLZ5808ATVKMs+DOuX1RLXsuPup0QbVwbZld6h05eDv27EcpX2Heq
   qpeJo8vfNbBKyGgal/S/McoRdnJLhcjQgouQTDQjjZKQ5qjgCh3gQDe6F
   wmqDTfK+6nZttRY+BXmaD4PmW3MVoRMOdzyYelgPYnkCM+NMvgvbmOh2w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361730934"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="361730934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824427345"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="824427345"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 08:12:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1q95hJ-003U4D-0H;
        Tue, 13 Jun 2023 18:12:41 +0300
Date:   Tue, 13 Jun 2023 18:12:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        ilpo.jarvinen@linux.intel.com, pali@kernel.org,
        hdegoede@redhat.com, markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Message-ID: <ZIiHaEn7nW7yAFK8@smile.fi.intel.com>
References: <20230613084310.2775896-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230613084310.2775896-1-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:43:10AM +0300, Michal Wilczynski wrote:
> Currently rbtn_add() in case of failure is leaking resources. Fix this
> by adding a proper rollback. Move devm_kzalloc() before rbtn_acquire(),
> so it doesn't require rollback in case of failure. While at it, remove
> unnecessary assignment of NULL to device->driver_data and unnecessary
> whitespace, plus add a break for the default case in a switch.

> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Isn't also suggested by Pali?

> Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

...

Hans, can it (an additional tag) be folded into applied change?

-- 
With Best Regards,
Andy Shevchenko


