Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A25ECC17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiI0SXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiI0SXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:23:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9F10252B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:23:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso16366513pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RixpraDw2SxLEdK6PC2PZsHmmx7TUNCjtnumQde8TDs=;
        b=YG1XIdYwLT4gDWQm4QZCR8cmjHC99hMkMt9QI/Pj2UmC3Hp+Mc4ePxjgQgyxJ/dl+K
         MpiC1Iapzm5V1bJ5SdOTh8O72Vv84R5NlsBhK827P63a41mZEIBo95n/txTkJ8FjIP6i
         BAQQ4YCZcBVOa0F2x4avjM7TrrsoKuCrMlZkSBJqFinhBjdSro+RhWA+K5S1PeA5Zo2t
         5mrF/Py/MOJeR0/xPkr+RMn541TPMlKpvihXqQtQSRhOXxFI/892hhNr66vuwzz5awWj
         u1ROc54sEujB315G2d0Qgr+Ql/s3eLsOEXuSnLrJhRB9qH0jRwSb04+vsZbe3tm0SXkP
         xy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RixpraDw2SxLEdK6PC2PZsHmmx7TUNCjtnumQde8TDs=;
        b=d2ulsF3+9UJqy2EsRS7NfE4E6SjV+6ue4EYsDlNyEBtQsAUjoew3AVwOqmhmQrrC4V
         q7slUR/VOurxgofqVWeQL7tnm9kirkcNk2ZjUGtRlVoZUGp+M1Azc9EZuDTznBDriLZK
         QZTq2B8mvshTctWwC79koW4ylM28kmU8/WRl7lMM3JWz8LJiIpBhvbUvKfP4uVc/SPcb
         wzZrjpsJN4Q0Ju9aP8k77fBKsRjPs8msn0wI2/va1JSJi8msJ2d/AziiMp5s/pvBfKsX
         ZsYylg0kRM9BPwRXmJbgmMNrZN2Y47AaxwRRkLP4pPKqInGl1BOO52rZEB26PH6JwrCa
         ldjA==
X-Gm-Message-State: ACrzQf0OJgXGyRvSII14qJd0yHGC4HTgBbIlcrzWx2n3U0e+ICQBQiO8
        u1VisTaA9N2Xg7CZ8CLTEhI=
X-Google-Smtp-Source: AMsMyM4SU0kK4m6sQWEtLv+2eujXdmV15a96InbJxsZxOaXDg9d3aKQUVwA7UBEFJqEw8TuD9Q3vmQ==
X-Received: by 2002:a17:902:e74b:b0:178:2976:41b0 with SMTP id p11-20020a170902e74b00b00178297641b0mr28254870plf.105.1664303013185;
        Tue, 27 Sep 2022 11:23:33 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b32-d148-19d6-82fa-6094.dynamic-ip6.hinet.net. [2001:b011:20e0:1b32:d148:19d6:82fa:6094])
        by smtp.gmail.com with ESMTPSA id w198-20020a627bcf000000b0052d2b55be32sm2161147pfc.171.2022.09.27.11.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 11:23:32 -0700 (PDT)
Date:   Wed, 28 Sep 2022 02:23:25 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 3/9] mm, pgtable: Add ownership to PTE table
Message-ID: <YzM/nQHTJu4OpQJh@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-4-shiyn.lin@gmail.com>
 <2A6CA595-1F8D-4A83-9E85-E2C4392395CB@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2A6CA595-1F8D-4A83-9E85-E2C4392395CB@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:30:39PM +0000, Nadav Amit wrote:
> > +static inline void set_cow_pte_owner(pmd_t *pmd, pmd_t *owner)
> > +{
> > +	smp_store_release(&pmd_page(*pmd)->cow_pte_owner, owner);
> > +}
> > +
> > +static inline bool cow_pte_owner_is_same(pmd_t *pmd, pmd_t *owner)
> > +{
> > +	return smp_load_acquire(&pmd_page(*pmd)->cow_pte_owner) == owner;
> > +}
> 
> Hiding synchronization primitives in such manner, and especially without
> proper comments, makes it hard to understand what the ordering is supposed
> to achieve.
> 

It ensures that every time we write into the pointer, the reader
will ebserve the newest one.
I will add the comments.

Thanks,
Chih-En Lin
