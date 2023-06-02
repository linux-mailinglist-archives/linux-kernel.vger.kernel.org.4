Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4932971F72A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjFBAgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjFBAgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16869123;
        Thu,  1 Jun 2023 17:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF7C3647BA;
        Fri,  2 Jun 2023 00:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E5AC433A1;
        Fri,  2 Jun 2023 00:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685666196;
        bh=8680DMzx0gtVOisbuW5F5FI58VdZiV3S7sDNyC66jIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XTmFrz6x8P+uu4p7+8CwwHHAR8ToxETybv3aokjIkUt8au2/bliIWtKwA0GAbEtXU
         35MXE4ZwOYCOUbquOW3LQoZZDXhPbam+LWuZhJ0mqETvOfa2/rMGWxD+GJruYpNbS6
         ci30bYJW5Xs8iSRMEPad+knzjZDpipv9dxPxlL70NiYXhKXJnUs1HWnqvirj5dSWAN
         B2cCO/rarwHERSu66gvzGkFtyDmlSmQAJPI3dJJQqihBq56qTMR5zptT8HtrJ2b10S
         TMFJdORTSry9D8pvsZGiWSqPLVC1lC/A7oq6hOwBZbEcU0/jUM34HuLUgEBSnU29a0
         P+mvZ51/iQCoA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f60bc818d7so1269054e87.1;
        Thu, 01 Jun 2023 17:36:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDz01X/xqtBxs2VBC7kbZ7774EbwDGMYrk1Mdk03I6HzRaiW0yxT
        U5plHKTKxbuE+J/FKIt2iVbdgdr0HQJB0Rp5MwY=
X-Google-Smtp-Source: ACHHUZ4rAYUoiHYEWWqFuntxOuL06QmDCDII8lO4o2SuljgVgQXswY+xn62uFOnPiNtfcw4WXcIV+P9v/6p/Zkld05w=
X-Received: by 2002:ac2:44ca:0:b0:4f3:b18a:6497 with SMTP id
 d10-20020ac244ca000000b004f3b18a6497mr927744lfm.52.1685666193979; Thu, 01 Jun
 2023 17:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230601101257.530867-1-rppt@kernel.org>
In-Reply-To: <20230601101257.530867-1-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 1 Jun 2023 17:36:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Em5Sj9uCGyfM6BheTuvA4pviavRTUK-3MbGsd9yCRbQ@mail.gmail.com>
Message-ID: <CAPhsuW5Em5Sj9uCGyfM6BheTuvA4pviavRTUK-3MbGsd9yCRbQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] mm: jit/text allocator
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jun 1, 2023 at 3:13=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Hi,
>
> module_alloc() is used everywhere as a mean to allocate memory for code.
>
> Beside being semantically wrong, this unnecessarily ties all subsystmes
> that need to allocate code, such as ftrace, kprobes and BPF to modules
> and puts the burden of code allocation to the modules code.
>
> Several architectures override module_alloc() because of various
> constraints where the executable memory can be located and this causes
> additional obstacles for improvements of code allocation.
>
> This set splits code allocation from modules by introducing
> jit_text_alloc(), jit_data_alloc() and jit_free() APIs, replaces call
> sites of module_alloc() and module_memfree() with the new APIs and
> implements core text and related allocation in a central place.
>
> Instead of architecture specific overrides for module_alloc(), the
> architectures that require non-default behaviour for text allocation must
> fill jit_alloc_params structure and implement jit_alloc_arch_params() tha=
t
> returns a pointer to that structure. If an architecture does not implemen=
t
> jit_alloc_arch_params(), the defaults compatible with the current
> modules::module_alloc() are used.
>
> The new jitalloc infrastructure allows decoupling of kprobes and ftrace
> from modules, and most importantly it enables ROX allocations for
> executable memory.

This set does look cleaner than my version [1]. However, this is
partially because this set only separates text and data; while [1]
also separates rw data, ro data, and ro_after_init data. We need
such separation to fully cover module usage, and to remove
VM_FLUSH_RESET_PERMS. Once we add these logic to this
set, the two versions will look similar.

OTOH, I do like the fact this version enables kprobes (and
potentially ftrace and bpf) without CONFIG_MODULES. And
mm/ seems a better home for the logic.

That being said, besides comments in a few patches, this
version looks good to me. With the fix I suggested for patch
12/13, it passed my tests on x86_64 with modules, kprobes,
ftrace, and BPF.

If we decided to ship this version, I would appreciate it if I
could get more credit for my work in [1] and research work
before that.

Thanks,
Song

[1] https://lore.kernel.org/lkml/20230526051529.3387103-1-song@kernel.org/
