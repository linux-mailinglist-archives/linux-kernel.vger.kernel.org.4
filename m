Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E35665DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbjAKOZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbjAKOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:24:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16C618693;
        Wed, 11 Jan 2023 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447087; x=1704983087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BA6+VzTrzXJU5RNlgIhIBoCQlD0/oKxFAfCpVwMo5lA=;
  b=C9nw4RuG3PVcw+NWX/LCqUboT8RcxNgThl0/Jftws5uI61f8c8VZt/Y/
   VsNZxKazVBovFsEX8IyRubL/dbtgW18VFF9B66mrE4oj4+j8y8Tt7t0UX
   t6h75ayGTGI8NKZ4DZf+fNfRDaR+cvrgoRnZ9WCMHyaqQpLFYAjfw1/mH
   +g7gvTS3a+WcOo2O6C6Cg2X3Vk3PAqqgmrnpEqsoXVcC7SSnr+Zzf0Fpe
   /DOHPkYZug6RJSWkG1E2boqMOmnAaM4CCPORtoGttgGeRc/UoXFOBWHKE
   w5dZyXehcetejJ/ATLFjWG94afwQAZ9KDJXzeHqf4owfMNy96QMeGQKnA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303793731"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303793731"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607382037"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607382037"
Received: from mihaiana-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.222.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:43 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 10/13] tty: Return bool from tty_termios_hw_change()
Date:   Wed, 11 Jan 2023 16:23:28 +0200
Message-Id: <20230111142331.34518-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
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

Change tty_termios_hw_change() to return bool.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

