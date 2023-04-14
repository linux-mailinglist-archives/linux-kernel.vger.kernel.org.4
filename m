Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444EF6E1DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDNIP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjDNIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:15:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0301B7EF3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:15:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C8B2F4;
        Fri, 14 Apr 2023 01:16:20 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.19.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04FBF3F6C4;
        Fri, 14 Apr 2023 01:15:32 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: [PATCH v4 3/4] arch_topology: Remove early cacheinfo error message if -ENOENT
Date:   Fri, 14 Apr 2023 10:14:51 +0200
Message-Id: <20230414081453.244787-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414081453.244787-1-pierre.gondois@arm.com>
References: <20230414081453.244787-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fetch_cache_info() tries to get the number of cache leaves/levels
for each CPU in order to pre-allocate memory for cacheinfo struct.
Allocating this memory later triggers a:
  'BUG: sleeping function called from invalid context'
in PREEMPT_RT kernels.

If there is no cache related information available in DT or ACPI,
fetch_cache_info() fails and an error message is printed:
  'Early cacheinfo failed, ret = ...'

Not having cache information should be a valid configuration.
Remove the error message if fetch_cache_info() fails with -ENOENT.

Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/base/arch_topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b1c1dd38ab01..c4b6198d7461 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -843,10 +843,11 @@ void __init init_cpu_topology(void)
 
 	for_each_possible_cpu(cpu) {
 		ret = fetch_cache_info(cpu);
-		if (ret) {
+		if (!ret)
+			continue;
+		else if (ret != -ENOENT)
 			pr_err("Early cacheinfo failed, ret = %d\n", ret);
-			break;
-		}
+		return;
 	}
 }
 
-- 
2.25.1

