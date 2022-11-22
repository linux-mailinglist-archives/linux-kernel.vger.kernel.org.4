Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90FF63381C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiKVJOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiKVJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:14:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D46A490A2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669108463; x=1700644463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dyyb6T2FF4wNQFOAKOH3RVlIgz0ShxAYmBVBgL6goeo=;
  b=BimsSOpmMZ+KzoeqPNuaXCY7x4Cf82k8hOmUOnWra1OiSX4AMRssSbbC
   j6+2avilPblFgNL+tnfc18D+9RRWPhNFNlRHvKxgIrXwvZMXr2jgPxhq3
   LSRUcA7gbmJ7TpAR8cYMz7mNp+fy2R7QyTDrU+9wKcn0ggGcXPoTc16Og
   ab8T+RQPmXLX5WzMnNG2+O6osIZDYDAam0BzgsA1SAjDMFFPxWJ6yyXoW
   PrVB2gHN2o/eWFD3VGWFxzgM6aUec8M0p4oZ9k5zwFBjF5pxnpAtDPTY7
   xwPLm6ALcVa+a0G70zY9TFJyu344vuCNM49lMiP8xXdYpRK0cQXHOUmMt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340639755"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="340639755"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672419094"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="672419094"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 01:14:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxPM9-00FgsZ-24;
        Tue, 22 Nov 2022 11:14:17 +0200
Date:   Tue, 22 Nov 2022 11:14:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     bigeasy@linutronix.de, robh@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v3 4/4] x86/of: Add support for boot time interrupt
 delivery mode configuration
Message-ID: <Y3yS6fCIl+0nsbOj@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <c62b81d5b91514e905d97e37feff6920f598e0ac.1669100394.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62b81d5b91514e905d97e37feff6920f598e0ac.1669100394.git.rtanwar@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:39:10PM +0800, Rahul Tanwar wrote:
> Presently, init/boot time interrupt delivery mode is enumerated
> only for ACPI enabled systems by parsing MADT table or for older
> systems by parsing MP table. But for OF based x86 systems, it is
> assumed & hardcoded to legacy PIC mode. This is a bug for
> platforms which are OF based but do not use 8259 compliant legacy
> PIC interrupt controller. Such platforms can not even boot because
> of this bug/hardcoding.
> 
> Fix this bug by adding support for configuration of init time
> interrupt delivery mode for x86 OF based systems by introducing a
> new optional boolean property 'intel,virtual-wire-mode' for
> interrupt-controller node of local APIC. This property emulates
> IMCRP Bit 7 of MP feature info byte 2 of MP floating pointer
> structure.
> 
> Defaults to legacy PIC mode if absent. Configures it to virtual
> wire compatibility mode if present.

> Fixes: 3879a6f32948 ("x86: dtb: Add early parsing of IO_APIC")

If it was never working, there is nothing to fix.
OTOH, without Cc: stable@ this is up to stable maintainers to
backport.


> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I definitely haven't suggested this fix.

...

The code looks good to me.

-- 
With Best Regards,
Andy Shevchenko


