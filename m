Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16964211D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiLEBix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiLEBiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:38:52 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FFD101EE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 17:38:50 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id r19so10509786qtx.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 17:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXxcMzUFM9e1S5I3wG5dQ8xpfGdRGLVQZ2ZblyAR08k=;
        b=Ho3FcbvIgRC/Ln9u3Gal/122V7y3okAGFtaeZaJ4W/4D4sphNZo9MFGG+xxWUR6Y8D
         /bbgn6cmLx+R1DCEpD5687i7Vno6npA+c2rqBZfuvtZ58rscaQysFg8bQX8e6LlHcpyZ
         1TE4Uo4uTNl2CaKioXBbW6IFB7DrzxgGd6nrqJK7Lmc6bwqbH75KqwZudP3W2CuC/flv
         zuMiSJDaYnqvBFIyvkJapl9lUf4XilxQVro1CCs8AVODEtzjgGyPiGJuhXjJVwdLyx11
         Nm0sXsMtRHK/RL5ZNq9zTrx357yyXyuqU8lbOWML0Krwgx9gUg2O0urR99FPMtexMbHY
         lMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXxcMzUFM9e1S5I3wG5dQ8xpfGdRGLVQZ2ZblyAR08k=;
        b=RzN6JoO8zONdp+bR2oYfbf3E5GJuhVcnx5HNSZps2KDIL5vyiTCXVMNyMWhzfeUxs7
         71hjhjThWXior2awSXgWY1K8EjsPF3Wdf2WRhnZ9l77ptrimpRshpd/5miHedUsmJsoX
         Tl1glvb71RhUZ5HkPt6oCmc6PItOFUN2qc9ZT+5t5uh+DIyMiXhoq/lFrfKc6pylBrL8
         uKbKXMRh4Jhvb+1fpEfwwvlPzAQCHBEQOXO8SOHCa9aaKOh1+cs0SPb9VcjKyRa5LZBv
         AlhuF4ah8ZO5jqjJQBO8+vHo5dwfscoHQlAeX8vmRXKiyyiMvXoFD+GEQxyNeF72b6/J
         H2HQ==
X-Gm-Message-State: ANoB5pnnCEUCtuyzIkaSUNlxiyG25tih11oOa+99PWLER6AmDWip6+Z4
        Hxmej/BDSlpbQdQJtBrxbnWGew==
X-Google-Smtp-Source: AA0mqf4Nqj9lnTkSOc1yx5kPVPyVAyOJCmDcDvRKi4mjaNFiZnwxhw7VrWIA4N+cNinpFSzgTelAzQ==
X-Received: by 2002:a05:622a:909:b0:3a5:7aaa:cfac with SMTP id bx9-20020a05622a090900b003a57aaacfacmr75038938qtb.278.1670204329819;
        Sun, 04 Dec 2022 17:38:49 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a6ebde4799sm10993796qkp.90.2022.12.04.17.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:38:49 -0800 (PST)
Date:   Sun, 4 Dec 2022 17:38:46 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        Zach O'Keefe <zokeefe@google.com>, Yu Zhao <yuzhao@google.com>,
        Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm,thp,rmap: clean up the end of
 __split_huge_pmd_locked()
In-Reply-To: <d43748aa-fece-e0b9-c4ab-f23c9ebc9011@google.com>
Message-ID: <306c84f5-f383-a95c-489f-151ef5202c@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <a5849eca-22f1-3517-bf29-95d982242742@google.com> <d43748aa-fece-e0b9-c4ab-f23c9ebc9011@google.com>
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

On Tue, 22 Nov 2022, Hugh Dickins wrote:

> It's hard to add a page_add_anon_rmap() into __split_huge_pmd_locked()'s
> HPAGE_PMD_NR set_pte_at() loop, without wincing at the "freeze" case's
> HPAGE_PMD_NR page_remove_rmap() loop below it.

No problem here, but I did later learn something worth sharing.

Comparing before and after vmstats for the series, I was worried to find
the thp_deferred_split_page count consistently much lower afterwards
(10%? 1%?), and thought maybe the COMPOUND_MAPPED patch had messed up
the accounting for when to call deferred_split_huge_page().

But no: that's as before.  We can debate sometime whether it could do a
better job - the vast majority of calls to deferred_split_huge_page() are
just repeats - but that's a different story, one I'm not keen to get into
at the moment.

> -	if (freeze) {
> -		for (i = 0; i < HPAGE_PMD_NR; i++) {
> -			page_remove_rmap(page + i, vma, false);
> -			put_page(page + i);
> -		}
> -	}

The reason for the lower thp_deferred_split_page (at least in the kind
of testing I was doing) was a very good thing: those page_remove_rmap()
calls from __split_huge_pmd_locked() had very often been adding the page
to the deferred split queue, precisely while it was already being split.

The list management is such that there was no corruption, and splitting
calls from the split queue itself did not reach the point of bumping up
the thp_deferred_split_page count; but off-queue splits would add the
page before deleting it again, adding lots of noise to the count, and
unnecessary contention on the queue lock I presume.

Hugh
