Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075F86BE845
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCQLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjCQLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:37:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72520DDF19;
        Fri, 17 Mar 2023 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679053005; x=1710589005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yc4OPTfM/oJcgtZ6y2TEuDn8PhNC+hKxLaa83kFYetw=;
  b=Y/n8Sm0jZ06+98Dm6PKQ2Rw0X9/mchdIn2eO5y/5k3ZLIoWdBlzuqurv
   DKkpB8gZe60Iikw6KQmur7BRLrgMjWMOw+6hLtt6ovDCgt0TNR3FfEi5A
   3yiaxSmn3p3I+SFbXzQRIu3yy+8iy98Ps1hC3kjLi1Cp/p2e/xRxKDAkd
   hTHo6x5EO9RP39fA69y4Cj/EQRjVvPAKR08Q4JfvYR37v8lRrK5vfVf43
   uB2Gs9lUHaaKYS/+zq+6OkklDre1tBKqY6x1haAMNFpPtdjerNsYd/obU
   Lc5ef5G+ULvgkGYYCMee49ToFKHv+LI54yxeL8u1Kf4kwQJW2MT5/hmU0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339779159"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="339779159"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="680270094"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="680270094"
Received: from bstach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.221.222])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:33:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/2] tty/serial: Fix tcsetattr() TCSADRAIN/FLUSH and write() races
Date:   Fri, 17 Mar 2023 13:33:16 +0200
Message-Id: <20230317113318.31327-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two races related TCSADRAIN/FLUSH. One in tty core and the other
that can occur when 8250 UART is using DMA for Tx.

These might be slightly controversial as it requires userspace to race
write() with tcsetattr() to trigger these races. But since the races
still seem fixable on kernel side, I made these patches.

v2:
- Switch DMA Tx running / LSR Tx empty checks order due to fast/slowness
- Calculate the result in serial8250_tx_empty() directly

Ilpo Järvinen (2):
  tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
  serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

 drivers/tty/serial/8250/8250.h      | 12 ++++++++
 drivers/tty/serial/8250/8250_port.c |  7 +++--
 drivers/tty/tty.h                   |  2 ++
 drivers/tty/tty_io.c                |  4 +--
 drivers/tty/tty_ioctl.c             | 45 +++++++++++++++++++++--------
 5 files changed, 53 insertions(+), 17 deletions(-)

-- 
2.30.2

