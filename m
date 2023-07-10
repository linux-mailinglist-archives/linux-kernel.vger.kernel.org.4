Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B074D876
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjGJOF5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGJOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:05:56 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32DA118;
        Mon, 10 Jul 2023 07:05:53 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-577637de4beso58960217b3.0;
        Mon, 10 Jul 2023 07:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688997953; x=1691589953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=synEb8i0PbvXljWfEAZgODayCcLrTZV/b7Ul2k51+yA=;
        b=JVNs2zbe3fr7Y3BCKQuiJL7hAqUUAdBWKTkiRneDBfdhgum9pa8UFfXMvMkWKnpuBh
         i5KH8vDw5pWTfovmKz+C9TQyRgCLt4qCnxRJKR7Ag7NtbsP38gzcIi61yD93PnjTDTAz
         6O5CvhO6xd7ptDcLm2Ywg0H0whTDqmLSfmY86Ila8UrpWx/xVvYCu3SUqIUOoRszYUSc
         abnNvYYV8VFZNrqXeTM5skPEk7GlDoTwUqKh+SjAVRbMVejSXYRhVOzt1djmqOitvXpQ
         YW233nQAiDgwju8KVhFyF01/B/qg44066Zhj15OwWhbXRcUz8fTqqlYPJWth9dLknEib
         Yg5g==
X-Gm-Message-State: ABy/qLYA5Qgpl34WsnQ5YmuMgx70ujjwMDRIKIPeZPNuatvEH6GnSWK9
        UvQD9/6cVa7eZaMRszDXhOguvyYccO5RoQ==
X-Google-Smtp-Source: APBJJlH07AvbSS6c59KxRnJm5cPmjHve9MAJ7N9tcVasaP7S5YJV7sRsE4IWSCSoavtUQ1iho8v9Cg==
X-Received: by 2002:a81:520e:0:b0:57a:871e:f625 with SMTP id g14-20020a81520e000000b0057a871ef625mr2099388ywb.52.1688997952966;
        Mon, 10 Jul 2023 07:05:52 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id t127-20020a815f85000000b0057087e7691bsm3100342ywb.56.2023.07.10.07.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 07:05:52 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c2cf29195f8so5914908276.1;
        Mon, 10 Jul 2023 07:05:52 -0700 (PDT)
X-Received: by 2002:a25:d8c3:0:b0:c67:ebf3:b1fa with SMTP id
 p186-20020a25d8c3000000b00c67ebf3b1famr11128212ybg.31.1688997952651; Mon, 10
 Jul 2023 07:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 16:05:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6_Q+GDG=MRTkaH4O=un-owzkN_B-aCbKdo_F1=B1sTw@mail.gmail.com>
Message-ID: <CAMuHMdV6_Q+GDG=MRTkaH4O=un-owzkN_B-aCbKdo_F1=B1sTw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add missing pins for RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jun 30, 2023 at 2:04 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This patch series intends to incorporate the absent port pins P19 to P28,
> which are exclusively available on the RZ/Five SoC.

Are you sure these are not available on RZ/G2UL?
I thought RZ/Five and RZ/G2UL were identical, except for the ARM
vs. RISC-V CPU core (+ support)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
