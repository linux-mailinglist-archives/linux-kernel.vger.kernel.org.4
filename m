Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93E72F9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjFNKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjFNKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:00:29 -0400
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C1AC;
        Wed, 14 Jun 2023 03:00:27 -0700 (PDT)
Received: from ed3e173716be.home.arpa (unknown [124.16.138.125])
        by APP-05 (Coremail) with SMTP id zQCowAAnLj61j4lkcbtFAg--.10545S2;
        Wed, 14 Jun 2023 18:00:21 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] pstore/platform: Add check for kstrdup
Date:   Wed, 14 Jun 2023 18:00:20 +0800
Message-Id: <20230614100020.39020-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnLj61j4lkcbtFAg--.10545S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur45XrW5tF1Duw1UJFWDJwb_yoW3trg_G3
        s7Ga4UWrW8trnYyr1qyr13C3s3A395GrW2qr4qkFs0y3yrG3W3Xryqvr93urWUXFyjyF1D
        u397Kry3Z343GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0NtxUUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for the return value of kstrdup() and return the error
if it fails in order to avoid NULL pointer dereference.

Fixes: 563ca40ddf40 ("pstore/platform: Switch pstore_info::name to const")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 fs/pstore/platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cbc0b468c1ab..afe07f0d1216 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -631,6 +631,10 @@ int pstore_register(struct pstore_info *psi)
 	 * through /sys/module/pstore/parameters/backend
 	 */
 	backend = kstrdup(psi->name, GFP_KERNEL);
+	if (!backend) {
+		mutex_unlock(&psinfo_lock);
+		return -ENOMEM;
+	}
 
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
-- 
2.25.1

