Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5008B6EC450
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 06:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjDXEUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 00:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXEUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:20:42 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 06BCC1726;
        Sun, 23 Apr 2023 21:20:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 620EC180120C7B;
        Mon, 24 Apr 2023 12:20:30 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Suhui <suhui@nfschina.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Suhui <suhui@nfschina.com>
Subject: [PATCH] usb: typec: tcpm: remove unnecessary (void*) conversions
Date:   Mon, 24 Apr 2023 12:19:40 +0800
Message-Id: <20230424041940.132866-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct fusb302_chip *) or (struct tcpm_port *).

Signed-off-by: Suhui <suhui@nfschina.com>
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
index 1ee774c263f0..ab3a54662ed9 100644
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
2.30.2

