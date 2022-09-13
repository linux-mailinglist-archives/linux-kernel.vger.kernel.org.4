Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEF25B7C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiIMUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIMUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:50:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E36F551
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:50:07 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y24-20020a17090aa41800b0020269fb74b0so10362802pjp.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=gy3bDNBw7VQytEVRKZxZzrTdbmTEWTGJEIGOvnabvxo=;
        b=MsIiTEcp0YKQ0q29PXoqrtM0XP78eU5bv/HJl7x4HzGd9dYG0kP/f4qqYx2Y6uYzoY
         5AbqkdzAhgmKSpUJxqX0Q+2TINrtybI03WTeO7PPJEGii/QTaZPDWNWQbAkVG95RwPxB
         pNN5fdf9XUlqBU+ojPKKznCDDWpTgI8Chdp4jSTdCqxUXMjg3thI+7oHCwp5cr2s42XR
         4xvMKpMA+jtmz13XBoq2KVAa5idLwm0OukMDv5oHBwTOKinPYoaO5/4ByCwSs7+hzZ3T
         9f2ehaWXoSF7eO5bHu8RzEEVC8UKYS0C6dcN5EyzxI7kEZEIN+IQvo43BkWd72iPNzjB
         RZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=gy3bDNBw7VQytEVRKZxZzrTdbmTEWTGJEIGOvnabvxo=;
        b=a5WcmTquo1jzqzvZSodpeE22qrZGulikkiWCJogUp/BrP6+DD7x/0zZDLtK6q+XhvH
         vhrKHOde7+Co0IJBdpxwnC89I58Ho8sbY+b4/GWxGUQLGogQIef034hqarbPNzDY85Q1
         9oCjYRMSlupiiGJ4P0yyCfVt9iT/OETcxilPNNFZW5Knql/uRswwVdF2+MvVDcuqZvjv
         B4R9lo0g6nMw0H+o3VUANLe9kK+ySe17LWmEVDanNZipJzZwzcFcV1Z3vxxKPweUO7P8
         XFwbwjwasDkHXaofOOQRWd5b2f+/9k23ll1L/MM4m4lL99OwKGm7fn7APyfgURfwa6cc
         K+GA==
X-Gm-Message-State: ACgBeo2CBu2R0rkMT0vfrUJ3Fbf6f/CfeMnEK0YoQcMeEvc2O++b/Zn3
        2u74bsnSNbV2CLlVck7IF/u4KBUmBAI=
X-Google-Smtp-Source: AA6agR7qXuSHYsLoYdDFCEwxGLsUWKVrpzzkU4qHYq5nHGq6bSMKbnk8HCDo45F5/DCYdGcKhlMvvmxiEd0=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3f85])
 (user=jthies job=sendgmr) by 2002:a05:6a00:1892:b0:540:acee:29e8 with SMTP id
 x18-20020a056a00189200b00540acee29e8mr27129067pfh.1.1663102206357; Tue, 13
 Sep 2022 13:50:06 -0700 (PDT)
Date:   Tue, 13 Sep 2022 20:49:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913204954.2931042-1-jthies@google.com>
Subject: [PATCH v4] platform/chrome: cros_ec: Notify the PM of wake events
 during resume
From:   Jameson Thies <jthies@google.com>
To:     chrome-platform@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, pmalani@chromium.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_handle_event in the cros_ec driver can notify the PM of wake
events. When a device is suspended, cros_ec_handle_event will not check
MKBP events. Instead, received MKBP events are checked during resume by
cros_ec_report_events_during_suspend. But
cros_ec_report_events_during_suspend cannot notify the PM if received
events are wake events, causing wake events to not be reported if
received while the device is suspended.

Update cros_ec_report_events_during_suspend to notify the PM of wake
events during resume by calling pm_wakeup_event.

Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
---

Changes since v1:
- Updated wording in commit message from "Log" to "Notify PM of".

Changes since v2:
- Removed Reviewed-by tag and provided more context for the update in
  the commit message.

Changes since v3:
- Added reviewers back into commit message.
---
 drivers/platform/chrome/cros_ec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 8aace50d446d..110df0fd4b00 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -349,10 +349,16 @@ EXPORT_SYMBOL(cros_ec_suspend);
 
 static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 {
+	bool wake_event;
+
 	while (ec_dev->mkbp_event_supported &&
-	       cros_ec_get_next_event(ec_dev, NULL, NULL) > 0)
+	       cros_ec_get_next_event(ec_dev, &wake_event, NULL) > 0) {
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     1, ec_dev);
+
+		if (wake_event && device_may_wakeup(ec_dev->dev))
+			pm_wakeup_event(ec_dev->dev, 0);
+	}
 }
 
 /**
-- 
2.37.2.789.g6183377224-goog

