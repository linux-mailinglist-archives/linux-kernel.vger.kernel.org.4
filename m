Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA3748F87
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjGEVIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEVIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:08:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D129C1700
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:08:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686c74183cso92360b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688591286; x=1691183286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmj/KUtCtgJQVjZIE+0mLvUSZaWRXEiyQldCxLAvqj8=;
        b=gRPWZ2BWJvbUXs3pMf0J4YjWzBJUwnYJQ1VdzD43dITmA6klOnCedfdoFSq171iZOl
         Y+81KpQb2qtZi0VDAsFIXZxC8J6kieLofCsSM59CnX4Ktj4kbUmMpLIJ+I0ipjzh3aaL
         FBQI5/XYwVE/a52jk7FA2fcK4Rn2oFPGRryGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688591286; x=1691183286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmj/KUtCtgJQVjZIE+0mLvUSZaWRXEiyQldCxLAvqj8=;
        b=WgLhLyt2asuceUIeFhy4Ld6mKZff7lKJY1xWf+Q5mKqJ0PRmsQG/j09xm60/S+Xtmh
         b2Pj4lYAYD4i6EEM1w/+Pg6VRHF5kjTjZ8q39qJvpdDWWYjQWBmCtZl1+llanaIlq3yk
         teb0pWJxgWQQJBtiIhbL+F2ThAqkFakxSQlrJMLG9VP1x4mgcYuhD2xRgux3wt6wvlqN
         Hn/VN13xQgQpt/JQuCCvo5hor/wa1d1we+VGFRQFY9TPDo0oMh1bW+WeJtaL3M9FULaS
         1CJoZVgQEiVHI/ptJOcT/4pmB7CWUm6rr5aE3SO73/0y8hChVm68jR6DfO0aHWRG9XcD
         f5ew==
X-Gm-Message-State: ABy/qLb/67GzRBQJoHy/eAXQ5M3lQvPTuqct3FqVGPFVEBFl5Oj0qHYx
        jVMeBcwd9ToC91gqaVkS0PxXuUZ2ddgqwv1bVaE=
X-Google-Smtp-Source: APBJJlGT7hg4Vn60TFwKSuMzD0gC/nqgGjpi79zDr/r3XjKH6gdTDifNDHVYIEknLD8CLrDH2Lcy/Q==
X-Received: by 2002:a05:6a20:970a:b0:126:a80d:4960 with SMTP id hr10-20020a056a20970a00b00126a80d4960mr12881pzc.30.1688591286299;
        Wed, 05 Jul 2023 14:08:06 -0700 (PDT)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id m30-20020a637d5e000000b0054fe07d2f3dsm6229pgn.11.2023.07.05.14.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 14:08:05 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix hci_suspend_sync crash
Date:   Wed,  5 Jul 2023 21:06:47 +0000
Message-ID: <20230705210647.1.I636c21e4dc8fe3352f4d7aef26c0ec3857e24ca0@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hci_unregister_dev() frees the hci_dev object but hci_suspend_notifier
may still be accessing it, it can cause the program to crash.
Here's the call trace:
  <4>[102152.653246] Call Trace:
  <4>[102152.653254]  hci_suspend_sync+0x109/0x301 [bluetooth]
  <4>[102152.653259]  hci_suspend_dev+0x78/0xcd [bluetooth]
  <4>[102152.653263]  hci_suspend_notifier+0x42/0x7a [bluetooth]
  <4>[102152.653268]  notifier_call_chain+0x43/0x6b
  <4>[102152.653271]  __blocking_notifier_call_chain+0x48/0x69
  <4>[102152.653273]  __pm_notifier_call_chain+0x22/0x39
  <4>[102152.653276]  pm_suspend+0x287/0x57c
  <4>[102152.653278]  state_store+0xae/0xe5
  <4>[102152.653281]  kernfs_fop_write+0x109/0x173
  <4>[102152.653284]  __vfs_write+0x16f/0x1a2
  <4>[102152.653287]  ? selinux_file_permission+0xca/0x16f
  <4>[102152.653289]  ? security_file_permission+0x36/0x109
  <4>[102152.653291]  vfs_write+0x114/0x21d
  <4>[102152.653293]  __x64_sys_write+0x7b/0xdb
  <4>[102152.653296]  do_syscall_64+0x59/0x194
  <4>[102152.653299]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1

This patch holds the reference count of the hci_dev object while
processing it in hci_suspend_notifier to avoid potential crash
caused by the race condition.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested with 100 times suspend/resume on a Chromebook device.

 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b421e196f60c..bdbe26ffbd39 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2434,6 +2434,9 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 		return NOTIFY_DONE;
 
+	/* To avoid a potential race with hci_unregister_dev. */
+	hci_dev_hold(hdev);
+
 	if (action == PM_SUSPEND_PREPARE)
 		ret = hci_suspend_dev(hdev);
 	else if (action == PM_POST_SUSPEND)
@@ -2443,6 +2446,7 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 		bt_dev_err(hdev, "Suspend notifier action (%lu) failed: %d",
 			   action, ret);
 
+	hci_dev_put(hdev);
 	return NOTIFY_DONE;
 }
 
-- 
2.41.0.255.g8b1d071c50-goog

