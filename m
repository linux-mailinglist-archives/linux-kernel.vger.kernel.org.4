Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC9635331
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiKWItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiKWItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:49:05 -0500
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38DE9E914E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:49:03 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-05 (Coremail) with SMTP id zQCowADX3_Nv3n1jNvg4AQ--.25384S2;
        Wed, 23 Nov 2022 16:48:48 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     almaz.alexandrovich@paragon-software.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] fs/ntfs3: Add check for kmemdup
Date:   Wed, 23 Nov 2022 16:48:46 +0800
Message-Id: <20221123084846.2703-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADX3_Nv3n1jNvg4AQ--.25384S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF48Gw15trWDJFW8CryDKFg_yoWxKFb_tF
        ZrC3WrWw47Jr1vka4Dt3yrtws3Wws3Arn3WFWxKFy3GrZ8Ga1YyryvqrZ8Jw4xW34FgFs5
        C3s0kF98Zr1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5sjjDUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the kmemdup may return NULL pointer,
it should be better to add check for the return value
in order to avoid NULL pointer dereference.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 fs/ntfs3/fslog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 0d611a6c5511..eb7cf8a69607 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4277,6 +4277,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	rec_len -= t32;
 
 	attr_names = kmemdup(Add2Ptr(lrh, t32), rec_len, GFP_NOFS);
+	if (!attr_names) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	lcb_put(lcb);
 	lcb = NULL;
-- 
2.25.1

