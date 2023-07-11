Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7974F497
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGKQNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjGKQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:13:38 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD2E6F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:13:35 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5701eaf0d04so67166317b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689092014; x=1691684014;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdgLHjoV4bKS9Y98q58pFf+T0XmV0gVspD1CmrLbFiw=;
        b=7WC/6DtRB9A57/9p81qiAbeeCg2Sr8V6m2g3eS+Qcppfm9mHNWKZfMIuZ1vj5TScTf
         zbmhE/s5i+obRLTSWGaFHsfVNJseY0BcRLmCW/SHg1uoyQ0i2Ud+ZISNhTSTW/sb4q7K
         zaPJPS1oYWrHDFuJdZ45TNsYThtZtbVfpcsNYM/bXO2C4pU+ZzHfWHm2EY122aLcKyxP
         dZdWV2g78I2zQCDRq4c+bo1SLxRmQ7PyzGAwnIKXJhBHChstvjdXwm/jk3O924aFJf5G
         tjh8yrtjteFmpHK09YBX8bmvZ2w8JzO/M3xr/lyMjo/fluxZs/NFMMmQgGZQhprdoGCp
         2YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092014; x=1691684014;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdgLHjoV4bKS9Y98q58pFf+T0XmV0gVspD1CmrLbFiw=;
        b=WIiB/K7tnXVyAcUjjpCEf9RqxjCaI0A0C+im2ZGItvB0/PWlzxaXib13XZoojBmPpy
         /vKIFFBapDuXQEcP5UJ6Tz4kU3N8yMTLYOVTAFFGoCqAZYGxUv9JGaGBj5CZcWqKmksV
         dvsgDYKhGY6VlcLtMITZoTx+N7HfoXU4gFFB6QBw8P5LYZKOxiaaN8WQ7ksB3vkF0miJ
         GI711z6mh13sywTjQR95uP/f21fTXrHaUXR7v7MIDp4EGMnOmnNVMjCGKPQAXADf8Ryz
         WsRE2d5c0bSGAdvCf9zlZcui7Y+YfvITPD0tmEiB+d+fnuol2FmUUO8uATPShItukxjc
         UA/A==
X-Gm-Message-State: ABy/qLZFJZdYGv7ccl7NeF4oiLu5dc2ITDuzl/SmjHNSazdzM28kNeu0
        5dBAGOVQ0dEgAq/k/C5wY6m0bA==
X-Google-Smtp-Source: APBJJlGSNY6l+WLYTnvEAP2ra+lyHa2IU+IJIgtlz9Nf2/g81KXhwZy6JNq5uZCdHuGosmVI3R8kIg==
X-Received: by 2002:a0d:d647:0:b0:577:228f:467f with SMTP id y68-20020a0dd647000000b00577228f467fmr15743604ywd.36.1689092014433;
        Tue, 11 Jul 2023 09:13:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i65-20020a819144000000b0057072e7fa77sm637283ywg.95.2023.07.11.09.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:13:34 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:13:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mark Brown <broonie@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
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
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@leemhuis.info, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
In-Reply-To: <fbb2b76c-bc5c-4d75-b8cd-37479de688d4@sirena.org.uk>
Message-ID: <b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <696386a-84f8-b33c-82e5-f865ed6eb39@google.com> <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk> <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local> <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
 <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com> <fbb2b76c-bc5c-4d75-b8cd-37479de688d4@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 09:34:42PM -0700, Hugh Dickins wrote:
> 
> > I suppose I should ask you to try reverting this 0d1c81edc61e alone
> > from 6.5-rc1: the consistency of your bisection implies that it will
> > "fix" the issues, and it is a commit which we could drop.  It makes
> > me a little nervous, applying userspace-pagetable validation to kernel
> > pagetables, so I don't want to drop it; and it would really be cargo-
> > culting to drop it without understanding.  But we could drop it.
> 
> I did look at that, it doesn't revert cleanly by itself. ...

Right, that ptep_get() wrapper on the next line came in on top.
The patch to revert just 0d1c81edc61e is this:

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -703,10 +703,11 @@ struct page *vmalloc_to_page(const void
 	if (WARN_ON_ONCE(pmd_bad(*pmd)))
 		return NULL;
 
-	ptep = pte_offset_kernel(pmd, addr);
+	ptep = pte_offset_map(pmd, addr);
 	pte = ptep_get(ptep);
 	if (pte_present(pte))
 		page = pte_page(pte);
+	pte_unmap(ptep);
 
 	return page;
 }
