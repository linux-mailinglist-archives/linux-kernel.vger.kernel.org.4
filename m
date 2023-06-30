Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D37444E5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjF3Wdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjF3Wdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:33:46 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8F93C22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:33:45 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1b055511b85so2095902fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688164425; x=1690756425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nq1QcjMnGfIZ/W8d+xE8ssqtAAponfz0QGs18ghKecs=;
        b=ePmdCCgl438/fHKG9lmQLCDSCX0oTeNziNiyk4EgYgOQHYihUa9mQvSiGhIgLkH12I
         eBRWE1x2Ip5ar6Y6JvgY4D1KTJZQd+yBAdpbYu/Rhf7isIn2Jw5qwjf3VTExUuBWbwhC
         P08HSNG4mlMeeAQE9D9MRInFCXzBXHyGCT+SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164425; x=1690756425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nq1QcjMnGfIZ/W8d+xE8ssqtAAponfz0QGs18ghKecs=;
        b=bilT+HHC/zHNch/hAft+Xqi+7H4KJ40iALmcy6llFRep5MbZ82mlcSI3VIk42CAUkm
         0FDCknpwZjRL1iXMdtBDyNr5LWvNlrhgxM8Rg+Xjp6cp0NttbhO2ek2mHtgA1bCqLCuz
         1OIE9N95iEGAM5nbMaZ0637ok1Ji9A4rw2Z/s7ZALXSBA2SJMSR2tnYmcR4fiT935AjN
         iao8JVC1eXpyX536kgz+CTKFZ/RcSBEjbRj2W07oNGRczgRzrkYbNPQCibxV9bdHAOnr
         WcFYJjTz9ZxDZkU95WtrsLo9CnKjkuApzZkdWPLIXZh1O2LSxIazVAGwHqYaEPJu5FjF
         ImQg==
X-Gm-Message-State: ABy/qLbUXF27CVSVx3R0yHKkgQdrrnGu32VqFi91QjivzgGhAa3mtGG+
        ZyPJnidai/UxF3HX+OOijrjloQ==
X-Google-Smtp-Source: APBJJlESTNjx5bHPxXJIAoycu0gyCWstYxfyBqmj5Yr6Xm5BspBzp5icngkNcTaSbfg30RdoDvRg0g==
X-Received: by 2002:a05:6870:e92:b0:1a2:8ebd:7d46 with SMTP id mm18-20020a0568700e9200b001a28ebd7d46mr5013095oab.21.1688164424896;
        Fri, 30 Jun 2023 15:33:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id em23-20020a17090b015700b0026356c056cbsm3105864pjb.34.2023.06.30.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:33:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
Date:   Fri, 30 Jun 2023 15:33:14 -0700
Message-ID: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes in v3:
- Back to v1 where we stash the handle in a local.

Changes in v2:
- Move the print, don't stash handle in a local.

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

