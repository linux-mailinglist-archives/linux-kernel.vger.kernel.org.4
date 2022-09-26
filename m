Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3928B5E9714
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 02:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiIZALT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 20:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiIZALQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 20:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C95255B7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664151074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aK8oEr6Mo1r3LJjWh8qC8wg2ZbpaqIAd/c7oyUSXWrA=;
        b=HBO5wigpGSysqqI0rymLm575OWBCjrOvz564lZ39clHiZMXzofzNPG+XwIfDxtGp8fUF/Q
        JDbJvkmgUk6w/RZVVylgQ/gyhanf/mvoJOgJ0+OcppRqq3VvSRIJvfo1+FDr2GkzcF+ymJ
        5ZW9Uy0SEFgMJjcWj9787ADDVf+ZFNU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-ea2bLH5TMSWJcBzj6AqynQ-1; Sun, 25 Sep 2022 20:11:12 -0400
X-MC-Unique: ea2bLH5TMSWJcBzj6AqynQ-1
Received: by mail-qk1-f198.google.com with SMTP id u20-20020a05620a455400b006ce5151968dso3896598qkp.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 17:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aK8oEr6Mo1r3LJjWh8qC8wg2ZbpaqIAd/c7oyUSXWrA=;
        b=HnjdepJh5pMPwIKvIbqFxGxnIKa3JCnzifeBxQBVAU+31660PkiCohxiM8BWzy6npK
         10SYN4EASnfBeFPd07CrewAGOh9DjmKiVerOOZDej++R1W2VKrOnJHp3kgWPP72HdtJi
         rjy/ggqC0RcAC7HkriBM3/AFpSklbg7/2Jjhddh+UjfIaMsxPFW7UFXX3V9/qpoZUDy+
         IeAdGw1Cbo6fT+mf8wQHFQARsTmSgKZBGE4y+fyxBkQ5aLicq9MMoZDrPatrcMmqUucM
         mXAeYTmjVDYlPqrILMCWLpewCVyRXzWK35x3xP34CTE7Q89jrNL+UFdUfxB0boEhCZur
         wfAQ==
X-Gm-Message-State: ACrzQf2h+SO4ybMK4TNtE0P/wzgXBaq8qjdsvnl8YcUex+DVjap4RLKq
        IwpXnhTAm3ajuW3TCF5jy05J0AvdNs8DDXlMljYBTfw3lhv5ig8b8UyeEOM6Iz47cXWn6Vz5PzJ
        2hFS03SXjwf7iUt4X0mpQq3Sx
X-Received: by 2002:a0c:a9d5:0:b0:4a6:3ec0:74ba with SMTP id c21-20020a0ca9d5000000b004a63ec074bamr15496721qvb.31.1664151071932;
        Sun, 25 Sep 2022 17:11:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43SNkGk46w9cMJaZj4k1tISHBtvYVuTHN92lm9iGTPf61F+K085X1BBI2xtFUatWbkHwjQCA==
X-Received: by 2002:a0c:a9d5:0:b0:4a6:3ec0:74ba with SMTP id c21-20020a0ca9d5000000b004a63ec074bamr15496698qvb.31.1664151071664;
        Sun, 25 Sep 2022 17:11:11 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bi16-20020a05620a319000b006b58d8f6181sm10636112qkb.72.2022.09.25.17.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 17:11:11 -0700 (PDT)
Date:   Sun, 25 Sep 2022 20:11:09 -0400
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
Message-ID: <YzDuHbuo2x/b2Mbr@x1n>
References: <0000000000006c300705e95a59db@google.com>
 <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
 <Yy5WHvioerD2Sev1@x1n>
 <Yy8dBrmvDmqlsRXE@x1n>
 <Yy9T/JmVb4ymf6WM@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy9T/JmVb4ymf6WM@monkey>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 12:01:16PM -0700, Mike Kravetz wrote:
> On 09/24/22 11:06, Peter Xu wrote:
> > 
> > Sorry I forgot to reply on this one.
> > 
> > I didn't try linux-next, but I can easily reproduce this with mm-unstable
> > already, and I verified that Hugh's patch fixes the problem for shmem.
> > 
> > When I was testing I found hugetlb selftest is broken too but with some
> > other errors:
> > 
> > $ sudo ./userfaultfd hugetlb 100 10  
> > ...
> > bounces: 6, mode: racing ver read, ERROR: unexpected write fault (errno=0, line=779)
> > 
> > The failing check was making sure all MISSING events are not triggered by
> > writes, but frankly I don't really know why it's required, and that check
> > existed since the 1st commit when test was introduced.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c47174fc362a089b1125174258e53ef4a69ce6b8
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/vm/userfaultfd.c?id=c47174fc362a089b1125174258e53ef4a69ce6b8#n291
> > 
> > And obviously some recent hugetlb-related change caused that to happen.
> > 
> > Dropping that check can definitely work, but I'll have a closer look soon
> > too to make sure I didn't miss something.  Mike, please also let me know if
> > you are aware of this problem.
> > 
> 
> Peter, I am not aware of this problem.  I really should make running ALL
> hugetlb tests part of my regular routine.
> 
> If you do not beat me to it, I will take a look in the next few days.

Just to update - my bisection points to 00cdec99f3eb ("hugetlbfs: revert
use i_mmap_rwsem to address page fault/truncate race", 2022-09-21).

I don't understand how they are related so far, though.  It should be a
timing thing because the failure cannot be reproduced on a VM but only on
the host, and it can also pass sometimes even on the host but rarely.

Logically all the uffd messages in the stress test should be generated by
the locking thread, upon:

		pthread_mutex_lock(area_mutex(area_dst, page_nr));

I thought a common scheme for lock() fast path should already be an
userspace cmpxchg() and that should be a write fault already.

For example, I did some stupid hack on the test and I can trigger the write
check fault with anonymous easily with an explicit cmpxchg on byte offset 128:

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 74babdbc02e5..a7d6938d4553 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -637,6 +637,10 @@ static void *locking_thread(void *arg)
                } else
                        page_nr += 1;
                page_nr %= nr_pages;
+               char *ptr = area_dst + (page_nr * page_size) + 128;
+               char _old = 0, new = 1;
+               (void)__atomic_compare_exchange_n(ptr, &_old, new, false,
+                               __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);
                pthread_mutex_lock(area_mutex(area_dst, page_nr));
                count = *area_count(area_dst, page_nr);
                if (count != count_verify[page_nr])

I'll need some more time thinking about it before I send a patch to drop
the write check..

Thanks,

-- 
Peter Xu

