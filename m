Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E328D69B759
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBRBNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjBRBNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:13:05 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBD30B04
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:13:04 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d10so2464964qtr.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wr2zCQ1Tc928nsK2G1LdnDMg6afLnDzp3aXmHYm4R0Y=;
        b=3LZZJ8PIaPV1i8wlos2B1/poAFMGi8fZ5Nof9/vczbtCLkM78UqClyya28OBzzaKR7
         z6IpNmM6nhEJwHO4tWqMkZO9VOZVisZDUg6G2R0fcC9TkXazH2qgLTDhoF6sv0JDM78u
         P1IcNb7mqTdQ38p2BTPXMtG8U41IFXxbAQzUS6YEFYE0pvvKqv+ZgqipbauUoSs3lzQ2
         mZ5drufEBeosri5ekoMf04z7BUkyVKIa8oRmP0mUajiyPQtNEaRbfkonpqU3+blb8FyB
         sZek0wP/j/23QFy3v8YA3MePixw01UdK+9L3koCFM4afKjiF7ELGfqJxUrdbUxh/grrs
         GOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr2zCQ1Tc928nsK2G1LdnDMg6afLnDzp3aXmHYm4R0Y=;
        b=5nNheGrDnbofOj/EA5pyXQam0gyZRLQ9VfT4H4yBTzjjgtW4zijdZYWkOxi8LAw3oa
         bkjtnz7m5HZ1Ri4FAfH3rhpXkX6VfvRyPsDI36OaaA8/3QeBBp405QiPS6mc+sZFxdqu
         0U9GCY1r1qJo5OQjfryF2ydfLzlgDg8se6G/PanNIS+YBLsffQUIqpoEhXdBKKs0mLFs
         mcks3yeUZU2HDJfbLEpmUTA0KjPVSvCDr8iiueiyJUtCj4vlIxHYNGc+cICOwgpnRYh0
         n15qhPQeKmWDiOT3s9Q4Oot7/CyhP7J1TmvLp9UuTzLLTeBG5aMaIu0wp7kv67TEOCsk
         TdbQ==
X-Gm-Message-State: AO0yUKV1rZ2X+W5fnsMLgN38TuVikegW4Fz810bUeTwWPEB/VjsieHOo
        t1c0WOMn+dx4JOJuPRi9hdDwUgE/VS2qa9D9
X-Google-Smtp-Source: AK7set9mecnmhN9lQs+1mh2KjpWEkvGt+HvEwPAWLjRIdx2QXia4RXM4X8Haemgi+/3jWKRyYbSkRg==
X-Received: by 2002:ac8:5a41:0:b0:3b9:b450:61f6 with SMTP id o1-20020ac85a41000000b003b9b45061f6mr5934166qta.62.1676682783430;
        Fri, 17 Feb 2023 17:13:03 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a024d00b006f9ddaaf01esm4268119qkn.102.2023.02.17.17.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 17:13:02 -0800 (PST)
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
Subject: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Date:   Fri, 17 Feb 2023 19:11:52 -0600
Message-Id: <cover.1676532759.git.development@efficientek.com>
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

Added suggestions from Jan.

Glenn

Glenn Washburn (2):
  scripts/gdb: Correct indentation in get_current_task
  scripts/gdb: Support getting current task struct in UML

 scripts/gdb/linux/cpus.py | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  f33ebe524590 ! 1:  c5a916e094d9 scripts/gdb: Correct indentation in get_current_task
    @@ Commit message
     
         There is an extra space in a couple blocks in get_current_task.
         Though python does not care, let's make the spacing consistent.
    +    Also, format better an if expression, removing unneeded parenthesis.
     
      ## scripts/gdb/linux/cpus.py ##
     @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
     -             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
     -                                "while running in userspace(EL0)")
     +        current_task_addr = gdb.parse_and_eval("$SP_EL0")
    -+        if((current_task_addr >> 63) != 0):
    ++        if (current_task_addr >> 63) != 0:
     +            current_task = current_task_addr.cast(task_ptr_type)
     +            return current_task.dereference()
     +        else:
2:  8c3db2291f58 ! 2:  683d10e752cd scripts/gdb: Support getting current task struct in UML
    @@ Commit message
         A running x86 UML kernel reports with architecture "i386:x86-64" as
         it is a sub-architecture. However, a difference with bare-metal x86
         kernels is in how it manages tasks and the current task struct. To
    -    identify that the inferior is a UML kernel and not bare-metal, the
    -    symbol "uml_kmalloc" is checked for. If it exists, then do the UML
    -    specific way of getting the current task struct.
    +    identify that the inferior is a UML kernel and not bare-metal, check
    +    for the existence of the UML specific symbol "cpu_tasks" which
    +    contains the current task struct.
     
      ## scripts/gdb/linux/cpus.py ##
     @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
          if utils.is_target_arch("x86"):
     -        var_ptr = gdb.parse_and_eval("&current_task")
     -        return per_cpu(var_ptr, cpu).dereference()
    -+        if gdb.lookup_global_symbol("uml_kmalloc"):
    ++        if gdb.lookup_global_symbol("cpu_tasks"):
    ++            # This is a UML kernel, which stores the current task
    ++            # differently than other x86 sub architectures
     +            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
     +            return var_ptr.dereference()
     +        else:
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
     +            return per_cpu(var_ptr, cpu).dereference()
          elif utils.is_target_arch("aarch64"):
              current_task_addr = gdb.parse_and_eval("$SP_EL0")
    -         if((current_task_addr >> 63) != 0):
    +         if (current_task_addr >> 63) != 0:
-- 
2.30.2

