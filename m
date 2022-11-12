Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C72A626BDD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiKLVVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiKLVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:34 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E2815801;
        Sat, 12 Nov 2022 13:21:32 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h10so5668026qvq.7;
        Sat, 12 Nov 2022 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVaIJ7pDx9D1d7++dPGO3X1V6P3xA2aUy4LXgc5/OsQ=;
        b=NuAD369d3rzZr33oCTozp40LU5AnXY/AsRBnDkr+q0wo4mJV/Oqe4lRswpJS46FQMQ
         qItsV886keH2h+ap+S7OD/Ccm8vUkxLQpZzWJzURSMAyMlj5l69Fn4xz0Fvo4+2UjjNZ
         vnEnFwkUE30nQQk7WTbZCdiBGUGff8kAKtE1YxkTMDOuzFq65JCbgsbC5Fwp2YmJ4oHz
         4kxVuSfuaAZzXFS+k9IXOyxOMjQGm4wJi1EmPcGwKpLBXeepfoP9CSyixojxBqXGF7BE
         aJm1euD633h4Nz7Vhnp3oHMXbvt0MfPOBcto7T8yjAa5Uo+DGheK4PoTgiZHJQy8kvk5
         mpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVaIJ7pDx9D1d7++dPGO3X1V6P3xA2aUy4LXgc5/OsQ=;
        b=ZqNvpSWDOmACSTk2OFchEgZYD7BF23m+BXLpsLBG5yr1dYPz4OWTJrv76Go8gFLHfh
         5XlJ2rD8V7jnXmyUP7NNP+lRhrLFhPIDccg4aquXX7OMfx6vokL1EJ9PTEd1r2BFSZdg
         +OZzH6v/3nkRkcQPV0wlDVuuhrjRQJ1EsRvsXt3F9sGaguJVekJ0QSw2Cl7OW6JYWPlc
         y3tU0FrjkSntZ2JdNkS/3XITqkatA2vic3jAxUJ6vkvFM+1V+ydyR4xDftedorqqHEQU
         bzv3T8ArZ6z4r4Rc1VMmUtAn1+IT6I04bW2dG1Gf+l62tRRAR3vh+n0dCy3MWFIXgOv5
         1fVA==
X-Gm-Message-State: ANoB5pmOo3AEiz3v2BuG//DRyeae8QlB32cZPRCubigVjp//ZdHJGyhq
        +bUVusARdnZph9BThbeAU6mdw1TjpfpF/g==
X-Google-Smtp-Source: AA0mqf73ifKrHva+7g+chysjxnNojnSDfSx8lnCWgiTzfEsq3Oznwdq+CH7No+ALMYYLbtOIqO5OoQ==
X-Received: by 2002:ad4:4b67:0:b0:4bb:3254:dfb9 with SMTP id m7-20020ad44b67000000b004bb3254dfb9mr7224438qvx.58.1668288091280;
        Sat, 12 Nov 2022 13:21:31 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:30 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 00/14] serial: liteuart: add IRQ support
Date:   Sat, 12 Nov 2022 16:21:11 -0500
Message-Id: <20221112212125.448824-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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

Changes from v2:
  - further split out "separate RX loop from poll timer" into
    dedicated patches highlighting additional changes explicitly:
      - factoring out tty_flip_buffer_push() (6/14)
      - ack only RX events in RX loop (7/14)
      - pass constant flag to uart_insert_char() directly (8/14)
      - fix variable types in rx loop (9/14)
      - separating RX loop from poll timer (10/14)
  - added patch (11/14) to move function definitions to a more
    convenient location, making subsequent changes easier to read
    in diff patch form.
  - fixes and clarifications for RX path IRQ support patch (now 12/14):
      - only return IRQ_HANDLED for RX events
      - use pr_fmt() to improve style of irq setup error message
      - remove unnecessary locking from around single-register access
  - modify TX path to support both IRQ-mode and polling (13/14)
  - move polling-only liteuart_putchar() behind same conditional
    (CONFIG_SERIAL_LITEUART_CONSOLE) as the rest of the code that's
    still using it.

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

 drivers/tty/serial/liteuart.c | 226 +++++++++++++++++++++-------------
 1 file changed, 142 insertions(+), 84 deletions(-)

-- 
2.37.3

