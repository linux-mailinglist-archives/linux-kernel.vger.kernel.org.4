Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01663742A55
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjF2QLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjF2QLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:11:05 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1170F1FD2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:11:04 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-313f10072daso440396f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688055062; x=1690647062;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NL2SfduPuknbakdHrvQPYI8YmFq0SZdmNsLJ3kLZ9cI=;
        b=QlfLLSyhKrffp5bj7j/booxuvQr86XsATuUxXtNZqRPzTaEUjLpkCMkZUYFX/3Eb9d
         RB8o4oGbBQBwUckbJZodb4pC5WzxWVOU7s9B1BqeZva1nlh2Z7QE1Dx6LTs1OQTCV6hh
         Nj3CHmCz/Lv5ALT9jqzI3p+HDUmMoaxM2PFRHMFX+Ph/LZQ68EsF0GwrTtQwfcXyGlhA
         ztUwtHXKQAjx0v98Rh+61rKdlHvDHajSPYLioqZZPDlQNokeq1SzCWkHV8tOtRmwlk3/
         RTKNGz3TzTW1F4x2Vrm/qfbaYVyklDDBjyN0kbFDSyIhNEQ+f0+4o1sH4TmY0R49KA1n
         0glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055062; x=1690647062;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NL2SfduPuknbakdHrvQPYI8YmFq0SZdmNsLJ3kLZ9cI=;
        b=X5TiQLpziNCtrVxALDQQJRRjNOHDG5iPoNyc2VvO8iewmCU/lV/TS14sK2ZjuGxZG6
         zG6/xrrnwY8FLRmGSkotLkwzdE4mtsXsJv7EgKHXYP1G33nD1ju6MXp2JQRB+cRBX/Gb
         ZB6FcdsJNjtwtnA+ufEg/ifRB7LwUWZpq+NvVh1JTGLIViT1gjvHNpah/90l8NxjtDVH
         TH65mAjbmtPfoZHVbH8H12mYetYec9JHXESJrgoGr21NTuFXvh7ZgcolIb+vEFMdiZt2
         f1Tj4GKCdgCvXNsNHnNiJSBUswXVmpy59sVI3JdC7x35pBHz6GhBMxXltSqjAlYoivBv
         /lHA==
X-Gm-Message-State: ABy/qLbd8mlDqQSlcbqVulStazXZrz1oLz1I+WL2bgxq4s1wMdyZWvHm
        0bc3WW2N3u9M9SwNELeeqXPrANDtZtKIFwAKBQ==
X-Google-Smtp-Source: APBJJlFgdr6gdNPQ0uaRW2SqtkizbITGJ2VAih/vbVXoSl7InI+uaV1/j8N9uy6kGcGvC8g4AOUYIc2NbnXpfSZJcw==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:fb5])
 (user=matteorizzo job=sendgmr) by 2002:adf:e989:0:b0:313:f6f2:5eda with SMTP
 id h9-20020adfe989000000b00313f6f25edamr2746wrm.3.1688055062533; Thu, 29 Jun
 2023 09:11:02 -0700 (PDT)
Date:   Thu, 29 Jun 2023 16:10:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230629161044.1995505-1-matteorizzo@google.com>
Subject: [PATCH] umh: fix build warning with CONFIG_SYSCTL disabled
From:   Matteo Rizzo <matteorizzo@google.com>
To:     jarkko@kernel.org, mcgrof@kernel.org, linux-kernel@vger.kernel.org
Cc:     Matteo Rizzo <matteorizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SYSCTL is not defined proc_cap_handler is not used. This
causes a build warning with -Wunused-function.

kernel/umh.c:497:12: error: unused function 'proc_cap_handler'
[-Werror,-Wunused-function]
static int proc_cap_handler(struct ctl_table *table, int write,
           ^
1 error generated.

Fixes: 861dc0b46432 ("sysctl: move umh sysctl registration to its own file")
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 kernel/umh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index 41088c5c39fd..1b13c5d34624 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -494,6 +494,7 @@ int call_usermodehelper(const char *path, char **argv, char **envp, int wait)
 }
 EXPORT_SYMBOL(call_usermodehelper);
 
+#if defined(CONFIG_SYSCTL)
 static int proc_cap_handler(struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -544,7 +545,6 @@ static int proc_cap_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-#if defined(CONFIG_SYSCTL)
 static struct ctl_table usermodehelper_table[] = {
 	{
 		.procname	= "bset",
-- 
2.41.0.162.gfafddb0af9-goog

