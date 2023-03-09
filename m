Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9696B1DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCIIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCIIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C7CC666;
        Thu,  9 Mar 2023 00:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350079; x=1709886079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NVk2Uwml/dLcUozFXuj/Wgf+vlU8vTU7nn1wZsqKalg=;
  b=YxAzWDqat2FJf+b5kIueKO0FBplLrOtYCkTudjvCHuZtihtcNn9sY5yb
   fh2hamzNRkG09Ta1CcrVFUEA+Htsh680pv4Mcrrn90xaqAXsiF+jA5Eo2
   0qrhKBU3lRaRrI2Fkznq00XScR61dA237AH/vgnNxpyarjW6ekPyHKAkl
   dXXpDp+rF+blMscLwIAFo2mIEnstZ3kPWiX4c1ibOD6xHqzL9QltCHhWZ
   +AmD9zgU5HHfFD0zAz+e3Yt1stq1Gsl1yYsla1F1M2LrnAZaHYwQdOMOu
   bsVuvEkAvr2qRe4piCOvJGfxdwMl/FfYRbe6IsOZ0C6jE4xH4IuKHfQ/M
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025823"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025823"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473870"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473870"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:01 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/8] Bluetooth: hci_ldisc: Fix tty_set_termios() return value assumptions
Date:   Thu,  9 Mar 2023 10:20:30 +0200
Message-Id: <20230309082035.14880-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
References: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_set_termios() never returns anything else than 0. Make the debug
prints to look directly into the new termios instead to check CRTSCTS
state.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/bluetooth/hci_ldisc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 865112e96ff9..efdda2c3fce8 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -323,9 +323,9 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		/* Disable hardware flow control */
 		ktermios = tty->termios;
 		ktermios.c_cflag &= ~CRTSCTS;
-		status = tty_set_termios(tty, &ktermios);
+		tty_set_termios(tty, &ktermios);
 		BT_DBG("Disabling hardware flow control: %s",
-		       status ? "failed" : "success");
+		       (tty->termios.c_cflag & CRTSCTS) ? "failed" : "success");
 
 		/* Clear RTS to prevent the device from sending */
 		/* Most UARTs need OUT2 to enable interrupts */
@@ -357,9 +357,9 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		/* Re-enable hardware flow control */
 		ktermios = tty->termios;
 		ktermios.c_cflag |= CRTSCTS;
-		status = tty_set_termios(tty, &ktermios);
+		tty_set_termios(tty, &ktermios);
 		BT_DBG("Enabling hardware flow control: %s",
-		       status ? "failed" : "success");
+		       !(tty->termios.c_cflag & CRTSCTS) ? "failed" : "success");
 	}
 }
 
-- 
2.30.2

