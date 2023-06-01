Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F409719094
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjFACiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjFACiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:38:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E18107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:38:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b0236ee816so3229245ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685587129; x=1688179129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6KIM/eqZlqxDnAEf4Mp5EKP1N4QltATian8TLmbDPw=;
        b=QFOUGOMhQNwiEvDUUlqmUAxS5rJPqYOvrxlHt3okDtgmyvL9g13tIhEJy6Xd4SoVYK
         eBieMkGDWEBagm0kGDwTd5rMj00cOQmKAhtbEyH3BUzhINyisq8uTEt0l3fNusLypewT
         FlVX7c3aUWbz/zAwlfYWNLWNqS7nQX7hSYwXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685587129; x=1688179129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6KIM/eqZlqxDnAEf4Mp5EKP1N4QltATian8TLmbDPw=;
        b=gjafCDmuNGnB6ZEJhsbmnT8xaso8kQuOOA1VeORBOYB48hp3I858eIko7ErO5Fy4pm
         0f+PJEHEbNMMzj3+vfzIdIEYidkImXRV1jiTrFOV276RgS+EbrTt5trOJc85QTOh8WLF
         tA+DN8kE4MxYu+NDYN8zaeDSz97E2g762b9X/+VowbjujGZGsvVSquBobDsRaYcQvUKS
         /FX1GJXEr8zKMiq+3jQNrIZxcl6MxVCXm5+mS3m8tjBJpcE4XnAQ5aEq/7TxJGvfFjhp
         n84Mfq556Jfs1QYNcVVF1vis7tJsJF12bGcj0nakJQQy5a1K39RH7B4/ubgfCyNX+ojM
         jvaA==
X-Gm-Message-State: AC+VfDwcdqQaIXkiWN9CNW5xsObpS4oalfx1GldaE5bTyBQjYCTCnRfc
        2W9SWppO/X8xtmRZDyimu0TOkw==
X-Google-Smtp-Source: ACHHUZ7gEL/GDu54KRGyiFnNCOXWK0l1/ZD+qeeR62f9kjeI0xeyE64fZ86A6WtyKKcaQ1LmcRcmiQ==
X-Received: by 2002:a17:902:c94f:b0:1af:b5af:367b with SMTP id i15-20020a170902c94f00b001afb5af367bmr469370pla.29.1685587128958;
        Wed, 31 May 2023 19:38:48 -0700 (PDT)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id z6-20020a170902708600b001a04d27ee92sm2077752plk.241.2023.05.31.19.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 19:38:48 -0700 (PDT)
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
        Min Li <lm0963hack@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v6] Bluetooth: Fix l2cap_disconnect_req deadlock
Date:   Thu,  1 Jun 2023 02:38:32 +0000
Message-ID: <20230601023835.1117866-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This patch releases chan->lock before acquiring the conn_chan_lock
to avoid the potential deadlock.

Fixes: a2a9339e1c9d ("Bluetooth: L2CAP: Fix use-after-free in l2cap_disconnect_{req,rsp}")
Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
This commit has been tested on a Chromebook device.

Changes in v6:
- Fixing format of the fixes tag.

Changes in v5:
- Fixing the merge conflict by removing l2cap_del_chan_by_scid.

Changes in v4:
- Using l2cap_get_chan_by_scid to avoid repeated code.
- Releasing chan->lock before acquiring conn->chan_lock.

Changes in v3:
- Adding the fixes tag.

Changes in v2:
- Adding the prefix "Bluetooth:" to subject line.

 net/bluetooth/l2cap_core.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 036bc147f4de..16ac4aac0638 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4634,26 +4634,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	return err;
 }
 
-static struct l2cap_chan *l2cap_del_chan_by_scid(struct l2cap_conn *conn,
-						 u16 cid, int err)
-{
-	struct l2cap_chan *c;
-
-	mutex_lock(&conn->chan_lock);
-	c = __l2cap_get_chan_by_scid(conn, cid);
-	if (c) {
-		/* Only lock if chan reference is not 0 */
-		c = l2cap_chan_hold_unless_zero(c);
-		if (c) {
-			l2cap_chan_lock(c);
-			l2cap_chan_del(c, err);
-		}
-	}
-	mutex_unlock(&conn->chan_lock);
-
-	return c;
-}
-
 static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				       u8 *data)
@@ -4671,7 +4651,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	chan = l2cap_del_chan_by_scid(conn, dcid, ECONNRESET);
+	chan = l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan) {
 		cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
 		return 0;
@@ -4682,6 +4662,13 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
 
 	chan->ops->set_shutdown(chan);
+
+	l2cap_chan_unlock(chan);
+	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
+	l2cap_chan_del(chan, ECONNRESET);
+	mutex_unlock(&conn->chan_lock);
+
 	chan->ops->close(chan);
 
 	l2cap_chan_unlock(chan);
@@ -4706,7 +4693,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	chan = l2cap_del_chan_by_scid(conn, scid, 0);
+	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan)
 		return 0;
 
@@ -4716,6 +4703,12 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_unlock(chan);
+	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
+	l2cap_chan_del(chan, 0);
+	mutex_unlock(&conn->chan_lock);
+
 	chan->ops->close(chan);
 
 	l2cap_chan_unlock(chan);
-- 
2.41.0.rc0.172.g3f132b7071-goog

