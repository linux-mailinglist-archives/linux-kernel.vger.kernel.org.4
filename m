Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304576DE169
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDKQrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDKQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:47:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE9D59D1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681231662; x=1712767662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nL/YARdljktZsY9OqaVduF5sOquUaghXU3vou5oKoNw=;
  b=l2qk7It2kRCoadW7P4byYwBoj5o478FkfDbLftnJoqtNLW8xna3ASyW+
   PntqxeGXOSGUq1WPCBf9PldC5KkDJbluMkecvaAnBhgTjKZjTr+1SwFBA
   ZzUqnB9hBd9dCpyAaA4dOhEtUFuocdup4oPpVYyI/3MxxJGCMIpq9Bk9Z
   iq43WOMeXVZ7XsM//7yYAPw7vlMUyazSdnA3Va/dE7aKHFVBM4p7ALOX9
   AX4sQQCCP+rBVZssC30ZsDJAPQ4pAjfL4SUgPvysJmlDLG27II+5vWysO
   qF4Fw6l++hnomDjNu9kclNL7SpeIjLMF8tTQeFtFY26pOs+9Z8l9Q0ckv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="371522350"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="371522350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="832400788"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="832400788"
Received: from rwambsga-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.212.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:47:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Daniel Starke <daniel.starke@siemens.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] n_gsm: Use array_index_nospec() with index that comes from userspace
Date:   Tue, 11 Apr 2023 19:45:32 +0300
Message-Id: <20230411164532.64175-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dc.channel used for indexing comes directly from copy_from_user(). Use
array_index_nospec() to mitigate speculative side-channel.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-serial/64306d13.ONswMlyWlVKLGkKR%25lkp@intel.com/
Fixes: afe3154ba87e ("tty: n_gsm: add ioctl for DLC config via ldisc handle")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_gsm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b7e1369a035c..21985432794f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -42,6 +42,7 @@
 #include <linux/ctype.h>
 #include <linux/mm.h>
 #include <linux/math.h>
+#include <linux/nospec.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
@@ -3718,8 +3719,8 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 	struct gsm_config_ext ce;
 	struct gsm_dlci_config dc;
 	struct gsm_mux *gsm = tty->disc_data;
+	unsigned int base, addr;
 	struct gsm_dlci *dlci;
-	unsigned int base;
 
 	switch (cmd) {
 	case GSMIOC_GETCONF:
@@ -3748,9 +3749,10 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 			return -EFAULT;
 		if (dc.channel == 0 || dc.channel >= NUM_DLCI)
 			return -EINVAL;
-		dlci = gsm->dlci[dc.channel];
+		addr = array_index_nospec(dc.channel, NUM_DLCI);
+		dlci = gsm->dlci[addr];
 		if (!dlci) {
-			dlci = gsm_dlci_alloc(gsm, dc.channel);
+			dlci = gsm_dlci_alloc(gsm, addr);
 			if (!dlci)
 				return -ENOMEM;
 		}
@@ -3763,9 +3765,10 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 			return -EFAULT;
 		if (dc.channel == 0 || dc.channel >= NUM_DLCI)
 			return -EINVAL;
-		dlci = gsm->dlci[dc.channel];
+		addr = array_index_nospec(dc.channel, NUM_DLCI);
+		dlci = gsm->dlci[addr];
 		if (!dlci) {
-			dlci = gsm_dlci_alloc(gsm, dc.channel);
+			dlci = gsm_dlci_alloc(gsm, addr);
 			if (!dlci)
 				return -ENOMEM;
 		}
-- 
2.30.2

