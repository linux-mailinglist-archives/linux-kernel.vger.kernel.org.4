Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7386AEC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCGRy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjCGRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:53:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2828EA29
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:48:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g3so55796145eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678211330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZk09D5pV/NBkHKsxPjLwaZasMmLHwZapP7AnIBpNcg=;
        b=A9Im528Kq8xKewupBI2QYrs6StYiCTRE3W+KuZy967wxchafyqIYpf/vFK5jfmg2Gz
         Ke5zLtPQgjXG1+fFFo3qxzAgG0C80uEIzidVIcy0bYOP5tpl2nzISlTv5vbEIMAun3/k
         YCpR2i6hEa1hSo1AMFJCKn7VmpW11SWjpasZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZk09D5pV/NBkHKsxPjLwaZasMmLHwZapP7AnIBpNcg=;
        b=gD5Q6X+U+EWdQWZ4AqKS0R0H4INACScmF7l6IdkTaWnPhq7/lZDgQ+/xGKXNaqIw+Z
         iTjZgG19C381DSUgKLisQgeBoPJlFItqfKBHClrQXQSPVXg3DAJ/aQEibbv+rOIMujaI
         07BQnpzEUbEu2KXGFJ360NSSA2cYtOVFRx6m8lZ4IpA2ZQ9g6eokm07cNSNtdTbnUuaH
         zUnmVHN9/r9DI2+sLzNE82srU+Gr8PekDU8Ga/jjONyYLVY8t6xAB9dkymRaa1S7I2S4
         WEgwWBhnV6xTb9iQNEOqEyOhDwnkG+Wjnee+UyFjNoJiwN+ZZ3JHK+dIujHehbYwTnWM
         40lw==
X-Gm-Message-State: AO0yUKV8n2Drdgaw0KedtxbqA7L51lZoIBjlazQ13cdZBjG/cTC6szI3
        5ZigejMA1aioL/tQK3VK/Roq7UqAqx+HqQOilep3Xaso
X-Google-Smtp-Source: AK7set9ek0v0jIrVk5JDrQH01vwA/J1zXhwKrPi7B6Yw/9b5cZ7smGrc07L2A/pAaK1hLHxMBdQK0Q==
X-Received: by 2002:a17:906:6882:b0:8b1:75a0:57fa with SMTP id n2-20020a170906688200b008b175a057famr14891433ejr.43.1678211330571;
        Tue, 07 Mar 2023 09:48:50 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id mb3-20020a170906eb0300b008e772c97db6sm6357950ejb.128.2023.03.07.09.48.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 09:48:50 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id cy23so55540455edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:48:50 -0800 (PST)
X-Received: by 2002:a50:cd94:0:b0:4c2:1a44:642e with SMTP id
 p20-20020a50cd94000000b004c21a44642emr8679892edi.5.1678211329875; Tue, 07 Mar
 2023 09:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com> <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
In-Reply-To: <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Mar 2023 09:48:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whX6g3QPA_g_ovsig8CsSHRS-vTWkdn9GCUCAZY=XPtCw@mail.gmail.com>
Message-ID: <CAHk-=whX6g3QPA_g_ovsig8CsSHRS-vTWkdn9GCUCAZY=XPtCw@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, james.morse@arm.com, babu.moger@amd.com,
        ananth.narayan@amd.com, vschneid@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 3:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> > I don't have a satisfactory answer yet, but am looking into this.
>
> Oh, geez, what a twisty tale that... So Linus knew back in '09 that "p"
> was icky, but it sorta was the only thing and it 'worked' -- until now
> :/

Yeah, so 'p' definitely is about the pointer, and I do worry that it
is only a dependency on exactly that - not the memory behind it.

I have this dim memory about us having talked about this with some gcc
person, and coming to the conclusion that it was all fine, but I
suspect it was in some very specific case where it might have been
fine for other reasons.

> Is there a way to explicitly order these things? barrier() obviously
> isn't going to help here.

So one "asm volatile" should always be ordered wrt another "asm volatile".

I have this other dim memory of it not even being clear whether "asm"
and "asm volatile" are ordered. I don't think they necessarily are
(with the obvious caveat that an asm without any arguments - a
so-called "basic asm" - is always volatile whether the "volatile" is
there or not).

I have a lot of dim memories, in other words. Should that worry me?

And then there's the "memory" clobber, of course.

But both of those are also going to disable CSE.

I do think that percpu_stable_op can use "p", but only when the value
is *truly* stable and there is no question about it being moved around
things that might modify it.

                         Linus
