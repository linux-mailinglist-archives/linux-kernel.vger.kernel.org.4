Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E1727C0A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjFHJ6x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 05:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFHJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:58:51 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36D026B9;
        Thu,  8 Jun 2023 02:58:49 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bad05c6b389so527416276.2;
        Thu, 08 Jun 2023 02:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686218329; x=1688810329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzz3OZh3QB/d2SKcrr0d8uZ9dUBpMs9PB0O6tVeC/Ug=;
        b=hNJUcA2ydfjedY295HDN7qc51uPSU9rnzQd3dAd1mNy4ZUMGQjHLu0myksw3JQwBb0
         EuVzPqCcrOEIZAdojenozcEiUdZio4nb42oGV6KVYJ7xG0weJ6Et+nTCA/hs+VW6hFPu
         2d3nXk3DDZ7c+qDPA7I6pPoN/lpoAwCw+LM52ioh2Oqj+gUsDDeOLubM4XR8rfPIyqsZ
         7kjPrJhXQDbnlAzijEXN6ONGKw3G9Dz7AUzg395wNXfoRd5O2o6090XXKC/rhx7g6E7t
         HLM0Mizm0WHe+CsNu8eYPYTKtej39c5jzgl1uKfZBV5pGiXTg74jSN/ywKXU/VnTjnAq
         /FbA==
X-Gm-Message-State: AC+VfDy+F59A6py899IKrSSiMuSDgAeA9f9xj8lttjJpuz3lu2Vv/4hE
        yxjL3r+W+9Po1Cgd1r32f68FUrTGkGptrA==
X-Google-Smtp-Source: ACHHUZ4u46GNap8T+b+tokBe1BF3/Gt8dAsZjpMNWkmaXJGjLocTU6ogawm8QVNarzqjn911pNTxYg==
X-Received: by 2002:a81:6583:0:b0:56a:3b3e:bc7 with SMTP id z125-20020a816583000000b0056a3b3e0bc7mr5129485ywb.16.1686218328766;
        Thu, 08 Jun 2023 02:58:48 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id x23-20020a25acd7000000b00bb1d8f2a593sm185261ybd.45.2023.06.08.02.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:58:48 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bad05c6b389so527400276.2;
        Thu, 08 Jun 2023 02:58:48 -0700 (PDT)
X-Received: by 2002:a0d:dd47:0:b0:568:b0f6:ce8a with SMTP id
 g68-20020a0ddd47000000b00568b0f6ce8amr9980204ywe.24.1686218327937; Thu, 08
 Jun 2023 02:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230527164452.64797-1-contact@artur-rojek.eu>
 <20230527164452.64797-4-contact@artur-rojek.eu> <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
 <f7b9ceb9739f8ae5cbee4f6073ce3af3921a2540.camel@physik.fu-berlin.de>
In-Reply-To: <f7b9ceb9739f8ae5cbee4f6073ce3af3921a2540.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Jun 2023 11:58:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFBo+KMNQ6gzh3rZrZ+_Wfg=UJ4XOW4Uqibnjm6T7CdA@mail.gmail.com>
Message-ID: <CAMuHMdVFBo+KMNQ6gzh3rZrZ+_Wfg=UJ4XOW4Uqibnjm6T7CdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sh: dma: Correct the number of DMA channels in SH7709
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Jun 8, 2023 at 11:54 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2023-06-07 at 11:16 +0200, Geert Uytterhoeven wrote:
> > On Sat, May 27, 2023 at 6:45 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> > > According to the hardware manual [1], the DMAC found in SH7709 features
> > > only 4 channels.
> > >
> > > While at it, also sort the existing targets and clarify that
> > > NR_ONCHIP_DMA_CHANNELS must be a multiply of two.
> > >
> > > [1] https://www.renesas.com/us/en/document/mah/sh7709s-group-hardware-manual (p. 373)
> > >
> > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> > > ---
> > >
> > > v2: - sort existing targets
> >
> > Thanks for the update!
> >
> > >     - clarify that the value must be a multiply of two
> >
> > That's only true when there are two DMACs, right?
> >
> > Even in that case, you could mitigate that by avoiding the division by
> >
> >     #ifdef SH_DMAC_BASE1
> >    -#define        SH_DMAC_NR_MD_CH        (CONFIG_NR_ONCHIP_DMA_CHANNELS / 2)
> >    +#define        SH_DMAC_NR_MD_CH        6
> >     #else
> >     #define        SH_DMAC_NR_MD_CH        CONFIG_NR_ONCHIP_DMA_CHANNELS
> >     #endif
>
> Aren't we dropping SH_DMAC_BASE1 in the other patch anyway?

Only for the SH4 parts that do not have it.
It is still set in arch/sh/include/cpu-sh4a/cpu/dma.h for the SH4a parts with
12 channels and 2 DMACs.

> > That is actually safer, as the user can override NR_ONCHIP_DMA_CHANNELS
> > when configuring his kernel, thus breaking DMA  due to an incorrect
> > value of SH_DMAC_NR_MD_CH.
> >
> > Unfortunately we cannot protect against that when using a single DMAC,
> > as SH_DMAC_NR_MD_CH can be either 4, 6, or 8.
> >
> > Perhaps this configuration should be moved from Kconfig to <cpu/dma.h>,
> > to protect against a user overriding this value?
>
> Isn't SH_DMAC_NR_MD_CH already hardwired to the SoC being used?

It depends on CONFIG_NR_ONCHIP_DMA_CHANNELS, while it
should be fixed based on the SoC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
