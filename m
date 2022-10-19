Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16C60404A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiJSJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiJSJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:42:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E81D4A37;
        Wed, 19 Oct 2022 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666171133; x=1697707133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mzl34Bq4RG8LrlBbNXgNetnn2C5D+8GwmBwKX8FGa28=;
  b=eBTPRh4AuVbWV3b2ng7gs0LmLMrkii0dhMLE3tm1dFZdwxzFXKLNn1j7
   oV+hJuJOi1aTAWyLSqRpsRBlEnPT4HF8BRV+tvKirkyDIkEj7hGkbchzQ
   N0IHubNcOIbMCrdSqcn79VTFD8t9kQuOdA+R/8A3+4xZMjZLNkdABuuC8
   eOglnlE21jAMTO8eZLHjPdir4ZhHYbq7PXjHbPvQqC41VrZOzU8CHjrMw
   1ND+xixtrZSGGkx8vYLb0jTanRXuzWll4y7x6CFX/ZaBClXD6efIw6eEw
   +mSK3w/2RLc30YmEWD6BWoccehtUejazxHBJl45+6xzE6MFPUOV3P883o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="286072356"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="286072356"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118374"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118374"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/44] serial: Convert drivers to use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:07 +0300
Message-Id: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uart_xmit_advance() helper was created for managing the xmit tail
index and accounting. It simplifies one the most common operation in
almost every serial driver. Convert most of the drivers to use the new
helper.

I've tried to pick the drivers such that these shouldn't collide with
the ones Jiri's tx loop rewrite series is touching (unless he has
something hidden beyond what has been on the list).

Ilpo Järvinen (44):
  serial: dz: Use uart_xmit_advance()
  serial: men_z135_uart: Use uart_xmit_advance()
  serial: msm: Use uart_xmit_advance()
  serial: pch_uart: Use uart_xmit_advance()
  serial: sc16is7xx: Use uart_xmit_advance()
  serial: 8250_bcm7271: Use uart_xmit_advance()
  serial: 8250: Use uart_xmit_advance()
  serial: pl011: Use uart_xmit_advance()
  serial: ar933x: Use uart_xmit_advance()
  serial: arc: Use uart_xmit_advance()
  serial: atmel: Use uart_xmit_advance()
  serial: clps711x: Use uart_xmit_advance()
  serial: cpm_uart: Use uart_xmit_advance()
  serial: digicolor: Use uart_xmit_advance()
  serial: linflexuart: Use uart_xmit_advance()
  serial: fsl_lpuart: Use uart_xmit_advance()
  serial: imx: Use uart_xmit_advance()
  serial: ip22zilog: Use uart_xmit_advance()
  serial: liteuart: Use uart_xmit_advance()
  serial: max3100: Use uart_xmit_advance()
  serial: max310x: Use uart_xmit_advance()
  serial: meson: Use uart_xmit_advance()
  serial: milbeaut_usio: Use uart_xmit_advance()
  serial: mvebu-uart: Use uart_xmit_advance()
  serial: pic32: Use uart_xmit_advance()
  serial: pmac_zilog: Use uart_xmit_advance()
  serial: rda: Use uart_xmit_advance()
  serial: samsung_tty: Use uart_xmit_advance()
  serial: sb1250-duart: Use uart_xmit_advance()
  serial: sccnxp: Use uart_xmit_advance()
  serial: tegra: Use uart_xmit_advance()
  serial: sh-sci: Use uart_xmit_advance()
  serial: sprd: Use uart_xmit_advance()
  serial: stm32: Use uart_xmit_advance()
  serial: sunhv: Use uart_xmit_advance()
  serial: sunplus-uart: Use uart_xmit_advance()
  serial: sunsab: Use uart_xmit_advance()
  serial: sunsu: Use uart_xmit_advance()
  serial: sunzilog: Use uart_xmit_advance()
  serial: timbuart: Use uart_xmit_advance()
  serial: uartlite: Use uart_xmit_advance()
  serial: ucc_uart: Use uart_xmit_advance()
  serial: xuartps: Use uart_xmit_advance()
  serial: zs: Use uart_xmit_advance()

 drivers/tty/serial/8250/8250_bcm7271.c      |  4 +---
 drivers/tty/serial/8250/8250_port.c         |  3 +--
 drivers/tty/serial/amba-pl011.c             |  3 +--
 drivers/tty/serial/ar933x_uart.c            |  3 +--
 drivers/tty/serial/arc_uart.c               |  3 +--
 drivers/tty/serial/atmel_serial.c           | 11 ++---------
 drivers/tty/serial/clps711x.c               |  3 +--
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  3 +--
 drivers/tty/serial/digicolor-usart.c        |  3 +--
 drivers/tty/serial/dz.c                     |  3 +--
 drivers/tty/serial/fsl_linflexuart.c        |  3 +--
 drivers/tty/serial/fsl_lpuart.c             |  7 ++-----
 drivers/tty/serial/imx.c                    |  7 ++-----
 drivers/tty/serial/ip22zilog.c              |  6 ++----
 drivers/tty/serial/liteuart.c               |  3 +--
 drivers/tty/serial/max3100.c                |  4 +---
 drivers/tty/serial/max310x.c                |  5 +----
 drivers/tty/serial/men_z135_uart.c          |  5 +----
 drivers/tty/serial/meson_uart.c             |  3 +--
 drivers/tty/serial/milbeaut_usio.c          |  3 +--
 drivers/tty/serial/msm_serial.c             | 11 +++--------
 drivers/tty/serial/mvebu-uart.c             |  3 +--
 drivers/tty/serial/pch_uart.c               | 12 ++++--------
 drivers/tty/serial/pic32_uart.c             |  3 +--
 drivers/tty/serial/pmac_zilog.c             |  6 ++----
 drivers/tty/serial/rda-uart.c               |  3 +--
 drivers/tty/serial/samsung_tty.c            | 10 +++-------
 drivers/tty/serial/sb1250-duart.c           |  3 +--
 drivers/tty/serial/sc16is7xx.c              |  5 +----
 drivers/tty/serial/sccnxp.c                 |  3 +--
 drivers/tty/serial/serial-tegra.c           |  3 +--
 drivers/tty/serial/sh-sci.c                 |  5 +----
 drivers/tty/serial/sprd_serial.c            |  7 ++-----
 drivers/tty/serial/stm32-usart.c            |  7 +++----
 drivers/tty/serial/sunhv.c                  |  6 ++----
 drivers/tty/serial/sunplus-uart.c           |  4 +---
 drivers/tty/serial/sunsab.c                 |  6 ++----
 drivers/tty/serial/sunsu.c                  |  3 +--
 drivers/tty/serial/sunzilog.c               |  6 ++----
 drivers/tty/serial/timbuart.c               |  3 +--
 drivers/tty/serial/uartlite.c               |  3 +--
 drivers/tty/serial/ucc_uart.c               |  3 +--
 drivers/tty/serial/xilinx_uartps.c          |  4 +---
 drivers/tty/serial/zs.c                     |  3 +--
 44 files changed, 62 insertions(+), 145 deletions(-)

-- 
2.30.2

