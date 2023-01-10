Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB55663FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjAJMF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjAJMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:04:52 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F25DE40;
        Tue, 10 Jan 2023 04:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673352232; x=1704888232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNJJld7xBe207RpnyaAIsARoz0ICCLJBlrA8o5yl/fY=;
  b=lvqFlVAryz6tE2q+uuzDYWU6ij6N5Tx/v53EKGZ4t2QzgywDwZBshhb1
   dyMP0IhZsZ3JSZtjX7AexuNL4IKAQ1niMakgQTx68G7JcI2gyPpH+rBF9
   Yqr2AefiDu8uekKjkt7CZjD4j4oDObEMIF9ky7RwQAkllAxI88bBF7foS
   Cy8KAPwzA8oqa847iJSB9GiIHK1tfG3/NZBDUxoMuhuCD4JfXys0KBfL/
   MU4vZxox67K3vviiVYR2mZE3wqgZg3jYNVWiMWb2o1Xsxsr/0K1kbZYQN
   aLvsa+ba0xql3dknOUyC58l0b6ViOKP2N7N0o/ho8OMxevHlGqfZ8cnnB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350350230"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350350230"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="799407021"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799407021"
Received: from gbocanex-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.115])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:49 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 10/13] tty: Return bool from tty_termios_hw_change()
Date:   Tue, 10 Jan 2023 14:02:23 +0200
Message-Id: <20230110120226.14972-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
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

Change tty_termios_hw_change() to return bool.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_ioctl.c | 8 ++++----
 include/linux/tty.h     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index ce511557b98b..12983ce4e43e 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -270,13 +270,13 @@ EXPORT_SYMBOL(tty_termios_copy_hw);
  *	between the two termios structures, or a speed change is needed.
  */
 
-int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
+bool tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
 {
 	if (a->c_ispeed != b->c_ispeed || a->c_ospeed != b->c_ospeed)
-		return 1;
+		return true;
 	if ((a->c_cflag ^ b->c_cflag) & ~(HUPCL | CREAD | CLOCAL))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 EXPORT_SYMBOL(tty_termios_hw_change);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 730c3301d710..093935e97f42 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -453,7 +453,7 @@ unsigned char tty_get_char_size(unsigned int cflag);
 unsigned char tty_get_frame_size(unsigned int cflag);
 
 void tty_termios_copy_hw(struct ktermios *new, const struct ktermios *old);
-int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
+bool tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
 int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
 void tty_wakeup(struct tty_struct *tty);
-- 
2.30.2

