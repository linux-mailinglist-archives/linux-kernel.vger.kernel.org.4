Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE66A3A01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjB0EGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjB0EGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:06:43 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35DA10AB2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:06:42 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id cc12-20020a05683061cc00b00693daa9016fso2897760otb.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flnML7b+bSQRGsvQ8NZIpa8v6ijknaB9o2IhQpg86OM=;
        b=HydNKyWBQ6INfb8aCWugSFRRQyXuUfSnrsfrPH0qpTanBmBdOmE1ChbsPcS5RlCnAU
         L7YgU3avoC/d1NOa46vC/Z+gc+YxTaWNe26fm4YZo8BuRs119GWsZVkQnITEc9jwc0kX
         4sVWLWm601f2CzphpW/FitMhVF2j+c/f23fPhsMcXbyEvyIuBJGiDKDo7l7DW6YOq09H
         X5SB4lV3tIB46+TqV1VsXybHxVk1T84M+hsxfnC+YU97M/vKPdhsTHYx/nqM1G7SiU4/
         CMPuvLCgFmIwyxgHgd5J7sXnfAD48nipqDexhVH0QL/7pBPar+sw5XaUQ9wMO6GnjsQF
         bczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flnML7b+bSQRGsvQ8NZIpa8v6ijknaB9o2IhQpg86OM=;
        b=W0pEkPyqn78OiM/aWBSSreSjlZX/1dge9s8Q9oueUXY/E0vry6u47VA/UD66lVPGfw
         wSJW5UAJ49IrZ9LTcCT7oKjVDsN8jdZys3xxI3tF7Gfi0qLtFlOf9I+RHTWjzGCSJxWO
         MnzMIyBsYGNsMF3O/cyeR9udsy7DFoEf6/z+rPzJzvaYS0TYrG3J63vt052VchfrqjYp
         VsbENQEI6gGEa9NQ1tYA3q18PpaJ9Y3hAMpiJuja1dKnq5QQQ5n2TMtswZoroWqvYWOq
         BlUGYRwMYBKsnutFaCHWevrsLGD1jHQk+4QR1UxcSJN6rR6PQ/McC+yqs54LZ8KaseHy
         nlFw==
X-Gm-Message-State: AO0yUKUdoq9RohJe3k84FIQSu6IPtUI0+nzvLMnn9NPG3nl3lo3IX5aR
        spiLWw4mQM4/huzMnFbNkJBOPJZYGQWv8qMq
X-Google-Smtp-Source: AK7set9J0nTW4hS4HuqvLTM2KAs1wmypF/nBiEPT9XNeaZovonDhj8PaKB0xQUZm95HarPWlm8HBNg==
X-Received: by 2002:a9d:1cb:0:b0:690:edd1:a86 with SMTP id e69-20020a9d01cb000000b00690edd10a86mr12439347ote.7.1677470802128;
        Sun, 26 Feb 2023 20:06:42 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b00690dd5e7345sm2219589otq.26.2023.02.26.20.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:06:41 -0800 (PST)
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
Subject: [PATCH v3 2/2] scripts/gdb: Support getting current task struct in UML
Date:   Sun, 26 Feb 2023 22:06:00 -0600
Message-Id: <b839d611e2906ccef2725c34d8e353fab35fe75e.1677469905.git.development@efficientek.com>
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

A running x86 UML kernel reports with architecture "i386:x86-64" as
it is a sub-architecture. However, a difference with bare-metal x86
kernels is in how it manages tasks and the current task struct. To
identify that the inferior is a UML kernel and not bare-metal, check
for the existence of the UML specific symbol "cpu_tasks" which
contains the current task struct.

Signed-off-by: Glenn Washburn <development@efficientek.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/cpus.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index e8d2a62ff119..255dc18cb9da 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,8 +163,14 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-        var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
-        return per_cpu(var_ptr, cpu).dereference()
+        if gdb.lookup_global_symbol("cpu_tasks"):
+            # This is a UML kernel, which stores the current task
+            # differently than other x86 sub architectures
+            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
+            return var_ptr.dereference()
+        else:
+            var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
+            return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
         current_task_addr = gdb.parse_and_eval("$SP_EL0")
         if (current_task_addr >> 63) != 0:
-- 
2.30.2

