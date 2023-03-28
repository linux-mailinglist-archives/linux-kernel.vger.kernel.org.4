Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953E86CBEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjC1MWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjC1MWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:22:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F3F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7931AB81CA5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE77BC433D2;
        Tue, 28 Mar 2023 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680006170;
        bh=SrusFfYKuzb9qJ1fPuyyiI19ee9dDYsDkKxhBfXFx60=;
        h=From:To:Cc:Subject:Date:From;
        b=FwXsEXEKogNnEjhyVpejwrEZ8M64Nhw0cflqOr9Hmq6LC/yls6YXwaSpuQ0P5tr6Q
         AP3JT+IbBllwzb35HlxZZ9FQ1rTezdgMnd0wdKLFbARifI9LgkrXRB6qEqnMMPyxk3
         zP6MBisI4s1Ty6JEt1spwm2NkTTeAii0zZV2qG0IrJBuAJ7BEr0P8qMnXURz5lLizr
         b2ZUPRedrt6HC3RWrotpNbK5RjpLXR0GS5uceaC9cfElhah/u2ueUU3Ce0dGVcbAdp
         DjyKxE8oTOqWoyJpfI+Ng50JkoUlX7u3caqQtofmtt9bm9YCnb0NIRa4wfCbF0eGkD
         REoTjHud0n/vg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jan Kara <jack@suse.com>, Yangtao Li <frank.li@vivo.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Dave Chinner <dchinner@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Baokun Li <libaokun1@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: quota: avoid unused function warning for !CONFIG_SYSCTL
Date:   Tue, 28 Mar 2023 14:22:31 +0200
Message-Id: <20230328122244.2521387-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Having fs_dqstats_table[] inside of an #ifdef causes a build time
warning:

fs/quota/dquot.c:2864:12: error: 'do_proc_dqstats' defined but not used [-Werror=unused-function]
 2864 | static int do_proc_dqstats(struct ctl_table *table, int write,

Avoid this by using an IS_ENABLED() check in place of the #ifdef,
giving the compiler a better idea of how it is used.

Fixes: 63d00e08515b ("quota: check for register_sysctl() failure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Note: it may be better to just revert the 63d00e08515b patch, as the
additional pr_notice() does not seem to add much value after
the pr_err() printed by register_sysctl() that tells us exactly what
went wrong.
---
 fs/quota/dquot.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 05bed02b257f..6e9109c6218e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2877,7 +2877,6 @@ static int do_proc_dqstats(struct ctl_table *table, int write,
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
-#ifdef CONFIG_SYSCTL
 static struct ctl_table fs_dqstats_table[] = {
 	{
 		.procname	= "lookups",
@@ -2946,7 +2945,6 @@ static struct ctl_table fs_dqstats_table[] = {
 #endif
 	{ },
 };
-#endif
 
 static int __init dquot_init(void)
 {
@@ -2955,10 +2953,10 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-#ifdef CONFIG_SYSCTL
-	if (!register_sysctl("fs/quota", fs_dqstats_table))
-		pr_notice("quota sysctl registration failed!\n");
-#endif
+	if (IS_ENABLED(CONFIG_SYSCTL)) {
+		if (!register_sysctl("fs/quota", fs_dqstats_table))
+			pr_notice("quota sysctl registration failed!\n");
+	}
 
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
-- 
2.39.2

