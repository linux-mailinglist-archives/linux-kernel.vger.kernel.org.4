Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF05B70157D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbjEMJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEMJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:06:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A4527A;
        Sat, 13 May 2023 02:06:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643aad3bc41so10111034b3a.0;
        Sat, 13 May 2023 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683968797; x=1686560797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHUxgE5ue7JMe+Nf+qn19ijZt00ZmZK/FLyVzzo0+kI=;
        b=fL0X73L0z0cDS0zzMyUyLw30hurpYzUmAU2mdpkb5BAZ1JqFtJ20sP++/oGihohViC
         I920md0zcNQ5pnBAWpvEs3YHjJ2Vd6I5JKMIf9qG6MR18ejL6YWZN7Cj3vn8xEtdqMmJ
         GJvfy8ZRIVLOowF3iTtmDfUC7DGwe7v0KJCM/bgbv7TOCsy9mTIh3lUKddw1Q5D0tmWM
         XmDS/IQe4mqgKgoNVWdQfWV8Yo0hkVjZAvrI+xGXltW776d1mCJvJvg73kPdg2tFgCwt
         YopiD9n6WSgoiFthYWURa44tXXFz+21zJjSHkGXp6bknt0yhqdYmr7ghENjUt2XWqrBI
         UeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683968797; x=1686560797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHUxgE5ue7JMe+Nf+qn19ijZt00ZmZK/FLyVzzo0+kI=;
        b=MucClyW4v+breYRF3COG87PGC2CEwcmEa7uZp6KdRMeItbWHGCecEhvbWx4TnUEwC4
         OQOMMva+71815pepvM55hse2+ziSznfrQwL6HSJk79E/sApeH9XpDyH9kKNVWRYjzB5g
         q67EdAO+JJuZvUfw7YV8UKIwEexXf8OF1x9piqKJt05uovMOO3NwEI6TyyJo3zLRgHtl
         er/h50F8UI3YJY3DvhEBbnMw4Yp2Vo18xlRWtUILQau34M+Xughyl7gdZjn6tNkNQ7q4
         /SwMOle6gw4mSdxyScb0+CHVVrOsTzUn/f2A3jy0gxJgoSrQOMqm75JHtu65mJZqeiNV
         s1FQ==
X-Gm-Message-State: AC+VfDyBS+S3wys+OHv1N4fz3Qxf61SOTfGBHFjZfFYZRwYLbqd5nBJy
        sSny1xYiKMf2pTvsqNoDWk0=
X-Google-Smtp-Source: ACHHUZ6Gd26eUNxOkI/AgQNmZxXwkAcvliCN1sDKofh/wV3wHLWPCX3xWK0k4XLHdylf5tlo7UWXVw==
X-Received: by 2002:a05:6a00:2e05:b0:63e:6b8a:7975 with SMTP id fc5-20020a056a002e0500b0063e6b8a7975mr33876328pfb.9.1683968797071;
        Sat, 13 May 2023 02:06:37 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.116])
        by smtp.googlemail.com with ESMTPSA id c25-20020a62e819000000b0063f172b1c47sm2057652pfi.35.2023.05.13.02.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 02:06:36 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] kprobe: use preempt_{disable, enable}_notrace in kprobe_busy_{begin, end}
Date:   Sat, 13 May 2023 17:05:48 +0800
Message-Id: <20230513090548.376522-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing preempt_{disable, enable} with its corresponding notrace
version in kprobe_busy_{begin, end} because they are called by
fprobe_kprobe_handler. Such changes would resolve the potential
stack recursion or overflow problem introduced by preempt_count
_{add, sub} when these functions themselves accidentally traced
by fprobe+rethook, and does not break the original semantics.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 00e177de91cc..94d01b5d0646 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1242,7 +1242,7 @@ void kprobe_busy_begin(void)
 {
 	struct kprobe_ctlblk *kcb;
 
-	preempt_disable();
+	preempt_disable_notrace();
 	__this_cpu_write(current_kprobe, &kprobe_busy);
 	kcb = get_kprobe_ctlblk();
 	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
@@ -1251,7 +1251,7 @@ void kprobe_busy_begin(void)
 void kprobe_busy_end(void)
 {
 	__this_cpu_write(current_kprobe, NULL);
-	preempt_enable();
+	preempt_enable_notrace();
 }
 
 /* Add the new probe to 'ap->list'. */
-- 
2.40.1

