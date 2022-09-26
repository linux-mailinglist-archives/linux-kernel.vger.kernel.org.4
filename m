Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938A5EB5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiIZXoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIZXoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:44:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA17F0B5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:44:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b10-20020a17090a12ca00b002034af352d0so3689142pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=4yZe56aAtuiDtJwfWDhM4RsiutBMFyeu7ZTmrp0RKL4=;
        b=VVfu0virBhkCEKaIMFZc0zucaa3SVAAfFeZRrBiMwrmyRIEErqGjruR/AaUdU0jO9r
         g9fYl7Nhl8URjAmWkweHB4SDweyjweoyW7fdYdNwQRuTkvCKzta57ljdi26hZagVnzgt
         /beypmuTTtS5K67uVKWKLKMP7e2o46pahZdXmUs9odwhT7ipwd/ab4wWnzXHlvuvcyX7
         mZWRHodFdwLATzqoRD4B7SlMQn4gbGqlV9FOLPm1dqZdf0FmWUnzK212LEUv66Yo00ox
         kbNJ8swTOQfEoUfj/3yOdvisDqPo0uCmqw6xp6WHFw8QJheV+rrRFhmnqacpFXc1KFV9
         1onA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4yZe56aAtuiDtJwfWDhM4RsiutBMFyeu7ZTmrp0RKL4=;
        b=bbIpDDSSfTYIpBfWxt4JPPI5ExsSfMGoBXT0G/V3McRscnzzZOok8GNAb6NguwppZu
         EVXokcpzInInS1AKEGmZvDBFmHfbQ56DvubKHeRKsgyfTpfo6OT/Ve139/cFPJuquB+y
         tTSgZJehUdqhCoSjyc8ha1KMM9S/UFmOHoKxGFsRtIoUfCUxdwedZsCZtQhc7ox9xpSF
         v2sDOU537nIBmc8mfqVvfz1vP20VSb1L8vJ1Ca1fU7zDPBIdtjbMCLGawaYnb//E0WSb
         GTVMkPayMxw5N6PJEedZAVaB4MCzEkB4eOvcM15jUzzS1Fbi9yyFVUfQ6kg3uvu0KLO7
         tDUA==
X-Gm-Message-State: ACrzQf1FzrzBkf1B6DhO3HZB/MAdlrkaLyWGUeKq69FFhrRpytol0Ngw
        k9uxAAHtUSaGrH6KzzCAvIdSg9IvkDT5f3sTlegNbw==
X-Google-Smtp-Source: AMsMyM434rTcHsdn97RL7+tq/m9aeIJbw0s+tzm3rDd559JndlyPU3vBODLMQElmeFIclwIynj+iw6qJEm5nRiZopXbkug==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a17:902:cec4:b0:176:be0f:5c79 with
 SMTP id d4-20020a170902cec400b00176be0f5c79mr24981106plg.40.1664235848042;
 Mon, 26 Sep 2022 16:44:08 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:44:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926164358.v2.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
Subject: [PATCH v2] Bluetooth: Call shutdown for HCI_USER_CHANNEL
From:   Abhishek Pandit-Subedi <abhishekpandit@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Some drivers depend on shutdown being called for proper operation.
Unset HCI_USER_CHANNEL and call the full close routine since shutdown is
complementary to setup.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Using hci_qca, we can get the controller into a bad state simply by
trying to bind to userchannel twice (open+bind+close, then open+bind).
Without running the shutdown routine, the device seems to get into a bad
state. A similar bug also occurs with btmtksdio (using MT7921).

This change properly runs the shutdown routine, which should be
complementary to setup. The reason it unsets the HCI_USER_CHANNEL flag
is that some drivers have complex operations in their shutdown routine
(including sending hci packets) and we need to support the normal data
path for them (including cmd_timeout + recovery mechanisms).

Note for v2: I've gotten a chance to test this on more devices
and figure out why it wasn't working before in v1. I found two problems:
I had a signal pending (SIGTERM) that was messing things up in the
socket release function and the HCI_USER_CHANNEL flag was preventing
hci_sync from operating properly during shutdown on Intel chipsets
(which use the sync functions to send a reset command + other commands
sometimes).

This was tested with hci_qca (QCA6174-A-3), btmtksdio (MT7921-SDIO)
and btusb (with AX200).


Changes in v2:
- Clear HCI_USER_CHANNEL flag at start of close and restore at end.
- Add comment explaning why we need to clear flag and run shutdown.

 net/bluetooth/hci_sync.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 422f7c6911d9..f9591fcefb8d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4731,9 +4731,18 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 {
 	bool auto_off;
 	int err = 0;
+	bool was_userchannel;
 
 	bt_dev_dbg(hdev, "");
 
+	/* Similar to how we first do setup and then set the exclusive access
+	 * bit for userspace, we must first unset userchannel and then clean up.
+	 * Otherwise, the kernel can't properly use the hci channel to clean up
+	 * the controller (some shutdown routines require sending additional
+	 * commands to the controller for example).
+	 */
+	was_userchannel = hci_dev_test_and_clear_flag(hdev, HCI_USER_CHANNEL);
+
 	cancel_delayed_work(&hdev->power_off);
 	cancel_delayed_work(&hdev->ncmd_timer);
 	cancel_delayed_work(&hdev->le_scan_disable);
@@ -4747,7 +4756,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	}
 
 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
-	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    test_bit(HCI_UP, &hdev->flags)) {
 		/* Execute vendor specific shutdown routine */
 		if (hdev->shutdown)
@@ -4756,6 +4764,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		cancel_delayed_work_sync(&hdev->cmd_timer);
+		if (was_userchannel)
+			hci_dev_set_flag(hdev, HCI_USER_CHANNEL);
 		return err;
 	}
 
@@ -4795,7 +4805,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
 
 	if (!auto_off && hdev->dev_type == HCI_PRIMARY &&
-	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+	    !was_userchannel &&
 	    hci_dev_test_flag(hdev, HCI_MGMT))
 		__mgmt_power_off(hdev);
 
@@ -4808,7 +4818,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	hci_sock_dev_event(hdev, HCI_DEV_DOWN);
 
-	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+	if (!was_userchannel)
 		aosp_do_close(hdev);
 		msft_do_close(hdev);
 	}
@@ -4858,6 +4868,9 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
 
+	if (was_userchannel)
+		hci_dev_set_flag(hdev, HCI_USER_CHANNEL);
+
 	hci_dev_put(hdev);
 	return err;
 }
-- 
2.37.3.998.g577e59143f-goog

