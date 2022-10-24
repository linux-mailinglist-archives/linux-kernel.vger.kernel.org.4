Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF460AB05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiJXNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiJXNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:40:14 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF9BB1DE5;
        Mon, 24 Oct 2022 05:37:11 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id g16so5500035qtu.2;
        Mon, 24 Oct 2022 05:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm0DhlBuWerQb7STPnVGOSZg9+mGmS13MMZKjPmbxqM=;
        b=Q/AB1BYhsDYBQa6OHia4tBMxS5kFaaNnNAaL9kSIB1W1/Erz3cL1zI4Qkp1pkNn1Bh
         xEnBThJ78dQvIq5j0HmsbT6vQjODHTwrTIaWlO8m2A7cZkYZVFAssIB4XlQmCCBTv7FU
         VnEXx48B0hJmjrAkIdtznzkJL10q8i5uBttVuGUmMRV79184b7bybqi9SfXFLuerCZ06
         3/LfLWXnh3L3MPHaSdFWhhh5OTYNcu4emGTvlgqKi9D5SfRvqpqLzfSViwPG96jEGRYq
         wFlKfQ0i2gftTPdUMmSWmtElckgZMbeScH+gnLtEAH+7bftjeUYc67SRC4E7WsEOKsFo
         Z2tg==
X-Gm-Message-State: ACrzQf3QcLnnyrjYP3WnuZDdO6+BDxlJ2nfu4H7FryTWxKhBeD3INiVh
        4n+jhLmAWZXZPXX9w91S6dm56GIoliUtgQ==
X-Google-Smtp-Source: AMsMyM5UdJDhicPIDh14Z2dn+rdMdObB+vEnjqqgA6wMFX3s4h4griSYn69Mz4dVty+nt00y7v7Qog==
X-Received: by 2002:a05:622a:209:b0:39c:d88f:20ed with SMTP id b9-20020a05622a020900b0039cd88f20edmr26522356qtx.131.1666613258930;
        Mon, 24 Oct 2022 05:07:38 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006af0ce13499sm14952635qko.115.2022.10.24.05.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:07:38 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id r3so10771170yba.5;
        Mon, 24 Oct 2022 05:07:38 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr26765379ybb.604.1666613257924; Mon, 24
 Oct 2022 05:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221023182437.15263-1-afd@ti.com> <20221023182437.15263-3-afd@ti.com>
In-Reply-To: <20221023182437.15263-3-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 14:07:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAM8VkDeUWqikjHZz8703ho6Ft=eMgN69ktvJXSue+Pg@mail.gmail.com>
Message-ID: <CAMuHMdXAM8VkDeUWqikjHZz8703ho6Ft=eMgN69ktvJXSue+Pg@mail.gmail.com>
Subject: Re: [PATCH 2/6] kbuild: Allow DTB overlays to built into .dtso.S files
To:     Andrew Davis <afd@ti.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 8:24 PM Andrew Davis <afd@ti.com> wrote:
> DTB files can be built into the kernel by converting them to assembly
> files then assembling them into object files. We extend this here
> for DTB overlays with the .dtso extensions.
>
> We change the start and end delimiting tag prefix to make it clear that
> this data came from overlay files.
>
> [Based on patch by Frank Rowand <frank.rowand@sony.com>]
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
