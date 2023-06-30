Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357FA744112
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjF3RVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjF3RVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:21:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE46ADF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:21:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69a48368fso33365231fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688145699; x=1690737699;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0PDtKbr7ijXKVXGOWfxwXRpuZD8qaZkn5kn5qp/Sek=;
        b=ZJ4WyDcIuqxvrl+ewKq6azbzQY14+MLu5j5WIbz3STR4cuReFcoYpWud7q7D1or0Ap
         N0jmeITxYPM1dnTKDkciY/11NtLyMbIvnZzUqpfHAVzCqd+yYdX019h2UgFr9lzGEcav
         jJvsDVYe5UiBit8lAcyPSya0SP4BZpcijWfqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688145699; x=1690737699;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0PDtKbr7ijXKVXGOWfxwXRpuZD8qaZkn5kn5qp/Sek=;
        b=VYed7ID2D9ffr8QjOf+YPUB4ogrR1HMfs6soF03ut6y4hPsxUKFyrdpMcqj8Vjhp7j
         zqUmmUe8jY9r3KZsadXGsjFDBaHw+vrOAwnWeNUO4ZImhQwKi9axKeGt6U3RsWpDLt/4
         F4oiC0bEu9M8r/kuNZgUBI6xUK7f2Rsxb51wMtRuUASBydVcpXbcDpok23ccx01KQ9Ci
         pcxqhTGP1/Vx9vlz+cH4ZbSXTY4LyebKfjRV6wfRxqAQ1sqeTZszHreJtwKKPxAPOhfn
         uD7FgTu1x+etsV1utWlPmzK/nbnK21JN5QoKGuJUwRuAbsTB3DApS1bxcGfUYWqRNUvr
         9Gzw==
X-Gm-Message-State: ABy/qLb5dzqpAaZSdfPt91lbVZTunUHVRYUdbzLo8LsiR3Fzx/VRXyvi
        qn3Ht74Msv8Dav5jLiT1RutEnYalHzpmMCtL5Mos2yzx
X-Google-Smtp-Source: APBJJlH78CqLlnH4noMkT8MmpRygQqb93cuI2YUboSjYb0r5ezW26y7AQoGViTPQyHfwxK34zyUGXQ==
X-Received: by 2002:a2e:8ed2:0:b0:2b6:a3a4:f7e8 with SMTP id e18-20020a2e8ed2000000b002b6a3a4f7e8mr2474112ljl.17.1688145698807;
        Fri, 30 Jun 2023 10:21:38 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id lc6-20020a170906f90600b0096637a19dccsm8216522ejb.210.2023.06.30.10.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 10:21:37 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51dd1e5a621so2533463a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:21:37 -0700 (PDT)
X-Received: by 2002:aa7:df84:0:b0:51b:ed1f:378c with SMTP id
 b4-20020aa7df84000000b0051bed1f378cmr2413618edy.3.1688145697543; Fri, 30 Jun
 2023 10:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <wiuXi4KmjgTocOZMpHTZuZP+y8r5wYynvvT_ZPXyG+TYA@mail.gmail.com>
 <20230630160519.3869505-1-Liam.Howlett@oracle.com> <CAHk-=wg=DGSsA+=rr3bMDKrGNgy4C+PGM_w2PtpK4+Sx9qFF8w@mail.gmail.com>
 <20230630164135.725ewvttype5tt6x@revolver>
In-Reply-To: <20230630164135.725ewvttype5tt6x@revolver>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 10:21:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpsY9MC-VyjO3j0OLWYRBZrctZZm-v=szTBh9JwfWEiw@mail.gmail.com>
Message-ID: <CAHk-=wjpsY9MC-VyjO3j0OLWYRBZrctZZm-v=szTBh9JwfWEiw@mail.gmail.com>
Subject: Re: [PATCH] mm: Update do_vmi_align_munmap() return semantics
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 at 09:41, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> I hesitate to ask considering how much trouble I've caused with the
> 32bit map flag, but I also wonder about the stack guard now that the
> write lock is taken for stack expansion?

Which part of it? We have a lot of special code wrt the whole thing
that came from how we did the expansion that probably can - and should
- be cleaned up.

For example I didn't want to go remove our ad-hoc locking, so we still
do that "mm->page_table_lock" thing.

And I think the stack expansion does several things differently from
the "normal" vma games in general, because it explicitly didn't want
to use the normal "merge vma" code because it didn't do real locking.

But you're talking about the general issue of having a stack guard
area at all, _that_ isn't affected by the locking.

That was always a real semantic issue of "we don't want user space
stack growth to possibly grow into another vma, and because the stack
growing isn't strictly predictable, we need to have that guard area in
between to catch things when they get too close".

So the stack guard isn't there to protect stack vma's from merging.
It's there to protect users from mistakes.

And then we have all those very rare situations where we *do* want
stacks to merge, and the guard goes away, but we currently do *not*
call vma_merge(), and just leave it as two adjacent vma's because we
used to only have a read-lock.

End result: I do think that doing the locking right means that we may
be able to clean up some other code. The odd do_vmi_align_munmap()
case is just one of the more egregious special cases.

              Linus
