Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E95E7349
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiIWFMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIWFMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:12:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0AEF370C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:12:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34d8987860fso31666867b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=yXjveCbLOdd0JzGR4qE7Eak16YrtEn9JU/5KgKpycQ4=;
        b=bsyGrP9RDOEf3/jOXC2B30WnREaFxo8TgD8RiysbiY21Zx4pM97GzW8B9LBoLLc3MT
         WkReA5dbfuobZIt2ERF02TM9S2JjuICdzby+kv46P6Re7jKNmbjQjQVklQ3Vs8OlUfOZ
         wJN4tRh9fAuRuf33bwPhhMn+6rgGI9EI6FOOYz/EmATwev07fw0A16LZnyPakmfn9TNF
         3CVnMrq5bYOhYqYV5N72W2AXxMnyUmF8FOAzp2uhN8VtEHlSDFd98AoivDkIWogu9f0I
         DcZoU/HLkTtJIJiNMw8F09gtli9dXgRK7VHcLOHt5pf0OP/o2cIE7+T42K59/rJ9lMrE
         FpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=yXjveCbLOdd0JzGR4qE7Eak16YrtEn9JU/5KgKpycQ4=;
        b=XWpsr2kyqJfldmeBVcuV+eigIm7ATA5lyacYMnuDmtOhXd+jhPzvLtgBQD9PxW3DLQ
         1u3ZXiAD2m1VSm2Krlq0tkpz/gLKZM9RHBxKFY1kqtENfEuWwZwLjzjlf+cuhqm/qHSB
         1Wo2UW3mnscT3dqw25Ushn2jJQS9z2gM2c7EVLrF3oWugNBOdqtwajhkzFO1KEaQPUlG
         rsJc8lVZ4q5f7VM2OcD02/7sQK35+Kn6hTSRDR17eZ8wU3E9j8rgtl8Bv58o68d1KGG1
         DxFosEmliNjhBzM/XCCSOzmVB9SxaUu6uWEdeP6rl9p5RgmFo4Sjlt9Hz3TiUjRf4Gzi
         SFag==
X-Gm-Message-State: ACrzQf0CkVg7v0lR3Wy/sWzUL7SXjT7hR9BuloONOU3jQhEBhPaMqdJr
        99Iaj00F8+2e8k2DGrAXVGlUlQnYFbRU9A==
X-Google-Smtp-Source: AMsMyM41fR83KD/FqMiNwNghkRfeT+azMYRzEeG2UAk9jdOfX/1Xz19S+AJ8YYD/cOCtqty+IlpSEopBrQrrDg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:5808:dcfb:1968:5125])
 (user=mmandlik job=sendgmr) by 2002:a25:320d:0:b0:6b0:29ba:fc57 with SMTP id
 y13-20020a25320d000000b006b029bafc57mr7625919yby.77.1663909933413; Thu, 22
 Sep 2022 22:12:13 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:12:04 -0700
In-Reply-To: <20220922221037.v6.1.I44a65858f594107d3688087dfbdf669fac450b52@changeid>
Mime-Version: 1.0
References: <20220922221037.v6.1.I44a65858f594107d3688087dfbdf669fac450b52@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922221037.v6.2.Id7ed3b8351837e45025add1d496630f0b9b460cb@changeid>
Subject: [PATCH v6 2/3] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the btusb driver side .coredump() callback to
trigger a devcoredump via sysfs.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v6:
- Remove dev->coredump_disabled check since the sysfs flag related
  change has been abandoned

Changes in v4:
- New patch in the series

 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..e9052779f4f8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4205,6 +4205,17 @@ static int btusb_resume(struct usb_interface *intf)
 }
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void btusb_coredump(struct device *dev)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	struct hci_dev *hdev = data->hdev;
+
+	if (hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
@@ -4216,6 +4227,14 @@ static struct usb_driver btusb_driver = {
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
+
+#ifdef CONFIG_DEV_COREDUMP
+	.drvwrap = {
+		.driver = {
+			.coredump = btusb_coredump,
+		},
+	},
+#endif
 };
 
 module_usb_driver(btusb_driver);
-- 
2.37.3.998.g577e59143f-goog

