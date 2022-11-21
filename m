Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CE1632AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKURYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKURXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:23:49 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0195BB6E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:23:49 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h7so7841840qvs.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i/VbYzsnoDE2k0Jj4uL/vSZLNIjl3EQx0mm05ELH+/A=;
        b=SvPg1Ztvqfsah6gG0PV9vXMlY7b7QctK404v8Y3iQFhXamQOz8sDneWIPMDDajhp1i
         G9aPIymQ8yfBh+kzb/C8LfxfF5LgGKVHzuHFr6c96/J/nLydPegcrikWa8Sl9y/aXbPO
         YYxBcHwur972W656iStWTcS4nNFTfczO0mRjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/VbYzsnoDE2k0Jj4uL/vSZLNIjl3EQx0mm05ELH+/A=;
        b=absO4sPh1TXtUzhDaCFDChlaFdK0CeivJj5pTxhDS0B8O2Vp0DbFd9X5lU8qpIoSb9
         rzT5vdaI0rvttieFGOpKHIpJyHUnR/rbODSWrp/wD1WLN3eIHK+ce0oG6Pa5Doh8FjFK
         YzYbzMSSIl4BncT3WyALxNlaCglpQSCN9iOxBGhN3DLa0QBZnCrON5E3Up+Sg2rMzGD4
         lVKbKse6x0lr1odg7A4Q7L8+DFoVUfsXBQVRNK15OEb6GaH7I8ZNhE12Fk/y5879RH8E
         Urwfh03xMYPMld7iH2DerwrcLTm4UMP6Y0dWCsYRb1c44pRX4/NwW1GOaLm8tbZ+hv9T
         VHYw==
X-Gm-Message-State: ANoB5pn/pFBvMiT+wMfCYcuh0NmprIp7jJHtu6yARL7NXOz6YKy335C3
        feBLKj32zBBNpQnmBT+iAcWuTyLAUIviXg==
X-Google-Smtp-Source: AA0mqf4W4/9f86q70cXHdM1sngfoef9jCkbqBmhiakXK9JZEp92Zhg/zrwGCp2nZdOS/NHPZOHiPCQ==
X-Received: by 2002:a05:6214:3d8a:b0:4b1:c5bb:25f2 with SMTP id om10-20020a0562143d8a00b004b1c5bb25f2mr3108084qvb.101.1669051427777;
        Mon, 21 Nov 2022 09:23:47 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b929a56a2bsm8560346qkb.3.2022.11.21.09.23.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:23:47 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id x18so8485296qki.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:23:47 -0800 (PST)
X-Received: by 2002:ac8:41cd:0:b0:3a5:1ba7:717d with SMTP id
 o13-20020ac841cd000000b003a51ba7717dmr18464445qtm.678.1669051034241; Mon, 21
 Nov 2022 09:17:14 -0800 (PST)
MIME-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <20221121165938.oid3pemsfkaeq3ws@google.com>
In-Reply-To: <20221121165938.oid3pemsfkaeq3ws@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Nov 2022 09:16:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgR=vJnkkUS=x26=meF=i0x_9q9ytSd+DZGaFP8uoGJsg@mail.gmail.com>
Message-ID: <CAHk-=wgR=vJnkkUS=x26=meF=i0x_9q9ytSd+DZGaFP8uoGJsg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Mon, Nov 21, 2022 at 8:59 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Is there a plan to remove lock_page_memcg() altogether which I missed? I
> am planning to make lock_page_memcg() a nop for cgroup-v2 (as it shows
> up in the perf profile on exit path)

Yay. It seems I'm not the only one hating it.

> but if we are removing it then I should just wait.

Well, I think Johannes was saying that at least the case I disliked
(the rmap removal from the page table tear-down - I strongly suspect
it's the one you're seeing on your perf profile too) can be removed
entirely as long as it's done under the page table lock (which my
final version of the rmap delaying still was).

See

    https://lore.kernel.org/all/Y2llcRiDLHc2kg%2FN@cmpxchg.org/

for his preliminary patch.

That said, if you have some patch to make it a no-op for _other_
reasons, and could be done away with _entirely_ (not just for rmap),
then that would be even better. I am  not a fan of that lock in
general, but in the teardown rmap path it's actively horrifying
because it is taken one page at a time. So it's taken a *lot*
(although you might not see it if all you run is long-running
benchmarks - it's mainly the "run lots of small scripts that really
hits it).

The reason it seems to be so horrifyingly noticeable on the exit path
is that the fork() side already does the rmap stuff (mainly
__page_dup_rmap()) _without_ having to do the lock_page_memcg() dance.

So I really hate that lock. It's completely inconsistent, and it all
feels very wrong. It seemed entirely pointless when I was looking at
the rmap removal path for a single page. The fact that both you and
Johannes seem to be more than ready to just remove it makes me much
happier, because I've never actually known the memcg code enough to do
anything about my simmering hatred.

              Linus
