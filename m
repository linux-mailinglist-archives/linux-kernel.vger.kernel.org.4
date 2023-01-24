Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8543679DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjAXPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjAXPlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:41:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4662748A32
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:41:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66AE4B3;
        Tue, 24 Jan 2023 07:42:04 -0800 (PST)
Received: from cam-smtp0.cambridge.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9F893F5A1;
        Tue, 24 Jan 2023 07:41:20 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dan Carpenter <error27@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next v2 2/3] cacheinfo: Make default acpi_get_cache_info() return an error
Date:   Tue, 24 Jan 2023 16:40:47 +0100
Message-Id: <20230124154053.355376-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124154053.355376-1-pierre.gondois@arm.com>
References: <20230124154053.355376-1-pierre.gondois@arm.com>
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
updates the prototype of acpi_get_cache_info(). The cache 'levels'
is update through a pointer and not the return value of the function.

If CONFIG_ACPI_PPTT is not defined, acpi_get_cache_info() doesn't
update its *levels and *split_levels parameters and returns 0.
This can lead to a faulty behaviour.

Make acpi_get_cache_info() return an error code if CONFIG_ACPI_PPTT
is not defined.
Also,

In init_cache_level(), if no PPTT is present or CONFIG_ACPI_PPTT is
not defined, instead of aborting if acpi_get_cache_info() returns an
error code, just continue. This allows to try fetching the cache
information from clidr_el1.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/kernel/cacheinfo.c | 2 +-
 include/linux/cacheinfo.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index d3fe9542c370..bf348b8d321f 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -59,7 +59,7 @@ int init_cache_level(unsigned int cpu)
 	} else {
 		ret = acpi_get_cache_info(cpu, &fw_level, NULL);
 		if (ret < 0)
-			return ret;
+			fw_level = 0;
 	}
 
 	if (fw_level < 0)
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

