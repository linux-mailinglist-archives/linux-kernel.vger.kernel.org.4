Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0616AA49C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjCCWix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjCCWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:38:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D651F5D9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677883011; x=1709419011;
  h=message-id:date:mime-version:to:from:cc:subject:
   content-transfer-encoding;
  bh=BoiuWKhvZS1dzlegB6iliDTkdESWTf6d4pcmrw3pTQg=;
  b=Phxhr4sL9H7xOTpkt3dFumWaR7zekkrc3SPo5dtOBPUWXMRdWOPkS/wf
   NnAg/BJtRBXlWmeRHuO2P4PaHbT6w1JkVN7yAj+yv8oxXzEC/MfYgc+Kg
   OBJt5vNtrjI0Asg8QEC760zaWvIP5GShN9MZK586Amyx0zZIR+RFWTgjk
   EGwgHoknMJ5PDhW/o/n1IDUEIuo+5Ul+4GuUvQcHbfkuXZu+VIuEM+2mG
   SWdnVe9UfVIdVMr2x4g8H3Sfgc27UzR+BMnxTu0BPmJMjpV7LfpkUNS+K
   OzOFVEfaO1csAMDxRoL+wKBORzfAwjM0y8CHmZQh3WXvpkDMU94kYYciX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399989543"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="399989543"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 14:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="675521485"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="675521485"
Received: from ctretbar-mobl.amr.corp.intel.com (HELO [10.212.170.209]) ([10.212.170.209])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 14:35:33 -0800
Message-ID: <299fbb80-e3ab-3b7c-3491-e85cac107930@intel.com>
Date:   Fri, 3 Mar 2023 14:35:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@google.com>
Subject: KASLR vs. KASAN on x86
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KASAN folks,

Currently, x86 disables (most) KASLR when KASAN is enabled:

> /*
>  * Apply no randomization if KASLR was disabled at boot or if KASAN
>  * is enabled. KASAN shadow mappings rely on regions being PGD aligned.
>  */
> static inline bool kaslr_memory_enabled(void)
> {
>         return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
> }

I'm a bit confused by this, though.  This code predates 5-level paging
so a PGD should be assumed to be 512G.  The kernel_randomize_memory()
granularity seems to be 1 TB, which *is* PGD-aligned.

Are KASAN and kernel_randomize_memory()/KASLR (modules and
cpu_entry_area randomization is separate) really incompatible?  Does
anyone have a more thorough explanation than that comment?

This isn't a big deal since KASAN is a debugging option after all.  But,
I'm trying to unravel why this:

>         if (kaslr_enabled()) {
>                 pr_emerg("Kernel Offset: 0x%lx from 0x%lx (relocation range: 0x%lx-0x%lx)\n",
>                          kaslr_offset(),
>                          __START_KERNEL,
>                          __START_KERNEL_map,
>                          MODULES_VADDR-1);

for instance uses kaslr_enabled() which includes just randomizing
module_load_offset, but *not* __START_KERNEL.  I think this case should
be using kaslr_memory_enabled() to match up with the check in
kernel_randomize_memory().  But this really boils down to what the
difference is between kaslr_memory_enabled() and kaslr_enabled().
