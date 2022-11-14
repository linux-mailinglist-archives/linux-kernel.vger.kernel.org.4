Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7960627948
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiKNJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiKNJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:44:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1BE192B9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668419093; x=1699955093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+osEQXoiJBf0MZvRowkYittMGqBgYA9xXQM/C9Gmrh0=;
  b=WZpiZ086fZYftwYK972r2K3ct3Lsk4L9078FFTH+sS7mbQmAc809TzBw
   2Yo+XKTvtnMPegNLJFJ2bi7+qh6BjmLOT1mRCIEpVzMH4EcUetwKfFe/l
   CZ6ai57185evoYxyG55MtcpOcNMVMGLUdXLIgJfMP9A/4SSAPwob7tJEc
   2sYymDfNs6WMKkQyOzmZjEeZnbjezUTGj1mAHLfy2k0qu60RR+3xO8Vzw
   BRfMVAhy5k/hT326eeD+7qGpCVZEi91CAWqTivScCUQG7L/2f+r9nbS3x
   NMXC52+Y7lk2kbvF49GlaMuxL5l+hV3O/v8QV5o3lQ7//6Vewwv/9QE8w
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="398218203"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="398218203"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="669581800"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="669581800"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 14 Nov 2022 01:44:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouW1I-00C6Py-1t;
        Mon, 14 Nov 2022 11:44:48 +0200
Date:   Mon, 14 Nov 2022 11:44:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     bigeasy@linutronix.de, robh@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH RESEND 1/1] x86/of: Add support for boot time interrupt
 mode config
Message-ID: <Y3IOEFTZ1e/7uWJ4@smile.fi.intel.com>
References: <cover.1668403214.git.rtanwar@maxlinear.com>
 <37cc31242d0edda1bb0900cc62bba87954a7e892.1668403214.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37cc31242d0edda1bb0900cc62bba87954a7e892.1668403214.git.rtanwar@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:20:06PM +0800, Rahul Tanwar wrote:
> Presently, init/boot time interrupt delivery mode is enumerated only
> for ACPI enabled systems by parsing MADT table or for older systems
> by parsing MP table. But for OF based x86 systems, it is assumed &
> fixed to legacy PIC mode.
> 
> Add support for configuration of init time interrupt delivery mode for
> x86 OF based systems by introducing a new optional boolean property
> 'intel,no-imcr' for interrupt-controller node of local APIC. This
> property emulates IMCRP Bit 7 of MP feature info byte 2 of MP
> floating pointer structure.
> 
> Defaults to legacy PIC mode if absent. Configures it to virtual wire
> compatibility mode if present.

...

> +	if (of_property_read_bool(dn, "intel,no-imcr")) {

I can't find this property in the Documentation/devicetree/bindings.

Moreover, I prefer to see positive one, something like:

	intel,virtual-wire-bla-bla-bla

Please consult with DT people on how properly name it.

> +		pr_info("    Virtual Wire compatibility mode.\n");
> +		pic_mode = 0;
> +	} else {
> +		pr_info("    IMCR and PIC compatibility mode.\n");
> +		pic_mode = 1;
> +	}

-- 
With Best Regards,
Andy Shevchenko


