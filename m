Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6310C722D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjFERFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjFERFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:05:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EBCA6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C591561E8B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB30C4339C;
        Mon,  5 Jun 2023 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685984714;
        bh=yEpxiQ3fmeL0xXU4oqZwbEUseI3GKuRgp39yNbpnCQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BolcBbiCcHlGyYY2b6/88QhsCF7i9w0kj753eMZt5nBdvBIjsHfDAPDe0Ba9pCGRf
         F2fUQfzLZTrKazCBgZl2t6P7GHuEqWfOtGdRZ6PJus5wvXAcRXRR0ZNw5zcmCac0mi
         36FHvdlJ25I5MabmuIDzog2p6NX0yyMIx45lt/nfsPWbFEPB+USg3Fcxo0IoDgQFNP
         oBaxagNngmnzHEW2jEIhHOn6EC/b5hTP9EqAz7/iOu33m5qoJqWoRp7LryvCNBwwkS
         TGJsnratZdjA1JFs4PXsywLvk+fAForUrvT9XuUpRgnNeIwnmb7gZCl/QsBVa1sE7R
         Upsmaghvbu2Zg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso22398731fa.2;
        Mon, 05 Jun 2023 10:05:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDyQJhDpOSBVoLotrchLF9T5lUWAY1wv3FAfXlUO6DGKujvO8KO1
        dlbSPcWVBL5SHzEjsd1ZfCGctWGLQdRm1shEmjk=
X-Google-Smtp-Source: ACHHUZ5a4uJgqYj6XYfDGH+cbQx//PBtbULgCbjcB59kMvuL6TUIBZNr7mZHyTg0SmBldrQE5OAx+nZDYXN+zYRkeR0=
X-Received: by 2002:a2e:8e97:0:b0:2b0:790e:95ab with SMTP id
 z23-20020a2e8e97000000b002b0790e95abmr4837221ljk.31.1685984712145; Mon, 05
 Jun 2023 10:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com> <20230605074024.1055863-4-puranjay12@gmail.com>
In-Reply-To: <20230605074024.1055863-4-puranjay12@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 5 Jun 2023 10:05:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4JVUUzMfNQwTE_uzp3bnO3EAYDikU1Nyx6x-6ROFDNOA@mail.gmail.com>
Message-ID: <CAPhsuW4JVUUzMfNQwTE_uzp3bnO3EAYDikU1Nyx6x-6ROFDNOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
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
> Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
> ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final ROX buffer
> with bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
> JIT as these functions are required by bpf_jit_binary_pack allocator.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 119 +++++++++++++++++++++++++++++-----
>  1 file changed, 102 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 145b540ec34f..ee9414cadea8 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -76,6 +76,7 @@ struct jit_ctx {
>         int *offset;
>         int exentry_idx;
>         __le32 *image;
> +       __le32 *ro_image;

We are using:
image vs. ro_image
rw_header vs. header
rw_image_ptr vs. image_ptr

Shall we be more consistent with rw_ or ro_ prefix?

>         u32 stack_size;
>         int fpb_offset;
>  };
> @@ -205,6 +206,20 @@ static void jit_fill_hole(void *area, unsigned int s=
ize)
>                 *ptr++ =3D cpu_to_le32(AARCH64_BREAK_FAULT);
>  }
>
> +int bpf_arch_text_invalidate(void *dst, size_t len)
> +{
> +       __le32 *ptr;
> +       int ret;
> +
> +       for (ptr =3D dst; len >=3D sizeof(u32); len -=3D sizeof(u32)) {
> +               ret =3D aarch64_insn_patch_text_nosync(ptr++, AARCH64_BRE=
AK_FAULT);

I think one aarch64_insn_patch_text_nosync() per 4 byte is too much overhea=
d.
Shall we add a helper to do this in bigger patches?

Thanks,
Song

> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +

[...]
