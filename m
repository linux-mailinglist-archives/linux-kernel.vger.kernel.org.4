Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74597455D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjGCHRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCHRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:17:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A35CC;
        Mon,  3 Jul 2023 00:17:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso2510014a91.0;
        Mon, 03 Jul 2023 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688368632; x=1690960632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3Enva+kpSAh7J7zWVKEgVuWagbPlUEDjh6vpwFm8Qw=;
        b=mFYhq6nvqCmn3YD3p47/y5FcGh5RRbWC8X+vXRIOhN3lJRumHSFCF9t405TkT2R2mi
         CiG28lziNtnLeFYfgbu3XlobCn/yEL38fSJ3iYo7j/haUbZ8F/d5SKPlQQ2vjl2rkGBw
         1FOCeDgWIHVQdftbBB35Lqc6OU1ulZri8cc31oCRCFBn1nXDYAAnJGQukAAHOv+hQihb
         dttdPyuAt0oiAfGwdbOt+5nHipA5aSevTPHJl9rHCUUUgUQW0pdfe1lu7GHDUzhh+zZu
         zWkHbSgQPACBwjj3S5kyypC2wyOJIWgrAKVloDfump/Q/sQuSla3fkAvV+I8aij9McSw
         FJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688368632; x=1690960632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3Enva+kpSAh7J7zWVKEgVuWagbPlUEDjh6vpwFm8Qw=;
        b=kgWpi2/HD9wtd6jZapyjePtpuNC+YVQ2W48/GRIbPAkl9aqhJYexfFdK5sayuSNt3Y
         G34byseJ3+CsuG9ktEt3HJJhHHBym1z1k9wYK2RKxJozVVckxvy/LTnABqKpVFDtspGH
         EWAYydc4PCKzjDWG69/MlKUWnaKssyENyJeI9Zb11qIw355glYhrghnJPVRDdku8yjwX
         ZwAJAVxkwXjVwUPkHkjSmdLzSXddxvQVdP5vYPHYXpVq8YOc0egYnDo9cfoXwfZbVYhz
         rHq1jTZZ28czj21VTPp7MhxCjC6UJXKxQOi3wgtqtoGZz9pkYQkIvJO8YRhQGlVSfcX5
         /a0A==
X-Gm-Message-State: ABy/qLY9hZ528qJBTGjtfJq2e7CWJti/PCEoRGdPxw2/zis7j+Hgkipf
        CDBoiqxMiLmTrH9hK5ytp7GzrY4oF7wA5Q==
X-Google-Smtp-Source: APBJJlHzxPw10D3waPBbWfVVxWU9jwHoIKg542XPuKfqp7GmZCZh1hbw326mOVAFWd+xOgtfUaptPQ==
X-Received: by 2002:a17:90b:3b8a:b0:261:219b:13b3 with SMTP id pc10-20020a17090b3b8a00b00261219b13b3mr14102946pjb.16.1688368632103;
        Mon, 03 Jul 2023 00:17:12 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.googlemail.com with ESMTPSA id x30-20020a17090a6c2100b0026358dfd2a3sm7012630pjj.24.2023.07.03.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 00:17:11 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Ze Gao <zegao2021@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Ze Gao <zegao@tencent.com>, Yafang <laoar.shao@gmail.com>
Subject: [PATCH] fprobe: add unlock to match a succeeded ftrace_test_recursion_trylock
Date:   Mon,  3 Jul 2023 15:16:40 +0800
Message-Id: <20230703071640.106204-1-zegao@tencent.com>
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

Fixes: 3cc4e2c5fbae ("fprobe: make fprobe_kprobe_handler recursion free")
Reported-by: Yafang <laoar.shao@gmail.com>
Closes: https://lore.kernel.org/linux-trace-kernel/CALOAHbC6UpfFOOibdDiC7xFc5YFUgZnk3MZ=3Ny6we=AcrNbew@mail.gmail.com/
Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/fprobe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 18d36842faf5..93b3e361bb97 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -102,12 +102,14 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 
 	if (unlikely(kprobe_running())) {
 		fp->nmissed++;
-		return;
+		goto recursion_unlock;
 	}
 
 	kprobe_busy_begin();
 	__fprobe_handler(ip, parent_ip, ops, fregs);
 	kprobe_busy_end();
+
+recursion_unlock:
 	ftrace_test_recursion_unlock(bit);
 }
 
-- 
2.40.1

