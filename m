Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C669A6FF132
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjEKMLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbjEKMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:11:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA593EB;
        Thu, 11 May 2023 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683807061; x=1715343061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GgId0k8oBG7lRV4xr41min05HrG3B+vzXuK7KKW5Bc8=;
  b=DxbfSPnUpFa5kbMdJbrnIRel+IWx+mhBv18J3qnPM+mnBBHJ5Vr8JeT0
   r9ZEm90vY7WN44ujVit6pIDT1vzsKZgE8nzF0Wi1T6d/F2iuRK1hPBdiP
   llKkiEUZHjmzBzmvpzDeSF/UFERjqp4ZLux24KcQxyeacyNL34KJT7lHO
   egUbnn+Db1j6KE0FwT0odSjV1B/jr+1LJeuFazNpScqCVzGHjvuXeckfZ
   NnU/5tZGhG28JPzeVrmaOqCEwca22SOL4pYBryslM2UlxJeljagw5Gn2t
   pd9CrSjxFMbHaOBWpf9oe8RoMq9cAnndA3OnkFVXrQ4/EaDYmNu4+D/3X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330839030"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="330839030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843921173"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843921173"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:10:35 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/6] serial: Separate RT288x/Au1xxx code into own file
Date:   Thu, 11 May 2023 15:10:23 +0300
Message-Id: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A non-trivial amount of RT288x/Au1xxx code is encapsulated into
ifdeffery in 8250_port / 8250_early and some if/switch UPIO_AU blocks.
Create a separate file from them and do a few additional cleanups.

I kept the Kconfig entry as bool because the code has somewhat tricky
dependency chain (mips arch code and 8250_of driver).

v4:
- Type changes
	- bugs: unsigned short -> u16
	- use u32 for old_dl too

v3:
- Convert dl_read/write() to take u32 arg + name the args
- Separatate the non-driver datastructure changes & document them better
- Fix build when SERIAL_8250=m + SERIAL_8250_RT288X=y (+note reasoning
  in the commit message for future reference)
- Use u8 for arrays that no longer have < 0 values

v2:
- Define register map array lengths explicitly to avoid creating
  declaration trap.

Ilpo Järvinen (6):
  serial: 8250: Change dl_read/write to handle value as u32
  serial: 8250: Document uart_8250_port's ->dl_read/write()
  serial: 8250: Add dl_read/write, bugs and mapsize into
    plat_serial8250_port
  serial: 8250: RT288x/Au1xxx code away from core
  serial: 8250_rt288x: Name non-standard divisor latch reg
  serial: 8250_rt288x: Remove unnecessary UART_REG_UNMAPPED

 arch/mips/alchemy/common/platform.c     |  10 +-
 drivers/tty/serial/8250/8250.h          |   4 +-
 drivers/tty/serial/8250/8250_core.c     |   4 +
 drivers/tty/serial/8250/8250_early.c    |  21 ----
 drivers/tty/serial/8250/8250_em.c       |   4 +-
 drivers/tty/serial/8250/8250_of.c       |   4 +-
 drivers/tty/serial/8250/8250_port.c     |  84 +--------------
 drivers/tty/serial/8250/8250_pxa.c      |   2 +-
 drivers/tty/serial/8250/8250_rt288x.c   | 136 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_uniphier.c |   4 +-
 drivers/tty/serial/8250/Makefile        |   1 +
 drivers/tty/serial/Makefile             |   2 +-
 include/linux/serial_8250.h             |  44 ++++++--
 13 files changed, 201 insertions(+), 119 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_rt288x.c

-- 
2.30.2

