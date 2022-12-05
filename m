Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0BC642516
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiLEIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiLEIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:53:41 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8AF1B7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:52:33 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id e18so7803941qvs.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fUiX2BOgIO3kRlBD2IZGFHz0fAiTgFWiM9Mfq43ZtE=;
        b=ARvFeSDobpZcb0ZJ3Lc+xqA7IJfOctBeFyBayT3F3R/Zwea2vpoEyKBJyiDjR6g3d9
         cvAJ7HQ9Kj1u8FwsLGpOpC+zq/7wzgFWAAorHHBAAfhzcorDYMV8xZrwHY8rGMXjhCIM
         vdKktXcgpfQgDdyuR1zmDT9EcekWfkTM4TZqclxtTshZwsP4YYloaVwubLww6GwW4wQW
         I+cryYo9snqh+3KwHkquMj+TG1nBkepN2IBaIZoLO/4CLczJC5isPyO4ot8GkxTBSOTf
         LRsKlJQw6YF6DrWgju9ouaHLgt3DxEGIhkoxhViZRLD8yOyOADh2qzuDISM+FyyShJui
         Xkwg==
X-Gm-Message-State: ANoB5pmX4NvrzMeDBF0Nkn+bY4utM91u1yZ/wPFtP0zGSCKNZ5hbzIvY
        v3mZZm1mk83m9zPRrHa42hj/dSXhkMaNkQ==
X-Google-Smtp-Source: AA0mqf5P9dXmZExh9IVxDv8n134Ce1OzmmhbewIkcfLtQsnkz5VQ5D9hYMGZAsosSRlZNvetpznkaw==
X-Received: by 2002:a05:6214:3502:b0:4c7:1fa7:2cc0 with SMTP id nk2-20020a056214350200b004c71fa72cc0mr20008848qvb.1.1670230352029;
        Mon, 05 Dec 2022 00:52:32 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g8-20020a05620a40c800b006f3e6933bacsm8960713qko.113.2022.12.05.00.52.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 00:52:31 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 189so13573190ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:52:31 -0800 (PST)
X-Received: by 2002:a25:9:0:b0:6f9:29ef:a5ee with SMTP id 9-20020a250009000000b006f929efa5eemr24512006yba.380.1670230350890;
 Mon, 05 Dec 2022 00:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20221203030544.11543-1-jwp.linux@gmail.com>
In-Reply-To: <20221203030544.11543-1-jwp.linux@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Dec 2022 09:52:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=8zBgY-Nsq2W99X1XCn8v17w5mScFixVOr8vrDpEEvg@mail.gmail.com>
Message-ID: <CAMuHMdW=8zBgY-Nsq2W99X1XCn8v17w5mScFixVOr8vrDpEEvg@mail.gmail.com>
Subject: Re: [PATCH] staging: board: Remove control flow from macro
To:     Joe Peterson <jwp.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

Hi Joe,

On Sat, Dec 3, 2022 at 4:08 AM Joe Peterson <jwp.linux@gmail.com> wrote:
> Adhere to Linux coding style
>
> Reported by checkpatch:
>
> WARNING: Macros with flow control statements should be avoided
>
> There is only one return value possible. Remove the checkpatch warning
> without effecting functionality.
>
> Signed-off-by: Joe Peterson <jwp.linux@gmail.com>

Thanks for your patch!
But please try to compile it before submission.

> --- a/drivers/staging/board/board.h
> +++ b/drivers/staging/board/board.h
> @@ -33,12 +33,10 @@ void board_staging_register_devices(const struct board_staging_dev *devs,
>                                     unsigned int ndevs);
>
>  #define board_staging(str, fn)                 \
> -static int __init runtime_board_check(void)    \
> +static void __init runtime_board_check(void)   \

device_initcalls must adhere to the initcall_t signature, regardless
what checkpatch says, cfr. include/linux/init.h:

    typedef int (*initcall_t)(void);

>  {                                              \
>         if (of_machine_is_compatible(str))      \
>                 fn();                           \
> -                                               \
> -       return 0;                               \
>  }                                              \
>                                                 \
>  device_initcall(runtime_board_check)


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
