Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614225FE45A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJMVpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJMVpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:45:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD16A496
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:45:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3521c1a01b5so28483117b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OC2TRA3RaKZigj+gmSjzr1uEQcbYSV2Diu4v9YA/yVc=;
        b=Jvauj2Q8iA9kDTzQWwJBKr0DPFzDpCVXLD9hYoQepUDDEB1Pcjr9WF6SSuCE0VhizD
         VDPJcwpU5AwyBpUWvY0drVpP4zS6ILIfXzmj8qUTV+03IFJwb+AVAwHRDoPx6BVlJuVs
         Sa044RS7mErdfOSGrjDUfsSgxPCxhxDA7qIEv3lTeuyZm6WT6cWlnXOzXNwhkYrWGKAd
         R4pCjTV4Iq+Zc8ULAR8mM7W5r3xGZ1A4o2AnB6XddaaCv/bIQYc1/ul2AckiFUZrTxK3
         s85kK+WkMfKX1SYEjBFVpk4f+KGUSDYSlO5iItD8px/jVuFIAosl+jLeqCEEmUCGXZMl
         +q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OC2TRA3RaKZigj+gmSjzr1uEQcbYSV2Diu4v9YA/yVc=;
        b=a7/0p/hl7eDjpHID7yUaiVmTVw/dhyjI/BxEHQ/DzCSXi5aT8WJOneYvxRRev300No
         zHf3V8wrUOD3PgV2PEwnE/fEOHlorui9TjSguS4am7f+CfZOC9sWwxIlRHR2GkXMwcRY
         FZf2mvEfanaZ1IIaQAABcO9nM+yyQfIPY8gUJ0O9M/5iI+u79vF8hnr2+a8kGAxUGvbT
         +kX++CjLGU7sID6M0Gre8WCA3RqZhYjenxvsKNC4Rzax1QbbCs86mz5zyWTysNAzJnlg
         OKMUjKfrbF8Qvgd6yZeawCxSRkh4MGc3oxY3LjiairFhY+5QqFDL8ud7oz6zHoeYAzkr
         JWKw==
X-Gm-Message-State: ACrzQf0nam0qeV4LnMWf4XQQt8N91i7gEdOv5juqqdgjUJD2CSUB+hBL
        y+XgyWIVw1GqHpQ1+jjXXi43M7WXIhPU
X-Google-Smtp-Source: AMsMyM4AJHKhvfkmvHItxuzNajgyI8OQNsNSRQ+SRT+HvEQTaurv0wK9KSgha+RuRm7FSJewIibC+DbXofiW
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a0d:c942:0:b0:337:5cf9:1c04 with SMTP id
 l63-20020a0dc942000000b003375cf91c04mr1907615ywd.39.1665697517001; Thu, 13
 Oct 2022 14:45:17 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:45:08 -0700
In-Reply-To: <20221013214508.2195347-1-jiangzp@google.com>
Mime-Version: 1.0
References: <20221013214508.2195347-1-jiangzp@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013144431.v1.1.I47f1918a2786b34e7649387233377c57a8bdcdac@changeid>
Subject: [PATCH v1 1/1] Bluetooth: hci_qca: only assign wakeup with serial
 port support
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only assign hdev->wakeup if the serial port supports wakeup. Otherwise
it will fall back to the hci_uart_wakeup or the behavior that can be
overridden before calling the hci_uart_register_device().

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Check serial port support before assigning wakeup callback

 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8df11016fd51..dacb6f5efd29 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1765,7 +1765,8 @@ static int qca_setup(struct hci_uart *hu)
 		qca_debugfs_init(hdev);
 		hu->hdev->hw_error = qca_hw_error;
 		hu->hdev->cmd_timeout = qca_cmd_timeout;
-		hu->hdev->wakeup = qca_wakeup;
+		if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
+			hu->hdev->wakeup = qca_wakeup;
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		set_bit(QCA_ROM_FW, &qca->flags);
-- 
2.38.0.413.g74048e4d9e-goog

