Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5416163F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiKBNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKBNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:37:58 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893842A961
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:37:56 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 187so21219676ybe.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20+jPjAz1Ru1ioQ+9Mris24WBI3NxGkmmf7N7L/+EgE=;
        b=e7qQu9cim/64+l+NdWFLloKj1Sj1l+tsXVXD8tLCYXnV5WTNWnf8vWfOIO87lpenOd
         RcEuiGs1eLeaIPWKKB/lELsBXw45dOWaynr3aUMMYUU8nveDvnJ8Wlny2SZQrK1H2hdc
         D+wWnoSB4qaxuxY4hh8BIgwzXrhK5oNBzzB4YuD2lR4ojjWoYuiw4mniMo+xbheV7uPr
         +Z1mHTCYajjZ4RuhjLr/2LtuOqCkks7dzYz2+Yzuf8iAQLkqLLB1lzf2/Es3ExIvpvdL
         JbCcYf0Kttm1o58eckeBZFUjfd+VRnU2OcJzYAlIo4rrPmT4SUW7mr/NdFoxmOwdj9YG
         Kh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20+jPjAz1Ru1ioQ+9Mris24WBI3NxGkmmf7N7L/+EgE=;
        b=qd8cwK23rhCLb/y3rPsHtDi4qUXRZxKwNxK30ho1KLElsHbF6WQmviDxuKogRIb6YS
         yUaoIUXL+HwvnP4hvj1B3iDb5P/fvcektBDBsy72OTUaHT3VPot7Q+Mhkv3eP+Xchl0k
         XKr2efkxGJ87KMezlKiTuI1zbYRX0Gynz2gs+fp1PU6RJsy/IJHy4gQFaWBOh3NST2ef
         tkHU5czpvtMdMcvWLR8lQdlwjPcbMexxZyVIu74Gk91J2qtNbm+iS1UleEmgV3GW5Sxa
         pwD5b2nWxXWNi1wv/FkYJmpeUYboos5Crsa95CZO7Qle+fq+3JUpG1gkDco80LWM3Yx7
         +uQA==
X-Gm-Message-State: ACrzQf3ug8mLvS47WtYutecxFb77eXYjddyEB+CU7BmNkBGCXZqJiFHa
        3NeKo/HpFjbeRyEgDmnwQLoDojbt/IxLOokqwKOY5Q==
X-Google-Smtp-Source: AMsMyM5msGxB2yjxh22chfUxH/SbSBaPN569yFH3bWPf17KpM0DvM3YkegTNb/rB0MgvJntmkDHlK0QMzsQsiwMono8=
X-Received: by 2002:a5b:a44:0:b0:6b0:13b:c93b with SMTP id z4-20020a5b0a44000000b006b0013bc93bmr24042422ybq.398.1667396275572;
 Wed, 02 Nov 2022 06:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221102110611.1085175-1-glider@google.com> <20221102110611.1085175-5-glider@google.com>
 <Y2JnsG5QZoO4iazD@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2JnsG5QZoO4iazD@hirez.programming.kicks-ass.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 2 Nov 2022 14:37:19 +0100
Message-ID: <CAG_fn=X_92f1w9=Xuj6eYcF9Za3rbpeGe+P79fJ8mkgEQO1XYA@mail.gmail.com>
Subject: Re: [PATCH 5/5] x86/traps: avoid KMSAN bugs originating from handle_bug()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 1:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 02, 2022 at 12:06:11PM +0100, Alexander Potapenko wrote:
> > There is a case in exc_invalid_op handler that is executed outside the
> > irqentry_enter()/irqentry_exit() region when an UD2 instruction is used
> > to encode a call to __warn().
> >
> > In that case the `struct pt_regs` passed to the interrupt handler is
> > never unpoisoned by KMSAN (this is normally done in irqentry_enter()),
> > which leads to false positives inside handle_bug().
> >
> > Use kmsan_unpoison_entry_regs() to explicitly unpoison those registers
> > before using them.
>
> As does poke_int3_handler(); does that need fixing up too? OTOH look
> *very very* carefully at the contraints there.

Fortunately poke_int3_handler() is a noinstr function, so KMSAN
doesn't add any checks to it.
It also does not pass regs to other instrumented functions, at least
for now, so we're good.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
