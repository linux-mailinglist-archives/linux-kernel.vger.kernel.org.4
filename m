Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D136AB149
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCEPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCEPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:55:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFFD19F39;
        Sun,  5 Mar 2023 07:55:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ay14so25317250edb.11;
        Sun, 05 Mar 2023 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678031749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8efU/42N5gltZQk9HUJR704uG5rbg0MZA6h5sgKkspk=;
        b=G1aqdxTn+71VdNR8g3O0QASFb740IvcBNC4ST3Jou9cGg/z97S13p9sI0oUOmLEe3m
         0aFxvabdCR0ryI5VU+IUzuxCG6+S4cFNG0GkhH83Y8yjGJwu0QVipw1ok6Zdfu7m7rdf
         fcfbW0+V/NQW+MtVOzHOd+8bzxvcDF+muxckewlR8h8ZhO9D1OLUN+dKb+1sIFtmcfcC
         kPrMMGuacmYJM55clnmBi3LkuYAH+ZR6iKqDl3NojSduLsIkBaV7QLgSJUMjiCGCno5d
         QGax4nwIQOb8Kk2xbkIufmvLJ3S6yU0gWKk4V62cAMg5JbfR9JVpvY2Zf4SdQcukbtoi
         fOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678031749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8efU/42N5gltZQk9HUJR704uG5rbg0MZA6h5sgKkspk=;
        b=rqoN5aQLAp5b/4j0lPKOLXWbLhwfWAqlcbIJPy3v9MeJ0gXzTRYC9eA6E5AiSh+lZM
         X0OK9sibKugIVI/6m/KHCd41MkXvxH54yPKVSXTxe4M7cU3GF4sJg4ywYlrwG8ZeybVf
         ATNeYwG1OWdWNaswEpG/K0yJtQxKuD5bqzgi5T4GgfuzR1XEQ8EmAoyE4wfjt81bT8Tt
         SMgLVtg8i273hOz5xsMzqaMt9dRfADJ0kiqoY6nYLTIUSgG/KNWXBlWWEcIKN0p7o89M
         r0DYAkXnVTd0se+bBdapoIbMc77roLQjh3zXiEPrM53n8yACElDIHJ4rfGC9RqG5GEyg
         aOXw==
X-Gm-Message-State: AO0yUKW1BWfTeRacIvJlcKlJvuXWLpxbDLq9XAh8wBCBvjMBR3Chkb08
        w/+EFMwdIsaGTfck8w/AaZ1SXasOTs9Kbg==
X-Google-Smtp-Source: AK7set9MXyGVFBx6g8kl4j1E+zlIjF4HWzjZB7zVejJFNaWTSx1XuSmsdxuSyVNhEVGdwk54z3g6ZA==
X-Received: by 2002:a17:906:7c4a:b0:8b2:abcc:8d9e with SMTP id g10-20020a1709067c4a00b008b2abcc8d9emr7989347ejp.26.1678031749089;
        Sun, 05 Mar 2023 07:55:49 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id pv16-20020a170907209000b009079442dd11sm3357332ejb.154.2023.03.05.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 07:55:48 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v4 1/3] ring_buffer: Change some static functions to void
Date:   Sun,  5 Mar 2023 16:55:30 +0100
Message-Id: <20230305155532.5549-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305155532.5549-1-ubizjak@gmail.com>
References: <20230305155532.5549-1-ubizjak@gmail.com>
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

The results of some static functions are not used. Change the
type of these function to void and remove unnecessary returns.

No functional change intended.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/trace/ring_buffer.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af50d931b020..05fdc92554df 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1569,15 +1569,12 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 }
 
-static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
+static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 			  struct buffer_page *bpage)
 {
 	unsigned long val = (unsigned long)bpage;
 
-	if (RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK))
-		return 1;
-
-	return 0;
+	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
 }
 
 /**
@@ -1587,30 +1584,28 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
  */
-static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
+static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *head = rb_list_head(cpu_buffer->pages);
 	struct list_head *tmp;
 
 	if (RB_WARN_ON(cpu_buffer,
 			rb_list_head(rb_list_head(head->next)->prev) != head))
-		return -1;
+		return;
 
 	if (RB_WARN_ON(cpu_buffer,
 			rb_list_head(rb_list_head(head->prev)->next) != head))
-		return -1;
+		return;
 
 	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
 		if (RB_WARN_ON(cpu_buffer,
 				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
-			return -1;
+			return;
 
 		if (RB_WARN_ON(cpu_buffer,
 				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
-			return -1;
+			return;
 	}
-
-	return 0;
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
@@ -4500,7 +4495,6 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 	default:
 		RB_WARN_ON(cpu_buffer, 1);
 	}
-	return;
 }
 
 static void
@@ -4531,7 +4525,6 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 	default:
 		RB_WARN_ON(iter->cpu_buffer, 1);
 	}
-	return;
 }
 
 static struct buffer_page *
@@ -4946,7 +4939,6 @@ rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked)
 {
 	if (likely(locked))
 		raw_spin_unlock(&cpu_buffer->reader_lock);
-	return;
 }
 
 /**
-- 
2.39.2

