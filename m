Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C570A2EE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjESWwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjESWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:52:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DA7101
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:52:40 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55db055b412so21065477b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684536760; x=1687128760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/3ocS24eoYwGfIiVCx+gEjnY3f1UvtwZkxMJpeF2sY=;
        b=Bm7Gn5uUyfgUHvaKPJ4LmsdJPZK2xKqqBjYyzSawEtA1LUx1q99FH0bUZ8bhJXkqx0
         BjSWlp0rUtqb3tM3m9ZuvGEVk+kVvX/XEEubgANORpKrLPx4JR4A+3HXCeNbJPmfCoLt
         s76O1K/E4hO/SxtsdXpVaFvXHjR+cf5KY0bJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536760; x=1687128760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/3ocS24eoYwGfIiVCx+gEjnY3f1UvtwZkxMJpeF2sY=;
        b=B6dbgfFTjpSoMuaWAlYWWqYa8gvXdet/nUQoQbb9lIT2NKS9pBTj0t/RmJxQOAPu7e
         +gzvbCcvIbTy9BlBi2983IpYQzNHsibSKMa4h1GSrl9xV0Xm2JbZBJOe668M63lmkS3c
         Hz0fqwwGpwm1g9Z2Z/QFopsA81C1GZ65mvILEzozhrpxTO5ZTRGTDlQa9PiYA3djSLys
         yrlUoemX9Tnat9FFsLYlj4PdaQrXVTu9nxdNppvsdKYXuDIn4W/LUkaXAxmb3oMktJ8I
         9LVxjSNaBLAWAH7PxpksbjK1rd2CCl4FdAzofANCXlYlYRK3WvMIUHlaQy1kNrHJZhYY
         kurA==
X-Gm-Message-State: AC+VfDw1+sirFZm3f3BEAygayD8uI7tkqi3peLBPdrbbi4Yb1h1FuSAZ
        bsuSUgSPTUgctvRsw+6p7Bmpsc1Ew466HL6muijmXA==
X-Google-Smtp-Source: ACHHUZ7ubDlJqjJI1E7K4aq6HRBx5jm4+SfR8lOnAWCsWDXbiLMZpymdcz9+wOHWwd0FQNHTPXwVAV6gw/PonDW6jso=
X-Received: by 2002:a81:9b0a:0:b0:561:b5c7:d764 with SMTP id
 s10-20020a819b0a000000b00561b5c7d764mr3602262ywg.18.1684536759920; Fri, 19
 May 2023 15:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
In-Reply-To: <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 May 2023 18:52:28 -0400
Message-ID: <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, May 19, 2023 at 3:21=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 19, 2023 at 12:09=E2=80=AFPM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > +static bool check_addr_in_prev(struct vm_area_struct *vma, unsigned lo=
ng addr,
> > +                              unsigned long mask)
> > +{
> > +       int addr_masked =3D addr & mask;
> > +       struct vm_area_struct *prev =3D NULL, *cur =3D NULL;
> > +
> > +       /* If the masked address is within vma, there is no prev mappin=
g of concern. */
> > +       if (vma->vm_start <=3D addr_masked)
> > +               return false;
>
> Hmm.
>
> I should have caught this last time, but I didn't.
>
> That test smells bad to me. Or maybe it's just the comment.
>
> I *suspect* that the test is literally just for the stack movement
> case by execve, where it catches the case where we're doing the
> movement entirely within the one vma we set up.

Yes that's right, the test is only for the stack movement case. For
the regular mremap case, I don't think there is a way for it to
trigger.

> But in the *general* case I think the above is horribly wrong: if you
> want to move pages within an existing mapping, the page moving code
> can't just randomly say "I'll expand the area you wanted to move".
> Again, in that general mremap() case (as opposed to the special stack
> moving case for execve), I *think* that the caller has already split
> the vma's at the point of the move, and this test simply cannot ever
> trigger.

Yes, the test simply cannot ever trigger for mremap() but we still
need the test for the stack case. That's why I had considered adding
it and I had indeed reviewed the stack case when adding the test. I
could update the comment to mention that, if you want.

> So I think the _code_ works, but I think the comment in particular is
> questionable, and I'm a bit surprised about the code too,. because I
> thought execve() only expanded to exactly the moving area.

It expands to cover both the new start and the old end of the stack AFAICS:
          /*
           * cover the whole range: [new_start, old_end)
           */
          if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL=
))
                  return -ENOMEM;

In this case, it will trigger for the stack because this same expanded
vma is passed as both the new vma and the old vma to
move_page_tables().

           */
          if (length !=3D move_page_tables(vma, old_start,
                                         vma, new_start, length, false))
                  return -ENOMEM;

So AFAICS, it is possible that old_start will start later than this
newly expanded VMA. So for such a situation, old_start can be
realigned to PMD and the test allows that by saying it need not worry
about aligning down to an existing VMA.

> End result: I think the patch on the whole looks nice, and smaller
> than I expected. I also suspect it works in practice, but I'd like
> that test clarified. Does it *actually* trigger for the stack moving
> case? Because I think it must (never* trigger for the mremap case?

You are right that the test will not trigger for the mremap case. But
from a correctness standpoint, I thought of leaving it there for the
stack (and who knows for what other future reasons the test may be needed).
I can update the comment describing the stack if you like.

> And maybe I'm the one confused here, and all I really need is an
> explanation with small words and simple grammar starting with "No,
> Linus, this is for case xyz"

Hopefully it is clear now and you agree. Let me know if you want me to
do something more. I can make some time next week to trace the stack
case a bit more if you like and report back on any behaviors, however
the mremap tests I did are looking good and working as expected.

thanks,

 - Joel
