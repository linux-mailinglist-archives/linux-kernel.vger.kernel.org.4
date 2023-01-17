Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E677466D982
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjAQJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjAQJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:13:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8203BD98;
        Tue, 17 Jan 2023 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673946394; x=1705482394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YS2Uaru2Y+ZexhigBPlSvVq4z2yWZdmpShnm8VGOc2w=;
  b=Sq3U6q6ct9NQXSgvyjPA5l82Lj5QX5hFeuR9EX0LJCgIgpDkD2kzVQHU
   cB8PM084sykMiURQYVh8JC28QqfuzUZNHPjVVllGPg6rcNqiyC+J27Pu0
   L5NaumiVcXkg0py8J8M/UHReZZh91x85uooU2GZgi++DYzxK4WpO1qW/Q
   hfI/1J3avTpTJjb50MgbHqyK5URfOHqqN5RvQim0BztpFXV/4YEL8oFym
   EbJat+6stmpvcm8qrKuifKsLBah9/efKMuKDgLPnYZ559M2Qd5sGA7+Lg
   gB9UVRukzP++g6vhRiw4QXjV4CJBRyR5ioqIfH9oXlW9KP55EGvZuSVlp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324701141"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324701141"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:05:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783174305"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783174305"
Received: from tronach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.40.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:05:26 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 10/12] tty: Return bool from tty_termios_hw_change()
Date:   Tue, 17 Jan 2023 11:03:56 +0200
Message-Id: <20230117090358.4796-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
References: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change tty_termios_hw_change() to return bool.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
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

