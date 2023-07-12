Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B3A750149
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGLIWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjGLIVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D13C21;
        Wed, 12 Jul 2023 01:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD20616E4;
        Wed, 12 Jul 2023 08:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAA0C433C8;
        Wed, 12 Jul 2023 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149894;
        bh=3pd36JdQslSBuIdGK+JvW/2KCTKLnAcqamIBhPP6FLM=;
        h=From:To:Cc:Subject:Date:From;
        b=ns3KqQauxv1YnV/xwsyT+OI7iv+X1Z3qJLvXOTvPaQ+IyZIFxXcBjT11BbE7jR/XH
         DEGGIAC78UFdackxoPCn7r4QTV+ts/mkVPl/9PL+krDDXH929nRP+KCu7Qz4bcIDCW
         6WxoFXxqkBS+t34PBUu+U097kWP1g2KsaPjXxGmRbwbCX5XUtSKEsXdA6dYj1Bjub8
         agWPC6sglAHOVqpe1oomM3MrSn48IFiut6TH4P1Cv/8aiPDBLtMrMaCkYOhPvAo4rK
         Oci6gzGKuURvW5eMNiO3zJBRSIEoFNcRXVpVqaGA4Br/W+QHlyfGGnaFbEUyCiPaPb
         P72nHu9egvgGQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/10] tty: u8 conversion preparation
Date:   Wed, 12 Jul 2023 10:18:01 +0200
Message-ID: <20230712081811.29004-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another round of preparations for conversions of chars and flags
to u8. This series converts sysrq handlers and serial_core + serial
drivers. The tty proper will be posted separately later.

Jiri Slaby (SUSE) (10):
  tty: sysrq: rename and re-type i in sysrq_handle_loglevel()
  tty: sysrq: switch sysrq handlers from int to u8
  tty: sysrq: switch the rest of keys to u8
  tty: sysrq: use switch in sysrq_key_table_key2index()
  serial: convert uart sysrq handling to u8
  serial: make uart_insert_char() accept u8s
  serial: pass state to __uart_start() directly
  serial: arc_uart: simplify flags handling in arc_serial_rx_chars()
  serial: omap-serial: remove flag from serial_omap_rdi()
  serial: drivers: switch ch and flag to u8

 arch/alpha/kernel/setup.c            |  2 +-
 arch/loongarch/kernel/sysrq.c        |  2 +-
 arch/mips/kernel/sysrq.c             |  2 +-
 arch/powerpc/xmon/xmon.c             |  2 +-
 arch/sparc/kernel/process_64.c       |  4 +-
 drivers/gpu/drm/drm_fb_helper.c      |  2 +-
 drivers/tty/serial/21285.c           |  3 +-
 drivers/tty/serial/8250/8250_port.c  |  3 +-
 drivers/tty/serial/altera_jtaguart.c |  2 +-
 drivers/tty/serial/altera_uart.c     |  2 +-
 drivers/tty/serial/amba-pl010.c      |  3 +-
 drivers/tty/serial/amba-pl011.c      |  3 +-
 drivers/tty/serial/apbuart.c         |  3 +-
 drivers/tty/serial/arc_uart.c        | 29 +++++-----
 drivers/tty/serial/atmel_serial.c    |  2 +-
 drivers/tty/serial/clps711x.c        |  3 +-
 drivers/tty/serial/digicolor-usart.c |  3 +-
 drivers/tty/serial/dz.c              |  2 +-
 drivers/tty/serial/ip22zilog.c       |  2 +-
 drivers/tty/serial/max3100.c         |  3 +-
 drivers/tty/serial/max310x.c         |  3 +-
 drivers/tty/serial/mcf.c             |  2 +-
 drivers/tty/serial/milbeaut_usio.c   |  3 +-
 drivers/tty/serial/mxs-auart.c       |  3 +-
 drivers/tty/serial/omap-serial.c     |  8 +--
 drivers/tty/serial/pxa.c             |  2 +-
 drivers/tty/serial/rp2.c             |  4 +-
 drivers/tty/serial/sa1100.c          |  3 +-
 drivers/tty/serial/samsung_tty.c     |  3 +-
 drivers/tty/serial/sb1250-duart.c    |  3 +-
 drivers/tty/serial/sc16is7xx.c       |  3 +-
 drivers/tty/serial/sccnxp.c          |  3 +-
 drivers/tty/serial/serial-tegra.c    |  7 +--
 drivers/tty/serial/serial_core.c     | 15 +++--
 drivers/tty/serial/serial_txx9.c     |  3 +-
 drivers/tty/serial/sifive.c          |  2 +-
 drivers/tty/serial/sprd_serial.c     |  5 +-
 drivers/tty/serial/st-asc.c          |  2 +-
 drivers/tty/serial/stm32-usart.c     |  5 +-
 drivers/tty/serial/sunplus-uart.c    |  2 +-
 drivers/tty/serial/zs.c              |  3 +-
 drivers/tty/sysrq.c                  | 84 ++++++++++++++--------------
 include/linux/serial_core.h          | 18 +++---
 include/linux/sysrq.h                | 18 +++---
 kernel/debug/debug_core.c            |  2 +-
 kernel/power/poweroff.c              |  2 +-
 kernel/rcu/tree_stall.h              |  2 +-
 47 files changed, 142 insertions(+), 145 deletions(-)

-- 
2.41.0

