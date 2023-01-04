Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45865DC0B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjADSYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjADSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:24:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6D1B9EE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:24:16 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c124so37481017ybb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KxFSAeIQaZ8kk0GXJhXrmy8k/ZlTX7XxQ3u7wqBqzBs=;
        b=YJS1LnExeamCNJAbrtg2PnEtWZU1IrvxBWzYRgGDcjZcQaZC9cjUdy3lbhKZeA2JEA
         +4mCGuPlCj8XRLGRtawqjnW0kyvJcFKaiRxDwjJOI0h/6YzyHsqk8kBKgcC/L6a1Vuvo
         4E8CHjqOl/yXT7MIJOIdf3woNrLCunLBnoz+pBYpvKt9KxwQlVESIYheKTrmdNSN3WWg
         ZAcdvxNQBLEvUJUpxFk+T/Hs1j6w6k/agMH5J1ugEoRRZYykhFbVyjPdMBa2y2gqgy2C
         eB7MPF9relmzFoxjlThYd699W4ayeJh2AKdksCUFOOEuT+lJdMckTAhUiSiip67oCfk7
         0rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxFSAeIQaZ8kk0GXJhXrmy8k/ZlTX7XxQ3u7wqBqzBs=;
        b=yycJyLlv408ZGBcnlZhbZhR/Wz5mkEtf2ad8KNLbsEm3rf7p6bjXPTBSxGigONDH5d
         R0VF4fm099RgMi6ZhClsADx04JTYnFDvaEDnZJygz67RJPgYHzabGEgmqHZjbjgK2cAf
         tpK7c06khDxYl/TTZQ5HptfdUt26bLe9qIZRMu/QF9Tb4RQmjRbf0YoQMysf38yG2tu5
         J9LAA2u9sjWMku9qmQ63VYj1YJctTD+ZerVEtJTefB790hYQr7CyittF9u5MzV3jUFaw
         4DCTE9Kc3C3RAjKQFfish4j0Tat6oy2Kzy865TIIudQ5RKz1oAMjSJeyCBI1WTJSam7E
         FHVw==
X-Gm-Message-State: AFqh2ko25mUu3ECgk2KyCBrOoY4d2XCwd/tLT2Cqd1quLLoU9gxBjl32
        j2oqvPvg0aLOiN7Df/RNVmKC1eVQWLwGSXNyMOpzXQ==
X-Google-Smtp-Source: AMrXdXvUwl8o6DfThWFhqJEq7nM/XEsZYO493gPYNkjXoA33zsGhsbnOVROL9yMdxYEzzmHtfHq4IdxFIxwhkzG4RYk=
X-Received: by 2002:a25:a292:0:b0:7b3:7fc6:2d52 with SMTP id
 c18-20020a25a292000000b007b37fc62d52mr182755ybi.340.1672856655114; Wed, 04
 Jan 2023 10:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20221228194249.170354-1-surenb@google.com> <6ddb468a-3771-92a1-deb1-b07a954293a3@redhat.com>
 <CAJuCfpGUpPPoKjAAmV7UK2H2o2NqsSa+-_M6JwesCfc+VRY2vw@mail.gmail.com> <b3aec4d4-737d-255a-d25e-451222fc9bb9@redhat.com>
In-Reply-To: <b3aec4d4-737d-255a-d25e-451222fc9bb9@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 4 Jan 2023 10:24:03 -0800
Message-ID: <CAJuCfpGBrAjjX9Otyn1vRKSVGL5uh=VOsEtM7-B6V4oT4ufSxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 1:04 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 03.01.23 20:53, Suren Baghdasaryan wrote:
> > On Mon, Jan 2, 2023 at 4:00 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 28.12.22 20:42, Suren Baghdasaryan wrote:
> >>> free_anon_vma_name() is missing a check for anonymous shmem VMA which
> >>> leads to a memory leak due to refcount not being dropped. Fix this by
> >>> adding the missing check.
> >>>
> >>> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
> >>> Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>>    include/linux/mm_inline.h | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> >>> index e8ed225d8f7c..d650ca2c5d29 100644
> >>> --- a/include/linux/mm_inline.h
> >>> +++ b/include/linux/mm_inline.h
> >>> @@ -413,7 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
> >>>         * Not using anon_vma_name because it generates a warning if mmap_lock
> >>>         * is not held, which might be the case here.
> >>>         */
> >>> -     if (!vma->vm_file)
> >>> +     if (!vma->vm_file || vma_is_anon_shmem(vma))
> >>>                anon_vma_name_put(vma->anon_name);
> >>
> >> Wouldn't it be me more consistent to check for "vma->anon_name"?
> >>
> >> That's what dup_anon_vma_name() checks. And it's safe now because
> >> anon_name is no longer overloaded in vm_area_struct.
> >
> > Thanks for the suggestion, David. Yes, with the recent change that
> > does not overload anon_name, checking for "vma->anon_name" would be
> > simpler. I think we can also drop anon_vma_name() function now
> > (https://elixir.bootlin.com/linux/v6.2-rc2/source/mm/madvise.c#L94)
> > since vma->anon_name does not depend on vma->vm_file anymore, remove
> > the last part of this comment:
> > https://elixir.bootlin.com/linux/v6.2-rc2/source/include/linux/mm_types.h#L584
> > and use vma->anon_name directly going forward. If all that sounds
> > good, I'll post a separate patch implementing all these changes.
> > So, for this patch I would suggest keeping it as is because
> > functionally it is correct and will change this check along with other
> > corrections I mentioned above in a separate patch. Does that sound
> > good?
>
> Works for me.
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thank you! Will post the followup cleanup patch shorly.

>
> for this one, as it fixes the issue.
>
> --
> Thanks,
>
> David / dhildenb
>
