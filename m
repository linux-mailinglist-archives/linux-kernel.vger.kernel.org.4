Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3199F5B925F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIOByg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIOByd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:54:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A81168
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:54:32 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSgBv5FT3zlVmR;
        Thu, 15 Sep 2022 09:50:31 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Sep 2022 09:54:30 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 15 Sep
 2022 09:54:29 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] x86/mm/pat: use DEFINE_SEQ_ATTRIBUTE to simplify memtype
Date:   Thu, 15 Sep 2022 10:28:18 +0800
Message-ID: <20220915022818.3119304-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 66a209f7eb86..3cf4ec3701f6 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1201,24 +1201,13 @@ static int memtype_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static const struct seq_operations memtype_seq_ops = {
+static const struct seq_operations memtype_sops = {
 	.start = memtype_seq_start,
 	.next  = memtype_seq_next,
 	.stop  = memtype_seq_stop,
 	.show  = memtype_seq_show,
 };
-
-static int memtype_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &memtype_seq_ops);
-}
-
-static const struct file_operations memtype_fops = {
-	.open    = memtype_seq_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(memtype);
 
 static int __init pat_memtype_list_init(void)
 {
-- 
2.25.1

