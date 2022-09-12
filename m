Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0842F5B63D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiILWsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiILWsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:48:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA124BA77
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:48:42 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id my9-20020a17090b4c8900b002027721b2b0so7577948pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=69eqzQldLaAKRphbYvjKq9UwxC3qVyQ1BnuwXpOP90k=;
        b=SmME0BoRudH8DEJT4v4/zsZ3xWJOz30HsCdv6NK/gwQLgnwxaE20doDBhiq1uGrL/Q
         n/AFLvKj7G5Qkcm4WCvGz9AExc2p38QVLZAsgZ/Uxgz4wzUuEDlgtEuQ8lFt7midKBbM
         53T4PwLEP5Q1mr0miEpX2RrlDptWi8e3bFLCz0I00ei2+lfbCV3hqYsImIfvPBIqSWpC
         nAt9f86oKWbs9ruvNhLnhXuQsJervZtGPvEA7Evq3/d1kEWzCwRJwe4kjsmf+R8FKawQ
         K5s/ABkk1n77LzD6wp633Hq6RfNJTCaxU/nEjRGusnm9um5co6dbyWJNO/fNEJ94FBrq
         zm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=69eqzQldLaAKRphbYvjKq9UwxC3qVyQ1BnuwXpOP90k=;
        b=PQsjELKpQcFQV1eymtrEWYU1PhfUrfSPfd0mNULVEMTqpTJBYh7s2bjb3V82Y+acSD
         V80c1HbSGVQL9jOhuS1d6gSyEkqgs7aM3nkVDzgipRITOAh720VvH/H9WxQ06D5KhU2v
         tT7DRD94yT9lvxtvqgNwJE63Ny1EDA4MiSpyhVLAY6seKOU1SJlRoO3vRDAvcxgOn/Lg
         TQNOBMvdY6ZayKgwRq8Jhb+Zq91KRZxi1SD5w9zGGuYMIbXSofDfCX9R9CMjD9C68gZa
         XDNQx5faOSymxVBfBL8KMH1XO6nRX087q9GqICZYEU+w/+/0CROls7chxblq3m8JJT2R
         Kphg==
X-Gm-Message-State: ACgBeo3S+DhZZES+M3ABbz/4Q9Eoebx8L+zamDJ7mc0iXMwAJWOMYvVq
        iXz55Em1UZ0QESGaM0f3RuYx0nu47k4=
X-Google-Smtp-Source: AA6agR54JsXmsNxLeykhCovQYXLPwCyudwSKJ5KzmN5v6Pt0M/FYw9u1jAFxSPymtmO4mvSh0T1/Iv01d8c=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3f85])
 (user=jthies job=sendgmr) by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id
 p4-20020a056a000a0400b00534d8a640cemr30258261pfh.15.1663022922073; Mon, 12
 Sep 2022 15:48:42 -0700 (PDT)
Date:   Mon, 12 Sep 2022 22:47:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912224745.2716345-1-jthies@google.com>
Subject: [PATCH v2] platform/chrome: cros_ec: Notify the PM of wake events
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

Update cros_ec_report_events_during_suspend to notify the PM of wake
events during resume by calling pm_wakeup_event.

Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v1:
- Updated wording in commit message from "Log" to "Notify PM of".
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

