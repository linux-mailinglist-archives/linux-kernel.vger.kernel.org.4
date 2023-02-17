Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CB869A351
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjBQBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBQBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:14:43 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FC4AFC1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:14:42 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 61E841A00A90;
        Fri, 17 Feb 2023 09:15:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S9EpLlZOJPy2; Fri, 17 Feb 2023 09:15:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 8EBB11A00A8E;
        Fri, 17 Feb 2023 09:15:17 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] dm: remove unnecessary (void*) conversions
Date:   Fri, 17 Feb 2023 09:14:21 +0800
Message-Id: <20230217011420.6613-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 drivers/md/dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b424a6ee27ba..669f2821376a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2139,7 +2139,7 @@ static void event_callback(void *context)
 {
 	unsigned long flags;
 	LIST_HEAD(uevents);
-	struct mapped_device *md = (struct mapped_device *) context;
+	struct mapped_device *md = context;
 
 	spin_lock_irqsave(&md->uevent_lock, flags);
 	list_splice_init(&md->uevent_list, &uevents);
-- 
2.18.2

