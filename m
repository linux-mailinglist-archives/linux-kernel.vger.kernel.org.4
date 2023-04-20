Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1474E6E9432
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjDTMXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjDTMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:23:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F731BF4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:23:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 132-20020a250c8a000000b00b8f4e12dd57so1981912ybm.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681993424; x=1684585424;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VyYkUgfpkn7wH0j2BAe1UVwheOGlOiDjxtv8agVE+bw=;
        b=TbQn/Mbd2r9XbgqECjXDNQ1qXc11e+lRv5zVbY5g0fUxU/wBDgi0LWdBvJ5EzfN2vS
         nbC0c3At6RoNmHTkHR7olw8UwMzG78HCLxLcPErHiS/OjPLCaKqfWb4ihfJFtRDkOInk
         5/xJJwjjSRtVs4SvIGI+ija/vJ+OpKQJP/bI64FBBytS2a+frulCCNNKSlQxPdJXjueo
         OwIo0PzvJTH+t14FcAXUSmdH6RsQ1BaU10JvbGZXM8W7dzClnZ0sGZ8dBdbQz3d3oRVB
         idGJUnyeoIQuTUE3Pqa5RYfI3fvc6B1omoFTq6C4av/3vsyTbzJzisxdMsKBZF95I7fQ
         Vvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993424; x=1684585424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyYkUgfpkn7wH0j2BAe1UVwheOGlOiDjxtv8agVE+bw=;
        b=dPWYrgugBJ/032NvwgBit3/JjEaJxK4Dkj6YrgJ5CUV3Ta0b6u8+ABddUluUkBbBmY
         HH8g/Ck/2Uz4K7DnoZ0LippqSX83uRLYwYbJ0yOIj+2MljMrIfyYI95BXkhbO4mER+6z
         i/nVbmWLILiXcQ5LBRxMqdIltwVbMLFtAkppwCz6sTaKqGvpQkj3704ddZcEvQiZuM4s
         9qsSRbD5BR3jjH+Of8rycC8bru55I7L2hK8yGuWhlyWx3cBEWtiim66yRlFFQHMM/uc2
         j4h8ADILKz8h18czfPjamKHz9OJPsH8WG8cnXgbw0qRsjOhNWT0A5kA/iBeUvEc6GIzC
         IHiA==
X-Gm-Message-State: AAQBX9cWHm2Jou0ZgJu+9LllER4evrjEe0K/5mnG6sSvjqOdFyU9qUtt
        /eWBaMOhrnRrHdawTvBUWxCBqqyKKzm1
X-Google-Smtp-Source: AKy350abez9O9onkkWOz4907E7Tm2r2pMZdIYnuyIOpOSJjrHP1NRWsW0B4RvmPmbW4IZX2IfF9GAKPclgfj
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:f314:6a1b:5ed1:38f4])
 (user=apusaka job=sendgmr) by 2002:a25:d796:0:b0:b92:5112:3f53 with SMTP id
 o144-20020a25d796000000b00b9251123f53mr673809ybg.2.1681993424038; Thu, 20 Apr
 2023 05:23:44 -0700 (PDT)
Date:   Thu, 20 Apr 2023 20:23:36 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420202312.1.I53bc906a716045c7474a77d3038bfcb6909094e2@changeid>
Subject: [PATCH] Bluetooth: Cancel sync command before suspend and power off
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Ying Hsu <yinghsu@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

From: Archie Pusaka <apusaka@chromium.org>

Some of the sync commands might take a long time to complete, e.g.
LE Create Connection when the peer device isn't responding might take
20 seconds before it times out. If suspend command is issued during
this time, it will need to wait for completion since both commands are
using the same sync lock.

This patch cancel any running sync commands before attempting to
suspend or adapter power off.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Ying Hsu <yinghsu@chromium.org>

---

 net/bluetooth/hci_core.c | 3 +++
 net/bluetooth/mgmt.c     | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 393b317ae68f6..a856b1051d355 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2803,6 +2803,9 @@ int hci_suspend_dev(struct hci_dev *hdev)
 	if (mgmt_powering_down(hdev))
 		return 0;
 
+	/* Cancel potentially blocking sync operation before suspend */
+	__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
+
 	hci_req_sync_lock(hdev);
 	ret = hci_suspend_sync(hdev);
 	hci_req_sync_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5f8c144c84b88..13c745876b390 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1399,6 +1399,10 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	/* Cancel potentially blocking sync operation before power off */
+	if (cp->val == 0x00)
+		__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
+
 	err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
 				 mgmt_set_powered_complete);
 
-- 
2.40.0.634.g4ca3ef3211-goog

