Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9489A679824
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjAXMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjAXMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:35:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B8262B2BC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:35:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865B91FB;
        Tue, 24 Jan 2023 04:35:47 -0800 (PST)
Received: from cam-smtp0.cambridge.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D97283F64C;
        Tue, 24 Jan 2023 04:35:03 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Dan Carpenter <error27@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] cacheinfo: Correctly handle new acpi_get_cache_info() prototype
Date:   Tue, 24 Jan 2023 13:34:46 +0100
Message-Id: <20230124123450.321852-1-pierre.gondois@arm.com>
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

commit bd500361a937 ("ACPI: PPTT: Update acpi_find_last_cache_level()
to acpi_get_cache_info()")
updates the function acpi_get_cache_info().

If CONFIG_ACPI_PPTT is not defined, acpi_get_cache_info() doesn't
update its *levels and *split_levels parameters and returns 0.
This can lead to a faulty behaviour.

Make acpi_get_cache_info() return an error code if CONFIG_ACPI_PPTT
is not defined. Initialize levels and split_levels before passing
their address to acpi_get_cache_info().

Also, in init_cache_level():
- commit e75d18cecbb3 ("arm64: cacheinfo: Fix incorrect
  assignment of signed error value to unsigned fw_level")
  checks the fw_level value in init_cache_level() in case
  the value is negative. Remove this check as the error code
  is not returned through fw_level anymore.
- if no PPTT is present or CONFIG_ACPI_PPTT is not defined,
  it is still possible to use the cache information from clidr_el1.
  Instead of aborting if acpi_get_cache_info() returns an error
  code, just continue.

Reported-by: Dan Carpenter <error27@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/kernel/cacheinfo.c | 5 +----
 drivers/base/cacheinfo.c      | 2 +-
 include/linux/cacheinfo.h     | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 36c3b07cdf2d..3ba70985e3a2 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -64,12 +64,9 @@ int init_cache_level(unsigned int cpu)
 	} else {
 		ret = acpi_get_cache_info(cpu, &fw_level, NULL);
 		if (ret < 0)
-			return ret;
+			fw_level = 0;
 	}
 
-	if (fw_level < 0)
-		return fw_level;
-
 	if (level < fw_level) {
 		/*
 		 * some external caches not specified in CLIDR_EL1
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index b57fbd0d7114..f184ef7dc1d2 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -414,7 +414,7 @@ int allocate_cache_info(int cpu)
 int fetch_cache_info(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
-	unsigned int levels, split_levels;
+	unsigned int levels = 0, split_levels = 0;
 	int ret;
 
 	if (acpi_disabled) {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index dfef57077cd0..908e19d17f49 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -100,7 +100,7 @@ static inline
 int acpi_get_cache_info(unsigned int cpu,
 			unsigned int *levels, unsigned int *split_levels)
 {
-	return 0;
+	return -ENOENT;
 }
 #else
 int acpi_get_cache_info(unsigned int cpu,
-- 
2.25.1

