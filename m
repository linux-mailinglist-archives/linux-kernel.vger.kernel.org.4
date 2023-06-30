Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F022E744402
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjF3VlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3Vkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:40:51 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3305935BC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:40:50 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b0138963ffso2205765fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688161249; x=1690753249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cg9zB1fXkpk+7GpB/Svxkl6enKDK8Dwoq2y9kTCjIA=;
        b=oFavwefyLR9wVs3hmLyB5TX6tYYx6yw96aWF5BCuMXqpto5h1lLwIe1nty1LMcFyYW
         2R0z9JLTeXyR6sb0i3kCQ77dHdcvLctI14pOhwvH5vKxwf0yEeay55z5MfhdIMf36/8I
         B1mhF+5WUXgVZebJTYgGdGTWGS8+sxqtHgCOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688161249; x=1690753249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Cg9zB1fXkpk+7GpB/Svxkl6enKDK8Dwoq2y9kTCjIA=;
        b=R95Z18bP2KOJw0kCJEWKP6ueo/d1Pq3BJUMD7bpL5arRlxy4OT+5SqY56JYol4RVQH
         QZYxKW2aOBzB/S7+hjGwCA/kGxIN5uCFk/l+ZA9SP48PmAGegf+Zq8pN1+eD++QBcnGY
         iptkKSHC5/mdMPQCwHfB3wx4YnDSqpfs42P5/oEDwP4YYhkB7bbGZrsfBM7Ivcw58fDa
         GK1Kef77qQqDJkhsU6IbVktNOBDjAGOl/ws7JJSXtxWIQD791/gHuxhK0NAeGPA2/rT7
         u8oBkyddA+bYaPENU/7YiqvRZ7i/tOvKVPqzw7aTAHgDvt5BnTPLdcI0PxvAO0tzUKkb
         peFQ==
X-Gm-Message-State: ABy/qLa9/QpSWCeIPpBHujdIDwBglw1DI+b6IytcJl9kyJZmY8fUW4Ti
        wd4UmHsMqmgFpulZfhm/5y8yqQ==
X-Google-Smtp-Source: APBJJlF3SvyUtB2tw/r4m4aYJeI4euVTVv7JJZjPCQf/HM3JvAr3m5HYb5mc4twRuvR20OvL67x7aw==
X-Received: by 2002:a05:6871:822:b0:1a3:1cb3:37e9 with SMTP id q34-20020a056871082200b001a31cb337e9mr5354026oap.4.1688161249516;
        Fri, 30 Jun 2023 14:40:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090ad58800b00256a4d59bfasm12916841pju.23.2023.06.30.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 14:40:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
Date:   Fri, 30 Jun 2023 14:31:27 -0700
Message-ID: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reports that there's a use-after-free in
hci_remove_adv_monitor(). Trawling through the disassembly, you can
see that the complaint is from the access in bt_dev_dbg() under the
HCI_ADV_MONITOR_EXT_MSFT case. The problem case happens because
msft_remove_monitor() can end up freeing the monitor
structure. Specifically:
  hci_remove_adv_monitor() ->
  msft_remove_monitor() ->
  msft_remove_monitor_sync() ->
  msft_le_cancel_monitor_advertisement_cb() ->
  hci_free_adv_monitor()

Let's fix the problem by just stashing the relevant data when it's
still valid.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 48917c68358d..dbb2043a9112 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1972,6 +1972,7 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 				  struct adv_monitor *monitor)
 {
 	int status = 0;
+	int handle;
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered off */
@@ -1980,9 +1981,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
+		handle = monitor->handle;
 		status = msft_remove_monitor(hdev, monitor);
 		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
-			   hdev->name, monitor->handle, status);
+			   hdev->name, handle, status);
 		break;
 	}
 
-- 
2.41.0.255.g8b1d071c50-goog

