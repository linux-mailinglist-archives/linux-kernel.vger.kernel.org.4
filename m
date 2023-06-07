Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73067726137
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbjFGN0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjFGN0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:26:20 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB381AC;
        Wed,  7 Jun 2023 06:26:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbnsK34lVz9xGgS;
        Wed,  7 Jun 2023 21:15:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCH9O9thYBk6e8aAw--.4240S2;
        Wed, 07 Jun 2023 14:26:09 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Subject: [PATCH] memfd: Check for non-NULL file_seals in memfd_create() syscall
Date:   Wed,  7 Jun 2023 15:24:27 +0200
Message-Id: <20230607132427.2867435-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCH9O9thYBk6e8aAw--.4240S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF15tFW7JFW7uF4UWFykXwb_yoWkAwbEg3
        y0qryrJr1DWw47CF4xAr13Zry8KFWDJrnxZF95tF4xAa98Ga1kWrZ3ur1fX348Gw4I9r1r
        tFZrZF17Ar97GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jx3ktUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj45W0QAAs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Ensure that file_seals is non-NULL before using it in the memfd_create()
syscall. One situation in which memfd_file_seals_ptr() could return a NULL
pointer is when CONFIG_SHMEM=n.

Cc: stable@vger.kernel.org # 4.16.x
Fixes: 47b9012ecdc7 ("shmem: add sealing support to hugetlb-backed memfd")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 mm/memfd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 69b90c31d38..e763e76f110 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -371,12 +371,15 @@ SYSCALL_DEFINE2(memfd_create,
 
 		inode->i_mode &= ~0111;
 		file_seals = memfd_file_seals_ptr(file);
-		*file_seals &= ~F_SEAL_SEAL;
-		*file_seals |= F_SEAL_EXEC;
+		if (file_seals) {
+			*file_seals &= ~F_SEAL_SEAL;
+			*file_seals |= F_SEAL_EXEC;
+		}
 	} else if (flags & MFD_ALLOW_SEALING) {
 		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
 		file_seals = memfd_file_seals_ptr(file);
-		*file_seals &= ~F_SEAL_SEAL;
+		if (file_seals)
+			*file_seals &= ~F_SEAL_SEAL;
 	}
 
 	fd_install(fd, file);
-- 
2.25.1

