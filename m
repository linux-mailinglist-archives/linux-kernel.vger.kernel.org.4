Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3A76885B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjBBRrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjBBRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:47:07 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6346AA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:47:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5028c723d28so27076147b3.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YtU9CnX3cBpyenF2XQ9oEZnYd7Lwckg3sr9WC007xnQ=;
        b=AuQ1JoDOl140cHDdE+mSysSLsYrmA6SHdMNLIy6+bukO+9pa133u4WE9RaE6dZo+IH
         NAHnD6OKqnddDShq7snW9N5JW+UhY8flJJlwPoDvHCyAwohRZPLVITM5GMrGlScLMVvj
         E1IqFR3BGmI1FpBBTcORh1WiRYesGfsXfI1TjAqMuprXlhuuypMG+jDxMQwLa4T6sWHL
         D7svt0DE69yjHehpCufriBMDu5td4/of0IN637OTfFSAqDgeWAWb6by2ve586WvrzAdU
         9awYYGTlR+2NsJkO3KahX27ffLLefnnhJCAPq0k05eSKmMphdBuXn6F5O/thap/lVTHg
         blbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtU9CnX3cBpyenF2XQ9oEZnYd7Lwckg3sr9WC007xnQ=;
        b=rBVoytxU+YG49UN38FnBonbGYHjaPEN2Uih7fW8qezYCjhl8GW9uB6IsuRM9D6VTKi
         SJfryT+0M21UYeflxXsToRnELERUEthKGIxI36FLE2BC7NA2ClbQP5tBkF3rn9q0cMD8
         R5eBGv2A6gRKu34SlPvo7E9TIA7DXHb/sQqpDz0GuqGFkqvjPm9miBxQz9Sk6u3aw5FH
         RGTFf9fy2uOXL3BmXndIN6G5wFn0QFl9PqhvA+7PWDVaPE3rsn0YbH1dDrZYryCyCcDo
         0qNdJgQDD7oKC32jrkcsLmnknj5m9M4Ym66maLrHiDtSm9oFHJoDw1Kt6v+DHETiqtb1
         U2ng==
X-Gm-Message-State: AO0yUKVZl58P3MpXAkm8fzoRvi70eez4li+Z4XuRUd4ys0d1LBiYRY/X
        bPWrVFR9wnz1iJXPG1KGBwzS+Ej6b5W+
X-Google-Smtp-Source: AK7set/pUtumSbmYthYO0RyWEklWO3fDPp1Ppdq+qBMUaWpNx51lrqWOcR0a5KfhivtIjbFwM0b6yUCcg5la
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a0d:cc84:0:b0:507:3872:5210 with SMTP id
 o126-20020a0dcc84000000b0050738725210mr761280ywd.152.1675360024329; Thu, 02
 Feb 2023 09:47:04 -0800 (PST)
Date:   Thu,  2 Feb 2023 09:47:01 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202094659.kernel.v1.1.I7d79501f333609addbb0b39803a7bafb99e5b728@changeid>
Subject: [kernel PATCH v1] Bluetooth: hci_qca: get wakeup status from serdev
 device handle
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
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

Bluetooth controller attached via the UART is handled by the serdev driver.
Get the wakeup status from the device handle through serdev, instead of the
parent path.

Fixes: c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Get wakeup status from device handle of serdev driver

 drivers/bluetooth/hci_qca.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a5c19f32926b..3df8c3606e93 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1588,10 +1588,11 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	bool wakeup;
 
-	/* UART driver handles the interrupt from BT SoC.So we need to use
-	 * device handle of UART driver to get the status of device may wakeup.
+	/* BT SoC attached through the serial bus is handled by the serdev driver.
+	 * So we need to use the device handle of the serdev driver to get the
+	 * status of device may wakeup.
 	 */
-	wakeup = device_may_wakeup(hu->serdev->ctrl->dev.parent);
+	wakeup = device_may_wakeup(&hu->serdev->ctrl->dev);
 	bt_dev_dbg(hu->hdev, "wakeup status : %d", wakeup);
 
 	return wakeup;
-- 
2.39.1.519.gcb327c4b5f-goog

