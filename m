Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE7365CB49
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbjADBPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbjADBPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:15:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0E917584
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:15:30 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so14459158pgl.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 17:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9rrPHtsDc664z8TlUhfeZ6o7/ZdnXcwK2CIJxHNuXg=;
        b=lRbVHoFQeHjsrzoHSmWlciMBX0cP/lBE/dgu3vX7qZ+C6TtDOl1WXGf1EO6iOIFWvG
         CRNkt1xKVWral6U8KW+RYgoS1G3Pv5DaUYpKG0blqxPtaaaf6nVxiZKrXcSeUx0A0abL
         G8+UhncS76rk/5fXhKI5d+LNkzg9eARkJ+47lSatGGZKl+rGjYETyC/EsDVxLEU7BfAL
         hUgEQSDc+uRXWpr3EQltY0jbZb4jgx1mJVLdmY8r8VO42Pa4eKs3RbyfWny54L9Bjjke
         ibqy8svP21PduGY0TidtzmTYEcsGY4bTEOfcabj8x+ZbxZvHQL7swEkRB0u4GYeRt8kp
         ySOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9rrPHtsDc664z8TlUhfeZ6o7/ZdnXcwK2CIJxHNuXg=;
        b=Hyy6VNkUU27OGofys/hD2knThwtPzKWfb1hYptBt0ncPXHPpUbCfH5CWmmHyF7hYYm
         +UKd6+R+9GjsJOTyt6MEE0eN4OIYZTCwr4ccouHWAIXXypt+JwKxe/csNuOqRcY+6YBL
         k+X8mLKFXNwUTlkqytZerSIIIDJ672z1MAn1h0OpFzn3DdG+CKnnK2/HD/jjsHBzsFQG
         eRnvi3jFhDLdIhsl7x8f+9ndlU8Z5Y2xBqTEHAWpK5Fak52kmrdPaesOg4RS6NSzgQYa
         eMNohfvfywFw7bVGXo6mFwk0Nk5K1PY4hPCuaY1X5KNP+i+ZkAP1eSgnNDikfGAk+RV0
         3TMA==
X-Gm-Message-State: AFqh2kpVsQVhb9EhUlo/jeLQv43yxu/tk92vk36BBdvcMINKtdmCOHDj
        DBTQuE6Y8zdQ4UIRtZQ/4bpAWijgJeKmY9w=
X-Google-Smtp-Source: AMrXdXtxmw9aguwDjJUz2htfsETgY4/yJbUjCtMyJXjunBRVCVyRNyKHSYsD8vefQjOZW6BtGbFgSctk+4wUdjk=
X-Received: from robbarnes3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6451])
 (user=robbarnes job=sendgmr) by 2002:a62:6003:0:b0:575:e44e:3e0 with SMTP id
 u3-20020a626003000000b00575e44e03e0mr3301718pfb.53.1672794930240; Tue, 03 Jan
 2023 17:15:30 -0800 (PST)
Date:   Wed,  4 Jan 2023 01:15:24 +0000
In-Reply-To: <20230104011524.369764-1-robbarnes@google.com>
Mime-Version: 1.0
References: <20230104011524.369764-1-robbarnes@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104011524.369764-3-robbarnes@google.com>
Subject: [PATCH v3 2/2] platform/chrome: cros_ec: Shutdown on EC Panic
From:   Rob Barnes <robbarnes@google.com>
To:     groeck@chromium.org, pmalani@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org, Rob Barnes <robbarnes@google.com>
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

When an EC panic is reported, attempt an orderly shutdown.
Force a shutdown after a brief timeout if the orderly shutdown
fails for any reason.

Using the common hw_protection_shutdown utility function since
an EC panic has the potential to cause hw damage.

This is all best effort. EC should also force a hard reset after a
short timeout.

Signed-off-by: Rob Barnes <robbarnes@google.com>
---

Changelog since v1:
- Split into two patches

 drivers/platform/chrome/cros_ec_lpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 5738f1d25091..3708fa75feb1 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -21,6 +21,7 @@
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/reboot.h>
 #include <linux/suspend.h>
 
 #include "cros_ec.h"
@@ -323,6 +324,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 	if (value == ACPI_NOTIFY_CROS_EC_PANIC) {
 		dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown is imminent!");
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
+		/* Begin orderly shutdown. Force shutdown after 1 second. */
+		hw_protection_shutdown("CrOS EC Panic", 1000);
 		/* Do not query for other events after a panic is reported */
 		return;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

