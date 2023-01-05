Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C676D65E2B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjAEBxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAEBxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:53:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B371EC61
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:53:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so2788203wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ss9yhGcodWv1DQGxova2CHsdFFoeyn3lh8mVFJsJXkA=;
        b=OE2yoCmNzsZVAQi3rSz26k+QZIZuIfQ3AtDLS5DmPR8LsvHBwOIf6ylf5Fjyc4e9S/
         QIr5/QSpvQrWnmXSwlr4ezEc6i0j9x+6h6D5cS2fzrNm9fxmOgAGOvAYk2G064ZZBoNn
         Pqfy1hdYxUXrLC3W2Zyqx0BkB9aGzGTtHrFJ91NkrZ641gCIR87oZwwEgO0fsUeSICTq
         xewdniGh3QxOmySuXp4uFVHitTl2bGU7Cl054FzG+vjvEhxIdTHf4u0ISYrBRN6cioyb
         4PFv4fMFbbYcYPIY7MwkHaspC4r4wsndN6wX54EmcwpU3tqy3AiJpkIHBJwwkTrUDujD
         CepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ss9yhGcodWv1DQGxova2CHsdFFoeyn3lh8mVFJsJXkA=;
        b=lbGisGdOttrmIJIXcdOwaYDeYnkeFfBNIWnviX3EKvT2eXikYwYL2LcKpoJ2sMjCaI
         FSj58ZlK39bHa6bYWIrfGe4SlkdSrwTzcdQOliyKI7mY1Z/4ySwGxCSWQKwks01Kw2+W
         8+nyPnvHImYVsCoOOCEp4PmSx4tLWbHmH49wO7K7TEBL5b9cwPUZYty3j1ljCb+T76iC
         rE7w4E/bmIFI5cOsVxcDcaDfatOj0mzSy5AyS08R38xpcxjd4Snv/s2tT5jl2OjdB0fV
         /4XKwCTR1wovVt6uiTjxkvmF3U6UpcWNAA3BI2ukAfbCxyKdP7aorY9h4maxAL5r0VTI
         7KgA==
X-Gm-Message-State: AFqh2krTtVbOCH4IHByt20IOLb08Cp0D+kswx41BOHyGyzMxPSwOnCEu
        820KasGqn+EV4ZvrEimNoo5l41IO7V1U/vxp5tGVzg==
X-Google-Smtp-Source: AMrXdXvHftDidmOqzjrCPQSF/Gf47TdU8ko2g5NM1kxKona6P4fGn+QyxnKMu64Yd7SgiR6WS2L83XW7z2JNTR26u7E=
X-Received: by 2002:a5d:6148:0:b0:280:91ea:29b7 with SMTP id
 y8-20020a5d6148000000b0028091ea29b7mr1044383wrt.98.1672883588801; Wed, 04 Jan
 2023 17:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20230104225207.1066932-1-peterx@redhat.com> <20230104225207.1066932-4-peterx@redhat.com>
In-Reply-To: <20230104225207.1066932-4-peterx@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 5 Jan 2023 01:52:56 +0000
Message-ID: <CADrL8HVGNPWrhBNgpofgt1kpc5-rCm3GKAFwbupm6_3i6=OBaA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 4, 2023 at 10:52 PM Peter Xu <peterx@redhat.com> wrote:
>
> Before this patch, when there's any pgtable allocation issues happened
> during change_protection(), the error will be ignored from the syscall.
> For shmem, there will be an error dumped into the host dmesg.  Two issues
> with that:
>
>   (1) Doing a trace dump when allocation fails is not anything close to
>       grace..
>
>   (2) The user should be notified with any kind of such error, so the user
>       can trap it and decide what to do next, either by retrying, or stop
>       the process properly, or anything else.
>
> For userfault users, this will change the API of UFFDIO_WRITEPROTECT when
> pgtable allocation failure happened.  It should not normally break anyone,
> though.  If it breaks, then in good ways.
>
> One man-page update will be on the way to introduce the new -ENOMEM for
> UFFDIO_WRITEPROTECT.  Not marking stable so we keep the old behavior on the
> 5.19-till-now kernels.
>
> Reported-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: James Houghton <jthoughton@google.com>

Thanks Peter! :)
