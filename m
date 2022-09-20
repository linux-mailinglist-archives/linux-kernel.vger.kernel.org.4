Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2715BDE61
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiITHh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiITHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:37:22 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09760683
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:37:19 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id OGF00011;
        Tue, 20 Sep 2022 15:37:11 +0800
Received: from lihongweizz00.home.langchao.com (10.180.204.84) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 15:37:15 +0800
From:   Rock Li <lihongweizz@inspur.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>
CC:     <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>,
        Rock Li <lihongweizz@inspur.com>
Subject: [PATCH] ocfs2: fix crash issue if access released lockres in debugfs
Date:   Tue, 20 Sep 2022 15:36:38 +0800
Message-ID: <20220920073638.1358-1-lihongweizz@inspur.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.204.84]
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201605.home.langchao.com (10.100.2.5)
tUid:   2022920153711997fac9f361039e13e098431dd3977e6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access locking_state of dlm debugfs may cause crash as scene below:

Proc A:                  Proc that access debuginfo:
add_lockres_tracking(lockresA)
...
                         ocfs2_dlm_seq_next():
                           //priv->p_iter_res points to next
                           //lockres e.g. B. priv->p_tmp_res hold
                           //copy of lockres A before leave
                         ocfs2_dlm_seq_show()
...
remove_lockres_tracking(lockres B):
  //free lockres B, l_debug_list in
  //priv->p_ter_res is updated but not
  //priv->p_tmp_res
...
                         ocfs2_dlm_seq_next():
			   //priv->p_tmp_res which holds a old copy of
                           //lockres A, the l_debug_list holds a
                           //out-of-date succeed pointer, which will
                           //cause crash as //access invalid memory
                           iter = v; //priv->p_tmp_res
                           iter = ocfs2_dlm_next_res(iter, priv)

The root cause of this issue is that private->p_iter_res acts as the
agent of accessing lockres and is protected by ocfs2_dlm_tracking_lock
while p_tmp_res is only a copy of the lockres and will be out-of-dated
after leave critial region of ocfs2_dlm_tracking_lock. We should use
priv->p_ter_res as the forward iterater instead.

Signed-off-by: Rock Li <lihongweizz@inspur.com>
---
 fs/ocfs2/dlmglue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index c28bc98..5d84350 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3109,7 +3109,7 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
 	struct ocfs2_lock_res *dummy = &priv->p_iter_res;
 
 	spin_lock(&ocfs2_dlm_tracking_lock);
-	iter = ocfs2_dlm_next_res(iter, priv);
+	iter = ocfs2_dlm_next_res(dummy, priv);
 	list_del_init(&dummy->l_debug_list);
 	if (iter) {
 		list_add(&dummy->l_debug_list, &iter->l_debug_list);
-- 
1.8.3.1

