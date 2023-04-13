Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557456E097B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDMI5O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Apr 2023 04:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDMI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:56:40 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882BAD32;
        Thu, 13 Apr 2023 01:55:11 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-54fb615ac3dso56381957b3.2;
        Thu, 13 Apr 2023 01:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376089; x=1683968089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/2r5n3qVynI/hX8mONBVdeZonUO/+YUa7xUJZQBOn8=;
        b=Eciy9S2H2pgGN47zJLfNfpFr61Mz7oVpOsd3/sGadhBrRIZfWaVWLH6RMK3CwCAxxm
         xHjcyS0Yql4htyfw+GT3YBzY3U3UfzlEQg5wfrrVcihC6VsMEFSbtmiXWWZn4mcpCWPo
         wzRdivTGGho9wpVKFXggwarbKfyOBNiLnSHxcBlulEYB8k+tKqDbadMa35PrI6/zHwbn
         bqt2t1U7Y/shL4fkF6JQOkAz6YvlZR4GyktV2ixyMnoqcB4dPQkhiSiJHypzfLQUxyCG
         cZtKs+djrXZaDPYJywbPZMamWAnbGFf36R0MSPUL28VmeFEFI/z7nsT9dR6N1UILqpa0
         vrlw==
X-Gm-Message-State: AAQBX9dz6Dc5vs0pze5rNv2rsZEkGL8+KkCsUFg19wlLkhPwZ/e7+z80
        9hyevCtlnmGHD9slsigLTiG/Hq5cYAJC8hzK
X-Google-Smtp-Source: AKy350ZcNqUumZkXFoyFiTc4zOBGrDgH7ifCk2ByIsB57ZcdO6Os/NZaTfFej6Sr5XtE+wc63XTvlA==
X-Received: by 2002:a81:5ac1:0:b0:54f:d816:8963 with SMTP id o184-20020a815ac1000000b0054fd8168963mr78192ywb.19.1681376089225;
        Thu, 13 Apr 2023 01:54:49 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 10-20020a81010a000000b0054662f7b42dsm315253ywb.63.2023.04.13.01.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 01:54:47 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j10so4379312ybj.1;
        Thu, 13 Apr 2023 01:54:47 -0700 (PDT)
X-Received: by 2002:a25:d057:0:b0:b8f:5c64:cc2e with SMTP id
 h84-20020a25d057000000b00b8f5c64cc2emr459363ybg.12.1681376087527; Thu, 13 Apr
 2023 01:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
 <58f91e983ac95b7f252606ecac12f016@bootlin.com>
In-Reply-To: <58f91e983ac95b7f252606ecac12f016@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Apr 2023 10:54:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVqyY=tg6iU4feRwQhPt9c7ZZK9ifBCYf5AAgkxWjYOBA@mail.gmail.com>
Message-ID: <CAMuHMdVqyY=tg6iU4feRwQhPt9c7ZZK9ifBCYf5AAgkxWjYOBA@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Add interrupt support
To:     kamel.bouhara@bootlin.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        metux IT consult <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        stratos-dev@op-lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamel,

On Thu, Apr 13, 2023 at 9:48 AM <kamel.bouhara@bootlin.com> wrote:
> Le 2021-10-04 14:44, Geert Uytterhoeven a écrit :
> What is the status for this patch, is there any remaining
> changes to be made ?

You mean commit a00128dfc8fc0cc8 ("gpio: aggregator: Add interrupt
support") in v5.17?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
