Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF672752E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjFHCrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjFHCrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:47:07 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8677A2715
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:46:40 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-568928af8f5so2663247b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686192397; x=1688784397;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ASVf02IlD8C2FBeHhgGmTxXuzubkx9rvqSR5YGjpQE=;
        b=da3ktJDtrHlXFJY7fBZV9rF65uZZhghhOV9dnWa/Fsa39j+kMpSSL6DALstHpQz61g
         K4YVYJos6+GGP6Xf9ot3Uk/1ZbuoyK1eEfBQh/bTNe/mDYJxX8S+fb9se2eckLKEuTOP
         UD7/4cfGR2T85Ke8Bc4ObLfx9a9FXmomkcXEFQInN+aLXpDDyqofJ4uF60Ko9gzt3x2L
         MGX9ZxFfnKfNnjs1tFSzEKj5NE78sfc+UDhIQev+RhydadRJR8BTDVk3Lch9IO5KK2Az
         N/YtKtrcGMeEnF2xteGjLRnISuA5d7eV63yxWyEhWp6zKk6kXjpoiTGJgfB7a9sG5sLf
         6M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686192397; x=1688784397;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ASVf02IlD8C2FBeHhgGmTxXuzubkx9rvqSR5YGjpQE=;
        b=g5Vp5rjA4hfrBNu1tCmLHaZbbBoyFUS8qWxfPfqi7/hHmhcftU9HbouIp0+zjiQRTT
         7TI09jKn83VaGYLarIZ8YuRq/8Ha56CBWx9oPocc3TxxFwmoaxntsF63GdheSJgf5nxx
         oiqfidaNoL4EmO/Q9debq59K5GJmok1oOc9rdWUBDdZfkZXT5xjvtw8bSUZ4d0aDrJ96
         ab4iwlBHK3kTcpMdec6glr3Bma4pMqYdifjK5ImZYtP7PK0OO+ufLNbnH4uN/ecTI/j+
         N56pq1J2zjENf3xog2Nf0zSzhglLQ5C3UL6teNirTzqcFqRGNLwnG23ehVdsaVC2ew4b
         zQfw==
X-Gm-Message-State: AC+VfDxptEELMuKwvlZs69zx0juyzgYd370DADdbFDhMiDb1sxm7HwbR
        Oot/FG05vLyCsz676a/l2+LDGw==
X-Google-Smtp-Source: ACHHUZ4dFnfQCU4EFBdNXwNcj7Ir8z8QRqL+UH/A47UqaCSLxCcPaFmZ7Dypt65uEduAukIhZYJfeQ==
X-Received: by 2002:a81:5f06:0:b0:561:bbb8:2dc3 with SMTP id t6-20020a815f06000000b00561bbb82dc3mr981921ywb.21.1686192396777;
        Wed, 07 Jun 2023 19:46:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j7-20020a816e07000000b00568e7e21db7sm103768ywc.96.2023.06.07.19.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 19:46:36 -0700 (PDT)
Date:   Wed, 7 Jun 2023 19:46:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
In-Reply-To: <ZH99cLKeALvUCIH8@ziepe.ca>
Message-ID: <ed24b58f-ef9f-2427-7372-5c77378c5b40@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com> <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com> <ZH99cLKeALvUCIH8@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023, Jason Gunthorpe wrote:
> On Mon, Jun 05, 2023 at 10:11:52PM -0700, Hugh Dickins wrote:
> 
> > "deposited" pagetable fragments, over in arch/s390/mm/pgtable.c: use
> > the first two longs of the page table itself for threading the list.
> 
> It is not RCU anymore if it writes to the page table itself before the
> grace period, so this change seems to break the RCU behavior of
> page_table_free_rcu().. The rcu sync is inside tlb_remove_table()
> called after the stores.

Yes indeed, thanks for pointing that out.

> 
> Maybe something like an xarray on the mm to hold the frags?

I think we can manage without that:
I'll say slightly more in reply to Gerald.

Hugh
