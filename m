Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE836219F6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiKHRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKHRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:01:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9DBE11;
        Tue,  8 Nov 2022 09:01:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4850A616EE;
        Tue,  8 Nov 2022 17:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F109C433C1;
        Tue,  8 Nov 2022 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667926910;
        bh=C0ygJNIHY7YHHTXjkz/J5QGMeVxxURlhGZV1Kafdb7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=FBUlZ75AuBrQU6xeEnIcruXOdGvwE/gs3BnFGwr1uJtkXfIe9TGhUHQqcCOOZLMoE
         aLeyhIx36Qkup5b8xOzJgDEvKXh230unMjFCPIPCKOa/u/A0MVTX+U5+jlemljJtU2
         8gDNDraNu//aVTBCM8yFTtZ35sguEYHrYixvC5wNQlvjE41P2/HrgQv4SLNtmyekJG
         U2cAMjaJe/mYs/6j0ACLjcZuewoOZTmMIl/JA/bbesmf8ktwVAnr2CLXWhboHn5+TQ
         g7LhU1RFrocrIG55AXdz1NhdQoY0CWe3nbCNvdz+cDJUgQwHfQinHaw0YydeAAbNjx
         ++/Vi666AYYEQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] cpufreq: ACPI: Remove unused variables 'acpi_cpufreq_online' and 'ret'
Date:   Tue,  8 Nov 2022 10:01:03 -0700
Message-Id: <20221108170103.3375832-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
          acpi_cpufreq_online = ret;
                                ^~~
  drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable 'ret' to silence this warning
          int ret;
                ^
                  = 0
  1 error generated.

Both ret and acpi_cpufreq_online are now unused so they can be safely
removed, clearing up the warning.

Fixes: 13fdbc8b8da6 ("cpufreq: ACPI: Defer setting boost MSRs")
Link: https://github.com/ClangBuiltLinux/linux/issues/1757
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index c8fdfcf659e6..74ef0e05ff7b 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -953,12 +953,8 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
 	.attr		= acpi_cpufreq_attr,
 };
 
-static enum cpuhp_state acpi_cpufreq_online;
-
 static void __init acpi_cpufreq_boost_init(void)
 {
-	int ret;
-
 	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
 		pr_debug("Boost capabilities not present in the processor\n");
 		return;
@@ -966,8 +962,6 @@ static void __init acpi_cpufreq_boost_init(void)
 
 	acpi_cpufreq_driver.set_boost = set_boost;
 	acpi_cpufreq_driver.boost_enabled = boost_state(0);
-
-	acpi_cpufreq_online = ret;
 }
 
 static int __init acpi_cpufreq_init(void)

base-commit: 21cdb6c18f85fe538ca8740bc79f11fbe08d0197
-- 
2.38.1

