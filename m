Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B07A74A485
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjGFTpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFTpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:45:30 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01791BFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:45:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-577637de4beso14083837b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688672727; x=1691264727;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jn2A84TyxlB9E6QwhZ/S3+QyShJtUiEedaODmn36QLU=;
        b=lNzL+MZHVE5Tf5jrUoH6qartx9zzmTGqRlIdWHCjVAbfYsp6CttNZlOBa0hRzJvZTL
         SocW3GJytbAfu6mxKOaeSgPA2iF9rnWdCYXvkrsIK9bHpmO7W6jRojvsd0W+wS+1M4ey
         Cy0yHMaRcD9qOOww9osMC+/qv3AnBllJOa6CwnAgkMCGCbzwsgDwWZB/A/DaH1aXsVkX
         GCRoPuBLf5rOxEvwKQVFZvVP2+nwXsMRUU4gYs9i3BpzNT/+y660I6oddp/GqxuJdZ4c
         ZEiHuDoHp93DRZmouI1YYfnuJreSUTCXVkXN8Tu0HBsepWhWGMKQWmvcj8W8/LXjSWTi
         jHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688672727; x=1691264727;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jn2A84TyxlB9E6QwhZ/S3+QyShJtUiEedaODmn36QLU=;
        b=XRnI7wBs7+tna6eqSSf8YKFdjHaBYaZ8XFuWmrLap/ZYIidNxHk7EEx724yJlZU8S8
         EMRNX5773nsaC2CB6eJhiYJmjCzkTDsmM0mPYKIOeZ13zh+VaHwMHqn4Kpb58rayCgeK
         EfSPLeFvkmA7uHo7StLgL8pLK02qOsoPNCq5IFlQBFc3qMt8FsJ3RS3MTmm7NJDhPHTn
         bCUMwi7Npn7GqD5w9G42J2IFhvsxA5jEbMiq7gc6lQnwhDSrG58daUq+CCvLTuLA0Fau
         zLX/w4Yf1P56r0ft8HdVZM5QY35mUyGiHhZcguYa0EJCMvgDFTVB8WIwWwYusulste/0
         zfDQ==
X-Gm-Message-State: ABy/qLZlYTXuvMk1NcdcFjl4XPQz3SLMlZw24sXsNr4PrYkjtL0VZS5e
        l0wmsDA4F0K4Kxw1PAjXGIdGlQ==
X-Google-Smtp-Source: APBJJlHqKtby+pVoLzti7droMN1zKJuKs2lBA2W3Af+OZJMud2WnSKOd+NI5VCViV+RTettlilf/TQ==
X-Received: by 2002:a81:5f09:0:b0:570:6667:1cfa with SMTP id t9-20020a815f09000000b0057066671cfamr3295624ywb.47.1688672726798;
        Thu, 06 Jul 2023 12:45:26 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z7-20020a81c207000000b005703cfc23c1sm539958ywc.104.2023.07.06.12.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:45:26 -0700 (PDT)
Date:   Thu, 6 Jul 2023 12:45:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <20230706170213.2ea63606@thinkpad-T15>
Message-ID: <b454cfb1-85dc-743f-8f0-30d7e3d4376@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com> <20230628211624.531cdc58@thinkpad-T15> <cd7c2851-1440-7220-6c53-16b343b1474@google.com> <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca> <20230629175645.7654d0a8@thinkpad-T15>
 <edaa96f-80c1-1252-acbb-71c4f045b035@google.com> <7bef5695-fa4a-7215-7e9d-d4a83161c7ab@google.com> <20230704171905.1263478f@thinkpad-T15> <e678affb-5eee-a055-7af1-1d29a965663b@google.com> <20230705145516.7d9d554d@thinkpad-T15> <1014735-ecc4-b4bc-3ae7-48a4328ed149@google.com>
 <20230706170213.2ea63606@thinkpad-T15>
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

On Thu, 6 Jul 2023, Gerald Schaefer wrote:
> 
> Since none of my remarks on the comments seem valid or strictly necessary
> any more, and I also could not find functional issues, I think you can add
> this patch as new version for 07/12. And I can now give you this:
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Great, thanks a lot Gerald.
The one change I'm making to it is then this merged in:

--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -455,6 +455,11 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	page = virt_to_page(pgtable);
 	SetPageActive(page);
 	page_table_free(mm, (unsigned long *)pgtable);
+	/*
+	 * page_table_free() does not do the pgste gmap_unlink() which
+	 * page_table_free_rcu() does: warn us if pgste ever reaches here.
+	 */
+	WARN_ON_ONCE(mm_alloc_pgste(mm));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
