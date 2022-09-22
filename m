Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651B45E62D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiIVMvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIVMvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:51:41 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F8E11D5;
        Thu, 22 Sep 2022 05:51:40 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id c6so6702881qvn.6;
        Thu, 22 Sep 2022 05:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1IX5rDJUB9B6ypTnX4DvDDFVPLxK4WN5mvStRFZFjD0=;
        b=xBKfamC7vby92JRWleg62eNt5uMcOo+UXTESUt9WP5nU6IjHc0AKcoC2Y/6udybgV7
         CM0SAIRebr2TM/ikU6bjvnDJ4NEmvu48A+IASeIdGs8P+nIGUGBBUG1esXjdFrL4FkEt
         aRtLzzIedho/SpyzS0waf5a9HR4qpqfbgcde6OGXH/A50yDc39r+vKwbK/gmBZu0Z+aT
         lA7RQ/oHKSRrUXuLl45DI+saiG3bJ0n1Rsbrbw6bpQm5ubp2AmaZ/F9hJ+LYu4tTORPF
         yqIWaL3yipgvZvZrQB1OF7JWub+EgIK86guQg0GFdBY5wJRJjq2wzObcWJU5ofuW+kTY
         uDXA==
X-Gm-Message-State: ACrzQf0nexWtbU2snwfCRvKl6uRwpln5AMBSqoc+hYMNrm3kTT914Cg1
        y+WSy7uQNQrKWJKMcDFa6jqzQr5CiGqbWw==
X-Google-Smtp-Source: AMsMyM4oSAp6q1umZdNWOg5TiQlj2G6FOZ8MJ8k8TiyMF0oeNpasv1R1mGT7EPzvspfUjMcpeZJpIA==
X-Received: by 2002:a05:6214:27c6:b0:4ac:94f9:c727 with SMTP id ge6-20020a05621427c600b004ac94f9c727mr2246920qvb.51.1663851099473;
        Thu, 22 Sep 2022 05:51:39 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id y17-20020a37f611000000b006b5cc25535fsm3589864qkj.99.2022.09.22.05.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 05:51:39 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3452214cec6so97752927b3.1;
        Thu, 22 Sep 2022 05:51:38 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr2797113ywe.283.1663851098623; Thu, 22
 Sep 2022 05:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yys4CRNnKP3LXyAO@pendragon.ideasonboard.com> <CA+V-a8uiT9rV=T6LmFovRwULf3SO=JKdqr1yacAqN8gJmv9VPw@mail.gmail.com>
 <YyxWOuWOrYmMexNj@paasikivi.fi.intel.com>
In-Reply-To: <YyxWOuWOrYmMexNj@paasikivi.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Sep 2022 14:51:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKz56jxw56fXa7CMh_y4MVYiUT25dqRntJw6481s1FWw@mail.gmail.com>
Message-ID: <CAMuHMdXKz56jxw56fXa7CMh_y4MVYiUT25dqRntJw6481s1FWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 2:34 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On Thu, Sep 22, 2022 at 01:08:33PM +0100, Lad, Prabhakar wrote:
> > > > * Switched to manually turn ON/OFF the clocks instead of pm_runtime so that
> > > >   the mipi/dhpy initialization happens as per the HW manual
> > >
> > > That doesn't look right. The driver doesn't use runtime PM anymore, so
> > > power domains may not be handled properly. What was the problem with
> > > clock handling using runtime PM ?
> > >
> > If we use the runtime PM all the clocks will be turned ON when we call
> > pm_runtime_resume_and_get() which I dont want to. As per the "Starting
> > reception for MIPI CSI-2 Input" section 35.3.1 for example we first
> > need to turn ON all the clocks and later further down the line we need
> > to just turn OFF VCLK -> Enable Link -> turn ON VCLK. Due to such
> > cases I have switched to individual clock handling.
>
> If that is the case, then you should control just that clock directly,
> outside runtime PM callbacks.
>
> Runtime PM may be needed e.g. for resuming a parent device.

Exactly.
So probably you should not consider R9A07G044_CRU_VCLK a PM clock,
i.e. you need changes to rzg2l_cpg_is_pm_clk() to exclude it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
