Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746046533DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiLUQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiLUQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:17:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679C220E8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:17:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x22so37940551ejs.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jCNdpn8GFI0Is0z/59JOfTTLADKxyB9PigrVleL5rjw=;
        b=kT6xmphJO5ckl4v315yHsSmQHcwASgIJXMzJk2vYFXsiWtX3G5cNYoGZopxeEpgm0l
         j4u4NL6qZs9ltnFQXoZa0EulkCqDv7ZCWH2M3rgm2SubHiIkBAiv8qvsIuJG6CeZCkhA
         QA3A5j3KCBWimYhomSVUROCw67iuuJVNxZdxxMVn5aaiAatF+Rdy43Y26tgeL/7mspz1
         jj5HUxWr/eO1ErC6b1ZN8PoVLTH+jX+4qr8gu5Q2Wpr+CXplyNuPaQyq4XFg1XrcLc2v
         i2vOAOmhx5KNBsiX7BulEtV1H0o8Kk6mBFdvYFwvlHUOe4F5BOg5Z9RBIKpNQ3k8xgHH
         r5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCNdpn8GFI0Is0z/59JOfTTLADKxyB9PigrVleL5rjw=;
        b=FojJIdM5ZrRxlRdWdfSlyonD21rLcuPJbrbbWJCpuiRzcAzcgr2SydOAeZLmQAObvy
         S22HfDTgfS0DbRmqOcGc4pHMbuFlyhdOK1fW5T6IjqyonZp5eVH7g9q8LGprrMOWAgz8
         GNDP9Htnj7Pu0TJR6qfV1b4tL5VWMsHSUN3OoKA0oiIKeAfWzPyS++ggiM9sUNBwMFuP
         tcF6RZT71xRFetvghN+VkpHjdFee2xjiZuGY2IfUPZtEBVVv1wUZWklw5eeFTdd+xnjm
         q+MSoE0igGahozmbLlsuUBGxvxOwZp+NEnSMj0bCu7gBG6LJTb5joXmi2d36HNAQFmj/
         Rh7Q==
X-Gm-Message-State: AFqh2kr98ZXpyYyF25/yV1bhTpFeuaNmkYkYpm6yZGnewZGPUCa1f6ZC
        PrmTmSshJi9rST4V/eGWqg7o20iRDNpbqQRE3tA=
X-Google-Smtp-Source: AMrXdXufU0qozuoKGH10DXoaVrf/cwlEjKCmPjC3df92wjSI/A87tF6JB9gDwWTeTRvO8P9lVIxPXMLCiehSmhzeUtY=
X-Received: by 2002:a17:907:ca14:b0:7ad:d7f9:1f88 with SMTP id
 uk20-20020a170907ca1400b007add7f91f88mr135196ejc.217.1671639438585; Wed, 21
 Dec 2022 08:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20221216185012.2342675-1-abdulras@google.com>
In-Reply-To: <20221216185012.2342675-1-abdulras@google.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 22 Dec 2022 00:17:07 +0800
Message-ID: <CAEUhbmUsFt0H-Dd3XHjuk6sUq0hrV9SFU=1jD2LQ10xywZOZiA@mail.gmail.com>
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 17, 2022 at 3:12 AM Saleem Abdulrasool <abdulras@google.com> wrote:
>
> The compiler is free to generate vectorized operations for zero'ing
> memory.  The kernel does not use the vector unit on RISCV, similar to
> architectures such as x86 where we use `-mno-mmx` et al to prevent the
> implicit vectorization.  Perform a similar check for
> `-mno-implicit-float` to avoid this on RISC-V targets.
>
> Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
> ---
>  arch/riscv/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0d13b597cb55..68433476a96e 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -89,6 +89,10 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
>  # architectures.  It's faster to have GCC emit only aligned accesses.
>  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>
> +# Ensure that we do not vectorize the kernel code when the `v` extension is
> +# enabled.  This mirrors the `-mno-mmx` et al on x86.
> +KBUILD_CFLAGS += $(call cc-option,-mno-implicit-float)

This looks like an LLVM flag, but not GCC.

Can you elaborate what exact combination (compiler flag and source)
would cause an issue?

From your description, I guess it's that when enabling V extension in
LLVM, the compiler tries to use vector instructions to zero memory,
correct?

Can you confirm LLVM does not emit any float instructions (like F/D
extensions) because the flag name suggests something like "float"?

> +
>  ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
>  prepare: stack_protector_prepare
>  stack_protector_prepare: prepare0
> --

Regards,
Bin
