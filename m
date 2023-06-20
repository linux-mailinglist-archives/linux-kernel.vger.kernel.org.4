Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408B1736B60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjFTLqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjFTLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:46:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018FA1BDC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:45:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-668711086f4so1765611b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687261549; x=1689853549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWdugmL7jiCCazRwRTiCxhXSGGIdZDMM/iY0UbvTdUM=;
        b=cnn8IRs9UEV2IyxM2/dyNE8Ybbqmsnj6tLoR8M1bmXQAVunFEwC20TKu6DUOVKG4AB
         L2Yp6/XPUf6F5Xy+nc7uJZfoC02InmQWSMblYoG/4uAdrA9GIFvL7kwUb/yEeNhYFGr1
         bkwG9DCJKJm7UPMDVOHOR7oHEfHhzz1mYZlMGy4Z2i7tBudfceWk0OsWq4cf8C2qfKpV
         w9kz4Q6fy8cbK1P9tLY7jnan9hyd8ZaBomTDWQJ4IaOPbEXOkOCCXRQOiThAn1UjmjTv
         PMpNa0lpCABevs0dIyQN5iH+zWSS9D1PjlkqlJwomy4rRdkHiQnPe7pPZunP1WQZBtR3
         zPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261549; x=1689853549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWdugmL7jiCCazRwRTiCxhXSGGIdZDMM/iY0UbvTdUM=;
        b=mBCCp78sqSiTRhyJYdTvv1pTjATRcrq8fXpYxcsbhRVI8tOT7nDOdE4wIMyAfHdoRQ
         H5ZPbcUnqtOvMHZqT8SV2F2n2ryksllvLwDt5N9X0Bw5Gik7KuACLrMSsH/0QQicSsXe
         o1mTIqhElAQvG4YiTny3VCY6hEYuYk8H4CE6zi3kW43bjnIdiNK2OXEwrVd2pg0mT53t
         CLMc0WOWh36eMJFgNWyYa+fw6Yxv5AScf7h1VRRLBiXLK/2AvWiRzameL9Nnnaux61no
         JuAnMjkVCq7FL+T5rx6682Xl+4UsRddnPWioqvCWG3kXDYDZAmYA2rYWclixmraTo1aL
         6qxA==
X-Gm-Message-State: AC+VfDzugxO3kwS/TeiyTsjo4O8j+6//EOAle2VY9FwjlAzTCM79Aq/+
        P5I9xU8PLXdxdsht2jRQciwgcQ==
X-Google-Smtp-Source: ACHHUZ4X6nDwRKfeDuMyEgMyTrD6VgfsYjM5cSKUHYx3cAu4vDqqHRc1ln2Pqg94YC+C6bvDGfs7/g==
X-Received: by 2002:a05:6a00:1820:b0:668:732d:7d9f with SMTP id y32-20020a056a00182000b00668732d7d9fmr10033336pfa.2.1687261549460;
        Tue, 20 Jun 2023 04:45:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78e51000000b0062d859a33d1sm1207199pfr.84.2023.06.20.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:45:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qBZnv-007KSY-BA;
        Tue, 20 Jun 2023 08:45:47 -0300
Date:   Tue, 20 Jun 2023 08:45:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        "David Sc. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 05/12] powerpc: add pte_free_defer() for pgtables
 sharing page
Message-ID: <ZJGRa4zvsXfc43vB@ziepe.ca>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
 <5cd9f442-61da-4c3d-eca-b7f44d22aa5f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd9f442-61da-4c3d-eca-b7f44d22aa5f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:47:54AM -0700, Hugh Dickins wrote:
> Add powerpc-specific pte_free_defer(), to call pte_free() via call_rcu().
> pte_free_defer() will be called inside khugepaged's retract_page_tables()
> loop, where allocating extra memory cannot be relied upon.  This precedes
> the generic version to avoid build breakage from incompatible pgtable_t.
> 
> This is awkward because the struct page contains only one rcu_head, but
> that page may be shared between PTE_FRAG_NR pagetables, each wanting to
> use the rcu_head at the same time: account concurrent deferrals with a
> heightened refcount, only the first making use of the rcu_head, but
> re-deferring if more deferrals arrived during its grace period.

You didn't answer my question why we can't just move the rcu to the
actual free page?

Since PPC doesn't recycle the frags, we don't need to carefully RCU
free each frag, we just need to RCU free the entire page when it
becomes eventually free?

Jason
