Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593A465D714
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbjADPRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239613AbjADPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:16:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E61A233;
        Wed,  4 Jan 2023 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672845412; x=1704381412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjjW6dFqxPvZpMJtTa0hvemI7uFSxCRu5bewJdPlkFg=;
  b=QBYZIFKCp4RDHI2A6skJ/DtzCZHQj9LMjTquXytZElrH7U+3pXATraT/
   RHxXRv3sRv3stjRNhYcx+TIw3zbVgftn74S/vrYUx4mUgyX2FuNPmp63Y
   A4dBssryqVjvLwqVCzpqUxjaBf2GSLDk6Nk5wUgnynhpus4gGj4xsXqyf
   afLz4IywQvKoJJbmbPJvunaeRIYjnL9GfT71Mcyugx9eUgrp6dU9o171N
   q8wNALk5Qhgm2JZ9+MyYRHfH6KOtCwW06jct74FXZOA/NpriYnCoQxz1D
   2x7Aar09FhptoTCUGRD5IiwlI22GJJxeViXy34c1Yzz29TZKLeS8+jmyb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301644574"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301644574"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:16:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762700952"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762700952"
Received: from msvoboda-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:16:29 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/10] tty: Return bool from tty_termios_hw_change()
Date:   Wed,  4 Jan 2023 17:15:31 +0200
Message-Id: <20230104151531.73994-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
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

Change tty_termios_hw_change() return to bool and convert it to
a or-chained return statement.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_ioctl.c | 10 ++++------
 include/linux/tty.h     |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index ce511557b98b..4a80fabf6d5e 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -270,13 +270,11 @@ EXPORT_SYMBOL(tty_termios_copy_hw);
  *	between the two termios structures, or a speed change is needed.
  */
 
-int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
+bool tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
 {
-	if (a->c_ispeed != b->c_ispeed || a->c_ospeed != b->c_ospeed)
-		return 1;
-	if ((a->c_cflag ^ b->c_cflag) & ~(HUPCL | CREAD | CLOCAL))
-		return 1;
-	return 0;
+	return a->c_ispeed != b->c_ispeed ||
+	       a->c_ospeed != b->c_ospeed ||
+	       (a->c_cflag ^ b->c_cflag) & ~(HUPCL | CREAD | CLOCAL);
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

