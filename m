Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93B6A2A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 15:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBYO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 09:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 09:29:05 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B31144AD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 06:29:04 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536cd8f6034so56557897b3.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fI6Mad85Cz4vp6VK2Mm5+3rmio2ISP3sBF+ZJAmcH/U=;
        b=OG9HnZYC/bYqbLxObgOjs27BbgVmA4VkV20le8X0z76K6o1vY/U4m1xZCMgXWv67Ju
         E4BrM1RIxN4VZ9mXBPBKfC2g77nlWeWa5H6GltZ37S+k+lSrzgU098Ih2P5t9h8BaWKv
         NQu0wLBZwPbkSoTWtuheuyxm8asWeXJ/BbrKT5I7Mq56Xzg13LY7TQWWRSI6U2S7bA0x
         B4YfRAlZ9o23cXvRKPbeYiwraZJ+j27ka7/ZTErxally2xttztU63F/s7qQaOoV4E1N2
         5+lWwNKxdCyj69G06Zvh2ppfDlRHapsweRbXqDi1TAYUH+tnmtOoDFtGAoDyc0to1XiN
         z+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fI6Mad85Cz4vp6VK2Mm5+3rmio2ISP3sBF+ZJAmcH/U=;
        b=HYaQWDprU70g/LWpqH5jQB9t4XHZG5nFmAfA1Z6xPpNskbrnv7roLLiHbIj039wMU4
         q78kMBBd/qCzhoXHYrc+66X7LK+ewb2fBnElgxQKdgDHt/nxGM2Y2e8ZSEtgVOoZv9zH
         2pxipVOS21a4M31YUHYoJyJY6UeiEYzW/03hhliOuNbeR+ULhGYCpzzFsl+fsSdITOZm
         GOz9Q+YgFK1yxxEmtw0nZSUaxbVeCZ58z3Zm/Y442ewFrWOa5VAledyBzAPteh+JTnq8
         Rrq7eX1qenn2Y+41GVjJP7F8YlF0yYGEjvl/ylEk0YUuz+rTDZT08Wx7DzSC7knvtyVk
         Tcug==
X-Gm-Message-State: AO0yUKVL6leiuUxylxdly9wEkiJdVZKxwsdZGIofW9oTfi2HWEXMWAAY
        OjxUuiF+ME6K7dJrrW2tqQbf0NCce4cNP1snRRnPnHop07bJJ+N3VgM=
X-Google-Smtp-Source: AK7set/ocK+qZa45wyHFV7HdOH34emA9y949JgcGkP8A3tBxCWvk9YQlDqNWQY1Phvk6WFOPAVJXwbWpbEA8EYaH4d4=
X-Received: by 2002:a81:b606:0:b0:52e:c79a:cda with SMTP id
 u6-20020a81b606000000b0052ec79a0cdamr6636890ywh.10.1677335343520; Sat, 25 Feb
 2023 06:29:03 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Feb 2023 15:28:52 +0100
Message-ID: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
Subject: Regression in probing some AMBA devices possibly devlink related
To:     Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

I have a boot regression for Ux500 on mainline, but bisecting mainline
isn't quite working for misc reasons :/

I'm not sure about this regression, but it smells like devlink-related.

Ux500 have a bunch of normal and some AMBA devices. After
boot this happens and we hang waiting for rootfs (which is on eMMC):

[   31.849586] amba 80126000.mmc: deferred probe pending
[   31.854801] amba 80118000.mmc: deferred probe pending
[   31.859895] amba 80005000.mmc: deferred probe pending
[   31.870297] amba 80120000.uart: deferred probe pending
[   31.875472] amba 80121000.uart: deferred probe pending
[   31.880689] amba 80004000.i2c: deferred probe pending
[   31.885799] amba 80128000.i2c: deferred probe pending
[   31.890932] amba 80110000.i2c: deferred probe pending
[   51.688361] vmem_3v3: disabling

The last regulator (vmem_3v3) is something the eMMC that didn't
probe was supposed to use.

All the failing drivers are AMBA PrimeCell devices:
drivers/mmc/host/mmci.c
drivers/tty/serial/amba-pl011.c
drivers/i2c/busses/i2c-nomadik.c

This makes me suspect something was done for ordinary (platform)
devices that didn't happen for AMBA devices?

This is the main portion of the device tree containing these
devices and their resources:
arch/arm/boot/dts/ste-dbx5x0.dtsi

Any hints?

Yours,
Linus Walleij
