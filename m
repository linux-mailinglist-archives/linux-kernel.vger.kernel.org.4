Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D65B75E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiIMP6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiIMP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:58:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66C992F4C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:57:02 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p12-20020a170902e74c00b00177f3be2825so8562234plf.17
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=cvJEnjTXhlWXDO7hFwpFHy53bcFzxR1mBtrl5AKvvps=;
        b=WHm/6D6ARpjPd/cEbWmZhCHS72PbANzTsxUSf4b7+nXr0kutRzr1TG9ZvI3Q6Ew4+o
         u4s4MgKcwejHN7wZz8QQVfM9DQth2kxFo/ZTeq/tlj+C5PQvu95GeX4lwVY/CXiW0vJk
         qKVS/u7l2clyrLlZMmpvEet2bARk8XwGjuGCEKViLqObSeBODiTFGzUpOGUKmPBQ3Bki
         6IFQEEUUbFx4rKoBQ+TYhiI+kaKogJCOTlguWFiGNeid0wD2bzzYu26osGPZs8HgIsdK
         mH6Kjdbjt7Bh0tZN1aU8D42KudrleRawLRywmhFwFZCOIwO8QFSA9s+e8/kgQLKyzdMN
         A1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cvJEnjTXhlWXDO7hFwpFHy53bcFzxR1mBtrl5AKvvps=;
        b=RXx/U3qHbNpMw4s/NLbr+Sx5t4ASFOD3Y1WEtn1nDKW5zydkL4RWAlzgeDotUBuhT7
         +AX97jVaXXI/nFNZBueHWIQ/HHT8p3C0i5Bf7+JiNwrfYaiQ7GogP1WwBY4TM73jFjYJ
         4OxZ4cLJWU6OIzPebUChByZa/EAG4TF0y25cQVrGg8YvuZa8J+JswbVyM3jLp2DZZ6e0
         xnn/DAZIToUEHuFwBi8sDH+kUiVZfInE1wyOHqdfZJJkwJbLzS9N4R7wt3xMh34/z17Z
         DwnN9F55VJT1yq3CttCAm+Zl0jCmgYpiWlU07D4bApb26Z0uMkLiEfTPRw02KqzPpTRS
         BWhw==
X-Gm-Message-State: ACgBeo0xVxQSTHGjI25n6meRtl/OJU0o1pv8z+3qCHEyjeB+FLVjPXRC
        eVzOPsnWeF8jV4VIcUj6AbwcBzXTzMM=
X-Google-Smtp-Source: AA6agR7fODZawl72r3SMpSlBhegJYwwMxyYRozj9aUC7ch9LdPpMMVnRzuFBzMmDU2bRbz5cy4mtdWyADpE=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3f85])
 (user=jthies job=sendgmr) by 2002:aa7:9d9a:0:b0:53e:8bc5:afb7 with SMTP id
 f26-20020aa79d9a000000b0053e8bc5afb7mr30628956pfq.54.1663080954632; Tue, 13
 Sep 2022 07:55:54 -0700 (PDT)
Date:   Tue, 13 Sep 2022 14:55:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913145549.2839948-1-jthies@google.com>
Subject: [PATCH v3] platform/chrome: cros_ec: Notify the PM of wake events
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
---

Changes since v1:
- Updated wording in commit message from "Log" to "Notify PM of".

Changes since v2:
- Removed Reviewed-by tag and provided more context for the update in
  the commit message.
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

