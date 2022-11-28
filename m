Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1656663A6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiK1LLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiK1LLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:11:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1651193DC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669633878; x=1701169878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O5qtyqw9+bir61hktTWiI7hNhwTVzyCALdEqd4k6WlQ=;
  b=bdC5LFj0sbFqOheLci7VBZZU3YvztCvLSbTUTEoBTuC+qX3AtPKjq4hJ
   Uus/xiExxPGFhBPzk5FSu+VFlga01QdgZ6HMromIpc4LNxPJ1NpBwUS/3
   /IEOxBT4fQUwcPf0YaU+cKO20s1wEMFwGGxRap3+3yxXbSSmblou1J6JR
   FE43czupWN8I1Q9L+7PbGLZBVhWpE0K7RoUGbZt2fBU51X4q7gI4qIIFG
   2lgJsAJQ1/Tm+pB67w+b9DEW38MhZx1QBnl1gYmubeKYCK3wBO8PVfZGc
   icOnx/iNrCVYFlhIsaAWolJjjuUh6Pmz/XplcCBYpJnHuejD+f8LGmxq5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="376948191"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="376948191"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 03:11:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="768004994"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="768004994"
Received: from gluber-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.50.190])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 03:11:14 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 126B0109836; Mon, 28 Nov 2022 14:11:12 +0300 (+03)
Date:   Mon, 28 Nov 2022 14:11:12 +0300
From:   kirill.shutemov@linux.intel.com
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from
 asm-offsets.c
Message-ID: <20221128111112.dzavip4eqqgpyrai@box.shutemov.name>
References: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
 <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:11:17PM +0900, Vincent Mailhol wrote:
> On Mon, 28 Nov 2022 12:15:06 +0300, Kirill A. Shutemov wrote:
> > On Sun, Nov 27, 2022 at 03:23:35PM +0900, Vincent Mailhol wrote:
> > > Following [1], the macro COMPILE_OFFSETS becomes unused:
> > 
> > Really? I see #ifdef COMPILE_OFFSETS in ftrace.h. Hm?
> > 
> > Have you tested your patch with CONFIG_FTRACE_SYSCALLS=y and
> > CONFIG_IA32_EMULATION=y?
> 
> Even if I activate those two configurations, the compiler still
> tells me it is unused:
> 
>   $ grep -E "CONFIG_FTRACE_SYSCALLS|CONFIG_IA32_EMULATION" .config
>   CONFIG_IA32_EMULATION=y
>   CONFIG_FTRACE_SYSCALLS=y
> 
>   $ make W=2 arch/x86/kernel/asm-offsets.o
>   <...>
>   arch/x86/kernel/asm-offsets.c:7: warning: macro "COMPILE_OFFSETS" is not used [-Wunused-macros]
>   <...>

If you are sure <asm/ftrace.h> is never included from asm-offsets.c,
remove #ifndef COMPILE_OFFSETS too.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
