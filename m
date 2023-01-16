Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222F066C51C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjAPQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjAPQBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:01:32 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFFB234C4;
        Mon, 16 Jan 2023 08:01:29 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id x7so14822528qtv.13;
        Mon, 16 Jan 2023 08:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yeeni+aVpCcW6b8lUXBeTt2zeTUBWlICjmBcGzWOK3E=;
        b=m0ShH6lP6szwI+O3m/SvSiDeqxdXgkA0CO0aQkMkKDgx//5EquIaEmjLcKVBTVU31H
         L8QF/YIBNXp3+9/OqTnY35yO4CujU4A9l363hXP/G8jn/tERZQQrsp3RNKi+epHepslo
         +g3o55sraX53FIvEbUE3OP2RcNFfcWY+8iG2uKi45Zyt7pbZIfRPT4Br+jMbHxhm8/Ng
         85i3d03JhWPjvUvbpMqe6/4SaJC0jBnY7PLTecBG4mEqx8NRJVjxY4epzCNBpKhkC2oe
         M8BCKwY3MelIWf2EdiPyf/jQ6j/wZ3QQ9s16GUGNcOSVqEJ6va7wcPJV/1xnOEBi/FuW
         bdPA==
X-Gm-Message-State: AFqh2kreNZ4DPJkehrvkPcDKAnGua4wY7ps0rFbiC5P08jAybYzGpknG
        DD/P00xywcqD5UfjNQFvt2SzlJeXmBrZeA==
X-Google-Smtp-Source: AMrXdXsgtPSo7WSVyH6gmIVfxsPOR9BQ+whspvw2CUZO1cq26DTdpyi1S4c1Qyvin/yhCyXBnkEQqg==
X-Received: by 2002:ac8:6609:0:b0:3b6:2fd2:84b5 with SMTP id c9-20020ac86609000000b003b62fd284b5mr7218005qtp.57.1673884888047;
        Mon, 16 Jan 2023 08:01:28 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id bb30-20020a05622a1b1e00b003aba8e9efdasm14687295qtb.4.2023.01.16.08.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:01:27 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id a9so14068378ybb.3;
        Mon, 16 Jan 2023 08:01:27 -0800 (PST)
X-Received: by 2002:a25:9012:0:b0:7b8:a0b8:f7ec with SMTP id
 s18-20020a259012000000b007b8a0b8f7ecmr35185ybl.36.1673884886896; Mon, 16 Jan
 2023 08:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com> <20221117114907.138583-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221117114907.138583-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jan 2023 17:01:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzkAjF=v__r2vJrYugBuDt13LnToCW66n-5r-jcVV+8A@mail.gmail.com>
Message-ID: <CAMuHMdUzkAjF=v__r2vJrYugBuDt13LnToCW66n-5r-jcVV+8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Thu, Nov 17, 2022 at 12:49 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> As per section 48.4 of the HW User Manual, IPs in the RZ/V2M
> SoC need either a TYPE-A reset sequence or a TYPE-B reset
> sequence. More specifically, the watchdog IP needs a TYPE-B
> reset sequence.
>
> If the proper reset sequence isn't implemented, then resetting
> IPs may lead to undesired behaviour. In the restart callback of
> the watchdog driver the reset has basically no effect on the
> desired funcionality, as the register writes following the reset
> happen before the IP manages to come out of reset.
>
> Implement the TYPE-B reset sequence in the watchdog driver to
> address the issues with the restart callback on RZ/V2M.
>
> Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Perhaps this logic can be incorporated into the RZ/V2M reset controller
driver later, so reset consumers don't have to care about TYPE-A and
TYPE-B reset, but can just call reset_control_reset()?
I understand that's not gonna be easy, as it needs to know about the
relation between resets and clocks, and how to handle both cases (clock
(not) switched off) for TYPE-B resets.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
