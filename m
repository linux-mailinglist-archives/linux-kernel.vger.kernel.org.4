Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315C25F1061
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiI3RBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiI3RBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:01:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C16DE7E06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:01:09 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d7-20020a170903230700b00177f6dd8472so3597308plh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=6okhiTCK9jSdHpUWA9dn5fwr9rkZfmJ2cAkySXPosdk=;
        b=UprhvT1gUl9XVy9KzrcA3UVj3VY8qe5UoDytgMGcKOSXj4EJzbS7fAygk50tyIbUUn
         103VszfAgRBAe/V9OBZeXtf50QIEO0L1YB7FFjkHANzUKm1TK2JhpXgYrSnLbxzRmiXC
         3GhOadqpgvnc3Uzd+SmjPZTZVqxH6Y2iKgwDTd9awX18KwpKT7fARo/nAKJ678AtOQdg
         3DI6kbahpH/a0EUjjcsII0Tzs8fsRjJj8plL3eZHi6Y67/X5P4GTbVtxixX1OUq8Pnu4
         qKl3j33okRuBwH7RjsnNu1t9tD/4SbeitOlmHKXwq3eOvvmxmNWCcO+B95XG8bU5Lday
         zBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=6okhiTCK9jSdHpUWA9dn5fwr9rkZfmJ2cAkySXPosdk=;
        b=TgAt9oKKSyRrK6OKhxkTZn2x6OqYNAL2N6pXfElp1jek9JbnR/kKpx4XOl/cHbKvLk
         50P9FI208USBr6C90uGo/D93FnElDFhnb6CXWxESay3fOOvhLY1VAnmAGfjtjjlsYOup
         bSMwLxIwtUuJIGWS9SX8EgCIg/ht/87IE43KcefnyQLsPCDSQU7ex3PNcY11/NTzhrBD
         i5mQ1thzgL+XHAgCo+NZrfre/boXs22HakfaaJ7mFO5O7UQbZr4ZkVl6jiqTQyrvJ4kY
         MaDm1krH/bWLf7wbX+D4nqGzWTKKZoCeyIFiWWgrs8Hw/CBFORbBQwfgMp2h+9Humjzw
         VzJQ==
X-Gm-Message-State: ACrzQf0eiLkePVpPi6p6hsXVsotT6ei3TclMElje54uiBGFqc/eiMV0L
        ni1gfKraJ633Vp9ka9ijyO+VDoL1vGE=
X-Google-Smtp-Source: AMsMyM4CT/vICWb1O+N8Pv7TsdlireG2TipVR8DAA+oiqscWrLynLk40Qb3lfYU6bnsKDFG1ZJdgsMLwZRI=
X-Received: from tzukui2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:58ad])
 (user=tzukui job=sendgmr) by 2002:a17:90b:4a52:b0:205:df8f:db94 with SMTP id
 lb18-20020a17090b4a5200b00205df8fdb94mr20656393pjb.61.1664557269023; Fri, 30
 Sep 2022 10:01:09 -0700 (PDT)
Date:   Fri, 30 Sep 2022 10:00:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930170058.2645213-1-tzukui@google.com>
Subject: [PATCH] lockdep: Allow tuning tracing keys constant.
From:   Ryan Huang <tzukui@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ryan Huang <tzukui@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa made a change for tuning lockdep tracing capacity constants
[1]. He created following tracing config constants:
  - LOCKDEP_BITS
  - LOCKDEP_CHAINS_BITS
  - LOCKDEP_STACK_TRACE_BITS
However there is a missing one for LOCKDEP_KEYS_BITS. We can see this is
also hitting the upper limits in [2].

[1] https://github.com/torvalds/linux/commit/5dc33592e95534dc8455ce3e9baaaf3dae0fff82
[2] https://syzkaller.appspot.com/bug?id=df466e1151a7e45dd880d8c7033f1ad48acebfb4

Fixes: 5dc33592e955 ("lockdep: Allow tuning tracing capacity constants.")
Signed-off-by: Ryan Huang <tzukui@google.com>
---
 include/linux/lockdep.h | 2 +-
 lib/Kconfig.debug       | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1f1099dac3f05..3bb1740296559 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -82,7 +82,7 @@ struct lock_chain {
 	u64				chain_key;
 };
 
-#define MAX_LOCKDEP_KEYS_BITS		13
+#define MAX_LOCKDEP_KEYS_BITS		CONFIG_LOCKDEP_KEYS_BITS
 #define MAX_LOCKDEP_KEYS		(1UL << MAX_LOCKDEP_KEYS_BITS)
 #define INITIAL_CHAIN_KEY		-1
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d3e5f36bb01e0..d15024bd14f1d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1398,6 +1398,14 @@ config LOCKDEP_CHAINS_BITS
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
 
+config LOCKDEP_KEYS_BITS
+	int "Bitsize for MAX_LOCKDEP_KEYS"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 13
+	help
+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_KEYS too low!" message.
+
 config LOCKDEP_STACK_TRACE_BITS
 	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-- 
2.38.0.rc1.362.ged0d419d3c-goog

