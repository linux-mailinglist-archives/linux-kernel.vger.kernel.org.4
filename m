Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231A16FAEAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjEHLql convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjEHLq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:46:26 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A923EF80;
        Mon,  8 May 2023 04:46:13 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-b9e27684b53so3855593276.0;
        Mon, 08 May 2023 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546372; x=1686138372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxzntl2vCSjynso5+OwUtZ2MCoVRvOy6diVTHHVIE0g=;
        b=Y5SxeZrTjL0WpkdTUj/aKNzXk6ncUAwFEZ3nLcA+uBYk/K6E+U0+GTDZTonvpVJUwx
         b+8Ix1MdP+0zxYC1yghKtT2M+NxdXfacugSmxvOl2j/s++Q6N4YnivsA3jmT/tKOtfoH
         egFb5VNjGus0v7QmJeo1KxAylpg3HP0wogj0550jAyv2U0ruwozD2GjxA3tayk4iBGlr
         EVUjTSW/Qo+6uTXbq+sxbGisqng2+hvVBao1oNs+enFVZVrPnhXWvHbOgAsR9f3LvlHY
         jEfZXbkwbYSbkPZ+995VVJQ21jcy+zU63CDIWC/tMNow5WXRpNAv5wZGpuBJehiVRlL/
         X90Q==
X-Gm-Message-State: AC+VfDyhxAc37/QpmV6kO0thIvyTxG5GRrJEt4qs5ZJLkhf5jsx7r2qc
        cgJAwQl6act76GJdpAXcCJped4cGLPCB4Q==
X-Google-Smtp-Source: ACHHUZ6X5Ri1ne6fVM6AmoeOclgQW+V9R7kx1nuBYlWR5vNK4Pd0bZZBR5y1mcP2iXLFqA+RZ5E19A==
X-Received: by 2002:a25:addf:0:b0:b96:52f0:9ba3 with SMTP id d31-20020a25addf000000b00b9652f09ba3mr11103511ybe.11.1683546372098;
        Mon, 08 May 2023 04:46:12 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id w6-20020a258506000000b00b9e9286f1e6sm2221026ybk.55.2023.05.08.04.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:46:11 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55a5a830238so38994427b3.3;
        Mon, 08 May 2023 04:46:11 -0700 (PDT)
X-Received: by 2002:a0d:d54d:0:b0:55a:7722:1401 with SMTP id
 x74-20020a0dd54d000000b0055a77221401mr11012997ywd.31.1683546371412; Mon, 08
 May 2023 04:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230506141703.65605-1-contact@artur-rojek.eu>
 <20230506141703.65605-2-contact@artur-rojek.eu> <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
 <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu> <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
 <3687ad9134f6869a479b94f821f92aefd41bd449.camel@physik.fu-berlin.de>
In-Reply-To: <3687ad9134f6869a479b94f821f92aefd41bd449.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 May 2023 13:46:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMyRz2NGrjOZtcLL4udwfvFyJ3zhLnQMoPtLzMCBa32g@mail.gmail.com>
Message-ID: <CAMuHMdWMyRz2NGrjOZtcLL4udwfvFyJ3zhLnQMoPtLzMCBa32g@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg` macros
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

On Mon, May 8, 2023 at 1:28 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2023-05-08 at 13:20 +0200, Geert Uytterhoeven wrote:
> > Looks like this is still broken on e.g. SH7751R, which has 8 channels,
> > both handled by a single DMAOR register at offset 0x40...
> >
> > While e.g. dma_base_addr() seems to have some provision for this
> > (cfr. the "chan >= 9" (not "8") check), dma_find_base() will fail, as
> > arch/sh/include/cpu-sh4/cpu/dma.h defines SH_DMAC_BASE1.
> > Anyway, that's not new, so I have no objection to your patch.
>
> Was SH7751R broken by 7f47c7189b3e8f19 as well?

I think so.
Before, the code to use 1 or 2 DMA engine relied on the presence of
DMAE1_IRQ, which is/was defined in arch/sh/include/cpu-sh4a/cpu/dma.h,
but not in arch/sh/include/cpu-sh4/cpu/dma.h.

It might be sufficient to fix this by just dropping the SH_DMAC_BASE1
definition from arch/sh/include/cpu-sh4/cpu/dma.h.  I'm actually
wondering why it was added (in commit 71b973a42c545682 ("sh: dma-sh
updates for multi IRQ and new SH-4A CPUs.")), because it looks like
none of the SH4-based (not SH4A!) SoCs have a second base...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
