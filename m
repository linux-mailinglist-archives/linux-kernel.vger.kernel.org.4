Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9196A8709
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCBQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCBQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:41:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17726B9;
        Thu,  2 Mar 2023 08:41:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o15so67552877edr.13;
        Thu, 02 Mar 2023 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677775314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLrofQCA379uXcxid9S1DouhqkUwWzrSWgzlacbqnto=;
        b=CBFi0q4qOzth7spzkCafCsnejBZ721xr4ZthnIXTkOhnTmnyMd6YUmSfUxL89Vy3HC
         YtXbBLYz+gKvlror5Vywa08LyC5DCv6HyUIqUDT/NU5qf8LGb6RIokAQu3IuKAkPKs4O
         IHo/8G8bsQQQ7wGcy99pcMgjmhWVHmIVqBZqcYwyw2hI16o/twXYVQlLYcPGbhGauemX
         tXmQUPQNW5TbbPel2iTN6Q+hrm205V4mhkStxNg2/qpEqs8NSy+yFmUL1kv8BRrisKIc
         Rbh1rlGyVtjuQl6i0VZaWSKnMn3fMBDPfP7p/06TN6nwFtuMT3Cx9IZTWs1UAbUV1HLx
         At0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677775314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLrofQCA379uXcxid9S1DouhqkUwWzrSWgzlacbqnto=;
        b=BDkp77eAoz4/K+17d/gzHYHC3mF9KwqAc/4YF/caU7Fc3R76G0PALe1EKbrXenvyg1
         m/vFYMwvQglxNa0MC0yBUY0alcrute1nc8dvFLyZto+knfKWw7vBlBAWyZhWH3Opcwns
         DSoCsa1DYHg+k8q9cBSjKhi9mONUP/GQ90C/2K6OnmilA5ynenVsFinoFmtWvakj+icl
         O+5bDGcA+5LW43LBnqF8nG1RqXxdM7P+Jh8gFLUEMi038n0Jd4bYYYfucDiI504rg0Wa
         KV6nIWVCJTQhw5T0c1IxIQI/bLzTh76z3J/HXCWArqEsMjc+p+9T9M6HQmacEfNU9pZz
         W5sQ==
X-Gm-Message-State: AO0yUKWm4JcRl2mM+UxeWEsLjlUQGl2IZbh59Y5bKPHXAMExMv+KB6UM
        vPa+P2QIOxMLg8Fq/vPIMyn6/+vv7deAyg==
X-Google-Smtp-Source: AK7set8YEwFGNVdmj+NqqNvop5WliKHmQ5jLgKHZ0k4uiGQ7ef26y3YYlFF8IExTdDxlue87hxbLLg==
X-Received: by 2002:a17:907:20ef:b0:8ab:b03d:a34f with SMTP id rh15-20020a17090720ef00b008abb03da34fmr2819385ejb.12.1677775314129;
        Thu, 02 Mar 2023 08:41:54 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a22-20020a170906191600b008c327bef167sm7230998eje.7.2023.03.02.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:41:53 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Date:   Thu,  2 Mar 2023 17:41:29 +0100
Message-Id: <20230302164129.4862-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302164129.4862-1-ubizjak@gmail.com>
References: <20230302164129.4862-1-ubizjak@gmail.com>
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change
saves a compare after cmpxchg (and related move instruction in
front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Convert only loops with cmpxchg.
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4188af7d4cfe..9a6ba5824cf2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4061,10 +4061,10 @@ void ring_buffer_record_off(struct trace_buffer *buffer)
 	unsigned int rd;
 	unsigned int new_rd;
 
+	rd = atomic_read(&buffer->record_disabled);
 	do {
-		rd = atomic_read(&buffer->record_disabled);
 		new_rd = rd | RB_BUFFER_OFF;
-	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
+	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
 }
 EXPORT_SYMBOL_GPL(ring_buffer_record_off);
 
@@ -4084,10 +4084,10 @@ void ring_buffer_record_on(struct trace_buffer *buffer)
 	unsigned int rd;
 	unsigned int new_rd;
 
+	rd = atomic_read(&buffer->record_disabled);
 	do {
-		rd = atomic_read(&buffer->record_disabled);
 		new_rd = rd & ~RB_BUFFER_OFF;
-	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
+	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
 }
 EXPORT_SYMBOL_GPL(ring_buffer_record_on);
 
-- 
2.39.2

