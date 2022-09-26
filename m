Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D85E9E73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiIZJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiIZJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:57:17 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C325E96
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:57:16 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id h28so3793003qka.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wKItE+4AXq4ijfjw/zsb4jrjt0VwS9VW608UoTuf7bY=;
        b=nm+8SY1h64dJ8sUxBag+lGT/onZ48f4QQztQD9L3MU0ruO28tbCaAWNm0HGI9ibhkx
         AKEUWth6D2K0YjQmWkzObpPahW1jzk/JUzwWWASRnWCUw0lJyxmRjsyiU8Ue11SKSe4J
         DfkdBW0nqSbP0rkbG4DI75nHMcC9B9wQSQPf7zogkZCTfQfQhzP6uvRVu5vHqnHxccv7
         r3dfGBmyzxXLROEpj19yNTMSwHNBwQ4OIRyCfXZkrVpMKu26PuwfM95OrCkWPmoEV75Z
         60WdOYdEP8UEGmBvLd/IIM5nMWnQxuifUotbXwi4MH6lsuIWFNiFixnpRi8ccT7LrE7h
         5x/Q==
X-Gm-Message-State: ACrzQf0OnuAL74tjKxgraRrglgMHqXwsKZZAjCs4i8Z06yw1s+CU0/iy
        BRNEbFgBOxzBvRdn6GwMYS1YTbBhWZih+Q==
X-Google-Smtp-Source: AMsMyM4l0+3zeGkZtrpo4ciryS2VTPq9UFhbuw6UX1S9wBKygjb1JojyPc/v0tpNzovliYAPhz0gYA==
X-Received: by 2002:a05:620a:424c:b0:6be:78d5:ec73 with SMTP id w12-20020a05620a424c00b006be78d5ec73mr13321112qko.579.1664186235226;
        Mon, 26 Sep 2022 02:57:15 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id g22-20020ac87d16000000b00342f844e30fsm11418188qtb.31.2022.09.26.02.57.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 02:57:15 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id b136so7706719yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:57:14 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr18511883ybp.365.1664186234639; Mon, 26
 Sep 2022 02:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170340.4099226-1-Jason@zx2c4.com>
In-Reply-To: <20220923170340.4099226-1-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 11:57:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJoocGUugnhv=pbgu7z6MFexmRGH1JkQCjm9g-=HiowQ@mail.gmail.com>
Message-ID: <CAMuHMdVJoocGUugnhv=pbgu7z6MFexmRGH1JkQCjm9g-=HiowQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] m68k: process bootinfo records before saving them
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 23, 2022 at 7:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The RNG seed boot record is memzeroed after processing, in order to
> preserve forward secrecy. By saving the bootinfo for procfs prior to
> that, forward secrecy is violated, since it becomes possible to recover
> past states. So, save the bootinfo block only after first processing
> them.
>
> Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
