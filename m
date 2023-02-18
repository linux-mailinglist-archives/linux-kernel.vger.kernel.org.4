Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9B69B75A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBRBNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBRBNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:13:08 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE02F75F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:13:07 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id u22so2289468qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxWY83X/UsingK6RL95Hy3CzpqO3q6ngg34P0jTRocg=;
        b=WIN99IGsdtMz+H4Hv/qbj5Re2qRTd9H0KYj0LkUK3EChVco0HZL+ADh0IFoaIRIpup
         1p7nrMauLq1lLWTK3pYnVq13gLRoNeqGnpMa6Ii1aNIpNQi2/ipm/sBqKnyIpjcMrQLE
         v1W8NcZUC7WWzWce76eT8bnOm6xzNabSau6112FYd+bpe+JkJjgF8WPfWdv6BJ83Zc43
         tpJPdGmVf0F6gDkkuAYm8yy1xe2Wph6ZJKhY4jHj56SF5kxev2SgZVv91tjLRsEnZMVw
         rKojYiHirtaWrcAv9O+qoSszAOteOVx8j+JhwlANHLmDtLhnuUH7jcswL8d279c6mEOi
         3kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxWY83X/UsingK6RL95Hy3CzpqO3q6ngg34P0jTRocg=;
        b=dlXszmOdpKDMYvUGAr7ZxRa4fqDQk76+HKbBHicS5YMc56PD0189gntZUoiRBoSDkO
         v1exv1Rf8Fw6p20fhN1gBvt2sNtxg5LS9jWu6XjGf55DtcIpqlFW9wBPcQvj9xPl433O
         lvXqnOrqyKLleX6CdA1tczFrT+/VBkN4BYHyjHcUYi/71aGcd0dj6u1onwPXrlZjbApl
         ZEe55z9sKWdZMRjlBNTY3x5R/kJf3BCil+rIiPzHHg2AKwfFJtIFeTh4RzMbeLRzq1vg
         ssxI1kjZ82uMHWN7Lt6IA8oA4GQrOXZJTu7jqtpuV2bZEAjFwojDy9TG6p6/Rpz54+2R
         Gy2w==
X-Gm-Message-State: AO0yUKV39iMvi/PlmjbDDUG811rkgWbvxGNefRIXNN1Y5h8boRcOHcvV
        qmVVCuxwrsGg2zOnkDG2cBdXuw==
X-Google-Smtp-Source: AK7set8hC9JiVA8qJhjEM5Kh6B0VruCtsUFsRT/MMcFZeeDzKDCiXVqSFhl1hOmJ0S7IfX7njGlbzw==
X-Received: by 2002:ac8:7f44:0:b0:3bd:14c:c39b with SMTP id g4-20020ac87f44000000b003bd014cc39bmr6205860qtk.25.1676682786337;
        Fri, 17 Feb 2023 17:13:06 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a024d00b006f9ddaaf01esm4268119qkn.102.2023.02.17.17.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 17:13:05 -0800 (PST)
From:   Glenn Washburn <development@efficientek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Glenn Washburn <development@efficientek.com>,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH v2 1/2] scripts/gdb: Correct indentation in get_current_task
Date:   Fri, 17 Feb 2023 19:11:53 -0600
Message-Id: <c5a916e094d9c7acd551030b5dd793203046fea5.1676532759.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
References: <cover.1676532759.git.development@efficientek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extra space in a couple blocks in get_current_task.
Though python does not care, let's make the spacing consistent.
Also, format better an if expression, removing unneeded parenthesis.

Signed-off-by: Glenn Washburn <development@efficientek.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/cpus.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..3e02a1866751 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,16 +163,16 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-         var_ptr = gdb.parse_and_eval("&current_task")
-         return per_cpu(var_ptr, cpu).dereference()
+        var_ptr = gdb.parse_and_eval("&current_task")
+        return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
-         current_task_addr = gdb.parse_and_eval("$SP_EL0")
-         if((current_task_addr >> 63) != 0):
-             current_task = current_task_addr.cast(task_ptr_type)
-             return current_task.dereference()
-         else:
-             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
-                                "while running in userspace(EL0)")
+        current_task_addr = gdb.parse_and_eval("$SP_EL0")
+        if (current_task_addr >> 63) != 0:
+            current_task = current_task_addr.cast(task_ptr_type)
+            return current_task.dereference()
+        else:
+            raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
+                               "while running in userspace(EL0)")
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
-- 
2.30.2

