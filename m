Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673A3659FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 01:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiLaAm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 19:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiLaAmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 19:42:24 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6843D1D0C8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 16:42:23 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c11so18238530qtn.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 16:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv+uaGor/dFf3uRzSMPbhI3giYMYL0ciKPN6qVvhgew=;
        b=LsSISpjXK233Q0blGUZutaAad5E4+i3r2l4D42x2x/B+rH8n6gvjqZwzOzYl/H0A30
         VGvGb7nxNEAsKTTG7LZ71NbJ5dy9UpZ+ro21VXi+94QTdWrOiNAzyoWKqjWwuG+5dJlM
         DjL9rf9apjZU3onlhTlbeMwh0E7vsnOhLmbVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hv+uaGor/dFf3uRzSMPbhI3giYMYL0ciKPN6qVvhgew=;
        b=q9+Bbc9cRtvBTFq/GkdWallg0c+PTmJIGCvOSt2zr2QeTnWfTLQGUVoG9t2HuDHw6M
         cKfE8b0KvbOw6nd4xZkR+UdTJlUk8bXzOMKzmEPLgjNbS47vhTIYcZX/XSx/O0K2jHFD
         Vmbpg6evIziHXcZ8ogesw6ZTKCOIhkwZVZ9yYbrQQ1gJkG7MHkR6nwf8EurPJ90IKkB2
         DuyJqmsaUDoTA+7dpUim84fXul2bmDk7jtQ+SmraGJeClCgRLO/2hSfhOjvjPOU3D7N7
         Sw1OS5ATt31ZopHYmjnjM3dQDxalw/9oQLhyywVL2LNMu/EgM5NRGB9VR/KWcwrSkAnl
         +NWA==
X-Gm-Message-State: AFqh2krrblVOZfl+fFo+tHfuZY0JGZ7W5YmFkiGmiW384Et4arpJ8WTV
        FcA9ThRq+C+vDFp4o6CFsi2SBSscnFg8TVGR
X-Google-Smtp-Source: AMrXdXuKfKmUUKl4RzC2EXbrW5BL8+eWmJ+E1f+YknrMgGNx5mFQcN3Q+F+9AutGMG3MnrMV0vf7hw==
X-Received: by 2002:ac8:524c:0:b0:3a9:7dd5:6a33 with SMTP id y12-20020ac8524c000000b003a97dd56a33mr52932299qtn.64.1672447342183;
        Fri, 30 Dec 2022 16:42:22 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a244b00b006cebda00630sm16314506qkn.60.2022.12.30.16.42.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 16:42:21 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id h8so10968034qkk.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 16:42:21 -0800 (PST)
X-Received: by 2002:a05:620a:4720:b0:6ff:cbda:a128 with SMTP id
 bs32-20020a05620a472000b006ffcbdaa128mr1591268qkb.697.1672447340840; Fri, 30
 Dec 2022 16:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-6-kirill.shutemov@linux.intel.com> <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
 <20221231001029.5nckrhtmwahb65jo@box>
In-Reply-To: <20221231001029.5nckrhtmwahb65jo@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Dec 2022 16:42:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
Message-ID: <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
Subject: Re: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
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

On Fri, Dec 30, 2022 at 4:10 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I made it a per-cpu variable (outside struct tlb_state to be visible in
> modules). __get/put_user_X() now have a single instruction to untag the
> address and it is gated by X86_FEATURE_LAM.

Yeah, that looks more reasonable to me.

> BTW, am I blind or we have no infrastructure to hookup static branches
> from assembly?

I think you're right.

> I would be a better fit than ALTERNATIVE here. It would allow to defer
> overhead until the first user of the feature.

Well, it would make the overhead worse once people actually start
using it. So it's not obvious that a static branch is really the right
thing to do.

That said, while I think that UNTAG_ADDR is quite reasonable now, the
more I look at getuser.S and putuser.S, the more I'm thinking that
getting rid of the TASK_SIZE comparison entirely is the right thing to
do on x86-64.

It's really rather nasty, with not just that whole LA57 alternative,
but it's doing a large 64-bit constant too.

Now, on 32-bit, we do indeed have to compare against TASK_SIZE
explicitly, but on 32-bit we could just use an immediate for the cmp
instruction, so even there that whole "load constant" isn't really
optimal.

And on 64-bit, we really only need to check the high bit.

In fact, we don't even want to *check* it, because then we need to do
that disgusting array_index_mask_nospec thing to mask the bits for it,
so it would be even better to use purely arithmetic with no
conditionals anywhere.

And that's exactly what we could do on x86-64:

        movq %rdx,%rax
        shrq $63,%rax
        orq %rax,%rdx

would actually be noticeably better than what we do now for for
TASK_SIZE checking _and_ for the array index masking (for putuser.S,
we'd use %rbx instead of %rax in that sequence).

The above three simple instructions would replace all of the games we
now play with

        LOAD_TASK_SIZE_MINUS_N(0)
        cmp %_ASM_DX,%_ASM_AX
        jae bad_get_user
        sbb %_ASM_DX, %_ASM_DX          /* array_index_mask_nospec() */
        and %_ASM_DX, %_ASM_AX

entirely.

It would just turn all kernel addresses into all ones, which is then
guaranteed to fault. So no need for any conditional that never
triggers in real life anyway.

On 32-bit, we'd still have to do that old sequence, but we'd replace the

        LOAD_TASK_SIZE_MINUS_N(0)
        cmp %_ASM_DX,%_ASM_AX

with just the simpler

        cmp $TASK_SIZE_MAX-(n),%_ASM_AX

since the only reason we do that immediate load is because there si no
64-bit immediate compare instruction.

And once we don't test against TASK_SIZE, the need for UNTAG_ADDR just
goes away, so now LAM is better too.

In other words, we could actually improve on our current code _and_
simplify the LAM situation. Win-win.

Anyway, I do not hate the version of the patch you posted, but I do
think that the win-win of just making LAM not _have_ this issue in the
first place might be the preferable one.

The one thing that that "shift by 63 and bitwise or" trick does
require is that the _ASM_EXTABLE_UA() thing for getuser/putuser would
have to have an extra annotation to shut up the

        WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in
user access. Non-canonical address?");

in ex_handler_uaccess() for the GP trap that users can now cause by
giving a non-canonical address with the high bit clear. So we'd
probably just want a new EX_TYPE_* for these cases, but that still
looks fairly straightforward.

Hmm?

              Linus
