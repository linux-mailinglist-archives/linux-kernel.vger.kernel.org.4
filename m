Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D6F7101E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjEYAMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEYAMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:12:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717B7135
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:12:04 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64d20f79776so921388b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684973524; x=1687565524;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CuGzP4jvcFhZR0qNDB5MEw2qn9YAXXZ3upPhfuHloLo=;
        b=QyP5/8p7Gy/PZSdwURtv5JC7lUyDeFZAlQgrfKUMESQAz11X9jTC701MmiWTjBTWvF
         IAuICHYBgGOZqQeEcyVQjQpaMAQYEio+n0H39WxwzhfDxbpisBUkNZjpTJD5ubWRy1Iy
         c6nUdTAJEBFUNl/+Byq7Cyfiw0sqvpVQLlvMrz2cFsUwhoccvg3tiIsUCPORX8Fr1MC5
         u000gRpAjzCP6n671I4By3AFo3+L3eeMmeRAwC87rjDfLnqU7Xk3YbbsJ516rCo/V6py
         UEzelwVRqWiBazvdg4pIdomKH5G/lutEBpQNw1JZ8k27mpiU74Cz5jr01Ri8TpDddZUW
         QLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684973524; x=1687565524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuGzP4jvcFhZR0qNDB5MEw2qn9YAXXZ3upPhfuHloLo=;
        b=fdzgXnuy8Uk9WrGo1Ax4RmDYLMaGWcAaLfn7Guu0ea+SUGA1uma+w6T/aIHJdo3xI4
         6TuzUdLS5SBozVPmgaz64jFNs2rCeqPvsVpdPJ4kBvhuSu+Yujyu3kYbLYBwUqNM1vrp
         uXef2ITrYK1gwr+hEop9AG1K2RxcrcsxN1KEkyFR0s38pOhI4ggBmi2DarjSQtMWm8rt
         xC2rtV+nlECeWZ6QfktiOFofaAH2HjXqASe0IM4hTgO+stC8/k+HO9mR/flyRQI7nHjY
         FS4ktLn+lmrkweTaYE9m3LLwpMxYTh8dNX6WyDZMWOgq374E2KKX+34GHmog6mjngLSE
         0MNQ==
X-Gm-Message-State: AC+VfDzhH0j9fUnAca1aEgIVYkdkvbnkBw/RLUpXhflLzIuBNf78vOcq
        ZTBHIGdHHpriaND5/Pou5etiosWIvqMW
X-Google-Smtp-Source: ACHHUZ5L4U6ncBchHbVPNxt3jSblZwPArf1Lu6PXIrUka0L1XTGS+c1Dcdl+Z/M7MxNvOvoT5Wxs5g76s7/Q
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:1514:b0:63d:397a:8fdd with SMTP
 id q20-20020a056a00151400b0063d397a8fddmr1747469pfu.0.1684973523938; Wed, 24
 May 2023 17:12:03 -0700 (PDT)
Date:   Wed, 24 May 2023 17:11:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524171158.kernel.v1.1.Ie9c81a5f8bbdb4f9a2007c56f05001d7e674dbe0@changeid>
Subject: [kernel PATCH v1] Bluetooth: hci_sync: add lock to protect HCI_UNREGISTER
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the HCI_UNREGISTER flag is set, no jobs should be scheduled. Fix
potential race when HCI_UNREGISTER is set after the flag is tested in
hci_cmd_sync_queue.

Fixes: 0b94f2651f56 ("Bluetooth: hci_sync: Fix queuing commands when HCI_UNREGISTER is set")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Add a lock to protect HCI_UNREGISTER flag

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  2 ++
 net/bluetooth/hci_sync.c         | 20 ++++++++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c86ecce34854..9a21b4787df5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -515,6 +515,7 @@ struct hci_dev {
 	struct work_struct	cmd_sync_work;
 	struct list_head	cmd_sync_work_list;
 	struct mutex		cmd_sync_work_lock;
+	struct mutex		hdev_unregister_lock;
 	struct work_struct	cmd_sync_cancel_work;
 	struct work_struct	reenable_adv_work;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a856b1051d35..216c78656133 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2686,7 +2686,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 {
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
+	mutex_lock(&hdev->hdev_unregister_lock);
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
+	mutex_unlock(&hdev->hdev_unregister_lock);
 
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 647a8ce54062..2038335bdc85 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -629,6 +629,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
 	INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
 	mutex_init(&hdev->cmd_sync_work_lock);
+	mutex_init(&hdev->hdev_unregister_lock);
 
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
@@ -692,14 +693,19 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	struct hci_cmd_sync_work_entry *entry;
+	int err = 0;
 
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		return -ENODEV;
+	mutex_lock(&hdev->hdev_unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		err = -ENODEV;
+		goto unlock;
+	}
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
+	if (!entry) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 	entry->func = func;
 	entry->data = data;
 	entry->destroy = destroy;
@@ -710,7 +716,9 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 
 	queue_work(hdev->req_workqueue, &hdev->cmd_sync_work);
 
-	return 0;
+unlock:
+	mutex_unlock(&hdev->hdev_unregister_lock);
+	return err;
 }
 EXPORT_SYMBOL(hci_cmd_sync_submit);
 
-- 
2.40.1.698.g37aff9b760-goog

