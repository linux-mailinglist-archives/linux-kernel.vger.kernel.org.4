Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A865E62C150
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiKPOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiKPOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:19 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3255617AAD;
        Wed, 16 Nov 2022 06:49:17 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id i9so11718855qki.10;
        Wed, 16 Nov 2022 06:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhT+wRGsMqZBVBNYbapxMHCh1jnUO0LAhIzATarUXGw=;
        b=Zj8Wr2/kDohSllpnz2X0zeoz2eqddleHHUv7vKHoxgAjy0pWzlYNnjXpy5+Q8HsjaT
         dH4gC6qIVpFnJwXC023mz1oOzfU2/MvGh1GPK1A9xK5qJATg+Td5KdYhCh5egyFZ3mxR
         ympEPLtbg1F7LNpR1uK3gMnYlteniwwnWOyR1oROaZI8lAu9aJ/lCOVYplKf8HUTpnAC
         bMUnrf28iprIYF1R+DdZsv+5MpbYL6amup3zv5ExbIisgI7I7adQ593u9gwD6exY39TE
         1QCUqZKyQMtth06rZB/xLL6WkIjIdvgZOLIPQw6CpEoioTm26pnGBRNWkACav96i3LC2
         bA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhT+wRGsMqZBVBNYbapxMHCh1jnUO0LAhIzATarUXGw=;
        b=K/80ZvrLRr7VuK0tmka3ke6qyrUY8KznjLhhogJPcDtBaqTyRS0/HT7Zgq/SoiIKIA
         x94CXGujFt/771LzlIcZ88gpcX/Sk4uhpKs0txKfMqiMFnQTDrPiVnPkA9As3D7w45oN
         XMRyAy7wabPzyP6GdUntSvOTFlb3iM+sVQgQhx4aaa7H8xvksjXN+xvdgdB8ZlbFXG2R
         iQjMX2Mx4eSLQQ9U11ASLJusDOZGUxC95/cOys08QK2vNlEyhPqZionLTQd+c9E/tRO2
         N45dEFQokQ/uWsZGj1f/Om1Sy77DHqMzaJs4z1+uQRdjdG3lbdYecKwvi32Wy6O6NOm9
         fkKA==
X-Gm-Message-State: ANoB5pkjblcXCoVwn+rOCGaZbCFMgoobU+cf5IxI0OPTnBsAKq7RVuey
        zLS5FtZCvTOHs1ZKM800OlfvDxEFUofHRg==
X-Google-Smtp-Source: AA0mqf40EvOlBxPBqo5493cwl+vY0AF8jUzkoqL/U8wHLZ0w7F5dgTfRF2ctxts1API4yGm/6zyZSw==
X-Received: by 2002:a05:620a:211d:b0:6fa:182:f2d7 with SMTP id l29-20020a05620a211d00b006fa0182f2d7mr19009471qkl.360.1668610155923;
        Wed, 16 Nov 2022 06:49:15 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:15 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 00/14] serial: liteuart: add IRQ support
Date:   Wed, 16 Nov 2022 09:48:54 -0500
Message-Id: <20221116144908.234154-1-gsomlo@gmail.com>
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

Changes from v3:
  - picked up r/b Ilpo Järvinen on select subset of commits
  - rebased entire series on top of tty-next tree
  - 2/14 ("use bit number macros"): explicitly include <linux/bits.h>
  - 3/14 ("remove unused uart_ops stubs"): don't add gratuitous comment
    removed later on in the series
  - 12/14 ("add IRQ support for the RX path"): add shadow irq register
    to support polling mode and avoid reading hardware mmio irq register
    to learn which irq flags are enabled
    - this also simplifies both liteuart_interrupt() and liteuart_startup()
  - 13/14 ("add IRQ support for the TX path"):
    - removed superfluous curly braces from liteuart_interrupt()
    - simplified [start|stop]_tx() by using shadow irq register from 12/14
    - simplified liteuart_tx_chars() by rebasing on top of tty-next tree

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
  serial: liteuart: fix rx loop variable types
  serial: liteuart: separate rx loop from poll timer
  serial: liteuart: move function definitions
  serial: liteuart: add IRQ support for the RX path
  serial: liteuart: add IRQ support for the TX path
  serial: liteuart: move polling putchar() function

 drivers/tty/serial/liteuart.c | 210 ++++++++++++++++++++--------------
 1 file changed, 126 insertions(+), 84 deletions(-)

-- 
2.38.1

