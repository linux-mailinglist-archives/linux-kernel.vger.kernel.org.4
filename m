Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59BA666ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 06:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbjALFZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 00:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjALFY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 00:24:59 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6A65C6;
        Wed, 11 Jan 2023 21:24:57 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 906BF1A00A1C;
        Thu, 12 Jan 2023 13:25:11 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 38brvE-IQqH0; Thu, 12 Jan 2023 13:25:10 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 8B4461A00888;
        Thu, 12 Jan 2023 13:25:10 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     rafael@kernel.org, pavel@ucw.cz, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] power: hibernate: optimize function structure
Date:   Thu, 12 Jan 2023 13:24:53 +0800
Message-Id: <20230112052453.3365-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goto statement jump is not required at the end of the if statement
block, because it will be executed to the lower part of the goto
statement.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/x86/power/hibernate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 6f955eb1e163..936558c4e821 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -210,8 +210,6 @@ int arch_resume_nosmt(void)
 		if (ret)
 			goto out;
 		ret = cpuhp_smt_disable(old);
-		if (ret)
-			goto out;
 	}
 out:
 	cpu_hotplug_disable();
-- 
2.18.2

