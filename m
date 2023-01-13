Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96056697AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbjAMMqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbjAMMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:43:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066887F2A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:35:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so52040476ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr0DjBH1YEnasxrYesj7cvRVZfRH4rPEDs0TxXAHiSg=;
        b=kE3RfzlxtjPHuvjfFEhPWJMp54HpFpp1Vnho1/xXHfQgsziEBG2QO7MlogQAjNMV6k
         xJ+4oX/N3D5Y8RJztAPXEw+2kW+MOz2hCSCzzaxdYommNiVXrq3II4WsgJ+eoa+sbrWY
         zAv+tdure6XvQ6edN3+fg+QR3xaWJ7OkfBOK2xMCclcTpwFGHgdr+2l1ZyXOC05ZRbHL
         SSruhU9xk84XGBTJ9QrwziONSZ2puhBmY3SeolCq9KrNeDVnmMAaUnsjArptv7QfH05F
         HjUDn1+r5B30e9+xtqAOsU/zJh0hjlpmLgky0g0X2xSxcbIKwaoVTY3rFzf8LDLJXfDV
         qB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr0DjBH1YEnasxrYesj7cvRVZfRH4rPEDs0TxXAHiSg=;
        b=rXwQDfWgDLfcnoRDsnM/xelZwcFCxhCBIaEVBzoMp9Uo0pEm87wvWfRzSmCVpnGMPq
         wd0LuP45eLyKtPnbWbtQuF5j2ht45DClHtUCwrn/pVRppsiUEj+FlHr2G7U7dON07KCM
         hKvT3luvlyLs6mpc0KaWwBJqqIb+XR/zr8tre3QxwTavSjFqceEFFiCfYA86mprANqcO
         gqKyxKzx7e5l+/ydrE9CpVM9UxGAo3JpY756wcj+ZvvoFTXythYm2CPEi1lJF25UY+mV
         DoczmxYMucGLmHgyxJ8yYl6F5xZ1YvseFx3NXj1sRMdd8/TLxNnl1U1PqGLU+s9YuaI9
         5O6A==
X-Gm-Message-State: AFqh2kp+hDKzaJY4vMBzcDR7GV54EhLj+NrE8MylB7YrU4+zumBVDVCP
        2DvQrqRohFgT89wgCvQ3gK5mKg==
X-Google-Smtp-Source: AMrXdXub5p+iGrNvx+NKgAL3VLKRz04ZYGHLuJRXqTeqrTZWvsOy/QeBj08JRCfb/ECCwDK4pMCFkg==
X-Received: by 2002:a17:906:494b:b0:862:e612:effe with SMTP id f11-20020a170906494b00b00862e612effemr8182025ejt.14.1673613321216;
        Fri, 13 Jan 2023 04:35:21 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b00846734faa9asm8386323ejo.164.2023.01.13.04.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:20 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 3/3] drbd: split off drbd_config into separate file
Date:   Fri, 13 Jan 2023 13:35:06 +0100
Message-Id: <20230113123506.144082-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
References: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be more similar to what we do in the out-of-tree module and ease the
upstreaming process.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_buildtag.c |  2 +-
 drivers/block/drbd/drbd_int.h      |  1 +
 include/linux/drbd.h               |  6 ------
 include/linux/drbd_config.h        | 16 ++++++++++++++++
 4 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/drbd_config.h

diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
index 956a4d5c339b..cb1aa66d7d5d 100644
--- a/drivers/block/drbd/drbd_buildtag.c
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/drbd.h>
+#include <linux/drbd_config.h>
 #include <linux/module.h>
 
 const char *drbd_buildtag(void)
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index edce1f7ac2da..d89b7d03d4c8 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -34,6 +34,7 @@
 #include <linux/prefetch.h>
 #include <linux/drbd_genl_api.h>
 #include <linux/drbd.h>
+#include <linux/drbd_config.h>
 #include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index df65a8f5228a..5468a2399d48 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -38,12 +38,6 @@
 
 #endif
 
-extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.11"
-#define PRO_VERSION_MIN 86
-#define PRO_VERSION_MAX 101
-
-
 enum drbd_io_error_p {
 	EP_PASS_ON, /* FIXME should the better be named "Ignore"? */
 	EP_CALL_HELPER,
diff --git a/include/linux/drbd_config.h b/include/linux/drbd_config.h
new file mode 100644
index 000000000000..d215365c6bb1
--- /dev/null
+++ b/include/linux/drbd_config.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * drbd_config.h
+ * DRBD's compile time configuration.
+ */
+
+#ifndef DRBD_CONFIG_H
+#define DRBD_CONFIG_H
+
+extern const char *drbd_buildtag(void);
+
+#define REL_VERSION "8.4.11"
+#define PRO_VERSION_MIN 86
+#define PRO_VERSION_MAX 101
+
+#endif
-- 
2.38.1

