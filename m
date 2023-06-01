Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4D071F642
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjFAWuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjFAWtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B363138;
        Thu,  1 Jun 2023 15:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B91BF64AAF;
        Thu,  1 Jun 2023 22:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266E3C433A8;
        Thu,  1 Jun 2023 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685659793;
        bh=s5scddDgq8SCu6I0UWPQExKWJjas9UFzehdQi3Sw4tA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K25ToaEbCp02bMG+wiJikwHyiXiwwQBkm/MmN8qlrLj5yam240H0kFAxxnFa3RlG8
         bu4BSS/frooyZ20B2VklohnrYULCfishpBQ/wfdUaMkt+oR8gS4E1+AjfNshKja3vS
         Rv+moH0Y5isDfBQyF8Rj722+0entBKGogJrcfr++cvzRmW73HdsIB35hoxtRn829Ae
         fyn3i/1QAGvtS1oiJarw65vHM76zJn0jBvddq9Vcz7E6Icr7CQW2U08iG1Oryzm6d3
         58DCK+DxQNJ2Qn/JWEej+n8GVZwut1/xKU3k6dkfSYsQUQ9uCCopruEXev0WWNFxor
         G4HpcCwxRlB1w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso1458699e87.0;
        Thu, 01 Jun 2023 15:49:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDygFaQyEGlCK+cBn5k10kr0LSS4LPF8TjiwLA5nWkYlIg34T11I
        usjdwtcH1xjP2uCYF0St+hKlyfYIRh4gdi5zNt4=
X-Google-Smtp-Source: ACHHUZ4uA6ym60CkoL3kD4Xme876wGBHsdD1XRoswJZBV/GnrkgRlI3npJzU+tR131QuPJoGC+7UxG4nzuqJElDeBo4=
X-Received: by 2002:ac2:4a8b:0:b0:4f3:aa81:2a6e with SMTP id
 l11-20020ac24a8b000000b004f3aa812a6emr364328lfp.19.1685659791105; Thu, 01 Jun
 2023 15:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230601101257.530867-1-rppt@kernel.org> <20230601101257.530867-13-rppt@kernel.org>
In-Reply-To: <20230601101257.530867-13-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 1 Jun 2023 15:49:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Q2d7=7yBMQLgz+7Bz_q==_F+N3C8O4LStXva73ECCTg@mail.gmail.com>
Message-ID: <CAPhsuW4Q2d7=7yBMQLgz+7Bz_q==_F+N3C8O4LStXva73ECCTg@mail.gmail.com>
Subject: Re: [PATCH 12/13] x86/jitalloc: prepare to allocate exectuatble
 memory as ROX
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

On Thu, Jun 1, 2023 at 3:15=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: Song Liu <song@kernel.org>
>
> Replace direct memory writes to memory allocated for code with text pokin=
g
> to allow allocation of executable memory as ROX.
>
> The only exception is arch_prepare_bpf_trampoline() that cannot jit
> directly into module memory yet, so it uses set_memory calls to
> unprotect the memory before writing to it and to protect memory in the
> end.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Co-developed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/x86/kernel/alternative.c | 43 +++++++++++++++++++++++------------
>  arch/x86/kernel/ftrace.c      | 41 +++++++++++++++++++++------------
>  arch/x86/kernel/module.c      | 24 +++++--------------
>  arch/x86/kernel/static_call.c | 10 ++++----
>  arch/x86/kernel/unwind_orc.c  | 13 +++++++----
>  arch/x86/net/bpf_jit_comp.c   | 22 +++++++++++++-----

We need the following in this patch (or before this patch).
Otherwise, the system will crash at the VIRTUAL_BUG_ON()
in vmalloc_to_page().

Thanks,
Song

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index bf954d2721c1..4efa8a795ebc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1084,7 +1084,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen,
u8 **image_ptr,
                return NULL;
        }

-       *rw_header =3D kvmalloc(size, GFP_KERNEL);
+       *rw_header =3D kvzalloc(size, GFP_KERNEL);
        if (!*rw_header) {
                bpf_arch_text_copy(&ro_header->size, &size, sizeof(size));
                bpf_prog_pack_free(ro_header);
@@ -1092,8 +1092,6 @@ bpf_jit_binary_pack_alloc(unsigned int proglen,
u8 **image_ptr,
                return NULL;
        }

-       /* Fill space with illegal/arch-dep instructions. */
-       bpf_fill_ill_insns(*rw_header, size);
        (*rw_header)->size =3D size;

        hole =3D min_t(unsigned int, size - (proglen + sizeof(*ro_header)),
