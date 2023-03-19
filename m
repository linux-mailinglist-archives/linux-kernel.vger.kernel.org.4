Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBAA6C05C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCSVtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCSVta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:49:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE8912BD3;
        Sun, 19 Mar 2023 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LipVinnRLoEDEa+vjjA5/3unXwIjvgFv3lLbKmxn/BU=; b=lpYOtGR+pKWQS+CVFCSXb+R381
        Nng6PMZnpsAokhXG2OF7PbF8Gt1IWfH80MLQBlBr4DtQ5cVWOcQqDWDomlqsfoy/i+MsUwg5SKVcI
        TeTE/4PtWACysO4cRjffqu8iEAUzgvNzSdzxofBRFgIQdjXI0aoxhtskOIqWl1y9/W2t8kXqBzZVQ
        4t8O5/YvGPKUKqv7bxB2rf4pShpU16ObKP+AcbEii6meGT+ku02fhuxgzPbCVPk+U+1B0v1xQDLXm
        1RxLkRSxxfpJbPRg9eC2ejBNAs8JVU7SUG0vcz4eMB1eJW+SjdX4FCUDm1+VyigwDwhmP53pKt6NL
        W2ZCe26g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0u8-007WjQ-09;
        Sun, 19 Mar 2023 21:49:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [RFT 1/5] module: move finished_loading()
Date:   Sun, 19 Mar 2023 14:49:22 -0700
Message-Id: <20230319214926.1794108-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319214926.1794108-1-mcgrof@kernel.org>
References: <20230319214926.1794108-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has no functional change, just moves a routine earlier
as we'll make use of it next.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 929644d79d38..560d00e60744 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2444,27 +2444,6 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	return module_finalize(info->hdr, info->sechdrs, mod);
 }
 
-/* Is this module of this name done loading?  No locks held. */
-static bool finished_loading(const char *name)
-{
-	struct module *mod;
-	bool ret;
-
-	/*
-	 * The module_mutex should not be a heavily contended lock;
-	 * if we get the occasional sleep here, we'll go an extra iteration
-	 * in the wait_event_interruptible(), which is harmless.
-	 */
-	sched_annotate_sleep();
-	mutex_lock(&module_mutex);
-	mod = find_module_all(name, strlen(name), true);
-	ret = !mod || mod->state == MODULE_STATE_LIVE
-		|| mod->state == MODULE_STATE_GOING;
-	mutex_unlock(&module_mutex);
-
-	return ret;
-}
-
 /* Call module constructors. */
 static void do_mod_ctors(struct module *mod)
 {
@@ -2628,6 +2607,27 @@ static int may_init_module(void)
 	return 0;
 }
 
+/* Is this module of this name done loading?  No locks held. */
+static bool finished_loading(const char *name)
+{
+	struct module *mod;
+	bool ret;
+
+	/*
+	 * The module_mutex should not be a heavily contended lock;
+	 * if we get the occasional sleep here, we'll go an extra iteration
+	 * in the wait_event_interruptible(), which is harmless.
+	 */
+	sched_annotate_sleep();
+	mutex_lock(&module_mutex);
+	mod = find_module_all(name, strlen(name), true);
+	ret = !mod || mod->state == MODULE_STATE_LIVE
+		|| mod->state == MODULE_STATE_GOING;
+	mutex_unlock(&module_mutex);
+
+	return ret;
+}
+
 /*
  * We try to place it in the list now to make sure it's unique before
  * we dedicate too many resources.  In particular, temporary percpu
-- 
2.39.1

