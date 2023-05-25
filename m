Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2817101E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjEYAEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjEYAEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:04:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ACBB3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:04:22 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1ae3f6df1afso7973375ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684973062; x=1687565062;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxmNnYgfaOtAwG3k7PZVh3xrHSOh7px0pgm2Rioiw6o=;
        b=Zj/fw8nmn6hoYdeGZf06QX+F1CudDEYVZTfIJKpBptP+hQz+AZfbDSs7kYyL9lhaFA
         FXHGJ5L0Q9h2//2gGs1HpTjxvAE6PdCxlUoHz/4QXOWjMeAV1rbvHhvbLPiIuJ1YeIFE
         KHbnV8A6PvqAovc8k8Ow1+C1zdzBh9oFFbirPuZQQHMW2/PFRTtpPSFlztSli9AdsFYw
         zWLU8dzks5nY9Ls9UASK0kWl0olJjSKCPycJ3LkGw2YTh+So7V7pSa/nWKz+gshuPSHB
         jn26lgjzx6kWOCz1yUE5C9ERczfnh3iquHaWH9PKXTkPEZVat7p0W/nI8FiQ1KjumdYd
         a1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684973062; x=1687565062;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxmNnYgfaOtAwG3k7PZVh3xrHSOh7px0pgm2Rioiw6o=;
        b=gDqodg9PaLSyP19RJVabNrc4Dl8KsjuxrjDC8NMwnE7LVnsU55Bsa6zVnM2VgJBi5X
         H+mnGfe2G/y8OwUBjxDcfHzey6ng3hp6HHRWCoj45H7h4KS8382wfVciVAlSjnnR2n+u
         3uYt+TE40BdW7aRQvrgnYaVmR4PdkggQ26SqPqwirKIs4vsZfmp7/v8AHbBZHzoeirx3
         5RW00LMmRgrmeRcn0WjEYKeXIySazVCPDwKCnlEkXv9JmtafiDBcHDLj7Glke2or2To4
         eA/1y/JiwvR45it+F5c4nQiRBK1x1gyNppY5GJ6bDtC2xW3tK8SaH8xr2SZy/LElVGFb
         w6sg==
X-Gm-Message-State: AC+VfDxEasaCgzxJmAMGOTSkQOxLWz8jmdFrMXz69Sn9ghLnevDI5fT1
        mMqcD71SefUAjBgxAyfXMW94pNJtHKWy
X-Google-Smtp-Source: ACHHUZ6hpmN3QjzofQnR261iNpNAsxsI9fXdPsPI51ofRYxGfFB1NDraSuymfcJxH3lVr8U4UxXo3bTULABm
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:902:7587:b0:1ae:5f7e:c115 with SMTP id
 j7-20020a170902758700b001ae5f7ec115mr4392038pll.11.1684973061937; Wed, 24 May
 2023 17:04:21 -0700 (PDT)
Date:   Wed, 24 May 2023 17:04:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524170415.kernel.v1.1.I575ec21daa35ebba038fe38e164df60b6121c633@changeid>
Subject: [kernel PATCH v1] Bluetooth: L2CAP: Fix use-after-free
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
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

Fix potential use-after-free in l2cap_le_command_rej.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Use l2cap_chan_hold_unless_zero to prevent adding refcnt when it is
  already 0.

 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 376b523c7b26..19b0b1f7ffed 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6361,9 +6361,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
-- 
2.40.1.698.g37aff9b760-goog

