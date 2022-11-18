Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8916C62FEA4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKRUTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKRUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:19:02 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725041573F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:19:01 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id z17so4223715qki.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=debetX+RiAoZ60gEyg+EiA1gcFjja9cf9U11elr9U+o=;
        b=QuReE7pDtEDmXS8ooywCd1z/6wqgabIk9k1P/wOLRqgenWXns6rpp9eA5g1qg4hdCb
         UEMOkz/J79Sp7kIM60GSRBJPiZTGXtjRc/DxOoqy/ebinql3uKzAOJBZ7nEfYESvatJG
         HxrLAWgC9NTL7Gakym5+FKleG7YdojP43DXrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=debetX+RiAoZ60gEyg+EiA1gcFjja9cf9U11elr9U+o=;
        b=5YSaokWnCkKdzHnWhPiMYwY48cOLe4v0i6SWWrxzC5dKBCI0l2E5/XS1+SCi4C+sIq
         rf36WAx3N4jLw5vppE2wufqapF0Cx0lFqRcXyL/A6zmwr36lP5e0ETUv+fuTh+cpVtEr
         2hGJ83CDp9LLJRB3Rq+7LSe6pk47cO0ztNOwZQmnyW0hUg3NmM5ECb+IFZFX3rdf3V0M
         G8dIT8Ij/d/7CK8bQ+mqbGcDtnArzp4LmS7Qn5WU+UFWIeA+ZXuJfqNdcSZsQZ7Bnl3x
         1mphal8uA8cbVPUTJ6oFf736PNrwUM7ZWmm2pFAWkM9t90mUJM3O8eGjT4KoFbPyNX4C
         DzZg==
X-Gm-Message-State: ANoB5pkw8Wq+beJ7IdJa+FWsxYF+9eDW257reVF8/yC1AfJ+i1C6Uj05
        H673YMgfBKOwfLWMW2jbOFTZbdQBQUgNnQ==
X-Google-Smtp-Source: AA0mqf5AVWwKD8ryTBHJf57cNLr9eWHWUPTzLjLNut58HO/HTOr16DzmLw6xOwjVsFMJIsJPIAFTTw==
X-Received: by 2002:a37:dc82:0:b0:6ee:80b5:32d3 with SMTP id v124-20020a37dc82000000b006ee80b532d3mr7496432qki.237.1668802739967;
        Fri, 18 Nov 2022 12:18:59 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a410600b006fa2dde9db8sm3090980qko.95.2022.11.18.12.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 12:18:58 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id l15so3886393qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:18:58 -0800 (PST)
X-Received: by 2002:ac8:518b:0:b0:3a5:49fa:3983 with SMTP id
 c11-20020ac8518b000000b003a549fa3983mr8046289qtn.436.1668802737937; Fri, 18
 Nov 2022 12:18:57 -0800 (PST)
MIME-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
In-Reply-To: <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Nov 2022 12:18:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
Message-ID: <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Nov 18, 2022 at 1:08 AM Hugh Dickins <hughd@google.com> wrote:
>
> Linus was underwhelmed by the earlier compound mapcounts series:
> this series builds on top of it (as in next-20221117) to follow
> up on his suggestions - except rmap.c still using lock_page_memcg(),
> since I hesitate to steal the pleasure of deletion from Johannes.

This looks good to me. Particularly 2/3 made me go "Aww, yes" but the
overall line removal stats look good too.

That said, I only looked at the patches, and not the end result
itself. But not having the bit spin lock is, I think, a huge
improvement.

I do wonder if this should be now just merged with your previous
series - it looks a bit odd how your previous series adds that
bitlock, only for it to be immediately removed.

But if you think the logic ends up being easier to follow this way as
two separate patch series, I guess I don't care.

And the memcg locking is entirely a separate issue, and I hope
Johannes will deal with that.

Thanks,
              Linus
