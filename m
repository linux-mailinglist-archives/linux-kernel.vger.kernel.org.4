Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EFD70125F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjELXS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbjELXSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:18:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FAB2720
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:18:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561120ed06fso43347017b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683933533; x=1686525533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PT2H6/apUR9sJajl9RbvJVKJwKwQ5MmsnWxP5CjA20=;
        b=uVs9T2Kpb8R7lRl62itfIQwYM3+HFtzrkMAg1asEW2okYqmgnE1VWzLMcUar6CPXXj
         2zMj+z8R9rYxXh4Ig9jYehnOhRV79MkpWa4EMenT6uU401Na8CfTNkTeHId80ElOTmYM
         i8+7a/wCjFFRTauS63zH5UJVdkZ6riCXurT01vFX8rqgPKOB57UqR0MuxAsdn1vJAk31
         i4Bpm7YsKA6YVX/gin5lyO/nMKnfewpra6LdwBemHEPnMffO4xZbdwkwlxEOKCrWDAWm
         0qnS/98NreiwEXQwBQYKK0syEcR70epqKxc++MX3w1COhQuEqAbbirhXek95bJ1uA/z2
         Xtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683933533; x=1686525533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PT2H6/apUR9sJajl9RbvJVKJwKwQ5MmsnWxP5CjA20=;
        b=fOP0sdtkZ0bvKUhfQSHMNyMo2QNF0YyX++WUycdnt/ZRbolNRorLbcJfXy9V7ClzUY
         68BSkdPqEgzW6sXO/Kj2bQ9GRo3RNTxnfsJ30AroGbZitYUsqY1gIZ2ta3nufOh7xJnu
         qiRClVXYyUe5YtBT7OnVoZjuMpShCAB4Zn5VURURlJpP7GrHyJJXbEusrUYdOqj/g7BM
         QVxcQBnBjurSGQzKCgfeLhMK842MbDUSAijX7pnRYyP5Kkwu7luYkh0pEnqWs4A+5OpE
         e0lg8vL2IgB0VQANVScAnNamWjqGM/psAY9HCe28p0RY7DAxlBNjGXBuPuadJX+BCDEg
         lZTQ==
X-Gm-Message-State: AC+VfDzZ9/Y5I0HJYJxXlIJ+gia+2mf7th3wvl658afZi6HTS3iozEiF
        Yd013Ph49ZEF+pimfboCQ32+W4vKPao=
X-Google-Smtp-Source: ACHHUZ59RrV5vYKSwm4YpCqYZqkszYf58HBf1LEHBizo1wFup5IR9VXqpvzYCIbJ6dr/q5NtnV4DEsl+7Q0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b64c:0:b0:54f:a609:e88 with SMTP id
 h12-20020a81b64c000000b0054fa6090e88mr16104735ywk.7.1683933533030; Fri, 12
 May 2023 16:18:53 -0700 (PDT)
Date:   Fri, 12 May 2023 16:18:51 -0700
In-Reply-To: <ZF7IRQZo8g7Lg46V@google.com>
Mime-Version: 1.0
References: <20230511235917.639770-1-seanjc@google.com> <20230511235917.639770-6-seanjc@google.com>
 <ZF7IRQZo8g7Lg46V@google.com>
Message-ID: <ZF7JW2huc2MjXZFA@google.com>
Subject: Re: [PATCH 5/9] KVM: x86/mmu: Convert "runtime" WARN_ON() assertions
 to WARN_ON_ONCE()
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023, David Matlack wrote:
> On Thu, May 11, 2023 at 04:59:13PM -0700, Sean Christopherson wrote:
> > Convert all "runtime" assertions, i.e. assertions that can be triggered
> > while running vCPUs, from WARN_ON() to WARN_ON_ONCE().  Every WARN in the
> > MMU that is tied to running vCPUs, i.e. not contained to loading and
> > initializing KVM, is likely to fire _a lot_ when it does trigger.  E.g. if
> > KVM ends up with a bug that causes a root to be invalidated before the
> > page fault handler is invoked, pretty much _every_ page fault VM-Exit
> > triggers the WARN.
> > 
> > If a WARN is triggered frequently, the resulting spam usually causes a lot
> > of damage of its own, e.g. consumes resources to log the WARN and pollutes
> > the kernel log, often to the point where other useful information can be
> > lost.  In many case, the damage caused by the spam is actually worse than
> > the bug itself, e.g. KVM can almost always recover from an unexpectedly
> > invalid root.
> > 
> > On the flip side, warning every time is rarely helpful for debug and
> > triage, i.e. a single splat is usually sufficient to point a debugger in
> > the right direction, and automated testing, e.g. syzkaller, typically runs
> > with warn_on_panic=1, i.e. will never get past the first WARN anyways.
> 
> On the topic of syzkaller, we should get them to test with
> CONFIG_KVM_PROVE_MMU once it's available.

+1

> > Lastly, when an assertions fails multiple times, the stack traces in KVM
> > are almost always identical, i.e. the full splat only needs to be captured
> > once.  And _if_ there is value in captruing information about the failed
> > assert, a ratelimited printk() is sufficient and less likely to rack up a
> > large amount of collateral damage.
> 
> These are all good arguments and I think they apply to KVM_MMU_WARN_ON()
> as well. Should we convert that to _ONCE() too?

Already done in this patch :-)  I didn't call it out because that warn also falls
under the "runtime assertions" umbrella.

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index bb1649669bc9..cfe925fefa68 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -9,7 +9,7 @@
 #undef MMU_DEBUG

 #ifdef MMU_DEBUG
-#define KVM_MMU_WARN_ON(x) WARN_ON(x)
+#define KVM_MMU_WARN_ON(x) WARN_ON_ONCE(x)
 #else
 #define KVM_MMU_WARN_ON(x) do { } while (0)
 #endif
