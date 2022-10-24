Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DFE609BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJXIBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJXIBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:01:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D222CDDC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l5qKvhavZx+90o//wOAFONhmBRPvXuSs33csSD8GNO0=; b=Hfi1g4KfxoMrGAenW2Aq+E1l2T
        bIoyoZOoqQofaNffwV2MwMYfxk+Bb0xmOnwb9drQ+k6OXnJTtj1+6rFq4S16MdgRA6xyfh3gBXGT2
        oJ0XMj1glFg2fbuDPPIS2Wm+S5B59z8kjS/7Oc9AGbw4k+KpQt22AZUxcuTfZQwcFtFBu5DPe2WZT
        Sxdgi5x6HyUVUPMXr6s9mMUleBBnot2dKrjP+uNEz3Licp39icKeQTruZfMQwk2DGDTCVDuVZVLNk
        fG6TaWUNSpheVdc8xmPLmz0uNm7zHs1cdnHixnD/F1NPA3do4K4SPf6rB5d8R+KLoSuvgvFn9yv9V
        NmxdNLsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omsOG-0060ii-Tq; Mon, 24 Oct 2022 08:00:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0359130017D;
        Mon, 24 Oct 2022 10:00:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA95F2C2328B2; Mon, 24 Oct 2022 10:00:55 +0200 (CEST)
Date:   Mon, 24 Oct 2022 10:00:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 10:42:49PM -0700, John Hubbard wrote:
> On 10/22/22 04:14, Peter Zijlstra wrote:
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -260,15 +260,12 @@ static inline pte_t ptep_get(pte_t *ptep
> >  
> >  #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
> >  /*
> > - * WARNING: only to be used in the get_user_pages_fast() implementation.
> > - *
> > - * With get_user_pages_fast(), we walk down the pagetables without taking any
> > - * locks.  For this we would like to load the pointers atomically, but sometimes
> > - * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
> > - * we do have is the guarantee that a PTE will only either go from not present
> > - * to present, or present to not present or both -- it will not switch to a
> > - * completely different present page without a TLB flush in between; something
> > - * that we are blocking by holding interrupts off.
> > + * For walking the pagetables without holding any locks.  Some architectures
> > + * (eg x86-32 PAE) cannot load the entries atomically without using expensive
> > + * instructions.  We are guaranteed that a PTE will only either go from not
> > + * present to present, or present to not present -- it will not switch to a
> > + * completely different present page without a TLB flush inbetween; which we
> > + * are blocking by holding interrupts off.
> 
> 
> This is getting interesting. My latest understanding of this story is
> that both the "before" and "after" versions of that comment are
> incorrect! Because, as Jann Horn noticed recently [1], there might not
> be any IPIs involved in a TLB flush, if x86 is running under a
> hypervisor, and that breaks the chain of reasoning here.

That mail doesn't really include enough detail. The way x86 HV TLB
flushing is supposed to work is by making use of
MMU_GATHER_RCU_TABLE_FREE. Specifically, something like:


	vCPU0				vCPU1

					tlb_gather_mmut(&tlb, mm);

					....

	local_irq_disable();
	... starts page-table walk ...

	<schedules out; sets KVM_VCPU_PREEMPTED>

					tlb_finish_mmu(&tlb)
					  ...
					  kvm_flush_tlb_multi()
					    if (state & KVM_VCPU_PREEMPTED)
					      if (try_cmpxchg(,&state, state | KVM_VCPU_FLUSH_TLB))
						__cpumask_clear_cpu(cpu, flushmask);


					  tlb_remove_table_sync_one() / call_rcu()


	<schedules back in>

	... continues page-table walk ...
	local_irq_enable();

If mmu gather is forced into tlb_remove_talbe_sync_one() (by memory
pressure), then you've got your IPI back, otherwise it does call_rcu()
and RCU itself will need vCPU0 to enable IRQs in order to make progress.

Either way around, the actual freeing of the pages is delayed until the
page-table walk is finished.

What am I missing?
