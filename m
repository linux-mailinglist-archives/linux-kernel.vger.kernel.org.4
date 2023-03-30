Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BB06CFC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC3HHx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 03:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjC3HHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:07:51 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DA859FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:07:47 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-536af432ee5so339016517b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680160066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx/OPeSP/6JGscUKbwjWV1A44GfF+C/voNDzk4y2Gmk=;
        b=2weDzp8zhC4bhhVpwpMakjkft1DGB0tyYEVv0DYpcL4MZTK89hVzh3zQotROvbNq5b
         u93y3TmIwmqlgon+P5x8jNIJ1qtfxhuPdDGGYwvfz/DbnrBvQ8FGgSdzV7kLdzhxArWa
         er7fuvyvtWjyqPePoTLuwJHioVOluy/Zq+0hBFB7FYQVbxvQQOBqr3Ub2npdOGSJBSx1
         1T6LzyIFdlZASCRTSbYpYm8RLEQ0UmKNa9uReCSKE/vdpQp7Xm6k0MB0Eu/+/Vpe5sR3
         YmfRraXakYVynaKp11l8L18wwLqDrd3IRZqDr+ANgQ/inYveihJ2dcq17IwuyPnj5tak
         7Opw==
X-Gm-Message-State: AAQBX9fZXv/FkKAvoDS834J2QS9LAPRFRptFeKZuCUtKQf3IjvcQsFW8
        tyl5W8Z4AXzJSZOtEQQblPZlyHnef8xe3w==
X-Google-Smtp-Source: AKy350aZA+Y+P0T/bGPR5lTc2E24HqT7tEf/MS1kkX8RJWGXujNv2GQa2DLSdPCfbHdc8zZdBh3yag==
X-Received: by 2002:a0d:cb56:0:b0:527:abe5:8478 with SMTP id n83-20020a0dcb56000000b00527abe58478mr22570825ywd.10.1680160066423;
        Thu, 30 Mar 2023 00:07:46 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id y3-20020a814b03000000b0054629ed82f9sm655163ywa.83.2023.03.30.00.07.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:07:46 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5456249756bso338214427b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:07:45 -0700 (PDT)
X-Received: by 2002:a81:a7c4:0:b0:546:264:a375 with SMTP id
 e187-20020a81a7c4000000b005460264a375mr5797313ywh.4.1680160065429; Thu, 30
 Mar 2023 00:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230329071405.1568021-1-geert+renesas@glider.be> <ZCTOxOGDPoJoZDNW@infradead.org>
In-Reply-To: <ZCTOxOGDPoJoZDNW@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Mar 2023 09:07:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWV0GzA91MNuZVqs1B_8jry=fUGPgL4hSxtGLNF=Gj1Sw@mail.gmail.com>
Message-ID: <CAMuHMdWV0GzA91MNuZVqs1B_8jry=fUGPgL4hSxtGLNF=Gj1Sw@mail.gmail.com>
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Desnes Nunes <desnesn@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        noreply@ellerman.id.au, Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, Mar 30, 2023 at 1:50 AM Christoph Hellwig <hch@infradead.org> wrote:
> I've applied this as it is the first fix I got into my mailbox for it.

Thank you!

> Arnd sent one a little later, which uses %pap instead of %pa, which
> confused me a bit.  The documentation seems to allow both without
> any recommendation which one to use, which confuses me even further.

The "%pa" class supports two variants: "%pad" (for dma_addr_t) and
"%pap" (for phys_addr_t). "%pa" is a shortcut for the latter, cfr.
https://elixir.bootlin.com/linux/latest/source/lib/vsprintf.c#L1792

The default exists because "%pa" was fist, cfr. commit aaf07621b8bbfdc0
("vsprintf: add %pad extension for dma_addr_t use"), and I don't think
we can easily remove it. The default is shorter (saves one byte, even
compared to %llx"), so why not use it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
