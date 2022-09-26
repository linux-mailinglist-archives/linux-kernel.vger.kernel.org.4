Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694145E9EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiIZKMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiIZKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:11:48 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A9DFA1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:10:48 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id i17so779334qkk.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CF2vupylMrVXkLI1Pe7H2d1pZD7KM4FL97tpjOkeLIE=;
        b=nWKudPRc16q6XPu/pCJnEZrKZ77vq9EhB/fGh+v5hKK4qKG2wal+kX5etz5aeMxzWR
         0tPoHeRrhEaZNFCVi50BGZDLE6Ne24JOBn9s0olJXVGlw6DG3wYBAFhOTGki2bMFQCSZ
         1RUyyvzKGiM+AaBRXJwD4e1BR5E/inaNhTpQViiC+XlwL9AmdKNj9fsaSNkYVgun2Dqt
         VXiricjLlxIk/9pwTpgXf0iyuUAOvd5+1Ud2co8EWNz6RCvxtNc1RPyHnWfYD61fNkpU
         UEcltwKsyPK3tKQ4wwDLsEKVucD+uK1Xt/sQzyhaHOT19/xJz52q3r3+YAEmxMrAaRZw
         vkGQ==
X-Gm-Message-State: ACrzQf06uRSWeDdgIxpJkzz2E89ATdmXW0Ti4jlzHWf5cXZBswbMCgpo
        7eXhRZYq/dCR+Asv5A3kEpg93Iq54uwBEg==
X-Google-Smtp-Source: AMsMyM7kpWjHE3ME7JheIfPJJsCGXl8gxPHSsLgJG5yygDQK/WDZCs0WA0wyRhxEiWMiH/LZA/DEOw==
X-Received: by 2002:a37:9847:0:b0:6cf:a6e5:8c32 with SMTP id a68-20020a379847000000b006cfa6e58c32mr986440qke.307.1664187047468;
        Mon, 26 Sep 2022 03:10:47 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a284500b006ce5f4720cdsm11349337qkp.47.2022.09.26.03.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:10:47 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3511e80f908so123747b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:10:47 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr19048935ywc.316.1664187046779; Mon, 26
 Sep 2022 03:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170340.4099226-1-Jason@zx2c4.com> <20220923170340.4099226-2-Jason@zx2c4.com>
In-Reply-To: <20220923170340.4099226-2-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 12:10:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWT8dhre5TGjYRnEwn_jCZ6CXxvMpLmKp3KKo_CjPOXRQ@mail.gmail.com>
Message-ID: <CAMuHMdWT8dhre5TGjYRnEwn_jCZ6CXxvMpLmKp3KKo_CjPOXRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] m68k: virt: generate new RNG seed on reboot
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

Hi Jason,

On Fri, Sep 23, 2022 at 7:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Rather than rebooting into a system with no entropy, regenerate the RNG
> seed before rebooting, so that the new system has a fresh seed.
>
> Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks for your patch!

I still doubt this is actually guaranteed to work, as the memory containing
the bootinfo might be overwritten during normal operation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
