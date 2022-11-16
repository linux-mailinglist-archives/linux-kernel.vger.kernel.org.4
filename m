Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5458762BA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiKPKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbiKPKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:53:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970B56572;
        Wed, 16 Nov 2022 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668595356; x=1700131356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AbTmtEPvkOM3n+TxYy670hFEqjcGp/xBnFYxhsbQLGw=;
  b=I9keWFvm4n/NUIGD8xKPtcWWc0eQtywx2eBy+bTmFT1uo/yo8ec9JcXR
   MB97zuTMQQCRQPnzaquKH/+whqnZ2h7BgWhIPQsn4hA+41eIp1lPfwrAe
   +G/xiYbKAZBRu6yVF0ew/9a8BZTBwjnWPHBmdubhVvVDBGsL1DE0oBoJZ
   DQY52qxerVkf29ZDGprbaeUahMLa4TdJ5yoDwjTbWk6QW4MXQoMC9qKQR
   JzQw6/vpdOG9OkkqPr9qI7k6tIzmHbYp1DxmSEeVJFGNJIbC8yKiscNj4
   bUwIUBPzIZ9QA5+A2M77ozJOCfk2N/QHnryPK+VPdl1poIfWHE7YEsrnz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339325438"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="339325438"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 02:42:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672350117"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="672350117"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2022 02:42:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovFsD-00D5jS-0Z;
        Wed, 16 Nov 2022 12:42:29 +0200
Date:   Wed, 16 Nov 2022 12:42:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     devicetree@vger.kernel.org, robh@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        alan@lxorguk.ukuu.org.uk, dirk.brandewie@gmail.com,
        grant.likely@secretlab.ca, sodaville@linutronix.de,
        devicetree-discuss@lists.ozlabs.org, linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v2 1/2] x86/of: Add support for boot time interrupt
 delivery mode configuration
Message-ID: <Y3S+lLzcmytKHLRq@smile.fi.intel.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
 <9114810c7af7fbaf9d0b2823752afcef865bdda0.1668589253.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9114810c7af7fbaf9d0b2823752afcef865bdda0.1668589253.git.rtanwar@maxlinear.com>
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

On Wed, Nov 16, 2022 at 06:28:20PM +0800, Rahul Tanwar wrote:
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
> structure [1].
> 
> Defaults to legacy PIC mode if absent. Configures it to virtual
> wire compatibility mode if present.

> [1] https://www.manualslib.com/manual/77733/Intel-Multiprocessor.html?page=40#manual

Link: ?

...

> +	if (of_property_read_bool(dn, "intel,virtual-wire-mode")) {

You need a separate patch to show this property being added (yes,
I have just commented on your patch 2).

> +		printk(KERN_NOTICE "Virtual Wire compatibility mode.\n");
> +		pic_mode = 0;
> +	} else {
> +		printk(KERN_NOTICE "IMCR and PIC compatibility mode.\n");
> +		pic_mode = 1;

Why not pr_notice()  in both cases?

> +	}

-- 
With Best Regards,
Andy Shevchenko


