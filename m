Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1570EF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjEXHYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbjEXHYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:24:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8DA196;
        Wed, 24 May 2023 00:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lgMAk4mNAvXRq4u66gUQkOlWUTi4SucZWhG20iHV2qA=; b=IrTas483CVgh9uJT70jaB6SKUR
        uDt76JhIVBau5lYeKSei7idTwu7kzQxYFYwYXOoi1hfSpZpauqEcYgbX3QY/P1B9oorB+60kEz83O
        axtRFjakKG5WW6CCoPuYV1ownJCh25YICaHCABIyMJ4j+eo7Er/J6rijDLjt7ciEudNZ5zCf3l0P5
        gFUcqQq7uPY2GBr8+y65OHReABriQYGWZfJwGmYkdTsoKdE4ntgPU6ccPbwHO8JZ623vpUhuWI/7/
        PJEk1Gp7bC4CIiCUVOb9Z0Bj2AtuKj+qogH5pJwGATVjd+ZJ5m5tZfdzzyHVecweBHAj2NQj9Wjqt
        SVa6e/eA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1ir6-00Cb2v-1L;
        Wed, 24 May 2023 07:24:20 +0000
Date:   Wed, 24 May 2023 00:24:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-modules@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
Message-ID: <ZG27pExhUqFpGexM@bombadil.infradead.org>
References: <20230517131820.936553-1-arnd@kernel.org>
 <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
 <a3d01d39-3d45-4fdc-8f73-b6c33bcae24b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d01d39-3d45-4fdc-8f73-b6c33bcae24b@app.fastmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:25:13AM +0200, Arnd Bergmann wrote:
> On Wed, May 24, 2023, at 07:07, Luis Chamberlain wrote:
> > On Wed, May 17, 2023 at 03:18:07PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The arch_get_kallsym() function was introduced so that x86 could override
> >> it, but that override was removed in bf904d2762ee ("x86/pti/64: Remove
> >> the SYSCALL64 entry trampoline"), so now this does nothing except causing
> >> a warning about a missing prototype:
> >> 
> >> kernel/kallsyms.c:662:12: error: no previous prototype for 'arch_get_kallsym' [-Werror=missing-prototypes]
> >>   662 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
> >> 
> >> Restore the old behavior before d83212d5dd67 ("kallsyms, x86: Export
> >> addresses of PTI entry trampolines") to simplify the code and avoid
> >> the warning.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Shouldn't this go through x86 as this sort of fixesss commit
> > bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")?
> 
> That works for me as well, as long as someone picks it up. It's
> not really x86 any more though since that commit is five years
> old and removed the last reference from the x86 code.

Fair enough.

> I sent it to you since you are the one that merged most of
> the kallsyms patches through the module tree, but I guess
> you are not actually maintaining that file (not blaming you,
> I'd also try to stay away from kallsyms).
> 
> I can resend it to Andrew for the -mm tree.

OK, I just took the patch in, it's on the train, better get on before
it gets lost.

  Luis
