Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D86A3A00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjB0EGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0EGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:06:42 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736B11141
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:06:40 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso2874526ots.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iZgPnDq1wPjqueobf/M4oDcAkjldH92kHB/el5/Fzc=;
        b=j5tFynW9kqal2hVWICOdqlsKcD+vVI7wEoFzxbjy2/xCQTj05Uai+taTnQRXGpsyI8
         yMESjLj9sBUznf1FOaGSt3tR/+R/d0mqELmgYbyWHXeosHGmOGjuxLik1Fo7qzLBQUPO
         ekV/jARW45eWDoe8h06Kiu6LvwbmkhdGzlTML7MJhSS2+BUErBovbI2KEkA8doS/IyzB
         YFnrYs9GwnWkmn5V478Tjvxd6NW5PLcnjsD8KDSu/0e8kl/gbVqHuqW+mCxzZyTIUrSo
         XXFn1QZ710zsozmnsfDTFX8sHtMFkJrZHWQZdb+cVN6W0tEv8Z8QFbpF8eoVtnNw6Hin
         MWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iZgPnDq1wPjqueobf/M4oDcAkjldH92kHB/el5/Fzc=;
        b=51eCq1MhJOK0iHXcCfzCLL4SUAJ6ssCCx1Fxx4dtPjpm1Nko/8ca8ep6FW9DteTwQn
         T1CxVvNfLv/0YwkommPUevO6KEFbQ//pI2S1CYGiBRB/Ao4DU3hBQWNhLHUtw63B8QsV
         hzTsqGMAOBELjeXplcZR8YcyYZd925oKALg8GV41JIScNPFlUcAvcNv1sGKvBeNiAbmv
         jebHy/hiLlUseaky0pa/GFQabcWj60kFrmssevDqcbGYf0kzIWRKajW4/rC5U8xRrq9p
         w8biEv1+vqianQo3J8lXZ1gRjUgO2PgXIfPokhJylZxe7AVmfe8NDknR6uqD2Y/rNnRx
         c16g==
X-Gm-Message-State: AO0yUKXDXmU3PiudfXFfAFRilQ1Xp8ZJgFyLwZhZ5nzts79tRKlqk02d
        f0/SL377fU9na+GH9CL8lBdCkldkFG3AjTvZ
X-Google-Smtp-Source: AK7set8p4y0b4YAe33oiCrG1LUD1gNe24YhWPYU7qv5koyxlDrt3YPn3c6QLAh0DJAZGAAl+4OXogQ==
X-Received: by 2002:a9d:37c6:0:b0:688:4670:e964 with SMTP id x64-20020a9d37c6000000b006884670e964mr6856648otb.27.1677470799390;
        Sun, 26 Feb 2023 20:06:39 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b00690dd5e7345sm2219589otq.26.2023.02.26.20.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:06:38 -0800 (PST)
From:   Glenn Washburn <development@efficientek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Glenn Washburn <development@efficientek.com>
Subject: [PATCH v3 1/2] scripts/gdb: Correct indentation in get_current_task
Date:   Sun, 26 Feb 2023 22:05:59 -0600
Message-Id: <2e117b82240de6893f27cb6507242ce455ed7b5b.1677469905.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1677469905.git.development@efficientek.com>
References: <cover.1677469905.git.development@efficientek.com>
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
index 9ee99f9fae8d..e8d2a62ff119 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,16 +163,16 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-         var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
-         return per_cpu(var_ptr, cpu).dereference()
+        var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
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

