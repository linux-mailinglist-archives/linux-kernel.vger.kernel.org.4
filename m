Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643117220A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjFEIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFEIMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E82A1;
        Mon,  5 Jun 2023 01:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEBAF61349;
        Mon,  5 Jun 2023 08:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD463C433D2;
        Mon,  5 Jun 2023 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685952732;
        bh=0a3Erj1+y05IXqjDMWsbKoIt+bMhOMaYKv6SbF8QYx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zu6xmXaSJOaYGEZ1M18sqNTyQoodb/FtprpnZS9jE7WS1RsqZh7vr80D82GP+H1i8
         Qbu+kLGLXkmXcf2oXs54XG8W5AAc+Szj5iw7w1esJF0pl3B4pku9TUNP0nnZRtgroI
         L7ysBaeg9qWTT4omm1x3jmC2/a5iIXjq4VNltoSIXSnirdvBxVCgizUUrQFclxA9A9
         JI6H8n/NsAtikP0Klus6G9HwEipbiVd/EmoeyXvbNSuuqp00lQftKP5siTorJJyFWk
         NlQqlLQB4dqezssu+rEQF7hm50+nogklsOxP5i6Esuay261E/tRiQMISJtPYoOP/Ua
         Cp41VdtuUrJ+Q==
Date:   Mon, 5 Jun 2023 11:11:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        Will Deacon <will@kernel.org>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 12/13] x86/jitalloc: prepare to allocate exectuatble
 memory as ROX
Message-ID: <20230605081143.GA3460@kernel.org>
References: <20230601101257.530867-1-rppt@kernel.org>
 <20230601101257.530867-13-rppt@kernel.org>
 <0f50ac52a5280d924beeb131e6e4717b6ad9fdf7.camel@intel.com>
 <ZHjcr26YskTm+0EF@moria.home.lan>
 <a51c041b61e2916d2b91c990349aabc6cb9836aa.camel@intel.com>
 <ZHjljJfQjhVV/jNS@moria.home.lan>
 <68b8160454518387c53508717ba5ed5545ff0283.camel@intel.com>
 <50D768D7-15BF-43B8-A5FD-220B25595336@gmail.com>
 <20230604225244.65be9103@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604225244.65be9103@rorschach.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 10:52:44PM -0400, Steven Rostedt wrote:
> On Thu, 1 Jun 2023 16:54:36 -0700
> Nadav Amit <nadav.amit@gmail.com> wrote:
> 
> > > The way text_poke() is used here, it is creating a new writable alias
> > > and flushing it for *each* write to the module (like for each write of
> > > an individual relocation, etc). I was just thinking it might warrant
> > > some batching or something.  

> > I am not advocating to do so, but if you want to have many efficient
> > writes, perhaps you can just disable CR0.WP. Just saying that if you
> > are about to write all over the memory, text_poke() does not provide
> > too much security for the poking thread.

Heh, this is definitely and easier hack to implement :)

> Batching does exist, which is what the text_poke_queue() thing does.

For module loading text_poke_queue() will still be much slower than a bunch
of memset()s for no good reason because we don't need all the complexity of
text_poke_bp_batch() for module initialization because we are sure we are
not patching live code.

What we'd need here is a new batching mode that will create a writable
alias mapping at the beginning of apply_relocate_*() and module_finalize(),
then it will use memcpy() to that writable alias and will tear the mapping
down in the end.

Another option is to teach alternatives to update a writable copy rather
than do in place changes like Song suggested. My feeling is that it will be
more intrusive change though.

> -- Steve
> 

-- 
Sincerely yours,
Mike.
