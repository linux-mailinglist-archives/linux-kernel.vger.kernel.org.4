Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5725373040E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbjFNPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjFNPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:43:35 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 510041FF9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=GO8rfML0jUHU67vdinHhiKtJMBNZI92wuILfIrohgyU=; b=W
        dm0lY6FLG6d/JdSHY5VF0498NhNAWX7lH0QezTl6QxxyE7hAx7DlIbR0+XeXLhqe
        /cjV4KAj96GY/9DEMsTrPFHQX5hOpGd3d6ZZByWWRrdZMBPmC2fVOaQOojbfRbD3
        jdpEzKuZGuEDqhQ+WQvbAdtm/R4M+i2s9j/8ml1x0Q=
Received: from ubuntu.localdomain (unknown [10.230.35.76])
        by app1 (Coremail) with SMTP id XAUFCgAnLfUO4Ilkj4DsAA--.39227S2;
        Wed, 14 Jun 2023 23:43:10 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
To:     joro@8bytes.org
Cc:     will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Chenyuan Mi <cymi20@fudan.edu.cn>
Subject: [PATCH] iommu: Fix missing check for return value of iommu_group_get()
Date:   Wed, 14 Jun 2023 08:43:08 -0700
Message-Id: <20230614154308.118783-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgAnLfUO4Ilkj4DsAA--.39227S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1DCryrGr1ktF1fuw4UJwb_yoWkXFc_G3
        Z7ZryUXrWrCr40kF1jvrnxZrZxK3909rn3tFWq9wn3JF1qgrn0y3WrZFZ7JrW3Cw47KFnF
        kFy7J3W3JFy7AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUeEfoUUUUU
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu_group_get() function may return NULL, which may
cause null pointer deference, and most other callsites of
iommu_group_get() do Null check. Add Null check for return
value of iommu_group_get().

Found by our static analysis tool.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..ef3483e75511 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3217,6 +3217,8 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
 void iommu_device_release_dma_owner(struct device *dev)
 {
 	struct iommu_group *group = iommu_group_get(dev);
+	if (!group)
+		return;
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt > 1)
@@ -3329,6 +3331,8 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 			       ioasid_t pasid)
 {
 	struct iommu_group *group = iommu_group_get(dev);
+	if (!group)
+		return;
 
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid);
-- 
2.17.1

