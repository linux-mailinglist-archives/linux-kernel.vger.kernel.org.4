Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A566B5894
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCKFSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCKFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78563140515;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O4b3Qxh/i39uh+zwcsp8AsaOxA5M41InYNm+nORqDPs=; b=3Ow6eDvBTwIXsDf145Zz2dBLVB
        yuBPoQbmbDY0TruIbFFrwghKp2pc0QFVg5Lm3yW9FgiDn5BzW4MiwSmotkIXMBPGPXebmLnuLQfxE
        62RMq0qzsEX+dOSlhoOuwYd8Bbwmq6vO7DuS1Dv9RM4oKsz03tnLCwCxBU/hwSf0YhPHS5TQyNae0
        +KqHD4ebj04pdEw4z40rApf4pnL5D2rC+G/Yb4ddAN0AACFeRBYoHeXVYYKvNdbc+paOa5z5Ymlw7
        Hv871ZP8Gojpg8tRM5KsGW8Zcv7Z7JHAHpEWEIOX8mGKb8hXlKlk8AeDIJjk0ql6FnsB6BixcMqfc
        /DUlEzCQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBNE-HP; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 11/12] module: use list_add_tail_rcu() when adding module
Date:   Fri, 10 Mar 2023 21:17:11 -0800
Message-Id: <20230311051712.4095040-12-mcgrof@kernel.org>
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

Put a new module at the end of the list intead of making
new modules at the top of the list. find_module_all() start
the hunt using the first entry on the list, if we assume
that the modules which are first loaded are the most
frequently looked for modules this should provide a tiny
optimization.

This is theoretical, and could use more actual data by analzying
the impact of this patch on boot time a slew of systems using
systemd-analyze.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 909454f9616e..bc9202b60d55 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2608,7 +2608,7 @@ static int add_unformed_module(struct module *mod)
 		goto out;
 
 	mod_update_bounds(mod);
-	list_add_rcu(&mod->list, &modules);
+	list_add_tail_rcu(&mod->list, &modules);
 	mod_tree_insert(mod);
 	err = 0;
 
-- 
2.39.1

