Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCF75EF296
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiI2JrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiI2Jqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:46:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16927CF4A6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:45:24 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MdSzN62cxz1P6wg;
        Thu, 29 Sep 2022 17:41:04 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:45:22 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:45:21 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>, <Julia.Lawall@inria.fr>,
        <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
        <elver@google.com>, <wangkefeng.wang@huawei.com>,
        <zhouchengming@bytedance.com>, <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 1/3] arm64: module: Make plt_equals_entry() static
Date:   Thu, 29 Sep 2022 17:41:32 +0800
Message-ID: <20220929094134.99512-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929094134.99512-1-lihuafei1@huawei.com>
References: <20220929094134.99512-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4e69ecf4da1e ("arm64/module: ftrace: deal with place
relative nature of PLTs"), plt_equals_entry() is not used outside of
module-plts.c, so make it static.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/arm64/include/asm/module.h | 1 -
 arch/arm64/kernel/module-plts.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 4e7fa2623896..28514b989a0b 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -58,7 +58,6 @@ static inline bool is_forbidden_offset_for_adrp(void *place)
 }
 
 struct plt_entry get_plt_entry(u64 dst, void *pc);
-bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b);
 
 static inline bool plt_entry_is_initialized(const struct plt_entry *e)
 {
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index a3d0494f25a9..5a0a8f552a61 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -37,7 +37,8 @@ struct plt_entry get_plt_entry(u64 dst, void *pc)
 	return plt;
 }
 
-bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b)
+static bool plt_entries_equal(const struct plt_entry *a,
+			      const struct plt_entry *b)
 {
 	u64 p, q;
 
-- 
2.17.1

