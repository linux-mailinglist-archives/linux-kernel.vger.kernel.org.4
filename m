Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652B2657196
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiL1B3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1B3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:29:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F67DF15;
        Tue, 27 Dec 2022 17:29:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A57D2B80FEC;
        Wed, 28 Dec 2022 01:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B905CC433D2;
        Wed, 28 Dec 2022 01:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672190950;
        bh=3XVIwz9Ohm85QPhk+zsQOi2XQO0+IAfPFOpLecTxMg0=;
        h=From:To:Cc:Subject:Date:From;
        b=hKkaqU5oJoC5WDr5ZPFVqhMzboiYc9mkt1GblQx3R3L6rpSJqAja5O+NLlk2MuppA
         gXQOuUvTWqG6KJWIYIcJSFkQgUxFBKhVgskJiAjO0sYxGEXKo/A4ci4wp/Yl/Nj+Cb
         jzeklfprYSsSHFv5+VbC6Z0u6taoVst5nFDyV2mm0itOc44wstERjnIM0b8tlnYt9i
         mfiBsn4N0ZWslLezaermTPArVLxYi1kmZiARJRvd4WbC/aTyfsjTsug+czx8161kcF
         agtfinvxgJI+dBy74z20AVTCGPDjDnaRVb0RAIuV7fcId33dDZLxs8Ro1I7ynE6+a3
         arjxjrw/UNoYA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     alexander.h.duyck@linux.intel.com, paulmck@kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2] mm/page_reporting: replace rcu_access_pointer() with rcu_dereference_protected()
Date:   Wed, 28 Dec 2022 01:29:02 +0000
Message-Id: <20221228012902.1510901-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page reporting fetches pr_dev_info using rcu_access_pointer(), which is
for safely fetching a pointer that will not be dereferenced but could
concurrently updated.  The code indeed does not dereference pr_dev_info
after fetcing it using rcu_access_pointer(), but it fetches the pointer
while concurrent updtes to the pointer is avoided by holding the update
side lock, page_reporting_mutex.

In the case, rcu_dereference_protected() is recommended because it
provides better readability and performance on some cases, as
rcu_dereference_protected() avoids use of READ_ONCE().  Replace the
rcu_access_pointer() calls with rcu_dereference_protected().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/linux-mm/20221227192158.2553-1-sj@kernel.org/)
- Explicitly set the protection condition (Matthew Wilcox)

 mm/page_reporting.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 79a8554f024c..5c557a3e1423 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -356,7 +356,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	mutex_lock(&page_reporting_mutex);
 
 	/* nothing to do if already in use */
-	if (rcu_access_pointer(pr_dev_info)) {
+	if (rcu_dereference_protected(pr_dev_info,
+				lockdep_is_held(&page_reporting_order))) {
 		err = -EBUSY;
 		goto err_out;
 	}
@@ -401,7 +402,8 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
 {
 	mutex_lock(&page_reporting_mutex);
 
-	if (rcu_access_pointer(pr_dev_info) == prdev) {
+	if (prdev == rcu_dereference_protected(pr_dev_info,
+				lockdep_is_held(&page_reporting_mutex))) {
 		/* Disable page reporting notification */
 		RCU_INIT_POINTER(pr_dev_info, NULL);
 		synchronize_rcu();
-- 
2.25.1

