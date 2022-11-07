Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67861F3D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiKGM6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKGM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:58:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8C113F79
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667825919; x=1699361919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75Q8jfo9VuSCUpi/mO2u+M18tr1BpWsKHMiqiHRAxVE=;
  b=bOMlffTWjFv/KKGi3ZGADCs9rdL3s4jxTEGfKXwJaZnajGMt3/3jRv6S
   CgfEAaG2zc/pZnAiX0qQYkglGDDnfE+qnvq6zz6hMJNK+Be+XVXzOFluO
   lcrvgqcy3Q0P0WAftfcTuq2Rj/LVzVXbQ4UmF8PwUoLqZH46WJQ8OAFlf
   mji1aI2mFwxFCMArMHibNKkrxwIu2sBBpUQLNprlfAn4FKdPJkgYqTKlB
   gAi1k3zgft1fQ757LI4IhSFjbiLBxnQJ3Fbj4yGhPV6P+7z7LerxkDtu1
   TuqTwfgLwA9+g6+dFlv/NWHtN+8ruLcteLPjkuwnfYFUNFjPdr2CSGVjU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="312167011"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="312167011"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 04:58:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="699463658"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="699463658"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 04:58:35 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2A7CwX1k017267;
        Mon, 7 Nov 2022 12:58:33 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/boot: fix relying on link order
Date:   Mon,  7 Nov 2022 13:55:28 +0100
Message-Id: <20221107125528.543764-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 1 Nov 2022 17:15:27 +0100

> The series contains stuff I caught last week while working on some
> x86 code. It can be considered a material for fixes or for next,
> I'm okay with either, although leaning more towards fixes :P
> 
> Notes on patches:
> * 0001: I didn't put any "Fixes:" tag since it's not linear. The
>         lines changed with this patch came from the initial x86
>         KASLR series, but that unconditional jump to the kernel
>         beginning already was there. It goes at least from the set
>         that brought relocatable kernel support to x86, but this
>         is quite prehistoric already and might not look really
>         relatable. So up to you whether it needs any.
> * 0002: doesn't fix anything, except that having any files listed
>         in that whitelist already is an architecture bug :D And
>         it wouldn't be convenient to decouple it from #0001, but
>         up to you as well.
> 
> From v1[0]:
>  * collect the Tested-by tags (Jiri);
>  * don't add pathetic returns after noreturn error() (Jiri);
>  * debug-print the entry point offset via debug_putaddr() before
>    booting (Jiri);
>  * always have an empty line before return statements (Jiri). 
> 
> [0] https://lore.kernel.org/all/20221031151047.167288-1-alexandr.lobakin@intel.com
> 
> Alexander Lobakin (2):
>   x86/boot: robustify calling startup_{32,64}() from the decompressor
>     code
>   scripts/head-object-list: remove x86 from the list
> 
>  arch/x86/boot/compressed/head_32.S |  2 +-
>  arch/x86/boot/compressed/head_64.S |  2 +-
>  arch/x86/boot/compressed/misc.c    | 16 ++++++++++------
>  scripts/head-object-list.txt       |  6 ------
>  4 files changed, 12 insertions(+), 14 deletions(-)

Ping?

Also, I managed to remove .head.text at all from x86. Would it be
better to respin this series with the third patch or send a
follow-up later?

> 
> -- 
> 2.38.1

Thanks,
Olek
