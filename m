Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD616E6855
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDRPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDRPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:33:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB32B15464
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=V7/9YRdvpUWFsXQviScvn8PuAX8GmByqNXRyVJ4I/AY=; b=WlAVA2OjOzVTDkW8+aCtJciaho
        lqdKYfqeZAufjQz1Xnq9HPX8lCtz3K6qeOwHwZDp28164W5YJIIOEU4r5LyQPzNSGsvQnPyC1+9Kp
        cD5M3g+r66zzNEDk9Obk63OL/f/UPipC5qzKBQH+R7yqlGbWGdXXtdtULiuoK8kiUHh9kBDo/FD4I
        dgcGkhnDDA6fjnaIFbkzCN1jH820wZAGoGj8ar1Zuzrd4d13bJyMEzMUlcobwvOdv0f+mD3HxyNk9
        Hq1GXLx6PnVqAw9F8wT0PRbyMiCmJkwCjTboFhTGWzkbi9EnmrF0lG+axsPXnVJjt8QMAVB9cnsAk
        tnviWRPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ponJj-00CPTZ-KO; Tue, 18 Apr 2023 15:32:27 +0000
Date:   Tue, 18 Apr 2023 16:32:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD64C3R6BzqpSfYX@casper.infradead.org>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD25bBPbZYSb7grA@x1n>
 <CAJuCfpHf06cr2d277DXQUtBto_0bVgK3ykMHLYRgZXgnot=e4w@mail.gmail.com>
 <ZD61DLJNilUeDCnC@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZD61DLJNilUeDCnC@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:19:40AM -0400, Peter Xu wrote:
> On Mon, Apr 17, 2023 at 03:47:57PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Apr 17, 2023 at 2:26 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
> > > > @@ -5223,8 +5230,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> > > >               if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
> > > >                       mem_cgroup_oom_synchronize(false);
> > > >       }
> > > > -
> > > > -     mm_account_fault(regs, address, flags, ret);
> > > > +out:
> > > > +     mm_account_fault(mm, regs, address, flags, ret);
> > >
> > > Ah, one more question.. can this cached mm race with a destroying mm (just
> > > like the vma race we wanted to avoid)?  Still a question only applies to
> > > COMPLETE case when mmap read lock can be released.  Thanks,
> > 
> > I believe that is impossible because whoever is calling the page fault
> > handler has stabilized the mm by getting a refcount.
> 
> Do you have a hint on where that refcount is taken?

... when we called clone()?  A thread by definition has a reference to
its own mm.

> Btw, it's definitely not a question sololy for this patch but a more common
> question to the page fault path.  It's just that when I wanted to look for
> any refcount boost (which I also expect to have somewhere) I didn't really
> see that in current path (e.g. do_user_addr_fault() for x86_64).
> 
> I also had a quick look on do_exit() but I also didn't see where do we
> e.g. wait for all the threads to stop before recycles a mm.
> 
> I had a feeling that I must have missed something, but just want to make
> sure it's the case.
> 
> -- 
> Peter Xu
> 
