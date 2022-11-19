Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1C630876
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKSBcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKSBcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:32:20 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F3116592
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:37:23 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id k2so3283100qvo.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyEPY+SojRhqXF/AvB0DrGy+gEBy7oa95tVCQD643p0=;
        b=no0Tfx19bBOZUAeRN3mzYn4qcd7kLI8jUwU9vN5lbhqXXNIoo1QCS2A9e6LG4U0Or7
         QY2bB2l5Z3pUGj2gA9Aw/njcKYwjrfj/oKHgw2oEwiMqbIA8R9sEtQ8zlmC3WWdzdmNd
         G4sNIs8QA/OoRGYnozf7yuka7VeDzAz+HGgy8wS6MENGIVT/XVNPQS96wwktYfdNVP7u
         K85AkTOjPQO/E7XCXBLuON5090rAPuzDsAEF8Gk6j8SKh0VQfJigAOHRFV/IeZ0Rkm/b
         FHPSt5HAkVZa+wj/or5IYfzxpf0C44y8QoXeTYMHrgvDBRp2t1fj4bLYw2HK9ShEsuBM
         GpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyEPY+SojRhqXF/AvB0DrGy+gEBy7oa95tVCQD643p0=;
        b=vsStgd5qN3eWHPyKpdiTEKYVqJJ5bButWi4aJDxhsnH8n8D/1EBZcMgIf2EVmj1v3i
         4IZDtGM7bMzKwk0GoENylhWrAWjwBjy4AnxSrFp0/TXzwDEyy4VEWenR6h0Nk1HlmTI5
         AN/CJfJn3yvAVOyvY20MhBVigTRE0XtP3/PZM/U5NYZbvIFJc/HGPTubY5G68AM3yOOu
         kGY334HJqUkxHScn9oyg8wS3w8HFCAPNaI9+WZlVu/6b3yQzAwpv5Vv3KEfOD7LdoBeD
         e3excixqSaFOXGxhiGhGr4kadaNrI98hgjc7pzXuqKS/dAXukHITKCKp2dQiT/vr076V
         bgiw==
X-Gm-Message-State: ANoB5pkRVWgoZM1kvcRk+quMkbUyo/IweZGlGF9y2z8TdHVjVRA2hRp4
        dZqjMblAqlK0M4/1L8bmY3b1Aw==
X-Google-Smtp-Source: AA0mqf6fsjaaxYUp3xx21CcJ8zpCHmptZyty/Ag71ufur/HJeNekLLxWkxwOOWjGfITrpe30FuE7mA==
X-Received: by 2002:a0c:9c43:0:b0:4c6:62af:5e17 with SMTP id w3-20020a0c9c43000000b004c662af5e17mr8967454qve.95.1668818242976;
        Fri, 18 Nov 2022 16:37:22 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05620a179400b006faa88ba2b5sm3461329qkb.7.2022.11.18.16.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:37:21 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:37:12 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yu Zhao <yuzhao@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm,thp,rmap: subpages_mapcount of PTE-mapped
 subpages
In-Reply-To: <CAOUHufYf9Ns6vPpDeSOnUBaQm3Th+N6WbLiT7F=191LNpsatNQ@mail.gmail.com>
Message-ID: <759077a6-a08-5bb0-a0b6-53be2fe8b56a@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <78fa518-85b5-32c0-ee92-537fa46131f6@google.com> <CAOUHufYf9Ns6vPpDeSOnUBaQm3Th+N6WbLiT7F=191LNpsatNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 18 Nov 2022, Yu Zhao wrote:
> On Fri, Nov 18, 2022 at 2:12 AM Hugh Dickins <hughd@google.com> wrote:
> 
> ...
> 
> > @@ -1308,31 +1285,29 @@ void page_add_anon_rmap(struct page *page,
...
> >
> >         VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
> 
> Hi Hugh, I got the following warning from the removed "else" branch.
> Is it legit? Thanks.
> 
> mm/rmap.c:1236:13: warning: variable 'first' is used uninitialized
> whenever 'if' condition is false [-Wsometimes-uninitialized]
>         } else if (PageTransHuge(page)) {
>                    ^~~~~~~~~~~~~~~~~~~
> mm/rmap.c:1248:18: note: uninitialized use occurs here
>         VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
>                         ^~~~~

Thanks a lot for that.  From the compiler's point of view, it is
certainly a legit warning.  From our point of view, it's unimportant,
because we know that page_add_anon_rmap() should only ever be called
with compound true when PageTransHuge(page) (and should never be
called with compound true when TRANSPARENT_HUGEPAGE is disabled):
so it's a "system error" if first is uninitialized there.

But none of us want a compiler warning: I'll follow up with a fix
patch, when I've decided whether it's better initialized to true
or to false in the impossible case...

Although the same pattern is used in other functions, this is the
only one of them which goes on to use "first" or "last" afterwards.

Hugh
