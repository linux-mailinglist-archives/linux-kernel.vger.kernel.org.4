Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5D6C9895
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 00:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCZWs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 18:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCZWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:48:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976FE4236
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:48:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn12so28735754edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679870903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fZkdxeeHkFCzAR8aqy81oHdx9YlDO1HnuZfhrn/TQ8=;
        b=eSv/r4S8HeF5JxW79ORKgU8fYq/vw/bKT+NR9Y79aZYWhgWtjPO9M1jZEUmvpDyp+e
         gBboqx3KXWTg7FNdY7YNr/4vgkMTPadAOXje14caUSXNzIe5x7ISDbWZh5W+cqe7bkpi
         6ytZ6z0e4qmBbDyEWapGtnPeLP6pPgCYYj/wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fZkdxeeHkFCzAR8aqy81oHdx9YlDO1HnuZfhrn/TQ8=;
        b=hIoe4TYsfc7rhi8qdVIJLCaz8bGoURQEDLKDnszDYF2tD1ttt/MP0taUCXncxJM+ze
         FMX35Pr6qa8eXfDIy9KOXnSo3VcHFC8c3FJ7re976tpDuI8yecf15odqu+BDiqJn0WDO
         cHo7xNjCILVxjLPcQGx1tED1tcCfxeiKle0jLf/s7Wahy6qMnT+J3y4uF3wUnfzAqhJn
         DYN6aJ7Xwx9givRVABVZcPCiCk+YnfSUdg7mcDdKr4qK/ya5bMA89zqUAI93CCynodyw
         yzBXmddKUUusbpZBJ7QA19lUrWf3KKGPIWxEmrMuFQn49FXoNmTpKWjUGHGHaY8w6VOd
         Oc5A==
X-Gm-Message-State: AAQBX9cP+kmEgUVicJYOYm5uq7uHaPIFvL1dXfT7PVtiFXAB69OZ+TEo
        zgWarfLbaq5H0hqPkrYMUXbCuwQt7fFRXx9d76QsbQ==
X-Google-Smtp-Source: AKy350Yoo55tkjwD45fh2wzOzHGS5MIBnC5sH+ptZJCr3oTX9HdCPk/AGpu3Fmq0Oc6+WuxtX3TvJw==
X-Received: by 2002:a17:906:a04a:b0:91f:5845:4e3c with SMTP id bg10-20020a170906a04a00b0091f58454e3cmr10779637ejb.42.1679870903590;
        Sun, 26 Mar 2023 15:48:23 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00914001c91fcsm13398242ejc.86.2023.03.26.15.48.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 15:48:22 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id y4so28776680edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:48:22 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:931:6e39:3d0b with SMTP id
 ne10-20020a1709077b8a00b009316e393d0bmr4811641ejc.15.1679870902220; Sun, 26
 Mar 2023 15:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz> <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
 <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com>
 <20230325163323.GA3088525@google.com> <CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com>
 <20230326022658.GB3142556@google.com>
In-Reply-To: <20230326022658.GB3142556@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Mar 2023 15:48:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOv7HL-qqH+ydLLG8rGZjQayP8FLnW4tpubVsPanbJhw@mail.gmail.com>
Message-ID: <CAHk-=wgOv7HL-qqH+ydLLG8rGZjQayP8FLnW4tpubVsPanbJhw@mail.gmail.com>
Subject: Re: WARN_ON in move_normal_pmd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 7:27=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> So for that very reason, we still have to handle the bad case where the
> source PMD was not deleted right?

Well, so our rules are that if nothing is mapped in a particular page
table directory (any level), then it must be empty.

And that "must" is actually a hard requirement, because our exit path
won't even spend time tearing down page tables that don't have any
mappings in them.

So if you were to have non-empty pmd entries that don't have a vma
associated with them, there would be a memory leak, and we really
would want to warn about that case.

End result: it should be sufficient to do something like "if you don't
have a mapping below you within this PMD, you can expand the movement
down to a full PMD".

And same with the above case.

Of course, the more I think about this, the more I wonder "is this
even worth it". Because we have

 (a) mremap() that can't trigger the problematic case currently
(because not overlapping), and *probably* almost never would trigger
the optimization of widening the move in practice.

 (b) setup_arg_pages() will probably almost never triggers the
problematic case in practice, since you'd have to shift the pages by
*just* the right amount

so in the end, maybe the "real fix" is to just say "none of this
matters, let's just remove the warning".

An alternative "real fix" might even be to just say "just don't shift
the stack by exactly a PMD". It's unlikely to happen anyway, it's not
worth optimizing for, so just make sure it doesn't happen.

IOW, another alternative could be something like this:

  --- a/fs/exec.c
  +++ b/fs/exec.c
  @@ -783,7 +783,14 @@ int setup_arg_pages(struct linux_binprm *bprm,
            unlikely(vma->vm_end - vma->vm_start >=3D stack_top - mmap_min_=
addr))
                return -ENOMEM;

  +     /*
  +      * Shift the stack up, but avoid shifting by
  +      * exactly a PMD size, which causes issues
  +      * when mixing page-sized and pmd-sized moves.
  +      */
        stack_shift =3D vma->vm_end - stack_top;
  +     if (stack_shift && !(stack_shift & ~PMD_MASK))
  +             stack_shift -=3D PAGE_SIZE;

        bprm->p -=3D stack_shift;
        mm->arg_start =3D bprm->p;

which is *really* quite ugly, and only handles the stack-grows-down
case, and I'm not proud of it, and the above is also entirely
untested.

I will delete that patch from my system after sending out this email,
and disavow any knowledge of that horrendously ugly hack. But if
somebody else takes ownership of it and I won't be blamed for it, I
would probably accept it as a solution.

Shudder. That's nasty.

                      Linus
