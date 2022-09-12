Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50185B62CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiILVeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiILVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:33:58 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA927FEA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:33:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y16-20020a17090aa41000b001fdf0a76a4eso4495202pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=t92G0xsuXiQ+5p7MU78V80zQy5qz0xUQIUtG/cpaDJU=;
        b=UeaI/F7To/XvQq0UnOtlDhy7TWOfXA+1z9EGlyjpTrEGbBEhCamdHNFU0CfzdMi5hM
         UhkFcQ2RD3R+FgOB4U8CBTvdnoG/wllzgOr3V58B3j2wlkWlevRmSN5EL0TWqkNr2i3F
         LLQUWgJ67u+HYHc4rByBM8S6mYnUi6jWdR8UXOwwRGmp8Hra5JFxI3lZLyUBATyBU5Q4
         3xIaVZt4CD9ZST6ilr/j0ihwyAqxJBf0tmhInPLzi8SratP4dnV0s2tLmzFKzPhxJ5nF
         jDbz/hiWW5PVxahvFqDbp2mecyU/uMGuMRsfkkROn5aUjjz1WPFhe36xOruaoULwePmI
         O6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=t92G0xsuXiQ+5p7MU78V80zQy5qz0xUQIUtG/cpaDJU=;
        b=hNTLnCmkVl95C35sngu+wCTcjjcdjk1ZwuGR6+sx7K/KZKrDU+ZwGfsvs4leRltCIQ
         4LY6/38w4jG2jIPJFXL/1m6OXZYMqQp1yfDfcxA+3xkzTe6TuCIMjjeYCFSCoN/p+Ans
         Xnca6iz4n4QQ/v5s6zX1jPFYlYzDDjOu5WagSf5pWgXnBYQ0TA2Wfpr+UOrQU8+5V7b8
         iuNt9JiVk3voOWhyt/k5TxHZXinfILIO11CVqG4Oz0FhlsKz88Mmr57DijyUylR7l0a+
         6kI1xSG1HpiutRa7pEMUacFdmSEuSGVUIul7WxxNS+/ZI4KgFPamckWT7TBQhnFHHVJA
         Heyg==
X-Gm-Message-State: ACgBeo2SRL0Firob7fjI2PhPP+J8y9pzBseOJLl5DJNNw6ZPIl3w+Ykf
        D40hsS9/woQjDLobsjg3sPRPW9GhlGM=
X-Google-Smtp-Source: AA6agR4Jn14x7CO49XIT60557aSMTJHu7eBX3x+qDQsf6nN0yuw8oVJdDIOQW/rtloP/L1LJ4bywP1FsqGY=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3f85])
 (user=jthies job=sendgmr) by 2002:a17:902:db0a:b0:178:2636:b6de with SMTP id
 m10-20020a170902db0a00b001782636b6demr10904990plx.58.1663018437527; Mon, 12
 Sep 2022 14:33:57 -0700 (PDT)
Date:   Mon, 12 Sep 2022 21:33:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912213334.2703872-1-jthies@google.com>
Subject: [PATCH] platform/chrome: cros_ec: Log wake events during resume
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

Update cros_ec_report_events_during_suspend to log wake events during
resume by calling pm_wakeup_event.

Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
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

