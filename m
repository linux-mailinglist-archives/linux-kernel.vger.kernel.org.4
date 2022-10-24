Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2567D609EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJXKVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJXKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:21:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1240A57267
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lTxOfg5Ra99+sqhS1DHanKPayyJDUus07bJIIS/DMT4=; b=LurEXlkcVfuB9pdOTpAoE8PFCB
        mehpzxpmakKk0JKzeD41izQeBjmpB+CwXyncblYxt8BG1k8cPDQ/neSsqOw0xNadDo9/rc+4U118L
        6sUWVpauFrt1Z/tQyNPyO42MDCSMOy/bpRW2is7inY6B9rPZkDN89m0iuKiu6yqhDJsVdywS37cpM
        8S9R/irVIpRlkmvn8XNOWb4sNlJ0oWVv2cJA/zcFxUnr35VgSdrt3g5TDwpXDCoKMTVkmGLGF9EBL
        EOHuvz8wC2qC+z8pOyXDL7+CgAmnar52F1clPVKH5fNUNeIdYxUTXtYmJVIWwv63/Ix2yp+QSYD3q
        wPctRF3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omuaD-00FLqo-Nj; Mon, 24 Oct 2022 10:21:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 046B4300205;
        Mon, 24 Oct 2022 12:21:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBF722025970F; Mon, 24 Oct 2022 12:21:18 +0200 (CEST)
Date:   Mon, 24 Oct 2022 12:21:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 09/13] x86/mm/pae: Use WRITE_ONCE()
Message-ID: <Y1ZnHkb7djZpANX5@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.038102604@infradead.org>
 <CAHk-=whVRHVJAOOc=+1eQMSuWSoRAp+yGkb3Kob2=7r05M+oXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVRHVJAOOc=+1eQMSuWSoRAp+yGkb3Kob2=7r05M+oXw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 10:42:52AM -0700, Linus Torvalds wrote:
> On Sat, Oct 22, 2022 at 4:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >  static inline void native_set_pte(pte_t *ptep, pte_t pte)
> >  {
> > -       ptep->pte_high = pte.pte_high;
> > +       WRITE_ONCE(ptep->pte_high, pte.pte_high);
> >         smp_wmb();
> > -       ptep->pte_low = pte.pte_low;
> > +       WRITE_ONCE(ptep->pte_low, pte.pte_low);
> 
> With this, the smp_wmb() should just go away too. It was really only
> ever there as a compiler barrier.

Right, however I find it easier to reason about this with the smp_wmb()
there, esp. since the counterpart is in generic code and (must) carries
those smp_rmb()s.

Still, I can take them out if you prefer.

> Or do we already have a comment elsewhere about why the ordering is
> important (and how *clearing* clears the low word with the present bit
> first, but setting a *new* entry sets the high word first so that the
> 64-bit entry is complete when the present bit is set?)

There's a comment in include/linux/pgtable.h near ptep_get_lockless().

Now; I've been on the fence about making those READ_ONCE(), I think
KCSAN would want that, but I think the code is correct without them,
even if the loads get torn, we rely on the equality of the first and
third load and the barriers then guarantee the second load is coherent.

OTOH, if the stores (this patch) go funny and get torn bad things can
happen, imagine it writing the byte with the present bit in first and
then the other bytes (because the compile is an evil bastard and wants a
giggle).


