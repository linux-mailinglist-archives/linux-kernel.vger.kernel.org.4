Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B8E678662
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjAWTbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjAWTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:31:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B9A254
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m/podwHds7JxQLCbcR8/xZsYC7Zym4+9Li/7t1BsGAU=; b=EzNI5XQFHCKDI4RmxwK5H85qS0
        6UAEG1u2YhqEZ87tlBlzCqJnVMUhWcWNWEIKOR/n5FWz2FECNBJSBX0T8LiwDOfVkvDYHlmiaPbxA
        4I/NbsDKV69v/QZwp9chVKa6zvOlWvAcU51xz5THZAKzOW/kh/weKydSwnigbjDrrWctKg42H6QPk
        b1fzz6huv7hyG/nqC1cXlZD4V7JGafLOwoac5ND3ZEtCCpvvv3o0wmwA1NBTWfWCQfT97un1xUw+c
        wkk8l8Ds+GtkptnTWKsm5oeLn7+gHZ3CXmNzIXOxvw9rV/pPUz82oqXeKmYZVB9H5pLDaFgnSfOVz
        eCAQhGqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK2Wh-004TK7-Jr; Mon, 23 Jan 2023 19:30:43 +0000
Date:   Mon, 23 Jan 2023 19:30:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in
 vm_area_free
Message-ID: <Y87gY7fhi5OJ35WQ@casper.infradead.org>
References: <Y8rQNj5dVyuxRBOf@casper.infradead.org>
 <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz>
 <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
 <Y868Fadajv27QMXh@dhcp22.suse.cz>
 <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
 <Y87A2CEKAugfgfHC@dhcp22.suse.cz>
 <CAJuCfpGJRZATfc8eUurvV5kGkSNkG=vK=sfwJbU72PESOyATSw@mail.gmail.com>
 <Y87QjHH2aDG5XCGv@casper.infradead.org>
 <Y87djZwQpXazRd00@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87djZwQpXazRd00@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 08:18:37PM +0100, Michal Hocko wrote:
> On Mon 23-01-23 18:23:08, Matthew Wilcox wrote:
> > On Mon, Jan 23, 2023 at 09:46:20AM -0800, Suren Baghdasaryan wrote:
> [...]
> > > Yes, batching the vmas into a list and draining it in remove_mt() and
> > > exit_mmap() as you suggested makes sense to me and is quite simple.
> > > Let's do that if nobody has objections.
> > 
> > I object.  We *know* nobody has a reference to any of the VMAs because
> > you have to have a refcount on the mm before you can get a reference
> > to a VMA.  If Michal is saying that somebody could do:
> > 
> > 	mmget(mm);
> > 	vma = find_vma(mm);
> > 	lock_vma(vma);
> > 	mmput(mm);
> > 	vma->a = b;
> > 	unlock_vma(mm, vma);
> > 
> > then that's something we'd catch in review -- you obviously can't use
> > the mm after you've dropped your reference to it.
> 
> I am not claiming this is possible now. I do not think we want to have
> something like that in the future either but that is really hard to
> envision. I am claiming that it is subtle and potentially error prone to
> have two different ways of mass vma freeing wrt. locking. Also, don't we
> have a very similar situation during last munmaps?

We shouldn't have two ways of mass VMA freeing.  Nobody's suggesting that.
There are two cases; there's munmap(), which typically frees a single
VMA (yes, theoretically, you can free hundreds of VMAs with a single
call which spans multiple VMAs, but in practice that doesn't happen),
and there's exit_mmap() which happens on exec() and exit().

For the munmap() case, just RCU-free each one individually.  For the
exit_mmap() case, there's no need to use RCU because nobody should still
have a VMA pointer after calling mmdrop() [1]

[1] Sorry, the above example should have been mmgrab()/mmdrop(), not
mmget()/mmput(); you're not allowed to look at the VMA list with an
mmget(), you need to have grabbed.
