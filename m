Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A075F625CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiKKOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiKKOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:25:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894AC391E9;
        Fri, 11 Nov 2022 06:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668176708; x=1699712708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m11pAB5y0zFrcscE/1egpbuT7jD+h/gvZLDvumXx/v8=;
  b=FLByUkvFGnOuQXxcDdqwDP0D+3v05oeu5wS5EMhNt2+sV/QDkwViIb7J
   J1aAOXMgquDjMrZkT2YCineTIRToc99cdcE6hK7jZkxDUQPK3VogvTxNa
   4jvtCfW7M37225wsXeIjXE59bVhH9Jt3IEyyLxitXVb5vI/VCPJgqGThh
   quWOmxWAudTyIdYiwgVw2ipOBO6AQaa8o0LZKkz2w3a+APdVls4pxY1fl
   /mpSU5gNG8j2iiBysnVGWIhTW9RjKr/eQhws5YxUILjLaU2+Zm1rOcuWz
   3itqtAeQl3wtXurMCjVy53YUHgvVG2dSmYXuwHcWWo3DmccagIEj5Z8D5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292007805"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="292007805"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 06:25:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="632044092"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="632044092"
Received: from iglushko-mobl1.ger.corp.intel.com ([10.249.44.68])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 06:25:05 -0800
Date:   Fri, 11 Nov 2022 16:25:02 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] n_tty: Rename tail to old_tail in n_tty_read()
Message-ID: <22b37499-ff9a-7fc1-f6e0-58411328d122@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1634807828-1668176707=:1606"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1634807828-1668176707=:1606
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

The local tail variable in n_tty_read() is used for one purpose, it
keeps the old tail. Thus, rename it appropriately to improve code
readability.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/n_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 597019690ae6..c8f56c9b1a1c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2130,7 +2130,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	ssize_t retval = 0;
 	long timeout;
 	bool packet;
-	size_t tail;
+	size_t old_tail;
 
 	/*
 	 * Is this a continuation of a read started earler?
@@ -2193,7 +2193,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	}
 
 	packet = tty->ctrl.packet;
-	tail = ldata->read_tail;
+	old_tail = ldata->read_tail;
 
 	add_wait_queue(&tty->read_wait, &wait);
 	while (nr) {
@@ -2282,7 +2282,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		if (time)
 			timeout = time;
 	}
-	if (tail != ldata->read_tail)
+	if (old_tail != ldata->read_tail)
 		n_tty_kick_worker(tty);
 	up_read(&tty->termios_rwsem);
 

-- 
tg: (15730dc45dc7..) tty/rename-tail (depends on: tty-next)
--8323329-1634807828-1668176707=:1606--
