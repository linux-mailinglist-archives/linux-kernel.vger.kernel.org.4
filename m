Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA765EAEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjAEMsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjAEMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:47:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A12E479E8;
        Thu,  5 Jan 2023 04:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672922874; x=1704458874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jXQCTdIu2ZeMuZ/yZOgheaRyF6UCRmg5kST3NNxQhro=;
  b=LnrnqHmyvMATPd6RpuaCaPW1waiSAUd/+j+NDcNnYHxRPj2aiCsk7yyD
   7TBg+KfGRJvDd08gPsl67FUa/0APmPQqVAswGl2tWpX+Y2UoHD/QZ1Z7a
   p8rfFxkyM2GDxw2X4T0sqPCJ0CP7YaRIagK8B6McWEC7/vxDVA1l7jjLf
   KeDvY6FYVamJvF/I16GUZ/efX2qW8JhYfDWMvjqTE61GlyHnQ41IUl6Qn
   g+Ciry2SdAHQeJRPAKEOzNDpEjEy35PWOH0+w4TQvflEXyURQFERomQkS
   X+Y/QoJNDosoeYszXSsbnqnOnmcN8jUXCtPZ2UXO86+NsBMlvWbMoCZCc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301889805"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="301889805"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:47:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="984287770"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="984287770"
Received: from khaunx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.35.181])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:47:52 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/3] serial: Separate RT288x/Au1xxx code into own file
Date:   Thu,  5 Jan 2023 14:47:41 +0200
Message-Id: <20230105124744.105950-1-ilpo.jarvinen@linux.intel.com>
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

A non-trivial amount of RT288x/Au1xxx code is encapsulated into
ifdeffery in 8250_port / 8250_early and some if/switch UPIO_AU blocks.
Create a separate file from them and do a few additional cleanups.

I kept the Kconfig entry as bool because the code has somewhat tricky
dependency chain (mips arch code and 8250_of driver). It would be nice
to make it tristate but I don't know how blocking some invalid =m + =y
combinations would be best addressed. It should probably be best done
on top of this series independent of the split itself anyway.

UPIO_AU could now be removed because it's same as UPIO_MEM for the
remaining code path but I'm unsure if that's allowed (is the port
iotype part of stable ABI or not)?

v2:
- Define register map array lengths explicitly to avoid creating
  declaration trap.

Ilpo Järvinen (3):
  serial: 8250: RT288x/Au1xxx code away from core
  serial: 8250_rt288x: Name non-standard divisor latch reg
  serial: 8250_rt288x: Remove unnecessary UART_REG_UNMAPPED

 arch/mips/alchemy/common/platform.c   |  10 +-
 drivers/tty/serial/8250/8250_core.c   |   4 +
 drivers/tty/serial/8250/8250_early.c  |  21 ----
 drivers/tty/serial/8250/8250_of.c     |   4 +-
 drivers/tty/serial/8250/8250_port.c   |  78 ---------------
 drivers/tty/serial/8250/8250_rt288x.c | 135 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/Makefile      |   1 +
 include/linux/serial_8250.h           |  14 ++-
 8 files changed, 163 insertions(+), 104 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_rt288x.c

-- 
2.30.2

