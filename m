Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111616D4A74
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjDCOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjDCOqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:46:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E928E90
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id br6so38367673lfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680533190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Is/5kUiz89V8Gf8TcMES1IfV2tlSCSl8CHRGwQyg8=;
        b=qkquT762YNUWctaKrmxGMiZPhyAN60ukJofAYr6gO92rEkvDQ6Hmk+0/ttUJ/v5o4B
         mXaKA0/9+8wtNx2/9VhAhfB/dogsedaNQlqIWBpsHIQVeCBQG0lpO6aG09tH8KZGiqmq
         +rgygjuG8uw6iD3Pf81J+o29gU3EGOk9DuocB1mwF3xo9hEmS+5M0D30PA0+fxHMnTN/
         tg0YQmiwSTe543/D6MNaSFa95bKc41cQfUkpbErcl1h7Ts2RWHfDrK8J6VG0pgDsNeXm
         rjHTn5+0Mv1j2s7dvPX0w3u2TuMr5LfaDX7kf6AR5/etzmXzjpj/efnrVQb8rFrA3hWl
         cmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0Is/5kUiz89V8Gf8TcMES1IfV2tlSCSl8CHRGwQyg8=;
        b=feM7og6EsLAbjExn9kPDkYPmkqk5o8MNMcnbxFUsiWn3zTpxSnaV+/sGqFEYanBy6w
         aoZeBbZSO5miX6WFSlxKQNprA149ILNTUwvbEdBwLwsBe1hm8DidvwkNydalpQxITdr/
         PheLR//AKExCdI2C/dlDy47wOoiuQ1p9vWdDouK2gxHHPMzNRg6HXdLnaVeb+YhkvKRu
         cfl9WWmpUOy+RsIMFhvsgGefRliCiiPeDBj6LCPW9ey94WAAk0NqzwAzsDTbCYl6DOgg
         zjD8i9NVPm7wuRzpUNsFmGmS24S15lBdU+2tSQZJIlZaKjWYcWc4UQETTDikFvJfTv82
         3qMA==
X-Gm-Message-State: AAQBX9dZA42gUVMaVuGN5fDW5TTYhayksgcO3MA2h/aoQU9fNWpxhFqp
        bFvF1i0AZyC8blpB/duj+l0GBXSnRemm+U7JMBIwAA==
X-Google-Smtp-Source: AKy350bSnPbpTlbAAvYcUmy4R3hDL0x8lXGAvTZEJHWaFCgLjWFcMb6Y89j6TauNU7RLIDG5XKlA23YDTz184TJyw1Q=
X-Received: by 2002:ac2:485b:0:b0:4d5:ca32:6ed8 with SMTP id
 27-20020ac2485b000000b004d5ca326ed8mr5673856lfy.6.1680533190490; Mon, 03 Apr
 2023 07:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
 <20230403111020.3136-3-kirill.shutemov@linux.intel.com> <CACT4Y+YoS9e=QVq6iKda5Gv852kVv9OTLaOZ=XCJ65mP0oyAOA@mail.gmail.com>
 <20230403143105.rj4l5tqn43t3zcnh@box.shutemov.name>
In-Reply-To: <20230403143105.rj4l5tqn43t3zcnh@box.shutemov.name>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Apr 2023 16:46:18 +0200
Message-ID: <CACT4Y+Z-2qbTSuPYAumg+TU8xnx4-yF1CQ46_D4=wjTebpQKDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/mm/iommu/sva: Do not allow to set
 FORCE_TAGGED_SVA bit from outside
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
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 16:31, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Apr 03, 2023 at 03:55:09PM +0200, Dmitry Vyukov wrote:
> > On Mon, 3 Apr 2023 at 13:10, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > arch_prctl(ARCH_FORCE_TAGGED_SVA) overrides the default and allows LAM
> > > and SVA to co-exist in the process. It is expected by called by the
> > > process when it knows what it is doing.
> > >
> > > arch_prctl() operates on the current process, but the same code is
> > > reachable from ptrace where it can be called on arbitrary task.
> > >
> > > Make it strict and only allow to set MM_CONTEXT_FORCE_TAGGED_SVA for the
> > > current process.
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
> > > Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > > ---
> > >  arch/x86/kernel/process_64.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > > index c7dfd727c9ec..cefac2d3a9f6 100644
> > > --- a/arch/x86/kernel/process_64.c
> > > +++ b/arch/x86/kernel/process_64.c
> > > @@ -885,6 +885,8 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
> > >         case ARCH_ENABLE_TAGGED_ADDR:
> > >                 return prctl_enable_tagged_addr(task->mm, arg2);
> > >         case ARCH_FORCE_TAGGED_SVA:
> > > +               if (current != task)
> > > +                       return -EINVAL;
> >
> > prctl_enable_tagged_addr() checks "task->mm != current->mm".
> > Should we check the same here for consistency? Or also change the
> > check in prctl_enable_tagged_addr().
> >
> > arch_prctl() can only do task==current, so I guess "current != task"
> > is a more reasonable check for prctl_enable_tagged_addr() as well.
>
> As of now, prctl_enable_tagged_addr() doesn't have the task on hands. It
> gets mm as input, so it cannot check the task directly. But functionally
> it is the same check.
>
> I would prefer to keep it this way. Unless anyone feels strongly about it.

Fine with me.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
