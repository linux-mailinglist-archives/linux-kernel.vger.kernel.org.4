Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE1650AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiLSLVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiLSLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:21:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD9A2AFB;
        Mon, 19 Dec 2022 03:21:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b69so12367200edf.6;
        Mon, 19 Dec 2022 03:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQqA7ygsto6xaIwShunauCg+8P+zPr4dDwx6z8aEPXk=;
        b=Qecx+b4KPAd9/b+nHyGpQdY6ioSxL7WtnO/O8BKN3xlRrLDu4JKdWez/YZqgCM1pkU
         oHF+aaw7v+iHBPAflj8s1AqvmZPQf9WosqgePDkQqSAMQsZRl9uS6MDOBkJs4qLTdjLN
         SQApEspVNLNaQtalgfWwNv3X2bW2/XQSKHnQdyEIWc6AMe/ah26IgFYyZZGzVZxVlSit
         jxESMo2+x+rGcJsXCPmlVQUoUOJvFjEOzZ6pxPwjXk6pLb/8BuVYiftWXsCQRuk8IkRI
         8229+/qKrVwOXwHsVskI6ZwbVklg1K/bbTEOgTzVO6ge0EC+UYkPwu05a4ta3BUOzrb8
         Piwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQqA7ygsto6xaIwShunauCg+8P+zPr4dDwx6z8aEPXk=;
        b=1UnEeDlM2CUgN3U1AjnZhyqKKAZv0ZDqWCq/BSLbecm/cIKWaEq2qN2Xpavmn0Y8ge
         QdZYlHirFXagIpZCbur3+jtbDQC3Bs/oYqZ+0B5m8hLyvD+CfNJYjW0fA8VXJjBG09rl
         B5709zhjZ24QmpjkNbjHPk0X7s3cUaS0DgTYFaov63sfIPXgsy7ZazEU7fUtNHtMybce
         ligx4YfusKz7CQSJBwdYt9mB7qVnBXS2L7XxXiHUwzKc+75x/SYgMwDuHX+kESV9DZ9e
         pN3dPzclp5yCWEIDKyW0Qc+8v6JlvhtHXcckJ5ubQA30IGJ20lv+aoL8Iv14NH9M/2/a
         v1Ow==
X-Gm-Message-State: ANoB5plqBtxolRC+6dGyXsJ6G8UL9tvzYmjV2UTwlsbsA/cYwdGsM7ma
        hmnMr74kFtld1sAyNEtmawjmzZNez+aE8AW9xIBG2u2NSVr7tA==
X-Google-Smtp-Source: AA0mqf4MJzdQeHVxrr4jU2yyYqIoZSH1BCgma3gnh1/Vinrzu8kFrTI3pr7SAtSy6Z9epAityEv24oeSY2sHT6rbsPM=
X-Received: by 2002:aa7:cc08:0:b0:461:8a43:e93 with SMTP id
 q8-20020aa7cc08000000b004618a430e93mr10171686edt.275.1671448887967; Mon, 19
 Dec 2022 03:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y54r+5lkSvgA9IxR@spud>
In-Reply-To: <Y54r+5lkSvgA9IxR@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Dec 2022 11:21:01 +0000
Message-ID: <CA+V-a8vdijL7qcju2zH2phfj2+NXNkw35g8j8KX=RR74jSAK1Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] riscv: mm: dma-noncoherent: Pass direction and
 operation to ALT_CMO_OP()
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Conor,

Thank you for the review.

On Sat, Dec 17, 2022 at 8:52 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Prabhakar,
>
> On Mon, Dec 12, 2022 at 11:55:03AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Pass direction and operation to ALT_CMO_OP() macro.
> >
> > Vendors might want to perform different operations based on the direction
> > and callbacks (arch_sync_dma_for_device/arch_sync_dma_for_cpu/
> > arch_dma_prep_coherent) so to handle such cases pass the direction and
> > operation to ALT_CMO_OP() macro. This is in preparation for adding errata
> > for the Andes CPU core.
>
> This patch seems to break the build on top of the most recent
> linux-next:
> ......./stuff/linux/arch/riscv/mm/pmem.c:13:53: error: too few arguments provided to function-like macro invocation
>         ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
>                                                            ^
> /stuff/linux/arch/riscv/include/asm/errata_list.h:127:9: note: macro 'ALT_CMO_OP' defined here
> #define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)          \
>         ^
> ..  CC      block/partitions/sgi.o
> .+...+/stuff/linux/arch/riscv/mm/pmem.c:13:2: error: use of undeclared identifier 'ALT_CMO_OP'
>         ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
>         ^
> /stuff/linux/arch/riscv/mm/pmem.c:19:53: error: too few arguments provided to function-like macro invocation
>         ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
>                                                            ^
> /stuff/linux/arch/riscv/include/asm/errata_list.h:127:9: note: macro 'ALT_CMO_OP' defined here
> #define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)          \
>         ^
> ...........  AR      lib/math/built-in.a
> ./stuff/linux/arch/riscv/mm/pmem.c:19:2: .error: use of undeclared identifier 'ALT_CMO_OP'
>         ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
>         ^
> ..4 errors generated.
>
> The pmem stuff is new so that'd be why it has not come up before.
>
> (FWIW, clang allmodconfig)
>
Yes I need to rebase my changes on Palmer's branch.

Cheers,
Prabhakar
