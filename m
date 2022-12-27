Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB145656E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiL0TWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0TWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:22:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68838D4C;
        Tue, 27 Dec 2022 11:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 193F3B810A9;
        Tue, 27 Dec 2022 19:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D798C433D2;
        Tue, 27 Dec 2022 19:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672168956;
        bh=HQogRMPkd4mTd9GL8MsC9tWHVut88yOyJXgzfE2Mg/8=;
        h=From:To:Cc:Subject:Date:From;
        b=vDLqcDB61J3uvKTRrDb2HTD3ZgflRoB2EjpBVWxzA4nFFZPKELz3A1ATtPhJR7nuL
         pkNiAu21YNCmlcuILqK/UTlowtfwJiO+fcIoJ1RSFVvuZRMCzHgVY64shOCgOFFAVQ
         hE6EABBBgJRC3y+nyI54+sp/U8XuXpVx9s2H3htxUu1g26mvnJixurxR0kJKPPTwnM
         PYBECaM3VLbY+MvgJk1ZlQt+SnYFvTV/ECNyD+qvNWTODSyJ5zxwp7cygtqTVbbcgi
         8R5Daa7u2KjSf7C/ZM9eoYbiE3kTkS9lygWpZGGrvEa49em6AmNCXL36qB+aDU6iNL
         Jzk2YVAe/ljSg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     alexander.h.duyck@linux.intel.com, paulmck@kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/page_reporting: replace rcu_access_pointer() with rcu_dereference_protected()
Date:   Tue, 27 Dec 2022 19:21:58 +0000
Message-Id: <20221227192158.2553-1-sj@kernel.org>
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
 mm/page_reporting.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 79a8554f024c..079e0ebe1fb7 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -356,7 +356,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	mutex_lock(&page_reporting_mutex);
 
 	/* nothing to do if already in use */
-	if (rcu_access_pointer(pr_dev_info)) {
+	if (rcu_dereference_protected(pr_dev_info, true)) {
 		err = -EBUSY;
 		goto err_out;
 	}
@@ -401,7 +401,7 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
 {
 	mutex_lock(&page_reporting_mutex);
 
-	if (rcu_access_pointer(pr_dev_info) == prdev) {
+	if (rcu_dereference_protected(pr_dev_info, true) == prdev) {
 		/* Disable page reporting notification */
 		RCU_INIT_POINTER(pr_dev_info, NULL);
 		synchronize_rcu();
-- 
2.25.1

