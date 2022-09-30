Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3D05F0F91
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiI3QFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiI3QFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E143312
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664553917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c4QE/ZnHkd3SdEyfwjL7hBSKGyN2ZeQxXhczkAxVxs8=;
        b=GXaeX1Xb9bBSAHPdbHdZi+RpzxIBTpwUzkaaTaa29kRIi9t1elNHGNSZSqu8ZU3gV5B43z
        QSsqYWNuTN2mS6IBCtvhbIjpzlmthhJ81JsGVF/uLmrS9ECCtitP2NS9kwdPzQQrsFSA+i
        tYeLsxbeQwHSufYFXuf02tVbg64bXhU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-mcnt18dUNXS7v4eDvaJ2Mw-1; Fri, 30 Sep 2022 12:05:15 -0400
X-MC-Unique: mcnt18dUNXS7v4eDvaJ2Mw-1
Received: by mail-qt1-f200.google.com with SMTP id bn4-20020a05622a1dc400b0035d24923a7fso3241224qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=c4QE/ZnHkd3SdEyfwjL7hBSKGyN2ZeQxXhczkAxVxs8=;
        b=UsjNdUpPfmow2WoJwkTn0BNj9/yw6awXWaUCwXCGXX8zShg6hTP0RQnMsFnzaOvCc/
         /cisWHZY8RgNMrf7fhDwk0LAKBO50jh+PpH/matieEabMlbMov73cyBDbnbJ9opfhzxM
         5+T8vnO+Gzt0Y096LAbJVgCTXYv/Pnff2QXeua/iw/fc7F1nlcgo59Ixm6sMbWi+1CSy
         V0h+D7kZJBujrCreilbtsSusvK3nx7kwUYN4n30yW6YI73O3pULcvMnDZogN/YG0ezsh
         vUWGXOJoPAaxF1BRwmbyThJO8GvE9YVq5wjgkXNERFpo5s6TsOLlVksE5EkMKLh7uhGR
         uhhA==
X-Gm-Message-State: ACrzQf2bC7XPaB+zj+EqtqtSwRmPbEsezeUdPEew5FD5Mor6YlvbP5QK
        cVeyW5Bwwt24ra6b0xVxY12s/tDm1jqx1FLIZTrO1bwrOyLeoCrKr6M55sq5tzp8TS7VFHGB1Jw
        DiDe97srGw2XiLoZp+ZnRUj9Z
X-Received: by 2002:a05:622a:315:b0:35d:53c4:2de4 with SMTP id q21-20020a05622a031500b0035d53c42de4mr7258909qtw.4.1664553914718;
        Fri, 30 Sep 2022 09:05:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68f817BNHClAWyHnNMg3tHTIUUfp4CfAm1J5ppDPG9kVT73B0aE3HgOachOvDEG/MLdL3OyA==
X-Received: by 2002:a05:622a:315:b0:35d:53c4:2de4 with SMTP id q21-20020a05622a031500b0035d53c42de4mr7258846qtw.4.1664553914183;
        Fri, 30 Sep 2022 09:05:14 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id 16-20020ac84e90000000b0035d4b13363fsm2361772qtp.48.2022.09.30.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:05:13 -0700 (PDT)
Date:   Fri, 30 Sep 2022 12:05:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-ID: <YzcTt3P3ofvbGQmi@x1n>
References: <0000000000006c300705e95a59db@google.com>
 <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
 <Yy5WHvioerD2Sev1@x1n>
 <Yy8dBrmvDmqlsRXE@x1n>
 <Yy9T/JmVb4ymf6WM@monkey>
 <YzDuHbuo2x/b2Mbr@x1n>
 <YzMjxY5O6Hf/IPTx@monkey>
 <YzMomT+OusJnLOPC@x1n>
 <YzYrYVeA0b9d5dos@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzYrYVeA0b9d5dos@monkey>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 04:33:53PM -0700, Mike Kravetz wrote:
> I was able to do a little more debugging:
> 
> As you know the hugetlb calling path to handle_userfault is something
> like this,
> 
> hugetlb_fault
> 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> 	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> 	if (huge_pte_none_mostly())
> 		hugetlb_no_page()
> 			page = find_lock_page(mapping, idx);
> 			if (!page) {
> 				if (userfaultfd_missing(vma))
> 					mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> 					return handle_userfault()
> 			}
> 
> For anon mappings, find_lock_page() will never find a page, so as long
> as huge_pte_none_mostly() is true we will call into handle_userfault().
> 
> Since your analysis shows the testcase should never call handle_userfault() for
> a write fault, I simply added a 'if (flags & FAULT_FLAG_WRITE) printk' before
> the call to handle_userfault().  Sure enough, I saw plenty of printk messages.
> 
> Then, before calling handle_userfault() I added code to take the page table
> lock and test huge_pte_none_mostly() again.  In every FAULT_FLAG_WRITE case,
> this second test of huge_pte_none_mostly() was false.  So, the condition
> changed from the check in hugetlb_fault until the check (with page table
> lock) in hugetlb_no_page.
> 
> IIUC, the only code that should be modifying the pte in this test is
> hugetlb_mcopy_atomic_pte().  It also holds the hugetlb_fault_mutex while
> updating the pte.
> 
> It 'appears' that hugetlb_fault is not seeing the updated pte and I can
> only guess that it is due to some caching issues.
> 
> After writing the pte in hugetlb_mcopy_atomic_pte() there is this comment.
> 
> 	/* No need to invalidate - it was non-present before */
> 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> 
> I suspect that is true.  However, it seems like this test depends on all
> CPUs seeing the updated pte immediately?
> 
> I added some TLB flushing to hugetlb_mcopy_atomic_pte, but it did not make
> any difference.  Suggestions would be appreciated as cache/tlb/???  flushing
> issues take me a while to figure out.

This morning when I went back and rethink the matter, I just found that the
common hugetlb path handles private anonymous mappings with all empty page
cache as you explained above.  In that sense the two patches I posted may
not really make sense even if they can pass the tests.. and maybe that's
also the reason why the reservations got messed up.  This is also something
I found after I read more on the reservation code e.g. no matter private or
shared hugetlb mappings we only reserve that only number of pages when mmap().

Indeed if with that in mind the UFFDIO_COPY should also work because
hugetlb fault handler checks pte first before page cache, so uffd missing
should still work as expected.

It makes sense especially for hugetlb to do that otherwise there can be
plenty of zero huge pages cached in the page cache.  I'm not sure whether
this is the reason hugetlb does it differently (e.g. comparing to shmem?),
it'll be great if I can get a confirmation.  If it's true please ignore the
two patches I posted.

I think what you analyzed is correct in that the pte shouldn't go away
after being armed once.  One more thing I tried (actually yesterday) was
SIGBUS the process when the write missing event was generated, and I can
see the user stack points to the cmpxchg() of the pthread_mutex_lock().  It
means indeed it moved forward and passed the mutex type check, it also
means it should have seen a !none pte already with at least reading
permission, in that sense it matches with "missing TLB" possibility
experiment mentioned above, because for a missing TLB it should keep
stucking at the read not write.  It's still uncertain why the pte can go
away somehow from under us and why it quickly re-appears according to your
experiment.

-- 
Peter Xu

