Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FD6BD0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCPNZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCPNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:25:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790E1E5D8;
        Thu, 16 Mar 2023 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678973102; x=1710509102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ktRhPuTr6t06vKe7BSUmf4gFWjPQpxmETy1bCwjLsq8=;
  b=D93yLrkFZ03FWrSRLe/doOz5ARb4/Uvequ/yLvqOeHaSf16aMro3tc/d
   VedZO+YGCS2yq9ep7RMJ6Bvzjf24nub1KcOhjNgigiiU1O5xMb84iiXkG
   5X8JtCpqW+29uETDThKiZDxXSZsHRMxqGmaEjyiA/O1tHEyZVzf/FBo9u
   h+zaRrA1YgGXVFt7VbHLVpGQ1Wqz78NNB/6raC3+z8Tv9U7jBV7sDR9fE
   MPqkJY8PBJXLRGQmKWh1978OOev+DIZVxEii43TCNfpCnYsgD5sFoGIE/
   pDvtY4Hevra69YZzN+hoYflPEHa0ULEtmYaWgG35lfNgySLShIcFGbh1E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="338003184"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="338003184"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 06:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="710109070"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="710109070"
Received: from trybicki-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.63.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 06:24:59 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] tty/serial: Fix tcsetattr() TCSADRAIN/FLUSH and write() races
Date:   Thu, 16 Mar 2023 15:24:50 +0200
Message-Id: <20230316132452.76478-1-ilpo.jarvinen@linux.intel.com>
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

Fix two races related TCSADRAIN/FLUSH. One in tty core and the other
that can occur when 8250 UART is using DMA for Tx.

These might be slightly controversial as it requires userspace to race
write() with tcsetattr() to trigger these races. But since the races
still seem fixable on kernel side, I made these patches.

Ilpo Järvinen (2):
  tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
  serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

 drivers/tty/serial/8250/8250.h      | 12 ++++++++
 drivers/tty/serial/8250/8250_port.c |  7 ++++-
 drivers/tty/tty.h                   |  2 ++
 drivers/tty/tty_io.c                |  4 +--
 drivers/tty/tty_ioctl.c             | 45 +++++++++++++++++++++--------
 5 files changed, 55 insertions(+), 15 deletions(-)

-- 
2.30.2

