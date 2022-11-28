Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B03F63A486
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiK1JP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiK1JPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:15:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23839A1AF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669626918; x=1701162918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GhVK2iv9vpjkCJP8+uH/K+u8TFdUdhWlY7FMTn9JVZo=;
  b=i42+vAz9Zoz6tIqHEIf6VOQe/hEWZnwdFq+5VdNAUfKU1MjHXOePYj4q
   qtzVnHxDuBzoS9X3AVDppzP9EUpy95hrWwaBv5eJ5jjCjL+r8Ac+diXQ9
   dDWfplMwbqGhWa4UJf5Jq82JSbMIdJDJVcdUVQw/Z528w96RTpnSKpxzC
   xmVB1gqSMleHHio3RLMSE+MCmXXRSzD0Fx1yA8H3ocgzL2uykyy7IRIio
   ZZ+JRUYGtyPW77cuMAagGlf5Af5ZSirBznhMevsOSwJt1iS7rH7Silc6H
   97gOZ5CJZydeUMuP3QoFglwkKGPqkBI73F8ad9J3uJK4icOCdWU19NUua
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="298141244"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="298141244"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 01:15:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="732067347"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="732067347"
Received: from gluber-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.50.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 01:15:08 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 270C5109780; Mon, 28 Nov 2022 12:15:06 +0300 (+03)
Date:   Mon, 28 Nov 2022 12:15:06 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from
 asm-offsets.c
Message-ID: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
References: <20221127062335.330758-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127062335.330758-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 03:23:35PM +0900, Vincent Mailhol wrote:
> Following [1], the macro COMPILE_OFFSETS becomes unused:

Really? I see #ifdef COMPILE_OFFSETS in ftrace.h. Hm?

Have you tested your patch with CONFIG_FTRACE_SYSCALLS=y and
CONFIG_IA32_EMULATION=y?

>   $ make W=2 arch/x86/kernel/asm-offsets.o
>   <...>
>   arch/x86/kernel/asm-offsets.c:7: warning: macro "COMPILE_OFFSETS" is not used [-Wunused-macros]
>   <...>
> 
> Remove COMPILE_OFFSETS macro.
> 
> [1] commit debc5a1ec0d1 ("KVM: x86: use a separate asm-offsets.c file")
>     Link: https://git.kernel.org/torvalds/linux/c/debc5a1ec0d1
> 
> Fixes: debc5a1ec0d1 ("KVM: x86: use a separate asm-offsets.c file")
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  arch/x86/kernel/asm-offsets.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> index 437308004ef2..cf2e02bafbef 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -4,7 +4,6 @@
>   * This code generates raw asm output which is post-processed to extract
>   * and format the required data.
>   */
> -#define COMPILE_OFFSETS
>  
>  #include <linux/crypto.h>
>  #include <linux/sched.h>
> -- 
> 2.37.4
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
