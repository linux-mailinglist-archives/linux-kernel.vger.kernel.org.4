Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4934260FB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiJ0PJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiJ0PJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32518F0CF;
        Thu, 27 Oct 2022 08:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14CED62395;
        Thu, 27 Oct 2022 15:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AFEC43470;
        Thu, 27 Oct 2022 15:09:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4VZ-00BvSf-1y;
        Thu, 27 Oct 2022 11:09:25 -0400
Message-ID: <20221027150925.435425818@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [RFC][PATCH v2 02/31] timers: s390/cmm: Use del_timer_shutdown() before freeing timer
References: <20221027150525.753064657@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, del_timer_shutdown() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/s390/mm/cmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 9141ed4c52e9..6ade449343d2 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -419,7 +419,7 @@ static int __init cmm_init(void)
 #endif
 	unregister_sysctl_table(cmm_sysctl_header);
 out_sysctl:
-	del_timer_sync(&cmm_timer);
+	del_timer_shutdown(&cmm_timer);
 	return rc;
 }
 module_init(cmm_init);
@@ -432,7 +432,7 @@ static void __exit cmm_exit(void)
 #endif
 	unregister_oom_notifier(&cmm_oom_nb);
 	kthread_stop(cmm_thread_ptr);
-	del_timer_sync(&cmm_timer);
+	del_timer_shutdown(&cmm_timer);
 	cmm_free_pages(cmm_pages, &cmm_pages, &cmm_page_list);
 	cmm_free_pages(cmm_timed_pages, &cmm_timed_pages, &cmm_timed_page_list);
 }
-- 
2.35.1
