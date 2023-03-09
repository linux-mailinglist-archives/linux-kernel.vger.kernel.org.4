Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCBC6B1D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCIILB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCIIKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:10:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0414794A7B;
        Thu,  9 Mar 2023 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349395; x=1709885395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5cdTwyQdDsMQRbq0AF2mKviGSSpKyj5Y/PsWAMzXUo=;
  b=nb+nP12dYJeE9nTkGYeFIUr8iFI0Zhm8SSfiCC8/SWv1joKSRYD2a1Cn
   xeTCtQ2/Y3gtR/cQPvcAOpIiLR9JtKwLtjQdc2DG7Qkpj5k4iAGS85Lhu
   LfVqACfsaXnTOYuoVWrYM1lrtFM+eUZrDWBC5+fzVYW4sE80RDnanfu2C
   sMc/W9gQ46EguIHGMwn2ivwzJBhXOP7C0T7vfeAKtlOIp76+Oe2yMzFJ0
   lHEBQTuUJnUx4A4U1U7PJDoXGh0BWrQ2EVES0WULg3Awela3YBgi5ZBGE
   Mm7AEU1siVZgaKCq87A77YP8BowMylWITUCZXNNKqBCgHMxFYnTBM1TqC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333853562"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="333853562"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746227966"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746227966"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:36 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/8] serial: Use B0 instead of implicit zero assumption
Date:   Thu,  9 Mar 2023 10:09:17 +0200
Message-Id: <20230309080923.11778-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
References: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
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

Compare against B0 rather than assume B0 equals zero, which is true for
all archs but explicit B0 makes the code more obvious.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ee2aabcc8943..296d2c33ea7a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1662,10 +1662,10 @@ static void uart_set_termios(struct tty_struct *tty,
 	cflag = tty->termios.c_cflag;
 
 	/* Handle transition to B0 status */
-	if ((old_termios->c_cflag & CBAUD) && !(cflag & CBAUD))
+	if (((old_termios->c_cflag & CBAUD) != B0) && ((cflag & CBAUD) == B0))
 		uart_clear_mctrl(uport, TIOCM_RTS | TIOCM_DTR);
 	/* Handle transition away from B0 status */
-	else if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
+	else if (((old_termios->c_cflag & CBAUD) == B0) && ((cflag & CBAUD) != B0)) {
 		unsigned int mask = TIOCM_DTR;
 
 		if (!(cflag & CRTSCTS) || !tty_throttled(tty))
-- 
2.30.2

