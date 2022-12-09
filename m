Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F191764844D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiLIO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLIOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:55:48 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1C80A3F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:55:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s5so3377885edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr0DjBH1YEnasxrYesj7cvRVZfRH4rPEDs0TxXAHiSg=;
        b=6BR4ftmEi4cwaY0Zq2EMADfCq7D3R7dRhGj565BcwcOdftO7DpLqU7m1Uq+/yJ+AGZ
         jh/kM4TgyggxJ+OTIBjhyKG6SAj9vKbh98eNvUeU43HoQPObiR6Pz9b5QNHJ3vavH2k1
         ZtqdFgFQq6/oMk76hY+leei80rWiI5ExUI3F5vd83sJCp4F/ZTicV1hH7KE6ocr2Kxbc
         vIl+6NtxjPHuGXJE2mutZpRE0s5Mz54VT5WHCKvnLwDfs5udM6eQpLVXxJ2N+nbLSW9f
         wqeE2ymttBeIpxn5/ahdOSnUceCLnfxZJcAzEMCvBIYv079KyzKGFg/I7JNLpD/SZZ9L
         d6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr0DjBH1YEnasxrYesj7cvRVZfRH4rPEDs0TxXAHiSg=;
        b=fRySLWAL19mVCtX6jY9hGAgciUZ0LPcBb76UJ56u11IZIMA95Y3LqQhUgAHEeG57XB
         b3Tm45hKRP2+3+3YS5RkQailiwwLkTu8XS2yNGtzY8fPa7lDvTP5jDZoOEXCbQKd7y9P
         oQ6JRmvnzrNU0cpneM/lPeuZhKqB2lKnCcZdQIQG/hkAqFieEhJ//yfddLlNXzZxQA+u
         NoKm+uTAT6XI6Jetfllqm4SvQO09f19NRMEEGv4RT9H5+bka1GrkxpFZCnhVood8gYrT
         5cOe8tAvE5GmvfCLjIxMXC3N2p+YX4rhjLKk0rnRHdn5AaxC5uAWXIFDIbzzEr6kxURa
         5epw==
X-Gm-Message-State: ANoB5pnoPp4Egse5MR+W5LKNI+FVz94DuoxMSIYWNpadfpO/7PjKY6L8
        vOaZzHsZ9jPmJl0xhOOlfhnHcg==
X-Google-Smtp-Source: AA0mqf4Yb/BOvMLtH6r67H46I1phEPMg/pmN85YtjlgWU29uNdJPkmrZ6mICq1Tm5TiV5cKxNxgBlA==
X-Received: by 2002:a05:6402:1004:b0:46b:c156:9965 with SMTP id c4-20020a056402100400b0046bc1569965mr5266982edu.38.1670597708861;
        Fri, 09 Dec 2022 06:55:08 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b0046b1d63cfc1sm716856edq.88.2022.12.09.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:55:08 -0800 (PST)
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
Date:   Fri,  9 Dec 2022 15:55:04 +0100
Message-Id: <20221209145504.2273072-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
References: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
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

