Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27B570EB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbjEXCWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEXCWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:22:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C74CD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:22:32 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56190515833so9635067b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684894952; x=1687486952;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNoZFE15KVCGaDsKWYPa3AXU3xXgJ31/Z6hKlwSh2kQ=;
        b=CYHuBQt4sNY1VOu7Oe2TF9KvZ6A5MpM3eHBJ3Hfajar8vhIXv3EieQ7KdHlCEj4hBN
         xRxLPqXXyAVpvGoVZxqv9xRQBK07xF7CxPJnjWwZ1P9UU1jnUYnZl/H+yd4O+yWjScr+
         6f8lLLMPEGj7tc+dNVo35Pgu1j9pjhH1eB2mjv0A2KNN5OosxpXlvr1W8iy5i6riCr1s
         uZDAZz29t0+rDczY3vYUYMp17f9D0nCVLUQl7f/+4Xq0bJGKkpLfU1xgGu21qcak1VEq
         X8U2GUv2hE+I0vwadhlJKWzJoI/QEtZ7MyP56j1xnS1Jpxnw4CsYGfk84Q8jhOJjNKpw
         0YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684894952; x=1687486952;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNoZFE15KVCGaDsKWYPa3AXU3xXgJ31/Z6hKlwSh2kQ=;
        b=W4XyQ9VCm8Nkk0dW7MncSkGkYuOz0WH/GHSUPKrvXm6yIdCdfTGwd5baUE6DtwXGxY
         PgzEH1eQ//0LEYz6ox2HiBAj/QrzDLl+tbRxVvXac7DR2s8B2RZUiJelnF62dyTukKTd
         PTM6kt4zj3o1A/Gnu5cFgTMZVqFPQGCkZTdHzDc7b1V3yA132xCV5IUJvPADILxbqh7X
         2bsPQc6u5gQOiLKyqYzjHa7kQrJiWrVntBhF9YwnGbSuchlV1juNqvNDWTIlXl8FsSXZ
         avuNah5W1HEApkNJmgSCp5ZQLyatyCO+5JqFZGUmzdqdERwB8xJ4uGwXrSngMAa4OVRm
         k8JQ==
X-Gm-Message-State: AC+VfDySSRBQTCwNvsHYDS77Wof23Duosf8Dggr+MniQlge0dPsDhTpc
        9UsmguKoM5cWEvkirxJw0sPGRA==
X-Google-Smtp-Source: ACHHUZ5CYV+kqZ1ERIdLFZg8vNO+dYiJO6JxvUqRllYKXRSR+T73Ju+E0jdwMxZkpwTw380HTv4cCg==
X-Received: by 2002:a81:981:0:b0:561:b53d:d1f1 with SMTP id 123-20020a810981000000b00561b53dd1f1mr16007563ywj.19.1684894951822;
        Tue, 23 May 2023 19:22:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d188-20020a0df4c5000000b0054601ee157fsm3342840ywf.114.2023.05.23.19.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 19:22:31 -0700 (PDT)
Date:   Tue, 23 May 2023 19:22:28 -0700 (PDT)
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
Subject: Re: [PATCH 04/31] mm/pgtable: allow pte_offset_map[_lock]() to
 fail
In-Reply-To: <9dc72654-79db-e988-54a8-488550d235ac@linux.dev>
Message-ID: <1efc993b-5b41-4895-a4d-20d38eb95de5@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <8218ffdc-8be-54e5-0a8-83f5542af283@google.com> <9dc72654-79db-e988-54a8-488550d235ac@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 22 May 2023, Qi Zheng wrote:
> On 2023/5/22 12:53, Hugh Dickins wrote:
> 
> [...]
> 
> >   @@ -229,3 +231,57 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> > unsigned long address,
> >   }
> >   #endif
> >   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > +
> > +pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
> > +{
> > +	pmd_t pmdval;
> > +
> > +	/* rcu_read_lock() to be added later */
> > +	pmdval = pmdp_get_lockless(pmd);
> > +	if (pmdvalp)
> > +		*pmdvalp = pmdval;
> > +	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
> > +		goto nomap;
> > +	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
> > +		goto nomap;
> 
> Will the follow-up patch deal with the above situation specially?

No, the follow-up patch will only insert the rcu_read_lock() and unlock();
and do something (something!) about the PAE mismatched halves case.

> Otherwise, maybe it can be changed to the following check method?
> 
> 	if (unlikely(pmd_none(pmdval) || pmd_leaf(pmdval)))
> 		goto nomap;

Maybe, but I'm not keen.  Partly just because pmd_leaf() is quite a
(good) new invention (I came across a few instances in updating to
the current tree), whereas here I'm just following the old examples,
from zap_pmd_range() etc.  I'd have to spend a while getting to know
pmd_leaf(), and its interaction with strange gotchas like pmd_present().

And partly because I do want as many corrupt cases as possible to
reach the pmd_bad() check below, so generating a warning (and clear).
I might be wrong, I haven't checked through the architectures and how
pmd_leaf() is implemented in each, but my guess is that pmd_leaf()
will tend to miss the pmd_bad() check.

But if you can demonstrate a performance improvement from using
pmd_leaf() there, I expect many people would prefer that improvement
to badness catching: send a patch later to make that change if it's
justified.

Thanks a lot for all your attention to these.

Hugh

> 
> > +	if (unlikely(pmd_bad(pmdval))) {
> > +		pmd_clear_bad(pmd);
> > +		goto nomap;
> > +	}
> > +	return __pte_map(&pmdval, addr);
> > +nomap:
> > +	/* rcu_read_unlock() to be added later */
> > +	return NULL;
> > +}
