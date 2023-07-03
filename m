Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA47464DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGCV3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGCV3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:29:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70BE69
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:29:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-262d33fa37cso2345891a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 14:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1688419778; x=1691011778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dg0Gj8viEWfIWcxIZc6iyfyM+TCYwvws/9N3ezb+Z4=;
        b=ciMHCgEytyQpXiLlKqi3gz/v7Q2CHhYlXp9swK68CxESaRga14VO+v3ioFdBXsYDLs
         rcJstbloCFNhdyL8erhHWR7+k/2G2ZmekQkHOlLD+CHVeKnxlVQEAYi4thVU88jUmlqP
         j3AGFkPfvugYcv6dCmSAzMJAAyhg1ABHOGQ6MaLAdsnWWMIo4JB8NFzrMsH4cg3S6MEo
         u2Zcz5D9ARgll/H+oBV/djEHlDDqEHh/6LiwiUjnMih7ZCbaZjvFAg4+P4L6MdepK6me
         Bll7SIw/4ovRaQDEUVlzPsNcEFS/MXpYuVmlTSmCre5BrbjEKllFu+L2hZxsC8HgQV9B
         IGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688419778; x=1691011778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dg0Gj8viEWfIWcxIZc6iyfyM+TCYwvws/9N3ezb+Z4=;
        b=dW7p6a010I9FcOIiGQdNj0XLiL9EMWFnXoVKFIp+vWHdAggMJratqjjjdrXJQNk0HY
         BslMAg7nN9OsEXmrEGke8/8f9WII/M5jU1UFF0X1/Q+qxKvk63Bc6W3gPFDt/eV1mNNQ
         QjBUI3eCf3ABxt3SQ3IgvjC4/ZbmMen4q3Wq7MBYxDSn2WBGWEyRvbV0gEzTnEjAYLDq
         6X4DIGU+1er9c+C8o8LxfoMy1PbHzxNCP0grRMsfzYUAHL7CMRtTW08hFwRbz6QgWRRz
         Wv+8z4F80cfGQa63p06ql0Vcm/9gjMnW6VzHugCrMGYmWTWiB+MoqIUukFaNronMb0fI
         8PLA==
X-Gm-Message-State: ABy/qLZdA1IG/L4Nf62Cx5F0sv4ITYgBljN+ckd42Jxtlt0HJ0djKWdc
        tPWdSWYC/rHs/v25IIM/5mOrVQ==
X-Google-Smtp-Source: APBJJlE0dK/ixgJCjZM8BVxtoBqxR3hYidUzDYcxy89uMsoxRbB7avUM4k+kl/Tzd5k23OlP0AX/hg==
X-Received: by 2002:a17:90a:1b02:b0:263:7d55:de2e with SMTP id q2-20020a17090a1b0200b002637d55de2emr9149088pjq.9.1688419778192;
        Mon, 03 Jul 2023 14:29:38 -0700 (PDT)
Received: from ziepe.ca (ip-216-194-73-131.syban.net. [216.194.73.131])
        by smtp.gmail.com with ESMTPSA id gz24-20020a17090b0ed800b00263c8b33bcfsm2234333pjb.14.2023.07.03.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:29:37 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qGR72-000BQ9-Bm;
        Mon, 03 Jul 2023 18:29:36 -0300
Date:   Mon, 3 Jul 2023 18:29:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
Message-ID: <ZKM9wEKZZes4n4u0@ziepe.ca>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
 <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
 <20230630153852.31163592@p-imbrenda>
 <062b19-4cf1-261-a9bf-9cefd32382fc@google.com>
 <20230630182556.7727ef50@p-imbrenda>
 <7f6d399b-c47-1faa-f7f6-9932b9811f8c@google.com>
 <20230703130013.559217c9@p-imbrenda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703130013.559217c9@p-imbrenda>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 01:00:13PM +0200, Claudio Imbrenda wrote:
> On Fri, 30 Jun 2023 12:22:43 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> 
> [...]
> 
> > That's something I would have expected to be handled already via
> > mmu_notifiers, rather than buried inside the page table freeing.
> > 
> > If s390 is the only architecture to go that way, and could instead do
> > it via mmu_notifiers, then I think that will be more easily supported
> > in the long term.
> 
> I am very well aware of that, and in fact I've been working on
> exactly that for some time already. But it's a very complex minefield
> and therefore I'm proceeding *very* carefully. It will take quite some
> time before anything comes out.

Yes +1 on this please, creating your own arch cross connect with kvm
in the page table freers is really horrible..

Jason
