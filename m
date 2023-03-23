Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B346C680F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjCWMTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjCWMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:19:12 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8395E2B2BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:18:29 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id x33so14797192uaf.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679573908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUGGmJNIiB2tF8GpRaO2v6aJCn8Q0P89mXNxX4DzMis=;
        b=mPuBjeJhfwjWVU2IiF589l1xztdu4iLvv5rYXSrDnDEmnOEfiaXr3e+6o21DzYJE6d
         TLtJGe7ge2fz5OHM6vcRKkB/g2EBVZBkguKaL7J491mqY/k7sqn3fSj4HW0nW3/NvB8S
         wrHnPIn9cbH+Ho2ekBbbo8KoaI7vNCQmWhyDxjnh5XXLzx5XFFeHFhi9pwsv+CypJv3V
         aZU5xlXrc8pmPv1fAu8dCvL7E4OQ04FpN0t0EcS7UE9vqVHzROz4LXn2DSKws//RaUJr
         cJ/U1kxwksVsO4tpBlDs6C8Zc/SDPt+TopdFtXa/7qhGmQd9ofI7MN/6uQ02tCpZZm6V
         R9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUGGmJNIiB2tF8GpRaO2v6aJCn8Q0P89mXNxX4DzMis=;
        b=E5LslAvFq3eTUi9nvDzHsOFplkwdWsvSsqgPz30GriE+9lbO9dBtB6ECdR/JifY/QP
         8uMCK+gEY8s0t82QK8aZP0Z2+2qymlanIu3SiwFHKz0tVtKyXodxq5mkxaKzTZOEHndB
         QmbnxKLBT2IiR12y8gTQrvtxh9qh42JjVJmcQLpqkOg3RFyZRLhQWMq8mrw+u1XXRgP+
         bpwd143cJB36/rI0ef05DF15aUjOutYhRSS9Yy4d1rzbwdwxMZxtaH6+1P5bFmslTW8V
         4KREFBrfcxkqyan8flLggX3mReB9oU+l0+WsCoet6bqHal62wfCy+Dt1CtSase81Hyp8
         OTBQ==
X-Gm-Message-State: AAQBX9fApqq1JUoxCjF6H/zugDGu7rDd46UYLZyJvYvngwHeEl3NvlAc
        5MeuObbcTOEJH1yFj7ILwuiibMTOY1K5N/ItBcQw8Q==
X-Google-Smtp-Source: AK7set9Ku140oLgFHLDCQ0mGT17Dc0+6TsKKP+riuE/qzlt8WH/QLk5OUjHO552MQkVQo+HaNEH3OYbtH5GCZ93/ARU=
X-Received: by 2002:a05:6130:c0b:b0:755:9b3:fef8 with SMTP id
 cg11-20020a0561300c0b00b0075509b3fef8mr5092826uab.2.1679573908493; Thu, 23
 Mar 2023 05:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
In-Reply-To: <20230316131711.1284451-1-alexghiti@rivosinc.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 23 Mar 2023 17:48:16 +0530
Message-ID: <CAK9=C2XJtSG2d_nsyDv7kU1v7Jj0chdevqrMc0MpJswukcEABA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] riscv: Use PUD/P4D/PGD pages for the linear mapping
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
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, Mar 16, 2023 at 6:48=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
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
> Alexandre Ghiti (4):
>   riscv: Get rid of riscv_pfn_base variable
>   mm: Introduce memblock_isolate_memory
>   arm64: Make use of memblock_isolate_memory for the linear mapping
>   riscv: Use PUD/P4D/PGD pages for the linear mapping

Kernel boot fine on RV64 but there is a failure which is still not
addressed. You can see this failure as following message in
kernel boot log:
    0.000000] Failed to add a System RAM resource at 80200000

Regards,
Anup

>
>  arch/arm64/mm/mmu.c           | 25 +++++++++++------
>  arch/riscv/include/asm/page.h | 19 +++++++++++--
>  arch/riscv/mm/init.c          | 53 ++++++++++++++++++++++++++++-------
>  arch/riscv/mm/physaddr.c      | 16 +++++++++++
>  drivers/of/fdt.c              | 11 ++++----
>  include/linux/memblock.h      |  1 +
>  mm/memblock.c                 | 20 +++++++++++++
>  7 files changed, 119 insertions(+), 26 deletions(-)
>
> --
> 2.37.2
>
