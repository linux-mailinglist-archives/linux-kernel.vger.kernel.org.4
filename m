Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3A874D4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGJMLb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGJML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:11:29 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA5F4;
        Mon, 10 Jul 2023 05:11:28 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-57688a146ecso55270997b3.2;
        Mon, 10 Jul 2023 05:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688991087; x=1691583087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72Wm2+Haf42PppkDwX2AiSMrYpGiUC/lF3qyDG6asRc=;
        b=DY/+ByY0vdf8vg0p/U5eg96ZYFqoM40eAd2+UF7dTCNIBILYzfrYHpKOPvzLm4PJ1Y
         sh/SXoBH6X06fKGvFdViJaajjykc1MVu4yrU8QXxY4LGeIkSo4ihMlbGC65q//5/BJ5f
         +wa4NNCNNJwaSkwHKCZttbqe4kKbbqxfzflD1Kk8Xwkb3tCYkHBHa1ov0IIzGIUV8IJY
         HiOC/KzUpHY6wXJKAVQi+XQFTlCV1NdZboSYSPi0uQJ9yuCsAI3H1HSKrEMC+ik9459t
         NFPBWVWgDbysxtz3mwoMlcOL07Gqlf1SRdAE6eO1jiEEaeAsWxf3F77t3FJY/sphrhn+
         wIHw==
X-Gm-Message-State: ABy/qLa9cUeUUkYEELNnLmO3aLtGfmKjOaLTQMNfbN59Kj7O31ynfjcx
        eAzczfHfh6YleD6An/PSixJkSQa02ohYDg==
X-Google-Smtp-Source: APBJJlGbjUGhg6rEspeFw5o+Wkwl6HM9YmIQynaD/xfCeS7OS2iQklVvbtKsZaStJAg7qvbxWZVpNQ==
X-Received: by 2002:a0d:e208:0:b0:579:16e0:b1bf with SMTP id l8-20020a0de208000000b0057916e0b1bfmr11014023ywe.12.1688991087351;
        Mon, 10 Jul 2023 05:11:27 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id e8-20020a81e948000000b0057072e7fa77sm2974981ywm.95.2023.07.10.05.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:11:26 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c4dfe2a95fbso5164776276.3;
        Mon, 10 Jul 2023 05:11:26 -0700 (PDT)
X-Received: by 2002:a25:810f:0:b0:c62:9634:d39 with SMTP id
 o15-20020a25810f000000b00c6296340d39mr11075620ybk.52.1688991086188; Mon, 10
 Jul 2023 05:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230710032355.72914-1-frank.li@vivo.com>
In-Reply-To: <20230710032355.72914-1-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:11:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=HzoBKhq3raBrE2B8XxsnJCvBKt6hEP-X7ExuuD-LUw@mail.gmail.com>
Message-ID: <CAMuHMdU=HzoBKhq3raBrE2B8XxsnJCvBKt6hEP-X7ExuuD-LUw@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] drm/renesas: Convert to devm_platform_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 5:25 AM Yangtao Li <frank.li@vivo.com> wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
