Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8B6C058E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCSV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCSV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8591B2FF;
        Sun, 19 Mar 2023 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J+/Q2DOgs8vLCa0HCsTGz7EjcxV00x9bDse9i1PpR1s=; b=CePS1LwRJyuk+mkqKdjf8aIOmS
        FrhfJ1Wk3YFgAnxvw2mIuv1lFtVQ0yOzMUjwUjJ6+k4kYoIbr73SxK99lOYnNygKn9WVQW4sq16Tx
        KCpoV0Z0juvqUek64GwK2lp0AQvRbwNqo/n5JhwNblKtSxOStv2JRRA/LdHcZJmm8DjPpLVewxHuT
        4ssQNmJsTtmWllfpBp5anKbmmVQifx3xpoHinbk2l+aEsCPPH1Rmz5LDy0e74s1kneUteJQKSGlVl
        +cVTxGrzRDBKDCcI+f8z0/RtCZY6WuCrQRsr2dXT65xjtOvfkukjMUgK4ytyOlSgef58ks0mDq+Ik
        rHW3CN7w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007Tr1-2I;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 02/12] module: rename next_string() to module_next_tag_pair()
Date:   Sun, 19 Mar 2023 14:27:36 -0700
Message-Id: <20230319212746.1783033-3-mcgrof@kernel.org>
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

This makes it clearer what it is doing. While at it,
make it available to other code other than main.c.
This will be used in the subsequent patch and make
the changes easier to read.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/internal.h | 2 ++
 kernel/module/main.c     | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index e3883b7d4840..1fa2328636ec 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -96,6 +96,8 @@ long module_get_offset_and_type(struct module *mod, enum mod_mem_type type,
 char *module_flags(struct module *mod, char *buf, bool show_state);
 size_t module_flags_taint(unsigned long taints, char *buf);
 
+char *module_next_tag_pair(char *string, unsigned long *secsize);
+
 static inline void module_assert_mutex_or_preempt(void)
 {
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1e739f534100..ebb5e6b92a48 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1017,7 +1017,7 @@ int try_to_force_load(struct module *mod, const char *reason)
 }
 
 /* Parse tag=value strings from .modinfo section */
-static char *next_string(char *string, unsigned long *secsize)
+char *module_next_tag_pair(char *string, unsigned long *secsize)
 {
 	/* Skip non-zero chars */
 	while (string[0]) {
@@ -1051,10 +1051,10 @@ static char *get_next_modinfo(const struct load_info *info, const char *tag,
 
 	if (prev) {
 		size -= prev - modinfo;
-		modinfo = next_string(prev, &size);
+		modinfo = module_next_tag_pair(prev, &size);
 	}
 
-	for (p = modinfo; p; p = next_string(p, &size)) {
+	for (p = modinfo; p; p = module_next_tag_pair(p, &size)) {
 		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
 			return p + taglen + 1;
 	}
-- 
2.39.1

