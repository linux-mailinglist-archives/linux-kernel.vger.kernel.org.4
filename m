Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE660D193
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiJYQYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiJYQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:24:48 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C58F4D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:24:44 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so7617037fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g89ernk4UyCE+8kwxR3Jyv5/vIX5YuI8xLhm1A4ERjI=;
        b=me2iS3zan7xp1lungXtMEHy478+snmQ8PXpOfSfZSvbJpysiWhm32N2znOhdc3DIf+
         i0qjOkqEogsZJ5y6xybLljNskJ4VSaPPSh/WslH9zG7/IypmvQEhGkJtSmxDgSwYQ1cv
         glkmy8ynnRP4r/oDDmsF1hEYOWqONzMpjpvJh2D36dc9NGvX5lF7Wma0F0oBpG18Wfwz
         TFW29rNtsoF23Mt5hSd2bF2FiBx7q3SCkd2D5QjnMXVB1SPGacORoQdTuuSt2qvk2Pv5
         uWP6xyX4xNT7wTLo6BD++jqfcVco5sbCU9o1tZOfpFSIbMwsFK3yfXK4pHMkXfafviXH
         FEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g89ernk4UyCE+8kwxR3Jyv5/vIX5YuI8xLhm1A4ERjI=;
        b=IEqnTtXzrx+lCsdCNpBhCgFmnt9lppbW2GcWRAI7jG5j6T+42XaqlA/vREdWSUSXsE
         HLrNsrEOuWWlqISgJ3avRiHiASDKaKq7H0mFyGVD1DbLzozgLIZDQBIsROZCU8/oAiJr
         UIihBfSfEZaXSCFT8ShUiWY6VBJJ9DrMaGXxexCFsfqUPIhpIn01dwl0phB73rovLh4W
         LlKaFSZ8AX1datr9XQB8mwbBFe54CiVivWe1dOgCFOKnTh20E3YE6EI6gmMpqqtCVJhB
         QsbcKOTFdLWeb6J5HyeV2F6ZmeUlw7QOPMOm5+ftHcPc3HxyyxYc/b/zA19xwD3HArJY
         aY1g==
X-Gm-Message-State: ACrzQf17hlbTGtK33omIkJ8N8Rg13FJUJpI+hp3AVBjC6K9GZ5KOzryB
        IxM1ebXAJdmvrbnXfxFixhA=
X-Google-Smtp-Source: AMsMyM66skY8peYqQCsAcNYATCWaSdXlgJng8rKLnrFG3anQDSwtsS3nLdGUBEzL0fGXbrprb79aXQ==
X-Received: by 2002:a05:6870:a7a5:b0:131:886b:214f with SMTP id x37-20020a056870a7a500b00131886b214fmr23648014oao.83.1666715084217;
        Tue, 25 Oct 2022 09:24:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13-20020a4ad80d000000b00480dac71228sm1265549oov.24.2022.10.25.09.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:24:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Oct 2022 09:24:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Linux 6.1-rc2
Message-ID: <20221025162441.GA1128834@roeck-us.net>
References: <CAHk-=wgLV1tNP0EYz7qWK-xeKzO6bh5Kogbpn2wxKLPPpOit3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLV1tNP0EYz7qWK-xeKzO6bh5Kogbpn2wxKLPPpOit3w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 04:03:45PM -0700, Linus Torvalds wrote:
> Hmm. Usually rc2 is a pretty quiet week, and it mostly started out
> that way too, but then things took a turn for the strange. End result:
> 6.1-rc2 ended up being unusually large.
> 
> The main reason is fairly benign, though: Mauro had screwed up the
> media tree pull request during the merge window, so rc2 ends up having
> a "oops, here's the part that was missing" moment. Since it had all
> been in linux-next (yes, I checked, so nobody else should try that
> trick), I ended up pulling that missing part during the rc2 week.
> 
> But if you ignore that media tree portion, things look pretty normal for an rc2.
> 
> Anyway, ignoring those media changes, we have a little bit of
> everything in here - arch updates, drivers (gpu, device mapper,
> networking), EFI, some core kernel fixes (mm, scheduler, cgroup,
> networking). The full shortlog is appended (and that shortlog does
> include the media pieces).
> 
> Please do go test,

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

================

Runtime warnings

powerpc
-------

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1

Not a new problem (seen as far back as v5.15.y), but fixed by:
    "powerpc/64s: Disable preemption in hash lazy mmu mode"
    "powerpc/64s: Fix hash__change_memory_range preemption warning"
    "powerpc: fix reschedule bug in KUAP-unlocked user copy"

at:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013151647.1857994-1-npiggin@gmail.com/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013151647.1857994-2-npiggin@gmail.com/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013151647.1857994-3-npiggin@gmail.com/

================================
WARNING: inconsistent lock state
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.

Fixed by:
    "powerpc/64s: Add lockdep for HPTE lock"
    "powerpc/64s: make HPTE lock and native_tlbie_lock irq-safe"
    "powerpc/64s: make linear_map_hash_lock a raw spinlock:

at:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013230710.1987253-1-npiggin@gmail.com/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013230710.1987253-2-npiggin@gmail.com/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20221013230710.1987253-3-npiggin@gmail.com/

Guenter
