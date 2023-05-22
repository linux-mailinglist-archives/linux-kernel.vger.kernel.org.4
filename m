Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F970C143
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjEVOiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjEVOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:38:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36FAB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:38:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso1159837b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684766300; x=1687358300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YPyrsVUlvNm+NcxG8kD6DkQObDPDskSuRSFzaPM82o=;
        b=SvgVkEojKc7aZ48xKy9aZ7SG3oJmaOkHmKB7MBBQZ9tS5lY0KUAoOSlyzRJvBS+kmu
         C9Tc+q58SigKg1HoGaQd6hpXtUVAWH2LZEi12DenO35F4SR/KMeaT1+9fiHt6eK2s8kz
         6o4USrC36jBVli59P4EhI2H9BwaLvqg+Efsd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684766300; x=1687358300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YPyrsVUlvNm+NcxG8kD6DkQObDPDskSuRSFzaPM82o=;
        b=ZYR+QNb7O5QGBc8weuBPFKcyzTzO7vqC4inrIsn8YY165AF9FqNqWlPQ+H7yWGmp/C
         AwWK8I3j3dqHPOtUvrGBzQ16uzF6bl3AdcajlVehIh59a6UFVz2VoACCLITifigKCLV5
         xn7M7u6vnMIXM/TKiCvxaLirxmgmF8IcraePtXWQyH9pqdjib8S5497b4xWhOR5xO2bu
         IzUq/xyB6FGZPbwkgpm/Fg6wIFCCw/mWK1wOfNPbhA/I75LshfHGrvh9obpYmDtxVup/
         nhevXQXBvhy8QpupaqMhwcktUfkEQhtoS912U5yA2D6CRvT20wm/Je1Mzj+xi2EqtnXS
         tLmQ==
X-Gm-Message-State: AC+VfDxKpg7yTLtDLr9N2abgDeidsTCVuLlrWXjqxX5Th7z4Lk+EnM50
        AHCYSjRQicYapgQl92GYMJ4Zzg==
X-Google-Smtp-Source: ACHHUZ4CWQp9pX0b2g37TgDBnbqKc0kFeicAyVPp1u3V8SxSnPR1C80GGNIXyvh22MOd2uU8idwjig==
X-Received: by 2002:a05:6a00:1486:b0:63f:120a:1dc3 with SMTP id v6-20020a056a00148600b0063f120a1dc3mr16165748pfu.0.1684766299980;
        Mon, 22 May 2023 07:38:19 -0700 (PDT)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id d18-20020aa78152000000b0062e0c39977csm4208846pfn.139.2023.05.22.07.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 07:38:19 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] Fix l2cap_disconnect_req deadlock
Date:   Mon, 22 May 2023 14:37:55 +0000
Message-ID: <20230522143759.2880743-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L2CAP assumes that the locks conn->chan_lock and chan->lock are
acquired in the order conn->chan_lock, chan->lock to avoid
potential deadlock.
For example, l2sock_shutdown acquires these locks in the order:
  mutex_lock(&conn->chan_lock)
  l2cap_chan_lock(chan)

However, l2cap_disconnect_req acquires chan->lock in
l2cap_get_chan_by_scid first and then acquires conn->chan_lock
before calling l2cap_chan_del. This means that these locks are
acquired in unexpected order, which leads to potential deadlock:
  l2cap_chan_lock(c)
  mutex_lock(&conn->chan_lock)

This patch uses __l2cap_get_chan_by_scid to replace
l2cap_get_chan_by_scid and adjusts the locking order to avoid the
potential deadlock.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
This commit has been tested on a Chromebook device.

 net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 376b523c7b26..8f08192b8fb1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4651,8 +4651,16 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	chan = l2cap_get_chan_by_scid(conn, dcid);
+	mutex_lock(&conn->chan_lock);
+	chan = __l2cap_get_chan_by_scid(conn, dcid);
+	if (chan) {
+		chan = l2cap_chan_hold_unless_zero(chan);
+		if (chan)
+			l2cap_chan_lock(chan);
+	}
+
 	if (!chan) {
+		mutex_unlock(&conn->chan_lock);
 		cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
 		return 0;
 	}
@@ -4663,14 +4671,13 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
-	mutex_lock(&conn->chan_lock);
 	l2cap_chan_del(chan, ECONNRESET);
-	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
+	mutex_unlock(&conn->chan_lock);
 
 	return 0;
 }
@@ -4691,25 +4698,32 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	chan = l2cap_get_chan_by_scid(conn, scid);
+	mutex_lock(&conn->chan_lock);
+	chan = __l2cap_get_chan_by_scid(conn, scid);
+	if (chan) {
+		chan = l2cap_chan_hold_unless_zero(chan);
+		if (chan)
+			l2cap_chan_lock(chan);
+	}
 	if (!chan) {
+		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
+		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
-	mutex_lock(&conn->chan_lock);
 	l2cap_chan_del(chan, 0);
-	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
+	mutex_unlock(&conn->chan_lock);
 
 	return 0;
 }
-- 
2.40.1.698.g37aff9b760-goog

