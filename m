Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB44671F4C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFAVd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFAVd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C7184;
        Thu,  1 Jun 2023 14:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F315964A01;
        Thu,  1 Jun 2023 21:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264F7C433EF;
        Thu,  1 Jun 2023 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655205;
        bh=DVSNOTIP/R8bS1m5PsAZpRYvyTGEtVsJhbarVlye1+4=;
        h=From:To:Cc:Subject:Date:From;
        b=NKehU82LODJq5Rc+Sc6LvY0DuP9DeKLBNt2mw38k1N8TmlsjQ44xMIxRmAr+XswpV
         jVGQIylW4BpsY69NMSamJ5SpsGssiiWACFQxQBmo5tzut27bObwiyUWt71KLk6ltBC
         XapuXMoABWgX5G0PCFl4qIgfWm7BRdQpnBu6GW9Gv9bwFxxVLX6KPtS5/4YBZEW4iC
         7X2fEYmqlGINHMGXwjeOpNGi4Ar1cF8uicLpyQ+7XXB4ES/p15eD+nVST/4nqTXGJ1
         mS6oAdXHZl7a/O3LZjoabM06FCzidiFbByXxXCBeSgu5ANY4Wwvl5bt9oAaqQXbdFo
         fl5i1qo8Q4URg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        Manyi Li <limanyi@uniontech.com>,
        Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: s2idle: fix section mismatch warning
Date:   Thu,  1 Jun 2023 23:33:15 +0200
Message-Id: <20230601213319.3304080-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The acpi_sleep_suspend_setup() function is missing an __init annotation,
which causes a warning in rare configurations that end up not inlining
it into its caller:

WARNING: modpost: vmlinux.o: section mismatch in reference: acpi_sleep_suspend_setup (section: .text) -> acpi_s2idle_setup (section: .init.text)

It's only called from an __init function, so adding the annotation is
correct here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/sleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 72470b9f16c45..552adc04743b5 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -840,7 +840,7 @@ void __weak acpi_s2idle_setup(void)
 	s2idle_set_ops(&acpi_s2idle_ops);
 }
 
-static void acpi_sleep_suspend_setup(void)
+static void __init acpi_sleep_suspend_setup(void)
 {
 	bool suspend_ops_needed = false;
 	int i;
-- 
2.39.2

