Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD962F859
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiKROz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiKROzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:24 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AD211C20;
        Fri, 18 Nov 2022 06:55:20 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h10so3468927qvq.7;
        Fri, 18 Nov 2022 06:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8m3ALn8djL3z29Z65yl8MZcN71VcLknqcAUT7X+SXM=;
        b=lv6Gz+n4VNuWgdsjnPesUhGm3Mb7yfHiUYKOCYyNUWiprlYc6sK810pUkn+e0XkA8P
         1i6AYYW8mFabsoTfgYSSxypPq4sxzWKTJ83mdbysZ9e0eaPBE4DVAGic7vdzrU8UWCKH
         RrG0FttRJPHqiQV9Qy21AZkjtO+67iKn2ig0v9hpW0hjJAS7W0KWH9YA2tXZxS6hOXVT
         9amon9o+pJI4n4bXwR/BFWwJS96ocSNF0k+IkTo/c1Pqd8VXbuLvwjflOnQDuwSvzRBF
         INI81QAuVsx8QAws9lwfOiHJZCN3BZoSA956I9PbvOYODqZf4PBVgdIBJhedmqxPc7CP
         CCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8m3ALn8djL3z29Z65yl8MZcN71VcLknqcAUT7X+SXM=;
        b=qIqmIEWxuDkYusFMvPArEyj2DN6Sp2LhGjPHUfyfUafEUW3s7pNgJ682sNHVKRsSBc
         y6SWb+NWIqstuu++LVdFYvPYKAC6Yc+D3CjOYlKypW6s2Hhy4vEF9GjUb4qbgfa76KT+
         7Dx0egNffKPtQo4STSibyLTm/AjXJrseirSlg//Fuztcy+wkwkv9kEo06uxeURU+xMBc
         fSlS2X6vt5pDamlArUVXHRmmXcSeZeX12GqkjKpjTs6Ia8sJKCsbBEDnHs5V8Fv/OhlC
         T5vsHUk6oeUKpdI0ExhCJVL46btlnlZliRdoL4VNQ5Km6B431TvfkAe5PLGItt716qDn
         fcxQ==
X-Gm-Message-State: ANoB5plq2ctbYu/oVEFuJ5MQZAO2oBaixIpNLj4S0gYqgSSv81d8/Jq3
        2Oxiok+rm/MevRoDGdpnCIGy/DVFpvEvPQ==
X-Google-Smtp-Source: AA0mqf60zKIBMMuEdixr0vKQVZLS3dThYUncL8mlya5LxVGBQqrruL0Vgo1Ux0Ffbs9rgK6rk90Jqw==
X-Received: by 2002:ad4:53c9:0:b0:4c6:8b88:3065 with SMTP id k9-20020ad453c9000000b004c68b883065mr5794524qvv.126.1668783319703;
        Fri, 18 Nov 2022 06:55:19 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:18 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 00/14] serial: liteuart: add IRQ support
Date:   Fri, 18 Nov 2022 09:54:58 -0500
Message-Id: <20221118145512.509950-1-gsomlo@gmail.com>
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

Changes from v4:
  - picked up r/b Ilpo Järvinen on 12/14 and 13/14
  - 12/14 ("add IRQ support for the RX path"): using dev_err() instead
    of combining pr_err() and pr_fmt(); also, remove superfluous comment

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

