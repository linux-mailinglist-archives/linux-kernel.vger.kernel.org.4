Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7321D6E09E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDMJP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMJPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:15:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CC0C6199
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:15:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8708C13D5;
        Thu, 13 Apr 2023 02:15:54 -0700 (PDT)
Received: from pierre123.nice.arm.com (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 427923F6C4;
        Thu, 13 Apr 2023 02:15:08 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Conor Dooley <conor@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 3/4] arch_topology: Remove early cacheinfo error message
Date:   Thu, 13 Apr 2023 11:14:33 +0200
Message-Id: <20230413091436.230134-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230413091436.230134-1-pierre.gondois@arm.com>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Remove the error message if fetch_cache_info() fails.

Suggested-by: Conor Dooley <conor@kernel.org>
Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/base/arch_topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b1c1dd38ab01..1f071eaede5b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -843,10 +843,8 @@ void __init init_cpu_topology(void)
 
 	for_each_possible_cpu(cpu) {
 		ret = fetch_cache_info(cpu);
-		if (ret) {
-			pr_err("Early cacheinfo failed, ret = %d\n", ret);
+		if (ret)
 			break;
-		}
 	}
 }
 
-- 
2.25.1

