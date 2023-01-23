Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61E86779F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjAWLRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjAWLRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:17:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154FA5D1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:17:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so8271249wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gWL+Pk8xqNJgEc/BiJaFQTjPu8aNsaT1rJQ4ElXFDM=;
        b=fNRC8Ij8xgy1/7RLSZZ03wsQBLesqDAbx9k+SCARCiyPDwsLsK/u3bVOpgvRcWTg9+
         85LVUnNf7Sb6UEd92O9OchScZvPhA6Z5b9s6VN1iQ1vjgE9G3McqrYlnW8Bks0u0reGx
         DCgTDfD6FN+pLnNev9MEhTKUsKqAFEA+JcJQOuXZ1m6opU1B4+54Vv58WWTd/dDKxdzM
         HTx9bYJgL41lPM4VZWJiecVhaZ3LcIHVq79Y3jaIPGmlxGHu3fp5foX3mvKWSXF6ESfv
         vY6Phh1epb8DrQ7H3Pk5UE1KYmG3/pP84SMUPCgaOBPQZvSUmcJ8jDsbWbr8eTfciHZ2
         YVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gWL+Pk8xqNJgEc/BiJaFQTjPu8aNsaT1rJQ4ElXFDM=;
        b=ie/1YULTcAy4sgkAb2UFp1/Ji0TDpHnscmhbCXfg23p4Nozfgug7jy3bbFBdyyrutL
         FP+n1mwTcE73dT0+i+Zn54XbzgYlvDF9zWUv3+88jYho5veoU9DAJEyl5z+4X5UazQJ0
         ChwDSUEzHD5zJBLa5QnL98ZnLrQjbBclL61gdgWpb8E91nCFi1GqRpskR8EEr5PhnL+I
         v7AXZxIB2NS9l1O5vwzzVpc/aAzjrFFBIy2MyIAkDigiT7R4iHSczfgC3hut2MNP2yXR
         gdy7vBxMqhfJzzuGZVhJTmu7VO3XIdWWXpWT30VTN4UczeZ22DlH0V9Dl2yORh9yjokG
         KLOA==
X-Gm-Message-State: AFqh2krkMmqiasnTrfymq7eUzUsFODgakXrXjM4IApfG1/lWgS0bht3l
        kb7eagg1tam59KUruzsaU7V9nXRLky7G0pKvLQxmsg==
X-Google-Smtp-Source: AMrXdXsE7/eis0AnNqg/Sw3AyuZ8/Z3AXvka/LcYo62OTdPK9H6JiGtJJs5MGNiibrB3AxRcoFw8AhQdrPUqPiaPwC0=
X-Received: by 2002:a7b:c4d0:0:b0:3db:459:5847 with SMTP id
 g16-20020a7bc4d0000000b003db04595847mr1328861wmk.5.1674472621696; Mon, 23 Jan
 2023 03:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20230123092928.808014-1-alexghiti@rivosinc.com> <20230123110337.3pmsk7nvip3sxlc4@orel>
In-Reply-To: <20230123110337.3pmsk7nvip3sxlc4@orel>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 23 Jan 2023 12:16:50 +0100
Message-ID: <CAHVXubg+1zi2p=XFX_TYx6S=yNdQPa_u0CLZnjOWSG_Drrao8A@mail.gmail.com>
Subject: Re: [PATCH] KVM: RISC-V: Fix wrong usage of PGDIR_SIZE to check page sizes
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:03 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Mon, Jan 23, 2023 at 10:29:28AM +0100, Alexandre Ghiti wrote:
> > At the moment, riscv only supports PMD and PUD hugepages. For sv39,
> > PGDIR_SIZE == PUD_SIZE but not for sv48 and sv57. So fix this by changing
> > PGDIR_SIZE into PUD_SIZE.
>
> Can you please add a sentence as to how you found this? Some test case
> or just by analysis?

Just by reading the code! That made me think that we can have more
hugepages for riscv since the introduction of sv48 and sv57, I'll send
this patch later.

>
> Anyway,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,

Alex

>
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/kvm/mmu.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index 34b57e0be2ef..dbc4ca060174 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -585,7 +585,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> >       if (!kvm->arch.pgd)
> >               return false;
> >
> > -     WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PGDIR_SIZE);
> > +     WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
> >
> >       if (!gstage_get_leaf_entry(kvm, range->start << PAGE_SHIFT,
> >                                  &ptep, &ptep_level))
> > @@ -603,7 +603,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> >       if (!kvm->arch.pgd)
> >               return false;
> >
> > -     WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PGDIR_SIZE);
> > +     WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
> >
> >       if (!gstage_get_leaf_entry(kvm, range->start << PAGE_SHIFT,
> >                                  &ptep, &ptep_level))
> > @@ -645,12 +645,12 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
> >       if (logging || (vma->vm_flags & VM_PFNMAP))
> >               vma_pagesize = PAGE_SIZE;
> >
> > -     if (vma_pagesize == PMD_SIZE || vma_pagesize == PGDIR_SIZE)
> > +     if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
> >               gfn = (gpa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
> >
> >       mmap_read_unlock(current->mm);
> >
> > -     if (vma_pagesize != PGDIR_SIZE &&
> > +     if (vma_pagesize != PUD_SIZE &&
> >           vma_pagesize != PMD_SIZE &&
> >           vma_pagesize != PAGE_SIZE) {
> >               kvm_err("Invalid VMA page size 0x%lx\n", vma_pagesize);
> > --
> > 2.37.2
> >
> >
> > --
> > kvm-riscv mailing list
> > kvm-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kvm-riscv
