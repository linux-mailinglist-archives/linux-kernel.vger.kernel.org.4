Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D56C058A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjCSV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCSV1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488581B2D5;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DmmClILS1g6mcg7ANVU+N9GnQBvI3D3ynSwuLGeWqeI=; b=JOGTvYtqYTaBIKjuf0MlJsEXU6
        ih7Dq5oCMS6MzKn1cNg2MRQqtbCPpb8OHPM2QQs1KwUoSSI63TpttvQnqXLXN+9IRQqPN44SrtjY/
        gwPnKkV4vnY+EfQmaDmGJcyd80GRNNttTdbopL45wvuoEvK1MMdPR4nf0QXYF/ZIHpLlFfMkkebTq
        UqWNaLzQP3DnpQUD1w6khRg1IRSBRIaOyMExY27eU3Zeu+leW3RaAMFtXoP1hSRcynevgfFAG/rtS
        jiwRUVQss5VQULenHs23VzmWBwGzAOC3OpLCFxv24ySpRLSIubTpscFDzHD5CIPYGXDjf3g4qBHDO
        7GLbR8Dw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007TrF-35;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 09/12] module: move tainting until after a module hits our linked list
Date:   Sun, 19 Mar 2023 14:27:43 -0700
Message-Id: <20230319212746.1783033-10-mcgrof@kernel.org>
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

It is silly to have taints spread out all over, we can just compromise
and add them if the module ever hit our linked list. Our sanity checkers
should just prevent crappy drivers / bogus ELF modules / etc and kconfig
options should be enough to let you *not* load things you don't want.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a3953ca18090..1aa71f82aca2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2009,18 +2009,6 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	if (err)
 		return err;
 
-	/*
-	 * We are tainting your kernel *even* if you try to load
-	 * modules with possible taints and we fail to load these
-	 * modules for other reasons.
-	 *
-	 * We have a descrepancy though, see the other taints for
-	 * signature and those in check_module_license_and_versions().
-	 *
-	 * We should compromise and converge.
-	 */
-	module_augment_kernel_taints(mod, info);
-
 	return 0;
 }
 
@@ -2772,6 +2760,16 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto free_module;
 
+	/*
+	 * We are tainting your kernel if your module gets into
+	 * the modules linked list somehow.
+	 *
+	 * We have a descrepancy though, see the other taints for
+	 * signature and those in check_module_license_and_versions().
+	 *
+	 * We should compromise and converge.
+	 */
+	module_augment_kernel_taints(mod, info);
 #ifdef CONFIG_MODULE_SIG
 	mod->sig_ok = info->sig_ok;
 	if (!mod->sig_ok) {
-- 
2.39.1

