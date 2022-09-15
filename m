Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF105BA060
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIOR1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:27:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5F98D00
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:27:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t3so19020542ply.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2byv70u9LxFyqg2KEOTjIwO2wrYAaSWdRlHkqPRd+W0=;
        b=L8REomJAnSSsKQQzOccREDQKI9QUe7j4kqYbUwlEK63BVvueOkP7HwF3Tg7LnN/LFo
         /EJAwjeIXrHCEfKGogFKKN0yGLPkwTBQnm9MmJGlA1fR1a2sOP3pwqi5j7AEZxerVynj
         n2GoZqNPHjwjRRmK9irk4vWQt+me36EeVoTpY5suYkVKLl8qjhzWR2VmAvcgYG+GHw2V
         dTgyxZGRdRtKxHDMny3JQhLtWvT/1gfQJzuTQqC6Kmpkwg53qGC5Oa9+HxCA29o9lDIq
         hJsZbmL5odvBBr+4xDP0KjoZ8KCmRsCUtVhF7lRUBWk1Nq0L0KpnW5dRkVide/uMppBb
         HYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2byv70u9LxFyqg2KEOTjIwO2wrYAaSWdRlHkqPRd+W0=;
        b=b5j0jclO3VfXA2wNK9kWUKXy0/w9cbU6A2bjY7SifXgJ+2CWtarvh08SMN7hixe18Z
         Fea0ZUykbUXoMeU9XMYmzDsGgnH7le5ijp9XbyjR/xKZAjzTcSGLGnY38yc+siz+pFKO
         NBgX9wmmgkrFhQthblZPSunk1CbZoHmcj+mgsswG6WiWW8lBB2zomIdXWjH68y3JXwAs
         ggBJh1+jOMr99mlH0eS78YYQpPtKVj4vVfFpANzpytrQyZQPiQCNMx688GKS69vTt/2x
         5QQVpof4c6LvpnxSQcFDHvKHM3b0IomOiuAog5sYS4H7wr0Nd9T6CYIjTHK1cu5LGJSy
         8V4g==
X-Gm-Message-State: ACrzQf3cO9cBrP/vT7kJBEKwNKDYm/5VICYHl/lR5tHtNRAXX7T5vO7Q
        sQrthVrbbtJy/XwSnpd7NUl90QFQriu+aMJw8EAzQw==
X-Google-Smtp-Source: AMsMyM6NIYvHuwjX471io4e8+lQbWL/2ToJ7/PZZC2/QexT0xHLfXzLeG5FwGJ2J+L4EXsdAsFPIUSfE6VQunsm8W0Y=
X-Received: by 2002:a17:902:bb97:b0:175:6721:2c34 with SMTP id
 m23-20020a170902bb9700b0017567212c34mr621209pls.146.1663262832597; Thu, 15
 Sep 2022 10:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220909212731.1373355-1-abrestic@rivosinc.com>
 <20220909212731.1373355-2-abrestic@rivosinc.com> <d46d6340-b985-49b2-babb-0082f1759c7b@microchip.com>
In-Reply-To: <d46d6340-b985-49b2-babb-0082f1759c7b@microchip.com>
From:   Andrew Bresticker <abrestic@rivosinc.com>
Date:   Thu, 15 Sep 2022 13:27:01 -0400
Message-ID: <CALE4mHrBC-ni3HunRzxRzM8QJDHb=FuJquccum6OcnB4jZ6KbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Allow PROT_WRITE-only mmap()
To:     Conor.Dooley@microchip.com
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Kumar Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 12:56 PM <Conor.Dooley@microchip.com> wrote:
>
> On 09/09/2022 22:27, Andrew Bresticker wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
> > invalid") made mmap() return EINVAL if PROT_WRITE was set wihtout
> > PROT_READ with the justification that a write-only PTE is considered a
> > reserved PTE permission bit pattern in the privileged spec. This check
> > is unnecessary since we let VM_WRITE imply VM_READ on RISC-V, and it is
> > inconsistent with other architectures that don't support write-only PTEs,
> > creating a potential software portability issue. Just remove the check
> > altogether and let PROT_WRITE imply PROT_READ as is the case on other
> > architectures.
> >
> > Note that this also allows PROT_WRITE|PROT_EXEC mappings which were
> > disallowed prior to the aforementioned commit; PROT_READ is implied in
> > such mappings as well.
> >
> > Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
>
> For the naive members of the audience such as myself, this patch
> came after a non-fixes patch in the series. What is the dependence
> of this patch on the other one (if any)?

This patch is dependent on the first. Happy to re-spin with a "Fixes"
tag on the first patch (or maybe Palmer can add when applying).

-Andrew

> Thanks,
> Conor.
>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > ---
> > v1 -> v2: Update access_error() to account for write-implies-read
> > v2 -> v3: Separate into two commits
> > ---
> >  arch/riscv/kernel/sys_riscv.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> > index 571556bb9261..5d3f2fbeb33c 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -18,9 +18,6 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
> >         if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
> >                 return -EINVAL;
> >
> > -       if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> > -               return -EINVAL;
> > -
> >         return ksys_mmap_pgoff(addr, len, prot, flags, fd,
> >                                offset >> (PAGE_SHIFT - page_shift_offset));
> >  }
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
