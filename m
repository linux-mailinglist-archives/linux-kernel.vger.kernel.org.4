Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0519C6B5B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCKL3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCKL3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:29:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2604213E530
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:25:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so30785049edy.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112; t=1678533891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2nk19RWJ3FFxQfThP1IJnCcqh4Rha1T966ziWyQOag=;
        b=xoi23uGWoVBMERLqg6d4ZCon4Umfwkx1isVhxM80MHOqn8Gy/MlUGfQG5TYs+Qbl5F
         zjtDXJxxde9ZrMKRmC/0ermLtUdoBz18vmGQMl3i+olvsTcsIJmXFcKyj0dhY2Twdfjj
         Qb8g2LFX6014DGKCz4WX/H6pdnc3Fx2D30jyY1QV93Y8vyuEqSsG5l70wTzyAoJg0d7E
         KpEU+gYQnlC8w1MmJv1GUlHIUvpfe2YDkhekUfubaFPyTSFh4ItLn/ZeA32AwSS82c/s
         1yUs4tAM6L2u2MkMmMlGEeJIVgiZmgRJI5WHjdJ8IidUjizOfyhqdmDEMAFl+CNWND7U
         ZinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2nk19RWJ3FFxQfThP1IJnCcqh4Rha1T966ziWyQOag=;
        b=x5LtnTn87I9jlVx6alTKS6c/DqsLgiHq9tSApbDfgr4iJO1C8VaEXFTTOqKjan1Uiy
         OXpD9E7lnAKr7RwMnr5diUjk2WQN7UhPXKV5HSwmLnOlMVxx+0zzfQBSnDzW2Ml4R6xz
         5Th0r5KGjRxhb5lrRcIZ5ucK5SUiMZcPMQOhJQWQHjoNok+8rZvmN6IPaiehkEhONAN9
         nlrv+PBUSCs0G/0ckTT8fSKCjJ5H39vVwF66WHu/MAwja0tQk6EW3KgcSTvAVlol8ace
         wVk1/gLZFQjDN7N9BqLFRempXvwHQcdIfN6yMzDaZFA27NX/65EbSMWZlyHIG00XgG03
         wEFw==
X-Gm-Message-State: AO0yUKUSLaEj0mWI4DFHykaWP7cEWd/3siROFT4WuyZQkV/0NuoNk1yN
        fwzp9/nFz5KXd+4kj1WylQuHpCySl2Y3Y39SOXWa+g==
X-Google-Smtp-Source: AK7set8a/pblYINKWh29is0KEdgqlAFOzRPVSYLjlA+rojWgWrbyCHnWQa3g8iViKoePj4aeVOWZbZX+sXfjSy8EGPU=
X-Received: by 2002:a17:906:a4b:b0:879:9c05:f5fb with SMTP id
 x11-20020a1709060a4b00b008799c05f5fbmr14921391ejf.5.1678533891185; Sat, 11
 Mar 2023 03:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20230310094539.764357-1-alexghiti@rivosinc.com>
In-Reply-To: <20230310094539.764357-1-alexghiti@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 11 Mar 2023 16:54:39 +0530
Message-ID: <CAAhSdy3K=ANGrfC43zx5XvF6r5p4+ta_UMsdQOjn9SfMYDN=jA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 3:15=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> This patchset intends to improve tlb utilization by using hugepages for
> the linear mapping.
>
> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
> take care of isolating the kernel text and rodata so that they are not
> mapped with a PUD mapping which would then assign wrong permissions to
> the whole region: it is achieved by introducing a new memblock API.
>
> Another patch makes use of this new API in arm64 which used some sort of
> hack to solve this issue: it was built/boot tested successfully.
>
> base-commit-tag: v6.3-rc1
>
> v7:
> - Fix Anup bug report by introducing memblock_isolate_memory which
>   allows us to split the memblock mappings and then avoid to map the
>   the PUD which contains the kernel as read only
> - Add a patch to arm64 to use this newly introduced API
>
> v6:
> - quiet LLVM warning by casting phys_ram_base into an unsigned long
>
> v5:
> - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, thanks
>   Conor
> - Add RB from Andrew
>
> v4:
> - Rebase on top of v6.2-rc3, as noted by Conor
> - Add Acked-by Rob
>
> v3:
> - Change the comment about initrd_start VA conversion so that it fits
>   ARM64 and RISCV64 (and others in the future if needed), as suggested
>   by Rob
>
> v2:
> - Add a comment on why RISCV64 does not need to set initrd_start/end that
>   early in the boot process, as asked by Rob
>
> Alexandre Ghiti (4):
>   riscv: Get rid of riscv_pfn_base variable
>   mm: Introduce memblock_isolate_memory
>   arm64: Make use of memblock_isolate_memory for the linear mapping
>   riscv: Use PUD/P4D/PGD pages for the linear mapping

This works fine on QEMU RV64. I have tested on QEMU RV64 with
busybox and Fedora rootfs. I also tested KVM RV64 which works
fine as well.

But, QEMU RV32 with busybox rootfs is broken so you might want
to try that.

In any case, I have reviewed and tested this series at my end.

Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

>
>  arch/arm64/mm/mmu.c           |  4 ++--
>  arch/riscv/include/asm/page.h | 19 +++++++++++++++--
>  arch/riscv/mm/init.c          | 39 ++++++++++++++++++++++++++---------
>  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++
>  drivers/of/fdt.c              | 11 +++++-----
>  include/linux/memblock.h      |  1 +
>  mm/memblock.c                 | 22 +++++++++++++++++++-
>  7 files changed, 92 insertions(+), 20 deletions(-)
>
> --
> 2.37.2
>
