Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4366073F884
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjF0JQk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjF0JQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:16:37 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF199;
        Tue, 27 Jun 2023 02:16:36 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so3316986276.3;
        Tue, 27 Jun 2023 02:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857396; x=1690449396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJEsAyJMr53UgQ5hcDPQftgfnsXq+Wmcilt10Mv3eBI=;
        b=OpuOLlgOb+BaeFTciOODtpgeZ/GY8hAK1ChDQoZdikoXkBW4PtcFt0BjfeXdlHrU/W
         DbyQxqfcI0xQf8IdkeEfK+u8W0Y7IQaUddRD6eJU4d52+hY1cOofg23YrR15WveWVwll
         +3A602hSyd9r2jTeecoXdFLOHV7papM1jYTbpZ+HAfrDT9W5wGr7hE4oS2vwsYvyFy5L
         hrz1bQhCm7e1KVFbneMm9FRkc0aUyl9U3zMYXMPV+dYpC6UHoeF4qQCjlYkvOTzuKKJE
         eQ4nom3TQhA+CRBKps70t9A0Kr6kIgN8qGhjBKnF2eRRbrYexj7RrL39UArTpJmPMSVO
         AbhA==
X-Gm-Message-State: AC+VfDwSgIDisT2LWfn3ur7U/hKz0bnKfXEcLNQpcygv+kstSMhZlXMg
        ZZ5PoAa+glBtoVoq+Yu+7owuo4IohBu6lJiO
X-Google-Smtp-Source: ACHHUZ7HhgnKQXF7vK8jeZRUTT0oc0pSGkv9Y390+CeN08m6DqCjh9iBvnTWUSUmNzogyLNpLxDzMw==
X-Received: by 2002:a25:ac9:0:b0:c2f:c604:2e86 with SMTP id 192-20020a250ac9000000b00c2fc6042e86mr1186227ybk.6.1687857395838;
        Tue, 27 Jun 2023 02:16:35 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id f32-20020a25b0a0000000b00bc501a1b062sm1566422ybj.42.2023.06.27.02.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 02:16:35 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5769e6a6818so32639957b3.1;
        Tue, 27 Jun 2023 02:16:35 -0700 (PDT)
X-Received: by 2002:a81:7bc2:0:b0:56d:43cb:da98 with SMTP id
 w185-20020a817bc2000000b0056d43cbda98mr30313449ywc.29.1687857394892; Tue, 27
 Jun 2023 02:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230627091007.190958-1-tanure@linux.com> <20230627091007.190958-4-tanure@linux.com>
 <3570635f-99ab-7127-0441-53852688a59c@linaro.org>
In-Reply-To: <3570635f-99ab-7127-0441-53852688a59c@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Tue, 27 Jun 2023 10:16:23 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+0fHUQTzgCUb5mU2BPFdwTnxNsq8+YCNadvdsq2_aeMaA@mail.gmail.com>
Message-ID: <CAJX_Q+0fHUQTzgCUb5mU2BPFdwTnxNsq8+YCNadvdsq2_aeMaA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tty: serial: meson: Add a earlycon for the T7 SoC
To:     neil.armstrong@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:12 AM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Hi Lucas,
>
> On 27/06/2023 11:10, Lucas Tanure wrote:
> > The new Amlogic T7 SoC does not have a always-on uart,
> > so add OF_EARLYCON_DECLARE for it.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >   drivers/tty/serial/meson_uart.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> > index 2501db5a7aaf..c24e105a98c5 100644
> > --- a/drivers/tty/serial/meson_uart.c
> > +++ b/drivers/tty/serial/meson_uart.c
> > @@ -649,6 +649,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
> >
> >   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> >                   meson_serial_early_console_setup);
> > +OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> > +                 meson_serial_early_console_setup);
> >
> >   #define MESON_SERIAL_CONSOLE        (&meson_serial_console)
> >   #else
>
> I've reviewed last version of this patch, please keep tags for minor changes,
> or explicitely explain why you didn't keep the tag.
>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Sure, I didn't keep it because the change from "amlogic,meson-t7-uart"
to "amlogic,t7-uart" seem a relevant one.

>
> Thanks,
> Neil
