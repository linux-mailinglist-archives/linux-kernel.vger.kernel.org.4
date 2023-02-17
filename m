Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44E169A596
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBQG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:26:37 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E745A3A1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 22:26:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbrJQtt_1676615188;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VbrJQtt_1676615188)
          by smtp.aliyun-inc.com;
          Fri, 17 Feb 2023 14:26:34 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ogabbay@kernel.org
Cc:     osharabi@habana.ai, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] habanalabs: make some functions static
Date:   Fri, 17 Feb 2023 14:26:26 +0800
Message-Id: <20230217062626.63213-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not used outside the file device.c, so the
modification is defined as static.

drivers/accel/habanalabs/common/device.c:2641:6: warning: no previous prototype for ‘hl_capture_fw_err’.
drivers/accel/habanalabs/common/device.c:2619:6: warning: no previous prototype for ‘hl_capture_hw_err’.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4098
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/accel/habanalabs/common/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index fefe70bbbede..a5f5ee102823 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2616,7 +2616,7 @@ void hl_handle_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_
 		*event_mask |=  HL_NOTIFIER_EVENT_PAGE_FAULT;
 }
 
-void hl_capture_hw_err(struct hl_device *hdev, u16 event_id)
+static void hl_capture_hw_err(struct hl_device *hdev, u16 event_id)
 {
 	struct hw_err_info *info = &hdev->captured_err_info.hw_err;
 
@@ -2638,7 +2638,7 @@ void hl_handle_critical_hw_err(struct hl_device *hdev, u16 event_id, u64 *event_
 		*event_mask |= HL_NOTIFIER_EVENT_CRITICL_HW_ERR;
 }
 
-void hl_capture_fw_err(struct hl_device *hdev, struct hl_info_fw_err_info *fw_info)
+static void hl_capture_fw_err(struct hl_device *hdev, struct hl_info_fw_err_info *fw_info)
 {
 	struct fw_err_info *info = &hdev->captured_err_info.fw_err;
 
-- 
2.20.1.7.g153144c

