Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E8658BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiL2K3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiL2K2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:28:39 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59E61EE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:28:37 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id e13so16432607ljn.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTij5lXnahNVnZelM9IFWy8LRMTXDX20UWVAv2jM92s=;
        b=aOyIJd5P9eX5swjwULosY3OgLA4/BTPCObCz76Xo9ft+wLJ1VspYKdA7s/qvxMF0ne
         CYVjdU8JSUsK5dsJVZJaeiLE7JHITgQY4Os9x4Lz7RLp272ZFJmoYQ/r5RHdxupKHWji
         TslHvBAMc1AaiQeTstPpiEbZOCHJaTj0VgNHNsnT2Kd9cq2RxxLBND7y12Okxswhoa3Z
         GO6lR3xLwlVWSzW/g5Y33cSRMXtlsR6h4jEyp7b0jSeFqj4a75CZrgDgdvrhnM8um7/f
         /VlSTeInKC+J1X0yJCNDnKOEG0tnvbfDb+A2xkf6SHRL8fbYW4vkJ7AsloYtGlGEvS5z
         biXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTij5lXnahNVnZelM9IFWy8LRMTXDX20UWVAv2jM92s=;
        b=qgrfY7Sv0RvliNzHd6RcJdUPF40gE8lZURM6eejhTO4Fm1fVu5pjOz7KaCuKxJVzi+
         3PYfcsncJzSv/ym57o36ppBIQ0HWYRSfO7daQ5JCkvlb+zscOZWrg8kJHyvVl85niJP0
         y6Zi7Q1q6HWAyNsIf6IqUb/jpBtTsP3RsKsUhSCCfAuZpwNxAUnOX0DPr34wcmLKwfM3
         NHOdmeK2LHBXGkKKu+Q5zgplxjlXn36pAt8aTa6sfCbhMkHlGeWD+zYfqQ6VQqibYIFy
         7s7nBLaXF84bOH/l1M8851FyIx7OR7APC6sslOhI8wfjrtmdkUtfW8sPa/WI+R7Uamyk
         nieA==
X-Gm-Message-State: AFqh2kpWwRoCupO/Hl8nof4undcSjhIdj3+CiYTloBOAbLUZdh8BBaM+
        U7+eH9VMxuVjfLM9X8FU152Jiw==
X-Google-Smtp-Source: AMrXdXtuqSCzj5t/76hqWuJ8YtdcnvJxyoU7SvtsoTpceWh72rF+i76AJ/OwhAzsrAOPFlzremP46w==
X-Received: by 2002:a2e:a481:0:b0:277:913:aed0 with SMTP id h1-20020a2ea481000000b002770913aed0mr7327380lji.4.1672309716014;
        Thu, 29 Dec 2022 02:28:36 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r22-20020a2eb616000000b0027fbfaa26dbsm1291311ljn.14.2022.12.29.02.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:28:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zijun Hu <zijuhu@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_qca: Fix driver shutdown on closed serdev
Date:   Thu, 29 Dec 2022 11:28:29 +0100
Message-Id: <20221229102829.403917-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver shutdown callback (which sends EDL_SOC_RESET to the device
over serdev) should not be invoked when HCI device is not open (e.g. if
hci_dev_open_sync() failed), because the serdev and its TTY are not open
either.  Also skip this step if device is powered off
(qca_power_shutdown()).

The shutdown callback causes use-after-free during system reboot with
Qualcomm Atheros Bluetooth:

  Unable to handle kernel paging request at virtual address 0072662f67726fd7
  ...
  CPU: 6 PID: 1 Comm: systemd-shutdow Tainted: G        W          6.1.0-rt5-00325-g8a5f56bcfcca #8
  Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
  Call trace:
   tty_driver_flush_buffer+0x4/0x30
   serdev_device_write_flush+0x24/0x34
   qca_serdev_shutdown+0x80/0x130 [hci_uart]
   device_shutdown+0x15c/0x260
   kernel_restart+0x48/0xac

KASAN report:

  BUG: KASAN: use-after-free in tty_driver_flush_buffer+0x1c/0x50
  Read of size 8 at addr ffff16270c2e0018 by task systemd-shutdow/1

  CPU: 7 PID: 1 Comm: systemd-shutdow Not tainted 6.1.0-next-20221220-00014-gb85aaf97fb01-dirty #28
  Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
  Call trace:
   dump_backtrace.part.0+0xdc/0xf0
   show_stack+0x18/0x30
   dump_stack_lvl+0x68/0x84
   print_report+0x188/0x488
   kasan_report+0xa4/0xf0
   __asan_load8+0x80/0xac
   tty_driver_flush_buffer+0x1c/0x50
   ttyport_write_flush+0x34/0x44
   serdev_device_write_flush+0x48/0x60
   qca_serdev_shutdown+0x124/0x274
   device_shutdown+0x1e8/0x350
   kernel_restart+0x48/0xb0
   __do_sys_reboot+0x244/0x2d0
   __arm64_sys_reboot+0x54/0x70
   invoke_syscall+0x60/0x190
   el0_svc_common.constprop.0+0x7c/0x160
   do_el0_svc+0x44/0xf0
   el0_svc+0x2c/0x6c
   el0t_64_sync_handler+0xbc/0x140
   el0t_64_sync+0x190/0x194

Fixes: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure after warm reboot")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Drop serdev patch and fix it only on BT side.
2. Update commit msg.
---
 drivers/bluetooth/hci_qca.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index bb7623fe53a8..157fc4d024c1 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2166,10 +2166,16 @@ static void qca_serdev_shutdown(struct device *dev)
 	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
 	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
+	struct hci_uart *hu = &qcadev->serdev_hu;
+	struct hci_dev *hdev = hu->hdev;
+	struct qca_data *qca = hu->priv;
 	const u8 ibs_wake_cmd[] = { 0xFD };
 	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
 
 	if (qcadev->btsoc_type == QCA_QCA6390) {
+		if (test_bit(QCA_BT_OFF, &qca->flags) || !test_bit(HCI_RUNNING, &hdev->flags))
+			return;
+
 		serdev_device_write_flush(serdev);
 		ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
 					      sizeof(ibs_wake_cmd));
-- 
2.34.1

