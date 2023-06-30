Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2174448C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjF3WK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjF3WKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:10:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5FB420E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:10:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8054180acso17906615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163020; x=1690755020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaAN0G7fwCuNl5CzPxOPdbGCqVfxseZDjS8aC/Jsx3Y=;
        b=e3P4cQ8hu7ahgxfyUOoSkEIYQdlx2lHHDXZTEEP32jHHZTvBd6yXMb3tZ1VNAewpvb
         e+LkTlfonZstm3DdWuKP4h2Pjtv7qPH3Ha539VoU8zZSfg6sF9yE62h76pewy3hEpQfq
         9IvjY5xDP+Cdjy/gkQeFL7D7so60UlGTKUe8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163020; x=1690755020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaAN0G7fwCuNl5CzPxOPdbGCqVfxseZDjS8aC/Jsx3Y=;
        b=h944wOjjG5IDplqm8n7rU5Ql9YOMZ/fSiO4dTPqwCg38jqVI0UNf1tVjX2u4WozjPI
         yDlcy+WQHDZQhE69tyLo+XB5Vewy59IuCDPGrq4pl6MWYx3FZPBhE7XiaQwrFkaf5phr
         4nNeT93TuKpAaIf0EZ4xKwu++8gnw0XtGdf/m3DquRjo6Y9JgM+LFZHzxAO2RWXM9zO0
         9VBdxJiGyUzq6+tB+96cQu2TFhAojyw1Fii2kJhvjeWNBJZXWple0qLRHz6XZUXOAvdJ
         vdo9dj/1l4S905HOS2olADcZs78Po5p9vrSwMZmyki1QL803bWsdRY8nDmkB8KmO4tZv
         HXSA==
X-Gm-Message-State: ABy/qLbXNX7pt2ckvi4QnDC0VYus3Y4Z3+1igRpTxAVLdqwN00mljr2o
        lXDv66E41gIDecWILb3OW7g5gg==
X-Google-Smtp-Source: APBJJlEgjiww29Uk47zncHTRUxXnIYTM/5vIHSdwNVSYwHJKplW02d7JYNLEZLLXGSSXLZtIXPitEA==
X-Received: by 2002:a17:903:24e:b0:1b7:f73d:524 with SMTP id j14-20020a170903024e00b001b7f73d0524mr4015022plh.43.1688163020445;
        Fri, 30 Jun 2023 15:10:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001ac897026cesm11238797plh.102.2023.06.30.15.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:10:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor
Date:   Fri, 30 Jun 2023 15:09:07 -0700
Message-ID: <20230630150906.v2.2.I8b6365c6a13afc74d7a91324dad73601a42038c9@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
References: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
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

Changes in v2:
- ("Don't double print name...") new for v2.

 net/bluetooth/hci_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7e2ecf8a55d8..a8e54383e551 100644
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
@@ -1975,13 +1975,13 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered off */
-		bt_dev_dbg(hdev, "%s remove monitor %d status %d", hdev->name,
+		bt_dev_dbg(hdev, "remove monitor %d status %d",
 			   monitor->handle, status);
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
-		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
-			   hdev->name, monitor->handle, status);
+		bt_dev_dbg(hdev, "remove monitor %d msft status %d",
+			   monitor->handle, status);
 		status = msft_remove_monitor(hdev, monitor);
 		break;
 	}
-- 
2.41.0.255.g8b1d071c50-goog

