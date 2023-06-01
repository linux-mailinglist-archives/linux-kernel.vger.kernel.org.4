Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748071F14C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjFASA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFASA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:00:26 -0400
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [IPv6:2001:41d0:203:375::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172E198
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:00:23 -0700 (PDT)
Date:   Thu, 1 Jun 2023 14:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685642421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rikKWdy6FkJZ7TxOeuVv2no4Uvw2FbvFXrknlku2Lr0=;
        b=atiaOaKv+uGgVWrIBgEc7yMVho95zk+yXn7HmIb/JWzdFNNRD8GsFkaCojYLUmxdGEZj8D
        7Ioc6S8oiCxOeWCOlyVYprsSznLfrTEBk/hh6wsG3yyt6B+kTftpXgtdtqd4vLEbQHfUux
        KWvBLALHSXDpFUTZKzUX7J9eP0pgECQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "will@kernel.org" <will@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 12/13] x86/jitalloc: prepare to allocate exectuatble
 memory as ROX
Message-ID: <ZHjcr26YskTm+0EF@moria.home.lan>
References: <20230601101257.530867-1-rppt@kernel.org>
 <20230601101257.530867-13-rppt@kernel.org>
 <0f50ac52a5280d924beeb131e6e4717b6ad9fdf7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f50ac52a5280d924beeb131e6e4717b6ad9fdf7.camel@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 04:54:27PM +0000, Edgecombe, Rick P wrote:
> It is just a local flush, but I wonder how much text_poke()ing is too
> much. A lot of the are even inside loops. Can't it do the batch version
> at least?
> 
> The other thing, and maybe this is in paranoia category, but it's
> probably at least worth noting. Before the modules were not made
> executable until all of the code was finalized. Now they are made
> executable in an intermediate state and then patched later. It might
> weaken the CFI stuff, but also it just kind of seems a bit unbounded
> for dealing with executable code.

I believe bpf starts out by initializing new executable memory with
illegal opcodes, maybe we should steal that and make it standard.

> Preparing the modules in a separate RW mapping, and then text_poke()ing
> the whole thing in when you are done would resolve both of these.

text_poke() _does_ create a separate RW mapping.

The thing that sucks about text_poke() is that it always does a full TLB
flush, and AFAICT that's not remotely needed. What it really wants to be
doing is conceptually just

kmap_local()
mempcy()
kunmap_loca()
flush_icache();

...except that kmap_local() won't actually create a new mapping on
non-highmem architectures, so text_poke() open codes it.
