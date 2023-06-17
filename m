Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3968734070
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjFQLJ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 17 Jun 2023 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjFQLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 07:09:25 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9B172A;
        Sat, 17 Jun 2023 04:09:25 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-be49e41a3d6so1303230276.1;
        Sat, 17 Jun 2023 04:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687000164; x=1689592164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma2ohXdKWjjObauQDSrmhCjbdpKidVQlMZ34Z0kZwiE=;
        b=k5I7pH9qIn0Cll61CKGkRyHSSBkUh5QTqYkz3j4ZqFtI7FEO6JRtSqjFo4fA+yVo4X
         XFhxJ38O93rCRPrx81mVnQ6kg6HyjlOoSbrRS+Rh+GG/fiXb+N3JY6f1+wfuKdVw1MwV
         /+zcKP36mpYvBgcZEDNKyRRbRiKlqrCIIA3G7XzXJRM/m/VzCD+AXipbBpMOUii2bfgB
         ZOijHOKbQyWRyZKNy+E9OXfXHQAq4xN/qdu8DE9U/heH0Qw84cNaK9XbwfcSRWS9CFyE
         EfenebNTXRgPiMuKuvNGfE2LvuQadel+1wJpTdqNVbMs/GHE4F8IRt7ptMqluYhaF5Ks
         Ww0g==
X-Gm-Message-State: AC+VfDxZRWckjPKXXV5SqwOt3y7iXl2qcN79z53MPPWmTLfqg5g41Zsz
        axrI+RkZQipNAtZUo4Fy9xhXFvQxmG18zA==
X-Google-Smtp-Source: ACHHUZ5Y/pYgk5ucg8HwGRJxY+NblBL9zjJdCXIufrkqCP3bvSEqTEgLzYTRE4oVwoxhTTOW30PCow==
X-Received: by 2002:a25:fc10:0:b0:bb1:5628:59ee with SMTP id v16-20020a25fc10000000b00bb1562859eemr1400672ybd.28.1687000164051;
        Sat, 17 Jun 2023 04:09:24 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id b13-20020a5b0b4d000000b00bcb4ac1fbc6sm2868049ybr.30.2023.06.17.04.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 04:09:23 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bcad7f7dabcso1479716276.0;
        Sat, 17 Jun 2023 04:09:23 -0700 (PDT)
X-Received: by 2002:a25:2404:0:b0:bc7:f83f:92f4 with SMTP id
 k4-20020a252404000000b00bc7f83f92f4mr1344930ybk.39.1687000163316; Sat, 17 Jun
 2023 04:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230527164452.64797-1-contact@artur-rojek.eu>
 <20230527164452.64797-4-contact@artur-rojek.eu> <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
 <f7b9ceb9739f8ae5cbee4f6073ce3af3921a2540.camel@physik.fu-berlin.de>
 <CAMuHMdVFBo+KMNQ6gzh3rZrZ+_Wfg=UJ4XOW4Uqibnjm6T7CdA@mail.gmail.com>
 <8205bc2cb9f983914ff6920deed3f54893713ba0.camel@physik.fu-berlin.de> <d5667e9675bf8be35b1a5414d443b8f371b1bd9e.camel@physik.fu-berlin.de>
In-Reply-To: <d5667e9675bf8be35b1a5414d443b8f371b1bd9e.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 17 Jun 2023 13:09:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=kc1sZfsBad99ofbUBUyuZ_fAekdkFJYp9Rhskf9xWg@mail.gmail.com>
Message-ID: <CAMuHMdV=kc1sZfsBad99ofbUBUyuZ_fAekdkFJYp9Rhskf9xWg@mail.gmail.com>
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

On Sat, Jun 17, 2023 at 9:32 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2023-06-08 at 12:03 +0200, John Paul Adrian Glaubitz wrote:
> > > > > That is actually safer, as the user can override NR_ONCHIP_DMA_CHANNELS
> > > > > when configuring his kernel, thus breaking DMA  due to an incorrect
> > > > > value of SH_DMAC_NR_MD_CH.
> > > > >
> > > > > Unfortunately we cannot protect against that when using a single DMAC,
> > > > > as SH_DMAC_NR_MD_CH can be either 4, 6, or 8.
> > > > >
> > > > > Perhaps this configuration should be moved from Kconfig to <cpu/dma.h>,
> > > > > to protect against a user overriding this value?
> > > >
> > > > Isn't SH_DMAC_NR_MD_CH already hardwired to the SoC being used?
> > >
> > > It depends on CONFIG_NR_ONCHIP_DMA_CHANNELS, while it
> > > should be fixed based on the SoC.
> >
> > I agree. However, I would be fine with merging this patch set first and fixing
> > this particular issue in a follow-up series.
>
> So, my suggestion is to take this series as-is for 6.5, then get the other issues
> you mentioned fixed for 6.6. I think it's already a gain when these issues are
> fixed and the kernel boots on the HP Journada 680 again.

Sure, I don't want to block the acceptance of this series at all.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
