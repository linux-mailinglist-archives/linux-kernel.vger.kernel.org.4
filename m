Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F0565856C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiL1R7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiL1R7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:59:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CA167C0;
        Wed, 28 Dec 2022 09:59:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 979C86158F;
        Wed, 28 Dec 2022 17:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0E9C433F0;
        Wed, 28 Dec 2022 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672250386;
        bh=XN9PcsyPPRLwqqgJ2SzuIm7xkFHpLYHw7zI07sgsjnc=;
        h=From:To:Cc:Subject:Date:From;
        b=dnUZukkc3qKrGLW6R3tkbIKWiwATzVWetlE/iWL6Rx7JJJPCfkJwdj4arTf88CmpJ
         7x6mJ27NRKW3BVc8h6cFtsmTUDQEXuUfiUfOdPZ5rmDjibNxqU1i7mqALaVvVtm14P
         C4hIDOdP5gRo7cHXKrqo3WL91/3iPq88gTKW4496/wH26+Uj7SSYLjSnwfEfotIkmX
         X7WsfiIvsHrrWDi5HBibzsJKnpQ9s4dlQFlaxGf8wxHrRwf4EyT6wmpRaeLOllAv1a
         2QHnGEQiBAKMl0ORqgWjckrysWHXHC5zj+/WzOnmuJsMK2gnbLzCapjL8Qk105IqjH
         sL4vkh84YjfGQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, alexander.h.duyck@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com, linux-mm@kvack.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/page_reporting: replace rcu_access_pointer() with rcu_dereference_protected()
Date:   Wed, 28 Dec 2022 17:59:42 +0000
Message-Id: <20221228175942.149491-1-sj@kernel.org>
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
after fetching it using rcu_access_pointer(), but it fetches the pointer
while concurrent updates to the pointer is avoided by holding the update
side lock, page_reporting_mutex.

In the case, rcu_dereference_protected() should be used instead because
it provides better readability and performance on some cases, as
rcu_dereference_protected() avoids use of READ_ONCE().  Replace the
rcu_access_pointer() calls with rcu_dereference_protected().

Fixes: 36e66c554b5c ("mm: introduce Reported pages")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2
(https://lore.kernel.org/linux-mm/20221228012902.1510901-1-sj@kernel.org/)
- Fix typos (Miaohe Lin)
- Add Fixes: tag

Changes from v1
(https://lore.kernel.org/linux-mm/20221227192158.2553-1-sj@kernel.org/)
- Explicitly set the protection condition (Matthew Wilcox)

 mm/page_reporting.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 79a8554f024c..c65813a9dc78 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -356,7 +356,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	mutex_lock(&page_reporting_mutex);
 
 	/* nothing to do if already in use */
-	if (rcu_access_pointer(pr_dev_info)) {
+	if (rcu_dereference_protected(pr_dev_info,
+				lockdep_is_held(&page_reporting_mutex))) {
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

