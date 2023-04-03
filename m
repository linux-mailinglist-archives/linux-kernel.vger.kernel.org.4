Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05C6D41E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjDCKW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDCKWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:22:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2071FD4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:22:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h9so29796944ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680517334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=96t9GjOEgpXEZ9acE0qRgTs7kWloWEC0J4minDuLaxo=;
        b=aj/faN4PYQkIL9hKnHImtE76LCPU8xKlVAfZ2msVYAfPKX7tYJlpPwRAW0FdlkCHij
         smH7wkgg76UjkaCWfxe2dMeMehRR+VLic1lof0LfgM4cAQPQJXDBvx+bq15OrTT2/SAk
         UM6gxCrxqhdreTZDfjzqswlYk+Rp/Zc8ngn3q0C14q/9F3cifNUe8F0MmDeEDFWdrr6J
         U1Ew3qZyzY5E9Kjdip797uaRAX3UpFSEOBFwWFxXXzNlWoI4soGdgBTbd4xIeprVmD05
         Qf/hSojTQXfhESuqE1MkGqJvr0ftCv72S9weZQhMMGhrrrKwm4b+Dw7LhoEpjiYPVwb3
         2Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96t9GjOEgpXEZ9acE0qRgTs7kWloWEC0J4minDuLaxo=;
        b=A2JZJ5muKE8Xw1ABdXX2EkvYX9Sz8BvcWUuI4WawPsAYAYjZIcxCOlcUVqXGw7Uimv
         AVNUj3RR4jCjFd7+7O6zQ77HYU7jxumQT1qk/Zy+PM9lLCSQz88VCyh44r3l9qENIcvX
         cz65x4amHj4XzlJBWjuUeoUsuAoA+4Ji2kOg7hdK0wQLsGW8QCBEK4hC/KRbMu/7+DVD
         I0YMjjyMwgH7Px7glyJKgqLqneTxOFe6UuySDgn0VUVHfF+Yh6LY+YWIYR/0uqjFD794
         G0L97jjEKXxSPpdXjKWnMafYAXVTcIyMLFXTP2W2xC6nCuoFs2Wt59HJgdJl418ql5fI
         UmCw==
X-Gm-Message-State: AAQBX9fyPuugCTY5wEK/8maeqf2px1E36s82kuhzNjv8W1ffEXWEpBco
        xXiWO7gBITiztxF3V6bCKRwcN4PjurZtQTEyRRbqGQ==
X-Google-Smtp-Source: AKy350bYYOTxXK8oCcjada9AsvBb3DgZ6WBEzQnxTEkBOr+Wt0p9dorCunXBY5zpBbykt71KuPTp+ep6Ka7LtpDEJw0=
X-Received: by 2002:a2e:a0c6:0:b0:298:a7c2:489 with SMTP id
 f6-20020a2ea0c6000000b00298a7c20489mr10896129ljm.8.1680517334457; Mon, 03 Apr
 2023 03:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
 <20230312112612.31869-12-kirill.shutemov@linux.intel.com> <CACT4Y+bnR=v0vUC_wTpd98Kpfd1KK--daPwjgnBL__r+wbHUkw@mail.gmail.com>
 <20230403094419.zl2ncsd4qyd35fex@box> <CACT4Y+Y8ANFPwGd+UALu63mLxWoiiXnp2Z5GXnFhg14DdJUc=A@mail.gmail.com>
 <20230403101707.satsniziz3tn2zyd@box>
In-Reply-To: <20230403101707.satsniziz3tn2zyd@box>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Apr 2023 12:22:01 +0200
Message-ID: <CACT4Y+YfqSMsZArhh25TESmG-U4jO5Hjphz87wKSnTiaw2Wrfw@mail.gmail.com>
Subject: Re: [PATCHv16 11/17] x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 12:17, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Apr 03, 2023 at 11:56:48AM +0200, Dmitry Vyukov wrote:
> > On Mon, 3 Apr 2023 at 11:44, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Mon, Apr 03, 2023 at 08:18:57AM +0200, Dmitry Vyukov wrote:
> > > > Hi Kirill,
> > > >
> > > > ARCH_ENABLE_TAGGED_ADDR checks that task->mm == current->mm,
> > > > shouldn't ARCH_FORCE_TAGGED_SVA check that as well?
> > >
> > > Do you a particular race in mind? I cannot think of anything right away.
> > >
> > > I guess we can add the check for consistency. But if there's a bug it is a
> > > different story.
> >
> > No, I don't have a particular race in mind. Was thinking solely about
> > consistency and if these things should be set for other processes
> > (relaxing the check is always possible in future, but adding new
> > restrictions is generally not possible).
>
> Okay. Makes sense.
>
> It is only reachable with task != current from ptrace, which is rather
> obscure path.
>
> Anyway, I will prepare a proper patch with this fixup:
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index eda826a956df..4ffd8e67d273 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -883,6 +883,8 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>         case ARCH_ENABLE_TAGGED_ADDR:
>                 return prctl_enable_tagged_addr(task->mm, arg2);
>         case ARCH_FORCE_TAGGED_SVA:
> +               if (current != task)
> +                       return -EINVAL;
>                 set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);
>                 return 0;
>         case ARCH_GET_MAX_TAG_BITS:
>
> > > > Also it looks like currently to enable both LAM and SVA.
> > > > LAM enabling checks for SVA, but SVA doesn't and both are not mutually
> > > > exclusive.
> > >
> > > For LAM we check SVM with mm_valid_pasid() && !test_bit() in
> > > prctl_enable_tagged_addr().
> > >
> > > For SVM we check for LAM with !mm_lam_cr3_mask() || test_bit() in
> > > arch_pgtable_dma_compat() which called from iommu_sva_alloc_pasid().
> >
> > It seems that currently it's possible to both enable LAM and set SVA bit.
> > Then arch_pgtable_dma_compat() will return true, but LAM is enabled.
>
> Right. That's the point of the bit. It allows SVA and LAM to co-exist:
>
>     The new ARCH_FORCE_TAGGED_SVA arch_prctl() overrides the limitation.
>     By using the arch_prctl() userspace takes responsibility to never pass
>     tagged address to the device.
>
> I'm confused.

Then I misunderstood what it means. Ignore.

While we are here:

        if (mm_valid_pasid(mm) &&
            !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
                return -EINTR;

should be EINVAL?
