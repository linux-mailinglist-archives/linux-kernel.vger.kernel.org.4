Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11CC5E54CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIUU7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIUU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:59:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE236A285D;
        Wed, 21 Sep 2022 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663793948; x=1695329948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=okstNxHnKywUUm6/cGGyWmjLYuItLGJ2g7P+uU67io4=;
  b=mrwBT5o9oht96xyZ92SfCCf/+FTKIAdiku6UcD1In8UcUPWRtoSszeMJ
   qJmNS+a0+jvHCw3yeyjVEwnq4+T5gVJdV4PuIANidE+fxIwPN/3Zew+Hz
   YgchmiymrffBbWsNgnea5tTmw82r8IXU325qUr9nctNPekjaL5SZLO1Ux
   ZuCio+W4N5SgiEAdzRVm4DxcAfuxhlxBaMOWUFvDFDcCHt5T+FP+Wys7h
   dfsi6w1rKCF5tvsH2Lh2lpQmcQP5WkNn9PD0dLmZ4mUVdcgY16742dP3S
   aodu5DR7bS/1w/3AOIfrkiCW/bGaEudflFNHwpQ52UOk+jnOdSCHZed1S
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="361885412"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="361885412"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 13:59:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="681933472"
Received: from nchaplot-mobl1.amr.corp.intel.com (HELO [10.209.89.231]) ([10.209.89.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 13:59:07 -0700
Message-ID: <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
Date:   Wed, 21 Sep 2022 13:59:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        Sean Christopherson <seanjc@google.com>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
 <20220921200726.GA3094503@roeck-us.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220921200726.GA3094503@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 13:07, Guenter Roeck wrote:
> [    2.042861] CPA refuse W^X violation: 8000000000000063 -> 0000000000000063 range: 0x00000000c00a0000 - 0x00000000c00a0fff PFN a0
> ILLOPC: cbc65efa: 0f 0b
> [    2.043267] WARNING: CPU: 0 PID: 1 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0xdca/0xdd0
...
> [    2.050307] ---[ end trace 0000000000000000 ]---
> [    2.050762] PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
> [    2.051115] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [    2.051115] BUG: unable to handle page fault for address: c00fd2bf

This _looks_ like it is working as intended.  The PCI BIOS code tried to
make a RWX page.  The CPA code refused to do it and presumably returned
an error, leaving a RW page, non-executable page.  The PCI code didn't
check the set_memory_x() return code and tried to go execute anyway.
That resulted in the oops.

I was able to reproduce this pretty easily.  The workaround from dmesg
is pci=nobios.  That seems to do the trick for me, although that advise
was sandwiched between a warning and an oops, so not the easiest to find.

I'm a bit torn what to do on this one.  Breaking the boot is bad, but so
is leaving RWX memory around.

Thoughts?
