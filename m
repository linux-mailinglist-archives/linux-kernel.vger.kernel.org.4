Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948DD670A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAQWBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjAQVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:48:05 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA677495D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:10:21 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e8so7252700qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNFni7Rgr3eQM2tShZ3fPnjMab/wLpj7M+t9eYmmNw4=;
        b=OiGs/qOOajehCduepkfEcpG8axNVtd4tbOgOWt02uJ83iC16JDlEf/zlF2d6GjReiB
         c2GFYK1+u/tXXdt73yLm4VUQcW39gVKE5rF2mtzMzX+UMGHDE3VTw0nW+YlyiTh4UGrv
         I+sqk4OwgrppTiVKoB5sCf19dVIgaNbLkKY5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNFni7Rgr3eQM2tShZ3fPnjMab/wLpj7M+t9eYmmNw4=;
        b=BXro9fWH/Sg3aE/jnu1HE+uII5toTlFyK11w/2oum1DHCWdB3NBjDOwbn+Fj9JRTbA
         Ca6IVQrIpwVCDkuuZ7guyqL8j+TsUbaB0pgJ+vtn2QFPjyitQdJbbp18bZAq636A/XJO
         bx/5qfGMRble77Jes7s6chFwaa5CnBs2tidUrmY2gRWUdtw2iuaU3PdKrrogxZs7wLGF
         Ai5WDC9J9GjXlgx10aa70ZalBVXswsnMFoJKvx07GCUqPGGaZZUT5EBvqfUPtmwXbpIR
         WbcFpoSAdm/3/pyNGnHPW9KQq416wkvq0/7YnkjwuY1tySPUdK+QHNd7r9do0jKV0/FI
         TBoA==
X-Gm-Message-State: AFqh2kp68iLJF4tnaXK57g28+M0albzIjKzx83hNosbWOeCXGGYwhxcA
        bTgVa9STOtd585jNDkljowRkgq68PnFZi4tw
X-Google-Smtp-Source: AMrXdXsz+T2W8fq8J45nJk5Rk5UeMkUCNNfS2rhCiGTFzaNcd753xbBTmKWWsdeydSERAyorw5UKng==
X-Received: by 2002:ac8:540a:0:b0:3b6:461e:afec with SMTP id b10-20020ac8540a000000b003b6461eafecmr1362388qtq.31.1673986220410;
        Tue, 17 Jan 2023 12:10:20 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id w17-20020ac843d1000000b003b62bc6cd1csm4525521qtn.82.2023.01.17.12.10.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 12:10:20 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id k12so1500006qvj.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:10:19 -0800 (PST)
X-Received: by 2002:a05:6214:5d11:b0:531:7593:f551 with SMTP id
 me17-20020a0562145d1100b005317593f551mr220481qvb.89.1673986219572; Tue, 17
 Jan 2023 12:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com> <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box> <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
 <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
 <CAHk-=wj4HUBvCvfX3oZLZAZTzPc2vdwsObFqnOsQ-UZrdzm_rQ@mail.gmail.com>
 <CAKwvOdnCJmcGurUpHcdO44vVazz67jGDTXzug9LGv6C84xGmPw@mail.gmail.com>
 <CAHk-=wjfmmYPw0wX1BW6gi_KAhdZi+81or024JFcRYHiQh-jpw@mail.gmail.com> <CAKwvOd=fcF=y-mBtPZ9QcVe++__jo11St4=+roPKrGh5D6FH_g@mail.gmail.com>
In-Reply-To: <CAKwvOd=fcF=y-mBtPZ9QcVe++__jo11St4=+roPKrGh5D6FH_g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jan 2023 12:10:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggKAKq1k0Z+EdWR0W9ULM7x9MhEbd_LmU2XPLM9WcjkQ@mail.gmail.com>
Message-ID: <CAHk-=wggKAKq1k0Z+EdWR0W9ULM7x9MhEbd_LmU2XPLM9WcjkQ@mail.gmail.com>
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        joao@overdrivepizza.com
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

On Tue, Jan 17, 2023 at 11:17 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Perhaps that was compiler version or config specific?

Possible, but...

The clang code generation annoyed me enough that I actually ended up
rewriting the unlikely test to be outside the loop in commit
ae2a823643d7 ("dcache: move the DCACHE_OP_COMPARE case out of the
__d_lookup_rcu loop").

I think that then made clang no longer have the whole "rotate loop
with unlikely case in the middle" issue.

And then because clang *still* messed up by trying to be too clever (see

    https://lore.kernel.org/all/CAHk-=wjyOB66pofW0mfzDN7SO8zS1EMRZuR-_2aHeO+7kuSrAg@mail.gmail.com/

for details), I also ended up doing commit c4e34dd99f2e ("x86:
simplify load_unaligned_zeropad() implementation").

The end result is that now the compiler almost *cannot* mess up any more.

So the reason clang now does a good job on __d_lookup_rcu() is largely
that I took away all the places where it did badly ;)

That said, clang still generates more register pressure than gcc,
causing the function prologue and epilogue to be rather bigger
(pushing and popping six registers, as opposed to gcc that only needs
three)

Gcc is also better able to schedule the prologue and epilogue together
with the work of the function, which clang seems to always do it as a
"push all" and "pop all" sequence.

That scheduling doesn't matter in that particular place (although it
does make the unlikely case of calling __d_lookup_rcu_op_compare
pointlessly push all regs only to then pop them), but I've seen a few
other cases where it ends up meaning that it always does that full
function prologue even when the *likely* case then returns early and
doesn't actually need any of that work because it didn't use any of
those registers.

But yeah, the RCU pathname lookup looks fine these days. And I don't
actually think it was due to clang changes ;)

                Linus
