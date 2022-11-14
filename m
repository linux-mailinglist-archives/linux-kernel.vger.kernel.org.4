Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC56281CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiKNOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKNOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:00:25 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064519FD6;
        Mon, 14 Nov 2022 06:00:25 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id x13so7794645qvn.6;
        Mon, 14 Nov 2022 06:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgcb91s2dt67CNb/h/jC4e6cUIsKNgCDgXmKk0U/nWQ=;
        b=hwEuzU5J8yikUD8aJRnMHJb0QP7apmleFcbSGAkONwiLwhoFarXI9lzXY90JHSDVdQ
         1M2nQNaG6HydNU/kh/L1J//erwNMNHDysBhuuPcRcSV6MYQ41RHPm0cm+mH91Tvhlk2H
         NN8tBSf2It8cGMwWchdsBHstuvMFam7eEjH2Er8XCg2V7ksahYHH7K/0rxErYfHOiuXS
         tj6fu8nvJZh4l5tFrty6RIf5sqi1I13KaQ7/tdC/qdwgdPJqoSQKRfCip7471nMuTPwh
         eYfZT8JI/WK6lMqZ3n0pp2YSYZJWWpDAKOseZQqugZXIjUgu/wpDCoOr+KPRA+zXD5Pa
         23tg==
X-Gm-Message-State: ANoB5pmAtByWgdzETmdxJc5WjZs7+9Io/NGHAtW49aOXjexG1jzUf1Ic
        3MLQ4ZymBjG96xETRJxY33MmKkQjOHahYg==
X-Google-Smtp-Source: AA0mqf7po8+D17d3cgqFPr/Jzw0wrIfeQpZXmYk1MeWxqSbJsQ2az3XIUyQPrfTrBLzNmK5LZANlSQ==
X-Received: by 2002:a0c:fa0f:0:b0:4b4:7ac1:aa38 with SMTP id q15-20020a0cfa0f000000b004b47ac1aa38mr12632722qvn.84.1668434423609;
        Mon, 14 Nov 2022 06:00:23 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b006f3e6933bacsm6387130qkb.113.2022.11.14.06.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:00:23 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-37063f855e5so106876007b3.3;
        Mon, 14 Nov 2022 06:00:23 -0800 (PST)
X-Received: by 2002:a81:a085:0:b0:37e:6806:a5f9 with SMTP id
 x127-20020a81a085000000b0037e6806a5f9mr7816378ywg.47.1668434409494; Mon, 14
 Nov 2022 06:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com> <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 14:59:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUWbT6VArm9B56VE0yUYWCTm=3vMGrrONSv9cdsQQnhpg@mail.gmail.com>
Message-ID: <CAMuHMdUWbT6VArm9B56VE0yUYWCTm=3vMGrrONSv9cdsQQnhpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
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

On Thu, Nov 3, 2022 at 11:40 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The setting for the RZ/V2M watchdog cannot be changed once
> the watchdog has been enabled, unless the IP gets reset.
> The current implementation of the restart callback assumes
> that the watchdog is not enabled, but that's not always the
> case, and it leads to longer than necessary reboot times if
> the watchdog is already running.
>
> Always reset the RZ/V2M watchdog first, so that we can always
> restart quickly.
>
> Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
