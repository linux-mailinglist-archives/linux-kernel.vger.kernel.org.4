Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB973B9E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFWOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjFWOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:21:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D028C270D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:21:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565a33c35b1so10324977b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687530063; x=1690122063;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=icSfLnxI7/48qNwmGJBkSMxp3qwuKIwJ3BuTt1ZLjoY=;
        b=3snnT+h8qhuo8YOgeQaIWdH9iGFHWdleURDxWax4fNp0K49eARf65mJlWzgZwNQf7+
         oK3E77Srn8QU9HpY4vZF0+pXOttih+245iUd86WOeG+iiR3e5pJIB6jsqzMIYINupFNh
         GDeq61eDKEvupmJb5LtYFhsaNUTMOw9kvtjxlrbJrUrXowWQZ0W2VFYiYNnVF5ZYnwXf
         EeGMB+jL+XYQoUdBMg5RmKtMuybsKEdW9JNezHfE7kNGu/suaSBUx38g5ssN5bSaxHsM
         Xhvwe7OyZIGS2UsctPrXl98grBeRmfCzXag78HRHA2Wkr7bPHjpPXcbB8ifM3UpAOW9P
         Ui0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530063; x=1690122063;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icSfLnxI7/48qNwmGJBkSMxp3qwuKIwJ3BuTt1ZLjoY=;
        b=SmPBUB+UO/AZsujgLFO+h/+/5k/xWbNmQQVew8o+f3MqxizJtgQJJjNluAXs9+hMUU
         Iuu+tW32P/hD2nFDoVdEMZZkP5Nopm6JHCOgs22P+NJCxwhmi1VhlMfTZ7OucC4sLlZg
         Qq6+cmsklubhYEYI4vEtDZaLYrxR5SHqJlMSF+XSz+PpkI8ctubkChLIFPZMzrHI2rkT
         kp9p4IBidBQpe6B1rNzb6ake3el3mjD21MdR0gjtB8JwEI6/YAhgu2l1kZ2iFjLVTZPL
         3WQhSCTacWIPCEvtJO/+nExqvpILcswmt0UQh48Z5CycwDf7jYpek7rN+VEG+orQGOPG
         MxuQ==
X-Gm-Message-State: AC+VfDwHTOzYIFSyu2rT5D23g7f8WCMQ0RWh/lbvPIjJUmM6QXTAEEi2
        +Tam+AQxWO/HCnISrjLBbiZb9FSx3kqM
X-Google-Smtp-Source: ACHHUZ4O0GmC/7kQGSHxouOGK5S5c29B8rJjWkjXhPsOd7hS9AV4GSHHKBPKUGkbkQvkcr0GKPd9cz4tDKr4
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:5d47:84a:2819:bba4])
 (user=kyletso job=sendgmr) by 2002:a81:ac42:0:b0:573:8316:8d04 with SMTP id
 z2-20020a81ac42000000b0057383168d04mr4567622ywj.4.1687530063033; Fri, 23 Jun
 2023 07:21:03 -0700 (PDT)
Date:   Fri, 23 Jun 2023 22:20:54 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623142054.3945121-1-kyletso@google.com>
Subject: [PATCH] sysfs: Replace %p with %pK in the warning of sysfs_emit*
From:   Kyle Tso <kyletso@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     badhri@google.com, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/core-api/printk-formats.rst, kernel pointers
need to be printed with %pK format specifier to respect kptr_restrict in
sysctl.

Also replace the function names in the strings with %s and __func__ as
checkpatch.pl suggested.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 fs/sysfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index a12ac0356c69..56712f0886ef 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -732,7 +732,7 @@ int sysfs_emit(char *buf, const char *fmt, ...)
 	int len;
 
 	if (WARN(!buf || offset_in_page(buf),
-		 "invalid sysfs_emit: buf:%p\n", buf))
+		 "invalid %s: buf:%pK\n", __func__, buf))
 		return 0;
 
 	va_start(args, fmt);
@@ -760,7 +760,7 @@ int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
 	int len;
 
 	if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
-		 "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
+		 "invalid %s: buf:%pK at:%d\n", __func__, buf, at))
 		return 0;
 
 	va_start(args, fmt);
-- 
2.41.0.162.gfafddb0af9-goog

