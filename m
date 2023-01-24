Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD52679DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjAXPmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjAXPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:41:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81E114C0E6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:41:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143ADFEC;
        Tue, 24 Jan 2023 07:42:12 -0800 (PST)
Received: from cam-smtp0.cambridge.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E3903F5A1;
        Tue, 24 Jan 2023 07:41:28 -0800 (PST)
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
Subject: [PATCH -next v2 3/3] cacheinfo: Remove unused check in init_cache_level()
Date:   Tue, 24 Jan 2023 16:40:48 +0100
Message-Id: <20230124154053.355376-4-pierre.gondois@arm.com>
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

commit e75d18cecbb3 ("arm64: cacheinfo: Fix incorrect assignment
of signed error value to unsigned fw_level")
checks the fw_level value in init_cache_level() in case the value is
negative.
Remove this check as the error code is not returned through
fw_level anymore, and reset fw_level if acpi_get_cache_info()
failed. This allows to try fetching the cache information from
clidr_el1.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/kernel/cacheinfo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index bf348b8d321f..c307f69e9b55 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -62,9 +62,6 @@ int init_cache_level(unsigned int cpu)
 			fw_level = 0;
 	}
 
-	if (fw_level < 0)
-		return fw_level;
-
 	if (level < fw_level) {
 		/*
 		 * some external caches not specified in CLIDR_EL1
-- 
2.25.1

