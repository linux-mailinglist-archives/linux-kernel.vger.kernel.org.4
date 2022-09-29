Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74E5EF6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiI2NjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiI2NjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:39:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64441879DA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:39:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a80so1485656pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=g3H7Fcpyw8fyayYdLffV0RX5soiF4EbtKkJrM7w/NLU=;
        b=m3GLnqQdyjwLMEin21Lj7q5pk3V5oolReoHaMp2tZ+bf/VZ2oWLbMLWQB8BjLcplSr
         A4y5yLMQuhZKV/GNIx36RWKVNjffaPLza7CDxOQ218pbya9mGURP+fhCv4a50IZlDiqA
         f57iV9VLkG1cpkmmaqFjiTXstGMTC5q8oZtinhqIeLsWApbLgrGPHhhMnCkm0VlQu6s7
         XYodXt1DvXfuKe52a3/LqKBqQAinGpoloXFKW0VdpUvEvnuekHiEol7/um8djQV4xFHR
         7dnukJk7xjNWbGxBzJq+rFrkj0tjOOq3Jbevtw2O/lD7ihUuWsP/oysFySddbYS9KyX+
         FPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=g3H7Fcpyw8fyayYdLffV0RX5soiF4EbtKkJrM7w/NLU=;
        b=phEor+nW19MLTGFFmTmVqWK86VCoVuJ0PxqDFmOPW/y0g1WmzbvnRX3jk+J4Oo8cOm
         cgMKGXUW3q56LJxGehjFjHkPST9sH0FtX7SQKYFM4rrguWpG14dDhVqnP91xIYQw4+Xr
         yZedmwBDRhkhWq5GSI+JSPgiZC4yaKaigt8WNwqoREFIYIJDLYlg2VXQXC+p0owiKiWE
         y9yoLr8GXVxxHUz+uuldKVIt8EMo97Or7agmpUdBisPpEc7ucd/iUoJE0C/PkCUZk7Zd
         MD+7tD5KHLBKmR9ji5dF/Y3UALbdYAZP1eVNluDbXJM6dsvOfiBx6MjfLdLFOY32pxkd
         BKLA==
X-Gm-Message-State: ACrzQf0B/rQEZIJ+8gB46yiMGnLHalQPaeCsoh3/cX+co070nG5i6Hxt
        mzeEgFd4Xk7xFqCp4J0zPUs=
X-Google-Smtp-Source: AMsMyM47X/JMtaA6HAVtDJgIftP1m1YbO9TT8Bgi74p9v1UlSWtNvp4o7o4kFmds/6oxEX73Z+VoFA==
X-Received: by 2002:a63:8a43:0:b0:440:34f2:c3c4 with SMTP id y64-20020a638a43000000b0044034f2c3c4mr3024905pgd.408.1664458741170;
        Thu, 29 Sep 2022 06:39:01 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b9a-f5f9-665b-0715-9cc1.dynamic-ip6.hinet.net. [2001:b011:20e0:1b9a:f5f9:665b:715:9cc1])
        by smtp.gmail.com with ESMTPSA id 205-20020a6214d6000000b0055b05b90480sm833306pfu.66.2022.09.29.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:39:00 -0700 (PDT)
Date:   Thu, 29 Sep 2022 21:38:53 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>,
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
Message-ID: <YzWf7V5qzMjzMAk4@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
 <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for replying late.

On Wed, Sep 28, 2022 at 04:03:19PM +0200, David Hildenbrand wrote:
> On 27.09.22 21:53, Chih-En Lin wrote:
> > On Tue, Sep 27, 2022 at 06:38:05PM +0000, Nadav Amit wrote:
> > > I only skimmed the patches that you sent. The last couple of patches seem a
> > > bit rough and dirty, so I am sorry to say that I skipped them (too many
> > > “TODO” and “XXX” for my taste).
> > > 
> > > I am sure other will have better feedback than me. I understand there is a
> > > tradeoff and that this mechanism is mostly for high performance
> > > snapshotting/forking. It would be beneficial to see whether this mechanism
> > > can somehow be combined with existing ones (mshare?).
> > 
> > Still thanks for your feedback. :)
> > I'm looking at the PTE refcount and mshare patches. And, maybe it can
> > combine with them in the future.
> > 
> > > The code itself can be improved. I found the reasoning about synchronization
> > > and TLB flushes and synchronizations to be lacking, and the code to seem
> > > potentially incorrect. Better comments would help, even if the code is
> > > correct.
> > > 
> > > There are additional general questions. For instance, when sharing a
> > > page-table, do you properly update the refcount/mapcount of the mapped
> > > pages? And are there any possible interactions with THP?
> > 
> > Since access to those mapped pages will cost a lot of time, and this
> > will make fork() even have more overhead. It will not update the
> > refcount/mapcount of the mapped pages.
> 
> Oh no.
> 
> So we'd have pages logically mapped into two processes (two page table
> structures), but the refcount/mapcount/PageAnonExclusive would not reflect
> that?
> 
> Honestly, I don't think it is upstream material in that hacky form. No, we
> don't need more COW CVEs or more COW over-complications that destabilize the
> whole system.
>

I know setting the write protection is not enough to prove the security
safe since the previous COW CVEs are related to it. And, if skipping the
accounting to reduce the overhead of fork() is not suitable for upstream
, we can change it. But, I think COW to the table can still be an
upstream material.

Recently the patches, like refcount for the empty user PTE page table
pages and mshare for the pages shared between the processes require more
PTE entries, showing that the modern system uses a lot of memory for the
page table (especially the PTE table). So, I think the method, COW to
the table, might reduce the memory usage for the side of the multiple
users PTE page table.

> IMHO, a relaxed form that focuses on only the memory consumption reduction
> could *possibly* be accepted upstream if it's not too invasive or complex.
> During fork(), we'd do exactly what we used to do to PTEs (increment
> mapcount, refcount, trying to clear PageAnonExclusive, map the page R/O,
> duplicate swap entries; all while holding the page table lock), however,
> sharing the prepared page table with the child process using COW after we
> prepared it.
> 
> Any (most once we want to *optimize* rmap handling) modification attempts
> require breaking COW -- copying the page table for the faulting process. But
> at that point, the PTEs are already write-protected and properly accounted
> (refcount/mapcount/PageAnonExclusive).
> 
> Doing it that way might not require any questionable GUP hacks and swapping,
> MMU notifiers etc. "might just work as expected" because the accounting
> remains unchanged" -- we simply de-duplicate the page table itself we'd have
> after fork and any modification attempts simply replace the mapped copy.

Agree.
However for GUP hacks, if we want to do the COW to page table, we still
need the hacks in this patch (using the COW_PTE_OWN_EXCLUSIVE flag to
check whether the PTE table is available or not before we do the COW to
the table). Otherwise, it will be more complicated since it might need
to handle situations like while preparing the COW work, it just figuring
out that it needs to duplicate the whole table and roll back (recover
the state and copy it to new table). Hopefully, I'm not wrong here.

> But devil is in the detail (page table lock, TLB flushing).

Sure, it might be an overhead in the page fault and needs to be handled
carefully. ;)

> "will make fork() even have more overhead" is not a good excuse for such
> complexity/hacks -- sure, it will make your benchmark results look better in
> comparison ;)

;);)
I think that, even if we do the accounting with the COW page table, it
still has a little bit improve.

> -- 
> Thanks,
> 
> David / dhildenb
>

Thanks,
Chih-En Lin
