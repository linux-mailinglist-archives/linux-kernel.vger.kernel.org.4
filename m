Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6FD745245
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGBU1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGBU1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC11E6C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688329568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RAuoFBXJGbrEK7r6lFPsWq6Du417iZcQuP9Eu+SLXPs=;
        b=i5fSoVu+JxqByZczP9BaA4ZzoS0GqFf+8xE8AawGSmRBduJMlCjrmAp5oE6/cUuhlsAojk
        m0GV/9c20cisBi0W9YZdBt+HQi1Kg4mIFXvi3BQahLrczryA9EAg5eiM83pdqvbOdHk9tR
        yoMAmaxJY5rZoZEq11IODMgfKsFmeGU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-GxYXjdKhP1GKRvyq0MRVWg-1; Sun, 02 Jul 2023 16:26:07 -0400
X-MC-Unique: GxYXjdKhP1GKRvyq0MRVWg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635f63d0c1aso25925696d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 13:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688329566; x=1690921566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAuoFBXJGbrEK7r6lFPsWq6Du417iZcQuP9Eu+SLXPs=;
        b=XXGVJonOeRmmdYz94hslAckgG8T3hU5wMjcbjmxQ/MoIc/Y+225CO23gW3ACe5AsbI
         mO86F4PkE8NCn08JEUQEOTdsgk1UD/qTDYtJwmzqWNgYJH2WUNNckLYtsrAT6UpjR6TL
         GU1mPfxE27nJ4vfefZhYlgLbaH+g+LWLdPX6E332UfsaJmMJjUhvwow5HYYzmSII3sDh
         FZ4UOZ/gnum3LewN8k31Yk/fVPSWNmvhCQNC/15552RRr7x+GKJZ0cGi0vaxJJJ6YXFm
         o6eHnlG4xIaHOB+SzDd74G2eKp1lRailic3kK2iMxM1XH32SGkchHnRihomW/rx8vyC9
         kNZA==
X-Gm-Message-State: ABy/qLbDwoOAIYp3MSHDYJ7pw73gpj08OQG0vqSHQ0l7T27cRU/0QrOv
        38kbDdGlSUM1vYVnZIJGxVG7Z7Mj2uQX2WbI+VFTwx80XE1/TaPpWtlPPv/Fgmj40qxjqOlm7ar
        onnTihPo1vErUr01lpoMv/AzvMEePIA18
X-Received: by 2002:ad4:5fcd:0:b0:635:a1f5:5458 with SMTP id jq13-20020ad45fcd000000b00635a1f55458mr10055506qvb.12.1688329566473;
        Sun, 02 Jul 2023 13:26:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHAdOVmOK/0+cxD45eADjdrnL8vXwAqDR93DNfpbltexe47gg5n3KhEGJTHpGhBn8F7/mMyLw==
X-Received: by 2002:ad4:5fcd:0:b0:635:a1f5:5458 with SMTP id jq13-20020ad45fcd000000b00635a1f55458mr10055495qvb.12.1688329566186;
        Sun, 02 Jul 2023 13:26:06 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g10-20020ad4510a000000b0063623c266easm4430335qvp.3.2023.07.02.13.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:26:05 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        jing.cai@mediatek.com, sean.wang@mediatek.com,
        chris.lu@mediatek.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] Bluetooth: btmtk: fix handling of CONFIG_DEV_COREDUMP not being defined
Date:   Sun,  2 Jul 2023 16:26:03 -0400
Message-Id: <20230702202603.3442724-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEV_COREDUMP is not defined, there is this error
drivers/bluetooth/btmtk.c: In function ‘btmtk_process_coredump’:
drivers/bluetooth/btmtk.c:386:44: error: ‘struct hci_dev’ has no member named ‘dump’
  386 |                 schedule_delayed_work(&hdev->dump.dump_timeout,
      |                                            ^~

The runtime IS_ENABLED(CONFIG_DEV_COREDUMP) is not enough to
prevent the compiletime error of accessing the dump element of hci_dev.
So switch to #ifdef.

Fixes: 872f8c253cb9 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bluetooth/btmtk.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 786f775196ae..12769e95bf55 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -369,11 +369,9 @@ EXPORT_SYMBOL_GPL(btmtk_register_coredump);
 
 int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	int err = 0;
+#ifdef CONFIG_DEV_COREDUMP
 	struct btmediatek_data *data = hci_get_priv(hdev);
-	int err;
-
-	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
-		return 0;
 
 	switch (data->cd_info.state) {
 	case HCI_DEVCOREDUMP_IDLE:
@@ -407,7 +405,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (err < 0)
 		kfree_skb(skb);
-
+#endif
 	return err;
 }
 EXPORT_SYMBOL_GPL(btmtk_process_coredump);
-- 
2.27.0

