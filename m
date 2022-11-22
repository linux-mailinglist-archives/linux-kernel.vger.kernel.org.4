Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE2633803
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiKVJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiKVJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:10:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8947301
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669108221; x=1700644221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6RQ4LTvRRK2w7BXb9qoyDhzIpeCsuWxp5RxE8SxskPk=;
  b=eslBen0CUn9QzSWHh2E2jJO3PlJM9zmHTYhR/griG/7FzsKL4TcVzE4j
   jIwR7RWwigWS1U4usoVt0B5wSM2DIGUZxKZnK0s/+UQ/ZCfpS0tJSS1sc
   HsIOFFYpNzU88FL/VtGMt/6waeqIl0AZ+Iw2IHig7epWRHKh0LxIO8jEH
   Y6nxCpT012VmwQ7xNutQ0LKK8xJ7OdOjCsAZ0TP1bVjuj9vLv4LAdawJ9
   yjG348UrHA6rpMj0xLN/OX7QSxwZk2Ugtk/usho/+YZbOd+2upTknR3Eh
   A9QUSQHCdCIGXlI3r05Dhas6fFeDEDyyHXP/U2XvASmUHOTy1nIcyBnzZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="301320132"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="301320132"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:10:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="704899257"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="704899257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2022 01:10:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxPIG-00FgoH-1S;
        Tue, 22 Nov 2022 11:10:16 +0200
Date:   Tue, 22 Nov 2022 11:10:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     bigeasy@linutronix.de, robh@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Message-ID: <Y3yR+Ouc7l9RvB8K@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:39:07PM +0800, Rahul Tanwar wrote:
> Intel's APIC family of interrupt controllers support local APIC
> (lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
> & ioapic from text to YAML schema. Separate lapic & ioapic schemas.
> Addditionally, add description which was missing in text file and
> add few more required standard properties which were also missing
> in text file.

...

> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-ioapic.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel I/O Advanced Programmable Interrupt Controller (IO APIC)

> +maintainers:
> +  - Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I'm not sure, you need to have a confirmation before putting someone's name here.
Yours is easier to add.

> +description: |
> +  Intel's Advanced Programmable Interrupt Controller (APIC) is a
> +  family of interrupt controllers. The APIC is a split
> +  architecture design, with a local component (LAPIC) integrated
> +  into the processor itself and an external I/O APIC. Local APIC
> +  (lapic) receives interrupts from the processor's interrupt pins,
> +  from internal sources and from an external I/O APIC (ioapic).
> +  And it sends these to the processor core for handling.

> +  See https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf

Dunno if schema has special format for data sheet links...

> +  Chapter 8 for more details.
> +
> +  Many of the Intel's generic devices like hpet, ioapic, lapic have
> +  the ce4100 name in their compatible property names because they

> +  first appeared in CE4100 SoC. See bindings/x86/ce4100.txt for more

Shouldn't you change this?

> +  details on it.
> +
> +  This schema defines bindings for I/O APIC interrupt controller.

...

> +maintainers:
> +  - Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> +
> +
> +description: |
> +  Intel's Advanced Programmable Interrupt Controller (APIC) is a
> +  family of interrupt controllers. The APIC is a split
> +  architecture design, with a local component (LAPIC) integrated
> +  into the processor itself and an external I/O APIC. Local APIC
> +  (lapic) receives interrupts from the processor's interrupt pins,
> +  from internal sources and from an external I/O APIC (ioapic).
> +  And it sends these to the processor core for handling.
> +  See https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
> +  Chapter 8 for more details.
> +
> +  Many of the Intel's generic devices like hpet, ioapic, lapic have
> +  the ce4100 name in their compatible property names because they
> +  first appeared in CE4100 SoC. See bindings/x86/ce4100.txt for more
> +  details on it.
> +
> +  This schema defines bindings for local APIC interrupt controller.

Same two comments as per above.

-- 
With Best Regards,
Andy Shevchenko


