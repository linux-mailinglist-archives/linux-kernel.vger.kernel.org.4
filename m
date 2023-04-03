Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABC86D41B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjDCKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjDCKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:17:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7565BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:17:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F9B05C0112;
        Mon,  3 Apr 2023 06:17:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Apr 2023 06:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680517030; x=
        1680603430; bh=2X6kQY81kFbB9dD0hTeXUDO4hec/j/TMwLdo/emFpoY=; b=P
        WLLBsRKU3t6HU9mytrKeBmCsce7DZbXrEbUsP1XSyJocFnMliyjsW7SnrhRtB3kl
        +RJdXf/OUH3loUP8GtoUzEdn8h13+Z1I8baYYOlMCYxEkS4QPyOMLmxTj6LEGAnF
        5YYGdEHZuvr5A3KK8ytIT4Boh+rVNJh9JPHPOClTSxeGPVe5uVCDLTajqhyPloGD
        nXy5uM8s0Fk/ZAJygBi2nOUhzQywjq4nxF8r+uCreRnXr6Rv4MInRqnRJiexhDc6
        WRxWESBdAwFiwR1sTDoRBlQasm0pg8dyGb9dObhQOE5CB6lAS6lexRTnVKEw7FnS
        aPGS1IXrkrK8UuKUuNWKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680517030; x=1680603430; bh=2X6kQY81kFbB9
        dD0hTeXUDO4hec/j/TMwLdo/emFpoY=; b=GCn6alqfL8Z3dAUqoE+HVZPwtPvs+
        xXfC3DT4YTTh2NGlc5tZn2Gh59F7uch966MlUSKIvMuv54SN5DF/vIawhnY6C4oa
        tBxWQmvyduZr9B/Co0hJNkSoxABDXJcvOKyr9koR+oanupXr0IgpOlgGDsY7Ggh/
        HUbF9XwzXxj6hOiFqZJ/1s1fSzrXjwA5w1eub8WyR9aDet1wV3mCIhR4kMfaGYPF
        NYMjdxHBoK9A+mZ+QLLQUlOM0zUi69grpoEMrsVaDBn+qipctRjR9IgX5CdgwLuq
        Xq4n/k9r/vATx1HCCHwpR0ZLGY9lpFUNWAoDtomW9av+UOt5zPM1EZvNQ==
X-ME-Sender: <xms:pacqZDuSeJkiesNUzHZxIbrkpQcwun-F_bLC7kk9nBls3i0UxvpX0A>
    <xme:pacqZEdhEezYlAygcVUpo6rE2_vk_-38HeFIhtP6kGqfpeTD1B78SL9IqwG0JviGa
    bFX3Vc4tr4OQ2uKP5Q>
X-ME-Received: <xmr:pacqZGyNoFfRo6jhZywe86VmgDJP82F1giSvTBKk9ZCnvFC3_gMPuKrpsY0xgZtRNb30lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:pacqZCOr3trmdqYTZRkyQ3LFU_ZCyTfHix9zsFUI0O_Hm2Qtg5L2PA>
    <xmx:pacqZD8UGJlRbG9d4xRX8Dm0wg2fix8ZTr951QggOPOVQ-glCXmIog>
    <xmx:pacqZCXVa54JlR0TMojwfDMEH2gya4AqAaPf6bHPPWTz2ujuvPspzA>
    <xmx:pqcqZG2CoJ5c8OO9LqxUeCpSbZLDfUTYKaQFaP-cfJhuIotglk41Tg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 06:17:09 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C0E9010D7B3; Mon,  3 Apr 2023 13:17:07 +0300 (+03)
Date:   Mon, 3 Apr 2023 13:17:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv16 11/17] x86/mm/iommu/sva: Make LAM and SVA mutually
 exclusive
Message-ID: <20230403101707.satsniziz3tn2zyd@box>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
 <20230312112612.31869-12-kirill.shutemov@linux.intel.com>
 <CACT4Y+bnR=v0vUC_wTpd98Kpfd1KK--daPwjgnBL__r+wbHUkw@mail.gmail.com>
 <20230403094419.zl2ncsd4qyd35fex@box>
 <CACT4Y+Y8ANFPwGd+UALu63mLxWoiiXnp2Z5GXnFhg14DdJUc=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y8ANFPwGd+UALu63mLxWoiiXnp2Z5GXnFhg14DdJUc=A@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:56:48AM +0200, Dmitry Vyukov wrote:
> On Mon, 3 Apr 2023 at 11:44, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Mon, Apr 03, 2023 at 08:18:57AM +0200, Dmitry Vyukov wrote:
> > > Hi Kirill,
> > >
> > > ARCH_ENABLE_TAGGED_ADDR checks that task->mm == current->mm,
> > > shouldn't ARCH_FORCE_TAGGED_SVA check that as well?
> >
> > Do you a particular race in mind? I cannot think of anything right away.
> >
> > I guess we can add the check for consistency. But if there's a bug it is a
> > different story.
> 
> No, I don't have a particular race in mind. Was thinking solely about
> consistency and if these things should be set for other processes
> (relaxing the check is always possible in future, but adding new
> restrictions is generally not possible).

Okay. Makes sense.

It is only reachable with task != current from ptrace, which is rather
obscure path.

Anyway, I will prepare a proper patch with this fixup:

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index eda826a956df..4ffd8e67d273 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -883,6 +883,8 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
 	case ARCH_FORCE_TAGGED_SVA:
+		if (current != task)
+			return -EINVAL;
 		set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);
 		return 0;
 	case ARCH_GET_MAX_TAG_BITS:

> > > Also it looks like currently to enable both LAM and SVA.
> > > LAM enabling checks for SVA, but SVA doesn't and both are not mutually
> > > exclusive.
> >
> > For LAM we check SVM with mm_valid_pasid() && !test_bit() in
> > prctl_enable_tagged_addr().
> >
> > For SVM we check for LAM with !mm_lam_cr3_mask() || test_bit() in
> > arch_pgtable_dma_compat() which called from iommu_sva_alloc_pasid().
> 
> It seems that currently it's possible to both enable LAM and set SVA bit.
> Then arch_pgtable_dma_compat() will return true, but LAM is enabled.

Right. That's the point of the bit. It allows SVA and LAM to co-exist:

    The new ARCH_FORCE_TAGGED_SVA arch_prctl() overrides the limitation.
    By using the arch_prctl() userspace takes responsibility to never pass
    tagged address to the device.

I'm confused.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
