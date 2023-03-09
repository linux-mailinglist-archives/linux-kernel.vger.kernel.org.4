Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9A6B1DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCIIXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCIIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2FE063B;
        Thu,  9 Mar 2023 00:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350078; x=1709886078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3m76VGZBewKkEU33NbY6qcZRyAz+1m3GJXuwbf9sfA=;
  b=ZTn75XKTAgUWFkL0SfY1mnyhLBIXK7rutOzTjGWEO0iAzWMGAACWfFbp
   0xBaq3rEI3aAGCQPtPdgUFg6PDJSBfW2/v3yM0vvpor5oGQZuIdqqRlF8
   PhG8vjMP/QteBp4HJwdtE08C43QihS7FNWwhtDn9Xboy93UNCeHXP4E+M
   Xis5mr/X0ODdMgQpkqFhRDqb7JLINwn/bKQsAHRzT4CK8+Ohd5WrcRJ5R
   9twLrUrFWLPn6Y+QqAQCDcDM544iZytE5sPAyM/BLrhi341zQwNM5GPRx
   1kugKG23Aq2yslsdHXlcsSgT00ksNoP/LHSs6KeM9tehNhoSbq1Tx36bu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025818"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025818"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473860"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473860"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:20:58 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/8] tty_ioctl: Use BIT() for internal flags
Date:   Thu,  9 Mar 2023 10:20:29 +0200
Message-Id: <20230309082035.14880-3-ilpo.jarvinen@linux.intel.com>
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

Convert internal flags to use BIT().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_ioctl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 12983ce4e43e..32ff9959b565 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -7,6 +7,7 @@
  * discipline handling modules (like SLIP).
  */
 
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/termios.h>
 #include <linux/errno.h>
@@ -40,10 +41,10 @@
 /*
  * Internal flag options for termios setting behavior
  */
-#define TERMIOS_FLUSH	1
-#define TERMIOS_WAIT	2
-#define TERMIOS_TERMIO	4
-#define TERMIOS_OLD	8
+#define TERMIOS_FLUSH	BIT(0)
+#define TERMIOS_WAIT	BIT(1)
+#define TERMIOS_TERMIO	BIT(2)
+#define TERMIOS_OLD	BIT(3)
 
 
 /**
-- 
2.30.2

