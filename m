Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB28642591
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLEJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiLEJQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:16:23 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461CF273;
        Mon,  5 Dec 2022 01:16:22 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id d2so7791200qvp.12;
        Mon, 05 Dec 2022 01:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyWCZnYLtOpzCElMxniM5SYUnr8uSBt4bLG5wCjERpo=;
        b=rZOODn0SFOY2LGd8dtqvolPAwBKI6Ek2Lb39XDpfhoBxES9pddUEpyBzh+1c+bHdB6
         UcNz/hLWWtJmbwBaGqJsSf63yl03ETGwKA+1RO9LL3lsSn9xT9YmR2ZL4pn/rBR6G7Bt
         MFOJqbKKoHLq/lxSnWAF9M/SuvCXlFt9Y2YnOEr1KfSBAkFY5sdFg0TaJtjrCrWOegST
         Qgno0lxz7MngbmIi9c4iq+g4lBnzzqBWXPswikeAQyLFaROuo1eFbx5LA3r3HU3RQ69h
         eRA0CKaMVXnTKW6Yb95fT/qZMaNvZBQELhAF9pBFZq+sH89GLyI1XaHq5GTS6z6wEQRF
         3ecw==
X-Gm-Message-State: ANoB5pkktG98FurrUOsUvZ2W/blsVGHVodbOQ7rNIanFi8yEWvcd17IM
        Cp2M73fw+NkRhAz3WvvVw2xpRM/BD/kF8w==
X-Google-Smtp-Source: AA0mqf5etMc+4zCKD2gCb1qv1zV+YC52T/Bl6SE6cIxNwi7yQ5prUjPJppvhOVXYJ0aMQR+MnzhBJg==
X-Received: by 2002:a0c:ff28:0:b0:4bb:798d:879c with SMTP id x8-20020a0cff28000000b004bb798d879cmr56733945qvt.7.1670231781231;
        Mon, 05 Dec 2022 01:16:21 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a424900b006fc2f74ad12sm12133280qko.92.2022.12.05.01.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 01:16:20 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id y135so9099272yby.12;
        Mon, 05 Dec 2022 01:16:20 -0800 (PST)
X-Received: by 2002:a25:d655:0:b0:6fc:1c96:c9fe with SMTP id
 n82-20020a25d655000000b006fc1c96c9femr17074822ybg.36.1670231780461; Mon, 05
 Dec 2022 01:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20221201095631.89448-1-tomi.valkeinen+renesas@ideasonboard.com> <20221201095631.89448-4-tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <20221201095631.89448-4-tomi.valkeinen+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Dec 2022 10:16:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeaZtrm7ohX4O0CGcam+1eDrtSvcqvhwoPbg3zOOgZcA@mail.gmail.com>
Message-ID: <CAMuHMdVeaZtrm7ohX4O0CGcam+1eDrtSvcqvhwoPbg3zOOgZcA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] clk: renesas: r8a779g0: Add display related clocks
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 10:56 AM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> Add clocks related to display which are needed to get the DSI output
> working.
>
> Extracted from Renesas BSP tree.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
