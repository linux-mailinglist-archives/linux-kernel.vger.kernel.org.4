Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85C16D06A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjC3N1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjC3N1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:27:09 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B080BDEF;
        Thu, 30 Mar 2023 06:26:46 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e6so9776646ilu.9;
        Thu, 30 Mar 2023 06:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680182805; x=1682774805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2pZnebNGLahNe2yjgjrKsFqnYvTRYd7uF1JoUeedu4=;
        b=ipMmc4f2rhe9ZxmiesNtaMCdByaDBx7tN+zc7KMJSrXwy2WiELheDph1YzfOyUJK5G
         2D9w1lws05LiLD96ktr9W079igf4FZMXTfy1rli6Syf8wtA/xOvdvesIM/xHoHpQ4mp2
         kGaQPBqZIeQg75WZRmLC1J0vvz0N+J/wHgPfeNx6CWqljr2xVRlnhMmqStDFXeH9OteD
         UdDKlBrcDx+IHVgGRnNql6fNqhC8UJ/0zLJcMACiQdKHQjGURJds5lWBs1vyz5ebkPWw
         0o6fGsGo2wE6PVztfykuJW8aKjmi0krcntJGszy/82gq0ndxxs4fJ8aJQW98nZewfAkA
         hgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182805; x=1682774805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2pZnebNGLahNe2yjgjrKsFqnYvTRYd7uF1JoUeedu4=;
        b=XKsMDayOlwVZ/+/jeS5lmBFAGWD0j4RBR2BY2nyji6WZuy/N3FaKHLkPpqeaWPMqUn
         txdSh18O2NU16utq/lwzwgwz6rUKdkcXa2qlMQymOBmYC4kqkMXed9jSBvMSDdPiiod+
         A6fFy4Nl/uQuMY7iayVLVTYQfi+VgqCvtmdJOwiEv7zl7K7TaBAAFoXizow8b/IX+4jf
         ga8m21Vt/qrehbiq6t46ECtRixi79KHHi06JGkaEF5lYbie94Jf313PUdpuZI8R7wHI/
         EPepXZ1PH2imQByNnwrQ5iLig0ayC5BcZrRK7n7MHVomJSJgP0QgfBN8E4W1mQsLjUrT
         K/ZQ==
X-Gm-Message-State: AAQBX9d+jR2BwKkDtcU459i1tNTLR81oh9wsEQLdmwozA42l3tHgpdiM
        xDe5DgCBBuRVlvi9zaCfTm8eGSjpDHycrDjd/VE=
X-Google-Smtp-Source: AKy350b7GKjd6GbmSD4bjqzZzqd/x8SBG7vY+M0wf9Tl0Xt+rzmxZqELne3/hmMfJjmFaGc7B3VEjdENhXkZ8+X22Co=
X-Received: by 2002:a05:6e02:1047:b0:325:dd36:7451 with SMTP id
 p7-20020a056e02104700b00325dd367451mr11322497ilj.1.1680182805604; Thu, 30 Mar
 2023 06:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-10-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-10-arnd@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Mar 2023 14:26:18 +0100
Message-ID: <CA+V-a8twDb_P3TOpOqhz3Umump_NZg2Bw-8tgMCAmAdadUxfkw@mail.gmail.com>
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before
 bidirectional DMA
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 1:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
> first to let the device see data written by the CPU, and invalidated
> after the transfer to let the CPU see data written by the device.
>
> riscv also invalidates the caches before the transfer, which does
> not appear to serve any purpose.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
> index 640f4c496d26..69c80b2155a1 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t=
 size,
>                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         case DMA_BIDIRECTIONAL:
> -               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         default:
>                 break;
> --
> 2.39.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
