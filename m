Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36826FB3E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjEHPdP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 11:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjEHPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:33:11 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B456072A4;
        Mon,  8 May 2023 08:33:09 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-55a14807e4cso83651217b3.1;
        Mon, 08 May 2023 08:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683559989; x=1686151989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X96dgxdvJ9o915QcPKTh2Rv+glavrTF5xrnJD83Sv1c=;
        b=a0XYhZBowQ2YJcTXmc29kz9I2z13FVYGp4wAxo6luNEMLRB5Rk35jdTAiGNYgUXmoC
         oKQhi9lyy17Y8iwd9soh/SLzlJQhH9kYYIuGiV8VZkn4Lo4ZVnEdWD63VjjiwOhcECAr
         XUvUDHiefpnPvFGJJ7hINwU+tWQWBg2MyvWg6dB2O14ttLhGop7m64RNjzpn/CpbWcwC
         Gc9hZTdJYYcgGMsSYSCNGCEN6FSX4GFCAiK0V16YGXqu7FxLVMpviDVWUNJdtfxHbJca
         KCLE7BR0QGIVM6C9jr2RFzaZ4ij0J9/Kuf8CdggyHBLKp1ct+Xt13ve70HbFIt3W+/7w
         MxKg==
X-Gm-Message-State: AC+VfDwICd6Bun43D5A586PrJ+W1c6xISOBDZIyzn9mY3YbjlA/QDEBW
        Ry365lqV8bFWnNzmId9QDSbazJZ9s6KTNw==
X-Google-Smtp-Source: ACHHUZ49tK3mrWF9CJCPX3xFqHREX5m+xJH/Bq65RRlJfljHLjvCwrtMJuUU0CZI7KLi1tZwykPlxQ==
X-Received: by 2002:a81:5b54:0:b0:559:f52b:7c5f with SMTP id p81-20020a815b54000000b00559f52b7c5fmr11630673ywb.17.1683559988518;
        Mon, 08 May 2023 08:33:08 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id p6-20020a815b06000000b0055a679f1d91sm2605025ywb.32.2023.05.08.08.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 08:33:07 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-b9a7e639656so7310740276.0;
        Mon, 08 May 2023 08:33:05 -0700 (PDT)
X-Received: by 2002:a25:5015:0:b0:ba2:6aea:2b8 with SMTP id
 e21-20020a255015000000b00ba26aea02b8mr5025776ybb.3.1683559985056; Mon, 08 May
 2023 08:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
 <20230508115727.2597864-1-geert@linux-m68k.org> <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
 <mafs035466ebk.fsf@amazon.de>
In-Reply-To: <mafs035466ebk.fsf@amazon.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 May 2023 17:32:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVaeS_j5=o7Nu5oh8pOY4uggTpy2yd9P9yGMu6iNWiEWQ@mail.gmail.com>
Message-ID: <CAMuHMdVaeS_j5=o7Nu5oh8pOY4uggTpy2yd9P9yGMu6iNWiEWQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.4-rc1
To:     Pratyush Yadav <pratyush@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-um@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        sparclinux@vger.kernel.org
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

Hi Pratyush,

On Mon, May 8, 2023 at 5:19 PM Pratyush Yadav <pratyush@kernel.org> wrote:
> On Mon, May 08 2023, Geert Uytterhoeven wrote:
> > On Mon, 8 May 2023, Geert Uytterhoeven wrote:
> >> Below is the list of build error/warning regressions/improvements in
> >> v6.4-rc1[1] compared to v6.3[2].
> >>
> >> Summarized:
> >>  - build errors: +9/-16
> >>  - build warnings: +1/-1439
> >>
> >> Happy fixing! ;-)
> >>
> >> Thanks to the linux-next team for providing the build service.
> >>
> >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ac9a78681b921877518763ba0e89202254349d1b/ (all 152 configs)
> >> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/457391b0380335d5e9a5babdec90ac53928b23b4/ (all 152 configs)
> >>
> >>
> [...]
> >
> >>  + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27
>
> Hmm, I don't get why we get this warning. Line 495 is in
> s25fs256t_post_bfpt_fixup(). It declares 'op' and then it does
>
>     op = (struct spi_mem_op)
>         CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
>                       SPINOR_REG_CYPRESS_ARCFN, 1,
>                       nor->bouncebuf);
>     ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
>
>
> which initializes 'op' before using it. Same with line 364 which is in
> the function cypress_nor_set_addr_mode_nbytes().

I suspect gcc-12 became stricter, and not all members of the union
are initialized.

> Even the compiler warnings [0] don't seem to make much sense to me:
>
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c: In function 's25fs256t_post_bfpt_fixup':
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c:495:27: error: 'op' is used uninitialized [-Werror=uninitialized]
>     495 |         struct spi_mem_op op;
>         |                           ^~
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c:495:27: note: 'op' declared here
>     495 |         struct spi_mem_op op;
>         |                           ^~
>
> [0] http://kisskb.ellerman.id.au/kisskb/buildresult/14922057/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
