Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561FA711A34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbjEYWfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjEYWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:35:28 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242BF95
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:35:25 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-56186035b61so3644297b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685054124; x=1687646124;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X1I0dDz7r+tt8jOu6t9oxl74u0KdPClVC8LiG257Y3o=;
        b=CKvE0O04BlYcOPgAIvegCAL27x1EQjo3Y0lqH/HneX+xDtSwRTt9wdWiMbBxHmmyjs
         7JXZFwr4+yHsMjg368dkp6y8AGV2Um5qt0xLnnEuezoVuiPE88WEvyP8thoEP+e72r7x
         3ZOz+EB704j+Zn51a+/q8S2b6v2Qffy4eddWD9xenXshmYaCJnqI19dbggFqPHNoJIQt
         7wxutVgKE8aVpOgXjxgedLMj9VN9sMr/7Xn/NoaVudCohKWFvEbeESsj++mBOk8QvtXU
         jFtaWcOVmEAWURq9xHWAJuKwANwgN2i5Fl8ZTtQ2Is8qhlB4hnlnQwuH6/e8IPDXsS/9
         JeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685054124; x=1687646124;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1I0dDz7r+tt8jOu6t9oxl74u0KdPClVC8LiG257Y3o=;
        b=EL/mi4209loULcyCqkog77cBoWutLL3R0kjYrm16DMIkKDQR8milCBcccKaboA2i35
         lsN3GOvFh6yVUsAJppSctg4oz+Z35cIJb1iLjAOSxrVCIdOpIJj/PKA5uWQmGgUcVPoX
         kUJ3wLvu47smCW9eUL5f9Y0+67uMPfl6ELJQSLO6FVybEQ0sd5qDHUbLKiItZr+/Lc1c
         aCDDnxgGFnKrAa7p0/uCWDcRcTgz+f6iPa179xxopcDWhs/gtcVffR7rRn10jUUGNlHf
         9mNCfX/RvGtp0SWm+PPQlHZ0sXDdXdyGHVppNj4QJK36ANsVobUAMUb7VL8LrUVwWuTG
         VApw==
X-Gm-Message-State: AC+VfDzVYRehSQQ+9QmVzEBT3wSlWEgVrJmkTaS09x//UIQZI2hhgWeG
        pb0OgdPEPIt+xua3NwMZBb8ASA==
X-Google-Smtp-Source: ACHHUZ58COqgHBl9so7Zp+r46G2D9ryKU3gAqr29xxGu/x3r6en9PCRXEPlb2IIF0M/UdojFyvCRYA==
X-Received: by 2002:a0d:f984:0:b0:561:8602:1a40 with SMTP id j126-20020a0df984000000b0056186021a40mr1108803ywf.46.1685054124263;
        Thu, 25 May 2023 15:35:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d13-20020a81ab4d000000b00545a08184cesm708388ywk.94.2023.05.25.15.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 15:35:23 -0700 (PDT)
Date:   Thu, 25 May 2023 15:35:01 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
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
Subject: Re: [PATCH 01/31] mm: use pmdp_get_lockless() without surplus
 barrier()
In-Reply-To: <ZG6PwAvIO4Z7lpkq@x1n>
Message-ID: <427ea01f-345a-6086-d145-fe573894dbe@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <34467cca-58b6-3e64-1ee7-e3dc43257a@google.com> <ZG6PwAvIO4Z7lpkq@x1n>
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

On Wed, 24 May 2023, Peter Xu wrote:
> On Sun, May 21, 2023 at 09:49:45PM -0700, Hugh Dickins wrote:
> > Use pmdp_get_lockless() in preference to READ_ONCE(*pmdp), to get a more
> > reliable result with PAE (or READ_ONCE as before without PAE); and remove
> > the unnecessary extra barrier()s which got left behind in its callers.
> 
> Pure question: does it mean that some of below path (missing barrier()
> ones) could have problem when CONFIG_PAE, hence this can be seen as a
> (potential) bug fix?

I don't think so; or at least, I am not claiming that this fixes any.

It really depends on what use is made of the pmdval afterwards, and
I've not checked through them.  The READ_ONCE()s which were there,
were good enough to make sure that the compiler did not reevaluate
the pmdval later on, with perhaps a confusingly different result.

But, at least in the x86 PAE case, they were not good enough to ensure
that the two halves of the entry match up; and, sad to say, nor is that
absolutely guaranteed by these conversions to pmdp_get_lockless() -
because of the "HOWEVER" below.  PeterZ's comments in linux/pgtable.h
are well worth reading through.

You might question why I made these changes at all: some days
I question them too.  Better though imperfect?  Or deceptive?

Hugh

> > 
> > HOWEVER: Note the small print in linux/pgtable.h, where it was designed
> > specifically for fast GUP, and depends on interrupts being disabled for
> > its full guarantee: most callers which have been added (here and before)
> > do NOT have interrupts disabled, so there is still some need for caution.
