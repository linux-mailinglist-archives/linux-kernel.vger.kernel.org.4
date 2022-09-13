Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02125B7CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIMWEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIMWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:04:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32843B4A9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:04:43 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 2-20020a17090a0b8200b001fdb8fd5f29so6140754pjr.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=0/mpIJ2sZEnqGQU+eeGOiHwYV7wmza8JoOszk+ZskGw=;
        b=La2UwnxAwzAIGGTRGxRY2aTrW3UyWe1vYGqQwnejHW/RqXhDz1yh045Mn5/TmsTyFn
         PREzALzxxhe7wqsvV2a1r5msIKw6sh1z8ZWKRJ5DNUVYmntdMUA9YrYV6j06/m7A080i
         epGrr40YmEFv3o+fBQzzB1Fpr3Qy9Iky4VNXrVsFtYVHU3yNQpO1m5j53EiNBDM0dpz8
         nIxflgGMf6LG82a3G3gUhuBwzMrWb9jsiGf4tFbXP9duQ1vMSiKDLe8GBCuZ7atCjw+E
         Keh51/YMhMoHFIqCkDl8sZLYfh3Kt73sC5xg2D6iUPAyZJ9hbWyA3JmmMvVIsSfHi40e
         2WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=0/mpIJ2sZEnqGQU+eeGOiHwYV7wmza8JoOszk+ZskGw=;
        b=YSoOx1jCUITJuv88W24Cke+4tnB8fr5Yy62Zg76Y+VpcZHywJ0zRuPxRlctbS6t0u3
         5nS1mOq2i55HHzbv7V+1UlgkIWrTLQQjeMi5UW560KGyLh6ndMDwBz6c6Ope/JMxo3fQ
         0cLlq+X/SefkEHmj7BofKACdDjXyCCjZMLFMloj35kVYJ0CAxUOs7MyJ6cMb4lRY6gRV
         LsZqGlrYFSc31eczWhe6QN12qHMXmT4gHhcltUmhD2zkDEi8Bup986QA1v8yD+ds1B2W
         +0PwEDo9Wy2iUza6NDBntK9g5ZiA6Sl/We/hjoub+yo5fuiago/ColmCbIwj/NCxwL9R
         3INQ==
X-Gm-Message-State: ACrzQf3fTb88Wj/JPCkFcfnQH4lKTlSiPxRbaO6M8MgBUD3taDv9U7+R
        mPBDPSWHJWPfpvr2RO+8bMKM8gNQsBxg
X-Google-Smtp-Source: AMsMyM67wH92vPtBbRZur6xn/xAJQLsTNPKQnIQuXSlrC9cCXreVggMRolS4xlStq9OL3cYYQ8CiMAMqWSAf
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:1b12:b0:200:5dbd:adff with SMTP id
 nu18-20020a17090b1b1200b002005dbdadffmr1364786pjb.43.1663106682689; Tue, 13
 Sep 2022 15:04:42 -0700 (PDT)
Date:   Tue, 13 Sep 2022 15:04:33 -0700
In-Reply-To: <20220913220433.3308871-1-jiangzp@google.com>
Mime-Version: 1.0
References: <20220913220433.3308871-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913150420.kernel.v1.1.I54824fdfb8de716a1d7d9eccecbbfb6e45b116a8@changeid>
Subject: [kernel PATCH v1 1/1] Bluetooth: hci_sync: allow advertising during
 active scan without privacy
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address resolution will be paused during active scan to allow any
advertising reports reach the host. If LL privacy is enabled,
advertising will rely on the controller to generate new RPA.

If host is not using RPA, there is no need to stop advertising during
active scan because there is no need to generate RPA in the controller.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Check privacy flag when disable advertising

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 41b6d19c70b06..422f7c6911d9f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5351,7 +5351,7 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	/* Pause advertising since active scanning disables address resolution
 	 * which advertising depend on in order to generate its RPAs.
 	 */
-	if (use_ll_privacy(hdev)) {
+	if (use_ll_privacy(hdev) && hci_dev_test_flag(hdev, HCI_PRIVACY)) {
 		err = hci_pause_advertising_sync(hdev);
 		if (err) {
 			bt_dev_err(hdev, "pause advertising failed: %d", err);
-- 
2.37.2.789.g6183377224-goog

