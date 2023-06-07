Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957FD725F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbjFGMh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjFGMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:36:52 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6CA173A;
        Wed,  7 Jun 2023 05:36:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QbmmK28W3z9y9xF;
        Wed,  7 Jun 2023 20:26:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnJgLMeYBkSckaAw--.4176S3;
        Wed, 07 Jun 2023 13:36:38 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Subject: [RFC][PATCH 1/5] smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
Date:   Wed,  7 Jun 2023 14:36:08 +0200
Message-Id: <20230607123612.2791303-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607123612.2791303-1-roberto.sassu@huaweicloud.com>
References: <20230607123612.2791303-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCnJgLMeYBkSckaAw--.4176S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1UKryUCFW8Gry7Jw4Utwb_yoWDCrb_G3
        W0yas3JrZ8A3W7Zws7CwnYqFn2g348Xr1rG3WSya9Iya45Xr1rXa15JFyrAFZ8Ww17Wa93
        uFnxWryYy347XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
        8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0xsqJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj45V2AABs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Since the SMACK64TRANSMUTE xattr makes sense only for directories, enforce
this restriction in smack_inode_setxattr().

Cc: stable@vger.kernel.org
Fixes: 5c6d1125f8db ("Smack: Transmute labels on specified directories") # v2.6.38.x
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/smack/smack_lsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b67d901ee74..53fc6a1034d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1260,7 +1260,8 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		check_priv = 1;
-		if (size != TRANS_TRUE_SIZE ||
+		if (!S_ISDIR(d_backing_inode(dentry)->i_mode) ||
+		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
-- 
2.25.1

