Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E32635F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiKWNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiKWNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:24 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C82903B9;
        Wed, 23 Nov 2022 05:05:08 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c2so416112qko.1;
        Wed, 23 Nov 2022 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+v8ZxKX8tGaAXfvICGpj0mzbrVbhvFOF5mYVd6TaZA=;
        b=EnaQDaNjXv66YcJvROjW0f4Fp2tpTGrlrVC3D8TyZX2t/4xHQRxAKa5K22EPyKj1xS
         dhwKCFByRH3lTWCbkLTrysAabgahJE/bE8lokrWd03gTZ09dSDz2jJ1iy6gZ2q97Dg4g
         Jzvebow4zGVLe4RhVS7QOoaXONXpGbtbm8jqosdnLfe/kmO0hh+ObDpVFn3fBG6Q/MDg
         59lwIxffJf60dVeaeYT4U0O6hsHskNFGFSSfyJxTSHF5dJxxyNtORppkt+8l4460cs/z
         FmdYcH/UPpArWaN8u12WdsqmELnWx1BIhAJY534UppzXUYLOugpyVREILYkqTb8MOX3X
         WVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+v8ZxKX8tGaAXfvICGpj0mzbrVbhvFOF5mYVd6TaZA=;
        b=mtVk75mPRjeEjb3tV4OxwGuJscUgvQmHFId3K6xWxfR8UX6rB3Pdq6o0FsAC0XuJqJ
         Ww2k7sNZtxRVrFGVWmzFrzcyQUAe4hIBmS6G5o8U+1Y69YeSrMXMyzKo5Kls8q3VWY5Y
         6XY7cZwUoZNy4JPk8nHaR3Xj9v/+dgCq8AtSa+QaxL8H8qrILhQfrNi/QDmyzu8TJHfL
         BmLAbiqrWT6axmxhAoQKEAVwhie+fYgKeyTbNg+1EMN6gJ+rXYpYdbk4RSlTb48j4QOf
         NbpLY9gVq8AtLlXATByXLLdLceLXozTqL1oILKDZfzNLx130IAr/EwrlyQmN2tu3a2sQ
         TMfw==
X-Gm-Message-State: ANoB5pk3atz7ygvot/Pnfry+6vMiOIHLuPIMwn0IbyPFf4M5AksSkAs+
        ENuARha7dJ/WRL4Iy5D0z+AFAJdpOzMoEg==
X-Google-Smtp-Source: AA0mqf7YCtPtIZq9hYuE3siFAGi4/qioJ7hPqW5YDQXgYKAPVT8DaADy5yParuwZ/m88yUdVx25BWw==
X-Received: by 2002:a05:620a:19:b0:6fb:aa94:7c0e with SMTP id j25-20020a05620a001900b006fbaa947c0emr10876901qki.37.1669208706941;
        Wed, 23 Nov 2022 05:05:06 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:06 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 00/14] serial: liteuart: add IRQ support
Date:   Wed, 23 Nov 2022 08:04:46 -0500
Message-Id: <20221123130500.1030189-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IRQ support to the LiteX LiteUART serial interface

Changes from v5:
  - picked up r/b Geert Uytterhoeven on select subset of commits
  - 09/14 ("clean up rx loop variables"):
    - eliminate `status` variable altogether as its value is known
      and constant inside the loop;
    - switch `ch` to `u8`, to match the call *producing* it
      (`litex_read8()`) instead of those consuming its value.
  - 12/14 ("add IRQ support for the RX path"):
    - s/dev_err()/dev_warn()/ when falling back to polling in
      `liteuart_startup()`
    - use `spin_[lock_irqsave|unlock_irqrestore]()` in the interrupt
      handler, since the same code may also be called in "serving_softirq"
      context when using a poll timer instead of interrupts

> Changes from v4:
>   - picked up r/b Ilpo Järvinen on 12/14 and 13/14
>   - 12/14 ("add IRQ support for the RX path"): using dev_err() instead
>     of combining pr_err() and pr_fmt(); also, remove superfluous comment
>
> Changes from v3:
>   - picked up r/b Ilpo Järvinen on select subset of commits
>   - rebased entire series on top of tty-next tree
>   - 2/14 ("use bit number macros"): explicitly include <linux/bits.h>
>   - 3/14 ("remove unused uart_ops stubs"): don't add gratuitous comment
>     removed later on in the series
>   - 12/14 ("add IRQ support for the RX path"): add shadow irq register
>     to support polling mode and avoid reading hardware mmio irq register
>     to learn which irq flags are enabled
>     - this also simplifies both liteuart_interrupt() and liteuart_startup()
>   - 13/14 ("add IRQ support for the TX path"):
>     - removed superfluous curly braces from liteuart_interrupt()
>     - simplified [start|stop]_tx() by using shadow irq register from 12/14
>     - simplified liteuart_tx_chars() by rebasing on top of tty-next tree
>
> Changes from v2:
>   - further split out "separate RX loop from poll timer" into
>     dedicated patches highlighting additional changes explicitly:
>       - factoring out tty_flip_buffer_push() (6/14)
>       - ack only RX events in RX loop (7/14)
>       - pass constant flag to uart_insert_char() directly (8/14)
>       - fix variable types in rx loop (9/14)
>       - separating RX loop from poll timer (10/14)
>   - added patch (11/14) to move function definitions to a more
>     convenient location, making subsequent changes easier to read
>     in diff patch form.
>   - fixes and clarifications for RX path IRQ support patch (now 12/14):
>       - only return IRQ_HANDLED for RX events
>       - use pr_fmt() to improve style of irq setup error message
>       - remove unnecessary locking from around single-register access
>   - modify TX path to support both IRQ-mode and polling (13/14)
>   - move polling-only liteuart_putchar() behind same conditional
>     (CONFIG_SERIAL_LITEUART_CONSOLE) as the rest of the code that's
>     still using it.
>
> Changes from v1:
>   - split minor cosmetic changes out into individual patches
>     (1/3 became 1..5/7)
>   - patches 6/7 and 7/7 unchanged (used to be 2/3 and 3/3)

Gabriel Somlo (14):
  serial: liteuart: use KBUILD_MODNAME as driver name
  serial: liteuart: use bit number macros
  serial: liteuart: remove unused uart_ops stubs
  serial: liteuart: don't set unused port fields
  serial: liteuart: minor style fix in liteuart_init()
  serial: liteuart: move tty_flip_buffer_push() out of rx loop
  serial: liteuart: rx loop should only ack rx events
  serial: liteuart: simplify passing of uart_insert_char() flag
  serial: liteuart: clean up rx loop variables
  serial: liteuart: separate rx loop from poll timer
  serial: liteuart: move function definitions
  serial: liteuart: add IRQ support for the RX path
  serial: liteuart: add IRQ support for the TX path
  serial: liteuart: move polling putchar() function

 drivers/tty/serial/liteuart.c | 217 +++++++++++++++++++++-------------
 1 file changed, 132 insertions(+), 85 deletions(-)

-- 
2.38.1

