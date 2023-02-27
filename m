Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2AD6A39FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjB0EGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0EGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:06:41 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF0510ABA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:06:37 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17227cba608so6250379fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NY3l/s5VQm6VcHLyL10UBGGbYoT2GbHYKXZoazGbGQ=;
        b=4qhtQ2kheDnpHE9FFFzqrfE2x+dSjQm8Mbdrez47ES8OGfHOGTo33J6l0+jvwR/CUl
         frX8+8C9eRptVWrhKZ5tQE653DA2JTheX9OBSKUMR05W1tqHIC8Z19/GAWShZ5NQUnsM
         BiePDWIh6PVq3Z8R8LBSRuMdLG2wECYCM/jHmVJ3+KOJzUKCRl4J3w83PaPbUGOReGJt
         VhpRZTW6WzjSOSWgBW+u2YaSH//VHlZ5c9s4zKdWK+kKz5R9L/hEb/AOBARqjNMeiK5m
         VD7lTSP4ToMdP3GEiROVI6JMYF5NmRNx7ympf8peALnBoJ+jSGoYK4VBIRFa378kvEwU
         t62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NY3l/s5VQm6VcHLyL10UBGGbYoT2GbHYKXZoazGbGQ=;
        b=PchOCbZelSL0BEJ3cZV48ZFB+3JCU1HO1qjvC1y9HQgNyeAfcfjYD/yy2AspAeY8UU
         q2J73ioTAYPXD2KAVyTfIpYiIFiU54lH0KiIK3LC93zrG7fhWpoFbX76ZlAgR6Mzurth
         meT79f+ca8/cmfEUZjAmmCpC2dpvokkJowJWf0sPe+/nX2XlyL10oD/KZxPvgSOoPekv
         772evh1rAZ8jIkI4Rn9PkC4gfJCCDqw/VhzW8CL2eOQCG+SJVjx/59yCWoi1S9tuHFPw
         wbS7QJtev0stt3tnB0jjMeTtTDqJtz5VWUfYIRu2kSWVnjDkEiR4yUzdwuyUr3dXrhGe
         5V/Q==
X-Gm-Message-State: AO0yUKUMb59vc7CeWtUM8nSZL88wT0QhbC66Dti829rUh/zHP+1JmmRv
        OElKH71x+mY1LQp+dKUTZ8A7Ib3zUkw4nByZ
X-Google-Smtp-Source: AK7set9I9pJi9niHzngrb+YDyd1WgNevIXHBtFNjsLnj4BakBocFpMg3ebWR16yLK5HVOgaU5sAjig==
X-Received: by 2002:a05:6871:68d:b0:163:535d:4a86 with SMTP id l13-20020a056871068d00b00163535d4a86mr18651384oao.22.1677470795611;
        Sun, 26 Feb 2023 20:06:35 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b00690dd5e7345sm2219589otq.26.2023.02.26.20.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:06:34 -0800 (PST)
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
Subject: [PATCH v3 0/2] GDB: Support getting current task struct in UML
Date:   Sun, 26 Feb 2023 22:05:58 -0600
Message-Id: <cover.1677469905.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
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

Changes in v3:
  - Rebase onto tip.

Changes in v2:
  - Use cpu_tasks symbols instead of uml_kmalloc when determining if the
    kernel is a UML kernel.
  - Improve formatting.

Glenn

Glenn Washburn (2):
  scripts/gdb: Correct indentation in get_current_task
  scripts/gdb: Support getting current task struct in UML

 scripts/gdb/linux/cpus.py | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  918bc1299bdb ! 1:  2e117b82240d scripts/gdb: Correct indentation in get_current_task
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
          task_ptr_type = task_type.get_type().pointer()
      
          if utils.is_target_arch("x86"):
    --         var_ptr = gdb.parse_and_eval("&current_task")
    +-         var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
     -         return per_cpu(var_ptr, cpu).dereference()
    -+        var_ptr = gdb.parse_and_eval("&current_task")
    ++        var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
     +        return per_cpu(var_ptr, cpu).dereference()
          elif utils.is_target_arch("aarch64"):
     -         current_task_addr = gdb.parse_and_eval("$SP_EL0")
2:  93fc6584ea16 ! 2:  b839d611e290 scripts/gdb: Support getting current task struct in UML
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
          task_ptr_type = task_type.get_type().pointer()
      
          if utils.is_target_arch("x86"):
    --        var_ptr = gdb.parse_and_eval("&current_task")
    +-        var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
     -        return per_cpu(var_ptr, cpu).dereference()
     +        if gdb.lookup_global_symbol("cpu_tasks"):
     +            # This is a UML kernel, which stores the current task
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
     +            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
     +            return var_ptr.dereference()
     +        else:
    -+            var_ptr = gdb.parse_and_eval("&current_task")
    ++            var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
     +            return per_cpu(var_ptr, cpu).dereference()
          elif utils.is_target_arch("aarch64"):
              current_task_addr = gdb.parse_and_eval("$SP_EL0")
-- 
2.30.2

