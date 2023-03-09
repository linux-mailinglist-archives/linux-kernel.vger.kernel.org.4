Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F776B1D90
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCIIM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCIILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:11:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30029DE1E2;
        Thu,  9 Mar 2023 00:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349416; x=1709885416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N198pABiElaUVsS/ZpKV5b88vjIcEWFXshSTja0nvU4=;
  b=ZOTuLXnOM6fVra1tv4fxyQAXXG+4gVtXtmNxqhpQ+KJbeN/gZGtHStKf
   2KgTmrDTY4akrm614cVN77RXRFfc8c3QohBFbIX4k3pO+5YM5Q7KUWyPM
   t+Lbi0/cLfIJm8ngxnvLhX7Kib7QBbO/7o26C/dQBLlstV7UANUUnGzfw
   7BmPgrOpgo6mcqTMlHmklucGZKoiePKiQV5g8t3hleoUmbk70Nb4tUrlX
   bcWaISb2OqYjtGltm7KC5FKAnpPX8mvCPk5Nuja8iLRoRItGEyrQ1Bqsy
   FGFUPc717dnO9gw05mkM3X/4dEcheYjr0BQVMTJMbhsJeCnlNw0bboXFP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333853624"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="333853624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746228016"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746228016"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:49 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/8] serial: Rename hw_stopped to old_hw_stopped & improve logic
Date:   Thu,  9 Mar 2023 10:09:22 +0200
Message-Id: <20230309080923.11778-8-ilpo.jarvinen@linux.intel.com>
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

hw_stopped in uart_change_line_settings() stores old hw_stopped, thus
rename it appropriately.

Alter logic to check first if the hw_stopped was changed, and then pick
which function to call if it was because the logic is more obvious that
way.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 31b69e61e71d..c494cb39394b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -182,7 +182,7 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct ktermios *termios;
-	bool hw_stopped;
+	bool old_hw_stopped;
 
 	/*
 	 * If we have no tty, termios, or the port does not exist,
@@ -209,14 +209,13 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 		uport->status |= UPSTAT_DCD_ENABLE;
 
 	/* reset sw-assisted CTS flow control based on (possibly) new mode */
-	hw_stopped = uport->hw_stopped;
+	old_hw_stopped = uport->hw_stopped;
 	uport->hw_stopped = uart_softcts_mode(uport) &&
 			    !(uport->ops->get_mctrl(uport) & TIOCM_CTS);
-	if (uport->hw_stopped) {
-		if (!hw_stopped)
+	if (uport->hw_stopped != old_hw_stopped) {
+		if (!old_hw_stopped)
 			uport->ops->stop_tx(uport);
-	} else {
-		if (hw_stopped)
+		else
 			__uart_start(tty);
 	}
 	spin_unlock_irq(&uport->lock);
-- 
2.30.2

