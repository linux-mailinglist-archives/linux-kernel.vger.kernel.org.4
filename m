Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B16382CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKYDmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYDmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:42:03 -0500
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB14B1182B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:42:01 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id TEO00022;
        Fri, 25 Nov 2022 11:41:22 +0800
Received: from lihongweizz00.home.langchao.com (10.93.221.219) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 25 Nov 2022 11:41:22 +0800
From:   lihongweizz <lihongweizz@inspur.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>
CC:     <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>,
        lihongweizz <lihongweizz@inspur.com>
Subject: [PATCH] ocfs2: fix infinite loop for orphan entry list
Date:   Fri, 25 Nov 2022 11:41:18 +0800
Message-ID: <20221125034118.427-1-lihongweizz@inspur.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.93.221.219]
tUid:   20221125114123bca5f4d50778c114cbf93989e7e66be2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orphan file may be in the recover list already when the ip_next_orphan
is NULL (for example, orphan file is second tail elementof recover
list). In this scenario, the file could be added to the list twice
and infinite loop happened. So we need another pointer value here(EFAULT)
 instead of NULL for the list tail element.

Signed-off-by: lihongweizz <lihongweizz@inspur.com>
---
 fs/ocfs2/journal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 126671e..4620013 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -2207,7 +2207,7 @@ static int ocfs2_recover_orphans(struct ocfs2_super *osb,
 				 enum ocfs2_orphan_reco_type orphan_reco_type)
 {
 	int ret = 0;
-	struct inode *inode = NULL;
+	struct inode *inode = ERR_PTR(-EFAULT);
 	struct inode *iter;
 	struct ocfs2_inode_info *oi;
 	struct buffer_head *di_bh = NULL;
@@ -2224,7 +2224,7 @@ static int ocfs2_recover_orphans(struct ocfs2_super *osb,
 	if (ret)
 		mlog_errno(ret);
 
-	while (inode) {
+	while (!IS_ERR(inode)) {
 		oi = OCFS2_I(inode);
 		trace_ocfs2_recover_orphans_iput(
 					(unsigned long long)oi->ip_blkno);
-- 
1.8.3.1

