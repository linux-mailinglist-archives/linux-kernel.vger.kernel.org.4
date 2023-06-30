Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66717444E6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjF3Wdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjF3Wdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:33:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93633C24
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:33:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-262ff3a4659so1622769a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688164426; x=1690756426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxfCoOso1eZfolB7gUqXEtVsJqGJE4ixGbTkHqSu72o=;
        b=C8Lei+oKaIkEOJW4Zxcm3YA1B+r3cUE9UbUJ6YJL+vcSf0La47MCNSSaQUSbG1CF8r
         GGaSfn2RB4Lo2InoqkZf0t7WYWI0gi+X/Yw5OwQZsrXfdok9x6Ymci1S9s6xrmjdxqHN
         K2mIvnQ2vFbpfX7lJ/oXkMv10xlgRjzeociy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164426; x=1690756426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxfCoOso1eZfolB7gUqXEtVsJqGJE4ixGbTkHqSu72o=;
        b=gAXMsZSXdNyB/iwcZfp+MIgoITSQ4vZFC/8eSHX9pjZvq1P4i46QFGEPwZ9jejBrEy
         llqgHXYictqYChJDMuhMWu51NZ/crEEV0OS44lyA7RNYD3Ij27E5xCmx2DAM1or1UjVa
         b+czV285cQfYegDWPek+K575D/rx3IIC/62v22kUg/1o5F50inf9HXf9L+FdE3KEl8pZ
         gHDKAw8de6QcwvuBfRTOah9zmV8rP2A9r4C6Z891fySu+P+Zcq1bEo7kInXa2Kw7WvS9
         gfp2cOY0PYXTR3v87SyP55Wg1bmHym80vPhm9icFII4S6BQE1lkO+U21mt8d6BkXdIoQ
         xClw==
X-Gm-Message-State: ABy/qLYb59R5otFZGEGoU7J7m5qKjqIPGZby3YokVQRqHg5d90bd73Db
        FpmRsfEbABaUKMqzlEQeNfwQ8owFz9kSduXTuH/Eng==
X-Google-Smtp-Source: APBJJlE/uNVnU1FE/z80KZnmJw9NpYEV3u7Ktt1iGRliZNqrRICWS8P/gtjk8dGriLHNDB8sz4GlHA==
X-Received: by 2002:a17:90a:c684:b0:25b:d8fe:2c92 with SMTP id n4-20020a17090ac68400b0025bd8fe2c92mr3130810pjt.48.1688164426450;
        Fri, 30 Jun 2023 15:33:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id em23-20020a17090b015700b0026356c056cbsm3105864pjb.34.2023.06.30.15.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:33:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor
Date:   Fri, 30 Jun 2023 15:33:15 -0700
Message-ID: <20230630153315.v3.2.I8b6365c6a13afc74d7a91324dad73601a42038c9@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
References: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
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

The hci_add_adv_monitor() hci_remove_adv_monitor() functions call
bt_dev_dbg() to print some debug statements. The bt_dev_dbg() macro
automatically adds in the device's name. That means that we shouldn't
include the name in the bt_dev_dbg() calls.

Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("Don't double print name...") new for v2.

 net/bluetooth/hci_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dbb2043a9112..de15a2c77e9f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1949,14 +1949,14 @@ int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE:
-		bt_dev_dbg(hdev, "%s add monitor %d status %d", hdev->name,
+		bt_dev_dbg(hdev, "add monitor %d status %d",
 			   monitor->handle, status);
 		/* Message was not forwarded to controller - not an error */
 		break;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
 		status = msft_add_monitor_pattern(hdev, monitor);
-		bt_dev_dbg(hdev, "%s add monitor %d msft status %d", hdev->name,
+		bt_dev_dbg(hdev, "add monitor %d msft status %d",
 			   monitor->handle, status);
 		break;
 	}
@@ -1976,15 +1976,15 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered off */
-		bt_dev_dbg(hdev, "%s remove monitor %d status %d", hdev->name,
+		bt_dev_dbg(hdev, "remove monitor %d status %d",
 			   monitor->handle, status);
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
 		handle = monitor->handle;
 		status = msft_remove_monitor(hdev, monitor);
-		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
-			   hdev->name, handle, status);
+		bt_dev_dbg(hdev, "remove monitor %d msft status %d",
+			   handle, status);
 		break;
 	}
 
-- 
2.41.0.255.g8b1d071c50-goog

