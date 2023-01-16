Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A766CB60
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjAPROg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjAPRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:13:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FAB4B759
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:53:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ss4so62192799ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3gL+vo2nZmaFGXvjiyowbCSgFOPmttF0YcJ6ksoAuA=;
        b=b3vWesy3yIjbd7kfnRDBv7O4TQTs9bjG225BOHTPHukn2haXOrIs6YdnRG6umF7oVd
         SB/gLzXe9Y43xtiRGEwapaadKT/yLns5dnogdox+NEkw81qclMZGr0zOdaHdqm0zACU/
         nFAc+RgHUWwatXJSDIiPHgMuDGZbuckw8XMHBHaO3422Oo3JQa+5U3Mpihk9Ftf5ZBIa
         9YjUsozQryMT8f2gO+HWSHcXRr6wBEUIiO1PMxMZyrxupubK7uCh5yNWiFPN/E5z6Sz8
         tx/xcwMDG2IN38L14OYKcNhkwwfS0AwCkGtXU7rT7mkB8zVWuNZ7uxlNvQO7g057ARJV
         tqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3gL+vo2nZmaFGXvjiyowbCSgFOPmttF0YcJ6ksoAuA=;
        b=e0WILYlFZBTuOhWQlQmnXD0qH8LkDqW3Y/e3ZaJe4USKC2xJON+OzhTw0vU7HcDozs
         dwll9q5FOHMOL6ZsI3xl+5kTpUpuX10Npsdi7X/kL0QrzMQq11ze7lANxmorlWM7AcMF
         gNebXO8ebzqTtsu5ZmMPTXC/Ou6GsUL6SGzOv3zoETuLYipT9UfCwMzwb0q+a64shggN
         H4LyT8uHQy29FIAYh61wnwvj3jITDTiu8dPxa1O0DTWXhw7aSa2uGFY5swp9ZpsiqQTR
         t4AasUDE5fEGdaHfaudHdnF2O3TQdiIbk3riW6czeAthp2bHMduPHqRFPsQqpzw9npJi
         FeMA==
X-Gm-Message-State: AFqh2kpHI6aRycRo9+tX7xPsfQzP5ffmNJdUOvwzJoK2HTYnIFFzcVQn
        eIEH1Tnkl0Z3wEt0VLT4Irl3rEAjf8icIw==
X-Google-Smtp-Source: AMrXdXum1Bwh3I00Nbb/8scZeAlFOnU5KqM+bC5zHR1QHXP+mgXWBkqimqNz+jBx/jZU7ePYDjDlPQ==
X-Received: by 2002:a17:906:7c3:b0:85a:4230:756c with SMTP id m3-20020a17090607c300b0085a4230756cmr26101249ejc.59.1673888025936;
        Mon, 16 Jan 2023 08:53:45 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906308100b007a8de84ce36sm11956785ejv.206.2023.01.16.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:53:45 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] posix-timers: use atomic64_try_cmpxchg in __update_gt_cputime
Date:   Mon, 16 Jan 2023 17:53:37 +0100
Message-Id: <20230116165337.5810-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use atomic64_try_cmpxchg instead of atomic64_cmpxchg (*ptr, old, new) == old
in __update_gt_cputime.  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

Also, atomic64_try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails.  There is no need to re-read the value in the loop.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index cb925e8ef9a8..2f5e9b34022c 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -243,13 +243,12 @@ static void proc_sample_cputime_atomic(struct task_cputime_atomic *at,
  */
 static inline void __update_gt_cputime(atomic64_t *cputime, u64 sum_cputime)
 {
-	u64 curr_cputime;
-retry:
-	curr_cputime = atomic64_read(cputime);
-	if (sum_cputime > curr_cputime) {
-		if (atomic64_cmpxchg(cputime, curr_cputime, sum_cputime) != curr_cputime)
-			goto retry;
-	}
+	u64 curr_cputime = atomic64_read(cputime);
+
+	do {
+		if (sum_cputime <= curr_cputime)
+			return;
+	} while (!atomic64_try_cmpxchg(cputime, &curr_cputime, sum_cputime));
 }
 
 static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
-- 
2.39.0

