Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD856CA31C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjC0MNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjC0MNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:13:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4248E3A90
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:13:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so35323413edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112; t=1679919189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmNpIzNfG612nyW1bhVMjBSrVg7n0oMr5DFwLjMDXpE=;
        b=cDuZhRwmRdhUa9PzYQnOCAO7avYp1p9ucMyD4vRrNtYqFQH5bgn8DVtNCyN8Qj4VvK
         Asm62i1lbAsqclKyYuS3dfTXUyh00QL2T/stsE3b2Sx0N8SRs+tJ9SGS+Vd2KbNV0AkX
         hw5CANHrzIrrTa3/Xs5D/jhnTJGcP6yRjgC43pz3p7TszeSxD3bfSJhV3+0o/n8EwzHe
         RWrKtvOzwdR4bheDoXFRJzlxwxj0jRwFB5NOdkOOcyb/PW3p7Q9XAVObF8UjkAq4VFBQ
         8Qjv9GhEUT9yAZav3rQsZ81tg86EZG2r/2oPfCWa6/I27FUSJkIxRD8AekAxurhA0GDL
         dYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679919189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmNpIzNfG612nyW1bhVMjBSrVg7n0oMr5DFwLjMDXpE=;
        b=FPcvApAezE2EpoCUStKMlsXixkreAUy1jsafANM2JORAIN5NjxaY1XYKm2N8uAuZvA
         tziLn4ZbJofjPPsNqGdlo2TXDnB3ES+SyZLV5/09XuzakyiYYEhyEYos1S6SU4zaC9cl
         55X9qTgJlPMSL6Mg+Zulyt+bqK0ZssAn80D4J4ANnhIbMKertsU5bzbwVVBfBZ3zh2Ad
         WkImgEKVD4d34iIubSSYKrGQyb3WEFQ3TYxF1yIV4p9ZJ9vnbuFR2eD/8lGSwoXewi8O
         MTvi5EHo3gqv7QEfzHAUTm3lzYLTMwSmW7QrVGdvUz403uvXzrpjzFfV4KMQGvNFlyVE
         Xpzw==
X-Gm-Message-State: AAQBX9eH1a6BsE91b3l5cJpJ6Iqirq+n4uVJ5vmbu55b88xeSXoRioQS
        en3sQ5l+yDKu0h/wfhT5oj0bfUjPL5NWzMFsQQINqg==
X-Google-Smtp-Source: AKy350bq3aqC/oOrLVqEUOhMcf2gp9/VAl1K+i1eN1DDWpJ/F20bJSOj2ABZt74p8o9I/6yRHACDjsmJwyg3dDlkhfc=
X-Received: by 2002:a50:bac5:0:b0:4ab:49b9:686d with SMTP id
 x63-20020a50bac5000000b004ab49b9686dmr5596204ede.1.1679919188663; Mon, 27 Mar
 2023 05:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
In-Reply-To: <20230324155421.271544-1-alexghiti@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 27 Mar 2023 17:42:57 +0530
Message-ID: <CAAhSdy3L59sUK3nniio8iWvAAR13cMzvXDX+wxyjEOajuuEhxw@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 9:24=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> This patchset intends to improve tlb utilization by using hugepages for
> the linear mapping.
>
> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
> take care of isolating the kernel text and rodata so that they are not
> mapped with a PUD mapping which would then assign wrong permissions to
> the whole region: it is achieved the same way as arm64 by using the
> memblock nomap API which isolates those regions and re-merge them afterwa=
rds
> thus avoiding any issue with the system resources tree creation.
>
> base-commit-tag: v6.3-rc1
>
> v9:
> - Remove new API and arm64 patches as it created more issues than it
>   solved, thanks Anup for reporting those bugs!
> - Add a patch that moves the linear mapping creation outside of setup_vm_=
final
> - Use nomap API like arm64
> - Removed RB from Andrew and Anup as the patch changed its logic
> - Fix kernel rodata size computation
>
> v8:
> - Fix rv32, as reported by Anup
> - Do not modify memblock_isolate_range and fixes comment, as suggested by=
 Mike
> - Use the new memblock API for crash kernel too in arm64, as suggested by=
 Andrew
> - Fix arm64 double mapping (which to me did not work in v7), but ends up =
not
>   being pretty at all, will wait for comments from arm64 reviewers, but
>   this patch can easily be dropped if they do not want it.
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
> Alexandre Ghiti (3):
>   riscv: Get rid of riscv_pfn_base variable
>   riscv: Move the linear mapping creation in its own function
>   riscv: Use PUD/P4D/PGD pages for the linear mapping

I have tested this series again on QEMU RV64 and RV32. I also tried
KVM RV64 and RV32, this works fine as well.

>
>  arch/riscv/include/asm/page.h |  19 ++++++-
>  arch/riscv/mm/init.c          | 102 ++++++++++++++++++++++++++--------
>  arch/riscv/mm/physaddr.c      |  16 ++++++
>  drivers/of/fdt.c              |  11 ++--
>  4 files changed, 118 insertions(+), 30 deletions(-)
>
> --
> 2.37.2
>

Regards,
Anup
