Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB86C058C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCSV2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCSV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18C1B2D8;
        Sun, 19 Mar 2023 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y4inih6EMR+irK8uhPNLzhLHPy7ra4luuniGmaPokTs=; b=EIz4TIDfS/FzCmyu9OWDP+62u1
        1ekZjcAPXtboI1H4AWBlt5FhUiHoPZtJp13yv3914FJ5GIKtHlslvJeTXW+1M8KYSCZwVlpJY1A6X
        Oo4Zk0gWRfrhBFzfOjvUskXehJ/1NOo+FBBa72egioQZhfYezozRfCE2ec9fXsl6p/BP8Rwch5i9Q
        S+j1K/N2KFTYAaBdiIrWJILWXf0hvpiTakat2q7jMI3SfDIKaUG+kTzE4ECSssUlu87s4Zh9Grhxt
        C0Ma6+E1/5saWJVsr3zuHzMODv/ihjgVtqEXWq4se0HcCF/kDiYzQHyhSX0WTaS/gWh4GEb89KMGp
        W2uBERuQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007Tr9-2k;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 06/12] module: rename set_license() to module_license_taint_check()
Date:   Sun, 19 Mar 2023 14:27:40 -0700
Message-Id: <20230319212746.1783033-7-mcgrof@kernel.org>
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

The set_license() routine would seem to a reader to do some sort of
setting, but it does not. It just adds a taint if the license is
not set or proprietary.

This makes what the code is doing clearer, so much we can remove
the comment about it.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 95fd705328ac..5e64485ac05a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1573,7 +1573,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 	__layout_sections(mod, info, true);
 }
 
-static void set_license(struct module *mod, const char *license)
+static void module_license_taint_check(struct module *mod, const char *license)
 {
 	if (!license)
 		license = "unspecified";
@@ -1993,8 +1993,7 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	if (err)
 		return err;
 
-	/* Set up license info based on the info section */
-	set_license(mod, get_modinfo(info, "license"));
+	module_license_taint_check(mod, get_modinfo(info, "license"));
 
 	if (get_modinfo(info, "test")) {
 		if (!test_taint(TAINT_TEST))
-- 
2.39.1

