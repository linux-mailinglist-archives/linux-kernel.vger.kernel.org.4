Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B891722CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjFEQmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFEQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B0EE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F99D60DBF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D98DC433A1;
        Mon,  5 Jun 2023 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685983353;
        bh=n5juZxlzx1EtJLsbnquMhCy7aHrstqC/yTfSW67S+qE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UpY/yHckYTINMFEyQt6nBEmx9F7m6ycqDkJdttfmJAbgLcViQH28Y9tMcMWVTFPAy
         gH89M6JNIONss9O3XXW/RSFvbQ3EsGJ+cF77HVfkiF7EmNBjP3XrA4ayIeGirBVjmo
         BPEFRlbByKV8KeEYCancTar+bWG9taqG5Wdm0nA2pug6HqHUJrSeg3mF6olPIMez/O
         OfShD4g2xTNOI59TCkXiMPDYnyRC3QJXSRDQM7yDYL7zozoQWX0CxS9fIqeqfb7dTT
         UVHE6Tf9RLTvsc43LTJDKAGKVuPdrKlFBbVdDzJSrnL8EuEBeW/G9noZFYPXCfFJgp
         S7spY20NHOI+g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso42970361fa.1;
        Mon, 05 Jun 2023 09:42:33 -0700 (PDT)
X-Gm-Message-State: AC+VfDxci713zmOZ4qT/xN447GNXnIwwwUqiINjWbLfs90U8a0bPXTdB
        m6ZSgZFM/kgGngCRklH2+oCGIYJHOt9L9vqbeC4=
X-Google-Smtp-Source: ACHHUZ4+IUD6+wCdoUvmip2g5FCLhoLnY4OOKMh2gI4u81vQapPFI1fPQigx/MPY6XWxpncRJN8+QwMYpOWbxpl1QxM=
X-Received: by 2002:a2e:a442:0:b0:2ad:dd7e:6651 with SMTP id
 v2-20020a2ea442000000b002addd7e6651mr4970194ljn.43.1685983351477; Mon, 05 Jun
 2023 09:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com> <20230605074024.1055863-3-puranjay12@gmail.com>
In-Reply-To: <20230605074024.1055863-3-puranjay12@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 5 Jun 2023 09:42:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5-+eBuNGFes3i5-A4vA_f3woLwL_WbUcg6gNXssyi_Xg@mail.gmail.com>
Message-ID: <CAPhsuW5-+eBuNGFes3i5-A4vA_f3woLwL_WbUcg6gNXssyi_Xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] arm64: patching: Add aarch64_insn_copy()
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 12:40=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> This will be used by BPF JIT compiler to dump JITed binary to a RX huge
> page, and thus allow multiple BPF programs sharing the a huge (2MB)
> page.
>
> The bpf_prog_pack allocator that implements the above feature allocates
> a RX/RW buffer pair. The JITed code is written to the RW buffer and then
> this function will be used to copy the code from RW to RX buffer.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Acked-by: Song Liu <song@kernel.org>

With a nit below.

> ---
>  arch/arm64/include/asm/patching.h |  1 +
>  arch/arm64/kernel/patching.c      | 39 +++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/p=
atching.h
> index 68908b82b168..dba9eb392bf1 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>  int aarch64_insn_write(void *addr, u32 insn);
>
>  int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +void *aarch64_insn_copy(void *addr, const void *opcode, size_t len);
>
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index b4835f6d594b..48c710f6a1ff 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -105,6 +105,45 @@ noinstr int aarch64_insn_write_literal_u64(void *add=
r, u64 val)
>         return ret;
>  }
>
> +/**
> + * aarch64_insn_copy - Copy instructions into (an unused part of) RX mem=
ory
> + * @addr: address to modify
> + * @opcode: source of the copy
> + * @len: length to copy
> + *
> + * Useful for JITs to dump new code blocks into unused regions of RX mem=
ory.
> + */

nit:
I understand "addr" and "opcode" are used by x86 text_poke_copy(). But mayb=
e
we should call them "dst" and "src" or "to" and "from" or something similar=
?

Thanks,
Song

> +noinstr void *aarch64_insn_copy(void *addr, const void *opcode, size_t l=
en)
> +{
> +       unsigned long flags;
> +       size_t patched =3D 0;
> +       size_t size;
> +       void *waddr;
> +       void *dst;
> +       int ret;
> +
> +       raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +       while (patched < len) {
> +               dst =3D addr + patched;
> +               size =3D min_t(size_t, PAGE_SIZE - offset_in_page(dst),
> +                            len - patched);
> +
> +               waddr =3D patch_map(dst, FIX_TEXT_POKE0);
> +               ret =3D copy_to_kernel_nofault(waddr, opcode + patched, s=
ize);
> +               patch_unmap(FIX_TEXT_POKE0);
> +
> +               if (ret < 0) {
> +                       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +                       return NULL;
> +               }
> +               patched +=3D size;
> +       }
> +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +       return addr;
> +}
> +
>  int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>  {
>         u32 *tp =3D addr;
> --
> 2.39.2
>
