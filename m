Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AAE71558F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjE3GhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjE3GhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41875B2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F9F62A92
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C60C433EF;
        Tue, 30 May 2023 06:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685428640;
        bh=SsEFykTTr1Y+kZYyRqrdoefiJQaCTMcgpE7uD+V55Ow=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OWDqbvWlIm7OcMQaGlT+EtXnC54BfSzGWgOzgp5j/7ydS/dewMezjQOwRKCHPIOHe
         TL051HGjO/RDOZjAL0Y+hLp1zKulj0+SdesJUstAg7+V1AYaACvbwkWZOFwyOLoquG
         awMoPUgNJ8SVHbU98ceJNJxa+JjwbY8tOzQtF2AMzz0d8qRkmgx9DpmFFTa3dZ5zl1
         zp0pnAAu8cf8xuN/gn/mMGXQo3SsfxZT5anmzHl+FPItlPFjQv/g+hIRFpHqmMMIDZ
         ykHwy9qcqwBUlDwGHk7LUvgSux9HeyHuTv2yp/sv4ee1+ADOPUQeky9Us0pLZNu0XU
         NMy7pb6+v+YLA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@rivosinc.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] riscv: mm: Pre-allocate PGD entries vmalloc/modules area
In-Reply-To: <20230529180023.289904-1-bjorn@kernel.org>
References: <20230529180023.289904-1-bjorn@kernel.org>
Date:   Tue, 30 May 2023 08:37:17 +0200
Message-ID: <871qiyfhpe.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The RISC-V port requires that kernel PGD entries are to be
> synchronized between MMs. This is done via the vmalloc_fault()
> function, that simply copies the PGD entries from init_mm to the
> faulting one.
>
> Historically, faulting in PGD entries have been a source for both bugs
> [1], and poor performance.
>
> One way to get rid of vmalloc faults is by pre-allocating the PGD
> entries. Pre-allocating the entries potientially wastes 64 * 4K (65 on
> SV39). The pre-allocation function is pulled from J=C3=B6rg R=C3=B6del's =
x86
> work, with the addition of 3-level page tables (PMD allocations).
>
> The pmd_alloc() function needs the ptlock cache to be initialized
> (when split page locks is enabled), so the pre-allocation is done in a
> RISC-V specific pgtable_cache_init() implementation.
>
> Pre-allocate the kernel PGD entries for the vmalloc/modules area, but
> only for 64b platforms.
>
> Link: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org=
/ # [1]
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

...and the build was bitten by nommu [1]. I'll hold off the v2 a bit, to
see if there's any other comments.


Bj=C3=B6rn

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20230529180023.2=
89904-1-bjorn@kernel.org/
