Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5366CD3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjC2IDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2IC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:02:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3431BFB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17102B81ADA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0902FC433D2;
        Wed, 29 Mar 2023 08:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680076974;
        bh=92TAbqWARXeujUx3JkwuNmKYR3DjPGLIhIOnKSx3mpg=;
        h=From:To:Cc:Subject:Date:From;
        b=hA0X1vVfmB6PTFroH5fIUajvrFvPW7/4V1OzE58pVDoViEAq4MMhFMcCITGr9/ZBx
         O5wXJBH67X8+23zbSvNdt2XtsQArIH0tL7zQwJfG0eZPOybQOskXcTYp9br6vpO606
         U24LeJkIp+DqPp9CMZjCPmX6d+PHZda8ufgoVjejP3ki3NGyi3u4FpFdnX8bDXHlq/
         52X/gLoXIvzvpRNcDTRRlraRp0o+AN1IxlDFBaeDQl3WZNd6SN8qilKnjA7BXmEN1C
         JxdDttsCSLghrxLhzZJCaPz1+1MSNHRUbieMfcyKcdPiR6W6NVpjsfNTW2FZnO5BVp
         Z8bV/CUymVw7A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>, Miaohe Lin <linmiaohe@huawei.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        NARIBAYASHI Akira <a.naribayashi@fujitsu.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: compaction: remove incorrect #ifdef checks
Date:   Wed, 29 Mar 2023 10:02:41 +0200
Message-Id: <20230329080248.2543492-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_SYSCTL, the compiler warns about a few unused functions:

mm/compaction.c:3076:12: error: 'proc_dointvec_minmax_warn_RT_change' defined but not used [-Werror=unused-function]
mm/compaction.c:2780:12: error: 'sysctl_compaction_handler' defined but not used [-Werror=unused-function]
mm/compaction.c:2750:12: error: 'compaction_proactiveness_sysctl_handler' defined but not used [-Werror=unused-function]

The #ifdef is actually not necessary here, as the alternative
register_sysctl_init() stub function does not use its argument, which
lets the compiler drop the rest implicitly, while avoiding the warning.

Fixes: c521126610c3 ("mm: compaction: move compaction sysctl to its own file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/compaction.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 3dfdb84b9c98..c8bcdea15f5f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3092,7 +3092,6 @@ static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
 	return ret;
 }
 
-#ifdef CONFIG_SYSCTL
 static struct ctl_table vm_compaction[] = {
 	{
 		.procname	= "compact_memory",
@@ -3130,7 +3129,6 @@ static struct ctl_table vm_compaction[] = {
 	},
 	{ }
 };
-#endif
 
 static int __init kcompactd_init(void)
 {
@@ -3147,9 +3145,7 @@ static int __init kcompactd_init(void)
 
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
-#ifdef CONFIG_SYSCTL
 	register_sysctl_init("vm", vm_compaction);
-#endif
 	return 0;
 }
 subsys_initcall(kcompactd_init)
-- 
2.39.2

