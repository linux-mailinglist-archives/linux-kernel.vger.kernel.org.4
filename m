Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D595648106
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLIKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLIKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:32:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B073E088;
        Fri,  9 Dec 2022 02:32:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA1E723A;
        Fri,  9 Dec 2022 02:32:48 -0800 (PST)
Received: from pierre123.arm.com (unknown [10.57.42.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56AAD3F73B;
        Fri,  9 Dec 2022 02:32:38 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     palmer@rivosinc.com, Ionela.Voinescu@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3 2/5] cacheinfo: Return error code in init_of_cache_level()
Date:   Fri,  9 Dec 2022 11:31:24 +0100
Message-Id: <20221209103130.572196-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209103130.572196-1-pierre.gondois@arm.com>
References: <20221209103130.572196-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make init_of_cache_level() return an error code when the cache
information parsing fails to help detecting missing information.

init_of_cache_level() is only called for riscv. Returning an error
code instead of 0 will prevent detect_cache_attributes() to allocate
memory if an incomplete DT is parsed.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/base/cacheinfo.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index a4308b48dd3e..6f6cd120c4f1 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -246,11 +246,11 @@ int init_of_cache_level(unsigned int cpu)
 		of_node_put(prev);
 		prev = np;
 		if (!of_device_is_compatible(np, "cache"))
-			break;
+			goto err_out;
 		if (of_property_read_u32(np, "cache-level", &level))
-			break;
+			goto err_out;
 		if (level <= levels)
-			break;
+			goto err_out;
 		if (of_property_read_bool(np, "cache-size"))
 			++leaves;
 		if (of_property_read_bool(np, "i-cache-size"))
@@ -265,6 +265,10 @@ int init_of_cache_level(unsigned int cpu)
 	this_cpu_ci->num_leaves = leaves;
 
 	return 0;
+
+err_out:
+	of_node_put(np);
+	return -EINVAL;
 }
 
 #else
-- 
2.25.1

