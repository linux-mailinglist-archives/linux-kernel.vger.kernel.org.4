Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFCF5FAAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJKDGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJKDGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:06:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC036F57D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:06:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 128so4011223pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LntH9WNdN7rlKiIZmbv0llXeNaMA97xMVBBJomnYFAw=;
        b=iCyHHadEcKG7exO047ddkuBqb3lPTi9GjS891kx7T06fJ4u7f7hXdDm9AM591WBKKR
         xudV5I+tk5bzfJ7V/jQa2qZ+beB1YwjCo6/8P3WdCB4GR0l9JVbEOrJm1R/k2xRbTibR
         cnwvYCePgJlgpf1M+qSJ8aHd7HRrhwFvW47qEdYNUe+0W3/RVCtg12+9WytokuRfTgNn
         nSN0nVyvDyTSB6x5g8zjdu5kB7hN6szIF9TjEilIiZk9P9ovSROmIHlqoqN+b4g/VVKx
         7ADtRub/FY1VNzt+uvBFklUzjSO/+dXp5ef3bd3PwUo55hF7rz6XttdiB5W8r/CiPkEe
         Ur7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LntH9WNdN7rlKiIZmbv0llXeNaMA97xMVBBJomnYFAw=;
        b=3H7kDJoXfzjOR7SKf/e+rZpU0FDaGU+KOxLdW0hK3F/PN93AWJoJVmKs6g4T0A59f8
         V8A9J0Maqz3qBkEiSNHyAydMmgdMcc5xMLY2Us4h8K5DzIOKKWLr6qHKKYSiSsXam3Lu
         QHtx3rWcWU6w4PPcDW0PKvBxjgC6nAFdyvajquH7pl8xV8fNjCoVQeR/Au55fPiN590Z
         WqIJEpvt2oOHODXCynR6S+PG+qC3OVuwmlKYIm9QyhJNfvC+YwD2yJ3JKRcFBCFgd1+I
         LY8jH/z62BBmNOkNKszPp/M7RkjG0+Guto3Ye7ojY3C28FQrmuH0FgElimqVb/cOgOzb
         9Udw==
X-Gm-Message-State: ACrzQf2Eh8hBa+d4JV6m6DZchzfwDQcfGJRoa2YjaA4vKhGmss7b0LEC
        aELXZprjcCkG9VW/wYD64An+Y/X22PPCDu0u
X-Google-Smtp-Source: AMsMyM7Mv2/GNhyFbWWfZWfTLwfKaTJ7qIHKn7l29pWflnguej7EdDfjWwZvzExkiJEW9Gc2pGZ3cw==
X-Received: by 2002:a63:942:0:b0:43c:428d:16a9 with SMTP id 63-20020a630942000000b0043c428d16a9mr18639343pgj.423.1665457603330;
        Mon, 10 Oct 2022 20:06:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m10-20020a638c0a000000b0043c22e926f8sm6845769pgd.84.2022.10.10.20.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 20:06:42 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     sboyd@kernel.org
Cc:     jstultz@google.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] timers: replace in_irq() with in_hardirq()
Date:   Tue, 11 Oct 2022 03:06:37 +0000
Message-Id: <20221011030637.322874-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..f65e3e00ef61 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1838,7 +1838,7 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	rcu_sched_clock_irq(user_tick);
 #ifdef CONFIG_IRQ_WORK
-	if (in_irq())
+	if (in_hardirq())
 		irq_work_tick();
 #endif
 	scheduler_tick();
-- 
2.25.1

