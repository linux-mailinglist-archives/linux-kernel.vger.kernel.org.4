Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFFF5E552F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiIUV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiIUV2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:28:07 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192FA5C7D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:28:06 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x13-20020a170902ec8d00b00177f0fa642cso4608207plg.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=Rj57beHCIEQ+ldfbuTVP/EURNkRb2EXXRe6WPMDPyCc=;
        b=GYVh1Hv2Gcij7haZHYTZEMfH/lnByf/3y5MSsbXvhHiBfK+A+BYPENJDuzsSzoR7NW
         Iy9Tz1XcjiMkpveXZpqcgEfFCrMGSEqgpO+hWaUIjqkuxF0QT36fZtYb7UFmM+iW0eGh
         meDKyvNcKVG4/6WdDGEzHaD6LlsfLTJQPp/Ij6mzKeCo3bovst4NjEOSjKzsUzmnrvAy
         xh/xKWaS0ZGrxoHVqWbwAZc26NlkKS2n96WMBCwuENEbgWcAVTCQqwNbpY5RwVDnH8mf
         +APEBFXVKaU7t0YLDp3Bq6aV8wOHoyd1vuRX9liZHfCY7CuMAv4wXqWZfc62vYBLw4KU
         +SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Rj57beHCIEQ+ldfbuTVP/EURNkRb2EXXRe6WPMDPyCc=;
        b=cg9yrgjMIrzjywaW3F4q0oR99h32g+eEhdMKs8pqkoGkD+L1Ez86KCVdUOZzCjZ4LM
         DY5ifWA5PNBIIHKQ2blxpHK09aZZp1WfPVdmHxHIoX7dahsahfmhKypv9Qq37p0taHUt
         B4cKDcY+0r/GxW3LZk0K8JYQHVeY6qyF1HI7HPY0O4NQ7Uh8G0iFKHO//TkxsCJNs81C
         NpzZ5zwrYsufaBlAqRey65lR1eeGws9ehhKdW57G3UvGM4UlpN7GyKemznp1eT/+Zr5I
         ReUSqs6FZIn7PIGQ7pvWK1NMvhaXweWfMQogDlldY8GG3YqfC7WdfZy3n5iGF0HuZCE2
         mO5A==
X-Gm-Message-State: ACrzQf0fBRxaqQ23BDcCvClM8ouJbOE5i5bTgBaYMkg/7wlQpKS6fJ4S
        9h5f2MD5X54nWwbaEFVz1FocACXp98ZRGyZ8jcM=
X-Google-Smtp-Source: AMsMyM5mAkA1kCKFW+/25JHt+67NH6269Gra3l4xUtoGcl1oXEHtJf1kgg3hlPjQjU1VBuulUjPXtNOUjkRczoTgxWE=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a05:6a00:1342:b0:545:4d30:eecb with
 SMTP id k2-20020a056a00134200b005454d30eecbmr164457pfu.69.1663795685856; Wed,
 21 Sep 2022 14:28:05 -0700 (PDT)
Date:   Wed, 21 Sep 2022 21:27:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921212735.2131588-1-willmcvicker@google.com>
Subject: [PATCH v4] PCI/PM: Switch D3hot delay to use usleep_range()
From:   Will McVicker <willmcvicker@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel-team@android.com, Sajid Dalvi <sdalvi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Will McVicker <willmcvicker@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sajid Dalvi <sdalvi@google.com>

The PCIe r6.0, sec 5.9 spec requires a 10ms D3hot delay (defined by
PCI_PM_D3HOT_WAIT) for transitions to or from D3hot. So let's switch to
usleep_range() for the delay time to improve the delay accuracy.

This patch is based off of a commit from Sajid Dalvi <sdalvi@google.com>
in the Pixel 6 kernel tree [1]. Testing on a Pixel 6, found that the
10ms delay for the Exynos PCIe device was on average delaying for 19ms
when the spec requires 10ms. Switching from msleep() to usleep_range()
therefore decreases the resume time on a Pixel 6 on average by 9ms.

Note: some ancient Intel chips do have a quirk that sets the delay to
120ms. Using usleep_delay() may add a few extra milliseconds for those
chips.

[1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/pci/pci.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

v4:
 * Drop use of msleep() in favor of always using usleep_range().
 * Update the commit message.

v3:
 * Use DIV_ROUND_CLOSEST instead of bit manipulation.
 * Minor refactor to use max() where relavant.

v2:
 * Update to use 20-25% upper bound
 * Update to use usleep_range() for <=20ms, else use msleep()

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 516bf0c2ca02..2127aba3550b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -66,13 +66,15 @@ struct pci_pme_device {
 
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
-	unsigned int delay = dev->d3hot_delay;
-
-	if (delay < pci_pm_d3hot_delay)
-		delay = pci_pm_d3hot_delay;
-
-	if (delay)
-		msleep(delay);
+	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
+	unsigned int upper;
+
+	if (delay_ms) {
+		/* Use a 20% upper bound, 1ms minimum */
+		upper = max(DIV_ROUND_CLOSEST(delay_ms, 5), 1U);
+		usleep_range(delay_ms * USEC_PER_MSEC,
+			     (delay_ms + upper) * USEC_PER_MSEC);
+	}
 }
 
 bool pci_reset_supported(struct pci_dev *dev)

base-commit: fcf773ae8016c6bffe5d408d3eda50d981b946e6
-- 
2.37.3.968.ga6b4b080e4-goog

