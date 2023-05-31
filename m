Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BBC7188F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjEaSAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjEaR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:59:59 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F696126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:59:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33baee0235cso12995ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685555997; x=1688147997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB39BX9t2bk69eR34cuPtTrtH3iMrtwgLqGN0anXQzs=;
        b=sNHcscEzF5oIXlbzrKvF04KLUYw1WT7sMRVqG8QGy8XIgG11atPlAKnpx5jKGtpy6a
         a+jCVG2eG9BX6mHRsSpbaugSwkATgdYQoWfvZd+ALZ/Jy6Mauf49PzdPffe5WmNZPR4Z
         WAFrsIXSEXKtDxjryc6yB0Z+hcuRTBy1nOpSqzMGFFGOJoYlv2FFuEbQe/FRb7W1B+KV
         0tTSBe6RpqLXei52V6g9ZxrdXeXwUXD4CalXMcTtAUE4wynrS414dVRH12lnDs0RZxQf
         mSOnJt6GA5r/CNqCC7dCE5XlEFmkMml+h5K7Z1ZJnauFHk0x4Zj6P4zxqfq+t5LPRE9b
         dxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685555997; x=1688147997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB39BX9t2bk69eR34cuPtTrtH3iMrtwgLqGN0anXQzs=;
        b=RtqFK+7f5W75AWsTHtEl2/bsbMneZqATmkfeLvjhjSIh8mmSL/b4ExEHqsTuiQoHNL
         3PPptbzFqraIHmcwviZ3YWnllC2sZzpM598xvDONpXx0Ae5zdQZZvc49tXCSWgRKkofD
         SNilW8Lr/U5YRs4amtvxRRV/7vZRp2tQvDMiKBpj/r5zqfAUK/RTT4362aIGTZ/SAfAw
         oa4IZHgO4zuK8jqn10pfyYzJ+e5fqK9TDGs0COc/b4HMaG8mi7hYVdJ0jhPxi/qLEZQe
         cjwt1xw3rr8bPLpP4FM6ixe3Z9kbXfP03HMoTdnHXVVA1ImQxUeN2V3PcSoRSm2XXzPL
         Q4ew==
X-Gm-Message-State: AC+VfDwZjho0C6tJcqUmBKzsf4vgUVY19Ezdvd4ENPLu4Jg2sanq0ofS
        fiojcDVjZWHQClCcJ6E/r7n20VGmTrs4fJsL5a2Ipw==
X-Google-Smtp-Source: ACHHUZ4G84rWJ4iQu8mReQkW8t0DG4yhWskE8/AflvFlAC8RqDIUu08YD8bIx3gECDchUWXdvk6aMUCK5QJkPh4jMtw=
X-Received: by 2002:a05:6e02:b2e:b0:33b:5343:c1be with SMTP id
 e14-20020a056e020b2e00b0033b5343c1bemr174970ilu.29.1685555996652; Wed, 31 May
 2023 10:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 31 May 2023 19:59:20 +0200
Message-ID: <CAG48ez0pCqfRdVSnJz7EKtNvMR65=zJgVB-72nTdrNuhtJNX2Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] mm: free retracted page table by RCU
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 29, 2023 at 8:11=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> Here is the third series of patches to mm (and a few architectures), base=
d
> on v6.4-rc3 with the preceding two series applied: in which khugepaged
> takes advantage of pte_offset_map[_lock]() allowing for pmd transitions.

To clarify: Part of the design here is that when you look up a user
page table with pte_offset_map_nolock() or pte_offset_map() without
holding mmap_lock in write mode, and you later lock the page table
yourself, you don't know whether you actually have the real page table
or a detached table that is currently in its RCU grace period, right?
And detached tables are supposed to consist of only zeroed entries,
and we assume that no relevant codepath will do anything bad if one of
these functions spuriously returns a pointer to a page table full of
zeroed entries?

So in particular, in handle_pte_fault() we can reach the "if
(unlikely(!pte_same(*vmf->pte, entry)))" with vmf->pte pointing to a
detached zeroed page table, but we're okay with that because in that
case we know that !pte_none(vmf->orig_pte)&&pte_none(*vmf->pte) ,
which implies !pte_same(*vmf->pte, entry) , which means we'll bail
out?

If that's the intent, it might be good to add some comments, because
at least to me that's not very obvious.
