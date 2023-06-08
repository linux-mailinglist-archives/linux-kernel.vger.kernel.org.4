Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8C7284F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFHQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjFHQ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF81FDC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CAF664EF5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C10C433A0;
        Thu,  8 Jun 2023 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686241719;
        bh=5zH08XUfq+18tqlmHVWvpEAsjeO5Ce/XxzLXbX4gVVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JfmL+BlSm6q41L0gLNUh+FbjT1O6SVwiKrCWfDK5VghY/IietAuCdGmVkGDKyc+CG
         ecpOIKaMpvJnuiNhsBKzEBEjbvzJH/VuMpaXgoBGyX18dddWlw4/yGwEqlzbD13nkj
         OQhYkpRm0nqGO1ab4Nr4rt0H9LDMwNyE42ZLM5C+WqcJ2VpJLrbluEOuNyA0aOE4RN
         oV8afTD79QjLpzYe3AOyUvNlg+Ulxy+NQ7aIeHswbV7m12UMQ+OvQcQBR5CIW8fNVj
         nSACJAYPj2pX+aCIoXHKCVUYkWHUt83FwCjYoZzVWGFZGerON2bm3iV9MozSok0Vko
         kz5Fe4Zs+uEpA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b1b084620dso7989071fa.0;
        Thu, 08 Jun 2023 09:28:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDwCGZnHOtYXQ6x5tdGksK+Km5Ohz9CHLDox72UK6XLyYuehcP74
        2tzFK+/GfD5yq4fIU2AEiqbGl/wGYgucFK9lA3M=
X-Google-Smtp-Source: ACHHUZ4YX0Ne++b7K0Iz0nPYwgBxAk5ute7QPeyjEc/PvBcXTPrezWlpefSE0BZKqQyRuzaIQ6x+FLzllBH98pluu/c=
X-Received: by 2002:a2e:9cd1:0:b0:2b1:e943:8abe with SMTP id
 g17-20020a2e9cd1000000b002b1e9438abemr3393233ljj.47.1686241717897; Thu, 08
 Jun 2023 09:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230607091814.46080-1-puranjay12@gmail.com> <20230607091814.46080-4-puranjay12@gmail.com>
In-Reply-To: <20230607091814.46080-4-puranjay12@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 8 Jun 2023 09:28:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7soOQasGw5fHB2qTeJnqR4ZrGBodyO87k=vg=TYqCsWA@mail.gmail.com>
Message-ID: <CAPhsuW7soOQasGw5fHB2qTeJnqR4ZrGBodyO87k=vg=TYqCsWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 2:18=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
[...]
> +
>  static inline int epilogue_offset(const struct jit_ctx *ctx)
>  {
>         int to =3D ctx->epilogue_offset;
> @@ -701,7 +716,8 @@ static int add_exception_handler(const struct bpf_ins=
n *insn,
>                                  struct jit_ctx *ctx,
>                                  int dst_reg)
>  {
> -       off_t offset;
> +       off_t ins_offset;
> +       off_t fixup_offset;

Please add some comments for these two offsets.

>         unsigned long pc;
>         struct exception_table_entry *ex;
>
> @@ -717,12 +733,11 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>                 return -EINVAL;
>
>         ex =3D &ctx->prog->aux->extable[ctx->exentry_idx];
> -       pc =3D (unsigned long)&ctx->image[ctx->idx - 1];
> +       pc =3D (unsigned long)&ctx->ro_image[ctx->idx - 1];
>
> -       offset =3D pc - (long)&ex->insn;
> -       if (WARN_ON_ONCE(offset >=3D 0 || offset < INT_MIN))
> +       ins_offset =3D pc - (long)&ex->insn;
> +       if (WARN_ON_ONCE(ins_offset >=3D 0 || ins_offset < INT_MIN))
>                 return -ERANGE;
> -       ex->insn =3D offset;
>
>         /*
>          * Since the extable follows the program, the fixup offset is alw=
ays
> @@ -732,11 +747,20 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>          * modifying the upper bits because the table is already sorted, =
and
>          * isn't part of the main exception table.
>          */
> -       offset =3D (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
> -       if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
> +       fixup_offset =3D (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
> +       if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
>                 return -ERANGE;
>
> -       ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
> +       /*
> +        * The offsets above have been calculated using the RO buffer but=
 we
> +        * need to use the R/W buffer for writes.
> +        * switch ex to rw buffer for writing.
> +        */
> +       ex =3D (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image);
> +
> +       ex->insn =3D ins_offset;
> +
> +       ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
>                     FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>
>         ex->type =3D EX_TYPE_BPF;
[...]
>         /* And we're done. */
>         if (bpf_jit_enable > 1)
>                 bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
>
> -       bpf_flush_icache(header, ctx.image + ctx.idx);
> +       bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
>
>         if (!prog->is_func || extra_pass) {
>                 if (extra_pass && ctx.idx !=3D jit_data->ctx.idx) {
>                         pr_err_once("multi-func JIT bug %d !=3D %d\n",
>                                     ctx.idx, jit_data->ctx.idx);
> -                       bpf_jit_binary_free(header);
>                         prog->bpf_func =3D NULL;
>                         prog->jited =3D 0;
>                         prog->jited_len =3D 0;
> +                       goto out_free_hdr;
> +               }
> +               if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
> +                                                        header))) {
> +                       ro_header =3D NULL;

I think we need
       prog =3D orig_prog;
here.

Thanks,
Song
