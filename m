Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C50737570
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjFTTy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFTTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:54:52 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C5E1982
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:54:47 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-56fff21c2ebso55292767b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687290887; x=1689882887;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IiBraH1gFEtLq0Kn5mTuDR7eletLpb8dAh5y2pzul9A=;
        b=GnK6zVktB4fTweKikYzUukoKZGCmVusKP/x6uUrsa1IZh7Lcf11VRj9767YwL28zyx
         J4JKcGvTfTr/LvFgYj5pm1tfEFEJ8PKkMTUvowkeEnkdtgmC9135h58fxQzErHTduUCX
         +m+UG/mn18iCUxOKOQQ3TboQqPdTC4trrhg3CdFjun1ZClZ8tNP63vy0pMK4T8o5rwHN
         Ev/CkGwjSSWdgG/b37eVTxoy7CA9K7VH5ECYT9iqlmvWSv+gngjFQijyE1bOMwoZXb/s
         MCqGmsFWL/xCVoRj8nY9T1uCu7dqqcS1sL95WKPUvtYF9Sc63RHc6WC/aK2yPQNdgDcy
         QIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290887; x=1689882887;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiBraH1gFEtLq0Kn5mTuDR7eletLpb8dAh5y2pzul9A=;
        b=bAQ/VoMtcaAzyVCMijP74XdHRnanDNMZDi4N9PrHZIFD/F8ugP3K0ZGKIuauza3CwC
         NvhAm22vfAdMUTN2dBiS11KLOrsR4LOWW0DeSJ5fg5DqAPQ5utUk7irwDQVhFKY9dRCk
         9ZiVMDaUL1a3vbOMnDSh9WUijjxavEXT98J0QWKT5YjRJ7ZCCm2CJQDg7zrbMXMT7ibh
         nL4EvqHFj2BPIIKma5gnLkcPzhbdcD/Hr9pZzDgSqiDNpyaQ2CLosI5gL+Cz3nVq7pgL
         bb612hfx3amddjW2whLYv+51tcZfDHfKAUgeCmMJykW8Iog8ovn+EhzIhyI8WgGyQ7V+
         HGBw==
X-Gm-Message-State: AC+VfDzWsk7aoXTtnVfOjZRwEmulODBmip21XMmHwgT7kRXILyipUErm
        AFAKQC5PpB+OwPDAYfqMsVAlXg==
X-Google-Smtp-Source: ACHHUZ5CjW+DD7ghkPvVJFGUBN1BQG+qQA/ISq9t6lWLEboPHQzho8N1caYYSPmYBruWUqH6Cq9/Mw==
X-Received: by 2002:a0d:d106:0:b0:56d:45ec:2e64 with SMTP id t6-20020a0dd106000000b0056d45ec2e64mr14660924ywd.43.1687290886830;
        Tue, 20 Jun 2023 12:54:46 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n20-20020a819e54000000b005705cbba0bcsm649525ywj.98.2023.06.20.12.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:54:45 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:54:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Hugh Dickins <hughd@google.com>,
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
In-Reply-To: <ZJGRa4zvsXfc43vB@ziepe.ca>
Message-ID: <2ad8b6cf-692a-ff89-ecc-586c20c5e07f@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <5cd9f442-61da-4c3d-eca-b7f44d22aa5f@google.com> <ZJGRa4zvsXfc43vB@ziepe.ca>
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

On Tue, 20 Jun 2023, Jason Gunthorpe wrote:
> On Tue, Jun 20, 2023 at 12:47:54AM -0700, Hugh Dickins wrote:
> > Add powerpc-specific pte_free_defer(), to call pte_free() via call_rcu().
> > pte_free_defer() will be called inside khugepaged's retract_page_tables()
> > loop, where allocating extra memory cannot be relied upon.  This precedes
> > the generic version to avoid build breakage from incompatible pgtable_t.
> > 
> > This is awkward because the struct page contains only one rcu_head, but
> > that page may be shared between PTE_FRAG_NR pagetables, each wanting to
> > use the rcu_head at the same time: account concurrent deferrals with a
> > heightened refcount, only the first making use of the rcu_head, but
> > re-deferring if more deferrals arrived during its grace period.
> 
> You didn't answer my question why we can't just move the rcu to the
> actual free page?

I thought that I had answered it, perhaps not to your satisfaction:

https://lore.kernel.org/linux-mm/9130acb-193-6fdd-f8df-75766e663978@google.com/

My conclusion then was:
Not very good reasons: good enough, or can you supply a better patch?

Hugh

> 
> Since PPC doesn't recycle the frags, we don't need to carefully RCU
> free each frag, we just need to RCU free the entire page when it
> becomes eventually free?
> 
> Jason
