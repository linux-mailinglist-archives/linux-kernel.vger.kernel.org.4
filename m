Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C25662B6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiKPJwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiKPJwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:52:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE59D6441;
        Wed, 16 Nov 2022 01:52:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BAB1477;
        Wed, 16 Nov 2022 01:52:41 -0800 (PST)
Received: from cam-smtp0.cambridge.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD94D3F663;
        Wed, 16 Nov 2022 01:52:33 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob.Herring@arm.com, sudeep.holla@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next v2] cacheinfo: Remove of_node_put() for fw_token
Date:   Wed, 16 Nov 2022 10:49:58 +0100
Message-Id: <20221116094958.2141072-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_token is used for DT/ACPI systems to identify CPUs sharing caches.
For DT based systems, fw_token is set to a pointer to a DT node.

commit 3da72e18371c ("cacheinfo: Decrement refcount in
cache_setup_of_node()")
doesn't increment the refcount of fw_token anymore in
cache_setup_of_node(). fw_token is indeed used as a token and not
as a (struct device_node*), so no reference to fw_token should be
kept.

However, [1] is triggered when hotplugging a CPU multiple times
since cache_shared_cpu_map_remove() decrements the refcount to
fw_token at each CPU unplugging, eventually reaching 0.

Remove of_node_put() for fw_token in cache_shared_cpu_map_remove().

[1]
------------[ cut here ]------------
refcount_t: saturated; leaking memory.
WARNING: CPU: 4 PID: 32 at lib/refcount.c:22 refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
Modules linked in:
CPU: 4 PID: 32 Comm: cpuhp/4 Tainted: G        W          6.1.0-rc1-14091-g9fdf2ca7b9c8 #76
Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct 31 2022
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
lr : refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
[...]
Call trace:
[...]
of_node_release (drivers/of/dynamic.c:335)
kobject_put (lib/kobject.c:677 lib/kobject.c:704 ./include/linux/kref.h:65 lib/kobject.c:721)
of_node_put (drivers/of/dynamic.c:49)
free_cache_attributes.part.0 (drivers/base/cacheinfo.c:712)
cacheinfo_cpu_pre_down (drivers/base/cacheinfo.c:718)
cpuhp_invoke_callback (kernel/cpu.c:247 (discriminator 4))
cpuhp_thread_fun (kernel/cpu.c:785)
smpboot_thread_fn (kernel/smpboot.c:164 (discriminator 3))
kthread (kernel/kthread.c:376)
ret_from_fork (arch/arm64/kernel/entry.S:861)
---[ end trace 0000000000000000 ]---

Fixes: 3da72e18371c ("cacheinfo: Decrement refcount in cache_setup_of_node()")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---

Notes:
    v2:
    - Update commit message. [Sudeep]

 drivers/base/cacheinfo.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 04317cde800c..950b22cdb5f7 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -317,8 +317,6 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
 		}
-		if (of_have_populated_dt())
-			of_node_put(this_leaf->fw_token);
 	}
 }
 
-- 
2.25.1

