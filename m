Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDF64E726
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLPF7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPF7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:59:18 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E8FE389D7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:59:16 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 810001E80D74;
        Fri, 16 Dec 2022 13:54:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PFhUgD3w8o_9; Fri, 16 Dec 2022 13:54:24 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B0ECF1E80D72;
        Fri, 16 Dec 2022 13:54:24 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     dimitri.sivanich@hpe.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] sgi-gru: grukservices: remove unnecessary (void*) conversions
Date:   Fri, 16 Dec 2022 13:59:10 +0800
Message-Id: <20221216055910.3559-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

void * pointer cb, no cast type assignment required.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 drivers/misc/sgi-gru/grukservices.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index fa1f5a632e7f..37e804bbb1f2 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -425,7 +425,7 @@ int gru_get_cb_exception_detail(void *cb,
 static char *gru_get_cb_exception_detail_str(int ret, void *cb,
 					     char *buf, int size)
 {
-	struct gru_control_block_status *gen = (void *)cb;
+	struct gru_control_block_status *gen = cb;
 	struct control_block_extended_exc_detail excdet;
 
 	if (ret > 0 && gen->istatus == CBS_EXCEPTION) {
@@ -452,7 +452,7 @@ static int gru_wait_idle_or_exception(struct gru_control_block_status *gen)
 
 static int gru_retry_exception(void *cb)
 {
-	struct gru_control_block_status *gen = (void *)cb;
+	struct gru_control_block_status *gen = cb;
 	struct control_block_extended_exc_detail excdet;
 	int retry = EXCEPTION_RETRY_LIMIT;
 
@@ -475,7 +475,7 @@ static int gru_retry_exception(void *cb)
 
 int gru_check_status_proc(void *cb)
 {
-	struct gru_control_block_status *gen = (void *)cb;
+	struct gru_control_block_status *gen = cb;
 	int ret;
 
 	ret = gen->istatus;
@@ -488,7 +488,7 @@ int gru_check_status_proc(void *cb)
 
 int gru_wait_proc(void *cb)
 {
-	struct gru_control_block_status *gen = (void *)cb;
+	struct gru_control_block_status *gen = cb;
 	int ret;
 
 	ret = gru_wait_idle_or_exception(gen);
-- 
2.18.2

