Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB35B5C80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiILOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiILOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:42:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F9653A15C;
        Mon, 12 Sep 2022 07:41:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AF21113E;
        Mon, 12 Sep 2022 07:42:03 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75B6F3F73D;
        Mon, 12 Sep 2022 07:41:50 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Jia He <justin.he@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 7/8] apei/ghes: Use unrcu_pointer for cmpxchg
Date:   Mon, 12 Sep 2022 14:40:04 +0000
Message-Id: <20220912144005.212624-8-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912144005.212624-1-justin.he@arm.com>
References: <20220912144005.212624-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ghes_estatus_caches should be add rcu annotation to avoid sparse warnings.
   drivers/acpi/apei/ghes.c:733:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/acpi/apei/ghes.c:733:25: sparse:    struct ghes_estatus_cache [noderef] __rcu *
   drivers/acpi/apei/ghes.c:733:25: sparse:    struct ghes_estatus_cache *
   drivers/acpi/apei/ghes.c:813:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/acpi/apei/ghes.c:813:25: sparse:    struct ghes_estatus_cache [noderef] __rcu *
   drivers/acpi/apei/ghes.c:813:25: sparse:    struct ghes_estatus_cache *

unrcu_pointer is to strip the __rcu in cmpxchg.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/acpi/apei/ghes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 4af269b22bd4..c0b09addb96f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -153,7 +153,7 @@ struct ghes_vendor_record_entry {
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;
 
-static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
@@ -843,8 +843,9 @@ static void ghes_estatus_cache_add(
 	}
 	/* new_cache must be put into array after its contents are written */
 	smp_wmb();
-	if (slot != -1 && cmpxchg(ghes_estatus_caches + slot,
-				  slot_cache, new_cache) == slot_cache) {
+	if (slot != -1 && unrcu_pointer(cmpxchg(ghes_estatus_caches + slot,
+				RCU_INITIALIZER(slot_cache),
+				RCU_INITIALIZER(new_cache))) == slot_cache) {
 		if (slot_cache)
 			call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu_free);
 	} else
-- 
2.25.1

