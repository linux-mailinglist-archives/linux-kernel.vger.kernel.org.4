Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F72746000
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGCPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:42:07 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5398CD;
        Mon,  3 Jul 2023 08:42:05 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-311367a3e12so6134607f8f.2;
        Mon, 03 Jul 2023 08:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688398924; x=1690990924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esng/Li8TZp8uQexQ4Q5eaRcrM+Ti1P/FSD7RWq9dOI=;
        b=NKwv6DlkYJNksHn44kDcAyPMqNZfJhZbpdUQC08o9O9dXBOotMzoiZ9ppeG4UE2VKG
         GAZ6EQoxslPg/2Z+CR0+CuQqFUt4OEyDn3w/1szb9HKXl0biVj1dTNwc5wUl8LOqTnA8
         OBUcb9DtxQsgWwFJKxALSRQK8mCYbrAskD4l3hnti4Xh+Pf5cko1QLWmLEF2zLXqpUoF
         B0Wy39W8z/GTvd9wgrh1cUrFnQgx9oOdB1lJy4KlDmZx9/N4YfZE3zq7QUjknnKOCIva
         lXUvLl/Z0rRk3jTg2LC8xMoIzT43Qj4Cij0Yt2e2fw6oSxTJ0lcTEAhgbZtvFoH3vUqB
         tQmg==
X-Gm-Message-State: ABy/qLbKVukaaYKHiQydAtF1ix1Yc2l85OI0FgQEPUNySA5f7QsWFgbV
        oJRyWkfWKfckzcwjFdnhqzs=
X-Google-Smtp-Source: APBJJlGCFXyEBcvLfvEFt0H9Cmu1OUmT9K/fnXAfOaXLHI+nNp4janK6T3asa7+wg6wwRC5wfY+GIQ==
X-Received: by 2002:adf:f2cc:0:b0:314:824:3778 with SMTP id d12-20020adff2cc000000b0031408243778mr10063606wrp.22.1688398923844;
        Mon, 03 Jul 2023 08:42:03 -0700 (PDT)
Received: from localhost (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id m1-20020adffe41000000b003143853590csm2387293wrs.104.2023.07.03.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:42:03 -0700 (PDT)
From:   leitao@debian.org
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     sergey.senozhatsky@gmail.com, pmladek@suse.com, tj@kernel.or,
        Breno Leitao <leitao@debian.org>,
        Dave Jones <davej@codemonkey.org.uk>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] netconsole: Append kernel version to message
Date:   Mon,  3 Jul 2023 08:41:54 -0700
Message-Id: <20230703154155.3460313-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

Create a new netconsole Kconfig option that prepends the kernel version in
the netconsole message. This is useful to map kernel messages to kernel
version in a simple way, i.e., without checking somewhere which kernel
version the host that sent the message is using.

If this option is selected, then the "<uname>;" is prepended before the
netconsole message. This is an example of a netcons output, with this
feature enabled:

	6.4.0-01762-ga1ba2ffe946e;12,426,112883998,-;this is a test

Calvin Owens send a RFC about this problem in 2016[1], but his
approach was a bit more intrusive, changing the printk subsystem. This
approach is lighter, and just append the information in the last mile,
just before netconsole push the message to netpoll.

[1] Link: https://lore.kernel.org/all/51047c0f6e86abcb9ee13f60653b6946f8fcfc99.1463172791.git.calvinowens@fb.com/

Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: Dave Jones <davej@codemonkey.org.uk>
---
 drivers/net/Kconfig      | 10 ++++++++++
 drivers/net/netconsole.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d0a1ed216d15..df50fdb6c794 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -332,6 +332,16 @@ config NETCONSOLE_DYNAMIC
 	  at runtime through a userspace interface exported using configfs.
 	  See <file:Documentation/networking/netconsole.rst> for details.
 
+config NETCONSOLE_UNAME
+	bool "Add the kernel version to netconsole lines"
+	depends on NETCONSOLE
+	default n
+	help
+	  This option causes extended netcons messages to be prepended with
+	  kernel uname version. This can be useful for monitoring a large
+	  deployment of servers, so, you can easily map outputs to kernel
+	  versions.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4f4f79532c6c..7edc5b033e14 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -36,6 +36,7 @@
 #include <linux/inet.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
+#include <linux/utsname.h>
 
 MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -815,6 +816,38 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	}
 }
 
+#ifdef CONFIG_NETCONSOLE_UNAME
+static void send_ext_msg_udp_uname(struct netconsole_target *nt,
+				   const char *msg, unsigned int len)
+{
+	unsigned int newlen;
+	char *newmsg;
+	char *uname;
+
+	uname = init_utsname()->release;
+
+	newmsg = kasprintf(GFP_KERNEL, "%s;%s", uname, msg);
+	if (!newmsg)
+		/* In case of ENOMEM, just ignore this entry */
+		return;
+	newlen = strlen(uname) + len + 1;
+
+	send_ext_msg_udp(nt, newmsg, newlen);
+
+	kfree(newmsg);
+}
+#endif
+
+static inline void send_msg_udp(struct netconsole_target *nt,
+				const char *msg, unsigned int len)
+{
+#ifdef CONFIG_NETCONSOLE_UNAME
+	send_ext_msg_udp_uname(nt, msg, len);
+#else
+	send_ext_msg_udp(nt, msg, len);
+#endif
+}
+
 static void write_ext_msg(struct console *con, const char *msg,
 			  unsigned int len)
 {
@@ -827,7 +860,7 @@ static void write_ext_msg(struct console *con, const char *msg,
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list)
 		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
-			send_ext_msg_udp(nt, msg, len);
+			send_msg_udp(nt, msg, len);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
-- 
2.34.1

