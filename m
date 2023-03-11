Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB196B5883
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCKFRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCKFRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7776A14050A;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qzqBEKCC2vC00pN2R7hc5pPU3nToqryyRx5JQLW/z9M=; b=TEsvSmfSDwpaf+lGKHbExgRkTY
        RaHoiv1xaoskdj4IYejWfTgE11m/GKkwy0mCL3C/iim1GxE7OHZfJbdGACeRKMTkBEF1ZQjf4ghVI
        BXdJ+uQp3ez6TA8qFVJf6LAts/cEkpfQK4LSLYn0Q+fqX0udUrWRZolJ2wtqDf/YPUVFAINZcjPMa
        lSagEX7ap2lUAKGMLSq9bMBtYjo3ecSjlRcnwqLZDxWFq8HgpjcIP2SIBsC4m5lNVqpOdB2a8xyad
        mGzUpQLZ/awK8V3YUlAH4MrmXxxqVpl+EHQher4RL+RFEFuQ4sLN68G+qdPlKYzu6AK+az2Mq8icF
        NQl4r/Sw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBN2-AK; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 07/12] module: move check_modinfo() early to early_mod_check()
Date:   Fri, 10 Mar 2023 21:17:07 -0800
Message-Id: <20230311051712.4095040-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230311051712.4095040-1-mcgrof@kernel.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves check_modinfo() to early_mod_check(). This
doesn't make any functional changes either, as check_modinfo()
was the first call on layout_and_allocate(), so we're just
moving it back one routine and at the end.

This let's us keep separate the checkers from the allocater.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 32c92fb69c05..e9c7eb827f0d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2284,10 +2284,6 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	unsigned int ndx;
 	int err;
 
-	err = check_modinfo(info->mod, info, flags);
-	if (err)
-		return ERR_PTR(err);
-
 	/* Allow arches to frob section contents and sizes.  */
 	err = module_frob_arch_sections(info->hdr, info->sechdrs,
 					info->secstrings, info->mod);
@@ -2702,7 +2698,11 @@ static int early_mod_check(struct load_info *info, int flags)
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(info, info->mod))
-		return ENOEXEC;
+		return -ENOEXEC;
+
+	err = check_modinfo(info->mod, info, flags);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.39.1

