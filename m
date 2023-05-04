Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2420A6F6810
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjEDJNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjEDJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:12:58 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749023ABF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:12:57 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-331643f4532so1952405ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1683191577; x=1685783577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+cBCuPemC9rnV8/QfSp10iYbH/9Adn653+lN+Obdqg=;
        b=YTbeCmGImxGvcLEuyfRZE5cMmqFs1C7MvVoUxmYjqrBcwYCW5hdd6Vs5090lxFVFvf
         ms6o/bOQuPW+RHlFflrZxWSNvNZfa2GTXN7kYDBnfp7UpeQb2uvOslAhscBflo4txXBK
         kH5qgmCiSEQLeVbqjiDAOmkjZ3M92AS3ZDKgHkR8SVesM7c6IXbaXJrlX+3k0bXWbSI6
         /2VI27NyGcrDQ4IhOLeL/VkQySMf/IEeUFwpMhrXJAlWpPDE6xpbRP+n4BdB8z6tZzWX
         AgrPwqBVi/lvENt1iHCHZNcLSad1iYfmSPgmhiDl1RlpwPuyrerZ7NBeDsUZWsRvqDBQ
         pZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683191577; x=1685783577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+cBCuPemC9rnV8/QfSp10iYbH/9Adn653+lN+Obdqg=;
        b=O17YlQ/BmM2K1uo35tQ2IpqtNMq5vFmU/VNoryArMPcnVD2ZmWhsxK528rHqFghOUR
         t98R5sdPdHyMVp++vqZrtWvriIZg9ycbLrpl9n3dGT3/ZkUEJDGSCgFDSXovd7GLvFQf
         H0T86ax5k0Kl5jW3AuWHotMpi77EgVyFbDvbljJMrF7Qem5gUkRlEc+C3bv4JyPrzQMt
         fnhqgEMVhnBFQiI33OwxP2STgNK8KBc6l5Ou1iPBhc50IBimAEfXTAAiJyYDsP+l4qd8
         iKfDhN9ctplA1r9RFn64vYbtae4ooSkh7gsqRP39zOzpTPT3z7RjHnKI9i0/mUFwqNDU
         t8dw==
X-Gm-Message-State: AC+VfDxGEHhdH4dEZyKEIP4sAlv/6S49hZ7T2ieXXDD4NFBA5EkXeCXB
        0nHTxvc6Rj62fgtB95iE80vMgsoWzNlAp5frPHeRgA==
X-Google-Smtp-Source: ACHHUZ7XzaFfYqsZ2DDqFN4AT6ORAT0qObZMB+f1YXKGsdQZ574TA025qZT7Zk/wE7euYGocFKi/txlwd67zHtlkOJo=
X-Received: by 2002:a92:c743:0:b0:331:3fe3:d111 with SMTP id
 y3-20020a92c743000000b003313fe3d111mr5296592ilp.25.1683191576814; Thu, 04 May
 2023 02:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230426074248.19336-1-zong.li@sifive.com> <mhng-cdb02a07-40f9-4424-b3cf-938247588537@palmer-ri-x1c9>
In-Reply-To: <mhng-cdb02a07-40f9-4424-b3cf-938247588537@palmer-ri-x1c9>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 4 May 2023 17:12:45 +0800
Message-ID: <CANXhq0r3+Wc3jZ7fVRS-RtVUTNM-tZjhvFO7qK_BmSCa4wdGyw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: xilinx: enable on RISC-V platform
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:28=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
>
> On Wed, 26 Apr 2023 00:42:48 PDT (-0700), zong.li@sifive.com wrote:
> > Enable the xilinx dmaengine driver on RISC-V platform. We have verified
> > the CDMA on RISC-V platform, enable this configuration to allow build o=
n
> > RISC-V.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/dma/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index fb7073fc034f..816f619804b9 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -695,7 +695,7 @@ config XGENE_DMA
> >
> >  config XILINX_DMA
> >       tristate "Xilinx AXI DMAS Engine"
> > -     depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> > +     depends on (ARCH_ZYNQ || MICROBLAZE || ARM64 || RISCV)
> >       select DMA_ENGINE
> >       help
> >         Enable support for Xilinx AXI VDMA Soft IP.
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Hi Palmer,
Thanks for your review.

Hi Vinod,
Could I know if this patch also meets your expectations? If it does,
would you please consider accepting it?
Thanks.
