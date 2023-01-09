Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92A466317F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbjAIUau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbjAIUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:30:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81A5F4A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:30:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673296243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+IF8N6gr4ASA6KlC0wAS2TTWdvbe6Fi/eF6ehclurk=;
        b=OWUdahdwuiLP+qCfcClBwFXOKfKnnboO8fOQSCgB7RiIP+nyuOLQHTaGUSKUC2pQbKXmRf
        UQ01UgeHpf0LAQYx1mDuAAkUMMidHGcVxA5qIahVxjCNOLBUOU9b0blwSoSCk4R2cPeiP7
        j6EcYPqfp//NbjW82QYVQ0SzvcrLTPtRQByjWWZwXoOhiIBfyaGXvipF1pGxME2cUjIthx
        vda6G0eKixiQ4o6xNbMVHAsUa7lPZt/nAFeBiwTROQnXTZBMWFOM2VZsSZU900rNV0cPui
        qUZAZmnFC8V/cV2lIZllJt6858jOTv1st0Xxk1o4qx7JWugVSpBabsce6twb0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673296243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+IF8N6gr4ASA6KlC0wAS2TTWdvbe6Fi/eF6ehclurk=;
        b=VzjuE1k1onSQnrZB7It7LxpHgFdKNaJ1kTi/mBvzn6a2jfu0bI1gaDJhcJsjLg/edLAonW
        YFDcNEj3PuTG/NCA==
To:     Jacky Li <jackyli@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jacky Li <jackyli@google.com>
Subject: Re: [PATCH] x86/mm/cpa: get rid of the cpa lock
In-Reply-To: <20221222013330.831474-1-jackyli@google.com>
References: <20221222013330.831474-1-jackyli@google.com>
Date:   Mon, 09 Jan 2023 21:30:42 +0100
Message-ID: <87y1qbjvrh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacky!

On Thu, Dec 22 2022 at 01:33, Jacky Li wrote:
> This RFC is to solicit feedback on how to remove/disable the CPA lock
> for modern x86 CPUs. We suspect it can be removed for older x86 CPUs
> as well per the third bullet in our full reasoning below. However,
> offlist discussion at LPC suggested that doing so could be too risky
> because it is hard to test these changes on very old CPUs.

Definitely so.

> The cpa_lock was introduced in commit ad5ca55f6bdb ("x86, cpa: srlz
> cpa(), global flush tlb after splitting big page and before doing cpa")
> to solve a race condition where one cpu is splitting a large
> page entry along with changing the attribute, while another cpu with
> stale large tlb entries is also changing the page attributes.
>
> There are 3 reasons to remove/modify this cpa_lock today.
>
> First, this cpa_lock is inefficient because it=E2=80=99s a global spin lo=
ck.
> It only protects the race condition when multiple threads are
> modifying the same large page entry while preventing all
> parallelization when threads are updating different 4K page entries,
> which is much more common.

It does not matter whether a particular operation is common or not,
really. Either the lock is required for protection or not.

> Second, as stated in arch/x86/include/asm/set_memory.h,
> 	"the API does not provide exclusion between various callers -
> 	including callers that operation on other mappings of the same
> 	physical page."
>
> the caller should handle the race condition where two threads are
> modifying the same page entry.

The API deals with memory ranges and of course is the caller responsible
that there are no two concurrent calls to change the same memory range.

But the caller is completely oblivious about large pages. That's an
internal implementation detail of the CPA code and that code is
responsible for serialization of large page splits and the resulting
subtleties.

Assume:
  BASEADDR     is covered by a large TLB

  CPU 0                              CPU 1
  cpa(BASEADDR, PAGE_SIZE, protA);   cpa(BASEADDR+PAGE_SIZE, PAGE_SIZE, pro=
tB);

is completely correct from an API usage point of view, no?

> The API should only handle it when this race condition can crash the
> kernel, which might have been true back in 2008 because the commit

Might have been true? The crashes were real.

> cover letter mentioned
> 	"If the two translations differ with respect to page frame or
> 	attributes (e.g., permissions), processor behavior is
> 	undefined and may be implementation specific. The processor
> 	may use a page frame or attributes that correspond to neither
> 	translation;"
> However it=E2=80=99s no longer true today per Intel's spec [1]:
> 	"the TLBs may subsequently contain multiple translations for
> 	the address range (one for each page size). A reference to a
> 	linear address in the address range may use any of these
> 	translations."

That's a partial quote. The full sentence is:

 "If software modifies the paging structures so that the page size used
  for a 4-KByte range of linear addresses changes, the TLBs may
  subsequently contain multiple translations for the address range (one
  for each page size).  A reference to a linear address in the address
  range may use any of these translations. Which translation is used may
  vary from one execution to another, and the choice may be
  implementation-specific."

The important part is the first part of the first sentence, which only
talks about changing the page size used, but does not talk about
changing attributes in a conflicting way. The latter is the real issue
which was addressed back then if my memory does not trick me.

It's still today a real issue with certain PAT combinations.

> Third, even though it=E2=80=99s possible in old hardware that this race
> condition can crash the kernel, this specific race condition that
> cpa_lock was trying to protect when introduced in 2008 has already
> been protected by pgd_lock today, thanks to the commit c0a759abf5a6
> ("x86/mm/cpa: Move flush_tlb_all()") in 2018 that moves the
> flush_tlb_all() from outside pgd_lock to inside. Therefore today when
> one cpu is splitting the large page and changing attributes, the other
> cpu will need to wait until the global tlb flush is done and pgd_lock
> gets released, and after that there won=E2=80=99t be stale large tlb entr=
ies
> to change within this cpu. (I did a talk in LPC [2] that has a pseudo
> code explaining why the race condition is protected by pgd_lock today)

A link to a video is not replacing a coherent written explanation why a
change is correct. Changelogs have to be self contained and fully
explanatory.

I agree that there is no issue vs. two CPUs trying to split the same
large page concurrently. They are properly serialized by pgd_lock, but
there are other scenarios too:

BASEADDR     is covered by a large TLB

CPU 0                              CPU 1

cpa(BASEADDR, PAGE_SIZE, protA)

  observes large TLB
  split_large_page()
    spin_lock(pgd_lock);
      __set_pmd_pte(...);

                                  cpa(BASEADDR + PAGE_SIZE, PAGE_SIZE, prot=
B)
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
                                     observes 4k PTE in lookup_addr_cpa()
                                     and proceeds
      flush_tlb_all();

Today this is fully serialized via cpa_lock and CPU1 cannot proceed
before the split is complete (including the flush), so this needs a
proper explanation too.

Thanks,

        tglx
