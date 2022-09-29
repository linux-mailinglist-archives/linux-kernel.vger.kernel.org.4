Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817D45EFD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiI2TCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiI2TCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:02:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA513F29A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:02:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b75so2243632pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VRWMAHYEyCYnit1DgorRCfjCV475mNFdc2il+dM3xyY=;
        b=H6Kx+Ps/laRy7Elku5rdgLa0ErE+Jw9V14A2+tjsz5c5RM+7m1fFuJU7yity9lcpiq
         dalHK68M/pEyCrSQrSQ74c/vqpgtSTW+w/VVONBSy3nHe7REYYy+GREGMLNXznm72blD
         m1eNJocmu7QaSgJdP071cHPTWgKNQFw352MITlWOLA4ZVHYS3EX8LtH7lS+XRKVQPPXT
         wlqk3t14bymOsU353YBk61cRQHVhYVXSNApuBW9xH/AubOPr7mXKSrZUHUgkf/1ZqYGl
         iWGnbZNzwTqPqzf9/nLuPpdij+f4k0DdeinHVTu1oQk805HlcUZvNX8UMTpyTtHTUUHv
         rZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VRWMAHYEyCYnit1DgorRCfjCV475mNFdc2il+dM3xyY=;
        b=Zcn/bGRSikDF7d4BuVK44e+2AT+pbqDjY8LLUZ/TE6qlp1DDMhHxpDSAonYhT+VDKC
         TOKvAv4562bueqagZwIBICaaakbDQZy+QhEd5PLjnMH7vqANmctohS+Bc6V2b6sjnIvy
         5CyW9z/EOl4xWnwscCvREH5mhFFue/qUPPuImO0ElNk6nauGR7VWxKSTkbVN5ebQ3033
         A9P9PTvcyXdxmGnKH8AfKMkyD/78LAy5e3hSviHNCEd7NZTIsUk8/E8igDijklqGOJ4M
         8vlmOHfha6x1nn6ZYy0oIx1cc0A90kfv/xG11UTf5e0sPJmTzV11qJkV4aYCjAUQa4db
         venQ==
X-Gm-Message-State: ACrzQf2HomCKcM8AUyR3IQEj62NAJ9A3zQ1hL1sg2pc/wjuJKMzF3wU8
        EfaCEJhEREawLBteHr6kqzQ=
X-Google-Smtp-Source: AMsMyM52NtPaZCjmHJfGnjdOcx1m8tXP4rloiRSU164tOI5oywdQdY3BPtOCczVOtjDYHRTH4M46Tg==
X-Received: by 2002:a63:ce17:0:b0:42a:bfb6:f218 with SMTP id y23-20020a63ce17000000b0042abfb6f218mr4066583pgf.484.1664478157417;
        Thu, 29 Sep 2022 12:02:37 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b9a-f5f9-665b-0715-9cc1.dynamic-ip6.hinet.net. [2001:b011:20e0:1b9a:f5f9:665b:715:9cc1])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090a3b4600b002098f3b4c67sm137488pjf.34.2022.09.29.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:02:36 -0700 (PDT)
Date:   Fri, 30 Sep 2022 03:02:29 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
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
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Message-ID: <YzXrxePakkc3eHXk@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
 <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
 <YzWf7V5qzMjzMAk4@strix-laptop>
 <39c5ef18-1138-c879-2c6d-c013c79fa335@redhat.com>
 <YzXkDKr6plbJZgG4@strix-laptop>
 <C4CA4A1E-5553-422E-B8C0-8A5FF17DFCED@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C4CA4A1E-5553-422E-B8C0-8A5FF17DFCED@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 06:40:36PM +0000, Nadav Amit wrote:
> On Sep 29, 2022, at 11:29 AM, Chih-En Lin <shiyn.lin@gmail.com> wrote:
> 
> > That case could be caught in copy_pte_range(): in case we'd have to allocate
> >> a page via page_copy_prealloc(), we'd have to fall back to the ordinary
> >> "separate page table for the child" way of doing things.
> >> 
> >> But that looks doable to me.
> > 
> > Sounds good. :)
> 
> Chih-En, I admit I did not fully read the entire correspondence and got deep
> into all the details.
> 
> I would note, however, that there are several additional components that I
> did not see (and perhaps missed) in your patches. Basically, there are many
> page-table manipulations that are done not through the page-fault handler or
> reclamation mechanisms. I did not see any of them being addressed.
> 
> So if/when you send a new version, please have a look at mprotect(),
> madvise(), soft-dirty, userfaultfd and THP. In these cases, I presume, you
> would have to COW-break (aka COW-unshare) the page-tables.
> 

Sure. Before I send the new version I will try to handle all of them.
Thank you for the note.

Thanks,
Chih-En Lin
