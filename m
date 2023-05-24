Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222C770EBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbjEXDVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbjEXDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:20:51 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B381A2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:20:46 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba71cd7ce7fso753155276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684898445; x=1687490445;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1Ic9lmajt1bc7YqAp1ZDUsVACgZvUXdJaCPzytnSgQ=;
        b=OydEIfSzuBg9A30R/d+SaZ/46FzOSp7LL0tywF5phYVeld9ovniXgucSvpmx9qp6kv
         fzEb5o+qX222y7d40RT69HOOmTqtE/mxh+dGZutzpRnxC1ohXmoOHRNT3LwrIrQLXLDd
         Cl+78DjSEKOQBNYxPXfM3tYeP5xrhc8C5uVkJYKYfF3nnLxd2sIHzA7toqq5yz5HQSF1
         qZshTFG6b0qR+n/iCO+lOHGEAZmQirGfiA7P7fpVHdYW/k2/6SHC1RT8qguWp/8hd4Ng
         Qelg8Olb9YUqP2TgKiPWMZdpBBtb7f/YltwBC83heuZghuFH3pWH8qOaitV46WFgAbZm
         vcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684898445; x=1687490445;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1Ic9lmajt1bc7YqAp1ZDUsVACgZvUXdJaCPzytnSgQ=;
        b=SeBUgFiKisD0Ctx1fJWlXudy1ywFtqC3Ggox6cQ7LfFwpksmy67cpRpzv3xuoHzVtu
         5+WNjSFSUHo//4R39a9It6Tft274eir4DboMckt5B7Y9O3BzVFgBJMTe6kVvhNvLp5eJ
         iw2BPf4+qzpFwOJ59KMearW3h6OuWQJ/uc1WIglwqfgFjivjqKQrLoTGLoNR3eDuTiZ5
         n85JU/NvmwYnUk1rza2YuhwnSRau2hbraJJzpjVAHiBkhSdf0nwyJFFMt6Irck09mvpe
         ydHAdDHYIxN7wCCtDCfpmQrCYSa9UlY7QZCQuNOqpsmJd3mNNleTxuScLCawwlFxhy6K
         v38g==
X-Gm-Message-State: AC+VfDw1bHKTsfYVf1BsQujv1vKA0dBhlEGEQJemFJhRljtm7zzUTpoi
        J/tlW9Yh43Yfb1/APUs4ouE+0A==
X-Google-Smtp-Source: ACHHUZ4jp475x6K67Bd7uNS4vA7Hth7pnLr9V4HuAUB51TqTKZ6Hb4uHD1d9YbQMgTAOfsJ3QTeg7g==
X-Received: by 2002:a81:6ac1:0:b0:556:9f48:cbe7 with SMTP id f184-20020a816ac1000000b005569f48cbe7mr18184556ywc.3.1684898445186;
        Tue, 23 May 2023 20:20:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e129-20020a0dc287000000b00545a08184f8sm3386553ywd.136.2023.05.23.20.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 20:20:44 -0700 (PDT)
Date:   Tue, 23 May 2023 20:20:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Qi Zheng <qi.zheng@linux.dev>
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
        Alistair Popple <apopple@nvidia.com>,
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
Subject: Re: [PATCH 17/31] mm/various: give up if pte_offset_map[_lock]()
 fails
In-Reply-To: <07317766-c901-34a9-360a-e916db4b9045@linux.dev>
Message-ID: <4df7a2a5-e2b9-6c9e-9bbf-27e1dbdace8@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <c299eba-4e17-c645-1115-ccd1fd9956bd@google.com> <f8468e50-9f54-f22d-59a7-3a48369d2f05@linux.dev> <07317766-c901-34a9-360a-e916db4b9045@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1197784731-1684898444=:7491"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1197784731-1684898444=:7491
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 22 May 2023, Qi Zheng wrote:
> On 2023/5/22 20:24, Qi Zheng wrote:
> > On 2023/5/22 13:10, Hugh Dickins wrote:
> >> Following the examples of nearby code, various functions can just give
> >> up if pte_offset_map() or pte_offset_map_lock() fails.=C2=A0 And there=
's no
> >> need for a preliminary pmd_trans_unstable() or other such check, since
> >> such cases are now safely handled inside.
> >>
> >> Signed-off-by: Hugh Dickins <hughd@google.com>
> >> ---
> >> =C2=A0 mm/gup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 9 ++++++---
> >> =C2=A0 mm/ksm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 7 ++++---
> >> =C2=A0 mm/memcontrol.c=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
> >> =C2=A0 mm/memory-failure.c | 8 +++++---
> >> =C2=A0 mm/migrate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> >> =C2=A0 mm/swap_state.c=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> >> =C2=A0 6 files changed, 25 insertions(+), 13 deletions(-)
> >>
> >=20
> > [...]
> >=20
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 3ecb7a40075f..308a56f0b156 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -305,6 +305,9 @@ void migration_entry_wait(struct mm_struct *mm, pm=
d_t
> >> *pmd,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_entry_t entry;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptep =3D pte_offset_map_lock(mm, pmd, a=
ddress, &ptl);
> >> +=C2=A0=C2=A0=C2=A0 if (!ptep)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > Maybe we should return false and let the caller handle the failure.

We have not needed to do that before, it's normal for migration_entry_wait(=
)
not to wait sometimes: it just goes back out to userspace to try again (by
which time the situation is usually resolved).  I don't think we want to
trouble the callers with a new case to handle in some other way.

> >=20
> >> +
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte =3D *ptep;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_unmap(ptep);
> >> diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> index b76a65ac28b3..db2ec85ef332 100644
> >> --- a/mm/swap_state.c
> >> +++ b/mm/swap_state.c
> >> @@ -734,6 +734,9 @@ static void swap_ra_info(struct vm_fault *vmf,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Copy the PTEs because the page table=
 may be unmapped */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 orig_pte =3D pte =3D pte_offset_map(vmf=
->pmd, faddr);
> >> +=C2=A0=C2=A0=C2=A0 if (!pte)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > Ditto?
>=20
> Oh, I see that you handle it in the PATCH[22/31].

I don't think 22/31 (about swapoff "unuse") relates to this one.
Here swap_vma_readahead() is doing an interesting calculation for
how big the readaround window should be, and my thinking was, who cares?
just read 1, in the rare case that the page table vanishes underneath us.

But thank you for making me look again: it looks like I was not careful
enough before, ra_info->win is definitely *not* 1 on this line, and I
wonder if something bad might result from not following through on the
ensuing calculations - see how !CONFIG_64BIT is copying ptes (and that
implies CONFIG_64BIT is accessing the page table after pte_unmap()).

This swap_ra_info() code looks like it will need a patch all it own:
I must come back to it.

Thanks!
Hugh
---1463760895-1197784731-1684898444=:7491--
