Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7A6026A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiJRIWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJRIWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:22:09 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2005695AEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:22:09 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id r19so9222474qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI3ZnOUgyhDtbIsMZt8LRqDd4gbizXvliS1A8m7UQjQ=;
        b=U8a7ihfuWLSvbHY8IBALWM4RnPbqN22kpE6A3JjVL6fhYMKi5rVy8qv3j+YaOQHmmm
         7gEVijRLYTYaYtsmCCiK0XjJ1dq47qEKvji8NTALxEtOCTWhtizQuwkips4D2xQmJV+m
         XswG+Mn9BZN/AGeO1OiCToD4kKDb/LOn6bowMwUeyaxpmwshC23XbckJ3v2eX3HJRuhh
         fRdt87iviLeftbBIfn5QSN8JV8ftHFOROl5CvE9b6jXhJD+69Zz+sJGhM02kPpid2E86
         EQEBrIUy8o3sAGLqJVmY2+kuGUCqUzGqq3EPPQhVBK5fz2pnEwhwSvpfWEMc6VO+yAVp
         gAyA==
X-Gm-Message-State: ACrzQf1g0pNfUvfscr1ngRTM4ubP/LB37veuMgDyl/ZL4XdGErP3xwa8
        SHKmQZXJ3XUX2UI5afWfJj+7+tlOo6RV6Q==
X-Google-Smtp-Source: AMsMyM4DLh6htkoFVbsyZsNAbSFcgLu/Olm4CLEH5KMp0XEQMNoVEBmENp6Kz6sg1h02kZRFNjlJyA==
X-Received: by 2002:ac8:5702:0:b0:39c:f612:29b8 with SMTP id 2-20020ac85702000000b0039cf61229b8mr794435qtw.68.1666081328007;
        Tue, 18 Oct 2022 01:22:08 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id bl12-20020a05620a1a8c00b006bbc09af9f5sm1924701qkb.101.2022.10.18.01.22.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:22:06 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 126so16120256ybw.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:22:06 -0700 (PDT)
X-Received: by 2002:a25:2:0:b0:6c4:dc1:d37c with SMTP id 2-20020a250002000000b006c40dc1d37cmr1382484yba.380.1666081325735;
 Tue, 18 Oct 2022 01:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230820.3295223-1-yury.norov@gmail.com> <20220905230820.3295223-6-yury.norov@gmail.com>
In-Reply-To: <20220905230820.3295223-6-yury.norov@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Oct 2022 10:21:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
Message-ID: <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Tue, Sep 6, 2022 at 1:10 AM Yury Norov <yury.norov@gmail.com> wrote:
> The size of cpumasks is hard-limited by compile-time parameter NR_CPUS,
> but defined at boot-time when kernel parses ACPI/DT tables, and stored in
> nr_cpu_ids. In many practical cases, number of CPUs for a target is known
> at compile time, and can be provided with NR_CPUS.
>
> In that case, compiler may be instructed to rely on NR_CPUS as on actual
> number of CPUs, not an upper limit. It allows to optimize many cpumask
> routines and significantly shrink size of the kernel image.
>
> This patch adds FORCE_NR_CPUS option to teach the compiler to rely on
> NR_CPUS and enable corresponding optimizations.
>
> If FORCE_NR_CPUS=y, kernel will not set nr_cpu_ids at boot, but only check
> that the actual number of possible CPUs is equal to NR_CPUS, and WARN if
> that doesn't hold.
>
> The new option is especially useful in embedded applications because
> kernel configurations are unique for each SoC, the number of CPUs is
> constant and known well, and memory limitations are typically harder.
>
> For my 4-CPU ARM64 build with NR_CPUS=4, FORCE_NR_CPUS=y saves 46KB:
>   add/remove: 3/4 grow/shrink: 46/729 up/down: 652/-46952 (-46300)
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Thanks for your patch, which is now commit 6f9c07be9d020489
("lib/cpumask: add FORCE_NR_CPUS config option") in v6.1-rc1.

FORCE_NR_CPUS is enabled for e.g. an allmodconfig kernel, which I
believe now makes it unsafe to boot such a kernel on any system that
does not have exactly CONFIG_NR_CPUS CPU cores?

If my assumption is true, this really needs some protection to prevent
enabling this option inadvertently, as it is quite common to boot
allmodconfig kernels for testing.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
