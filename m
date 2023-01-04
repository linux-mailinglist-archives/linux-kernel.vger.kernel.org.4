Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A965D6F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbjADPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjADPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:15:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CDF193DD;
        Wed,  4 Jan 2023 07:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672845342; x=1704381342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tJ3bj3MrfiZCAxDXbBCyEWZjTJi5n8tfV2A1B0+qdBM=;
  b=dFu/L8Bdj6gG4dNeANl50zz7iXZwgDE4dLDVL5laMNP0hRlB1V5bICua
   Mv6sHLlaTb/dFirGnsTKco1Z2+SwruHBO6htwzFoZZI5H2lGA8SPrnaid
   2OdV6iByTmLXXyf+6kXkeRtowNEXZ5/7vF1AwKLy3WTgfstytUqaaoPUm
   GukutDmYyubFWunYcClPo86t2lewORcF9l+O69PE8EaBob3xfBWIKJoVE
   L7iR0AOfTFS7gejiBIs6Yv5TTv+JXd1600KIBDOHUlPg4mZ4zyC6iJrAJ
   zfE1FMScpp7/R7j8054YvyrDkblp7ChRpQxvaCjNUAReR5+NRntSHd0vQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301644274"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301644274"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:15:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762700641"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762700641"
Received: from msvoboda-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:15:39 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/10] tty/serial: bool conversions and cleanups
Date:   Wed,  4 Jan 2023 17:15:21 +0200
Message-Id: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are number of functions in tty/serial which have arguments or
return types that expect/behave like bool. Likely due to them existing
before bool was available, other types are used. Make conversions to
bool and cleanups.

Ilpo Järvinen (10):
  tty: Cleanup tty_port_set_initialized() bool parameter
  tty: Cleamup tty_port_set_suspended() bool parameter
  tty: Cleanup tty_port_set_active() bool parameter
  tty: moxa: Make local var storing tty_port_initialized() bool
  serial: Convert uart_{,port_}startup() init_hw param to bool
  tty: Convert ->carrier_raised() and callchains to bool
  tty: Convert ->dtr_rts() to take bool argument
  tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool
  serial: Make uart_handle_cts_change() status param bool
  tty: Return bool from tty_termios_hw_change()

 drivers/char/pcmcia/synclink_cs.c    | 16 ++++----
 drivers/ipack/devices/ipoctal.c      |  4 +-
 drivers/mmc/core/sdio_uart.c         | 11 +++---
 drivers/pps/clients/pps-ldisc.c      |  2 +-
 drivers/s390/char/con3215.c          |  4 +-
 drivers/staging/greybus/uart.c       |  2 +-
 drivers/tty/amiserial.c              | 10 ++---
 drivers/tty/hvc/hvc_console.c        |  4 +-
 drivers/tty/hvc/hvc_console.h        |  2 +-
 drivers/tty/hvc/hvc_iucv.c           |  4 +-
 drivers/tty/moxa.c                   | 24 ++++++------
 drivers/tty/mxser.c                  |  9 +++--
 drivers/tty/n_gsm.c                  | 14 +++----
 drivers/tty/serial/imx.c             |  2 +-
 drivers/tty/serial/max3100.c         |  2 +-
 drivers/tty/serial/max310x.c         |  3 +-
 drivers/tty/serial/serial_core.c     | 55 +++++++++++++---------------
 drivers/tty/serial/sunhv.c           |  8 ++--
 drivers/tty/synclink_gt.c            | 19 +++++-----
 drivers/tty/tty_ioctl.c              | 10 ++---
 drivers/tty/tty_port.c               | 22 +++++------
 drivers/usb/class/cdc-acm.c          |  2 +-
 drivers/usb/serial/ch341.c           |  9 ++---
 drivers/usb/serial/console.c         |  2 +-
 drivers/usb/serial/cp210x.c          |  4 +-
 drivers/usb/serial/cypress_m8.c      |  6 +--
 drivers/usb/serial/digi_acceleport.c |  6 +--
 drivers/usb/serial/f81232.c          |  8 ++--
 drivers/usb/serial/f81534.c          |  2 +-
 drivers/usb/serial/ftdi_sio.c        |  2 +-
 drivers/usb/serial/generic.c         |  2 +-
 drivers/usb/serial/ipw.c             |  2 +-
 drivers/usb/serial/keyspan.c         |  2 +-
 drivers/usb/serial/keyspan_pda.c     |  2 +-
 drivers/usb/serial/mct_u232.c        |  4 +-
 drivers/usb/serial/mxuport.c         |  2 +-
 drivers/usb/serial/pl2303.c          |  9 ++---
 drivers/usb/serial/quatech2.c        |  2 +-
 drivers/usb/serial/sierra.c          |  2 +-
 drivers/usb/serial/spcp8x5.c         |  9 ++---
 drivers/usb/serial/ssu100.c          |  2 +-
 drivers/usb/serial/upd78f0730.c      |  6 +--
 drivers/usb/serial/usb-serial.c      |  6 +--
 drivers/usb/serial/usb-wwan.h        |  2 +-
 drivers/usb/serial/usb_wwan.c        |  2 +-
 drivers/usb/serial/xr_serial.c       |  6 +--
 include/linux/serial_core.h          |  6 +--
 include/linux/tty.h                  |  2 +-
 include/linux/tty_ldisc.h            |  4 +-
 include/linux/tty_port.h             | 10 ++---
 include/linux/usb/serial.h           |  6 +--
 net/bluetooth/rfcomm/tty.c           |  2 +-
 52 files changed, 170 insertions(+), 188 deletions(-)

-- 
2.30.2

