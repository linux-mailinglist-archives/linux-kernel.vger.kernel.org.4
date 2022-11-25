Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763D6382A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKYDPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKYDPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:15:46 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D8023EA2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:15:41 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id TEO00134;
        Fri, 25 Nov 2022 11:15:34 +0800
Received: from lihongweizz00.home.langchao.com (10.93.221.219) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 25 Nov 2022 11:15:34 +0800
From:   lihongweizz <lihongweizz@inspur.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>
CC:     <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>,
        Rock Li <lihongweizz@inspur.com>
Subject: [PATCH] ocfs2: properly clean task pointer before o2hb thread exits abnormally
Date:   Fri, 25 Nov 2022 11:15:22 +0800
Message-ID: <20221125031522.339-1-lihongweizz@inspur.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.93.221.219]
tUid:   2022112511153408350572528650079766ee080579aa08
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rock Li <lihongweizz@inspur.com>

in case o2hb thread exits abnormally before stop o2cb service,
heartbeat_drop_group_item will try to stop a noexit thread cause
ret->hb_task was not clear properly.

Signed-off-by: Rock Li <lihongweizz@inspur.com>
---
 fs/ocfs2/cluster/heartbeat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index b13d344..9db448d 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1258,6 +1258,8 @@ static int o2hb_thread(void *data)
 	/* Unpin node */
 	o2nm_undepend_this_node();
 
+	reg->hr_task = NULL;
+
 	mlog(ML_HEARTBEAT|ML_KTHREAD, "o2hb thread exiting\n");
 
 	return 0;
-- 
1.8.3.1

