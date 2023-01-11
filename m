Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA43665241
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAKDTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjAKDS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:18:27 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC16914086
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:18:22 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so15419313pll.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAbF+23J3WNopzFWmwTkdmCspCTcLNnSoUJcTK0GAFs=;
        b=DE/cmeK3OBSndt4c0IKA6JG+HDRlOVKjYBXKoUihcvFcJ03NuoZwBVHI7wxYUvMJxT
         wuZiHEjFprkHQl3NkLLHZtmv2YdO9qBE6cpxlLWIVEJUPeD6QLsqgY8SGHFIzDnv76mE
         vZoICCP+B8Zt7b9OorU2AuvtzSSo/rp3U9qjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAbF+23J3WNopzFWmwTkdmCspCTcLNnSoUJcTK0GAFs=;
        b=i4aR6+xTVbpCBoUf+wfVAJat/41icOSyJvMyQQc6rJsLODN5nu7H/15yq7u55F11TA
         HLOHABDkFbRVc4KaDy9NDmd2nNrWXhEkqpx73J/IzH+NigJET5prc0UlM5Im1YXV5UK0
         RKlwwPz0VGpAcwpqRD62QAFByMsQ1eLmgQrF6E+aCyu1Xy0IbyvRdkCua2ir0khMUHiw
         uNPmUds7BoBDTF+cRTFA0e0+21YdWQbqHO8j+r2aw1nUed2gIrniNpnhxTpPXDRILmiq
         4Nh3dCScCsmXvck0np4Fw4+TByYVdzsrZE+ANZSNyU4D5OEVokzpyfeQ3MpV8TFe+I/8
         SSyQ==
X-Gm-Message-State: AFqh2kqtaPJh8v5OT+rOMaCnr7WVZmuiyUJOLmueHzZ0QF4goGMaJVp9
        j92T53n6QUwRDGiFBH/Boy8hlw==
X-Google-Smtp-Source: AMrXdXtdXPd92VZ4OuZs+hLhLJ0sBhmQ9zsy8iKrN3gjRA28v67aK3QwpoKwrHM7ZfKUz/fBm/dk8g==
X-Received: by 2002:a05:6a20:3c8a:b0:af:8128:757 with SMTP id b10-20020a056a203c8a00b000af81280757mr110302543pzj.61.1673407102474;
        Tue, 10 Jan 2023 19:18:22 -0800 (PST)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id gk19-20020a17090b119300b00218f9bd50c7sm7896488pjb.50.2023.01.10.19.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 19:18:21 -0800 (PST)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        leon@kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Fix possible deadlock in rfcomm_sk_state_change
Date:   Wed, 11 Jan 2023 03:16:14 +0000
Message-Id: <20230111031540.v3.1.I1f29bb547a03e9adfe2e6754212f9d14a2e39c4b@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reports a possible deadlock in rfcomm_sk_state_change [1].
While rfcomm_sock_connect acquires the sk lock and waits for
the rfcomm lock, rfcomm_sock_release could have the rfcomm
lock and hit a deadlock for acquiring the sk lock.
Here's a simplified flow:

rfcomm_sock_connect:
  lock_sock(sk)
  rfcomm_dlc_open:
    rfcomm_lock()

rfcomm_sock_release:
  rfcomm_sock_shutdown:
    rfcomm_lock()
    __rfcomm_dlc_close:
        rfcomm_k_state_change:
	  lock_sock(sk)

This patch drops the sk lock before calling rfcomm_dlc_open to
avoid the possible deadlock and holds sk's reference count to
prevent use-after-free after rfcomm_dlc_open completes.

Reported-by: syzbot+d7ce59...@syzkaller.appspotmail.com
Fixes: 1804fdf6e494 ("Bluetooth: btintel: Combine setting up MSFT extension")
Link: https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218 [1]

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
This commit has been tested with a C reproducer on qemu-x86_64
and a ChromeOS device.

Changes in v3:
- Revise the commit message.

Changes in v2:
- Fix potential use-after-free in rfc_comm_sock_connect.

 net/bluetooth/rfcomm/sock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 21e24da4847f..4397e14ff560 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -391,6 +391,7 @@ static int rfcomm_sock_connect(struct socket *sock, struct sockaddr *addr, int a
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
+	sock_hold(sk);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
@@ -410,14 +411,18 @@ static int rfcomm_sock_connect(struct socket *sock, struct sockaddr *addr, int a
 	d->sec_level = rfcomm_pi(sk)->sec_level;
 	d->role_switch = rfcomm_pi(sk)->role_switch;
 
+	/* Drop sock lock to avoid potential deadlock with the RFCOMM lock */
+	release_sock(sk);
 	err = rfcomm_dlc_open(d, &rfcomm_pi(sk)->src, &sa->rc_bdaddr,
 			      sa->rc_channel);
-	if (!err)
+	lock_sock(sk);
+	if (!err && !sock_flag(sk, SOCK_ZAPPED))
 		err = bt_sock_wait_state(sk, BT_CONNECTED,
 				sock_sndtimeo(sk, flags & O_NONBLOCK));
 
 done:
 	release_sock(sk);
+	sock_put(sk);
 	return err;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

