Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C96672266
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjARQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjARQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:03:41 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE11F56EE4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:59:40 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id q10so24032271qvt.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMnfiDl90nDMp75zhCoCphPVt5I3scvrOc1ITYVkfYQ=;
        b=PdMtFWv6YOkJKhAG4gLjZhgFPo65DsYbGhXsa3xdtPIKBIPTic0rHcEQ3CdiRbooys
         MtFyqsMqZIIgHuIoVgVIVuT6YoFxNTQ2CcVt6GhEwOcXD09vu8nJ2n4BB6fo3/kBhPt2
         JxhySlSm6v/yV+rqY6m/f6nNkvkEhQaiHRo6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMnfiDl90nDMp75zhCoCphPVt5I3scvrOc1ITYVkfYQ=;
        b=uTeypvjs0CEL8OIAquveHulL5TZBL8Uzqji+HTfQAD0RjmVM7MWQXrsL7/eb8vaYhJ
         tM0EvsA36bQ3ha1TdvV+nDn2G05LVGm5ZkKoyDWbUcHuLtHc5XunkrBX7PAqOUAnI+0A
         gSFwu/2VqKjBrhjZ/Ln4IVakVu0Im5nHgcuxBrCpSdyS7XkN9dh0ZaGNd9H3lZWzcxU3
         +0khY+1j6U06zt3YK6qZtpQ9rwvrFYqezp3VspOeGcH76bpPHLio7ZdX5GkdXOBRM1xl
         DYwkLJej5Np/FN8ORTzFg8yYCGlUgwaPE/Psjd1nAoGZwdjy+lPWZNIQdL+esjszc+GI
         Kefw==
X-Gm-Message-State: AFqh2krxiRrGEmv94SaRpKzuU8XVn5heB16340qjCpA9A8FbKHVITK+l
        x07shYXn8qndYV7dDOWp6VcCDshwBcNpcxX/
X-Google-Smtp-Source: AMrXdXvv7Qn9dVgYc73P0kNntiKIlzrMoh90GDKYfjCV0SIVg4z1zFPdxW5dKJblwiNMSHkdkeFa3Q==
X-Received: by 2002:a0c:ef4f:0:b0:531:c196:3dfb with SMTP id t15-20020a0cef4f000000b00531c1963dfbmr36338668qvs.25.1674057579632;
        Wed, 18 Jan 2023 07:59:39 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a430800b006b615cd8c13sm22698539qko.106.2023.01.18.07.59.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 07:59:38 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id d13so9514795qkk.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:59:38 -0800 (PST)
X-Received: by 2002:a37:6387:0:b0:706:92f4:125 with SMTP id
 x129-20020a376387000000b0070692f40125mr423230qkb.72.1674057577814; Wed, 18
 Jan 2023 07:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-2-kirill.shutemov@linux.intel.com> <Y8gVJUDEFE5U7xAq@hirez.programming.kicks-ass.net>
In-Reply-To: <Y8gVJUDEFE5U7xAq@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jan 2023 07:59:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4PDt_73n5rG9obkXrRQFcxN8vUhG6T9DipxozybH9_w@mail.gmail.com>
Message-ID: <CAHk-=wj4PDt_73n5rG9obkXrRQFcxN8vUhG6T9DipxozybH9_w@mail.gmail.com>
Subject: Re: [PATCHv14 01/17] x86/mm: Rework address range check in get_user()
 and put_user()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 11, 2023 at 03:37:20PM +0300, Kirill A. Shutemov wrote:
>
> > If an address with bit 63 set is passed down, it will trigger a #GP
> > exception. _ASM_EXTABLE_UA() complains about this. Replace it with
> > plain _ASM_EXTABLE() as it is expected behaviour now.
>
> here I don't. The new logic basically squishes every kernel address to
> -1L -- a known unmapped address, but getting that address in
> {get,put}_user() is still a fail, right?
>
> We used to manually branch to bad_get_user when outside TASK_SIZE_MAX,
> now we rely on #GP.
>
> So why silence it?

We don't silence it - for a kernel address that turns into an all-ones
address, the the _ASM_EXTABLE() will still cause the -EFAULT due to
the page fault.

But it's not the high bit set case that is the problem here.

The problem is a "positive" address that is non-canonical.

Testing against TASK_SIZE_MAX would catch non-canonical addresses
before the access, and we'd return -EFAULT.

But now that we don't test against TASK_SIZE_MAX any more,
non-canonical accesses will cause a GP fault, and *that* message is
what we want to silence.

We'll still return -EFAULT, of course, we're just getting rid of the

        WARN_ONCE(trapnr == X86_TRAP_GP,
                "General protection fault in user access.
Non-canonical address?");

issue that comes from not being so exact about the address limit any more.

                 Linus
