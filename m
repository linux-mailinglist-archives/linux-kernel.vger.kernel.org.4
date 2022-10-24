Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF84609FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJXLOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJXLNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9652FFE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cBDkBr7vYUB7A8Ost1DKjjkaKnH15tbd8dYfxDJQD38=; b=NQ7/5E2VdPz3hqSrREq13WOsYw
        7OjbQIhMab1CWMDTYpWIjExQ/7gUPIaEpzsf/d0899RZAiNH8t1OnS+CIfiBCuBixwibhgkePjhab
        mAhPmzKO2cS5tHi8WUc7IlibUadOJYQeFUXsUe5FEge8mZGnQRZuQit/U1BjKULuvwlUpGnGaH6I/
        Cm8tjd/+xsa8C//w99oE4liaPNF3RgYEIfinD29AKjXdGpl92JIUrxIk0iM6EbrqtV8DPAJmEUS5w
        bSXu6Ac/eDZHWbnwCNMOjoh2sfyj/yMdxk+mrf3f0IO8XzLBz+XHdAPUEr4Q7qDh9htaBvWNsUJAs
        Au9qgPBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omvOR-00632M-O4; Mon, 24 Oct 2022 11:13:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB0BC300445;
        Mon, 24 Oct 2022 13:13:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 875D02C35E216; Mon, 24 Oct 2022 13:13:18 +0200 (CEST)
Date:   Mon, 24 Oct 2022 13:13:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 10/13] x86/mm/pae: Be consistent with pXXp_get_and_clear()
Message-ID: <Y1ZzTvJAm8SCbZY/@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.103392961@infradead.org>
 <CAHk-=wh6ip4AVqGx6kB9aHN07pR3M4htTTq1n=M7skPaudpM-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6ip4AVqGx6kB9aHN07pR3M4htTTq1n=M7skPaudpM-Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 10:53:42AM -0700, Linus Torvalds wrote:
> On Sat, Oct 22, 2022 at 4:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > +
> > +#define pxx_xchg64(_pxx, _ptr, _val) ({                                        \
> > +       _pxx##val_t *_p = (_pxx##val_t *)_ptr;                          \
> > +       _pxx##val_t _o = *_p;                                           \
> > +       do { } while (!try_cmpxchg64(_p, &_o, (_val)));                 \
> > +       native_make_##_pxx(_o);                                         \
> > +})
> 
> I think this could just be a "xchp64()", but if the pte/pmd code is
> the only thing that actually wants this on 32-bit architectures, I'm
> certainly ok with making it be specific to just this code, and calling
> it "pxx_xchg()".

Regular xchg64() didn't work, the casting crud there is required because
of how pxx_t is a struct.

Now I could obviously do a xchg64(), but then we'd still need this
wrapper -- and yeah, I don't know how many other users there are.
