Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DC5BDF65
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiITILx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiITILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:11:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12727642DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:07:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWvCy4KsnzMn5k;
        Tue, 20 Sep 2022 16:02:38 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 16:07:19 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <jpoimboe@kernel.org>, <peterz@infradead.org>, <mbenes@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, <zengheng4@huawei.com>,
        <liwei391@huawei.com>
Subject: [PATCH -next 1/3] tools: objtool: fix unused parameter warning in elf.c
Date:   Tue, 20 Sep 2022 16:14:14 +0800
Message-ID: <20220920081416.3570803-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920081416.3570803-1-zengheng4@huawei.com>
References: <20220920081416.3570803-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function parameter of internal function
'elf_rebuild_reloc_section'.

There is no logic changes.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/objtool/elf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c25e957c1e52..356af4d16d3f 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1224,7 +1224,7 @@ static int elf_rebuild_rela_reloc_section(struct section *sec)
 	return 0;
 }
 
-static int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
+static int elf_rebuild_reloc_section(struct section *sec)
 {
 	switch (sec->sh.sh_type) {
 	case SHT_REL:  return elf_rebuild_rel_reloc_section(sec);
@@ -1302,7 +1302,7 @@ int elf_write(struct elf *elf)
 			}
 
 			if (sec->base &&
-			    elf_rebuild_reloc_section(elf, sec)) {
+			    elf_rebuild_reloc_section(sec)) {
 				WARN("elf_rebuild_reloc_section");
 				return -1;
 			}
-- 
2.25.1

