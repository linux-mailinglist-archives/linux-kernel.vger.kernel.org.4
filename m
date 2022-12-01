Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648F163EC99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLAJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLAJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:34:39 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC363D44;
        Thu,  1 Dec 2022 01:34:39 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id x18so754138qki.4;
        Thu, 01 Dec 2022 01:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBTb30FlOeNn7g2bMTV3z6C876wmi9foz5yxG1pCxwA=;
        b=cIkffSYNj+lR5XPnGWNSE9BLoeq8tPsP+lBxdVEyxonvO5XKd/FVXiOFztc9CwawBk
         MixtOQlA3RjWv9VSXVUqmJVFQRF/LEZ66LTZ4v+ogqGrmvpoBYWCUAQL2hlpFUbA3O5d
         eFPOrLVC30XkPFbhKM24CA4GNL0/BrgIlHVUjTR87ug9ypwkdZ/4kQZNg0zvwgldP1P6
         8+lIPxRkTnKk96DTldVCHPUjKzwEb6Zjo3ZOsQ9AVHkxCgaIc7OTzvlfVn5bmgfZ8DRy
         Fh9Ct8E8XdEWKwr5E6vNG7T2VpoUjP1vKmW3EJOsBWgrujPR878sBjE06otvEgreZXXo
         X8fQ==
X-Gm-Message-State: ANoB5plNl6YYpzJNW/8wBpf/2NkUN5pV4d44RJUvq68BPhwXomFzzh5c
        iNa74DHfq2L3oc8LobYv6DpEoz59T7ctrA==
X-Google-Smtp-Source: AA0mqf6LLfjwiaggCZ/1FW7LsdSS+7kJgBjyq77M79yBM0vx4Obz/RWO3iruUETJNmNnL/f79njJiw==
X-Received: by 2002:a05:620a:d48:b0:6fc:a8ae:492a with SMTP id o8-20020a05620a0d4800b006fca8ae492amr689635qkl.340.1669887277998;
        Thu, 01 Dec 2022 01:34:37 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l27-20020ac84cdb000000b00399fe4aac3esm2227797qtv.50.2022.12.01.01.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 01:34:37 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id i131so1273660ybc.9;
        Thu, 01 Dec 2022 01:34:36 -0800 (PST)
X-Received: by 2002:a25:9:0:b0:6f9:29ef:a5ee with SMTP id 9-20020a250009000000b006f929efa5eemr10068854yba.380.1669887276592;
 Thu, 01 Dec 2022 01:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
 <20221123065946.40415-4-tomi.valkeinen+renesas@ideasonboard.com>
 <CAMuHMdUjCS6q44XmTanu=R68GyuVECLa0B-1AFg1CUD_oV4DuA@mail.gmail.com> <cb85e1f4-2292-19d4-2b7e-f16c1b43d29f@ideasonboard.com>
In-Reply-To: <cb85e1f4-2292-19d4-2b7e-f16c1b43d29f@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Dec 2022 10:34:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXH+CfOMtnPUecfAW9U7+WugbytkG5_P-wu=bk6JygLGg@mail.gmail.com>
Message-ID: <CAMuHMdXH+CfOMtnPUecfAW9U7+WugbytkG5_P-wu=bk6JygLGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] clk: renesas: r8a779g0: Add display related clocks
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
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

Hi Tomi,

On Thu, Dec 1, 2022 at 10:06 AM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> On 30/11/2022 21:18, Geert Uytterhoeven wrote:
> > On Wed, Nov 23, 2022 at 8:00 AM Tomi Valkeinen
> > <tomi.valkeinen+renesas@ideasonboard.com> wrote:
> >> Add clocks related to display which are needed to get the DSI output
> >> working.
> >>
> >> Extracted from Renesas BSP tree.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > Not that all of this matters a lot: all of these parents are always-on,
> > and I think "dis0" is the only clock where we care about the actual
> > clock rate?
>
> No, of the clocks added above, in the drivers we only care about the
> dsiref rate. That's used for the DSI PLL, and that PLL is used as the
> DU's pclk.

IC. As the DU node has only a single clocks property, I thought that
clock is used to derive the pixel clock from.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
