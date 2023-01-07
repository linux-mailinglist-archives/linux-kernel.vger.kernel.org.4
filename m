Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE93660E49
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAGLhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGLhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:37:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE3A6DBA0;
        Sat,  7 Jan 2023 03:37:13 -0800 (PST)
Date:   Sat, 07 Jan 2023 11:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673091432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0TiEt6R/k7PhmvnMvJLv7VpfpmxF8iccSTw/Z9XGG4=;
        b=VFSwUTHAnjIoOcAGBHqGIIfpJxSS2P94dwXHwnO2HDnncp106U1zisuAFpqzDDMwlwMSh7
        WFGeiuXexjQv4ouDoap48o2ohuRDzBKGYfTFA5fegXMCREtvrH3Ae21HbePBqGJdbTpkbc
        4D6F2oEQMjAf/3hcDFr+zzczh+c30DHo7xBkKQFKENnFqBBee/nKmt9Nvh5jg/BzqkfYip
        k6GlzNw6VALXOK1+oATBgGTvMhDukSbdqque/drVE6dY8zXWdrvX4XmVdKo0NBsliMs1zT
        W+47ozGhMw2qPpX3kkqhw9VFrKkS5xeW5aezBSgtY0Uwkt9odaWfLxzxj8wnNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673091432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0TiEt6R/k7PhmvnMvJLv7VpfpmxF8iccSTw/Z9XGG4=;
        b=n9VK123stcS1SNnrXfZd61PKSC7tgjyp/zi1IO/GG3I2J6bXRFImdtoSfUouSuNlrn8PbW
        nfxIrkjpDx9ocyDQ==
From:   "tip-bot2 for Xu Panda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/mce/dev-mcelog: use strscpy() to instead of strncpy()
Cc:     Xu Panda <xu.panda@zte.com.cn>, Yang Yang <yang.yang29@zte.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202212031419324523731@zte.com.cn>
References: <202212031419324523731@zte.com.cn>
MIME-Version: 1.0
Message-ID: <167309143194.4906.10220848041501270532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     7ddf0050a21fdcc025c3cb1055fe3db60df1cd97
Gitweb:        https://git.kernel.org/tip/7ddf0050a21fdcc025c3cb1055fe3db60df1cd97
Author:        Xu Panda <xu.panda@zte.com.cn>
AuthorDate:    Sat, 03 Dec 2022 14:19:32 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 11:47:35 +01:00

x86/mce/dev-mcelog: use strscpy() to instead of strncpy()

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/202212031419324523731@zte.com.cn
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 100fbee..a05ac07 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -105,8 +105,7 @@ static ssize_t set_trigger(struct device *s, struct device_attribute *attr,
 {
 	char *p;
 
-	strncpy(mce_helper, buf, sizeof(mce_helper));
-	mce_helper[sizeof(mce_helper)-1] = 0;
+	strscpy(mce_helper, buf, sizeof(mce_helper));
 	p = strchr(mce_helper, '\n');
 
 	if (p)
