Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE36C058B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCSV22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCSV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C72E1B2F4;
        Sun, 19 Mar 2023 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wQkyT18VZpOuqRMfI0/GbWVG9J9s2yrV/+TTo6WVbWQ=; b=dkn9BWo+buogcOb4zH8SOvdKC5
        WNMMT8Jl+AR5MxaBeO9NBZlZeLxqEZOJxSP/6ShMRF76q5E8DoZ5Y+zR6c59absP/Nbr1Oo7wLZy5
        PeGPpvVcEhKKa4ZXSwRyVqKLI0ARZi+L9K0HnVuNmQX7iJ589cEzOGzfWQMXUa/3aBgNNv+U3BEIw
        3ujVrbll7407IemEyJYcjsz9fbM0TWErvVWtnuQdgSpOBQzqXGRwHOiQR6Y/a7IxtWyXsUUweEUNi
        1owqCZYziD0tEV5AQN9bcySH8/0tDgGi6TicwAg0vlP2hN2g/X4Oalkut5vPTNfCHlJ6Nrxc0igN3
        lkz+bsfw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0ZA-007TrN-0D;
        Sun, 19 Mar 2023 21:27:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 12/12] module: rename check_module_license_and_versions() to check_export_symbol_versions()
Date:   Sun, 19 Mar 2023 14:27:46 -0700
Message-Id: <20230319212746.1783033-13-mcgrof@kernel.org>
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

This makes the routine easier to understand what the check its checking for.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index f165d93a4ef9..cf097ffe6a4a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2220,7 +2220,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	return -ENOMEM;
 }
 
-static int check_module_license_and_versions(struct module *mod)
+static int check_export_symbol_versions(struct module *mod)
 {
 #ifdef CONFIG_MODVERSIONS
 	if ((mod->num_syms && !mod->crcs) ||
@@ -2796,7 +2796,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto free_unload;
 
-	err = check_module_license_and_versions(mod);
+	err = check_export_symbol_versions(mod);
 	if (err)
 		goto free_unload;
 
-- 
2.39.1

