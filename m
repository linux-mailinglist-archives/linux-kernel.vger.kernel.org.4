Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72F46B1DDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCIIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCIIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B991EFC7;
        Thu,  9 Mar 2023 00:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350104; x=1709886104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LugKJEKmoFir+JyJxq1ICb/Yr9xuZ+hFG2k0xUqfkNU=;
  b=JavNjAz9DxTpoHbBRBTfeaQ5KnbVSbF+oeRVvcOv81pe48f3BM30Eu9W
   L0MuPEH2MFycL7JKyWK4xK5V+0oU0gHdz3Bnu8A863ptgD3zdheAogJMC
   mghV0Fi2z1l+Owb919l0iuZC4C+vvTTXQfM0DAk0TUyAfPyw4mQdTvNqw
   NRrtDuynaY160M7E1Di1h5XiqfoXMNk8nUplZuHyup3p8Y6dbO3ItXbwH
   whwq2odl6bDGlfRTAdl87MwMqJv9xSZ3kDmLBW4eCzOyWs3i61geBWEJK
   PMLuRXm4k65fNDWAFrO2DgyqGzXqDjXUNkdE9yQ/Ois0pYhenT1+JJerK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025901"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025901"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473886"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473886"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:10 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/8] n_tty: Cleanup includes
Date:   Thu,  9 Mar 2023 10:20:33 +0200
Message-Id: <20230309082035.14880-7-ilpo.jarvinen@linux.intel.com>
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

n_tty uses:
	- bitmap_zero() from linux/bitmap.h
	- EXPORT_SYMBOL_GPL() from linux/export.h
	- jiffies, time_after() from linux/jiffies.h

Add includes.

n_tty uses nothing from:
	- linux/audit.h
	- linux/interrupt.h
	- linux/major.h
	- linux/mm.h
	- linux/module.h
	- linux/timer.h

Remove those includes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6d754fc35dce..0481e57077f1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -28,24 +28,21 @@
  *		EAGAIN
  */
 
-#include <linux/audit.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/fcntl.h>
 #include <linux/file.h>
-#include <linux/interrupt.h>
-#include <linux/major.h>
+#include <linux/jiffies.h>
 #include <linux/math.h>
-#include <linux/mm.h>
-#include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/ratelimit.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/timer.h>
 #include <linux/tty.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
-- 
2.30.2

