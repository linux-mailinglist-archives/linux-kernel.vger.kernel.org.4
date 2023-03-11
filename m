Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4AB6B5888
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCKFRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCKFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E5140530;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ulzd+B0GQOyWFcFb7AVNe7XdcgPMcGdt6XRGjoo6VBo=; b=36lENrK/S8KQeyMPt8RDa26cJW
        e0ZCzwSKXfwQcJX3aQHLJRvNrlkunyHS+BEIj3jLisOjsWQUxn7/RJPW5TkxFAFV/4fBxu6a1KsO+
        fl2LpAmwD+Xo2ql/6C4ZDdXVw5b1G+bJgamCh1ARmD1yuyqe8uO/niy3MZYCDJ3MBt8QI8pm+Nl8C
        QCmj2+IkOSXLYi0dFZSQPEBTvYUe1pTQfFFjXJWEd8397ntsh9LQZwa8INM85ItwblZRIi3APSu4A
        rTvnkQx7+/EG19UAuFao7c5MxTbXkVYBAivtXjxSV9mgEpq9Tl3S0DgzbGCT0huWAo3Fj+X0I3CnR
        hXAcAh+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBMs-4W; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 03/12] module: rename next_string() to module_next_tag_pair()
Date:   Fri, 10 Mar 2023 21:17:03 -0800
Message-Id: <20230311051712.4095040-4-mcgrof@kernel.org>
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
index 6d6e6a6184b5..50364707c0cd 100644
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

