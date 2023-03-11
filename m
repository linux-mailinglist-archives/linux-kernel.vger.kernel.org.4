Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F96B5890
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCKFSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCKFRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB0F140507;
        Fri, 10 Mar 2023 21:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=P2MoYZYdnAb3Oq0MP2kQqdmToxGWZIkjpMBdgpAlhMs=; b=SuFhUVy5Zd7B7mtIDnpPByC4Ao
        10YL+FTyhpuXcsai5/ra07AtTaL5mvac+FSPlnnWqTEKl+hS31lsFUdNEawCii+7q0glpKsoCEWpZ
        HcsVn3gxQ7LZm2Nf1pUIAmQ/B4IW0uQW06uwV62r6p7PoZk45GSTxT+rmIlduySRK0EbiYsjvYSBk
        qYbYPz9wY0Du2LmXb20Xw88j30mQqJmGCRzcy7WzsiZ4/yUXWrD9w8DQHNImzr34AIc26mHOVpvqD
        gRqKNWz7jxO2yBDwYX5Tg3I1gxxwwuG2ANUNOjq/se13XzV1zupepqdj2WnJedLFKD3759M+PlDkn
        fhPpKksg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBNC-Fl; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 10/12] module: avoid allocation if module is already present and ready
Date:   Fri, 10 Mar 2023 21:17:10 -0800
Message-Id: <20230311051712.4095040-11-mcgrof@kernel.org>
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

load_module() will allocate a struct module before even checking
if the module is already loaded. This can create unecessary memory
pressure since we can easily just check if the module is already
present early with the copy of the module information from userspace
after we've validated it a bit.

This can only be an issue if a system is getting hammered with userspace
loading modules. Note that there are two ways to load modules, one is
auto-loading in-kernel and that pings back to userspace to just call
modprobe. Then userspace itself *is* supposed to check if a module
is present before loading it. But we're observing situations where
tons of the same module are in effect being loaded. In that situation
we can end up allocating memory for module requests which after
allocating memory will fail to load.

To avoid memory pressure for such stupid cases put a stop gap for them.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e24323e2c499..909454f9616e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2713,6 +2713,10 @@ static int early_mod_check(struct load_info *info, int flags)
 	if (err)
 		return err;
 
+	err = module_patient_check_exists(info->mod->name);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.39.1

