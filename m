Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA2B6C0584
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjCSV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCSV1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BB91B2D9;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BJziSesoP/Gpg+7BL9qEqeZCL3p8RKiimKBmJEDITp8=; b=g3NwwIG3zD7AFe0LuFyf5oAFC5
        HRgQIDx/dWpyLqYoKvOcWyhc5D5C6EJslVjQWlx325cDgx8xdvgFLQVUiRYTTupvcLZyqmtYrYPGz
        idFG3aftxkZ6sHc6l9y8/90vBIuz3mDyvsKEXfwfCyfIKnjf8P71Zd6eE3+URco0h0E23z109KhhK
        fHBIb0eQx872JTdamAukzyihSKtICy20JfmfF/KRnbBgPaXwKdMa66UDz4V0KH2zDpWzdd8k3Pv77
        m1j+kDkec88lwIEVYJngSs7CIx5eiNmqDWyyd+Btada3Kx0Z1IPq2Dhn05bQP0TVC8QRxpWuP+IkH
        28R1TAqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007TrH-3C;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 10/12] module: move signature taint to module_augment_kernel_taints()
Date:   Sun, 19 Mar 2023 14:27:44 -0700
Message-Id: <20230319212746.1783033-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319212746.1783033-1-mcgrof@kernel.org>
References: <20230319212746.1783033-1-mcgrof@kernel.org>
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

Just move the signature taint into the helper:

  module_augment_kernel_taints()

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1aa71f82aca2..2f1988137965 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1984,6 +1984,15 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 				mod->name);
 		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
 	}
+#ifdef CONFIG_MODULE_SIG
+	mod->sig_ok = info->sig_ok;
+	if (!mod->sig_ok) {
+		pr_notice_once("%s: module verification failed: signature "
+			       "and/or required key missing - tainting "
+			       "kernel\n", mod->name);
+		add_taint_module(mod, TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
+	}
+#endif
 }
 
 static int check_modinfo(struct module *mod, struct load_info *info, int flags)
@@ -2770,15 +2779,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	 * We should compromise and converge.
 	 */
 	module_augment_kernel_taints(mod, info);
-#ifdef CONFIG_MODULE_SIG
-	mod->sig_ok = info->sig_ok;
-	if (!mod->sig_ok) {
-		pr_notice_once("%s: module verification failed: signature "
-			       "and/or required key missing - tainting "
-			       "kernel\n", mod->name);
-		add_taint_module(mod, TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
-	}
-#endif
 
 	/* To avoid stressing percpu allocator, do this once we're unique. */
 	err = percpu_modalloc(mod, info);
-- 
2.39.1

