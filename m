Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6570EC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbjEXDqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbjEXDqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:46:07 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E58E48
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:45:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-561a7d96f67so6569247b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684899949; x=1687491949;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lVbnEYsazKzX4enQtO4af5XFObezJstzH38Mnuyqik=;
        b=QeqsWRUTIaM7z8ObBASO6rMxhUwHOaMOJQuaiTpKL4dhLcrusvv81VoDTUHxu0zaPc
         l2n68Z6HCYi0FK4CW7Xxh4nLcs7I6SuH4H+KIz63Dxsbq/W7e5ockvMqvIJT4A8rVFEw
         r2HfYjvpXIdGadh+M/JHV94OiHEJS2Y1qXcnjJBi44vAWTeSfWv4kQmauXwlPd+D2jKk
         JQKv9zBR2MqNQi/DVKTe1dXOuqbJliDsxOzg+5MAguYnOYSfs091WlrNIJNRMs47CrZd
         jPERmDuwKyAsBb944CNDy1jjmz6iypYAK7Gy1wvcADAX0RL813ghMliaaD152dgoa9X4
         YVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684899949; x=1687491949;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lVbnEYsazKzX4enQtO4af5XFObezJstzH38Mnuyqik=;
        b=WDxTtGLOTNk3H1whjR20IJ7t8sPdnGHAUUYKRpbpCQkodUFOp0XhhLa99VNDWPSnnp
         YXPnnXHhK89jBrtEcT1tbHDjQDP24MxeLdbMbjA+w/Qeu95Ljt5JfdAIznkepjmZGRs0
         495yhrev5zHU0MEMSe56/8WkQomZ5zWq+WQd1S6UlXzv+pPp0dx0xPrlmmpFnxi44iiB
         IqVovQPn9kpinDdJVs2WLOEAm13tmwDkdTyZ7STyebHnLC2lkZUTKFJyfRby5UOXpAoS
         4B7P1X9b/WSZ+epJA60NrnclxcOZnacfPXxT94OBFVBmtAUs1LOn7+t+WqvWEOBHeNFw
         1rKQ==
X-Gm-Message-State: AC+VfDxUNRieQ+OwPa9sjeitaKysFJwRyJvaY2S1HRrLyHr+JDNSTNM+
        2OWl33dSj1ezY8f0S9e1NvyFyA==
X-Google-Smtp-Source: ACHHUZ70sisZwDeFJo5/b2Pf7ePEqVJmgh0OAHByoVNyolGXBU8aPumI2PHrZqUwzWqCYUICcJtddQ==
X-Received: by 2002:a0d:ff44:0:b0:55d:7d07:7fbb with SMTP id p65-20020a0dff44000000b0055d7d077fbbmr20216649ywf.27.1684899949486;
        Tue, 23 May 2023 20:45:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f205-20020a816ad6000000b00561949f713fsm3417913ywc.39.2023.05.23.20.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 20:45:49 -0700 (PDT)
Date:   Tue, 23 May 2023 20:45:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alistair Popple <apopple@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 24/31] mm/migrate_device: allow pte_offset_map_lock() to
 fail
In-Reply-To: <877csz943s.fsf@nvidia.com>
Message-ID: <838a5172-f7f2-43db-e990-d38b36b544a2@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <ea51bb69-189c-229b-fc0-9d3e7be5d6b@google.com> <877csz943s.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, Alistair Popple wrote:
> Hugh Dickins <hughd@google.com> writes:
> 
> > migrate_vma_collect_pmd(): remove the pmd_trans_unstable() handling after
> > splitting huge zero pmd, and the pmd_none() handling after successfully
> > splitting huge page: those are now managed inside pte_offset_map_lock(),
> > and by "goto again" when it fails.
> >
> > But the skip after unsuccessful split_huge_page() must stay: it avoids an
> > endless loop.  The skip when pmd_bad()?  Remove that: it will be treated
> > as a hole rather than a skip once cleared by pte_offset_map_lock(), but
> > with different timing that would be so anyway; and it's arguably best to
> > leave the pmd_bad() handling centralized there.
> 
> So for a pmd_bad() the sequence would be:
> 
> 1. pte_offset_map_lock() would return NULL and clear the PMD.
> 2. goto again marks the page as a migrating hole,
> 3. In migrate_vma_insert_page() a new PMD is created by pmd_alloc().
> 4. This leads to a new zero page getting mapped for the previously
>    pmd_bad() mapping.

Agreed.

> 
> I'm not entirely sure what the pmd_bad() case is used for but is that
> ok? I understand that previously it was all a matter of timing, but I
> wouldn't rely on the previous code being correct in this regard either.

The pmd_bad() case is for when the pmd table got corrupted (overwritten,
cosmic rays, whatever), and that pmd entry is easily recognized as
nonsense: we try not to crash on it, but user data may have got lost.

My "timing" remark may not be accurate: I seem to be living in the past,
when we had a lot more "pmd_none_or_clear_bad()"s around than today - I
was thinking that any one of them could be racily changing the bad to none.
Though I suppose I am now making my timing remark accurate, by changing
the bad to none more often again.

Since data is liable to be lost anyway (unless the corrupted entry was
actually none before it got corrupted), it doesn't matter greatly what
we do with it (some would definitely prefer a crash, but traditionally
we don't): issue a "pmd bad" message and not get stuck in a loop is
the main thing.

> 
> > migrate_vma_insert_page(): remove comment on the old pte_offset_map()
> > and old locking limitations; remove the pmd_trans_unstable() check and
> > just proceed to pte_offset_map_lock(), aborting when it fails (page has
> > now been charged to memcg, but that's so in other cases, and presumably
> > uncharged later).
> 
> Correct, the non-migrating page will be freed later via put_page() which
> will uncharge the page.

Thanks for confirming, yes, it was more difficult once upon a time,
but nowadays just a matter of reaching the final put_page()

Hugh
