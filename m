Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB80B6BA473
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCOBHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCOBHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:07:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6364D47437
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:07:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-541942bfdccso86454617b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678842455;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Iqt4lmpo1vWvSb8BXeyDrVxhvcJ5VCFpVeZDH2+GSQ=;
        b=eKgP4Yy2pJtaIETWShLKmMy6i1b04c3wcoFT/DI0SYN8DTIS5EKD64iByU8ViUL2Nc
         Dw3CjYyBRdd0ha+vzPigpe31DYGcB123ola3vjN1XOGoBbph/SViON8CvAVxUChXiUN1
         MBicROSyqTEs2T1q/49oKew/XSimWVep9Crf5VLzTrIOMFq6joFwdwRIdrRry8fFQ9L8
         sQWX9sNjiOoYWRKA3wDEWnLb/Z+NUtrimPt6v8bYE2vmhrOoGJ4hOYkxGYdVtBb6bZ2n
         z/yY6jQjEcovuyu2ISgfAkk3MXMR5xX/SGuhND2WCqVkeJzaDr5SSqqQenO1N6dyPAqX
         4n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678842455;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Iqt4lmpo1vWvSb8BXeyDrVxhvcJ5VCFpVeZDH2+GSQ=;
        b=WIq63+G2y6ozoQWj13w7mG4oK9Cp3tNE1nCOoA/m4gmgnnHp3o4zt5gbCXmXSN+dOk
         KkMVzZynbckyRlkhBw4jrbZipTl/aCwSb3BCs9pAQ6nWwkf2c3IJKk8I5DZ9lNMqFJeC
         2iYYoE8liykuxtVhLeTtAK/Tf/bnGQtN8EyUPuDbT8f9DZQHTDIqJJi05L6WEkelpt0k
         2+tvbG/K8GiaXvT7UAujy52sLUQ+jOcrNOyjoE1cZw3uLvvFRqqZSgT0rQgCvBLRhml7
         jOlg9LYLcitjPDzFetWw3Q81eg99tPPCNLarZw8gntWtD3+hgLby0stc92lfc4iOsjpd
         UBFQ==
X-Gm-Message-State: AO0yUKUyWfttolLIL/3GN0yyD8v1A7HTNIRfuDJ2NycwF0C38dP7Cq4c
        7WD68Ef49BdOJwN++/pXnPgXk7DwagpDSuY=
X-Google-Smtp-Source: AK7set+cLAcAPNpuyyWqMqvq1Wh1EBDNEZDq9zVPXt/cKsHXT2KK9B4VrU1zeyw+Yn/S9bJoZ1jknN0Lxy3FNxM=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:53af:6d3a:57fe:ec95])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1547:b0:b4c:9333:2a2 with SMTP
 id r7-20020a056902154700b00b4c933302a2mr873006ybu.9.1678842455685; Tue, 14
 Mar 2023 18:07:35 -0700 (PDT)
Date:   Tue, 14 Mar 2023 18:07:31 -0700
Message-Id: <20230315010732.633992-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v2] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a build time equivalent of fw_devlink.sync_state=timeout so that
board specific kernels could enable it and not have to deal with setting
or cluttering the kernel commandline.

Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/Kconfig | 12 ++++++++++++
 drivers/base/core.c  |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 6f04b831a5c0..aac247512d69 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -230,4 +230,16 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config FW_DEVLINK_SYNC_STATE_TIMEOUT
+	bool
+	help
+	  This is build time equivalent of adding kernel command line parameter
+	  "fw_devlink.sync_state=timeout". Give up waiting on consumers and
+	  call sync_state() on any devices that haven't yet received their
+	  sync_state() calls after deferred_probe_timeout has expired or by
+	  late_initcall() if !CONFIG_MODULES. You should almost always want to
+	  select N here unless you have already successfully tested with the
+	  command line option on every system/board your kernel is expected to
+	  work on.
+
 endmenu
diff --git a/drivers/base/core.c b/drivers/base/core.c
index fe74a786e2c3..adc81871829f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1672,7 +1672,12 @@ early_param("fw_devlink.strict", fw_devlink_strict_setup);
 #define FW_DEVLINK_SYNC_STATE_STRICT	0
 #define FW_DEVLINK_SYNC_STATE_TIMEOUT	1
 
+#ifndef CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
 static int fw_devlink_sync_state;
+#else
+static int fw_devlink_sync_state = FW_DEVLINK_SYNC_STATE_TIMEOUT;
+#endif
+
 static int __init fw_devlink_sync_state_setup(char *arg)
 {
 	if (!arg)
-- 
2.40.0.rc1.284.g88254d51c5-goog

