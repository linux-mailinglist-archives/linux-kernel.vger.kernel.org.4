Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB086288D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiKNTEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiKNTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:04:00 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58481839D;
        Mon, 14 Nov 2022 11:03:57 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id z17so8031232qki.11;
        Mon, 14 Nov 2022 11:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbBWqu7EwIcfg7tWgn9JDFpx91torOus7W6SwljXq88=;
        b=lJ9Q4uee/HzkRxjbvCwPm2xFBpCmpFCUeaYw++l41pM0WDT53fCUsI1AccI/L3Y0y1
         9ktg2NfapBhW3Y1PCyo2oZr05V+xN/P28tlQsI30uHV4PH/lfvwjXVHK4oQTycqO7AHu
         b9HV1GTlJ+KciSXmYdZ3IVel1Ota0N0nOEdGFhbCoUjL0+zapFWvHMYMnqjMcedvNDCF
         /1jMwrS2rHfBBR1sa3uj2ObU9InIyUPxKTz/c2xQCLI+KD8QSx5iTLb0QgOFmRfREq5L
         9UoBnA1vWHacJGAkX3KUVXATwNUvETFX8jKvr6WZXJgDK2ytEHolnQ4zWRf2y+wY/N1C
         4CVQ==
X-Gm-Message-State: ANoB5pk174GhQCCYGtVSlwtdhGsPOOjymjlVbe3LAO+rPDQYmvLhBJoO
        zH5G+xaMQ6Z+R2VL0guCSXAXZpwnIZ7dsQ==
X-Google-Smtp-Source: AA0mqf4ITEjo6jQO8XKELHrzCh2INu8TYfVF/goDiWs0XnbDf4C6bNnCy8cjhGGDd+3lbJL8q7Ui2A==
X-Received: by 2002:a37:89c4:0:b0:6f8:1e94:ffbd with SMTP id l187-20020a3789c4000000b006f81e94ffbdmr12587445qkd.539.1668452636605;
        Mon, 14 Nov 2022 11:03:56 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id r17-20020ae9d611000000b006ee7e223bb8sm6967561qkk.39.2022.11.14.11.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 11:03:55 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-376596ae449so115854177b3.5;
        Mon, 14 Nov 2022 11:03:55 -0800 (PST)
X-Received: by 2002:a81:4dc3:0:b0:370:61f5:b19e with SMTP id
 a186-20020a814dc3000000b0037061f5b19emr13890254ywb.316.1668452635372; Mon, 14
 Nov 2022 11:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 20:03:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
Message-ID: <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Mon, Nov 14, 2022 at 7:42 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 14 November 2022 18:09
> > To: Geert Uytterhoeven <geert+renesas@glider.be>; Wim Van Sebroeck
> > <wim@linux-watchdog.org>; Guenter Roeck <linux@roeck-us.net>; Philipp Zabel
> > <p.zabel@pengutronix.de>; linux-watchdog@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > Prabhakar <prabhakar.csengg@gmail.com>; Biju Das
> > <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>
> > Subject: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
> > clocks
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn't
> > reset the system. To fix this we make sure we issue a reset before putting
> > the PM clocks to make sure the registers have been cleared.
> >
> > While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as we were
> > calling the same functions here.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Note,
> > - This patch has been tested on RZ/G2L, RZ/V2M and RZ/Five.
> > - My initial investigation showed adding the delay after
> > pm_runtime_get_sync()
> >   also fixed this issue.
> > - Do I need add the fixes tag ? what should be the operation PUT-
> > >RESET/RESET->PUT?
>
> It looks like timing issue, None of the previous devices are affected by this.

To me it looks like the device must be clocked for the reset signal
to be propagated?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
