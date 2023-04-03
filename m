Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FBC6D48BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjDCObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjDCObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:31:15 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF8319AC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:31:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 90381320092B;
        Mon,  3 Apr 2023 10:31:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Apr 2023 10:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680532270; x=
        1680618670; bh=B/Do+b9pnKPWS+TxyE4WQ3cBvHCKsM0Md0bJGMcs1Tg=; b=m
        xRyNbNMS737Q+puOd26TJC0aUjkW+vYMYJO4bqi5XPzV+CibVHguIqAG4O24Rs/l
        thz43eN8HIV7uLg+vzHg2EvQMo9CPLDUFHpsKBByQS07ex8Zq/l0BI/NXIMZWA0L
        k4M7DM7fz8Dt1Ofux60e/KLgTx8KccnIXOjFW8qBk0D7K2gJnT0dUQEmFZ2HkOGB
        dDqjDpU3Mcg8H1uP1eixeDwILA4NUbWF2icMlKl1XJUTbi6f8sCZs/GBEPTS4GuJ
        glhqUpC5vARROT0T3JiaO19YL5s1oJIEJklFdhpGCFrNyCcngQIJx/w7Nf6I4eqE
        Z7scNlOTev1wJA7YTTMZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680532270; x=1680618670; bh=B/Do+b9pnKPWS
        +TxyE4WQ3cBvHCKsM0Md0bJGMcs1Tg=; b=SXtdgnNvFj1sb/H249OpfeD/MGWVN
        F2r9NHuzQMOPspIGrKFWd9UetLv3Tn52Y/pOkC7wBaddnjg9eKHdICUKdYiIInZP
        5guNpxIEoWV3pFE4J50aHyN7syXPPOmifUAU8YkmBzWGp6TYfWh/QtmX/Xigu6V+
        ltGq6QXr6OntWuGm5F1K7Krat1m9oskxvvPLuf8ZL2HpZzkmrK/YxkHzBZdcTd8m
        g+6lvmO1MtVh/ygYs9p/HNtqHdEwvW+59kQhkt+AO6OlUg6N/rkakudX4sVLX4Cw
        7DGj2G1Axl2qT/U2uEz1ddSI8quwwa3YJ2bY//oDpW2hzmhI1/07nZFHg==
X-ME-Sender: <xms:LeMqZN0euFbeJEAZ4wRim1wryBJTWn0jLgOdxWdYuCD04B8FeO2j1A>
    <xme:LeMqZEHO0bkHAKpj78N5hyZMl9iBrAWmTFhwBM6rH0YwfrldOmoqgSCoBbATp-BBB
    Lh8aYid2QRgE3Xg7Ak>
X-ME-Received: <xmr:LeMqZN6P7xZ9hXiasnw2bHzprJFKX09HALseIAwZLJOC8COiLR3lv7t-W863ECEI6SluBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:LeMqZK0hzWjhUj8iEKbRyl5xAkUMihtmj1vdm2vEG72MdX-kAigI4A>
    <xmx:LeMqZAGJWDmf5y1Stw7veuGje0PqAtOR2NSrgxvuLYBoqE-rmBRuFg>
    <xmx:LeMqZL_Xm6Hc72_RQgySFqxDraRcinVhHBp__uz8FfMrVzKyXVrq7g>
    <xmx:LuMqZO_R3txir8lOvYeIbrmt_to3IX0htYn7z2tESyWnEMZ0NpM-XA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 10:31:08 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B136110D7B3; Mon,  3 Apr 2023 17:31:05 +0300 (+03)
Date:   Mon, 3 Apr 2023 17:31:05 +0300
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
Subject: Re: [PATCH 2/2] x86/mm/iommu/sva: Do not allow to set
 FORCE_TAGGED_SVA bit from outside
Message-ID: <20230403143105.rj4l5tqn43t3zcnh@box.shutemov.name>
References: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
 <20230403111020.3136-3-kirill.shutemov@linux.intel.com>
 <CACT4Y+YoS9e=QVq6iKda5Gv852kVv9OTLaOZ=XCJ65mP0oyAOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YoS9e=QVq6iKda5Gv852kVv9OTLaOZ=XCJ65mP0oyAOA@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:55:09PM +0200, Dmitry Vyukov wrote:
> On Mon, 3 Apr 2023 at 13:10, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > arch_prctl(ARCH_FORCE_TAGGED_SVA) overrides the default and allows LAM
> > and SVA to co-exist in the process. It is expected by called by the
> > process when it knows what it is doing.
> >
> > arch_prctl() operates on the current process, but the same code is
> > reachable from ptrace where it can be called on arbitrary task.
> >
> > Make it strict and only allow to set MM_CONTEXT_FORCE_TAGGED_SVA for the
> > current process.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
> > Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > ---
> >  arch/x86/kernel/process_64.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index c7dfd727c9ec..cefac2d3a9f6 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -885,6 +885,8 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
> >         case ARCH_ENABLE_TAGGED_ADDR:
> >                 return prctl_enable_tagged_addr(task->mm, arg2);
> >         case ARCH_FORCE_TAGGED_SVA:
> > +               if (current != task)
> > +                       return -EINVAL;
> 
> prctl_enable_tagged_addr() checks "task->mm != current->mm".
> Should we check the same here for consistency? Or also change the
> check in prctl_enable_tagged_addr().
> 
> arch_prctl() can only do task==current, so I guess "current != task"
> is a more reasonable check for prctl_enable_tagged_addr() as well.

As of now, prctl_enable_tagged_addr() doesn't have the task on hands. It
gets mm as input, so it cannot check the task directly. But functionally
it is the same check.

I would prefer to keep it this way. Unless anyone feels strongly about it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
