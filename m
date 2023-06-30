Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3385674448A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjF3WKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjF3WKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:10:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651383C22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:10:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55adfa72d3fso1310486a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163019; x=1690755019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ7kxnAKg6Cu8Pu7Voq9nKWydDnN6Tk0Ch2JNhThoso=;
        b=aGkPwnLnHayzjcvlPC0S/w8My+uR91LuCAWSxVO4ashAxJ1pmhX/Ebg1wreE5baRh9
         ipTQHJK80q1LmoGv4y1dxVHl+x0VkLHjPDlqiD2UnPcXgDWjMXGVQB0KbU1+rBZEHA66
         NtBF7MwzFRdjHIb4vortgyayAbaOd2zEvjC9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163019; x=1690755019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJ7kxnAKg6Cu8Pu7Voq9nKWydDnN6Tk0Ch2JNhThoso=;
        b=PzEYe3039sDfXNFqGHyElU/wJCzDNcqPRyCja1BI7OnQC0BR/LJOhqGSaEMr91uNgy
         PF9fkwg/TlexgvgfeGyz945QTAkQtMadW3CcvTFqjTbLuGo9M7qVOe8S8/9n07b6Kxwc
         K7REaBVB8mXCFk/7iLo0yWT20WjOKojpK+Tzr553ufEg6/G+DDjJrIqIpcrtu3iM3AWa
         +yjyKgrMS/S2ymQjO7W6rdBoWN28gcBTKLbmWSPXms0KCIXUCFeYkm82EW1XBR0SSELf
         vgU1+MUBfLA0x3B9mJbhWlYnlTYgns1h+9O/8yRu4BMIl3n+CIvcYzPEbQ7+r2/hC6Ny
         colg==
X-Gm-Message-State: AC+VfDxmXgO5ey+jUNi/gHzGR+ba3eimLOyy+Egiz/8npG7/jQdkVVgU
        97cR8nl6qnU2VTqmj5GZVH2QHg==
X-Google-Smtp-Source: ACHHUZ5vRSB70zXnWQz1lLVzwVB4LIsI55bIhO5OlwOkZSSgqWm+WZvjUNS+IX5K9D+iEprZUhwVcQ==
X-Received: by 2002:a05:6a20:b711:b0:12c:7528:d981 with SMTP id fg17-20020a056a20b71100b0012c7528d981mr2972407pzb.18.1688163018835;
        Fri, 30 Jun 2023 15:10:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001ac897026cesm11238797plh.102.2023.06.30.15.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:10:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
Date:   Fri, 30 Jun 2023 15:09:06 -0700
Message-ID: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
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

Moving the printout to before the memory is freed.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Move the print, don't stash handle in a local.

 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 48917c68358d..7e2ecf8a55d8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1980,9 +1980,9 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
-		status = msft_remove_monitor(hdev, monitor);
 		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
 			   hdev->name, monitor->handle, status);
+		status = msft_remove_monitor(hdev, monitor);
 		break;
 	}
 
-- 
2.41.0.255.g8b1d071c50-goog

