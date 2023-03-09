Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D06B1DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCIIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCIIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BB61B1;
        Thu,  9 Mar 2023 00:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350116; x=1709886116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1gjDjb6XOju7BxrPkMiH9NjVH6xJrxEdgnWQjbfCD6k=;
  b=FDvlVHOVmQJZoiuG5w1pDjIvU06vFYMzPabMqLrf3BSYub87zBfFvdBA
   M4xG2CyxIiUeMvyRksF1gD6sJ6sqfob5wRS5FoEJLeyVdUujkt9n0vqyX
   RuMMv/0fYLUF+EyM7sn5IqRHOvpfGmZ1ICZrMCW9j0I+1xr/Yu+o6welj
   v0ePHbaeu9Fyt55RpDXW2LURtqac0WcvRh/Z7CErBb2hE0+7so5l8OOlJ
   W7qF8rUVe8LY6v3ZpFrBkdQZeG0lyi8EXWJQjJPwvFq1bwaT+/3HzfFrh
   /asDIoo6ryJF1ZPJavLkayhoBSqNvOZgV2aK4J3NhPF3lMawNhp2QSV3a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025940"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025940"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473884"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473884"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:07 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/8] n_tty: Use DIV_ROUND_UP() in room calculation
Date:   Thu,  9 Mar 2023 10:20:32 +0200
Message-Id: <20230309082035.14880-6-ilpo.jarvinen@linux.intel.com>
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

When PARMRK is set, a character can result in up to 3 chars in the read
buffer. Receive code calculates for how many characters there (at
least) is room. Convert an opencoded rounding in the calculation to use
DIV_ROUND_UP().

Note: the room variable is decremented afterwards by one which ensures
the characters will fit into the buffer for real so the code is okay
despite rounding upwards.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 2cf263de1366..6d754fc35dce 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -36,6 +36,7 @@
 #include <linux/file.h>
 #include <linux/interrupt.h>
 #include <linux/major.h>
+#include <linux/math.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/poll.h>
@@ -1692,7 +1693,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 
 		room = N_TTY_BUF_SIZE - (ldata->read_head - tail);
 		if (I_PARMRK(tty))
-			room = (room + 2) / 3;
+			room = DIV_ROUND_UP(room, 3);
 		room--;
 		if (room <= 0) {
 			overflow = ldata->icanon && ldata->canon_head == tail;
-- 
2.30.2

