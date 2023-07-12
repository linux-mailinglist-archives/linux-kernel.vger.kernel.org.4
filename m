Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26CD750A96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjGLOP5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjGLOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:15:55 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747510C2;
        Wed, 12 Jul 2023 07:15:54 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso6183722276.1;
        Wed, 12 Jul 2023 07:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689171353; x=1691763353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUKUkYOEFIfGid1+2OLYcBlqK8nZmLojwj0PzdrDpYo=;
        b=bUabv4NCrx99n8iHsYuKtblfuAQ4uUKaxgoqCODNHOm3E9ckJFqokqkmvRxkVfzrks
         KtpwMc13MNwCU7YFhQxGWR8rA6DEIMlZNa5NfSFiY/nKbMhN1toDewU47LKYsqykDyfK
         QMcp1eJfNbj86vRPaC24wphWKxqWGgtklRlsAe5ebo23rFnj/VIAj6WUvm6EirYIDva3
         PMvntMK6y1qfcCbO7vaRvG+dvQJUDBNqb+65tHcFKJfD0vu0HavnIZuIlONPkKhiL3eE
         jV//A9gHrw7twy+ZKkvaTOM/COQ2VMekXZdq6VKW+pIXPwvkcPXSoviYjQYfskLrc0wf
         s0jg==
X-Gm-Message-State: ABy/qLYwgbgXzWDCSUPErdG3b4mQVR/jMURXhMiWQaO49N4w9cc++oOz
        RvzyXtX9XnVIXxbJtymE9yQTKzPZ/NtOmw==
X-Google-Smtp-Source: APBJJlHC7QUvBfJPF1/zNFMhy1jZlkMdd0KSFUtX/0nmTOOaCsyRxe7j2SToOujuFAzjslLYagS6/g==
X-Received: by 2002:a5b:d02:0:b0:c00:3434:f633 with SMTP id y2-20020a5b0d02000000b00c003434f633mr15232909ybp.3.1689171353445;
        Wed, 12 Jul 2023 07:15:53 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o11-20020a25810b000000b00ba88763e5b5sm920173ybk.2.2023.07.12.07.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:15:53 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so6172630276.3;
        Wed, 12 Jul 2023 07:15:53 -0700 (PDT)
X-Received: by 2002:a5b:f4c:0:b0:c4f:1d25:c6f8 with SMTP id
 y12-20020a5b0f4c000000b00c4f1d25c6f8mr13894522ybr.21.1689171352726; Wed, 12
 Jul 2023 07:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230712140011.18602-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230712140011.18602-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 16:15:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-ZzkKz1h6gLsfUEXQ41hQp0VCGrH=JmhRpOT_-_P3PQ@mail.gmail.com>
Message-ID: <CAMuHMdX-ZzkKz1h6gLsfUEXQ41hQp0VCGrH=JmhRpOT_-_P3PQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: register irqs before registering controller
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 12, 2023 at 4:04 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> IRQs should be ready to serve when we call mmc_add_host() via
> tmio_mmc_host_probe(). To achieve that, ensure that all irqs are masked
> before registering the handlers.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>
> Additionally tested on a Renesas Ebisu board (R-Car E3).
>
> Changes since v1:
> * refactored setting sdcard_irq_mask_all (Thanks Geert!)
> * added tag

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
