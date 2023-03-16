Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A776BC8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCPIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCPIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:24:36 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5C648E37;
        Thu, 16 Mar 2023 01:24:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3F1061A0099A;
        Thu, 16 Mar 2023 16:24:28 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 11QE_HsTtNrT; Thu, 16 Mar 2023 16:24:27 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D4BFD1A0079E;
        Thu, 16 Mar 2023 16:24:26 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] usb: typec: tcpm: remove unnecessary (void*) conversions
Date:   Thu, 16 Mar 2023 16:23:38 +0800
Message-Id: <20230316082338.18388-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 2 +-
 drivers/usb/typec/tcpm/tcpm.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 1ffce00d94b4..4b7b8f6af3ca 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -190,7 +190,7 @@ static void fusb302_log(struct fusb302_chip *chip, const char *fmt, ...)
 
 static int fusb302_debug_show(struct seq_file *s, void *v)
 {
-	struct fusb302_chip *chip = (struct fusb302_chip *)s->private;
+	struct fusb302_chip *chip = s->private;
 	int tail;
 
 	mutex_lock(&chip->logbuffer_lock);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a0d943d78580..e8bfe3f57ab4 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -737,7 +737,7 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
 
 static int tcpm_debug_show(struct seq_file *s, void *v)
 {
-	struct tcpm_port *port = (struct tcpm_port *)s->private;
+	struct tcpm_port *port = s->private;
 	int tail;
 
 	mutex_lock(&port->logbuffer_lock);
-- 
2.11.0

