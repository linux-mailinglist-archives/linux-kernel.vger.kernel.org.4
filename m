Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117426A9FBE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCCSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCCSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:55:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93D17152
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:55:21 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q189so2062416pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677869721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7wlGDroZzOg+2IjAVas7e/KeaMFCpHiT+RVQL9gPBs=;
        b=DWFAH5M/qFHxUMQx0oKMPW/xb7JKmBEfDR/f4aTRQPFOLhXXydFA8V272o49Dwu+pN
         JoerO1de1Pm3ZeRJR8ch6VamHzgY63wim3VrWx8OQDTZBjmJ2pXMQOyMYRfWNpvMGuuW
         zyFQAjyc0PpAS7+ywQnQaxyUB2iBMzdAf75ZntaULB9DDv/RkUIFJDXt017jWKcJ92wW
         TLvy6wIyiB36g+E2Ok4koq3SaDOlGa+MHMUoa5SMpTce/m+Ttco3ne7xiC4SNHtb/VyV
         3oJA1u2MnlryGNXXJ+sIwMiyFEHHFYkzm7BRiOPEnTKmtIOypzgSg7mT+i+OvkjvOJLe
         cRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677869721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7wlGDroZzOg+2IjAVas7e/KeaMFCpHiT+RVQL9gPBs=;
        b=y3sMkb9f19JEofdsPjkR/cfCPmeoGWja4Uwl+hh7U4+QLiQ/gROji86UmhQbRal3/e
         /EtuZc9X7lj1GmkcWH6sisS/u+TCk6j0wBwabLSm8owF5Vh9S5KAA6hKGeFNjBruqNFP
         zsau39SBVIrr+Us17VhmdT3VwYn5C0l/Zv+jNI4rUPx+KipfRHXs18a+5cb1rDFSrMJA
         Bl9J0po2CGmIRFwmds+l3AK1r7bMWFBHRoN9yOCmzZCbV+d0ZTbo5Nhe/xYOvLIU3lDp
         EOrEFM98zcI/aaIGK6e+OQoXmayDW7sg6hJv35C/etUTsDKcQCSRUrdL3k84s9uniVSB
         mtMA==
X-Gm-Message-State: AO0yUKV/BJCgKBTxbSGQMeqaTbzU36KJMKzAeaYgPpJe8EuAd/Ui7T+I
        OOOlzAZJECjSuEfmmVxAgrnNdcyIKdNed6u8FWA=
X-Google-Smtp-Source: AK7set8dmoPgvy6q2h3W+WcuHxL1wFt0qmnk/vBnXIwlYMiQHjtBrLN/BBCnWiOrjnPeu7tzgHM2B+WVk+4EViFRRF8=
X-Received: by 2002:a63:7e11:0:b0:503:913f:77b9 with SMTP id
 z17-20020a637e11000000b00503913f77b9mr855552pgc.6.1677869720669; Fri, 03 Mar
 2023 10:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20230217085439.2826375-1-stevensd@google.com> <ZAIT2YI4WrzZK5NK@x1n>
In-Reply-To: <ZAIT2YI4WrzZK5NK@x1n>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 3 Mar 2023 10:55:09 -0800
Message-ID: <CAHbLzkp1HdbSJsef2qvVt5txWHE36vj3h3=L=G74eXxjj6cmyA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm/khugepaged: fix khugepaged+shmem races
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 7:35=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Feb 17, 2023 at 05:54:36PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > Fix two races in khugepaged+shmem that cause issues with userfaultfd an=
d
> > lseek, respectively.
> >
> > v3 -> v4:
> >  - Base changes on mm-everything (fba720cb4dc0)
> >  - Add patch to refactor error handling control flow in collapse_file
> >  - Rebase userfaultfd patch with no significant logic changes
> >  - Different approach for fixing lseek race
>
> I just noticed this one hasn't landed unstable, so I guess I just posted =
a
> trivial cleanup that can conflict with this so it won't apply cleanly..
>
> https://lore.kernel.org/r/20230303151218.311015-1-peterx@redhat.com
>
> The resolution will be fairly straightforward though, and I'm happy to
> rebase that one to this since this targets a real bug so should have high=
er
> priority.
>
> I guess it's possible Andrew thought the series has unsettled comment so
> Andrew could just have ignored that whole set in the mark ups.  A repost
> could possibly clarify that.

IIUC this series should need to be rebased on top of your clean up patch?

>
> Again, it'll always great to get another eye on this slightly involved
> series. Matthew / Yang were already on the list, also copying Zach for hi=
s
> recent works on khugepaged just in case he spots anything wrong.

I had a quick look at it before, I didn't recall I spotted anything
wrong about khugepaged, but I'm not familiar with userfaultfd.

>
> Thanks,
>
> --
> Peter Xu
>
