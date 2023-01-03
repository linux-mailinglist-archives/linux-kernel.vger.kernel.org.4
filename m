Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E0465BE6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbjACKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjACKus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:50:48 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55862199;
        Tue,  3 Jan 2023 02:50:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id fc4so72591294ejc.12;
        Tue, 03 Jan 2023 02:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkatKLJ3qYUKGORjBOFQcSqkI25EQPSR3fb3zK2nRZ4=;
        b=iWv5WTf9UYUuf08z/VB2JfMIE2Vf/mX8RiJQCXh8o+R7kTpPjQtiY2DfPkxIsy3e1a
         iYO78jxMxb/OWEJRoxhW7QA2CNeEs0/XBRslGsuvgpHq64xTuBJaw6IK2ibAz6FRMsmy
         WZbjY0u9VFC8NSi/DIETtu1jzJeNtxZ8fxsUjj7Rv88UjLTQxBF2VB3lrJOibB6qUNSX
         JHgikcIgm8z7OMovght+ngiurPmA08t6bWkotxpNQYwiC8kv+MQGPgOCTVita7HptoHA
         9EKMQA4GqgNQ16jP5+TuW/P71kBjHVzwAAP3DQjwPVt2WfqO4oJUi4qCrpz0M9r3UyUM
         Q32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkatKLJ3qYUKGORjBOFQcSqkI25EQPSR3fb3zK2nRZ4=;
        b=mPfDLLEgXl60XpzPTZf9B5EDMxdc/JFGrSE+4I888PVAvvmbU4Xa1pDQpDcBugSpbE
         6dELeogZl4PHYV6v1ELpjQOjRIln0IZW7ZTSlcuZdVE8DbV7V1qqYAPU7hgWl5I4QSYG
         yn9i1H/L8Fb32XaKclw8JVe2LmxjL8iUE/Gi9MZkvAKieRowXuUqOIPb5eu97mCbsCbB
         IqZpG8ukfrZjU/YQctHOBJSjbS5K4+kRLnn67cR0UnbJwUCBT5PZudikFOmymgZM7Wln
         OhXgQHGtsCRN7irA0n4mVsevcg9bdwmr2WLj/oCzy+akDM6Wz883EG3+JInYWSWBik1z
         ac+g==
X-Gm-Message-State: AFqh2koVDR/Pt227Sc9EKZZeeqw/r++3SlOEA4HKpqh+JSzlY9fMsuCW
        PcnTjHO0O4OO/JPNYtTL2ow=
X-Google-Smtp-Source: AMrXdXsqrbLRQvWkdEnkoyrRn7PkXm7IBeuwAzwJNn66HH7AqMNyRJOiDOPxeMEZTTvwvguSTVcNMw==
X-Received: by 2002:a17:906:7fc2:b0:838:9c66:cd2f with SMTP id r2-20020a1709067fc200b008389c66cd2fmr35132067ejs.74.1672743045865;
        Tue, 03 Jan 2023 02:50:45 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id jg34-20020a170907972200b0084cb8589523sm3545273ejc.139.2023.01.03.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 02:50:45 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Jan 2023 11:50:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7QIg/hAIk7eZE42@gmail.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101162910.710293-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> The vDSO getrandom() implementation works with a buffer allocated with a
> new system call that has certain requirements:
> 
> - It shouldn't be written to core dumps.
>   * Easy: VM_DONTDUMP.
> - It should be zeroed on fork.
>   * Easy: VM_WIPEONFORK.
> 
> - It shouldn't be written to swap.
>   * Uh-oh: mlock is rlimited.
>   * Uh-oh: mlock isn't inherited by forks.
> 
> - It shouldn't reserve actual memory, but it also shouldn't crash when
>   page faulting in memory if none is available
>   * Uh-oh: MAP_NORESERVE respects vm.overcommit_memory=2.
>   * Uh-oh: VM_NORESERVE means segfaults.
> 
> It turns out that the vDSO getrandom() function has three really nice
> characteristics that we can exploit to solve this problem:
> 
> 1) Due to being wiped during fork(), the vDSO code is already robust to
>    having the contents of the pages it reads zeroed out midway through
>    the function's execution.
> 
> 2) In the absolute worst case of whatever contingency we're coding for,
>    we have the option to fallback to the getrandom() syscall, and
>    everything is fine.
> 
> 3) The buffers the function uses are only ever useful for a maximum of
>    60 seconds -- a sort of cache, rather than a long term allocation.
> 
> These characteristics mean that we can introduce VM_DROPPABLE, which
> has the following semantics:
> 
> a) It never is written out to swap.
> b) Under memory pressure, mm can just drop the pages (so that they're
>    zero when read back again).
> c) If there's not enough memory to service a page fault, it's not fatal,
>    and no signal is sent. Instead, writes are simply lost.
> d) It is inherited by fork.
> e) It doesn't count against the mlock budget, since nothing is locked.
> 
> This is fairly simple to implement, with the one snag that we have to
> use 64-bit VM_* flags, but this shouldn't be a problem, since the only
> consumers will probably be 64-bit anyway.
> 
> This way, allocations used by vDSO getrandom() can use:
> 
>     VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
> 
> And there will be no problem with OOMing, crashing on overcommitment,
> using memory when not in use, not wiping on fork(), coredumps, or
> writing out to swap.
> 
> At the moment, rather than skipping writes on OOM, the fault handler
> just returns to userspace, and the instruction is retried. This isn't
> terrible, but it's not quite what is intended. The actual instruction
> skipping has to be implemented arch-by-arch, but so does this whole
> vDSO series, so that's fine. The following commit addresses it for x86.

Yeah, so VM_DROPPABLE adds a whole lot of complexity, corner cases, per 
arch low level work and rarely tested functionality (seriously, whose 
desktop system touches swap these days?), just so we can add a few pages of 
per thread vDSO data of a quirky type that in 99.999% of cases won't ever 
be 'dropped' from under the functionality that is using it and will thus 
bitrot fast?

The maintainability baby is being thrown out with the bath water IMO ...

And we want to add more complexity to a facility people desperately want to 
trust *more*? [RNG]

What's wrong with making mlock() more usable? Or just saying that "yeah, 
the vDSO can allocate a few more permanent pages outside of existing 
rlimits & mlock budgets"?

The rest of the series looks fine to me, but this special one of a kind 
VM_DROPPABLE is just way over-engineered cornercase functionality that 
pushes us well past the maintenance_overhead<->complexity trade-off sweet spot ...

Thanks,

	Ingo
