Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD571EF6B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjFAQqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFAQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:46:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3CA195;
        Thu,  1 Jun 2023 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685637959; x=1717173959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iDL6LVNWKZBuZvvnqj/X3vGXzRQAR73q49VVn7ziVp0=;
  b=nJlhZ5IHgjL8o8J/ql3asMRn+gNDZsIDjLRnNE1WFYx9nA78dGprQKOo
   HeHUd5O2vOLjkkVWiUZCdECHGymdryRwMwMxJHoDNCA4Xh8qTo9Rvlxep
   lsZ3E2C2/0kxYxHOOyDF4p1Lk7lfmR7pzys2km0gp5MTBG0Nec+HtNiIO
   vUuKXZxRa3Gf2tPs4hGJscvhPaGvP1V7tQUkzacC3mG7h2X8E7B7IATLb
   UAb6Oir14dJ81KWZthRY1xzfwJZ1Ht2VxKYgkSUqJ09HvnqQ8hCIdyXw/
   Lp105XooDWw6vGlFIJsa/S54yES8vaLMvmiB8F5Hitf/63iUv1CmxvxVh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358037897"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358037897"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="701621225"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="701621225"
Received: from jdboswor-mobl.amr.corp.intel.com (HELO [10.212.227.45]) ([10.212.227.45])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:45:57 -0700
Message-ID: <3c67fdd6-bce9-f695-a6c5-0fe9209bd3e4@intel.com>
Date:   Thu, 1 Jun 2023 09:45:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/purgatory: Do not use fortified string functions
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        =?UTF-8?Q?Joan_Bruguera_Mic=c3=b3?= <joanbrugueram@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alyssa Ross <hi@alyssa.is>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230531003345.never.325-kees@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230531003345.never.325-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 17:33, Kees Cook wrote:
> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> 
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
> 
> This means that the memcpy() calls with "buf" as a destination in
> sha256.c's code will attempt to perform run-time bounds checking, which
> could lead to calling missing functions, specifically a potential
> WARN_ONCE, which isn't callable from purgatory.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/
> Bisected-by: "Joan Bruguera Micó" <joanbrugueram@gmail.com>
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>

Hi Folks,

The -fstrict-flex-arrays=3 commit isn't upstream yet, right?  That makes
it a _bit_ wonky for us to carry this on the x86 side since among other
things, the Fixes commit doesn't exist.  I'd be fine if this goes up
along with the -fstrict-flex-arrays=3 code, so:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

We could also pick it up from the x86 side, but I think that would need
a _bit_ of a different commit message to allude to it being to prepare
for the _future_ setting of -fstrict-flex-arrays=3 and having no
practical benefits now.

Let me know if you don't want to send this up with the
-fstrict-flex-arrays=3 set.
