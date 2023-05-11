Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B778B6FFCCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbjEKWmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbjEKWmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:42:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638872720
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:42:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ac65ab7432so447105ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683844921; x=1686436921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRrgqpOwIlQoRPTZLdmgpQ64qveaxTRuu89B7YxAGY0=;
        b=DHYnwtIOsObzm5cm/h2VvG5bwx3m3YhRXesCgIFneCf491ex5QqsJ4W2eMPAG8wzPv
         ak43yqflicbl/KI+dHgg0aGr4U9LEv4vTdpS1nRO1m89WRv9F2QXhHAj279D0YbP8OGo
         /cyMA8aMw9Z6Tva/A1MLuvGQvfqUdzY8GU7YecKug/+t6eSsc3AZAhQ7xXimDg4rC0sL
         CxH1EzZINasfsoSEA+p/mbivb9mnEB3a1mZGHsXfpvJrJYt5/q/HUb5eK1S+GTjGH31j
         zbFYZ54F5mjQGo0a/hng8ANmX7lTUoW7eW3zvW1M67q98oa3S92SRxJXlhKpXI0sSTZq
         B5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844921; x=1686436921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRrgqpOwIlQoRPTZLdmgpQ64qveaxTRuu89B7YxAGY0=;
        b=C8Wpbb0hIThKzQ2epm2z0xemmxAcpaGNjgbZ7xfI1X1tfy1fB0zgGg7zSD8CZyRhOS
         5bVPTsFUYzzWAwMZdU82/2H0vwxOqPNLh4Dt2CbdG7rJh+ZFHWjNaQftZEjWG5H7qwGA
         QKOasdmBgAQD78bRPJF1MI/FxqW+rXeTSDV/ntKKRUikcbURKIYEaHnDP4ZbH+Mh/nMS
         e7/e2SKgDTGQsqex0cyamvUiKhaRKU5xouKGT2JCLjslYjXcNAhBhVZmD+DsoMKbfjWr
         y/W+Uavl3fqAo7DVIecJOye1XmA7e5Z2Wd7FflakseBzEfhrcVrNmwYu4ycS0xanLVfA
         T2aQ==
X-Gm-Message-State: AC+VfDxdk1lnZ0nKabnRRn9ByWIlOTkYVz4jfe2oea/AEaedlkKCz0jS
        9wn1RLuALKmnmhFjf10R4SJY+UA2vyrh8zjJBK3y/Q==
X-Google-Smtp-Source: ACHHUZ6tbw+SRPvBBpQQ26e6/t6mz3DeQYeLX5dQ+govmHEl95m+b9MeoOnyRnt4VK/SdOF4osHF69PHIs5+g1jIR+0=
X-Received: by 2002:a17:902:c410:b0:1aa:ea22:8043 with SMTP id
 k16-20020a170902c41000b001aaea228043mr14610plk.7.1683844920748; Thu, 11 May
 2023 15:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230423223210.126948-1-maskray@google.com>
In-Reply-To: <20230423223210.126948-1-maskray@google.com>
From:   Fangrui Song <maskray@google.com>
Date:   Thu, 11 May 2023 15:41:48 -0700
Message-ID: <CAFP8O3LksO-4JAoRnx9ND0E9rRyqb6xsUsGtBVQXOsaYxLmhBQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: replace deprecated scall with ecall
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 3:32=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> scall is a deprecated alias for ecall. ecall is used in several places,
> so there is no assembler compatibility concern.
>
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  arch/riscv/kernel/entry.S             | 4 ++--
>  arch/riscv/kernel/vdso/rt_sigreturn.S | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 99d38fdf8b18..2f51935612d1 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -191,7 +191,7 @@ handle_syscall:
>         REG_S a0, PT_ORIG_A0(sp)
>         /*
>          * Advance SEPC to avoid executing the original
> -        * scall instruction on sret
> +        * ecall instruction on sret
>          */
>         addi s2, s2, 0x4
>         REG_S s2, PT_EPC(sp)
> @@ -603,6 +603,6 @@ END(excp_vect_table)
>  #ifndef CONFIG_MMU
>  ENTRY(__user_rt_sigreturn)
>         li a7, __NR_rt_sigreturn
> -       scall
> +       ecall
>  END(__user_rt_sigreturn)
>  #endif
> diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vd=
so/rt_sigreturn.S
> index 0573705eac76..10438c7c626a 100644
> --- a/arch/riscv/kernel/vdso/rt_sigreturn.S
> +++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
> @@ -11,6 +11,6 @@ ENTRY(__vdso_rt_sigreturn)
>         .cfi_startproc
>         .cfi_signal_frame
>         li a7, __NR_rt_sigreturn
> -       scall
> +       ecall
>         .cfi_endproc
>  ENDPROC(__vdso_rt_sigreturn)
> --
> 2.40.0.634.g4ca3ef3211-goog
>

Ping:)


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
