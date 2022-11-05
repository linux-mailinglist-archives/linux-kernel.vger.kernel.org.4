Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A5961DD93
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKETFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKETFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9F79FC2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667675096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fMzdSVUxKzfJHte4Vux2hVjWJ41SsNMVC7KP71E/b/A=;
        b=Bsp4D4uY4xKa+28fS1YcocwuX1C0agJ8JSBM7TmWF1oC/kD/KsK7Pk+iXyvfARg7EJ9IsK
        Oey28NYVV/ueCjmUtc270buPXBYjwOA0rKUEy3PYwCcvq/8M+r/JUo58HVAyFg72G3nPZ9
        0F6TQXoWIZjVc4xUn6qjKJchhgKaqNU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-388-wfXgdLLBNx2E3rJ4GMBbGQ-1; Sat, 05 Nov 2022 15:04:55 -0400
X-MC-Unique: wfXgdLLBNx2E3rJ4GMBbGQ-1
Received: by mail-pl1-f199.google.com with SMTP id n12-20020a170902e54c00b00188515e81a6so5945037plf.23
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 12:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMzdSVUxKzfJHte4Vux2hVjWJ41SsNMVC7KP71E/b/A=;
        b=x+rcMwDOMx9G6Wrcyq5dlnpkbcEO/gk10xMigW3N+rQINLa4vy9i93rb77jyFScJws
         p9wQg0aeKJ/zJuT2jhHB0CStSLGhz3wTxOkIzWsPfi3YCoDzAxHtV2auCA03yxUBPNkp
         mbO7gR0MHmTM6Y26vKNoZQmaqHYj4+xfbxYQ241MW4KRNpGfTORlNh/9UkIrOCiEWKlo
         5iegVUmVAeXR+g6sMecxcJwUQMqdaLes9HEXT5cVmZHQptk5pS4RJtswuzhObAkJm4n+
         6NopAHOhvH+zjAnxn8ocQY2gZI20Az4/OfRf8w2MUYYMxcyAak1f1pi/wcc8DrxS1yRr
         IORw==
X-Gm-Message-State: ACrzQf0Z+OkyONz5i31n2tscWHHsrvwrIock8VtIE+UKEXHrmJmaDdsL
        GQ4zNiMUzlpR9l7EGrspMJhEQd9ZxLVTwcM3CMApQXzEnJ8/FdWBb/fC6o1kGTY2uAjF9UPEwik
        JZPtHRMU84X70zkBsJZiFoxZp
X-Received: by 2002:a05:6a00:a8c:b0:558:991a:6691 with SMTP id b12-20020a056a000a8c00b00558991a6691mr42009594pfl.53.1667675093780;
        Sat, 05 Nov 2022 12:04:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5D2hSXvk8kyWEGa1X5jowmFyC1fJpWFKAKj5E4KNYRak6FWEYFFNtXoe78WT4AeqLosIE1tA==
X-Received: by 2002:a05:6a00:a8c:b0:558:991a:6691 with SMTP id b12-20020a056a000a8c00b00558991a6691mr42009574pfl.53.1667675093464;
        Sat, 05 Nov 2022 12:04:53 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:fc9c:8ee9:e32c:2d9])
        by smtp.gmail.com with ESMTPSA id jd10-20020a170903260a00b00185507b5ef8sm2009003plb.50.2022.11.05.12.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 12:04:53 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: Fix use-after-free read in hci_cmd_timeout()
Date:   Sun,  6 Nov 2022 04:04:46 +0900
Message-Id: <20221105190446.1324053-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported use-after-free in hci_cmd_timeout() [1].  The scenario
for the issue is as follows:

Task                                    Workqueue
----------------------------------------------------------------------
hci_dev_open_sync
  ...
  hci_dev_init_sync  <- failed
  ...
  if (hdev->sent_cmd)
    kfree_skb(hdev->sent_cmd)
                                        hci_cmd_timeout
                                          ...
                                          if (hdev->sent_cmd)
                                            sent = hdev->sent_cmd->data
                                                   ^^ UAF occurred
    hdev->sent_cmd = NULL

When hci_dev_init_sync() failed, hci_dev_open_sync() frees
hdev->send_cmd and set it to NULL.  However, hci_cmd_timeout() can run
just after freeing hdev->sent_cmd because hdev->cmd_timer is not
canceled.

This patch fixes the issue by canceling hdev->cmd_timer before freeing
hdev->sent_cmd.

Link: https://syzkaller.appspot.com/bug?id=cb23ebfc8f304f510fb717cb783fe8b496c7ffb1 [1]
Reported-by: syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76c3107c9f91..a011065220e4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4696,6 +4696,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 			hdev->flush(hdev);
 
 		if (hdev->sent_cmd) {
+			cancel_delayed_work_sync(&hdev->cmd_timer);
 			kfree_skb(hdev->sent_cmd);
 			hdev->sent_cmd = NULL;
 		}
-- 
2.38.1

