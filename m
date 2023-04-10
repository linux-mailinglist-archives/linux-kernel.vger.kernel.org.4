Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8676DC3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjDJHcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 03:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDJHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 03:32:22 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E3449C2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 00:31:43 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s93-20020a17090a2f6600b0024670ac71caso1680333pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681111898;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XsjqIBb7Ia4TAnyJQH7l5g8jRueBhJOfzmgtMcl/GKU=;
        b=m6eMlr6IRRsKYg4YgpoBxj3rZB0vKRWzHjaaj+18miNfqGNHBiDwCxMoaWbCfTF92l
         PZZkKOzTFNGolO0Mo08YW0qeriAIxKjlNoy8VG/ol8o53WxJtIJj9wzyDJBcx440HTvS
         SxkClUwOaeEz/Sbw7bcqfvLsfEIvfSiacr6NHGtHYgCSMxAmCekGenYvzUk9Y0WIIeSF
         iu+LGvZAsxk17Rq1Jw+dxOLV1EgAh5iuEUtky/R/+WU3S5S4bpOXuiv57vkqg70/asgF
         fl5shxMYIZ75Ikzf9MIZawDPCdsRAC57KUPuwcUFPbVRd+o+TFpBepaWxsaLqRUXfnJ9
         2cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681111898;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsjqIBb7Ia4TAnyJQH7l5g8jRueBhJOfzmgtMcl/GKU=;
        b=AyNvk6OX5LjO9IUfecH1aqTU8rc6gr8FHmx5Ad6STIZRr+K2lpTSLaGHiNJ2Rt4Ym5
         N3jt5t1K+dsYcXvNCw69PR/7wqrRdnROoDgE0wVuCz2RgImjc9MYrL72A5dfaeBMcUQJ
         J7njpa7EjuLXRTiFBI1KLjWkyMQG+QVNpH0HZZefSvxRhUSLzJ6tIY0XVTTLBxMWO6+E
         ZeiNMz2xkQ9L7xAXR6wBXKXkZQrZmvd+TjBeYKANOz59MGavaTreqMI1IEFen6yQuQr2
         eVbS5LGnmthPQXGTjO8A21FXW8bXjef74FxrX3Gtr924jK4HFfFgGDpf0+933EwJkZMM
         GoWA==
X-Gm-Message-State: AAQBX9dQQEry9QHy0C4jl0zoBcrxT+/99l3KISVBrG8KFVNcxsLdtgk1
        9qK7zPtPpV+x4jPgPovucYEXvGm9xzo=
X-Google-Smtp-Source: AKy350Y72WTmHlZCqbSqBE/mvKlNKZ3e7Mjyhz2CnPLNHut9WSgl8t4sTky2LXtQst1y39zXTlN33BP6+wM=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a17:903:13cd:b0:1a5:22f3:220e with SMTP id
 kd13-20020a17090313cd00b001a522f3220emr2419872plb.3.1681111898602; Mon, 10
 Apr 2023 00:31:38 -0700 (PDT)
Date:   Mon, 10 Apr 2023 07:31:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230410073134.488762-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around tcpm logs
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allows the
logs to be wrapped around. Additionally, when set, does not clear
the TCPM logs when dumped.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/Kconfig | 6 ++++++
 drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index e6b88ca4a4b9..4dd2b594dfc9 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -18,6 +18,12 @@ config TYPEC_TCPCI
 	help
 	  Type-C Port Controller driver for TCPCI-compliant controller.
 
+config TCPM_LOG_WRAPAROUND
+	bool "Enable TCPM log wraparound"
+	help
+	  When set, wraps around TCPM logs and does not clear the logs when dumped. TCPM logs by
+	  default gets cleared when dumped and does not wraparound when full.
+
 if TYPEC_TCPCI
 
 config TYPEC_RT1711H
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ab3a54662ed9..3f708749431b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -619,7 +619,7 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
 
 	vsnprintf(tmpbuffer, sizeof(tmpbuffer), fmt, args);
 
-	if (tcpm_log_full(port)) {
+	if (!IS_ENABLED(CONFIG_TCPM_LOG_WRAPAROUND) && tcpm_log_full(port)) {
 		port->logbuffer_head = max(port->logbuffer_head - 1, 0);
 		strcpy(tmpbuffer, "overflow");
 	}
@@ -644,6 +644,10 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
 		  tmpbuffer);
 	port->logbuffer_head = (port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
 
+	if (IS_ENABLED(CONFIG_TCPM_LOG_WRAPAROUND) && port->logbuffer_head == port->logbuffer_tail)
+		port->logbuffer_tail =
+			(port->logbuffer_tail + 1) % LOG_BUFFER_ENTRIES;
+
 abort:
 	mutex_unlock(&port->logbuffer_lock);
 }
@@ -746,7 +750,8 @@ static int tcpm_debug_show(struct seq_file *s, void *v)
 		seq_printf(s, "%s\n", port->logbuffer[tail]);
 		tail = (tail + 1) % LOG_BUFFER_ENTRIES;
 	}
-	if (!seq_has_overflowed(s))
+
+	if (!IS_ENABLED(CONFIG_TCPM_LOG_WRAPAROUND) && !seq_has_overflowed(s))
 		port->logbuffer_tail = tail;
 	mutex_unlock(&port->logbuffer_lock);
 
-- 
2.40.0.577.gac1e443424-goog

