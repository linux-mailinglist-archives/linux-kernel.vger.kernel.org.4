Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89D718A36
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjEaTcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjEaTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:32:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27F13E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:32:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53f158ecfe1so40227a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685561568; x=1688153568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1b4BZmA9xJj4k+yX9G1OpwN8zaCq1YL9w8UMx2HW8U=;
        b=DqMU+tzEkEG/KBm/Eq8c50aBcNpCYLCDfIfu2qjwwcPg0L4B3pyIohHBAzyR1rV0BP
         V/m/A6VPjh2V/gAf1InQamkLfVKnTZy+tS4G8D7G9FxBmlJSwxxYbjh8ZmupHNl0eevX
         lPbMy/Tw/ElEj/9T2zLclMOTikXMCoO4zi4Jz/K3dXTMzCQPf+al0bdolspqKcUBZ42g
         y7dXf745BGesGzWYp54442rTbaeMerKhc5X4qohTsEn7zGpNGB/zvD6xbsbfEfu2Zlu+
         WM86IzoR72al1oCugiwWriFtaYbSkEqg9fqkAfaWIDuLcOZimNJeIf/7vhUEyBMi3En6
         l4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561568; x=1688153568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1b4BZmA9xJj4k+yX9G1OpwN8zaCq1YL9w8UMx2HW8U=;
        b=SpibDXl2tLheIHK+xdaenzn7gBZdh/YkjgxwhQVZ1aaP6dUvvW2Ok3Yzel0JPaUF6N
         DCk5qJQxLQ5vPBD3rDCBcKw+DiX5w3bZ0m/XgxM9IND/r3B1Os5P1bS4PKaQhe+/VMQy
         q7TxhEHN2KE7aKSImCarMDBkgalgb+m1MvSTuvbg9lTX1UXWRbQhdYy7yD5M9dUvPZx6
         UKhFygbaX+8PxbzMVqVkt7hkXL7YMGmJDfI0BPtscYQ8Z6ljqGTKzrJg0OhVRHEzjSur
         NhwKylK5BNqsyPwQxhxxaHuvOoCWKgzb0YhNasWF2S/VGwPf37HXtn47RMGjQyGZuQiK
         yQQA==
X-Gm-Message-State: AC+VfDza8KFX4eDN1wvmRW35Iwq/rHO7LK706PJdzM9RGjl1KQiTZptw
        KuvRPk3SSzcEv4BhidMoB8TLCQ==
X-Google-Smtp-Source: ACHHUZ7lcXE9sadSW9Rrzl5BAk50j1XTwgJx3egzhx6uSXmvo9XJdNso/P+uf7WiDgNFtlx4kiddiQ==
X-Received: by 2002:a17:902:c3ca:b0:1b1:714a:335b with SMTP id j10-20020a170902c3ca00b001b1714a335bmr1984367plj.6.1685561568342;
        Wed, 31 May 2023 12:32:48 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b001b034faf49csm1733132pla.285.2023.05.31.12.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:32:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q4RYs-0017pL-AV;
        Wed, 31 May 2023 16:32:46 -0300
Date:   Wed, 31 May 2023 16:32:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
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
Subject: Re: [PATCH 02/12] mm/pgtable: add PAE safety to __pte_offset_map()
Message-ID: <ZHeg3oRljRn6wlLX@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <923480d5-35ab-7cac-79d0-343d16e29318@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923480d5-35ab-7cac-79d0-343d16e29318@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 11:16:16PM -0700, Hugh Dickins wrote:
> There is a faint risk that __pte_offset_map(), on a 32-bit architecture
> with a 64-bit pmd_t e.g. x86-32 with CONFIG_X86_PAE=y, would succeed on
> a pmdval assembled from a pmd_low and a pmd_high which never belonged
> together: their combination not pointing to a page table at all, perhaps
> not even a valid pfn.  pmdp_get_lockless() is not enough to prevent that.
> 
> Guard against that (on such configs) by local_irq_save() blocking TLB
> flush between present updates, as linux/pgtable.h suggests.  It's only
> needed around the pmdp_get_lockless() in __pte_offset_map(): a race when
> __pte_offset_map_lock() repeats the pmdp_get_lockless() after getting the
> lock, would just send it back to __pte_offset_map() again.

What about the other places calling pmdp_get_lockless ? It seems like
this is quietly making it part of the API that the caller must hold
the IPIs off.

And Jann had a note that this approach used by the lockless functions
doesn't work anyhow:

https://lore.kernel.org/linux-mm/CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com/

Though we never fixed it, AFAIK..

Jason
