Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65474A94D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGGDSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 23:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGGDSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 23:18:13 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB11BF3;
        Thu,  6 Jul 2023 20:18:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qxz9r0m6hz4f43Kd;
        Fri,  7 Jul 2023 11:18:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3mp7vg6dk0X+NNQ--.406S4;
        Fri, 07 Jul 2023 11:18:08 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huaweicloud.com,
        yi.zhang@huawei.com, yukuai3@huawei.com
Subject: [PATCH -next 0/3] nbd: fix null-ptr-dereference while accessing 'nbd->config'
Date:   Fri,  7 Jul 2023 11:15:33 +0800
Message-Id: <20230707031536.666482-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3mp7vg6dk0X+NNQ--.406S4
X-Coremail-Antispam: 1UD129KBjvdXoWrGr17Xw15KrWfXr18ur15Arb_yoWxWrc_uF
        97CFyxtr4j9a48Ca40vF48JryDKa1UGFWjyF17J39xX3yxZFn7Jw1Dtr45Zr17Za1jyrWU
        ZrW8Zan7Aw48KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbz8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

nbd->config = config and refcount_set(&nbd->config_refs, 1) in
nbd_genl_connect may be out of order, causing config_refs to be set to 1
first, and then nbd_open accessing nbd->config reports a null pointer
reference.

Zhong Jinghua (3):
  nbd: fold nbd config initialization into nbd_alloc_config()
  nbd: factor out a helper to get nbd_config without holding
    'config_lock'
  nbd: fix null-ptr-dereference while accessing 'nbd->config'

 drivers/block/nbd.c | 82 +++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 29 deletions(-)

-- 
2.31.1

