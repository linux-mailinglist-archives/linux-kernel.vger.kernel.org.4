Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13A737E75
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjFUIxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjFUIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:53:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409595
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mmXkm5/oIx1V/0IF0h6fcCPsKPVdvFpGJPKWvTYR5Z8=; b=WInZFulVdbKQFqZuBlZtu0gndE
        V/p+3euilZoenhA2uYyckdf3wAp3NEmHZkwAFBo9Rl72tSlsjVU6EIRzPMw+YtakuLxouaFIlSorh
        Ah6/cwcOwLgdDbJMB2qrQww0udACkBuQHN2nYdxEgK20RKL7kOsaqh3VcaNGvo2MdTk0ZeGN8Zv5k
        wX/ay9UmexbXKHcjH4ZCA5R3wSfc1L26ZPf4KVcF4LHP6Kw5FY6Y4PBGA6KsLG2flHoN9LTDknH5w
        9N6ZCtz0Oa3KwB758WUdbyFfulJC8Ll0MAt0kJTO2W6eb76Eu4zJhD35vUqZ5tra2juVP/BhUDANe
        ogZl/GWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBtYP-00HK9x-03;
        Wed, 21 Jun 2023 08:53:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A2853002A9;
        Wed, 21 Jun 2023 10:51:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 224A120825AF7; Wed, 21 Jun 2023 10:51:04 +0200 (CEST)
Date:   Wed, 21 Jun 2023 10:51:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        alyssa.milburn@linux.intel.com, linux-kernel@vger.kernel.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 2/2] x86/fineibt: Poison ENDBR at +0
Message-ID: <20230621085104.GH2046280@hirez.programming.kicks-ass.net>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.194131053@infradead.org>
 <202306201454.0A2E875F@keescook>
 <CABCJKucbBfpwPYnKoEpAx1xe58uShKsxBhX5y8JyaTRs3eWanQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKucbBfpwPYnKoEpAx1xe58uShKsxBhX5y8JyaTRs3eWanQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 05:04:50PM -0700, Sami Tolvanen wrote:
> On Tue, Jun 20, 2023 at 2:55 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jun 15, 2023 at 09:35:48PM +0200, Peter Zijlstra wrote:
> > > Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
> > > booting on IBT enabled hardware obtain FineIBT, the indirect functions
> > > look like:
> > >
> > >   __cfi_foo:
> > >       endbr64
> > >       subl    $hash, %r10d
> > >       jz      1f
> > >       ud2
> > >       nop
> > >   1:
> > >   foo:
> > >       endbr64
> > >
> > > This is because clang currently does not supress ENDBR emission for
> > > functions it provides a __cfi prologue symbol for.
> >
> > Should this be considered a bug in Clang?
> 
> The endbr is needed with KCFI if we have FineIBT disabled for some
> reason. There's some discussion here:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1735
> 
> However, since the kernel handles FineIBT patching, it might be
> cleaner to let it also poison the extra endbr.

That's what I get for replying before reading all replies. Anyway, we're
in agreement.
