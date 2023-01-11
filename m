Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C4665DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjAKOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjAKOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:23:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EAA13F03;
        Wed, 11 Jan 2023 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447024; x=1704983024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AmhnEiGab9Eaur3Fmk7nmA032oNYijkXIBqHp/6Omb0=;
  b=UILuiBo54grvsZ27vFQe3N7tTTHi7Dyw1TZfwgEEtgRzvp2GORUaYCi7
   Gy2Ut/5h+jiRdFhuNMr8kQNldErhtsD7mKOdt+Xn6o2TznHxPT5IemAwA
   qU57CIMO11W60zecoluXwzJANOl+HlaBoyCMTfEPnwAeDRtPyhwrgdVHl
   XrhtBMKNMjYyFnCnlOcbEBfz4iwDhJsNV+OvJsDBiY93xSJu7a3aNJFKx
   ptHjCQ1oRMeiSGvv6u7J5hcaGlEXXb6td5YvYzRlYeuFzDCJDfba/yHQj
   I9LtEInmT1t0hWwF82wfe/tO8oQT53RE9EP0oG0o/PFk92Y3sZyIM0t5A
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303793407"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303793407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:23:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607381759"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607381759"
Received: from mihaiana-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.222.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:23:40 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 00/13] tty/serial: bool conversions and cleanups
Date:   Wed, 11 Jan 2023 16:23:18 +0200
Message-Id: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

v3:
- moxa: Fix function signature in comment
- moxa: Rearrange comment (0: off, 1: on) removal from rename change
  to bool change (effect is internal to the series)

v2:
- Call dtr/rts parameters/variables consistently "active"
- Don't chain one return statement with ||
- Don't change function signatures to >80 chars ("while at it")
- moxa: differentiated dtr and status variables

Ilpo Järvinen (13):
  tty: Cleanup tty_port_set_initialized() bool parameter
  tty: Cleamup tty_port_set_suspended() bool parameter
  tty: Cleanup tty_port_set_active() bool parameter
  tty: moxa: Make local var storing tty_port_initialized() bool
  serial: Convert uart_{,port_}startup() init_hw param to bool
  tty: Convert ->carrier_raised() and callchains to bool
  tty: Convert ->dtr_rts() to take bool argument
  tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool
    active
  serial: Make uart_handle_cts_change() status param bool active
  tty: Return bool from tty_termios_hw_change()
  tty/serial: Call ->dtr_rts() parameter active consistently
  tty: moxa: Rename dtr/rts parameters/variables to active
  usb/serial: Rename dtr/rts parameters/variables to active

 drivers/char/pcmcia/synclink_cs.c    | 18 +++---
 drivers/ipack/devices/ipoctal.c      |  4 +-
 drivers/mmc/core/sdio_uart.c         | 13 ++---
 drivers/pps/clients/pps-ldisc.c      |  6 +-
 drivers/s390/char/con3215.c          |  4 +-
 drivers/staging/greybus/uart.c       |  4 +-
 drivers/tty/amiserial.c              | 12 ++--
 drivers/tty/hvc/hvc_console.c        |  4 +-
 drivers/tty/hvc/hvc_console.h        |  2 +-
 drivers/tty/hvc/hvc_iucv.c           |  6 +-
 drivers/tty/moxa.c                   | 82 ++++++++++++++--------------
 drivers/tty/mxser.c                  | 11 ++--
 drivers/tty/n_gsm.c                  | 16 +++---
 drivers/tty/serial/imx.c             |  2 +-
 drivers/tty/serial/max3100.c         |  2 +-
 drivers/tty/serial/max310x.c         |  3 +-
 drivers/tty/serial/serial_core.c     | 65 +++++++++++-----------
 drivers/tty/serial/sunhv.c           |  8 +--
 drivers/tty/synclink_gt.c            | 21 +++----
 drivers/tty/tty_ioctl.c              |  8 +--
 drivers/tty/tty_port.c               | 22 ++++----
 drivers/usb/class/cdc-acm.c          |  4 +-
 drivers/usb/serial/ch341.c           | 11 ++--
 drivers/usb/serial/console.c         |  2 +-
 drivers/usb/serial/cp210x.c          |  6 +-
 drivers/usb/serial/cypress_m8.c      |  6 +-
 drivers/usb/serial/digi_acceleport.c |  6 +-
 drivers/usb/serial/f81232.c          | 10 ++--
 drivers/usb/serial/f81534.c          |  4 +-
 drivers/usb/serial/ftdi_sio.c        |  6 +-
 drivers/usb/serial/generic.c         | 10 ++--
 drivers/usb/serial/ipw.c             |  8 +--
 drivers/usb/serial/keyspan.c         |  6 +-
 drivers/usb/serial/keyspan_pda.c     |  4 +-
 drivers/usb/serial/mct_u232.c        |  6 +-
 drivers/usb/serial/mxuport.c         |  4 +-
 drivers/usb/serial/pl2303.c          | 11 ++--
 drivers/usb/serial/quatech2.c        |  6 +-
 drivers/usb/serial/sierra.c          |  6 +-
 drivers/usb/serial/spcp8x5.c         | 11 ++--
 drivers/usb/serial/ssu100.c          |  6 +-
 drivers/usb/serial/upd78f0730.c      |  8 +--
 drivers/usb/serial/usb-serial.c      |  8 +--
 drivers/usb/serial/usb-wwan.h        |  2 +-
 drivers/usb/serial/usb_wwan.c        |  6 +-
 drivers/usb/serial/xr_serial.c       |  8 +--
 include/linux/serial_core.h          |  6 +-
 include/linux/tty.h                  |  2 +-
 include/linux/tty_ldisc.h            |  4 +-
 include/linux/tty_port.h             | 10 ++--
 include/linux/usb/serial.h           |  6 +-
 net/bluetooth/rfcomm/tty.c           |  2 +-
 52 files changed, 248 insertions(+), 260 deletions(-)

-- 
2.30.2

